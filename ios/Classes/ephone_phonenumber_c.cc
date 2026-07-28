// Anchor TU so Flutter still emits ephone_field.framework.
// Native libphonenumber symbols are force-loaded from the CMake static stack.
#include "../../src/ephone_phonenumber_c.h"

extern "C" int ephone_field_ios_anchor(void) {
  return ephone_phone_api_version();
}
