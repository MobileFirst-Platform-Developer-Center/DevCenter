---
layout: tutorial
title: Référence d'installation
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Informations de référence sur les tâches Ant et les exemples de fichier de configuration pour l'installation d'{{ site.data.keys.mf_server_full }}, d'{{ site.data.keys.mf_app_center_full }} et d'{{ site.data.keys.mf_analytics_full }}.

#### Aller à
{: #jump-to }
* [Référence de la tâche Ant configuredatabase](#ant-configuredatabase-task-reference)
* [Tâches Ant pour l'installation de {{ site.data.keys.mf_console }}, des artefacts de {{ site.data.keys.mf_server }} et des services d'administration et Live Update de {{ site.data.keys.mf_server }}](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tâches Ant pour l'installation du service push de {{ site.data.keys.mf_server }}](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Tâches Ant pour l'installation d'Application Center](#ant-tasks-for-installation-of-application-center)
* [Tâches Ant pour l'installation de {{ site.data.keys.mf_analytics }}](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [Bases de données d'environnement d'exécution internes](#internal-runtime-databases)
* [Exemples de fichier de configuration](#list-of-sample-configuration-files)
* [Exemples de fichiers de configuration pour {{ site.data.keys.mf_analytics }}](#sample-configuration-files-for-mobilefirst-analytics)

## Référence de la tâche Ant configuredatabase
{: #ant-configuredatabase-task-reference }
Informations de référence relatives à la tâche Ant configuredatabase. Ces informations de référence concernent uniquement les bases de données relationnelles. Elles ne s'appliquent pas à Cloudant.

La tâche Ant **configuredatabase** crée les bases de données relationnelles qui sont utilisées par le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }}, le service push de {{ site.data.keys.mf_server }}, l'environnement d'exécution de {{ site.data.keys.product_adj }} et les services Application Center. Cette tâche Ant configure une base de données relationnelle à l'aide des actions suivantes :

* Elle vérifie si les tables {{ site.data.keys.product_adj }} existent et
les créent si nécessaire.
* Si les tables existent pour une version précédente de
{{ site.data.keys.product }}, elle les migre vers la version en cours.
* Si les tables existent pour la version en cours de
{{ site.data.keys.product }}, elle n'intervient pas.

De plus,
si l'une des conditions suivantes est remplie :

* Le type du système de gestion de base de données est Derby.
* Un élément interne `<dba>` est présent.
* Le type de système de gestion de base de données est DB2 et l'utilisateur spécifié dispose des droits nécessaires pour créer des bases de données.

La tâche peut avoir les effets suivants :

* Créer la base de données si nécessaire (sauf pour Oracle 12c, et Cloudant).
* Créer un utilisateur, si nécessaire, et lui attribuer les droits d'accès à la base de données.

> **Remarque :** La tâche Ant configuredatabase n'a aucun effet si vous l'utilisez avec Cloudant.

### Attributs et éléments pour la tâche configuredatabase
{: #attributes-and-elements-for-configuredatabase-task }

La tâche **configuredatabase** possède les
attributs ci-après.

| Attribut | Description | Obligatoire | Valeur par défaut |
|-----------|-------------|----------|---------|
| kind      | Type de base de données : Dans {{ site.data.keys.mf_server }} : MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin ou push. Dans Application Center : ApplicationCenter. | Oui | Aucune |
| includeConfigurationTables | Spécifier si des opérations de base de données doivent être exécutées à la fois sur le service Live Update et sur le service d'administration ou uniquement sur le service d'administration. La valeur est true ou false. |  Non | true |
| execute | Spécifier si la tâche Ant configuredatabase doit être exécutée. La valeur est true ou false. | Non | true |

#### kind
{: #kind }
{{ site.data.keys.product }} prend en charge quatre types de base de données : L'environnement d'exécution de {{ site.data.keys.product_adj }} utilise la base de données **MobileFirstRuntime**. Le service d'administration de {{ site.data.keys.mf_server }} utilise la base de données **MobileFirstAdmin**. Le service Live Update de {{ site.data.keys.mf_server }} utilise la base de données **MobileFirstConfig**. Par défaut, il est créé avec le type **MobileFirstAdmin**. Le service push de {{ site.data.keys.mf_server }} utilise la base de données **push**. Application Center utilise la base de données **ApplicationCenter**.

#### includeConfigurationTables
{: #includeconfigurationtables }
L'attribut **includeConfigurationTables** ne peut être utilisé que lorsque l'attribut **kind** a pour valeur **MobileFirstAdmin**. La valeur valide peut être true ou false. Lorsque cet attribut a pour valeur true, la tâche **configuredatabase** effectue des opérations de base de données à la fois sur la base de données du service d'administration et sur la base de données du service Live Update en une seule exécution. Lorsque cet attribut a pour valeur false, la tâche **configuredatabase** effectue des opérations de base de données uniquement sur la base de données du service d'administration.

#### execute
{: #execute }
L'attribut **execute** active ou désactive l'exécution de la tâche Ant **configuredatabase**. La valeur valide peut être true ou false. Lorsque cet attribut a pour valeur false, la tâche **configuredatabase** n'effectue pas d'opération de configuration ou de base de données.

La tâche **configuredatabase** prend en charge les éléments ci-après.

| Elément             | Description	                | Nombre |
|---------------------|-----------------------------|-------|
| `<derby>`           | Paramètres pour Derby.   | 0..1  |
| `<db2>`             |	Paramètres pour DB2.     | 0..1  |
| `<mysql>`           |	Paramètres pour MySQL.   | 0..1  |
| `<oracle>`          |	Paramètres pour Oracle.  | 0..1  |
| `<driverclasspath>` | Chemin de classe du pilote JDBC. | 0..1  |

Pour chaque type de base de données, vous pouvez utiliser un élément `<property>` afin de spécifier une propriété de connexion JDBC pour l'accès à la base de données. L'élément `<property>` possède les attributs suivants :

| Attribut | Description                | Obligatoire | Valeur par défaut |
|-----------|----------------------------|----------|---------|
| name      | Nom de la propriété.	 | Oui      | Aucune    |
| value	    | Valeur de la propriété.| Oui	    | Aucune    |   

#### Apache Derby
{: #apache-derby }
L'élément `<derby>` possède les attributs suivants :

| Attribut | Description                                | Obligatoire | Valeur par défaut                                                                      |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| database  | Nom de la base de données.                         | Non	    | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind.             |
| datadir   | Répertoire contenant les bases de données. | Oui      | Aucune                                                                         |
| schema	| Nom du schéma.                           | Non       | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH ou APPCENTER, selon l'attribut kind. |

L'élément `<derby>` prend en charge l'élément suivant :

| Elément      | Description                     | Nombre   |
|--------------|---------------------------------|---------|
| `<property>` | Propriété de connexion JDBC.   | 0..∞    |

Pour les propriétés disponibles, voir [Setting attributes for the database connection URL](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html).

#### DB2
{: #db2 }
L'élément `<db2>` possède les attributs suivants :

| Attribut | Description                            | Obligatoire | Valeur par défaut |
|-----------|----------------------------------------|----------|---------|
| database  | Nom de la base de données.                     | Non       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind. |
| server    | Nom d'hôte du serveur de base de données.	 | Oui      | Aucune  |
| port      | Port sur le serveur de base de données.       | Non	    | 50000 |
| user      | Nom d'utilisateur permettant d'accéder aux bases de données. | Oui	    | Aucune  |
| password  | Nom d'utilisateur permettant d'accéder aux bases de données.	 | Non	    | Demandée en mode interactif |
| instance  | Nom de l'instance DB2.          | Non	    | Dépend du serveur |
| schema    | Nom du schéma.                       | Non	    | Dépend de l'utilisateur   |

Pour plus d'informations sur les comptes utilisateur DB2, voir [DB2 security model overview](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
L'élément `<db2>` prend en charge les éléments suivants :

| Elément      | Description                             | Nombre   |
|--------------|-----------------------------------------|---------|
| `<property>` | Propriété de connexion JDBC.           | 0..∞    |
| `<dba>`      | Données d'identification de l'administrateur de base de données. | 0..1    |

Pour connaître les propriétés disponibles, voir [Properties for the IBM  Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).  
L'élément interne `<dba>` spécifie les données d'identification des administrateurs de base de données. Cet élément possède les attributs ci-après.

| Attribut | Description                            | Obligatoire | Valeur par défaut |
|-----------|----------------------------------------|----------|---------|
| user      | Nom d'utilisateur permettant d'accéder à la base de données.  | Oui      | Aucune    |
| password  | Mot de passe permettant d'accéder à la base de données.    | Non	    | Demandée en mode interactif |

L'utilisateur spécifié dans l'élément `<dba>` doit disposer du privilège DB2 SYSADM ou SYSCTRL. Pour plus d'informations, voir [Authorities overview](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html).

L'élément `<driverclasspath>` doit contenir les fichiers JAR pour le pilote JDBC DB2 et pour la licence qui lui est associée. Vous pouvez extraire ces fichiers de plusieurs façons :

* Téléchargez les pilotes JDBC DB2 depuis la page [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866) page
* Ou bien, procédez à l'extraction du fichier **db2jcc4.jar** et des fichiers **db2jcc_license_*.jar** qui lui sont associés à partir du répertoire **DB2_INSTALL_DIR/java** sur le serveur DB2.

Vous ne pouvez pas
spécifier de détails sur les allocations de table, comme l'espace table, avec la tâche Ant. Pour contrôler l'espace table, vous devez utiliser les instructions manuelles décrites dans la section [Exigences utilisateur et base de données DB2](../prod-env/databases/#db2-database-and-user-requirements).

#### MySQL
{: #mysql }
L'élément `<mysql>` possède les attributs suivants :

| Attribut | Description                            | Obligatoire | Valeur par défaut |
|-----------|----------------------------------------|----------|---------|
| database	| Nom de la base de données.	                 | Non       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind. |
| server	| Nom d'hôte du serveur de base de données.	 | Oui	    | Aucune |
| port	    | Port sur le serveur de base de données.	     | Non	    | 3306 |
| user	    | Nom d'utilisateur permettant d'accéder aux bases de données. | Oui	    | Aucune |
| password	| Nom d'utilisateur permettant d'accéder aux bases de données.	 | Non	    | Demandée en mode interactif |

Pour plus d'informations sur les comptes utilisateur MySQL, voir [MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).  
L'élément `<mysql>` prend en charge les éléments suivants :

| Elément      | Description                                      | Nombre |
|--------------|--------------------------------------------------|-------|
| `<property>` | Propriété de connexion JDBC.                    | 0..∞  |
| `<dba>`      | Données d'identification de l'administrateur de base de données.          | 0..1  |
| `<client>`   | Hôte autorisé à accéder à la base de données. | 0..∞  |

Pour connaître les propriétés disponibles, voir [Driver/Datasource
Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).
L'élément interne `<dba>` spécifie les données d'identification de l'administrateur de base de données. Cet élément possède les attributs ci-après.

| Attribut | Description                            | Obligatoire | Valeur par défaut |
|-----------|----------------------------------------|----------|---------|
| user	    | Nom d'utilisateur permettant d'accéder aux bases de données. | Oui	    | Aucune |
| password	| Nom d'utilisateur permettant d'accéder aux bases de données.	 | Non	    | Demandée en mode interactif |

L'utilisateur spécifié dans un élément `<dba>` doit être un compte superutilisateur MySQL. Pour plus d'informations, voir [Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html).

Chaque élément interne `<client>` spécifie un ordinateur client ou un caractère générique pour les ordinateurs client. Ces ordinateurs sont autorisés à se connecter à la base de données. Cet élément possède les attributs ci-après.

| Attribut | Description                                                              | Obligatoire | Valeur par défaut |
|-----------|--------------------------------------------------------------------------|----------|---------|
| hostname	| Nom d'hôte symbolique, adresse IP ou modèle avec % comme marque de réservation. | Oui	  | Aucune    |

Pour plus d'informations sur la syntaxe de l'attribut hostname, voir [Specifying Account Names](http://dev.mysql.com/doc/refman/5.5/en/account-names.html).

L'élément `<driverclasspath>` doit contenir un fichier JAR MySQL Connector/J. Vous pouvez télécharger ce fichier depuis la page [Download Connector/J](http://www.mysql.com/downloads/connector/j/).

Vous pouvez aussi utiliser l'élément `<mysql>` avec les attributs suivants :

| Attribut | Description                            | Obligatoire | Valeur par défaut               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | URL de connexion à la base de données.	         | Oui      | Aucune                  |
| user	    | Nom d'utilisateur permettant d'accéder aux bases de données. | Oui      | Aucune                  |
| password	| Nom d'utilisateur permettant d'accéder aux bases de données.	 | Non       | Demandée en mode interactif |

> `Remarque :` Si vous spécifiez la base de données avec des attributs alternatifs, cette base de données doit exister, le compte utilisateur doit exister et la base de données doit être déjà accessible pour l'utilisateur. Dans ce cas, la tâche **configuredatabase** ne tente pas de créer la base de données ou l'utilisateur ni d'accorder l'accès à l'utilisateur. La tâche **configuredatabase** garantit seulement que la base de données comporte les tables requises pour la version en cours de {{ site.data.keys.mf_server }}. Vous n'avez pas besoin de spécifier les éléments internes `<dba>` ou `<client>`.

#### Oracle
{: #oracle }
L'élément `<oracle>` possède les attributs suivants :

| Attribut      | Description                                                              | Obligatoire | Valeur par défaut |
|----------------|--------------------------------------------------------------------------|----------|---------|
| database       | Nom de base de données, ou nom de service Oracle. **Remarque :** Vous devez toujours utiliser un nom de service pour vous connecter à une base de données PDB. | Non | ORCL |
| server	     | Nom d'hôte du serveur de base de données.                                    | Oui      | Aucune |
| port	         | Port sur le serveur de base de données.                                         | Non       | 1521 |
| user	         | Nom d'utilisateur permettant d'accéder aux bases de données. Voir la note sous ce tableau.	| Oui      | Aucune |
| password	     | Nom d'utilisateur permettant d'accéder aux bases de données.                                    | Non       | Demandée en mode interactif |
| sysPassword	 | Mot de passe de l'utilisateur SYS.                                           | Non       | Demandée en mode interactif si la base de données n'existe pas encore |
| systemPassword | Mot de passe de l'utilisateur SYSTEM.                                        | Non       | Demandée en mode interactif si la base de données ou l'utilisateur n'existe pas encore |

> `Remarque:` Pour l'attribut user, utilisez plutôt un nom d'utilisateur en lettres majuscules. Les noms d'utilisateur Oracle sont en général
en lettres majuscules. A la différence des autres outils de bases de données, la tâche Ant **configuredatabase** ne convertit pas les majuscules en minuscules en ce qui concerne le nom d'utilisateur. Si la tâche Ant **configuredatabase** ne parvient pas à se connecter à la base de données, essayez de saisir une valeur en majuscules pour l'attribut **user**.

Pour plus d'informations sur les comptes utilisateur Oracle,
voir [Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).  
L'élément `<oracle>` prend en charge les éléments suivants :

| Elément      | Description                                      | Nombre |
|--------------|--------------------------------------------------|-------|
| `<property>` | Propriété de connexion JDBC.                    | 0..∞  |
| `<dba>`      | Données d'identification de l'administrateur de base de données.          | 0..1  |

Pour des informations sur les propriétés de connexion disponibles, voir [Class OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html).  
L'élément interne `<dba>` spécifie les données d'identification de l'administrateur de base de données. Cet élément possède les attributs ci-après.

| Attribut      | Description                                                              | Obligatoire | Valeur par défaut |
|----------------|--------------------------------------------------------------------------|----------|---------|
| user	         | Nom d'utilisateur permettant d'accéder aux bases de données. Voir la note sous ce tableau.	| Oui      | Aucune    |
| password	     | Nom d'utilisateur permettant d'accéder aux bases de données.                                    | Non       | Demandée en mode interactif |

L'élément `<driverclasspath>` doit contenir un fichier JAR de pilote JDBC Oracle. Vous pouvez télécharger des pilotes JDBC Oracle depuis la page [JDBC, SQLJ, Oracle JPublisher and Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

Vous ne pouvez pas spécifier de détails sur une allocation de table, comme l'espace table, avec la tâche Ant. Pour contrôler l'espace table, vous pouvez créer le compte utilisateur manuellement et lui affecter un espace table par défaut avant d'exécuter la tâche Ant. Pour contrôler les autres détails, vous devez utiliser les instructions manuelles décrites dans la section [Exigences utilisateur et base de données Oracle](../prod-env/databases/#oracle-database-and-user-requirements).

| Attribut | Description                            | Obligatoire | Valeur par défaut               |
|-----------|----------------------------------------|----------|-----------------------|
| url       | URL de connexion à la base de données.	         | Oui      | Aucune                  |
| user	    | Nom d'utilisateur permettant d'accéder aux bases de données. | Oui      | Aucune                  |
| password	| Nom d'utilisateur permettant d'accéder aux bases de données.	 | Non       | Demandée en mode interactif |

> **Remarque :** Si vous spécifiez la base de données avec des attributs alternatifs, cette base de données doit exister, le compte utilisateur doit exister et la base de données doit être déjà accessible pour l'utilisateur. Dans ce cas, la tâche ne tente pas de créer la base de données ou l'utilisateur ni d'accorder l'accès à l'utilisateur. La tâche **configuredatabase** garantit seulement que la base de données comporte les tables requises pour la version en cours de {{ site.data.keys.mf_server }}. Vous n'avez pas besoin de spécifier l'élément interne `<dba>`.

## Tâches Ant pour l'installation de {{ site.data.keys.mf_console }}, des artefacts de {{ site.data.keys.mf_server }} et des services d'administration et Live Update de {{ site.data.keys.mf_server }}
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
Les tâches Ant **installmobilefirstadmin**, **updatemobilefirstadmin** et **uninstallmobilefirstadmin** sont fournies pour l'installation de {{ site.data.keys.mf_console }}, du composant des artefacts, du service d'administration et du service Live Update.

### Effets des tâches
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
La tâche Ant **installmobilefirstadmin** configure un serveur d'applications pour exécuter les fichiers WAR du service d'administration et du service Live Update sous forme d'applications Web, et éventuellement, pour installer la {{ site.data.keys.mf_console }}. Elle a les effets suivants :

* Elle déclare l'application Web du service d'administration dans la racine de contexte spécifiée, par défaut, /mfpadmin.
* Elle déclare l'application Web du service Live Update dans une racine de contexte dérivée de la racine de contexte spécifiée pour le service d'administration. Par défaut, il s'agit de /mfpadminconfig.
* Pour les bases de données relationnelles, elle déclare les sources de données et, sur le profil complet de WebSphere Application Server, elle déclare les fournisseurs JDBC pour les services d'administration.
* Elle déploie le service d'administration et le service Live Update sur le serveur d'applications.
* Le cas échéant, elle déclare {{ site.data.keys.mf_console }} en tant qu'application Web dans la racine de contexte spécifiée, par défaut, /mfpconsole. Si l'instance de {{ site.data.keys.mf_console }} est spécifiée, la tâche Ant déclare l'entrée d'environnement JNDI appropriée pour communiquer avec le service de gestion correspondant. Exemple :

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* Le cas échéant, elle déclare l'application Web des artefacts {{ site.data.keys.mf_server }} dans la racine de contexte spécifiée, /mfp-dev-artifacts, lorsque {{ site.data.keys.mf_console }} est installé.
* Elle configure les propriétés de configuration pour le service d'administration à l'aide des entrées d'environnement JNDI. Ces entrées d'environnement JNDI fournissent également des informations supplémentaires sur la topologie du serveur d'applications ; par exemple, elles peuvent indiquer si la topologie est une configuration autonome, un cluster ou un parc de serveurs.
* Le cas échéant, elle configure les utilisateurs qu'elle mappe aux rôles utilisés par {{ site.data.keys.mf_console }}, ainsi que les applications Web des services d'administration et Live Update.
* Elle configure le serveur d'applications en vue de l'utilisation de JMX.
* Le cas échéant, elle configure la communication avec le service push de {{ site.data.keys.mf_server }}.
* Le cas échéant, elle définit les entrées d'environnement JNDI MobileFirst pour configurer le serveur d'applications en tant que membre de parc de serveurs pour le composant d'administration de {{ site.data.keys.mf_server }}.

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
La tâche Ant **updatemobilefirstadmin** met à jour une application Web {{ site.data.keys.mf_server }} déjà configurée sur un serveur d'applications. Elle a les effets suivants :

* Elle met à jour le fichier WAR du service d'administration. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.
* Elle met à jour le fichier WAR du service Live Update. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.
* Elle met à jour le fichier WAR de {{ site.data.keys.mf_console }}. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.
La tâche ne change pas la configuration du serveur d'applications, c'est-à-dire la configuration de l'application Web, les sources de données, les entrées d'environnement JNDI, les mappages des utilisateurs à des rôles et la configuration JMX.

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
La tâche Ant **uninstallmobilefirstadmin** annule les effets d'une précédente exécution de la tâche installmobilefirstadmin. Elle a les effets suivants :

* Elle supprime la configuration de l'application Web de service d'administration avec la racine de contexte spécifiée. En conséquence, elle supprime
également les paramètres ajoutés manuellement à cette application.
* Elle supprime les fichiers WAR des services d'administration et Live Update et la console {{ site.data.keys.mf_console }} du serveur d'applications en tant qu'option.
* Pour le système de gestion de base de données relationnelle, elle retire les sources de données et, sur le profil complet de WebSphere Application Server, elle retire les fournisseurs JDBC pour les services d'administration et Live Update.
* Pour le système de gestion de base de données relationnelle, elle retire du serveur d'applications les pilotes de base de données qui étaient utilisés par les services d'administration et Live Update.
* Elle supprime les entrées associées de l'environnement JNDI.
* Sur WebSphere Application Server Liberty et Apache Tomcat, elle retire les utilisateurs configurés par l'appel de la tâche installmobilefirstadmin.
* Elle supprime la configuration JMX.

### Attributs et éléments
{: #attributes-and-elements }
Les tâches Ant **installmobilefirstadmin**, **updatemobilefirstadmin** et **uninstallmobilefirstadmin** possèdent les attributs suivants :

| Attribut         | Description                                                              | Obligatoire | Valeur par défaut |
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | Préfixe commun pour les URL vers le service d'administration afin d'obtenir des informations sur les environnements d'exécution, les applications et les adaptateurs de {{ site.data.keys.product_adj }}. | Non | /mfpadmin |
| id                | Permet de distinguer différents déploiements.              | Non | Vide |
| environmentId     | Permet de distinguer différents environnements {{ site.data.keys.product_adj }}. | Non | Vide |
| servicewar        | Fichier WAR pour le service d'administration.       | Non | Le fichier mfp-admin-service.war se trouve dans le même répertoire que le fichier mfp-ant-deployer.jar. |
| shortcutsDir      | Répertoire dans lequel placer les raccourcis.            | Non | Aucune |
| wasStartingWeight | Ordre de démarrage pour WebSphere Application Server. Les valeurs les plus faibles démarrent en premier. | Non | 1 |

#### contextroot et id
{: #contextroot-and-id }
Les attributs **contextroot** et **id** permettent de distinguer différents déploiements de {{ site.data.keys.mf_console }} et du service d'administration.

Dans les profils Liberty de WebSphere Application Server et dans les environnements Tomcat, le paramètre contextroot est suffisant pour atteindre cet objectif. Dans les environnements de profil complet de WebSphere Application Server, l'attribut id est utilisé à la place. Sans l'attribut id, deux fichiers WAR possédant les mêmes racines de contexte pourraient entrer en conflit et ne pas être déployés.

#### environmentId
{: #environmentid }
Utilisez l'attribut **environmentId** pour distinguer plusieurs environnements, constitués chacun du service d'administration de {{ site.data.keys.mf_server }} et des applications Web d'environnement d'exécution de {{ site.data.keys.product_adj }}, qui doivent fonctionner indépendamment. Par exemple, avec cette option, vous pouvez héberger un environnement de test, un environnement de préproduction et un environnement de production sur le même serveur ou dans la même cellule WebSphere Application Server Network Deployment. Cet attribut environmentId crée un suffixe qui est ajouté aux noms de bean géré que le service d'administration et les projets d'exécution de {{ site.data.keys.product_adj }} utilisent lorsqu'ils communiquent via JMX (Java Management Extensions).

#### servicewar
{: #servicewar }
Utilisez un attribut **servicewar** afin de spécifier un autre répertoire pour le fichier WAR du service d'administration. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

#### shortcutsDir
{: #shortcutsdir }
L'attribut **shortcutsDir** indique où placer les raccourcis vers {{ site.data.keys.mf_console }}. Si vous le définissez, vous pouvez ajouter les fichiers suivants dans ce répertoire :

* **mobilefirst-console.url** - ce fichier est un raccourci Windows. Il ouvre
{{ site.data.keys.mf_console }} dans un navigateur.
* **mobilefirst-console.sh** - ce fichier est un script shell UNIX qui ouvre {{ site.data.keys.mf_console }} dans un navigateur.
* **mobilefirst-admin-service.url** - ce fichier est un raccourci Windows. Il s'ouvre dans un navigateur Web et appelle un service REST qui renvoie la liste des projets {{ site.data.keys.product_adj }} pouvant être gérés au format JSON. Pour chaque projet {{ site.data.keys.product_adj }} répertorié, des détails sur ses artefacts sont également disponibles, par exemple le nombre d'applications, le nombre d'adaptateurs, le nombre d'appareils actifs et le nombre d'appareils mis hors service. La liste indique aussi si l'environnement d'exécution du projet {{ site.data.keys.product_adj }} est en cours d'exécution ou en veille.
* **mobilefirst-admin-service.sh** - ce fichier est un script shell UNIX qui fournit la même sortie que le fichier **mobilefirst-admin-service.url**.

#### wasStartingWeight
{: #wasstartingweight }
Utilisez l'attribut **wasStartingWeight** pour spécifier une valeur qui est utilisée dans WebSphere Application Server comme une pondération pour s'assurer que l'ordre de démarrage est respecté. Conformément à la valeur d'ordre de démarrage, l'application Web du service d'administration est déployée et démarrée avant tout autre projet d'exécution {{ site.data.keys.product_adj }}. Si des projets {{ site.data.keys.product_adj }} sont déployés ou démarrés avant l'application Web, la communication JMX n'est pas établie, l'environnement d'exécution ne peut pas être synchronisé avec la base de données du service d'administration et ne peut pas traiter les demandes de serveur.

Les tâches Ant **installmobilefirstadmin**, **updatemobilefirstadmin** et **uninstallmobilefirstadmin** prennent en charge les éléments suivants :

| Elément               | Description                                      | Nombre |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | Serveur d'applications.                          | 1     |
| `<configuration>`     | Service Live Update.	                       | 1     |
| `<console>`           | Console d'administration.                      | 0..1  |
| `<database>`          | Bases de données.                                   | 1     |
| `<jmx>`               | Permet d'activer Java Management Extensions.	           | 1     |
| `<property>`          | Propriétés.	                               | 0..   |
| `<push>`              | Service push.	                               | 0..1  |
| `<user>`              | Utilisateur à mapper à un rôle de sécurité.	       | 0..   |

### Pour spécifier {{ site.data.keys.mf_console }}
{: #to-specify-a-mobilefirst-operations-console }
L'élément `<console>` collecte des informations permettant de personnaliser l'installation de {{ site.data.keys.mf_console }}. Cet élément possède les attributs ci-après.

| Attribut         | Description                                                               | Obligatoire | Valeur par défaut     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | URI de {{ site.data.keys.mf_console }}.                            | Non       | /mfpconsole |
| install           | Permet d'indiquer si {{ site.data.keys.mf_console }} doit être installé. | Non       | Oui         |
| warfile           | Fichier WAR de la console.	                                                    |Non        | Le fichier mfp-admin-ui.war se trouve dans le même répertoire que le fichier themfp-ant-deployer.jar. |

L'élément `<console>` prend en charge l'élément suivant :

| Elément               | Description                                      | Nombre |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | Artefacts de {{ site.data.keys.mf_server }}.                | 0..1  |
| `<property>`	        | Propriétés.	                               | 0..   |

L'élément `<artifacts>` possède les attributs suivants :

| Attribut         | Description                                                               | Obligatoire | Valeur par défaut     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           | Permet d'indiquer si le composant des artefacts doit être installé.            | Non       | true        |
| warFile           | Fichier WAR des artefacts.                                                   | Non       | Le fichier mfp-dev-artifacts.war se trouve dans le même répertoire que le fichier mfp-ant-deployer.jar. |

Vous pouvez utiliser cet élément pour définir vos propres propriétés JNDI ou remplacer la valeur par défaut des propriétés JNDI qui sont fournies par le service d'administration et les fichiers WAR de {{ site.data.keys.mf_console }}.

L'élément `<property>` spécifie une propriété de déploiement à définir dans le serveur d'applications. Il possède les attributs suivants :

| Attribut  | Description                | Obligatoire | Valeur par défaut |
|------------|----------------------------|----------|---------|
| name       | Nom de la propriété.  | Oui      | Aucune    |
| value	     | Valeur de la propriété. |	Oui      | Aucune    |

Vous pouvez utiliser cet élément pour définir vos propres propriétés JNDI ou remplacer la valeur par défaut des propriétés JNDI qui sont fournies par le service d'administration et les fichiers WAR de {{ site.data.keys.mf_console }}.

Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Pour spécifier un serveur d'applications
{: #to-specify-an-application-server }
Utilisez l'élément `<applicationserver>` pour définir les paramètres qui dépendent du serveur d'applications sous-jacent. L'élément `<applicationserver>` prend en charge les éléments suivants :

| Elément                                   | Description                                      | Nombre |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` ou `<was>` | Paramètres pour WebSphere Application Server. <br/><br/>L'élément `<websphereapplicationserver>` (ou `was>` dans sa forme abrégée) signale une instance WebSphere Application Server. Le profil complet de WebSphere Application Server (versions Base et Network Deployment) est pris en charge, de même que WebSphere Application Server Liberty Core et WebSphere Application Server Liberty Network Deployment.               | 0..1  |
| `<tomcat>`                                | Paramètres pour Apache Tomcat.	               | 0..1  |

Les attributs et les éléments internes de ces éléments sont décrits dans les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
Toutefois, pour l'élément interne de l'élément `<was>` pour la collectivité Liberty, voir le tableau suivant :

| Elément                  | Description                      | Nombre |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | Contrôleur de collectivité Liberty. |	0..1  |

L'élément `<collectiveController>` possède les attributs suivants :

| Attribut                | Description                            | Obligatoire | Valeur par défaut |
|--------------------------|----------------------------------------|----------|---------|
| serverName               | Nom du contrôleur de collectivité.	| Oui      | Aucune    |
| controllerAdminName      | Nom d'administrateur qui est défini dans le contrôleur de collectivité. Il s'agit du même utilisateur que celui utilisé pour joindre de nouveaux membres à la collectivité.                                                         | Oui      | Aucune    |
| controllerAdminPassword  | Mot de passe de l'administrateur.	    | Oui      | Aucune    |
| createControllerAdmin    | Permet d'indiquer si l'administrateur doit être créé dans le registre de base du contrôleur de collectivité. Les valeurs possibles sont true ou false.                                                              | Non	   | true    |

### Pour spécifier la configuration du service Live Update
{: #to-specify-the-live-update-service-configuration }
Utilisez l'élément `<configuration>` pour définir les paramètres qui dépendent du service Live Update. L'élément `<configuration>` possède les attributs suivants :

| Attribut                | Description                                                    | Obligatoire | Valeur par défaut |
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  | Permet d'indiquer si le service Live Update doit être installé.	| Oui | true |
| configAdminUser	       | Administrateur du service Live Update.	                | Non. En  revanche, obligatoire dans le cadre d'une topologie de parc de serveurs. |Si cet attribut n'est pas défini, un utilisateur est généré. Dans le cadre d'une topologie de parc de serveurs, le nom d'utilisateur doit être identique pour tous les membres du parc de serveurs. |
| configAdminPassword      | Mot de passe administrateur de l'utilisateur du service Live Update.       | Si un utilisateur est spécifié pour **configAdminUser**. | Aucune. Dans le cadre d'une topologie de parc de serveurs, le mot de passe doit être identique pour tous les membres du parc de serveurs. |
| createConfigAdminUser	   | Permet d'indiquer si un administrateur doit être créé dans le registre de base du serveur d'applications, s'il est manquant. | Non | true |
| warFile                  | Fichier WAR du service Live Update.	                            | Non         | Le fichier mfp-live-update.war se trouve dans le même répertoire que le fichier mfp-ant-deployer.jar. |

L'élément `<configuration>` prend en charge les éléments suivants :

| Elément      | Description                           | Nombre |
|--------------|---------------------------------------|-------|
| `<user>`     | Utilisateur du service Live Update. | 0..1  |
| `<property>` | Propriétés.	                   | 0..   |

L'élément `<user>` collecte les paramètres relatifs à un utilisateur qui doivent être inclus dans un rôle de sécurité spécifique pour une application.

| Attribut   | Description                                                             | Obligatoire | Valeur par défaut |
|-------------|-------------------------------------------------------------------------|----------|---------|
| role	      | Rôle de sécurité valide pour l'application. Valeur possible : configadmin.	| Oui      | Aucune    |
| name	      | Nom d'utilisateur.	                                                        | Oui      | Aucune    |
| password	  | Mot de passe si l'utilisateur doit être créé.	                        | Non       | Aucune    |

Une fois que vous avez défini les utilisateurs à l'aide de l'élément `<user>`, vous pouvez les mapper à n'importe lequel des rôles suivants à des fins d'authentification dans {{ site.data.keys.mf_console }} : `configadmin`.

Pour plus d'informations sur les autorisations implicites pour les rôles spécifiques, voir [Configuration de l'authentification d'utilisateur pour l'administration de {{ site.data.keys.mf_server }}](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

> **Astuce :** Si les utilisateurs existent dans un annuaire LDAP externe, définissez uniquement les attributs **role** et **name**, mais ne définissez pas de mots de passe.

L'élément `<property>` spécifie une propriété de déploiement à définir dans le serveur d'applications. Il possède les attributs suivants :

| Attribut  | Description                | Obligatoire | Valeur par défaut |
|------------|----------------------------|----------|---------|
| name       | Nom de la propriété.  | Oui      | Aucune    |
| value	     | Valeur de la propriété. |	Oui      | Aucune    |

Vous pouvez utiliser cet élément pour définir vos propres propriétés JNDI ou remplacer la valeur par défaut des propriétés JNDI qui sont fournies par le service d'administration et les fichiers WAR de {{ site.data.keys.mf_console }}. Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Pour spécifier un serveur d'applications
{: #to-specify-an-application-server-1 }
Utilisez l'élément `<applicationserver>` pour définir les paramètres qui dépendent du serveur d'applications sous-jacent. L'élément `<applicationserver>` prend en charge les éléments suivants :

| Elément      | Description                                              | Nombre |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` ou `<was>`	| Paramètres pour WebSphere Application Server.<br/><br/>L'élément <websphereapplicationserver> (ou<was> dans sa forme développée) signale une instance WebSphere Application Server. Le profil complet de WebSphere Application Server (versions Base et Network Deployment) est pris en charge, de même que WebSphere Application Server Liberty Core et WebSphere Application Server Liberty Network Deployment. | 0..1  |
| `<tomcat>`   | Paramètres pour Apache Tomcat.                        | 0..1  |

Les attributs et les éléments internes de ces éléments sont décrits dans les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
Toutefois, pour l'élément interne de l'élément <was> pour la collectivité Liberty, voir le tableau suivant :

| Elément               | Description                  | Nombre |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| Membre d'une collectivité Liberty. | 0..1  |

L'élément `<collectiveMember>` possède les attributs suivants :

| Attribut   | Description                                             | Obligatoire | Valeur par défaut |
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	Nom du membre de collectivité.                      | Oui      | Aucune    |
| clusterName |	Nom du cluster auquel appartient le membre de collectivité. | Oui	   | Aucune    |

> **Remarque :** Si le service push et les composants d'exécution sont installés dans le membre de collectivité, ils doivent porter le même nom de cluster. Si ces composants sont installés sur des membres distincts de la même collectivité, les noms de cluster peuvent être différents.

### Pour spécifier le composant Analytics
{: #to-specify-analytics }
L'élément `<analytics>` indique que vous souhaitez connecter le service push de {{ site.data.keys.product_adj }} à un service {{ site.data.keys.mf_analytics }} déjà installé. Il possède les attributs suivants :

| Attribut     | Description                                                               | Obligatoire | Valeur par défaut |
|---------------|---------------------------------------------------------------------------|----------|---------|
| install	    | Permet d'indiquer si le service push doit être connecté à {{ site.data.keys.mf_analytics }}. | Non       | false   |
| analyticsURL 	| URL des services {{ site.data.keys.mf_analytics }}.	                            | Oui	   | Aucune    |
| username	    | Nom d'utilisateur.	                                                        | Oui	   | Aucune    |
| password	    | Mot de passe.	                                                            | Oui	   | Aucune    |
| validate	    | Permet de déterminer si la {{ site.data.keys.mf_analytics_console }} est accessible ou non.	| Non	   | true    |

**install**  
Utilisez l'attribut install pour indiquer que ce service push doit être connecté et pour envoyer des événements à {{ site.data.keys.mf_analytics }}. Les valeurs valides sont true ou false.

**analyticsURL**  
Utilisez l'attribut analyticsURL afin de spécifier l'URL qui est exposée par {{ site.data.keys.mf_analytics }}, qui reçoit les données d'analyse entrantes.

Par exemple : `http://<hostname>:<port>/analytics-service/rest`

**username**  
Utilisez l'attribut username afin de spécifier le nom d'utilisateur qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de base.

**password**  
Utilisez l'attribut password afin de spécifier le mot de passe qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de base.

**validate**  
Utilisez l'attribut validate pour déterminer si la console {{ site.data.keys.mf_analytics_console }} est accessible ou non et pour vérifier l'authentification par nom d'utilisateur avec un mot de passe. Les valeurs possibles sont true ou false.

### Pour spécifier une connexion à la base de données du service push
{: #to-specify-a-connection-to-the-push-service-database }

L'élément `<database>` collecte les paramètres permettant de spécifier une déclaration de source de données dans un serveur d'applications pour accéder à la base de données du service push.

Vous devez déclarer une seule base de données : `<database kind="Push">`. Vous spécifiez l'élément `<database>` en procédant comme pour la tâche Ant configuredatabase, à ceci près que l'élément `<database>`  ne possède pas les éléments `<dba>` et `<client>`. Il peut posséder les éléments `<property>`.

L'élément `<database>` possède les attributs suivants :

| Attribut     | Description                                     | Obligatoire | Valeur par défaut |
|---------------|-------------------------------------------------|----------|---------|
| kind          | Type de base de données (Push).	                  | Oui	     | Aucune    |
| validate	    | Permet de déterminer si la base de données est accessible. | Non       | true    |

L'élément `<database>` prend en charge les éléments suivants : Pour plus d'informations sur la configuration de ces éléments de base de données pour le système de gestion de base de données relationnelle, voir les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elément            | Description                                                      | Nombre |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | Paramètre pour les bases de données DB2.	                            | 0..1  |
| <derby>	         | Paramètre pour les bases de données Apache Derby.	                    | 0..1  |
| <mysql>	         | Paramètre pour les bases de données MySQL.                               | 0..1  |
| <oracle>	         | Paramètre pour les bases de données Oracle.	                            | 0..1  |
| <cloudant>	     | Paramètre pour les bases de données Cloudant.	                        | 0..1  |
| <driverclasspath>	 | Paramètre pour le chemin de classe du pilote JDBC (système de gestion de base de données relationnelle uniquement). | 0..1  |

> **Remarque :** Les attributs de l'élément `<cloudant>` sont légèrement différents de ceux de l'environnement d'exécution. Pour plus d'informations, voir le tableau suivant :

| Attribut     | Description                                     | Obligatoire | Valeur par défaut                   |
|---------------|-------------------------------------------------|----------|---------------------------|
| url           | URL du compte Cloudant.                | Non       | https://user.cloudant.com |
| user          | Nom d'utilisateur du compte Cloudant.	      | Oui	     | Aucune                      |
| password      | Mot de passe du compte Cloudant.	          | Non	     | Demandée en mode interactif     |
| dbName        | Nom de la base de données Cloudant. **Important :** Ce nom de base de données doit commencer par un caractère en minuscule et ne peut contenir que des caractères en minuscules (a-z), des chiffres (0-9) et les caractères _, $ et -.                                | Non       | mfp_push_db               |

## Tâches Ant pour l'installation du service push de {{ site.data.keys.mf_server }}
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
Les tâches Ant **installmobilefirstpush**, **updatemobilefirstpush** et **uninstallmobilefirstpush** sont fournies pour l'installation du service push.

### Effets des tâches
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
La tâche Ant **installmobilefirstpush** configure un serveur d'applications pour exécuter le fichier WAR du service push en tant qu'application Web. Elle a les effets suivants : Elle déclare l'application Web de service push dans la racine de contexte **/imfpush**. La racine de contexte ne peut pas être modifiée.
Pour les bases de données relationnelles, elle déclare les sources de données et, sur le profil complet de WebSphere Application Server, elle déclare les fournisseurs JDBC pour le service push.
Elle configure les propriétés de configuration pour le service push à l'aide des entrées d'environnement JNDI. Ces entrées d'environnement JNDI configurent la communication OAuth avec le serveur d'autorisations {{ site.data.keys.product_adj }}, avec {{ site.data.keys.mf_analytics }} et avec Cloudant lorsque ce produit est utilisé.

#### updatemobilefirstpush
{: #updatemobilefirstpush }
La tâche Ant **updatemobilefirstpush** met à jour une application Web {{ site.data.keys.mf_server }} déjà configurée sur un serveur d'applications. Elle met à jour le fichier WAR du service push. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
La tâche Ant **uninstallmobilefirstpush** annule les effets d'une précédente exécution de la tâche **installmobilefirstpush**. Elle a les effets suivants : elle supprime la configuration de l'application Web de service push avec la racine de contexte spécifiée. En conséquence, elle supprime
également les paramètres ajoutés manuellement à cette application.
Elle supprime le fichier WAR du service push du serveur d'applications en tant qu'option.
Pour le système de gestion de base de données relationnelle, elle retire les sources de données et, sur le profil complet de WebSphere Application Server, elle retire les fournisseurs JDBC pour le service push.
Elle supprime les entrées associées de l'environnement JNDI.

### Attributs et éléments
{: #attributes-and-elements-1 }
Les tâches Ant **installmobilefirstpush**, **updatemobilefirstpush** et **uninstallmobilefirstpush** possèdent les attributs suivants :

| Attribut | Description                           | Obligatoire | Valeur par défaut     |
|-----------|---------------------------------------|----------|-------------|
| id        | Permet de distinguer différents déploiements.	| Non	   | Vide
| warFile	| Fichier WAR du service push.	| Non	   | Le fichier ../PushService/mfp-push-service.war est relatif au répertoire MobileFirstServer contenant le fichier mfp-ant-deployer.jar. |

### Id
{: #id }
L'attribut **id** distingue différents déploiements du service push dans la même cellule WebSphere Application Server. Sans l'attribut id, deux fichiers WAR possédant les mêmes racines de contexte pourraient entrer en conflit et ne pas être déployés.

### warFile
{: #warfile }
Utilisez l'attribut **warFile** afin de spécifier un autre répertoire pour le fichier WAR du service push. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

Les tâches Ant **installmobilefirstpush**, **updatemobilefirstpush** et **uninstallmobilefirstpush** prennent en charge les éléments suivants :

| Elément               | Description             | Nombre |
|-----------------------|-------------------------|-------|
| `<applicationserver>` | Serveur d'applications. | 1     |
| `<analytics>`	        | Analyses.	      | 0..1  |
| `<authorization>`	    | Serveur d'autorisations permettant d'authentifier la communication avec d'autres composants {{ site.data.keys.mf_server }}. | 1 |
| `<database>`	        | Bases de données.	      | 1     |
| `<property>`	        | Propriétés.	      | 0..∞  |

### Pour spécifier le serveur d'autorisations
{: #to-specify-the-authorization-server }
L'élément `<authorization>` collecte des informations afin de configurer le serveur d'autorisations pour la communication d'authentification avec d'autres composants {{ site.data.keys.mf_server }}. Cet élément possède les attributs ci-après.

| Attribut          | Description                           | Obligatoire | Valeur par défaut     |
|--------------------|---------------------------------------|----------|-------------|
| auto               | Permet d'indiquer si l'URL de serveur d'autorisations est calculé. Les valeurs possibles sont true ou false.	| Obligatoire sur un cluster ou un noeud WebSphere Application Server Network Deployment.   	 | true |
| authorizationURL   | URL du serveur d'autorisations.	 | Si le mode n'est pas auto. | Racine de contexte de l'environnement d'exécution sur le serveur local. |
| runtimeContextRoot | Racine de contexte de l'environnement d'exécution.	     | Non	     | /mfp       |
| pushClientID	     | ID confidentiel de service push dans le serveur d'autorisations.  | Oui | Aucune |
| pushClientSecret	 | Mot de passe client confidentiel de service push dans le serveur d'autorisations. | Oui | Aucune |

#### auto
{: #auto }
Si la valeur définie est true, l'URL du serveur d'autorisations est calculée automatiquement à l'aide de la racine de contexte de l'environnement d'exécution sur le serveur d'applications local. Le mode auto n'est pas pris en charge si vous procédez au déploiement sur WebSphere Application Server Network Deployment sur un cluster.

#### authorizationURL
{: #authorizationurl }
URL du serveur d'autorisations. Si le serveur d'autorisations est l'environnement d'exécution de {{ site.data.keys.product_adj }}, l'URL est l'URL de l'environnement d'exécution. Exemple : `http://myHost:9080/mfp`.

#### runtimeContextRoot
{: #runtimecontextroot }
Racine de contexte de l'environnement d'exécution qui est utilisée pour calculer l'URL du serveur d'autorisations en mode automatique.
#### pushClientID
{: #pushclientid }
ID de cette instance de service push en tant que client confidentiel du serveur d'autorisations. L'ID et le secret doivent être enregistrés pour le serveur d'autorisations. Ils peuvent être enregistrés par la tâche Ant **installmobilefirstadmin** ou à partir de {{ site.data.keys.mf_console }}.

#### pushClientSecret
{: #pushclientsecret }
Clé secrète de cette instance de service push en tant que client confidentiel du serveur d'autorisations. L'ID et le secret doivent être enregistrés pour le serveur d'autorisations. Ils peuvent être enregistrés par la tâche Ant **installmobilefirstadmin** ou à partir de {{ site.data.keys.mf_console }}.

L'élément `<property>` spécifie une propriété de déploiement à définir dans le serveur d'applications. Il possède les attributs suivants :

| Attribut  | Description                | Obligatoire | Valeur par défaut |
|------------|----------------------------|----------|---------|
| name       | Nom de la propriété.  |	Oui	     | Aucune    |
| value	     | Valeur de la propriété. |	Oui	     | Aucune    |

Vous pouvez utiliser cet élément pour définir vos propres propriétés JNDI ou remplacer la valeur par défaut des propriétés JNDI qui sont fournies par le fichier WAR de service push.

Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

### Pour spécifier un serveur d'applications
{: #to-specify-an-application-server-2 }
Utilisez l'élément `<applicationserver>` pour définir les paramètres qui dépendent du serveur d'applications sous-jacent. L'élément `<applicationserver>` prend en charge les éléments suivants :

| Elément                               | Description                                      | Nombre |
|---------------------------------------|--------------------------------------------------|-------|
| <websphereapplicationserver> ou <was>	| Paramètres pour WebSphere Application Server. | L'élément `<websphereapplicationserver>` (ou `<was>` dans sa forme abrégée) signale une instance WebSphere Application Server. Le profil complet de WebSphere Application Server (versions Base et Network Deployment) est pris en charge, de même que WebSphere Application Server Liberty Core et WebSphere Application Server Liberty Network Deployment. | 0..1 |
| `<tomcat>` | Paramètres pour Apache Tomcat. | 0..1 |

Les attributs et les éléments internes de ces éléments sont décrits dans les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

Toutefois, pour l'élément interne de l'élément `<was>` pour la collectivité Liberty, voir le tableau suivant :

| Elément              | Description                  | Nombre |
|----------------------|------------------------------|-------|
| `<collectiveMember>` | Membre d'une collectivité Liberty. |	0..1  |

L'élément `<collectiveMember>` possède les attributs suivants :

| Attribut   | Description                        | Obligatoire | Valeur par défaut |
|-------------|------------------------------------|----------|---------|
| serverName  | Nom du membre de collectivité. | Oui      | Aucune    |
| clusterName |	Nom du cluster auquel appartient le membre de collectivité. | Oui | Aucune |

> **Remarque :** Si le service push et les composants d'exécution sont installés dans le membre de collectivité, ils doivent porter le même nom de cluster. Si ces composants sont installés sur des membres distincts de la même collectivité, les noms de cluster peuvent être différents.

### Pour spécifier le composant Analytics
{: #to-specify-analytics-1 }
L'élément `<analytics>` indique que vous souhaitez connecter le service push de {{ site.data.keys.product_adj }} à un service {{ site.data.keys.mf_analytics }} déjà installé. Il possède les attributs suivants :

| Attribut    | Description                        | Obligatoire | Valeur par défaut |
|--------------|------------------------------------|----------|---------|
| install	   | Permet d'indiquer si le service push doit être connecté à {{ site.data.keys.mf_analytics }}. | Non | false |
| analyticsURL | URL des services {{ site.data.keys.mf_analytics }}. | Oui | Aucune |
| username	   | Nom d'utilisateur. | Oui | Aucune |
| password	   | Mot de passe. | Oui | Aucune |
| validate	   | Permet de déterminer si la {{ site.data.keys.mf_analytics_console }} est accessible ou non. | Non | true |

#### install
{: #install }
Utilisez l'attribut **install** pour indiquer que ce service push doit être connecté et pour envoyer des événements à {{ site.data.keys.mf_analytics }}. Les valeurs valides sont true ou false.

#### analyticsURL
{: #analyticsurl }
Utilisez l'attribut **analyticsURL** afin de spécifier l'adresse URL qui est exposée par
{{ site.data.keys.mf_analytics }}, qui reçoit les données d'analyse
entrantes.  
Par exemple : `http://<hostname>:<port>/analytics-service/rest`

#### username
{: #username }
Utilisez l'attribut **username** afin de spécifier le nom d'utilisateur qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de
base.

#### password
{: #password }
Utilisez l'attribut **password** afin de spécifier le mot de passe qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de
base.

#### validate
{: #validate }
Utilisez l'attribut **validate** pour déterminer si la console {{ site.data.keys.mf_analytics_console }} est accessible ou non et pour vérifier l'authentification par nom d'utilisateur avec un mot de passe. Les valeurs possibles sont true ou false.

### Pour spécifier une connexion à la base de données du service push
{: #to-specify-a-connection-to-the-push-service-database-1 }
L'élément `<database>` collecte les paramètres permettant de spécifier une déclaration de source de données dans un serveur d'applications pour accéder à la base de données du service push.

Vous devez déclarer une seule base de données : `<database kind="Push">`. Vous spécifiez l'élément `<database>` en procédant comme pour la tâche Ant configuredatabase, à ceci près que l'élément `<database>`  ne possède pas les éléments `<dba>` et `<client>`. Il peut posséder les éléments `<property>`.

L'élément `<database>` possède les attributs suivants :

| Attribut    | Description                  | Obligatoire | Valeur par défaut |
|--------------|------------------------------|----------|---------|
| kind         | Type de base de données (Push). | Oui      | Aucune    |
| validate	   | Permet de déterminer si la base de données est accessible. | Non | true |

L'élément `<database>` prend en charge les éléments suivants : Pour plus d'informations sur la configuration de ces éléments de base de données pour le système de gestion de base de données relationnelle, voir les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elément              | Description                               | Nombre |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           | Paramètre pour les bases de données DB2.         | 0..1  |
| `<derby>`	           | Paramètre pour les bases de données Apache Derby. | 0..1  |
| `<mysql>`	           | Paramètre pour les bases de données MySQL.        | 0..1  |
| `<oracle>`           | Paramètre pour les bases de données Oracle.       | 0..1  |
| `<cloudant>`	       | Paramètre pour les bases de données Cloudant.     | 0..1  |
| `<driverclasspath>`  | Paramètre pour le chemin de classe du pilote JDBC (système de gestion de base de données relationnelle uniquement). | 0..1 |

> **Remarque :** Les attributs de l'élément `<cloudant>` sont légèrement différents de ceux de l'environnement d'exécution. Pour plus d'informations, voir le tableau suivant :

| Attribut    | Description                            | Obligatoire   | Valeur par défaut |
|--------------|----------------------------------------|------------|---------|
| url	       | URL du compte Cloudant.       | Non         | https://user.cloudant.com |
| user	       | Nom d'utilisateur du compte Cloudant. | Oui | Aucune |
| password	   | Mot de passe du compte Cloudant.	| Non  | Demandée en mode interactif |
| dbName	   | Nom de la base de données Cloudant. **Important :** Ce nom de base de données doit commencer par un caractère en minuscule et ne peut contenir que des caractères en minuscules (a-z), des chiffres (0-9) et les caractères _, $ et -. |Non	| mfp_push_db |

## Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
Informations de référence pour les tâches Ant **installmobilefirstruntime**, **updatemobilefirstruntime** et **uninstallmobilefirstruntime**.

### Effets des tâches
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
La tâche Ant **installmobilefirstruntime** configure un serveur d'applications pour exécuter un fichier WAR de l'environnement d'exécution de {{ site.data.keys.product_adj }} en tant qu'application Web. Elle a les effets suivants :

* Elle déclare l'application Web de {{ site.data.keys.product_adj }} dans la racine de contexte spécifiée, par défaut, /mfp.
* Elle déploie le fichier WAR de l'environnement d'exécution sur le serveur d'applications.
* Elle déclare les sources de données et, sur le profil complet de WebSphere Application Server, elle déclare les fournisseurs JDBC pour l'environnement d'exécution.
* Elle déploie les pilotes de base de données dans le serveur d'applications.
* Elle définit les propriétés de configuration de {{ site.data.keys.product_adj }} via des entrées d'environnement JNDI.
* Le cas échéant, elle définit les entrées d'environnement JNDI {{ site.data.keys.product_adj }} pour configurer le serveur d'applications en tant que membre de parc de serveurs pour l'environnement d'exécution.

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
La tâche Ant **updatemobilefirstruntime** met à jour un environnement d'exécution de {{ site.data.keys.product_adj }} qui est déjà configuré sur un serveur d'applications. Elle met à jour le fichier WAR de l'environnement d'exécution. Le fichier doit porter le même nom de base que le fichier WAR de l'environnement d'exécution précédemment déployé. A part cela, la tâche ne change pas la configuration du serveur d'applications, c'est-à-dire la configuration de l'application Web, les sources de données et
les entrées d'environnement JNDI.

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
La tâche Ant **uninstallmobilefirstruntime** annule les effets d'une précédente exécution de la tâche **installmobilefirstruntime**. Elle a les effets suivants :

* Elle supprime la configuration de l'application Web de {{ site.data.keys.product_adj }} avec la racine de contexte spécifiée. Elle supprime également les paramètres ajoutés manuellement à cette application.
* Elle supprime le fichier WAR de l'environnement d'exécution sur le serveur d'applications.
* Elle supprime les sources de données et, sur le profil complet de WebSphere Application Server, elle retire les fournisseurs JDBC pour l'environnement d'exécution.
* Elle supprime les entrées associées de l'environnement JNDI.

### Attributs et éléments
{: #attributes-and-elements-2 }
Les tâches Ant **installmobilefirstruntime**, **updatemobilefirstruntime** et **uninstallmobilefirstruntime** possèdent les attributs suivants :

| Attribut         | Description                                                                 | Obligatoire   | Valeur par défaut                   |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | Préfixe commun dans les URL vers l'application (racine de contexte).                | Non | /mfp  |
| id	            | Permet de distinguer différents déploiements.                                       | Non | Vide |
| environmentId	    | Permet de distinguer différents environnements {{ site.data.keys.product_adj }}.                          | Non | Vide |
| warFile	        | Fichier WAR de l'environnement d'exécution de {{ site.data.keys.product_adj }}.                                       | Non | Le fichier mfp-server.war se trouve dans le même répertoire que le fichier mfp-ant-deployer.jar. |
| wasStartingWeight | Ordre de démarrage pour WebSphere Application Server. Les valeurs les plus faibles démarrent en premier. | Non | 2     |                           |

#### contextroot et id
{: #contextroot-and-id-1 }
Les attributs **contextroot** et **id** distinguent différents projets
{{ site.data.keys.product_adj }}.

Dans les profils Liberty de WebSphere Application Server et dans les environnements Tomcat, le paramètre contextroot est suffisant pour atteindre cet objectif. Dans les environnements de profil complet de WebSphere Application Server, l'attribut id est utilisé à la place.

#### environmentId
{: #environmentid-1 }
Utilisez l'attribut **environmentId** pour distinguer plusieurs environnements, constitués chacun du service d'administration de {{ site.data.keys.mf_server }} et des applications Web d'environnement d'exécution de {{ site.data.keys.product_adj }}, qui doivent fonctionner indépendamment. Vous devez affecter à cet attribut la même valeur que pour l'application d'exécution qui a été définie dans l'appel de la tâche <installmobilefirstadmin>, pour l'application du service d'administration.

#### warFile
{: #warfile-1 }
Utilisez l'attribut **warFile** afin de spécifier un répertoire différent pour le fichier WAR de l'environnement d'exécution de {{ site.data.keys.product_adj }}. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

#### wasStartingWeight
{: #wasstartingweight-1 }
Utilisez l'attribut **wasStartingWeight** pour spécifier une valeur qui est utilisée dans WebSphere Application Server comme une pondération pour s'assurer que l'ordre de démarrage est respecté. Conformément à la valeur d'ordre de démarrage, l'application Web du service d'administration de {{ site.data.keys.mf_server }} est déployée et démarrée avant tout autre projet d'exécution {{ site.data.keys.product_adj }}. Si
des projets {{ site.data.keys.product_adj }} sont déployés ou démarrés avant
l'application Web, la communication JMX n'est pas établie et vous ne pourrez pas gérer vos projets
{{ site.data.keys.product_adj }}.

Les tâches **installmobilefirstruntime**, **updatemobilefirstruntime** et **uninstallmobilefirstruntime** prennent en charge les éléments suivants :

| Elément               | Description                                      | Nombre |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | Propriétés.	                               | 0..   |
| `<applicationserver>` | Serveur d'applications.                          | 1     |
| `<database>`          | Bases de données.                                   | 1     |
| `<analytics>`         | Composant Analytics.                                   | 0..1  |

L'élément `<property>` spécifie une propriété de déploiement à définir dans le serveur d'applications. Il possède les attributs suivants :

| Attribut | Description                | Obligatoire | Valeur par défaut |
|-----------|----------------------------|----------|---------|
| name      | Nom de la propriété.	 | Oui      | Aucune    |
| value	    | Valeur de la propriété.| Oui	    | Aucune    |  

L'élément `<applicationserver>` décrit le serveur d'applications sur lequel l'application {{ site.data.keys.product_adj }} est déployée. Il s'agit d'un conteneur
pour l'un des éléments ci-après.

| Elément                                    | Description                                      | Nombre |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` ou `<was>`  | Paramètres pour WebSphere Application Server.	| 0..1  |
| `<tomcat>`                                 | Paramètres pour Apache Tomcat.                | 0..1  |

L'élément `<websphereapplicationserver>` (ou `<was>` dans sa forme abrégée) signale une instance WebSphere Application Server. Le profil complet de WebSphere Application Server (versions Base et Network Deployment) est pris en charge, de même que WebSphere Application Server Liberty Core et WebSphere Application Server Liberty Network Deployment. L'élément `<websphereapplicationserver>` possède les attributs suivants :

| Attribut       | Description                                            | Obligatoire                 | Valeur par défaut |
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	Répertoire d'installation de WebSphere Application Server.   | Oui                      | Aucune    |
| profile         |	Profil WebSphere Application Server ou Liberty.      | Oui	                  | Aucune    |
| user	Nom de l'administrateur WebSphere Application Server.	               | Oui, sauf pour Liberty  | Aucune    |
| password        | Mot de passe de l'administrateur WebSphere Application Server.   | Non demandée de manière interactive |         |
| libertyEncoding |	Algorithme permettant de coder les mots de passe de source de données pour WebSphere Application Server Liberty. Les valeurs possibles sont none, xor et aes. Que le codage xor ou aes soit utilisé, le mot de passe déchiffré est transmis en tant qu'argument au programme securityUtility, appelé via un processus externe. Vous pouvez afficher le mot de passe à l'aide d'une commande ps ou dans le système de fichiers /proc sur les systèmes d'exploitation UNIX.                                                         | Non                       |	xor     |
| jeeVersion      |	Pour le profil Liberty. Permet de spécifier si les fonctions du profil Web JEE6 ou du profil Web JEE7 doivent être installées. Les valeurs possibles sont 6, 7 ou auto.| Non | auto |
| configureFarm   |	Pour le profil Liberty de WebSphere Application Server et pour le profil complet de WebSphere Application Server (non pour l'édition WebSphere Application Server Network Deployment et la collectivité Liberty). Permet de spécifier si le serveur est membre d'un parc de serveurs. Les valeurs possibles sont true ou false. | Non	      | false   |
| farmServerId    |	Chaîne qui identifie de manière unique un serveur dans un parc de serveurs. Les services d'administration de {{ site.data.keys.mf_server }} et tous les environnements d'exécution de {{ site.data.keys.product_adj }} qui communiquent avec lui doivent partager la même valeur.                                                                | Oui                      |	Aucune    |

Il prend en charge les éléments ci-après pour un déploiement sur un serveur unique :

| Elément     | Description      | Nombre |
|-------------|------------------|-------|
| `<server>`  | Serveur unique. | 0..1  |

L'élément <server>, qui est utilisé dans ce contexte, possède les attributs suivants :

| Attribut | Description      | Obligatoire | Valeur par défaut |
|-----------|------------------|----------|---------|
| name	    | Nom du serveur. | Oui      | Aucune    |

Il prend en charge les éléments suivants pour la collectivité Liberty :

| Elément               | Description                  | Nombre |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | Membre d'une collectivité Liberty. | 0..1  |

L'élément `<collectiveMember>` possède les attributs suivants :

| Attribut               | Description      | Obligatoire | Valeur par défaut |
|-------------------------|------------------|----------|---------|
| serverName              |	Nom du membre de collectivité.                       | Oui | Aucune |
| clusterName             |	Nom du cluster auquel appartient le membre de collectivité.  | Oui | Aucune |
| serverId                |	Chaîne qui identifie de manière unique le membre de collectivité. | Oui | Aucune |
| controllerHost          |	Nom du contrôleur de collectivité.                   | Oui | Aucune |
| controllerHttpsPort     |	Port HTTPS du contrôleur de collectivité.             | Oui | Aucune |
| controllerAdminName     |	Nom d'administrateur qui est défini dans le contrôleur de collectivité. Il s'agit du même utilisateur que celui utilisé pour joindre de nouveaux membres à la collectivité. | Oui | Aucune |
| controllerAdminPassword |	Mot de passe de l'administrateur.	                     | Oui | Aucune |
| createControllerAdmin   |	Permet d'indiquer si l'administrateur doit être créé dans le registre de base du membre de collectivité. Les valeurs possibles sont true ou false. | Non | true |

Il prend en charge les éléments ci-après pour Network Deployment.

| Elément     | Description                                   | Nombre |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	Ensemble de la cellule.	                          | 0..1  |
| `<cluster>` |	Tous les serveurs d'un cluster.                 |	0..1  |
| `<node>`    |	Tous les serveurs d'un noeud, clusters exclus. | 0..1  |
| `<server>`  |	Serveur unique.	                          | 0..1  |

L'élément `<cell>` ne possède aucun attribut.

L'élément `<cluster>` possède les attributs suivants :

| Attribut | Description       | Obligatoire | Valeur par défaut |
|-----------|-------------------|----------|---------|
| name      | Nom du cluster. | Oui	   | Aucune    |

L'élément `<node>` possède les attributs suivants :

| Attribut | Description    | Obligatoire | Valeur par défaut |
|-----------|----------------|----------|---------|
| name      | Nom du noeud. | Oui	    | Aucune    |

L'élément `<server>`, qui est utilisé dans un contexte Network Deployment, possède les attributs suivants :

| Attribut  | Description      | Obligatoire | Valeur par défaut |
|------------|------------------|----------|---------|
| nodeName   | Nom du noeud.   | Oui	   | Aucune    |
| serverName | Nom du serveur. | Oui      | Aucune    |

L'élément `<tomcat>` désigne un serveur Apache Tomcat. Il possède l'attribut suivant :

| Attribut     | Description      | Obligatoire | Valeur par défaut |
|---------------|------------------|----------|---------|
| installdir    | Répertoire d'installation d'Apache Tomcat. Pour une installation Tomcat répartie dans un répertoire CATALINA_HOME et un répertoire CATALINA_BASE, spécifiez la valeur de la variable d'environnement CATALINA_BASE.     | Oui | Aucune    |
| configureFarm | Permet de spécifier si le serveur est membre d'un parc de serveurs. Les valeurs possibles sont true ou false.	| Non | false |
| farmServerId	| Chaîne qui identifie de manière unique un serveur dans un parc de serveurs. Les services d'administration de {{ site.data.keys.mf_server }} et tous les environnements d'exécution de {{ site.data.keys.product_adj }} qui communiquent avec lui doivent partager la même valeur. | Oui | Aucune |

L'élément `<database>` spécifie les informations nécessaires pour accéder à une base de données spécifique. L'élément `<database>` est spécifié comme pour la tâche Ant configuredatabase, à ceci près qu'il ne possède pas les éléments `<dba>` et `<client>`. En revanche, il peut posséder les éléments `<property>`. L'élément `<database>` possède les attributs suivants :

| Attribut | Description                                | Obligatoire | Valeur par défaut |
|-----------|--------------------------------------------|----------|---------|
| kind      | Type de base de données (environnement d'exécution de {{ site.data.keys.product_adj }}). | Oui | Aucune |
| validate  | Pour déterminer si la base de données est accessible ou non. Les valeurs possibles sont true ou false. | Non | true |

L'élément `<database>` prend en charge les éléments suivants :

| Elément             | Description	                | Nombre |
|---------------------|-----------------------------|-------|
| `<derby>`           | Paramètres pour Derby.   | 0..1  |
| `<db2>`             |	Paramètres pour DB2.     | 0..1  |
| `<mysql>`           |	Paramètres pour MySQL.   | 0..1  |
| `<oracle>`          |	Paramètres pour Oracle.  | 0..1  |
| `<driverclasspath>` | Chemin de classe du pilote JDBC. | 0..1  |

L'élément `<analytics>` indique que vous souhaitez connecter l'environnement d'exécution de {{ site.data.keys.product_adj }} à une console et des services {{ site.data.keys.mf_analytics_console }} déjà installés. Il possède les attributs suivants :

| Attribut    | Description                                                                      | Obligatoire | Valeur par défaut |
|--------------|----------------------------------------------------------------------------------|----------|---------|
| install      | Permet d'indiquer si l'environnement d'exécution de {{ site.data.keys.product_adj }} doit être connecté à {{ site.data.keys.mf_analytics }}. | Non       | false   |
| analyticsURL | URL des services {{ site.data.keys.mf_analytics }}.	                                      | Oui      | Aucune    |
| consoleURL   | URL de {{ site.data.keys.mf_analytics_console }}.	                                      | Oui      | Aucune    |
| username     | Nom d'utilisateur.	                                                                  | Oui      | Aucune    |
| password     | Mot de passe.	                                                                  | Oui      | Aucune    |
| validate     | Permet de déterminer si la {{ site.data.keys.mf_analytics_console }} est accessible ou non.	      | Non	     | true    |
| tenant       | Titulaire des données d'indexation qui sont collectées depuis un environnement d'exécution de {{ site.data.keys.product_adj }}.	      | Non       | Identificateur interne |

#### install
{: #install-1 }
Utilisez l'attribut **install** pour indiquer que ce contexte d'exécution
{{ site.data.keys.product_adj }} doit être connecté et pour envoyer des
événements à {{ site.data.keys.mf_analytics }}. Les valeurs admises sont **true** et **false**.

#### analyticsURL
{: #analyticsurl-1 }
Utilisez l'attribut **analyticsURL** afin de spécifier l'adresse URL qui est exposée par
{{ site.data.keys.mf_analytics }}, qui reçoit les données d'analyse
entrantes.  
Par exemple : `http://<hostname>:<port>/analytics-service/rest`

#### consoleURL
{: #consoleurl }
Utilisez l'attribut **consoleURL** vers l'URL qui est exposée par {{ site.data.keys.mf_analytics }}, qui établit un lien vers {{ site.data.keys.mf_analytics_console }}.  
Par exemple : `http://<hostname>:<port>/analytics/console`

#### username
{: #username-1 }
Utilisez l'attribut **username** afin de spécifier le nom d'utilisateur qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de
base.

#### password
{: #password-1 }
Utilisez l'attribut **password** afin de spécifier le mot de passe qui est utilisé si le point d'entrée des données pour
{{ site.data.keys.mf_analytics }} est protégé avec l'authentification de
base.

#### validate
{: #validate-1 }
Utilisez l'attribut **validate** pour déterminer si la console {{ site.data.keys.mf_analytics_console }} est accessible ou non et pour vérifier l'authentification par nom d'utilisateur avec un mot de passe. Les valeurs possibles sont **true** ou **false**.

#### tenant
{: #tenant }
Pour plus d'informations sur cet attribut, voir [Propriétés de configuration](../analytics/configuration/#configuration-properties).

### Pour spécifier une base de données Apache Derby
{: #to-specify-an-apache-derby-database }
L'élément `<derby>` possède les attributs suivants :

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| database	 | Nom de la base de données.	                      | Non       |	MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind. |
| datadir	 | Répertoire contenant les bases de données. |	Oui	     | Aucune    |
| schema     |	Nom du schéma.                          |	Non	     | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH ou APPCENTER, selon l'attribut kind. |

L'élément `<derby>` prend en charge l'élément suivant :

| Elément       | Description	                | Nombre |
|---------------|-------------------------------|-------|
| `<property>`  | Propriété de source de données ou propriété de connexion JDBC.	| 0.. |

Pour plus d'informations sur les propriétés disponibles, voir la documentation de la classe [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html). Voir
aussi la documentation de la
[classe
EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html).

Pour plus d'informations sur les propriétés disponibles pour un serveur Liberty, voir la documentation
relative à `properties.derby.embedded`
sur la
page [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

Lorsque le fichier **mfp-ant-deployer.jar** est utilisé dans le répertoire d'installation de {{ site.data.keys.product }}, un élément `<driverclasspath>` n'est pas nécessaire.

### Pour spécifier une base de données DB2
{: #to-specify-a-db2-database }
L'élément `<db2>` possède les attributs suivants :

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| database   | Nom de la base de données. | Non MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind. |
| server     | Nom d'hôte du serveur de base de données.      | Oui	     | Aucune    |
| port       | Port sur le serveur de base de données.           | Non	     | 50000   |
| user       | Nom d'utilisateur permettant d'accéder aux bases de données.     | Cet utilisateur n'a pas besoin de privilèges étendus pour les bases de données. Si vous implémentez des restrictions sur la base de données, vous pouvez définir un utilisateur avec des privilèges restreints                                 | répertoriés dans Utilisateurs de base de données et privilèges correspondants. | Oui Aucune |
| password   | Nom d'utilisateur permettant d'accéder aux bases de données.      | Non       | Demandée en mode interactif |
| schema     | Nom du schéma.                           | Non       | Dépend de l'utilisateur |

Pour plus d'informations sur les comptes utilisateur DB2, voir [DB2 security model overview](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
L'élément `<db2>` prend en charge l'élément suivant :

| Elément       | Description	                | Nombre |
|---------------|-------------------------------|-------|
| `<property>`  | Propriété de source de données ou propriété de connexion JDBC.	| 0.. |

Pour plus d'informations sur les propriétés disponibles, voir [Properties for the IBM  Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).

Pour plus d'informations sur les propriétés disponibles pour un serveur Liberty, voir
la section **properties.db2.jcc** de la page [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

L'élément `<driverclasspath>` doit contenir les fichiers JAR pour le pilote JDBC DB2 et pour la licence qui lui est associée. Vous pouvez télécharger des pilotes JDBC DB2 depuis la page [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).

### Pour spécifier une base de données MySQL
{: #to-specify-a-mysql-database }
L'élément `<mysql>` possède les attributs suivants :

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| database	 | Nom de la base de données.	                      | Non       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, selon l'attribut kind. |
| server	 | Nom d'hôte du serveur de base de données.	  | Oui      | Aucune    |
| port	     | Port sur le serveur de base de données.           | Non	     | 3306    |
| user	     | Nom d'utilisateur permettant d'accéder aux bases de données. Cet utilisateur n'a pas besoin de privilèges étendus pour les bases de données. Si vous implémentez des restrictions sur la base de données, vous pouvez définir un utilisateur avec des privilèges restreints | répertoriés dans Utilisateurs de base de données et privilèges correspondants. | Oui | Aucune |
| password	 | Nom d'utilisateur permettant d'accéder aux bases de données.	  | Non	     | Demandée en mode interactif |

A la place de **database**, **server**
et **port**, vous pouvez aussi spécifier une adresse URL. Dans ce cas, utilisez les attributs ci-après.

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| url	     | URL pour la connexion à la base de données.	  | Oui	     | Aucune    |
| user	     | Nom d'utilisateur permettant d'accéder aux bases de données. Cet utilisateur n'a pas besoin de privilèges étendus pour les bases de données. Si vous implémentez des restrictions sur la base de données, vous pouvez définir un utilisateur avec les privilèges restreints répertoriés dans Utilisateurs de base de données et privilèges correspondants | Oui  | Aucune |
| password	 | Nom d'utilisateur permettant d'accéder aux bases de données.	  | Non       | Demandée en mode interactif |

Pour plus d'informations sur les comptes utilisateur MySQL, voir [MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).

L'élément `<mysql>` prend en charge l'élément suivant :

| Elément       | Description	                | Nombre |
|---------------|-------------------------------|-------|
| `<property>`  | Propriété de source de données ou propriété de connexion JDBC.	| 0.. |

Pour plus d'informations sur les propriétés disponibles, voir la documentation [Driver/Datasource Class Names, URL Syntax and Configuration
Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).

Pour plus d'informations sur les propriétés disponibles pour un serveur Liberty, voir la section Properties de la page [Liberty profile: Configuration elements in the server.xml file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

L'élément `<driverclasspath>` doit contenir un fichier JAR MySQL Connector/J. Vous pouvez le télécharger depuis la page [Download Connector/J](http://www.mysql.com/downloads/connector/j/).

### Pour spécifier une base de données Oracle
{: #to-specify-an-oracle-database }
L'élément `<oracle>` possède les attributs suivants :

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| database   | Nom de base de données, ou nom de service Oracle. Remarque : Vous devez toujours utiliser un nom de service pour vous connecter à une base de données PDB. | Non | ORCL |
| server	 | Nom d'hôte du serveur de base de données.	Oui Aucune
| port	     | Port sur le serveur de base de données.	Non	1521
| user	     | Nom d'utilisateur permettant d'accéder aux bases de données. Cet utilisateur n'a pas besoin de privilèges étendus pour les bases de données. Si vous implémentez des restrictions sur la base de données, vous pouvez définir un utilisateur avec les privilèges restreints répertoriés dans Utilisateurs de base de données et privilèges correspondants Voir la note sous ce tableau. | Oui | Aucune |
| password	 | Nom d'utilisateur permettant d'accéder aux bases de données.	  | Non       | Demandée en mode interactif |

> **Remarque:** Pour l'attribut **user**, utilisez plutôt un nom d'utilisateur en lettres majuscules. Les noms d'utilisateur Oracle sont en général
en lettres majuscules. A la différence des autres outils de bases de données, la tâche Ant **installmobilefirstruntime**
ne convertit pas les majuscules en minuscules en ce qui concerne le nom d'utilisateur. Si la tâche Ant **installmobilefirstruntime**
ne parvient pas à se connecter à la base de données, essayez de saisir une valeur en majuscules pour l'attribut
**user**.

A la place de **database**, **server**
et **port**, vous pouvez aussi spécifier une adresse URL. Dans ce cas, utilisez les attributs ci-après.

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| url	     | URL pour la connexion à la base de données.	  | Oui      | Aucune    |
| user	     | Nom d'utilisateur permettant d'accéder aux bases de données. Cet utilisateur n'a pas besoin de privilèges étendus pour les bases de données. Si vous implémentez des restrictions sur la base de données, vous pouvez définir un utilisateur avec les privilèges restreints répertoriés dans Utilisateurs de base de données et privilèges correspondants Voir la note sous ce tableau. | Oui | Aucune |
| password	 | Nom d'utilisateur permettant d'accéder aux bases de données.	  | Non	     | Demandée en mode interactif |

> **Remarque:** Pour l'attribut **user**, utilisez plutôt un nom d'utilisateur en lettres majuscules. Les noms d'utilisateur Oracle sont en général
en lettres majuscules. A la différence des autres outils de bases de données, la tâche Ant **installmobilefirstruntime**
ne convertit pas les majuscules en minuscules en ce qui concerne le nom d'utilisateur. Si la tâche Ant **installmobilefirstruntime**
ne parvient pas à se connecter à la base de données, essayez de saisir une valeur en majuscules pour l'attribut
**user**.

Pour plus d'informations sur les comptes utilisateur Oracle,
voir [Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).

Pour
plus d'informations sur les adresses URL de connexion à une base de données Oracle, voir la section **Database
URLs and Database Specifiers** de la page
[Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Il prend en charge l'élément suivant :

| Elément       | Description	                | Nombre |
|---------------|-------------------------------|-------|
| `<property>`  | Propriété de source de données ou propriété de connexion JDBC.	| 0.. |

Pour plus d'informations sur les propriétés disponibles, voir la section **Data
Sources and URLs** de la page [Data
Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Pour plus d'informations sur les propriétés disponibles pour un serveur Liberty, voir la section
**properties.oracle** de la page
[Liberty
profile: Configuration elements in the server.xml file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

L'élément `<driverclasspath>` doit contenir un fichier JAR de pilote JDBC Oracle. Vous pouvez télécharger des pilotes JDBC Oracle depuis la page [JDBC, SQLJ, Oracle JPublisher and Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

L'élément `<property>`, qui peut être inclus dans les éléments `<derby>`, `<db2>`,` <mysql>` ou `<oracle>`, possède les attributs suivants :

| Attribut  | Description                                | Obligatoire | Valeur par défaut |
|------------|--------------------------------------------|----------|---------|
| name       | Nom de la propriété.	              | Oui      | Aucune    |
| type	     | Type Java des valeurs de propriété, généralement java.lang.String/Integer/Boolean. | Non | java.lang.String |
| value	     | Valeur de la propriété.	              | Oui      |  Aucune   |

## Tâches Ant pour l'installation d'Application Center
{: #ant-tasks-for-installation-of-application-center }
Les tâches Ant `<installApplicationCenter>`, `<updateApplicationCenter>` et `<uninstallApplicationCenter>` sont fournies pour l'installation de la console et des services Application Center.

### Effets des tâches
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
La tâche Ant `<installApplicationCenter>` configure un serveur d'applications pour exécuter le fichier WAR des services Application Center en tant qu'application Web et pour installer la console Application Center. Elle a les effets suivants :

* Elle déclare l'application Web des services Application Center dans la racine de contexte /applicationcenter.
* Elle déclare les sources de données et, sur le profil complet de WebSphere Application Server, elle déclare également les fournisseurs JDBC pour les services Application Center.
* Elle déploie l'application Web des services Application Center sur le serveur d'applications.
* Elle déclare la console  Application Center en tant qu'application Web dans la racine de contexte /appcenterconsole.
* Elle déploie le fichier WAR de la console Application Center sur le serveur d'applications.
* Elle configure les propriétés de configuration des services Application Center à l'aide des entrées d'environnement JNDI. Les entrées d'environnement JNDI qui sont liées au noeud final et aux proxys sont commentées. Vous devez supprimer leur mise en commentaire dans certains cas.
* Elle configure les utilisateurs qu'elle mappe aux rôles utilisés par les applications Web des services et de la console Application Center.
* Sur WebSphere Application Server, elle configure la propriété personnalisée nécessaire pour le conteneur Web.

#### updateApplicationCenter
{: #updateApplicationCenter }
La tâche `<updateApplicationCenter>` met à jour une application Application Center déjà configurée sur un serveur d'applications. Elle a les effets suivants :

* Elle met à jour le fichier WAR des services Application Center. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.
* Elle met à jour le fichier WAR de la console Application Center. Ce fichier doit porter le même nom de base que le fichier WAR correspondant précédemment déployé.

La tâche ne change pas la configuration du serveur d'applications, c'est-à-dire la configuration d'application Web, les
sources de données, les entrées d'environnement JNDI et les mappages utilisateur à rôle. Elle ne s'applique qu'à une installation qui est effectuée à l'aide de la tâche <installApplicationCenter> décrite dans cette rubrique.

> **Remarque :** Sur le profil Liberty de WebSphere Application Server, la tâche ne modifie pas les fonctions, laissant ainsi une liste non minimale potentielle de fonctions dans le fichier server.xml pour l'application installée.

#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
La tâche Ant `<uninstallApplicationCenter>` annule les effets d'une précédente exécution de la tâche `<installApplicationCenter>`. Elle a les effets suivants :

* Elle supprime la configuration de l'application Web des services Application Center avec la racine de contexte **/applicationcenter**. En conséquence, elle supprime
également les paramètres ajoutés manuellement à cette application.
* Elle supprime les fichiers WAR des services et de la console Application Center du serveur d'applications.
* Elle supprime les sources de données et, sur le profil complet de WebSphere Application Server, elle retire également les fournisseurs JDBC pour les services Application Center.
* Elle supprime les pilotes de base de données qui étaient utilisés par les services Application Center sur le serveur d'applications.
* Elle supprime les entrées associées de l'environnement JNDI.
* Elle supprime les utilisateurs qui sont configurés par l'appel de la tâche `<installApplicationCenter>`.

### Attributs et éléments
{: #attributes-and-elements-3 }
Les tâches `<installApplicationCenter>`, `<updateApplicationCenter>` et `<uninstallApplicationCenter>` possèdent les attributs suivants :

| Attribut    | Description                                | Obligatoire | Valeur par défaut |
|--------------|--------------------------------------------|----------|---------|
| id	       | Distingue différents déploiements dans le profil complet de WebSphere Application Server.	| Non | Vide |
| servicewar   | Fichier WAR des services Application Center. | Non | Le fichier applicationcenter.war se trouve dans le répertoire de la console Application Center : **product_install_dir/ApplicationCenter/console.** |
| shortcutsDir | Répertoire dans lequel vous placez les raccourcis. | Non | Aucune |
| aaptDir | Répertoire contenant le programme aapt provenant du package platform-tools du logiciel SDK Android. | Non | Aucune |

#### id
{: #id-1 }
Dans les environnements de profil complet de WebSphere Application Server, l'attribut **id** est utilisé pour distinguer différents déploiements de la console et des services Application Center. Sans l'attribut **id**, deux fichiers WAR avec les mêmes racines de contexte peuvent entrer en conflit et ne pas être déployés.

#### servicewar
{: #servicewar-1 }
Utilisez l'attribut **servicewar** afin de spécifier un autre répertoire pour le fichier WAR des services Application Center. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

#### shortcutsDir
{: #shortcutsdir-1 }
L'attribut **shortcutsDir** indique où placer les raccourcis vers la console Application Center. Si vous définissez cet attribut, les fichiers suivants sont ajoutés à ce répertoire :

* **appcenter-console.url** : ce fichier est un raccourci Windows. Il ouvre la console Application Center dans un navigateur.
* **appcenter-console.sh** : ce fichier est un script shell UNIX. Il ouvre la console Application Center dans un navigateur.

#### aaptDir
{: #aaptdir }
Le programme **aapt** fait partie de la distribution {{ site.data.keys.product }} : **rép_install_produit/ApplicationCenter/tools/android-sdk**.  
Si cet attribut n'est pas défini, lors du téléchargement d'une application apk, Application Center effectue l'analyse syntaxique de cette dernière à l'aide de son propre code, ce qui peut entraîner les limitations.

Les tâches `<installApplicationCenter>`, `<updateApplicationCenter>` et `<uninstallApplicationCenter>` possèdent les éléments suivants :

| Elément           | Description	                            | Nombre |
|-------------------|-------------------------------------------|-------|
| applicationserver	| Serveur d'applications.                   | 1     |
| console           | Console Application Center.	        | 1     |
| database          | Bases de données.	                        | 1     |
| user	            | Utilisateur à mapper à un rôle de sécurité. | 0..∞  |

### Pour spécifier une console Application Center
{: #to-specify-an-application-center-console }
L'élément `<console>` collecte des informations permettant de personnaliser l'installation de la console Application Center. Cet élément possède les attributs ci-après.

| Attribut    | Description                                      | Obligatoire | Valeur par défaut |
|--------------|--------------------------------------------------|----------|---------|
| warfile      | Fichier WAR de la console Application Center. |	Non       | Le fichier appcenterconsole.war se trouve dans le répertoire de la console Application Center : **rép_install_produit/ApplicationCenter/console**. |

### Pour spécifier un serveur d'applications
{: #to-specify-an-application-server-3 }
Utilisez l'élément `<applicationserver>` pour définir les paramètres qui dépendent du serveur d'applications sous-jacent. L'élément `<applicationserver>` prend en charge les éléments suivants :

| Elément           | Description	                            | Nombre |
|-------------------|-------------------------------------------|-------|
| **websphereapplicationserver** ou **was**	| Paramètres pour WebSphere Application Server. L'élément `<websphereapplicationserver>` (ou `<was>` dans sa forme abrégée) signale une instance WebSphere Application Server. Le profil complet de WebSphere Application Server (versions Base et Network Deployment) est pris en charge, de même que WebSphere Application Server Liberty Core. La collectivité Liberty n'est pas prise en charge pour Application Center. | 0..1 |
| tomcat            | Paramètres pour Apache Tomcat. | 0..1 |

Les attributs et les éléments internes de ces éléments sont décrits dans les tableaux de la page [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

### Pour spécifier une connexion à la base de données des services
{: #to-specify-a-connection-to-the-services-database }
L'élément `<database>` collecte les paramètres permettant de spécifier une déclaration de source de données dans un serveur d'applications pour accéder à la base de données des services.

Vous devez déclarer une seule base de données : `<database kind="ApplicationCenter">`. Vous spécifiez l'élément `<database>` en procédant comme pour la tâche Ant `<configuredatabase>`, à ceci près que l'élément `<database>` ne possède pas les éléments `<dba>` et `<client>`. Il peut posséder les éléments `<property>`.

L'élément `<database>` possède les attributs suivants :

| Attribut    | Description                                            | Obligatoire | Valeur par défaut |
|--------------|--------------------------------------------------------|----------|---------|
| kind         | Type de base de données (ApplicationCenter).              | Oui      | Aucune    |
| validate	   | Pour déterminer si la base de données est accessible ou non. | Non       | True    |

L'élément `<database>` prend en charge les éléments suivants : Pour plus d'informations sur la configuration de ces éléments de base de données, voir les tableaux dans la section [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}.](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

| Elément           | Description	                            | Nombre |
|-------------------|-------------------------------------------|-------|
| db2	            | Paramètre pour les bases de données DB2.	        | 0..1  |
| derby             | Paramètre pour les bases de données Apache Derby.	| 0..1  |
| mysql             | Paramètre pour les bases de données MySQL.	    | 0..1  |
| oracle	        | Paramètre pour les bases de données Oracle.	    | 0..1  |
| driverclasspath   | Paramètre pour le chemin de classe du pilote JDBC.	| 0..1  |

### Pour spécifier un utilisateur et un rôle de sécurité
{: #to-specify-a-user-and-a-security-role }
L'élément `<user>` collecte les paramètres relatifs à un utilisateur qui doivent être inclus dans un rôle de sécurité spécifique pour une application.

| Attribut    | Description                                            | Obligatoire | Valeur par défaut |
|--------------|--------------------------------------------------------|----------|---------|
| role         | Rôle utilisateur appcenteradmin. | Oui | Aucune |
| name	       | Nom d'utilisateur. | Oui | Aucune |
| password	   | Mot de passe, si vous devez créer l'utilisateur.	| Non | Aucune |

## Tâches Ant pour l'installation de {{ site.data.keys.mf_analytics }}
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
Les tâches Ant **installanalytics**, **updateanalytics** et **uninstallanalytics** sont fournies pour l'installation de {{ site.data.keys.mf_analytics }}.

Ces tâches Ant ont pour finalité de configurer {{ site.data.keys.mf_analytics_console }} et le service {{ site.data.keys.mf_analytics }} avec le stockage approprié pour les données sur un serveur d'applications.
La tâche installe des noeuds {{ site.data.keys.mf_analytics }} qui
agissent comme des noeuds principaux et des données. Pour plus d'informations, voir [Gestion de cluster et Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch).

### Effets des tâches
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
La tâche Ant **installanalytics** configure un serveur d'applications pour exécuter IBM {{ site.data.keys.mf_analytics }}. Elle a les effets suivants :

* Elle déploie les fichiers WAR des services {{ site.data.keys.mf_analytics }} et {{ site.data.keys.mf_analytics_console }} sur le serveur d'applications.
* Elle déclare l'application Web du service {{ site.data.keys.mf_analytics }} dans la racine de contexte spécifiée, /analytics-service.
* Elle déclare l'application Web de {{ site.data.keys.mf_analytics_console }} dans la racine de contexte spécifiée, /analytics.
* Elle définit les propriétés de configuration des services {{ site.data.keys.mf_analytics_console }} et {{ site.data.keys.mf_analytics }} via des entrées d'environnement JNDI.
* Sur le profil Liberty de WebSphere Application Server, elle configure le conteneur Web.
* Le cas échéant, elle crée des utilisateurs pour utiliser {{ site.data.keys.mf_analytics_console }}.

#### updateanalytics
{: #updateanalytics }
La tâche Ant **updateanalytics** met à jour les fichiers WAR des applications Web du service {{ site.data.keys.mf_analytics }} et de {{ site.data.keys.mf_analytics_console }} déjà configurés sur un serveur d'applications. Ces fichiers doivent porter les mêmes noms de base que les fichiers WAR de projet précédemment déployés.

La tâche ne change pas la configuration du serveur d'applications, c'est-à-dire les entrées de configuration d'application Web et d'environnement JNDI.

#### uninstallanalytics
{: #uninstallanalytics }
La tâche Ant **uninstallanalytics** annule les effets d'une précédente exécution de la tâche **installanalytics**. Elle a les effets suivants :

* Elle supprime la configuration des applications Web du service {{ site.data.keys.mf_analytics }} et de {{ site.data.keys.mf_analytics_console }} avec leurs racines de contexte respectives.
* Elle supprime les fichiers WAR du service {{ site.data.keys.mf_analytics }} et de {{ site.data.keys.mf_analytics_console }} du serveur d'applications.
* Elle supprime les entrées associées de l'environnement JNDI.

### Attributs et éléments
{: #attributes-and-elements-4 }
Les tâches **installanalytics**, **updateanalytics** et **uninstallanalytics** possèdent les attributs suivants :

| Attribut    | Description                                            | Obligatoire | Valeur par défaut |
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   | Fichier WAR pour le service {{ site.data.keys.mf_analytics }}     | Non       | Le fichier analytics-service.war se trouve dans le répertoire Analytics. |

#### serviceWar
{: #servicewar-2 }
Utilisez l'attribut **serviceWar** afin de spécifier un répertoire différent pour le fichier WAR des services
{{ site.data.keys.mf_analytics }}. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

Les tâches `<installanalytics>`, `<updateanalytics>` et `<uninstallanalytics>` possèdent les éléments suivants :

| Attribut         | Description                               | Obligatoire | Valeur par défaut |
|-------------------|-------------------------------------------|----------|---------|
| console	        | {{ site.data.keys.mf_analytics }}   	                | Oui	   | 1       |
| user	            | Utilisateur à mapper à un rôle de sécurité.	| Non	   | 0..     |
| storage	        | Type de stockage.	                    | Oui 	   | 1       |
| applicationserver	| Serveur d'applications.	                | Oui	   | 1       |
| property          | Propriétés.	                            | Non 	   | 0..     |

### Pour spécifier {{ site.data.keys.mf_analytics_console }}
{: #to-specify-a-mobilefirst-analytics-console }
L'élément `<console>` collecte des informations permettant de personnaliser l'installation de {{ site.data.keys.mf_analytics_console }}. Cet élément possède les attributs ci-après.

| Attribut    | Description                                  | Obligatoire | Valeur par défaut |
|--------------|----------------------------------------------|----------|---------|
| warfile	   | Fichier WAR de la console	                      | Non	     | Le fichier analytics-ui.war se trouve dans le répertoire Analytics. |
| shortcutsdir | Répertoire dans lequel vous placez les raccourcis. | Non	     | Aucune    |

#### warFile
{: #warfile-2 }
Utilisez l'attribut **warFile** afin de spécifier un répertoire différent pour le fichier WAR de {{ site.data.keys.mf_analytics_console }}. Vous pouvez
spécifier le nom de ce fichier WAR avec un chemin d'accès absolu ou relatif.

#### shortcutsDir
{: #shortcutsdir-2 }
L'attribut **shortcutsDir** indique où placer les raccourcis vers {{ site.data.keys.mf_analytics_console }}. Si vous le définissez, vous pouvez ajouter les fichiers suivants dans ce répertoire :

* **analytics-console.url** : ce fichier est un raccourci Windows. Il ouvre
{{ site.data.keys.mf_analytics_console }} dans un navigateur.
* **analytics-console.sh** : ce fichier est un script shell UNIX. Il ouvre
{{ site.data.keys.mf_analytics_console }} dans un navigateur.

> Remarque : ces raccourcis n'incluent pas le paramètre de titulaire ElasticSearch.

L'élément `<console>` prend en charge l'élément imbriqué suivant :

| Elément  | Description	| Nombre |
|----------|----------------|-------|
| property | Propriétés	    | 0..   |

Avec cet élément, vous pouvez définir vos propres propriétés JNDI.

L'élément `<property>` possède les attributs suivants :

| Attribut  | Description                | Obligatoire | Valeur par défaut |
|------------|----------------------------|----------|---------|
| name       | Nom de la propriété.  | Oui      | Aucune    |
| value	     | Valeur de la propriété. |	Oui      | Aucune    |

### Pour spécifier un utilisateur et un rôle de sécurité
{: #to-specify-a-user-and-a-security-role-1 }
L'élément `<user>` collecte les paramètres relatifs à un utilisateur qui doivent être inclus dans un rôle de sécurité spécifique pour une application.

| Attribut   | Description                                   | Obligatoire | Valeur par défaut |
|-------------|-----------------------------------------------|----------|---------|
| role	      | Rôle de sécurité valide pour l'application.    | Oui      | Aucune    |
| name	      | Nom d'utilisateur.	                              | Oui      | Aucune    |
| password	  | Mot de passe si l'utilisateur doit être créé. | Non       | Aucune    |

Une fois que vous avez défini les utilisateurs à l'aide de l'élément ` <user>`, vous pouvez les mapper à n'importe lequel des rôles suivants à des fins d'authentification dans {{ site.data.keys.mf_console }} :

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### Pour spécifier un type de stockage pour {{ site.data.keys.mf_analytics }}
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
L'élément `<storage>` indique le type de stockage sous-jacent utilisé par {{ site.data.keys.mf_analytics }} pour stocker les informations et les données qu'il collecte.

Il prend en charge l'élément suivant :

| Elément       | Description	| Nombre   |
|---------------|---------------|---------|
| elasticsearch	| ElasticSearch | Cluster |

L'élément `<elasticsearch>` collecte les paramètres relatifs à un cluster ElasticSearch.

| Attribut        | Description                                   | Obligatoire | Valeur par défaut   |
|------------------|-----------------------------------------------|----------|-----------|
| clusterName	   | Nom du cluster ElasticSearch.	           | Non       | worklight |
| nodeName	       | Nom du noeud ElasticSearch. Il doit être unique dans un cluster ElasticSearch.	| Non | `worklightNode_<random number>` |
| mastersList	   | Chaîne délimitée par des virgules qui contient le nom d'hôte et les ports des noeuds principaux ElasticSearch dans le cluster ElasticSearch (par exemple hostname1:transport-port1,hostname2:transport-port2)	           | Non       |	Dépend de la topologie |
| dataPath	       | Emplacement du cluster ElasticSearch.	       | Non	      | Dépend du serveur d'applications |
| shards	       | Nombre de fragments que le cluster ElasticSearch crée. Cette valeur ne peut être définie que par les noeuds principaux qui sont créés dans le cluster ElasticSearch.	| Non | 5 |
| replicasPerShard | Nombre de répliques pour chaque fragment dans le cluster ElasticSearch. Cette valeur ne peut être définie que par les noeuds principaux qui sont créés dans le cluster ElasticSearch. | Non | 1 |
| transportPort	   | Port utilisé pour la communication noeud à noeud dans le cluster ElasticSearch.	| Non | 9600 |

#### clusterName
{: #clustername }
Utilisez l'attribut **clusterName** afin de spécifier le nom de votre choix pour le cluster ElasticSearch.

Un cluster ElasticSearch se compose d'un ou de plusieurs noeuds qui partagent le même nom de cluster ; par conséquent, vous pouvez spécifier la même
valeur pour l'attribut **clusterName** si vous configurez plusieurs noeuds.

#### nodeName
{: #nodename }
Utilisez l'attribut **nodeName** afin de spécifier le nom de votre choix pour le noeud à configurer dans le cluster ElasticSearch. Chaque
nom de noeud doit être unique dans le cluster ElasticSearch même si les noeuds s'étendent sur plusieurs machines.

#### mastersList
{: #masterslist }
Utilisez l'attribut **mastersList** pour fournir la liste des noeuds principaux de votre cluster ElasticSearch séparés par une virgule. Chaque noeud principal dans cette liste doit être identifié par son nom d'hôte et le port de communication de noeud à noeud ElasticSearch. Ce port est 9600
par défaut ou le numéro de port que vous avez spécifié avec l'attribut **transportPort** lorsque vous avez configuré ce noeud principal.

Exemple : `hostname1:transport-port1, hostname2:transport-port2`.

**Remarque :**

* Si vous spécifiez un élément **transportPort** différent de la valeur par défaut 9600, vous devez aussi définir cette valeur avec
l'attribut **transportPort**. Par défaut, lorsque l'attribut **mastersList** est omis, une tentative de détection du nom d'hôte
et du port de transport ElasticSearch est effectuée sur tous les serveurs d'applications pris en charge.
* Si le serveur d'applications cible est un cluster WebSphere Application Server Network Deployment, et si vous ajoutez ou retirez un serveur dans ce cluster ultérieurement, vous devrez éditer cette liste manuellement pour qu'elle reste synchronisée avec le cluster ElasticSearch.

#### dataPath
{: #datapath }
Utilisez l'attribut **dataPath** afin de spécifier un répertoire différent dans lequel stocker les données ElasticSearch. Vous pouvez
spécifier un chemin absolu ou un chemin relatif.

Si l'attribut **dataPath** n'est pas spécifié, les données du cluster ElasticSearch sont stockées dans un répertoire par défaut appelé
**analyticsData**, dont l'emplacement dépend du serveur d'applications :

* Pour le profil Liberty de WebSphere Application Server, l'emplacement est `${wlp.user.dir}/servers/serverName/analyticsData`.
* Pour Apache Tomcat, l'emplacement est `${CATALINA_HOME}/bin/analyticsData`.
* Pour WebSphere Application Server et WebSphere Application Server Network Deployment, l'emplacement est `${was.install.root}/profiles/<profileName>/analyticsData`.

Le répertoire **analyticsData** et la
hiérarchie des sous-répertoires et des fichiers qu'il contient sont créés automatiquement à l'exécution, s'ils n'existent pas déjà lorsque le composant
du service {{ site.data.keys.mf_analytics }} reçoit des événements.

#### shards
{: #shards }
Utilisez l'attribut **shards** afin de spécifier le nombre de fragments à créer dans le cluster ElasticSearch.

#### replicasPerShard
{: #replicaspershard }
Utilisez l'attribut **replicasPerShard** afin de spécifier le nombre de répliques à créer pour chaque fragment dans le cluster
ElasticSearch.

Chaque fragment peut avoir une ou plusieurs répliques, ou ne pas avoir de réplique. Par défaut, chaque fragment possède une réplique, mais le nombre de
répliques peut changer de façon dynamique dans un index existant dans {{ site.data.keys.mf_analytics }}. Une réplique de fragment ne peut pas être démarrée sur le même noeud que le fragment lui-même.

#### transportPort
{: #transportport }
Utilisez l'attribut **transportPort** afin de spécifier un port que les autres noeuds dans le cluster ElasticSearch doivent utiliser
pour communiquer avec ce noeud. Vous devez vous assurer que ce port est disponible et accessible s'il se trouve derrière un proxy ou un pare-feu.

### Pour spécifier un serveur d'applications
{: #to-specify-an-application-server-4 }
Utilisez l'élément `<applicationserver>` pour définir les paramètres qui dépendent du serveur d'applications sous-jacent. L'élément `<applicationserver>` prend en charge les éléments suivants :

**Remarque :** Les attributs et les éléments internes de cet élément sont décrits dans les tableaux de la page[Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elément                                   | Description	| Nombre   |
|-------------------------------------------|---------------|---------|
| **websphereapplicationserver** ou **was** | Paramètres pour WebSphere Application Server.	| 0..1 |
| tomcat	                                | Paramètres pour Apache Tomcat.	| 0..1 |

### Pour spécifier des propriétés JNDI personnalisées
{: #to-specify-custom-jndi-properties }
Les éléments `<installanalytics>`, `<updateanalytics>` et `<uninstallanalytics>` prennent en charge l'élément suivant :

| Elément  | Description | Nombre |
|----------|-------------|-------|
| property | Propriétés	 | 0..   |

Avec cet élément, vous pouvez définir vos propres propriétés JNDI.

Cet élément possède les attributs ci-après.

| Attribut  | Description                | Obligatoire | Valeur par défaut |
|------------|----------------------------|----------|---------|
| name       | Nom de la propriété.  | Oui      | Aucune    |
| value	     | Valeur de la propriété. |	Oui      | Aucune    |

## Bases de données d'environnement exécution internes
{: #internal-runtime-databases }
Découvrez les tables de base de données d'environnement d'exécution, leur finalité et l'ordre de grandeur des données stockées dans chaque table. Dans les bases de données relationnelles, les entités sont organisées en tables de base de données.

### Base de données utilisée par l'environnement d'exécution de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-runtime }
Le tableau ci-après contient une liste de tables de base de données d'environnement d'exécution accompagnées de leur description et indique comment elles sont utilisées dans les bases de données relationnelles.

| Nom de la table de base de données relationnelle | Description | Ordre de grandeur |
|--------------------------------|-------------|--------------------|
| LICENSE_TERMS	                 | Stocke les diverses métriques de licence capturées à chaque fois que la tâche de mise hors service de l'appareil est exécutée. | Des dizaines de lignes. Cette valeur ne dépasse pas la valeur définie par la propriété JNDI mfp.device.decommission.when. Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }} ](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime) |
| ADDRESSABLE_DEVICE	         | Stocke quotidiennement les indicateurs d'appareils adressables. Une entrée est également ajoutée à chaque fois qu'un cluster est démarré.	| Environ 400 lignes. Les entrées dont l'ancienneté est supérieure à 13 mois sont supprimées quotidiennement. |
| MFP_PERSISTENT_DATA	         | Stocke les instances d'applications client enregistrées auprès du serveur OAuth, y compris les informations sur l'appareil, l'application, les utilisateurs associés au client et le statut de l'appareil. | Une ligne par paire appareil/application. |
| MFP_PERSISTENT_CUSTOM_ATTR	 | Attributs personnalisés qui sont associés à des instances d'applications client. Les attributs personnalisés sont des attributs propres à l'application qui ont été enregistrés par l'application pour chaque instance client. | Aucune ligne ou plusieurs lignes par paire appareil/application. |
| MFP_TRANSIENT_DATA	         | Contexte d'authentification de clients et d'appareils | Deux lignes par paire appareil/application ; si la connexion unique à l'appareil est utilisée, deux lignes supplémentaires par appareil. Pour plus d'informations sur la connexion unique, voir [Configuration de la connexion unique à l'appareil](../../../authentication-and-security/device-sso). |
| SERVER_VERSION	             | Version du produit.	| Une ligne |

### Base de données utilisée par le service d'administration de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-administration-service }
Le tableau ci-après contient une liste de tables de base de données d'administration accompagnées de leur description et indique comment elles sont utilisées dans les bases de données relationnelles.

| Nom de la table de base de données relationnelle | Description | Ordre de grandeur |
|--------------------------------|-------------|--------------------|
| ADMIN_NODE	                 | Stocke des informations sur les serveurs qui exécutent le service d'administration. Dans une topologie autonome avec un seul  serveur, cette entité n'est pas utilisée. | Une ligne par serveur ; vide si un serveur autonome est utilisé. |
| AUDIT_TRAIL	                 | Stocke une analyse rétrospective de toutes les actions administratives effectuées avec le service d'administration. | Des milliers de lignes. |
| CONFIG_LINKS	                 | Stocke les liens vers le service Live Update. Les adaptateurs et les applications peuvent avoir des configurations stockées dans le service Live Update, et les liens sont utilisés pour retrouver ces configurations.	| Des centaines de lignes. 2 à 3 lignes sont utilisées par adaptateur. 4 à 6 lignes sont utilisées par application. |
| FARM_CONFIG	                 | Stocke la configuration des parcs de serveurs lorsqu'un parc de serveurs est utilisé. | Des dizaines de lignes ; vide si aucun parc de serveurs n'est utilisé. |
| GLOBAL_CONFIG	                 | Stocke des données de configuration globale. | 1 ligne. |
| PROJECT	                     | Stocke les noms des projets déployés. | Des dizaines de lignes. |
| PROJECT_LOCK	                 | Tâches de synchronisation de cluster internes. | Des dizaines de lignes. |
| TRANSACTIONS	                 | Table de synchronisation de cluster interne ; stocke l'état de toutes les actions d'administration en cours. | Des dizaines de lignes. |
| MFPADMIN_VERSION	             | Version du produit.	| Une ligne. |

### Base de données utilisée par le service Live Update de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-live-update-service }
Le tableau ci-après contient une liste de tables de base de données du service Live Update accompagnées de leur description et indique comment elles sont utilisées dans les bases de données relationnelles.

| Nom de la table de base de données relationnelle | Description | Ordre de grandeur |
|--------------------------------|-------------|--------------------|
| CS_SCHEMAS	                 | Stocke les schémas versionnés qui existent dans la plateforme.	| Une ligne par schéma. |
| CS_CONFIGURATIONS	             | Stocke des instances de configurations pour chaque schéma versionné. | Une ligne par configuration. |
| CS_TAGS	                     | Stocke les zones pouvant faire l'objet d'une recherche et les valeurs pour chaque instance de configuration.	| Une ligne pour chaque nom de zone et valeur pour chaque zone pouvant faire l'objet d'une recherche dans la configuration. |
| CS_ATTACHMENTS	             | Stocke les pièces jointes pour chaque instance de configuration. | Une ligne par pièce jointe. |
| CS_VERSION	                 | Stocke la version du MFP ayant créé les tables ou les instances. | Une ligne dans la table avec la version de MFP. |

### Base de données utilisée par le service push de {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-push-service }
Le tableau ci-après contient une liste de tables de base de données du service push accompagnées de leur description et indique comment elles sont utilisées dans les bases de données relationnelles.

| Nom de la table de base de données relationnelle | Description | Ordre de grandeur |
|--------------------------------|-------------|--------------------|
| PUSH_APPS	                     | Table des notifications push ; stocke les détails des applications push. | Une ligne par application. |
| PUSH_ENV	                     | Table des notifications push ; stocke les détails des environnements push. | Des dizaines de lignes. |
| PUSH_TAGS	                     | Table des notifications push ; stocke les détails des étiquettes définies.	     | Des dizaines de lignes. |
| PUSH_DEVICES	                 | Table des notifications push. Stocke un enregistrement par appareil.	         | Une ligne par appareil. |
| PUSH_SUBSCRIPTIONS	         | Table des notifications push. Stocke un enregistrement par abonnement d'étiquette. | Une ligne par abonnement d'appareil. |
| PUSH_MESSAGES	                 | Table des notifications push ; stocke les détails des messages push.	 | Des dizaines de lignes. |
| PUSH_MESSAGE_SEQUENCE_TABLE	 | Table des notifications push ; stocke l'ID de séquence généré.	 | Une ligne. |
| PUSH_VERSION	                 | Version du produit.	                                         | Une ligne. |

Pour plus d'informations sur la configuration des bases de données, voir [Configuration des bases de données](../prod-env/databases).

## Exemples de fichier de configuration
{{ site.data.keys.product }} inclut un certain nombre d'exemples de fichier de configuration destinés à vous aider à commencer à utiliser les tâches Ant pour installer {{ site.data.keys.mf_server }}.

Pour commencer à utiliser ces tâches Ant le plus facilement possible, servez-vous des exemples de fichier de configuration fournis dans le répertoire **MobileFirstServer/configuration-samples/** de la distribution de {{ site.data.keys.mf_server }}. Pour plus d'informations sur l'installation de {{ site.data.keys.mf_server }} à l'aide de tâches Ant, voir [Installation à l'aide de tâches Ant](../prod-env/appserver/#installing-with-ant-tasks).

### Liste des exemples de fichier de configuration
{: #list-of-sample-configuration-files }
Choisissez l'exemple de fichier de configuration approprié. Les fichiers suivants sont fournis :

| Tâche                                                     | Derby                     | DB2                     | MySQL                     | Oracle                      |
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
| Créer les bases de données avec les données d'identification de l'administrateur de base de données | create-database-derby.xml | create-database-db2.xml | create-database-mysql.xml | create-database-oracle.xml
| Installer {{ site.data.keys.mf_server }} sur Liberty	                   | configure-liberty-derby.xml | configure-liberty-db2.xml | configure-liberty-mysql.xml | (Voir Remarque sur MySQL) | configure-liberty-oracle.xml |
| Installer {{ site.data.keys.mf_server }} sur le profil complet de WebSphere Application Server, serveur unique |	configure-was-derby.xml | configure-was-db2.xml | configure-was-mysql.xml (voir Remarque sur MySQL) | configure-was-oracle.xml |
| Installer {{ site.data.keys.mf_server }} sur WebSphere Application Server Network Deployment (voir Remarque sur les fichiers de configuration) | configure-wasnd-cluster-derby.xml, configure-wasnd-server-derby.xml, configure-wasnd-node-derby.xml. configure-wasnd-cell-derby.xml | configure-wasnd-cluster-db2.xml, configure-wasnd-server-db2.xml, configure-wasnd-node-db2.xml, configure-wasnd-cell-db2.xml | configure-wasnd-cluster-mysql.xml (voir Remarque sur MySQL),  configure-wasnd-server-mysql.xml (voir Remarque sur MySQL), configure-wasnd-node-mysql.xml (voir Remarque sur MySQL), configure-wasnd-cell-mysql.xml | configure-wasnd-cluster-oracle.xml, configure-wasnd-server-oracle.xml, configure-wasnd-node-oracle.xml, configure-wasnd-cell-oracle.xml |
| Installer {{ site.data.keys.mf_server }} sur Apache Tomcat	           | configure-tomcat-derby.xml | configure-tomcat-db2.xml | configure-tomcat-mysql.xml | configure-tomcat-oracle.xml |
| Installer {{ site.data.keys.mf_server }} sur une collectivité Liberty	       | Non pertinent              | configure-libertycollective-db2.xml | configure-libertycollective-mysql.xml | configure-libertycollective-oracle.xml |

**Remarque sur MySQL :** L'utilisation de MySQL conjointement avec le profil Liberty de WebSphere Application Server ou le profil complet de WebSphere Application Server n'est pas considérée comme une configuration prise en charge. Pour plus d'informations, voir la déclaration de prise en charge sur WebSphere Application Server. Envisagez d'utiliser IBM DB2 ou une autre base de données qui est prise en charge par WebSphere Application Server afin de bénéficier d'une configuration entièrement prise en charge par le support IBM.

**Remarque sur les fichiers de configuration pour WebSphere Application Server Network Deployment : ** Les fichiers de configuration pour **wasnd** contiennent une portée qui peut avoir pour valeur **cluster**, **node**, **server** ou **cell**. Par exemple, pour le fichier **configure-wasnd-cluster-derby.xml**, la portée est **cluster**. Ces types de portée définissent la cible de déploiement de la façon suivante :

* **cluster** : permet de déployer un cluster.
* **server** : permet de déployer un serveur unique géré par le gestionnaire de déploiement.
* **node** : permet de déployer tous les serveurs en cours d'exécution sur un noeud, qui n'appartiennent pas à un cluster.
* **cell** : permet de déployer tous les serveurs sur une cellule.

## Exemples de fichier de configuration pour {{ site.data.keys.mf_analytics }}
{: #sample-configuration-files-for-mobilefirst-analytics }
{{ site.data.keys.product }} inclut un certain nombre d'exemples de fichier de configuration destinés à vous aider à commencer à utiliser les tâches Ant pour installer les services {{ site.data.keys.mf_analytics }} et {{ site.data.keys.mf_analytics_console }}.

Pour commencer à utiliser les tâches Ant `<installanalytics>`, `<updateanalytics>` et `<uninstallanalytics>` le plus facilement possible, servez-vous des exemples de fichier de configuration fournis dans le répertoire **Analytics/configuration-samples/** de la distribution de {{ site.data.keys.mf_server }}.

### Etape 1
{: #step-1 }
Choisissez l'exemple de fichier de configuration approprié. Les fichiers XML ci-après sont fournis. Ils sont appelés **configure-file.xml**
dans les étapes suivantes.

| Tâche | Serveur d'applications |
|------|--------------------|
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur le profil Liberty de WebSphere Application Server | configure-liberty-analytics.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur Apache Tomcat | configure-tomcat-analytics.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur le profil complet de WebSphere Application Server | configure-was-analytics.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Network Deployment, serveur unique | configure-wasnd-server-analytics.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Network Deployment, cellule | configure-wasnd-cell-analytics.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Network Deployment, noeud | configure-wasnd-node.xml |
| Installer les services et la console {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Network Deployment, cluster | configure-wasnd-cluster-analytics.xml |

**Remarque sur les fichiers de configuration pour WebSphere Application Server Network Deployment :**  
Les fichiers de configuration pour wasnd contiennent une portée qui peut avoir pour valeur **cluster**, **node**, **server** ou **cell**. Par exemple, pour
**configure-wasnd-cluster-analytics.xml**, la portée est le **cluster**. Ces types de portée définissent la cible de déploiement de la façon suivante :

* **cluster** : permet de déployer un cluster.
* **server** : permet de déployer un serveur unique géré par le gestionnaire de déploiement.
* **node** : permet de déployer tous les serveurs en cours d'exécution sur un noeud, qui n'appartiennent pas à un cluster.
* **cell** : permet de déployer tous les serveurs sur une cellule.

### Etape 2
{: #step-2 }
Changez les droits d'accès à l'exemple de fichier pour qu'ils soient aussi restrictifs que possible. L'étape 3
requiert l'indication de mots de passe. Si vous devez empêcher d'autres utilisateurs sur le même ordinateur de prendre connaissance de ces mots de passe,
vous devez retirer les droits d'accès en lecture au fichier pour ces autres utilisateurs. Vous pouvez utiliser une commande, comme
dans les exemples suivants :

Sous UNIX : `chmod 600 configure-file.xml`
Sous Windows : `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### Etape 3
{: #step-3 }
De la même façon, si votre serveur d'applications est un profil Liberty de WebSphere Application Server, ou Apache Tomcat, et qu'il est destiné à être démarré uniquement depuis votre compte utilisateur, vous devez également retirer les droits d'accès en lecture pour les autres utilisateurs dans les fichiers suivants :

* Pour le profil Liberty de WebSphere Application Server : **wlp/usr/servers/<server>/server.xml**
* Pour Apache Tomcat : **conf/server.xml**

### Etape 4
{: #step-4 }
Remplacez les valeurs de marque de réservation pour les propriétés au début du fichier.

**Remarque :**  
Les caractères spéciaux suivants doivent être associés à
des caractères d'échappement lorsqu'ils sont utilisés dans les valeurs des scripts XML Ant :

* Le symbole du dollar (`$`) doit être écrit sous la forme $$, sauf si vous voulez référencer explicitement une variable
Ant via la syntaxe `${variable}`, comme décrit dans
la section Properties du manuel Apache Ant.
* Le caractère de la perluète (`&`) doit être écrit sous la forme `&amp;`, sauf si vous voulez référencer explicitement une entité XML.
* Les guillemets (`"`) doivent être écrits sous la forme `&quot;`, sauf lorsqu'ils figurent au sein d'une chaîne placée entre apostrophes.

### Etape 5
{: #step-5 }
Exécutez la commande `ant -f configure-file.xml install`

Cette commande installe vos services {{ site.data.keys.mf_analytics }} et composants {{ site.data.keys.mf_analytics_console }} dans le serveur d'applications.
Pour installer les services {{ site.data.keys.mf_analytics }} et composants {{ site.data.keys.mf_analytics_console }} mis à jour, par exemple, si vous appliquez un groupe de correctifs {{ site.data.keys.mf_server }}, exécutez la commande suivante : `ant -f configure-file.xml minimal-update`.

Pour inverser l'étape d'installation, exécutez la commande `ant -f configure-file.xml uninstall`

Cette commande désinstalle les services {{ site.data.keys.mf_analytics }} et les composants {{ site.data.keys.mf_analytics_console }}.
