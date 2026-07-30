#!/usr/bin/env bash
# Fail if published native prebuilts are missing (CI / pre-publish guard).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MISSING=0

require() {
  local path="$1"
  if [[ ! -f "${ROOT}/${path}" ]]; then
    echo "MISSING: ${path}" >&2
    MISSING=1
  else
    echo "OK: ${path} ($(wc -c < "${ROOT}/${path}") bytes)"
  fi
}

require "ios/prebuilt/libephone_phonenumber_stack-iphoneos.a"
require "ios/prebuilt/libephone_phonenumber_stack-iphonesimulator.a"
require "android/src/main/jniLibs/arm64-v8a/libephone_field.so"
require "android/src/main/jniLibs/armeabi-v7a/libephone_field.so"
require "android/src/main/jniLibs/x86_64/libephone_field.so"

if [[ "${MISSING}" -ne 0 ]]; then
  echo "Run ./tool/prebuild_all.sh before publish." >&2
  exit 1
fi
