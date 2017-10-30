---
layout: tutorial
title: Demonstração de ponta a ponta do Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O propósito desta demonstração é experimentar um fluxo de ponta a ponta:

1. Um aplicativo de amostra que é pré-empacotado com o SDK do cliente {{ site.data.keys.product_adj }} é registrado e transferido por download a partir do {{ site.data.keys.mf_console }}.
2. Um adaptador novo ou fornecido é implementado no {{ site.data.keys.mf_console }}.  
3. A lógica de aplicativo é alterada para fazer uma solicitação de recurso.

**Resultado final**:

* Ping de {{ site.data.keys.mf_server }} executado com sucesso.
* Recuperação de dados usando adaptador realizada com sucesso.

#### Pré-requisitos:
{: #prerequisites }
* Xcode for iOS, Android Studio for Android ou Visual Studio 2013/2015 for Windows 8.1 Universal/Windows 10 UWP
* Cordova CLI 6.x.
* *Opcional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads))
* *Opcional*. Independente {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### 1. Iniciando o {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Certifique-se de ter [criado uma instância do Mobile Foundation](../../bluemix/using-mobile-foundation) ou  
Se estiver usando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navegue para a pasta do servidor e execute o comando: `./run.sh` em Mac e Linux ou `run.cmd` no Windows.

### 2. Criando e registrando um aplicativo
{: #2-creating-and-registering-an-application }
Em uma janela do navegador, abra {{ site.data.keys.mf_console }} carregando a URL: `http://your-server-host:server-port/mfpconsole`. Se estiver executando localmente, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). O nome de usuário/senha são *admin/admin*.
 
1. Clique no botão **Novo** próximo de **Aplicativos**
    * Selecione uma plataforma: **Android, iOS, Windows**
    * Insira **com.ibm.mfpstartercordova** como o **identificador do aplicativo**
    * Insira **1.0.0** como a **versão**
    * Clique em **Registrar aplicativo**

    <img class="gifplayer" alt="Registre um aplicativo" src="register-an-application-cordova.png"/>
 
2. Clique no quadro **Obter Código de Início** e selecione para fazer download do aplicativo de amostra Cordova.

    <img class="gifplayer" alt="Download do aplicativo de amostra" src="download-starter-code-cordova.png"/>
 
### 3. Editando a lógica de aplicativo
{: #3-editing-application-logic }
1. Abra o projeto Cordova no editor de código escolhido.

2. Selecione o arquivo **www/js/index.js** e cole o fragmento de código a seguir, substituindo a função
`WLAuthorizationManager.obtainAccessToken()` existente:

```javascript
WLAuthorizationManager.obtainAccessToken()
    .then(
        function(accessToken) {
            titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
            
            var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );
            
            resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                    // Exibirá "Hello world" em um diálogo de alerta.
                    alert("Success: " + response.responseText);
                },
                function(response) {
                    alert("Failure: " + JSON.stringify(response));
                }
            );
        },

        function(error) {
            titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
    );
```
    
### 4. Implemente um adaptador
{: #4-deploy-an-adapter }
Faça o download [deste artefato .adapter preparado](../javaAdapter.adapter) e implemente-o a partir do
{{ site.data.keys.mf_console }} usando a ação **Ações → Implementar Adaptador**.

Como alternativa, clique no botão **Novo** próximo de **Adaptadores**.  
        
1. Selecione a opção **Ações → Download de Amostra**. Faça o download da amostra do adaptador **Java** "Hello World".

    > Se o Maven e o {{ site.data.keys.mf_cli }} não estiverem instalados, siga as instruções **Configure seu ambiente de desenvolvimento** na tela.

2. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Maven do adaptador e execute o comando:

    ```bash
    mfpdev adapter build
    ```

3. Quando a compilação for concluída, implemente-a a partir do {{ site.data.keys.mf_console }} usando a ação **Ações → Implementar Adaptador**. O adaptador pode ser localizado na pasta **[adapter]/target**.
    
    <img class="gifplayer" alt="Implemente um adaptador" src="create-an-adapter.png"/>   


<img src="cordovaQuickStart.png" alt="aplicativo de amostra" style="float:right"/>
### 5. Testando o aplicativo
{: #5-testing-the-application }
1. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Cordova:
2. Execute o comando: `cordova platform add ios|android|windows` para incluir uma plataforma.
3. O projeto Cordova, selecione o arquivo **config.xml** e edite o `<mfp:server ... url=" "/>` valor com as propriedades **protocolo**, **host** e **porta** com os valores corretos para o seu {{ site.data.keys.mf_server }}.
    * Se estiver usando um {{ site.data.keys.mf_server }} local, os valores normalmente serão **http**, **localhost** e **9080**.
    * Se estiver usando um {{ site.data.keys.mf_server }} remoto (no Bluemix), os valores normalmente serão
**https**, **your-server-address** e **443**.

    Como alternativa, se você tiver instalado {{ site.data.keys.mf_cli }}, navegue para a pasta raiz do projeto e execute o comando
`mfpdev app register`. Se um {{ site.data.keys.mf_server }} remoto for usado, [execute o comando `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para incluir o servidor, seguido por, por exemplo: `mfpdev app register myBluemixServer`.
	
Se um dispositivo estiver conectado, o aplicativo será instalado e ativado no dispositivo.  
Caso contrário, o Simulador ou Emulador será usado.

<br clear="all"/>
### Resultados
{: #results }
* Um clique no botão **Ping {{ site.data.keys.mf_server }}** exibirá **Conectado ao
{{ site.data.keys.mf_server }}**.
* Se o aplicativo foi capaz de se conectar ao {{ site.data.keys.mf_server }}, uma chamada de solicitação de recurso usando o adaptador Java implementado acontecerá.

A resposta do adaptador é então exibida em um alerta.

## Etapas Seguintes
{: #next-steps }
Saiba mais sobre como usar adaptadores em aplicativos e como integrar serviços adicionais, como Notificações Push, usando a estrutura de segurança do {{ site.data.keys.product_adj }} e mais:

- Revise os tutoriais [Desenvolvimento de Aplicativo](../../application-development/)
- Revise os tutoriais [Desenvolvimento de Adaptadores](../../adapters/)
- Revise os tutoriais [Autenticação e Segurança](../../authentication-and-security/)
- Revise os tutoriais [Notificações](../../notifications/)
- Revise [Todos os Tutoriais](../../all-tutorials)
