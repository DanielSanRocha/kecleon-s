#include "peripheral.h"
#include "timer.h"
#include "memory.h"
#include "uart.h"

void timer_initialize() {
    #ifdef RASPI2B
    u32 x = inb((void*) TIMER_COUNTER_LOW);
    outb((void*) TIMER_COMPARE_1, x + 5000);
    #endif

    #ifdef CUBIEBOARD2
    outb((void*) TIMER_REGISTER, 0x1);
    outb((void*) TIMER0_INTV_VALUE_REG, 5000);
    #endif
}

void timer_handler() {
    #ifdef RASPI2B
    outb((void*)TIMER_REGISTER, 2);

    u32 x = inb((void*) TIMER_COUNTER_LOW);
    outb((void*) TIMER_COMPARE_1, x + 5000);
    #endif

    uart_print("fire!");
}
