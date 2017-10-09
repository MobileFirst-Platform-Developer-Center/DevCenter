---
layout: tutorial
title: Tutoriel d'installation de MobileFirst Server à partir de la ligne de commande
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Utilisez le mode de ligne de commande d'IBM Installation Manager et les tâches Ant pour installer {{ site.data.keys.mf_server }}.

#### Avant de commencer
{: #before-you-begin }
* Assurez-vous que l'une des bases de données suivantes et une version Java prise en charge sont installées. En outre, le pilote JDBC correspondant pour la base de données devra également être disponible sur votre ordinateur :
    * Système de gestion de base de données dans la liste de bases de données prises en charge :
        * DB2 
        * MySQL
        * Oracle

        > **Important :** Vous devez disposer d'une base de données dans laquelle vous pouvez créer les tables requises par le produit, et d'un utilisateur de base de données qui peut créer des tables dans cette base de données.

        Dans le tutoriel, les étapes permettant de créer les tables s'appliquent à DB2. Le programme d'installation de DB2 est disponible sous la forme d'un package de {{ site.data.keys.product }} eAssembly sur le site IBM Passport Advantage .

* Pilote JDBC pour votre base de données.
    * Pour DB2, utilisez le pilote JDBC DB2 de type 4.
    * Pour MySQL, utilisez le pilote JDBC Connector/J.
    * Pour Oracle, utilisez le pilote JDBC fin d'Oracle.
* Java version 7 ou ultérieure.

* Téléchargez le programme d'installation d'IBM Installation Manager version 1.8.4 ou ultérieure à partir du site [Installation Manager and Packaging Utility download documents](http://www.ibm.com/support/docview.wss?uid=swg27025142).
* Vous devez également disposer du référentiel d'installation de {{ site.data.keys.mf_server }} et du programme d'installation de WebSphere  Application Server Liberty Core version 8.5.5.3 ou ultérieure. Téléchargez ces packages à partir de {{ site.data.keys.product }} eAssembly sur le site Passport Advantage :

Référentiel d'installation de **{{ site.data.keys.mf_server }}**  
{{ site.data.keys.product }} V8.0 .zip file of Installation Manager Repository for {{ site.data.keys.mf_server }}

**Profil Liberty de WebSphere Application Server**  
IBM WebSphere Application Server - Liberty Core version 8.5.5.3 ou ultérieure
    
#### Accéder à
{: #jump-to }
* [Installation d'IBM Installation Manager](#installing-ibm-installation-manager)
* [Installation de WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core)
* [Installation de {{ site.data.keys.mf_server }}](#installing-mobilefirst-server)
* [Création d'une base de données](#creating-a-database)
* [Déploiement de {{ site.data.keys.mf_server }} sur Liberty à l'aide de tâches Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)
* [Test de l'installation](#testing-the-installation)
* [Création d'un parc de deux serveurs Liberty exécutant {{ site.data.keys.mf_server }}](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [Test du parc de serveurs et affichage des modifications dans {{ site.data.keys.mf_console }}](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

## Installation d'IBM Installation Manager
{: #installing-ibm-installation-manager }
Vous devez installer Installation Manager version 1.8.4 ou ultérieure. Les anciennes versions d'Installation Manager ne peuvent pas installer {{ site.data.keys.product }} V8.0 car les opérations de post-installation du produit nécessitent Java 7. Les anciennes version d'Installation Manager sont livrées avec Java 6.

1. Décompressez le fichier archive d'IBM Installation Manager que vous avez téléchargé. Le programme d'installation se trouve sur le site [Installation Manager and Packaging Utility download documents](http://www.ibm.com/support/docview.wss?uid=swg27025142).
2. Passez en revue le contrat de licence d'IBM Installation Manager figurant dans le répertoire **unzip\_IM\_1.8.x/license**.
3. Si vous acceptez les dispositions du contrat de licence, vous pouvez installer Installation Manager.  
    * Exécutez **installc.exe** pour installer Installation Manager en tant qu'administrateur. Les privilèges de superutilisateur sont requis sur Linux ou UNIX. Sous Windows, le privilège d'administrateur est requis. Dans ce mode, les informations sur les packages installés sont placées dans un emplacement partagé sur le disque et tout utilisateur autorisé à exécuter Installation Manager peut mettre à jour les applications. Le fichier exécutable se termine par "c" (**installc**) pour une installation à partir de la ligne de commande (sans faire appel à une interface graphique). Pour installer Installation Manager, entrez **installc.exe -acceptLicence**.
    * Exécutez **userinstc.exe** pour installer Installation Manager en mode utilisateur. Aucun privilège spécifique n'est requis. Toutefois, dans ce mode, les informations sur les packages installés sont placées dans le répertoire de base de l'utilisateur. Seul cet utilisateur peut mettre à jour les applications qui sont installées à l'aide d'Installation Manager. Le fichier exécutable se termine par "c" (**userinstc**) pour une installation à partir de la ligne de commande (sans faire appel à une interface graphique). Pour installer Installation Manager, entrez **userinstc.exe -acceptLicence**.
    
## Installation de WebSphere Application Server Liberty Core
{: #installing-websphere-application-server-liberty-core }
Le programme d'installation de WebSphere Application Server Liberty Core est fourni dans le package de {{ site.data.keys.product }}. Dans cette tâche, le profil Liberty est installé et une instance de serveur est créée de manière à vous permettre d'installer {{ site.data.keys.mf_server }} dessus.

1. Passez en revue le contrat de licence de WebSphere Application Server Liberty Core. Vous pouvez visualiser les fichiers de licence lorsque vous téléchargez le programme d'installation à partir de Passport Advantage.
2. Décompressez dans un dossier le fichier compressé de WebSphere Application Server Liberty Core que vous avez téléchargé.

    Dans les étapes décrites ci-après, le répertoire dans lequel vous décompressez le programme d'installation s'appelle **liberty\_repository\_dir**. Il contient entre autres un fichier **repository.config** ou un fichier **diskTag.inf**.

3. Choisissez le répertoire dans lequel installer le profil Liberty. Dans les étapes suivantes, ce répertoire s'appelle liberty_install_dir.
4. Démarrez une session de ligne de commande et accédez à **installation\_manager\_install\_dir/tools/eclipse/**.
5. Si vous acceptez les dispositions du contrat de licence, vous pouvez installer Liberty.
    
    Entrez la commande **imcl install com.ibm.websphere.liberty.v85 -repositories liberty\_repository\_dir -installationDirectory liberty\_install\_dir -acceptLicense**

    Cette commande installe Liberty dans le répertoire **liberty\_install\_dir**. L'option **-acceptLicense** signifie que vous acceptez les dispositions du contrat de licence relatif au produit.

6. Déplacez le répertoire qui contient les serveurs vers un emplacement ne nécessitant pas de privilèges spécifiques.

    Pour les besoins de ce tutoriel, si **liberty\_install\_dir** désigne un emplacement dans lequel un utilisateur qui n'est pas un administrateur ou qui ne dispose pas de privilèges superutilisateur ne peut pas modifier les fichiers, déplacez le répertoire contenant les serveurs vers un emplacement ne nécessitant pas de privilèges spécifiques. Ainsi, les opérations d'installation pourront être effectuées sans nécessiter de privilèges spécifiques.
    * Accédez au répertoire d'installation de Liberty.
    * Créez un répertoire nommé etc. Vous devez disposer de privilèges d'administrateur ou de superutilisateur.
    * Dans le répertoire **etc**, créez un fichier **server.env** avec le contenu suivant : `WLP_USER_DIR=<path to a directory where any user can write>`. Par exemple, sous Windows : `WLP_USER_DIR=C:\LibertyServers\usr`.
7.  Créez un serveur Liberty qui sera utilisé pour installer le premier noeud de {{ site.data.keys.mf_server }} ultérieurement dans le cadre du tutoriel.
    * Démarrez une session de ligne de commande.
    * Accédez à **liberty\_install\_dir/bin** et entrez **server create mfp1**.
    
    Cette commande crée une instance de serveur Liberty nommée **mfp1**. Sa définition se trouve dans **liberty\_install\_dir/usr/servers/mfp1** ou **WLP\_USER\_DIR/servers/mfp1** (si vous modifiez le répertoire comme indiqué à l'étape 6).
    
Une fois le serveur créé, vous pouvez le démarrer en exécutant la commande `server start mfp1` à partir du répertoire**liberty\_install\_dir/bin/**.  
Pour arrêter le serveur, exécutez la commande `server stop mfp1` à partir du répertoire **liberty\_install\_dir/bin/**.

La page d'accueil par défaut se trouve sur le site [http://localhost:9080](http://localhost:9080).

> **Remarque :** Pour la production, vous devez vous assurer que le serveur Liberty est démarré en tant que service lorsque l'ordinateur hôte démarre. La procédure de démarrage du serveur Liberty en tant que service n'est pas décrite dans le cadre de ce tutoriel.

## Installation de {{ site.data.keys.mf_server }}
{: #installing-mobilefirst-server }
Assurez-vous qu'Installation Manager version 1.8.4 ou ultérieure est installé. L'installation de {{ site.data.keys.mf_server }} peut ne pas aboutir avec une ancienne version d'Installation Manager car les opérations de post-installation nécessitent Java 7. Les anciennes version d'Installation Manager sont livrées avec Java 6.

Exécutez Installation Manager pour installer les fichiers binaires de {{ site.data.keys.mf_server }} sur votre disque avant de créer les bases de données et de déployer {{ site.data.keys.mf_server }} sur le profil Liberty. Lors de l'installation de {{ site.data.keys.mf_server }} à l'aide d'Installation Manager, une option permettant d'installer  {{ site.data.keys.mf_app_center }} vous est proposée. Application Center est un autre composant du produit. Pour les besoins de ce tutoriel, il n'est pas nécessaire de l'installer avec {{ site.data.keys.mf_server }}.

Vous devez également définir une propriété pour indiquer si l'octroi de licence de jeton doit être ou non activé. Dans ce tutoriel, on part du principe que l'octroi de licence de jeton n'est pas nécessaire, par conséquent, les étapes de configuration de {{ site.data.keys.mf_server }} pour l'octroi de licence de jeton ne sont pas incluses. En revanche, dans le cadre d'une installation en environnement de production, vous devrez déterminer si vous devez activer ou non l'octroi de licence de jeton. Si vous ne disposez pas d'un contrat d'utilisation de l'octroi de licence de jeton avec Rational License Key Server, vous n'avez pas besoin d'activer l'octroi de licence de jeton. Si vous activez cette option, vous devez configurer {{ site.data.keys.mf_server }} pour l'octroi de licence de jeton. 

Dans ce tutoriel, vous spécifiez les propriétés sous forme de paramètres via la ligne de commande **imcl**. Vous pouvez également vous servir d'un fichier de réponses pour spécifier les propriétés.

1. Passez en revue le contrat de licence de {{ site.data.keys.mf_server }}. Vous pouvez visualiser les fichiers de licence lorsque vous téléchargez le référentiel d'installation à partir de Passport Advantage.
2. Décompressez dans un dossier le fichier compressé du programme d'installation de {{ site.data.keys.mf_server }} que vous avez téléchargé.

    Dans les étapes décrites ci-après, le répertoire dans lequel vous décompressez le programme d'installation s'appelle **mfp\_repository\_dir**. Il contient un dossier **MobileFirst\_Platform\_Server/disk1**.
3. Démarrez une session de ligne de commande et accédez à **installation\_manager\_install\_dir/tools/eclipse/**.
4. Si vous acceptez les dispositions du contrat de licence que vous avez passé en revue à l'étape 1, vous pouvez installer {{ site.data.keys.mf_server }}.

    Entrez la commande suivante : `imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense`

    Les propriétés suivantes permettent d'obtenir une installation sans Application Center :
    * **user.appserver.selection2=none**
    * **user.database.selection2=none**
    * **user.database.preinstalled=false**

    La propriété suivante indique que l'octroi de licence de jeton n'est pas activé : **user.licensed.by.tokens=false**.  
    Affectez la valeur false à la propriété **user.use.ios.edition** pour installer {{ site.data.keys.product }}.

Un répertoire d'installation contenant les ressources nécessaires pour installer les composants {{ site.data.keys.product_adj }} est installé.  
Ces ressources figurent dans les dossiers suivants :

* Dossier **MobileFirstServer** pour {{ site.data.keys.mf_server }}
* Dossier **PushService** pour le service push de {{ site.data.keys.mf_server }}
* Dossier **ApplicationCenter** pour Application Center
* Dossier **Analytics** pour {{ site.data.keys.mf_analytics }}

L'objectif de ce tutoriel est d'installer {{ site.data.keys.mf_server }} à l'aide des ressources contenues dans le dossier **MobileFirstServer**.  
En outre, le dossier **shortcuts** contient des raccourcis pour l'outil de configuration de serveur, les tâches Ant et le programme **mfpadm**.

## Création d'une base de données
{: #creating-a-database }
Cette tâche consiste à s'assurer qu'une base de données existe dans le système de gestion de base de données et qu'un utilisateur est autorisé à utiliser la base de données, à créer des tables dans celle-ci et à utiliser ces tables. Vous pouvez ignorer cette tâche si vous prévoyez d'utiliser une base de données Derby.

La base de données permet de stocker les données techniques qui sont utilisées par les différents composants {{ site.data.keys.product_adj }} :

* Service d'administration de {{ site.data.keys.mf_server }}
* Service Live Update de {{ site.data.keys.mf_server }}
* Service push de {{ site.data.keys.mf_server }}
* L'environnement d'exécution de {{ site.data.keys.product_adj }}

Dans ce tutoriel, les tables de tous les composants sont placées sous le même schéma.  
**Remarque :** Les étapes de cette tâche s'appliquent à DB2. Si vous prévoyez d'utiliser MySQL ou Oracle, voir [Exigences en matière de base de données](../../databases/#database-requirements).

1. Connectez-vous à l'ordinateur qui exécute le serveur DB2. On part du principe qu'un utilisateur DB2, par exemple, **mfpuser**, existe.
2. Vérifiez que cet utilisateur DB2 peut accéder à une base de données dotée d'une taille de page d'au moins 32768 et qu'il est autorisé à créer des schémas et des tables implicites dans cette base de données.

    Par défaut, cet utilisateur est déclaré sur le système d'exploitation de l'ordinateur qui exécute DB2. Autrement dit, cet utilisateur dispose d'un ID de connexion pour cet ordinateur. Si cet utilisateur existe, l'action suivante décrite à l'étape 3 n'est pas requise.
3. Le cas échéant, créez une base de données avec la taille de page appropriée pour cette installation.
    * Ouvrez une session avec un ID utilisateur disposant des droits **SYSADM** ou **SYSCTRL**. Par exemple, utilisez l'ID utilisateur **db2inst1** ; il s'agit de l'administrateur créé par défaut par le programme d'installation de DB2.
    * Ouvrez un interpréteur de commandes DB2 :
        * Sous Windows, cliquez sur **Démarrer → IBM DB2 → Interpréteur de commandes**.
        * Sous Linux ou UNIX, accédez à **~/sqllib/bin** (ou **db2\_install\_dir/bin** si la bibliothèque sqllib n'est pas créée dans le répertoire de base de l'administrateur) et entrez `./db2`.
    * Entrez les instructions SQL suivantes pour créer une base de données appelée **MFPDATA** :
    
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

    Si vous avez défini un autre nom d'utilisateur, remplacez **mfpuser** par votre propre nom d'utilisateur.
    
    > **Remarque :** L'instruction ne retire pas les privilèges par défaut accordés à PUBLIC dans une base de données DB2 par défaut. Pour un environnement de production, vous devrez peut-être réduire les privilèges dans cette base de données au minimum requis pour le produit. Pour plus d'informations sur la sécurité DB2 et pour obtenir un exemple des pratiques de sécurité, voir [DB2 security, Part 8: Twelve DB2 security best practices](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/).

## Déploiement de {{ site.data.keys.mf_server }} sur Liberty à l'aide de tâches Ant
{: #deploying-mobilefirst-server-to-liberty-with-ant-tasks }
Vous utilisez les tâches Ant pour exécuter les opérations suivantes :

* Créer dans la base de données les tables requises par les applications {{ site.data.keys.product_adj }}
* Déployer les applications Web de {{ site.data.keys.mf_server }} (les composants d'environnement d'exécution, de service d'administration, de service Live Update, de service push et {{ site.data.keys.mf_console }}) sur le serveur Liberty

Les applications {{ site.data.keys.product_adj }} suivantes ne sont pas déployées à l'aide de tâches Ant :

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} est généralement déployé sur un ensemble de serveurs autre que {{ site.data.keys.mf_server }} en raison de ses exigences élevées en matière de mémoire. {{ site.data.keys.mf_analytics }} peut être installé manuellement ou à l'aide de tâches Ant. Si ce composant est déjà installé, vous pouvez entrer son URL, le nom d'utilisateur et le mot de passe afin de lui envoyer des données dans l'outil de configuration de serveur. L'outil de configuration de serveur configure ensuite les applications {{ site.data.keys.product_adj }} afin d'envoyer des données à {{ site.data.keys.mf_analytics }}. 

#### Application Center
{: #application-center }
Cette application peut être utilisée pour distribuer des applications mobiles en interne aux employés qui utilisent les applications, ou à des fins de test. Indépendante de {{ site.data.keys.mf_server }}, elle n'a pas besoin d'être installée en même temps que ce produit. 

Choisissez le fichier XML approprié contenant les tâches Ant et configurez les propriétés.

* Créez une copie du fichier **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-db2.xml** dans un répertoire de travail. Ce fichier contient les tâches Ant permettant d'installer {{ site.data.keys.mf_server }} sur Liberty avec DB2 comme base de données. Avant de l'utiliser, définissez les propriétés indiquant où déployer les applications de {{ site.data.keys.mf_server }}.
* Editez la copie du fichier XML et définissez les valeurs des propriétés suivantes :
    * Affectez à **mfp.admin.contextroot** la valeur **/mfpadmin**
    * Affectez à **mfp.runtime.contextroot** la valeur **/mfp**
    * Affectez à **database.db2.host** la valeur du nom d'hôte de l'ordinateur qui exécute votre base de données DB2. Si la base de données se trouve sur le même ordinateur que Liberty, utilisez **localhost**.
    * Affectez à **database.db2.port** le port sur lequel l'instance DB2 est en mode écoute. Par défaut, **50000**.
    * Affectez à **database.db2.driver.dir** le répertoire contenant votre pilote DB2 : **db2jcc4.jar** et **db2jcc\_license\_cu.jar**. Dans une distribution DB2 standard, ces fichiers se trouvent dans **db2\_install\_dir/java**.
    * Affectez à **database.db2.mfp.dbname** la valeur **MFPDATA** - Nom de base de données que vous créez à l'étape Création d'une base de données.
    * Affectez à **database.db2.mfp.schema** la valeur **MFPDATA** - Valeur du schéma dans lequel les tables pour {{ site.data.keys.mf_server }} seront créées. Si votre utilisateur de base de données ne peut pas créer un schéma, définissez une chaîne vide comme valeur. Par exemple, **database.db2.mfp.schema=""**.
    * Affectez à **database.db2.mfp.username** l'utilisateur DB2 qui crée les tables. Cet utilisateur utilise également les tables lors de l'exécution. Pour les besoins de ce tutoriel, utilisez **mfpuser**.
    * Affectez à **appserver.was.installdir** le répertoire d'installation de Liberty.
    * Affectez à **appserver.was85liberty.serverInstance** la valeur **mfp1** - Valeur du nom du serveur Liberty sur lequel {{ site.data.keys.mf_server }} doit être installé.
    * Affectez à **mfp.farm.configure** la valeur **false** pour installer {{ site.data.keys.mf_server }} en mode autonome.
    * Affectez à **mfp.analytics.configure** la valeur **false**. La connexion à {{ site.data.keys.mf_analytics }} n'est pas abordée dans ce tutoriel. Vous pouvez ignorer les autres propriétés mfp.analytics.****.
    * Affectez à **mfp.admin.client.id** la valeur **admin-client-id**.
    * Affectez à **mfp.admin.client.secret** la valeur **adminSecret** (ou choisissez un autre mot de passe secret).
    * Affectez à **mfp.push.client.id** la valeur **push-client-id**.
    * Affectez à **mfp.push.client.secret** la valeur **pushSecret** (ou choisissez un autre mot de passe secret).
    * Affectez à **mfp.config.admin.user** le nom d'utilisateur du service Live Update de {{ site.data.keys.mf_server }}. Dans une topologie de parc de serveurs, le nom d'utilisateur doit être identique pour tous les membres du parc de serveurs.
    * Affectez à **mfp.config.admin.password** le mot de passe du service Live Update de {{ site.data.keys.mf_server }}. Dans le cadre d'une topologie de parc de serveurs, le mot de passe doit être identique pour tous les membres du parc de serveurs.
* Conservez les valeurs par défaut des propriétés suivantes :
    * true pour **mfp.admin.console.install**
    * **admin** pour **mfp.admin.default.user** - Nom d'un utilisateur par défaut qui est créé pour se connecter à {{ site.data.keys.mf_console }}.
    * **admin** pour **mfp.admin.default.user.initialpassword** - Mot de passe d'un utilisateur par défaut qui est créé pour se connecter à la console d'administration.
    * **Liberty** pour **appserver.was.profile**. Avec une valeur différente, la tâche Ant considère que l'installation est effectuée sur un serveur WebSphere Application Server.
* Sauvegardez le fichier une fois que vous avez défini les propriétés.
* Exécutez `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml` afin d'afficher la liste des cibles possibles pour le fichier Ant.
* Exécutez `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml databases` pour créer les tables de base de données.
* Exécutez `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml install` pour installer {{ site.data.keys.mf_server }}.

> **Remarque :** Si vous ne disposez pas de DB2 et que vous souhaitez tester l'installation avec une instance Derby intégrée comme base de données, utilisez le fichier**mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-derby.xml**. En revanche, vous ne pourrez pas exécuter la dernière étape de ce tutoriel (Création d'un parc de deux serveurs Liberty exécutant {{ site.data.keys.mf_server }}) car l'accès à la base de données Derby par plusieurs serveurs Liberty est impossible. Vous devez définir les propriétés sauf celles liées à DB2 (**database.db2**, ...). Pour Derby, affectez à la propriété **database.derby.datadir** la valeur du répertoire dans lequel la base de données Derby peut être créée. En outre, affectez à la propriété **database.derby.mfp.dbname** la valeur **MFPDATA**.

Les opérations suivantes sont exécutées par les tâches Ant :

1. Les tables pour les composants suivants sont créées dans la base de données :
    * Service d'administration et service Live Update. Les tables sont créées par la cible Ant `admdatabases`.
    * Composant d'environnement exécution. Les tables sont créées par la cible Ant `rtmdatabases`.
    * Service push. Les tables sont créées par la cible Ant `pushdatabases`.
2. Les fichiers WAR des divers composants sont déployés sur le serveur Liberty. Vous pouvez afficher les détails des opérations dans le journal sous les cibles `adminstall`, `rtminstall` et `pushinstall`.

Si vous avez accès au serveur DB2, vous pouvez répertorier les tables créées à l'aide des instructions suivantes :

1. Ouvrez un interpréteur de commandes DB2 à l'aide de mfpuser, comme indiqué à l'étape 3 de la section Création d'une base de données.
2. Entrez les Instructions SQL :

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

Tenez compte des facteurs de base de données suivants :

#### Remarque concernant l'utilisateur de base de données
{: #database-user-consideration }
Dans l'outil de configuration de serveur, un seul utilisateur de base de données est nécessaire. Cet utilisateur est utilisé pour créer les tables, mais il sert également d'utilisateur de source de données dans le serveur d'applications lors de l'exécution. Dans un environnement de production, vous souhaiterez peut-être restreindre au strict minimum les privilèges de l'utilisateur qui est utilisé lors de l'exécution (`SELECT / INSERT / DELETE / UPDATE)`, et par conséquent, fournir un autre utilisateur pour le déploiement dans le serveur d'applications. Les fichiers Ant qui sont fournis comme exemples utilisent également les mêmes utilisateurs dans les deux cas. Toutefois, dans le cas de DB2, vous souhaiterez peut-être créer vos propres versions de fichiers. Ainsi, vous pourrez distinguer l'utilisateur qui sert à créer les bases de données de l'utilisateur qui sert pour la source de données dans le serveur d'applications à l'aide des tâches Ant.

#### Création de tables de base de données
{: #database-tables-creation }
Pour un environnement de production, vous souhaiterez peut-être créer les tables manuellement. Par exemple, si votre administrateur de base de données souhaite remplacer certains paramètres par défaut ou affecter des espaces table spécifiques. Les scripts de base de données qui permettent de créer les tables sont disponibles dans **mfp\_server\_install\_dir/MobileFirstServer/databases** et **mfp\_server\_install\_dir/PushService/databases**. Pour plus d'informations, voir[Création des tables de base de données manuellement](../../databases/#create-the-database-tables-manually).

Le fichier **server.xml** et certains paramètres de serveur d'applications sont modifiés lors de l'installation. Avant chaque modification, une copie du fichier **server.xml** est créée, par exemple, **server.xml.bak**, **server.xml.bak1** et **server.xml.bak2**. Pour voir tout ce qui a été ajouté, vous pouvez comparer le fichier **server.xml** à la sauvegarde la plus ancienne (server.xml.bak). Sous Linux, vous pouvez utiliser la commande diff `--strip-trailing-cr server.xml server.xml.bak` pour voir les différences. Sous AIX , utilisez la commande `diff server.xml server.xml.bak` pour voir les différences.

#### Modification des paramètres de serveur d'applications (propre à Liberty) :
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Les fonctions Liberty sont ajoutées.

    Les fonctions sont ajoutées pour chaque application et peuvent être dupliquées. Par exemple, la fonction JDBC est utilisée pour le service d'administration et pour les composants d'environnement d'exécution. Cette duplication permet de retirer les fonctions d'une application lorsque celle-ci est désinstallée, sans affecter les autres applications. Par exemple, si vous décidez de désinstaller le service push d'un serveur et de l'installer sur un autre serveur. Toutefois, les topologies ne sont pas toutes possibles. Le service d'administration, le service Live Update et le composant d'environnement d'exécution doivent figurer sur le même serveur d'applications avec profil Liberty. Pour plus d'informations, voir [Contraintes sur le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }}](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime). La duplication des fonctions ne génère pas de problèmes sauf si les fonctions ajoutées sont en conflit. Un problème peut être généré lorsque les fonctions jdbc-40 et jdbc-41 sont ajoutées, mais pas lorsqu'une fonction est ajoutée deux fois.
    
2. `host='*'` est ajouté dans la déclaration `httpEndPoint`.

    Ce paramètre permet d'autoriser la connexion au serveur à partir de toutes les interfaces réseau. Pour un environnement de production, vous souhaiterez peut-être restreindre la valeur hôte du noeud final HTTP.
3. L'élément **tcpOptions** (**tcpOptions soReuseAddr="true"**) est ajouté dans la configuration de serveur pour redéfinir immédiatement les accès à un port sans programme d'écoute actif et pour améliorer le débit du serveur.
4. Un magasin de clés portant l'ID **defaultKeyStore** est créé, le cas échéant.

    Le magasin de clés sert à activer le port HTTPS et plus spécifiquement, à activer la communication JMX entre le service d'administration (mfp-admin-service.war) et le composant d'environnement d'exécution (mfp-server.war). Les deux applications communiquent via JMX. Dans le cas d'un profil Liberty, restConnector est utilisé pour permettre la communication entre les applications au sein d'un serveur unique et également entre les serveurs d'un parc de serveurs Liberty. Cela requiert l'utilisation de HTTPS. Pour le magasin de clés créé par défaut, le profil Liberty crée un certificat avec une période de validité de 365 jours. Cette configuration n'est pas destinée à un
usage en production. Pour un environnement de production, vous devez envisager d'utiliser votre propre certificat.    

    Pour activer JMX, un utilisateur doté d'un rôle d'administrateur (MfpRESTUser) est créé dans le registre de base. Son nom et son mot de passe sont fournis en tant que propriétés JNDI (mfp.admin.jmx.user et mfp.admin.jmx.pwd) et sont utilisés par le composant d'environnement d'exécution et le service d'administration pour exécuter des requêtes JMX. Dans les propriétés JMX globales, certaines propriétés sont utilisées pour définir le mode cluster (serveur autonome ou appartenant à un parc de serveurs). L'outil de configuration de serveur affecte à la propriété mfp.topology.clustermode la valeur Autonome dans le serveur Liberty. Dans la partie ultérieure de ce tutoriel relative à la création d'un parc de serveurs, la valeur de la propriété est remplacée par Cluster.
5. Création d'utilisateurs (également valide pour Apache Tomcat et WebSphere Application Server)
    * Utilisateurs facultatifs : l'outil de configuration de serveur crée un utilisateur test (admin/admin) que vous pouvez utiliser pour vous connecter à la console après l'installation.
    * Utilisateurs obligatoires : l'outil de configuration de serveur crée également un utilisateur (nommé configUser_mfpadmin et doté d'un mot de passe généré de manière aléatoire) qui sera utilisé par le service d'administration pour contacter le service Live Update local. Pour le serveur Liberty, MfpRESTUser est créé. Si votre serveur d'applications n'est pas configuré pour utiliser un registre de base (par exemple, un registre LDAP), l'outil de configuration de serveur est dans l'incapacité de demander le nom d'un utilisateur existant. Dans ce cas, vous devez utiliser des tâches Ant.
6. L'élément **webContainer** est modifié.

    La propriété personnalisée de conteneur Web `deferServletLoad` a pour valeur false. Le composant d'environnement d'exécution et le service d'administration doivent démarrer en même temps que le serveur. Ces composants peuvent alors enregistrer les beans JMX et démarrer la procédure de synchronisation qui permet au composant d'environnement d'exécution de télécharger toutes les applications et tous les adaptateurs qu'il doit prendre en charge.
7. Le programme d'exécution par défaut est personnalisé afin de définir des valeurs élevées pour `coreThreads` et `maxThreads` si vous utilisez Liberty version 8.5.5.5 ou antérieure. Le programme d'exécution par défaut est réglé automatiquement par Liberty à partir de la version 8.5.5.6.

    Ce paramètre permet d'éviter les problèmes de dépassement de délai d'attente qui rompent la séquence de démarrage du composant d'environnement d'exécution et du service d'administration sur certaines versions Liberty. Si cette instruction est absente, les erreurs suivantes peuvent être générées dans le fichier journal du serveur :
    
    > Impossible d'obtenir la connexion JMX pour accéder à un bean géré. Il peut s'agir d'une erreur de configuration : Délai d'attente dépassé pour la lecture
FWLSE3000E: Une erreur de serveur a été détectée.
    > FWLSE3012E: Erreur de configuration JMX. Impossible d'obtenir des beans gérés. Motif : "Délai d'attente dépassé pour la lecture".

#### Déclaration des applications
{: #declaration-of-applications }
Les applications suivantes sont installées :

* **mfpadmin** : service d'administration
* **mfpadminconfig** : service Live Update
* **mfpconsole** : {{ site.data.keys.mf_console }}
* **mobilefirs**t : composant d'exécution de {{ site.data.keys.product_adj }}
* **imfpush** : service push

L'outil de configuration de serveur installe toutes les applications sur le même serveur. Vous pouvez séparer les applications dans différents serveurs d'applications, mais sous certaines contraintes documentées dans la section [Topologies et flots réseau](../../topologies).  
Pour une installation sur différents serveurs, vous ne pouvez pas utiliser l'outil de configuration de serveur. Utilisez des tâches Ant pour installer le produit manuellement.

#### Service d'administration
{: #administration-service }
Le service d'administration permet de gérer les applications et les adaptateurs de {{ site.data.keys.product_adj }}, ainsi que leurs configurations. Il est sécurisé au moyen de rôles de sécurité. Par défaut, l'outil de configuration de serveur ajoute un utilisateur (admin) doté du rôle d'administrateur, et vous pouvez utiliser cet utilisateur pour vous connecter à la console à des fins de test. La configuration du rôle de sécurité doit être effectuée après une installation à l'aide de l'outil de configuration de serveur (ou à l'aide de tâches Ant). Vous souhaiterez peut-être mapper les utilisateurs ou les groupes provenant du registre de base ou d'un registre LDAP que vous configurez dans votre serveur d'applications à chaque rôle de sécurité.

Le chargeur de classe est défini avec l'option delegation parent last pour le profil Liberty et pour WebSphere Application Server, et pour toutes les applications {{ site.data.keys.product_adj }}. Ce paramètre permet d'éviter les conflits entre les classes fournies dans les applications {{ site.data.keys.product_adj }} et celles du serveur d'applications. Oublier de définir l'option delegation parent last pour le chargeur de classe est une source courante d'erreur lors de l'installation manuelle. Pour Apache Tomcat, cette déclaration n'est pas nécessaire.

Dans le profil Liberty, une bibliothèque commune est ajoutée à l'application pour déchiffrer les mots de passe transmis en tant que propriétés JNDI. L'outil de configuration de serveur définit deux propriétés JNDI obligatoires pour le service d'administration : **mfp.config.service.user** et **mfp.config.service.password**. Elles sont utilisées par le service d'administration pour établir une connexion au service Live Update à l'aide de son API REST. D'autres propriétés JNDI peuvent être définies pour régler l'application ou l'adapter aux spécificités de votre installation. Pour plus d'informations, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

L'outil de configuration de serveur définit également les propriétés JNDI (l'URL et les paramètres OAuth permettant d'enregistrer les clients confidentiels) pour la communication avec le service push.  
La source de données avec la base de données qui contient les tables du service d'administration est déclarée, tout comme une bibliothèque pour son pilote JDBC.

#### Service Live Update
{: #live-update-service }
Le service Live Update stocke des informations sur les configurations d'environnement d'exécution et d'application. Il est contrôlé par le service d'administration et doit toujours s'exécuter sur le même serveur que celui-ci. La racine de contexte est **context\_root\_of\_admin\_serverconfig**. Par exemple, **mfpadminconfig**. Le service d'administration part du principe que cette convention est respectée pour créer l'URL de ses demandes vers les services REST du service Live Update.

Le chargeur de classe est défini avec l'option delegation parent last, comme indiqué dans la section sur le service d'administration.

Le service Live Update possède un rôle de sécurité, **admin_config**. Un utilisateur doit être mappé à ce rôle. Son mot de passe et son ID de connexion doivent être fournis au service d'administration via les propriétés JNDI suivantes : **mfp.config.service.user** et **mfp.config.service.password**. Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }} ](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) et [Liste des propriétés JNDI pour le service Live Update de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service).

Cette application a également besoin d'une source de données dotée d'un nom JNDI sur le profil Liberty. La convention est **context\_root\_of\_config\_server/jdbc/ConfigDS**. Dans ce tutoriel, il est défini comme suit : **mfpadminconfig/jdbc/ConfigDS**. Dans une installation effectuée à l'aide de l'outil de configuration de serveur ou de tâches Ant, les tables du service Live Update figurent dans la même base de données et le même schéma que les tables du service d'administration. L'ID utilisateur permettant d'accéder à ces tables est également le même.

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} est déclarée avec les mêmes rôles de sécurité que ceux du service d'administration. Les utilisateurs qui sont mappés aux rôles de sécurité de {{ site.data.keys.mf_console }} doivent également être mappés aux mêmes rôles de sécurité du service d'administration. En effet, {{ site.data.keys.mf_console }} exécute des requêtes sur le service d'administration pour le compte de l'utilisateur de la console.

L'outil de configuration de serveur positionne une propriété JNDI, **mfp.admin.endpoint**, indiquant de quelle manière la console se connecte au service d'administration. La valeur par défaut définie par l'outil de configuration de serveur est `*://*:*/mfpadmin`. Ce paramètre signifie qu'il doit utiliser le même protocole, le même nom d'hôte et le même port que la demande HTTP entrante sur la console, et que la racine de contexte du service d'administration est /mfpadmin. Si vous souhaitez forcer le passage de la demande par un proxy Web, modifiez la valeur par défaut. Pour plus d'informations sur les valeurs possibles pour cette URL, ou pour toute information sur les autres propriétés JNDI possibles, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}. ](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)

Le chargeur de classe est défini avec l'option delegation parent last, comme indiqué dans la section sur le service d'administration.

#### L'environnement d'exécution de {{ site.data.keys.product_adj }}
{: #mobilefirst-runtime }
Cette application n'est pas sécurisée au moyen d'un rôle de sécurité. Il n'est pas nécessaire de se connecter avec un ID utilisateur connu du serveur Liberty pour accéder à cette application. Les demandes des appareils mobiles sont dirigées vers l'environnement d'exécution. Elles sont authentifiées par d'autres mécanismes propres au produit (par exemple, OAuth) et à la configuration des applications {{ site.data.keys.product_adj }}.

Le chargeur de classe est défini avec l'option delegation parent last, comme indiqué dans la section sur le service d'administration.

Cette application a également besoin d'une source de données dotée d'un nom JNDI sur le profil Liberty. La convention est **context\_root\_of\_runtime/jdbc/mfpDS**. Dans ce tutoriel, il est défini comme suit : **mobilefirst/jdbc/mfpDS**. Dans une installation effectuée à l'aide de l'outil de configuration de serveur ou de tâches Ant, les tables de l'environnement d'exécution figurent dans la même base de données et le même schéma que les tables du service d'administration. L'ID utilisateur permettant d'accéder à ces tables est également le même.

#### Service push
{: #push-service }
Cette application est sécurisée via le mécanisme OAuth. Les jetons OAuth valides doivent être inclus dans n'importe quelle demande HTTP émise sur le service.

La configuration de OAuth est effectuée via les propriétés JNDI (par exemple, l'URL du serveur d'autorisations, l'ID client et le mot de passe du service push). Les propriétés JNDI définissent également le plug-in de sécurité (**mfp.push.services.ext.security**) et indiquent qu'une base de données relationnelle est utilisée (**mfp.push.db.type**). Les demandes entre les appareils mobiles et le service push sont acheminées vers ce service. La racine de contexte du service push doit être /imfpush. Le logiciel SDK client calcule l'URL du service push en fonction de l'URL de l'environnement d'exécution avec la racine de contexte (**/imfpush**). Si vous souhaitez installer le service push sur un autre serveur que celui de l'environnement d'exécution, vous devez disposer d'un routeur HTTP capable d'acheminer les demandes des appareils vers le serveur d'applications approprié.

Le chargeur de classe est défini avec l'option delegation parent last, comme indiqué dans la section sur le service d'administration.

Cette application a également besoin d'une source de données dotée d'un nom JNDI sur le profil Liberty. Le nom JNDI est **imfpush/jdbc/imfPushDS**. Dans une installation effectuée à l'aide de l'outil de configuration de serveur ou de tâches Ant, les tables du service push figurent dans la même base de données et le même schéma que les tables du service d'administration. L'ID utilisateur permettant d'accéder à ces tables est également le même.

#### Autres fichiers modifiés
{: #other-files-modification }
Le fichier **jvm.options** de profil Liberty est modifié. Une propriété (**com.ibm.ws.jmx.connector.client.rest.readTimeout**) est définie de manière à éviter les problèmes de dépassement de délai d'attente avec JMX lors de la synchronisation de l'environnement d'exécution avec le service d'administration.

### Test de l'installation
{: #testing-the-installation }
Une fois l'installation terminée, vous pouvez utiliser cette procédure pour tester les composants qui sont installés.

1. Démarrez le serveur à l'aide de la commande **server start mfp1**. Le fichier binaire pour le serveur se trouve dans le répertoire **liberty\_install\_dir/bin**.
2. Testez {{ site.data.keys.mf_console }} avec un navigateur Web. Accédez à [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Par défaut, le serveur s'exécute sur le port 9080. Toutefois, vous pouvez vérifier le port dans l'élément `<httpEndpoint>`, comme cela est défini dans le fichier **server.xml**. Un écran de connexion s'affiche.

![Ecran de connexion de la console](mfpconsole_signin.jpg)

3. Connectez-vous avec **admin/admin**. Cet utilisateur est créé par défaut par l'outil de configuration de serveur.

    > **Remarque :** Si vous vous connectez à l'aide de HTTP, l'ID de connexion et le mot de passe sont envoyés en clair dans le réseau. Pour une connexion sécurisée, utilisez HTTPS pour vous connecter au serveur. Le port HTTPS du serveur Liberty est défini dans l'attribut httpsPort de l'élément `<httpEndpoint>` dans le fichier **server.xml**. Par défaut, il s'agit du port 9443.

4. Déconnectez-vous de la console à l'aide de la commande **Hello Admin → Sign Out**.
5. Entrez l'URL suivante : [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) dans le navigateur Web et acceptez le certificat. Par défaut, le serveur Liberty génère un certificat qui n'est pas connu de votre serveur Web. Vous devez accepter ce certificat. Mozilla Firefox présente cette certification sous la forme d'une exception de sécurité.
6. Reconnectez-vous avec **admin/admin**. L'ID de connexion et le mot de passe sont chiffrés entre votre navigateur Web et {{ site.data.keys.mf_server }}. Pour un environnement de production, vous souhaiterez peut-être fermer le port HTTP.

## Création d'un parc de deux serveurs Liberty exécutant {{ site.data.keys.mf_server }}
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
Dans cette tâche, vous allez créer un second serveur Liberty qui exécute le même serveur {{ site.data.keys.mf_server }} et est connecté à la même base de données. Dans un environnement de production, vous souhaiterez peut-être utiliser plusieurs serveurs afin de posséder suffisamment de serveurs pour prendre en charge le nombre de transactions par seconde requis pour vos applications mobiles aux heures pleines, ce qui vous permettra d'améliorer vos performances. Il est également recommandé d'éviter d'avoir un point de défaillance unique afin de disposer d'un système à haute disponibilité.

Lorsque plusieurs serveurs exécutent {{ site.data.keys.mf_server }}, ils doivent être configurés en tant que parc de serveurs. Cette configuration permet à n'importe quel service d'administration de contacter tous les environnements d'exécution d'un parc de serveurs. Si le cluster n'est pas configuré en tant que parc de serveurs, seul l'environnement d'exécution qui s'exécute dans le même serveur d'applications que le service d'administration qui exécute l'opération de gestion est averti. Les autres environnements d'exécution ne sont pas informés de la modification. Par exemple, si vous déployez une nouvelle version d'un adaptateur dans un cluster qui n'est pas configuré en tant que parc de serveurs, un seul serveur prend en charge le nouvel adaptateur. Les autres serveurs continuent de prendre en charge l'ancien adaptateur. Seule l'installation de serveurs sur WebSphere Application Server Network Deployment permet de disposer d'un cluster et de ne pas avoir besoin de configurer un parc de serveurs. Le service d'administration peut retrouver tous les serveurs en interrogeant les beans JMX à l'aide du gestionnaire de déploiement. Le gestionnaire de déploiement doit être actif pour que les opérations de gestion soient autorisées car il permet de fournir la liste des beans JMX {{ site.data.keys.product_adj }} de la cellule.

Lorsque vous créez un parc de serveurs, vous devez également configurer un serveur HTTP pour envoyer des requêtes à tous les membres du parc de serveurs. La configuration d'un serveur HTTP n'est pas abordée dans ce tutoriel. Ce tutoriel concerne uniquement la configuration du parc de serveurs dans le but de répliquer les opérations de gestion sur tous les composants d'environnement d'exécution du cluster.

1. Créez un second serveur Liberty sur le même ordinateur.
    * Démarrez une session de ligne de commande.
    * Accédez à **liberty\_install\_dir/bin** et entrez server create **mfp2**.

2. Modifiez les ports HTTP et HTTPS du serveur **mfp2** de sorte qu'ils ne génèrent pas de conflits avec les ports du serveur **mfp1**.
    * Accédez au répertoire du second serveur.

        Le répertoire est **liberty\_install\_dir/usr/servers/mfp2** ou **WLP\_USER\_DIR/servers/mfp2** (si vous modifiez le répertoire comme indiqué à l'étape 6 de la section Installation de WebSphere Application Server Liberty Core).
    * Editez le fichier **server.xml**. Remplacez

      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9080"
        httpsPort="9443" />
      ```
        
      par
        
      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9081"
        httpsPort="9444" />
      ```
        
      Grâce à cette modification, les ports HTTP et HTTPS du serveur mfp2 ne sont pas en conflit avec les ports du serveur mfp1. Prenez soin de modifier les ports avant d'exécuter l'installation de {{ site.data.keys.mf_server }}. Sinon, si vous modifiez le port après l'installation, vous devez également répercuter cette modification dans la propriété JNDI suivante : **mfp.admin.jmx.port**.

3. Copiez le fichier Ant que vous avez utilisé dans la rubrique [Déploiement de {{ site.data.keys.mf_server }} sur Liberty à l'aide de tâches Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks) et remplacez la valeur de la propriété**appserver.was85liberty.serverInstance** par **mfp2**. Les tâches Ant détectent que les bases de données existent et ne créent pas les tables (voir l'extrait de journal ci-après). Ensuite, les applications sont déployées sur le serveur.

   ```bash
   [configuredatabase] Checking connectivity to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser'...
   [configuredatabase] Database MFPDATA exists.
   [configuredatabase] Connection to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser' succeeded.
   [configuredatabase] Getting the version of MobileFirstAdmin database MFPDATA...
   [configuredatabase] Table MFPADMIN_VERSION exists, checking its value...
   [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
   [configuredatabase] Configuring MobileFirstAdmin database MFPDATA...
   [configuredatabase] The database is in latest version (8.0.0), no upgrade required.
   [configuredatabase] Configuration of MobileFirstAdmin database MFPDATA succeeded.
   ```

4. Testez les deux serveurs avec la connexion HTTP.
    * Ouvrez un navigateur Web.
    * Entrez l'URL suivante : [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). La console est prise en charge par le serveur mfp1.
    * Connectez-vous avec **admin/admin**.
    * Ouvrez un onglet dans le même navigateur Web et entrez l'URL suivante : [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole). La console est prise en charge par le serveur mfp2.
    * Connectez-vous avec admin/admin. Si l'installation a été correctement effectuée, la même page de bienvenue s'affiche dans les deux onglets après la connexion.
    * Revenez au premier onglet de navigateur et cliquez sur **Hello, admin → Télécharger le journal d'audit**. Vous êtes déconnecté de la console et l'écran de connexion réapparaît. Cette déconnexion n'est pas normale. Ce problème se produit parce que lorsque vous vous connectez au serveur mfp2, un jeton LTPA est créé et stocké dans votre navigateur sous la forme d'un cookie. Or, ce jeton LTPA n'est pas reconnu par le serveur mfp1. Le basculement d'un serveur vers un autre est susceptible de se produire dans un environnement de production lorsque vous disposez d'un équilibrage de charge HTTP devant le cluster. Pour résoudre ce problème, vous devez faire en sorte que les deux serveurs (mfp1 et mfp2) génèrent les jetons LTPA avec les mêmes clés secrètes. Copiez les clés LTPA du serveur mfp1 sur le serveur mfp2.
    
        * Arrêtez les deux serveurs à l'aide des commandes suivantes :
        
          ```bash
          server stop mfp1
          server stop mfp2
          ```
        
        * Copiez les clés LTPA du serveur mfp1 sur le serveur mfp2.
            A partir de **liberty\_install\_dir/usr/servers** ou **WLP\_USER\_DIR/servers**, exécutez l'une des commandes suivantes en fonction de votre système d'exploitation : 
            * Sous UNIX : `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
            * Sous Windows : `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * Redémarrez les serveurs. Le basculement d'un onglet de navigateur vers un autre ne nécessite pas de se reconnecter. Dans un parc de serveurs Liberty, tous les serveurs doivent disposer des mêmes clés LTPA.
    
5. Activez la communication JMX entre les serveurs Liberty.

    La communication JMX avec Liberty est effectuée à l'aide du connecteur REST Liberty via le protocole HTTPS. Pour activer cette communication, chaque serveur du parc de serveur doit être capable de reconnaître le certificat SSL des autres membres. Vous devez échanger les certificats HTTPS dans leurs magasins de clés. Utilisez des utilitaires IBM, tels que Keytool, inclus dans la distribution d'IBM JRE dans **java/bin**, pour configurer le magasin de clés. Les emplacements du magasin de clés et du magasin de clés de confiance sont définis dans le fichier **server.xml**. Par défaut, le magasin de clés du profil Liberty se trouve dans **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks**. Le mot de passe de ce magasin de clés par défaut, défini dans le fichier **server.xml**, est **mobilefirst**.
        
    > **Astuce :** Vous pouvez le modifier à l'aide de l'outil Keytool, mais vous devez également modifier le mot de passe dans le fichier server.xml de sorte que le serveur Liberty puisse lire ce magasin de clés. Dans ce tutoriel, utilisez le mot de passe par défaut.
    
    * Dans **WLP\_USER\_DIR/servers/mfp1/resources/security**, entrez `keytool -list -keystore key.jks`. La commande affiche les certificats dans le magasin de clés. Il existe un seul certificat nommé **default**. Vous êtes invité à entrer le mot de passe du magasin de clés (mobilefirst) avant de pouvoir visualiser les clés. C'est le cas pour toutes les commandes suivantes exécutées avec l'utilitaire Keytool.
    * Exportez le certificat par défaut du serveur mfp1 à l'aide de la commande `keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`.
    * Dans **WLP\_USER\_DIR/servers/mfp2/resources/security**, exportez le certificat par défaut du serveur mfp2 à l'aide de la commande `keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`.
    * Dans le même répertoire, importez le certificat du serveur mfp1 à l'aide de la commande `keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`. Le certificat du serveur mfp1 est importé dans le magasin de clés du serveur mfp2 de sorte que celui-ci puisse approuver les connexions HTTPS au serveur mfp1. Vous êtes invité à confirmer que vous approuvez le certificat.
    * Dans **WLP\_USER\_DIR/servers/mfp1/resources/security**, importez le certificat du serveur mfp2 à l'aide de la commande `keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`. Après cette étape, les connexions HTTPS entre les deux serveurs sont possibles.

## Test du parc de serveurs et affichage des modifications dans {{ site.data.keys.mf_console }}
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. Démarrez les deux serveurs :

   ```bash
   server start mfp1
   server start mfp2
   ```
        
2. Accédez à la console. Par exemple, [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) ou [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) dans HTTPS. Dans la barre de navigation de gauche, un menu supplémentaire appelé **Noeuds de parc de serveurs** apparaît. Si vous cliquez sur **Noeuds de parc de serveurs**, le statut de chaque noeud s'affiche. Vous devrez peut-être attendre un peu avant que les deux noeuds démarrent.
