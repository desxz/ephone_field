# Prebuilt iOS native stacks

When `libephone_phonenumber_stack-${PLATFORM_NAME}.a` is present here,
[`ios/cmake_build.sh`](../cmake_build.sh) copies it into `ios/build/` and skips
CMake at pod install. These archives ship in the pub package so consumers need
no extra tools.

Build / refresh with:

```bash
./tool/prebuild_ios.sh --all
# or
./tool/prebuild_all.sh
```

Requires CMake + Xcode (maintainers only). Set `EPHONE_FORCE_CMAKE=1` is
implied by the prebuild scripts.
