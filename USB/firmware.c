#include <stdbool.h>

/*
 * DEFINITIONS
 */

enum LedState {
  LED_RED = 0x08,
  LED_YELLOW = 0x10,
  LED_GREEN = 0x20,
  LED_OFF = 0x00,
};

enum Mode {
  MODE_1 = 1,
  MODE_2 = 2,
  MODE_3 = 3,
};

enum ControlMode {
  MANUAL_MODE = 0,
  AUTO_MODE = 1,
};

int durations[4] = {5, 3, 10, 1};
int mode = MODE_3;
int is_night_mode = false;
int controlMode = MANUAL_MODE;

/*
 * COMMUNICATION
 * - ESP8266
 * - UART
 */
#define inp_size 7
#define out_size 7
unsigned char readbuff[inp_size] absolute 0x500;
unsigned char writebuff[out_size] absolute 0x540;

void interrupt(void) {
  if (USBIF_bit == 1) {
    USBIF_bit = 0;
    USB_Interrupt_Proc();
  }
}

void setup_communication() {
  UPUEN_bit = 1;
  FSEN_bit = 1;

  HID_Enable(&readbuff, &writebuff);

  USBIF_bit = 0;
  USBIE_bit = 1;
  GIE_bit = 1;
  PEIE_bit = 1;

  Delay_ms(100);
}

char read_data() {
  if (HID_Read() != 0)
    return readbuff[0];
  return 0;
}

void send_data(char _data) {
  writebuff[0] = _data;
  HID_Write(&writebuff, out_size);
  Delay_ms(100);
}

/*
 * MAIN
 * - SETUP: Initialize peripherals
 * - LOOP: Main loop
 * - DELAY: Delay function with UART and button handler
 */

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  TRISB = 0x07;
  PORTB = LED_OFF;

  setup_communication();
}

void delay(int delay_s) {
  int i, j;
  for (i = 0; i < delay_s * 10; i++) {
    /* UART handler */
    char msg = read_data();
    if (msg == 'I') {
      send_data('0' + mode);
      Delay_ms(100);
      send_data(controlMode ? 'A' : 'M');
      Delay_ms(100);
    } else if (msg == 'T') {
      controlMode = 1 - controlMode;
      send_data(controlMode ? 'A' : 'M');
    } else if (msg == 'D' || msg == 'N') {
      is_night_mode = (msg == 'N');
      if (mode == MODE_3) {
        PORTB = LED_OFF;
        return;
      }
    } else if (msg == 'S') {
      char time[out_size - 1];
      for (j = 0; j < 6; j++) {
          time[j] = readbuff[j + 1];
      }

      for (j = 0; j < 6; j++) {
        if (time[j] < '0' || time[j] > '9') {
          send_data('E');
          return;
        }
      }

      durations[0] = (time[0] - '0') * 10 + (time[1] - '0');
      durations[1] = (time[2] - '0') * 10 + (time[3] - '0');
      durations[2] = (time[4] - '0') * 10 + (time[5] - '0');
      send_data('S');

      if (mode == MODE_3) {
        PORTB = LED_OFF;
        return;
      }
    } else if ((msg >= '1' || msg <= '3') && controlMode == AUTO_MODE) {
      int newMode = msg - '0';
      if (newMode >= 1 && newMode <= 3 && mode != newMode) {
        PORTB = LED_OFF;
        mode = newMode;
        send_data('0' + mode);
        return;
      }
    }

    /* Button handler */
    for (j = 0; j < 3; j++) {
      if (Button(&PORTB, j, 10, 0) && controlMode == MANUAL_MODE) {
        while (Button(&PORTB, j, 10, 0))
          ;
        PORTB = LED_OFF;
        mode = j + 1;
        send_data('0' + mode);
        return;
      }
    }

    Delay_ms(100);
  }
}

void loop() {
  if (mode == MODE_1) {
    PORTB = LED_RED;
    send_data('R');
    delay(durations[0]);
  } else if (mode == MODE_2 || (mode == MODE_3 && is_night_mode)) {
    PORTB ^= LED_YELLOW;
    send_data((PORTB & LED_YELLOW) ? 'Y' : 'O');
    delay(durations[3]);
  } else if (mode == MODE_3) {
    if ((PORTB & 0x38) == LED_RED) {
      PORTB = LED_YELLOW;
      send_data('Y');
      delay(durations[1]);
    } else if ((PORTB & 0x38) == LED_YELLOW) {
      PORTB = LED_GREEN;
      send_data('G');
      delay(durations[2]);
    } else {
      PORTB = LED_RED;
      send_data('R');
      delay(durations[0]);
    }
  } else {
    PORTB = LED_OFF;
  }
}

int main() {
  setup();
  while (true) {
    loop();
  }

  return 0;
}