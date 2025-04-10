#include <stdbool.h>

#include "include/P18F4550.h"

enum LedState {
  LED_RED = 0x08,
  LED_YELLOW = 0x10,
  LED_GREEN = 0x20,
  LED_OFF = 0x00,
};

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  TRISB = 0x07;
  PORTB = LED_OFF;
}

void loop() {
  PORTB = LED_RED;
  Delay_ms(100);
}

int main() {
  setup();
  while (true) {
    loop();
  }
}
