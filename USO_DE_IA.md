# Uso de IA Generativa

Este documento descreve o uso de ferramentas de Inteligência Artificial generativa durante o desenvolvimento deste trabalho, conforme as diretrizes do professor.

---

## Ferramentas utilizadas

| Ferramenta        | Uso                                              |
|-------------------|--------------------------------------------------|
| Ash (Hermes Agent) | Planejamento do trabalho, estrutura do projeto e esclarecimento de conceitos CUDA |
| ChatGPT / Claude  | Tirar dúvidas pontuais sobre sintaxe C/CUDA e depuração de erros de compilação |

> **Atualizar esta tabela conforme for usando outras ferramentas.**

---

## Momentos do trabalho em que IA foi usada

### 1. Planejamento e estruturação do projeto
**Ferramenta:** Ash (Hermes Agent)
**Quando:** Início do trabalho (Fase 1)
**O que fiz:** Pedi ao Ash para organizar o plano de trabalho, definir a estrutura de pastas do repositório e criar o cronograma com as fases do projeto.
**O que aprendi:** A importância de planejar antes de codificar — ter um plano claro com fases definidas e checklist evita retrabalho e garante que nada seja esquecido.

### 2. Compreensão dos conceitos de CUDA (kernel, threads, blocos, grid)
**Ferramenta:** Ash (Hermes Agent) + documentação NVIDIA
**Quando:** Antes de escrever a versão GPU (Fase 3)
**O que fiz:** Perguntei sobre a diferença entre host e device memory, como funciona o cálculo do índice global de uma thread (`blockIdx.x * blockDim.x + threadIdx.x`), e por que precisamos do `if (i < N)` na kernel.
**O que aprendi:** Cada thread na GPU executa o mesmo código mas com índices diferentes — o paralelismo vem de milhares de threads rodando simultaneamente. A verificação `if (i < N)` é necessária porque o número total de threads pode exceder o tamanho do vetor.

### 3. Depuração de erros de compilação e execução
**Ferramenta:** ChatGPT / Claude
**Quando:** Durante a compilação e execução no Colab (Fases 2–4)
**O que fiz:** Ao encontrar erros de compilação do nvcc ou resultados divergentes entre CPU e GPU, usei a IA para identificar a causa (ex.: esquecimento de `cudaMemcpy`, tipo incorreto de dado) e entender a correção.
**O que aprendi:** Erros em CUDA frequentemente não geram mensagens claras — é preciso entender o fluxo de memória (alocar → copiar → kernel → copiar de volta) para depurar eficazmente.

---

## Declaração

Declaro que todo o código entregue foi por mim compreendido. Na arguição, sou capaz de explicar qualquer linha dos programas apresentados. O conteúdo do relatório foi escrito por mim, com base no meu entendimento dos conceitos — textos gerados por IA foram lidos, compreendidos e reescritos com minhas próprias palavras.

---

*Documento criado em 25/05/2026. Atualizar conforme o andamento do trabalho.*
