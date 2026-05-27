#!/usr/bin/env bash
set -u

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR" || exit 1

MODO="${1:-rapido}"

azul='\033[1;34m'
verde='\033[1;32m'
amarelo='\033[1;33m'
vermelho='\033[1;31m'
reset='\033[0m'

pausa() {
  echo
  read -r -p "Pressione ENTER para continuar... " _
}

secao() {
  echo
  echo -e "${azul}============================================================${reset}"
  echo -e "${azul}$1${reset}"
  echo -e "${azul}============================================================${reset}"
}

ok() { echo -e "${verde}✅ $1${reset}"; }
aviso() { echo -e "${amarelo}⚠️  $1${reset}"; }
erro() { echo -e "${vermelho}❌ $1${reset}"; }

rodar() {
  echo -e "${amarelo}$ $*${reset}"
  "$@"
}

rodar_shell() {
  echo -e "${amarelo}$ $*${reset}"
  bash -lc "$*"
}

secao "DEMO AO VIVO — Soma de Vetores em CUDA"
echo "Projeto: CPU sequencial vs GPU CUDA"
echo "Pasta: $REPO_DIR"
echo
echo "Fala sugerida: 'Vou mostrar primeiro o ambiente, depois compilar, validar e comparar CPU/GPU.'"
pausa

secao "1) Conferir GPU NVIDIA"
if command -v nvidia-smi >/dev/null 2>&1; then
  rodar nvidia-smi --query-gpu=name,memory.used,memory.total,driver_version --format=csv,noheader
  ok "Driver NVIDIA detectado."
else
  erro "nvidia-smi não encontrado. Sem isso, a parte CUDA não roda."
fi
pausa

secao "2) Conferir compiladores"
if command -v gcc >/dev/null 2>&1; then
  rodar_shell "gcc --version | head -1"
else
  erro "gcc não encontrado."
fi

if command -v nvcc >/dev/null 2>&1; then
  rodar_shell "nvcc --version | tail -1"
else
  erro "nvcc não encontrado. Instale/ative o CUDA Toolkit."
fi
pausa

secao "3) Compilar CPU e GPU"
rm -f soma_cpu soma_gpu

if rodar gcc -std=c11 -O2 -Wall -Wextra codigo/soma_cpu.c -o soma_cpu; then
  ok "CPU compilada: ./soma_cpu"
else
  erro "Falha ao compilar CPU."
  exit 1
fi

if command -v nvcc >/dev/null 2>&1; then
  if rodar nvcc -O2 codigo/soma_gpu.cu -o soma_gpu; then
    ok "GPU compilada: ./soma_gpu"
  else
    erro "Falha ao compilar GPU."
    exit 1
  fi
else
  aviso "Pulando compilação GPU porque nvcc não existe."
fi
pausa

secao "4) Teste visual pequeno — N = 10"
echo "Fala sugerida: 'Como A[i]=i e B[i]=2i, então C[i]=3i. Isso prova a lógica.'"
echo
if [[ -x ./soma_cpu ]]; then
  rodar ./soma_cpu 10
else
  erro "Executável CPU não existe."
fi

echo
if [[ -x ./soma_gpu ]]; then
  if rodar ./soma_gpu 10; then
    ok "GPU validou corretamente em N=10."
  else
    aviso "GPU falhou no teste pequeno. Se aparecer 'out of memory', provavelmente a VRAM está ocupada por IA local/llama-server."
    aviso "Feche processos de IA pesados antes da apresentação ou mostre os resultados salvos no relatório."
  fi
else
  aviso "Executável GPU não existe."
fi
pausa

secao "5) Benchmark comparativo"
echo "Fala sugerida: 'Agora uso o modo --benchmark, que imprime só o tempo em milissegundos.'"
echo

if [[ "$MODO" == "--full" || "$MODO" == "full" ]]; then
  TAMANHOS=(1000 100000 1000000 10000000)
else
  TAMANHOS=(1000 100000 1000000)
  aviso "Modo rápido: não roda 10.000.000 para evitar demora/risco ao vivo. Use: cuda-demo --full"
fi

printf "\n%-12s | %-14s | %-14s | %-10s\n" "N" "CPU (ms)" "GPU (ms)" "Speedup"
printf '%s\n' "---------------------------------------------------------------"

for N in "${TAMANHOS[@]}"; do
  CPU_MS="erro"
  GPU_MS="erro"
  SPEEDUP="-"

  if CPU_OUT=$(./soma_cpu "$N" --benchmark 2>/tmp/cuda_demo_cpu.err); then
    CPU_MS=$(echo "$CPU_OUT" | awk '{print $2}')
  else
    CPU_MS="erro"
  fi

  if [[ -x ./soma_gpu ]] && GPU_OUT=$(./soma_gpu "$N" --benchmark 2>/tmp/cuda_demo_gpu.err); then
    GPU_MS=$(echo "$GPU_OUT" | awk '{print $2}')
  else
    GPU_MS="erro"
  fi

  if [[ "$CPU_MS" != "erro" && "$GPU_MS" != "erro" ]]; then
    SPEEDUP=$(awk -v c="$CPU_MS" -v g="$GPU_MS" 'BEGIN { if (g > 0) printf "%.2fx", c/g; else print "-" }')
  fi

  printf "%-12s | %-14s | %-14s | %-10s\n" "$N" "$CPU_MS" "$GPU_MS" "$SPEEDUP"
done

if [[ -s /tmp/cuda_demo_gpu.err ]]; then
  echo
  aviso "Última mensagem de erro GPU, se houve:"
  cat /tmp/cuda_demo_gpu.err
fi
pausa

secao "6) Resultados oficiais salvos no relatório"
echo "Se o teste ao vivo variar, use esta tabela como referência do relatório:"
echo
printf "%-12s | %-14s | %-14s | %-10s\n" "N" "CPU médio" "GPU médio" "Speedup"
printf '%s\n' "---------------------------------------------------------------"
printf "%-12s | %-14s | %-14s | %-10s\n" "1.000" "0,0042 ms" "0,1681 ms" "0,02x"
printf "%-12s | %-14s | %-14s | %-10s\n" "100.000" "0,3207 ms" "0,2076 ms" "1,54x"
printf "%-12s | %-14s | %-14s | %-10s\n" "1.000.000" "3,1630 ms" "0,3349 ms" "9,45x"
printf "%-12s | %-14s | %-14s | %-10s\n" "10.000.000" "31,4850 ms" "0,5917 ms" "53,21x"
echo
echo "Fala final sugerida: 'Para vetores pequenos, o overhead da GPU pesa. Para vetores grandes, o paralelismo massivo domina.'"
ok "Demo finalizada."
