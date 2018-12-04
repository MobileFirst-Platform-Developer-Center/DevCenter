---
layout: tutorial
title: Configuration de l'environnement de développement Ionic
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Ionic est une infrastructure basée sur [AngularJS](https://angularjs.org/) et [Apache Cordova](https://cordova.apache.org/) qui vous permet de créer rapidement des applications hybrides mobiles et Web à l'aide de technologies telles que HTML, CSS et Javascript.

Si vous êtes développeur et si vous avez choisi Ionic comme infrastructure de développement pour vos applications mobiles ou Web, les sections qui suivent vous expliqueront comment utiliser le logiciel SDK [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) dans vos applications Ionic.

Vous pouvez écrire vos applications à l'aide de l'éditeur de code de votre choix (par exemple Atom.io, Visual Studio Code, Eclipse, IntelliJ, ou d'autres).

**Prérequis :** Lors de la configuration de votre environnement de développement Ionic, lisez également le tutoriel [Configuration de l'environnement de développement MobileFirst](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst).

## Installation de l'interface de ligne de commande Ionic
{: #installing_cli }
La première étape requise pour le développement Ionic est l'installation de [l'interface de ligne de commande Ionic](https://ionicframework.com/docs/cli/).

**Pour installer l'interface de ligne de commande cordova et ionic :**

* Téléchargez et installez [NodeJS](https://nodejs.org/en/).
* Depuis une fenêtre de ligne de commande, exécutez la commande :
```bash  
  npm install -g ionic
```  

## Ajout du SDK Mobile Foundation à votre application Ionic
{: #adding_mfp_ionic_sdk }
Pour permettre le développement MobileFirst dans vos applications Ionic, vous devez ensuite y ajouter le SDK ou les plug-in Cordova de MobileFirst.

Apprenez à ajouter le logiciel SDK MobileFirst aux applications Cordova.
Pour le développement d'application, reportez-vous au tutoriel [Adding the Mobile Foundation SDK to Ionic applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic).
