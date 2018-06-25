---
layout: tutorial
title: Installation de MobileFirst Server pour un environnement de production
breadcrumb_title: Production Environment
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Cette section contient des informations détaillées destinées à vous aider à planifier et préparer une installation pour votre propre environnement.  
Pour plus d'informations sur la configuration de {{ site.data.keys.mf_server }}, voir [Configuration de {{ site.data.keys.mf_server }}](server-configuration).

#### Aller à
{: #jump-to }

* [Prérequis](#prerequisites)
* [Que faire ensuite ?](#whats-next)

## Prérequis
{: #prerequisites }
Pour une installation sans problèmes de {{ site.data.keys.mf_server }}, prenez soin de disposer de tous les logiciels prérequis suivants :

**Système de gestion de base de données**  
Un système de gestion de base de données est nécessaire pour stocker les données techniques des composants {{ site.data.keys.mf_server }}. Vous devez utiliser l'un des systèmes de gestion de base de données pris en charge :

* IBM DB2 
* MySQL
* Oracle

Pour plus d'informations sur les versions de système de gestion de base de données prises en charge par le produit, voir [Configuration requise](../../product-overview/requirements). Si vous utilisez un système de gestion de base de données relationnelle (IBM DB2, Oracle, or MySQL), vous avez besoin du pilote JDBC correspondant à cette base de données lors du processus d'installation. Les pilotes JDBC ne sont pas fournis par le programme d'installation de {{ site.data.keys.mf_server }}. Vérifiez que vous disposez du pilote JDBC approprié.

* Pour DB2, utilisez le pilote JDBC DB2 V4.0 (db2jcc4.jar).
* Pour MySQL, utilisez le pilote JDBC Connector/J.
* Pour Oracle, utilisez le pilote JDBC fin d'Oracle.

**Serveur d'applications Java**  
Un serveur d'applications Java est nécessaire pour exécuter les applications {{ site.data.keys.mf_server }}. Vous pouvez utiliser n'importe lequel des serveurs d'applications suivants :

* WebSphere  Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

Pour plus d'informations sur les versions de serveurs d'applications prises en charge par le produit, voir [Configuration requise](../../product-overview/requirements). Le serveur d'applications doit exécuter Java version 7 ou ultérieure. Par défaut, certaines versions de WebSphere Application Server s'exécutent avec Java 6. Avec cette version par défaut, ils ne peuvent pas exécuter {{ site.data.keys.mf_server }}

**IBM Installation Manager version 1.8.4 ou ultérieure**  
Installation Manager est utilisé pour exécuter le programme d'installation de {{ site.data.keys.mf_server }}. Vous devez installer Installation Manager version 1.8.4 ou ultérieure. Les anciennes versions d'Installation Manager ne peuvent pas installer {{ site.data.keys.product_full }} {{ site.data.keys.product_version }} car les opérations de post-installation du produit nécessitent Java 7. Les anciennes version d'Installation Manager sont livrées avec Java 6.

Téléchargez le programme d'installation d'IBM Installation Manager version 1.8.4 ou ultérieure à partir du site [Installation Manager and Packaging Utility download documents](http://www.ibm.com/support/docview.wss?uid=swg27025142).

**Référentiel d'Installation Manager pour {{ site.data.keys.mf_server }}**  
Vous pouvez télécharger le référentiel à partir de {{ site.data.keys.product }} eAssembly sur le site [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). Le nom du package est **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**.

Vous souhaiterez peut-être appliquer le dernier groupe de correctifs que vous pouvez télécharger à partir du [portail de support IBM](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). Ce groupe de correctifs ne peut pas être installé sans le référentiel de la version de base dans les référentiels d'Installation Manager.

{{ site.data.keys.product }} eAssembly comprend les programmes d'installation suivants :

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Pour Liberty, vous pouvez également utiliser l'édition IBM WebSphere SDK Java Technology avec le supplément IBM WebSphere Application Server Liberty Core.

## Que faire ensuite ?
{: #whats-next }

* [Exécution d'IBM Installation Manager](installation-manager)
* [Configuration de bases de données](databases)
* [Topologies et flots réseau](topologies)
* [Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](appserver)
