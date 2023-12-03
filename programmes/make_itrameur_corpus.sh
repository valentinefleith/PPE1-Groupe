#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
	echo "Usage : ./make_itrameur_corpus dossier langue"
	exit
fi

# langue = fr, en ou zh

dossier=$1
langue=$2

echo "<lang=\"$langue\">\n" > "./itrameur/$dossier-$langue.txt"

# On boucle parmi tous les fichiers textes
if [ $langue = "zh" ]
then
	nom_dossier="chinois"
fi

if [ $langue = "en" ]
then
	nom_dossier="anglais"
fi

if [ $langue = "fr" ]
then
	nom_dossier="francais"
fi

for fichier in $(ls ${dossier}/${nom_dossier}/*.html)
do
	pagename=$(basename -s .html $fichier)
	echo $pagename




done
