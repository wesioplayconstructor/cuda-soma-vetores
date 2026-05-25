# Soma de Vetores em CUDA

Trabalho final da disciplina **Arquitetura de Computadores** — comparação de desempenho entre CPU (sequencial em C) e GPU (paralelo em CUDA) para a operação de soma de vetores.

**Autor:** Wésio Filho
**Disciplina:** Arquitetura de Computadores — 5º Período
**Professor:** Newarney T. da Costa
**Instituição:** Bacharelado em Ciência da Computação
**Período letivo:** 2026/1

---

## Sobre

Este projeto implementa a soma de dois vetores (`C[i] = A[i] + B[i]`) de duas formas:

- **Versão CPU** (`codigo/soma_cpu.c`): loop sequencial em C
- **Versão GPU** (`codigo/soma_gpu.cu`): kernel CUDA com uma thread por elemento

Em seguida, compara o desempenho das duas versões para diferentes tamanhos de vetor (1.000, 100.000, 1.000.000 e 10.000.000 elementos).

---

## Estrutura do repositório

```
cuda-soma-vetores/
├── codigo/
│   ├── soma_cpu.c          # Versão sequencial (CPU)
│   └── soma_gpu.cu         # Versão paralela (GPU/CUDA)
├── notebook/
│   └── benchmark.ipynb     # Notebook Colab com benchmark + gráficos
├── resultados/
│   ├── tempos.csv          # Dados brutos de tempo
│   ├── grafico_tempos.png  # Gráfico CPU vs GPU (escala log)
│   └── grafico_speedup.png # Gráfico de speedup
├── relatorio/
│   └── relatorio_sbc.pdf   # Artigo no template SBC
├── slides/
│   └── apresentacao.pdf    # Slides de apresentação
├── README.md               # Este arquivo
└── USO_DE_IA.md            # Declaração de uso de IA
```

---

## Como rodar no Google Colab

### Requisitos
- Conta no Google
- Navegador com acesso ao [Google Colab](https://colab.research.google.com)

### Passo a passo

1. **Abrir o notebook:** Clique no badge abaixo ou abra o arquivo `notebook/benchmark.ipynb` diretamente no Colab:

   [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/WESIOFILHO/cuda-soma-vetores/blob/main/notebook/benchmark.ipynb)

2. **Selecionar GPU:** Vá em `Runtime → Change runtime type → T4 GPU` e salve.

3. **Rodar tudo:** Clique em `Runtime → Run all` ou execute cada célula sequencialmente.

4. **Resultados:** Os gráficos e a tabela de tempos serão exibidos nas células do notebook e salvos na pasta `resultados/`.

### Rodando localmente (opcional)

Se você tiver o CUDA Toolkit instalado:

```bash
# Versão CPU
gcc codigo/soma_cpu.c -o soma_cpu
./soma_cpu

# Versão GPU
nvcc codigo/soma_gpu.cu -o soma_gpu
./soma_gpu
```

---

## Resultados esperados

| N          | Tempo CPU (ms) | Tempo GPU (ms) | Speedup |
|------------|----------------|----------------|---------|
| 1.000      | ~0,01          | ~0,1           | < 1     |
| 100.000    | ~0,3           | ~0,2           | ~1–2    |
| 1.000.000  | ~3             | ~0,5           | ~6      |
| 10.000.000 | ~30            | ~2             | ~15     |

> **Nota:** Os valores acima são estimativas. Os tempos reais dependem da carga do Colab no momento da execução.

**Conclusão esperada:** Para vetores pequenos, a CPU é mais rápida (overhead de transferência de dados domina). Para vetores grandes, a GPU é significativamente mais rápida thanks ao paralelismo massivo.

---

## Referências

1. STALLINGS, W. *Arquitetura e organização de computadores.* 10. ed. Pearson, 2017. Cap. 19.
2. NVIDIA. *CUDA C++ Programming Guide.* Disponível em: https://docs.nvidia.com/cuda/cuda-c-programming-guide/
3. HARRIS, M. *An Even Easier Introduction to CUDA.* NVIDIA Blog, 2017. Disponível em: https://developer.nvidia.com/blog/even-easier-introduction-cuda

---

## Licença

Este projeto é de uso acadêmico, desenvolvido para a disciplina de Arquitetura de Computadores.
