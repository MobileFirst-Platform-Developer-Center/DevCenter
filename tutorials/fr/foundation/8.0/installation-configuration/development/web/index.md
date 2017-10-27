---
layout: tutorial
title: Configuration de l'environnement de développement Web
breadcrumb_title: Web
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Il est aussi facile de développer et de tester des applications Web que de prévisualiser un fichier HTML local dans le navigateur Web de votre choix.  
Les développeurs peuvent utiliser l'environnement de développement intégré de leur choix et toute infrastructure adaptée à leurs besoins.

Toutefois, un problème peut survenir lors du développement d'applications Web. Les applications Web peuvent rencontrer des erreurs en raison de la violation de la [règle same-origin](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy). Il s'agit d'une restriction imposée aux navigateurs Web. Par exemple, si une application est hébergée dans le domaine **example.com**, elle ne peut pas accéder à un contenu disponible sur un autre serveur ou sur {{ site.data.keys.mf_server }}.

[Les applications Web devant utiliser le logiciel SDK Web de {{ site.data.keys.product }}](../../../application-development/sdk/web) doivent être gérées dans une topologie de support, par exemple à l'aide d'un proxy inverse afin de rediriger les demandes en interne vers le serveur approprié tout en conservant la même origine unique.

Vous pouvez satisfaire les exigences dictées par la règle en appliquant l'une des méthodes suivantes :

- En traitant les ressources d'application Web depuis le serveur d'applications WebSphere de profil complet ou Liberty qui héberge {{ site.data.keys.mf_server }}.
- En utilisant Node.js comme proxy pour rediriger les demandes d'application vers {{ site.data.keys.mf_server }}.

#### Accéder à
{: #jump-to }
- [Prérequis](#prerequisites)
- [Utilisation du profil Liberty de WebSphere pour traiter les ressources d'application Web ](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [Utilisation de Node.js](#using-nodejs)
- [Etapes suivantes](#next-steps)

## Prérequis
{: #prerequisites }
-   {: #web-app-supported-browsers }
    Les applications Web sont prises en charge pour les versions de navigateur suivantes. Le numéro de version indique la première version entièrement prise en charge pour le navigateur concerné.

    | Navigateur               | Chrome   | Safari<sup>*</sup>   | Internet Explorer   | Firefox   | Android Browser   |
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **Version prise en charge** |  {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> Dans Safari, le mode de navigation privé n'est pris en charge que pour les applications monopages (SPA). D'autres applications peuvent avoir un comportement inattendu.

    {% comment %} [sharonl][c-web-browsers-ms-edge] Voir les informations sur la prise en charge de Microsoft Edge dans la tâche 111165. {% endcomment %}

-   Les instructions de configuration suivantes nécessitent que Apache Maven ou Node.js soit installé sur le poste de travail du développeur. Pour plus d'instructions, voir le [guide d'installation](../mobilefirst/installation-guide/).

## Utilisation du profil Liberty de WebSphere pour traiter les ressources
d'application Web
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
Pour que vous puissiez traiter les ressources de l'application Web, celles-ci doivent être stockées dans une application Web Maven (un fichier **.war**).

### Création d'un archétype d'application Web Maven
{: #creating-a-maven-webapp-archetype }
1. Depuis une fenêtre de **ligne de commande**, accédez à l'emplacement de votre choix.
2. Exécutez la commande suivante :

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - Remplacez **MaSociété** et **MonAppWeb** par vos propres valeurs.
    - Pour entrer les valeurs une par une, supprimez l'indicateur `-DinteractiveMode=false`.

### Génération de l'application Web Maven avec les ressources de l'application Web
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. Placez les ressources de l'application Web (comme les fichiers HTML, CSS, JavaScript et image) dans le dossier **[MonAppWeb] → src → Main → webapp**.

    > A partir de maintenant, le dossier **webapp** sera considéré comme l'emplacement de développement de l'application web.

2. Exécutez la commande `mvn clean install` pour générer un fichier .war contenant les ressources Web de l'application.  
   Le fichier .war généré est disponible dans le dossier **[MonAppWeb] target**.

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important :** vous devez exécuter la commande `mvn clean install` à chaque fois que vous mettez à jour une ressource Web.

### Ajout de l'application Web Maven sur le serveur d'applications
{: #adding-the-maven-webapp-to-the-application-server }
1. Editez le fichier **server.xml** de votre serveur d'applications WebSphere.  
    Si vous utilisez {{ site.data.keys.mf_dev_kit }}, le fichier se trouve dans le dossier [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp**. Ajoutez l'entrée suivante :

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - Remplacez **MonAppWeb** et
**chemin/MonAppWeb.war** par vos propres valeurs.
    - Le serveur d'applications redémarre automatiquement après la sauvegarde des modifications apportées au fichier **server.xml**.  

### Test de l'application Web
{: #testing-the-web-application }
Lorsque vous êtes prêt à tester votre application Web, accédez à l'adresse URL **localhost:9080/MonAppWeb**.
    - Remplacez **MonAppWeb** par votre propre valeur.

## Utilisation de Node.js
{: #using-nodejs }
Vous pouvez utiliser Node.js comme proxy inverse pour acheminer les demandes depuis l'application Web vers {{ site.data.keys.mf_server }}.

1. Depuis une fenêtre de **ligne de commande**, accédez au dossier de votre application Web et exécutez l'ensemble de commandes suivant :

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. Créez un fichier dans le dossier **node_modules**, par exemple **proxy.js**.
3. Ajoutez le code suivant au fichier :

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/monapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Serveur Web - traite l'application Web
   app.get('/home', function(req, res) {
        // Site Web dont vous voulez autoriser la connexion
        res.sendFile(__dirname + '/index.html');
   });

   // Proxy inverse, achemine les demandes vers/de {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - Remplacez la valeur **port** par la valeur de votre choix.
    - Remplacez `/monapp` par le nom de chemin de votre choix pour votre application Web.
    - Remplacez `/index.html` par le nom de votre fichier HTML principal.
    - Si nécessaire, mettez à jour `/mfp/*` avec la racine de contexte de votre environnement d'exécution de {{ site.data.keys.product }}.

4. Pour démarrer le proxy, exécutez la commande `node proxy.js`.
5. Lorsque vous êtes prêt à tester votre application Web, accédez à l'adresse URL **nomhôte-serveur:port/nom-app**, par exemple **http://localhost:9081/monapp**.
    - Remplacez **nomhôte-serveur** par votre propre valeur.
    - Remplacez **port** par votre propre valeur.
    - Remplacez **nom-app** par votre propre valeur.

## Etapes suivantes
{: #next-steps }
Pour continuer le développement de {{ site.data.keys.product }} dans des applications Web, vous devez ajouter le logiciel SDK Web de {{ site.data.keys.product }} dans l'application Web.

* Apprenez à ajouter le logiciel SDK de [{{ site.data.keys.product }} dans les applications Web](../../../application-development/sdk/web/).
* Pour le développement d'applications, reportez-vous aux tutoriels relatifs à l'[utilisation du logiciel SDK de {{ site.data.keys.product }}](../../../application-development/).
* Pour le développement d'adaptateurs, reportez-vous à la catégorie relative aux [adaptateurs](../../../adapters/).
