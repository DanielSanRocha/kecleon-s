#include "peripheral.h"
#include "memory.h"
#include "uart.h"

void* UART_PTR = (void*) UART_DR;

void uart_putc(char c) {
    unsigned int status = inb((void*) UART_LSR);

    while(!(status & (1 << 5))) {
        status = inb((void*) UART_LSR);
    }

    if(c=='\n') {
        outb(UART_PTR, (u32) '\r');
    }

    outb(UART_PTR, (u32) c);
}

void uart_print(char* str) {
    for(u32 i = 0;str[i] != '\0'; i++) {
        uart_putc(str[i]);
    }
}
