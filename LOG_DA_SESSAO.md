# 📋 LOG DA SESSÃO — Projeto: Soma de Vetores em CUDA

**Data:** 26 de maio de 2026  
**Agente:** Ash (Servo-Sensei) 🔥  
**Contexto:** Finalização do projeto final individual de Arquitetura de Computadores  
**Repositório:** https://github.com/wesioplayconstructor/cuda-soma-vetores

---

## 🎯 Status Geral do Projeto

| Item | Status | Observação |
|------|--------|-----------|
| `codigo/soma_cpu.c` | ✅ Pronto | Código CPU sequencial compilado com `gcc` |
| `codigo/soma_gpu.cu` | ✅ Pronto | Código GPU CUDA compilado com `nvcc` |
| `notebook/benchmark.ipynb` | ✅ Atualizado | Fluxo local/bare metal, sem serviço externo como caminho principal e sem dependência de `pandas` |
| `README.md` | ✅ Atualizado | Instruções locais com `gcc`, `nvcc`, `nvidia-smi`, Jupyter e `matplotlib` |
| `USO_DE_IA.md` | ✅ Atualizado | Preserva Gemma 4, GPT-5.5 e DeepSeek; adiciona Qwen 3.5 9B |
| Resultados CSV | ✅ Presentes | `resultados/tempos.csv` e `resultados/tempos_medios.csv` |
| Gráficos PNG | ✅ Presentes | `grafico_tempos.png`, `grafico_speedup.png`, `grid-blocks-threads.png` |
| Relatório PDF | ✅ Compilado | `relatorio/relatorio_sbc.pdf`, 10 páginas |
| Slides PDF | ✅ Compilado | `slides/apresentacao.pdf`, 12 slides |
| GitHub | ✅ Atualizado | Commit/push final realizado após verificação |

---

## 🧪 Verificações feitas nesta finalização

### Código

```text
gcc -std=c11 -O2 -Wall -Wextra codigo/soma_cpu.c -o soma_cpu
nvcc -O2 codigo/soma_gpu.cu -o soma_gpu
```

Resultado:

- ✅ Compilação CPU concluída.
- ✅ Compilação GPU concluída.
- ✅ Smoke test CPU com `N=10` validou os primeiros resultados.
- ⚠️ Smoke test GPU não foi repetido nesta sessão porque a VRAM estava ocupada pelo próprio ambiente local de IA/Hermes/Qwen, causando `cudaMemGetInfo: out of memory`. O código CUDA compilou; para rerodar benchmark real, liberar a VRAM antes de executar `./soma_gpu` ou o notebook.

### Relatório

```text
pdflatex -> bibtex -> pdflatex -> pdflatex
pdfinfo main.pdf
pdftotext main.pdf - | wc -l
```

Resultado:

- ✅ Sem erros LaTeX críticos no log.
- ✅ PDF gerado com 10 páginas.
- ✅ Texto extraído com conteúdo real (~393 linhas).
- ✅ Ambiente corrigido para notebook Acer Nitro V15 + RTX 4050 Laptop GPU + CachyOS.

### Slides

```text
pdflatex apresentacao.tex
pdfinfo apresentacao.pdf
```

Resultado:

- ✅ Slides recompilados sem erros críticos.
- ✅ PDF gerado com 12 páginas/slides.
- ✅ Slides usam gráficos e diagrama reais do projeto.

---

## 📊 Dados de Benchmark registrados

| N | CPU (ms) | GPU (ms) | Speedup |
|---:|---:|---:|---:|
| 1.000 | 0,0042 | 0,1681 | 0,02x |
| 100.000 | 0,3207 | 0,2076 | 1,54x |
| 1.000.000 | 3,1630 | 0,3349 | 9,45x |
| 10.000.000 | 31,4850 | 0,5917 | 53,21x |

---

## 📦 Arquivos finais principais

```text
cuda-soma-vetores/README.md
cuda-soma-vetores/USO_DE_IA.md
cuda-soma-vetores/codigo/soma_cpu.c
cuda-soma-vetores/codigo/soma_gpu.cu
cuda-soma-vetores/notebook/benchmark.ipynb
cuda-soma-vetores/resultados/tempos.csv
cuda-soma-vetores/resultados/tempos_medios.csv
cuda-soma-vetores/resultados/grafico_tempos.png
cuda-soma-vetores/resultados/grafico_speedup.png
cuda-soma-vetores/relatorio/relatorio_sbc.pdf
cuda-soma-vetores/slides/apresentacao.pdf
```

---

## 📝 Próximo passo manual no Moodle

Enviar:

1. Link do GitHub: https://github.com/wesioplayconstructor/cuda-soma-vetores
2. PDF do relatório: `relatorio/relatorio_sbc.pdf`
3. PDF dos slides: `slides/apresentacao.pdf`

---

*Documento atualizado por Ash 🔥 — 26/05/2026*
