---
layout: tutorial
title: Configurando o MobileFirst Server
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Considere sua política de backup e recuperação, otimize a configuração do {{ site.data.keys.mf_server }} Server e aplique restrições de acesso e opções de segurança.

#### Ir para
{: #jump-to }

* [Terminais do servidor de produção do {{ site.data.keys.mf_server }}](#endpoints-of-the-mobilefirst-server-production-server)
* [Configurando o {{ site.data.keys.mf_server }} para ativar o TLS V1.2](#configuring-mobilefirst-server-to-enable-tls-v12)
* [Configurando a autenticação do usuário para administração do {{ site.data.keys.mf_server }}](#configuring-user-authentication-for-mobilefirst-server-administration)
* [Lista de propriedades JNDI dos aplicativos da web do {{ site.data.keys.mf_server }}](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [Configurando as Origens de Dados ](#configuring-data-sources)
* [Configurando mecanismos de criação de log e monitoramento](#configuring-logging-and-monitoring-mechanisms)
* [Configurando vários tempos de execução](#configuring-multiple-runtimes)
* [Configurando rastreamento de licença](#configuring-license-tracking)
* [Configuração de SSL e adaptadores HTTP do WebSphere Application Server](#websphere-application-server-ssl-configuration-and-http-adapters)

## Terminais do servidor de produção do {{ site.data.keys.mf_server }}
{: #endpoints-of-the-mobilefirst-server-production-server }
É possível criar listas de desbloqueio e listas de bloqueio para os terminais do IBM {{ site.data.keys.mf_server }}.

> **Nota:** As informações referentes a URLs que são expostas pelo {{ site.data.keys.product }} são fornecidas como uma diretriz. As organizações devem assegurar que as URLs sejam testadas em uma infraestrutura corporativa, com base no que estiver ativado para as listas de bloqueio e desbloqueio.

| URL da API em `<runtime context root>/api/` | Descrição (Description)                               | Sugerido para a lista de desbloqueio? |
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | Retornar documentação do swagger do adaptador para o adaptador nomeado | Não. Usado apenas internamente pelo administrador e pelos desenvolvedores |
| /adapters/*  | Entrega de adaptadores | Sim |
| /az/v1/authorization/* | Autorizar o cliente a acessar um escopo específico | Sim |
| /az/v1/introspection | Introspecção do token de acesso do cliente | Não. Esta API é somente para clientes confidenciais. |
| /az/v1/token | Gerar um token de acesso para o cliente | Sim |
| /clientLogProfile/* | Obter perfil de log do cliente | Sim |
| /directupdate/* | Obter arquivo .zip do Direct Update | Sim, se você pretende usar o Direct Update |
| /loguploader | Fazer upload dos logs do cliente para o servidor | Sim |
| /preauth/v1/heartbeat | Aceitar pulsação do cliente e anotar o horário da última atividade | Sim |
| /preauth/v1/logout | Efetuar logout em uma verificação de segurança | Sim |
| /preauth/v1/preauthorize | Mapear e executar verificações de segurança para um escopo específico | Sim |
| /reach | O servidor está acessível | Não, somente para uso interno |
| /registration/v1/clients/* | API dos clientes de serviço de registro | Não. Esta API é somente para clientes confidenciais. |
| /registration/v1/self/* | API de auto-registro do cliente de serviço de registro | Sim |

## Configurando o {{ site.data.keys.mf_server }} para ativar o TLS V1.2
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
Para o  {{ site.data.keys.mf_server }} se comunicar com dispositivos que suportam somente Transport Layer Security v1.2 (TLS) V1.2, entre os protocolos SSL, deve-se concluir as instruções a seguir.

As etapas para configurar o {{ site.data.keys.mf_server }} para ativar a Segurança da Camada de Transporte (TLS) V1.2 dependem de como o {{ site.data.keys.mf_server }} se conecta aos dispositivos.

* Se o {{ site.data.keys.mf_server }} estiver atrás de um proxy reverso que decriptografa pacotes codificados em SSL dos dispositivos antes de passar os pacotes para o servidor de aplicativos, você deverá ativar o suporte ao TLS V1.2 no proxy reverso. Se você usar o IBM HTTP Server como seu proxy reverso, consulte [Protegendo o IBM HTTP Server](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc) para obter instruções.
* Se o {{ site.data.keys.mf_server }} se comunicar diretamente com dispositivos, as etapas para ativar o TLS V1.2 dependerão de seu servidor de aplicativos ser Apache Tomcat, perfil Liberty do WebSphere Application Server ou perfil completo do WebSphere Application Server.

### Apache Tomcat
{: #apache-tomcat }
1. Confirme se o Java Runtime Environment (JRE) suporta o TLS V1.2.
    Assegure-se de ter uma das versões de JRE a seguir:
    * Oracle JRE 1.7.0_75 ou mais recente
    * Oracle JRE 1.8.0_31 ou mais recente
2. Edite o arquivo **conf/server.xml** e modifique o elemento `Connector` que declara a porta HTTPS para que o atributo **sslEnabledProtocols** tenha o seguinte valor: `sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`.

### perfil Liberty do WebSphere Application Server
{: #websphere-application-server-liberty-profile }
1. Confirme se o Java Runtime Environment (JRE) suporta o TLS V1.2.
    * Se você usar um IBM Java SDK, certifique-se de que seu IBM Java SDK seja corrigido para a vulnerabilidade POODLE. É possível localizar as versões mínimas do IBM Java SDK que contêm a correção para sua versão do WebSphere Application Server em [Security Bulletin: vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).

        > **Nota:** é possível usar as versões que estão listadas no boletim de segurança ou as versões mais recentes.
    * Se você usar um Oracle Java SDK, certifique-se de que tenha uma das seguintes versões:
        * Oracle JRE 1.7.0_75 ou mais recente
        * Oracle JRE 1.8.0_31 ou mais recente
2. Se você usar um IBM Java SDK, edite o arquivo **server.xml**.
    * Inclua a linha a seguir: `<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * Inclua o atributo `sslProtocol="SSL_TLSv2"` em todos os elementos `<ssl>` existentes.

### WebSphere Application Server Full Profile
{: #websphere-application-server-full-profile }
1. Confirme se o Java Runtime Environment (JRE) suporta o TLS V1.2.

    Certifique-se de que o IBM Java SDK seja corrigido para a vulnerabilidade POODLE. É possível localizar as versões mínimas do IBM Java SDK que contêm a correção para sua versão do WebSphere Application Server em [Security Bulletin: vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).
    > **Nota:** é possível usar as versões que estão listadas no boletim de segurança ou as versões mais recentes.
2. Efetue login no console administrativo do WebSphere Application Server e clique em **Segurança → Certificado SSL e gerenciamento de chave → Configurações SSL**.
3. Para cada configuração de SSL listada, modifique a configuração para ativar o TLS V1.2.
    * Selecione uma configuração SSL e, em seguida, em **Propriedades adicionais**, clique em configurações de **Qualidade de proteções (QoP)**.
    * Na lista **Protocolo**, selecione **SSL_TLSv2**.
    * Clique em **Aplicar** e, em seguida, salve as mudanças.

## Configurando a autenticação do usuário para o {{ site.data.keys.mf_server }} administration
{: #configuring-user-authentication-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} A administração do  requer autenticação do usuário. É possível configurar a autenticação do usuário e escolher um método de autenticação. Então, o procedimento de configuração depende do servidor de aplicativos da web usado.

> **Importante:** Se você usar o perfil completo do WebSphere Application Server independente, use um método de autenticação diferente do simple WebSphere authentication method (SWAM) na segurança global. É possível usar Lightweight Third Party Authentication (LTPA). Se usar SWAM, talvez você enfrente falhas de autenticação não esperadas.

Deve-se configurar autenticação após o instalador implementar os aplicativos da web de administração do {{ site.data.keys.mf_server }} no servidor de aplicativos da web.

A administração do {{ site.data.keys.mf_server }} tem as seguintes funções de segurança Java Platform, Enterprise Edition (Java EE) definidas:

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

Você deve mapear as funções para os conjuntos de usuários correspondentes. A função **mfpmonitor** pode visualizar dados, mas não pode alterar nenhum deles. As tabelas a seguir listam atribuições e funções do MobileFirst para servidores de produção.

#### Implementação
{: #deployment }

|                        | Administrador | Implementador    | Operador    | Monitorar    |
|------------------------|---------------|-------------|-------------|------------|
| Função de segurança Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Implementar um aplicativo. | Sim           | Sim         | No          | No         |
| Implementar um adaptador.     | Sim           | Sim         | No          | No         |

#### Gerenciamento do {{ site.data.keys.mf_server }}
{: #mobilefirst-server-management }

|                            | Administrador | Implementador    | Operador    | Monitorar    |
|----------------------------|---------------|-------------|-------------|------------|
| Função de segurança Java EE.     | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Configurar as definições de tempo de execução.| Sim           | Sim         | No          | No         |

#### Gerenciamento de Aplicativos
{: #application-management }

|                                     | Administrador | Implementador    | Operador    | Monitorar    |
|-------------------------------------|---------------|-------------|-------------|------------|
| Função de segurança Java EE.              | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Fazer upload do novo aplicativo do {{ site.data.keys.product_adj }}. | Sim           | Sim         | No          | No         |
| Remover aplicativo {{ site.data.keys.product_adj }}.	  | Sim           | Sim         | No          | No         |
| Fazer upload de novo adaptador.     | Sim           | Sim         | No          | No         |
| Remover adaptador.         | Sim           | Sim         | No          | No         |
| Ligar ou desligar o teste de autenticidade do aplicativo para um aplicativo. | Sim | Sim | No | No    |
| Alterar propriedades no status do aplicativo {{ site.data.keys.product_adj }}: ativa, Notificação ativa e Desativada. | Sim | Sim | Sim | No |

Basicamente, todas as funções podem emitir solicitações GET, as funções **mfpadmin**, **mfpdeployer** e **mfpmonitor** também podem emitir solicitações POST e PUT e as funções **mfpadmin** e **mfpdeployer** também podem emitir solicitações DELETE.

#### Solicitações relacionadas às notificações push
{: #requests-related-to-push-notifications }

|                        | Administrador | Implementador    | Operador    | Monitorar    |
|------------------------|---------------|-------------|-------------|------------|
| Função de segurança Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| pedidos GET {::nomarkdown}<ul><li>Obter uma lista de todos os dispositivos que usam notificação push para um aplicativo</li><li>Obter os detalhes de um dispositivo específico</li><li>Obter a lista de assinaturas</li><li>Obter as informações de assinatura associadas ao ID da assinatura</li><li>Obter os detalhes de uma configuração de GCM</li><li>Obter os detalhes de uma configuração de APNS</li><li>Obter a lista de tags definidas para o aplicativo</li><li>Obter os detalhes de uma tag específica</li></ul>{:/}| Sim           | Sim         | Sim         | Sim        |
| solicitações POST e PUT {::nomarkdown}<ul><li>Registrar um aplicativo com notificação push</li><li>Atualizar um registro de dispositivo push</li><li>Criar uma assinatura</li><li>Incluir ou atualizar uma configuração de GCM</li><li>Incluir ou atualizar uma configuração de APNS</li><li>Enviar notificações para um dispositivo</li><li>Criar ou atualizar uma tag</li></ul>{:/} | Sim           | Sim         | Sim         | No         |
| solicitações DELETE {::nomarkdown}<ul><li>Excluir o registro de um dispositivo para notificação push</li><li>Excluir uma Assinatura</li><li>Cancelar a assinatura de um dispositivo de uma tag</li><li>Excluir uma configuração de GCM</li><li>Excluir uma configuração de APNS</li><li>Excluir uma tag</li></ul>{:/} | Sim           | Sim         | No          | No         |

#### Disabling
{: #disabling }

|                        | Administrador | Implementador    | Operador    | Monitorar    |
|------------------------|---------------|-------------|-------------|------------|
| Função de segurança Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Desativar o dispositivo específico, marcando o estado como perdido ou roubado para que o acesso de qualquer aplicativo nesse dispositivo seja bloqueado.       | Sim           | Sim         | Sim          | No        |
| Desativar um aplicativo específico, marcando o estado como desativado para que o acesso a partir do aplicativo específico nesse dispositivo seja bloqueado.              | Sim           | Sim         | Sim         | No         |

Se você optar por usar um método de autenticação por meio de um repositório do usuário como o LDAP, é possível configurar o {{ site.data.keys.mf_server }} de administração para que você possa usar usuários e grupos com o repositório de usuários para definir a Lista de Controle de Acesso (ACL) do {{ site.data.keys.mf_server }} de administração. Esse procedimento depende do tipo e da versão do servidor de aplicativos da web usado.

### Configurando o perfil completo do WebSphere Application Server para administração do {{ site.data.keys.mf_server }}
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
Configure a segurança mapeando as funções Java EE de administração do {{ site.data.keys.mf_server }} para um conjunto de usuários para ambos os aplicativos da web.

Defina os conceitos básicos da configuração de usuário no console do WebSphere Application Server. O acesso ao console é geralmente por este endereço: `https://localhost:9043/ibm/console/`

1. Selecione **Segurança → Segurança Global**.
2. Selecione **Assistente de Configuração de Segurança** para configurar os usuários.
    É possível gerenciar contas do usuário individuais selecionando **Usuários e Grupos → Gerenciar usuários**.
3. Mapeie as funções **mfpadmin**, **mfpdeployer**, **mfpmonitor** e **mfpoperator** para um conjunto de usuários.
    * Selecione **Servidores → Tipos de servidores → Servidores de aplicativos WebSphere**.
    * Selecione o servidor.
    * Na guia **Configuração**, selecione **Aplicativos → Aplicativos corporativos**.
    * Selecione **MobileFirst_Administration_Service**.
    * Na guia **Configuração**, selecione a função **Detalhes → Segurança** para mapeamento de usuário/grupo.
    * Execute a customização necessária.
    * Clique em ** OK **.
    * Repita as etapas para mapear as funções para o aplicativo da web do console. Dessa vez selecione **MobileFirst_Administration_Console**.
    * Clique em **Salvar** para salvar as alterações.

### Configurando o perfil Liberty do WebSphere Application Server para administração do {{ site.data.keys.mf_server }}
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
No perfil Liberty do WebSphere Application Server, configure as funções de **mfpadmin**, **mfpdeployer**, **mfpmonitor** e **mfpoperator** no arquivo de configuração **server.xml** do servidor.

Para configurar as funções de segurança, você deve editar o arquivo **server.xml**. No elemento `<application-bnd>` de cada elemento `<application>`, crie elementos `<security-role>`. Cada elemento `<security-role>` destina-se a cada função: **mfpadmin**, mfpdeployer, mfpmonitor e mfpoperator. Mapeie as funções para o nome do grupo de usuários apropriado, neste exemplo: **mfpadmingroup**, **mfpdeployergroup**,
**mfpmonitorgroup** ou **mfpoperatorgroup**. Esses grupos são definidos por meio do elemento `<basicRegistry>`. É possível customizar esse elemento ou substituí-lo completamente por um elemento `<ldapRegistry>` ou por um elemento `<safRegistry>`.

Em seguida, para manter tempos bons de resposta com um grande número de aplicativos instalados, por exemplo com 80 aplicativos, você deve configurar um conjunto de conexões para o banco de dados de administração.

1. Edite o arquivo **server.xml**. Por exemplo:

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. Defina o tamanho de **AppCenterPool**:

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. No elemento `<dataSource>`, defina uma referência para o gerenciador de conexões:

   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### Configurando o Apache Tomcat para o {{ site.data.keys.mf_server }} administration
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
Deve-se configurar as funções de segurança Java EE para administração do {{ site.data.keys.mf_server }} no servidor de aplicativos da web Apache Tomcat.

1. Se você instalou a administração do {{ site.data.keys.mf_server }} manualmente, declare as seguintes funções no arquivo **conf/tomcat-users.xml**:

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. Incluir funções para os usuários selecionados, por exemplo:

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. É possível definir o conjunto de usuários conforme descrito na documentação do Apache Tomcat, [INSTRUÇÕES de Configuração do Domínio](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

## Lista de propriedades JNDI dos aplicativos da web {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
Configure as propriedades JNDI para os aplicativos da web {{ site.data.keys.mf_server }} implementados no servidor de aplicativos.

* [Configurando propriedades JNDI para aplicativos da web do {{ site.data.keys.mf_server }}](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Lista de propriedades JNDI para o serviço de atualização em tempo real do {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}](#list-of-jndi-properties-for-mobilefirst-runtime)
* [Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### Configurando propriedades JNDI para aplicativos da web do {{ site.data.keys.mf_server }}
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
Defina as propriedades JNDI para configurar os aplicativos da web do {{ site.data.keys.mf_server }} que são implementados no servidor de aplicativos.  
Configure as entradas de ambiente JNDI de uma das seguintes formas:

* Configure as entradas de ambiente do servidor. As etapas para configurar as entradas de ambiente do servidor dependem do servidor de aplicativos utilizado:

    * **WebSphere Application Server:**
        1. No console de administração do WebSphere Application Server, acesse **Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere → application_name → Entradas de ambiente para módulos da web**.
        2. Nos campos Valor, insira valores que são apropriados para seu ambiente do servidor.

        ![Entradas de ambiente JNDI no WebSphere](jndi_was.jpg)
    * WebSphere Application Server Liberty:

      Em **liberty\_install\_dir/usr/servers/serverName**, edite o arquivo **server.xml** e declare as propriedades JNDI conforme a seguir:

      ```xml
      <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
      ```

      A raiz de contexto (no exemplo anterior: **app\_context\_root**) se conecta entre a entrada JNDI e um aplicativo do {{ site.data.keys.product_adj }} específico. Se diversos aplicativos do {{ site.data.keys.product_adj }} existirem no mesmo servidor, será possível definir entradas JNDI específicas para cada aplicativo usando um prefixo do caminho do contexto.

      > **Nota:** Algumas propriedades são definidas globalmente no WebSphere Application Server Liberty, sem prefixar o nome da propriedade pela raiz de contexto. Para obter uma lista dessas propriedades, consulte [Entradas JNDI globais](../appserver/#global-jndi-entries).

      Para todas as outras propriedades JNDI, os nomes devem ser prefixados com a raiz de contexto do aplicativo:

       * Para o serviço de atualização em tempo real, a raiz de contexto deve ser **/[adminContextRoot]config**. Por exemplo, se a raiz de contexto do serviço de administração for **/mfpadmin**, a raiz de contexto do serviço de atualização em tempo real deverá ser **/mfpadminconfig**.
       * Para o serviço de push, deve-se definir a raiz de contexto como **/imfpush**. Caso contrário, os dispositivos do cliente não poderão se conectar a ela, já que a raiz de contexto está codificada permanentemente no SDK.
       * Para o aplicativo de Serviço de Administração do {{ site.data.keys.product_adj }} e o tempo de execução do {{ site.data.keys.mf_console }} e do {{ site.data.keys.product_adj }}, é possível definir a raiz de contexto que desejar. No entanto, por padrão, ela é **/mfpadmin** para o Serviço de Administração do {{ site.data.keys.product_adj }}, **/mfpconsole** para o {{ site.data.keys.mf_console }} e **/mfp** para o tempo de execução do {{ site.data.keys.product_adj }}.

      Por exemplo:

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat:

      Em **tomcat\_install\_dir/conf**, edite o arquivo **server.xml** e declare as propriedades JNDI conforme a seguir:

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
      </Context>
      ```

        * O prefixo do caminho de contexto não é necessário porque as entradas JNDI estão definidas dentro do elemento `<Context>` de um aplicativo.
        * `override="false"` é obrigatório.
        * O atribuo `type` é sempre `java.lang.String`, a menos que seja especificado de modo diferente para a propriedade.

      Por exemplo:

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* Se você instalar com tarefas Ant, também será possível configurar os valores das propriedades JNDI no momento da instalação.

  Em **mfp_install_dir/MobileFirstServer/configuration-samples**, edite o arquivo XML de configuração para as tarefas Ant, e declare os valores para as propriedades JNDI usando o elemento da propriedade dentro das seguintes tags:

  * `<installmobilefirstadmin>`, para {{site.data.keys.mf_server }} administração, {{site.data.keys.mf_console }}e serviços de atualização em tempo real. Para obter informações adicionais, consulte [Tarefas Ant para instalação de artefatos do {{ site.data.keys.mf_console }}, do {{ site.data.keys.mf_server }}, administração do {{ site.data.keys.mf_server }} e serviços de atualização em tempo real](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services).
  * `<installmobilefirstruntime>`, para  {{ site.data.keys.product_adj }} propriedades de configuração de tempo de execução do. Para obter informações adicionais, consulte [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments).
  * `<installmobilefirstpush>`, para configuração do serviço de push. Para obter informações adicionais, consulte [Tarefas Ant para instalação do serviço de push do {{ site.data.keys.mf_server }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service).

  Por exemplo:

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### Lista de Propriedades JNDI para serviço de administração do {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
Ao configurar o serviço de administração do {{ site.data.keys.mf_server }} e o {{ site.data.keys.mf_console }} para seu servidor de aplicativos, você configura propriedades JNDI opcionais e obrigatórias, em específico para Java Management Extensions (JMX).

As seguintes propriedades podem ser configuradas no aplicativo da web do serviço de administração mfp-admin-service.war.

#### Propriedades JNDI para serviço de administração: JMX
{: #jndi-properties-for-administration-service-jmx }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description) | Restrictions |
|--------------------------|-----------------------|-------------|--------------|
| mfp.admin.jmx.connector  | Opcional	           | O tipo de conector Java Management Extensions (JMX).<br/>Os valores possíveis são `SOAP` e `RMI`. O valor padrão é SOAP. | Somente WebSphere Application Server. |
| mfp.admin.jmx.host       | Opcional	           | nome do host para a conexão JMX REST. | perfil do Liberty apenas. |
| mfp.admin.jmx.port	   | Opcional	           | Porta para a conexão JMX REST. | perfil do Liberty apenas. |
| mfp.admin.jmx.user       | Obrigatório para o perfil Liberty e para o farm do WebSphere Application Server; caso contrário, opcional | nome do usuário para a conexão JMX REST. | Perfil Liberty do WebSphere Application Server: o nome do usuário para a conexão JMX REST.<br/><br/>Farm do WebSphere Application Server: o nome do usuário para a conexão SOAP.<br/><br/>WebSphere Application Server Network Deployment: o nome do usuário do administrador do WebSphere, se o host virtual mapeado para o aplicativo de administração do {{ site.data.keys.mf_server }} não for o host padrão.<br/><br/>Liberty Collective: o nome de usuário do administrador do controlador definido em `<administrator-role>` elemento do arquivo server.xml do controlador do Liberty. |
| mfp.admin.jmx.pwd	| Obrigatório para o perfil Liberty e para o farm do WebSphere Application Server; caso contrário, opcional | Senha de usuário para a conexão JMX REST. | Perfil Liberty do WebSphere Application Server: a senha de usuário para a conexão JMX REST.<br/><br/>Farm do WebSphere Application Server: a senha de usuário para a conexão SOAP.<br/><br/>WebSphere Application Server Network Deployment: a senha de usuário do administrador do WebSphere, se o host virtual mapeado para o aplicativo de administração do servidor do {{ site.data.keys.mf_server }} não for o host padrão.<br/><br/>Liberty Collective: a senha do administrador do controlador definida em `<administrator-role>` elemento do arquivo server.xml do controlador do Liberty. |
| mfp.admin.rmi.registryPort | Opcional | porta do registro RMI para a conexão JMX através de um firewall. | Tomcat apenas. |
| mfp.admin.rmi.serverPort | Opcional | porta do servidor RMI para a conexão JMX através de um firewall. | Tomcat apenas. |
| mfp.admin.jmx.dmgr.host | Obrigatório | nome do host do gerenciador de implementação. | Somente WebSphere Application Server Network Deployment. |
| mfp.admin.jmx.dmgr.port | Obrigatório | porta SOAP ou RMI do gerenciador de implementação. | Somente WebSphere Application Server Network Deployment. |

#### Propriedades JNDI para serviço de administração: tempo limite
{: #jndi-properties-for-administration-service-timeout }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.actions.prepareTimeout | Opcional | Tempo limite em segundos para transferir dados do serviço de administração para o tempo de execução durante uma transação de implementação. Se o tempo de execução não pode ser alcançado dentro deste tempo, um erro será levantado e a transação de implementação termina.<br/><br/>Valor padrão : 1800000 ms (30 min) |
| mfp.admin.actions.commitRejectTimeout | Opcional | tempo limite em milissegundos, quando um tempo de execução é contatado, para confirmar ou rejeitar a transação de implementação. Se o tempo de execução não pode ser alcançado dentro deste tempo, um erro será levantado e a transação de implementação termina.<br/><br/>Valor padrão : 120000 ms (2 min) |
| mfp.admin.lockTimeoutInMillis | Opcional |tempo limite em milissegundos para obter o bloqueio de transação. Como as transações de implementação são executados seqüencialmente, eles utilizam um bloqueio. Portanto, uma transação deve esperar até que uma transação anterior esteja concluído. Esse tempo limite é o tempo máximo durante o qual uma transação aguarda.<br/><br/>Valor padrão : 1200000 ms (20 min) |
| mfp.admin.maxLockTimeInMillis | Opcional | O tempo máximo durante o qual um processo pode levar o bloqueio de transação. Como as transações de implementação são executados seqüencialmente, eles utilizam um bloqueio. Se o servidor de aplicativos falha enquanto um bloqueio é executada, ela pode ocorrer em raras situações em que o bloqueio não é liberado no próximo reinício do servidor de aplicativos. Neste caso, o bloqueio é liberado automaticamente após o tempo de bloqueio máximo para que o servidor não esteja bloqueado indefinidamente. Defina um tempo que seja maior do que uma transação normal.<br/><br/>Valor padrão: 1800000 (30 min) |

#### Propriedades JNDI para serviço de administração: criação de log
{: #jndi-properties-for-administration-service-logging }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.logging.formatjson | Opcional | Configure essa propriedade como true para ativar a formatação elegante (espaço em branco extra) de objetos JSON em respostas e mensagens de log. A configuração dessa propriedade é útil quando você depure o servidor. Valor padrão: falso. |
| mfp.admin.logging.tosystemerror | Opcional | Especifica se todas as mensagens de criação de log também são direcionadas para System.Error. A configuração dessa propriedade é útil quando você depure o servidor. |

#### Propriedades JNDI para serviço de administração: proxies
{: #jndi-properties-for-administration-service-proxies }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.proxy.port | Opcional | Se o servidor de administração {{ site.data.keys.product_adj }} estiver atrás de um firewall ou proxy reverso, essa propriedade especificará o endereço do host. Configure essa propriedade para permitir que um usuário fora do firewall atinja o servidor de administração {{ site.data.keys.product_adj }}. Geralmente, essa propriedade é a porta do proxy, por exemplo, 443. É necessário apenas se o protocolo dos URIs externo e interno for diferente. |
| mfp.admin.proxy.protocol | Opcional | Se o servidor de administração {{ site.data.keys.product_adj }} estiver atrás de um firewall ou proxy reverso, essa propriedade especificará o protocolo (HTTP ou HTTPS). Configure essa propriedade para permitir que um usuário fora do firewall atinja o servidor de administração {{ site.data.keys.product_adj }}. Normalmente, essa propriedade é configurada para o protocolo do proxy. Por exemplo, wl.net. Esta propriedade será necessária apenas se o protocolo dos URIs externo e interno for diferente. |
| mfp.admin.proxy.scheme | Opcional | Essa propriedade é apenas um nome alternativo para mfp.admin.proxy.protocol. |
| mfp.admin.proxy.host | Opcional | Se o servidor de administração {{ site.data.keys.product_adj }} estiver atrás de um firewall ou proxy reverso, essa propriedade especificará o endereço do host. Configure essa propriedade para permitir que um usuário fora do firewall atinja o servidor de administração {{ site.data.keys.product_adj }}. Normalmente, essa propriedade é o endereço do proxy. |

#### Propriedades JNDI para serviço de administração: topologias
{: #jndi-properties-for-administration-service-topologies }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.audit | Opcional. | Configure esta propriedade como false para desativar o recurso de auditoria do {{ site.data.keys.mf_console }}. O valor-padrão é true. |
| mfp.admin.environmentid | Opcional. | O identificador de ambiente para o registro dos MBeans. Use esse identificador quando diferentes instâncias do {{ site.data.keys.mf_server }} estiverem instaladas no mesmo servidor de aplicativos. O identificador determina qual serviço de administração, qual console e quais tempos de execução pertencem à mesma instalação. O serviço de administração gerencia somente os tempos de execução que têm o mesmo identificador de ambiente. |
| mfp.admin.serverid | Obrigatório para server farms e Liberty Collective; caso contrário, opcional. | Server farm: o identificador do servidor. Deve ser diferente para cada servidor na fazenda.<br/><br/> Liberty Collective: o valor deve ser controller. |
| mfp.admin.hsts | Opcional. | Defina como true para ativar HTTP Estrita Transport Security de acordo com a RFC 6797. |
| mfp.topology.platform | Opcional | Tipo de servidor. Valores válidos:{::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}Se você não configurar o valor, o aplicativo tentará adivinhar o tipo de servidor. |
| mfp.topology.clustermode | Opcional | Além do tipo de servidor, especifique aqui a topologia do servidor. Valores válidos: {::nomarkdown}<ul><li>Standalone</li><li>Cluster</li><li>Farm</li></ul>{ O valor padrão é Standalone. |
| mfp.admin.farm.heartbeat | Opcional | Esta propriedade permite que você configure, em minutos, a taxa de pulsação que é usada em topologias de server farm. O valor padrão é 2 minutos.<br/><br/>Em uma server farm, todos os membros devem usar a mesma taxa de pulsação. Se você configurar ou alterar este valor de JNDI no mesmo servidor no farm, também é necessário configurar o mesmo valor em cada um dos outros servidores no farm. Para obter informações adicionais, consulte [Ciclo de vida de um nó server farm](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.missed.heartbeats.timeout | Opcional | Esta propriedade permite que você configure o número de pulsações perdidas de um membro do farm antes que o status do membro do farm seja considerado como com falha ou inativo. O valor padrão é 2.<br/><br/>Em uma server farm, todos os membros devem usar o mesmo valor de pulsação perdido. Se você configurar ou alterar este valor de JNDI no mesmo servidor no farm, também é necessário configurar o mesmo valor em cada um dos outros servidores no farm. Para obter informações adicionais, consulte [Ciclo de vida de um nó server farm](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.reinitialize | Opcional | Um valor booleano (true ou false) para registrar novamente ou reinicializar o membro do farm. |
| Mfp.server.swagger.ui.url | Opcional | Esta propriedade define a URL da interface com o usuário do Swagger a ser exibida no console de administração. |

#### Propriedades JNDI para serviço de administração: banco de dados relacional
{: #jndi-properties-for-administration-service-relational-database }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.db.jndi.name | Opcional | O nome JNDI do banco de dados. Este parâmetro é o mecanismo normal para especificar o banco de dados. O valor padrão é **java:comp/env/jdbc/mfpAdminDS**. |
| mfp.admin.db.openjpa.ConnectionDriverName | Opcional/Condicionalmente obrigatório | O nome completo da classe do driver de conexão com o banco de dados. Obrigatório somente quando a origem de dados especificada pela propriedade **mfp.admin.db.jndi.name** não estiver definida na configuração do servidor de aplicativos. |
| mfp.admin.db.openjpa.ConnectionURL | Opcional/Condicionalmente obrigatório | A URL da conexão com o banco de dados. Obrigatório somente quando a origem de dados especificada pela propriedade **mfp.admin.db.jndi.name** não estiver definida na configuração do servidor de aplicativos. |
| mfp.admin.db.openjpa.ConnectionUserName | Opcional/Condicionalmente obrigatório | O nome de usuário da conexão com o banco de dados. Obrigatório somente quando a origem de dados especificada pela propriedade **mfp.admin.db.jndi.name** não estiver definida na configuração do servidor de aplicativos. |
| mfp.admin.db.openjpa.ConnectionPassword | Opcional/Condicionalmente obrigatório | A senha para a conexão com o banco de dados. Obrigatório somente quando a origem de dados especificada pela propriedade **mfp.admin.db.jndi.name** não estiver definida na configuração do servidor de aplicativos. |
| mfp.admin.db.openjpa.Log | Opcional | Esta propriedade é transmitida para o OpenJPA e permite a criação de JPA. Para obter mais informações, consulte [o Apache OpenJPA User's Guide](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html). |
| mfp.admin.db.type | Opcional | Esta propriedade define o tipo de banco de dados. O valor padrão é inferido a partir da URL de conexão. |

#### Propriedades JNDI para serviço de administração: licenciamento
{: #jndi-properties-for-administration-service-licensing }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.license.key.server.host	| {::nomarkdown}<ul><li>Opcional para licenças perpétuas</li><li>Obrigatório para licenças de token</li></ul>{:/} | Nome do host do Rational License Key Server. |
| mfp.admin.license.key.server.port	| {::nomarkdown}<ul><li>Opcional para licenças perpétuas</li><li>Obrigatório para licenças de token</li></ul>{:/} | Número da porta do Rational License Key Server. |

#### Propriedades JNDI para serviço de administração: configurações de JNDI
{: #jndi-properties-for-administration-service-jndi-configurations }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.jndi.configuration | Opcional | O nome da configuração JNDI se as propriedades JNDI (exceto esta) tiverem que ser lidas de um arquivo de propriedade injetado no arquivo WAR. Se você não configurar essa propriedade, propriedades JNDI não serão lidas de um arquivo de propriedade. |
| mfp.jndi.file | Opcional | O nome do arquivo contendo a configuração JNDI se as propriedades JNDI (exceto esta) tiverem que ser lidas de um arquivo instalado no servidor da web. Se você não configurar essa propriedade, propriedades JNDI não serão lidas de um arquivo de propriedade. |

O serviço de administração usa um serviço de atualização em tempo real como recurso auxiliar para armazenar várias configurações. Use essas propriedades para configurar como atingir o serviço de atualização em tempo real.

#### Propriedades JNDI para serviço de administração: serviço de atualização em tempo real
{: #jndi-properties-for-administration-service-live-update-service }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.config.service.url | Opcional A URL do serviço de atualização em tempo real. A URL padrão é derivada da URL do serviço de administração, incluindo configuração na raiz de contexto do serviço de administração. |
| mfp.config.service.user | Obrigatório | O nome do usuário que é usado para acessar o serviço de atualização em tempo real. Em uma topologia de server farm, o nome do usuário deve ser o mesmo para todos os membros do farm. |
| mfp.config.service.password | Obrigatório | A senha que é usada para acessar o serviço de atualização em tempo real. Em uma topologia de server farm, a senha deve ser a mesma para todos os membros do farm. |
| mfp.config.service.schema | Opcional | O nome do esquema usado pelo serviço de atualização em tempo real. |

O serviço de administração usa um serviço de push como recurso auxiliar para armazenar várias configurações de push. Use essas propriedades para configurar como atingir o serviço de push. Como o serviço de push é protegido pelo modelo de segurança OAuth, deve-se configurar várias propriedades para permitir clientes confidenciais em OAuth.

#### Propriedades JNDI para serviço de administração: serviço de push
{: #jndi-properties-for-administration-service-push-service }

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.push.url | Opcional | A URL do serviço de push. Se a propriedade não estiver especificada, o serviço de push será considerado desativado. Se a propriedade não estiver configurada adequadamente, o serviço de administração não poderá contatar o serviço de push e a administração de serviços de push no {{ site.data.keys.mf_console }} não funcionará. |
| mfp.admin.authorization.server.url | Opcional | A URL do servidor de autorizações OAuth usada pelo serviço de push. A URL padrão é derivada da URL do serviço de administração mudando a raiz de contexto para a raiz de contexto do primeiro tempo de execução instalado. Se você instalar vários tempos de execução, é melhor configurar a propriedade. Se a propriedade não estiver configurada adequadamente, o serviço de administração não poderá contatar o serviço de push e a administração de serviços de push no {{ site.data.keys.mf_console }} não funcionará. |
| mfp.push.authorization.client.id | Opcional/Condicionalmente obrigatório | O identificador o cliente confidencial que manipula autorização OAuth para o serviço de push. Obrigatória somente se a propriedade **mfp.admin.push.url** estiver especificada. |
| mfp.push.authorization.client.secret | Opcional/Condicionalmente obrigatório | O segredo do cliente confidencial que manipula autorização OAuth para o serviço de push. Obrigatório somente se a propriedade **mfp.admin.push.url** for especificada |
| mfp.admin.authorization.client.id | Opcional/Condicionalmente obrigatório | O identificador do cliente confidencial que manipula autorização OAuth para o serviço de administração. Obrigatória somente se a propriedade **mfp.admin.push.url** estiver especificada. |
| mfp.push.authorization.client.secret | Opcional/Condicionalmente obrigatório | O segredo do cliente confidencial que manipula autorização OAuth para o serviço de administração. Obrigatória somente se a propriedade **mfp.admin.push.url** estiver especificada. |

### Propriedades da JNDI para o {{ site.data.keys.mf_console }}
{: #jndi-properties-for-mobilefirst-operations-console }
As seguintes propriedades podem ser configuradas no aplicativo da web (mfp-admin-ui.war) do {{ site.data.keys.mf_console }}.

| Propriedade                 | Opcional ou obrigatório | Descrição (Description)  |
|--------------------------|-----------------------|--------------|
| mfp.admin.endpoint | Opcional | Permite que o {{ site.data.keys.mf_console }} localize o serviço REST de administração do {{ site.data.keys.mf_server }}. Especifique o endereço externo e a raiz de contexto do aplicativo da web **mfp-admin-service.war**. Em um cenário com um firewall ou um proxy reverso seguro, esse URI deve ser o URI externo e não o URI interno na LAN local. Por exemplo, https://wl.net:443/mfpadmin. |
| mfp.admin.global.logout | Opcional | Limpa o cache de autenticação do usuário do WebSphere durante o logout do console. Esta propriedade é útil somente para o WebSphere Application Server V7. O valor padrão é falso. |
| mfp.admin.hsts | Opcional | Configure essa propriedade como true para ativar o HTTP [Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security) de acordo com o RFC 6797. Para obter informações adicionais, consulte a página W3C Strict Transport Security. O valor padrão é falso. |
| mfp.admin.ui.cors | Opcional | O valor-padrão é true. Para obter informações adicionais, consulte a [página W3C Cross-Origin Resource Sharing](http://www.w3.org/TR/cors/). |
| mfp.admin.ui.cors.strictssl | Opcional | Configure como false para permitir situações do CORS em que o {{ site.data.keys.mf_console }} é protegido com SSL (protocolo HTTPS) enquanto o serviço de administração do {{ site.data.keys.mf_server }} não é, ou o contrário. Essa propriedade só entra em vigor se a propriedade **mfp.admin.ui.cors** estiver ativada. |

### Lista de propriedades JNDI para serviço de atualização em tempo real do {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
Quando você configura o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} para seu servidor de aplicativos, é possível configurar as seguintes propriedades JNDI. A tabela lista as propriedades JNDI para o serviço de atualização em tempo real do banco de dados relacional IBM.

| Propriedade | Opcional ou obrigatório | Descrição (Description) |
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout | Opcional | Tempo limite para executar uma consulta em RDBMS, em segundos. Um valor zero significa um tempo limite infinito. Um valor negativo significa o padrão (nenhuma substituição).<br/><br/>Caso nenhum valor esteja configurado, um valor padrão será usado. Para obter informações adicionais, consulte [setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int)). |

Para saber como configurar essas propriedades, consulte [Configurando propriedades JNDI para aplicativos da web do {{ site.data.keys.mf_server }}](#setting-up-jndi-properties-for-mobilefirst-server-web-applications).

### Lista de propriedades JNDI para tempo de execução do {{ site.data.keys.product_adj }}
{: #list-of-jndi-properties-for-mobilefirst-runtime }
Quando você configura o tempo de execução do {{ site.data.keys.mf_server }} para seu servidor de aplicativos, é necessário configurar as propriedades JNDI opcionais ou obrigatórias.  
A tabela a seguir lista as propriedades do {{ site.data.keys.product_adj }} que estão sempre disponíveis como entradas JNDI:

| Propriedade | Descrição (Description) |
|----------|-------------|
| mfp.admin.jmx.dmgr.host | Obrigatório. O nome do host do gerenciador de implementação. Somente WebSphere Application Server Network Deployment. |
| mfp.admin.jmx.dmgr.port | Obrigatório. A porta RMI ou SOAP do gerenciador de implementação. Somente WebSphere Application Server Network Deployment. |
| mfp.admin.jmx.host | Somente Liberty. O nome do host da conexão REST JMX. Para Liberty Collective, use o nome do host do controlador. |
| Mfp.admin.jmx.port | Somente Liberty. O número da porta para a conexão REST JMX. Para Liberty Collective, a porta do conector REST deve ser idêntica ao valor do atributo httpsPort que é declarado no elemento `<httpEndpoint>`. Esse elemento é declarado no arquivo server.xml do controlador Liberty. |
| mfp.admin.jmx.user | Opcional. Farm do WebSphere Application Server: o nome do usuário da conexão SOAP.<br/><br/>Liberty Collective: o nome de usuário do administrador do controlador definido em `<administrator-role>` elemento do arquivo server.xml do controlador do Liberty. |
| Mfp.admin.jmx.pwd | Opcional. Farm do WebSphere Application Server: a senha de usuário da conexão SOAP.<br/><br/>Liberty Collective: a senha do administrador do controlador definida em `<administrator-role>` elemento do arquivo server.xml do controlador do Liberty. |
| mfp.admin.serverid | Obrigatório para server farms e Liberty Collective; caso contrário, opcional.<br/><br/>Server farm: o identificador do servidor. Deve ser diferente para cada servidor na fazenda.<br/><br/>Liberty Collective: o identificador do membro. O identificador deve ser diferente para cada membro no Collective. O controlador de valor não pode ser usado, pois está reservado para o controlador coletivo. |
| mfp.topology.platform | Opcional. O tipo de servidor. Os valores válidos são:<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>Se você não configurar o valor, o aplicativo tenta adivinhar o tipo de servidor. |
| mfp.topology.clustermode | Opcional. Além do tipo de servidor, especifique aqui a topologia do servidor. Valores válidos:<ul><li>Standalone<li>Cluster</li><li>Farm</li></ul>O valor padrão é Standalone. |
| mfp.admin.jmx.replica | Opcional. Somente para Liberty Collective.<br/><br/>Configure essa propriedade somente quando os componentes de administração que gerenciam esse tempo de execução forem implementados em controladores (réplicas) diferentes do Liberty.<br/><br/>Lista de endpoints das diferentes réplicas do controlador com a sintaxe a seguir: `replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` |
| mfp.analytics.console.url | Opcional. A URL que é exportada pelo IBM {{ site.data.keys.mf_analytics }} que se vincula ao console do Analytics. Configure essa propriedade se desejar acessar o console do Analytics a partir de {{ site.data.keys.mf_console }}. Por exemplo, `http://<hostname>:<port>/analytics/console` |
| mfp.analytics.password | A senha que será usada se o ponto de entrada de dados para o IBM {{ site.data.keys.mf_analytics }} for protegido com autenticação básica. |
| mfp.analytics.url | A URL que é exposta pelo IBM {{ site.data.keys.mf_analytics }} que recebe dados de análise de dados de entrada. Por exemplo, `http://<hostname>:<port>/analytics-service/rest` |
| mfp.analytics.username | O nome do usuário que será usado se o ponto de entrada de dados para o IBM {{ site.data.keys.mf_analytics }} for protegido com autenticação básica.|
| mfp.device.decommissionProcessingInterval | Define com que frequência (em segundos) a tarefa de desatribuição é executada. Padrão: 86400, que é um dia. |
| mfp.device.decommission.when | O número de dias de inatividade após o qual um dispositivo do cliente é desatribuído pela tarefa de desatribuição de dispositivo. Padrão: 90 dias. |
| mfp.device.archiveDecommissioned.when | O número de dias de inatividade após o qual um dispositivo do cliente que foi desatribuído é arquivado.<br/><br/>Essa tarefa grava os dispositivos do cliente que foram desatribuídos em um archive. Os dispositivos do cliente arquivados são gravados em um arquivo no diretório **home\devices_archive** do {{ site.data.keys.mf_server }}. O nome do arquivo contém o registro de data e hora em que o archive foi criado. Padrão: 90 dias. |
| mfp.licenseTracking.enabled | Um valor usado para ativar ou desativar o rastreamento de dispositivo no {{ site.data.keys.product }}.<br/><br/>Por motivos de desempenho, é possível desativar o rastreamento de dispositivo quando o {{ site.data.keys.product }} executa somente aplicativos Business-to-Consumer (B2C). Quando o rastreamento de dispositivo for desativado, os relatórios de licença também serão desativados e nenhuma métrica de licença será gerada.<br/><br/>Os valores possíveis são true (padrão) e false. |
| mfp.runtime.temp.folder | Define a pasta de arquivos temporários do tempo de execução. Usa o local da pasta temporária padrão do contêiner da web quando não configurada. |
| mfp.adapter.invocation.url | A URL a ser usada para chamar procedimentos do adaptador de dentro de adaptadores Java, ou adaptadores JavaScript, que são chamados usando o terminal rest. Se essa propriedade não for configurada, a URL da solicitação atualmente em execução será usada (esse é o comportamento padrão). Esse valor deve conter a URL completa, incluindo a raiz de contexto. |
| mfp.authorization.server | Modo de servidor de autorizações. Pode ser um dos modos a seguir:{::nomarkdown}<ul><li>integrado: use o servidor de autorizações do {{ site.data.keys.product_adj }}.</li><li>externo: use um servidor de autorizações externo</li></ul>{:/}. Durante a configuração desse valor, também deve-se configurar as propriedades **mfp.external.authorization.server.secret** e **mfp.external.authorization.server.introspection.url** para seu servidor externo. |
| mfp.external.authorization.server.secret | Segredo do servidor de autorizações externo. Essa propriedade é necessária ao usar um servidor de autorizações externo, significando que **mfp.authorization.server** é configurado como externo e, caso contrário, será ignorado. |
| mfp.external.authorization.server.introspection.url | URL do terminal de introspecção do servidor de autorizações externo. Essa propriedade é necessária durante o uso de um servidor de autorizações externo, o que significa que **mfp.authorization.server** está configurado para **external** e, caso contrário, será ignorado. |
| ssl.websphere.config | Usado para configurar o keystore para um adaptador HTTP. Quando configurado como falso (padrão), instrui o tempo de execução do {{ site.data.keys.product_adj }} a usar o keystore do {{ site.data.keys.product_adj }}. Quando configurado como verdadeiro, instrui o tempo de execução do {{ site.data.keys.product_adj }} a usar a configuração SSL do WebSphere. Para obter mais informações, consulte [Configuração de SSL do WebSphere Application Server e adaptadores HTTP](#websphere-application-server-ssl-configuration-and-http-adapters). |

### Lista de Propriedades JNDI para serviço de push do {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

| Propriedade | Opcional ou obrigatório | Descrição (Description) |
|----------|-----------------------|-------------|
| mfp.push.db.type | Opcional | O tipo do banco de dados. Valores possíveis: DB, CLOUDANT. Padrão: DB |
| mfp.push.db.queue.connections | Opcional | Número de encadeamentos no conjunto de encadeamentos que executa a operação do banco de dados. Padrão:  3 |
| mfp.push.db.cloudant.url | Opcional | A URL da conta do Cloudant. Quando essa propriedade for definida, o banco de dados Cloudant será direcionado para essa URL. |
| mfp.push.db.cloudant.dbName | Opcional | O nome do banco de dados na conta do Cloudant. Ele deve começar com uma letra minúscula e consistir somente em letras minúsculas, em dígitos e nos caracteres _, $ e -. Padrão: mfp\_push\_db |
| mfp.push.db.cloudant.username | Opcional | O nome do usuário da conta do Cloudant usado para armazenar o banco de dados. Quando essa propriedade não for definida, um banco de dados relacional será usado. |
| mfp.push.db.cloudant.password | Opcional | A senha da conta do Cloudant usada para armazenar o banco de dados. Essa propriedade deve ser configurada quando mfp.db.cloudant.username estiver configurado. |
| mfp.push.db.cloudant.doc.version | Opcional | A versão do documento do Cloudant. |
| mfp.push.db.cloudant.socketTimeout | Opcional	           | Um tempo limite para detectar a perda de uma conexão de rede para Cloudant em milissegundos. Um valor zero significa um tempo limite infinito. Um valor negativo significa o padrão (nenhuma substituição). Padrão. Consulte [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Opcional	           | Um tempo limite para estabelecer uma conexão de rede para Cloudant em milissegundos. Um valor zero significa um tempo limite infinito. Um valor negativo significa o padrão (nenhuma substituição). Padrão. Consulte [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Opcional | O máximo de conexões do conector do Cloudant. Padrão. Consulte [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Opcional | Um valor booleano (true ou false) que especifica se a validação de cadeia de certificados SSL e verificação de nome de host estão ativadas para conexões HTTPS para o banco de dados Cloudant. Padrão: verdadeiro |
| mfp.push.db.cloudant.ssl.configuration | Opcional	           | (Somente perfil completo do WAS) Para conexões HTTPS com o banco de dados Cloudant: o nome de uma configuração SSL na configuração do WebSphere Application Server, a ser usado quando nenhuma configuração for especificada para o host e para a porta. |
| mfp.push.db.cloudant.proxyHost | Opcional	           | Host do proxy do conector do Cloudant. Padrão: consulte [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Opcional	           | Porta do proxy do conector do Cloudant. Padrão: consulte [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Opcional	           | O plug-in de extensão de segurança. |
| mfp.push.security.endpoint | Opcional	           | A URL de terminal para o servidor de autorizações. |
| mfp.push.security.user | Opcional	           | O nome do usuário para acessar o servidor de autorizações. |
| mfp.push.security.password | Opcional	           | A senha para acessar o servidor de autorizações. |
| mfp.push.services.ext.analytics | Opcional | O plug-in de extensão de análise de dados. |
| mfp.push.analytics.endpoint | Opcional | A URL de terminal para o servidor de análise de dados. |
| mfp.push.analytics.user | Opcional | O nome do usuário para acessar o servidor de análise de dados. |
| mfp.push.analytics.password | Opcional | A senha para acessar o servidor de análise de dados. |
| mfp.push.analytics.events.notificationDispatch | Opcional	           | O evento analítico quando a notificação está prestes a ser despachada. Default: true |
| mfp.push.internalQueue.maxLength | Opcional | O comprimento da fila que retém tarefas de notificação antes do despacho. Padrão: 200000 |
| mfp.push.gcm.proxy.enabled | Opcional	           | Mostra se o Google GCM deve ser acessado por meio de um proxy. Padrão: falso |
| mfp.push.gcm.proxy.protocol | Opcional | Pode ser http ou https. |
| mfp.push.gcm.proxy.host | Opcional | Host do proxy GCM. Valor negativo significa porta padrão. |
| mfp.push.gcm.proxy.port | Opcional | Porta do proxy GCM. Padrão: -1 |
| mfp.push.gcm.proxy.user | Opcional | Nome do usuário do proxy, se o proxy requerer autenticação. Nome do usuário vazio significa sem autenticação. |
| mfp.push.gcm.proxy.password | Opcional | Senha do proxy, se o proxy requerer autenticação. |
| mfp.push.gcm.connections | Opcional | Máximo de conexões do GCM de push. Padrão : 10 |
| mfp.push.apns.proxy.enabled | Opcional | Mostra se APNs devem ser acessadas por meio de um proxy. Padrão: falso |
| mfp.push.apns.proxy.type | Opcional | Tipo de proxy APNs. |
| mfp.push.apns.proxy.host | Opcional | Host do proxy APNs. |
| mfp.push.apns.proxy.port | Opcional | Porta do proxy APNs. Padrão: -1 |
| mfp.push.apns.proxy.user | Opcional | Nome do usuário do proxy, se o proxy requerer autenticação. Nome do usuário vazio significa sem autenticação. |
| mfp.push.apns.proxy.password | Opcional | Senha do proxy, se o proxy requerer autenticação. |
| mfp.push.apns.connections | Opcional | Máximo de conexões push APNs. Padrão:  3 |
| mfp.push.apns.connectionIdleTimeout | Opcional | Tempo limite de conexão inativa APNs. Padrão : 0 |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## Configurando Origens de Dados
{: #configuring-data-sources }
Descubra alguns detalhes de configuração de origem de dados pertencentes aos bancos de dados suportados.

* [Gerenciando o tamanho do log de transações do DB2](#managing-the-db2-transaction-log-size)
* [Configurando o failover contínuo do DB2 HADR para origens de dados do {{ site.data.keys.mf_server }} e do Application Center](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [Manipulando conexões antigas](#handling-stale-connections)
* [Dados antigos após a criação ou exclusão de aplicativos do {{ site.data.keys.mf_console }}](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### Gerenciando o tamanho do log de transações do DB2
{: #managing-the-db2-transaction-log-size }
Ao implementar um aplicativo que tem pelo menos 40 MB com o IBM {{ site.data.keys.mf_console }}, você pode receber um erro de log de transações cheio.

A seguinte saída do sistema é um exemplo do código de erro de log de transações cheio.

```bash
Erro de DB2 SQL: SQLCODE=-964, SQLSTATE=57011
```

O conteúdo de cada aplicativo é armazenado no banco de dados de administração do {{ site.data.keys.product_adj }} .

Os arquivos de log ativos são definidos em número pelo **LOGPRIMARY** e **LOGSECOND** parâmetros de configuração do banco de dados, e tamanho pelo parâmetro de configuração do banco de dados **LOGFILSIZ** . Uma única transação não pode usar mais espaço de log do que **LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096 KB.

O `DB2 GET DATABASE CONFIGURATION` comando inclui informações sobre o tamanho do arquivo de log e o número de arquivos de log primários e secundários.

Dependendo do maior tamanho do aplicativo do {{ site.data.keys.product_adj }} que está implementado, pode ser necessário aumentar o espaço de log do DB2.

Usando o `DB2 update db cfg` comando, aumente o parâmetro **LOGSECOND** . Space não está alocados quando o banco de dados é ativado. Em vez disso, o espaço será alocado apenas se necessário.

### Configurando o failover contínuo do DB2 HADR para origens de dados do {{ site.data.keys.mf_server }} e do Application Center
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
Deve-se ativar o recurso de failover contínuo com o perfil Liberty do WebSphere Application Server e do WebSphere Application Server. Com este recurso, é possível gerenciar uma exceção quando um banco de dados executa failover e é roteado novamente pelo driver JDBC DB2.

> **Nota:** O failover do DB2 HADR não é suportado para Apache Tomcat.

Por padrão, com o DB2 HADR, quando o driver JDBC DB2 executa uma nova rota do cliente após detectar que um banco de dados executou failover durante a primeira tentativa de reutilizar uma conexão existente, o driver aciona **com.ibm.db2.jcc.am.ClientRerouteException**, com **ERRORCODE=-4498** e **SQLSTATE=08506**. O WebSphere Application Server mapeia essa exceção para **com.ibm.websphere.ce.cm.StaleConnectionException** antes de ela ser recebida pelo aplicativo.

Nesse caso, o aplicativo terá de capturar a exceção e executar novamente a transação. Os ambientes de tempo de execução do {{ site.data.keys.product_adj }} e do Application Center não gerenciam a exceção, mas dependem de um recurso que é chamado de failover contínuo. Para ativar esse recurso, deve-se configurar a propriedade JDBC **enableSeamlessFailover** como "1".

#### Configuração de perfil Liberty do WebSphere Application Server
{: #websphere-application-server-liberty-profile-configuration }
Deve-se editar o arquivo **server.xml** e incluir a propriedade **enableSeamlessFailover** para o elemento **properties.db2.jcc** das origens de dados do {{ site.data.keys.product_adj }} e do Application Center. Por exemplo:

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### configuração do WebSphere Application Server
{: #websphere-application-server-configuration }
No console administrativo do WebSphere Application Server para cada origem de dados do {{ site.data.keys.product_adj }} e do Application Center:

1. Acesse **Recursos → JDBC → Origens de dados → Nome do DataSource**.
2. Selecione **Novo** e inclua a seguinte propriedade customizada, ou atualize os valores, se as propriedades já existirem: `enableSeamlessFailover : 1`
3. Dê um clique em **Aplicar**.
4. Salve a sua configuração.

Para obter mais informações sobre como configurar uma conexão com um banco de dados DB2 ativado por HADR, consulte [Configurando uma conexão com um banco de dados DB2 ativado por HADR](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=en).

### Manipulando conexões antigas
{: #handling-stale-connections }
Configure seu servidor de aplicativos para evitar problemas de tempo limite de banco de dados.

Uma **StaleConnectionException** é uma exceção gerada pelo código de conexão do banco de dados do perfil do servidor de aplicativos Java quando um driver JDBC retorna um erro irrecuperável de uma solicitação de conexão ou operação. A **StaleConnectionException** é levantada quando o fornecedor de base de dados emite uma exceção para indicar que uma conexão atualmente no conjunto de conexões não é mais válida. Essa exceção pode acontecer por vários motivos. A causa mais comum da **StaleConnectionException** é devido à recuperação de conexões do conjunto de conexões com o banco de dados e à descoberta de que a conexão atingiu o tempo limite ou caiu quando ficou inutilizada por um longo período.

É possível configurar seu servidor de aplicativos para evitar essa exceção.

#### Configuração do Apache Tomcat
{: #apache-tomcat-configuration }
**MySQL**  
O banco de dados MySQL fecha suas conexões após um período de não atividade em uma conexão. Esse tempo limite é definido pela variável do sistema chamada **wait_timeout**. O padrão é de 28.000 segundos (8 horas).

Quando um aplicativo tenta conectar ao banco de dados após o fechamento da conexão por MySQL, a seguinte exceção é gerada:

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

Edite os arquivos **server.xml** e **context.xml** e, para cada elemento `<Resource>`, inclua as propriedades a seguir:

* **testOnBorrow="true"**
* **validationQuery="select 1"**

Por exemplo:

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### Configuração de perfil Liberty do WebSphere Application Server
{: #websphere-application-server-liberty-profile-configuration-1 }
Edite o arquivo **server.xml** e, para cada elemento `<dataSource>` (bancos de dados de tempo de execução e do Application Center), inclua um elemento `<connectionManager>` com a propriedade agedTimeout:

```xml
<connectionManager agedTimeout="timeout_value"/>
```

O valor de tempo limite depende principalmente do número de conexões abertas em paralelo, mas também dos números mínimo e máximo de conexões no conjunto. Por isso, deve-se ajustar os diferentes atributos **connectionManager** para identificar os valores mais adequados. Para obter informações adicionais sobre o elemento **connectionManager**, consulte [Liberty: elementos de configuração no arquivo **server.xml**](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html).

> **Nota:** O MySQL, em conjunto com o perfil Liberty do WebSphere Application Server ou o perfil completo do WebSphere Application Server, não é classificado como uma configuração suportada. Para obter informações adicionais, consulte [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Use o IBM DB2 ou outro banco de dados que seja suportado pelo WebSphere Application Server para beneficiar-se de uma configuração totalmente suportada pelo Suporte IBM.

### Dados antigos após criar ou excluir aplicativos do
{{ site.data.keys.mf_console }}
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
Em um servidor de aplicativos Tomcat 8, se você usar um banco de dados MySQL, algumas chamadas de {{ site.data.keys.mf_console }} para serviços retornam um erro 404.

Em um servidor de aplicativos do Tomcat 8, se você trabalhar com um banco de dados MySQL, ao usar o {{ site.data.keys.mf_console }} para excluir um aplicativo ou incluir um novo e tentar atualizar o console algumas vezes, dados antigos poderão ser exibidos. Por exemplo, os usuários podem ver um aplicativo já excluído na lista.

Para evitar esse problema, mude o nível de isolamento para **READ_COMMITTED**, na origem de dados ou no sistema de gerenciamento de banco de dados.

Para o significado de **READ_COMMITTED**, consulte a [documentação do MySQL](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc) em [http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html).

* Para mudar o nível de isolamento para **READ_COMMITTED** na origem de dados, modifique o arquivo de configuração do Tomcat **server.xml**: na seção **<Resource name="jdbc/mfpAdminDS" .../>**, inclua o atributo **defaultTransactionIsolation="READ_COMMITTED"**.
* Para mudar o nível de isolamento para **READ_COMMITTED** globalmente no sistema de gerenciamento de banco de dados, consulte a [página SET TRANSACTION Syntax](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html) da documentação do MySQL em [http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html).

#### Configuração de perfil completo do WebSphere Application Server
{: #websphere-application-server-full-profile-configuration }
**DB2 ou Oracle**  
Para minimizar os problemas de conexão antiga, verifique a configuração dos conjuntos de conexões em cada origem de dados no console de administração do WebSphere Application Server.

1. Efetue login no console administrativo do WebSphere Application Server.
2. Selecione **Recursos → Provedores JDBC → database_jdbc_provider → Origens de dados → your_data_source → Propriedades do conjunto de conexões**.
3. Configure o valor **Mínimo de conexões** como 0.
4. Configure o valor **Tempo de Coleta** para que ele seja menor que o valor **Tempo Limite Não Usado**.
5. Certifique-se de que a propriedade **Política de limpeza** esteja configurada como **EntirePool (padrão)**.

Para obter mais informações, consulte [Configurações do conjunto de conexões](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html).

**MySQL**  

1. Efetue login no console administrativo do WebSphere Application Server.
2. Selecione **Recursos → JDBC → Origens de dados**.
3. Para cada origem de dados MySQL:
    * Clique na origem de dados.
    * Selecione as propriedades do **Conjunto de conexões** em **Propriedades adicionais**.
    * Modifique o valor da propriedade **Tempo Limite Transcorrido**. O valor deve ser inferior ao da variável do sistema MySQL **wait_timeout** para que as conexões sejam limpas antes de o MySQL fechar essas conexões.
    * Clique em ** OK **.

> **Nota:** O MySQL, em conjunto com o perfil Liberty do WebSphere Application Server ou o perfil completo do WebSphere Application Server, não é classificado como uma configuração suportada. Para obter informações adicionais, consulte [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Use o IBM DB2 ou outro banco de dados que seja suportado pelo WebSphere Application Server para beneficiar-se de uma configuração totalmente suportada pelo Suporte IBM.

## Configurando mecanismos de criação de log e monitoramento
{: #configuring-logging-and-monitoring-mechanisms }
{{ site.data.keys.product }} relata erros, avisos e mensagens informativas em um arquivo de log. O mecanismo de criação de log subjacente varia de um servidor de aplicativos para outro.

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.product }} ({{ site.data.keys.mf_server }} O abreviado) usa o pacote java.util.logging padrão. Por padrão, toda a criação de log do {{ site.data.keys.product_adj }} vai para os arquivos de log do servidor de aplicativos. É possível controlar a criação de log do {{ site.data.keys.mf_server }} usando as ferramentas padrão que estão disponíveis em cada servidor de aplicativos. Por exemplo, se desejar ativar a criação de logs de rastreio no WebSphere Application Server Liberty, inclua um elemento de rastreio no arquivo server.xml. Para ativar a criação de logs de rastreio no WebSphere Application Server, use a tela de criação de log no console e ative o rastreio para logs do {{ site.data.keys.product_adj }}.

{{ site.data.keys.product_adj }} Todos os logs do começam com **com.ibm.mfp**.  
Os logs do Application Center começam com **com.ibm.puremeap**.

Para obter mais informações sobre os modelos de criação de log de cada servidor de aplicativos, incluindo o local dos arquivos de log, consulte a documentação para o servidor de aplicativos relevante, conforme mostrado na tabela a seguir.

| Servidor de aplicativo | Local da documentação |
| -------------------|---------------------------|
| Apache Tomcat	     | [http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
| Perfil completo do WebSphere Application Server Versão 8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
| Perfil Liberty do WebSphere Application Server Versão 8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### Mapeamentos em nível de log
{: #log-level-mappings }
{{ site.data.keys.mf_server }} usa a API **java.util.logging**. Os níveis de criação de log são mapeados para os seguintes níveis:

* WL.Logger.debug: FINE
* WL.Logger.info: INFO
* WL.Logger.warn: WARNING
* WL.Logger.error: SEVERE

### Ferramentas de monitoramento de log
{: #log-monitoring-tools }
Para Apache Tomcat, é possível usar o [IBM  Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) ou outras ferramentas de monitoramento de arquivos de log padrão de mercado para monitorar logs e destacar erros e avisos.

Para o WebSphere Application Server, use os recursos de visualização de log que estão descritos no IBM Knowledge Center. As URLs estão listadas na tabela na seção {{ site.data.keys.mf_server }}  desta página.

### Conectividade backend
{: #back-end-connectivity }
Para ativar o rastreio para monitorar a conectividade backend, consulte a documentação da plataforma do servidor de aplicativos específica na tabela da seção {{ site.data.keys.mf_server }} desta página. Use o pacote **com.ibm.mfp.server.js.adapter** e configure o nível de log para **FINEST**.

### Log de auditoria para operações de administração
{: #audit-log-for-administration-operations }
{{ site.data.keys.mf_console }} armazena um log de auditoria para login, logout e para todas as operações de administração, como implementação de aplicativos ou adaptadores ou bloqueio de aplicativos. É possível desativar o log de auditoria, configurando a propriedade JNDI **mfp.admin.audit** como false no aplicativo da web do serviço de administração do {{ site.data.keys.product_adj }} (**mfp-admin-service.war**).

Quando o log de auditoria estiver ativado, você poderá fazer seu download no {{ site.data.keys.mf_console }} clicando no link **Log de Auditoria** no rodapé da página.

### Problemas de login e autenticação
{: #login-and-authentication-issues }
Para diagnosticar problemas de login e autenticação, ative o pacote **com.ibm.mfp.server.security** para rastreio e configure o nível de log para **FINEST**.

## Configurando vários tempos de execução
{: #configuring-multiple-runtimes }
É possível configurar o {{ site.data.keys.mf_server }} com vários tempos de execução, criando uma diferenciação visual entre "tipos" de aplicativos no {{ site.data.keys.mf_console }}.

> **Nota:** Vários tempos de execução não são suportados em uma instância do servidor Mobile Foundation criada pelo serviço Mobile Foundation Bluemix. No serviço Bluemix, deve-se criar então várias instâncias de serviço.

#### Ir para
{: #jump-to-1 }
* [Configurando vários tempos de execução no perfil Liberty do WebSphere](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [Registrando aplicativos e implementando adaptadores em diferentes tempos de execução](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [Exportando e importando configurações de tempo de execução](#exporting-and-importing-runtime-configurations)

### Configurando vários tempos de execução no perfil Liberty do WebSphere
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. Abra o arquivo **server.xml** do servidor de aplicativos. Geralmente localizado na pasta **[application-server]/usr/servers/server-name/**. Por exemplo, com o {{ site.data.keys.mf_dev_kit }}, o arquivo pode ser localizado em **[installation-folder]/mfp-server/usrs/servers/mfp/server.xml**.

2. Inclua um segundo elemento do `aplicativo`:

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. Inclua um segundo conjunto de entradas JNDI:

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. Inclua um segundo elemento `dataSource`:

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **Nota:**
    >
    > * Certifique-se de que o `dataSource` esteja apontando para um esquema do banco de dados diferente.
    > * Certifique-se de que tenha criado [outra instância de banco de dados](../databases) para o novo tempo de execução.
    > * No ambiente de desenvolvimento, inclua `createDatabase="create"` no elemento-filho `properties.derby.embedded`.

5. Reinicie o servidor de aplicativos.

### Registrando aplicativos e implementando adaptadores em diferentes tempos de execução
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
Quando um {{ site.data.keys.mf_server }} é configurado com vários tempos de execução, o registro de aplicativos e a implementação de adaptadores são um pouco diferentes.

* [Registrando e implementando a partir do {{ site.data.keys.mf_console }}](#registering-and-deploying-from-the-mobilefirst-operations-console)
* [Registrando e implementando a partir da linha de comandos](#registering-and-deploying-from-the-command-line)

#### Registrando e implementando a partir do {{ site.data.keys.mf_console }}
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
Ao executar essas ações no {{ site.data.keys.mf_console }}, agora é preciso selecionar o tempo de execução para registro ou implementação.

<img class="gifplayer" alt="Diversos tempos de execução no {{ site.data.keys.mf_console }}" src="register-and-deploy-to-multiple-runtimes.png"/>

#### Registrando e implementando a partir da linha de comandos
{: #registering-and-deploying-from-the-command-line }
Ao executar essas ações usando a ferramenta de linha de comandos **mfpdev**, agora é preciso incluir o nome do tempo de execução para registro ou implementação.

Para registrar um aplicativo: `mfpdev app register <server-name> <runtime-name>`.  

```bash
mfpdev app register local second-runtime
```

Para implementar um adaptador: `mfpdev adapter deploy <server-name> <runtime-name>`.  

```bash
mfpdev adapter deploy local second-runtime
```

* **local** é o nome da definição do servidor padrão no {{ site.data.keys.mf_cli }}. Substitua *local* por um nome de definição do servidor que precisa de registro ou implementação.
* **runtime-name** é o nome do tempo de execução para registro ou implementação.

> Saiba mais com os seguintes comandos de ajuda da CLI:
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## Exportando e importando configurações de tempo de execução
{: #exporting-and-importing-runtime-configurations }
É possível exportar uma configuração de tempo de execução e importá-la para outro {{ site.data.keys.mf_server }} usando as APIs REST do **serviço de administração** do {{ site.data.keys.mf_server }}.

Por exemplo, é possível definir uma configuração de tempo de execução em um ambiente de desenvolvimento, exportar sua configuração e, em seguida, importá-la para um ambiente de teste para uma configuração rápida e, em seguida, configurá-la melhor para as necessidades específicas do ambiente de teste.

> Descubra todas as APIs REST disponíveis [na Referência da API](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html).

## Configurando rastreamento de licença
{: #configuring-license-tracking }
O rastreamento de licença é ativado por padrão. Leia os tópicos a seguir para saber como é possível configurar o rastreamento de licença. Para obter mais informações sobre rastreamento de licença, consulte [Rastreamento de licença](../../../administering-apps/license-tracking).

* [Configurando rastreamento de licença para dispositivo do cliente e dispositivo endereçável](#configuring-license-tracking-for-client-device-and-addressable-device)
* [Configurando arquivos de log do IBM License Metric Tool](#configuring-ibm-license-metric-tool-log-files)

### Configurando rastreamento de licença para dispositivo do cliente e dispositivo endereçável
{: #configuring-license-tracking-for-client-device-and-addressable-device }
O rastreamento de licença para dispositivos do cliente e dispositivos endereçáveis fica ativado por padrão. Relatórios de licença estão disponíveis no {{ site.data.keys.mf_console }}. É possível especificar as propriedades JNDI a seguir para mudar as configurações padrão para rastreamento de licença.

> **Nota:** Se você tiver um contrato que define o uso do licenciamento de token, consulte também [Instalando e configurando para licenciamento de token](../token-licensing).

É possível especificar as propriedades JNDI a seguir para mudar as configurações padrão para rastreamento de licença.

**mfp.device.decommission.when**  
O número de dias de inatividade após o qual um dispositivo é desatribuído pela tarefa de desatribuição de dispositivo. Relatórios de licença não contam dispositivos desatribuídos como dispositivos ativos. O valor padrão para a propriedade é 90 dias. Não configure um valor menor que 30 dias se seu software for licenciado pelo Dispositivo do Cliente ou pelo Dispositivo Endereçável ou os relatórios de licença podem não ser suficientes para comprovar a conformidade.

**mfp.device.archiveDecommissioned.when**  
Um valor, em dias, que define quando dispositivos desatribuídos são colocados em um archive quando a tarefa de desatribuição é executada. Os dispositivos arquivados são gravados em um arquivo no diretório **home\devices_archive** do IBM {{ site.data.keys.mf_server }}. O nome do arquivo contém o registro de data e hora em que o archive foi criado. O valor padrão é 90 dias.

**mfp.device.decommissionProcessingInterval**  
Define com que frequência (em segundos) a tarefa de desatribuição é executada. Padrão: 86400, que é um dia. A tarefa de desatribuição executa as ações a seguir:

* Desatribui dispositivos inativos com base na configuração **mfp.device.decommission.when**.
* Opcionalmente, arquiva dispositivos desatribuídos mais antigos com base na configuração **mfp.device.archiveDecommissioned.when**.
* Gera o relatório de rastreamento de licença.

**mfp.licenseTracking.enabled**  
Um valor usado para ativar ou desativar rastreamento de licença no {{ site.data.keys.product }}. Por padrão, o rastreamento de licença fica ativado. Por motivos de desempenho, é possível desativar essa sinalização quando o {{ site.data.keys.product }} não for licenciado por Dispositivo do cliente ou Dispositivo endereçável. Quando o rastreamento de dispositivo for desativado, os relatórios de licença também serão desativados e nenhuma métrica de licença será gerada. Nesse caso, somente registros do IBM License Metric Tool para contagem de Aplicativos são gerados.

Para obter informações adicionais sobre como especificar propriedades JNDI, consulte [Lista de propriedades JNDI para tempo de execução do {{ site.data.keys.product_adj }}](#list-of-jndi-properties-for-mobilefirst-runtime).

### Configurando arquivos de log do IBM License Metric Tool
{: #configuring-ibm-license-metric-tool-log-files }
O {{ site.data.keys.product }} gera arquivos do IBM Software License Metric Tag (SLMT). Versões do IBM License Metric Tool que suportam o IBM Software License Metric Tag podem gerar Relatórios de Consumo de Licença. Leia isso para entender como configurar o local e o tamanho máximo dos arquivos gerados.

Por padrão, os arquivos do IBM Software License Metric Tag estão nos seguintes diretórios:

* No Windows: **%ProgramFiles%\ibm\common\slm**
* Em sistemas operacionais como UNIX e UNIX: **/var/ibm/common/slm**

Se os diretórios não forem graváveis, os arquivos serão criados no diretório de log do servidor de aplicativos que executa o ambiente de tempo de execução do {{ site.data.keys.product_adj }}.

É possível configurar o local e o gerenciamento desses arquivos com as propriedades a seguir:

* **license.metric.logger.output.dir**: local dos arquivos do IBM Software License Metric Tag
* **license.metric.logger.file.size**: tamanho máximo de um arquivo SLMT antes de uma rotação ser executada. O tamanho padrão é 1 MB.
* **license.metric.logger.file.number**: número máximo de archives SLMT para manter em rotações. O número padrão é 10.

Para mudar os valores padrão, deve-se criar um arquivo de propriedade Java, com o formato **key=value**, e fornecer o caminho para o arquivo de propriedades por meio da propriedade JVM **license_metric_logger_configuration**.

Para obter informações adicionais sobre relatórios do IBM License Metric Tool, consulte [Integração com o IBM License Metric Tool](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool).

## Configuração SLL e adaptadores HTTP do WebSphere Application Server
{: #websphere-application-server-ssl-configuration-and-http-adapters }
Ao configurar uma propriedade, é possível permitir que adaptadores HTTP se beneficiem da configuração SSL do WebSphere.

Por padrão, os adaptadores HTTP não usam SSL do WebSphere concatenando o armazenamento confiável do Java Runtime Environment (JRE) com o keystore do {{ site.data.keys.mf_server }}, que é descrito em [Configurando o keystore do {{ site.data.keys.mf_server }}](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore). Consulte também [Configurando SSL entre adaptadores e servidores backend usando certificados autoassinados](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

Para que adaptadores HTTP usem a configuração SSL do WebSphere, configure a propriedade JNDI **ssl.websphere.config** como true. A configuração tem os seguintes efeitos por ordem de precedência:

1. Os adaptadores em execução no WebSphere usam o keystore do WebSphere e não o keystore do {{ site.data.keys.mf_server }}.
2. Se a propriedade **ssl.websphere.alias** estiver configurada, o adaptador usará a configuração de SSL associada ao alias, conforme configurado nessa propriedade.
