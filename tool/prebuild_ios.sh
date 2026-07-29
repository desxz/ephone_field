#!/usr/bin/env bash
# Maintainer helper: document / eventually produce prebuilt iOS native artifacts.
#
# Goal (Phase 2): consumers must not run CMake + FetchContent at `pod install`.
# This script is a stub — fill in once CI produces `libephone_phonenumber_stack-*.a`
# or an xcframework checked into `ios/prebuilt/` or GitHub Releases.
#
# Usage (future):
#   ./tool/prebuild_ios.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "ephone_field Phase 2 prebuild is not automated yet."
echo "See $ROOT/docs/ARCHITECTURE.md for the target layout:"
echo "  - Build ios/cmake_build.sh output per arch on CI"
echo "  - Publish xcframework / static libs"
echo "  - Point ephone_field.podspec at prebuilt libs (no script_phases compile)"
exit 1
