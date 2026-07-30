#!/usr/bin/env bash
# Maintainer helper: build iOS static stacks into ios/prebuilt/ for consumer installs
# that skip CMake (see ios/ephone_field.podspec + ios/cmake_build.sh).
#
# Requires: cmake, Xcode CLT, network on first FetchContent populate.
#
# Usage:
#   ./tool/prebuild_ios.sh                         # default: iphonesimulator arm64
#   PLATFORM_NAME=iphoneos ARCHS=arm64 ./tool/prebuild_ios.sh
#   ./tool/prebuild_ios.sh --all                   # device + simulator arm64
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IOS_DIR="${ROOT}/ios"
PREBUILT_DIR="${IOS_DIR}/prebuilt"
mkdir -p "${PREBUILT_DIR}"

build_one() {
  local platform="$1"
  local archs="$2"
  echo "Building ${platform} (${archs}) → ${PREBUILT_DIR}"
  export PLATFORM_NAME="${platform}"
  export ARCHS="${archs}"
  export CONFIGURATION="${CONFIGURATION:-Release}"
  export IPHONEOS_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET:-12.0}"
  # Always compile from source when producing prebuilts.
  export EPHONE_FORCE_CMAKE=1
  chmod +x "${IOS_DIR}/cmake_build.sh"
  "${IOS_DIR}/cmake_build.sh"

  local src_lib="${IOS_DIR}/build/libephone_phonenumber_stack-${platform}.a"
  if [[ ! -f "${src_lib}" ]]; then
    echo "Missing built archive: ${src_lib}" >&2
    exit 1
  fi
  local dest_lib="${PREBUILT_DIR}/libephone_phonenumber_stack-${platform}.a"
  cp -f "${src_lib}" "${dest_lib}"
  echo "Installed ${dest_lib} ($(wc -c < "${dest_lib}") bytes)"
}

if [[ "${1:-}" == "--all" ]]; then
  build_one iphoneos arm64
  build_one iphonesimulator arm64
else
  build_one "${PLATFORM_NAME:-iphonesimulator}" "${ARCHS:-arm64}"
fi

echo
echo "Consumer builds use ios/prebuilt when present (no CMake at pod install)."
