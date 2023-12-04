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


# Itrameur
Pour l'analyse de l'anglais, on a eu le résultat comme ci-dessous:
![image](https://github.com/valentinefleith/PPE1-Groupe/assets/125041345/8e5858cf-ee30-469e-98ed-5b19e12b83c1)

![image](https://github.com/valentinefleith/PPE1-Groupe/assets/125041345/3b130018-e502-4d4c-bbf5-babd2690091c)

On voit que les 5 mots les plus fréquents sur nos corpus de sites sont: article, everyday, talk, learn, troubles
