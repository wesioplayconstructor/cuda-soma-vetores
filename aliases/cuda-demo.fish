# Alias/Função Fish para a demonstração ao vivo
#
# Como usar temporariamente na apresentação:
#   source aliases/cuda-demo.fish
#   cuda-demo
#
# Para rodar benchmark completo:
#   cuda-demo --full
#
# Para instalar de vez no seu Fish real:
#   mkdir -p ~/.config/fish/functions
#   cp aliases/cuda-demo.fish ~/.config/fish/functions/cuda-demo.fish

function cuda-demo --description 'Roda a demo ao vivo do projeto CUDA Soma de Vetores'
    bash "/home/wesio/Documentos/Faculdade/Arquitetura de computadores/apresentação final/cuda-soma-vetores/scripts/demo_ao_vivo.sh" $argv
end
