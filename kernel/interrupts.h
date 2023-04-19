#ifndef _INTERRUPTS_H_
#define _INTERRUPTS_H_

void move_vector_table();
void enable_interrupts();
void disable_interrupts();

void interrupts_initialize();

#endif