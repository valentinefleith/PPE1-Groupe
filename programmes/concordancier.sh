#!/usr/bin/env bash

if [[ $# -ne 4 ]]; then
	echo "Usage : ./concordancier.sh mot noline contexte langue"
    exit
fi

MOT=$1
lineno=$2
CONTEXTE=$3
LANGUE=$4

OUTPUT_FILE="../concordances/${LANGUE}-${lineno}.html"

echo "<!DOCTYPE html>
<html lang="fr">
<head>
	<!--Métadonnées-->
	<meta charset="UTF-8"/>
	<title>Tableaux- PPE1 Projet Groupe</title>
    <meta name = "author" content = "valentinefleith, ashleyratier, lidanzhang"/>
    <meta name = "keywords" content = "Argent"/>
    <meta name = "description" content = "Projet Groupe PPE1"/>

	<!--Bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="methode.css">
</head>
<body>
<div class="container">
    <br/>
    <table class=\"table table-striped-columns\">
		<thead>
		  <tr>
			<th scope="col">Gauche</th>
			<th scope="col">Mot</th>
			<th scope="col">Droite</th>
		  </tr>
		</thead>" > $OUTPUT_FILE

if [ $LANGUE = "zh" ]; then
	#grep -P -o "([\p{Script=Han}]+){0,7}($MOT)([\p{Script=Han}]+){0,7}" $CONTEXTE | sed -E "s/(.*)(($MOT))(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
	#grep -P -o "([\p{Han}]+[^\p{Han}]+){0,5}($MOT)([\p{Han}]+[^\p{Han}]+){0,5}" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
	#grep -P -o "([\p{Han}]{0,5}[^\p{Han}]{0,5})($MOT)([^\p{Han}]{0,5}[\p{Han}]{0,5}[^\p{Han}]+){0,5}" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
    #grep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)($MOT)([^\p{Han}]*?[\p{Han}]{0,5})" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
	ggrep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)($MOT)([^\p{Han}]*?[\p{Han}]{0,5})" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
    
    else
		egrep -o "(\w+\W+){0,5}($MOT)(\W+\w+){0,5}" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" | sed "s/concordancier\.sh//g" | sed "s/creation_tableaux\.sh//g" | sed "s/make_itrameur_corpus\.sh//g" | sed "s/make_itrameur_corpus\.//g" | sed "s/creation_tableaux\.//g" | sed "s/concordancier\.sh//g"  >> $OUTPUT_FILE
fi


echo "      </table>
        </div>
</body>
</html>" >> $OUTPUT_FILE
