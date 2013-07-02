pgc
===

PGC LaTeX Class

Info
----
Le paquet PGC a été spécialement créer pour le cours de Physique Générale C de l'université de Genève, mais peut très bien être utilisé pour d'autres cours.

Celui-ci est retro-compatible avec les anciens formats d'exercices de nos archives. Toutefois le passage au nouveau format (voir les fichiers exemples nom finissant en _nouveau) est fortement recommendé, la mise en page est nettement meilleures.

Utilisation
-----------
Avec l'option solution, le corrigé sera généré. Sans celle-ci l'énoncé sera généré.

\documentclass[11pt,a4paper,solution]{pgc} % "solution" display solution only.

Un environement 'choices' redéfinit les listes pour les QCM:
    
La question tant attendue dont la réponse est :
\begin{choices}
    \choice Peut-être
    \choice Eventuellement
    \correctchoice Et bien oui
           \ifissolution, même avec un complement de réponse. \fi
    \choice Non surtout pas
\end{choices}

Un environement 'exercise' et 'solution' sont utilisés pour les exercices
\begin{exercise}
L'énoncé d'un nouveau problème\\
Une deuxième ligne.
\end{exercise}
\begin{solution}
La solution
\end{solution}

Bug
---
Ne pas laisser de lignes vides entre le \end{exercise} et \begin{solution} sinon l'alignement sera défectueux.


Licence
-------
La classe PGC est le code sont disponible sous licence GPL v3.


François Bianco, le 2 juillet 2013