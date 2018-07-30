---
layout: tutorial
title: Guide d'installation de MobileFirst Analytics Server
breadcrumb_title: Installation Guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.mf_analytics_server }} est implémenté et livré sous la forme d'un ensemble de deux fichiers archive d'application Web (WAR) de norme Java EE ou d'un fichier archive d'application d'entreprise (EAR). Par conséquent, il peut être installé sur l'un des serveurs d'applications pris en charge suivants : WebSphere Application Server, WebSphere Application Server Liberty ou Apache Tomcat (fichiers WAR seulement).

{{ site.data.keys.mf_analytics_server }} utilise une bibliothèque Elasticsearch imbriquée pour le stockage des données et la gestion de cluster. Etant donné que sa fonction de recherche en mémoire et son moteur de requête sont très performants et qu'il nécessite des entrées-sorties de disque rapides, vous devez satisfaire la configuration système requise pour la production. En général, la mémoire et l'espace disque sont insuffisants (ou les entrées-sorties sur le disque génèrent un goulot d'étranglement des performances) car l'unité centrale devient problématique. Dans un environnement en cluster, vous avez besoin d'un cluster de noeuds rapide, fiable et colocalisé.

#### Aller à
{: #jump-to }

* [Configuration système requise](#system-requirements)
* [Remarques sur la capacité](#capacity-considerations)
* [Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Liberty](#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
* [Installation de {{ site.data.keys.mf_analytics }} sur Tomcat](#installing-mobilefirst-analytics-on-tomcat)
* [Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server](#installing-mobilefirst-analytics-on-websphere-application-server)
* [Installation de {{ site.data.keys.mf_analytics }} à l'aide de tâches Ant](#installing-mobilefirst-analytics-with-ant-tasks)
* [Installation de {{ site.data.keys.mf_analytics_server }} sur des serveurs exécutant des versions précédentes](#installing-mobilefirst-analytics-server-on-servers-running-previous-versions)

## Configuration système requise
{: #system-requirements }

### Systèmes d'exploitation
{: #operating-systems }
* CentOS/RHEL 6.x/7.x
* Oracle Enterprise Linux 6/7 avec noyau RHEL seulement
* Ubuntu 12.04/14.04
* SLES 11/12
* OpenSuSE 13.2
* Windows Server 2012/R2
* Debian 7

### Machines virtuelles Java
{: #jvm }
* Oracle JVM 1.7u55+
* Oracle JVM 1.8u20+
* IcedTea OpenJDK 1.7.0.55+

### Matériel
{: #hardware }
* Mémoire RAM : plus la quantité de mémoire RAM est élevée, mieux c'est.
Toutefois, ne dépassez pas 64 Go par noeud. 32 Go et 16 Go sont des valeurs acceptables. Une quantité inférieure à 8 Go nécessite que le cluster contienne de nombreux petits noeuds, et une quantité égale à 64 Go est inutile et problématique en raison de la façon dont Java utilise la mémoire pour les pointeurs.
* Disque : utilisez des disques SSD si possible, ou des disques traditionnels à rotation rapide dans une configuration RAID 0 si vous ne pouvez pas utiliser de disques SSD.
* Unité centrale : en général, l'unité centrale n'est pas à l'origine du goulot d'étranglement des performances. Utilisez des systèmes de 2 à 8 coeurs.
* Réseau : lorsqu'une extension horizontale est nécessaire, vous devez utiliser un centre de données rapide et fiable dont les vitesses prises en charge vont de 1 à 10 Gbe.

### Configuration matérielle
{: #hardware-configuration }
* Allouez à votre machine virtuelle Java la moitié de la mémoire RAM disponible, mais ne dépassez pas 32 Go
    * En associant la variable d'environnement **ES\_HEAP\_SIZE** à la valeur 32g.
    * En définissant les indicateurs de machine virtuelle Java avec -Xmx32g et -Xms32g.
* Désactivez la permutation des disques. Le fait d'autoriser le système d'exploitation à permuter le segment de mémoire (sur/hors disque) réduit considérablement les performances.
    * Provisoirement : `sudo swapoff -a`
    * Définitivement : éditez **/etc/fstab** conformément à la documentation du système d'exploitation.
    * Si aucune de ces options n'est applicable, définissez l'option Elasticsearch **bootstrap.mlockall: true** (cette valeur est la valeur par défaut dans l'instance Elasticsearch imbriquée).
* Augmentez les descripteurs de fichier ouvert autorisés.
    * En général, Linux limite le nombre de descripteurs de fichier ouvert par processus à 1024.
    * Consultez la documentation de votre système d'exploitation pour savoir comment augmenter cette valeur de façon permanente en définissant une valeur beaucoup plus élevée, comme 64 000.
* Elasticsearch utilise également un mélange de types NioFS et MMapFS pour les divers fichiers. Augmentez le nombre maximal de mappes pour qu'une grande quantité de mémoire virtuelle soit disponibles pour les fichiers mappés.
    * Provisoirement : `sysctl -w vm.max_map_count=262144`
    * Définitivement : modifiez le paramètre **vm.max\_map\_count** dans votre fichier **/etc/sysctl.conf**
* Si vous utilisez un système BSD ou Linux, assurez-vous que le planificateur d'E-S de votre système d'exploitation est **deadline** ou **noop**, et non **cfq**.

## Remarques sur la capacité
{: #capacity-considerations }
La question de la capacité est essentielle. De combien de mémoire RAM avez-vous besoin ? De combien d'espace disque ? De combien de noeuds ? La réponse est toujours la même : ça dépend.

IBM {{ site.data.keys.mf_analytics }} Analytics vous permet de collecter de nombreux types d'événement hétérogènes, notamment des journaux de débogage de logiciel SDK client bruts, des événements réseau signalés par le serveur, des données personnalisées, etc. Il s'agit d'un système big data qui présente des exigences de système big data.

Le type et la quantité de données que vous choisissez de collecter, ainsi que la durée pendant laquelle vous décidez de conserver les données, ont un impact considérable sur vos exigences de stockage et les performances générales. Par exemple, examinons les questions suivantes :

* Les journaux client de débogage bruts sont-ils utiles après un mois ?
* Utilisez-vous la fonction **Alertes** dans {{ site.data.keys.mf_analytics }}? Si oui, recherchez-vous des événements qui sont survenus au cours des dernières minutes ou au cours d'une période plus longue ?
* Utilisez-vous des graphiques personnalisés ? Si oui, créez-vous ces graphiques pour des données intégrées ou pour des paires clé-valeur instrumentées et personnalisées ? Pendant combien de temps conservez-vous les données ?

Les graphiques intégrés dans {{ site.data.keys.mf_analytics_console }} sont affichés lorsque vous recherchez des données que {{ site.data.keys.mf_analytics_server }} a déjà résumées et optimisées spécifiquement pour un acquis utilisateur de la console le plus rapide possible. Comme les données sont préalablement résumées et optimisées pour les graphiques intégrés, elles ne sont pas adaptées pour les alertes ou les graphiques personnalisés, où l'utilisateur de la console définit les requêtes.

Lorsque vous recherchez des documents bruts, appliquez des filtres, effectuez des agrégations et demandez au moteur de requête sous-jacent de calculer des moyennes et des pourcentages, les performances de requête sont nécessairement dégradées. C'est pour ce cas d'utilisation que la question de la capacité doit être examinée avec soin. Si vos performances de requête sont faibles, il est temps de décider s'il est réellement nécessaire de conserver les anciennes données en vue d'une visibilité en temps réel dans la console ou s'il vaut mieux les effacer de {{ site.data.keys.mf_analytics_server }}. La visibilité en temps réel dans la console vous est-elle vraiment utile pour les données datant d'il y a quatre mois ?

### Index, fragments et noeuds
{: #indicies-shards-and-nodes }
Le magasin de données sous-jacent est Elasticsearch. Vous devez avoir quelques notions relatives aux index, aux fragments et aux noeuds, ainsi qu'à la façon dont la configuration affecte les performances. Grossièrement, vous pouvez penser à un index comme à une unité logique de données. Un index est mappé à des fragments (un à plusieurs), où la clé de configuration est shards. {{ site.data.keys.mf_analytics_server }}
crée un index distinct par type de document. Si votre configuration n'ignore aucun type de document, le nombre d'index créé doit être équivalent au nombre de types de document proposés par {{ site.data.keys.mf_analytics_server }}.

Si vous définissez un nombre de fragments de 1, chaque index ne possédera toujours qu'un seul fragment primaire dans lequel les données sont écrites. Si vous définissez un nombre de fragments de 10, chaque index pourra répartir les données dans un à dix fragments. Toutefois, si le nombre de fragments est élevé, les performances peuvent en pâtir si vous ne disposez que d'un seul noeud. Ce noeud répartit les données de chaque index entre 10 fragments sur un même disque physique. Ne configurez 10 fragments que si vous prévoyez immédiatement (ou rapidement) de passer à 10 noeuds physiques dans le cluster.

Le même principe s'applique aux **répliques**. Pour les **répliques**, ne définissez un nombre supérieur à 0 que si vous prévoyez immédiatement (ou rapidement) de passer au nombre de noeuds correspondant.  
Par exemple, si vous définissez 4 **fragments** et 2 **répliques**, passez à 8 noeuds, c'est-à-dire 4x2.

## Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Liberty
{: #installing-mobilefirst-analytics-on-websphere-application-server-liberty }
Assurez-vous de disposer du fichier EAR de {{ site.data.keys.mf_analytics }}. Pour plus d'informations sur les artefacts d'installation, voir [Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](../../prod-env/appserver). Le fichier **analytics.ear** se trouve dans le dossier `<mf_server_install_dir>\analytics`. Pour plus d'informations sur le téléchargement et l'installation de WebSphere Application Server Liberty, voir l'article [About WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/) sur le site IBM developerWorks.

1. Créez un serveur en exécutant la commande suivante dans votre dossier **./wlp/bin** :

   ```bash
   ./server create <nom_serveur>
   ```

2. Installez les fonctions ci-dessous en exécutant la commande suivante dans votre dossier **./bin** :

   ```bash
   ./featureManager install jsp-2.2 ssl-1.0 appSecurity-1.0 localConnector-1.0
   ```

3. Ajoutez le fichier **analytics.ear** au dossier `./usr/servers/<serverName>/apps` de votre serveur Liberty.
4. Remplacez le contenu de la balise `<featureManager>` du fichier `./usr/servers/<serverName>/server.xml` par le contenu suivant :

   ```xml
   <featureManager>
        <feature>jsp-2.2</feature>
        <feature>ssl-1.0</feature>
        <feature>appSecurity-1.0</feature>
        <feature>localConnector-1.0</feature>
   </featureManager>
   ```

5. Configurez **analytics.ear** en tant qu'application avec la sécurité basée sur les rôles dans le fichier **server.xml**. L'exemple ci-dessous crée un registre d'utilisateurs de base codé en dur et affecte un utilisateur à chaque rôle d'analyse.

   ```xml
   <application location="analytics.ear" name="analytics-ear" type="ear">
        <application-bnd>
            <security-role name="analytics_administrator">
                <user name="admin"/>
            </security-role>
            <security-role name="analytics_infrastructure">
                <user name="infrastructure"/>
            </security-role>
            <security-role name="analytics_support">
                <user name="support"/>
            </security-role>
            <security-role name="analytics_developer">
                <user name="developer"/>
            </security-role>
            <security-role name="analytics_business">
                <user name="business"/>
            </security-role>
        </application-bnd>
   </application>

   <basicRegistry id="worklight" realm="worklightRealm">
        <user name="business" password="demo"/>
        <user name="developer" password="demo"/>
        <user name="support" password="demo"/>
        <user name="infrastructure" password="demo"/>
        <user name="admin" password="admin"/>
   </basicRegistry>
   ```

   > Pour plus d'informations sur la configuration d'autres types de registre d'utilisateurs, par exemple LDAP, voir la rubrique [Configuration d'un registre d'utilisateurs pour le profil Liberty](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.iseries.doc/ae/twlp_sec_registries.html) dans la documentation du produit WebSphere Application Server.

6. Démarrez le serveur Liberty en exécutant la commande suivante dans votre dossier **bin** :

   ```bash
   ./server start <nom_serveur>
   ```

7. Accédez à {{ site.data.keys.mf_analytics_console }}.

   ```bash
   http://localhost:9080/analytics/console
   ```

Pour plus d'informations sur l'administration de WebSphere Application Server Liberty, voir la rubrique [Administration du profil Liberty depuis la ligne de commande](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_script.html) dans la documentation du produit WebSphere Application Server.

## Installation de {{ site.data.keys.mf_analytics }} sur Tomcat
{: #installing-mobilefirst-analytics-on-tomcat }
Assurez-vous de disposer des fichiers WAR de {{ site.data.keys.mf_analytics }}. Pour plus d'informations sur les artefacts d'installation, voir [Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](../../prod-env/appserver). Les fichiers **analytics-ui.war** et **analytics-service.war** se trouvent dans le dossier **<rép_install_serveur_mf>\analytics**. Pour plus d'informations sur le téléchargement et l'installation de Tomcat, voir [Apache Tomcat](http://tomcat.apache.org/). Assurez-vous de télécharger la version qui prend en charge Java 7 ou version ultérieure. Pour savoir quelles versions de Tomcat prennent en charge Java 7, voir [Apache Tomcat Versions](http://tomcat.apache.org/whichversion.html).

1. Ajoutez les fichiers **analytics-service.war** et **analytics-ui.war** dans le dossier **webapps** de Tomcat.
2. Supprimez la mise en commentaire de la section suivante dans le fichier **conf/server.xml**, qui existe mais est en commentaire dans toute archive Tomcat téléchargée :

   ```xml
   <Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
   ```

3. Déclarez les deux fichiers war dans le fichier **conf/server.xml** et définissez un registre d'utilisateurs.

   ```xml
   <Context docBase ="analytics-service" path ="/analytics-service"></Context>
   <Context docBase ="analytics" path ="/analytics"></Context>
   <Realm className ="org.apache.catalina.realm.MemoryRealm"/>
   ```

   L'implémentation **MemoryRealm** reconnaît les utilisateurs qui sont définis dans le fichier **conf/tomcat-users.xml**. Pour plus d'informations sur les autres choix, voir [Apache Tomcat Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

4. Ajoutez les sections ci-dessous dans le fichier **conf/tomcat-users.xml** afin de configurer une implémentation **MemoryRealm**.
    * Ajoutez les rôles de sécurité.

      ```xml
      <role rolename="analytics_administrator"/>
      <role rolename="analytics_infrastructure"/>
      <role rolename="analytics_support"/>
      <role rolename="analytics_developer"/>
      <role rolename="analytics_business"/>
      ```
    * Ajoutez quelques utilisateurs avec les rôles de votre choix.

      ```xml
      <user name="admin" password="admin" roles="analytics_administrator"/>
      <user name="support" password="demo" roles="analytics_support"/>
      <user name="business" password="demo" roles="analytics_business"/>
      <user name="developer" password="demo" roles="analytics_developer"/>
      <user name="infrastructure" password="demo" roles="analytics_infrastructure"/>
      ```    
    * Démarrez votre serveur Tomcat et accédez à {{ site.data.keys.mf_analytics_console }}.

      ```xml
      http://localhost:8080/analytics/console
      ```

    Pour plus d'informations sur le démarrage du serveur Tomcat, voir le site officiel de Tomcat, par exemple [Apache Tomcat 7](http://tomcat.apache.org/tomcat-7.0-doc/introduction.html) pour Tomcat 7.0.

## Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server
{: #installing-mobilefirst-analytics-on-websphere-application-server }
Pour plus d'informations sur les étapes d'installation initiale permettant d'acquérir les artefacts d'installation (fichiers JAR et EAR), voir [Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](../../prod-env/appserver). Les fichiers **analytics.ear**, **analytics-ui.war** et **analytics-service.war** se trouvent dans le dossier **<rép_install_serveur_mf>\analytics**.

Les étapes ci-après expliquent comment installer et exécuter le fichier EAR d'Analytics sur WebSphere Application Server. Si vous installez les fichiers WAR individuels sur WebSphere Application Server, suivez uniquement les étapes 2 à 7 concernant le fichier WAR **analytics-service** après avoir déployé les deux fichiers WAR. L'ordre de chargement des classes ne doit pas être modifié dans le fichier WAR analytics-ui.

1. Déployez le fichier EAR sur le serveur d'applications, mais ne le démarrez pas . Pour plus d'informations sur l'installation d'un fichier EAR sur WebSphere Application Server, voir la rubrique [Installation de fichiers d'application d'entreprise à l'aide de la console](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_instwiz.html) dans la documentation du produit
WebSphere Application Server.

2. Sélectionnez l'application **MobileFirst Analytics** dans la liste **Applications d'entreprise**.

    ![Installation d'applications d'entreprise WebSphere](install_webphere_ent_app.jpg)

3. Cliquez sur **Chargement de classes et détection de mise à jour**.

    ![Chargement de classes dans WebSphere](install_websphere_class_load.jpg)

4. Définissez l'ordre de chargement des classes **Parent en dernier**.

    ![Changement de l'ordre de chargement des classes](install_websphere_app_class_load_order.jpg)

5. Cliquez sur **Mappage rôle de sécurité-utilisateur/groupe** pour mapper l'utilisateur admin.

    ![Ordre de chargement des classes war](install_websphere_sec_role.jpg)

6. Cliquez sur **Gestion des modules**.

    ![Gestion des modules dans WebSphere](install_websphere_manage_modules.jpg)

7. Sélectionnez le module **analytics** et remplacez l'ordre de chargement des classes par **Parent en dernier**.

    ![Module Analytics dans WebSphere](install_websphere_module_class_load_order.jpg)

8. Activez la **sécurité administrative** et la **sécurité des applications** dans la console d'administration WebSphere Application Server :
    * Connectez-vous à la console d'administration WebSphere Application Server.
    * Dans le menu **Sécurité > Sécurité globale**, vérifiez que les options **Activer la sécurité administrative** et **Activer la sécurité des applications** sont sélectionnées. Remarque : la sécurité des applications ne peut être sélectionnée que si la **sécurité administrative** est activée.
    * Cliquez sur **OK** et sauvegardez les modifications.

9. Pour que le service d'analyse soit accessible via la documentation Swagger, procédez comme suit :
    * Cliquez sur **Serveurs > Types de serveurs > Serveurs d'applications WebSphere** et choisissez dans la liste de serveurs le serveur sur lequel le service d'analyse est déployé.
    * Sous **Infrastructure du serveur**, cliquez sur **Java** puis sélectionnez **Gestion des processus et Java > Définition des processus > Machine virtuelle Java > Propriétés personnalisées**.
      - Définissez la propriété personnalisée suivante<br/>
        **Nom de la propriété :** *com.ibm.ws.classloader.strict*<br/>
        **Valeur :** *true*

10. Démarrez l'application {{ site.data.keys.mf_analytics }} et entrez l'adresse suivante dans le navigateur : `http://<hostname>:<port>/analytics/console`.

## Installation de {{ site.data.keys.mf_analytics }} à l'aide de tâches Ant
{: #installing-mobilefirst-analytics-with-ant-tasks }
Assurez-vous de disposer des fichiers de configuration WAR nécessaires : **analytics-ui.war** et **analytics-service.war**. Pour plus d'informations sur les artefacts d'installation, voir [Installation de {{ site.data.keys.mf_server }} sur un serveur d'applications](../../prod-env/appserver). Les fichiers **analytics-ui.war** et **analytics-service.war** se trouvent dans le dossier **MobileFirst_Platform_Server\analytics**.

Vous devez exécuter la tâche Ant sur l'ordinateur sur lequel est installé le serveur d'applications ou le gestionnaire de déploiement réseau pour WebSphere Application Server Network Deployment. Si vous souhaitez démarrer la tâche Ant depuis un ordinateur sur lequel {{ site.data.keys.mf_server }} n'est pas installé, vous devez copier le fichier **\<mf_server_install_dir\>/MobileFirstServer/mfp-ant-deployer.jar** sur cet ordinateur.

> Remarque : la marque de réservation **rép_install_serveur_mf** correspond au répertoire dans lequel vous avez installé {{ site.data.keys.mf_server }}.

1. Editez le script Ant que vous utiliserez ultérieurement pour déployer les fichiers WAR de {{ site.data.keys.mf_analytics }}.
    * Prenez connaissance des exemples de fichier de configuration dans [Exemples de fichier de configuration pour {{ site.data.keys.mf_analytics }}](../../installation-reference/#sample-configuration-files-for-mobilefirst-analytics).
    * Remplacez les marques de réservation par les propriétés au début du fichier.

    > Remarque : Les caractères spéciaux suivants doivent être associés à des caractères d'échappement lorsqu'ils sont utilisés dans les valeurs des scripts XML Ant :
    >
    > * Le symbole du dollar ($) doit être écrit sous la forme $$, sauf si vous voulez référencer explicitement une variable Ant via la syntaxe ${variable}, comme décrit dans la section [Properties](http://ant.apache.org/manual/properties.html) du manuel Apache Ant.
    > * Le caractère perluète (&) doit être écrit sous la forme &amp;, sauf si vous voulez référencer explicitement une entité XML.
    > * Les guillemets (") doivent être écrits sous la forme &quot;, sauf s'ils se trouvent dans une chaîne placée entre apostrophes. 

2. Si vous installez un cluster de noeuds sur plusieurs serveurs :
    * Vous devez supprimer la mise en commentaire de la propriété **wl.analytics.masters.list** et définir comme valeur la liste des noms d'hôte et des ports de transport des noeuds maîtres. Exemple : `noeud1.masociété.com:96000,noeud2.masociété.com:96000`
    * Ajoutez l'attribut **mastersList** aux éléments **elasticsearch** dans les tâches **installanalytics**, **updateanalytics** et **uninstallanalytics**.

    **Remarque :** si vous procédez à l'installation dans un cluster sur Application Server Network Deployment et que vous ne définissez pas la propriété, la tâche Ant calcule les noeuds finaux des données pour tous les membres du cluster au moment de l'installation et associe la propriété JNDI **masternodes** à cette valeur.

3. Pour déployer les fichiers WAR, exécutez la commande suivante : `ant -f configure-appServer-analytics.xml install`
    Elle se trouve dans le répertoire **rép_install_serveur_mf/shortcuts**. Elle installe un noeud de {{ site.data.keys.mf_analytics }} avec le type par défaut maître et données sur le serveur ou sur chaque membre d'un cluster si vous procédez à l'installation sur WebSphere Application Server Network Deployment.
4. Sauvegardez le fichier Ant. Vous en aurez peut-être besoin plus tard pour appliquer un groupe de correctifs ou effectuer une mise à niveau.
    Si vous ne voulez pas sauvegarder les mots de passe, vous pouvez les remplacer par "************" (12 astérisques) pour une invite interactive.

    **Remarque :** si vous ajoutez un noeud à un cluster de {{ site.data.keys.mf_analytics }}, vous devez mettre à jour la propriété JNDI analytics/masternodes pour qu'elle contienne les ports de tous les noeuds maîtres du cluster.

## Installation de {{ site.data.keys.mf_analytics_server }} sur des serveurs exécutant des versions précédentes
{: #installing-mobilefirst-analytics-server-on-servers-running-previous-versions }
Bien qu'il n'existe pas d'option permettant de mettre à niveau des versions précédentes de {{ site.data.keys.mf_analytics_server }}, lorsque vous installez {{ site.data.keys.mf_analytics_server }} version 8.0.0 sur un serveur qui a hébergé une version précédente, vous devez migrer certaines propriétés et données d'analyse.

Pour les serveurs qui ont exécuté précédemment des versions antérieures de {{ site.data.keys.mf_analytics_server }}, mettez à jour les données d'analyse et les propriétés JNDI.

### Migration des propriétés de serveur utilisées par des versions précédentes de {{ site.data.keys.mf_analytics_server }}
{: #migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server }
Si vous installez {{ site.data.keys.mf_analytics_server }} version 8.0.0 sur un serveur qui exécutait auparavant une version précédente de {{ site.data.keys.mf_analytics_server }}, vous devez mettre à jour les valeurs des propriétés JNDI sur ce serveur.

Certains types d'événement ont été modifiés entre les versions précédentes de {{ site.data.keys.mf_analytics_server }} et la version 8.0.0. En raison de cette évolution, les propriétés JNDI qui ont été configurées auparavant dans le fichier de configuration de votre serveur doivent être remplacées par le nouveau type d'événement.

Le tableau ci-dessous indique le mappage entre les anciens types d'événement et les nouveaux types d'événement. Certains types d'événement n'ont pas changé.

| Ancien type d'événement            | Nouveau type d'événement         |
|---------------------------|------------------------|
| AlertDefinition	        | AlertDefinition        |
| AlertNotification	        | AlertNotification      |
| AlertRunnerNode	        | AlertRunnerNode        |
| AnalyticsConfiguration    | AnalyticsConfiguration |
| CustomCharts	            | CustomChart            |
| CustomData	            | CustomData             |
| Devices	                | Device                 |
| MfpAppLogs                | AppLog                 |
| MfpAppPushAction          | AppPushAction          |
| MfpAppSession	            | AppSession             |
| ServerLogs	            | ServerLog              |
| ServerNetworkTransactions | NetworkTransaction     |
| ServerPushNotifications   | PushNotification       |
| ServerPushSubscriptions   | PushSubscription       |
| Users	                    | User                   |
| inboundRequestURL	        | resourceURL            |
| mfpAppName	            | appName                |
| mfpAppVersion	            | appVersion             |

### Migration des données d'analyse
{: #analytics-data-migration }
Les éléments internes de {{ site.data.keys.mf_analytics_console }} ont été améliorés ; par conséquent, le format dans lequel les données sont stockées a été changé. Pour que vous puissiez continuer d'interagir avec les données d'analyse qui ont déjà été collectées, celles-ci doivent être migrées vers le nouveau format de données.

Lorsque vous affichez {{ site.data.keys.mf_analytics_console }} pour la première fois après avoir procédé à la mise à niveau vers la version 8.0.0, aucune statistique n'est affichée. Vos données ne sont pas perdues ; elles doivent simplement être migrées vers le nouveau format de données.

Une alerte s'affiche sur chaque page de {{ site.data.keys.mf_analytics_console }} pour vous rappeler que les documents doivent être migrés. Le texte de l'alerte comporte un lien vers la page **Migration**.

L'image suivante illustre un exemple d'alerte dans la page **Présentation** de la section **Tableau de bord** :

![Alerte de migration dans la console](migration_alert.jpg)

### Page Migration
{: #migration-page }
Vous pouvez accéder à la page Migration depuis l'icône en forme de clé dans {{ site.data.keys.mf_analytics_console }}. La page **Migration** affiche le nombre de documents à migrer et leurs index de stockage. Une action seulement est disponible : **Effectuer la migration**.

L'image suivante représente la page **Migration** lorsque des documents doivent être migrés :

![Page Migration dans la console](migration_page.jpg)

> **Remarque :** ce processus peut prendre du temps, selon la quantité de données dont vous disposez, et ne peut pas être arrêté.

La migration d'un million de documents sur un noeud unique possédant 32 Go de mémoire RAM, avec 16 Go alloués à la machine virtuelle Java et un processeur à 4 coeurs, prend environ 3 minutes. Les documents qui ne sont pas migrés ne sont pas interrogés et, par conséquent, ne sont pas affichés dans {{ site.data.keys.mf_analytics_console }}.

Si la migration échoue pendant sa progression, relancez le processus. Une nouvelle tentative de migration ne migre pas à nouveau les documents qui ont déjà été migrés, et l'intégrité de vos données est conservée.
