---
layout: tutorial
title: Installation et configuration
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #installation-and-configuration }

Vous pouvez installer Digital App Builder sur les plateformes MacOS et Windows.

### Installation sur MacOS
{: #installing-on-macos }

1. Installez **Node.js** et **npm** en les téléchargeant depuis [https://nodejs.org/en/download](https://nodejs.org/en/download) (Node.js 8.x ou version ultérieure). Pour plus d'informations sur les instructions d'installation, cliquez [ici](https://nodejs.org/en/download/package-manager/). Vérifiez la version de Node.js et de npm comme suit :
    ```java
    $node -v
    v8.10.0
    $npm -v
    6.4.1
    ```
2. Installez **Cordova**. Vous pouvez télécharger et installer le package à partir de [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html).
    ```java
    $ npm install -g cordova
    $ cordova –version
    7.0.1
    ```

    >**Remarque** : Si vous rencontrez des problèmes de droits lors de l'exécution de la commande `$ npm install -g cordova`, effectuez l'installation avec des droits élevés (`$ sudo npm install -g cordova`).

3. Installez **ionic**. Vous pouvez télécharger et installer le package à partir de [ionic](https://ionicframework.com/docs/cli/).
    ```java
    $ npm install -g ionic
    $ ionic –version
    4.2.0
    ```

    >**Remarque** : Si vous rencontrez des problèmes de droits lors de l'exécution de la commande `$ npm install -g ionic`, effectuez l'installation avec des droits élevés (`$ sudo npm install -g ionic`).

4. Téléchargez le fichier .dmg (**IBM.Digital.App.Builder-8.0.0.dmg**) depuis [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou en cliquant [ici](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
5. Cliquez deux fois sur le fichier .dmg pour monter le programme d'installation.
6. Dans la fenêtre ouverte par le programme d'installation, faites glisser et déposez IBM Digital App Builder dans le dossier **Applications**.
7. Cliquez deux fois sur l'icône ou l'exécutable IBM Digital App Builder pour ouvrir Digital App Builder.
>**Remarque** : Lorsque Digital App Builder est installé pour la première fois, l'interface de Digital App Builder s'ouvre et réalise une [Vérification des prérequis](#prerequisites-check). En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

### Installation sur Windows
{: #installing-on-windows }

Exécutez les commandes suivantes à partir de l'invite de commande ouverte en mode d'administration :

1. Installez **Node.js** et **npm** en les téléchargeant depuis [https://nodejs.org/en/download](https://nodejs.org/en/download) (Node.js 8.x ou version ultérieure). Pour plus d'informations sur les instructions d'installation, cliquez [ici](https://nodejs.org/en/download/package-manager/). Vérifiez la version de Node.js et de npm comme suit :  

    ```java
    C:\>node -v
    v8.10.0
    C:\>npm -v
    6.4.1
    ```

2. Installez **Cordova**. Vous pouvez télécharger et installer le package à partir de [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html).
    

    ```java
    C:\>npm install -g cordova
    C:\>cordova –v
    7.0.1
    ```

3. Installez **ionic**. Vous pouvez télécharger et installer le package à partir de [ionic](https://ionicframework.com/docs/cli/).
    

    ```java
    C:\>npm install -g ionic
    C:\> ionic –version
    4.2.0
    ``` 

4. Téléchargez le fichier .exe (**IBM.Digital.App.Builder.Setup.8.0.0.exe**) depuis [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou en cliquant [ici](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
5. Cliquez deux fois sur l'exécutable Digital App Builder pour procéder à l'installation. Un raccourci est également créé dans **Démarrer > Programmes** sur le bureau. Le dossier d'installation par défaut est `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.0`.
>**Remarque** : Lorsque Digital App Builder est installé pour la première fois, l'interface de Digital App Builder s'ouvre et réalise une [Vérification des prérequis](#prerequisites-check). En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

### Vérification des prérequis
{: #prerequisites-check }

Vous pouvez effectuer une vérification des prérequis en sélectionnant **Aide > Vérification des prérequis** avant de développer une application.

![Vérification des prérequis](dab-prerequsites-check.png)

En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

>**Remarque** : [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) est requis uniquement pour MacOS.

