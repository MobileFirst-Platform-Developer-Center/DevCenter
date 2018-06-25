---
layout: tutorial
title: O que há de novo
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
O {{ site.data.keys.product_full }} V8.0 traz mudanças significativas que modernizam sua experiência de desenvolvimento, implementação e gerenciamento de aplicativos no {{ site.data.keys.product_adj }}.

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">O que há de novo na construção de aplicativos</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>O {{ site.data.keys.product }} SDK e a interface da linha de comandos foram projetados novamente para fornecerem mais flexibilidade e eficiência para desenvolver seus aplicativos. Além disso, agora é possível usar qualquer uma de suas ferramentas Cordova preferenciais ao desenvolver aplicativos multiplataformas.</p>

                <p>Revise as seções a seguir para saber o que há de novo no desenvolvimento de aplicativos.</p>

                <h3>Novo processo de desenvolvimento e implementação</h3>
                <p>Você não cria mais um arquivo WAR do projeto que precisa ser instalado no servidor de aplicativos. Em vez disso, o {{ site.data.keys.mf_server }} é instalado uma vez e você faz upload da configuração do lado do servidor de seus aplicativos, da segurança do recurso ou do serviço de push para o servidor. É possível modificar a configuração de seus aplicativos com o {{ site.data.keys.mf_console }}.</p>

                <p>Os projetos do {{ site.data.keys.product_adj }} não existem mais. Ao invés disso, você desenvolve seu aplicativo móvel com o ambiente de desenvolvimento de sua escolha.<br/>
                É possível modificar a configuração do lado do servidor de seus aplicativos e adaptadores sem parar o {{ site.data.keys.mf_server }}.</p>

                <ul>
                    <li>Para obter mais informações sobre o novo processo de desenvolvimento, consulte <a href="../../../application-development/">Conceitos e visão geral de desenvolvimento</a></li>
                    <li>Para obter mais informações sobre a migração de aplicativos existentes, consulte <a href="../../../upgrading/migration-cookbook">o Cookbook de migração</a>.</li>
                    <li>Para obter mais informações sobre como administrar aplicativos {{ site.data.keys.product_adj }}, consulte Administrando aplicativos {{ site.data.keys.product_adj }}.</li>
                </ul>

                <h3>Aplicativos para Web</h3>
                <p>Agora é possível usar a API JavaScript do lado do cliente do {{ site.data.keys.product_adj }} para desenvolver aplicativos da web com ferramentas preferenciais e IDE. É possível registrar seu aplicativo da web no {{ site.data.keys.mf_server }} para incluir recursos de segurança no aplicativo.</p>

                <p>Também é possível usar a nova API de análise de dados da web JavaScript do lado do cliente como parte do novo SDK da web para incluir recursos do {{ site.data.keys.mf_analytics }} em seu aplicativo da web.</p>

                <h3>Desenvolva aplicativos multiplataformas com suas ferramentas Cordova preferenciais</h3>
                <p>Agora é possível usar suas ferramentas Cordova preferenciais (como Apache Cordova CLI ou Ionic Framework) para desenvolver seus aplicativos híbridos entre plataformas. Você obtém essas ferramentas independentemente do {{ site.data.keys.product }} e, em seguida, inclui plug-ins do {{ site.data.keys.product_adj }} para fornecer recursos backend do {{ site.data.keys.product_adj }}.</p>

                <p>É possível instalar o plug-in do Eclipse do {{ site.data.keys.product }} Studio para gerenciar seus aplicativos Cordova entre plataformas ativados com o {{ site.data.keys.product }} no ambiente de desenvolvimento do Eclipse. O plug-in {{ site.data.keys.product }} Studio também fornece comandos de {{ site.data.keys.mf_cli }} adicionais que podem ser executados de dentro do ambiente do Eclipse.</p>

                <h3>Componentização SDK</h3>
                <p>Anteriormente, o SDK do cliente {{ site.data.keys.product_adj }} era entregue como uma estrutura única ou arquivo JAR. Agora é possível escolher incluir ou excluir funcionalidades específicas. Além do SDK principal, cada API do {{ site.data.keys.product_adj }} possui seu próprio conjunto de componentes opcionais.</p>

                <h3>Nova e melhorada interface da linha de comandos de desenvolvimento (CLI)</h3>
                <p>A {{ site.data.keys.mf_cli }} foi projetada novamente para aumentar a eficiência de desenvolvimento, incluindo o uso em scripts automatizados. Os comandos agora iniciam com o prefixo mfpdev. A CLI está incluída no {{ site.data.keys.mf_dev_kit_full }} ou é possível fazer rapidamente o download da versão mais recente da CLI no npm.</p>

                <h3>Ferramenta de assistência de migração</h3>
                <p>Uma ferramenta de assistência de migração simplifica o procedimento para migrar seus aplicativos existentes para o {{ site.data.keys.product }} versão 8.0. A ferramenta varre seus aplicativos {{ site.data.keys.product_adj }} existentes e cria uma lista das APIs que são usadas no arquivo que são removidas, descontinuadas ou substituídas na versão 8.0. Ao executar a ferramenta de assistência de migração em aplicativos Apache Cordova que foram criados com o {{ site.data.keys.product }}, ela cria uma nova estrutura Cordova para o aplicativo compatível com a versão 8.0. Para obter mais informações sobre a ferramenta de assistência de migração.</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>A partir do Cordova 4.0, o WebView plugável permite que o tempo de execução da web padrão seja substituído. Agora o Crosswalk é suportado pelos aplicativos Cordova com {{ site.data.keys.product }}. Usar o Crosswalk WebView for Android permite uma experiência do usuário de alto desempenho e consistente entre uma ampla gama de dispositivos móveis. Para aproveitar os recursos do Crosswalk, aplique o plug-in do Cordova Crosswalk.</p>

                <h3>Distribuindo os aplicativos {{ site.data.keys.product_adj }} SDK for Windows 8 e Windows 10 Universal com NuGet</h3>
                <p>Os aplicativos {{ site.data.keys.product_adj }} SDK for Windows 8 e Windows 10 Universal estão disponíveis no NuGet em <a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>. Para iniciar,</p>

                <h3>org.apache.http substituído por okHttp</h3>
                <p><code>org.apache.http</code> foi removido do Android SDK. okHttp será usado como a dependência http.</p>

                <h3>Suporte do WKWebView para aplicativos Cordova híbridos do iOS</h3>
                <p>Agora é possível substituir o UIWebView padrão em aplicativos Cordova com o WKWebView.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">O que há de novo nas APIs do MobileFirst</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>Os novos recursos melhoram e estendem as APIs que podem ser usadas para desenvolver aplicativos móveis. Use as APIs mais recentes para aproveitar as vantagens de funções novas, melhoradas ou alteradas no {{ site.data.keys.product }}.</p>

                <h3>API do lado do servidor de JavaScript atualizada</h3>
                <p>Funções de chamada de backend são suportadas apenas para tipos de adaptadores suportados. Atualmente, somente adaptadores HTTP e SQL são suportados, portanto, invocadores de backend <code>WL.Server.invokeHttp</code> e <code>WL.Server.invokeSQL</code> são suportados, também.</p>

                <h3>Nova API Java do lado do servidor</h3>
                <p>Uma nova API Java do lado do servidor é fornecida, que pode ser usada para estender o {{ site.data.keys.mf_server }}.</p>

                <h4>Nova API Java do lado do servidor para segurança</h4>
                <p>O novo pacote de API de segurança, <code>com.ibm.mfp.server.security.external</code>, e seus pacotes contidos incluem as interfaces necessárias para desenvolver verificações de segurança e adaptadores que usam o contexto de verificação de segurança.</p>

                <h4>Nova API Java do lado do servidor para dados de registro do cliente</h4>
                <p>O novo pacote de API de dados de registro do cliente, <code>com.ibm.mfp.server.registration.external</code>, e seus pacotes contidos incluem uma interface para fornecer acesso a dados persistentes de registro do cliente do {{ site.data.keys.product_adj }}.</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>Com esta nova API, é possível retornar o aplicativo JAX-RS para o adaptador.</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>Com esta nova API, é possível obter o valor da configuração de adaptador (ou valor padrão).</p>

                <h3>API Java do lado do servidor atualizada</h3>
                <p>Uma API Java do lado do servidor atualizada é fornecida, que pode ser usada para estender o {{ site.data.keys.mf_server }}.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>A assinatura dessa nova API não mudou nesta versão. No entanto, seu comportamento agora é idêntico ao de <code>String getPropertyValue (String propertyName)</code>, que está descrito em Nova API Java do lado do servidor.</p>

                <h4>WLServerAPIProvider</h4>
                <p>Na V7.0.0 e V7.1.0, a API Java estava acessível por meio da interface WLServerAPIProvider. Por exemplo: <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> e <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>Essas interfaces estáticas ainda são suportadas para permitir que os adaptadores que foram desenvolvidos em versões anteriores do produto compilem e implementem. Adaptadores antigos que não usam notificações push ou a API de segurança anterior continuam a funcionar com a nova versão. Os adaptadores que usam notificações push ou a API de segurança anterior não funcionam.</p>

                <h3>APIs do lado do cliente JavaScript para aplicativos da web</h3>
                <p>A API do lado do cliente JavaScript que é usada para o desenvolvimento de aplicativos Cordova multiplataformas agora está disponível para o desenvolvimento de aplicativos da web, com pequenas variações no método de inicialização. Observe que nem todas as funções da API JavaScript são aplicáveis aos aplicativos da web.</p>

                <p>Além disso, uma nova API de análise de dados da web do lado do cliente JavaScript é fornecida para a inclusão de recursos do {{ site.data.keys.mf_analytics }} em seu aplicativo da web.</p>

                <h3>API C# do lado do cliente atualizada para o Windows 8 Universal e o Windows Phone 8 Universal</h3>
                <p>A API C# do lado do cliente para o Windows 8 Universal e o Windows Phone 8 Universal mudou.</p>

                <h3>Novas APIs Java do lado do cliente para Android</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>Com este novo método, é possível obter o nome de exibição de um dispositivo a partir dos dados de registro do {{ site.data.keys.mf_server }}.</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>Com este novo método, é possível obter o nome de exibição de um dispositivo nos dados de registro do {{ site.data.keys.mf_server }}.</p>

                <h3>Novas APIs do lado do cliente Objective-C para iOS</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>Com este novo método, é possível obter o nome de exibição de um dispositivo a partir dos dados de registro do {{ site.data.keys.mf_server }}.</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>Com este novo método, é possível obter o nome de exibição de um dispositivo nos dados de registro do {{ site.data.keys.mf_server }}.</p>

                <h3>API REST atualizada para o serviço de administração</h3>
                <p>A API REST para o serviço de administração foi parcialmente refatorada. Em particular, a API para indicadores e mediadores foi removida e a maioria dos serviços REST para notificação push agora faz parte da API REST para o serviço push.</p>

                <h3>API REST atualizada para o tempo de execução</h3>
                <p>A API REST para o tempo de execução do {{ site.data.keys.product_adj }} agora fornece vários serviços para clientes móveis e clientes confidenciais para chamar adaptadores, obter tokens de acesso, obter conteúdo de Atualização direta e mais. A maioria dos terminais de API REST é protegida por OAuth. Em um servidor de desenvolvimento, é possível visualizar o doc do Swagger para a API de tempo de execução em: <code>http(s)://server_ip:server_port/context_root/doc</code>.</p>

                <h3>Suporte de fixação de certificado múltiplo</h3>
                <p>Iniciando com iFix 8.0.0.0-IF201706240159, o {{ site.data.keys.mf_bm_short }} suporta a fixação de vários certificados. Isso permite que usuários tenham acesso seguro a diversos hosts. Antes desta iFix, o {{ site.data.keys.mf_bm_short }} suportava fixação de um único certificado. O {{ site.data.keys.mf_bm_short }} introduziu uma nova API, que permite conexão com vários hosts, permitindo que o usuário fixe chaves públicas de vários certificados X509 (adquiridas com uma autoridade de certificação) para o aplicativo cliente. Uma cópia de todos os certificados deve ser colocada em seu aplicativo cliente. Durante o handshake SSL, o cliente SDK do {{ site.data.keys.product_full }} verifica se a chave pública do certificado do servidor corresponde à chave pública de um dos certificados armazenados no aplicativo.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">O que há de novo na segurança do MobileFirst</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>A estrutura de segurança no {{ site.data.keys.product }} foi toda projetada novamente. Novos recursos de segurança foram introduzidos e algumas modificações foram feitas em recursos existentes.</p>

                <h3>Revisão de estrutura de segurança</h3>
                <p>A estrutura de segurança do {{ site.data.keys.product_adj }} foi projetada e implementada novamente para melhorar e simplificar as tarefas de administração e desenvolvimento de segurança. A estrutura agora é baseada inerentemente no modelo OAuth e a implementação é independente de sessão. Consulte Visão geral da estrutura de segurança do {{ site.data.keys.product_adj }}.</p>

                <p>No lado do servidor, os diversos blocos de construção da estrutura foram substituídos por verificações de segurança (implementado em adaptadores), permitindo o desenvolvimento simplificado com novas APIs. As implementações de amostra e as verificações de segurança predefinidas são fornecidas. Veja Verificações de segurança. As verificações de segurança podem ser configuradas no descritor de adaptador e customizadas fazendo mudanças de configuração de adaptador de tempo de execução ou aplicativo, sem reimplementar o adaptador ou interromper o fluxo. As configurações podem ser feitas a partir das interfaces de segurança do {{ site.data.keys.mf_console }} projetadas novamente. Também é possível editar os arquivos de configuração manualmente ou usar as ferramentas {{ site.data.keys.mf_cli }} ou mfpadm.</p>

                <h3>Verificação de segurança de autenticidade do aplicativo</h3>
                <p>Agora a validação de autenticidade do aplicativo {{ site.data.keys.product_adj }} é implementada como uma verificação de segurança predefinida que substitui a "verificação da autenticidade do aplicativo estendida". É possível ativar, desativar e configurar dinamicamente a validação de autenticidade do aplicativo usando {{ site.data.keys.mf_console }} ou mfpadm. Uma ferramenta Java de autenticidade do aplicativo {{ site.data.keys.product_adj }} independente (mfp-app-authenticity-tool.jar) é fornecida para gerar um arquivo de autenticidade do aplicativo.</p>

                <h3>Clientes confidenciais</h3>
                <p>O suporte para clientes confidenciais foi projetado novamente e reimplementado usando a nova estrutura de segurança OAuth.</p>

                <h3>Segurança de aplicativos da web</h3>
                <p>A estrutura de segurança baseada em OAuth revisada suporta aplicativos da web. Agora é possível registrar aplicativos da web com {{ site.data.keys.mf_server }} para incluir recursos de segurança em seu aplicativo e proteger o acesso aos recursos da web. Para obter mais informações sobre o desenvolvimento de aplicativos da web {{ site.data.keys.product_adj }}, consulte Desenvolvendo aplicativos da web. A verificação de segurança de autenticidade do aplicativo não é suportada para aplicativos da web.</p>

                <h3>Aplicativos de plataforma cruzada (aplicativos Cordova), recursos de segurança novos e mudados</h3>
                <p>Recursos de segurança adicionais estão disponíveis para ajudar a proteger seu aplicativo Cordova. Esses recursos incluem o seguinte:</p>

                <ul>
                    <li>Criptografia de recursos da web: Use este recurso para criptografar os recursos da web em seu pacote Cordova para ajudar a evitar que alguém modifique o pacote.</li>
                    <li>Soma de verificação de recursos da web: Use este recurso para executar um teste de soma de verificação que compare as atuais estatísticas de recursos da web do aplicativo com as estatísticas de linha de base que foram estabelecidas quando ele foi aberto pela primeira vez. Essa verificação ajuda a evitar que alguém modifique o aplicativo após ele ser instalado e aberto.</li>
                    <li>Fixação de certificado: Use este recurso para associar o certificado de um aplicativo a um certificado no servidor host. Esse recurso ajuda a evitar que as informações passadas entre o aplicativo e o servidor sejam visualizadas ou modificadas.</li>
                    <li>Suporte para Federal Information Processing Standard (FIPS) 140-2: Use este recurso para assegurar que os dados que são transferidos estejam em conformidade com o padrão de criptografia FIPS 140-2.</li>
                    <li>OpenSSL: para usar a criptografia e decriptografia de dados OpenSSL com seu aplicativo Cordova para a plataforma iOS, é possível usar o plug-in do Cordova cordova-plugin-mfp-encrypt-utils.</li>
                </ul>

                <h3>Conexão única do dispositivo</h3>
                <p>Agora a conexão única (SSO) do dispositivo é suportado por meio da nova propriedade de configuração do descritor de aplicativo de verificação de segurança <code>enableSSO</code> predefinida.</p>

                <h3>Atualização Direta</h3>
                <p>Em contraste com as versões anteriores do {{ site.data.keys.product_adj }}, a partir da V8.0</p>

                <ul>
                    <li>Se um aplicativo cliente acessar um recurso desprotegido, o aplicativo não receberá atualizações, mesmo se uma atualização estiver disponível no {{ site.data.keys.mf_server }}.</li>
                    <li>Após ser ativado, o Direct Update será forçado em cada solicitação para um recurso protegido.</li>
                </ul>

                <h3>Proteção de recursos externos</h3>
                <p>O método suportado e os artefatos fornecidos para proteger recursos em servidores externos foram modificados:</p>

                <ul>
                    <li>Um novo módulo de token de acesso {{ site.data.keys.product_adj }} Java Token Validator configurável é fornecido para usar a estrutura de segurança do {{ site.data.keys.product_adj }} para proteger recursos em qualquer servidor Java externo. O módulo é fornecido como uma biblioteca Java (mfp-java-token-validador-8.0.0.jar) e substitui o uso do terminal de validação do token do {{ site.data.keys.mf_server }} obsoleto para criar um módulo de validação Java customizado.</li>
                    <li>O filtro {{ site.data.keys.product_adj }} OAuth Trust Association Interceptor (TAI), para proteger recursos Java em um servidor WebSphere Application Server ou WebSphere Application Server Liberty, agora é fornecido como uma biblioteca Java (com.ibm.imf.oauth.common_8.0.0.jar). A biblioteca usa o novo módulo de validação Java Token Validador e a configuração do TAI fornecida mudada.</li>
                    <li>A API {{ site.data.keys.product_adj }} OAuth do lado do servidor TAI não é mais necessária e foi removida.</li>
                    <li>A estrutura passport-mfp-token-validation {{ site.data.keys.product_adj }} Node.js, para proteger recursos Java em um servidor Node.js externo, foi modificada para suportar a nova estrutura de segurança.</li>
                    <li>Também é possível gravar seu próprio filtro customizado e módulo de validação, para qualquer tipo de servidor de recurso, que use o novo terminal de introspecção do servidor de autorização.</li>
                </ul>

                <h3>Integração com o WebSphere DataPower como um servidor de autorizações</h3>
                <p>Agora é possível optar por usar o WebSphere DataPower como o servidor de autorizações OAuth, em vez do servidor de autorizações padrão do {{ site.data.keys.mf_server }}. É possível configurar o DataPower para integração com a estrutura de segurança do {{ site.data.keys.product_adj }}.</p>

                <h3>Verificação de segurança de conexão única (SSO) baseada em LTPA</h3>
                <p>Suporte para compartilhamento de autenticação do usuário entre servidores que usam Lightweight Third Party Authentication (LTPA) do WebSphere agora é fornecido usando a nova verificação de segurança predefinida de conexão única (SSO) baseada em LTPA. Essa verificação substitui o domínio {{ site.data.keys.product_adj }} LTPA obsoleto e elimina a configuração necessária anterior.</p>

                <h3>Gerenciamento de aplicativo móvel com o {{ site.data.keys.mf_console }}</h3>
                <p>Algumas mudanças foram feitas no suporte para rastreamento e gerenciamento de aplicativos móveis, usuários e dispositivos do {{ site.data.keys.mf_console }}. O bloqueio de acesso ao dispositivo ou ao aplicativo é aplicável somente a tentativas de acessar recursos protegidos.</p>

                <h3>Armazenamento de chaves do {{ site.data.keys.mf_server }}</h3>
                <p>Um único keystore do {{ site.data.keys.mf_server }} é usado para assinar tokens OAuth e pacotes de Atualização Direta e para autenticação mútua HTTPS (SSL). É possível configurar dinamicamente esse keystore usando {{ site.data.keys.mf_console }} ou mfpadm.</p>

                <h3>Criptografia e decriptografia nativas para iOS</h3>
                <p>OpenSSL foi removido da estrutura principal para iOS e substituído por uma criptografia/decriptografia nativa. OpenSSL pode ser incluído como uma estrutura separada. Consulte Ativando OpenSSL for iOS. Para iOS Cordova JavaScript, o OpenSSL ainda está integrado à estrutura principal. Para ambas as APIs, tanto a criptografia nativa quanto a OpenSSL estão disponíveis.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">O que há de novo no suporte ao sistema operacional</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>O {{ site.data.keys.product }} agora suporta aplicativos Windows 10 Universal, compilações de bitcode e Apple watchOS 2.</p>

                <h3>Suporte para aplicativos universais para Windows 10 Native</h3>
                <p>Com o {{ site.data.keys.product }}, agora é possível gravar aplicativos C# Universal App Platform nativos para usar o {{ site.data.keys.product_adj }} SDK dentro de seu aplicativo.</p>

                <h3>Suporte para ambientes híbridos do Windows</h3>
                <p>Suporte do Windows 10 Universal Windows Platform (UWP) para ambientes híbridos do Windows. Para obter mais informações sobre como iniciar.</p>

                <h3>Fim de suporte ao BlackBerry</h3>
                <p>O ambiente BlackBerry não é mais suportado no {{ site.data.keys.product }}.</p>

                <h3>Bitcode</h3>
                <p>Compilações de bitcode agora são suportadas para projetos iOS. Entretanto, a verificação de segurança de autenticidade do aplicativo {{ site.data.keys.product_adj }} não é suportada para compilação de aplicativos com bitcode.</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 agora é suportado e requer compilações de bitcode.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">O que há de novo na implementação e no gerenciamento de aplicativos</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Novos recursos do {{ site.data.keys.product }} foram introduzidos para ajudá-lo a implementar e gerenciar seus aplicativos. Agora é possível atualizar seus aplicativos e adaptadores sem reiniciar o {{ site.data.keys.mf_server }}.</p>

                <h3>Suporte melhorado ao DevOps</h3>
                <p>O {{ site.data.keys.mf_server }} foi projetado novamente de forma significativa para melhor suportar seu ambiente DevOps. O {{ site.data.keys.mf_server }} é instalado uma vez em seu ambiente de servidor de aplicativos e nenhuma mudança na configuração do servidor de aplicativos é necessária ao fazer upload de um aplicativo ou mudar a configuração do {{ site.data.keys.mf_server }}.</p>

                <p>Não é necessário reiniciar o {{ site.data.keys.mf_server }} ao atualizar seus aplicativos ou quaisquer adaptadores de que seus aplicativos dependem. É possível executar operações de configuração, ou fazer upload de uma nova versão de um adaptador ou registrar um novo aplicativo enquanto o servidor ainda estiver manipulando o tráfego.</p>

                <p>Mudanças na configuração e operações de desenvolvimento são protegidas pelas funções de segurança.</p>

                <p>É possível fazer upload de artefatos de desenvolvimento para os servidores de várias maneiras para oferecer mais flexibilidade operacional:</p>

                <ul>
                    <li>{{ site.data.keys.mf_console }} foi aprimorado: em particular, agora é possível usá-lo para registrar um aplicativo ou uma nova versão de um aplicativo, para gerenciar parâmetros de segurança do aplicativo e para implementar certificados, criar tags de notificação push e enviar notificações push. Agora o console inclui guias de ajuda contextual.</li>
                    <li>Ferramenta de linha de comandos</li>
                </ul>

                <p>Artefatos de desenvolvimento dos quais você faz upload para o servidor incluem adaptadores e sua configuração, configurações de segurança para seus aplicativos, certificados de notificação push e filtros de log.</p>

                <h3>Executando aplicativos criados no IBM Cloud no {{ site.data.keys.product }}</h3>
                <p>Desenvolvedores podem migrar aplicativos do IBM Cloud para serem executados no {{ site.data.keys.product }}. A migração requer que você faça mudanças na configuração para seu aplicativo cliente para corresponder às APIs do {{ site.data.keys.product }}.</p>

                <h3>{{ site.data.keys.product }} como um serviço no IBM Cloud</h3>
                <p>Agora, é possível usar o serviço {{ site.data.keys.mf_bm_full }} no IBM Cloud para criar e executar seus aplicativos móveis corporativos. </p>

                <h3>Nenhum arquivo .wlapp</h3>
                <p>Em versões anteriores, aplicativos eram implementados no {{ site.data.keys.mf_server }} fazendo upload de um arquivo <b>.wlapp</b>. O arquivo continha dados que descreviam o aplicativo e, no caso de aplicativos híbridos, os recursos da web que também eram necessários. Na V8.0.0, em vez do arquivo <b>.wlapp</b>:</p>

                <ul>
                    <li>Você registra um aplicativo no {{ site.data.keys.mf_server }} implementando um arquivo JSON do descritor de aplicativo.</li>
                    <li>Para atualizar aplicativos Cordova usando Direct Update, você faz upload de um archive (arquivo .zip) do recurso da web modificado para o servidor. O archive não contém mais os arquivos de visualização da web ou aparências que eram possíveis em versões anteriores do {{ site.data.keys.product }}. Eles foram descontinuados. O archive contém somente os recursos da web que são enviados para os clientes, bem como somas de verificação para validações do Direct Update.</li>
                </ul>

                <p>Para ativar a Atualização Direta de aplicativos Cordova do cliente que estão instalados em dispositivos do usuário final, deve-se agora implementar os recursos da web modificados como um archive (arquivo .zip) no servidor. Para ativar a Atualização Direta segura, um arquivo keystore definido pelo usuário deve ser implementado no {{ site.data.keys.mf_server }} e uma cópia da chave pública correspondente deve ser incluída no aplicativo cliente implementado.</p>

                <h3>Adaptadores</h3>
                <h4>Adaptadores são projetos do Apache Maven.</h4>
                <p>Adaptadores agora são tratados como projetos do Maven. É possível criar, construir e implementar adaptadores usando comandos Maven da linha de comandos padrão ou usando qualquer IDE que suporte Maven, como Eclipse e IntelliJ.</p>

                <h4>Configuração e implementação do adaptador em ambientes de DevOps</h4>
                <ul>
                    <li>Administradores do {{ site.data.keys.mf_server }} agora podem usar o {{ site.data.keys.mf_console }} para modificar o comportamento de um adaptador que foi implementado. Após a reconfiguração, as mudanças entram em vigor no servidor imediatamente, sem a necessidade de reimplementar o adaptador ou reiniciar o servidor.</li>
                    <li>Agora é possível efetuar "hot deploy" dos adaptadores, o que significa implementar, remover implementação e reimplementá-los no tempo de execução, enquanto o {{ site.data.keys.mf_server }} ainda está atendendo o tráfego.</li>
                </ul>

                <h4>Mudanças no arquivo descritor do adaptador</h4>
                <p>O arquivo descritor <b>adapter.xml</b> mudou ligeiramente. Para obter mais informações sobre a estrutura do arquivo descritor do adaptador para adaptadores, consulte os <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">tutoriais de Adaptadores</a>.</p>

                <h4>Integração com a UI Swagger</h4>
                <p>O {{ site.data.keys.mf_server }} agora se integra à UI do Swagger. Para qualquer adaptador, é possível visualizar a API associada clicando em Visualizar docs do Swagger na guia Recursos no {{ site.data.keys.mf_console }}. O recurso está disponível nos ambientes de desenvolvimento somente.</p>

                <h4>Suporte para adaptadores JavaScript</h4>
                <p>JavaScript adapters are supported with HTTP and SQL connectivity types, only.</p>

                <h4>Suporte para JAX-RS 2.0</h4>
                <p>JAX-RS 2.0 apresenta uma nova funcionalidade do lado do servidor: filtros e interceptores HTTP assíncronos do lado do servidor.  Os adaptadores agora podem explorar esses novos recursos.</p>

                <h3>{{ site.data.keys.product }} no IBM Containers</h3>
                <p>O {{ site.data.keys.product }} no IBM Containers liberado para a V8.0.0 está disponível no <a href="http://www-01.ibm.com/software/passportadvantage/">site do IBM Passport Advantage</a>. Essa versão do {{ site.data.keys.product }} no IBM Containers está pronta para produção e suporta o banco de dados transacional e corporativo dashDB™ no IBM Cloud. </p>

                <p><b>Nota:</b> consulte os pré-requisitos para implementar o {{ site.data.keys.product }} no IBM Containers.</p>

                <h3>Implementando o {{ site.data.keys.mf_server }} no IBM PureApplication System</h3>
                <p>Agora é possível implementar e configurar o {{ site.data.keys.mf_server }} no {{ site.data.keys.product }} System Pattern no IBM PureApplication System suportado.</p>

                <p>Todos os padrões do sistema do {{ site.data.keys.product }} suportados agora incluem suporte para um banco de dados IBM DB2 existente. {{ site.data.keys.mf_app_center_full }} agora é suportado em um Padrão de Sistema Virtual.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">O que há de novo no {{ site.data.keys.mf_server }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>O {{ site.data.keys.mf_server }} foi projetado novamente para ajudar a reduzir o tempo e o custo da implementação e da atualização de seus aplicativos. Além do novo design do {{ site.data.keys.mf_server }}, {{ site.data.keys.product }}o expande o número de métodos de instalação disponíveis.</p>

                <p>O novo design do {{ site.data.keys.mf_server }} apresenta dois novos componentes, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e os artefatos do {{ site.data.keys.mf_server }}.</p>

                <p>{{ site.data.keys.mf_server }} O serviço de atualização em tempo real do é projetado para ajudar a reduzir o tempo e o custo de atualizações incrementais de seus aplicativos. Ele gerencia e armazena os dados de configuração do lado do servidor dos aplicativos e adaptadores. É possível mudar ou atualizar várias partes do seu aplicativo reconstruindo ou reimplementando seu aplicativo:</p>

                <ul>
                    <li>Mude ou atualize dinamicamente o comportamento do aplicativo com base nos segmentos de usuário definidos por você.</li>
                    <li>Mude ou atualize dinamicamente a lógica de negócios no lado do servidor.</li>
                    <li>Mude ou atualize dinamicamente a segurança do aplicativo.</li>
                    <li>Externalize ou mude dinamicamente a configuração do aplicativo.</li>
                </ul>

                <p>Os artefatos do {{ site.data.keys.mf_server }} fornecem recursos para o {{ site.data.keys.mf_console }}.</p>

                <p>Além do novo design do {{ site.data.keys.mf_server }}, mais opções de instalação são agora fornecidas. Além da instalação manual, o {{ site.data.keys.product }} fornece duas opções para instalar o {{ site.data.keys.mf_server }} em um server farm. Também é possível instalar o {{ site.data.keys.mf_server }} no Liberty Collective.</p>

                <p>Agora é possível instalar os componentes do {{ site.data.keys.mf_server }} em um server farm usando tarefas Ant ou com o Server Configuration Tool. Para obter informações adicionais, consulte os seguintes tópicos:</p>

                <ul>
                    <li>Instalando um server farm</li>
                    <li>Tutoriais sobre a instalação do {{ site.data.keys.mf_server }}</li>
                </ul>

                <p>O {{ site.data.keys.mf_server }} também suporta o Liberty Collective. Para obter mais informações sobre a topologia do servidor e vários métodos de instalação, consulte os tópicos a seguir:</p>

                <ul>
                    <li>Topologia do Liberty Collective</li>
                    <li>Executando o Server Configuration Tool</li>
                    <li>Instalando com tarefas Ant</li>
                    <li>Instalação manual no WebSphere Application Server Liberty Collective</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">O que há de novo no {{ site.data.keys.mf_analytics }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }} apresenta um console reprojetado com melhorias na apresentação de informações e controles de acesso baseados em função. Agora o console também está disponível em inúmeros idiomas diferentes.</p>

                <p>O {{ site.data.keys.mf_analytics_console }} foi projetado novamente para apresentar informações de uma maneira mais significativa e intuitiva e usa dados resumidos para alguns tipos de eventos.</p>

                <p>Agora é possível sair do {{ site.data.keys.mf_analytics_console }} clicando no ícone de engrenagem.</p>

                <p>O {{ site.data.keys.mf_analytics_console }} está disponível nos idiomas a seguir:</p>
                <ul>
                    <li>alemão</li>
                    <li>Espanhol</li>
                    <li>Francês</li>
                    <li>FAR</li>
                    <li>japonês</li>
                    <li>Coreano</li>
                    <li>Português (Brasileiro)</li>
                    <li>Russo</li>
                    <li>Chinês Simplificado</li>
                    <li>Chinês tradicional</li>
                </ul>

                <p>O {{ site.data.keys.mf_analytics_console }} agora mostra conteúdo diferente baseado na função de segurança do usuário que efetuou login.<br/>
                Para obter mais informações, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">Controle de acesso baseado em função</a>.</p>

                <p>O {{ site.data.keys.mf_analytics_server }} usa o Elasticsearch V1.7.5.</p>

                <p>O suporte do {{ site.data.keys.mf_analytics_short }} para aplicativos da web foi incluído com a nova API do lado do cliente de análise de dados da web.</p>

                <p>Alguns tipos de eventos foram mudados entre versões anteriores do {{ site.data.keys.mf_analytics_server }} e a V8.0. Devido a esta mudança, quaisquer propriedades JNDI que foram configuradas anteriormente em seu arquivo de configuração do servidor devem ser convertidas para o novo tipo de evento.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">O que há de novo em notificações push do {{ site.data.keys.product_adj }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>O serviço de notificação push agora é fornecido como um serviço independente hospedado em um aplicativo da web separado.</p>

                <p>Versões anteriores do {{ site.data.keys.product }} integravam o serviço de notificação push como parte do tempo de execução do aplicativo.</p>

                <h3>Modelo de programação</h3>
                <p>O modelo de programação abrange do servidor ao cliente, e é necessário configurar seu aplicativo para o serviço de notificação push para trabalhar em seus aplicativos clientes. Dois tipos de clientes interagiriam com o serviço de notificação push:</p>

                <ul>
                    <li>Aplicativos clientes móveis</li>
                    <li>Aplicativos de servidor de backend</li>
                </ul>

                <h3>Segurança para serviço de notificação push</h3>
                <p>O servidor de autorizações {{ site.data.keys.product }} força o protocolo OAuth a proteger o serviço de notificação push.</p>

                <h3>Modelo de serviço de notificação push</h3>
                <p>O modelo baseado em origem de eventos não é suportado. O recurso de notificação push é ativado no {{ site.data.keys.product }} pelo modelo de serviço de push.</p>

                <h3>API REST de Push</h3>
                <p>É possível ativar aplicativos do servidor de backend implementados fora do {{ site.data.keys.mf_server }} para acessar funções da notificação push usando API REST para push no tempo de execução do {{ site.data.keys.product }}.</p>

                <h3>Fazendo upgrade do modelo de notificação baseado em origem de eventos existente</h3>
                <p>O modelo baseado em origem de eventos não é suportado. O recurso de notificação push é totalmente ativado pelo modelo de serviço de push. Todos os aplicativos baseados em origem de eventos existentes precisam ser migrados para o novo modelo de serviço de push.</p>

                <h3>Enviando notificações push</h3>
                <p>É possível escolher enviar uma notificação push baseada em origem de eventos, baseada em tag ou ativada por transmissão a partir do servidor.</p>

                <p>Notificações push podem ser enviadas usando os métodos a seguir:</p>
                <ul>
                    <li>Usando o {{ site.data.keys.mf_console }}, dois tipos de notificações podem ser enviadas: tag e transmissão. Consulte Enviando notificação push com o {{ site.data.keys.mf_console }}.</li>
                    <li>Usando a API de REST Mensagem push (POST), todas as formas de notificações podem ser enviadas: tag, transmissão e autenticada.</li>
                    <li>Usando API de REST para o serviço de administração do {{ site.data.keys.mf_server }}, todas as formas de notificações podem ser enviadas: tag, transmissão e autenticada.</li>
                </ul>

                <h3>Enviando notificações SMS</h3>
                <p>É possível configurar o serviço de push para enviar uma notificação por Serviço de Mensagens Curtas (SMS) para dispositivos do usuário.</p>

                <h3>Instalação do serviço de notificação push</h3>
                <p>O serviço de notificação push é empacotado como um componente do {{ site.data.keys.mf_server }} (serviço de push do {{ site.data.keys.mf_server }}).</p>

                <h3>O modelo de serviço de push é suportado em aplicativos Windows Universal Platform</h3>
                <p>Agora é possível migrar aplicativos nativos Windows Universal Platform (UWP) para usar o modelo de serviço de push para enviar notificações push.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">O que há de novo no {{ site.data.keys.mf_app_center }} </a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>Agora, o {{ site.data.keys.mf_app_center }} é suportado no IBM Cloud (baseado em contêineres) através de scripts BYOL. </p>
            </div>
        </div>
    </div>
</div>
