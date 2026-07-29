#!/usr/bin/env bash
# Downloads a slim Google libphonenumber snapshot (cpp/ + resources/ only),
# regenerates protobuf C++ sources (protoc 25.3), and applies local patches.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="${ROOT_DIR}/third_party/LIBPHONENUMBER_VERSION"
VERSION="$(tr -d '[:space:]' < "${VERSION_FILE}")"
TARGET="${ROOT_DIR}/third_party/libphonenumber"
PATCH_DIR="${ROOT_DIR}/tool/patches"
PROTOC_VERSION="25.3"
TMP="$(mktemp -d)"
ARCHIVE="${TMP}/libphonenumber.tar.gz"
TAG="v${VERSION}"

cleanup() { rm -rf "${TMP}"; }
trap cleanup EXIT

echo "Fetching google/libphonenumber@${TAG} (cpp + resources only)..."
curl -fsSL \
  "https://github.com/google/libphonenumber/archive/refs/tags/${TAG}.tar.gz" \
  -o "${ARCHIVE}"

mkdir -p "${TMP}/extract"
tar -xzf "${ARCHIVE}" -C "${TMP}/extract"
SRC="${TMP}/extract/libphonenumber-${VERSION}"

rm -rf "${TARGET}"
mkdir -p "${TARGET}"
cp -R "${SRC}/cpp" "${TARGET}/cpp"
cp -R "${SRC}/resources" "${TARGET}/resources"
cp "${SRC}/LICENSE" "${TARGET}/LICENSE"
cp "${SRC}/AUTHORS" "${TARGET}/AUTHORS" 2>/dev/null || true

# Generate .pb.cc/.pb.h with a pinned host protoc matching FetchContent protobuf.
OS="$(uname -s)"
ARCH="$(uname -m)"
case "${OS}-${ARCH}" in
  Darwin-arm64) PROTOC_ZIP="protoc-${PROTOC_VERSION}-osx-aarch_64.zip" ;;
  Darwin-x86_64) PROTOC_ZIP="protoc-${PROTOC_VERSION}-osx-x86_64.zip" ;;
  Linux-x86_64) PROTOC_ZIP="protoc-${PROTOC_VERSION}-linux-x86_64.zip" ;;
  Linux-aarch64) PROTOC_ZIP="protoc-${PROTOC_VERSION}-linux-aarch_64.zip" ;;
  *)
    echo "Unsupported host for protoc download: ${OS}-${ARCH}" >&2
    exit 1
    ;;
esac

echo "Downloading protoc ${PROTOC_VERSION} (${PROTOC_ZIP})..."
curl -fsSL -o "${TMP}/protoc.zip" \
  "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${PROTOC_ZIP}"
unzip -q "${TMP}/protoc.zip" -d "${TMP}/protoc"
PROTOC_BIN="${TMP}/protoc/bin/protoc"
OUT_DIR="${TARGET}/cpp/src/phonenumbers"
"${PROTOC_BIN}" --cpp_out="${OUT_DIR}" --proto_path="${TARGET}/resources" \
  "${TARGET}/resources/phonemetadata.proto" \
  "${TARGET}/resources/phonenumber.proto"

if [[ -d "${PATCH_DIR}" ]]; then
  shopt -s nullglob
  for patch in "${PATCH_DIR}"/*.patch; do
    echo "Applying $(basename "${patch}")..."
    patch -d "${TARGET}" -p1 < "${patch}"
  done
fi

echo "Vendored slim libphonenumber ${VERSION} → third_party/libphonenumber"
echo "Native builds always link Google libphonenumber."
echo "Note: resources/metadata|geocoding|carrier are not linked by the plugin;"
echo "      they are excluded from pub via .pubignore."
