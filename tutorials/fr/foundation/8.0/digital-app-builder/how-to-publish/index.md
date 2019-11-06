---
layout: tutorial
title: Publication d'une application dans IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publication d'une application dans App Center
{: #dab-app-publish }

IBM MobileFirst Foundation Application Center est un référentiel d'applications mobiles similaire aux magasins d'applications publics, mais qui est dédié aux besoins d'une organisation ou d'une équipe. Il s'agit d'un magasin d'applications privé. Pour plus d'informations sur App Center, cliquez [ici](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/).

Vous pouvez ajouter votre application au référentiel sur le serveur à l'aide de la fonction **Publier** de Digital App Builder.

>**Remarque** : Vérifiez que l'application créée ne contient pas d'erreur avant de la publier sur App Center.

1. A partir de votre projet d'application, cliquez sur **Publier**. Une fenêtre contextuelle contenant les plateformes sélectionnées s'ouvre.

    ![Publier](dab-publish.png)

2. Cliquez sur **Publier dans App Center**.

    ![Publier dans App Center](dab-publish-app-center.png)

3. Sélectionnez un App Center existant ou cliquez sur **Connecter un nouveau**. Cliquez sur **Se connecter**.
4. Le package est alors généré pour la plateforme sélectionnée.
5. *Pour iOS uniquement* : Editez le fichier *app-build.json* et mettez à jour la zone `developmentTeam` avec votre Apple Developer Team ID. Pour connaître cet ID, connectez-vous à votre [compte Apple Developer](https://developer.apple.com/account/#/membership). 

    ![Publier sur iOS](dab-publish-ios.png)

6. Cliquez sur **Publier** une fois que les packages sont prêts.
7. Lorsque la publication aboutit, un code QR est généré.

    ![Code QR de publication dans App Center](dab-publish-code-scan.png)

8. Vous pouvez vérifier que l'application est disponible dans App Center en vous connectant à **App Center** > **Gestion des applications**.

>**Remarque** : Vous pouvez sélectionner une nouvelle fois la plateforme requise et créer, puis publier l'application dans **App Center**.

