---
layout: tutorial
title: Ajout d'un jeu de données
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Ajout d'un jeu de données
{: #dab-login-form }

### Création d'un jeu de données en mode Conception
{: #data-set-design-mode }

1. A partir de la page d'arrivée de Digital App Builder, ouvrez n'importe quelle application existante ou créez-en une en mode Conception.
2. Cliquez sur **Données** dans le panneau de gauche.

    ![Données](dab-list-menu.png)

3. Cliquez sur **Ajouter un nouveau jeu de données**. La fenêtre Ajouter un jeu de données s'ouvre.

    ![Ajouter un nouveau jeu de données](dab-list-add-data-set.png)

4. Créez un jeu de données. Vous pouvez le créer à partir d'une source existante (par défaut) ou créer une source de données pour un microservice à l'aide d'un document OpenAPI.
    * **Créer à partir d'une source de données existante** (par défaut) : remplit la liste déroulante avec toutes les sources de données (adaptateurs) à partir de l'instance configurée du serveur Mobile Foundation. 
    * **Créer une source de données pour un microservice à l'aide du doc OpenAPI** : cette option vous permet de créer une source de données à partir d'un fichier de document de spécification Open API (Swagger json/yml), puis de créer un jeu de données à partir de cette source de données.

#### Créer un jeu de données à partir d'une source de données existante

1. Sélectionnez la source de données pour laquelle vous souhaitez créer le jeu de données.
2. Cette opération remplira les entités disponibles dans la source de données. Sélectionnez l'entité à créer.
3. Donnez un nom au jeu de données et cliquez sur le bouton **Ajouter**. Le jeu de données est alors ajouté et vous pouvez voir les attributs et actions qui lui sont associés.

    ![Nouveau jeu de données et ses attributs](dab-list-dataset-attributes.png)

4. Vous pouvez masquer certains attributs et actions en fonction de ce que vous souhaitez faire avec le jeu de données.
5. Vous pouvez également éditer les étiquette d'affichage des attributs.
6. Vous pouvez tester n'importe quelle action GET en indiquant les attributs obligatoires puis en cliquant sur le bouton **Exécuter cette action** associé. Pour ce faire, vous devez avoir spécifié le nom et le mot de passe du client confidentiel dans l'onglet **Paramètres**.

#### Créer une source de données pour un microservice à l'aide d'un fichier swagger

1. Sélectionnez le fichier **json/yml** pour lequel vous souhaitez créer une source de données et cliquez sur **Générer**.
2. Un adaptateur est alors créé. Il s'agit d'un artefact de configuration sur le serveur MF que vous pouvez réutiliser et déployer sur l'instance du serveur Mobile Foundation.
3. Sélectionnez l'entité pour laquelle vous souhaitez définir la source de données.
4. Donnez un nom au jeu de données et cliquez sur le bouton **Ajouter**.
5. Le jeu de données est alors ajouté et vous pouvez voir les attributs et actions qui lui sont associés.

Vous pouvez maintenant lier ce jeu de données à n'importe quel contrôle lié aux données.

#### Liaison du jeu de données dans l'application

1. A partir de votre application ouverte en mode Conception, accédez à la page à laquelle vous souhaitez ajouter la liste.
2. Cliquez sur **Afficher les contrôles** pour afficher **Lié aux données**.
3. Cliquez pour développer **Lié aux données** et faites glisser-déposez la **Liste** sur le canevas.
4. Mettez à jour les **Valeurs** si nécessaire. 
5. Ajoutez le **Titre de la liste**.
6. Choisissez le **Type de liste** à utiliser.
7. Ajoutez du contenu à l'élément de liste.
8. Etablissez une connexion à un jeu de données à employer. 

### Création d'un jeu de données en mode Code
{: #data-set-code-mode }

1. A partir de la page d'arrivée de Digital App Builder, ouvrez n'importe quelle application existante ou créez-en une en mode Code.
2. Cliquez sur **</>**  (**Afficher les fragments de code**).
3. Accédez à **IONIC** et ajoutez le fragment de code requis (liste simple, liste de carte, bouton d'en-tête) et modifiez le code si nécessaire.


