---
layout: tutorial
title: Configuration de l'environnement de développement
breadcrumb_title: Development Environment
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Avant de commencer à développer le code de client et de serveur avec
{{ site.data.keys.product_full }}, vous devez configurer l'environnement de
développement. Vous devez notamment installer divers logiciels et outils requis. Vous
trouverez ci-après la liste des logiciels qu'il peut être nécessaire d'installer sur le
poste de travail du développeur, selon les besoins.

Vous trouverez également des instructions détaillées
[dans ce guide d'installation pour le poste de
travail](mobilefirst/installation-guide/).

#### Aller à :

* [Serveur](#server)
* [Développement d'applications](#application-development)
* [Développement d'adaptateurs](#adapter-development)
* [Instructions propres à
la plateforme](#platform-specific-instructions)

### Serveur
{: #server }
Vous pouvez utiliser {{ site.data.keys.mf_server }} via le [service IBM Cloud Mobile Foundation](../../bluemix/using-mobile-foundation) ou localement avec {{ site.data.keys.mf_dev_kit_full }} (pour un développement local seulement). {{ site.data.keys.mf_server }} requiert
l'exécution de Java 7 ou 8.

Si vous envisagez d'utiliser le service IBM Cloud Mobile Foundation, un compte bluemix.net est requis.

### Développement d'applications
{: #application-development }
Les logiciels suivants au moins sont requis :

* NodeJS (requis pour {{ site.data.keys.mf_cli }})
* {{ site.data.keys.mf_cli }}
* L'interface de ligne de commande Cordova
* Des environnements de développement intégrés :
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io/Visual Studio Code/WebStorm/IntelliJ/Eclipse/d'autres

### Développement d'adaptateurs
{: #adapter-development }
Les logiciels suivants au moins sont requis :

* NodeJS (requis pour {{ site.data.keys.mf_cli }})
* *Facultatif* : {{ site.data.keys.mf_cli }}
* Maven (requiert Java)
* Des environnements de développement intégrés :
    - IntelliJ/Eclipse/d'autres

### Instructions propres à la plateforme
{: #platform-specific-instructions }
