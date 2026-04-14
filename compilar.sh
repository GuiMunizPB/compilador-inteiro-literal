#!/bin/bash

#  compilar.sh
#  Script de automação do Compilador de Inteiro Literal (CIL)
#  Uso: ./compilar.sh <entrada> <nome_saida>


#    1. Compilação  → gera o assembly via compilador.py
#    2. Montagem    → converte assembly em arquivo objeto (as)
#    3. Link-edição → gera o executável final (ld)

set -e  # aborta imediatamente em caso de erro

# Validação 
if [ "$#" -ne 2 ]; then
    echo "erro: numero de argumentos invalido."
    echo "uso:  ./compilar.sh <arquivo_entrada> <nome_executavel>"
    exit 1
fi

ENTRADA="$1"
NOME="$2"

if [ ! -f "$ENTRADA" ]; then
    echo "erro: arquivo de entrada não encontrado: '$ENTRADA'"
    exit 1
fi

# Diretórios de saída 
DIR_ASM="gerados/asm"
DIR_OBJ="gerados/obj"
DIR_BIN="gerados/bin"

mkdir -p "$DIR_ASM" "$DIR_OBJ" "$DIR_BIN"

#  Caminhos dos artefatos 
ARQ_ASM="$DIR_ASM/${NOME}.s"
ARQ_OBJ="$DIR_OBJ/${NOME}.o"
ARQ_BIN="$DIR_BIN/${NOME}"

#  Etapa 1: compilação 
echo "[ 1/3 ] compilando '$ENTRADA' → '$ARQ_ASM' ..."
python3 compilador.py "$ENTRADA" > "$ARQ_ASM"

#  Etapa 2: montagem 
echo "[ 2/3 ] montando '$ARQ_ASM' → '$ARQ_OBJ' ..."
as --64 -o "$ARQ_OBJ" "$ARQ_ASM"

#  Etapa 3: link-edição 
echo "[ 3/3 ] gerando executável '$ARQ_BIN' ..."
ld -o "$ARQ_BIN" "$ARQ_OBJ"

echo ""
echo "feito, execute com:  $ARQ_BIN"
