# The Flutter tooling requires CMake 3.10+. libphonenumber deps need 3.14+.
cmake_minimum_required(VERSION 3.14)

project(ephone_field_library VERSION 0.0.3 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

option(EPHONE_BUILD_SHARED_PLUGIN "Build shared ephone_field library (Android)" ON)

# Production builds always link Google libphonenumber. Offline stub builds were
# removed to keep the native graph single-path and easier to reason about.
set(LIBPHONENUMBER_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../third_party/libphonenumber")
set(LPN_CPP "${LIBPHONENUMBER_ROOT}/cpp")
set(LPN_SRC "${LPN_CPP}/src")

if(NOT EXISTS "${LPN_CPP}/src/phonenumbers/phonenumberutil.cc")
  message(FATAL_ERROR
    "ephone_field: vendored libphonenumber is missing at ${LIBPHONENUMBER_ROOT}. "
    "Run tool/upgrade_libphonenumber.sh")
endif()
if(NOT EXISTS "${LPN_CPP}/src/phonenumbers/phonenumber.pb.cc")
  message(FATAL_ERROR
    "ephone_field: missing pre-generated phonenumber.pb.cc — "
    "regenerate with protoc 25.3 (see tool/upgrade_libphonenumber.sh)")
endif()

include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/EphoneMobileDeps.cmake")

set(LPN_SOURCES
  "${LPN_SRC}/phonenumbers/asyoutypeformatter.cc"
  "${LPN_SRC}/phonenumbers/base/strings/string_piece.cc"
  "${LPN_SRC}/phonenumbers/default_logger.cc"
  "${LPN_SRC}/phonenumbers/logger.cc"
  "${LPN_SRC}/phonenumbers/lite_metadata.cc"
  "${LPN_SRC}/phonenumbers/phonemetadata.pb.cc"
  "${LPN_SRC}/phonenumbers/phonenumber.cc"
  "${LPN_SRC}/phonenumbers/phonenumber.pb.cc"
  "${LPN_SRC}/phonenumbers/phonenumberutil.cc"
  "${LPN_SRC}/phonenumbers/regex_based_matcher.cc"
  "${LPN_SRC}/phonenumbers/regexp_adapter_re2.cc"
  "${LPN_SRC}/phonenumbers/regexp_cache.cc"
  "${LPN_SRC}/phonenumbers/short_metadata.cc"
  "${LPN_SRC}/phonenumbers/shortnumberinfo.cc"
  "${LPN_SRC}/phonenumbers/stringutil.cc"
  "${LPN_SRC}/phonenumbers/unicodestring.cc"
  "${LPN_SRC}/phonenumbers/utf/rune.c"
  "${LPN_SRC}/phonenumbers/utf/unicodetext.cc"
  "${LPN_SRC}/phonenumbers/utf/unilib.cc"
)

add_library(ephone_phonenumber STATIC ${LPN_SOURCES})
target_include_directories(ephone_phonenumber PUBLIC "${LPN_SRC}")
target_compile_definitions(ephone_phonenumber
  PUBLIC
    I18N_PHONENUMBERS_USE_RE2
    I18N_PHONENUMBERS_USE_STDMUTEX
)
target_link_libraries(ephone_phonenumber
  PUBLIC
    libprotobuf-lite
    re2
    absl::strings
    absl::node_hash_set
    absl::synchronization
)
set_target_properties(ephone_phonenumber PROPERTIES
  CXX_VISIBILITY_PRESET hidden
  C_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN ON
)
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  target_compile_options(ephone_phonenumber PRIVATE -Wno-error)
endif()

# Static stack (C API + LPN) for CocoaPods force_load on iOS.
add_library(ephone_phonenumber_stack STATIC ephone_phonenumber_c.cc)
target_include_directories(ephone_phonenumber_stack PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(ephone_phonenumber_stack
  PUBLIC DART_SHARED_LIB
  PRIVATE EPHONE_HAS_LIBPHONENUMBER=1
)
target_link_libraries(ephone_phonenumber_stack PUBLIC ephone_phonenumber)
set_target_properties(ephone_phonenumber_stack PROPERTIES
  CXX_VISIBILITY_PRESET hidden
  C_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN ON
)

if(EPHONE_BUILD_SHARED_PLUGIN)
  add_library(ephone_field SHARED ephone_phonenumber_c.cc)
  set_target_properties(ephone_field PROPERTIES
    PUBLIC_HEADER ephone_phonenumber_c.h
    OUTPUT_NAME "ephone_field"
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN ON
  )
  target_include_directories(ephone_field PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
  target_compile_definitions(ephone_field
    PUBLIC DART_SHARED_LIB
    PRIVATE EPHONE_HAS_LIBPHONENUMBER=1
  )
  target_link_libraries(ephone_field PRIVATE ephone_phonenumber)
  message(STATUS "ephone_field: linking Google libphonenumber (production)")
else()
  message(STATUS "ephone_field: building static phonenumber stack (iOS)")
endif()

if(ANDROID AND TARGET ephone_field)
  target_link_options(ephone_field PRIVATE "-Wl,-z,max-page-size=16384")
  target_link_libraries(ephone_field PRIVATE log)
endif()
