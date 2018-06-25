---
layout: tutorial
title: Instalando e configurando para licenciamento do token
breadcrumb_title: Token licensing
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Se você planeja usar o licenciamento de token para o {{ site.data.keys.mf_server }}, deve-se instalar a biblioteca do Rational Common Licensing e configurar seu servidor de aplicativos para conectar o {{ site.data.keys.mf_server }} ao Rational License Key Server.

Os tópicos a seguir descrevem a visão geral de instalação, a instalação manual da biblioteca do Rational Common Licensing, a configuração do servidor de aplicativos e as limitações de plataforma para licenciamento de token.

#### Ir para
{: #jump-to }

* [Planejando o uso do licenciamento de token](#planning-for-the-use-of-token-licensing)
* [Visão geral da instalação para licenciamento de token](#installation-overview-for-token-licensing)
* [Conectando o {{ site.data.keys.mf_server }} instalado no Apache Tomcat ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Conectando o {{ site.data.keys.mf_server }} instalado no perfil Liberty do WebSphere Application Server ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Conectando o {{ site.data.keys.mf_server }} instalado no WebSphere Application Server ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Limitações de plataformas suportadas para licenciamento de token](#limitations-of-supported-platforms-for-token-licensing)
* [Resolução de problemas de licenciamento de token](#troubleshooting-token-licensing-problems)

## Planejando o uso do licenciamento de token
{: #planning-for-the-use-of-token-licensing }
Se o licenciamento de token for comprado para o {{ site.data.keys.mf_server }}, haverá etapas extras a serem consideradas no planejamento da instalação.

### Restrições técnicas
{: #technical-restrictions }
Aqui estão as restrições técnicas para o uso do licenciamento de token:

#### Plataformas suportadas:
{: #supported-platforms }
A lista de plataformas que suportam o licenciamento de token está em [Limitações de plataformas suportadas para licenciamento de token](#limitations-of-supported-platforms-for-token-licensing). A instalação e configuração do {{ site.data.keys.mf_server }} em execução em uma plataforma que não esteja listada pode não ser possível para o licenciamento de token. As bibliotecas nativas para o cliente Rational Common Licensing podem não estar disponíveis para a plataforma ou não serem suportadas.

#### Topologias suportadas:
{: #supported-topologies }
As topologias suportadas pelo licenciamento de token estão listadas em [Restrições no serviço de administração do {{ site.data.keys.mf_server }}, no serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e no tempo de execução do {{ site.data.keys.product_adj }}](../prod-env/topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime).

### Requisito de rede
{: #network-requirement }
{{ site.data.keys.mf_server }} O deve poder se comunicar com o Rational License Key Server.

Essa comunicação requer o acesso às duas portas a seguir do servidor de licença:

* Porta do daemon de gerenciador de licença (**lmgrd**) - o número da porta padrão é 27000.
* Porta do daemon de fornecedor (**ibmratl**)
 
Para configurar as portas para que usem valores estáticos, consulte Como entregar uma chave de licença para máquinas clientes através de um firewall.

### Processo de Instalação
{: #installation-process }
É preciso ativar o licenciamento de token quando executar o IBM Installation Manager no momento da instalação. Para obter informações adicionais sobre as instruções para ativar o licenciamento de token, consulte [Visão geral de instalação para licenciamento de token](#installation-overview-for-token-licensing).

Após a instalação do {{ site.data.keys.mf_server }}, deve-se configurar manualmente o servidor para licenciamento de token. Para obter mais informações, consulte os tópicos a seguir nesta seção.

O {{ site.data.keys.mf_server }} não fica funcional antes da conclusão dessa configuração manual. A biblioteca do cliente Rational Common Licensing deve ser instalada em seu servidor de aplicativo, e você define o local do Rational License Key Server.

### Operações
{: #operations }
Após a instalação e configuração do {{ site.data.keys.mf_server }} para licenciamento de token, o servidor valida licenças durante vários cenários. Para obter mais informações sobre a recuperação de tokens durante operações, consulte [Validação da licença de token](../../../administering-apps/license-tracking/#token-license-validation).

Se for necessário testar um aplicativo de não produção em um servidor de produção com o licenciamento de token ativado, será possível declarar o aplicativo como de não produção. Para obter mais informações sobre como declarar o tipo de aplicativo, consulte [Configurando informações sobre licença do aplicativo](../../../administering-apps/license-tracking/#setting-the-application-license-information).

## Visão geral da instalação para licenciamento de token
{: #installation-overview-for-token-licensing }
Se você pretende usar o licenciamento de token com o {{ site.data.keys.product }}, certifique-se de passar pelas etapas preliminares a seguir nesta ordem.

> **Importante:** Sua opção sobre licenciamento de token (ativá-lo ou não) como parte de uma instalação que suporta licenciamento de token não pode ser modificada. Se posteriormente for necessário mudar a opção de licenciamento de token, o {{ site.data.keys.product }} deverá ser desinstalado e reinstalado.

1. Ative o licenciamento de token quando executar o IBM Installation Manager para instalar o {{ site.data.keys.product }}.

   #### Instalação no modo de gráfico
   Se você instalar o produto no modo de gráfico, selecione **Ativar licenciamento de token com o Rational License Key Server** no painel **Configurações Gerais** durante a instalação.
    
   ![Ativando o licenciamento de token no IBM Installation Manager](licensing_with_tokens_activate.jpg)
    
   #### Instalação no modo de linha de comando
   Se você instalar no modo silencioso, configure o valor como **true** para o parâmetro **user.licensed.by.tokens** no arquivo de resposta.  
   Por exemplo, você pode usar:
    
   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```
    
2. Implemente o {{ site.data.keys.mf_server }} em um servidor de aplicativos após a instalação do produto ser concluída. Para obter informações adicionais, consulte [Instalando o {{ site.data.keys.mf_server }} em um servidor de aplicativos](../prod-env/appserver).

3. Configure o {{ site.data.keys.mf_server }} para licenciamento de token. As etapas dependem do servidor de aplicativos.

* Para o perfil Liberty do WebSphere Application Server, consulte [Conectando o {{ site.data.keys.mf_server }} instalado no perfil Liberty do WebSphere Application Server ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* Para Apache Tomcat, consulte [Conectando o {{ site.data.keys.mf_server }} instalado no Apache Tomcat ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* Para o perfil completo do WebSphere Application Server, consulte [Conectando o {{ site.data.keys.mf_server }} instalado no WebSphere Application Server ao Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server).

## Conectando o {{ site.data.keys.mf_server }} instalado no Apache Tomcat ao Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
Deve-se instalar as bibliotecas nativas e Java do Rational Common Licensing no servidor de aplicativos Apache Tomcat antes de conectar o {{ site.data.keys.mf_server }} ao Rational License Key Server.

* O Rational License Key Server 8.1.4.8 ou mais recente deve ser instalado e configurado. A rede deve permitir a comunicação com e a partir do {{ site.data.keys.mf_server }}, abrindo as portas de comunicação bidirecionais (**lmrgd** e **ibmratl**). Para obter informações adicionais, consulte [Portal do Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) e [Como entregar uma chave de licença para máquinas clientes através de um firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Certifique-se de que as chaves de licença para {{ site.data.keys.product }} sejam geradas. Para obter informações adicionais sobre como gerar e gerenciar suas chaves de licença com o IBM Rational License Key Center, consulte [Suporte IBM - Licenciamento](http://www.ibm.com/software/rational/support/licensing/) e [Obtendo chaves de licença com o IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* O {{ site.data.keys.mf_server }} deve ser instalado e configurado com a opção Ativar licenciamento de token com o Rational License Key Server no Apache Tomcat, conforme indicado em [Visão geral de instalação para licenciamento de token](#installation-overview-for-token-licensing).

### Instalando bibliotecas do Rational Common Licensing
{: #installing-rational-common-licensing-libraries }

1. Escolha a biblioteca nativa do Rational Common Licensing. Dependendo do sistema operacional e da versão de bit do Java Runtime Environment (JRE) em que o Apache Tomcat está sendo executado, deve-se escolher a biblioteca nativa correta em **product\_install\_dir/MobileFirstServer/tokenLibs/bin/your\_corresponding\_platform/the\_native\_library\_file**. Por exemplo, para Linux x86 com um JRE de 64 bits, a biblioteca pode ser localizada em **product\_install\_dir/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**.
2. Copie a biblioteca nativa para o computador que executa o serviço de administração do {{ site.data.keys.mf_server }}. O diretório pode ser **${CATALINA_HOME}/bin**. 
    > **Nota:** **${CATALINA_HOME}** é o diretório de instalação do Apache Tomcat.
3. Copie o arquivo **rcl_ibmratl.jar** para **${CATALINA_HOME}/lib**. O arquivo **rcl_ibmratl.jar** é uma biblioteca Java do Rational Common Licensing que pode ser localizada no diretório **product\_install\_dir/MobileFirstServer/tokenLibs**. A biblioteca usa a biblioteca nativa que foi copiada na Etapa 2, e pode ser carregada somente uma vez pelo Apache Tomcat. Esse arquivo pode ser colocado no diretório **${CATALINA_HOME}/lib** ou em qualquer diretório no caminho do carregador de classes comum do Apache Tomcat.
    > **Importante:** A Java virtual machine (JVM) do Apache Tomcat precisa de privilégios de leitura e execução nas bibliotecas nativas e Java copiadas. Ambos os arquivos copiados também devem ser legíveis e executáveis pelo menos para o processo do servidor de aplicativos em seu sistema operacional.
4. Configure o acesso à biblioteca do Rational Common Licensing pela JVM de seu servidor de aplicativos. Para quaisquer sistemas operacionais, configure o arquivo **${CATALINA_HOME}/bin/setenv.bat** (ou o arquivo **setenv.sh** no UNIX), incluindo a seguinte linha:

   **Windows:**  
    
   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```
    
   **UNIX:**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```
    
   > **Nota:** Se você mover a pasta de configuração do servidor em que o serviço de administração está sendo executado, deve atualizar o **java.library.path** com o novo caminho absoluto.

5. Configure o {{ site.data.keys.mf_server }} para acessar o Rational License Key Server. No arquivo **${CATALINA_HOME}/conf/server.xml**, procure o elemento `Context` do aplicativo do serviço de administração e inclua nessas linhas de configuração JNDI.

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname** é o nome do host do Rational License Key Server.
   * **rlks_port** é a porta do Rational License Key Server. Por padrão, o valor é **27000**.

Para obter mais informações sobre as propriedades JNDI, consulte [Propriedades JNDI para serviços de administração: licenciamento](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Instalando na server farm do Apache Tomcat
{: #installing-on-apache-tomcat-server-farm }
Para configurar a conexão do {{ site.data.keys.mf_server }} no server farm Apache Tomcat, deve-se seguir todas as etapas que estão descritas em [Instalando bibliotecas do Rational Common Licensing](#installing-rational-common-licensing-libraries) para cada nó de seu server farm em que o serviço de administração do {{ site.data.keys.mf_server }} está em execução. Para obter informações adicionais sobre o server farm, consulte [Topologia do server farm](../prod-env/topologies/#server-farm-topology) e [Instalando um server farm](../prod-env/appserver/#installing-a-server-farm).

## Conectando o {{ site.data.keys.mf_server }} instalado no perfil Liberty do WebSphere Application Server ao Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
Deve-se instalar as bibliotecas nativas e Java do Rational Common Licensing no perfil Liberty antes de conectar o {{ site.data.keys.mf_server }} ao Rational License Key Server.

* O Rational License Key Server 8.1.4.8 ou mais recente deve ser instalado e configurado. A rede deve permitir a comunicação com e a partir do {{ site.data.keys.mf_server }}, abrindo as portas de comunicação bidirecionais (**lmrgd** e **ibmratl**). Para obter informações adicionais, consulte [Portal do Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) e [Como entregar uma chave de licença para máquinas clientes através de um firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Certifique-se de que as chaves de licença para {{ site.data.keys.product }} sejam geradas. Para obter informações adicionais sobre como gerar e gerenciar suas chaves de licença com o IBM Rational License Key Center, consulte [Suporte IBM - Licenciamento](http://www.ibm.com/software/rational/support/licensing/) e [Obtendo chaves de licença com o IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* O {{ site.data.keys.mf_server }} deve ser instalado e configurado com a opção Ativar licenciamento de token com o Rational License Key Server no Apache Tomcat, conforme indicado em [Visão geral de instalação para licenciamento de token](#installation-overview-for-token-licensing).

### Instalando bibliotecas do Rational Common Licensing
{: #common-licensing-libraries-liberty }

1. Defina uma biblioteca compartilhada para o cliente Rational Common Licensing. Essa biblioteca usa código nativo e pode ser carregada apenas uma vez pelo servidor de aplicativos. Desse modo, os aplicativos que o utilizam devem referenciá-lo como uma biblioteca comum.
   * Escolha a biblioteca nativa do Rational Common Licensing. Dependendo do sistema operacional e da versão de bit do Java Runtime Environment (JRE) em que o perfil Liberty está sendo executado, deve-se escolher a biblioteca nativa correta em **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**. Por exemplo, para Linux x86 com um JRE de 64 bits, a biblioteca pode ser localizada em **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
   * Copie a biblioteca nativa para o computador que executa o serviço de administração do {{ site.data.keys.mf_server }}. O diretório pode ser **${shared.resource.dir}/rcllib**. O diretório **${shared.resource.dir}** geralmente está em **usr/shared/resources**, em que usr é o diretório que também contém o diretório usr/servers. Para obter informações adicionais sobre o local padrão de **${shared.resource.dir}**, consulte [WebSphere  Application Server Liberty Core - Locais e propriedades do diretório](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc). Se a pasta **rcllib** não existir, crie essa pasta e, em seguida, copie o arquivo de biblioteca nativa.
    
   > **Nota:** Certifique-se de que a Java virtual machine (JVM) do servidor de aplicativos tenha privilégios de leitura e execução na biblioteca nativa. No Windows, aparece a seguinte exceção no log do servidor de aplicativos, se a JVM do servidor de aplicativos não tiver os direitos executáveis na biblioteca nativa copiada.
    
   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * Copie o arquivo **rcl_ibmratl.jar** para **${shared.resource.dir}/rcllib**. O arquivo **rcl_ibmratl.jar** é uma biblioteca Java do Rational Common Licensing que pode ser localizada no diretório **product_install_dir/MobileFirstServer/tokenLibs**.

   > **Nota:** A Java virtual machine (JVM) de perfil Liberty deve ter a possibilidade de ler a biblioteca Java copiada. Esse arquivo também deve ter privilégio de leitura (pelo menos para o processo do servidor de aplicativos) em seu sistema operacional.    
   * Declare uma biblioteca compartilhada que usa o arquivo **rcl_ibmratl.jar** no arquivo **${server.config.dir}/server.xml**.

   ```xml
   <!-- Declare uma biblioteca compartilhada para o cliente RCL. -->
   <!- Essa biblioteca pode ser carregada apenas uma vez, pois ela usa código nativo. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * Indique a biblioteca compartilhada como uma biblioteca comum para o aplicativo de serviço de administração do {{ site.data.keys.mf_server }}, incluindo um atributo (**commonLibraryRef**) no carregador de classes do aplicativo. Como a biblioteca pode ser carregada somente uma vez, deve-se usá-la como uma biblioteca comum e não como uma biblioteca privada.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Declare a biblioteca compartilhada como um atributo commonLibraryRef
          para o carregador de classes do aplicativo. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * Se estiver usando Oracle como banco de dados, o **server.xml** já terá o seguinte carregador de classes:

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```
    
   Também é preciso anexar a biblioteca do Rational Common Licensing como uma biblioteca comum à biblioteca do Oracle, conforme a seguir:
    
   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * Configure o acesso à biblioteca do Rational Common Licensing pela JVM de seu servidor de aplicativos. Para quaisquer sistemas operacionais, configure o arquivo **${wlp.user.dir}/servers/server_name/jvm.options** incluindo a seguinte linha:

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```
    
   > **Nota:** Se você mover a pasta de configuração do servidor em que o serviço de administração está sendo executado, deve atualizar o **java.library.path** com o novo caminho absoluto.

   O diretório **${wlp.user.dir}** geralmente está em **liberty_install_dir/usr** e contém o diretório de servidores. Entretanto, seu local pode ser customizado. Para obter mais informações, consulte [Customizando o ambiente do Liberty](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc)
    
2. Configure o {{ site.data.keys.mf_server }} para acessar o Rational License Key Server.

   No arquivo **${wlp.user.dir}/servers/server_name/server.xml**, inclua essas linhas de configuração JNDI.
    
   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/> 
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/> 
   ```
   * **rlks_hostname** é o nome do host do Rational License Key Server.
   * **rlks_port** é a porta do Rational License Key Server. Por padrão,
o valor é 27000.

   Para obter mais informações sobre as propriedades JNDI, consulte [Propriedades JNDI para serviços de administração: licenciamento](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Instalando na server farm do perfil Liberty
{: #installing-on-liberty-profile-server-farm }
Para configurar a conexão do {{ site.data.keys.mf_server }} no server farm do perfil Liberty, deve-se seguir todas as etapas descritas em [Instalando bibliotecas do Rational Common Licensing](#installing-rational-common-licensing-libraries) para cada nó de seu server farm em que o serviço de administração do {{ site.data.keys.mf_server }} está em execução. Para obter informações adicionais sobre o server farm, consulte [Topologia do server farm](../prod-env/topologies/#server-farm-topology) e [Instalando um server farm](../prod-env/appserver/#installing-a-server-farm).

## Conectando o {{ site.data.keys.mf_server }} instalado no WebSphere Application Server ao Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
Deve-se configurar uma biblioteca compartilhada para as bibliotecas do Rational Common Licensing no WebSphere Application Server antes de conectar o {{ site.data.keys.mf_server }} ao Rational License Key Server.

* O Rational License Key Server 8.1.4.8 ou mais recente deve ser instalado e configurado. A rede deve permitir a comunicação com e a partir do {{ site.data.keys.mf_server }}, abrindo as portas de comunicação bidirecionais (**lmrgd** e **ibmratl**). Para obter informações adicionais, consulte [Portal do Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) e [Como entregar uma chave de licença para máquinas clientes através de um firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Certifique-se de que as chaves de licença para {{ site.data.keys.product }} sejam geradas. Para obter informações adicionais sobre como gerar e gerenciar suas chaves de licença com o IBM Rational License Key Center, consulte [Suporte IBM - Licenciamento](http://www.ibm.com/software/rational/support/licensing/) e [Obtendo chaves de licença com o IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* O {{ site.data.keys.mf_server }} deve ser instalado e configurado com a opção Ativar licenciamento de token com o Rational License Key Server no Apache Tomcat, conforme indicado em [Visão geral de instalação para licenciamento de token](#installation-overview-for-token-licensing).

### Instalando a biblioteca do Rational Common Licensing em um servidor independente
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. Defina uma biblioteca compartilhada para a biblioteca do Rational Common Licensing. Essa biblioteca usa código nativo e pode ser carregada somente uma vez por um carregador de classes durante o ciclo de vida do servidor de aplicativos. Por esse motivo, a biblioteca é declarada como uma biblioteca compartilhada e associada a todos os servidores de aplicativos que executam o serviço de administração do {{ site.data.keys.mf_server }}. Para obter mais informações sobre os motivos para declarar essa biblioteca como uma biblioteca compartilhada, consulte [Configurando bibliotecas nativas em bibliotecas compartilhadas](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc).
    * Escolha a biblioteca nativa do Rational Common Licensing. Dependendo do sistema operacional e da versão de bit do Java Runtime Environment (JRE) em que o WebSphere Application Server está em execução, deve-se escolher a biblioteca nativa correta em **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**.
    
        Por exemplo, para Linux x86 com um JRE de 64 bits, a biblioteca pode ser localizada em **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
    
        Para determinar a versão de bit do Java Runtime Environment para uma instalação do WebSphere Application Server ou do WebSphere Application Server Network Deployment independente, execute **versionInfo.bat** no Windows ou **versionInfo.sh** no UNIX a partir do diretório **bin**. O arquivo **versionInfo.sh** está em **/opt/IBM/WebSphere/AppServer/bin**. Examine o valor Architecture na seção **Produto instalado**. O Java Runtime Environment será de 64 bits se o valor Architecture mencioná-lo explicitamente ou se ele for sufixado com 64 ou _64.
    * Coloque a biblioteca nativa que corresponde à sua plataforma em uma pasta de seu sistema operacional. Por exemplo, **/opt/IBM/RCL_Native_Library/**.
    * Copie o arquivo **rcl_ibmratl.jar** para **/opt/IBM/RCL_Native_Library/**. O arquivo **rcl_ibmratl.jar** é uma biblioteca Java do Rational Common Licensing que pode ser localizada no **diretório product_install_dir/MobileFirstServer/tokenLibs**.
    
        > **Importante:** A Java virtual machine (JVM) do servidor de aplicativos precisa de privilégios de leitura e execução nas bibliotecas nativas e Java copiadas. Ambos os arquivos copiados também devem ser legíveis e executáveis pelo menos para o processo do servidor de aplicativos em seu sistema operacional.    
    * Declare uma biblioteca compartilhada no console administrativo do WebSphere Application Server.
        * Efetue login no console administrativo do WebSphere Application Server.
        * Expanda **Ambiente → Bibliotecas compartilhadas**.
        * Selecione um escopo que seja visível por todos os servidores que executam o serviço de administração do {{ site.data.keys.mf_server }}. Por exemplo, um cluster.
        * Clique em **Novo(a)**.
        * Insira um nome para a biblioteca no campo Nome. Por exemplo, "Biblioteca compartilhada RCL".
        * No campo Caminha da classe, insira o caminho para o arquivo **rcl_ibmratl.jar**. Por exemplo, **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * Clique em **OK** e salve as mudanças. Essa configuração entrará em vigor quando o servidor for reiniciado.
    
        > **Nota:** O caminho da biblioteca nativa para essa biblioteca está configurado na etapa 3 na propriedade **ld.library.path** da Java virtual machine do servidor.
    * Associe a biblioteca compartilhada a todos os servidores que executam o serviço de administração do {{ site.data.keys.mf_server }}.
    
        Associar a biblioteca compartilhada a um servidor permite que ela seja usada por vários aplicativos. Se você precisar do cliente Rational Common Licensing somente para o serviço de administração do {{ site.data.keys.mf_server }}, será possível criar uma biblioteca compartilhada com um carregador de classes isolado e associá-la ao aplicativo do serviço de administração.

        A instrução a seguir é associar a biblioteca a um servidor. Para o WebSphere Application Server Network Deployment, deve-se concluir essa instrução para todos os servidores que executam o serviço de administração do {{ site.data.keys.mf_server }}.    
        * Configure a política e o modo do carregador de classes.    
            1. No console administrativo do WebSphere Application Server, clique em **Servidores → Tipos de servidores → Servidores de aplicativos WebSphere → server_name** para acessar a página de configuração do servidor de aplicativos.
            2. Configure os valores para a política do carregador de classes do aplicativo e o modo de carregamento de classe do servidor:
                * **Política do carregador de classes**: múltipla
                * **Modo de carregamento de classes**: classes carregadas com o carregador de classes-pai primeiro
            3. Na seção **Infraestrutura do servidor**, clique em **Gerenciamento de Java e de processos → Carregador de classes**.
            4. Clique em **Novo** e assegure-se de que a ordem do carregador de classes esteja configurada como **Classes carregadas com o carregador de classes-pai primeiro**.
            5. Clique em **Aplicar** para criar um novo ID do carregador de classes.                
        * Crie uma referência de biblioteca para cada arquivo de biblioteca compartilhada que o aplicativo precisar.
            1. Clique no nome do carregador de classes que foi criado na etapa anterior.
            2. Na seção **Propriedades adicionais**, clique em **Referências de biblioteca compartilhada**.
            3. Clique em **Incluir (Add)**.
            4. Na página Configurações de referência de biblioteca, selecione a referência de biblioteca apropriada. O nome identifica o arquivo da biblioteca compartilhada que o aplicativo utiliza. Por exemplo, Biblioteca compartilhada RCL.
            5. Clique em **Aplicar** e, em seguida, salve as
mudanças.
2. Configure as entradas de ambiente para o aplicativo da web do serviço de administração do {{ site.data.keys.mf_server }}.
    * No console administrativo do WebSphere Application Server, clique em **Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere** e selecione o aplicativo do serviço de administração: **MobileFirst_Administration_Service**.
    * Na seção **Propriedades do módulo da web**, clique em **Entradas de ambiente para módulos da web**.
    * Insira os valores para **mfp.admin.license.key.server.host** e **mfp.admin.license.key.server.port**.
        * **mfp.admin.license.key.server.host** é o nome do host do Rational License Key Server.
        * **mfp.admin.license.key.server.port** é a porta do Rational License Key Server. Por padrão,
o valor é 27000.
    * Clique em **OK** e salve as alterações.
3. Configure o acesso à biblioteca do Rational Common Licensing pela JVM do servidor de aplicativos.
    * No console administrativo do WebSphere Application Server, clique em **Servidores → Tipos de servidores → WebSphere Application Servers** e selecione seu servidor.
    * Na seção **Infraestrutura do servidor**, clique em **Gerenciamento de Java e de processos → Definição de processo → Java Virtual Machine → Propriedades customizadas → Novo** para incluir uma propriedade customizada.
    * No campo **Nome**, digite o nome da propriedade customizada como **java.library.path**.
    * No campo **Valor**, insira o caminho da pasta em que você coloca o arquivo de biblioteca nativa na Etapa 1b. Por exemplo, **/opt/IBM/RCL_Native_Library/**.
    * Clique em **OK** e salve as alterações.
4. Reinicie o seu servidor de aplicativos.

### Instalando a biblioteca do Rational Common Licensing no WebSphere Application Server Network Deployment
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
Para instalar a biblioteca nativa em um WebSphere Application Server Network Deployment, deve-se seguir todas as etapas descritas em [Instalando a biblioteca do Rational Common Licensing em um servidor independente](#installing-rational-common-licensing-library-on-a-stand-alone-server) acima. Os servidores ou os clusters que você configurar deverão ser reiniciados para que as mudanças entrem em vigor.

Cada nó do WebSphere Application Server Network Deployment deve ter uma cópia da biblioteca nativa do Rational Common Licensing.

Cada servidor em que o serviço de administração do {{ site.data.keys.mf_server }} for executado deve ser configurado para ter acesso à biblioteca nativa copiada em seu computador local. Esses servidores também devem ser configurados para se conectarem ao Rational License Key Server.

> **Importante:** Se você usar um cluster com o WebSphere Application Server Network Deployment, seu cluster pode mudar. Deve-se configurar cada servidor recém-incluído em seu cluster, onde os serviços de administração estão em execução.

## Limitações de plataformas suportadas para licenciamento de token
{: #limitations-of-supported-platforms-for-token-licensing }
A lista de sistemas operacionais, sua versão e a arquitetura de hardware que suporta o {{ site.data.keys.mf_server }} com o licenciamento de token ativado.

Para licenciamento de token, o {{ site.data.keys.mf_server }} precisa se conectar ao Rational License Key Server usando a biblioteca do Rational Common Licensing.

Essa biblioteca é composta de uma biblioteca Java e também de bibliotecas nativas. Essas bibliotecas nativas dependem da plataforma em que o {{ site.data.keys.mf_server }} está sendo executado. Portanto, o licenciamento de token pelo {{ site.data.keys.mf_server }} é suportado somente em plataformas em que a biblioteca do Rational Common Licensing pode ser executada.

A tabela a seguir descreve as plataformas que suportam o {{ site.data.keys.mf_server }} com o licenciamento de token.

| Sistema Operacional             | Versão do sistema operacional |	Arquitetura de Hardware |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8  (somente 64 bits) |
| SUSE Linux Enterprise Server | 11	                      | Somente x86-64           |
| Windows Server               | 2012	                  | Somente x86-64           |

O licenciamento de token não suporta o Java Runtime Environment (JRE) de 32 bits. Certifique-se de que o servidor de aplicativos use um JRE de 64 bits.

## Resolução de problemas de licenciamento de token
{: #troubleshooting-token-licensing-problems }
Localize informações para ajudar a resolver problemas que podem ser encontrados com o licenciamento de token se você tiver ativado esse recurso quando instalou o {{ site.data.keys.mf_server }}.

Quando iniciar o serviço de administração do {{ site.data.keys.mf_server }} depois de concluir Instalando e configurando para licenciamento de token, alguns erros ou exceções podem ser emitidos no log do servidor de aplicativos ou no {{ site.data.keys.mf_console }}. Essas exceções podem ser devido à instalação incorreta da biblioteca do Rational Common Licensing e à configuração do servidor de aplicativos.

**Apache Tomcat **  
Verifique o arquivo **catalina.log** ou catalina.out, dependendo de sua plataforma.

**Perfil Liberty do WebSphere® Application Server**  
Verifique o arquivo **messages.log**.

**WebSphere Application Server Full Profile**  
Verifique o arquivo **SystemOut.log**.

> **Importante:** Se o licenciamento de token for instalado no WebSphere Application Server Network Deployment ou em um cluster, deve-se verificar o log de cada servidor.

Aqui está uma lista de exceções que podem ocorrer após a instalação e configuração para o licenciamento de token:

* [A biblioteca nativa do Rational Common Licensing não foi localizada](#rational-common-licensing-native-library-is-not-found)
* [A biblioteca compartilhada do Rational Common Licensing não foi localizada](#rational-common-licensing-shared-library-is-not-found)
* [A conexão do Rational License Key Server não está configurada](#the-rational-license-key-server-connection-is-not-configured)
* [O Rational License Key Server não está acessível](#the-rational-license-key-server-is-not-accessible)
* [Falha ao inicializar a API do Rational Common Licensing](#failed-to-initialize-rational-common-licensing-api)
* [Licenças de token insuficientes](#insufficient-token-licenses)
* [Arquivo rcl_ibmratl.jar inválido](#invalid-rcl_ibmratljar-file)

### A biblioteca nativa do Rational Common Licensing não foi localizada
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: a biblioteca nativa Rational Common Licensing não foi localizada. Certifique-se de que a propriedade JVM (java.library.path) está definida com o caminho correto e a biblioteca nativa possa ser executada. Reinicie o {{ site.data.keys.mf_server }} depois de executar a ação corretiva.

#### Para o perfil completo do WebSphere Application Server
{: #for-websphere-application-server-full-profile }
As possíveis causas para esse erro podem ser:

* Nenhuma propriedade comum com o nome **java.library.path** está definida no nível do servidor.
* O caminho fornecido como o valor para a propriedade **java.library.path** não contém a biblioteca nativa do Rational Common Licensing.
* A biblioteca nativa não possui permissões apropriadas. A biblioteca deve ter os privilégios de leitura e execução no UNIX e no Windows para o usuário que acessá-la com o Java™ Runtime
* Environment do servidor de aplicativos.

#### Para o perfil Liberty do WebSphere Application Server e o Apache Tomcat
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
As possíveis causas para esse erro podem ser:

* O caminho para a biblioteca nativa do Rational Common Licensing fornecido como o valor da propriedade java.library.path não está configurado ou está incorreto.
    * Para o perfil Liberty, verifique o arquivo **${wlp.user.dir}/servers/server_name/jvm.options**.
    * Para o Apache Tomcat, verifique o arquivo **${CATALINA_HOME}/bin/setenv.bat** ou o arquivo setenv.sh, dependendo de sua plataforma.
* A biblioteca nativa não foi localizada no caminho definido para a propriedade **java.library.path**. Verifique se a biblioteca nativa existe no caminho definido com o nome esperado.
* A biblioteca nativa não possui permissões apropriadas. O erro pode ser precedido por essa exceção: `com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: o acesso é negado`.

O Java Runtime Environment do servidor de aplicativos precisa de privilégios de leitura e execução nessa biblioteca nativa. O arquivo de biblioteca também deve ser legível e executável pelo menos para o processo do servidor de aplicativos em seu sistema operacional.

* A biblioteca compartilhada que usa o arquivo **rcl_ibmratl.jar** não está definida no arquivo **${server.config.dir}/server.xml** para o perfil Liberty. O **rcl_ibmratl.jar** também pode não estar no diretório correto ou o diretório não tem as permissões apropriadas.
* A biblioteca compartilhada que usou o arquivo **rcl_ibmratl.jar** não está declarada como uma biblioteca comum para o aplicativo de serviço de administração do {{ site.data.keys.mf_server }} no arquivo **${server.config.dir}/server.xml** para o perfil Liberty.
* Há uma combinação de objetos de 32 bits e de 64 bits entre o Java Runtime Environment do servidor de aplicativos e a biblioteca nativa. Por exemplo, um Java Runtime Environment de 32 bits é usado com uma biblioteca nativa de 64 bits. Essa combinação não é suportada.

### A biblioteca compartilhada do Rational Common Licensing não foi localizada
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: a biblioteca compartilhada Rational Common Licensing não foi localizada. Certifique-se de que a biblioteca compartilhada está configurada. Reinicie o {{ site.data.keys.mf_server }} depois de executar a ação corretiva.

As possíveis causas para esse erro podem ser:

* O arquivo **rcl_ibmratl.jar** não está no diretório esperado.
    * Para o Apache Tomcat, verifique se esse arquivo está no diretório **${CATALINA_HOME}/lib**.
    * Para o perfil Liberty do WebSphere Application Server, verifique se esse arquivo está no diretório conforme definido no arquivo server.xml para a biblioteca compartilhada do cliente Rational Common Licensing. Por exemplo, **${shared.resource.dir}/rcllib**. No arquivo **server.xml**, assegure-se de que essa biblioteca compartilhada esteja corretamente referenciada como uma biblioteca comum para o aplicativo de serviço de administração do {{ site.data.keys.mf_server }}.
    * Para o WebSphere Application Server, certifique-se de que esse arquivo esteja no diretório especificado no caminho da classe da biblioteca compartilhada do WebSphere Application Server. Verifique se o caminho da classe dessa biblioteca compartilhada contém essa entrada: **absolute\_path/rcl\_ibmratl.jar**, em que absolute_path é o caminho absoluto do arquivo **rcl_ibmratl.jar**.

A propriedade **java.library.path** não está configurada
para o servidor de aplicativos. Defina uma propriedade com o nome **java.library.path** e configure o caminho para a biblioteca nativa do Rational Common Licensing como o valor. Por exemplo, **/opt/IBM/RCL\_Native\_Library/**.
* A biblioteca nativa não possui as permissões esperadas. No Windows, o Java Runtime Environment do servidor de aplicativos deve ter os direitos de leitura e executáveis na biblioteca nativa.
* Há uma combinação de objetos de 32 bits e de 64 bits entre o Java Runtime Environment do servidor de aplicativos e a biblioteca nativa. Por exemplo, um Java Runtime Environment de 32 bits é usado com uma biblioteca nativa de 64 bits. Essa combinação não é suportada.

### A conexão do Rational License Key Server não está configurada
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: a conexão Rational License Key Server não foi configurada. Certifique-se de que as propriedades JNDI do administrador "mfp.admin.license.key.server.host" e "mfp.admin.license.key.server.port" estejam configuradas. Reinicie o {{ site.data.keys.mf_server }} depois de executar a ação corretiva.

As possíveis causas para esse erro podem ser:

* A biblioteca nativa e a biblioteca compartilhada do Rational Common Licensing que usam o arquivo **rcl_ibmratl.jar** estão configuradas corretamente, mas o valor das propriedades JNDI (**mfp.admin.license.key.server.host** e **mfp.admin.license.key.server.port**) não está configurado no aplicativo do serviço de administração do {{ site.data.keys.mf_server }}.
* O Rational License Key Server está inativo.
* O computador host no qual o Rational License Key Server está instalado não pode ser acessado. Verifique o endereço IP ou
o nome do host com a porta especificada.

### O Rational License Key Server não está acessível
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: o Rational License Key Server "{port}@{IP address or hostname}" não está acessível. Certifique-se de que o servidor de licença esteja em execução e acessível ao {{ site.data.keys.mf_server }}. Se esse erro ocorrer na inicialização do tempo de execução, reinicie o {{ site.data.keys.mf_server }} depois de executar a ação corretiva.

As possíveis causas para esse erro podem ser:

* A biblioteca compartilhada e a biblioteca nativa do Rational Common Licensing estão definidas corretamente, mas não há nenhuma configuração válida para se conectar ao Rational License Key Server. Verifique o endereço IP, o nome do host e a porta do servidor de licença. Certifique-se de que o servidor de licença tenha sido iniciado e esteja acessível a partir do computador em que o servidor de aplicativos está instalado.
* A biblioteca nativa não foi localizada no caminho definido para a propriedade **java.library.path**.
* A biblioteca nativa não possui permissões apropriadas.
* A biblioteca nativa não está no diretório definido.
* O Rational License Key Server está protegido por um firewall. O erro pode ser precedido por essa exceção: [ERRO] Falha ao obter a licença para o aplicativo 'WorklightStarter' porque o Rational Licence Key Server ({port}@{IP address or hostname}) está inativo ou não acessível com.ibm.rcl.ibmratl.LicenseServerUnreachableException. Procura de recursos em todos os arquivos de licença: {port}@{IP address or hostname}

Certifique-se de que a porta do daemon de gerenciador de licença (lmgrd) e a porta do daemon de fornecedor (ibmratl) estejam abertas em seu firewall. Para obter informações adicionais, consulte Como entregar uma chave de licença para máquinas clientes através de um firewall.

### Falha ao inicializar a API do Rational Common Licensing
{: #failed-to-initialize-rational-common-licensing-api }

> Falha ao inicializar a API do Rational Common Licensing (RCL), porque sua biblioteca nativa não pôde ser localizada ou carregada com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Não localizada em java.library.path)

As possíveis causas para esse erro podem ser:

* A biblioteca nativa do Rational Common Licensing não foi localizada no caminho definido para a propriedade **java.library.path**. Verifique se a biblioteca nativa existe no caminho definido com o nome esperado.
* A propriedade **java.library.path** não está configurada
para o servidor de aplicativos. Defina uma propriedade com o nome **java.library.path** e configure o caminho para a biblioteca nativa do Rational Common Licensing como o valor. Por exemplo, **/opt/IBM/RCL_Native_Library/**.
* Há uma combinação de objetos de 32 bits e de 64 bits entre o Java Runtime Environment do servidor de aplicativos e a biblioteca nativa. Por exemplo, um Java Runtime Environment de 32 bits é usado com uma biblioteca nativa de 64 bits. Essa combinação não é suportada.

### Licenças de token insuficientes
{: #insufficient-token-licenses }

> FWLSE3129E: licenças de token insuficientes para o recurso "{0}".

Esse erro ocorre quando o número restante de licenças de token no Rational License Key Server não é suficiente para implementar um novo aplicativo {{ site.data.keys.product_adj }}.

### Arquivo rcl_ibmratl.jar inválido
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: a biblioteca compartilhada Biblioteca Compartilhada RCL contém uma entrada de caminho de classe que não é resolvida para um arquivo jar válido, o arquivo jar da biblioteca deve ser localizado em {0}/rcl_ibmratl.jar.

**Nota:** Somente para WebSphere Application Server e WebSphere Application Server Network Deployment

As possíveis causas para esse erro podem ser:

* A biblioteca Java **rcl_ibmratl.jar** não tem as permissões apropriadas. O erro pode ser seguido por outra exceção: java.util.zip.ZipException: erro ao abrir o arquivo zip. Verifique se o arquivo **rcl_ibmratl.jar** tem a permissão de leitura para o usuário que instala o WebSphere Application Server.
* Se não houver outra exceção, o arquivo **rcl_ibmratl.jar** referenciado no caminho de classe da biblioteca compartilhada pode ser inválido ou não existir. Verifique se o arquivo **rcl_ibmratl.jar** é válido ou se existe no caminho definido.


