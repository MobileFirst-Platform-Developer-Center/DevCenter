---
layout: tutorial
title: Configurando bancos de dados
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Os componentes do {{ site.data.keys.mf_server_full }} a seguir precisam armazenar dados técnicos em um banco de dados:

* Serviço de Administração do {{ site.data.keys.mf_server }}
* Serviço de atualização em tempo real do {{ site.data.keys.mf_server }}
* serviço de push do {{ site.data.keys.mf_server }}
* Tempo de execução
{{ site.data.keys.product }}

> **Nota:** Se várias instâncias de tempo de execução estiverem instaladas com uma raiz de contexto diferente, cada instância precisará de seu próprio conjunto de tabelas.
> O banco de dados pode ser um banco de dados relacional, como IBM DB2, Oracle ou MySQL.

#### Bancos de dados relacionais (DB2, Oracle ou MySQL)
{: #relational-databases-db2-oracle-or-mysql }
Cada componente precisa de um conjunto de tabelas. As tabelas podem ser criadas manualmente executando os scripts SQL específicos para cada componente (consulte [Criar as tabelas de banco de dados manualmente](#create-the-database-tables-manually)), usando Tarefas Ant ou o Server Configuration Tool. Os nomes da tabela de cada componente não se sobrepõem. Assim, é possível colocar todas as tabelas desses componentes sob um único esquema.

Entretanto, se você decidir instalar várias instâncias do tempo de execução do {{ site.data.keys.product }}, cada uma com sua raiz de contexto no servidor de aplicativos, cada instância precisará ter seu próprio conjunto de tabelas. Nesse caso, elas precisam estar em esquemas diferentes.

> **Nota sobre o DB2:** Os licenciados do {{ site.data.keys.product_adj }} estão autorizados a usar o DB2 como um sistema de suporte para o Foundation. Para beneficiar-se disso você deve, depois de instalar o software DB2:
> 
> * Faça o download a imagem de ativação de uso restrito direetamente do [website do IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)
> * Aplicar o arquivo de licença de ativação de uso restrito **db2xxxx.lic** usando o comando **db2licm**
>
> Saiba mais no [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html)

#### Ir para
{: #jump-to }

* [Usuários do banco de dados e privilégios](#database-users-and-privileges)
* [Requisitos do banco de dados](#database-requirements)
* [Crie as tabelas de banco de dados manualmente](#create-the-database-tables-manually)
* [Criar as tabelas de banco de dados com o Server Configuration Tool](#create-the-database-tables-with-the-server-configuration-tool)
* [Crie tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks)

## Usuários do banco de dados e privilégios
{: #database-users-and-privileges }
No tempo de execução, os aplicativos {{ site.data.keys.mf_server }} no servidor de aplicativos usam origens de dados como recursos para obter uma conexão com bancos de dados relacionais. A origem de dados precisa de um usuário com certos privilégios para acessar o banco de dados.

É necessário configurar uma origem de dados para cada aplicativo {{ site.data.keys.mf_server }} implementado para o servidor de aplicativos ter acesso ao banco de dados relacional. A origem de dados requer um usuário com privilégios específicos para acessar o banco de dados. O número de usuários que você precisa criar depende do procedimento de instalação usado para implementar aplicativos
{{ site.data.keys.mf_server }} no servidor de aplicativos.

### Instalação com o Server Configuration Tool
{: #installation-with-the-server-configuration-tool }
O mesmo usuário é usado para todos os componentes (serviço de administração do {{ site.data.keys.mf_server }}, serviço de configuração do {{ site.data.keys.mf_server }}, serviço de push do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product }})

### Instalação com tarefas Ant
{: #installation-with-ant-tasks }
Os arquivos Ant de amostra que são fornecidos na distribuição do produto usam o mesmo usuário para todos os componentes. Entretanto, é possível modificar os arquivos Ant para se ter diferentes usuários:

* O mesmo usuário para o serviço de administração e o serviço de configuração, já que eles não podem ser instalados separadamente com tarefas Ant.
* Um usuário diferente para o tempo de execução
* Um usuário diferente para o serviço de push.

### Manual de Instalação
{: #manual-installation }
É possível designar uma origem de dados diferente e, assim, um usuário diferente, a cada um dos componentes do {{ site.data.keys.mf_server }}.
No tempo de execução, os usuários devem ter os seguintes privilégios nas tabelas e sequências de seus dados:

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Se as tabelas não forem criadas manualmente antes de você executar a instalação com Tarefas Ant ou o Server Configuration Tool, certifique-se de que tenha um usuário capaz de criar as tabelas. Ele também precisa dos seguintes privilégios:

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

Para um upgrade do produto, ele precisa destes privilégios adicionais:

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## Requisitos de Banco de Dados
{: #database-requirements }
O banco de dados armazena todos os dados dos aplicativos {{ site.data.keys.mf_server }}. Antes da instalação dos componentes do {{ site.data.keys.mf_server }}, assegure-se de que os requisitos do banco de dados sejam atendidos.

* [Requisitos de usuário e banco de dados do DB2](#db2-database-and-user-requirements)
* [Requisitos de usuário e banco de dados Oracle](#oracle-database-and-user-requirements)
* [Requisitos de usuário e banco de dados do MySQL](#mysql-database-and-user-requirements)

> Para obter uma lista atualizada de versões de software de banco de dados suportadas, consulte a página [Requisitos do sistema](../../../product-overview/requirements/).

### Requisitos de usuário e banco de dados do DB2
{: #db2-database-and-user-requirements }
Revise o requisito do banco de dados para o DB2. Siga as etapas para criar usuário e banco de dados e configure seu banco de dados para atender ao requisito específico.

Certifique-se de configurar o conjunto de caracteres do banco de dados como UTF-8.

O tamanho da página do banco de dados deve ser menor que 32768. O procedimento a seguir cria um banco de dados com um tamanho de página de 32768. Ele também cria um usuário (**mfpuser**) e, em seguida, concede a ele acesso ao banco de dados. Esse usuário pode então ser usado pelo Server Configuration Tool ou pelas tarefas Ant para criar as tabelas.

1. Crie um usuário do sistema chamado, por exemplo, **mfpuser**, em um grupo de administradores do DB2, como **DB2USERS**, usando os comandos apropriados para seu sistema operacional. Forneça uma senha, por exemplo, **mfpuser**.
2. Abra um processador de linha de comandos do DB2, com um usuário que tenha permissões **SYSADM** ou **SYSCTRL**.
    * Em sistemas Windows, clique em **Iniciar → IBM DB2 → Processador de Linha de Comandos**.
    * Em sistemas Linux ou UNIX, acesse **~/sqllib/bin** e insira `./db2`.
3. Para criar o banco de dados do {{ site.data.keys.mf_server }}, insira as instruções SQL semelhantes ao exemplo a seguir.

Substitua o nome **mfpuser** pelo seu.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Requisitos de usuário e banco de dados Oracle
{: #oracle-database-and-user-requirements }
Revise o requisito do banco de dados para o Oracle. Siga as etapas para criar usuário e banco de dados e configure seu banco de dados para atender ao requisito específico.

Certifique-se de configurar o conjunto de caracteres do banco de dados como um conjunto de caracteres Unicode (AL32UTF8) e o conjunto de caracteres nacionais como UTF8 - Unicode 3.0 UTF-8.  

O usuário de tempo de execução (conforme discutido em [Usuários e privilégios do banco de dados](#database-users-and-privileges)) deve ter um espaço de tabela associado e uma cota suficiente para gravar dados técnicos requeridos pelos serviços do {{ site.data.keys.product }}. Para obter informações adicionais sobre as tabelas que são usadas pelo produto, consulte [Bancos de dados de tempo de execução internos](../installation-reference/#internal-runtime-databases).

As tabelas devem ser criadas no esquema padrão para o usuário do tempo de execução. As tarefas Ant e o Server Configuration Tool criam as tabelas no esquema padrão do usuário transmitido como argumento. Para obter informações adicionais sobre a criação de tabelas, consulte [Criando as tabelas de banco de dados Oracle manualmente](#creating-the-oracle-database-tables-manually).

O procedimento cria um banco de dados, caso haja necessidade. Um usuário que pode criar tabelas e índices nesse banco de dados é incluído e usado como usuário do tempo de execução.

1. Se você ainda não tiver um banco de dados, use o Oracle Database Configuration Assistant (DBCA) e siga as etapas no assistente para criar um novo banco de dados de propósito geral chamado ORCL neste exemplo:
    * Use o nome do banco de dados global **ORCL\_your\_domain**, e o identificador do sistema (SID) **ORCL**.
    * Na guia **Scripts customizados** da etapa **Conteúdo do banco de dados**, não execute os scripts SQL porque você deve criar primeiro uma conta do usuário.
    * Na guia **Conjuntos de Caracteres** da etapa **Parâmetros de Inicialização**, selecione **Usar o conjunto de caracteres Unicode (AL32UTF8) e o conjunto de caracteres nacional UTF8 – Unicode 3.0 UTF-8**.
    * Conclua o procedimento, aceitando os valores padrão.
2. Crie um usuário do banco de dados usando Oracle Database Control ou o interpretador de linha de comandos do Oracle, SQLPlus.
3. Usando Oracle Database Control:
    * Conecte-se como **SYSDBA**.
    * Acesse a página **Usuários** e clique em **Servidor**, em seguida, **Usuários** na seção **Segurança**.
    * Crie um usuário, por exemplo, **MFPUSER**.
    * Designe os seguintes atributos:
        * **Perfil**: DEFAULT
        * **Autenticação**: password
        * **Espaço de tabela padrão**: USERS
        * **Espaço de tabela temporário**: TEMP
        * **Status**: desbloqueado
        * Incluir privilégio no sistema : CREATE SESSION
        * Incluir privilégio no sistema : CREATE SEQUENCE
        * Add system privilege: CREATE TABLE
        * Incluir cota: ilimitado para espaço de tabela USERS
    * Usando o interpretador de linha de comandos do Oracle, SQLPlus:

Os comandos no exemplo a seguir criam um usuário denominado **MFPUSER** para o banco de dados:

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### Requisitos de usuário e banco de dados do MySQL
{: #mysql-database-and-user-requirements }
Revise o requisito do banco de dados para o MySQL. Siga as etapas para criar usuário e banco de dados e configure seu banco de dados para atender ao requisito específico.

Certifique-se de configurar o conjunto de caracteres para UTF8.

As propriedades a seguir devem ser designadas com valores apropriados:

* max_allowed_packet com 256 M ou mais
* innodb_log_file_size com 250 M ou mais

Para obter informações adicionais sobre como configurar as propriedades, consulte a [documentação do MySQL](http://dev.mysql.com/doc/).  
O procedimento cria um banco de dados (MFPDATA) e um usuário (mfpuser) que podem se conectar ao banco de dados com todos os privilégios de um host (mfp-host).

1. Execute um cliente da linha de comando MySQL com a opção `-u root`.
2. Insira os comandos a seguir:

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    Em que mfpuser antes do sinal de "arroba" (@) é o nome do usuário, **mfpuser-password** após **IDENTIFIED BY** é sua senha e **mfp-host** é o nome do host no qual o {{ site.data.keys.product_adj }} é executado.
    
    O usuário deve estar apto para conectar-se ao servidor MySQL a partir dos hosts que executam o servidor de aplicativos Java com os aplicativos {{ site.data.keys.mf_server }} instalados.
    
## Crie as tabelas de banco de dados manualmente
{: #create-the-database-tables-manually }
As tabelas de banco de dados para os aplicativos do {{ site.data.keys.mf_server }} podem ser criadas manualmente, com Tarefas Ant ou com o Server Configuration Tool. Os tópicos fornecem a explicação e os detalhes sobre como criá-las manualmente.

* [Criando tabelas de banco de dados DB2 manualmente](#creating-the-db2-database-tables-manually)
* [Criando tabelas de banco de dados Oracle manualmente](#creating-the-oracle-database-tables-manually)
* [Criando as tabelas de banco de dados MySQL manualmente](#creating-the-mysql-database-tables-manually)

### Criando tabelas de banco de dados DB2 manualmente
{: #creating-the-db2-database-tables-manually }
Use os scripts SQL que são fornecidos na instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados DB2.

Conforme descrito na seção Visão Geral, todos os quatro componentes do {{ site.data.keys.mf_server }} precisam de tabelas. Eles podem
ser criados no mesmo esquema ou em esquemas diferentes. No entanto, algumas restrições se aplicam dependendo de como aplicativos {{ site.data.keys.mf_server }} são implementados no servidor de aplicativos Java. Eles são semelhantes ao tópico sobre os possíveis usuários para DB2, conforme descrito em [Usuários e privilégios do banco de dados](#database-users-and-privileges).

#### Instalação com o Server Configuration Tool
{: #installation-with-the-server-configuration-tool-1 }
O mesmo esquema é usado para todos os componentes (serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, serviço de push do
{{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product }})

#### Instalação com tarefas Ant
{: #installation-with-ant-tasks-1 }
Os arquivos Ant de amostra que são fornecidos na distribuição do produto usam o mesmo esquema para todos os componentes. Entretanto, é possível modificar os arquivos Ant para se ter diferentes esquemas:

* O mesmo esquema aplica-se ao serviço de administração e serviço de atualização em tempo real, já que eles não podem ser instalados separadamente com tarefas Ant.
* Um esquema diferente para o tempo de execução
* Um esquema diferente para o serviço de push.

#### Manual de Instalação
{: #manual-installation-1 }
É possível designar uma origem de dados diferente e, assim, um esquema diferente, a cada um dos componentes do {{ site.data.keys.mf_server }}.  
Os scripts para criar as tabelas são os seguintes:

* Para o serviço de administração, em **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**.
* Para o serviço de atualização em tempo real, em **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**.
* Para o componente de tempo de execução, em **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**.
* Para o serviço de push, em **mfp\_install\_dir/PushService/databases/create-push-db2.sql**.

O procedimento a seguir cria as tabelas para todos os aplicativos no mesmo esquema (MFPSCM). Ele supõe que um banco de dados e um usuário já tenham sido criados. Para obter informações adicionais, consulte [Requisitos do banco de dados DB2 e do usuário](#db2-database-and-user-requirements).

Execute o DB2 com os seguintes comandos com o usuário (mfpuser):

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

Se as tabelas forem criadas por mfpuser, esse usuário terá privilégios nas tabelas automaticamente e poderá usá-las no tempo de execução. Se desejar restringir os privilégios do usuário de tempo de execução conforme descrito em [Usuários e privilégios do banco de dados](#database-users-and-privileges) ou um controle mais preciso de privilégios, consulte a documentação do DB2.

### Criando tabelas de banco de dados Oracle manualmente
{: #creating-the-oracle-database-tables-manually }
Use os scripts SQL fornecidos na instalação do {{ site.data.keys.mf_server }} para criar tabelas de banco de dados Oracle.

Conforme descrito na seção Visão Geral, todos os quatro componentes do {{ site.data.keys.mf_server }} precisam de tabelas. Eles podem
ser criados no mesmo esquema ou em esquemas diferentes. No entanto, algumas restrições se aplicam dependendo de como aplicativos {{ site.data.keys.mf_server }} são implementados no servidor de aplicativos Java. Os detalhes são descritos em [Usuários e privilégios do banco de dados](#database-users-and-privileges).

As tabelas devem ser criadas no esquema padrão do usuário do tempo de execução. Os scripts para criar as tabelas são os seguintes:

* Para o serviço de administração, em **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**.
* Para o serviço de atualização em tempo real, em **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**.
* Para o componente de tempo de execução, em **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**.
* Para o serviço de push, em **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**.

O procedimento a seguir cria as tabelas para todos os aplicativos para o mesmo usuário (**MFPUSER**). Ele supõe que um banco de dados e um usuário já tenham sido criados. Para obter informações adicionais, consulte [Requisitos do banco de dados Oracle e do usuário](#oracle-database-and-user-requirements).

Execute os comandos a seguir no Oracle SQLPlus:

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

Se as tabelas forem criadas por MFPUSER, esse usuário terá os privilégios nas tabelas automaticamente e poderá usá-las no tempo de execução. As tabelas são criadas no esquema padrão do usuário. Se desejar restringir os privilégios do usuário de tempo de execução conforme descrito em [Usuários e privilégios do banco de dados](#database-users-and-privileges) ou ter um controle mais preciso de privilégios, consulte a documentação do Oracle.

### Criando as tabelas de banco de dados MySQL manualmente
{: #creating-the-mysql-database-tables-manually }
Use os scripts SQL que são fornecidos na instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados MySQL.

Conforme descrito na seção Visão Geral, todos os quatro componentes do {{ site.data.keys.mf_server }} precisam de tabelas. Eles podem
ser criados no mesmo esquema ou em esquemas diferentes. No entanto, algumas restrições se aplicam dependendo de como aplicativos {{ site.data.keys.mf_server }} são implementados no servidor de aplicativos Java. Eles são semelhantes ao tópico sobre os possíveis usuários para MySQL, conforme descrito em [Usuários e privilégios do banco de dados](#database-users-and-privileges).

#### Instalação com o Server Configuration Tool
{: #installation-with-the-server-configuration-tool-2 }
O mesmo banco de dados é usado para todos os componentes (serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, serviço de push do {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.product }})

#### Instalação com tarefas Ant
{: #installation-with-ant-tasks-2 }
Os arquivos Ant de amostra que são fornecidos na distribuição do produto usam o mesmo banco de dados para todos os componentes. Entretanto, é possível modificar os arquivos Ant para terem um banco de dados diferente:

* O mesmo banco de dados para o serviço de administração e serviço de atualização em tempo real, já que eles não podem ser instalados separadamente com tarefas Ant.
* Um banco de dados diferente para o tempo de execução
* Um banco de dados diferente para o serviço de push.

#### Manual de Instalação
{: #manual-installation-2 }
É possível designar uma origem de dados diferente e, assim, um banco de dados diferente, a cada um dos componentes do {{ site.data.keys.mf_server }}.  
Os scripts para criar as tabelas são os seguintes:

* Para o serviço de administração, em **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**.
* Para o serviço de atualização em tempo real, em **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**.
* Para o componente de tempo de execução, em **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**.
* Para o serviço de push, em **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**.

O exemplo a seguir cria as tabelas para todos os aplicativos para o mesmo usuário e banco de dados. Ele supõe que um banco de dados e um usuário foram criados como em [Requisitos para os bancos de dados para MySQL](#database-requirements).

O procedimento a seguir cria as tabelas para todos os aplicativos para o mesmo usuário (mfpuser) e banco de dados (MFPDATA). Ele supõe que um banco de dados e um usuário já tenham sido criados.

1. Execute um cliente da linha de comando MySQL com a opção: `-u mfpuser`.
2. Insira os comandos a seguir:

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## Criar as tabelas de banco de dados com o Server Configuration Tool
{: #create-the-database-tables-with-the-server-configuration-tool }
As tabelas de banco de dados para os aplicativos do {{ site.data.keys.mf_server }} podem ser criadas manualmente, com Tarefas Ant ou com o Server Configuration Tool. Os tópicos fornecem explicação e detalhes sobre a configuração do banco de dados quando você instala o {{ site.data.keys.mf_server }} com o Server Configuration Tool.

O Server Configuration Tool pode criar as tabelas de banco de dados como parte do processo de instalação. Em alguns casos, ele pode até criar um banco de dados e um usuário para os componentes do {{ site.data.keys.mf_server }}. Para obter uma visão geral do processo de instalação com o Server Configuration Tool, consulte [Instalando o {{ site.data.keys.mf_server }} no modo gráfico](../tutorials/graphical-mode).

Depois de concluir as credenciais de configuração e clicar em **Implementar** na área de janela Server Configuration Tool, as seguintes operações são executadas:

* Crie o banco de dados e o usuário, se necessário.
* Verifique se existem tabelas do {{ site.data.keys.mf_server }} no banco de dados. Se elas não existirem, crie-as.
* Implemente aplicativos {{ site.data.keys.mf_server }} no servidor de aplicativos.

Se as tabelas de banco de dados forem criadas manualmente antes de você executar o Server Configuration Tool, a ferramenta poderá detectá-las e ignorar a fase de configuração das tabelas.

Dependendo de sua escolha de sistema de gerenciamento de banco de dados (DBMS) suportado, selecione um dos tópicos a seguir para obter mais detalhes sobre como a ferramenta cria as tabelas de banco de dados.

* [Criando as tabelas de banco de dados DB2 com o Server Configuration Tool](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Criando as tabelas de banco de dados Oracle com o Server Configuration Tool](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [Criando as tabelas de banco de dados MySQL com o Server Configuration Tool](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### Criando as tabelas de banco de dados DB2 com o Server Configuration Tool
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
Use o Server Configuration Tool fornecido com a instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados DB2.

O Server Configuration Tool pode criar um banco de dados na instância padrão do DB2. No painel **Seleção de banco de dados** do Server Configuration Tool, selecione a opção IBM DB2. Nas próximas três áreas de janela, insira as credenciais de banco de dados. Se o nome do banco de dados inserido no painel **Configurações Adicionais do Banco de Dados** não existir na instância do DB2, é possível inserir informações adicionais para ativar a ferramenta para criar um banco de dados para você.

O Server Configuration Tool cria as tabelas de banco de dados com configurações padrão com a seguinte instrução SQL:
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Ela não deve ser usada para produção, já que em uma instalação DB2 padrão, muitos privilégios são concedidos a PUBLIC.

### Criando as tabelas de banco de dados Oracle com o Server Configuration Tool
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
Use o Server Configuration Tool fornecido com a instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados Oracle.

No painel Seleção de banco de dados do Server Configuration Tool, selecione a opção **Oracle Standard ou Enterprise Editions, 11g ou 12c**. Nas próximas três áreas de janela, insira as credenciais de banco de dados.

Quando você inserir o nome do usuário do Oracle no painel **Configurações Adicionais do Banco de Dados**, ele deverá estar em letra maiúscula. Se você tiver um usuário do banco de dados Oracle (FOO), mas inserir um nome do usuário com letras minúsculas (foo), o Server Configuration Tool o considerará como outro usuário. Ao contrário de outras ferramentas para o banco de dados Oracle, o Server Configuration Tool protege o nome do usuário contra conversão automática em letras maiúsculas.

O Server Configuration Tool usa um nome de serviço ou um Identificador do Sistema Oracle (SID) para identificar um banco de dados. No entanto, se desejar estabelecer a conexão com o Oracle RAC, você precisará inserir uma URL JDBC complexa. Nesse caso, no painel **Configurações do Banco de Dados**, selecione **Conectar Usando URLs JDBC do Oracle Genéricas** e insira uma URL para o thin driver Oracle.

Se for necessário criar um banco de dados e um usuário para o Oracle, use a ferramenta Oracle Database Creation Assistant (DBCA). Para obter informações adicionais, consulte [Requisitos do banco de dados Oracle e do usuário](#oracle-database-and-user-requirements).

O Server Configuration Tool pode fazer o mesmo, mas com uma limitação. A ferramenta pode criar um usuário para o Oracle 11 g ou Oracle 12 g. Entretanto, é possível criar um banco de dados somente para Oracle 11g, e não para Oracle 12c.

Se o nome do banco de dados ou nome do usuário inserido no painel **Configurações Adicionais do Banco de Dados** não existir, consulte as duas seções a seguir para conhecer as etapas extra para criar o banco de dados ou usuário.

#### Criando o banco de dados
{: #creating-the-database }

1. Execute um servidor SSH no computador que execute o banco de dados Oracle.

    O Server Configuration Tool abre uma sessão SSH para o host Oracle para criar o banco de dados. Exceto no Linux e em algumas versões de sistemas UNIX, o servidor SSH é necessário, mesmo que o banco de dados Oracle seja executado no mesmo computador que o Server Configuration Tool.

2. No painel **Solicitação de Criação de Banco de Dados**, insira o ID e a senha de login de um usuário do banco de dados Oracle que tenha privilégios para criar um banco de dados.
3. No mesmo painel, insira também a senha para o usuário **SYS** e o usuário **SYSTEM** para o banco de dados que deve ser criado.

Um banco de dados é criado com o nome do SID que é inserido no painel **Configurações Adicionais do Banco de Dados**. Ele não deve ser usado para produção.

#### Criando o usuário
{: #creating-the-user }

1. Execute um servidor SSH no computador que execute o banco de dados Oracle.

    O Server Configuration Tool abre uma sessão SSH para o host Oracle para criar o banco de dados. Exceto no Linux e em algumas versões de sistemas UNIX, o servidor SSH é necessário, mesmo que o banco de dados Oracle seja executado no mesmo computador que o Server Configuration Tool.

2. No painel **Configurações Adicionais do Banco de Dados**, insira o ID e a senha de login do usuário do banco de dados que deve ser criado.
3. No painel **Solicitação de Criação de Banco de Dados**, insira o ID e a senha de login de um usuário do banco de dados Oracle que tenha privilégios para criar um usuário do banco de dados.
4. No mesmo painel, insira também a senha para o usuário **SYSTEM** do banco de dados.

### Criando as tabelas de banco de dados MySQL com o Server Configuration Tool
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
Use o Server Configuration Tool fornecido com a instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados MySQL.

O Server Configuration Tool pode criar um banco de dados MySQL para você. No painel **Seleção de banco de dados** do Server Configuration Tool, selecione a opção **MySQL 5.5.x, 5.6.x ou 5.7.x**. Nas próximas três áreas de janela, insira as credenciais de banco de dados. Se o banco de dados ou o usuário inserido no painel Configurações adicionais do banco de dados não existir, a ferramenta poderá criá-lo.

Se o servidor MySQL não tiver as configurações recomendadas em [Requisitos do banco de dados MySQL e do usuário](#mysql-database-and-user-requirements), o Server Configuration Tool exibirá um aviso. Certifique-se de preencher os requisitos antes de executar o Server Configuration Tool.

O procedimento a seguir fornece algumas etapas extra que devem ser executadas quando você criar as tabelas de banco de dados com a ferramenta.

1. No painel **Configurações Adicionais do Banco de Dados**, além das configurações de conexão, deve-se inserir todos os hosts a partir dos quais o usuário tem permissão para se conectar ao banco de dados. Ou seja, todos os hosts nos quais o {{ site.data.keys.mf_server }} é executado.
2. No painel **Solicitação de Criação de Banco de Dados**, insira o ID e a senha de login de um administrador do MySQL. Por padrão, o administrador é raiz.

## Crie tabelas de banco de dados com tarefas Ant
{: #create-the-database-tables-with-ant-tasks }
As tabelas de banco de dados para os aplicativos do {{ site.data.keys.mf_server }} podem ser criadas manualmente, com Tarefas Ant ou com o Server Configuration Tool. Os tópicos fornecem explicação e detalhes sobre como criá-las com tarefas Ant.

É possível localizar informações relevantes nesta seção sobre a configuração do banco de dados, caso o
{{ site.data.keys.mf_server }} seja instalado com tarefas Ant.

É possível usar tarefas Ant para configurar as tabelas de banco de dados do {{ site.data.keys.mf_server }}. Em alguns casos, também é possível criar um banco de dados e um usuário com essas tarefas. Para obter uma visão geral do processo de instalação com tarefas Ant, consulte [Instalando o {{ site.data.keys.mf_server }} no modo de linha de comando](../tutorials/command-line).

Um conjunto de arquivos Ante de amostra é fornecido com a instalação para ajudá-lo a começar a usar tarefas Ant. É possível localizar os arquivos em **mfp\_install\_dir/MobileFirstServer/configurations-samples**. Os arquivos são nomeados de acordo com os seguintes padrões:

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Os arquivos Ant podem executar estas tarefas:

* Criar as tabelas em um banco de dados, caso o banco de dados e o usuário do banco de dados existam. Os requisitos para o banco de dados estão listados em [Requisitos do banco de dados](#database-requirements).
* Implementar os arquivos WAR dos componentes do {{ site.data.keys.mf_server }} no servidor de aplicativos. Esses arquivos Ant usam o mesmo usuário do banco de dados para criar as tabelas e para instalar o usuário do banco de dados de tempo de execução para os aplicativos no tempo de execução. Os arquivos também usam o mesmo usuário do banco de dados para todos os aplicativos do {{ site.data.keys.mf_server }}.

#### create-database-dbms.xml
{: #create-database-dbmsxml }
Os arquivos Ant podem criar um banco de dados se for necessário no sistema de gerenciamento de banco de dados (DBMS) e depois criar as tabelas no banco de dados. No entanto, como o banco de dados é criado com configurações padrão, ele não deve ser usado para produção.

Nos arquivos Ant, é possível localizar os destinos predefinidos que usam a tarefa Ant **configureDatabase** para configurar o banco de dados. Para obter informações adicionais, consulte a referência de tarefa [Ant configuredatabase](../installation-reference/#ant-configuredatabase-task-reference).

### Usando os arquivos Ant de amostra
{: #using-the-sample-ant-files }
Os arquivos Ant de amostra têm destinos predefinidos. Siga este procedimento para usar os arquivos.

1. Copie o arquivo Ant de acordo com seu servidor de aplicativos e configuração do banco de dados em um diretório ativo.
2. Edite o arquivo e insira os valores para sua configuração na seção `<! -- Start of Property Parameters -->` para o arquivo Ant.
3. Execute o arquivo Ant com o destino do banco de dados: `mfp_install_dir/shortcuts/ant -f your_ant_file databases`.

Esse comando cria as tabelas no banco de dados e no esquema especificados para todos os aplicativos {{ site.data.keys.mf_server }} (serviço de administração do {{ site.data.keys.mf_server }}, serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, serviço de push do  {{ site.data.keys.mf_server }} e tempo de execução do {{ site.data.keys.mf_server }}). Um log para as operações é produzido e armazenado em seu disco.

* No Windows, ele está no diretório **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\**.
* No UNIX, ele está no diretório **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/**.

### Diferentes usuários para a criação de tabelas de banco de dados e para tempo de execução
{: #different-users-for-the-database-tables-creation-and-for-run-time }
Os arquivos Ant de amostra em **mfp\_install\_dir/MobileFirstServer/configurations-samples** usam o mesmo usuário do banco de dados para:

* Todos os aplicativos {{ site.data.keys.mf_server }} (serviço de administração, serviço de atualização em tempo real, serviço de push e tempo de execução)
* O usuário usado para criar o banco de dados e o usuário no tempo de execução para a origem de dados no servidor de aplicativos.

Se desejar separar os usuários conforme descrito em [Usuários e privilégios do banco de dados](#database-users-and-privileges), é necessário criar seu próprio arquivo Ant, ou modificar os arquivos Ant de amostra para que cada destino de banco de dados tenha um usuário diferente. Para obter informações adicionais, consulte a [Referência de instalação](../installation-reference).

Para DB2 e MySQL, é possível ter diferentes usuários para a criação de banco de dados e para o tempo de execução. Os privilégios para cada tipo de usuário são listados em [Usuários e privilégios do banco de dados](#database-users-and-privileges). Para Oracle, não é possível ter um usuário diferente para a criação de banco de dados e para o tempo de execução. As tarefas Ant consideram que as tabelas estão no esquema padrão de um usuário. Se desejar reduzir privilégios para o usuário do tempo de execução, deve-se criar as tabelas manualmente no esquema padrão do usuário que será usado no tempo de execução. Para obter informações adicionais, consulte [Criando as tabelas de banco de dados Oracle manualmente](#creating-the-oracle-database-tables-manually).

Dependendo de sua escolha de sistema de gerenciamento de banco de dados (DBMS) suportado, selecione um dos tópicos a seguir para criar o banco de dados com tarefas Ant.

### Criando as tabelas de banco de dados DB2 com tarefas Ant
{: #creating-the-db2-database-tables-with-ant-tasks }
Use as tarefas Ant fornecidas com a instalação do {{ site.data.keys.mf_server }} para criar o banco de dados DB2.

Para criar as tabelas de banco de dados em um banco de dados que já existe, consulte [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks).

Para criar um banco de dados e tabelas de banco de dados, use tarefas Ant. As tarefas Ant criam um banco de dados na instância padrão do DB2 se você usar um arquivo Ant que contenha o elemento **dba**. Esse elemento pode ser localizado nos arquivos Ant de amostra chamados **create-database-<dbms>.xml**.

Antes de executar as tarefas Ant, certifique-se de ter um servidor SSH no computador que executa o banco de dados DB2. A tarefa Ant **configureDatabase** abre uma sessão do SSH para o host do DB2 para criar o banco de dados. O servidor SSH é necessário, mesmo se o banco de dados DB2 for executado no mesmo computador no qual você executa as tarefas Ant (exceto no Linux e em algumas versões de sistemas UNIX).

Siga as diretrizes gerais conforme descrito em [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks) para editar a cópia do arquivo **create-database-db2.xml**.

Também deve-se fornecer o ID e a senha de login de um usuário do DB2 com privilégios administrativos (permissões **SYSADM** ou **SYSCTRL**) no elemento **dba**. No arquivo Ant de amostra para DB2 (**create-database-db2.xml**), as propriedades para configurar são: **database.db2.admin.username** e **database.db2.admin.password**.

Quando o destino Ant **databases** é chamado, a tarefa Ant **configureDatabase** cria um banco de dados com configurações padrão com a seguinte instrução SQL:

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Ela não deve ser usada para produção, já que em uma instalação DB2 padrão, muitos privilégios são concedidos a PUBLIC.

### Criando as tabelas de banco de dados Oracle com tarefas Ant
{: #creating-the-oracle-database-tables-with-ant-tasks }
Use tarefas Ant que são fornecidas com a instalação do {{ site.data.keys.mf_server }} para criar tabelas de banco de dados Oracle.

Quando você inserir o nome do usuário do Oracle no arquivo Ant, ele deverá estar em letras maiúsculas. Se você tiver um usuário do banco de dados Oracle (FOO), mas inserir um nome do usuário com letras minúsculas (foo), a tarefa Ant **configureDatabase** o considerará como outro usuário. Ao contrário de outras ferramentas para banco de dados Oracle, a tarefa Ant **configureDatabase** protege o nome do usuário contra a conversão automática em letras maiúsculas.

A tarefa Ant **configureDatabase** usa um nome de serviço ou Identificador do Sistema (SID) do Oracle para identificar um banco de dados. No entanto, se desejar estabelecer a conexão com o Oracle RAC, você precisará inserir uma URL JDBC complexa. Nesse caso, o elemento **oracle** que está na tarefa Ant **configureDatabase** deve usar os atributos (**url**, **user** e **password**) em vez desses atributos (**database**, **server**, **port**, **user** e **password**). Para obter informações adicionais, consulte a tabela em [Referência de tarefa Ant **configuredatabase**](../installation-reference/#ant-configuredatabase-task-reference). Os arquivos Ant de amostra em **mfp\_install\_dir/MobileFirstServer/configurations-samples** usam os atributos **database**, **server**, **port**, **user** e **password** no elemento **oracle**. Eles devem ser modificados se você precisar se conectar ao Oracle com uma URL JDBC.

Para criar as tabelas de banco de dados em um banco de dados que já existe, consulte [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks).

Para criar um banco de dados, um usuário ou tabelas de banco de dados, use a ferramenta Oracle Database Creation Assistant (DBCA). Para obter informações adicionais, consulte [Requisitos do banco de dados Oracle e do usuário](#oracle-database-and-user-requirements).

A tarefa Ant **configureDatabase** pode fazer o mesmo, mas com uma limitação. A tarefa pode criar um usuário do banco de dados para Oracle 11 g ou Oracle 12 g. Entretanto, é possível criar um banco de dados somente para Oracle 11g, e não para Oracle 12c. Consulte as duas seções a seguir para conhecer as etapas extra necessárias para criar o banco de dados ou o usuário.

#### Criando o banco de dados
{: #creating-the-database-1 }
Siga as diretrizes gerais conforme descrito em [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks) para editar a cópia do arquivo **create-database-oracle.xml**.

1. Execute um servidor SSH no computador que execute o banco de dados Oracle.

    A tarefa Ant **configureDatabase** abre uma sessão do SSH para o host do Oracle para criar o banco de dados. Exceto no Linux e em algumas versões de sistemas UNIX, o servidor SSH é necessário, mesmo que o banco de dados Oracle seja executado no mesmo computador no qual as tarefas Ant são executadas.

2. No elemento **dba** definido no arquivo **create-database-oracle.xml**, insira o ID e a senha de login de um usuário do banco de dados Oracle que possa se conectar ao Oracle Server via SSH e que tenha privilégios para criar um banco de dados. É possível atribuir valores nas propriedades a seguir:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. No elemento **oracle**, insira o nome do banco de dados que deseja criar. O atributo é **database**. É possível designar o valor na propriedade **database.oracle.mfp.dbname**.
4. No mesmo elemento **oracle**, insira também a senha para o usuário **SYS** e o usuário **SYSTEM** para o banco de dados que deve ser criado. Os atributos são **sysPassword** e **systemPassword**. É possível atribuir valores nas propriedades correspondentes.
    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Após todas as credenciais de banco de dados serem inseridas no arquivo Ant, salve-as e execute o destino Ant **databases**.

Um banco de dados é criado com o nome do SID inserido no banco de dados do elemento **oracle**. Ele não deve ser usado para produção.

#### Criando o usuário
{: #creating-the-user-1 }
Siga as diretrizes gerais conforme descrito em [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks) para editar a cópia do arquivo **create-database-oracle.xml**.

1. Execute um servidor SSH no computador que execute o banco de dados Oracle.

    A tarefa Ant **configureDatabase** abre uma sessão do SSH para o host do Oracle para criar o banco de dados. Exceto no Linux e em algumas versões de sistemas UNIX, o servidor SSH é necessário, mesmo que o banco de dados Oracle seja executado no mesmo computador no qual as tarefas Ant são executadas.

2. No elemento oracle definido no arquivo **create-database-oracle.xml**, insira o ID e a senha de login de um usuário do banco de dados Oracle que você deseja criar. Os atributos são **user** e **password**. É possível atribuir valores nas propriedades correspondentes.
    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. No mesmo elemento **oracle**, insira também a senha para o usuário **SYSTEM** do banco de dados. O atributo é **systemPassword**. É possível designar o valor na **propriedade database.oracle.systemPassword**.
4. No elemento **dba**, insira o ID e a senha de login para um usuário do banco de dados Oracle que tenha os privilégios para criar um usuário. É possível atribuir valores nas propriedades a seguir:
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Após todas as credenciais de banco de dados serem inseridas no arquivo Ant, salve-as e execute o destino Ant **databases**.

Um usuário do banco de dados é criado com o nome e a senha inseridos no elemento **oracle**. Esse usuário tem privilégios para criar as tabelas {{ site.data.keys.mf_server }}, fazer seu upgrade e usá-las no tempo de execução.

### Criando as tabelas de banco de dados MySQL com tarefas Ant
{: #creating-the-mysql-database-tables-with-ant-tasks }
Use as tarefas Ant fornecidas com a instalação do {{ site.data.keys.mf_server }} para criar as tabelas de banco de dados MySQL.

Para criar as tabelas de banco de dados em um banco de dados que já existe, consulte [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks).

Se o servidor MySQL não tiver as configurações recomendadas em [Requisitos do banco de dados MySQL e do usuário](#mysql-database-and-user-requirements), a tarefa Ant **configureDatabase** exibirá um aviso. Certifique-se de preencher os requisitos antes de executar a tarefa Ant.

Para criar um banco de dados e as tabelas de banco de dados, siga as diretrizes gerais conforme descrito em [Criar as tabelas de banco de dados com tarefas Ant](#create-the-database-tables-with-ant-tasks) para editar a cópia do arquivo **create-database-mysql.xml**.

O procedimento a seguir fornece algumas etapas extras que precisam ser executadas quando você cria as tabelas de banco de dados com a tarefa Ant **configureDatabase**.

1. No elemento **dba** definido no arquivo **create-database-mysql.xml**, insira o ID e a senha de login de um administrador do MySQL. Por padrão, o administrador é **root**. É possível atribuir valores nas propriedades a seguir:
    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. No elemento **mysql**, inclua um elemento **client** para cada host a partir dos quais o usuário tem permissão para se conectar ao banco de dados. Ou seja, todos os hosts nos quais o {{ site.data.keys.mf_server }} é executado.
Após todas as credenciais de banco de dados serem inseridas no arquivo Ant, salve-as e execute o destino Ant **databases**.
