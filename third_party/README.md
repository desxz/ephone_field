# Vendored Google libphonenumber (slim)

This package **ships** a slim Google libphonenumber tree (`cpp/` + `resources/` +
pre-generated `.pb.cc` / `.pb.h`) and links it by default on Android/iOS.

Pin the version in [`LIBPHONENUMBER_VERSION`](LIBPHONENUMBER_VERSION). To bump:

```bash
chmod +x tool/upgrade_libphonenumber.sh
./tool/upgrade_libphonenumber.sh
```

The upgrade script:

1. Fetches only `cpp/` + `resources/` (not Java/JS)
2. Regenerates protobuf C++ sources with **protoc 25.3** (matches CMake FetchContent)
3. Applies patches under `tool/patches/`

Native builds always link Google libphonenumber. Abseil, protobuf-lite, and RE2
are pulled via CMake `FetchContent` during the first native build (network
required once; then cached in the CMake build directory). ICU is **not** fetched:
digit normalization uses a local Nd→ASCII shim
(`tool/patches/libphonenumber-no-icu.patch`).

For iOS consumer installs without CMake, place prebuilt stacks under
`ios/prebuilt/` (see `tool/prebuild_ios.sh` and `docs/ARCHITECTURE.md`).
