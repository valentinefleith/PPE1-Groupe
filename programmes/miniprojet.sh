#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "On attend exactement un argument pour le script."
    exit
fi

URLS=$1

if [ ! -f "$URLS" ]; then
    echo "On attend un fichier, pas un dossier."
    exit
fi

echo "<html>"
echo "<head>"
echo "    <meta charset=\"UTF-8\">"
echo "    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">"
echo "    <style>"
echo "        .table-container {"
echo "            max-width: 1000px;"
echo "            margin: 0 auto;"
echo "        }"
echo "        .has-background-rose {"
echo "            background-color: #FFE7FE;"
echo "        }"
echo "    </style>"
echo "</head>"
echo "<body>"
echo "    <div class=\"container\">"
echo "        <h1 class=\"title is-1 has-text-centered has-text-grey\"><b>Tableau</b></h1>"
echo "        <div class=\"table-container\">"
echo "            <table class=\"table is-bordered is-striped is-hoverable is-fullwidth\">"
echo "                <tr class=\"has-background-rose\">"
echo "                    <th>Numero ligne</th><th>URL</th><th>Code HTTP</th><th>Encodage</th>"
echo "                </tr>"
lineno=1
while read -r URL; do
    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null "$URL")
    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null "$URL" | ggrep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    echo "                <tr>"
    echo "                    <td>$lineno</td><td>$URL</td><td>$response</td><td>$encoding</td>"
    echo "                </tr>"
    lineno=$(expr $lineno + 1)
done < "$URLS"
echo "            </table>"
echo "        </div>"
echo "    </div>"
echo "</body>"
echo "</html>"
