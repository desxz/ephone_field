#ifndef EPHONE_PHONENUMBER_C_H_
#define EPHONE_PHONENUMBER_C_H_

#include <stdint.h>

#if _WIN32
#define EPHONE_FFI_EXPORT __declspec(dllexport)
#else
#define EPHONE_FFI_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#endif

#ifdef __cplusplus
extern "C" {
#endif

/// API version for Dart ↔ native handshake (hello round-trip).
EPHONE_FFI_EXPORT int32_t ephone_phone_api_version(void);

/// Returns 1 if this build links libphonenumber, 0 for the stub FFI.
EPHONE_FFI_EXPORT int32_t ephone_phone_uses_libphonenumber(void);

/// Opaque handle to a shared PhoneNumberUtil-backed context.
typedef struct EphonePhoneUtil EphonePhoneUtil;

EPHONE_FFI_EXPORT EphonePhoneUtil* ephone_phone_util_create(void);
EPHONE_FFI_EXPORT void ephone_phone_util_destroy(EphonePhoneUtil* util);

/// Returns 1 if valid, 0 if invalid, -1 on error.
EPHONE_FFI_EXPORT int32_t ephone_phone_is_valid(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code);

/// Returns 1 if possible, 0 if not, -1 on error.
EPHONE_FFI_EXPORT int32_t ephone_phone_is_possible(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code);

/// Writes E.164 into [out] (NUL-terminated). Returns 1 on success, 0 on failure.
EPHONE_FFI_EXPORT int32_t ephone_phone_format_e164(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* out,
    int32_t out_len);

/// Writes national format into [out]. Returns 1 on success, 0 on failure.
EPHONE_FFI_EXPORT int32_t ephone_phone_format_national(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* out,
    int32_t out_len);

/// Opaque as-you-type session.
typedef struct EphoneAsYouType EphoneAsYouType;

EPHONE_FFI_EXPORT EphoneAsYouType* ephone_asyoutype_create(
    EphonePhoneUtil* util,
    const char* region_code);

EPHONE_FFI_EXPORT void ephone_asyoutype_destroy(EphoneAsYouType* session);

/// Feeds one Unicode code point; writes formatted output into [out].
/// Returns 1 on success.
EPHONE_FFI_EXPORT int32_t ephone_asyoutype_input_digit(
    EphoneAsYouType* session,
    int32_t code_point,
    char* out,
    int32_t out_len);

EPHONE_FFI_EXPORT void ephone_asyoutype_clear(EphoneAsYouType* session);

/// Parses [raw] for [region_code]. On success writes E.164, national digits,
/// and ITU country calling code. Returns 1 on success, 0 on failure.
EPHONE_FFI_EXPORT int32_t ephone_phone_parse(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* e164_out,
    int32_t e164_len,
    char* national_out,
    int32_t national_len,
    int32_t* country_code_out);

#ifdef __cplusplus
}  // extern "C"
#endif

#endif  // EPHONE_PHONENUMBER_C_H_
