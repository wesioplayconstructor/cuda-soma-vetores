# Uso de IA Generativa

Este documento descreve o uso de ferramenta de Inteligência Artificial generativa durante o desenvolvimento deste trabalho, conforme as diretrizes da disciplina.

---

## Ferramenta utilizada

| Ferramenta | Uso |
|---|---|
| Ash (Hermes Agent) | Planejamento do trabalho, organização do repositório, explicação de conceitos de CUDA e apoio na revisão dos arquivos do projeto. |

> Até o momento, a única ferramenta de IA generativa usada neste trabalho foi o Ash (Hermes Agent).

---

## Momentos do trabalho em que IA foi usada

### 1. Planejamento e organização do projeto

**Ferramenta:** Ash (Hermes Agent)

**Quando:** Início do trabalho.

**O que fiz:** Usei a IA para organizar as etapas do trabalho, separar as fases de desenvolvimento, criar uma estrutura de pastas e montar um roteiro de execução com checklist.

**O que aprendi:** Aprendi que dividir o trabalho em etapas menores facilita a execução e evita esquecer partes importantes, como código, notebook, resultados, relatório, slides e declaração de uso de IA.

---

### 2. Compreensão dos conceitos de CUDA

**Ferramenta:** Ash (Hermes Agent)

**Quando:** Durante a preparação da versão paralela em CUDA.

**O que fiz:** Usei a IA para esclarecer conceitos como kernel, thread, bloco, grid, memória do host, memória do device, `cudaMalloc`, `cudaMemcpy` e o cálculo do índice global da thread com `blockIdx.x * blockDim.x + threadIdx.x`.

**O que aprendi:** Entendi que cada thread da GPU executa a mesma kernel, mas trabalha em um índice diferente do vetor. Também entendi por que é necessário usar `if (i < N)`, já que o total de threads lançado pode ser maior que o tamanho real do vetor.

---

### 3. Revisão e documentação dos arquivos do repositório

**Ferramenta:** Ash (Hermes Agent)

**Quando:** Durante a organização do repositório GitHub.

**O que fiz:** Usei a IA para revisar e melhorar arquivos de documentação, como `README.md` e este arquivo `USO_DE_IA.md`, além de orientar comandos de Git usando SSH.

**O que aprendi:** Aprendi a deixar o repositório mais organizado e claro para avaliação, separando código, notebook, resultados, relatório, slides e documentação.

---

## Declaração

Declaro que utilizei IA generativa apenas como ferramenta de apoio ao aprendizado, planejamento, documentação e esclarecimento de dúvidas. O código, os resultados e o relatório foram lidos, revisados e compreendidos por mim. Na arguição, sou capaz de explicar as partes do trabalho que foram entregues.

---

*Documento criado em 25/05/2026 e atualizado conforme o andamento do trabalho.*
