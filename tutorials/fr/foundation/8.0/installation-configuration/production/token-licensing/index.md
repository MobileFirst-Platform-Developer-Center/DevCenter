---
layout: tutorial
title: Installation et configuration pour l'octroi de licence de jeton
breadcrumb_title: Token licensing
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Si vous prévoyez d'utiliser l'octroi de licence de jeton pour {{ site.data.keys.mf_server }}, vous devez installer la bibliothèque Rational Common Licensing et configurer votre serveur d'applications pour connecter {{ site.data.keys.mf_server }} à Rational License Key Server.

Les rubriques ci-après décrivent la présentation de l'installation, l'installation manuelle de la bibliothèque Rational Common Licensing, la configuration du serveur d'applications et les limitations propres aux plateformes pour l'octroi de licence de jeton.

#### Aller à
{: #jump-to }

* [Planification pour l'utilisation de l'octroi de licence de jeton](#planning-for-the-use-of-token-licensing)
* [Présentation de l'installation pour l'octroi de licence de jeton](#installation-overview-for-token-licensing)
* [Connexion du serveur {{ site.data.keys.mf_server }} installé sur Apache Tomcat à Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Connexion du serveur {{ site.data.keys.mf_server }} installé sur le profil Liberty de WebSphere Application Server Liberty à Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Connexion du serveur {{ site.data.keys.mf_server }} installé sur WebSphere Application Server à Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Limitations des plateformes prises en charge pour l'octroi de licence de jeton](#limitations-of-supported-platforms-for-token-licensing)
* [Traitement des incidents liés à l'octroi de licence de jeton](#troubleshooting-token-licensing-problems)

## Planification pour l'utilisation de l'octroi de licence de jeton
{: #planning-for-the-use-of-token-licensing }
Si la fonction d'octroi de licence de jeton est achetée pour {{ site.data.keys.mf_server }}, des étapes supplémentaires sont à prévoir dans la planification de l'installation.

### Restrictions techniques
{: #technical-restrictions }
Voici les restrictions techniques relatives à l'utilisation de l'octroi de licence de jeton :

#### Plateformes prises en charge :
{: #supported-platforms }
Les plateformes qui prennent en charge l'octroi de licence de jeton sont répertoriées dans [Limitations des plateformes prises en charge pour l'octroi de licence de jeton](#limitations-of-supported-platforms-for-token-licensing). L'installation et la configuration de l'octroi de licence de jeton sur le serveur {{ site.data.keys.mf_server }} qui s'exécute sur une plateforme non répertoriée peuvent s'avérer impossibles. Les bibliothèques natives pour le client Rational Common Licensing peuvent ne pas être disponibles pour la plateforme ou non prises en charge.

#### Topologies prises en charge :
{: #supported-topologies }
Les topologies prises en charge par la fonction d'octroi de licence de jeton sont répertoriées dans [Contraintes sur le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }} ](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime).

### Exigences relatives au réseau
{: #network-requirement }
{{ site.data.keys.mf_server }} doit être capable de communiquer avec Rational License Key Server.

Cette communication nécessite l'accès aux deux ports suivants sur le serveur de licences :

* Port (**lmgrd**) de démon de gestionnaire de licence - le numéro de port par défaut est 27000.
* Port (**ibmratl**) de démon de fournisseur
 
Pour configurer les ports de sorte qu'ils utilisent des valeurs statiques, voir la rubrique How to serve a license key to client machines through a firewall.

### Processus d'installation
{: #installation-process }
Vous devez activer l'octroi de licence de jeton lorsque vous exécutez IBM Installation Manager lors de l'installation. Pour plus d'informations sur l'activation de l'octroi de licence de jeton, voir [Présentation de l'installation pour l'octroi de licence de jeton](#installation-overview-for-token-licensing).

Une fois que {{ site.data.keys.mf_server }} est installé, vous devez le configurer manuellement pour l'octroi de licence de jeton. Pour plus d'informations, voir les rubriques suivantes de cette section.

{{ site.data.keys.mf_server }} n'est pas fonctionnel tant que vous n'avez pas terminé cette configuration manuelle. La bibliothèque client Rational Common Licensing doit être installée dans votre serveur d'applications et vous devez définir l'emplacement de Rational License Key Server.

### Opérations
{: #operations }
Une fois que vous avez installé et configuré IBM {{ site.data.keys.mf_server }} pour l'octroi de licence de jeton, le serveur valide des licences dans différents scénarios. Pour plus d'informations sur l'extraction de jetons lors d'opérations, voir [Validation de licence de jeton](../../../administering-apps/license-tracking/#token-license-validation).

Si vous devez tester une application hors production sur un serveur de production avec l'octroi de licence de jeton activé, vous pouvez déclarer cette application comme une application hors production. Pour plus d'informations sur la déclaration du type d'application, voir [Définition des informations de licence d'application](../../../administering-apps/license-tracking/#setting-the-application-license-information).

## Présentation de l'installation pour l'octroi de licence de jeton
{: #installation-overview-for-token-licensing }
Si vous prévoyez d'utiliser l'octroi de licence de jeton avec {{ site.data.keys.product }}, prenez soin d'exécuter les étapes préliminaires ci-après dans l'ordre indiqué.

> **Important :** Votre décision concernant l'activation ou non de l'octroi de licence de jeton dans le cadre d'une installation qui prend en charge l'octroi de licence de jeton ne peut pas être modifiée. Si vous devez modifier ultérieurement l'option d'octroi de licence de jeton, vous devrez désinstaller {{ site.data.keys.product }}, puis le réinstaller.

1. Activez l'octroi de licence de jeton lorsque vous exécutez IBM Installation Manager pour installer {{ site.data.keys.product }}.

   #### Installation en mode graphique
   Si vous installez le produit en mode graphique, sélectionnez l'option **Activer l'octroi de licence de jeton avec Rational License Key Server** dans le panneau **Paramètres généraux** lors de l'installation.
    
   ![Activation de licence de jeton dans le gestionnaire d'installation IBM](licensing_with_tokens_activate.jpg)
    
   #### Installation en mode de ligne de commande
   Si vous effectuez l'installation en mode silencieux, affectez la valeur **true** au paramètre **user.licensed.by.tokens** dans le fichier de réponses.  
   Par exemple, vous pouvez utiliser :
    
   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```
    
2. Déployez {{ site.data.keys.mf_server }} sur un serveur d'applications une fois l'installation du produit terminée. Pour plus d'informations, voir
[Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](../appserver).

3. Configurez {{ site.data.keys.mf_server }} pour l'octroi de licence de jeton. Les étapes dépendent de votre serveur d'applications.

* Pour le profil Liberty de WebSphere Application Server, voir [Connexion du serveur {{ site.data.keys.mf_server }} installé sur le profil Liberty de WebSphere Application Server à Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server).
* Pour Apache Tomcat, voir [Connexion du serveur {{ site.data.keys.mf_server }} installé sur Apache Tomcat à Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* Pour le profil complet de WebSphere Application Server, voir [Connexion du serveur {{ site.data.keys.mf_server }} installé sur WebSphere Application Server à Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server).

## Connexion du serveur {{ site.data.keys.mf_server }} installé sur Apache Tomcat à Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
Vous devez installer les bibliothèques Java et natives Rational Common Licensing sur le serveur d'applications Apache Tomcat avant de pouvoir connecter {{ site.data.keys.mf_server }} à Rational License Key Server.

* Rational License Key Server version 8.1.4.8 ou ultérieure doit être installée et configurée. Le réseau doit autoriser la communication vers et depuis {{ site.data.keys.mf_server }} en ouvrant les ports de communication bidirectionnelle (**lmrgd** et **ibmratl**). Pour plus d'informations, voir le portail [Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) et la rubrique [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vérifiez que les clés de licence pour {{ site.data.keys.product }} sont générées. Pour plus d'informations sur la génération et la gestion de vos clés de licence avec IBM Rational License Key Center, voir [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) et [Obtention des clés de licence avec IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} doit être installé et configuré avec l'option Activer l'octroi de licence de jeton avec Rational License Key Server sur votre serveur Apache Tomcat, comme indiqué dans [Présentation de l'installation pour l'octroi de licence de jeton](#installation-overview-for-token-licensing).

### Installation des bibliothèques Rational Common Licensing
{: #installing-rational-common-licensing-libraries }

1. Choisissez la bibliothèque native Rational Common Licensing. Selon le système d'exploitation que vous utilisez et la version bit de Java Runtime Environment sur laquelle Apache Tomcat est exécuté, vous devez choisir la bibliothèque native appropriée dans **product\_install\_dir/MobileFirstServer/tokenLibs/bin/your\_corresponding\_platform/the\_native\_library\_file**. Par exemple, pour Linux x86 avec JRE 64 bits, la bibliothèque figure dans **product\_install\_dir/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**.
2. Copiez la bibliothèque native sur l'ordinateur qui exécute le service d'administration de {{ site.data.keys.mf_server }}. Le répertoire peut être **${CATALINA_HOME}/bin**. 
    > **Remarque :** **${CATALINA_HOME}** est le répertoire d'installation de votre serveur Apache Tomcat.
3. Copiez le fichier **rcl_ibmratl.jar** dans **${CATALINA_HOME}/lib**. Le fichier **rcl_ibmratl.jar** est une bibliothèque Java Rational Common Licensing qui se trouve dans le répertoire **product\_install\_dir/MobileFirstServer/tokenLibs**. La bibliothèque utilise la bibliothèque native que vous avez copiée à l'étape 2, et ne peut être chargée qu'une seule fois par Apache Tomcat. Ce fichier doit être placé dans le répertoire **${CATALINA_HOME}/lib** ou dans n'importe quel répertoire du chemin du chargeur de classe commun Apache Tomcat.
    > **Important :** La machine virtuelle Java d'Apache Tomcat doit disposer des droits de lecture et d'exécution sur la bibliothèque native copiée et la bibliothèque Java. Les deux fichiers copiés doivent également être lisibles et exécutables au moins pour le processus de serveur d'applications dans votre système d'exploitation.
4. Configurez l'accès à la bibliothèque Rational Common Licensing par la machine virtuelle Java de votre serveur d'applications. Pour tout système d'exploitation, configurez le fichier **${CATALINA_HOME}/bin/setenv.bat** (ou le fichier **setenv.sh** sous UNIX) en ajoutant la ligne suivante :

   **Windows :**  
    
   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```
    
   **UNIX :**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```
    
   > **Remarque :** Si vous déplacez le dossier de configuration du serveur sur lequel le service d'administration s'exécute, vous devez mettre à jour **java.library.path** avec le nouveau chemin absolu.

5. Configurez {{ site.data.keys.mf_server }} pour qu'il accède à Rational License Key Server. Dans le fichier **${CATALINA_HOME}/conf/server.xml**, recherchez l'élément `Context` de l'application du service d'administration, et ajoutez-y les lignes de configuration JNDI suivantes :

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname** est le nom d'hôte de Rational License Key Server.
   * **rlks_port** est le port de Rational License Key Server. Par défaut, la valeur est **27000**.

Pour plus d'informations sur les propriétés JNDI, voir [Propriétés JNDI pour les services d'administration : octroi de licence](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installation sur un parc de serveurs Apache Tomcat
{: #installing-on-apache-tomcat-server-farm }
Pour configurer la connexion d'un serveur {{ site.data.keys.mf_server }} sur un parc de serveurs Apache Tomcat, vous devez suivre toutes les étapes décrites dans [Installation des bibliothèques Rational Common Licensing](#installing-rational-common-licensing-libraries) pour chaque noeud de votre parc de serveurs où le service d'administration de {{ site.data.keys.mf_server }} s'exécute. Pour plus d'informations sur un parc de serveurs, voir [Topologie de parc de serveurs](../topologies/#server-farm-topology) et [Installation d'un parc de serveurs](../appserver/#installing-a-server-farm).

## Connexion d'un serveur {{ site.data.keys.mf_server }} installé sur le profil Liberty de WebSphere Application Server à Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
Vous devez installer les bibliothèques Java et natives Rational Common Licensing sur le profil Liberty avant de pouvoir connecter {{ site.data.keys.mf_server }} à Rational License Key Server.

* Rational License Key Server version 8.1.4.8 ou ultérieure doit être installée et configurée. Le réseau doit autoriser la communication vers et depuis {{ site.data.keys.mf_server }} en ouvrant les ports de communication bidirectionnelle (**lmrgd** et **ibmratl**). Pour plus d'informations, voir le portail [Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) et la rubrique [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vérifiez que les clés de licence pour {{ site.data.keys.product }} sont générées. Pour plus d'informations sur la génération et la gestion de vos clés de licence avec IBM Rational License Key Center, voir [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) et [Obtention des clés de licence avec IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} doit être installé et configuré avec l'option Activer l'octroi de licence de jeton avec Rational License Key Server sur votre serveur Apache Tomcat, comme indiqué dans [Présentation de l'installation pour l'octroi de licence de jeton](#installation-overview-for-token-licensing).

### Installation des bibliothèques Rational Common Licensing
{: #common-licensing-libraries-liberty }

1. Définissez une bibliothèque partagée pour le client Rational Common Licensing. Cette bibliothèque utilise du code natif et ne peut être chargée qu'une seule fois par le serveur d'applications. Par conséquent, les applications qui l'utilisent doivent y faire référence en tant que bibliothèque commune.
   * Choisissez la bibliothèque native Rational Common Licensing. Selon le système d'exploitation que vous utilisez et la version bit de Java Runtime Environment sur laquelle le profil Liberty est exécuté, vous devez choisir la bibliothèque native appropriée dans **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**. Par exemple, pour Linux x86 avec JRE 64 bits, la bibliothèque figure dans **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
   * Copiez la bibliothèque native sur l'ordinateur qui exécute le service d'administration de {{ site.data.keys.mf_server }}. Le répertoire peut être **${shared.resource.dir}/rcllib**. Le répertoire **${shared.resource.dir}** figure généralement dans **usr/shared/resources**, où usr est le répertoire qui contient également le répertoire usr/servers. Pour plus d'informations sur l'emplacement standard de **${shared.resource.dir}**, voir [WebSphere Application Server Liberty Core - Emplacement des répertoires et des propriétés](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc). Si le dossier **rcllib** n'existe pas, créez-le, puis copiez le fichier de bibliothèque native dedans.
    
   > **Remarque :** Assurez-vous que la machine virtuelle Java du serveur d'applications dispose des droits de lecture et d'exécution sur la bibliothèque native. Sous  Windows, l'exception suivante apparaît dans le journal du serveur d'applications si la machine virtuelle Java du serveur d'applications ne dispose pas des droits d'exécution sur la bibliothèque native copiée.
    
   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * Copiez le fichier **rcl_ibmratl.jar** dans **${shared.resource.dir}/rcllib**. Le fichier **rcl_ibmratl.jar** est une bibliothèque Java Rational Common Licensing qui se trouve dans le répertoire **product_install_dir/MobileFirstServer/tokenLibs**.

   > **Remarque :** La machine virtuelle Java de profil Liberty doit pouvoir lire la bibliothèque Java copiée. Ce fichier doit également disposer du droit de lecture (au moins pour le processus de serveur d'applications) dans votre système d'exploitation.    
   * Déclarez une bibliothèque partagée qui utilise le fichier **rcl_ibmratl.jar** dans le fichier **${server.config.dir}/server.xml**.

   ```xml
   <!-- Déclaration d'une bibliothèque partagée pour le client RCL. -->
   <!- Cette bibliothèque peut être chargée une seule fois car elle utilise le code natif. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * Déclarez la bibliothèque partagée en tant que bibliothèque commune pour l'application de service d'administration de {{ site.data.keys.mf_server }} en ajoutant un attribut (**commonLibraryRef**) au chargeur de classe de l'application. Etant donné que la bibliothèque ne peut être chargée qu'une seule fois, elle doit être utilisée comme bibliothèque commune et non comme bibliothèque privée.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Déclaration de la bibliothèque partagée en tant qu'attribut commonLibraryRef dans
          le chargeur de classe de l'application. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * Si vous utilisez Oracle comme base de données, le fichier **server.xml** dispose déjà du chargeur de classe suivant :

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```
    
   Vous devez également ajouter la bibliothèque Rational Common Licensing en tant que bibliothèque commune à la bibliothèque Oracle, comme suit :
    
   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * Configurez l'accès à la bibliothèque Rational Common Licensing par la machine virtuelle Java de votre serveur d'applications. Pour tout système d'exploitation, configurez le fichier **${wlp.user.dir}/servers/server_name/jvm.options** en ajoutant la ligne suivante :

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```
    
   > **Remarque :** Si vous déplacez le dossier de configuration du serveur sur lequel le service d'administration s'exécute, vous devez mettre à jour **java.library.path** avec le nouveau chemin absolu.

   Le répertoire **${wlp.user.dir}** figure généralement dans **liberty_install_dir/usr** et contient le répertoire servers. Toutefois, son emplacement peut être personnalisé. Pour plus d'informations, voir [Personnalisation de l'environnement du profil Liberty](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc)
    
2. Configurez {{ site.data.keys.mf_server }} pour qu'il accède à Rational License Key Server.

   Dans le fichier **${wlp.user.dir}/servers/server_name/server.xml**, ajoutez ces lignes de configuration JNDI.
    
   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/> 
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/> 
   ```
   * **rlks_hostname** est le nom d'hôte de Rational License Key Server.
   * **rlks_port** est le port de Rational License Key Server. La valeur par défaut est 27000.

   Pour plus d'informations sur les propriétés JNDI, voir [Propriétés JNDI pour les services d'administration : octroi de licence](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installation sur un parc de serveurs de profil Liberty
{: #installing-on-liberty-profile-server-farm }
Pour configurer la connexion d'un serveur {{ site.data.keys.mf_server }} sur un parc de serveurs de profil Liberty, vous devez suivre toutes les étapes décrites dans [Installation des bibliothèques Rational Common Licensing](#installing-rational-common-licensing-libraries) pour chaque noeud de votre parc de serveurs où le service d'administration de {{ site.data.keys.mf_server }} s'exécute. Pour plus d'informations sur un parc de serveurs, voir [Topologie de parc de serveurs](../topologies/#server-farm-topology) et [Installation d'un parc de serveurs](../appserver/#installing-a-server-farm).

## Connexion du serveur {{ site.data.keys.mf_server }} installé sur WebSphere Application Server à Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
Vous devez configurer une bibliothèque partagée pour les bibliothèques Rational Common Licensing sur WebSphere Application Server avant de pouvoir connecter {{ site.data.keys.mf_server }} à Rational License Key Server.

* Rational License Key Server version 8.1.4.8 ou ultérieure doit être installée et configurée. Le réseau doit autoriser la communication vers et depuis {{ site.data.keys.mf_server }} en ouvrant les ports de communication bidirectionnelle (**lmrgd** et **ibmratl**). Pour plus d'informations, voir le portail [Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) et la rubrique [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vérifiez que les clés de licence pour {{ site.data.keys.product }} sont générées. Pour plus d'informations sur la génération et la gestion de vos clés de licence avec IBM Rational License Key Center, voir [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) et [Obtention des clés de licence avec IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} doit être installé et configuré avec l'option Activer l'octroi de licence de jeton avec Rational License Key Server sur votre serveur Apache Tomcat, comme indiqué dans [Présentation de l'installation pour l'octroi de licence de jeton](#installation-overview-for-token-licensing).

### Installation de la bibliothèque Rational Common Licensing sur un serveur autonome
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. Définissez une bibliothèque partagée pour la bibliothèque Rational Common Licensing. Cette bibliothèque utilise du code natif et ne peut être chargée qu'une seule fois par un chargeur de classe au cours du cycle de vie du serveur d'applications. Par conséquent, la bibliothèque est déclarée en tant que bibliothèque partagée et associée à tous les serveurs d'applications qui exécutent le service d'administration de {{ site.data.keys.mf_server }}. Pour plus d'informations sur les raisons qui imposent de déclarer cette bibliothèque en tant que bibliothèque partagée, voir [Configuration des bibliothèques natives dans les bibliothèques partagées](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc).
    * Choisissez la bibliothèque native Rational Common Licensing. Selon le système d'exploitation que vous utilisez et la version bit de Java Runtime Environment sur laquelle WebSphere Application Server est exécuté, vous devez choisir la bibliothèque native appropriée dans **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**.
    
        Par exemple, pour Linux x86 avec JRE 64 bits, la bibliothèque figure dans **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
    
        Pour déterminer la version bit de Java Runtime Environment pour une installation WebSphere Application Server autonome ou WebSphere Application Server Network Deployment, exécutez **versionInfo.bat** sous Windows ou **versionInfo.sh** sous UNIX à partir du répertoire **bin**. Le fichier **versionInfo.sh** figure dans **/opt/IBM/WebSphere/AppServer/bin**. Recherchez la valeur Architecture dans la section **Produit installé**. Java Runtime Environment est en version 64 bits si la valeur Architecture mentionne explicitement cette version ou si elle porte le suffixe 64 ou _64.
    * Placez la bibliothèque native correspondant à votre plateforme dans un dossier de votre système d'exploitation. Par exemple, **/opt/IBM/RCL_Native_Library/**.
    * Copiez le fichier **rcl_ibmratl.jar** dans **/opt/IBM/RCL_Native_Library/**. Le fichier **rcl_ibmratl.jar** est une bibliothèque Java Rational Common Licensing qui se trouve dans **product_install_dir/MobileFirstServer/tokenLibs directory**.
    
        > **Important :** La machine virtuelle Java du serveur d'applications doit disposer des droits de lecture et d'exécution sur la bibliothèque native copiée et la bibliothèque Java. Les deux fichiers copiés doivent également être lisibles et exécutables au moins pour le processus de serveur d'applications dans votre système d'exploitation.    
    * Déclarez une bibliothèque partagée dans la console d'administration de WebSphere Application Server.
        * Connectez-vous à la console d'administration de WebSphere Application Server.
        * Développez **Environnement → Bibliothèques partagées**.
        * Sélectionnez une portée qui est visible par tous les serveurs qui exécutent le service d'administration de {{ site.data.keys.mf_server }}. Par exemple, un cluster.
        * Cliquez sur **Nouveau**.
        * Entrez un nom pour la bibliothèque dans la zone Nom. Par exemple, "RCL Shared Library".
        * Dans la zone Chemin de classe, entrez le chemin d'accès au fichier **rcl_ibmratl.jar**. Par exemple, **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * Cliquez sur **OK** et sauvegardez les modifications. Cette valeur prendra effet au redémarrage du serveur.
    
        > **Remarque :** Le chemin de la bibliothèque native pour cette bibliothèque est définie à l'étape 3 dans la propriété **ld.library.path** de la machine virtuelle Java du serveur.
    * Associez la bibliothèque partagée à tous les serveurs qui exécutent le service d'administration de {{ site.data.keys.mf_server }}.
    
        Lorsque la bibliothèque partagée est associée à un serveur, elle peut être utilisée par plusieurs applications. Si vous avez besoin du client Rational Common Licensing uniquement pour le service d'administration de {{ site.data.keys.mf_server }}, vous pouvez créer une bibliothèque partagée avec un chargeur de classe isolé et l'associer à l'application de service d'administration.

        L'instruction décrite ci-après consiste à associer la bibliothèque à un serveur. Pour WebSphere Application Server Network Deployment, vous devez exécuter cette instruction pour tous les serveurs qui exécutent le service d'administration de {{ site.data.keys.mf_server }}.    
        * Définissez les règles de chargeur de classe et le mode.    
            1. Dans la console d'administration de WebSphere Application Server, cliquez sur **Serveurs → Types de serveur → Serveurs WebSphere application → nom_serveur** pour accéder à la page des paramètres de serveur d'applications.
            2. Définissez les valeurs pour les règles de chargeur de classe et le mode de chargement de classe du serveur :
                * **Règles de chargeur de classe** : Multiple
                * **Mode de chargement de classe** : Classes chargées avec le chargeur de classes parent en premier
            3. Dans la section **Infrastructure du serveur**, cliquez usr **Java et gestion de processus → Chargeur de classe**.
            4. Cliquez sur **Nouveau** et assurez-vous que l'ordre de chargeur de classe a pour valeur **Classes chargées avec le chargeur de classes parent en premier**.
            5. Cliquez sur **Appliquer** pour créer un nouvel ID de chargeur de classe.                
        * Créez une référence de bibliothèque pour chaque fichier de bibliothèque partagée requis par votre application.
            1. Cliquez sur le nom du chargeur de classe qui a été créé à l'étape précédente.
            2. Dans la section **Propriétés supplémentaires**, cliquez sur **Références de bibliothèque partagée**.
            3. Cliquez sur **Ajouter**.
            4. Sur la page des paramètres de référence de bibliothèque, sélectionnez la référence de bibliothèque appropriée. Ce nom identifie le fichier de bibliothèque partagée utilisée par votre application. Par exemple, bibliothèque partagée RCL.
            5. Cliquez sur **Appliquer** et sauvegardez les modifications.
2. Configurez les entrées d'environnement pour l'application Web de service d'administration de {{ site.data.keys.mf_server }}.
    * Dans la console d'administration de WebSphere Application Server, cliquez sur **Applications → Types d'application → Applications d'entreprise WebSphere** et sélectionnez l'application de service d'administration : **MobileFirst_Administration_Service**.
    * Dans la section **Propriétés de module Web**, cliquez sur **Entrées d'environnement pour les modules Web**.
    * Entrez les valeurs pour **mfp.admin.license.key.server.host** et **mfp.admin.license.key.server.port**.
        * **mfp.admin.license.key.server.host** est le nom d'hôte de Rational License Key Server.
        * **mfp.admin.license.key.server.port** est le port de Rational License Key Server. La valeur par défaut est 27000.
    * Cliquez sur **OK** et sauvegardez les modifications.
3. Configurez l'accès à la bibliothèque Rational Common Licensing par la machine virtuelle Java du serveur d'applications.
    * Dans la console d'administration de WebSphere Application Server, cliquez sur **Serveurs → Types de serveur → Serveurs WebSphere Application** et sélectionnez votre serveur.
    * Dans la section **Infrastructure du serveur**, cliquez sur **Java et gestion de processus → Définition de processus → Machine virtuelle Java → Propriétés personnalisées → Nouveau** pour ajouter une propriété personnalisée.
    * Dans la zone **Nom**, tapez le nom de la propriété personnalisée, **java.library.path**.
    * Dans la zone **Valeur**, entrez le chemin d'accès du dossier dans lequel vous avez placé le fichier de bibliothèque native à l'étape 1b. Par exemple, **/opt/IBM/RCL_Native_Library/**.
    * Cliquez sur **OK** et sauvegardez les modifications.
4. Redémarrez votre serveur d'applications.

### Installation de la bibliothèque Rational Common Licensing sur WebSphere Application Server Network Deployment
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
Pour installer la bibliothèque native sur WebSphere Application Server Network Deployment, vous devez suivre toutes les étapes décrites dans [Installation de la bibliothèque Rational Common Licensing sur un serveur autonome](#installing-rational-common-licensing-library-on-a-stand-alone-server) ci-dessus. Les serveurs ou les clusters que vous configurez doivent être redémarrés pour que les modifications soient prises en compte.

Chaque noeud de WebSphere Application Server Network Deployment doit disposer d'une copie de la bibliothèque native Rational Common Licensing.

Chaque serveur sur lequel le service d'administration de {{ site.data.keys.mf_server }} s'exécute doit être configuré pour accéder à la bibliothèque native copiée sur votre ordinateur local. Ces serveurs doivent également être configurés pour se connecter à Rational License Key Server.

> **Important :** Si vous utilisez un cluster avec WebSphere Application Server Network Deployment, il peut être amené à changer. Vous devez configurer chaque serveur nouvellement ajouté dans votre cluster, où les services d'administration s'exécutent.

## Limitations des plateformes prises en charge pour l'octroi de licence de jeton
{: #limitations-of-supported-platforms-for-token-licensing }
Liste des systèmes d'exploitation, de leur version, et de l'architecture matérielle qui prend en charge {{ site.data.keys.mf_server }} avec l'octroi de licence de jeton activé.

Pour l'octroi de licence de jeton, {{ site.data.keys.mf_server }} doit se connecter à Rational License Key Server à l'aide de la bibliothèque Rational Common Licensing.

Cette bibliothèque est composée d'une bibliothèque Java et également de bibliothèques natives. Ces bibliothèques natives dépendent de la plateforme sur laquelle {{ site.data.keys.mf_server }} s'exécute. Par conséquent, l'octroi de licence de jeton par {{ site.data.keys.mf_server }} est pris en charge uniquement sur les plateformes sur lesquelles la bibliothèque Rational Common Licensing peut être exécutée.

Le tableau suivant répertorie les plateformes qui prennent en charge {{ site.data.keys.mf_server }} avec l'octroi de licence de jeton.

| Système d'exploitation             | Version de système exploitation |	Architecture matérielle |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8  (64 bits uniquement) |
| SUSE Linux Enterprise Server | 11	                      | x86-64 uniquement           |
| Windows Server               | 2012	                  | x86-64 uniquement           |

L'octroi de licence de jeton ne prend pas en charge l'environnement d'exécution Java (JRE) 32 bits. Assurez-vous que le serveur d'applications utilise un environnement d'exécution Java (JRE) 64 bits.

## Traitement des incidents liés à l'octroi de licence de jeton
{: #troubleshooting-token-licensing-problems }
Recherchez les informations destinées à vous aider à résoudre les problèmes susceptibles de se produire au niveau de l'octroi de licence de jeton si vous avez activé cette fonction lors de l'installation de {{ site.data.keys.mf_server }}.

Lorsque vous démarrez le service d'administration de {{ site.data.keys.mf_server }} après avoir effectué l'installation et la configuration pour l'octroi de licence de jeton, des erreurs ou des exceptions peuvent être générées dans le journal du serveur d'applications sur {{ site.data.keys.mf_console }}. Ces exceptions peuvent être dues à une installation de la bibliothèque Rational Common Licensing et une configuration du serveur d'applications incorrectes.

**Apache Tomcat**  
Vérifiez le fichier **catalina.log** ou catalina.out, selon les plateformes.

**Profil Liberty de WebSphere® Application Server**  
Vérifiez le message **messages.log**.

**Profil complet de WebSphere Application Server**  
Vérifiez le fichier **SystemOut.log**.

> **Important :** Si l'octroi de licence de jeton est installé sur  WebSphere Application Server Network Deployment ou sur un cluster, vous devez vérifier le journal de chaque serveur.

Voici une liste des exceptions qui peuvent se produire après l'installation et la configuration pour l'octroi de licence de jeton :

* [La bibliothèque native Rational Common Licensing est introuvable](#rational-common-licensing-native-library-is-not-found)
* [La bibliothèque partagée Rational Common Licensing est introuvable](#rational-common-licensing-shared-library-is-not-found)
* [La connexion à Rational License Key Server n'est pas configurée](#the-rational-license-key-server-connection-is-not-configured)
* [Rational License Key Server n'est pas accessible](#the-rational-license-key-server-is-not-accessible)
* [L'initialisation de l'API Rational Common Licensing a échoué](#failed-to-initialize-rational-common-licensing-api)
* [Licences de jeton insuffisantes](#insufficient-token-licenses)
* [Fichier rcl_ibmratl.jar non valide](#invalid-rcl_ibmratljar-file)

### La bibliothèque native Rational Common Licensing est introuvable
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: La bibliothèque native Rational Common Licensing est introuvable. Vérifiez que la propriété JVM (java.library.path) contient le chemin d'accès correct et que la bibliothèque native peut être exécutée. Redémarrez {{ site.data.keys.mf_server }} après avoir exécuté l'action corrective.

#### Pour le profil complet de WebSphere Application Server
{: #for-websphere-application-server-full-profile }
Causes possibles de cette erreur :

* Aucune propriété commune portant le nom **java.library.path** n'est définie au niveau serveur.
* Le chemin fourni comme valeur pour la propriété **java.library.path** ne contient pas la bibliothèque native Rational Common Licensing.
* La bibliothèque native ne dispose pas des droits appropriés. La bibliothèque doit disposer des droits de lecture et d'exécution sous UNIX et Windows pour l'utilisateur qui y accède avec l'environnement d'exécution Java™
* du serveur d'applications.

#### Pour le profil Liberty de WebSphere Application Server et Apache Tomcat
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
Causes possibles de cette erreur :

* Le chemin d'accès à la bibliothèque native Rational Common Licensing donné comme valeur pour la propriété java.library.path n'est pas défini ou est incorrect.
    * Pour le profil Liberty, vérifiez le fichier **${wlp.user.dir}/servers/server_name/jvm.options**.
    * Pour Apache Tomcat, vérifiez le fichier **${CATALINA_HOME}/bin/setenv.bat** ou setenv.sh, selon les plateformes.
* La bibliothèque native est introuvable dans le chemin défini pour la propriété **java.library.path**. Vérifiez que la bibliothèque native existe dans le chemin défini avec le nom attendu.
* La bibliothèque native ne dispose pas des droits appropriés. L'erreur peut être précédée de l'exception suivante : `com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: Access is denied`.

L'environnement d'exécution Java du serveur d'applications doit disposer des droits de lecture et d'exécution sur cette bibliothèque native. Le fichier de bibliothèque doit également être lisible et exécutable au moins pour le processus de serveur d'applications dans votre système d'exploitation.

* La bibliothèque partagée qui utilise le fichier **rcl_ibmratl.jar** n'est pas définie dans le fichier **${server.config.dir}/server.xml** pour le profil Liberty. Il se peut également que le fichier **rcl_ibmratl.jar** ne soit pas dans le répertoire approprié ou que le répertoire ne dispose pas des droits appropriés.
* La bibliothèque partagée qui utilisait le fichier **rcl_ibmratl.jar** n'est pas déclarée comme bibliothèque commune pour l'application de service d'administration de {{ site.data.keys.mf_server }} dans le fichier **${server.config.dir}/server.xml** pour le profil Liberty.
* Il existe un mélange d'objets 32 bits et 64 bits entre l'environnement d'exécution Java du serveur d'applications et la bibliothèque native. Par exemple, un environnement d'exécution Java 32 bits est utilisé avec une bibliothèque native 64 bits. Ce mélange n'est pas pris en charge.

### La bibliothèque partagée Rational Common Licensing est introuvable
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: La bibliothèque partagée Rational Common Licensing est introuvable. Vérifiez que la bibliothèque partagée est configurée. Redémarrez {{ site.data.keys.mf_server }} après avoir exécuté l'action corrective.

Causes possibles de cette erreur :

* Le fichier **rcl_ibmratl.jar** ne se trouve pas dans répertoire attendu.
    * Pour Apache Tomcat, vérifiez que ce fichier figure dans le répertoire **${CATALINA_HOME}/lib**.
    * Pour le profil Liberty de WebSphere Application Server, vérifiez que ce fichier figure dans le répertoire comme indiqué dans le fichier server.xml pour la bibliothèque partagée du client Rational Common Licensing. Par exemple, **${shared.resource.dir}/rcllib**. Dans le fichier **server.xml**, assurez-vous que cette bibliothèque partagée est correctement référencée comme bibliothèque commune pour l'application de service d'administration de {{ site.data.keys.mf_server }}.
    * Pour WebSphere Application Server, vérifiez que ce fichier figure dans le répertoire qui a été spécifié dans le chemin d'accès aux classes de la bibliothèque partagée WebSphere Application Server. Vérifiez que le chemin d'accès aux classes de cette bibliothèque partagée contient l'entrée **absolute\_path/rcl\_ibmratl.jar** bien que absolute_path soit le chemin d'accès absolu au fichier **rcl_ibmratl.jar**.

La propriété **java.library.path** n'est pas définie pour le serveur d'applications. Définissez une propriété avec le nom **java.library.path** et définissez le chemin d'accès à la bibliothèque native Rational Common Licensing comme valeur. Par exemple, **/opt/IBM/RCL\_Native\_Library/**.
* La bibliothèque native ne dispose pas des droits attendus. Sous Windows, l'environnement d'exécution Java du serveur d'applications doit disposer des droits de lecture et d'exécution sur la bibliothèque native.
* Il existe un mélange d'objets 32 bits et 64 bits entre l'environnement d'exécution Java du serveur d'applications et la bibliothèque native. Par exemple, un environnement d'exécution Java 32 bits est utilisé avec une bibliothèque native 64 bits. Ce mélange n'est pas pris en charge.

### La connexion à Rational License Key Server n'est pas configurée
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: La connexion à Rational License Key Server n'est pas configurée. Assurez-vous que les propriétés JNDI d'administration "mfp.admin.license.key.server.host" et "mfp.admin.license.key.server.port" sont définies. Redémarrez {{ site.data.keys.mf_server }} après avoir exécuté l'action corrective.

Causes possibles de cette erreur :

* La bibliothèque native Rational Common Licensing et la bibliothèque partagée qui utilise le fichier **rcl_ibmratl.jar** sont correctement configurées, mais la valeur des propriétés JNDI (**mfp.admin.license.key.server.host** et **mfp.admin.license.key.server.port**) n'est pas définie dans l'application de service d'administration de {{ site.data.keys.mf_server }}.
* Rational License Key Server est arrêté.
* L'ordinateur hôte sur lequel Rational License Key Server est installé est inaccessible. Vérifiez l'adresse IP ou le nom d'hôte avec le port spécifié.

### Rational License Key Server n'est pas accessible
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: Rational License Key Server "{port}@{IP address or hostname}" n'est pas accessible. Assurez-vous que le serveur de licences s'exécute et qu'il est accessible pour {{ site.data.keys.mf_server }}. Si cette erreur se produit lors du démarrage de l'exécution, redémarrez {{ site.data.keys.mf_server }} après avoir exécuté l'action corrective.

Causes possibles de cette erreur :

* La bibliothèque partagée Rational Common Licensing et la bibliothèque native sont correctement définies, mais il n'existe aucune configuration valide à connecter à Rational License Key Server. Vérifiez l'adresse IP, le nom d'hôte et le port du serveur de licences. Assurez-vous que le serveur de licences est démarré et accessible à partir de l'ordinateur sur lequel le serveur d'applications est installé.
* La bibliothèque native est introuvable dans le chemin défini pour la propriété **java.library.path**.
* La bibliothèque native ne dispose pas des droits appropriés.
* La bibliothèque native ne figure pas dans le répertoire défini.
* Rational License Key Server se trouve derrière un pare-feu. L'erreur peut être précédée de l'exception suivante : [ERROR] Failed to get license for application 'WorklightStarter' because Rational Licence Key Server ({port}@{IP address or hostname}) is either down or not accessible com.ibm.rcl.ibmratl.LicenseServerUnreachableException. All license files searched for features: {port}@{IP address or hostname}

Assurez-vous que le port de démon de gestionnaire de licence (lmgrd) et le port de démon de fournisseur (ibmratl) sont ouverts dans votre pare-feu. Pour plus d'informations, voir How to serve a license key to client machines through a firewall.

### L'initialisation de l'API Rational Common Licensing a échoué
{: #failed-to-initialize-rational-common-licensing-api }

> Failed to initialize Rational Common Licensing (RCL) API because its native library could not be found or loaded com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Not found in java.library.path)

Causes possibles de cette erreur :

* La bibliothèque native Rational Common Licensing est introuvable dans le chemin défini pour la propriété **java.library.path**. Vérifiez que la bibliothèque native existe dans le chemin défini avec le nom attendu.
* La propriété **java.library.path** n'est pas définie pour le serveur d'applications. Définissez une propriété avec le nom **java.library.path** et définissez le chemin d'accès à la bibliothèque native Rational Common Licensing comme valeur. Par exemple, **/opt/IBM/RCL_Native_Library/**.
* Il existe un mélange d'objets 32 bits et 64 bits entre l'environnement d'exécution Java du serveur d'applications et la bibliothèque native. Par exemple, un environnement d'exécution Java 32 bits est utilisé avec une bibliothèque native 64 bits. Ce mélange n'est pas pris en charge.

### Licences de jeton insuffisantes
{: #insufficient-token-licenses }

> FWLSE3129E: Licences de jeton insuffisantes pour la fonction "{0}".

Cette erreur se produit lorsque le nombre restant de licences de jeton sur Rational License Key Server n'est pas suffisant pour déployer une nouvelle application {{ site.data.keys.product_adj }}.

### Fichier rcl_ibmratl.jar non valide
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: The shared library RCL Shared Library contains a classpath entry which does not resolve to a valid jar file, the library jar file is expected to be found at {0}/rcl_ibmratl.jar.

**Remarque :** Pour WebSphere Application Server et WebSphere Application Server Network Deployment uniquement

Causes possibles de cette erreur :

* La bibliothèque Java **rcl_ibmratl.jar** ne dispose pas des droits appropriés. L'erreur peut être suivie d'une autre exception :java.util.zip.ZipException: erreur d'ouverture du fichier zip. Vérifiez que le fichier **rcl_ibmratl.jar** dispose du droit de lecture pour l'utilisateur qu installe WebSphere Application Server.
* S'il n'existe aucune autre exception, le fichier **rcl_ibmratl.jar** qui est référencé dans le chemin d'accès aux classes de la bibliothèque partagée est peut-être incorrect ou inexistant. Vérifiez que le fichier **rcl_ibmratl.jar** est valide ou qu'il existe dans le chemin défini.


