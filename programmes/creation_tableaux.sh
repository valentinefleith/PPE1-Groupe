#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
	echo "Usage : ./creation_tableaux.sh /chemin/vers/urls.txt nom_langue(francais, anglais, chinois)"
    exit
fi

URLS=$1

if [ ! -f "$URLS" ]; then
    echo "On attend un fichier, pas un dossier."
    exit
fi

LANGUE=$2
LANGUE_ATTENDUE="anglais|francais|chinois"
if [[ ! $LANGUE =~ $LANGUE_ATTENDUE ]]; then
    echo "La langue doit etre anglais, francais ou chinois."
    exit
fi

OUTPUT_FILE="../tableaux/tableau_${LANGUE}.html"
echo "<html>
<head>
    <meta charset=\"UTF-8\">
    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
    <style>
        .table-container {
            max-width: 1000px;
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
                    <th>Numero ligne</th><th>URL</th><th>Aspiration</th><th>Dump</th><th>Code HTTP</th><th>Encodage</th>
                </tr>" > $OUTPUT_FILE
lineno=1
while read -r URL; do
    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null "$URL")
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null "$URL" | egrep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	FICHIER_ASPIRATION="../aspirations/${LANGUE}/aspiration${lineno}.txt"
	curl -s -L $URL > $FICHIER_ASPIRATION
	FICHIER_DUMP="../dump-texts/${LANGUE}/dump${lineno}.txt"
	lynx -dump $URL > $FICHIER_DUMP	
    echo "<tr>
				<td>$lineno</td><td>$URL</td><td><a href='$FICHIER_ASPIRATION'>Aspiration</a></td><td><a href='$FICHIER_DUMP'>Dump</a></td><td>$response</td><td>$encoding</td>
		</tr>" >> $OUTPUT_FILE
    lineno=$(expr $lineno + 1)
	echo "OK"
done < "$URLS"
echo "            </table>
        </div>
    </div>
</body>
</html>" >> $OUTPUT_FILE
