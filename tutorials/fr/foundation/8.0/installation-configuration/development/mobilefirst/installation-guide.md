---
layout: tutorial
title: Guide d'installation du poste de travail
breadcrumb_title: Guide d'installation
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Suivez ce guide d'installation afin de configurer votre poste de travail pour le développement avec {{ site.data.keys.product }}.

## Programme d'installation de DevKit
{: #devkit-installer }
Le [programme d'installation de {{ site.data.keys.mf_dev_kit }}]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) installe une base de données et un environnement d'exécution {{ site.data.keys.mf_server }} prêts à l'emploi sur la machine du développeur.  

**Prérequis :**  
Le programme d'installation requiert l'installation de Java.

1. [Installez l'environnement d'exécution Java d'Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).

2. Ajoutez une variable `JAVA_HOME` qui désigne l'environnement d'exécution Java (JRE).

    *Mac et Linux :* éditez votre fichier **~/.bash_profile** :

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows :*  
    [Suivez ce guide](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html).

### Installation
{: #installation }
Procurez-vous le programme d'installation de DevKit depuis la [page Downloads]({{site.baseurl}}/downloads/) et suivez les instructions affichées à l'écran.

![Programme d'installation de devkit](devkit-installer.png)

### Démarrage et arrêt du serveur
{: #starting-and-stopping-the-server }
Ouvrez une fenêtre de ligne de commande et accédez à l'emplacement auquel le dossier a été extrait.

*Mac et Linux :*  

* Pour démarrer le serveur : `./run.sh -bg`
* Pour arrêter le serveur : `./stop.sh`

*Windows :*  

* Pour démarrer le serveur : `./run.cmd -bg`
* Pour arrêter le serveur : `./stop.cmd`

### Accès à {{ site.data.keys.mf_console }}
{: #accessing-the-mobilefirst-operations-console }
Vous pouvez accéder à [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) comme suit :

* Depuis la ligne de commande, exécutez : `mfpdev server
console`
* Depuis un navigateur, accédez à l'adresse
[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).

![console]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
[{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) est une interface de ligne de commande qui vous permet d'enregistrer des applications sur {{ site.data.keys.mf_server }}, d'extraire et d'envoyer des applications depuis/vers {{ site.data.keys.mf_server }}, de créer des adaptateurs Java et JavaScript, de gérer plusieurs serveurs locaux et distants, de mettre à jour des applications opérationnelles à l'aide de Direct Update, etc.

**Prérequis :**  
1. NodeJS doit être installé avant {{ site.data.keys.mf_cli }}.  
 Téléchargez et installez [NodeJS v4.4.3 LTS](https://nodejs.org/en/).

 Pour vérifier l'installation, ouvrez une fenêtre de ligne de commande et exécutez `node -v`.

2. Certaines commandes d'interface de ligne de commande, comme la création, la génération et le déploiement d'adaptateurs requièrent Maven. Voir la section ci-après pour des instructions d'installation.

### Installation de l'{{ site.data.keys.mf_cli }}
{: #installation-cli }
Ouvrez un terminal et exécutez `npm install -g mfpdev-cli`.  

*Mac et Linux :* il peut être nécessaire d'exécuter la commande avec `sudo`.  
Pour en savoir plus, voir [Fixing NPM permissions](https://docs.npmjs.com/getting-started/fixing-npm-permissions).

Pour vérifier l'installation, ouvrez une fenêtre de ligne de commande et exécutez `mfpdev -v` ou `mfpdev help`.

![console](mfpdev-cli.png)

## Adaptateurs et contrôles de sécurité
{: #adapters-and-security-checks }
Les [adaptateurs]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) et les [contrôles de sécurité]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security) permettent d'introduire l'authentification et d'autres couches de sécurité pour votre application.

**Prérequis :**  
Apache Maven doit être configuré pour que vous puissiez créer des adaptateurs et des contrôles de sécurité.  

1. [Téléchargez Apache Maven .zip](https://maven.apache.org/download.cgi).
2. Ajoutez une variable `MVN_PATH` qui désigne le dossier Maven.

    *Mac et Linux :* éditez votre fichier **~/.bash_profile** :

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows :*  
    [Suivez ce guide](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/).
Vérifiez l'installation en exécutant `mvn -v`.

### Utilisation
{: #usage }
Une fois Apache Maven installé, vous pouvez créer des adaptateurs avec des commandes de la ligne de commande Maven ou dans {{ site.data.keys.mf_cli }}.  
Pour plus d'informations, reportez-vous aux [tutoriels sur les adaptateurs]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).
