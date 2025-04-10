#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/*
 * Button at PORTB0, PORTB1, PORTB2
 * - PORTB0: Mode 1
 * - PORTB1: Mode 2
 * - PORTB2: Mode 3
 * LED at PORTB5, PORTB6, PORTB7
 * - PORTB3: Led red
 * - PORTB4: Led yellow
 * - PORTB5: Led green
 */
const int BUTTONS[3] = {0b00000001, 0b00000010, 0b00000100};
const int LEDS[3] = {0b00001000, 0b00010000, 0b00100000};
const int OFF = 0b00000000;

const char SEND_MSGS[11] = {'1', '2', '3', 'M', 'A', 'R',
                            'O', 'Y', 'G', 'E', 'S'};
const char RECEIVE_MSGS[6] = {'T', 'D', 'N', 'I', 'S', 'Z'};
int durations[4] = {5, 3, 10, 1}; /* Red, yellow, green, blink yellow */

/* Mode
 * - 1: Ony red led
 * - 2: Blink yellow led 1s
 * - 3:
 *   + Day mode: 5s red -> 3s yellow -> 10s green -> loop
 *   + Night mode: blink yellow led 1s
 */
int mode = 3;
int is_night_mode = 0;

/* Control mode
 * - 0: Manual mode
 * - 1: Auto mode
 */
int control_mode = 0;

/* Communication */
#define ESP8266_STATION 0x01
#define ESP8266_SOFTAP 0x02
#define ESP8266_BOTH 0x03

#define ESP8266_TCP 1
#define ESP8266_UDP 0
#define ESP8266_TRANS_PASS 1
#define ESP8266_TRANS_NOR 0

#define ESP8266_OK 1
#define ESP8266_READY 2
#define ESP8266_FAIL 3
#define ESP8266_NOCHANGE 4
#define ESP8266_LINKED 5
#define ESP8266_UNLINK 6
#define ESP8266_CONNECT 7

char received_data;
bit transmit_flag, receive_flag;

void _esp8266_putch(char c) {
  while (!TXIF_bit)
    ;
  TXREG = c;
}

char _esp8266_getch() {
  if (OERR_bit) {
    CREN_bit = 0;
    CREN_bit = 1;
  }
  while (!RCIF_bit)
    ;
  return RCREG;
}

void ESP8266_send_string(char *str) {
  while (*str) {
    _esp8266_putch(*str++);
  }
}

void _esp8266_print(unsigned char *str) {
  while (*str != 0) {
    _esp8266_putch(*str++);
  }
}

inline uint16_t _esp8266_waitFor(unsigned char *str) {
  unsigned char so_far = 0;
  unsigned char received;
  uint16_t counter = 0;

  do {
    received = _esp8266_getch();
    counter++;

    if (received == str[so_far]) {
      so_far++;
    } else {
      so_far = 0;
    }
  } while (str[so_far] != 0);

  return counter;
}

void esp8266_restart(void) {
  _esp8266_print("AT+RST\r\n");
  // _esp8266_waitFor("OK");
  // _esp8266_waitFor("ready");
}

void esp8266_isStarted(void) {
  _esp8266_print("AT\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_echoCmds(bool echo) {
  _esp8266_print("ATE");

  if (echo)
    _esp8266_putch('1');
  else
    _esp8266_putch('0');

  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_mode(unsigned char mode) {
  _esp8266_print("AT+CWMODE=");
  _esp8266_putch(mode + '0');
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_trans_mode(unsigned char mode) {
  _esp8266_print("AT+CIPMODE=");
  _esp8266_putch(mode + '0');
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_connect(unsigned char *ssid, unsigned char *password) {
  _esp8266_print("AT+CWJAP=\"");
  _esp8266_print(ssid);
  _esp8266_print("\",\"");
  _esp8266_print(password);
  _esp8266_print("\"\r\n");
  _esp8266_waitFor("OK");
}

unsigned char esp8266_start(unsigned char protocol, unsigned char *ip,
                            unsigned int port) {
  unsigned char port_str[5] = "\0\0\0\0";
  _esp8266_print("AT+CIPSTART=\"");
  if (protocol == ESP8266_TCP)
    _esp8266_print("TCP");
  else
    _esp8266_print("UDP");

  _esp8266_print("\",\"");
  _esp8266_print(ip);
  _esp8266_print("\",");

  sprintf(port_str, "%u", port);
  _esp8266_print(port_str);
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_send(void) {
  _esp8266_print("AT+CIPSEND");
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
  while (_esp8266_getch() != '>')
    ;
}

void esp8266_receive(unsigned char *stored) {
  unsigned char length = 0;
  unsigned char i;
  unsigned char received;

  _esp8266_waitFor("+IPD,");
  do {
    received = _esp8266_getch();
    if (received == ':')
      break;
    length = length * 10 + (received - '0');
  } while (received >= '0' && received <= '9');

  for (i = 0; i < length; i++) {
    stored[i] = _esp8266_getch();
  }
}

void esp8266_disconnect(void) {
  _esp8266_print("AT+CWQAP\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_stop_send(void) {
  _esp8266_print("+++");
  delay_ms(2000);
}

void esp8266_del_TCP(void) {
  _esp8266_print("AT+CIPCLOSE\r\n");
  _esp8266_waitFor("OK");
}

void setup_communication() {
  PORTC = 0x00;
  LATC = 0x00;
  TRISC0_bit = 0;

  UART1_Init(115200);
  delay_ms(100);

  RC0_bit = 0;
  delay_ms(100);
  RC0_bit = 1;
  Delay_ms(1000);

  esp8266_restart();
  esp8266_echoCmds(0);
  esp8266_isStarted();
  esp8266_mode(ESP8266_STATION);
  esp8266_connect("Phat Tien", "tt@20042007");
  esp8266_start(ESP8266_TCP, "192.168.1.3", 3001);

  esp8266_trans_mode(ESP8266_TRANS_PASS);
  esp8266_send();

  RCIF_bit = 0;
  PIE1.RCIE = 1;

  GIE_bit = 1;
  PEIE_bit = 1;
}

void send_msg(int index) {
  if (!UART1_Tx_Idle())
    return;

  UART1_Write(SEND_MSGS[index]);
  Delay_ms(100);
}

char receive_msg() {
  if (receive_flag == 1) {
    receive_flag = 0;
    received_data = UART1_READ();
    return received_data;
  }
}

void set_time() {
  int i;
  char time[7];

  for (i = 0; i < 6; i++) {
    time[i] = UART1_READ();

    if (time[i] == 'S')
      i = -1;
  }
  time[6] = '\0';

  for (i = 0; i < 6; i++) {
    if (time[i] < '0' || time[i] > '9') {
      return;
    }
  }

  durations[0] = (time[0] - '0') * 10 + (time[1] - '0');
  durations[1] = (time[2] - '0') * 10 + (time[3] - '0');
  durations[2] = (time[4] - '0') * 10 + (time[5] - '0');
  send_msg(10);
}

void interrupt(void) {
  if ((RCIE_bit == 1) && (RCIF_bit == 1)) {
    RCIF_bit = 0;
    received_data = UART1_Read();
    receive_flag = 1;
  }
}

/* Main */

void delay(int duration);

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  TRISB = 0b00000111;
  PORTB = OFF;

  setup_communication();
}

void loop() {
  if (mode == 1) {
    PORTB = LEDS[0];
    send_msg(5);
    delay(durations[0]);
  } else if (mode == 2 || (mode == 3 && is_night_mode)) {
    PORTB ^= LEDS[1];
    send_msg((PORTB & 0x38) == LEDS[1] ? 7 : 6);
    delay(durations[3]);
  } else if (mode == 3) {
    if ((PORTB & 0x38) == LEDS[0]) {
      PORTB = LEDS[1];
      send_msg(7);
      delay(durations[1]);
    } else if ((PORTB & 0x38) == LEDS[1]) {
      PORTB = LEDS[2];
      send_msg(8);
      delay(durations[2]);
    } else {
      PORTB = LEDS[0];
      send_msg(5);
      delay(durations[0]);
    }
  }
}

void main() {
  setup();
  while (1)
    loop();
}

int switch_mode(int newMode) {
  if (mode == newMode)
    return 0;

  PORTB = OFF;
  mode = newMode;
  send_msg(newMode - 1);
  return 1;
}

void delay(int delay_s) {
  int i, j;

  for (i = 0; i < delay_s * 10; i++) {

    // Check receive message
    char msg = receive_msg();
    if (msg == RECEIVE_MSGS[0]) {
      control_mode = 1 - control_mode;
      send_msg(control_mode + 3);
    } else if (msg == RECEIVE_MSGS[1]) {
      is_night_mode = 0;
      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (msg == RECEIVE_MSGS[2]) {
      is_night_mode = 1;
      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (msg == RECEIVE_MSGS[3]) {
      send_msg(mode - 1);
      Delay_ms(100);
      send_msg(control_mode + 3);
    } else if (msg == RECEIVE_MSGS[4]) {
      set_time();

      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (msg == RECEIVE_MSGS[5]) {
      GIE_bit = 0;
      RE0_bit = 0;
      esp8266_stop_send();
      esp8266_trans_mode(ESP8266_TRANS_NOR);
      esp8266_del_TCP();
    } else if (control_mode == 1) {
      int newMode = msg - '0';
      if (newMode >= 1 && newMode <= 3) {
        if (switch_mode(newMode))
          return;
      }
    }

    // Check button
    for (j = 0; j < 3; j++)
      if (Button(&PORTB, j, 10, 0) && control_mode == 0) {
        while (Button(&PORTB, j, 10, 0))
          ;
        if (switch_mode(j + 1))
          return;
      }

    Delay_ms(100);
  }
}
