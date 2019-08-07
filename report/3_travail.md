# Travail réalisé

Durant l'ensemble de mon stage, j'ai pris soin de documenter mon travail dans l'instance de Confluence déployée en interne, qui est un logiciel de wiki.

L'entreprise étant basée à l'étranger avec des personnes qui ne sont pas nécessairement francophones, l'ensemble du contenu est rédigé en langue anglaise.

L'ensemble de mon travail a donc entièrement été rédigé en anglais.

## Kubernetes

### Qu'est-ce qu'un container ?

### Pourquoi Kubernetes ?

### Clusters de test

L'équipe IT au sein de l'entreprise utilise déjà massivement les conteneurs pour leur infrastructure. Ils utilisent actuellement la version 1.6 de Rancher pour gérer ces différents conteneurs.

Pour se donner un ordre de grandeur, il y a actuellement plus de 200 conteneurs qui tournent à travers 18 machines virtuelles.

Cependant la gestion de ces conteneurs était assez lourde et limitée. L'équipe a donc pensé qu'utiliser Kubernetes pourrait être une solution qui pourrait répondre à leur besoin, et d'avoir une architecture plus actuelle et standard, d'où l'intérêt de mon stage.

Il existe différentes manières de mettre en place un cluster Kubernetes. J'ai donc exploré ces différentes solutions afin de voir celle qui pourrait convenir au mieux.

#### Cluster avec un seul noeud en local

Pour tester Kubernetes plusieurs solutions s'offrent à nous. Une solution très simple, à condition de posséder une machine Windows ou un Mac, est d'installer Docker Desktop.

En effet, avec Docker Desktop, il est possible d'activer un cluster Kubernetes d'un simple clic depuis les paramètres, et vient avec tous les outils nécessaires pour le gérer, notamment `kubectl` qui permet de gérer un cluster Kubernetes depuis le terminal.

Une autre alternative est d'utiliser minikube, et à l'avantage de fonctionner sur Linux également, mais est très légèrement plus complexe à mettre en place.

Ces solutions sont très pratiques pour commencer à se familiarier avec Kubernetes, mais ne sont pas fait pour de la production, étant donné que l'on a qu'un seul noeud, et que l'on est donc pas en mesure d'assurer une haute disponibilité. Si ce noeud tombe, l'ensemble des services sera indisponible.

#### Déploiement d'un cluster avec `kubeadm`

#### Déploiement d'un cluster avec Kubespray

Ansible!

#### Déploiement d'un cluster avec Rancher

#### Solution retenue

Rancher, parce que :

  - ils utilisent déjà une ancienne version, quelques similitudes dans l'interface,

  - gestion de plusieurs clusters, qui peuvent être de pas mal de providers,

  - déploiement de la stack de monitoring et d'alerting très simple et rapide,

  - facile à mettre à jour, etc...

### Présentation

#### Préparation

#### Rélisation d'un projet de démonstration

pour imager les concepts

### Mise en production de services sur le cluster final

Maintenant que tout le monde, que ce soit les membres de l'équipe IT ou bien les développeurs, est convaicu du choix d'utiliser Kubernetes, j'ai commencé dans la dernière partie de mon stage à déployer un cluster Kubernetes de production avec l'équipe IT.

Pour transmettre ce que j'ai pu apprendre durant mon stage, je me suis mis d'accord avec un membre de l'équipe IT pour travailler ensemble pour déployer le cluster de production. Il va essayer de suivre simplement la documentation que j'ai pu produire, et en cas de soucis ou s'il a la moindre question, je me tiendrai prêt pour intervenir.

## Callhome

### Présentation du service

Dalim Software étant une entreprise de logiciels, elle souhaite suivre l'évolution de l'utilisation de ces derniers à travers le temps, pour voir quelles sont les builds utilisées actuellement ainsi que le nombre d'utilisateurs. Ce mécanisme est également utile pour vérifier le bon usage des licences de ces logiciels.

Chaque logiciel développé par l'entreprise contient un bout de code qui va effectuer une requête vers une adresse précise lors du lancement. Cette requête va envoyer un certain nombre d'informations pour pouvoir assurer un suivi de l'utilisation.

Lors de l'envoi de la requête vers le «callhome», qui est le service qui est chargé de traiter les données transmises par les applications, des statistiques sont calculées.

Ce service fait également un bilan régulier qui est transmis à un certains nombre de services de l'entreprise, afin d'avoir un retour sur le taux d'utilisation, des mises à jour qui sont effectuées, etc.

### Mon travail

On m'a chargé de reprendre en main le service qui n'avait plus été maintenu depuis de nombreux mois. J'ai eu l'occasion de travailler à la fois sur une partie frontend qui consistait à afficher une carte dynamique, et sur la partie backend, où l'on reçoit et traite les données transmises par les logiciels.

#### La carte

Un ancien stagiaire avait créé une page web montrant une carte permettant de visualiser approximativement où se trouvent les utilisateurs en fonction du logiciel. La carte va afficher et mettre en surbrillance les pays dans lesquels il y a le plus d'utilisateurs à tour de rôle et afficher le classement.

Cependant elle n'a jamais été déployée, car il n'était pas possible de la lancer, du fait que certaines erreurs étaient présentes.

J'ai donc fait en sorte que ça fonctionne. J'ai également ajouté une petite animation pour zoomer sur le pays en cours de visualisation en fonction de sa taille, et ajusté certaines couleurs.

#### Le traitement des données

Concernant la partie du traitement des données transmises par les logiciels, la partie était originellement été rédigée en PHP 5. Or cette version n'est plus supportée.

J'ai donc fait en sorte de nettoyer l'ensemble du code pour le rendre compatible avec les dernières versions de PHP, en corrigeant un bon nombre de failles, principalement des possibilités d'injection SQL, au passage.

Le résultat produit est un code nettement plus lisible, maintenabe et sécurisé.

#### Le déploiement

Pour faciliter le déploiement, j'ai conteneurisé l'ensemble de l'application en différents conteneurs.

J'ai créé une machine virtuelle, dans laquelle je n'avais qu'à les lancer avec `docker-compose`.
