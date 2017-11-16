---
layout: tutorial
title: アプリケーション・サーバーへの MobileFirst Server のインストール
breadcrumb_title: MobileFirst Server のインストール
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
コンポーネントのインストールは、Ant タスクを使用するか、サーバー構成ツールを使用するか、または手動で行うことができます。コンポーネントをアプリケーション・サーバー上に正常にインストールできるように、前提条件およびインストール・プロセスについての詳細を確認してください。

アプリケーション・サーバーへのコンポーネントのインストールを続行する前に、コンポーネント用のデータベースおよび表が準備されており、使用できる状態になっていることを確認してください。詳しくは、[データベースのセットアップ](../databases)を参照してください。

コンポーネントをインストールするためのサーバー・トポロジーも定義済みである必要があります。[トポロジーとネットワーク・フロー](../topologies)を参照してください。

#### ジャンプ先
{: #jump-to }

* [アプリケーション・サーバーの前提条件](#application-server-prerequisites)
* [サーバー構成ツールを使用したインストール](#installing-with-the-server-configuration-tool)
* [Ant タスクを使用したインストール](#installing-with-ant-tasks)
* [手動での {{ site.data.keys.mf_server }} コンポーネントのインストール](#installing-the-mobilefirst-server-components-manually)
* [サーバー・ファームのインストール](#installing-a-server-farm)

## アプリケーション・サーバーの前提条件
{: #application-server-prerequisites }
{{ site.data.keys.mf_server }} コンポーネントをインストールする前に、アプリケーション・サーバーの選択に応じて以下のトピックのいずれかを選択し、満たすべき前提条件を確認してください。

* [Apache Tomcat の前提条件](#apache-tomcat-prerequisites)
* [WebSphere Application Server Liberty の前提条件](#websphere-application-server-liberty-prerequisites)
* [WebSphere Application Server および WebSphere Application Server Network Deployment の前提条件](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Apache Tomcat の前提条件
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} には、Apache Tomcat の構成に関していくつかの要件があります。その詳細は、以下のトピックで説明されています。  
以下の基準を満たしていることを確認してください。

* サポートされているバージョンの Apache Tomcat を使用してください。[システム要件](../../../product-overview/requirements)を参照してください。
* Apache Tomcat は、JRE 7.0 以降で実行する必要があります。
* 管理サービスとランタイム・コンポーネントとの間の通信を可能にするには、JMX 構成を有効にする必要があります。次の **Apache Tomcat 用の JMX 接続の構成**で説明しているとおり、この通信では RMI を使用します。

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Apache Tomcat 用の JMX 接続の構成手順を参照する場合にクリック</b></a>
</h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Apache Tomcat アプリケーション・サーバー用のセキュア JMX 接続を構成する必要があります。</p>
                <p>サーバー構成ツールと Ant タスクは、デフォルトのセキュア JMX 接続を構成することができます。これには、JMX リモート・ポートの定義、および認証プロパティーの定義が含まれます。サーバー構成ツールと Ant タスクは、<b>tomcat_install_dir/bin/setenv.bat</b> および <b>tomcat_install_dir/bin/setenv.sh</b> を変更して、以下のオプションを <b>CATALINA_OPTS</b> に追加します。</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>注:</b> 8686 はデフォルト値です。このポートの値は、ポートがコンピューターで使用可能でない場合、変更することができます。</p>

                <ul>
                    <li><b>tomcat_install_dir/bin/startup.bat</b> または <b>tomcat_install_dir/bin/catalina.bat</b> を使用して Apache Tomcat を始動する場合は、<b>setenv.bat</b> ファイルが使用されます。</li>
                    <li><b>tomcatInstallDir/bin/startup.sh</b> または <b>tomcat_install_dir/bin/catalina.sh</b> を使用して Apache Tomcat を始動する場合は、<b>setenv.sh</b> ファイルが使用されます。</li>
                </ul>

                <p>別のコマンドを使用して Apache Tomcat を始動する場合は、このファイルが使用されない場合があります。Apache Tomcat Windows Service Installer をインストールした場合、サービス・ランチャーは <b>setenv.bat</b>を使用しません。</p>

                <blockquote><b>重要:</b> この構成は、デフォルトでは保護されていません。構成を保護するには、以下の手順のステップ 2 と 3 を手動で完了する必要があります。</blockquote>

                <p>Apache Tomcat の手動構成</p>

                <ol>
                    <li>単純な構成の場合は、<b>CATALINA_OPTS</b> に以下のオプションを追加します

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>認証をアクティブにするには、Apache Tomcat ユーザー資料の <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL サポート - BIO および NIO</a> と <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL 構成方法</a>を参照してください。</li>
                    <li>For a JMX configuration with SSL enabled, add the following options:
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<key store location>
-Djavax.net.ssl.trustStorePassword=<key store password>
-Djavax.net.ssl.trustStoreType=<key store type>
-Djavax.net.ssl.keyStore=<key store location>
-Djavax.net.ssl.keyStorePassword=<key store password>
-Djavax.net.ssl.keyStoreType=<key store type>
{% endhighlight %}

                    <b>注:</b> ポート 8686 は変更することができます。</li>
                    <li>
                        <p>Tomcat インスタンスがファイアウォールの背後で実行されている場合は、JMX リモート・ライフサイクル・リスナーを構成する必要があります。<a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX リモート・ライフサイクル・リスナー</a>については、Apache Tomcat の資料を参照してください。</p><p>また、以下の例に示すように、以下の環境プロパティーを <b>server.xml</b> ファイル内の管理サービス・アプリケーションの Context セクションに追加する必要があります。</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        上記の例について、以下に説明します。
                        <ul>
                            <li>registryPort の値は、JMX リモート・ライフサイクル・リスナーの <b>rmiRegistryPortPlatform</b> 属性と同じ値でなければなりません。</li>
                            <li>serverPort の値は、JMX リモート・ライフサイクル・リスナーの <b>rmiServerPortPlatform</b> 属性と同じ値でなければなりません。</li>
                        </ul>
                    </li>
                    <li>Apache Tomcat Windows Service Installer を使用して Apache Tomcat をインストールした場合は、<b>CATALINA_OPTS</b> にオプションを追加する代わりに、<b>tomcat_install_dir/bin/Tomcat7w.exe</b> を実行し、「プロパティー」ウィンドウの<b>「Java」</b>タブにオプションを追加してください。

                    <img alt="Apache Tomcat 7 のプロパティー" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty の前提条件
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }} には、Liberty サーバーの構成に関していくつかの要件があります。その詳細は、以下のトピックで説明されています。  

以下の基準を満たしていることを確認してください。

* サポートされているバージョンの Liberty を使用してください。[システム要件](../../../product-overview/requirements)を参照してください。
* Liberty は、JRE 7.0 以降で実行する必要があります。JRE 6.0 はサポートされていません。
* Liberty の一部のバージョンは、Java EE 6 と Java EE 7 の両方のフィーチャーをサポートしています。例えば、jdbc-4.0 Liberty フィーチャーは Java EE 6 の一部で、jdbc-4.1 Liberty フィーチャーは Java EE 7 の一部です。{{ site.data.keys.mf_server }} V8.0.0 は、Java EE 6 または Java EE 7 のフィーチャーと共にインストールできます。ただし、これより古いバージョンの {{ site.data.keys.mf_server }} を同じ Liberty サーバーで実行する場合、Java EE 6 フィーチャーを使用しなければなりません。{{ site.data.keys.mf_server }} V7.1.0 以前は Java EE 7 のフィーチャーをサポートしません。
* 次の JMX は、**WebSphere Application Server Liberty プロファイル用の JMX 接続の構成**の記述に従って構成する必要があります。
* 実稼働環境でのインストールの場合、次の利点を得るために、Windows、Linux、または UNIX システムのサービスとして Liberty サーバーを始動することができます。
コンピューターの始動時に {{ site.data.keys.mf_server }} コンポーネントが自動的に始動する。
プロセスを開始したユーザーがログアウトしても、Liberty サーバーを実行しているプロセスは停止しない。
* {{ site.data.keys.mf_server }} V8.0.0 を、前のバージョンからの {{ site.data.keys.mf_server }} コンポーネントがデプロイされた Liberty サーバーにデプロイすることはできません。
* Liberty 集合環境でのインストールの場合、[Liberty 集合の構成 (Configuring a Liberty) ](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc)に記述されているように、Liberty 集合コントローラーおよび Liberty 集合クラスター・メンバーが構成されている必要があります。

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>WebSphere Application Server Liberty プロファイル用の JMX 接続の構成手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} では、セキュア JMX 接続が構成されている必要があります。</p>

                <ul>
                    <li>サーバー構成ツールと Ant タスクは、デフォルトのセキュア JMX 接続を構成することができます。これには、365 日間の有効期間を持つ自己署名 SSL 証明書の生成が含まれます。この構成は、実稼働環境での使用を目的としたものではありません。 </li>
                    <li>実動使用のためのセキュア JMX 接続を構成するには、<a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Liberty プロファイルへのセキュア JMX 接続の構成</a>に記載された指示に従ってください。</li>
                    <li>REST コネクターは WebSphere Application Server、Liberty Core、および Liberty の他のエディションで使用可能ですが、Liberty サーバーを使用可能フィーチャーのサブセットと共にパッケージすることが可能です。REST コネクターがユーザーの Liberty のインストール済み環境で使用可能かどうかを確認するには、以下のコマンドを入力します。
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>注:</b> このコマンドの出力に restConnector-1.0 が含まれていることを確認してください。</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server および WebSphere Application Server Network Deployment の前提条件
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} には、WebSphere Application Server および WebSphere Application Server Network Deployment の構成に関していくつかの要件があります。その詳細は、以下のトピックで説明されています。  
以下の基準を満たしていることを確認してください。

* サポートされているバージョンの WebSphere Application Server を使用してください。[システム要件](../../../product-overview/requirements)を参照してください。
* アプリケーション・サーバーは、JRE 7.0 で実行する必要があります。デフォルトで、WebSphere Application Server は Java 6.0 SDK を使用します。Java 7.0 SDK に切り替えるには、[WebSphere Application Server での Java 7.0 SDK への切り替え](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html)を参照してください。
* 管理セキュリティーはオンにする必要があります。{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理サービス、および {{ site.data.keys.mf_server }} 構成サービスは、セキュリティー・ロールにより保護されます。詳しくは、[セキュリティーの使用可能化](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en)を参照してください。
* 管理サービスとランタイム・コンポーネントとの間の通信を可能にするには、JMX 構成を有効にする必要があります。この通信では SOAP を使用します。WebSphere Application Server Network Deployment には、RMI を使用できます。詳しくは、次の **WebSphere Application Server および WebSphere Application Server Network Deployment 用の JMX 接続の構成**を参照してください。

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>WebSphere Application Server および WebSphere Application Server Network Deployment 用の JMX 接続の構成手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} では、セキュア JMX 接続が構成されている必要があります。</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }} には、JMX 操作を実行するために、SOAP ポートまたは RMI ポートへのアクセスが必要です。デフォルトで、SOAP ポートは WebSphere Application Server でアクティブです。{{ site.data.keys.mf_server }} は、デフォルトで SOAP ポートを使用します。SOAP ポートおよび RMI ポートの両方が使用不能の場合、{{ site.data.keys.mf_server }} は稼働しません。</li>
                    <li>RMI は WebSphere Application Server Network Deployment でのみサポートされています。RMI は、スタンドアロン・プロファイルまたは WebSphere Application Server サーバー・ファームではサポートされていません。</li>
                    <li>管理セキュリティーとアプリケーション・セキュリティーをアクティブにする必要があります。</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### ファイル・システムの前提条件
{: #file-system-prerequisites }
アプリケーション・サーバーに {{ site.data.keys.mf_server }} をインストールするには、特定のファイル・システムの特権を持つユーザーが {{ site.data.keys.product_adj }} インストール・ツールを実行する必要があります。  
インストール・ツールには以下のものが含まれます。

* IBM Installation Manager
* サーバー構成ツール
* {{ site.data.keys.mf_server }} をデプロイする Ant タスク

WebSphere Application Server Liberty プロファイルの場合、以下の操作を実行するには必要な権限を持っていなければなりません。

* Liberty インストール・ディレクトリーのファイルを読み取る。
* バックアップ・コピーの作成および server.xml と jvm.options の変更のため、Liberty サーバーの構成ディレクトリー内にファイルを作成する。一般的なディレクトリーは usr/servers/server-name です。
* Liberty 共有リソース・ディレクトリー内にファイルおよびディレクトリーを作成する。一般的なディレクトリーは usr/shared です。
* Liberty サーバー apps ディレクトリー内にファイルを作成する。一般的なディレクトリーは usr/servers/server-name/apps です。

WebSphere Application Server フル・プロファイルおよび WebSphere Application Server Network Deployment の場合、以下の操作を実行するには必要な権限を持っていなければなりません。

* WebSphere Application Server インストール・ディレクトリー内のファイルを読み取る。
* Deployment Manager プロファイルで選択した WebSphere Application Server フル・プロファイルの構成ファイルを読み取る。
* wsadmin コマンドを実行する。
* profiles 構成ディレクトリー内にファイルを作成する。インストール・ツールは、共用ライブラリーまたは JDBC ドライバーなどのリソースをこのディレクトリーに格納します。

Apache Tomcat の場合、以下の操作を実行するには必要な権限を持っていなければなりません。

* 構成ディレクトリーを読み取る。
* バックアップ・ファイルを作成し、server.xml および tomcat-users.xml などの構成ディレクトリー内のファイルを変更する。
* バックアップ・ファイルを作成し、setenv.bat などの bin ディレクトリー内のファイルを変更する。
* lib ディレクトリー内にファイルを作成する。
* webapps ディレクトリー内にファイルを作成する。

これらのアプリケーション・サーバーの場合、アプリケーション・サーバーを稼働するユーザーは、{{ site.data.keys.product_adj }} インストール・ツールを実行するユーザーが作成したファイルを読み取ることができる必要があります。

## サーバー構成ツールを使用したインストール
{: #installing-with-the-server-configuration-tool }
サーバー構成ツールを使用して {{ site.data.keys.mf_server }} コンポーネントをアプリケーション・サーバーにインストールします。

サーバー構成ツールはデータベースをセットアップし、コンポーネントをアプリケーション・サーバーにインストールすることができます。このツールは単一ユーザーを対象としています。構成ファイルはディスク上に保管されます。それらが保管されるディレクトリーは、**「ファイル」→「設定」**メニューを使用して変更できます。これらのファイルを使用するのは、1 度にサーバー構成ツールの 1 インスタンスのみにする必要があります。このツールは、同じファイルへの同時アクセスを管理しません。このツールの複数のインスタンスが同じファイルにアクセスしていると、データが消失する可能性があります。ツールがどのようにデータベースを作成およびセットアップするかについて詳しくは、[サーバー構成ツールを使用したデータベース表の作成](../databases/#create-the-database-tables-with-the-server-configuration-tool)を参照してください。データベースが存在する場合、ツールは一部のテスト表の存在と内容をテストすることによりそれらを検出でき、それらのデータベース表を変更しません。

* [サポートされるオペレーティング・システム](#supported-operating-systems)
* [サポートされるトポロジー](#supported-topologies)
* [サーバー構成ツールの実行](#running-the-server-configuration-tool)
* [サーバー構成ツールを使用したフィックスパックの適用](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### サポートされるオペレーティング・システム
{: #supported-operating-systems }
以下のオペレーティング・システムをご使用の場合、サーバー構成ツールを使用できます。

* Windows x86 または x86-64
* macOS x86-64
* Linux x86 または Linux x86-64

その他のオペレーティング・システムでは、本ツールは使用できません。[Ant タスクを使用したインストール](#installing-with-ant-tasks)の説明に従い、Ant タスクを使用して {{ site.data.keys.mf_server }} コンポーネントをインストールする必要があります。

### サポートされるトポロジー
{: #supported-topologies }
サーバー構成ツールは、以下のトポロジーで {{ site.data.keys.mf_server }} コンポーネントをインストールします。

* すべてのコンポーネント ({{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイム) は同じアプリケーション・サーバー内にあります。ただし、WebSphere Application Server Network Deployment では、クラスターにインストールするときに、管理サービスおよびライブ更新サービス用とランタイム用とで異なるクラスターを指定することができます。Liberty 集合では、{{ site.data.keys.mf_console }}、管理サービス、およびライブ更新サービスは集合コントローラーにインストールされ、ランタイムは集合メンバーにインストールされます。
* {{ site.data.keys.mf_server }} プッシュ・サービスをインストールする場合は、それも同じサーバーにインストールします。ただし、WebSphere Application Server Network Deployment では、クラスターにインストールするときに、プッシュ・サービス用に異なるクラスターを指定することができます。Liberty 集合では、プッシュ・サービスは Liberty メンバー (ランタイムがインストールされたのと同じメンバーでも可) にインストールされます。
* すべてのコンポーネントは、同じデータベース・システムとユーザーを使用します。DB2 の場合、すべてのコンポーネントが同じスキーマも使用します。
* サーバー構成ツールは、非対称デプロイメントの Liberty 集合および WebSphere Application Server Network Deployment の場合を除いて、単一サーバー用にコンポーネントをインストールします。複数サーバーへのインストールの場合は、ツールを実行した後にファームを構成する必要があります。サーバー・ファーム構成は、WebSphere Application Server Network Deployment では必要ありません。

他のトポロジーまたは他のデータベース設定を使用するには、代わりに Ant タスクを使用するか手動でコンポーネントをインストールすることができます。

### サーバー構成ツールの実行
{: #running-the-server-configuration-tool }
サーバー構成ツールを実行する前に、必ず以下の要件が満たされるようにしてください。

* コンポーネント用のデータベースおよび表が用意されていて、使用できる状態にある。[データベースのセットアップ](../databases)を参照してください。
* コンポーネントをインストールするためのサーバー・トポロジーが決められている。[トポロジーとネットワーク・フロー](../topologies)を参照してください。
* アプリケーション・サーバーが構成済みである。[アプリケーション・サーバーの前提条件](#application-server-prerequisites)を参照してください。
* ツールを実行するユーザーが特定のファイル・システム特権を付与されている。[ファイル・システムの前提条件](#file-system-prerequisites)を参照してください。

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>構成ツールの実行手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>サーバー構成ツールを始動します。
                        <ul>
                            <li>Linux の場合、アプリケーションのショートカットから<b>「アプリケーション」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」</b>とクリックします。</li>
                            <li>Windows の場合、<b>「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」</b>とクリックします。</li>
                            <li>macOS の場合、シェル・コンソールを開きます。<b>mfp_server_install_dir/shortcuts</b> に移動し、<b>./configuration-tool.sh</b> と入力します。</li>
                            <li><b>mfp_server_install_dir</b> ディレクトリーが、{{ site.data.keys.mf_server }} をインストールした場所です。</li>
                        </ul>
                    </li>
                    <li><b>「ファイル (File)」→「新規構成 (New Configuration)」</b>を選択して {{ site.data.keys.mf_server }} 構成を作成します。
                        <ul>
                            <li><b>「構成の詳細 (Configuration Details)」</b>パネルで、管理サービスとランタイム・コンポーネントのコンテキスト・ルートを入力します。環境 ID を入力することもできます。環境 ID は、例えば<a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">同じアプリケーション・サーバーまたは同じ WebSphere Application Server セルに {{ site.data.keys.mf_server }} の複数のインストール済み環境を作成する</a>場合など、高度なユース・ケースにおいて使用します。</li>
                            <li><b>「コンソール設定」</b>パネルで、{{ site.data.keys.mf_console }} をインストールするかどうか選択します。コンソールをインストールしない場合、コマンド・ライン・ツール (<b>mfpdev</b> または <b>mfpadm</b>) あるいは REST API を使用して {{ site.data.keys.mf_server }} 管理サービスと対話する必要があります。</li>
                            <li><b>「データベース選択 (Database Selection)」</b>パネルで、使用する予定のデータベース管理システムを選択します。すべてのコンポーネントが同じデータベース・タイプおよび同じデータベース・インスタンスを使用します。データベース・ペインについて詳しくは、<a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">サーバー構成ツールを使用したデータベース表の作成</a>を参照してください。</li>
                            <li><b>「アプリケーション・サーバー選択 (Application Server Selection)」</b>パネルで、{{ site.data.keys.mf_server }} をデプロイするアプリケーション・サーバーのタイプを選択します。</li>
                        </ul>
                    </li>
                    <li><b>「アプリケーション・サーバー設定 (Application Server Settings)」</b>パネルで、アプリケーション・サーバーを選択して以下のステップを実行してください。
                        <ul>
                            <li>インストール先が WebSphere Application Server Liberty の場合:
                                <ul>
                                    <li>Liberty のインストール・ディレクトリーおよび {{ site.data.keys.mf_server }} をインストールするサーバーの名前を入力します。</li>
                                    <li>コンソールにログインするためのデフォルト・ユーザーを作成します。このユーザーは Liberty の基本レジストリーに作成されます。実動インストールの場合は、<b>「デフォルト・ユーザーの作成」</b>オプションをクリアして、インストール後にユーザー・アクセスを構成することもできます。詳しくは、<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成</a>を参照してください。</li>
                                    <li><b>「スタンドアロン・デプロイメント」</b> (デフォルト)、<b>「サーバー・ファーム・デプロイメント」</b>、または<b>「Liberty 集合デプロイメント」</b>のいずれかのデプロイメント・タイプを選択します。</li>
                                </ul>

                                「Liberty 集合デプロイメント」オプションを選択する場合、以下の手順を実行してください。
                                <ul>
                                    <li>Liberty 集合サーバーを指定します。
                                        <ul>
                                            <li>管理サービス、{{ site.data.keys.mf_console }}、およびライブ更新サービスのインストール先。このサーバーは、Liberty 集合コントローラーでなければなりません。</li>
                                            <li>ランタイムのインストール先。このサーバーは、Liberty 集合メンバーでなければなりません。</li>
                                            <li>プッシュ・サービスのインストール先。このサーバーは、Liberty 集合メンバーでなければなりません。</li>
                                        </ul>
                                    </li>
                                    <li>メンバーのサーバー ID を入力します。この ID は、集合内のメンバーごとに異なっていなければなりません。</li>
                                    <li>集合メンバーのクラスター名を入力します。</li>
                                    <li>コントローラーのホスト名および HTTPS ポート番号を入力します。これらの値は、Liberty 集合コントローラーの <b>server.xml</b> ファイル内の <code>variable</code> エレメントで定義されたものと同じでなければなりません。</li>
                                    <li>コントローラーの管理者ユーザー名およびパスワードを入力します。</li>
                                </ul>
                            </li>
                            <li>インストール先が WebSphere Application Server または WebSphere Application Server Network Deployment の場合:
                                <ul>
                                    <li>WebSphere Application Server のインストール・ディレクトリーを入力します。</li>
                                    <li>{{ site.data.keys.mf_server }} をインストールする WebSphere Application Server プロファイルを選択します。WebSphere Application Server Network Deployment にインストールする場合は、デプロイメント・マネージャーのプロファイルを選択してください。デプロイメント・マネージャーのプロファイルで、スコープ (<b>サーバー</b>または<b>クラスター</b>) を選択できます。<b>「クラスター」</b>を選択する場合、クラスターを指定する必要があります。
                                        <ul>
                                            <li>ランタイムのインストール先。</li>
                                            <li>管理サービス、{{ site.data.keys.mf_console }}、およびライブ更新サービスのインストール先。</li>
                                            <li>プッシュ・サービスのインストール先。</li>
                                        </ul>
                                    </li>
                                    <li>管理者のログイン ID およびパスワードを入力します。管理者ユーザーは、管理者ロールを持っている必要があります。</li>
                                    <li><b>「WebSphere 管理者を {{ site.data.keys.mf_console }} の管理者として宣言 (Declare the WebSphere Administrator as an administrator of {{ site.data.keys.mf_console }})」</b>オプションを選択すると、{{ site.data.keys.mf_server }} のインストールに使用されたユーザーは、コンソールの管理セキュリティー・ロールにマップされ、管理者の権限を持ってコンソールにログインできます。また、このユーザーはライブ更新サービスのセキュリティー・ロールにもマップされます。そのユーザー名とパスワードは、管理サービスの JNDI プロパティー (<b>mfp.config.service.user</b> および <b>mfp.config.service.password</b>) として設定されます。</li>
                                    <li><b>「WebSphere 管理者を {{ site.data.keys.mf_console }} の管理者として宣言 (Declare the WebSphere Administrator as an administrator of {{ site.data.keys.mf_console }})」</b>オプションを選択すると、{{ site.data.keys.mf_server }} のインストールに使用されたユーザーは、コンソールの管理セキュリティー・ロールにマップされ、管理者の権限を持ってコンソールにログインできます。
                                        <ul>
                                            <li>以下の方法で、管理サービスとライブ更新サービスの間の通信を使用可能にする。
                                                <ul>
                                                    <li>ライブ更新サービスのセキュリティー・ロール <b>configadmin</b> にユーザーをマップする。</li>
                                                    <li>このユーザーのログイン ID とパスワードを管理サービスの JNDI プロパティー (<b>mfp.config.service.user</b> および <b>mfp.config.service.password</b>) に追加する。</li>
                                                    <li>1 人以上のユーザーを、管理サービスおよび {{ site.data.keys.mf_console }} のセキュリティー・ロールにマップします。<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成</a>を参照してください。</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>インストール先が Apache Tomcat の場合:
                                <ul>
                                    <li>Apache Tomcat のインストール・ディレクトリーを入力します。</li>
                                    <li>RMI との JMX 通信に使用するポートを入力します。デフォルトで、この値は 8686 です。サーバー構成ツールは、<b>tomcat_install_dir/bin/setenv.bat</b> ファイルまたは <b>tomcat_install_dir/bin/setenv.sh</b> ファイルを変更してこのポートを開きます。手動でポートを開きたい場合や、ポートを開くコードが既に <b>setenv.bat</b> または <b>setenv.sh</b> にある場合は、このツールを使用しないでください。その場合、代わりに Ant タスクを使用してインストールします。Ant タスクでのインストールの場合は、RMI ポートを手動で開くオプションが提供されます。</li>
                                    <li>コンソールにログインするためのデフォルト・ユーザーを作成します。このユーザーは、<b>tomcat-users.xml</b> 構成ファイルでも作成されます。実動インストールの場合は、「デフォルト・ユーザーの作成」オプションをクリアして、インストール後にユーザー・アクセスを構成することもできます。詳しくは、<a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成</a>を参照してください。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>アプリケーション・サーバーにプッシュ・サービスをインストールする場合は、<b>「プッシュ・サービスの設定 (Push Service Settings)」</b>パネルで<b>「プッシュ・サービスをインストール (Install the Push service)」</b>オプションを選択します。コンテキスト・ルートは <b>imfpush</b> です。プッシュ・サービスと管理サービスの間の通信を使用可能にするには、以下のパラメーターを定義する必要があります。
                        <ul>
                            <li>プッシュ・サービスの URL とランタイムの URL を入力します。Liberty、Apache Tomcat、またはスタンドアロンの WebSphere Application Server にインストールする場合、この URL は自動計算できます。これにはローカル・サーバー上のコンポーネント (ランタイムまたはプッシュ・サービス) の URL が使用されます。WebSphere Application Server Network Deployment にインストールする場合、あるいは Web プロキシーまたはロード・バランサーを使用して通信が行われる場合は、URL を手動で入力する必要があります。</li>
                            <li>サービス間の OAuth 通信用に、機密クライアント ID および秘密鍵を入力します。入力しない場合、ツールによってデフォルトの値とランダム・パスワードが生成されます。</li>
                        </ul>
                    </li>
                    <li>{{ site.data.keys.mf_analytics }} がインストールされている場合、 <b>「Analytics 設定 (Analytics Settings)」</b>パネルで<b>「Analytics サーバーへの接続を使用可能にする (Enable the connection to the Analytics server)」</b>を選択します。以下の接続設定を入力します。
                        <ul>
                            <li>Analytics コンソールの URL。</li>
                            <li>Analytics サーバー (Analytics データ・サービス) の URL。</li>
                            <li>Analytics サーバーへのデータの公開を許可されているユーザーのログイン ID とパスワード。</li>
                        </ul>

                        ツールにより、ランタイムおよびプッシュ・サービスが Analytics サーバーにデータを送信するよう構成されます。
                    </li>
                    <li><b>「デプロイ」</b>をクリックしてインストールを続行します。</li>
                </ol>
            </div>
        </div>
    </div>
</div>

インストールが正常に完了した後、Apache Tomcat または Liberty プロファイルの場合はアプリケーション・サーバーを再始動します。

Apache Tomcat がサービスとして起動される場合、RMI を開くためのステートメントを含む setenv.bat ファイルまたは setenv.sh ファイルが読み取られない可能性があります。その結果、{{ site.data.keys.mf_server }} が正常に機能しない可能性があります。必要な変数を設定するには、[Apache Tomcat 用の JMX 接続の構成](#apache-tomcat-prerequisites)を参照してください。

WebSphere Application Server Network Deployment では、アプリケーションはインストールされますが、開始はされません。手動で開始する必要があります。この操作は、WebSphere Application Server 管理コンソールから行うことができます。

構成ファイルはサーバー構成ツール内に保持してください。このファイルは暫定修正のインストール時に再使用する場合があります。暫定修正を適用するメニューは、**「構成 (Configurations)」>「デプロイ済みの WAR ファイルを置換する (Replace the deployed WAR files)」**です。

### サーバー構成ツールを使用したフィックスパックの適用
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
{{ site.data.keys.mf_server }} が構成ツールを使用してインストールされていて、構成ファイルが保持されている場合は、構成ファイルを再使用してフィックスパックまたは暫定修正を適用できます。

1. サーバー構成ツールを始動します。
    * Linux の場合、アプリケーションのショートカットから**「アプリケーション」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * Windows の場合、**「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * macOS の場合、シェル・コンソールを開きます。**mfp\_server\_install_dir/shortcuts** に移動し、**./configuration-tool.sh** と入力します。
    * **mfp\_server\_install\_dir** ディレクトリーが、{{ site.data.keys.mf_server }} をインストールした場所です。

2. **「構成」→「デプロイ済みの WAR ファイルを置換する (Replace the deployed WAR files)」**をクリックし、フィックスパックまたは暫定修正を適用する既存の構成を選択します。

## Ant タスクを使用したインストール
{: #installing-with-ant-tasks }
Ant タスクを使用して、{{ site.data.keys.mf_server }} コンポーネントをアプリケーション・サーバーにインストールします。

{{ site.data.keys.mf_server }} をインストールするためのサンプル構成ファイルは、**mfp\_install\_dir/MobileFirstServer/configuration-samples** ディレクトリーにあります。

また、サーバー構成ツールを使用して構成を作成し、**「ファイル」→「構成を Ant ファイルとしてエクスポート...(Export Configuration as Ant Files...)」**を使用して Ant ファイルをエクスポートすることもできます。サンプル Ant ファイルには、以下のようにサーバー構成ツールと同じ制限があります。

* すべてのコンポーネント ({{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、{{ site.data.keys.mf_server }} 成果物、および {{ site.data.keys.product_adj }} ランタイム) は同じアプリケーション・サーバーにあります。ただし、WebSphere Application Server Network Deployment では、クラスターにインストールするときに、管理サービスおよびライブ更新サービス用とランタイム用とで異なるクラスターを指定することができます。
* {{ site.data.keys.mf_server }} プッシュ・サービスをインストールする場合は、それも同じサーバーにインストールします。ただし、WebSphere Application Server Network Deployment では、クラスターにインストールするときに、プッシュ・サービス用に異なるクラスターを指定することができます。
* すべてのコンポーネントは、同じデータベース・システムとユーザーを使用します。DB2 の場合、すべてのコンポーネントが同じスキーマも使用します。
* サーバー構成ツールは、単一サーバー用のコンポーネントをインストールします。複数サーバーへのインストールの場合は、ツールを実行した後にファームを構成する必要があります。サーバー・ファーム構成は WebSphere Application Server Network Deployment ではサポートされていません。

Ant タスクを使用して、サーバー・ファームで実行するように {{ site.data.keys.mf_server }} サービスを構成できます。サーバーをファームに含めるには、アプリケーション・サーバーを適切に構成するためのいくつかの特定の属性を指定する必要があります。Ant タスクを使用したサーバー・ファームの構成について詳しくは、[Ant タスクを使用したサーバー・ファームのインストール](#installing-a-server-farm-with-ant-tasks)を参照してください。

[トポロジーとネットワーク・フロー](../topologies)でサポートされている他のトポロジーについては、サンプル Ant ファイルを変更できます。

Ant タスクの参照は以下のとおりです。

* [{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 成果物、{{ site.data.keys.mf_server }} 管理サービス、およびライブ更新サービスのインストールのための Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [{{ site.data.keys.mf_server }} プッシュ・サービスのインストールに関する Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

サンプル構成ファイルとタスクを使用したインストールの概要については、[コマンド・ライン・モードでの {{ site.data.keys.mf_server }} のインストール](../tutorials/command-line)を参照してください。

Ant ファイルは、製品インストールの一部である Ant ディストリビューションを使用して実行できます。例えば、WebSphere Application Server Network Deployment クラスターがあり、データベースが IBM DB2 の場合は、**mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** Ant ファイルを使用できます。このファイルを編集し、必要なすべてのプロパティーを入力したら、**mfp\_install\_dir/MobileFirstServer/configuration-samples** ディレクトリーから以下のコマンドを実行できます。

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - このコマンドは、一部のコンポーネントをインストール、アンインストール、または更新する、Ant ファイルのすべての可能なターゲットのリストを表示します。
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install** - このコマンドは、Ant ファイルのプロパティーに入力されたパラメーターを使用して、DB2 をデータ・ソースとして、{{ site.data.keys.mf_server }} を WebSphere Application Server Network Deployment クラスター上にインストールします。

<br/>
インストール後、フィックスパックを適用する際に再使用できるように、Ant ファイルのコピーを作成します。

### Ant ファイルを使用したフィックスパックの適用
{: #applying-a-fix-pack-by-using-the-ant-files }

#### サンプル Ant ファイルを使用した更新
{: #updating-with-the-sample-ant-file }
**mfp\_install\_dir/MobileFirstServer/configuration-samples** ディレクトリー内に用意されているサンプル Ant ファイルを使用して {{ site.data.keys.mf_server }} をインストールする場合、この Ant ファイルのコピーを再使用してフィックスパックを適用することができます。パスワードの値には、実際の値の代わりに 12 個の星印 (\*) を入力することができます。こうすると Ant ファイルの実行時に対話式にプロンプトが出されます。

1. Ant ファイルの **mfp.server.install.dir** プロパティーの値を確認します。この値は、フィックスパックが適用された製品が含まれているディレクトリーを指している必要があります。この値は、更新済みの {{ site.data.keys.mf_server }} WAR ファイルを取得するのに使用されます。
2. 次のコマンドを実行します。`mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### 独自の Ant ファイルを使用した更新
{: #updating-with-own-ant-file }
独自の Ant ファイルを使用する場合、それぞれのインストール・タスク (**installmobilefirstadmin**、**installmobilefirstruntime**、および **installmobilefirstpush**) に対応する、同じパラメーターを持つ更新タスクを、Ant ファイルに含めるようにしてください。対応する更新タスクは、**updatemobilefirstadmin**、**updatemobilefirstruntime**、および **updatemobilefirstpush** です。

1. **mfp-ant-deployer.jar** ファイルの **taskdef** エレメントのクラスパスを確認します。これは、{{ site.data.keys.mf_server }} のインストール済み環境内の、フィックスパックの適用された **mfp-ant-deployer.jar** ファイルを指している必要があります。デフォルトでは、更新された {{ site.data.keys.mf_server }} WAR ファイルは **mfp-ant-deployer.jar** のロケーションから取得されます。
2. ご使用の Ant ファイルの更新タスク (**updatemobilefirstadmin**、**updatemobilefirstruntime**、および **updatemobilefirstpush**) を実行します。

### サンプル Ant ファイルの変更
{: #sample-ant-files-modifications }
インストール要件に適応するように、**mfp\_install\_dir/MobileFirstServer/configuration-samples** ディレクトリー内に用意されているサンプル Ant ファイルを変更することができます。  
以下のセクションでは、インストールを要件に適応させるためにサンプル Ant ファイルを変更する方法について、詳細な情報を提供します。

1. [追加の JNDI プロパティーの指定](#specify-extra-jndi-properties)
2. [既存のユーザーの指定](#specify-existing-users)
3. [Liberty Java EE レベルの指定](#specify-liberty-java-ee-level)
4. [データ・ソースの JDBC プロパティーの指定](#specify-data-source-jdbc-properties)
5. [{{ site.data.keys.mf_server }} がインストールされていないコンピューターでの Ant ファイルの実行](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [WebSphere Application Server Network Deployment ターゲットの指定](#specify-websphere-application-server-network-deployment-targets)
7. [Apache Tomcat での RMI ポートの手動構成](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### 追加の JNDI プロパティーの指定
{: #specify-extra-jndi-properties }
**installmobilefirstadmin**、**installmobilefirstruntime**、および **installmobilefirstpush** の各 Ant タスクは、コンポーネントを機能させるために必要となる JNDI プロパティーの値を宣言します。これらの JNDI プロパティーは、JMX 通信を定義するのに使用します。また、他のコンポーネント (ライブ更新サービス、プッシュ・サービス、分析サービス、または許可サーバーなど) へのリンクを定義するのにも使用します。ただし、他の JNDI プロパティーの値も定義できます。これらの 3 つのタスクのために存在する `<property>` エレメントを使用します。JNDI プロパティーのリストについては、以下を参照してください。

* [{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

例えば、次のとおりです。

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin> 
```

#### 既存のユーザーの指定
{: #specify-existing-users }
デフォルトで、**installmobilefirstadmin** Ant タスクにより以下のようにユーザーが作成されます。

* WebSphere Application Server Liberty で、JMX 通信用の Liberty 管理者を定義する。
* 任意のアプリケーション・サーバーで、ライブ更新サービスとの通信に使用するユーザーを定義する。

新規ユーザーを作成するのでなく既存ユーザーを使用するには、以下の操作を実行します。

1. `<jmx>` エレメントで、ユーザーとパスワードを指定し、**createLibertyAdmin** 属性の値を false に設定します。例えば、次のとおりです。

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. `<configuration>` エレメントで、ユーザーとパスワードを指定し、**createConfigAdminUser** 属性の値を false に設定します。例えば、次のとおりです。

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

また、サンプル Ant ファイルにより作成されるユーザーは、管理サービスおよび管理コンソールのセキュリティー・ロールにマップされます。この設定により、インストール後、このユーザーを使用して {{ site.data.keys.mf_server }} にログオンすることができます。この振る舞いを変更するには、`<user>` エレメントをサンプル Ant ファイルから削除します。もしくは、**password** 属性を `<user>` エレメントから削除することもできます。こうすると、アプリケーション・サーバーのローカル・レジストリーにユーザーが作成されません。

#### Liberty Java EE レベルの指定
{: #specify-liberty-java-ee-level }
WebSphere Application Server Liberty の一部のディストリビューションでは、Java EE 6、または Java EE 7 のフィーチャーがサポートされます。デフォルトで、インストール対象のフィーチャーが Ant タスクによって自動的に検出されます。例えば、Java EE 6 用には **jdbc-4.0** Liberty フィーチャーがインストールされ、Java EE 7 用には **jdbc-4.1** フィーチャーがインストールされます。Liberty インストール済み環境が Java EE 6 および Java EE 7 の両方のフィーチャーをサポートする場合、特定のレベルのフィーチャーを強制することが可能です。一例として、同じ Liberty サーバーで {{ site.data.keys.mf_server }} V8.0.0 および V7.1.0 の両方を実行するよう計画する場合があります。{{ site.data.keys.mf_server }} V7.1.0 以前がサポートするのは Java EE 6 フィーチャーのみです。

Java EE 6 フィーチャーの特定のレベルを強制するには、`<websphereapplicationserver>` エレメントの jeeversion 属性を使用します。例えば、次のとおりです。

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### データ・ソースの JDBC プロパティーの指定
{: #specify-data-source-jdbc-properties }
JDBC 接続のプロパティーを指定できます。`<database>` エレメントの `<property>` エレメントを使用します。このエレメントは、**configureDatabase**、**installmobilefirstadmin**、**installmobilefirstruntime**、および **installmobilefirstpush** の各 Ant タスクで使用可能です。例えば、次のとおりです。

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### {{ site.data.keys.mf_server }} がインストールされていないコンピューターでの Ant ファイルの実行
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
{{ site.data.keys.mf_server }} がインストールされていないコンピューターで Ant ファイルを実行するには、以下の項目が必要です。

* Ant インストール済み環境
* **mfp-ant-deployer.jar** ファイルのリモート・コンピューターへのコピー。このライブラリーには Ant タスクの定義が含まれます。
* インストールするリソースの指定。デフォルトで、WAR ファイルは **mfp-ant-deployer.jar** 付近で取得されますが、これらの WAR ファイルの場所を指定することもできます。例えば、次のとおりです。

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

詳しくは、[インストールに関する参照情報](../installation-reference)で、各 {{ site.data.keys.mf_server }} コンポーネントをインストールする Ant タスクを参照してください。

#### WebSphere Application Server Network Deployment ターゲットの指定
{: #specify-websphere-application-server-network-deployment-targets }
WebSphere Application Server Network Deployment にインストールするには、指定された WebSphere Application Server プロファイルがデプロイメント・マネージャーでなければなりません。以下の構成にデプロイできます。

* クラスター
* シングル・サーバー
* セル (セルのすべてのサーバー)
* ノード (ノードのすべてのサーバー) 

**configure-wasnd-cluster-dbms-name.xml**、**configure-wasnd-server-dbms-name.xml**、および **configure-wasnd-node-dbms-name.xml** などのサンプル・ファイルには、各タイプのターゲットにデプロイする宣言が含まれています。詳しくは、[インストールに関する参照情報](../installation-reference)で、各 {{ site.data.keys.mf_server }} コンポーネントをインストールする Ant タスクを参照してください。

> 注: V8.0.0 以降、WebSphere Application Server Network Deployment セル用のサンプル構成ファイルは提供されません。


#### Apache Tomcat での RMI ポートの手動構成
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
デフォルトで、Ant タスクは **setenv.bat** ファイルまたは **setenv.sh** ファイルを変更して RMI ポートを開きます。RMI ポートを手動で開きたい場合は、値を false にして **tomcatSetEnvConfig** 属性を **installmobilefirstadmin** タスク、**updatemobilefirstadmin** タスク、および **uninstallmobilefirstadmin** タスクの `<jmx>` エレメントに追加します。

## 手動での {{ site.data.keys.mf_server }} コンポーネントのインストール
{: #installing-the-mobilefirst-server-components-manually }
{{ site.data.keys.mf_server }} コンポーネントを手動でアプリケーション・サーバーにインストールすることもできます。  
以下のトピックは、サポートされる実動アプリケーションへのコンポーネントのインストール・プロセスをガイドするための完全情報を提供します。

* [WebSphere Application Server Liberty への手動インストール](#manual-installation-on-websphere-application-server-liberty)
* [WebSphere Application Server Liberty 集合への手動インストール](#manual-installation-on-websphere-application-server-liberty-collective)
* [Apache Tomcat への手動インストール](#manual-installation-on-apache-tomcat)
* [WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### WebSphere Application Server Liberty への手動インストール
{: #manual-installation-on-websphere-application-server-liberty }
[WebSphere Application Server Liberty の前提条件](#websphere-application-server-liberty-prerequisites)に記載されている要件を満たしていることも確認してください。

* [トポロジーの制約](#topology-constraints)
* [アプリケーション・サーバーの設定](#application-server-settings)
* [{{ site.data.keys.mf_server }} アプリケーションに必要な Liberty フィーチャー](#liberty-features-required-by-the-mobilefirst-server-applications)
* [グローバル JNDI 項目](#global-jndi-entries)
* [クラス・ローダー](#class-loader)
* [パスワード・デコーダー・ユーザー・フィーチャー](#password-decoder-user-feature)
* [構成の詳細](#configuration-details-liberty)

#### トポロジーの制約
{: #topology-constraints }
{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および MobileFirst ランタイムは同じアプリケーション・サーバー上にインストールする必要があります。ライブ更新サービスのコンテキスト・ルートは **the-adminContextRootconfig** と定義します。プッシュ・サービスのコンテキスト・ルートは **imfpush** にする必要があります。制約について詳しくは、[{{ site.data.keys.mf_server }} コンポーネントおよび {{ site.data.keys.mf_analytics }} に対する制約](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)を参照してください。

#### アプリケーション・サーバーの設定
{: #application-server-settings }
サーブレットを即時ロードするように **webContainer** エレメントを構成する必要があります。この設定は、JMX を使用した初期化に必要です。例えば、次のとおりです。`<webContainer deferServletLoad="false"/>`

オプションで、一部の Liberty バージョンでランタイムおよび管理サービスの始動シーケンスが中断されるタイムアウトの問題を避けるために、デフォルトの **executor** エレメントを変更できます。**coreThreads** 属性と **maxThreads** 属性に大きい値を設定します。例えば、次のとおりです。

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

また、**tcpOptions** エレメントを構成し、次のように **soReuseAddr** 属性を `true` に設定することもできます。`<tcpOptions soReuseAddr="true"/>`

#### {{ site.data.keys.mf_server }} アプリケーションに必要な Liberty フィーチャー
{: #liberty-features-required-by-the-mobilefirst-server-applications }
以下の Java EE 6 または Java EE 7 のフィーチャーを使用できます。

**{{ site.data.keys.mf_server }} 管理サービス**

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} プッシュ・サービス**  

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **servlet-3.0** (Java EE 7 の場合 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} ランタイム**  

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **servlet-3.0** (Java EE 7 の場合 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### グローバル JNDI 項目
{: #global-jndi-entries }
ランタイムと管理サービス間の JMX 通信を構成するために、以下のグローバル JNDI 項目が必要です。

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

これらのグローバル JNDI 項目はこの構文を使用して設定され、コンテキスト・ルートの接頭部は付きません。例えば、次のとおりです。`<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`

> **注:** JNDI 値の自動変換から保護し、075 が 61 に、または 31.500 が 31.5 に変換されないようにするには、値を定義するときにこの構文 '"075"' を使用してください。



管理サービスの JNDI プロパティーについて詳しくは、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。  

ファーム構成については、以下のトピックも参照してください。

* [サーバー・ファームのトポロジー](../topologies/#server-farm-topology)
* [トポロジーとネットワーク・フロー](../topologies)
* [サーバー・ファームのインストール](#installing-a-server-farm)

#### クラス・ローダー
{: #class-loader }
すべてのアプリケーションで、クラス・ローダーは、親が最後の委任になっている必要があります。例えば、次のとおりです。

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### パスワード・デコーダー・ユーザー・フィーチャー
{: #password-decoder-user-feature }
パスワード・デコーダー・ユーザー・フィーチャーを Liberty プロファイルにコピーします。例えば、次のとおりです。

* UNIX および Linux システムの場合:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Windows システムの場合: 

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### 構成の詳細
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>{{ site.data.keys.mf_server }} 管理サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>管理サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。管理サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpadmin</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、管理サービスのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mfpadmin</b> を使用して管理サービスがインストールされている場合に <b>mfp.admin.push.url</b> を宣言するケースを示しています。</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>プッシュ・サービスがインストールされている場合は、以下の JNDI プロパティーを構成する必要があります。</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>構成サービスとの通信用の JNDI プロパティーは以下のとおりです。</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>管理サービスのデータ・ソースの JNDI 名は、<b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b> と定義する必要があります。以下の例は、管理サービスが、コンテキスト・ルート <b>/mfpadmin</b> を使用してインストールされており、そのサービスがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで以下のロールを宣言します。</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>{{ site.data.keys.mf_server }} ライブ更新サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>ライブ更新サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>ライブ更新サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> にあります。ライブ更新サービスのコンテキスト・ルートは <b>/the-adminContextRootconfig</b> のように定義する必要があります。例えば、管理サービスのコンテキスト・ルートが <b>/mfpadmin</b> の場合、ライブ更新サービスのコンテキスト・ルートは <b>/mfpadminconfig</b> でなければなりません。</p>

                <h3>データ・ソース</h3>
                <p>ライブ更新サービスのデータ・ソースの JNDI 名は contextRoot/jdbc/ConfigDS と定義する必要があります。以下の例は、ライブ更新サービスが、コンテキスト・ルート /mfpadminconfig を使用してインストールされており、そのサービスがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで configadmin ロールを宣言します。少なくとも 1 人のユーザーがこのロールにマップされている必要があります。ユーザーとパスワードは、管理サービスの以下の JNDI プロパティーに指定する必要があります。</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>{{ site.data.keys.mf_console }}  の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>このコンソールは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>コンソール WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpconsole</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、コンソールのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mfpconsole</b> を使用してコンソールがインストールされている場合に <b>mfp.admin.endpoint</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint プロパティーの標準的な値は <b>*://*:*/the-adminContextRoot</b> です。<br/>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} の JNDI プロパティー</a>を参照してください。</p>

                <h3>セキュリティー・ロール</h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで以下のロールを宣言します。</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                コンソールのセキュリティー・ロールにマップされているユーザーは、管理サービスの同じセキュリティー・ロールにもマップされている必要があります。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>MobileFirst ランタイムの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>このランタイムは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>ランタイム WAR ファイルは、<b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、デフォルトでは <b>/mfp</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、ランタイムのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mobilefirst</b> を使用してランタイムがインストールされている場合に <b>mfp.analytics.url</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}
                <p><b>mobilefirst/mfp.authorization.server</b> プロパティーを定義する必要があります。例えば、次のとおりです。</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>{{ site.data.keys.mf_analytics }} がインストールされている場合は、以下の JNDI プロパティーを定義する必要があります。</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>ランタイムのデータ・ソースの JNDI 名は、<b>jndiName=the-contextRoot/jdbc/mfpDS</b> と定義する必要があります。以下の例は、ランタイムが、コンテキスト・ルート <b>/mobilefirst</b> を使用してインストールされており、ランタイムがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>{{ site.data.keys.mf_server }} プッシュ・サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>プッシュ・サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>プッシュ・サービスの WAR ファイルは <b>mfp_install_dir/PushService/mfp-push-service.war</b> にあります。コンテキスト・ルートは <b>/imfpush</b> と定義する必要があります。さもないと、コンテキスト・ルートは SDK にハードコーディングされているため、クライアント・デバイスはプッシュ・サービスに接続できません。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、プッシュ・サービスのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/imfpush</b> を使用してプッシュ・サービスがインストールされている場合に <b>mfp.push.analytics.user</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                以下のプロパティーを定義する必要があります。
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - この値は <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> でなければなりません。</li>
                    <li><b>mfp.push.db.type</b> - リレーショナル・データベースの場合、この値は DB でなければなりません。</li>
                </ul>

                {{ site.data.keys.mf_analytics }} が構成されている場合は、以下の JNDI プロパティーを定義します。
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - この値は <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> でなければなりません。</li>
                </ul>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト</a>を参照してください。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>{{ site.data.keys.mf_server }} 成果物の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>この成果物コンポーネントは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>このコンポーネントの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b> にあります。コンテキスト・ルートは <b>/mfp-dev-artifacts</b> と定義する必要があります。</p>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty 集合への手動インストール
{: #manual-installation-on-websphere-application-server-liberty-collective }
[WebSphere Application Server Liberty の前提条件](#websphere-application-server-liberty-prerequisites)に記載されている要件を満たしていることも確認してください。

* [トポロジーの制約](#topology-constraints-collective)
* [アプリケーション・サーバーの設定](#application-server-settings-collective)
* [{{ site.data.keys.mf_server }} アプリケーションに必要な Liberty フィーチャー](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [グローバル JNDI 項目](#global-jndi-entries-collective)
* [クラス・ローダー](#class-loader-collective)
* [パスワード・デコーダー・ユーザー・フィーチャー](#password-decoder-user-feature-collective)
* [構成の詳細](#configuration-details-collective)

#### トポロジーの制約
{: #topology-constraints-collective }
{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.mf_console }} は、Liberty 集合コントローラーにインストールされる必要があります。{{ site.data.keys.product_adj }} ランタイムおよび {{ site.data.keys.mf_server }} プッシュ・サービスは、Liberty 集合クラスターの各メンバーにインストールされる必要があります。

ライブ更新サービスのコンテキスト・ルートは **the-adminContextRootconfig** と定義します。プッシュ・サービスのコンテキスト・ルートは **imfpush** にする必要があります。制約について詳しくは、[{{ site.data.keys.mf_server }} コンポーネントおよび {{ site.data.keys.mf_analytics }} に対する制約](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)を参照してください。

#### アプリケーション・サーバーの設定
{: #application-server-settings-collective }
サーブレットを即時ロードするように **webContainer** エレメントを構成する必要があります。この設定は、JMX を使用した初期化に必要です。例えば、次のとおりです。`<webContainer deferServletLoad="false"/>`

オプションで、一部の Liberty バージョンでランタイムおよび管理サービスの始動シーケンスが中断されるタイムアウトの問題を避けるために、デフォルトの **executor** エレメントを変更できます。**coreThreads** 属性と **maxThreads** 属性に大きい値を設定します。例えば、次のとおりです。

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

また、**tcpOptions** エレメントを構成し、次のように **soReuseAddr** 属性を `true` に設定することもできます。`<tcpOptions soReuseAddr="true"/>`

#### {{ site.data.keys.mf_server }} アプリケーションに必要な Liberty フィーチャー
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

以下の Java EE 6 または Java EE 7 のフィーチャーを追加する必要があります。

**{{ site.data.keys.mf_server }} 管理サービス**

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} プッシュ・サービス**  

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **servlet-3.0** (Java EE 7 の場合 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} ランタイム**  

* **jdbc-4.0** (Java EE 7 の場合 jdbc-4.1)
* **servlet-3.0** (Java EE 7 の場合 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### グローバル JNDI 項目
{: #global-jndi-entries-collective }
ランタイムと管理サービス間の JMX 通信を構成するために、以下のグローバル JNDI 項目が必要です。

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

これらのグローバル JNDI 項目はこの構文を使用して設定され、コンテキスト・ルートの接頭部は付きません。例えば、次のとおりです。`<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`

> **注:** JNDI 値の自動変換から保護し、075 が 61 に、または 31.500 が 31.5 に変換されないようにするには、値を定義するときにこの構文 '"075"' を使用してください。



* 管理サービスの JNDI プロパティーについて詳しくは、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。  
* ランタイムの JNDI プロパティーについて詳しくは、[{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)を参照してください。

#### クラス・ローダー
{: #class-loader-collective }
すべてのアプリケーションで、クラス・ローダーは、親が最後の委任になっている必要があります。例えば、次のとおりです。

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### パスワード・デコーダー・ユーザー・フィーチャー
{: #password-decoder-user-feature-collective }
パスワード・デコーダー・ユーザー・フィーチャーを Liberty プロファイルにコピーします。例えば、次のとおりです。

* UNIX および Linux システムの場合:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Windows システムの場合: 

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### 構成の詳細
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>{{ site.data.keys.mf_server }} 管理サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>管理サービスは、Liberty 集合コントローラーにデプロイするための WAR アプリケーションとしてパッケージされています。Liberty 集合コントローラーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty 集合への手動インストール</a>を検討してください。
                <br/><br/>
                管理サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpadmin</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、管理サービスのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mfpadmin</b> を使用して管理サービスがインストールされている場合に <b>mfp.admin.push.url</b> を宣言するケースを示しています。</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>プッシュ・サービスがインストールされている場合は、以下の JNDI プロパティーを構成する必要があります。</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>構成サービスとの通信用の JNDI プロパティーは以下のとおりです。</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>管理サービスのデータ・ソースの JNDI 名は、<b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b> と定義する必要があります。以下の例は、管理サービスが、コンテキスト・ルート <b>/mfpadmin</b> を使用してインストールされており、そのサービスがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>セキュリティー・ロール</h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで以下のロールを宣言します。</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>{{ site.data.keys.mf_server }} ライブ更新サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>ライブ更新サービスは、Liberty 集合コントローラーにデプロイするための WAR アプリケーションとしてパッケージされています。Liberty 集合コントローラーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty 集合への手動インストール</a>を検討してください。
                <br/><br/>
                ライブ更新サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> にあります。ライブ更新サービスのコンテキスト・ルートは <b>/the-adminContextRootconfig</b> のように定義する必要があります。例えば、管理サービスのコンテキスト・ルートが <b>/mfpadmin</b> の場合、ライブ更新サービスのコンテキスト・ルートは <b>/mfpadminconfig</b> でなければなりません。</p>

                <h3>データ・ソース</h3>
                <p>ライブ更新サービスのデータ・ソースの JNDI 名は <b>the-contextRoot/jdbc/ConfigDS</b> と定義する必要があります。以下の例は、ライブ更新サービスが、コンテキスト・ルート <b>/mfpadminconfig</b> を使用してインストールされており、そのサービスがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>セキュリティー・ロール</h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで configadmin ロールを宣言します。少なくとも 1 人のユーザーがこのロールにマップされている必要があります。ユーザーとパスワードは、管理サービスの以下の JNDI プロパティーに指定する必要があります。</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>{{ site.data.keys.mf_console }}  の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>コンソールは、Liberty 集合コントローラーにデプロイするための WAR アプリケーションとしてパッケージされています。Liberty 集合コントローラーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty への手動インストール</a>を検討してください。
                <br/><br/>
                コンソール WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpconsole</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、コンソールのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mfpconsole</b> を使用してコンソールがインストールされている場合に <b>mfp.admin.endpoint</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint プロパティーの標準的な値は <b>*://*:*/the-adminContextRoot</b> です。<br/>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} の JNDI プロパティー</a>を参照してください。</p>

                <h3>セキュリティー・ロール</h3>
                <p>アプリケーションの <b>application-bnd</b> エレメントで以下のロールを宣言します。</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                コンソールのセキュリティー・ロールにマップされているユーザーは、管理サービスの同じセキュリティー・ロールにもマップされている必要があります。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>{{ site.data.keys.product_adj }} ランタイムの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>ランタイムは、Liberty 集合クラスター・メンバーにデプロイするための WAR アプリケーションとしてパッケージされています。各 Liberty 集合クラスター・メンバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty 集合への手動インストール</a>を検討してください。
                <br/><br/>
                ランタイム WAR ファイルは、<b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、デフォルトでは <b>/mfp</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、ランタイムのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/mobilefirst</b> を使用してランタイムがインストールされている場合に <b>mfp.analytics.url</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}
                <p><b>mobilefirst/mfp.authorization.server</b> プロパティーを定義する必要があります。例えば、次のとおりです。</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>{{ site.data.keys.mf_analytics }} がインストールされている場合は、以下の JNDI プロパティーを定義する必要があります。</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>ランタイムのデータ・ソースの JNDI 名は、<b>jndiName=the-contextRoot/jdbc/mfpDS</b> と定義する必要があります。以下の例は、ランタイムが、コンテキスト・ルート <b>/mobilefirst</b> を使用してインストールされており、ランタイムがリレーショナル・データベースを使用しているケースを示しています。</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>{{ site.data.keys.mf_server }} プッシュ・サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>プッシュ・サービスは、Liberty 集合クラスター・メンバーまたは Liberty サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。プッシュ・サービスを Liberty サーバーにインストールする場合、<a href="#configuration-details-liberty">{{ site.data.keys.mf_server }} プッシュ・サービスの構成の詳細</a>の下の <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を参照してください。
                <br/><br/>
                {{ site.data.keys.mf_server }} プッシュ・サービスが Liberty 集合にインストールされる場合、ランタイムと同じクラスターにインストールすることも、別のクラスターにインストールすることもできます。
                <br/><br/>
                各 Liberty 集合クラスター・メンバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty 集合への手動インストール</a>を検討してください。    
                <br/><br/>
                プッシュ・サービスの WAR ファイルは <b>mfp_install_dir/PushService/mfp-push-service.war</b> にあります。コンテキスト・ルートは <b>/imfpush</b> と定義する必要があります。さもないと、コンテキスト・ルートは SDK にハードコーディングされているため、クライアント・デバイスはプッシュ・サービスに接続できません。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーを定義するとき、プッシュ・サービスのコンテキスト・ルートを接頭部として JNDI 名に追加する必要があります。以下の例は、コンテキスト・ルートとして <b>/imfpush</b> を使用してプッシュ・サービスがインストールされている場合に <b>mfp.push.analytics.user</b> を宣言するケースを示しています。</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                以下のプロパティーを定義する必要があります。
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - この値は <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> でなければなりません。</li>
                    <li><b>mfp.push.db.type</b> - リレーショナル・データベースの場合、この値は DB でなければなりません。</li>
                </ul>

                {{ site.data.keys.mf_analytics }} が構成されている場合は、以下の JNDI プロパティーを定義します。
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - この値は <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> でなければなりません。</li>
                </ul>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト</a>を参照してください。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>{{ site.data.keys.mf_server }} 成果物の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>成果物コンポーネントは、Liberty 集合コントローラーにデプロイするための WAR アプリケーションとしてパッケージされています。Liberty 集合コントローラーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty への手動インストール</a>を検討してください。</p>

                <p>このコンポーネントの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b> にあります。コンテキスト・ルートは <b>/mfp-dev-artifacts</b> と定義する必要があります。</p>
            </div>
        </div>
    </div>
</div>

### Apache Tomcat への手動インストール
{: #manual-installation-on-apache-tomcat }
[Apache Tomcat の前提条件](#apache-tomcat-prerequisites)に記載されている要件を満たしていることを確認してください。

* [トポロジーの制約](#topology-constraints-tomcat)
* [アプリケーション・サーバーの設定](#application-server-settings-tomcat)
* [構成の詳細](#configuration-details-tomcat)

#### トポロジーの制約
{: #topology-constraints-tomcat }
{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイムは同じアプリケーション・サーバー上にインストールする必要があります。ライブ更新サービスのコンテキスト・ルートは **the-adminContextRootconfig** と定義します。プッシュ・サービスのコンテキスト・ルートは **imfpush** にする必要があります。制約について詳しくは、[{{ site.data.keys.mf_server }} コンポーネントおよび {{ site.data.keys.mf_analytics }} に対する制約](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)を参照してください。

#### アプリケーション・サーバーの設定
{: #application-server-settings-tomcat }
**Single Sign On Valve** をアクティブにする必要があります。例えば、次のとおりです。

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

オプションで、**tomcat-users.xml** にユーザーが定義されている場合、メモリー・レルムをアクティブにすることもできます。例えば、次のとおりです。

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
      ```
#### 構成の詳細
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>{{ site.data.keys.mf_server }} 管理サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>管理サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。
                <br/><br/>
                管理サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpadmin</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーは、アプリケーション・コンテキストの <code>Environment</code> エレメント内に定義されます。例えば、次のとおりです。</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>ランタイムとの JMX 通信を使用可能にするには、以下の JNDI プロパティーを定義します。</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>プッシュ・サービスがインストールされている場合は、以下の JNDI プロパティーを構成する必要があります。</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>構成サービスとの通信用の JNDI プロパティーは以下のとおりです。</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>データ・ソース (jdbc/mfpAdminDS) は、**Context** エレメントでリソースとして宣言されます。例えば、次のとおりです。</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>セキュリティー・ロール</h3>
                <p>管理サービス・アプリケーションで使用可能なセキュリティー・ロールは以下のとおりです。</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>{{ site.data.keys.mf_server }} ライブ更新サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>ライブ更新サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。
                <br/><br/>
                ライブ更新サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> にあります。ライブ更新サービスのコンテキスト・ルートは <b>/the-adminContextRoot/config</b> のように定義する必要があります。例えば、管理サービスのコンテキスト・ルートが <b>/mfpadmin</b> の場合、ライブ更新サービスのコンテキスト・ルートは <b>/mfpadminconfig</b> でなければなりません。</p>

                <h3>データ・ソース</h3>
                <p>ライブ更新サービスのデータ・ソースの JNDI 名は <code>jdbc/ConfigDS</code> と定義する必要があります。それを <code>Context</code> エレメントでリソースとして宣言します。</p>

                <h3>セキュリティー・ロール</h3>
                <p>ライブ更新サービス・アプリケーションで使用可能なセキュリティー・ロールは <b>configadmin</b> です。
                <br/><br/>
                少なくとも 1 人のユーザーがこのロールにマップされている必要があります。ユーザーとパスワードは、管理サービスの以下の JNDI プロパティーに指定する必要があります。</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>{{ site.data.keys.mf_console }}  の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>このコンソールは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。
                <br/><br/>
                コンソール WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpconsole</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p><b>mfp.admin.endpoint</b> プロパティーを定義する必要があります。このプロパティーの標準的な値は <b>*://*:*/the-adminContextRoot</b> です。
                <br/><br/>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} の JNDI プロパティー</a>を参照してください。</p>

                <h3>セキュリティー・ロール</h3>
                <p>このアプリケーションで使用可能なセキュリティー・ロールは以下のとおりです。</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>{{ site.data.keys.product_adj }} ランタイムの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>このランタイムは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。
                <br/><br/>
                ランタイム WAR ファイルは、<b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、デフォルトでは <b>/mfp</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p><b>mfp.authorization.server</b> プロパティーを定義する必要があります。例えば、次のとおりです。</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>管理サービスとの JMX 通信を使用可能にするには、以下の JNDI プロパティーを定義します。</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }} がインストールされている場合は、以下の JNDI プロパティーを定義する必要があります。</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>ランタイムのデータ・ソースの JNDI 名は <b>jdbc/mfpDS</b> と定義する必要があります。それを <b>Context</b> エレメントでリソースとして宣言します。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>{{ site.data.keys.mf_server }} プッシュ・サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>プッシュ・サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。このアプリケーションに固有の構成をいくつか実行する必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。    
                <br/><br/>
                プッシュ・サービスの WAR ファイルは <b>mfp_install_dir/PushService/mfp-push-service.war</b> にあります。コンテキスト・ルートは <b>/imfpush</b> と定義する必要があります。さもないと、コンテキスト・ルートは SDK にハードコーディングされているため、クライアント・デバイスはプッシュ・サービスに接続できません。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>以下のプロパティーを定義する必要があります。</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - この値は <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> でなければなりません。</li>
                    <li><b>mfp.push.db.type</b> - リレーショナル・データベースの場合、この値は DB でなければなりません。</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }} が構成されている場合は、以下の JNDI プロパティーを定義します。</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - この値は <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> でなければなりません。</li>
                </ul>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト</a>を参照してください。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>{{ site.data.keys.mf_server }} 成果物の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>この成果物コンポーネントは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-apache-tomcat">Apache Tomcat への手動インストール</a>を検討してください。</p>

                <p>このコンポーネントの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b> にあります。コンテキスト・ルートは <b>/mfp-dev-artifacts</b> と定義する必要があります。</p>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
<a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">WebSphere Application Server および WebSphere Application Server Network Deployment の前提条件</a>に記載されている要件を満たしていることを確認してください。

* [トポロジーの制約](#topology-constraints-nd)
* [アプリケーション・サーバーの設定](#application-server-settings-nd)
* [クラス・ローダー](#class-loader-nd)
* [構成の詳細](#configuration-details-nd)

#### トポロジーの制約
{: #topology-constraints-nd }
<b>スタンドアロン WebSphere Application Server の場合</b>  
{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイムは同じアプリケーション・サーバー上にインストールする必要があります。ライブ更新サービスのコンテキスト・ルートは <b>the-adminContextRootConfig</b> と定義します。プッシュ・サービスのコンテキスト・ルートは <b>imfpush</b> にする必要があります。制約について詳しくは、[{{ site.data.keys.mf_server }} コンポーネントおよび {{ site.data.keys.mf_analytics }} に対する制約](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)を参照してください。

<b>WebSphere Application Server Network Deployment の場合</b>  
{{ site.data.keys.mf_server }} の稼働中は、デプロイメント・マネージャーが稼働している必要があります。デプロイメント・マネージャーは、ランタイムと管理サービス間の JMX 通信に使用されます。管理サービスとライブ更新サービスは、同じアプリケーション・サーバー上にインストールする必要があります。ランタイムは、管理サービスとは異なるサーバーにインストールできますが、同じセル上になければなりません。

#### アプリケーション・サーバーの設定
{: #application-server-settings-nd }
管理セキュリティーとアプリケーション・セキュリティーを使用可能にする必要があります。アプリケーション・セキュリティーは、WebSphere Application Server 管理コンソールで以下のようにして使用可能にできます。

1. WebSphere Application Server 管理コンソールにログインします。
2. **「セキュリティー (Security)」→「グローバル・セキュリティー (Global Security)」**をクリックします。「管理セキュリティーを使用可能にする (Enable administrative security)」が選択されていることを確認します。
3. また、**「アプリケーション・セキュリティーを使用可能にする」**が選択されていることも確認します。アプリケーション・セキュリティーは、管理セキュリティーが使用可能になっている場合にのみ使用可能にできます。
4. **「OK」**をクリックします。
5. 変更を保存します。

詳しくは、WebSphere Application Server 資料の[セキュリティーの使用可能化](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc)を参照してください。

サーバーのクラス・ローダー・ポリシーで、親が最後の委任がサポートされている必要があります。{{ site.data.keys.mf_server }} WAR ファイルは、親が最後のクラス・ローダー・モードでインストールされている必要があります。以下のようにしてクラス・ローダー・ポリシーを確認してください。

1. WebSphere Application Server 管理コンソールにログインします。
2. **「サーバー」 → 「サーバー・タイプ」 → 「WebSphere Application Server」**をクリックし、{{ site.data.keys.product }} に使用されているサーバーをクリックします。
3. クラス・ローダー・ポリシーが **「マルチ (Multiple)」** に設定されている場合は、何もしません。
4. クラス・ローダー・ポリシーが**「シングル (Single)」**に設定されており、クラス・ロード・モードが**「最初にローカル・クラス・ローダーをロードしたクラス (親が最後)」**に設定されている場合は何も実行しません。
5. クラス・ローダー・ポリシーが**「シングル (Single)」**に設定されており、クラス・ロード・モードが**「最初に親クラス・ローダーをロードしたクラス (親が最初)」**に設定されている場合は、クラス・ローダー・ポリシーを**「マルチ (Multiple)」**に変更します。さらに、{{ site.data.keys.mf_server }} アプリケーション以外のすべてのアプリケーションのクラス・ローダー順序を**「最初に親クラス・ローダーをロードしたクラス (親が最初)」**に設定します。

#### クラス・ローダー
{: #class-loader-nd }
すべての {{ site.data.keys.mf_server }} アプリケーションで、クラス・ローダーは、親が最後の委任になっている必要があります。

アプリケーションをインストールした後、クラス・ローダーの委任を、親が最後に設定するには、以下のステップを実行します。

1. **「アプリケーションの管理」**リンクをクリックするか、**「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」**をクリックします。
2. **{{ site.data.keys.mf_server }}** アプリケーションをクリックします。デフォルトで、アプリケーションの名前は WAR ファイルの名前です。
3. **「詳細プロパティー」**セクションで、**「クラス・ロードおよび更新の検出 (Class loading and update detection)」**リンクをクリックします。
4. **「クラス・ローダー順序」**ペインで、**「最初にローカル・クラス・ローダーをロードしたクラス (親は最後)」**オプションを選択します。
5. **「OK」**をクリックします。
6. **「モジュール」**セクションで、**「モジュールの管理」**リンクをクリックします。
7. モジュールをクリックします。
8. **「クラス・ローダー順序」**フィールドでは、**「最初にローカル・クラス・ローダーをロードしたクラス (親は最後)」**オプションを選択します。
9. **「OK」**を 2 回クリックして選択を確認し、アプリケーションの**「構成」**パネルに戻ります。
10. **「保存」**をクリックして変更を永続化します。

#### 構成の詳細
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>{{ site.data.keys.mf_server }} 管理サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>管理サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。
                <br/><br/>
                管理サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpadmin</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーは、WebSphere Application Server 管理コンソールを使用して設定できます。<b>「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」→「application_name」→「Web モジュールの環境項目」</b>を選択し、項目を設定します。</p>

                <p>ランタイムとの JMX 通信を使用可能にするには、以下の JNDI プロパティーを定義します。</p>

                <b>WebSphere Application Server Network Deployment の場合</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - デプロイメント・マネージャー上の SOAP ポート。</li>
                    <li><b>mfp.topology.platform</b> - 値を <b>WAS</b> に設定します。</li>
                    <li><b>mfp.topology.clustermode</b> - 値を <b>Cluster</b> に設定します。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 値を <b>SOAP</b> に設定します。</li>
                </ul>

                <b>スタンドアロン WebSphere Application Server の場合</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 値を <b>WAS</b> に設定します。</li>
                    <li><b>mfp.topology.clustermode</b> -  値を <b>Standalone</b> に設定します。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 値を <b>SOAP</b> に設定します。</li>
                </ul>

                <p>プッシュ・サービスがインストールされている場合は、以下の JNDI プロパティーを構成する必要があります。</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>構成サービスとの通信用の JNDI プロパティーは以下のとおりです。</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>管理サービス用のデータ・ソースを作成し、それを <b>jdbc/mfpAdminDS</b> にマップします。</p>

                <h3>始動順序</h3>
                <p>管理サービス・アプリケーションは、ランタイム・アプリケーションの前に始動する必要があります。順序は、<b>「始動の動作」</b>セクションで設定できます。例えば、管理サービスでは Startup Order を <b>1</b> に設定し、ランタイムでは <b>2</b> に設定します。</p>

                <h3>セキュリティー・ロール</h3>
                <p>管理サービス・アプリケーションで使用可能なセキュリティー・ロールは以下のとおりです。</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>{{ site.data.keys.mf_server }} ライブ更新サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>ライブ更新サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。
                <br/><br/>
                ライブ更新サービスの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b> にあります。ライブ更新サービスのコンテキスト・ルートは <b>/the-adminContextRoot/config</b> のように定義する必要があります。例えば、管理サービスのコンテキスト・ルートが <b>/mfpadmin</b> の場合、ライブ更新サービスのコンテキスト・ルートは <b>/mfpadminconfig</b> でなければなりません。</p>

                <h3>データ・ソース</h3>
                <p>ライブ更新サービスのデータ・ソースを作成し、それを <b>jdbc/ConfigDS</b> にマップします。</p>

                <h3>セキュリティー・ロール</h3>
                <p>このアプリケーションに対して <b>configadmin</b> ロールが定義されています。
                <br/><br/>
                少なくとも 1 人のユーザーがこのロールにマップされている必要があります。ユーザーとパスワードは、管理サービスの以下の JNDI プロパティーに指定する必要があります。</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>{{ site.data.keys.mf_console }}  の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>このコンソールは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。
                <br/><br/>
                コンソール WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、通常は <b>/mfpconsole</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーは、WebSphere Application Server 管理コンソールを使用して設定できます。<b>「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」→「application_name」→「Web モジュールの環境項目」</b>を選択し、項目を設定します。
                <br/><br/>
                <b>mfp.admin.endpoint</b> プロパティーを定義する必要があります。このプロパティーの標準的な値は <b>*://*:*/the-adminContextRoot</b> です。
                <br/><br/>
                JNDI プロパティーについて詳しくは、<a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }} の JNDI プロパティー</a>を参照してください。</p>

                <h3>セキュリティー・ロール</h3>
                <p>このアプリケーションで使用可能なセキュリティー・ロールは以下のとおりです。</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                コンソールのセキュリティー・ロールにマップされているユーザーは、管理サービスの同じセキュリティー・ロールにもマップされている必要があります。
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>MobileFirst ランタイムの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>このランタイムは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。<b>server.xml </b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。
                <br/><br/>
                続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。
                <br/><br/>
                ランタイム WAR ファイルは、<b>mfp_install_dir/MobileFirstServer/mfp-server.war</b> にあります。コンテキスト・ルートは自由に定義できます。ただし、デフォルトでは <b>/mfp</b> です。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーは、WebSphere Application Server 管理コンソールを使用して設定できます。<b>「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」→「application_name」→「Web モジュールの環境項目」</b>を選択し、項目を設定します。</p>

                <p><b>mfp.authorization.server</b> プロパティーに値 embedded を定義する必要があります。<br/>
                また、以下の JNDI プロパティーを定義して、管理サービスとの JMX 通信を使用可能にする必要があります。</p>

                <b>WebSphere Application Server Network Deployment の場合</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - デプロイメント・マネージャーのホスト名。</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - デプロイメント・マネージャーの SOAP ポート。</li>
                    <li><b>mfp.topology.platform</b> - 値を <b>WAS</b> に設定します。</li>
                    <li><b>mfp.topology.clustermode</b> - 値を <b>Cluster</b> に設定します。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 値を <b>SOAP</b> に設定します。</li>
                </ul>

                <b>スタンドアロン WebSphere Application Server の場合</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 値を <b>WAS</b> に設定します。</li>
                    <li><b>mfp.topology.clustermode</b> -  値を <b>Standalone</b> に設定します。</li>
                    <li><b>mfp.admin.jmx.connector </b> - 値を <b>SOAP</b> に設定します。</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }} がインストールされている場合は、以下の JNDI プロパティーを定義する必要があります。</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>始動順序</h3>
                <p>ランタイム・アプリケーションは、管理サービス・アプリケーションの後に始動する必要があります。順序は、<b>「始動の動作」</b>セクションで設定できます。例えば、管理サービスでは Startup Order を <b>1</b> に設定し、ランタイムでは <b>2</b> に設定します。</p>

                <h3>データ・ソース</h3>
                <p>ランタイムのデータ・ソースを作成し、それを <b>jdbc/mfpDS</b> にマップします。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>{{ site.data.keys.mf_server }} プッシュ・サービスの構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>プッシュ・サービスは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。このアプリケーションに固有の構成をいくつか実行する必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。    
                <br/><br/>
                プッシュ・サービスの WAR ファイルは <b>mfp_install_dir/PushService/mfp-push-service.war</b> にあります。コンテキスト・ルートは <b>/imfpush</b> と定義する必要があります。さもないと、コンテキスト・ルートは SDK にハードコーディングされているため、クライアント・デバイスはプッシュ・サービスに接続できません。</p>

                <h3>必須の JNDI プロパティー</h3>
                <p>JNDI プロパティーは、WebSphere Application Server 管理コンソールを使用して設定できます。<b>「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」→「application_name」→「Web モジュールの環境項目」</b>を選択し、項目を設定します。</p>

                <p>以下のプロパティーを定義する必要があります。</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - この値は <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> でなければなりません。</li>
                    <li><b>mfp.push.db.type</b> - リレーショナル・データベースの場合、この値は DB でなければなりません。</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }} が構成されている場合は、以下の JNDI プロパティーを定義します。</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - この値は <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> でなければなりません。</li>
                </ul>
                <p>JNDI プロパティーについて詳しくは、<a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト</a>を参照してください。</p>

                <h3>データ・ソース</h3>
                <p>プッシュ・サービスのデータ・ソースを作成し、それを <b>jdbc/imfPushDS</b> にマップします。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>{{ site.data.keys.mf_server }} 成果物の構成の詳細</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>この成果物コンポーネントは、アプリケーション・サーバーにデプロイするための WAR アプリケーションとしてパッケージされています。アプリケーション・サーバーの <b>server.xml</b> ファイル内で、このアプリケーションに固有の構成をいくつか行う必要があります。続行する前に、すべてのサービスに共通の構成詳細について<a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server および WebSphere Application Server Network Deployment への手動インストール</a>を検討してください。</p>

                <p>このコンポーネントの WAR ファイルは <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b> にあります。コンテキスト・ルートは <b>/mfp-dev-artifacts</b> と定義する必要があります。</p>
            </div>
        </div>
    </div>
</div>

## サーバー・ファームのインストール
{: #installing-a-server-farm }
サーバー・ファームのインストールは、Ant タスクを実行することによって、サーバー構成ツールを使用して、または手動で行うことができます。

* [サーバー・ファームの構成の計画](#planning-the-configuration-of-a-server-farm)
* [サーバー構成ツールを使用した サーバー・ファームのインストール](#installing-a-server-farm-with-the-server-configuration-tool)
* [Ant タスクを使用したサーバー・ファームのインストール](#installing-a-server-farm-with-ant-tasks)
* [手動でのサーバー・ファームの構成](#configuring-a-server-farm-manually)
* [ファーム構成の検証](#verifying-a-farm-configuration)
* [サーバー・ファーム・ノードのライフサイクル](#lifecycle-of-a-server-farm-node)

### サーバー・ファームの構成の計画
{: #planning-the-configuration-of-a-server-farm }
サーバー・ファームの構成を計画するには、アプリケーション・サーバーを選択し、{{ site.data.keys.product_adj }} データベースを構成し、{{ site.data.keys.mf_server }} コンポーネントの WAR ファイルをファームの各サーバーにデプロイします。サーバー・ファームを構成する方法として、サーバー構成ツールを使用して行うか、Ant タスクを使用して行うか、あるいは手動操作で行うかを選択できます。

サーバー・ファームのインストールを計画している場合、まず最初に [{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および MobileFirst ランタイムでの制約](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)を参照し、特に、[サーバー・ファームのトポロジー](../topologies/#server-farm-topology)を参照してください。

{{ site.data.keys.product }} で、サーバー・ファームは、アプリケーション・サーバーの管理コンポーネントによって統合も管理もされていない複数のスタンドアロン・アプリケーション・サーバーで構成されています。{{ site.data.keys.mf_server }} は、サーバー・ファームの一部になれるようにアプリケーション・サーバーを拡張するための手段としてファーム・プラグインを内部で提供しています。

#### どのような場合にサーバー・ファームを宣言するか
{: #when-to-declare-a-server-farm }
**以下の場合にサーバー・ファームを宣言します。**

* {{ site.data.keys.mf_server }} が複数の Tomcat アプリケーション・サーバーにインストールされている。
* {{ site.data.keys.mf_server }} が WebSphere Application Server を除く、複数の WebSphere Application Server Network Deployment サーバーにインストールされている。
* {{ site.data.keys.mf_server }} が複数の WebSphere Application Server Liberty サーバーにインストールされている。

**以下の場合、サーバー・ファームを宣言しません。**

* ユーザーのアプリケーション・サーバーがスタンドアロンである。
* 複数のアプリケーション・サーバーが WebSphere Application Server Network Deployment によって統合されている。

#### なぜファームの宣言が必須なのか
{: #why-it-is-mandatory-to-declare-a-farm }
{{ site.data.keys.mf_console }} または {{ site.data.keys.mf_server }} 管理サービス・アプリケーションを通じて管理操作を実行するたびに、その操作は、ランタイム環境のすべてのインスタンスに対して複製される必要があります。そのような管理操作の例として、アプリまたはアダプターの新バージョンのアップロードがあります。複製は、その操作を処理する管理サービス・アプリケーション・インスタンスによって実行される JMX 呼び出しを介して行われます。管理サービスは、クラスター内のすべてのランタイム・インスタンスに接続する必要があります。『**どのような場合にサーバー・ファームを宣言するか**』の項で列挙した環境では、ファームが構成されている場合にのみ、ランタイムに JMX を介して接続できます。ファームを適切に構成することなくサーバーをクラスターに追加すると、そのサーバー内のランタイムは、管理操作が行われるごとに不整合な状態になり、それはそのサーバーを再始動するまで解消されません。

### サーバー構成ツールを使用した サーバー・ファームのインストール
{: #installing-a-server-farm-with-the-server-configuration-tool }
サーバー構成ツールを使用して、サーバー・ファームの各メンバー用に使用される単一タイプのアプリケーション・サーバーの要件に合わせて、ファーム内の各サーバーを構成します。

サーバー構成ツールを使用してサーバー・ファームの計画を行う場合、最初に、スタンドアロン・サーバーを作成し、それらのサーバーのそれぞれのトラストストアを構成して、互いに安全に通信できるようにします。次に、以下の操作を行うツールを実行します。

* {{ site.data.keys.mf_server }} コンポーネントで共有されるデータベース・インスタンスを構成します。
* {{ site.data.keys.mf_server }} コンポーネントを各サーバーにデプロイします。
* 構成を変更してサーバー・ファームのメンバーにします。

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>サーバー構成ツールを使用したサーバー・ファームのインストール手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} では、セキュア JMX 接続が構成されている必要があります。</p>

                <ol>
                    <li>サーバー・ファームのメンバーとして構成される必要のあるアプリケーション・サーバーを準備します。
                        <ul>
                            <li>サーバー・ファームのメンバーを構成するために使用するアプリケーション・サーバーのタイプを選択します。{{ site.data.keys.product }} は、サーバー・ファーム内の以下のアプリケーション・サーバーをサポートしています。
                                <ul>
                                    <li>WebSphere Application Server フル・プロファイル<br/>
                                    <b>注:</b> ファーム・トポロジーでは、RMI JMX コネクターを使用できません。このトポロジーでは、{{ site.data.keys.product }} は SOAP コネクターのみをサポートします。</li>
                                    <li>WebSphere Application Server Liberty プロファイル</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                サポートされているアプリケーション・サーバーのバージョンについては、<a href="../../../product-overview/requirements">システム要件</a>を参照してください。

                                <blockquote><b>重要:</b> {{ site.data.keys.product }} では、同種のサーバー・ファームのみがサポートされます。同じタイプのアプリケーション・サーバーを接続する場合、サーバー・ファームは同種です。異なるタイプのアプリケーション・サーバーを関連付けようとすると、予測不能の動作が実行時に起こる可能性があります。例えば、Apache Tomcat サーバーと WebSphere Application Server フル・プロファイル・サーバーを混在させたファームは、無効な構成になります。</blockquote>
                            </li>
                            <li>ファーム内で必要になるメンバーの数と同じ数のスタンドアロン・サーバーをセットアップします。
                                <ul>
                                    <li>これらのスタンドアロン・サーバーは、それぞれが同じデータベースと通信する必要があります。これらのサーバーによって使用されるすべてのポートが、同じホスト上で構成されている他のサーバーによっても使用されることのないように注意してください。この制約は、HTTP、HTTPS、REST、SOAP、および RMI の各プロトコルによって使用されるポートに適用されます。</li>
                                    <li>これらのサーバーは、それぞれに {{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および 1 つ以上の {{ site.data.keys.product_adj }}ランタイムがデプロイされている必要があります。</li>
                                    <li>サーバーのセットアップについて詳しくは、<a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイムでの制約</a>を参照してください。</li>
                                </ul>
                            </li>
                            <li>すべてのサーバー間でそれぞれのトラストストア内の署名者証明書を交換します。
                            <br/><br/>
                            WebSphere Application Server フル・プロファイルまたは Liberty を使用するファームの場合、セキュリティーが有効にされる必要があるため、このステップは必須です。さらに、Liberty ファームの場合、シングル・サインオンが可能となるように、同じ LTPA 構成が各サーバー上で複製される必要があります。この構成を行うには、<a href="#configuring-a-server-farm-manually">手動でのサーバー・ファームの構成</a>のステップ 6 で説明されているガイドラインに従ってください。
                            </li>
                        </ul>
                    </li>
                    <li>ファームの各サーバーに対してサーバー構成ツールを実行します。すべてのサーバーが同じデータベースを共有する必要があります。<b>「アプリケーション・サーバー設定」</b>パネルで、デプロイメント・タイプ<b>「サーバー・ファーム・デプロイメント (Server farm deployment)」</b>を選択してください。このツールについて詳しくは、<a href="#running-the-server-configuration-tool">サーバー構成ツールの実行</a>を参照してください。
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Ant タスクを使用したサーバー・ファームのインストール
{: #installing-a-server-farm-with-ant-tasks }
Ant タスクを使用して、サーバー・ファームの各メンバー用に使用される単一タイプのアプリケーション・サーバーの要件に合わせて、ファーム内の各サーバーを構成します。

Ant タスクを使用してサーバー・ファームの計画を行う場合、最初に、スタンドアロン・サーバーを作成し、それらのサーバーのそれぞれのトラストストアを構成して、互いに安全に通信できるようにします。次に、 Ant タスクを実行して、{{ site.data.keys.mf_server }} コンポーネントで共有されるデータベース・インスタンスを構成します。最後に、Ant タスクを実行して、{{ site.data.keys.mf_server }} コンポーネントを各サーバーにデプロイし、各サーバーがサーバー・ファームのメンバーになるようにサーバーの構成を変更します。

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Ant タスクを使用したサーバー・ファームのインストール手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} では、セキュア JMX 接続が構成されている必要があります。</p>

                <ol>
                    <li>サーバー・ファームのメンバーとして構成される必要のあるアプリケーション・サーバーを準備します。
                        <ul>
                            <li>サーバー・ファームのメンバーを構成するために使用するアプリケーション・サーバーのタイプを選択します。{{ site.data.keys.product }} は、サーバー・ファーム内の以下のアプリケーション・サーバーをサポートしています。
                                <ul>
                                    <li>WebSphere Application Server フル・プロファイル。<b>注:</b> ファーム・トポロジーでは、RMI JMX コネクターを使用できません。このトポロジーでは、{{ site.data.keys.product }} は SOAP コネクターのみをサポートします。</li>
                                    <li>WebSphere Application Server Liberty プロファイル</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                サポートされているアプリケーション・サーバーのバージョンについては、<a href="../../../product-overview/requirements">システム要件</a>を参照してください。

                                <blockquote><b>重要:</b> {{ site.data.keys.product }} では、同種のサーバー・ファームのみがサポートされます。同じタイプのアプリケーション・サーバーを接続する場合、サーバー・ファームは同種です。異なるタイプのアプリケーション・サーバーを関連付けようとすると、予測不能の動作が実行時に起こる可能性があります。例えば、Apache Tomcat サーバーと WebSphere Application Server フル・プロファイル・サーバーを混在させたファームは、無効な構成になります。</blockquote>
                            </li>
                            <li>ファーム内で必要になるメンバーの数と同じ数のスタンドアロン・サーバーをセットアップします。
                            <br/><br/>
                            これらのスタンドアロン・サーバーは、それぞれが同じデータベースと通信する必要があります。これらのサーバーによって使用されるすべてのポートが、同じホスト上で構成されている他のサーバーによっても使用されることのないように注意してください。この制約は、HTTP、HTTPS、REST、SOAP、および RMI の各プロトコルによって使用されるポートに適用されます。
                            <br/><br/>
                            これらのサーバーは、それぞれに {{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および 1 つ以上の {{ site.data.keys.product_adj }}ランタイムがデプロイされている必要があります。
                            <br/><br/>
                            サーバーのセットアップについて詳しくは、<a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および {{ site.data.keys.product_adj }} ランタイムでの制約</a>を参照してください。</li>
                            <li>すべてのサーバー間でそれぞれのトラストストア内の署名者証明書を交換します。
                            <br/><br/>
                            WebSphere Application Server フル・プロファイルまたは Liberty を使用するファームの場合、セキュリティーが有効にされる必要があるため、このステップは必須です。さらに、Liberty ファームの場合、シングル・サインオンが可能となるように、同じ LTPA 構成が各サーバー上で複製される必要があります。この構成を行うには、<a href="#configuring-a-server-farm-manually">手動でのサーバー・ファームの構成</a>のステップ 6 で説明されているガイドラインに従ってください。
                            </li>
                        </ul>
                    </li>
                    <li>管理サービス、ライブ更新サービス、およびランタイム用にデータベースを構成します。
                        <ul>
                            <li>使用したいデータベースを決定し、<b>mfp_install_dir/MobileFirstServer/configuration-samples</b> ディレクトリー内で、データベースを作成して構成するための Ant ファイルを選択します。
                                <ul>
                                    <li>DB2 の場合、<b>create-database-db2.xml</b> を使用します。</li>
                                    <li>MySQL の場合、<b>create-database-mysql.xml</b> を使用します。</li>
                                    <li>Oracle の場合、<b>create-database-oracle.xml</b> を使用します。</li>
                                </ul>
                                <blockquote>注: Derby データベースでは同時に許可されるのは 1 つのみの接続であるため、ファーム・トポロジーでは Derby データベースを使用しないでください。</blockquote>

                            </li>
                            <li>Ant ファイルを編集して、データベースに必要なプロパティーをすべて入力します。
                            <br/><br/>
                            {{ site.data.keys.mf_server }} コンポーネントによって使用されるデータベースの構成を有効にするため、以下のプロパティーの値を設定します。
                                <ul>
                                    <li><b>mfp.process.admin</b> を <b>true</b> に設定します。これは、管理サービスおよびライブ更新サービス用にデータベースを構成するためです。</li>
                                    <li><b>mfp.process.runtime</b> を <b>true</b> に設定します。これは、ランタイム用にデータベースを構成するためです。</li>
                                </ul>
                            </li>
                            <li><b>mfp_install_dir/MobileFirstServer/configuration-samples</b> ディレクトリーから以下のコマンドを実行します。<b>create-database-ant-file.xml</b> は選択した実際の Ant ファイル名に置き換えてください。<code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> および <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>
                            <br/><br/>
                            {{ site.data.keys.mf_server }} データベースはファーム内のアプリケーション・サーバー間で共有されるため、これら 2 つのコマンドは、ファーム内のサーバーの数にかかわらず、1 回のみ実行すればすみます。
                            </li>
                            <li>オプションで、別のランタイムを実行したい場合は、別のデータベースを別のデータベース名またはスキーマで構成する必要があります。これを行うには、Ant ファイルを編集してプロパティーを変更し、ファーム内のサーバーの数にかかわらず、以下のコマンドを 1 回だけ実行します。<code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code></li>
                        </ul>
                    </li>
                    <li>管理サービス、ライブ更新サービス、およびランタイムをサーバーにデプロイし、これらのサーバーをサーバー・ファームのメンバーとして構成します。
                        <ul>
                            <li>管理サービス、ライブ更新サービス、およびランタイムをサーバーにデプロイするため、ご使用のアプリケーション・サーバーおよびデータベースに対応する Ant ファイルを <b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> ディレクトリー内で選択します。
                            <br/><br/>
                            例えば、DB2 データベースを使用する Liberty サーバーでのデプロイメントの場合、<b>configure-liberty-db2.xml</b> ファイルを選択します。ファームのメンバーにしたい数だけ、このファイルのコピーを作成します。
                            <br/><br/>
                            <b>注:</b> これらのファイルは構成が終わっても保持しておいてください。これらのファイルは、既にデプロイ済みの {{ site.data.keys.mf_server }} コンポーネントをアップグレードする場合や、ファームの各メンバーからアンインストールする場合に再使用できます。</li>
                            <li>Ant ファイルの各コピーを編集して、ステップ 2 で使用したのと同じデータベースのプロパティーを入力し、アプリケーション・サーバーについての他の必要なプロパティーも入力します。
                            <br/><br/>
                            サーバーをサーバー・ファーム・メンバーとして構成するため、以下のプロパティーの値を設定します。<ul>
                                    <li><b>mfp.farm.configure</b> を true に設定します。</li>
                                    <li><b>mfp.farm.server.id</b>: このファーム・メンバーに対して定義する ID。 ファーム内の各サーバーがそれぞれ固有の ID を持っていることを確認してください。ファーム内の 2 つのサーバーの ID が同じであると、ファームは予測不能な動作をする可能性があります。</li>
                                    <li><b>mfp.config.service.user</b>: ライブ更新サービスにアクセスするために使用されるユーザー名。ユーザー名はファームのすべてのメンバーで同じでなければなりません。</li>
                                    <li><b>mfp.config.service.password</b>: ライブ更新サービスにアクセスするために使用されるパスワード。パスワードはファームのすべてのメンバーで同じでなければなりません。</li>
                                </ul>
                                サーバーでの {{ site.data.keys.mf_server }} コンポーネントの WAR ファイルのデプロイメントを有効にするため、以下のプロパティーの値を設定します。
                                    <ul>
                                        <li><b>mfp.process.admin</b> を <b>true</b> に設定します。これは、管理サービスおよびライブ更新サービスの WAR ファイルをデプロイするためです。</li>
                                        <li><b>mfp.process.runtime</b> を <b>true</b> に設定します。これは、ランタイムの WAR ファイルをデプロイするためです。</li>
                                    </ul>
                                <br/>
                                <b>注:</b> ファームのサーバーに複数のランタイムをインストールすることを計画している場合、Ant タスク <b>installmobilefirstruntime</b>、<b>updatemobilefirstruntime</b>、および <b>uninstallmobilefirstruntime</b> に id 属性を指定し、各ランタイムで固有の値を設定します。
                                <br/>
                                以下に例を示します。
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>各サーバーに対して以下のコマンドを実行します。<b>configure-appserver-database-ant-file.xml</b> は選択した実際の Ant ファイル名に置き換えてください。<code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> および <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>
                            <br/><br/>
                            これらのコマンドは、Ant タスク <b>installmobilefirstadmin</b> および <b>installmobilefirstruntime</b> を実行します。これらのタスクについて詳しくは、<a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 成果物、{{ site.data.keys.mf_server }} 管理サービス、およびライブ更新サービスのインストールのための Ant タスク</a>および <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">{{ site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク</a>を参照してください。
                            </li>
                            <li>オプションで、別のランタイムをインストールしたい場合は、以下のステップを実行します。
                                <ul>
                                    <li>ステップ 3.b で構成した Ant ファイルのコピーを作成します。</li>
                                    <li>そのコピーを編集して、<b>installmobilefirstruntime</b>、<b>updatemobilefirstruntime</b>、および <b>uninstallmobilefirstruntime</b> に、別のコンテキスト・ルートと、他のランタイム構成とは異なる <b>id</b> 属性の値を設定します。</li>
                                    <li>以下のコマンドをファームの各サーバーで実行します。<b>configure-appserver-database-ant-file2.xml</b> は、編集した Ant ファイルの実際の名前に置き換えてください。<code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code></li>
                                    <li>ファームの各サーバーについてこのステップを繰り返します。</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>すべてのサーバーを再始動します。</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 手動でのサーバー・ファームの構成
{: #configuring-a-server-farm-manually }
サーバー・ファームの各メンバーのために使用される単一タイプのアプリケーション・サーバーの要件に合わせて、ファーム内の各サーバーを構成する必要があります。

サーバー・ファームの計画を立案するときには、最初に、同じデータベース・インスタンスと通信するスタンドアロン・サーバーを複数作成します。次に、これらのサーバーの構成を変更して、これらのサーバーをサーバー・ファームのメンバーにします。

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>サーバー・ファームの手動構成手順を参照する場合にクリック</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>サーバー・ファームのメンバーを構成するために使用するアプリケーション・サーバーのタイプを選択します。{{ site.data.keys.product }} は、サーバー・ファーム内の以下のアプリケーション・サーバーをサポートしています。
                       <ul>
                            <li>WebSphere Application Server フル・プロファイル<br/>
                            <b>注:</b> ファーム・トポロジーでは、RMI JMX コネクターを使用できません。このトポロジーでは、{{ site.data.keys.product }} は SOAP コネクターのみをサポートします。</li>
                            <li>WebSphere Application Server Liberty プロファイル</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        サポートされているアプリケーション・サーバーのバージョンについては、<a href="../../../product-overview/requirements">システム要件</a>を参照してください。

                        <blockquote><b>重要:</b> {{ site.data.keys.product }} では、同種のサーバー・ファームのみがサポートされます。同じタイプのアプリケーション・サーバーを接続する場合、サーバー・ファームは同種です。異なるタイプのアプリケーション・サーバーを関連付けようとすると、予測不能の動作が実行時に起こる可能性があります。例えば、Apache Tomcat サーバーと WebSphere Application Server フル・プロファイル・サーバーを混在させたファームは、無効な構成になります。</blockquote>
                    </li>
                    <li>使用するデータベースを決定します。以下の中から選択できます。
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL </li>
                            <li>Oracle </li>
                        </ul>
                        {{ site.data.keys.mf_server }} データベースは、ファーム内のアプリケーション・サーバーの間で共有されます。このことは以下のような意味を持ちます。
                        <ul>
                            <li>ファーム内のサーバーの数にかかわらず、データベースを作成するのは 1 回のみです。</li>
                            <li>ファーム・トポロジーでは Derby データベースを使用できません。これは、Derby データベースが同時に 1 つの接続しか許可しないからです。</li>
                        </ul>
                        データベースについて詳しくは、<a href="../databases">データベースのセットアップ</a>を参照してください。
                    </li>
                    <li>ファーム内で必要になるメンバーの数と同じ数のスタンドアロン・サーバーをセットアップします。
                        <ul>
                            <li>これらのスタンドアロン・サーバーは、それぞれが同じデータベースと通信する必要があります。これらのサーバーによって使用されるすべてのポートが、同じホスト上で構成されている他のサーバーによっても使用されることのないように注意してください。この制約は、HTTP、HTTPS、REST、SOAP、および RMI の各プロトコルによって使用されるポートに適用されます。</li>
                            <li>これらのサーバーは、それぞれに {{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_server }} ライブ更新サービス、および 1 つ以上の {{ site.data.keys.product_adj }}ランタイムがデプロイされている必要があります。</li>
                            <li>これらのサーバーがそれぞれスタンドアロン・トポロジーで正常に稼働している場合には、それらをサーバー・ファームのメンバーに変換できます。</li>
                        </ul>
                    </li>
                    <li>ファームのメンバーにする予定のサーバーをすべて停止します。</li>
                    <li>アプリケーション・サーバーのタイプに合わせて各サーバーを適切に構成します。<br/>いくつかの JNDI プロパティーを正しく設定する必要があります。サーバー・ファーム・トポロジーでは、JNDI プロパティー mfp.config.service.user および mfp.config.service.password は、ファームのすべてのメンバーで同じでなければなりません。Apache Tomcat の場合には、JVM 引数が適正に定義されていることを確認する必要もあります。
                        <ul>
                            <li><b>WebSphere Application Server Liberty プロファイル</b>
                                <br/>
                                server.xml ファイルで、以下のサンプル・コードに示される JNDI プロパティーを設定します。
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                これらのプロパティーは、適切な値に設定しなければなりません。
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: このファーム・メンバー用に定義された ID。 この ID は、すべてのファーム・メンバーにわたって固有である必要があります。</li>
                                    <li><b>mfp.admin.jmx.user</b> および <b>mfp.admin.jmx.pwd</b>: これらの値は、<code>administrator-role</code> エレメントで宣言したユーザーの資格情報と一致する必要があります。</li>
                                    <li><b>mfp.admin.jmx.host</b>: このパラメーターには、リモート・メンバーがこのサーバーにアクセスするために使用する IP またはホスト名を設定します。したがたって、<b>localhost</b> には設定しないでください。このホスト名はファームの他のメンバーによって使用されるため、すべてのファーム・メンバーにとってアクセス可能でなければなりません。</li>
                                    <li><b>mfp.admin.jmx.port</b>: このパラメーターには、JMX REST 接続に使用するサーバー HTTPS ポートを設定します。この値は、<b>server.xml</b> ファイルの <code>httpEndpoint</code> エレメントにあります。</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                管理サービスのコンテキストおよびすべてのランタイムのコンテキストで以下の JNDI プロパティーを設定するために、<b>conf/server.xml</b> ファイルを変更します。
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                <b>mfp.admin.serverid</b> プロパティーには、このファーム・メンバー用に定義した ID を設定します。この ID は、すべてのファーム・メンバーにわたって固有である必要があります。
                                <br/>
                                <code>-Djava.rmi.server.hostname</code> JVM 引数は、リモート・メンバーがこのサーバーにアクセスするために使用する IP またはホスト名に必ず設定しなければなりません。したがたって、<b>localhost</b> には設定しないでください。さらに、<code>-Dcom.sun.management.jmxremote.port</code> JVM 引数の設定に使用されるポートが、JMX RMI 接続を有効にするために既に使用中のポートではないことを確認する必要があります。両方の引数が <b>CATALINA_OPTS</b> 環境変数で設定されます。
                            </li>
                            <li><b>WebSphere Application Server フル・プロファイル</b>
                                <br/>
                                管理サービスおよびサーバー上でデプロイされたすべてのランタイム・アプリケーションで、以下の JNDI プロパティーを宣言する必要があります。<ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                WebSphere Application Server コンソールで、以下を行います。
                                <ul>
                                    <li><b>「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」</b>を選択します。</li>
                                    <li>管理サービス・アプリケーションを選択します。</li>
                                    <li><b>「Web モジュール・プロパティー」</b>で<b>「Web モジュールの環境項目」</b>をクリックして、JNDI プロパティーを表示します。</li>
                                    <li>以下のプロパティーの値を設定します。
                                        <ul>
                                            <li><b>mfp.topology.clustermode</b> を <b>Farm</b> に設定します。</li>
                                            <li><b>mfp.admin.serverid</b> をこのファーム・メンバーに割り当てた ID に設定します。この ID は、すべてのファーム・メンバーにわたって固有である必要があります。</li>
                                            <li><b>mfp.admin.jmx.user</b> を SOAP コネクターにアクセスできるユーザー名に設定します。</li>
                                            <li><b>mfp.admin.jmx.pwd</b> を <b>mfp.admin.jmx.user</b> で宣言したユーザーのパスワードに設定します。</li>
                                            <li><b>mfp.admin.jmx.port</b> を SOAP ポートの値に設定します。</li>
                                        </ul>
                                    </li>
                                    <li><b>mfp.admin.jmx.connector</b> が <b>SOAP</b> に設定されていることを確認します。</li>
                                    <li><b>「OK」</b>をクリックし、構成を保存します。</li>
                                    <li>サーバー上にデプロイされているすべての {{ site.data.keys.product_adj }} ランタイム・アプリケーションに対して同様の変更を行います。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>ファームのすべてのメンバー間でトラストストア内のサーバー証明書を交換します。トラストストア内のサーバー証明書の交換は、WebSphere Application Server フル・プロファイルおよび WebSphere Application Server Liberty プロファイルを使用するファームにとって必須です。これは、これらのファームにおいてサーバー間の通信が SSL によって保護されるためです。
                        <ul>
                            <li><b>WebSphere Application Server Liberty プロファイル</b>
                                <br/>
                                トラストストアの構成は、Keytool または iKeyman などの IBM ユーティリティーを使用して行うことができます。
                                <ul>
                                    <li>Keytool について詳しくは、IBM SDK, Java Technology Edition の <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a> を参照してください。</li>
                                    <li>iKeyman について詳しくは、IBM SDK, Java Technology Edition の <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a> を参照してください。</li>
                                </ul>
                                鍵ストアおよびトラストストアのロケーションは、<b>server.xml</b> ファイルに定義されています。<a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">SSL 構成属性</a>内の <b>keyStoreRef</b> 属性と <b>trustStoreRef</b> 属性を参照してください。デフォルトで、Liberty プロファイルの鍵ストアは <b>${server.config.dir}/resources/security/key.jks</b> にあります。トラストストア参照が <b>server.xml</b> ファイルにないか定義されていない場合は、<b>keyStoreRef</b> によって指定された鍵ストアが使用されます。サーバーはデフォルトの鍵ストアを使用し、ファイルはサーバーを初めて実行した時に作成されます。その場合、365 日間の有効期間でデフォルト証明書が作成されます。実動では、独自の証明書 (必要な場合、中間証明書を含む) を使用したり、生成された証明書の有効期限を変更したりすることも検討できます。

                                <blockquote>注: トラストストアのロケーションを確認したい場合は、次の宣言を server.xml ファイルに追加することにより確認できます。
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                最後に、サーバーを始動し、<b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b> ファイル内で com.ibm.ssl.trustStore を含む行を見つけます。
                                <ul>
                                    <li>ファーム内の他のサーバーの公開証明書を、サーバーの <b>server.xml</b> 構成ファイルによって参照されているトラストストアにインポートします。<a href="../tutorials/graphical-mode">グラフィカル・モードでの {{ site.data.keys.mf_server }} のインストール</a>のチュートリアルに、ファーム内の 2 つの Liberty サーバー間で証明書を交換する手順が説明されています。詳しくは、<a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">{{ site.data.keys.mf_server }} を実行する 2 つの Liberty サーバーのファームの作成</a>セクションのステップ 5 を参照してください。</li>
                                    <li>WebSphere Application Server Liberty プロファイルの各インスタンスを再始動して、セキュリティー構成を有効にします。以下のステップは、シングル・サインオン (SSO) を機能させる場合に必須です。</li>
                                    <li>ファームのメンバーの 1 つを始動します。デフォルトの LTPA 構成では、Liberty サーバーが正常に始動すると、LTPA 鍵ストアを <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys</b> として生成します。</li>
                                    <li><b>ltpa.keys</b> ファイルを各ファーム・メンバーの <b>${wlp.user.dir}/servers/server_name/resources/security</b> ディレクトリーにコピーして、ファーム・メンバー全体にわたって LTPA 鍵ストアを複製します。LTPA 構成について詳しくは、<a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Liberty プロファイル上での LTPA の構成</a>を参照してください。</li>
                                </ul>
                            </li>
                            <li><b>WebSphere Application Server フル・プロファイル</b>
                                <br/>
                                WebSphere Application Server 管理コンソールでトラストストアを構成します。
                                <ul>
                                    <li>WebSphere Application Server 管理コンソールにログインします。</li>
                                    <li><b>「セキュリティー」→「SSL 証明書および鍵管理」</b>を選択します。</li>
                                    <li>「<b>関連項目</b>」で、<b>「鍵ストアおよび証明書」</b>を選択します。</li>
                                    <li><b>「鍵ストアの使用法」</b>フィールドで、<b>「SSL 鍵ストア」</b>が選択されていることを確認します。これで、ファーム内の他のすべてのサーバーから証明書をインポートできるようになりました。</li>
                                    <li><b>「NodeDefaultTrustStore」</b>をクリックします。</li>
                                    <li>「<b>追加プロパティー</b>」で、<b>「署名者証明書」</b>を選択します。</li>
                                    <li><b>「ポートから取得 (Retrieve from port)」</b>をクリックします。これで、ファーム内の他のサーバーそれぞれについて通信とセキュリティーの詳細を入力できるようになりました。他のファーム・メンバーのそれぞれに対して以下のステップに従って操作します。</li>
                                    <li><b>「ホスト」</b>フィールドに、サーバーのホスト名または IP アドレスを入力します。</li>
                                    <li><b>「ポート」</b>フィールドに、HTTPS トランスポート (SSL) ポートを入力します。</li>
                                    <li><b>「アウトバウンド接続のための SSL 構成」</b>で、<b>「NodeDefaultSSLSettings」</b>を選択します。</li>
                                    <li><b>「別名 (Alias)」</b>フィールドに、この署名者証明書の別名を入力します。</li>
                                    <li><b>「署名者情報の取得 (Retrieve signer information)」</b>をクリックします。</li>
                                    <li>リモート・サーバーから取得した情報を検討し、<b>「OK」</b>をクリックします。</li>
                                    <li><b>「保存 (Save)」</b>をクリックします。</li>
                                    <li>サーバーを再始動します。</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### ファーム構成の検証
{: #verifying-a-farm-configuration }
このタスクの目的は、ファーム・メンバーの状況をチェックすることと、ファームが正しく構成されているかどうかを検証することです。

1. ファームのすべてのサーバーを始動します。
2. {{ site.data.keys.mf_console }} にアクセスします。例えば、**http://server_name:port/mfpconsole**、または HTTPS では **https://hostname:secure_port/mfpconsole** です。
    コンソールのサイドバーに、「サーバー・ファームのノード」というラベルの付いた追加メニューが表示されます。
3. **「サーバー・ファームのノード」**をクリックすると、登録されているファーム・メンバーとその状況のリストにアクセスできます。次の例では、**FarmMember2** という名前のノードは、ダウンしていると見なされています。つまり、このサーバーはおそらく障害を発生しており、何らかのメンテナンスが必要であることを示しています。

![{{ site.data.keys.mf_console }} 内のファーム・ノードの状況](farm_nodes_status_list.jpg)

### サーバー・ファーム・ノードのライフサイクル
{: #lifecycle-of-a-server-farm-node }
影響を受けたノードの状況を変更することでファーム・メンバーの間で発生する可能性のあるサーバーの問題を示すために、ハートビート・レート値およびタイムアウト値を構成することができます。

#### ファーム・ノードとしてのサーバーの登録およびモニター
{: #registration-and-monitoring-servers-as-farm-nodes }
ファーム・ノードとして構成されたサーバーを始動すると、そのサーバーの管理サービスは、新規のファーム・メンバーとして自動的にそのサーバーを登録します。
ファーム・メンバーは、シャットダウンされると、ファームから自動的に登録が抹消されます。

ハートビート・メカニズムが存在するのは、例えば電源異常やサーバーの障害などが原因で応答しなくなる可能性のあるファーム・メンバーを追跡するためです。このハートビート・メカニズムでは、指定されたレートで周期的に {{ site.data.keys.product_adj }} ランタイムがハートビートを {{ site.data.keys.product_adj }} 管理サービスに送信します。ファーム・メンバーがハートビートを送信した後で経過した時間が長すぎることを {{ site.data.keys.product_adj }} 管理サービスが記録した場合に、そのファーム・メンバーはダウンしていると見なされます。

ダウンしていると見なされたファーム・メンバーは、それ以降モバイル・アプリケーションに対して要求へのサービスを行いません。

1 つ以上のノードがダウンしても、他のファーム・メンバーがモバイル・アプリケーションへの要求に対し正常にサービスを提供することや、{{ site.data.keys.mf_console }} でトリガーされる新しい管理操作を受け入れることは妨げられません。

#### ハートビート・レート値およびタイムアウト値の構成
{: #configuring-the-heartbeat-rate-and-timeout-values }
ハートビート・レート値およびタイムアウト値は、以下の JNDI プロパティーを定義することによって設定できます。

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
JNDI プロパティーについて詳しくは、[{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)を参照してください。
