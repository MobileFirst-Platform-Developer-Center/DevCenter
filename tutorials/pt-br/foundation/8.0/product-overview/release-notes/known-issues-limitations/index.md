---
layout: tutorial
title: Problemas e limitações conhecidos
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Problemas Conhecidos
{: #known-issues }
Clique no link a seguir para receber uma lista de documentos gerada dinamicamente para esta liberação específica e todos os seus fix packs, incluindo problemas conhecidos e suas resoluções e downloads relevantes: [http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0).

## Limitações conhecidas
{: #known-limitations }
Nesta documentação, é possível localizar a descrição das limitações conhecidas do {{ site.data.keys.product_full }} em locais diferentes:

* Quando a limitação conhecida se aplicar a um recurso específico, é possível
localizar sua descrição no tópico que explica esse recurso específico. É possível então identificar imediatamente como ela afetará o recurso.
* Quando a limitação conhecida for geral, ou seja, se aplicar a tópicos
relacionados diferentes e possivelmente não diretamente a eles, é possível localizar sua descrição
aqui.

### Globalização
{: #globalization }
Se você estiver desenvolvendo aplicativos globalizados, as restrições
a seguir se aplicam:

* Tradução parcial: parte do produto {{ site.data.keys.product }} v8.0, incluindo sua documentação, está traduzida para os idiomas a seguir: chinês simplificado, chinês tradicional, francês, alemão, italiano, japonês, coreano, português (do Brasil), russo e espanhol. O texto voltado ao usuário é traduzido.
* Suporte bidirecional: Os aplicativos que são gerados pelo
{{ site.data.keys.product }}
não são ativados como totalmente bidirecionais. O espelhamento dos elementos da interface gráfica com o usuário (GUI) e o controle da direção do texto
não são fornecidos por padrão. No entanto, não existe nenhuma
dependência permanente dos aplicativos gerados nessa limitação. Os desenvolvedores podem alcançar a conformidade bidirecional integral através de ajustes manuais no código gerado.

Embora a tradução para o hebraico seja fornecida para a funcionalidade principal do {{ site.data.keys.product }},
alguns elementos da GUI não são espealhados.

* Restrições sobre nomes de adaptadores: os nomes dos adaptadores devem ser nomes válidos para criar um nome de classe Java. Além disso, eles devem ser compostos apenas dos seguintes
caracteres:
    * Letras maiúsculas e minúsculas (A-Z e a-z)
    * Dígitos (0-9)
    * Caractere de sublinhado (_)

* Caracteres Unicode: Caracteres Unicode fora do Plano Básico
Multilíngue não são suportados.
* Sensibilidade do idioma e formulários de normalização Unicode: nos casos de uso a seguir, as consultas não consideram a sensibilidade do idioma, como correspondência normal, sem distinção de acentuação, sem distinção entre maiúsculas e minúsculas e mapeamento de um para dois para a função de procura, para executar corretamente em diferentes idiomas e a procura em dados não usa Normalization Form C (NFC).
    * No
{{ site.data.keys.mf_analytics_console }},
quando você cria um filtro customizado para um gráfico customizado. No entanto, nesse console, a propriedade de mensagem usa
Normalization Form C (NFC) e considera a sensibilidade ao idioma.
    * No {{ site.data.keys.mf_console }}, ao procurar um aplicativo na página Procurar aplicativos, um adaptador na página Procurar adaptadores, uma tag na página Push ou um dispositivo na página Dispositivos.
    * Nas funções Localizar para a API JSONStore.

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
O
{{ site.data.keys.mf_analytics }}
possui as limitações a seguir:

* Análise de dados de segurança (dados em solicitações falhando nas verificações de segurança) não é suportada.
* No {{ site.data.keys.mf_analytics_console }}, o formato dos números não segue as regras International Components for Unicode (ICU).
* No {{ site.data.keys.mf_analytics_console }}, os números não usam o script de número preferencial do usuário.
* No {{ site.data.keys.mf_analytics_console }}, o formato para datas, horários e números são exibidos de acordo com a configuração do idioma do sistema operacional em vez de no código de idioma do Microsoft Internet Explorer.
* Ao criar um filtro customizado para um gráfico customizado, os dados
numéricos devem estar em numerais de base 10, ocidentais ou europeus, como 0,
1, 2, 3, 4, 5, 6, 7, 8, 9.
* Ao criar um alerta na página Gerenciamento de alerta do {{ site.data.keys.mf_analytics_console }}, os dados numéricos devem estar em numerais base 10, ocidentais ou europeus, como 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
* A página Analytics do {{ site.data.keys.mf_console }} suporta os navegadores a seguir:
    * Microsoft Internet Explorer versão 10 ou posterior
    * Mozilla Firefox ESR ou posterior
    * Apple Safari on iOS versão 7.0 ou posterior
    * Versão mais recente do Google Chrome
* O SDK do cliente Analytics não está disponível para o Windows.


### Cliente móvel do {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
O cliente móvel
do Application Center segue as convenções culturais do dispositivo em
execução, como formatação de data. Ele nem sempre segue as
regras estritas do International Components for Unicode (ICU).

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
O
{{ site.data.keys.mf_console }}
possui as limitações a seguir:

* Fornece somente suporte parcial para linguagens bidirecionais.
* A direção do texto não pode ser alterada quando mensagens de notificação forem enviadas para o dispositivo Android:
    * Se as primeiras letras digitadas estiverem em um idioma da
direita-à-esquerda, como árabe e hebraico, a direção do texto inteiro
será automaticamente da direita-à-esquerda.
    * Se as primeiras letras digitadas estiverem em um idioma da
esquerda-à-direita, a direção do texto inteiro será automaticamente
da esquerda-à-direita.
* A sequência de caracteres e o alinhamento do texto não correspondem a um estilo cultural na linguagem bidirecional.
* Os campos numéricos não analisam valores numéricos de acordo com
as regras de formatação do código de idioma. O console exibe números
formatados, mas aceita como entrada somente números
*brutos* (não formatados). Por exemplo: 1000, não 1 000 ou 1.000.
* Os tempos de resposta na página Analytics do {{ site.data.keys.mf_console }} depende de vários fatores, como hardware (RAM, CPUs), quantidade de dados de análise de dados acumulados e armazenamento em cluster do {{ site.data.keys.mf_analytics }}. Considere
testar a carga antes de integrar o
{{ site.data.keys.mf_analytics }}
na produção.

### Server Configuration Tool
{: #server-configuration-tool }
A Ferramenta de Configuração do Servidor tem as seguintes restrições:

* O nome descritivo de uma configuração do servidor pode conter apenas caracteres que estejam no conjunto de caracteres do sistema. No Windows, é o conjunto de caracteres ANSI.
* As senhas que contêm caracteres de aspas simples ou aspas duplas podem não funcionar corretamente.
* O console do Server Configuration Tool tem a mesma limitação de globalização que o console do Windows para exibir sequências que estão fora da página de códigos padrão.

Também pode haver restrições ou anomalias nos
vários aspectos de globalização devido a limitações em outros produtos,
como navegadores, sistemas de gerenciamento de banco de dados ou kits de desenvolvimento
de software em uso. Por
exemplo:

* Você deve definir o nome do usuário e a senha do Application
Center apenas com caracteres ASCII. Essa limitação existe porque o WebSphere Application Server (perfis completo ou Liberty) não suporta senhas e nomes de usuário não ASCII. Consulte Caracteres que são válidos para IDs de usuário e senhas.
* No
Windows:
    * Para ver quaisquer mensagens localizadas no arquivo de log criado pelo servidor de teste, deve-se abrir esse arquivo de log com a codificação UTF8.
    * A causa dessas limitações são as seguintes:
        * O servidor de teste é instalado no perfil Liberty do WebSphere Application Server, que cria o arquivo de log com a codificação ANSI, exceto para suas mensagens localizadas para as quais ele usa a codificação UTF8.

* No Java 7.0 Service Refresh 4-FP2 e versões anteriores, não é possível colar caracteres Unicode que não fazem parte do Plano multilíngue básico no campo de entrada. Para evitar esse problema, crie a pasta de caminho manualmente e escolha essa
pasta durante a instalação.
* Os nomes de títulos e botões customizados para os métodos de alerta, confirmação e
prompt devem ser mantidos curtos para evitar truncamento na borda da
tela.
* O JSONStore não manipula a normalização. As funções Localizar para a API JSONStore não levam em consideração a sensibilidade do idioma, como sem distinção de acentuação, sem distinção entre maiúsculas e minúsculas e mapeamento de um para dois.

### Adaptadores e dependências de terceiros
{: #adapters-and-third-party-dependencies }
Os problemas conhecidos a seguir pertencem às interações entre dependências e classes no servidor de aplicativos, incluindo a biblioteca compartilhada do {{ site.data.keys.product_adj }}.

#### Apache HttpClient
{: #apache-httpclient }
{{ site.data.keys.product }} usa Apache HttpClient internamente. Se você incluir uma instância do Apache HttpClient como uma dependência em um adaptador Java, as APIs a seguir não funcionarão corretamente no adaptador: `AdaptersAPI.executeAdapterRequest, AdaptersAPI.getResponseAsJSON` e `AdaptersAPI.createJavascriptAdapterRequest`. O motivo é que as APIs contêm tipos Apache HttpClient em sua assinatura. A solução alternativa é usar o Apache HttpClient interno, mas mudar o escopo de dependência no **pom.xml** fornecido.

#### Biblioteca criptográfica Bouncy Castle
{: #bouncy-castle-cryptographic-library }
{{ site.data.keys.product }} usa Bouncy Castle. Talvez
seja possível usar outra versão de Bouncy Castle no adaptador, mas as consequências precisam ser testadas cuidadosamente: às vezes o código {{ site.data.keys.product_adj }} Bouncy Castle preenche certos campos Singleton estáticos das classes do pacote `javax.security` e pode impedir a versão do Bouncy Castle dentro de um adaptador de usar recursos que contam com esses campos.

#### Implementação de arquivos JAR do Apache CXF
{: #apache-cxf-implementaton-of-jar-files }
CXF é usado na implementação {{ site.data.keys.product_adj }} JAX-RS, evitando assim que você inclua arquivos JAR Apache CXF em um adaptador.

### Cliente Móvel do Application Center: Problemas de Atualização no
Android 4.0.x
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Sabe-se que o componente Android 4.0.x WebView possui
vários problemas de atualização. A atualização de dispositivos para o Android 4.1.x deve
fornecer uma experiência melhor ao usuário.

Se você construir o cliente do Application Center a partir de origens, desativar a aceleração do hardware no nível do aplicativo no manifesto do Android deve melhorar a situação para o Android 4.0.x. Nesse caso, o aplicativo deverá ser construído com
o Android SDK 11 ou mais recente.

### O Application Center requer o MobileFirst Studio V7.1 para importar e construir o cliente móvel do Application Center
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Para construir o cliente móvel do Application Center, você precisa do MobileFirst Studio V7.1. É possível fazer download do MobileFirst Studio a partir da [página Downloads]({{site.baseurl}}/downloads). Clique na guia
**Liberações anteriores do MobileFirst Platform
Foundation** para o link de download. Para obter instruções de instalação, consulte [Instalando o MobileFirst Studio no IBM Knowledge Center para 7.1](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html). Para obter mais informações sobre como construir o cliente móvel do Application Center, consulte [Preparações para usar o cliente móvel](../../../appcenter/preparations).

### Application Center e Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
O Application Center suporta a distribuição de aplicativos como arquivos do pacote de aplicativos do Windows Phone (.xap) para o Microsoft Windows Phone 8.0 e o Microsoft Windows Phone 8.1. Com o Microsoft Windows Phone
8.1, a Microsoft introduziu um novo formato universal como
arquivos de pacote de aplicativos (.appx) para o Windows
Phone. Atualmente, o Application Center não suporta a distribuição de arquivos do pacote de aplicativos (.appx) para o Microsoft Windows Phone 8.1, mas está limitado somente a arquivos do pacote de aplicativos do Windows Phone (.xap).

O Application Center suporta somente a distribuição de arquivos do pacote de aplicativos (.appx) para o Microsoft Windows Store (aplicativos para desktop).

### Administrando aplicativos {{ site.data.keys.product_adj }} por meio de Ant ou da linha de comandos
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
A ferramenta **mfpadm** não estará disponível se você fizer download e instalar somente {{ site.data.keys.mf_dev_kit_full }}. A ferramenta mfpadm é instalada com o {{ site.data.keys.mf_server }} com o instalador.

### Clientes confidenciais
{: #confidential-clients }
Use caracteres ASCII apenas para os valores de IDs de clientes confidenciais e segredos.

### Atualização Direta
{: #direct-update }
Atualização Direta no Windows não é suportada na V8.0.0.

### Limitações de Recurso FIPS 140-2
{: #fips-104-2-feature-limitations }
As seguintes limitações conhecidas se aplicam ao usar o recurso FIPS 140-2 no {{ site.data.keys.product }}:
* Este modo validado pelo FIPS 140-2 se aplica somente à proteção (criptografia) de dados locais que são armazenados pelo recurso JSONStore
e à proteção de comunicações HTTPS entre o cliente do
{{ site.data.keys.product_adj }} e o
{{ site.data.keys.mf_server }}.
    * Para comunicações HTTPS, somente as comunicações entre o cliente do
{{ site.data.keys.product_adj }} e o
{{ site.data.keys.mf_server }} usam as bibliotecas FIPS 140-2
no cliente. Conexões diretas a outros servidores ou serviços não usam as bibliotecas FIPS 140-2.
* Esse recurso é suportado apenas nas plataformas iOS e Android.
    * No Android, esse recurso é suportado apenas em dispositivos ou simuladores que usam as arquiteturas x86 ou armeabi. Ele não é suportado no Android usando as arquiteturas armv5 ou armv6. A razão é porque a biblioteca OpenSSL usada não obteve validação do FIPS 140-2 para armv5 ou armv6 no Android. O FIPS
140-2 não é suportado na arquitetura de 64 bits, mesmo que a biblioteca do {{ site.data.keys.product_adj }}
suporte a arquitetura de 64 bits. FIPS 140-2 pode ser executado em dispositivos de 64 bits, caso o projeto inclua somente bibliotecas NDK nativas de 32 bits.
    * No iOS, ele é suportado nas arquiteturas i386, x86_64, armv7, armv7s e arm64.
* Esse recurso funciona somente com aplicativos híbridos (não com aplicativos nativos).
* Para iOS nativo, o FIPS é ativado por meio das bibliotecas iOS
FIPS e é ativado por padrão. Nenhuma ação é necessária para ativar o
FIPS 140-2.
* O uso do recurso de inscrição do usuário no cliente não é suportado pelo recurso
FIPS 140-2.
* O cliente do Application Center não suporta o recurso FIPS 140-2.

### A instalação de um fix pack ou de uma correção temporária no Application Center ou no {{ site.data.keys.mf_server }}
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Ao aplicar um fix pack ou uma correção temporária ao Application Center ou ao {{ site.data.keys.mf_server }}, operações manuais são necessárias e poderá ser necessário encerrar seus aplicativos por algum tempo.

### Arquiteturas suportadas
por JSONStore
{: #jsonstore-supported-architectures }
Para
Android, JSONStore suporta as arquiteturas a seguir: ARM, ARM
v7 e x86 de 32 bits. Outras arquiteturas não são suportadas no momento. A tentativa de usar outras arquiteturas leva a exceções e a possíveis travamentos de aplicativo.

O armazenamento JSON não é suportado para aplicativos nativos do
Windows.

### Limitações do servidor Liberty
{: #liberty-server-limitations }
Se você usar o servidor Liberty em JDK 7 de 32 bits, o Eclipse poderá não inicia, e o erro a seguir pode ser recebido: "Ocorreu um erro durante a inicialização da VM. Could not reserve enough space
for object heap. Error: Could not create the Java Virtual Machine. Error: A fatal exception has occurred. O programa será fechado."

Para corrigir esse problema, use o JDK de 64 bits com o Eclipse de 64 bits e o Windows de 64 bits. Se usar JDK de 32 bits em um computador de 64 bits, você pode configurar preferências de JVM para **mx512m** e **Xms216m**.

### Limitações de token LTPA
{: #ltpa-token-limitations }
Uma exceção `SESN0008E` ocorre quando um token LTPA expira antes de a sessão do usuário expirar.

Um token LTPA está associado à sessão do usuário atual. Se a sessão expirar antes de um token LTPA expirar, uma nova sessão será criada automaticamente. Entretanto, quando um token LTPA expira antes de uma sessão do usuário expirar, a exceção a seguir ocorre:

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E: A user authenticated as anonymous has attempted to access a session owned by {user name}`

Para resolver esta limitação, você deve forçar a sessão do usuário a expirar quando o token LTPA expirar.
* No WebSphere Application Server Liberty, configure o atributo httpSession invalidateOnUnauthorizedSessionRequestException para true no arquivo server.xml.
* No WebSphere Application Server, inclua a propriedade customizada de gerenciamento de sessões InvalidateOnUnauthorizedSessionRequestException com o valor true para corrigir o problema.

**Nota:** em determinadas versões do WebSphere Application Server ou do WebSphere Application Server Liberty, a exceção ainda é registrada, mas a sessão é corretamente invalidada. Para obter mais informações, [consulte o APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141).

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
Para ambientes Windows Phone 8.1, a arquitetura x64 não é suportada.

### Aplicativos Microsoft Windows 10 UWP
{: #microsoft-windows-10-uwp-apps }
O recurso de autenticidade do aplicativo não funciona nos aplicativos Windows 10 UWP do {{ site.data.keys.product_adj }} quando o {{ site.data.keys.product_adj }} SDK é instalado por meio do pacote NuGet. Como uma solução alternativa,
os desenvolvedores podem fazer download do pacote NuGet e incluir as
referências de SDK do
{{ site.data.keys.product_adj }}
manualmente.

### Os projetos aninhados podem resultar em resultados
imprevisíveis com a CLI
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
Não aninhe projetos dentro de um
outro ao usar o
{{ site.data.keys.mf_cli }}. Caso contrário, o projeto em que se atua pode não ser aquele que você
espera.

### Visualizando recursos da web do Cordova com o {{ site.data.keys.mf_mbs }}
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
É possível visualizar seu recursos da web com o {{ site.data.keys.mf_mbs }}, mas nem todas as APIs JavaScript do {{ site.data.keys.product_adj }} são suportadas pelo simulador. Em particular, o protocolo OAuth não é
totalmente suportado. No entanto, é possível testar chamadas para
adaptadores com `WLResourceRequest`.

### Dispositivo iOS físico necessário para testar
a autenticidade do aplicativo estendido
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
O teste do recurso de autenticidade do aplicativo estendido
necessita de um dispositivo iOS físico, pois um IPA não pode ser
instalado em um simulador de iOS.

### Suporte de Oracle 12c pelo {{ site.data.keys.mf_server }}
{: #support-of-oracle-12c-by-mobilefirst-server }
As ferramentas de instalação do {{ site.data.keys.mf_server }} (Installation Manager, Server Configuration Tool e as tarefas Ant) suportam a instalação com o Oracle 12c como um banco de dados.

Os usuários e tabelas podem ser criados pelas ferramentas de instalação, mas o banco de dados, ou bancos de dados, devem existir antes de você executar as ferramentas de instalação.

### Suporte para notificações push
{: #support-for-push-notification }
Push não seguro é suportado em Cordova (em iOS e Android).

### Atualizando a plataforma cordova-ios
{: #updating-cordova-ios-platform }
Para atualizar a plataforma cordova-ios de um aplicativo Cordova, deve-se desinstalar e reinstalar a plataforma concluindo as etapas a seguir:

1. Navegue até o diretório do projeto para o aplicativo usando a interface da linha de comandos.
2. Execute o comando `cordova platform rm ios` para remover a plataforma.
3. Execute o comando `cordova platform add ios@version` para incluir a nova plataforma no aplicativo, em que version é a versão da plataforma Cordova iOS.
4. Execute o comando `cordova prepare` para integrar as mudanças.

A atualização falhará se você usar o comando `cordova platform update ios`.

### Aplicativos para Web
{: #web-applications }
Aplicativos da web têm as limitações a seguir:
- {: #web_app_limit_ms_ie_n_edge }
No Microsoft Internet Explorer (IE) e no Microsoft Edge, mensagens de aplicativos administrativos e mensagens do SDK da web do cliente são exibidas de acordo com a preferência de formato da região do sistema operacional e não de acordo com as preferências de idioma de exibição configuradas para o navegador ou para o sistema operacional. Consulte também [Definindo mensagens do administrador em vários idiomas](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages).

### Suporte do WKWebView para aplicativos iOS Cordova
{: #wkwebview-support-for-ios-cordova-applications }
Os
recursos de notificação de aplicativo e Direct Update podem não funcionar bem em aplicativos iOS
Cordova com o WKWebView.

Essa limitação se deve ao defeito de file:// url XmlHttpRequests não serem permitidas no WKWebViewEgine em **cordova-plugin-wkwebview-engine**.

Para contornar esse problema, execute o comando a seguir em seu projeto Cordova: `cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`

Executar esse comando executaria um servidor da web local em seu aplicativo Cordova, seria possível então hospedar e acessar seus arquivos locais em vez de usar o esquema do URI de arquivo (file://) para trabalhar com arquivos locais.

**Nota:** esse plug-in do Cordova não é publicado no Node package manager (npm).

### cordova-plugin-statusbar não funciona com o aplicativo Cordova carregado com cordova-plugin-mfp.
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
cordova-plugin-statusbar não funcionará com o aplicativo Cordova carregado com cordova-plugin-mfp.

Para contornar esse problema, o desenvolvedor precisará configurar `CDVViewController` como o controlador de visualização raiz. Substituindo o fragmento de código no método `wlInitDidCompleteSuccessfully`, conforme sugerido abaixo no arquivo **MFPAppdelegate.m** do projeto Cordova iOS.

Fragmento de código existente:

```objc
(void)wlInitDidCompleteSuccessfully
{ 
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

Fragmento de código recomendado com solução alternativa para a limitação:

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### Endereço IPv6 bruto raw não suportado em aplicativos Android
{: #raw-ipv6-address-not-supported-in-android-applications }
Durante a configuração de **mfpclient.properties** para o seu aplicativo Android nativo, se seu {{ site.data.keys.mf_server }} estiver em um host com endereço IPv6, então use um nome do host mapeado para o endereço IPV6 para configurar a propriedade **wlServerHost** em **mfpclient.properties**. Configurar a propriedade **wlServerHost** com endereço IPv6 bruto faz a tentativa do aplicativo para se conectar ao {{ site.data.keys.mf_server }} falhar.
