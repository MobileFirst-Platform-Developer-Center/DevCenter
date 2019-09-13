---
layout: tutorial
title: Installation et configuration
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #installation-and-configuration }

Vous pouvez désormais installer Digital App Builder sur les plateformes MacOS et Windows. L'installation initiale inclut également l'installation et la vérification des logiciels prérequis. Vous pouvez installer Java, Xcode et Android Studio pour la génération des adaptateurs et la prévisualisation de l'application au cours du développement.

### Installation sur MacOS
{: #installing-on-macos }

1. Téléchargez le fichier .dmg (**IBM.Digital.App.Builder-n.n.n.dmg**, où `n.n.n` correspond au numéro de version) depuis [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou en cliquant [ici](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
2. Cliquez deux fois sur le fichier .dmg pour monter le programme d'installation.
3. Dans la fenêtre ouverte par le programme d'installation, faites glisser et déposez IBM Digital App Builder dans le dossier **Applications**.
4. Cliquez deux fois sur l'icône ou l'exécutable IBM Digital App Builder pour ouvrir Digital App Builder.
    >**Remarque** : Lors de la première installation de Digital App Builder, Digital App Builder ouvrez l'interface permettant d'installer les logiciels prérequis.
    
    ![Installation de Digital App Builder](dab-install-startup.png)

5. Cliquez sur **Commencer à configurer**. L'écran du contrat de licence s'affiche.

    ![Ecran du contrat de licence](dab-install-license.png)

6. Acceptez le contrat de licence et cliquez sur **Suivant**. L'écran **Installer les prérequis** apparaît.
    >**Remarque** : Une vérification permet de savoir si un des logiciels prérequis est déjà installé. Le statut correspondant s'affiche en regard de chacun d'entre eux.

    ![Ecran Installer les prérequis](dab-install-prereq.png)

7. Cliquez sur **Installer** pour configurer les logiciels prérequis si l'un d'entre eux présente le statut **A installer**.

    ![Ecran Installer les prérequis](dab-install-prereq-tobeinstalled.png)

8. Une fois les logiciels prérequis installés, l'écran de démarrage de Digital App Builder apparaît. Cliquez sur **Commencer à générer**.

    ![Démarrage de Digital App Builder](dab-install-startup-screen.png)

9. *Facultatif* : une fois les logiciels prérequis installés, le programme d'installation vérifie la présence de JAVA  car Digital App Builder a besoin de JAVA pour utiliser vos jeux de données.
    >**Remarque** : Vous devez installer manuellement JAVA, s'il n'est pas déjà installé. Pour connaître les instructions d'installation, voir [Installation de Java](https://www.java.com/en/download/help/download_options.xml).
10. *Facultatif* : Le programme d'installation vérifie également la présence facultative de Xcode (pour la prévisualisation de votre application sur un simulateur iOS au cours du développement, sous MacOS uniquement) et sur Android Studio (pour la prévisualisation de votre application Android, sous MacOS et Windows).
    >**Remarque** : Vous devez installer manuellement Xcode et Android Studio. Pour connaître les instructions d'installation de Cocoapods, voir [Utilisation de CocoaPods](https://guides.cocoapods.org/using/using-cocoapods). Pour connaître les instructions d'installation d'Android Studio, voir [Installation d'Android Studio](https://developer.android.com/studio/). 

>**Remarque** : Vous pouvez à tout moment effectuer un [contrôle prérequis](#prerequisites-check) afin de vérifier que l'installation est adéquate pour le développement de votre application. En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

### Installation sur Windows
{: #installing-on-windows }

Exécutez les commandes suivantes à partir de l'invite de commande ouverte en mode d'administration :

1. Téléchargez le fichier .exe (**IBM.Digital.App.Builder.Setup.n.n.n.exe**, où `n.n.n` correspond au numéro de version) depuis [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou en cliquant [ici](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
2. Cliquez deux fois sur l'exécutable Digital App Builder pour procéder à l'installation.

    ![Installation de Digital App Builder](dab-install-startup.png)

3. Cliquez sur **Commencer à configurer**. L'écran du contrat de licence s'affiche.

    ![Ecran du contrat de licence](dab-install-license.png)

4. Acceptez le contrat de licence et cliquez sur **Suivant**. L'écran **Installer les prérequis** apparaît.
    >**Remarque** : Une vérification permet de savoir si un des logiciels prérequis est déjà installé. Le statut correspondant s'affiche en regard de chacun d'entre eux.

    ![Ecran Installer les prérequis](dab-install-prereq.png)

5. Cliquez sur **Installer** pour configurer les logiciels prérequis si l'un d'entre eux présente le statut **A installer**.

    ![Ecran Installer les prérequis](dab-install-prereq-tobeinstalled.png)

6. Une fois les logiciels prérequis installés, l'écran de démarrage de Digital App Builder apparaît. Cliquez sur **Commencer à générer**.

    ![Démarrage de Digital App Builder](dab-install-startup-screen.png)

    >**Remarque** : Un raccourci est également créé dans **Démarrer > Programmes** sur le bureau. Le dossier d'installation par défaut est `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.2`.

7. *Facultatif* : une fois les logiciels prérequis installés, le programme d'installation vérifie la présence de JAVA  car Digital App Builder a besoin de JAVA pour utiliser vos jeux de données.
    >**Remarque** : Vous devez installer manuellement JAVA, s'il n'est pas déjà installé. Pour connaître les instructions d'installation, voir [Installation de Java](https://www.java.com/en/download/help/download_options.xml).
8. *Facultatif* : Le programme d'installation vérifie également la présence facultative de Xcode (pour la prévisualisation de votre application sur un simulateur iOS au cours du développement, sous MacOS uniquement) et sur Android Studio (pour la prévisualisation de votre application Android, sous MacOS et Windows).
    >**Remarque** : Vous devez installer manuellement Android Studio. Pour connaître les instructions d'installation d'Android Studio, voir [Installation d'Android Studio](https://developer.android.com/studio/). 

>**Remarque** : Vous pouvez à tout moment effectuer un [contrôle prérequis](#prerequisites-check) afin de vérifier que l'installation est adéquate pour le développement de votre application. En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

### Vérification des prérequis
{: #prerequisites-check }

Vous pouvez effectuer une vérification des prérequis en sélectionnant **Aide > Vérification des prérequis** avant de développer une application.

![Vérification des prérequis](dab-prerequsites-check.png)

En présence d'erreurs, procédez à la correction et redémarrez Digital App Builder avant de créer une application.

>**Remarque** : [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) est requis uniquement pour MacOS.

