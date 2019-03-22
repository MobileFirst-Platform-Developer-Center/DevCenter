---
layout: tutorial
title: Nouveautés des mises à jour en distribution continue
breadcrumb_title: CD Updates
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Les correctifs temporaires et les mises à jour en distribution continue fournissent des modules de correction et de mises à jour permettant de corriger des problèmes et de maintenir {{ site.data.keys.product_full }} à jour pour les nouvelles éditions des systèmes d'exploitation mobiles. Les mises à jour en distribution continue améliorent aussi les fonctionnalités du produit en y introduisant de nouvelles fonctions.

Les correctifs temporaires et les mises à jour en distribution continue sont cumulatifs. Lorsque vous téléchargez le dernier correctif temporaire ou la dernière mise à jour en distribution continue de la version 8.0, vous obtenez l'ensemble des correctifs et des fonctions contenus dans les correctifs temporaires et les mises à jour en distribution continue précédents.

Téléchargez et installez la dernière mise à jour en distribution continue pour obtenir toutes les fonctions décrites dans les sections qui suivent.

> Pour obtenir la liste des éditions de correctif temporaire de {{ site.data.keys.product }} 8.0, [cliquez ici]({{site.baseurl}}/blog/tag/iFix_8.0/).

### Fonctions incluses avec la mise à jour en distribution continue 4 (8.0.0.0-MFPF-IF201812191602-CDUpdate-04)

##### <span style="color:NAVY">**Prise en charge de HTTP/2 pour les notifications push APNs**</span>

Les notifications push dans MobileFirst prennent maintenant en charge les notifications push APNs HTTP/2 avec les notifications via des sockets TCP existantes. [En savoir plus]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/sending-notifications/#http2-support-for-apns-push-notifications).

##### <span style="color:NAVY">**Logiciel SDK push React Native publié**</span>

Le logiciel SDK React Native pour les notifications push (*react-native-ibm-mobilefirst-push 1.0.0*) est livré avec cette mise à jour en distribution continue.


### Fonctions introduites par la mise à jour en distribution continue 3 (8.0.0.0-MFPF-IF201811050432-CDUpdate-03)

##### <span style="color:NAVY">**Prise en charge des jetons d'actualisation sur iOS**</span>

Mobile Foundation introduit la fonction de jeton d'actualisation sur iOS à partir de cette mise à jour en distribution continue. [En savoir plus]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Téléchargement de l'interface de ligne de commande d'administration (*mfpadm*) depuis la console Mobile Foundation**</span>

Vous pouvez maintenant télécharger l'interface de ligne de commande d'administration de Mobile Foundation (*mfpadm*) depuis le *centre de téléchargement* de la console Mobile Foundation.

##### <span style="color:NAVY">**Prise en charge de Node v8.x pour l'interface de ligne de commande MobileFirst**</span>

A partir de ce correctif temporaire (*8.0.0.0-MFPF-IF201810040631*), Mobile Foundation prend en charge Node v8.x pour l'interface de ligne de commande MobileFirst.

##### <span style="color:NAVY">**Retrait de la dépendance à *libstdc++* pour les projets Cordova**</span>

A partir de ce correctif temporaire (*8.0.0.0-MFPF-IF201809041150*), une modification visant à retirer *libstdc++* en tant que dépendance aux projets Cordova a été introduite. Ceci est obligatoire pour les nouvelles applications exécutées sur ios 12. Pour plus de détails, par exemple pour connaître une solution palliative, consultez [cet article de blogue](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/).

### Fonctions introduites par la mise à jour en distribution continue 2 (8.0.0.0-MFPF-IF201807180449-CDUpdate-02)

##### <span style="color:NAVY">**Prise en charge du développement React Native**</span>

A partir de la mise à jour en distribution continue (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), Mobile Foundation [annonce]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/) la prise en charge du développement React Native avec la disponibilité du SDK IBM Mobile Foundation pour les applications React Native. [En savoir plus]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).

##### <span style="color:NAVY">**Synchronisation automatisée des collections JSONStore avec les bases de données CouchDB pour les SDK iOS et Cordova**</span>

A partir de la mise à jour en distribution continue (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), les SDK iOS et Cordova de MobileFirst vous permettent d'automatiser la synchronisation des données entre une collection JSONStore sur un appareil et n'importe quel type de base de données CouchDB, y compris [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). Pour plus d'informations sur cette fonction, lisez cet [article de blogue]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/).

##### <span style="color:NAVY">**Présentation des jetons d'actualisation**</span>

A partir de la mise à jour en distribution continue (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), Mobile Foundation introduit des jetons spéciaux appelés jetons d'actualisation qui peuvent être utilisés pour demander un nouveau jeton d'accès.  [En savoir plus]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Prise en charge de Cordova version 8 et Cordova Android version 7**</span>

A partir de ce correctif temporaire (*8.0.0.0-MFPF-IF201804051553*), les plug-in MobileFirst Cordova pour Cordova version 8 et Cordova Android version 7 sont prise en charge. Pour utiliser la version mentionnée de Cordova, vous devez obtenir les plug-in MobileFirst les plus récents et effectuer une mise à niveau vers la version la plus récente de l'interface de ligne de commande (mfpdev-cli). Pour plus de détails sur les versions prises en charge pour chaque plateforme, voir [Adding the MobileFirst Foundation SDK to Cordova Applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Synchronisation automatisée des collections JSONStore avec des bases de données CouchDB**</span>

A partir de ce correctif temporaire (*8.0.0.0-MFPF-IF201802201451*), le SDK Android de MobileFirst vous permet d'automatiser la synchronisation des données entre une collection JSONStore d'un appareil et n'importe quel type de base de données CouchDB, y compris [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). Pour plus d'informations sur cette fonction, lisez cet [article de blogue]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).

### Fonctions introduites par la mise à jour en distribution continue 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01)

##### <span style="color:NAVY">**Prise en charge de l'éditeur d'interface utilisateur Eclipse**</span>

A partir de la mise à jour en distribution continue *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, l'éditeur WYSIWYG est fourni dans l'environnement Eclipse de MobileFirst Studio. Les développeurs peuvent concevoir et implémenter l'interface utilisateur de leurs applications Cordova grâce à cet éditeur d'interface utilisateur. [En savoir plus](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**Nouveaux adaptateurs pour la génération d'applications cognitives**</span>

A partir de la mise à jour en distribution continue *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation introduit deux nouveaux adaptateurs de service cognitif préconfigurés pour les services [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) et [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator). Ces adaptateurs sont disponibles pour le téléchargement et le déploiement depuis le *Centre de téléchargement* de la console Mobile Foundation.

##### <span style="color:NAVY">**Authenticité de l'application dynamique**</span>

A partir du correctif temporaire *8.0.0.0-MFPF-IF20170220-1900*, une nouvelle implémentation de l'*authenticité de l'application* est fournie. Cette implémentation ne requiert pas l'outil hors ligne *mfp-app-authenticity* pour la génération du fichier *.authenticity_data*. Au lieu de cela, vous pouvez activer ou désactiver l'*authenticité de l'application* depuis la console MobileFirst. Pour plus d'informations, voir [Configuring Application Authenticity](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity).

##### <span style="color:NAVY">**Prise en charge d'Application Center (client et serveur) pour Windows 10**</span>

A partir du correctif temporaire *8.0.0.0-MFPF-IF20170327-1055*, les applications Windows 10 UWP sont prises en charge dans IBM Application Center. L'utilisateur peut désormais télécharger des applications Windows 10 UWP et les installer sur son appareil. Le projet du client Windows 10 UWP pour l'installation de l'application UWP est désormais fourni avec l'Application Center. Vous pouvez ouvrir le projet dans Visual Studio et créer un binaire (par exemple, *.appx*) pour la distribution. Application Center ne fournit pas de méthode prédéfinie pour distribuer le client mobile. Pour plus d'informations, voir [Microsoft Windows 10 Universal (Native) IBM AppCenter client](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

##### <span style="color:NAVY">**Prise en charge du plug-in MobileFirst Eclipse pour Eclipse Neon**</span>

A partir du correctif temporaire *8.0.0.0-MFPF-IF20170426-1210*, le plug-in MobileFirst Eclipse est mis à jour pour prendre en charge Eclipse Neon.

##### <span style="color:NAVY">**Modification du SDK Android qui utilise une version plus récente d'OkHttp (version 3.4.1)**</span>

A partir du correctif temporaire *8.0.0.0-MFPF-IF20170605-2216*, le SDK Android a été modifié et utilise une version plus récente d'*OkHttp (version 3.4.1)* au lieu de l'ancienne version précédemment fournie avec le SDK MobileFirst pour Android. OkHttp est ajouté en tant que dépendance plutôt que d'être intégré au SDK. Cela permet davantage de liberté lors du choix de l'utilisation de la bibliothèque OkHttp pour les développeurs et permet également d'éviter les conflits entre plusieurs versions d'OkHttp.

##### <span style="color:NAVY">**Prise en charge de Cordova version 7**</span>

A partir du correctif temporaire *8.0.0.0-MFPF-IF20170608-0406*, Cordova version 7 est pris en charge. Pour plus de détails sur les versions prises en charge sur chaque plateforme, voir [Adding the MobileFirst Foundation SDK to Cordova Applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

##### <span style="color:NAVY">**Prise en charge de l'épinglage de plusieurs certificats**</span>

A partir du correctif temporaire (*8.0.0.0-MFPF-IF20170624-0159*), Mobile Foundation prend en charge l'épinglage de plusieurs certificats. Avant ce correctif temporaire, Mobile Foundation prenait en charge l'épinglage d'un seul certificat. Mobile Foundation a introduit une nouvelle API, qui autorise la connexion vers plusieurs hôtes en permettant à l'utilisateur d'épingler des clés publiques de plusieurs certificats X509 à l'application client. Cette fonction est prise en charge uniquement pour les applications Android et iOS natives. Pour en savoir plus sur la *prise en charge de l'épinglage de plusieurs certificats*, reportez-vous à la rubrique [Nouveautés](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), sous la section *Nouveautés en matière d'API MobileFirst*.

##### <span style="color:NAVY">**Adaptateurs pour la création d'une application cognitive**</span>

A partir du correctif temporaire (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation introduit des adaptateurs préconfigurés pour les services cognitifs Watson, tels que [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter) et [*WatsonNLU (Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter). Ces adaptateurs sont disponibles pour le téléchargement et le déploiement depuis le *Centre de téléchargement* de la console Mobile Foundation.

##### <span style="color:NAVY">**Adaptateur Cloud Functions pour la création d'une application sans serveur**</span>

A partir du correctif temporaire (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation introduit un adaptateur préconfiguré nommé [*adaptateur Cloud Functions*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter) pour la [plateforme Cloud Functions](https://console.bluemix.net/openwhisk/). L'adaptateur est disponible pour le téléchargement et le déploiement depuis le *Centre de téléchargement* de la console Mobile Foundation.

##### <span style="color:NAVY">**Prise en charge de l'épinglage de plusieurs certificats dans le SDK Cordova**</span>

A partir de ce correctif temporaire (*8.0.0.0-MFPF-IF20170803-1112*), l'épinglage de plusieurs certificats est pris en charge dans le SDK Cordova. Pour en savoir plus sur la *prise en charge de l'épinglage de plusieurs certificats*, reportez-vous à la rubrique [Nouveautés](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), sous la section *Nouveautés en matière d'API MobileFirst*.

##### <span style="color:NAVY">**Prise en charge de la plateforme de navigateur Cordova**</span>

A partir du correctif temporaire (*8.0.0.0-MFPF-IF20170823-1236*), {{ site.data.keys.product }} prend en charge la plateforme de navigateur Cordova ainsi que les plateformes précédentes prises en charge sur Cordova Windows, Cordova Android et Cordova iOS. [En savoir plus](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**Génération d'un adaptateur à partir de sa spécification OpenAPI**</span>

A partir du correctif temporaire (*8.0.0.0-MFPF-IF20170901-1903*), {{ site.data.keys.product }} introduit la fonctionnalité de génération automatique d'un adaptateur à partir de sa spécification OpenAPI. Les utilisateurs {{ site.data.keys.product }} peuvent maintenant se concentrer sur la logique d'application au lieu de créer l'adaptateur {{ site.data.keys.product }}, qui connecte l'application au service de back end souhaité. [En savoir plus]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**Prise en charge de l'iOS 11 et de l'iPhone X**</span>

A partir de la mise à jour en distribution continue *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation annonce la prise en charge de l'iOS 11 et de l'iPhone X sur Mobile Foundation version 8.0. Pour plus de détails, lisez l'article de blogue [IBM MobileFirst Platform Foundation Support for iOS 11 and iPhone X](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/).

##### **<span style="color:NAVY">Prise en charge d'Android Oreo</span>**

A partir de la mise à jour en distribution continue *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation annonce la prise en charge d'Android Oreo dans cet [article de blogue](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/). Les applications Android natives et les applications hybrides/Cordova, générées à partir de versions anciennes d'Android, fonctionnent comme prévu sur Android Oreo lorsque l'appareil est mis à niveau via un OTA.

##### <span style="color:NAVY">**Possibilité de déploiement de Mobile Foundation sur les clusters Kubernetes**</span>

A partir de la mise à jour en distribution continue *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, les utilisateurs de Mobile Foundation peuvent déployer Mobile Foundation, qui inclut le serveur Mobile Foundation, le serveur Mobile Analytics et Application Center, sur des clusters Kubernetes. Le package de déploiement a été mis à jour pour prendre en charge le déploiement Kubernetes. Lisez l'[annonce](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/).
