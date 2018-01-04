---
layout: tutorial
title: Administration d'applications via Ant
breadcrumb_title: Administration à l'aide de Ant
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez administrer des applications {{ site.data.keys.product_adj }} via la tâche Ant **mfpadm**.

#### Accéder à
{: #jump-to }

* [Comparaison avec d'autres fonctions](#comparison-with-other-facilities)
* [Prérequis](#prerequisites)

## Comparaison avec d'autres fonctions
{: #comparison-with-other-facilities }
Vous pouvez exécuter des opérations d'administration à l'aide d'{{ site.data.keys.product_full }} en utilisant les composants suivants :

* La console {{ site.data.keys.mf_console }}, qui est interactive.
* La tâche Ant **mfpadm**.
* Le programme **mfpadm**.
* Les services REST d'administration de {{ site.data.keys.product_adj }}.

La tâche Ant **mfpadm**, le programme **mfpadm** et les services REST sont utiles pour l'exécution automatisée ou sans assistance d'opérations, telles que les suivantes :

* Elimination d'erreurs d'opérateur dans des opérations répétitives, ou
* Exploitation en dehors des heures de travail normales de l'opérateur, ou
* Configuration d'un serveur de production avec les mêmes paramètres qu'un serveur de test ou de préproduction.

La tâche Ant **mfpadm** et le programme **mfpadm** sont plus simples à utiliser et fournissent une meilleure génération de rapports d'erreurs que les services REST. Comparée au programme mfpadm, la tâche Ant **mfpadm** présente l'avantage d'être non tributaire de la plateforme et plus facile à intégrer lorsque l'intégration à Ant est déjà disponible.

## Prérequis
{: #prerequisites }
L'outil **mfpadm** est installé à l'aide du programme d'installation de {{ site.data.keys.mf_server }}. Sur cette page,  **product\_install\_dir** indique le répertoire d'installation du programme d'installation de {{ site.data.keys.mf_server }}.

Apache Ant est requis pour l'exécution de la tâche **mfpadm**. Pour toute information sur la version Ant minimale prise en charge, voir la section Configuration requise.

Pour plus de commodité, Apache Ant 1.9.4 est inclus dans {{ site.data.keys.mf_server }}. Dans le répertoire **product\_install\_dir/shortcuts/**, les scripts suivants sont fournis.

* ant pour UNIX/Linux
* ant.bat pour Windows

Ces scripts sont prêts à être exécutés, ce qui signifie qu'ils ne nécessitent pas de variables d'environnement spécifiques. Si la variable d'environnement JAVA_HOME est définie, les scripts l'acceptent.

Vous pouvez utiliser la tâche Ant **mfpadm** sur un autre ordinateur que celui sur lequel vous avez installé {{ site.data.keys.mf_server }}.

* Copiez le fichier **product\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar** sur l'ordinateur.
* Assurez-vous qu'une version prise en charge d'Apache Ant et un environnement d'exécution Java sont installés sur l'ordinateur.

Pour utiliser la tâche Ant **mfpadm**, ajoutez cette commande d'initialisation au script Ant :

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="rép_install_produit/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Les autres commandes d'initialisation qui font référence au même fichier **mfp-ant-deployer.jar** sont redondantes car l'initialisation par **defaults.properties** est également effectuée implicitement par antlib.xml. Voici un exemple de commande d'initialisation redondante :

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="rép_install_produit/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Pour plus d'informations sur l'exécution du programme d'installation de {{ site.data.keys.mf_server }}, voir [Exécution d'IBM Installation Manager](../../installation-configuration/production/installation-manager/).

#### Accéder à
{: #jump-to-1 }

* [Appel de la tâche Ant **mfpadm**](#calling-the-mfpadm-ant-task)
* [Commandes de configuration générale](#commands-for-general-configuration)
* [Commandes pour adaptateurs](#commands-for-adapters)
* [Commandes pour applications](#commands-for-apps)
* [Commandes pour appareils](#commands-for-devices)
* [Commandes de traitement des incidents](#commands-for-troubleshooting)

### Appel de la tâche Ant mfpadm
{: #calling-the-mfpadm-ant-task }
Vous pouvez utiliser la tâche Ant **mfpadm** et les commandes qui lui sont associées pour administrer des applications {{ site.data.keys.product_adj }}.
Appelez la tâche Ant **mfpadm** comme suit :

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    some commands
</mfpadm>
```

#### Attributs
{: #attributes }
La tâche Ant **mfpadm** possède les attributs suivants :

| Attribut      | Description | Obligatoire | Par défaut | 
|----------------|-------------|----------|---------|
| url	         | URL de base de l'application Web {{ site.data.keys.product_adj }} pour les services d'administration | Oui	 | |
| secure	     | Indique si les opérations présentant des risques de sécurité doivent être évitées | Non | true |
| user	         | Nom d'utilisateur permettant d'accéder aux services d'administration de {{ site.data.keys.product_adj }} | Oui | |
| password	     | Mot de passe de l'utilisateur | L'un des deux est obligatoire | |
| passwordfile   |	Fichier contenant le mot de passe de l'utilisateur | L'un des deux est obligatoire | |	 
| timeout	     | Délai d'attente relatif à l'accès à l'ensemble du service REST, exprimé en secondes | Non | |
| connectTimeout |	Délai d'attente relatif à l'établissement d'une connexion réseau, exprimé en secondes | Non | |	 
| socketTimeout  |	Délai d'attente relatif à la détection de la perte d'une connexion réseau, exprimé en secondes | Non | |
| connectionRequestTimeout |	Délai d'attente relatif à l'obtention d'une entrée à partir d'un pool de demande de connexion, exprimé en secondes | Non | |
| lockTimeout    |	Délai d'attente relatif à l'acquisition d'un verrou | Non | |

**url**<br/>
L'URL de base utilise de préférence le protocole HTTPS. Par exemple, si vous utilisez des ports et des racines de contexte par défaut, utilisez l'URL suivante.

* Pour WebSphere Application Server : [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* Pour Tomcat : [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
La valeur par défaut est **true**. Définir **secure="false"** peut avoir les effets suivants :

* L'utilisateur et le mot de passe peuvent être transmis de façon non sécurisée, peut-être même via un protocole HTTP non chiffré.
* Les certificats SSL du serveur sont acceptés même s'ils sont auto-signés ou s'ils ont été créés pour un nom d'hôte différent du nom d'hôte du serveur spécifié.

**password**<br/>
Spécifiez le mot de passe dans le script Ant, via l'attribut **password**, ou dans un fichier distinct que vous transmettez via l'attribut **passwordfile**. Le mot de passe constitue des informations sensibles qui doivent par conséquent être protégées. Vous devez empêcher les autres utilisateurs de l'ordinateur de connaître ce mot de passe. Pour sécuriser un mot de passe, avant de saisir ce dernier dans un fichier, retirez les droits d'accès en lecture à ce fichier pour les autres utilisateurs. Par exemple, utilisez l'une des commandes suivantes :

* Sous UNIX : `chmod 600 adminpassword.txt`
* Sous Windows : `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

En outre, vous souhaiterez peut-être brouiller le mot de passe afin qu'il ne puisse pas être entrevu. Pour cela, utilisez la commande **mfpadm** config password afin de stocker le mot de passe brouillé dans un fichier de configuration. Vous pouvez ensuite copier et coller le mot de passe brouillé dans le script Ant ou dans le fichier de mot de passe.

L'appel **mfpadm** contient des commandes codées dans des éléments internes. Ces commandes sont exécutées dans l'ordre où elles sont répertoriées. Si l'une des commandes échoue, les autres commandes ne sont pas exécutées et l'appel **mfpadm** échoue.

#### Eléments
{: #elements }
Vous pouvez utiliser les éléments suivants dans des appels **mfpadm** :

| Elément                       | Description | Nombre |
|-------------------------------|-------------|-------|
| show-info	                    | Affiche des informations de configuration et d'utilisateur | 0..∞ | 
| show-global-config	        | Affiche des informations de configuration globale | 0..∞ | 
| show-diagnostics              | Affiche des informations de diagnostic | 0..∞ | 
| show-versions	                | Affiche des informations de version | 0..∞ | 
| unlock	                    | Libère le verrou général | 0..∞ | 
| list-runtimes	                | Répertorie les environnements d'exécution | 0..∞ | 
| show-runtime      	        | Affiche des informations sur un environnement d'exécution | 0..∞ | 
| delete-runtime	            | Supprime un environnement d'exécution | 0..∞ | 
| show-user-config	            | Affiche la configuration utilisateur d'un environnement d'exécution | 0..∞ | 
| set-user-config	            | Spécifie la configuration utilisateur d'un environnement d'exécution | 0..∞ | 
| show-confidential-clients	    | Affiche les configurations des clients confidentiels d'un environnement d'exécution | 0..∞ | 
| set-confidential-clients	    | Spécifie les configurations des clients confidentiels d'un environnement d'exécution | 0..∞ | 
| set-confidential-clients-rule	| Spécifie une règle pour la configuration de clients confidentiels d'un environnement d'exécution | 0..∞ | 
| list-adapters	                | Répertorie les adaptateurs | 0..∞ | 
| deploy-adapter	            | Déploie un adaptateur | 0..∞ | 
| show-adapter	                | Affiche des informations sur un adaptateur | 0..∞ | 
| delete-adapter	            | Supprime un adaptateur | 0..∞ | 
| adapter	                    | Autres opérations sur un adaptateur | 0..∞ | 
| list-apps	                    | Répertorie les applications | 0..∞ | 
| deploy-app	                | Déploie une application | 0..∞ | 
| show-app	                    | Affiche des informations sur une application | 0..∞ | 
| delete-app	                | Supprime une application | 0..∞ | 
| show-app-version              | Affiche des informations sur une version d'application | 0..∞ | 
| delete-app-version            | Supprime une version d'une application | 0..∞ | 
| app	                        | Autres opérations sur une application | 0..∞ | 
| app-version	                | Autres opérations sur une version d'application | 0..∞ | 
| list-devices	                | Répertorie les appareils | 0..∞ | 
| remove-device	                | Retire un appareil | 0..∞ | 
| device	                    | Autres opérations pour un appareil | 0..∞ | 
| list-farm-members	            | Répertorie les membres du parc de serveurs | 0..∞ | 
| remove-farm-member	        | Retire un membre de parc de serveurs | 0..∞ | 

#### Format XML
{: #xml-format }
Le résultat de la plupart des commandes s'affiche au format XML, et les données d'entrée dans des commandes spécifiques, telles que `<set-accessrule>`, s'affichent également au format XML. Les schémas XML de ces formats XML figurent dans le répertoire **product\_install\_dir/MobileFirstServer/mfpadm-schemas/**. Les commandes qui reçoivent une réponse XML du serveur vérifient que cette réponse est conforme au schéma donné. Vous pouvez désactiver cette option en spécifiant l'attribut **xmlvalidation="none"**. 

#### Jeu de caractères de sortie
{: #output-character-set }
Le résultat normal de la tâche Ant mfpadm est codé à l'aide du format de codage de l'environnement local en cours. Sous Windows, ce format de codage est appelé "page de codes ANSI". Les effets sont les suivants :

* Les caractères non compris dans ce jeu de caractères sont convertis en points d'interrogation lorsqu'ils sont affichés.
* Lorsque le résultat est dirigé vers une fenêtre d'invite de commande Windows (cmd.exe), les caractères non ASCII ne s'affichent pas correctement car ce type de fenêtre considère que les caractères sont codés dans la "page de codes OEM".

Pour contourner cette limitation :

* Sur les systèmes d'exploitation autres que Windows, utilisez un environnement local dont le codage est UTF-8. Cet environnement local est l'environnement local par défaut sur Red Hat Linux et  macOS. De nombreux autres systèmes d'exploitation possèdent l'environnement local en_US.UTF-8.
* Vous pouvez aussi utiliser l'attribut **output="some file name"** pour rediriger le résultat d'une commande mfpadm vers un fichier.

### Commandes de configuration générale
{: #commands-for-general-configuration }
Lorsque vous appelez la tâche Ant **mfpadm**, vous pouvez inclure différentes commandes permettant d'accéder à la configuration globale d'un serveur IBM {{ site.data.keys.mf_server }} ou d'un environnement d'exécution.

#### Commande `show-global-config`
{: #the-show-global-config-command }
La commande `show-global-config` affiche la configuration globale. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output	     | Nom du fichier de sortie.  |	Non	   | Non applicable |
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable |

**Exemple**  

```xml
<show-global-config/>
```

Cette commande est basée sur le service REST [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-).

<br/>
#### Commande `show-user-config`
{: #the-show-user-config-command }
La commande `show-user-config`, spécifiée en dehors des éléments `<adapter>` et `<app-version>`, affiche la configuration utilisateur d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	     | Nom de l'environnement d'exécution.      | Oui     |	Non disponible |
| format	     | Indique le format de sortie. JSON ou XML. | Oui | Non disponible       | 
| output	     | Nom du fichier dans lequel stocker le résultat.   | Non  | Non applicable      | 
| outputproperty | Nom d'une propriété Ant dans laquelle stocker le résultat.  | Non | Non applicable |

**Exemple**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

Cette commande est basée sur le service REST [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Commande `set-user-config`
{: #the-set-user-config-command }
La commande `set-user-config`, spécifiée en dehors des éléments `<adapter>` et `<app-version>`, spécifie la configuration utilisateur d'un environnement d'exécution. Elle possède les attributs suivants permettant de définir l'ensemble de la configuration :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime        | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| file	         | Nom du fichier JSON ou XML contenant la nouvelle configuration. | Oui | Non disponible | 

La commande `set-user-config` possède les attributs suivants permettant de définir une propriété unique dans la configuration.

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	     | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| property	     | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. | Oui | Non disponible | 
| value	         | Valeur de la propriété. | Oui | Non disponible |

**Exemple**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

Cette commande est basée sur le service REST [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-).

<br/>
#### Commande `show-confidential-clients`
{: #the-show-confidential-clients-command }
La commande `show-confidential-clients` affiche la configuration des clients confidentiels pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients). Cette commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime        | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| format         | Indique le format de sortie. JSON ou XML. | Oui | Non disponible | 
| output         | Nom du fichier dans lequel stocker le résultat. | Non | Non applicable | 
| outputproperty | Nom d'une propriété Ant dans laquelle stocker le résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

Cette commande est basée sur le service REST [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc).

<br/>
#### Commande `set-confidential-clients`
{: #the-set-confidential-clients-command }
La commande `set-confidential-clients` spécifie la configuration des clients confidentiels pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients). Cette commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime        | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| file	         | Nom du fichier JSON ou XML contenant la nouvelle configuration. | Oui | Non disponible | 

**Exemple**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

Cette commande est basée sur le service REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

<br/>
#### Commande `set-confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
La commande `set-confidential-clients-rule` spécifie une règle dans la configuration des clients confidentiels pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients). Cette commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime        | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| id             | Identificateur de la règle. | Oui | Non disponible | 
| displayName    | Nom d'affichage de la règle. | Oui | Non disponible | 
| secret         | Secret de la règle. | Oui | Non disponible | 
| allowedScope   | Portée de la règle. Liste de jetons séparés par des espaces. | Oui | Non disponible | 

**Exemple**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

Cette commande est basée sur le service REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

### Commandes pour adaptateurs
{: #commands-for-adapters }
Lorsque vous appelez la tâche Ant **mfpadm**, vous pouvez inclure différentes commandes pour adaptateurs.

#### Commande `list-adapters`
{: #the-list-adapters-command }
La commande `list-adapters` renvoie la liste des adaptateurs déployés pour un environnement d'exécution donné. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime        | Nom de l'environnement d'exécution. | 	Oui | Non disponible | 
| output	     | Nom du fichier de sortie. | 	Non  | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<list-adapters runtime="mfp"/>
```

Cette commande est basée sur le service REST [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-).

<br/>
#### Commande `deploy-adapter`
{: #the-deploy-adapter-command }
La commande `deploy-adapter` déploie un adaptateur dans un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	     | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| file           | Fichier d'adaptateur binaire (.adapter). | Oui | Non disponible |

**Exemple**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

Cette commande est basée sur le service REST [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-).

<br/>
#### Commande `show-adapter`
{: #the-show-adapter-command }
La commande `show-adapter` affiche les détails relatifs à un adaptateur. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name | Nom d'un adaptateur. | Oui | Non disponible | 
| output | Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

Cette commande est basée sur le service REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Commande `delete-adapter`
{: #the-delete-adapter-command }
La commande `delete-adapter` retire (annule le déploiement d') un adaptateur d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name    | Nom d'un adaptateur. | Oui | Non disponible | 

**Exemple**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

Cette commande est basée sur le service REST [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Groupe de commandes `adapter`
{: #the-adapter-command-group }
Le groupe de commandes `adapter` possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name | Nom d'un adaptateur. | Oui | Non disponible | 

La commande `adapter` prend en charge les éléments suivants :

| Elément          | Description |	Nombre    | 
|------------------|-------------|-------------|
| get-binary	   | Obtient les données binaires. | 0..∞ | 
| show-user-config | Affiche la configuration utilisateur. | 0..∞ | 
| set-user-config  | Spécifie la configuration utilisateur. | 0..∞ | 

<br/>
#### Commande `get-binary`
{: #the-get-binary-command }
La commande `get-binary` au sein d'un élément `<adapter>` renvoie le fichier d'adaptateur binaire. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| tofile	     | Nom du fichier de sortie. | Oui | Non disponible | 

**Exemple**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

Cette commande est basée sur le service REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Commande `show-user-config`
{: #the-show-user-config-command-1 }
La commande `show-user-config`, spécifiée au sein d'un élément `<adapter>`, affiche la configuration utilisateur de l'adaptateur. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| format	     | Indique le format de sortie. JSON ou XML. | Oui | Non disponible       | 
| output	     | Nom du fichier dans lequel stocker le résultat.   | Non  | Non applicable      | 
| outputproperty | Nom d'une propriété Ant dans laquelle stocker le résultat.  | Non | Non applicable |

**Exemple**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

Cette commande est basée sur le service REST [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-).

<br/>
#### Commande `set-user-config`
{: #the-set-user-config-command-1 }
La commande `set-user-config`, spécifiée au sein d'un élément `<adapter>`, spécifie la configuration utilisateur de l'adaptateur. Elle possède les attributs suivants permettant de définir l'ensemble de la configuration :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| file Nom du fichier JSON ou XML contenant la nouvelle configuration. | Oui | Non disponible | 

La commande possède les attributs suivants permettant de définir une propriété dans la configuration.

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| property | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. | Oui | Non disponible | 
| value | Valeur de la propriété. | Oui | Non disponible | 

**Exemples**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

Cette commande est basée sur le service REST [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc).

### Commandes pour applications
{: #commands-for-apps }
Lorsque vous appelez la tâche Ant **mfpadm**, vous pouvez inclure différentes commandes pour applications.

#### Commande `list-apps`
{: #the-list-apps-command }
La commande `list-apps` renvoie la liste des applications déployées dans un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui Non disponible | 
| output | Nom du fichier de sortie. | Non	Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<list-apps runtime="mfp"/>
```

Cette commande est basée sur le service REST [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

<br/>
#### Commande `deploy-app`
{: #the-deploy-app-command }
La commande `deploy-app` déploie une version d'application dans un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| file | Descripteur d'application, fichier JSON. | Oui | Non disponible | 

**Exemple**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

Cette commande est basée sur le service REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

<br/>
#### Commande `show-app`
{: #the-show-app-command }
La commande `show-app` renvoie la liste des versions d'application déployées dans un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name | Nom d'une application. | Oui | Non disponible | 
| output | Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

Cette commande est basée sur le service REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

<br/>
#### Commande `delete-app`
{: #the-delete-app-command }
La commande `delete-app` retire (annule le déploiement d') une application, avec toutes ses versions d'application, pour tous les environnements pour lesquels elle a été déployée, à partir d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name | Nom d'une application. | Oui | Non disponible | 

**Exemple**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

Cette commande est basée sur le service REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Commande `show-app-version`
{: #the-show-app-version-command }
La commande `show-app-version` affiche les détails relatifs à une version d'application dans un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name	Nom de l'application. | Oui | Non disponible | 
| environment	Plateforme mobile. | Oui | Non disponible | 
| version	Numéro de version de l'application. | Oui | Non disponible | 

**Exemple**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Cette commande est basée sur le service REST [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

<br/>
#### Commande `delete-app-version`
{: #the-delete-app-version-command }
La commande `delete-app-version` retire (annule le déploiement d') une version d'application d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name	Nom de l'application. | Oui | Non disponible | 
| environment	Plateforme mobile. | Oui | Non disponible | 
| version	Numéro de version de l'application. | Oui | Non disponible | 

**Exemple**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Cette commande est basée sur le service REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Groupe de commandes `app`
{: #the-app-command-group }
Le groupe de commandes `app` possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime	Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name	Nom de l'application. | Oui | Non disponible | 

Le groupe de commandes app prend en charge les éléments suivants :

| Elément | Description | Nombre | 
|---------|-------------|-------|
| show-license-config | Affiche la configuration de licence de jeton. | 0.. | 
| set-license-config | Spécifie la configuration de licence de jeton. | 0.. | 
| delete-license-config | Retire la configuration de licence de jeton. | 0.. | 

<br/>
#### Commande `show-license-config`
{: #the-show-license-config-command }
La commande `show-license-config` affiche la configuration de licence de jeton d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output         |	Nom d'un fichier dans lequel stocker le résultat. | Oui | Non disponible |
| outputproperty | 	Nom d'une propriété Ant dans laquelle stocker le résultat. | Oui	| Non disponible |

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

Cette commande est basée sur le service REST [Application license configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

<br/>
#### Commande `set-license-config`
{: #the-set-license-config-command }
La commande `set-license-config` spécifie la configuration de licence de jeton d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| appType | Type d'application : B2C ou B2E | Oui | Non disponible | 
| licenseType | Type d'application : APPLICATION ou ADDITIONAL_BRAND_DEPLOYMENT ou NON_PRODUCTION. | Oui | Non disponible | 

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

Cette commande est basée sur le service REST [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc).

<br/>
#### Commande `delete-license-config`
{: #the-delete-license-config-command }
La commande `delete-license-config` réinitialise la configuration de licence de jeton d'une application, autrement dit, elle rétablit son état initial.

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

Cette commande est basée sur le service REST [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

<br/>
#### Groupe de commandes `app-version`
{: #the-app-version-command-group }
Le groupe de commandes `app-version` possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| name | Nom d'une application. | Oui | Non disponible | 
| environment | Plateforme mobile. | Oui | Non disponible | 
| version | Version de l'application. | Oui | Non disponible | 

Le groupe de commandes `app-version` prend en charge les éléments suivants :

| Elément | Description | Nombre | 
|---------|-------------|-------|
| get-descriptor | Obtient le descripteur. | 0.. | 
| get-web-resources | Obtient les ressources Web. | 0.. | 
| set-web-resources | Spécifie les ressources Web. | 0.. | 
| get-authenticity-data | Obtient les données d'authenticité. | 0.. | 
| set-authenticity-data | Spécifie les données d'authenticité. | 0.. | 
| delete-authenticity-data | Supprime les données d'authenticité. | 0.. | 
| show-user-config | Affiche la configuration utilisateur. | 0.. | 
| set-user-config | Spécifie la configuration utilisateur. | 0.. | 

<br/>
#### Commande `get-descriptor`
{: #the-get-descriptor-command }
La commande `get-descriptor`, spécifiée au sein d'un élément `<app-version>`, renvoie le descripteur d'application d'une version d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output | Nom d'un fichier dans lequel stocker le résultat. | Non | Non applicable | 
| outputproperty | Nom d'une propriété Ant dans laquelle stocker le résultat. | Non | Non applicable | 

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

Cette commande est basée sur le service [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

<br/>
#### Commande `get-web-resources`
{: #the-get-web-resources-command }
La commande `get-web-resources`, spécifiée au sein d'un élément `<app-version>`, renvoie les ressources Web d'une version d'une application sous la forme d'un fichier .zip. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| tofile | 	Nom du fichier de sortie. | Oui |Non disponible | 

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

Cette commande est basée sur le service REST [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

<br/>
#### Commande `set-web-resources`
{: #the-set-web-resources-command }
La commande `set-web-resources`, spécifiée au sein d'un élément `<app-version>`, indique les ressources Web d'une version d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| file | Nom du fichier d'entrée (il doit s'agir d'un fichier .zip). | Oui |Non disponible |

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

Cette commande est basée sur le service REST [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

<br/>
#### Commande `get-authenticity-data`
{: #the-get-authenticity-data-command }
La commande `get-authenticity-data`, spécifiée au sein d'un élément `<app-version>`, renvoie les données d'authenticité d'une version d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output | 	Nom d'un fichier dans lequel stocker le résultat. | Non | Non applicable | 
| outputproperty | Nom d'une propriété Ant dans laquelle stocker le résultat. | Non | Non applicable | 

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

Cette commande est basée sur le service REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

<br/>
#### Commande `set-authenticity-data`
{: #the-set-authenticity-data-command }
La commande `set-authenticity-data`, spécifiée au sein d'un élément `<app-version>`, spécifie les données d'authenticité d'une version d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| file | Nom du fichier d'entrée :<ul><li>Fichier de données d'authenticité</li><li>ou fichier d'appareil (fichier .ipa, .apk ou .appx) à partir duquel les données d'authenticité sont extraites.</li></ul> |  Oui | Non disponible | 

**Exemples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

Cette commande est basée sur le service REST [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

<br/>
#### Commande `delete-authenticity-data`
{: #the-delete-authenticity-data-command }
La commande `delete-authenticity-data`, spécifiée au sein d'un élément `<app-version>`, supprime les données d'authenticité d'une version d'une application. Elle ne possède aucun attribut.

**Exemple**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

Cette commande est basée sur le service REST [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc).

<br/>
#### Commande `show-user-config`
{: #the-show-user-config-command-2 }
La commande `show-user-config`, spécifiée au sein d'un élément `<app-version>`, affiche la configuration utilisateur d'une version d'une application. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| format | Indique le format de sortie. JSON ou XML. | Oui | Non disponible | 
| output | Nom du fichier de sortie.	Non	Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

Cette commande est basée sur le service REST [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

<br/>
#### Commande `set-user-config`
{: #the-set-user-config-command-2 }
La commande `set-user-config`, spécifiée au sein d'un élément `<app-version>`, indique la configuration utilisateur d'une version d'une application. Elle possède les attributs suivants permettant de définir l'ensemble de la configuration :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| file | Nom du fichier JSON ou XML contenant la nouvelle configuration. | Oui | Non disponible | 

La commande `set-user-config` possède les attributs suivants permettant de définir une propriété unique dans la configuration.

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| property | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. | Oui | Non disponible | 
| value	| Valeur de la propriété. | Oui | Non disponible | 

**Exemples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### Commandes pour appareils
{: #commands-for-devices }
Lorsque vous appelez la tâche Ant **mfpadm**, vous pouvez inclure différentes commandes pour appareils.

#### Commande `list-devices`
{: #the-list-devices-command }
La commande `list-devices` renvoie la liste des appareils ayant contacté les applications d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| query	 | Nom usuel ou identificateur utilisateur à rechercher. Ce paramètre spécifie une chaîne à rechercher. Tous les appareils possédant un nom usuel ou un identificateur utilisateur contenant cette | chaîne (avec une correspondance insensible à la casse) sont renvoyés. | Non | Non applicable | 
| output | 	Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | 	Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemples**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

Cette commande est basée sur le service REST [Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-).

<br/>
#### Commande `remove-device`
{: #the-remove-device-command }
La commande `remove-device` efface l'enregistrement relatif à un appareil ayant contacté les applications d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| id | Identificateur unique d'appareil. | Oui | Non disponible | 

**Exemple**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

Cette commande est basée sur le service REST [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

<br/>
#### Groupe de commandes `device`
{: #the-device-command-group }
Le groupe de commandes `device` possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| id | Identificateur unique d'appareil. | Oui | Non disponible | 

La commande `device` prend en charge les éléments suivants :

| Elément        | Description |       Nombre |
|----------------|-------------|-------------|
| set-status | Modifie le statut. | 0..∞ | 
| set-appstatus | Modifie le statut d'une application. | 0..∞ | 

<br/>
#### Commande `set-status`
{: #the-set-status-command }
La commande `set-status` modifie le statut d'un appareil, dans la limite de la portée d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| status | Nouveau statut. | Oui | Non disponible | 

Les valeurs de statut possibles sont les suivantes :

* ACTIF
* PERDU
* VOLE
* ARRIVE A EXPIRATION
* DESACTIVE

**Exemple**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

Cette commande est basée sur le service REST [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

<br/>
#### Commande `set-appstatus`
{: #the-set-appstatus-command }
La commande `set-appstatus` modifie le statut d'un appareil concernant une application d'un environnement d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| app	| Nom d'une application. | Oui | Non disponible | 
| status | 	Nouveau statut. | Oui | Non disponible | 

Les valeurs de statut possibles sont les suivantes :

* ACTIVE
* DESACTIVE

**Exemple**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

Cette commande est basée sur le service REST [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Commandes de traitement des incidents
{: #commands-for-troubleshooting }
Vous pouvez utiliser les commandes de tâche Ant pour analyser les incidents liés à des applications Web {{ site.data.keys.mf_server }}.

#### Commande `show-info`
{: #the-show-info-command }
La commande `show-info` affiche des informations de base sur les services d'administration de {{ site.data.keys.product_adj }} pouvant être renvoyées sans accéder à aucun environnement d'exécution ni à aucune base de données. Cette commande permet de vérifier si les services d'administration de {{ site.data.keys.product_adj }} sont en cours d'exécution. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output | 	Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | 	Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-info/>
```

<br/>
#### Commande `show-versions`
{: #the-show-versions-command }
La commande `show-versions` affiche les versions {{ site.data.keys.product_adj }} des différents composants :

* **mfpadmVersion** : numéro de version {{ site.data.keys.mf_server }} exact dont est extrait le fichier **mfp-ant-deployer.jar**.
* **productVersion** : numéro de version {{ site.data.keys.mf_server }} exact dont est extrait le fichier **mfp-admin-service.war**.
* **mfpAdminVersion** : numéro de version de génération exact du fichier **mfp-admin-service.war**.

La commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output | 	Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | 	Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-versions/>
```

<br/>
#### Commande `show-diagnostics`
{: #the-show-diagnostics-command }
La commande `show-diagnostics` affiche le statut des différents composants nécessaires pour assurer le fonctionnement correct du service d'administration de {{ site.data.keys.product_adj }}, par exemple, la disponibilité de la base de données et des services secondaires. Cette commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| output | 	Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | 	Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**  

```xml
<show-diagnostics/>
```

<br/>
#### Commande `unlock`
{: #the-unlock-command }
La commande `unlock` libère le verrou général. Certaines opérations de destruction utilisent ce verrou afin d'empêcher la modification simultanée des mêmes données de configuration. Dans de rares cas, si une opération de ce type est interrompue, le verrou peut rester à l'état verrouillé, rendant toute autre opération de suppression impossible. Utilisez la commande unlock pour libérer le verrou dans ces cas-là. La commande ne possède aucun attribut.

**Exemple**  

```xml
<unlock/>
```

<br/>
#### Commande `list-runtimes`
{: #the-list-runtimes-command }
La commande `list-runtimes` renvoie la liste des environnements d'exécution déployés. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| output | Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemples**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

Cette commande est basée sur le service REST [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

<br/>
#### Commande `show-runtime`
{: #the-show-runtime-command }
La commande `show-runtime` affiche des informations sur un environnement d'exécution déployé. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| output | Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**

```xml
<show-runtime runtime="mfp"/>
```

Cette commande est basée sur le service REST [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

<br/>
#### Commande `delete-runtime`
{: #the-delete-runtime-command }
La commande `delete-runtime` supprime l'environnement d'exécution, y compris ses applications et adaptateurs, de la base de données. Vous ne pouvez supprimer un environnement d'exécution que lorsque son application Web est arrêtée. La commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime |  Nom de l'environnement d'exécution. | Oui | Non disponible |
| condition | Condition dans laquelle supprimer l'environnement d'exécution : empty ou always. **Attention :** L'utilisation de l'option always est dangereuse. | Non | Non applicable |

**Exemple**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

Cette commande est basée sur le service REST [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

<br/>
#### Commande `list-farm-members`
{: #the-list-farm-members-command }
La commande `list-farm-members` renvoie une liste de serveurs membres d'un parc de serveurs sur lesquels un environnement d'exécution donné est déployé. Elle possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| output | Nom du fichier de sortie. | Non | Non applicable | 
| outputproperty | Nom de la propriété Ant du résultat. | Non | Non applicable | 

**Exemple**

```xml
<list-farm-members runtime="mfp"/>
```

Cette commande est basée sur le service REST [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-).

<br/>
#### Commande `remove-farm-member`
{: #the-remove-farm-member-command }
La commande `remove-farm-member` retire un serveur de la liste de membres d'un parc de serveurs sur lesquels un environnement d'exécution est déployé. Utilisez cette commande si le serveur est devenu non disponible ou a été déconnecté. La commande possède les attributs suivants :

| Attribut      | Description |	Obligatoire | Par défaut |
|----------------|-------------|-------------|---------|
| runtime | Nom de l'environnement d'exécution. | Oui | Non disponible | 
| serverId | Identificateur du serveur.	 | Oui | Non applicable | 
| force | Forcer le retrait d'un membre d'un parc de serveurs même s'il est disponible et connecté. | Non | false | 

**Exemple**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

Cette commande est basée sur le service REST [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc).
