---
layout: tutorial
title: Ajout de notifications push
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Ajout de notifications push à une application
{: #dab-engagement-push }

Vous pouvez ajouter des notifications push à votre application et renforcez l'engagement des utilisateurs.

Pour ajouter des notifications push à votre application, procédez comme suit :

1. Sélectionnez **Engagement**. La liste des services disponibles s'affiche.

    ![Notifications push d'engagement](dab-push-notification.png)

2. Sélectionnez **Notifications push** et cliquez sur **Activer**. La page de configuration des Notifications push apparaît.

3. Configurez la notification push pour Android en indiquant la **Clé secrète d'API** et l'**ID d'émetteur**, puis cliquez sur **Sauvegarder la configuration**.

    ![Configuration de la notification push d'engagement pour Android](dab-push-android-config.png)

4. Accédez à l'onglet iOS et indiquez les détails de configuration de la configuration push : sélectionnez l'**Environnement**, saisissez le fichier .p12 avec son chemin et entrez le **Mot de passe**, puis cliquez sur **Sauvegarder la configuration**.

    ![Configuration de la notification push d'engagement pour iOS](dab-push-ios-config.png)

5. Effectuez l'étape supplémentaire suivante pour iOS :
    * Ouvrez le projet xcode `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj` et activez la fonctionnalité de notification push. Pour plus de détails, voir [https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1).

6. Côté serveur :
 
    * Suivez les instructions indiquées dans [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) pour activer les notifications push côté serveur.

    * Suivez les instructions indiquées dans [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications) pour envoyer des notifications à partir du serveur.

**Remarque** : Les notifications push issues du serveur MFP permettent d'activer le service de notification. Par conséquent, si le service de notification push IBM Cloud a été utilisé auparavant, suivez les instructions indiquées dans [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) pour configurer les notifications dans le serveur MFP.

