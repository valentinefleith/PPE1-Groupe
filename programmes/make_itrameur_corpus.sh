#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
	echo "Usage : ./make_itrameur_corpus dossier langue"
	exit
fi

# langue = fr, en ou zh

dossier=$1
langue=$2
output_file="./itrameur/$dossier-$langue.txt"


echo "<lang=\"$langue\">\n" > $output_file 

# On boucle parmi tous les fichiers textes

for fichier in $(ls ${dossier}/$langue*.html)
do
	page=$(basename -s .html $fichier)
	contenu=$(cat $fichier | sed 's/&/&amp;/g' | sed 's/</&lt;/g' | sed 's/>/&gt;/g')
	echo "<page=\"${page}\">
	<text>${contenu}</text>
	</page> §" >> $output_file
done

echo "</lang>" >> $output_file
