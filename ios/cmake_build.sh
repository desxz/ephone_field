#!/usr/bin/env bash
# Builds and merges a fat static archive for the iOS CocoaPods target.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SRC_DIR="${ROOT_DIR}/src"

PLATFORM_NAME="${PLATFORM_NAME:-iphoneos}"
ARCHS="${ARCHS:-arm64}"
CONFIGURATION="${CONFIGURATION:-Release}"
IPHONEOS_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET:-12.0}"

case "${PLATFORM_NAME}" in
  iphoneos) SDK=iphoneos ;;
  iphonesimulator) SDK=iphonesimulator ;;
  *)
    echo "Unsupported PLATFORM_NAME=${PLATFORM_NAME}" >&2
    exit 1
    ;;
esac

# Use the first arch for single-slice builds (Flutter usually builds one at a time).
PRIMARY_ARCH="$(echo "${ARCHS}" | awk '{print $1}')"
BUILD_DIR="${SCRIPT_DIR}/build/${PLATFORM_NAME}-${PRIMARY_ARCH}"
mkdir -p "${BUILD_DIR}"

SDKROOT="$(xcrun --sdk "${SDK}" --show-sdk-path)"
CMAKE_BIN="${CMAKE_BIN:-$(command -v cmake || true)}"
if [[ -z "${CMAKE_BIN}" ]]; then
  CMAKE_BIN="/Users/muratgun/Library/Android/sdk/cmake/3.22.1/bin/cmake"
fi

"${CMAKE_BIN}" -S "${SRC_DIR}" -B "${BUILD_DIR}" \
  -G "Unix Makefiles" \
  -DCMAKE_SYSTEM_NAME=iOS \
  -DCMAKE_OSX_SYSROOT="${SDKROOT}" \
  -DCMAKE_OSX_ARCHITECTURES="${PRIMARY_ARCH}" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET}" \
  -DCMAKE_BUILD_TYPE="${CONFIGURATION}" \
  -DEPHONE_USE_LIBPHONENUMBER=ON \
  -DEPHONE_BUILD_SHARED_PLUGIN=OFF

"${CMAKE_BIN}" --build "${BUILD_DIR}" --target ephone_phonenumber_stack -j "$(sysctl -n hw.ncpu 2>/dev/null || echo 4)"

# Collect static archives that make up the stack (transitive deps are not
# embedded in a STATIC library automatically).
STACK_OBJ="$(find "${BUILD_DIR}" -name 'libephone_phonenumber_stack.a' | head -n 1)"
if [[ -z "${STACK_OBJ}" ]]; then
  echo "libephone_phonenumber_stack.a not found under ${BUILD_DIR}" >&2
  exit 1
fi

ARCHIVES=()
while IFS= read -r archive; do
  ARCHIVES+=("${archive}")
done < <(find "${BUILD_DIR}" -name '*.a' ! -name 'libephone_phonenumber_stack.a' | sort)

OUT_LIB="${SCRIPT_DIR}/build/libephone_phonenumber_stack-${PLATFORM_NAME}.a"
TMP_MERGE="${BUILD_DIR}/merged_stack.a"
rm -f "${TMP_MERGE}"

# libtool can merge multiple .a into one fat archive on Apple platforms.
libtool -static -o "${TMP_MERGE}" "${STACK_OBJ}" "${ARCHIVES[@]}"
cp -f "${TMP_MERGE}" "${OUT_LIB}"
echo "Installed ${OUT_LIB} ($(wc -c < "${OUT_LIB}") bytes)"
