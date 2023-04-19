#ifndef _UART_H_
#define _UART_H_

#ifdef RASPI2B
#define UART_DR 0x3F201000
#endif

#ifdef CUBIEBOARD2
#define UART_DR 0x01C28000
#endif

void uart_print(char* c);

#endif