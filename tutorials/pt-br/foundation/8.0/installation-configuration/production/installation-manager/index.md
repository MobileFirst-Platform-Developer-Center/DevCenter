---
layout: tutorial
title: Executando o IBM Installation Manager
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O IBM Installation Manager instala os arquivos e as ferramentas do {{ site.data.keys.mf_server_full }} em seu computador.

Você executa o Installation Manager para instalar os arquivos binários do {{ site.data.keys.mf_server }} e as ferramentas para implementar
os aplicativos {{ site.data.keys.mf_server }} em um servidor de aplicativos em seu computador. Os arquivos e ferramentas instalados pelo instalador são descritos em [Estrutura de distribuição do {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server).

Você precisa do IBM Installation Manager V1.8.4 ou posterior para executar o instalador do {{ site.data.keys.mf_server }}. É possível executá-lo no modo gráfico ou no modo de linha de comando.  
As duas principais opções são propostas durante o processo de instalação:

* Ativação do licenciamento de token
* Instalação e implementação do {{ site.data.keys.mf_app_center }}

### Licenciamento de Token
{: #token-licensing }
O licenciamento de token é um dos dois métodos de licenciamento suportados pelo {{ site.data.keys.mf_server }}. Deve-se determinar se é ou não necessário ativar o licenciamento de token. Se você não tiver um contrato que define o uso de licenciamento de token com o Rational License Key Server, não ative o licenciamento de token. Se você ativar o licenciamento de token, deve-se configurar o {{ site.data.keys.mf_server }} para licenciamento de token. Para obter informações adicionais, consulte [Instalando e configurando para licenciamento de token](../token-licensing).

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
O Application Center é um componente do {{ site.data.keys.product }}. Com o Application Center, é possível compartilhar aplicativos móveis que estão em desenvolvimento em sua organização em um único repositório de aplicativos móveis.

Se você optar por instalar o Application Center com o Installation Manager, deverá fornecer os parâmetros do banco de dados e do servidor de aplicativos para que o Installation Manager configure os bancos de dados e implemente o Application Center no servidor de aplicativos. Se você optar por não instalar o Application Center com o Installation Manager, o Installation Manager salvará o arquivo WAR e os recursos do Application Center em seu disco. Ele não configura os bancos de dados nem implementa o arquivo WAR do Application Center no servidor de aplicativos. Isso pode ser feito posteriormente usando tarefas Ant ou manualmente. Essa opção para instalar o Application Center é uma maneira conveniente de descobrir o Application Center, porque você é orientado durante o processo de instalação pelo assistente de instalação gráfico.

No entanto, para instalação de produção, use tarefas Ant para instalar o Application Center. A instalação com tarefas Ant permite desacoplar as atualizações no {{ site.data.keys.mf_server }} das atualizações no Application Center.

* Vantagem de instalar o Application Center com o Installation Manager.
    * Um assistente gráfico guiado lhe ajuda durante o processo de instalação e implementação.
* Desvantagens de instalar o Application Center com o Installation Manager.
    * Se o Installation Manager for executado com o usuário root no UNIX ou no Linux, ele pode criar arquivos que pertencem à raiz no diretório do servidor de aplicativos em que o Application Center está implementado. Como resultado, deve-se executar o servidor de aplicativos como raiz.
    * Você não tem acesso aos scripts do banco de dados e não pode fornecê-los para seu administrador de banco de dados para criar as tabelas antes da execução do procedimento de instalação. O Installation Manager cria as tabelas de banco de dados para você com as configurações padrão.
    * Sempre que você fizer upgrade do produto, por exemplo, para instalar uma correção temporária, o Application Center será atualizado primeiro. O upgrade do Application Center inclui operações no banco de dados e no servidor de aplicativos. Se o upgrade do Application Center falhar, isso impedirá o Installation Manager de concluir o upgrade, e te impedirá de fazer upgrade de outros componentes do {{ site.data.keys.mf_server }}. Para instalação de produção, não implemente o Application Center com o Installation Manager. Instale o Application Center separadamente com tarefas Ant após o Installation Manager instalar o {{ site.data.keys.mf_server }}. Para obter informações adicionais sobre o Application Center, consulte [Instalando e configurando o Application Center](../../../appcenter).

> **Importante:** O instalador do {{ site.data.keys.mf_server }} instala somente os arquivos binários e ferramentas do {{ site.data.keys.mf_server }} em seu disco. Ele não implementa os aplicativos {{ site.data.keys.mf_server }} em seu servidor de aplicativos. Após a execução da instalação com o Installation Manager, deve-se configurar os bancos de dados e implementar os aplicativos {{ site.data.keys.mf_server }} em seu servidor de aplicativos.  
> Da mesma forma, quando você executa o Installation Manager para atualizar uma instalação existente, eçe atualiza somente os arquivos que estão no seu disco. É necessário executar ações adicionais para atualizar os aplicativos que estão implementados em seus servidores de aplicativos.

#### Ir para
{: #jump-to }
* [Modo de administrador versus modo de usuário](#administrator-versus-user-mode)
* [Instalando usando o Assistente de instalação do IBM Installation Manager](#installing-by-using-ibm-installation-manager-install-wizard)
* [Instalando executando o IBM Installation Manager na linha de comandos](#installing-by-running-ibm-installation-manager-in-command-line)
* [Instalando usando arquivos de resposta XML - instalação silenciosa](#installing-by-using-xml-response-files---silent-installation)
* [Estrutura de distribuição do {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server)

## Modo de administrador versus modo de usuário
{: #administrator-versus-user-mode }
É possível instalar o {{ site.data.keys.mf_server }} em dois modos diferentes do IBM Installation Manager. O modo depende de como o próprio IBM Installation Manager está instalado. O modo determina os diretórios e os comandos que você usa para o Installation Manager e os pacotes.

{{ site.data.keys.product }} suporta os dois modos do Installation Manager a seguir:

* Modo de administrador
* Modo de usuário (não administrador)

O modo de grupo que está disponível no Linux ou UNIX não é suportado pelo produto.

### Modo de administrador
{: #administrator-mode }
No modo de administrador, o Installation Manager deve ser executado como raiz sob Linux ou UNIX e com privilégios de administrador sob o Windows. Os arquivos de repositório do Installation Manager (ou seja, a lista de softwares instalados e suas versões) estão instalados em um diretório do sistema. /var/ibm no Linux ou UNIX, ou ProgramData no Windows. Não implemente o Application Center com o Installation Manager se você executar o Installation Manager no modo de administrador.

### Modo de usuário (não administrador)
{: #user-nonadministrator-mode }
No modo de usuário, o Installation Manager pode ser executado por qualquer usuário sem privilégios específicos. Entretanto, os arquivos de repositório do Installation Manager são armazenados no diretório inicial do usuário. Somente esse usuário está apto para fazer upgrade de uma instalação do produto.
Se você não executar o Installation Manager como raiz, certifique-se de ter uma conta do usuário que esteja disponível posteriormente quando você fizer upgrade da instalação do produto ou aplicar uma correção temporária.

Para obter informações adicionais sobre os modos do Installation Manager, consulte [Instalando como um administrador, não administrador ou grupo](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc) na documentação do IBM Installation Manager.

## Instalando usando o Assistente de instalação do IBM Installation Manager
{: #installing-by-using-ibm-installation-manager-install-wizard }
Siga as etapas no procedimento para instalar os recursos do {{ site.data.keys.mf_server }}, e as ferramentas (como o Server Configuration Tool, Ant e o programa mfpadm).  
As decisões nas duas áreas de janela a seguir no assistente de instalação são obrigatórias:

* O painel **Configurações Gerais**.
* O painel **Escolher configuração** para instalar o Application Center.

1. Inicie o Installation Manager.
2. Inclua o repositório do {{ site.data.keys.mf_server }} no Installation Manager.
    * Acesse **Arquivo → Preferências** e clique em **Incluir repositórios...**
    * Navegue para o arquivo de repositório no diretório no qual o instalador foi extraído.

        Se você descompactar o arquivo .zip do {{ site.data.keys.product }} V8.0 para o {{ site.data.keys.mf_server }} na pasta **mfp\_installer\_directory**, o arquivo de repositório poderá ser localizado em **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        Talvez você também queira aplicar o fix pack mais recente que pode ser transferido por download do [Portal de Suporte IBM](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). Certifique-se de inserir o repositório para o fix pack. Se você descompactar o fix pack na pasta **fixpack_directory**, o arquivo de repositório será localizado em **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**.

        **Nota:** Não é possível instalar o fix pack sem o repositório da versão base nos repositórios do Installation Manager. Os fix packs são instaladores incrementais e precisam que o repositório da versão base esteja instalado.
    * Selecione
o arquivo e clique em **OK**.
    * Clique em **OK** para fechar o painel **Preferências**.
3. Após aceitar os termos de licença do produto, clique em **Avançar**.
4. Escolha o grupo de pacotes para instalar o produto.

    {{ site.data.keys.product }} V8.0 é uma substituição das liberações anteriores que têm um nome de instalação diferente:
    * Worklight para V5.0.6
    * IBM Worklight para a V6.0 até a V6.3
    
    Se uma dessas versões mais antigas do produto estiver instalada em seu computador, o Installation Manager oferecerá uma opção Usar um grupo de pacotes existente no início do processo de instalação. Essa opção desinstala a versão mais antiga do produto e reutiliza as opções de instalação mais antigas para fazer upgrade do {{ site.data.keys.mf_app_center_full }}, caso ele estivesse instalado.
    
    Para uma instalação separada, selecione a opção Criar um novo grupo de pacotes para que seja possível instalar a nova versão junto com a mais antiga.  
    Se nenhuma outra versão do produto estiver instalada em seu computador, escolha a opção Criar um novo grupo de pacotes para instalar o produto em um novo grupo de pacotes.
    
5. Clique em **Avançar**.
6. Decida se deseja ativar o licenciamento de token na seção **Ativar Licenciamento de Token** do painel **Configurações Gerais**.

    Se você tiver um contrato para usar licenciamento de token com o Rational License Key Server, selecione a opção **Ativar licenciamento de token com o Rational License Key Server**. Após ativar o licenciamento de token, deve-se executar etapas extras para configurar o
{{ site.data.keys.mf_server }}. Caso contrário, selecione a opção **Não ativar licenciamento de token com o Rational License Key Server** para continuar.
7. Mantenha a opção padrão (Não) como está na seção **Instalar o {{ site.data.keys.product }} para iOS** do painel **Configurações gerais**.
8. Decide se irá instalar o Application Center no painel **Escolher configuração**.

    Para instalação de produção, use tarefas Ant para instalar o Application Center. A instalação com tarefas Ant permite desacoplar as atualizações no {{ site.data.keys.mf_server }} das atualizações no Application Center. Nesse caso, selecione a opção Não no painel Escolher configuração para que o Application Center não seja instalado.

    Se selecionar Sim, será necessário passar pelas próximas áreas de janela para inserir os detalhes sobre o banco de dados que você planeja usar e o servidor de aplicativos onde você planeja implementar o Application Center. Também é necessário ter o driver JDBC do banco de dados disponível.
9. Clique em **Avançar** até atingir o painel **Obrigado**. Em seguida, continue com a instalação.

Um diretório de instalação contendo os recursos para instalação dos componentes do {{ site.data.keys.product_adj }} está instalado.

É possível localizar os recursos nas pastas a seguir:

* Pasta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Pasta **PushService** para serviço de push do {{ site.data.keys.mf_server }}
* Pasta **ApplicationCenter** para Application Center
* Pasta **Analytics** para {{ site.data.keys.mf_analytics }}

Também é possível localizar alguns atalhos para o Server Configuration Tool, Ant e o programa mfpadm na pasta **shortcuts**.

## Instalando executando o IBM Installation Manager na linha de comandos
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. Revise o contrato de licença para {{ site.data.keys.mf_server }}. Os arquivos de licença podem ser visualizados quando você fizer download do repositório de instalação a partir do Passport Advantage.
2. Extraia o arquivo compactado do repositório do {{ site.data.keys.mf_server }}, que você transferiu por download, para uma pasta.

    É possível fazer download do repositório do {{ site.data.keys.product }} eAssembly no [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). O nome do pacote é arquivo .zip do **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} do Installation Manager Repository para IBM MobileFirst Platform Server**.

    Nas etapas a seguir, o diretório onde é extraído o instalador é referido como **mfp\_repository\_dir**. Ele contém uma pasta **MobileFirst\_Platform\_Server/disk1**.
3. Inicie uma linha de comandos e acesse **installation\_manager\_install\_dir/tools/eclipse/**.

    Se você aceitar o contrato de licença após a revisão na etapa 1, instale o {{ site.data.keys.mf_server }}.
    * Para uma instalação sem execução de licenciamento de token (caso você não tenha um contrato que defina o uso de licenciamento de token), insira o comando:

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * Para uma instalação com execução de licenciamento de token, insira o comando:
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        O valor da propriedade **user.licensed.by.tokens** é configurado para **true**. Deve-se configurar o {{ site.data.keys.mf_server }} para [licenciamento de token](../token-licensing).
        
        As propriedades a seguir são configuradas para instalar o {{ site.data.keys.mf_server }} sem o Application Center:
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        Essa propriedade indica se o licenciamento de token está ativado ou não: **user.licensed.by.tokens=true/false**.
        
        Configure o valor da propriedade user.use.ios.edition como false para instalar o {{ site.data.keys.product }}.
        
5. Se desejar instalar com a correção temporária mais recente, inclua o repositório de correção temporária no parâmetro **-repositories**. O parâmetro **-repositories** usa uma lista separada por vírgula de repositórios.

    Inclua a versão da correção temporária substituindo **com.ibm.mobilefirst.foundation.server** por **com.ibm.mobilefirst.foundation.server_version**. **version** tem o formato **8.0.0.0-buildNumber**. Por exemplo, se você instalar a correção temporária **8.0.0.0-IF20160103101**5, insira o comando: `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`.
    
    Para obter informações adicionais sobre o comando imcl, consulte [Installation Manager: instalando pacotes usando comandos `imcl`](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en).
    
Um diretório de instalação contendo os recursos para instalação dos componentes do {{ site.data.keys.product_adj }} está instalado.

É possível localizar os recursos nas pastas a seguir:

* Pasta **MobileFirstServer** para {{ site.data.keys.mf_server }}
* Pasta **PushService** para serviço de push do {{ site.data.keys.mf_server }}
* Pasta **ApplicationCenter** para Application Center
* Pasta **Analytics** para {{ site.data.keys.mf_analytics }}    

Também é possível localizar alguns atalhos para o Server Configuration Tool, Ant e o programa mfpadm na pasta **shortcuts**.

## Instalando usando arquivos de resposta XML - instalação silenciosa
{: #installing-by-using-xml-response-files---silent-installation }
Se desejar instalar o {{ site.data.keys.mf_app_center_full }} com IBM Installation Manager na linha de comandos, será necessário fornecer uma grande lista de argumentos. Nesse caso, use os arquivos de resposta XML para fornecer esses argumentos.

Instalações silenciosas são definidas por um arquivo XML que é chamado de arquivo de resposta. Esse arquivo contém os dados necessários para concluir operações de instalação silenciosamente. As instalações silenciosas são iniciadas a partir da linha de comandos ou de um arquivo em lote.

É possível usar o Installation Manager para registrar preferências e ações de instalação para seu arquivo de resposta no modo de interface com o usuário. Como alternativa, é possível criar um arquivo de resposta manualmente usando a lista documentada de comandos e preferências do arquivo de resposta.

A instalação silenciosa está descrita na documentação do usuário do Installation Manager; consulte [Trabalhando no modo silencioso](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html).

Há duas maneiras de criar um arquivo de resposta adequado:

* Trabalhando com arquivos de resposta de amostra fornecidos na documentação do usuário do {{ site.data.keys.product_adj }}.
* Trabalhando com um arquivo de resposta registrado em um computador diferente.

Esses dois métodos serão documentados na próximas seções.

### Trabalhando com arquivos de resposta de amostra para IBM Installation Manager
{: #working-with-sample-response-files-for-ibm-installation-manager }
Os arquivos de resposta de amostra para IBM Installation Manager são fornecidos no arquivo compactado **Silent\_Install\_Sample_Files.zip**. Os procedimentos a seguir descrevem como utilizá-los.

1. Selecione o arquivo de resposta de amostra apropriado a partir do arquivo compactado. O arquivo Silent_Install_Sample_Files.zip contém um subdiretório por liberação.

    > **Importante:**  
    > 
    > * Para uma instalação que não instale o Application Center em um servidor de aplicativos, use o arquivo denominado **install-no-appcenter.xml**.
    > * para uma instalação que instale o Application Center, selecione o arquivo de amostra de resposta a partir da tabela a seguir, dependendo do seu servidor e do seu banco de dados de aplicativo. 

   #### Arquivos de resposta de instalação de amostra no arquivo **Silent\_Install\_Sample_Files.zip** para instalar o Application Center
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>O servidor de aplicativos no qual você instala o Application Center</th>
            <th>Derby</th>
            <th>IBM DB2 </th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>perfil Liberty do WebSphere Application Server</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (Consulte a Nota)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Perfil completo do WebSphere Application Server, servidor independente</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (Consulte a Nota)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>N/D</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (Consulte a Nota), install-wasnd-server-mysql.xml (Consulte a Nota), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml (Consulte a Nota)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>
    
    > **Nota:** O MySQL, em conjunto com o perfil Liberty do WebSphere Application Server ou o perfil completo do WebSphere Application Server, não é classificado como uma configuração suportada. Para obter informações adicionais, consulte [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). É possível usar o IBM DB2 ou outro DBMS que seja suportado pelo WebSphere Application Server para beneficiar-se de uma configuração que seja totalmente suportada pelo Suporte IBM.

    Para a desinstalação, use um arquivo de amostra que depende da versão do {{ site.data.keys.mf_server }} ou so Worklight Server que você instalou inicialmente no grupo de pacotes específico:
    
    * O {{ site.data.keys.mf_server }} usa o grupo de pacotes {{ site.data.keys.mf_server }}.
    * O Worklight Server V6.x ou mais recente usa o grupo de pacotes IBM Worklight.
    * O Worklight Server V5.x usa o grupo de pacotes Worklight.

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Versão inicial do {{ site.data.keys.mf_server }}</th>
            <th>Arquivo de Amostra</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server V6.x ou mais recente</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. Altere os direitos de acesso do arquivo de amostra para ser tão restritivo quanto possível. A Etapa 4 requer que você forneça algumas senhas. Se você tiver que impedir que outros usuários no mesmo computador saibam essas senhas, será necessário remover as permissões de leitura do arquivo para outros usuários, além de você. É possível usar um comando, como nos seguintes exemplos:
    * No UNIX: `chmod 600 <target-file.xml>`
    * No Windows: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. Da mesma forma, se o servidor for um perfil Liberty do WebSphere Application Server ou servidor Apache Tomcat, e o servidor for destinado a ser iniciado somente a partir de sua conta do usuário, também será preciso remover as permissões de leitura para usuários, além de você, do seguinte arquivo:
    * Para o perfil Liberty do WebSphere Application Server: `wlp/usr/servers/<server>/server.xml`
    * Para o Apache Tomcat: `conf/server.xml`
4. Ajuste a lista de repositórios no elemento <server>. Para obter informações adicionais sobre essa etapa, consulte a documentação do IBM Installation Manager em [Repositórios](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html).

    No elemento `<profile>`, ajuste os valores em cada par de chaves / valor.  
    No elemento `<offering>` no elemento `<install>`<offering>` `<install>`, configure o atributo de versão para corresponder à liberação que você deseja instalar ou remova o atributo de versão se quiser instalar a versão mais recente disponível nos repositórios.
5. Digite o seguinte comando: `<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    Em que:
    * `<InstallationManagerPath>` é o diretório de instalação do IBM Installation Manager.
    * `<responseFile>` é o nome do arquivo selecionado e atualizado na etapa 1.

> Para obter informações adicionais, consulte a documentação do IBM Installation Manager em [Instalando um pacote silenciosamente usando um arquivo de resposta](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).
    

### Trabalhando com um Arquivo de Resposta Registrado em uma Máquina Diferente
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. Registre um arquivo de resposta, executando o IBM Installation Manager no modo de assistente e com a opção `-record responseFile` em uma máquina em que uma GUI esteja disponível. Para obter mais detalhes, consulte [Registrar um arquivo de resposta com o Installation Manager](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html).
2. Altere os direitos de acesso do arquivo de resposta para ser tão restritivo quanto possível. A Etapa 4 requer que você forneça algumas senhas. Se você tiver de impedir que outros usuários no mesmo computador saibam essas senhas, deverá remover as permissões **read** do arquivo para outros usuários, além de você mesmo. É possível usar um comando, como nos seguintes exemplos:
    * No UNIX: `chmod 600 response-file.xml`
    * No Windows: `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. Da mesma forma, se o servidor for um WebSphere Application Server Liberty ou um servidor Apache Tomcat, e o servidor for destinado a ser iniciado somente a partir de sua conta do usuário, também será preciso remover as permissões de leitura para usuários, além de você, do seguinte arquivo:
    * Para WebSphere Application Server Liberty: `wlp/usr/servers/<server>/server.xml`
    * Para o Apache Tomcat: `conf/server.xml`
4. Modifique o arquivo de resposta para levar em conta as diferenças entre a máquina na qual o arquivo de resposta foi criado e a máquina de destino.
5. Instale o {{ site.data.keys.mf_server }}, usando o arquivo de resposta na máquina de destino, conforme descrito em [Instalar um pacote silenciosamente usando um arquivo de resposta](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).

### Parâmetros da linha de comandos (instalação silenciosa)
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>Key</th>
        <th>Quando necessário</th>
        <th>Descrição (Description)</th>
        <th>Valores permitidos</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>Sempre</td>
        <td>Configure o valor como <code>false</code> se você planeja instalar o {{ site.data.keys.product }}. Se você pretende instalar o produto para uma edição do iOS, deve-se configurar o valor para <code>true</code>.</td>
        <td><code>true</code> ou <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>Sempre</td>
        <td>Ativação do licenciamento de token. Se você pretende usar o produto com o Rational License Key Server, deve-se ativar o licenciamento de token.<br/><br/>Nesse caso, configure o valor para <code>true</code>. Se você não planeja usar o produto com o Rational License Key Server, configure o valor como <code>false</code>.<br/><br/>Se você ativar os tokens de licença, serão necessárias etapas específicas de configuração após a implementação do produto em um servidor de aplicativos. </td>
        <td><code>true</code> ou <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>Sempre</td>
        <td>Tipo de servidor de aplicativos. was significa WebSphere Application Server 8.5.5 pré-instalado. tomcat significa Tomcat 7.0.</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Diretório de instalação do WebSphere Application Server.</td>
        <td>Um nome de diretório absoluto.</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Perfil no qual instalar os aplicativos. Para WebSphere Application Server Network Deployment, especifique o perfil do Deployment Manager. Liberty significa o perfil Liberty (subdiretório wlp).</td>
        <td>O nome de um dos perfis do WebSphere Application Server.</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Célula do WebSphere Application Server na qual instalar os aplicativos.</td>
        <td>O nome da célula do WebSphere Application Server.</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Nó do WebSphere Application Server no qual instalar os aplicativos. Isso corresponde à máquina atual.</td>
        <td>O nome do nó do WebSphere Application Server da máquina atual.</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>Tipo de conjunto de servidores no qual instalar os aplicativos.<br/><br/><code>server</code> significa um servidor independente.<br/><br/><code>nd-cell</code> significa uma célula do WebSphere Application Server Network Deployment. <code>nd-cluster</code> significa um cluster do WebSphere Application Server Network Deployment.<br/><br/><code>nd-node</code> significa um nó do WebSphere Application Server Network Deployment (excluindo clusters).<br/><br/><code>nd-server</code> significa um servidor gerenciado do WebSphere Application Server Network Deployment.</td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == server</td>
      <td>Nome do servidor WebSphere Application Server no qual instalar os aplicativos.</td>
      <td>O nome de um servidor WebSphere Application Server na máquina atual.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-cluster</td>
      <td>Nome do cluster do WebSphere Application Server Network Deployment no qual instalar os aplicativos.</td>
      <td>O nome de um cluster do WebSphere Application Server Network Deployment na célula do WebSphere Application Server.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope} == nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>Nome do nó do WebSphere Application Server Network Deployment no qual instalar os aplicativos.</td>
      <td>O nome de um nó do WebSphere Application Server Network Deployment na célula do WebSphere Application Server.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-server</td>
      <td>Nome do servidor WebSphere Application Server Network Deployment no qual instalar os aplicativos.</td>
      <td>O nome de um servidor WebSphere Application Server Network Deployment no nó especificado do WebSphere Application Server Network Deployment.</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Nome do administrador do WebSphere Application Server.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Senha de administrador do WebSphere Application Server, opcionalmente criptografada de uma maneira específica.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Senha do usuário <code>appcenteradmin</code> para inclusão na lista de usuários do WebSphere Application Server, opcionalmente criptografada de uma maneira específica.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>Sufixo que distingue os aplicativos a serem instalados de outras instalações do {{ site.data.keys.mf_server }}.</td>
      <td>Sequência de 10 dígitos decimais.</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} == Liberty</td>
      <td>Nome do servidor WebSphere Application Server Liberty no qual instalar os aplicativos.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Diretório de instalação do Apache Tomcat. Para uma instalação do Tomcat dividida entre um diretório <b>CATALINA_HOME</b> e um diretório <b>CATALINA_BASE</b>, aqui é necessário especificar o valor da variável de ambiente <b>CATALINA_BASE</b>.</td>
      <td>Um nome de diretório absoluto.</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>Sempre</td>
      <td>Tipo de sistema de gerenciamento de banco de dados usado para armazenar os bancos de dados.</td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. O valor none significa que o instalador não instalará o Application Center. Se esse valor for usado, <b>user.appserver.selection2</b> e <b>user.database.selection2</b> deverão usar o valor none.</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>Sempre</td>
      <td><code>true</code> significa um sistema de gerenciamento de banco de dados pré-instalado, <code>false</code> significa o Apache Derby a ser instalado.</td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>O diretório no qual criar ou assumir os bancos de dados Derby.</td>
      <td>Um nome de diretório absoluto.</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>O nome do host ou o endereço IP do servidor de banco de dados DB2.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>A porta em que o servidor de banco de dados DB2 recebe conexões JDBC. Geralmente 50000.</td>
      <td>Um número entre 1 e 65535.</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>O nome do arquivo absoluto de db2jcc4.jar.</td>
      <td>Um nome de arquivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>O nome do usuário usado para acessar o banco de dados DB2 para o Application Center.</td>
      <td>Non-empty.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>A senha usada para acessar o banco de dados DB2 para o Application Center, opcionalmente criptografada de uma maneira específica.</td>
      <td>Senha não vazia.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>O nome do banco de dados DB2 para o Application Center.</td>
      <td>Non-empty; um nome de banco de dados DB2 válido.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Indica se <b>user.database.mysql.appcenter.dbname</b> é um nome de serviço ou um nome de SID. Se o parâmetro estiver ausente, <b>user.database.mysql.appcenter.dbname</b> será considerado um nome de SID.</td>
      <td><code>true</code> (indica um nome de Serviço) ou <code>false</code> (indica um nome de SID)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>O nome do esquema para o Application Center no banco de dados DB2.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>O nome do host ou o endereço IP do servidor de
banco de dados MySQL.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>A porta em que o servidor de banco de dados MySQL recebe conexões JDBC. Geralmente 3306.</td>
      <td>Um número entre 1 e 65535.</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td>O nome do arquivo absoluto de <b>mysql-connector-java-5.*-bin.jar</b>.</td>
      <td>Um nome de arquivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>O nome do usuário usado para acessar o banco de dados Oracle para o Application Center.</td>
      <td>Uma sequência composta por 1 a 30 caracteres: dígitos ASCII, ASCII em letras maiúsculas e minúsculas, '_', '#', '$' são permitidos.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>A senha usada para acessar o banco de dados Oracle para o Application Center, criptografada, opcionalmente, de uma maneira específica.</td>
      <td>A senha deve ser uma sequência composta por 1 a 30 caracteres: dígitos ASCII, ASCII em letras maiúsculas e minúsculas, '_', '#', '$' são permitidos.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, a menos que ${user.database.oracle.appcenter.jdbc.url} seja especificado</td>
      <td>O nome do banco de dados Oracle para o Application Center.</td>
      <td>Non-empty, um nome de banco de dados válido do Oracle.</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle, a menos que ${user.database.oracle.appcenter.jdbc.url} seja especificado</td>
      <td>O nome do host ou o endereço IP do servidor de banco de dados Oracle.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle, a menos que ${user.database.oracle.appcenter.jdbc.url} seja especificado</td>
      <td>A porta em que o servidor de banco de dados Oracle recebe conexões JDBC. Geralmente 1521.</td>
      <td>Um número entre 1 e 65535.</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>O nome do arquivo absoluto do arquivo JAR do driver thin do Oracle. (<b>ojdbc6.jar ou ojdbc7.jar</b>)</td>
      <td>Um nome de arquivo absoluto.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>O nome do usuário usado para acessar o banco de dados Oracle para o Application Center.</td>
      <td>Uma sequência composta por 1 a 30 caracteres: dígitos ASCII, ASCII em letras maiúsculas e minúsculas, '_', '#', '$' são permitidos.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>O nome do usuário usado para acessar o banco de dados Oracle para o Application Center, em uma sintaxe adequada para JDBC.</td>
      <td>O mesmo que ${user.database.oracle.appcenter.username} se iniciar com um caractere alfabético e não contiver caracteres minúsculos, caso contrário, deverá ser ${user.database.oracle.appcenter.username}, demarcada por aspas duplas.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>A senha usada para acessar o banco de dados Oracle para o Application Center, criptografada, opcionalmente, de uma maneira específica.</td>
      <td>A senha deve ser uma sequência composta por 1 a 30 caracteres: dígitos ASCII, ASCII em letras maiúsculas e minúsculas, '_', '#', '$' são permitidos.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, a menos que ${user.database.oracle.appcenter.jdbc.url} seja especificado</td>
      <td>O nome do banco de dados Oracle para o Application Center.</td>
      <td>Non-empty, um nome de banco de dados válido do Oracle.
</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Indica se <code>user.database.oracle.appcenter.dbname</code> é um nome de serviço ou um nome de SID. Se o parâmetro estiver ausente, <code>user.database.oracle.appcenter.dbname</code> será considerado um nome de SID.</td>
      <td><code>true</code> (indica um nome de Serviço) ou <code>false</code> (indica um nome de SID)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle, a menos que ${user.database.oracle.host}, ${user.database.oracle.port}, ${user.database.oracle.appcenter.dbname} sejam todos especificados</td>
      <td>A URL do JDBC do banco de dados Oracle para o Application Center.</td>
      <td>Uma URL do JDBC do Oracle válida. Iniciada com "jdbc:oracle:".</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>Sempre</td>
      <td>O usuário do sistema operacional que tem permissão para executar o servidor instalado.</td>
      <td>Um nome de usuário do sistema operacional, ou vazio.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>Sempre</td>
      <td>O grupo de usuários do sistema operacional que tem permissão para executar o servidor instalado.</td>
      <td>Um nome de grupo de usuários do sistema operacional, ou vazio.</td>
    </tr>
</table>

## Estrutura de distribuição do {{ site.data.keys.mf_server }}
{: #distribution-structure-of-mobilefirst-server }
Os arquivos e as ferramentas do {{ site.data.keys.mf_server }} estão instalado no diretório de instalação do {{ site.data.keys.mf_server }}.

#### Arquivos e subdiretórios no subdiretório Analytics
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **analytics.ear** e **analytics-*.war** | Os arquivos EAR e WAR para instalar {{ site.data.keys.mf_analytics }}. |
| **configuration-samples** | Contém os arquivos Ant de amostra para instalar o {{ site.data.keys.mf_analytics }} com tarefas Ant. |

#### Arquivos e subdiretórios no subdiretório ApplicationCenter
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **configuration-samples** | Contém os arquivos Ant de amostra para instalar o Application Center. As tarefas Ant criam a tabela de banco de dados e implementam arquivos WAR em um servidor de aplicativos. | 
| **console** | Contém os arquivos EAR e WAR para instalar o Application Center. O arquivo EAR é exclusivamente para o IBM PureApplication System. | 
| **databases** | Contém os scripts SQL a serem usados para a criação manual de tabelas para o Application Center. |
| **installer** | Contém os recursos para criar o cliente Application Center. | 
| **tools** | As ferramentas do Application Center. | 

#### Arquivos e subdiretórios no subdiretório {{ site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **mfp-ant-deployer.jar** | Um conjunto de tarefas Ant do {{ site.data.keys.mf_server }}. |
| **mfp-*.war** | Os arquivos WAR dos componentes do {{ site.data.keys.mf_server }}. |
| **configuration-samples** | Contém os arquivos Ant de amostra para instalar componentes do {{ site.data.keys.mf_server }} com tarefas Ant. | 
| **ConfigurationTool** | Contém os arquivos binários do Server Configuration Tool. A ferramenta é ativada a partir de **mfp_server_install_dir/shortcuts**. |
| **databases** | Contém os scripts SQL a serem usados para a criação manual de tabelas para componentes do {{ site.data.keys.mf_server }} (serviço de administração do {{ site.data.keys.mf_server }}, serviço de configuração do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product_adj }}). | 
| **external-server-libraries** |  Contém os arquivos JAR usados por diferentes ferramentas (como ferramenta de autenticidade e ferramenta de segurança OAuth). |

#### Arquivos e subdiretórios no subdiretório PushService
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **mfp-push-service.war** | O arquivo WAR para instalar o serviço de push do {{ site.data.keys.mf_server }}. |
| **databases** | Contém os scripts SQL a serem usados para a criação manual de tabelas para o serviço de push do {{ site.data.keys.mf_server }}. | 

#### Arquivos e subdiretórios no subdiretório License
{: #files-and-subdirectories-in-the-license-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **Texto** | Contém a licença para {{ site.data.keys.product }}. | 

#### Arquivos e subdiretórios no diretório de instalação do {{ site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| Item | Descrição (Description) |
|------|-------------|
| **shortcuts** | Os scripts do ativador para Apache Ant, o Server Configuration Tool, e o comando mfpadmin, que são fornecidos com o {{ site.data.keys.mf_server }}. | 

#### Arquivos e subdiretórios no subdiretório tools
{: #files-and-subdirectories-in-the-tools-subdirectory }

| Item | Descrição (Description) |
|------|-------------|
| **tools/apache-ant-version-number** | Uma instalação binária do Apache Ant que é usada pelo Server Configuration Tool. Ela também pode ser usada para executar tarefas Ant. | 
