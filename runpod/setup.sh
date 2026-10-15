#!/bin/bash
# One-shot toolchain setup for building this project on a fresh Ubuntu RunPod pod.
# Installs JDK 17 + Android SDK/NDK into /root/android-sdk.
set -e
export DEBIAN_FRONTEND=noninteractive
echo "=== install JDK 17 ==="
apt-get update -qq
apt-get install -y -qq openjdk-17-jdk-headless >/dev/null 2>&1
java -version 2>&1 | head -1

SDK=/root/android-sdk
mkdir -p "$SDK/bin"
echo "=== download android CLI ==="
curl -fsSL --retry 6 -o "$SDK/bin/android" https://dl.google.com/android/cli/latest/linux_x86_64/android
chmod +x "$SDK/bin/android"
echo "=== install SDK components (platform-tools, platform-36, build-tools-36, cmake 3.22.1, ndk 27) ==="
yes | "$SDK/bin/android" --no-metrics --sdk "$SDK" sdk install \
  platform-tools "platforms;android-36" "build-tools;36.0.0" \
  "cmake;3.22.1" "ndk;27.2.12479018"
echo "=== installed packages ==="
"$SDK/bin/android" --no-metrics --sdk "$SDK" sdk list
echo "=== DONE setup ==="
