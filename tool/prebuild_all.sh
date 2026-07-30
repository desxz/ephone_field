#!/usr/bin/env bash
# Build all shipped native prebuilts (iOS + Android) for zero-friction installs.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
chmod +x \
  "${ROOT}/tool/prebuild_ios.sh" \
  "${ROOT}/tool/prebuild_android.sh" \
  "${ROOT}/tool/assert_prebuilts.sh"

echo "=== iOS (device + simulator arm64) ==="
"${ROOT}/tool/prebuild_ios.sh" --all

echo
echo "=== Android (arm64-v8a, armeabi-v7a, x86_64) ==="
"${ROOT}/tool/prebuild_android.sh"

echo
"${ROOT}/tool/assert_prebuilts.sh"
echo "All prebuilts ready."
