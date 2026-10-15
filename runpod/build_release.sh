#!/bin/bash
# Build the release APK (flavor afat, package org.telegram.messenger -> replaces stock
# Telegram), signed with the release.keystore shipped in the repo. Run after setup.sh.
set -e
cd "$(dirname "$0")/.."
SDK="${ANDROID_SDK:-/root/android-sdk}"
echo "sdk.dir=$SDK" > local.properties
export ANDROID_HOME="$SDK"
export ANDROID_SDK_ROOT="$SDK"
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(command -v javac))))
echo "JAVA_HOME=$JAVA_HOME"
chmod +x gradlew
set +e
echo "=== building :TMessagesProj_App:assembleAfatRelease (log -> /root/build_release.log) ==="
./gradlew --no-daemon --stacktrace :TMessagesProj_App:assembleAfatRelease > /root/build_release.log 2>&1
RC=$?
echo "=== gradle exit code: $RC ==="
tail -40 /root/build_release.log
echo "=== APK outputs ==="
find TMessagesProj_App/build/outputs -name '*.apk' 2>/dev/null | xargs ls -la 2>/dev/null
exit $RC
