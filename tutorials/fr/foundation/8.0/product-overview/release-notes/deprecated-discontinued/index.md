---
layout: tutorial
title: Fonctions et API dépréciées et interrompues
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Examinez attentivement la façon dont les éléments des fonctions et des API supprimées affectent votre environnement {{ site.data.keys.product_full }}.

#### Accéder à
{: #jump-to }
* [Fonctions abandonnées et fonctions qui ne font pas partie de la version 8.0](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [Modifications des API côté serveur](#server-side-api-changes)
* [Modifications des API côté client](#client-side-api-changes)

## Fonctions abandonnées et fonctions absentes de la version 8.0
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }}La version 8.0 a été simplifiée de manière radicale par rapport à la version précédente. En conséquences, certaines fonctions de la version 7.1 ne sont pas suivies dans la version 8.0. Dans la plupart des cas, une autre manière de les implémenter est proposée. Ces fonctions sont signalées comme abandonnées. D'autres fonctions de la version V7.1. n'ont pas été reconduites en version 8.0, sans que cela soit dû au remaniement de celle-ci. Pour les distinguer des fonctions abandonnées à partir de la version 8.0, elles sont signalées comme non disponibles en version 8.0.

<table class="table table-striped">
    <tr>
        <td>Fonction</td>
        <td>Statut et chemin de remplacement</td>
    </tr>
    <tr>
        <td><p>MobileFirst Studio est remplacé par le plug-in {{ site.data.keys.mf_studio }} pour Eclipse.</p></td>
        <td><p>Remplacée par le plug-in {{ site.data.keys.mf_studio }} pour Eclipse. Montée en puissance avec les plug-in de communauté et standard Eclipse. Vous pouvez développer des applications hybrides directement dans l'interface de ligne de commande Apache Cordova ou à l'aide d'un environnement de développement intégré Cordova, par exemple Visual Studio Code, Eclipse ou IntelliJ. Pour davantage d'informations sur l'utilisation d'Eclipse en tant qu'environnement IDE Cordova, voir <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">IBM {{ site.data.keys.mf_studio }} plug-in for managing Cordova projects in Eclipse</a>.</p>

        <p>Vous pouvez développer des adaptateurs avec Apache Maven ou un environnement IDE Maven tel qu'Eclipse, IntelliJ ou autre. Pour plus d'informations sur le développement des adaptateurs, voir la <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">catégorie Adaptateurs</a>. Pour en savoir plus sur l'utilisation d'Eclipse en tant qu'IDE Maven, consultez le <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">tutoriel Developing Adapters in Eclipse</a>.</p>

        <p>Installez {{ site.data.keys.mf_dev_kit_full }} pour tester les adaptateurs et les applications avec {{ site.data.keys.mf_server }}. Vous pouvez également accéder à des outils de développement et des SDK {{ site.data.keys.product_adj }}, si vous ne voulez pas les télécharger à partir des référentiels Internet tels que NPM, Maven, Cocoapod ou NuGet. Pour plus d'informations sur {{ site.data.keys.mf_dev_kit }}, voir <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>.</p>
        </td>
    </tr>
    <tr>
        <td><p>Les habillages, les interpréteurs de commandes Shell, la page Paramètres, la minimisation et les éléments de l'interface utilisateur JavaScript sont abandonnés pour les applications hybrides.</p></td>
        <td><p>Abandonnée. Les applications hybrides sont développées directement avec Apache Cordova. Pour plus d'informations sur le remplacement des habillages, des interpréteurs de commandes Shell, sur la page Setting et sur l'optimisation de taille, voir la rubrique Removed components and Comparison of Cordova apps developed with v8.0 versus v7.1 and before.</p>
        </td>
    </tr>
    <tr>
        <td><p>Sencha Touch ne peut plus être importé dans des projets {{ site.data.keys.product_adj }} pour des applications hybrides.</p></td>
        <td><p>Abandonnée. Les applications hybrides {{ site.data.keys.product_adj }} sont développées directement avec Apache Cordova, et les fonctions de {{ site.data.keys.product_adj }} sont fournies en tant que plug-in Cordova. Consultez la documentation Sencha Touch pour intégrer Sencha Touch et Cordova.</p>
        </td>
    </tr>
    <tr>
        <td><p>Le cache chiffré est abandonné.</p></td>
        <td><p>Abandonnée. Pour stocker des données chiffrées en local, utilisez JSONStore. Pour plus d'informations sur JSONStore, voir le <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">tutoriel JSONStore</a>.</p>
        </td>
    </tr>
    <tr>        
        <td><p>Le déclenchement des mises à jour directes à la demande n'est pas disponible en version 8.0. L'application client contrôle la mise à jour directe lorsqu'elle obtient le jeton OAuth pour une session. Le contrôle par l'application des mises à jour directes à un autre moment n'est pas programmable dans la version 8.0.</p></td>
        <td><p>Non disponible en version 8.0.</p></td>
    </tr>
    <tr>
        <td><p>Adaptateurs avec configuration dépendante des sessions. Dans V7.1.0, vous pouvez configurer {{ site.data.keys.mf_server }} pour fonctionner en mode indépendant de session (par défaut) ou en mode dépendant de session. A partir de la version 8.0, le mode dépendant de session n'est plus pris en charge. Le serveur est intrinsèquement indépendant de la session HTTP, et aucune configuration associée n'est requise.</p></td>
        <td><p>Abandonnée.</p></td>
    </tr>
    <tr>
        <td><p>Le magasin d'attributs sur IBM WebSphere eXtreme Scale n'est pas pris en charge en version 8.0.</p></td>
        <td><p>Non disponible en version 8.0.</p></td>
    </tr>
    <tr>
        <td><p>La reconnaissance de service et la génération d'adaptateur pour les applications de processus IBM Business Process Manager (IBM BPM) , Microsoft Azure Marketplace DataMarket, les API RESTful OData, les ressources RESTful, les services présentés par une passerelle SAP Netweaver Gateway et les services Web ne sont pas disponibles en version 8.0.</p></td>
        <td><p>Non disponible en version 8.0.</p></td>
    </tr>
    <tr>
        <td>L'adaptateur JavaScript JMS n'est pas disponible en version 8.0.</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>L'adaptateur JavaScript SAP Gateway n'est pas disponible en version 8.0.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>L'adaptateur JavaScript SAP JCo n'est pas disponible en version 8.0.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>L'adaptateur JavaScript Cast Iron n'est pas disponible en version 8.0.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Les adaptateurs JavaScript OData et Microsoft Azure OData ne sont pas disponibles en version 8.0.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Le support des notifications push pour USSD n'est pas pris en charge en version 8.0.	</td>
        <td>Abandonnée.</td>
    </tr>
    <tr>
        <td>Les notifications push basée sur les événements ne sont pas prises en charge en version 8.0.	</td>
        <td>Abandonnée. Utilisez le service de notification push. Pour plus d'informations sur la migration vers le service de notification push, voir la rubrique Migration vers les notifications push à partir de notifications basées sur la source d'événement.</td>
    </tr>
    <tr>
      <td>
        Sécurité : Le domaine anti-falsification de requêtes intersites (anti-XSRF) (<code>wl_antiXSRFRealm</code>) n'est pas requis en version 8.0.
      </td>
      <td>
        En version V7.1.0, le contexte d'authentification est stocké dans la session HTTP et identifié par un cookie de session envoyé par le navigateur dans les demandes intersites. Dans cette version, le domaine anti-XSRF sert à protéger la transmission du cookie des attaques XSRF à l'aide d'un en-tête supplémentaire envoyé au serveur par le client.
        <br />
        En version 8.0.0, le contexte de sécurité n'est plus associé à une session HTTP est n'est pas identifié par un cookie de session.
        L'autorisation est obtenue à l'aide d'un jeton d'accès OAuth 2.0 qui est transmis dans l'en-tête Authorization.
        Celui-ci, n'étant pas envoyé par le navigateur dans les demandes intersites, n'a pas besoin d'être protégé des attaques XSRF.
      </td>
    </tr>
    <tr>
        <td>Sécurité : Authentification des certificats d'utilisateur. La version 8.0 ne contient pas de contrôles de sécurité prédéfinis permettant d'authentifier les utilisateurs avec des certificats X.509 côté client.</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Sécurité : Intégration avec IBM Trusteer. La version 8.0 ne contient pas de contrôles de sécurité ni de demande d'authentification prédéfinis permettant de tester les facteurs de risque d'IBM Trusteer.</td>
        <td>Non disponible en version 8.0. Utilisez le SDK IBM Trusteer Mobile.</td>
    </tr>
    <tr>
        <td>Sécurité : Mise à disposition de périphériques et mise à disposition automatique de périphériques.	</td>
        <td><p>Abandonnée.</p><p>Remarque : La mise à disposition de périphériques est gérée dans le flux d'autorisation normal. Les données du périphérique sont automatiquement collectées pendant le processus d'enregistrement du flux de sécurité. Pour plus d'informations sur le flux de sécurité, voir Flux d'autorisation de bout en bout.</p>
        </td>
    </tr>
    <tr>
        <td>Sécurité : Fichier de configuration pour brouiller le code Android avec ProGuard. La version 8.0 ne contient pas le fichier de configuration prédéfini proguard-project.txt destiné au brouillage Android ProGuard avec une application Android MobileFirst.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Sécurité : L'authentification basée sur l'adaptateur est remplacée. L'authentification utilise le protocole OAuth et est implémentée avec des contrôles de sécurité.</td>
        <td>Remplacée par une implémentation basée sur le contrôle de sécurité.</td>
    </tr>
    <tr>
        <td><p>Sécurité : Connexion LDAP. La version 8.0 ne contient pas de contrôles de sécurité prédéfinis permettant d'authentifier les utilisateurs avec un serveur LDAP.</p>
        <p>A la place, pour WebSphere Application Server ou WebSphere Application Server Liberty, utilisez le serveur d'application ou une passerelle pour mapper un fournisseur d'identité tel que LDAP à LTPA et générer un jeton OAuth destiné à l'utilisateur à l'aide d'un contrôle de sécurité LTPA.</p></td>
        <td>Non disponible en version 8.0. Remplacée par un contrôle de sécurité LTPA pour WebSphere Application Server ou WebSphere Application Server Liberty.</td>
    </tr>
    <tr>
        <td>
        Configuration de l'authentification de l'adaptateur HTTP. L'adaptateur HTTP prédéfini ne prend pas en charge la connexion en tant qu'utilisateur à un serveur distant.</td>
        <td><p>Non disponible en version 8.0.</p><p>Modifier le code source de l'adaptateur HTTP et ajoutez le code d'authentification. Utilisez <code>MFP.Server.invokeHttp</code> pour ajouter des jetons d'identification à l'en-tête de la demande HTTP.</p></td>
    </tr>
    <tr>
        <td>
        Security Analytics, le composant permettant de surveiller les événements de l'infrastructure de sécurité MobileFirst à l'aide de MobileFirst Analytics Console n'est pas disponible en version v8.0.</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Le modèle basé sur la source d'événement pour les notifications push est abandonné et remplacé par le modèle de service push basé sur les étiquettes.</td>
        <td>Abandonnée et remplacée par le modèle de service push basé sur les étiquettes.</td>
    </tr>
    <tr>
        <td>La prise en charge de USSD (Unstructured Supplementary Service Data) n'est pas disponible en version 8.0.</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Cloudant utilisé comme base de données pour {{ site.data.keys.mf_server }} n'est pas pris en charge en version 8.0.	</td>
        <td>Non disponible en version 8.0.</td>
    </tr>
    <tr>
        <td>Géolocalisation : la prise en charge de la géolocalisation n'est plus disponible dans {{ site.data.keys.product }} v8.0. L'API REST pour les alarmes et les médiateurs est abandonnée. Les API côté client et côté serveur WL.Geo et WL.Device sont abandonnées.	</td>
        <td>Abandonnée. Utilisez l'API de périphérique natif ou les plug-in Cordova tiers pour la géolocalisation.</td>
    </tr>
    <tr>
        <td>La fonction {{ site.data.keys.product_adj }} Data
Proxy est abandonnée. Les API Cloudant IMFData et CloudantToolkit sont également abandonnées.	</td>
        <td>Abandonnée. Pour plus d'informations sur le remplacement des API IMFData et CloudantToolkit dans vos applications, voir la rubrique Migration d'applications qui stockent des données mobiles dans Cloudant à l'aide du kit de développement de logiciels IMFData ou Cloudant.</td>
    </tr>
    <tr>
        <td>Le kit de développement de logiciels IBM Tealeaf n'est plus intégré à {{ site.data.keys.product }}.	</td>
        <td>Abandonnée. Utilisez le kit de développement de logiciels IBM Tealeaf. Pour plus d'informations, voir <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a> et <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a> dans la documentation IBM Tealeaf Customer Experience.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_test_workbench_full }} n'est pas intégré à {{ site.data.keys.product }}</td>
        <td>Abandonnée.</td>
    </tr>
    <tr>
        <td>BlackBerry, Adobe AIR et Windows Silverlight ne sont pas pris en charge par {{ site.data.keys.product }} v8.0. Aucun SDK n'est fourni pour ces plateformes.	</td>
        <td>Abandonnée.</td>
    </tr>
</table>

## Modifications des API côté serveur
{: #server-side-api-changes }
Pour faire migrer le côté serveur de votre application {{ site.data.keys.product_adj }}, tenez compte des modifications apportées aux API.  
Les tableaux suivants montrent les éléments des API côté serveur abandonnés en version 8.0, les éléments obsolètes des mêmes API et les chemins de migration proposés. Pour plus d'informations sur la migration du côté serveur de votre application,

### Eléments des API JavaScript abandonnés en version 8.0
{: #javascript-api-elements-discontinued-v-v-80 }
#### Sécurité
{: #security }

| Elément d'API                         | Chemin de remplacement                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUser`, `WL.Server.getCurrentUserIdentity`,  `WL.Server.getCurrentDeviceIdentity`, `WL.Server.setActiveUser`, `WL.Server.getClientId`, `WL.Server.getClientDeviceContext`, `WL.Server.setApplicationContext` | Utilisez `MFP.Server.getAuthenticatedUser` à la place. |

#### Source d'événement
{: #event-source }

| Elément d'API                         | Chemin de remplacement                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | Utilisez `MFP.Server.getAuthenticatedUser` à la place. |
| `WL.Server.setEventHandlers`         | Pour effectuer une migration des notifications d'événement basées sur la source aux notifications basées sur l'étiquette, voir Migration vers les notifications push à partir de notifications basées sur la source d'événement.                                                     |
| `WL.Server.createEventHandler`       |                                                |
| `WL.Server.createSMSEventHandler`	 | Pour envoyer des messages SMS, utilisez l'API REST de service push. Pour plus d'informations, voir [Envoi de notifications](../../../notifications/sending-notifications).                         |
| `WL.Server.createUSSDEventHandler`	 | Intégrez USSD à l'aide de services tiers.  |

#### Envoi par commande push
{: #push }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`, `WL.Server.notifyAllDevices`, `WL.Server.sendMessage`, `WL.Server.notifyDevice`, `WL.Server.notifyDeviceSubscription`, `WL.Server.notifyAll`, `WL.Server.createDefaultNotification`, `WL.Server.submitNotification` 	| Pour effectuer une migration des notifications d'événement basées sur la source aux notifications basées sur l'étiquette, voir Migration vers les notifications push à partir de notifications basées sur la source d'événement. |
| `WL.Server.subscribeSMS`	                | Utilisez l'API REST Push Device Registration (POST) pour enregistrer l'appareil. Pour envoyer et recevoir des notifications par SMS, indiquez un numéro de téléphone dans le contenu lors de l'appel de l'API.                               |
| `WL.Server.unsubscribeSMS`	                | Utilisez l'API REST Push Device Registration (DELETE) pour annuler l'enregistrement de l'appareil. |
| `WL.Server.getSMSSubscription`	            | Utilisez l'API REST Push Device Registration GET) pour obtenir les enregistrements d'appareil. |

#### Services de localisation
{: #location-services }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | Intégrez les services de localisation à l'aide de services tiers. |

#### Sécurité de services Web
{: #ws-security }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | Utilisez les fonctions de sécurité de services Web de WebSphere Application Server. |

### Eléments des API Java abandonnés en version 8.0
{: #java-api-elements-discontinued-in-v-80 }
#### Sécurité
{: #security-java }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | Utilisez AdapterSecurityContext à la place.            |

#### Envoi par commande push
{: #push-java }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| Pour effectuer une migration des notifications d'événement basées sur la source aux notifications basées sur l'étiquette, voir Migration vers les notifications push à partir de notifications basées sur la source d'événement. |
| `INotification PushAPI.buildNotification();` | Pour effectuer une migration des notifications d'événement basées sur la source aux notifications basées sur l'étiquette, voir Migration vers les notifications push à partir de notifications basées sur la source d'événement. |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | Pour effectuer une migration des notifications d'événement basées sur la source aux notifications basées sur l'étiquette, voir Migration vers les notifications push à partir de notifications basées sur la source d'événement. |

#### Adaptateurs
{: #adapters-java }

| Elément d'API                                | Chemin de remplacement                               |
|-------------------------------------------|------------------------------------------------|
| Interface `AdaptersAPI` dans le package `com.worklight.adapters.rest.api` | Utilisez l'interface `AdaptersAPI` dans le package `com.ibm.mfp.adapter.api` à la place. |
| Interface `AnalyticsAPI` dans le package `com.worklight.adapters.rest.api` | Utilisez l'interface `AnalyticsAPI` dans le package `com.ibm.mfp.adapter.api` à la place. |
| Interface `ConfigurationAPI` dans le package `com.worklight.adapters.rest.api` | Utilisez l'interface `ConfigurationAPI` dans le package `com.ibm.mfp.adapter.api` à la place. |
| Annotation `OAuthSecurity` dans le package `com.worklight.core.auth` | Utilisez l'annotation `OAuthSecurity` dans le package `com.ibm.mfp.adapter.api` à la place. |
| Classe `MFPJAXRSApplication` dans le package `com.worklight.wink.extensions` | Utilisez la classe `MFPJAXRSApplication` dans le package `com.ibm.mfp.adapter.api` à la place. |
| Interface `WLServerAPI` dans le package `com.worklight.adapters.rest.api` | Utilisez l'annotation JAX-RS `Context` pour accéder directement aux interfaces d'API {{ site.data.keys.product_adj }}. |
| Classe `WLServerAPIProvider` dans le package `com.worklight.adapters.rest.api` | Utilisez l'annotation JAX-RS `Context` pour accéder directement aux interfaces d'API {{ site.data.keys.product_adj }}. |

## Modifications d'API côté client
{: #client-side-api-changes }
Les modifications suivantes dans les API sont pertinentes pour la migration de votre application client {{ site.data.keys.product_adj }}.  
Les tableaux suivants montrent les éléments des API côté client abandonnés en version 8.0.0, les éléments obsolètes des mêmes API et les chemins de migration proposés.

### API JavaScript
{: #javascript-apis }
Les API JavaScript qui affectent l'interface utilisateur ne sont plus prises en charge en version 8.0. Elles peuvent être remplacées par des plug-in Cordova tiers disponibles ou en créant des plug-in Cordova personnalisés.

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WL.BusyIndicator`, `WL.OptionsMenu`, `WL.TabBar`, `WL.TabBarItem` | Utilisez des plug-in Cordova ou 5 éléments HTML. |
| `WL.App.close` | Gérez cet événement en dehors de {{ site.data.keys.product_adj }}. |
| `WL.App.copyToClipboard()` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. |
| `WL.App.openUrl(url, target, options)` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in Cordova **InAppBrowser** fournit cette fonction. |
| `WL.App.overrideBackButton(callback)`, `WL.App.resetBackButton()` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in Cordova **backbutton** fournit cette fonction. |
| `WL.App.getDeviceLanguage()` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in Cordova **cordova-plugin-globalization** fournit cette fonction. |
| `WL.App.getDeviceLocale()` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in Cordova **cordova-plugin-globalization** fournit cette fonction. |
| `WL.App.BackgroundHandler` | Pour exécuter une fonction de gestionnaire personnalisée, utiliser le programme d'écoute d'événement de mise en pause Cordova. Utilisez un plug-in Cordova qui fournit la confidentialité et empêche les systèmes et utilisateurs iOS et Android de prendre des clichés ou des captures d'écran. Pour plus d'informations, voir la description **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**. |
| `WL.Client.close`, `WL.Client.restore`, `WL.Client.minimize` | Les fonctions ont été fournies pour prendre en charge la plateforme Adobe AIR, non prise en charge par {{ site.data.keys.product }} V8.0.0. |
| `WL.Toast.show(string)` | Utilisez les plug-in Cordova pour Toast. |

Cet ensemble d'API n'est plus pris en charge en v8.0.

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WL.Client.checkForDirectUpdate(options)` | Pas de remplacement. **Remarque :** Vous pouvez appeler `WLAuthorizationManager.obtainAccessToken` pour déclencher une mise à jour directe le cas échéant. L'accès à un jeton de sécurité déclenche une mise à jour directe si une mise à jour directe est disponible sur le serveur. Toutefois, vous ne pouvez pas déclencher une mise à jour directe à la demande. |
| `WL.Client.setSharedToken({key: myName, value: myValue})`, `WL.Client.getSharedToken({key: myName})`, `WL.Client.clearSharedToken({key: myName})` | Pas de remplacement. |
| `WL.Client.isConnected()`, `connectOnStartup` init option | Utilisez `WLAuthorizationManager.obtainAccessToken` pour vérifier la connectivité au serveur et appliquer des règles de gestion des applications. |
| `WL.Client.setUserPref(key,value, options)`, `WL.Client.setUserPrefs(userPrefsHash, options)`, `WL.Client.deleteUserPrefs(key, options)` | Pas de remplacement. Vous pouvez utiliser un adaptateur et l'API `MFP.Server.getAuthenticatedUser` pour gérer des préférences d'utilisateur. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Pas de remplacement. |
| `WL.Client.logActivity(activityType)` | Utilisez `WL.Logger`. |
| `WL.Client.login(realm, options)` | Utilisez `WLAuthorizationManager.login`. Pour vous initier à l'authentification et à la sécurité, voir les tutoriels de la rubrique Authentication and Security. |
| `WL.Client.logout(realm, options)` | Utilisez `WLAuthorizationManager.logout`. |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | Utilisez `WLAuthorizationManager.obtainAccessToken`. |
| `WL.Client.transmitEvent(event, immediate)`, `WL.Client.purgeEventTransmissionBuffer()`, `WL.Client.setEventTransmissionPolicy(policy)` | Créez un adaptateur personnalisé pour recevoir des notifications de ces événements. |
| `WL.Device.getContext()`, `WL.Device.startAcquisition(policy, triggers, onFailure)`, `WL.Device.stopAcquisition()`, `WL.Device.Wifi`, `WL.Device.Geo.Profiles`, `WL.Geo` | Utilisez l'API native ou les plug-in Cordova tiers pour la géolocalisation. |
| `WL.Client.makeRequest (url, options)` | Créez un adaptateur personnalisé qui fournit la même fonctionnalité. |
| `WLDevice.getID(options)` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, l'option `device.uuid` du plug-in c**ordova-plugin-device** fournit cette fonction. |
| `WL.Device.getFriendlyName()` | Utilisez `WL.Client.getDeviceDisplayName` |
| `WL.Device.setFriendlyName()` | Utilisez `WL.Client.setDeviceDisplayName` |
| `WL.Device.getNetworkInfo(callback)` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in **cordova-plugin-network-information** fournit cette fonction. |
| `WLUtils.wlCheckReachability()` | Créez un adaptateur personnalisé pour vérifier la disponibilité de serveur. |
| `WL.EncryptedCache` | Utilisez JSONStore pour stocker des données chiffrées localement. JSONStore se trouve dans le plug-in **cordova-plugin-mfp-jsonstore**. Pour plus d'informations, voir
[JSONStore](../../../application-development/jsonstore). |
| `WL.SecurityUtils.remoteRandomString(bytes)` | Créez un adaptateur personnalisé qui fournit la même fonctionnalité. |
| `WL.Client.getAppProperty(property)` | Vous pouvez extraite la propriété de version d'application à l'aide du plug-in **cordova-plugin-appversion**. La version renvoyée est la version d'application native (Android et iOS uniquement). |
| `WL.Client.Push.*` | Utilisez l'API push côté client JavaScript à partir du plug-in **cordova-plugin-mfp-push**. |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | Utilisez `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)` pour enregistrer l'appareil pour push et SMS. |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | Utilisez `WLAuthorizationManager.obtainAccessToken` dans le but d'obtenir un jeton pour la portée demandée. |
| `WLClient.getLastAccessToken(scope)` | Utilisez `WLAuthorizationManager.obtainAccessToken` |
| `WLClient.getLoginName()`, `WL.Client.getUserName(realm)` | Pas de remplacement |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | Utilisez `WLAuthorizationManager.isAuthorizationRequired` et `WLAuthorizationManager.getResourceScope`. |
| `WL.Client.isUserAuthenticated(realm)` | Pas de remplacement |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | Pas de remplacement |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | Pas de remplacement |
| `WL.Client.createChallengeHandler(realmName)` | Pour créer un gestionnaire de demandes d'authentification afin de traiter les demandes d'authentification de passerelle personnalisées, utilisez `WL.Client.createGatewayChallengeHandler(gatewayName)`. Pour créer un gestionnaire de demandes d'authentification afin de traiter des demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
| `WL.Client.createWLChallengeHandler(realmName)` | Utilisez `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
| `challengeHandler.isCustomResponse()` où challengeHandler est un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createChallengeHandler()` | Utilisez `gatewayChallengeHandler.canHandleResponse()` où `gatewayChallengeHandler` est un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createGatewayChallengeHandler()`. |
| `wlChallengeHandler.processSucccess()` où `wlChallengeHandler` est un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createWLChallengeHandler()` | Utilisez `securityCheckChallengeHandler.handleSuccess()` où `securityCheckChallengeHandler` est un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createSecurityCheckChallengeHandler()`. |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | Implémentez une logique similaire dans votre gestionnaire de demandes d'authentification. Pour les gestionnaires de demandes d'authentification de passerelle personnalisés, utilisez un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createGatewayChallengeHandler()`. Pour les gestionnaires de demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez un objet de gestionnaire de demandes d'authentification renvoyé par `WL.Client.createSecurityCheckChallengeHandler()`. |
| `WL.Client.createProvisioningChallengeHandler()` | Pas de remplacement. La mise à disposition d'appareil est maintenant traitée automatiquement par l'infrastructure de sécurité. |

#### API JavaScript dépréciées
{: #deprecated-javascript-apis }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`, `WL.Client.invokeProcedure(invocationData, options)`, `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`, `WLProcedureInvocationResult` | Utilisez `WLResourceRequest` à la place. **Remarque :** L'implémentation de `invokeProcedure` utilise `WLResourceRequest`. |
| `WLClient.getEnvironment` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in **device.platform** fournit cette fonction. |
| `WLClient.getLanguage` | Utilisez les plug-in Cordova qui fournissent cette fonctionnalité. **Remarque :** A titre d'information, le plug-in **cordova-plugin-globalization** fournit cette fonction. |
| `WL.Client.connect(options)` | Utilisez `WLAuthorizationManager.obtainAccessToken` pour vérifier la connectivité au serveur et appliquer des règles de gestion des applications. |

### API Android
{: #android-apis}
####  Eléments d'API Android dépréciés
{: #discontinued-android-api-elements }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WLConfig WLClient.getConfig()` | Pas de remplacement. |
| `WLDevice WLClient.getWLDevice()`, `WLClient.transmitEvent(org.json.JSONObject event)`, `WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`, `WLClient.purgeEventTransmissionBuffer()` | Utilisez l'API Android ou des packages tiers pour la géolocalisation. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Pas de remplacement. |
| `WL.Client.getUserInfo(realm, key`, `WL.Client.updateUserInfo(options)` | Pas de remplacement. |
| `WLClient.checkForNotifications()` | Utilisez `WLAuthorizationManager.obtainAccessToken("", listener)` pour vérifier la connectivité au serveur et appliquer des règles de gestion des applications. |
| `WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.login(java.lang.String realmName, WLRequestListener listener)` | Utilisez `AuthorizationManager.login()` |
| `WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.logout(java.lang.String realmName, WLRequestListener listener)` | Utilisez `AuthorizationManager.logout()` |
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | Utilisez `WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)` pour vérifier la connectivité au serveur et appliquer des règles de gestion des applications. |
| `WLClient.getLastAccessToken()`, `WLClient.getLastAccessToken(java.lang.String scope)` | Utilisez `AuthorizationManager` |
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | Utilisez `AuthorizationManager` |
| `WLClient.logActivity(java.lang.String activityType)` | Utilisez `com.worklight.common.Logger`. Pour plus d'informations, voir la rubrique Kit de développement de logiciels de consignateur. |
| `WLAuthorizationPersistencePolicy` | Pas de remplacement. Pour implémenter la persistance d'autorisation, stockez le jeton d'autorisation dans le code d'application et créez des demandes HTTP personnalisées. |
| `WLSimpleSharedData.setSharedToken(myName, myValue)`, `WLSimpleSharedData.getSharedToken(myName)`, `WLSimpleSharedData.clearSharedToken(myName)` | Utilisez les API Android pour partager des jetons entre les applications. |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | Pas de remplacement |
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | Utilisez `BaseChallengeHandler.cancel()` |
| `ChallengeHandler` | Pour les demandes d'authentification de passerelle personnalisées, utilisez `GatewayChallengeHandler`. Pour les demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler` | Utilisez `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.isCustomResponse()` | Utilisez `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implémentez une logique similaire dans votre gestionnaire de demandes d'authentification. Pour les gestionnaires de demandes d'authentification de passerelle personnalisés, utilisez `GatewayChallengeHandler`. |

#### API Android dépréciées
{: #deprecated-android-apis }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` | Déprécié. Utilisez `WLResourceRequest`. **Remarque :** L'implémentation de `invokeProcedure` utilise `WLResourceRequest`. |
| `WLClient.connect(WLResponseListener responseListener)`, `WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` | Utilisez `WLAuthorizationManager.obtainAccessToken("", listener)` pour vérifier la connectivité au serveur et appliquer des règles de gestion des applications. |

#### Les API Android dépendant des API org.apach.http existantes ne sont plus prises en charge
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `org.apache.http.Header[]` est désormais déprécié. Par conséquent, les méthodes suivantes ont été retirées :||
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | Utilisez la nouvelle API `Map<String, List<String>> WLResourceRequest.getAllHeaders()` à la place. |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | Utilisez la nouvelle API `WLResourceRequest.addHeader(String name, String value)` à la place. |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | Utilisez la nouvelle API `List<String> WLResourceRequest.getHeaders(String headerName)` à la place. |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | Utilisez la nouvelle API `WLResourceRequest.getHeaders(String headerName)` à la place. |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | Utilisez la nouvelle API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` à la place. |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | Utilisez la nouvelle API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` à la place. |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | Remplacé par `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | Pas de remplacement. Le client MFP autorise des redirections circulaires. |
| `WLHttpResponseListener`, `WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`, `WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`, `WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`, `WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`, `WLResourceRequest.send(WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` | Retiré en raison des dépendances Apache HTTP Client dépréciées. Créez votre propre demande afin de disposer d'un contrôle complet sur la demande et la réponse. |

#### Le package `com.worklight.androidgap.api` fournit la fonctionnalité de plateforme Android pour les applications Cordova. Dans {{ site.data.keys.product }}, un certain nombre de modifications a été effectué afin d'assurer la prise en charge de l'intégration Cordova.
{: #comworklightandroidgapapi }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| L'activité Android a été remplacée par le contexte Android. | |
| `static WL.createInstance(android.app.Activity activity)` | `static WL.createInstance(android.content.Context context)` crée une instance partagée. |
| `static WL.getInstance()` |  `static WL.getInstance()` obtient une instance de la classe WL. Cette méthode ne peut pas être appelée avant `WL.createInstance(Context)`. |

### API Objective-C
{: #objective-c-apis }
#### API Objective C iOS abandonnées
{: #discontinued-ios-objective-c-apis }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `[WLClient getWLDevice][WLClient transmitEvent:]`, `[WLClient setEventTransmissionPolicy]`, `[WLClient purgeEventTransmissionBuffer]` | Géolocalisation retirée. Utilisez les packages iOS natifs ou tiers pour la géolocalisation. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Pas de remplacement. |
| `WL.Client.deleteUserPref(key, options)` | Pas de remplacement. Vous pouvez utiliser un adaptateur et l'API `MFP.Server.getAuthenticatedUser` pour gérer des préférences d'utilisateur. |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | Utilisez `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient login:withDelegate:]` | Utilisez `WLAuthorizationManager login`. |
| `[WLClient logout:withDelegate:]` | Utilisez `WLAuthorizationManager logout`. |
| `[WLClient lastAccessToken]`, `[WLClient lastAccessTokenForScope:]` | Utilisez `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient obtainAccessTokenForScope:withDelegate:]`, `[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` | Utilisez `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | Utilisez l'API push côté client Objective-C pour les applications iOS à partir de l'infrastructure IBMMobileFirstPlatformFoundationPush |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | Utilisez l'API push côté client Objective-C pour les applications iOS à partir de l'infrastructure IBMMobileFirstPlatformFoundationPush. |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | Déprécié. Utilisez `WLResourceRequest` à la place. |
| `WLClient sendUrlRequest:delegate:]` | Utilisez `[WLResourceRequest sendWithDelegate:delegate]` à la place. |
| `[WLClient (void) logActivity:(NSString *) activityType]` | Retiré. Utilisez un consignateur Objective C. |
| `[WLSimpleDataSharing setSharedToken: myName value: myValue]`, `[WLSimpleDataSharing getSharedToken: myName]]`, `[WLSimpleDataSharing clearSharedToken: myName]` | Utilisez les API OS pour partager des jetons entre les applications. |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | Utilisez `BaseChallengeHandler.cancel()`. |
| `BaseProvisioningChallengeHandler` | Pas de remplacement. La mise à disposition d'appareil est maintenant traitée automatiquement par l'infrastructure de sécurité. |
| `ChallengeHandler` | Pour les demandes d'authentification de passerelle personnalisées, utilisez `GatewayChallengeHandler`. Pour les demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler` | Utilisez `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.isCustomResponse()` | Utilisez `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implémentez une logique similaire dans votre gestionnaire de demandes d'authentification. Pour les gestionnaires de demandes d'authentification de passerelle personnalisés, utilisez `GatewayChallengeHandler`. Pour les gestionnaires de demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler`. |

### API Windows C#
{: #windows-c-apis }
#### Eléments d'API Windows C# dépréciés - Classes
{: #deprecated-windows-c-api-elements-classes }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `ChallengeHandler` | Pour les demandes d'authentification de passerelle personnalisées, utilisez `GatewayChallengeHandler`. Pour les demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler`. |
| `ChallengeHandler. isCustomResponse()` | Utilisez `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implémentez une logique similaire dans votre gestionnaire de demandes d'authentification. Pour les gestionnaires de demandes d'authentification de passerelle personnalisés, utilisez `GatewayChallengeHandler`. Pour les gestionnaires de demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | Pour les gestionnaires de demandes d'authentification de passerelle personnalisées, utilisez`GatewayChallengeHandler.Shouldcancel()`. Pour les gestionnaires de demandes d'authentification de contrôle de sécurité {{ site.data.keys.product_adj }}, utilisez `SecurityCheckChallengeHandler.ShouldCancel()`. |
| `WLAuthorizationManager` | Utilisez `WorklightClient.WorklightAuthorizationManager` à la place. |
| `WLChallengeHandler` | Utilisez `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)` | Utilisez `SecurityCheckChallengeHandler.ShouldCancel()`. |
| `WLClient` | Utilisez `WorklightClient` à la place. |
| `WLErrorCode` | Pas de prise en charge. |
| `WLFailResponse` | Utilisez `WorklightResponse` à la place. |
| `WLResponse` | Utilisez `WorklightResponse` à la place. |
| `WLProcedureInvocationData` | Utilisez `WorklightProcedureInvocationData` à la place. |
| `WLProcedureInvocationFailResponse` | Pas de prise en charge. |
| `WLProcedureInvocationResult` | Pas de prise en charge. |
| `WLRequestOptions` | Pas de prise en charge. |
| `WLResourceRequest` | Pas de prise en charge. |

#### Eléments d'API Windows C# dépréciés - Interfaces
{: #deprecated-windows-c-api-elements-interfaces }

| Elément d'API           | Chemin de migration                           |
|-----------------------|------------------------------------------|
| `WLHttpResponseListener` | Pas de prise en charge. |
| `WLResponseListener` | La réponse sera disponible sous forme d'un objet `WorklightResponse` |
| `WLAuthorizationPersistencePolicy` | Pas de prise en charge. |
