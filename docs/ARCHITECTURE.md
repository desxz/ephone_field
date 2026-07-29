# Architecture roadmap

Living checklist for making `ephone_field` cleaner, more compact, and safer to
install alongside other Flutter plugins. Prefer small PRs over one mega-change.

## Goals

- Honest platform support (Android/iOS only)
- Consumer installs without fragile native compile when possible
- Minimal collision surface with Abseil/protobuf/RE2/ICU from other plugins
- Slim Dart ceremony (validation, formatters, ports)

## Phase status

| Phase | Status | Notes |
| --- | --- | --- |
| 0 Commits for 0.2.0 DX | Done | Compact API, full-width picker, clearErrorOnChange |
| 1 Install honesty | Done | pubspec Android/iOS only; iOS CI smoke; README + this doc |
| 2 Native install reliability | In progress | Stub path removed; prebuild script scaffold; ICU shrink + prebuilt artifacts still open |
| 3 Dart compact structure | Done (pass 1) | Capability flag; formatter merge; session inline; resolver in Validators; FFI dispose |
| 4 Country/assets footprint | Partial | `useFlagImages` emoji option; catalog/mask split still open |
| 5 Test/docs hygiene | Partial | Prefer public API; expand contract tests as Phase 2 lands |

## Phase 2 detail (native)

Current risk: iOS `pod install` runs CMake + FetchContent and force-loads a large
static archive (Abseil + protobuf-lite + RE2 + ICU + libphonenumber).

Target:

1. Ship prebuilt iOS xcframework / static libs (no CMake at consumer install).
2. Rebuild from source only via maintainer scripts under `tool/`.
3. Shrink or replace full ICU source build.
4. Hide non-C-API symbols; keep [`src/ephone_phonenumber_c.h`](../src/ephone_phonenumber_c.h) as the sole export.
5. Add iOS link smoke (example app + optional second plugin with protobuf) in CI.

## Non-goals (for now)

- Pure-Dart phone validation rewrite
- Depending on a third-party libphonenumber Flutter plugin
- Desktop/web native parity
