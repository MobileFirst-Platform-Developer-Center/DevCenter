---
layout: tutorial
title: Demonstração completa do Ionic
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O propósito dessa demonstração é explicar um fluxo completo. As etapas a seguir são executadas.

1. Um aplicativo de amostra que é pré-empacotado com o SDK do cliente {{ site.data.keys.product_adj }} é registrado e transferido
por download a partir do {{ site.data.keys.mf_console }}.
2. Um adaptador novo ou fornecido é implementado no {{ site.data.keys.mf_console }}.  
3. A lógica de aplicativo é alterada para fazer uma solicitação de recurso.

**Resultado final**:

* Ping de {{ site.data.keys.mf_server }} executado com sucesso.
* Recuperação de dados usando um adaptador executada com sucesso.

### Pré-requisitos:
{: #prerequisites }
* Xcode para iOS, Android Studio para Android ou Visual Studio 2015 ou superior para Windows 10 UWP
* CLI do Ionic
* *Opcional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads)).
* *Opcional*. {{ site.data.keys.mf_server }} independente ([download]({{site.baseurl}}/downloads)).

### Etapa 1. Iniciando o {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Certifique-se de ter [criado uma instância do Mobile Foundation](../../bluemix/using-mobile-foundation) ou, se estiver usando o [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navegue até a pasta do servidor e execute o comando: `./run.sh` no Mac e no Linux ou `run.cmd` no Windows.

### Etapa 2. Criando e registrando um aplicativo
{: #2-creating-and-registering-an-application }
Abra o {{site.data.keys.mf_console }} carregando a URL: `http://your-server-host:server-port/mfpconsole` em um navegador. Se o servidor estiver sendo executado localmente, use: `http://localhost:9080/mfpconsole`. O *username/password* é **admin/admin**.

1. Clique no botão **Novo** próximo de **Aplicativos**
    * Selecione uma plataforma na lista de plataformas: **Android, iOS, Windows, Navegador**
    * Insira **com.ibm.mfpstarterionic** como o **identificador do aplicativo**
    * Insira **1.0.0** como a **versão**
    * Clique em **Registrar aplicativo**

    <img class="gifplayer" alt="Registre um aplicativo" src="register-an-application-ionic.png"/>

2. Faça download do aplicativo Ionic de amostra a partir do [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic).

### Etapa 3: Incluindo o SDK do MobileFirst no aplicativo Ionic
{: #adding_mfp_ionic_sdk}

Siga as etapas abaixo para incluir o SDK MobileFirst do Ionic no aplicativo de amostra Ionic transferido por download.

1. Navegue até a raiz de seu projeto Ionic existente e inclua o plug-in Ionic Cordova principal {{ site.data.keys.product_adj }}.

2. Mude o diretório para a raiz do projeto Ionic: `cd MFPStarterIonic`

3. Inclua os Plug-ins do MobileFirst usando o comando da CLI do Ionic: `ionic cordova plugin add cordova-plugin-name`
Por exemplo:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > O comando acima inclui o plug-in do SDK principal do MobileFirst no projeto Ionic.

4. Inclua uma ou mais plataformas suportadas no projeto Cordova usando o comando da CLI do Ionic: `ionic cordova platform add ios|android|windows|browser`. Por
exemplo:

   ```bash
   cordova platform add ios
   ```

5. Prepare os recursos do aplicativo executando o comando ` ionic cordova prepare `:

   ```bash
   ionic cordova prepare
   ```

### Etapa 4. Editando a lógica do aplicativo
{: #3-editing-application-logic }
1. Abra o projeto Ionic no editor de código de sua escolha.

2. Selecione o arquivo **src/js/index.js** e cole o seguinte fragmento de código, substituindo a função `WLAuthorizationManager.obtainAccessToken()` existente:

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
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
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### Etapa 5. Implementar um adaptador
{: #4-deploy-an-adapter }
Faça download desse [.adapter artifact](../javaAdapter.adapter) e implemente-o a partir do {{ site.data.keys.mf_console }} usando a ação **Actions  → Deploy adapter**.

Como alternativa, clique no botão **Novo** próximo de **Adaptadores**.  

1. Selecione a opção **Ações → Download de Amostra**. Faça download da amostra de adaptador *Hello World* **Java**.

    > Se Maven e {{ site.data.keys.mf_cli }} não estiverem instalados, siga as instruções **Configure seu ambiente de desenvolvimento** na tela.

2. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Maven do adaptador e execute o comando:

    ```bash
    mfpdev adapter build
    ```

3. Quando a compilação for concluída, implemente-a a partir do {{ site.data.keys.mf_console }} usando a ação **Ações → Implementar Adaptador**. O adaptador pode ser localizado na pasta **[adapter]/target**.

    <img class="gifplayer" alt="Implemente um adaptador" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="aplicativo de amostra" style="float:right"/>

### Etapa 6. Testando o aplicativo
{: #5-testing-the-application }
1. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Cordova:
2. Execute o comando: `ionic cordova platform add ios|android|windows|browser` para incluir uma plataforma.
3. No projeto Ionic, selecione o arquivo **config.xml** e edite o `<mfp:server ... url=" "/>` valor com as propriedades **protocolo**, **host** e **porta** com os valores corretos para o seu {{ site.data.keys.mf_server }}.
    * Se estiver usando um {{ site.data.keys.mf_server }} local, os valores normalmente serão **http**, **localhost** e **9080**.
    * Se você estiver usando um {{ site.data.keys.mf_server }} remoto (no IBM Cloud), normalmente os valores serão **https**, **your-server-address** e **443**.
    * Se você estiver usando um cluster do Kubernetes no IBM Cloud Private, e se a implementação for do tipo **NodePort**, normalmente o valor da porta será **NodePort**, exposto pelo serviço no cluster do Kubernetes.

    Como alternativa, se você tiver instalado {{ site.data.keys.mf_cli }}, navegue para a pasta raiz do projeto e execute o comando
`mfpdev app register`. Se um {{ site.data.keys.mf_server }} remoto for usado, [execute o comando](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)
    ```bash
    mfpdev server add
    ```
     para incluir o servidor, seguido do comando para registrar o aplicativo, por exemplo:
    ```bash
    mfpdev app register myIBMCloudServer
    ```

Se um dispostivo estiver conectado, o aplicativo será instalado e ativado no dispostivo.
Caso contrário, o simulador ou emulador será usado.

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
