.extern main
.global _start

_start:
    mrc p15, 0, r0, c0, c0, 5
    and r0, r0, #0x1
    cmp r0,#0x1
    bne core_zero
    b   .

core_zero:
    ldr sp, =stack_top

    BL main
    B  .
