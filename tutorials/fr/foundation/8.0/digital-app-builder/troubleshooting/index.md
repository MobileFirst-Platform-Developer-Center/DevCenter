---
layout: tutorial
title: Traitement des incidents
weight: 19
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #troubleshooting }

Vous trouverez ci-après les réponses à certains problèmes que vous êtes susceptibles de rencontrer lorsque vous utilisez IBM Digital App Builder.

* En cas d'erreur, reportez-vous au fichier :

    * `log.log` correspondant à votre plateforme :

        * Sur mac OS : `~/Library/Logs/IBM Digital App Builder/log.log`

        * Sur Windows : `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`

    * `applog.log` pour les journaux liés à votre application qui se trouvent dans `<APP LOCATION>/ibm/applog.log`.

* Echec de la création d'un jeu de données pour un microservice à l'aide d'un fichier swagger.

    Lors de la première utilisation de Builder, la création de microservice peut échouer en raison du temps d'attente des réseaux.
    Pour vous affranchir de ce problème, procédez comme suit :
    1. Ouvrez l'invite de commande et accédez à l'emplacement d'installation de l'application.
    2. `cd ibm\adapterGenerator`
    3. Exécutez la commande suivante :
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. Lorsque cette commande aboutit, vous pouvez commencer à utiliser le microservice (fichier swagger) depuis Digital App Builder.

* Echec de la prévisualisation de l'application sur Windows.

    Dans Digital App Builder, accédez à **Paramètres > Réparer le projet** et cliquez sur les boutons **Régénérer les dépendances** et **Régénérer les plateformes**.

* L'application Android ne fonctionne pas après l'ajout du composant Liste dans l'application.

    Ce problème survient car la version d'Android WebView est antérieure à la version 68.X.XXXX.XX. Pour résoudre ce problème, mettez à niveau Android WebView vers la version 68.X.XXXX.XX ou ultérieure.

* Sur MacOS, la prévisualisation de l'application sur un simulateur Android échoue et l'application tombe en panne avec l'erreur suivante :

    `java.lang.RuntimeException: Unable to create application com.ibm.MFPApplication: java.lang.RuntimeException: Client configuration file mfpclient.properties not found in application assets. Use the MFP CLI command 'mfpdev app register' to create the file.`

    Pour résoudre ce problème, à partir du terminal, accédez au répertoire ionic de l'application et exécutez les commandes suivantes :

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    Prévisualisez à nouveau l'application depuis Digital App Builder.

* Impossible de générer l'adaptateur lors de l'importation du fichier swagger json/yaml.

    Cette erreur est liée à la dépendance Maven.

    Idéalement, toutes les dépendances Maven qui n'existent pas sont téléchargées et installées derrière la scène. Mais Maven échoue parfois en raison de ses multiples versions dans le système. Pour résoudre ce problème, procédez comme suit :

    a. Accédez à l'emplacement Aa\pp et ouvrez le fichier execute.sh/execute.bat selon le système d'exploitation. (`<APP_LOCATION>\ibm\adapterGenerator`)

    b. Modifiez toutes les occurrences de `call %MAVEN_HOME% clean install` en `call %MAVEN_HOME% -U clean install`.

        Le fait d'ajouter `-U` force Maven à vérifier toutes les dépendances externes qui doivent être mises à jour en fonction du fichier POM.

* Le contrôle prérequis échoue pour Android Studio même s'il est installé.

    Vérifiez que l'exécutable Android (`<path to android sdk>/tools`) figure dans le chemin et vérifiez les prérequis.

* Problème de création et de prévisualisation d'application sur Windows 7

    Vous risquez d'obtenir une erreur lorsque vous tentez de créer une application à un emplacement d'unité de disque autre que `C:`.

    Veillez à créer votre unité d'application sous l'unité `C://<your folder name/app name>`.

* Digital App Builder tombe en panne avec un écran rouge.

    Si vous voyez un écran rouge de panne, consultez les journaux à cet emplacement :
    * Sur MacOS : `/Users/<username>/Library/Logs/IBM Digital App Builder/log.log`
    * Sur Windows : `C:\\Users\<username>\AppData\Roming\IBM Digital App Builder\log.log`

    Si l'erreur concerne un élément `getPath` issu de `rendered.js`, il s'agit d'un [problème connu lié à electron](https://github.com/electron/electron/issues/8205).

    Cette erreur se produit de manière aléatoire.

    Redémarrez Digital App Builder et votre scénario devrait fonctionner.
