---
layout: tutorial
title: Configuration de l'environnement de développement MobileFirst
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.product_full }} est constitué de plusieurs composants : les logiciels SDK de client, les archétypes d'adaptateur, les contrôles de sécurité et les outils d'authentification.

Ces composants sont disponibles depuis des référentiels en ligne et peuvent être installés à l'aide de gestionnaires de package. Ces référentiels en ligne fournissent l'édition la plus récente de chaque composant. Un même composant peut également être téléchargé depuis {{ site.data.keys.mf_dev_kit }} pour une utilisation locale. Notez que la version disponible depuis {{ site.data.keys.mf_dev_kit_short }} est la version qui était disponible au moment de la publication de la génération de {{ site.data.keys.mf_dev_kit_short }}, et que vous devrez télécharger une nouvelle génération de {{ site.data.keys.mf_dev_kit_short }} pour pouvoir utiliser la version la plus récente.

Lisez cette rubrique pour en savoir plus sur les composants de {{ site.data.keys.product }}.

> Pour évaluer {{ site.data.keys.product }}, il suffit de démarrer une instance de {{ site.data.keys.mf_server }} dans IBM Cloud à l'aide du service IBM Cloud Mobile Foundation. Voir le tutoriel [Using Mobile Foundation](../../../bluemix/using-mobile-foundation/) pour des instructions. Vous pouvez aussi choisir d'installer {{ site.data.keys.mf_dev_kit_short }} pour une installation locale.

#### Aller à :
{: #jump-to }

* [Guide d'installation](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [Composants de {{ site.data.keys.product }}](#mobilefirst-foundation-components)
* [Développement d'applications et d'adaptateurs](#applications-and-adapters-development)
* [Tutoriels à suivre ensuite](#tutorials-to-follow-next)

## Guide d'installation
{: #installation-guide }
[Lisez le guide d'installation](installation-guide) pour configurer rapidement MobileFirst Foundation sur votre poste de travail.

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
{{ site.data.keys.mf_dev_kit_short }} fournit un environnement prêt pour le développement avec la configuration minimale requise. Le kit est constitué des composants suivants : {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_console }} et MobileFirst Developer Commande-line interface (CLI). Il permet également de télécharger en option des logiciels SDK de client ainsi que des outils d'adaptateur.

> **Remarque :** si vous devez configurer votre environnement de développement sur un ordinateur sans accès Internet, vous pouvez installer les composants hors ligne. Voir [How to set up an offline IBM MobileFirst development environment]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment).

### Programme d'installation de {{ site.data.keys.mf_dev_kit_short }}
{: #developer-kit-installer }
Le programme d'installation conditionne les composants pour une installation locale pour laquelle la connectivité Internet n'est pas disponible.  
Les composants sont disponibles via le centre de téléchargement de {{ site.data.keys.mf_console }}.

> Pour télécharger le programme d'installation, visitez la page des [téléchargements]({{site.baseurl}}/downloads/).

## Composants de {{ site.data.keys.product }}
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Dans le cadre de {{ site.data.keys.mf_dev_kit_short }}, {{ site.data.keys.mf_server }} est prédéployé sur un serveur d'applications WebSphere de profil Liberty. Le serveur est préconfiguré avec un environnement d'exécution "mfp" et utilise une base de données Apache Derby reposant sur un système de fichiers.

Les scripts suivants, que vous pouvez exécuter depuis une ligne de commande, sont disponibles dans le répertoire de base de {{ site.data.keys.mf_dev_kit_short }} :

* `run.[sh|cmd]` : exécutez {{ site.data.keys.mf_server }} et affichez le journal serveur dans la fenêtre de ligne de commande pour le serveur Liberty
    * Ajoutez l'indicateur `-bg` afin d'exécuter le processus en arrière-plan
* `stop.[sh|cmd]` : arrêtez l'instance {{ site.data.keys.mf_server }} en cours
* `console.[sh|cmd]` : ouvrez {{ site.data.keys.mf_console }}

L'extension de fichier `.sh` est valable pour Mac et Linux et l'extension de fichier `.cmd` pour Windows.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} expose les fonctionnalités ci-dessous.  
Un développeur peut :

- Enregistrer et déployer des applications et des adaptateurs
- Télécharger des modèles de code de démarrage d'adaptateur et d'application native/Cordova, s'il le souhaite
- Configurer les propriétés de sécurité et d'authentification d'une application
- Gérer les applications :
    - Authenticité de l'application
    - Mise à jour directe
    - Désactivation/Notification à distance
- Envoyer des notifications push à des appareils iOS et Android
- Générer des scripts DevOps pour des flux de travaux d'intégration continue et des cycles de développement plus rapides

> Pour en savoir plus sur {{ site.data.keys.mf_console }}, voir le tutoriel [Utilisation de MobileFirst Operations Console](../../../product-overview/components/console/).

### {{ site.data.keys.product }} Command-line Interface
{: #mobilefirst-foundation-command-line-interface }
Vous pouvez utiliser {{ site.data.keys.mf_cli }} en plus de {{ site.data.keys.mf_console }} pour développer et gérer des applications. Les commandes de l'interface de ligne de commande sont préfixées avec `mfpdev` et prennent en charge les types de tâche suivants :

* Enregistrement des applications sur {{ site.data.keys.mf_server }}
* Configuration de votre application
* Création, génération et déploiement d'adaptateurs
* Aperçu et mise à jour des applications Cordova

> Pour télécharger et installer {{ site.data.keys.mf_cli }}, visitez la page des [téléchargements]({{site.baseurl}}/downloads/).  
> Pour plus d'informations sur les différentes commandes d'interface de ligne de commande, voir le tutoriel [Utilisation de l'interface de ligne de commande pour gérer des artefacts MobileFirst](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### Logiciels SDK de client et outils d'adaptateur de {{ site.data.keys.product }}
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{ site.data.keys.product }} fournit des logiciels SDK de client pour les applications Cordova ainsi que pour les plateformes natives (iOS, Android, Windows 8.1 Universal et Windows 10 UWP). Des outils d'adaptateur pour le développement d'adaptateurs et de contrôles de sécurité sont également disponibles.

* Pour utiliser les logiciels SDK de client de {{ site.data.keys.product_adj }}, visitez la catégorie de tutoriels [Adding the {{ site.data.keys.product }} SDK](../../../application-development/sdk/).  
* Pour développer des adaptateurs, visitez la catégorie de tutoriels [Adaptateurs](../../../adapters/).  
* Pour développer des contrôles de sécurité, visitez la catégorie de tutoriels [Authentification et sécurité](../../../authentication-and-security/).  

## Développement d'applications et d'adaptateurs
{: #applications-and-adapters-development }

### Applications
{: #applications }
* Les applications Cordova requièrent NodeJS et l'interface de ligne de commande Cordova. Pour en savoir plus, voir [Configuration de l'environnement de développement Cordova](../cordova).

    Vous pouvez utiliser l'éditeur de code de votre choix, par exemple Atom.io, Visual Studio Code, Eclipse, IntelliJ ou d'autres, afin d'implémenter des applications et des adaptateurs.  

* Les applications natives requièrent Xcode, Android Studio ou Visual Studio. Pour en savoir plus, voir [Configuration de l'environnement de développement - iOS/Android/Windows](../).

### Adaptateurs
{: #adapters }
Les adaptateurs requièrent l'installation d'Apache Maven. Voir la catégorie [Adaptateurs](../../../adapters/) pour en savoir plus sur les adaptateurs, leur création, leur développement et leur déploiement.

## Tutoriels à suivre ensuite
{: #tutorials-to-follow-next }
Visitez la page [Tous les tutoriels](../../../all-tutorials/) et sélectionnez une catégorie de tutoriels à suivre ensuite.
