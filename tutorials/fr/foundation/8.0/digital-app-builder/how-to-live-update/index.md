---
layout: tutorial
title: Activation/désactivation de fonctions avec Live Update
weight: 13
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Activation/désactivation de fonctions avec Live Update
{: #dab-feature-toggle-live-update }

Utilisez Live Update pour rendre différents aspects de votre application configurables, et pour activer ou désactiver des fonctions à distance. Vous pouvez également contrôler les propriétés de l'application en modifiant les valeurs des variables directement à partir de MobileFirst Operations Console.

* Une **fonction** est une valeur binaire Activé/Désactivé utilisée pour activer ou désactiver une fonction de l'application.
* Les **propriétés** sont des paires nom-valeur qui permettent de contrôler le comportement de l'application.

>**Remarque** : Live Update est disponible uniquement lorsque l'application est prête.

### Activation de Live Update

Vous pouvez activer la fonction Live Update à l'aide de la méthode suivante :

1. Sélectionnez **Engagement**. La liste des services disponibles s'affiche.

    ![Engagement - Live Update](dab-live-update.png)

2. Sélectionnez **Live Update** et cliquez sur **Activer**. Live Update sera configurée dans le serveur Mobile Foundation. Lorsqu'elle a été activée avec succès, un message contextuel s'affiche.

    ![Activation de Live Update](dab-live-update-enable.png)

3. Cliquez sur **+ Nouvelle fonction** pour définir une nouvelle fonction dans le serveur Mobile Foundation. L'écran ci-dessous s'affiche.

    ![Nouvelle propriété](dab-live-update-feature-new.png)

4. Saisissez l'**ID de la fonction** et le **Nom de la fonction**, puis définissez la **Visibilité** par défaut.

    * **ID de la fonction** : identificateur unique de la fonction.
    * **Nom de la fonction** : indiquez un nom décrivant la fonction.

5. Cliquez sur **Créer**.

6. De même, définissez une propriété Live Update en indiquant les détails suivants :

    * **ID de la propriété**
    * **Nom de la propriété**
    * **Valeur de la propriété**

### Utilisation de Live Update en mode Conception

En mode Conception, après avoir activé l'option Live Update, vous pouvez modifier les paramètres **Valeur textuelle**, **Couleur du texte** ou **Couleur d'arrière-plan** du contrôle sélectionné et mettre à jour en direct les modifications en définissant une nouvelle propriété ou en modifiant une propriété existante. Vous pouvez modifier la valeur de la propriété dans la table Live Updates qui répertorie les fonctions et les propriétés qui leur sont associées.

#### Association d'un contrôle à une fonction

Pour associer un contrôle à une fonction :

1. Cliquez sur un contrôle pour le sélectionner. 
2. Définissez une nouvelle fonction en cliquant sur le signe **+** en regard de l'option **Sélectionner une fonction** dans la section **Afficher/Masquer les contrôles**. 
3. Attribuez-lui des valeurs pour **ID de la fonction** et **Nom de la fonction**, et activez ou désactivez  sa visibilité à l'aide du commutateur **Activé/Désactivé**.

#### Modification de la propriété d'un contrôle

Pour modifier la propriété d'un contrôle :

Sélectionnez un contrôle et un type **${property_name}**, ou sélectionnez une propriété à associer dans la liste ou créez-en une  à l'aide de l'option **Ajouter une nouvelle propriété**, puis renseignez les champs **ID de la propriété**, **Nom de la propriété** et **Valeur de la propriété**.
 
Vous pouvez utiliser les contrôles et propriétés suivants avec Live Update :

* **Bouton** : Valeur textuelle, Couleur du texte, Couleur d'arrière-plan
* **En-tête** : Valeur textuelle, Couleur du texte
* **Etiquette** : Valeur textuelle, Couleur du texte

### Ajout de Live Update en mode Code

Pour ajouter Live Update à votre application :

**Méthode 1**

1. Ouvrez l'application en mode Code.
2. Accédez à `projectname/ionic/src/app/app.component.ts`

    ![Ajout de Live Update en mode Code - méthode 1](dab-live-update-new-feature-code.png)

3. Accédez à la méthode d'initialisation de Live Update
4. Editez le code de sorte à afficher/masquer un contrôle et une propriété pour définir la propriété du contrôle.

**Méthode 2**

1. Ouvrez l'application en mode Code.
2. Accédez au fragment de code et cliquez sur **</>**.
3. Sous **Live Update**, faites glisser et déposez le fragment de code de la **fonction Live Update** ou de la **propriété Live Update**.

    ![Ajout de Live Update en mode Code - méthode 2](dab-live-update-new-feature-code-snippet.png)

4. Editez le code de sorte à afficher/masquer un contrôle et une propriété pour définir la propriété du contrôle.
