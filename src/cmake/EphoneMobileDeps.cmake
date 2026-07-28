# Fetches mobile-native deps for Google libphonenumber (abseil, protobuf-lite, RE2, ICU).
# Pre-generated .pb.cc/.pb.h ship in third_party — host protoc is not required at build time.

include(FetchContent)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
# Subproject FetchContent targets must not emit install(EXPORT) against Abseil.
set(CMAKE_SKIP_INSTALL_RULES ON)

# ---------------------------------------------------------------------------
# Abseil (RE2 + libphonenumber)
# ---------------------------------------------------------------------------
set(ABSL_PROPAGATE_CXX_STD ON CACHE BOOL "" FORCE)
set(ABSL_BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(ABSL_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
  abseil-cpp
  GIT_REPOSITORY https://github.com/abseil/abseil-cpp.git
  GIT_TAG 20240116.2
  GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(abseil-cpp)

# ---------------------------------------------------------------------------
# Protocol Buffers lite (matches checked-in gencode from protoc 25.3)
# ---------------------------------------------------------------------------
set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_CONFORMANCE OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_PROTOC_BINARIES OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_LIBPROTOC OFF CACHE BOOL "" FORCE)
set(protobuf_WITH_ZLIB OFF CACHE BOOL "" FORCE)
set(protobuf_INSTALL OFF CACHE BOOL "" FORCE)
set(protobuf_MSVC_STATIC_RUNTIME OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
  ephone_protobuf
  GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
  GIT_TAG v25.3
  GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(ephone_protobuf)

if(NOT TARGET libprotobuf-lite)
  message(FATAL_ERROR "ephone_field: libprotobuf-lite missing after FetchContent")
endif()

# ---------------------------------------------------------------------------
# RE2
# ---------------------------------------------------------------------------
set(RE2_BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(RE2_USE_ICU OFF CACHE BOOL "" FORCE)
FetchContent_Declare(
  ephone_re2
  GIT_REPOSITORY https://github.com/google/re2.git
  # Prefer a current RE2; local patch adapts StringPiece API for LPN 9.x.
  GIT_TAG 2024-04-01
  GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(ephone_re2)

if(NOT TARGET re2)
  message(FATAL_ERROR "ephone_field: re2 target missing after FetchContent")
endif()

# ---------------------------------------------------------------------------
# ICU — always build a static icuuc+stubdata from source so mobile SDKs that
# lack full unicode/*.h headers (notably iOS) still compile.
# ---------------------------------------------------------------------------
FetchContent_Declare(
  ephone_icu
  GIT_REPOSITORY https://github.com/unicode-org/icu.git
  GIT_TAG release-74-2
  GIT_SHALLOW TRUE
)
FetchContent_GetProperties(ephone_icu)
if(NOT ephone_icu_POPULATED)
  FetchContent_Populate(ephone_icu)
endif()

set(_icu_common "${ephone_icu_SOURCE_DIR}/icu4c/source/common")
set(_icu_stub "${ephone_icu_SOURCE_DIR}/icu4c/source/stubdata")

file(GLOB _icu_common_sources CONFIGURE_DEPENDS "${_icu_common}/*.cpp")
list(APPEND _icu_common_sources "${_icu_stub}/stubdata.cpp")

add_library(ephone_icu STATIC ${_icu_common_sources})
target_include_directories(ephone_icu PUBLIC "${_icu_common}")
target_compile_definitions(ephone_icu
  PUBLIC
    U_COMMON_IMPLEMENTATION
    U_STATIC_IMPLEMENTATION
    U_USING_ICU_NAMESPACE=0
  PRIVATE
    U_ATTRIBUTE_DEPRECATED=
)
# ICU common is large; keep warnings from stopping the plugin build.
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  target_compile_options(ephone_icu PRIVATE -Wno-error -w)
endif()
