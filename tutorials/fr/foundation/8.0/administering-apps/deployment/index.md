---
layout: tutorial
title: Déploiement d'applications sur des environnements de test et de production
breadcrumb_title: Déploiement d'applications sur des environnements
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Lorsque vous avez terminé un cycle de développement de votre application, déployez-le sur un environnement de test, puis sur un environnement de production.

### Accéder à
{: #jump-to }

* [Déploiement ou mise à jour d'un adaptateur dans un environnement de production](#deploying-or-updating-an-adapter-to-a-production-environment)
* [Configuration de SSL entre des adaptateurs et des serveurs de back end à l'aide de certificats auto-signés](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment)
* [Enregistrement d'une application sur un environnement de production](#registering-an-application-to-a-production-environment)
* [Transfert d'artefacts côté serveur vers un serveur de test ou de production](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [Mise à jour d'applications {{site.data.keys.product_adj }} en production](#updating-mobilefirst-apps-in-production)

## Déploiement ou mise à jour d'un adaptateur dans un environnement de production
{: #deploying-or-updating-an-adapter-to-a-production-environment }
Les adaptateurs contiennent le code côté serveur des applications qui sont déployées et gérées par {{site.data.keys.product }}. Consultez cette liste de contrôle avant de déployer ou de mettre à jour un adaptateur sur un environnement de production. Pour plus d'informations sur la création et la génération d'adaptateurs, voir[Développement du côté serveur d'une application {{site.data.keys.product_adj }}](../../adapters).

Les adaptateurs peuvent être envoyés par téléchargement, mis à jour ou configurés alors qu'un serveur de production est en cours d'exécution. Une fois que tous les noeuds d'un parc de serveurs ont reçu le nouvel adaptateur ou la nouvelle configuration, toutes les demandes entrantes sur l'adaptateur utilisent les nouveaux paramètres.

1. Si vous mettez à jour un adaptateur existant dans un environnement de production, assurez-vous que cet adaptateur ne contient aucune incompatibilité ou régression par rapport à des applications existantes enregistrées sur un serveur.

    Le même adaptateur peut être utilisé par plusieurs applications, ou par plusieurs versions de la même application, qui sont déjà publiées sur le magasin et utilisées. Avant de mettre à jour l'adaptateur dans un environnement de production, exécutez des tests de non régression dans un serveur de test sur le nouvel adaptateur et les copies des applications qui sont générées pour le serveur de test.

2. Pour les adaptateurs Java, si l'adaptateur utilise Java URLConnection avec HTTPS, assurez-vous que les certificats de back end figurent dans le magasin de clés {{site.data.keys.mf_server }}.
        
    Pour plus d'informations, voir [Utilisation de SSL dans les adaptateurs HTTP](../../adapters/javascript-adapters/js-http-adapter/using-ssl/). Pour plus d'informations sur l'utilisation des certificats auto-signés, voir [Configuration de SSL entre des adaptateurs et des serveurs de back end à l'aide de certificats auto-signés](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

    > **Remarque :** Si le serveur d'applications est WebSphere Application Server Liberty, les certificats doivent également figurer dans le fichier de clés certifiées Liberty.

3. Vérifiez la configuration côté serveur de l'adaptateur.
4. Utilisez les commandes `mfpadm deploy adapter` et `mfpadm adapter set user-config` pour envoyer par téléchargement l'adaptateur et sa configuration.

    Pour plus d'informations sur le programme **mfpadm** pour les adaptateurs, voir [Commandes pour adaptateurs](../using-cli/#commands-for-adapters).
        
## Configuration de SSL entre des adaptateurs et des serveurs de back end à l'aide de certificats auto-signés
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
Vous pouvez configurer SSL entre des adaptateurs et des serveurs de back end en important le certificat SSL auto-signé du serveur dans le magasin de clés {{site.data.keys.product_adj }}.

1. Exportez le certificat public de serveur à partir du magasin de clés de serveur de back end.

    > **Remarque :** Exportez les certificats publics de back end à partir du magasin de clés de back end à l'aide de keytool ou de la bibliothèque openssl. N'utilisez pas la fonction d'exportation d'un navigateur Web.

2. Importez le certificat de serveur de back end dans le magasin de clés {{site.data.keys.product_adj }}.
3. Déployez le nouveau magasin de clés {{site.data.keys.product_adj }}. Pour plus d'informations, voir [Configuration du magasin de clés {{site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

### Exemple
{: #example }
Le nom **CN** du certificat de back end doit correspondre à celui qui est configuré dans le fichier **adapter.xml** du descripteur de l'adaptateur. Par exemple, prenons un fichier **adapter.xml** configuré comme suit :

```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

Le certificat de back end doit être généré avec **CN=mybackend.com**.

Prenons comme autre exemple la configuration d'adaptateur suivante :

```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

Le certificat de back end doit être généré avec **CN=123.124.125.126**.

L'exemple suivant vous démontre comment exécuter la configuration à l'aide du programme Keytool.

1. Créez un magasin de clés de serveur de back end avec un certificat privé pour 365 jours.
        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **Remarque :** La zone **First and Last Name** contient l'URL de votre serveur, que vous avez indiquée dans le fichier de configuration **adapter.xml**. Par exemple, **mydomain.com** ou **localhost**.

2. Configurez votre serveur de back end pour qu'il fonctionne avec le magasin de clés. Par exemple, dans Apache Tomcat, modifiez
le fichier **server.xml** :

   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. Vérifiez la configuration de la connectivité dans le fichier **adapter.xml** :

   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- The following properties are used by adapter's key manager for choosing a specific certificate from the key store
        <sslCertificateAlias></sslCertificateAlias> 
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. Exportez le certificat public à partir du magasin de clés de serveur de back end créé :

   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. Importez le certificat exporté dans votre magasin de clés {{site.data.keys.mf_server }} :

   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. Assurez-vous que le certificat est correctement importé dans me magasin de clés :

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. Déployez le nouveau magasin de clés {{site.data.keys.mf_server }}.

## Génération d'une application pour un environnement de test ou de production
{: #building-an-application-for-a-test-or-production-environment }
Pour générer une application pour un environnement de test ou de production, vous devez la configurer pour son serveur cible. Pour générer une application pour un environnement de production, vous devez exécuter des étapes supplémentaires.

1. Assurez-vous que le magasin de clés de serveur cible est configuré.
Pour plus d'informations, voir [Configuration du magasin de clés {{site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

2. Si vous prévoyez de distribuer l'artefact installable de l'application, incrémentez la version de l'application.
3. Avant de générer votre application, configurez-la pour le serveur cible.

    Vous définissez l'URL et le nom d'exécution du serveur cible dans le fichier de propriétés du client. Vous pouvez également modifier le serveur cible en utilisant l'{{site.data.keys.mf_cli }}. Pour configurer l'application pour un serveur cible sans enregistrer l'application sur un serveur en cours d'exécution, vous pouvez utiliser les commandes `mfpdev app config server <server URL>` et `mfpdev app config runtime <runtime_name>`. Vous pouvez aussi enregistrer l'application sur un serveur en cours d'exécution en exécutant la commande `mfpdev app register`. Utilisez l'URL publique du serveur. L'application mobile utilise cette URL pour se connecter  au serveur {{site.data.keys.mf_server }}.
    
    Par exemple, pour configurer l'application pour un serveur cible mfp.mycompany.com avec un environnement d'exécution dont le nom par défaut est mfp, exécutez
    `mfpdev app config server https://mfp.mycompany.com` et `mfpdev app config runtime mfp`.
    
4. Configurez les clés secrètes et les serveurs autorisés de votre application.
    * Si votre application implémente l'épinglage de certificat, utilisez le certificat de votre serveur cible. Pour plus d'informations sur l'épinglage de certificat, voir [Epinglage de certificat](../../authentication-and-security/certificate-pinning).
    * Si votre application iOS utilise la sécurité ATS (App Transport Security), configurez cette dernière pour votre serveur cible.
    * Pour configurer la mise à jour directe sécurisée pour une application Apache Cordova, voir [Implémentation de la mise à jour directe sécurisée côté client](../../application-development/direct-update).
    * Si vous développez votre application avec Apache Cordova, configurez la règle de sécurité CSP (Content Security Policy) de Cordova.    

5. Si vous prévoyez d'utiliser la mise à jour directe pour une application développée avec Apache Cordova, archivez les versions des plug-in Cordova que vous avez utilisés pour générer l'application.

    La mise à jour directe ne peut pas être utilisée pour mettre à jour un code natif. Si vous avez modifié une bibliothèque native ou l'un des outils de génération dans un projet Cordova et envoyé par téléchargement un tel fichier sur le serveur {{site.data.keys.mf_server }}, celui-ci détecte la différence et n'envoie aucune mise à jour pour l'application client. Les modifications apportées à la bibliothèque native peuvent inclure une autre version de Cordova, un plug-in iOS Cordova plus récent ou même un groupe de correctifs de plug-in mfpdev plus récent que celui utilisé pour générer l'application d'origine.
    
6. Configurez l'application afin de vous en servir en environnement de production.
    * Vous pouvez envisager de désactiver l'impression dans le journal de terminal.
    * Si vous prévoyez d'utiliser {{site.data.keys.mf_analytics }}, assurez-vous que votre application envoie les données collectées au serveur  {{site.data.keys.mf_server }}.
    * Envisagez de désactiver les fonctions de votre application qui appellent l'API `setServerURL`, sauf si vous prévoyez de créer une seule génération pour plusieurs serveurs de test.

7. Si vous effectuez une génération pour un serveur de production et prévoyez de distribuer l'artefact installable, archivez le code source de l'application afin de pouvoir exécuter des tests de non régression pour cette application sur un serveur de test.

    Par exemple, si par la suite vous mettez à jour un adaptateur, vous pourrez peut-être exécuter des tests de non régression sur des applications déjà distribuées qui utilisent cet adaptateur. Pour plus d'informations, voir [Déploiement ou mise à jour d'un adaptateur dans un environnement de production](#deploying-or-updating-an-adapter-to-a-production-environment).
    
8. Facultatif : Créez le fichier d'authenticité d'application pour votre application.

    Vous utilisez le fichier d'authenticité d'application après avoir enregistré l'application sur le serveur pour activer le contrôle de sécurité de l'authenticité de l'application.
    * Pour plus d'informations, voir [Activation du contrôle de sécurité de l'authenticité de l'application](../../authentication-and-security/application-authenticity).
    * Pour plus d'informations sur l'enregistrement d'une application sur un serveur de production, voir [Enregistrement d'une application sur un serveur de production](#registering-an-application-to-a-production-environment).

## Enregistrement d'une application sur un environnement de production
{: #registering-an-application-to-a-production-environment }
Lorsque vous enregistrez une application sur un serveur de production, vous envoyé par téléchargement son descripteur, vous définissez son type de licence et, le cas échéant, vous activez son authenticité.

#### Avant de commencer
{: #before-you-begin }
* Vérifiez que le magasin de clés {{site.data.keys.mf_server }} est configuré et qu'il ne s'agit pas du magasin de clés par défaut. Vous ne devez pas utiliser un serveur en production avec un magasin de clés par défaut. Le magasin de clés {{site.data.keys.mf_server }} définit l'identité des instances {{site.data.keys.mf_server }} et est utilisé pour signer numériquement les jetons OAuth et les modules de mise à jour directe. Vous devez configurer le magasin de clés du serveur avec une clé secrète avant de l'utiliser en environnement de production. Pour plus d'informations, voir [Configuration du magasin de clés {{site.data.keys.mf_server }}](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).
* Déployez les adaptateurs utilisés par l'application. Pour plus d'informations, voir [Déploiement ou mise à jour d'un adaptateur dans un environnement de production](#deploying-or-updating-an-adapter-to-a-production-environment).
* Générez l'application pour votre serveur cible. Pour plus d'informations, voir [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment).

Lorsque vous enregistrez une application auprès d'un serveur de production, vous envoyez par téléchargement son descripteur, vous définissez son type de licence et, le cas échéant, vous activez son authenticité. Vous avez également la possibilité de mettre à jour votre stratégie si une version plus ancienne de votre application est déjà déployée. Prenez soin de lire la procédure décrite ci-après afin de découvrir les principales étapes, ainsi que les méthodes permettant de les automatiser à l'aide du programme **mfpadm**.

1. Si votre serveur {{site.data.keys.mf_server }} est configuré pour l'octroi de licence de jeton, vérifiez que vous disposez de suffisamment de jetons disponibles sur le serveur de clé de licence. Pour plus d'informations, voir[Validation de licence de jeton](../license-tracking/#token-license-validation) et [Planification pour l'utilisation de l'octroi de licence de jeton](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing).

   > **Astuce :** Vous pouvez définir le type de licence de jeton de votre application avant d'enregistrer la première version de votre application. Pour plus d'informations, voir [Définition des informations de licence d'application](../license-tracking/#setting-the-application-license-information).

2. Transférez le descripteur d'application d'un serveur de test sur le serveur de production.

   Cette opération enregistre votre application sur le serveur de production et envoie par téléchargement sa configuration. Pour plus d'informations sur le transfert d'un descripteur d'application, voir [Transfert d'artefacts côté serveur vers un serveur de test ou de production](#transferring-server-side-artifacts-to-a-test-or-production-server).

3. Définissez les informations de licence d'application. Pour plus d'informations, voir [Définition des informations de licence d'application](../license-tracking/#setting-the-application-license-information).
4. Configurez le contrôle de sécurité de l'authenticité de l'application. Pour plus d'informations sur la configuration du contrôle de sécurité de l'authenticité de l'application, voir [Configuration du contrôle de sécurité de l'authenticité de l'application](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).

   > **Remarque :** Vous avez besoin du fichier binaire d'application pour créer le fichier d'authenticité de l'application. Pour plus d'informations, voir [Activation du contrôle de sécurité de l'authenticité de l'application](../../authentication-and-security/application-authenticity/#enabling-application-authenticity).

5. Si votre application utilise la notification push, envoyez par téléchargement les certificats de notification push sur le serveur. Vous pouvez envoyer par téléchargement les certificats push pour votre application à l'aide de la console {{site.data.keys.mf_console }}. Les certificats sont communs à toutes les versions d'une application.

   > **Remarque :** Vous ne pourrez peut-être pas tester la notification push pour votre application avec des certificats de production avant que votre application ne soit publiée sur le magasin.

6. Vérifiez les éléments suivants avant de publier l'application sur le magasin :
    * Testez la fonction de gestion des applications mobiles que vous prévoyez d'utiliser, telle que la désactivation d'applications distantes ou l'affichage d'un message d'administrateur. Pour plus d'informations, voir [Gestion des applications mobiles](../using-console/#mobile-application-management).
    * Dans le cas d'une mise à jour, définissez la stratégie de mise à jour. Pour plus d'informations, voir [Mise à jour d'applications {{site.data.keys.product_adj }} en production](#updating-mobilefirst-apps-in-production).

## Transfert d'artefacts côté serveur vers un serveur de test ou de production
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
Vous pouvez transférer une configuration d'application d'un serveur vers un autre à l'aide d'outils de ligne de commande ou d'une API REST.

Le fichier descripteur d'application est un fichier JSON contenant la description et la configuration de votre application. Lorsque vous exécutez une application qui se connecte à une instance {{site.data.keys.mf_server }}, l'application doit être enregistrée avec ce serveur et configurée. Une fois que vous avez défini une configuration pour votre application, vous pouvez transférer le descripteur d'application vers un autre serveur, par exemple, vers un serveur de test ou un serveur de production. Une fois le descripteur d'application transféré vers le nouveau serveur, l'application est enregistrée auprès du nouveau serveur. Différentes procédures sont disponibles selon que vous développez des applications mobiles en ayant accès au code ou que vous administrez des serveurs sans avoir accès au code de l'application mobile.

> **Important :** Si vous importez une application comprenant des données d'authenticité et si l'application proprement dite a été recompilée depuis la création des données d'authenticité, vous devez actualiser ces dernières. Pour plus d'informations, voir[Configuration du contrôle de sécurité de l'authenticité de l'application](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).

* Si vous avez accès au code de l'application mobile, utilisez les commandes `mfpdev app pull` et `mfpdev app push`.
* Si vous n'avez pas accès au code de l'application mobile, utilisez le service d'administration.

#### Accéder à
{: #jump-to-1 }

* [Transfert d'une configuration d'application à l'aide de mfpdev](#transferring-an-application-configuration-by-using-mfpdev)
* [Transfert d'une configuration d'application à l'aide du service d'administration](#transferring-an-application-configuration-with-the-administration-service)
* [Transfert d'artefacts côté serveur à l'aide de l'API REST](#transferring-server-side-artifacts-by-using-the-rest-api)
* [Exportation et importation d'applications et d'adaptateurs depuis MobileFirst Operations Console](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### Transfert d'une configuration d'application à l'aide de mfpdev
{: #transferring-an-application-configuration-by-using-mfpdev }
Après avoir développé une application, vous pouvez la transférer depuis votre environnement de développement vers un environnement de test ou de production.

* Vous devez disposer d'une application {{site.data.keys.product_adj }} sur votre ordinateur local. Cette application doit être enregistrée sur un serveur {{site.data.keys.mf_server }}. Pour toute information sur la création d'un profil de serveur, exécutez **mfpdev app register** ou consultez la rubrique relative à l'enregistrement de votre type d'application décrite dans la section Développement d'applications de cette documentation.
* Vous devez disposer d'une connectivité entre votre ordinateur local et le serveur sur lequel votre application est enregistrée et le serveur vers lequel vous souhaitez transférer votre application.
* Un profil de serveur doit exister sur l'ordinateur local à la fois pour le serveur {{site.data.keys.mf_server }} d'origine et pour le serveur vers lequel vous souhaitez transférer votre application. Pour toute information sur la création d'un profil de serveur, exécutez **mfpdev server add**.
* Vous devez avoir installé l'{{site.data.keys.mf_cli }}.

Vous utilisez la commande **mfpdev app pull** pour envoyer une copie des fichiers de configuration côté serveur pour votre application sur votre ordinateur local. Vous utilisez ensuite la commande **mfpdev app push** pour l'envoyer à un autre serveur {{site.data.keys.mf_server }}. La commande **mfpdev app push** enregistre également l'application sur le serveur spécifié.

Vous pouvez aussi utiliser ces commandes pour transférer une configuration d'exécution d'un serveur vers un autre.

Les informations de configuration incluent notamment le contenu du descripteur d'application, lequel permet d'identifier de manière unique l'application sur le serveur, ainsi que d'autres informations propres à l'application. Les fichiers de configuration sont fournis sous forme de fichiers compressés (format .zip). Les fichiers .zip sont placés dans le répertoire **appName/mobilefirst** et nommés comme suit :

```bash
appID-platform-version-artifacts.zip
```

où **appID** représente le nom de l'application, **platform** désigne **android**, **ios** ou **windows** et version correspond au niveau de version de votre application. Pour les applications Cordova, un fichier .zip distinct est créé pour chaque plateforme cible.

Lorsque vous utilisez la commande **mfpdev app push**, le fichier de propriétés client de l'application est modifié de manière à refléter le nom de profil et l'URL du nouveau serveur {{site.data.keys.mf_server }}.

1. Sur votre ordinateur de développement, accédez à un répertoire qui est le répertoire racine de votre application ou à l'un de ses sous-répertoires.
2. Exécutez la commande **mfpdev app pull**. Si vous spécifiez la commande sans paramètres, l'application est extraite du serveur {{site.data.keys.mf_server }} par défaut. Vous pouvez également spécifier un serveur spécifique et son mot de passe administrateur. Par exemple, pour une application Android nommée **myapp1** :

   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   Cette commande recherche les fichiers de configuration pour l'application en cours sur le serveur {{site.data.keys.mf_server }} dont le profil de serveur est Server10. Il envoie ensuite le fichier compressé **myapp1-android-1.0.0-artifacts.zip** contenant ces fichiers de configuration sur l'ordinateur local et le place dans le répertoire **myapp1/mobilefirst**.
    
3. Exécutez la commande **mfpdev app push**. Si vous spécifiez la commande sans paramètres, l'application est envoyée sur le serveur {{site.data.keys.mf_server }} par défaut. Vous pouvez également spécifier un serveur spécifique et son mot de passe administrateur. Par exemple, pour l'application qui a été envoyée lors de l'étape précédente : `mfpdev app push Server12 -password secretPass234!`.
    
   Cette commande envoie le fichier **myapp1-android-1.0.0-artifacts.zip** au serveur {{site.data.keys.mf_server }} dont le profil de serveur s'appelle Server12 et le mot de passe administrateur est **secretPass234!** Le fichier de propriétés client **myapp1/app/src/main/assets/mfpclient.properties** est modifié de manière à refléter le fait que le serveur sur lequel l'application est enregistrée s'appelle Server12, avec l'URL du serveur.

Les fichiers de configuration côté serveur de l'application sont présents sur le serveur {{site.data.keys.mf_server }} que vous avez spécifié dans la commande mfpdev app push. L'application est enregistrée sur ce nouveau serveur.

### Transfert d'une configuration d'application à l'aide du service d'administration
{: #transferring-an-application-configuration-with-the-administration-service }
En tant qu'administrateur, vous pouvez transférer une configuration d'application d'un serveur vers un autre à l'aide du service d'administration du serveur {{site.data.keys.mf_server }}. L'accès au code d'application n'est pas requis, mais l'application client doit être générée pour le serveur cible.

#### Avant de commencer
{: #before-you-begin-1 }
Générez l'application client pour votre serveur cible. Pour plus d'informations, voir [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment).

Envoyez par téléchargement le descripteur d'application depuis le serveur sur lequel l'application est configurée et déployez-le sur le nouveau serveur. Le descripteur d'application est visible dans la console {{site.data.keys.mf_console }}.

1. Facultatif : Examinez le descripteur d'application sur le serveur où le serveur d'applications est configuré.
    Ouvrez la console {{site.data.keys.mf_console }} pour ce serveur, sélectionnez la version de votre application et accédez à l'onglet **Fichiers de configuration**.

2. Recevez par téléchargement le descripteur d'application à partir du serveur sur lequel l'application est configurée. Vous pouvez le recevoir par téléchargement à l'aide de l'API REST ou du programme **mfpadm**.

   > **Remarque :** Vous pouvez également exporter une application ou une version d'application depuis la console {{site.data.keys.mf_console }}. Voir [Exportation et importation d'applications et d'adaptateurs depuis la console {{site.data.keys.mf_console }}](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console).
    * Pour recevoir par téléchargement le descripteur d'application à l'aide de l'API REST, utilisez l'API REST [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

    L'URL suivante renvoie le descripteur d'application pour l'application dont l'ID est **my.test.application**, pour la plateforme **ios** et la version **0.0.1**. L'appel est émis vers le serveur {{site.data.keys.mf_server }} : `http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor`
    
    Par exemple, vous pouvez utiliser une URL de ce type avec un outil tel que curl : `curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`.
    
    <br/>
    Modifiez les éléments suivants de l'URL en fonction de la configuration de votre serveur :
     * **9080** est le port HTTP par défaut du serveur {{site.data.keys.mf_server }} lors du développement.
     * **mfpadmin** est la racine de contexte par défaut du service d'administration. 

    Pour plus d'informations sur l'API REST, voir l'API REST pour le service d'administration du serveur {{site.data.keys.mf_server }}.
     * Recevez par téléchargement le descripteur d'application à l'aide du programme **mfpadm**.

       Le programme **mfpadm** est installé lorsque vous exécutez le programme d'installation du serveur {{site.data.keys.mf_server }}. Vous le démarrez à partir du répertoire **product\_install\_dir/shortcuts/**, où **product\_install\_dir** désigne le répertoire d'installation du serveur {{site.data.keys.mf_server }}.
    
       L'exemple suivant crée un fichier de mot de passe, requis par la commande **mfpadm**, puis reçoit par téléchargement le descripteur d'application de l'application dont l'ID est **my.test.application**, pour la plateforme **ios** et la version **0.0.1**. L'URL fournie est l'URL HTTPS du serveur {{site.data.keys.mf_server }} lors du développement.
    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       Modifiez les éléments suivants de la ligne de commande en fonction de la configuration de votre serveur :
        * **9443** est le port HTTPS par défaut du serveur {{site.data.keys.mf_server }} lors du développement.
        * **mfpadmin** est la racine de contexte par défaut du service d'administration. 
        * --secure false indique que le certificat SSL du serveur est accepté même s'il est auto-signé ou s'il est créé pour un nom d'hôte différent du nom d'hôte du serveur utilisé dans l'URL.

       Pour plus d'informations sur le programme **mfpadm**, voir [Administration des applications {{site.data.keys.product_adj }} via la ligne de commande](../using-cli).
    
3. Envoyez par téléchargement le descripteur d'application sur le nouveau serveur pour enregistrer l'application ou mettre à jour sa configuration.
Vous pouvez l'envoyer par téléchargement à l'aide de l'API REST ou du programme **mfpadm**.
   * Pour envoyer par téléchargement le descripteur d'application à l'aide de l'API REST, utilisez l'API REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).
    
     L'URL suivante envoie par téléchargement le descripteur d'application sur l'environnement d'exécution mfp. Vous envoyez une demande POST et le contenu est le descripteur d'application JSON. Dans cet exemple, l'appel est émis vers un serveur qui s'exécute sur l'ordinateur local et qui est configuré avec un port HTTP défini sur 9081.
    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     Par exemple, vous pouvez utiliser une URL de ce type avec un outil tel que curl.
    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * Envoyez par téléchargement le descripteur d'application à l'aide du programme mfpadm.

     L'exemple suivant crée un fichier de mot de passe, requis par la commande mfpadm, puis envoie par téléchargement le descripteur d'application de l'application dont l'ID est my.test.application, pour la plateforme ios et la version 0.0.1. L'URL fournie est l'URL HTTPS d'un serveur qui s'exécute sur l'ordinateur local mais qui est configuré avec un port HTTPS défini sur 9444 et pour un environnement d'exécution appelé mfp.

     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### Transfert d'artefacts côté serveur à l'aide de l'API REST
{: #transferring-server-side-artifacts-by-using-the-rest-api }
Quel que soit votre rôle, vous pouvez exporter des applications, des adaptateurs et des ressources à des fins de sauvegarde ou de réutilisation à l'aide du service d'administration du serveur {{site.data.keys.mf_server }}. En tant qu'administrateur ou déployeur, vous pouvez également déployer une archive d'exportation sur un autre serveur. L'accès au code d'application n'est pas requis, mais l'application client doit être générée pour le serveur cible.

#### Avant de commencer
{: #before-you-begin-2 }
Générez l'application client pour votre serveur cible. Pour plus d'informations, voir [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment).

L'API d'exportation extrait les artefacts sélectionnés pour un environnement d'exécution sous la forme d'une archive .zip. Utilisez l'API de déploiement pour réutiliser le contenu archivé.

> **Important :** Examinez attentivement votre cas d'utilisation :  
>  
> * Le fichier d'exportation inclut les données d'authenticité d'application. Ces données sont propres à la génération d'une application mobile. Celle-ci comporte l'URL du serveur et le nom de son environnement d'exécution. Par conséquent, si vous souhaitez utiliser un autre serveur ou environnement d'exécution, vous devez régénérer l'application. Si vous transférez uniquement les fichiers d'application exportés, cela ne fonctionnera pas.
> * Certains artefacts peuvent varier d'un serveur à un autre. Les données d'identification push varient selon que vous travaillez dans un environnement de développement ou de production.
> * La configuration de contexte d'exécution d'application (contenant l'état actif/désactivé et les profils de journal) peut être transférée dans certains cas, mais pas toujours.
> * Le transfert de ressources Web peut être inutile dans certains cas, par exemple, si vous régénérez l'application afin d'utiliser un nouveau serveur.

* Pour exporter toutes les ressources, ou un sous-ensemble de ressources sélectionné, pour un adaptateur ou pour tous les adaptateurs, utilisez l'API [Export adapter resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) ou [Export adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc).
* Pour exporter toutes les ressources sous un environnement d'application spécifique (par exemple, Android ou iOS), autrement dit, toutes les versions et toutes les ressources de la version de cet environnement, utilisez l'API [Export application environment (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc).
* Pour exporter toutes les ressources d'une version spécifique d'une application (par exemple, la version 1.0 ou 2.0 d'une application Android), utilisez l'API[Export application environment resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc).
* Pour exporter une application spécifique ou toutes les applications d'un environnement d'exécution, utilisez l'API [Export applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) ou [Export application resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc). **Remarque :** Les données d'identification de notification push ne sont pas exportées avec les autres ressources d'application.
* Pour exporter le contenu d'adaptateur, le descripteur, la configuration de licence, le contenu, la configuration utilisateur, le magasin de clés et les ressources Web d'une application, utilisez l'API [Export resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-).
* Pour exporter la totalité ou certaines des ressources d'un environnement d'exécution, utilisez l'API [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc). Par exemple, vous pouvez utiliser cette commande curl générale pour extraire toutes les ressources sous la forme d'un fichier .zip.

  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* Pour déployer une archive contenant des ressources d'application Web, telles qu'un adaptateur, une application, une configuration de licence, un magasin de clés, une ressource Web, utilisez l'API [Deploy (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc). Par exemple, vous pouvez utiliser cette commande curl pour déployer un fichier .zip existant contenant des artefacts.

  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* Pour déployer des données d'authenticité d'application, utilisez l'API [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).
* Pour déployer les ressources Web d'une application, utilisez l'API [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc).

Si vous déployez une archive d'exportation sur le même environnement d'exécution, l'application ou la version n'est pas nécessairement restaurée telle qu'elle a été exportée. Autrement dit, le redéploiement ne retire pas les modifications apportées ultérieurement. En revanche, si certaines ressources d'application sont modifiées entre le moment de l'exportation et celui du redéploiement, seules les ressources incluses dans l'archive exportée sont redéployées dans leur état d'origine. Par exemple, si vous exportez une application sans données d'authenticité, que vous envoyez par téléchargement des données d'authenticité, puis que vous importez l'archive initiale, les données d'authenticité ne sont pas effacées.

### Exportation et importation d'applications et d'adaptateurs depuis la console {{site.data.keys.mf_console }}
{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
Depuis la console, lorsque certaines conditions sont réunies, vous pouvez exporter une application ou l'une de ses versions, puis l'importer ultérieurement dans un autre environnement d'exécution sur le même serveur ou un autre serveur. Vous pouvez également exporter et réimporter des adaptateurs. Utilisez cette fonction à des fins de sauvegarde ou de réutilisation.

Si vous possédez le rôle d'administrateur **mfpadmin** et le rôle de déployeur **mfpdeployer**, vous pouvez exporter une version ou toutes les versions d'une application. L'application ou la version est exportée sous la forme d'un fichier compressé .zip dans lequel sont sauvegardés l'ID, les descripteurs, les données d'authenticité et les ressources Web de l'application. Vous pouvez ensuite importer l'archive afin de redéployer l'application ou la version vers un autre environnement d'exécution sur le même serveur ou un autre serveur.

> **Important :** Examinez attentivement votre cas d'utilisation :  
> 
> * Le fichier d'exportation inclut les données d'authenticité d'application. Ces données sont propres à la génération d'une application mobile. Celle-ci comporte l'URL du serveur et le nom de son environnement d'exécution. Par conséquent, si vous souhaitez utiliser un autre serveur ou environnement d'exécution, vous devez régénérer l'application. Si vous transférez uniquement les fichiers d'application exportés, cela ne fonctionnera pas.
> * Certains artefacts peuvent varier d'un serveur à un autre. Les données d'identification push varient selon que vous travaillez dans un environnement de développement ou de production.
> * La configuration de contexte d'exécution d'application (contenant l'état actif/désactivé et les profils de journal) peut être transférée dans certains cas, mais pas toujours.
> * Le transfert de ressources Web peut être inutile dans certains cas, par exemple, si vous régénérez l'application afin d'utiliser un nouveau serveur.

Vous pouvez également transférer des descripteurs d'application à l'aide de l'API REST ou de l'outil mfpadm. Pour plus d'informations, voir [Transfert d'une configuration d'application à l'aide du service d'administration](#transferring-an-application-configuration-with-the-administration-service).

1. Dans la barre latérale de navigation, sélectionnez une application, une version d'application ou un adaptateur.
2. Sélectionnez **Actions → Exporter une application** ou **Exporter une version** ou **Exporter l'adaptateur**.

    Vous êtes invité à sauvegarder le fichier archive .zip qui encapsule les ressources exportées. L'aspect de la boîte de dialogue dépend de votre navigateur et le dossier cible dépend des paramètres de votre navigateur.

3. Sauvegardez le fichier archive.

    Le nom de fichier archive inclut le nom et la version de l'application ou de l'adaptateur, par exemple, **export_applications_com.sample.zip**.

4. Pour réutiliser une archive d'exportation existante, sélectionnez **Actions → Importer une application** ou **Importer une version**, accédez à l'archive, puis cliquez sur **Déployer**.

Le panneau principal de la console affiche les détails de l'application ou de l'adaptateur importés.

Si vous effectuez une importation dans le même environnement d'exécution, l'application ou la version n'est pas nécessairement restaurée telle qu'elle a été exportée. Autrement dit, le redéploiement lors de l'importation ne retire pas les modifications apportées ultérieurement. En revanche, si certaines ressources d'application sont modifiées entre le moment de l'exportation et celui du redéploiement lors de l'importation, seules les ressources incluses dans l'archive exportée sont redéployées dans leur état d'origine. Par exemple, si vous exportez une application sans données d'authenticité, que vous envoyez par téléchargement des données d'authenticité, puis que vous importez l'archive initiale, les données d'authenticité ne sont pas effacées.

## Mise à jour d'applications {{site.data.keys.product_adj }} en production
{: #updating-mobilefirst-apps-in-production }
Il existe des instructions générales vous permettant de mettre à niveau vos applications {{site.data.keys.product_adj }} déjà en production, sur Application Center ou dans des magasins d'applications.

Lorsque vous effectuez une mise à niveau d'une application, vous pouvez déployer une nouvelle version de l'application et laisser l'ancienne version active, ou déployer une nouvelle version de l'application et bloquer l'ancienne version. Dans le cas d'une application développée avec Apache Cordova, vous pouvez également envisager de mettre à jour uniquement les ressources Web.

### Déploiement d'une nouvelle version d'application en laissant l'ancienne version active
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
Le chemin de mise à niveau le plus couramment utilisé lorsque vous ajoutez de nouvelles fonctions ou que vous modifiez le code natif consiste à mettre en production une nouvelle version de votre application. Exécutez les étapes suivantes :

1. Incrémentez le numéro de version d'application.
2. Générez et testez votre application. Pour plus d'informations, voir [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment).
3. Enregistrez l'application sur le serveur {{site.data.keys.mf_server }} et configurez-la.
4. Envoyez les nouveaux fichiers .apk, .ipa, .appx ou .xap à leurs magasins d'applications respectifs.
5. Attendez la phase d'examen et d'approbation et la mise à disposition des applications.
6. Facultatif - Envoyez un message de notification aux utilisateurs de l'ancienne version pour leur annoncer la mise sur le marché de la nouvelle version. Voir [Affichage d'un message d'administrateur](../using-console/#displaying-an-administrator-message) et  [Définition de messages d'administrateur dans plusieurs langues](../using-console/#defining-administrator-messages-in-multiple-languages).


### Déploiement d'une nouvelle version d'application en bloquant l'ancienne version
{: #deploying-a-new-app-version-and-blocking-the-old-version }
Ce chemin de mise à niveau est utilisé lorsque vous souhaitez forcer les utilisateurs à effectuer une mise à niveau vers la nouvelle version et bloquer leur accès à l'ancienne version. Exécutez les étapes suivantes :

1. Facultatif - Envoyez un message de notification aux utilisateurs de l'ancienne version pour leur annoncer qu'une mise à jour obligatoire sera disponible dans quelques jours. Voir [Affichage d'un message d'administrateur](../using-console/#displaying-an-administrator-message) et  [Définition de messages d'administrateur dans plusieurs langues](../using-console/#defining-administrator-messages-in-multiple-languages).
2. Incrémentez le numéro de version d'application.
3. Générez et testez votre application. Pour plus d'informations, voir [Génération d'une application pour un environnement de test ou de production](#building-an-application-for-a-test-or-production-environment).
4. Enregistrez l'application sur le serveur {{site.data.keys.mf_server }} et configurez-la.
5. Envoyez les nouveaux fichiers .apk, .ipa, .appx ou .xap à leurs magasins d'applications respectifs.
6. Attendez la phase d'examen et d'approbation et la mise à disposition des applications.
7. Copiez des liens vers la nouvelle version de l'application.
8. Bloquez l'ancienne version de l'application dans la console {{site.data.keys.mf_console }} en fournissant un message et établissez un lien vers la nouvelle version. Voir [Désactivation à distance de l'accès d'une application à des ressources protégées](../using-console/#remotely-disabling-application-access-to-protected-resources).

> **Remarque :** Si vous désactivez l'ancienne application, elle n'est plus en capacité de communiquer avec le serveur {{site.data.keys.mf_server }}. Les utilisateurs peuvent toujours démarrer l'application et l'utiliser en mode hors ligne sauf si vous forcez une connexion serveur lors du démarrage de l'application.

### Mise à jour directe (pas de modification de code natif)
{: #direct-update-no-native-code-changes }
La mise à jour directe est un mécanisme de mise à niveau obligatoire utilisé pour déployer des correctifs rapides sur une application de production. Lorsque vous redéployez une application sur un serveur {{site.data.keys.mf_server }} sans en modifier la version, le serveur {{site.data.keys.mf_server }} insère directement les ressources Web mises à jour sur le terminal lorsque l'utilisateur se connecte au serveur. Il n'insère pas de code natif mis à jour. Les éléments à prendre en compte lorsque vous envisagez d'effectuer une mise à jour directe sont les suivants :

1. La mise à jour directe ne met pas à jour la version de l'application. L'application ne change pas de version, mais un ensemble différent de ressources Web lui est affecté. Le numéro de version inchangé peut générer de la confusion s'il n'est pas utilisé à bon escient.
2. La mise à jour directe n'est pas non plus incluse dans le processus de révision du magasin d'applications car techniquement il ne s'agit pas d'une nouvelle édition. Cela ne doit pas se produire trop souvent car les fournisseurs peuvent être mécontents si vous déployez une toute nouvelle version de votre application en sautant leur processus de révision. Il est de votre responsabilité de lire les contrats d'utilisation de chaque magasin et de vous y conformer. La mise à jour directe est idéale pour traiter des problèmes urgents dont la résolution ne peut attendre plusieurs jours.
3. La mise à jour directe est considérée comme un mécanisme de sécurité ; par conséquent, elle est obligatoire et non facultative. Lorsque vous initiez la mise à jour directe, tous les utilisateurs doivent mettre à jour leur application pour pouvoir l'utiliser.
4. La mise à jour directe ne fonctionne pas si une application est compilée (construite) avec une autre version de {{site.data.keys.product }} que celle qui a été utilisée pour le déploiement initial.

> **Remarque :** Les fichiers archive/IPA générés à l'aide de Test Flight ou d'iTunes Connect pour la soumission/validation de magasin d'applications iOS peuvent générer une panne lors de l'exécution. Pour en savoir plus, lisez le blogue [Preparing iOS apps for App Store submission in {{site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).
