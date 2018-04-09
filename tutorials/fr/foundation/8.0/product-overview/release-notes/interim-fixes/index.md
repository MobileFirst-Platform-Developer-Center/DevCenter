---
layout: tutorial
title: Nouveautés des correctifs temporaires 
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Les correctifs temporaires fournissent des modules de correction et de mises à jour permettant de corriger des problèmes et de maintenir {{ site.data.keys.product_full }} à jour pour les nouvelles éditions des systèmes d'exploitation mobiles.

Les correctifs temporaires sont cumulatifs. Lorsque vous téléchargez le dernier correctif temporaire v8.0, vous obtenez tous les correctifs des correctifs temporaires antérieurs.

Téléchargez et installez le dernier correctif temporaire pour obtenir tous les correctifs décrits dans les sections ci-après. Si vous installez des correctifs antérieurs, vous n'obtiendrez peut-être pas tous les correctifs décrits ci-après.

> Pour obtenir la liste des éditions de correctif temporaire de {{ site.data.keys.product }} 8.0, [voir ces articles de blogue]({{site.baseurl}}/blog/tag/iFix_8.0/).

Lorsqu'un numéro d'APAR est indiqué, vous pouvez vérifier qu'un correctif temporaire possède cette fonction en recherchant ce numéro dans le fichier README du correctif temporaire.

### Octroi de licence
{: #licensing }
#### Octroi de licence PVU
{: #pvu-licensing }
Une nouvelle offre, {{ site.data.keys.product }} Extension V8.0.0, est disponible via l'octroi de licence PVU (unité de valeur par coeur de processeur). Pour
plus d'informations sur l'octroi de licence par unité de valeur par coeur de
processeur pour {{ site.data.keys.product }} Extension, voir
[Octroi de licence dans {{ site.data.keys.product_adj }}](../../licensing).

### Applications Web
{: #web-applications }
#### Enregistrement d'applications Web à partir de
l'interface de ligne de commande {{ site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
Vous pouvez désormais enregistrer des applications Web client sur
{{ site.data.keys.mf_server }} en utilisant
l'interface de ligne de commande {{ site.data.keys.mf_cli }} (mfpdev) à la
place de la
console {{ site.data.keys.mf_console }}. Pour plus d'informations, voir
la rubrique Enregistrement d'applications Web à partir de
l'interface de ligne de commande {{ site.data.keys.mf_cli }}.

### Applications Cordova
{: #cordova-applications }
#### Ouverture de l'environnement de développement intégré natif pour un projet Cordova à partir d'Eclipse à l'aide du plug-in Studio
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Le plug-in Studio étant installé dans votre environnement de développement intégré Eclipse, vous pouvez ouvrir un projet Cordova existant dans Android Studio ou Xcode à partir de l'interface Eclipse afin de générer et d'exécuter le projet.

#### Répertoire *projectName* ajouté en tant qu'option lors de l'utilisation de l'outil Assistance à la migration
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
Vous pouvez spécifier un nom pour votre répertoire de projet Cordova lorsque vous migrez des projets à l'aide de l'outil Assistance à la migration. Si vous n'indiquez pas de nom, le nom par défaut est *app_name-app_id-version*.

#### Améliorations de la facilité d'utilisation de l'outil Assistance à la migration
{: #usability-improvements-to-the-migration-assistance-tool }
Les modifications suivantes ont été apportées afin d'améliorer la facilité d'utilisation de l'outil Assistance à la migration :

* L'outil Assistance à la migration analyse les fichiers HTML et JavaScript.
* Le rapport d'analyse s'ouvre automatiquement dans votre navigateur par défaut à la fin de l'analyse.
* L'indicateur *--out* est facultatif. Le répertoire de travail est utilisé si l'indicateur n'est pas spécifié.
* Lorsque l'indicateur *--out* est spécifié et que le répertoire n'existe pas, le répertoire est créé.

### Adaptateurs
{: #adapters }
#### Commandes `mfpdev push` et `pull` ajoutées pour les configurations d'adaptateur Java et JavaScript
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
Vous pouvez utiliser {{ site.data.keys.mf_cli }}
pour insérer des
configurations d'adaptateur Java et JavaScript sur le serveur {{ site.data.keys.mf_server }} et extraire des configurations d'adaptateur du serveur {{ site.data.keys.mf_server }}.

### Application Center
{: #application-center}

Le client Application Center Cordova est désormais disponible pour iOS et Android.
