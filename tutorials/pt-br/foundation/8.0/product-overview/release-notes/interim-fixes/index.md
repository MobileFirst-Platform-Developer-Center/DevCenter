---
layout: tutorial
title: O que há de novo nas atualizações do CD
breadcrumb_title: Atualizações de CD
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Correções temporárias e atualizações do CD fornecem correções e atualizações para corrigir problemas e manter o {{ site.data.keys.product_full }} atualizado para novas liberações de sistemas operacionais móveis. As atualizações do CD também aprimoram a funcionalidade do produto, introduzindo novos recursos.

As correções temporárias e as atualizações do CD são cumulativas. Ao fazer download da correção temporária ou da atualização do CD mais recente da v8.0, você obtém todas as correções e recursos de correções temporárias e atualizações do CD anteriores.

Faça download e instale a atualização mais recente do CD para obter todos os recursos descritos nas seções a seguir.

> Para obter uma lista de liberações de iFix do {{ site.data.keys.product }} 8.0, [veja aqui]({{site.baseurl}}/blog/tag/iFix_8.0/).

### Recursos incluídos na atualização 6 do CD (8.0.0.0-MFPF-IF201911050809-CDUpdate-06)

#### <span style="color:Black">Servidor</span>
##### <span style="color:NAVY">**Melhorias de Desempenho**</span>

Otimização das operações do banco de dados Mobile Foundation e introdução de limpeza automatizada do banco de dados de registros.

##### <span style="color:NAVY">**Agora o Application Center está disponível no DevKit**</span>

Agora o Application Center está disponível como um pacote com [DevKit]({{site.baseurl}}/downloads/). Isso permite que os desenvolvedores construam aplicativos e os publiquem no armazenamento privado, que agora está disponível como parte do DevKit.

##### <span style="color:NAVY">**Suporte de pilha para software do fornecedor**</span>

Agora o Mobile Foundation suporta Windows Server 2016 SE e Oracle 18c.

##### <span style="color:NAVY">**Suporte para estruturas de desenvolvimento de aplicativo**</span>

O Mobile Foundation suporta as estruturas mais recentes liberadas pela Apple e pelo Google com suporte para [iOS 13]({{site.baseurl}}/blog/2019/09/19/IBM-MobileFoundation-iOS13/), iPadOS e
[Android 10]({{site.baseurl}}/blog/2019/09/04/mobilefirst-android-Q/). A plataforma também fornece um SDK para Swift 5.

##### <span style="color:NAVY">**Conecte-se com segurança a aplicativos back-end utilizando um Proxy API**</span>

Ao conectar-se ao back-end corporativo, é possível alavancar a segurança e a análise da plataforma Mobile Foundation utilizando o Proxy API. O Proxy API envia as solicitações para o back-end real. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/digital-app-builder/api-proxy/).

#### <span style="color:Black">Analítico</span>
##### <span style="color:NAVY">**Feedback no Aplicativo**</span>

O recurso de feedback no aplicativo estava disponível anteriormente no serviço Mobile Foundation no IBM Cloud e agora foi transferido para a distribuição de contêiner e no local do Mobile Foundation. Utilizando esse recurso, os usuários podem compartilhar feedback do aplicativo em forma de capturas de tela, anotações e texto. Um administrador pode efetuar login no console de analítica para visualizar o feedback recebido e tomar a ação necessária.



#### <span style="color:Black">Pacote OpenShift</span>
##### <span style="color:NAVY">**O Mobile Foundation faz parte do IBM Cloud Pak for Applications v3**</span>

Agora o Mobile Foundation está disponível como parte do [IBM Cloud Pak for Apps]({{site.baseurl}}/blog/2019/09/13/announcing-support-for-mf-on-rhocp/) e suporta Red Hat Open Shift 3.11 e Red Hat Open Shift 4.2. Os serviços atualmente disponíveis são núcleo móvel, análise, notificações de push e centro de aplicativos. Utilizando esses recursos, os desenvolvedores podem construir aplicativos nativos em nuvem usando microsserviços back-end e serviços móveis.


### Recursos incluídos com a atualização 5 do CD (8.0.0.0-MFPF-IF201903190949-CDUpdate-05)

##### <span style="color:NAVY">**Atualização do CoreML**</span>

Os modelos de ML (Machine Learning) podem ser executados localmente no dispositivo móvel iOS usando a estrutura CoreML da Apple.
A Mobile Foundation fornece a capacidade de gerenciar a distribuição desses modelos para dispositivos de forma segura. [Saiba mais](https://mobilefirstplatform.ibmcloud.com/blog/2019/02/08/distribute-coreml-models-securely-using-mfp/).

##### <span style="color:NAVY">**App Authenticity for watchOS**</span>

O App Authenticity é um recurso de segurança que valida a autenticidade do aplicativo antes de fornecer acesso. Esse recurso estava disponível para aplicativos móveis. Agora, ele foi estendido para aplicativos Apple WatchOS. [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/watchos/).

##### <span style="color:NAVY">**Notificações push - Recursos e atributos de mensagem adicionais para o FCM**</span>

Agora, as notificações push suportam os seguintes atributos de mensagem adicionais.
1. Luzes
2. Estilos (caixa de entrada, BigText, PictureNotifications)


### Recursos incluídos na atualização 4 do CD (8.0.0.0-MFPF-IF201812191602-CDUpdate-04)

##### <span style="color:NAVY">**Suporte de HTTP/2 para notificações push de APNs**</span>

As notificações push no MobileFirst agora suportam as notificações push de APNs baseadas em HTTP/2 juntamente com as notificações anteriores baseadas no soquete TCP . [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/sending-notifications/#http2-support-for-apns-push-notifications).

##### <span style="color:NAVY">**SDK do push nativo de reação liberado**</span>

O SDK nativo de reação para push (*react-native-ibm-mobilefirst-push 1.0.0*) foi liberado com essa atualização do CD.


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

Iniciando com o CD Update (*8.0.0.0-MFPF-IF201804180449-CDUpdate-02*), o Mobile Foundation agora introduz um tipo especial de token, chamado token de Atualização, que pode ser usado para solicitar um novo token de acesso.  [Saiba mais]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Suporte para Cordova v8 e Cordova Android v7**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF201804051553*), os plug-ins do MobileFirst Cordova para Cordova v8 e Cordova Android v7 são suportados. Para trabalhar com a versão mencionada do Cordova, é necessário obter os plug-ins MobileFirst mais recentes e fazer upgrade para a versão mais recente da CLI (mfpdev-cli). Para obter detalhes sobre as versões suportadas para plataformas individuais, consulte [Incluindo o SDK do MobileFirst Foundation em aplicativos Cordova]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Sincronização automatizada de coleções JSONStore com bancos de dados CouchDB**</span>

Iniciando com este iFix (*8.0.0.0-MFPF-IF201802201451*), usando o SDK do MobileFirst Android, é possível automatizar a sincronização de dados entre uma Coleção JSONStore em um dispositivo com qualquer tipo de banco de dados CouchDB, incluindo [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). Para obter mais informações sobre esse recurso, leia esta [postagem do blog]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).

### Recursos introduzidos com o CD Update 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01)

##### <span style="color:NAVY">**Suporte para o editor de UI do Eclipse**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o editor WYSIWYG é agora fornecido no Eclipse do MobileFirst Studio. Os desenvolvedores podem projetar e implementar a UI para seus aplicativos Cordova usando esse editor de UI. [Saiba mais](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**Novos adaptadores para construção de apps cognitivos**</span>

Iniciando com o CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, o Mobile Foundation introduziu dois novos adaptadores de serviços cognitivos pré-construídos para os serviços [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) e [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator). Esses adaptadores estão disponíveis para serem transferidos por download e implementados por meio do *Centro de download* no Console do Mobile Foundation.

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
