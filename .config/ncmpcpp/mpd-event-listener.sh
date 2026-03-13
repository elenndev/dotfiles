#!/bin/bash

echo "cover listener"
echo "Ctrl+C to quit"
echo ""

# show initial cover
bash ~/.config/ncmpcpp/cover-debug.sh

ultima_musica=""

while true; do
    # Pega música atual (sem --wait pra não travar)
    musica_atual=$(mpc current 2>/dev/null)

    # Se mudou E não está vazia
    if [ "$musica_atual" != "$ultima_musica" ] && [ -n "$musica_atual" ]; then
        ultima_musica="$musica_atual"

        # Limpa e mostra
        clear
        bash ~/.config/ncmpcpp/cover.sh

       fi

    sleep 1
done
