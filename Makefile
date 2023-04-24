.PHONY: help, build

help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

PREFIX = arm-none-eabi

CC = $(PREFIX)-gcc
CC_PARAMS = -Wall -Werror -nostdlib -nostartfiles -fpic -mcpu=cortex-a7 -ffreestanding

AS = $(PREFIX)-as
AS_PARAMS = -mcpu=cortex-a7

LD = $(PREFIX)-ld
OBJCOPY = $(PREFIX)-objcopy
AR = $(PREFIX)-ar

clean: # Cleans the directory, run setup after
	rm -rf kernel/*.o
	rm -rf kernel.bin
	rm -rf kernel.elf

build: # Build the project targetting the cubieboard2 (real hardware)
	$(AS) $(AS_PARAMS) -c kernel/main.s -o kernel/main_s.o
	$(AS) $(AS_PARAMS) -c kernel/interrupts.s -o kernel/interrupts_s.o
	$(CC) $(CC_PARAMS) -c kernel/main.c -o kernel/main_c.o
	$(CC) $(CC_PARAMS) -c kernel/memory.c -o kernel/memory_c.o
	$(CC) $(CC_PARAMS) -c kernel/uart.c -o kernel/uart_c.o
	$(CC) $(CC_PARAMS) -c kernel/interrupts.c -o kernel/interrupts_c.o
	$(CC) $(CC_PARAMS) -c kernel/timer.c -o kernel/timer_c.o
	$(LD) -nostdlib -T kernel/link.ld -o kernel.elf kernel/interrupts_s.o kernel/main_s.o kernel/main_c.o kernel/uart_c.o kernel/memory_c.o kernel/interrupts_c.o kernel/timer_c.o
	$(OBJCOPY) -O binary kernel.elf kernel.bin
