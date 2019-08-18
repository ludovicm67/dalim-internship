# Organisation du stage

## Présentation de l'entreprise

Dalim Software GmbH est une société allemande fondée en 1986, aujourd'hui dirigée par Carol Werlé.
Son chiffre d'affaires est de l'ordre de 5 millions d'euros.
Elle compte une soixantaine de collaborateurs.
L'entreprise est éditrice de logiciels.
Le siège social se situe en Allemagne, à l'entrée de Kehl.
Il s'agit d'une entreprise ayant une présence forte à l'international.
En effet, elle réalise la plus grande partie de son chiffre d'affaires en dehors de l'Allemagne, notamment sur le territoire américain, du fait que c'est là que se trouve la majorité de leur revendeurs et distributeurs.
Ses produits principaux concernent l'automatisation et la validation de visuels graphiques, tels que des catalogues, des livres ou emballages, ainsi que la gestion de flux de production.
Ses clients les plus importants sont dans les domaines de l'impression, de la publicité, de la prépresse et de l'édition de médias.
Ses principaux concurrents sont Enfocus et Adobe.

![Siège de Dalim Software à Kehl](./images/dalim.jpg)

Un certain nombre de services sont présents au siège à Kehl : toute la partie marketing, comptable, développement et gestion de l'infrastructure informatique.

L'équipe IT a pour mission de gérer l'infrastructure informatique de Dalim Software.
Elle est pilotée par Vincent Demange qui est aussi mon tuteur de stage.
Jean-Yves Meyer qui est plutôt chargé de la partie réseau, et Melwin Kieffer qui s'occupe principalement du déploiement des différents services complètent l'équipe.
Ma place en tant que stagiaire était au sein de ce trinôme.

## Objectif du stage

Ma mission principale lors de ce stage était de trouver la solution qui répond au mieux aux besoins de l'entreprise pour déployer des grappes Kubernetes, tout en documentant l'ensemble de mes démarches et de transmettre le savoir acquis aux membres de l'équipe IT, qui sera chargée de les maintenir.

En plus de cela, j'ai pu me rendre disponible pour donner mon avis sur certains sujets et aider l'équipe IT à remettre au goût du jour certains services que je détaillerai dans la suite de ce rapport.

## Les outils utilisés

### MacBook Pro

Lors de mon stage j'ai utilisé un MacBook Pro. Il s'agissait de la première fois que j'en utilisais.
Je me suis plutôt bien adapté au pavé tactile et à l'interface, mais j'ai eu beaucoup de mal avec le clavier en QWERTY, sans compter les soucis que rencontrent les touches des claviers des MacBook récents.

Dans l'ensemble, j'en tire une assez bonne expérience : l'interface est intuitive tout comme les gestes pris en charge par le pavé tactile.
La machine était performante, avec notamment beaucoup de RAM et d'espace disque en SSD.
Le seul point négatif pour moi était le clavier.

### Versionnement avec `git` et gestion des dépôts sur GitLab

Versionner son projet est quelque chose de primordial. Pour pouvoir revenir en arrière, travailler avec différentes branches, travailler à plusieurs sur un même projet, `git` est l’outil idéal !

Dalim Software héberge ses dépôts sur une instance de GitLab hébergée en interne.
J'ai eu l'occasion de paramétrer l'intégration et le déploiement continue pour certains de mes projets.
J'ai par exemple été amené à utiliser l'intégration d'un cluster Kubernetes au sein de certains projets sur cette instance de GitLab, de sorte à pouvoir les déployer automatiquement sur le cluster.

### Confluence

Confluence est un logiciel de wiki propriétaire édité par Atlassian depuis 2004.

Pour centraliser le savoir et la documentation, l'ensemble du personnel de l'entreprise, peu importe le service, s'est mis d'accord pour utiliser un même outil : Confluence.

Une instance interne a donc été déployée pour ce besoin, et c'est sur cette instance que j'ai pu documenter l'essentiel de mon travail effectué lors de mon stage.

### Autres outils

Outre mon éditeur de texte, mon terminal, mon navigateur web et ma messagerie électronique, je n’ai pas réellement eu besoin d’utiliser d’outils supplémentaires lors de mon stage.
