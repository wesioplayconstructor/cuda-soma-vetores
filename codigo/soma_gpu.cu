/**
 * soma_gpu.cu — Soma de vetores na GPU (versão paralela em CUDA)
 *
 * Disciplina: Arquitetura de Computadores
 * Autor: Wésio Filho
 *
 * Compilação recomendada:
 *   nvcc -O2 codigo/soma_gpu.cu -o soma_gpu
 *
 * Execução:
 *   ./soma_gpu [N] [--benchmark]
 *   ./soma_gpu --help
 *
 * Se N não for passado, usa o valor padrão (1.000.000).
 * Com --benchmark, imprime apenas: GPU <tempo_ms>
 */

#include <cuda_runtime.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N_PADRAO 1000000
#define N_MAXIMO 100000000
#define THREADS_POR_BLOCO 256

#define CHECK_CUDA(chamada)                                                         \
    do {                                                                            \
        cudaError_t erro_cuda = (chamada);                                          \
        if (erro_cuda != cudaSuccess) {                                             \
            fprintf(stderr, "Erro CUDA em %s:%d: %s\n",                            \
                    __FILE__, __LINE__, cudaGetErrorString(erro_cuda));             \
            status = 1;                                                             \
            goto cleanup;                                                           \
        }                                                                           \
    } while (0)

/**
 * Kernel CUDA: soma de vetores.
 *
 * Cada thread calcula UM elemento:
 *   C[i] = A[i] + B[i]
 *
 * Índice global da thread:
 *   i = blockIdx.x * blockDim.x + threadIdx.x
 *
 * A proteção if (i < N) evita acesso fora do vetor quando o grid lança
 * mais threads do que elementos. Isso acontece porque o número de blocos
 * é arredondado para cima.
 */
__global__ void somaVetores(const float *A, const float *B, float *C, int N) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    if (i < N) {
        C[i] = A[i] + B[i];
    }
}

static void imprimir_uso(const char *programa) {
    printf("Uso: %s [N] [--benchmark]\n", programa);
    printf("\n");
    printf("Opções:\n");
    printf("  N             Tamanho do vetor (1 até %d). Padrão: %d\n", N_MAXIMO, N_PADRAO);
    printf("  --benchmark   Imprime somente: GPU <tempo_ms>\n");
    printf("  --help        Mostra esta ajuda\n");
    printf("\n");
    printf("Exemplos:\n");
    printf("  %s 1000000\n", programa);
    printf("  %s 10000000 --benchmark\n", programa);
}

static int parsear_tamanho(const char *texto, int *N) {
    char *fim = NULL;
    long valor;

    errno = 0;
    valor = strtol(texto, &fim, 10);

    if (errno != 0 || fim == texto || *fim != '\0') {
        return 0;
    }

    if (valor <= 0 || valor > N_MAXIMO || valor > INT_MAX) {
        return 0;
    }

    *N = (int)valor;
    return 1;
}

static int processar_argumentos(int argc, char *argv[], int *N, int *modo_benchmark) {
    int tamanho_informado = 0;

    for (int arg = 1; arg < argc; arg++) {
        if (strcmp(argv[arg], "--benchmark") == 0) {
            *modo_benchmark = 1;
        } else if (strcmp(argv[arg], "--help") == 0 || strcmp(argv[arg], "-h") == 0) {
            imprimir_uso(argv[0]);
            return 2;
        } else {
            if (tamanho_informado) {
                fprintf(stderr, "Erro: informe o tamanho N apenas uma vez.\n");
                fprintf(stderr, "Use --help para ver exemplos.\n");
                return 0;
            }

            if (!parsear_tamanho(argv[arg], N)) {
                fprintf(stderr, "Erro: N deve ser um inteiro entre 1 e %d.\n", N_MAXIMO);
                fprintf(stderr, "Use --help para ver exemplos.\n");
                return 0;
            }

            tamanho_informado = 1;
        }
    }

    return 1;
}

static void preencher_vetores(float *A, float *B, int N) {
    for (int i = 0; i < N; i++) {
        A[i] = (float)i;
        B[i] = 2.0f * (float)i;
    }
}

static int validar_resultado(const float *A, const float *B, const float *C, int N, int *indice_erro) {
    for (int i = 0; i < N; i++) {
        float esperado = A[i] + B[i];
        if (C[i] != esperado) {
            *indice_erro = i;
            return 0;
        }
    }

    *indice_erro = -1;
    return 1;
}

int main(int argc, char *argv[]) {
    int status = 0;
    int N = N_PADRAO;
    int modo_benchmark = 0;
    int resultado_argumentos;
    int indice_erro = -1;

    float *h_A = NULL;
    float *h_B = NULL;
    float *h_C = NULL;
    float *d_A = NULL;
    float *d_B = NULL;
    float *d_C = NULL;

    cudaEvent_t inicio = NULL;
    cudaEvent_t fim = NULL;

    int threadsPorBloco = THREADS_POR_BLOCO;
    int blocos = 0;
    float tempoMs = 0.0f;
    size_t memoria_livre = 0;
    size_t memoria_total = 0;
    size_t blocos_size = 0;

    resultado_argumentos = processar_argumentos(argc, argv, &N, &modo_benchmark);
    if (resultado_argumentos == 2) {
        return 0;
    }
    if (resultado_argumentos == 0) {
        return 1;
    }

    size_t bytes = (size_t)N * sizeof(float);

    /* ============================================
     * 1. ALOCAÇÃO NO HOST (CPU)
     * ============================================ */
    h_A = (float *)malloc(bytes);
    h_B = (float *)malloc(bytes);
    h_C = (float *)malloc(bytes);

    if (h_A == NULL || h_B == NULL || h_C == NULL) {
        fprintf(stderr, "Erro: falha na alocação de memória no host para %d elementos.\n", N);
        status = 1;
        goto cleanup;
    }

    preencher_vetores(h_A, h_B, N);

    /* ============================================
     * 2. VERIFICAÇÃO DA MEMÓRIA DISPONÍVEL NA GPU
     * ============================================ */
    CHECK_CUDA(cudaMemGetInfo(&memoria_livre, &memoria_total));

    if (bytes > memoria_livre / 3) {
        fprintf(stderr,
                "Erro: memória livre da GPU pode ser insuficiente. Necessário ~%.2f MB, livre %.2f MB.\n",
                (3.0 * bytes) / (1024.0 * 1024.0),
                memoria_livre / (1024.0 * 1024.0));
        status = 1;
        goto cleanup;
    }

    /* ============================================
     * 3. ALOCAÇÃO NO DEVICE (GPU)
     * ============================================ */
    CHECK_CUDA(cudaMalloc((void **)&d_A, bytes));
    CHECK_CUDA(cudaMalloc((void **)&d_B, bytes));
    CHECK_CUDA(cudaMalloc((void **)&d_C, bytes));

    /* ============================================
     * 4. CONFIGURAÇÃO DO LANÇAMENTO DA KERNEL
     * ============================================
     * threadsPorBloco = 256: múltiplo de 32, que é o tamanho de um warp.
     * blocos = teto(N / threadsPorBloco): garante threads suficientes.
     */
    blocos_size = ((size_t)N + (size_t)threadsPorBloco - 1) / (size_t)threadsPorBloco;
    if (blocos_size > (size_t)INT_MAX) {
        fprintf(stderr, "Erro: quantidade de blocos excede o limite suportado neste exemplo.\n");
        status = 1;
        goto cleanup;
    }
    blocos = (int)blocos_size;

    /* ============================================
     * 5. MEDIÇÃO DE TEMPO COM CUDA EVENTS
     * ============================================
     * O tempo GPU medido aqui inclui o ciclo completo:
     *   host -> device + kernel + sincronização + device -> host.
     * Isso representa o custo real de descarregar a operação para a GPU.
     */
    CHECK_CUDA(cudaEventCreate(&inicio));
    CHECK_CUDA(cudaEventCreate(&fim));
    CHECK_CUDA(cudaEventRecord(inicio));

    CHECK_CUDA(cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice));
    CHECK_CUDA(cudaMemcpy(d_B, h_B, bytes, cudaMemcpyHostToDevice));

    somaVetores<<<blocos, threadsPorBloco>>>(d_A, d_B, d_C, N);
    CHECK_CUDA(cudaGetLastError());
    CHECK_CUDA(cudaDeviceSynchronize());

    CHECK_CUDA(cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost));

    CHECK_CUDA(cudaEventRecord(fim));
    CHECK_CUDA(cudaEventSynchronize(fim));
    CHECK_CUDA(cudaEventElapsedTime(&tempoMs, inicio, fim));

    if (!validar_resultado(h_A, h_B, h_C, N, &indice_erro)) {
        fprintf(stderr, "Erro: resultado incorreto em C[%d].\n", indice_erro);
        status = 2;
        goto cleanup;
    }

    if (modo_benchmark) {
        printf("GPU %.6f\n", tempoMs);
    } else {
        printf("=== Versão GPU — Soma de Vetores (CUDA) ===\n");
        printf("N = %d elementos\n", N);
        printf("Memória por vetor: %.2f MB\n", bytes / (1024.0 * 1024.0));
        printf("Configuração: %d blocos × %d threads/bloco = %d threads total\n",
               blocos, threadsPorBloco, blocos * threadsPorBloco);
        printf("Primeiros 5 resultados:\n");
        for (int i = 0; i < 5 && i < N; i++) {
            printf("  C[%d] = %.0f + %.0f = %.0f\n", i, h_A[i], h_B[i], h_C[i]);
        }
        printf("Validação: todos os %d elementos conferidos corretamente.\n", N);
        printf("Tempo GPU (incluindo transferências): %.6f ms\n", tempoMs);
    }

cleanup:
    if (inicio != NULL) {
        cudaEventDestroy(inicio);
    }
    if (fim != NULL) {
        cudaEventDestroy(fim);
    }
    if (d_A != NULL) {
        cudaFree(d_A);
    }
    if (d_B != NULL) {
        cudaFree(d_B);
    }
    if (d_C != NULL) {
        cudaFree(d_C);
    }

    free(h_A);
    free(h_B);
    free(h_C);

    return status;
}
