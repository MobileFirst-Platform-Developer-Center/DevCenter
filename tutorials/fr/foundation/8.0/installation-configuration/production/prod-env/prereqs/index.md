---
layout: tutorial
title: Conditions préalables à l'installation
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Pour une installation sans problème de MobileFirst Server, assurez-vous de disposer de tous les logiciels prérequis suivants.

Avant d'installer MobileFirst Server, vous devez disposer du logiciel suivant.

* **Système de gestion de base de données (SGBD)**
  Un système de gestion de base de données est nécessaire pour stocker les données techniques des composants MobileFirst Server. Vous devez utiliser l'un des systèmes de gestion de base de données pris en charge :

  * IBM DB2
  * MySQL
  * Oracle

  Pour plus d'informations sur les versions de système de gestion de base de données prises en charge par le produit, voir [Configuration requise](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). Si vous utilisez un système de gestion de base de données relationnelle (IBM DB2, Oracle, or MySQL), vous avez besoin du pilote JDBC correspondant à cette base de données lors du processus d'installation. Les pilotes JDBC ne sont pas fournis par le programme d'installation de MobileFirst Server. Vérifiez que vous disposez du pilote JDBC approprié.

  * Pour DB2, utilisez le pilote JDBC DB2 V4.0 (db2jcc4.jar).
  * Pour MySQL, utilisez le pilote JDBC Connector/J.
  * Pour Oracle, utilisez le pilote JDBC fin d'Oracle.

* **Serveur d'applications Java**
  Un serveur d'applications Java est nécessaire pour exécuter les applications MobileFirst Server. Vous pouvez utiliser n'importe lequel des serveurs d'applications suivants :

  * WebSphere Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  Pour plus d'informations sur les versions de serveurs d'applications prises en charge par le produit, voir [Configuration requise](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). Le serveur d'applications doit exécuter Java version 7 ou ultérieure. Par défaut, certaines versions de WebSphere Application Server s'exécutent avec Java 6. Avec cette version par défaut, ils ne peuvent pas exécuter MobileFirst Server. 

* **IBM Installation Manager version 1.8.4 ou version ultérieure**
  Installation Manager permet d'exécuter le programme d'installation de MobileFirst Server. Vous devez installer Installation Manager version 1.8.4 ou ultérieure. Les anciennes versions d'Installation Manager ne peuvent pas installer IBM MobileFirst Platform Foundation V8.0 car les opérations de post-installation du produit nécessitent Java 7. Les anciennes versions d'Installation Manager sont livrées avec Java 6.

  Téléchargez le programme d'installation d'IBM Installation Manager version 1.8.4 ou ultérieure à partir du site [Installation Manager and Packaging Utility download documents](http://www-01.ibm.com/support/docview.wss?uid=swg27025142).

* **Référentiel Installation Manager pour MobileFirst Server**
  Vous pouvez télécharger le référentiel à partir d'IBM MobileFirst Platform Foundation eAssembly sur le site [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm). Le nom du package est `IBM MobileFirst Platform Foundation V8.0.zip` (référentiel Installation Manager pour IBM MobileFirst Platform Server).

  Vous souhaiterez peut-être appliquer le dernier groupe de correctifs que vous pouvez télécharger à partir du [portail de support IBM](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation). Ce groupe de correctifs ne peut pas être installé sans le référentiel de la version de base dans les référentiels d'Installation Manager.

IBM MobileFirst Platform Foundation eAssembly comprend les programmes d'installation suivants :
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Pour Liberty, vous pouvez également utiliser l'édition IBM WebSphere SDK Java Technology avec le supplément IBM WebSphere Application Server Liberty Core.

## Rubrique parent
{: #parent-topic }

* [Installation de MobileFirst Server dans un environnement de production](../).
