#!/usr/bin/env bash
# Maintainer helper: build iOS static stacks into ios/prebuilt/ for consumer installs
# that skip CMake (see ios/ephone_field.podspec + ios/cmake_build.sh).
#
# Requires: cmake, Xcode CLT, network on first FetchContent populate.
#
# Usage:
#   ./tool/prebuild_ios.sh
#   PLATFORM_NAME=iphoneos ARCHS=arm64 ./tool/prebuild_ios.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IOS_DIR="${ROOT}/ios"
PREBUILT_DIR="${IOS_DIR}/prebuilt"
mkdir -p "${PREBUILT_DIR}"

export PLATFORM_NAME="${PLATFORM_NAME:-iphonesimulator}"
export ARCHS="${ARCHS:-arm64}"
export CONFIGURATION="${CONFIGURATION:-Release}"
export IPHONEOS_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET:-12.0}"

echo "Building ${PLATFORM_NAME} (${ARCHS}) → ${PREBUILT_DIR}"
chmod +x "${IOS_DIR}/cmake_build.sh"
"${IOS_DIR}/cmake_build.sh"

SRC_LIB="${IOS_DIR}/build/libephone_phonenumber_stack-${PLATFORM_NAME}.a"
if [[ ! -f "${SRC_LIB}" ]]; then
  echo "Missing built archive: ${SRC_LIB}" >&2
  exit 1
fi

DEST_LIB="${PREBUILT_DIR}/libephone_phonenumber_stack-${PLATFORM_NAME}.a"
cp -f "${SRC_LIB}" "${DEST_LIB}"
echo "Installed ${DEST_LIB} ($(wc -c < "${DEST_LIB}") bytes)"
echo
echo "Consumer builds use ios/prebuilt when present (no CMake at pod install)."
echo "Commit prebuilt archives only after CI size/review (large binaries)."
