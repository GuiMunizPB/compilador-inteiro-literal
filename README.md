# GUILHERME MUNIZ DE OLIVEIRA - 20220054848
# Compilador de Inteiro Literal (CIL)

Compilador simples que traduz um arquivo de texto contendo um único inteiro (positivo ou negativo) direto para assembly x86-64, produzindo um executável nativo via `as` + `ld`.

---

## Como funciona

O pipeline tem três etapas:

```
arquivo .txt ──► compilador.py ──► .s ──► as ──► .o ──► ld ──► executável
```

1. **`compilador.py`** lê o inteiro do arquivo de entrada e emite código assembly AT&T.
2. **`as`** monta o `.s` em um arquivo objeto `.o`.
3. **`ld`** faz a link-edição e gera o binário final.

Ao executar, o programa imprime o inteiro compilado no stdout e encerra.

---

No Ubuntu/Debian:
```bash
sudo apt install binutils
```

---

## Uso rápido

```bash
./compilar.sh <arquivo_entrada> <nome_executavel>

./compilar.sh programas/positivo.txt resultado
```

O executável será salvo em `gerados/bin/resultado`.

---