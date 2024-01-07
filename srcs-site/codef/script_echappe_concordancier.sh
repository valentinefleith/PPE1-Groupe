#!/usr/bin/env bash

if [[ $# -ne 4 ]]; then
	echo &quot;Usage : ./concordancier.sh mot noline contexte langue&quot;
    exit
fi

MOT=$1
lineno=$2
CONTEXTE=$3
LANGUE=$4

OUTPUT_FILE=&quot;../concordances/${LANGUE}-${lineno}.html&quot;

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
&lt;div class=&quot;container&quot;&gt;
    &lt;br/&gt;
    &lt;table class=\&quot;table table-striped-columns\&quot;&gt;
		&lt;thead&gt;
		  &lt;tr&gt;
			&lt;th scope=&quot;col&quot;&gt;Gauche&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Mot&lt;/th&gt;
			&lt;th scope=&quot;col&quot;&gt;Droite&lt;/th&gt;
		  &lt;/tr&gt;
		&lt;/thead&gt;&quot; &gt; $OUTPUT_FILE

if [ $LANGUE = &quot;zh&quot; ]; then
	#grep -P -o &quot;([\p{Script=Han}]+){0,7}($MOT)([\p{Script=Han}]+){0,7}&quot; $CONTEXTE | sed -E &quot;s/(.*)(($MOT))(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; &gt;&gt; $OUTPUT_FILE
	#grep -P -o &quot;([\p{Han}]+[^\p{Han}]+){0,5}($MOT)([\p{Han}]+[^\p{Han}]+){0,5}&quot; $CONTEXTE | sed -E &quot;s/(.*)($MOT)(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; &gt;&gt; $OUTPUT_FILE
	#grep -P -o &quot;([\p{Han}]{0,5}[^\p{Han}]{0,5})($MOT)([^\p{Han}]{0,5}[\p{Han}]{0,5}[^\p{Han}]+){0,5}&quot; $CONTEXTE | sed -E &quot;s/(.*)($MOT)(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; &gt;&gt; $OUTPUT_FILE
    #grep -P -o &quot;([\p{Han}]{0,5}[^\p{Han}]*?)($MOT)([^\p{Han}]*?[\p{Han}]{0,5})&quot; $CONTEXTE | sed -E &quot;s/(.*)($MOT)(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; &gt;&gt; $OUTPUT_FILE
	grep -P -o &quot;([\p{Han}]{0,5}[^\p{Han}]*?)($MOT)([^\p{Han}]*?[\p{Han}]{0,5})&quot; $CONTEXTE | sed -E &quot;s/(.*)($MOT)(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; &gt;&gt; $OUTPUT_FILE
    
    else
		egrep -o &quot;(\w+\W+){0,5}($MOT)(\W+\w+){0,5}&quot; $CONTEXTE | sed -E &quot;s/(.*)($MOT)(.*)/&lt;tr&gt;&lt;td&gt;\1&lt;\/td&gt;&lt;td&gt;\2&lt;\/td&gt;&lt;td&gt;\3&lt;\/td&gt;&lt;\/tr&gt;/&quot; | sed &quot;s/concordancier\.sh//g&quot; | sed &quot;s/creation_tableaux\.sh//g&quot; | sed &quot;s/make_itrameur_corpus\.sh//g&quot; | sed &quot;s/make_itrameur_corpus\.//g&quot; | sed &quot;s/creation_tableaux\.//g&quot; | sed &quot;s/concordancier\.sh//g&quot;  &gt;&gt; $OUTPUT_FILE
fi


echo &quot;      &lt;/table&gt;
        &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;&quot; &gt;&gt; $OUTPUT_FILE
