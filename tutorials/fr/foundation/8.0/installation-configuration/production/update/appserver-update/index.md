---
layout: tutorial
title: Mise à jour de MobileFirst Server
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
IBM MobileFirst Platform Foundation inclut plusieurs composants que vous pouvez avoir installés.

Voici une description de leurs dépendances pour effectuer la mise à jour :

### Service d'administration de MobileFirst Server, MobileFirst Operations Console et environnement d'exécution de MobileFirst
{: #server-console }

Ces trois composants constituent MobileFirst Server. Ils doivent être mis à jour en même temps.

### Application Center
{: #appenter}

L'installation de ce composant est facultative. Ce composant est indépendant des autres. Il peut être exécuté à un autre niveau de correctif provisoire que les autres, si nécessaire.

### MobileFirst Operational Analytics
{: #analytics}

L'installation de ce composant est facultative. Les composants MobileFirst envoient des données à MobileFirst Operational Analytics via une API REST. Il est préférable d'exécuter MobileFirst Operational Analytics avec les autres composants de MobileFirst Server du même niveau de correctif provisoire.


## Mise à jour du service d'administration de MobileFirst Server, de MobileFirst Operations Console et de l'environnement d'exécution de MobileFirst
{: #updating-server}

Vous pouvez mettre à jour ces composants en procédant de deux façons :
* En utilisant l'outil de configuration de serveur
* En utilisant des tâches Ant

La procédure de mise à jour dépend de la méthode utilisée lors de l'installation initiale.

> **Remarque :** Installation Manager(IM) ne prend pas en charge l'annulation d'une mise à jour ou d'un correctif iFix. Toutefois, l'annulation est possible en utilisant Ant ou l'outil de configuration de serveur, si vous disposez des anciens fichiers war.

### Application d'un groupe de correctifs avec l'outil de configuration de serveur
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Si {{ site.data.keys.mf_server }} a été installé avec l'outil de configuration et que le fichier de configuration a été conservé, vous pouvez appliquer un groupe de correctifs ou un correctif temporaire en réutilisant le fichier de configuration.

1. Démarrez l'outil de configuration de serveur.
    * Sous Linux, cliquez sur les raccourcis d'application **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Sous Windows, cliquez sur **Démarrer → Programmes → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Sous macOS, ouvrez une console d'interpréteur de commandes. Accédez à **rép\_install\_mfp\_serveur/shortcuts** et entrez **./configuration-tool.sh**.
    * Le répertoire **rép\_install\_mfp\_serveur** est l'emplacement auquel vous avez installé {{ site.data.keys.mf_server }}.

2. Cliquez sur **Configurations → Replace the deployed WAR files** et sélectionnez une configuration existante pour appliquer le groupe de correctifs ou un correctif temporaire.


### Application d'un groupe de correctifs à l'aide des fichiers Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Mise à jour à l'aide de l'exemple de fichier Ant
{: #updating-with-the-sample-ant-file }
Si vous utilisez l'un des exemples de fichier Ant fournis dans le répertoire **rép\_install\_mfp/MobileFirstServer/configuration-samples** pour installer {{ site.data.keys.mf_server }}, vous pouvez réutiliser une copie de ce fichier Ant afin d'appliquer un groupe de correctifs. Pour les valeurs de mot de passe, vous pouvez entrer 12 astérisques (\*) à la place de la valeur réelle pour être invité à la saisir de manière interactive lorsque le fichier Ant est exécuté.

1. Vérifiez la valeur de la propriété **mfp.server.install.dir** dans le fichier Ant. Elle doit désigner le répertoire contenant le produit auquel est appliqué le groupe de correctifs. Cette valeur permet d'extraire les fichiers WAR {{ site.data.keys.mf_server }} mis à jour.
2. Exécutez la commande suivante : `rép_install_mfp/shortcuts/ant -f votre_fichier_ant update`

#### Mise à jour à l'aide de votre propre fichier Ant
{: #updating-with-own-ant-file }
Si vous utilisez votre propre fichier Ant, assurez-vous que pour chaque tâche d'installation (**installmobilefirstadmin**, **installmobilefirstruntime** et **installmobilefirstpush**), votre fichier Ant comporte une tâche de mise à jour correspondante avec les mêmes paramètres. Les tâches de mise à jour correspondantes sont **updatemobilefirstadmin**, **updatemobilefirstruntime** et **updatemobilefirstpush**.

1. Vérifiez le chemin d'accès aux classes de l'élément **taskdef** pour le fichier **mfp-ant-deployer.jar**. Il doit désigner le fichier **mfp-ant-deployer.jar** dans une installation de {{ site.data.keys.mf_server }} à laquelle le groupe de correctifs est appliqué. Par défaut, les fichiers WAR mis à jour de {{ site.data.keys.mf_server }} sont extraits de l'emplacement dans lequel se trouve **mfp-ant-deployer.jar**.
2. Exécutez les tâches de mise à jour (**updatemobilefirstadmin**, **updatemobilefirstruntime** et **updatemobilefirstpush**) de votre fichier Ant.
