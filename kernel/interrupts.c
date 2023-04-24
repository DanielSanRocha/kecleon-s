#include "peripheral.h"
#include "interrupts.h"
#include "memory.h"
#include "uart.h"
#include "timer.h"

void irq_handler(void) {
    timer_handler();
}

void interrupts_initialize() {
    move_vector_table();
    outb((void*) INTERRUPTS_SETENABLE_REG, 2);

    enable_interrupts();
}

void __attribute__((interrupt("UNDEF"))) undefined_handler(void) {
    uart_print("UNDEF!");
    while(1);
}

void __attribute__((interrupt("IRQ"))) swi_handler(void) {
    uart_print("SWI!");
}

void __attribute__((interrupt("ABORT"))) prefetch_handler(void) {
    uart_print("ABORT!");
    while(1);
}

void __attribute__((interrupt("ABORT"))) data_handler(void) {
    uart_print("ABORT!");
    while(1);
}

void __attribute__((interrupt("UNDEF"))) unused_handler(void) {
    uart_print("UNDEF!");
    while(1);
}

void __attribute__((interrupt("FIQ"))) fiq_handler(void) {
    uart_print("FIQ!");
    while(1);
}
