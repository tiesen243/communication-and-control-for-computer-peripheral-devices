#include "ESP8266.h"

#include <stdbool.h>
#include <stdio.h>

void _esp8266_putch(char bt) {
  while (!TXIF_bit)
    ;
  TXREG = bt;
}
char _esp8266_getch() {
  if (OERR_bit) // check for Error
  {
    CREN_bit = 0; // If error -> Reset
    CREN_bit = 1; // If error -> Reset
  }
  while (!RCIF_bit)
    ;           // hold the program till RX buffer is free
  return RCREG; // receive the value and send it to main function
}

void ESP8266_send_string(char *st_pt) {
  while (*st_pt)
    _esp8266_putch(*st_pt++);
}

void _esp8266_print(unsigned char *ptr) {
  while (*ptr != 0)
    _esp8266_putch(*ptr++);
}

inline uint16_t _esp8266_waitFor(unsigned char *string) {
  unsigned char so_far = 0;
  unsigned char received;
  uint16_t counter = 0;
  do {
    received = _esp8266_getch();
    counter++;
    if (received == string[so_far]) {
      so_far++;
    } else {
      so_far = 0;
    }
  } while (string[so_far] != 0);
  return counter;
}

void esp8266_restart(void) {
  _esp8266_print("AT+RST\r\n"); // Command
  _esp8266_waitFor("OK");       // Wait for "OK"
  Delay_ms(2000);               // Wait for 2 seconds
}

void esp8266_isStarted(void) {
  _esp8266_print("AT\r\n"); // Command
  _esp8266_waitFor("OK");   // Wait for "OK"
}

void esp8266_echoCmds(bool echo) {
  _esp8266_print("ATE");            // Command
  _esp8266_putch(echo ? '1' : '0'); // 1 for echo, 0 for no echo
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK"); // Wait for "OK"
}

void esp8266_mode(unsigned char mode) {
  _esp8266_print("AT+CWMODE="); // Command
  _esp8266_putch(mode + '0');
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK"); // Wait for "OK"
}

void esp8266_trans_mode(unsigned char mode) {
  _esp8266_print("AT+CIPMODE="); // Command
  _esp8266_putch(mode + '0');
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK"); // Wait for "OK"
}

void esp8266_connect(unsigned char *ssid, unsigned char *pass) {
  _esp8266_print("AT+CWJAP=\""); // Command
  _esp8266_print(ssid);
  _esp8266_print("\",\"");
  _esp8266_print(pass);
  _esp8266_print("\"\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_ip() {
  _esp8266_print("AT+CIFSR\r\n"); // Command
  _esp8266_waitFor("OK");         // Wait for "OK"
}

unsigned char esp8266_start(unsigned char protocol, unsigned char *ip,
                            unsigned int port) {
  unsigned char port_str[5] = "\0\0\0\0";
  _esp8266_print("AT+CIPSTART=\"");
  if (protocol == ESP8266_TCP) {
    _esp8266_print("TCP");
  } else {
    _esp8266_print("UDP");
  }
  _esp8266_print("\",\"");
  _esp8266_print(ip);
  _esp8266_print("\",");

  sprintf((char *)port_str, "%u", port);
  _esp8266_print(port_str);
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK"); // Wait for "OK"

  return 1;
}

void esp8266_send(void) {
  _esp8266_print("AT+CIPSEND");
  _esp8266_print("\r\n");
  _esp8266_waitFor("OK");
  while (_esp8266_getch() != '>')
    ;
}

void esp8266_receive(unsigned char *store_in) {
  unsigned char length = 0;
  unsigned char i;
  unsigned char received;

  // Format: +IPD,<length>:<data>
  _esp8266_waitFor("+IPD,"); // Wait for: +IPD - Read data
  do {
    received = _esp8266_getch(); // Get bytes of Length
    if (received == ':')
      break;                                 // Stop when detect ":"
    length = length * 10 + (received - '0'); // Determine data length
  } while (received >= '0' && received <= '9');

  for (i = 0; i < length; i++) // Get bytes of Data
    store_in[i] = _esp8266_getch();
}

void esp8266_disconnect(void) {
  _esp8266_print("AT+CWQAP\r\n");
  _esp8266_waitFor("OK");
}

void esp8266_stop(void) {
  _esp8266_print("+++");
  Delay_ms(2000);
}

void esp8266_close(void) {
  _esp8266_print("AT+CIPCLOSE\r\n");
  _esp8266_waitFor("OK");
}
