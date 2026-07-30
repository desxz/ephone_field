#include "ephone_phonenumber_c.h"

#include <cstring>
#include <string>

#if defined(EPHONE_HAS_LIBPHONENUMBER)
#include "phonenumbers/asyoutypeformatter.h"
#include "phonenumbers/phonenumberutil.h"
#endif

namespace {

constexpr int32_t kApiVersion = 1;

#if defined(EPHONE_HAS_LIBPHONENUMBER)
using i18n::phonenumbers::AsYouTypeFormatter;
using i18n::phonenumbers::PhoneNumber;
using i18n::phonenumbers::PhoneNumberUtil;

bool CopyToBuffer(const std::string& value, char* out, int32_t out_len) {
  if (out == nullptr || out_len <= 0) {
    return false;
  }
  if (static_cast<int32_t>(value.size()) + 1 > out_len) {
    return false;
  }
  std::memcpy(out, value.c_str(), value.size() + 1);
  return true;
}
#endif

}  // namespace

struct EphonePhoneUtil {
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  const PhoneNumberUtil* util = nullptr;
#else
  int unused = 0;
#endif
};

struct EphoneAsYouType {
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  AsYouTypeFormatter* formatter = nullptr;
#else
  int unused = 0;
#endif
};

extern "C" {

EPHONE_FFI_EXPORT int32_t ephone_phone_api_version(void) { return kApiVersion; }

EPHONE_FFI_EXPORT int32_t ephone_phone_uses_libphonenumber(void) {
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  return 1;
#else
  return 0;
#endif
}

EPHONE_FFI_EXPORT EphonePhoneUtil* ephone_phone_util_create(void) {
  auto* handle = new EphonePhoneUtil();
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  handle->util = PhoneNumberUtil::GetInstance();
#endif
  return handle;
}

EPHONE_FFI_EXPORT void ephone_phone_util_destroy(EphonePhoneUtil* util) {
  delete util;
}

EPHONE_FFI_EXPORT int32_t ephone_phone_is_valid(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code) {
  if (util == nullptr || raw == nullptr || region_code == nullptr) {
    return -1;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  PhoneNumber number;
  const auto error = util->util->Parse(raw, region_code, &number);
  if (error != PhoneNumberUtil::NO_PARSING_ERROR) {
    return 0;
  }
  return util->util->IsValidNumber(number) ? 1 : 0;
#else
  (void)util;
  (void)raw;
  (void)region_code;
  return 0;
#endif
}

EPHONE_FFI_EXPORT int32_t ephone_phone_is_possible(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code) {
  if (util == nullptr || raw == nullptr || region_code == nullptr) {
    return -1;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  PhoneNumber number;
  const auto error = util->util->Parse(raw, region_code, &number);
  if (error != PhoneNumberUtil::NO_PARSING_ERROR) {
    return 0;
  }
  return util->util->IsPossibleNumber(number) ? 1 : 0;
#else
  (void)util;
  (void)raw;
  (void)region_code;
  return 0;
#endif
}

EPHONE_FFI_EXPORT int32_t ephone_phone_format_e164(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* out,
    int32_t out_len) {
  if (util == nullptr || raw == nullptr || region_code == nullptr) {
    return 0;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  PhoneNumber number;
  const auto error = util->util->Parse(raw, region_code, &number);
  if (error != PhoneNumberUtil::NO_PARSING_ERROR) {
    return 0;
  }
  std::string formatted;
  util->util->Format(number, PhoneNumberUtil::E164, &formatted);
  return CopyToBuffer(formatted, out, out_len) ? 1 : 0;
#else
  (void)util;
  (void)raw;
  (void)region_code;
  (void)out;
  (void)out_len;
  return 0;
#endif
}

EPHONE_FFI_EXPORT int32_t ephone_phone_format_national(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* out,
    int32_t out_len) {
  if (util == nullptr || raw == nullptr || region_code == nullptr) {
    return 0;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  PhoneNumber number;
  const auto error = util->util->Parse(raw, region_code, &number);
  if (error != PhoneNumberUtil::NO_PARSING_ERROR) {
    return 0;
  }
  std::string formatted;
  util->util->Format(number, PhoneNumberUtil::NATIONAL, &formatted);
  return CopyToBuffer(formatted, out, out_len) ? 1 : 0;
#else
  (void)util;
  (void)raw;
  (void)region_code;
  (void)out;
  (void)out_len;
  return 0;
#endif
}

EPHONE_FFI_EXPORT EphoneAsYouType* ephone_asyoutype_create(
    EphonePhoneUtil* util,
    const char* region_code) {
  if (util == nullptr || region_code == nullptr) {
    return nullptr;
  }
  auto* session = new EphoneAsYouType();
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  session->formatter = util->util->GetAsYouTypeFormatter(region_code);
#else
  (void)util;
  (void)region_code;
#endif
  return session;
}

EPHONE_FFI_EXPORT void ephone_asyoutype_destroy(EphoneAsYouType* session) {
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  if (session != nullptr) {
    delete session->formatter;
  }
#endif
  delete session;
}

EPHONE_FFI_EXPORT int32_t ephone_asyoutype_input_digit(
    EphoneAsYouType* session,
    int32_t code_point,
    char* out,
    int32_t out_len) {
  if (session == nullptr || out == nullptr || out_len <= 0) {
    return 0;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  if (session->formatter == nullptr) {
    return 0;
  }
  std::string formatted;
  session->formatter->InputDigit(code_point, &formatted);
  return CopyToBuffer(formatted, out, out_len) ? 1 : 0;
#else
  (void)code_point;
  out[0] = '\0';
  return 1;
#endif
}

EPHONE_FFI_EXPORT void ephone_asyoutype_clear(EphoneAsYouType* session) {
  if (session == nullptr) {
    return;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  if (session->formatter != nullptr) {
    session->formatter->Clear();
  }
#endif
}

EPHONE_FFI_EXPORT int32_t ephone_phone_parse(
    EphonePhoneUtil* util,
    const char* raw,
    const char* region_code,
    char* e164_out,
    int32_t e164_len,
    char* national_out,
    int32_t national_len,
    int32_t* country_code_out) {
  if (util == nullptr || raw == nullptr || region_code == nullptr ||
      e164_out == nullptr || national_out == nullptr ||
      country_code_out == nullptr || e164_len <= 0 || national_len <= 0) {
    return 0;
  }
#if defined(EPHONE_HAS_LIBPHONENUMBER)
  PhoneNumber number;
  const auto error = util->util->Parse(raw, region_code, &number);
  if (error != PhoneNumberUtil::NO_PARSING_ERROR) {
    return 0;
  }
  std::string e164;
  util->util->Format(number, PhoneNumberUtil::E164, &e164);
  std::string national;
  util->util->GetNationalSignificantNumber(number, &national);
  if (!CopyToBuffer(e164, e164_out, e164_len) ||
      !CopyToBuffer(national, national_out, national_len)) {
    return 0;
  }
  *country_code_out = number.has_country_code() ? number.country_code() : 0;
  return 1;
#else
  (void)util;
  (void)raw;
  (void)region_code;
  (void)e164_out;
  (void)e164_len;
  (void)national_out;
  (void)national_len;
  (void)country_code_out;
  return 0;
#endif
}

}  // extern "C"
