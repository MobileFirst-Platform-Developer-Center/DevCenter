---
layout: tutorial
title: Publication d'une application dans IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publication d'une application
{: #dab-app-publish }

L'option Publier vous permet de générer et de publier votre application pour Android/iOS dans App Center ou de publier des mises à jour directes de votre application via une “connexion OTA” avec des ressources Web actualisées.

### Publication d'une application dans App Center
{: #dab-app-publish-to-app-center }

IBM MobileFirst Foundation Application Center est un référentiel d'applications mobiles similaire aux magasins d'applications publics, mais qui est dédié aux besoins d'une organisation ou d'une équipe. Il s'agit d'un magasin d'applications privé. Pour plus d'informations sur App Center, cliquez [ici](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/).

Vous pouvez ajouter votre application au référentiel sur le serveur à l'aide de la fonction **Publier** de Digital App Builder.

>**Remarque** : Vérifiez que l'application créée ne contient pas d'erreur avant de la publier sur App Center.

1. A partir de votre projet d'application, cliquez sur **Publier**. Une fenêtre contextuelle contenant les plateformes sélectionnées s'ouvre.

    ![Publier](dab-publish.png)

2. Sélectionnez la **plateforme** sur laquelle publier votre application.

3. Cliquez sur **Web Checksum** pour activer la fonctionnalité de somme de contrôle des ressources Web. Pour en savoir plus, voir [Enabling the web resources checksum feature](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Cliquez sur **Web Resource Encryption** pour chiffrer les ressources Web de vos packages Cordova. Pour en savoir plus, voir [Encrypting the web resources of your Cordova packages](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).

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

### Publier la mise à jour directe
{: #dab-publish-direct-update }

Avec la [mise à jour directe](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/), les applications Cordova peuvent être mises à jour via une “connexion OTA” avec des ressources Web actualisées, tels que des fichiers Javascript, HTML, CSS ou images. Les entreprises peuvent ainsi s'assurer que les utilisateurs finaux utilisent la dernière version de l'application.

>**Remarque** : Vérifiez que l'application créée ne contient pas d'erreur avant de la publier sur App Center.

1. A partir de votre projet d'application, cliquez sur **Publier**. Une fenêtre contextuelle contenant les plateformes sélectionnées s'ouvre.

    ![Publier](dab-publish.png)

2. Sélectionnez la **plateforme** sur laquelle publier votre application.

3. Cliquez sur **Web Checksum** pour activer la fonctionnalité de somme de contrôle des ressources Web. Pour en savoir plus, voir [Enabling the web resources checksum feature](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Cliquez sur **Web Resource Encryption** pour chiffrer les ressources Web de vos packages Cordova. Pour en savoir plus, voir [Encrypting the web resources of your Cordova packages](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).
5. Cliquez sur **Publier la mise à jour directe**. Lorsque l'utilisateur démarre l'application et se connecte au serveur Mobile Foundation, une invite apparaît lui demandant de mettre à jour les ressources Web. Après la confirmation, les ressources Web mises à jour seront disponibles pour l'utilisateur.
