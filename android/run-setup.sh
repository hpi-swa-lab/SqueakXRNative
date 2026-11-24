#!/usr/bin/env bash
set -e

# On WSL the USB headset is attached to Windows, so the Linux `adb` cannot see it.
# Prefer the Windows `adb.exe` in that case; otherwise use the regular `adb`.
if grep -qi microsoft /proc/version 2>/dev/null && command -v adb.exe >/dev/null 2>&1; then
    ADB=adb.exe
else
    ADB=adb
fi

device=$(adb devices -l | grep -m 1 "\(Quest_\S\+\)" | grep -o "^\S\+")
if [ -z "$device" ]; then
  echo "No compatible device found" 1>&2
  exit -1
fi

"$ADB" reverse tcp:8080 tcp:8080
