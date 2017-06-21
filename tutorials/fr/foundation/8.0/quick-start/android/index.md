---
layout: tutorial
title: Android - Démonstration de bout en bout
breadcrumb_title: Android
relevantTo: [android]
weight: 3
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
* Android Studio
* *Facultatif* - {{ site.data.keys.mf_cli }} ([téléchargement]({{site.baseurl}}/downloads))
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads))

### 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Assurez-vous d'avoir [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation), ou  
Si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), accédez au dossier du serveur puis exécutez la commande `./run.sh` sous Mac et Linux ou `run.cmd` sous Windows.

### 2. Création d'une application
{: #2-creating-an-application }
Dans une fenêtre de navigateur, ouvrez la console {{ site.data.keys.mf_console }} en entrant l'URL `http://your-server-host:server-port/mfpconsole`. Dans le cas d'une exécution locale, entrez l'URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Le nom d'utilisateur et le mot de passe sont *admin/admin*.
 
1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**
    * Sélectionnez la plateforme **Android**
    * Entrez **com.ibm.mfpstarterandroid** en tant qu'**identificateur d'application**
    * Entrez **1.0** dans la zone **Version**
    * Cliquez sur **Enregistrer l'application**

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-android.png"/>
 
2. Cliquez sur le titre **Obtenir le code de démarrage** puis indiquez que vous souhaitez télécharger l'application exemple Android.

    <img class="gifplayer" alt="Téléchargement d'application exemple" src="download-starter-code-android.png"/>

### 3. Edition d'une logique d'application
{: #3-editing-application-logic }
1. Ouvrez le projet Android Studio puis importez le projet.

2. A partir du menu de la barre latérale **Project**, sélectionnez le fichier **app → java → com.ibm.mfpstarterandroid → ServerConnectActivity.java** et :

* Ajoutez les importations suivantes :

  ```java
  import java.net.URI;
  import java.net.URISyntaxException;
  import android.util.Log;
  ```
    
* Collez le fragment de code suivant, en remplaçant l'appel `WLAuthorizationManager.getInstance().obtainAccessToken` :

  ```java
  WLAuthorizationManager.getInstance().obtainAccessToken("", new WLAccessTokenListener() {
                @Override
                public void onSuccess(AccessToken token) {
                    System.out.println("Received the following access token value: " + token);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Yay!");
                            connectionStatusLabel.setText("Connected to {{ site.data.keys.mf_server }}");
                        }
                    });

                    URI adapterPath = null;
                    try {
                        adapterPath = new URI("/adapters/javaAdapter/resource/greet");
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }

                    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
                    
                    request.setQueryParameter("name","world");
                    request.send(new WLResponseListener() {
                        @Override
                        public void onSuccess(WLResponse wlResponse) {
                            // Will print "Hello world" in LogCat.
                            Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
                        }

                        @Override
                        public void onFailure(WLFailResponse wlFailResponse) {
                            Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
                        }
                    });
                }

                @Override
                public void onFailure(WLFailResponse wlFailResponse) {
                    System.out.println("Did not receive an access token from server: " + wlFailResponse.getErrorMsg());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Bummer...");
                            connectionStatusLabel.setText("Failed to connect to {{ site.data.keys.mf_server }}");
                        }
                    });
                }
            });
  ```

### 4. Déploiement d'un adaptateur
{: #4-deploy-an-adapter }
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

<img src="androidQuickStart.png" alt="application exemple" style="float:right"/>
### 5. Test de l'application
{: #5-testing-the-application }

1. Dans Android Studio, à partir du menu latéral **Project**, sélectionnez le fichier **app → src → main →assets → mfpclient.properties** puis modifiez les propriétés **protocol**, **host** et **port** en indiquant les valeurs correctes de votre serveur {{ site.data.keys.mf_server }}.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} local, les valeurs sont généralement **http**, **localhost** et **9080**.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} distant (sur Bluemix), les valeurs sont généralement **https**, **your-server-address** et **443**.

    Par ailleurs, si vous avez installé l'interface {{ site.data.keys.mf_cli }}, accédez au dossier racine du projet puis exécutez la commande `mfpdev app register`. Si un serveur {{ site.data.keys.mf_server }} distant est utilisé, [exécutez la commande `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) pour ajouter le serveur, suivi par exemple de la commande `mfpdev app register myBluemixServer`.

2. Cliquez sur le bouton **Run App**.  

<br clear="all"/>
### Résultats
{: #results }
* Si vous cliquez sur **Ping {{ site.data.keys.mf_server }}**, la mention **Connected to {{ site.data.keys.mf_server }}** s'affiche.
* Si l'application a pu se connecter au serveur {{ site.data.keys.mf_server }}, un appel de demande de ressource utilisant l'adaptateur Java déployé aura lieu.

La réponse s'affiche ensuite dans la vue LogCat d'Android Studio.

![Image de l'application ayant appelé une ressource à partir du serveur {{ site.data.keys.mf_server }}](success_response.png)

## Etapes suivantes
{: #next-steps }
Pour en savoir plus notamment sur l'utilisation d'adaptateurs dans des applications et sur le mode d'intégration de services supplémentaires (notifications Push, par exemple) à l'aide de l'infrastructure de sécurité {{ site.data.keys.product_adj }} :

- Consultez les tutoriels [Developing Applications](../../application-development/)
- Consultez les tutoriels [Adapters development](../../adapters/)
- Consultez les tutoriels [Authentication and security](../../authentication-and-security/)
- Consultez les tutoriels [Notifications](../../notifications/)
- Consultez [tous les tutoriels](../../all-tutorials)
