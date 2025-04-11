#ifndef _P18F4550_H_
#define _P18F4550_H_

#include <stdint.h>

#define PORTA (*((volatile uint8_t *)0xF80))
#define PORTB (*((volatile uint8_t *)0xF81))
#define PORTC (*((volatile uint8_t *)0xF82))
#define PORTD (*((volatile uint8_t *)0xF83))
#define PORTE (*((volatile uint8_t *)0xF84))

#define TRISA (*((volatile uint8_t *)0xF92))
#define TRISB (*((volatile uint8_t *)0xF93))
#define TRISC (*((volatile uint8_t *)0xF94))
#define TRISD (*((volatile uint8_t *)0xF95))
#define TRISE (*((volatile uint8_t *)0xF96))

#define LATA (*((volatile uint8_t *)0xF89))
#define LATB (*((volatile uint8_t *)0xF8A))
#define LATC (*((volatile uint8_t *)0xF8B))
#define LATD (*((volatile uint8_t *)0xF8C))
#define LATE (*((volatile uint8_t *)0xF8D))

#define ADCON0 (*((volatile uint8_t *)0xFC2))
#define ADCON1 (*((volatile uint8_t *)0xFC1))
#define ADCON2 (*((volatile uint8_t *)0xFC0))

#define CMCON (*((volatile uint8_t *)0x0FB4))

#define T0CON (*((volatile uint8_t *)0xFD5))
#define T1CON (*((volatile uint8_t *)0xFCD))
#define T2CON (*((volatile uint8_t *)0xFCA))

#define INTCON (*((volatile uint8_t *)0xFF2))
#define INTCON2 (*((volatile uint8_t *)0xFF1))
#define INTCON3 (*((volatile uint8_t *)0xFF0))

#define PIR1 (*((volatile uint8_t *)0x0F9E))
#define RCSTA (*((volatile uint8_t *)0x0FAB))
#define TXREG (*((volatile uint8_t *)0x0FAD))
#define RCREG (*((volatile uint8_t *)0x0FAE))

#define RCIE_bit (INTCON & 0x20)
#define RCIF_bit (INTCON & 0x10)
#define TXIF_bit (INTCON & 0x08)
#define OERR_bit (RCSTA & 0x02)
#define CREN_bit (RCSTA & 0x01)

void Delay_ms(uint16_t milliseconds);

#endif // _P18F4550_H_
