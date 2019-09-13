---
layout: tutorial
title: Développement d'une application
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #developing-an-app }

Pour développer une application, procédez comme suit :

1. Créez une application. Voir [Création d'une application](../getting-started/).
2. Concevez votre application en ajoutant les contrôles requis. Pour plus d'informations, voir [Interface de Digital App Builder](../dab-interface/).
3. Ajoutez les services dont vous avez besoin (Watson Chat, Watson Visual Recognition, Notifications push, Jeu de données) dans votre application.
4. Ajoutez ou modifiez les plateformes si nécessaire. Voir [Paramètres > Détails de l'application](../dab-interface/).
5. Prévisualisez votre application. Voir [Aperçu de l'application à l'aide du simulateur](#preview-the-app-using-the-simulator).
6. Après avoir prévisualisé l'application et si elle est prête à être créée après rectification des éventuelles erreurs, procédez comme suit pour la générer :

    * **Dans le cas d'une application Android**

        a. Accédez au répertoire que vous avez indiqué à la création de l'application.

        b. Accédez au dossier ionic.

        c. Accédez à **Plateforme > Android**.

        d. Ouvrez Android Studio, puis accédez à **File > Open Project** > Choose pour sélectionner le dossier android mentionné à l'étape c.

        e. Générez le projet. 

        >**Remarque** : Pour la publication et la génération, suivez les étapes du tutoriel disponible à l'adresse [https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/).

    * **Dans le cas d'une application iOS**
 
        a. Accédez au répertoire que vous avez indiqué à la création de l'application.

        b. Accédez au dossier ionic.

        c. Accédez à Plateforme > iOS.

        d. Ouvrez **Xcode** et générez le projet. 

        >**Remarque** : Pour la publication et la génération, suivez les étapes du tutoriel disponible à l'adresse [https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/).


### Aperçu de l'application à l'aide du simulateur
{: #preview-the-app-using-the-simulator }

Vous pouvez prévisualiser l'application en vous connectant à la simulation sur le canal sélectionné.

* Pour prévisualiser l'application sur iOS, téléchargez et installez **XCode** depuis l'Apple App Store.
* Pour prévisualiser l'application sur Android : 
    * Installez Android Studio et suivez les instructions disponibles à l'adresse [https://developer.android.com/studio/](https://developer.android.com/studio/).
    * Configurez une machine virtuelle Android. Suivez les instructions en cliquant [ici](https://developer.android.com/studio/releases/emulator).

