---
layout: tutorial
title: Installation et configuration
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.product_full }} fournit des outils de développement et des composants côté serveur que vous pouvez installer sur site ou déployer dans le cloud pour le test ou la production. Reportez-vous aux rubriques d'installation appropriées à votre scénario d'installation.

### Configuration d'un environnement de développement
{: #installing-a-development-environment }
Si vous développez le côté client ou le côté serveur d'applications mobiles, utilisez [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) ou le [service {{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation) pour commencer.

**Utilisation du kit {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

{{ site.data.keys.mf_dev_kit }} inclut tous les éléments nécessaires à l'exécution et au débogage d'applications mobiles sur un poste de travail personnel. Pour développer une application avec {{ site.data.keys.mf_dev_kit }}, suivez le tutoriel [Configuration de l'environnement de développement MobileFirst](development/mobilefirst).

**Utilisation du service {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

Le service {{ site.data.keys.mf_bm }} offre une fonctionnalité similaire à celle du kit {{ site.data.keys.mf_dev_kit }}, mais le service s'exécute sur IBM Cloud.

**Configuration de l'environnement de développement pour des applications {{ site.data.keys.product }}**
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }} offre une grande flexibilité en matière d'outils et de plateformes pouvant être utilisés pour le développement d'applications {{ site.data.keys.product }}. Il est cependant nécessaire d'effectuer une configuration de base pour pouvoir choisir les outils permettant d'interagir avec {{ site.data.keys.product }}.  

Sélectionnez l'un des liens suivants pour configurer l'environnement de développement correspondant à l'approche de développement utilisée par l'application :

* [Configuration de l'environnement de développement Cordova](development/cordova)
* [Configuration de l'environnement de développement iOS](development/ios)
* [Configuration de l'environnement de développement Android](development/android)
* [Configuration de l'environnement de développement Windows](development/windows)
* [Configuration de l'environnement de développement Xamarin](development/xamarin)
* [Configuration de l'environnement de développement Web](development/web)

### Configuration d'un serveur de test ou de production sur site
{: #installing-a-test-or-production-server-on-premises }

La première partie de l'installation du serveur {{ site.data.keys.product }} Server fait appel à un produit IBM nommé IBM Installation Manager. IBM Installation Manager version 1.8.4 ou ultérieure doit être installé avant les composants {{ site.data.keys.product }} Server.

> **Important :** assurez-vous d'utiliser IBM Installation Manager version 1.8.4 ou ultérieure. Les anciennes versions d'Installation Manager ne peuvent pas installer {{ site.data.keys.product }} {{ site.data.keys.product_version }} car les opérations de post-installation du produit nécessitent Java 7. Les anciennes version d'Installation Manager sont livrées avec Java 6.

L'assistant d'installation de {{ site.data.keys.mf_server }} utilise IBM Installation Manager pour placer tous les composants serveur sur le serveur.  Les outils et les bibliothèques nécessaires au déploiement des composants {{ site.data.keys.product }} Server sur le serveur d'applications sont également installés.  Il n'est pas recommandé d'installer tous les composants sur la même instance de serveur d'applications, sauf dans le cas d'un serveur de développement. Les outils de déploiement permettent de sélectionner les composants à installer.  Veuillez vous reporter à [Topologies et flots réseau](production/prod-env/topologies) pour connaître les éléments à prendre en compte avant d'installer le serveur.

Prenez connaissance des informations ci-dessous concernant la préparation et l'installation de {{ site.data.keys.mf_server }} et des services facultatifs sur votre environnement spécifique. Pour une configuration simple, consultez le tutoriel [Configuration d'un environnement de test ou de production](production).

* [Vérification de la configuration requise](production/prod-env/prereqs)
* [Présentation des composants {{ site.data.keys.mf_server }}](production/prod-env/topologies)
* Facteurs à prendre en compte avant le chargement des outils et des bibliothèques pour le déploiement des composants MobileFirst Server et éventuellement d'Application Center
  * Licence de jeton
  * MobileFirst Foundation Application Center
  * Mode administrateur et mode utilisateur
* Structure de distribution de MobileFirst Server après le chargement des fichiers
* Chargement des fichiers via
  * l'utilisation de l'assistant d'installation d'IBM Installation Manager
  * l'exécution d'IBM Installation Manager sur la ligne de commande
  * l'utilisation des fichiers de réponses XML (installation en mode silencieux)
* [Configuration de bases de données dorsales pour les composants MobileFirst Foundation Server](production/prod-env/databases)
* [Installation de MobileFirst Server sur un serveur d'applications](production/prod-env/appserver)
* [Configuration de MobileFirst Server](production/server-configuration)
* [Installation de MobileFirst Analytics Server](production/analytics/installation)
* [Installation d'Application Center](production/appcenter)
* [Déploiement de MobileFirst Server sur IBM PureApplication System](production/pure-application)

### Configuration d'un environnement de test ou de production
{: #setting-up-test-or-production-server}

Pour plus d'informations sur le processus d'installation de {{ site.data.keys.mf_server }}, reportez-vous aux instructions permettant de créer un cluster {{ site.data.keys.mf_server }} fonctionnel avec deux noeuds sur le profil WebSphere Application Server Liberty. L'installation peut être effectuée grâce aux outils graphiques (interface graphique) ou via la ligne de commande.

* [Installation en mode interface graphique avec IBM Installation Manager et l'outil de configuration de serveur](production/simple-install/tutorials/graphical-mode).
* [Installation en mode ligne de commande avec l'outil de ligne de commande](production/simple-install/tutorials/command-line).

Après avoir procédé à l'installation via l'une des deux méthodes ci-dessus, il se peut que vous deviez effectuer une [configuration](production/server-configuration) supplémentaire pour terminer l'installation selon les exigences de l'environnement.

### Configuration de fonctions facultatives sur votre environnement de test ou de production
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }} inclut des composants facultatifs qui peuvent être utilisés pour renforcer votre environnement de test ou de production.  Pour plus d'informations, reportez-vous aux tutoriels suivants :

* [Installation et configuration de {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/)
* [Installation et configuration de {{ site.data.keys.mf_app_center }}](production/appcenter)

### Déploiement d'un environnement {{ site.data.keys.mf_server }} de test ou de production sur le cloud
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

Si vous prévoyez de déployer {{ site.data.keys.mf_server }} dans le cloud, reportez-vous aux options suivantes :

* [Utilisation de {{ site.data.keys.mf_server }} sur IBM Cloud](../bluemix).
* [Utilisation de {{ site.data.keys.mf_server }} dans IBM PureApplication](production/pure-application).

### Mise à niveau depuis des versions antérieures
{: #upgrading-from-earlier-versions }
Pour des informations sur la mise à niveau d'installations et d'applications existantes vers une version plus récente, voir [Mise à niveau vers {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).
