---
layout: tutorial
title: Distribution d'applications mobiles avec IBM Application Center
breadcrumb_title: Distributing apps with Application Center
relevantTo: [ios,android,windows8,cordova]
show_in_nav: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.mf_app_center_full }} est un **référentiel d'applications mobiles** similaire aux magasins d'applications publics, mais axé sur les besoins d'une organisation ou d'une équipe. Il s'agit d'un magasin d'applications privé.

Application Center facilite le partage des applications mobiles :

* Vous pouvez partager des informations de **commentaires et d'évaluation**.  
* Vous pouvez utiliser les listes de contrôle d'accès pour limiter les personnes qui peuvent installer des applications.

Application Center fonctionne avec des applications {{ site.data.keys.product_adj }} et non {{ site.data.keys.product_adj }} et prend en charge toutes les applications **iOS, Android**, **BlackBerry 6/7** et **Windows/Phone 8.x**.

> **Remarque :** les fichiers Archive/IPA générés à l'aide de Test Flight ou d'iTunes Connect pour la soumission ou la validation d'applications iOS dans les magasins peuvent entraîner un échec/une panne d'exécution. Pour en savoir plus, lisez le blog [Preparing iOS apps for App Store submission in IBM MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).

Vous pouvez utiliser Application Center dans différents contextes. Par exemple :

* En tant que magasin d'applications d'entreprise à travers une organisation.
* Pendant le développement pour distribuer des applications au sein d'une équipe.

> **Remarque :** pour générer l'application iOS AppCenter Installer, MobileFirst 7.1 est requis.

#### Accéder à
{: #jump-to}
* [Installation et configuration](#installing-and-configuring)
* [Client IBM AppCenter basé sur Cordova](#cordova-based-ibm-appcenter-client)
* [Préparation des clients mobiles](#preparing-mobile-clients)
* [Gestion des applications dans la console Application Center](#managing-applications-in-the-application-center-console)
* [Client mobile Application Center](#the-application-center-mobile-client)
* [Outils de ligne de commande Application Center](#application-center-command-line-tools)

## Installation et configuration
{: #installing-and-configuring }
Application Center est installé dans le cadre de l'installation de {{ site.data.keys.mf_server }} avec IBM Installation Manager.

**Prérequis :** avant d'installer Application Center, vous devez avoir installé un serveur d'applications et une base de données :

* Serveur d'applications : profil complet Tomcat ou WebSphere Application Server ou profil Liberty
* Base de données : DB2, Oracle ou MySQL

Si vous ne disposez pas d'une base de données installée, le processus d'installation peut également installer une base de données Apache Derby. Toutefois, l'utilisation de la base de données Derby n'est pas recommandée pour les scénarios de production.

1. IBM Installation Manager vous guide à travers l'installation Application Center pour choisir la base de données et le serveur d'applications.

    > Pour plus d'informations, voir la rubrique sur l'[installation de {{ site.data.keys.mf_server }}](../../installation-configuration).

    Étant donné que iOS 7.1 prend uniquement en charge le protocole https, le serveur Application Center doit être sécurisé avec SSL (au moins avec TLS v.1) si vous prévoyez de distribuer des applications pour des appareils exécutant iOS 7.1 ou version ultérieure. Les certificats auto-signés ne sont pas recommandés, mais peuvent être utilisés à des fins de test, à condition que les certificats d'AC auto-signés soient distribués aux appareils.

2. Une fois Application Center installé avec IBM Installation Manager, ouvrez la console : `http://localhost:9080/appcenterconsole`

3. Connectez-vous avec cette combinaison utilisateur/mot de passe : demo/demo

4. A ce stade, vous pouvez configurer l'authentification des utilisateurs. Par exemple, vous pouvez vous connecter à un référentiel LDAP.

    > Pour plus d'informations, voir la rubrique sur la [configuration Application Center après l'installation](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation).

5. Préparez le client mobile pour Android, iOS, BlackBerry 6/7 et Windows Phone 8

Le client mobile est l'application mobile que vous utilisez pour parcourir le catalogue et installer l'application.

> **Remarque :** pour une installation de production, envisagez d'installer Application Center en exécutant les tâches Ant fournies : cela vous permet de découpler les mises à jour du serveur à partir des mises à jour vers Application Center.

## Client IBM AppCenter basé sur Cordova
{: #cordova-based-ibm-appcenter-client }
Le projet client AppCenter basé sur Cordova est situé dans le répertoire `install`, à l'adresse : **install_dir/ApplicationCenter/installer/CordovaAppCenterClient**.

Ce projet est basé uniquement sur l'infrastructure Cordova et n'a donc aucune dépendance sur les API client/serveur de {{ site.data.keys.product }}.  
Dans la mesure où il s'agit d'une application Cordova standard, il n'y a pas non plus de dépendance de {{ site.data.keys.mf_studio }}. Cette application utilise Dojo pour l'interface utilisateur.

Suivez les étapes ci-dessous pour apprendre à :

1. Installer Cordova.

```bash
npm install -g cordova@latest
```

2. Installer le SDK Android et définir `ANDROID_HOME`.  
3. Générer et exécuter ce projet.

Générer toutes les plateformes :

```bash
cordova build
```

Générer uniquement les systèmes d'exploitation Android :

```bash
cordova build android
```

Générer uniquement les systèmes d'exploitation iOS :

```bash
cordova build ios
```

### Personnalisation de l'application AppCenter Installer
{: #customizing-appcenter-installer-application }
Vous pouvez personnaliser davantage l'application, comme la mise à jour de son interface utilisateur pour votre société ou vos besoins spécifiques.

> **Remarque :** bien que vous puissiez personnaliser librement l'interface utilisateur et le comportement de l'application, ces modifications ne sont pas couvertes par l'accord de prise en charge IBM.

#### Android
{: #android }
* Ouvrez Android Studio.
* Sélectionnez **Import project (Eclipse ADT, Gradle, etc.)**
* Sélectionnez le dossier android dans **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android**.

Cela peut prendre du temps. Une fois cette opération terminée, vous êtes prêt à personnaliser.

> **Remarque :** sélectionnez d'ignorer l'option de mise à jour dans la fenêtre contextuelle, pour mettre à niveau la version gradle. Consultez `grade-wrapper.properties` pour la version.

#### iOS
{: #ios }
* Accédez à **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms**.
* Cliquez pour ouvrir le fichier **IBMAppCenterClient.xcodeproj**, le projet est ouvert dans Xcode et vous êtes prêt pour la personnalisation.

## Préparation des clients mobiles
{: #preparing-mobile-clients }
### Pour les téléphones et tablettes Android
{: #for-android-phones-and-tablets }
Le client mobile est livré en tant qu'application compilée (APK) et se trouve dans **install_dir/ApplicationCenter/installer/IBMApplicationCenter.apk**

> **Remarque :** consultez [Client IBM AppCenter basé sur Cordova](#cordova-based-ibm-appcenter-client), si vous utilisez une infrastructure Cordova pour la génération d'un client AppCenter Android et iOS.

### Pour iPad et iPhone
{: #for-ipad-and-iphone }
1. Compilez et signez l'application client fournie dans le code source. Ceci est obligatoire.

2. Dans MobileFirst Studio, ouvrez IBMAppCenter Project dans : **install\_dir/ApplicationCenter/installer**

3. Utilisez **Run As → Run on MobileFirst Development Server** pour générer le projet.

4. Utilisez Xcode pour créer et signer l'application avec votre profil Apple iOS Enterprise.  
Vous pouvez ouvrir le projet natif obtenu (dans **iphone\native**) manuellement dans Xcode, ou cliquer avec le bouton droit de la souris sur le dossier iPhone et sélectionner **Run As → Xcode project**. Cette action génère le projet et l'ouvre dans Xcode.

> **Remarque :** consultez [Client IBM AppCenter basé sur Cordova](#cordova-based-ibm-appcenter-client), si vous utilisez une infrastructure Cordova pour la génération d'un client AppCenter Android et iOS.

### Pour Blackberry
{: #for-blackberry }
* Pour générer la version BlackBerry, vous devez disposer de l'environnement IDE Eclipse pour BlackBerry (ou Eclipse avec le plug-in Java pour BlackBerry) avec le SDK 6.0 pour BlackBerry. L'application s'exécute également sur BlackBerry OS 7 lorsqu'elle est compilée avec le SDK 6.0 pour BlackBerry.

Un projet BlackBerry est fourni dans : **install\_dir/ApplicationCenter/installer/IBMAppCenterBlackBerry6**

### Pour Windows Phone 8
{: #for-windows-phone-8}
1.  Enregistrez un compte de société auprès de Microsoft.  
Application Center gère uniquement les applications de société qui sont signées avec le certificat de société fourni avec votre compte de société.

2. La version Windows Phone du client mobile est incluse à l'adresse suivante : **install\_dir/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap**

* Assurez-vous que le client mobile Application Center est également signé avec ce certificat de société.

* Pour installer des applications de société sur un appareil, inscrivez d'abord l'appareil auprès de la société en installant un jeton d'inscription de société.

> Pour plus d'informations sur les comptes de société et les jetons d'inscription, consultez la page [Microsoft Developer website → Company app distribution for Windows Phone](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).aspx).

> Pour plus d'informations sur la façon de signer des applications de client mobile Windows Phone, consultez le [site Web Microsoft Developer](http://dev.windows.com/en-us/develop).

<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important :** vous **ne pouvez pas** utiliser le fichier `.xap` non signé directement. Avant de l'installer sur un appareil, vous devez d'abord le signer avec votre certificat de société, que vous avez obtenu auprès de Symantec ou de Microsoft.

### Pour Windows Store Apps pour Windows 8.1 Pro
{: #for-windows-store-apps-for-windows-81-pro }
* Le fichier **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** contient l'exécutable du client Application Center. Transmettez ce fichier à l'ordinateur client et décompressez-le. Il contient le programme exécutable.

* L'installation d'une application Windows Store (fichier de type `appx`) sans utiliser Microsoft Windows Store s'appelle chargement indépendant (<em>sideloading</em>) d'une application. Pour charger une application, vous devez respecter les prérequis de la page [Prepare to sideload apps](https://technet.microsoft.com/fr-fr/library/dn613842.aspx. The Windows 8.1.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading Store Apps to Windows 8.1.1 Devices]( http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx).

## Gestion des applications dans la console Application Center
{: #managing-applications-in-the-application-center-console }
![Illustration de la gestion des applications dans App Center]({{ site.baseurl }}/assets/backup/overview1.png)

Utilisez la console Application Center pour gérer les applications dans le catalogue de la manière suivante :

* Ajouter et supprimer des applications
* Gérer les versions des applications    
* Consulter les détails d'une application
* Limiter l'accès d'une application à certains utilisateurs ou groupes d'utilisateurs
* Lire les revues pour chaque application
* Réviser des utilisateurs et des appareils enregistrés

### Ajout de nouvelles applications au magasin
{: #adding-new-applications-to-the-store }
![Illustration de l'ajout d'applications dans App Center]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

Pour ajouter de nouvelles applications au magasin :

1. Ouvrez la console Application Center.
2. Cliquez sur **Add application**.
3. Sélectionner un fichier d'application :
    * `.ipa` : iOS
    * `.apk` : Android
    * `.zip` : BlackBerry 6/7
    * `.xap` : Windows Phone 8.x
    * `.appx` : Windows Store 8.x

* Cliquez sur **Next**.

    Dans les vues Application Details, vous pouvez consulter les informations relatives à la nouvelle application et entrer d'autres informations telles que la description. Vous pouvez revenir ultérieurement à cette vue pour toutes les applications du catalogue.

    ![Image de l'écran des détails de l'application]({{ site.baseurl }}/assets/backup/appDetails1.png)

* Cliquez sur **Done** pour terminer la tâche.

La nouvelle application est ajoutée au magasin.

![Illustration du contrôle d'accès dans App Center]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)

Par défaut, une application peut être installée par tout utilisateur autorisé du magasin.

### Restriction de l'accès à un groupe d'utilisateurs
{: #restricting-access-to-a-group-of-users }
Pour limiter l'accès à un groupe d'utilisateurs :

1. Dans la vue de catalogue, cliquez sur le **lien sans restriction** en regard du nom de l'application. La page Installation Access Control s'affiche.
2. Sélectionnez **Access control enabled**. Vous pouvez maintenant entrer la liste des utilisateurs ou groupes autorisés à installer l'application.
3. Si vous avez configuré LDAP, ajoutez les utilisateurs et les groupes qui sont définis dans le référentiel LDAP.

Vous pouvez également ajouter des applications à partir de magasins d'applications publics tels que Google Play ou Apple App Store en saisissant leurs URL.

## Client mobile Application Center
{: #the-application-center-mobile-client }
Le client mobile Application Center est une application mobile permettant de gérer les applications sur l'appareil. Avec le client mobile, vous pouvez :

* Répertorier toutes les applications du catalogue (pour lesquelles vous avez des droits d'accès).
* Répertorier les applications favorites.
* Installer une application ou mettre à niveau vers une nouvelle version.
* Fournir des commentaires et une évaluation sur cinq étoiles pour une application.

### Ajout d'applications de client mobile au catalogue
{: #adding-mobile-client-applications-to-the-catalog }
Vous devez ajouter des applications de client mobile Application Center au catalogue.

1. Ouvrez la console Application Center.
2. Cliquez sur le bouton **Add Application** pour ajouter le fichier de client mobile `.apk`, `.ipa`, `.zip` ou `.xap`.
3. Cliquez sur **Next** pour ouvrir la page Application Details.
4. Dans la page Application Details, sélectionnez **Installer** pour indiquer que cette application est un client mobile.
5. Cliquez sur **Done** pour ajouter l'application Application Center au catalogue.

Il n'est pas nécessaire d'ajouter le client Application Center pour Windows 8.1 au catalogue. Ce client est un programme `.exe` Windows standard contenu dans le fichier **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip**. Vous pouvez simplement le copier sur l'ordinateur client.

### Windows Phone 8
{: #windows-phone-8 }
Sous Windows Phone 8, vous devez également installer le jeton d'inscription que vous avez reçu avec votre compte de société dans la console Application Center afin que les utilisateurs puissent inscrire leurs appareils. Vous utilisez la page Settings Application Center que vous pouvez ouvrir à l'aide de l'icône représentant une roue dentée.

![Illustration de l'enregistrement des applications dans Windows Phone 8]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

Avant d'installer le client mobile, vous devez inscrire l'appareil auprès de la société en installant le jeton d'inscription :

1. Ouvrez le navigateur Web sur l'appareil.
2. Entrez l'URL : `http://hostname:9080/appcenterconsole/installers.html`
3. Entrez le nom d'utilisateur et le mot de passe.
4. Cliquez sur **Tokens** pour ouvrir la liste des jetons d'inscription.
5. Sélectionnez la société dans la liste. Les détails du compte de société s'affichent.
6. Cliquez sur **Add Company Account**. Votre appareil est inscrit.

### Installation du client mobile sur l'appareil mobile
{: #installing-the-mobile-client-on-the-mobile-device }
Pour installer le client mobile sur l'appareil mobile :
![Image de l'application d'installation d'applications]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. Ouvrez le navigateur Web sur l'appareil.
2. Entrez l'URL : `http://hostname:9080/appcenterconsole/installers.html`
3. Entrez le nom d'utilisateur et le mot de passe.
4. Sélectionnez l'application Application Center pour lancer l'installation.

Sur les appareils **Android**, vous devez ouvrir l'application Android Download et sélectionner **IBM App Center** pour installation.

### Connexion au client mobile
{: #logging-in-to-the-mobile-client }
Pour vous connecter au client mobile :

1. Entrez vos données d'identification pour accéder au serveur.
2. Entrez le nom d'hôte ou l'adresse IP du serveur.
3. Dans la zone **Server port**, entrez le numéro de port s'il ne s'agit pas de la valeur par défaut (`9080`).
4. Dans la zone **Application context**, entrez le contexte : `applicationcenter`.

![Ecran de connexion]({{ site.baseurl }}/assets/backup/login.png)

### Vues du client mobile Application Center
{: #application-center-mobile-client-views }
* La vue **Catalog** affiche la liste des applications disponibles.
* La sélection d'une application ouvre la vue **Details** de l'application. Vous pouvez installer des applications à partir de la vue Details. Vous pouvez également marquer les applications en tant que favorites en utilisant l'icône en forme d'étoile dans la vue Details.

    ![Détails du catalogue]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* La vue **Favorites** affiche la liste des applications favorites. Cette liste est disponible sur tous les appareils d'un utilisateur particulier.
* La vue **Updates** répertorie toutes les mises à jour disponibles. Dans la vue Updates, vous pouvez accéder à la vue Details. Vous pouvez sélectionner une nouvelle version de l'application ou utilisez la dernière version disponible. Si Application Center est configuré pour envoyer des notifications push, vous pouvez être averti des mises à jour par des messages de notification push.

Dans le client mobile, vous pouvez évaluer l'application et envoyer une revue. Les revues peuvent être affichées sur la console ou sur l'appareil mobile.

![Revues]({{ site.baseurl }}/assets/backup/reviewss.png)

## Outils de ligne de commande Application Center
{: #application-center-command-line-tools }
Le répertoire **install_dir/ApplicationCenter/tools** contient tous les fichiers nécessaires pour utiliser l'outil de ligne de commande ou des tâches Ant pour la gestion des applications dans le magasin :

* `applicationcenterdeploytool.jar` : outil de ligne de commande de téléchargement.
* `json4jar` : bibliothèque pour le format JSON requis par l'outil de téléchargement.
* `build.xml` : exemple de script Ant que vous pouvez utiliser pour télécharger un fichier unique ou une séquence de fichiers dans Application Center.
* `acdeploytool.sh` et `acdeploytool.bat` : scripts simples pour appeler Java avec le fichier `applicationcenterdeploytool.jar`.

Par exemple, pour déployer un fichier `app.apk` d'application sur le magasin dans `localhost:9080/applicationcenter` avec l'ID utilisateur `demo` et le mot de passe `demo`, entrez :

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
