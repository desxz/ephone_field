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

Native builds set `EPHONE_USE_LIBPHONENUMBER=ON` by default. Abseil, protobuf-lite,
RE2, and ICU are pulled via CMake `FetchContent` during the first native build
(network required once; then cached in the CMake build directory).
