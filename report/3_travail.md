# Travail réalisé

J'ai principalement travaillé sur Kubernetes durant mon stage : analyser les besoins de l'entreprise pour trouver la meilleure façon pour déployer une grappe Kubernetes et déployer une instance de tests, tout en documentant ce que je faisais.

L'entreprise étant basée à l'étranger avec des personnes qui ne sont pas nécessairement francophones, l'ensemble du contenu est rédigé en langue anglaise.

De plus, j'ai eu l'occasion de faire une présentation à une grande partie des employés de l'entreprise, afin de leur présenter le concept de la conteneurisation et les avantages que peut nous offrir Kubernetes.

J'ai également été en charge de remettre au goût du jour une application interne et la déployer sur une des grappes.

## Kubernetes

### Pourquoi Kubernetes ?

L'équipe IT au sein de l'entreprise utilise déjà massivement les conteneurs, un ensemble de processus isolés au sein du système, pour leur infrastructure.
Ils utilisent actuellement la version 1.6 de Rancher pour gérer ces différents conteneurs.
Pour se donner un ordre de grandeur, il y a actuellement plus de 200 conteneurs actifs répartis à travers 18 machines virtuelles.

Cependant la gestion de ces conteneurs était assez lourde et limitée.
En effet avec l'infrastructure actuelle, il était difficile de déboguer une application particulière, du fait qu'ils est compliqué de mettre en place un mécanisme de surveillance et d'alerte.

Il n'est également pas possible de faire de la mise à l'échelle automatique, notamment en fonction de la charge, tout comme il n'est pas possible de déployer un conteneur automatiquement sur la machine ayant le plus de ressources disponibles.

L'équipe a donc pensé qu'utiliser Kubernetes pourrait être une solution qui pourrait répondre à ces problèmes, et d'avoir une architecture plus actuelle et standard, d'où l'intérêt de mon stage.

J'ai donc pu faire un peu le tour de tout ce que pouvait offrir Kubernetes pour voir s'il s'agissait d'une solution réellement pertinente dans le cas de Dalim Software, ce qui s'est révélé l'être étant donné que Kubernetes était en mesure de répondre à chacun des problèmes énumérés.

Il existe différentes manières de mettre en place une grappe Kubernetes.
J'ai donc exploré ces différentes solutions afin de voir celle qui pourrait convenir au mieux, ce que je vais détailler dans la section suivante.

### Déploiement d'une grappe

Pour tester Kubernetes plusieurs solutions s'offrent à nous.
Une solution très simple, à condition de posséder une machine Windows ou un Mac, est d'installer Docker Desktop^[<https://www.docker.com/products/docker-desktop>].

En effet, avec Docker Desktop, il est possible d'activer une grappe Kubernetes d'un simple clic depuis les paramètres, et vient avec tous les outils nécessaires pour le gérer, notamment `kubectl` qui permet de gérer un cluster Kubernetes depuis le terminal.

Une autre alternative est d'utiliser `minikube`^[<https://kubernetes.io/docs/setup/learning-environment/minikube/>], et à l'avantage de fonctionner sur Linux également, mais est très légèrement plus complexe à mettre en place.

Ces solutions sont très pratiques pour commencer à se familiarier avec Kubernetes, mais ne sont pas fait pour de la production, étant donné que l'on a qu'un seul noeud, et que l'on est donc pas en mesure d'assurer une haute disponibilité. Si ce noeud tombe, l'ensemble des services sera indisponible.

J'ai donc regardé du côté de `kubeadm`^[<https://kubernetes.io/fr/docs/setup/independent/create-cluster-kubeadm/>], un outil qui permet de déployer un cluster Kubernetes.
Il permet de choisir finement ce que l'on souhaite au sein du cluster, ce qui peut aussi être source de complexité.

J'ai également eu l'occasion de tester Kubespray^[<https://github.com/kubernetes-sigs/kubespray>], qui permet d'utiliser Ansible^[<https://www.ansible.com/>], une plateforme pour la configuration et gestion de machines, pour déployer une grappe Kubernetes.
L'avantage est qu'il est possible de versionner la configuartion utilisée, mais elle reste toutefois complexe.

J'ai donc testé Rancher, dans sa seconde version.
Le premier aspect positif, est qu'en terme d'interface et de terminologie, il y a un certain nombre de similitudes par rapport à la version actuellement utilisée en production pour la gestion de l'infrastructure.
Ce que j'ai trouvé intéressant, et pertinent pour l'équipe, c'est que Rancher offre la possibilité de gérer différentes grappes Kubernetes, que ce soit sur l'infrastructure interne ou chez un fournisseur d'infractructure en ligne, comme Google, Amazon ou Microsoft par exemple.
Rancher offre un certain nombre d'abstractions et permet de déployer des éléments naturellement complexes, telle que la mise en place d'un mécanisme de surveillance et d'alerte à propos de l'état de santé de la grappe en elle-même ainsi que des conteneurs, et ce de manière simple et rapide, avec une configuration pertinente et directement fonctionnelle.
Il est d'ailleurs relativement simple de mettre à jour l'ensemble, ce qui devrait faciliter la maintenance du service sur le long terme.

Cependant la documentation du projet peut s'avérer parfois incomplète, notamment en ce qui concerne le mécanisme propre des abstractions proposées ou des droits requis pour faire tourner une grappe Kubernetes chez Amazon ; mais l'ensemble de relève plutôt satisfaisant.

J'ai donc proposé d'utiliser Rancher pour la gestion des différentes grappes Kubernetes.

### Évaluation des solutions de stockages

Kubernetes est un orchestrateur de conteneurs.
Certains services, tels que les bases de données par exemple, qui tournent au sein de certains conteneurs possèdent des informations qui doivent pouvoir être pérénisées.
Or, les conteneurs peuvent être détruits, recrées à partir d'une image n'importe quand, et pas nécessairement sur la même machine.
Il faut donc persister ces données, et les monter lors de la création du conteneur.

Kubernetes propose pour cela une certaine abstraction et va utiliser un mécanisme de demande et d'offre : un service va demander à avoir une quantité de d'espace précise dans une plateforme de stockage. Kubernetes va voir la demande, et, s'il a été configuré pour, sera en mesure de répondre à la demande. Il ne restait plus qu'à choisir quelle solution de stoackage on allait utiliser.

Ce qui a été mis en place par l'équipe IT est une solution sur une base de GlusterFS. Cependant les performances ne sont pas satisfaisantes. J'ai donc été chargé de regarder quelles sont les solutions de stackages qui peuvent s'intégrer parfaitement avec Kubernetes et qui offrent des performances correctes pour faire tourner l'ensemble des applications actuelles.

J'ai testé deux solutions : un montage NFS depuis une machine virtuelle se trouvant sur le même serveur que celles utilisées par la grappe Kubernetes, et du CephFS avec l'aide du projet Rook^[<https://rook.io/>], que j'ai comparé avec les performances du GlusterFS actuellement déployé, en utilisant un banc de test d'accès aléatoire de fichiers depuis Java proposé par Atlassian^[<https://confluence.atlassian.com/kb/testing-disk-access-speed-for-a-java-application-818577561.html#TestingdiskaccessspeedforaJavaapplication-GradingtheResults>].

Voici les résultats que j'ai pu obtenir (tous les temps sont en nanosecondes) :

| Solution            | Ouverture | Lecture/écriture | Fermeture | Suppression |
|---------------------|----------:|-----------------:|----------:|------------:|
| GlusterFS (moyenne) | 4 418 067 |        3 267 901 |   331 782 |   2 044 691 |
| GlusterFS (médiane) | 3 193 282 |        2 871 261 |   296 244 |   1 814 538 |
| NFS (moyenne)       |   863 827 |           21 173 | 1 569 491 |     799 173 |
| NFS (médiane)       |   791 506 |           17 220 | 1 477 673 |     737 965 |
| Ceph (moyenne)      |    88 779 |           81 885 |     8 443 |      24 961 |
| Ceph (médiane)      |    20 024 |           15 081 |     7 495 |      22 960 |

On peut constater que dans les configurations évaluées NFS offre de meilleures performances que GlusterFS, excepté pour les fermetures, où elles sont cinq fois plus importantes. Ceph offre de bien meilleures résultats en termes de latences que les deux autres solutions. Cependant on peut constater que la médiane diffère grandement de la moyenne, on doit donc s'attendre à avoir une grande variance.

On a donc fait le choix d'utiliser CephFS pour les grappes internes.

### Présentation

Étant donné que j'ai pu travailler sur Kubernetes et apprendre les différents concepts au cours de plusieurs semaines, j'ai été chargé par l'équipe IT de faire une présentation au sein de l'entreprise vers le milieu de mon stage.
En effet, en souhaitant s'orienter vers une offre de logiciels en tant que services, les développeurs doivent être en accord sur la philosophie à adopter, dans le but d'avancer ensemble dans une même direction.

Ma présentation consistait dans un premier temps à expliquer le principe des conteneurs, leurs utilité, et comment est-ce que l'on peut créer des images.
J'ai ensuite introduit un certains nombre de concepts de Kubernetes, sans spécialement entrer dans le technique, dans le but de donner une vue d'ensemble des possibilités offertes par un te orchestrateur de conteneur, et fournir un aperçu des problèmes auquels il répond.

En amont, j'ai pu discuter avec Thierry, le responsable des développeurs, afin de voir quelles seraient les aspects de Kubernetes qui pourraient leur être le plus utile, et orienter ma présentation en fonction.
Il en est ressorti qu'un besoin qui leur serait très utile serait la capacité à lancer de nouvelles instances de services de traitement en fonction de la taille d'une file d'attente, avec la possibilité de borner le nombre de ces instances.

Pour conclure ma présentation, j'ai donc réalisé une petite application de démonstration, avec différentes files, où des instances sont lancées ou supprimées en fonction de la taille de ces dernières.

Ma présentation a plutôt bien été reçue par l'ensemble des personnes qui ont pu être présentes. Une seconde session a même été programmée pour les personnes qui n'ont pas pu y assister et qui sont intéressés par le sujet.

### Rédaction d'un tutoriel

Pour les personnes les plus curieuses et qui souhaitent aller plus loin, j'ai pris le temps de rédiger un tutoriel qui est vraiment accessible pour tout le monde.
En effet, le but de ce tutoriel est de déployer à la main l'application de démonstration que j'ai fait pour la présentation, et ce sur un cluster créé avec Docker Desktop.
N'importe qui sur Mac (la majorité des personnes de l'entreprise sont sur Mac) ou Windows peut créer la grappe d'un simple clic de souris, et se laisser guider.
J'ai détaillé l'ensemble des concepts en mettant à chaque fois les références vers la documentation officielle pour ceux qui souhaitent creuser davantage.

Avant d'en parler aux développeurs lors de ma présentation, je l'ai fait valider par Melwin, un membre de l'équipe IT, qui l'a trouvé bien rédigé, et ne m'a pas demandé d'y apporter de changements.

### Mise en production de services

Maintenant que le choix d'utiliser Kubernetes a été fait, du fait qu'il répond efficacement aux besoins de l'entreprise, j'ai commencé avec les membres de l'équipe IT à déployer certains services en production, que ce soit sur une grappe hébergée localement, ou que ce soit sur une grappe chez Amazon. La première sera plutôt utilisée pour les outils internes et la seconde principalement pour les sites de présentation des services, qui doivent pouvoir être accessibles depuis l'extérieur.

Pour transmettre ce que j'ai pu apprendre durant mon stage, je me suis mis d'accord avec un membre de l'équipe IT pour travailler ensemble pour déployer les différentes grappes de production. Il va essayer de suivre la documentation que j'ai pu produire, et en cas de soucis ou s'il a la moindre question, je me tenais prêt pour intervenir.

## Déploiement de certains services

En plus d'avoir effectué des déploiements de Kubernetes, j'ai également mis en place certains services en production en-dehors des grappes.

### Harbor

Chez Dalim Software on créer du logiciel propriétaire. Le code source est uniquement accessible par les développeurs. D'ici quelques années, les développeurs devront avoir réussi à découper ES, qui est un gros monolithe, sous forme de micro services et de le conteneuriser, afin qu'on puisse le déployer rapidement dans le *cloud*. Or pour pouvoir déployer des images Docker, il est plus pratique de passer par un *registry*. Le plus connu, Docker Hub^[<https://hub.docker.com/>], est un registry publique, où tout le monde est en mesure de récupérer ou pousser des images. Or, comme on souhaite restreindre l'accès à ces images, il nous faut utiliser un *registry* privé.

Au moment où j'en ai parlé aux membres de l'équipe IT, on m'a demandé s'il était possible d'avoir une solution avec une interface web, où il serait possible de pouvoir gérer rapidement les différents projets et images.

J'ai donc cherché les solutions les plus crédibles, et je suis tombé sur Portus^[<http://port.us.org/>] et Harbor^[<https://goharbor.io/>]. Les deux proposent une interface web où l'on peut facilement gérer les utilisateurs et les droits, mais Harbor arrive de manière plus complète, vu qu'il fournit à la fois le registry et l'interface web, alors que Portus ne vient qu'avec l'interface web.

J'ai donc mis en place Harbor sur une machine virtuelle dédiée, en faisant en sorte qu'il soit possible de se connecter avec une instance de Keycloak^[<https://www.keycloak.org/>], un service de gestion d'identité et d'accès open-source, étant donné que l'IT vennait d'en mettre une en place.

J'ai également expliqué comment j'ai mis le tout en place sur le wiki, ainsi que la manière dont on transmet les identifiants à un cluster Kubernetes pour récupérer des images Docker se trouvant sur un *registry* Docker privé.

### Minio

Minio^[<https://min.io/>] est une solution de stockage que l'on utilise compatible S3, ce qui m'a été très utile lorsque j'ai mis en place le système de sauvegardes avec Velero^[<https://velero.io/>], une solution permettant de faire des sauvegardes et des migrations de ressources et de volumes persistants d'un cluster Kubernetes.

J'ai donc déployé une instance de Minio en interne, également sur une machine virtuelle dédiée.

## Callhome

### Présentation du service

Dalim Software étant une entreprise de logiciels, elle souhaite suivre l'évolution de l'utilisation de ces derniers à travers le temps, pour voir quelles sont les builds utilisées actuellement ainsi que le nombre d'utilisateurs. Ce mécanisme est également utile pour vérifier le bon usage des licences de ces logiciels.

Chaque logiciel développé par l'entreprise contient un bout de code qui va effectuer une requête vers une adresse précise lors du lancement. Cette requête va envoyer un certain nombre d'informations pour pouvoir assurer un suivi de l'utilisation.

Lors de l'envoi de la requête transmise par une des applications au service qui est chargé de traiter les données, des statistiques sont calculées.

Ce service fait également un bilan régulier qui est transmis à un certains nombre de services de l'entreprise, afin d'avoir un retour sur le taux d'utilisation, des mises à jour qui sont effectuées, etc.

### Mon travail

On m'a chargé de reprendre en main le service qui n'avait plus été maintenu depuis de nombreuses années. J'ai eu l'occasion de travailler à la fois sur une partie frontend qui consistait à afficher une carte dynamique, et sur la partie backend, où l'on reçoit et traite les données transmises par les logiciels.

#### La carte

Un stagiaire précédent, Paul, avait développé une nouvelle interface sous forme de carte pour pouvoir visualiser approximativement la position des utilisateurs de deux logiciels de l'entreprise : ES et PDF Light.

![Carte pour visualiser les callhomes](./images/screen/callhome.png)

La carte va afficher et mettre en surbrillance les pays dans lesquels il y a le plus d'utilisateurs à tour de rôle et afficher le classement.

Cependant elle n'a jamais été déployée, car personne n'avait eu le temps de faire les tests pour vérifier que tout était fonctionnel.

Lors de mon stage, il m'a donc été demandé de voir si je pouvais voir ce qui a été fait. J'ai rencontré certains problèmes pour lancer l'application, mais j'ai pu les régler en précisant les versions des différents composants à utiliser.

J'ai également ajouté une petite animation pour zoomer sur le pays en cours de visualisation en fonction de sa taille, et ajusté certaines couleurs, afin d'avoir quelque chose de plus dynamique et moins aggressif visuellement.

#### Le traitement des données

Concernant la partie du traitement des données transmises par les logiciels, elle était originellement rédigée en PHP 5. Or cette version n'est plus maintenue^[<https://www.php.net/supported-versions.php>].

J'ai donc fait en sorte de nettoyer l'ensemble du code pour le rendre compatible avec les dernières versions de PHP, en corrigeant au passage un bon nombre de failles, principalement des possibilités d'injection SQL.

Pour avoir des URL propres, j'ai utilisé Slim dans sa seconde version, un micro

Le résultat produit est un code nettement plus lisible, maintenabe et sécurisé.

#### Le déploiement

Pour faciliter le déploiement, j'ai conteneurisé l'ensemble de l'application en différents conteneurs.

Dans un premier temps, j'ai créé une machine virtuelle, dans laquelle je n'avais qu'à les lancer avec `docker-compose`, ce qui a permis de faire valider l'ensemble.

Une fois validé, j'ai rédigé la configuration nécessaire pour déployer l'application sur le cluster Kubernetes que j'ai déployé.
