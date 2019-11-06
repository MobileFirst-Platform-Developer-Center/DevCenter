---
layout: tutorial
title: Activation/désactivation de fonctions avec Live Update
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Activation/désactivation de fonctions avec Live Update
{: #dab-feature-toggle-live-update }

Utilisez Live Update pour rendre différents aspects de votre application configurables, et pour activer ou désactiver des fonctions à distance. Vous pouvez également contrôler les propriétés de l'application en modifiant les valeurs des variables directement à partir de MobileFirst Operations Console.

Fonction est une valeur activée/désactivée qui permet d'activer ou de désactiver une fonction de l'application.

Les propriétés sont des paires nom-valeur qui permettent de contrôler le comportement de l'application.

>**Remarque** : Live Update est disponible uniquement lorsque l'application est prête.


### Ajout de Live Update en mode Conception

Pour ajouter Live Update à votre application :

1. Sélectionnez **Engagement**. La liste des services disponibles s'affiche.

    ![Engagement - Live Update](dab-live-update.png)

2. Sélectionnez **Live Update** et cliquez sur **Activer**. La fonction Live Update est alors configurée dans le serveur Mobile Foundation. Lorsque la fonction Live Update est activée avec succès, un message contextuel s'affiche.

    ![Activation de Live Update](dab-live-update-enable.png)

3. Cliquez sur **+ Nouvelle fonction** pour définir une nouvelle fonction dans le serveur Mobile Foundation. L'écran ci-dessous s'affiche.

    ![Nouvelle fonction](dab-live-update-new-feature.png)

4. Saisissez l'**ID de la fonction** et le **Nom de la fonction**, puis définissez la **Visibilité** par défaut.

    * **ID de la fonction** : identificateur unique de la fonction.
    * **Nom de la fonction** : indiquez un nom décrivant la fonction.

    ![Nouvelle propriété](dab-live-update-feature-new.png)

5. Cliquez sur **Créer**.

6. De même, définissez une propriété Live Update en indiquant les détails suivants :

    * **ID de la propriété**
    * **Nom de la propriété**
    * **Valeur de la propriété**

### Ajout de Live Update en mode Code

Pour ajouter Live Update à votre application :

**Méthode 1**

1. Ouvrez l'application en mode Code.
2. Accédez à `projectname/ionic/src/app/app.component.ts`

    ![Nouvelle propriété - méthode 1](dab-live-update-new-feature-code.png)

3. Accédez à la méthode d'initialisation de Live Update
4. Editez le code de sorte à afficher/masquer un contrôle et une propriété pour définir la propriété du contrôle.

**Méthode 2**

1. Ouvrez l'application en mode Code.
2. Accédez au fragment de code et cliquez sur **</>**.
3. sous Live Update > Live Update Configuration.

    ![Nouvelle propriété - méthode 2](dab-live-update-new-feature-code-snippet.png)

4. Faites glisser et déposez le fragment de code **LiveUpdate Configuration**.
5. Editez le code de sorte à afficher/masquer un contrôle et une propriété pour définir la propriété du contrôle.

