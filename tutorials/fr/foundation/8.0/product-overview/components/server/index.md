---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{site.data.keys.mf_server }} est constitué de plusieurs composants. Une présentation de l'architecture {{site.data.keys.mf_server }} est fournie pour vous permettre de comprendre les fonctions de chaque composant.

Contrairement à la version 7.1 ou aux versions précédentes de {{site.data.keys.mf_server }}, le processus d'installation de la version 8.0.0 est distinct du développement et du déploiement d'opérations sur des applications mobiles. En V8.0.0, une fois les composants de serveur et la base de données installés et configurés, {{site.data.keys.mf_server }} peut être utilisé pour la plupart des opérations sans qu'il soit nécessaire d'accéder au serveur d'applications ou à la configuration de base de données.

Les opérations d'administration et de déploiement des artefacts {{site.data.keys.product_adj }} sont effectuées via la console {{site.data.keys.mf_console }} ou l'API REST du service d'administration de {{site.data.keys.mf_server }}. Les opérations peuvent également être effectuées en utilisant certains outils de ligne de commande qui encapsulent cette API, par exemple, mfpdev ou mfpadm. Les utilisateurs autorisés de {{site.data.keys.mf_server }} peuvent modifier la configuration côté serveur des applications mobiles, télécharger ou configurer du code côté serveur (les adaptateurs), télécharger de nouvelles ressources Web pour des applications mobiles Cordova, exécuter des opérations de gestion d'applications, et plus.

{{site.data.keys.mf_server }} offre des couches de sécurité supplémentaires, en plus des couches de sécurité de l'infrastructure réseau ou du serveur d'applications. Les fonctions de sécurité incluent le contrôle de l'authenticité d'application et le contrôle d'accès aux ressources côté serveur et aux adaptateurs. Ces configurations de sécurité peuvent également être effectuées par les utilisateurs autorisés de {{site.data.keys.mf_console }} et du service d'administration . Vous déterminez l'autorisation des administrateurs de {{site.data.keys.product_adj }} en les mappant aux rôles de sécurité, comme décrit dans [Configuration de l'authentification d'utilisateur pour l'administration de {{site.data.keys.mf_server }} ](../../../installation-configuration/production/server-configuration).

Une version simplifiée de {{site.data.keys.mf_server }} préconfigurée et ne nécessitant pas de logiciel prérequis, tel qu'une base de données ou un serveur d'applications, est disponible pour les développeurs. Voir [Configuration du serveur de développement {{site.data.keys.product_adj }}](../../../installation-configuration/development).

## Composants de {{site.data.keys.mf_server }}
{: #mobilefirst-server-components }
L'architecture des composants de {{site.data.keys.mf_server }} est illustrée comme suit :

![Composants de {{site.data.keys.mf_server }}](server_components.jpg)

### Composants de base de {{site.data.keys.mf_server }}
{: #core-components-of-mobilefirst-server }
{{site.data.keys.mf_console }}, le service d'administration de {{site.data.keys.mf_server }}, le service de mise à jour opérationnel de {{site.data.keys.mf_server }}, les artefacts {{site.data.keys.mf_server }} et l'environnement d'exécution {{site.data.keys.product_adj }} représentent l'ensemble de composants de base à installer. 

* L'environnement d'exécution fournit les services {{site.data.keys.product_adj }} aux applications mobiles qui s'exécutent sur les terminaux mobiles.
* Le service d'administration fournit les fonctions de configuration et d'administration. Vous utilisez le service d'administration via {{site.data.keys.mf_console }}, l'API REST de service de mise à jour opérationnel ou les outils de ligne de commande, tels que mfpadm ou mfpdev. 
* Le service de mise à jour opérationnel gère les données de configuration et est utilisé par le service d'administration.

Ces composants requièrent une base de données. Le nom de table de base de données de chaque composant ne comporte pas de propriétés en commun. Vous pouvez donc utiliser la même base de données ou le même schéma pour stocker toutes les tables de ces composants. Pour plus d'informations, voir [Configuration des bases de données](../../../installation-configuration/production/server-configuration).

Il est possible d'installer plus d'une instance de l'environnement d'exécution. Dans ce cas, chaque instance a besoin de sa propre base de données. Le composant des artefacts fournit des ressources pour {{site.data.keys.mf_console }}. Il ne requiert pas de base de données.

### Composants facultatifs de {{site.data.keys.mf_server }}
{: #optional-components-of-mobliefirst-server }
Le service push de {{site.data.keys.mf_server }} fournit des fonctions de notification push. Il doit être installé pour fournir les fonctions des applications mobiles qui utilisent les fonctions push de {{site.data.keys.product_adj }}. Dans la perspective des applications mobiles, l'URL du service push est identique à l'URL de l'environnement d'exécution, à ceci près que sa racine de contexte est `/imfpush`.

Si vous prévoyez d'installer le service push sur un autre serveur ou cluster que celui de l'environnement d'exécution, vous devez configurer les règles de routage de votre serveur HTTP. La configuration consiste à s'assurer que les demandes émises vers le service push et l'environnement d'exécution sont correctement routées. 

Le service push requiert une base de données. Les tables du service push n'ont pas de propriétés en commun avec les tables de l'environnement d'exécution, du service d'administration et du service de mise à jour opérationnel. Par conséquent, il peut également être installé dans la même base de données ou le même schéma.

Le service {{site.data.keys.mf_analytics }} et {{site.data.keys.mf_analytics_console }} fournissent des informations d'analyse et de surveillance sur l'utilisation des applications mobiles. Les applications mobiles peuvent fournir davantage de connaissances en utilisant le kit de développement de logiciels du consignateur. Le service {{site.data.keys.mf_analytics }} ne requiert pas de base de données. Il stocke ses données localement sur un disque à l'aide de Elasticsearch. Les données sont structurées en fragments qui peuvent être répliqués entre les membres d'un cluster du service Analytics.

Pour plus d'informations sur les flots réseau et les contraintes de topologie pour ces composants, voir [Topologies et flots réseau](../../../installation-configuration/production/server-configuration).

### Processus d'installation
{: #installation-process }
L'installation de {{site.data.keys.mf_server }} sur site peut être effectuée en procédant comme suit :

* Outil de configuration de serveur (assistant graphique)
* Tâches Ant via les outils de ligne de commande
* Installation manuelle

Pour plus d'informations sur l'installation de {{site.data.keys.mf_server }} sur site, voir :

* Un [guide décrivant l'installation complète](../../../installation-configuration/production/) d'un parc de serveurs {{site.data.keys.mf_server }} sur un profil WebSphere Application Server Liberty. Ce guide est basé sur un scénario simple que vous pouvez suivre pour effectuer l'installation en mode graphique ou en mode de ligne de commande.
* Une [section détaillée](../../../installation-configuration/production/) contenant des informations détaillées sur les prérequis de l'installation, la configuration de base de données, les topologies de serveur, le déploiement des composants sur le serveur d'applications et la configuration de serveur.

