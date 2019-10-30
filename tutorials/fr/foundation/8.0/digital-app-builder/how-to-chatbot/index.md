---
layout: tutorial
title: Ajout d'un agent conversationnel
weight: 9
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Agent conversationnel Watson
{: #dab-chatbot }

Les agents conversationnels reposent sur le service Watson Assistant d'IBM Cloud. Créez une instance Watson Assistant sur IBM Cloud. Pour plus d'informations, cliquez [ici](https://cloud.ibm.com/catalog/services/watson-assistant-formerly-conversation).

Une fois la configuration effectuée, vous pouvez créer un nouvel **espace de travail**. L'espace de travail est un ensemble de conversations qui constituent un agent conversationnel. Après avoir créé l'espace de travail, commencez à créer les dialogues. Indiquez un ensemble de questions liés à une intention, ainsi qu'un ensemble de réponses pour cette intention. Watson Assistant utilise Natural Language Understand pour interpréter l'intention en fonction des exemples de questions que vous avez indiqués. Il peut ensuite tenter d'interpréter la question posée par un utilisateur dans différents styles et la mapper à l'intention.

Pour activer un agent conversationnel dans votre application, procédez comme suit :

1. Cliquez sur **Watson**, puis sur **Agent conversationnel**. L'écran **Utiliser Watson Assistant** s'affiche.

    ![Agent conversationnel Watson](dab-watson-chat.png)

2. Cliquez sur **Se connecter** pour vous connecter à votre instance Watson Assistant.

    ![Instance de dialogue en ligne Watson](dab-watson-chat-instance.png)

3. Entrez les détails de la **Clé d'API** et précisez l'**URL** de votre instance Watson Assistant. 
4. Donnez un **Nom** à l'agent conversationnel, puis cliquez sur **Se connecter**. Le tableau de bord du service de dialogue en ligne associé au **Nom** donné s'affiche.

    ![Espace de travail de l'agent conversationnel Watson](dab-watson-chat-workspace.png)

5. Ajoutez un espace de travail en cliquant sur **Ajouter un espace de travail**. L'option contextuelle **Créer un modèle** s'affiche.

    ![Nouveau modèle d'espace de travail pour l'agent conversationnel Watson](dab-watson-chat-new-model.png)

6. Entrez le **Nom de l'espace de travail** et la **Description de l'espace de travail**, puis cliquez sur **Créer**. Trois espaces de travail **Conversation** sont alors créés (Bienvenue, Aucune correspondance trouvée et Nouvelle conversation).

    ![Conversation par défaut de l'agent conversationnel Watson](dab-watson-chat-conversations.png)

7. Cliquez sur **Nouvelle conversation** pour entraîner le nouveau modèle d'agent conversationnel. 

    ![Questions/réponses sur l'agent conversationnel Watson](dab-watson-chat-questions.png)

8. Ajoutez des questions et des réponses sous la forme d'un fichier CSV ou de questions/réponses individuelles. Par exemple, indiquez **Ajouter une instruction de l'utilisateur** pour Si l'utilisateur a l'intention de demander, puis **Ajouter une réponse du bot** pour **Alors, le bot doit répondre par**. Vous pouvez également transférer des questions et des réponses à l'agent conversationnel.
9. Cliquez sur **Sauvegarder**.
10. Cliquez sur l'icône Agent conversationnel en bas à droite pour tester l'agent conversationnel.

    ![Test de l'agent conversationnel](dab-watson-chat-testing.png)
