---
layout: tutorial
title: インストールに関する参照情報
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.mf_server_full }}、
{{site.data.keys.mf_app_center_full }}、および {{site.data.keys.mf_analytics_full }} のインストールのための Ant タスクおよび構成のサンプル・ファイルに関する参照情報。

#### ジャンプ先
{: #jump-to }
* [Ant configuredatabase タスクの参照情報](#ant-configuredatabase-task-reference)
* [{{site.data.keys.mf_console }}、{{site.data.keys.mf_server }} 成果物、{{site.data.keys.mf_server }} 管理サービス、およびライブ更新サービスのインストールのための Ant タスク](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [{{site.data.keys.mf_server }} プッシュ・サービスのインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Application Center のインストール用の Ant タスク](#ant-tasks-for-installation-of-application-center)
* [{{site.data.keys.mf_analytics }} のインストール用の Ant タスク](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [内部ランタイム・データベース](#internal-runtime-databases)
* [サンプル構成ファイル](#sample-configuration-files)
* [{{site.data.keys.mf_analytics }} のサンプル構成ファイル](#sample-configuration-files-for-mobilefirst-analytics)

## Ant configuredatabase タスクの参照情報
{: #ant-configuredatabase-task-reference }
configuredatabase Ant タスクの参照情報。この参照情報は、リレーショナル・データベース専用です。Cloudant には適用されません。

**configuredatabase** Ant タスクは、{{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、{{site.data.keys.mf_server }} プッシュ・サービス、{{site.data.keys.product_adj }} ランタイム、および Application Center のサービスによって使用されるリレーショナル・データベースを作成します。この Ant タスクは、以下のアクションによってリレーショナル・データベースを構成します。

* {{site.data.keys.product_adj }} 表があるかどうかを確認して、必要であれば作成します。
* 旧バージョンの {{site.data.keys.product }} の表がある場合、それらの表を現行バージョンにマイグレーションします。
* 現行バージョンの {{site.data.keys.product }} の表がある場合は、何もしません。

また、以下のいずれかの条件が満たされている場合を考えます。

* DBMS タイプが Derby である。
* 内部エレメント `<dba>` が存在する。
* DBMS タイプが DB2 で、指定ユーザーがデータベース作成許可を備えている。

この場合、タスクでは、以下の結果が得られる可能性があります。

* 必要に応じて、データベースを作成する (Oracle 12c および Cloudant を除く)。
* 必要な場合にユーザーを作成し、そのユーザーにデータベースへのアクセス権限を付与する。

> **注:** configuredatabase Ant タスクは、Cloudant で使用した場合、無効です。

### configuredatabase タスクの属性とエレメント
{: #attributes-and-elements-for-configuredatabase-task }

**configuredatabase** タスクには以下の属性があります。

| 属性 | 説明 | 必要 | デフォルト | 
|-----------|-------------|----------|---------|
| kind      | データベースのタイプ: {{site.data.keys.mf_server }}: MobileFirstRuntime、MobileFirstConfig、MobileFirstAdmin、または push。Application Center: ApplicationCenter。 | はい | なし |
| includeConfigurationTables | データベース操作をライブ更新サービスと管理サービスの両方で実行するか、または管理サービスのみで実行するかを指定します。値は true または false のいずれかになります。 |  いいえ | true |
| execute | configuredatabase Ant タスクを実行するかどうかを指定します。値は true または false のいずれかになります。 | いいえ | true | 

#### kind
{: #kind }
{{site.data.keys.product }} は、4 種類のデータベースをサポートしています。{{site.data.keys.product_adj }} ランタイムは、**MobileFirstRuntime** データベースを使用します。{{site.data.keys.mf_server }} 管理サービスは **MobileFirstAdmin** データベースを使用します。{{site.data.keys.mf_server }} ライブ更新サービスは **MobileFirstConfig** データベースを使用します。デフォルトでは、**MobileFirstAdmin** の kind で作成されます。{{site.data.keys.mf_server }} プッシュ・サービスは **push** データベースを使用します。Application Center は **ApplicationCenter** データベースを使用します。

#### includeConfigurationTables
{: #includeconfigurationtables }
**includeConfigurationTables** 属性は、**kind** 属性が **MobileFirstAdmin** の場合にのみ使用できます。有効値は、true または false になります。この属性が true に設定されている場合、**configuredatabase** タスクは、1 回の実行で管理サービス・データベースとライブ更新サービス・データベースの両方でデータベース操作を実行します。この属性が false に設定されている場合、**configuredatabase** タスクは、管理サービス・データベースのみでデータベース操作を実行します。

#### execute
{: #execute }
**execute** 属性は、**configuredatabase** Ant タスクの実行を使用可能または使用不可にします。有効値は、true または false になります。この属性が false に設定されている場合、**configuredatabase** タスクは構成操作もデータベース操作も実行しません。

**configuredatabase** タスクは、以下のエレメントをサポートします。

| エレメント             | 説明	                | カウント | 
|---------------------|-----------------------------|-------|
| `<derby>`           | Derby のパラメーター。   | 0..1  | 
| `<db2>`             |	DB2 のパラメーター。     | 0..1  | 
| `<mysql>`           |	MySQL のパラメーター。   | 0..1  | 
| `<oracle>`          |	Oracle のパラメーター。  | 0..1  | 
| `<driverclasspath>` | JDBC ドライバーのクラスパス。 | 0..1  | 

各データベース・タイプに対し、`<property>` エレメントを使用してデータベースにアクセスするための JDBC 接続プロパティーを指定することができます。
`<property>` エレメントには以下の属性があります。

| 属性 | 説明                | 必要 | デフォルト | 
|-----------|----------------------------|----------|---------|
| 名前      | プロパティーの名前。	 | はい      | なし    |
| value	    | プロパティーの値。| はい	    | なし    |   

#### Apache Derby
{: #apache-derby }
`<derby>` エレメントには以下の属性があります。

| 属性 | 説明                                | 必要 | デフォルト                                                                      | 
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
| データベース  | データベース名。                         | いいえ	    | 種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。             |
| datadir   | データベースを含むディレクトリー。 | はい      | なし                                                                         | 
| schema	| スキーマ名。                           | いいえ       | 種類に応じて、MFPDATA、MFPCFG、MFPADMINISTRATOR、MFPPUSH、または APPCENTER。 |

`<derby>` エレメントは以下のエレメントをサポートします。

| エレメント      | 説明                     | カウント   |
|--------------|---------------------------------|---------|
| `<property>` | JDBC 接続プロパティー。   | 0..∞    |

使用可能なプロパティーについては、[Setting attributes for the database connection URL](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html) を参照してください。

#### DB2
{: #db2 }
`<db2>` エレメントには以下の属性があります。

| 属性 | 説明                            | 必要 | デフォルト | 
|-----------|----------------------------------------|----------|---------|
| データベース  | データベース名。                     | いいえ       | 種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。 |
| サーバー    | データベース・サーバーのホスト名。	 | はい      | なし  |
| port      | データベース・サーバーのポート。       | いいえ	    | 50000 |
| user      | データベースにアクセスするユーザー名。 | はい	    | なし  |
| password  | データベースにアクセスするパスワード。	 | いいえ	    | 対話式に照会 |
| instance  | DB2 インスタンスの名前。          | いいえ	    | サーバーに応じて異なる |
| schema    | スキーマ名。                       | いいえ	    | ユーザーに応じて異なる   |

DB2 ユーザー・アカウントについて詳しくは、[DB2 のセキュリティー・モデルの概要](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)を参照してください。  
`<db2>` エレメントは以下のエレメントをサポートします。

| エレメント      | 説明                             | カウント   |
|--------------|-----------------------------------------|---------|
| `<property>` | JDBC 接続プロパティー。           | 0..∞    |
| `<dba>`      | データベース管理者の資格情報。 | 0..1    |

使用可能なプロパティーについては、[IBM Data Server Driver for JDBC and SQLJ のプロパティー](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)を参照してください。  
内部エレメント `<dba>` は、データベース管理者の資格情報を指定します。このエレメントには以下の属性があります。

| 属性 | 説明                            | 必要 | デフォルト | 
|-----------|----------------------------------------|----------|---------|
| user      | データベースにアクセスするユーザー名。  | はい      | なし    |
| password  | データベースにアクセスするパスワード。    | いいえ	    | 対話式に照会 |

`<dba>` エレメントに指定するユーザーは、DB2 特権の SYSADM または SYSCTRL を持っている必要があります。詳しくは、[権限の概要](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html)を参照してください。

`<driverclasspath>` エレメントは、DB2 JDBC ドライバー用および関連するライセンス用の JAR ファイルを含んでいる必要があります。これらのファイルは、以下のいずれかの方法で取得できます。

* [DB2 JDBC Driver Versions and Downloads](http://www.ibm.com/support/docview.wss?uid=swg21363866) ページから、DB2 JDBC ドライバーをダウンロードする。
* あるいは、DB2 サーバー上の **DB2_INSTALL_DIR/java** ディレクトリーから、**db2jcc4.jar** ファイルおよびそれに関連のある **db2jcc_license_*.jar** ファイルを取り出す。

Ant タスクを使用して表スペースなどの表割り振りの詳細を指定することはできません。表スペースを制御する場合は、[DB2 データベースおよびユーザーの要件](../databases/#db2-database-and-user-requirements)のセクションにある手動での指示を使用する必要があります。

#### MySQL 
{: #mysql }
エレメント `<mysql>` には以下の属性があります。

| 属性 | 説明                            | 必要 | デフォルト | 
|-----------|----------------------------------------|----------|---------|
| データベース	| データベース名。	                 | いいえ       | 種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。 |
| サーバー	| データベース・サーバーのホスト名。	 | はい	    | なし |
| port	    | データベース・サーバーのポート。	     | いいえ	    | 3306 |
| user	    | データベースにアクセスするユーザー名。 | はい	    | なし |
| password	| データベースにアクセスするパスワード。	 | いいえ	    | 対話式に照会 |

MySQL ユーザー・アカウントについて詳しくは、[MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html) を参照してください。  
`<mysql>` エレメントは以下のエレメントをサポートします。

| エレメント      | 説明                                      | カウント |
|--------------|--------------------------------------------------|-------|
| `<property>` | JDBC 接続プロパティー。                    | 0..∞  |
| `<dba>`      | データベース管理者の資格情報。          | 0..1  |
| `<client>`   | データベースへのアクセスを許可されたホスト。 | 0..∞  | 

使用可能なプロパティーについては、[Driver/Datasource Class Names, URL Syntax and Configuration
Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html) を参照してください。
内部エレメント `<dba>` は、データベース管理者資格情報を指定します。このエレメントには以下の属性があります。

| 属性 | 説明                            | 必要 | デフォルト | 
|-----------|----------------------------------------|----------|---------|
| user	    | データベースにアクセスするユーザー名。 | はい	    | なし |
| password	| データベースにアクセスするパスワード。	 | いいえ	    | 対話式に照会 |

`<dba>` エレメントに指定するユーザーは、MySQL スーパーユーザー・アカウントでなければなりません。詳しくは、[Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html) を参照してください。

各 `<client>` 内部エレメントがクライアント・コンピューターまたはクライアント・コンピューターのワイルドカードを指定します。
これらのコンピューターは、データベースへの接続が許可されます。このエレメントには以下の属性があります。

| 属性 | 説明                                                              | 必要 | デフォルト | 
|-----------|--------------------------------------------------------------------------|----------|---------|
| hostname	| シンボリック・ホスト名、IP アドレス、またはテンプレート (プレースホルダーとして % を使用) | はい	  | なし    |

hostname の構文について詳しくは、[Specifying Account Names](http://dev.mysql.com/doc/refman/5.5/en/account-names.html) を参照してください。

`<driverclasspath>` エレメントには、MySQL Connector/J JAR ファイルが含まれている必要があります。このファイルは [Download Connector/J](http://www.mysql.com/downloads/connector/j/) ページからダウンロードできます。

または、以下の属性を持つ
`<mysql>` エレメントを使用することもできます。


| 属性 | 説明                            | 必要 | デフォルト               | 
|-----------|----------------------------------------|----------|-----------------------|
| url       | データベース接続 URL。	         | はい      | なし                  |
| user	    | データベースにアクセスするユーザー名。 | はい      | なし                  |
| password	| データベースにアクセスするパスワード。	 | いいえ       | 対話式に照会 |

> `注:` 代替属性を持つデータベースを指定する場合、このデータベースとユーザー・アカウントが存在している必要があり、それとともに、ユーザーがデータベースにアクセスできるようになっている必要があります。この場合、**configuredatabase** タスクはデータベースおよびユーザーの作成を試行せず、
ユーザーのアクセス権限の付与も試行しません。
**configuredatabase** タスクにより確実となるのは、現行バージョンの {{site.data.keys.mf_server }} に必要な表がデータベースにあることのみです。内部エレメント `<dba>` と `<client>` を指定する必要はありません。#### Oracle 
{: #oracle }
エレメント `<oracle>` には以下の属性があります。

| 属性      | 説明                                                              | 必要 | デフォルト | 
|----------------|--------------------------------------------------------------------------|----------|---------|
| データベース       | データベース名、または Oracle サービス名。**注:** PDB データベースに接続するには、常にサービス名を使う必要があります。 | いいえ | ORCL |
| サーバー	     | データベース・サーバーのホスト名。                                    | はい      | なし | 
| port	         | データベース・サーバーのポート。                                         | いいえ       | 1521 | 
| user	         | データベースにアクセスするユーザー名。この表の下の注を参照してください。	| はい      | なし | 
| password	     | データベースにアクセスするパスワード。                                    | いいえ       | 対話式に照会 | 
| sysPassword	 | ユーザー SYS のパスワード。                                           | いいえ       | 対話式に照会 (データベースがまだ存在しない場合) | 
| systemPassword | ユーザー SYSTEM のパスワード。                                        | いいえ       | 対話式に照会 (データベースまたはユーザーがまだ存在していない場合) | 

> `注:` user 属性については、大文字のユーザー名を使用することをお勧めします。Oracle のユーザー名は、一般的に大文字で表されます。他のデータベース・ツールとは異なり、**configuredatabase** Ant タスクは、ユーザー名に含まれる小文字を大文字に変換しません。**configuredatabase** Ant タスクがデータベースへの接続に失敗した場合には、**user** 属性の値を大文字で入力してみてください。

Oracle ユーザー・アカウントについて詳しくは、[Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374) を参照してください。  
`<oracle>` エレメントは以下のエレメントをサポートします。

| エレメント      | 説明                                      | カウント |
|--------------|--------------------------------------------------|-------|
| `<property>` | JDBC 接続プロパティー。                    | 0..∞  |
| `<dba>`      | データベース管理者の資格情報。          | 0..1  |

使用可能な接続プロパティーについては、[Class OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html) を参照してください。  
内部エレメント `<dba>` は、データベース管理者資格情報を指定します。このエレメントには以下の属性があります。

| 属性      | 説明                                                              | 必要 | デフォルト | 
|----------------|--------------------------------------------------------------------------|----------|---------|
| user	         | データベースにアクセスするユーザー名。この表の下の注を参照してください。	| はい      | なし    | 
| password	     | データベースにアクセスするパスワード。                                    | いいえ       | 対話式に照会 | 

`<driverclasspath>` エレメントには、Oracle JDBC ドライバーの JAR ファイルが含まれている必要があります。Oracle
JDBC ドライバーは、[JDBC and Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) からダウンロードできます。

表スペースなどの表割り振りの詳細を、Ant タスクで指定することはできません。表スペースを制御する場合は、ユーザー・アカウントを手動で作成し、そのアカウントにデフォルト表スペースを割り当ててから、Ant タスクを実行することができます。他の詳細を制御する場合は、[Oracle データベースおよびユーザーの要件](../databases/#oracle-database-and-user-requirements)のセクションにある手動での指示を使用する必要があります。

| 属性 | 説明                            | 必要 | デフォルト               | 
|-----------|----------------------------------------|----------|-----------------------|
| url       | データベース接続 URL。	         | はい      | なし                  |
| user	    | データベースにアクセスするユーザー名。 | はい      | なし                  |
| password	| データベースにアクセスするパスワード。	 | いいえ       | 対話式に照会 |

> **注:** 代替属性を持つデータベースを指定する場合、このデータベースとユーザー・アカウントが存在している必要があり、それとともに、ユーザーがデータベースにアクセスできるようになっている必要があります。この場合、タスクはデータベースおよびユーザーの作成を試行せず、ユーザーのアクセス権限の付与も試行しません。**configuredatabase** タスクにより確実となるのは、現行バージョンの {{site.data.keys.mf_server }} に必要な表がデータベースにあることのみです。内部エレメント`<dba>` を指定する必要はありません。

## {{site.data.keys.mf_console }}、{{site.data.keys.mf_server }} 成果物、{{site.data.keys.mf_server }} 管理サービス、およびライブ更新サービスのインストールのための Ant タスク
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
**installmobilefirstadmin**、**updatemobilefirstadmin**、および **uninstallmobilefirstadmin** の各 Ant タスクが、{{site.data.keys.mf_console }}、成果物コンポーネント、管理サービス、およびライブ更新サービスのインストールのために提供されています。

### タスクの結果
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
**installmobilefirstadmin** Ant タスクは、管理サービスおよびライブ更新サービスの WAR ファイルを Web アプリケーションとして実行するように、また、オプションで {{site.data.keys.mf_console }} をインストールするように、アプリケーション・サーバーを構成します。このタスクは以下のような結果をもたらします。

* 指定されたコンテキスト・ルート (デフォルトで /mfpadmin) で管理サービス Web アプリケーションを宣言します。
* 管理サービスの、指定されたコンテキスト・ルートから派生したコンテキスト・ルートでライブ更新サービス Web アプリケーションを宣言します。デフォルトで、/mfpadminconfig です。
* リレーショナル・データベースの場合、データ・ソースを宣言し、WebSphere Application Server フル・プロファイルでは管理サービスの JDBC プロバイダーを宣言します。
* 管理サービスとライブ更新サービスをアプリケーション・サーバーにデプロイします。
* オプションで、指定されたコンテキスト・ルート (デフォルトでは /mfpconsole) で、{{site.data.keys.mf_console }} を Web アプリケーションとして宣言します。{{site.data.keys.mf_console }} インスタンスが指定されている場合、Ant タスクは、対応する管理サービスと通信するために適切な JNDI 環境項目を宣言します。以下に例を示します。

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* オプションで、{{site.data.keys.mf_console }} のインストール時に、指定されたコンテキスト・ルート /mfp-dev-artifacts で {{site.data.keys.mf_server }} 成果物 Web アプリケーションを宣言します。
* JNDI 環境項目を使用して管理サービスの構成プロパティーが構成されます。これらの JNDI 環境項目は、アプリケーション・サーバー・トポロジーに関するいくつかの追加情報も提供します。例えば、トポロジーがスタンドアロン構成か、クラスターか、またはサーバー・ファームかなどです。
* オプションで、{{site.data.keys.mf_console }} と、管理サービスおよびライブ更新サービスの Web アプリケーションで使用されるロールにマップするユーザーを構成します。
* JMX の使用のためにアプリケーション・サーバーが構成されます。
* オプションで、{{site.data.keys.mf_server }} プッシュ・サービスとの通信を構成します。
* オプションで、MobileFirst JNDI 環境項目を設定して、{{site.data.keys.mf_server }} 管理パート用にアプリケーション・サーバーをサーバー・ファーム・メンバーとして構成します。

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
**updatemobilefirstadmin** Ant タスクは、アプリケーション・サーバー上の構成済み {{site.data.keys.mf_server }} Web アプリケーションを更新します。このタスクは以下のような結果をもたらします。

* 管理サービス WAR ファイルを更新します。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。
* ライブ更新サービス WAR ファイルを更新します。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。
* {{site.data.keys.mf_console }} の WAR ファイルを更新します。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。このタスクは、アプリケーション・サーバー構成、すなわち Web アプリケーション構成、データ・ソース、JNDI 環境項目、ユーザーとロールのマッピング、および JMX 構成を変更しません。

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
**uninstallmobilefirstadmin** Ant タスクは、installmobilefirstadmin の以前の実行の結果を元に戻します。このタスクは以下のような結果をもたらします。

* 指定されたコンテキスト・ルートを持つ管理サービス Web アプリケーションの構成が削除されます。その結果、このタスクは、そのアプリケーションに手動で追加された設定も削除します。
* オプションで、管理サービスおよびライブ更新サービスの WAR ファイル、および {{site.data.keys.mf_console }} をアプリケーション・サーバーから削除します。
* リレーショナル DBMS の場合、データ・ソースを削除し、WebSphere Application Serverフル・プロファイルでは管理サービスおよびライブ更新サービスの JDBC プロバイダーを削除します。
* リレーショナル DBMS の場合、管理サービスおよびライブ更新サービスによって使用されたデータベース・ドライバーをアプリケーション・サーバーから削除します。
* 関連する JNDI 環境項目が削除されます。
* WebSphere Application Server Liberty および Apache Tomcat 上で、installmobilefirstadmin 呼び出しによって構成されたユーザーを削除します。
* JMX 構成が削除されます。

### 属性およびエレメント
{: #attributes-and-elements }
**installmobilefirstadmin**、**updatemobilefirstadmin**、および **uninstallmobilefirstadmin** の各 Ant タスクは以下の属性を持っています。

| 属性         | 説明                                                              | 必要 | デフォルト | 
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       | {{site.data.keys.product_adj }} ランタイム環境、アプリケーション、およびアダプターに関する情報を取得するための、管理サービスの URL の共通接頭部 | いいえ | /mfpadmin | 
| id                | さまざまなデプロイメントを区別する。              | いいえ | 空 | 
| environmentId     | さまざまな {{site.data.keys.product_adj }} 環境を区別する。 | いいえ | 空 | 
| servicewar        | 管理サービスの WAR ファイル       | いいえ | mfp-admin-service.war ファイルは、mfp-ant-deployer.jar ファイルと同じディレクトリー内にあります。 | 
| shortcutsDir      | ショートカットを配置するディレクトリー。            | いいえ | なし | 
| wasStartingWeight | WebSphere Application Server の開始順序。低い値から先に開始されます。 | いいえ | 1 | 

#### contextroot および id
{: #contextroot-and-id }
**contextroot** 属性と **id** 属性は、{{site.data.keys.mf_console }} および管理サービスの異なるデプロイメントを識別します。

WebSphere Application Server Liberty プロファイルおよび Tomcat の環境では、この目的には contextroot パラメーターで十分です。WebSphere Application Server フル・プロファイル環境では、id 属性が代わりに使用されます。この id 属性がないと、同じコンテキスト・ルートを持つ 2 つの WAR ファイルが競合し、これらのファイルがデプロイされない可能性があります。

#### environmentId
{: #environmentid }
**environmentId** 属性を使用して、独立して作動しなければならない、{{site.data.keys.mf_server }} 管理サービスおよび {{site.data.keys.product_adj }} ランタイム Web アプリケーションのそれぞれから構成される、複数の環境を区別します。例えば、このオプションを使用して、同じサーバー上、または同じ WebSphere Application Server Network Deployment セル内のテスト環境、実動前環境、および実稼働環境をホストすることができます。この environmentId 属性は、管理サービスと {{site.data.keys.product_adj }} ランタイムのプロジェクトが Java Management Extensions (JMX) を介して通信するときに使用する MBean 名に追加される接尾部を作成します。

#### servicewar
{: #servicewar }
**servicewar** 属性を使用して、管理サービス WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

#### shortcutsDir
{: #shortcutsdir }
**shortcutsDir** 属性は、{{site.data.keys.mf_console }} のショートカットを配置する場所を指定します。この属性を設定した場合、そのディレクトリーに以下のファイルを追加できます。

* **mobilefirst-console.url** - このファイルは、Windows のショートカットです。これは、{{site.data.keys.mf_console }} をブラウザーで開きます。
* **mobilefirst-console.sh** - このファイルは、UNIX のシェル・スクリプトであり、{{site.data.keys.mf_console }} をブラウザーで開きます。
* **mobilefirst-admin-service.url** - このファイルは、Windows のショートカットです。これはブラウザーで開き、JSON 形式で管理できる {{site.data.keys.product_adj }} プロジェクトのリストを返す REST サービスを呼び出します。リストされている {{site.data.keys.product_adj }} の各プロジェクトについて、それらの成果物に関する詳細情報 (アプリケーションの数、アダプターの数、アクティブ・デバイスの数、廃止されたデバイスの数など) も表示されます。このリストには、{{site.data.keys.product_adj }} プロジェクト・ランタイムが実行中であるかアイドル状態であるかも示されます。
* **mobilefirst-admin-service.sh** - このファイルは、**mobilefirst-admin-service.url** ファイルと同じ出力を行う UNIX のシェル・スクリプトです。

#### wasStartingWeight
{: #wasstartingweight }
**wasStartingWeight** 属性を使用して、開始順序が順守されることを確実にするためのウェイトとして WebSphere Application Server で使用される値を指定します。この開始順序の値の結果、管理サービス Web アプリケーションは、他のどの {{site.data.keys.product_adj }} ランタイム・プロジェクトよりも前にデプロイされて開始されます。{{site.data.keys.product_adj }} プロジェクトが Web アプリケーションより前にデプロイまたは開始されると、JMX 通信は確立されず、ランタイムは管理サービス・データベースと同期化することも、サーバー要求を処理することもできません。

**installmobilefirstadmin**、**updatemobilefirstadmin**、および
**uninstallmobilefirstadmin** の各 Ant タスクでは、以下のエレメントがサポートされます。

| エレメント               | 説明                                      | カウント |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` | アプリケーション・サーバー。                          | 1     |
| `<configuration>`     | ライブ更新サービス。	                       | 1     |
| `<console>`           | 管理コンソール。                      | 0..1  |
| `<database>`          | データベース。                                   | 1     |
| `<jmx>`               | Java Management Extensions を使用可能にする。	           | 1     |
| `<property>`          | プロパティー。	                               | 0..   |
| `<push>`              | プッシュ・サービス。	                               | 0..1  |
| `<user>`              | セキュリティー・ロールにマップされるユーザー。	       | 0..   |

### {{site.data.keys.mf_console }} を指定するには
{: #to-specify-a-mobilefirst-operations-console }
`<console>` エレメントは、{{site.data.keys.mf_console }} のインストールをカスタマイズするための情報を収集します。このエレメントには以下の属性があります。

| 属性         | 説明                                                               | 必要 | デフォルト     | 
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       | {{site.data.keys.mf_console }} の URI。                            | いいえ       | /mfpconsole |
| install           | {{site.data.keys.mf_console }} をインストールする必要があるかどうかを示す。 | いいえ       | はい         |
| warfile           | コンソール WAR ファイル。	                                                    |いいえ        | mfp-admin-ui.war ファイルは、mfp-ant-deployer.jar ファイルと同じディレクトリー内にあります。 |

`<console>` エレメントでは、以下のエレメントがサポートされます。

| エレメント               | 説明                                      | カウント |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         | {{site.data.keys.mf_server }} 成果物。                | 0..1  |
| `<property>`	        | プロパティー。	                               | 0..   |

`<artifacts>` エレメントには以下の属性があります。

| 属性         | 説明                                                               | 必要 | デフォルト     | 
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           | 成果物コンポーネントをインストールする必要があるかどうかを示す。            | いいえ       | true        |
| warFile           | 成果物 WAR ファイル。                                                   | いいえ       | mfp-dev-artifacts.war ファイルは、mfp-ant-deployer.jar ファイルと同じディレクトリー内にあります。 |

このエレメントを使用して、独自の JNDI プロパティーを定義したり、管理サービスおよび {{site.data.keys.mf_console }} の WAR ファイルによって提供されている JNDI プロパティーのデフォルト値をオーバーライドしたりすることができます。

`<property>` エレメントは、アプリケーション・サーバーに定義するデプロイメント・プロパティーを指定します。
これには、以下の属性があります。

| 属性  | 説明                | 必要 | デフォルト | 
|------------|----------------------------|----------|---------|
| 名前       | プロパティーの名前。  | はい      | なし    | 
| value	     | プロパティーの値。 |	はい      | なし    |

このエレメントを使用して、独自の JNDI プロパティーを定義したり、管理サービスおよび {{site.data.keys.mf_console }} の WAR ファイルによって提供されている JNDI プロパティーのデフォルト値をオーバーライドしたりすることができます。

JNDI プロパティーについて詳しくは、[{{site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

### アプリケーション・サーバーを指定するには
{: #to-specify-an-application-server }
`<applicationserver>` エレメントを使用して、基礎となるアプリケーション・サーバーに依存するパラメーターを定義します。`<applicationserver>` エレメントは以下のエレメントをサポートしています。

| エレメント                                   | 説明                                      | カウント |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` または `<was>` | WebSphere Application Server のパラメーター。<br/><br/> `<websphereapplicationserver>` エレメント (短縮形では `was>`) は、WebSphere Application Server インスタンスを示します。WebSphere Application Server フル・プロファイル (Base、および Network Deployment) がサポートされ、WebSphere Application Server Liberty Core および WebSphere Application Server Liberty Network Deployment もサポートされます。               | 0..1  |
| `<tomcat>`                                | Apache Tomcat のパラメーター。	               | 0..1  |

これらのエレメントの属性および内部エレメントについては、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) の表に説明があります。  
ただし、Liberty 集合の `<was>` エレメントの内部エレメントについては、以下の表を参照してください。

| エレメント                  | 説明                      | カウント |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` | Liberty 集合コントローラー。 |	0..1  |

`<collectiveController>` エレメントには以下の属性があります。

| 属性                | 説明                            | 必要 | デフォルト | 
|--------------------------|----------------------------------------|----------|---------|
| serverName               | 集合コントローラーの名前。	| はい      | なし    |
| controllerAdminName      | 集合コントローラーに定義された管理ユーザー名。 これは、新規メンバーを集合に参加させるために使用されるのと同じユーザーです。                                                         | はい      | なし    |
| controllerAdminPassword  | 管理ユーザー・パスワード。	    | はい      | なし    |
| createControllerAdmin    | 集合コントローラーの基本レジストリー内に管理ユーザーが作成される必要があるかどうかを示す。指定可能な値は true または false です。                                                              | いいえ	   | true    |

### ライブ更新サービスの構成を指定するには
{: #to-specify-the-live-update-service-configuration }
`<configuration>` エレメントを使用して、ライブ更新サービスに依存するパラメーターを定義します。`<configuration>` エレメントには以下の属性があります。

| 属性                | 説明                                                    | 必要 | デフォルト | 
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  | ライブ更新サービスをインストールする必要があるかどうかを示す。	| はい | true |
| configAdminUser	       | ライブ更新サービスの管理者。	                | いいえ。ただし、サーバー・ファーム・トポロジーの場合は必須。 |定義されていない場合、ユーザーが生成されます。サーバー・ファーム・トポロジーでは、ユーザー名はファームのすべてのメンバーで同じでなければなりません。 |
| configAdminPassword      | ライブ更新サービス・ユーザーの管理者パスワード。       | ユーザーが **configAdminUser** に指定されている場合。 | なし。サーバー・ファーム・トポロジーでは、パスワードはファームのすべてのメンバーで同じでなければなりません。 |
| createConfigAdminUser	   | アプリケーション・サーバーの基本レジストリー内に管理ユーザーがない場合に作成するかどうかを示す。 | いいえ | true |
| warFile                  | ライブ更新サービス WAR ファイル。	                            | いいえ         | mfp-live-update.war ファイルは、mfp-ant-deployer.jar ファイルと同じディレクトリー内にあります。 |

`<configuration>` エレメントは以下のエレメントをサポートします。

| エレメント      | 説明                           | カウント |
|--------------|---------------------------------------|-------|
| `<user>`     | ライブ更新サービスのユーザー。 | 0..1  |
| `<property>` | プロパティー。	                   | 0..   |

`<user>` エレメントは、アプリケーションの特定のセキュリティー・ロールに含める、ユーザーに関するパラメーターを収集します。

| 属性   | 説明                                                             | 必要 | デフォルト | 
|-------------|-------------------------------------------------------------------------|----------|---------|
| role	      | アプリケーションの有効なセキュリティー・ロール。可能な値: configadmin。	| はい      | なし    |
| 名前	      | ユーザー名。	                                                        | はい      | なし    |
| password	  | ユーザーを作成する必要がある場合のパスワード。	                        | いいえ       | なし    |

`<user>` エレメントを使用してユーザーを定義した後、それらのユーザーを、{{site.data.keys.mf_console }} 内の以下の認証用のロールにマップすることができます。`configadmin`

特定のロールによってどの許可が暗黙指定されているかについて詳しくは、[{{site.data.keys.mf_server }} 管理用のユーザー認証の構成](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)を参照してください。

> **ヒント:** ユーザーが外部 LDAP ディレクトリーに存在する場合は、**role** 属性と **name** 属性のみを設定し、パスワードは定義しないでください。`<property>` エレメントは、アプリケーション・サーバーに定義するデプロイメント・プロパティーを指定します。
これには、以下の属性があります。

| 属性  | 説明                | 必要 | デフォルト | 
|------------|----------------------------|----------|---------|
| 名前       | プロパティーの名前。  | はい      | なし    | 
| value	     | プロパティーの値。 |	はい      | なし    |

このエレメントを使用して、独自の JNDI プロパティーを定義したり、管理サービスおよび {{site.data.keys.mf_console }} の WAR ファイルによって提供されている JNDI プロパティーのデフォルト値をオーバーライドしたりすることができます。JNDI プロパティーについて詳しくは、[{{site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

### アプリケーション・サーバーを指定するには
{: #to-specify-an-application-server-1 }
`<applicationserver>` エレメントを使用して、基礎となるアプリケーション・サーバーに依存するパラメーターを定義します。`<applicationserver>` エレメントは以下のエレメントをサポートしています。

| エレメント      | 説明                                              | カウント |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` または `<was>`	| WebSphere Application Server のパラメーター。<br/><br/><websphereapplicationserver> エレメント (短縮形では <was>) は、WebSphere Application Server インスタンスを示します。WebSphere Application Server フル・プロファイル (Base、および Network Deployment) がサポートされ、WebSphere Application Server Liberty Core および WebSphere Application Server Liberty Network Deployment もサポートされます。 | 0..1  | 
| `<tomcat>`   | Apache Tomcat のパラメーター。                        | 0..1  |

これらのエレメントの属性および内部エレメントについては、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) の表に説明があります。  
ただし、Liberty 集合の <was> エレメントの内部エレメントについては、以下の表を参照してください。

| エレメント               | 説明                  | カウント |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	| Liberty 集合メンバー。 | 0..1  |

`<collectiveMember>` エレメントには以下の属性があります。

| 属性   | 説明                                             | 必要 | デフォルト | 
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	集合メンバーの名前。                      | はい      | なし    |
| clusterName |	集合メンバーが所属しているクラスター名。 | はい	   | なし    |

> **注:** プッシュ・サービスとランタイム・コンポーネントが同じ集合メンバーにインストールされている場合、それらのクラスター名は同じでなければなりません。これらのコンポーネントが、同じ集合の別々のメンバーにインストールされている場合、クラスター名は異なっていてもかまいません。

### Analytics の指定
{: #to-specify-analytics }
`<analytics>` エレメントは、既にインストールされている {{site.data.keys.mf_analytics }} サービスに {{site.data.keys.product_adj }} プッシュ・サービスを接続することを指示します。これには、以下の属性があります。

| 属性     | 説明                                                               | 必要 | デフォルト | 
|---------------|---------------------------------------------------------------------------|----------|---------|
| install	    | プッシュ・サービスを {{site.data.keys.mf_analytics }} に接続するかどうかを示します。 | いいえ       | false   |
| analyticsURL 	| {{site.data.keys.mf_analytics }} サービスの URL。	                            | はい	   | なし    |
| username	    | ユーザー名。	                                                        | はい	   | なし    |
| password	    | パスワード。	                                                            | はい	   | なし    |
| validate	    | {{site.data.keys.mf_analytics_console }} がアクセス可能かどうかを検証します。	| いいえ	   | true    |

**install**  
install 属性は、このプッシュ・サービスが接続され、イベントを {{site.data.keys.mf_analytics }} に送信する必要があることを指示するために使用します。有効な値は true または false です。

**analyticsURL**  
analyticsURL 属性は、着信分析データを受信する {{site.data.keys.mf_analytics }} によって公開される URL を指定するために使用します。

例えば、`http://<hostname>:<port>/analytics-service/rest` などです。

**username**  
username 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名を指定するために使用します。

**password**  
password 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるパスワードを指定するために使用します。

**validate**  
validate 属性は、{{site.data.keys.mf_analytics_console }}にアクセス可能かどうかを検証するため、およびパスワードでのユーザー名認証を検査するために使用します。指定可能な値は true または false です。

### プッシュ・サービス・データベースへの接続の指定
{: #to-specify-a-connection-to-the-push-service-database }

`<database>` エレメントは、プッシュ・サービス・データベースにアクセスするためのアプリケーション・サーバー内のデータ・ソース宣言を指定するパラメーターを収集します。

次のように単一のデータベースを宣言する必要があります。`<database kind="Push">`。`<database>` エレメントは、configuredatabase Ant タスクと同様に指定します。ただし、`<database>` エレメントには `<dba>` エレメントと `<client>` エレメントはありません。`<property>` エレメントは含まれる場合があります。

`<database>` エレメントには以下の属性があります。

| 属性     | 説明                                     | 必要 | デフォルト | 
|---------------|-------------------------------------------------|----------|---------|
| kind          | データベースの種類 (Push)。	                  | はい	     | なし    |
| validate	    | データベースがアクセス可能かどうかを検証します。 | いいえ       | true    |

`<database>` エレメントは以下のエレメントをサポートしています。リレーショナル DBMS の場合のこれらのデータベース・エレメントの構成について詳しくは、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)の表を参照してください。

| エレメント            | 説明                                                      | カウント |
|--------------------|----------------------------------------------------------------- |-------|
| <db2>	             | DB2 データベースのパラメーター。	                            | 0..1  |
| <derby>	         | Apache Derby データベースのパラメーター。	                    | 0..1  | 
| <mysql>	         | MySQL データベースのパラメーター。                               | 0..1  |
| <oracle>	         | Oracle データベースのパラメーター。	                            | 0..1  |
| <cloudant>	     | Cloudant データベースのパラメーター。	                        | 0..1  |
| <driverclasspath>	 | JDBC ドライバー・クラスパスのパラメーター (リレーショナル DBMS のみ)。 | 0..1  |

> **注:** `<cloudant>` エレメントの属性は、ランタイムとは若干異なります。詳しくは、以下の表を参照してください。

| 属性     | 説明                                     | 必要 | デフォルト                   | 
|---------------|-------------------------------------------------|----------|---------------------------|
| url           | Cloudant アカウントの URL。                | いいえ       | https://user.cloudant.com |
| user          | Cloudant アカウントのユーザー名。	      | はい	     | なし                      |
| password      | Cloudant アカウントのパスワード。	          | いいえ	     | 対話式に照会     |
| dbName        | Cloudant データベースの名前。**重要:** このデータベース名は小文字で開始し、小文字 (a から z)、数字 (0 から 9)、文字 _、$、および - のみを含んでいる必要があります。                                | いいえ       | mfp_push_db               |

## {{site.data.keys.mf_server }} プッシュ・サービスのインストールに関する Ant タスク
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
**installmobilefirstpush**、**updatemobilefirstpush**、および **uninstallmobilefirstpush** の各 Ant タスクが、プッシュ・サービスのインストール用に用意されています。

### タスクの結果
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
**installmobilefirstpush** Ant タスクは、プッシュ・サービス WAR ファイルを Web アプリケーションとして実行するようにアプリケーション・サーバーを構成します。このタスクは以下のような結果をもたらします。**/imfpush** コンテキスト・ルートで、プッシュ・サービス Web アプリケーションを宣言します。コンテキスト・ルートは変更できません。リレーショナル・データベースの場合、データ・ソースを宣言し、WebSphere Application Server フル・プロファイルではプッシュ・サービスの JDBC プロバイダーを宣言します。JNDI 環境項目を使用してプッシュ・サービスの構成プロパティーが構成されます。これらの JNDI 環境項目は、{{site.data.keys.product_adj }} 許可サーバーおよび {{site.data.keys.mf_analytics }} との、また Cloudant の使用時には Cloudant との OAuth 通信を構成します。

#### updatemobilefirstpush
{: #updatemobilefirstpush }
**updatemobilefirstpush** Ant タスクは、アプリケーション・サーバー上の構成済み {{site.data.keys.mf_server }} Web アプリケーションを更新します。このタスクにより、プッシュ・サービスの WAR ファイルが更新されます。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
**uninstallmobilefirstpush** Ant タスクは、**installmobilefirstpush** の以前の実行の結果を元に戻します。このタスクは以下のような結果をもたらします。指定されたコンテキスト・ルートを持つプッシュ・サービス Web アプリケーションの構成が削除されます。その結果、このタスクは、そのアプリケーションに手動で追加された設定も削除します。アプリケーション・サーバーからプッシュ・サービスの WAR ファイルを削除します (オプション)。リレーショナル DBMS の場合、データ・ソースを削除し、WebSphere Application Server フル・プロファイルではプッシュ・サービスの JDBC プロバイダーを削除します。関連する JNDI 環境項目が削除されます。

### 属性およびエレメント
{: #attributes-and-elements-1 }
**installmobilefirstpush**、**updatemobilefirstpush**、および **uninstallmobilefirstpush** の各 Ant タスクには、以下の属性があります。

| 属性 | 説明                           | 必要 | デフォルト     | 
|-----------|---------------------------------------|----------|-------------|
| id        | さまざまなデプロイメントを区別する。	| いいえ	   | 空| warFile	| プッシュ・サービスの WAR ファイル	| いいえ	   | ../PushService/mfp-push-service.war ファイルは、mfp-ant-deployer.jar ファイルを含む MobileFirstServer ディレクトリーに対して相対です。 |

### id
{: #id }
**id** 属性は、同じ WebSphere Application Server セル内にあるプッシュ・サービスの異なるデプロイメントを識別します。この id 属性がないと、同じコンテキスト・ルートを持つ 2 つの WAR ファイルが競合し、これらのファイルがデプロイされない可能性があります。

### warFile
{: #warfile }
**warFile** 属性を使用して、プッシュ・サービス WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

**installmobilefirstpush**、**updatemobilefirstpush**、および
**uninstallmobilefirstpush** の各 Ant タスクでは、以下のエレメントがサポートされます。

| エレメント               | 説明             | カウント |
|-----------------------|-------------------------|-------|
| `<applicationserver>` | アプリケーション・サーバー。 | 1     |
| `<analytics>`	        | 分析。	      | 0..1  | 
| `<authorization>`	    | 他の {{site.data.keys.mf_server }} コンポーネントとの通信を認証するための許可サーバー。 | 1 |
| `<database>`	        | データベース。	      | 1     |
| `<property>`	        | プロパティー。	      | 0..∞  | 

### 許可サーバーを指定するには
{: #to-specify-the-authorization-server }
`<authorization>` エレメントは、他の {{site.data.keys.mf_server }} コンポーネントとの認証通信用の許可サーバーを構成するための情報を収集します。このエレメントには以下の属性があります。

| 属性          | 説明                           | 必要 | デフォルト     | 
|--------------------|---------------------------------------|----------|-------------|
| auto               | 許可サーバーの URL が計算されるかどうかを示します。指定可能な値は true または false です。	| WebSphere Application Server Network Deployment クラスターまたはノード上では必要。   	 | true | 
| authorizationURL   | 許可サーバーの URL。	 | モードが auto でない場合。 | ローカル・サーバー上のランタイムのコンテキスト・ルート。 |
| runtimeContextRoot | ランタイムのコンテキスト・ルート。	     | いいえ	     | /mfp       | 
| pushClientID	     | 許可サーバーでのプッシュ・サービスの機密 ID。  | はい | なし |
| pushClientSecret	 | 許可サーバーでのプッシュ・サービスの機密クライアントのパスワード。 | はい | なし |

#### auto
{: #auto }
値が true に設定されると、ローカル・アプリケーション・サーバーのランタイムのコンテキスト・ルートを使用して、許可サーバーの URL が自動的に計算されます。auto モードは、クラスター上の WebSphere Application Server Network Deployment にデプロイする場合、サポートされません。

#### authorizationURL
{: #authorizationurl }
許可サーバーの URL。許可サーバーが {{site.data.keys.product_adj }} ランタイムの場合、この URL はランタイムの URL です。例えば、`http://myHost:9080/mfp` などです。

#### runtimeContextRoot
{: #runtimecontextroot }
自動モードで許可サーバーの URL を計算するために使用されるランタイムのコンテキスト・ルート。
#### pushClientID
{: #pushclientid }
許可サーバーの機密クライアントとしての、このプッシュ・サービス・インスタンスの ID。この ID と秘密鍵は、許可サーバー用に登録されている必要があります。登録は、
**installmobilefirstadmin** Ant タスクによって、もしくは {{site.data.keys.mf_console }} から行えます。

#### pushClientSecret
{: #pushclientsecret }
許可サーバーの機密クライアントとしての、このプッシュ・サービス・インスタンスの秘密鍵。この ID と秘密鍵は、許可サーバー用に登録されている必要があります。登録は、
**installmobilefirstadmin** Ant タスクによって、もしくは {{site.data.keys.mf_console }} から行えます。

`<property>` エレメントは、アプリケーション・サーバーに定義するデプロイメント・プロパティーを指定します。
これには、以下の属性があります。

| 属性  | 説明                | 必要 | デフォルト | 
|------------|----------------------------|----------|---------|
| 名前       | プロパティーの名前。  |	はい	     | なし    |
| value	     | プロパティーの値。 |	はい	     | なし    |

このエレメントを使用して、独自の JNDI プロパティーを定義したり、プッシュ・サービス WAR ファイルによって提供されている JNDI プロパティーのデフォルト値をオーバーライドしたりすることができます。

JNDI プロパティーについて詳しくは、[{{site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)を参照してください。

### アプリケーション・サーバーを指定するには
{: #to-specify-an-application-server-2 }
`<applicationserver>` エレメントを使用して、基礎となるアプリケーション・サーバーに依存するパラメーターを定義します。`<applicationserver>` エレメントは以下のエレメントをサポートしています。

| エレメント                               | 説明                                      | カウント |
|---------------------------------------|--------------------------------------------------|-------|
| <websphereapplicationserver> または <was>	| WebSphere Application Server のパラメーター。 | `<websphereapplicationserver>` エレメント (短縮形では `<was>`) は、WebSphere Application Server インスタンスを示します。WebSphere Application Server フル・プロファイル (Base、および Network Deployment) がサポートされ、WebSphere Application Server Liberty Core および WebSphere Application Server Liberty Network Deployment もサポートされます。 | 0..1 |
| `<tomcat>` | Apache Tomcat のパラメーター。 | 0..1 |

これらのエレメントの属性および内部エレメントについては、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) の表に説明があります。

ただし、Liberty 集合の `<was>` エレメントの内部エレメントについては、以下の表を参照してください。

| エレメント              | 説明                  | カウント |
|----------------------|------------------------------|-------|
| `<collectiveMember>` | Liberty 集合メンバー。 |	0..1  |

`<collectiveMember>` エレメントには以下の属性があります。

| 属性   | 説明                        | 必要 | デフォルト | 
|-------------|------------------------------------|----------|---------|
| serverName  | 集合メンバーの名前。 | はい      | なし    |
| clusterName |	集合メンバーが所属しているクラスター名。 | はい | なし |

> **注:** プッシュ・サービスとランタイム・コンポーネントが同じ集合メンバーにインストールされている場合、それらのクラスター名は同じでなければなりません。これらのコンポーネントが、同じ集合の別々のメンバーにインストールされている場合、
クラスター名は異なっていてもかまいません。### Analytics の指定
{: #to-specify-analytics-1 }
`<analytics>` エレメントは、既にインストールされている {{site.data.keys.mf_analytics }} サービスに {{site.data.keys.product_adj }} プッシュ・サービスを接続することを指示します。これには、以下の属性があります。

| 属性    | 説明                        | 必要 | デフォルト | 
|--------------|------------------------------------|----------|---------|
| install	   | プッシュ・サービスを {{site.data.keys.mf_analytics }} に接続するかどうかを示します。 | いいえ | false | 
| analyticsURL | {{site.data.keys.mf_analytics }} サービスの URL。 | はい | なし | 
| username	   | ユーザー名。 | はい | なし | 
| password	   | パスワード。 | はい | なし | 
| validate	   | {{site.data.keys.mf_analytics_console }} がアクセス可能かどうかを検証します。 | いいえ | true | 

#### install
{: #install }
**install** 属性は、このプッシュ・サービスが接続され、イベントを {{site.data.keys.mf_analytics }} に送信する必要があることを指示するために使用します。有効な値は true または false です。

#### analyticsURL
{: #analyticsurl }
**analyticsURL** 属性は、着信分析データを受信する {{site.data.keys.mf_analytics }} によって公開される URL を指定するために使用します。  
例えば、`http://<hostname>:<port>/analytics-service/rest` などです。

#### username
{: #username }
**username** 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名を指定するために使用します。

#### password
{: #password }
**password** 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるパスワードを指定するために使用します。

#### validate
{: #validate }
**validate** 属性は、{{site.data.keys.mf_analytics_console }}にアクセス可能かどうかを検証するため、およびパスワードでのユーザー名認証を検査するために使用します。指定可能な値は true または false です。

### プッシュ・サービス・データベースへの接続の指定
{: #to-specify-a-connection-to-the-push-service-database-1 }
`<database>` エレメントは、プッシュ・サービス・データベースにアクセスするためのアプリケーション・サーバー内のデータ・ソース宣言を指定するパラメーターを収集します。

次のように単一のデータベースを宣言する必要があります。`<database kind="Push">`。`<database>` エレメントは、configuredatabase Ant タスクと同様に指定します。ただし、`<database>` エレメントには `<dba>` エレメントと `<client>` エレメントはありません。`<property>` エレメントは含まれる場合があります。

`<database>` エレメントには以下の属性があります。

| 属性    | 説明                  | 必要 | デフォルト | 
|--------------|------------------------------|----------|---------|
| kind         | データベースの種類 (Push)。 | はい      | なし    |
| validate	   | データベースがアクセス可能かどうかを検証します。 | いいえ | true |

`<database>` エレメントは以下のエレメントをサポートしています。リレーショナル DBMS の場合のこれらのデータベース・エレメントの構成について詳しくは、[{{site.data.keys.product_adj }} ランタイム環境のインストール用の Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)の表を参照してください。

| エレメント              | 説明                               | カウント |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           | DB2 データベースのパラメーター。         | 0..1  | 
| `<derby>`	           | Apache Derby データベースのパラメーター。 | 0..1  | 
| `<mysql>`	           | MySQL データベースのパラメーター。        | 0..1  | 
| `<oracle>`           | Oracle データベースのパラメーター。       | 0..1  |
| `<cloudant>`	       | Cloudant データベースのパラメーター。     | 0..1  | 
| `<driverclasspath>`  | JDBC ドライバー・クラスパスのパラメーター (リレーショナル DBMS のみ)。 | 0..1 |

> **注:** `<cloudant>` エレメントの属性は、ランタイムとは若干異なります。詳しくは、以下の表を参照してください。

| 属性    | 説明                            | 必要   | デフォルト | 
|--------------|----------------------------------------|------------|---------|
| url	       | Cloudant アカウントの URL。       | いいえ         | https://user.cloudant.com | 
| user	       | Cloudant アカウントのユーザー名。 | はい | なし |
| password	   | Cloudant アカウントのパスワード。	| いいえ  | 対話式に照会 |
| dbName	   | Cloudant データベースの名前。**重要:** このデータベース名は小文字で開始し、小文字 (a から z)、数字 (0 から 9)、文字 _、$、および - のみを含んでいる必要があります。 |いいえ	| mfp_push_db |

## {{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
**installmobilefirstruntime**、**updatemobilefirstruntime**、および **uninstallmobilefirstruntime** の各 Ant タスクに関する参照情報を示します。

### タスクの結果
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
**installmobilefirstruntime** Ant タスクは、{{site.data.keys.product_adj }} ランタイム WAR ファイルを Web アプリケーションとして実行するようにアプリケーション・サーバーを構成します。このタスクの結果は以下のとおりです。

* {{site.data.keys.product_adj }} Web アプリケーションを、指定されたコンテキスト・ルート (デフォルトでは /mfp) の中で宣言します。
* ランタイム WAR ファイルをアプリケーション・サーバーにデプロイします。
* データ・ソースおよび (WebSphere Application Server フル・プロファイルにおける) ランタイム用の JDBC プロバイダーを宣言します。
* アプリケーション・サーバーにデータベース・ドライバーがデプロイされます。
* JNDI 環境項目を使用して、{{site.data.keys.product_adj }} 構成プロパティーを設定します。
* オプションで、{{site.data.keys.product_adj }} JNDI 環境項目を設定して、ランタイム用にアプリケーション・サーバーをサーバー・ファーム・メンバーとして構成します。

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
**updatemobilefirstruntime** Ant タスクは、既にアプリケーション・サーバー上に構成されている {{site.data.keys.product_adj }} ランタイムを更新します。このタスクは、ランタイム WAR ファイルを更新します。このファイルは、以前にデプロイされたランタイム WAR ファイルと同じベース名を持つ必要があります。これを除き、このタスクはアプリケーション・サーバー構成 (Web アプリケーション構成、データ・ソース、および JNDI 環境項目) を変更しません。

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
**uninstallmobilefirstruntime** Ant タスクは、以前の **installmobilefirstruntime** 実行の結果を元に戻します。
このタスクの結果は以下のとおりです。

* 指定されたコンテキスト・ルートを持つ {{site.data.keys.product_adj }} Web アプリケーションの構成が削除されます。このタスクは、そのアプリケーションに手動で追加された設定も削除します。
* アプリケーション・サーバーからランタイム WAR ファイルを削除します。
* データ・ソースおよび (WebSphere Application Server フル・プロファイルにおける) ランタイム用の JDBC プロバイダーを削除します。
* 関連する JNDI 環境項目が削除されます。

### 属性およびエレメント
{: #attributes-and-elements-2 }
**installmobilefirstruntime**、**updatemobilefirstruntime**、および **uninstallmobilefirstruntime** の各 Ant タスクは以下の属性を持っています。

| 属性         | 説明                                                                 | 必要   | デフォルト                   | 
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       | アプリケーションの URL の共通接頭部 (コンテキスト・ルート)                | いいえ | /mfp  |
| id	            | さまざまなデプロイメントを区別する。                                       | いいえ | 空 |
| environmentId	    | さまざまな {{site.data.keys.product_adj }} 環境を区別する。                          | いいえ | 空 |
| warFile	        | {{site.data.keys.product_adj }} ランタイムの WAR ファイル。                                       | いいえ | mfp-server.war ファイルは、mfp-ant-deployer.jar file と同じディレクトリー内にあります。 |
| wasStartingWeight | WebSphere Application Server の開始順序。低い値から先に開始されます。 | いいえ | 2     |                           | 

#### contextroot および id
{: #contextroot-and-id-1 }
**contextroot** および **id** 属性は、さまざまな {{site.data.keys.product_adj }} プロジェクトを区別します。

WebSphere Application Server Liberty プロファイルおよび Tomcat の環境では、この目的には contextroot パラメーターで十分です。WebSphere Application Server フル・プロファイル環境では、id 属性が代わりに使用されます。

#### environmentId
{: #environmentid-1 }
**environmentId** 属性を使用して、独立して作動しなければならない、{{site.data.keys.mf_server }} 管理サービスおよび {{site.data.keys.product_adj }} ランタイム Web アプリケーションのそれぞれから構成される、複数の環境を区別します。管理サービス・アプリケーションの場合、
この属性には、<installmobilefirstadmin> 呼び出しで設定されたものと同じランタイム・アプリケーションの値を設定する必要があります。

#### warFile
{: #warfile-1 }
**warFile** 属性を使用して、{{site.data.keys.product_adj }} ランタイム WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

#### wasStartingWeight
{: #wasstartingweight-1 }
**wasStartingWeight** 属性を使用して、開始順序が順守されることを確実にするためのウェイトとして WebSphere Application Server で使用される値を指定します。この開始順序の値の結果、{{site.data.keys.mf_server }} 管理サービス Web アプリケーションは、他のどの {{site.data.keys.product_adj }} ランタイム・プロジェクトよりも前にデプロイされて開始されます。{{site.data.keys.product_adj }} プロジェクトが Web アプリケーションよりも前にデプロイまたは開始されると、JMX 通信は確立されず、{{site.data.keys.product_adj }} プロジェクトは管理できません。

**installmobilefirstruntime**、**updatemobilefirstruntime**、および **uninstallmobilefirstruntime** の各タスクでは、以下のエレメントがサポートされます。

| エレメント               | 説明                                      | カウント |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          | プロパティー。	                               | 0..   |
| `<applicationserver>` | アプリケーション・サーバー。                          | 1     |
| `<database>`          | データベース。                                   | 1     |
| `<analytics>`         | 分析。                                   | 0..1  |

`<property>` エレメントは、アプリケーション・サーバーに定義するデプロイメント・プロパティーを指定します。
これには、以下の属性があります。

| 属性 | 説明                | 必要 | デフォルト | 
|-----------|----------------------------|----------|---------|
| 名前      | プロパティーの名前。	 | はい      | なし    |
| value	    | プロパティーの値。| はい	    | なし    |  

`<applicationserver>` エレメントは、{{site.data.keys.product_adj }} アプリケーションのデプロイ先のアプリケーション・サーバーを記述します。これは、以下のエレメントの 1 つに対するコンテナーです。

| エレメント                                    | 説明                                      | カウント |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` または `<was>`  | WebSphere Application Server のパラメーター。	| 0..1  |
| `<tomcat>`                                 | Apache Tomcat のパラメーター。                | 0..1  |

`<websphereapplicationserver>` エレメント (短縮形では `<was>`) は、WebSphere Application Server インスタンスを示します。WebSphere Application Server フル・プロファイル (Base、および Network Deployment) がサポートされ、WebSphere Application Server Liberty Core および WebSphere Application Server Liberty Network Deployment もサポートされます。`<websphereapplicationserver>` エレメントには以下の属性があります。

| 属性       | 説明                                            | 必要                 | デフォルト | 
|-----------------|--------------------------------------------------------|--------------------------|---------|
| installdir      |	WebSphere Application Server インストール・ディレクトリー。   | はい                      | なし    |
| profile         |	WebSphere Application Server プロファイルまたは Liberty。      | はい	                  | なし    |
| user	WebSphere Application Server 管理者名。	               | はい (Liberty の場合を除く)  | なし    |
| password        | WebSphere Application Server 管理者パスワード。   | いいえ 対話式に照会 |         | 
| libertyEncoding |	WebSphere Application Server Liberty のデータ・ソース・パスワードをエンコードするアルゴリズム。指定可能な値は none、xor、および aes です。xor エンコードが使用されているか aes エンコードが使用されているかに関係なく、外部プロセスによって呼び出される securityUtility プログラムにクリア・パスワードが引数として渡されます。このパスワードは ps コマンドにより確認できます。また、UNIX オペレーティング・システム上では /proc ファイル・システム内で確認できます。                                                         | いいえ                       |	xor     |
| jeeVersion      |	Liberty プロファイル用。JEE6 Web プロファイルまたは JEE7 Web プロファイルのフィーチャーをインストールするかどうかを指定する。指定可能な値は、6、7、または auto。| いいえ | auto |
| configureFarm   |	WebSphere Application Server Liberty および WebSphere Application Server フル・プロファイル用 (WebSphere Application Server Network Deployment エディションおよび Liberty 集合用ではない)。サーバーがサーバー・ファーム・メンバーかどうかを指定します。指定可能な値は true または false です。 | いいえ	      | false   |
| farmServerId    |	サーバー・ファーム内でサーバーを一意的に識別するストリング。そのサーバーと通信する {{site.data.keys.mf_server }} 管理サービスおよびすべての {{site.data.keys.product_adj }} ランタイムは、同じ値を共有する必要があります。                                                                | はい                      |	なし    |

シングル・サーバー・デプロイメントの場合、以下のエレメントがサポートされます。

| エレメント     | 説明      | カウント |
|-------------|------------------|-------|
| `<server>`  | シングル・サーバー。 | 0..1  |

このコンテキストで使用される <server> エレメントには以下の属性があります。

| 属性 | 説明      | 必要 | デフォルト | 
|-----------|------------------|----------|---------|
| 名前	    | サーバー名。 | はい      | なし    |

Liberty 集合の場合、以下のエレメントがサポートされます。

| エレメント               | 説明                  | カウント |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  | Liberty 集合メンバー。 | 0..1  |

`<collectiveMember>` エレメントには以下の属性があります。

| 属性               | 説明      | 必要 | デフォルト | 
|-------------------------|------------------|----------|---------|
| serverName              |	集合メンバーの名前。                       | はい | なし | 
| clusterName             |	集合メンバーが所属しているクラスター名。  | はい | なし | 
| serverId                |	集合メンバーを一意的に識別するストリング。 | はい | なし | 
| controllerHost          |	集合コントローラーの名前。                   | はい | なし | 
| controllerHttpsPort     |	集合コントローラーの HTTPS ポート。             | はい | なし | 
| controllerAdminName     |	集合コントローラーに定義された管理ユーザー名。 これは、新規メンバーを集合に参加させるために使用されるのと同じユーザーです。 | はい | なし | 
| controllerAdminPassword |	管理ユーザー・パスワード。	                     | はい | なし | 
| createControllerAdmin   |	集合メンバーの基本レジストリー内に管理ユーザーが作成される必要があるかどうかを示す。指定可能な値は true または false です。 | いいえ | true |

Network Deployment の場合、以下のエレメントがサポートされます。

| エレメント     | 説明                                   | カウント |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	セル全体。	                          | 0..1  |
| `<cluster>` |	クラスターのすべてのサーバー。                 |	0..1  |
| `<node>`    |	ノード内のすべてのサーバー (クラスターを除く)。 | 0..1  |
| `<server>`  |	シングル・サーバー。	                          | 0..1  |

`<cell>` エレメントには属性はありません。

`<cluster>` エレメントには以下の属性があります。

| 属性 | 説明       | 必要 | デフォルト | 
|-----------|-------------------|----------|---------|
| 名前      | クラスター名。 | はい	   | なし    |

`<node>` エレメントには以下の属性があります。

| 属性 | 説明    | 必要 | デフォルト | 
|-----------|----------------|----------|---------|
| 名前      | ノード名。 | はい	    | なし    |

Network Deployment コンテキストで使用される `<server>` エレメントには以下の属性があります。

| 属性  | 説明      | 必要 | デフォルト | 
|------------|------------------|----------|---------|
| nodeName   | ノード名。   | はい	   | なし    |
| serverName | サーバー名。 | はい      | なし    |

`<tomcat>` エレメントは Apache
Tomcat サーバーを示します。これには、以下の属性があります。

| 属性     | 説明      | 必要 | デフォルト | 
|---------------|------------------|----------|---------|
| installdir    | Apache Tomcat のインストール・ディレクトリー。CATALINA_HOME ディレクトリーと CATALINA_BASE ディレクトリーに分割されている Tomcat のインストール済み環境の場合、CATALINA_BASE 環境変数の値を指定します。     | はい | なし    | 
| configureFarm | サーバーがサーバー・ファーム・メンバーかどうかを指定します。指定可能な値は true または false です。	| いいえ | false |
| farmServerId	| サーバー・ファーム内でサーバーを一意的に識別するストリング。そのサーバーと通信する {{site.data.keys.mf_server }} 管理サービスおよびすべての {{site.data.keys.product_adj }} ランタイムは、同じ値を共有する必要があります。 | はい | なし |

`<database>` エレメントは、特定のデータベースにアクセスするために必要な情報を指定します。`<database>` エレメントは、configuredatabase Ant タスクと同じように指定されますが、`<dba>` エレメントと `<client>` エレメントがない点は異なります。ただし、`<property>` エレメントを含めることはできます。`<database>` エレメントには以下の属性があります。

| 属性 | 説明                                | 必要 | デフォルト | 
|-----------|--------------------------------------------|----------|---------|
| kind      | データベースの種類 ({{site.data.keys.product_adj }} ランタイム)。 | はい | なし |
| validate  | データベースがアクセス可能かどうかを検証します。指定可能な値は true または false です。 | いいえ | true |

`<database>` エレメントは以下のエレメントをサポートします。

| エレメント             | 説明	                | カウント | 
|---------------------|-----------------------------|-------|
| `<derby>`           | Derby のパラメーター。   | 0..1  | 
| `<db2>`             |	DB2 のパラメーター。     | 0..1  | 
| `<mysql>`           |	MySQL のパラメーター。   | 0..1  | 
| `<oracle>`          |	Oracle のパラメーター。  | 0..1  | 
| `<driverclasspath>` | JDBC ドライバーのクラスパス。 | 0..1  | 

`<analytics>` エレメントは、既にインストールされている {{site.data.keys.mf_analytics_console }} およびサービスに {{site.data.keys.product_adj }} ランタイムを接続することを指示します。これには、以下の属性があります。

| 属性    | 説明                                                                      | 必要 | デフォルト | 
|--------------|----------------------------------------------------------------------------------|----------|---------|
| install      | {{site.data.keys.product_adj }} ランタイムを {{site.data.keys.mf_analytics }} に接続するかどうかを示す。 | いいえ       | false   |
| analyticsURL | {{site.data.keys.mf_analytics }} サービスの URL。	                                      | はい      | なし    |
| consoleURL   | {{site.data.keys.mf_analytics_console }} の URL。	                                      | はい      | なし    |
| username     | ユーザー名。	                                                                  | はい      | なし    |
| password     | パスワード。	                                                                  | はい      | なし    |
| validate     | {{site.data.keys.mf_analytics_console }} がアクセス可能かどうかを検証します。	      | いいえ	     | true    |
| tenant       | {{site.data.keys.product_adj }} ランタイムから収集されたデータを索引付けするためのテナント。	      | いいえ       | 内部 ID |

#### install
{: #install-1 }
**install** 属性は、この {{site.data.keys.product_adj }} ランタイムが接続され、イベントを {{site.data.keys.mf_analytics }} に送信する必要があることを指示するために使用します。
有効な値は **true** または **false** です。

#### analyticsURL
{: #analyticsurl-1 }
**analyticsURL** 属性は、着信分析データを受信する {{site.data.keys.mf_analytics }} によって公開される URL を指定するために使用します。  
例えば、`http://<hostname>:<port>/analytics-service/rest` などです。

#### consoleURL
{: #consoleurl }
**consoleURL** 属性は、{{site.data.keys.mf_analytics_console }}にリンクされる {{site.data.keys.mf_analytics }} によって公開される URL を指定するために使用します。  
例えば、`http://<hostname>:<port>/analytics/console` などです。

#### username
{: #username-1 }
**username** 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名を指定するために使用します。

#### password
{: #password-1 }
**password** 属性は、{{site.data.keys.mf_analytics }} のデータ・エントリー・ポイントが基本認証で保護されている場合に使用されるパスワードを指定するために使用します。

#### validate
{: #validate-1 }
**validate** 属性は、{{site.data.keys.mf_analytics_console }}にアクセス可能かどうかを検証するため、およびパスワードでのユーザー名認証を検査するために使用します。指定可能な値は **true** または **false** です。

#### tenant
{: #tenant }
この属性について詳しくは、[構成プロパティー](../analytics/configuration/#configuration-properties)を参照してください。

### Apache Derby データベースを指定するには
{: #to-specify-an-apache-derby-database }
`<derby>` エレメントには以下の属性があります。 

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| データベース	 | データベース名。	                      | いいえ       |	種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。 |
| datadir	 | データベースを含むディレクトリー。 |	はい	     | なし    |
| schema     |	スキーマ名。                          |	いいえ	     | 種類に応じて、MFPDATA、MFPCFG、MFPADMINISTRATOR、MFPPUSH、または APPCENTER。 |

`<derby>` エレメントは以下のエレメントをサポートします。

| エレメント       | 説明	                | カウント | 
|---------------|-------------------------------|-------|
| `<property>`  | データ・ソース・プロパティーまたは JDBC 接続プロパティー。	| 0.. |

使用可能なプロパティーについて詳しくは、Class [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html) の資料を参照してください。また、[Class EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html) の資料も参照してください。

Liberty サーバーで使用可能なプロパティーについて詳しくは、`properties.derby.embedded` の資料 ([Liberty プロファイル: server.xml ファイルの構成エレメント](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)) を参照してください。

**mfp-ant-deployer.jar** ファイルが {{site.data.keys.product }} のインストール・ディレクトリー内で使用されている場合には、`<driverclasspath>` エレメントは不要です。

### DB2 データベースを指定するには
{: #to-specify-a-db2-database }
`<db2>` エレメントには以下の属性があります。

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| データベース   | データベース名。 | いいえ	種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。 | 
| サーバー     | データベース・サーバーのホスト名。      | はい	     | なし    | 
| port       | データベース・サーバーのポート。           | いいえ	     | 50000   | 
| user       | データベースにアクセスするユーザー名。     | このユーザーに、データベースに対する拡張特権は必要ありません。データベースに制限を実装する場合は、『データベースのユーザーおよび特権』にリストされている、制限された特権を持つユーザーを設定できます。                                 | はい | なし | 
| password   | データベースにアクセスするパスワード。      | いいえ       | 対話式に照会 | 
| schema     | スキーマ名。                           | いいえ       | ユーザーに応じて異なる | 

DB2 ユーザー・アカウントについて詳しくは、[DB2 のセキュリティー・モデルの概要](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)を参照してください。  
`<db2>` エレメントは以下のエレメントをサポートします。

| エレメント       | 説明	                | カウント | 
|---------------|-------------------------------|-------|
| `<property>`  | データ・ソース・プロパティーまたは JDBC 接続プロパティー。	| 0.. |

使用可能なプロパティーについて詳しくは、[IBM Data Server Driver for JDBC and SQLJ のプロパティー](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)を参照してください。

Liberty サーバーで使用可能なプロパティーについて詳しくは、[Liberty プロファイル: server.xml ファイルの構成エレメント](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)の『**properties.db2.jcc**』セクションを参照してください。

`<driverclasspath>` エレメントは、DB2 JDBC ドライバーおよび関連するライセンス用の JAR ファイルを含んでいる必要があります。DB2 JDBC ドライバーは、[DB2 JDBC Driver Versions and Downloads](http://www.ibm.com/support/docview.wss?uid=swg21363866) からダウンロードできます。

### MySQL データベースを指定するには
{: #to-specify-a-mysql-database }
`<mysql>` エレメントには以下の属性があります。

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| データベース	 | データベース名。	                      | いいえ       | 種類に応じて、MFPDATA、MFPADM、MFPCFG、MFPPUSH、または APPCNTR。 | 
| サーバー	 | データベース・サーバーのホスト名。	  | はい      | なし    |
| port	     | データベース・サーバーのポート。           | いいえ	     | 3306    |
| user	     | データベースにアクセスするユーザー名。このユーザーに、データベースに対する拡張特権は必要ありません。データベースに制限を実装する場合は、『データベースのユーザーおよび特権』にリストされている、制限された特権を持つユーザーを設定できます。 | はい | なし |
| password	 | データベースにアクセスするパスワード。	  | いいえ	     | 対話式に照会 |

**database**、**server**、および **port** の代わりに、URL を指定することもできます。この場合、以下の属性を使用します。 

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| url	     | データベースへの接続の URL。	  | はい	     | なし    |
| user	     | データベースにアクセスするユーザー名。このユーザーに、データベースに対する拡張特権は必要ありません。データベースに制限を実装する場合は、データベースのユーザーおよび特権にリストされている、制限された特権を持つユーザーを設定できます。 | はい  | なし |
| password	 | データベースにアクセスするパスワード。	  | いいえ       | 対話式に照会 |

MySQL ユーザー・アカウントについて詳しくは、[MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html) を参照してください。

`<mysql>` エレメントは以下のエレメントをサポートします。

| エレメント       | 説明	                | カウント | 
|---------------|-------------------------------|-------|
| `<property>`  | データ・ソース・プロパティーまたは JDBC 接続プロパティー。	| 0.. |

使用可能なプロパティーについて詳しくは、[Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html) の資料を参照してください。

Liberty サーバーで使用可能なプロパティーについて詳しくは、[Liberty プロファイル: server.xml ファイル](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)の構成エレメントの『properties』セクションを参照してください。

`<driverclasspath>` エレメントには、MySQL Connector/J JAR ファイルが含まれている必要があります。これは、[Download Connector/J](http://www.mysql.com/downloads/connector/j/) からダウンロードできます。

### Oracle データベースを指定するには
{: #to-specify-an-oracle-database }
`<oracle>` エレメントには以下の属性があります。

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| データベース   | データベース名、または Oracle サービス名。注: PDB データベースに接続するには、常にサービス名を使う必要があります。 | いいえ | ORCL |
| サーバー	 | データベース・サーバーのホスト名。はい	なし
| port	     | データベース・サーバーのポート。いいえ	1521
| user	     | データベースにアクセスするユーザー名。このユーザーに、データベースに対する拡張特権は必要ありません。データベースに制限を実装する場合は、データベースのユーザーおよび特権にリストされている、制限された特権を持つユーザーを設定できます。この表の下の注を参照してください。 | はい | なし |
| password	 | データベースにアクセスするパスワード。	  | いいえ       | 対話式に照会 |

> **注:** **user** 属性については、大文字のユーザー名を使用することをお勧めします。Oracle のユーザー名は、一般的に大文字で表されます。他のデータベース・ツールとは異なり、**installmobilefirstruntime** Ant タスクは、ユーザー名に含まれる小文字を大文字に変換しません。**installmobilefirstruntime** Ant タスクがデータベースへの接続に失敗した場合には、**user** 属性の値を大文字で入力してみてください。

**database**、**server**、および **port** の代わりに、URL を指定することもできます。この場合、以下の属性を使用します。


| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| url	     | データベースへの接続の URL。	  | はい      | なし    |
| user	     | データベースにアクセスするユーザー名。このユーザーに、データベースに対する拡張特権は必要ありません。データベースに制限を実装する場合は、データベースのユーザーおよび特権にリストされている、制限された特権を持つユーザーを設定できます。この表の下の注を参照してください。 | はい | なし |
| password	 | データベースにアクセスするパスワード。	  | いいえ	     | 対話式に照会 |

> **注:** **user** 属性については、大文字のユーザー名を使用することをお勧めします。Oracle のユーザー名は、一般的に大文字で表されます。他のデータベース・ツールとは異なり、**installmobilefirstruntime** Ant タスクは、ユーザー名に含まれる小文字を大文字に変換しません。**installmobilefirstruntime** Ant タスクがデータベースへの接続に失敗した場合には、**user** 属性の値を大文字で入力してみてください。Oracle ユーザー・アカウントについて詳しくは、[Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374) を参照してください。

Oracle データベースの接続 URL について詳しくは、[Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm) の『**Database
URLs and Database Specifiers**』セクションを参照してください。

以下のエレメントがサポートされます。

| エレメント       | 説明	                | カウント | 
|---------------|-------------------------------|-------|
| `<property>`  | データ・ソース・プロパティーまたは JDBC 接続プロパティー。	| 0.. |

使用可能なプロパティーについて詳しくは、[Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm) の『**Data Sources and URLs**』セクションを参照してください。

Liberty サーバーで使用可能なプロパティーについて詳しくは、[Liberty プロファイル: server.xml ファイルの構成エレメント](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)の『**properties.oracle**』セクションを参照してください。

`<driverclasspath>` エレメントには、Oracle JDBC ドライバーの JAR ファイルが含まれている必要があります。Oracle JDBC ドライバーは、[JDBC and Universal Connection Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) からダウンロードできます。

`<property>` エレメント (`<derby>`、`<db2>`、` <mysql>`、および `<oracle>` の各エレメントの内部で使用可能) には、以下の属性があります。

| 属性  | 説明                                | 必要 | デフォルト | 
|------------|--------------------------------------------|----------|---------|
| 名前       | プロパティーの名前。	              | はい      | なし    |
| type	     | プロパティーの値の Java タイプ (通常は java.lang.String/Integer/Boolean)。 | いいえ | java.lang.String |
| value	     | プロパティーの値。	              | はい      |  なし   |

## Application Center のインストール用の Ant タスク
{: #ant-tasks-for-installation-of-application-center }
Application Center Console および Services のインストールに関して、`<installApplicationCenter>`、`<updateApplicationCenter>`、および `<uninstallApplicationCenter>` の各 Ant タスクが用意されています。

### タスクの結果
{: #task-effects-3 }
### <installApplicationCenter>
{: #installapplicationcenter }
`<installApplicationCenter>` タスクは、Application Center Services の WAR ファイルを Web アプリケーションとして実行し、Application Center コンソールをインストールするようにアプリケーション・サーバーを構成します。このタスクは以下のような結果をもたらします。

* /applicationcenter コンテキスト・ルートで Application Center  Services の Web アプリケーションを宣言します。
* データ・ソースを宣言します。また、WebSphere Application Server フル・プロファイルでは、Application Center Services の JDBC プロバイダーも宣言します。
* アプリケーション・サーバーで Application Center Services の Web アプリケーションをデプロイします。
* /appcenterconsole コンテキスト・ルートで Web アプリケーションとして Application Center コンソールを宣言します。
* Application Center Console WAR ファイルをアプリケーション・サーバーにデプロイします。
* JNDI 環境項目を使用して Application Center Services の構成プロパティーを構成します。エンドポイントおよびプロキシーに関連した JNDI 環境項目はコメント化されます。場合によっては、ユーザーがコメントを外す必要があります。
* Application Center コンソールおよびサービス Web アプリケーションによって使用されるロールにマップするユーザーを構成します。
* WebSphere Application Server 上に、Web コンテナー用の必要なカスタム・プロパティーを構成します。

#### <updateApplicationCenter>
{: #updateApplicationCenter }
`<updateApplicationCenter>` タスクは、アプリケーション・サーバー上の構成済み Application Center アプリケーションを更新します。このタスクは以下のような結果をもたらします。

* Application Center Services の WAR ファイルを更新します。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。
* Application Center コンソールの WAR ファイルを更新します。このファイルは、以前にデプロイされた、対応する WAR ファイルと同じベース名を持っている必要があります。 

このタスクは、アプリケーション・サーバー構成を変更しません。つまり、Web アプリケーション構成、データ・ソース、JNDI 環境項目、およびユーザーとロールのマッピングは変更されません。このタスクは、このトピックで説明している <installApplicationCenter> タスクを使用して実行されるインストールにのみ適用されます。

> **注:** WebSphere Application Server Liberty プロファイルでは、このタスクはフィーチャーを変更しません。そのため、インストール済みアプリケーションの server.xml ファイルに含まれるフィーチャーのリストは最小限のものではない可能性がありますが、このタスクの実行後も、そのリストがそのまま残ります。

#### <uninstallApplicationCenter>
{: #uninstallApplicationCenter }
`<uninstallApplicationCenter>` Ant タスクは、`<installApplicationCenter>` の以前の実行の結果を元に戻します。このタスクは以下のような結果をもたらします。

* **/applicationcenter** コンテキスト・ルートを持つ Application Center サービス Web アプリケーションの構成を削除します。その結果、このタスクは、そのアプリケーションに手動で追加された設定も削除します。
* Application Center サービスとコンソールの両方の WAR ファイルをアプリケーション・サーバーから削除します。
* データ・ソースを削除します。WebSphere Application Server フル・プロファイルでは、Application Center サービスの JDBC プロバイダーも削除します。
* Application Center Services によって使用されたデータベース・ドライバーをアプリケーション・サーバーから削除します。
* 関連する JNDI 環境項目が削除されます。
* `<installApplicationCenter>` 呼び出しで構成されたユーザーを削除します。

### 属性およびエレメント
{: #attributes-and-elements-3 }
`<installApplicationCenter>`、`<updateApplicationCenter>`、および `<uninstallApplicationCenter>` の各タスクには、以下の属性があります。

| 属性    | 説明                                | 必要 | デフォルト | 
|--------------|--------------------------------------------|----------|---------|
| id	       | WebSphere Application Server フル・プロファイルの異なるデプロイメントを識別します。	| いいえ | 空 |
| servicewar   | Application Center Services の WAR ファイル。 | いいえ | applicationcenter.war ファイルは、アプリケーション・センター・コンソール・ディレクトリー (**product_install_dir/ApplicationCenter/console**) 内にあります。 |
| shortcutsDir | ショートカットを配置するディレクトリー。 | いいえ | なし |
| aaptDir | Android SDK platform-tools パッケージの aapt プログラムが含まれているディレクトリー。 | いいえ | なし |

#### id
{: #id-1 }
WebSphere Application Server フル・プロファイル環境では、**id** 属性は、Application Center コンソールおよびサービスの異なるデプロイメントを識別するために使用されます。この **id** 属性がないと、同じコンテキスト・ルートを持つ 2 つの WAR ファイルが競合し、これらのファイルがデプロイされない可能性があります。

#### servicewar
{: #servicewar-1 }
**servicewar** 属性を使用して、Application Center Services の WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

#### shortcutsDir
{: #shortcutsdir-1 }
**shortcutsDir** 属性は、Application Center コンソールのショートカットを配置する場所を指定します。この属性を設定した場合、以下のファイルがこのディレクトリーに追加されます。

* **appcenter-console.url**: このファイルは、Windows のショートカットです。これは、Application Center コンソールをブラウザーで開きます。
* **appcenter-console.sh**: このファイルは UNIX シェル・スクリプトです。これは、Application Center コンソールをブラウザーで開きます。

#### aaptDir
{: #aaptdir }
**aapt** プログラムは、{{site.data.keys.product }} ディストリビューション (**product_install_dir/ApplicationCenter/tools/android-sdk**) の一部です。  
この属性が設定されていない場合、apk アプリケーションのアップロード時に、Application Center は独自のコードを使用してこれを解析しますが、限界がある場合があります。

`<installApplicationCenter>`、`<updateApplicationCenter>`、および `<uninstallApplicationCenter>` の各タスクは、以下のエレメントをサポートします。

| エレメント           | 説明	                            | カウント | 
|-------------------|-------------------------------------------|-------|
| applicationserver	| アプリケーション・サーバー。                   | 1     |
| コンソール           | Application Center コンソール。	        | 1     |
| データベース          | データベース。	                        | 1     | 
| user	            | セキュリティー・ロールにマップされるユーザー。 | 0..∞  |

### Application Center コンソールを指定するには
{: #to-specify-an-application-center-console }
`<console>` エレメントは、Application Center コンソールのインストールをカスタマイズするための情報を収集します。このエレメントには以下の属性があります。

| 属性    | 説明                                      | 必要 | デフォルト | 
|--------------|--------------------------------------------------|----------|---------|
| warfile      | Application Center コンソールの WAR ファイル。 |	いいえ       | appcenterconsole.war ファイルは、Application Center コンソール・ディレクトリー (**product_install_dir/ApplicationCenter/console**) 内にあります。 |

### アプリケーション・サーバーを指定するには
{: #to-specify-an-application-server-3 }
`<applicationserver>` エレメントを使用して、基礎となるアプリケーション・サーバーに依存するパラメーターを定義します。`<applicationserver>` エレメントは以下のエレメントをサポートしています。

| エレメント           | 説明	                            | カウント | 
|-------------------|-------------------------------------------|-------|
| **websphereapplicationserver** または **was**	| WebSphere Application Server のパラメーター。`<websphereapplicationserver>` エレメント (短縮形では `<was>`) は、WebSphere Application Server インスタンスを示します。WebSphere Application Server フル・プロファイル (Base、および Network Deployment) がサポートされ、WebSphere Application Server Liberty Core もサポートされます。Application Center には Liberty 集合はサポートされません。 | 0..1 | 
| tomcat            | Apache Tomcat のパラメーター。 | 0..1 |

これらのエレメントの属性および内部エレメントについては、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) ページの表に説明があります。

### サービス・データベースへの接続を指定するには
{: #to-specify-a-connection-to-the-services-database }
`<database>` エレメントは、サービス・データベースにアクセスするためのアプリケーション・サーバー内のデータ・ソース宣言を指定するパラメーターを収集します。

次のように単一のデータベースを宣言する必要があります。`<database kind="ApplicationCenter">`. `<database>` エレメントは、`<configuredatabase>` Ant タスクと同様に指定します。ただし、`<database>` エレメントには `<dba>` エレメントと`<client>` エレメントはありません。`<property>` エレメントは含まれる場合があります。

`<database>` エレメントには以下の属性があります。

| 属性    | 説明                                            | 必要 | デフォルト | 
|--------------|--------------------------------------------------------|----------|---------|
| kind         | データベースの種類 (ApplicationCenter)。              | はい      | なし    |
| validate	   | データベースがアクセス可能かどうかを検証します。 | いいえ       | True    |

`<database>` エレメントは以下のエレメントをサポートしています。これらのデータベース・エレメントの構成について詳しくは、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)の表を参照してください。

| エレメント           | 説明	                            | カウント | 
|-------------------|-------------------------------------------|-------|
| db2	            | DB2 データベースのパラメーター。	        | 0..1  |
| derby             | Apache Derby データベースのパラメーター。	| 0..1  |
| mysql             | MySQL データベースのパラメーター。	    | 0..1  |
| oracle	        | Oracle データベースのパラメーター。	    | 0..1  |
| driverclasspath   | JDBC ドライバー・クラスパスのパラメーター。	| 0..1  |

### ユーザーおよびセキュリティー・ロールを指定するには
{: #to-specify-a-user-and-a-security-role }
`<user>` エレメントは、アプリケーションの特定のセキュリティー・ロールに含める、ユーザーに関するパラメーターを収集します。

| 属性    | 説明                                            | 必要 | デフォルト | 
|--------------|--------------------------------------------------------|----------|---------|
| role         | ユーザー・ロール appcenteradmin。 | はい | なし |
| 名前	       | ユーザー名。 | はい | なし |
| password	   | パスワード (ユーザーを作成する必要がある場合)。	| いいえ | なし |

## {{site.data.keys.mf_analytics }} のインストール用の Ant タスク
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
**installanalytics**、**updateanalytics**、および **uninstallanalytics** の各 Ant タスクが、{{site.data.keys.mf_analytics }} のインストール用に用意されています。

これらの Ant タスクの目的は、アプリケーション・サーバーでのデータの適切なストレージを使用して、{{site.data.keys.mf_analytics_console }}および {{site.data.keys.mf_analytics }} サービスを構成することです。タスクは、マスターおよびデータとして機能する {{site.data.keys.mf_analytics }} ノードをインストールします。詳しくは、[クラスター管理および Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch) を参照してください。

### タスクの結果
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
**installanalytics** Ant タスクは、IBM {{site.data.keys.mf_analytics }} を実行するようアプリケーション・サーバーを構成します。このタスクは以下のような結果をもたらします。

* アプリケーション・サーバーで {{site.data.keys.mf_analytics }} サービスおよび {{site.data.keys.mf_analytics_console }}の WAR ファイルをデプロイします。
* 指定コンテキスト・ルート /analytics-service で {{site.data.keys.mf_analytics }} サービスの Web アプリケーションを宣言します。
* 指定コンテキスト・ルート /analytics で {{site.data.keys.mf_analytics_console }}の Web アプリケーションを宣言します。
* JNDI 環境項目を使用して {{site.data.keys.mf_analytics_console }}および {{site.data.keys.mf_analytics }} サービスの構成プロパティーを設定します。
* WebSphere Application Server Liberty プロファイルでは、Web コンテナーを構成します。
* オプションとして、{{site.data.keys.mf_analytics_console }}を使用するユーザーを作成します。

#### updateanalytics
{: #updateanalytics }
**updateanalytics** Ant タスクは、アプリケーション・サーバーで既に構成されている {{site.data.keys.mf_analytics }} サービスおよび {{site.data.keys.mf_analytics_console }}の Web アプリケーションの WAR ファイルを更新します。これらのファイルのベース名は、以前にデプロイされたプロジェクト WAR ファイルと同じでなければなりません。

このタスクは、アプリケーション・サーバー構成、すなわち Web アプリケーション構成および JNDI 環境項目を変更しません。

#### uninstallanalytics
{: #uninstallanalytics }
**uninstallanalytics** Ant タスクは、以前の **installanalytics** 実行の結果を元に戻します。
このタスクは以下のような結果をもたらします。

* {{site.data.keys.mf_analytics }} サービスと {{site.data.keys.mf_analytics_console }}の両 Web アプリケーションを、それぞれのコンテキスト・ルートと共に削除します。
* アプリケーション・サーバーから {{site.data.keys.mf_analytics }} サービスおよび {{site.data.keys.mf_analytics_console }}の WAR ファイルを削除します。
* 関連する JNDI 環境項目が削除されます。

### 属性およびエレメント
{: #attributes-and-elements-4 }
**installanalytics**、**updateanalytics**、および **uninstallanalytics** の各タスクには、以下の属性があります。

| 属性    | 説明                                            | 必要 | デフォルト | 
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   | {{site.data.keys.mf_analytics }} サービスの WAR ファイル     | いいえ       | analytics-service.war ファイルはディレクトリー Analytics 内にあります。 |

#### serviceWar
{: #servicewar-2 }
**serviceWar** 属性を使用して、{{site.data.keys.mf_analytics }} サービスの WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

`<installanalytics>`、`<updateanalytics>`、および `<uninstallanalytics>` の各タスクでは、以下のエレメントがサポートされます。

| 属性         | 説明                               | 必要 | デフォルト | 
|-------------------|-------------------------------------------|----------|---------|
| コンソール	        | {{site.data.keys.mf_analytics }}   	                | はい	   | 1       |
| user	            | セキュリティー・ロールにマップされるユーザー。	| いいえ	   | 0..     |
| storage	        | ストレージのタイプ。	                    | はい 	   | 1       |
| applicationserver	| アプリケーション・サーバー。	                | はい	   | 1       |
| property          | プロパティー。	                            | いいえ 	   | 0..     |

### {{site.data.keys.mf_analytics_console }} を指定するには
{: #to-specify-a-mobilefirst-analytics-console }
`<console>` エレメントは、{{site.data.keys.mf_analytics_console }} のインストールをカスタマイズするための情報を収集します。このエレメントには以下の属性があります。

| 属性    | 説明                                  | 必要 | デフォルト | 
|--------------|----------------------------------------------|----------|---------|
| warfile	   | コンソール WAR ファイル	                      | いいえ	     | analytics-ui.war ファイルは、Analytics ディレクトリー内にあります。 |
| shortcutsdir | ショートカットを配置するディレクトリー。 | いいえ	     | なし    |

#### warFile
{: #warfile-2 }
**warFile** 属性を使用して、{{site.data.keys.mf_analytics_console }}の WAR ファイル用に異なるディレクトリーを指定します。この WAR ファイルの名前は、絶対パスまたは相対パスを使用して指定できます。

#### shortcutsDir
{: #shortcutsdir-2 }
**shortcutsDir** 属性は、{{site.data.keys.mf_analytics_console }} のショートカットを配置する場所を指定します。この属性を設定した場合、そのディレクトリーに以下のファイルを追加できます。

* **analytics-console.url**: このファイルは、Windows のショートカットです。これは、{{site.data.keys.mf_analytics_console }} をブラウザーで開きます。
* **analytics-console.sh**: このファイルは UNIX シェル・スクリプトです。これは、{{site.data.keys.mf_analytics_console }} をブラウザーで開きます。

> 注: これらのショートカットには、ElasticSearch テナント・パラメーターは含まれません。

`<console>` エレメントでは、以下のネスト・エレメントがサポートされます。

| エレメント  | 説明	| カウント | 
|----------|----------------|-------|
| property | プロパティー	    | 0..   |

このエレメントでは、独自の JNDI プロパティーを定義できます。

`<property>` エレメントには以下の属性があります。

| 属性  | 説明                | 必要 | デフォルト | 
|------------|----------------------------|----------|---------|
| 名前       | プロパティーの名前。  | はい      | なし    | 
| value	     | プロパティーの値。 |	はい      | なし    |

### ユーザーおよびセキュリティー・ロールを指定するには
{: #to-specify-a-user-and-a-security-role-1 }
`<user>` エレメントは、アプリケーションの特定のセキュリティー・ロールに含める、ユーザーに関するパラメーターを収集します。

| 属性   | 説明                                   | 必要 | デフォルト | 
|-------------|-----------------------------------------------|----------|---------|
| role	      | アプリケーションの有効なセキュリティー・ロール。    | はい      | なし    |
| 名前	      | ユーザー名。	                              | はい      | なし    |
| password	  | ユーザーを作成する必要がある場合のパスワード。 | いいえ       | なし    |

` <user>` エレメントを使用してユーザーを定義した後、それらのユーザーを、{{site.data.keys.mf_console }} 内の以下の認証用のロールにマップすることができます。

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### {{site.data.keys.mf_analytics }} のストレージのタイプを指定するには
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
`<storage>` エレメントは、{{site.data.keys.mf_analytics }} が収集した情報およびデータを保管するために使用する基盤ストレージ・タイプを指定します。

以下のエレメントがサポートされます。

| エレメント       | 説明	| カウント   | 
|---------------|---------------|---------|
| Elasticsearch	| ElasticSearch | クラスター (cluster) |

`<elasticsearch>` エレメントは、ElasticSearch クラスターに関するパラメーターを収集します。

| 属性        | 説明                                   | 必要 | デフォルト   | 
|------------------|-----------------------------------------------|----------|-----------|
| clusterName	   | ElasticSearch クラスター名。	           | いいえ       | worklight | 
| nodeName	       | ElasticSearch ノード名。この名前は、ElasticSearch クラスター内で固有でなければなりません。	| いいえ | `worklightNode_<random number>` |
| mastersList	   | ElasticSearch クラスター内の ElasticSearch マスター・ノードのホスト名とポートが含まれたコンマ区切りのストリング (例: hostname1:transport-port1,hostname2:transport-port2) 	           | いいえ       |	トポロジーに応じて異なる |
| dataPath	       | ElasticSearch クラスターの場所。	       | いいえ	      | アプリケーション・サーバーに応じて異なる |
| shards	       | ElasticSearch クラスターで作成されるシャードの数。この値は、ElasticSearch クラスターで作成されたマスター・ノードによってのみ設定できます。	| いいえ | 5 |
| replicasPerShard | ElasticSearch クラスターのシャードごとのレプリカの数。この値は、ElasticSearch クラスターで作成されたマスター・ノードによってのみ設定できます。 | いいえ | 1 |
| transportPort	   | ElasticSearch クラスターでのノード間通信に使用するポート。	| いいえ | 9600 | 

#### clusterName
{: #clustername }
**clusterName** 属性は、ElasticSearch クラスターの任意の名前を指定するために使用します。

ElasticSearch クラスターは、同じクラスター名を共有する 1 つ以上のノードで構成されるため、複数のノードを構成する場合は **clusterName** 属性に同じ値を指定することができます。

#### nodeName
{: #nodename }
**nodeName** 属性は、ElasticSearch クラスターで構成するノードの任意の名前を指定するために使用します。各ノード名は、ノードが複数のマシンにまたがっている場合でも、ElasticSearch クラスター内で固有でなければなりません。

#### mastersList
{: #masterslist }
**mastersList** 属性は、ElasticSearch クラスター内のマスター・ノードのコンマ区切りリストを指定するために使用します。このリスト内の各マスター・ノードは、そのホスト名と ElasticSearch ノード間通信ポートで識別する必要があります。このポートは、9600 (デフォルト)、または当該マスター・ノードの構成時に属性 **transportPort** で指定したポート番号です。

例: `hostname1:transport-port1、hostname2:transport-port2`

**注:
**

* デフォルト値の 9600 以外の **transportPort** を指定した場合、属性 **transportPort** にもその値を設定する必要があります。デフォルトでは、属性 **mastersList** を省略した場合、サポートされるすべてのアプリケーション・サーバーでホスト名と ElasticSearch トランスポート・ポートを検出する試行が行われます。
* ターゲット・アプリケーション・サーバーが WebSphere Application Server Network Deployment クラスターであり、かつ後からそのクラスターでサーバーを追加または削除した場合、このリストを手動で編集して ElasticSearch クラスターと同期された状態にする必要があります。

#### dataPath
{: #datapath }
**dataPath** 属性は、ElasticsSearch データを保管するために異なるディレクトリーを指定する場合に使用します。絶対パスまたは相対パスを指定できます。

属性 **dataPath** を指定しなかった場合、ElasticSearch クラスター・データは、**analyticsData** というデフォルト・ディレクトリーに保管されます。この場所は、以下のように、アプリケーション・サーバーによって異なります。

* WebSphere Application Server Liberty プロファイルの場合、この場所は `${wlp.user.dir}/servers/serverName/analyticsData` です。
* Apache Tomcat の場合、この場所は `${CATALINA_HOME}/bin/analyticsData` です。
* WebSphere Application Server および WebSphere Application Server Network Deployment の場合、この場所は `${was.install.root}/profiles/<profileName>/analyticsData` です。

ディレクトリー **analyticsData** およびそれに含まれるサブディレクトリーとファイルの階層は、{{site.data.keys.mf_analytics }} サービス・コンポーネントがイベントを受信したときにまだ存在しない場合、実行時に自動的に作成されます。

#### shards
{: #shards }
**shards** 属性は、ElasticSearch クラスターで作成するシャードの数を指定するために使用します。

#### replicasPerShard
{: #replicaspershard }
**replicasPerShard** 属性は、ElasticSearch クラスターでシャードごとに作成するレプリカの数を指定するために使用します。

各シャードには、ゼロ個以上のレプリカを含めることができます。デフォルトでは、各シャードに 1 つのレプリカが含まれますが、レプリカの数は、{{site.data.keys.mf_analytics }} の既存の索引で動的に変更されることがあります。
レプリカ・シャードは、当該シャードと同じノードで開始できません。

#### transportPort
{: #transportport }
**transportPort** 属性は、ElasticSearch クラスター内の他のノードがこのノードとの通信時に使用する必要があるポートを指定するために使用します。このノードがプロキシーまたはファイアウォールの背後にある場合、このポートが使用可能でアクセス可能であることを確認する必要があります。

### アプリケーション・サーバーを指定するには
{: #to-specify-an-application-server-4 }
`<applicationserver>` エレメントを使用して、基礎となるアプリケーション・サーバーに依存するパラメーターを定義します。`<applicationserver>` エレメントは以下のエレメントをサポートしています。

**注:** このエレメントの属性および内部エレメントについては、[{{site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) の表に説明があります。

| エレメント                                   | 説明	| カウント   | 
|-------------------------------------------|---------------|---------|
| **websphereapplicationserver** または **was** | WebSphere Application Server のパラメーター。	| 0..1 |
| tomcat	                                | Apache Tomcat のパラメーター。	| 0..1 |

### カスタム JNDI プロパティーを指定するには
{: #to-specify-custom-jndi-properties }
`<installanalytics>`、`<updateanalytics>`、および `<uninstallanalytics>` の各エレメントでは、以下のエレメントがサポートされます。

| エレメント  | 説明 | カウント | 
|----------|-------------|-------|
| property | プロパティー	 | 0..   |

このエレメントを使用して、独自の JNDI プロパティーを定義できます。

このエレメントには以下の属性があります。

| 属性  | 説明                | 必要 | デフォルト | 
|------------|----------------------------|----------|---------|
| 名前       | プロパティーの名前。  | はい      | なし    | 
| value	     | プロパティーの値。 |	はい      | なし    |

## 内部ランタイム・データベース
{: #internal-runtime-databases }
ランタイム・データベース表、その目的、および各表に保管されるデータの概算規模について説明します。リレーショナル・データベースでは、エンティティーはデータベース表で編成されます。

### {{site.data.keys.mf_server }} ランタイムによって使用されるデータベース
{: #database-used-by-mobilefirst-server-runtime }
以下の表に、ランタイム・データベース表、その説明、およびリレーショナル・データベースでの使用方法のリストを示します。

| リレーショナル・データベースの表名 | 説明 | 概算規模 |
|--------------------------------|-------------|--------------------|
| LICENSE_TERMS	                 | デバイス廃棄タスクが実行されるごとにキャプチャーされる各種ライセンス・メトリックを保管します。 | 数十行。この値は、JNDI プロパティー mfp.device.decommission.when で設定された値を超えることはありません。JNDI プロパティーについて詳しくは、[{{site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)を参照してください。 | 
| ADDRESSABLE_DEVICE	         | アドレス可能デバイス・メトリック (日次) を保管します。また、クラスターが開始されるたびに、1 つの項目が追加されます。	| 約 400 行。毎日、13 カ月より古い項目が削除されます。 |
| MFP_PERSISTENT_DATA	         | デバイスに関する情報、アプリケーション、クライアントに関連付けられたユーザー、およびデバイスの状況など、OAuth サーバーに登録したクライアント・アプリケーションのインスタンスを保管します。 | デバイスおよびアプリケーションのペアごとに 1 行。 |
| MFP_PERSISTENT_CUSTOM_ATTR	 | クライアント・アプリケーションのインスタンスに関連付けられたカスタム属性。カスタム属性は、クライアント・インスタンスごとにアプリケーションによって登録されたアプリケーション固有属性です。 | デバイスまたはアプリケーションのペアごとにゼロ行以上。 |
| MFP_TRANSIENT_DATA	         | クライアントおよびデバイスの認証コンテキスト | デバイスとアプリケーションのペアごとに 2 行。
デバイス・シングル・サインオンを使用している場合はデバイスごとにさらに 2 行。SSO について詳しくは、[デバイス・シングル・サインオン (SSO) の構成](../../../authentication-and-security/device-sso)を参照してください。 |
| SERVER_VERSION	             | 製品バージョン。	| 1 行 |

### {{site.data.keys.mf_server }} 管理サービスによって使用されるデータベース
{: #database-used-by-mobilefirst-server-administration-service }
以下の表に、管理データベース表、その説明、およびリレーショナル・データベースでの使用方法のリストを示します。

| リレーショナル・データベースの表名 | 説明 | 概算規模 |
|--------------------------------|-------------|--------------------|
| ADMIN_NODE	                 | 管理サービスを実行するサーバーに関する情報を保管します。サーバーが 1 つのみのスタンドアロン・トポロジーでは、このエンティティーは使用されません。 | サーバーごとに 1 行。スタンドアロン・サーバーが使用されている場合、空。 |
| AUDIT_TRAIL	                 | 管理サービスで実行されたすべての管理アクションの監査証跡を保管します。 | 数千行。 | 
| CONFIG_LINKS	                 | ライブ更新サービスへのリンクを保管します。アダプターやアプリケーションが使用する構成がライブ更新サービスに保管されている場合があり、リンクはそれらの構成を検出するために使用されます。	| 数百行。アダプターごとに、2 から 3 行が使用されます。アプリケーションごとに、4 から 6 行が使用されます。 |
| FARM_CONFIG	                 | サーバー・ファームが使用されている場合のファーム・ノードの構成を保管します。 | 数十行。サーバー・ファームが使用されていない場合は空。 |
| GLOBAL_CONFIG	                 | 一部のグローバル構成データを保管します。 | 1 行。 |
| PROJECT	                     | デプロイされたプロジェクトの名前を保管します。 | 数十行。 |
| PROJECT_LOCK	                 | 内部クラスター同期タスク。 | 数十行。 | 
| TRANSACTIONS	                 | 内部クラスター同期表。現行のすべての管理アクションの状態を保管します。 | 数十行。 |
| MFPADMIN_VERSION	             | 製品バージョン。	| 1 行。 |

### {{site.data.keys.mf_server }} ライブ更新サービスによって使用されるデータベース
{: #database-used-by-mobilefirst-server-live-update-service }
以下の表に、ライブ更新サービス・データベース表、その説明、およびリレーショナル・データベースでの使用方法のリストを示します。

| リレーショナル・データベースの表名 | 説明 | 概算規模 |
|--------------------------------|-------------|--------------------|
| CS_SCHEMAS	                 | プラットフォームに存在する、バージョン管理されたスキーマを保管します。	| スキーマごとに 1 行。 |
| CS_CONFIGURATIONS	             | バージョン管理された各スキーマの構成のインスタンスを保管します。 | 構成ごとに 1 行。 | 
| CS_TAGS	                     | 各構成インスタンスの検索可能なフィールドと値を保管します。	| 構成内の検索可能な各フィールドの、各フィールド名と値の行。 |
| CS_ATTACHMENTS	             | 各構成インスタンスの添付を保管します。 | 添付ごとに 1 行。 |
| CS_VERSION	                 | 表またはインスタンスを作成した MFP のバージョンを保管します。 | MFP のバージョンが含まれた表内の単一行。 | 

### {{site.data.keys.mf_server }} プッシュ・サービスによって使用されるデータベース
{: #database-used-by-mobilefirst-server-push-service }
以下の表に、プッシュ・サービス・データベース表、その説明、およびリレーショナル・データベースでの使用方法のリストを示します。

| リレーショナル・データベースの表名 | 説明 | 概算規模 |
|--------------------------------|-------------|--------------------|
| PUSH_APPS	                     | プッシュ通知表。プッシュ・アプリケーションの詳細を保管します。 | アプリケーションごとに 1 行。 |
| PUSH_ENV	                     | プッシュ通知表。プッシュ環境の詳細を保管します。 | 数十行。 |
| PUSH_TAGS	                     | プッシュ通知表。定義されているタグの詳細を保管します。	     | 数十行。 | 
| PUSH_DEVICES	                 | プッシュ通知表。デバイスごとに 1 つのレコードを保管します。	         | デバイスごとに 1 行。 | 
| PUSH_SUBSCRIPTIONS	         | プッシュ通知表。タグ・サブスクリプションごとに 1 つのレコードを保管します。 | デバイス・サブスクリプションごとに 1 行。 |
| PUSH_MESSAGES	                 | プッシュ通知表。プッシュ・メッセージの詳細を保管します。	 | 数十行。 | 
| PUSH_MESSAGE_SEQUENCE_TABLE	 | プッシュ通知表。生成されたシーケンス ID を保管します。	 | 1 行。 |
| PUSH_VERSION	                 | 製品バージョン。	                                         | 1 行。 |

データベースについて詳しくは、[データベースのセットアップ](../databases)を参照してください。

## サンプル構成ファイル
{{site.data.keys.product }} には、{{site.data.keys.mf_server }} をインストールするための Ant タスクの使用を開始する上で役立つ、多数のサンプル構成ファイルが用意されています。

これらの Ant タスクの使用を開始するには、{{site.data.keys.mf_server }} ディストリビューションの **MobileFirstServer/configuration-samples/** ディレクトリー内に用意されているサンプル構成ファイルを使用して作業を行うのが最も簡単な方法です。Ant タスクを使用した {{site.data.keys.mf_server }} のインストールについて詳しくは、[Ant タスクを使用したインストール](../appserver/#installing-with-ant-tasks)を参照してください。

### サンプル構成ファイルのリスト
{: #list-of-sample-configuration-files }
適切なサンプル構成ファイルを選択します。以下のファイルが用意されています。

| タスク                                                     | Derby                     | DB2                     | MySQL                      | Oracle                       | 
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
| データベース管理者資格情報を指定したデータベースの作成 | create-database-derby.xml | create-database-db2.xml | create-database-mysql.xml | create-database-oracle.xml
| {{site.data.keys.mf_server }} を Liberty にインストールします。	                   | configure-liberty-derby.xml | configure-liberty-db2.xml | configure-liberty-mysql.xml | (MySQL に関する注を参照) | configure-liberty-oracle.xml |
| シングル・サーバーの WebSphere Application Server フル・プロファイル上への {{site.data.keys.mf_server }} のインストール |	configure-was-derby.xml | configure-was-db2.xml | configure-was-mysql.xml (MySQL に関する注を参照) | configure-was-oracle.xml |
| {{site.data.keys.mf_server }} を WebSphere Application Server Network Deployment にインストールします。(構成ファイルに関する注を参照) | configure-wasnd-cluster-derby.xml、configure-wasnd-server-derby.xml、configure-wasnd-node-derby.xml、configure-wasnd-cell-derby.xml | configure-wasnd-cluster-db2.xml、configure-wasnd-server-db2.xml、configure-wasnd-node-db2.xml、configure-wasnd-cell-db2.xml | configure-wasnd-cluster-mysql.xml (MySQL に関する注を参照)、configure-wasnd-server-mysql.xml (MySQL に関する注を参照)、configure-wasnd-node-mysql.xml (MySQL に関する注を参照)、configure-wasnd-cell-mysql.xml | configure-wasnd-cluster-oracle.xml、configure-wasnd-server-oracle.xml、configure-wasnd-node-oracle.xml、configure-wasnd-cell-oracle.xml |
| {{site.data.keys.mf_server }} を Apache Tomcat にインストールします。	           | configure-tomcat-derby.xml | configure-tomcat-db2.xml | configure-tomcat-mysql.xml | configure-tomcat-oracle.xml |
| {{site.data.keys.mf_server }} を Liberty 集合にインストールします。	       | 関連なし              | configure-libertycollective-db2.xml | configure-libertycollective-mysql.xml | configure-libertycollective-oracle.xml |

**MySQL に関する注:** WebSphere Application Server Liberty プロファイルまたは WebSphere Application Server フル・プロファイルと組み合わせて使用される MySQL は、サポートされる構成には分類されません。詳しくは、WebSphere Application Server Support Statement を参照してください。IBM サポートによるフルサポートの対象となる構成の利点を活用するために、WebSphere Application Server でサポートされる IBM DB2 などのデータベースの使用を検討してください。

**WebSphere Application Server Network Deployment の構成ファイルに関する注:** **wasnd** の構成ファイルには、**cluster**、**node**、**server**、または **cell** に設定できる有効範囲が含まれます。例えば、**configure-wasnd-cluster-derby.xml** の場合、有効範囲は **cluster** です。これらの有効範囲タイプは、以下のようにデプロイメント・ターゲットを定義します。

* **cluster**: クラスターにデプロイします。
* **server**: デプロイメント・ マネージャーに管理されるシングル・サーバーにデプロイします。
* **node**: ノード上で稼動していてもクラスターに属していないすべてのサーバーにデプロイします。
* **cell**: セル上のすべてのサーバーにデプロイします。

## {{site.data.keys.mf_analytics }} のサンプル構成ファイル
{: #sample-configuration-files-for-mobilefirst-analytics }
{{site.data.keys.product }} には、{{site.data.keys.mf_analytics }} サービスおよび {{site.data.keys.mf_analytics_console }}をインストールするための Ant タスクの使用を開始する上で役立つ、多数のサンプル構成ファイルが用意されています。

`<installanalytics>`、`<updateanalytics>`、および `<uninstallanalytics>` の各 Ant タスクの使用を開始するには、{{site.data.keys.mf_server }} ディストリビューションの **Analytics/configuration-samples/** ディレクトリー内に用意されている、サンプル構成ファイルを使用して作業を行うのが最も簡単な方法です。

### ステップ 1
{: #step-1 }
適切なサンプル構成ファイルを選択します。以下の XML ファイルが用意されています。後続のステップでは、**configure-file.xml** と記載しています。

| タスク | アプリケーション・サーバー |
|------|--------------------|
| WebSphere Application Server Liberty プロファイルで {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-liberty-analytics.xml | 
| Apache Tomcat で {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-tomcat-analytics.xml | 
| WebSphere Application Server フル・プロファイルで {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-was-analytics.xml | 
| WebSphere Application Server Network Deployment (シングル・サーバー) で {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-wasnd-server-analytics.xml | 
| WebSphere Application Server Network Deployment (セル) で {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-wasnd-cell-analytics.xml | 
| WebSphere Application Server Network Deployment (ノード) で {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-wasnd-node.xml | 
| WebSphere Application Server Network Deployment (クラスター) で {{site.data.keys.mf_analytics }} サービスおよびコンソールをインストールする | configure-wasnd-cluster-analytics.xml | 

**WebSphere Application Server Network Deployment の構成ファイルに関する注:**  
wasnd の構成ファイルには、**cluster**、**node**、**server**、または **cell** に設定できる有効範囲が含まれます。例えば、**configure-wasnd-cluster-analytics.xml** の場合、有効範囲は **cluster** です。これらの有効範囲タイプは、以下のようにデプロイメント・ターゲットを定義します。

* **cluster**: クラスターにデプロイします。
* **server**: デプロイメント・ マネージャーに管理されるシングル・サーバーにデプロイします。
* **node**: ノード上で稼動していてもクラスターに属していないすべてのサーバーにデプロイします。
* **cell**: セル上のすべてのサーバーにデプロイします。

### ステップ 2
{: #step-2 }
サンプル・ファイルのファイル・アクセス権限を、できる限り制限されたものに変更します。ステップ 3 では、いくつかのパスワードを指定する必要があります。同じコンピューター上の他のユーザーがこれらのパスワードを知ることができないようにする必要がある場合は、自分以外のユーザーに対して、ファイルの read 権限を削除する必要があります。以下の例のようなコマンドを使用できます。

UNIX の場合: `chmod 600 configure-file.xml`
Windows の場合: `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### ステップ 3
{: #step-3 }
同様に、アプリケーション・サーバーが WebSphere Application Server Liberty プロファイルまたは Apache Tomcat サーバーであり、そのサーバーが自分のアカウントからのみ始動するようにする場合は、次のファイルから自分以外のユーザーの read 権限を削除する必要もあります。

* WebSphere Application Server Liberty プロファイルの場合: **wlp/usr/servers/<server>/server.xml**
* Apache Tomcat の場合: **conf/server.xml**

### ステップ 4
{: #step-4 }
ファイルの先頭にあるプロパティーのプレースホルダー値を置き換えます。

**注:
**  
Ant XML スクリプトの値で以下の特殊文字が使用される場合は、エスケープする必要があります。


* Apache Ant Manual の『Properties』セクションに説明されているように、ドル記号 (`$`) は、構文 `${variable}` によって Ant 変数を明示的に参照する場合を除き、$$ と記述してください。
* アンパーサンド文字 (`&`) は、XML エンティティーを明示的に参照する場合を除き、`&amp;` と記述してください。
* 二重引用符 (`"`) は、単一引用符で囲まれたストリング内にある場合を除き、`&quot;` と記述してください。

### ステップ 5
{: #step-5 }
次のコマンドを実行します。`ant -f configure-file.xml install`

このコマンドは、アプリケーション・サーバーで {{site.data.keys.mf_analytics }} サービス・コンポーネントおよび {{site.data.keys.mf_analytics_console }}・コンポーネントをインストールします。{{site.data.keys.mf_analytics }} サービス・コンポーネントおよび {{site.data.keys.mf_analytics_console }}・コンポーネントをインストールするには (例えば、{{site.data.keys.mf_server }} フィックスパックを適用する場合は)、以下のコマンドを実行します。`ant -f configure-file.xml minimal-update`

インストール手順をリバースするには、次のコマンドを実行します。`ant -f configure-file.xml uninstall`

このコマンドは、{{site.data.keys.mf_analytics }} サービス・コンポーネントおよび {{site.data.keys.mf_analytics_console }}・コンポーネントをアンインストールします。

