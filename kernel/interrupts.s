vector_table:
    ldr pc,reset_handler_ptr
    ldr pc,undefined_handler_ptr
    ldr pc,swi_handler_ptr
    ldr pc,prefetch_handler_ptr
    ldr pc,data_handler_ptr
    ldr pc,unused_handler_ptr
    ldr pc,irq_handler_ptr
    ldr pc,fiq_handler_ptr

reset_handler_ptr:      .word _start
undefined_handler_ptr:  .word undefined_handler
swi_handler_ptr:        .word swi_handler
prefetch_handler_ptr:   .word prefetch_handler
data_handler_ptr:       .word data_handler
unused_handler_ptr:     .word unused_handler
irq_handler_ptr:        .word irq_wrapper_handler
fiq_handler_ptr:        .word fiq_handler

.global move_vector_table
move_vector_table:
    push {r0-r9}
    cpsid i
    mov r0,#0x42000000
    mov r1,#0x0000
    ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
    ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}

    pop {r0-r9}
    bx  lr

.global enable_interrupts
enable_interrupts:
    cpsie i
    bx lr

.global disable_interrupts
disable_interrupts:
    cpsid i
    bx    lr

.extern irq_handler
irq_wrapper_handler:
    push {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
    bl irq_handler
    pop {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
    subs pc,lr,#4
