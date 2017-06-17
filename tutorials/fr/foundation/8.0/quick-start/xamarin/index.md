---
layout: tutorial
title: Xamarin - Démonstration de bout en bout
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Cette démonstration présente un processus complet :

1. Une application exemple fournie avec le kit SDK client Xamarin {{ site.data.keys.product_adj }} est enregistrée auprès de la console {{ site.data.keys.mf_console }}.
2. Un nouvel adaptateur ou un adaptateur fourni est déployé sur la console {{ site.data.keys.mf_console }}.  
3. La logique d'application est changée afin d'effectuer une demande de ressource.

**Résultat final** :

* Interrogation par commande ping du serveur {{ site.data.keys.mf_server }} réussie.

#### Prérequis :
{: #prerequisites }
* Xamarin Studio
* *Facultatif* - Serveur {{ site.data.keys.mf_server }} autonome ([téléchargement]({{site.baseurl}}/downloads))

### 1. Démarrage du serveur {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Assurez-vous d'avoir [créé une instance Mobile Foundation](../../bluemix/using-mobile-foundation), ou  
Si vous utilisez le kit [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/), accédez au dossier du serveur puis exécutez la commande `./run.sh` sous Mac et Linux ou `run.cmd` sous Windows.

### 2. Création d'une application
{: #2-creating-an-application }
Dans une fenêtre de navigateur, ouvrez la console {{ site.data.keys.mf_console }} en entrant l'URL `http://your-server-host:server-port/mfpconsole`. Dans le cas d'une exécution locale, entrez l'URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Le nom d'utilisateur et le mot de passe sont *admin/admin*.

1. Cliquez sur le bouton **Nouveau** en regard de l'option **Applications**
    * Sélectionnez la plateforme **Android**
    * Entrez **com.ibm.mfpstarterxamarin** en tant qu'**identificateur d'application** (en fonction de la structure d'applications téléchargée à l'étape suivante)
    * Entrez **1.0** dans la zone **Version**
    * Cliquez sur **Enregistrer l'application**

    <img class="gifplayer" alt="Enregistrement d'une application" src="register-an-application-xamarin.gif"/>

### 3. Edition d'une logique d'application
{: #3-editing-application-logic }
* Créez un projet Xamarin.
* Ajoutez le kit SDK Xamarin en suivant les instructions du tutoriel [Adding the SDK](../../application-development/sdk/xamarin/).
* Ajoutez une propriété de type `IWorklightClient` dans un fichier classe, comme présenté ci-dessous.

   ```csharp
   /// <summary>
   /// Gets or sets the worklight sample client.
   /// </summary>
   /// <value>The worklight client.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* Si vous effectuez le développement pour une utilisation sous iOS, collez le code suivant dans la méthode **FinishedLaunching** du fichier **AppDelegate.cs** :

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance();
  ```
  >Remplacez `<ClassName>` par le nom de votre classe.
* Si vous effectuez le développement pour une utilisation sous Android, incluez la ligne de code suivante dans la méthode **OnCreate** du fichier **MainActivity.cs** :

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance(this);
  ```
  >Remplacez `<ClassName>` par le nom de votre classe.
* Définissez une méthode afin d'obtenir le jeton d'accès et d'effectuer une demande de ressource auprès du serveur MFP, de la manière suivante.

    ```csharp
    public async void ObtainToken()
           {
            try
                   {

                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");

                       if (accessToken.Value != null && accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");

                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();

                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```

* Appelez la méthode **ObtainToken** dans un constructeur de classe ou en cliquant sur un bouton.

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

<!-- <img src="device-screen.png" alt="sample app" style="float:right"/>-->
### 5. Test de l'application
{: #5-testing-the-application }
1. Dans Xamarin Studio, sélectionnez le fichier **mfpclient.plist** puis modifiez les propriétés **protocol**, **host** et **port** en indiquant les valeurs correctes de votre serveur {{ site.data.keys.mf_server }}.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} local, les valeurs sont généralement **http**, **localhost** et **9080**.
    * Si vous utilisez un serveur {{ site.data.keys.mf_server }} distant (sur Bluemix), les valeurs sont généralement **https**, **your-server-address** et **443**.

2. Appuyez sur le bouton **Play**.

<br clear="all"/>
### Résultats
{: #results }
* Si vous cliquez sur **Ping MobileFirst Server**, la mention **Connected to MobileFirst Server**.
* Si l'application a pu se connecter au serveur {{ site.data.keys.mf_server }}, un appel de demande de ressource utilisant l'adaptateur Java déployé aura lieu.

La réponse de l'adaptateur s'affiche alors dans la console Xamarin Studio Console.

![Image de l'application ayant appelé une ressource à partir du serveur {{ site.data.keys.mf_server }}](console-output.png)

## Etapes suivantes
{: #next-steps }
Pour en savoir plus notamment sur l'utilisation d'adaptateurs dans des applications et sur le mode d'intégration de services supplémentaires (notifications Push, par exemple) à l'aide de l'infrastructure de sécurité {{ site.data.keys.product_adj }} :

- Consultez les tutoriels [Adapters development](../../adapters/)
- Consultez les tutoriels [Authentication and security](../../authentication-and-security/)
- Consultez [tous les tutoriels](../../all-tutorials)
