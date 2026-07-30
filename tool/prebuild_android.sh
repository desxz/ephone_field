#!/usr/bin/env bash
# Maintainer helper: build Android shared libs into jniLibs for consumer installs
# that skip CMake (see android/build.gradle).
#
# Requires: Android SDK + NDK, CMake (SDK cmake preferred), network on first
# FetchContent populate.
#
# Usage:
#   ./tool/prebuild_android.sh
#   ABIS="arm64-v8a x86_64" ./tool/prebuild_android.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="${ROOT}/src"
JNI_DIR="${ROOT}/android/src/main/jniLibs"
ABIS="${ABIS:-arm64-v8a armeabi-v7a x86_64}"
ANDROID_SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-${HOME}/Library/Android/sdk}}"

if [[ ! -d "${ANDROID_SDK}" ]]; then
  echo "Android SDK not found (set ANDROID_HOME). Looked at: ${ANDROID_SDK}" >&2
  exit 1
fi

NDK_DIR="${ANDROID_NDK_HOME:-}"
if [[ -z "${NDK_DIR}" || ! -d "${NDK_DIR}" ]]; then
  NDK_DIR="$(ls -d "${ANDROID_SDK}"/ndk/* 2>/dev/null | sort -V | tail -1 || true)"
fi
if [[ -z "${NDK_DIR}" || ! -d "${NDK_DIR}" ]]; then
  echo "Android NDK not found under ${ANDROID_SDK}/ndk" >&2
  exit 1
fi

CMAKE_BIN="${CMAKE_BIN:-}"
if [[ -z "${CMAKE_BIN}" ]]; then
  for candidate in \
    "${ANDROID_SDK}/cmake/3.22.1/bin/cmake" \
    "${ANDROID_SDK}/cmake/"*/bin/cmake \
    "/opt/homebrew/bin/cmake" \
    "/usr/local/bin/cmake"
  do
    # Expand globs safely
    for path in ${candidate}; do
      if [[ -x "${path}" ]]; then
        CMAKE_BIN="${path}"
        break 2
      fi
    done
  done
fi
if [[ -z "${CMAKE_BIN}" ]]; then
  CMAKE_BIN="$(command -v cmake || true)"
fi
if [[ -z "${CMAKE_BIN}" ]]; then
  echo "cmake not found" >&2
  exit 1
fi

NINJA_BIN="$(dirname "${CMAKE_BIN}")/ninja"
GENERATOR=()
if [[ -x "${NINJA_BIN}" ]]; then
  GENERATOR=(-G Ninja "-DCMAKE_MAKE_PROGRAM=${NINJA_BIN}")
elif command -v ninja >/dev/null 2>&1; then
  GENERATOR=(-G Ninja)
else
  echo "ninja not found; using default CMake generator"
fi

JOBS="$(sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4)"
TOOLCHAIN="${NDK_DIR}/build/cmake/android.toolchain.cmake"

echo "NDK: ${NDK_DIR}"
echo "CMake: ${CMAKE_BIN}"
echo "ABIs: ${ABIS}"

for abi in ${ABIS}; do
  build_dir="${ROOT}/android/.cxx/prebuild-${abi}"
  echo
  echo "=== Building ${abi} → ${JNI_DIR}/${abi} ==="
  rm -rf "${build_dir}"
  mkdir -p "${build_dir}"
  "${CMAKE_BIN}" \
    "${GENERATOR[@]}" \
    -S "${SRC_DIR}" \
    -B "${build_dir}" \
    -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN}" \
    -DANDROID_ABI="${abi}" \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_STL=c++_static \
    -DCMAKE_BUILD_TYPE=Release \
    -DEPHONE_BUILD_SHARED_PLUGIN=ON
  "${CMAKE_BIN}" --build "${build_dir}" --config Release -j "${JOBS}"

  so_path="$(find "${build_dir}" -name 'libephone_field.so' -print -quit)"
  if [[ -z "${so_path}" || ! -f "${so_path}" ]]; then
    echo "Missing libephone_field.so under ${build_dir}" >&2
    exit 1
  fi
  mkdir -p "${JNI_DIR}/${abi}"
  cp -f "${so_path}" "${JNI_DIR}/${abi}/libephone_field.so"

  # Strip debug symbols so shipped .so match iOS stack footprint (~2 MB/abi).
  STRIP_BIN="$(find "${NDK_DIR}/toolchains/llvm/prebuilt" -name llvm-strip 2>/dev/null | head -1 || true)"
  if [[ -n "${STRIP_BIN}" ]]; then
    STRIP_BIN="$(python3 -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "${STRIP_BIN}")"
    "${STRIP_BIN}" --strip-unneeded "${JNI_DIR}/${abi}/libephone_field.so"
  elif command -v llvm-strip >/dev/null 2>&1; then
    llvm-strip --strip-unneeded "${JNI_DIR}/${abi}/libephone_field.so"
  fi

  echo "Installed ${JNI_DIR}/${abi}/libephone_field.so ($(wc -c < "${JNI_DIR}/${abi}/libephone_field.so") bytes)"
done

echo
echo "Consumer Android builds use jniLibs when arm64-v8a/libephone_field.so is present."
