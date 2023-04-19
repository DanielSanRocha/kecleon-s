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

setup: # Create the disk.img file
	mkdir -p mnt
	dd if=/dev/zero of=disk.img bs=1M count=128
	fdisk disk.img

clean: # Cleans the directory, run setup after
	rm -rf kernel/*.o
	rm -rf disk.img
	rm -rf kernel.bin
	rm -rf kernel.elf
	rm -rf mnt

build: # Build the project targetting the raspi2b(qemu)
	$(AS) $(AS_PARAMS) -c kernel/main.s -o kernel/main_s.o
	$(CC) $(CC_PARAMS) -c kernel/main.c -o kernel/main_c.o
	$(CC) $(CC_PARAMS) -c kernel/memory.c -o kernel/memory_c.o
	$(CC) $(CC_PARAMS) -c kernel/uart.c -o kernel/uart_c.o -D RASPI2B
	$(LD) -nostdlib -T kernel/raspi2b.ld -o kernel.elf kernel/main_s.o kernel/main_c.o kernel/uart_c.o kernel/memory_c.o
	$(OBJCOPY) -O binary kernel.elf kernel.bin

build-cubieboard2: # Build the project targetting the cubieboard2 (real hardware)
	$(AS) $(AS_PARAMS) -c kernel/main.s -o kernel/main_s.o
	$(CC) $(CC_PARAMS) -c kernel/main.c -o kernel/main_c.o
	$(CC) $(CC_PARAMS) -c kernel/memory.c -o kernel/memory_c.o
	$(CC) $(CC_PARAMS) -c kernel/uart.c -o kernel/uart_c.o -D CUBIEBOARD2
	$(LD) -nostdlib -T kernel/cubieboard2.ld -o kernel.elf kernel/main_s.o kernel/main_c.o kernel/uart_c.o kernel/memory_c.o
	$(OBJCOPY) -O binary kernel.elf kernel.bin

run: build # Run the project on qemu
	sync
	qemu-system-arm -cpu cortex-a7 -M raspi2b -kernel kernel.bin -sd disk.img -no-reboot -monitor telnet:127.0.0.1:1234,server,nowait -serial stdio

debug: build # Run the project on qemu on debug mode
	sync
	qemu-system-arm -s -S -cpu cortex-a7 -M raspi2b -kernel kernel.bin -sd disk.img -no-reboot -monitor telnet:127.0.0.1:1235,server,nowait -serial stdio