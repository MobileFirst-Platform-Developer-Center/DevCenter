---
layout: tutorial
title: Configuration des bases de données
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Les composants {{ site.data.keys.mf_server_full }} suivants doivent stocker des données techniques dans une base de données :

* Le service d'administration de {{ site.data.keys.mf_server }}
* Le service Live Update de {{ site.data.keys.mf_server }}
* Le service push de {{ site.data.keys.mf_server }}
* L'environnement d'exécution de {{ site.data.keys.product }}

> **Remarque :** si plusieurs instances d'exécution sont installées avec une racine de contexte différente, chaque instance requiert son propre ensemble de tables.
> La base de données peut être une base de données relationnelle telle qu'IBM DB2, Oracle ou MySQL.

#### Bases de données relationnelles (DB2, Oracle ou MySQL)
{: #relational-databases-db2-oracle-or-mysql }
Chaque composant requiert un ensemble de tables. Vous pouvez créer les tables manuellement en exécutant les scripts SQL propres à chaque composant (voir [Création manuelle des tables de base de données](#create-the-database-tables-manually)), à l'aide de tâches Ant, ou en utilisant l'outil de configuration de serveur. Les noms de table de chaque composant ne se chevauchent pas. Par conséquent, il est possible de placer toutes les tables de ces composants sous un schéma unique.

Toutefois, si vous décidez d'installer plusieurs instances d'exécution de {{ site.data.keys.product }}, chacune avec sa propre racine de contexte sur le serveur d'applications, chaque instance requiert son propre ensemble de tables. Dans ce cas, les tables doivent se trouver dans des schémas différents.

> **Remarque sur DB2 :** les détenteurs de licence {{ site.data.keys.product_adj }} peuvent utiliser DB2 comme système de support pour Foundation. Pour ce faire, après avoir installé le logiciel DB2, vous devez :
>
> * Télécharger l'image d'activation de l'utilisation restreinte directement depuis le [site Web IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)
> * Appliquer le fichier de licence d'activation de l'utilisation restreinte **db2xxxx.lic** avec la commande **db2licm**
>
> Consultez l'[IBM Knowledge Center de DB2](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html) pour en savoir plus.

#### Aller à
{: #jump-to }

* [Utilisateurs de base de données et droits](#database-users-and-privileges)
* [Configuration requise pour la base de données](#database-requirements)
* [Création manuelle des tables de base de données](#create-the-database-tables-manually)
* [Création des tables de base de données avec l'outil de configuration de serveur](#create-the-database-tables-with-the-server-configuration-tool)
* [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks)

## Utilisateurs de base de données et droits
{: #database-users-and-privileges }
A l'exécution, les applications {{ site.data.keys.mf_server }} sur le serveur d'applications utilisent des sources de données comme ressources afin d'obtenir une connexion aux bases de données relationnelles. La source de données requiert un utilisateur disposant de certains droits permettant d'accéder à la base de données.

Vous devez configurer une source de données pour que chaque application {{ site.data.keys.mf_server }} déployée sur le serveur d'applications ait accès à la base de données relationnelle. La source de données requiert un utilisateur disposant de droits spécifiques permettant d'accéder à la base de données. Le nombre d'utilisateurs que vous devez créer dépend de la procédure d'installation qui est utilisée pour déployer des applications {{ site.data.keys.mf_server }} sur le serveur d'applications.

### Installation avec l'outil de configuration de serveur
{: #installation-with-the-server-configuration-tool }
Le même utilisateur est utilisé pour tous les composants (service d'administration de {{ site.data.keys.mf_server }}, service de configuration de {{ site.data.keys.mf_server }}, service push de {{ site.data.keys.mf_server }} et environnement d'exécution de {{ site.data.keys.product }}).

### Installation à l'aide de tâches Ant
{: #installation-with-ant-tasks }
Les exemples de fichier Ant qui sont fournis avec la distribution du produit utilisent le même utilisateur pour tous les composants. Toutefois, vous pouvez modifier les fichiers Ant pour indiquer des utilisateurs différents :

* Un même utilisateur pour le service d'administration et le service de configuration, car ces services ne peuvent pas être installés séparément à l'aide de tâches Ant.
* Un utilisateur différent pour l'environnement d'exécution.
* Un utilisateur différent pour le service push.

### Installation manuelle
{: #manual-installation }
Il est possible d'affecter une source de données différente, et par conséquent un utilisateur différent, à chaque composant {{ site.data.keys.mf_server }}.
A l'exécution, les utilisateurs doivent disposer des droits suivants sur les tables et les séquences de données :

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Si les tables ne sont pas créées manuellement avant l'exécution de l'installation à l'aide de tâches Ant ou avec l'outil de configuration de serveur, assurez-vous de disposer d'un utilisateur pouvant créer les tables. Les droits suivants sont également requis :

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

Pour une mise à niveau du produit, les droits supplémentaires suivants sont requis :

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## Configuration requise pour la base de données
{: #database-requirements }
La base de données stocke toutes les données des applications {{ site.data.keys.mf_server }}. Avant d'installer les composants {{ site.data.keys.mf_server }}, vérifiez que la configuration requise pour la base de données existe.

* [Base de données DB2 et exigences utilisateur](#db2-database-and-user-requirements)
* [Base de données Oracle et exigences utilisateur](#oracle-database-and-user-requirements)
* [Base de données MySQL et exigences utilisateur](#mysql-database-and-user-requirements)

> Pour la liste à jour des versions des logiciels de base de données prises en charge, voir la page [Configuration système requise](../../../../product-overview/requirements/).

### Base de données DB2 et exigences utilisateur
{: #db2-database-and-user-requirements }
Prenez connaissance de la configuration requise pour la base de données DB2. Suivez les étapes permettant de créer un utilisateur et une base de données et de configurer votre base de données conformément à la configuration requise spécifique.

Assurez-vous de définir UTF-8 comme jeu de caractères pour la base de données.

La taille de page de la base de données doit être d'au moins 32768. La procédure ci-après crée une base de données avec une taille de page de 32768. Elle crée également un utilisateur (**utilisateurmfp**), puis accorde à cet utilisateur l'accès à la base de données. Cet utilisateur peut ensuite être utilisé par l'outil de configuration de serveur ou les tâches Ant pour créer les tables.

1. Créez un utilisateur système, par exemple **utilisateurmfp**, dans un groupe d'administration DB2 tel que **DB2USERS**, à l'aide des commandes appropriées à votre système d'exploitation. Associez-lui un mot de passe, par exemple **utilisateurmfp**.
2. Ouvrez un processeur de ligne de commande DB2 en tant qu'utilisateur disposant des droits **SYSADM** ou **SYSCTRL**.
    * Sur les systèmes Windows, cliquez sur **Démarrer → IBM DB2 → Command Line Processor**.
    * Sur les systèmes Linux et UNIX, accédez à **~/sqllib/bin** et entrez `./db2`.
3. Pour créer la base de données de {{ site.data.keys.mf_server }}, entrez des instructions SQL similaires à l'exemple ci-dessous.

Remplacez le nom d'utilisateur **utilisateurmfp** par le vôtre.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER utilisateurmfp
DISCONNECT MFPDATA
QUIT
```

### Base de données Oracle et exigences utilisateur
{: #oracle-database-and-user-requirements }
Prenez connaissance de la configuration requise pour la base de données Oracle. Suivez les étapes permettant de créer un utilisateur et une base de données et de configurer votre base de données conformément à la configuration requise spécifique.

Assurez-vous de définir le jeu de caractères Unicode (AL32UTF8) comme jeu de caractères pour la base de données et UTF8 - Unicode 3.0 UTF-8 comme jeu de caractères national.  

L'utilisateur d'exécution (comme indiqué dans [Utilisateurs de base de données et droits](#database-users-and-privileges)) doit être associé à un espace table et disposer d'un quota suffisant pour pouvoir écrire les données techniques requises par les services de {{ site.data.keys.product }}. Pour plus d'informations sur les tables qui sont utilisées par le produit, voir [Bases de données d'exécution internes](../../installation-reference/#internal-runtime-databases).

Les tables doivent être créées dans le schéma par défaut de l'utilisateur d'exécution. Les tâches Ant et l'outil de configuration de serveur créent les tables dans le schéma par défaut de l'utilisateur transmis sous forme d'argument. Pour plus d'informations sur la création des tables, voir [Création manuelle des tables de base de données Oracle](#creating-the-oracle-database-tables-manually).

La procédure crée une base de données si nécessaire. Un utilisateur pouvant créer des tables et un index dans cette base de données est ajouté et utilisé comme utilisateur d'exécution.

1. Si vous ne disposez pas encore d'une base de données, utilisez l'assistant de configuration de base de données Oracle (DBCA) et suivez les étapes qu'il présente afin de créer une base de données à usage général nommée ORCL dans l'exemple suivant :
    * Utilisez un nom de base de données global de type **ORCL\_votre\_domaine** et l'identificateur système (SID) **ORCL**.
    * Dans l'onglet **Custom Scripts** de l'étape **Database Content**, n'exécutez pas les scripts SQL car vous devez d'abord créer un compte utilisateur.
    * Dans l'onglet **Character Sets** de l'étape **Initialization Parameters**, sélectionnez **Use Unicode (AL32UTF8) character set and UTF8 - Unicode 3.0 UTF-8 national character set**.
    * Terminez la procédure en acceptant les valeurs par défaut.
2. Créez un utilisateur de base de données en utilisant Oracle Database Control ou l'interpréteur de ligne de commande Oracle SQLPlus.
3. Avec Oracle Database Control :
    * Connectez-vous en tant que **SYSDBA**.
    * Accédez à la page **Users** et cliquez sur **Server**, puis sur **Users** dans la section **Security**.
    * Créez un utilisateur, par exemple **UTILISATEURMFP**.
    * Affectez les attributs suivants :
        * **Profile**: DEFAULT
        * **Authentication**: password
        * **Default tablespace**: USERS
        * **Temporary tablespace**: TEMP
        * **Status**: Unlocked
        * Add system privilege: CREATE SESSION
        * Add system privilege: CREATE SEQUENCE
        * Add system privilege: CREATE TABLE
        * Add quota: Unlimited for tablespace USERS
    * Avec l'interpréteur de ligne de commande Oracle SQLPlus :

Les commandes de l'exemple suivant créent un utilisateur nommé **UTILISATEURMFP** pour la base de données :

```sql
CONNECT SYSTEM/<mot_de_passe_SYSTEM>@ORCL
CREATE USER MFPUSER IDENTIFIED BY mot_de_passe_UTILISATEURMFP DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### Base de données MySQL et exigences utilisateur
{: #mysql-database-and-user-requirements }
Prenez connaissance de la configuration requise pour la base de données MySQL. Suivez les étapes permettant de créer un utilisateur et une base de données et de configurer votre base de données conformément à la configuration requise spécifique.

Assurez-vous de définir UTF-8 comme jeu de caractères.

Les propriétés suivantes doivent être associées à des valeurs appropriées :

* max_allowed_packet à 256 M ou plus
* innodb_log_file_size à 250 M ou plus

Pour plus d'informations sur la définition des propriétés, voir la [documentation de MySQL](http://dev.mysql.com/doc/).  
La procédure crée une base de données (MFPDATA) et un utilisateur (utilisateurmfp) pouvant se connecter à la base de données avec tous les droits depuis un hôte (hôte-mfp).

1. Exécutez un client de ligne de commande MySQL avec l'option `-u root`.
2. Entrez les commandes suivantes :

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'utilisateurmfp'@'hôte-mfp' IDENTIFIED BY 'mot_de_passe-utilisateurmfp';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'utilisateurmfp'@'localhost' IDENTIFIED BY 'mot_de_passe-utilisateurmfp';
   FLUSH PRIVILEGES;
   ```

    Où utilisateurmfp avant l'arobase (@) correspond au nom d'utilisateur, **mot_de_passe_utilisateurmfp** après **IDENTIFIED BY** correspond au mot de passe de cet utilisateur, et **hôte-mfp** correspond au nom de l'hôte sur lequel s'exécute {{ site.data.keys.product_adj }}.

    L'utilisateur doit pouvoir se connecter au serveur MySQL depuis les hôtes qui exécutent le serveur d'applications Java sur lequel sont installées les applications {{ site.data.keys.mf_server }}.

## Création manuelle des tables de base de données
{: #create-the-database-tables-manually }
Vous pouvez créer les tables de base de données pour les applications {{ site.data.keys.mf_server }} manuellement à l'aide de tâches Ant ou avec l'outil de configuration de serveur. Les rubriques suivantes expliquent en détail comment créer les tables manuellement :

* [Création manuelle des tables de base de données DB2](#creating-the-db2-database-tables-manually)
* [Création manuelle des tables de base de données Oracle](#creating-the-oracle-database-tables-manually)
* [Création manuelle des tables de base de données MySQL](#creating-the-mysql-database-tables-manually)

### Création manuelle des tables de base de données DB2
{: #creating-the-db2-database-tables-manually }
Servez-vous des scripts SQL fournis dans l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données DB2.

Comme décrit dans la section Présentation, les quatre composants {{ site.data.keys.mf_server }} requièrent des tables. Celles-ci peuvent être créées dans un même schéma ou dans des schémas différents. Toutefois, certaines contraintes s'appliquent selon la façon dont les applications
{{ site.data.keys.mf_server }} sont déployées sur le serveur d'applications Java. Elles sont similaires à celles décrites dans la rubrique relative aux utilisateurs possibles pour DB2 [Utilisateurs de base de données et droits](#database-users-and-privileges).

#### Installation avec l'outil de configuration de serveur
{: #installation-with-the-server-configuration-tool-1 }
Le même schéma est utilisé pour tous les composants (service d'administration de {{ site.data.keys.mf_server }}, service Live Update de {{ site.data.keys.mf_server }}, service push de {{ site.data.keys.mf_server }} et environnement d'exécution de {{ site.data.keys.product }}).

#### Installation à l'aide de tâches Ant
{: #installation-with-ant-tasks-1 }
Les exemples de fichier Ant qui sont fournis avec la distribution du produit utilisent le même schéma pour tous les composants. Toutefois, vous pouvez modifier les fichiers Ant pour indiquer des schémas différents :

* Un même schéma pour le service d'administration et le service Live Update, car ces services ne peuvent pas être installés séparément à l'aide de tâches Ant.
* Un schéma différent pour l'exécution.
* Un schéma différent pour le service push.

#### Installation manuelle
{: #manual-installation-1 }
Il est possible d'affecter une source de données différente, et par conséquent un schéma différent, à chaque composant {{ site.data.keys.mf_server }}.  
Les scripts de création des tables se trouvent aux emplacements suivants :

* Pour le service d'administration, dans **rép\_install\_mfp/MobileFirstServer/databases/create-mfp-admin-db2.sql**.
* Pour le service Live Update, dans **rép\_install\_mfp/MobileFirstServer/databases/create-configservice-db2.sql**.
* Pour le environnement d'exécution, dans **rép\_install\_mfp/MobileFirstServer/databases/create-runtime-db2.sql**.
* Pour le service push, dans **rép\_install\_mfp/PushService/databases/create-push-db2.sql**.

La procédure ci-dessous crée les tables pour toutes les applications dans un même schéma (MFPSCM). Elle suppose qu'une base de données et qu'un utilisateur ont déjà été créés. Pour plus d'informations, voir [Base de données DB2 et exigences utilisateur](#db2-database-and-user-requirements).

Exécutez DB2 à l'aide des commandes suivantes avec l'utilisateur (utilisateurmfp) :

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf rép_install_mfp/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf rép_install_mfp/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf rép_install_mfp/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf rép_install_mfp/PushService/databases/create-push-db2.sql -t
```

Si les tables sont créées par utilisateurmfp, cet utilisateur dispose automatiquement des droits relatifs aux tables et peut les utiliser à l'exécution. Pour restreindre les droits de l'utilisateur d'exécution comme décrit dans [Utilisateurs de base de données et droits](#database-users-and-privileges) ou définir un contrôle plus précis des droits, voir la documentation de DB2.

### Création manuelle des tables de base de données Oracle
{: #creating-the-oracle-database-tables-manually }
Servez-vous des scripts SQL fournis dans l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données Oracle.

Comme décrit dans la section Présentation, les quatre composants {{ site.data.keys.mf_server }} requièrent des tables. Celles-ci peuvent être créées dans un même schéma ou dans des schémas différents. Toutefois, certaines contraintes s'appliquent selon la façon dont les applications
{{ site.data.keys.mf_server }} sont déployées sur le serveur d'applications Java. Les détails sont décrits dans la section [Utilisateurs de base de données et droits](#database-users-and-privileges).

Les tables doivent être créées dans le schéma par défaut de l'utilisateur d'exécution. Les scripts de création des tables se trouvent aux emplacements suivants :

* Pour le service d'administration, dans **rép\_install\_mfp/MobileFirstServer/databases/create-mfp-admin-oracle.sql**.
* Pour le service Live Update, dans **rép\_install\_mfp/MobileFirstServer/databases/create-configservice-oracle.sql**.
* Pour le composant d'exécution, dans **rép\_install\_mfp/MobileFirstServer/databases/create-runtime-oracle.sql**.
* Pour le service push, dans **rép\_install\_mfp/PushService/databases/create-push-oracle.sql**.

La procédure ci-dessous crée les tables pour toutes les applications pour un même utilisateur (**UTILISATEURMFP**). Elle suppose qu'une base de données et qu'un utilisateur ont déjà été créés. Pour plus d'informations, voir [Base de données Oracle et exigences utilisateur](#oracle-database-and-user-requirements).

Exécutez les commandes suivantes dans Oracle SQLPlus :

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@rép_install_mfp/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@rép_install_mfp/MobileFirstServer/databases/create-configservice-oracle.sql
@rép_install_mfp/MobileFirstServer/databases/create-runtime-oracle.sql
@rép_install_mfp/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

Si les tables sont créées par UTILISATEURMFP, cet utilisateur dispose automatiquement des droits relatifs aux tables et peut les utiliser à l'exécution. Les tables sont créées dans le schéma par défaut de l'utilisateur. Pour restreindre les droits de l'utilisateur d'exécution comme décrit dans [Utilisateurs de base de données et droits](#database-users-and-privileges) ou définir un contrôle plus précis des droits, voir la
documentation d'Oracle.

### Création manuelle des tables de base de données MySQL
{: #creating-the-mysql-database-tables-manually }
Servez-vous des scripts SQL fournis dans l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données MySQL.

Comme décrit dans la section Présentation, les quatre composants {{ site.data.keys.mf_server }} requièrent des tables. Celles-ci peuvent être créées dans un même schéma ou dans des schémas différents. Toutefois, certaines contraintes s'appliquent selon la façon dont les applications
{{ site.data.keys.mf_server }} sont déployées sur le serveur d'applications Java. Elles sont similaires à celles décrites dans la rubrique relative aux utilisateurs possibles pour MySQL [Utilisateurs de base de données et droits](#database-users-and-privileges).

#### Installation avec l'outil de configuration de serveur
{: #installation-with-the-server-configuration-tool-2 }
La même base de données est utilisée pour tous les composants (service d'administration de {{ site.data.keys.mf_server }}, service Live Update de {{ site.data.keys.mf_server }}, service push de {{ site.data.keys.mf_server }} et environnement d'exécution de {{ site.data.keys.product }}).

#### Installation à l'aide de tâches Ant
{: #installation-with-ant-tasks-2 }
Les exemples de fichier Ant qui sont fournis avec la distribution du produit utilisent la même base de données pour tous les composants. Toutefois, vous pouvez modifier les fichiers Ant pour indiquer des bases de données différentes :

* Une même base de données pour le service d'administration et le service Live Update, car ces services ne peuvent pas être installés séparément à l'aide de tâches Ant.
* Une base de données différente pour l'environnement d'exécution.
* Une base de données différente pour le service push.

#### Installation manuelle
{: #manual-installation-2 }
Il est possible d'affecter une source de données différente, et par conséquent une base de données différente, à chaque composant {{ site.data.keys.mf_server }}.  
Les scripts de création des tables se trouvent aux emplacements suivants :

* Pour le service d'administration, dans **rép\_install\_mfp/MobileFirstServer/databases/create-mfp-admin-mysql.sql**.
* Pour le service Live Update, dans **rép\_install\_mfp/MobileFirstServer/databases/create-configservice-mysql.sql**.
* Pour le composant d'exécution, dans **rép\_install\_mfp/MobileFirstServer/databases/create-runtime-mysql.sql**.
* Pour le service push, dans **rép\_install\_mfp/PushService/databases/create-push-mysql.sql**.

L'exemple ci-dessous crée les tables pour toutes les applications pour un même utilisateur et une même base de données. Il suppose qu'une base de données et un utilisateur ont été créés comme décrit dans [Configuration requise pour la base de données](#database-requirements) pour MySQL.

La procédure ci-dessous crée les tables pour toutes les applications pour un même utilisateur (utilisateurmfp) et une même base de données (MFPDATA). Elle suppose qu'une base de données et qu'un utilisateur ont déjà été créés.

1. Exécutez un client de ligne de commande MySQL avec l'option `-u utilisateurmfp`.
2. Entrez les commandes suivantes :

```sql
USE MFPDATA;
SOURCE rép_install_mfp/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE rép_install_mfp/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE rép_install_mfp/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE rép_install_mfp/PushService/databases/create-push-mysql.sql;
```

## Création des tables de base de données avec l'outil de configuration de serveur
{: #create-the-database-tables-with-the-server-configuration-tool }
Vous pouvez créer les tables de base de données pour les applications {{ site.data.keys.mf_server }} manuellement à l'aide de tâches Ant ou avec l'outil de configuration de serveur. Les rubriques ci-après expliquent en détail comment configurer la base de données lorsque vous installez
{{ site.data.keys.mf_server }} avec l'outil de configuration de serveur.

L'outil de configuration de serveur peut créer les tables de base de données dans le cadre du processus d'installation. Dans certains cas, il peut même créer une base de données et un utilisateur pour les composants {{ site.data.keys.mf_server }}. Pour une présentation du processus d'installation avec l'outil de configuration de serveur, voir [Installation de {{ site.data.keys.mf_server }} en mode graphique](../../simple-install/tutorials/graphical-mode).

Une fois que vous avez indiqué les données d'identification de configuration et cliqué sur **Deploy** dans la sous-fenêtre Server Configuration Tool, les opérations suivantes sont exécutées :

* Création de la base de données et de l'utilisateur si nécessaire.
* Vérification de l'existence des tables {{ site.data.keys.mf_server }} dans la base de données. Si elles n'existent pas, création des tables.
* Déploiement des applications {{ site.data.keys.mf_server }} sur le serveur d'applications.

Si les tables de base de données sont créées manuellement avant l'exécution de l'outil de configuration de serveur, celui-ci peut les détecter et ignorer la phase de configuration des tables.

Selon le système de gestion de base de données (SGBD) que vous avez choisi, reportez-vous à l'une des rubriques suivantes pour plus de détails sur la façon dont l'outil crée les tables de base de données :

* [Création des tables de base de données DB2 avec l'outil de configuration de serveur](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Création des tables de base de données Oracle avec l'outil de configuration de serveur](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [Création des tables de base de données MySQL avec l'outil de configuration de serveur](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### Création des tables de base de données DB2 avec l'outil de configuration de serveur
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
Servez-vous de l'outil de configuration de serveur fourni avec l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données DB2.

L'outil de configuration de serveur peut créer une base de données dans l'instance DB2 par défaut. Dans le panneau **Database Selection** de l'outil de configuration de serveur, sélectionnez l'option IBM DB2. Dans les trois sous-fenêtres suivantes, entrez les données d'identification de la base de données. Si le nom de base de données entré dans le panneau **Database Additional Settings** n'existe pas dans l'instance DB2, vous pouvez entrer des informations supplémentaires afin de permettre à l'outil de créer une base de données pour vous.

L'outil de configuration de serveur crée les tables de base de données avec les paramètres par défaut avec l'instruction SQL suivante :
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Cet élément ne doit pas être utilisé en production car dans une installation DB2 par défaut, de nombreux droits sont accordés à PUBLIC.

### Création des tables de base de données Oracle avec l'outil de configuration de serveur
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
Servez-vous de l'outil de configuration de serveur fourni avec l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données Oracle.

Dans le panneau Database Selection de l'outil de configuration de serveur, sélectionnez l'option **Oracle Standard or Enterprise Editions, 11g or 12c**. Dans les trois sous-fenêtres suivantes, entrez les données d'identification de la base de données.

Lorsque vous entrez le nom d'utilisateur Oracle dans le panneau **Database Additional Settings**, saisissez-le en majuscules. Si vous disposez d'un utilisateur de base de données Oracle (FOO) mais que vous entrez le nom d'utilisateur en minuscules (foo), l'outil de configuration de serveur considère qu'il s'agit d'un utilisateur différent. Contrairement aux autres outils pour la base de données Oracle, l'outil de configuration de serveur empêche la conversion automatique des noms d'utilisateur en majuscules.

L'outil de configuration de serveur utilise un nom de service ou un identificateur système Oracle (SID) pour identifier une base de données. Toutefois, si vous voulez établir la connexion à Oracle RAC, vous devez entrer une adresse URL JDBC complexe. Dans ce cas, dans le panneau **Database Settings**, sélectionnez l'option **Connect using generic Oracle JDBC URLs** et entrez une adresse URL pour le pilote léger
Oracle.

Si vous devez créer une base de données et un utilisateur pour Oracle, servez-vous de l'assistant de création de base de données Oracle (DBCA). Pour plus d'informations, voir [Base de données Oracle et exigences utilisateur](#oracle-database-and-user-requirements).

L'outil de configuration de serveur peut effectuer les mêmes opérations mais avec des limites. Il peut créer un utilisateur pour Oracle 11g ou Oracle 12g. Cependant, il peut créer une base de données pour Oracle 11g seulement, et non pour Oracle 12c.

Si le nom de base de données ou le nom d'utilisateur entré dans le panneau **Database Additional Settings** n'existe pas, reportez-vous aux deux sections ci-dessous qui décrivent les étapes supplémentaires permettant de créer la base de données ou l'utilisateur.

#### Création de la base de données
{: #creating-the-database }

1. Exécutez un serveur SSH sur l'ordinateur qui exécute la base de données Oracle.

    L'outil de configuration de serveur ouvre une session SSH sur l'hôte Oracle afin de créer la base de données. Sauf sur les systèmes Linux et certaines versions des systèmes UNIX, le serveur SSH est nécessaire même si la base de données Oracle s'exécute sur le même ordinateur que l'outil de configuration de serveur.

2. Dans le panneau **Database creation request**, entrez l'ID de connexion et le mot de passe d'un utilisateur de base de données Oracle qui dispose des droits permettant de créer une base de données.
3. Dans le même panneau, entrez également le mot de passe de l'utilisateur **SYS** et l'utilisateur **SYSTEM** pour la base de données à créer.

Une base de données est créée avec le nom d'identificateur système (SID) entré dans le panneau **Database Additional Settings**. Elle ne doit pas être utilisée en production.

#### Création de l'utilisateur
{: #creating-the-user }

1. Exécutez un serveur SSH sur l'ordinateur qui exécute la base de données Oracle.

    L'outil de configuration de serveur ouvre une session SSH sur l'hôte Oracle afin de créer la base de données. Sauf sur les systèmes Linux et certaines versions des systèmes UNIX, le serveur SSH est nécessaire même si la base de données Oracle s'exécute sur le même ordinateur que l'outil de configuration de serveur.

2. Dans le panneau **Database Additional Settings**, entrez l'ID de connexion et le mot de passe de l'utilisateur de base de données à créer.
3. Dans le panneau **Database creation request**, entrez l'ID de connexion et le mot de passe d'un utilisateur de base de données Oracle qui dispose des droits permettant de créer un utilisateur de base de données.
4. Dans le même panneau, entrez également le mot de passe de l'utilisateur **SYSTEM** de la base de données.

### Création des tables de base de données MySQL avec l'outil de configuration de serveur
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
Servez-vous de l'outil de configuration de serveur fourni avec l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données MySQL.

L'outil de configuration de serveur peut créer une base de données MySQL pour vous. Dans le panneau **Database Selection** de l'outil de configuration de serveur, sélectionnez l'option **MySQL 5.5.x, 5.6.x or 5.7.x**. Dans les trois sous-fenêtres suivantes, entrez les données d'identification de la base de données. Si la base de données ou l'utilisateur que vous entrez dans le panneau Database Additional Settings n'existe pas, l'outil peut la/le créer.

Si le serveur MySQL ne présente pas les paramètres recommandés dans [Base de données MySQL et exigences utilisateur](#mysql-database-and-user-requirements), l'outil de configuration de serveur affiche un avertissement. Assurez-vous de remplir les exigences avant d'exécuter l'outil de configuration de serveur.

La procédure ci-après décrit les étapes supplémentaires à effectuer lorsque vous créez les tables de base de données avec l'outil.

1. Dans le panneau **Database Additional Settings**, à côté des paramètres de connexion, vous devez entrer tous les hôtes à partir desquels l'utilisateur peut se connecter à la base de données, c'est-à-dire tous les hôtes sur lesquels s'exécute {{ site.data.keys.mf_server }}.
2. Dans le panneau **Database creation request**, entrez l'ID de connexion et le mot de passe d'un administrateur MySQL. Par défaut, l'administrateur est root.

## Création des tables de base de données à l'aide de tâches Ant
{: #create-the-database-tables-with-ant-tasks }
Vous pouvez créer les tables de base de données pour les applications {{ site.data.keys.mf_server }} manuellement à l'aide de tâches Ant ou avec l'outil de configuration de serveur. Les rubriques ci-dessous expliquent en détail comment créer les tables à l'aide de tâches Ant.

Vous trouverez dans cette section des informations pertinentes relatives à la configuration de la base de données si {{ site.data.keys.mf_server }} est installé à l'aide de tâches Ant.

Vous pouvez utiliser des tâches Ant pour configurer les tables de base de données {{ site.data.keys.mf_server }}. Dans certains cas, vous pouvez également créer une base de données et un utilisateur à l'aide de ces tâches. Pour une présentation du processus d'installation à l'aide de tâches Ant, voir [Installation de {{ site.data.keys.mf_server }} en mode de ligne de commande](../../simple-install/tutorials/command-line).

Un ensemble d'exemples de fichier Ant est fourni avec l'installation pour vous initier aux tâches Ant. Les fichiers se trouvent dans **rép\_install\_mfp/MobileFirstServer/configurations-samples**. Ils sont nommés selon le modèle suivant :

#### configure-appserver-sgbd.xml
{: #configure-appserver-dbmsxml }
Les fichiers Ant peuvent effectuer les tâches suivantes :

* Créer les tables dans une base de données si la base de données et l'utilisateur de base de données existent. La configuration requise pour la base de données est décrite dans [Configuration requise pour la base de données](#database-requirements).
* Déployer les fichiers WAR des composants {{ site.data.keys.mf_server }} sur le serveur d'applications. Ces fichiers Ant utilisent le même utilisateur de base de données pour créer les tables et pour installer l'utilisateur de base de données d'exécution pour les applications à l'exécution. Les fichiers utilisent également le même utilisateur de base de données pour toutes les applications {{ site.data.keys.mf_server }}.

#### create-database-sgbd.xml
{: #create-database-dbmsxml }
Les fichiers Ant peuvent créer une base de données, si nécessaire, sur le système de gestion de base de données (SGBD) pris en charge, puis créer les tables dans la base de données. Toutefois, étant donné que la base de données est créée avec les paramètres par défaut, elle ne doit pas être utilisée en production.

Dans les fichiers Ant, vous trouverez les cibles prédéfinies qui utilisent la tâche Ant **configureDatabase** pour configurer la base de données. Pour plus d'informations, voir la référence de tâche [Ant configuredatabase](../../installation-reference/#ant-configuredatabase-task-reference).

### Utilisation des exemples de fichier Ant
{: #using-the-sample-ant-files }
Les exemples de fichier Ant possèdent des cibles prédéfinies. Suivez la procédure ci-dessous pour utiliser les fichiers.

1. Copiez le fichier Ant en fonction de votre serveur d'applications et de votre configuration de base de données dans un répertoire de travail.
2. Editez le fichier et entrez les valeurs pour votre configuration dans la section `<! -- Start of Property Parameters -->` pour le fichier Ant.
3. Exécutez le fichier Ant avec la cible databases : `rép_install_mfp/shortcuts/ant -f votre_fichier_ant databases`.

Cette commande crée les tables dans la base de données et le schéma spécifiés pour toutes les applications {{ site.data.keys.mf_server }} (service d'administration de {{ site.data.keys.mf_server }}, service Live Update de {{ site.data.keys.mf_server }}, service push de {{ site.data.keys.mf_server }} et environnement d'exécution de {{ site.data.keys.mf_server }}). Un journal des opérations est généré et stocké sur votre disque.

* Sous Windows, il se trouve dans le répertoire **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\**.
* Sous UNIX, il se trouve dans le répertoire **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/**.

### Utilisateurs différents pour la création des tables de base de données et l'exécution
{: #different-users-for-the-database-tables-creation-and-for-run-time }
Les exemples de fichier Ant dans **rép\_install\_mfp/MobileFirstServer/configurations-samples** utilisent le même utilisateur de base de données pour :

* Toutes les applications {{ site.data.keys.mf_server }} (service d'administration, service Live Update, service push et environnement d'exécution).
* L'utilisateur qui est indiqué pour créer la base de données et l'utilisateur à l'exécution pour la source de données sur le serveur d'applications.

Si vous voulez séparer les utilisateurs comme décrit dans [Utilisateurs de base de données et droits](#database-users-and-privileges), vous devez créer votre propre fichier Ant ou modifier les exemples de fichier Ant pour que chaque cible de base de données possède un utilisateur différent. Pour plus d'informations, voir [Référence d'installation](../../installation-reference).

Pour DB2 et MySQL, des utilisateurs différents peuvent exister pour la création de base de données et l'exécution. Les droits pour chaque type d'utilisateur sont répertoriés dans [Utilisateurs de base de données et droits](#database-users-and-privileges). Pour Oracle, vous ne pouvez pas avoir un utilisateur différent pour la création de base de données et l'exécution. Les tâches Ant supposent que les tables se trouvent dans le schéma par défaut d'un utilisateur. Si vous voulez limiter les droits de l'utilisateur d'exécution, vous devez créer les tables manuellement dans le schéma par défaut de l'utilisateur qui sera indiqué à l'exécution. Pour plus d'informations, voir [Création manuelle des tables de base de données Oracle](#creating-the-oracle-database-tables-manually).

Selon le système de gestion de base de données (SGBD) que vous avez choisi, reportez-vous à l'une des rubriques suivantes pour apprendre à créer la base de données à l'aide de tâches Ant :

### Création des tables de base de données DB2 à l'aide de tâches Ant
{: #creating-the-db2-database-tables-with-ant-tasks }
Servez-vous des tâches Ant fournies avec l'installation de {{ site.data.keys.mf_server }} pour créer la base de données DB2.

Pour créer les tables de base de données dans une base de données qui existe déjà, voir [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks).

Pour créer une base de données et les tables de base de données, vous pouvez utiliser des tâches Ant. Celles-ci créent une base de données dans l'instance par défaut de DB2 si vous utilisez un fichier Ant contenant l'élément **dba**. Cet élément se trouve dans les exemples de fichier Ant nommés **create-database-<sgbd>.xml**.

Avant d'exécuter les tâches Ant, assurez-vous de disposer d'un serveur SSH sur l'ordinateur qui exécute la base de données DB2. La tâche Ant **configureDatabase** ouvre une session SSH sur l'hôte DB2 afin de créer la base de données. Le serveur SSH est nécessaire même si la base de données DB2 s'exécute sur l'ordinateur sur lequel vous exécutez les tâches Ant (sauf sur les systèmes Linux et certaines versions des systèmes UNIX).

Suivez les instructions générales décrites dans [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks) pour éditer la copie du fichier **create-database-db2.xml**.

Vous devez également fournir l'ID de connexion et le mot de passe d'un utilisateur DB2 disposant de privilèges d'administration (droits **SYSADM** ou **SYSCTRL**) dans l'élément **dba**. Dans l'exemple de fichier Ant pour DB2 (**create-database-db2.xml**), les propriétés à définir sont **database.db2.admin.username** et **database.db2.admin.password**.

Lorsque la cible Ant **databases** est appelée, la tâche Ant **configureDatabase** crée une base de données avec les paramètres par défaut avec l'instruction SQL suivante :

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Cet élément ne doit pas être utilisé en production car dans une installation DB2 par défaut, de nombreux droits sont accordés à PUBLIC.

### Création des tables de base de données Oracle à l'aide de tâches Ant
{: #creating-the-oracle-database-tables-with-ant-tasks }
Servez-vous des tâches Ant fournies avec l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données Oracle.

Lorsque vous entrez le nom d'utilisateur Oracle dans le fichier Ant, saisissez-le en majuscules. Si vous disposez d'un utilisateur de base de données Oracle (FOO) mais que vous entrez le nom d'utilisateur en minuscules (foo), la tâche Ant **configureDatabase** considère qu'il s'agit d'un utilisateur différent. Contrairement aux autres outils pour la base de données Oracle, la tâche Ant **configureDatabase** empêche la conversion automatique des noms d'utilisateur en majuscules.

La tâche Ant **configureDatabase** utilise un nom de service ou un identificateur système Oracle (SID) pour identifier une base de données. Toutefois, si vous voulez établir la connexion à Oracle RAC, vous devez entrer une adresse URL JDBC complexe. Dans ce cas, l'élément **oracle** qui se trouve dans la tâche Ant **configureDatabase** doit utiliser les attributs **url**, **user** et **password** à la place des attributs **database**, **server**, **port**, **user** et **password**. Pour plus d'informations, voir le tableau dans la [référence de tâche Ant **configuredatabase**](../../installation-reference/#ant-configuredatabase-task-reference). Les exemples de fichier Ant dans **rép\_install\_mfp/MobileFirstServer/configurations-samples** utilisent les attributs **database**, **server**, **port**, **user** et **password** définis dans l'élément **oracle**. Ils doivent être modifiés si vous devez vous connecter à Oracle à l'aide d'une adresse URL JDBC.

Pour créer les tables de base de données dans une base de données qui existe déjà, voir [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks).

Pour créer une base de données, un utilisateur ou les tables de base de données, utilisez l'assistant de création de base de données Oracle (DBCA). Pour plus d'informations, voir [Base de données Oracle et exigences utilisateur](#oracle-database-and-user-requirements).

La tâche Ant **configureDatabase** peut effectuer les mêmes opérations mais avec des limites. Elle peut créer un utilisateur de base de données pour Oracle 11g ou Oracle 12g. Cependant, elle peut créer une base de données pour Oracle 11g seulement, et non pour Oracle 12c. Reportez-vous aux deux sections ci-dessous qui décrivent les étapes supplémentaires permettant de créer la base de données ou l'utilisateur.

#### Création de la base de données
{: #creating-the-database-1 }
Suivez les instructions générales décrites dans [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks) pour éditer la copie du fichier **create-database-oracle.xml**.

1. Exécutez un serveur SSH sur l'ordinateur qui exécute la base de données Oracle.

    La tâche Ant **configureDatabase** ouvre une session SSH sur l'hôte Oracle afin de créer la base de données. Sauf sur les systèmes Linux et certaines versions des systèmes UNIX, le serveur SSH est nécessaire même si la base de données Oracle s'exécute sur le même ordinateur que celui sur lequel vous exécutez les tâches Ant.

2. Dans l'élément **dba** qui est défini dans le fichier **create-database-oracle.xml**, entrez l'ID de connexion et le mot de passe d'un utilisateur de base de données Oracle pouvant se connecter au serveur Oracle via SSH et disposant des droits permettant de créer une base de données. Vous pouvez affecter les valeurs dans les propriétés suivantes :
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. Dans l'élément **oracle**, entrez le nom de base de données à créer. L'attribut est **database**. Vous pouvez affecter la valeur dans la propriété **database.oracle.mfp.dbname**.
4. Dans le même élément **oracle**, entrez également le mot de passe de l'utilisateur **SYS** et l'utilisateur **SYSTEM** pour la base de données à créer. Les attributs sont **sysPassword** et **systemPassword**. Vous pouvez affecter les valeurs dans les propriétés correspondantes :
    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Une fois toutes les données d'identification de la base de données entrées dans le fichier Ant, sauvegardez le fichier et exécutez la cible Ant **databases**.

Une base de données est créée avec le nom d'identificateur système (SID) entré dans la base de données de l'élément **oracle**. Elle ne doit pas être utilisée en production.

#### Création de l'utilisateur
{: #creating-the-user-1 }
Suivez les instructions générales décrites dans [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks) pour éditer la copie du fichier **create-database-oracle.xml**.

1. Exécutez un serveur SSH sur l'ordinateur qui exécute la base de données Oracle.

    La tâche Ant **configureDatabase** ouvre une session SSH sur l'hôte Oracle afin de créer la base de données. Sauf sur les systèmes Linux et certaines versions des systèmes UNIX, le serveur SSH est nécessaire même si la base de données Oracle s'exécute sur le même ordinateur que celui sur lequel vous exécutez les tâches Ant.

2. Dans l'élément oracle qui est défini dans le fichier **create-database-oracle.xml**, entrez l'ID de connexion et le mot de passe d'un utilisateur de base de données Oracle à créer. Les attributs sont **user** et **password**. Vous pouvez affecter les valeurs dans les propriétés correspondantes :
    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. Dans le même élément **oracle**, entrez également le mot de passe de l'utilisateur **SYSTEM** pour la base de données. L'attribut est **systemPassword**. Vous pouvez affecter la valeur dans la propriété **database.oracle.systemPassword**.
4. Dans l'élément **dba**, entrez l'ID de connexion et le mot de passe d'un utilisateur de base de données Oracle qui dispose des droits permettant de créer un utilisateur. Vous pouvez affecter les valeurs dans les propriétés suivantes :
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Une fois toutes les données d'identification de la base de données entrées dans le fichier Ant, sauvegardez le fichier et exécutez la cible Ant **databases**.

Un utilisateur de base de données est créé avec le nom et le mot de passe entrés dans l'élément **oracle**. Cet utilisateur dispose des droits permettant de créer les tables {{ site.data.keys.mf_server }}, de les mettre à niveau et de les utiliser à l'exécution.

### Création des tables de base de données MySQL à l'aide de tâches Ant
{: #creating-the-mysql-database-tables-with-ant-tasks }
Servez-vous des tâches Ant fournies avec l'installation de {{ site.data.keys.mf_server }} pour créer les tables de base de données MySQL.

Pour créer les tables de base de données dans une base de données qui existe déjà, voir [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks).

Si le serveur MySQL ne présente pas les paramètres recommandés dans [Base de données MySQL et exigences utilisateur](#mysql-database-and-user-requirements), la tâche Ant **configureDatabase** affiche un avertissement. Assurez-vous de remplir les exigences avant d'exécuter la tâche Ant.

Pour créer une base de données et les tables de base de données, suivez les instructions générales décrites dans [Création des tables de base de données à l'aide de tâches Ant](#create-the-database-tables-with-ant-tasks) pour éditer la copie du fichier **create-database-mysql.xml**.

La procédure ci-après décrit les étapes supplémentaires à effectuer lorsque vous créez les tables de base de données à l'aide de la tâche Ant **configureDatabase**.

1. Dans l'élément **dba** qui est défini dans le fichier **create-database-mysql.xml**, entrez l'ID de connexion et le mot de passe d'un administrateur MySQL. Par défaut, l'administrateur est **root**. Vous pouvez affecter les valeurs dans les propriétés suivantes :
    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. Dans l'élément **mysql**, ajoutez un élément **client** pour chaque hôte depuis lequel l'utilisateur peut se connecter à la base de données, c'est-à-dire tous les hôtes sur lesquels s'exécute {{ site.data.keys.mf_server }}.
Une fois toutes les données d'identification de la base de données entrées dans le fichier Ant, sauvegardez le fichier et exécutez la cible Ant **databases**.
