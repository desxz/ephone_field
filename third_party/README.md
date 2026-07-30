# Vendored Google libphonenumber (slim)

Maintainer-only sources for rebuilding the Android/iOS FFI stacks. Published
packages ship **prebuilt** natives (`ios/prebuilt/*.a`, `android/.../jniLibs`)
and exclude this tree via `.pubignore`.

Pin the version in [`LIBPHONENUMBER_VERSION`](LIBPHONENUMBER_VERSION). To bump:

```bash
chmod +x tool/upgrade_libphonenumber.sh
./tool/upgrade_libphonenumber.sh
./tool/prebuild_all.sh
```

The upgrade script keeps only:

- `cpp/src` (compile sources + pre-generated `.pb.cc`)
- `resources/{phonemetadata,phonenumber}.proto`
- `resources/PhoneNumberMetadata.xml` + `ShortNumberMetadata.xml`

It omits `resources/{metadata,geocoding,carrier,test,timezones}` and `cpp/test`.

Abseil, protobuf-lite, and RE2 still come from CMake `FetchContent` when
maintainers rebuild. ICU is not fetched; digit normalize uses
`tool/patches/libphonenumber-no-icu.patch`.
