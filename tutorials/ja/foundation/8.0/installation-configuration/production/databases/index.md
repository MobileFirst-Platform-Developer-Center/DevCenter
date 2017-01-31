---
layout: tutorial
title: データベースのセットアップ
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下の {{site.data.keys.mf_server_full }} コンポーネントは、テクニカル・データをデータベースに保管する必要があります。

* {{site.data.keys.mf_server }} 管理サービス
* {{site.data.keys.mf_server }} ライブ更新サービス
* {{site.data.keys.mf_server }} プッシュ・サービス
* {{site.data.keys.product }}runtime > **注:** 複数のランタイム・インスタンスが異なるコンテキスト・ルートでインストールされる場合、各インスタンスに独自の表のセットが必要です。
> データベースは、IBM DB2、Oracle、または MySQL などのリレーショナル・データベースにできます。

#### リレーショナル・データベース (DB2、Oracle、または MySQL)
{: #relational-databases-db2-oracle-or-mysql }
各コンポーネントに 1 つの表セットが必要です。各コンポーネントに固有の SQL スクリプトを実行するか ([手動でのデータベース表の作成](#create-the-database-tables-manually)を参照)、Ant タスクを使用するか、サーバー構成ツールを使用することで、表を手動で作成することができます。各コンポーネントの表名はオーバーラップしません。このため、これらのコンポーネントの表をすべて単一のスキーマに置くことができます。

ただし、{{site.data.keys.product }} ランタイムの複数インスタンスを、インスタンスごとに独自のコンテキスト・ルートを指定してアプリケーション・サーバー内にインストールすることにした場合、各インスタンスに独自の表セットが必要となります。この場合、各インスタンスを異なるスキーマに置く必要があります。

> **DB2 に関する注:** {{site.data.keys.product_adj }} のライセンス所有者は、Foundation のサポート・システムとして DB2 を使用する資格があります。これを利用するには、DB2 ソフトウェアのインストール後に以下を行う必要があります。
> 
> * [IBM パスポート・アドバンテージ (PPA) Web サイト](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)から制限付き使用のアクティベーション・イメージを直接ダウンロードします。
> * **db2licm** コマンドを使用して、制限付き使用のアクティベーション・ライセンス・ファイル **db2xxxx.lic** を適用します。
>
> [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html) に詳細の説明があります。

#### ジャンプ先
{: #jump-to }

* [データベースのユーザーおよび特権](#database-users-and-privileges)
* [データベース要件](#database-requirements)
* [手動でのデータベース表の作成](#create-the-database-tables-manually)
* [サーバー構成ツールを使用したデータベース表の作成](#create-the-database-tables-with-the-server-configuration-tool)
* [Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)

## データベースのユーザーおよび特権
{: #database-users-and-privileges }
実行時、アプリケーション・サーバー内の {{site.data.keys.mf_server }} アプリケーションは、リレーショナル・データベースへの接続を獲得するためのリソースとしてデータ・ソースを使用します。データ・ソースには、データベースにアクセスするための特定の特権を持つユーザーが必要です。

アプリケーション・サーバーにデプロイされる各 {{site.data.keys.mf_server }} アプリケーションのデータ・ソースを、リレーショナル・データベースにアクセスできるように構成する必要があります。データ・ソースには、データベースにアクセスするための特定の特権を持つユーザーが必要です。作成する必要があるユーザーの数は、{{site.data.keys.mf_server }} アプリケーションをアプリケーション・サーバーにデプロイするために使用されるインストール手順によって決まります。

### サーバー構成ツールを使用したインストール
{: #installation-with-the-server-configuration-tool }
同じユーザーがすべてのコンポーネント ({{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} 構成サービス、{{site.data.keys.mf_server }} プッシュ・サービス、および {{site.data.keys.product }} ランタイム) に使用されます。

### Ant タスクを使用したインストール
{: #installation-with-ant-tasks }
製品のディストリビューションで提供されているサンプル Ant ファイルは、すべてのコンポーネントに同じユーザーを使用します。ただし、以下のように、異なるユーザーを使用するように Ant ファイルを変更することも可能です。

* 管理サービスと構成サービスは Ant タスクを使用して別々にインストールできないので、これらには同じユーザーを使用する。
* ランタイムには異なるユーザーを使用する。
* プッシュ・サービスには異なるユーザーを使用する。

### 手動インストール
{: #manual-installation }
{{site.data.keys.mf_server }} の各コンポーネントに、異なるデータ・ソース (したがって、異なるユーザー) を割り当てることが可能です。実行時、ユーザーは、データの表およびシーケンスに対して以下の特権を持っている必要があります。

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Ant タスクまたはサーバー構成ツールを使用してインストールを実行する前に表が手動で作成されていない場合は、表を作成できるユーザーを割り当てるようにしてください。ユーザーには以下の特権も必要になります。

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

製品のアップグレードについては、以下の追加特権が必要になります。

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## データベース要件
{: #database-requirements }
データベースは、{{site.data.keys.mf_server }} アプリケーションのすべてのデータを保管します。{{site.data.keys.mf_server }} コンポーネントをインストールする前に、データベース要件が満たされていることを確認してください。

* [DB2 データベースおよびユーザーの要件](#db2-database-and-user-requirements)
* [Oracle データベースおよびユーザーの要件](#oracle-database-and-user-requirements)
* [MySQL データベースおよびユーザーの要件](#mysql-database-and-user-requirements)

> サポートされるデータベース・ソフトウェア・バージョンの最新リストについては、[システム要件](../../../product-overview/requirements/)ページを参照してください。

### DB2 データベースおよびユーザーの要件
{: #db2-database-and-user-requirements }
DB2 のデータベースの要件を確認してください。以下のステップに従って、ユーザーおよびデータベースを作成し、特定の要件を満たすようにデータベースをセットアップします。

データベース文字セットは「UTF-8」に設定するようにしてください。

データベースのページ・サイズは 32768 以上でなければなりません。以下の手順では、ページ・サイズが 32768 のデータベースを作成します。また、この手順では、ユーザー (**mfpuser**) を作成し、そのユーザーにデータベース・アクセス権限を付与します。その後、サーバー構成ツールまたは Ant タスクでこのユーザーを使用して、テーブルを作成できます。

1. ご使用のオペレーティング・システムの該当するコマンドを使用して、DB2 管理グループ (**DB2USERS** など) に、例えば **mfpuser** などの名前のシステム・ユーザーを作成します。それにパスワード (例えば **mfpuser**) を付与します。
2. **SYSADM** または **SYSCTRL** 権限を持つユーザーで DB2 コマンド・ライン・プロセッサーを開きます。
    * Windows システムでは、**「開始 (Start)」→「IBM DB2」→「コマンド・ライン・プロセッサー (Command Line Processor)」**とクリックします。
    * Linux システムまたは UNIX システムでは、**~/sqllib/bin** に移動し、`./db2` と入力します。
3. {{site.data.keys.mf_server }} データベースを作成するには、以下の例のような SQL ステートメントを入力します。

ユーザー名 **mfpuser** は実際の名前で置き換えてください。

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Oracle データベースおよびユーザーの要件
{: #oracle-database-and-user-requirements }
Oracle のデータベースの要件を確認してください。以下のステップに従って、ユーザーおよびデータベースを作成し、特定の要件を満たすようにデータベースをセットアップします。

データベース文字セットは「Unicode 文字セット (AL32UTF8)」に、国別文字セットは 「UTF8 - Unicode 3.0 UTF-8」に設定するようにしてください。  

ランタイム・ユーザー (説明は [データベースのユーザーおよび特権](#database-users-and-privileges)を参照) には、関連付けられた表スペースと、{{site.data.keys.product }} サービスが必要とするテクニカル・データを書き込むために十分な割り当て量を持つ必要があります。本製品で使用する表について詳しくは、[内部ランタイム・データベース](../installation-reference/#internal-runtime-databases)を参照してください。

表は、ランタイム・ユーザーのデフォルト・スキーマ内に作成する必要があります。Ant タスクおよびサーバー構成ツールは、引数として渡されたユーザーのデフォルト・スキーマ内に表を作成します。表の作成について詳しくは、[Oracle データベース表の手動作成](#creating-the-oracle-database-tables-manually)を参照してください。

この手順により、必要に応じてデータベースが作成されます。このデータベースで表および索引を作成できるユーザーが追加され、ランタイム・ユーザーとして使用されます。

1. データベースがまだない場合、Oracle Database Configuration Assistant (DBCA) を使用し、ウィザードのステップに従って、(この例では ORCL という名前の) 新しい汎用データベースを作成します。
    * グローバル・データベース名 **ORCL\_your\_domain**、およびシステム ID (SID) **ORCL** を使用します。
    * ステップ**「データベース・コンテント (Database Content)」**の**「カスタム・スクリプト (Custom Scripts)」**タブで、SQL スクリプトを実行しないでください。これは、まずユーザー・アカウントを作成する必要があるためです。
    * **「初期化パラメーター (Initialization Parameters)」**ステップの
**「キャラクタ・セット (Character Sets)」**タブで、**「Unicode (AL32UTF8) 文字セットおよび UTF8 - Unicode 3.0 UTF-8 国別文字セットを
使用」**を選択します。
    * デフォルト値を受け入れてプロシージャーを完了します。
2. Oracle Database Control を使用するか、または Oracle SQLPlus コマンド・ライン・インタープリターを使用して、データベース・ユーザーを作成します。
3. Oracle Database Control を使用する場合:
    * **SYSDBA** として接続します。
    * **「ユーザー (Users)」**ページに進み、**「サーバー (Server)」**をクリックし、**「セキュリティー (Security)」**セクションの**「ユーザー (Users)」**をクリックします。
    * 例えば **MFPUSER** という名前のユーザーを作成します。
    * 以下の属性を割り当てます。
        * **Profile**: DEFAULT
        * **Authentication**: password
        * **Default tablespace**: USERS
        * **Temporary tablespace**: TEMP
        * **Status**: Unlocked
        * Add system privilege: CREATE SESSION
        * Add system privilege: CREATE SEQUENCE
        * Add system privilege: CREATE TABLE
        * Add quota: Unlimited for tablespace USERS
    * Oracle SQLPlus コマンド・ライン・インタープリターを使用する場合:

以下の例に示されたコマンドは、
データベース用の **MFPUSER** という名前のユーザーを作成します。

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### MySQL データベースおよびユーザーの要件
{: #mysql-database-and-user-requirements }
MySQL のデータベースの要件を確認してください。以下のステップに従って、ユーザーおよびデータベースを作成し、特定の要件を満たすようにデータベースを構成します。

文字セットは UTF8 に設定するようにしてください。

以下のプロパティーに適切な値を割り当てる必要があります。

* max_allowed_packet には、256 M 以上
* innodb_log_file_size には 250 M 以上

プロパティーの設定方法について詳しくは、[MySQL の資料](http://dev.mysql.com/doc/)を参照してください。  
この手順により、データベース (MFPDATA) およびユーザー (mfpuser) が作成されます。このユーザーは、ホスト (mfp-host) からすべての特権を持ってデータベースに接続することができます。

1. オプション `-u root` を指定して MySQL コマンド・ライン・クライアントを実行します。
2. 以下のコマンドを入力します。

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    ここで、「at」記号 (@) の前の mfpuser はユーザー名で、**IDENTIFIED BY** の後の **mfpuser-password** はそのパスワード、そして **mfp-host** は、{{site.data.keys.product_adj }} が稼働しているホストの名前です。
    
    このユーザーは、{{site.data.keys.mf_server }} アプリケーションがインストールされた Java アプリケーション・サーバーを実行するホストから、MySQL サーバーに接続できなければなりません。
    
## 手動でのデータベース表の作成
{: #create-the-database-tables-manually }
{{site.data.keys.mf_server }} アプリケーションのデータベース表は、Ant タスクを使用するか、サーバー構成ツールを使用して手動で作成することができます。以下のトピックでは、それらを手動で作成する方法についての説明および詳細情報を提供しています。

* [DB2 データベース表の手動作成](#creating-the-db2-database-tables-manually)
* [Oracle データベース表の手動作成](#creating-the-oracle-database-tables-manually)
* [MySQL データベース表の手動作成](#creating-the-mysql-database-tables-manually)

### DB2 データベース表の手動作成
{: #creating-the-db2-database-tables-manually }
{{site.data.keys.mf_server }} のインストールで提供される SQL スクリプトを使用して、DB2 データベース表を作成します。

「概説」セクションで説明されているとおり、4 つの {{site.data.keys.mf_server }} コンポーネントすべてに表が必要です。表の作成には、同じスキーマを使用しても、異なるスキーマを使用しても構いません。ただし、{{site.data.keys.mf_server }} アプリケーションの Java アプリケーション・サーバーへのデプロイ方法によって、いくつかの制約が適用されます。それらの制約は、[データベースのユーザーおよび特権](#database-users-and-privileges)で説明された、DB2 の可能なユーザーについてのトピックに類似しています。

#### サーバー構成ツールを使用したインストール
{: #installation-with-the-server-configuration-tool-1 }
すべてのコンポーネント ({{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、{{site.data.keys.mf_server }} プッシュ・サービス、および {{site.data.keys.product }} ランタイム) に対して同じスキーマが使用されます。

#### Ant タスクを使用したインストール
{: #installation-with-ant-tasks-1 }
製品のディストリビューションで提供されるサンプル Ant ファイルは、すべてのコンポーネントに対して同じスキーマを使用します。ただし、以下のように、異なるスキーマを使用するよう Ant ファイルを変更することは可能です。

* 管理サービスとライブ更新サービスには同じスキーマ (これらは Ant タスクで別々にインストールできないため)。
* ランタイム用には異なるスキーマ。
* プッシュ・サービス用には異なるスキーマ。

#### 手動インストール
{: #manual-installation-1 }
{{site.data.keys.mf_server }} コンポーネントのそれぞれに異なるデータ・ソースを (またそれにより異なるスキーマを) 割り当てることができます。  
表の作成に使用するスクリプトは以下のとおりです。

* 管理サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**
* ライブ更新サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**
* ランタイム・コンポーネントの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**
* プッシュ・サービスの場合: **mfp\_install\_dir/PushService/databases/create-push-db2.sql**

以下の手順により、すべてのアプリケーション用の表が、同じスキーマ (MFPSCM) で作成されます。ここでは、データベースおよびユーザーが作成済みであることを前提としています。詳しくは、[DB2 データベースおよびユーザーの要件](#db2-database-and-user-requirements)を参照してください。

ユーザー (mfpuser) を使用して、以下のコマンドで  DB2 を実行します。

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

mfpuser によって表が作成された場合、このユーザーはそれらの表に対する特権を自動的に付与され、ランタイムでそれらを使用できます。[データベースのユーザーおよび特権](#database-users-and-privileges)の説明のようにランタイム・ユーザーの特権を制限したい場合、もしくは特権の内容をより詳細に制御したい場合は、DB2 の資料を参照してください。

### Oracle データベース表の手動作成
{: #creating-the-oracle-database-tables-manually }
{{site.data.keys.mf_server }} のインストールで提供される SQL スクリプトを使用して、Oracle データベース表を作成します。

「概説」セクションで説明されているとおり、4 つの {{site.data.keys.mf_server }} コンポーネントすべてに表が必要です。表の作成には、同じスキーマを使用しても、異なるスキーマを使用しても構いません。ただし、{{site.data.keys.mf_server }} アプリケーションの Java アプリケーション・サーバーへのデプロイ方法によって、いくつかの制約が適用されます。詳しくは、[データベースのユーザーおよび特権](#database-users-and-privileges)で説明しています。

表は、ランタイム・ユーザーのデフォルト・スキーマ内に作成する必要があります。表の作成に使用するスクリプトは以下のとおりです。

* 管理サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**
* ライブ更新サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**
* ランタイム・コンポーネントの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**
* プッシュ・サービスの場合: **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**

以下の手順により、すべてのアプリケーション用の、同じユーザー (**MFPUSER**) を対象にした表が作成されます。ここでは、データベースおよびユーザーが作成済みであることを前提としています。詳しくは、[Oracle データベースおよびユーザーの要件](#oracle-database-and-user-requirements)を参照してください。

Oracle SQLPlus で以下のコマンドを実行します。

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

MFPUSER によって表が作成された場合、このユーザーはそれらの表に対する特権を自動的に付与され、ランタイムでそれらを使用できます。表は、このユーザーのデフォルト・スキーマ内に作成されます。[データベースのユーザーおよび特権](#database-users-and-privileges)の説明のようにランタイム・ユーザーの特権を制限したい場合、もしくは特権の内容をより詳細に制御したい場合は、Oracle の資料を参照してください。

### MySQL データベース表の手動作成
{: #creating-the-mysql-database-tables-manually }
{{site.data.keys.mf_server }} のインストールで提供される SQL スクリプトを使用して、MySQL データベース表を作成します。

「概説」セクションで説明されているとおり、4 つの {{site.data.keys.mf_server }} コンポーネントすべてに表が必要です。表の作成には、同じスキーマを使用しても、異なるスキーマを使用しても構いません。ただし、{{site.data.keys.mf_server }} アプリケーションの Java アプリケーション・サーバーへのデプロイ方法によって、いくつかの制約が適用されます。それらの制約は、[データベースのユーザーおよび特権](#database-users-and-privileges)で説明された、 MySQL の可能なユーザーについてのトピックに類似しています。

#### サーバー構成ツールを使用したインストール
{: #installation-with-the-server-configuration-tool-2 }
すべてのコンポーネント ({{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、{{site.data.keys.mf_server }} プッシュ・サービス、および {{site.data.keys.product }} ランタイム) に対して同じデータベースが使用されます。

#### Ant タスクを使用したインストール
{: #installation-with-ant-tasks-2 }
製品のディストリビューションで提供されるサンプル Ant ファイルは、すべてのコンポーネントに対して同じデータベースを使用します。ただし、以下のように、異なるデータベースを使用するよう Ant ファイルを変更することは可能です。

* 管理サービスとライブ更新サービスには同じデータベース (これらは Ant タスクで別々にインストールできないため)。
* ランタイム用には異なるデータベース。
* プッシュ・サービス用には異なるデータベース。

#### 手動インストール
{: #manual-installation-2 }
{{site.data.keys.mf_server }} コンポーネントのそれぞれに異なるデータ・ソースを (またそれにより異なるデータベースを) 割り当てることができます。  
表の作成に使用するスクリプトは以下のとおりです。

* 管理サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**
* ライブ更新サービスの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**
* ランタイム・コンポーネントの場合: **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**
* プッシュ・サービスの場合: **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**

以下のサンプルでは、すべてのアプリケーション用の表が、同じユーザーおよびデータベースを対象として作成されます。
ここでは、データベースおよびユーザーが[MySQL のデータベース要件](#database-requirements)に従って作成済みであることを前提としています。

以下の手順により、すべてのアプリケーション用の表が、同じユーザー (mfpuser) およびデータベース (MFPDATA) を対象として作成されます。ここでは、データベースおよびユーザーが作成済みであることを前提としています。

1. オプション `-u mfpuser` を指定して MySQL コマンド・ライン・クライアントを実行します。
2. 以下のコマンドを入力します。

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## サーバー構成ツールを使用したデータベース表の作成
{: #create-the-database-tables-with-the-server-configuration-tool }
{{site.data.keys.mf_server }} アプリケーションのデータベース表は、Ant タスクを使用するか、サーバー構成ツールを使用して手動で作成することができます。以下のトピックでは、サーバー構成ツールを使用して {{site.data.keys.mf_server }} をインストールする際のデータベースのセットアップに関する説明および詳細情報を提供しています。

サーバー構成ツールは、インストール・プロセスの一部としてデータベース表を作成することができます。場合によっては、{{site.data.keys.mf_server }} コンポーネントのユーザーおよびデータベースも作成できます。サーバー構成ツールを使用したインストール・プロセスの概要については、[グラフィカル・モードでの {{site.data.keys.mf_server }} のインストール](../tutorials/graphical-mode)を参照してください。

構成資格情報を完了し、サーバー構成ツールペインで**「デプロイ」**をクリックすると、以下の操作が実行されます。

* 必要に応じてデータベースおよびユーザーを作成する。
* {{site.data.keys.mf_server }} 表がデータベース内に存在するかどうかを確認する。存在しない場合は、それらの表を作成します。
* {{site.data.keys.mf_server }} アプリケーションをアプリケーション・サーバーにデプロイする。

サーバー構成ツールを実行する前にデータベース表が手動で作成されていると、ツールはそれらを検出し、表のセットアップ・フェーズをスキップできます。

サポートされるデータベース管理システム (DBMS) の選択に応じて以下のいずれかのトピックを選択し、ツールがどのようにデータベース表を作成するかについての詳細を確認してください。

* [サーバー構成ツールによる DB2 データベース表の作成](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [サーバー構成ツールによる Oracle データベース表の作成](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [サーバー構成ツールによる MySQL データベース表の作成](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### サーバー構成ツールによる DB2 データベース表の作成
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
{{site.data.keys.mf_server }} のインストールで提供されるサーバー構成ツールを使用して、DB2 データベース表を作成します。

サーバー構成ツールは、デフォルトの DB2 インスタンスにデータベースを作成できます。サーバー構成ツールの**「データベース選択 (Database Selection)」**パネルで、IBM DB2 オプションを選択します。次の 3 つのペインで、データベースの資格情報を入力します。**「データベースの追加設定」**パネルで入力されたデータベース名が DB2 インスタンス内に存在しない場合、追加情報を入力して、ツールがデータベースを作成できるようにします。

サーバー構成ツールは、以下の SQL ステートメントを使用して、デフォルト設定でデータベース表を作成します。
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

これは、デフォルトの DB2 インストール済み環境のように実動での使用を意図したものではありません。多くの特権が PUBLIC に付与されています。

### サーバー構成ツールによる Oracle データベース表の作成
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
{{site.data.keys.mf_server }} のインストールで提供されるサーバー構成ツールを使用して、Oracle データベース表を作成します。

サーバー構成ツールの「データベース選択 (Database Selection)」パネルで、**「Oracle Standard または Enterprise Editions、11g または 12c (Oracle Standard or Enterprise Editions, 11g or 12c)」**オプションを選択します。次の 3 つのペインで、データベースの資格情報を入力します。

**「データベースの追加設定」** パネルに Oracle ユーザー名を入力する際は、大文字を使用してください。Oracle データベースのユーザー (FOO) がいるのに、ユーザー名を小文字 (foo) で入力すると、サーバー構成ツールはそれを別のユーザーと認識します。Oracle データベース用の他のツールとは異なり、サーバー構成ツールは大文字への自動変換からユーザー名を保護します。

サーバー構成ツールは、サービス名または Oracle システム ID (SID) を使用してデータベースを識別します。ただし、Oracle RAC への接続を行う場合は、複雑な JDBC URL を入力する必要があります。この場合、**「データベース設定 (Database Settings)」**パネルで**「汎用 Oracle JDBC URL を使用して接続 (Connect using generic
Oracle JDBC URLs)」**オプションを選択し、Oracle シン・ドライバーの URL を入力します。

Oracle のデータベースおよびユーザーを作成する必要がある場合、Oracle Database Creation Assistant (DBCA) ツールを使用します。詳しくは、[Oracle データベースおよびユーザーの要件](#oracle-database-and-user-requirements)を参照してください。

サーバー構成ツールでも同じことができますが、1 つ制限があります。このツールでは、Oracle 11g または Oracle 12g のユーザーを作成できます。しかし、データベースの作成は Oracle 11g に対してのみ可能で、Oracle 12c には対応していません。

**「データベースの追加設定」**パネルで入力されたデータベース名またはユーザー名が存在しない場合、データベースまたはユーザーの作成のための追加ステップを説明した以下の 2つのセクションを参照してください。

#### データベースの作成
{: #creating-the-database }

1. Oracle データベースを実行するコンピューター上で SSH サーバーを実行します。

    サーバー構成ツールは、Oracle ホストへの SSH セッションを開き、データベースを作成します。Linux システムおよび一部のバージョンの UNIX システムを除き、Oracle データベースがサーバー構成ツールと同じコンピューター上で実行されている場合でも、SSH サーバーは必要です。

2. **「データベース作成要求」**パネルで、データベース作成の特権を持つ Oracle データベース・ユーザーのログイン ID とパスワードを入力します。
3. 同じパネルで、作成するデータベースの **SYS** ユーザーおよび **SYSTEM** ユーザーのパスワードも入力します。

**「データベースの追加設定」**パネルで入力された SID 名を使用して、データベースが作成されます。これは、実動用に使用するものではありません。

#### ユーザーの作成
{: #creating-the-user }

1. Oracle データベースを実行するコンピューター上で SSH サーバーを実行します。

    サーバー構成ツールは、Oracle ホストへの SSH セッションを開き、データベースを作成します。Linux システムおよび一部のバージョンの UNIX システムを除き、Oracle データベースがサーバー構成ツールと同じコンピューター上で実行されている場合でも、SSH サーバーは必要です。

2. **「データベースの追加設定」**パネルで、作成するデータベース・ユーザーのログイン ID とパスワードを入力します。
3. **「データベース作成要求」**パネルで、データベース・ユーザー作成の特権を持つ Oracle データベース・ユーザーのログイン ID とパスワードを入力します。
4. 同じパネルで、データベースの **SYSTEM** ユーザーのパスワードも入力します。

### サーバー構成ツールによる MySQL データベース表の作成
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
{{site.data.keys.mf_server }} のインストールで提供されるサーバー構成ツールを使用して、MySQL データベース表を作成します。

サーバー構成ツールは、MySQL データベースを作成できます。サーバー構成ツールの**「データベース選択 (Database Selection)」**パネルで、**「MySQL 5.5.x、5.6.x、または 5.7.x (MySQL 5.5.x, 5.6.x or 5.7.x)」**オプションを選択します。次の 3 つのペインで、データベースの資格情報を入力します。「データベースの追加設定」パネルで入力したデータベースまたはユーザーが存在しない場合、このツールがそれを作成できます。

[MySQL データベースおよびユーザーの要件](#mysql-database-and-user-requirements)で推奨された設定が MySQL サーバーにない場合、サーバー構成ツールが警告を表示します。サーバー構成ツールを実行する前に、必ず要件を満たすようにしてください。

以下の手順では、このツールでデータベース表を作成する際に実行する必要のあるいくつかの追加のステップを説明しています。

1. **「データベースの追加設定」**パネルで、接続設定に加え、ユーザーがデータベースに接続する許可を得るすべてのホストを入力する必要があります。
これはすなわち、{{site.data.keys.mf_server }} が実行されるすべてのホストです。
2. **「データベース作成要求」**パネルで、MySQL 管理者のログイン ID とパスワードを入力します。デフォルトでは、管理者は root です。

## Ant タスクを使用したデータベース表の作成
{: #create-the-database-tables-with-ant-tasks }
{{site.data.keys.mf_server }} アプリケーションのデータベース表は、Ant タスクを使用するか、サーバー構成ツールを使用して手動で作成することができます。トピックでは、Ant タスクを使用したデータベース表の作成方法の説明および詳細情報を提供します。

{{site.data.keys.mf_server }} が Ant タスクを使用してインストールされている場合は、このセクションにデータベースのセットアップに関する関連情報があります。

Ant タスクを使用して、{{site.data.keys.mf_server }} データベース表をセットアップすることができます。場合によっては、これらのタスクを使用してデータベースおよびユーザーも作成できます。Ant タスクを使用したインストール・プロセスの概要については、[コマンド・ライン・モードでの {{site.data.keys.mf_server }} のインストール](../tutorials/command-line)を参照してください。

Ant タスクの使用を開始するのに役立つように、インストール済み環境にサンプル Ant ファイルのセットが用意されています。ファイルは **mfp\_install\_dir/MobileFirstServer/configurations-samples** にあります。これらのファイルは、以下のパターンに従って命名されています。

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Ant ファイルは以下のタスクを実行できます。

* データベースおよびデータベース・ユーザーが存在する場合、データベース内に表を作成する。データベースの要件は、[データベース要件](#database-requirements)にリストされています。
* {{site.data.keys.mf_server }} コンポーネントの WAR ファイルをアプリケーション・サーバーにデプロイする。これらの Ant ファイルは、同じデータベース・ユーザーを使用して表を作成し、実行時にアプリケーションのランタイム・データベース・ユーザーをインストールします。またこれらのファイルは、すべての {{site.data.keys.mf_server }} アプリケーションに同じデータベース・ユーザーを使用します。

#### create-database-dbms.xml
{: #create-database-dbmsxml }
これらの Ant ファイルは、サポートされるデータベース管理システム (DBMS) で必要な場合、データベースを作成し、次にそのデータベース内に表を作成できます。ただし、データベースはデフォルト設定で作成されるため、実動での使用を意図したものではありません。

Ant ファイル内に、**configureDatabase** Ant タスクを使用してデータベースをセットアップする、事前定義ターゲットがあります。詳しくは、[Ant configuredatabase](../installation-reference/#ant-configuredatabase-task-reference) タスクの参照情報を参照してください。

### サンプル Ant ファイルの使用
{: #using-the-sample-ant-files }
サンプル Ant ファイルには事前定義ターゲットがあります。これらのファイルを使用するには、以下の手順に従ってください。

1. アプリケーション・サーバーおよびデータベースの構成に従って作業ディレクトリーに Ant ファイルをコピーします。
2. ファイルを編集し、Ant ファイルの `<! -- Start of Property Parameters -->` セクションに構成の値を入力します。
3. 次のように、databases ターゲットを使用して Ant ファイルを実行します。 `mfp_install_dir/shortcuts/ant -f your_ant_file databases`

このコマンドは、すべての {{site.data.keys.mf_server }} アプリケーション ({{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、{{site.data.keys.mf_server }} プッシュ・サービス、および {{site.data.keys.mf_server }} ランタイム) の表を、指定されたデータベースおよびスキーマに作成します。これらの操作のログが作成され、ディスク内に保管されます。

* Windows では、**{{site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\** ディレクトリー内。
* UNIX では、**{{site.data.keys.prod_server_data_dir_unix }}/configuration-logs/** ディレクトリー内。

### データベース表の作成用とランタイム用で異なるユーザー
{: #different-users-for-the-database-tables-creation-and-for-run-time }
**mfp\_install\_dir/MobileFirstServer/configurations-samples** 内のサンプル Ant ファイルは、以下に対して同じデータベース・ユーザーを使用します。

* すべての {{site.data.keys.mf_server }} アプリケーション (管理サービス、ライブ更新サービス、プッシュ・サービス、およびランタイム)
* データベースの作成に使用されるユーザーと、アプリケーション・サーバー内のデータ・ソースのための、実行時のユーザー。

[データベースのユーザーおよび特権](#database-users-and-privileges)の説明にあるように、これらのユーザーを分離したい場合は、独自の Ant ファイルを作成するか、各データベース・ターゲットのユーザーが異なるようにサンプル Ant ファイルを変更する必要があります。詳しくは、[インストールに関する参照情報](../installation-reference)を参照してください。

DB2 および MySQL の場合、データベース作成用とランタイム用で異なるユーザーにすることが可能です。各タイプのユーザーの特権は、[データベースのユーザーおよび特権](#database-users-and-privileges)にリストされています。Oracle の場合は、データベースの作成用とランタイム用で異なるユーザーにすることはできません。Ant タスクは、表がユーザーのデフォルト・スキーマ内にあると見なします。ランタイム・ユーザーの特権を減らしたい場合は、実行時に使用されるユーザーのデフォルト・スキーマ内に表を手動で作成する必要があります。詳しくは、[Oracle データベース表の手動作成](#creating-the-oracle-database-tables-manually)を参照してください。

サポートされているデータベース管理システム (DBMS) の選択に応じて、以下のいずれかのトピックを選択し、Ant タスクを使用してデータベースを作成してください。

### Ant タスクを使用した DB2 データベース表の作成
{: #creating-the-db2-database-tables-with-ant-tasks }
{{site.data.keys.mf_server }} インストール済み環境で提供されている Ant タスクを使用して DB2 データベースを作成します。

既に存在するデータベース内にデータベース表を作成するには、[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)を参照してください。

データベースとデータベース表を作成するには、Ant タスクを使用できます。**dba** エレメントを含む Ant ファイルを使用した場合、Ant タスクは、DB2 のデフォルト・インスタンスにデータベースを作成します。このエレメントは、**create-database-<dbms>.xml** という名前のサンプル Ant ファイル内にあります。

Ant タスクを実行する前に、DB2 データベースを実行するコンピューター上に SSH サーバーがインストールされていることを確認してください。**configureDatabase** Ant タスクは、DB2 ホストへの SSH セッションを開いてデータベースを作成します。SSH サーバーは、Ant タスクを実行するコンピューターと同じコンピューター上で DB2 データベースが実行されている場合でも必要です (Linux システムおよび一部のバージョンの UNIX システムを除く)。

[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)で説明された一般ガイドラインに従って、**create-database-db2.xml** ファイルのコピーを編集してください。

さらに、管理特権 (**SYSADM** 権限または **SYSCTRL** 権限) を持つ DB2 ユーザーのログイン ID とパスワードを **dba** エレメントに指定する必要もあります。DB2 用のサンプル Ant ファイル (**create-database-db2.xml**) で設定するプロパティーは **database.db2.admin.username** および **database.db2.admin.password** です。

**databases** Ant ターゲットが呼び出されると、**configureDatabase** Ant タスクは、以下の SQL ステートメントを使用してデフォルト設定でデータベースを作成します。


```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

これは、デフォルトの DB2 インストール済み環境のように実動での使用を意図したものではありません。多くの特権が PUBLIC に付与されています。

### Ant タスクによる Oracle データベース表の作成
{: #creating-the-oracle-database-tables-with-ant-tasks }
{{site.data.keys.mf_server }} のインストールで提供される Ant タスクを使用して、Oracle データベース表を作成します。

Ant ファイル内に Oracle ユーザー名を入力する際は、大文字を使用してください。Oracle データベースのユーザー (FOO) がいるのに、ユーザー名を小文字 (foo) で入力すると、**configureDatabase** Ant タスクはそれを別のユーザーと認識します。Oracle データベース用の他のツールとは異なり、**configureDatabase** Ant タスクは大文字への自動変換からユーザー名を保護します。

**configureDatabase** Ant タスクは、サービス名または Oracle システム ID (SID) を使用してデータベースを識別します。ただし、Oracle RAC への接続を行う場合は、複雑な JDBC URL を入力する必要があります。この場合、**configureDatabase** Ant タスク内にある **oracle** エレメントは、これらの属性 (**database**、**server**、**port**、
**user**、および **password**) の代わりに属性 (**url**、
**user**、および **password**) を使用する必要があります。詳しくは、[Ant **configuredatabase** タスクの参照情報](../installation-reference/#ant-configuredatabase-task-reference)の表を参照してください。**mfp\_install\_dir/MobileFirstServer/configurations-samples** 内のサンプル Ant ファイルは、**database**、**server**、**port**、**user**、および **password** 属性を **oracle** エレメントで使用します。JDBC URL で Oracle に接続する必要がある場合は、これらを変更する必要があります。

既に存在するデータベース内にデータベース表を作成するには、[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)を参照してください。

データベース、ユーザー、またはデータベース表を作成するには、Oracle Database Creation Assistant
(DBCA) ツールを使用します。詳しくは、[Oracle データベースおよびユーザーの要件](#oracle-database-and-user-requirements)を参照してください。

**configureDatabase** Ant タスクでも同じことができますが、1 つ制限があります。このタスクでは、Oracle 11g または Oracle 12g のデータベース・ユーザーを作成できます。しかし、データベースの作成は Oracle 11g に対してのみ可能で、Oracle 12c には対応していません。データベースまたはユーザーの作成に必要な追加のステップについては、以下の 2 つのセクションを参照してください。

#### データベースの作成
{: #creating-the-database-1 }
[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)で説明された一般ガイドラインに従って、**create-database-oracle.xml** ファイルのコピーを編集してください。

1. Oracle データベースを実行するコンピューター上で SSH サーバーを実行します。

    **configureDatabase** Ant タスクは、Oracle ホストへの SSH セッションを開き、データベースを作成します。Linux システムおよび一部のバージョンの UNIX システムを除き、Ant タスクが実行されているのと同じコンピューター上で Oracle データベースが実行されている場合でも、SSH サーバーは必要です。

2. **create-database-oracle.xml** ファイルで定義された **dba** エレメントに、SSH 経由で Oracle サーバーに接続できて、データベース作成の特権を持っている Oracle データベース・ユーザーのログイン ID とパスワードを入力します。以下のプロパティーに値を割り当てることができます。

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. **oracle** エレメントに、作成するデータベースの名前を入力します。属性は **database** です。**database.oracle.mfp.dbname** プロパティーに値を割り当てることができます。
4. 同じ **oracle** エレメントに、作成するデータベースの **SYS** ユーザーおよび **SYSTEM** ユーザーのパスワードも入力します。属性は、**sysPassword** および **systemPassword** です。
次の対応するプロパティーに値を割り当てることができます。

    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Ant ファイルにすべてのデータベース資格情報が入力されたら、それを保存し、**databases** Ant ターゲットを実行します。

**oracle** エレメントの database に入力された SID 名を使用して、データベースが作成されます。これは、実動用に使用するものではありません。

#### ユーザーの作成
{: #creating-the-user-1 }
[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)で説明された一般ガイドラインに従って、**create-database-oracle.xml** ファイルのコピーを編集してください。

1. Oracle データベースを実行するコンピューター上で SSH サーバーを実行します。

    **configureDatabase** Ant タスクは、Oracle ホストへの SSH セッションを開き、データベースを作成します。Linux システムおよび一部のバージョンの UNIX システムを除き、Ant タスクが実行されているのと同じコンピューター上で Oracle データベースが実行されている場合でも、SSH サーバーは必要です。

2. **create-database-oracle.xml** ファイルで定義された oracle エレメントに、作成する Oracle データベース・ユーザーのログイン ID とパスワードを入力します。属性は、**user** および **password** です。
次の対応するプロパティーに値を割り当てることができます。

    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. 同じ **oracle** エレメントに、データベースの **SYSTEM** ユーザーのパスワードも入力します。属性は **systemPassword** です。**database.oracle.systemPassword** プロパティーに値を割り当てることができます。
4. **dba** エレメントに、ユーザー作成の特権を持つ Oracle データベース・ユーザーのログイン ID とパスワードを入力します。以下のプロパティーに値を割り当てることができます。

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Ant ファイルにすべてのデータベース資格情報が入力されたら、それを保存し、**databases** Ant ターゲットを実行します。

**oracle** エレメントに入力された名前とパスワードを使用して、データベース・ユーザーが作成されます。このユーザーは、{{site.data.keys.mf_server }} の表を作成し、それをアップグレードしてランタイムで使用できる特権を持ちます。

### Ant タスクによる MySQL データベース表の作成
{: #creating-the-mysql-database-tables-with-ant-tasks }
{{site.data.keys.mf_server }} のインストールで提供される Ant タスクを使用して、MySQL データベース表を作成します。

既に存在するデータベース内にデータベース表を作成するには、[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)を参照してください。

[MySQL データベースおよびユーザーの要件](#mysql-database-and-user-requirements)で推奨された設定が MySQL サーバーにない場合、**configureDatabase** Ant タスクが警告を表示します。Ant タスクを実行する前に、必ず要件を満たすようにしてください。

データベースおよびデータベース表を作成するには、[Ant タスクを使用したデータベース表の作成](#create-the-database-tables-with-ant-tasks)で説明された一般ガイドラインに従って、**create-database-mysql.xml** ファイルのコピーを編集してください。

以下の手順では、**configureDatabase** Ant タスクでデータベース表を作成する際に実行する必要のあるいくつかの追加のステップを説明しています。

1. **create-database-mysql.xml** ファイルで定義された **dba** エレメントに、MySQL 管理者のログイン ID とパスワードを入力します。デフォルトでは、管理者は **root** です。以下のプロパティーに値を割り当てることができます。

    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. **mysql** エレメントで、ユーザーがデータベースに接続する許可を得る各ホストに対し、**client** エレメントを追加します。これはすなわち、{{site.data.keys.mf_server }} が実行されるすべてのホストです。Ant ファイルにすべてのデータベース資格情報が入力されたら、それを保存し、**databases** Ant ターゲットを実行します。
