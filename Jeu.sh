#!/bin/bash

#TODO : Indices, recommencer, fermer les pages a chaque question et enfin finir la biographie

path=$(pwd)

pkill -f chrono.py

echo "Bonjour et bienvenue dans CodeWebPourTous"
echo "Voulez-vous jouer ?"
echo "Répondez oui pour commencer ou non pour éteindre le programme"

start() {
    echo "Réponse :"
    read commencer
    if [ "$commencer" == "oui" ]; then
        echo "c bon"
    elif [ "$commencer" == "non" ]; then
        echo "A bient�t !"
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
        chromium-browser "$path/$page.html"
    fi
    echo "Quel est le mot de passe que vous avez trouvé ?"
    read answeruser
    if [ "$answeruser" == "$2" ]; then
        echo "Bravo vous avez trouvé le mot de passe de la page numéro $1"
        echo "Vous passez maintenant au niveau suivant."
	python led_true.py &
	pkill -f chrono.py
        clear
    elif [ "$answeruser" == "recommencer" ]; then
        chromium-browser "$path/$page.html"
        game $1 $2 "restart"
    elif [ "$answeruser" == "indice" ]; then
        echo "indice"
        game $1 $2 "restart"
    else
        echo "Le mot de passe est incorrect, recommencez"
	python led_false.py &
        game $1 $2 "restart"
    fi
}

bio() {
    declare -A answer_array
    answer_array['ADA_LOVELACE']="2"
    answer_array['HEDY_LAMARR']="2"
    answer_array['JEAN_BARTIK']="2"
    answer_array['GRACE_HOPPER']="3"
    answer_array['EVELYN_BOYD']="3"
    answer_array['MARGARET_HAMILTON']="2"
    answer_array['JOAN_BALL']="1"
    answer_array['ELISABETH_FEINLER']="1"
    answer_array['JANESE_SWANSON']="3"
    answer_array['DONNA_DUBINSKY']="1"

    declare -A question_array
    question_array['ADA_LOVELACE']="Quel role a joue Ada Lovelace dans l'histoire de l'informatique ? \n \
    [1] Elle était la fille du poète britannique Lord Byron. \n \
    [2] Elle a publié la traduction d'un article sur le moteur analytique de Luigi Menabrea. \n \
    [3] Elle était la première à concevoir des machines pouvant composer de la musique complexe. \n"

    question_array['HEDY_LAMARR']="Quelle innovation Hedy Lamarr et George Anthiel ont-ils développée pendant la Seconde Guerre mondiale ? \n \
    [1] Ils ont inventé le téléphone portable. \n \
    [2] Ils ont mis au point un système de communication secret utilisant des fréquences radio. \n \
    [3] Ils ont créé le premier télécopieur. \n"

    question_array['JEAN_BARTIK']="Quel rôle a joué Jean Bartik dans l'histoire de l'informatique ? \n \
    [1] Elle était l'une des premières femmes à utiliser des calculatrices mécaniques pour l'armée américaine. \n \
    [2] Elle a été choisie pour travailler sur la machine ENIAC et est devenue l'une des premières programmeuses au monde. \n \
    [3] Elle a conçu le premier ordinateur électronique. \n"

    question_array['GRACE_HOPPER']="Quelle contribution majeure Grace Hopper a-t-elle apportée à l'informatique ? \n \
    [1] Elle a supervisé la programmation de l'ordinateur UNIVAC chez Remington Rand. \n \
    [2] Elle a créé le premier ordinateur UNIVAC. \n \
    [3] Elle a inventé le premier compilateur, précurseur du langage COBOL. \n"

    question_array['EVELYN_BOYD']="Quelle réalisation majeure d'Evelyn Boyd Granville est associée à son travail chez IBM et la NASA ? \n \
    [1] Elle est devenue la première femme mathématicienne afro-américaine à obtenir un doctorat en mathématiques. \n \
    [2] Elle a conçu le premier ordinateur pour la NASA. \n \
    [3] Elle a développé un logiciel informatique pour analyser les orbites des satellites pour le projet Vanguard. \n"
    
    question_array['MARGARET_HAMILTON']="Quel rôle Margaret Hamilton a-t-elle joué dans le programme spatial Apollo de la NASA ? \n \   
    [1] Elle était la première femme à marcher sur la lune. \n \
    [2] Elle a dirigé une équipe de développement de logiciels pour les missions Apollo. \n \
    [3] Elle a inventé le terme 'ingénieur logiciel' et a enseigné ce domaine dans les écoles. \n"
    
    question_array['JOAN_BALL']="Quel rôle Joan Ball a-t-elle joué dans le domaine des rencontres et de l'informatique ? \n \
    [1] Elle était la première femme à avoir conçu un algorithme de compatibilité pour les rencontres. \n \
    [2] Elle a ouvert le St. James Computer Dating Service et a amélioré son fonctionnement grâce à l'informatique. \n \
    [3] Elle a fondé le premier site web de rencontres en ligne. \n"
    
    question_array['ELISABETH_FEINLER']="Quel rôle majeur Elizabeth Feinler a-t-elle joué dans le développement de l'Internet ? \n \
    [1] Elle a créé et géré l'ARPANET pour le ministère de la Défense, un précurseur de l'Internet moderne. \n \
    [2] Elle a inventé le premier navigateur web. \n \
    [3] Elle a fondé le premier service de messagerie électronique. \n"
    
    question_array['JANESE_SWANSON']="Quelle contribution majeure Janese Swanson a-t-elle apportée dans le domaine des jouets technologiques et de l'autonomisation des filles ? \n \
    [1] Elle a créé le jeu vidéo 'Where in the World Is Carmen Sandiego?'. \n \
    [2] Elle a fondé la société Kid One for Fun pour développer des jouets technologiques. \n \
    [3] Elle a créé la société Girl Tech pour encourager les filles à utiliser les nouvelles technologies. \n"
    
    question_array['DONNA_DUBINSKY']="Quelle réalisation majeure est associée à Donna Dubinsky dans le domaine de la technologie ? \n \
    [1] Elle a introduit le premier assistant numérique personnel (PDA) au monde. \n \
    [2] Elle a développé un système de mémoire informatique calqué sur le cerveau humain. \n \
    [3] Elle a été l'une des premières femmes ingénieures en informatique. \n"

    question="${question_array[$1]}"
    correct_answer="${answer_array[$1]}"
    answeruser=""

    chromium-browser "$path/BIO_$1.html"

    echo -e "$question"

    while [ "$answeruser" != "$correct_answer" ]; do
        echo "Quel est votre réponse ?"
        read answeruser
        if [ "$answeruser" == "$correct_answer" ]; then
            python led_true.py
            echo "Bravo vous avez trouvé !"
        else
            python led_false.py
            echo "Mauvaise réponse !"
        fi
    done
}

start
clear
password_array=("ADA_LOVELACE" "HEDY_LAMARR" "JEAN_BARTIK" "GRACE_HOPPER" "EVELYN_BOYD" "MARGARET_HAMILTON" "JOAN_BALL" \
 "ELISABETH_FEINLER" "JANESE_SWANSON" "DONNA_DUBINSKY")

for i in {1..10}; do
    python chrono.py &
    game "$i" "${password_array[$i-1]}"
    bio "${password_array[$i-1]}"
done
    



