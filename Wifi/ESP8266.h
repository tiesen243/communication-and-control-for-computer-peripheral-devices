#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#ifndef ESP8266_H
#define ESP8266_H

#ifdef __cplusplus
extern "C" {
#endif

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

/**
 * Function to send one byte of date to UART
 */
void _esp8266_putch(char bt);

/**
 * Function to get one byte of date from UART
 */
char _esp8266_getch();

/**
 * Function to convert string to byte
 */
void ESP8266_send_string(char *st_pt);

/**
 *Output a string to the ESP module.
 * This is a function for internal use only.
 * @param ptr A pointer to the string to send.
 */
void _esp8266_print(unsigned char *ptr);

/**
 * Wait until we found a string on the input.
 * Careful: this will read everything until that string (even if it's never
 * found). You may lose important data.
 * @param string
 * @return the number of characters read
 */
inline uint16_t _esp8266_waitFor(unsigned char *string);

/**
 * Restart the module
 * This sends the `AT+RST` command to the ESP and waits until there is a
 * response "OK" and "ready".
 */
void esp8266_restart(void);

/**
 * Check if the module is started
 * This sends the `AT` command to the ESP and waits until it gets a response "OK
 */
void esp8266_isStarted(void);

/**
 * Enable / disable command echoing.
 * Enabling this is useful for debugging: one could sniff the TX line from the
 * ESP8266 with his computer and thus receive both commands and responses.
 * This sends the ATE command to the ESP module and waits until it gets a
 * respone "OK".
 * @param echo whether to enable command echoing(1) or not(0)
 */
void esp8266_echoCmds(bool echo);

/**
 * Set the WiFi mode.
 * ESP8266_STATION : Station mode
 * ESP8266_SOFTAP : Access Point mode
 * ESP8266_BOTH : Station + Access Point mode
 * This sends the AT+CWMODE command to the ESP module and waits until it gets a
 * response "OK".
 * @param mode an ORed bitmask of ESP8266_STATION, ESP8266_SOFTAP, ESP8266_BOTH
 */
void esp8266_mode(unsigned char mode);

/**
 * Set the transmission mode.
 *  - ESP8266_TRANS_PASS: Passthrough Receiving Mode (Transparent receiving
 * transmission mode)
 *  - ESP8266_TRANS_NOR: Normal Transmission Mode This sends the AT+CIPMODE
 * command to the ESP module and waits until it gets a response "OK".
 * @param mode an ORed bitmask of ESP8266_TRANS_PASS, ESP8266_TRANS_NOR
 */
void esp8266_trans_mode(unsigned char mode);

/**
 * Connect to an access point.
 * This sends the AT+CWJAP command to the ESP module and waits until it gets a
 * response "OK".
 * @param ssid The SSID to connect to
 * @param pass The password of the network
 */
void esp8266_connect(unsigned char *ssid, unsigned char *pass);

/**
 * Get the IP address of the ESP8266.
 * This sends the AT+CIFSR command to the ESP module and waits until it gets a
 * response "OK".
 * @param ip The IP address of the ESP8266
 */
void esp8266_ip(void);

/**
 * Open a TCP or UDP connection.
 * This sends the AT+CIPSTART command to the ESP module and waits until it gets
 * response "OK".
 * @param protocol Either ESP8266_TCP or ESP8266_UDP
 * @param ip The IP or hostname to connect to; as a string
 * @param port The port to connect to
 */
unsigned char esp8266_start(unsigned char protocol, unsigned char *ip,
                            unsigned int port);

/**
 * Send data over a connection.
 * This sends the AT+CIPSEND command to the ESP module and waits until it gets a
 * response "OK".
 * @param data The data to send
 */
void esp8266_send(void);

/**
 * Read a string of data that is sent to the ESP8266 (for Single Connection as
 * TCP Client). This waits for a +IPD line from the module. If more bytes than
 * the maximum are received, the remaining bytes will be discarded.
 * @param store_in a pointer to a character array to store the data in
 */
void esp8266_receive(unsigned char *store_in);

/**
 * Disconnect from the access point.
 * This sends the AT+CWQAP command to the ESP module.
 */
void esp8266_disconnect(void);

/**
 * Stop sending data.
 * This sends the +++ to the ESP module.
 */
void esp8266_stop(void);

/**
 * Delete TCP connection
 * This sends the AT+CIPCLOSE command to the ESP module.
 */
void esp8266_close(void);

#ifdef __cplusplus
}
#endif

#endif /* ESP8266_H */
