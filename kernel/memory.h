#ifndef _MEMORY_H_
#define _MEMORY_H_

#include "types.h"

u32 inb(void* addr);
void outb(void* addr, u32 data);

#endif