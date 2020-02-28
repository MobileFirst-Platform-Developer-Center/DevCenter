---
layout: tutorial
title: Incluindo notificações de push
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Incluindo notificações de push em um aplicativo
{: #dab-engagement-push }

É possível incluir notificações Push em seu aplicativo e aumentar o engajamento do usuário.

Para incluir notificações Push em seu aplicativo:

1. Selecione **Engajamento**. Isso exibirá a lista de serviços disponíveis.

    ![Push de engajamento](dab-push-notification.png)

2. Selecione **Notificações de push** e clique em **Ativar**. Isso exibe a página de configuração Notificações push.

3. Configure a notificação push para Android fornecendo **Chave secreta da API** e **ID do emissor** e clique em **Salvar configuração**.

    ![Configuração de notificação push de engajamento do Android](dab-push-android-config.png)

4. Navegue até a guia iOS e forneça detalhes de configuração de push: selecione o **Ambiente**, forneça um caminho ao arquivo .p12, insira a **Senha** e clique em **Salvar configuração**.

    ![Configuração de notificação push de engajamento do iOS](dab-push-ios-config.png)

5. Execute a seguinte etapa adicional para iOS:
    * Abra o projeto xcode `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj` e ative o recurso de notificação de push. Para obter mais detalhes, consulte [https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1).

6. No lado do servidor,
 
    * Siga [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) para ativar as notificações push no lado do servidor.

    * Siga [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications) para enviar notificações do servidor

**Nota**:
As notificações push do servidor MFP são usadas para ativar o serviço de notificação. Portanto, se o serviço de notificação push do IBM Cloud foi usado antes, siga o link para configurar notificações no servidor MFP [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications).

