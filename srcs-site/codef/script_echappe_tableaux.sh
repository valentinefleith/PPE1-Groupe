#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo &quot;Usage : ./creation_tableaux.sh /chemin/vers/urls.txt&quot;
    exit
fi

URLS=$1

if [ ! -f &quot;$URLS&quot; ]; then
    echo &quot;On attend un fichier, pas un dossier.&quot;
    exit
fi

LANGUE=$(basename -s .txt $URLS)

if [ $LANGUE = &quot;fr&quot; ]; then
		MOT=&quot;argent&quot;
fi
 
if [ $LANGUE = &quot;en&quot; ]; then
		MOT=&quot;money&quot;
fi

if [ $LANGUE = &quot;zh&quot; ]; then
		MOT=&quot;钱&quot;
fi

OUTPUT_FILE=&quot;../tableaux/tableau_${LANGUE}.html&quot;

echo &quot;&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;fr&quot;&gt;
&lt;head&gt;
	&lt;!--Métadonnées--&gt;
	&lt;meta charset=&quot;UTF-8&quot;/&gt;
	&lt;title&gt;Tableaux- PPE1 Projet Groupe&lt;/title&gt;
    &lt;meta name = &quot;author&quot; content = &quot;valentinefleith, ashleyratier, lidanzhang&quot;/&gt;
    &lt;meta name = &quot;keywords&quot; content = &quot;Argent&quot;/&gt;
    &lt;meta name = &quot;description&quot; content = &quot;Projet Groupe PPE1&quot;/&gt;

	&lt;!--Bootstrap--&gt;
    &lt;link href=&quot;https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css&quot; rel=&quot;stylesheet&quot; integrity=&quot;sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN&quot; crossorigin=&quot;anonymous&quot;&gt;
    &lt;script src=&quot;https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js&quot; integrity=&quot;sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL&quot; crossorigin=&quot;anonymous&quot;&gt;&lt;/script&gt;
    &lt;link rel=&quot;stylesheet&quot; type=&quot;text/css&quot; href=&quot;methode.css&quot;&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;table class=\&quot;table table-striped-columns\&quot;&gt;
		&lt;thead&gt;
		  &lt;tr&gt;
			&lt;th scope=&quot;col&quot;&gt;Nº ligne&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;URL&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Aspiration&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Dump&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Contexte&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Concordancier&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Code HTTP&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Encodage&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Compte&lt;/th&gt;
		  &lt;/tr&gt;
		&lt;/thead&gt;&quot; &gt; $OUTPUT_FILE
lineno=1
while read -r URL; do
	FICHIER_ASPIRATION=&quot;../aspirations/${LANGUE}-${lineno}.html&quot;

    response=$(curl -s -L -w &quot;%{http_code}&quot; -o &quot;$FICHIER_ASPIRATION&quot; &quot;$URL&quot;)
    encoding=$(curl -s -I -L -w &quot;%{content_type}&quot; -o /dev/null &quot;$URL&quot; | egrep -o &quot;charset=\S+&quot; | cut -d&quot;=&quot; -f2 | tail -n 1 | tr &apos;[:lower]&apos; &apos;[:upper&quot;]&apos;)
	COMPTE=0
	FICHIER_DUMP=&quot;NA&quot;
	FICHIER_CONTEXTE=&quot;NA&quot;
	CONCORDANCIER=&quot;NA&quot;
if [ $response -eq 200 ];then
	#creation du dump text
	if [[ ! $encoding == &quot;UTF-8&quot; ]]
	then
		iconv -f &quot;$encoding&quot; -t &quot;UTF-8&quot; &quot;$FICHIER_ASPIRATION&quot; &gt; &quot;temp.html&quot;
		mv &quot;temp.html&quot; &quot;$FICHIER_ASPIRATION&quot;
		encoding=&quot;UTF-8&quot;
	fi
		FICHIER_DUMP=&quot;../dump-texts/${LANGUE}-${lineno}.txt&quot;
		lynx -assume_charset=&quot;UTF-8&quot; -dump -nolist &quot;$FICHIER_ASPIRATION&quot; &gt; &quot;$FICHIER_DUMP&quot;

		COMPTE=$(egrep -i -o &quot;$MOT&quot; $FICHIER_DUMP | wc -l)

		#CONTEXTE=$(egrep -i -C 3 &quot;$MOT&quot; $FICHIER_DUMP)
		FICHIER_CONTEXTE=&quot;../contextes/${LANGUE}-${lineno}.txt&quot;
		egrep -i -C 3 &quot;$MOT&quot; $FICHIER_DUMP &gt; $FICHIER_CONTEXTE

		./concordancier.sh $MOT $lineno $FICHIER_CONTEXTE $LANGUE
		CONCORDANCIER=&quot;../concordances/${LANGUE}-${lineno}.html&quot;
    echo &quot;&lt;tbody&gt;
		&lt;tr&gt;
				&lt;th&gt;$lineno&lt;/th&gt;&lt;td&gt;$URL&lt;/td&gt;&lt;td&gt;&lt;a href=&apos;$FICHIER_ASPIRATION&apos;&gt;Aspiration&lt;/a&gt;&lt;/td&gt;&lt;td&gt;&lt;a href=&apos;$FICHIER_DUMP&apos;&gt;Dump&lt;/a&gt;&lt;/td&gt;&lt;td&gt;&lt;a href=&apos;$FICHIER_CONTEXTE&apos;&gt;Contexte&lt;/a&gt;&lt;/td&gt;&lt;td&gt;&lt;a href=&apos;$CONCORDANCIER&apos;&gt;Concordancier&lt;/a&gt;&lt;/td&gt;&lt;td&gt;$response&lt;/td&gt;&lt;td&gt;$encoding&lt;/td&gt;&lt;td&gt;$COMPTE&lt;/td&gt;
		&lt;/tr&gt;
		&lt;/tbody&gt;&quot; &gt;&gt; $OUTPUT_FILE

	else
		FICHIER_ASPIRATION=&quot;NA&quot;
		echo &quot;&lt;tbody&gt;
			&lt;tr&gt;
				&lt;th&gt;$lineno&lt;/th&gt;&lt;td&gt;$URL&lt;/td&gt;&lt;td&gt;$FICHIER_ASPIRATION&lt;/td&gt;&lt;td&gt;$FICHIER_DUMP&lt;/td&gt;&lt;td&gt;$FICHIER_CONTEXTE&lt;/td&gt;&lt;td&gt;$CONCORDANCIER&lt;/td&gt;&lt;td&gt;$response&lt;/td&gt;&lt;td&gt;$encoding&lt;/td&gt;&lt;td&gt;$COMPTE&lt;/td&gt;
			&lt;/tr&gt;
			&lt;/tbody&gt;&quot; &gt;&gt; $OUTPUT_FILE
fi
    lineno=$(expr $lineno + 1)
	echo &quot;OK&quot;
done &lt; &quot;$URLS&quot;
echo &quot;         &lt;/table&gt;
        &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;&quot; &gt;&gt; $OUTPUT_FILE

