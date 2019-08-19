# Organisation du stage

## Présentation de l'entreprise

Dalim Software GmbH [@dalim_home] est une société allemande fondée en 1985, aujourd'hui dirigée par Carol Werlé.
Son chiffre d'affaires (CA) est de l'ordre de 5 millions d'euros.
Elle compte une soixantaine de collaborateurs.
L'entreprise est éditrice de logiciels.
Le siège social se situe en Allemagne, à l'entrée de Kehl.
La figure \ref{fig_dalim} est une photo de ce dernier.

Il s'agit d'une entreprise ayant une forte présence à l'international.
En effet, la majorité de leur revendeurs et distributeurs se trouvent dans plus de trente pays, dont les États-Unis (30% du CA), l'Allemagne et la France (30%), le Royaume-Uni, l'Italie et le reste de l'Europe (30%).
Le Brésil, l'Afrique du Sud, le Japon et le reste des pays du monde représentent quant à eux les 10% restants.

Ses produits principaux concernent l'automatisation et la validation de visuels graphiques, tels que des catalogues, des livres ou emballages, ainsi que la gestion de flux de production.

On y trouve par exemple ES [@dalim_es], son produit phare, un outil de gestion de traitement et validation de documents numériques.
Il permet d'ajouter des annotations, versionner les différents documents de travail, les inspecter, les éditer et les faire valider par différentes équipes.
Ces documents peuvent être des visuels, des fichiers PDF, des sites web ou des emballages tridimensionnels.

On retrouve également Twist [@dalim_twist], un moteur de traitement de flux de fichiers.
On peut y définir de manière graphique les différentes étapes de traitement des documents : analyses, conversions, stockage, renommages.

Litho permet de créer et éditer des fichiers PDF ou PostScript ainsi que toutes sortes de formats de fichiers spécifiques pour les imprimeurs.
Il leur permet notamment de faire des corrections de dernière minute avant impression sur les rotatives, notamment pour simplifier certains documents.

Dialogue Engine [@dalim_dialogue] est quant à lui un outil de contrôle qualité collaboratif en ligne qui offre un kit de développement puissant pour l'intégrer avec des outils déjà en place.

PDFLight [@dalim_pdf] est un petit outil qui permet de compresser des fichiers PDF.
Le taux moyen de compression observé est de plus de 90%.

Les clients les plus importants de Dalim Software appartiennent aux domaines de l'impression, de la publicité, du prépresse et de l'édition de médias.

Ses principaux concurrents sont Enfocus et Adobe.

![Siège de Dalim Software à Kehl (source : service marketing) \label{fig_dalim}](./images/dalim.jpg)

L'entreprise est constituée de différents services qui sont tous présents au siège à Kehl, dont la hiérarchie est visible sur la figure \ref{fig_services}.

![Organigramme des différents services de l'entreprise \label{fig_services}](./images/screen/services.png)

Tout d'abord on trouve la direction générale.
C'est elle qui prend les décisions importantes pour définir le cap de l'entreprise.

La direction scientifique est chargée de faire de la veille technologique, créer des prototypes, et évaluer des nouvelles technologies.
Ces dernières pourront être utilisées en interne, telle que le choix du logiciel de gestion d'entreprise à utiliser, tout comme celles qui seront utilisées à l'avenir pour la conception de logiciels futurs.

Le service de l'administration, des finances et de la comptabilité ainsi que des ressources humaines s'occupe de la gestion du personnel ainsi que du budget.

Étant donnée que Dalim conçoit des logiciels, une équipe est dédiée à leur conception et au contrôle de la qualité.
Un autre service quant à lui est dédié à assurer le support technique et le service après-vente.

Le service de marketing et de communication a pour but de promouvoir l'entreprise ainsi que ses logiciels, afin de se faire connaître et attirer de nouveaux clients.
Un service est justement dédié aux ventes et au développement des relations commerciales.

L'équipe IT a pour mission de gérer l'infrastructure informatique de Dalim Software.
Elle est pilotée par Vincent Demange, directeur des systèmes d'information, qui est aussi mon tuteur de stage.
Jean-Yves Meyer est ingénieur système.
Il principalement chargé de la partie réseau.
Melwin Kieffer, ingénieur logiciel, s'occupe quant à lui principalement du développement des outils internes et des différents services.
Ma place en tant que stagiaire était au sein de ce trinôme.

## Objectif du stage

Ma mission principale lors de ce stage était de trouver la solution qui répondait au mieux aux besoins de l'entreprise pour déployer des grappes Kubernetes, tout en documentant l'ensemble de mes démarches et en transmettant le savoir acquis aux membres de l'équipe IT, qui sera chargée de les maintenir.

J'ai également pu partager mon avis sur différents sujets, et aider l'équipe IT à remettre au goût du jour certains services que je détaillerai dans la suite de ce rapport.

## Outils utilisés

### MacBook Pro

Lors de mon stage j'ai utilisé un MacBook Pro. Il s'agissait de la première fois que j'en utilisais.
Je me suis plutôt bien adapté au pavé tactile et à l'interface, mais j'ai eu beaucoup de mal avec le clavier en QWERTY, sans compter les soucis que rencontrent les touches des claviers des MacBook récents.

Dans l'ensemble, j'en tire une assez bonne expérience : l'interface est intuitive tout comme les gestes pris en charge par le pavé tactile.
La machine était performante, avec notamment beaucoup de RAM et d'espace disque en SSD.
Le seul point négatif pour moi était le clavier.

### Versionnement avec Git et gestion des dépôts sur GitLab

Versionner son projet est primordial.
Pour revenir en arrière, travailler avec différentes branches, travailler à plusieurs sur un même projet, Git [@git] est l’outil idéal !

Dalim Software héberge ses dépôts sur une instance de GitLab [@gitlab] hébergée en interne.

J'ai par exemple été amené à paramétrer et utiliser l'intégration d'une grappe Kubernetes au sein de certains projets sur cette instance de GitLab, de sorte à pouvoir les déployer automatiquement sur la grappe.

### Confluence

Confluence [@confluence] est un logiciel de wiki propriétaire édité par Atlassian depuis 2004.

Pour centraliser le savoir, la documentation ainsi que les différents comptes-rendus de réunions, l'ensemble du personnel de l'entreprise, peu importe le service, s'est mis d'accord pour utiliser un même outil : Confluence.

Une instance interne a donc été déployée pour répondre à ce besoin, et c'est sur cette dernière que j'ai pu documenter l'essentiel de mon travail effectué lors de mon stage.

C'est aussi via cet outil que nous avons listé, suite à une réunion au début de mon stage, l'ensemble de mes objectifs dans le détail.

### Docker

Au cours de mon stage j'ai été amené à lancer, créer et pousser de nombreuses images Docker [@docker] sur différents registres.

### Communication

La messagerie électronique ainsi que Slack [@slack] étaient utilisés pour échanger en interne.

### Autres outils

Outre mon éditeur de texte, mon terminal, mon navigateur web et les outils faisant partie de l'environnement Kubernetes [@k8s], je n’ai pas réellement eu besoin d’utiliser d’outils supplémentaires lors de mon stage.
