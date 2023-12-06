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
echo "<html>
<head>
    <meta charset=\"UTF-8\">
    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
    <style>
        .table-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .has-background-rose {
            background-color: #FFE7FE;
        }
    </style>
</head>
<body>
    <div class=\"container\">
        <h1 class=\"title is-1 has-text-centered has-text-grey\"><b>Tableau</b></h1>
        <div class=\"table-container\">
            <table class=\"table is-bordered is-striped is-hoverable is-fullwidth\">
                <tr class=\"has-background-rose\">
                    <th>Numero ligne</th><th>URL</th><th>Aspiration</th><th>Dump</th><th>Contexte</th><th>Concordancier</th><th>Code HTTP</th><th>Encodage</th><th>Compte</th>
                </tr>" > $OUTPUT_FILE
lineno=1
while read -r URL; do
	FICHIER_ASPIRATION="../aspirations/${LANGUE}-${lineno}.html"

    response=$(curl -s -L -w "%{http_code}" -o "$FICHIER_ASPIRATION" "$URL")
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null "$URL" | egrep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower]' '[:upper"]')
	COMPTE=0
	FICHIER_DUMP="NA"
	FICHIER_CONTEXTE="NA"
	CONCORDANCIER="NA"
if [ $response -eq 200 ];then
	#creation du dump text
	if [[ ! $encoding == "UTF-8" ]]
	then
		iconv -f "$encoding" -t "UTF-8"
	fi
		FICHIER_DUMP="../dump-texts/${LANGUE}-${lineno}.html"
		lynx -dump -nolist -assume_charset=$encoding $URL > $FICHIER_DUMP

		COMPTE=$(egrep -o "$MOT" $FICHIER_DUMP | wc -l)

		CONTEXTE=$(egrep -A2 -B2 "$MOT" $FICHIER_DUMP)
		FICHIER_CONTEXTE="../contextes/${LANGUE}-${lineno}.html"
		echo $CONTEXTE > $FICHIER_CONTEXTE

		./concordancier.sh $MOT $lineno $FICHIER_CONTEXTE $LANGUE
		CONCORDANCIER="../concordances/${LANGUE}-${lineno}.html"
fi
    echo "<tr>
				<td>$lineno</td><td>$URL</td><td><a href='$FICHIER_ASPIRATION'>Aspiration</a></td><td><a href='$FICHIER_DUMP'>Dump</a></td><td><a href='$FICHIER_CONTEXTE'>Contexte</a></td><td><a href='$CONCORDANCIER'>Concordancier</a></td><td>$response</td><td>$encoding</td><td>$COMPTE</td>
		</tr>" >> $OUTPUT_FILE


    lineno=$(expr $lineno + 1)
	echo "OK"
done < "$URLS"
echo "            </table>
        </div>
    </div>
</body>
</html>" >> $OUTPUT_FILE
