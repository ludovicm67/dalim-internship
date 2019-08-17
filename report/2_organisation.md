# Organisation du stage

## Présentation de l'entreprise

Dalim Software GmbH est une société allemande qui a été fondée en 1986.
Elle compte aujourd'hui une soixantaine de collaborateurs.
Le siège social se situe en Allemagne, à l'entrée de Kehl.
Son chiffre d'affaires est de l'ordre de 5 millions d'euros.
L'entreprise est éditrice de logiciels, notamment en ce qui concerne l'automatisation et la validation de visuels graphiques, tels que des catalogues, des livres ou emballages par exemple, ainsi que la gestion de flux de production.
Ses clients les plus importants sont dans les domaines de l'impression, de la publicité, de la prépresse et l'édition de médias.
Ses principaux concurrents sont Enfocus et Adobe.

![Siège de Dalim Software à Kehl](./images/dalim.jpg)

## Objectif du stage

Ma mission principale lors de ce stage était de trouver la solution qui répond au mieux aux besoins de l'entreprise pour déployer des clusters Kubernetes, tout en documentant l'ensemble de mes démarches et de transmettre le savoir acquis aux membres de l'équipe IT, qui sera chargée de les maintenir.

En plus de cela, j'ai pu me rendre disponible pour donner mon avis sur certains sujets et aider l'équipe IT à remttre au goût du jour certains services que je détaillerai dans la suite de ce rapport.

## Les outils utilisés

### MacBook Pro

Lors de mon stage j'ai utiliser un MacBook Pro. Il s'agissait de la première fois que j'en utilisais.
Je me suis plutôt bien adapté au trackpad et à l'interface, mais j'ai eu beaucoup de mal avec le clavier, qui était en QWERTY, sans compter les soucis que rencontrent les touches des claviers des MacBook récents.

Dans l'ensemble, j'en tire une assez bonne expérience : l'interface est intuitive tout comme les gestes pris en charge par le trackpad.
La machine était vraiment performante, avec notamment beaucoup de RAM et d'espace disque en SSD.
Le seul point noir pour moi était le clavier.

### Versionning avec `git` et gestion des dépôts sur GitLab

Versionner son projet est vraiment quelque chose de primordial. Pour pouvoir revenir en arrière, travailler avec différentes branches, travailler à plusieurs sur un même projet, `git` est vraiment l’outil idéal !

Dalim Software héberge ses dépôts sur une instance de GitLab hébergée en interne.
J'ai eu l'occasion de paramétrer l'intégration et le déploiement continue pour certains de mes projets.
J'ai par exemple été amené à utiliser l'intégration d'un cluster Kubernetes au sein de certains projets sur cette instance de GitLab, de sorte à pouvoir les déployer automatiquement sur le cluster.

### Confluence

Confluence est un logiciel de wiki propriétaire édité par Atlassian depuis 2004.

Pour centraliser le savoir et la documentation, l'ensemble du personnel de l'entreprise, peu importe le service, s'est mis d'accord pour utiliser un même outil : Confluence.

Une instance interne a donc été déployée pour ce besoin, et c'est sur cette instance que j'ai pu documenter l'essentiel de mon travail effectué lors de mon stage.

### Autres outils

Outre mon éditeur de texte, mon terminal, mon navigateur web et ma messagerie électronique, je n’ai pas réellement eu besoin d’utiliser d’outils supplémentaires lors de mon stage.
