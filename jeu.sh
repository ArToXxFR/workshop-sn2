#!/bin/bash

#TODO : Indices, recommencer, fermer les pages a chaque question et enfin finir la biographie

path=$(pwd)

pkill -f chrono.py

clear

echo -e"Bonjour et bienvenue dans CodeWebPourTous \n"
echo -e "Plongez dans le monde passionnant du développement web 
tout en explorant la contribution exceptionnelle des femmes dans 
le domaine de l'informatique. Ce jeu innovant propose des exercices 
de HTML/CSS tout en offrant un aperçu fascinant de l'histoire des 
femmes pionnières de l'informatique.

Objectif : Apprendre les bases du développement web (HTML/CSS) et 
découvrir des figures emblématiques de l'informatique.

Comment ça fonctionne :

    Exercices de HTML/CSS : Chaque niveau du jeu vous présente des 
    exercices de codage HTML/CSS. Vous devrez résoudre ces petits défis
    pour avancer dans le jeu.

    Histoire des femmes de l'informatique : Une fois que vous avez terminé 
    un exercice, un code caché est révélé sur la page web. Vous devez trouver 
    ce code et le saisir dans le "terminal" du jeu.

    Biographie des héroïnes de l'informatique : Si vous entrez le code
    correctement, vous débloquerez l'accès à une biographie détaillée 
    d'une femme exceptionnelle de l'histoire de l'informatique. Apprenez 
    comment ces femmes ont influencé le domaine et ont ouvert la voie pour
    les générations futures.\n"

echo "Pour commencer la partie tapez 'oui' ou 'non' pour ne pas commencer la partie maintenant :"

start() {
    read commencer
    if [ "$commencer" == "oui" ]; then
        echo "c bon"
    elif [ "$commencer" == "non" ]; then
        echo "A bientot !"
        exit 0
    else
        echo "La réponse est incorrecte"
        echo "Spécifiez 'oui' ou 'non'"
        start
    fi
}

hint() {
    declare -A hint_array
    hint_array['ADA_LOVELACE']="Bizarre la couleur..."
    hint_array['HEDY_LAMARR']="Elle est loin la marge !"
    hint_array['JEAN_BARTIK']="On voit pas le fond."
    hint_array['GRACE_HOPPER']="Elle est grosse la bordure."
    hint_array['EVELYN_BOYD']="J'aime bien m'habiller en noir !"
    hint_array['MARGARET_HAMILTON']="Decale moi ca !"
    hint_array['JOAN_BALL']="C'est mieux avec la meme ecriture."
    hint_array['ELISABETH_FEINLER']="Retire ta loupe."
    hint_array['JANESE_SWANSON']="Pas opaque le pack"
    hint_array['DONNA_DUBINSKY']="Y'a trop de vert..."

    echo "$hint_array[$1]"
}

game() {
    page="page$1"
    if [ -z "$3" ]; then
        chromium-browser "$path/pages_jeu/$page.html"
    fi
    echo "Si vous avez besoin de recommencer le niveau tapez 'recommencer'"
    echo "Si vous bloquez sur le niveau, tapez 'indice' \n"
    echo "Quel est le mot de passe que vous avez trouvé ?"
    read answeruser
    if [ "$answeruser" == "$2" ]; then
        echo "Bravo vous avez trouvé le mot de passe de la page numéro $1"
        echo "Vous passez maintenant au niveau suivant."
        python led_true.py &
        pkill -f chrono.py
        pkill chromium-browser
        clear
    elif [ "$answeruser" == "recommencer" ]; then
        pkill chromium-browser
        chromium-browser "$path/pages_jeu/$page.html"
        game "$1" "$2" "restart"
    elif [ "$answeruser" == "indice" ]; then
        hint "$2"
        game "$1" "$2" "restart"
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

    chromium-browser "$path/pages_bio/BIO_$1.html"

    echo -e "$question"

    while [ "$answeruser" != "$correct_answer" ]; do
        echo "Quel est votre réponse ?"
        read answeruser
        if [ "$answeruser" == "$correct_answer" ]; then
            python led_true.py
            echo "Bravo vous avez trouvé !"
            pkill chromium-browser
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
    



