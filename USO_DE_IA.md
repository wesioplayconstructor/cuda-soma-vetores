# Uso de IA Generativa

Este documento descreve o uso de Inteligência Artificial generativa durante o desenvolvimento deste trabalho, conforme as diretrizes da disciplina.

---

## Ferramenta, ambiente e modelos utilizados

| Ferramenta/assistente | Ambiente | Modelos/motores informados | Uso no trabalho |
|---|---|---|---|
| Ash (Hermes Agent) | Hermes WebUI | Modelos online acessados pelo Hermes, incluindo `Gemma 4` (`gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M`), `GPT-5.5` via API OpenAI e `DeepSeek` via API compatível com OpenAI | Planejamento do trabalho, organização do repositório, explicação de conceitos de CUDA, revisão do código e documentação final. |

> A ferramenta/assistente utilizada no trabalho foi o **Ash (Hermes Agent)** pela **Hermes WebUI**. Os modelos online informados variaram conforme a sessão, incluindo `Gemma 4`, `GPT-5.5` (via API OpenAI) e `DeepSeek` (via API compatível com OpenAI).

---

## Ambiente e modelos utilizados

Durante o apoio ao trabalho, utilizei o assistente **Ash (Hermes Agent)** acessado pela **Hermes WebUI**.

Ao longo das sessões, os modelos/motores informados foram:

```text
Gemma 4 — gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M
GPT-5.5 — via API OpenAI
DeepSeek — via API compatível com OpenAI
```

Não utilizei GitHub Copilot, Claude, ChatGPT nem Codex como ferramentas autônomas para este trabalho. A programação, revisão e orientação foram feitas por meio do Ash/Hermes Agent.

---

## Momentos do trabalho em que IA foi usada

### 1. Planejamento e organização do projeto

**Ferramenta:** Ash (Hermes Agent)

**Ambiente/modelo:** Hermes WebUI com `gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M`

**Quando:** Início do trabalho.

**O que fiz:** Usei a IA para organizar as etapas do trabalho, separar as fases de desenvolvimento, criar uma estrutura de pastas e montar um roteiro de execução com checklist.

**O que aprendi:** Aprendi que dividir o trabalho em etapas menores facilita a execução e evita esquecer partes importantes, como código, notebook, resultados, relatório, slides e declaração de uso de IA.

---

### 2. Compreensão dos conceitos de CUDA

**Ferramenta:** Ash (Hermes Agent)

**Ambiente/modelo:** Hermes WebUI com `gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M`

**Quando:** Durante a preparação da versão paralela em CUDA.

**O que fiz:** Usei a IA para esclarecer conceitos como kernel, thread, bloco, grid, memória do host, memória do device, `cudaMalloc`, `cudaMemcpy` e o cálculo do índice global da thread com `blockIdx.x * blockDim.x + threadIdx.x`.

**O que aprendi:** Entendi que cada thread da GPU executa a mesma kernel, mas trabalha em um índice diferente do vetor. Também entendi por que é necessário usar `if (i < N)`, já que o total de threads lançado pode ser maior que o tamanho real do vetor.

---

### 3. Revisão e melhoria do código e do notebook

**Ferramenta:** Ash (Hermes Agent)

**Ambiente/modelo:** Hermes WebUI com `GPT-5.5` (via API OpenAI) e posteriormente `DeepSeek` (via API compatível com OpenAI)

**Quando:** Durante a revisão dos arquivos `soma_cpu.c`, `soma_gpu.cu` e `benchmark.ipynb`.

**O que fiz:** Usei a IA para revisar o código, identificar inconsistências, melhorar a validação dos resultados, ajustar o modo de benchmark, organizar o notebook para usar os arquivos reais do repositório e evitar duplicação de código.

**O que aprendi:** Aprendi que um benchmark precisa ter saída fácil de interpretar, validação correta dos resultados e consistência entre o código entregue no repositório e o código executado no notebook.

---

### 4. Documentação e organização do repositório

**Ferramenta:** Ash (Hermes Agent)

**Ambiente/modelo:** Hermes WebUI com `GPT-5.5` (via API OpenAI) e posteriormente `DeepSeek` (via API compatível com OpenAI)

**Quando:** Durante a organização final do repositório GitHub.

**O que fiz:** Usei IA para revisar e melhorar arquivos de documentação, como `README.md` e este arquivo `USO_DE_IA.md`, deixando claro como executar o projeto e como a IA foi utilizada.

**O que aprendi:** Aprendi a deixar o repositório mais organizado e claro para avaliação, separando código, notebook, resultados, relatório, slides e documentação, e registrando de forma transparente o uso de IA.

---

## Declaração

Declaro que utilizei IA generativa apenas como ferramenta de apoio ao aprendizado, planejamento, documentação, revisão de código e esclarecimento de dúvidas. O código, os resultados e o relatório foram lidos, revisados e compreendidos por mim. Na arguição, sou capaz de explicar as partes do trabalho que foram entregues.

---

*Documento criado em 25/05/2026 e atualizado em 25/05/2026 conforme o andamento do trabalho.*
