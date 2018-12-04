---
layout: tutorial
title: Windows 8.1 Universal et Windows 10 UWP  - Démonstration de bout en bout
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
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
* Visual Studio 2013/5 configuré
* *Facultatif* - {{ site.data.keys.mf_cli }}  ([téléchargement]({{site.baseurl}}/downloads))
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads))

### 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Assurez-vous d'avoir [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation), ou  
Si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), accédez au dossier du serveur et exécutez la commande `./run.cmd`.

### 2. Création d'une application
{: #2-creating-an-application }
Dans une fenêtre de navigateur, ouvrez la console {{ site.data.keys.mf_console }} en entrant l'URL `http://your-server-host:server-port/mfpconsole`. Dans le cas d'une exécution locale, entrez l'URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Le nom d'utilisateur et le mot de passe sont *admin/admin*.

1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**
    * Sélectionnez une plateforme **Windows**
    * Entrez **MFPStarterCSharp.Windows** en tant qu'**identificateur d'application** pour Windows ou **MFPStarterCSharp.WindowsPhone** pour Windows Phone
    * Entrez **1.0.0** dans la zone **Version**
    * Cliquez sur **Enregistrer l'application**

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-windows.png"/>

2. Cliquez sur le titre **Obtenir le code de démarrage** puis indiquez que vous souhaitez télécharger l'application exemple Windows 8.1 ou Windows 10.

    <img class="gifplayer" alt="Téléchargement d'une application exemple" src="download-starter-code-windows.png"/>

### 3. Edition d'une logique d'application
{: #3-editing-application-logic }
1. Ouvrez le projet Visual Studio.

2. Sélectionnez le fichier **MainPage.xaml.cs** de la solution et collez le fragment de code suivant dans la méthode GetAccessToken() :

   ```csharp
   try
                   {
          IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken &&  accessToken.Value != null &&  accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. Déploiement d'un adaptateur
{: 4-deploy-an-adapter }
Téléchargez [cet artefact .adapter préparé](../javaAdapter.adapter) et déployez-le à partir de la console {{ site.data.keys.mf_console }} en sélectionnant **Actions → Déployer un adaptateur**.

<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="application exemple" style="float:right"/>
### 5. Test de l'application
{: 5-testing-the-application }
1. Dans Visual Studio, sélectionnez le fichier **mfpclient.resw** puis modifiez les propriétés **protocol**, **host** et **port** en indiquant les valeurs correctes de votre serveur {{ site.data.keys.mf_server }}.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} local, les valeurs sont généralement **http**, **localhost** et **9080**.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} distant (sur IBM Cloud), les valeurs sont généralement **https**, **your-server-address** et **443**.
    * Si vous utilisez un cluster Kubernetes sur IBM Cloud Private et si le déploiement est de type **NodePort**, la valeur du port est généralement celle de **NodePort** exposée par le service dans le cluster Kubernetes.

    Par ailleurs, si vous avez installé l'interface {{ site.data.keys.mf_cli }}, accédez au dossier racine du projet puis exécutez la commande `mfpdev app register`. Si un serveur {{ site.data.keys.mf_server }} distant est utilisé, [exécutez la commande `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) pour ajouter le serveur, suivi par exemple de la commande `mfpdev app register myIBMCloudServer`.
    
2. Cliquez sur le bouton **Run App**.

### Résultats
{: #results }
* Si vous cliquez sur **Ping {{ site.data.keys.mf_server }}**, la mention **Connected to {{ site.data.keys.mf_server }}** s'affiche.
* Si l'application a pu se connecter au serveur {{ site.data.keys.mf_server }}, un appel de demande de ressource utilisant l'adaptateur Java déployé aura lieu.

La réponse de l'adaptateur est ensuite envoyée dans la console de sortie de Visual Studio.

![Image de l'application ayant appelé avec succès une ressource de {{ site.data.keys.mf_server }}](success_response.png)

## Etapes suivantes
{: #next-steps }
Pour en savoir plus notamment sur l'utilisation d'adaptateurs dans des applications et sur le mode d'intégration de services supplémentaires (notifications Push, par exemple) à l'aide de l'infrastructure de sécurité {{ site.data.keys.product_adj }} :

- Consultez les tutoriels [Developing Applications](../../application-development/)
- Consultez les tutoriels [Adapters development](../../adapters/)
- Consultez les tutoriels [Authentication and security](../../authentication-and-security/)
- Consultez les tutoriels [Notifications](../../notifications/)
- Consultez [tous les tutoriels](../../all-tutorials)
