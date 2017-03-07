---
layout: tutorial
title: Configurando o ambiente de desenvolvimento da web
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Desenvolver e testar aplicativos da web é tão fácil quanto visualizar um arquivo HTML local no navegador da web de sua escolha.  
Os desenvolvedores podem usar o IDE de sua escolha e quaisquer estruturas que atendam suas necessidades.

No entanto, uma coisa pode barrar o caminho de desenvolvimento de aplicativos da web. Os aplicativos da web podem encontrar erros devido à violação da [política de mesma origem](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy). A política de mesma origem é uma restrição imposta em navegadores da web. Por exemplo, se um aplicativo for hospedado no domínio **example.com**, não será permitido que o mesmo aplicativo também acesse o conteúdo que está disponível em outro servidor, ou neste caso, no {{ site.data.keys.mf_server }}.

[Os aplicativos da web que devem usar o SDK da web do {{ site.data.keys.product }}](../../../application-development/sdk/web) devem ser manipulados em uma topologia de suporte, por exemplo, usando um proxy reverso para redirecionar internamente solicitações para o servidor apropriado enquanto mantém a mesma origem única.

Os requisitos de política podem ser preenchidos usando qualquer um dos seguintes métodos:

- Entregando os recursos de aplicativo da web do mesmo servidor de aplicativos de perfil Completo/Liberty do WebSphere que também hospeda o {{ site.data.keys.mf_server }}.
- Usando Node.js como um proxy para redirecionar solicitações de aplicativos para o {{ site.data.keys.mf_server }}.

#### Ir para
{: #jump-to }
- [Pré-requisito](#prerequisites)
- [Usando o perfil Liberty do WebSphere para entregar os recursos de aplicativo da web ](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [Usando Node.js](#using-nodejs)
- [Próximas Etapas](#next-steps)

## Pré-Requisitos
{: #prerequisites }
-   {: #web-app-supported-browsers }
    Os aplicativos da web são suportados para as seguintes versões de navegador. Os números de versão indicam a versão mais antiga integralmente suportada do navegador respectivo.

    | Navegador               | Chrome   | Safari<sup>*</sup>   | Internet Explorer   | Firefox   | Android Browser   |
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **Versão Suportada** |  {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> No Safari, o modo de navegação privada é suportado apenas para aplicativos de página única (SPAs). Outros aplicativos podem apresentar comportamento inesperado.

    {% comment %} [sharonl][c-web-browsers-ms-edge] Veja informações sobre o suporte do Microsoft Edge na Tarefa 111165. {% endcomment %}

-   As instruções de configuração a seguir requerem a instalação do Apache Maven ou do Node.js na estação de trabalho do desenvolvedor. Para obter instruções adicionais, consulte o [guia de instalação](../mobilefirst/installation-guide/).

## Usando o perfil Liberty do WebSphere para entregar os recursos de aplicativo da web
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
Para entregar os recursos de aplicativo da web, eles precisam ser armazenados em um aplicativo da web Maven (um arquivo **.war**).

### Criando um archetype de aplicativo da web Maven
{: #creating-a-maven-webapp-archetype }
1. Em uma janela de **linha de comandos**, navegue para um local de sua escolha.
2. Execute o comando:

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - Substitua **MyCompany** e **MyWebApp** por seus próprios valores.
    - Para inserir os valores, um a um, remova a sinalização `-DinteractiveMode=false`.

### Construindo o aplicativo da web Maven com os recursos do aplicativo da web 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. Coloque os recursos do aplicativo da web (como HTML, CSS, JavaScript e arquivos de imagem) dentro da pasta gerada **[MyWebApp] → src → Main → webapp**.

    > A partir de agora, considere a pasta **webapp** como o local de desenvolvimento para o aplicativo da web.

2. Execute o comando: `mvn clean install` para gerar um arquivo .war contendo os recursos da web do aplicativo.  
   O arquivo .war gerado está disponível na pasta **[MyWebApp] → target**.
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** `mvn clean install` deve ser executado sempre que você atualizar um recurso da web.

### Incluindo o aplicativo da web Maven no servidor de aplicativos
{: #adding-the-maven-webapp-to-the-application-server }
1. Edite o **arquivo server.xml** do servidor de aplicativos WebSphere.  
    Se estiver usando o {{ site.data.keys.mf_dev_kit }}, o arquivo será localizado na pasta: [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp**. Inclua a seguinte entrada:

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - Substitua **name** e **path-to/MyWebApp.war** por seus próprios valores.
    - O servidor de aplicativos é reiniciado automaticamente após salvar as mudanças no arquivo **server.xml**.  

### Testando o aplicativo da web
{: #testing-the-web-application }
Quando estiver pronto para testar seu aplicativo da web, visite a URL: **localhost:9080/MyWebApp**.
    - Substitua **MyWebApp** por seu próprio valor.

## Usando Node.js
{: #using-nodejs }
O Node.js pode ser usado como um proxy reverso para canalizar solicitações do aplicativo da web para o {{ site.data.keys.mf_server }}.

1. Em uma janela de **linha de comandos**, navegue para a pasta do aplicativo da web e execute o seguinte conjunto de comandos: 

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. Crie um novo arquivo na pasta **node_modules**, por exemplo, **proxy.js**.
3. Adicione os seguintes códigos ao arquivo:

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Servidor da web - atende o aplicativo da web
   app.get('/home', function(req, res) {
        // Website com o qual você deseja permitir conexão
        res.sendFile(__dirname + '/index.html');
   });

   // Proxy reverso, canaliza as solicitações para/de {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - substitua o valor **port** pelo seu preferencial.
    - substitua `/myapp` pelo nome de caminho preferencial para seu aplicativo da web.
    - substitua `/index.html` pelo nome de seu arquivo HTML principal.
    - se necessário, atualize `/mfp/*` com a raiz de contexto do tempo de execução do {{ site.data.keys.product }}.

4. Para iniciar o proxy, execute o comando: `node proxy.js`.
5. Quando estiver pronto para testar seu aplicativo da web, visite a URL: **server-hostname:port/app-name**, por exemplo: **http://localhost:9081/myapp**
    - Substitua **server-hostname** por seu próprio valor.
    - Substitua **port** por seu próprio valor.
    - Substitua **app-name** por seu próprio valor.

## Etapas seguintes
{: #next-steps }
Para continuar com o desenvolvimento do {{ site.data.keys.product }} em aplicativos da web, o SDK da web do {{ site.data.keys.product }} precisa ser incluído no aplicativo da web.

* Saiba como incluir o SDK do [{{ site.data.keys.product }} em aplicativos da web](../../../application-development/sdk/web/).
* Para desenvolvimento de aplicativos, consulte os tutoriais [Usando o SDK do {{ site.data.keys.product }}](../../../application-development/).
* Para desenvolvimento de adaptadores, consulte a categoria [Adaptadores](../../../adapters/).
