---
layout: tutorial
title: Installation et configuration
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.product_full }} fournit des outils de développement et des composants côté serveur que vous pouvez installer sur site ou déployer dans le cloud pour le test ou la production. Reportez-vous aux rubriques d'installation appropriées à votre scénario d'installation.

### Installation d'un environnement de développement
{: #installing-a-development-environment }
Si vous développez le côté client ou le côté serveur d'applications mobiles, utilisez [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) ou le [service {{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation) pour commencer.

* [Configuration de l'environnement de développement MobileFirst](development/mobilefirst/)
* [Configuration de l'environnement de développement Cordova](development/cordova)
* [Configuration de l'environnement de développement iOS](development/ios)
* [Configuration de l'environnement de développement Android](development/android)
* [Configuration de l'environnement de développement Windows](development/windows)
* [Configuration de l'environnement de développement Xamarin](development/xamarin)
* [Configuration de l'environnement de développement Web](development/web)

### Installation d'un serveur de test ou de production sur site
{: #installing-a-test-or-production-server-on-premises }
Les installations IBM reposent sur un produit IBM qui s'appelle IBM Installation Manager. Installez IBM Installation Manager version 1.8.4 ou ultérieure séparément avant d'installer {{ site.data.keys.product }}.

> **Important :** assurez-vous d'utiliser IBM Installation Manager version 1.8.4 ou ultérieure. Les anciennes versions d'Installation Manager ne peuvent pas installer {{ site.data.keys.product }} {{ site.data.keys.product_version }} car les opérations de post-installation du produit nécessitent Java 7. Les anciennes version d'Installation Manager sont livrées avec Java 6.

Le programme d'installation de {{ site.data.keys.mf_server }} copie sur votre ordinateur tous les outils et toutes les bibliothèques qui sont requis pour le déploiement des composants {{ site.data.keys.mf_server }} et en option, d'{{ site.data.keys.mf_app_center_full }} sur votre serveur d'applications.

Si vous installez un serveur de test ou de production, reportez-vous à la section **Tutoriels sur l'installation de {{ site.data.keys.mf_server }}** ci-dessous pour effectuer une installation simple et en savoir plus sur l'installation de {{ site.data.keys.mf_server }}. Pour plus d'informations sur la préparation d'une installation pour votre environnement spécifique, voir [Installation de {{ site.data.keys.mf_server }} pour un environnement de production](production).

**Tutoriels sur l'installation de {{ site.data.keys.mf_server }}**  
Pour plus d'informations sur le processus d'installation de {{ site.data.keys.mf_server }}, parcourez les instructions permettant de créer un serveur {{ site.data.keys.mf_server }} fonctionnel, un cluster avec deux noeuds dans le profil Liberty de WebSphere Application Server. Vous pouvez procéder à l'installation de deux façons :

* [Via le mode graphique d'IBM Installation Manager](production/tutorials/graphical-mode) et l'outil de configuration de serveur.
* [Via l'outil de ligne de commande](production/tutorials/command-line).

Vous obtenez ainsi un serveur {{ site.data.keys.mf_server }} opérationnel. Toutefois, vous devrez le configurer, notamment pour la sécurité, avant de l'utiliser. Pour plus d'informations, voir [Configuration de {{ site.data.keys.mf_server }}](production/server-configuration).

**Ajouts**  

* Pour ajouter {{ site.data.keys.mf_analytics_server }} à votre installation, voir [Guide d'installation de {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/).  
* Pour installer {{ site.data.keys.mf_app_center }}, voir [Installation et configuration d'Application Center](production/appcenter).

### Déploiement de {{ site.data.keys.mf_server }} dans le cloud
{: #deploying-mobilefirst-server-to-the-cloud }
Si vous prévoyez de déployer {{ site.data.keys.mf_server }} dans le cloud, reportez-vous aux options suivantes :

* [Utilisation de {{ site.data.keys.mf_server }} dans IBM Bluemix](../bluemix).
* [Utilisation de {{ site.data.keys.mf_server }} dans IBM PureApplication](production/pure-application).

### Mise à niveau depuis des versions antérieures
{: #upgrading-from-earlier-versions }
Pour des informations sur la mise à niveau d'installations et d'applications existantes vers une version plus récente, voir [Mise à niveau vers {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).


