#ifndef UARTx_H_
#define UARTx_H_

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void UART1_Init(long baud_rate);

char UART1_Data_Ready(void);

char UART1_Tx_Idle();

char UART1_Read();

void UART1_Read_Text(char *Output, char *Delimiter, char Attempts);

void UART1_Write(char data_);

void UART1_Write_Text(char *UART_text);

#ifdef __cplusplus
}
#endif

#endif // UARTx_H_
