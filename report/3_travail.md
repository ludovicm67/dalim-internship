# Travail réalisé

J'ai principalement travaillé sur Kubernetes durant mon stage : j'ai analysé les besoins de l'entreprise pour trouver la meilleure façon pour déployer une grappe Kubernetes et déployer une instance de tests, tout en documentant ce que je faisais.

L'entreprise étant basée à l'étranger avec des personnes qui ne sont pas nécessairement francophones, l'ensemble du contenu est rédigé en langue anglaise.

De plus, j'ai eu l'occasion de faire une présentation à une grande partie des employés de l'entreprise pour leur présenter le concept de la conteneurisation et les avantages de Kubernetes.

J'ai également été chargé de remettre au goût du jour une application interne et la déployer sur une des grappes.

## Kubernetes

### Pourquoi Kubernetes ?

L'équipe IT au sein de l'entreprise a déjà massivement recours aux conteneurs, un ensemble de processus isolés au sein du système, pour leur infrastructure.
Elle utilise actuellement la version 1.6 de Rancher [@rancher16] pour gérer ces derniers.
Pour se donner un ordre de grandeur, il y a actuellement plus de 200 conteneurs actifs répartis à travers 18 machines virtuelles.

Cependant la gestion de ces conteneurs était assez lourde et limitée.
En effet avec l'infrastructure actuelle, il était difficile de déboguer une application particulière, du fait qu'il est compliqué de mettre en place un mécanisme de surveillance et d'alerte.

Il n'est également pas possible de faire de la mise à l'échelle automatique, notamment en fonction de la charge, tout comme il est impossible de déployer un conteneur automatiquement sur la machine ayant le plus de ressources disponibles.

L'équipe a donc pensé qu'utiliser Kubernetes pouvait être une solution qui serait en mesure de pallier ces problèmes et d'offrir une architecture plus actuelle et standard, qui puisse être déployée rapidement n'importe où, d'où l'intérêt de mon stage.

J'ai donc fait le tour de tout ce que pouvait offrir Kubernetes pour voir s'il s'agissait d'une solution pertinente pour Dalim Software, ce qui s'est révélé l'être étant donné que Kubernetes était en mesure de répondre à chacun des problèmes énumérés.

Il existe différentes manières de mettre en place une grappe Kubernetes.
J'ai donc exploré ces solutions afin de voir celle qui pourrait convenir au mieux, ce que je vais détailler dans la section suivante.

### Déploiement d'une grappe

Il existe de nombreuses manières de déployer une grappe Kubernetes.

La première catégorie permet d'avoir rapidement une grappe composée d'un seul nœud en local.
J'ai pu tester Docker Desktop [@docker_desktop], qui permet de lancer une grappe d'un simple clic sur Mac ou Windows.
Minikube [@minikube] est une alternative, qui à l'avantage de tourner sur Linux également.
Cela est pratique dans le but de se familiariser avec les fichiers de configuration ainsi que les différents outils pour gérer une grappe Kubernetes.
Parmi ces outils on retrouve notamment `kubectl` qui permet de gérer une grappe depuis le terminal.
Cependant, ces solutions ne sont pas faites pour de la production, étant donné que l'on n'a qu'un seul nœud et que l'on n'est donc pas en mesure d'assurer une haute disponibilité.
Si ce nœud tombe, l'ensemble des services sera indisponible, ce qui n'est pas envisageable.

La deuxième contient des outils pour déployer une grappe Kubernetes, tout en pouvant choisir finement ce que l'on souhaite y intégrer comme composants.
J'ai eu l'occasion de tester `kubeadm` [@kubeadm] et Kubespray [@kubespray].
Ce dernier permet d'utiliser Ansible [@ansible], une plateforme pour la configuration et gestion de machines, pour déployer une grappe.
L'avantage est qu'il est possible de versionner la configuration utilisée, mais elle reste toutefois complexe à mettre en œuvre.

La dernière permet de déployer rapidement une grappe de production, en intégrant des fonctionnalités supplémentaires.
Certains choix sont donc faits à notre place, mais on perd en complexité.
Dans cette catégorie on retrouve des offres portées par les principaux fournisseurs d'infrastructures numériques, comme GKE par Google [@gke], EKS par Amazon [@eks], AKS par Microsoft, des offres de DigitalOcean, IBM et OVH.

On y trouve également des projets comme Rancher [@rancher] dans sa seconde version, qui permettent de gérer plusieurs grappes, que ce soit celles gérées par des fournisseurs ou des grappes locales.
Je l'ai donc testé pour déployer des grappes locales et distantes chez Google et Amazon.
Un aspect positif est qu'en terme d'interface et de terminologie il y a un certain nombre de similitudes par rapport à la version actuellement utilisée en production pour la gestion de l'infrastructure.

Le fait de pouvoir gérer depuis une même interface les différentes grappes est un point pratique pour les besoins de l'équipe IT.
Rancher offre un certain nombre d'abstractions et permet de déployer des éléments naturellement complexes, tels des mécanismes de surveillance et d'alertes à propos de l'état de santé de la grappe en elle-même ainsi que des conteneurs, et ce de manière simple et rapide, avec une configuration pertinente et directement fonctionnelle.

Il est d'ailleurs relativement aisé de mettre à jour l'ensemble, ce qui devrait faciliter la maintenance du service sur le long terme.
Cependant la documentation du projet peut s'avérer parfois incomplète, notamment en ce qui concerne le mécanisme interne des abstractions proposées ou des droits requis pour faire tourner une grappe Kubernetes chez Amazon avec les permissions minimales, mais à part ça l'ensemble se révèle plutôt satisfaisant.

![Capture d'écran de l'interface de Rancher](./images/screen/rancher.png)

J'ai donc proposé d'utiliser Rancher pour la gestion des différentes grappes Kubernetes, choix qui a été validé par l'équipe.

### Évaluation des solutions de stockage

Kubernetes est un orchestrateur de conteneurs.
Certains services, tels que les bases de données, tournant au sein de certains conteneurs possèdent des informations qui doivent pouvoir être pérennisées.
Or, les conteneurs peuvent être détruits, recréés à partir d'une image n'importe quand et pas nécessairement sur la même machine.
Il faut donc faire persister ces données et les monter lors de la création du conteneur.

Kubernetes propose pour cela une abstraction et utilise un mécanisme de demande et d'offre : un service demande une quantité d'espace précise dans une plateforme de stockage.
Kubernetes va voir la demande, et, s'il a été configuré pour, sera en mesure de répondre à la demande.
Il ne restait plus qu'à choisir quelle solution de stockage on allait utiliser.

Une solution à base de GlusterFS a été mis en place par l'équipe IT.
Cependant les performances ne sont pas satisfaisantes.
J'ai donc été chargé de regarder quelles solutions de stockage peuvent s'intégrer parfaitement avec Kubernetes et offrent des performances correctes pour faire tourner l'ensemble des applications actuelles.

J'ai testé deux solutions : un montage NFS depuis une machine virtuelle sur le même serveur que celles utilisées par la grappe Kubernetes et du CephFS avec l'aide du projet Rook [@rook].
J'ai comparé avec les performances avec la solution actuellement déployée, en utilisant un banc de test d'accès aléatoire de fichiers depuis Java proposé par Atlassian [@bench].

: Résultats obtenus avec le banc de test d'Atlassian. Tous les temps sont en microsecondes. Les latences les plus faibles sont les meilleures en termes de performances. \label{table_eval_storage}

| Solution            | Ouverture | Lecture/écriture | Fermeture | Suppression |
|---------------------|----------:|-----------------:|----------:|------------:|
| GlusterFS (moyenne) |     4 418 |            3 268 |       332 |       2 045 |
| GlusterFS (médiane) |     3 193 |            2 871 |       296 |       1 815 |
| NFS (moyenne)       |       864 |               21 |     1 569 |         799 |
| NFS (médiane)       |       792 |               17 |     1 478 |         738 |
| Ceph (moyenne)      |        89 |               82 |         8 |          25 |
| Ceph (médiane)      |        20 |               15 |         7 |          23 |

On peut constater sur la table \ref{table_eval_storage} que dans les configurations évaluées NFS offre de meilleures performances que GlusterFS, excepté pour les fermetures, où elles sont cinq fois plus importantes.
Ceph offre de bien meilleurs résultats en termes de latences que les deux autres solutions.
Il permet aussi un stockage distribué à travers les différents nœuds de la grappe pour permettre un stockage sans point unique de défaillance.
Cependant on peut constater que la médiane diffère grandement de la moyenne, on doit donc s'attendre à avoir une grande variance, mais les performances sont quand-même excellentes.

On a donc fait le choix d'utiliser CephFS pour les grappes internes.

### Mécanisme de surveillance et d'alerte

Rancher offre la possibilité de déployer rapidement un mécanisme de surveillance et d'alerte reposant sur Prometheus [@prometheus], Alertmanager [@alertmanager] et Grafana [@grafana].

Un certain nombre de métriques sont déjà configurées par défaut, telles que le taux d'utilisation de processeur, de mémoire et de l'état de santé général de la grappe, mais il est toutefois possible d'exposer des métriques supplémentaires par des applications déployées.
La figure \ref{fig_grafana} est une capture d'écran de la vue d'un tableau de bord de Grafana, montrant l'état de santé d'une grappe Kubernetes.

![Vue d'ensemble de l'état de santé de la grappe depuis Grafana \label{fig_grafana}](./images/screen/dashboard.png)

Ces métriques peuvent être utilisées pour déclencher des alertes.
On peut imaginer par exemple déclencher l'envoi de notifications si jamais la grappe utilise trop de ressources ou n'est pas en bonne santé.
La figure \ref{fig_alert} est une capture d'écran d'une alerte reçue depuis Slack [@slack], une des solutions de communication utilisée en interne.

![Exemple d'alerte reçue sur Slack suite à un composant en mauvaise santé \label{fig_alert}](./images/screen/alert.png)

On peut également exploiter ces métriques pour faire de la mise à l'échelle automatique.

### Autres points d'attention

La majorité des services qui ont vocation à être déployés sur les différentes grappes Kubernetes sont accessibles via HTTP ou HTTPS.
Un point important a donc été de voir comment router le trafic au bon service en fonction de l'adresse utilisée et d'analyser les solutions principales.

La sécurité est également un point important.
J'ai notamment étudié la manière dont les certificats SSL/TLS pour les connexions en HTTPS peuvent être gérés et comment mettre en place une solution pour chiffrer les échanges entre les différents services s'exécutant au sein de la grappe.

L'intégration et le déploiement continu d'applications sont bénéfiques du moment où l'ensemble est bien configuré.
En effet à chaque fois que du code est poussé sur un dépôt Git, cela va lancer des jeux de tests, de construction d'images et de déploiement de l'application sur une grappe précise.
Cela permet d'automatiser les déploiements et d'en faire plus régulièrement, tout en s'assurant que l'ensemble est fonctionnel.

J'ai également pris le temps de rajouter des tests de santé d'application pour que Kubernetes puisse relancer les conteneurs qui auraient pu rencontrer des problèmes en cours de route.

### Présentation au sein des équipes

Étant donné que j'ai pu travailler sur Kubernetes et apprendre les différents concepts au cours de plusieurs semaines, j'ai été chargé par l'équipe IT de faire une présentation au sein de l'entreprise vers le milieu de la période de mon stage.
En effet, en souhaitant s'orienter vers une offre de logiciels en tant que services, les développeurs doivent être en accord sur la philosophie à adopter, dans le but d'avancer ensemble dans une même direction.

Ma présentation consistait dans un premier temps à expliquer le principe des conteneurs, leur utilité et comment créer des images.
J'ai ensuite introduit un certain nombre de concepts de Kubernetes, sans spécialement entrer dans l'aspect technique, dans le but de donner une vue d'ensemble des possibilités offertes par un orchestrateur de conteneurs et fournir un aperçu des problèmes auxquels il répond.

En amont, j'ai pu discuter avec Thierry Rolland, le responsable du développement, afin de voir quelles seraient les aspects de Kubernetes qui pourraient leur être le plus utile, et orienter ma présentation en fonction.
Il en est ressorti que la capacité à lancer de nouvelles instances de services de traitement en fonction de la taille d'une file d'attente, avec la possibilité de borner le nombre de ces instances, leur serait très utile.

Pour conclure ma présentation, j'ai réalisé une petite application de démonstration, avec différentes files, où des instances sont lancées ou supprimées en fonction de la taille de ces dernières.

Ma présentation a été bien reçue par l'ensemble des personnes qui ont pu y assister.
Une seconde session a même été programmée pour les personnes absentes et intéressées par le sujet.

### Rédaction d'un tutoriel

Pour les personnes les plus curieuses souhaitant aller plus loin, j'ai pris le temps de rédiger un tutoriel accessible à tous.
En effet, son but est de déployer à la main l'application de démonstration que j'ai faite pour la présentation sur une grappe créée avec Docker Desktop.
N'importe qui sur Mac (ce qui concerne la majorité du personnel de l'entreprise) ou Windows peut créer la grappe d'un simple clic de souris et se laisser guider.
J'ai détaillé l'ensemble des concepts en mettant à chaque fois les références vers la documentation officielle pour ceux qui souhaitent creuser davantage.

Avant d'en parler aux développeurs lors de ma présentation, je l'ai fait valider par Melwin Kieffer, un membre de l'équipe IT, qui l'a trouvé bien rédigé et ne m'a pas demandé d'y apporter de changements.

### Mise en production de services

Maintenant que le choix d'utiliser Kubernetes a été fait et validé, j'ai commencé avec les membres de l'équipe IT à déployer certains services en production, que ce soit sur une grappe hébergée localement ou chez Amazon.
La première sera plutôt utilisée pour les outils internes et la seconde principalement pour les sites de présentation des services, qui doivent pouvoir être accessibles depuis l'extérieur.

Pour transmettre ce que j'ai pu apprendre durant mon stage, je me suis mis d'accord avec un membre de l'équipe IT pour travailler ensemble pour déployer les différentes grappes de production.
Il a essayé de suivre la documentation que j'ai pu produire et, en cas de soucis ou s'il a la moindre question, je me tenais prêt pour intervenir.

## Déploiement d'autres services

En plus d'avoir effectué des déploiements de Kubernetes, j'ai également mis en place certains services en production en-dehors des grappes.

### Harbor

Dalim Software créée du logiciel propriétaire.
Le code source est uniquement accessible par les développeurs.
D'ici quelques années ils auront réussi à réduire le couplage de leurs applications sous forme de micro services et à le conteneuriser pour le déployer rapidement dans le *cloud*.
Or pour pouvoir déployer des images Docker, il est plus pratique de passer par un registre Docker.
Le plus connu, Docker Hub [@docker_hub], est public.
Tout le monde est en mesure d'y récupérer ou d'y pousser des images.
Comme on souhaite restreindre l'accès à ces images, il nous faut utiliser un registre privé.

Au moment où j'en ai parlé aux membres de l'équipe IT, on m'a demandé s'il était possible d'avoir une solution avec une interface web, où il serait possible de gérer rapidement les différents projets et images.

J'ai donc cherché les solutions les plus crédibles et je suis tombé sur Portus [@portus] et Harbor [@harbor].
Les deux proposent une interface web où l'on peut facilement gérer les utilisateurs et les droits, mais Harbor arrive de manière plus complète, vu qu'il fournit à la fois le registre et l'interface web, alors que Portus ne propose que l'interface.

J'ai donc mis en place Harbor sur une machine virtuelle dédiée, en faisant en sorte qu'il soit possible de se connecter avec une instance de Keycloak [@keycloak].
Il s'agit d'un service de gestion d'identité et d'accès open-source que l'IT venait de mettre en place.

J'ai également expliqué sur le wiki comment j'ai mis le tout en place, ainsi que la manière dont on transmet les identifiants à une grappe Kubernetes pour récupérer des images se trouvant sur un registre Docker privé.

### Minio

Minio [@minio] est une solution de stockage compatible S3 que j'ai mis en place notamment pour le système de sauvegardes avec Velero [@velero], une solution permettant de faire des sauvegardes et des migrations de ressources et de volumes persistants d'une grappe Kubernetes.

J'ai donc déployé une instance de Minio en interne, également sur une machine virtuelle dédiée.

## Callhome

### Présentation du service

Dalim Software étant une entreprise de logiciels, elle souhaite suivre l'évolution de l'utilisation de ces derniers à travers le temps, pour voir quelles sont les versions actuellement utilisées ainsi que le nombre d'utilisateurs actifs.
Ce mécanisme est également utile pour vérifier le bon usage des licences de ces logiciels.

Chaque logiciel développé par l'entreprise contient un bout de code qui va effectuer une requête vers une adresse précise lors du lancement. Cette requête va envoyer un certain nombre d'informations pour pouvoir assurer un suivi de l'utilisation.

Lors de l'envoi de la requête transmise par une des applications au service qui est chargé de traiter les données, des statistiques sont calculées.

Ce service fait également un bilan régulier qui est transmis à un certain nombre de services de l'entreprise, afin d'avoir un retour sur le taux d'utilisation, des mises à jour qui sont effectuées, etc.

### Mon travail

On m'a chargé de reprendre en main le service qui n'avait plus été maintenu depuis de nombreuses années. J'ai eu l'occasion de travailler à la fois sur une partie frontale qui consistait à afficher une carte dynamique, et sur la partie serveur, où l'on reçoit et traite les données transmises par les logiciels.

#### La carte

Un stagiaire précédent, Paul von Allwörden, avait développé une nouvelle interface sous forme de carte pour pouvoir visualiser approximativement la position des utilisateurs de deux logiciels de l'entreprise : ES et PDFLight.

![Carte pour visualiser les callhomes \label{fig_cal}](./images/screen/callhome.png)

La carte va afficher et mettre en surbrillance les pays dans lesquels il y a le plus d'utilisateurs à tour de rôle et afficher le classement.

Cependant elle n'a jamais été déployée, car personne n'avait eu le temps de faire les tests pour vérifier que tout était fonctionnel.

Lors de mon stage, il m'a donc été demandé de regarder ce qui a été fait.
J'ai rencontré certains problèmes pour lancer l'application, mais j'ai pu les régler en précisant les versions des différents composants à utiliser.

J'ai également ajouté une petite animation pour zoomer sur le pays en cours de visualisation en fonction de sa taille et ajusté certaines couleurs, afin d'avoir quelque chose de plus dynamique et moins agressif visuellement.

La figure \ref{fig_cal} montre la vue que l'on peut obtenir sur cette interface.

#### Le traitement des données

Concernant la partie du traitement des données transmises par les logiciels, elle était originellement rédigée en PHP 5. Or cette version n'est plus maintenue^[D'après <https://www.php.net/supported-versions.php>, la dernière version de la branche 5 a arrêtée de recevoir de nouvelles fonctionnalités depuis début 2017 et plus aucun correctif de sécurité n'y est appliqué depuis début 2019. Plus aucune correction ne sera donc effectuée, continuer à utiliser cette version représente un risque de sécurité.].

J'ai donc fait en sorte de nettoyer l'ensemble du code pour le rendre compatible avec les dernières versions de PHP, en corrigeant au passage un bon nombre de failles, principalement des possibilités d'injection SQL.

Pour avoir des URL propres, j'ai utilisé Slim [@slim], une bibliothèque PHP simple mais efficace pour mettre en place un système de routage.

Le résultat produit est un code nettement plus lisible, maintenable et sécurisé.

#### Le déploiement

Pour faciliter le déploiement, j'ai conteneurisé l'ensemble de l'application en différents conteneurs.

Dans un premier temps, j'ai créé une machine virtuelle, dans laquelle je n'avais qu'à les lancer avec `docker-compose`, ce qui a permis de faire valider l'ensemble.

Ensuite, j'ai rédigé la configuration nécessaire pour déployer l'application sur une grappe Kubernetes, qui va être très prochainement passé en production.

## Autres tâches

Comme précisé plus haut, j'ai utilisé Velero [@velero] pour sauvegarder les données de la grappe.
Pour vérifier le bon fonctionnement de ce système, j'ai déployé une instance de WordPress [@wordpress] sur une grappe Kubernetes, en faisant persister les données de la base de données ainsi que des données du site.
J'ai lancé une sauvegarde, puis j'ai supprimé l'instance.
En lançant la commande de restauration, j'ai bien été en mesure de rétablir l'ensemble du service.
J'ai également mis en place le mécanisme de sauvegarde périodiques, de sorte à effectuer une sauvegarde par jour, par semaine, par mois et par année, et d'en garder un nombre précis.
J'ai également supprimé l'instance et restauré, ce qui a parfaitement fonctionné.

Mon stage n'étant pas encore terminé, certaines tâches sont encore en cours de réalisation.
Notamment la réalisation d'une preuve de concept de traitement de fichiers PDF, où un utilisateur peut déposer des fichiers dans une interface web, et récupérer ses fichiers traités en sortie.

La mise en production d'une partie des services existants sur une grappe EKS [@eks] est également en cours.
Melwin Kieffer est en train de déployer les différents services avec l'aide de la documentation que j'ai pu produire.
J'interviens pour l'aider en cas de besoin.
Cette méthode permet de transmettre la connaissance et de valider la documentation, le but étant que l'équipe IT soit en mesure de gérer pleinement toute l'infrastructure une fois mon stage terminé.
