---
layout: tutorial
title: Interface de Digital App Builder
weight: 4
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Interface de Digital App Builder
{: #digital-app-builder-interface }

L'interface de Digital App Builder affichée dépend du mode (Conception/Code) sélectionné.

### Interface de Digital App Builder en mode Conception

![Interface de DAB en mode Conception](dab-workbench-elements.png)

L'interface de Digital App Builder se compose des éléments suivants dans le panneau de navigation de gauche :

* **Plan de travail** : affiche ou masque les détails des pages.
* **Données** : vous aide à ajouter un jeu de données en se connectant à une source de données existante ou à créer une source de données pour un microservice à l'aide d'un document OpenAPI. 
* **Watson** : comprend les composants Reconnaissance d'image et Agent conversationnel (Watson Assistant) pour la configuration d'une instance existante ou la création d'une nouvelle instance. 
* **Engagement** : renforcez l'engagement de vos utilisateurs pour l'application en ajoutant des services de notifications push et utilisez la fonction Live Update pour afficher/masquer les contrôles et les pages ou modifier leurs propriétés lorsque votre application est active.
* **Console** : affiche la console qui permet de visualiser les activités. 
* **Paramètres** : affiche les Détails de l'application, les informations sur le Serveur, les Plug-in et les paramètres Réparer le projet (comme Régénérer les dépendances, Régénérer les plateformes, Réinitialiser les données  d'identification IBM Cloud) et permet d'activer ou de désactiver les analyses.

#### Plan de travail
{: #workbench }

Le plan de travail vous aide à concevoir les pages. Il est composé de trois zones de travail :

![Plan de travail](dab-workbench.png)

1. **Pages/Contrôles** : Cette zone affiche le nom des pages créées par défaut. Utilisez le signe **+** pour créer une page. Cliquez sur l'icône **Contrôles** pour afficher les contrôles qui vous permettent d'ajouter une fonctionnalité à une page dans une application. Vous pouvez faire glisser et déposer les contrôles à partir de la palette Contrôles vers le canevas d'une page. Chaque contrôle dispose d'un jeu de propriétés et d'actions. Vous pouvez modifier les propriétés de chaque contrôle sélectionné.

    Voici la liste des contrôles disponibles :
    * **De base** : vous pouvez faire glisser et déposer ces contrôles de base (Bouton, En-tête, Image et Etiquette) dans le canevas et configurer les propriétés et les actions.

        ![Pages/contrôles](dab-workbench-basic-controls.png)

        * **Bouton** : les boutons ont une propriété d'étiquetage. L'onglet Action vous permet d'indiquer la page à laquelle l'utilisateur accède lorsqu'il clique sur le bouton.
        * **En-tête** : vous permet d'ajouter un texte d'en-tête à l'application, comme un titre de page.
        * **Image** : vous permet de transférer une image locale ou d'indiquer l'URL d'une image.
        * **Etiquette** : vous permet d'ajouter du texte statique au corps de page. 
    * **Lié aux données** : vous permet de vous connecter à un jeu de données et d'agir sur les entités de ce dernier. Comprend deux composants : **Liste** et **Etiquette connectée**

        ![Contrôles Lié aux données](dab-workbench-databound-controls.png)

        * **Liste** : créez une page, puis faites glisser et déposez le composant Liste. Ajoutez le **Titre de la liste**, choisissez le type de liste, ajoutez du contenu et sélectionnez le jeu de données à utiliser.

        Pour plus d'informations sur l'ajout d'un **Jeu de données**, cliquez [ici](../how-to-add-dataset/).

    * **Connexion** : comprend le contrôle **Formulaire de connexion**. 
 
        Le contrôle Formulaire de connexion vous permet de créer une page de connexion afin que votre application connecte l'utilisateur au serveur Mobile Foundation. Le serveur Mobile Foundation fournit une infrastructure de sécurité pour authentifier les utilisateurs et offre ce contexte de sécurité pour accéder aux jeux de données. Pour plus d'informations, cliquez [ici](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/creating-a-security-check/).

        ![Formulaire de connexion](dab-workbench-login-control.png)

        Pour plus d'informations sur l'ajout du contrôle **Formulaire de connexion**, cliquez [ici](../how-to-login/).

    * **IA** : vous permet d'ajouter les fonctions d'intelligence artificielle de Watson à votre application.

        * **Watson Chat** : fournit une interface complète de dialogue en ligne qui peut être basée sur le service Watson Assistant d'IBM Cloud. 

            ![Watson Assistant](dab-workbench-ai-watson-chat.png)

            * Dans la section des propriétés, sélectionnez le service Watson Assistant configuré et choisissez l'espace de travail auquel vous souhaitez vous connecter. Pour définir et entraîner une conversation de dialogue en ligne, voir [Agent conversationnel](../how-to-chatbot/) sous Watson.

        * **Watson Visual Recognition** : ce contrôle permet de prendre une photo et de la faire identifier par le service Watson Visual Recognition.
         
            ![Watson Visual Recognition](dab-workbench-ai-watson-vr.png)
 
            *  Dans la section des propriétés, sélectionnez le service Visual Recognition configuré et le modèle de classification. Pour définir et entraîner ce service avec vos propres images, voir [Reconnaissance d'image](../how-to-image-recognition/) sous Watson.

2. Section **Canevas** : cette zone comprend le canal en cours sélectionné, le nom de la page en cours, la publication et le canevas.

    * Icône **Canal** : affiche le canal en cours sélectionné. Vous pouvez ajouter des canaux supplémentaires en sélectionnant les canaux requis dans la section Plateformes sous **Paramètres > Application > Détails de l'application**.
    * Nom de la page en cours : affiche le nom de la page de canevas. Lorsque vous passez d'une page à l'autre, le nom de la page en cours est mis à jour pour refléter la page sélectionnée.
    * **Créer/Prévisualiser l'application** : ce bouton comporte deux options : a. permet de prévisualiser l'application que vous développez ; b. permet de générer l'application.
    * **Publier** : cette option permet de générer et publier votre application pour Android/iOS dans App Center ou de publier des mises à jour directes de votre application via une “connexion OTA” avec des ressources Web actualisées.
    * **Canevas** : au centre de cette section se trouve le canevas qui affiche soit la conception, soit le code. Vous pouvez faire glisser et déposer les contrôles et créer l'application.

3. **Propriétés/Actions** : l'onglet des propriétés et des actions se trouve sur le côté droit. Lorsqu'un contrôle est placé dans le canevas, vous pouvez éditer et modifier les propriétés du contrôle et connecter un contrôle à une action associée à effectuer.

#### Données
{: #dataset-integration}

Vous pouvez créer un jeu de données pour un microservice. Une fois le jeu de données créé, vous pouvez connecter les contrôlées liés aux données dans votre application.

Pour plus d'informations sur l'ajout d'un **Jeu de données**, cliquez [ici](../how-to-add-dataset/).

#### Watson
{: #integrating-with-watson-services}

Digital App Builder permet de configurer l'application de telle sorte qu'elle se connecte aux différents services Watson mis à disposition sur IBM Cloud.

#### Engagement
{: #engagement}

Vous pouvez ajouter des notifications push à votre application et renforcer l'engagement des utilisateurs ou utiliser la fonction Live Update pour afficher/masquer les contrôles et les pages ou modifier leurs propriétés lorsque votre application est active.

#### Console
{: #console }

La console permet de visualiser le code de chaque composant. Elle affiche également les informations sur les différentes activités et erreurs.

#### Paramètres
{: #settings}

Cette section vous permet de gérer les paramètres de l'application et de rectifier d'éventuelles erreurs pendant le processus de construction. Elle est composée des onglets **Détails de l'application**, **Serveur**, **Plug-in** et **Réparer le projet**.

### Interface de Digital App Builder en mode Code

![Interface de DAB en mode Code](dab-workbench-elements-codemode.png)

L'interface de Digital App Builder en mode Code est composé des éléments suivants dans le panneau de navigation de gauche :

* **Plan de travail** : affiche ou masque les fichiers.
* **Watson** : comprend les composants Reconnaissance d'image et Agent conversationnel (Watson Assistant) pour la configuration d'une instance existante ou la création d'une nouvelle instance. 
* **Engagement** : renforcez l'engagement de vos utilisateurs pour l'application en ajoutant des services de notifications push et utilisez la fonction Live Update pour afficher/masquer les contrôles et les pages ou modifier leurs propriétés lorsque votre application est active.
* **API** : permet de simuler le serveur en fournissant des données JSON lors du développement.
* **Console** : affiche la console qui permet de visualiser les activités. 
* **Paramètres** : affiche les Détails de l'application, les informations sur le Serveur, les Plug-in et les paramètres Réparer le projet (comme Régénérer les dépendances, Régénérer les plateformes, Réinitialiser les données d'identification IBM Cloud) et permet d'activer ou de désactiver les analyses.

#### Plan de travail (mode Code)
{: #workbench }

Le plan de travail vous aide à concevoir les pages. Il est composé de deux zones de travail :

1. **Fichiers de projet** : cette zone affiche la liste des fichiers associés à l'application créés par défaut. Utilisez le signe **+** pour créer une page. Lorsque vous cliquez sur l'icône **Contrôles** (**</>**), le panneau **Fragments de code** s'affiche. Vous pouvez faire glisser et déposer ces fragments de code dans votre code et modifier les propriétés de chacun des contrôles sélectionnés.

#### Fragments de code (mode Code uniquement)
{: #code-snippets}

Certains fragments de code fréquemment employés sont prédéfinis et peuvent être ajoutés aux fichiers source par simple glisser-déposer à partir de la section Fragments de code. Cette section est composée de fragments de code dans les catégories suivantes :

* **Coeur mobile** : fragments de code qui permettent d'effectuer des opérations de base avec IBM Mobile Foundation Server.
* **Analyse** : fragments de code pour l'analyse personnalisée et les commentaires utilisateur.
* **Ionic** : fragments de code pour des composants Ionic simples.
* **Push** : fragments de code pour l'utilisation de notifications push.
* **Live Update** : fragment de code pour l'activation/désactivation de la fonction Live Update.

