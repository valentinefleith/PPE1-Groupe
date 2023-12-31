# Journal de Bord - Programmation et Projet Encadré (Groupe)

Membres du groupe : Ashley Ratier, Lidan Zhang, Valentine Fleith

## Choix du mot

Les trois langues que nous allons étudier sont le français, l'anglais et le chinois.

Nous nous sommes mises d'accord pour choisir le mot **"argent"** pour notre projet. Nous avons choisi ce mot nous sommes intéressées de découvrir ses utilisations et ses emplois sur les pages web dans différentes langues.

_-> Ce mot est-il majoritairement utilisé par des économistes ? Ou bien ces derniers emploient-ils des mots plus précis ?_ 

_-> Y a-t-il est sentiments qui gravitent autour du mot "argent" ? Lesquels ?_

_-> Comment la vision de l'argent diffère-t-elle d'un pays à l'autre ? (de plus, en français, ce mot a un homonyme)_


## le français

## l'anglais

En anglais, le mot est "money".

## le chinois

- En chinois, la particule **"钱" (qián)** est souvent utilisée pour désigner l'argent, la monnaie ou la richesse matérielle en général. Toutefois, l'utilisation de cette particule seule ne capture pas toutes les nuances et les implications culturelles associées à la notion d'argent. Lorsqu'elle est combinée avec d'autres caractères, elle crée des termes qui évoquent des idées plus spécifiques ou des contextes particuliers.

_-> Comment la combinaison de la particule "钱" (qián) avec d'autres caractères en chinois, tels que "金" (jīn) pour former "金钱" (jīnqián,argent) ou "钱币"(qiánbì, monnaie), reflète-t-elle les nuances culturelles et les valeurs associées à la notion d'argent dans la société chinoise contemporaine ?


# Miniprojet groupe (26/11/2023)

Nous écrivons dans le journal en tant que groupe (nous avons travaillé ensemble sur le projet). 

Nous avions 5 exercices à faire. Nous avons dû réunir nos trois scripts du miniprojet en un seul : nous avons choisi le tableau d'Ashley pour des raisons esthétiques.
Notre script est réuni [ici](/programmes/creation_tableaux.sh).
Pour les exercices 1-4, pas de difficultés particulières.
Au début, on voulait ajouter la langue en argument mais grâce à la correction en cours, nous avons découvert `basename` qui nous permet de récupérer automatiquement la langue à partir du nom de fichier d'urls.
En revanche, l'exercice 5 a été plus laborieux. Nous ne sommes toujours pas certaines que la version actuelle fonctionne complètement, mais au moins des mots s'affichent.


Certains de nos sites sont des pages de forums : il y a beaucoup d'urls à la fin du site, qui "polluent" un peu notre dump texte. Il faudra peut-être faire un tri dans les pages plus tard.

Concernant les concordanciers, bizarrement cela a fonctionné pour l'anglais et le francais mais pas pour le chinois. C'est probablement a cause de l'expression reguliere qui ne reconnait pas les caracteres chinois.

# 03/12/2023
Nous avons du faire git rm avec tous les fichiers qu'on a classifiés respectivement dans des fichiers francais/anglais/chinois pour pouvoir les remettre tous les dans les mêmes fichiers et puis les renommer en fr/en/zh.

# Itrameur
Après avoir lu le mannuel de Itrameur fourni sur GitHub, nous avons pu procéder notre analyse des 3 langues avec cet outil. On a ensuite déduit les étapes suivantes pour utiliser iTrameur pour que ce soit plus compréhensible: charger fichier --> sélectionner dans "trame" dictionnaire --> sélectionner les mots indésirables -->  dans paramètere tout en haut on met "money/argent" --> coocs, cocher stopliste --> cliquer sur cocurrences --> nb terme gauche / droite : 5 --> SPmin 10
• On remarque que pourtant le site tombe parfois en panne en raison de genération des graphes de cocurrences.

• Pour l'analyse de l'anglais, on a eu le résultat comme ci-dessous:
![image](https://github.com/valentinefleith/PPE1-Groupe/assets/125041345/8e5858cf-ee30-469e-98ed-5b19e12b83c1)

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/125041345/3b130018-e502-4d4c-bbf5-babd2690091c)

On voit que les 5 mots les plus fréquents sur nos corpus de sites sont: article, everyday, talk, learn, troubles

• Pour l'analyse du français on a obtenu ces résultats : 
Pour les dump : 

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145553165/d172e3f4-724d-43c0-a535-4d8ab8d6a01c)

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145553165/564b0893-db17-48a4-986a-4e742ceb1ff2)



Il y a pas mal de mots inutiles et de lettres seules mais les 5 mots les plus fréquents sont or, métaux, famille, pièces, catégories.

Pour les contextes : 

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145553165/fb7911b7-19c2-40d7-a179-7530a1a3621b)

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145553165/8ab2baa9-d69b-414e-b19b-80dabec89e79)

les 5 mots les plus fréquents sont : or, métaux, famille, gamme, rond, et il u a également des mots et lettres parasites.


• Pour l'analyse du chinois, on suppose que car notre corpus chinois n'a pas été tokénizé, le résultat sur iTrameur n'est pas du tout attendu:
On a des centaines de tokens indésirables (des chiffres inutiles, https, des mots anglais inutiles qui vont jusqu'à la cinquantaine de page sur iTrameur dans la colonne "selection"; ou alors on trouve une phrase entière contenant une vingtaine de caractères et cela n'est évidemment non plus le résultat attendu:

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145340927/76cde544-b68b-40a9-949a-5ea755568d43)

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/145340927/c88ebf09-046c-475e-a602-9f45d7d681f4)

# 11/12/2023
Après avoir tokénisé le chinois, on a réussi avec la partie itrameur avec les résultats suivants: <img width="273" alt="image" src="https://github.com/valentinefleith/PPE1-Groupe/assets/145340927/5da66bf5-83a4-411c-86bd-db5aadb793f7">

<img width="688" alt="image" src="https://github.com/valentinefleith/PPE1-Groupe/assets/145340927/469e388d-034b-43e8-9a6f-6ae2211421f7">


### Problemes 

Nous avons des problemes pour le script de concordancier et nous ne trouvons pas de correction de ce script : le script ne fonctionne pas du tout pour le chinois. Nous supposons que c'est a cause de l'expression reguliere qui ne reconnait pas les caracteres chinois. Est-ce qu'il y a une alternative a `\w` pour le chinois ? Nous avons essaye avec `\p{Script=Han}` mais cela ne marche que partiellement (on a toujours le meme mot qui est reconnu partout) :
![image](https://github.com/valentinefleith/PPE1-Groupe/assets/125041345/e03bcc98-5705-4b48-93de-211178081df4)

Nous avons reussi a resoudre d'autres problemes mais ne sommes pas sures que notre script de concordancier soit correct. Il serait plus facile de pouvoir comparer avec une correction.

Nous avons reussi a creer des wordcloud pour toutes les langues mais malgre des essais d'installation de Fonts pour le chinois, les caracteres ne s'affichent pas. Il faut reussir a regler le probleme.

