/**
 * soma_cpu.c — Soma de vetores na CPU (versão sequencial)
 *
 * Disciplina: Arquitetura de Computadores
 * Autor: Wésio Filho
 *
 * Compilação:  gcc soma_cpu.c -o soma_cpu -lm
 * Execução:    ./soma_cpu [N]
 *
 * Se N não for passado, usa o valor padrão (1.000.000).
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* Tamanho padrão dos vetores */
#define N_PADRAO 1000000

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

    /* 1. Alocar vetores no host (CPU) */
    float *A = (float *)malloc(N * sizeof(float));
    float *B = (float *)malloc(N * sizeof(float));
    float *C = (float *)malloc(N * sizeof(float));

    if (A == NULL || B == NULL || C == NULL) {
        fprintf(stderr, "Erro: falha na alocação de memória.\n");
        return 1;
    }

    /* 2. Preencher A e B com valores conhecidos */
    for (int i = 0; i < N; i++) {
        A[i] = (float)i;
        B[i] = 2.0f * (float)i;
    }

    /* 3. Medir tempo — clock_gettime para maior precisão */
    struct timespec ts_inicio, ts_fim;
    clock_gettime(CLOCK_MONOTONIC, &ts_inicio);

    /* 4. Somar C[i] = A[i] + B[i] (loop sequencial) */
    for (int i = 0; i < N; i++) {
        C[i] = A[i] + B[i];
    }

    /* 5. Fim da medição */
    clock_gettime(CLOCK_MONOTONIC, &ts_fim);

    /* Calcular tempo em milissegundos */
    double tempo_ms = (ts_fim.tv_sec - ts_inicio.tv_sec) * 1000.0
                    + (ts_fim.tv_nsec - ts_inicio.tv_nsec) / 1000000.0;

    /* 6. Imprimir verificação (primeiros 5 elementos) */
    printf("=== Versão CPU — Soma de Vetores ===\n");
    printf("N = %d elementos\n", N);
    printf("Primeiros 5 resultados:\n");
    for (int i = 0; i < 5 && i < N; i++) {
        printf("  C[%d] = %.0f + %.0f = %.0f\n", i, A[i], B[i], C[i]);
    }
    printf("Tempo CPU: %.6f ms\n", tempo_ms);

    /* 7. Liberar memória */
    free(A);
    free(B);
    free(C);

    return 0;
}
