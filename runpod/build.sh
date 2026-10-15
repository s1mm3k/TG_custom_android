#!/bin/bash
# Build the debug test APK (flavor afat, package org.telegram.messenger.beta -> installs
# alongside stock Telegram). Run from anywhere inside the repo after setup.sh.
set -e
cd "$(dirname "$0")/.."
SDK="${ANDROID_SDK:-/root/android-sdk}"
echo "sdk.dir=$SDK" > local.properties
export ANDROID_HOME="$SDK"
export ANDROID_SDK_ROOT="$SDK"
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(command -v javac))))
echo "JAVA_HOME=$JAVA_HOME"
java -version 2>&1 | head -1
chmod +x gradlew
set +e
echo "=== building :TMessagesProj_App:assembleAfatDebug (log -> /root/build.log) ==="
./gradlew --no-daemon --stacktrace :TMessagesProj_App:assembleAfatDebug > /root/build.log 2>&1
RC=$?
echo "=== gradle exit code: $RC ==="
tail -40 /root/build.log
echo "=== APK outputs ==="
find TMessagesProj_App/build/outputs -name '*.apk' 2>/dev/null | xargs ls -la 2>/dev/null
exit $RC
