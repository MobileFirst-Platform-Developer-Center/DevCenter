---
layout: tutorial
title: O que há de novo nas correções temporárias
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
As correções temporárias fornecem correções e atualizações para corrigir problemas e manter o {{ site.data.keys.product_full }} atual para novas liberações de sistemas operacionais de dispositivo móvel.

As correções temporárias são acumulativas. Ao fazer download da correção temporária mais recente da v8.0, você obtém todas as correções das correções temporárias anteriores.

Faça download e instale a correção temporária mais recente para obter todas as correções descritas nas seções a seguir. Se você instalar correções anteriores, pode ser que não obtenha todas as correções descritas aqui.

> Para obter uma lista de liberações de iFix do {{ site.data.keys.product }} 8.0, [veja aqui]({{site.baseurl}}/blog/tag/iFix_8.0/).

Quando um número de APAR estiver listado, será possível confirmar se uma correção temporária tem esse recurso procurando o número do APAR no arquivo LEIA-ME da correção temporária.

### Recursos introduzidos com o CD Update 3 (8.0.0.0-MFPF-IF201811050432-CDUpdate-03)

##### <span style="color:NAVY">**Suporte para tokens de atualização no iOS**</span>

O Mobile Foundation introduz o recurso de token de atualização no iOS iniciando com este CD Update. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Fazer download da CLI do administrador (*mfpadm*) por meio do console do Mobile Foundation**</span>

A CLI do administrador do Mobile Foundation (*mfpadm*) agora pode ser transferida por download de dentro do *Centro de download* do console do Mobile Foundation.

##### <span style="color:NAVY">**Suporte para Node v8.x para a CLI do MobileFirst** </span>

Iniciando neste iFix (*8.0.0.0-MFPF-IF201810040631*), o Mobile Foundation inclui suporte para Node v8.x para a CLI do MobileFirst.

##### <span style="color:NAVY">**Remover dependência do *libstdc++* para projetos Cordova**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF201809041150*), uma mudança para remover *libstdc++* como uma dependência para projetos Cordova foi introduzida. Isso é necessário para novos apps em execução no iOS 12. Para obter detalhes adicionais, como uma solução alternativa, consulte [esta postagem do blog](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/).

### Recursos introduzidos com o CD Update 2 (8.0.0.0-MFPF-IF201807180449-CDUpdate-02)

##### <span style="color:NAVY">**Suporte para desenvolvimento do React Native**</span>

Iniciando com o CD Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), o Mobile Foundation [anuncia]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/) o suporte para desenvolvimento do React Native com a disponibilidade do SDK do IBM Mobile Foundation para apps React Native. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).

##### <span style="color:NAVY">**Sincronização automatizada de coleções JSONStore com bancos de dados CouchDB para SDK do iOS e Cordova**</span>

Iniciando com o CD Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), usando o SDK do MobileFirst iOS e o SDK do Cordova, é possível automatizar a sincronização de dados entre uma Coleção JSONStore em um dispositivo com qualquer tipo de banco de dados CouchDB, incluindo [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). Para obter mais informações sobre esse recurso, leia esta [postagem do blog]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/).

##### <span style="color:NAVY">**Introduzindo tokens de atualização** </span>

Iniciando com o CD Update (*8.0.0.0-MFPF-IF201804180449-CDUpdate-02*), o Mobile Foundation agora introduz um tipo especial de token, chamado token de Atualização, que pode ser usado para solicitar um novo token de acesso. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Suporte para Cordova v8 e Cordova Android v7**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF201804051553*), os plug-ins do MobileFirst Cordova para Cordova v8 e Cordova Android v7 são suportados. Para trabalhar com a versão mencionada do Cordova, é necessário obter os plug-ins MobileFirst mais recentes e fazer upgrade para a versão mais recente da CLI (mfpdev-cli). Para obter detalhes sobre as versões suportadas para plataformas individuais, consulte [Incluindo o SDK do MobileFirst Foundation em aplicativos Cordova]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Sincronização automatizada de coleções JSONStore com bancos de dados CouchDB**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF201802201451*), usando o SDK do MobileFirst Android, é possível automatizar a sincronização de dados entre uma Coleção JSONStore em um dispositivo com qualquer tipo de banco de dados CouchDB, incluindo [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). Para obter mais informações sobre esse recurso, leia esta [postagem do blog]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).

### Recursos introduzidos com o CD Update 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01)

##### <span style="color:NAVY">**Suporte para o editor de UI do Eclipse**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o editor WYSIWYG é agora fornecido no Eclipse do MobileFirst Studio. Os desenvolvedores podem projetar e implementar a UI para seus aplicativos Cordova usando esse editor de UI. [Saiba mais](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**Novos adaptadores para construção de apps cognitivos**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o Mobile Foundation introduziu dois novos adaptadores de serviços cognitivos pré-construídos para os serviços [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) e [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator). Esses adaptadores estão disponíveis para serem transferidos por download e implementados por meio do *Centro de download* no Mobile Foundation Console.

##### <span style="color:NAVY">**Autenticidade de app dinâmico**</span>

Iniciando com o iFix *8.0.0.0-MFPF-IF20170220-1900*, uma nova implementação de *autenticidade do aplicativo* é fornecida. Essa implementação não requer a ferramenta off-line *mfp-authenticity-authenticity* para gerar o arquivo *.authenticity_data*. Em vez disso, é possível ativar ou desativar a *autenticidade do aplicativo* por meio do console do MobileFirst. Para obter mais informações, veja [Configurando a autenticidade do aplicativo](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity).

##### <span style="color:NAVY">**Suporte do Appcenter (cliente e servidor) para Windows 10**</span>

Iniciando com o iFix *8.0.0.0-MFPF-IF20170327-1055*, os apps UWP do Windows 10 são suportados no IBM Application Center. O usuário agora pode fazer upload dos apps UWP do Windows 10 e instalar de forma idêntica em seu dispositivo. O projeto do cliente UWP do Windows 10 para instalar o app UWP agora é enviado com o Application Center. É possível abrir o projeto no Visual Studio e criar um binário (por exemplo, *.appx*) para distribuição. O Application Center não fornece um método predefinido de distribuição do cliente móvel. Para obter mais informações, veja [Cliente IBM AppCenter do Microsoft Windows 10 Universal (nativo)](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

##### <span style="color:NAVY">**Suporte ao plug-in do MobileFirst Eclipse para o Eclipse Neon**</span>

Iniciando com o iFix *8.0.0.0-MFPF-IF20170426-1210*, o plug-in do MobileFirst Eclipse é atualizado para suportar o Eclipse Neon.

##### <span style="color:NAVY">**SDK do Android modificado para usar uma versão mais recente de OkHttp (versão 3.4.1)**</span>

Iniciando com o iFix *8.0.0.0-MFPF-IF20170605-2216*, o Android SDK foi modificado para usar uma versão mais recente do *OkHttp (versão 3.4.1)* em vez da versão antiga que foi empacotada anteriormente com o SDK do MobileFirst para Android. O OkHttp é incluído como uma dependência em vez de ser empacotado com o SDK. Isso permite a liberdade de escolha no uso da biblioteca OkHttp para desenvolvedores e também evita conflitos com múltiplas versões de OkHttp.

##### <span style="color:NAVY">**Suporte para Cordova v7**</span>

Iniciando com o iFix *8.0.0.0-MFPF-IF20170608-0406*, o Cordova v7 é suportado. Para obter detalhes sobre as versões suportadas de plataformas individuais, consulte [Incluindo o SDK do MobileFirst Foundation em aplicativos Cordova](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

##### <span style="color:NAVY">**Suporte à fixação de múltiplos certificados** </span>

Iniciando com o iFix (* 8.0.0.0-MFPF-IF20170624-0159 *), o Mobile Foundation suporta a fixação de múltiplos certificados. Antes desse iFix, a Mobile Foundation suportava a fixação de um único certificado. O Mobile Foundation introduziu uma nova API, que permite a conexão com múltiplos hosts, permitindo que o usuário fixe chaves públicas de múltiplos certificados X509 para o aplicativo cliente. Esse recurso é suportado somente para apps Android e iOS nativos. Saiba mais sobre *Suporte à fixação de múltiplos certificados* em [O que há de novo](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), sob a seção *O que há de novo nas APIs do MobileFirst*.

##### <span style="color:NAVY">**Adaptadores para construir um app cognitivo**</span>

Iniciando com o iFix (*8.0.0.0-MFPF-IF20170710-1834*), o Mobile Foundation introduziu adaptadores pré-construídos para serviços cognitivos do Watson, como [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter) e [*WatsonNLU (Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter). Esses adaptadores estão disponíveis para serem transferidos por download e implementados por meio do *Centro de download* no Console do Mobile Foundation.

##### <span style="color:NAVY">**Adaptador do Cloud Functions para construir um app sem servidor**</span>

Começando com o iFix (*8.0.0.0-MFPF-IF20170710-1834*), o Mobile Foundation introduziu um adaptador pré-construído chamado [*Adaptador do Cloud Functions*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter) para a [Plataforma Cloud Functions](https://console.bluemix.net/openwhisk/). O adaptador está disponível para ser transferido por download e implementado por meio do *Centro de download* no Console do Mobile Foundation.

##### <span style="color:NAVY">**Suporte para fixar múltiplos certificados no SDK do Cordova**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF20170803-1112*), a fixação de múltiplos certificados é suportada no SDK do Cordova. Leia mais em *Suporte à fixação de múltiplos certificados* em [O que há de novo](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), sob a seção *O que há de novo nas APIs do MobileFirst*.

##### <span style="color:NAVY">**Suporte para plataforma do navegador Cordova**</span>

Iniciando com o iFix (*8.0.0.0-MFPF-IF20170823-1236*), o {{site.data.keys.product }} suporta a plataforma do navegador Cordova juntamente com as plataformas suportadas anteriormente do Cordova Windows, Cordova Android e Cordova iOS. [Saiba mais](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**Gerar um adaptador por meio de sua especificação do OpenAPI**</span>

Iniciando com o iFix (*8.0.0.0-MFPF-IF20170901-1903*), o {{site.data.keys.product }} introduziu o recurso para gerar automaticamente um adaptador por meio de sua especificação do OpenAPI. Os usuários do {{site.data.keys.product }} podem agora concentra-se na lógica de aplicativo em vez de criar o adaptador do {{site.data.keys.product }}, que conecta o aplicativo ao serviço de backend desejado. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**Suporte para iOS 11 e iPhone X**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o Mobile Foundation anunciou o suporte para iOS 11 e iPhone X on Mobile Foundation v8.0. Para obter detalhes adicionais, leia a postagem do blog [Suporte do IBM MobileFirst Platform Foundation para iOS 11 e iPhone X](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/).

##### **<span style="color:NAVY">Suporte para o Android Oreo</span>**

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o Mobile Foundation anunciou o suporte para Android Oreo com esta [postagem do blog](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/). Os apps nativos do Android e os aplicativos híbridos/Cordova, construídos em versões mais antigas do Android, funcionam conforme o esperado no Android Oreo quando o dispositivo é submetido a upgrade por meio de um OTA.

##### <span style="color:NAVY">**O Mobile Foundation pode agora ser implementado em clusters do Kubernetes**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o usuário do Mobile Foundation pode agora implementar o Mobile Foundation, que inclui o Mobile Foundation Server, o Mobile Analytics Server e o Application Center, em clusters do Kubernetes. O pacote de implementação foi atualizado para suportar a implementação do Kubernetes. Leia o [anúncio](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/).

<!--
### Licensing
{: #licensing }
#### PVU licensing
{: #pvu-licensing }
A new offering, {{ site.data.keys.product }} Extension V8.0.0, is available through PVU (processor value unit) licensing. For more information on PVU licensing for {{ site.data.keys.product }} Extension, see [Licensing {{ site.data.keys.product_adj }}](../../licensing).


### Web applications
{: #web-applications }
#### Registering web applications from the {{ site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
You can now register client web applications to {{ site.data.keys.mf_server }} by using the {{ site.data.keys.mf_cli }} (mfpdev) as an alternative to registration from the {{ site.data.keys.mf_console }}. For more information, see Registering web applications from the {{ site.data.keys.mf_cli }}.

### Cordova applications
{: #cordova-applications }
#### Opening the native IDE for a Cordova project from Eclipse with the Studio plug-in
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
With the Studio plug-in installed in your Eclipse IDE, you can open an existing Cordova project in Android Studio or Xcode from the Eclipse interface to build and run the project.

#### Added *projectName* directory as an option when you use the Migration Assistance tool
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
You can specify a name for your Cordova project directory when you migrate projects with the migration assistance tool. If you do not provide a name, the default name is *app_name-app_id-version*.

#### Usability improvements to the Migration Assistance tool
{: #usability-improvements-to-the-migration-assistance-tool }
Made the following changes to improve the usability of the Migration Assistance tool:

* The Migration Assistance tool scans HTML files and JavaScript files.
* The scan report opens in your default browser automatically after the scan is finished.
* The *--out* flag is optional. The working directory is used if it is not specified.
* When the *--out* flag is specified and the directory does not exist, the directory is created.

### Adapters
{: #adapters }
#### Added `mfpdev push` and `pull` commands for Java and JavaScript adapter configurations
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
You can use {{ site.data.keys.mf_cli }} to push Java and JavaScript adapter configurations to the {{ site.data.keys.mf_server }} and pull adapter configurations from the {{ site.data.keys.mf_server }}.

### Application Center
{: #application-center}

Cordova based application center client is now available for iOS and Android.
-->
