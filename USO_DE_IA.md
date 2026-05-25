# Uso de IA Generativa

Este documento descreve o uso de ferramentas de Inteligência Artificial generativa durante o desenvolvimento deste trabalho, conforme as diretrizes da disciplina.

---

## Ferramentas, ambientes e modelos utilizados

| Ferramenta/assistente | Ambiente | Modelo/motor informado | Uso no trabalho |
|---|---|---|---|
| Ash (Hermes Agent) | Hermes WebUI | `gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M` | Planejamento inicial do trabalho, organização do repositório, explicação de conceitos de CUDA e apoio na revisão dos arquivos do projeto. |
| Codex | Ambiente Codex | `GPT-5.5` | Refinamento posterior da documentação, correção da declaração de uso de IA e apoio na organização final do repositório. |

> O trabalho começou com o assistente Ash executado via Hermes Agent/Hermes WebUI e, posteriormente, passou a usar o Codex com o modelo/motor GPT-5.5.

---

## Ambiente e modelos utilizados

Durante o apoio ao trabalho, foram utilizados dois ambientes de IA generativa:

1. **Ash no Hermes Agent/WebUI**, com o modelo/motor informado pela sessão:

```text
gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M
```

2. **Codex**, com o modelo/motor informado pelo usuário durante a continuidade do trabalho:

```text
GPT-5.5
```

Esse registro é incluído para deixar transparente quais ambientes e modelos de IA foram usados no processo de planejamento, revisão e documentação do projeto.

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

### 3. Revisão e documentação dos arquivos do repositório

**Ferramentas:** Ash (Hermes Agent) e Codex

**Ambientes/modelos:** Hermes WebUI com `gemma-4-E2B-it-Q8_0-mtp-E2B-Q4_K_M` e Codex com `GPT-5.5`

**Quando:** Durante a organização e o refinamento do repositório GitHub.

**O que fiz:** Usei IA para revisar e melhorar arquivos de documentação, como `README.md` e este arquivo `USO_DE_IA.md`, além de orientar comandos de Git usando SSH.

**O que aprendi:** Aprendi a deixar o repositório mais organizado e claro para avaliação, separando código, notebook, resultados, relatório, slides e documentação, e registrando de forma transparente o uso de IA.

---

## Declaração

Declaro que utilizei IA generativa apenas como ferramenta de apoio ao aprendizado, planejamento, documentação e esclarecimento de dúvidas. O código, os resultados e o relatório foram lidos, revisados e compreendidos por mim. Na arguição, sou capaz de explicar as partes do trabalho que foram entregues.

---

*Documento criado em 25/05/2026 e atualizado conforme o andamento do trabalho.*
