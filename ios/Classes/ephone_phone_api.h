#ifndef EPHONE_PHONE_API_H_
#define EPHONE_PHONE_API_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/// Declared here so the iOS anchor TU does not depend on ../src (pubignored).
/// The real definition is force-loaded from the prebuilt/CMake stack.
int32_t ephone_phone_api_version(void);

#ifdef __cplusplus
}  // extern "C"
#endif

#endif  // EPHONE_PHONE_API_H_
