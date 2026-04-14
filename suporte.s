  # suporte.s  –  rotinas de suporte para o código compilado
  #
  # Exporta:
  #   exibe_inteiro  – imprime %eax como decimal + newline
  #   encerra        – encerra o processo com código 0

exibe_inteiro:
  # Prepara contadores e marca o final da área de impressão
  xor  %r9,  %r9              # r9  = qtd. de dígitos (+ sinal)
  mov  $20,  %rcx             # rcx = idx dentro de 'saida'
  movb $10,  saida(%rcx)      # '\n' na posição final
  dec  %rcx
  inc  %r9

  mov  $10,  %r8              # divisor decimal
  or   %rax, %rax
  jz   .imprimir_zero
  jl   .marcar_negativo
  xor  %r10, %r10             # r10 = 0 → numero positivo
  jmp  .extrair_digitos

.marcar_negativo:
  mov  $1,   %r10             # r10 = 1 → numero negativo
  neg  %rax

.extrair_digitos:
  cqo
  idiv %r8
  addb $0x30, %dl             # converte resto em ASCII
  movb %dl,   saida(%rcx)
  dec  %rcx
  inc  %r9
  or   %rax, %rax
  jnz  .extrair_digitos
  test %r10, %r10
  jz   .imprimir
  movb $45,  saida(%rcx)      # '-' para negativos
  dec  %rcx
  jmp  .imprimir

.imprimir_zero:
  movb $0x30, saida(%rcx)     # '0'
  dec  %rcx
  inc  %r9

.imprimir:
  mov  $1,       %rax         # sys_write
  mov  $1,       %rdi         # stdout
  mov  $saida,   %rsi
  inc  %rcx
  add  %rcx,     %rsi         # aponta para o 1º dígito
  mov  %r9,      %rdx         # número de bytes
  syscall
  ret

encerra:
  mov $60,  %rax              # sys_exit
  xor %rdi, %rdi              # código de saída = 0
  syscall


  .section .bss
  .lcomm saida, 21
