#!/bin/bash

path=$(pwd)

echo "Bonjour et bienvenue dans  "
echo "Voulez-vous jouer ?"
echo "Répondez oui pour commencer ou non pour éteindre le programme"

start() {
    echo "Réponse :"
    read commencer
    if [ "$commencer" == "oui" ]; then
        echo "c bon"
    elif [ "$commencer" == "non" ]; then
        echo "A bientôt !"
        exit 0
    else
        echo "La réponse est incorrecte"
        echo "Spécifiez 'oui' ou 'non'"
        start
    fi
}

game() {
    page="page$1"
    if [ -z "$3" ]; then
        firefox "$path/$page.html"
    fi
    echo "Quel est le mot de passe que vous avez trouvé ?"
    read answeruser
    if [ "$answeruser" == "$2" ]; then
        echo "Bravo vous avez trouvé le mot de passe de la page numéro $1"
        echo "Vous passez maintenant au niveau suivant."
        clear
    elif [ "$answeruser" == "recommencer" ]; then
        firefox "$path/$page.html"
        game $1 $2 "restart"
    elif [ "$answeruser" == "indice" ]; then
        echo "indice"
        game $1 $2 "restart"
    else
        echo "Le mot de passe est incorrect, recommencez"
        game $1 $2 "restart"
    fi
}

start
clear
password_array=("Le_p0n3y" "B0nb0nMagique99" "LicorneVolante7" "DinosaureFiesta42" "AstronauteGalactique" "PandaBambouDance" "EtoileMagique7" \
 "CookieArcenciel123" "ReineFeerique45" "RocherViolet03")

for i in {1..10}; do
    game "$i" "${password_array[$i-1]}"
done
    



