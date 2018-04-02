---
layout: tutorial
title: Tutorial de instalação do servidor MobileFirst a partir da linha de comandos
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Use o modo de linha de comando do IBM Installation Manager e tarefas Ant para instalar o {{ site.data.keys.mf_server }}.

#### Antes de Começar
{: #before-you-begin }
* Certifique-se de que um dos bancos de dados a seguir e uma versão Java suportada estejam instaladas. Você também precisa do driver JDBC correspondente para o banco de dados ficar disponível no computador:
    * Sistema de Gerenciamento de Banco de Dados (DBMS) da lista de bancos de dados suportados:
        * DB2 
        * MySQL
        * Oracle

        > **Importante:** É preciso ter um banco de dados em que possam ser criadas as tabelas que são necessárias para o produto, e um usuário do banco de dados que possa criar tabelas nesse banco de dados.

        No tutorial, as etapas para criar as tabelas são para DB2. É possível localizar o instalador do DB2 como um pacote do {{ site.data.keys.product }} eAssembly no IBM Passport Advantage.

* Driver JDBC para seu banco de dados.
    * Para DB2, use o driver JDBC tipo 4.
    * Para MySQL, use o driver JDBC Connector/J.
    * Para Oracle, use o driver JDBC Oracle thin JDBC.
* Java 7 ou posterior.

* Faça download do instalador do IBM Installation Manager V1.8.4 ou a partir dos [links de download do Installation Manager e Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).
* Também é preciso ter o repositório de instalação do {{ site.data.keys.mf_server }} e o instalador do WebSphere Application Server Liberty Core V8.5.5.3 ou mais recente. Faça download desses pacotes a partir do {{ site.data.keys.product }} eAssembly no Passport Advantage:

**Repositório de instalação do {{ site.data.keys.mf_server }}**  
Arquivo .zip do {{ site.data.keys.product }} V8.0 do Installation Manager Repository para {{ site.data.keys.mf_server }}

**perfil Liberty do WebSphere Application Server**  
IBM WebSphere Application Server - Liberty Core V8.5.5.3 ou posterior
    
#### Ir para
{: #jump-to }
* [Instalando o IBM Installation Manager](#installing-ibm-installation-manager)
* [Instalando o WebSphere Application Server Liberty Core](#installing-websphere-application-server-liberty-core)
* [Instalando o {{ site.data.keys.mf_server }}](#installing-mobilefirst-server)
* [
Criando um banco de dados](#creating-a-database)
* [Implementando o {{ site.data.keys.mf_server }} no Liberty com tarefas Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)
* [Testando a Instalação](#testing-the-installation)
* [Criando um farm de dois servidores Liberty que executam o {{ site.data.keys.mf_server }}](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [Testando o farm e vendo as mudanças no {{ site.data.keys.mf_console }}](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

## Instalando o IBM Installation Manager
{: #installing-ibm-installation-manager }
Deve-se instalar o Installation Manager V1.8.4 ou posterior. As versões mais antigas do Installation Manager não são capazes de instalar o {{ site.data.keys.product }} V8.0 porque operações pós-instalação do produto requerem Java 7. As versões mais antigas do Installation Manager vêm com Java 6.

1. Extraia o archive do IBM Installation Manager que é transferido por download. É possível localizar o instalador em [Links de download do Installation Manager e Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).
2. Revise o contrato de licença para o IBM Installation Manager que está no diretório **unzip\_IM\_1.8.x/license**.
3. Se você aceitar o contrato de licença após a revisão, instale o Installation Manager.  
    * Execute **installc.exe** para instalar o Installation Manager como administrador. A raiz é necessária no Linux ou UNIX. No Windows, o privilégio de administrador é necessário. Nesse modo, as informações sobre os pacotes instalados são colocadas em um local compartilhado no disco, e qualquer usuário com permissão para executar o Installation Manager pode atualizar os aplicativos. O nome do arquivo executável termina com "c" (**installc**) para uma instalação da linha de comandos sem uma interface gráfica com o usuário. Para instalar o Installation Manager, insira **installc.exe -acceptLicence**.
    * Execute **userinstc.exe** para instalar o Installation Manager no modo de usuário. Nenhum privilégio específico é necessário. No entanto, nesse modo, as informações sobre os pacotes instalados são colocadas no diretório inicial do usuário. Somente o usuário pode atualizar o aplicativo que é instalado com o Installation Manager. O executável termina com "c" (**userinstc**) para uma instalação da linha de comandos sem uma interface gráfica com o usuário. Para instalar o Installation Manager, insira **userinstc.exe -acceptLicence**.
    
## Instalando o WebSphere Application Server Liberty Core
{: #installing-websphere-application-server-liberty-core }
O instalador do WebSphere Application Server Liberty Core é fornecido como parte do pacote para o {{ site.data.keys.product }}. Nesta tarefa, o perfil Liberty é instalado e uma instância de servidor é criada, de modo que seja possível instalar o {{ site.data.keys.mf_server }} nele.

1. Revise o contrato de licença para o WebSphere Application Server Liberty Core. Os arquivos de licença podem ser visualizados quando se faz download do instalador a partir do Passport Advantage.
2. Extraia o arquivo compactado do WebSphere Application Server Liberty Core, que foi transferido por download, em uma pasta.

    Nas etapas seguintes, o diretório onde o instalador será extraído é referido como **liberty\_repository\_dir**. Ele contém um arquivo **repository.config** ou um arquivo **diskTag.inf** entre vários outros.

3. Decida um diretório no qual o perfil Liberty deve ser instalado. É referido como liberty_install_dir nas próximas etapas.
4. Inicie uma linha de comandos e acesse **installation\_manager\_install\_dir/tools/eclipse/**.
5. Se você aceitar o contrato de licença após a revisão, instale o Liberty.
    
    Insira o comando: **imcl install com.ibm.websphere.liberty.v85 -repositories liberty\_repository\_dir -installationDirectory liberty\_install\_dir -acceptLicense**

    Esse comando instala o Liberty no diretório **liberty\_install\_dir**. A opção **-acceptLicense** significa que você aceita os termos de licença do produto.

6. Mova o diretório que contém os servidores para um local que não precise de privilégios específicos.

    Para o escopo desse tutorial, se **liberty\_install\_dir** apontar para um local onde usuários não administradores ou não raiz não podem modificar os arquivos, mova o diretório que contém os servidores para um local que não precisa de privilégios específicos. Dessa forma, as operações de instalação podem ser feitas sem privilégios específicos.
    * Acesse o diretório de instalação do Liberty.
    * Crie um diretório chamado etc. São necessários privilégios de administrador.
    * No diretório **etc**, crie um arquivo **server.env** com o seguinte conteúdo: `WLP_USER_DIR=<path to a directory where any user can write>`. Por exemplo, no Windows: `WLP_USER_DIR=C:\LibertyServers\usr`.
7.  Crie um servidor Liberty que será usado para instalar o primeiro nó do {{ site.data.keys.mf_server }} na parte posterior do tutorial.
    * Inicie uma linha de comandos.
    * Acesse **liberty\_install\_dir/bin** e insira **server create mfp1**.
    
    Este comando chama uma instância de servidor Liberty chamada **mfp1**. É possível ver sua definição em **liberty\_install\_dir/usr/servers/mfp1** ou **WLP\_USER\_DIR/servers/mfp1** (se você modificar o diretório conforme descrito na etapa 6).
    
Após a criação do servidor, é possível iniciar esse servidor com `server start mfp1` a partir de **liberty\_install\_dir/bin/**.  
Para parar o servidor, insira o comando: `server stop mfp1` de **liberty\_install\_dir/bin/**.

A página inicial padrão pode ser visualizada em [http://localhost:9080](http://localhost:9080).

> **Nota:** Para produção, é preciso assegurar que o servidor Liberty seja iniciado como um serviço quando o computador host for iniciado. Fazer o servidor Liberty iniciar como um serviço não é parte deste tutorial.<

## Instalando o {{ site.data.keys.mf_server }}
{: #installing-mobilefirst-server }
Certifique-se de que o Installation Manager V1.8.4 ou posterior esteja instalado. A instalação do
{{ site.data.keys.mf_server }} pode não ser bem-sucedida com uma versão mais antiga do Installation Manager, pois as operações pós-instalação requerem Java 7. As versões mais antigas do Installation Manager vêm com Java 6.

Execute o Installation Manager para instalar os arquivos binários
do {{ site.data.keys.mf_server }} no
seu disco antes de criar os bancos de dados e implementar o {{ site.data.keys.mf_server }}
no perfil do Liberty. Durante a instalação do {{ site.data.keys.mf_server }} com o
Installation Manager, é proposta uma opção para você instalar o {{ site.data.keys.mf_app_center }}. O Application Center é um componente diferente do produto. Para este tutorial, ele não precisa ser instalado com
{{ site.data.keys.mf_server }}.

Também é necessário especificar uma propriedade para indicar se é necessário ou não ativar o licenciamento de token. Neste tutorial, supõe-se que um licenciamento de token não seja necessário e que as etapas para configurar o
{{ site.data.keys.mf_server }} para licenciamento de token não estejam incluídas. Entretanto, para instalação de produção, deve-se determinar se é necessário ou não ativar o licenciamento de token. Se você não tiver um contrato para usar o licenciamento de token com o Rational License Key Server, não precisará ativar o licenciamento de token. Se você ativar o licenciamento de token, deve-se configurar o {{ site.data.keys.mf_server }} para licenciamento de token. 

Neste tutorial, você especifica as propriedades como parâmetros por meio da linha de comandos **imcl**. Essa especificação também pode ser feita usando um arquivo de resposta.

1. Revise o contrato de licença para {{ site.data.keys.mf_server }}. Os arquivos de licença podem ser visualizados quando você fizer download do repositório de instalação a partir do Passport Advantage.
2. Extraia o arquivo compactado do instalador do {{ site.data.keys.mf_server }}, que você transferiu por download, em uma pasta.

    Nas etapas a seguir, o diretório onde é extraído o instalador é referido como **mfp\_repository\_dir**. Ele contém uma pasta **MobileFirst\_Platform\_Server/disk1**.
3. Inicie uma linha de comandos e acesse **installation\_manager\_install\_dir/tools/eclipse/**.
4. Se você aceitar o contrato de licença após a revisão na etapa 1, instale o {{ site.data.keys.mf_server }}.

    Insira o comando: `imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense`

    As propriedades a seguir são definidas para se ter uma instalação sem Application Center:
    * **user.appserver.selection2=none**
    * **user.database.selection2=none**
    * **user.database.preinstalled=false**

    Essa propriedade indica que o licenciamento de token não está ativado: **user.licensed.by.tokens=false**.  
    Configure o valor da propriedade **user.use.ios.edition** como false para instalar o {{ site.data.keys.product }}.

Um diretório de instalação contendo os recursos para instalação dos componentes do {{ site.data.keys.product_adj }} está instalado.  
É possível localizar os recursos nas pastas a seguir:

* Pasta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Pasta **PushService** para serviço de push do {{ site.data.keys.mf_server }}
* Pasta **ApplicationCenter** para Application Center
* Pasta **Analytics** para {{ site.data.keys.mf_analytics }}

O objetivo deste tutorial é instalar {{ site.data.keys.mf_server }} usando os recursos na pasta **MobileFirstServer**.  
Também é possível localizar alguns atalhos para o Server Configuration Tool, Ant e o programa **mfpadm** na pasta **shortcuts**.

## Criando um Banco de Dados
{: #creating-a-database }
Essa tarefa é para assegurar que exista um banco de dados em seu DBMS e que um usuário tenha permissão para usar o banco de dados, criar tabelas nele e usar as tabelas. É possível ignorar essa tarefa se você pretende usar banco de dados Derby.

O banco de dados é usado para armazenar os dados técnicos que são usados pelos vários componentes do {{ site.data.keys.product_adj }}:

* Serviço de Administração do {{ site.data.keys.mf_server }}
* Serviço de atualização em tempo real do {{ site.data.keys.mf_server }}
* serviço de push do {{ site.data.keys.mf_server }}
* Tempo de execução
{{ site.data.keys.product_adj }}

Neste tutorial, as tabelas para todos os componentes são colocadas sob o mesmo esquema.  
**Nota:** As etapas nesta tarefa são para DB2. Se você planeja usar MySQL ou Oracle, consulte [Requisitos do banco de dados](../../../prod-env/databases/#database-requirements).

1. Efetue logon no computador que está executando o servidor DB2. Supõe-se que um usuário do DB2, por exemplo, um usuário chamado **mfpuser**, exista.
2. Verifique se o usuário do DB2 tem acesso a um banco de dados com tamanho de página de 32768 ou mais e tem permissão para criar tabelas e esquemas implícitos nesse banco de dados.

    Por padrão, esse usuário é um usuário declarado no sistema operacional do computador que executa o DB2. Ou seja, um usuário com um login para esse computador. Se tal usuário existir, a próxima ação na etapa 3 não será necessária.
3. Crie um banco de dados com o tamanho da página correto para essa instalação, caso ainda não tenha feito isso.
    * Abra uma sessão com um usuário que tenha permissões **SYSADM** ou **SYSCTRL**. Por exemplo, use o usuário **db2inst1** que é o usuário administrativo padrão criado pelo instalador do DB2.
    * Abra um processador de linha de comandos do DB2:
        * Em sistemas Windows, clique em **Iniciar → IBM DB2 → Processador de Linha de Comandos**.
        * Em sistemas Linux ou UNIX, acesse **~/sqllib/bin** (ou **db2\_install\_dir/bin** se sqllib não for criado no diretório inicial do administrador) e insira `./db2`.
    * Insira as instruções SQL a seguir para criar um banco de dados chamado **MFPDATA**:
    
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

    Se você definiu um nome do usuário diferente, substitua **mfpuser** por seu próprio nome do usuário.
    
    > **Nota:** A instrução não remove os privilégios padrão concedidos a PUBLIC em um banco de dados DB2 padrão. Para produção, você pode precisar reduzir os privilégios nesse banco de dados para o requisito mínimo do produto. Para obter mais informações sobre a segurança do DB2 e obter um exemplo das práticas de segurança, consulte [Segurança do DB2. Parte 8: doze melhores práticas de segurança do DB2](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/).

## Implementando o {{ site.data.keys.mf_server }} no Liberty com tarefas Ant
{: #deploying-mobilefirst-server-to-liberty-with-ant-tasks }
Você usa as tarefas Ant para executar as operações a seguir:

* Crie as tabelas no banco de dados que são necessárias para os aplicativos {{ site.data.keys.product_adj }}
* Implemente os aplicativos da web do {{ site.data.keys.mf_server }} (componentes de tempo de execução, serviço de administração, serviço de atualização em tempo real, serviço de push e {{ site.data.keys.mf_console }}) para o servidor Liberty.

Os aplicativos {{ site.data.keys.product_adj }} a seguir não são implementados por tarefas Ant:

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} normalmente é implementado em um conjunto de servidores diferente do {{ site.data.keys.mf_server }} devido aos seus requisitos de alta memória. {{ site.data.keys.mf_analytics }} pode ser instalado manualmente ou com tarefas Ant. Se ele já estiver instalado, será possível inserir sua URL, o nome do usuário e a senha para enviar dados para ele no Server Configuration Tool. O Server Configuration Tool configura então os aplicativos do {{ site.data.keys.product_adj }} para enviar dados para o {{ site.data.keys.mf_analytics }}. 

#### Application Center
{: #application-center }
Esse aplicativo pode ser usado para distribuir aplicativos móveis internamente para os funcionários que usam os aplicativos ou para propósitos de teste. Ele é independente do {{ site.data.keys.mf_server }} e não é necessário instalá-lo junto com o {{ site.data.keys.mf_server }}. 

Selecione o arquivo XML apropriado que contém as tarefas Ant e configure as propriedades.

* Faça uma cópia do arquivo **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-db2.xml** para um diretório ativo. Esse arquivo contém as tarefas Ant para instalar o {{ site.data.keys.mf_server }} no Liberty com o DB2 como banco de dados. Antes de usá-lo, defina as propriedades para descrever onde os aplicativos do
{{ site.data.keys.mf_server }} devem ser implementados.
* Edite a cópia do arquivo XML e configure os valores das propriedades a seguir:
    * **mfp.admin.contextroot** para **/mfpadmin**
    * **mfp.runtime.contextroot** como **/mfp**
    * **database.db2.host** para o valor para o nome do host do computador que executa seu banco de dados DB2. Se o banco de dados estiver no mesmo computador que o Liberty, use **localhost**.
    * **database.db2.port** para a porta para a qual a instância do DB2 está atendendo. Por padrão, ele é **50000**.
    * **database.db2.driver.dir** para o diretório que contém o driver DB2: **db2jcc4.jar** e **db2jcc\_license\_cu.jar**. Em uma distribuição padrão do DB2, esses arquivos são localizados em **db2\_install\_dir/java**.
    * **database.db2.mfp.dbname** para **MFPDATA** - o nome do banco de dados criado em Criando um banco de dados.
    * **database.db2.mfp.schema** para **MFPDATA** - o valor do esquema no qual as tabelas para {{ site.data.keys.mf_server }} devem ser criadas. Se seu usuário do DB não puder criar um esquema, configure o valor para uma sequência vazia. Por exemplo, **database.db2.mfp.schema=""**.
    * **database.db2.mfp.username** para o usuário do DB2 que cria as tabelas. Esse usuário também usa as tabelas no tempo de execução. Para este tutorial, use **mfpuser**.
    * **appserver.was.installdir** para o diretório de instalação do Liberty.
    * **appserver.was85liberty.serverInstance** como **mfp1** - o valor para o nome do servidor Liberty no qual o {{ site.data.keys.mf_server }} deve ser instalado.
    * **mfp.farm.configure** para **false** para instalar o {{ site.data.keys.mf_server }} no modo independente.
    * **mfp.analytics.configure** para **false**. A conexão com o {{ site.data.keys.mf_analytics }} não está no escopo deste tutorial. É possível ignorar as outras propriedades mfp.analytics.****.
    * **mfp.admin.client.id** para **admin-client-id**.
    * **mfp.admin.client.secret** como **adminSecret** (ou escolha outra senha secreta).
    * **mfp.push.client.id** para **push-client-id**.
    * **mfp.push.client.secret** para **pushSecret** (ou escolha outra senha secreta).
    * **mfp.config.admin.user** para o nome do usuário do serviço de atualização em tempo real do {{ site.data.keys.mf_server }}. Em uma topologia de server farm, o nome do usuário deve ser o mesmo para todos os membros do farm.
    * **mfp.config.admin.password** para a senha do serviço de atualização em tempo real do {{ site.data.keys.mf_server }}. Em uma topologia de server farm, a senha deve ser a mesma para todos os membros do farm.
* Mantenha os valores padrão das propriedades a seguir no estado em que eles se encontram:
    * **mfp.admin.console.install** como true
    * **mfp.admin.default.user** para **admin** - o nome de um usuário padrão criado para efetuar login no {{ site.data.keys.mf_console }}.
    * **mfp.admin.default.user.initialpassword** como **admin** - a senha de um usuário padrão criado para efetuar login no console administrativo.
    * **appserver.was.profile** para **Liberty**. Se o valor for diferente, a tarefa Ant considerará que a instalação está em um servidor WebSphere Application Server.
* Salve o arquivo após as propriedades serem definidas.
* Execute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml` para mostrar uma lista de possíveis destinos para o arquivo Ant.
* Execute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml databases` para criar as tabelas de banco de dados.
* Execute `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml install` para instalar o {{ site.data.keys.mf_server }}.

> **Nota:** Se você não tiver o DB2, e desejar testar a instalação com um Derby integrado como um banco de dados, use o arquivo **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-derby.xml**. No entanto, não é possível executar a última etapa desse tutorial (Criando um farm de dois servidores Liberty que executam o {{ site.data.keys.mf_server }}) porque o banco de dados Derby não pode ser acessado por vários servidores Liberty. Deve-se configurar as propriedades, exceto as relacionadas ao DB2 (**database.db2**, ...). Para o Derby, configure o valor da propriedade **database.derby.datadir** para o diretório onde o banco de dados Derby pode ser criado. Além disso, configure o valor da propriedade **database.derby.mfp.dbname** para **MFPDATA**.

As operações a seguir são executadas pelas tarefas Ant:

1. As tabelas para os componentes a seguir são criadas no banco de dados:
    * O serviço de administração e o serviço de atualização em tempo real. Criados pelo destino Ant `admdatabases`.
    * O componente de tempo de execução. Criado pelo destino Ant `rtmdatabases`.
    * O serviço de push. Criado pelo destino Ant `pushdatabases`.
2. Os arquivos WAR dos vários componentes são implementados no servidor Liberty. É possível ver os detalhes das operações no log sob os destinos `adminstall`, `rtminstall` e `pushinstall`.

Se você tiver acesso ao servidor DB2, é possível listar as tabelas que são criadas usando estas instruções:

1. Abra um processador de linha de comandos do DB2 com mfpuser, conforme descrito na etapa 3 de Criando um banco de dados.
2. Insira as instruções SQL:

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

Anote os seguintes fatores de banco de dados:

#### Consideração sobre usuário do banco de dados
{: #database-user-consideration }
No Server Configuration Tool, somente um usuário do banco de dados é necessário. Esse usuário é usado para criar as tabelas, mas também é usado como usuário da origem de dados no servidor de aplicativos no tempo de execução. No ambiente de produção, talvez você queira restringir os privilégios do usuário que é usado no tempo de execução ao mínimo estrito (`SELECT / INSERT / DELETE / UPDATE)`, e assim, fornecer um usuário diferente para implementação no servidor de aplicativos. Os arquivos Ant fornecidos como exemplos também usam os mesmos usuários para ambos os casos. No entanto, no caso do DB2, talvez você queira criar suas próprias versões de arquivos. Desse modo, é possível distinguir o usuário usado para criar os bancos de dados do usuário usado para a origem de dados no servidor de aplicativos com tarefas Ant.

#### Criação de tabelas de banco de dados
{: #database-tables-creation }
Para produção, talvez você queira criar as tabelas manualmente. Por exemplo, se seu administrador de banco de dados desejar substituir algumas configurações padrão ou designar espaços de tabela específicos. Os scripts do banco de dados que são usados para criar as tabelas estão disponíveis em **mfp\_server\_install\_dir/MobileFirstServer/databases** e **mfp\_server\_install\_dir/PushService/databases**. Para obter informações adicionais, consulte [Criando as tabelas de banco de dados manualmente](../../../prod-env/databases/#create-the-database-tables-manually).

O arquivo **server.xml** e algumas configurações do servidor de aplicativos são modificados durante a instalação. Antes de cada modificação, uma cópia do arquivo **server.xml** é feita, como **server.xml.bak**, **server.xml.bak1** e **server.xml.bak2**. Para ver tudo o que foi incluído, é possível comparar o arquivo **server.xml** com o backup mais antigo (server.xml.bak). No Linux, é possível usar o comando diff `--strip-trailing-cr server.xml server.xml.bak` para ver as diferenças. No AIX, use o comando `diff server.xml server.xml.bak` para localizar as diferenças.

#### Modificação das configurações do servidor de aplicativos (específico para o Liberty):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Os recursos do Liberty estão incluídos.

    Os recursos são incluídos para cada aplicativo e podem ser duplicados. Por exemplo, o recurso JDBC é usado para o serviço de administração e os componentes de tempo de execução. Essa duplicação permite a remoção dos recursos de um aplicativo quando ele é desinstalado sem dividir os outros aplicativos. Por exemplo, se você decidir, em algum ponto, desinstalar o serviço de push de um servidor e instalá-lo em outro servidor. No entanto, nem todas as topologias são possíveis. O serviço de administração, o serviço de atualização em tempo real e o componente de tempo de execução devem estar no mesmo servidor de aplicativos com o perfil Liberty. Para obter informações adicionais, consulte [Restrições no serviço de administração do {{ site.data.keys.mf_server }}, no serviço de atualização em tempo real do {{ site.data.keys.mf_server }} e no tempo de execução do {{ site.data.keys.product_adj }}](../../../prod-env/topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime). A duplicação de recursos não cria problema, a menos que os recursos incluídos estejam em conflito. A inclusão dos recursos jdbc-40 e jdbc-41 causa um problema, mas incluir duas vezes o mesmo recurso não.
    
2. `host='*'` é incluído na declaração `httpEndPoint`.

    Essa configuração deve permitir a conexão com o servidor a partir de todas as interfaces de rede. Na produção, talvez você queira restringir o valor do host do terminal HTTP.
3. O elemento **tcpOptions** (**tcpOptions soReuseAddr="true"**) é incluído na configuração do servidor para permitir a religação imediata com uma porta sem listener ativo e melhorar o rendimento do servidor.
4. Um keystore com ID **defaultKeyStore** será criado se ainda não existir.

    O keystore serve para ativar a porta HTTPS, e mais especificamente, para ativar a comunicação JMX entre o serviço de administração (mfp-admin-service.war) e o componente de tempo de execução (mfp-server.war). Os dois aplicativos se comunicam via JMX. No caso do perfil Liberty, restConnector é usado para se comunicar entre os aplicativos em um único servidor e também entre os servidores de um Liberty Farm. Isso requer o uso de HTTPS. Para o keystore criado por padrão, perfis Liberty criam um certificado com um período de validade de 365 dias. Essa configuração não deve ser usada para produção. Para produção, é necessário reconsiderar o uso de seu próprio certificado.    

    Para ativar o JMX, um usuário com função de administrador (chamado MfpRESTUser) é criado no registro básico. Seu nome e senha são fornecidos como propriedades JNDI (mfp.admin.jmx.user e mfp.admin.jmx.pwd) e são usados pelo componente de tempo de execução e o serviço de administração para executar consultas JMX. Nas propriedades JMX globais, algumas propriedades são usadas para definir o modo de cluster (servidor independente ou trabalhando em um farm). O Server Configuration Tool configura a propriedade mfp.topology.clustermode como Independente no servidor Liberty. Na parte final desse tutorial sobre a criação de um farm, a propriedade é modificada para Cluster.
5. A criação de usuários (Válida também para o Apache Tomcat e o WebSphere Application Server)
    * Usuários opcionais: o Server Configuration Tool cria um usuário de teste (admin/admin) para que seja possível usar esse usuário para efetuar login no console após a instalação.
    * Usuários obrigatórios: o Server Configuration Tool também cria um usuário (chamado configUser_mfpadmin com uma senha gerada aleatoriamente) para ser usado pelo serviço de administração para entrar em contato com o serviço de atualização em tempo real local. Para o servidor Liberty, é criado MfpRESTUser. Se seu servidor de aplicativos não estiver configurado para usar um registro básico (por exemplo, um registro LDAP), o Server Configuration Tool não poderá solicitar o nome de um usuário existente. Nesse caso, é preciso usar tarefas Ant.
6. O elemento **webContainer** é modificado.

    A propriedade customizada do contêiner da web `deferServletLoad` é configurada para false. Tanto o componente de tempo de execução quanto o serviço de administração devem ser iniciados quando o servidor for iniciado. Esses componentes podem então registrar os beans JMX e iniciar o procedimento de sincronização que permite que o componente de tempo de execução faça download de todos os aplicativos e adaptadores que ele precisa atender.
7. O executor padrão é customizado para configurar valores grandes para `coreThreads` e `maxThreads` se você usar Liberty V8.5.5.5 ou anterior. O executor padrão é ajustado automaticamente pelo Liberty a partir da V8.5.5.6.

    Essa configuração evita problemas de tempo limite que quebram a sequência de inicialização do componente de tempo de execução e do serviço de administração em algumas versões do Liberty. A ausência dessa instrução pode ser a causa desses erros no arquivo de log do servidor:
    
    > Falha ao obter a conexão JMX para acessar um MBean. Pode haver um erro de configuração de JMX: atingido o tempo limite de leitura
FWLSE3000E: foi detectado um erro do servidor.
    > FWLSE3012E: erro de configuração do JMX. Não é possível obter MBeans. Motivo: "Limite de tempo de leitura atingido".

#### Declaração de aplicativos
{: #declaration-of-applications }
Os aplicativos a seguir estão instalados:

* **mfpadmin**, o serviço de administração
* **mfpadminconfig**, o serviço de atualização em tempo real
* **mfpconsole**, {{ site.data.keys.mf_console }}
* **mobilefirs**t, {{site.data.keys.product_adj }} componente de tempo de execução
* **imfpush**, o serviço de push

O Server Configuration Tool instala todos os aplicativos no mesmo servidor. É possível separar os aplicativos em diferentes servidores de aplicativos, mas com algumas restrições que estão documentadas em [Topologias e fluxos de rede](../../../prod-env/topologies).  
Para uma instalação em servidores diferentes, não é possível usar o Server Configuration Tool. Use tarefas Ant ou instale o produto manualmente.

#### Serviço de administração
{: #administration-service }
O serviço de administração é o serviço para gerenciar aplicativos {{ site.data.keys.product_adj }}, adaptadores e suas configurações. Ele é protegido por funções de segurança. Por padrão, o Server Configuration Tool inclui um usuário (admin) com a função de administrador, que pode ser usado para efetuar login no console para teste. A configuração da função de segurança deve ser feita após uma instalação com o Server Configuration Tool (ou com tarefas Ant). Talvez você queira mapear usuários ou grupos que vêm do registro básico ou registro LDAP que você configura em seu servidor de aplicativos para cada função de segurança.

O carregador de classes é configurado com a delegação de pai por último para o perfil Liberty e o WebSphere Application Server e para todos os aplicativos {{ site.data.keys.product_adj }}. Essa configuração é para evitar conflitos entre as classes empacotadas em aplicativos {{ site.data.keys.product_adj }} e classes do servidor de aplicativos. Esquecer de configurar a delegação do carregador de classes para último pai é uma frequente fonte de erros na instalação manual. Para o Apache Tomcat, essa declaração não é necessária.

No perfil Liberty, uma biblioteca comum é incluída no aplicativo para decriptografar senhas passadas como propriedades JNDI. O Server Configuration Tool define duas propriedades JNDI obrigatórias para o serviço de administração: **mfp.config.service.user** e **mfp.config.service.password**. Elas são usadas pelo serviço de administração para se conectarem ao serviço de atualização em tempo real com sua API REST. Mais propriedades JNDI podem ser definidas para ajustar o aplicativo ou adaptá-lo às particularidades de sua instalação. Para obter informações adicionais, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

O Server Configuration Tool também define as propriedades JNDI (a URL e os parâmetros OAuth para registrar os clientes confidenciais) para a comunicação com o serviço de push.  
A origem de dados para o banco de dados que contém as tabelas para o serviço de administração é declarada, bem como uma biblioteca para seu driver JDBC.

#### Serviço de atualização em tempo real
{: #live-update-service }
O serviço de atualização em tempo real armazena informações sobre o tempo de execução e configurações do aplicativo. Isso é controlado pelo serviço de administração e deve ser sempre executado no mesmo servidor que o serviço de administração. A raiz de contexto é **context\_root\_of\_admin\_serverconfig**. Dessa forma, ela é **mfpadminconfig**. O serviço de administração supõe que essa convenção seja respeitada para criar a URL de suas solicitações para os serviços REST do serviço de atualização em tempo real.

O carregador de classes é configurado para a última delegação de pai, conforme discutido na seção de serviço de administração.

O serviço de atualização em tempo real tem uma função de segurança, **admin_config**. Um usuário deve ser mapeado para essa função. Sua senha e seu login devem ser fornecidos para o serviço de administração com a propriedade JNDI: **mfp.config.service.user** e **mfp.config.service.password**. Para obter informações sobre as propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) e [Lista de propriedades JNDI para o serviço de atualização em tempo real do {{ site.data.keys.mf_server }}](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service).

Ele também precisa de uma origem de dados com nome JNDI no perfil Liberty. A convenção é **context\_root\_of\_config\_server/jdbc/ConfigDS**. Neste tutorial, ela é definida como **mfpadminconfig/jdbc/ConfigDS**. Em uma instalação pelo Server Configuration Tool ou com tarefas Ant, as tabelas do serviço de atualização em tempo real estão no mesmo banco de dados e esquema que as tabelas do serviço de administração. O usuário para acessar essas tabelas também é o mesmo.

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} é declarado com as mesmas funções de segurança que o serviço de administração. Os usuários que são mapeados para as funções de segurança do {{ site.data.keys.mf_console }} também devem ser mapeados para a mesma função de segurança do serviço de administração. De fato, o {{ site.data.keys.mf_console }} executa consultas para o serviço de administração em nome do usuário do console.

O Server Configuration Tool posiciona uma propriedade JNDI, **mfp.admin.endpoint**, que indica como o console se conecta ao serviço de administração. O valor padrão configurado pelo Server Configuration Tool é `*://*:*/mfpadmin`. A configuração significa que ele deve usar o mesmo protocolo, nome do host e porta que a solicitação de HTTP recebida para o console, e a raiz de contexto do serviço de administração é /mfpadmin. Se desejar forçar a solicitação para passar por um proxy da web, mude o valor padrão. Para obter informações adicionais sobre os valores possíveis para essa URL, ou para obter informações sobre outras possíveis propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

O carregador de classes é configurado para a última delegação de pai, conforme discutido na seção de serviço de administração.

#### Tempo de execução
{{ site.data.keys.product_adj }}
{: #mobilefirst-runtime }
Esse aplicativo não é protegido por uma função de segurança. Não é necessário efetuar login com um usuário conhecido pelo servidor Liberty para acessar esse aplicativo. As solicitações de dispositivos móveis são roteadas para o tempo de execução. Elas são autenticadas por outros mecanismos específicos para o produto (como OAuth) e para a configuração dos aplicativos  {{ site.data.keys.product_adj }}.

O carregador de classes é configurado para a última delegação de pai, conforme discutido na seção de serviço de administração.

Ele também precisa de uma origem de dados com nome JNDI no perfil Liberty. A convenção é **context\_root\_of\_runtime/jdbc/mfpDS**. Neste tutorial, ela é definida como **mobilefirst/jdbc/mfpDS**. Em uma instalação pelo Server Configuration Tool ou com tarefas Ant, as tabelas do tempo de execução estão no mesmo banco de dados e esquema que as tabelas do serviço de administração. O usuário para acessar essas tabelas também é o mesmo.

#### Serviço de push
{: #push-service }
Este aplicativo é protegido por OAuth. Os tokens OAuth válidos devem ser incluídos em qualquer solicitação de HTTP para o serviço.

A configuração do OAuth é feita por meio de propriedades JNDI (como a URL do servidor de autorizações, o ID do cliente e a senha do serviço de push). As propriedades JNDI também indicam o plug-in de segurança (**mfp.push.services.ext.security**) e o fato de que um banco de dados relacional é usado (**mfp.push.db.type**). As solicitações dos dispositivos móveis para o serviço de push são roteadas para esse serviço. A raiz de contexto do serviço de push deve ser /imfpush. O SDK cliente calcula a URL do serviço de push com base na URL do tempo de execução com a raiz de contexto (**/imfpush**). Se desejar instalar o serviço de push em um servidor diferente do tempo de execução, é necessário ter um roteador HTTP que possa rotear as solicitações do dispositivo para o servidor de aplicativos relevante.

O carregador de classes é configurado para a última delegação de pai, conforme discutido na seção de serviço de administração.

Ele também precisa de uma origem de dados com nome JNDI no perfil Liberty. O nome JNDI é **imfpush/jdbc/imfPushDS**. Em uma instalação pelo Server Configuration Tool ou com tarefas Ant, as tabelas do serviço de push estão no mesmo banco de dados e esquema que as tabelas do serviço de administração. O usuário para acessar essas tabelas também é o mesmo.

#### Modificação de outros arquivos
{: #other-files-modification }
O arquivo **jvm.options** do perfil Liberty é modificado. Uma propriedade (**com.ibm.ws.jmx.connector.client.rest.readTimeout**) é definida para evitar problemas de tempo limite com o JMX quando o tempo de execução for sincronizado com o serviço de administração.

### Testando a Instalação
{: #testing-the-installation }
Após a instalação ser concluída, é possível usar esse procedimento para testar os componentes instalados.

1. Inicie o servidor usando o comando **server start mfp1**. O arquivo binário para o servidor está em **liberty\_install\_dir/bin**.
2. Teste {{ site.data.keys.mf_console }} com um navegador da web. Acesse [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Por padrão, o servidor é executado na porta 9080. No entanto, é possível verificar a porta no elemento `<httpEndpoint>` como definido no arquivo **server.xml**. Uma tela de login é exibida.

![A tela de login do console](mfpconsole_signin.jpg)

3. Efetue login com **admin/admin**. Por padrão, esse usuário é criado pelo Server Configuration Tool.

    > **Nota:** Se você se conectar ao HTTP, o ID e a senha de login serão enviados em texto não criptografado na rede. Para um login seguro, use HTTPS para efetuar login no servidor. É possível ver a porta HTTPS do servidor Liberty no atributo httpsPort do `<httpEndpoint>` elemento no arquivo **server.xml**. Por padrão, o valor é 9443.

4. Efetue logout do console com **Hello Admin → Sair**.
5. Insira a seguinte URL: [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) no navegador da web e aceite o certificado. Por padrão, o servidor Liberty gera um certificado padrão que não é conhecido pelo seu navegador da web e você precisa aceitar o certificado. Mozilla Firefox apresenta essa certificação como uma exceção de segurança.
6. Efetue login novamente com **admin/admin**. O login e a senha são criptografados entre seu navegador da web e o {{ site.data.keys.mf_server }}. Na produção, talvez você queira fechar a porta HTTP.

## Criando um farm de dois servidores Liberty executando {{ site.data.keys.mf_server }}
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
Nesta tarefa, você criará um segundo servidor Liberty executando o mesmo {{ site.data.keys.mf_server }} e conectado ao mesmo banco de dados. Em produção, você pode usar mais de um servidor por motivos de desempenho para ter servidores suficientes para atender o número de transações por segundo necessário para seus aplicativos móveis em horário de pico. E também por motivos de alta disponibilidade para evitar um ponto único de falha.

Quando se tem mais de um servidor executando o {{ site.data.keys.mf_server }}, os servidores devem ser configurados como um farm. Essa configuração permite que qualquer serviço de administração entre em contato com todos os tempos de execução de um farm. Se o cluster não estiver configurado como um farm, somente o tempo de execução que é executado no mesmo servidor de aplicativos que o serviço de gerenciamento executando a operação de gerenciamento é notificado. Outros tempos de execução não têm conhecimento da mudança. Por exemplo, você implementa uma nova versão de um adaptador em cluster não configurado como um farm; somente um servidor atenderia o novo adaptador. Os outros servidores continuariam atendendo o antigo adaptador. A única situação em que é possível ter um cluster e não precisar configurar um farm é quando você instala seus servidores no WebSphere Application Server Network Deployment. O serviço de administração está apto para localizar todos os servidores consultando os beans JMX com o gerenciador de implementação. O gerenciador de implementação deve estar em execução para permitir operações de gerenciamento, pois ele é usado para fornecer a lista dos beans JMX do
{{ site.data.keys.product_adj }} da célula.

Quando você cria um farm, também é necessário configurar um servidor HTTP para enviar consultas para todos os membros do farm. A configuração de um servidor HTTP não está incluída neste tutorial. Este tutorial trata apenas da configuração do farm, de modo que as operações de gerenciamento sejam replicadas para todos os componentes de tempo de execução do cluster.

1. Crie um segundo servidor Liberty no mesmo computador.
    * Inicie uma linha de comandos.
    * Acesse **liberty\_install\_dir/bin**, e insira server create **mfp2**.

2. Modifique as portas HTTP e HTTPS do servidor **mfp2** para que elas não entrem em conflito com as portas do servidor **mfp1**.
    * Acesse o segundo diretório do servidor.

        O diretório é **liberty\_install\_dir/usr/servers/mfp2** ou **WLP\_USER\_DIR/servers/mfp2** (se você modificar o diretório, conforme descrito na etapa 6 de Instalando o WebSphere Application Server Liberty Core).
    * Edite o arquivo **server.xml**. Replace

      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9080"
        httpsPort="9443" />
      ```
        
      Com:
        
      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9081"
        httpsPort="9444" />
      ```
        
      As portas HTTP e HTTPS do servidor mfp2 não entram em conflito com as portas do servidor mfp1 com essa mudança. Certifique-se de modificar as portas antes de executar a instalação do {{ site.data.keys.mf_server }}. Caso contrário, se você modificar a porta após a instalação ser feita, também será necessário refletir a mudança da porta na propriedade JNDI: **mfp.admin.jmx.port**.

3. Copie o arquivo Ant que foi usado em [Implementando o {{ site.data.keys.mf_server }} no Liberty com tarefas Ant](#deploying-mobilefirst-server-to-liberty-with-ant-tasks), e mude o valor da propriedade **appserver.was85liberty.serverInstance** para **mfp2**. As tarefas Ant detectam que os bancos de dados existem e não criam as tabelas (consulte a extração de log a seguir). Em seguida, os aplicativos são implementados no servidor.

   ```bash
   [configuredatabase] Verificando a conectividade com o banco de dados MobileFirstAdmin MFPDATA com esquema 'MFPDATA' e usuário 'mfpuser'...
   [configuredatabase] Banco de dados MFPDATA existe.
   [configuredatabase] Conexão com o banco de dados MobileFirstAdmin MFPDATA com esquema 'MFPDATA' e usuário 'mfpuser' estabelecida com sucesso.
   [configuredatabase] Obtendo a versão do banco de dados MobileFirstAdmin MFPDATA...
   [configuredatabase] Tabela MFPADMIN_VERSION existe, verificando seu valor...
   [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
    [configuredatabase] Configurando o banco de dados MobileFirstAdmin MFPDATA...
   [configuredatabase] O banco de dados está na versão mais recente (8.0.0), não é necessário fazer upgrade.
   [configuredatabase] Configuração do banco de dados MobileFirstAdmin MFPDATA feita com sucesso.
   ```

4. Teste os dois servidores com a conexão HTTP.
    * Abra um navegador da Web.
    * Insira a seguinte URL: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). O console é atendido pelo servidor mfp1.
    * Efetue login com **admin/admin**.
    * Abra uma guia no mesmo navegador da web e insira a URL: [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole). O console é atendido pelo servidor mfp2.
    * Efetue login com admin/admin. Se a instalação for feita corretamente, é possível ver a mesma página de boas-vindas em ambas as guias após o login.
    * Retorne à primeira guia do navegador e clique em **Olá, administrador → Fazer download do log de auditoria**. Você é desconectado do console e vê a tela de login novamente. Esse comportamento de logout é um problema. O problema acontece porque, quando você efetua logon no servidor mfp2, um token Lightweight Third Party Authentication (LTPA) é criado e armazenado em seu navegador como um cookie. No entanto, esse token LTPA não é reconhecido pelo servidor mfp1. É provável que aconteça uma alternância entre servidores em um ambiente de produção quando você tiver um balanceador de carga HTTP na frente do cluster. Para resolver esse problema, deve-se assegurar que ambos os servidores (mfp1 e mfp2) gerem tokens LTPA com as mesmas chaves secretas. Copie as chaves LTPA do servidor mfp1 no servidor mfp2.
    
        * Pare ambos os servidores com estes comandos:
        
          ```bash
          server stop mfp1
          server stop mfp2
          ```
        
        * Copie as chaves LTPA do servidor mfp1 no servidor mfp2.
            Em **liberty\_install\_dir/usr/servers** ou **WLP\_USER\_DIR/servers**, execute o seguinte comando, dependendo de seu sistema operacional. 
            * No UNIX: `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
            * No Windows: `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * Reinicie os servidores. Alterne de uma guia do navegador para outra que não requer um novo login. Em um server farm Liberty, todos os servidores devem ter as mesmas chaves LTPA.
    
5. Ative a comunicação JMX entre os servidores Liberty.

    A comunicação JMX com o Liberty é feita via o conector REST do Liberty sobre o protocolo HTTPS. Para ativar essa comunicação, cada servidor do farm deve estar apto para reconhecer o certificado SSL dos outros membros. É necessário trocar os certificados HTTPS em seus armazenamentos confiáveis. Use utilitários IBM, como o Keytool, que faz parte da distribuição do IBM JRE em **java/bin** para configurar o armazenamento confiável. Os locais do keystore e do armazenamento confiável são definidos no arquivo **server.xml**. Por padrão, o keystore do perfil Liberty está em **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks**. A senha desse keystore padrão, como pode ser visto no arquivo **server.xml**, é **mobilefirst**.
        
    > **Dica:** É possível mudá-la com o utilitário Keytool, mas também deve-se mudar a senha no arquivo server.xml para que o servidor Liberty possa ler esse keystore. Neste tutorial, use a senha padrão.
    
    * Em **WLP\_USER\_DIR/servers/mfp1/resources/security**, insira `keytool -list -keystore key.jks`. O comando mostra os certificados no keystore. Há somente um **default** nomeado. É solicitada a senha do keystore (mobilefirst) antes de você ver as chaves. Esse é o caso para todos os próximos comandos com o utilitário Keytool.
    * Exporte o certificado padrão do servidor mfp1 com o comando: `keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`.
    * Em **WLP\_USER\_DIR/servers/mfp2/resources/security**, exporte o certificado padrão do servidor mfp2 com o comando: `keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`.
    * No mesmo diretório, importe o certificado do servidor mfp1 com o comando: `keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`. O certificado do servidor mfp1 é importado no keystore do servidor mfp2 para que o servidor mfp2 possa confiar nas conexões HTTPS com o servidor mfp1. Será solicitado que você confirme se confia no certificado.
    * Em **WLP\_USER\_DIR/servers/mfp1/resources/security**, importe o certificado do servidor mfp2 com o comando: `keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`. Após essa etapa, as conexões HTTPS entre os dois servidores serão possíveis.

## Testando o farm e vendo mudanças no {{ site.data.keys.mf_console }}
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. Inicie os dois servidores:

   ```bash
   server start mfp1
   server start mfp2
   ```
        
2. Acesse o console. Por exemplo, [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) ou [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) em HTTPS. Na barra lateral esquerda, um menu extra rotulado como **Nós do Server Farm** aparece. Se você clicar em **Nós do Server Farm**, é possível ver o status de cada nó. Talvez você tenha que esperar um pouco até que os nós sejam iniciados.
