#define _POSIX_C_SOURCE 199309L

/**
 * soma_cpu.c — Soma de vetores na CPU (versão sequencial)
 *
 * Disciplina: Arquitetura de Computadores
 * Autor: Wésio Filho
 *
 * Compilação recomendada:
 *   gcc -std=c11 -O2 -Wall -Wextra codigo/soma_cpu.c -o soma_cpu
 *
 * Execução:
 *   ./soma_cpu [N] [--benchmark]
 *   ./soma_cpu --help
 *
 * Se N não for passado, usa o valor padrão (1.000.000).
 * Com --benchmark, imprime apenas: CPU <tempo_ms>
 */

#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define N_PADRAO 1000000
#define N_MAXIMO 100000000

static void imprimir_uso(const char *programa) {
    printf("Uso: %s [N] [--benchmark]\n", programa);
    printf("\n");
    printf("Opções:\n");
    printf("  N             Tamanho do vetor (1 até %d). Padrão: %d\n", N_MAXIMO, N_PADRAO);
    printf("  --benchmark   Imprime somente: CPU <tempo_ms>\n");
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

static void somar_vetores_cpu(const float *A, const float *B, float *C, int N) {
    for (int i = 0; i < N; i++) {
        C[i] = A[i] + B[i];
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

static double diferenca_ms(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) * 1000.0
         + (fim.tv_nsec - inicio.tv_nsec) / 1000000.0;
}

int main(int argc, char *argv[]) {
    int N = N_PADRAO;
    int modo_benchmark = 0;
    int resultado_argumentos;
    int indice_erro = -1;

    resultado_argumentos = processar_argumentos(argc, argv, &N, &modo_benchmark);
    if (resultado_argumentos == 2) {
        return 0;
    }
    if (resultado_argumentos == 0) {
        return 1;
    }

    size_t bytes = (size_t)N * sizeof(float);

    float *A = (float *)malloc(bytes);
    float *B = (float *)malloc(bytes);
    float *C = (float *)malloc(bytes);

    if (A == NULL || B == NULL || C == NULL) {
        fprintf(stderr, "Erro: falha na alocação de memória para %d elementos.\n", N);
        free(A);
        free(B);
        free(C);
        return 1;
    }

    preencher_vetores(A, B, N);

    struct timespec ts_inicio;
    struct timespec ts_fim;

    if (clock_gettime(CLOCK_MONOTONIC, &ts_inicio) != 0) {
        perror("clock_gettime inicio");
        free(A);
        free(B);
        free(C);
        return 1;
    }

    somar_vetores_cpu(A, B, C, N);

    if (clock_gettime(CLOCK_MONOTONIC, &ts_fim) != 0) {
        perror("clock_gettime fim");
        free(A);
        free(B);
        free(C);
        return 1;
    }

    double tempo_ms = diferenca_ms(ts_inicio, ts_fim);

    if (!validar_resultado(A, B, C, N, &indice_erro)) {
        fprintf(stderr, "Erro: resultado incorreto em C[%d].\n", indice_erro);
        free(A);
        free(B);
        free(C);
        return 2;
    }

    if (modo_benchmark) {
        printf("CPU %.6f\n", tempo_ms);
    } else {
        printf("=== Versão CPU — Soma de Vetores ===\n");
        printf("N = %d elementos\n", N);
        printf("Memória por vetor: %.2f MB\n", bytes / (1024.0 * 1024.0));
        printf("Primeiros 5 resultados:\n");
        for (int i = 0; i < 5 && i < N; i++) {
            printf("  C[%d] = %.0f + %.0f = %.0f\n", i, A[i], B[i], C[i]);
        }
        printf("Validação: todos os %d elementos conferidos corretamente.\n", N);
        printf("Tempo CPU: %.6f ms\n", tempo_ms);
    }

    free(A);
    free(B);
    free(C);

    return 0;
}
