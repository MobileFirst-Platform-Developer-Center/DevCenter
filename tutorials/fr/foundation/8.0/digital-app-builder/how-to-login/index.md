---
layout: tutorial
title: Ajout d'un formulaire de connexion
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Ajout d'un formulaire de connexion
{: #dab-login-form }

### Ajout d'un formulaire de connexion à votre application en mode Conception
{: #add-login-form-design-mode }

Pour ajouter un formulaire de connexion à votre application, procédez comme suit :

1. Apportez les modifications suivantes au serveur Mobile Foundation :
    * Déployez un adaptateur de contrôle de sécurité qui admet le nom d'utilisateur et le mot de passe en entrée. Vous pouvez utiliser l'adaptateur exemple fourni [ici](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80).
    * Dans la console Mobile Foundation Operation, accédez à l'onglet de sécurité de l'application et, sous les portées d'application obligatoires, ajoutez la définition de sécurité créée ci-dessus en tant qu'élément de portée.
2. Effectuez la configuration suivante dans votre application avec Builder.
    * Ajoutez le contrôle **Formulaire de connexion** à une page du canevas.
    * Sur l'onglet **Propriétés**, indiquez le **Nom du contrôle de sécurité** et la page d'arrivée **A la réussite de la connexion**.
    * Exécutez l'application.
