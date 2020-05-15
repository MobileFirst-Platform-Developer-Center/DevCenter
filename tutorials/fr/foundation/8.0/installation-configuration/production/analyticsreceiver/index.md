---
layout: tutorial
title: Installation et configuration de MobileFirst Analytics Receiver Server
breadcrumb_title: Installation de MobileFirst Analytics Receiver Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Le serveur Mobile Analytics Receiver est un serveur facultatif qui peut être déployé pour envoyer des événements d'analyse Mobile Foundation à partir des applications client mobile et non de l'exécution de Mobile Foundation Server. Cette option de déploiement permet de décharger le traitement des événements d'analyse à partir de l'environnement d'exécution du serveur Mobile Foundation, permettant ainsi d'utiliser pleinement ses ressources pour les fonctions d'exécution.  

{{ site.data.keys.mf_analytics_receiver_server }} est livré en tant que fichier WAR unique. Il est conseillé de l'installer sur un serveur séparé. Vous pouvez l'installer de différentes façons :

* Installation à l'aide de tâches Ant
* Installation manuelle

Après avoir installé {{ site.data.keys.mf_analytics_receiver_server }} dans le serveur d'applications Web de votre choix, vous devez effectuer d'autres tâches de configuration. Pour plus d'informations, voir Configuration de {{ site.data.keys.mf_analytics_receiver_server }} après sont installation ci-dessous. Si vous choisissez l'installation manuelle dans le programme d'installation, reportez-vous à la documentation du serveur d'applications de votre choix.

> **Remarque :** n'installez pas plusieurs instances de {{ site.data.keys.mf_analytics_receiver_server }} sur une seule machine hôte.

Le fichier WAR Analytics Receiver est inclus dans l'installation de MobileFirst Server. Pour plus d'informations, voir Structure de distribution de MobileFirst Server.

* Pour plus d'informations sur l'installation de {{ site.data.keys.mf_analytics_receiver_server }}, consultez le [Guide d'installation de {{ site.data.keys.mf_analytics_receiver_server }}](installation).
* Pour plus d'informations sur la configuration d'IBM MobileFirst Analytics Receiver, consultez le [Guide de configuration](configuration).
