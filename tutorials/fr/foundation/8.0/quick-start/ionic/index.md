---
layout: tutorial
title: Ionic - Démonstration de bout en bout
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
L'objectif de cette démonstration est de présenter un flux de bout en bout, qui comprend les étapes suivantes :

1. Une application exemple fournie avec le kit SDK client {{ site.data.keys.product_adj }} est enregistrée et téléchargée à partir de la console {{ site.data.keys.mf_console }}.
2. Un nouvel adaptateur ou un adaptateur fourni est déployé sur la console {{ site.data.keys.mf_console }}.  
3. La logique d'application est changée afin d'effectuer une demande de ressource.

**Résultat final** :

* Interroger avec succès le serveur {{ site.data.keys.mf_server }} par commande ping
* Extraire avec succès des données à l'aide d'un adaptateur

### Prérequis :
{: #prerequisites }
* Xcode for iOS, Android Studio for Android ou Visual Studio 2015 ou version ultérieure pour Windows 10 UWP
* Interface de ligne de commande Ionic
* *Facultatif* - Interface {{ site.data.keys.mf_cli }} ([téléchargement]({{site.baseurl}}/downloads)).
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads)).

### Etape 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Vérifiez que vous avez [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation) ou, si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), accédez au dossier du serveur puis exécutez la commande `./run.sh`sous Mac et Linux ou `run.cmd` sous Windows.

### Etape 2. Création et enregistrement d'une application
{: #2-creating-and-registering-an-application }
Ouvrez la console {{ site.data.keys.mf_console }} en chargeant l'URL `http://your-server-host:server-port/mfpconsole` dans un navigateur. Si le serveur s'exécute en local, utilisez `http://localhost:9080/mfpconsole`. Pour *username/password*, indiquez **admin/admin**.

1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**.
    * Sélectionnez une plateforme dans la liste suivante : **Android, iOS, Windows, Browser**
    * Entrez **com.ibm.mfpstarterionic** comme **Identificateur d'application**.
    * Entrez **1.0.0** pour **Version**.
    * Cliquez sur **Enregistrer l'application**.

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-ionic.png"/>

2. Téléchargez le modèle d'application Ionic à partir de [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic).

### Etape 3. Ajout du SDK MobileFirst dans l'application Ionic
{: #adding_mfp_ionic_sdk}

Suivez les étapes ci-dessous pour ajouter le SDK MobileFirst Ionic au modèle d'application Ionic téléchargé.

1. Accédez à la racine du projet Ionic existant et ajoutez le plug-in {{ site.data.keys.product_adj }} Ionic Cordova de base.

2. Accédez à la racine du projet Ionic : `cd MFPStarterIonic`

3. Ajoutez les plug-in MobileFirst à l'aide de la commande de l'interface de ligne de commande Ionic : `ionic cordova plugin add cordova-plugin-name` Par exemple :

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > La commande ci-dessus ajoute MobileFirst Core SDK Plugin au projet Ionic.

4. Ajoutez une ou plusieurs plateformes prises en charge au projet Cordova à l'aide de la commande de l'interface de ligne de commande Ionic : `ionic cordova platform add ios|android|windows|browser`. Exemple :

   ```bash
   cordova platform add ios
   ```

5. Préparez les ressources de l'application en exécutant la `commande ionic cordova prepare` :

   ```bash
   ionic cordova prepare
   ```

### Etape 4. Edition de la logique de l'application
{: #3-editing-application-logic }
1. Ouvrez le projet Ionic dans l'éditeur de code de votre choix.

2. Sélectionnez le fichier **src/js/index.js** et collez le fragment de code suivant en remplaçant la fonction `WLAuthorizationManager.obtainAccessToken()` existante :

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                (response) => {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                (error) => {
                    alert("Failure: " + JSON.stringify(error));
                }
            );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### Etape 5. Déploiement d'un adaptateur
{: #4-deploy-an-adapter }
Téléchargez cet [artefact .adapter](../javaAdapter.adapter) et déployez-le à partir de la console {{ site.data.keys.mf_console }} à l'aide de l'action **Actions → Déployer un adaptateur**.

Vous pouvez également cliquer sur le bouton **Nouveau** en regard de la zone **Adaptateurs**.  

1. Sélectionnez l'option **Actions → Télécharger des exemples**. Téléchargez l'adaptateur **Java** exemple *Hello World*.

    >Si Maven et {{ site.data.keys.mf_cli }} ne sont pas installés, suivez les instructions de **configuration de votre environnement de développement** s'affichant à l'écran.

2. A partir d'une fenêtre de ligne de commande****, accédez au dossier racine du projet Maven de l'adaptateur et exécutez la commande :

    ```bash
    mfpdev adapter build
    ```

3. Une fois la génération terminée, déployez-la à partir de la console {{ site.data.keys.mf_console }} en utilisant l'option **Actions → Déployer un adaptateur**. L'adaptateur est disponible dans le dossier **[adaptateur]/target**.

    <img class="gifplayer" alt="Déploiement d'un adaptateur" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="modèle d'application" style="float:right"/>

### Etape 6. Test de l'application
{: #5-testing-the-application }
1. A partir d'une fenêtre de ligne de commande****, accédez au dossier racine du projet Cordova.
2. Exécutez la commande `ionic cordova platform add ios|android|windows|browser` pour ajouter une plateforme.
3. Dans le projet Ionic, sélectionnez le fichier **config.xml** et éditez la valeur `<mfp:server ... url=" "/>` avec les propriétés **protocol**, **host** et **port** en indiquant les valeurs correctes de votre serveur {{ site.data.keys.mf_server }}.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} local, les valeurs sont généralement **http**, **localhost** et **9080**.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} distant (sur IBM Cloud), les valeurs sont généralement **https**, **your-server-address** et **443**.
    * Si vous utilisez un cluster Kubernetes sur IBM Cloud Private et si le déploiement est de type **NodePort**, la valeur du port est généralement celle de **NodePort** exposée par le service dans le cluster Kubernetes.

    Par ailleurs, si vous avez installé l'interface {{ site.data.keys.mf_cli }}, accédez au dossier racine du projet puis exécutez la commande `mfpdev app register`. Si un serveur {{ site.data.keys.mf_server }} distant est utilisé, [exécutez la commande](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)
    ```bash
    mfpdev server add
    ```
     pour ajouter le serveur, puis exécutez la commande suivante pour enregistrer l'application, par exemple :
    ```bash
    mfpdev app register myIBMCloudServer
    ```

Si un appareil est connecté, l'application est installée et exécutée sur ce dernier.
Sinon, le simulateur ou l'émulateur est utilisé.

<br clear="all"/>
### Résultats
{: #results }
* Cliquez sur le bouton **Ping {{ site.data.keys.mf_server }}** pour afficher la mention **Connected to {{ site.data.keys.mf_server }}**.
* Si l'application a pu se connecter au serveur {{ site.data.keys.mf_server }}, un appel de demande de ressource utilisant l'adaptateur Java déployé est effectué. La réponse de l'adaptateur est ensuite affichée dans une alerte.

## Etapes suivantes
{: #next-steps }
Pour en savoir plus notamment sur l'utilisation d'adaptateurs dans des applications et sur le mode d'intégration de services supplémentaires (notifications Push, par exemple) à l'aide de l'infrastructure de sécurité {{ site.data.keys.product_adj }} :

- Consultez les tutoriels [Developing Applications](../../application-development/)
- Consultez les tutoriels [Adapters development](../../adapters/)
- Consultez les tutoriels [Authentication and security](../../authentication-and-security/)
- Consultez les tutoriels [Notifications](../../notifications/)
- Consultez [tous les tutoriels](../../all-tutorials)
