/**
 * soma_gpu.cu — Soma de vetores na GPU (versão paralela em CUDA)
 *
 * Disciplina: Arquitetura de Computadores
 * Autor: Wésio Filho
 *
 * Compilação:  nvcc soma_gpu.cu -o soma_gpu
 * Execução:    ./soma_gpu [N]
 *
 * Se N não for passado, usa o valor padrão (1.000.000).
 */

#include <stdio.h>
#include <stdlib.h>

/* Tamanho padrão dos vetores */
#define N_PADRAO 1000000

/**
 * Kernel CUDA: soma de vetores
 *
 * Cada thread calcula UM elemento do vetor resultado:
 *   C[i] = A[i] + B[i]
 *
 * O índice global da thread é calculado por:
 *   i = blockIdx.x * blockDim.x + threadIdx.x
 *
 * A verificação if (i < N) é necessária porque o número
 * total de threads (blocos × threadsPorBloco) pode ser
 * maior que N, e threads extras não devem acessar memória
 * fora do vetor.
 */
__global__ void somaVetores(float *A, float *B, float *C, int N) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
        C[i] = A[i] + B[i];
    }
}

int main(int argc, char *argv[]) {
    /* Permite passar N pela linha de comando */
    int N = N_PADRAO;
    if (argc > 1) {
        N = atoi(argv[1]);
        if (N <= 0) {
            fprintf(stderr, "Erro: N deve ser positivo.\n");
            return 1;
        }
    }

    /* ============================================
     * 1. ALOCAÇÃO NO HOST (CPU)
     * ============================================ */
    float *h_A = (float *)malloc(N * sizeof(float));
    float *h_B = (float *)malloc(N * sizeof(float));
    float *h_C = (float *)malloc(N * sizeof(float));

    if (h_A == NULL || h_B == NULL || h_C == NULL) {
        fprintf(stderr, "Erro: falha na alocação de memória no host.\n");
        return 1;
    }

    /* Preencher vetores no host */
    for (int i = 0; i < N; i++) {
        h_A[i] = (float)i;
        h_B[i] = 2.0f * (float)i;
    }

    /* ============================================
     * 2. ALOCAÇÃO NO DEVICE (GPU)
     * ============================================ */
    float *d_A, *d_B, *d_C;
    cudaMalloc((void **)&d_A, N * sizeof(float));
    cudaMalloc((void **)&d_B, N * sizeof(float));
    cudaMalloc((void **)&d_C, N * sizeof(float));

    /* ============================================
     * 3. TRANSFERÊNCIA HOST → DEVICE
     * ============================================
     * cudaMemcpy com cudaMemcpyHostToDevice copia
     * os dados da RAM da CPU para a VRAM da GPU.
     */
    cudaMemcpy(d_A, h_A, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, N * sizeof(float), cudaMemcpyHostToDevice);

    /* ============================================
     * 4. CONFIGURAÇÃO DO LANÇAMENTO DA KERNEL
     * ============================================
     * threadsPorBloco: número de threads em cada bloco
     *   (256 é um valor típico e eficiente)
     *
     * blocos: número de blocos no grid
     *   Fórmula: (N + threadsPorBloco - 1) / threadsPorBloco
     *   Isso é o "teto" inteiro de N / threadsPorBloco,
     *   garantindo blocos suficientes para cobrir todos
     *   os N elementos.
     */
    int threadsPorBloco = 256;
    int blocos = (N + threadsPorBloco - 1) / threadsPorBloco;

    /* ============================================
     * 5. MEDIÇÃO DE TEMPO COM CUDA EVENTS
     * ============================================
     * cudaEvent_t é a forma recomendada de medir
     * tempo na GPU — mais precisa que clock() ou
     * chrono para código CUDA.
     */
    cudaEvent_t inicio, fim;
    cudaEventCreate(&inicio);
    cudaEventCreate(&fim);

    /* Incluir transferência host→device na medição */
    cudaEventRecord(inicio);

    /* ============================================
     * 6. LANÇAMENTO DA KERNEL
     * ============================================
     * A sintaxe <<<blocos, threads>>> configura
     * o grid de execução na GPU:
     *   - blocos: quantos blocos lançar
     *   - threadsPorBloco: threads por bloco
     *
     * Cada thread executa a função somaVetores
     * de forma independente e paralela.
     */
    somaVetores<<<blocos, threadsPorBloco>>>(d_A, d_B, d_C, N);

    /* Incluir transferência device→host na medição */
    cudaMemcpy(h_C, d_C, N * sizeof(float), cudaMemcpyDeviceToHost);

    /* Fim da medição */
    cudaEventRecord(fim);
    cudaEventSynchronize(fim);

    float tempoMs = 0.0f;
    cudaEventElapsedTime(&tempoMs, inicio, fim);

    /* ============================================
     * 7. VERIFICAÇÃO DOS RESULTADOS
     * ============================================ */
    printf("=== Versão GPU — Soma de Vetores (CUDA) ===\n");
    printf("N = %d elementos\n", N);
    printf("Configuração: %d blocos × %d threads/bloco = %d threads total\n",
           blocos, threadsPorBloco, blocos * threadsPorBloco);
    printf("Primeiros 5 resultados:\n");
    for (int i = 0; i < 5 && i < N; i++) {
        printf("  C[%d] = %.0f + %.0f = %.0f\n", i, h_A[i], h_B[i], h_C[i]);
    }
    printf("Tempo GPU (incluindo transferências): %.6f ms\n", tempoMs);

    /* ============================================
     * 8. LIBERAÇÃO DE MEMÓRIA
     * ============================================ */
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(h_A);
    free(h_B);
    free(h_C);

    /* Destruir eventos */
    cudaEventDestroy(inicio);
    cudaEventDestroy(fim);

    return 0;
}
