---
layout: tutorial
title: Referência de instalação
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Informações de referência sobre tarefas Ant e arquivos de amostra de configuração para a instalação do {{ site.data.keys.mf_server_full }}, {{ site.data.keys.mf_app_center_full }} e {{ site.data.keys.mf_analytics_full }}.

#### Ir para
{: #jump-to }
* [Referência de tarefa Ant configuredatabase](#ant-configuredatabase-task-reference)
* [Tarefas Ant para instalação de artefatos do {{ site.data.keys.mf_console }}, do {{ site.data.keys.mf_server }}, administração do {{ site.data.keys.mf_server }} e serviços de atualização em tempo real](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tarefas Ant para instalação do serviço de push do {{ site.data.keys.mf_server }}](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Tarefas Ant para instalação do Application Center](#ant-tasks-for-installation-of-application-center)
* [Tarefas Ant para instalação do {{ site.data.keys.mf_analytics }}](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [Bancos de dados de tempo de execução internos](#internal-runtime-databases)
* [Arquivos de configuração de amostra](#list-of-sample-configuration-files)
* [Arquivos de configuração de amostra para o {{ site.data.keys.mf_analytics }}](#sample-configuration-files-for-mobilefirst-analytics)

## Referência de tarefa Ant configuredatabase
{: #ant-configuredatabase-task-reference }
Informações de referência para a tarefa Ant configuredatabase. Essas informações de referência são somente para bancos de dados relacionais. Elas não se aplicam ao Cloudant.

A tarefa Ant **configuredatabase** cria os bancos de dados relacionais que são usados pelo serviço de administração do {{ site.data.keys.mf_server }}, pelo serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, pelo serviço de push do {{ site.data.keys.mf_server }}, pelo tempo de execução do {{ site.data.keys.product_adj }} e pelos serviços do Application Center. Essa tarefa Ant configura um banco de dados relacional por meio das ações a seguir:

* Verifica se existem tabelas do {{ site.data.keys.product_adj }} e as cria se for necessário.
* Se as tabelas existirem para uma versão mais antiga do {{ site.data.keys.product }}, migre-as para a versão atual.
* Se as tabelas existirem para a versão atual do {{ site.data.keys.product }}, não é necessário fazer nada.

Além disso, se alguma das condições a seguir for atendida:

* O tipo de DBMS for Derby.
* Um elemento interno `<dba>` está presente.
* O tipo de DBMS for DB2, e o usuário especificado tiver as permissões para criar bancos de dados.

Então, a tarefa poderá ter os efeitos a seguir:

* Criar o banco de dados, se necessário (exceto Oracle 12c e Cloudant).
* Criar um usuário, se necessário, e conceder a ele direitos de acesso de usuário ao banco de dados.

> **Nota:** A tarefa Ant configuredatabase não terá efeito se você usá-la com o Cloudant.

### Atributos e elementos para a tarefa configuredatabase
{: #attributes-and-elements-for-configuredatabase-task }

A tarefa **configuredatabase** tem os atributos a seguir:

| Atributo | Descrição (Description) | Necessário | Padrão |
|-----------|-------------|----------|---------|
| kind      | O tipo de banco de dados: no {{ site.data.keys.mf_server }}: MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin ou push. No Application Center: applicationCenter. | Sim | Nenhuma |
| includeConfigurationTables | Para especificar se deve ou não executar operações de banco de dados no serviço de atualização em tempo real e no serviço de administração ou somente no serviço de administração. O valor é verdadeiro ou falso. |  No | verdadeiro |
| execute | Para especificar se deve ou não executar a tarefa Ant configuredatabase. O valor é verdadeiro ou falso. | No | verdadeiro |

#### kind
{: #kind }
{{ site.data.keys.product }} O suporta quatro tipos de banco de dados: o tempo de execução do {{ site.data.keys.product_adj }} usa o banco de dados **MobileFirstRuntime**. O serviço de administração do {{ site.data.keys.mf_server }} usa o banco de dados **MobileFirstAdmin**. O serviço Live Update do {{ site.data.keys.mf_server }} usa o banco de dados **MobileFirstConfig**. Por padrão, ele é criado com o tipo **MobileFirstAdmin**. O serviço de push do {{ site.data.keys.mf_server }} usa o banco de dados **push**. O Application Center usa o banco de dados **ApplicationCenter**.

#### includeConfigurationTables
{: #includeconfigurationtables }
O atributo **includeConfigurationTables** pode ser usado somente quando o atributo **kind** for **MobileFirstAdmin**. O valor válido pode ser true ou false. Quando esse atributo for configurado como verdadeiro, a tarefa **configuredatabase** executará operações do banco de dados do serviço de administração e no banco de dados de serviço Live Update em uma única execução. Quando esse atributo for configurado como falso, a tarefa **configuredatabase** executará operações do banco de dados somente no banco de dados do serviço de administração.

#### execute
{: #execute }
O atributo **execute** ativa ou desativa a execução da tarefa Ant **configuredatabase**. O valor válido pode ser true ou false. Quando esse atributo for configurado como falso, a tarefa **configuredatabase** não executará nenhuma operação de configuração ou do banco de dados.

A tarefa **configuredatabase** suporta os elementos a seguir:

| Elemento             | Descrição	                | Conta |
|---------------------|-----------------------------|-------|
| `<derby>`           | Os parâmetros para Derby.   | 0..1  |
| `<db2>`             |	Os parâmetros para DB2.     | 0..1  |
| `<mysql>`           |	Os parâmetros para MySQL.   | 0..1  |
| `<oracle>`          |	Os parâmetros para Oracle.  | 0..1  |
| `<driverclasspath>` | O caminho de classe do driver JDBC. | 0..1  |

Para cada tipo de banco de dados, é possível usar um elemento `<property>` para especificar uma propriedade da conexão JDBC para acesso ao banco de dados. O elemento `<property>` possui os atributos a seguir:

| Atributo | Descrição (Description)                | Necessário | Padrão |
|-----------|----------------------------|----------|---------|
| Nome      | O nome da propriedade.	 | Sim      | Nenhuma    |
| valor	    | O valor da propriedade.| Sim	    | Nenhuma    |   

#### Apache Derby
{: #apache-derby }
O elemento `<derby>` possui os atributos a seguir:

| Atributo | Descrição (Description)                                | Necessário | Padrão                                                                      |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| banco de dados  | O nome do banco de dados.                         | Não	    | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo.             |
| datadir   | O diretório que contém os bancos de dados. | Sim      | Nenhuma                                                                         |
| esquema	| O nome do esquema.                           | No       | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH ou APPCENTER, dependendo do tipo. |

O elemento `<derby>` suporta o elemento a seguir:

| Elemento      | Descrição (Description)                     | Conta   |
|--------------|---------------------------------|---------|
| `<property>` | A propriedade da conexão JDBC.   | 0..∞    |

Para as propriedades disponíveis, consulte
[Configurando atributos para a URL de conexão com o banco de dados](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html).

#### DB2
{: #db2 }
O elemento `<db2>` possui os atributos a seguir:

| Atributo | Descrição (Description)                            | Necessário | Padrão |
|-----------|----------------------------------------|----------|---------|
| banco de dados  | O nome do banco de dados.                     | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo. |
| servidor    | O nome do host do servidor de banco de dados.	 | Sim      | Nenhuma  |
| porta      | A porta no servidor de banco de dados.       | Não	    | 50000 |
| usuário      | O nome do usuário para acessar bancos de dados. | Sim	    | Nenhuma  |
| Senha  | A senha para acessar bancos de dados.	 | Não	    | Consultado interativamente |
| concreto  | O nome da instância do DB2.          | Não	    | Depende do servidor |
| esquema    | O nome do esquema.                       | Não	    | Depende do usuário   |

Para obter informações adicionais sobre contas do usuário do DB2, consulte [Visão geral do modelo de segurança do DB2](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
O elemento `<db2>` suporta os elementos a seguir:

| Elemento      | Descrição (Description)                             | Conta   |
|--------------|-----------------------------------------|---------|
| `<property>` | A propriedade da conexão JDBC.           | 0..∞    |
| `<dba>`      | As credenciais do administrador de banco de dados. | 0..1    |

Para as propriedades disponíveis, consulte [Propriedades do IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).  
O elemento interno `<dba>` especifica as credenciais para os administradores de base de dados. Esse elemento possui os atributos a seguir:

| Atributo | Descrição (Description)                            | Necessário | Padrão |
|-----------|----------------------------------------|----------|---------|
| usuário      | O nome do usuário para acessar o banco de dados.  | Sim      | Nenhuma    |
| Senha  | A senha para acessar o banco de dados.    | Não	    | Consultado interativamente |

O usuário que é especificado em um elemento `<dba>` deve ter o privilégio do DB2 SYSADM ou SYSCTRL. Para obter mais informações, consulte [Visão geral de autoridades](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html).

O elemento `<driverclasspath>` deve conter os arquivos JAR para o driver JDBC do DB2 e para a licença associada. É possível recuperar esses arquivos de uma das seguintes formas:

* Faça download dos drivers JDBC DB2 da página [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866)
* Ou busque o arquivo **db2jcc4.jar** e seus arquivos **db2jcc_license_*.jar** associados a partir do diretório **DB2_INSTALL_DIR/java** no servidor DB2.

Não é possível especificar detalhes de alocações de tabela, como o espaço de tabela, usando a tarefa Ant. Para controlar o espaço de tabela, deve-se usar as instruções do manual na seção [Requisitos do banco de dados DB2 e do usuário](../prod-env/databases/#db2-database-and-user-requirements).

#### MySQL
{: #mysql }
O status de proteção do elemento `<mysql>` possui os atributos a seguir:

| Atributo | Descrição (Description)                            | Necessário | Padrão |
|-----------|----------------------------------------|----------|---------|
| banco de dados	| O nome do banco de dados.	                 | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo. |
| servidor	| O nome do host do servidor de banco de dados.	 | Sim	    | Nenhuma |
| porta	    | A porta no servidor de banco de dados.	     | Não	    | 3306 |
| usuário	    | O nome do usuário para acessar bancos de dados. | Sim	    | Nenhuma |
| senha	| A senha para acessar bancos de dados.	 | Não	    | Consultado interativamente |

Para obter mais informações sobre contas do usuário do MySQL, consulte [Gerenciamento de conta do usuário do MySQL](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).  
O elemento `<mysql>` suporta os elementos a seguir:

| Elemento      | Descrição (Description)                                      | Conta |
|--------------|--------------------------------------------------|-------|
| `<property>` | A propriedade da conexão JDBC.                    | 0..∞  |
| `<dba>`      | As credenciais do administrador de banco de dados.          | 0..1  |
| `<client>`   | O host tem permissão para acessar o banco de dados. | 0..∞  |

Para as propriedades disponíveis, consulte [Nomes de classe de driver/origem de dados, sintaxe de URL e propriedades de configuração para Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).  
O elemento interno `<dba>` especifica as credenciais do administrador de base de dados. Esse elemento possui os atributos a seguir:

| Atributo | Descrição (Description)                            | Necessário | Padrão |
|-----------|----------------------------------------|----------|---------|
| usuário	    | O nome do usuário para acessar bancos de dados. | Sim	    | Nenhuma |
| senha	| A senha para acessar bancos de dados.	 | Não	    | Consultado interativamente |

O usuário que é especificado em um elemento `<dba>` deve ser uma conta de superusuário do MySQL. Para obter mais informações, consulte [Protegendo contas iniciais do MySQL](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html).

Cada elemento `<client>` especifica um computador cliente ou um curinga para computadores clientes. Esses computadores têm permissão para se conectarem ao banco de dados. Esse elemento possui os atributos a seguir:

| Atributo | Descrição (Description)                                                              | Necessário | Padrão |
|-----------|--------------------------------------------------------------------------|----------|---------|
| nome do host	| O nome do host, endereço IP ou modelo simbólico com % como um item temporário. | Sim	  | Nenhuma    |

Para obter informações adicionais sobre a sintaxe de nome do host, consulte [Especificando nomes de contas](http://dev.mysql.com/doc/refman/5.5/en/account-names.html).

O elemento `<driverclasspath>` deve conter um arquivo JAR do MySQL Connector/J. É possível fazer download desse arquivo a partir da página [Download do Connector/J](http://www.mysql.com/downloads/connector/j/).

Como alternativa, é possível usar o elemento `<mysql>` com os atributos a seguir:

| Atributo | Descrição (Description)                            | Necessário | Padrão               |
|-----------|----------------------------------------|----------|-----------------------|
| URL       | A URL de conexão com o banco de dados.	         | Sim      | Nenhuma                  |
| usuário	    | O nome do usuário para acessar bancos de dados. | Sim      | Nenhuma                  |
| senha	| A senha para acessar bancos de dados.	 | No       | Consultado interativamente |

> `Nota:` se você especificar o banco de dados com os atributos alternativos, esse banco de dados deverá existir, a conta do usuário deverá existir e o banco de dados já deverá estar acessível ao usuário. Nesse caso, a tarefa **configuredatabase** não tenta criar o banco de dados ou o usuário, nem tenta conceder acesso ao usuário. A tarefa **configuredatabase** assegura apenas que o banco de dados tem as tabelas necessárias para a atual versão do {{ site.data.keys.mf_server }}. Não é necessário especificar os elementos internos `<dba>` ou `<client>`.

#### Oracle
{: #oracle }
O status de proteção do elemento `<oracle>` possui os atributos a seguir:

| Atributo      | Descrição (Description)                                                              | Necessário | Padrão |
|----------------|--------------------------------------------------------------------------|----------|---------|
| banco de dados       | O nome do banco de dados ou nome do serviço Oracle. **Nota:** Você deve sempre usar um nome do serviço para se conectar a um banco de dados PDB. | No | ORCL |
| servidor	     | O nome do host do servidor de banco de dados.                                    | Sim      | Nenhuma |
| porta	         | A porta no servidor de banco de dados.                                         | No       | 1521 |
| usuário	         | O nome do usuário para acessar bancos de dados. Consulte a nota sob esta tabela.	| Sim      | Nenhuma |
| senha	     | A senha para acessar bancos de dados.                                    | No       | Consultado interativamente |
| sysPassword	 | A senha para o usuário SYS.                                           | No       | Consultado interativamente se o banco de dados ainda não existir |
| systemPassword | A senha para o usuário SYSTEM.                                        | No       | Consultado interativamente se o banco de dados ou o usuário ainda não existir |

> `Nota:` Para o atributo do usuário, use preferencialmente um nome do usuário em letras maiúsculas. Geralmente os nomes de usuário do Oracle estão em letras maiúsculas. Ao contrário de outras ferramentas de banco de dados, a tarefa Ant **configuredatabase** não converte letras minúsculas em letras maiúsculas no nome do usuário. Se a tarefa Ant  **configuredatabase** falhar ao se conectar ao banco de dados, tente inserir o valor para o atributo **user** em letras maiúsculas.

Para obter mais informações sobre contas do usuário do Oracle, consulte
[Visão geral dos métodos de autenticação](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).  
O elemento `<oracle>` suporta os elementos a seguir:

| Elemento      | Descrição (Description)                                      | Conta |
|--------------|--------------------------------------------------|-------|
| `<property>` | A propriedade da conexão JDBC.                    | 0..∞  |
| `<dba>`      | As credenciais do administrador de banco de dados.          | 0..1  |

Para obter mais informações sobre propriedades de conexão disponíveis, consulte [Classe OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html).  
O elemento interno `<dba>` especifica as credenciais do administrador de base de dados. Esse elemento possui os atributos a seguir:

| Atributo      | Descrição (Description)                                                              | Necessário | Padrão |
|----------------|--------------------------------------------------------------------------|----------|---------|
| usuário	         | O nome do usuário para acessar bancos de dados. Consulte a nota sob esta tabela.	| Sim      | Nenhuma    |
| senha	     | A senha para acessar bancos de dados.                                    | No       | Consultado interativamente |

O elemento `<driverclasspath>` deve conter um arquivo JAR do driver JDBC Oracle. É possível fazer download de drivers JDBC Oracle do [JDBC, SQLJ, Oracle JPublisher e Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

Não é possível especificar detalhes de alocação de tabela, como o espaço de tabela, usando a tarefa Ant. Para controlar o espaço de tabela, é possível criar a conta do usuário manualmente e designar a ela um espaço de tabela padrão antes da execução da tarefa Ant. Para controlar outros detalhes, deve-se usar as instruções do manual na seção [Requisitos do banco de dados Oracle e do usuário](../prod-env/databases/#oracle-database-and-user-requirements).

| Atributo | Descrição (Description)                            | Necessário | Padrão               |
|-----------|----------------------------------------|----------|-----------------------|
| URL       | A URL de conexão com o banco de dados.	         | Sim      | Nenhuma                  |
| usuário	    | O nome do usuário para acessar bancos de dados. | Sim      | Nenhuma                  |
| senha	| A senha para acessar bancos de dados.	 | No       | Consultado interativamente |

> **Nota:** se você especificar o banco de dados com os atributos alternativos, esse banco de dados deve existir, a conta do usuário deve existir e o banco de dados já deve estar acessível ao usuário. Nesse caso, a tarefa não tenta criar o banco de dados ou o usuário, nem tenta conceder acesso ao usuário. A tarefa **configuredatabase** assegura apenas que o banco de dados tem as tabelas necessárias para a atual versão do {{ site.data.keys.mf_server }}. Não é necessário especificar o elemento interno `<dba>`.

## Tarefas Ant para instalação do {{ site.data.keys.mf_console }}, artefatos do {{ site.data.keys.mf_server }}, administração do {{ site.data.keys.mf_server }} e serviços de atualização em tempo real
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
As tarefas Ant **installmobilefirstadmin**, **updatemobilefirstadmin** e **uninstallmobilefirstadmin** são fornecidas para a instalação do {{ site.data.keys.mf_console }}, componente de artefatos, serviço de administração e serviço de atualização em tempo real.

### efeitos da Tarefa
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
A tarefa Ant **installmobilefirstadmin** configura um servidor de aplicativos para executar os arquivos WAR dos serviços de administração e atualização em tempo real como aplicativos da web e, opcionalmente, instalar o {{ site.data.keys.mf_console }}. Esta tarefa tem os seguintes efeitos:

* Declara o aplicativo da web do serviço de administração na raiz de contexto especificada, por padrão, /mfpadmin.
* Declara o aplicativo da web de serviço de atualização em tempo real em uma raiz de contexto derivada da raiz de contexto especificada do serviço de administração. Por padrão, /mfpadminconfig.
* Para os bancos de dados relacionais, declara origens de dados e no perfil completo do WebSphere Application Server, provedores JDBC para os serviços de administração.
* Implementa o serviço de administração e o serviço de atualização em tempo real no servidor de aplicativos.
* Opcionalmente, declara o {{ site.data.keys.mf_console }} como um aplicativo da web na raiz de contexto especificada, por padrão, /mfpconsole. Se a instância do {{ site.data.keys.mf_console }} estiver especificada, a tarefa Ant declarará a entrada de ambiente JNDI apropriada para se comunicar com o serviço de gerenciamento correspondente. Por exemplo,

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* Opcionalmente, declara o aplicativo da web de artefatos do {{ site.data.keys.mf_server }} na raiz de contexto especificada /mfp-dev-artifacts quando o {{ site.data.keys.mf_console }} é instalado.
* Configura as propriedades de configuração para o serviço de administração usando entradas de ambiente JNDI. Essas entradas do ambiente JNDI também fornecem algumas informações adicionais sobre a topologia do servidor de aplicativos, por exemplo se a topologia é uma configuração independente, um cluster, ou em um server farm.
* Opcionalmente, configura usuários que são mapeados para as funções usadas pelo {{ site.data.keys.mf_console }} e aplicativos da web de serviços de administração e atualização em tempo real.
* Configura o servidor de aplicativos para utilização do JMX.
* Opcionalmente, configura a comunicação com o serviço de push do {{ site.data.keys.mf_server }}.
* Opcionalmente, configura as entradas de ambiente JNDI do MobileFirst para configurar o servidor de aplicativos como um membro de server farm para a parte de administração do {{ site.data.keys.mf_server }}.

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
A tarefa Ant **updatemobilefirstadmin** atualiza um aplicativo da web {{ site.data.keys.mf_server }} já configurado em um servidor de aplicativos. Esta tarefa tem os seguintes efeitos:

* Atualiza o arquivo WAR do serviço de administração. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.
* Atualiza o arquivo WAR do serviço de atualização em tempo real. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.
* Atualiza o arquivo WAR do {{ site.data.keys.mf_console }}. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.
A tarefa não altera a configuração do servidor de aplicativos, ou seja, a configuração do aplicativo da Web, origens de dados, as entradas do ambiente JNDI, os mapeamentos de user-to-função, e configuração JMX.

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
A tarefa Ant **uninstallmobilefirstadmin** desfaz os efeitos de uma execução anterior de installmobilefirstadmin. Esta tarefa tem os seguintes efeitos:

* Remove a configuração do aplicativo da web de serviço de administração com a raiz de contexto especificada. Como conseqüência, a tarefa também remove as configurações que foram incluídos manualmente para esse aplicativo.
* Remove os arquivos WAR dos serviços de administração e atualização em tempo real e o {{ site.data.keys.mf_console }} do servidor de aplicativos como uma opção.
* Para o DBMS relacional, remove as origens de dados e no Perfil completo do WebSphere Application Server, os provedores JDBC para os serviços de administração e de atualização em tempo real.
* Para o DBMS relacional, remove os drivers de banco de dados que foram usados pelos serviços de administração e atualização em tempo real do servidor de aplicativos.
* Ele remove o ambiente JNDI entradas associadas.
* No WebSphere Application Server Liberty e no Apache Tomcat, remove os usuários configurados pela chamada installmobilefirstadmin.
* Ele remove a configuração JMX.

### Atributos e Elementos
{: #attributes-and-elements }
As tarefas Ant **installmobilefirstadmin**, **updatemobilefirstadmin** e **uninstallmobilefirstadmin** têm os seguintes atributos:

| Atributo         | Descrição (Description)                                                              | Necessário | Padrão |
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | O prefixo comum para URLs para o serviço de administração para obter informações sobre ambientes de tempo de execução do {{ site.data.keys.product_adj }}, aplicativos e adaptadores. | No | /mfpadmin |
| ID                | Para distinguir diferentes implementações.              | No | Esvaziar |
| environmentId     | Para distinguir diferentes ambientes do {{ site.data.keys.product_adj }}. | No | Esvaziar |
| servicewar        | O arquivo WAR para o serviço de administração.       | No | O arquivo mfp-admin-service.war está no mesmo diretório que o arquivo mfp-ant-deployer.jar. |
| shortcutsDir      | O diretório no qual colocar atalhos.            | No | Nenhuma |
| wasStartingWeight | A ordem inicial para o WebSphere Application Server. valores mais baixos primeiro início. | No | 1 |

#### contextroot e id
{: #contextroot-and-id }
Os atributos **contextroot** e **id** distinguem diferentes implementações do {{ site.data.keys.mf_console }} e serviço de administração.

Em ambientes de perfis Liberty do WebSphere Application Server e do Tomcat, o parâmetro contextroot é suficiente para esse propósito. Em ambientes de Perfil completo do WebSphere Application Server, o atributo id é usado em substituição. Sem esse atributo id, dois arquivos WAR com as mesmas raízes de contexto podem entrar em conflito e esses arquivos não seriam implementados.

#### environmentId
{: #environmentid }
Use o atributo **environmentId** para diferenciar diversos ambientes, cada um consistindo em serviços administrativos do {{ site.data.keys.mf_server }} e aplicativos da web de tempo de execução {{ site.data.keys.product_adj }}, que devem operar independentemente. Por exemplo, com essa opção você pode hospedar um ambiente de teste, um ambiente de pré-produção, e um ambiente de produção no mesmo servidor ou no mesmo WebSphere Application Server Network Deployment da célula. Esse atributo environmentId cria um sufixo que é incluído em nomes de MBean que o serviço de administração e os projetos de tempo de execução do {{ site.data.keys.product_adj }} usam quando se comunicam por meio de Java Management Extensions (JMX).

#### servicewar
{: #servicewar }
Use o atributo **servicewar** para especificar um diretório diferente para o arquivo WAR do serviço de administração. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

#### shortcutsDir
{: #shortcutsdir }
O atributo **shortcutsDir** especifica onde colocar atalhos para o {{ site.data.keys.mf_console }}. Se você definir esse atributo, você pode incluir os seguintes arquivos para esse diretório:

* **mobilefirst-console.url** - esse arquivo é um atalho do Windows. Ele abre o {{ site.data.keys.mf_console }} em um navegador.
* **mobilefirst-console.sh**- esse arquivo é um shell script UNIX e abre o {{ site.data.keys.mf_console }} em um navegador.
* **mobilefirst-admin-service.url** - esse arquivo é um atalho do Windows. Ele é aberto em um navegador e chama um serviço REST que retorna uma lista dos projetos do {{ site.data.keys.product_adj }} que podem ser gerenciados em formato JSON. Para cada projeto do {{ site.data.keys.product_adj }} listado, também estão disponíveis alguns detalhes sobre seus artefatos, como o número de aplicativos, o número de adaptadores, o número de dispositivos ativos e o número de dispositivos desatribuídos. A lista também indica se o tempo de execução do projeto do  {{ site.data.keys.product_adj }} está em execução ou inativo.
* **mobilefirst-admin-service.sh** - esse arquivo é um shell script UNIX que fornece a mesma saída que o arquivo **mobilefirst-admin-service.url**.

#### wasStartingWeight
{: #wasstartingweight }
Use o atributo **wasStartingWeight** para especificar um valor que é usado no WebSphere Application Server como um weight para assegurar que uma ordem inicial seja respeitada. Como resultado do valor da ordem inicial, o aplicativo da web de serviço de administração é implementado e iniciado antes de quaisquer outros projetos de tempo de execução do {{ site.data.keys.product_adj }}. Se projetos do {{ site.data.keys.product_adj }} forem implementados ou iniciados antes do aplicativo da web, a comunicação do JMX não será estabelecida e o tempo de execução não poderá ser sincronizado com o banco de dados de serviço de administração, nem manipular solicitações do servidor.

As tarefas Ant **installmobilefirstadmin**, **updatemobilefirstadmin** e **uninstallmobilefirstadmin** suportam os seguintes elementos:

| Elemento               | Descrição (Description)                                      | Conta |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | O servidor de aplicativos.                          | 1     |
| `<configuration>`     | O serviço de atualização em tempo real.	                       | 1     |
| `<console>`           | O console de administração.                      | 0..1  |
| `<database>`          | Os bancos de dados.                                   | 1     |
| `<jmx>`               | Para ativar Java Management Extensions.	           | 1     |
| `<property>`          | As propriedades.	                               | 0..   |
| `<push>`              | O serviço de push.	                               | 0..1  |
| `<user>`              | O usuário deve ser mapeado para uma função de segurança.	       | 0..   |

### Para especificar um {{ site.data.keys.mf_console }}
{: #to-specify-a-mobilefirst-operations-console }
O elemento `<console>` coleta informações para customizar a instalação do {{ site.data.keys.mf_console }}. Esse elemento possui os atributos a seguir:

| Atributo         | Descrição (Description)                                                               | Necessário | Padrão     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | O URI do {{ site.data.keys.mf_console }}.                            | No       | /mfpconsole |
| Instalar           | Para indicar se o {{ site.data.keys.mf_console }} deve ser instalado. | No       | Sim         |
| warfile           | O arquivo WAR do console.	                                                    |No        | O arquivo mfp-admin-ui.war está no mesmo diretório que o arquivo themfp-ant-deployer.jar. |

O elemento `<console>` suporta o elemento a seguir:

| Elemento               | Descrição (Description)                                      | Conta |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | Os artefatos do {{ site.data.keys.mf_server }}.                | 0..1  |
| `<property>`	        | As propriedades.	                               | 0..   |

O elemento `<artifacts>` possui os atributos a seguir:

| Atributo         | Descrição (Description)                                                               | Necessário | Padrão     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| Instalar           | Para indicar se o componente de artefatos deve ser instalado.            | No       | verdadeiro        |
| warFile           | O arquivo WAR de artefatos.                                                   | No       | O arquivo mfp-dev-artifacts.war está no mesmo diretório que o arquivo mfp-ant-deployer.jar |

Usando esse elemento, é possível definir suas próprias propriedades JNDI ou substituir o valor padrão de propriedades JNDI fornecidas pelo serviço de administração e arquivos WAR do {{ site.data.keys.mf_console }}.

O elemento `<property>` especifica uma propriedade de implementação a ser definida no servidor de aplicativos. Possui os seguintes atributos:

| Atributo  | Descrição (Description)                | Necessário | Padrão |
|------------|----------------------------|----------|---------|
| Nome       | O nome da propriedade.  | Sim      | Nenhuma    |
| valor	     | O valor da propriedade. |	Sim      | Nenhuma    |

Usando esse elemento, é possível definir suas próprias propriedades JNDI ou substituir o valor padrão de propriedades JNDI fornecidas pelo serviço de administração e arquivos WAR do {{ site.data.keys.mf_console }}.

Para obter mais informações sobre as propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Para especificar um servidor de aplicativos
{: #to-specify-an-application-server }
Use o elemento `<applicationserver>` para definir os parâmetros que dependem do servidor de aplicativos subjacente. O elemento `<applicationserver>` suporta os elementos a seguir.

| Elemento                                   | Descrição (Description)                                      | Conta |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` ou `<was>` | Os parâmetros para o WebSphere Application Server. <br/><br/>O elemento `<websphereapplicationserver>` (ou `was>` em seu formato abreviado) denota uma instância do WebSphere Application Server. O perfil completo do WebSphere Application Server (Base e Network Deployment) é suportado, portanto, é o WebSphere Application Server Liberty Core e o WebSphere Application Server Liberty Network Deployment.               | 0..1  |
| `<tomcat>`                                | Os parâmetros para Apache Tomcat.	               | 0..1  |

Os atributos e os elementos internos desses elementos são descritos nas tabelas de [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
No entanto, para o elemento interno do elemento `<was>` para Liberty Collective, consulte a tabela a seguir:

| Elemento                  | Descrição (Description)                      | Conta |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | Um controlador do Liberty Collective. |	0..1  |

O elemento `<collectiveController>` possui os atributos a seguir:

| Atributo                | Descrição (Description)                            | Necessário | Padrão |
|--------------------------|----------------------------------------|----------|---------|
| serverName               | O nome do controlador coletivo.	| Sim      | Nenhuma    |
| controllerAdminName      | O nome do usuário administrativo definido no controlador coletivo. É o mesmo usuário que o usado para associar membros ao Collective.                                                         | Sim      | Nenhuma    |
| controllerAdminPassword  | A senha do usuário administrativo.	    | Sim      | Nenhuma    |
| createControllerAdmin    | Para indicar se o usuário administrativo deve ser criado no registro básico do controlador coletivo. Os valores possíveis são true ou false.                                                              | Não	   | verdadeiro    |

### Para especificar a configuração de serviço de atualização em tempo real
{: #to-specify-the-live-update-service-configuration }
Use o elemento `<configuration>` para definir os parâmetros que dependem do serviço de atualização em tempo real. O elemento `<configuration>` possui os atributos a seguir.

| Atributo                | Descrição (Description)                                                    | Necessário | Padrão |
|--------------------------|----------------------------------------------------------------|----------|---------|
| Instalar                  | Para indicar se o serviço de atualização em tempo real deve ser instalado.	| Sim | verdadeiro |
| configAdminUser	       | O administrador do serviço de atualização em tempo real.	                | Não. No entanto, é necessário para uma topologia de server farm. |Se não estiver definido, um usuário será gerado. Em uma topologia de server farm, o nome do usuário deve ser o mesmo
para todos os membros do farm. |
| configAdminPassword      | A senha do administrador do usuário do serviço de atualização em tempo real.       | Se um usuário for especificado para **configAdminUser**. | Nenhum(a). Em uma topologia de server farm, a senha deve ser a mesma para todos
os membros do farm. |
| createConfigAdminUser	   | Para indicar se deve-se criar um usuário administrador no registro básico do servidor de aplicativos, caso ele esteja ausente. | No | verdadeiro |
| warFile                  | O arquivo WAR do serviço de atualização em tempo real.	                            | No         | O arquivo mfp-live-update.war está no mesmo diretório que o arquivo mfp-ant-deployer.jar. |

O elemento `<configuration>` suporta os elementos a seguir:

| Elemento      | Descrição (Description)                           | Conta |
|--------------|---------------------------------------|-------|
| `<user>`     | O usuário para o serviço de atualização em tempo real. | 0..1  |
| `<property>` | As propriedades.	                   | 0..   |

O elemento `<user>` coleta os parâmetros sobre um usuário para incluir em uma determinada função de segurança para um aplicativo.

| Atributo   | Descrição (Description)                                                             | Necessário | Padrão |
|-------------|-------------------------------------------------------------------------|----------|---------|
| função	      | Uma função de segurança válida para o aplicativo. Valor possível: configadmin.	| Sim      | Nenhuma    |
| nome	      | O nome de usuário.	                                                        | Sim      | Nenhuma    |
| senha	  | A senha, caso o usuário precise ser criado.	                        | No       | Nenhuma    |

Após ter definido os usuários usando o elemento `<user>`, é possível mapeá-los para qualquer uma das funções a seguir para autenticação no {{site.data.keys.mf_console }}: `configadmin`.

Para obter informações adicionais sobre quais autorizações são implícitas pelas funções específicas, consulte [Configurando a autenticação do usuário para   {{ site.data.keys.mf_server }}](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration) administração do.

> **Dica:** Se o usuário existir em um diretório LDAP externo, configure somente os atributos **role** e **name**, mas não defina nenhuma senha.

O elemento `<property>` especifica uma propriedade de implementação a ser definida no servidor de aplicativos. Possui os seguintes atributos:

| Atributo  | Descrição (Description)                | Necessário | Padrão |
|------------|----------------------------|----------|---------|
| Nome       | O nome da propriedade.  | Sim      | Nenhuma    |
| valor	     | O valor da propriedade. |	Sim      | Nenhuma    |

Usando esse elemento, é possível definir suas próprias propriedades JNDI ou substituir o valor padrão de propriedades JNDI fornecidas pelo serviço de administração e arquivos WAR do {{ site.data.keys.mf_console }}. Para obter mais informações sobre as propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de administração do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Para especificar um servidor de aplicativos
{: #to-specify-an-application-server-1 }
Use o elemento `<applicationserver>` para definir os parâmetros que dependem do servidor de aplicativos subjacente. O elemento `<applicationserver>` suporta os elementos a seguir:

| Elemento      | Descrição (Description)                                              | Conta |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` ou `<was>`	| Os parâmetros para o WebSphere Application Server.<br/><br/>O elemento <websphereapplicationserver> (ou <was> em seu formato abreviado) denota uma instância do WebSphere Application Server. O perfil completo do WebSphere Application Server (Base e Network Deployment) é suportado, portanto, é o WebSphere Application Server Liberty Core e o WebSphere Application Server Liberty Network Deployment. | 0..1  |
| `<tomcat>`   | Os parâmetros para Apache Tomcat.                        | 0..1  |

Os atributos e os elementos internos desses elementos são descritos nas tabelas de [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).  
No entanto, para o elemento interno do elemento <was> para Liberty Collective, consulte a seguinte tabela:

| Elemento               | Descrição (Description)                  | Conta |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| Um membro do Liberty
Collective. | 0..1  |

O elemento `<collectiveMember>` possui os atributos a seguir:

| Atributo   | Descrição (Description)                                             | Necessário | Padrão |
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	O nome do membro coletivo.                      | Sim      | Nenhuma    |
| clusterName |	O nome do cluster ao qual o membro coletivo pertence. | Sim	   | Nenhuma    |

> **Nota:** Se os componentes de serviço de push e de tempo de execução forem instalados no mesmo membro coletivo, eles deverão ter o mesmo nome de cluster. Se esses componentes estiverem instalados em membros distintos do mesmo Collective, os nomes de cluster poderão ser diferentes.

### Para especificar Analytics
{: #to-specify-analytics }
O elemento `<analytics>` indica que você deseja conectar o serviço de push do {{site.data.keys.product_adj }} a um serviço {{site.data.keys.mf_analytics }} já instalado. Possui os seguintes atributos:

| Atributo     | Descrição (Description)                                                               | Necessário | Padrão |
|---------------|---------------------------------------------------------------------------|----------|---------|
| instalar	    | Para indicar se deseja conectar o serviço de push ao {{ site.data.keys.mf_analytics }}. | No       | falso   |
| analyticsURL 	| A URL dos serviços {{ site.data.keys.mf_analytics }}.	                            | Sim	   | Nenhuma    |
| username	    | O nome de usuário.	                                                        | Sim	   | Nenhuma    |
| senha	    | A senha.	                                                            | Sim	   | Nenhuma    |
| validar	    | Para validar se o {{ site.data.keys.mf_analytics_console }} está ou não acessível.	| Não	   | verdadeiro    |

**instalar **  
Use o atributo install para indicar que esse serviço de push deve ser conectado e enviar eventos para o {{ site.data.keys.mf_analytics }}. Os valores válidos são true ou false.

**analyticsURL**  
Use o atributo analyticsURL para especificar a URL que é exposta pelo {{ site.data.keys.mf_analytics }}, que recebe dados de análise de dados de entrada.

Por exemplo: `http://<hostname>:<port>/analytics-service/rest`

**nome de usuário**  
Use o atributo nome do usuário para especificar o nome do usuário que será usado se o ponto de entrada de dados para o {{ site.data.keys.mf_analytics }} está
protegido com autenticação básica.

**senha**  
Use o atributo password para especificar a senha que será usada se o ponto de entrada de dados para o {{ site.data.keys.mf_analytics }} está protegido com autenticação básica.

**validar**  
Use o atributo validate para validar se o {{ site.data.keys.mf_analytics_console }} está acessível ou não, e para verificar a autenticação de nome do usuário com uma senha. Os valores possíveis são true ou false.

### Para especificar uma conexão com o banco de dados de serviço de push
{: #to-specify-a-connection-to-the-push-service-database }

O elemento `<database>` coleta os parâmetros que especificam uma declaração de origem de dados em um servidor de aplicativos para acessar o banco de dados de serviço de push.

Deve-se declarar um único banco de dados: `<database kind="Push">`. Você especifica o elemento `<database>` de modo semelhante à tarefa Ant configuredatabase, exceto que o elemento `<database>` não possui os elementos `<dba>` e `<client>`. Ele pode ter elementos `<property>` existentes.

O elemento `<database>` possui os atributos a seguir:

| Atributo     | Descrição (Description)                                     | Necessário | Padrão |
|---------------|-------------------------------------------------|----------|---------|
| kind          | O tipo de banco de dados (Push).	                  | Sim	     | Nenhuma    |
| validar	    | Para validar se o banco de dados está acessível. | No       | verdadeiro    |

O elemento `<database>` suporta os elementos a seguir. Para obter informações adicionais sobre a configuração desses elementos de banco de dados para DBMS relacional, consulte as tabelas de [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento            | Descrição (Description)                                                      | Conta |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | O parâmetro para bancos de dados DB2.	                            | 0..1  |
| <derby>	         | O parâmetro para bancos de dados Apache Derby.	                    | 0..1  |
| <mysql>	         | O parâmetro para bancos de dados MySQL.                               | 0..1  |
| <oracle>	         | O parâmetro para bancos de dados Oracle.	                            | 0..1  |
| <cloudant>	     | O parâmetro para bancos de dados Cloudant.	                        | 0..1  |
| <driverclasspath>	 | O parâmetro para o caminho da classe do driver JDBC (somente DBMS relacional). | 0..1  |

> **Nota:** Os atributos do elemento `<cloudant>` são um pouco diferentes do tempo de execução. Para obter informações adicionais, consulte a tabela a seguir:

| Atributo     | Descrição (Description)                                     | Necessário | Padrão                   |
|---------------|-------------------------------------------------|----------|---------------------------|
| URL           | A URL da conta do Cloudant.                | No       | https://user.cloudant.com |
| usuário          | O nome do usuário da conta do Cloudant.	      | Sim	     | Nenhuma                      |
| Senha      | A senha da conta do Cloudant.	          | Não	     | Consultado interativamente     |
| dbName        | O nome do banco de dados Cloudant. **Importante:** Esse nome do banco de dados deve começar com uma letra minúscula e conter somente caracteres minúsculos (de a a z), dígitos (de 0 a 9), qualquer um dos caracteres _, $ e -.                                | No       | mfp_push_db               |

## Tarefas Ant para instalação do serviço de push do {{ site.data.keys.mf_server }}
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
As tarefas Ant **installmobilefirstpush**, **updatemobilefirstpush** e **uninstallmobilefirstpush** são fornecidas para a instalação do serviço de push.

### efeitos da Tarefa
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
A tarefa Ant **installmobilefirstpush** configura um servidor de aplicativos para executar o arquivo WAR do serviço de push como um aplicativo da web. Essa tarefa tem os seguintes efeitos:
declara o aplicativo da web do serviço de push na raiz de contexto **/imfpush**. A raiz de contexto não pode ser alterada.
Para os bancos de dados relacionais, declara origens de dados, e no Perfil completo do WebSphere Application Server, provedores JDBC para o serviço de push.
Configura as propriedades de configuração para o serviço de push usando entradas de ambiente JNDI. Essas entradas de ambiente JNDI configuram a comunicação OAuth com o servidor de autorizações do {{ site.data.keys.product_adj }}, o {{ site.data.keys.mf_analytics }} e com o Cloudant, caso o Cloudant seja usado.

#### updatemobilefirstpush
{: #updatemobilefirstpush }
A tarefa Ant **updatemobilefirstpush** atualiza um aplicativo da web {{ site.data.keys.mf_server }} já configurado em um servidor de aplicativos. Essa tarefa atualiza o arquivo WAR do serviço de push. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
A tarefa Ant **uninstallmobilefirstpush** desfaz os efeitos de uma execução anterior de **installmobilefirstpush**. Essa tarefa tem os seguintes efeitos:
remove a configuração do aplicativo da web do serviço de push com a raiz de contexto especificada. Como conseqüência, a tarefa também remove as configurações que foram incluídos manualmente para esse aplicativo.
Remove o arquivo WAR do serviço de push do servidor de aplicativos como uma opção.
Para o DBMS relacional, remove as origens de dados e, no Perfil completo do WebSphere Application Server, os provedores JDBC para o serviço de push.
Ele remove o ambiente JNDI entradas associadas.

### Atributos e Elementos
{: #attributes-and-elements-1 }
As tarefas Ant **installmobilefirstpush**, **updatemobilefirstpush** e **uninstallmobilefirstpush** têm os atributos a seguir:

| Atributo | Descrição (Description)                           | Necessário | Padrão     |
|-----------|---------------------------------------|----------|-------------|
| ID        | Para distinguir diferentes implementações.	| Não	   | Esvaziar
| warFile	| O arquivo WAR para o serviço de push.	| Não	   | O arquivo ../PushService/mfp-push-service.war é relativo ao diretório do MobileFirstServer que contém o arquivo mfp-ant-deployer.jar. |

### ID
{: #id }
O atributo **id** distingue diferentes implementações do serviço de push na mesma célula do WebSphere Application Server. Sem esse atributo id, dois arquivos WAR com as mesmas raízes de contexto podem entrar em conflito e esses arquivos não seriam implementados.

### warFile
{: #warfile }
Use o atributo **warFile** para especificar um diretório diferente para o arquivo WAR do serviço de push. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

As tarefas Ant **installmobilefirstpush**, **updatemobilefirstpush** e **uninstallmobilefirstpush** suportam os elementos a seguir:

| Elemento               | Descrição (Description)             | Conta |
|-----------------------|-------------------------|-------|
| `<applicationserver>` | O servidor de aplicativos. | 1     |
| `<analytics>`	        | O Analytics.	      | 0..1  |
| `<authorization>`	    | O servidor de autorizações para autenticar a comunicação com outros componentes do {{ site.data.keys.mf_server }}. | 1 |
| `<database>`	        | Os bancos de dados.	      | 1     |
| `<property>`	        | As propriedades.	      | 0..∞  |

### Para especificar um servidor de autorização
{: #to-specify-the-authorization-server }
O elemento `<authorization>` coleta informações para configurar o servidor de autorizações para a comunicação de autenticação com outros componentes do {{site.data.keys.mf_server }}. Esse elemento possui os atributos a seguir:

| Atributo          | Descrição (Description)                           | Necessário | Padrão     |
|--------------------|---------------------------------------|----------|-------------|
| automática               | Para indicar se a URL do servidor de autorizações é calculada. Os valores possíveis são true ou false.	| Necessário em um cluster ou nó do WebSphere Application Server Network Deployment.   	 | verdadeiro |
| authorizationURL   | A URL do servidor de autorizações.	 | Se o modo não for automático. | A raiz de contexto do tempo de execução no servidor local. |
| runtimeContextRoot | A raiz de contexto do tempo de execução.	     | Não	     | /mfp       |
| pushClientID	     | O ID confidencial do serviço de push no servidor de autorizações.  | Sim | Nenhuma |
| pushClientSecret	 | A senha do cliente confidencial do serviço de push no servidor de autorizações. | Sim | Nenhuma |

#### automática
{: #auto }
Se o valor estiver configurado para true, a URL do servidor de autorizações será calculada automaticamente usando a raiz de contexto do tempo de execução no servidor de aplicativos local. O modo automático não será suportado se você implementar no WebSphere Application Server Network Deployment em um cluster.

#### authorizationURL
{: #authorizationurl }
A URL do servidor de autorizações. Se o servidor de autorizações for o tempo de execução do {{ site.data.keys.product_adj }}, a URL será a URL do tempo de execução. Por exemplo: `http://myHost:9080/mfp`.

#### runtimeContextRoot
{: #runtimecontextroot }
A raiz de contexto do tempo de execução usada para calcular a URL do servidor de autorizações no modo automático.
#### pushClientID
{: #pushclientid }
O ID desta instância de serviço de push como um cliente confidencial do servidor de autorizações. O ID e o segredo devem ser registrados para o servidor de autorizações. Eles podem ser registrados pela tarefa Ant **installmobilefirstadmin** ou a partir do {{ site.data.keys.mf_console }}.

#### pushClientSecret
{: #pushclientsecret }
A chave secreta desta instância de serviço de push como um cliente confidencial do servidor de autorizações. O ID e o segredo devem ser registrados para o servidor de autorizações. Eles podem ser registrados pela tarefa Ant **installmobilefirstadmin** ou a partir do {{ site.data.keys.mf_console }}.

O elemento `<property>` especifica uma propriedade de implementação a ser definida no servidor de aplicativos. Possui os seguintes atributos:

| Atributo  | Descrição (Description)                | Necessário | Padrão |
|------------|----------------------------|----------|---------|
| Nome       | O nome da propriedade.  |	Sim	     | Nenhuma    |
| valor	     | O valor da propriedade. |	Sim	     | Nenhuma    |

Usando esse elemento, é possível definir suas próprias propriedades JNDI ou substituir o valor padrão de propriedades JNDI fornecidas pelo arquivo WAR do serviço de push.

Para obter mais informações sobre as propriedades JNDI, consulte [Lista de propriedades JNDI para o serviço de push do {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

### Para especificar um servidor de aplicativos
{: #to-specify-an-application-server-2 }
Use o elemento `<applicationserver>` para definir os parâmetros que dependem do servidor de aplicativos subjacente. O elemento `<applicationserver>` suporta os elementos a seguir:

| Elemento                               | Descrição (Description)                                      | Conta |
|---------------------------------------|--------------------------------------------------|-------|
| <websphereapplicationserver> ou <was>	| Os parâmetros para o WebSphere Application Server. | O elemento `<websphereapplicationserver>` (ou `<was>` em seu formato abreviado) denota uma instância do WebSphere Application Server. O perfil completo do WebSphere Application Server (Base e Network Deployment) é suportado, portanto, é o WebSphere Application Server Liberty Core e o WebSphere Application Server Liberty Network Deployment. | 0..1 |
| `<tomcat>` | Os parâmetros para Apache Tomcat. | 0..1 |

Os atributos e os elementos internos desses elementos são descritos nas tabelas de [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

No entanto, para o elemento interno do elemento `<was>` para Liberty Collective, consulte a tabela a seguir:

| Elemento              | Descrição (Description)                  | Conta |
|----------------------|------------------------------|-------|
| `<collectiveMember>` | Um membro do Liberty
Collective. |	0..1  |

O elemento `<collectiveMember>` possui os atributos a seguir:

| Atributo   | Descrição (Description)                        | Necessário | Padrão |
|-------------|------------------------------------|----------|---------|
| serverName  | O nome do membro coletivo. | Sim      | Nenhuma    |
| clusterName |	O nome do cluster ao qual o membro coletivo pertence. | Sim | Nenhuma |

> **Nota:** Se os componentes de serviço de push e de tempo de execução forem instalados no mesmo membro coletivo, eles deverão ter o mesmo nome de cluster. Se esses componentes estiverem instalados em membros distintos do mesmo Collective, os nomes de cluster poderão ser diferentes.

### Para especificar Analytics
{: #to-specify-analytics-1 }
O elemento `<analytics>` indica que você deseja conectar o serviço de push do {{site.data.keys.product_adj }} a um serviço {{site.data.keys.mf_analytics }} já instalado. Possui os seguintes atributos:

| Atributo    | Descrição (Description)                        | Necessário | Padrão |
|--------------|------------------------------------|----------|---------|
| instalar	   | Para indicar se deseja conectar o serviço de push ao {{ site.data.keys.mf_analytics }}. | No | falso |
| analyticsURL | A URL dos serviços {{ site.data.keys.mf_analytics }}. | Sim | Nenhuma |
| username	   | O nome de usuário. | Sim | Nenhuma |
| senha	   | A senha. | Sim | Nenhuma |
| validar	   | Para validar se o {{ site.data.keys.mf_analytics_console }} está ou não acessível. | No | verdadeiro |

#### instalar
{: #install }
Use o atributo **install** para indicar que este serviço de push deve ser conectado e enviar eventos para o {{ site.data.keys.mf_analytics }}. Os valores válidos são true ou false.

#### analyticsURL
{: #analyticsurl }
Use o atributo **analyticsURL** para especificar a URL exposta por {{ site.data.keys.mf_analytics }}, que recebe os dados de análise de dados recebidos.  
Por exemplo: `http://<hostname>:<port>/analytics-service/rest`

#### nome do usuário
{: #username }
Use o atributo **username** para especificar o nome do usuário que é usado se o ponto de entrada de dados para {{ site.data.keys.mf_analytics }} estiver protegido com autenticação básica.

#### senha
{: #password }
Use o atributo **password** para especificar a senha usada, caso o ponto de entrada de dados para o {{ site.data.keys.mf_analytics }} esteja protegido com autenticação básica.

#### validar
{: #validate }
Use o atributo **validate** para validar se o {{ site.data.keys.mf_analytics_console }} está acessível ou não, e para verificar a autenticação de nome do usuário com uma senha. Os valores possíveis são true ou false.

### Para especificar uma conexão com o banco de dados de serviço de push
{: #to-specify-a-connection-to-the-push-service-database-1 }
O elemento `<database>` coleta os parâmetros que especificam uma declaração de origem de dados em um servidor de aplicativos para acessar o banco de dados de serviço de push.

Deve-se declarar um único banco de dados: `<database kind="Push">`. Você especifica o elemento `<database>` de modo semelhante à tarefa Ant configuredatabase, exceto que o elemento `<database>` não possui os elementos `<dba>` e `<client>`. Ele pode ter elementos `<property>` existentes.

O elemento `<database>` possui os atributos a seguir:

| Atributo    | Descrição (Description)                  | Necessário | Padrão |
|--------------|------------------------------|----------|---------|
| kind         | O tipo de banco de dados (Push). | Sim      | Nenhuma    |
| validar	   | Para validar se o banco de dados está acessível. | No | verdadeiro |

O elemento `<database>` suporta os elementos a seguir. Para obter informações adicionais sobre a configuração desses elementos de banco de dados para o DBMS relacional, consulte as tabelas em [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento              | Descrição (Description)                               | Conta |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           | O parâmetro para bancos de dados DB2.         | 0..1  |
| `<derby>`	           | O parâmetro para bancos de dados Apache Derby. | 0..1  |
| `<mysql>`	           | O parâmetro para bancos de dados MySQL.        | 0..1  |
| `<oracle>`           | O parâmetro para bancos de dados Oracle.       | 0..1  |
| `<cloudant>`	       | O parâmetro para bancos de dados Cloudant.     | 0..1  |
| `<driverclasspath>`  | O parâmetro para o caminho da classe do driver JDBC (somente DBMS relacional). | 0..1 |

> **Nota:** Os atributos do elemento `<cloudant>` são um pouco diferentes do tempo de execução. Para obter informações adicionais, consulte a tabela a seguir:

| Atributo    | Descrição (Description)                            | Necessário   | Padrão |
|--------------|----------------------------------------|------------|---------|
| url	       | A URL da conta do Cloudant.       | No         | https://user.cloudant.com |
| usuário	       | O nome do usuário da conta do Cloudant. | Sim | Nenhuma |
| senha	   | A senha da conta do Cloudant.	| No  | Consultado interativamente |
| dbName	   | O nome do banco de dados Cloudant. **Importante:** Esse nome do banco de dados deve começar com uma letra minúscula e conter somente caracteres minúsculos (de a a z), dígitos (de 0 a 9), qualquer um dos caracteres _, $ e -. |Não	| mfp_push_db |

## Tarefas Ant para instalação de ambientes de  {{ site.data.keys.product_adj }} tempo de execução do
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
Informações de referência para as tarefas Ant **installmobilefirstruntime**, **updatemobilefirstruntime** e **uninstallmobilefirstruntime**.

### efeitos da Tarefa
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
A tarefa Ant **installmobilefirstruntime** configura um servidor de aplicativos para executar um arquivo WAR de tempo de execução do {{ site.data.keys.product_adj }} como um aplicativo da web. Essa tarefa tem os efeitos a seguir.

* Declara o aplicativo da web do {{ site.data.keys.product_adj }} na raiz de contexto especificada, por padrão, /mfp.
* Implementa o arquivo web de tempo de execução no servidor de aplicativos.
* Declara origens de dados, e no perfil completo do WebSphere Application Server, provedores JDBC para o tempo de execução.
* Implementa os drivers de banco de dados no servidor de aplicativos.
* Configura as propriedades de configuração do {{ site.data.keys.product_adj }} por meio de entradas de ambiente JNDI.
* Opcionalmente, configura as entradas de ambiente JNDI do {{ site.data.keys.product_adj }} para configurar o servidor de aplicativos como um membro do server farm para o tempo de execução.

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
A tarefa Ant **updatemobilefirstruntime** atualiza um tempo de execução do {{ site.data.keys.product_adj }} já configurado em um servidor de aplicativos. Essa tarefa atualiza o arquivo WAR do tempo de execução. O arquivo deve ter o mesmo nome base que o arquivo WAR do tempo de execução que foi implementado anteriormente. Ao contrário daquela, esta tarefa não muda a configuração do servidor de aplicativos, ou seja, a configuração do aplicativo da web, origens de dados e entradas de ambiente JNDI.

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
A tarefa Ant **uninstallmobilefirstruntime** desfaz os efeitos de uma execução do **installmobilefirstruntime** anterior. Essa tarefa tem os efeitos a seguir.

* Remove a configuração do aplicativo da web {{ site.data.keys.product_adj }} com a raiz de contexto especificada. A tarefa também remove as configurações que são incluídas manualmente nesse aplicativo.
* Remove o arquivo WAR do tempo de execução do servidor de aplicativos.
* Remove as origens de dados e, no perfil completo do WebSphere Application Server, os provedores JDBC para o tempo de execução.
* Ele remove o ambiente JNDI entradas associadas.

### Atributos e Elementos
{: #attributes-and-elements-2 }
As tarefas Ant **installmobilefirstruntime**, **updatemobilefirstruntime** e **uninstallmobilefirstruntime** têm os atributos a seguir:

| Atributo         | Descrição (Description)                                                                 | Necessário   | Padrão                   |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | O prefixo comum em URLs para o aplicativo (raiz de contexto).                | No | /mfp  |
| id	            | Para distinguir diferentes implementações.                                       | No | Esvaziar |
| environmentId	    | Para distinguir diferentes ambientes do {{ site.data.keys.product_adj }}.                          | No | Esvaziar |
| warFile	        | O arquivo WAR para o tempo de execução do {{ site.data.keys.product_adj }}.                                       | No | O arquivo mfp-server.war está no mesmo diretório que o arquivo mfp-ant-deployer.jar. |
| wasStartingWeight | A ordem inicial para o WebSphere Application Server. valores mais baixos primeiro início. | No | 2     |                           |

#### contextroot e id
{: #contextroot-and-id-1 }
Os atributos **contextroot** e **id** distinguem diferentes projetos do {{ site.data.keys.product_adj }}.

Em ambientes de perfis Liberty do WebSphere Application Server e do Tomcat, o parâmetro contextroot é suficiente para esse propósito. Em ambientes de perfil completo do WebSphere Application Server, o atributo id é usado em substituição.

#### environmentId
{: #environmentid-1 }
Use o atributo **environmentId** para diferenciar diversos ambientes, cada um consistindo em serviços administrativos do {{ site.data.keys.mf_server }} e aplicativos da web de tempo de execução {{ site.data.keys.product_adj }}, que devem operar independentemente. Deve-se configurar esse atributo como o mesmo valor para o aplicativo de tempo de execução que o que foi configurado na chamada <installmobilefirstadmin>, para o aplicativo de serviço de administração.

#### warFile
{: #warfile-1 }
Use o atributo **warFile** para especificar um diretório diferente para o arquivo WAR do tempo de execução do {{ site.data.keys.product_adj }}. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

#### wasStartingWeight
{: #wasstartingweight-1 }
Use o atributo **wasStartingWeight** para especificar um valor que é usado no WebSphere Application Server como um weight para assegurar que uma ordem inicial seja respeitada. Como resultado do valor da ordem inicial, o aplicativo da web de serviço de administração do {{ site.data.keys.mf_server }} é implementado e iniciado antes de quaisquer outros projetos de tempo de execução do {{ site.data.keys.product_adj }}. Se projetos do {{ site.data.keys.product_adj }} forem implementados ou iniciados antes do aplicativo da web, a comunicação do JMX não será estabelecida e não será possível gerenciar seus projetos do {{ site.data.keys.product_adj }}.

As tarefas **installmobilefirstruntime**, **updatemobilefirstruntime** e **uninstallmobilefirstruntime** suportam os elementos a seguir:

| Elemento               | Descrição (Description)                                      | Conta |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | As propriedades.	                               | 0..   |
| `<applicationserver>` | O servidor de aplicativos.                          | 1     |
| `<database>`          | Os bancos de dados.                                   | 1     |
| `<analytics>`         | A análise de dados.                                   | 0..1  |

O elemento `<property>` especifica uma propriedade de implementação a ser definida no servidor de aplicativos. Possui os seguintes atributos:

| Atributo | Descrição (Description)                | Necessário | Padrão |
|-----------|----------------------------|----------|---------|
| Nome      | O nome da propriedade.	 | Sim      | Nenhuma    |
| valor	    | O valor da propriedade.| Sim	    | Nenhuma    |  

O elemento `<applicationserver>` descreve o servidor de aplicativos no qual o aplicativo {{ site.data.keys.product_adj }} é implementado. Ele é um contêiner para um dos elementos a seguir:

| Elemento                                    | Descrição (Description)                                      | Conta |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` ou `<was>`  | Os parâmetros para o WebSphere Application Server.	| 0..1  |
| `<tomcat>`                                 | Os parâmetros para Apache Tomcat.                | 0..1  |

O elemento `<websphereapplicationserver>` (ou `<was>` em seu formato abreviado) denota uma instância do WebSphere Application Server. O perfil completo do WebSphere Application Server (Base e Network Deployment) é suportado, portanto, é o WebSphere Application Server Liberty Core e o WebSphere Application Server Liberty Network Deployment. O elemento `<websphereapplicationserver>` possui os atributos a seguir:

| Atributo       | Descrição (Description)                                            | Necessário                 | Padrão |
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	Diretório de instalação do WebSphere Application Server.   | Sim                      | Nenhuma    |
| perfis         |	Perfil do WebSphere Application Server, ou Liberty.      | Sim	                  | Nenhuma    |
| Nome de usuário do administrador do WebSphere Application Server.	               | Sim, exceto para Liberty  | Nenhuma    |
| Senha        | Senha do administrador do WebSphere Application Server.   | Nenhuma consultada interativamente |         |
| libertyEncoding |	O algoritmo para codificar senhas de origem de dados para o WebSphere Application Server Liberty. Os valores possíveis são none, xor e aes. Se a codificação xor ou aes for usada, a senha limpa será transmitida como argumento para o programa securityUtility, que é chamado por meio de um processo externo. É possível ver a senha com um comando ps, ou no sistema de arquivos /proc em sistemas operacionais UNIX.                                                         | No                       |	xor     |
| jeeVersion      |	Para perfil Liberty. Para especificar se deve ou não instalar recursos do perfil da web JEE6 ou perfil da web JEE7. Os valores possíveis são 6, 7 ou auto.| No | automática |
| configureFarm   |	Para o WebSphere Application Server Liberty e o perfil completo do WebSphere Application Server (não para o WebSphere Application Server Network Deployment edition e o Liberty Collective). Para especificar se o servidor é um membro do server farm. Os valores possíveis são true ou false. | Não	      | falso   |
| farmServerId    |	Uma sequência que identifica um servidor exclusivamente em um server farm. Os serviços de administração do {{ site.data.keys.mf_server }} e todos os tempos de execução do {{ site.data.keys.product_adj }} que se comunicam com ele devem compartilhar o mesmo valor.                                                                | Sim                      |	Nenhuma    |

Suporta o elemento a seguir para implementação de servidor único:

| Elemento     | Descrição (Description)      | Conta |
|-------------|------------------|-------|
| `<server>`  | Um único servidor. | 0..1  |

O elemento <server>, que é usado nesse contexto, tem o seguinte atributo:

| Atributo | Descrição (Description)      | Necessário | Padrão |
|-----------|------------------|----------|---------|
| nome	    | O nome do servidor. | Sim      | Nenhuma    |

Suporta os seguintes elementos para o Liberty Collective:

| Elemento               | Descrição (Description)                  | Conta |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | Um membro do Liberty
Collective. | 0..1  |

O elemento `<collectiveMember>` possui os atributos a seguir:

| Atributo               | Descrição (Description)      | Necessário | Padrão |
|-------------------------|------------------|----------|---------|
| serverName              |	O nome do membro coletivo.                       | Sim | Nenhuma |
| clusterName             |	O nome do cluster ao qual o membro coletivo pertence.  | Sim | Nenhuma |
| serverId                |	Uma sequência que identifica exclusivamente o membro coletivo. | Sim | Nenhuma |
| controllerHost          |	O nome do controlador coletivo.                   | Sim | Nenhuma |
| controllerHttpsPort     |	A porta HTTPS do controlador coletivo.             | Sim | Nenhuma |
| controllerAdminName     |	O nome do usuário administrativo definido no controlador coletivo. É o mesmo usuário que o usado para associar membros ao Collective. | Sim | Nenhuma |
| controllerAdminPassword |	A senha do usuário administrativo.	                     | Sim | Nenhuma |
| createControllerAdmin   |	Para indicar se o usuário administrativo deve ser criado no registro básico do membro coletivo. Os valores possíveis são true ou false. | No | verdadeiro |

Suporta os elementos a seguir para o Network Deployment:

| Elemento     | Descrição (Description)                                   | Conta |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	A célula inteira.	                          | 0..1  |
| `<cluster>` |	Todos os servidores de um cluster.                 |	0..1  |
| `<node>`    |	Todos os servidores em um nó, clusters excluídos. | 0..1  |
| `<server>`  |	Um único servidor.	                          | 0..1  |

O elemento `<cell>` não possui atributos.

O elemento `<cluster>` possui o atributo a seguir:

| Atributo | Descrição (Description)       | Necessário | Padrão |
|-----------|-------------------|----------|---------|
| Nome      | O nome do cluster. | Sim	   | Nenhuma    |

O elemento `<node>` possui o atributo a seguir:

| Atributo | Descrição (Description)    | Necessário | Padrão |
|-----------|----------------|----------|---------|
| Nome      | O nome do nó. | Sim	    | Nenhuma    |

O elemento `<server>`, que é usado em um contexto do Network Deployment, possui os atributos a seguir:

| Atributo  | Descrição (Description)      | Necessário | Padrão |
|------------|------------------|----------|---------|
| nodeName   | O nome do nó.   | Sim	   | Nenhuma    |
| serverName | O nome do servidor. | Sim      | Nenhuma    |

O elemento `<tomcat>` denota um servidor Apache Tomcat. Ele possui o seguinte atributo:

| Atributo     | Descrição (Description)      | Necessário | Padrão |
|---------------|------------------|----------|---------|
| installdir    | O diretório de instalação do Apache Tomcat. Para uma instalação do Tomcat dividida entre um diretório CATALINA_HOME e um diretório CATALINA_BASE, especifique o valor da variável de ambiente CATALINA_BASE.     | Sim | Nenhuma    |
| configureFarm | Para especificar se o servidor é um membro do server farm. Os valores possíveis são true ou false.	| No | falso |
| farmServerId	| Uma sequência que identifica um servidor exclusivamente em um server farm. Os serviços de administração do {{ site.data.keys.mf_server }} e todos os tempos de execução do {{ site.data.keys.product_adj }} que se comunicam com ele devem compartilhar o mesmo valor. | Sim | Nenhuma |

O elemento `<database>` especifica quais informações são necessárias para acessar um banco de dados específico. O elemento `<database>` é especificado como a tarefa Ant configuredatabase, exceto que ele não possui os elementos `<dba>` e `<client>`. No entanto, ele pode possuir os elementos `<property>`. O elemento `<database>` possui os atributos a seguir:

| Atributo | Descrição (Description)                                | Necessário | Padrão |
|-----------|--------------------------------------------|----------|---------|
| kind      | O tipo de banco de dados ({{ site.data.keys.product_adj }} Runtime). | Sim | Nenhuma |
| validar  | Para validar se o banco de dados está ou não acessível. Os valores possíveis são true ou false. | No | verdadeiro |

O elemento `<database>` suporta os elementos a seguir:

| Elemento             | Descrição	                | Conta |
|---------------------|-----------------------------|-------|
| `<derby>`           | Os parâmetros para Derby.   | 0..1  |
| `<db2>`             |	Os parâmetros para DB2.     | 0..1  |
| `<mysql>`           |	Os parâmetros para MySQL.   | 0..1  |
| `<oracle>`          |	Os parâmetros para Oracle.  | 0..1  |
| `<driverclasspath>` | O caminho de classe do driver JDBC. | 0..1  |

O elemento `<analytics>` indica que você deseja conectar o tempo de execução do {{site.data.keys.product_adj }} a um {{site.data.keys.mf_analytics_console }} e serviços já instalados. Possui os seguintes atributos:

| Atributo    | Descrição (Description)                                                                      | Necessário | Padrão |
|--------------|----------------------------------------------------------------------------------|----------|---------|
| Instalar      | Para indicar se você deve ou não conectar o tempo de execução do {{ site.data.keys.product_adj }} ao {{ site.data.keys.mf_analytics }}. | No       | falso   |
| analyticsURL | A URL dos serviços {{ site.data.keys.mf_analytics }}.	                                      | Sim      | Nenhuma    |
| consoleURL   | A URL do {{ site.data.keys.mf_analytics_console }}.	                                      | Sim      | Nenhuma    |
| nome de usuário     | O nome de usuário.	                                                                  | Sim      | Nenhuma    |
| Senha     | A senha.	                                                                  | Sim      | Nenhuma    |
| validar     | Para validar se o {{ site.data.keys.mf_analytics_console }} está ou não acessível.	      | Não	     | verdadeiro    |
| arrendatário       | O locatário para indexação de dados que são coletados de um tempo de execução do {{ site.data.keys.product_adj }}.	      | No       | Identificador Interno |

#### instalar
{: #install-1 }
Use o atributo **install** para indicar que esse tempo de execução do {{ site.data.keys.product_adj }} deve ser conectado e para enviar eventos para o {{ site.data.keys.mf_analytics }}. Os valores válidos são **true** ou **false**.

#### analyticsURL
{: #analyticsurl-1 }
Use o atributo **analyticsURL** para especificar a URL exposta por {{ site.data.keys.mf_analytics }}, que recebe os dados de análise de dados recebidos.  
Por exemplo: `http://<hostname>:<port>/analytics-service/rest`

#### consoleURL
{: #consoleurl }
Use o atributo **consoleURL** para a URL que é exposta por {{ site.data.keys.mf_analytics }}, que se vincula ao {{ site.data.keys.mf_analytics_console }}.  
Por exemplo: `http://<hostname>:<port>/analytics/console`

#### nome do usuário
{: #username-1 }
Use o atributo **username** para especificar o nome do usuário que é usado se o ponto de entrada de dados para {{ site.data.keys.mf_analytics }} estiver protegido com autenticação básica.

#### senha
{: #password-1 }
Use o atributo **password** para especificar a senha usada, caso o ponto de entrada de dados para o {{ site.data.keys.mf_analytics }} esteja protegido com autenticação básica.

#### validar
{: #validate-1 }
Use o atributo **validate** para validar se o {{ site.data.keys.mf_analytics_console }} está acessível ou não, e para verificar a autenticação de nome do usuário com uma senha. Os valores possíveis são **true** ou **false**.

#### arrendatário
{: #tenant }
Para obter mais informações sobre esse atributo, consulte [Propriedades de configuração](../analytics/configuration/#configuration-properties).

### Para especificar um banco de dados Apache Derby
{: #to-specify-an-apache-derby-database }
O elemento `<derby>` possui os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| banco de dados	 | O nome do banco de dados.	                      | No       |	MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo. |
| datadir	 | O diretório que contém os bancos de dados. |	Sim	     | Nenhuma    |
| esquema     |	O nome do esquema.                          |	Não	     | MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH ou APPCENTER, dependendo do tipo. |

O elemento `<derby>` suporta o elemento a seguir:

| Elemento       | Descrição	                | Conta |
|---------------|-------------------------------|-------|
| `<property>`  | A propriedade de origem de dados ou propriedade da conexão JDBC.	| 0.. |

Para obter informações adicionais sobre as propriedades disponíveis, consulte a documentação para a Classe [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html). Consulte também a documentação para [Classe EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html).

Para obter mais informações sobre as propriedades disponíveis para um servidor Liberty, consulte a documentação para `properties.derby.embedded` em [Perfil do Liberty: elementos de configuração no arquivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

Quando o arquivo **mfp-ant-deployer.jar** é usado dentro do diretório de instalação do {{site.data.keys.product }}, um elemento `<driverclasspath>` não é necessário.

### Para especificar um banco de dados DB2
{: #to-specify-a-db2-database }
O elemento `<db2>` possui os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| banco de dados   | O nome do banco de dados. | Nenhum	MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo. |
| servidor     | O nome do host do servidor de banco de dados.      | Sim	     | Nenhuma    |
| porta       | A porta no servidor de banco de dados.           | Não	     | 50000   |
| usuário       | O nome do usuário para acessar bancos de dados.     | Esse usuário não precisa de privilégios estendidos nos bancos de dados. Se você implementar restrições no banco de dados, será possível configurar um usuário com os privilégios restritos                                 | que estão listados em Usuários e privilégios do banco de dados. | Yes	None |
| Senha   | A senha para acessar bancos de dados.      | No       | Consultado interativamente |
| esquema     | O nome do esquema.                           | No       | Depende do usuário |

Para obter informações adicionais sobre contas do usuário do DB2, consulte [Visão geral do modelo de segurança do DB2](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).  
O elemento `<db2>` suporta o elemento a seguir:

| Elemento       | Descrição	                | Conta |
|---------------|-------------------------------|-------|
| `<property>`  | A propriedade de origem de dados ou propriedade da conexão JDBC.	| 0.. |

Para obter informações adicionais sobre as propriedades disponíveis, consulte [Propriedades do IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).

Para obter mais informações sobre as propriedades disponíveis para um servidor Liberty, consulte a seção **properties.db2.jcc** em [Perfil do Liberty: elementos de configuração no arquivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

O elemento `<driverclasspath>` deve conter arquivos JAR para o driver JDBC do DB2 e a licença associada. É possível fazer download de drivers JDBC DB2 de [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866).

### Para especificar um banco de dados MySQL
{: #to-specify-a-mysql-database }
O elemento `<mysql>` possui os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| banco de dados	 | O nome do banco de dados.	                      | No       | MFPDATA, MFPADM, MFPCFG, MFPPUSH ou APPCNTR, dependendo do tipo. |
| servidor	 | O nome do host do servidor de banco de dados.	  | Sim      | Nenhuma    |
| porta	     | A porta no servidor de banco de dados.           | Não	     | 3306    |
| usuário	     | O nome do usuário para acessar bancos de dados. Esse usuário não precisa de privilégios estendidos nos bancos de dados. Se você implementar restrições no banco de dados, será possível configurar um usuário com os privilégios restritos | que estão listados em Usuários e privilégios do banco de dados. | Sim | Nenhuma |
| senha	 | A senha para acessar bancos de dados.	  | Não	     | Consultado interativamente |

Em vez de **database**, **server** e **port**, também é possível especificar uma URL. Nesse caso, use os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| url	     | A URL para conexão com o banco de dados.	  | Sim	     | Nenhuma    |
| usuário	     | O nome do usuário para acessar bancos de dados. Esse usuário não precisa de privilégios estendidos nos bancos de dados. Se você implementar restrições no banco de dados, será possível configurar um usuário com os privilégios restritos que estão listados em Usuários e privilégios do banco de dados. | Sim  | Nenhuma |
| senha	 | A senha para acessar bancos de dados.	  | No       | Consultado interativamente |

Para obter mais informações sobre contas do usuário do MySQL, consulte [Gerenciamento de conta do usuário do MySQL](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).

O elemento `<mysql>` suporta o elemento a seguir:

| Elemento       | Descrição	                | Conta |
|---------------|-------------------------------|-------|
| `<property>`  | A propriedade de origem de dados ou propriedade da conexão JDBC.	| 0.. |

Para obter mais informações sobre as propriedades disponíveis, consulte a documentação em [Nomes de classe de driver/origem de dados, sintaxe de URL e propriedades de configuração para Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).

Para obter informações adicionais sobre as propriedades disponíveis para um servidor Liberty, consulte a seção de propriedades em [Perfil Liberty: elementos de configuração no arquivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

O elemento `<driverclasspath>` deve conter um arquivo JAR do MySQL Connector/J. É possível fazer seu download em [Download do Connector/J](http://www.mysql.com/downloads/connector/j/).

### Para especificar um banco de dados Oracle
{: #to-specify-an-oracle-database }
O elemento `<oracle>` possui os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| banco de dados   | O nome do banco de dados ou nome do serviço Oracle. Nota: você deve sempre usar um nome do serviço para conectar-se a um banco de dados PDB. | No | ORCL |
| servidor	 | O nome do host do servidor de banco de dados.	Yes	None
| porta	     | A porta no servidor de banco de dados.	No	1521
| usuário	     | O nome do usuário para acessar bancos de dados. Esse usuário não precisa de privilégios estendidos nos bancos de dados. Se você implementar restrições no banco de dados, será possível configurar um usuário com os privilégios restritos que estão listados em Usuários e privilégios do banco de dados. Consulte a nota sob esta tabela. | Sim | Nenhuma |
| senha	 | A senha para acessar bancos de dados.	  | No       | Consultado interativamente |

> **Nota:** Para o atributo **user**, use preferencialmente um nome do usuário em letras maiúsculas. Geralmente os nomes de usuário do Oracle estão em letras maiúsculas. Ao contrário de outras ferramentas de banco de dados, a tarefa Ant **installmobilefirstruntime** não converte letras minúsculas em letras maiúsculas no nome do usuário. Se a tarefa Ant  **installmobilefirstruntime** falhar ao se conectar ao banco de dados, tente inserir o valor para o atributo **user** em letras maiúsculas.

Em vez de **database**, **server** e **port**, também é possível especificar uma URL. Nesse caso, use os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| url	     | A URL para conexão com o banco de dados.	  | Sim      | Nenhuma    |
| usuário	     | O nome do usuário para acessar bancos de dados. Esse usuário não precisa de privilégios estendidos nos bancos de dados. Se você implementar restrições no banco de dados, será possível configurar um usuário com os privilégios restritos que estão listados em Usuários e privilégios do banco de dados. Consulte a nota sob esta tabela. | Sim | Nenhuma |
| senha	 | A senha para acessar bancos de dados.	  | Não	     | Consultado interativamente |

> **Nota:** Para o atributo **user**, use preferencialmente um nome do usuário em letras maiúsculas. Geralmente os nomes de usuário do Oracle estão em letras maiúsculas. Ao contrário de outras ferramentas de banco de dados, a tarefa Ant **installmobilefirstruntime** não converte letras minúsculas em letras maiúsculas no nome do usuário. Se a tarefa Ant  **installmobilefirstruntime** falhar ao se conectar ao banco de dados, tente inserir o valor para o atributo **user** em letras maiúsculas.

Para obter mais informações sobre contas do usuário do Oracle, consulte
[Visão geral dos métodos de autenticação](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).

Para obter mais informações sobre URLs de conexão com o banco de dados Oracle, consulte **URLs do banco de dados e especificadores do banco de dados** em [Origens de dados e URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Ele suporta o seguinte elemento:

| Elemento       | Descrição	                | Conta |
|---------------|-------------------------------|-------|
| `<property>`  | A propriedade de origem de dados ou propriedade da conexão JDBC.	| 0.. |

Para obter informações adicionais sobre propriedades disponíveis, consulte a seção **Origens de dados e URLs** em [Origens de dados e URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Para obter mais informações sobre as propriedades disponíveis de um servidor Liberty, consulte a seção **properties.oracle** em [Perfil do Liberty: elementos de configuração no arquivo server.xml](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

O elemento `<driverclasspath>` deve conter um arquivo JAR do driver JDBC Oracle. É possível fazer download de drivers JDBC Oracle do [JDBC, SQLJ, Oracle JPublisher e Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html).

O elemento `<property>`, que pode ser usado dentro dos elementos `<derby>`, `<db2>`,` <mysql>`, ou `<oracle>`, possui os atributos a seguir:

| Atributo  | Descrição (Description)                                | Necessário | Padrão |
|------------|--------------------------------------------|----------|---------|
| Nome       | O nome da propriedade.	              | Sim      | Nenhuma    |
| tipo	     | Tipo Java dos valores da propriedade, geralmente java.lang.String/Integer/Boolean. | No | java.lang.String |
| valor	     | O valor da propriedade.	              | Sim      |  Nenhuma   |

## Tarefas Ant para instalação do Application Center
{: #ant-tasks-for-installation-of-application-center }
O elemento `<installApplicationCenter>`, `<updateApplicationCenter>`
e `<uninstallApplicationCenter>` são fornecidas para a instalação do Application Center Console and Services.

### efeitos da Tarefa
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
O elemento `<installApplicationCenter>` configura um servidor de aplicativos para executar o arquivo WAR do Application Center Services como um aplicativo da web e para instalar o Application Center Console. Esta tarefa tem os seguintes efeitos:

* Declara o aplicativo da web do Application Center Services na raiz de contexto /applicationcenter.
* Declara origens de dados, e no perfil completo do WebSphere Application Server, também declara provedores JDBC para o Application Center Services.
* Implementa o aplicativo da web do Application Center Services no servidor de aplicativos.
* Declara o Application Center Console como um aplicativo da web na raiz de contexto /appcenterconsole.
* Implementa o arquivo WAR do Application Center Console no servidor de aplicativos.
* Configura propriedades de configuração para o Application Center Services usando entradas de ambiente JNDI. As entradas de ambiente JNDI relacionadas ao terminal e aos proxies são comentadas. Deve-se remover seus comentários em alguns casos.
* Configura usuários que ele mapeia para funções usadas pelo aplicativo da web do Application Center Console and Services.
* No WebSphere Application Server, configura a propriedade customizada necessária para o contêiner da web.

#### updateApplicationCenter
{: #updateApplicationCenter }
O elemento `<updateApplicationCenter>` atualiza um aplicativo do Application Center já configurado em um servidor de aplicativos. Esta tarefa tem os seguintes efeitos:

* Atualiza o arquivo WAR do Application Center Services. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.
* Atualiza o arquivo WAR do Application Center Console. Este arquivo deve ter o mesmo nome de base do arquivo WAR correspondente que foi implementado anteriormente.

A tarefa não muda a configuração do servidor de aplicativos, ou seja, a configuração do aplicativo da web, origens de dados, entradas de ambiente JNDI e mapeamentos de usuário-para-função. Essa tarefa se aplica somente a uma instalação que é executada usando a tarefa <installApplicationCenter> descrita nesse tópico.

> **Nota:** No perfil Liberty do WebSphere Application Server, a tarefa não muda os recursos, o que deixa uma possível lista não mínima de recursos no arquivo server.xml para o aplicativo instalado.

#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
O elemento `<uninstallApplicationCenter>` desfaz os efeitos de uma execução anterior do `<installApplicationCenter>`. Esta tarefa tem os seguintes efeitos:

* Remove a configuração do aplicativo da web do Application Center Services com a raiz de contexto **/applicationcenter**. Como conseqüência, a tarefa também remove as configurações que foram incluídos manualmente para esse aplicativo.
* Remove ambos os arquivos WAR do Application Center Services and Console do servidor de aplicativos.
* Remove as origens de dados e, no perfil completo do WebSphere Application Server, também remove os provedores JDBC para o Application Center Services.
* Remove os drivers de banco de dados que foram usados pelo Application Center Services do servidor de aplicativos.
* Ele remove o ambiente JNDI entradas associadas.
* Remove os usuários que são configurados pela chamada do `<installApplicationCenter>`.

### Atributos e Elementos
{: #attributes-and-elements-3 }
O elemento `<installApplicationCenter>`, `<updateApplicationCenter>`
e `<uninstallApplicationCenter>` possuem os atributos a seguir:

| Atributo    | Descrição (Description)                                | Necessário | Padrão |
|--------------|--------------------------------------------|----------|---------|
| id	       | Distingue diferentes implementações no perfil completo do WebSphere Application Server.	| No | Esvaziar |
| servicewar   | O arquivo WAR para o Application Center Services. | No | O arquivo applicationcenter.war está no diretório do console do Application Center: **product_install_dir/ApplicationCenter/console.** |
| shortcutsDir | O diretório no qual você coloca os atalhos. | No | Nenhuma |
| aaptDir | O diretório que contém o programa aapt, do pacote platform-tools do Android SDK. | No | Nenhuma |

#### id
{: #id-1 }
Em ambientes de perfil completo do WebSphere Application Server, o atributo **id** é usado para distinguir entre diferentes implementações do Application Center Console and Services. Sem esse atributo **id** , dois arquivos WAR com as raízes de contexto pode mesmo conflito e esses arquivos não seriam implementados.

#### servicewar
{: #servicewar-1 }
Use o atributo **servicewar** para especificar um diretório diferente para o arquivo WAR do Application Center Services. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

#### shortcutsDir
{: #shortcutsdir-1 }
O atributo **shortcutsDir** especifica onde colocar atalhos para o Application Center Console. Se você configurar esse atributo, os arquivos a seguir serão incluídos nesse diretório:

* **appcenter-console.url**: esse arquivo é um atalho do Windows. Ele abre o Application Center Console em um navegador.
* **appcenter-console.sh**: esse arquivo é um shell script do UNIX. Ele abre o Application Center Console em um navegador.

#### aaptDir
{: #aaptdir }
O programa **aapt** faz parte da distribuição do {{ site.data.keys.product }}: **product_install_dir/ApplicationCenter/tools/android-sdk**.  
Se esse atributo não for configurado, durante o upload de um aplicativo apk, o Application Center o analisa usando seu próprio código, que pode ter limitações.

O elemento `<installApplicationCenter>`, `<updateApplicationCenter>`
e `<uninstallApplicationCenter>` suportam os elementos a seguir:

| Elemento           | Descrição	                            | Conta |
|-------------------|-------------------------------------------|-------|
| applicationserver	| O servidor de aplicativos.                   | 1     |
| console           | O console do Application Center.	        | 1     |
| banco de dados          | Os bancos de dados.	                        | 1     |
| usuário	            | O usuário deve ser mapeado para uma função de segurança. | 0..∞  |

### Para especificar um console do Application Center
{: #to-specify-an-application-center-console }
O elemento `<console>` coleta informações para customizar a instalação do Application Center Console. Esse elemento possui os atributos a seguir:

| Atributo    | Descrição (Description)                                      | Necessário | Padrão |
|--------------|--------------------------------------------------|----------|---------|
| warfile      | O arquivo WAR para o Application Center Console. |	No       | O arquivo appcenterconsole.war está no diretório do console do Application Center:  **product_install_dir/ApplicationCenter/console**. |

### Para especificar um servidor de aplicativos
{: #to-specify-an-application-server-3 }
Use o elemento `<applicationserver>` para definir os parâmetros que dependem do servidor de aplicativos subjacente. O elemento `<applicationserver>` suporta os elementos a seguir.

| Elemento           | Descrição	                            | Conta |
|-------------------|-------------------------------------------|-------|
| **websphereapplicationserver** ou **was**	| Os parâmetros para o WebSphere Application Server. O elemento `<websphereapplicationserver>` (ou `<was>` em seu formato abreviado) denota uma instância do WebSphere Application Server. O perfil completo do WebSphere Application Server (Base e Network Deployment) é suportado, portanto, representam o WebSphere Application Server Liberty Core. O Liberty Collective não é suportado para o Application Center. | 0..1 |
| tomcat            | Os parâmetros para Apache Tomcat. | 0..1 |

Os atributos e os elementos internos desses elementos são descritos nas tabelas da página [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

### Para especificar uma conexão com o banco de dados de serviços
{: #to-specify-a-connection-to-the-services-database }
O elemento `<database>` coleta os parâmetros que especificam uma declaração de origem de dados em um servidor de aplicativos para acessar o banco de dados de serviços.

Deve-se declarar um único banco de dados: `<database kind="ApplicationCenter">`. Você especifica o elemento `<database>` de modo semelhante à tarefa Ant `<configuredatabase>`, exceto que o elemento `<database>` não possui os elementos `<dba>` e `<client>`. Ele pode ter elementos `<property>` existentes.

O elemento `<database>` possui os atributos a seguir:

| Atributo    | Descrição (Description)                                            | Necessário | Padrão |
|--------------|--------------------------------------------------------|----------|---------|
| kind         | O tipo de banco de dados (ApplicationCenter).              | Sim      | Nenhuma    |
| validar	   | Para validar se o banco de dados está ou não acessível. | No       | True    |

O elemento `<database>` suporta os elementos a seguir. Para obter informações adicionais sobre a configuração desses elementos de banco de dados, consulte as tabelas em [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento           | Descrição	                            | Conta |
|-------------------|-------------------------------------------|-------|
| db2	            | O parâmetro para bancos de dados DB2.	        | 0..1  |
| derby             | O parâmetro para bancos de dados Apache Derby.	| 0..1  |
| mysql             | O parâmetro para bancos de dados MySQL.	    | 0..1  |
| oracle	        | O parâmetro para bancos de dados Oracle.	    | 0..1  |
| driverclasspath   | O parâmetro para o caminho da classe do driver JDBC.	| 0..1  |

### Para especificar um usuário e uma função de segurança
{: #to-specify-a-user-and-a-security-role }
O elemento `<user>` coleta os parâmetros sobre um usuário para incluir em uma determinada função de segurança para um aplicativo.

| Atributo    | Descrição (Description)                                            | Necessário | Padrão |
|--------------|--------------------------------------------------------|----------|---------|
| papel         | A função de usuário appcenteradmin. | Sim | Nenhuma |
| nome	       | O nome de usuário. | Sim | Nenhuma |
| senha	   | A senha, se você tiver que criar o usuário.	| No | Nenhuma |

## Tarefas Ant para instalação do {{ site.data.keys.mf_analytics }}
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
As tarefas Ant **installanalytics**, **updateanalytics** e **uninstallanalytics** são fornecidas para a instalação do {{ site.data.keys.mf_analytics }}.

O propósito dessas tarefas Ant é configurar o {{ site.data.keys.mf_analytics_console }} e o serviço do {{ site.data.keys.mf_analytics }} com o armazenamento apropriado para os dados em um servidor de aplicativos.
A tarefa instala nós do {{ site.data.keys.mf_analytics }} que agem como um mestre e dados. Para obter mais informações, consulte [Gerenciamento de cluster e Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch).

### efeitos da Tarefa
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
A tarefa Ant **installanalytics** configura um servidor de aplicativos para executar o IBM {{ site.data.keys.mf_analytics }}. Esta tarefa tem os seguintes efeitos:

* Implementa o {{ site.data.keys.mf_analytics }} Service e os arquivos WAR do {{ site.data.keys.mf_analytics_console }} no servidor de aplicativos.
* Declara o aplicativo da web do {{ site.data.keys.mf_analytics }} Service na raiz de contexto /analytics-service especificada.
* Declara o aplicativo da web do {{ site.data.keys.mf_analytics_console }} na raiz de contexto /analytics especificada.
* Configura as propriedades de configuração de {{ site.data.keys.mf_analytics_console }} e de {{ site.data.keys.mf_analytics }} Services por meio de entradas de ambiente JNDI.
* No perfil Liberty do WebSphere Application Server, configura o contêiner da web.
* Opcionalmente, cria usuários para usarem o {{ site.data.keys.mf_analytics_console }}.

#### updateanalytics
{: #updateanalytics }
A tarefa Ant **updateanalytics** atualiza os arquivos WAR dos aplicativos da web {{ site.data.keys.mf_analytics }} Service e {{ site.data.keys.mf_analytics_console }} em um servidor de aplicativos. Esses arquivos devem ter os mesmos nomes base que os arquivos WAR do projeto que foram implementados anteriormente.

A tarefa não muda a configuração do servidor de aplicativos, ou seja, a configuração de aplicativo da web e entradas de ambiente JNDI.

#### uninstallanalytics
{: #uninstallanalytics }
A tarefa Ant **uninstallanalytics** desfaz os efeitos de uma execução anterior de **installanalytics**. Esta tarefa tem os seguintes efeitos:

* Remove a configuração dos aplicativos da web {{ site.data.keys.mf_analytics }} Service e {{ site.data.keys.mf_analytics_console }} com suas respectivas raízes de contexto.
* Remove os arquivos WAR do {{ site.data.keys.mf_analytics }} Service e do {{ site.data.keys.mf_analytics_console }} do servidor de aplicativos.
* Ele remove o ambiente JNDI entradas associadas.

### Atributos e Elementos
{: #attributes-and-elements-4 }
As tarefas **installanalytics**, **updateanalytics** e **uninstallanalytics** têm os seguintes atributos:

| Atributo    | Descrição (Description)                                            | Necessário | Padrão |
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   | O arquivo WAR para o Serviço do {{ site.data.keys.mf_analytics }}     | No       | O arquivo analytics-service.war está no diretório Analytics. |

#### serviceWar
{: #servicewar-2 }
Use o atributo **serviceWar** para especificar um diretório diferente para o arquivo WAR de Serviços do {{ site.data.keys.mf_analytics }}. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

O elemento `<installanalytics>`, `<updateanalytics>`
e `<uninstallanalytics>` suportam os elementos a seguir:

| Atributo         | Descrição (Description)                               | Necessário | Padrão |
|-------------------|-------------------------------------------|----------|---------|
| console	        | {{ site.data.keys.mf_analytics }}   	                | Sim	   | 1       |
| usuário	            | O usuário deve ser mapeado para uma função de segurança.	| Não	   | 0..     |
| armazenamento	        | O tipo de armazenamento.	                    | Sim 	   | 1       |
| applicationserver	| O servidor de aplicativos.	                | Sim	   | 1       |
| property          | Propriedades.	                            | Não 	   | 0..     |

### Para especificar um {{ site.data.keys.mf_analytics_console }}
{: #to-specify-a-mobilefirst-analytics-console }
O elemento `<console>` coleta informações para customizar a instalação do {{ site.data.keys.mf_analytics_console }}. Esse elemento possui os atributos a seguir:

| Atributo    | Descrição (Description)                                  | Necessário | Padrão |
|--------------|----------------------------------------------|----------|---------|
| warfile	   | O arquivo WAR do console	                      | Não	     | O arquivo analytics-ui.war está no diretório Analytics. |
| shortcutsdir | O diretório no qual você coloca os atalhos. | Não	     | Nenhuma    |

#### warFile
{: #warfile-2 }
Use o atributo **warFile** para especificar um diretório diferente para o arquivo WAR do {{ site.data.keys.mf_analytics_console }}. Você pode especificar o nome desse arquivo WAR com um caminho absoluto ou um caminho relativo.

#### shortcutsDir
{: #shortcutsdir-2 }
O atributo **shortcutsDir** especifica onde colocar atalhos para o {{ site.data.keys.mf_analytics_console }}. Se você definir esse atributo, você pode incluir os seguintes arquivos para esse diretório:

* **analytics-console.url**: esse arquivo é um atalho do Windows. Ele abre o {{ site.data.keys.mf_analytics_console }} em um navegador.
* **analytics-console.sh**: esse arquivo é um shell script do UNIX. Ele abre o {{ site.data.keys.mf_analytics_console }} em um navegador.

> Nota: esses atalhos não incluem o parâmetro de locatário ElasticSearch.

O elemento `<console>` suporta o elemento aninhado a seguir:

| Elemento  | Descrição	| Conta |
|----------|----------------|-------|
| property | Propriedades	    | 0..   |

Com esse elemento, é possível definir suas próprias propriedades JNDI.

O elemento `<property>` possui os atributos a seguir:

| Atributo  | Descrição (Description)                | Necessário | Padrão |
|------------|----------------------------|----------|---------|
| Nome       | O nome da propriedade.  | Sim      | Nenhuma    |
| valor	     | O valor da propriedade. |	Sim      | Nenhuma    |

### Para especificar um usuário e uma função de segurança
{: #to-specify-a-user-and-a-security-role-1 }
O elemento `<user>` coleta os parâmetros sobre um usuário para incluir em uma determinada função de segurança para um aplicativo.

| Atributo   | Descrição (Description)                                   | Necessário | Padrão |
|-------------|-----------------------------------------------|----------|---------|
| função	      | Uma função de segurança válida para o aplicativo.    | Sim      | Nenhuma    |
| nome	      | O nome de usuário.	                              | Sim      | Nenhuma    |
| senha	  | A senha, caso o usuário precise ser criado. | No       | Nenhuma    |

Após ter definido os usuários usando o elemento` <user>`, é possível mapeá-los para qualquer uma das funções a seguir para autenticação no {{site.data.keys.mf_console }}:

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### Para especificar um tipo de armazenamento para {{ site.data.keys.mf_analytics }}
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
O elemento `<storage>` indica qual tipo subjacente de armazenamento o {{site.data.keys.mf_analytics }} usa para armazenar as informações e os dados que ele coleta.

Ele suporta o seguinte elemento:

| Elemento       | Descrição	| Conta   |
|---------------|---------------|---------|
| elasticsearch	| ElasticSearch | cluster |

O elemento `<elasticsearch>` coleta os parâmetros sobre um cluster ElasticSearch.

| Atributo        | Descrição (Description)                                   | Necessário | Padrão   |
|------------------|-----------------------------------------------|----------|-----------|
| clusterName	   | O nome do cluster ElasticSearch.	           | No       | Worklight |
| nodeName	       | O nome do nó ElasticSearch. Esse nome deve ser exclusivo em um cluster ElasticSearch.	| No | `worklightNode_<random number>` |
| mastersList	   | Uma sequência delimitada por vírgulas que contém o nome do host e as portas dos nós principais ElasticSearch no cluster ElasticSearch (Por exemplo: hostname1:transport-port1,hostname2:transport-port2)	           | No       |	Depende da topologia |
| dataPath	       | O local do cluster ElasticSearch.	       | Não	      | Depende do servidor de aplicativos |
| shards	       | O número de shards que o cluster ElasticSearch cria. Esse valor pode ser configurado pelos nós principais que são criados no cluster ElasticSearch.	| No | 5 |
| replicasPerShard | O número de réplicas para cada shard no cluster ElasticSearch. Esse valor pode ser configurado pelos nós principais que são criados no cluster ElasticSearch. | No | 1 |
| transportPort	   | A porta usada para comunicação nó-para-nó no cluster ElasticSearch.	| No | 9600 |

#### clusterName
{: #clustername }
Use o atributo **clusterName** para especificar um nome de sua escolha para o cluster ElasticSearch.

Um cluster ElasticSearch consiste em um ou mais nós que compartilham o mesmo nome de cluster, portanto, é possível especificar o mesmo valor para o atributo **clusterName** se você configurar vários nós.

#### nodeName
{: #nodename }
Use o atributo **nodeName** para especificar um nome de sua escolha para o nó para configurar no cluster ElasticSearch. Cada nome de nó deve ser exclusivo no cluster ElasticSearch, mesmo se os nós incluírem várias máquinas.

#### mastersList
{: #masterslist }
Use o atributo **mastersList** para fornecer uma lista separada por vírgula dos nós principais em seu cluster ElasticSearch. Cada nó principal nessa lista deve ser identificado por seu nome de host e porta de comunicação nó-para-nó ElasticSearch. Essa porta é 9600, por padrão, ou o número da porta que você especificou com o atributo **transportPort** ao configurar esse nó principal.

Por exemplo: `hostname1:transport-port1, hostname2:transport-port2`.

**Nota:**

* Se você especificar um **transportPort** diferente do valor padrão 9600, também será necessário configurar esse valor com o atributo **transportPort**. Por padrão, quando o atributo **mastersList** é omitido, é feita uma tentativa de detectar o nome do host e a porta de transporte ElasticSearch em todos os servidores de aplicativos suportados.
* Se o servidor do aplicativo de destino for um cluster do WebSphere Application Server Network Deployment e se você incluir ou remover um servidor desse cluster em um momento posterior, deverá editar essa lista manualmente para manter-se em sincronização com o cluster ElasticSearch.

#### dataPath
{: #datapath }
Use o atributo **dataPath** para especificar um diretório diferente para armazenar dados ElasticsSearch. É possível especificar um caminho absoluto ou um caminho relativo.

Se o atributo **dataPath** não for especificado, os dados do cluster ElasticSearch serão armazenados no diretório padrão chamado **analyticsData**, cujo local depende do servidor de aplicativos:

* Para o perfil Liberty do WebSphere Application Server, o local é `${wlp.user.dir}/servers/serverName/analyticsData`.
* Para Apache Tomcat, o local é `${CATALINA_HOME}/bin/analyticsData`.
* Para o WebSphere Application Server e o WebSphere Application Server Network Deployment, o local é `${was.install.root}/profiles/<profileName>/analyticsData`.

O diretório **analyticsData** e a hierarquia de subdiretórios e arquivos que ele contém são criados automaticamente no tempo de execução, caso eles ainda não existam quando o componente de Serviço do {{ site.data.keys.mf_analytics }} receber eventos.

#### shards
{: #shards }
Use o atributo **shards** para especificar o número de shards para criar no cluster ElasticSearch.

#### replicasPerShard
{: #replicaspershard }
Use o atributo **replicasPerShard** para especificar o número de réplicas para criar para cada shard no cluster ElasticSearch.

Cada shard pode ter zero ou mais réplicas. Por padrão, cada shard tem uma réplica, mas o número de réplicas pode ser alterado dinamicamente em um índice existente no {{ site.data.keys.mf_analytics }}. Um shard de réplica nunca pode ser iniciado no mesmo nó que seu shard.

#### transportPort
{: #transportport }
Use o atributo **transportPort** para especificar uma porta que outros nós no cluster ElasticSearch devem usar durante a comunicação com esse nó. Deve-se assegurar que essa porta esteja disponível e acessível, caso esse nó esteja atrás de um proxy ou firewall.

### Para especificar um servidor de aplicativos
{: #to-specify-an-application-server-4 }
Use o elemento `<applicationserver>` para definir os parâmetros que dependem do servidor de aplicativos subjacente. O elemento `<applicationserver>` suporta os elementos a seguir.

**Nota:** Os atributos e os elementos internos desse elemento são descritos nas tabelas de [Tarefas Ant para instalação de ambientes de tempo de execução do {{ site.data.keys.product_adj }}](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Elemento                                   | Descrição	| Conta   |
|-------------------------------------------|---------------|---------|
| **websphereapplicationserver** ou **was** | Os parâmetros para o WebSphere Application Server.	| 0..1 |
| tomcat	                                | Os parâmetros para Apache Tomcat.	| 0..1 |

### Para especificar propriedades JNDI customizadas
{: #to-specify-custom-jndi-properties }
O elemento `<installanalytics>`, `<updateanalytics>`
e `<uninstallanalytics>` suportam o elemento a seguir:

| Elemento  | Descrição (Description) | Conta |
|----------|-------------|-------|
| property | Propriedades	 | 0..   |

Usando esse elemento, é possível definir suas próprias propriedades JNDI.

Esse elemento possui os atributos a seguir:

| Atributo  | Descrição (Description)                | Necessário | Padrão |
|------------|----------------------------|----------|---------|
| Nome       | O nome da propriedade.  | Sim      | Nenhuma    |
| valor	     | O valor da propriedade. |	Sim      | Nenhuma    |

## Bancos de dados de tempo de execução internos
{: #internal-runtime-databases }
Saiba mais sobre tabelas de banco de dados de tempo de execução, seu propósito e a ordem de magnitude de dados armazenados em cada tabela. Em bancos de dados relacionais, as entidades são organizadas em tabelas de banco de dados.

### Banco de dados usado pelo tempo de execução do {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-runtime }
A tabela a seguir fornece uma lista de tabelas de banco de dados de tempo de execução, suas descrições e como elas são usadas em bancos de dados relacionais.

| Nome da tabela de banco de dados relacional | Descrição (Description) | Ordem de magnitude |
|--------------------------------|-------------|--------------------|
| LICENSE_TERMS	                 | Armazena as várias métricas de licença capturadas cada vez que a tarefa de desatribuição de dispositivo é executada. | Dezenas de linhas. Esse valor não excede o valor configurado pela propriedade JNDI mfp.device.decommission.when. Para obter mais informações sobre propriedades JNDI, consulte [Lista de propriedades JNDI para tempo de execução do {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime) |
| ADDRESSABLE_DEVICE	         | Armazena as métricas de dispositivo endereçáveis diariamente. Uma entrada também é incluída cada vez que um cluster é iniciado.	| Cerca de 400 linhas. Entradas com mais de 13 meses de existência são excluídas diariamente. |
| MFP_PERSISTENT_DATA	         | Armazena instâncias de aplicativos clientes que foram registradas com o servidor OAuth, incluindo informações sobre o dispositivo, o aplicativo, os usuários associados ao cliente e o status do dispositivo. | Uma linha por par de dispositivo e aplicativo. |
| MFP_PERSISTENT_CUSTOM_ATTR	 | Atributos customizados associados a instâncias de aplicativos clientes. Atributos customizados são atributos específicos do aplicativo que foram registrados pelo aplicativo por cada instância do cliente. | Zero ou mais linhas por par de dispositivo e aplicativo |
| MFP_TRANSIENT_DATA	         | Contexto de autenticação de clientes e dispositivos | Duas linhas por par de dispositivo e aplicativo; se estiver usando conexão única de dispositivo, duas linhas extra por dispositivo. Para obter mais informações sobre SSO, consulte [Configurando conexão única (SSO) de dispositivo](../../../authentication-and-security/device-sso). |
| SERVER_VERSION	             | A versão do produto.	| Uma linha |

### Banco de dados usado pelo serviço de administração do {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-administration-service }
A tabela a seguir fornece uma lista de tabelas de banco de dados de administração, suas descrições e como elas são usadas em bancos de dados relacionais.

| Nome da tabela de banco de dados relacional | Descrição (Description) | Ordem de magnitude |
|--------------------------------|-------------|--------------------|
| ADMIN_NODE	                 | Armazena informações sobre os servidores que executam o serviço de administração. Em uma topologia independente com somente um servidor, essa entidade não é usada. | Uma linha por servidor; vazio se um servidor independente for usado. |
| AUDIT_TRAIL	                 | Armazena uma trilha de auditoria de todas as ações administrativas executadas com o serviço de administração. | Milhares de linhas. |
| CONFIG_LINKS	                 | Armazena os links para o serviço de atualização em tempo real. Adaptadores e aplicativos podem ter configurações armazenadas no serviço de atualização em tempo real, e os links são usados para localizar configurações.	| Centenas de linhas. Por adaptador, 2-3 linhas são usadas. Por aplicativo, 4-6 linhas são usadas. |
| FARM_CONFIG	                 | Armazena a configuração de nós farm quando um server farm é usado. | Dezenas de linhas; vazio se nenhum server farm for usado. |
| GLOBAL_CONFIG	                 | Armazena alguns dados de configuração global. | Uma linha. |
| PROJECT	                     | Armazena os nomes dos projetos implementados. | Dezenas de linhas. |
| PROJECT_LOCK	                 | Tarefas de sincronização de cluster interno. | Dezenas de linhas. |
| TRANSACTIONS	                 | Tabela de sincronização de cluster interno; armazena o estado de todas as ações administrativas atuais. | Dezenas de linhas. |
| MFPADMIN_VERSION	             | A versão do produto.	| Uma linha. |

### Banco de dados usado pelo serviço de atualização em tempo real do {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-live-update-service }
A tabela a seguir fornece uma lista de tabelas de banco de dados do serviço de atualização em tempo real, suas descrições e como elas são usadas em bancos de dados relacionais.

| Nome da tabela de banco de dados relacional | Descrição (Description) | Ordem de magnitude |
|--------------------------------|-------------|--------------------|
| CS_SCHEMAS	                 | Armazena os esquemas com versão que existem na plataforma.	| Uma linha por esquema. |
| CS_CONFIGURATIONS	             | Armazena instâncias de configurações para cada esquema com versão. | Uma linha por configuração |
| CS_TAGS	                     | Armazena os campos e valores pesquisáveis para cada instância de configuração.	| Linha para cada nome de campo e valor para cada campo pesquisável na configuração. |
| CS_ATTACHMENTS	             | Armazena os anexos para cada instância de configuração. | Uma linha por anexo. |
| CS_VERSION	                 | Armazena a versão do MFP que criou as tabelas ou instâncias. | Uma única linha na tabela com a versão do MFP. |

### Banco de dados usado pelo serviço de push do {{ site.data.keys.mf_server }}
{: #database-used-by-mobilefirst-server-push-service }
A tabela a seguir fornece uma lista de tabelas de banco de dados de serviço de push, suas descrições e como elas são usadas em bancos de dados relacionais.

| Nome da tabela de banco de dados relacional | Descrição (Description) | Ordem de magnitude |
|--------------------------------|-------------|--------------------|
| PUSH_APPS	                     | Tabela de notificação push; armazena detalhes de aplicativos push. | Uma linha por aplicativo. |
| PUSH_ENV	                     | Tabela de notificação push; armazena detalhes de ambientes push. | Dezenas de linhas. |
| PUSH_TAGS	                     | Tabela de notificação push; armazena detalhes de tags definidas.	     | Dezenas de linhas. |
| PUSH_DEVICES	                 | Tabela de notificação push. Armazena um registro por dispositivo.	         | Uma linha por dispositivo. |
| PUSH_SUBSCRIPTIONS	         | Tabela de notificação push. Armazena um registro por assinatura de tag. | Uma linha por assinatura de dispositivo. |
| PUSH_MESSAGES	                 | Tabela de notificação push; armazena detalhes de mensagens push.	 | Dezenas de linhas. |
| PUSH_MESSAGE_SEQUENCE_TABLE	 | Tabela de notificação push; armazena o ID de sequência gerado.	 | Uma linha. |
| PUSH_VERSION	                 | A versão do produto.	                                         | Uma linha. |

Para obter informações adicionais sobre como configurar os bancos de dados, consulte [Configurando bancos de dados](../prod-env/databases).

## Arquivos de configuração de amostra
{{ site.data.keys.product }} inclui inúmeros arquivos de amostra de configuração para ajudá-lo a começar a usar as tarefas Ant para instalar o {{ site.data.keys.mf_server }}.

A maneira mais fácil de começar a usar essas tarefas Ant é trabalhando com os arquivos de configuração de amostra fornecidos no diretório **MobileFirstServer/configuration-samples/** da distribuição do {{ site.data.keys.mf_server }}. Para obter informações adicionais sobre como instalar o {{ site.data.keys.mf_server }} com tarefas Ant, consulte [Instalando com tarefas Ant](../prod-env/appserver/#installing-with-ant-tasks).

### Lista de arquivos de configuração de amostra
{: #list-of-sample-configuration-files }
Selecione o arquivo de configuração de amostra apropriado. Os seguintes arquivos são fornecidos.

| Task                                                     | Derby                     | DB2                     | MySQL                     | Oracle                      |
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
| Criar bancos de dados com credenciais de administrador de banco de dados | create-database-derby.xml | create-database-db2.xml | create-database-mysql.xml | create-database-oracle.xml
| Instalar {{ site.data.keys.mf_server }} no Liberty	                   | configure-liberty-derby.xml | configure-liberty-db2.xml | configure-liberty-mysql.xml | (Consulte Nota sobre MySQL) | configure-liberty-oracle.xml |
| Instalar o {{ site.data.keys.mf_server }} no perfil completo do WebSphere Application Server, servidor único |	configure-was-derby.xml | configure-was-db2.xml | configure-was-mysql.xml (Consulte Nota sobre MySQL) | configure-was-oracle.xml |
| Instalar o {{ site.data.keys.mf_server }} no WebSphere Application Server Network Deployment (Consulte Nota sobre arquivos de configuração) | configure-wasnd-cluster-derby.xml, configure-wasnd-server-derby.xml, configure-wasnd-node-derby.xml. configure-wasnd-cell-derby.xml | configure-wasnd-cluster-db2.xml, configure-wasnd-server-db2.xml, configure-wasnd-node-db2.xml, configure-wasnd-cell-db2.xml | configure-wasnd-cluster-mysql.xml (Consulte Nota sobre MySQL),  configure-wasnd-server-mysql.xml (Consulte Nota sobre MySQL), configure-wasnd-node-mysql.xml (Consulte Nota sobre MySQL), configure-wasnd-cell-mysql.xml | configure-wasnd-cluster-oracle.xml, configure-wasnd-server-oracle.xml, configure-wasnd-node-oracle.xml, configure-wasnd-cell-oracle.xml |
| Instalar {{ site.data.keys.mf_server }} no Apache Tomcat	           | configure-tomcat-derby.xml | configure-tomcat-db2.xml | configure-tomcat-mysql.xml | configure-tomcat-oracle.xml |
| Instale o {{ site.data.keys.mf_server }} no Liberty Collective	       | Não relevante              | configure-libertycollective-db2.xml | configure-libertycollective-mysql.xml | configure-libertycollective-oracle.xml |

**Nota sobre MySQL:** O MySQL, em conjunto com o perfil Liberty do WebSphere Application Server ou o perfil completo do WebSphere Application Server não é classificado como uma configuração suportada. Para obter informações adicionais, consulte WebSphere Application Server Support Statement. Considere usar o IBM DB2 ou outro banco de dados que seja suportado pelo WebSphere Application Server para beneficiar-se de uma configuração que seja totalmente suportada pelo Suporte IBM.

**Nota sobre arquivos de configuração para WebSphere Application Server Network Deployment:** Os arquivos de configuração para **wasnd** contêm um escopo que pode ser configurado como **cluster**, **nó**, **servidor** ou **célula**. Por exemplo, para **configure-wasnd-cluster-derby.xml**, o escopo é **cluster**. Esses tipos de escopo definem o destino de implementação da seguinte forma:

* **cluster**: para implementar em um cluster.
* **server**: para implementar em um único servidor que seja gerenciado pelo gerenciador de implementação.
* **node**: para implementar em todos os servidores em execução em um nó, mas que não pertencem a um cluster.
* **cell**: para implementar em todos os servidores em uma célula.

## Arquivos de configuração de amostra para {{ site.data.keys.mf_analytics }}
{: #sample-configuration-files-for-mobilefirst-analytics }
{{ site.data.keys.product }} O inclui vários arquivos de configuração de amostra para ajudá-lo a começar a usar as tarefas Ant para instalar o {{ site.data.keys.mf_analytics }} Services e o {{ site.data.keys.mf_analytics_console }}.

A maneira mais fácil de começar a usar as tarefas Ant `<installanalytics>`, `<updateanalytics>`
e `<uninstallanalytics>` é trabalhando com os arquivos de configuração de amostra fornecidos no diretório **Analytics/configuration-samples/** da distribuição do {{ site.data.keys.mf_server }}.

### Etapa 1
{: #step-1 }
Selecione o arquivo de configuração de amostra apropriado. Os arquivos XML a seguir são fornecidos. Eles serão chamados de **configure-file.xml** nas próximas etapas.

| Task | Servidor de aplicativo |
|------|--------------------|
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no perfil Liberty do WebSphere Application Server | configure-liberty-analytics.xml |
| Instale os Serviços e o Console do {{ site.data.keys.mf_analytics }} no Apache Tomcat | configure-tomcat-analytics.xml |
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no perfil completo do WebSphere Application Server | configure-was-analytics.xml |
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no WebSphere Application Server Network Deployment, servidor único | configure-wasnd-server-analytics.xml |
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no WebSphere Application Server Network Deployment, célula | configure-wasnd-cell-analytics.xml |
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no WebSphere Application Server Network Deployment, nó | configure-wasnd-node.xml |
| Instalar o {{ site.data.keys.mf_analytics }} Services and Console no WebSphere Application Server Network Deployment, cluster | configure-wasnd-cluster-analytics.xml |

**Nota sobre arquivos de configuração para o WebSphere Application Server Network Deployment:**  
Os arquivos de configuração para wasnd contêm um escopo que pode ser configurado como **cluster**, **nó**, **servidor** ou **célula**. Por exemplo, para **configure-wasnd-cluster-analytics.xml**, o escopo é **cluster**. Esses tipos de escopo definem o destino de implementação da seguinte forma:

* **cluster**: para implementar em um cluster.
* **server**: para implementar em um único servidor que seja gerenciado pelo gerenciador de implementação.
* **node**: para implementar em todos os servidores em execução em um nó, mas que não pertencem a um cluster.
* **cell**: para implementar em todos os servidores em uma célula.

### Etapa 2
{: #step-2 }
Altere os direitos de acesso do arquivo de amostra para ser tão restritivo quanto possível. A Etapa 3 requer que você forneça algumas senhas. Se você tiver que impedir que outros usuários no mesmo computador saibam essas senhas, será necessário remover as permissões de leitura do arquivo para outros usuários, além de você. É possível usar um comando, como nos seguintes exemplos:

No UNIX: `chmod 600 configure-file.xml`
No Windows: `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### Etapa 3
{: #step-3 }
Da mesma forma, se seu servidor de aplicativos for o perfil Liberty do WebSphere Application Server, ou Apache Tomcat, e o servidor for destinado a ser iniciado somente a partir de sua conta do usuário, também será preciso remover as permissões de leitura para outros usuários, além de você, dos seguintes arquivos:

* Para o perfil Liberty do WebSphere Application Server: **wlp/usr/servers/<server>/server.xml**
* Para o Apache Tomcat: **conf/server.xml**

### Etapa 4
{: #step-4 }
Substitua os valores de item temporário pelas propriedades no início do arquivo.

**Nota:**  
Os seguintes caracteres especiais devem estar escapados quando eles forem usados nos valores dos scripts de XML Ant:

* O símbolo de dólar (`$`) deve ser escrito como $$, , a menos que você deseje referenciar explicitamente uma variável Ant através da sintaxe `${variable}`, conforme descrito na seção Propriedades do Manual do Apache Ant.
* O caractere e comercial (`&`) deve ser escrito como `&amp;`, a menos que você deseje fazer referência explicitamente a uma entidade XML.
* Aspas duplas (`"`) devem ser escritas como `&quot;`, exceto quando estiverem dentro de uma sequência que esteja entre aspas simples.

### Etapa 5
{: #step-5 }
Execute o comando: `ant -f configure-file.xml install`

Esse comando instala os componentes {{ site.data.keys.mf_analytics }} Services e {{ site.data.keys.mf_analytics_console }} no servidor de aplicativos.
Para instalar os componentes atualizados {{ site.data.keys.mf_analytics }} Services e {{ site.data.keys.mf_analytics_console }}, por exemplo, se você aplicar um fix pack do {{ site.data.keys.mf_server }}, execute o seguinte comando: `ant -f configure-file.xml minimal-update`.

Para reverter a etapa de instalação, execute o comando: `ant -f configure-file.xml uninstall`

Esse comando desinstala os componentes {{ site.data.keys.mf_analytics }} Services e {{ site.data.keys.mf_analytics_console }}.
