.extern main
.global _start

_start:
    ldr sp, =stack_top

    BL main
    B  .

.global set_irq_stack
set_irq_stack:
    cps #0x12
    ldr sp, =stack_irq_top
    cps #0x13
    bx lr
