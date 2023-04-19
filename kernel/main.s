.extern main
.global _start

_start:
    ldr sp, =stack_top
    BL main
    B  .
