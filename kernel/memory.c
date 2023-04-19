#include "memory.h"

u32 inb(void* addr) {
    u32* addr2 = (u32*) addr;
    return *addr2;
}

void outb(void* addr, u32 data) {
    u32* addr2 = (u32*) addr;
    *addr2 = data;
}
