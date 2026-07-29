# Optional prebuilt iOS native stacks

When `libephone_phonenumber_stack-${PLATFORM_NAME}.a` is present here,
[`ios/cmake_build.sh`](../cmake_build.sh) copies it into `ios/build/` and skips
CMake at pod install.

Build with:

```bash
./tool/prebuild_ios.sh
PLATFORM_NAME=iphoneos ARCHS=arm64 ./tool/prebuild_ios.sh
```

Archives are gitignored (large binaries). CI may upload the simulator archive as
an artifact; do not commit `.a` files unless deliberately reviewed.
