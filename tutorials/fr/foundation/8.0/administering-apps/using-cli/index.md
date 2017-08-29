---
layout: tutorial
title: Administration d'applications via un terminal
breadcrumb_title: Administration à l'aide d'un terminal
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez administrer des applications {{ site.data.keys.product_adj }} via le programme **mfpadm**.

>Dans les versions du SDK {{ site.data.keys.product_full }} ultérieures à **8.0.0.0-MFPF-IF201701250919**, la prise en charge de l'authenticité des applications est mise à jour : les commandes `mfpadm` permettent de choisir une validation `dynamique` ou `statique` et de la réinitialiser.
>
Naviguez jusqu'au répertoire d'installation d'{{ site.data.keys.product_full }}, `/MobilefirstPlatformServer/shortcuts`, et exécutez les commandes `mfpadm`.
>
1.Pour passer d'un type de validation à l'autre :
```bash
	mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```  
La valeur de *TYPE* peut être `static` ou `dynamic`
>
Exemple pour android : Ici nous définissons le type de validation sur `dynamic`.
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp test android 1.0 set authenticity-validation dynamic
```
>
2.Pour réinitialiser les données à l'aide de la commande ci-desous, qui efface l'empreinte digitale de l'application :
```bash
  mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] reset authenticity
```
Exemple :
>
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp sample.com.pincodeandroid android 1.0 reset authenticity
```

#### Accéder à
{: #jump-to }

* [Comparaison avec d'autres fonctions](#comparison-with-other-facilities)
* [Prérequis](#prerequisites)

## Comparaison avec d'autres fonctions
{: #comparison-with-other-facilities }
Vous pouvez exécuter des opérations d'administration à l'aide d'{{ site.data.keys.product_full }} en utilisant les composants suivants :

* La console {{ site.data.keys.mf_console }}, qui est interactive.
* La tâche Ant mfpadm.
* Le programme **mfpadm**.
* Les services REST d'administration de {{ site.data.keys.product_adj }}.

La tâche Ant **mfpadm**, le programme mfpadm et les services REST sont utiles pour l'exécution automatisée ou sans assistance d'opérations, telles que celles présentées dans les cas d'utilisation suivants :

* Elimination d'erreurs d'opérateur dans des opérations répétitives, ou
* exploitation en dehors des heures de travail normales de l'opérateur, ou
* configuration d'un serveur de production avec les mêmes paramètres qu'un serveur de test ou de préproduction.

Le programme **mfpadm** et la tâche Ant mfpadm sont plus faciles à utiliser et fournissent une meilleure génération de rapports d'erreurs que les services REST. Comparé à la tâche Ant mfpadm, le programme mfpadm présente l'avantage d'être plus facile à intégrer lorsque l'intégration à des commandes de système d'exploitation est déjà disponible. De plus, il convient davantage pour une utilisation interactive.

## Prérequis
{: #prerequisites }
L'outil **mfpadm** est installé à l'aide du programme d'installation de {{ site.data.keys.mf_server }}. Sur cette page,  **product\_install\_dir** indique le répertoire d'installation du programme d'installation de {{ site.data.keys.mf_server }}.

La commande **mfpadm** est fournie dans le répertoire **product\_install\_dir/shortcuts/** sous la forme d'un ensemble de scripts :

* mfpadm pour UNIX / Linux
* mfpadm.bat pour Windows

Ces scripts sont prêts à être exécutés, ce qui signifie qu'ils ne nécessitent pas de variables d'environnement spécifiques. Si la variable d'environnement**JAVA_HOME** est définie, les scripts l'acceptent.  
Pour utiliser le programme **mfpadm**, placez le répertoire **product\_install\_dir/shortcuts/** dans votre variable d'environnement PATH ou faites référence à son nom de fichier absolu dans chaque appel.

Pour plus d'informations sur l'exécution du programme d'installation de {{ site.data.keys.mf_server }}, voir [Exécution d'IBM Installation Manager](../../installation-configuration/production/installation-manager/).

#### Accéder à
{: #jump-to-1 }

* [Appel du programme **mfpadm**](#calling-the-mfpadm-program)
* [Commandes de configuration générale](#commands-for-general-configuration)
* [Commandes pour adaptateurs](#commands-for-adapters)
* [Commandes pour applications](#commands-for-apps)
* [Commandes pour appareils](#commands-for-devices)
* [Commandes de traitement des incidents](#commands-for-troubleshooting)


### Appel du programme **mfpadm**
{: #calling-the-mfpadm-program }
Vous pouvez utiliser le programme **mfpadm** pour administrer des applications {{ site.data.keys.product_adj }}.

#### Syntaxe
{: #syntax }
Appelez le programme mfpadm comme suit :

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] some command
```

Le programme **mfpadm** comporte les options suivantes :

| Option	| Type | Description | Obligatoire | Par défaut |
|-----------|------|-------------|----------|---------|
| --url | 	 | URL | URL de base de l'application Web {{ site.data.keys.product_adj }} pour les services d'administration | Oui | |
| --secure	 | Booléen | Indique si les opérations présentant des risques de sécurité doivent être évitées | Non | true |
| --user	 | name | Nom d'utilisateur permettant d'accéder aux services d'administration de {{ site.data.keys.product_adj }} | Oui |  | 	 
| --passwordfile | file | Fichier contenant le mot de passe de l'utilisateur | Non |
| --timeout	     | Nombre  | Délai d'attente relatif à l'accès à l'ensemble du service REST, exprimé en secondes | Non | 	 
| --connect-timeout | Nombre | Délai d'attente relatif à l'établissement d'une connexion réseau, exprimé en secondes | Non |
| --socket-timeout  | Nombre | Délai d'attente relatif à la détection de la perte d'une connexion réseau, exprimé en secondes | Non |
| --connection-request-timeout | Nombre Délai d'attente relatif à l'obtention d'une entrée à partir d'un pool de demande de connexion, exprimé en secondes | Non |
| --lock-timeout | Nombre | Délai d'attente relatif à l'acquisition d'un verrou, exprimé en secondes | Non | 2 |
| --verbose	     | Sortie détaillée | Non	| |  

**url**  
L'URL utilise de préférence le protocole HTTPS. Par exemple, si vous utilisez des ports et des racines de contexte par défaut, utilisez l'URL suivante :

* Pour WebSphere Application Server : https://server:9443/mfpadmin
* Pour Tomcat : https://server:8443/mfpadmin

**secure**  
Par défaut, l'option `--secure` a pour valeur true. Si vous définissez la valeur `--secure=false`, les effets possibles sont les suivants :

* L'utilisateur et le mot de passe peuvent être transmis de façon non sécurisée (peut-être même via un protocole HTTP non chiffré).
* Les certificats SSL du serveur sont acceptés même s'ils sont auto-signés ou s'ils ont été créés pour un nom d'hôte différent du nom d'hôte du serveur.

**password**  
Indiquez le mot de passe dans un fichier distinct que vous transmettez via l'option `--passwordfile`. En mode interactif (voir la section Mode interactif), vous pouvez aussi spécifier le mot de passe de manière interactive. Le mot de passe constitue des informations sensibles qui doivent par conséquent être protégées. Vous devez empêcher les autres utilisateurs de l'ordinateur de connaître ce mot de passe. Pour sécuriser un mot de passe, avant de saisir ce dernier dans un fichier, retirez les droits d'accès en lecture à ce fichier pour les autres utilisateurs. Par exemple, utilisez l'une des commandes suivantes :

* Sous UNIX : `chmod 600 adminpassword.txt`
* Sous Windows : `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Pour cette raison, ne transmettez pas le mot de passe à un processus via un argument de ligne de commande. Sur un grand nombre de systèmes d'exploitation, d'autres utilisateurs peuvent inspecter les arguments de ligne de commande de vos processus.

Les appels du programme mfpadm contiennent une commande. Les commandes suivantes sont prises en charge :

| Commande                           | Description |
|-----------------------------------|-------------|
| show info	| Affiche des informations de configuration et d'utilisateur. |
| show global-config | Affiche des informations de configuration globale. |
| show diagnostics | Affiche des informations de diagnostic. |
| show versions	| Affiche des informations de version. |
| unlock | Libère le verrou général. |
| list runtimes [--in-database] | Répertorie les environnements d'exécution. |
| show runtime [runtime-name] | Affiche des informations sur un environnement d'exécution. |
| delete runtime [runtime-name] condition | Supprime un environnement d'exécution. |
| show user-config [runtime-name] | Affiche la configuration utilisateur d'un environnement d'exécution. |
| set user-config [runtime-name] file | Spécifie la configuration utilisateur d'un environnement d'exécution. |
| set user-config [runtime-name] property = value | Spécifie une propriété dans la configuration utilisateur d'un environnement d'exécution. |
| show confidential-clients [runtime-name] | Affiche la configuration des clients confidentiels d'un environnement d'exécution. |
| set confidential-clients [runtime-name] file | Spécifie la configuration des clients confidentiels d'un environnement d'exécution. |
| set confidential-clients-rule [runtime-name] id display-name secret allowed-scope | Spécifie une règle pour la configuration des clients confidentiels d'un environnement d'exécution. |
| list adapters [runtime-name] | Répertorie les adaptateurs. |
| deploy adapter [runtime-name] property = value | Déploie un adaptateur.|
| show adapter [runtime-name] adapter-name | Affiche des informations sur un adaptateur.|
| delete adapter [runtime-name] adapter-name | Supprime un adaptateur.|
| adapter [runtime-name] adapter-name get binary [> tofile]	| Obtient les données binaires d'un adaptateur.|
| list apps [runtime-name] | Répertorie les applications.|
| deploy app [runtime-name] file | Déploie une application.|
| show app [runtime-name] app-name | Affiche des informations sur une application.|
| delete app [runtime-name] app-name | Supprime une application. |
| show app version [runtime-name] app-name environment version | Affiche des informations sur une version d'application. |
| delete app version [runtime-name] app-name environment version | Supprime une version d'une application. |
| app [runtime-name] app-name show license-config | Affiche la configuration de licence de jeton d'une application. |
| app [runtime-name] app-name set license-config app-type license-type | Spécifie la configuration de licence de jeton pour une application. |
| app [runtime-name] app-name delete license-config | Retire la configuration de licence de jeton pour une application. |
| app version [runtime-name] app-name environment version get descriptor [> tofile]	| Obtient le descripteur d'une version d'application. |
| app version [runtime-name] app-name environment version get web-resources [> tofile] | Obtient les ressources Web d'une version d'application. |
| app version [runtime-name] app-name environment version set web-resources file | Spécifie les ressources Web d'une version d'application. |
| app version [runtime-name] app-name environment version get authenticity-data [> tofile] | Obtient les données d'authenticité d'une version d'application. |
| app version [runtime-name] app-name environment version set authenticity-data [file] | Spécifie les données d'authenticité d'une version d'application. |
| app version [runtime-name] app-name environment version delete authenticity-data | Supprime les données d'authenticité d'une version d'application. |
| app version [runtime-name] app-name environment version show user-config | Affiche la configuration utilisateur d'une version d'application. |
| app version [runtime-name] app-name environment version set user-config file | Spécifie la configuration utilisateur d'une version d'application. |
| app version [runtime-name] app-name environment version set user-config property = value | Spécifie une propriété dans la configuration utilisateur d'une version d'application. |
| list devices [runtime-name][--query query] | Répertorie les appareils. |
| remove device [runtime-name] id | Retire un appareil. |
| device [runtime-name] id set status new-status | Modifie le statut d'un appareil. |
| device [runtime-name] id set appstatus app-name new-status | Modifie le statu d'un appareil pour une application. |
| list farm-members [runtime-name] | Répertorie les serveurs membres du parc de serveurs. |
| remove farm-member [runtime-name] server-id | Retire un serveur de la liste des membres du parc de serveurs. |

#### Mode interactif
{: #interactive-mode }
Vous pouvez aussi appeler le programme **mfpadm** sans aucune commande en ligne de commande. Vous pouvez ensuite entrer des commandes de manière interactive, à raison d'une par ligne.
La commande `exit`, ou une marque de fin de fichier dans une entrée standard (**Ctrl-D** sur les terminaux UNIX), permet de terminer le programme mfpadm.

Des commandes `Help` sont également disponibles dans ce mode. Exemple :

* help
* help show versions
* help device
* help device set status

#### Historique des commandes en mode interactif
{: #command-history-in-interactive-mode }
Sur certains systèmes d'exploitation, la commande mfpadm interactive mémorise l'historique des commandes. Dans l'historique des commandes, vous pouvez sélectionner une commande précédente à l'aide des touches de déplacement vers le haut et vers le bas, puis l'éditer et l'exécuter.

**Sous Linux**  
L'historique des commandes est activé dans des fenêtres d'émulation de terminal si le module rlwrap est installé et figure dans PATH. Pour installer le module rlwrap :

* Sous Red Hat Linux : `sudo yum install rlwrap`
* Sous SUSE Linux : `sudo zypper install rlwrap`
* Sous Ubuntu : `sudo apt-get install rlwrap`

**Sous OS X**  
L'historique des commandes est activé dans le programme terminal si le module rlwrap est installé et figure dans PATH. Pour installer le module rlwrap :

1. Installez MacPorts à l'aide du programme d'installation disponible sur [www.macports.org](http://www.macports.org).
2. Exécutez la commande `sudo /opt/local/bin/port install rlwrap`
3. Pour rendre le programme rlwrap disponible dans PATH, utilisez la commande suivante dans un shell compatible Bourne : `PATH=/opt/local/bin:$PATH`

**Sous Windows**  
L'historique des commandes est activé dans des fenêtres console cmd.exe.

Dans les environnements où le programme rlwrap ne fonctionne pas ou n'est pas requis, vous pouvez désactiver son utilisation via l'option `--no-readline`.

#### Fichier de configuration
{: #the-configuration-file }
Vous pouvez également stocker les options dans un fichier de configuration au lieu de les transmettre sur la ligne de commande à chaque appel. Lorsqu'un fichier de configuration est présent et que l'option –configfile=file est spécifiée, vous pouvez omettre les options suivantes :

* --url=URL
* --secure=boolean
* --user=name
* --passwordfile=file
* --timeout=seconds
* --connect-timeout=seconds
* --socket-timeout=seconds
* --connection-request-timeout=seconds
* --lock-timeout=seconds
* runtime-name

Utilisez les commandes suivantes pour stocker ces valeurs dans le fichier de configuration :

| Commande | Commentaire |
|---------|---------|
| mfpadm [--configfile=file] config url URL | |
| mfpadm [--configfile=file] config secure boolean | |
| mfpadm [--configfile=file] config user name | |
| mfpadm [--configfile=file] config password | Vous invite à entrer le mot de passe. |
| mfpadm [--configfile=file] config timeout seconds | |
| mfpadm [--configfile=file] config connect-timeout seconds | |
| mfpadm [--configfile=file] config socket-timeout seconds | |
| mfpadm [--configfile=file] config connection-request-timeout seconds | |
| mfpadm [--configfile=file] config lock-timeout seconds | |
| mfpadm [--configfile=file] config runtime runtime-name | |

Utilisez la commande suivante pour répertorier les valeurs stockées dans le fichier de configuration : `mfpadm [--configfile=file] config`

Le fichier de configuration est un fichier texte, dans le codage de l'environnement local en cours et dans la syntaxe Java **.properties**. Les fichiers de configuration par défaut sont les suivants :

* UNIX : **${HOME}/.mfpadm.config**
* Windows : **{{ site.data.keys.prod_server_data_dir_win }}\mfpadm.config**

**Remarque :** Lorsque vous ne spécifiez pas une option `--configfile`, le fichier de configuration par défaut est utilisé uniquement en mode interactif et dans des commandes config. Pour une utilisation non interactive des autres commandes, vous devez spécifier explicitement le fichier de configuration si vous souhaitez en utiliser un.

> **Important :** Le mot de passe est stocké dans un format brouillé afin qu'il ne puisse pas être entrevu. Toutefois, ce brouillage ne procure aucune sécurité.

#### Options génériques
{: #generic-options }
Les options génériques habituelles sont les suivantes :

| Option	| Description |
|-----------|-------------|
| --help	| Affiche de l'aide sur la syntaxe |
| --version	| Affiche la version |

#### Format XML
{: #xml-format }
Les commandes qui reçoivent une réponse XML du serveur vérifient que cette réponse est conforme au schéma donné. Vous pouvez désactiver cette vérification en spécifiant `--xmlvalidation=none`.

#### Jeu de caractères de sortie
{: #output-character-set }
Le résultat normal généré par le programme mfpadm est codé à l'aide du format de codage de l'environnement local en cours. Sous Windows, ce format de codage est appelé "page de codes ANSI". Les effets sont les suivants :

* Les caractères non compris dans ce jeu de caractères sont convertis en points d'interrogation lorsqu'ils sont affichés.
* Lorsque le résultat est dirigé vers une fenêtre d'invite de commande Windows (cmd.exe), les caractères non ASCII ne s'affichent pas correctement car ce type de fenêtre considère que les caractères sont codés dans la "page de codes OEM".

Pour contourner cette limitation :

* Sur les systèmes d'exploitation autres que Windows, utilisez un environnement local dont le codage est UTF-8. Ce format est l'environnement local par défaut sous Red Hat Linux et OS X. De nombreux autres systèmes d'exploitation ont un environnement local `en_US.UTF-8`.
* Ou utilisez la tâche Ant mfpadm avec l'attribut `output="some file name"` pour rediriger le résultat d'une commande vers un fichier.

### Commandes de configuration générale
{: #commands-for-general-configuration }
Lorsque vous appelez le programme **mfpadm**, vous pouvez inclure différentes commandes qui accèdent à la configuration globale du serveur IBM {{ site.data.keys.mf_server }} ou d'un module d'exécution.

#### Commande `show global-config`
{: #the-show-global-config-command }
La commande `show global-config` affiche la configuration globale.

Syntaxe : `show global-config`

Elle accepte les options suivantes :

| Argument | Description |
|----------|-------------|
| --xml    | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**  

```bash
show global-config
```

Cette commande est basée sur le service REST [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-).

<br/>
#### Commande `show user-config`
{: #the-show-user-config-command }
La commande `show user-config` affiche la configuration utilisateur d'un module d'exécution.

Syntaxe : `show user-config [--xml][runtime-name]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `show user-config` accepte les options suivantes après le verbe.

| Argument | Description | Obligatoire | Par défaut |
|----------|-------------|----------|---------|
| --xml | Génère une sortie au format XML à la place du format JSON. | Non | Sortie standard |

**Exemple**  

```bash
show user-config mfp
```

Cette commande est basée sur le service REST [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Commande `set user-config`
{: #the-set-user-config-command }
La commande `set user-config` spécifie la configuration utilisateur d'un environnement d'exécution ou une propriété de cette configuration.

Syntaxe pour l'ensemble de la configuration : `set user-config [runtime-name] file`

Elle accepte les arguments suivants :

| Attribut | Description |
|-----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| file | Nom du fichier JSON ou XML contenant la nouvelle configuration. |

Syntaxe pour une propriété : `set user-config [runtime-name] property = value`

La commande `set user-config` accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| property | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. |
| value | Valeur de la propriété. |

**Exemples**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

Cette commande est basée sur le service REST [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-).

<br/>
#### Commande `show confidential-clients`
{: #the-show-confidential-clients-command }
La commande `show confidential-clients` affiche la configuration des clients confidentiels pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients).

Syntaxe : `show confidential-clients [--xml][runtime-name]`

Elle accepte les arguments suivants :

| Attribut | Description |
|-----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `show confidential-clients` accepte les options suivantes après le verbe.

| Argument | Description | Obligatoire | Par défaut |
|----------|-------------|----------|---------|
| --xml | Génère une sortie au format XML à la place du format JSON. | Non | Sortie standard |

**Exemple**

```bash
show confidential-clients --xml mfp
```

Cette commande est basée sur le service REST [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-).

<br/>
#### Commande `set confidential-clients`
{: #the-set-confidential-clients-command }
La commande `set confidential-clients` spécifie la configuration des clients confidentiels pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients).

Syntaxe : `set confidential-clients [runtime-name] file`

Elle accepte les arguments suivants :

| Attribut | Description |
|-----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| file Nom du fichier JSON ou XML contenant la nouvelle configuration. |

**Exemple**

```bash
set confidential-clients mfp clients.xml
```

Cette commande est basée sur le service REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

<br/>
#### Commande `set confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
La commande `set confidential-clients-rule` spécifie une règle dans la configuration des clients confidentielles pouvant accéder à un environnement d'exécution. Pour plus d'informations sur les clients confidentiels, voir [Clients confidentiels](../../authentication-and-security/confidential-clients).

Syntaxe : `set confidential-clients-rule [runtime-name] id displayName secret allowedScope`

Elle accepte les arguments suivants :

| Attribut	| Description |
|-----------|-------------|
| runtime | Nom de l'environnement d'exécution. |
| id | Identificateur de la règle. |
| displayName | Nom d'affichage de la règle. |
| secret | Secret de la règle. |
| allowedScope | Portée de la règle. Liste de jetons séparés par des espaces. Utilisez des guillemets pour transmettre une liste composée d'au moins deux jetons. |

**Exemple**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

Cette commande est basée sur le service REST [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-).

### Commandes pour adaptateurs
{: #commands-for-adapters }
Lorsque vous appelez le programme **mfpadm**, vous pouvez inclure différentes commandes pour adaptateurs.

### Commande `list adapters`
{: #the-list-adapters-command }
La commande `list adapters` renvoie la liste des adaptateurs déployés pour un environnement d'exécution.

Syntaxe : `list adapters [runtime-name]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `list adapters` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**  

```xml
list adapters mfp
```

Cette commande est basée sur le service REST [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-).

<br/>
#### Commande `deploy adapter`
{: #the-deploy-adapter-command }
La commande `deploy adapter` déploie un adaptateur dans un environnement d'exécution.

Syntaxe : `deploy adapter [runtime-name] file`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| file | Fichier d'adaptateur binaire (.adapter). |

**Exemple**

```bash
deploy adapter mfp MyAdapter.adapter
```

Cette commande est basée sur le service REST [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-).

<br/>
#### Commande `show adapter`
{: #the-show-adapter-command }
La commande `show adapter` affiche les détails relatifs à un adaptateur.

Syntaxe : `show adapter [runtime-name] adapter-name`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| adapter-name | Nom d'un adaptateur |

La commande `show adapter` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show adapter mfp MyAdapter
```

Cette commande est basée sur le service REST [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Commande `delete adapter`
{: #the-delete-adapter-command }
La commande `delete adapter` retire (annule le déploiement d') un adaptateur d'un environnement d'exécution.

Syntaxe : `delete adapter [runtime-name] adapter-name`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| adapter-name | Nom d'un adaptateur. |

**Exemple**

```bash
delete adapter mfp MyAdapter
```

Cette commande est basée sur le service REST [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-).

<br/>
#### Préfixe de la commande `adapter`
{: #the-adapter-command-prefix }
Le préfixe de la commande `adapter` accepte les arguments suivants avant le verbe.

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| adapter-name | Nom d'un adaptateur. |

<br/>
#### Commande `adapter get binary`
{: #the-adapter-get-binary-command }
La commande `adapter get binary` renvoie le fichier d'adaptateur binaire.

Syntaxe : `adapter [runtime-name] adapter-name get binary [> tofile]`

Elle accepte les options suivantes après le verbe.

| Option | Description | Obligatoire | Par défaut |
|--------|-------------|----------|---------|
| > tofile | Nom du fichier de sortie. | Non | Sortie standard |

**Exemple**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

Cette commande est basée sur le service REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

<br/>
#### Commande `adapter show user-config`
{: #the-adapter-show-user-config-command }
La commande `adapter show user-config` affiche la configuration utilisateur de l'adaptateur.

Syntaxe : `adapter [runtime-name] adapter-name show user-config [--xml]`

Elle accepte les options suivantes après le verbe.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie au format XML à la place du format JSON. |

**Exemple**

```bash
adapter mfp MyAdapter show user-config
```

Cette commande est basée sur le service REST [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-).

<br/>
#### Commande `adapter set user-config`
{: #the-adapter-set-user-config-command }
La commande `adapter set user-config` spécifie la configuration utilisateur de l'adaptateur ou une propriété de cette configuration.

Syntaxe pour l'ensemble de la configuration : `adapter [runtime-name] adapter-name set user-config file`

Elle accepte les arguments suivants après le verbe.

| Option | Description |
|--------|-------------|
| file | Nom du fichier JSON ou XML contenant la nouvelle configuration. |

Syntaxe pour une propriété : `adapter [runtime-name] adapter-name set user-config property = value`

Elle accepte les arguments suivants après le verbe.

| Option | Description |
|--------|-------------|
| property | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. |
| value | Valeur de la propriété. |

**Exemples**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

Cette commande est basée sur le service REST [Adapter configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc).

### Commandes pour applications
{: #commands-for-apps }
Lorsque vous appelez le programme **mfpadm**, vous pouvez inclure différentes commandes pour applications.

#### Commande `list apps`
{: #the-list-apps-command }
La commande `list apps` renvoie la liste des applications déployées dans un environnement d'exécution.

Syntaxe : `list apps [runtime-name]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `list apps` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
list apps mfp
```

Cette commande est basée sur le service REST [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

#### Commande `deploy app`
{: #the-deploy-app-command }
La commande `deploy app` déploie une version d'application dans un environnement d'exécution.

Syntaxe : `deploy app [runtime-name] file`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| file | Descripteur d'application, fichier JSON. |

**Exemple**

```bash
deploy app mfp MyApp/application-descriptor.json
```

Cette commande est basée sur le service REST [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

#### Commande `show app`
{: #the-show-app-command }
La commande `show app` affiche les détails relatifs à une application dans un environnement d'exécution, notamment ses environnements et ses versions.

Syntaxe : `show app [runtime-name] app-name`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |

La commande `show app` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml	 | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show app mfp MyApp
```

Cette commande est basée sur le service REST [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

#### Commande `delete app`
{: #the-delete-app-command }
La commande `delete app` retire (annule le déploiement d') une application, de tous les environnements et de toutes les versions, d'un environnement d'exécution.

Syntaxe : `delete app [runtime-name] app-name`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |

**Exemple**

```bash
delete app mfp MyApp
```

Cette commande est basée sur le service REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Commande `show app version`
{: #the-show-app-version-command }
La commande `show app version` affiche les détails relatifs à une version d'application dans un environnement d'exécution.

Syntaxe : `show app version [runtime-name] app-name environment version`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |
| environment | Plateforme mobile. |
| version | Version de l'application. |

La commande `show app version` accepte les options suivantes après l'objet.

| Argument | Description |
| ---------|-------------|
| -- xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show app version mfp MyApp iPhone 1.1
```

Cette commande est basée sur le service REST [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

#### Commande `delete app version`
{: #the-delete-app-version-command }
La commande `delete app version` retire (annule le déploiement d') une version d'application d'un environnement d'exécution.

Syntaxe : `delete app version [runtime-name] app-name environment version`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |
| environment | Plateforme mobile. |
| version | Version de l'application. |

**Exemple**

```bash
delete app version mfp MyApp iPhone 1.1
```

Cette commande est basée sur le service REST [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Préfixe de la commande `app`
{: #the-app-command-prefix }
Le préfixe de la commande `app` accepte les arguments suivants avant le verbe.

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |

#### Commande `app show license-config`
{: #the-app-show-license-config-command }
La commande `app show license-config` affiche la configuration de licence de jeton d'une application.

Syntaxe : `app [runtime-name] app-name show license-config`

Elle accepte les options suivantes après l'objet :

| Argument | Description |
|----------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
app mfp MyApp show license-config
```

Cette commande est basée sur le service REST [Application license configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

#### Commande `app set license-config`
{: #the-app-set-license-config-command }
La commande `app set license-config` spécifie la configuration de licence de jeton d'une application.

Syntaxe : `app [runtime-name] app-name set license-config app-type license-type`

Elle accepte les arguments suivants après le verbe.

| Argument | Description |
|----------|-------------|
| appType | Type d'application : B2C ou B2E. |
| licenseType | Type d'application : APPLICATION ou ADDITIONAL_BRAND_DEPLOYMENT ou NON_PRODUCTION. |

**Exemple**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

Cette commande est basée sur le service REST [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc).

#### Commande `app delete license-config`
{: #the-app-delete-license-config-command }
La commande `app delete license-config` réinitialise la configuration de licence de jeton d'une application, autrement dit, elle rétablit son état initial.

Syntaxe : `app [runtime-name] app-name delete license-config`

**Exemple**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

Cette commande est basée sur le service REST [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

#### Préfixe de la commande `app version`
{: #the-app-version-command-prefix }
Le préfixe de la commande `app version` accepte les arguments suivants avant le verbe.

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| app-name | Nom d'une application. |
| environment | Plateforme mobile |
| version | Version de l'application |

#### Commande `app version get descriptor`
{: #the-app-version-get-descriptor-command }
La commande `app version get descriptor` renvoie le descripteur d'application d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version get descriptor [> tofile]`

Elle accepte les arguments suivants après le verbe.

| Argument | Description | Obligatoire | Par défaut |
|----------|-------------|----------|---------|
| > tofile | Nom du fichier de sortie. | Non | Sortie standard |

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

Cette commande est basée sur le service REST [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

#### Commande `app version get web-resources`
{: #the-app-version-get-web-resources-command }
La commande `app version get web-resources` renvoie les ressources Web d'une version d'une application sous la forme d'un fichier .zip.

Syntaxe : `app version [runtime-name] app-name environment version get web-resources [> tofile]`

Elle accepte les arguments suivants après le verbe.

| Argument | Description | Obligatoire | Par défaut |
|----------|-------------|----------|---------|
| > tofile | Nom du fichier de sortie. | Non | Sortie standard |

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

Cette commande est basée sur le service REST [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

#### Commande `app version set web-resources`
{: #the-app-version-set-web-resources-command }
La commande `app version set web-resources` spécifie les ressources Web d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version set web-resources file`

Elle accepte les arguments suivants après le verbe.

| Argument | Description |
| file | Nom du fichier d'entrée (il doit s'agit d'un fichier .zip). |

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

Cette commande est basée sur le service REST [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

#### Commande `app version get authenticity-data`
{: #the-app-version-get-authenticity-data-command }
La commande `app version get authenticity-data` renvoie les données d'authenticité d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version get authenticity-data [> tofile]`

Elle accepte les arguments suivants après le verbe.

| Argument | Description | Obligatoire | Par défaut |
| > tofile | Nom du fichier de sortie. | Non | Sortie standard |

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

Cette commande est basée sur le service REST [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc).

#### Commande `app version set authenticity-data`
{: #the-app-version-set-authenticity-data-command }
La commande `app version set authenticity-data` spécifie les données d'authenticité d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version set authenticity-data file`

Elle accepte les arguments suivants après le verbe.

| Argument | Description |
|----------|-------------|
| file | Nom du fichier d'entrée :<ul><li>Fichier .authenticity_data</li><li>ou fichier d'appareil (.ipa, .apk ou .appx) à partir duquel les données d'authenticité sont extraites.</li></ul>|

**Exemples**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

Cette commande est basée sur le service REST [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

#### Commande `app version delete authenticity-data`
{: #the-app-version-delete-authenticity-data-command }
La commande `app version delete authenticity-data` supprime les données d'authenticité d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version delete authenticity-data`

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

Cette commande est basée sur le service REST [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc).

#### Commande `app version show user-config`
{: #the-app-version-show-user-config-command }
La commande `app version show user-config` affiche la configuration utilisateur d'une version d'une application.

Syntaxe : `app version [runtime-name] app-name environment version show user-config [--xml]`

Elle accepte les options suivantes après le verbe.

| Argument | Description | Obligatoire | Par défaut |
|----------|-------------|----------|---------|
| [--xml] | Génère une sortie au format XML à la place du format JSON. | Non | Sortie standard |

**Exemple**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

Cette commande est basée sur le service REST [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

### Commande `app version set user-config`
{: #the-app-version-set-user-config-command }
La commande `app version set user-config` spécifie la configuration utilisateur d'une version d'une application ou une propriété de cette configuration.

Syntaxe pour l'ensemble de la configuration : `app version [runtime-name] app-name environment version set user-config file`

Elle accepte les arguments suivants après le verbe.

| Argument | Description |
|----------|-------------|
| file | Nom du fichier JSON ou XML contenant la nouvelle configuration. |

Syntaxe pour une propriété : `app version [runtime-name] app-name environment version set user-config property = value`

La commande `app version set user-config` accepte les arguments suivants après le verbe.

| Argument | Description |
|----------|-------------|
| property | Nom de la propriété JSON. Pour une propriété imbriquée, utilisez la syntaxe prop1.prop2.....propN. Pour un élément de tableau JSON, utilisez l'index à la place d'un nom de propriété. |
| value | Valeur de la propriété. |

**Exemples**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

Cette commande est basée sur le service REST [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc).

### Commandes pour appareils
{: #commands-for-devices }
Lorsque vous appelez le programme **mfpadm**, vous pouvez inclure différentes commandes pour appareils.

#### Commande `list devices`
{: #the-list-devices-command }
La commande `list devices` renvoie la liste des appareils ayant contacté les applications d'un environnement d'exécution.

Syntaxe : `list devices [runtime-name][--query query]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| query | Nom usuel ou identificateur utilisateur à rechercher. Ce paramètre spécifie une chaîne à rechercher. Tous les appareils possédant un nom usuel ou un identificateur utilisateur contenant cette chaîne (avec une correspondance insensible à la casse) sont renvoyés. |

La commande `list devices` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemples**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

Cette commande est basée sur le service [Devices (GET) REST](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-).

#### Commande `remove device`
{: #the-remove-device-command }
La commande `remove device` efface l'enregistrement relatif à un appareil ayant contacté les applications d'un environnement d'exécution.

Syntaxe : `remove device [runtime-name] id`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| id | Identificateur unique d'appareil. |

**Exemple**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

Cette commande est basée sur le service REST [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

#### Préfixe de la commande `device`
{: #the-device-command-prefix }
Le préfixe de la commande `device` accepte les arguments suivants avant le verbe.

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| id | Identificateur unique d'appareil. |

#### Commande `device set status`
{: #the-device-set-status-command }
La commande `device set status` modifie le statut d'un appareil, dans la limite de la portée d'un environnement d'exécution.

Syntaxe : `device [runtime-name] id set status new-status`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| new-status | Nouveau statut. |

Les valeurs de statut possibles sont les suivantes :

* ACTIF
* PERDU
* VOLE
* ARRIVE A EXPIRATION
* DESACTIVE

**Exemple**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

Cette commande est basée sur le service REST [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

#### Commande `device set appstatus`
{: #the-device-set-appstatus-command }
La commande `device set appstatus` modifie le statut d'un appareil concernant une application d'un environnement d'exécution.

Syntaxe : `device [runtime-name] id set appstatus app-name new-status`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| app-name | Nom d'une application. |
| new-status | Nouveau statut. |

Les valeurs de statut possibles sont les suivantes :

* ACTIVE
* DESACTIVE


**Exemple**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

Cette commande est basée sur le service REST [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Commandes de traitement des incidents
{: #commands-for-troubleshooting }
Lorsque vous appelez le programme **mfpadm**, vous pouvez inclure différentes commandes de traitement des incidents.

#### Commande `show info`
{: #the-show-info-command }
La commande `show info` affiche des informations de base sur les services d'administration de {{ site.data.keys.product_adj }} pouvant être renvoyées sans accéder à aucun environnement d'exécution ni à aucune base de données. Cette commande permet de vérifier si les services d'administration de {{ site.data.keys.product_adj }} sont en cours d'exécution.

Syntaxe : `show info`

Elle accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show info
```

#### Commande `show versions`
{: #the-show-versions-command }
La commande `show versions` affiche les versions {{ site.data.keys.product_adj }} de différents composants :

* **mfpadmVersion** : numéro de version {{ site.data.keys.mf_server }} exact dont est extrait le fichier **mfp-ant-deployer.jar**.
* **productVersion** : numéro de version {{ site.data.keys.mf_server }} exact dont est extrait le fichier **mfp-admin-service.war**.
* **mfpAdminVersion** : numéro de version de génération exact du fichier **mfp-admin-service.war**.

Syntaxe : `show versions`

Elle accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show versions
```

#### Commande `show diagnostics`
{: #the-show-diagnostics-command }
La commande `show diagnostics` affiche le statut des différents composants nécessaires pour assurer le fonctionnement correct du service d'administration de {{ site.data.keys.product_adj }}, par exemple, la disponibilité de la base de données et des services secondaires.

Syntaxe : `show diagnostics`

Elle accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
show diagnostics
```

#### Commande `unlock`
{: #the-unlock-command }
La commande `unlock` libère le verrou général. Certaines opérations de destruction utilisent ce verrou afin d'empêcher la modification simultanée des mêmes données de configuration. Dans de rares cas, si une opération de ce type est interrompue, le verrou peut rester à l'état verrouillé, rendant toute autre opération de suppression impossible. Utilisez la commande unlock pour libérer le verrou dans ces cas-là.

**Exemple**

```bash
unlock
```

#### Commande `list runtimes`
{: #the-list-runtimes-command }
La commande `list runtimes` renvoie la liste des environnements d'exécution déployés.

Syntaxe : `list runtimes [--in-database]`

Elle accepte les options suivantes :

| Option | Description |
|--------|-------------|
| --in-database	| Indique si la recherche doit porter sur la base de données et non sur les beans gérés. |
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemples**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

Cette commande est basée sur le service REST [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

#### Commande `show runtime`
{: #the-show-runtime-command }
La commande `show runtime` affiche des informations sur un environnement d'exécution déployé spécifique.

Syntaxe : `show runtime [runtime-name]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `show runtime` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

Cette commande est basée sur le service REST [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

**Exemple**

```bash
show runtime mfp
```

#### Commande `delete runtime`
{: #the-delete-runtime-command }
La commande `delete runtime` supprime un environnement d'exécution, y compris ses applications et adaptateurs, de la base de données. Vous ne pouvez supprimer un environnement d'exécution que lorsque son application Web est arrêtée.

Syntaxe : `delete runtime [runtime-name] condition`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| condition | Condition dans laquelle supprimer l'environnement d'exécution : empty ou always. **Attention :** L'utilisation de l'option always est dangereuse. |

**Exemple**

```bash
delete runtime mfp empty
```

Cette commande est basée sur le service REST [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

#### Commande `list farm-members`
{: #the-list-farm-members-command }
La commande `list farm-members` renvoie une liste de serveurs membres d'un parc de serveurs sur lesquels un environnement d'exécution donné est déployé.

Syntaxe : `list farm-members [runtime-name]`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |

La commande `list farm-members` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --xml | Génère une sortie XML à la place d'une sortie tabulaire. |

**Exemple**

```bash
list farm-members mfp
```

Cette commande est basée sur le service REST [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-).

#### Commande `remove farm-member`
{: #the-remove-farm-member-command }
La commande `remove farm-member` retire un serveur de la liste de membres d'un parc de serveurs sur lesquels l'environnement d'exécution spécifié est déployé. Utilisez cette commande si le serveur est devenu non disponible ou a été déconnecté.

Syntaxe : `remove farm-member [runtime-name] server-id`

Elle accepte les arguments suivants :

| Argument | Description |
|----------|-------------|
| runtime-name | Nom de l'environnement d'exécution. |
| server-id | Identificateur du serveur. |

La commande `remove farm-member` accepte les options suivantes après l'objet.

| Option | Description |
|--------|-------------|
| --force | Forcer le retrait d'un membre d'un parc de serveurs même s'il est disponible et connecté. |

**Exemple**

```bash
remove farm-member mfp srvlx15
```

Cette commande est basée sur le service REST [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc).
