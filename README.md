# Soma de Vetores em CUDA — CPU vs GPU

Trabalho final individual da disciplina **Arquitetura de Computadores**, comparando o desempenho de uma versão sequencial em **C/CPU** com uma versão paralela em **CUDA/GPU** para a operação de soma de vetores.

---

## Dados do trabalho

- **Aluno:** Wésio Filho
- **Disciplina:** Arquitetura de Computadores
- **Curso:** Bacharelado em Ciência da Computação — 5º Período
- **Professor:** Newarney T. da Costa
- **Período letivo:** 2026/1
- **Tema:** Paralelismo com CUDA — soma de vetores

---

## Objetivo

Implementar a operação:

```c
C[i] = A[i] + B[i]
```

para todos os índices `i` de `0` até `N - 1`, usando duas abordagens:

1. **CPU:** programa sequencial em C com laço `for`.
2. **GPU:** programa paralelo em CUDA com uma thread para cada elemento do vetor.

Depois, medir os tempos de execução, calcular o **speedup** e comparar quando a GPU passa a compensar o custo de transferência de dados.

---

## Estrutura do repositório

```text
cuda-soma-vetores/
├── codigo/
│   ├── soma_cpu.c              # Implementação sequencial em C
│   └── soma_gpu.cu             # Implementação paralela em CUDA
├── notebook/
│   └── benchmark.ipynb         # Notebook local para benchmark e gráficos
├── resultados/                 # Arquivos gerados após executar o benchmark
│   ├── tempos.csv
│   ├── tempos_medios.csv
│   ├── grafico_tempos.png
│   └── grafico_speedup.png
├── relatorio/                  # PDF final do relatório
├── slides/                     # PDF dos slides
├── docs/
│   ├── figuras/
│   └── referencias/
├── README.md
└── USO_DE_IA.md
```

---

## Requisitos para executar em bare metal

Este projeto foi preparado para execução local em uma máquina Linux com GPU NVIDIA.

### Ferramentas necessárias

- `gcc` para compilar a versão CPU.
- `nvcc` do CUDA Toolkit para compilar a versão GPU.
- Driver NVIDIA funcionando.
- Python/Jupyter, caso o notebook de benchmark seja usado.

### Verificar GPU NVIDIA

```fish
nvidia-smi
```

Se o comando mostrar a GPU, o driver está ativo.

### Verificar compiladores

```fish
gcc --version
nvcc --version
```

---

## Como compilar manualmente

Execute os comandos na raiz do repositório:

```fish
cd /home/wesio/Documentos/Faculdade/Arquitetura\ de\ computadores/apresentação\ final/cuda-soma-vetores
```

### Versão CPU

```fish
gcc -std=c11 -O2 -Wall -Wextra codigo/soma_cpu.c -o soma_cpu
```

### Versão GPU

```fish
nvcc -O2 codigo/soma_gpu.cu -o soma_gpu
```

---

## Como executar

### Execução normal

```fish
./soma_cpu 1000000
./soma_gpu 1000000
```

O valor `1000000` representa o tamanho do vetor `N`. Você pode trocar por outros tamanhos:

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

### Modo benchmark

O modo `--benchmark` imprime apenas uma linha com o rótulo e o tempo em milissegundos. Esse modo é usado pelo notebook e por scripts de medição.

```fish
./soma_cpu 1000000 --benchmark
./soma_gpu 1000000 --benchmark
```

Exemplo de saída:

```text
CPU 3.421000
GPU 0.842000
```

---

## Como rodar o notebook local

O notebook em `notebook/benchmark.ipynb` serve para automatizar a compilação, executar os testes e gerar os gráficos.

Na raiz do repositório:

```fish
jupyter notebook notebook/benchmark.ipynb
```

Depois execute as células em ordem. O notebook deve:

1. Verificar a GPU com `nvidia-smi`.
2. Compilar `codigo/soma_cpu.c` com `gcc`.
3. Compilar `codigo/soma_gpu.cu` com `nvcc`.
4. Rodar CPU e GPU para diferentes valores de `N`.
5. Calcular médias e speedup.
6. Gerar os arquivos na pasta `resultados/`.

---

## Metodologia de medição

Foram definidos quatro tamanhos de vetor:

| Tamanho | Quantidade de elementos |
|--------:|--------------------------:|
| 10³     | 1.000                     |
| 10⁵     | 100.000                   |
| 10⁶     | 1.000.000                 |
| 10⁷     | 10.000.000                |

Para cada tamanho, cada versão deve ser executada **5 vezes**. Em seguida, calcula-se a média dos tempos.

- Na **CPU**, o tempo é medido com `clock_gettime`, focando no laço de soma sequencial.
- Na **GPU**, o tempo é medido com `cudaEvent_t`, incluindo transferência host→device, execução da kernel, sincronização e transferência device→host.
- Em ambas as versões, todos os elementos calculados são validados após a medição.

O speedup é calculado por:

```text
speedup = tempo_CPU / tempo_GPU
```

- `speedup > 1`: GPU foi mais rápida.
- `speedup < 1`: CPU foi mais rápida.
- `speedup = 1`: desempenho equivalente.

---

## Resultado esperado da soma

Os primeiros elementos devem seguir este padrão:

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

## Arquivos de resultado

Após executar o notebook ou script de benchmark, os arquivos esperados são:

```text
resultados/tempos.csv
resultados/tempos_medios.csv
resultados/grafico_tempos.png
resultados/grafico_speedup.png
```

O gráfico de tempo compara CPU e GPU em função de `N`. O gráfico de speedup mostra quantas vezes a GPU foi mais rápida que a CPU.

> Observação: os valores podem variar conforme o hardware local, driver NVIDIA, versão do CUDA Toolkit, carga do sistema e modelo da GPU usada.

---

## Conceitos utilizados

- Programação em C.
- CUDA C/C++.
- Kernel CUDA.
- Threads, blocos e grid.
- Memória do host e memória do device.
- Transferência de dados com `cudaMemcpy`.
- Medição de tempo com `clock_gettime` e `cudaEvent_t`.
- Speedup e análise de desempenho.

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

Cada thread calcula um elemento do vetor resultado. O `if (i < N)` impede acesso fora do vetor quando o número total de threads lançadas é maior que `N`.

---

## Uso de IA generativa

O uso do assistente de IA generativa **Ash (Hermes Agent)**, acessado pela **Hermes WebUI**, está documentado no arquivo:

```text
USO_DE_IA.md
```

Esse arquivo informa em quais momentos a IA foi usada, quais modelos online foram informados nas sessões (`Gemma 4`, `GPT-5.5` via API OpenAI, `DeepSeek` via API compatível) e o que foi aprendido com o apoio.

---

## Referências

1. HARRIS, Mark. **An Even Easier Introduction to CUDA**. NVIDIA Technical Blog, 2017. Disponível em: <https://developer.nvidia.com/blog/even-easier-introduction-cuda>.
2. NVIDIA. **CUDA C++ Programming Guide**. Disponível em: <https://docs.nvidia.com/cuda/cuda-c-programming-guide/>.
3. STALLINGS, William. **Arquitetura e Organização de Computadores**. 10. ed. Pearson, 2017.
4. SBC. **Modelos para publicação de artigos**. Disponível em: <https://www.sbc.org.br/documentos-da-sbc/category/169-templates-para-artigos-e-capitulos-de-livros>.

---

## Licença

Projeto desenvolvido exclusivamente para fins acadêmicos na disciplina de Arquitetura de Computadores.
