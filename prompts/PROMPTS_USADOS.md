# Prompts usados no projeto

Projeto: **Soma de Vetores em CUDA — CPU vs GPU**

Aluno: **Wésio Filho**

Disciplina: **Arquitetura de Computadores**

Professor: **Newarney T. da Costa**


---


## Observação


Este arquivo reúne os prompts usados/registrados durante a finalização do projeto, conforme solicitado para transparência no uso de IA.

Os prompts foram mantidos em português e preservam as restrições do trabalho: projeto individual, execução local/bare metal, relatório em PDF e slides gerados a partir do relatório.


---


## Índice


1. Prompt de retomada do projeto

2. Prompt para Notebook LLM gerar/revisar novo PDF LaTeX do relatório

3. Prompt inicial para gerar slides a partir do relatório PDF

4. Prompt final para NotebookLM gerar slides seguindo o PDF do relatório


---


# 1. Prompt de retomada do projeto


**Arquivo original:** `/home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/PROMPT_RETOMADA.md`


---


# Prompt de Retomada — Projeto CUDA Soma de Vetores

Use este prompt depois de resetar a conversa ou iniciar uma nova sessão do Ash/Hermes.

---

## Prompt para colar na nova conversa

```text
Leia primeiro estes dois arquivos do workspace do trabalho, nesta ordem:

1. /home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/RESUMO_PARA_RESET.md
2. /home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/LOG_DA_SESSAO.md

Depois de ler, assuma o contexto do projeto final de Arquitetura de Computadores: Soma de Vetores em CUDA, versão individual.

Regras importantes:

- Não refaça o que já foi feito.
- Não reescreva código, relatório, README, slides ou arquivos do GitHub sem eu pedir.
- Primeiro confira o estado real dos arquivos quando precisar.
- O workspace do trabalho é:
  /home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final
- O repositório local é:
  /home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/cuda-soma-vetores
- O GitHub é:
  https://github.com/wesioplayconstructor/cuda-soma-vetores

Lembretes importantes sobre minhas preferências:

- Eu, Wésio, quero fazer o trabalho sozinho; você deve orientar, revisar e explicar.
- Evite embroma.
- Use português do Brasil.
- Use explicações claras, visuais e diretas, porque tenho TDAH e autismo.
- Pode usar analogias gamer/anime, mas sem exagerar.
- O fluxo principal do projeto é local/bare metal, não Google Colab.
- M4A/M4P são áudio, não vídeo.
- Quando eu falar para ouvir áudio, normalmente quero analisar/transcrever o áudio existente, não gerar outro áudio.
- Nunca apague ferramentas/modelos realmente usados do USO_DE_IA.md; apenas adicione novas informações se necessário.
- Modelos usados que devem permanecer registrados: Gemma 4, GPT-5.5 e DeepSeek.

Estado conhecido pelo último handoff:

- Código CPU e GPU prontos.
- Notebook benchmark pronto.
- Resultados CSV e gráficos prontos.
- Relatório SBC em PDF pronto.
- Slides em PDF prontos.
- GitHub atualizado.
- Áudio do NotebookLM analisado por transcrição + Gemma 4.

Depois de ler os dois arquivos, responda somente com:

1. Um resumo curto do estado atual.
2. O que falta verificar antes da entrega no Moodle.
3. Pergunte qual próximo passo eu quero fazer.
```

---

## Arquivos que este prompt depende

```text
/home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/RESUMO_PARA_RESET.md
/home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/LOG_DA_SESSAO.md
```

---

## Observação para o Ash/Hermes

Se houver conflito entre o `RESUMO_PARA_RESET.md` e o `LOG_DA_SESSAO.md`, trate o `LOG_DA_SESSAO.md` como o registro mais direto do status final de entrega, mas confirme no sistema de arquivos antes de afirmar que algo está pronto.

---

*Criado para reduzir contexto e permitir continuar o projeto sem depender da conversa longa anterior.*


---


# 2. Prompt para Notebook LLM gerar/revisar novo PDF LaTeX do relatório


**Arquivo original:** `/home/wesio/workspace/PROMPT_NOTEBOOK_LLM_NOVO_PDF_LATEX.md`


---


# Prompt para Notebook LLM — Gerar Novo PDF do Relatório LaTeX

## Objetivo deste arquivo

Este prompt deve ser usado em um **Notebook LLM** para gerar ou revisar um novo PDF do relatório em LaTeX do projeto:

> **Soma de Vetores em CUDA — Comparação de desempenho entre CPU sequencial e GPU paralela**

A tarefa do LLM é trabalhar **somente no relatório LaTeX/PDF**, não em slides.

---

# PROMPT PRINCIPAL

```text
Você é um assistente acadêmico especializado em LaTeX, escrita científica e projetos de Arquitetura de Computadores.

Sua tarefa é gerar ou revisar um NOVO PDF do relatório LaTeX do trabalho "Soma de Vetores em CUDA", seguindo fielmente o relatório escrito fornecido no contexto ou nos arquivos anexados.

## 1. Escopo obrigatório

Você deve trabalhar SOMENTE no relatório escrito em LaTeX.

O objetivo é produzir um PDF acadêmico final do relatório, não slides, não roteiro de apresentação, não README, não notebook e não código CUDA.

Se eu pedir "novo PDF", interprete como:

- gerar ou revisar `main.tex`;
- garantir que o conteúdo siga o relatório escrito;
- compilar o LaTeX;
- entregar um PDF final do relatório.

Não gere apresentação de slides.
Não gere Beamer.
Não gere PowerPoint.
Não gere HTML.
Não gere roteiro de fala.

## 2. Fonte única de verdade

Use como fonte principal o relatório escrito atual do projeto.

O relatório deve permanecer sobre:

- Soma de vetores em CUDA;
- comparação CPU sequencial vs GPU paralela;
- disciplina Arquitetura de Computadores;
- versão individual do aluno Wésio Filho;
- execução local/bare metal no notebook Acer Nitro V15.

Não invente outro tema.
Não troque o projeto.
Não substitua CUDA por OpenCL, Python, NumPy, MPI, OpenMP ou outra tecnologia.

## 3. Dados obrigatórios do trabalho

Mantenha estes dados exatamente, salvo se o arquivo do relatório original trouxer correção mais recente:

- Título: Soma de Vetores em CUDA
- Subtítulo/tema: Comparação de desempenho entre CPU sequencial e GPU paralela
- Aluno: Wésio Filho
- Disciplina: Arquitetura de Computadores — 5º Período
- Professor: Newarney T. da Costa
- Ano: 2026
- Ambiente: notebook Acer Nitro V15
- Sistema: CachyOS / Linux
- CPU: 13th Gen Intel Core i5-13420H
- GPU: NVIDIA GeForce RTX 4050 Laptop GPU
- VRAM: 6 GB
- Núcleos CUDA: 2.560
- SMs: 20 Streaming Multiprocessors
- Compilação CPU: gcc -std=c11 -O2 -Wall -Wextra
- Compilação GPU: nvcc -O2

## 4. Resultados obrigatórios

A tabela de resultados deve aparecer no relatório com estes valores:

| N | CPU médio (ms) | GPU médio (ms) | Speedup |
|---:|---:|---:|---:|
| 1.000 | 0,0042 | 0,1681 | 0,02x |
| 100.000 | 0,3207 | 0,2076 | 1,54x |
| 1.000.000 | 3,1630 | 0,3349 | 9,45x |
| 10.000.000 | 31,4850 | 0,5917 | 53,21x |

Não altere esses números.
Não arredonde de forma diferente.
Não crie novos benchmarks.
Não invente resultados extras.

## 5. Estrutura obrigatória do relatório

O relatório deve seguir uma estrutura acadêmica parecida com esta:

1. Título, autor, instituição/disciplina
2. Abstract em inglês
3. Resumo em português
4. Introdução
5. Fundamentação teórica
   - CPU vs GPU
   - Modelo CUDA
   - Threads, blocos e grids
   - SIMT e warps
   - Hierarquia de memória
6. Trabalhos relacionados ou referências teóricas
7. Metodologia
   - Implementação CPU
   - Implementação GPU
   - Ambiente de execução
   - Tamanhos testados
   - Forma de medição
8. Resultados
   - Tabela de tempos
   - Gráfico de tempos, se disponível
   - Gráfico de speedup, se disponível
9. Discussão
   - Por que a GPU perde em vetores pequenos
   - Por que a GPU vence em vetores grandes
   - Overhead de transferência PCIe
   - Lançamento de kernel
   - Paralelismo massivo
10. Limitações
11. Conclusão
12. Agradecimentos, se o modelo/template exigir
13. Referências

Não remova seções técnicas importantes.
Não transforme o relatório em texto curto.
Não transforme o relatório em tópicos de slide.

## 6. Tamanho obrigatório

O PDF final deve ter entre 9 e 10 páginas, preferencialmente 10 páginas.

Se compilar e ficar com menos de 9 páginas:

- aprofunde a fundamentação teórica;
- detalhe melhor CUDA, SIMT, warps e memória;
- explique melhor a metodologia;
- amplie a discussão dos resultados;
- detalhe limitações e trabalhos futuros.

Se passar de 10 páginas:

- reduza redundâncias;
- encurte trechos repetitivos;
- compacte parágrafos muito longos;
- mantenha os dados e seções obrigatórias.

Meta final: 10 páginas.

## 7. Regras de fidelidade

Você deve seguir o relatório escrito e preservar o conteúdo técnico correto.

Não diga que foi usado Google Colab.
Não diga que foi usada GPU NVIDIA T4.
Não diga que foi usada RTX 3050.
Não diga que a CPU é Intel Xeon.
Não diga que a execução principal foi em nuvem.

O fluxo principal é local/bare metal no notebook do aluno.

## 8. Código no relatório

Se incluir trechos de código, use apenas trechos curtos e explicativos.

Código CPU esperado, de forma resumida:

```c
for (int i = 0; i < N; i++) {
    C[i] = A[i] + B[i];
}
```

Código CUDA esperado, de forma resumida:

```cuda
__global__ void somaVetores(const float *A, const float *B, float *C, int N) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
        C[i] = A[i] + B[i];
    }
}
```

Não escreva uma implementação diferente.
Não altere a lógica do projeto.

## 9. Gráficos e figuras

Se o ambiente permitir incluir imagens, use os arquivos já existentes do projeto:

- resultados/grafico_tempos.png
- resultados/grafico_speedup.png
- resultados/grid-blocks-threads.png

Não crie gráficos com valores diferentes.
Não substitua os gráficos por imagens genéricas.
Não invente figuras externas.

## 10. Referências obrigatórias ou recomendadas

Use referências reais e coerentes com CUDA e Arquitetura de Computadores, como:

- STALLINGS, William. Computer Organization and Architecture.
- NVIDIA Corporation. CUDA C++ Programming Guide.
- HARRIS, Mark. CUDA Pro Tip / textos técnicos da NVIDIA Developer Blog.
- BIALAS, Piotr. NVIDIA CUDA — programming model.

Não invente DOI.
Não invente artigo inexistente.
Não use referências sem relação com CUDA, GPU ou Arquitetura de Computadores.

## 11. Formato de saída desejado

Se você conseguir editar arquivos, entregue:

1. `main.tex` atualizado;
2. arquivo `.bib` atualizado, se necessário;
3. PDF final compilado;
4. resumo final com:
   - número de páginas do PDF;
   - se a compilação teve erro;
   - caminho do PDF gerado.

Se você só puder responder em texto, entregue:

1. o conteúdo completo do `main.tex` dentro de um bloco de código LaTeX;
2. o conteúdo completo do `.bib`, se necessário;
3. instruções de compilação:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
pdfinfo main.pdf | grep Pages
```

## 12. Checklist obrigatório antes de finalizar

Antes de responder como concluído, verifique:

- [ ] O PDF é do relatório, não de slides.
- [ ] O PDF tem 9 a 10 páginas, preferencialmente 10.
- [ ] O relatório cita Acer Nitro V15, CachyOS e RTX 4050 Laptop GPU.
- [ ] O relatório NÃO cita Google Colab como fluxo principal.
- [ ] O relatório NÃO cita T4, RTX 3050 ou Intel Xeon como ambiente real.
- [ ] A tabela de resultados tem os quatro tamanhos corretos.
- [ ] O speedup máximo é 53,21x para 10.000.000 elementos.
- [ ] O texto explica por que a CPU vence em vetor pequeno.
- [ ] O texto explica por que a GPU vence em vetor grande.
- [ ] O relatório tem referências reais.
- [ ] A compilação LaTeX não terminou com erro fatal.

## 13. O que você NÃO deve fazer

- Não gerar slides.
- Não gerar Beamer.
- Não gerar roteiro de apresentação.
- Não gerar README.
- Não gerar notebook.
- Não mudar o tema do trabalho.
- Não mudar os resultados.
- Não inventar hardware.
- Não inventar referências.
- Não remover a declaração de uso de IA, se ela estiver no projeto.
- Não apagar ferramentas/modelos usados anteriormente.

## 14. Resposta final esperada

Ao terminar, responda apenas neste formato:

```text
PDF DO RELATÓRIO GERADO/REVISADO

Arquivo principal: main.tex
PDF final: main.pdf
Páginas: X
Compilação: sem erro fatal / com erro a corrigir
Ambiente descrito: Acer Nitro V15 + CachyOS + RTX 4050 Laptop GPU
Resultados preservados: sim/não
Observações: ...
```

Se não conseguir compilar, explique exatamente o erro e diga qual arquivo/linha precisa de correção.
```

---

# Lembrete rápido para o Wésio

Use este prompt quando quiser que o Notebook LLM gere ou revise **o PDF do relatório LaTeX**.

Se quiser slides, use outro prompt separado. Este aqui é travado para relatório/PDF escrito.


---


# 3. Prompt inicial para gerar slides a partir do relatório PDF


**Arquivo original:** `/home/wesio/workspace/PROMPT_SLIDES_GERAR.md`


---


# Prompt: Gerar Slides a Partir do Relatório PDF

## Como usar

Copie todo o conteúdo abaixo e cole em uma célula de código ou markdown de um notebook LLM (Google Colab, LM Studio, etc.). O prompt é autocontido — não precisa de contexto adicional, basta colar e executar.

> **Importante:** Não modifique as instruções, a estrutura de seções nem a ordem dos slides. Cada slide tem um papel definido no fluxo da apresentação. Se o LLM tentar reduzir, expandir ou mudar a ordem, recuse e peça para seguir este prompt à risca.

---

## Prompt completo

```
Você é um assistente de produtividade acadêmica. Sua única tarefa neste turno é gerar uma apresentação de slides em formato texto estruturado (Markdown) com base no relatório PDF que você acabou de receber (Soma de Vetores em CUDA — Wésio Filho, Arquitetura de Computadores, 2026).

## REGRAS ABSOLUTAS

1. **Siga o relatório PDF como fonte única de verdade.** Não invente dados, nomes de autores, especificações de hardware, resultados numéricos ou conclusões que não estejam no relatório.
2. **Não desviar do tema.** A apresentação é sobre Soma de Vetores em CUDA, disciplina Arquitetura de Computadores. Qualquer tentativa de falar sobre outros assuntos deve ser ignorada.
3. **Número de slides: exatamente 12.** Nem um a mais, nem um a menos.
4. **Cada slide deve ter título claro e conteúdo conciso** (máximo 6 linhas de bullet points).
5. **Não gere código LaTeX, Beamer, PowerPoint XML nem HTML.** Gere APENAS Markdown formatado para apresentação.
6. **Os slides devem ser numerados de 1 a 12, sequencialmente.**
7. **Após gerar os 12 slides, pare.** Não acrescente slides extras, não sugira melhorias, não faça comentários sobre a própria resposta.

## Estrutura fixa dos 12 slides (NÃO MUDAR A ORDEM)

### Slide 1 — Capa
- Título do trabalho: "Soma de Vetores em CUDA"
- Subtítulo: "Comparação de desempenho entre CPU sequencial e GPU paralela"
- Aluno: Wésio Filho
- Disciplina: Arquitetura de Computadores — 5º Período
- Professor: Newarney T. da Costa
- Ano: 2026

### Slide 2 — Problema e Objetivo
- O problema clássico de soma de vetores: C[i] = A[i] + B[i]
- Objetivo: implementar em CPU (sequencial) e GPU (paralela) e comparar desempenho
- Métrica principal: tempo de execução e speedup

### Slide 3 — Fundamentos: CPU vs GPU
- CPU: poucos núcleos complexos, excelente para tarefas sequenciais
- GPU: muitos núcleos simples, otimizada para paralelismo massivo
- Analogia: CPU = 1 guerreiro forte; GPU = exército de clones fazendo a mesma tarefa em partes diferentes

### Slide 4 — Arquitetura CUDA: Grid, Blocos e Threads
- Hierarquia: Thread → Bloco → Grid
- Cada thread calcula 1 elemento do vetor
- Diagrama da relação entre threads, blocos e grid

### Slide 5 — Implementação CPU
- Código: laço for percorrendo todos os elementos sequencialmente
- Função somar_vetores_cpu em C
- Medição de tempo com clock_gettime

### Slide 6 — Implementação GPU (CUDA)
- Código: kernel __global__ com thread por elemento
- Índice global: blockIdx.x * blockDim.x + threadIdx.x
- Verificação if (i < N) para elementos fora do vetor

### Slide 7 — Metodologia e Ambiente
- Ambiente: notebook Acer Nitro V15 com CachyOS
- CPU: 13th Gen Intel Core i5-13420H
- GPU: NVIDIA GeForce RTX 4050 Laptop GPU, 6 GB VRAM, 2.560 núcleos CUDA, 20 SMs
- Compilação: gcc -std=c11 -O2 (CPU) e nvcc -O2 (GPU)
- Tamanhos testados: 1.000, 100.000, 1.000.000, 10.000.000 elementos — 5 execuções por tamanho

### Slide 8 — Resultados Numéricos (tabela)
| N | CPU (ms) | GPU (ms) | Speedup |
|---:|---:|---:|---:|
| 1.000 | 0,0042 | 0,1681 | 0,02x |
| 100.000 | 0,3207 | 0,2076 | 1,54x |
| 1.000.000 | 3,1630 | 0,3349 | 9,45x |
| 10.000.000 | 31,4850 | 0,5917 | 53,21x |

### Slide 9 — Análise: Por que GPU vence em vetores grandes
- Paralelismo massivo: 2.560 threads simultâneas
- Latência de memória oculta: escalonador alterna warps enquanto threads aguardam dados
- Largura de banda da memória global da GPU (~192 GB/s)
- Eficiência calculada: 53,21 / 2.560 ≈ 2,1%

### Slide 10 — Gargalo: Por que GPU perde em vetores pequenos
- Overhead de transferência Host→Device via barramento PCIe (~16 GB/s)
- Overhead de lançamento da kernel
- Para N=1.000, CPU vence porque custo de transferência > benefício paralelo

### Slide 11 — Conclusão
- Soma de vetores é altamente paralelizável (cada posição independente)
- GPU vence em vetores ≥ 100.000 elementos
- Speedup máximo: 53,21x no maior vetor (10 milhões de elementos)
- Conceitos consolidados: kernel, threads, blocos, grid, memória host/device, speedup

### Slide 12 — Referências e Declaração
- Referências usadas no relatório:
  1. Stallings, W. "Computer Organization and Architecture" (referência teórica)
  2. NVIDIA Corporation. "CUDA C++ Programming Guide" (guia CUDA)
  3. Harris, M. "CUDA Pro Tip: Optimized Filtering with Warp-Agnostic Primitives" (otimização)
  4. Bialas, P. "NVIDIA CUDA — programming model" (artigo acadêmico)
- Declaração: o código, resultados e relatório foram lidos e compreendidos pelo aluno

## Formato de saída esperado

Cada slide deve seguir este formato EXATO:

```markdown
---
## Slide N — Título do Slide

- Bullet point 1
- Bullet point 2
- Bullet point 3
...
```

Exemplo para Slide 1:

```markdown
---
## Slide 1 — Capa

- **Título:** Soma de Vetores em CUDA
- **Subtítulo:** Comparação de desempenho entre CPU sequencial e GPU paralela
- **Aluno:** Wésio Filho
- **Disciplina:** Arquitetura de Computadores — 5º Período
- **Professor:** Newarney T. da Costa
- **Ano:** 2026
```

## O que NÃO fazer

- ❌ Não adicione slides além dos 12 especificados
- ❌ Não mude a ordem dos slides
- ❌ Não invente dados que não estejam no relatório PDF
- ❌ Não gere código LaTeX, Beamer, Python, HTML ou qualquer outra linguagem
- ❌ Não faça comentários após os slides ("Espero que gostem", "Isso é só um exemplo", etc.)
- ❌ Não sugira melhorias ou variações
- ❌ Não mude os valores numéricos dos resultados

## Confirmação antes de gerar

Antes de começar, confirme neste formato:

```
CONFIRMADO: Vou gerar exatamente 12 slides em Markdown seguindo a estrutura acima.
Fonte de dados: relatório PDF fornecido.
Formato: Markdown.
Slides: 1 (Capa) → 12 (Referências).
```

Após confirmar, gere os 12 slides.
```

---

## Notas de uso

- **Se o LLM tentar expandir ou resumir demais:** Recuse e diga " gere os 12 slides seguindo a estrutura acima, sem modificar dados, ordem ou quantidade".
- **Se o LLMask "não tenho acesso ao PDF":** Forneça o texto completo do relatório PDF manualmente na célula anterior, ou peça para usar apenas o conteúdo que foi passado no contexto da conversa.
- **Após gerar:** Copie o resultado para um editor de apresentação (PowerPoint, Google Slides, Canva) e formate visualmente, ou use uma ferramenta de conversão (Markdown → PPTX).


---


# 4. Prompt final para NotebookLM gerar slides seguindo o PDF do relatório


**Arquivo original:** `/home/wesio/workspace/PROMPT_NOTEBOOKLM_SLIDES_RELATORIO_CUDA.md`


---


# Prompt para NotebookLM gerar slides a partir do PDF do relatório

## Objetivo

Este prompt deve ser usado no **NotebookLM** depois de adicionar como fonte o PDF do relatório escrito:

```text
relatorio_sbc.pdf
```

PDF local do projeto:

```text
/home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/cuda-soma-vetores/relatorio/relatorio_sbc.pdf
```

O NotebookLM deve gerar **somente o conteúdo dos slides**, seguindo fielmente o relatório. O PDF do relatório é a fonte principal. Não é para inventar dados, trocar hardware, trocar resultados ou mudar o foco do trabalho.

---

## Prompt para colar no NotebookLM

```text
Você é um assistente acadêmico. Sua tarefa é gerar o conteúdo de uma apresentação de slides baseada EXCLUSIVAMENTE no PDF do relatório fornecido como fonte: "Soma de Vetores em CUDA: Uma Análise Comparativa de Desempenho entre CPU e GPU".

O trabalho é individual, da disciplina Arquitetura de Computadores, sobre soma de vetores em CUDA.

# REGRA PRINCIPAL
Use somente informações presentes no PDF do relatório. O PDF é a fonte única de verdade.

Se alguma informação não estiver no PDF, NÃO invente. Escreva apenas: "informação não consta no relatório".

# NÃO DESVIAR
Não fale de outro projeto, outra linguagem, outro algoritmo ou outra disciplina. O assunto é somente:

- Soma de vetores
- CPU sequencial
- GPU CUDA
- Arquitetura CUDA
- Benchmark CPU vs GPU
- Resultados e conclusões do relatório

# PROIBIÇÕES
Não use, não cite e não invente:

- Google Colab
- GPU T4
- RTX 3050
- outro notebook
- outro aluno
- outro professor
- outros resultados de benchmark
- outras ferramentas que não estejam no relatório
- bibliografia adicional fora do PDF

# DADOS QUE DEVEM SER MANTIDOS EXATAMENTE COMO NO RELATÓRIO
Use estes dados exatamente, porque fazem parte do relatório:

- Aluno: Wésio Filho
- Tema: Soma de Vetores em CUDA
- Disciplina: Arquitetura de Computadores
- Professor: Newarney T. da Costa
- Ambiente: notebook Acer Nitro V15
- CPU: 13th Gen Intel Core i5-13420H
- RAM: 8 GB
- GPU: NVIDIA GeForce RTX 4050 Laptop GPU
- VRAM: 6 GB
- Núcleos CUDA: 2.560
- SMs: 20 Streaming Multiprocessors
- Sistema: CachyOS / Arch Linux
- Compilação CPU: gcc -std=c11 -O2
- Compilação GPU: nvcc -O2

# RESULTADOS NUMÉRICOS OBRIGATÓRIOS
Inclua esta tabela exatamente, sem alterar valores:

| N | CPU médio (ms) | GPU médio (ms) | Speedup |
|---:|---:|---:|---:|
| 1.000 | 0,0042 | 0,1681 | 0,02x |
| 100.000 | 0,3207 | 0,2076 | 1,54x |
| 1.000.000 | 3,1630 | 0,3349 | 9,45x |
| 10.000.000 | 31,4850 | 0,5917 | 53,21x |

# QUANTIDADE E ORDEM DOS SLIDES
Gere exatamente 12 slides, nesta ordem. Não mude a ordem. Não adicione slide extra. Não remova slide.

## Slide 1 — Capa
Conteúdo obrigatório:
- Soma de Vetores em CUDA
- Comparação de desempenho entre CPU sequencial e GPU paralela
- Wésio Filho
- Arquitetura de Computadores
- Professor Newarney T. da Costa
- 2026

## Slide 2 — Problema do Trabalho
Explique:
- Operação: C[i] = A[i] + B[i]
- Por que é um problema adequado para paralelismo
- Objetivo: comparar CPU sequencial e GPU CUDA

## Slide 3 — Objetivos
Explique:
- Implementar versão CPU em C
- Implementar versão GPU em CUDA
- Medir tempo de execução
- Calcular speedup
- Analisar quando a GPU compensa

## Slide 4 — Fundamentos: CPU vs GPU
Explique:
- CPU tem poucos núcleos complexos
- GPU tem muitos núcleos simples
- GPU é adequada para tarefas massivamente paralelas
- Relação com Arquitetura de Computadores

## Slide 5 — Modelo CUDA
Explique:
- Kernel
- Thread
- Bloco
- Grid
- Índice global: blockIdx.x * blockDim.x + threadIdx.x

## Slide 6 — Implementação CPU
Explique:
- Laço sequencial for
- Cada posição do vetor é processada uma após a outra
- Medição de tempo na CPU
- Validação dos resultados

## Slide 7 — Implementação GPU
Explique:
- Uma thread por elemento
- Kernel CUDA executado na GPU
- if (i < N) para evitar acesso fora do vetor
- Uso de memória host/device
- Medição com eventos CUDA

## Slide 8 — Metodologia e Ambiente
Use os dados reais do relatório:
- Acer Nitro V15
- Intel Core i5-13420H
- 8 GB RAM
- NVIDIA RTX 4050 Laptop GPU, 6 GB VRAM
- 2.560 núcleos CUDA e 20 SMs
- CachyOS / Arch Linux
- gcc e nvcc
- 5 execuções por tamanho de vetor

## Slide 9 — Resultados
Inclua obrigatoriamente a tabela de resultados numéricos fornecida acima.
Depois da tabela, destaque:
- CPU vence em N=1.000
- GPU passa a vencer a partir de 100.000 elementos
- Maior speedup: 53,21x em 10 milhões de elementos

## Slide 10 — Análise dos Resultados
Explique:
- Para vetores pequenos, overhead da GPU pesa mais
- Para vetores grandes, paralelismo massivo domina
- Transferência PCIe e lançamento de kernel têm custo
- GPU aproveita largura de banda e muitas threads

## Slide 11 — Limitações e Desafios
Explique:
- Overhead Host ↔ Device
- Dependência de GPU NVIDIA e CUDA
- Portabilidade limitada
- Benchmark pode variar conforme carga da máquina
- Vetores pequenos não justificam GPU

## Slide 12 — Conclusão
Explique:
- Soma de vetores é altamente paralelizável
- GPU foi vantajosa para entradas médias e grandes
- Speedup máximo foi 53,21x
- O trabalho consolidou conceitos de threads, blocos, grid, memória host/device e speedup
- Finalize com uma frase curta de encerramento acadêmico

# FORMATO DE SAÍDA
Gere em Markdown, com este formato exato:

---
# Slide 1 — Capa

- bullet 1
- bullet 2
- bullet 3

---
# Slide 2 — Problema do Trabalho

- bullet 1
- bullet 2
- bullet 3

Continue até o Slide 12.

# REGRAS DE ESTILO
- Linguagem: português do Brasil
- Tom: acadêmico, claro e direto
- Não usar gírias
- Não usar emoji
- Cada slide deve ter no máximo 6 bullets
- Cada bullet deve ter no máximo 18 palavras
- Evite parágrafos longos
- Não coloque notas de apresentador
- Não coloque roteiro de fala
- Não coloque comentários depois do Slide 12

# CHECAGEM ANTES DE RESPONDER
Antes de entregar, confira mentalmente:

1. Tem exatamente 12 slides?
2. A ordem está igual à pedida?
3. Os dados de hardware estão iguais ao relatório?
4. A tabela de resultados está igual aos valores fornecidos?
5. Não citei Colab, T4 ou RTX 3050?
6. Não inventei bibliografia nem resultado?

Agora gere somente os 12 slides em Markdown.
```

---

## Prompt curto de correção, caso o NotebookLM desvie

Use este texto se o NotebookLM sair do escopo:

```text
Refaça seguindo exatamente o prompt anterior.
Você desviou das regras.
Não invente informações.
Não cite Colab, T4 ou RTX 3050.
Use somente o PDF do relatório como fonte.
Gere exatamente 12 slides em Markdown, na ordem solicitada, sem comentários extras.
```

---

## Checklist rápido para o Wésio

Antes de colar no NotebookLM:

- [ ] Adicionar `relatorio_sbc.pdf` como fonte.
- [ ] Confirmar que o PDF carregado tem 10 páginas.
- [ ] Colar o prompt completo.
- [ ] Conferir se a resposta tem exatamente 12 slides.
- [ ] Conferir se não apareceu Colab, T4 ou RTX 3050.
- [ ] Conferir se a tabela ficou com os mesmos números do relatório.


---
