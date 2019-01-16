---
layout: tutorial
title: React Native - Démonstration de bout en bout
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
L'objectif de cette démonstration est de présenter un flux de bout en bout :

1. Une application exemple fournie avec le kit SDK client {{ site.data.keys.product_adj }} est enregistrée et téléchargée à partir de la console {{ site.data.keys.mf_console }}.
2. Un nouvel adaptateur ou un adaptateur fourni est déployé sur la console {{ site.data.keys.mf_console }}.  
3. La logique d'application est changée afin d'effectuer une demande de ressource.

**Résultat final** :

* Interroger avec succès le serveur {{ site.data.keys.mf_server }} par commande ping
* Extraire avec succès des données à l'aide d'un adaptateur

### Prérequis :
{: #prerequisites }
* Xcode for iOS, Android Studio for Android
* Interface de ligne de commande React Native
* *Facultatif* - {{ site.data.keys.mf_cli }}  ([téléchargement]({{site.baseurl}}/downloads))
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads))

### Etape 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Vérifiez que vous avez [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation) ou, si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), accédez au dossier du serveur puis exécutez la commande `./run.sh`sous Mac et Linux ou `run.cmd` sous Windows.

### Etape 2. Création et enregistrement d'une application
{: #2-creating-and-registering-an-application }
Ouvrez la console {{ site.data.keys.mf_console }} en chargeant l'URL `http://your-server-host:server-port/mfpconsole` dans le navigateur. Si le serveur s'exécute en local, utilisez `http://localhost:9080/mfpconsole`. Pour
*username/password*, indiquez **admin/admin**.

1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**.
    * Sélectionnez une plateforme : **Android, iOS**.
    * Entrez **com.ibm.mfpstarter.reactnative** comme **Identificateur d'application**.
    * Entrez **1.0.0** pour **Version**.
    * Cliquez sur **Enregistrer l'application**.

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-reactnative.png"/>

2. Téléchargez le modèle d'application React Native à partir de [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative).

### Etape 3. Edition de la logique de l'application
{: #3-editing-application-logic }
1. Ouvrez le projet React Native dans l'éditeur de code de votre choix.

2. Sélectionnez le fichier **app.js** qui se trouve à la racine du projet et collez le fragment de code suivant en remplaçant la fonction `WLAuthorizationManager.obtainAccessToken()` existante :

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
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
        alert("Failed to connect to MobileFirst Server");
      });
```

### Etape 4. Déploiement d'un adaptateur
{: #4-deploy-an-adapter }
Téléchargez l'[artefact .adapter](../javaAdapter.adapter) et déployez-le à partir de la console {{ site.data.keys.mf_console }} à l'aide de l'action **Actions → Déployer un adaptateur**.

Vous pouvez également cliquer sur le bouton **Nouveau** en regard de la zone **Adaptateurs**.  

1. Sélectionnez l'option **Actions → Télécharger des exemples**. Téléchargez l'adaptateur **Java** exemple *Hello World*.

    >Si Maven et {{ site.data.keys.mf_cli }} ne sont pas installés, suivez les instructions de **configuration de votre environnement de développement** s'affichant à l'écran.

2. A partir d'une fenêtre de ligne de commande****, accédez au dossier racine du projet Maven de l'adaptateur et exécutez la commande :

    ```bash
    mfpdev adapter build
    ```

3. Une fois la génération terminée, déployez-la à partir de la console {{ site.data.keys.mf_console }} en utilisant l'option **Actions → Déployer un adaptateur**. L'adaptateur est disponible dans le dossier **[adaptateur]/target**.

    <img class="gifplayer" alt="Déploiement d'un adaptateur" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="modèle d'application" style="float:right"/>

### Etape 5. Test de l'application
{: #5-testing-the-application }
1.  Vérifiez que vous avez installé l'interface {{ site.data.keys.mf_cli }}, accédez au dossier racine de la plateforme spécifique (iOS ou Android) et exécutez la commande `mfpdev app register`. Si un serveur {{ site.data.keys.mf_server }} distant est utilisé, [exécutez la commande](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) pour ajouter le serveur :
```bash
mfpdev server add
```
puis exécutez la commande suivante pour enregistrer l'application, par exemple :
```bash
mfpdev app register myIBMCloudServer
```
2. Exécutez les commandes suivantes pour exécuter l'application :
```bash
react-native run-ios|run-android
```

Si un appareil est connecté, l'application est installée et exécutée sur ce dernier. Sinon, le simulateur ou l'émulateur est utilisé.

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
