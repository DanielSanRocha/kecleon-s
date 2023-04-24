#include "uart.h"
#include "interrupts.h"
#include "timer.h"

void main() {
    uart_print("KecleonS Operating System!\n\n");

    uart_print("Initializing interrupts... ");
    interrupts_initialize();
    uart_print("Initialized!\n");

    uart_print("Initializing timer... ");
    timer_initialize();
    uart_print("Initialized!\n");

    while(1);
}