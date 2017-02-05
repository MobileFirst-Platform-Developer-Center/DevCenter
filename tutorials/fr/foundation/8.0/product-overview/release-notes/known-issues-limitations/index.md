---
layout: tutorial
title: Problèmes et limitations connus
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Problèmes connus
{: #known-issues }
Cliquez sur le lien suivant pour recevoir une liste de documents générés dynamiquement pour cette édition spécifique et tous ses groupes de correctifs, y compris les problèmes connus et les résolutions correspondantes, ainsi que les téléchargements appropriés : [http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0).

## Limitations connues
{: #known-limitations }
Cette documentation décrit les limitations connues d'{{site.data.keys.product_full }} à différents emplacements :

* Lorsque la limitation connue s'applique à une fonction spécifique, elle est explicitée dans la rubrique qui décrit la fonction. Vous pouvez alors savoir immédiatement comment elle affecte la fonction.
* Lorsque la limitation connue est générale, c'est-à-dire qu'elle s'applique à des éléments différents et éventuellement non directement liés, sa description est fournie ici.

### Globalisation
{: #globalization }
Si vous développez des applications globalisées, les restrictions sont les suivantes :

* Traduction partielle : une partie du produit {{site.data.keys.product }} v8.0, y compris sa documentation, est traduite dans les langues suivantes : chinois simplifié, chinois traditionnel, français, allemand, italien, japonais, coréen, portugais (Brésil), russe et espagnol. Le texte destiné aux utilisateurs est traduit.
* Support bidirectionnel : Les applications qui sont générées par {{site.data.keys.product }} ne
sont
pas entièrement prises en charge dans les langues bidirectionnelles. La mise en miroir des éléments d'interface graphique et le contrôle de la
direction du texte ne sont pas mis à disposition par défaut. Cependant, aucune dépendance stricte n'existe dans les applications générées sur cette limitation. Les développeurs peuvent définir la compatibilité pour les langues bidirectionnelles en procédant à des ajustements manuels dans le code généré.

Bien que la traduction en hébreu existe pour la fonctionnalité de base d'{{site.data.keys.product }}, certains éléments de l'interface graphique
ne sont pas mis en miroir.

* Contraintes sur les noms d'adaptateur : les noms des adaptateurs doivent être des noms valides pour créer un nom de classe Java. En outre, ils doivent être composés uniquement des caractères suivants :
    * Lettres majuscules et minuscules (A à Z et a à z)
    * Chiffres (0 à 9)
    * Trait de soulignement (_)

* Caractères Unicode : les caractères Unicode en dehors du plan multilingue de base ne sont pas pris en charge.
* Caractéristiques de langue et formulaire de normalisation C (NFC) : dans les cas d'utilisation suivants, les requêtes ne tiennent pas compte des caractéristiques de
langue telles que l'insensibilité à l'accentuation, l'insensibilité à la casse et le mappage de 1 vers 2 pour que la fonction de recherche s'exécute correctement dans différentes langues, et la recherche sur des données n'utilise pas le formulaire de normalisation C (NFC).
    * Dans {{site.data.keys.mf_analytics_console }},
lorsque vous créez un filtre personnalisé pour un graphique personnalisé. Cependant, dans cette console, la propriété de message utilise le formulaire de normalisation C (NFC) et tient compte de la sensibilité de la langue.
    * A partir de la console {{site.data.keys.mf_console }}, lorsque vous recherchez une application sur la page de survol des applications, un adaptateur sur la page de survol des adaptateurs, une balise sur la page Push ou un terminal sur la page des terminaux.
    * Dans les fonctions de recherche pour l'API JSONStore.

### {{site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{site.data.keys.mf_analytics }} est soumis aux limitations suivantes :

* L'analyse de sécurité (les contrôles de sécurité sur les données des demandes échouent) n'est pas prise en charge.
* Dans {{site.data.keys.mf_analytics_console }}, le format des nombres ne suit pas les règles des composants internationaux pour le jeu de caractères Unicode.
* Dans {{site.data.keys.mf_analytics_console }}, les nombres n'utilisent pas le script de nombre préféré de l'utilisateur.
* Dans {{site.data.keys.mf_analytics_console }}, le format des dates, heures et nombres est affiché en fonction du paramètre linguistique du système d'exploitation et non en fonction de l'environnement local de Microsoft Internet Explorer.
* Lorsque vous créez un filtre personnalisé pour un graphique personnalisé, les données numériques doivent être en base 10 et il doit s'agir de chiffres occidentaux ou européens, comme 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
* Lorsque vous créez une alerte sur la page Gestion des alertes de la console {{site.data.keys.mf_analytics_console }}, les données numériques doivent être en base 10 et il doit s'agir de chiffres occidentaux ou européens, comme 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
* La page Analyse de la console {{site.data.keys.mf_console }} prend en charge les navigateurs suivants :
    * Microsoft Internet Explorer version 10 ou ultérieure
    * Mozilla Firefox ESR ou version ultérieure
    * Apple Safari sur iOS version 7.0 ou ultérieure
    * Dernière version de Google Chrome
* Le SDK client d'analyse, Analytics, n'est pas disponible pour Windows.


### Client mobile {{site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
Le client mobile d'Application Center suit les conventions culturelles du terminal en cours d'exécution, tel le formatage des dates. Il ne suit pas toujours strictement les règles Unicode applicables aux caractères internationaux.

### {{site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
{{site.data.keys.mf_console }} est soumis aux limitations suivantes :

* Fournit un support partiel pour les langues bidirectionnelles.
* La direction du texte ne peut pas être modifiée lorsque les messages de notification sont envoyés à un appareil Android :
    * Si les premières lettres sont tapées dans une langue de droite à gauche, comme l'arabe et l'hébreu, toute la direction du texte est automatiquement de droite à gauche.
    * Si les premières lettres tapées sont dans une langue de gauche à droite, toute la direction du texte est automatiquement de gauche à droite.
* La séquence de caractères et l'alignement du texte ne correspondent pas au mode culturel de la langue bidirectionnelle.
* Les zones numériques n'analysent pas les valeurs numériques selon les règles de formatage des paramètres régionaux. La console affiche les nombres formatés, mais accepte en entrée uniquement des nombres *bruts* (non formatés). Par exemple : 1000, et non 1 000 ou 1,000.
* Les temps de réponse sur la page Analyse de la console {{site.data.keys.mf_console }} dépendent de plusieurs facteurs, tels que le
matériel (mémoire vive, unités centrales), la quantité de données d'analyse accumulée et la mise en cluster de {{site.data.keys.mf_analytics }}. Envisagez de tester la charge de travail avant d'intégrer
{{site.data.keys.mf_analytics }} à la production.

### Outil de configuration du serveur
{: #server-configuration-tool }
L'outil de configuration de serveur comporte les restrictions suivantes :

* Le nom descriptif d'une configuration de serveur ne peut contenir que des caractères appartenant au jeu de caractères du système. Sous Windows, il s'agit d'un jeu de caractères ANSI.
* Les mots de passe qui contiennent des guillemets simples ou doubles peuvent ne pas fonctionner correctement.
* La console de l'outil de configuration du serveur présente la même limitation de globalisation que la console Windows en matière d'affichage des chaînes non comprises dans la page de codes par défaut.

Vous pouvez également observer les restrictions ou des anomalies dans divers aspects de l'internationalisation en raison de limitations d'autres produits, tels que les navigateurs, les systèmes de gestion de base de données ou les kits de développement de logiciels utilisés. Exemple :

* Vous devez définir le nom d'utilisateur et le mot de passe d'Application Center uniquement avec des caractères ASCII. Cette limitation existe car WebSphere Application Server (profils complets ou Liberty) ne prend pas en charge les mots de passe et les noms d'utilisateur non ASCII. Voir la rubrique Caractères qui ne sont pas valides pour les ID utilisateur et les mots de passe.
* Sous Windows :
    * Pour afficher les messages localisés dans le fichier journal que le serveur de test crée, vous devez ouvrir ce fichier journal
avec le codage UTF8.
    * Les raisons de ces limitations sont les suivantes :
        * Le serveur de test est installé sur le profil WebSphere Application Server Liberty, qui crée un fichier journal avec le codage ANSI sauf pour ses messages localisés pour lesquels il utilise le codage UTF8.

* Dans Java 7.0 Service Refresh 4-FP2 et les versions précédentes, vous ne pouvez pas coller de caractères Unicode qui ne font pas partie du plan multilingue de base dans la zone d'entrée. Pour éviter ce problème, créez le dossier de chemin manuellement et choisissez ce dossier au cours de l'installation.
* Les noms personnalisés des boutons et des titres pour les méthodes d'alerte, de confirmation et d'invite doivent être courts afin d'éviter toute
troncature à l'écran.
* JSONStore ne traite pas la normalisation. Les fonctions de recherche pour l'API JSONStore ne prennent pas en compte les caractéristiques de
langue telles que l'insensibilité à l'accentuation, l'insensibilité à la casse et le mappage de 1 vers 2.

### Adaptateurs et dépendances à des tiers
{: #adapters-and-third-party-dependencies }
Les problèmes connus suivants concernent les interactions entre les dépendances et les classes dans le serveur d'applications, y compris la bibliothèque partagée {{site.data.keys.product_adj }}.

#### Apache HttpClient
{: #apache-httpclient }
{{site.data.keys.product }} utilise
Apache HttpClient en interne. Si vous ajoutez une instance Apache HttpClient en tant que dépendance à un adaptateur Java, les API suivantes ne fonctionnent pas correctement dans l'adaptateur : `AdaptersAPI.executeAdapterRequest, AdaptersAPI.getResponseAsJSON` et `AdaptersAPI.createJavascriptAdapterRequest`. La raison est que les API contiennent des types Apache HttpClient dans leur signature. La solution de contournement consiste à utiliser l'instance Apache HttpClient interne et à modifier la portée de la dépendance dans le fichier **pom.xml** fourni.

#### Bibliothèque cryptographique Bouncy Castle
{: #bouncy-castle-cryptographic-library }
{{site.data.keys.product }} utilise
Bouncy Castle même. Il peut être possible d'utiliser une autre version de Bouncy Castle dans l'adaptateur, mais les conséquences doivent être soigneusement testées : parfois, le code {{site.data.keys.product_adj }} Bouncy
Castle remplit certaines zones Singleton statiques des classes de package `javax.security` et peut empêcher la version de Bouncy Castle qui se trouve dans un adaptateur d'utiliser des fonctionnalités qui dépendent de ces zones.

#### Implémentation Apache CXF des fichiers JAR
{: #apache-cxf-implementaton-of-jar-files }
CXF est utilisé dans l'implémentation JAX-RS de {{site.data.keys.product_adj }}, vous empêchant ainsi d'ajouter des fichiers JAR Apache CXF à un adaptateur.

### Client mobile d'Application Center : problèmes d'actualisation sur Android 4.0.x
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Le composant WebView d'Android 4.0.x présente plusieurs problèmes d'actualisation connus. La mise à jour des terminaux vers Android 4.1.x offre de meilleures performances aux utilisateurs.

Si vous générez le client Application Center à partir de sources, la désactivation de l'accélération matérielle au niveau de l'application dans le manifeste Android devrait permettre d'améliorer la situation pour Android 4.0.x. Dans ce cas, l'application doit être générée avec le kit de développement de logiciels Android
version 11 ou ultérieure.

### Application Center requiert MobileFirst Studio V7.1 pour l'importation et la génération du client mobile Application Center
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Pour générer le client mobile Application Center, vous avez besoin de MobileFirst Studio V7.1. Vous pouvez télécharger MobileFirst Studio depuis la page [Downloads]({{site.baseurl}}/downloads). Cliquez sur l'onglet **Editions précédentes de MobileFirst Platform Foundation** pour le lien de téléchargement. Pour obtenir des instructions d'installation, voir [Installing MobileFirst Studio in the IBM  Knowledge Center for 7.1](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html). Pour plus d'informations sur la génération du client mobile Application Center, voir [Préparations liées à l'utilisation du client mobile](../../../appcenter/preparations).

### Application Center et Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Application Center prend en charge la distribution d'applications telles que les fichiers de package d'application Windows Phone (.xap) pour Microsoft Windows Phone 8.0 et Microsoft Windows Phone 8.1. Avec Microsoft Windows Phone 8.1, Microsoft a introduit un nouveau format universel de fichiers de package d'application (.appx) pour Windows Phone. Actuellement, Application Center ne prend pas en charge la distribution de fichiers de package d'application (.appx) pour Microsoft Windows Phone 8.1, mais est limité aux fichiers de package d'application Windows Phone (.xap).

Application Center ne prend en charge que la distribution de fichiers de package d'application (.appx) pour Microsoft Windows Store (applications de bureau).

### Administration des applications {{site.data.keys.product_adj }} par des tâches Ant ou par la ligne de commande
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
L'outil **mfpadm**  n'est pas disponible si vous téléchargez et installez seulement {{site.data.keys.mf_dev_kit_full }}. L'outil mfpadm est installé avec{{site.data.keys.mf_server }} à l'aide du programme d'installation.

### Clients confidentiels
{: #confidential-clients }
Utilisez des caractères ASCII uniquement pour les valeurs d'ID et de secret de client confidentiels.

### Mise à jour directe
{: #direct-update }
La mise à jour directe sur Windows n'est pas prise en charge dans V8.0.0.

### Limitations de la fonction FIPS 140-2
{: #fips-104-2-feature-limitations }
Les limitations connues suivantes s'appliquent lorsque vous utilisez la fonction FIPS 140-2
dans {{site.data.keys.product }} :
* Le mode validé FIPS 140-2 ne s'applique qu'à la protection (chiffrement) des données locales qui sont stockées par la fonction JSONStore et à la
protection des communications HTTPS entre le
client {{site.data.keys.product_adj }} et {{site.data.keys.mf_server }}.
    * Pour les communications HTTPS, seules les communications entre le client
{{site.data.keys.product_adj }} et
{{site.data.keys.mf_server }} utilisent les bibliothèques FIPS 140-2 sur
le client. Les connexions directes aux autres serveurs ou services n'utilisent pas de bibliothèques FIPS 140-2.
* Cette fonction n'est prise en charge que sur les plateformes iOS et Android.
    * Sous Android, cette fonction n'est prise en charge que sur des terminaux ou des simulateurs utilisant l'architecture x86 ou armeabi. Elle n'est pas prise en charge sous Android avec une architecture armv5 ou armv6. C'est parce que la bibliothèque OpenSSL utilisée n'a pas obtenu la validation FIPS
140-2 pour armv5 ou armv6 sous Android. La norme FIPS 140-2 n'est pas encore prise en charge dans l'architecture 64 bits, même si la bibliothèque {{site.data.keys.product_adj }} prend en charge l'architecture 64 bits. La norme FIPS 140-2 peut être exécuté sur des appareils 64 bits s'il n'existe que des bibliothèques NDK natives 32 bits dans le projet.
    * Sous iOS, elle est prise en charge dans les architectures i386, x86_64, armv7, armv7s et arm64.
* Cette fonction n'est opérationnelle qu'avec des applications hybrides (non natives).
* Pour l'iOS natif, FIPS est activé à travers les bibliothèques FIPS iOS et est activé par défaut. Aucune action n'est nécessaire pour activer FIPS 140-2.
* L'utilisation de la fonction d'enregistrement utilisateur sur le client n'est pas prise en charge par la fonction FIPS 140-2.
* Le client Application Center ne prend pas en charge la fonction FIPS 140-2.

### Installation d'un groupe de correctifs ou d'un correctif temporaire sur Application Center ou sur le serveur {{site.data.keys.mf_server }}
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Lorsque vous appliquez un groupe de correctifs ou un correctif temporaire sur Application Center ou sur le serveur {{site.data.keys.mf_server }}, des opérations manuelles sont nécessaires et vous pouvez être amené à arrêter vos applications pendant un certain temps.

### Architectures JSONStore prises en charge
{: #jsonstore-supported-architectures }
Pour Android, JSONStore prend en charge les
architectures suivantes : ARM, ARM version 7 et x86 32 bits. Les autres architectures ne sont pas prises en charge actuellement. La tentative
d'utilisation d'autres architectures génère des exceptions et des pannes d'application potentielles.

JSON Store n'est pas pris en charge pour les applications natives Windows.

### Limitations du serveur Liberty
{: #liberty-server-limitations }
Si vous utilisez le serveur Liberty sur un kit JDK 7 32 bits, il se peut qu'Eclipse ne démarre pas et que le message d'erreur suivant s'affiche : "Error occurred during initialization of VM. Could not reserve enough space
for object heap. Error: Could not create the Java Virtual Machine. Error: A fatal exception has occurred. Program will exit."

Pour résoudre ce problème, utilisez le kit JDK 64 bits avec Eclipse 64 bits et Windows 64 bits. Si vous utilisez le kit JDK 32 bits sur un poste 64 bits, vous pouvez configurer les préférences de la machine virtuelle Java **mx512m** et **-Xms216m**.

### Limitations du jeton LTPA
{: #ltpa-token-limitations }
Une exception `SESN0008E`
se produit lorsqu'un jeton LTPA expire avant la session utilisateur.

Le jeton LTPA est
associé à la session utilisateur en cours. Si la session
expire avant le jeton LTPA, une autre est automatiquement créée. A l'inverse, l'exception suivante se produit :

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E : Un utilisateur authentifié en tant qu'anonyme a tenté d'accéder
à une session appartenant à {nom d'utilisateur}`

Pour
résoudre cette limitation, vous devez forcer l'expiration de la session utilisateur
lorsque le jeton LTPA expire.
* Sur WebSphere Application Server Liberty, affectez la valeur true à l'attribut httpSession invalidateOnUnauthorizedSessionRequestException dans le fichier server.xml.
* Sur WebSphere Application Server, ajoutez la propriété personnalisée de gestion de sessions InvalidateOnUnauthorizedSessionRequestException avec la valeur true pour résoudre le problème.

**Remarque :** Sur certaines versions de WebSphere Application Server ou WebSphere Application Server Liberty, l'exception est toujours consignée, mais la session est correctement invalidée. Pour plus d'informations, [voir l'APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141).

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
Pour les environnements Windows Phone 8.1, l'architecture x64 n'est pas prise en charge.

### Applications Microsoft Windows 10 UWP
{: #microsoft-windows-10-uwp-apps }
La fonction d'authenticité d'application ne fonctionne pas sur les applications {{site.data.keys.product_adj }} Windows 10 UWP lorsque le SDK {{site.data.keys.product_adj }} est installé via le package NuGet. Pour contourner ce problème, les développeurs peuvent télécharger le package NuGet et ajouter les références du SDK {{site.data.keys.product_adj }} manuellement.

### Les projets imbriqués peuvent entraîner des résultats imprévisibles avec l'interface CLI
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
N'imbriquez pas les projets les uns dans les autres lors de l'utilisation de {{site.data.keys.mf_cli }}. Sinon, le projet qui est sollicité pourrait ne pas être celui que vous attendez.

### Aperçu des ressources Web Cordova avec
{{site.data.keys.mf_mbs }}
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
Vous pouvez prévisualiser vos ressources Web à l'aide de {{site.data.keys.mf_mbs }}, mais les API JavaScript {{site.data.keys.product_adj }} ne sont pas toutes prises en charge par le simulateur. Le protocole OAuth, notamment, n'est pas entièrement pris en charge. Cependant, vous pouvez tester les appels des adaptateurs avec `WLResourceRequest`.

### Terminal iOS physique requis pour tester l'authenticité d'une application avancée
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
Le test de l'authenticité d'une application avancée nécessite un terminal iOS physique, car une IPA (analyse interprocédurale) ne peut pas être installée sur un simulateur iOS.

### Prise en charge d'Oracle 12c par {{site.data.keys.mf_server }}
{: #support-of-oracle-12c-by-mobilefirst-server }
Les outils d'installation du serveur {{site.data.keys.mf_server }} (gestionnaire d'installation outil de configuration de serveur et tâches Ant) prennent en charge l'installation avec Oracle 12c en tant que base de données.

Les utilisateurs et les tables peuvent être créés à l'aide des outils d'installation. La ou les base(s) de données doivent être créées en amont, c'est-à-dire avant que les outils d'installation soient exécutés.

### Support de notification push
{: #support-for-push-notification }
Le push non sécurisé est pris en charge dans Cordova (sur iOS et Android).

### Mise à jour de la plateforme cordova-ios
{: #updating-cordova-ios-platform }
Pour mettre à jour la plateforme cordova-ios d'une application Cordova, vous devez désinstaller, puis réinstaller la plateforme en procédant comme suit :

1. Accédez au répertoire de projet pour l'application à l'aide de l'interface de ligne de commande.
2. Exécutez la commande `cordova platform rm ios` pour retirer la plateforme.
3. Exécutez la commande `cordova platform add ios@version` pour ajouter la nouvelle plateforme à l'application, où version est la version de la plateforme Cordova iOS.
4. Exécutez la commande `cordova prepare` pour intégrer les modifications.

La mise à jour échoie si vous utilisez la commande `cordova platform update ios`.

### Applications Web
{: #web-applications }
Les applications Web sont soumises aux limitations suivantes :
- {: #web_app_limit_ms_ie_n_edge }
Dans Microsoft Internet Explorer (IE) et Microsoft Edge, des messages d'administration et des messages SDK Web client s'affichent en fonction de la définition des paramètres de région du système d'exploitation et non en fonction des préférences de langue configurées pour le navigateur ou le système d'exploitation. Voir aussi [Définition de messages d'administrateur dans plusieurs langues](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages).

### Support WKWebView pour les applications Cordova iOS
{: #wkwebview-support-for-ios-cordova-applications }
Les fonctions de notification d'applications et de mise à jour directe peuvent ne pas fonctionner correctement dans les applications Cordova iOS avec WKWebView.

Cette limitation est due au défaut file:// url XmlHttpRequests are not allowed in WKWebViewEgine in **cordova-plugin-wkwebview-engine**.

Pour contourner ce problème, exécutez la commande suivante dans votre projet Cordova : `cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`

L'exécution de cette commande entraîne l'exécution d'un serveur Web local dans votre application Cordova et vous pouvez alors héberger et accéder à vos fichiers locaux au lieu d'utiliser le schéma d'URI de fichier (file://) pour gérer les fichiers locaux.

**Remarque :** Ce plug-in Cordova n'est pas publié sur le gestionnaire de package de noeud (npm).

### La barre d'état du plug-in cordova ne fonctionne pas avec l'application Cordova chargée avec cordova-plugin-mfp
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
La barre d'état du plug-in cordova ne fonctionnera pas avec l'application Cordova chargée avec cordova-plugin-mfp.

Pour contourner ce problème, le développeur doit définir `CDVViewController` comme contrôleur de vue racine en remplaçant le fragment de code dans la méthode`wlInitDidCompleteSuccessfully` comme suggéré ci-après dans le fichier **MFPAppdelegate.m** du projet Cordova iOS.

Fragment de code existant :

```objc
(void)wlInitDidCompleteSuccessfully
{ 
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

Fragment de code recommandé avec une solution de contournement pour la limitation :

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### Adresse IPv6 brute non prise en charge dans les applications Android
{: #raw-ipv6-address-not-supported-in-android-applications }
Lors de la configuration de **mfpclient.properties** pour votre application Android native, si votre serveur {{site.data.keys.mf_server }} figure sur un hôte ayant une adresse IPv6, utilisez un nom d'hôte mappé pour l'adresse IPV6 afin de configurer la propriété **wlServerHost** dans **mfpclient.properties**. La configuration de la propriété **wlServerHost** avec une adresse IPv6 brute entraîne l'échec de la tentative de connexion de l'application au serveur {{site.data.keys.mf_server }}.
