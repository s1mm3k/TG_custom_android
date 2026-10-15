# Cloud build helpers

Scripts to build this fork quickly on a fresh Ubuntu cloud box (e.g. a RunPod pod),
where downloads of the Android SDK/NDK are fast and unthrottled.

## Flow

```bash
# 1. clone this repo (with submodules) onto the box
git clone --branch dev --recurse-submodules https://github.com/s1mm3k/TG_custom_android.git
cd TG_custom_android

# 2. install JDK 17 + Android SDK/NDK (into /root/android-sdk)
bash runpod/setup.sh

# 3a. build the debug test APK (package .beta, installs alongside stock Telegram)
bash runpod/build.sh
#     -> TMessagesProj_App/build/outputs/apk/afat/debug/app.apk

# 3b. or build the release APK (replaces stock Telegram)
bash runpod/build_release.sh
#     -> TMessagesProj_App/build/outputs/apk/afat/release/app.apk
```

`ANDROID_SDK` env var overrides the SDK location (default `/root/android-sdk`).

## Toolchain pinned by setup.sh

JDK 17 · platform-tools · platforms;android-36 · build-tools;36.0.0 · cmake;3.22.1 · ndk;27.2.12479018

## Fork features

Extended control, privacy and convenience changes on top of upstream Telegram for Android:

- Allow saving/forwarding from chats that restrict it
- Privacy ("stealth"): do not broadcast typing, keep status offline, do not send read receipts
- Static (non-animated) stickers
- View stories without appearing in the viewer list or bumping view counts
- Show peer and data-center ID on profiles
- Disable media auto-download (stickers still load)
- Keep messages visible after they are deleted, highlighted
- Show the previous text under an edited message
