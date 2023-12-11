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
                    <th>Gauche</th><th>Mot</th><th>Droite</th>
		</tr>" > $OUTPUT_FILE

if [ $LANGUE = "zh" ]; then
		egrep -o "([\\p{Script=Hani}]+[^\p{Script=Hani}]+){0,7}($MOT)([^\p{Script=Hani}]+[\\p{Script=Hani}]+){0,7}" $CONTEXTE | sed -E "s/(.*)(($MOT))(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE

	else

		egrep -o "(\w+\W+){0,7} ($MOT) (\w+\W+){0,7}" $CONTEXTE | sed -E "s/(.*)($MOT)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $OUTPUT_FILE
fi


echo "            </table>
        </div>
    </div>
</body>
</html>" >> $OUTPUT_FILE
