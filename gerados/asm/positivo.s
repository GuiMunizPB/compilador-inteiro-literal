    .section .text
    .globl _inicio

_inicio:
    mov $42, %eax
    call exibe_inteiro
    call encerra

.include "suporte.s"
