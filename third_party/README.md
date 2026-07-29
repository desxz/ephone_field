# Vendored Google libphonenumber (slim)

This package ships a slim Google libphonenumber tree used by the Android/iOS FFI
plugin: `cpp/` sources, pre-generated `.pb.cc` / `.pb.h`, and the `resources/`
files needed to regenerate protobufs.

Pin the version in [`LIBPHONENUMBER_VERSION`](LIBPHONENUMBER_VERSION). To bump:

```bash
chmod +x tool/upgrade_libphonenumber.sh
./tool/upgrade_libphonenumber.sh
```

The upgrade script:

1. Fetches only `cpp/` + `resources/` (not Java/JS)
2. Regenerates protobuf C++ sources with **protoc 25.3** (matches CMake FetchContent)
3. Applies patches under `tool/patches/`

## What the consumer build uses

[`src/CMakeLists.txt`](../src/CMakeLists.txt) compiles the lite/short metadata
objects and core util sources. It does **not** link geocoder/carrier offline
data. Abseil, protobuf-lite, and RE2 come from CMake `FetchContent` (cached after
the first build). ICU is not fetched; digit normalize uses
`tool/patches/libphonenumber-no-icu.patch`.

Large unused trees under `resources/` (for example `metadata/`, `geocoding/`,
`carrier/`) may exist after an upgrade for maintainer convenience; they are
excluded from the pub package via `.pubignore`.

## iOS prebuilts

See [`ios/prebuilt/README.md`](../ios/prebuilt/README.md) and
[`doc/ARCHITECTURE.md`](../doc/ARCHITECTURE.md).
