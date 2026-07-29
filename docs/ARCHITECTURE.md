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
| 2 Native install reliability | Done | ICU removed; prebuild path; C API-only globals; CI FetchContent cache + prebuilt artifact |
| 3 Dart compact structure | Done (pass 1) | Capability flag; formatter merge; session inline; resolver in Validators; FFI dispose |
| 4 Country/assets footprint | Done | Emoji default; PNGs not bundled; `Country` keeps mask/min/max inline |
| 5 Test/docs hygiene | Done | Export assert in CI; public API-oriented tests; architecture doc |

## Phase 2 detail (native)

Done:

1. Dropped full ICU FetchContent; Nd digit normalize uses a local shim
   (`tool/patches/libphonenumber-no-icu.patch`).
2. Hybrid prebuild: `ios/prebuilt/libephone_phonenumber_stack-*.a` preferred by
   `ios/cmake_build.sh`. Produce with `./tool/prebuild_ios.sh`.
3. iOS merge localizes non-C-API symbols via `ld -r -exported_symbols_list`
   ([`ios/ephone_exports.txt`](../ios/ephone_exports.txt)).
4. CI caches FetchContent `_deps` and uploads the simulator prebuilt archive on
   `main` pushes (14-day artifact). Collision surface is covered by the export
   assert rather than a second protobuf plugin fixture.

Deferred (not needed for 0.2.0):

- Vendoring Abseil/protobuf/RE2 into git (large; FetchContent + CI cache is enough).
- Publishing prebuilts to GitHub Releases for tagged versions (artifact upload is
  the first step; Releases can wrap the same files later).

## Non-goals (for now)

- Pure-Dart phone validation rewrite
- Depending on a third-party libphonenumber Flutter plugin
- Desktop/web native parity
