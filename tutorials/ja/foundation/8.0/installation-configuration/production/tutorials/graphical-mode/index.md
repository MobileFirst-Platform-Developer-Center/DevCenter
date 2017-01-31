---
layout: tutorial
title: グラフィカル・モードでの MobileFirst Server のインストールに関するチュートリアル
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
グラフィカル・モードの IBM Installation Manager とサーバー構成ツールを使用して、{{site.data.keys.mf_server }} をインストールします。

#### 始める前に
{: #before-you-begin }
* 以下のいずれかのデータベースおよびサポート対象の Java バージョンがインストール済みであることを確認してください。また、そのデータベースに対応する JDBC ドライバーがご使用のコンピューターで使用可能である必要があります。
    * サポート対象のデータベース・リストにあるデータベース管理システム (DBMS)
        * DB2 
        * MySQL 
        * Oracle 

        **重要:** 本製品で必要とされる表の作成場所となるデータベース、およびそのデータベースで表を作成できるデータベース・ユーザーが必要となります。



        このチュートリアルにおける表の作成手順は DB2 を対象にしています。DB2 インストーラーは、[IBM パスポート・アドバンテージで](http://www.ibm.com/software/passportadvantage/pao_customers.htm) {{site.data.keys.product }} eAssembly のパッケージとして提供されています。  
        
* ご使用のデータベースの JDBC ドライバー:
    * DB2 の場合、DB2 JDBC ドライバー・タイプ 4 を使用します。
    * MySQL の場合、Connector/J JDBC ドライバーを使用します。
    * Oracle の場合、Oracle Thin JDBC ドライバーを使用します。

* Java 7 以降。

* IBM Installation Manager V1.8.4 以降のインストーラーは、[Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142) からダウンロードします。
* また、{{site.data.keys.mf_server }} のインストール・リポジトリーおよび WebSphere Application Server Liberty Core V8.5.5.3 以降のインストーラーも必要です。これらのパッケージを、パスポート・アドバンテージの {{site.data.keys.product }} eAssembly からダウンロードします。

**{{site.data.keys.mf_server }} のインストール・リポジトリー**  
{{site.data.keys.mf_server }} 用の Installation Manager リポジトリーの {{site.data.keys.product }} V8.0 .zip ファイル

**WebSphere Application Server Liberty プロファイル**  
IBM WebSphere Application Server - Liberty Core V8.5.5.3 以降
    
以下のいずれかのオペレーティング・システムをご使用の場合、グラフィカル・モードでインストールを実行できます。

* Windows x86 または x86-64
* macOS x86-64
* Linux x86 または Linux x86-64

その他のオペレーティング・システムをご使用の場合でも、グラフィカル・モードで Installation Manager を使用してインストールを実行できますが、サーバー構成ツールは使用できません。Ant タスクを使用して (説明については[コマンド・ライン・モードでの {{site.data.keys.mf_server }} のインストール](../command-line)を参照)、{{site.data.keys.mf_server }} を Liberty プロファイルにデプロイする必要があります。

**注:** データベースのインストールおよびセットアップについての説明は、このチュートリアルには含まれていません。スタンドアロン・データベースをインストールせずにこのチュートリアルを実行する場合は、組み込みの Derby データベースを使用できます。ただし、このデータベースの使用には以下の制限があります。


* グラフィカル・モードで Installation Manager を実行することは可能ですが、サーバーをデプロイするには、このチュートリアルのコマンド・ラインのセクションまでスキップして Ant タスクでインストールする必要があります。
* サーバー・ファームを構成することはできません。組み込みの Derby データベースは、複数のサーバーからのアクセスをサポートしていません。サーバー・ファームを構成するには、DB2、MySQL、Oracle のいずれかが必要です。

#### ジャンプ先
{: #jump-to }

* [IBM Installation Manager のインストール](#installing-ibm-installation-manager)
* [WebSphere Application Server Liberty Core のインストール](#installing-websphere-application-server-liberty-core)
* [{{site.data.keys.mf_server }} のインストール](#installing-mobilefirst-server)
* [データベースの作成](#creating-a-database)
* [サーバー構成ツールの実行](#running-the-server-configuration-tool)
* [インストール済み環境のテスト](#testing-the-installation)
* [{{site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [ファームのテストと {{site.data.keys.mf_console }} での変更内容の確認](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

### IBM Installation Manager のインストール
{: #installing-ibm-installation-manager }
Installation Manager V1.8.4 以降をインストールする必要があります。製品のポストインストール操作で Java 7 が必要なため、古いバージョンの Installation Manager は {{site.data.keys.product }} V8.0 をインストールできません。古いバージョンの Installation Manager には Java 6 が装備されています。

1. ダウンロードした IBM Installation Manager アーカイブを解凍します。インストーラーは [Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142) にあります。
2. 以下のように Installation Manager をインストールします。
    * **install.exe** を実行して、管理者として Installation Manager をインストールします。Linux または UNIX では root が必要です。Windows では、管理者特権が必要です。このモードでは、インストール済みパッケージに関する情報はディスク上の共有ロケーションに置かれ、Installation Manager の実行を許可されたユーザーなら誰でも、アプリケーションを更新することができます。
    * ユーザー・モードで Installation Manager をインストールするには、**userinst.exe** を実行します。特定の特権は必要ありません。ただし、このモードでは、インストール済みパッケージに関する情報は、ユーザーのホーム・ディレクトリーに置かれます。Installation Manager でインストールされるアプリケーションの更新を行えるのは、そのユーザーのみです。

### WebSphere Application Server Liberty Core のインストール
{: #installing-websphere-application-server-liberty-core }
WebSphere Application Server Liberty Core のインストーラーは、{{site.data.keys.product }} のパッケージの一部として提供されています。このタスクでは、Liberty プロファイルがインストールされ、サーバー・インスタンスが作成されます。このサーバー・インスタンス上に {{site.data.keys.mf_server }} をインストールできます。

1. ダウンロードした WebSphere Application Server Liberty Core の圧縮ファイルを解凍します。
2. Installation Manager を起動します。
3. リポジトリーを Installation Manager 内に追加します。
    * **「ファイル」→「設定」に移動して「リポジトリーの追加 (Add Repositories...)」**をクリックします。
    * インストーラーが解凍されたディレクトリー内にある **diskTag.inf** ファイルの **repository.config** ファイルを参照します。
    * ファイルを選択し、**「OK」**をクリックします。
    * **「OK」**をクリックして、「設定」パネルを閉じます。
4. **「インストール」**をクリックして Liberty をインストールします。
    * **「IBM WebSphere Application Server Liberty Core」**を選択し、
**「次へ」**をクリックします。
    * 使用条件の条項に同意し、**「次へ」**をクリックします。
5. このチュートリアルの対象範囲では、確認を求められたとき、追加のアセットのインストールは必要ありません。**「インストール」**をクリックすると、インストール・プロセスが開始します。
    * 正常にインストールされた場合は、プログラムにより、インストールが正常に行われたことを示すメッセージが
表示されます。プログラムは、重要なポストインストール指示も表示することがあります。
    * インストールが正常に行われなかった場合は、**「ログ・ファイルの表示」**を
クリックして、問題のトラブルシューティングを行います。
6. サーバーを含む **usr** ディレクトリーを、特定の特権が必要とされないロケーションに移動します。

    Liberty を管理者モードで Installation Manager を使用してインストールした場合、非管理者ユーザーまたは非 root ユーザーがファイルの変更を行えない場所にファイルが置かれています。このチュートリアルの目的で、サーバーを含む **usr** ディレクトリーを、特定の特権が必要とされない場所に移動してください。そうすることで、特定の特権がなくてもインストールの操作を行うことができます。
    * Liberty のインストール・ディレクトリーに移動します。
    * **etc** という名前のディレクトリーを作成します。管理者または root の特権が必要です。
    * **etc** ディレクトリー内に、`WLP_USER_DIR=<どのユーザーでも書き込めるディレクトリーのパス>` というコンテンツを含む **server.env** ファイルを作成します。
    
    例えば、Windows の場合は、`WLP_USER_DIR=C:\LibertyServers\usr` です。
7. チュートリアルのこの後のパートで {{site.data.keys.mf_server }} の最初のノードのインストールに使用する Liberty サーバーを作成します。
    * コマンド・ラインを開始します。
    * l**iberty\_install\_dir/bin** に移動し、`server create mfp1` と入力します。
    
    このコマンドにより、mfp1 という名前の Liberty サーバー・インスタンスが作成されます。その定義は、**liberty\_install\_dir/usr/servers/mfp1** または **WLP\_USER\_DIR/servers/mfp1** (ステップ 6 の説明に従ってディレクトリーを変更した場合) にあります。
    
サーバーの作成後、このサーバーは **liberty\_install\_dir/bin/** から `server start mfp1` で始動することができます。サーバーを停止するには、**liberty\_install\_dir/bin/** からコマンド `server stop mfp1` を入力します。  
デフォルトのホーム・ページは http://localhost:9080 で表示できます。

> **注:** 実動用には、ホスト・コンピューターの始動時に Liberty サーバーがサービスとして始動するようにする必要があります。Liberty サーバーをサービスとして始動させる手順は、このチュートリアルには含まれていません。

### {{site.data.keys.mf_server }} のインストール
{: #installing-mobilefirst-server }
データベースを作成して {{site.data.keys.mf_server }} を Liberty プロファイルにデプロイする前に、Installation Manager を実行してご使用のディスクに {{site.data.keys.mf_server }} のバイナリー・ファイルをインストールします。Installation Manager を使用した {{site.data.keys.mf_server }} のインストール中に、{{site.data.keys.mf_app_center }} をインストールするオプションが提案されます。 Application Center は、本製品の別のコンポーネントです。このチュートリアルでは、これを {{site.data.keys.mf_server }} と共にインストールする必要はありません。

1. Installation Manager を起動します。
2. {{site.data.keys.mf_server }} のリポジトリーを Installation Manager 内に追加します。
    * **「ファイル」→「設定」に移動して「リポジトリーの追加 (Add Repositories...)」**をクリックします。
    * インストーラーが解凍されたディレクトリー内にあるリポジトリー・ファイルを参照します。

        {{site.data.keys.mf_server }} の {{site.data.keys.product }} V8.0 .zip ファイルを **mfp\_installer\_directory** フォルダーで解凍すると、リポジトリー・ファイルは **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf** にできます。

        [IBM サポート・ポータル](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)からダウンロード可能な最新のフィックスパックを適用することもできます。フィックスパック用のリポジトリーを入力するようにしてください。**fixpack_directory** フォルダーにフィックスパックを解凍した場合、リポジトリー・ファイルは **fixpack_directory/MobileFirst_Platform_Server/disk1/diskTag.inf** にあります。
    
        > **注:** Installation Manager のリポジトリー内に基本バージョンのリポジトリーが存在しないと、フィックスパックをインストールすることができません。対象のフィックスパックは差分インストーラーで、インストールを行うのに基本バージョンのリポジトリーを必要とします。
    * ファイルを選択し、**「OK」**をクリックします。
    * **「OK」**をクリックして、「設定」パネルを閉じます。

3. 製品のライセンス条項に同意した後、**「次へ (Next)」**をクリックします。
4. **「新規パッケージ・グループの作成 (Create a new package group)」**オプションを選択し、その新規パッケージ・グループ内に製品をインストールします。
5. **「次へ」**をクリックします。
6. **「汎用設定 (General settings)」**パネルの**「トークン・ライセンスのアクティブ化 (Activate token licensing)」**セクションで、**「Rational License Key Server でトークン・ライセンスをアクティブ化しない (Do not activate token licensing with the Rational License Key Server)」**オプションを選択します。

    このチュートリアルでは、トークン・ライセンスが不要であることを前提としています。そのため、{{site.data.keys.mf_server }} をトークン・ライセンス用に構成する手順は含まれていません。ただし、実動インストールでは、トークン・ライセンスをアクティブ化する必要があるかどうかを判断する必要があります。Rational License Key Server でトークン・ライセンスを使用する契約がある場合は、「Rational License Key Server でトークン・ライセンスをアクティブにする (Activate token licensing with the Rational License Key Server)」オプションを使用してください。トークン・ライセンスをアクティブ化した後、追加のステップを実行して {{site.data.keys.mf_server }} を構成する必要があります。
7. **「汎用設定 (General settings)」**パネルの**「{{site.data.keys.product }} for iOS** のインストール」セクションで、デフォルト・オプション (「いいえ」) をそのままにします。
8. **「構成の選択」**パネルで「いいえ (No)」オプションを選択し、Application Center がインストールされないようにします。実動インストールの場合は、Ant タスクを使用して Application Center をインストールしてください。Ant タスクを使用したインストールでは、{{site.data.keys.mf_server }} に対する更新を Application Center に対する更新から分離することができます。
9. **「ありがとうございました (Thank You)」**パネルが表示されるまで、**「次へ (Next)」**をクリックします。 その後、インストールを続行します。

{{site.data.keys.product_adj }} コンポーネントをインストールするためのリソースを含むインストール・ディレクトリーがインストールされます。  
リソースは以下のフォルダーに入っています。

* {{site.data.keys.mf_server }} 用の MobileFirstServer フォルダー
* {{site.data.keys.mf_server }} プッシュ・サービス用の PushService フォルダー
* Application Center 用の ApplicationCenter フォルダー
* {{site.data.keys.mf_analytics }} 用の Analytics フォルダー

このチュートリアルの目的は、**MobileFirstServer** フォルダー内のリソースを使用して {{site.data.keys.mf_server }} をインストールすることです。  
また、**shortcuts** フォルダーには、サーバー構成ツール、Ant、および mfpadm プログラムのショートカットも用意されています。

### データベースの作成
{: #creating-a-database }
このタスクでは、ご使用の DBMS にデータベースが存在するようにし、ユーザーがそのデータベースの使用、データベース内での表の作成、およびその表の使用を許可されるようにします。  
このデータベースは、さまざまな {{site.data.keys.product_adj }} コンポーネントが使用するテクニカル・データを保管するのに使用します。

* {{site.data.keys.mf_server }} 管理サービス
* {{site.data.keys.mf_server }} ライブ更新サービス
* {{site.data.keys.mf_server }} プッシュ・サービス
* {{site.data.keys.product_adj }}runtime

このチュートリアルでは、すべてのコンポーネント用の表が同じスキーマに置かれています。サーバー構成ツールは同じスキーマ内に表を作成します。より柔軟に対応するには、Ant タスクを使用するか、手動インストールを行うこともできます。

> **注:** このタスクの手順は、DB2 用です。MySQL または Oracle を使用する予定である場合は、[データベース要件](../../databases/#database-requirements)を参照してください。

1. DB2 サーバーを実行しているコンピューターにログオンします。DB2 ユーザー (例えば **mfpuser** という名前のユーザー) が存在することを想定しています。
2. この DB2 ユーザーが 32768 以上のページ・サイズのデータベースへのアクセス権限を付与されていること、またそのデータベース内に暗黙的なスキーマおよび表を作成できることを確認してください。

    デフォルトで、このユーザーは、DB2 を実行するコンピューターのオペレーティング・システムで宣言されたユーザーです。つまり、そのコンピューターへのログインができるユーザーです。そのようなユーザーが存在する場合、次のステップ 3 で説明するアクションは不要です。 チュートリアルのこの後のパートで、本製品が必要とするすべての表が、サーバー構成ツールによってそのデータベースのスキーマ内に作成されます。

3. このインストール済み環境用の正しいページ・サイズのデータベースがなければ、作成してください。
    * `SYSADM` 権限または `SYSCTRL` 権限を持つユーザーでセッションを開きます。例えば、DB2 インストーラーによって作成されたデフォルトの管理ユーザーであるユーザー **db2inst1** を使用します。
    * 次のように、DB2 コマンド・ライン・プロセッサーを開きます。
        * Windows システムでは、**「開始 (Start)」→「IBM DB2」→「コマンド・ライン・プロセッサー (Command Line Processor)」**とクリックします。
        * Linux システムまたは UNIX システムでは、**~/sqllib/bin** (または、管理者のホーム・ディレクトリーに **sqllib** が作成されていなければ **db2\_install\_dir/bin**) に移動し、`./db2` と入力します。
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
        
別のユーザー名を定義した場合は、mfpuser を独自のユーザー名に置き換えます。  

> **注:** このステートメントにより、デフォルトの DB2 データベースで PUBLIC に付与されたデフォルトの特権が削除されることはありません。実動では、そのデータベース内の特権を、本製品の最小要件まで減らすことが必要になる場合もあります。DB2 セキュリティーおよびセキュリティーの実施例について詳しくは、[DB2 security, Part 8: Twelve DB2 security best practices](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/) を参照してください。

### サーバー構成ツールの実行
{: #running-the-server-configuration-tool }
サーバー構成ツールを使用して、以下の操作を実行します。

* データベース内に {{site.data.keys.product_adj }} アプリケーションで必要となる表を作成します。
* {{site.data.keys.mf_server }} の Web アプリケーション (ランタイム、管理サービス、ライブ更新サービス、プッシュ・サービスのコンポーネント、および {{site.data.keys.mf_console }}) を Liberty サーバーにデプロイします。

サーバー構成ツールは以下の {{site.data.keys.product_adj }} アプリケーションをデプロイしません。

#### {{site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{site.data.keys.mf_analytics }} はメモリー所要量が大きいため、通常 {{site.data.keys.mf_server }} とは別のサーバー・セットにデプロイされます。{{site.data.keys.mf_analytics }} は、手動で、もしくは Ant タスクを使用してインストールできます。既にインストール済みの場合は、サーバー構成ツールでその URL、ユーザー名、およびパスワードを入力し、それにデータを送信できるようにします。それにより、サーバー構成ツールが {{site.data.keys.mf_analytics }} にデータを送信するように {{site.data.keys.product_adj }} アプリを構成します。 

#### Application Center
{: #application-center }
このアプリケーションは、社内でモバイル・アプリを使用する従業員に配布するのに使用したり、テスト目的に使用したりできます。これは {{site.data.keys.mf_server }} とは独立していて、{{site.data.keys.mf_server }} と一緒にインストールする必要はありません。
    
1. サーバー構成ツールを始動します。
    * Linux の場合、アプリケーションのショートカットから**「アプリケーション」→「{{site.data.keys.mf_server }}」→「サーバー構成ツール」**とクリックします。
    * Windows の場合、**「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * macOS の場合、シェル・コンソールを開きます。**mfp_server\_install\_dir/shortcuts and type ./configuration-tool.sh** に移動します。
    
    mfp_server_install_dir ディレクトリーが、{{site.data.keys.mf_server }} をインストールした場所です。
2. **「ファイル (File)」→「新規構成 (New Configuration)」**を選択して {{site.data.keys.mf_server }} 構成を作成します。
3. 構成に 「Hello MobileFirst」という名前を付けて、**「OK」**をクリックします。
4. 「構成の詳細 (Configuration Details)」のデフォルト項目をそのままにして、**「次へ」**をクリックします。
    
    このチュートリアルでは、環境 ID は使用しません。それは上級のデプロイメント・シナリオ用のフィーチャーです。  
    そのようなシナリオの一例としては、{{site.data.keys.mf_server }} の複数インスタンスおよび管理サービスを同じアプリケーション・サーバーまたは WebSphere Application Server セル内にインストールする場合などが挙げられます。
5. 管理サービスとランタイム・コンポーネントのデフォルト・コンテキスト・ルートを保持します。
6. **「コンソール設定」**パネルのデフォルト項目は変更せず、**「次へ」**をクリックしてデフォルト・コンテキスト・ルートで {{site.data.keys.mf_console }} をインストールします。
7. **「IBM DB2」**をデータベースとして選択し、**「次へ」**をクリックします。
8. **「DB2 データベース設定 (DB2 Database Settings)」**パネルで、以下の詳細を入力します。
    * DB2 サーバーを実行するホスト名を入力します。ご使用のコンピューター上で実行する場合は、**localhost** と入力できます。
    * 使用する予定の DB2 インスタンスがデフォルト・ポート (50000) を listen していない場合は、ポート番号を変更します。
    * DB2 JDBC ドライバーへのパスを入力します。DB2 の場合、**db2jcc4.jar** という名前のファイルが求められます。また、同じディレクトリー内に **db2jcc\_license\_cu.jar** ファイルも存在する必要があります。標準の DB2 ディストリビューションでは、これらのファイルは **db2\_install\_dir/java** 内にあります。
    * **「次へ」**をクリックします。

    入力された資格情報で DB2 サーバーに到達できない場合、サーバー構成ツールにより **「次へ」**ボタンが使用不可にされ、エラーが表示されます。求められるクラスが JDBC ドライバーに含まれていない場合も、**「次へ」**ボタンは使用不可になります。すべてが適切であれば、**「次へ」**ボタンが使用可能になります。
    
9. **「DB2 追加設定 (DB2 Additional Settings)」**パネルで、以下の詳細を入力します。
    * DB2 のユーザー名およびパスワードとして **mfpuser** を入力します。独自の DB2 ユーザー名が **mfpuser** でない場合は、そのユーザー名を使用します。
    * データベースの名前として **MFPDATA** を入力します。
    * **MFPDATA** を、表の作成場所となるスキーマとしてそのまま保持します。**「次へ」**をクリックします。デフォルトで、サーバー構成ツールは値 **MFPDATA** を提案します。
10. **「データベース作成要求」**パネルでは何も値を入力せず、**「次へ」**をクリックします。

    このペインは、前のペインで入力されたデータベースが DB2 サーバーに存在しない場合に使用します。その場合、DB2 管理者のユーザー名とパスワードを入力できます。サーバー構成ツールは DB2 サーバーへの SSH セッションを開き、[データベースの作成](#creating-a-database)で説明したコマンドを実行して、デフォルト設定および正しいページ・サイズでデータベースを作成します。
11. **「アプリケーション・サーバー選択 (Application Server Selection)」**パネルで**「WebSphere Application Server」**オプションを選択し、**「次へ」**をクリックします。
12. **「アプリケーション・サーバー設定 (Application Server Settings)」**パネルで、以下の詳細を入力します。
    * WebSphere Application Server Liberty のインストール・ディレクトリーを入力します。
    * サーバー名フィールドで、製品のインストール先にするサーバーを選択します。[WebSphere Application Server Liberty Core のインストール](#installing-websphere-application-server-liberty-core)のステップ 7 で作成された **mfp1** サーバーを選択します。
    * **「ユーザーの作成 (Create a user)」**オプションを、そのデフォルト値で選択されたままにします。
    
    このオプションにより Liberty サーバーの基本レジストリー内にユーザーが作成され、{{site.data.keys.mf_console }} または管理サービスにサインインできるようになります。実動インストールの場合はこのオプションを使用せず、『{{site.data.keys.mf_server }} 管理用のユーザー認証の構成』の説明のとおり、インストール後にアプリケーションのセキュリティー・ロールを構成します。
    * デプロイメント・タイプに「サーバー・ファーム・デプロイメント」オプションを選択します。
    * **「次へ」**をクリックします。
13. **「プッシュ・サービスのインストール (Install the Push service)」**オプションを選択します。

    プッシュ・サービスがインストールされている場合は、管理サービスからプッシュ・サービスへ、ならびに管理サービスおよびプッシュ・サービスからランタイム・コンポーネントへの HTTP フローまたは HTTPS フローが必要です。
14. **「プッシュ・サービスおよび許可サービスの URL を自動計算する (Have the Push and Authorization Service URLs computed automatically)」**オプションを選択します。

    このオプションが選択されている場合、サーバー構成ツールはアプリケーションを、同じサーバーにインストール済みのアプリケーションに接続するように構成します。クラスターを使用する場合は、ご使用の HTTP ロード・バランサーからサービスへの接続に使用する URL を入力してください。 WebSphere Application Server Network Deployment にインストールする場合は、URL の手動入力が必須です。
15. **「管理サービスとプッシュ・サービスの間のセキュア通信のための資格情報 (Credentials for secure communication between the Administration and the Push service)」**のデフォルト項目を、そのまま保持します。

    プッシュ・サービスと管理サービスを許可サーバー (デフォルトではランタイム・コンポーネント) の機密 OAuth クライアントとして登録するには、クライアント ID とパスワードが必要です。サーバー構成ツールが各サービス用に ID とランダム・パスワードを生成します。この入門チュートリアル用には、それらをそのまま保持することができます。
16. **「次へ」**をクリックします。
17. **「Analytics 設定 (Analytics Setting)」**パネルでデフォルト項目をそのまま保持します。

    Analytics サーバーへの接続を使用可能にするには、まず {{site.data.keys.mf_analytics }} をインストールする必要があります。 ただし、インストールはこのチュートリアルの対象範囲に含まれていません。
18. **「デプロイ」**をクリックします。

実行された操作の詳細を、**「コンソール・ウィンドウ」**で確認できます。  
Ant ファイルが保存されます。サーバー構成ツールは、構成のインストールと更新のための Ant ファイルの作成を支援します。この Ant ファイルは、**「ファイル」→「構成を Ant ファイルとしてエクスポート...(Export Configuration as Ant Files...)」**を使用してエクスポートできます。この Ant ファイルについて詳しくは、『[コマンド・ライン・モードでの](../command-line) {{site.data.keys.mf_server }} のインストール』の『Ant タスクを使用した {{site.data.keys.mf_server }} の Liberty へのデプロイ』を参照してください。

その後、この Ant ファイルが実行され、以下の操作が行われます。

1. 以下のコンポーネントの表が、データベース内に作成されます。
    * 管理サービスおよびライブ更新サービス。**admdatabases** Ant ターゲットにより作成。
    * ランタイム。**rtmdatabases** Ant ターゲットにより作成。
    * プッシュ・サービス。pushdatabases Ant ターゲットにより作成。
2. さまざまなコンポーネントの WAR ファイルが、Liberty サーバーにデプロイされます。操作の詳細は、**adminstall**、**rtminstall**、および **pushinstall** ターゲットの下のログで確認できます。

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
実動用には、手動で表を作成することもできます。例えば、DBA がデフォルトの設定値の一部をオーバーライドしたい場合や、特定の表スペースを割り当てたい場合などがそうです。表の作成に使用するデータベース・スクリプトは、 **mfp\_server\_install\_dir/MobileFirstServer/databases** および **mfp_server\_install\_dir/PushService/databases** にあります。詳しくは、[データベース表の手動作成](../../databases/#create-the-database-tables-manually)を参照してください。

**server.xml** ファイルおよび何らかのアプリケーション・サーバーの設定が、インストール中に変更されます。それぞれの変更の前に、**server.xml** ファイルのコピー (**server.xml.bak**、**server.xml.bak1**、**server.xml.bak2** など) が作成されます。追加された内容をすべて確認するには、**server.xml** ファイルを最も古いバックアップ (server.xml.bak) と比較することができます。Linux では、コマンド `--strip-trailing-cr server.xml server.xml.bak` を使用してその差異を確認します。AIX では、コマンド `diff server.xml server.xml.bak` を使用してその差異を確認します。

#### アプリケーション・サーバーの設定の変更 (Liberty に固有):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Liberty のフィーチャーが追加されます。

    それらのフィーチャーは各アプリケーションに対して追加され、重複することがあります。例えば、JDBC フィーチャーは、管理サービスとランタイム・コンポーネントの両方に使用されます。この重複があることで、アプリケーションをアンインストールするとき、他のアプリケーションを中断せずにそのフィーチャーを削除することができます。例えば、ある時点でプッシュ・サービスをサーバーからアンインストールして別のサーバーにインストールすることにした場合などがそうです。ただし、すべてのトポロジーが可能というわけではありません。管理サービス、ライブ更新サービス、およびランタイム・コンポーネントは、Liberty プロファイルのある同じアプリケーション・サーバー上にある必要があります。詳しくは、[{{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、および {{site.data.keys.product_adj }} ランタイムでの制約](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)を参照してください。フィーチャーが重複していても、追加されたフィーチャー同士が競合しなければ、問題は生じません。jdbc-40 および jdbc-41 のフィーチャーを追加すると問題が生じますが、同じフィーチャーを 2 回追加すると問題は生じません。
    
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
* **mfpconsole**、{{site.data.keys.mf_console }}
* **mobilefirs**t、{{site.data.keys.product_adj }} ランタイム・コンポーネント
* **imfpush**、プッシュ・サービス

サーバー構成ツールはすべてのアプリケーションを同じサーバーにインストールします。アプリケーションを別のアプリケーション・サーバーに分離することもできますが、[トポロジーとネットワーク・フロー](../../topologies)に記載された特定の制約を受けることになります。  
別々のサーバーにインストールする場合は、サーバー構成ツールを使用することはできません。Ant タスクを使用するか、手動で製品をインストールしてください。

#### 管理サービス
{: #administration-service }
管理サービスは、{{site.data.keys.product_adj }} のアプリケーション、アダプター、およびその構成を管理するためのサービスです。このサービスはセキュリティー・ロールによって保護されます。デフォルトでは、サーバー構成ツールにより管理者ロールを持つユーザー (admin) が作成され、このユーザーを使用して、テストのためにコンソールにログインすることができます。セキュリティー・ロールの構成は、サーバー構成ツールで (または Ant タスクで) インストールを実行した後に行わなければなりません。アプリケーション・サーバーで構成する基本レジストリーまたは LDAP レジストリーからのユーザーまたはグループを、各セキュリティー・ロールにマップすることもできます。

Liberty プロファイルおよび WebSphere Application Server、ならびにすべての {{site.data.keys.product_adj }} アプリケーションに対し、クラス・ローダー委任が「親が最後」に設定されます。この設定は、{{site.data.keys.product_adj }} アプリケーションにパッケージされたクラスとアプリケーション・サーバーのクラスの間で生じる競合を回避するためのものです。親が最後になるようクラス・ローダーの委任を設定するのを忘れると、手動インストールにおいて頻繁にエラーが発生する原因になります。Apache Tomcat の場合、この宣言は不要です。

Liberty プロファイル内では、JNDI プロパティーとして渡されたパスワードの暗号化解除のために、共通ライブラリーがアプリケーションに追加されます。サーバー構成ツールは、管理サービスの 2 つの必須 JNDI プロパティー (**mfp.config.service.user** および **mfp.config.service.password**) を定義します。これらは、管理サービスがその REST API でライブ更新サービスに接続する際に使用します。他にも JNDI プロパティーを定義して、アプリケーションを調整したり、ご使用のインストール済み環境の詳細にアプリケーションを適応させたりすることができます。詳しくは、[{{site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

また、サーバー構成ツールは、プッシュ・サービスとの通信のための JNDI プロパティー (機密クライアントを登録するための URL および OAuth パラメーター) も定義します。  
管理サービス用の表を含むデータベースのデータ・ソース、およびその JDBC ドライバーのライブラリーが宣言されます。

#### ライブ更新サービス
{: #live-update-service }
ライブ更新サービスは、ランタイムおよびアプリケーションの構成に関する情報を保管します。このサービスは管理サービスによって制御されていて、常に管理サービスと同じサーバー上で実行されていなければなりません。コンテキスト・ルートは **context\_root\_of\_admin\_serverconfig** です。そのため、**mfpadminconfig** です。管理サービスはこの規則が順守されていることを想定して、ライブ更新サービスの REST サービスに対するその要求の URL を作成します。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

ライブ更新サービスには 1 つのセキュリティー・ロール **admin_config** があります。そのロールにユーザーをマップする必要があります。そのパスワードおよびログインを、JNDI プロパティー **mfp.config.service.user** および **mfp.config.service.password** で管理サービスに指定してください。JNDI プロパティーについて詳しくは、[{{site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)および[{{site.data.keys.mf_server }} ライブ更新サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service)を参照してください。

Liberty プロファイル上に、JNDI 名を持つデータ・ソースも必要となります。規則は **context\_root\_of\_config\_server/jdbc/ConfigDS** です。このチュートリアルでは、**mfpadminconfig/jdbc/ConfigDS** として定義されています。サーバー構成ツールまたは Ant タスクを使用したインストールの場合、ライブ更新サービスの表は管理サービスの表と同じデータベースおよびスキーマ内にあります。これらの表にアクセスするユーザーも同じです。

#### {{site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{site.data.keys.mf_console }} が、管理サービスと同じセキュリティー・ロールで宣言されます。{{site.data.keys.mf_console }} のセキュリティー・ロールにマップされたユーザーは、管理サービスの同じセキュリティー・ロールにもマップされなければなりません。実際に、{{site.data.keys.mf_console }} はコンソール・ユーザーの代わりに管理サービスに対する照会を実行します。

サーバー構成ツールは 1 つの JNDI プロパティー **mfp.admin.endpoint** を配置します。これはコンソールが管理サービスに接続する方法を指示します。サーバー構成ツールによって設定されるデフォルト値は `*://*:*/mfpadmin` です。この設定は、コンソールへの着信 HTTP 要求と同じプロトコル、ホスト名、およびポートを使用する必要があること、そして管理サービスのコンテキスト・ルートが /mfpadmin であることを意味しています。要求が Web プロキシーを経由するよう強制したい場合は、デフォルト値を変更してください。この URL の可能な値についての詳細情報、およびその他の可能な JNDI プロパティーの情報については、[{{site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。

管理サービスのセクションで説明されたように、クラス・ローダー委任が「親が最後」に設定されます。

#### {{site.data.keys.product_adj }}runtime
{: #mobilefirst-runtime }
このアプリケーションはセキュリティー・ロールによって保護されていません。このアプリケーションにアクセスするために、Liberty サーバーが認識するユーザーでログインする必要はありません。モバイル・デバイス要求はランタイムに経路指定されます。それらの要求は、他の、製品固有のメカニズム (OAuth など) および {{site.data.keys.product_adj }} アプリケーションの構成固有のメカニズムにより認証されます。

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
Liberty プロファイル jvm.options ファイルが変更されます。ランタイムが管理サービスと同期する際の JMX でのタイムアウトの問題を回避するために、プロパティー (com.ibm.ws.jmx.connector.client.rest.readTimeout) が定義されます。

### インストール済み環境のテスト
{: #testing-the-installation }
インストールが完了した後、この手順を使用して、インストールされたコンポーネントをテストすることができます。

1. コマンド **server start mfp1** を使用してサーバーを始動します。サーバーのバイナリー・ファイルは **liberty\_install\_dir/bin** にあります。
2. Web ブラウザーを使用して {{site.data.keys.mf_console }} をテストします。[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) に移動します。デフォルトで、サーバーはポート 9080 で稼働します。ただし、**server.xml** ファイルで定義されているエレメント `<httpEndpoint>` でポートを確認できます。ログイン画面が表示されます。

![コンソールのログイン画面](mfpconsole_signin.jpg)

3. **admin/admin** でログインします。このユーザーは、デフォルトでサーバー構成ツールによって作成されます。

    > **注:** HTTP で接続する場合、ログイン ID とパスワードがネットワークで平文で送信されます。セキュアなログインのためには、HTTPS を使用してサーバーにログインしてください。Liberty サーバーの HTTPS ポートは、**server.xml** ファイル内の `<httpEndpoint>` エレメントの httpsPort 属性で確認できます。デフォルトで、この値は 9443 です。

4. **「管理者トップ (Hello Admin)」→「サインアウト (Sign Out)」**で、コンソールをログアウトします。
5. Web ブラウザーに次の URL を入力して、証明書を受け入れます。[https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)デフォルトでは、Web ブラウザーに認識されないデフォルト証明書が Liberty サーバーにより生成されるため、証明書を受け入れる必要があります。Mozilla Firefox はこの認証をセキュリティー例外として提示します。
6. **admin/admin** で再度ログインします。ご使用の Web ブラウザーと {{site.data.keys.mf_server }} の間では、ログインおよびパスワードが暗号化されます。実動では、HTTP ポートを閉じることもできます。

### {{site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
このタスクでは、同じ {{site.data.keys.mf_server }} を実行し、同じデータベースに接続する 2 番目の Liberty サーバーを作成します。実動では、モバイル・アプリケーションがピーク時に必要とする 1 秒 当たりのトランザクション数に対応するのに十分なサーバーを用意するため、パフォーマンス上の理由で複数のサーバーを使用する場合もあります。また、Single Point of Failure を避けるため、高可用性を実現するという理由もあります。

{{site.data.keys.mf_server }} を実行するサーバーが複数ある場合、サーバーはファームとして構成する必要があります。この構成により、どの管理サービスもファームのすべてのランタイムに接続することが可能になります。クラスターがファームとして構成されていない場合、管理操作を実行する管理サービスと同じアプリケーション・サーバーで実行されるランタイムのみが通知を受けます。その他のランタイムは、変更を認識しません。例えば、ファームとして構成されていないクラスターに、新しいバージョンのアダプターをデプロイした場合、その新しいアダプターにサービスを提供するのは 1 つのサーバーのみです。その他のサーバーは、古いアダプターへのサービス提供を継続します。クラスターを持っていて、ファームを構成する必要がない唯一の状況は、サーバーを WebSphere Application Server Network Deployment にインストールする場合のみです。デプロイメント・マネージャーで JMX Bean を照会することで、管理サービスはすべてのサーバーを見つけることができます。管理操作を行えるようにするには、デプロイメント・マネージャーが実行中でなければなりません。これは、セルの {{site.data.keys.product_adj }} JMX Bean のリストを提供するのにデプロイメント・マネージャーが使用されるためです。

また、ファームを作成する際、そのファームのすべてのメンバーに対して照会を送信するよう、HTTP サーバーを構成することも必要です。HTTP サーバーの構成は、このチュートリアルには含まれていません。このチュートリアルで扱うのは、管理操作がクラスターのすべてのランタイム・コンポーネントに複製されるようにファームを構成することのみです。

1. 同じコンピューター上に、2 番目の Liberty サーバーを作成します。
    * コマンド・ラインを開始します。
    * **liberty\_install\_dir/bin** に移動し、**server create mfp2** と入力します。
2. サーバー mfp2 の HTTP ポートおよび HTTPS ポートを変更して、サーバー mfp1 のポートと競合しないようにします。
    * 2 番目のサーバーのディレクトリーに移動します。ディレクトリーは **liberty\_install\_dir/usr/servers/mfp2** または **WLP\_USER\_DIR/servers/mfp2** ([『WebSphere Application Server Liberty Core のインストール』](#installing-websphere-application-server-liberty-core)のステップ 6 に説明されたようにディレクトリーを変更した場合) です。
    * **server.xml** ファイルを編集します。置換は、

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
    
    この変更により、サーバー mfp2 の HTTP ポートおよび HTTPS ポートはサーバー mfp1 のポートと競合しなくなります。{{site.data.keys.mf_server }} のインストールを実行する前に必ずポートを変更するようにしてください。 そうでない場合、インストールが完了した後にポートを変更するのであれば、JNDI プロパティー **mfp.admin.jmx.port** にもポートの変更を反映させなければなりません。
    
3. サーバー構成ツールを実行します。
    *  構成 **Hello MobileFirst 2** を作成します。
    * [サーバー構成ツールの実行](#running-the-server-configuration-tool)で説明したものと同じインストール手順を実行します。ただし、アプリケーション・サーバーとしては **mfp2** を選択してください。同じデータベースと同じスキーマを使用します。 

    > **注: **  
    > 
    > * サーバー mfp1 の環境 ID を使用する場合 (このチュートリアルでは推奨されていません)、サーバー mfp2 にも同じ環境 ID を使用する必要があります。
    > * 一部のアプリケーションのコンテキスト・ルートを変更する場合、サーバー mfp2 にも同じコンテキスト・ルートを使用してください。ファームのサーバーは、対称でなければなりません。
    > * デフォルト・ユーザー (admin/admin) を作成する場合、サーバー mfp2 でも同じユーザーを作成してください。

    Ant タスクはデータベースが存在することを検出し、表を作成しません (以下のログ抽出を参照)。次に、アプリケーションがサーバーにデプロイされます。 
    
    ```xml
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
    
    > **ヒント:** このパスワードは Keytool ユーティリティーで変更できますが、Liberty サーバーがその鍵ストアを読み取れるように、server.xml ファイルでもパスワードの変更を行う必要があります。このチュートリアルでは、デフォルトのパスワードを使用します。    * **WLP\_USER\_DIR/servers/mfp1/resources/security** で、`keytool -list -keystore key.jks` と入力します。このコマンドにより、鍵ストア内の証明書が表示されます。存在するのは **default** という名前の証明書 1 つのみです。鍵が表示される前に、鍵ストアのパスワード (mobilefirst) を要求されます。これは、Keytool ユーティリティーを使用する次のすべてのコマンドに当てはまります。
    * 次のコマンドを使用して、サーバー mfp1 のデフォルト証明書をエクスポートします。`keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`
        * **WLP\_USER\_DIR/servers/mfp2/resources/security** で、次のコマンドを使用してサーバー mfp2 のデフォルト証明書をエクスポートします。`keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`
    * 同じディレクトリーで、次のコマンドを使用してサーバー mfp1 の証明書をインポートします。`keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`。サーバー mfp1 の証明書がサーバー mfp2 の鍵ストアにインポートされ、サーバー mfp2 がサーバー mfp1 への HTTPS 接続を信頼できるようになります。この証明書を信頼するかどうか確認を求められます。
    * **WLP_USER_DIR/servers/mfp1/resources/security** で、次のコマンドを使用してサーバー mfp2 の証明書をインポートします。`keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`このステップの後、2 つのサーバー間の HTTPS 接続が可能になります。

## ファームのテストと {{site.data.keys.mf_console }} での変更内容の確認
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. 以下の 2 つのサーバーを始動します。

    ```bash
    server start mfp1
    server start mfp2
    ```
    
2. コンソールにアクセスします。例えば、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)、または HTTPS では [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) です。左側のサイドバーに、**「サーバー・ファームのノード」**という名前の追加メニューが表示されます。**「サーバー・ファームのノード」**をクリックすると、各ノードの状況を表示できます。両方のノードが始動するまで、しばらく待たなければならない場合があります。
    
    
