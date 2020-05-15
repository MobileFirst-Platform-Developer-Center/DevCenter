---
layout: tutorial
title: MobileFirst Analytics Receiver Server インストール・ガイド
breadcrumb_title: インストール・ガイド
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_analytics_receiver_server }} は、Java EE 標準 Web アプリケーション・アーカイブ (WAR) ファイルとして実装されて出荷されます。そのため、サポートされるアプリケーション・サーバーである WebSphere Application Server、WebSphere Application Server Liberty、または Apache Tomcat (WAR ファイルのみ) のいずれかにインストール可能です。

#### ジャンプ先
{: #jump-to }

* [システム要件](#system-requirements)
* [容量に関する考慮事項](#capacity-considerations)
* [{{ site.data.keys.mf_analytics_receiver }} の WebSphere Application Server Liberty へのインストール](#installing-mobilefirst-analytics-receiver-on-websphere-application-server-liberty)
* [{{ site.data.keys.mf_analytics_receiver }} の Tomcat へのインストール](#installing-mobilefirst-analytics-receiver-on-tomcat)
* [{{ site.data.keys.mf_analytics_receiver }} の WebSphere Application Server へのインストール](#installing-mobilefirst-analytics-receiver-on-websphere-application-server)
* [Ant タスクを使用した {{ site.data.keys.mf_analytics_receiver }} のインストール](#installing-mobilefirst-analytics-receiver-with-ant-tasks)

## システム要件
{: #system-requirements }

### オペレーティング・システム
{: #operating-systems }
* CentOS/RHEL 6.x/7.x
* Oracle Enterprise Linux 6/7 (RHEL カーネルのみ)
* Ubuntu 12.04/14.04
* SLES 11/12
* OpenSuSE 13.2
* Windows Server 2012/R2
* Debian 7

### JVM
{: #jvm }
* Oracle JVM 1.7u55+
* Oracle JVM 1.8u20+
* IcedTea OpenJDK 1.7.0.55+

### ハードウェア
{: #hardware }
* RAM: RAM は大きいほうがよいですが、ノード当たり 64 GB 以下です。 32 GB と 16 GB も許容されます。 8 GB 未満では、クラスターに多くの小さなノードが必要です。64 GB は無駄で、Java がポインターにメモリーを使用するしくみの理由で問題があります。
* ディスク: 可能な場合は SSD を使用します。あるいは、SSD が可能でなければ高速回転の従来型ディスクを RAID 0 構成で使用します。
* CPU: CPU は、傾向としてパフォーマンス・ボトルネックになりません。 2 コアから 8 コアのシステムを使用します。
* ネットワーク: 水平方向のスケールアウトが必要になる場合は、1 GbE から 10 GbE の速度をサポートする、高速で、信頼性が高いデータ・センターが必要です。

### ハードウェア構成
{: #hardware-configuration }
* JVM に十分なサイズを設定して、メモリー内のキューのサイズを 10000 (つまり、最小 Xmx を 6 GB) に拡張します。
* BSD と Linux を使用する場合は、必ず、オペレーティング・システム入出力スケジューラーを **cfq** ではなく、**deadline** または **noop** に設定してください。

## 容量に関する考慮事項
{: #capacity-considerations }
容量は、最も共通する問題です。 どれぐらいの RAM が必要か? ディスク・スペースはどれぐらいか? ノードの数は? その答えはいつも主観的です。

IBM {{ site.data.keys.mf_analytics_receiver }} は、モバイル・アプリケーションからログを受信して分析サーバーに転送するにすぎず、イベント・データのストレージもないため、ディスク・スペースを必要としません。

## {{ site.data.keys.mf_analytics_receiver }} の WebSphere Application Server Liberty へのインストール
{: #installing-mobilefirst-analytics-receiver-on-websphere-application-server-liberty }
{{ site.data.keys.mf_analytics_receiver }} WAR ファイルがすでに存在していることを確認します。インストール成果物について詳しくは、[アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストール](../../prod-env/appserver)を参照してください。 **analytics-receiver.war** ファイルは、`<mf_server_install_dir>\analyticsreceiver` フォルダーにあります。WebSphere Application Server Liberty のダウンロードとインストールの方法について詳しくは、IBM developerWorks の「[About WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/)」の記事を参照してください。

1. `./wlp/bin` フォルダーで次のコマンドを実行して、サーバーを作成します。

   ```bash
   ./server create <serverName>
   ```

2. `./bin` フォルダーから次のコマンドを実行して、フィーチャーをインストールします。

   ```bash
   ./featureManager install jsp-2.2 ssl-1.0 appSecurity-1.0 localConnector-1.0
   ```

3. **analytics-receiver.war** ファイルを、Liberty サーバーの `./usr/servers/<serverName>/apps` フォルダーに追加します。
4. `./usr/servers/<serverName>/server.xml` ファイルの **<featureManager>** タグのコンテンツを以下のコンテンツに置換します。

   ```xml
   <featureManager>
        <feature>jsp-2.2</feature>
        <feature>ssl-1.0</feature>
        <feature>appSecurity-1.0</feature>
        <feature>localConnector-1.0</feature>
   </featureManager>
   ```

5. **server.xml** ファイル内に、ロール・ベースのセキュリティーを使用するアプリケーションとして `analytics-receiver.war` を構成します。以下の例は、基本的な、ハードコーディングされたユーザー・レジストリーを作成し、さまざまな Analytics ロールのそれぞれにユーザーを割り当てます。

   ```xml
   <application id="analytics-receiver" name="analytics-receiver" location="analytics-receiver.war" type="war">
        <application-bnd>
            <security-role name="analytics_administrator">
                <user name="admin"/>
            </security-role>
            <security-role name="analytics_infrastructure">
                <user name="infrastructure"/>
            </security-role>
            <security-role name="analytics_support">
                <user name="support"/>
            </security-role>
            <security-role name="analytics_developer">
                <user name="developer"/>
            </security-role>
            <security-role name="analytics_business">
                <user name="business"/>
            </security-role>
        </application-bnd>
   </application>

   <basicRegistry id="worklight" realm="worklightRealm">
        <user name="business" password="demo"/>
        <user name="developer" password="demo"/>
        <user name="support" password="demo"/>
        <user name="infrastructure" password="demo"/>
        <user name="admin" password="admin"/>
   </basicRegistry>
   ```

   > LDAP など、他のユーザー・レジストリー・タイプの構成方法について詳しくは、WebSphere Application Server 製品資料で [Liberty のユーザー・レジストリーの構成](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.iseries.doc/ae/twlp_sec_registries.html)のトピックを参照してください。

6. **bin** フォルダー内で以下のコマンドを実行して Liberty サーバーを始動します。

   ```bash
   ./server start <serverName>
   ```

7. 正常性 URL を呼び出してサービスを検証します。

   ```bash
   http://localhost:9080/analytics-receiver/rest/data/health
   ```

WebSphere Application Server Liberty の管理について詳しくは、WebSphere Application Server 製品資料で[コマンド行からの Liberty の管理](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_script.html)のトピックを参照してください。

## {{ site.data.keys.mf_analytics_receiver }} の Tomcat へのインストール
{: #installing-mobilefirst-analytics-receiver-on-tomcat }
{{ site.data.keys.mf_analytics_receiver }} WAR ファイルがあることを確認します。 インストール成果物について詳しくは、[アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストール](../../prod-env/appserver)を参照してください。 **analytics-receiver.war** ファイルは、`<mf_server_install_dir>\analyticsreceiver` フォルダーにあります。Tomcat のダウンロードとインストールの方法について詳しくは、[Apache Tomcat](http://tomcat.apache.org/) を参照してください。Java 7 以上をサポートするバージョンをダウンロードするようにしてください。 Tomcat のどのバージョンで Java 7 がサポートされているかについて詳しくは、[Apache Tomcat Versions](http://tomcat.apache.org/whichversion.html) を参照してください。

1. **analytics-receiver.war** ファイルを Tomcat `webapps` フォルダーに追加します。
2. 新しくダウンロードした Tomcat アーカイブの `conf/server.xml` ファイルで、コメント化されている次のセクションの、コメントを外します。

   ```xml
   <Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
   ```

3. `conf/server.xml` ファイルに 2 つの WAR ファイルを宣言し、ユーザー・レジストリーを定義します。

   ```xml
   <Context docBase ="analytics-receiver-service" path ="/analytics-receiver"></Context>
   <Realm className ="org.apache.catalina.realm.MemoryRealm"/>
   ```

   **MemoryRealm** は、`conf/tomcat-users.xml` ファイルに定義されているユーザーを認識します。 その他の使用可能なオプションについて詳しくは、[Apache Tomcat Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html)を参照してください。

4. `conf/tomcat-users.xml` ファイルに以下のセクションを追加して、**MemoryRealm** を構成します。
    * セキュリティー・ロールを追加します。

      ```xml
      <role rolename="analytics_administrator"/>
      <role rolename="analytics_infrastructure"/>
      <role rolename="analytics_support"/>
      <role rolename="analytics_developer"/>
      <role rolename="analytics_business"/>
      ```
    * 必要なロールのユーザーを数人追加します。

      ```xml
      <user name="admin" password="admin" roles="analytics_administrator"/>
      <user name="support" password="demo" roles="analytics_support"/>
      <user name="business" password="demo" roles="analytics_business"/>
      <user name="developer" password="demo" roles="analytics_developer"/>
      <user name="infrastructure" password="demo" roles="analytics_infrastructure"/>
      ```    
    * Tomcat Server を始動し、正常性 URL を呼び出してサービスを検証します。

      ```text
      http://localhost:8080/analytics-receiver/rest/data/health
      ```

    Tomcat サーバーの始動方法について詳しくは、Tomcat の公式サイトを参照してください。 例えば、Tomcat 7.0 の場合、[「Apache Tomcat 7」](http://tomcat.apache.org/tomcat-7.0-doc/introduction.html)です。

## {{ site.data.keys.mf_analytics_receiver }} の WebSphere Application Server へのインストール
{: #installing-mobilefirst-analytics-receiver-on-websphere-application-server }
インストール成果物 (JAR ファイルおよび EAR ファイル) を獲得するための最初のインストール・ステップについては、[アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストール](../../prod-env/appserver)を参照してください。**analytics-receiver.war** ファイルは、`<mf_server_install_dir>\analyticsreceiver` フォルダーにあります。

以下のステップでは、WebSphere Application Server に Analytics EAR ファイルをインストールし、実行する方法について説明します。 WebSphere Application Server に個別の WAR ファイルをインストールする場合は、デプロイ後に **analytics-receiver** WAR ファイルについてステップ 2 から 7 のみを実行してください。

1. WAR ファイルをアプリケーション・サーバーにデプロイします。ただし、開始はしないでください。WebSphere Application Server に EAR ファイルをインストールする方法については、WebSphere Application Server 製品資料で[コンソールを使用したエンタープライズ・アプリケーション・ファイルのインストール](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_instwiz.html)のトピックを参照してください。

2. **「エンタープライズ・アプリケーション」**リストから**「MobileFirst Analytics Receiver」**アプリケーションを選択します。

    ![WebSphere Enterprise アプリケーションをインストールします。](install_webphere_ent_app.jpg)

3. **「クラス・ロードおよび更新の検出」**をクリックします。

    ![WebSphere でのクラス・ロード](install_websphere_class_load.jpg)

4. クラス・ロード順序を**「親が最後」**に設定します。

    ![クラス・ロード順序の変更](install_websphere_app_class_load_order.jpg)

5. **「ユーザー/グループへのセキュリティー・ロールのマッピング」**をクリックして、管理ユーザーをマップします。

    ![WAR クラス・ロード順序](install_websphere_sec_role.jpg)

6. **「モジュールの管理」**をクリックします。

    ![WebSphere でのモジュールの管理](install_websphere_manage_modules.jpg)

7. **analytics-receiver** モジュールを選択し、クラス・ローダー順序を**「親が最後」**に変更します。

    ![WebSphere の分析モジュール](install_websphere_module_class_load_order.jpg)

8. 以下のようにして、WebSphere Application Server 管理コンソールで**管理セキュリティー**と**アプリケーション・セキュリティー**を使用可能にします。
    * WebSphere Application Server 管理コンソールにログインします。
    * **「セキュリティー」 > 「グローバル・セキュリティー」**メニューで、**「管理セキュリティーを使用可能にする」**と**「アプリケーション・セキュリティーを使用可能にする」**の両方を必ず選択します。
    > **注**: アプリケーション・セキュリティーは、**管理セキュリティー**が使用可能にされた後にのみ、選択可能です。
    * **「OK」**をクリックし、変更を保存します。

9. Swagger 文書を介して Analytics サービスへのアクセスを有効にするには、以下のステップを実行します。
    * **「サーバー」 > 「サーバー・タイプ」 > 「WebSphere Application Server」**をクリックし、Analytics サービスがデプロイされたサーバーをサーバー・リストから選択します。
    * **「サーバー・インフラストラクチャー」**の下で、**「Java」**をクリックし、**「プロセス管理」 > 「プロセス定義」 > 「Java 仮想マシン」 > 「カスタム・プロパティー」**と進みます。
      - 以下のカスタム・プロパティーを設定します。<br/>
        **プロパティー名:** *com.ibm.ws.classloader.strict*<br/>
        **値:** *true*

10. {{ site.data.keys.mf_analytics_receiver }} アプリケーションを開始し、ブラウザーで正常性 URL (`http://<hostname>:<port>/analytics-receiver/rest/data/health`) にアクセス可能であることを確認します。

## Ant タスクを使用した {{ site.data.keys.mf_analytics_receiver }} のインストール
{: #installing-mobilefirst-analytics-receiver-with-ant-tasks }
必要な WAR ファイルおよび構成ファイルの **analytics-receiver.war** があることを確認します。インストール成果物について詳しくは、[アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストール](../../prod-env/appserver)を参照してください。 **analytics-receiver.war** ファイルは、`MobileFirst_Platform_Server\AnalyticsReceiver` フォルダーにあります。

アプリケーション・サーバー、または WebSphere Application Server Network Deployment 用の Network Deployment Manager がインストールされているコンピューターで Ant タスクを実行する必要があります。 {{ site.data.keys.mf_server }} がインストールされていないコンピューターから Ant タスクを開始したい場合は、ファイル `\<mf_server_install_dir\>/MobileFirstServer/mfp-ant-deployer.jar` をそのコンピューターにコピーする必要があります。

> **注**: **mf_server_install_dir** は、{{ site.data.keys.mf_server }} をインストールしたディレクトリーです。

1. {{ site.data.keys.mf_analytics_receiver }} WAR ファイルをデプロイするために後で使用する Ant スクリプトを編集します。
    * [{{ site.data.keys.mf_analytics_receiver }} のサンプル構成ファイル](../../installation-reference/#sample-configuration-files-for-mobilefirst-analytics)のサンプル構成ファイルを検討します。
    * ファイルの先頭でプレースホルダーの値をプロパティーに置き換えます。

    > **注**: Ant XML スクリプトの値で以下の特殊文字が使用される場合は、エスケープする必要があります。
    >
    > * Apache Ant Manual の『[Properties](http://ant.apache.org/manual/properties.html)』セクションに説明されているように、ドル記号 ($) は、構文 ${variable} によって Ant 変数を明示的に参照する場合を除き、$$ と記述してください。
    > * アンパーサンド文字 (&) は、XML エンティティーを明示的に参照する場合を除き、&amp; と記述してください。
    > * 二重引用符 (") は、単一引用符で囲まれたストリング内にある場合を除き、&quot; と記述してください。

2. WAR ファイルをデプロイするには、次のコマンドを実行します。
   ```bash
   ant -f configure-appServer-analytics-receiver.xml install
   ```
    Ant コマンドは、`mf_server_install_dir/shortcuts` にあります。これにより、{{ site.data.keys.mf_analytics_receiver }} のノードが、サーバー、またはクラスターの各メンバー (WebSphere Application Server Network Deployment にインストールする場合) にインストールされます。
3. Ant ファイルを保存します。 後でフィックスパックの適用時やアップグレードの実行時に、これが必要になる可能性があります。
    パスワードを保存しない場合は、対話式プロンプトのために、`************` (12 個のアスタリスク) に置き換えることができます。
