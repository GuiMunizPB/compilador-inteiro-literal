    .section .text
    .globl _inicio

_inicio:
    mov $2147483647, %eax
    call exibe_inteiro
    call encerra

.include "suporte.s"
