#!/usr/bin/env bash
# Build and install the debug APK on a Quest from WSL.
#
# Gradle's own `installDebug` uses the Linux `adb`, which cannot see a headset
# that is attached to Windows over USB. This script builds with Gradle and then
# deploys with the Windows `adb.exe` instead.
#
# This only builds and installs. The runtime port forward (adb reverse) is a
# separate concern; run ./run-setup.sh for that.
#
# Usage: ./install-wsl.sh   (run from the android/ directory)
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v adb.exe >/dev/null 2>&1; then
    echo "adb.exe not found on PATH. Install Windows platform-tools and expose adb.exe to WSL." >&2
    exit 1
fi

APK="app/build/outputs/apk/debug/app-debug.apk"

echo "==> Building debug APK"
./gradlew assembleDebug

echo "==> Installing $APK via adb.exe"
# adb.exe reads Windows paths reliably; copy the APK to a Windows temp dir first.
WIN_TMP="$(wslpath "$(cmd.exe /c 'echo %TEMP%' 2>/dev/null | tr -d '\r')")/squeakxrnative-debug.apk"
cp "$APK" "$WIN_TMP"
adb.exe install -r "$(wslpath -w "$WIN_TMP")"
rm -f "$WIN_TMP"

echo "==> Done. To serve images at runtime, set up the port forward with ./run-setup.sh"
