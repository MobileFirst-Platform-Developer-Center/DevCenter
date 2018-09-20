---
layout: tutorial
title: Executando o IBM Installation Manager para atualização
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Executando o Installation Manager em modo gráfico
{: #graphical-mode}

* Execute o Installation Manager da conta do usuário que é usada na instalação inicial.
  Para aplicar uma atualização, o Installation Manager deve ser executado com a mesma lista de arquivos de registro que são usados na instalação inicial. A lista de Softwares que está instalada e as opções que são usadas durante o momento da instalação são armazenadas nesses arquivos de registro. Se você executar o Installation Manager no modo de administrador, os arquivos de registro serão instalados no nível do sistema. Na pasta `/var` no UNIX ou no Linux. Na pasta `c:\ProgramData` no Windows. O local é independente do usuário que executa o Installation Manager (embora a raiz seja necessária no UNIX e no Linux). No entanto, se você executar o Installation Manager no modo de usuário único, os arquivos de registro serão armazenados por padrão no diretório inicial do usuário.

* Selecione **Arquivo > Preferências**.
  Se você planeja atualizar um IBM MobileFirst Platform Foundation V8.0.0 existente (aplicar um fix pack ou uma correção temporária), o repositório do produto não é necessário.

* Clique em **OK** para fechar a exibição **Preferências**.

* Clique em **Atualização** e selecione o pacote que precisa ser atualizado. O Installation Manager exibe uma lista de pacotes. Por padrão, o pacote para atualização é nomeado como IBM MobileFirst Platform Server.

* Aceite os termos de licença e clique em **Avançar**.

* No painel **Obrigado**, clique em **Avançar**. Um resumo é exibido.

* Clique em **Atualizar** para iniciar o procedimento de atualização.

## Executando o Installation Manager no modo de linha de comando
{: #cli-mode}

1. Faça download dos arquivos de instalação silenciosa [aqui](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip).

2. Descompacte o arquivo e selecione o arquivo `8.0/upgrade-initially-mfpserver.xml`.
  - Se você instalou inicialmente o produto na V6.0.0, na V6.1.0 ou na V6.2.0, selecione o `8.0/upgrade-initially-worklightv6.xmlfile` em vez disso.
  - Se você instalou inicialmente o produto na V5.x, selecione este arquivo `8.0/upgrade-initially-worklightv5.xml` em vez disso.
  O arquivo contém a identidade de perfil do produto. O valor padrão dessa identidade é mudado nas liberações do produto. Na V5.x, ele é Worklight. Na V6.0.0, na V6.1.0 e na V6.2.0, ele é IBM Worklight. Na V6.3.0, na V7.0.0, na V7.1.0 e na V8.0.0, ele é IBM MobileFirst Platform Server.

3. Faça uma cópia do arquivo selecionado.

4. Abra o arquivo XML copiado com um editor de texto ou um editor de XML. Modifique os elementos a seguir:

   a. O elemento de repositório que define a lista de repositórios. Como você planeja atualizar um IBM MobileFirst Platform Foundation V8.0.0 existente (aplique um fix pack ou uma correção temporária), o repositório do produto não é necessário.

   b. **Opcional:** atualize as senhas para o banco de dados e o servidor de aplicativos.
      Se o Application Center estiver instalado na instalação inicial com o Installation Manager e as senhas para o banco de dados ou para o servidor de aplicativos forem mudadas, será possível modificar o valor no arquivo XML. Essas senhas são usadas para validar que o banco de dados tem a versão de esquema correta e para atualizá-lo se ele estiver em uma versão anterior à V8.0.0. Também são usadas para executar **wsadmin** para uma instalação do Application Center no perfil integral do WebSphere Application Server. Remova os comentários das linhas apropriadas no arquivo XML:
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. Se você não tiver feito uma escolha antes de ativar o licenciamento de token que foi liberado com uma correção temporária em 15 de setembro de 2015 ou mais recente, remova o comentário da linha `<data key=’user.licensed.by.tokens’ value=’false’/>`. Configure o valor para **true** se você tiver um contrato para usar o licenciamento de token com o Rational License Key Server. Caso contrário, configure o valor como **false**.
      Se você ativar o licenciamento de token, certifique-se de que o Rational License Key Server esteja configurado e que possam ser obtidos tokens suficientes para executar o MobileFirst Server e os aplicativos que ele atende. Caso contrário, o aplicativo de administração MobileFirst Server e o ambiente de tempo de execução não poderão ser executados.
      > **Restrição:** após a decisão ser feita para ativar o licenciamento de token ou não, isso não poderá ser modificado. Se você executar um upgrade com o valor **true** e, posteriormente, outro upgrade com o valor **false**, o segundo upgrade falhará.

    d. Revise a identidade do perfil e o local de instalação. A identidade do perfil e o local da instalação devem corresponder ao que está instalado:
      * Esta linha: `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * E esta linha: `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Para revisar a identidade do perfil e os diretórios de instalação que são conhecidos para o Installation Manager, será possível digitar o comando:
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. Atualize o atributo de versão e configure-o para a versão da correção temporária.
       Por exemplo, se você instalar a correção temporária (8.0.0.0-MFPF-IF20171006-1725), substitua

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      por

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      O Installation Manager não usa somente os repositórios listados no arquivo de instalação, mas também os repositórios instalados em suas preferências. Especificar o atributo de versão no elemento de oferta é opcional. No entanto, ao especificá-lo, você garante que a correção temporária definida é a versão que você pretende instalar. Essa especificação substitui os outros repositórios por correções temporárias que estão listadas nas preferências do Installation Manager.

5. Abra uma sessão com a conta do usuário que é usada na instalação inicial.
    Para aplicar uma atualização, o Installation Manager deve ser executado com a mesma lista de arquivos de registro que são usados na instalação inicial. A lista de Softwares que está instalada e as opções que são usadas durante o momento da instalação são armazenadas nesses arquivos de registro. Se você executar o Installation Manager no modo de administrador, os arquivos de registro serão instalados no nível do sistema. Na pasta `/var` no UNIX ou no Linux. Na pasta `c:\ProgramData` no Windows. O local é independente do usuário que executa o Installation Manager (embora a raiz seja necessária no UNIX e no Linux). No entanto, se você executar o Installation Manager no modo de usuário único, os arquivos de registro serão armazenados por padrão no diretório inicial do usuário.

6. Execute o comando
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   em que,
   * <responseFile> é o arquivo XML editado na etapa 4.
   * *-log /tmp/installwl.log* é opcional. Isso especifica um arquivo de log para a saída do Installation Manager.
   * *-acceptLicense* é obrigatório. Isso significa que você aceita os termos de licença do IBM MobileFirst Platform Foundation V8.0.0. Sem essa opção, o Installation Manager não pode continuar com a atualização.

## Etapas seguintes
{: #next-steps }

[Atualizando o servidor de aplicativos](../appserver-update)
