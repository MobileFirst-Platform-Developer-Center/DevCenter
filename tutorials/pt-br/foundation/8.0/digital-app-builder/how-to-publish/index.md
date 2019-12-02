---
layout: tutorial
title: Publicando um aplicativo no IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publicando um aplicativo
{: #dab-app-publish }

Com a opção Publicar, é possível construir e publicar seu aplicativo para Android/iOS no App Center ou Publicar atualizações diretas de seu aplicativo “over-the-air” com recursos da web atualizados.

### Publicando um aplicativo no App Center
{: #dab-app-publish-to-app-center }

O IBM MobileFirst Foundation Application Center é um repositório de aplicativos móveis semelhante a armazenamentos de aplicativos públicos, mas concentrado nas necessidades de uma organização ou equipe. É um armazenamento de aplicativos privado. Para obter informações adicionais sobre o App Center, consulte [aqui](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/).

É possível incluir o aplicativo no repositório no servidor usando a função **Publicar** no Digital App Builder.

>**Nota**: Certifique-se de que seu aplicativo seja construído sem nenhum erro antes de publicar no app center.

1. Em seu projeto de aplicativo, clique em **Publicar**. Isso abrirá um pop-up com as plataformas selecionadas.

    ![Publicar](dab-publish.png)

2. Selecione a **Plataforma** para a qual seu aplicativo precisa ser publicado.

3. Clique em **Soma de verificação da Web** para ativar o recurso de soma de verificação de recursos da web. Para obter mais detalhes, consulte [Ativando o recurso de soma de verificação de recursos da web](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Clique em **Criptografia de recurso da web** para criptografar os recursos da web de seus pacotes Cordova. Para obter mais detalhes, consulte [Criptografando os recursos da web de seus pacotes Cordova](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).

2. Clique em **Publicar no App Center**.

    ![Publicar no App Center](dab-publish-app-center.png)

3. Selecione um App Center existente ou clique em **Conectar novo**. Clique em **Conectar**.
4. Isso irá construir o pacote para a plataforma selecionada.
5. *Somente para iOS*: Edite o arquivo *app-build.json* e atualize o campo `developmentTeam` com seu ID da Equipe de Desenvolvedores Apple. Para saber o ID da Equipe, efetue login na [Conta do desenvolvedor Apple](https://developer.apple.com/account/#/membership). 

    ![Publicar iOS](dab-publish-ios.png)

6. Clique em **Publicar** quando os pacotes estiverem prontos.
7. Na publicação bem-sucedida, o código QR é gerado.

    ![Publicar no código QR do App Center](dab-publish-code-scan.png)

8. É possível verificar se o aplicativo está disponível no App Center efetuando login no **App Center** > **Gerenciamento de aplicativo**.

>**Nota**: É possível selecionar novamente a plataforma necessária e construir e publicar o aplicativo no **App Center**.

### Publicar Atualização Direta
{: #dab-publish-direct-update }

Com a [Atualização direta](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/), os aplicativos Cordova podem ser atualizados “over-the-air” com recursos atualizados da web, como lógica de aplicativo mudada, fixa ou nova (JavaScript), HTML, CSS ou imagens. As organizações são, assim, capazes de assegurar que os usuários finais sempre usem a versão mais recente do aplicativo.

>**Nota**: Certifique-se de que seu aplicativo seja construído sem nenhum erro antes de publicar no app center.

1. Em seu projeto de aplicativo, clique em **Publicar**. Isso abrirá um pop-up com as plataformas selecionadas.

    ![Publicar](dab-publish.png)

2. Selecione a **Plataforma** para a qual seu aplicativo precisa ser publicado.

3. Clique em **Soma de verificação da Web** para ativar o recurso de soma de verificação de recursos da web. Para obter mais detalhes, consulte [Ativando o recurso de soma de verificação de recursos da web](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Clique em **Criptografia de recurso da web** para criptografar os recursos da web de seus pacotes Cordova. Para obter mais detalhes, consulte [Criptografando os recursos da web de seus pacotes Cordova](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).
5. Clique em **Publicar atualização direta**. Aos usuários iniciarem o aplicativo e se conectarem ao servidor Mobile Foundation, um prompt para atualizar os recursos da web aparecerá. Após a confirmação, os recursos da web atualizados estarão disponíveis para o usuário.
