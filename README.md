# Soma de Vetores em CUDA — CPU vs GPU

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/wesioplayconstructor/cuda-soma-vetores/blob/main/notebook/benchmark.ipynb)

Trabalho final individual da disciplina **Arquitetura de Computadores**, com comparação de desempenho entre uma versão sequencial em **C/CPU** e uma versão paralela em **CUDA/GPU** para soma de vetores.

---

## Dados do trabalho

- **Aluno:** Wésio Filho
- **Disciplina:** Arquitetura de Computadores
- **Curso:** Bacharelado em Ciência da Computação — 5º Período
- **Professor:** Newarney T. da Costa
- **Período letivo:** 2026/1
- **Tema:** Paralelismo com CUDA — soma de vetores

---

## Problema

Dados dois vetores `A` e `B`, ambos com `N` elementos do tipo `float`, calcular um terceiro vetor `C` da seguinte forma:

```c
C[i] = A[i] + B[i]
```

para todo `i` de `0` até `N - 1`.

Neste projeto, a operação é implementada de duas formas:

1. **CPU:** versão sequencial em C, usando um laço `for`.
2. **GPU:** versão paralela em CUDA, usando uma kernel com uma thread por elemento.

---

## Estrutura do repositório

```text
cuda-soma-vetores/
├── codigo/
│   ├── soma_cpu.c              # Implementação sequencial em C
│   └── soma_gpu.cu             # Implementação paralela em CUDA
├── notebook/
│   └── benchmark.ipynb         # Notebook para executar no Google Colab
├── resultados/                 # Arquivos gerados pelo notebook
│   ├── tempos.csv              # Gerado após executar o benchmark
│   ├── grafico_tempos.png      # Gerado após executar o benchmark
│   └── grafico_speedup.png     # Gerado após executar o benchmark
├── relatorio/                  # Relatório final no template SBC
│   └── relatorio_sbc.pdf       # Adicionado na etapa final
├── slides/                     # Slides da apresentação
│   └── apresentacao.pdf        # Adicionado na etapa final
├── docs/
│   ├── figuras/                # Figuras usadas no relatório/slides
│   └── referencias/            # Materiais de referência
├── README.md
└── USO_DE_IA.md
```

---

## Como executar no Google Colab

### 1. Abrir o notebook

Clique no botão abaixo:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/wesioplayconstructor/cuda-soma-vetores/blob/main/notebook/benchmark.ipynb)

Ou acesse manualmente:

```text
notebook/benchmark.ipynb
```

### 2. Ativar GPU

No Colab:

```text
Runtime → Change runtime type → T4 GPU → Save
```

Depois, rode a célula:

```bash
!nvidia-smi
```

Se a GPU estiver ativa, o Colab mostrará informações da placa NVIDIA T4.

### 3. Rodar o notebook

No Colab:

```text
Runtime → Run all
```

O notebook compila os programas, executa os testes, mede os tempos e gera os gráficos.

---

## Como compilar manualmente

### Versão CPU

```fish
gcc -std=c11 -O2 -Wall -Wextra codigo/soma_cpu.c -o soma_cpu
./soma_cpu 1000000
```

### Versão GPU

```fish
nvcc -O2 codigo/soma_gpu.cu -o soma_gpu
./soma_gpu 1000000
```

O valor `1000000` representa o tamanho do vetor `N`. Ele pode ser alterado para outros tamanhos, como:

```fish
./soma_cpu 1000
./soma_cpu 100000
./soma_cpu 1000000
./soma_cpu 10000000

./soma_gpu 1000
./soma_gpu 100000
./soma_gpu 1000000
./soma_gpu 10000000
```

Para o modo usado pelo notebook de benchmark, os programas também aceitam a opção `--benchmark`, que imprime apenas uma linha fácil de processar:

```fish
./soma_cpu 1000000 --benchmark
./soma_gpu 1000000 --benchmark
```

Saída esperada nesse modo:

```text
CPU 3.421000
GPU 0.842000
```

---

## Metodologia de medição

Foram testados quatro tamanhos de vetor:

| Tamanho | Quantidade de elementos |
|--------:|--------------------------:|
| 10³     | 1.000                     |
| 10⁵     | 100.000                   |
| 10⁶     | 1.000.000                 |
| 10⁷     | 10.000.000                |

Para cada tamanho, cada versão foi executada **5 vezes**. Em seguida, foi calculada a média dos tempos.

- Na **CPU**, o tempo é medido com `clock_gettime` apenas no laço de soma sequencial.
- Na **GPU**, o tempo é medido com `cudaEvent_t` incluindo transferência host→device, execução da kernel, sincronização e transferência device→host.
- Em ambas as versões, todos os elementos calculados são validados após a medição.
- O speedup é calculado por:

```text
speedup = tempo_CPU / tempo_GPU
```

---

## Saídas esperadas

Os primeiros resultados devem seguir o padrão:

```text
C[0] = 0 + 0 = 0
C[1] = 1 + 2 = 3
C[2] = 2 + 4 = 6
C[3] = 3 + 6 = 9
C[4] = 4 + 8 = 12
```

Isso acontece porque:

```text
A[i] = i
B[i] = 2*i
C[i] = A[i] + B[i] = 3*i
```

Exemplo:

```text
C[3] = 3 + 6 = 9
```

---

## Resultados

Após executar o notebook, os seguintes arquivos são gerados:

```text
resultados/tempos.csv
resultados/grafico_tempos.png
resultados/grafico_speedup.png
```

O gráfico de tempo compara CPU e GPU em função de `N`, usando escala logarítmica. O gráfico de speedup mostra quantas vezes a GPU foi mais rápida do que a CPU.

> Observação: os valores podem variar de acordo com a carga do Google Colab e a GPU disponibilizada no momento da execução.

---

## Conceitos utilizados

- Programação em C
- CUDA C/C++
- Kernel CUDA
- Threads, blocos e grid
- Memória do host e memória do device
- Transferência de dados com `cudaMemcpy`
- Medição de tempo com `clock_gettime` e `cudaEvent_t`
- Speedup e análise de desempenho

---

## Arquivos principais

### `codigo/soma_cpu.c`

Implementa a soma de vetores na CPU usando um laço sequencial:

```c
for (int i = 0; i < N; i++) {
    C[i] = A[i] + B[i];
}
```

### `codigo/soma_gpu.cu`

Implementa a soma de vetores na GPU usando uma kernel CUDA:

```cuda
__global__ void somaVetores(const float *A, const float *B, float *C, int N) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
        C[i] = A[i] + B[i];
    }
}
```

Cada thread calcula um elemento do vetor resultado.

---

## Uso de IA generativa

O uso do assistente de IA generativa **Ash (Hermes Agent)**, acessado pela **Hermes WebUI**, está documentado no arquivo:

```text
USO_DE_IA.md
```

Esse arquivo informa em quais momentos a IA foi usada, quais modelos/motores foram informados nas sessões (`gemma-4`, `GPT-5.5` via API OpenAI, `DeepSeek` via API compatível) e o que foi aprendido com o apoio.

---

## Referências

1. HARRIS, Mark. **An Even Easier Introduction to CUDA**. NVIDIA Technical Blog, 2017. Disponível em: <https://developer.nvidia.com/blog/even-easier-introduction-cuda>.
2. NVIDIA. **CUDA C++ Programming Guide**. Disponível em: <https://docs.nvidia.com/cuda/cuda-c-programming-guide/>.
3. STALLINGS, William. **Arquitetura e Organização de Computadores**. 10. ed. Pearson, 2017.
4. SBC. **Modelos para publicação de artigos**. Disponível em: <https://www.sbc.org.br/documentos-da-sbc/category/169-templates-para-artigos-e-capitulos-de-livros>.

---

## Licença

Projeto desenvolvido exclusivamente para fins acadêmicos na disciplina de Arquitetura de Computadores.
