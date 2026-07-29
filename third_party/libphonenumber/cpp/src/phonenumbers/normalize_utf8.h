// Copyright (C) 2011 The Libphonenumber Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <cstdint>
#include <string>

#include "phonenumbers/utf/unicodetext.h"

namespace i18n {
namespace phonenumbers {
namespace {

// Local Nd → ASCII digit mapping so we do not depend on ICU u_charDigitValue.
inline int32_t EphoneCharDigitValue(char32_t c) {
  if (c >= '0' && c <= '9') {
    return static_cast<int32_t>(c - '0');
  }
  // Unicode decimal digit (Nd) block starts — each runs for 10 consecutive code points.
  static const char32_t kNdStarts[] = {
      0x0660, 0x06F0, 0x07C0, 0x0966, 0x09E6, 0x0A66, 0x0AE6, 0x0B66, 0x0BE6,
      0x0C66, 0x0CE6, 0x0D66, 0x0DE6, 0x0E50, 0x0ED0, 0x0F20, 0x1040, 0x1090,
      0x17E0, 0x1810, 0x1946, 0x19D0, 0x1A80, 0x1A90, 0x1B50, 0x1BB0, 0x1C40,
      0x1C50, 0xA620, 0xA8D0, 0xA900, 0xA9D0, 0xA9F0, 0xAA50, 0xABF0, 0xFF10,
      0x104A0, 0x10D30, 0x11066, 0x110F0, 0x11136, 0x111D0, 0x112F0, 0x11450,
      0x114D0, 0x11650, 0x116C0, 0x11730, 0x118E0, 0x11950, 0x11C50, 0x11D50,
      0x11DA0, 0x16A60, 0x16B50, 0x16E80, 0x1D7CE, 0x1D7D8, 0x1D7E2, 0x1D7EC,
      0x1D7F6, 0x1E140, 0x1E2F0, 0x1E4F0, 0x1E950, 0x1FBF0,
  };
  for (char32_t start : kNdStarts) {
    if (c >= start && c <= start + 9) {
      return static_cast<int32_t>(c - start);
    }
  }
  return -1;
}

}  // namespace

struct NormalizeUTF8 {
  // Put a UTF-8 string in ASCII digits: All decimal digits (Nd) replaced by
  // their ASCII counterparts; all other characters are copied from input to
  // output.
  static string NormalizeDecimalDigits(const string& number) {
    string normalized;
    UnicodeText number_as_unicode;
    number_as_unicode.PointToUTF8(number.data(), static_cast<int>(number.size()));
    if (!number_as_unicode.UTF8WasValid())
      return normalized; // Return an empty result to indicate an error
    for (UnicodeText::const_iterator it = number_as_unicode.begin();
         it != number_as_unicode.end();
         ++it) {
      int32_t digitValue = EphoneCharDigitValue(*it);
      if (digitValue == -1) {
        // Not a decimal digit.
        char utf8[4];
        int len = it.get_utf8(utf8);
        normalized.append(utf8, len);
      } else {
        normalized.push_back('0' + digitValue);
      }
    }
    return normalized;
  }
};

}  // namespace phonenumbers
}  // namespace i18n
