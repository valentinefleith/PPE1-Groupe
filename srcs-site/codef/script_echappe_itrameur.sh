#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
	echo &quot;Usage : ./make_itrameur_corpus dossier langue&quot;
	exit
fi

# langue = fr, en ou zh

dossier=$1
langue=$2
output_file=&quot;./itrameur/$dossier-$langue.txt&quot;


echo &quot;&lt;lang=\&quot;$langue\&quot;&gt;\n&quot; &gt; $output_file 

# On boucle parmi tous les fichiers textes

for fichier in $(ls ${dossier}/$langue*.txt)
do
	page=$(basename -s .txt $fichier)
	contenu=$(cat $fichier | sed &apos;s/&amp;/&amp;amp;/g&apos; | sed &apos;s/&lt;/&amp;lt;/g&apos; | sed &apos;s/&gt;/&amp;gt;/g&apos;)
	echo &quot;&lt;page=\&quot;${page}\&quot;&gt;
	&lt;text&gt;${contenu}&lt;/text&gt;
	&lt;/page&gt; §&quot; &gt;&gt; $output_file
done

echo &quot;&lt;/lang&gt;&quot; &gt;&gt; $output_file
