#include <stdbool.h>

#include "include/ESP8266.h"

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

void setup_communication() {
  UART1_Init(115200);
  Delay_ms(100);

  esp8266_restart();
  esp8266_echoCmds(false);
  esp8266_isStarted();
  esp8266_mode(ESP8266_STATION);
  esp8266_connect((unsigned char *)"Tiesen", (unsigned char *)"24032206");
  esp8266_ip();
  esp8266_start(ESP8266_TCP, (unsigned char *)"192.168.235.142", 3000);
  esp8266_trans_mode(ESP8266_TRANS_PASS);
  esp8266_send();
}

char read_data() {
  char _data = 0;
  if (UART1_Data_Ready()) {
    _data = UART1_Read();
  }
  return _data;
}

void send_data(char _data) {
  if (!UART1_Tx_Idle())
    return;

  UART1_Write(_data);
  Delay_ms(100);
}

/*
 * MAIN
 * - SETUP: Initialize peripherals
 * - LOOP: Main loop
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
      char time[7];
      for (j = 0; j < 6; j++) {
        while (!UART1_Data_Ready())
          ;
        time[j] = UART1_Read();
        if (time[j] == 'S')
          j = -1;
      }
      time[6] = '\0';

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
    } else if (msg == 'Z') {
      esp8266_stop();
      esp8266_trans_mode(ESP8266_TRANS_NOR);
      esp8266_close();
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