---
layout: tutorial
title: Instalando o MobileFirst Server em um servidor de aplicativos
breadcrumb_title: Instalando o MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
A instalação dos componentes pode ser feita usando tarefas Ant, o Server Configuration Tool ou manualmente. Descubra quais são os pré-requisitos e os detalhes sobre o processo de instalação para que seja possível instalar os componentes no servidor de aplicativos com sucesso.

Antes de continuar com a instalação dos componentes no servidor de aplicativos, assegure-se de que os bancos de dados e as tabelas para os componentes estejam preparados e prontos para serem usados. Para obter informações adicionais, consulte [Configurando bancos de dados](../databases).

A topologia do servidor para instalar os componentes também deve estar definida. Consulte [Topologias e fluxos de rede](../topologies).

#### Ir para
{: #jump-to }

* [Pré-requisitos do Servidor de Aplicativos](#application-server-prerequisites)
* [Instalando com o Server Configuration Tool](#installing-with-the-server-configuration-tool) 
* [Instalando com tarefas Ant](#installing-with-ant-tasks)
* [Instalando os componentes do {{ site.data.keys.mf_server }} manualmente](#installing-the-mobilefirst-server-components-manually)
* [Instalando um server farm](#installing-a-server-farm)

## Pré-requisitos do Servidor de Aplicativos
{: #application-server-prerequisites }
Dependendo de sua escolha de servidor de aplicativos, selecione um dos tópicos a seguir para descobrir os pré-requisitos que devem ser cumpridos antes da instalação dos componentes do {{ site.data.keys.mf_server }}.

* [Pré-requisitos do Apache Tomcat](#apache-tomcat-prerequisites)
* [Pré-requisitos do WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites)
* [Pré-requisitos do WebSphere Application Server e do WebSphere Application Server Network Deployment](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Pré-requisitos do Apache Tomcat
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} tem alguns requisitos para a configuração do Apache Tomcat que estão detalhados nos tópicos a seguir.  
Assegure-se de cumprir os seguintes critérios:

* Use uma versão suportada do Apache Tomcat. Consulte [Requisitos do Sistema](../../../product-overview/requirements).
* Apache Tomcat deve ser executado com JRE 7.0 ou posterior.
* A configuração JMX deve ser ativada para permitir a comunicação entre o serviço de administração e o componente de tempo de execução. A comunicação usa RMI conforme descrito em **Configurando a conexão JMX para Apache Tomcat** abaixo.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Clique para obter instruções sobre como configurar a conexão JMX para Apache Tomcat</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Você deve configurar uma conexão JMX segura para o servidor de aplicativos Apache Tomcat.</p>
                <p>O Server Configuration Tool e as tarefas Ant pode configurar um padrão seguro conexão JMX, que inclui a definição de uma porta remota JMX, e a definição de propriedades de autenticação. Eles modificam <b>tomcat_install_dir/bin/setenv.bat</b> e <b>tomcat_install_dir/bin/setenv.sh</b> para incluir essas opções em <b>CATALINA_OPTS</b>:</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>Nota:</b> 8686 é um valor padrão. O valor para essa porta poderá ser alterado se a porta não estiver disponível no computador.</p>
                
                <ul>
                    <li>O arquivo <b>setenv.bat</b> será usado se você iniciar o Apache Tomcat com <b>tomcat_install_dir/bin/startup.bat</b> ou <b>tomcat_install_dir/bin/catalina.bat.</b></li>
                    <li>O arquivo <b>setenv.sh</b> será usado se você iniciar o Apache Tomcat com <b>tomcatInstallDir/bin/startup.sh</b> ou <b>tomcat_install_dir/bin/catalina.sh.</b></li>
                </ul>
                
                <p>Esse arquivo talvez não seja usado se você iniciar o Apache Tomcat com outro comando. Se você tiver instalado o Apache Tomcat Windows Service Installer, o ativador de serviço não usará o <b>setenv.bat</b>.</p>
                
                <blockquote><b>Importante:</b> Esta configuração não é segura por padrão. Para proteger a configuração, você deve concluir manualmente as etapas 2 e 3 do procedimento a seguir.</blockquote>
                
                <p>Configurando Manualmente o Apache Tomcat:</p>
                
                <ol>
                    <li>Para uma configuração simples, inclua as seguintes opções para <b>CATALINA_OPTS</b>:
                    
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>Para ativar a autenticação, consulte a documentação do usuário do Apache Tomcat <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">Suporte SSL BIO – e NIO</a> e <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">Instruções de Configuração SSL</a>.</li>
                    <li>Para uma configuração JMX com SSL ativado, inclua as seguintes opções:
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<key store location>
-Djavax.net.ssl.trustStorePassword=<key store password>
-Djavax.net.ssl.trustStoreType=<key store type>
-Djavax.net.ssl.keyStore=<key store location>
-Djavax.net.ssl.keyStorePassword=<key store password>
-Djavax.net.ssl.keyStoreType=<key store type>
{% endhighlight %}

                    <b>Nota:</b> A porta 8686 pode ser mudada.</li>
                    <li>
                        <p>Se a instância Tomcat está atrás de um firewall, o JMX Remote de Ciclo de Listener deve ser configurado. Consulte a documentação do Apache Tomcat para <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX Remote Listener de Ciclo de Vida</a>.</p><p>As propriedades do ambiente a seguir também devem ser usadas para a seção Contexto do aplicativo de serviço de administração no arquivo <b>server.xml</b>, como no exemplo a seguir:</p>
                    
{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        No exemplo anterior:
                        <ul>
                            <li>registryPort deve ter o mesmo valor que o atributo <b>rmiRegistryPortPlatform</b> do JMX Remote Lifecycle Listener.</li>
                            <li>serverPort deve ter o mesmo valor que o atributo <b>rmiServerPortPlatform</b> do JMX Remote Lifecycle Listener.</li>
                        </ul>
                    </li>
                    <li>Se você instalou o Apache Tomcat com o Apache Tomcat Windows Service Installer em vez de incluir as opções em <b>CATALINA_OPTS</b>, execute <b>tomcat_install_dir/bin/Tomcat7w.exe</b> e inclua as opções na guia <b>Java</b> da janela Propriedades.
                    
                    <img alt="Propriedades do Apache Tomcat 7" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Pré-requisitos do WebSphere Application Server Liberty
{: #websphere-application-server-liberty-prerequisites }
O {{ site.data.keys.product_full }} tem alguns requisitos para a configuração do servidor Liberty que são detalhados nos tópicos seguintes.  

Assegure-se de cumprir os seguintes critérios:

* Use uma versão suportada do Liberty. Consulte [Requisitos do Sistema](../../../product-overview/requirements).
* O Liberty deve ser executado com JRE 7.0 ou posterior. JRE 6.0 não é suportado.
* Algumas versões do Liberty suportam os recursos de Java EE 6 e Java EE 7. Por exemplo, o recurso Liberty jdbc-4.0 faz parte de Java EE 6, enquanto o recurso Liberty jdbc-4.1 faz parte de Java EE 7. O {{ site.data.keys.mf_server }} V8.0.0 pode ser instalado com recursos de Java EE 6 ou Java EE 7. Entretanto, se desejar executar uma versão mais antiga do {{ site.data.keys.mf_server }} no mesmo servidor Liberty, você deverá usar os recursos do Java EE 6. {{ site.data.keys.mf_server }} V7.1.0 e anterior não suporta recursos do Java EE 7.
* O JMX deve ser configurado conforme documentado em **Configurando a conexão JMX para o perfil Liberty do WebSphere Application Server** abaixo.
* Para uma instalação em um ambiente de produção, talvez você queira iniciar o servidor Liberty como um serviço em sistemas Windows, Linux ou UNIX para que: os componentes do {{ site.data.keys.mf_server }} são iniciados automaticamente quando o computador é iniciado.
O processo que executa o servidor Liberty não seja interrompido quando o usuário, que iniciou o processo, efetuar logout.
* {{ site.data.keys.mf_server }} V8.0.0 não possa ser implementado em um servidor Liberty contendo os componentes do {{ site.data.keys.mf_server }} implementados de versões anteriores.
* Para uma instalação no ambiente do Liberty Collective, o controlador do Liberty Collective e os membros de cluster do Liberty Collective devem ser configurados conforme documentado em
[Configurando um Liberty Collective](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc).

<div class="panel-group accordion" id="websphere-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>Clique para obter instruções sobre como configurar a conexão JMX para o perfil Liberty do WebSphere Application Server</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>O {{ site.data.keys.mf_server }} requer que a conexão JMX segura seja configurada.</p>
                
                <ul>
                    <li>O Server Configuration Tool e as tarefas Ant pode configurar um padrão seguro conexão JMX, que inclui a geração de um certificado SSL auto-assinado por um período de validade de 365 dias. Essa configuração não deve ser usada para produção.</li>
                    <li>Para configurar a conexão JMX segura para uso de produção, siga as instruções conforme descrito em <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Configurando a conexão JMX segura para o perfil Liberty</a>.</li>
                    <li>O rest-connector está disponível para WebSphere Application Server, Liberty Core e outras edições do Liberty, mas é possível empacotar um servidor Liberty com um subconjunto dos recursos disponíveis. Para verificar se o recurso rest-connector está disponível na instalação do Liberty, insira o seguinte comando:
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>Nota:</b> Verifique se a saída desse comando contém restConnector-1.0.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Pré-requisitos do WebSphere Application Server e do WebSphere Application Server Network Deployment
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} O tem alguns requisitos para a configuração do WebSphere Application Server e do WebSphere Application Server Network Deployment que são detalhados nos tópicos seguintes.  
Assegure-se de cumprir os seguintes critérios:

* Use uma versão suportada do WebSphere Application Server. Consulte [Requisitos do Sistema](../../../product-overview/requirements).
* O servidor de aplicativos deve ser executado com JRE 7.0. Por padrão, o WebSphere Application Server usa o SDK Java 6.0. Para alternar para Java 7.0 SDK, consulte [Alterando para Java 7.0 SDK no WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* A segurança administrativa deve estar ativada. {{ site.data.keys.mf_console }}, o serviço de administração do {{ site.data.keys.mf_server }} e o serviço de configuração do {{ site.data.keys.mf_server }} são protegidos pelas funções de segurança. Para obter informações adicionais, consulte [Ativando a Segurança](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* A configuração JMX deve ser ativada para permitir a comunicação entre o serviço de administração e o componente de tempo de execução. A comunicação usa SOAP. Para WebSphere Application Server Network Deployment, o RMI pode ser usado. Para obter informações adicionais, consulte **Configurando a conexão JMX para WebSphere Application Server e WebSphere Application Server Network Deployment** abaixo.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>Clique para obter instruções sobre como configurar a conexão JMX para WebSphere Application Server e WebSphere Application Server Network Deployment</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>O {{ site.data.keys.mf_server }} requer que a conexão JMX segura seja configurada.</p>
                
                <ul>
                    <li>O {{ site.data.keys.mf_server }} requer acesso à porta SOAP ou à porta RMI para executar operações JMX. Por padrão, a porta SOAP está ativa em um WebSphere Application Server. {{ site.data.keys.mf_server }} usa a porta SOAP por padrão. Se ambas as portas SOAP e RMI estiverem desativadas, o {{ site.data.keys.mf_server }} não será executado.</li>
                    <li>O RMI é suportado somente pelo WebSphere Application Server Network Deployment. O RMI não é suportado por um perfil independente, ou um server farm do WebSphere Application Server.</li>
                    <li>Você deve ativar Administrativa e Segurança do Aplicativo.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Pré-requisitos do sistema de arquivos
{: #file-system-prerequisites }
Para instalar o {{ site.data.keys.mf_server }} para um servidor de aplicativos, as ferramentas de instalação do {{ site.data.keys.product_adj }} devem ser executadas por um usuário que possui privilégios do sistema de arquivos específicos.  
As ferramentas de instalação incluem:

* IBM Installation Manager
* O Server Configuration Tool
* As tarefas Ant para implementar o {{ site.data.keys.mf_server }}

Para o perfil Liberty do WebSphere Application Server, é preciso ter a permissão necessária para executar as seguintes ações:

* Leia os arquivos no diretório de instalação do Liberty.
* Criar arquivos no diretório de configuração do servidor Liberty, que geralmente é usr/servers/server-name, para criar cópias de backup e modificar server.xml e jvm.options.
* Criar arquivos e diretórios no diretório de recurso compartilhado do Liberty, que geralmente é usr/shared.
* Criar arquivos no diretório de aplicativos do servidor Liberty, que geralmente é usr/servers/server-name/apps.

Para o perfil completo do WebSphere Application Server e o WebSphere Application Server Network Deployment, é preciso ter a permissão necessária para executar as seguintes ações:

* Ler os arquivos no diretório de instalação do WebSphere Application Server.
* Ler o arquivo de configuração do perfil completo do WebSphere Application Server selecionado ou do perfil do Deployment Manager.
* Executar o comando wsadmin.
* Criar arquivos no diretório de configuração de perfis. As ferramentas de instalação colocam recursos, como as bibliotecas compartilhadas ou drivers JDBC, nesse diretório.

Para o Apache Tomcat, deve-se ter a permissão necessária para executar as ações a seguir:

* Leia o diretório de configuração.
* Criar arquivos de backup e modificar arquivos no diretório de configuração, como server.xml e tomcat-users.xml.
* Criar arquivos de backup e modificar arquivos no diretório bin, como setenv.bat.
* Criar arquivos no diretório lib.
* Criar arquivos no diretório webapps.

Para todos esses servidores de aplicativos, o usuário que executa o servidor de aplicativos deve ser capaz de ler os arquivos que foram criados pelo usuário que executou as ferramentas de instalação do {{ site.data.keys.product_adj }}.

## Instalando com o Server Configuration Tool
{: #installing-with-the-server-configuration-tool }
Use o Server Configuration Tool para instalar os componentes do {{ site.data.keys.mf_server }} em seu servidor de aplicativos.

O Server Configuration Tool pode configurar o banco de dados e instalar os componentes em um servidor de aplicativos. Essa ferramenta destina-se a um único usuário. Os arquivos de configuração são armazenados em disco. O diretório no qual eles são armazenados pode ser modificado com o menu **Arquivo → Preferências**. Os arquivos devem ser usados somente por uma instância do Server Configuration Tool no momento. A ferramenta não gerencia acesso simultâneo ao mesmo arquivo. Se você tiver várias instâncias da ferramenta acessando o mesmo arquivo, os dados podem ser perdidos. Para obter informações adicionais sobre como a ferramenta cria e configura os bancos de dados, consulte [Criar as tabelas de banco de dados com o Server Configuration Tool](../databases/#create-the-database-tables-with-the-server-configuration-tool). Se os bancos de dados existirem, a ferramenta poderá detectá-los testando a presença e o conteúdo de algumas tabelas de teste e não modificará essas tabelas de banco de dados.

* [Sistemas operacionais suportados ](#supported-operating-systems)
* [Topologias Suportadas](#supported-topologies)
* [Executando o Server Configuration Tool](#running-the-server-configuration-tool)
* [Aplicando um fix pack usando o Server Configuration Tool](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### sistemas operacionais suportados
{: #supported-operating-systems }
É possível usar o Server Configuration Tool se você estiver nos seguintes sistemas operacionais:

* Windows x86 ou x86-64
* macOS x86-64
* Linux x86 ou Linux x86-64

A ferramenta não está disponível em outros sistemas operacionais. É necessário usar tarefas Ant para instalar os componentes do {{ site.data.keys.mf_server }}, conforme descrito em [Instalando com tarefas Ant](#installing-with-ant-tasks).

### Topologias suportadas
{: #supported-topologies }
O Server Configuration Tool instala os componentes do {{ site.data.keys.mf_server }} com as seguintes topologias:

* Todos os componentes ({{ site.data.keys.mf_console }}, o serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e o tempo de execução do {{ site.data.keys.product_adj }}) estão no mesmo servidor de aplicativos. No entanto, no WebSphere Application Server Network Deployment, ao instalar em um cluster, é possível especificar um cluster diferente para a administração e serviços de atualização em tempo real e para o tempo de execução. No Liberty Collective, o {{ site.data.keys.mf_console }}, o serviço de administração e o serviço de atualização em tempo real são instalados em um controlador coletivo e o tempo de execução em um membro coletivo.
* Se o serviço de push do {{ site.data.keys.mf_server }} estiver instalado, ele também será instalado no mesmo servidor. No entanto, no WebSphere Application Server Network Deployment, ao instalar em um cluster, é possível especificar um cluster diferente para o serviço de push. No Liberty Collective, o serviço de push é instalado em um membro do Liberty que pode ser igual ao membro onde o tempo de execução está instalado.
* Todos os componentes usam o mesmo sistema de banco de dados e usuário. Para DB2, todos os componentes também usam o mesmo esquema.
* O Server Configuration Tool instala os componentes para um único servidor, exceto para o Liberty Collective e o WebSphere Application Server Network Deployment para implementação assimétrica. Para uma instalação em vários servidores, um farm deve ser configurado após a ferramenta ser executada. A configuração de server farm não é necessária no WebSphere Application Server Network Deployment.

Para outras topologias ou outras configurações de banco de dados, é possível instalar os componentes com tarefas Ant ou manualmente.

### Executando o Server Configuration Tool
{: #running-the-server-configuration-tool }
Antes de executar o Server Configuration Tool, certifique-se de que os seguintes requisitos sejam preenchidos:

* O banco de dados e as tabelas para os componentes estão preparados e prontos para uso. Consulte [Configurando bancos de dados](../databases).
* A topologia do servidor para instalar os componentes foi decidida. Consulte [Topologias e fluxos de rede](../topologies).
* O servidor de aplicativos está configurado. Consulte [Pré-requisitos do servidor de aplicativos](#application-server-prerequisites).
* O usuário que executa a ferramenta tem os privilégios do sistema de arquivos específicos. Consulte [Pré-requisitos do sistema de arquivos](#file-system-prerequisites).

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>Clique para obter instruções sobre como executar o Configuration Tool</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Inicie o Server Configuration Tool.
                        <ul>
                            <li>No Linux, em atalhos de aplicativo <b>Aplicativos → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>No Windows, clique em <b>Iniciar → Programas → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>No macOS, abra um console de shell. Acesse <b>mfp_server_install_dir/shortcuts</b> e digite <b>./configuration-tool.sh</b>.</li>
                            <li>O diretório <b>mfp_server_install_dir</b> é onde você instalou o {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>Selecione <b>Arquivo → Nova configuração</b> para criar uma configuração do {{ site.data.keys.mf_server }}.
                        <ul>
                            <li>No painel <b>Detalhes de Configuração</b>, insira a raiz de contexto do serviço de administração e do componente de tempo de execução. Talvez você queira inserir um ID de ambiente. Um ID de ambiente é usado em casos de uso avançados, por exemplo, quando <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">várias instalações do {{ site.data.keys.mf_server }} são feitas no mesmo servidor de aplicativos ou na mesma célula do WebSphere Application Server</a>.</li>
                            <li>No painel <b>Configurações de Console</b>, selecione se deseja ou não instalar o {{ site.data.keys.mf_console }}. Se o console não estiver instalado, será necessário usar ferramentas de linha de comandos (<b>mfpdev</b> ou <b>mfpadm</b>) ou a API REST para interagir com o serviço de administração do {{ site.data.keys.mf_server }}.</li>
                            <li>No painel <b>Seleção de Banco de Dados</b>, selecione o sistema de gerenciamento de banco de dados que pretende usar. Todos os componentes usam o mesmo tipo de banco de dados e a mesma instância de banco de dados. Para obter informações adicionais sobre as áreas de janela do banco de dados, consulte <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Criar as tabelas de banco de dados com o Server Configuration Tool</a>.</li>
                            <li>No painel <b>Seleção de Servidor de Aplicativos</b>, selecione o tipo de servidor de aplicativos em que deseja implementar o {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>No painel <b>Configurações do Servidor de Aplicativos</b>, escolha o servidor de aplicativos e execute as etapas a seguir:
                        <ul>
                            <li>Para uma instalação no WebSphere Application Server Liberty:
                                <ul>
                                    <li>Insira o diretório de instalação do Liberty e o nome do servidor no qual deseja instalar o {{ site.data.keys.mf_server }}.</li>
                                    <li>É possível criar um usuário padrão para efetuar login no console. Esse usuário é criado no registro Básico do Liberty. Para uma instalação de produção, talvez você queira limpar a opção <b>Criar um Usuário Padrão</b> e configurar o acesso de usuário após a instalação. Para obter informações adicionais, consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configurando a autenticação do usuário para administração do {{ site.data.keys.mf_server }}</a>.</li>
                                    <li>Selecione o tipo de implementação: <b>Implementação Independente</b> (padrão), <b>Implementação de Server Farm</b> ou <b>Implementação de Liberty Collective</b>.</li>
                                </ul>
                                
                                Se a opção de implementação do Liberty Collective for selecionada, execute as seguintes etapas:
                                <ul>
                                    <li>Especifique o servidor Liberty Collective:
                                        <ul>
                                            <li>Onde o serviço de administração e o serviço de atualização em tempo real do {{ site.data.keys.mf_console }} estão instalados. O servidor deve ser um controlador do Liberty Collective.</li>
                                            <li>Onde o tempo de execução está instalado. O servidor deve ser um membro do Liberty Collective.</li>
                                            <li>No qual o serviço de push está instalado. O servidor deve ser um membro do Liberty Collective.</li>
                                        </ul>
                                    </li>
                                    <li>Insira o ID do servidor do membro. Esse identificador deve ser diferente para cada membro do Collective.</li>
                                    <li>Insira o nome do cluster dos membros coletivos.</li>
                                    <li>Insira o nome do host do controlador e o número da porta HTTPS. Os valores devem ser iguais ao que está definido no elemento <code>variable</code> dentro do arquivo <b>server.xml</b> do controlador coletivo do Liberty.</li>
                                    <li>Insira o nome do usuário e a senha do administrador do controlador.</li>
                                </ul>
                            </li>
                            <li>Para uma instalação no WebSphere Application Server ou no WebSphere Application Server Network Deployment:
                                <ul>
                                    <li>Insira o diretório de instalação do WebSphere Application Server.</li>
                                    <li>Selecione o perfil do WebSphere Application Server onde você deseja instalar o {{ site.data.keys.mf_server }}. Se você instalar no WebSphere Application Server Network Deployment, selecione o perfil do gerenciador de implementação. No perfil de gerenciador de implementação, é possível selecionar um escopo (<b>Servidor</b> ou <b>Cluster</b>). Se selecionar <b>Cluster</b>, você deverá especificar o cluster:
                                        <ul>
                                            <li>Onde o tempo de execução está instalado.</li>
                                            <li>Onde o serviço de administração e o serviço de atualização em tempo real do {{ site.data.keys.mf_console }} estão instalados.</li>
                                            <li>No qual o serviço de push está instalado.</li>
                                        </ul>
                                    </li>
                                    <li>Insira um ID e uma senha de login de administrador. O usuário administrador deve ter uma função de administrador.</li>
                                    <li>Se você selecionar a opção <b>Declarar o WebSphere Administrator como um usuário administrador no {{ site.data.keys.mf_console }}</b>, o usuário que é usado para instalar o {{ site.data.keys.mf_server }} será mapeado para a função de segurança de administração do console e poderá efetuar login no console com privilégios de administrador. Esse usuário também é mapeado para a função de segurança do serviço de atualização em tempo real. O nome do usuário e a senha são configurados como propriedades JNDI (<b>mfp.config.service.user</b> e <b>mfp.config.service.password</b>) do serviço de administração.</li>
                                    <li>Se você não selecionar a opção <b>Declarar o WebSphere Administrator como um usuário administrador no {{ site.data.keys.mf_console }}</b>, antes de usar o {{ site.data.keys.mf_server }}, deve-se executar as seguintes tarefas:
                                        <ul>
                                            <li>Ativar a comunicação entre o serviço de administração e o serviço de atualização em tempo real:
                                                <ul>
                                                    <li>Mapeando um usuário para a função de segurança <b>configadmin</b> do serviço de atualização em tempo real.</li>
                                                    <li>Incluindo o ID e a senha de login desse usuário nas propriedades JNDI (<b>mfp.config.service.user</b> e <b>mfp.config.service.password</b>) do serviço de administração.</li>
                                                    <li>Mapear um ou mais usuários para as funções de segurança do serviço de administração e {{ site.data.keys.mf_console }}. Consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configurando a autenticação do usuário para administração do {{ site.data.keys.mf_server }}</a>.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>Para uma instalação no Apache Tomcat:
                                <ul>
                                    <li>Insira o diretório de instalação do Apache Tomcat.</li>
                                    <li>Insira a porta usada para a comunicação JMX com RMI. Por padrão, o valor é 8686. O Server Configuration Tool modifica o arquivo <b>tomcat_install_dir/bin/setenv.bat</b> ou <b>tomcat_install_dir/bin/setenv.sh</b> para abrir essa porta. Se desejar abrir a porta manualmente, ou se você já tiver algum código que abre a porta no <b>setenv.bat</b> ou <b>setenv.sh</b>, não use a ferramenta. Instale com as tarefas Ant. Uma opção para abrir a porta RMI manualmente é fornecida para uma instalação com tarefas Ant.</li>
                                    <li>Crie um usuário padrão para efetuar login no console. Esse usuário também é criado no arquivo de configuração <b>tomcat-users.xml</b>. Para uma instalação de produção, talvez você queira limpar a opção Criar uma opção de usuário padrão e configurar o acesso de usuário após a instalação. Para obter informações adicionais, consulte <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configurando a autenticação do usuário para administração do {{ site.data.keys.mf_server }}</a>.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>No painel <b>Configurações de Serviço de Push</b>, selecione a opção <b>Instalar o Serviço de Push</b> se desejar que o serviço de push seja instalado no servidor de aplicativos. A raiz de contexto é <b>imfpush</b>. Para ativar a comunicação entre o serviço de push e o serviço de administração, é necessário definir os parâmetros a seguir:
                        <ul>
                            <li>Insira a URL do serviço de push e a URL do tempo de execução. Essa URL pode ser calculada automaticamente se você instalar no Liberty, Apache Tomcat ou WebSphere Application Server independente. Ela usa a URL do componente (o tempo de execução ou o serviço de push) no servidor local. Se você instalar no WebSphere Application Server Network Deployment ou as comunicações passarem por um proxy da web ou balanceador de carga, será preciso inserir a URL manualmente.</li>
                            <li>Insira o segredo e os IDs do cliente confidencial para comunicação OAuth entre os serviços. Caso contrário, a ferramenta gerará valores padrão e senhas aleatórias.</li>
                        </ul>
                    </li>
                    <li>No painel <b>Configurações do Analytics</b>, selecione <b>Ativar Conexão com o Servidor Analytics</b> se o {{ site.data.keys.mf_analytics }} estiver instalado. Insira as configurações de conexão a seguir:
                        <ul>
                            <li>A URL do console do Análise de Dados.</li>
                            <li>A URL do servidor Analytics (o serviço de dados do Analytics).</li>
                            <li>O ID e a senha de login do usuário com permissão para publicar dados no servidor Analytics.</li>
                        </ul>
                        
                        A ferramenta configura o tempo de execução e o serviço de push para enviar dados para o servidor Analytics.
                    </li>
                    <li>Clique em <b>Implementar</b> para continuar com a instalação.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

Após a instalação ser concluída com sucesso, reinicie o servidor de aplicativos no caso de um Apache Tomcat ou perfil Liberty.

Se o Apache Tomcat for ativado como um serviço, o arquivo setenv.bat ou setenv.sh que contém a instrução para abrir o RMI pode não ser lido. Como resultado, o {{ site.data.keys.mf_server }} pode não estar apto para trabalhar corretamente. Para configurar as variáveis necessárias, consulte [Configurando a conexão JMX para Apache Tomcat](#apache-tomcat-prerequisites).

No WebSphere Application Server Network Deployment, os aplicativos são instalados, mas não iniciados. É necessário iniciá-los manualmente. É possível fazer isso a partir do console de administração do WebSphere Application Server.

Mantenha o arquivo de configuração no Server Configuration Tool. Você pode reutilizá-lo para instalar correções temporárias. O menu para aplicar uma correção temporária é **Configurações > Substituir os arquivos WAR implementados**.

### Aplicando um fix pack usando o Server Configuration Tool
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Se o {{ site.data.keys.mf_server }} for instalado com a ferramenta de configuração e o arquivo de configuração for mantido, será possível aplicar um fix pack ou uma correção temporária reutilizando o arquivo de configuração.

1. Inicie o Server Configuration Tool.
    * No Linux, em atalhos de aplicativo **Aplicativos → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No Windows, clique em **Iniciar → Programas → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No macOS, abra um console de shell. Acesse **mfp\_server\_install_dir/shortcuts** e digite **./configuration-tool.sh**.
    * O diretório **mfp\_server\_install\_dir** é onde foi instalado o {{ site.data.keys.mf_server }}.

2. Clique em **Configurações → Substituir os arquivos WAR implementados** e selecione uma configuração existente para aplicar o fix pack ou uma correção temporária.

## Instalando com tarefas Ant
{: #installing-with-ant-tasks }
Use tarefas Ant para instalar os componentes do {{ site.data.keys.mf_server }} em seu servidor de aplicativos.

É possível localizar os arquivos de configuração de amostra para instalar o {{ site.data.keys.mf_server }} no **diretório mfp\_install\_dir/MobileFirstServer/configuration-samples**.

Também é possível criar uma configuração com o Server Configuration Tool e exportar os arquivos Ant usando **Arquivo → Exportar configuração como arquivos Ant...**. Os arquivos Ant de amostra possuem as mesmas limitações que o Server Configuration Tool:

* Todos os componentes ({{ site.data.keys.mf_console }}, serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, artefatos do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product_adj }}) estão no mesmo servidor de aplicativos. No entanto, no WebSphere Application Server Network Deployment, ao instalar em um cluster, é possível especificar um cluster diferente para a administração e serviços de atualização em tempo real e para o tempo de execução.
* Se o serviço de push do {{ site.data.keys.mf_server }} estiver instalado, ele também será instalado no mesmo servidor. No entanto, no WebSphere Application Server Network Deployment, ao instalar em um cluster, é possível especificar um cluster diferente para o serviço de push.
* Todos os componentes usam o mesmo sistema de banco de dados e usuário. Para DB2, todos os componentes também usam o mesmo esquema.
* O Server Configuration Tool instala os componentes para um único servidor. Para uma instalação em vários servidores, um farm deve ser configurado após a ferramenta ser executada. A configuração de server farm não é suportada no WebSphere Application Server Network Deployment.

É possível configurar serviços do {{ site.data.keys.mf_server }} para execução no server farm com tarefas Ant. Para incluir seu servidor em um farm, você precisa especificar alguns atributos que configurem seu servidor de aplicativos de acordo. Para obter informações adicionais sobre como configurar um server farm com tarefas Ant, consulte [Instalando um server farm com tarefas Ant](#installing-a-server-farm-with-ant-tasks).

Para outras topologias que são suportadas em [Topologias e fluxos de rede](../topologies), é possível modificar os arquivos Ant de amostra.

As referências às tarefas Ant são as seguintes:

* [Tarefas Ant para instalação de artefatos do {{ site.data.keys.mf_console }}, do {{ site.data.keys.mf_server }}, administração do {{ site.data.keys.mf_server }} e serviços de atualização em tempo real](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tarefas Ant para instalação de serviço de push do {{ site.data.keys.mf_server }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

Para obter uma visão geral da instalação com tarefas e arquivo de configuração de amostra, consulte [Instalando o {{ site.data.keys.mf_server }} no modo de linha de comando](../tutorials/command-line).

É possível executar um arquivo Ant com a distribuição Ant que faz parte da instalação do produto. Por exemplo, se você tiver o cluster do WebSphere Application Server Network Deployment e seu banco de dados for IBM DB2, será possível usar o arquivo Ant **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml**. Depois de editar o arquivo e inserir todas as propriedades necessárias, é possível executar os seguintes comandos a partir do diretório **mfp\_install\_dir/MobileFirstServer/configuration-samples**:

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - Esse comando exibe a lista de todos os destinos possíveis do arquivo Ant para instalar, desinstalar ou atualizar alguns componentes.
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install**  - Esse comando instala o {{ site.data.keys.mf_server }} no cluster do WebSphere Application Server Network Deployment, com o DB2 como uma origem de dados, usando os parâmetros inseridos nas propriedades do arquivo Ant.

<br/>
Após a instalação, faça uma cópia do arquivo Ant para poder reutilizá-la para aplicar um fix pack.

### Aplicando um fix pack usando os arquivos Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Atualizando com o arquivo Ant de amostra
{: #updating-with-the-sample-ant-file }
Se você usar os arquivos Ant de amostra fornecidos no diretório **mfp\_install\_dir/MobileFirstServer/configuration-samples** para instalar o {{ site.data.keys.mf_server }}, será possível reutilizar uma cópia desse arquivo Ant para aplicar um fix pack. Para valores de senha, é possível inserir 12 estrelas (\*) em vez do valor real, a ser solicitado interativamente quando o arquivo Ant for executado.

1. Verifique o valor da propriedade **mfp.server.install.dir** no arquivo Ant. Ele deve apontar para o diretório que contém o produto com o fix pack aplicado. Esse valor é usado para obter os arquivos WAR do {{ site.data.keys.mf_server }} atualizados.
2. Execute o comando: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Atualizando com seu próprio arquivo Ant
{: #updating-with-own-ant-file }
Se você usar seu próprio arquivo Ant, certifique-se de que, para cada tarefa de instalação task (**installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush**), você tenha uma tarefa de atualização correspondente em seu arquivo Ant com os mesmos parâmetros. As tarefas de atualização correspondentes são **updatemobilefirstadmin**, **updatemobilefirstruntime** e **updatemobilefirstpush**.

1. Verifique o caminho da classe do elemento **taskdef** para o arquivo **mfp-ant-deployer.jar**. Ele deve apontar para o arquivo **mfp-ant-deployer.jar** em uma instalação do {{ site.data.keys.mf_server }} à qual o fix pack é aplicado. Por padrão, os arquivos WAR do {{ site.data.keys.mf_server }} atualizados são obtidos do local **mfp-ant-deployer.jar**.
2. Execute as tarefas de atualização (**updatemobilefirstadmin**, **updatemobilefirstruntime** e **updatemobilefirstpush**) de seu arquivo Ant.

### Modificações de arquivos Ant de amostra
{: #sample-ant-files-modifications }
É possível modificar os arquivos Ant de amostra fornecidos no diretório **mfp\_install\_dir/MobileFirstServer/configuration-samples** para adaptação a seus requisitos de instalação.  
As seções a seguir fornecem os detalhes sobre como é possível modificar os arquivos Ant de amostra para adaptar a instalação às suas necessidades:

1. [Especifique propriedades JNDI extra](#specify-extra-jndi-properties)
2. [Especifique usuários existentes](#specify-existing-users)
3. [Especifique o nível Liberty Java EE](#specify-liberty-java-ee-level)
4. [Especifique propriedades JDBC da origem de dados](#specify-data-source-jdbc-properties)
5. [Execute os arquivos Ant em um computador onde o {{ site.data.keys.mf_server }} não está instalado](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Especifique destinos do WebSphere Application Server Network Deployment](#specify-websphere-application-server-network-deployment-targets)
7. [Configuração manual da porta RMI no Apache Tomcat](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Especifique propriedades JNDI extra
{: #specify-extra-jndi-properties }
As tarefas Ant **installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush** declaram os valores para as propriedades JNDI necessárias para os componentes funcionarem. Essas propriedades JNDI são usadas para definir a comunicação JMX e também os links para outros componentes (como serviço de atualização em tempo real, serviço de push, o serviço de análise de dados ou serviço de autorização). Entretanto, também é possível definir valores para outras propriedades JNDI. Use o elemento `<property>` existente para essas três tarefas. Para obter uma lista de propriedades JNDI, consulte:

* [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

Por Por exemplo:

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin>
```

#### Especifique usuários existentes
{: #specify-existing-users }
Por padrão, a tarefa Ant **installmobilefirstadmin** cria usuários:

* No WebSphere Application Server Liberty para definir um administrador do Liberty para a comunicação JMX.
* Em qualquer servidor de aplicativos, para definir um usuário usado para comunicação com o serviço de atualização em tempo real.

Para usar um usuário existente em vez de criar um novo, é possível executar as operações a seguir:

1. No elemento `<jmx>`, especifique um usuário e senha, e configure o valor do atributo **createLibertyAdmin** como false. Por Por exemplo:

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. No elemento `<configuration>`, especifique um usuário e senha, e configure o valor do atributo **createConfigAdminUser** como false. Por Por exemplo:

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```
    
Além disso, o usuário que é criado pelos arquivos Ant de amostra é mapeado para as funções de segurança do serviço de administração e do console. Com essa configuração, é possível usar esse usuário para efetuar logon no
{{ site.data.keys.mf_server }} após a instalação. Para mudar esse comportamento, remova o elemento `<user>` dos arquivos Ant de amostra. Como alternativa, é possível remover o atributo **password** do elemento `<user>` e o usuário não é criado no registro local do servidor de aplicativos.

#### Especifique o nível Liberty Java EE
{: #specify-liberty-java-ee-level }
Algumas distribuições do WebSphere Application Server Liberty suportam recursos de Java EE 6 ou de Java EE 7. Por padrão, as tarefas Ant detectam automaticamente os recursos a serem instalados. Por exemplo, o recurso do Liberty **jdbc-4.0** é instalado para Java EE 6 e o recurso **jdbc-4.1** é instalado no caso do Java EE 7. Se a instalação do Liberty suportar ambos os recursos do Java EE 6 e Java EE 7, talvez você queira forçar um certo nível de recursos. Um exemplo pode ser que você pretende executar o {{ site.data.keys.mf_server }} V8.0.0 e V7.1.0 no mesmo servidor Liberty. O {{ site.data.keys.mf_server }} V7.1.0 ou anterior suporta somente recursos de Java EE 6.

Para forçar um determinado nível de recursos de Java EE 6, use o atributo jeeversion do elemento `<websphereapplicationserver>`. Por Por exemplo:

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### Especifique propriedades JDBC da origem de dados
{: #specify-data-source-jdbc-properties }
É possível especificar as propriedades para a conexão JDBC. Use o elemento `<property>` de um elemento `<database>`. O elemento está disponível nas tarefas Ant **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush**. Por Por exemplo:

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### Execute os arquivos Ant em um computador no qual o {{ site.data.keys.mf_server }} não esteja instalado
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
Para executar as tarefas Ant em um computador no qual o {{ site.data.keys.mf_server }} não está instalado, você precisa dos seguintes itens:

* Uma instalação Ant
* Uma cópia do arquivo **mfp-ant-deployer.jar** para o computador remoto. Essa biblioteca contém a definição das tarefas Ant.
* Para especificar os recursos a serem instalados. Por padrão, os arquivos WAR são levados para perto do **mfp-ant-deployer.jar**, mas é possível especificar o local desses arquivos WAR. Por Por exemplo:

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

Para obter informações adicionais, consulte as tarefas Ant para instalar cada componente do {{ site.data.keys.mf_server }} em [Referência de instalação](../installation-reference).

#### Especifique destinos do WebSphere Application Server Network Deployment
{: #specify-websphere-application-server-network-deployment-targets }
Para instalar no WebSphere Application Server Network Deployment, o perfil do WebSphere Application Server especificado deve ser o gerenciador de implementação. É possível implementar nas configurações a seguir:

* Um cluster
* Um único servidor
* Uma célula (todos os servidores de uma célula)
* Um nó (todos os servidores de um nó)

Os arquivos de amostra, como **configure-wasnd-cluster-dbms-name.xml**, **configure-wasnd-server-dbms-name.xml** e **configure-wasnd-node-dbms-name.xml** contêm a declaração a ser implementada em cada tipo de destino. Para obter informações adicionais, consulte as tarefas Ant para instalar cada componente do {{ site.data.keys.mf_server }} na [Referência de instalação](../installation-reference).

> Nota: a partir da V8.0.0, o arquivo de configuração de amostra para a célula do WebSphere Application Server Network Deployment não é fornecido.


#### Configuração manual da porta RMI no Apache Tomcat
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
Por padrão, as tarefas Ant modificam o arquivo **setenv.bat** ou o arquivo **setenv.sh** para abrir a porta RMI. Se preferir abrir a porta RMI manualmente, inclua o atributo **tomcatSetEnvConfig** com o valor como false no elemento `<jmx>` das tarefas **installmobilefirstadmin**, **updatemobilefirstadmin** e **uninstallmobilefirstadmin**.

## Instalando componentes do {{ site.data.keys.mf_server }} manualmente
{: #installing-the-mobilefirst-server-components-manually }
Também é possível instalar componentes do {{ site.data.keys.mf_server }} em seu servidor de aplicativos manualmente.  
Os tópicos a seguir fornecem informações completas para guiá-lo pelo processo de instalação dos componentes nos aplicativos suportados na produção.

* [Instalação manual no WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty)
* [Instalação manual no WebSphere Application Server Liberty Collective](#manual-installation-on-websphere-application-server-liberty-collective)
* [Instalação manual no Apache Tomcat](#manual-installation-on-apache-tomcat)
* [Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### Instalação manual no WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty }
Certifique-se de que também tenha preenchido os requisitos conforme documentado em [Pré-requisitos do WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Restrições de topologia](#topology-constraints)
* [Definições de servidores de aplicativos](#application-server-settings)
* [Recursos do Liberty requeridos por aplicativos do {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications)
* [Entradas JNDI globais](#global-jndi-entries)
* [Carregador de classes
](#class-loader)
* [Recurso de usuário decodificador de senha](#password-decoder-user-feature)
* [Detalhes da configuração](#configuration-details)

#### Restrições de topologia
{: #topology-constraints }
O serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e o tempo de execução do MobileFirst devem ser instalados no mesmo servidor de aplicativos. A raiz de contexto do serviço de atualização em tempo real deve ser definida como **the-adminContextRootconfig**. A raiz de contexto do serviço de push deve ser **imfpush**. Para obter informações adicionais sobre as restrições, consulte [Restrições nos componentes do {{ site.data.keys.mf_server }} e {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Definições de servidores de aplicativos
{: #application-server-settings }
Deve-se configurar o elemento **webContainer** para carregar os servlets imediatamente. Essa configuração é necessária para a inicialização por meio de JMX. Por exemplo: `<webContainer deferServletLoad="false"/>`.

Opcionalmente, para evitar problemas de tempo limite que interrompem a sequência de inicialização do tempo de execução e do serviço de administração em algumas versões do Liberty, mude o elemento **executor** padrão. Configure valores grandes para os atributos **coreThreads** e **maxThreads**. Por Por exemplo:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Também é possível configurar o elemento **tcpOptions** e configurar o atributo **soReuseAddr** como `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Recursos do Liberty requeridos pelos aplicativos {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications }
É possível usar os recursos a seguir para Java EE 6 ou Java EE 7.

**Serviço de administração do {{ site.data.keys.mf_server }}** 

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Serviço de push do {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **servlet-3.0** (servlet-3.1 para Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Tempo de execução do {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **servlet-3.0** (servlet-3.1 para Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entradas JNDI globais
{: #global-jndi-entries }
As entradas JNDI globais a seguir são necessárias para se configurar a comunicação JMX entre o tempo de execução e o serviço de administração:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

Essas entradas JNDI globais são configuradas com essa sintaxe e não são prefixadas por uma raiz de contexto. Por exemplo: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Nota:** Para proteger contra uma conversão automática dos valores JNDI, para que 075 não seja convertido em 61 ou 31.500 não seja convertido em 31.5, use essa sintaxe '"075"' quando definir o valor.

Para obter informações adicionais sobre as propriedades JNDI para o serviço de administração, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  

Para uma configuração de farm, consulte também os tópicos a seguir:

* [Topologia do server farm](../topologies/#server-farm-topology)
* [Topologias e fluxos de rede](../topologies)
* [Instalando um server farm](#installing-a-server-farm)

#### Carregador de Classes
{: #class-loader }
Para todos os aplicativos, o carregador de classes deve ter a última delegação de pai. Por Por exemplo:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Recurso de usuário decodificador de senha
{: #password-decoder-user-feature }
Copie o recurso de usuário decodificador de senha em seu perfil Liberty. Por Por exemplo:

* Nos sistemas UNIX e Linux:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Nos sistemas do Windows:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
    
#### Detalhes de configuração
{: #configuration-details }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>Detalhes de configuração do serviço de administração do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>O serviço de administração é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. O arquivo WAR do serviço de administração está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpadmin</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do serviço de administração. O exemplo a seguir ilustra o caso para declarar <b>mfp.admin.push.url</b> por meio do qual o serviço de administração é instalado com <b>/mfpadmin</b> como a raiz de contexto:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Se o serviço de push estiver instalado, você deverá configurar as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>As propriedades JNDI para comunicação com o serviço de configuração são as seguintes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o serviço de administração deve ser definido como <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. O exemplo a seguir ilustra o caso por meio do qual o serviço de administração é instalado com a raiz de contexto <b>/mfpadmin</b>, e se o serviço está usando um banco de dados relacional:</p>
                
{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}
                
                <h3></h3>
                <p>Declare as seguintes funções no elemento <b>application-bnd</b> do aplicativo:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-liberty-admin-service">Detalhes de configuração do serviço de atualização em tempo real do <b>{{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>O serviço de atualização em tempo real é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR do serviço de atualização em tempo real está em <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. A raiz de contexto do serviço de atualização em tempo real deve ser definida desta forma: <b>/the-adminContextRootconfig</b>. Por exemplo, se a raiz de contexto do serviço de administração for <b>/mfpadmin</b>, a raiz de contexto do serviço de atualização em tempo real deverá ser <b>/mfpadminconfig</b>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o serviço de atualização em tempo real deve ser definido como the-contextRoot/jdbc/ConfigDS. O exemplo a seguir ilustra o caso por meio do qual o serviço de atualização em tempo real é instalado com a raiz de contexto /mfpadminconfig, e se o serviço está usando um banco de dados relacional:</p>
                
{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Declare a função configadmin no elemento <b>application-bnd</b> do aplicativo. Pelo menos um usuário deve ser mapeado para essa função. O usuário e sua senha devem ser fornecidos para as seguintes propriedades JNDI do serviço de administração:</p>
                
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>Detalhes de configuração do {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>O console é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR do console está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpconsole</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do console. O exemplo a seguir ilustra o caso para declarar <b>mfp.admin.endpoint</b> por meio do qual o console é instalado com <b>/mfpconsole</b> como raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>O valor típico para a propriedade mfp.admin.endpoint é <b>*://*:*/the-adminContextRoot</b>.<br/>
                Para obter mais informações sobre as propriedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>
                
                <h3>Funções de segurança</h3>
                <p>Declare as seguintes funções no elemento <b>application-bnd</b> do aplicativo:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Qualquer usuário mapeado para uma função de segurança do console também deverá ser mapeado para a mesma função de segurança do serviço de administração.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>Detalhes de configuração de tempo de execução do MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>O tempo de execução é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR de tempo de execução está em <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. É possível definir a raiz de contexto conforme desejado. Entretanto, por padrão, ela é <b>/mfp</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do tempo de execução. O exemplo a seguir ilustra o caso para declarar <b>mfp.analytics.url</b> por meio do qual o tempo de execução é instalado com <b>/mobilefirst</b> como raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Deve-se definir a propriedade <b>mobilefirst/mfp.authorization.server</b>. Por Por exemplo:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Se o {{ site.data.keys.mf_analytics }} estiver instalado, é necessário definir as seguintes propriedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>
                
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o tempo de execução deve ser definido como <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. O exemplo a seguir ilustra o caso por meio do qual o tempo de execução é instalado com a raiz de contexto <b>/mobilefirst</b>, e se o tempo de execução está usando um banco de dados relacional:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>Detalhes de configuração do serviço de push do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>O serviço de push é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR do serviço de push está em <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Deve-se definir a raiz de contexto como <b>/imfpush</b>. Caso contrário, os dispositivos do cliente não poderão se conectar a ela, já que a raiz de contexto está codificada permanentemente no SDK.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do serviço de push. O exemplo a seguir ilustra o caso para declarar <b>mfp.push.analytics.user</b> por meio do qual o serviço de push é instalado com <b>/imfpush</b> como a raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}
                
                É necessário definir as propriedades a seguir:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - o valor deve ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para um banco de dados relacional, o valor deve ser DB.</li>
                </ul>
                
                Se {{ site.data.keys.mf_analytics }} estiver configurado, defina as seguintes propriedades JNDI:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - o valor deve ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>Detalhes de configuração de artefatos do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>O componente de artefatos é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR para esse componente está em <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Deve-se definir a raiz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalação manual no WebSphere Application Server Liberty Collective
{: #manual-installation-on-websphere-application-server-liberty-collective }
Certifique-se de que também tenha preenchido os requisitos conforme documentado em [Pré-requisitos do WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Restrições de topologia](#topology-constraints-collective)
* [Definições de servidores de aplicativos](#application-server-settings-collective)
* [Recursos do Liberty requeridos por aplicativos do {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [Entradas JNDI globais](#global-jndi-entries-collective)
* [Carregador de classes
](#class-loader-collective)
* [Recurso de usuário decodificador de senha](#password-decoder-user-feature-collective)
* [Detalhes da configuração ](#configuration-details-collective)

#### Restrições de topologia
{: #topology-constraints-collective }
O serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e o {{ site.data.keys.mf_console }} devem estar instalados em um controlador do Liberty Collective. O tempo de execução do {{ site.data.keys.product_adj }} e o serviço de push do {{ site.data.keys.mf_server }} devem estar instalados em cada membro do cluster do Liberty Collective.

A raiz de contexto do serviço de atualização em tempo real deve ser definida como **the-adminContextRootconfig**. A raiz de contexto do serviço de push deve ser **imfpush**. Para obter informações adicionais sobre as restrições, consulte [Restrições nos componentes do {{ site.data.keys.mf_server }} e {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Definições de servidores de aplicativos
{: #application-server-settings-collective }
Deve-se configurar o elemento **webContainer** para carregar os servlets imediatamente. Essa configuração é necessária para a inicialização por meio de JMX. Por exemplo: `<webContainer deferServletLoad="false"/>`.

Opcionalmente, para evitar problemas de tempo limite que interrompem a sequência de inicialização do tempo de execução e do serviço de administração em algumas versões do Liberty, mude o elemento **executor** padrão. Configure valores grandes para os atributos **coreThreads** e **maxThreads**. Por Por exemplo:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Também é possível configurar o elemento **tcpOptions** e configurar o atributo **soReuseAddr** como `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Recursos do Liberty requeridos pelos aplicativos {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

É preciso incluir os seguintes recursos para Java EE 6 ou Java EE 7.

**Serviço de administração do {{ site.data.keys.mf_server }}** 

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Serviço de push do {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **servlet-3.0** (servlet-3.1 para Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Tempo de execução do {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 para Java EE 7)
* **servlet-3.0** (servlet-3.1 para Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entradas JNDI globais
{: #global-jndi-entries-collective }
As entradas JNDI globais a seguir são necessárias para se configurar a comunicação JMX entre o tempo de execução e o serviço de administração:

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

Essas entradas JNDI globais são configuradas com essa sintaxe e não são prefixadas por uma raiz de contexto. Por exemplo: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Nota:** Para proteger contra uma conversão automática dos valores JNDI, para que 075 não seja convertido em 61 ou 31.500 não seja convertido em 31.5, use essa sintaxe '"075"' quando definir o valor.

* Para obter informações adicionais sobre as propriedades JNDI para o serviço de administração, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  
* Para obter informações adicionais sobre as propriedades JNDI para o tempo de execução, consulte [Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

#### Carregador de Classes
{: #class-loader-collective }
Para todos os aplicativos, o carregador de classes deve ter a última delegação de pai. Por Por exemplo:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Recurso de usuário decodificador de senha
{: #password-decoder-user-feature-collective }
Copie o recurso de usuário decodificador de senha em seu perfil Liberty. Por Por exemplo:

* Nos sistemas UNIX e Linux:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Nos sistemas do Windows:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### Detalhes de configuração
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>Detalhes de configuração do serviço de administração do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>O serviço de administração é empacotado como um aplicativo WAR para você implementar no controlador do Liberty Collective. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do controlador Liberty Collective. 
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalação manual no WebSphere Application Server Liberty Collective</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de administração está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpadmin</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do serviço de administração. O exemplo a seguir ilustra o caso para declarar <b>mfp.admin.push.url</b> por meio do qual o serviço de administração é instalado com <b>/mfpadmin</b> como a raiz de contexto:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Se o serviço de push estiver instalado, você deverá configurar as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>As propriedades JNDI para comunicação com o serviço de configuração são as seguintes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o serviço de administração deve ser definido como <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>. O exemplo a seguir ilustra o caso por meio do qual o serviço de administração é instalado com a raiz de contexto <b>/mfpadmin</b>, e se o serviço está usando um banco de dados relacional:</p>
                
{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}
                
                <h3>Funções de segurança</h3>
                <p>Declare as seguintes funções no elemento <b>application-bnd</b> do aplicativo:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective">Detalhes de configuração do serviço de atualização em tempo real do <b>{{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>O serviço de atualização em tempo real é empacotado como um aplicativo WAR para implementação no controlador do Liberty Collective. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do controlador do Liberty Collective.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalação manual no WebSphere Application Server Liberty Collective</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de atualização em tempo real está em <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. A raiz de contexto do serviço de atualização em tempo real deve ser definida desta forma: <b>/the-adminContextRootconfig</b>. Por exemplo, se a raiz de contexto do serviço de administração for <b>/mfpadmin</b>, a raiz de contexto do serviço de atualização em tempo real deverá ser <b>/mfpadminconfig</b>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o serviço de atualização em tempo real deve ser definido como <b>the-contextRoot/jdbc/ConfigDS</b>. O exemplo a seguir ilustra o caso por meio do qual o serviço de atualização em tempo real é instalado com a raiz de contexto <b>/mfpadminconfig</b>, e se o serviço está usando um banco de dados relacional:</p>
                
{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}

                <h3>Funções de segurança</h3>
                <p>Declare a função configadmin no elemento <b>application-bnd</b> do aplicativo. Pelo menos um usuário deve ser mapeado para essa função. O usuário e sua senha devem ser fornecidos para as seguintes propriedades JNDI do serviço de administração:</p>
                
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>Detalhes de configuração do {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>O console é empacotado como um aplicativo WAR para você implementar no controlador do Liberty Collective. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do controlador Liberty Collective.
                <br/><br/>Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do console está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpconsole</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do console. O exemplo a seguir ilustra o caso para declarar <b>mfp.admin.endpoint</b> por meio do qual o console é instalado com <b>/mfpconsole</b> como raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>O valor típico para a propriedade mfp.admin.endpoint é <b>*://*:*/the-adminContextRoot</b>.<br/>
                Para obter mais informações sobre as propriedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>
                
                <h3>Funções de segurança</h3>
                <p>Declare as seguintes funções no elemento <b>application-bnd</b> do aplicativo:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Qualquer usuário mapeado para uma função de segurança do console também deverá ser mapeado para a mesma função de segurança do serviço de administração.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>Detalhes de configuração do tempo de execução do {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>O tempo de execução é empacotado como um aplicativo WAR para você implementar nos membros do cluster do Liberty Collective. Você precisa fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> de cada membro de cluster do Liberty Collective.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalação manual no WebSphere Application Server Liberty Collective</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR de tempo de execução está em <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. É possível definir a raiz de contexto conforme desejado. Entretanto, por padrão, ela é <b>/mfp</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do tempo de execução. O exemplo a seguir ilustra o caso para declarar <b>mfp.analytics.url</b> por meio do qual o tempo de execução é instalado com <b>/mobilefirst</b> como raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Deve-se definir a propriedade <b>mobilefirst/mfp.authorization.server</b>. Por Por exemplo:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Se o {{ site.data.keys.mf_analytics }} estiver instalado, é necessário definir as seguintes propriedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>
                
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o tempo de execução deve ser definido como <b>jndiName=the-contextRoot/jdbc/mfpDS</b>. O exemplo a seguir ilustra o caso por meio do qual o tempo de execução é instalado com a raiz de contexto <b>/mobilefirst</b>, e se o tempo de execução está usando um banco de dados relacional:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...] 
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>Detalhes de configuração do serviço de push do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>O serviço de push é empacotado como um aplicativo WAR para você implementar em um membro de cluster do Liberty Collective ou servidora Liberty. Se você instalar o serviço de push em um servidor Liberty, consulte <a href="#configuration-details">Detalhes de configuração do serviço de push do {{ site.data.keys.mf_server }}</a> em <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a>.
                <br/><br/>
                Quando o serviço de push do {{ site.data.keys.mf_server }} é instalado em um Liberty Collective, ele pode ser instalado no mesmo cluster que o tempo de execução ou em outro cluster.
                <br/><br/>
                Você precisa fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> de cada membro de cluster do Liberty Collective. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty-collective">Instalação manual no WebSphere Application Server Liberty Collective</a> para obter os detalhes de configuração que são comuns a todos os serviços.    
                <br/><br/>
                O arquivo WAR do serviço de push está em <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Deve-se definir a raiz de contexto como <b>/imfpush</b>. Caso contrário, os dispositivos do cliente não poderão se conectar a ela, já que a raiz de contexto está codificada permanentemente no SDK.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Quando você define as propriedades JNDI, os nomes JNDI devem ser prefixados com a raiz de contexto do serviço de push. O exemplo a seguir ilustra o caso para declarar <b>mfp.push.analytics.user</b> por meio do qual o serviço de push é instalado com <b>/imfpush</b> como a raiz de contexto:</p>
                
{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}
                
                É necessário definir as propriedades a seguir:
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - o valor deve ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para um banco de dados relacional, o valor deve ser DB.</li>
                </ul>
                
                Se {{ site.data.keys.mf_analytics }} estiver configurado, defina as seguintes propriedades JNDI:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - o valor deve ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>Detalhes de configuração de artefatos do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>O componente de artefatos é empacotado como um aplicativo WAR para você implementar no controlador do Liberty Collective. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do controlador Liberty Collective. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-liberty">Instalação manual no WebSphere Application Server Liberty</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR para esse componente está em <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Deve-se definir a raiz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalação manual no Apache Tomcat
{: #manual-installation-on-apache-tomcat }
Certifique-se de que tenha preenchido os requisitos conforme documentado em [Pré-requisitos do Apache Tomcat](#apache-tomcat-prerequisites).

* [Restrições de topologia](#topology-constraints-tomcat)
* [Definições de servidores de aplicativos](#application-server-settings-tomcat)
* [Detalhes da configuração ](#configuration-details-tomcat)

#### Restrições de topologia
{: #topology-constraints-tomcat }
O serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e o tempo de execução do {{ site.data.keys.product_adj }} devem ser instalados no mesmo servidor de aplicativos. A raiz de contexto do serviço de atualização em tempo real deve ser definida como **the-adminContextRootconfig**. A raiz de contexto do serviço de push deve ser **imfpush**. Para obter informações adicionais sobre as restrições, consulte [Restrições nos componentes do {{ site.data.keys.mf_server }} e {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Definições de servidores de aplicativos
{: #application-server-settings-tomcat }
Deve-se ativar o **Single Sign On Valve**. Por Por exemplo:

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

Opcionalmente, talvez você queira ativar a região da memória se os usuários estiverem definidos em **tomcat-users.xml**. Por Por exemplo:

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### Detalhes de configuração
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>Detalhes de configuração do serviço de administração do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>O serviço de administração é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos. 
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de administração está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpadmin</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>As propriedades JNDI que são definidas no elemento <code>Environment</code> no contexto de aplicativos. Por Por exemplo:</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>Para ativar a comunicação JMX com o tempo de execução, defina as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Se o serviço de push estiver instalado, você deverá configurar as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>As propriedades JNDI para comunicação com o serviço de configuração são as seguintes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>A origem de dados (jdbc/mfpAdminDS) é declarada como um recurso no elemento **Context**. Por Por exemplo:</p>
                                    
{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}
                
                <h3>Funções de segurança</h3>
                <p>As funções de segurança disponíveis para o aplicativo de serviço de administração são:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>Detalhes de configuração do serviço de atualização em tempo real do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>O serviço de atualização em tempo real é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de atualização em tempo real está em <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. A raiz de contexto do serviço de atualização em tempo real deve ser definida dessa forma: <b>/the-adminContextRoot/config</b>. Por exemplo, se a raiz de contexto do serviço de administração for <b>/mfpadmin</b>, a raiz de contexto do serviço de atualização em tempo real deverá ser <b>/mfpadminconfig</b>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o serviço de atualização em tempo real deve ser definido como <code>jdbc/ConfigDS</code>. Declare-a como um recurso no elemento <code>Context</code>.</p>

                <h3>Funções de segurança</h3>
                <p>A função de segurança disponível para o aplicativo de serviço de atualização em tempo real é <b>configadmin</b>.
                <br/><br/>
                Pelo menos um usuário deve ser mapeado para essa função. O usuário e sua senha devem ser fornecidos para as seguintes propriedades JNDI do serviço de administração:</p>
                
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>Detalhes de configuração do {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>O console é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos.
                <br/><br/>Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do console está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpconsole</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É preciso definir a propriedade <b>mfp.admin.endpoint</b>. O valor típico para essa propriedade é <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                Para obter mais informações sobre as propriedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>
                
                <h3>Funções de segurança</h3>
                <p>As funções de segurança disponíveis para o aplicativo são:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>Detalhes de configuração do tempo de execução do {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>O tempo de execução é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR de tempo de execução está em <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. É possível definir a raiz de contexto conforme desejado. Entretanto, por padrão, ela é <b>/mfp</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>Deve-se definir a propriedade <b>mfp.authorization.server</b>. Por Por exemplo:</p>
                
{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>Para ativar a comunicação JMX com o serviço de administração, defina as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>
                
                <p>Se o {{ site.data.keys.mf_analytics }} estiver instalado, é necessário definir as seguintes propriedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>
                
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>O nome JNDI da origem de dados para o tempo de execução deve ser definido como <b>jdbc/mfpDS</b>. Declare-a como um recurso no elemento <b>Context</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>Detalhes de configuração do serviço de push do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>O serviço de push é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo. Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.    
                <br/><br/>
                O arquivo WAR do serviço de push está em <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Deve-se definir a raiz de contexto como <b>/imfpush</b>. Caso contrário, os dispositivos do cliente não poderão se conectar a ela, já que a raiz de contexto está codificada permanentemente no SDK.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É necessário definir as propriedades a seguir:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - o valor deve ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para um banco de dados relacional, o valor deve ser DB.</li>
                </ul>
                
                <p>Se {{ site.data.keys.mf_analytics }} estiver configurado, defina as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - o valor deve ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat">Detalhes de configuração de artefatos do <b>{{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>O componente de artefatos é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos. Antes de continuar, revise <a href="#manual-installation-on-apache-tomcat">Instalação manual no Apache Tomcat</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR para esse componente está em <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Deve-se definir a raiz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
Certifique-se de que tenha preenchido os requisitos conforme documentado em <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">Pré-requisitos do WebSphere Application Server e do WebSphere Application Server Network Deployment</a>.

* [Restrições de topologia](#topology-constraints-nd)
* [Definições de servidores de aplicativos](#application-server-settings-nd)
* [Carregador de classes
](#class-loader-nd)
* [Detalhes da configuração ](#configuration-details-nd)

#### Restrições de topologia
{: #topology-constraints-nd }
<b>Em um WebSphere Application Server independente</b>  
O serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e o tempo de execução do {{ site.data.keys.product_adj }} devem ser instalados no mesmo servidor de aplicativos. A raiz de contexto do serviço de atualização em tempo real deve ser definida como <b>the-adminContextRootConfig</b>. A raiz de contexto do serviço de push deve ser <b>imfpush</b>. Para obter informações adicionais sobre as restrições, consulte [Restrições nos componentes do {{ site.data.keys.mf_server }} e {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

<b>No WebSphere Application Server Network Deployment</b>  
O gerenciador de implementação deve estar em execução enquanto o {{ site.data.keys.mf_server }} estiver em execução. O gerenciador de implementação é usado para comunicação JMX entre o tempo de execução e o serviço de administração. O serviço de administração e o serviço de atualização em tempo real devem estar instalados no mesmo servidor de aplicativos. O tempo de execução pode estar instalado em servidores diferentes do serviço de administração, mas ele deve estar na mesma célula.

#### Definições de servidores de aplicativos
{: #application-server-settings-nd }
A segurança administrativa e a segurança do aplicativo devem estar ativadas. É possível ativar a segurança do aplicativo no console de administração do WebSphere Application Server:

1. Efetue login no console administrativo do WebSphere Application Server.
2. Clique em **Segurança → Segurança Global**. Certifique-se de que Ativar segurança administrativa esteja selecionado.
3. Além disso, assegure-se de que **Ativar Segurança do Aplicativo** esteja selecionada. A segurança do aplicativo pode ser ativada somente se a segurança administrativa estiver ativada.
4. Clique em ** OK **.
5. Salve as alterações.

Para obter informações adicionais, consulte [Ativando a segurança](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc) na documentação do WebSphere Application Server.

A política do carregador de classes do servidor deve suportar última delegação de pai. Os arquivos WAR do {{ site.data.keys.mf_server }} devem ser instalados com o modo de carregador de classes do último pai. Revise a política do carregador de classes:

1. Efetue login no console administrativo do WebSphere Application Server.
2. Clique em S**ervidores → Tipos de servidores → Servidores de aplicativos WebSphere**, e clique no servidor que é usado para o {{ site.data.keys.product }}.
3. Se a política do carregador de classes estiver configurada para **Múltiplo**, não faça nada.
4. Se a política do carregador de classes estiver configurada para **Único** e o modo de carregamento de classes estiver configurado para **Classes carregadas com carregador de classes local primeiro (pai por último)**, não faça nada.
5. Se a política do carregador de classes estiver configurada como **Único** e o modo de carregamento de classes estiver configurado como **Classes carregadas com o carregador de classes-pai primeiro (pai primeiro)**, mude a política do carregador de classes para **Múltiplo**. Além disso, configure a ordem do carregador de classes para todos os aplicativos diferentes de aplicativos do {{ site.data.keys.mf_server }} para **Classes carregadas com o carregador de classes-pai primeiro (pai primeiro)**.

#### Carregador de Classes
{: #class-loader-nd }
Para todos os aplicativos {{ site.data.keys.mf_server }}, o carregador de classes deve ter a última delegação de pai.

Para configurar a delegação de carregador de classes para o último pai após um aplicativo ser instalado, siga estas etapas:

1. Clique no link **Gerenciar aplicativos** ou clique em **Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere**.
2. Clique no aplicativo **{{ site.data.keys.mf_server }}**. Por padrão, o nome do aplicativo é o nome do arquivo WAR.
3. Na seção **Detalhar Propriedades**, clique no link **Carregamento de classe e detecção de atualização**.
4. Na área de janela **Ordem do Carregador de Classes**, clique na opção **Classes carregadas com carregador de classes local primeiro (pai por último)**.
5. Clique em ** OK **.
6. Na seção **Módulos**, clique no link **Gerenciar módulos**.
7. Clique no módulo.
8. Para o campo **Ordem do Carregador de Classes**, selecione a opção **Classes carregadas com carregador de classes local primeiro (pai por último)**.
9. Clique em **OK** duas vezes para confirmar a seleção e retornar ao painel **Configuração** do aplicativo.
10. Clique em **Salvar** para persistir com as mudanças.

#### Detalhes de configuração
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>Detalhes de configuração do serviço de administração do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>O serviço de administração é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos. 
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de administração está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpadmin</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É possível configurar propriedades JNDI com o console de administração do WebSphere Application Server. Acesse <b>Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere → application_name → Entradas de ambiente para módulos da web</b> e configure as entradas.</p>

                <p>Para ativar a comunicação JMX com o tempo de execução, defina as seguintes propriedades JNDI:</p>
                
                <b>No WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - a porta SOAP no gerenciador de implementação.</li>
                    <li><b>mfp.topology.platform</b> - configure o valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - configure o valor como <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector </b> - configure o valor como <b>SOAP</b>.</li>
                </ul>
                
                <b>Em um WebSphere Application Server independente</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - configure o valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - configure o valor como <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector </b> - configure o valor como <b>SOAP</b>.</li>
                </ul>

                <p>Se o serviço de push estiver instalado, você deverá configurar as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>As propriedades JNDI para comunicação com o serviço de configuração são as seguintes:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}</a>.</p>
                
                <h3>Origem de dados</h3>
                <p>Crie uma origem de dados para o serviço de administração e mapeie-a para <b>jdbc/mfpAdminDS</b>.</p>
                
                <h3>Ordem de início</h3>
                <p>O aplicativo de serviço de administração deve ser iniciado antes do aplicativo de tempo de execução. É possível configurar a ordem na seção <b>Comportamento de Inicialização</b>. Por exemplo, configure a Ordem de inicialização como <b>1</b> para o serviço de administração e <b>2</b> para o tempo de execução.</p>
                
                <h3>Funções de segurança</h3>
                <p>As funções de segurança disponíveis para o aplicativo de serviço de administração são:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>Detalhes de configuração do serviço de atualização em tempo real do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>O serviço de atualização em tempo real é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do serviço de atualização em tempo real está em <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>. A raiz de contexto do serviço de atualização em tempo real deve ser definida dessa forma: <b>/the-adminContextRoot/config</b>. Por exemplo, se a raiz de contexto do serviço de administração for <b>/mfpadmin</b>, a raiz de contexto do serviço de atualização em tempo real deverá ser <b>/mfpadminconfig</b>.</p>
                
                <h3>Origem de dados</h3>
                <p>Crie uma origem de dados para o serviço de atualização em tempo real e mapeie-a para <b>jdbc/ConfigDS</b>.</p>

                <h3>Funções de segurança</h3>
                <p>A função <b>configadmin</b> é definida para esse aplicativo.
                <br/><br/>
                Pelo menos um usuário deve ser mapeado para essa função. O usuário e sua senha devem ser fornecidos para as seguintes propriedades JNDI do serviço de administração:</p>
                
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>Detalhes de configuração do {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>O console é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos.
                <br/><br/>Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR do console está em <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>. É possível definir a raiz de contexto conforme desejado. No entanto, geralmente ela é <b>/mfpconsole</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É possível configurar propriedades JNDI com o console de administração do WebSphere Application Server. Acesse <b>Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere → application_name → Entradas de Ambiente</b> para os módulos da web e configure as entradas.
                <br/><br/>
                É preciso definir a propriedade <b>mfp.admin.endpoint</b>. O valor típico para essa propriedade é <b>*://*:*/the-adminContextRoot</b>.
                <br/><br/>
                Para obter mais informações sobre as propriedades JNDI, consulte <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriedades JNDI para {{ site.data.keys.mf_console }}</a>.</p>
                
                <h3>Funções de segurança</h3>
                <p>As funções de segurança disponíveis para o aplicativo são:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Qualquer usuário mapeado para uma função de segurança do console também deverá ser mapeado para a mesma função de segurança do serviço de administração.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>Detalhes de configuração de tempo de execução do MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>O tempo de execução é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml </b>.
                <br/><br/>
                Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.
                <br/><br/>
                O arquivo WAR de tempo de execução está em <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>. É possível definir a raiz de contexto conforme desejado. Entretanto, por padrão, ela é <b>/mfp</b>.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É possível configurar propriedades JNDI com o console de administração do WebSphere Application Server. Acesse <b>Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere → application_name → Entradas de Ambiente</b> para os módulos da web e configure as entradas.</p>
                
                <p>Deve-se definir a propriedade <b>mfp.authorization.server</b> com o valor como integrado.<br/>
                Além disso, defina as propriedades JNDI a seguir para ativer a comunicação JMX com o serviço de administração:</p>
                
                <b>No WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - o nome do host do gerenciador de implementação.</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - a porta SOAP do gerenciador de implementação.</li>
                    <li><b>mfp.topology.platform</b> - configure o valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - configure o valor como <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector </b> - configure o valor como <b>SOAP</b>.</li>
                </ul>
                
                <b>Em um WebSphere Application Server independente</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - configure o valor como <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - configure o valor como <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector </b> - configure o valor como <b>SOAP</b>.</li>
                </ul>
                                
                <p>Se o {{ site.data.keys.mf_analytics }} estiver instalado, é necessário definir as seguintes propriedades JNDI:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>
                
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Lista de propriedades JNDI para o tempo de execução do {{ site.data.keys.product_adj }}</a>.</p>
                
                <h3>Ordem de início</h3>
                <p>O aplicativo de tempo de execução deve ser iniciado após o aplicativo de serviço de administração. É possível configurar a ordem na seção <b>Comportamento de Inicialização</b>. Por exemplo, configure a Ordem de inicialização como <b>1</b> para o serviço de administração e <b>2</b> para o tempo de execução.</p>
                
                <h3>Origem de dados</h3>
                <p>Crie uma origem de dados para o tempo de execução e mapeie-a para <b>jdbc/mfpDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>Detalhes de configuração do serviço de push do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>O serviço de push é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É necessário fazer algumas configurações específicas para esse aplicativo. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.    
                <br/><br/>
                O arquivo WAR do serviço de push está em <b>mfp_install_dir/PushService/mfp-push-service.war</b>. Deve-se definir a raiz de contexto como <b>/imfpush</b>. Caso contrário, os dispositivos do cliente não poderão se conectar a ela, já que a raiz de contexto está codificada permanentemente no SDK.</p>
                
                <h3>Propriedades JNDI obrigatórias</h3>
                <p>É possível configurar propriedades JNDI com o console de administração do WebSphere Application Server. Acesse <b>Aplicativos > Tipos de aplicativos → Aplicativos corporativos WebSphere → application_name → Entradas de ambiente para módulos da web</b> e configure as entradas.</p>
                
                <p>É necessário definir as propriedades a seguir:</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - o valor deve ser <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - para um banco de dados relacional, o valor deve ser DB.</li>
                </ul>
                
                <p>Se {{ site.data.keys.mf_analytics }} estiver configurado, defina as seguintes propriedades JNDI:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - o valor deve ser <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                <p>Para obter informações adicionais sobre as propriedades JNDI, consulte <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Origem de dados</h3>
                <p>Crie a origem de dados para o serviço de push e mapeie-a para <b>jdbc/imfPushDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>Detalhes de configuração de artefatos do {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>O componente de artefatos é empacotado como um aplicativo WAR para você implementar no servidor de aplicativos. É preciso fazer algumas configurações específicas para esse aplicativo no arquivo <b>server.xml</b> do servidor de aplicativos. Antes de continuar, revise <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Instalação manual no WebSphere Application Server e no WebSphere Application Server Network Deployment</a> para obter os detalhes de configuração que são comuns a todos os serviços.</p>
                
                <p>O arquivo WAR para esse componente está em <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>. Deve-se definir a raiz de contexto como <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

## Instalando um server farm
{: #installing-a-server-farm }
É possível instalar seu server farm executando tarefas Ant, com o Server Configuration Tool ou manualmente.

* [Planejando a Configuração de um server farm](#planning-the-configuration-of-a-server-farm)
* [Instalando um server farm com o Server Configuration Tool](#installing-a-server-farm-with-the-server-configuration-tool)
* [Instalando um server farm com tarefas Ant](#installing-a-server-farm-with-ant-tasks)
* [Configurando um server farm manualmente](#configuring-a-server-farm-manually)
* [Verificando uma configuração de farm](#verifying-a-farm-configuration)
* [Ciclo de vida de um nó do server farm](#lifecycle-of-a-server-farm-node)

### Planejando a Configuração de um server farm
{: #planning-the-configuration-of-a-server-farm }
Para planejar a configuração de um server farm, escolha o servidor de aplicativos, configure os bancos de dados do {{ site.data.keys.product_adj }} e implemente os arquivos WAR dos componentes do {{ site.data.keys.mf_server }} em cada servidor do farm. Existem as opções de usar o Server Configuration Tool, tarefas Ant ou operações manuais para configurar um server farm.

Quando você pretender planejar uma instalação de server farm, consulte [Restrições no serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e tempo de execução do MobileFirst](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) primeiro e, em específico, consulte [Topologia de server farm](../topologies/#server-farm-topology).

No {{ site.data.keys.product }}, um server farm é composto por múltiplos servidores de aplicativo independentes que não são federados ou administrados por um componente de gerenciamento de um servidor de aplicativos. O {{ site.data.keys.mf_server }} fornece internamente um plug-in de farm como o meio para aprimorar um servidor de aplicativos para que possa ser parte de um server farm.

#### Quando declarar um server farm
{: #when-to-declare-a-server-farm }
**Declare um server farm nos casos a seguir:**

* O {{ site.data.keys.mf_server }} está instalado em vários servidores de aplicativos Tomcat.
* O {{ site.data.keys.mf_server }} é instalado em vários servidores WebSphere Application Server, mas não no WebSphere Application Server Network Deployment.
* O {{ site.data.keys.mf_server }} é instalado em vários servidores WebSphere Application Server Liberty.

**Não declare um server farm nos seguintes casos:**

* Seu servidor de aplicativos é independente.
* Vários servidores de aplicativos são federados pelo WebSphere Application Server Network Deployment.

#### Por que é obrigatório declarar um farm
{: #why-it-is-mandatory-to-declare-a-farm }
Cada vez que uma operação de gerenciamento é executada por meio do {{ site.data.keys.mf_console }} ou por meio do aplicativo de serviço de administração do {{ site.data.keys.mf_server }}, a operação precisa ser replicada para todas as instâncias de um ambiente de tempo de execução. Exemplos dessas operações de gerenciamento são o upload de uma nova versão de um aplicativo ou de um adaptador. A replicação é feita via chamadas JMX executadas pela instância do aplicativo do serviço de administração que manipula a operação. O serviço de administração precisa contatar todas as instâncias de tempo de execução no cluster. Em ambientes listados em **Quando declarar um server farm** acima, o tempo de execução pode ser contatado por meio de JMX somente se um farm estiver configurado. Se um servidor for incluído em um cluster sem a configuração apropriada do farm, o tempo de execução nesse servidor estará em um estado inconsistente após cada operação de gerenciamento e até que seja reiniciado novamente.

### Instalando um server farm com o Server Configuration Tool
{: #installing-a-server-farm-with-the-server-configuration-tool }
Use o Server Configuration Tool para configurar cada servidor no farm, de acordo com os requisitos do único tipo de servidor de aplicativos que é usado para cada membro do server farm.

Quando você planejar um server farm com o Server Configuration Tool, primeiro crie os servidores independentes e configure seus respectivos armazenamentos confiáveis para que eles possam se comunicar uns com os outros de maneira segura. Em seguida, execute a ferramenta que realiza as operações a seguir:

* Configure a instância de banco de dados compartilhada pelos componentes do {{ site.data.keys.mf_server }}.
* Implementar componentes do {{ site.data.keys.mf_server }} em cada servidor
* Modificar sua configuração para torná-lo membro de um server farm

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Clique para obter instruções sobre como instalar um server farm com o Server Configuration Tool</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>O {{ site.data.keys.mf_server }} requer que a conexão JMX segura seja configurada.</p>
                
                <ol>
                    <li>Prepare os servidores de aplicativos que devem ser configurados como membros do server farm.
                        <ul>
                            <li>Escolha o tipo de servidor de aplicativos que usará para configurar os membros do server farm. {{ site.data.keys.product }} suporta os servidores de aplicativos a seguir em server farms:
                                <ul>
                                    <li>WebSphere Application Server Full Profile<br/>
                                    <b>Nota:</b> Em uma topologia de farm, não é possível usar o conector JMX RMI. Nessa topologia, somente o conector SOAP é suportado pelo {{ site.data.keys.product }}.</li>
                                    <li>perfil Liberty do WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Para saber quais versões dos servidores de aplicativos são suportadas, consulte <a href="../../../product-overview/requirements">Requisitos do sistema</a>.
                                
                                <blockquote><b>Importante:</b> O {{ site.data.keys.product }} suporta apenas server farms homogêneos. Um server farm é homogêneo quando se conecta ao mesmo tipo de servidores de aplicativos. Tentar associar tipos diferentes de servidores de aplicativos levaria a um comportamento imprevisível no tempo de execução. Por exemplo, um farm com uma combinação de servidores Apache Tomcat e servidores de perfil completo do WebSphere Application Server é uma configuração inválida.</blockquote>
                            </li>
                            <li>Configure tantos servidores independentes quanto o número de membros que você deseja no farm.
                                <ul>
                                    <li>Cada um desses servidores independentes deve se comunicar com o mesmo banco de dados. Você deve se certificar também de que nenhuma porta usada por qualquer um desses servidores seja usada por outro servidor configurado no mesmo host. Essa restrição aplica-se a portas usadas pelos protocolos HTTP, HTTPS, REST, SOAP e RMI.</li>
                                    <li>Cada um desses servidores deve ter o serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e um ou mais tempos de execução do {{ site.data.keys.product_adj }} implementados.</li>
                                    <li>Para obter informações adicionais sobre como configurar um servidor, consulte <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Restrições no serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product_adj }}</a>.</li>
                                </ul>
                            </li>
                            <li>Troque os certificados de assinante entre todos os servidores em seus respectivos armazenamentos confiáveis.
                            <br/><br/>
                            Esta etapa é obrigatória para os farms que usam o perfil integral do WebSphere Application Server ou o Liberty, pois a segurança deve ser ativada. Além disso, para farms do Liberty, a mesma configuração de LTPA deve ser replicada em cada servidor para assegurar o recurso de conexão única. Para fazer essa configuração, siga as diretrizes na etapa 6 de <a href="#configuring-a-server-farm-manually">Configurando um server farm manualmente</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Execute o Server Configuration Tool para cada servidor do farm. Todos os servidores devem compartilhar os mesmos bancos de dados. Certifique-se de selecionar o tipo de implementação: <b>Implementação de Server Farm</b> no painel <b>Configurações do Servidor de Aplicativos</b>. Para obter informações adicionais sobre a ferramenta, consulte <a href="#running-the-server-configuration-tool">Executando o Server Configuration Tool</a>.
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Instalando um server farm com tarefas Ant
{: #installing-a-server-farm-with-ant-tasks }
Use tarefas Ant para configurar cada servidor no farm de acordo com os requisitos do único tipo de servidor de aplicativo usado para cada membro do server farm.

Ao planejar um server farm com tarefas Ant, primeiro crie os servidores independentes e configure seus respectivos armazenamentos confiáveis, de modo que eles possam se comunicar uns com os outros de uma maneira segura. Em seguida, execute tarefas Ant para configurar a instância de banco de dados compartilhada pelos componentes do {{ site.data.keys.mf_server }}. Por fim, execute tarefas Ant para implementar os componentes do {{ site.data.keys.mf_server }} em cada servidor e para modificar sua configuração para torná-lo membro de um server farm.

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Clique para obter instruções sobre como instalar um server farm com tarefas Ant</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>O {{ site.data.keys.mf_server }} requer que a conexão JMX segura seja configurada.</p>
                
                <ol>
                    <li>Prepare os servidores de aplicativos que devem ser configurados como membros do server farm.
                        <ul>
                            <li>Escolha o tipo de servidor de aplicativos que usará para configurar os membros do server farm. {{ site.data.keys.product }} suporta os servidores de aplicativos a seguir em server farms:
                                <ul>
                                    <li>Perfil completo do WebSphere Application Server. <b>Nota:</b> Em uma topologia de farm, não é possível usar o conector JMX RMI. Nessa topologia, somente o conector SOAP é suportado pelo {{ site.data.keys.product }}.</li>
                                    <li>perfil Liberty do WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Para saber quais versões dos servidores de aplicativos são suportadas, consulte <a href="../../../product-overview/requirements">Requisitos do sistema</a>.
                                
                                <blockquote><b>Importante:</b> O {{ site.data.keys.product }} suporta apenas server farms homogêneos. Um server farm é homogêneo quando se conecta ao mesmo tipo de servidores de aplicativos. Tentar associar tipos diferentes de servidores de aplicativos levaria a um comportamento imprevisível no tempo de execução. Por exemplo, um farm com uma combinação de servidores Apache Tomcat e servidores de perfil completo do WebSphere Application Server é uma configuração inválida.</blockquote>
                            </li>
                            <li>Configure tantos servidores independentes quanto o número de membros que você deseja no farm.
                            <br/><br/>
                            Cada um desses servidores independentes deve se comunicar com o mesmo banco de dados. Você deve se certificar também de que nenhuma porta usada por qualquer um desses servidores seja usada por outro servidor configurado no mesmo host. Essa restrição aplica-se a portas usadas pelos protocolos HTTP, HTTPS, REST, SOAP e RMI.
                            <br/><br/>
                            Cada um desses servidores deve ter o serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e um ou mais tempos de execução do {{ site.data.keys.product_adj }} implementados.
                            <br/><br/>
                            Para obter informações adicionais sobre como configurar um servidor, consulte <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Restrições no serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product_adj }}</a>.</li>
                            <li>Troque os certificados de assinante entre todos os servidores em seus respectivos armazenamentos confiáveis.
                            <br/><br/>
                            Esta etapa é obrigatória para os farms que usam o perfil integral do WebSphere Application Server ou o Liberty, pois a segurança deve ser ativada. Além disso, para farms do Liberty, a mesma configuração de LTPA deve ser replicada em cada servidor para assegurar o recurso de conexão única. Para fazer essa configuração, siga as diretrizes na etapa 6 de <a href="#configuring-a-server-farm-manually">Configurando um server farm manualmente</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Configure o banco de dados para o serviço de administração, serviço de atualização em tempo real e tempo de execução.
                        <ul>
                            <li>Decida qual banco de dados você deseja usar e escolha o arquivo Ant para criar e configurar o banco de dados no diretório <b>mfp_install_dir/MobileFirstServer/configuration-samples</b>:
                                <ul>
                                    <li>Para DB2, use <b>create-database-db2.xml</b>.</li>
                                    <li>Para MySQL, use <b>create-database-mysql.xml</b>.</li>
                                    <li>Para Oracle, use <b>create-database-oracle.xml</b>.</li>
                                </ul>
                                <blockquote>Nota: não use o banco de dados Derby em uma topologia de farm porque o banco de dados Derby permite apenas uma única conexão de cada vez.</blockquote>

                            </li>
                            <li>Edite o arquivo Ant e insira todas as propriedades necessárias para o banco de dados.
                            <br/><br/>
                            Para ativar a configuração do banco de dados usada pelos componentes do {{ site.data.keys.mf_server }}, configure os valores das propriedades a seguir:
                                <ul>
                                    <li>Configure <b>mfp.process.admin</b> como <b>true</b>. Para configurar o banco de dados para o serviço de administração e o serviço de atualização em tempo real.</li>
                                    <li>Configure <b>mfp.process.runtime</b> como <b>true</b>. Para configurar o banco de dados para o tempo de execução.</li>
                                </ul>
                            </li>
                            <li>Execute os seguintes comandos a partir do diretório <b>mfp_install_dir/MobileFirstServer/configuration-samples</b>, em que <b>create-database-ant-file.xml</b> deve ser substituído pelo nome do arquivo Ant real escolhido: <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> e <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.
                            <br/><br/>
                            Como os bancos de dados do {{ site.data.keys.mf_server }} são compartilhados entre os servidores de aplicativos de um farm, esses dois comandos só devem ser executados uma vez, seja qual for o número de servidores no farm.
                            </li>
                            <li>Como opção, se desejar instalar outro tempo de execução, deve-se configurar outro banco de dados com outro esquema ou nome de banco de dados. Para isso, edite o arquivo Ant, modifique as propriedades e execute o seguinte comando uma vez, independentemente do número de servidores no farm: <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.</li>
                        </ul>
                    </li>
                    <li>Implemente o serviço de administração, o serviço de atualização em tempo real e o tempo de execução nos servidores e configure esses servidores como membros de um server farm.
                        <ul>
                            <li>Escolha o arquivo Ant que corresponde a seu servidor de aplicativos e seu banco de dados no diretório <b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> para implementar o serviço de administração, o serviço de atualização em tempo real e o tempo de execução nos servidores.
                            <br/><br/>
                            Por exemplo, escolha o arquivo <b>configure-liberty-db2.xml</b> para uma implementação no servidor Liberty com o banco de dados DB2. Faça a quantidade de cópias desse arquivo de acordo com o número de membros que você deseja ter no farm. 
                            <br/><br/>
                            <b>Nota:</b> mantenha esses arquivos após a configuração, pois eles podem ser reutilizados para fazer upgrade dos componentes do {{ site.data.keys.mf_server }} que já foram implementados, ou para desinstalá-los de cada membro do farm.</li>
                            <li>Edite cada cópia do arquivo Ant, insira as mesmas propriedades para o banco de dados que são usadas na etapa 2, e também insira as outras propriedades necessárias para o servidor de aplicativos.
                            <br/><br/>
                            Para configurar o servidor como um server farm member, configure os valores das propriedades a seguir:
                                <ul>
                                    <li>Configure <b>mfp.farm.configure</b> como true.</li>
                                    <li><b>mfp.farm.server.id</b>: um identificador que você define para este farm member. Certifique-se de que cada servidor no farm tenha seu próprio identificador exclusivo. Se dois servidores no farm tiverem o mesmo identificador, o farm poderá se comportar de maneira imprevisível.</li>
                                    <li><b>mfp.config.service.user</b>: o nome do usuário que é usado para acessar o serviço de atualização em tempo real. O nome do usuário deve ser o mesmo para todos os membros do farm.</li>
                                    <li><b>mfp.config.service.password</b>: a senha que é usada para acessar o serviço de atualização em tempo real. A senha deve ser a mesma para todos os membros do farm.</li>
                                </ul>
                                Para ativar a implementação dos arquivos WAR dos componentes do {{ site.data.keys.mf_server }} no servidor, configure os valores das propriedades a seguir:
                                    <ul>
                                        <li>Configure <b>mfp.process.admin</b> como <b>true</b>. Para implementar os arquivos WAR do serviço de administração e do serviço de atualização em tempo real.</li>
                                        <li>Configure <b>mfp.process.runtime</b> como <b>true</b>. Para implementar o arquivo WAR do tempo de execução.</li>
                                    </ul>
                                <br/>
                                <b>Nota:</b> se você planeja instalar mais de um tempo de execução nos servidores do farm, especifique o ID de atributo e configure um valor, que deve ser exclusivo para cada tempo de execução nas tarefas Ant <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> e <b>uninstallmobilefirstruntime</b>.
                                <br/>
                                Por exemplo,
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>Para cada servidor, execute os seguintes comandos em que <b>configure-appserver-database-ant-file.xml</b> deve ser substituído pelo nome do arquivo Ant real escolhido: <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> e <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>.
                            <br/><br/>
                            Esses comandos executam as tarefas Ant <b>installmobilefirstadmin</b> e <b>installmobilefirstruntime</b>. Para obter informações adicionais sobre essas tarefas, consulte <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">Tarefas Ant para instalação de artefatos do {{ site.data.keys.mf_console }}, do {{ site.data.keys.mf_server }}, serviços de administração e de atualização em tempo real do {{ site.data.keys.mf_server }}</a> e <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}</a>.
                            </li>
                            <li>Opcionalmente, se você deseja instalar outro tempo de execução, execute as etapas a seguir:
                                <ul>
                                    <li>Faça uma cópia do arquivo Ant configurado na etapa 3.b.</li>
                                    <li>Edite a cópia, configure uma raiz de contexto distinta e um valor para o atributo <b>id</b> de <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> e <b>uninstallmobilefirstruntime</b> que seja diferente da configuração do outro tempo de execução.</li>
                                    <li>Execute o seguinte comando em cada servidor no farm em que <b>configure-appserver-database-ant-file2.xml</b> deve ser substituído pelo nome real do arquivo Ant que foi editado: <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code>.</li>
                                    <li>Repita essa etapa para cada servidor do farm.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>Reinicialize todos os servidores.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Configurando um server farm manualmente
{: #configuring-a-server-farm-manually }
Deve-se configurar cada servidor no farm de acordo com os requisitos do único tipo de servidor de aplicativos usado para cada membro do server farm.

Ao planejar um server farm, crie primeiramente servidores independentes que se comuniquem com a mesma instância de banco de dados. Em seguida, modifique a configuração desses servidores para torná-los membros de um server farm.

<div class="panel-group accordion" id="configuring-manually" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>Clique para obter instruções sobre como configurar um server farm manualmente</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>Escolha o tipo de servidor de aplicativos que usará para configurar os membros do server farm. {{ site.data.keys.product }} suporta os servidores de aplicativos a seguir em server farms:
                        <ul>
                            <li>WebSphere Application Server Full Profile<br/>
                            <b>Nota:</b> Em uma topologia de farm, não é possível usar o conector JMX RMI. Nessa topologia, somente o conector SOAP é suportado pelo {{ site.data.keys.product }}.</li>
                            <li>perfil Liberty do WebSphere Application Server</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        Para saber quais versões dos servidores de aplicativos são suportadas, consulte <a href="../../../product-overview/requirements">Requisitos do sistema</a>.
                        
                        <blockquote><b>Importante:</b> O {{ site.data.keys.product }} suporta apenas server farms homogêneos. Um server farm é homogêneo quando se conecta ao mesmo tipo de servidores de aplicativos. Tentar associar tipos diferentes de servidores de aplicativos levaria a um comportamento imprevisível no tempo de execução. Por exemplo, um farm com uma combinação de servidores Apache Tomcat e servidores de perfil completo do WebSphere Application Server é uma configuração inválida.</blockquote>
                    </li>
                    <li>Decida qual banco de dados você deseja usar. É possível escolher entre:
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        Os bancos de dados do {{ site.data.keys.mf_server }} são compartilhados entre os servidores de aplicativos de um farm, ou seja:
                        <ul>
                            <li>Você cria o banco de dados apenas uma vez, independentemente do número de servidores no farm.</li>
                            <li>Não é possível usar o banco de dados Derby em uma topologia de farm porque esse banco de dados permite somente uma única conexão de cada vez.</li>
                        </ul>
                        Para obter informações adicionais sobre bancos de dados, consulte <a href="../databases">Configurando bancos de dados</a>.
                    </li>
                    <li>Configure tantos servidores independentes quanto o número de membros que você deseja no farm.
                        <ul>
                            <li>Cada um desses servidores independentes deve se comunicar com o mesmo banco de dados. Você deve se certificar também de que nenhuma porta usada por qualquer um desses servidores seja usada por outro servidor configurado no mesmo host. Essa restrição aplica-se a portas usadas pelos protocolos HTTP, HTTPS, REST, SOAP e RMI.</li>
                            <li>Cada um desses servidores deve ter o serviço de administração do {{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e um ou mais tempos de execução do {{ site.data.keys.product_adj }} implementados.</li>
                            <li>Quando cada um desses servidores está trabalhando corretamente em uma topologia independente, é possível transformá-los em membros de um server farm.</li>
                        </ul>
                    </li>
                    <li>Pare todos os servidores que devem ser membros do farm.</li>
                    <li>Configure cada servidor apropriadamente para o tipo de servidor de aplicativos.<br/>Deve-se configurar algumas propriedades JNDI corretamente. Em uma topologia de server farm, as propriedades JNI mfp.config.service.user e mfp.config.service.password devem ter o mesmo valor para todos os membros do farm. Para o Apache Tomcat, deve-se também verificar se os argumentos da JVM estão definidos adequadamente.
                        <ul>
                            <li><b>Perfil Liberty do WebSphere Application Server</b>
                                <br/>
                                No arquivo server.xml, configure as propriedades JNDI mostradas no seguinte código de amostra.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                Essas propriedades devem ser configuradas com valores apropriados:
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: o identificador definido para este membro do farm. Esse identificador deve ser exclusivo entre todos os membros do farm.</li>
                                    <li><b>mfp.admin.jmx.user</b> e <b>mfp.admin.jmx.pwd</b>: esses valores devem corresponder às credenciais de um usuário conforme declarado no elemento <code>administrator-role</code>.</li>
                                    <li><b>mfp.admin.jmx.host</b>: configure este parâmetro para o IP ou nome do host usados pelos membros remotos para acessar esse servidor. Portanto, não o configure para <b>localhost</b>. Esse é o nome do host usado pelos outros membros do farm e deve estar acessível para todos os membros do farm.</li>
                                    <li><b>mfp.admin.jmx.port</b>: configure este parâmetro para a porta HTTPS do servidor usada para a conexão REST do JMX. É possível localizar o valor no elemento <code>httpEndpoint</code> do arquivo <b>server.xml</b>.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                Modifique o arquivo <b>conf/server.xml</b> para configurar as propriedades JNDI a seguir no contexto do serviço de administração e em cada contexto de tempo de execução.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                A propriedade <b>mfp.admin.serverid</b> deve ser configurada para o identificador definido para esse membro do farm. Esse identificador deve ser exclusivo entre todos os membros do farm.
                                <br/>
                                Você deve se certificar de que o argumento de JVM <code>-Djava.rmi.server.hostname</code> esteja configurado para o IP ou nome do host usados pelos membros remotos para acessar esse servidor. Portanto, não o configure para <b>localhost</b>. Além disso, você deve se certificar de que o argumento da JVM <code>-Dcom.sun.management.jmxremote.port</code> esteja configurado com uma porta que ainda não estejam em uso para ativar conexões JMX RMI. Ambos os argumentos são configurados na variável de ambiente <b>CATALINA_OPTS</b>.
                            </li>
                            <li><b>Perfil integral do WebSphere Application Server</b>
                                <br/>
                                Deve-se declarar as propriedades JNDI a seguir no serviço de administração e em cada aplicativo de tempo de execução implementado no servidor.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                No console do WebSphere Application Server,
                                <ul>
                                    <li>selecione <b>Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere</b>.</li>
                                    <li>Selecione o aplicativo de serviço de administração.</li>
                                    <li>Em <b>Propriedades do Módulo da Web</b>, clique em <b>Entradas de Ambiente para Módulos da Web</b> para exibir as propriedades de JNDI.</li>
                                    <li>Configure os valores das propriedades a seguir.
                                        <ul>
                                            <li>Configure <b>mfp.topology.clustermode</b> como <b>Farm</b>.</li>
                                            <li>Configura <b>mfp.admin.serverid</b> para o identificador escolhido para este membro do farm. Esse identificador deve ser exclusivo entre todos os membros do farm.</li>
                                            <li>Configure <b>mfp.admin.jmx.user</b> para o nome do usuário que têm acesso ao conector SOAP.</li>
                                            <li>Configure <b>mfp.admin.jmx.pwd</b> para a senha do usuário conforme declarado no <b>mfp.admin.jmx.user</b>.</li>
                                            <li>Configure <b>mfp.admin.jmx.port</b> para o valor da porta SOAP.</li>
                                        </ul>
                                    </li>
                                    <li>Verifique se <b>mfp.admin.jmx.connector</b> está configurado para <b>SOAP</b>.</li>
                                    <li>Clique em <b>OK</b> e salve a configuração.</li>
                                    <li>Faça mudanças semelhantes para cada aplicativo de tempo de execução do {{ site.data.keys.product_adj }} implementado no servidor.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Troque os certificados do servidor em seus armazenamentos confiáveis entre todos os membros do farm. A troca de certificados do servidor em seus armazenamentos confiáveis é obrigatória para farms que usam o perfil completo do WebSphere Application Server e o perfil Liberty do WebSphere Application Server, porque nesses farms, as comunicações entre os servidores são protegidas por SSL.
                        <ul>
                            <li><b>Perfil Liberty do WebSphere Application Server</b>
                                <br/>
                                É possível configurar o armazenamento confiável usando utilitários IBM como Keytool ou iKeyman.
                                <ul>
                                    <li>Para obter informações adicionais sobre Keytool, consulte <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a> no IBM SDK, Java Technology Edition.</li>
                                    <li>Para obter informações adicionais sobre iKeyman, consulte <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a> no IBM SDK, Java Technology Edition.</li>
                                </ul>
                                As localizações do keystore e do armazenamento confiável são definidas no arquivo <b>server.xml</b>. Consulte os atributos <b>keyStoreRef</b> e <b>trustStoreRef</b> em <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">Atributos de configuração SSL</a>. Por padrão, o keystore do perfil Liberty está em <b>${server.config.dir}/resources/security/key.jks</b>. Se a referência de armazenamento confiável estiver ausente ou não estiver definido no arquivo <b>server.xml</b>, o keystore especificado por <b>keyStoreRef</b> será usado. O servidor usa o keystore padrão e o arquivo é criado na primeira vez que o servidor é executado. Nesse caso, um certificado padrão é criado com um período de validade de 365 dias. Para produção, você pode considerar usar seu próprio certificado (incluindo os intermediários, se necessário) ou mudar a data de expiração do certificado gerado.
                                
                                <blockquote>Nota: se desejar confirmar o local do armazenamento confiável, isso pode ser feito incluindo a seguinte declaração no arquivo server.xml:
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                Por último, inicie o servidor e procure linhas que contenham com.ibm.ssl.trustStore no arquivo <b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b>.
                                <ul>
                                    <li>Importe os certificados públicos dos outros servidores no farm para o armazenamento confiável referenciado pelo arquivo de configuração <b>server.xml</b> do servidor. O tutorial <a href="../tutorials/graphical-mode">Instalando o {{ site.data.keys.mf_server }} no modo gráfico</a> fornece as instruções para trocar os certificados entre dois servidores Liberty em um farm. Para obter informações adicionais, consulte a etapa 5 da seção <a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">Criando um farm de dois servidores Liberty que executam o {{ site.data.keys.mf_server }}</a>.</li>
                                    <li>Reinicie cada instância do perfil Liberty do WebSphere Application Server para que a configuração de segurança entre em vigor. As etapas a seguir são necessárias para a conexão única (SSO) funcionar.</li>
                                    <li>Inicie um membro do farm. Na configuração padrão de LTPA, após o início bem-sucedido do servidor Liberty, ele gera um keystore LTPA como <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys.</b></li>
                                    <li>Copie o arquivo <b>ltpa.keys</b> para o diretório <b>${wlp.user.dir}/servers/server_name/resources/security</b> de cada membro de farm para replicar os keystores LTPA nos membros de farm. Para obter mais informações sobre a configuração de LTPA, consulte <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Configurando LTPA no perfil do Liberty</a>.</li>
                                </ul>
                            </li>
                            <li><b>Perfil integral do WebSphere Application Server</b>
                                <br/>
                                Configure o armazenamento confiável no console de administração do WebSphere Application Server.
                                <ul>
                                    <li>Efetue login no console administrativo do WebSphere Application Server.</li>
                                    <li>Selecione <b>Segurança → Certificado SSL e gerenciamento de chave</b>.</li>
                                    <li>Em <b>Itens relacionados</b>, selecione <b>Keystores e certificados</b>.</li>
                                    <li>No campo <b>Usos do keystore</b>, certifique-se de que <b>Keystores SSL</b> esteja selecionado. Agora é possível importar os certificados de todos os outros servidores no farm.</li>
                                    <li>Clique em <b>NodeDefaultTrustStore</b>.</li>
                                    <li>Em <b>Propriedades adicionais</b>, selecione <b>Certificados de assinantes</b>.</li>
                                    <li>Clique em <b>Recuperar a Partir da Porta</b>. Agora é possível inserir os detalhes de comunicação e segurança de cada um dos outros servidores no farm. Siga as próximas etapas para cada um dos outros membros do farm.</li>
                                    <li>No campo <b>Host</b>, insira o nome do host do servidor ou o endereço IP.</li>
                                    <li>No campo <b>Porta</b>, insira a porta de transporte HTTPS (SSL).</li>
                                    <li>Em <b>Configuração SSL para conexão de saída</b>, selecione <b>NodeDefaultSSLSettings</b>.</li>
                                    <li>No campo <b>Alias</b>, insira um alias para esse certificado de assinante.</li>
                                    <li>Clique em <b>Recuperar Informações do Signatário</b>.</li>
                                    <li>Revise as informações que são recuperadas do servidor remoto e, em seguida, clique em <b>OK</b>.</li>
                                    <li>Clique em <b>Salvar</b>.</li>
                                    <li>Reinicialize o servidor.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Verificando uma configuração de farm
{: #verifying-a-farm-configuration }
O propósito desta tarefa é verificar o status dos membros do farm e verificar se um farm está configurado corretamente.

1. Inicie todos os servidores do farm.
2. Acessar o {{ site.data.keys.mf_console }}. Por exemplo, **http://server_name:port/mfpconsole** ou **https://hostname:secure_port/mfpconsole** no HTTPS.
    Na barra lateral do console, aparece um menu extra que é nomeado como Nós do server farm.
3. Clique em **Nós do Server Farm** para acessar a lista de membros do farm registrados e seus status. No exemplo a seguir, o nó identificado como **FarmMember2** é considerado inativo, o que indica que esse servidor provavelmente falhou e requer manutenção.

![Status de nós farm no {{ site.data.keys.mf_console }}](farm_nodes_status_list.jpg)

### Ciclo de vida de um nó do server farm
{: #lifecycle-of-a-server-farm-node }
É possível configurar a taxa de pulsação e os valores de tempo limite para indicar possíveis problemas do servidor entre os membros do farm, acionando uma mudança no status de um nó afetado.

#### Servidores de registro e monitoramento como nós farm
{: #registration-and-monitoring-servers-as-farm-nodes }
Quando um servidor configurado como um nó farm é iniciado, o serviço de administração nesse servidor o registra automaticamente como um novo membro do farm.
Quando um membro do farm é encerrado, ele cancela o registro automaticamente do farm.

Existe um mecanismo de pulsação para manter o controle de membros do farm que podem se tornar irresponsivos, por exemplo, por causa de uma indisponibilidade de energia ou de uma falha do servidor. Nesse mecanismo de pulsação, os tempos de execução do {{ site.data.keys.product_adj }} enviam periodicamente uma pulsação para os serviços de administração do {{ site.data.keys.product_adj }} em uma taxa especificada. Se o serviço de administração do {{ site.data.keys.product_adj }} registrar que decorreu muito tempo desde que um membro do farm enviou uma pulsação, o membro do farm será considerado inativo.

Membros do farm que são considerados inativos não atendem mais às solicitações de aplicativos móveis.

Ter um ou mais nós inativos não impede os outros membros do farm de atenderem às solicitações corretamente para aplicativos móveis, nem de aceitarem novas operações de gerenciamento acionadas por meio de {{ site.data.keys.mf_console }}.

#### Configurando a taxa de pulsação e os valores de tempo limite
{: #configuring-the-heartbeat-rate-and-timeout-values }
É possível configurar a taxa de pulsação e os valores de tempo limite definindo as propriedades de JNDI a seguir:

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
Para obter mais informações sobre as propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).
