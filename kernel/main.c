#include "uart.h"
#include "interrupts.h"
#include "timer.h"

extern void set_irq_stack();

void main() {
    #ifdef RASPI2B
    set_irq_stack();
    #endif

    uart_print("Welcome to Kecleon OS!\n");

    uart_print("Initializing interrupts...");
    interrupts_initialize();
    uart_print("Initialized!\n");

    uart_print("Initializing timer...");
    timer_initialize();
    uart_print("Initialized!\n");
}