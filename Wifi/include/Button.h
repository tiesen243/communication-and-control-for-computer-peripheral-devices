#ifndef _BUTTON_H_
#define _BUTTON_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

unsigned short Button(volatile uint8_t *port, unsigned short pin,
                      unsigned short time, unsigned short active_state);

#ifdef __cplusplus
}
#endif

#endif // _BUTTON_H_
