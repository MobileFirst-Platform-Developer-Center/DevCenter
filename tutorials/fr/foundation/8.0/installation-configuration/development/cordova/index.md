---
layout: tutorial
title: Configuration de l'environnement de développement Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Pour commencer le [développement Cordova (PhoneGap)](https://cordova.apache.org/), vous devez tout d'abord installer l'interface de ligne de commande Cordova. Il s'agit de l'outil permettant de créer des applications Cordova. Celles-ci peuvent être améliorées à l'aide de divers outils et infrastructures tiers tels qu'Ionic, AngularJS, jQuery Mobile, etc. 
Avec des applications Cordova, vous pouvez utiliser l'éditeur de code de votre choix, par exemple Atom.io, Visual Studio Code, Eclipse, IntelliJ ou d'autres, afin d'implémenter vos applications et vos adaptateurs.

**Prérequis :** Lors de la configuration de votre environnement de développement Cordova, lisez également le tutoriel [Configuration de l'environnement de développement {{ site.data.keys.product_adj }}](../mobilefirst/).

## Installation de l'interface de ligne de commande Cordova
{: #installing-the-cordova-cli }
{{ site.data.keys.product }} prend en charge l'[interface de ligne de commande Cordova 6.x](https://www.npmjs.com/package/cordova) ou version ultérieure d'Apache.  
Pour procéder à l'installation :

1. Téléchargez et installez [NodeJS](https://nodejs.org/en/).
2. Depuis une fenêtre de **ligne de commande**, exécutez la commande `npm install -g cordova`.

## Etapes suivantes
{: #next-steps }
Pour continuer le développement {{ site.data.keys.product_adj }} dans les applications Cordova, vous devez ajouter le logiciel SDK Cordova/des plug-in {{ site.data.keys.product_adj }} à l'application Cordova.

* Apprenez à ajouter le logiciel SDK [{{ site.data.keys.product_adj }} à des applications Cordova](../../../application-development/sdk/cordova/).
* Pour le développement d'applications, reportez-vous aux tutoriels relatifs à l'[utilisation du logiciel SDK de {{ site.data.keys.product }}](../../../application-development/).
* Pour le développement d'adaptateurs, reportez-vous à la catégorie relative aux [adaptateurs](../../../adapters/).
