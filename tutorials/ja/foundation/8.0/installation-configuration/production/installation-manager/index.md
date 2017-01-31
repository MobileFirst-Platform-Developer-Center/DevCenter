---
layout: tutorial
title: IBM Installation Manager の実行
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM Installation Manager は {{site.data.keys.mf_server_full }} ファイルおよびツールをコンピューターにインストールします。

Installation Manager を実行して、{{site.data.keys.mf_server }} のバイナリー・ファイルおよび、{{site.data.keys.mf_server }} アプリケーションをご使用のコンピューターのアプリケーション・サーバーにデプロイするためのツールをインストールします。インストーラーによってインストールされるファイルおよびツールについては、[{{site.data.keys.mf_server }} の配布構造](#distribution-structure-of-mobilefirst-server)で説明しています。

{{site.data.keys.mf_server }} インストーラーを実行するには、IBM Installation Manager V1.8.4 以降が必要です。これは、グラフィカル・モードまたはコマンド・ライン・モードのいずれかで実行できます。  
インストール・プロセス中に、次の 2 つの主なオプションが提案されます。

* トークン・ライセンスのアクティベーション
* {{site.data.keys.mf_app_center }} のインストールおよびデプロイメント

### トークン・ライセンス
{: #token-licensing }
トークン・ライセンスは、{{site.data.keys.mf_server }} でサポートされている 2 つのライセンス交付メソッドのうちの 1 つです。トークン・ライセンスをアクティブ化する必要があるかどうかを判断する必要があります。Rational License Key Server でのトークン・ライセンスの使用を定義した契約がない場合は、トークン・ライセンスをアクティブ化しないでください。トークン・ライセンスをアクティブ化する場合は、{{site.data.keys.mf_server }} をトークン・ライセンス用に構成する必要があります。詳しくは、
[
トークン・ライセンスのインストールと構成 (Installing
and configuring for token licensing)](../token-licensing) を参照してください。

### {{site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center は {{site.data.keys.product }} のコンポーネントです。Application Center を使用すると、組織内で開発中のモバイル・アプリケーションを、モバイル・アプリケーションの単一リポジトリーで共有できます。

Application Center を Installation Manager でインストールすることを選択した場合、Installation Manager がデータベースを構成し、Application Center をアプリケーション・サーバーにデプロイするように、データベースおよびアプリケーション・サーバーのパラメーターを指定する必要があります。Application Center を Installation Manager でインストールしないことを選択した場合、Installation Manager は Application Center の WAR ファイルおよびリソースをご使用のディスクに保存します。これによってデータベースがセットアップされたり、Application Center WAR ファイルがご使用のアプリケーション・サーバーにデプロイされることはありません。それらは後で Ant タスクを使用するか、または手動で行うことができます。Application Center をインストールするこのオプションは、インストール・プロセス中にグラフィカル・インストール・ウィザードによるガイドが提供されるため、Application Center をディスカバーするための便利な方法です。

ただし、実動インストールの場合は、Ant タスクを使用して Application Center をインストールしてください。Ant タスクを使用したインストールでは、{{site.data.keys.mf_server }} に対する更新を Application Center に対する更新から分離することができます。

* Installation Manager による Application Center のインストールの利点。
    * グラフィカル・ウィザードによるガイドで、インストールおよびデプロイメントのプロセスを支援します。
* Installation Manager による Application Center のインストールの欠点。
    * Installation Manager が UNIX または Linux の root ユーザーで実行される場合、Application Center がデプロイされたアプリケーション・サーバーのディレクトリーに、root が所有するファイルが作成される可能性があります。この結果、アプリケーション・サーバーを root として実行しなければならなくなります。
    * データベース・スクリプトにアクセスできないため、インストール手順を実行する前に表を作成できるように、データベース管理者にデータベース・スクリプトを提供することができません。Installation Manager により、デフォルト設定でデータベース表が作成されます。
    * 例えば暫定修正をインストールする際など、製品をアップグレードするたびに、Application Center が最初にアップグレードされます。Application Center のアップグレードには、データベースおよびアプリケーション・サーバーに対する操作が含まれます。Application Center のアップグレードが失敗すると、Installation Manager はアップグレードを完了できなくなり、他の {{site.data.keys.mf_server }} コンポーネントをアップグレードすることもできなくなります。実動インストールの場合は、Installation Manager を使用して Application Center をデプロイしないでください。Installation Manager により {{site.data.keys.mf_server }} がインストールされた後で、別途 Ant タスクで Application Center をインストールしてください。Application Center について詳しくは、[Application Center のインストールおよび構成](../../../appcenter)を参照してください。

> **重要:** {{site.data.keys.mf_server }} インストーラーがご使用のディスクにインストールするのは、{{site.data.keys.mf_server }} バイナリー・ファイルおよびツールのみです。{{site.data.keys.mf_server }} アプリケーションはご使用のアプリケーション・サーバーにデプロイされません。Installation Manager によるインストールを実行した後、データベースをセットアップし、{{site.data.keys.mf_server }} アプリケーションをアプリケーション・サーバーにデプロイする必要があります。  
> 同様に、Installation Manager を実行して既存のインストール済み環境を更新する場合、ご使用のディスク上のファイルのみが更新されます。アプリケーション・サーバーにデプロイされたアプリケーションを更新するには、追加のアクションを実行する必要があります。

#### ジャンプ先
{: #jump-to }
* [管理者モード対ユーザー・モード](#administrator-versus-user-mode)
* [IBM Installation Manager インストール・ウィザードを使用したインストール](#installing-by-using-ibm-installation-manager-install-wizard)
* [コマンド・ラインでの IBM Installation Manager の実行によるインストール](#installing-by-running-ibm-installation-manager-in-command-line)
* [XML 応答ファイルを使用したインストール - サイレント・インストール](#installing-by-using-xml-response-files---silent-installation)
* [{{site.data.keys.mf_server }} の配布構造](#distribution-structure-of-mobilefirst-server)

## 管理者モード対ユーザー・モード
{: #administrator-versus-user-mode }
2 つの異なる IBM Installation Manager モードで {{site.data.keys.mf_server }} をインストールすることができます。モードは、IBM Installation Manager 自体がどのようにインストールされたのかに基づきます。このモードにより、Installation Manager とパッケージの両方に使用するディレクトリーおよびコマンドが決定されます。

{{site.data.keys.product }} では、次の 2 つの Installation Manager モードがサポートされています。

* 管理者モード
* ユーザー (非管理者) モード

Linux または UNIX で使用可能なグループ・モードは、この製品ではサポートされていません。

### 管理者モード
{: #administrator-mode }
管理者モードの場合、Linux または UNIX では root として、Windows では管理者特権を使用して Installation Manager を実行する必要があります。Installation Manager のリポジトリー・ファイル (すなわち、インストール済みソフトウェアとそのバージョンのリスト) はシステム・ディレクトリーにインストールされます。Linux または UNIX では /var/ibm、Windows では ProgramData になります。Installation Manager を管理者モードで実行している場合は、Installation Manager を使用して Application Center をデプロイしないでください。

### ユーザー (非管理者) モード
{: #user-nonadministrator-mode }
ユーザー・モードの場合、Installation Manager は、特定の特権を持たないどのユーザーも実行できます。ただし、Installation Manager のリポジトリー・ファイルは、ユーザーのホーム・ディレクトリーに保管されます。製品のインストール済み環境をアップグレードできるのは、そのユーザーのみになります。root として Installation Manager を実行しない場合は、後で製品のインストール済み環境をアップグレードしたり暫定修正を適用したりするときに使用可能なユーザー・アカウントを持っていることを確認してください。

Installation Manager のモードについて詳しくは、IBM Installation Manager 資料で [Installing as an administrator, nonadministrator, or group](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc) を参照してください。

## IBM Installation Manager インストール・ウィザードを使用したインストール
{: #installing-by-using-ibm-installation-manager-install-wizard }
以下の手順に示されたステップに従って、{{site.data.keys.mf_server }} のリソースと、ツール (例えば、サーバー構成ツール、Ant、mfpadm プログラムなど) をインストールします。  
インストール・ウィザードでの以下の 2 つのペインでの決定は必須です。

* **「汎用設定 (General settings)」**パネル。
* Application Center をインストールするための**「構成の選択」**パネル。

1. Installation Manager を起動します。
2. {{site.data.keys.mf_server }} のリポジトリーを Installation Manager 内に追加します。
    * **「ファイル」→「設定」**に移動して**「リポジトリーの追加 (Add Repositories...)」**をクリックします。
    * インストーラーが解凍されたディレクトリー内にあるリポジトリー・ファイルを参照します。

        {{site.data.keys.mf_server }} の {{site.data.keys.product }} V8.0 .zip ファイルを **mfp\_installer\_directory** フォルダーで解凍すると、リポジトリー・ファイルは **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf** にできます。

        [IBM サポート・ポータル](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)からダウンロード可能な最新のフィックスパックを適用することもできます。フィックスパック用のリポジトリーを入力するようにしてください。**fixpack_directory** フォルダーにフィックスパックを解凍した場合、リポジトリー・ファイルは **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf** にあります。

        **注:** Installation Manager のリポジトリー内に基本バージョンのリポジトリーが存在しないと、フィックスパックをインストールすることができません。対象のフィックスパックは差分インストーラーで、インストールを行うのに基本バージョンのリポジトリーを必要とします。    * ファイルを選択し、**「OK」**をクリックします。
    * **「OK」**をクリックして、**「設定」**パネルを閉じます。
3. 製品のライセンス条項に同意した後、**「次へ (Next)」**をクリックします。
4. 製品をインストールするためのパッケージ・グループを選択します。

    {{site.data.keys.product }} V8.0 は、以下のように異なるインストール名を持つ、以前のリリースの後継製品です。
    * Worklight for V5.0.6
    * IBM Worklight for V6.0 から V6.3
    
    これらの古い製品バージョンのいずれかがコンピューターにインストールされている場合、Installation Manager はインストール・プロセスの最初に、「既存のパッケージ・グループを使用」というオプションを提供します。このオプションは、{{site.data.keys.mf_app_center_full }} がインストールされていた場合、製品の古いバージョンをアンインストールし、古いインストール・オプションを再使用してアップグレードを実行します。
    
    分離インストールの場合は、古いバージョンと共に新規バージョンをインストールできるように、「新規パッケージ・グループの作成」オプションを選択します。  
コンピューターに製品の他のバージョンがインストールされていない場合、新しいパッケージ・グループで製品をインストールするために「新規パッケージ・グループの作成」オプションを選択します。
    
5. **「次へ」**をクリックします。
6. **「汎用設定 (General settings) 」**パネルの**「トークン・ライセンスのアクティブ化 (Activate token licensing)」**セクションで、トークン・ライセンスをアクティブにするかどうかを決定します。

     Rational License Key Server でトークン・ライセンスを使用する契約がある場合は、**「Rational License Key Server でトークン・ライセンスをアクティブにする (Activate token licensing with the Rational License Key Server)」**オプションを使用してください。トークン・ライセンスをアクティブ化した後、追加のステップを実行して {{site.data.keys.mf_server }} を構成する必要があります。それ以外の場合は、**「Rational License Key Server でトークン・ライセンスをアクティブ化しない (Do not activate token licensing with the Rational License Key Server)」**オプションを選択して先に進みます。
7. **「汎用設定 (General settings)」**パネルの**「{{site.data.keys.product }} for iOS のインストール」**セクションで、デフォルト・オプション (「いいえ」) をそのままにします。
8. **「構成の選択」**パネルで、Application Center をインストールするかどうかを決定します。

    実動インストールの場合は、Ant タスクを使用して Application Center をインストールしてください。Ant タスクを使用したインストールでは、{{site.data.keys.mf_server }} に対する更新を Application Center に対する更新から分離することができます。この場合、「構成の選択」パネルで「いいえ」オプションを選択して、Application Center がインストールされないようにします。

「はい」を選択した場合は、次のペインを検討して、使用する予定のデータベース、および Application Center をデプロイする予定のアプリケーション・サーバーに関する詳細を入力する必要があります。また、ご使用のデータベースの JDBC ドライバーも使用できるようにしておく必要があります。
9. **「ありがとうございました (Thank You)」**パネルが表示されるまで、**「次へ (Next)」**をクリックします。 その後、インストールを続行します。

{{site.data.keys.product_adj }} コンポーネントをインストールするためのリソースを含むインストール・ディレクトリーがインストールされます。

リソースは以下のフォルダーに入っています。

* {{site.data.keys.mf_server }} 用の **MobileFirstServer** フォルダー
*  {{site.data.keys.mf_server }} プッシュ・サービス用の **PushService** フォルダー
* Application Center 用の **ApplicationCenter** フォルダー
* {{site.data.keys.mf_analytics }} 用の **Analytics** フォルダー

また、**shortcuts** フォルダーには、サーバー構成ツール、Ant、および mfpadm プログラムのショートカットも用意されています。

## コマンド・ラインでの IBM Installation Manager の実行によるインストール
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. {{site.data.keys.mf_server }} のご使用条件を確認します。ライセンス・ファイルは、パスポート・アドバンテージからインストール・リポジトリーをダウンロードすると表示できます。
2. ダウンロードした {{site.data.keys.mf_server }} リポジトリーの圧縮ファイルを、任意のフォルダーに解凍します。

    このリポジトリーは、[IBM パスポート・アドバンテージ](http://www.ibm.com/software/passportadvantage/pao_customers.htm)の {{site.data.keys.product }} eAssembly からダウンロードできます。このパックの名前は、**IBM MobileFirst Foundation V{{site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server** です。

     以下のステップでは、インストーラーを解凍するディレクトリーは **mfp\_repository\_dir** という名前になっています。この中には **MobileFirst\_Platform\_Server/disk1** フォルダーが含まれています。
3. コマンド・ラインを開始し、**installation\_manager\_install\_dir/tools/eclipse/** に移動します。

    ステップ 1 で確認後ご使用条件に同意したら、{{site.data.keys.mf_server }} をインストールします。
    * トークン・ライセンスの適用なしでインストールする場合 (トークン・ライセンスの使用を定義した契約がない場合) は、次のコマンドを入力します。

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * トークン・ライセンスの適用ありでインストールする場合は、次のコマンドを入力します。 
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        **user.licensed.by.tokens** プロパティーの値を **true** に設定します。[トークン・ライセンス](../token-licensing)用に {{site.data.keys.mf_server }} を構成する必要があります。
        
        Application Center はインストールせずに {{site.data.keys.mf_server }} をインストールする場合は、以下のプロパティーを設定します。
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        このプロパティーは、トークン・ライセンスをアクティブ化するかどうかを示しています。**user.licensed.by.tokens=true/false**.
        
        {{site.data.keys.product }} をインストールするには、user.use.ios.edition プロパティーの値を false に設定します。
        
5. 最新の暫定修正も一緒にインストールする場合は、**-repositories** パラメーターに暫定修正・リポジトリーを追加してください。**-repositories** パラメーターは、リポジトリーのコンマ区切りリストを受け入れます。

    **com.ibm.mobilefirst.foundation.server** を **com.ibm.mobilefirst.foundation.server_version** に置換することで、暫定修正のバージョンを追加します。**version** の形式は **8.0.0.0-buildNumber** となります。例えば、暫定修正 **8.0.0.0-IF20160103101**5 をインストールする場合、次のコマンドを入力します。 `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`
    
    imcl コマンドについて詳しくは、[Installation Manager: Installing packages by using `imcl` commands](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en) を参照してください。
    
{{site.data.keys.product_adj }} コンポーネントをインストールするためのリソースを含むインストール・ディレクトリーがインストールされます。

リソースは以下のフォルダーに入っています。

* {{site.data.keys.mf_server }} 用の **MobileFirstServer** フォルダー
*  {{site.data.keys.mf_server }} プッシュ・サービス用の **PushService** フォルダー
* Application Center 用の **ApplicationCenter** フォルダー
* {{site.data.keys.mf_analytics }} 用の **Analytics** フォルダー    

また、**shortcuts** フォルダーには、サーバー構成ツール、Ant、および mfpadm プログラムのショートカットも用意されています。

## XML 応答ファイルを使用したインストール - サイレント・インストール
{: #installing-by-using-xml-response-files---silent-installation }
IBM Installation Manager を使用してコマンド・ラインで {{site.data.keys.mf_app_center_full }} をインストールする場合は、長い引数リストを提供する必要があります。この場合、XML 応答ファイルを使用して、これらの引数を提供します。

サイレント・インストールは、応答ファイルと
呼ばれる XML ファイルによって定義されます。このファイルには、サイレント・インストールの実行に
必要なデータが含まれています。サイレント・インストールは、コマンド・ラインまたはバッチ・ファイルから開始されます。

Installation Manager を使用して、応答ファイル用の設定値およびインストール操作をユーザー・インターフェース・モードで記録できます。あるいは、応答ファイルのコマンドおよび設定値のリストが記述された文書を使用して、
手動で応答ファイルを作成することもできます。

サイレント・インストールは、Installation Manager のユーザー資料に記載されています。[サイレント・モードでの作業](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html)を参照してください。

適切な応答ファイルを作成するには、次の 2 つの方法があります。

* {{site.data.keys.product_adj }} ユーザー資料で提供されているサンプル応答ファイルを処理する。
* 別のコンピューターで記録された応答ファイルを処理する。

両方の方法が以下のセクションで説明されています。

### IBM Installation Manager 用のサンプル応答ファイルの処理
{: #working-with-sample-response-files-for-ibm-installation-manager }
IBM Installation Manager 用のサンプル応答ファイルは、**Silent\_Install\_Sample_Files.zip** 圧縮ファイル内に入っています。以下の手順では、それらの使用方法について説明します。

1. 適切なサンプル応答ファイルを圧縮ファイルから選択します。
Silent_Install_Sample_Files.zip ファイルには、リリースごとに 1 つのサブディレクトリーが含まれています。

    > **重要:**  
    > 
    > * Application Center をアプリケーション・サーバーにインストールしないインストールには、**install-no-appcenter.xml** という名前のファイルを使用します。    > * Application Center をインストールするインストールには、使用するアプリケーション・サーバーおよびデータベースに基づいて、以下の表からサンプル応答ファイルを選択します。

   #### Application Center をインストールするための **Silent\_Install\_Sample_Files.zip** ファイル内の
インストール用サンプル応答ファイル
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Application Center をインストールするアプリケーション・サーバー</th>
            <th>Derby</th>
            <th>IBM DB2</th>
            <th>MySQL </th>
            <th>Oracle </th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Liberty プロファイル</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (注を参照)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server フル・プロファイル、スタンドアロン・サーバー</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (注を参照)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>該当なし</td>
            <td>install-wasnd-cluster-db2.xml、install-wasnd-server-db2.xml、install-wasnd-node-db2.xml、install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (注を参照)、install-wasnd-server-mysql.xml (注を参照)、install-wasnd-node-mysql.xml、install-wasnd-cell-mysql.xml (注を参照)</td>
            <td>install-wasnd-cluster-oracle.xml、install-wasnd-server-oracle.xml、install-wasnd-node-oracle.xml、install-wasnd-cell-oracle.xml</td>
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
    
    > **注:** WebSphere Application Server Liberty プロファイルまたは WebSphere Application Server フル・プロファイルと組み合わせて使用される MySQL は、サポートされる構成には分類されません。詳しくは、「[WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)」を参照してください。IBM DB2、または WebSphere Application Server によってサポートされる別の DBMSを使用して、IBM サポートによってフルにサポートされる構成の利点を活用することができます。

    アンインストールする場合は、最初に特定のパッケージ・グループにインストールした {{site.data.keys.mf_server }} または Worklight Server のバージョンに応じたサンプル・ファイルを使用してください。
    
    * {{site.data.keys.mf_server }} では、パッケージ・グループ「{{site.data.keys.mf_server }}」を使用します。
    * Worklight Server V6.x 以降では、パッケージ・グループ「IBM Worklight」を使用します。
    * Worklight Server V5.x では、パッケージ・グループ「Worklight」を使用します。

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>{{site.data.keys.mf_server }} の初期バージョン</th>
            <th>サンプル・ファイル</th>
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
            <td>IBM MobileFirst Server V6.x 以降</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. サンプル・ファイルのファイル・アクセス権限を、できる限り制限されたものに変更します。ステップ 4 では、いくつかのパスワードを指定する必要があります。
同じコンピューター上の他のユーザーがこれらのパスワードを知ることができないようにする必要がある場合は、自分以外のユーザーに対して、ファイルの read 権限を削除する必要があります。以下の例のようなコマンドを使用できます。
    * UNIX の場合: `chmod 600 <target-file.xml>`
    * Windows の場合: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 同様に、サーバーが WebSphere Application Server Liberty プロファイルまたは Apache Tomcat サーバーで、そのサーバーが自分のアカウントからのみ始動するようにする場合は、次のファイルから自分以外のユーザーの read 権限も削除する必要があります。
    * WebSphere Application Server Liberty プロファイルの場合: `wlp/usr/servers/<server>/server.xml`
    * Apache Tomcat の場合: `conf/server.xml`
4. <server> エレメント内のリポジトリーのリストを調整します。 このステップについて詳しくは、[リポジトリー](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html)にある IBM Installation Manager の資料を参照してください。

    `<profile>` エレメント内のキー/値の各ペアの値を調整します。  
    `<install>` エレメントの `<offering>` エレメント内で、インストールするリリースに合致するよう version 属性を設定するか、リポジトリー内の最新バージョンをインストールする場合は version 属性を削除します。
5. 以下のコマンドを入力してください。`<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    各部の意味は次のとおりです。
    * `<InstallationManagerPath>` は、IBM Installation Manager のインストール・ディレクトリーです。
    * `<responseFile>` は、ステップ 1 で選択および更新されるファイルの名前です。

> 詳細については、IBM Installation Manager 資料の[応答ファイルを使用したパッケージのサイレント・インストール](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)を参照してください。    

### 別のマシンで記録された応答ファイルの処理
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. GUI が使用可能なマシン上で IBM Installation Manager をオプション `-record responseFile` を指定してウィザード・モードで実行することによって、応答ファイルを記録します。詳しくは、[Installation Manager による応答ファイルの記録](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html)を参照してください。
2. 応答ファイルのファイル・アクセス権限を、できる限り制限されたものに変更します。ステップ 4 では、いくつかのパスワードを指定する必要があります。 同じコンピューター上の他のユーザーがこれらのパスワードを知ることができないようにする必要がある場合は、自分以外のユーザーに対して、ファイルの **read** 権限を削除する必要があります。以下の例のようなコマンドを使用できます。
    * UNIX の場合: `chmod 600 response-file.xml`
    * Windows の場合: `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 同様に、サーバーが WebSphere Application Server Liberty または Apache Tomcat サーバーで、そのサーバーが自分のアカウントからのみ始動するようにする場合は、次のファイルから自分以外のユーザーの read 権限も削除する必要があります。
    * WebSphere Application Server Liberty の場合: `wlp/usr/servers/<server>/server.xml`
    * Apache Tomcat の場合: `conf/server.xml`
4. 応答ファイルが作成されたマシンとターゲット・マシンとの相違点を反映するよう、応答ファイルを変更します。
5. [応答ファイルを使用したパッケージのサイレント・インストール](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)の説明に従って、応答ファイルを使用してターゲット・マシンに {{site.data.keys.mf_server }} をインストールします。

### コマンド・ライン (サイレント・インストール) パラメーター
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>キー</th>
        <th>いつ必要か</th>
        <th>説明</th>
        <th>許可される値</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>常時</td>
        <td>{{site.data.keys.product }} をインストールする予定の場合、この値を <code>false</code> に設定します。iOS エディション用の製品をインストールする計画の場合、値を <code>true</code> に設定する必要があります。</td>
        <td><code>true</code> または <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>常時</td>
        <td>トークン・ライセンスのアクティベーション。製品を Rational License Key Server と共に使用することを計画している場合は、トークン・ライセンスをアクティブにする必要があります。<br/><br/>この場合、値を <code>true</code> に設定します。製品を Rational License Key Server と共に使用することを計画していない場合、値を <code>false</code> に設定します。<br/><br/>ライセンス・トークンをアクティブにした場合は、製品をアプリケーション・サーバーにデプロイした後に、特定の構成ステップが必要になります。</td>
        <td><code>true</code> または <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>常時</td>
        <td>アプリケーション・サーバーのタイプ。was は、事前インストール済みの WebSphere Application Server 8.5.5 を意味します。tomcat は、Tomcat 7.0 を意味します。</td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>WebSphere Application Server インストール・ディレクトリー。</td>
        <td>絶対ディレクトリー名。</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>アプリケーションをインストールする先のプロファイル。
WebSphere Application Server Network Deployment の場合、Deployment Manager プロファイルを指定します。Liberty は、Liberty プロファイル (サブディレクトリー wlp) を意味します。</td>
        <td>いずれかの WebSphere Application Server プロファイルの名前。</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>アプリケーションをインストールする先の WebSphere Application Server セル。</td>
        <td>WebSphere Application Server セルの名前。</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>アプリケーションをインストールする先の WebSphere Application Server ノード。これは、現行マシンに対応します。</td>
        <td>現行マシンの WebSphere Application Server ノードの名前。</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>アプリケーションをインストールするサーバー・セットのタイプ。<br/><br/><code>server</code> はスタンドアロン・サーバーを意味します。<br/><br/><code>nd-cell</code> は WebSphere Application Server Network Deployment セルを意味します。<code>nd-cluster</code> は WebSphere Application Server Network Deployment クラスターを意味します。<br/><br/><code>nd-node</code> は、WebSphere Application Server Network Deployment ノード (クラスターを除く) を意味します。<br/><br/><code>nd-server</code> は、管理対象 WebSphere Application Server Network Deployment サーバーを意味します。</td>
        <td><code>server</code>、<code>nd-cell</code>、<code>nd-cluster</code>、<code>nd-node</code>、<code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== server</td>
      <td>アプリケーションをインストールする先の WebSphere Application Server サーバーの名前。</td>
      <td>現行マシン上の WebSphere Application Server サーバーの名前。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-cluster</td>
      <td>アプリケーションをインストールする先の WebSphere Application Server Network Deployment クラスターの名前。</td>
      <td>WebSphere Application Server セル内の WebSphere Application Server Network Deployment クラスターの名前。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope}
== nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>アプリケーションをインストールする先の WebSphere Application Server Network Deployment ノードの名前。</td>
      <td>WebSphere Application Server セル内の WebSphere Application Server Network Deployment ノードの名前。</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-server</td>
      <td>アプリケーションをインストールする先の WebSphere Application Server Network Deployment サーバーの名前。</td>
      <td>指定された WebSphere Application Server Network Deployment ノード内の WebSphere Application Server Network Deployment サーバーの名前。</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 管理者の名前。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 管理者のパスワード (オプションで、特定の方法での暗号化が可能です)。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server ユーザー・リストに追加する <code>appcenteradmin</code> ユーザーのパスワード (オプションで、特定の方法での暗号化が可能です)。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>インストールされるアプリケーションを {{site.data.keys.mf_server }} の他のインストールと区別するための接尾部。</td>
      <td>10 桁の 10 進数からなるストリング。</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} == Liberty</td>
      <td>アプリケーションをインストールする先の WebSphere Application Server Liberty サーバーの名前。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Apache Tomcat インストール・ディレクトリー。<b>CATALINA_HOME</b> ディレクトリー
と <b>CATALINA_BASE</b> ディレクトリーに分割される Tomcat インストールの
場合、ここで <b>CATALINA_BASE</b> 環境変数の値を指定する
必要があります。</td>
      <td>絶対ディレクトリー名。</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>常時</td>
      <td>データベースを保管するのに使用されるデータベース管理システムのタイプ。</td>
      <td><code>derby</code>、<code>db2</code>、<code>mysql</code>、<code>oracle</code>、<code>none</code>。値 none は、インストーラーが Application Center をインストールしないことを意味します。この値が使用される場合、<b>user.appserver.selection2</b> および <b>user.database.selection2</b> の両方の値が none でなければなりません。</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>常時</td>
      <td><code>true</code> は事前インストール済み
のデータベース管理システムを意味し、<code>false</code> は Apache Derby を
インストールすることを意味します。</td>
      <td><code>true</code>、<code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>Derby データベースを作成または想定するディレクトリー。</td>
      <td>絶対ディレクトリー名。</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 データベース・サーバーのホスト名または IP アドレス。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 データベース・サーバーが JDBC 接続を listen するポート。通常は 50000 です。</td>
      <td>1 から 65535 までの範囲の数値。</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>db2jcc4.jar の絶対ファイル名。</td>
      <td>絶対ファイル名。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center 用の DB2 データベースにアクセスするのに使用されるユーザー名。</td>
      <td>空でない。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center 用の DB2 データベースにアクセスするのに使用されるパスワード (オプションで、特定の方法での暗号化が可能です)。</td>
      <td>空でないパスワード。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center 用の DB2 データベースの名前。</td>
      <td>空でない、有効な DB2 データベース名。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>オプション</td>
      <td><b>user.database.mysql.appcenter.dbname</b> がサービス名と SID 名のいずれであるかを示します。このパラメーターが欠落している場合、<b>user.database.mysql.appcenter.dbname</b> は SID 名であると見なされます。</td>
      <td><code>true </code> (サービス名を示します) または <code>false </code>(SID 名を示します)。</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 データベース内の、Application Center のスキーマの名前。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>MySQL データベース・サーバーのホスト名または IP アドレス。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>MySQL データベース・サーバーが JDBC 接続を listen するポート。通常は 3306 です。</td>
      <td>1 から 65535 までの範囲の数値。</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td><b>mysql-connector-java-5.*-bin.jar</b> の絶対ファイル名。</td>
      <td>絶対ファイル名。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center 用の Oracle データベースにアクセスするのに使用されるユーザー名。</td>
      <td>1 から 30 個までの文字からなるストリング。
許可される文字は、ASCII 数字、ASCII 大文字および小文字、「_」、「#」、「$」です。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center 用の Oracle データベースにアクセスするのに使用されるパスワード (オプションで、特定の方法での暗号化が可能です)。</td>
      <td>パスワードは、1 から 30 個までの文字からなるストリングでなければなりません。
許可される文字は、ASCII 数字、ASCII 大文字および小文字、「_」、「#」、「$」です。</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle (ただし、
${user.database.oracle.appcenter.jdbc.url} が指定されていない場合に限る)</td>
      <td>Application Center 用の Oracle データベースの名前。</td>
      <td>空でない、有効な Oracle データベース名。</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle (ただし、
${user.database.oracle.appcenter.jdbc.url} が指定されていない場合に限る)</td>
      <td>Oracle データベース・サーバーのホスト名または IP アドレス。</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle (ただし、
${user.database.oracle.appcenter.jdbc.url} が指定されていない場合に限る)</td>
      <td>Oracle データベース・サーバーが JDBC 接続を listen するポート。通常は 1521 です。</td>
      <td>1 から 65535 までの範囲の数値。</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Oracle Thin ドライバー JAR ファイルの絶対ファイル名。
(<b>ojdbc6.jar または ojdbc7.jar</b>)</td>
      <td>絶対ファイル名。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center 用の Oracle データベースにアクセスするのに使用されるユーザー名。</td>
      <td>1 から 30 個までの文字からなるストリング。
許可される文字は、ASCII 数字、ASCII 大文字および小文字、「_」、「#」、「$」です。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>Application Center 用の Oracle データベースにアクセスするのに使用される、JDBC に適した構文のユーザー名。</td>
      <td>先頭が英字であって、小文字を含んでいない場合は、${user.database.oracle.appcenter.username} と
同じ。それ以外の場合は、二重引用符で囲んだ ${user.database.oracle.appcenter.username} で
なければなりません。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center 用の Oracle データベースにアクセスするのに使用されるパスワード (オプションで、特定の方法での暗号化が可能です)。</td>
      <td>パスワードは、1 から 30 個までの文字からなるストリングでなければなりません。
許可される文字は、ASCII 数字、ASCII 大文字および小文字、「_」、「#」、「$」です。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle (ただし、
${user.database.oracle.appcenter.jdbc.url} が指定されていない場合に限る)</td>
      <td>Application Center 用の Oracle データベースの名前。</td>
      <td>空でない、有効な Oracle データベース名。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>オプション</td>
      <td><code>user.database.oracle.appcenter.dbname</code> がサービス名と SID 名のいずれであるかを示します。このパラメーターが欠落している場合、<code>user.database.oracle.appcenter.dbname</code> は SID 名であると見なされます。</td>
      <td><code>true </code> (サービス名を示します) または <code>false </code>(SID 名を示します)。</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle (ただし、
${user.database.oracle.host}、${user.database.oracle.port}、${user.database.oracle.appcenter.dbname} が
すべて指定されていない場合に限る)</td>
      <td>Application Center 用の Oracle データベースの JDBC URL。</td>
      <td>有効な Oracle JDBC URL。「jdbc:oracle:」で始まります。</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>常時</td>
      <td>インストールされたサーバーの実行を許可されるオペレーティング・システム・ユーザー。</td>
      <td>オペレーティング・システム・ユーザー名、または空。</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>常時</td>
      <td>インストールされたサーバーの実行を許可されるオペレーティング・システム・ユーザー・グループ。</td>
      <td>オペレーティング・システム・ユーザー・グループ名、または空。</td>
    </tr>
</table>

## {{site.data.keys.mf_server }} の配布構造
{: #distribution-structure-of-mobilefirst-server }
{{site.data.keys.mf_server }} ファイルおよびツールは、{{site.data.keys.mf_server }} インストール・ディレクトリー内にインストールされます。

#### Analytics サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **analytics.ear** および **analytics-*.war** | {{site.data.keys.mf_analytics }} をインストールするための EAR ファイルと WAR ファイル。 |
| **configuration-samples** | Ant タスクを使用して {{site.data.keys.mf_analytics }} をインストールするためのサンプル Ant ファイルが含まれています。 |

#### ApplicationCenter サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **configuration-samples** | Application Center をインストールするためのサンプル Ant ファイルが含まれています。これらの Ant タスクはデータベース表を作成し、WAR ファイルをアプリケーション・サーバーにデプロイします。 | 
| **console** | Application Center をインストールするための EAR ファイルと WAR ファイルが含まれています。この EAR ファイルは IBM PureApplication システムに一意的に使用されます。 | 
| **databases** | Application Center 用の表の手動作成に使用される SQL スクリプトが含まれています。 |
| **installer** | Application Center クライアントを作成するためのリソースが含まれています。 | 
| **tools** | Application Center のツール。 | 

#### {{site.data.keys.mf_server }} サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **mfp-ant-deployer.jar** | {{site.data.keys.mf_server }} Ant タスクのセット。 |
| **mfp-*.war** | {{site.data.keys.mf_server }} コンポーネントの WAR ファイル。 |
| **configuration-samples** | Ant タスクを使用して {{site.data.keys.mf_server }} コンポーネントをインストールするためのサンプル Ant ファイルが含まれています。 | 
| **ConfigurationTool** | サーバー構成ツールのバイナリー・ファイルが含まれています。このツールは、**mfp_server_install_dir/shortcuts** から起動されます。 |
| **databases** | {{site.data.keys.mf_server }} コンポーネント ({{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} 構成サービス、および {{site.data.keys.product_adj }} ランタイム) 用の表の手動作成に使用される SQL スクリプトが含まれています。 | 
| **external-server-libraries** |  さまざまなツール (認証性ツールおよび OAuth セキュリティー・ツールなど) によって使用される JAR ファイルが含まれています。 |

#### PushService サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **mfp-push-service.war** | {{site.data.keys.mf_server }} プッシュ・サービスをインストールするための WAR ファイル。 |
| **databases** | {{site.data.keys.mf_server }} プッシュ・サービス用の表の手動作成に使用される SQL スクリプトが含まれています。 | 

#### License サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-license-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **Text** | {{site.data.keys.product }} のライセンスが含まれています。 | 

#### {{site.data.keys.mf_server }} インストール・ディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| アイテム | 説明 |
|------|-------------|
| **shortcuts** | Apache Ant 用ランチャー・スクリプト、サーバー構成ツール、および mfpadmin コマンド。これらは、{{site.data.keys.mf_server }} と共に提供されています。 | 

#### tools サブディレクトリー内のファイルおよびサブディレクトリー
{: #files-and-subdirectories-in-the-tools-subdirectory }

| アイテム | 説明 |
|------|-------------|
| **tools/apache-ant-version-number** | サーバー構成ツールによって使用される Apache Ant のバイナリー・インストール。これは、Ant タスクを実行するためにも使用できます。 | 
