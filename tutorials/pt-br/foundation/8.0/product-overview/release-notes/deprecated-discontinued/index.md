---
layout: tutorial
title: Recursos e APIs descontinuados
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Considere como os recursos e elementos de API removidos afetam seu ambiente do {{ site.data.keys.product_full }}.

#### Ir para
{: #jump-to }
* [Recursos descontinuados e recursos que não estão incluídos na v8.0](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [Mudanças de API do lado do servidor](#server-side-api-changes)
* [Mudanças de API do lado do cliente](#client-side-api-changes)

## Recursos descontinuados e recursos que não estão incluídos na v8.0
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }} O v8.0 foi radicalmente simplificado em comparação à versão anterior. Como resultado dessa simplificação, alguns recursos que estavam disponíveis na v7.1 foram descontinuados na v8.0. Na maioria dos casos, uma maneira alternativa de implementar os recursos é sugerida. Esses recursos são marcados como descontinuados. Alguns outros recursos que existem na V7.1. não estão na v8.0, mas não como uma consequência do novo design da v8.0. Para distinguir esses recursos excluídos dos recursos que foram descontinuados a partir da v8.0, eles estão marcados como não na v8.0.

<table class="table table-striped">
    <tr>
        <td>Recursos</td>
        <td>Status e caminho de substituição</td>
    </tr>
    <tr>
        <td><p>O MobileFirst Studio foi substituído pelo plug-in do {{ site.data.keys.mf_studio }} para Eclipse.</p></td>
        <td><p>Substituído pelo plug-in do {{ site.data.keys.mf_studio }} para Eclipse e com poderes conferidos por plug-ins do Eclipse padrão e baseados em comunidade. É possível desenvolver aplicativos híbridos diretamente com a CLI do Apache Cordova ou com um IDE ativado para Cordova, como Visual Studio Code, Eclipse, IntelliJ e outros. Para obter mais informações sobre como usar o Eclipse como um IDE ativado para Cordova, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">Plug-in do IBM {{ site.data.keys.mf_studio }} para gerenciar projetos Cordova no Eclipse</a>.</p>

        <p>É possível desenvolver adaptadores com Apache Maven ou um IDE ativado por maven, como Eclipse, IntelliJ e outros. Para obter mais informações sobre como desenvolver adaptadores, consulte a <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">categoria Adaptadores</a>. Para obter mais informações sobre como usar o Eclipse como um IDE ativado para Maven, leia o <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">tutorial Desenvolvendo adaptadores no Eclipse</a>.</p>

        <p>Instale o {{ site.data.keys.mf_dev_kit_full }} para testar adaptadores e aplicativos com o {{ site.data.keys.mf_server }}. Também é possível acessar SDKs e ferramentas de desenvolvimento do {{ site.data.keys.product_adj }}, caso não queira fazer seu download a partir de repositórios baseados na Internet, como NPM, Maven, Cocoapod ou NuGet. Para obter mais informações sobre o {{ site.data.keys.mf_dev_kit }}, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>.</p>
        </td>
    </tr>
    <tr>
        <td><p>Aparências, shells, a página Configuração, minificação e elementos da UI de JavaScript foram descontinuados para aplicativos híbridos.</p></td>
        <td><p>Descontinuado. Aplicativos híbridos são desenvolvidos diretamente com Apache Cordova. Para obter mais informações sobre como substituir as aparências, shells, a página Configuração e minificação, consulte Componentes removidos e Comparação de aplicativos Cordova desenvolvidos com a v8.0 versus a v7.1 e antes.</p>
        </td>
    </tr>
    <tr>
        <td><p>Sencha Touch não pode mais ser importado em projetos {{ site.data.keys.product_adj }} para aplicativos híbridos.</p></td>
        <td><p>Descontinuado. Aplicativos híbridos {{ site.data.keys.product_adj }} são desenvolvidos diretamente com Apache Cordova, e os recursos do {{ site.data.keys.product_adj }} são fornecidos como plug-ins Cordova. Consulte a documentação do Sencha Touch para integrar o Sencha Touch e o Cordova.</p>
        </td>
    </tr>
    <tr>
        <td><p>O cache criptografado foi descontinuado.</p></td>
        <td><p>Descontinuado. Para armazenar dados criptografados localmente, use JSONStore. Para obter mais informações sobre JSONStore, consulte o <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">tutorial do JSONStore</a>.</p>
        </td>
    </tr>
    <tr>        
        <td><p>Acionando Atualização Direta sob demanda não está na v8.0. O aplicativo cliente verifica o Direct Update ao obter o token OAuth para uma sessão. Não é possível programar um aplicativo cliente para verificar as atualizações diretas em um momento diferente na v8.0.</p></td>
        <td><p>Não na v8.0.</p></td>
    </tr>
    <tr>
        <td><p>Adaptadores com configuração dependente de sessão. Na V7.1.0, é possível configurar o {{ site.data.keys.mf_server }} para trabalhar no modo independente de sessão (padrão) ou no modo dependente de sessão. A partir da v8.0, o modo dependente de sessão não é mais suportado. O servidor é inerentemente independente da sessão HTTP e nenhuma configuração relacionada é necessária.</p></td>
        <td><p>Descontinuado.</p></td>
    </tr>
    <tr>
        <td><p>Armazenamento de atributo no IBM WebSphere eXtreme Scale não é suportado na v8.0.</p></td>
        <td><p>Não na v8.0.</p></td>
    </tr>
    <tr>
        <td><p>Descoberta de serviço e geração de adaptador para aplicativos de processo do IBM Business Process Manager (IBM BPM), Microsoft Azure Marketplace DataMarket, APIs RESTful OData, recursos RESTful, serviços que são expostos por um SAP Netweaver Gateway e serviços da web não estão na v8.0.</p></td>
        <td><p>Não na v8.0.</p></td>
    </tr>
    <tr>
        <td>O adaptador JMS JavaScript não está na v8.0.</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>O adaptador SAP Gateway JavaScript não está na v8.0.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>O adaptador SAP JCo JavaScript não está na v8.0.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>O adaptador Cast Iron JavaScript não está na v8.0.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Os adaptadores OData e Microsoft Azure OData JavaScript não estão na v8.0.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Suporte de notificação push para USSD não é suportado na v8.0.	</td>
        <td>Descontinuado.</td>
    </tr>
    <tr>
        <td>Notificações push baseadas em evento não são suportadas na v8.0.	</td>
        <td>Descontinuado. Use o serviço de notificação push. Para obter mais informações sobre a migração para o serviço de notificação push, consulte o tópico Migrando para notificações push de notificações baseadas na origem de eventos.</td>
    </tr>
    <tr>
      <td>
        Segurança: a região anti-cross site request forgery (anti-XSRF) (<code>wl_antiXSRFRealm</code>) não é necessária na V8.0.
      </td>
      <td>
        Na V7.1.0, o contexto de autenticação é armazenado na sessão HTTP e identificado por um cookie de sessão, que é enviado pelo navegador em solicitações entre sites. A região anti-XSRF nesta versão é usada para proteger a transmissão de cookies contra ataques de XSRF usando um cabeçalho adicional que é enviado do cliente para o servidor.
        <br />
        Na V8.0.0, o contexto de segurança não é mais associado a uma sessão HTTP e não é identificada por um cookie de sessão.
        Em vez disso, a autorização é feita usando um token de acesso OAuth 2.0 que é passado no cabeçalho de autorização.
        Como o cabeçalho de autorização não é enviado pelo navegador em solicitações entre sites, não há necessidade de proteger contra ataques de XSRF.
      </td>
    </tr>
    <tr>
        <td>Segurança: autenticação de certificado de usuário. A V8.0 não inclui nenhuma verificação de segurança predefinida para autenticar usuários com certificados X.509 do lado do cliente.</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Segurança: integração com o IBM Trusteer. A v8.0 não inclui nenhuma verificação de segurança predefinida ou desafio para testar fatores de risco do IBM Trusteer.</td>
        <td>Não na v8.0. Use IBM Trusteer Mobile SDK.</td>
    </tr>
    <tr>
        <td>Segurança: fornecimento de dispositivo e fornecimento automático de dispositivo	</td>
        <td><p>Descontinuado.</p><p>Nota: o fornecimento de dispositivo é manipulado no fluxo de autorização normal. Os dados do dispositivo são coletados automaticamente durante o processo de registro do fluxo de segurança. Para obter mais informações sobre o fluxo de segurança, consulte Fluxo de autorização de ponta a ponta.</p>
        </td>
    </tr>
    <tr>
        <td>Segurança: arquivo de configuração para ofuscar o código Android com ProGuard. A v8.0 não inclui o arquivo de configuração proguard-project.txt predefinido para ofuscação do Android ProGuard com um aplicativo MobileFirst Android.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Segurança: a autenticação baseada em adaptador é substituída. A autenticação usa o protocolo OAuth e é implementada com verificações de segurança.</td>
        <td>Substituída por uma implementação baseada em verificação de segurança.</td>
    </tr>
    <tr>
        <td><p>Segurança: login de LDAP. A v8.0 não inclui nenhuma verificação de segurança predefinida para autenticar usuários com um servidor LDAP.</p>
        <p>Em vez disso, para o WebSphere Application Server ou o WebSphere Application Server Liberty, use o servidor de aplicativos ou um gateway para mapear um provedor de identidade, como LDAP para LTPA, e gerar um token OAuth para o usuário usando uma verificação de segurança LTPA.</p></td>
        <td>Não na v8.0. Substituído por uma verificação de segurança LTPA para o WebSphere Application Server ou o WebSphere Application Server Liberty.</td>
    </tr>
    <tr>
        <td>
        Configuração de autenticação do adaptador HTTP. O adaptador HTTP predefinido não suporta a conexão como um usuário para um servidor remoto.</td>
        <td><p>Não na v8.0.</p><p>Edite o código-fonte do adaptador HTTP e inclua o código de autenticação. Use <code>MFP.Server.invokeHttp</code> para incluir tokens de identificação de cabeçalho da solicitação de HTTP.</p></td>
    </tr>
    <tr>
        <td>
        Análise de dados de segurança, a capacidade de monitorar eventos da estrutura de segurança do MobileFirst com o MobileFirst Analytics Console não está na v8.0.</td>
        <td>Não na v.8.0.</td>
    </tr>
    <tr>
        <td>O modelo baseado em origem de eventos para notificações push foi descontinuado e substituído pelo modelo de serviço de push baseado em tag.</td>
        <td>Descontinuado e substituído pelo modelo de serviço de push baseado em tag.</td>
    </tr>
    <tr>
        <td>Não há suporte para Unstructured Supplementary Service Data (USSD) na v8.0.</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Cloudant usado como um banco de dados para o {{ site.data.keys.mf_server }} não é suportado na v8.0.	</td>
        <td>Não na v8.0.</td>
    </tr>
    <tr>
        <td>Localização geográfica: o suporte à localização geográfica foi descontinuada no {{ site.data.keys.product }} v8.0. A API REST para indicadores e mediadores foi descontinuada. As APIs WL.Geo e WL.Device do lado do cliente e do lado do servidor foram descontinuadas.	</td>
        <td>Descontinuado. Use a API do dispositivo nativo ou plug-ins Cordova de terceiros para localização geográfica.</td>
    </tr>
    <tr>
        <td>O recurso {{ site.data.keys.product_adj }} Data Proxy foi descontinuado. As APIs IMFData e CloudantToolkit do Cloudant também foram descontinuadas.	</td>
        <td>Descontinuado. Para obter mais informações sobre como substituir as APIs IMFData e CloudantToolkit em seus aplicativos, consulte Migrando aplicativos armazenando dados móveis no Cloudant com IMFData ou com o Cloudant SDK.</td>
    </tr>
    <tr>
        <td>O IBM Tealeaf SDK não é mais empacotado com o {{ site.data.keys.product }}.	</td>
        <td>Descontinuado. Use IBM Tealeaf SDK. Para obter mais informações, consulte <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Instalação e implementação Tealeaf em um aplicativo Android</a> e <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Instalação e implementação Tealeaf iOS Logging Framework</a> na documentação do IBM Tealeaf Customer Experience.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_test_workbench_full }} não é empacotado com {{ site.data.keys.product }}</td>
        <td>Descontinuado.</td>
    </tr>
    <tr>
        <td>BlackBerry, Adobe AIR, Windows Silverlight não são suportados pelo {{ site.data.keys.product }} v8.0. Nenhum SDK é fornecido para essas plataformas.	</td>
        <td>Descontinuado.</td>
    </tr>
</table>

## Mudanças de API do lado do servidor
{: #server-side-api-changes }
Para migrar o lado do servidor do aplicativo {{ site.data.keys.product_adj }}, leve em conta as mudanças nas APIs.  
As tabelas a seguir listam os elementos de API do lado do servidor descontinuados na v8.0 e os caminhos de migração sugeridos. Para obter mais informações sobre como migrar o lado do servidor de seu aplicativo,

### Elementos da API de JavaScript descontinuados na v8.0
{: #javascript-api-elements-discontinued-v-v-80 }
#### Segurança
{: #security }

| Elemento da API                         | Caminho de substituição                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUser`, `WL.Server.getCurrentUserIdentity`,  `WL.Server.getCurrentDeviceIdentity`, `WL.Server.setActiveUser`, `WL.Server.getClientId`, `WL.Server.getClientDeviceContext`, `WL.Server.setApplicationContext` | Use `MFP.Server.getAuthenticatedUser` no lugar. |

#### Fonte de Eventos
{: #event-source }

| Elemento da API                         | Caminho de substituição                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | Use `MFP.Server.getAuthenticatedUser` no lugar. |
| `WL.Server.setEventHandlers`         | Para migrar de notificações baseadas na origem de eventos para notificações baseadas em tag, consulte Migrando para notificações push de notificações baseadas em origem de eventos.                                                     |
| `WL.Server.createEventHandler`       |                                                |
| `WL.Server.createSMSEventHandler`	 | Para enviar mensagens SMS, use a API de REST do serviço de push. Para obter mais informações, consulte [Enviando notificações](../../../notifications/sending-notifications).                         |
| `WL.Server.createUSSDEventHandler`	 | Integre USSD usando serviços de terceiros.  |

#### Enviar
{: #push }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`, `WL.Server.notifyAllDevices`, `WL.Server.sendMessage`, `WL.Server.notifyDevice`, `WL.Server.notifyDeviceSubscription`, `WL.Server.notifyAll`, `WL.Server.createDefaultNotification`, `WL.Server.submitNotification` 	| Para migrar de notificações baseadas na origem de eventos para notificações baseadas em tag, consulte Migrando para notificações push de notificações baseadas em origem de eventos. |
| `WL.Server.subscribeSMS`	                | Use o registro de dispositivo push da API de REST (POST) para registrar o dispositivo. Para enviar e receber notificações por SMS, forneça phoneNumber na carga útil ao chamar a API.                               |
| `WL.Server.unsubscribeSMS`	                | Use o registro de dispositivo push da API de REST (DELETE) para cancelar registro do dispositivo. |
| `WL.Server.getSMSSubscription`	            | Use o registro de dispositivo push da API de REST (GET) para obter os registros do dispositivo. |

#### Serviços do Local
{: #location-services }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | Integre serviços de localização usando serviços de terceiros. |

#### Segurança WS
{: #ws-security }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | Use os recursos WS-Security do WebSphere Application Server. |

### Elementos de Java API descontinuados na v8.0
{: #java-api-elements-discontinued-in-v-80 }
#### Segurança
{: #security-java }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | Use AdapterSecurityContext no lugar.            |

#### Enviar
{: #push-java }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| Para migrar de notificações baseadas na origem de eventos para notificações baseadas em tag, consulte Migrando para notificações push de notificações baseadas em origem de eventos. |
| `INotification PushAPI.buildNotification();` | Para migrar de notificações baseadas na origem de eventos para notificações baseadas em tag, consulte Migrando para notificações push de notificações baseadas em origem de eventos. |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | Para migrar de notificações baseadas na origem de eventos para notificações baseadas em tag, consulte Migrando para notificações push de notificações baseadas em origem de eventos. |

#### Adaptadores
{: #adapters-java }

| Elemento da API                                | Caminho de substituição                               |
|-------------------------------------------|------------------------------------------------|
| Interface `AdaptersAPI` no pacote `com.worklight.adapters.rest.api` | Use a interface `AdaptersAPI` no pacote `com.ibm.mfp.adapter.api`. |
| Interface `AnalyticsAPI` no pacote `com.worklight.adapters.rest.api` | Use a interface `AnalyticsAPI` no pacote `com.ibm.mfp.adapter.api`. |
| Interface `ConfigurationAPI` no pacote `com.worklight.adapters.rest.api` | Use a interface `ConfigurationAPI` no pacote `com.ibm.mfp.adapter.api`. |
| Anotação `OAuthSecurity` no pacote `com.worklight.core.auth` | Use a anotação `OAuthSecurity` no pacote `com.ibm.mfp.adapter.api`. |
| Classe `MFPJAXRSApplication` no pacote `com.worklight.wink.extensions` | Use a classe `MFPJAXRSApplication` no pacote `com.ibm.mfp.adapter.api`. |
| Interface `WLServerAPI` no pacote `com.worklight.adapters.rest.api` | Use anotação JAX-RS `Context` para acessar diretamente as interfaces da API {{ site.data.keys.product_adj }}. |
| Classe `WLServerAPIProvider` no pacote `com.worklight.adapters.rest.api` | Use anotação JAX-RS `Context` para acessar diretamente as interfaces da API {{ site.data.keys.product_adj }}. |

## Mudanças de API do lado do cliente
{: #client-side-api-changes }
As seguintes mudanças nas APIs são relevantes para migrar seu aplicativo cliente {{ site.data.keys.product_adj }}.  
As tabelas a seguir listam os elementos de API do lado do cliente descontinuados na V8.0.0 e caminhos de migração sugeridos.

### APIs de JavaScript
{: #javascript-apis }
Estas APIs de JavaScript que afetam a interface com o usuário não são mais suportadas na v8.0. Elas podem ser substituídas por plug-ins Cordova de terceiros disponíveis ou criando-se plug-ins Cordova customizados.

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WL.BusyIndicator`, `WL.OptionsMenu`, `WL.TabBar`, `WL.TabBarItem` | Use plug-ins Cordova ou elementos HTML 5. |
| `WL.App.close` | Manipule esse evento fora do {{ site.data.keys.product_adj }}. |
| `WL.App.copyToClipboard()` | Use plug-ins Cordova que fornecem essa funcionalidade. |
| `WL.App.openUrl(url, target, options)` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, o plug-in **InAppBrowser** do Cordova fornece esse recurso. |
| `WL.App.overrideBackButton(callback)`, `WL.App.resetBackButton()` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, o plug-in **backbutton** do Cordova fornece esse recurso. |
| `WL.App.getDeviceLanguage()` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** Para sua informação, o plug-in **cordova-plugin-globalization** do Cordova fornece esse recurso. |
| `WL.App.getDeviceLocale()` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** Para sua informação, o plug-in **cordova-plugin-globalization** do Cordova fornece esse recurso. |
| `WL.App.BackgroundHandler` | Para executar uma função de manipulador customizada, use o listener de eventos de pausa Cordova padrão. Use um plug-in Cordova que forneça privacidade e impeça sistemas e usuários do iOS e Android de fazerem capturas instantâneas ou capturas de tela. Para obter mais informações, consulte a descrição do **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**. |
| `WL.Client.close`, `WL.Client.restore`, `WL.Client.minimize` | As funções foram fornecidas para suportar a plataforma Adobe AIR, que não é suportado pelo {{ site.data.keys.product }} V8.0.0. |
| `WL.Toast.show(string)` | Use plug-ins Cordova para Toast. |

Este conjunto de APIs não é mais suportado na v8.0.

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WL.Client.checkForDirectUpdate(options)` | Nenhuma substituição. **Nota:** será possível chamar `WLAuthorizationManager.obtainAccessToken` para acionar uma atualização direta se uma estiver disponível. O acesso ao token de segurança acionará uma atualização direta se ela estiver disponível no servidor. Mas não é possível acionar o Direct Update on demand. |
| `WL.Client.setSharedToken({key: myName, value: myValue})`, `WL.Client.getSharedToken({key: myName})`, `WL.Client.clearSharedToken({key: myName})` | Nenhuma substituição. |
| `WL.Client.isConnected()`, opção de inicialização `connectOnStartup` | Use `WLAuthorizationManager.obtainAccessToken` para verificar a conectividade com o servidor e aplicar regras de gerenciamento de aplicativo. |
| `WL.Client.setUserPref(key,value, options)`, `WL.Client.setUserPrefs(userPrefsHash, options)`, `WL.Client.deleteUserPrefs(key, options)` | Nenhuma substituição. É possível usar um adaptador e a API `MFP.Server.getAuthenticatedUser` para gerenciar preferências do usuário. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Nenhuma substituição. |
| `WL.Client.logActivity(activityType)` | Use `WL.Logger`. |
| `WL.Client.login(realm, options)` | Use `WLAuthorizationManager.login`. Para iniciar a autenticação e a segurança, consulte os tutoriais Autenticação e Segurança. |
| `WL.Client.logout(realm, options)` | Use `WLAuthorizationManager.logout`. |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | Use `WLAuthorizationManager.obtainAccessToken`. |
| `WL.Client.transmitEvent(event, immediate)`, `WL.Client.purgeEventTransmissionBuffer()`, `WL.Client.setEventTransmissionPolicy(policy)` | Crie um adaptador customizado para receber notificações desses eventos. |
| `WL.Device.getContext()`, `WL.Device.startAcquisition(policy, triggers, onFailure)`, `WL.Device.stopAcquisition()`, `WL.Device.Wifi`, `WL.Device.Geo.Profiles`, `WL.Geo` | Use API nativa ou plug-ins Cordova de terceiros para localização geográfica. |
| `WL.Client.makeRequest (url, options)` | Crie um adaptador customizado que forneça a mesma funcionalidade |
| `WLDevice.getID(options)` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, `device.uuid` do plug-in c**ordova-plugin-device** fornece esse recurso. |
| `WL.Device.getFriendlyName()` | Use `WL.Client.getDeviceDisplayName` |
| `WL.Device.setFriendlyName()` | Use `WL.Client.setDeviceDisplayName` |
| `WL.Device.getNetworkInfo(callback)` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, o plug-in **cordova-plugin-network-information** fornece esse recurso. |
| `WLUtils.wlCheckReachability()` | Crie um adaptador customizado que verifique a disponibilidade do servidor. |
| `WL.EncryptedCache` | Use JSONStore para armazenar dados criptografados localmente. JSONStore está no plug-in **cordova-plugin-mfp-jsonstore**. Para obter mais informações, consulte [JSONStore](../../../application-development/jsonstore). |
| `WL.SecurityUtils.remoteRandomString(bytes)` | Crie um adaptador customizado que forneça a mesma funcionalidade. |
| `WL.Client.getAppProperty(property)` | É possível recuperar a propriedade da versão do aplicativo usando o plug-in **cordova-plugin-appversion**. A versão retornada é a versão do aplicativo nativo (somente Android e iOS). |
| `WL.Client.Push.*` | Use a API de push do lado do cliente de JavaScript do plug-in **cordova-plugin-mfp-push**. |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | Use `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)` para registrar o dispositivo para push e SMS. |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | Use `WLAuthorizationManager.obtainAccessToken` para obter um token para o escopo necessário. |
| `WLClient.getLastAccessToken(scope)` | Use `WLAuthorizationManager.obtainAccessToken` |
| `WLClient.getLoginName()`, `WL.Client.getUserName(realm)` | Nenhuma substituição |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | Use `WLAuthorizationManager.isAuthorizationRequired` e `WLAuthorizationManager.getResourceScope`. |
| `WL.Client.isUserAuthenticated(realm)` | Nenhuma substituição |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | Nenhuma substituição |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | Nenhuma substituição |
| `WL.Client.createChallengeHandler(realmName)` | Para criar um manipulador de desafios para manipulação de desafios de gateway customizados, use `WL.Client.createGatewayChallengeHandler(gatewayName)`. Para criar um manipulador de desafios para manipular desafios de verificação de segurança do {{ site.data.keys.product_adj }}, use `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
| `WL.Client.createWLChallengeHandler(realmName)` | Use `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
| `challengeHandler.isCustomResponse()`, em que challengeHandler é um objeto manipulador de desafios que é retornado por `WL.Client.createChallengeHandler()` | Use `gatewayChallengeHandler.canHandleResponse()`, em que `gatewayChallengeHandler` é um objeto manipulador de desafios que é retornado por `WL.Client.createGatewayChallengeHandler()`. |
| `wlChallengeHandler.processSucccess()`, em que `wlChallengeHandler` é um objeto manipulador de desafios que é retornado pelo `WL.Client.createWLChallengeHandler()` | Use `securityCheckChallengeHandler.handleSuccess()`, em que `securityCheckChallengeHandler` é um objeto manipulador de desafios que é retornado por `WL.Client.createSecurityCheckChallengeHandler()`. |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | Implemente uma lógica semelhante em seu manipulador de desafios. Para manipuladores de desafios de gateway customizados, use um objeto manipulador de desafios que é retornado por `WL.Client.createGatewayChallengeHandler()`. Para manipuladores de desafios de verificação de segurança do {{ site.data.keys.product_adj }}, use um objeto manipulador de desafios que é retornado por `WL.Client.createSecurityCheckChallengeHandler()`. |
| `WL.Client.createProvisioningChallengeHandler()` | Nenhuma substituição. O fornecimento de dispositivo é agora manipulado automaticamente pela estrutura de segurança. |

#### APIs de JavaScript descontinuadas
{: #deprecated-javascript-apis }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`, `WL.Client.invokeProcedure(invocationData, options)`, `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`, `WLProcedureInvocationResult` | Use `WLResourceRequest`. **Nota:** a implementação de `invokeProcedure` usa `WLResourceRequest`. |
| `WLClient.getEnvironment` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, o plug-in **device.platform** fornece esse recurso. |
| `WLClient.getLanguage` | Use plug-ins Cordova que fornecem essa funcionalidade. **Nota:** para sua informação, o plug-in **cordova-plugin-globalization** fornece esse recurso. |
| `WL.Client.connect(options)` | Use `WLAuthorizationManager.obtainAccessToken` para verificar a conectividade com o servidor e aplicar regras de gerenciamento de aplicativo. |

### APIs Android
{: #android-apis}
####  Elementos de API Android descontinuados
{: #discontinued-android-api-elements }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WLConfig WLClient.getConfig()` | Nenhuma substituição. |
| `WLDevice WLClient.getWLDevice()`, `WLClient.transmitEvent(org.json.JSONObject event)`, `WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`, `WLClient.purgeEventTransmissionBuffer()` | Use API Android ou pacotes de terceiros para localização geográfica. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Nenhuma substituição. |
| `WL.Client.getUserInfo(realm, key`, `WL.Client.updateUserInfo(options)` | Nenhuma substituição. |
| `WLClient.checkForNotifications()` | Use `WLAuthorizationManager.obtainAccessToken("", listener)` para verificar a conectividade com o servidor e aplicar regras de gerenciamento de aplicativo. |
| `WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.login(java.lang.String realmName, WLRequestListener listener)` | Use `AuthorizationManager.login()` |
| `WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.logout(java.lang.String realmName, WLRequestListener listener)` | Use `AuthorizationManager.logout()` |
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | Use `WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)` para verificar a conectividade com o servidor e aplicar regras de gerenciamento de aplicativo |
| `WLClient.getLastAccessToken()`, `WLClient.getLastAccessToken(java.lang.String scope)` | Use `AuthorizationManager` |
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | Use `AuthorizationManager` |
| `WLClient.logActivity(java.lang.String activityType)` | Use `com.worklight.common.Logger`. Para obter mais informações, consulte o Logger SDK. |
| `WLAuthorizationPersistencePolicy` | Nenhuma substituição. Para implementar persistência de autorização, armazene o token de autorização no código do aplicativo e crie solicitações HTTP customizadas. |
| `WLSimpleSharedData.setSharedToken(myName, myValue)`, `WLSimpleSharedData.getSharedToken(myName)`, `WLSimpleSharedData.clearSharedToken(myName)` | Use as APIs Android para compartilhar tokens em aplicativos. |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | Nenhuma substituição |
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | Use `BaseChallengeHandler.cancel()` |
| `ChallengeHandler` | Para desafios de gateway customizados, use `GatewayChallengeHandler`. Para desafios de verificação de segurança do {{ site.data.keys.product_adj }}, use `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler` | Use `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.isCustomResponse()` | Use `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implemente uma lógica semelhante em seu manipulador de desafios. Para manipuladores de desafio de gateway customizados, use `GatewayChallengeHandler`. |

#### APIs Android descontinuadas
{: #deprecated-android-apis }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` | Desaprovado. Use `WLResourceRequest`. **Nota:** a implementação de `invokeProcedure` usa `WLResourceRequest`. |
| `WLClient.connect(WLResponseListener responseListener)`, `WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` | Use `WLAuthorizationManager.obtainAccessToken("", listener)` para verificar a conectividade com o servidor e aplicar regras de gerenciamento de aplicativo. |

#### APIs do Android dependendo das APIs org.apach.http anteriores não são mais suportadas
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `org.apache.http.Header[]` foi descontinuado. Portanto, os métodos a seguir foram removidos:||
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | Use no lugar a nova API `Map<String, List<String>> WLResourceRequest.getAllHeaders()`. |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | Use a nova API `WLResourceRequest.addHeader(String name, String value)`. |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | Use no lugar a nova API `List<String> WLResourceRequest.getHeaders(String headerName)`. |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | Use no lugar a nova API `WLResourceRequest.getHeaders(String headerName)`. |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | Use no lugar a nova API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | Use no lugar a nova API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | Substituído por `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | Nenhuma substituição. Cliente MFP permite redirecionamentos circulares. |
| `WLHttpResponseListener`, `WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`, `WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`, `WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`, `WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`, `WLResourceRequest.send(WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` | Removido devido às dependências do cliente Apache HTTP descontinuadas. Crie sua própria solicitação para ter controle total sobre a solicitação e a resposta. |

#### O pacote `com.worklight.androidgap.api` fornece a funcionalidade da plataforma Android para aplicativos Cordova. No
{{ site.data.keys.product }}, foram feitas inúmeras mudanças para acomodar a integração do Cordova.
{: #comworklightandroidgapapi }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| A atividade do Android foi substituída pelo contexto do Android. | |
| `static WL.createInstance(android.app.Activity activity)` | `static WL.createInstance(android.content.Context context)` cria uma instância compartilhada. |
| `static WL.getInstance()` |  `static WL.getInstance()` obtém uma instância da classe WL. Esse método não pode ser chamado antes de `WL.createInstance(Context)`. |

### APIs de Objective-C
{: #objective-c-apis }
#### APIs Objective C do iOS descontinuadas
{: #discontinued-ios-objective-c-apis }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `[WLClient getWLDevice][WLClient transmitEvent:]`, `[WLClient setEventTransmissionPolicy]`, `[WLClient purgeEventTransmissionBuffer]` | Localização geográfica removida. Use pacotes iOS nativo ou de terceiros para localização geográfica. |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Nenhuma substituição. |
| `WL.Client.deleteUserPref(key, options)` | Nenhuma substituição. É possível usar um adaptador e a API `MFP.Server.getAuthenticatedUser` para gerenciar preferências do usuário. |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | Use `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient login:withDelegate:]` | Use `WLAuthorizationManager login`. |
| `[WLClient logout:withDelegate:]` | Use `WLAuthorizationManager logout`. |
| `[WLClient lastAccessToken]`, `[WLClient lastAccessTokenForScope:]` | Use `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient obtainAccessTokenForScope:withDelegate:]`, `[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` | Use `WLAuthorizationManager obtainAccessTokenForScope`. |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | Use API de push do lado do cliente de Objective-C para aplicativos iOS a partir da estrutura IBMMobileFirstPlatformFoundationPush framework |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | Use API de push do lado do cliente de Objective-C para aplicativos iOS a partir da estrutura IBMMobileFirstPlatformFoundationPush. |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | Desaprovado. Use `WLResourceRequest`. |
| `WLClient sendUrlRequest:delegate:]` | Use `[WLResourceRequest sendWithDelegate:delegate]` no lugar. |
| `[WLClient (void) logActivity:(NSString *) activityType]` | Removido. Use um criador de logs Objective C. |
| `[WLSimpleDataSharing setSharedToken: myName value: myValue]`, `[WLSimpleDataSharing getSharedToken: myName]]`, `[WLSimpleDataSharing clearSharedToken: myName]` | Use as APIs do sistema operacional para compartilhar tokens entre aplicativos. |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | Use `BaseChallengeHandler.cancel()`. |
| `BaseProvisioningChallengeHandler` | Nenhuma substituição. O fornecimento de dispositivo é agora manipulado automaticamente pela estrutura
de segurança. |
| `ChallengeHandler` | Para desafios de gateway customizados, use `GatewayChallengeHandler`. Para desafios de verificação de segurança do
{{ site.data.keys.product_adj }},
use `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler` | Use `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.isCustomResponse()` | Use `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implemente uma lógica semelhante em seu manipulador de desafios. Para manipuladores de desafio de gateway customizados, use `GatewayChallengeHandler`. Para manipuladores de desafio de verificação de segurança do {{ site.data.keys.product_adj }}, use `SecurityCheckChallengeHandler`. |

### APIs de C# do Windows
{: #windows-c-apis }
#### Elementos de API de C# do Windows descontinuados - Classes
{: #deprecated-windows-c-api-elements-classes }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `ChallengeHandler` | Para desafios de gateway customizados, use `GatewayChallengeHandler`. Para desafios de verificação de segurança do
{{ site.data.keys.product_adj }},
use `SecurityCheckChallengeHandler`. |
| `ChallengeHandler. isCustomResponse()` | Use `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implemente uma lógica semelhante em seu manipulador de desafios. Para manipuladores de desafio
de gateway customizados, use `GatewayChallengeHandler`. Para manipuladores de desafio de verificação de segurança do
{{ site.data.keys.product_adj }},
use `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | Para manipuladores de desafio de gateway customizados, use `GatewayChallengeHandler.Shouldcancel`. Para manipuladores de desafio de verificação de segurança do {{ site.data.keys.product_adj }}, use `SecurityCheckChallengeHandler.ShouldCancel`. |
| `WLAuthorizationManager` | Use `WorklightClient.WorklightAuthorizationManager`. |
| `WLChallengeHandler` | Use `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)` | Use `SecurityCheckChallengeHandler.ShouldCancel()`. |
| `WLClient` | Use `WorklightClient`. |
| `WLErrorCode` | Não suportada. |
| `WLFailResponse` | Use `WorklightResponse`. |
| `WLResponse` | Use `WorklightResponse`. |
| `WLProcedureInvocationData` | Use `WorklightProcedureInvocationData`. |
| `WLProcedureInvocationFailResponse` | Não suportada. |
| `WLProcedureInvocationResult` | Não suportada. |
| `WLRequestOptions` | Não suportada. |
| `WLResourceRequest` | Não suportada. |

#### Elementos de API de C# do Windows descontinuados - Interfaces
{: #deprecated-windows-c-api-elements-interfaces }

| Elemento da API           | Caminho de Migração                           |
|-----------------------|------------------------------------------|
| `WLHttpResponseListener` | Não suportada. |
| `WLResponseListener` | A resposta estará disponível como um objeto `WorklightResponse` |
| `WLAuthorizationPersistencePolicy` | Não suportada. |
