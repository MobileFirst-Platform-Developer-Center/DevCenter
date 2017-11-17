---
layout: tutorial
title: コマンド・ラインからの MobileFirst Server のインストールに関するチュートリアル
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM Installation Manager のコマンド・ライン・モードおよび Ant タスクを使用して、{{ site.data.keys.mf_server }} をインストールします。

#### 始める前に
{: #before-you-begin }
* 以下のいずれかのデータベースおよびサポート対象の Java バージョンがインストール済みであることを確認してください。また、そのデータベースに対応する JDBC ドライバーがご使用のコンピューターで使用可能である必要があります。
    * サポート対象のデータベース・リストにあるデータベース管理システム (DBMS)
        * DB2 
        * MySQL 
        * Oracle 

        > **重要:** 本製品で必要とされる表の作成場所となるデータベース、およびそのデータベースで表を作成できるデータベース・ユーザーが必要となります。

        このチュートリアルにおける表の作成手順は DB2 を対象にしています。DB2 インストーラーは、IBM パスポート・アドバンテージで {{ site.data.keys.product }} eAssembly のパッケージとして提供されています。

* ご使用のデータベースの JDBC ドライバー
    * DB2 の場合、DB2 JDBC ドライバー・タイプ 4 を使用します。
    * MySQL の場合、Connector/J JDBC ドライバーを使用します。
    * Oracle の場合、Oracle Thin JDBC ドライバーを使用します。
* Java 7 以降。

* IBM Installation Manager V1.8.4 以降のインストーラーは、[Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142) からダウンロードします。
* また、{{ site.data.keys.mf_server }} のインストール・リポジトリーおよび WebSphere Application Server Liberty Core V8.5.5.3 以降のインストーラーも必要です。これらのパッケージを、パスポート・アドバンテージの {{ site.data.keys.product }} eAssembly からダウンロードします。

**{{ site.data.keys.mf_server }} のインストール・リポジトリー**  
{{ site.data.keys.mf_server }} 用の Installation Manager リポジトリーの {{ site.data.keys.product }} V8.0 .zip ファイル

**WebSphere Application Server Liberty プロファイル**  
IBM WebSphere Application Server - Liberty Core V8.5.5.3 以降
    
#### ジャンプ先
{: #jump-to }
* [IBM Installation Manager のインストール](#installing-ibm-installation-manager)
* [WebSphere Application Server Liberty Core のインストール](#installing-websphere-application-server-liberty-core)
* [{{ site.data.keys.mf_server }} のインストール](#installing-mobilefirst-server)
* [データベースの作成](#creating-a-database)
* [Ant タスクを使用した {{ site.data.keys.mf_server }} の Liberty へのデプロイ](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)
* [インストール済み環境のテスト](#testing-the-installation)
* [{{ site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [ファームのテストと {{ site.data.keys.mf_console }} での変更内容の確認](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

## IBM Installation Manager のインストール
{: #installing-ibm-installation-manager }
Installation Manager V1.8.4 以降をインストールする必要があります。製品のポストインストール操作で Java 7 が必要なため、古いバージョンの Installation Manager は {{ site.data.keys.product }} V8.0 をインストールできません。古いバージョンの Installation Manager には Java 6 が装備されています。

1. ダウンロードした IBM Installation Manager アーカイブ・ファイルを解凍します。インストーラーは [Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142) にあります。
2. **unzip\_IM\_1.8.x/license** ディレクトリー内にある IBM Installation Manager のご使用条件を確認します。
3. 確認後、ご使用条件に同意したら、Installation Manager をインストールします。  
    * **installc.exe** を実行して、管理者として Installation Manager をインストールします。Linux または UNIX では root が必要です。Windows では、管理者特権が必要です。このモードでは、インストール済みパッケージに関する情報はディスク上の共有ロケーションに置かれ、Installation Manager の実行を許可されたユーザーなら誰でも、アプリケーションを更新することができます。グラフィカル・ユーザー・インターフェースを使用しないコマンド・ラインでのインストール用として、実行可能ファイル名は、末尾が 「c」 (**installc**) となっています。Installation Manager をインストールするには、**installc.exe -acceptLicence** と入力します。
    * ユーザー・モードで Installation Manager をインストールするには、**userinstc.exe** を実行します。特定の特権は必要ありません。ただし、このモードでは、インストール済みパッケージに関する情報は、ユーザーのホーム・ディレクトリーに置かれます。Installation Manager でインストールされるアプリケーションの更新を行えるのは、そのユーザーのみです。グラフィカル・ユーザー・インターフェースを使用しないコマンド・ラインでのインストール用として、実行可能ファイル名は、末尾が 「c」 (**userinstc**) となっています。Installation Manager をインストールするには、**userinstc.exe -acceptLicence** と入力します。
    
## WebSphere Application Server Liberty Core のインストール
{: #installing-websphere-application-server-liberty-core }
WebSphere Application Server Liberty Core のインストーラーは、{{ site.data.keys.product }} のパッケージの一部として提供されています。このタスクでは、Liberty プロファイルがインストールされ、サーバー・インスタンスが作成されます。このサーバー・インスタンス上に {{ site.data.keys.mf_server }} をインストールできます。

1. WebSphere Application Server Liberty Core のご使用条件を確認します。ライセンス・ファイルは、パスポート・アドバンテージからインストーラーをダウンロードすると表示できます。
2. ダウンロードした WebSphere Application Server Liberty Core の圧縮ファイルを、任意のフォルダーに解凍します。

    以下のステップでは、インストーラーを解凍するディレクトリーは **liberty\_repository\_dir** という名前になっています。ここには、他の多くのファイルとともに、**repository.config** ファイルまたは **diskTag.inf** ファイルが含まれています。

3. Liberty プロファイルをインストールするディレクトリーを決めます。以下のステップでは、このディレクトリーは liberty_install_dir という名前になっています。
4. コマンド・ラインを開始し、**installation\_manager\_install\_dir/tools/eclipse/** に移動します。
5. 確認後、ご使用条件に同意したら、Liberty をインストールします。
    
    次のコマンドを入力します。**imcl install com.ibm.websphere.liberty.v85 -repositories liberty\_repository\_dir -installationDirectory liberty\_install\_dir -acceptLicense**

    このコマンドにより、**liberty\_install\_dir** ディレクトリーに Liberty がインストールされます。**-acceptLicense** オプションは、製品のライセンス条項に同意することを意味します。

6. サーバーを含むディレクトリーを、特定の特権が必要とされないロケーションに移動します。

    このチュートリアルの目的で、**liberty\_install\_dir** が非管理者または非 root ユーザーがファイルを変更できないロケーションを指している場合、サーバーを含むそのディレクトリーを、特定の特権が必要とされないロケーションに移動してください。そうすることで、特定の特権がなくてもインストールの操作を行うことができます。
    * Liberty のインストール・ディレクトリーに移動します。
    * etc という名前のディレクトリーを作成します。管理者または root の特権が必要です。
    * **etc** ディレクトリー内に、**server.env** ファイルを作成し、ファイル内に `WLP_USER_DIR=<path to a directory where any user can write>` というコンテンツを含めます。例えば、Windows の場合は、`WLP_USER_DIR=C:\LibertyServers\usr` です。
7.  チュートリアルのこの後のパートで {{ site.data.keys.mf_server }} の最初のノードのインストールに使用する Liberty サーバーを作成します。
    * コマンド・ラインを開始します。
    * **liberty\_install\_dir/bin** に移動し、**server create mfp1** と入力します。
    
    このコマンドにより、**mfp1** という名前の Liberty サーバー・インスタンスが作成されます。その定義は、**liberty\_install\_dir/usr/servers/mfp1** または **WLP\_USER\_DIR/servers/mfp1** (ステップ 6 の説明に従ってディレクトリーを変更した場合) にあります。
    
サーバーの作成後、このサーバーは **liberty\_install\_dir/bin/** から `server start mfp1` で始動することができます。  
サーバーを停止するには、**liberty\_install\_dir/bin/** からコマンド `server stop mfp1` を入力します。

デフォルトのホーム・ページは [http://localhost:9080](http://localhost:9080) で表示できます。

> **注:** 実動用には、ホスト・コンピューターの始動時に Liberty サーバーがサービスとして始動するようにする必要があります。Liberty サーバーをサービスとして始動させる手順は、このチュートリアルには含まれていません。



## {{ site.data.keys.mf_server }} のインストール
{: #installing-mobilefirst-server }
Installation Manager V1.8.4 以降がインストールされていることを確認してください。Installation Manager のバージョンがこれより古いと、{{ site.data.keys.mf_server }} のインストールが正常に終了しない場合があります。これは、インストール後の操作に Java 7 が必要であり、古いバージョンの Installation Manager に付属するのは Java 6 であるためです。

データベースを作成して {{ site.data.keys.mf_server }} を Liberty プロファイルにデプロイする前に、Installation Manager を実行してご使用のディスクに {{ site.data.keys.mf_server }} のバイナリー・ファイルをインストールします。Installation Manager を使用した {{ site.data.keys.mf_server }} のインストール中に、{{ site.data.keys.mf_app_center }} をインストールするオプションが提案されます。 Application Center は、本製品の別のコンポーネントです。このチュートリアルでは、これを {{ site.data.keys.mf_server }} と共にインストールする必要はありません。

また、トークン・ライセンスをアクティブ化するかどうかを指示するプロパティーも 1 つ指定する必要があります。このチュートリアルでは、トークン・ライセンスが不要であることを前提としています。そのため、{{ site.data.keys.mf_server }} をトークン・ライセンス用に構成する手順は含まれていません。ただし、実動インストールでは、トークン・ライセンスをアクティブ化する必要があるかどうかを判断する必要があります。Rational License Key Server でトークン・ライセンスを使用する契約がない場合は、トークン・ライセンスをアクティブ化する必要はありません。トークン・ライセンスをアクティブ化する場合は、{{ site.data.keys.mf_server }} をトークン・ライセンス用に構成する必要があります。 

このチュートリアルでは、**imcl** コマンド・ラインを使用して、これらのプロパティーをパラメーターとして指定します。この指定は、応答ファイルを使用しても行うことができます。 

1. {{ site.data.keys.mf_server }} のご使用条件を確認します。ライセンス・ファイルは、パスポート・アドバンテージからインストール・リポジトリーをダウンロードすると表示できます。
2. ダウンロードした {{ site.data.keys.mf_server }} インストーラーの圧縮ファイルを、任意のフォルダーに解凍します。

    以下のステップでは、インストーラーを解凍するディレクトリーは **mfp\_repository\_dir** という名前になっています。この中には **MobileFirst\_Platform\_Server/disk1** フォルダーが含まれています。
3. コマンド・ラインを開始し、**installation\_manager\_install\_dir/tools/eclipse/** に移動します。
4. ステップ 1 で確認後ご使用条件に同意したら、{{ site.data.keys.mf_server }} をインストールします。

    次のコマンドを入力します。`imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense`

    Application Center なしでインストールを行うために、以下のプロパティーを定義しています。 
    * **user.appserver.selection2=none**
    * **user.database.selection2=none**
    * **user.database.preinstalled=false**

    このプロパティーは、トークン・ライセンスがアクティブ化されないことを指示します。**user.licensed.by.tokens=false**  
    {{ site.data.keys.product }} をインストールするには、**user.use.ios.edition** プロパティーの値を false に設定します。

{{ site.data.keys.product_adj }} コンポーネントをインストールするためのリソースを含むインストール・ディレクトリーがインストールされます。  
リソースは以下のフォルダーに入っています。

* {{ site.data.keys.mf_server }} 用の **MobileFirstServer** フォルダー
*  {{ site.data.keys.mf_server }} プッシュ・サービス用の **PushService** フォルダー
* Application Center 用の **ApplicationCenter** フォルダー
* {{ site.data.keys.mf_analytics }} 用の **Analytics** フォルダー

このチュートリアルの目的は、**MobileFirstServer** フォルダー内のリソースを使用して {{ site.data.keys.mf_server }} をインストールすることです。  
また、**shortcuts** フォルダーには、サーバー構成ツール、Ant、および **mfpadm** プログラムのショートカットも用意されています。

## データベースの作成
{: #creating-a-database }
このタスクでは、ご使用の DBMS にデータベースが存在するようにし、ユーザーがそのデータベースの使用、データベース内での表の作成、およびその表の使用を許可されるようにします。Derby データベースを使用する予定である場合は、このタスクはスキップできます。

このデータベースは、さまざまな {{ site.data.keys.product_adj }} コンポーネントが使用するテクニカル・データを保管するのに使用します。

* {{ site.data.keys.mf_server }} 管理サービス
* {{ site.data.keys.mf_server }} ライブ更新サービス
* {{ site.data.keys.mf_server }} プッシュ・サービス
* {{ site.data.keys.product_adj }}runtime

このチュートリアルでは、すべてのコンポーネント用の表が同じスキーマに置かれています。  
**注:** このタスクの手順は、DB2 用です。MySQL または Oracle を使用する予定である場合は、[データベース要件](../../databases/#database-requirements)を参照してください。

1. DB2 サーバーを実行しているコンピューターにログオンします。DB2 ユーザー (例えば **mfpuser** という名前のユーザー) が存在することを想定しています。
2. この DB2 ユーザーが 32768 以上のページ・サイズのデータベースへのアクセス権限を付与されていること、またそのデータベース内に暗黙的なスキーマおよび表を作成できることを確認してください。

    デフォルトで、このユーザーは、DB2 を実行するコンピューターのオペレーティング・システムで宣言されたユーザーです。つまり、そのコンピューターへのログインができるユーザーです。そのようなユーザーが存在する場合、次のステップ 3 で説明するアクションは不要です。
3. このインストール済み環境用の正しいページ・サイズのデータベースがなければ、作成してください。
    * **SYSADM** 権限または **SYSCTRL** 権限を持つユーザーでセッションを開きます。例えば、DB2 インストーラーによって作成されたデフォルトの管理ユーザーであるユーザー **db2inst1** を使用します。
    * 次のように、DB2 コマンド・ライン・プロセッサーを開きます。
        * Windows システムでは、**「開始 (Start)」→「IBM DB2」→「コマンド・ライン・プロセッサー (Command Line Processor)」**とクリックします。
        * Linux システムまたは UNIX システムでは、**~/sqllib/bin** (または、管理者のホーム・ディレクトリーに sqllib が作成されていなければ **db2\_install\_dir/bin**) に移動し、`./db2` と入力します。
    * 以下の SQL ステートメントを入力して、**MFPDATA** という名前のデータベースを作成します。
    
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

    別のユーザー名を定義した場合は、**mfpuser** を独自のユーザー名に置き換えます。
    
    > **注:** このステートメントにより、デフォルトの DB2 データベースで PUBLIC に付与されたデフォルトの特権が削除されることはありません。実動では、そのデータベース内の特権を、本製品の最小要件まで減らすことが必要になる場合もあります。DB2 セキュリティーおよびセキュリティーの実施例について詳しくは、[DB2 security, Part 8: Twelve DB2 security best practices](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/) を参照してください。



## Ant タスクを使用した {{ site.data.keys.mf_server }} の Liberty へのデプロイ
{: #deploying-mobilefirst-server-to-liberty-with-ant-tasks }
Ant タスクを使用して、以下の操作を実行します。

* データベース内に {{ site.data.keys.product_adj }} アプリケーションで必要となる表を作成します。
* {{ site.data.keys.mf_server }} の Web アプリケーション (ランタイム、管理サービス、ライブ更新サービス、プッシュ・サービスのコンポーネント、および {{ site.data.keys.mf_console }}) を Liberty サーバーにデプロイします。

以下の {{ site.data.keys.product_adj }} アプリケーションは Ant タスクではデプロイされません。

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} はメモリー所要量が大きいため、通常 {{ site.data.keys.mf_server }} とは別のサーバー・セットにデプロイされます。{{ site.data.keys.mf_analytics }} は、手動で、もしくは Ant タスクを使用してインストールできます。既にインストール済みの場合は、サーバー構成ツールでその URL、ユーザー名、およびパスワードを入力し、それにデータを送信できるようにします。それにより、サーバー構成ツールが {{ site.data.keys.mf_analytics }} にデータを送信するように {{ site.data.keys.product_adj }} アプリを構成します。 

#### Application Center
{: #application-center }
このアプリケーションは、社内でモバイル・アプリを使用する従業員に配布するのに使用したり、テスト目的に使用したりできます。これは {{ site.data.keys.mf_server }} とは独立していて、{{ site.data.keys.mf_server }} と一緒にインストールする必要はありません。 

Ant タスクを含む適切な XML ファイルを選択し、プロパティーを構成します。

* **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-db2.xml** ファイルのコピーを、作業ディレクトリーに作成します。このファイルには、{{ site.data.keys.mf_server }} を、データベースとして DB2 が設定された Liberty にインストールするための Ant タスクが含まれています。これを使用する前に、{{ site.data.keys.mf_server }} のアプリケーションをどこにデプロイするかを示すプロパティーを定義します。
* XML ファイルのコピーを編集し、以下のプロパティーの値を設定してください。
    * **mfp.admin.contextroot** を **/mfpadmin** に。
    * **mfp.runtime.contextroot** を **/mfp** に。
    * **database.db2.host** を DB2 データベースが稼働しているコンピューターのホスト名の値に。データベースが Liberty と同じコンピューター上にある場合は、 **localhost** を使用してください。
    * **database.db2.port** を DB2 インスタンスが listen しているポートに。デフォルトでは、これは **50000** です。
    * **database.db2.driver.dir** を、ご使用の DB2 ドライバー (**db2jcc4.jar** および **db2jcc\_license\_cu.jar**) が含まれるディレクトリーに。標準の DB2 ディストリビューションでは、これらのファイルは **db2\_install\_dir/java** 内にあります。
    * **database.db2.mfp.dbname** を **MFPDATA** (『データベースの作成』で作成したデータベース名) に。
    * **database.db2.mfp.schema** を **MFPDATA** ({{ site.data.keys.mf_server }} の表の作成場所となるスキーマの値) に。DB ユーザーがスキーマを作成できない場合は、この値を空ストリングにしてください。例えば、**database.db2.mfp.schema=""** などにします。
    * **database.db2.mfp.username** を、表を作成する DB2 ユーザーに。このユーザーは、実行時に表の使用も行います。このチュートリアル用には、**mfpuser** を使用します。
    * **appserver.was.installdir** を Liberty インストール・ディレクトリーに。
    * **appserver.was85liberty.serverInstance** を **mfp1** ({{ site.data.keys.mf_server }} のインストール先の Liberty サーバーの名前の値) に。
    * **mfp.farm.configure** を **false** に (スタンドアロン・モードで {{ site.data.keys.mf_server }} をインストールするため)。
    * **mfp.analytics.configure** を **false** に。{{ site.data.keys.mf_analytics }} への接続は、このチュートリアルの対象範囲に含まれていません。その他のプロパティー mfp.analytics.**** は無視して構いません。
    * **mfp.admin.client.id** を **admin-client-id** に。
    * **mfp.admin.client.secret** を **adminSecret** に (または別の秘密パスワードを選択)。
    * **mfp.push.client.id** を **push-client-id** に。
    * **mfp.push.client.secret** を **pushSecret** に (または別の秘密パスワードを選択)。
    * **mfp.config.admin.user** を {{ site.data.keys.mf_server }} ライブ更新サービスのユーザー名に。サーバー・ファーム・トポロジーでは、ユーザー名はファームのすべてのメンバーで同じでなければなりません。
    * **mfp.config.admin.password** を {{ site.data.keys.mf_server }} ライブ更新サービスのパスワードに。サーバー・ファーム・トポロジーでは、パスワードはファームのすべてのメンバーで同じでなければなりません。
* 以下のプロパティーのデフォルト値はそのまま保持します。
    * **mfp.admin.console.install** を true に。
    * **mfp.admin.default.user** を **admin** ({{ site.data.keys.mf_console }} へのログイン用に作成したデフォルト・ユーザーの名前) に。
    * **mfp.admin.default.user.initialpassword** を **admin** (管理コンソールへのログイン用に作成したデフォルト・ユーザーのパスワード) に。
    * **appserver.was.profile** を **Liberty** に。この値が異なる場合、Ant タスクはインストール済み環境が WebSphere Application Server サーバー上にあると想定します。
* プロパティーの定義が完了したら、ファイルを保存します。
* `mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml` を実行すると、Ant ファイルの可能なターゲットのリストが表示されます。
* 次のコマンドを実行してデータベース表を作成します。`mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml databases`
* 次のコマンドを実行して {{ site.data.keys.mf_server }} をインストールします。`mfp_server_install_dir/shortcuts/ant -f configure-liberty-db2.xml install`

> **注:** DB2 が存在せず、組み込みの Derby をデータベースとして使用してインストール済み環境をテストしたい場合は、**mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-liberty-derby.xml** ファイルを使用してください。ただし、Derby データベースに複数の Liberty サーバーがアクセスすることはできないため、このチュートリアルの最後のステップ ({{ site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成) は実行できません。DB2 関連のプロパティー (**database.db2**, ...) を除くプロパティーを設定する必要があります。Derby を使用する場合は、プロパティー **database.derby.datadir** の値を、Derby データベースを作成できるディレクトリーに設定してください。また、プロパティー **database.derby.mfp.dbname** の値を **MFPDATA** に設定します。



以下の操作が、Ant タスクにより実行されます。

1. 以下のコンポーネントの表が、データベース内に作成されます。
    * 管理サービスおよびライブ更新サービス。`admdatabases` Ant ターゲットにより作成。
    * ランタイム・コンポーネント。`rtmdatabases` Ant ターゲットにより作成。
    * プッシュ・サービス。`pushdatabases` Ant ターゲットにより作成。
2. さまざまなコンポーネントの WAR ファイルが、Liberty サーバーにデプロイされます。操作の詳細は、`adminstall`、`rtminstall`、および `pushinstall` ターゲットの下のログで確認できます。

DB2 サーバーへのアクセス権限を持っている場合は、以下の命令を使用して、作成された表をリストできます。

1. 『データベースの作成』のステップ 3 の説明に従って、mfpuser で DB2 コマンド・ライン・プロセッサーを開きます。
2. 以下の SQL ステートメントを入力します。

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

データベースの以下のファクターに注意してください。

#### データベース・ユーザーに関する考慮事項
{: #database-user-consideration }
サーバー構成ツールで必要とされるデータベース・ユーザーは、1 人のみです。このユーザーは、表の作成に使用されますが、実行時にアプリケーション・サーバーでデータ・ソース・ユーザーとしても使用されます。実稼働環境では、実行時に使用されるこのユーザーの特権を厳密に最小限 (`SELECT / INSERT / DELETE / UPDATE`) に制限し、アプリケーション・サーバーへのデプロイメント用には別のユーザーを指定することもできます。サンプルとして提供されている Ant ファイルも、同じユーザーを両方のケースに使用しています。ただし、DB2 の場合、独自のバージョンのファイルを作成することもできます。それにより、データベースの作成に使用されるユーザーと、Ant タスクでアプリケーション・サーバー内のデータ・ソースに使用されるユーザーとを識別することができます。

#### データベース表の作成
{: #database-tables-creation }
実動用には、手動で表を作成することもできます。例えば、DBA がデフォルトの設定値の一部をオーバーライドしたい場合や、特定の表スペースを割り当てたい場合などがそうです。表の作成に使用するデータベース・スクリプトは、**mfp\_server\_install\_dir/MobileFirstServer/databases** および **mfp\_server\_install\_dir/PushService/databases** にあります。詳しくは、[データベース表の手動作成](../../databases/#create-the-database-tables-manually)を参照してください。

**server.xml** ファイルおよび何らかのアプリケーション・サーバーの設定が、インストール中に変更されます。それぞれの変更の前に、**server.xml** ファイルのコピー (**server.xml.bak**、**server.xml.bak1**、**server.xml.bak2** など) が作成されます。追加された内容をすべて確認するには、**server.xml** ファイルを最も古いバックアップ (server.xml.bak) と比較することができます。Linux では、コマンド `--strip-trailing-cr server.xml server.xml.bak` を使用してその差異を確認します。AIX では、コマンド `diff server.xml server.xml.bak` を使用してその差異を確認します。

#### アプリケーション・サーバーの設定の変更 (Liberty に固有):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Liberty のフィーチャーが追加されます。

    それらのフィーチャーは各アプリケーションに対して追加され、重複することがあります。例えば、JDBC フィーチャーは、管理サービスとランタイム・コンポーネントの両方に使用されます。この重複があることで、アプリケーションをアンインストールするとき、他のアプリケーションを中断せずにそのフィーチャーを削除することができます。例えば、ある時点でプッシュ・サービスをサーバーからアンインストールして別のサーバーにインストールすることにした場合などがそうです。ただし、すべてのトポロジーが可能というわけではありません。管理サービス、ライブ更新サービス、およびランタイム・コンポーネントは、Liberty プロファイルのある同じアプリケーション・サーバー上にある必要があります。詳しくは、[{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイムでの制約](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)を参照してください。フィーチャーが重複していても、追加されたフィーチャー同士が競合しなければ、問題は生じません。jdbc-40 および jdbc-41 のフィーチャーを追加すると問題が生じますが、同じフィーチャーを 2 回追加すると問題は生じません。
    
2. `host='*'` が `httpEndPoint` 宣言内で追加されます。

    この設定は、すべてのネットワーク・インターフェースからサーバーへの接続を許可するものです。実動用には、HTTP エンドポイントのホスト値を制限することもできます。
3. **tcpOptions** エレメント (**tcpOptions soReuseAddr="true"**) は、アクティブなリスナーのないポートへの即時再バインドを可能にし、サーバーのスループットを改善するために、サーバー構成に追加されます。
4. ID **defaultKeyStore** の鍵ストアが存在しない場合は、作成されます。

    この鍵ストアは、HTTPS ポートを使用可能にし、さらに具体的に言えば、管理サービス (mfp-admin-service.war) とランタイム・コンポーネント (mfp-server.war) の間の JMX 通信を使用可能にするためのものです。これらの 2 つのアプリケーションは、JMX を介して通信します。Liberty プロファイルの場合、単一サーバー内のアプリケーション間の通信および Liberty ファームのサーバー間の通信に、restConnector が使用されます。これには HTTPS の使用が必要です。デフォルトで作成される鍵ストア用に、Liberty プロファイルは 365 日の有効期間の証明書を作成します。この構成は、実稼働環境での使用を目的としたものではありません。 実動用には、独自の証明書の使用を再検討する必要があります。    

    JMX を使用可能にするために、基本レジストリーに管理者ロールを持つユーザーが (MfpRESTUser という名前で) 作成されます。このユーザーの名前とパスワードは JNDI プロパティー (mfp.admin.jmx.user および mfp.admin.jmx.pwd) として指定されており、JMX 照会を実行するために、ランタイム・コンポーネントおよび管理サービスによって使用されます。グローバル JMX プロパティーでは、一部のプロパティーはクラスター・モード (スタンドアロン・サーバーまたはファーム内で稼働) の定義に使用されます。サーバー構成ツールは Liberty サーバーで mfp.topology.clustermode プロパティーを Standalone に設定します。このチュートリアルの後半のファームの作成に関するパートで、このプロパティーは Cluster に変更されます。
5. ユーザーが作成されます (Apache Tomcat および WebSphere Application Server にも有効)。
    * オプション・ユーザー: サーバー構成ツールは、インストール後にコンソールへのログインに使用できるように、テスト・ユーザー (admin/admin) を作成します。
    * 必須ユーザー: また、サーバー構成ツールは、ローカルライブ更新サービスに接続するために管理サービスが使用するユーザー (名前は configUser_mfpadmin、パスワードはランダムに生成) も作成します。Liberty サーバー用に、MfpRESTUser が作成されます。ご使用のアプリケーション・サーバーが基本レジストリー (例えば LDAP レジストリー) を使用するように構成されていなければ、サーバー構成ツールは既存ユーザーの名前を要求できません。この場合、Ant タスクを使用する必要があります。
6. **webContainer** エレメントが変更されます。

    `deferServletLoad` Web コンテナー・カスタム・プロパティーが false に設定されます。サーバーの始動時に、ランタイム・コンポーネントと管理サービスの両方が始動しなければなりません。そうすることで、これらのコンポーネントは JMX Bean を登録でき、ランタイム・コンポーネントが機能するために必要なアプリケーションおよびアダプターをすべてダウンロードできるようにするための同期プロシージャーを開始できます。
7. Liberty V8.5.5.5 以前をご使用の場合、デフォルトの executor がカスタマイズされ、`coreThreads` および `maxThreads` に大きな値が設定されます。V8.5.5.6 以降、デフォルトの executor は Liberty により自動調整されます。

    この設定により、一部の Liberty バージョンでランタイム・コンポーネントおよび管理サービスの始動シーケンスを中断するタイムアウトの問題が回避されます。このステートメントがないと、サーバー・ログ・ファイルでこれらのエラーが発生する可能性があります。
    
    > MBean にアクセスするための JMX 接続を取得することができませんでした。JMX 構成のエラーの可能性があります: 読み取りタイムアウト
FWLSE3000E: サーバー・エラーが検出されました。
    > FWLSE3012E: JMX 構成のエラー。MBean を取得できません。理由: "読み取りタイムアウト"。

#### アプリケーションの宣言
{: #declaration-of-applications }
以下のアプリケーションがインストールされています。

* **mfpadmin**、管理サービス
* **mfpadminconfig**、ライブ更新サービス
* **mfpconsole**、{{ site.data.keys.mf_console }}
* **mobilefirst**、{{ site.data.keys.product_adj }} ランタイム・コンポーネント
* **imfpush**、プッシュ・サービス

サーバー構成ツールはすべてのアプリケーションを同じサーバーにインストールします。アプリケーションを別のアプリケーション・サーバーに分離することもできますが、[トポロジーとネットワーク・フロー](../../topologies)に記載された特定の制約を受けることになります。  
別々のサーバーにインストールする場合は、サーバー構成ツールを使用することはできません。Ant タスクを使用するか、手動で製品をインストールしてください。

#### 管理サービス
{: #administration-service }
管理サービスは、{{ site.data.keys.product_adj }} のアプリケーション、アダプター、およびその構成を管理するためのサービスです。このサービスはセキュリティー・ロールによって保護されます。デフォルトでは、サーバー構成ツールにより管理者ロールを持つユーザー (admin) が作成され、このユーザーを使用して、テストのためにコンソールにログインすることができます。セキュリティー・ロールの構成は、サーバー構成ツールで (または Ant タスクで) インストールを実行した後に行わなければなりません。アプリケーション・サーバーで構成する基本レジストリーまたは LDAP レジストリーからのユーザーまたはグループを、各セキュリティー・ロールにマップすることもできます。

Liberty プロファイルおよび WebSphere Application Server、ならびにすべての {{ site.data.keys.product_adj }} アプリケーションに対し、クラス・ローダー委任が「親が最後」に設定されます。この設定は、{{ site.data.keys.product_adj }} アプリケーションにパッケージされたクラスとアプリケーション・サーバーのクラスの間で生じる競合を回避するためのものです。親が最後になるようクラス・ローダーの委任を設定するのを忘れると、手動インストールにおいて頻繁にエラーが発生する原因になります。Apache Tomcat の場合、この宣言は不要です。

Liberty プロファイル内では、JNDI プロパティーとして渡されたパスワードの暗号化解除のために、共通ライブラリーがアプリケーションに追加されます。サーバー構成ツールは、管理サービスの 2 つの必須 JNDI プロパティー (**mfp.config.service.user** および **mfp.config.service.password**) を定義します。これらは、管理サービスがその REST API でライブ更新サービスに接続する際に使用します。他にも JNDI プロパティーを定義して、アプリケーションを調整したり、ご使用のインストール済み環境の詳細にアプリケーションを適応させたりすることができます。詳しくは、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

また、サーバー構成ツールは、プッシュ・サービスとの通信のための JNDI プロパティー (機密クライアントを登録するための URL および OAuth パラメーター) も定義します。  
管理サービス用の表を含むデータベースのデータ・ソース、およびその JDBC ドライバーのライブラリーが宣言されます。

#### ライブ更新サービス
{: #live-update-service }
ライブ更新サービスは、ランタイムおよびアプリケーションの構成に関する情報を保管します。このサービスは管理サービスによって制御されていて、常に管理サービスと同じサーバー上で実行されていなければなりません。コンテキスト・ルートは **context\_root\_of\_admin\_serverconfig** です。そのため、**mfpadminconfig** です。管理サービスはこの規則が順守されていることを想定して、ライブ更新サービスの REST サービスに対するその要求の URL を作成します。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

ライブ更新サービスには 1 つのセキュリティー・ロール **admin_config** があります。そのロールにユーザーをマップする必要があります。そのパスワードおよびログインを、JNDI プロパティー **mfp.config.service.user** および **mfp.config.service.password** で管理サービスに指定してください。JNDI プロパティーについて詳しくは、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)および[{{ site.data.keys.mf_server }} ライブ更新サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service)を参照してください。

Liberty プロファイル上に、JNDI 名を持つデータ・ソースも必要となります。規則は **context\_root\_of\_config\_server/jdbc/ConfigDS** です。このチュートリアルでは、**mfpadminconfig/jdbc/ConfigDS** として定義されています。サーバー構成ツールまたは Ant タスクを使用したインストールの場合、ライブ更新サービスの表は管理サービスの表と同じデータベースおよびスキーマ内にあります。これらの表にアクセスするユーザーも同じです。

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }} が、管理サービスと同じセキュリティー・ロールで宣言されます。{{ site.data.keys.mf_console }} のセキュリティー・ロールにマップされたユーザーは、管理サービスの同じセキュリティー・ロールにもマップされなければなりません。実際に、{{ site.data.keys.mf_console }} はコンソール・ユーザーの代わりに管理サービスに対する照会を実行します。

サーバー構成ツールは 1 つの JNDI プロパティー **mfp.admin.endpoint** を配置します。これはコンソールが管理サービスに接続する方法を指示します。サーバー構成ツールによって設定されるデフォルト値は `*://*:*/mfpadmin` です。この設定は、コンソールへの着信 HTTP 要求と同じプロトコル、ホスト名、およびポートを使用する必要があること、そして管理サービスのコンテキスト・ルートが /mfpadmin であることを意味しています。要求が Web プロキシーを経由するよう強制したい場合は、デフォルト値を変更してください。この URL の可能な値についての詳細情報、およびその他の可能な JNDI プロパティーの情報については、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

#### {{ site.data.keys.product_adj }}runtime
{: #mobilefirst-runtime }
このアプリケーションはセキュリティー・ロールによって保護されていません。このアプリケーションにアクセスするために、Liberty サーバーが認識するユーザーでログインする必要はありません。モバイル・デバイス要求はランタイムに経路指定されます。それらの要求は、他の、製品固有のメカニズム (OAuth など) および {{ site.data.keys.product_adj }} アプリケーションの構成固有のメカニズムにより認証されます。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

Liberty プロファイル上に、JNDI 名を持つデータ・ソースも必要となります。規則は **context\_root\_of\_runtime/jdbc/mfpDS** です。このチュートリアルでは、**mobilefirst/jdbc/mfpDS** として定義されています。サーバー構成ツールまたは Ant タスクを使用したインストールの場合、ランタイムの表は管理サービスの表と同じデータベースおよびスキーマ内にあります。これらの表にアクセスするユーザーも同じです。

#### プッシュ・サービス
{: #push-service }
このアプリケーションは OAuth によって保護されています。サービスに対する HTTP 要求には必ず有効な OAuth トークンが含まれていなければなりません。

OAuth の構成は JNDI プロパティー (許可サーバーの URL、クライアント ID、およびプッシュ・サービスのパスワードなど) を使用して作成されます。また、JNDI プロパティーは、セキュリティー・プラグイン (**mfp.push.services.ext.security**)、およびリレーショナル・データベースが使用されていること (**mfp.push.db.type**) も指示します。モバイル・デバイスからプッシュ・サービスへの要求は、このサービスに経路指定されます。プッシュ・サービスのコンテキスト・ルートは /imfpush でなければなりません。クライアント SDK は、コンテキスト・ルート (**/imfpush**) のランタイムの URL に基づいて、プッシュ・サービスの URL を計算します。プッシュ・サービスをランタイムとは別のサーバーにインストールする場合は、デバイスの要求を該当するアプリケーション・サーバーに経路指定することができる HTTP ルーターが必要です。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

Liberty プロファイル上に、JNDI 名を持つデータ・ソースも必要となります。JNDI 名は **imfpush/jdbc/imfPushDS** です。サーバー構成ツールまたは Ant タスクを使用したインストールの場合、プッシュ・サービスの表は管理サービスの表と同じデータベースおよびスキーマ内にあります。これらの表にアクセスするユーザーも同じです。

#### 他のファイルの変更
{: #other-files-modification }
Liberty プロファイル **jvm.options** ファイルが変更されます。ランタイムが管理サービスと同期する際の JMX でのタイムアウトの問題を回避するために、プロパティー (**com.ibm.ws.jmx.connector.client.rest.readTimeout**) が定義されます。

### インストール済み環境のテスト
{: #testing-the-installation }
インストールが完了した後、この手順を使用して、インストールされたコンポーネントをテストすることができます。

1. コマンド **server start mfp1** を使用してサーバーを始動します。サーバーのバイナリー・ファイルは **liberty\_install\_dir/bin** にあります。
2. Web ブラウザーを使用して {{ site.data.keys.mf_console }} をテストします。[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) に移動します。デフォルトで、サーバーはポート 9080 で稼働します。ただし、**server.xml** ファイルに定義されている `<httpEndpoint>` エレメントでポートを確認できます。ログイン画面が表示されます。

![コンソールのログイン画面](mfpconsole_signin.jpg)

3. **admin/admin** でログインします。このユーザーは、デフォルトでサーバー構成ツールによって作成されます。

    > **注:** HTTP で接続する場合、ログイン ID とパスワードがネットワークで平文で送信されます。セキュアなログインのためには、HTTPS を使用してサーバーにログインしてください。Liberty サーバーの HTTPS ポートは、**server.xml** ファイル内の `<httpEndpoint>` エレメントの httpsPort 属性で確認できます。デフォルトで、この値は 9443 です。

4. **「管理者トップ (Hello Admin)」→「サインアウト (Sign Out)」**で、コンソールをログアウトします。
5. Web ブラウザーに次の URL を入力して、証明書を受け入れます。[https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)デフォルトでは、Web ブラウザーに認識されないデフォルト証明書が Liberty サーバーにより生成されるため、証明書を受け入れる必要があります。Mozilla Firefox はこの認証をセキュリティー例外として提示します。
6. **admin/admin** で再度ログインします。ご使用の Web ブラウザーと {{ site.data.keys.mf_server }} の間では、ログインおよびパスワードが暗号化されます。実動では、HTTP ポートを閉じることもできます。

## {{ site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
このタスクでは、同じ {{ site.data.keys.mf_server }} を実行し、同じデータベースに接続する 2 番目の Liberty サーバーを作成します。実動では、モバイル・アプリケーションがピーク時に必要とする 1 秒 当たりのトランザクション数に対応するのに十分なサーバーを用意するため、パフォーマンス上の理由で複数のサーバーを使用する場合もあります。また、Single Point of Failure を避けるため、高可用性を実現するという理由もあります。

{{ site.data.keys.mf_server }} を実行するサーバーが複数ある場合、サーバーはファームとして構成する必要があります。この構成により、どの管理サービスもファームのすべてのランタイムに接続することが可能になります。クラスターがファームとして構成されていない場合、管理操作を実行する管理サービスと同じアプリケーション・サーバーで実行されるランタイムのみが通知を受けます。その他のランタイムは、変更を認識しません。例えば、ファームとして構成されていないクラスターに、新しいバージョンのアダプターをデプロイした場合、その新しいアダプターにサービスを提供するのは 1 つのサーバーのみです。その他のサーバーは、古いアダプターへのサービス提供を継続します。クラスターを持っていて、ファームを構成する必要がない唯一の状況は、サーバーを WebSphere Application Server Network Deployment にインストールする場合のみです。デプロイメント・マネージャーで JMX Bean を照会することで、管理サービスはすべてのサーバーを見つけることができます。管理操作を行えるようにするには、デプロイメント・マネージャーが実行中でなければなりません。これは、セルの {{ site.data.keys.product_adj }} JMX Bean のリストを提供するのにデプロイメント・マネージャーが使用されるためです。

また、ファームを作成する際、そのファームのすべてのメンバーに対して照会を送信するよう、HTTP サーバーを構成することも必要です。HTTP サーバーの構成は、このチュートリアルには含まれていません。このチュートリアルで扱うのは、管理操作がクラスターのすべてのランタイム・コンポーネントに複製されるようにファームを構成することのみです。

1. 同じコンピューター上に、2 番目の Liberty サーバーを作成します。
    * コマンド・ラインを開始します。
    * **liberty\_install\_dir/bin** に移動し、server create **mfp2** と入力します。

2. サーバー **mfp2** の HTTP ポートおよび HTTPS ポートを変更して、サーバー **mfp1** のポートと競合しないようにします。
    * 2 番目のサーバーのディレクトリーに移動します。

        ディレクトリーは **liberty\_install\_dir/usr/servers/mfp2** または **WLP\_USER\_DIR/servers/mfp2** (『WebSphere Application Server Liberty Core のインストール』のステップ 6 に説明されたようにディレクトリーを変更した場合) です。
    * **server.xml** ファイルを編集します。 置換は、

      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9080"
        httpsPort="9443" />
      ```
        
      これを以下のように置き換えます。
        
      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9081"
        httpsPort="9444" />
      ```
        
      この変更により、サーバー mfp2 の HTTP ポートおよび HTTPS ポートはサーバー mfp1 のポートと競合しなくなります。{{ site.data.keys.mf_server }} のインストールを実行する前に必ずポートを変更するようにしてください。 そうでない場合、インストールが完了した後にポートを変更するのであれば、JNDI プロパティー **mfp.admin.jmx.port** にもポートの変更を反映させなければなりません。

3. [Ant タスクを使用した {{ site.data.keys.mf_server }} の Liberty へのデプロイ](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)で使用した Ant ファイルをコピーして、プロパティー **appserver.was85liberty.serverInstance** の値を **mfp2** に変更します。Ant タスクはデータベースが存在することを検出し、表を作成しません (以下のログ抽出を参照)。次に、アプリケーションがサーバーにデプロイされます。  

   ```bash
[configuredatabase] スキーマ 'MFPDATA' およびユーザー 'mfpuser' で MobileFirstAdmin データベース MFPDATA への接続をチェックしています...
[configuredatabase] データベース MFPDATA が存在します。
   [configuredatabase] スキーマ 'MFPDATA' およびユーザー 'mfpuser' での MobileFirstAdmin データベース MFPDATA への接続が成功しました。
   [configuredatabase] MobileFirstAdmin データベース MFPDATA のバージョンを取得しています...
   [configuredatabase] 表 MFPADMIN_VERSION が存在し、その値をチェックしています...
   [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
   [configuredatabase] MobileFirstAdmin データベース MFPDATA を構成しています...
   [configuredatabase] データベースは最新バージョン (8.0.0) です。アップグレードは必要ありません。
   [configuredatabase] MobileFirstAdmin データベース MFPDATA の構成が正常終了しました。
   ```

4. HTTP 接続で 2 つのサーバーをテストします。
    * Web ブラウザーを開きます。
    * 次の URL を入力します。[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)コンソールはサーバー mfp1 によってサービスを提供されます。
    * **admin/admin** でログインします。
    * 同じ Web ブラウザーでタブを開いて、次の URL を入力します。 [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole)コンソールはサーバー mfp2 によってサービスを提供されます。
    * admin/admin でログインします。インストールが正しく行われると、ログイン後、両方のタブで同じウェルカム・ページが表示されます。
    * 最初のブラウザー・タブに戻り、**「管理者トップ (Hello, Admin)」→「監査ログのダウンロード (Download Audit Log)」**をクリックします。コンソールからログアウトし、ログイン画面が再度表示されます。 このログアウトの動作は、問題点です。この問題が発生するのは、サーバー mfp2 にログオンする際に Lightweight Third Party Authentication (LTPA) トークンが作成され、ご使用のブラウザーに Cookie として保管されるためです。しかし、この LTPA トークンはサーバー mfp1 からは認識されません。クラスターの前に HTTP ロード・バランサーがある場合、実稼働環境ではサーバーの切り替えが行われる可能性があります。この問題を解決するには、両方のサーバー (mfp1 および mfp2) が同じ秘密鍵を使用して LTPA トークンを生成するようにしなければなりません。LTPA 鍵をサーバー mfp1 からサーバー mfp2 にコピーしてください。
    
        * 以下のコマンドで両方のサーバーを停止します。
        
          ```bash
          server stop mfp1
          server stop mfp2
          ```
        
        * サーバー mfp1 の LTPA 鍵をサーバー mfp2 にコピーします。
            **liberty\_install\_dir/usr/servers** または **WLP\_USER\_DIR/servers** から、オペレーティング・システムに応じて以下のコマンドを実行してください。 
            * UNIX の場合: `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
            * Windows の場合: `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * サーバーを再始動します。1 つのブラウザー・タブから別のブラウザー・タブに切り替えても、再度ログインを要求されることはありません。Liberty サーバー・ファームでは、すべてのサーバーが同じ LTPA 鍵を持っている必要があります。
    
5. Liberty サーバー間の JMX 通信を使用可能にします。

    Liberty との JMX 通信は、Liberty REST コネクター経由で、HTTPS プロトコルを使用して行われます。この通信を使用可能にするには、ファームの各サーバーが他のメンバーの SSL 証明書を認識できなければなりません。トラストストア内の HTTPS 証明書を交換する必要があります。IBM ユーティリティー (**java/bin** 内の IBM JRE ディストリビューションの一部である Keytool など) を使用して、トラストストアを構成します。鍵ストアおよびトラストストアのロケーションは、**server.xml** ファイルに定義されています。デフォルトで、Liberty プロファイルの鍵ストアは **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks** にあります。**server.xml** ファイルで確認できるとおり、このデフォルトの鍵ストアのパスワードは **mobilefirst** です。
        
    > **ヒント:** このパスワードは Keytool ユーティリティーで変更できますが、Liberty サーバーがその鍵ストアを読み取れるように、server.xml ファイルでもパスワードの変更を行う必要があります。このチュートリアルでは、デフォルトのパスワードを使用します。

    
    * **WLP\_USER\_DIR/servers/mfp1/resources/security** で、`keytool -list -keystore key.jks` と入力します。このコマンドにより、鍵ストア内の証明書が表示されます。存在するのは **default** という名前の証明書 1 つのみです。鍵が表示される前に、鍵ストアのパスワード (mobilefirst) を要求されます。これは、Keytool ユーティリティーを使用する次のすべてのコマンドに当てはまります。
    * 次のコマンドを使用して、サーバー mfp1 のデフォルト証明書をエクスポートします。`keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`
    * **WLP\_USER\_DIR/servers/mfp2/resources/security** で、次のコマンドを使用してサーバー mfp2 のデフォルト証明書をエクスポートします。`keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`
    * 同じディレクトリーで、次のコマンドを使用してサーバー mfp1 の証明書をインポートします。`keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`。サーバー mfp1 の証明書がサーバー mfp2 の鍵ストアにインポートされ、サーバー mfp2 がサーバー mfp1 への HTTPS 接続を信頼できるようになります。この証明書を信頼するかどうか確認を求められます。
    * **WLP\_USER\_DIR/servers/mfp1/resources/security** で、次のコマンドを使用してサーバー mfp2 の証明書をインポートします。`keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`このステップの後、2 つのサーバー間の HTTPS 接続が可能になります。

## ファームのテストと {{ site.data.keys.mf_console }} での変更内容の確認
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. 以下の 2 つのサーバーを始動します。

   ```bash
   server start mfp1
   server start mfp2
   ```
        
2. コンソールにアクセスします。例えば、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)、または HTTPS では [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) です。左側のサイドバーに、**「サーバー・ファームのノード」**という名前の追加メニューが表示されます。**「サーバー・ファームのノード」**をクリックすると、各ノードの状況を表示できます。両方のノードが始動するまで、しばらく待たなければならない場合があります。
