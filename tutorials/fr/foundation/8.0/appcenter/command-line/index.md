---
layout: tutorial
title: Outil de ligne de commande permettant de télécharger ou de supprimer une application
breadcrumb_title: Téléchargement ou suppression d'une application
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Pour déployer des applications dans Application Center via un processus de génération, utilisez l'outil de ligne de commande.

Vous pouvez télécharger une application vers Application Center à l'aide de l'interface Web de la console Application Center. Vous pouvez également télécharger une nouvelle application à l'aide d'un outil de ligne de commande.

Cela est particulièrement utile lorsque vous souhaitez incorporer le déploiement d'une application à Application Center dans un processus de génération. Cet outil se trouve dans : **installDir/ApplicationCenter/tools/applicationcenterdeploytool.jar**.

L'outil peut être utilisé pour les fichiers d'application avec l'extension APK ou IPA. Il peut être utilisé seul ou en tant que tâche Ant.

Le répertoire tools contient tous les fichiers nécessaires à l'utilisation de l'outil.

* **applicationcenterdeploytool.jar** : outil de téléchargement.
* **json4j.jar** : bibliothèque pour le format JSON requis par l'outil de téléchargement.
* **build.xml** : exemple de script Ant que vous pouvez utiliser pour télécharger un fichier unique ou une séquence de fichiers dans Application Center.
* **acdeploytool.sh** et **acdeploytool.bat** : scripts simples pour appeler java avec **applicationcenterdeploytool.jar**.

#### Accéder à
{: #jump-to }
* [Utilisation de l'outil autonome pour télécharger une application](#using-the-stand-alone-tool-to-upload-an-application)
* [Utilisation de l'outil autonome pour supprimer une application](#using-the-stand-alone-tool-to-delete-an-application)
* [Utilisation de l'outil autonome pour effacer le cache LDAP](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [Tâche Ant pour le téléchargement ou la suppression d'une application](#ant-task-for-uploading-or-deleting-an-application)

### Utilisation de l'outil autonome pour télécharger une application
{: #using-the-stand-alone-tool-to-upload-an-application }
Pour télécharger une application, appelez l'outil autonome à partir de la ligne de commande.  
Utilisez l'outil autonome en suivant ces étapes.

1. Ajoutez **applicationcenterdeploytool.jar** et **json4j.jar** à la variable d'environnement classpath java.
2. Appelez l'outil de téléchargement à partir de la ligne de commande :

   ```bash
   java com.ibm.appcenter.Upload [options] [files]
   ```

Vous pouvez transmettre l'une des options disponibles dans la ligne de commande.

| Option | Contenu indiqué par | Description |
|--------|----------------------|-------------|
| -s | serverpath | Chemin d'accès au serveur Application Center. |
| -c | context | Contexte de l'application Web Application Center. |
| -u | user | Données d'identification de l'utilisateur pour accéder à Application Center. |
| -p | password | Mot de passe de l'utilisateur. |
| -d | description | Description de l'application à télécharger. |
| -l | label | Etiquette de réserve. Normalement, l'étiquette est extraite du descripteur d'application stocké dans le fichier à télécharger. Si le descripteur d'application ne contient pas d'étiquette, l'étiquette de réserve est utilisée. |
| -isActive | true ou false | L'application est stockée dans Application Center en tant qu'application active ou inactive. |
| -isInstaller | true ou false | L'application est stockée dans Application Center avec l'indicateur "installer" correctement défini. |
| -isReadyForProduction | true ou false | L'application est stockée dans Application Center avec l'indicateur "ready-for-production" correctement défini. |
| -isRecommended | true ou false | L'application est stockée dans Application Center avec l'indicateur "recommended" correctement défini. |
| -e	  |  | Affiche la trace de la pile d'exception complète en cas d'échec. |
| -f	  |  | Force le téléchargement des applications, même si elles existent déjà. |
| -y	  |  | Désactive la vérification de la sécurité SSL, qui permet la publication sur des hôtes sécurisés sans vérification du certificat SSL. |  L'utilisation de cet indicateur est un risque de sécurité, mais peut être appropriée pour tester l'hôte local avec des certificats SSL auto-signés temporaires. |

Le paramètre files peut spécifier des fichiers de type fichiers de modules d'application Android (.apk) ou fichiers d'application iOS (.ipa).  
Dans cet exemple, le mot de passe de la démonstration de l'utilisateur est demopassword. Utilisez cette ligne de commande.

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### Utilisation de l'outil autonome pour supprimer une application
{: #using-the-stand-alone-tool-to-delete-an-application }
Pour supprimer une application d'Application Center, appelez l'outil autonome à partir de la ligne de commande.  
Utilisez l'outil autonome en suivant ces étapes.

1. Ajoutez **applicationcenterdeploytool.jar** et **json4j.jar** à la variable d'environnement classpath java.
2. Appelez l'outil de téléchargement à partir de la ligne de commande :

   ```bash
   java com.ibm.appcenter.Upload -delete [options] [files or applications]
   ```

Vous pouvez transmettre l'une des options disponibles dans la ligne de commande.

| Option | Contenu indiqué par	| Description |
|--------|----------------------|-------------|
| -s |serverpath | Chemin d'accès au serveur Application Center. |
| -c | context | Contexte de l'application Web Application Center. |
| -u | user | Données d'identification de l'utilisateur pour accéder à Application Center. |
| -p | password | Mot de passe de l'utilisateur. |
| -y | | Désactive la vérification de la sécurité SSL, qui permet la publication sur des hôtes sécurisés sans vérification du certificat SSL. L'utilisation de cet indicateur est un risque de sécurité, mais peut être appropriée pour tester l'hôte local avec des certificats SSL auto-signés temporaires. |

Vous pouvez spécifier des fichiers ou le module d'application, le système d'exploitation et la version. Si des fichiers sont spécifiés, le module, le système d'exploitation et la version sont déterminés à partir du fichier et l'application correspondante est supprimée d'Application Center. Si des applications sont spécifiées, elles doivent être à l'un des formats suivants :

* `package@os@version` : cette version exacte est supprimée d'Application Center. La partie version doit spécifier la "version interne" et non la "version commerciale" de l'application.
* `package@os` : toutes les versions de cette application sont supprimées d'Application Center.
* `package` : toutes les versions de tous les systèmes d'exploitation de cette application sont supprimées d'Application Center.

#### Exemple
{: #example-delete }
Dans cet exemple, le mot de passe de la démonstration de l'utilisateur est demopassword. Utilisez cette ligne de commande pour supprimer l'application iOS demo.HelloWorld avec la version interne 3.0.

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### Utilisation de l'outil autonome pour effacer le cache LDAP
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
Utilisez l'outil autonome pour effacer le cache LDAP et afficher immédiatement les modifications des utilisateurs et des groupes LDAP dans Application Center.

Lorsqu'Application Center est configuré avec LDAP, les modifications apportées aux utilisateurs et aux groupes sur le serveur LDAP sont affichées dans Application Center après un délai. Application Center conserve un cache de données LDAP et les modifications ne deviennent visibles qu'après l'expiration du cache. Par défaut, le délai est de 24 heures. Si vous ne souhaitez pas attendre l'expiration du délai après les modifications apportées aux utilisateurs ou aux groupes, vous pouvez appeler l'outil autonome à partir de la ligne de commande pour effacer le cache de données LDAP. Lorsque vous utilisez l'outil autonome pour effacer le cache, les modifications deviennent immédiatement visibles.

Utilisez l'outil autonome en suivant ces étapes.

1. Ajoutez applicationcenterdeploytool.jar et json4j.jar à la variable d'environnement classpath java.
2. Appelez l'outil de téléchargement à partir de la ligne de commande :

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [options]
   ```

Vous pouvez transmettre l'une des options disponibles dans la ligne de commande.

| Option | Contenu indiqué par | Description |
|--------|----------------------|-------------|
| -s | serverpath | Chemin d'accès au serveur Application Center.|
| -c | context | Contexte de l'application Web Application Center.|
| -u | user | Données d'identification de l'utilisateur pour accéder à Application Center.|
| -p | password | Mot de passe de l'utilisateur.|
| -y | | Désactive la vérification de la sécurité SSL, qui permet la publication sur des hôtes sécurisés sans vérification du certificat SSL. L'utilisation de cet indicateur est un risque de sécurité, mais peut être appropriée pour tester l'hôte local avec des certificats SSL auto-signés temporaires.|

#### Exemple
{: #example-cache }
Dans cet exemple, le mot de passe de la démonstration de l'utilisateur est demopassword.

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### Tâche Ant pour le téléchargement ou la suppression d'une application
{: #ant-task-for-uploading-or-deleting-an-application}

Vous pouvez utiliser les outils de téléchargement et de suppression comme tâche Ant et utiliser la tâche Ant dans votre propre script Ant.  
Apache Ant est nécessaire pour exécuter ces tâches. La version minimale prise en charge d'Apache Ant est répertoriée dans la [Configuration requise](../../product-overview/requirements).

Pour plus de commodité, Apache Ant 1.8.4 est inclus dans {{ site.data.keys.mf_server }}. Dans le répertoire product_install_dir/shortcuts/, les scripts suivants sont fournis :

* ant pour UNIX / Linux
* ant.bat pour Windows

Ces scripts sont prêts à être exécutés, ce qui signifie qu'ils ne nécessitent pas de variables d'environnement spécifiques. Si la variable d'environnement JAVA_HOME est définie, les scripts l'acceptent.

Lorsque vous utilisez l'outil de téléchargement comme tâche Ant, la valeur classname de la tâche Ant de téléchargement est **com.ibm.appcenter.ant.UploadApps**. La valeur classname de la tâche Ant de suppression est **com.ibm.appcenter.ant.DeleteApps**.

| Paramètres de la tâche Ant | Description |
|------------------------|-------------|
| serverPath | Pour se connecter à Application Center. La valeur par défaut est http://localhost:9080. |
| context | Contexte d'Application Center. La valeur par défaut est /applicationcenter. |
| loginUser | Nom d'utilisateur doté des droits appropriés pour télécharger une application. |
| loginPass | Mot de passe de l'utilisateur doté des droits pour télécharger une application. |
| forceOverwrite | Si ce paramètre est défini sur true, la tâche Ant tente d'écraser les applications dans Application Center lorsqu'elle télécharge une application déjà présente. Ce paramètre est disponible uniquement dans la tâche Ant de téléchargement.
| file | Le fichier .apk ou .ipa doit être téléchargé dans Application Center ou doit être supprimé d'Application Center. Ce paramètre ne possède pas de valeur par défaut. |
| fileset | Pour télécharger ou supprimer plusieurs fichiers. |
| application | Nom du module de l'application ; ce paramètre est disponible uniquement dans la tâche Ant de suppression. |
| os | Système d'exploitation de l'application. (Par exemple, Android ou iOS.) Ce paramètre est disponible uniquement dans la tâche Ant de suppression. |
| version | Version interne de l'application ; ce paramètre est disponible uniquement dans la tâche Ant de suppression. N'utilisez pas la version commerciale ici, car cette version ne convient pas pour identifier la version exactement. |

#### Exemple
{: #example-ant }
Vous pouvez trouver un exemple développé dans le répertoire **ApplicationCenter/tools/build.xml**.  
L'exemple suivant montre comment utiliser la tâche Ant dans votre propre script Ant.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Server Properties -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" />
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!--  Authentication Properties -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps">
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

Cet exemple de script Ant se trouve dans le répertoire **tools**. Vous pouvez l'utiliser pour télécharger une application unique dans Application Center.

```bash
ant upload.App -Dupload.file=sample.ipa
```

Vous pouvez également l'utiliser pour télécharger toutes les applications trouvées dans une hiérarchie de répertoires.

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### Propriétés de l'exemple de script Ant
{: #properties-of-the-sample-ant-script }
| Propriété | Commentaire |
|----------|---------|
| install.dir | Par défaut, ../../ |
| server.path | La valeur par défaut est http://localhost:9080. |
| context.path | La valeur par défaut est applicationcenter. |
| upload.file | Cette propriété n'a pas de valeur par défaut. Elle doit inclure le chemin d'accès au fichier. |
| workspace.root | Par défaut, ../../ |
| login.user | La valeur par défaut est appcenteradmin. |
| login.pass | La valeur par défaut est admin. |
| force	La valeur par défaut est true. |

Pour spécifier ces paramètres en ligne de commande lorsque vous appelez Ant, ajoutez -D avant le nom de la propriété. Par exemple :

```xml
-Dserver.path=http://localhost:8888/
```
