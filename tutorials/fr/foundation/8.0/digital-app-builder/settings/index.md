---
layout: tutorial
title: Paramètres de Digital App Builder
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Paramètres de Digital App Builder
{: #dab-app-settings }

Cette section vous permet de gérer les paramètres de l'application et de rectifier d'éventuelles erreurs pendant le processus de construction. Les paramètres sont composés des onglets **Détails de l'application**, **Serveur**, **Plug-in**, **Thème** et **Réparer le projet**.

### Détails de l'application
{: #app-details}

L'onglet Détails de l'application affiche des informations sur votre application : **Icône de l'application**, **Nom**, **Emplacement** de stockage des fichiers, **Projet/ID de bundle** fourni à la création de l'application, **Plateformes** (canaux) sélectionnées et **Service** activé.

![Paramètres - Détails de l'application](dab-settings.png)

Vous pouvez modifier l'**Icône de l'application** en cliquant sur l'icône et en transférant une nouvelle icône.

Vous pouvez ajouter/retirer des plateformes supplémentaires en cochant/désélectionnant la case associée.

Cliquez sur **Sauvegarder** pour mettre à jour les modifications.

### Serveur
{: #server }

L'onglet Serveur indique les **Détails du serveur** en cours d'utilisation. Vous pouvez éditer ces informations en cliquant sur le lien **Editer**. Vous pouvez ajouter ou modifier l'autorisation du client confidentiel.

![Paramètres - Détails du serveur](dab-settings-server.png)

L'onglet Serveur affiche également les **Serveurs récents**.

>**Remarque** : Vous ne pouvez supprimer un serveur que s'il a été ajouté précédemment lors de la création d'une application avec Digital App Builder et s'il n'est utilisé par aucune application créée avec Digital App Builder.

Vous pouvez aussi ajouter un nouveau serveur en cliquant sur le bouton **Connecter un nouveau +**, en indiquant les détails dans la fenêtre contextuelle **Se connecter à un nouveau serveur**, puis en cliquant sur **Se connecter**.

![Paramètres - Nouveau serveur](dab-settings-new-server.png)

### **Plug-in**
{: #plugins}

L'onglet Plug-in affiche la liste des plug-in disponibles dans Digital App Builder. Vous pouvez effectuer les actions suivantes :

![Paramètres - Plug-in disponibles](dab-settings-plugins.png)

* **Installer un nouveau** : vous pouvez installer de nouveaux plug-in en cliquant sur ce bouton. La boîte de dialogue **Nouveau plug-in** s'ouvre. Entrez le **Nom du plug-in**, la **Version** (facultatif) et, s'il s'agit d'un **Plug-in local**, activez la bascule du nom, pointez vers l'emplacement et cliquez sur **Installer**.

![Paramètres - Nouveaux plug-in](dab-settings-new-plugins.png)

* Dans la liste des plug-in déjà installés, vous pouvez éditer la version et réinstaller le plug-in ou désinstaller un plug-in en cliquant sur le lien associé.


### Thème
{: #dab-theme}

Personnalisez l'impression générale de votre application en indiquant son thème (Foncé ou Clair). 

### Réparer le projet
{: #repair-project}

L'onglet Réparer le projet vous permet de corriger des problèmes en cliquant sur les options appropriées.

![Paramètres - Réparer](dab-settings-repair.png)

* **Régénérer les dépendances** : si le projet instable, vous pouvez tenter de régénérer les dépendances.
* **Régénérer les plateformes** : si vous détectez dans la console des erreurs liées aux plateformes, essayez de régénérer les plateformes. Si vous avez apporté des modifications aux canaux ou si vous avez ajouté des canaux, utilisez cette option.
* **Réinitialiser les données d'identification IBM Cloud pour le serveur Playground** : vous pouvez réinitialiser les données d'identification IBM Cloud informations d'authentification employées pour la connexion au serveur Playground. La réinitialisation du cache des données d'identification efface également toutes vos applications sur le serveur Playground. **CETTE OPERATION EST IRREVERSIBLE.**
