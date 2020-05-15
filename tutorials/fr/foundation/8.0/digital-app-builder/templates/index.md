---
layout: tutorial
title: Modèles
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Utilisation de modèles
{: #dab-templates }

Vous pouvez utiliser des modèles pour générer rapidement votre application. Il existe des modèles d'application activés pour des fonctionnalités spécifiques qui vous permettent de modifier et développer rapidement des applications.

Par défaut, Digital App Builder est livré avec deux modèles : Mod Resorts et Tabs

* **Mod Resorts** : modèle d'application comportant un cas d'utilisation d'une application de lieux de villégiature. Il contient le module de connexion, le module de dialogue en ligne et le module de commentaires intégré pour commencer. Vous devez déployer l'adaptateur de connexion et configurer vos propres données d'identification pour l'agent conversationnel.
* **Tabs** : ce modèle fournit une interface d'application mobile dont la partie inférieure contient des onglets. Ce modèle contient aussi le module de connexion.

### Création d'un modèle personnalisé
{: #create-custom-template }

Les modèles par défaut sont stockés à l'emplacement suivant :
* MacOS : `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows : `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Créez un modèle personnalisé en dupliquant et en éditant l'un des modèles par défaut, par exemple Mod Resorts.
Appliquez les personnalisations requises au modèle copié et compressez le dossier.
Sous `\ionic_templates\`, créez un dossier pour le modèle que vous avez personnalisé et copiez-y le fichier .zip.
Editez le fichier templates.json présent dans le dossier \ionic_templates\ et ajoutez une nouvelle entrée pour votre modèle.
Par exemple, le nouveau modèle personnalisé peut être ajouté de la manière suivante :

```json
{
    "version": 12,
    "templates": [
        {
            "name": "Mod Resorts",
            "icon": "modresorts/modresortslogo.png",
            "templateFile": "modresorts/modresorts.zip"
        },
        {
            "name": "Tabs",
            "icon": "tabs/tabs.png",
            "templateFile": "tabs/tabs.zip"
        }
       {
            "name": "MyCustomTemplate",
            "icon": "mytemplate/customtemplate.png",
            "templateFile": "mytemplate/customtemplate.zip"
        }
     ]
}
```
>**
Important**
>* Vous devez incrémenter le numéro de `version`.
>* En cas d'ajout d'un modèle par l'équipe d'édition, la mise à jour remplace le dossier `\ionic_templates\`. Pensez donc à effectuer une sauvegarde de votre dossier de modèle personnalisé et à l'appliquer à nouveau après les mises à jour.
