#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo "Usage : ./creation_tableaux.sh /chemin/vers/urls.txt"
    exit
fi

URLS=$1

if [ ! -f "$URLS" ]; then
    echo "On attend un fichier, pas un dossier."
    exit
fi

LANGUE=$(basename -s .txt $URLS)

if [ $LANGUE = "fr" ]; then
		MOT="argent"
fi
 
if [ $LANGUE = "en" ]; then
		MOT="money"
fi

if [ $LANGUE = "zh" ]; then
		MOT="钱"
fi

OUTPUT_FILE="../tableaux/tableau_${LANGUE}.html"

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
    <table class=\"table table-striped-columns\">
		<thead>
		  <tr>
			<th scope="col">Nº ligne</th>
			<th scope="col">URL</th>
			<th scope="col">Aspiration</th>
			<th scope="col">Dump</th>
			<th scope="col">Contexte</th>
			<th scope="col">Concordancier</th>
			<th scope="col">Code HTTP</th>
			<th scope="col">Encodage</th>
			<th scope="col">Compte</th>
		  </tr>
		</thead>" > $OUTPUT_FILE
lineno=1
while read -r URL; do
	FICHIER_ASPIRATION="../aspirations/${LANGUE}-${lineno}.html"

    response=$(curl -s -L -w "%{http_code}" -o "$FICHIER_ASPIRATION" "$URL")
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null "$URL" | egrep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower]' '[:upper"]')
	COMPTE=0
	FICHIER_DUMP="NA"
	FICHIER_CONTEXTE="NA"
	CONCORDANCIER="NA"
if [ $response -eq 200 ];then
	#creation du dump text
	if [[ ! $encoding == "UTF-8" ]]
	then
		iconv -f "$encoding" -t "UTF-8" "$FICHIER_ASPIRATION" > "temp.html"
		mv "temp.html" "$FICHIER_ASPIRATION"
		encoding="UTF-8"
	fi
		FICHIER_DUMP="../dump-texts/${LANGUE}-${lineno}.txt"
		lynx -assume_charset="UTF-8" -dump -nolist "$FICHIER_ASPIRATION" > "$FICHIER_DUMP"

		COMPTE=$(egrep -i -o "$MOT" $FICHIER_DUMP | wc -l)

		#CONTEXTE=$(egrep -i -C 3 "$MOT" $FICHIER_DUMP)
		FICHIER_CONTEXTE="../contextes/${LANGUE}-${lineno}.txt"
		egrep -i -C 3 "$MOT" $FICHIER_DUMP > $FICHIER_CONTEXTE

		./concordancier.sh $MOT $lineno $FICHIER_CONTEXTE $LANGUE
		CONCORDANCIER="../concordances/${LANGUE}-${lineno}.html"
    echo "<tbody>
		<tr>
				<th>$lineno</th><td>$URL</td><td><a href='$FICHIER_ASPIRATION'>Aspiration</a></td><td><a href='$FICHIER_DUMP'>Dump</a></td><td><a href='$FICHIER_CONTEXTE'>Contexte</a></td><td><a href='$CONCORDANCIER'>Concordancier</a></td><td>$response</td><td>$encoding</td><td>$COMPTE</td>
		</tr>
		</tbody>" >> $OUTPUT_FILE

	else
		FICHIER_ASPIRATION="NA"
		echo "<tbody>
			<tr>
				<th>$lineno</th><td>$URL</td><td>$FICHIER_ASPIRATION</td><td>$FICHIER_DUMP</td><td>$FICHIER_CONTEXTE</td><td>$CONCORDANCIER</td><td>$response</td><td>$encoding</td><td>$COMPTE</td>
			</tr>
			</tbody>" >> $OUTPUT_FILE
fi
    lineno=$(expr $lineno + 1)
	echo "OK"
done < "$URLS"
echo "         </table>
        </div>
</body>
</html>" >> $OUTPUT_FILE

