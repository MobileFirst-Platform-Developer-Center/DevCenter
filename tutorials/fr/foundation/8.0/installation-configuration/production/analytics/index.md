---
layout: tutorial
title: Installation et configuration de MobileFirst Analytics Server	
breadcrumb_title: Installing MobileFirst Analytics Server
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.mf_analytics_server }} est livré avec deux fichiers WAR distincts. Pour faciliter le déploiement sur WebSphere Application Server ou WebSphere Application Server Liberty, il est également livré avec un fichier EAR contenant les deux fichiers WAR.

> **Remarque :** n'installez pas plusieurs instances de {{ site.data.keys.mf_analytics_server }} sur une seule machine hôte. Pour plus d'informations sur la gestion de votre cluster, voir la documentation d'Elasticsearch.

Les fichiers WAR et EAR d'analyse sont inclus dans l'installation de MobileFirst Server. Pour plus d'informations, voir Structure de distribution de MobileFirst Server. Lorsque vous déployez le fichier WAR, MobileFirst Analytics Console est disponible à l'adresse : `http://<hostname>:<port>/analytics/console`, par exemple `http://localhost:9080/analytics/console`.

* Pour plus d'informations sur l'installation de {{ site.data.keys.mf_analytics_server }}, voir [Guide d'installation de {{ site.data.keys.mf_analytics_server }}](installation).
* Pour plus d'informations sur la configuration d'IBM MobileFirst Analytics, voir [Guide de configuration](configuration).
