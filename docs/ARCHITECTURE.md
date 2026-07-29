# Architecture roadmap

Living checklist for making `ephone_field` cleaner, more compact, and safer to
install alongside other Flutter plugins. Prefer small PRs over one mega-change.

## Goals

- Honest platform support (Android/iOS only)
- Consumer installs without fragile native compile when possible
- Minimal collision surface with Abseil/protobuf/RE2 from other plugins
- Slim Dart ceremony (validation, formatters, ports)

## Phase status

| Phase | Status | Notes |
| --- | --- | --- |
| 0 Commits for 0.2.0 DX | Done | Compact API, full-width picker, clearErrorOnChange |
| 1 Install honesty | Done | pubspec Android/iOS only; iOS CI smoke; README + this doc |
| 2 Native install reliability | In progress | ICU removed; prebuild path; iOS `ld -r` keeps only C API globals; CI/Releases prebuilt + collision smoke still open |
| 3 Dart compact structure | Done (pass 1) | Capability flag; formatter merge; session inline; resolver in Validators; FFI dispose |
| 4 Country/assets footprint | Partial | `useFlagImages` emoji option; catalog/mask split still open |
| 5 Test/docs hygiene | Partial | Prefer public API; expand contract tests as Phase 2 lands |

## Phase 2 detail (native)

Current risk: iOS `pod install` may still run CMake + FetchContent and force-load a
static archive (Abseil + protobuf-lite + RE2 + libphonenumber) when no prebuilt
is present.

Done in this pass:

1. Dropped full ICU FetchContent (~22 MB/arch); Nd digit normalize uses a local shim
   (`tool/patches/libphonenumber-no-icu.patch`).
2. Hybrid prebuild: `ios/prebuilt/libephone_phonenumber_stack-*.a` preferred by
   `ios/cmake_build.sh` (no CMake / no network). Produce with `./tool/prebuild_ios.sh`.
3. iOS merge localizes non-C-API symbols via `ld -r -exported_symbols_list`
   ([`ios/ephone_exports.txt`](../ios/ephone_exports.txt)); only `ephone_*` stay global under
   `-force_load`.

Still open:

1. Ship prebuilt archives via CI/Releases (not git-tracked by default).
2. Add iOS link smoke (example app + optional second plugin with protobuf) in CI.
3. Optionally vendor Abseil/protobuf/RE2 to shrink FetchContent at first build.

## Non-goals (for now)

- Pure-Dart phone validation rewrite
- Depending on a third-party libphonenumber Flutter plugin
- Desktop/web native parity
