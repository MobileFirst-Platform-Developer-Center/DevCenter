---
layout: tutorial
title: Exécution d'IBM Installation Manager
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
IBM Installation Manager installe les fichiers et les outils de {{site.data.keys.mf_server_full }} sur votre ordinateur. 

Vous exécutez Installation Manager pour installer les fichiers binaires de {{site.data.keys.mf_server }} et les outils pour déployer les applications {{site.data.keys.mf_server }} sur un serveur d'applications sur votre ordinateur. Les fichiers et les outils installés par le programme d'installation sont décrits dans la rubrique [Structure de distribution de {{site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server).

IBM Installation Manager version 1.8.4 ou ultérieure est requis pour exécuter le programme d'installation de {{site.data.keys.mf_server }}. Vous pouvez l'exécuter en mode graphique ou en mode de ligne de commande.   
Deux options principales sont proposées lors du processus d'installation :

* Activation de l'octroi de licence de jeton
* Installation et déploiement d'{{site.data.keys.mf_app_center }}

### Octroi de licence de jeton
{: #token-licensing }
L'octroi de licence de jeton est l'une des méthodes d'octroi de licence prises en charge par {{site.data.keys.mf_server }}. Vous devez déterminer si vous avez besoin d'activer ou non l'octroi de licence de jeton. Si vous ne disposez pas d'un contrat définissant l'utilisation de l'octroi de licence de jeton avec Rational License Key Server, vous n'avez pas besoin d'activer l'octroi de licence de jeton. Si vous activez cette option, vous devez configurer {{site.data.keys.mf_server }} pour l'octroi de licence de jeton. Pour plus d'informations, voir[Installation et configuration pour l'octroi de licence de jeton](../token-licensing).

### {{site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center est un composant de {{site.data.keys.product }}. Avec Application Center, vous pouvez partager des applications mobiles en cours de développement au sein de votre organisation dans un unique référentiel d'applications mobiles.


Si vous choisissez d'installer Application Center à l'aide d'Installation Manager, vous devez définir les paramètres de base de données et de serveur d'applications de sorte qu'Installation Manager puisse configurer les bases de données et déployer Application Center sur le serveur d'applications. Si vous choisissez de ne pas installer Application Center à l'aide d'Installation Manager, ce dernier sauvegarde le fichier WAR et les ressources d'Application Center sur votre disque. Il ne configure pas les bases de données et ne déploie pas le fichier WAR d'Application Center sur votre serveur d'applications. Vous pourrez effectuer ce opérations ultérieurement à l'aide de tâches Ant ou manuellement. L'option d'installation d'Application Center est un excellent moyen de découvrir ce composant car vous êtes assisté par un assistant graphique lors du processus d'installation. 

Toutefois, dans le cadre d'une installation pour un environnement de production, utilisez des tâches Ant pour installer Application Center. L'installation à l'aide de tâches Ant vous permet de découpler les mises à jour sur {{site.data.keys.mf_server }} à partir des mises à jour apportées à Application Center.

* Avantage lié à l'installation d'Application Center à l'aide d'Installation Manager.
    * Un assistant graphique vous guide lors du processus d'installation et de déploiement. 
* Inconvénients liés à l'installation d'Application Center à l'aide d'Installation Manager.
    * Si Installation Manager est exécuté à l'aide du superutilisateur sous UNIX ou Linux, il peut créer des fichiers appartenant au superutilisateur dans le répertoire du serveur d'applications sur lequel Application Center est déployé. Par conséquent, vous devez exécuter le serveur d'applications en tant que superutilisateur. 
    * Vous n'avez pas accès aux scripts de base de données et vous ne pouvez les fournir à votre administrateur de base de données pour créer les tables avant d'exécuter la procédure d'installation. Installation Manager crée les tables de base de données pour vous avec des paramètres par défaut. 
    * Chaque fois que vous effectuez une mise à niveau du produit, par exemple, pour installer un correctif temporaire, Application Center est mis à niveau en premier. La mise à niveau d'Application Center comprend des opérations sur la base de données et le serveur d'applications. Si la mise à niveau d'Application Center échoue, Installation Manager ne peut pas terminer la mise à niveau, et cela vous empêche d'effectuer la mise à niveau d'autres composants {{site.data.keys.mf_server }}. Pour une installation dans un environnement de production, vous ne devez pas déployer Application Center à l'aide d'Installation Manager. Installez Application Center séparément à l'aide de tâches Ant après qu'Installation Manager a installé {{site.data.keys.mf_server }}. Pour plus d'informations sur Application Center, voir [Installation et configuration d'Application Center](../../../appcenter).

> **Important : **Le programme d'installation de {{site.data.keys.mf_server }} installe uniquement les fichiers binaires et les outils de {{site.data.keys.mf_server }} sur votre disque. Il ne déploie pas les applications {{site.data.keys.mf_server }} sur votre serveur d'applications. Après avoir exécuté l'installation à l'aide d'Installation Manager, vous devez configurer les bases de données et déployer les applications {{site.data.keys.mf_server }} sur votre serveur d'applications.   
> De même, lorsque vous exécutez Installation Manager pour mettre à jour une installation existante, seuls les fichiers présents sur votre disque sont mis à jour. Vous devez effectuer d'autres actions pour mettre à jour les applications qui sont déployées sur vos serveurs d'applications.

#### Accéder à
{: #jump-to }
* [Mode administrateur et mode utilisateur](#administrator-versus-user-mode)
* [Installation à l'aide de l'assistant d'installation d'IBM Installation Manager](#installing-by-using-ibm-installation-manager-install-wizard)
* [Installation en exécutant IBM Installation Manager en ligne de commande](#installing-by-running-ibm-installation-manager-in-command-line)
* [Installation à l'aide de fichiers de réponses XML (installation en mode silencieux)](#installing-by-using-xml-response-files---silent-installation)
* [Structure de distribution de {{site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server)

## Mode administrateur et mode utilisateur
{: #administrator-versus-user-mode }
Vous pouvez installer {{site.data.keys.mf_server }} dans deux modes IBM Installation Manager distincts. Ce mode varie en fonction de la façon dont IBM Installation Manager est lui-même installé. Le mode détermine les répertoires et les commandes que vous utilisez pour Installation Manager et pour les packages.

{{site.data.keys.product }} prend en charge les deux modes Installation Manager suivants : 

* Mode administrateur
* Mode utilisateur (non administrateur)

Le mode groupe disponible sur Linux ou UNIX n'est pas pris en charge par le produit. 

### Mode administrateur
{: #administrator-mode }
En mode administrateur, Installation Manager doit être exécuté en tant que superutilisateur sous Linux ou UNIX, et avec des privilèges d'administrateur sous Windows. Les fichiers référentiel d'Installation Manager (liste des logiciels installés accompagnés de leur version) sont installés dans un répertoire système. /var/ibm sous Linux ou UNIX, ou ProgramData sous Windows. Ne déployez pas Application Center à l'aide d'Installation Manager si vous exécutez ce dernier en mode administrateur. 

### Mode utilisateur (non administrateur)
{: #user-nonadministrator-mode }
En mode utilisateur, Installation Manager peut être exécuté par n'importe quel utilisateur sans aucun privilège spécifique. Toutefois, les fichiers référentiel d'Installation Manager sont stockés dans le répertoire de base de l'utilisateur. Seul cet utilisateur peut effectuer la mise à niveau d'une installation du produit.
Si vous n'exécutez pas Installation Manager en tant que superutilisateur, vous devez disposer d'un compte utilisateur que vous utiliserez ultérieurement pour effectuer la mise à niveau de l'installation du produit ou appliquer un correctif temporaire. 

Pour plus d'informations sur les modes Installation Manager, voir [Installation en tant qu'administrateur, non-administrateur ou groupe](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc) dans la documentation d'IBM Installation Manager. 

## Installation à l'aide de l'assistant d'installation d'IBM Installation Manager
{: #installing-by-using-ibm-installation-manager-install-wizard }
Suivez la procédure décrite ci-après pour installer les ressources de {{site.data.keys.mf_server }} et les outils (par exemple, l'outil de configuration de serveur, les tâches Ant et le programme mfpadm).   
Les décisions dans les deux panneaux suivants de l'assistant d'installation sont obligatoires :

* Panneau **Paramètres généraux**.
* Panneau **Choisir la configuration** pour installer Application Center

1. Lancez Installation Manager.
2. Ajoutez le référentiel de {{site.data.keys.mf_server }} dans Installation Manager.
    * Accédez à **Fichier → Préférences** et cliquez sur **Ajouter des référentiels...**.
    * Recherchez le fichier référentiel dans le répertoire où le programme d'installation a été extrait. 

        Si vous décompressez le fichier {{site.data.keys.product }} V8.0 .zip pour {{site.data.keys.mf_server }} dans le dossier **mfp\_installer\_directory**, le fichier référentiel se trouve dans **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        Vous souhaiterez peut-être appliquer le dernier groupe de correctifs que vous pouvez télécharger à partir du [portail de support IBM](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). Prenez soin d'entrer le référentiel pour le groupe de correctifs. Si vous décompressez le groupe de correctifs dans le dossier **fixpack_directory**, le fichier référentiel se trouve dans **fixpack\_directory/MobileFirst\_Platform\_Server/d le /diskTag.inf**.

        **Remarque :** Vous ne pouvez pas installer le groupe de correctifs sans le référentiel de la version de base dans les référentiels d'Installation Manager. Les groupes de correctifs sont des programmes d'installation incrémentiels et nécessitent que le référentiel de la version de base soit installé.
    * Sélectionnez le fichier, puis cliquez sur **OK**. 
    * Cliquez sur **OK** pour fermer le panneau **Préférences**. 
3. Après avoir accepté les dispositions du contrat de licence du produit, cliquez sur **Suivant**.
4. Choisissez le groupe de packages pour installer le produit. 

    {{site.data.keys.product }} V8.0 remplace les éditions précédentes dont le nom d'installation est différent :
    * Worklight for V5.0.6
    * IBM Worklight for V6.0 vers V6.3
    
    Si l'une de ces anciennes versions du produit est installée sur votre ordinateur, Installation Manager vous offre une option vous permettant d'utiliser un groupe de packages existant au début du processus d'installation. Cette option désinstalle votre ancienne version du produit et réutilise vos options d'installation précédentes pour mettre à niveau {{site.data.keys.mf_app_center_full }} si ce composant a été installé. 
    
    Pour une installation distincte, sélectionnez l'option permettant de créer un nouveau groupe de packages afin de pouvoir installer la nouvelle version et l'ancienne version côte à côte.   
    Si aucune autre version du produit n'est installée sur votre ordinateur, choisissez l'option permettant de créer un nouveau groupe de packages afin de pouvoir installer le produit dans un nouveau groupe de packages. 
    
5. Cliquez sur **Suivant**. 
6. Décidez si l'octroi de licence de jeton doit être ou non activé dans la section **Activer l'octroi de licence de jeton** du panneau **Paramètres généraux**. 

Si vous disposez d'un contrat d'utilisation de l'octroi de licence de jeton avec Rational License Key Server, sélectionnez l'option **Activer l'octroi de licence de jeton avec Rational License Key Server**. Après avoir activé l'octroi de licence de jeton, vous devez exécuter des étapes supplémentaires pour configurer {{site.data.keys.mf_server }}. Sinon, sélectionnez l'option **Ne pas activer l'octroi de licence de jeton avec Rational License Key Server** pour continuer.
7. Conservez l'option par défaut (Non) dans la section **Installer {{site.data.keys.product }} for iOS** du panneau **Paramètres généraux**. 
8. Indiquez dans le panneau **Choisir la configuration** si Application Center doit être installé. 

    Dans le cadre d'une installation pour un environnement de production, utilisez des tâches Ant pour installer Application Center. L'installation à l'aide de tâches Ant vous permet de découpler les mises à jour sur {{site.data.keys.mf_server }} à partir des mises à jour apportées à Application Center. Dans ce cas, sélectionnez l'option Non dans le panneau Choisir la configuration de sorte qu'Application Center ne soit pas installé. 

    Si vous sélectionnez Oui, vous devez, à l'aide des panneaux suivants, entrer les détails relatifs à la base de données que vous prévoyez d'utiliser et au serveur d'applications sur lequel vous prévoyez de déployer Application Center. Vous devez également disposer du pilote JDBC correspondant à votre base de données.
9. Cliquez sur **Suivant** jusqu'à ce que vous ayez atteint le panneau **Merci**. Ensuite, poursuivez l'installation. 

Un répertoire d'installation contenant les ressources nécessaires pour installer les composants {{site.data.keys.product_adj }} est installé. 

Ces ressources figurent dans les dossiers suivants :

* Dossier **MobileFirstServer** pour {{site.data.keys.mf_server }}
* Dossier **PushService** pour le service push de {{site.data.keys.mf_server }}
* Dossier **ApplicationCenter** pour Application Center
* Dossier **Analytics** pour {{site.data.keys.mf_analytics }}

En outre, le dossier **shortcuts** contient des raccourcis pour l'outil de configuration de serveur, les tâches Ant et le programme mfpadm. 

## Installation en exécutant IBM Installation Manager en ligne de commande
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. Passez en revue le contrat de licence de {{site.data.keys.mf_server }}. Vous pouvez visualiser les fichiers de licence lorsque vous téléchargez le référentiel d'installation à partir de Passport Advantage. 
2. Décompressez dans un dossier le fichier compressé du référentiel de {{site.data.keys.mf_server }} que vous avez téléchargé. 

    Vous pouvez télécharger le référentiel à partir de {{site.data.keys.product }} eAssembly sur le site [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). Le nom du package est **IBM MobileFirst Foundation V{{site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**.

    Dans les étapes décrites ci-après, le répertoire dans lequel vous décompressez le programme d'installation s'appelle **mfp\_repository\_dir**. Il contient un dossier **MobileFirst\_Platform\_Server/disk1**.
3. Démarrez une session de ligne de commande et accédez à **installation\_manager\_install\_dir/tools/eclipse/**.

    Si vous acceptez les dispositions du contrat de licence que vous avez passé en revue à l'étape 1, vous pouvez installer {{site.data.keys.mf_server }}.
    * Pour une installation sans application de l'octroi de licence de jeton (si vous ne disposez pas d'un contrat définissant l'utilisation de l'octroi de licence de jeton), entrez la commande suivante : 

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * Pour une installation avec application de l'octroi de licence de jeton, entrez la commande suivante :
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        La valeur de la propriété **user.licensed.by.tokens** est **true**. Vous devez configurer {{site.data.keys.mf_server }} pour l'[octroi de licence de jeton](../token-licensing).
        
        Les propriétés suivantes permettent d'installer {{site.data.keys.mf_server }} sans Application Center :
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        Cette propriété indique si l'octroi de licence de jeton est activé ou non : **user.licensed.by.tokens=true/false**.
        
        Affectez la valeur false à la propriété user.use.ios.edition pour installer {{site.data.keys.product }}.
        
5. Si vous souhaitez effectuer une installation avec le dernier correctif temporaire, ajoutez le référentiel de correctif temporaire au paramètre **-repositories**. Le paramètre **-repositories** accepte une liste de référentiels séparés par des virgules. 

    Ajoutez la version du correctif temporaire en remplaçant **com.ibm.mobilefirst.foundation.server** par **com.ibm.mobilefirst.foundation.server_version**. Le format de **version** est **8.0.0.0-buildNumber**. Par exemple, si vous installez le correctif temporaire **8.0.0.0-IF20160103101**5, entrez la commande suivante : `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`.
    
    Pour plus d'informations sur la commande imcl, voir [Installation Manager : Installation de packages via les commandes `imcl`](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en).
    
Un répertoire d'installation contenant les ressources nécessaires pour installer les composants {{site.data.keys.product_adj }} est installé. 

Ces ressources figurent dans les dossiers suivants :

* Dossier **MobileFirstServer** pour {{site.data.keys.mf_server }}
* Dossier **PushService** pour le service push de {{site.data.keys.mf_server }}
* Dossier **ApplicationCenter** pour Application Center
* Dossier **Analytics** pour {{site.data.keys.mf_analytics }}    

En outre, le dossier **shortcuts** contient des raccourcis pour l'outil de configuration de serveur, les tâches Ant et le programme mfpadm. 

## Installation à l'aide de fichiers de réponses XML (installation en mode silencieux)
{: #installing-by-using-xml-response-files---silent-installation }
Si vous souhaitez installer {{site.data.keys.mf_app_center_full }} à l'aide d'IBM Installation Manager en ligne de commande, vous devez fournir une grande liste d'arguments. Dans ce cas, utilisez les fichiers de réponses XML pour fournir ces arguments. 

Les installations en mode silencieux sont définies par un fichier XML appelé fichier de réponses. Ce fichier contient les données nécessaires pour exécuter les opérations d'installation en mode silencieux. Les installations en mode silencieux sont lancées à partir de la ligne de commande ou d'un fichier de commandes. 

Vous pouvez utiliser Installation Manager pour enregistrer des préférences et des actions d'installation pour votre fichier de réponses en mode interface utilisateur. Sinon, vous pouvez créer manuellement un fichier de réponses
à l'aide de la liste répertoriant les commandes et les préférences du fichier de réponses.  

L'installation en mode silencieux est décrite dans la documentation utilisation d'Installation Manager. Voir[Travail en mode silencieux](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html).

Deux méthodes permettent de créer un fichier de réponses adapté :

* Utilisation d'exemples de fichier de réponses fournis dans la documentation utilisateur de {{site.data.keys.product_adj }}. 
* Utilisation d'un fichier de réponses enregistré sur un autre ordinateur.

Ces deux méthodes sont documentées dans les sections suivantes :

### Utilisation d'exemples de fichier de réponses pour IBM Installation Manager
{: #working-with-sample-response-files-for-ibm-installation-manager }
Des exemples de fichier de réponses pour IBM Installation Manager sont fournis dans le fichier compressé **Silent\_Install\_Sample_Files.zip**. Les procédures décrites ci-après expliquent comment les utiliser. 

1. Choisissez l'exemple de fichier de réponses approprié dans le fichier compressé. Le fichier Silent_Install_Sample_Files.zip contient un sous-répertoire par édition. 

    > **Important :**  
    > 
    > * Pour une installation qui n'installe pas Application Center sur un serveur d'applications, utilisez le fichier nommé **install-no-appcenter.xml**.
    > * Pour une installation qui installe Application Center, choisissez l'exemple de fichier de réponses dans le tableau suivant, en fonction de votre serveur d'applications et de votre base de données.
   #### Exemples de fichier de réponses d'installation contenus dans le fichier **Silent\_Install\_Sample_Files.zip** permettant d'installer Application Center
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Serveur d'applications où vous installez Application Center</th>
            <th>Derby</th>
            <th>IBM DB2</th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Profil Liberty de WebSphere Application Server</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (See Note)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Profil complet de WebSphere Application Server, serveur autonome</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (voir Remarque)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>Non applicable</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (voir Remarque), install-wasnd-server-mysql.xml (voir Remarque), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml (voir Remarque)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>
    
    > **Remarque :** L'utilisation de MySQL conjointement avec le profil Liberty de WebSphere Application Server ou le profil complet de WebSphere Application Server n'est pas considérée comme une configuration prise en charge. Pour plus d'informations, voir [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Vous pouvez utiliser IBM DB2 ou un autre système de gestion de base de données qui est pris en charge par WebSphere Application Server afin de bénéficier d'une configuration entièrement prise en charge par le support IBM.
    Pour la désinstallation, utilisez un exemple de fichier qui dépend de la version de {{site.data.keys.mf_server }} ou de Worklight Server que vous avez initialement installé dans le groupe de packages spécifique : 
    
    * {{site.data.keys.mf_server }} utilise le groupe de packages {{site.data.keys.mf_server }}.
    * Worklight Server V6.x, ou version ultérieure, utilise le groupe de packages IBM Worklight.
    * Worklight Server V5.x utilise le groupe de packages Worklight.

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Version initiale de {{site.data.keys.mf_server }}</th>
            <th>Exemple de fichier</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server V6.x ou version ultérieure</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. Changez les droits d'accès à l'exemple de fichier pour qu'ils soient aussi restrictifs que possible. L'étape 4 requiert l'indication de mots de passe. Si vous devez empêcher d'autres utilisateurs sur le même ordinateur de prendre connaissance de ces mots de passe,
vous devez retirer les droits d'accès en lecture au fichier pour ces autres utilisateurs. Vous pouvez utiliser une commande, comme
dans les exemples suivants :
    * Sous UNIX : `chmod 600 <target-file.xml>`
    * Sous Windows: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. De même, si le serveur est un profil Liberty de WebSphere Application Server ou un serveur Apache Tomcat destiné à être démarré uniquement depuis votre compte utilisateur, vous devez également retirer les droits d'accès en lecture pour les autres utilisateurs dans le fichier suivant :
    * Pour le profil Liberty de WebSphere Application Server : `wlp/usr/servers/<server>/server.xml`
    * Pour Apache Tomcat : `conf/server.xml`
4. Ajustez la liste de référentiels dans l'élément <server>. Pour plus d'informations sur cette étape, voir la documentation d'IBM Installation Manager dans [Référentiels](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html).

    Dans l'élément `<profile>`, ajustez les valeurs de chaque paire clé-valeur.   
    Dans l'élément `<offering>` de l'élément `<install>`, définissez l'attribut de version de sorte qu'il corresponde à l'édition que vous souhaitez installer ou retirez l'attribut de version si vous souhaitez installer la dernière version disponible dans les référentiels.
5. Tapez la commande suivante : `<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    Où : 
    * `<InstallationManagerPath>` est le répertoire d'installation d'IBM Installation Manager.
    * `<responseFile>` est le nom du fichier que vous avez sélectionné et mis à jour à l'étape 1. 

> Pour plus d'informations, voir la documentation d'IBM Installation Manager dans [Installation d'un package en mode silencieux avec un fichier de réponses](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).
    

### Utilisation d'un fichier de réponses enregistré sur un autre ordinateur
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. Enregistrez un fichier de réponses en exécutant IBM Installation Manager en mode assistant et avec l'option `-record responseFile` sur une machine sur laquelle une interface graphique est disponible. Pour obtenir des détails, reportez-vous à
[Enregistrement d'un fichier de réponses avec Installation Manager](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html).
 
2. Changez les droits d'accès à l'exemple de fichier de réponses pour qu'ils soient aussi restrictifs que possible. L'étape 4 requiert l'indication de mots de passe. Si vous devez empêcher d'autres utilisateurs sur le même ordinateur de prendre connaissance de ces mots de passe,
vous devez retirer les droits d'accès en lecture (**read**) au fichier pour ces autres utilisateurs. Vous pouvez utiliser une commande, comme
dans les exemples suivants :
    * Sous UNIX : `chmod 600 response-file.xml`
    * Sous Windows : `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. De même, si le serveur est un profil Liberty de WebSphere Application Server ou un serveur Apache Tomcat destiné à être démarré uniquement depuis votre compte utilisateur, vous devez également retirer les droits d'accès en lecture pour les autres utilisateurs dans le fichier suivant :
    * Pour WebSphere Application Server Liberty : `wlp/usr/servers/<server>/server.xml`
    * Pour Apache Tomcat : `conf/server.xml`
4. Modifiez le fichier de réponses de manière à tenir compte des différences entre la machine sur laquelle le fichier de réponses a été créé et la machine cible. 
5. Installez {{site.data.keys.mf_server }} en utilisant le fichier de réponses de la machine cible, comme indiqué dans [Installation d'un package en mode silencieux avec un fichier de réponses](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).

### Paramètres de ligne de commande (installation en mode silencieux)
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>Libellé</th>
        <th>Nécessaire ?</th>
        <th>Description</th>
        <th>Valeurs autorisées</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>Toujours</td>
        <td>Indiquez la valeur <code>false</code> si vous prévoyez d'installer {{site.data.keys.product }}. Si vous prévoyez d'installer le produit pour l'édition iOS, vous devez indiquer la valeur <code>true</code>.</td>
        <td><code>true</code> ou <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>Toujours</td>
        <td>Activation de l'octroi de licence de jeton. Si vous prévoyez d'utiliser le produit avec Rational License Key Server, vous devez activer l'octroi de licence de jeton.<br/><br/>Dans ce cas, indiquez la valeur <code>true</code>. Si vous ne prévoyez pas d'utiliser le produit avec Rational License Key Server, indiquez la valeur <code>false</code>.<br/><br/>Si vous activez des jetons de licence, des étapes de configuration spécifiques sont requises après le déploiement du produit sur un serveur d'applications. </td>
        <td><code>true</code> ou <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>Toujours</td>
        <td>Type de serveur d'applications. was désigne le produit WebSphere Application Server 8.5.5 préinstallé. tomcat désigne Tomcat 7.0.</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Répertoire d'installation de WebSphere Application Server.</td>
        <td>Nom de répertoire absolu. </td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Profil dans lequel installer les applications. Pour WebSphere Application Server Network Deployment, spécifiez le profil Deployment Manager. Liberty désigne le profil Liberty (sous-répertoire wlp).</td>
        <td>Nom des profils WebSphere Application Server. </td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Cellule WebSphere Application Server dans laquelle installer les applications.</td>
        <td>Nom de la cellule WebSphere Application Server. </td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Noeud WebSphere Application Server dans lequel installer les applications. Cela correspond à la machine en cours. </td>
        <td>Nom du noeud WebSphere Application Server de la machine en cours. </td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Type d'ensemble de serveurs dans lequel installer les applications.<br/><br/><code>server</code> désigne un serveur autonome.<br/><br/><code>nd-cell</code> désigne une cellule WebSphere Application Server Network Deployment. <code>nd-cluster</code> désigne un cluster WebSphere Application Server Network Deployment.<br/><br/><code>nd-node</code> désigne un noeud WebSphere Application Server Network Deployment (clusters existants).<br/><br/><code>nd-server</code> désigne un serveur WebSphere Application Server Network Deployment géré. </td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == server</td>
      <td>Nom d'un serveur WebSphere Application Server dans lequel installer les applications.</td>
      <td>Nom d'un serveur WebSphere Application Server sur la machine en cours. </td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-cluster</td>
      <td>Nom du cluster WebSphere Application Server Network Deployment dans lequel installer les applications.</td>
      <td>Nom d'un cluster WebSphere Application Server Network Deployment dans la cellule WebSphere Application Server. </td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope} == nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>Nom du noeud WebSphere Application Server Network Deployment dans lequel installer les applications.</td>
      <td>Nom d'un noeud WebSphere Application Server Network Deployment dans la cellule WebSphere Application Server. </td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-server</td>
      <td>Nom d'un serveur WebSphere Application Server Network Deployment dans lequel installer les applications.</td>
      <td>Nom d'un serveur WebSphere Application Server Network Deployment dans le noeud WebSphere Application Server Network Deployment donné. </td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Nom de l'administrateur WebSphere Application Server. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Mot de passe de l'administrateur WebSphere Application Server, éventuellement chiffré d'une manière spécifique. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Mot de passe de l'utilisateur <code>appcenteradmin</code> à ajouter à la liste d'utilisateurs WebSphere Application Server, éventuellement chiffré d'une manière spécifique. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Suffixe qui distingue les applications à installer des autres installations de {{site.data.keys.mf_server }}.</td>
      <td>Chaîne de 10 décimaux. </td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} == Liberty</td>
      <td>Nom du serveur WebSphere Application Server Liberty dans lequel installer les applications.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Répertoire d'installation d'Apache Tomcat. Pour une installation Tomcat répartie dans un répertoire <b>CATALINA_HOME</b> et un répertoire <b>CATALINA_BASE</b>, vous devez spécifier la valeur de la variable d'environnement <b>CATALINA_BASE</b>. </td>
      <td>Nom de répertoire absolu. </td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>Toujours</td>
      <td>Type de système de gestion de base de données utilisé pour stocker les bases de données. </td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. La valeur none signifie que le programme d'installation n'installera pas Application Center. Si cette valeur est utilisée, <b>user.appserver.selection2</b> et <b>user.database.selection2</b> doivent prendre la valeur none.</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>Toujours</td>
      <td><code>true</code> désigne un système de gestion de base de données préinstallé, <code>false</code> désigne la base de données Apache Derby à installer. </td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>Répertoire dans lequel créer ou considérer que se trouvent les bases de données Derby. </td>
      <td>Nom de répertoire absolu. </td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>Nom d'hôte ou adresse IP du serveur de base de données DB2. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>Port sur lequel le serveur de base de données DB2 écoute les connexions JDBC. Généralement, 50000.</td>
      <td>Nombre compris entre 1 et 65535.</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>Nom de fichier absolu de db2jcc4.jar.</td>
      <td>Nom de fichier absolu. </td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>Nom d'utilisateur permettant d'accéder à la base de données DB2 pour Application Center.</td>
      <td>Non vide.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>Mot de passe permettant d'accéder à la base de données DB2 pour Application Center, éventuellement chiffré d'une manière spécifique.</td>
      <td>Mot de passe non vide.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>Nom de la base de données DB2 pour Application Center.</td>
      <td>Non vide ; nom de base de données DB2 valide. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Facultatif</td>
      <td>Indique si <b>user.database.mysql.appcenter.dbname</b> est un nom de service ou un nom SID. Si le paramètre est absent, <b>user.database.mysql.appcenter.dbname</b> est considéré comme un nom SID. </td>
      <td><code>true</code> (indique un nom de service) ou <code>false</code> (indique un nom SID)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>Nom du schéma d'Application Center dans la base de données DB2. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Nom d'hôte ou adresse IP du serveur de base de données MySQL. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Port sur lequel le serveur de base de données MySQL écoute les connexions JDBC. Généralement, 3306.</td>
      <td>Nombre compris entre 1 et 65535.</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Nom de fichier absolu de <b>mysql-connector-java-5.*-bin.jar</b>.</td>
      <td>Nom de fichier absolu. </td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Nom d'utilisateur permettant d'accéder à la base de données Oracle pour Application Center.</td>
      <td>Chaîne composée de 1 à 30 caractères : les chiffres ASCII, les lettres ASCII en majuscules et en minuscules et les caractères '_', '#', '$' sont admis. </td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Mot de passe permettant d'accéder à la base de données Oracle pour Application Center, éventuellement chiffré d'une manière spécifique.</td>
      <td>Le mot de passe doit être une chaîne composée de 1 à 30 caractères : les chiffres ASCII, les lettres ASCII en majuscules et en minuscules et les caractères '_', '#', '$' sont admis. </td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, sauf si ${user.database.oracle.appcenter.jdbc.url} est spécifié</td>
      <td>Nom de la base de données Oracle pour Application Center.</td>
      <td>Non vide ; nom de base de données Oracle valide. </td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle, sauf si ${user.database.oracle.appcenter.jdbc.url} est spécifié</td>
      <td>Nom d'hôte ou adresse IP du serveur de base de données Oracle. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle, sauf si ${user.database.oracle.appcenter.jdbc.url} est spécifié</td>
      <td>Port sur lequel le serveur de base de données Oracle écoute les connexions JDBC. Généralement, 1521.</td>
      <td>Nombre compris entre 1 et 65535.</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Nom de fichier absolu du fichier JAR du pilote JDBC fin d'Oracle. (<b>ojdbc6.jar ou ojdbc7.jar</b>)</td>
      <td>Nom de fichier absolu. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Nom d'utilisateur permettant d'accéder à la base de données Oracle pour Application Center.</td>
      <td>Chaîne composée de 1 à 30 caractères : les chiffres ASCII, les lettres ASCII en majuscules et en minuscules et les caractères '_', '#', '$' sont admis. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>Nom d'utilisateur permettant d'accéder à la base de données Oracle pour Application Center, spécifié dans une syntaxe appropriée pour JDBC.</td>
      <td>Identique à ${user.database.oracle.appcenter.username} s'il commence par un caractère alphabétique et ne contient pas de caractères en minuscules, sinon, il doit s'agir de ${user.database.oracle.appcenter.username} placé entre guillemets. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Mot de passe permettant d'accéder à la base de données Oracle pour Application Center, éventuellement chiffré d'une manière spécifique.</td>
      <td>Le mot de passe doit être une chaîne composée de 1 à 30 caractères : les chiffres ASCII, les lettres ASCII en majuscules et en minuscules et les caractères '_', '#', '$' sont admis. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, sauf si ${user.database.oracle.appcenter.jdbc.url} est spécifié</td>
      <td>Nom de la base de données Oracle pour Application Center.</td>
      <td>Non vide ; nom de base de données Oracle valide. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Facultatif</td>
      <td>Indique si <code>user.database.oracle.appcenter.dbname</code> est un nom de service ou un nom SID. Si le paramètre est absent, <code>user.database.oracle.appcenter.dbname</code> est considéré comme un nom SID. </td>
      <td><code>true</code> (indique un nom de service) ou <code>false</code> (indique un nom SID)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle, sauf si ${user.database.oracle.host}, ${user.database.oracle.port}, ${user.database.oracle.appcenter.dbname} sont tous spécifiés.</td>
      <td>URL JDBC de la base de données Oracle pour Application Center.</td>
      <td>URL JDBC Oracle valide. Commence par "jdbc:oracle:".</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>Toujours</td>
      <td>Utilisateur du système d'exploitation autorisé à exécuter le serveur installé. </td>
      <td>Nom d'utilisateur du système d'exploitation, ou vide.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>Toujours</td>
      <td>Groupe d'utilisateurs du système d'exploitation autorisé à exécuter le serveur installé. </td>
      <td>Nom du groupe d'utilisateurs du système d'exploitation, ou vide.</td>
    </tr>
</table>

## Structure de distribution de {{site.data.keys.mf_server }}
{: #distribution-structure-of-mobilefirst-server }
Les fichiers et les outils de {{site.data.keys.mf_server }} sont installés dans le répertoire d'installation de {{site.data.keys.mf_server }}. 

#### Fichiers et sous-répertoires du sous-répertoire d'Analytics
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| Elément | Description |
|------|-------------|
| **analytics.ear** et **analytics-*.war** | Fichiers EAR et WAR permettant d'installer {{site.data.keys.mf_analytics }}. |
| **configuration-samples** | Contient les exemples de fichier Ant permettant d'installer {{site.data.keys.mf_analytics }} à l'aide de tâches Ant. |

#### Fichiers et sous-répertoires du sous-répertoire d'Application Center
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| Elément | Description |
|------|-------------|
| **configuration-samples** | Contient les exemples de fichier Ant permettant d'installer Application Center. Les tâches Ant créent la table de base de données et déploient les fichiers WAR sur un serveur d'applications.  | 
| **console** | Contient les fichiers EAR et WAR permettant d'installer Application Center. Le fichier EAR concerne uniquement IBM PureApplication System. | 
| **databases** | Contient les scripts SQL à utiliser pour créer manuellement les tables destinées à Application Center. |
| **installer** | Contient les ressources permettant de créer le client Application Center.  | 
| **tools** | Outils d'Application Center. | 

#### Fichiers et sous-répertoires du sous-répertoire de {{site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| Elément | Description |
|------|-------------|
| **mfp-ant-deployer.jar** | Ensemble de tâches Ant pour {{site.data.keys.mf_server }}.  |
| **mfp-*.war** | Fichiers WAR des composants {{site.data.keys.mf_server }}. |
| **configuration-samples** | Contient les exemples de fichier Ant permettant d'installer les composants {{site.data.keys.mf_server }} à l'aide de tâches Ant. | 
| **ConfigurationTool** | Contient les fichiers binaires de l'outil de configuration de serveur. L'outil est lancé à partir de **rép_install_serbeur_mfp/shortcuts**. |
| **databases** | Contient les scripts SQL à utiliser pour créer manuellement les tables destinées aux composants {{site.data.keys.mf_server }} (service d'administration de {{site.data.keys.mf_server }}, service de configuration de {{site.data.keys.mf_server }} et environnement d'exécution de {{site.data.keys.product_adj }}).  | 
| **external-server-libraries** |  Contient les fichiers JAR utilisés par différents outils (par exemple, l'outil d'authenticité et l'outil de sécurité OAuth).  |

#### Fichiers et sous-répertoires du sous-répertoire du service push
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| Elément | Description |
|------|-------------|
| **mfp-push-service.war** | Fichier WAR permettant d'installer le service push de {{site.data.keys.mf_server }}.  |
| **databases** | Contient les scripts SQL à utiliser pour créer manuellement les tables destinées au service push de {{site.data.keys.mf_server }}.  | 

#### Fichiers et sous-répertoires du sous-répertoire de licences
{: #files-and-subdirectories-in-the-license-subdirectory }

| Elément | Description |
|------|-------------|
| **Text** | Contient la licence de {{site.data.keys.product }}. | 

#### Fichiers et sous-répertoire du répertoire d'installation de {{site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| Elément | Description |
|------|-------------|
| **shortcuts** | Scripts de programme de lancement pour Apache Ant, l'outil de configuration de serveur et la commande mfpadmin, fournis avec {{site.data.keys.mf_server }}. | 

#### Fichiers et sous-répertoire du sous-répertoire d'outils
{: #files-and-subdirectories-in-the-tools-subdirectory }

| Elément | Description |
|------|-------------|
| **tools/apache-ant-version-number** | Installation binaire d'Apache Ant utilisée par l'outil de configuration de serveur. Peut également être utilisée pour exécuter les tâches Ant.  | 
