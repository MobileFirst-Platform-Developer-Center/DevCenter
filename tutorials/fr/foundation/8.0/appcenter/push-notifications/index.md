---
layout: tutorial
title: Notifications push des mises à jour de l'application
breadcrumb_title: Notifications push
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez configurer le client Application Center de sorte que les notifications push soient envoyées aux utilisateurs lorsqu'une mise à jour est disponible pour une application dans le magasin.

L'administrateur Application Center utilise des notifications push pour envoyer la notification automatiquement à n'importe quel appareil iOS ou Android. Des notifications sont envoyées pour les mises à jour des applications favorites et des nouvelles applications qui sont déployées sur le serveur Application Center et sont marquées comme recommandées.

### Processus de notification push
{: #push-notification-process }
Les notifications push sont envoyées à un appareil si les conditions suivantes sont remplies :

* Application Center est installé sur l'appareil et a été démarré au moins une fois.
* L'utilisateur n'a pas désactivé la notification push pour cet appareil pour Application Center dans l'interface **Settings → Notifications**.
* L'utilisateur est autorisé à installer l'application. Ces droits sont contrôlés par les droits d'accès Application Center.
* L'application est marquée comme recommandée ou comme préférée pour l'utilisateur qui utilise Application Center sur cet appareil. Ces indicateurs sont définis automatiquement lorsque l'utilisateur installe une application via Application Center. Vous pouvez savoir quelles applications sont marquées comme préférées en observant l'onglet **Favorites** d'Application Center sur l'appareil.
* L'application n'est pas installée sur l'appareil ou une version plus récente que celle installée sur le périphérique est disponible.

La première fois que le client Application Center démarre sur un appareil, l'utilisateur peut être invité à accepter les notifications push entrantes. C'est le cas des appareils mobiles iOS. La fonction de notification push ne fonctionne pas lorsque le service est désactivé sur l'appareil mobile.

IOS et les versions actuelles du système d'exploitation Android offrent un moyen d'activer ou de désactiver ce service pour chaque application.

Consultez le fournisseur de votre appareil pour savoir comment configurer votre appareil mobile pour les notifications push.

#### Accéder à
{: #jump-to }
* [Configuration des notifications push pour les mises à jour d'application](#configuring-push-notifications)
* [Configuration du serveur Application Center pour la connexion à Google Cloud Messaging](#gcm)
* [Configuration du serveur Application Center pour la connexion à Apple Push Notification Services](#apns)
* [Génération d'une version du client mobile indépendante de l'API GCM](#no-gcm)

## Configuration des notifications push pour les mises à jour d'application
{: #configuring-push-notifications }
Vous devez configurer les données d'identification ou les certificats des services Application Center afin de pouvoir communiquer avec des serveurs de notification push tiers.

### Configuration du planificateur du serveur Application Center
{: #configuring-the-server-scheduler }
Le planificateur de serveur est un service en arrière-plan qui démarre et s'arrête automatiquement avec le serveur. Ce planificateur est utilisé pour vider à intervalles réguliers une pile qui est automatiquement remplie par des actions d'administrateur avec des messages de mise à jour push à envoyer. L'intervalle par défaut entre l'envoi de deux lots de messages de mise à jour push est de douze heures. Si cette valeur par défaut ne vous convient pas, vous pouvez la modifier à l'aide des variables d'environnement du serveur **ibm.appcenter.push.schedule.period.amount** et **ibm.appcenter.push.schedule.period.unit**.

La valeur de **ibm.appcenter.push.schedule.period.amount** est un nombre entier. La valeur **ibm.appcenter.push.schedule.period.unit** peut être exprimée en secondes, minutes ou heures. Si l'unité n'est pas spécifiée, la quantité est un intervalle exprimé en heures. Ces variables servent à définir le temps écoulé entre deux lots de messages push.

Utilisez les propriétés JNDI pour définir ces variables.

> **Important :** dans un environnement de production, évitez de définir le paramètre en secondes. Plus le temps écoulé est court, plus la charge sur le serveur est élevée. L'unité exprimée en secondes n'est mise en œuvre qu'à des fins de test et d'évaluation. Par exemple, lorsque le temps écoulé est réglé sur 10 secondes, les messages push sont envoyés presque immédiatement.

Voir [Propriétés JNDI pour Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) pour obtenir une liste complète des propriétés que vous pouvez définir.

### Exemple pour le serveur Apache Tomcat
{: tomcat }
Définissez ces variables avec les propriétés JNDI dans le fichier server.xml :

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server v8.5
{: #websphere }
Pour configurer les variables JNDI pour WebSphere Application Server v8.5, procédez comme suit :

1. Cliquez sur **Applications → Application Types → Websphere enterprise applications**.
2. Sélectionnez l'application Application Center Services.
3. Cliquez sur **Web Module Properties → Environment entries for Web modules**.
4. Éditez la chaîne dans la colonne **Value**.

#### Profil Liberty de WebSphere Application Server
{: #liberty }
Pour plus d'informations sur la configuration des variables JNDI pour le profil Liberty de WebSphere Application Server, voir [Utilisation de la liaison JNDI pour les constantes à partir des fichiers de configuration du serveur](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html).

Les actions restantes pour configurer le service de notification push dépendent du fournisseur de l'appareil sur lequel l'application cible est installée.

## Configuration du serveur Application Center pour la connexion à Google Cloud Messaging
{: #gcm }
Pour activer Google Cloud Messaging (GCM) pour une application, vous devez associer les services GCM à un compte Google développeur avec l'API Google activée. Voir [Getting Started with GCM](http://developer.android.com/google/gcm/gs.html) pour plus de détails.

> Important : client Application Center sans Google Cloud Messaging : Application Center dépend de la disponibilité de l'API de Google Cloud Messaging (GCM). Cette API peut ne pas être disponible sur les appareils de certains territoires tels que la Chine. Pour prendre en charge ces territoires, vous pouvez créer une version du client Application Center qui ne dépend pas de l'API de GCM. La fonctionnalité de notification push ne fonctionne pas sur cette version du client Application Center. Voir [Génération d'une version du client mobile indépendante de l'API de CM](#no-gcm) pour plus de détails.

1. Si vous ne disposez pas du compte Google approprié, accédez à [Créer un compte Google](https://mail.google.com/mail/signup) et créez-en un pour le client Application Center.
2. Enregistrez ce compte en utilisant l'API Google dans la [console de l'API Google](https://code.google.com/apis/console/). La procédure d'enregistrement crée un projet par défaut que vous pouvez renommer. Le nom que vous donnez à ce projet GCM n'est pas lié au nom du moduled'application Android. Lorsque le projet est créé, un ID de projet GCM est ajouté à la fin de l'URL du projet. Vous devez enregistrer ce numéro de fin en tant qu'ID de projet pour référence future.
3. Activez le service GCM pour votre projet ; dans la console d'API Google, cliquez sur l'onglet **Services** à gauche et activez le service "Google Cloud Messaging for Android" dans la liste des services.
4. Assurez-vous qu'une clé de serveur d'accès d'API simple est disponible pour les communications de votre application.
    * Cliquez sur l'onglet vertical **API Access** à gauche de la console.
    * Créez une clé de serveur d'accès d'API simple ou, si une clé par défaut est déjà créée, notez les détails de la clé par défaut. Deux autres types de clé existent mais ils ne nous intéressent pas pour le moment.
    * Enregistrez la clé du serveur d'accès d'API simple pour une utilisation ultérieure dans vos communications d'application via GCM. La longueur de la clé est d'environ 40 caractères et cette clé est appelée clé de l'API Google dont vous aurez besoin ultérieurement du côté serveur.
5. Entrez l'ID de projet GCM en tant que propriété de ressource de chaîne dans le projet JavaScript du client Android d'Application Center ; dans le fichier modèle **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json**, remplacez cette ligne par votre propre valeur :

   ```xml
   gcmProjectId:""// Google API project (project name = com.ibm.appcenter) ID needed for Android push.
   // example : 123456789012
   ```

6. Enregistrez la clé de l'API Google en tant que propriété JNDI pour le serveur Application Center. Le nom de la clé est : **ibm.appcenter.gcm.signature.googleapikey**. Par exemple, vous pouvez configurer cette clé pour un serveur Apache Tomcat en tant que propriété JNDI dans le fichier **server.xml** :

   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String" 
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   La propriété JNDI doit être définie en fonction des exigences de votre serveur d'applications.  
   Voir [Propriétés JNDI pour Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) pour obtenir une liste complète des propriétés que vous pouvez définir.
    
**Important :**

* Si vous utilisez GCM avec des versions antérieures d'Android, vous devrez peut-être appairer votre appareil avec un compte Google existant pour que GCM fonctionne efficacement. Voir [GCM service](http://developer.android.com/google/gcm/gcm.html) : "Il utilise une connexion existante pour les services Google. Pour les appareils antérieurs à la version 3.0, les utilisateurs doivent configurer leur compte Google sur leurs appareils mobiles. Un compte Google n'est pas obligatoire pour les appareils fonctionnant sous Android 4.0.4 ou version ultérieure."
* Vous devez également vous assurer que votre pare-feu accepte les connexions sortantes vers android.googleapis.com sur le port 443 pour que les notifications push fonctionnent.

## Configuration du serveur Application Center pour la connexion à Apple Push Notification Services
{: #apns }
Configurez votre projet iOS pour Apple Notification Services (APN). Assurez-vous que les serveurs suivants sont accessibles depuis le serveur Application Center.

**Serveurs de bac à sable**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**Serveurs de production**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

Vous devez être un développeur Apple enregistré pour configurer votre projet iOS auprès d'Apple Push Notification Services (APN). Dans la société, le rôle administratif responsable du développement d'Apple demande l'activation d'APN. La réponse à cette demande devrait vous fournir un profil de mise à disposition compatible APN pour votre bundle d'applications iOS ; c'est-à-dire une valeur de chaîne qui est définie dans la page de configuration de votre projet Xcode. Ce profil de mise à disposition est utilisé pour générer un fichier de certificat de signature.
Il existe deux types de profils de mise à disposition : les profils de développement et les profils de production, qui concernent respectivement les environnements de développement et de production. Les profils de développement concernent exclusivement les serveurs APN de développement Apple. Les profils de production s'adressent exclusivement aux serveurs APN de production Apple. Ces types de serveurs n'offrent pas la même qualité de service.

Remarque : les appareils connectés à un wifi d'entreprise derrière un pare-feu ne peuvent recevoir de notifications push que si la connexion au type d'adresse suivant n'est pas bloquée par le pare-feu.

`x-courier.sandbox.push.apple.com:5223`  
Où x est un nombre entier.

1. Procurez-vous le profil de mise à disposition activé par APN pour le projet Xcode d'Application Center. Le résultat de la demande d'activation des APN effectuée par votre administrateur s'affiche sous la forme d'une liste accessible à partir de [https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action). Chaque élément de la liste indique si le profil possède ou non des capacités APN. Lorsque vous possédez le profil, vous pouvez le télécharger et l'installer dans le répertoire du projet Xcode du client Application Center en cliquant deux fois sur le profil. Le profil est alors automatiquement installé dans votre magasin de clés et votre projet Xcode.

2. Si vous souhaitez tester ou déboguer Application Center sur un appareil en le lançant directement depuis XCode, dans la fenêtre "Xcode Organizer", accédez à la section "Provisioning Profiles" et installez le profil sur votre appareil mobile.

3. Créez un certificat de signature utilisé par les services Application Center pour sécuriser la communication avec le serveur APN. Ce serveur utilise le certificat à des fins de signature de chaque demande push vers le serveur APN. Ce certificat de signature est produit à partir de votre profil de mise à disposition.
    
* Ouvrez l'utilitaire "Keychain Access" et cliquez sur la catégorie **My Certificates** dans le volet gauche.
* Recherchez le certificat que vous souhaitez installer et divulguez son contenu. Vous voyez à la fois un certificat et une clé privée ; pour Application Center, la ligne de certificat contient le bundle d'applications d'Application Center **com.ibm.imf.AppCenter**.
* Sélectionnez **File → Export Items** pour sélectionner à la fois le certificat et la clé et exportez-les en tant que fichier d'échange d'informations personnelles (.p12). Ce fichier .p12 contient la clé privée requise lorsque le protocole d'établissement de liaison sécurisé est impliqué pour communiquer avec le serveur APN.
* Copiez le certificat .p12 sur l'ordinateur responsable de l'exécution des services Application Center et installez-le à l'endroit approprié. Le fichier de certificat et son mot de passe sont nécessaires pour créer la tunnellisation sécurisés avec le serveur APN. Vous avez également besoin de certaines informations indiquant si un certificat de développement ou un certificat de production est en jeu. Un profil de mise à disposition de développement produit un certificat de développement et un profil de production génère un certificat de production. L'application Web des services Application Center utilise les propriétés JNDI pour faire référence à ces données sécurisées

Les exemples du tableau montrent comment les propriétés JNDI sont définies dans le fichier server.xml du serveur Apache Tomcat.

| Propriété JNDI	| Type et description | Exemple pour le serveur Apache Tomcat | 
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location | Valeur de chaîne qui définit le chemin d'accès complet au certificat .p12. | `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password | Valeur de chaîne définissant le mot de passe nécessaire pour accéder au certificat. | `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` | 
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate |	Valeur booléenne (identifiée comme true ou false) qui définit si le profil de mise à disposition utilisé pour générer le certificat d'authentification était ou non un certificat de développement. | `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` | 

Consultez [Propriétés JNDI pour Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) pour obtenir une liste complète des propriétés JNDI que vous pouvez définir.

## Génération d'une version du client mobile indépendante de l'API GCM
{: #no-gcm }
Vous pouvez supprimer la dépendance de l'API Google Cloud Messaging (GCM) de la version Android du client pour respecter les contraintes dans certains territoires. Les notifications Push ne fonctionnent pas sur cette version du client.

Application Center dépend de la disponibilité de l'API Google Cloud Messaging (GCM). Cette API peut ne pas être disponible sur les appareils de certains territoires tels que la Chine. Pour prendre en charge ces territoires, vous pouvez créer une version du client Application Center qui ne dépend pas de l'API de GCM. La fonctionnalité de notification push ne fonctionne pas sur cette version du client Application Center.

1. Vérifiez que les notifications push sont désactivées en vérifiant que le fichier **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** contient cette ligne : `"gcmProjectId": "" ,`.
2. Supprimez de deux endroits dans le fichier **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** toutes les lignes qui se trouvent entre ces commentaires : `<!-- AppCenter Push configuration -->` et `<!-- end of AppCenter Push configuration -->`.
3. Supprimez la classe **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java**.
4. Dans Eclipse, exécutez "Build Android Environment" dans le dossier IBMAppCenter/apps/AppCenter/android folder.
5. Supprimez le fichier **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar** qui a été créé par le plug-in MobileFirst lorsque vous avez exécuté la commande précédente "Build Android Environment".
6. Actualisez le nouveau projet IBMAppCenterAppCenterAndroid, afin que la suppression de la bibliothèque GCM soit prise en compte.
7. Créez le fichier .apk d'Application Center.

La bibliothèque **gcm.jar** est automatiquement ajoutée par le plug-in MobileFirst Eclipse chaque fois que l'environnement Android est généré. Par conséquent, ce fichier d'archive java doit être supprimé du répertoire **IBMAppCenter/apps/AppCenter/android/native/libs/** à chaque exécution du processus de génération Android de MobileFirst. Faute de quoi, la bibliothèque **gcm.jar** est présente dans le fichier **appcenter.apk** obtenu.
