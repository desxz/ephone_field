#!/usr/bin/env bash
# Builds and merges a fat static archive for the iOS CocoaPods target.
# Builds every arch in $ARCHS and lipo-creates a universal OUT_LIB.
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

# Normalize Xcode config names (Debug/Release).
case "${CONFIGURATION}" in
  Debug|debug) CONFIGURATION=Debug ;;
  *) CONFIGURATION=Release ;;
esac

OUT_LIB="${SCRIPT_DIR}/build/libephone_phonenumber_stack-${PLATFORM_NAME}.a"
PREBUILT_LIB="${SCRIPT_DIR}/prebuilt/libephone_phonenumber_stack-${PLATFORM_NAME}.a"
mkdir -p "${SCRIPT_DIR}/build"

# Prefer maintainer-produced archives (tool/prebuild_ios.sh) so consumers skip CMake.
# Set EPHONE_FORCE_CMAKE=1 to rebuild even when a prebuilt exists.
if [[ -f "${PREBUILT_LIB}" && "${EPHONE_FORCE_CMAKE:-0}" != "1" ]]; then
  cp -f "${PREBUILT_LIB}" "${OUT_LIB}"
  echo "ephone_field: using prebuilt ${PREBUILT_LIB} ($(wc -c < "${OUT_LIB}") bytes)"
  exit 0
fi

SDKROOT="$(xcrun --sdk "${SDK}" --show-sdk-path)"
CMAKE_BIN="${CMAKE_BIN:-$(command -v cmake || true)}"
if [[ -z "${CMAKE_BIN}" ]]; then
  for candidate in \
    "/opt/homebrew/bin/cmake" \
    "/usr/local/bin/cmake" \
    "${HOME}/Library/Android/sdk/cmake/3.22.1/bin/cmake"
  do
    if [[ -x "${candidate}" ]]; then
      CMAKE_BIN="${candidate}"
      break
    fi
  done
fi
if [[ -z "${CMAKE_BIN}" ]]; then
  echo "cmake not found; install CMake, set CMAKE_BIN, or place a prebuilt archive in ios/prebuilt/ (see tool/prebuild_ios.sh)" >&2
  exit 1
fi

LIBTOOL="${LIBTOOL:-/usr/bin/libtool}"
LIPO="${LIPO:-/usr/bin/lipo}"
LD="${LD:-$(xcrun --find ld)}"
JOBS="$(sysctl -n hw.ncpu 2>/dev/null || echo 4)"
EXPORTS_LIST="${SCRIPT_DIR}/ephone_exports.txt"
SDK_VERSION="$(xcrun --sdk "${SDK}" --show-sdk-version)"
case "${PLATFORM_NAME}" in
  iphoneos) LD_PLATFORM=ios ;;
  iphonesimulator) LD_PLATFORM=ios-simulator ;;
esac

rm -f "${OUT_LIB}"

SLICE_LIBS=()

# Collapse the merged static archive into one relocatable object and keep only the
# C API globals exported. Abseil/protobuf/RE2/LPN symbols become local so
# -force_load does not collide with other plugins that ship the same deps.
localize_archive() {
  local in_a="$1"
  local out_a="$2"
  local arch="$3"
  local work localized
  work="$(mktemp -d "${TMPDIR:-/tmp}/ephone_localize.XXXXXX")"
  localized="${work}/localized.o"
  "${LD}" -r -arch "${arch}" -syslibroot "${SDKROOT}" \
    -platform_version "${LD_PLATFORM}" "${SDK_VERSION}" "${SDK_VERSION}" \
    -exported_symbols_list "${EXPORTS_LIST}" \
    -all_load "${in_a}" \
    -o "${localized}"
  "${LIBTOOL}" -static -o "${out_a}" "${localized}"
  rm -rf "${work}"
}

# Protobuf (and some other CMake libs) emit both libfoo.a and libfood.a.
# Merging both causes hundreds of duplicate symbols at link time.
select_archives() {
  local build_dir="$1"
  local -a raw=()
  while IFS= read -r archive; do
    raw+=("${archive}")
  done < <(
    find "${build_dir}" -name '*.a' \
      ! -name 'libephone_phonenumber_stack.a' \
      ! -name 'merged_stack.a' \
      ! -name 'libephone_phonenumber_stack-*.a' \
      | sort
  )

  local -a selected=()
  local archive base
  for archive in "${raw[@]}"; do
    base="$(basename "${archive}")"
    if [[ "${CONFIGURATION}" == "Debug" ]]; then
      # Prefer *d.a debug variants; skip the non-d twin when both exist.
      if [[ "${base}" == "libprotobuf-lite.a" ]]; then
        continue
      fi
    else
      if [[ "${base}" == "libprotobuf-lited.a" ]]; then
        continue
      fi
    fi
    selected+=("${archive}")
  done

  if [[ ${#selected[@]} -eq 0 ]]; then
    echo "No dependency archives found under ${build_dir}" >&2
    exit 1
  fi
  printf '%s\n' "${selected[@]}"
}

build_slice() {
  local arch="$1"
  local build_dir="${SCRIPT_DIR}/build/${PLATFORM_NAME}-${arch}"
  mkdir -p "${build_dir}"

  "${CMAKE_BIN}" -S "${SRC_DIR}" -B "${build_dir}" \
    -G "Unix Makefiles" \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_SYSROOT="${SDKROOT}" \
    -DCMAKE_OSX_ARCHITECTURES="${arch}" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="${IPHONEOS_DEPLOYMENT_TARGET}" \
    -DCMAKE_BUILD_TYPE="${CONFIGURATION}" \
    -DEPHONE_BUILD_SHARED_PLUGIN=OFF

  "${CMAKE_BIN}" --build "${build_dir}" --target ephone_phonenumber_stack -j "${JOBS}"

  local stack_obj
  stack_obj="$(find "${build_dir}" -name 'libephone_phonenumber_stack.a' | head -n 1)"
  if [[ -z "${stack_obj}" ]]; then
    echo "libephone_phonenumber_stack.a not found under ${build_dir}" >&2
    exit 1
  fi

  local tmp_merge="${build_dir}/merged_stack.a"
  rm -f "${tmp_merge}"

  local -a archives=()
  while IFS= read -r archive; do
    archives+=("${archive}")
  done < <(select_archives "${build_dir}")

  "${LIBTOOL}" -static -o "${tmp_merge}" "${stack_obj}" "${archives[@]}"

  local slice_out="${SCRIPT_DIR}/build/libephone_phonenumber_stack-${PLATFORM_NAME}-${arch}.a"
  if [[ ! -f "${EXPORTS_LIST}" ]]; then
    echo "Missing exports list: ${EXPORTS_LIST}" >&2
    exit 1
  fi
  localize_archive "${tmp_merge}" "${slice_out}" "${arch}"
  SLICE_LIBS+=("${slice_out}")
  echo "Built slice ${slice_out} ($(wc -c < "${slice_out}") bytes; C API symbols only)"
}

for arch in ${ARCHS}; do
  if [[ "${arch}" == "i386" ]]; then
    continue
  fi
  build_slice "${arch}"
done

if [[ ${#SLICE_LIBS[@]} -eq 0 ]]; then
  echo "No architecture slices were built (ARCHS=${ARCHS})" >&2
  exit 1
fi

if [[ ${#SLICE_LIBS[@]} -eq 1 ]]; then
  cp -f "${SLICE_LIBS[0]}" "${OUT_LIB}"
else
  "${LIPO}" -create "${SLICE_LIBS[@]}" -output "${OUT_LIB}"
fi

echo "Installed ${OUT_LIB} ($(wc -c < "${OUT_LIB}") bytes)"
"${LIPO}" -info "${OUT_LIB}" || true
