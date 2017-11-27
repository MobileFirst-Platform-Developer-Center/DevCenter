---
layout: tutorial
title: Préparatifs pour l'utilisation du client mobile
breadcrumb_title: Préparatifs
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
L'application AppCenter Installer permet d'installer des applications sur des appareils mobiles. Vous pouvez générer cette application en utilisant les projets Cordova, Visual Studio, MobileFirst Studio fournis ou utilisez directement une version précompilée du projet MobileFirst Studio pour Android, iOS ou Windows 8 Universal.

#### Accéder à
{: #jump-to }
* [Prérequis](#prerequisites)
* [Client IBM AppCenter basé sur Cordova](#cordova-based-ibm-appcenter-client)
* [Client IBM AppCenter basé sur MobileFirst Studio](#mobilefirst-studio-based-ibm-appcenter-client)
* [Personnalisation de fonctionnalités (pour les spécialistes) : Android, iOS, Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [Déploiement du client mobile dans Application Center](#deploying-the-mobile-client)

## Prérequis
{: #prerequisites }
### Prérequis spécifiques au système d'exploitation Android
{: #prerequisites-specific-to-the-android-operating-system }
La version Native Android du client mobile est incluse dans la livraison du logiciel sous la forme d'un fichier de module d'application Android (.apk). Le fichier **IBMApplicationCenter.apk** se trouve dans le répertoire **ApplicationCenter/installer**. Les notifications push sont désactivées. Si vous souhaitez activer les notifications push, vous devez régénérer le fichier .apk. Voir [Notifications push des mises à jour de l'application](../push-notifications) pour plus d'informations sur les notifications push dans Application Center.

Pour générer la version Android, vous devez disposer de la dernière version des outils de développement Android.

### Prérequis spécifiques au système d'exploitation iOS d'Apple
{: #prerequisites-specific-to-apple-ios-operating-system }
La version iOS native pour iPad et iPhone n'est pas livrée en tant qu'application compilée. L'application doit être créée à partir du projet {{ site.data.keys.product_full }} nommé **IBMAppCenter**. Ce projet est également fourni dans le cadre de la distribution dans le répertoire **ApplicationCenter/installer**.

Pour générer la version d'iOS, vous devez disposer des logiciels appropriés {{ site.data.keys.product_full }} et Apple. La version de {{ site.data.keys.mf_studio }} doit être identique à celle de {{ site.data.keys.mf_server }} sur laquelle cette documentation est basée. La version d'Apple Xcode est V6.1.

### Prérequis spécifiques au système d'exploitation Microsoft Windows Phone
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
La version Windows Phone du client mobile est incluse dans un fichier de module d'application Windows Phone (.xap) non signé dans la livraison du logiciel. Le fichier **IBMApplicationCenterUnsigned.xap** se trouve dans le répertoire **ApplicationCenter/installer**.

> **Important :** le fichier .xap non signé ne peut pas être utilisé directement. Vous devez le signer avec votre certificat de certificat obtenu auprès de Symantec/Microsoft avant de pouvoir l'installer sur un appareil.

Facultatif : si nécessaire, vous pouvez également générer la version Windows Phone à partir de sources. Pour cela, vous devez disposer de la dernière version de Microsoft Visual Studio.

### Prérequis spécifiques au système d'exploitation Microsoft Windows 8
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
La version Windows 8 du client mobile est incluse dans un fichier archive .zip. Le fichier **IBMApplicationCenterWindowsStore.zip** contient un fichier exécutable (.exe) et ses fichiers de bibliothèque de liens dynamiques (.dll) dépendants. Pour utiliser le contenu de cette archive, téléchargez l'archive vers un emplacement sur votre lecteur local et exécutez le fichier exécutable.

Facultatif : si nécessaire, vous pouvez également générer la version Windows 8 à partir de sources. Pour cela, vous devez disposer de la dernière version de Microsoft Visual Studio.

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

## Client IBM AppCenter basé sur MobileFirst Studio
{: #mobilefirst-studio-based-ibm-appcenter-client }
Au lieu d'utiliser le projet Cordova pour iOS et Android, vous pouvez également choisir d'utiliser l'édition précédente de l'application client App Center, basée sur MobileFirst Studio 7.1 et prenant en charge iOS, Android et Windows Phone.

### Importation et génération du projet (Android, iOS, Windows Phone)
{: #importing-and-building-the-project-android-ios-windows-phone }
Vous devez importer le projet **IBMAppCenter** dans {{ site.data.keys.mf_studio }}, puis générer le projet.

> **Remarque :** pour V8.0.0, utilisez MobileFirst Studio 7.1. Vous pouvez télécharger MobileFirst Studio depuis la page [Downloads]({{site.baseurl}}/downloads). Pour les instructions d'installation, voir [Installing MobileFirst Studio](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html) dans IBM Knowledge Center pour 7.1.

1. Sélectionnez **File → Import**.
2. Sélectionnez **General → Existing Project into Workspace**.
3. Sur la page suivante, sélectionnez **Select root directory** et localisez la racine du projet **IBMAppCenter**.
4. Sélectionnez le projet **IBMAppCenter**.
5. Sélectionnez **Copy projects into workspace**. Cette sélection crée une copie du projet dans votre espace de travail. Sur les systèmes UNIX, le projet IBMAppCenter est lu uniquement à l'emplacement d'origine. Ainsi, la copie de projets dans l'espace de travail évite les problèmes de droits d'accès aux fichiers.
6. Cliquez sur **Finish** pour importer le projet **IBMAppCenter** dans MobileFirst Studio.

Générez le projet **IBMAppCenter**. Le projet MobileFirst contient une seule application nommée **AppCenter**. Cliquez avec le bouton droit de la souris sur l'application et sélectionnez **Run as → Build All Environments**.

#### Importation et génération du projet sous Android
{: #importing-building-projects-android }
MobileFirst Studio génère un projet Android natif dans **IBMAppCenter/apps/AppCenter/android/native**. Un projet d'outils de développement Android (ADT) natif se trouve dans le dossier android/native. Vous pouvez compiler et signer ce projet à l'aide des outils ADT. Ce projet nécessite l'installation du SDK Android de niveau 16, de sorte que l'APK obtenu soit compatible avec toutes les versions 2.3 et ultérieures d'Android. Si vous choisissez un niveau supérieur du SDK Android lors de la génération du projet, l'APK résultant ne sera pas compatible avec Android version 2.3.

Reportez-vous au [site Android pour les développeurs](https://developer.android.com/index.html) pour des informations plus spécifiques sur Android qui affectent l'application client mobile.

Si vous souhaitez activer les notifications push pour les mises à jour d'application, vous devez d'abord configurer les propriétés du client Application Center. Voir [Configuration des notifications push pour les mises à jour d'application](../push-notifications) pour plus d'informations.

#### Importation et génération du projet sous iOS
{: #importing-building-projects-ios }
MobileFirst Studio génère un projet iOS natif dans **IBMAppCenter/apps/AppCenter/iphone/native**. Le fichier **IBMAppCenterAppCenterIphone.xcodeproj** se trouve dans le dossier iphone/native. Ce fichier est le projet Xcode que vous devez compiler et signer en utilisant Xcode.

Consultez [le site pour développeurs Apple](https://developer.apple.com/) pour en savoir plus sur la procédure de signature de l'application client mobile iOS. Pour signer une application iOS, vous devez remplacer l'identificateur de bundle de l'application par un identificateur de bundle qui peut être utilisé avec le profil de mise à disposition que vous utilisez. La valeur est définie dans les paramètres du projet Xcode comme **com.your\_internet\_domain\_name.appcenter**, où **your\_internet\_domain\_name** est le nom de votre domaine Internet.

Si vous souhaitez activer les notifications push pour les mises à jour d'application, vous devez d'abord configurer les propriétés du client Application Center. Voir [Configuration des notifications push pour les mises à jour d'application](../push-notifications) pour plus d'informations.

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio génère un projet Windows Phone 8 natif dans **IBMAppCenter/apps/AppCenter/windowsphone8/native**. Le fichier **AppCenter.csproj** se trouve dans le dossier windowsphone8/native. Ce fichier est le projet Visual Studio que vous devez compiler en utilisant le SDK Visual Studio et Windows Phone 8.0.

L'application est générée avec le [SDK Windows Phone 8.0](https://www.microsoft.com/en-in/download/details.aspx?id=35471) afin qu'elle puisse s'exécuter sur les appareils Windows Phone 8.0 et 8.1. Elle n'est pas générée avec le SDK Windows Phone 8.1, car le résultat ne fonctionnerait pas sur des appareils Windows Phone 8.0 antérieurs.

L'installation de Visual Studio 2013 vous permet de sélectionner l'installation du SDK Windows Phone 8.0 en plus du SDK 8.1. Le SDK Windows Phone 8.0 est également disponible à partir de [Windows Phone SDK Archives](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive).

Consultez [Windows Phone Dev Center](https://developer.microsoft.com/en-us) pour en savoir plus sur la façon de générer et de signer l'application client mobile Windows Phone.

#### Microsoft Windows 8 : génération du projet
{: #microsoft-windows-8-building-the-project }
Le projet Windows 8 Universal est fourni en tant que projet Visual Studio situé à **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj.**  
Vous devez générer le projet client dans Microsoft Visual Studio 2013 afin que vous puissiez le distribuer.

La génération du projet est une condition préalable à sa distribution à vos utilisateurs, or l'application Windows 8 n'est pas destinée à être déployée sur Application Center pour une distribution ultérieure.

Pour générer le projet Windows 8 :

1. Ouvrez le fichier de projet Visual Studio appelé **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** dans Microsoft Visual Studio 2013.
2. Effectuez une génération complète de l'application.

Pour distribuer le client mobile à vos utilisateurs Application Center, vous pouvez ensuite générer un programme d'installation qui installera le fichier exécutable généré (.exe) et ses fichiers de bibliothèque de liens dynamiques (.dll) dépendants. Vous pouvez également fournir ces fichiers sans les inclure dans un programme d'installation.

####  Client IBM AppCenter de Microsoft Windows 10 Universal (Natif)
{: #microsoft-windows-10-universal-(native)-ibm-appcenter-client}

Le client IBM AppCenter de Window 10 Universal natif peut être utilisé pour installer des applications Windows 10 Universal sur des téléphones Windows 10. Utilisez **IBMApplicationCenterWindowsStore** pour installer des applications Windows 10 sur Windows Desktop.

#### Microsoft Windows 10 Universal : création du projet
{: #microsoft-windows-10-universal-building-the-project}

Le projet Windows 10 Universal est fourni sous forme de projet Visual Studio situé dans **IBMAppCenterUWP\IBMAppCenterUWP.csproj**.             
Avant de pouvoir distribuer le projet du client, vous devez le créer dans Microsoft Visual Studio 2015.
>La création du projet est un prérequis avant de le distribuer à vos utilisateurs

Pour créer le projet Windows 10 Universal :
1.  Ouvrez le fichier du projet Visual Studio **IBMAppCenterUWP\IBMAppCenterUWP.csproj**, in Microsoft Visual Studio 2015.
+ Effectuez une génération complète de l'application.
+ Générez le fichier **.appx** comme suit :
  * Cliquez avec le bouton droit de la souris sur le projet et sélectionnez **Store → ///Create App Packages**.

## Personnalisation de fonctionnalités (pour les spécialistes) : Android, iOS, Windows Phone)
{: #customizing-features-for-experts-android-ios-windows-phone }
Vous pouvez personnaliser les fonctionnalités en modifiant un fichier de propriétés central et en manipulant d'autres ressources.
>Cette possibilité n'est prise en charge que sous Android, iOS, Windows 8 (modules Windows Store uniquement) ou Windows Phone 8.


Pour personnaliser les fonctionnalités : plusieurs fonctionnalités sont contrôlées par un fichier de propriétés central appelé **config.json** dans le répertoire **IBMAppCenter/apps/AppCenter/common/js/appcenter/** ou **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter**. Si vous souhaitez modifier le comportement des applications par défaut, vous pouvez adapter ce fichier de propriétés avant de générer le projet.

Ce fichier contient les propriétés indiquées dans le tableau suivant.

| Propriété | Description |
|----------|-------------|
| url | Adresse du serveur Application Center codée en dur. Si cette propriété est définie, les zones d'adresse de la vue Login ne sont pas affichées. |
| defaultPort | Si la propriété url est NULL, cette propriété pré-remplit la zone Port de la vue Login sur un téléphone. Il s'agit d'une valeur par défaut ; la zone peut être modifiée par l'utilisateur. |
| defaultContext | Si la propriété url est NULL, cette propriété pré-remplit la zone Context de la vue Login sur un téléphone. Il s'agit d'une valeur par défaut ; la zone peut être modifiée par l'utilisateur. |
| ssl | Valeur par défaut du commutateur SSL de la vue Login. |
| allowDowngrade | Cette propriété indique si l'installation de versions antérieures est autorisée ou non ; une version plus ancienne ne peut être installée que si le système d'exploitation et la version permettent la rétromigration. |
| showPreviousVersions | Cette propriété indique si l'utilisateur de l'appareil peut afficher les détails de toutes les versions d'applications ou uniquement les détails de la dernière version. |
| showInternalVersion | Cette propriété indique si la version interne est affichée ou non. Si la valeur est false, la version interne est affichée uniquement si aucune version commerciale n'est définie. |
| listItemRenderer | Cette propriété peut avoir l'une des valeurs suivantes : <br/>- **full** : la valeur par défaut ; les listes d'application indiquent le nom de l'application, l'évaluation et la dernière version.<br/>- **simple** : les listes d'application ne montrent que le nom de l'application. |
| listAverageRating | Cette propriété peut avoir l'une des valeurs suivantes : <br/>- **latestVersion** : les listes d'application indiquent l'évaluation moyenne de la dernière version de l'application.<br/>- **allVersions** : les listes d'application indiquent l'évaluation moyenne de toutes les versions de l'application. |
| requestTimeout | Cette propriété indique le délai d'attente en millisecondes pour les demandes adressées au serveur Application Center. |
| gcmProjectId | ID du projet de l'API Google (nom du projet = com.ibm.appcenter), requis pour les notifications push d'Android ; par exemple, 123456789012. |
| allowAppLinkReview | Cette propriété indique si les revues locales des applications provenant de magasins d'applications externes peuvent être enregistrées et consultées dans Application Center. Ces revues locales ne sont pas visibles dans le magasin d'applications externe. Ces revues sont stockées dans le serveur Application Center. |

### Autres ressources
{: #other-resources }
Les autres ressources disponibles sont les icônes d'application, le nom de l'application, les images d'écran d'accueil, les icônes et les ressources traduisibles de l'application.

#### Icônes d'application
{: #application-icons }
* **Android :** fichier nommé **icon.png** dans les répertoires **/res/drawabledensity** du projet Android Studio ; il existe un répertoire pour chaque densité.
* **iOS :** fichiers nommés **iconsize.png** dans le répertoire **Resources** du projet Xcode.
* **Windows Phone :** fichiers nommés **ApplicationIcon.png**, **IconicTileSmallIcon.png** et **IconicTileMediumIcon.png** dans le répertoire **native** du dossier d'environnement de MobileFirst Studio pour Windows Phone.
* **Windows 10 Universal :** fichiers **Square\*Logo\*.png**, **StoreLogo.png** et **Wide\*Logo\*.png** in the **IBMAppCenterUWP/Assets** directory in Visual Studio.


#### Nom de l'application
{: #application-name }
* **Android :** éditez la propriété **app_name** dans le fichier **res/values/strings.xml** du projet Android Studio.
* **iOS :** éditez la clé **CFBundleDisplayName** dans le fichier **IBMAppCenterAppCenterIphone-Info.plist** du projet Xcode.
* **Windows Phone :** éditez l'attribut **Title** de l'entrée App dans le fichier **Properties/WMAppManifest.xml** de Visual Studio.
* **Windows 10 Universal :** modifiez l'attribut **Title** de l'entrée App dans le fichier **IBMAppCenterUWP/Package.appxmanifest** de Visual Studio.


#### Images d'écran d'accueil
{: #splash-screen-images }
* **Android :** éditez le fichier nommé **splashimage.9.png** dans les répertoires **res/drawable/density** du projet Android Studio ; il existe un répertoire pour chaque densité. Ce fichier est une image de correctif 9.
* **iOS :** fichiers nommés **Default-size.png** dans le répertoire **Resources** du projet Xcode.
* Ecran d'accueil des projets basés sur Cordova/MobileFirst Studio pendant la connexion automatique : **js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone :** éditez le fichier nommé **SplashScreenImage.png** dans le répertoire **native** du dossier d'environnement de MobileFirst Studio pour Windows Phone.
* **Windows 10 Universal :** modifiez les fichiers **SplashScreen*.png** dans le répertoire **IBMAppCenterUWP/Assets** dans Visual Studio.

#### Icônes (boutons, étoiles et objets similaires) de l'application
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**.

#### Ressources traduisibles de l'application
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**.

## Déploiement du client mobile dans Application Center
{: #deploying-the-mobile-client }
Déployez les différentes versions de l'application client dans Application Center.

Le client mobile Windows 8 n'est pas destiné à être déployé dans Application Center pour une distribution ultérieure. Vous pouvez choisir de distribuer le client mobile Windows 8 en fournissant aux utilisateurs le fichier exécutable .exe du client et les fichiers .dll de la bibliothèque de liens dynamiques directement intégrés dans une archive ou en créant un programme d'installation exécutable pour le client mobile Windows 8.

Les versions Android, iOS, Windows Phone et Windows 10 Universal (Phone) du client mobile doivent être déployées dans Application Center. A cet effet, vous devez transférer les fichiers de module d'application Android (.apk), les fichiers d'application iOS (.ipa), les fichiers d'application Windows Phone (.xap), les fichiers Windows 10 Universal (.appx) ou les fichiers archive de répertoire web (.zip) dans Application Center.

Suivez la procédure décrite dans [Ajout d'une application mobile](../appcenter-console/#adding-a-mobile-application) pour ajouter l'application de client mobile pour Android, iOS, Windows Phone et Windows 10 Universal. Veillez à sélectionner la propriété d'application Installer pour indiquer que l'application est un programme d'installation. La sélection de cette propriété permet aux utilisateurs d'appareils mobiles d'installer facilement l'application de client mobile. Pour installer le client mobile, reportez-vous à la tâche associée correspondant à la version de l'application de client mobile déterminée par le système d'exploitation.
