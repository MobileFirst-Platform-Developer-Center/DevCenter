---
layout: tutorial
title: Configuration de l'environnement de développement React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
React Native est une infrastructure qui permet d'utiliser [React](https://reactjs.org/) pour créer rapidement des applications mobiles natives iOS et Android à l'aide de technologies telles que HTML, CSS et Javascript.

Si vous êtes développeur et si vous avez choisi React Native comme infrastructure de développement pour vos applications mobiles ou Web, les sections qui suivent vous expliqueront comment utiliser le logiciel SDK [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) dans vos applications React Native.

Vous pouvez écrire vos applications à l'aide de l'éditeur de code de votre choix (par exemple Atom.io, Visual Studio Code, Eclipse, IntelliJ, ou d'autres).

**Prérequis :** Lors de la configuration de votre environnement de développement React Native, lisez également le tutoriel [Configuration de l'environnement de développement MobileFirst](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst).

## Installation de l'interface de ligne de commande React Native
{: #installing_cli }
La première étape requise pour le développement React Native est l'installation de [l'interface de ligne de commande React Native](https://facebook.github.io/react-native/docs/getting-started.html).

**Pour installer l'interface de ligne de commande React Native :**

* Téléchargez et installez [NodeJS](https://nodejs.org/en/).
* Depuis une fenêtre de ligne de commande, exécutez la commande :
```bash
npm install -g react-native-cli
```

## Ajout du SDK Mobile Foundation à votre application React Native
{: #adding_mfp_reactnative_sdk }
Pour permettre le développement MobileFirst dans vos applications React Native, vous devez ensuite y ajouter le SDK ou les plug-in React Native de MobileFirst.

Apprenez à ajouter le logiciel SDK MobileFirst aux applications React Native.
Pour le développement d'application, reportez-vous au tutoriel [Adding the Mobile Foundation SDK to React Native applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/reactnative).
