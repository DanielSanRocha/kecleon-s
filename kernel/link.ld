ENTRY(_start)
MEMORY {
    ram : ORIGIN = 0x42000000, LENGTH = 0x100000
}

SECTIONS {
    .text : { *(.text*) } > ram
    _etext = .;
    .data : { *(.data) } > ram
    .bss : { *(.bss*) } > ram
     . = . + 0x1000;
    stack_top = .;
    . = . + 0x1000;
    stack_irq_top = .;
}
