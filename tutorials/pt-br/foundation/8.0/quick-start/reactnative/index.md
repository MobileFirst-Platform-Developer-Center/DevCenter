---
layout: tutorial
title: Demonstração completa do React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O propósito dessa demonstração é explicar um fluxo completo:

1. Um aplicativo de amostra que é pré-empacotado com o SDK do cliente {{ site.data.keys.product_adj }} é registrado e transferido
por download a partir do {{ site.data.keys.mf_console }}.
2. Um adaptador novo ou fornecido é implementado no {{ site.data.keys.mf_console }}.  
3. A lógica de aplicativo é alterada para fazer uma solicitação de recurso.

**Resultado final**:

* Ping de {{ site.data.keys.mf_server }} executado com sucesso.
* Recuperação de dados usando um adaptador executada com sucesso.

### Pré-requisitos:
{: #prerequisites }
* Xcode para iOS, Android Studio para Android
* CLI do React Native
* *Opcional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads))
* *Opcional*. Independente {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### Etapa 1. Iniciando o {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Certifique-se de ter [criado uma instância do Mobile Foundation](../../bluemix/using-mobile-foundation) ou, se estiver usando o [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navegue até a pasta do servidor e execute o comando: `./run.sh` no Mac e no Linux ou `run.cmd` no Windows.

### Etapa 2. Criando e registrando um aplicativo
{: #2-creating-and-registering-an-application }
Abra o {{ site.data.keys.mf_console }} carregando a URL: `http://your-server-host:server-port/mfpconsole` no navegador. Se o servidor estiver sendo executado localmente, use: `http://localhost:9080/mfpconsole`. O *username/password* é **admin/admin**.

1. Clique no botão **Novo** próximo de **Aplicativos**
    * Selecione uma plataforma: **Android, iOS**
    * Insira **com.ibm.mfpstarter.reactnative** como o **identificador do aplicativo**
    * Insira **1.0.0** como a **versão**
    * Clique em **Registrar aplicativo**

    <img class="gifplayer" alt="Registre um aplicativo" src="register-an-application-reactnative.png"/>

2. Faça download do aplicativo React Native de amostra a partir do [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative).

### Etapa 3. Editando a lógica do aplicativo
{: #3-editing-application-logic }
1. Abra o projeto React Native em seu editor de código de escolha.

2. Selecione o arquivo **app.js**, localizado na pasta raiz do projeto, e cole o seguinte fragmento de código, substituindo a função `WLAuthorizationManager.obtainAccessToken()` existente:

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
        resourceRequest.send().then(
          (response) => {
            // Exibirá "Hello world" em um diálogo de alerta.
            alert("Success: " + response.responseText);
          },
          (error) => {
            alert("Failure: " + JSON.stringify(error));
          }
        );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        alert("Failed to connect to MobileFirst Server");
      });
```

### Etapa 4. Implementar um adaptador
{: #4-deploy-an-adapter }
Faça download desse [.adapter artifact](../javaAdapter.adapter) e implemente-o a partir do {{ site.data.keys.mf_console }} usando a ação **Actions → Deploy adapter**.

Como alternativa, clique no botão **Novo** próximo de **Adaptadores**.  

1. Selecione a opção **Ações → Download de Amostra**. Faça download da amostra de adaptador *Hello World* **Java**.

    > Se Maven e {{ site.data.keys.mf_cli }} não estiverem instalados, siga as instruções **Configure seu ambiente de desenvolvimento** na tela.

2. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Maven do adaptador e execute o comando:

    ```bash
    mfpdev adapter build
    ```

3. Quando a compilação for concluída, implemente-a a partir do {{ site.data.keys.mf_console }} usando a ação **Ações → Implementar Adaptador**. O adaptador pode ser localizado na pasta **[adapter]/target**.

    <img class="gifplayer" alt="Implemente um adaptador" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="aplicativo de amostra" style="float:right"/>

### Etapa 5. Testando o aplicativo
{: #5-testing-the-application }
1.  Certifique-se de ter instalado o {{ site.data.keys.mf_cli }} e, em seguida, navegue até a pasta raiz da plataforma específica (iOS ou Android) e execute o comando `mfpdev app register`. Se um {{ site.data.keys.mf_server }} remoto for usado, [execute o comando](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para incluir o servidor,
```bash
Servidor mfpdev add
```
seguido do comando para regisrar o aplicativo, por exemplo:
```bash
mfpdev app register myIBMCloudServer
```
2. Execute o seguinte comando para executar o aplicativo:
```bash
react-native run-ios|run-android
```

Se um dispositivo estiver conectado, o aplicativo será instalado e ativado no dispositivo. Caso contrário, o simulador ou emulador será usado.

<br clear="all"/>
### Resultados
{: #results }
* Clicar no botão **Ping {{ site.data.keys.mf_server }}** exibe **Conectado ao {{ site.data.keys.mf_server }}**.
* Se o aplicativo foi capaz de se conectar ao {{site.data.keys.mf_server }}, uma chamada de solicitação de recurso usando o adaptador Java implementado ocorrerá. A resposta do adaptador é então exibida em um alerta.

## Etapas Seguintes
{: #next-steps }
Saiba mais sobre como usar adaptadores em aplicativos e como integrar serviços adicionais, como Notificações Push, usando a estrutura de segurança do {{ site.data.keys.product_adj }} e mais:

- Revise os tutoriais [Desenvolvimento de Aplicativo](../../application-development/)
- Revise os tutoriais [Desenvolvimento de Adaptadores](../../adapters/)
- Revise os tutoriais [Autenticação e Segurança](../../authentication-and-security/)
- Revise os tutoriais [Notificações](../../notifications/)
- Revise [Todos os Tutoriais](../../all-tutorials)
