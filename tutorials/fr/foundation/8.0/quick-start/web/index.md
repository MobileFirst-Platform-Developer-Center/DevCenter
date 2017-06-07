---
layout: tutorial
title: Application Web - Démonstration de bout en bout
breadcrumb_title: Web
relevantTo: [javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Cette démonstration présente un processus complet :

1. Une application exemple fournie avec le kit SDK client {{ site.data.keys.product_adj }} est enregistrée et téléchargée à partir de la console {{ site.data.keys.mf_console }}.
2. Un nouvel adaptateur ou un adaptateur fourni est déployé sur la console {{ site.data.keys.mf_console }}.  
3. La logique d'application est changée afin d'effectuer une demande de ressource.

**Résultat final** :

* Interrogation par commande ping du serveur {{ site.data.keys.mf_server }} réussie.
* Extraction réussie des données à l'aide d'un adaptateur.

#### Prérequis :
{: #prerequisites }
* Un navigateur Web récent
* *Facultatif* - {{ site.data.keys.mf_cli }} ([téléchargement]({{site.baseurl}}/downloads))
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads))

### 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #starting-the-mobilefirst-server }
Assurez-vous d'avoir [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation), ou  
Si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), accédez au dossier du serveur puis exécutez la commande `./run.sh` sous Mac et Linux ou `run.cmd` sous Windows.

### 2. Création et enregistrement d'une application
{: #creating-and-registering-an-application }
Dans une fenêtre de navigateur, ouvrez la console {{ site.data.keys.mf_console }} en entrant l'URL `http://your-server-host:server-port/mfpconsole`. Dans le cas d'une exécution locale, entrez l'URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Le nom d'utilisateur et le mot de passe sont *admin/admin*.
 
1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**
    * Sélectionnez la plateforme **Web**
    * Entrez **com.ibm.mfpstarterweb** en tant qu'**identificateur d'application**
    * Cliquez sur **Enregistrer l'application**

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-web.png"/>
 
2. Cliquez sur le titre **Obtenir le code de démarrage** puis indiquez que vous souhaitez télécharger l'application exemple Web.

    <img class="gifplayer" alt="Téléchargement de l'application exemple" src="download-starter-code-web.png"/>
 
### 3. Edition d'une logique d'application
{: #editing-application-logic }
1. Ouvrez le projet dans l'éditeur de code de votre choix.

2. Sélectionnez le fichier **client/js/index.js** et collez le fragment de code suivant en remplaçant la fonction `WLAuthorizationManager.obtainAccessToken()` existante :

   ```javascript
   WLAuthorizationManager.obtainAccessToken()
        .then(
            function(accessToken) {
                titleText.innerHTML = "Yay!";
                statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
                
                var resourceRequest = new WLResourceRequest(
                    "/adapters/javaAdapter/resource/greet/",
                    WLResourceRequest.GET
                );
                
                resourceRequest.setQueryParameter("name", "world");
                resourceRequest.send().then(
                    function(response) {
                        // Will display "Hello world" in an alert dialog.
                        alert("Success: " + response.responseText);
                    },
                    function(response) {
                        alert("Failure: " + JSON.stringify(response));
                    }
                );
            },

            function(error) {
                titleText.innerHTML = "Bummer...";
                statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
            }
        );
   ```
    
### 4. Déploiement d'un adaptateur
{: #deploy-an-adapter }
Téléchargez [cet artefact .adapter préparé](../javaAdapter.adapter) et déployez-le à partir de la console {{ site.data.keys.mf_console }} en sélectionnant **Actions → Déployer un adaptateur**.

Vous pouvez également cliquer sur le bouton **Nouveau** en regard de la zone **Adaptateurs**.  
        
1. Sélectionnez l'option **Actions → Télécharger des exemples**. Téléchargez l'adaptateur **Java** exemple "Hello World".

   > Si Maven et {{ site.data.keys.mf_cli }} ne sont pas installés, suivez les instructions de **configuration de votre environnement de développement** s'affichant à l'écran.

2. A partir d'une fenêtre de ligne de commande****, accédez au dossier racine du projet Maven de l'adaptateur et exécutez la commande :

   ```bash
   mfpdev adapter build
   ```

3. Une fois la génération terminée, déployez-la à partir de la console {{ site.data.keys.mf_console }} en utilisant l'option **Actions → Déployer un adaptateur**. L'adaptateur est disponible dans le dossier **[adaptateur]/target**.
    
    <img class="gifplayer" alt="Déploiement d'un adaptateur" src="create-an-adapter.png"/>   


<img src="web-success.png" alt="application exemple" style="float:right"/>
### 5. Test de l'application
{: #testing-the-application }
1. A partir d'une fenêtre de ligne de commande****, accédez au dossier **[racine projet] → node-server**.
2. Exécutez la commande `npm start` pour installer la configuration Node.js requise et démarrer le serveur Node.js.
3. Ouvrez le fichier **[racine projet] → node-server → server.js** puis modifiez les variables **host** et **port** en les remplaçant par les valeurs correctes de votre serveur {{ site.data.keys.mf_server }}.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} local, les valeurs sont généralement **http**, **localhost** et **9080**.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} distant (sur Bluemix), les valeurs sont généralement **https**, **your-server-address** et **443**. 

   Exemple :  
    
   ```javascript
   var host = 'https://mobilefoundation-xxxx.mybluemix.net'; // The Mobile Foundation server address
   var port = 9081; // The local port number to use
   var mfpURL = host + ':443'; // The Mobile Foundation server port number
   ```
   
4. A partir de votre navigateur, accédez à l'URL [http://localhost:9081/home](http://localhost:9081/home).

<br>
#### Règle concernant les origines sécurisées
{: #secure-origins-policy }
Lors de l'utilisation de Chrome pendant le développement, le navigateur peut ne pas autoriser le chargement d'une application utilisant à la fois le protocole HTTP et un hôte qui n'est **pas** "localhost". Cette restriction est due à la règle des origines sécurisées implémentée et utilisée par défaut dans ce navigateur.

Pour contourner ce problème, il suffit de démarrer le navigateur Chrome en indiquant :

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- Remplacez "test-to-new-user-profile/myprofile" par l'emplacement d'un dossier qui se comportera comme un nouveau profil utilisateur Chrome afin que la commande aboutisse.

<br clear="all"/>
### Résultats
{: #results }
* Si vous cliquez sur **Ping {{ site.data.keys.mf_server }}**, la mention **Connected to {{ site.data.keys.mf_server }}** s'affiche.
* Si l'application a pu se connecter au serveur {{ site.data.keys.mf_server }}, un appel de demande de ressource utilisant l'adaptateur Java déployé aura lieu.

La réponse de l'adaptateur est ensuite affichée dans une alerte.

## Etapes suivantes
{: #next-steps }
Pour en savoir plus notamment sur l'utilisation d'adaptateurs dans des applications et sur le mode d'intégration de services supplémentaires (notifications Push, par exemple) à l'aide de l'infrastructure de sécurité {{ site.data.keys.product_adj }} :

- Consultez les tutoriels [Developing Applications](../../application-development/)
- Consultez les tutoriels [Adapters development](../../adapters/)
- Consultez les tutoriels [Authentication and security](../../authentication-and-security/)
- Consultez [tous les tutoriels](../../all-tutorials)
