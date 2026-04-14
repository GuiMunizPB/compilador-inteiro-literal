    .section .text
    .globl _inicio

_inicio:
    mov $-7, %eax
    call exibe_inteiro
    call encerra

.include "suporte.s"
