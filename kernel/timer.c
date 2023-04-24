#include "peripheral.h"
#include "timer.h"
#include "memory.h"
#include "uart.h"

void timer_initialize() {
    outb((void*) TIMER_IRQ_EN_REG, 0x1);
    outb((void*) TIMER0_INTV_VALUE_REG, 5000);
    // outb((void*) TIMER0_CUR_VALUE_REG, 50);
    outb((void*) TIMER0_CTRL_REG, 0x1);
}

void timer_handler() {
    uart_print("fire!");
}
