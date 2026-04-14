#  Compilador de Inteiro Literal (CIL)
#  Traduz um arquivo contendo um único inteiro para assembly
#  x86-64, pronto para ser montado com 'as' e 'ld'.

import sys

# Cabeçalho do arquivo assembly gerado 
CABECALHO_ASM = """\
    .section .text
    .globl _inicio

_inicio:
"""

# Rodapé: chama as rotinas de suporte do runtime 
RODAPE_ASM = """\
    call exibe_inteiro
    call encerra

.include "suporte.s"
"""


def gerar_assembly(numero: int) -> str:
    linhas = [CABECALHO_ASM]
    linhas.append(f"    mov ${numero}, %eax\n")
    linhas.append(RODAPE_ASM)
    return "".join(linhas)


def ler_inteiro(caminho: str) -> int:
    try:
        with open(caminho, "r", encoding="utf-8") as arq:
            texto = arq.read().strip()
    except FileNotFoundError:
        sys.stderr.write(f"[erro] arquivo não encontrado: '{caminho}'\n")
        sys.exit(1)

    try:
        return int(texto)
    except ValueError:
        sys.stderr.write(
            f"[erro] o conteúdo de '{caminho}' não é um inteiro válido.\n"
            f"       valor lido: '{texto}'\n"
        )
        sys.exit(1)


def uso():
    print("Uso: python3 compilador.py <arquivo_de_entrada>")
    print("O arquivo deve conter apenas um inteiro (positivo ou negativo).")
    sys.exit(1)


#  Ponto de entrada ─
if __name__ == "__main__":
    if len(sys.argv) != 2:
        uso()

    numero = ler_inteiro(sys.argv[1])
    asm = gerar_assembly(numero)
    sys.stdout.write(asm)
