#!/usr/bin/env python3
"""Dev runner: HTTP server + adb reverse + app launcher + log viewer in one TUI.

  r  (re)launch the app          s  stop the app
  c  clear the log               f  follow (jump to end of log)
  h  toggle HTTP request lines   q  quit (stops app, removes reverse, stops server)

The device is polled every second. Whenever it (re)appears and has finished
booting, `adb reverse` is (re)applied. Any adb failure (unplug, reboot, computer
sleep, adb server restart, ...) is treated as if the app had been stopped.
"""

from __future__ import annotations

import argparse
import asyncio
import functools
import http.server
import re
import signal
import subprocess
import sys
import threading
from pathlib import Path

from rich.text import Text
from textual.app import App, ComposeResult
from textual.binding import Binding
from textual.containers import Horizontal
from textual.widgets import Button, Footer, RichLog, Static

SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_PACKAGE = "com.swalab.squeakxrnative"


class AdbError(Exception):
    pass


async def adb(*args: str, timeout: float = 5.0) -> tuple[int, str]:
    """Run an adb command, return (returncode, combined output). Raises AdbError on timeout."""
    try:
        proc = await asyncio.create_subprocess_exec(
            "adb", *args,
            stdin=asyncio.subprocess.DEVNULL,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.STDOUT,
        )
    except FileNotFoundError as e:
        raise AdbError("adb not found on PATH") from e
    try:
        out, _ = await asyncio.wait_for(proc.communicate(), timeout)
    except (asyncio.TimeoutError, asyncio.CancelledError) as e:
        proc.kill()
        await proc.wait()
        if isinstance(e, asyncio.CancelledError):
            raise
        raise AdbError(f"adb {' '.join(args)} timed out") from e
    return proc.returncode, out.decode(errors="replace").strip()


# --------------------------------------------------------------------------- HTTP


def make_http_server(app: "DevApp", directory: Path, bind: str, port: int) -> http.server.ThreadingHTTPServer:
    class Handler(http.server.SimpleHTTPRequestHandler):
        def end_headers(self) -> None:
            # Always serve the current files, never a cached copy.
            self.send_header("Cache-Control", "no-store")
            super().end_headers()

        def log_message(self, format: str, *args) -> None:  # noqa: A002
            try:
                app.call_from_thread(app.log_http, format % args)
            except Exception:
                pass

    handler = functools.partial(Handler, directory=str(directory))
    server = http.server.ThreadingHTTPServer((bind, port), handler)
    server.daemon_threads = True
    return server


# --------------------------------------------------------------------------- TUI

LOGCAT_RE = re.compile(r"^\S+\s+\S+\s+\d+\s+\d+\s+([VDIWEFA])\s")
LEVEL_STYLE = {"V": "dim", "D": "", "I": "green", "W": "yellow", "E": "bold red", "F": "bold white on red", "A": "bold white on red"}


class DevApp(App):
    TITLE = "App runner"
    CSS = """
    #status { height: 1; padding: 0 1; background: $panel; }
    #buttons { height: 3; }
    #buttons Button { margin: 0 1 0 0; min-width: 12; }
    #log { border: round $primary; }
    """
    BINDINGS = [
        Binding("r", "relaunch", "(Re)launch"),
        Binding("s", "stop_app", "Stop app"),
        Binding("c", "clear_log", "Clear"),
        Binding("f", "follow", "Follow"),
        Binding("h", "toggle_http", "HTTP lines"),
        Binding("q", "shutdown", "Quit"),
        Binding("ctrl+c", "shutdown", "Quit", show=False, priority=True),
        Binding("ctrl+q", "shutdown", "Quit", show=False, priority=True),
    ]

    def __init__(self, args: argparse.Namespace, server: http.server.ThreadingHTTPServer | None = None) -> None:
        super().__init__()
        self.args = args
        self.package: str = args.package
        self.component = f"{args.package}/{args.activity}"
        self.port: int = args.port
        self.server = server
        self.server_thread: threading.Thread | None = None

        self.device_ready = False
        self.device_error = ""
        self.reverse_ok = False
        self.app_state = "stopped"  # stopped | starting | running
        self.app_pid: str | None = None
        self.show_http = True

        self.session_task: asyncio.Task | None = None
        self.watch_task: asyncio.Task | None = None
        self.launch_lock = asyncio.Lock()
        self.shutting_down = False
        self.cleaned_up = False
        self.autolaunch_pending = args.launch
        self.autolaunch_task: asyncio.Task | None = None

    # ---- layout

    def compose(self) -> ComposeResult:
        yield Static(id="status")
        with Horizontal(id="buttons"):
            yield Button("(Re)launch", id="relaunch", variant="success")
            yield Button("Stop app", id="stop_app", variant="warning")
            yield Button("Clear log", id="clear_log")
            yield Button("Quit", id="shutdown", variant="error")
        yield RichLog(id="log", max_lines=self.args.max_lines, wrap=True, auto_scroll=True)
        yield Footer()

    async def on_mount(self) -> None:
        self.server_thread = threading.Thread(target=self.server.serve_forever, name="http", daemon=True)
        self.server_thread.start()
        self.info(f"Serving {self.args.dir} at http://{self.args.bind}:{self.port}/")
        loop = asyncio.get_running_loop()
        for sig in (signal.SIGTERM, signal.SIGHUP):
            try:
                loop.add_signal_handler(sig, lambda: self.call_later(self.action_shutdown))
            except (NotImplementedError, RuntimeError):
                pass
        self.watch_task = asyncio.create_task(self.watch_device())
        self.update_status()
        self.query_one(RichLog).focus()

    async def on_button_pressed(self, event: Button.Pressed) -> None:
        await self.run_action(event.button.id)
        self.query_one(RichLog).focus()

    # ---- log output

    def write(self, text: Text) -> None:
        log = self.query_one(RichLog)
        log.write(text, scroll_end=log.is_vertical_scroll_end)

    def info(self, msg: str, style: str = "bold cyan") -> None:
        self.write(Text(f"── {msg}", style=style))

    def error(self, msg: str) -> None:
        self.info(msg, style="bold red")

    def log_http(self, msg: str) -> None:
        if self.show_http:
            self.write(Text(f"[http] {msg}", style="magenta"))

    def log_logcat(self, line: str) -> None:
        m = LOGCAT_RE.match(line)
        style = LEVEL_STYLE.get(m.group(1), "") if m else "dim"
        self.write(Text(line, style=style))

    def update_status(self) -> None:
        t = Text()
        if self.device_ready:
            t.append("● device", style="green")
        else:
            t.append("○ no device", style="red")
            if self.device_error:
                t.append(f" ({self.device_error})", style="dim")
        t.append("   ")
        t.append(f"reverse :{self.port} ", style="")
        t.append("ok" if self.reverse_ok else "—", style="green" if self.reverse_ok else "red")
        t.append("   ")
        t.append(f"http :{self.port} ok", style="green")
        t.append("   app: ")
        style = {"running": "bold green", "starting": "yellow"}.get(self.app_state, "dim")
        t.append(self.app_state + (f" (pid {self.app_pid})" if self.app_pid else ""), style=style)
        self.query_one("#status", Static).update(t)

    # ---- device supervision

    async def check_device(self) -> bool:
        try:
            rc, out = await adb("shell", "getprop", "sys.boot_completed", timeout=4)
        except AdbError as e:
            self.device_error = str(e)
            return False
        if rc == 0 and out.strip() == "1":
            self.device_error = ""
            return True
        last = out.splitlines()[-1] if out else ""
        self.device_error = "booting" if rc == 0 else last.removeprefix("adb: ").removeprefix("error: ")
        return False

    async def ensure_reverse(self, force: bool = False) -> None:
        spec = f"tcp:{self.port}"
        try:
            if not force:
                rc, out = await adb("reverse", "--list", timeout=4)
                if rc == 0 and f"{spec} {spec}" in out:
                    self.reverse_ok = True
                    return
            rc, out = await adb("reverse", spec, spec, timeout=4)
        except AdbError as e:
            rc, out = 1, str(e)
        was_ok = self.reverse_ok
        self.reverse_ok = rc == 0
        if self.reverse_ok and (force or not was_ok):
            self.info(f"adb reverse {spec} -> {spec} set up")
        elif not self.reverse_ok:
            self.error(f"adb reverse failed: {out}")

    async def watch_device(self) -> None:
        tick = 0
        while True:
            ready = await self.check_device()
            if ready and not self.device_ready:
                self.device_ready = True
                self.info("Device connected")
                await self.ensure_reverse(force=True)
                if self.autolaunch_pending:
                    self.autolaunch_pending = False
                    self.autolaunch_task = asyncio.create_task(self.action_relaunch())
            elif not ready and self.device_ready:
                self.device_ready = False
                self.reverse_ok = False
                self.error(f"Device lost ({self.device_error or 'unknown'})")
                await self.end_session()
            elif ready and tick % 5 == 0:
                await self.ensure_reverse()
            tick += 1
            self.update_status()
            await asyncio.sleep(1)

    # ---- app session

    async def pidof(self) -> str | None:
        rc, out = await adb("shell", "pidof", self.package, timeout=4)
        pids = out.split() if rc == 0 else []
        return pids[0] if pids and pids[0].isdigit() else None

    async def end_session(self) -> None:
        task, self.session_task = self.session_task, None
        if task and not task.done():
            task.cancel()
            try:
                await task
            except (asyncio.CancelledError, Exception):
                pass

    async def run_session(self) -> None:
        logcat: asyncio.subprocess.Process | None = None
        try:
            self.app_state, self.app_pid = "starting", None
            self.update_status()
            self.info(f"Launching {self.component}")
            rc, out = await adb("shell", "am", "start", "-S", "-W", self.component, timeout=30)
            if rc != 0 or "Error" in out:
                self.error(f"Launch failed: {out}")
                return

            pid = None
            for _ in range(40):
                pid = await self.pidof()
                if pid:
                    break
                await asyncio.sleep(0.25)
            if not pid:
                self.error("App process not found after launch")
                return

            self.app_state, self.app_pid = "running", pid
            self.update_status()
            self.info(f"App running, pid {pid}")

            logcat = await asyncio.create_subprocess_exec(
                "adb", "logcat", "-v", "threadtime", f"--pid={pid}",
                stdin=asyncio.subprocess.DEVNULL,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.STDOUT,
            )
            reader = asyncio.create_task(self.read_logcat(logcat))
            try:
                while True:
                    await asyncio.sleep(1)
                    if reader.done():
                        self.error("logcat ended unexpectedly; treating app as stopped")
                        break
                    try:
                        current = await self.pidof()
                    except AdbError as e:
                        self.error(f"Lost contact with device ({e}); treating app as stopped")
                        break
                    if current != pid:
                        await asyncio.sleep(0.5)  # let the last lines (e.g. crash traces) arrive
                        self.info("App exited")
                        break
            finally:
                reader.cancel()
        except AdbError as e:
            self.error(f"adb error: {e}")
        finally:
            if logcat and logcat.returncode is None:
                logcat.kill()
                try:
                    await asyncio.wait_for(logcat.wait(), 2)
                except asyncio.TimeoutError:
                    pass
            self.app_state, self.app_pid = "stopped", None
            if not self.shutting_down:
                self.update_status()

    async def read_logcat(self, proc: asyncio.subprocess.Process) -> None:
        assert proc.stdout
        while line := await proc.stdout.readline():
            self.log_logcat(line.decode(errors="replace").rstrip("\r\n"))

    # ---- actions

    async def action_relaunch(self) -> None:
        if self.shutting_down:
            return
        if not self.device_ready:
            self.error("No device ready")
            return
        async with self.launch_lock:
            await self.end_session()
            self.session_task = asyncio.create_task(self.run_session())

    async def action_stop_app(self) -> None:
        async with self.launch_lock:
            await self.end_session()
            if self.device_ready:
                try:
                    await adb("shell", "am", "force-stop", self.package, timeout=5)
                    self.info("App stopped")
                except AdbError as e:
                    self.error(f"force-stop failed: {e}")

    def action_clear_log(self) -> None:
        self.query_one(RichLog).clear()

    def action_follow(self) -> None:
        self.query_one(RichLog).scroll_end(animate=False)

    def action_toggle_http(self) -> None:
        self.show_http = not self.show_http
        self.info(f"HTTP request lines {'shown' if self.show_http else 'hidden'}")

    async def action_shutdown(self) -> None:
        if self.shutting_down:
            return
        self.shutting_down = True
        self.info("Shutting down…", style="bold yellow")
        if self.watch_task:
            self.watch_task.cancel()
        await self.end_session()
        if self.device_ready:
            for cmd in (("shell", "am", "force-stop", self.package),
                        ("reverse", "--remove", f"tcp:{self.port}")):
                try:
                    await adb(*cmd, timeout=4)
                except AdbError:
                    pass
        await asyncio.to_thread(self.stop_server)
        self.cleaned_up = True
        self.exit()

    def stop_server(self) -> None:
        if self.server:
            self.server.shutdown()
            self.server.server_close()
            self.server = None


def sync_cleanup(app: DevApp) -> None:
    """Fallback if the app exited without running action_shutdown (e.g. crash)."""
    for cmd in (["adb", "shell", "am", "force-stop", app.package],
                ["adb", "reverse", "--remove", f"tcp:{app.port}"]):
        try:
            subprocess.run(cmd, timeout=4, capture_output=True)
        except Exception:
            pass
    try:
        app.stop_server()
    except Exception:
        pass


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--dir", type=Path, default=SCRIPT_DIR.parent.parent, help="directory to serve (default: ../.. relative to this script)")
    p.add_argument("--port", type=int, default=8080, help="HTTP / reverse port (default: 8080)")
    p.add_argument("--bind", default="127.0.0.1", help="HTTP bind address (default: 127.0.0.1)")
    p.add_argument("--package", default=DEFAULT_PACKAGE)
    p.add_argument("--activity", default=None, help="activity (default: <package>.MainActivity)")
    p.add_argument("--launch", action="store_true", help="launch the app as soon as the device is ready")
    p.add_argument("--max-lines", type=int, default=20000, help="log scrollback (default: 20000)")
    args = p.parse_args()
    args.activity = args.activity or f"{args.package}.MainActivity"
    args.dir = args.dir.resolve()

    if not args.dir.is_dir():
        sys.exit(f"Directory to serve does not exist: {args.dir}")

    app = DevApp(args)
    try:
        app.server = make_http_server(app, args.dir, args.bind, args.port)
    except OSError as e:
        sys.exit(f"Cannot start HTTP server on {args.bind}:{args.port}: {e}\n"
                 f"(Is another instance still running?)")
    try:
        app.run()
    finally:
        if not app.cleaned_up:
            sync_cleanup(app)


if __name__ == "__main__":
    main()
