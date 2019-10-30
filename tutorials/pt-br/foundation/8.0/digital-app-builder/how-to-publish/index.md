---
layout: tutorial
title: Publicando um aplicativo no IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publicando um aplicativo no App Center
{: #dab-app-publish }

O IBM MobileFirst Foundation Application Center é um repositório de aplicativos móveis semelhante a armazenamentos de aplicativos públicos, mas concentrado nas necessidades de uma organização ou equipe. É um armazenamento de aplicativos privado. Para obter informações adicionais sobre o App Center, consulte [aqui](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/).

É possível incluir o aplicativo no repositório no servidor usando a função **Publicar** no Digital App Builder.

>**Nota**: Certifique-se de que seu aplicativo seja construído sem nenhum erro antes de publicar no app center.

1. Em seu projeto de aplicativo, clique em **Publicar**. Isso abrirá um pop-up com as plataformas selecionadas.

    ![Publicar](dab-publish.png)

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

