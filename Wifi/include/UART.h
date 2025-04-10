#ifndef _UART_H_
#define _UART_H_

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Initialize UART1 with given baud rate
void UART1_Init(uint32_t baudrate);

// Returns true if data is available to read
bool UART1_Data_Ready(void);

// Returns true if UART is ready to transmit
bool UART1_Tx_Idle(void);

// Read one byte from UART1
uint8_t UART1_Read(void);

// Read string until termination character or max length
void UART1_Read_Text(char *output, char delimiter, uint16_t max_length);

// Write one byte to UART1
void UART1_Write(uint8_t data);

// Write null-terminated string to UART1
void UART1_Write_Text(const char *text);

// Set active UART (used when multiple UART modules are available)
void UART_Set_Active(void (*read_ptr)(void), void (*write_ptr)(char),
                     void (*data_ready_ptr)(void), void (*tx_idle_ptr)(void));

#ifdef __cplusplus
}
#endif

#endif // _UART_H_
