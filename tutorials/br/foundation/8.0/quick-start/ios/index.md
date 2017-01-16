---
layout: tutorial
title: Demonstração de ponta a ponta do iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral (Overview)
{: #overview }
O propósito desta demonstração é experimentar um fluxo de ponta a ponta:

1. Um aplicativo de amostra que é pré-empacotado com o SDK do cliente {{site.data.keys.product_adj }} é registrado e transferido
por download a partir do {{site.data.keys.mf_console }}.
2. Um adaptador novo ou fornecido é implementado no {{site.data.keys.mf_console }}.  
3. A lógica de aplicativo é alterada para fazer uma solicitação de recurso.

**Resultado final**:

* Ping de {{site.data.keys.mf_server }} executado com sucesso.
* Recuperação de dados usando adaptador realizada com sucesso.

#### Pré-requisitos:
{: #prerequisites }
* Xcode
* *Opcional*. {{site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads))
* *Opcional*. Independente {{site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### 1. Iniciando o {{site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Certifique-se de ter [criado uma instância do Mobile Foundation](../../bluemix/using-mobile-foundation) ou  
Se estiver usando [{{site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navegue
para a pasta do servidor e execute o comando: `./run.sh` em Mac e Linux ou `run.cmd` no Windows.

### 2. Criando um aplicativo
{: #2-creating-an-application }
Em uma janela do navegador, abra {{site.data.keys.mf_console }} carregando a URL:
`http://your-server-host:server-port/mfpconsole`. Se estiver executando localmente, use:
[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). O nome de usuário/senha são *admin/admin*.
 
1. Clique no botão **Novo** próximo de **Aplicativos**
    * Selecione a plataforma **iOS**
    * Insira **com.ibm.mfpstarteriosobjectivec** ou **com.ibm.mfpstarteriosswift** como o
**identificador do aplicativo** (dependendo do andaime do aplicativo do qual você fará download na próxima etapa)
    * Insira **1.0** como o valor da **versão**
    * Clique em **Registrar aplicativo**
    
    <img class="gifplayer" alt="Registre um aplicativo" src="register-an-application-ios.png"/>
 
2. Clique no quadro **Obter Código de Início** e selecione para fazer download do aplicativo de amostra iOS Objective-C
ou iOS Swift.

    <img class="gifplayer" alt="Download do aplicativo de amostra" src="download-starter-code-ios.png"/>
    
### 3. Editando a lógica de aplicativo
{: #3-editing-application-logic }
1. Abra o projeto Xcode dando um clique duplo no arquivo **.xcworkspace**.

2. Selecione o arquivo **[project-root]/ViewController.m/swift** e cole o fragmento de código a seguir, substituindo
a função `getAccessToken()` existente:
 
   No Objective-C:

   ```objc
   - (IBAction)getAccessToken:(id)sender {
   _testServerButton.enabled = NO;
   NSURL *serverURL = [[WLClient sharedInstance] serverUrl];
   _connectionStatusLabel.text = [NSString stringWithFormat:@"Connecting to server...\n%@", serverURL];
    
   NSLog(@"Testing Server Connection");
   [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:@"" withCompletionHandler:^(AccessToken *token, NSError *error) {
        if (error != nil) {
            _titleLabel.text = @"Bummer...";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Failed to connect to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Did not receive an access token from server: %@", error.description);
        } else {
            _titleLabel.text = @"Yay!";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Connected to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Received the following access token value: %@", token.value);
            
            NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/resource/greet/"];
            WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
            
            [request setQueryParameterValue:@"world" forName:@"name"];
            [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                if (error != nil){
                    NSLog(@"Failure: %@",error.description);
                }
                else if (response != nil){
                    // Imprimirá "Hello world" no Xcode Console.
                    NSLog(@"Success: %@",response.responseText);
                }
            }];
        }

        _testServerButton.enabled = YES;
    }];
}
   ```
    
   No Swift:
    
   ```swift
   @IBAction func getAccessToken(sender: AnyObject) {
        self.testServerButton.enabled = false
        
        let serverURL = WLClient.sharedInstance().serverUrl()
        
        connectionStatusLabel.text = "Connecting to server...\n\(serverURL)"
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in
            
            if (error != nil) {
                self.titleLabel.text = "Bummer..."
                self.connectionStatusLabel.text = "Failed to connect to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Did not recieve an access token from server: " + error.description)
            } else {
                self.titleLabel.text = "Yay!"
                self.connectionStatusLabel.text = "Connected to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Recieved the following access token value: " + token.value)
                
                let url = NSURL(string: "/adapters/javaAdapter/resource/greet/")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)
                
                request.setQueryParameterValue("world", forName: "name")
                request.sendWithCompletionHandler { (response, error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }
            
            self.testServerButton.enabled = true
        }
   }
   ```

### 4. Implemente um adaptador
{: #4-deploy-an-adapter }
Faça o download [deste artefato .adapter preparado](../javaAdapter.adapter) e implemente-o a partir do
{{site.data.keys.mf_console }} usando a ação **Ações → Implementar Adaptador**.

Como alternativa, clique no botão **Novo** próximo de **Adaptadores**.  
        
1. Selecione a opção **Ações → Download de Amostra**. Faça o download da amostra do adaptador **Java** "Hello World".

   > Se o Maven e o {{site.data.keys.mf_cli }} não estiverem instalados, siga as instruções **Configure seu ambiente de
desenvolvimento** na tela.

2. Em uma janela de **Linha de Comandos**, navegue para a pasta raiz do projeto Maven do adaptador e execute o comando:

   ```bash
   mfpdev adapter build
   ```

3. Quando a compilação for concluída, implemente-a a partir do {{site.data.keys.mf_console }} usando a ação **Ações →
Implementar Adaptador**. O adaptador pode ser localizado na pasta **[adapter]/target**. 

    <img class="gifplayer" alt="Implemente um adaptador" src="create-an-adapter.png"/>   

<img src="iosQuickStart.png" alt="aplicativo de amostra" style="float:right"/>
### 5. Testando o aplicativo
{: #5-testing-the-application }
1. No Xcode, selecione o arquivo **mfpclient.plist** e edite as propriedades **protocol**,
**host** e **port** com os valores corretos para seu {{site.data.keys.mf_server }}.
    * Se estiver usando um {{site.data.keys.mf_server }} local, os valores normalmente serão **http**,
**localhost** e **9080**.
    * Se estiver usando um {{site.data.keys.mf_server }} remoto (no Bluemix), os valores normalmente serão
**https**, **your-server-address** e **443**.
     
    Como alternativa, se você tiver instalado {{site.data.keys.mf_cli }}, navegue para a pasta raiz do projeto e execute o comando
`mfpdev app register`. Se um {{site.data.keys.mf_server }} remoto for usado,
[execute o comando
mfpdev server add](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para incluir o servidor, seguido por, por exemplo: mfpdev app
register
myBluemixServer`.

2. Pressione o botão **Reproduzir**.

<br clear="all"/>
### Resultados
{: #results }
* Um clique no botão **Ping {{site.data.keys.mf_server }}** exibirá **Conectado ao
{{site.data.keys.mf_server }}**.
* Se o aplicativo foi capaz de se conectar ao {{site.data.keys.mf_server }}, uma chamada de solicitação de recurso usando o
adaptador Java implementado acontecerá.

A resposta do adaptador é então impressa no Xcode Console.

![Imagem do aplicativo que chamou um recurso do {{site.data.keys.mf_server }} ](success_response.png) com sucesso

## Etapas Seguintes
{: #next-steps }
Saiba mais sobre como usar adaptadores em aplicativos e como integrar serviços adicionais, como Notificações Push, usando a estrutura de
segurança do {{site.data.keys.product_adj }} e mais:

- Revise os tutoriais [Desenvolvimento de Aplicativo](../../application-development/)
- Revise os tutoriais [Desenvolvimento de Adaptadores](../../adapters/)
- Revise os tutoriais [Autenticação e Segurança](../../authentication-and-security/)
- Revise os tutoriais [Notificações](../../notifications/)
- Revise [Todos os Tutoriais](../../all-tutorials)
