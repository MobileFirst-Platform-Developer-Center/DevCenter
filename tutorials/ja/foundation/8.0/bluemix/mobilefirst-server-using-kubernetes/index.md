---
layout: tutorial
title: IBM Cloud Kubernetes クラスター上の MobileFirst Server のセットアップ
breadcrumb_title: Mobile Foundation on Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
下記の指示に従って {{ site.data.keys.mf_server }} インスタンスおよび {{ site.data.keys.mf_analytics }} インスタンスを IBM Cloud 上で構成します。 これは、次のような手順で行います。

* タイプ: 標準 (有料クラスター) の Kubernetes クラスターを作成します。
* 以下の必要なツールを使用して、ホスト・コンピューターをセットアップします。Docker、Cloud Foundry CLI ( cf )、IBM Cloud CLI ( bx )、Container Service Plugin for IBM Cloud CLI ( bx cs )、Container Registry Plugin for IBM Cloud CLI ( bx cr )、Kubernetes CLI (kubectl)
* {{ site.data.keys.mf_server }} Docker イメージをビルドし、それを IBM Cloud リポジトリーにプッシュします。
* 最後に、Kubernetes クラスター上で Docker イメージを実行します。

>**注:**  
>
* Windows OS でのこれらのスクリプトの実行は現在サポートされていません。  
* {{ site.data.keys.mf_server }} 構成ツールは IBM Containers へのデプロイメントには使用できません。

#### ジャンプ先:
{: #jump-to }
* [IBM Cloud でアカウントを登録する](#register-an-account-on-ibmcloud)
* [ホスト・マシンをセットアップする](#set-up-your-host-machine)
* [IBM Cloud Container Service を使用して Kubernetes クラスターを作成およびセットアップする](#setup-kube-cluster)
* [{{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする](#download-the-ibm-mfpf-container-8000-archive)
* [前提条件](#prerequisites)
* [IBM Containers を使用して Kubernetes クラスター上の {{ site.data.keys.product_adj }} および Analytics サーバーをセットアップする](#setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers)
* [{{ site.data.keys.mf_server }} 修正の適用](#applying-mobilefirst-server-fixes)
* [IBM Cloud からの Kubernetes デプロイメントの削除](#removing-kube-deployments)
* [IBM Cloud からのデータベース・サービス構成の削除](#removing-the-database-service-configuration-from-ibmcloud)

## IBM Cloud でアカウントを登録する
{: #register-an-account-on-ibmcloud }
まだアカウントをお持ちでない場合は、[IBM Cloud Web サイト](https://bluemix.net)にアクセスし、**「無料で開始」**、または**「登録」**をクリックします。 次のステップに進むため、登録フォームに記入する必要があります。

### IBM Cloud ダッシュボード
{: #the-ibmcloud-dashboard }
IBM Cloud にサインインすると IBM Cloud ダッシュボードが表示され、アクティブな IBM Cloud **スペース**の概略が示されます。 デフォルトでは、この作業領域の名前は「dev」です。 必要に応じて、複数の作業領域/スペースを作成できます。

## ホスト・マシンをセットアップする
{: #set-up-your-host-machine }
コンテナーとイメージを管理するには、以下のツールをインストールする必要があります。
* Docker
* IBM Cloud CLI (bx)
* Container Service Plugin for IBM Cloud CLI ( bx cs )
* Container Registry Plugin for IBM Cloud CLI ( bx cr )
* Kubernetes CLI (kubectl)

[前提条件の CLI をセットアップする手順](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps)については、IBM Cloud 資料を参照してください。

## IBM Cloud Container Service を使用して Kubernetes クラスターを作成およびセットアップする
{: #setup-kube-cluster}
[IBM Cloud 上の Kubernetes クラスターをセットアップする](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli)には、IBM Cloud の資料を参照してください。

>**注:** {{ site.data.keys.mf_bm_short }} のデプロイには、Kubernetes クラスター・タイプ: 標準 (有料クラスター) が必要です。

## {{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする
{: #download-the-ibm-mfpf-container-8000-archive}
IBM Cloud Container を使用して、{{ site.data.keys.mf_bm_short }} を Kubernetes クラスターとしてセットアップするには、まず、後で IBM Cloud にプッシュするイメージを作成する必要があります。<br/>
IBM Containers 上の MobileFirst Server 用の暫定修正を [IBM Fix Central](http://www.ibm.com/support/fixcentral) から取得できます。<br/>
Fix Central から、最新の暫定修正をダウンロードします。 Kubernetes サポートは、iFix **8.0.0.0-IF201707051849** 以降で使用可能です。

このアーカイブ・ファイルには、イメージをビルドするためのファイル (**dependencies** と **mfpf-libs**)、 Kubernetes 上で {{ site.data.keys.mf_server }} および {{ site.data.keys.mf_analytics }} をビルドしてデプロイするためのファイル (bmx-kubenetes) が含まれています。

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>クリックすると、アーカイブ・ファイルの内容と使用できる環境プロパティーについて、詳細情報が表示されます</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="アーカイブ・ファイルのファイル・システム構成を示すイメージ" style="float:right;width:570px"/>
                <h4>bmx-kubernetes フォルダー</h4>
                <p>IBM Cloud Container Service を使用して Kubernetes クラスターにデプロイするために必要な、カスタマイズ・ファイルとスクリプトが含まれています。</p>

                <h4>Dockerfile-mfpf-analytics と Dockerfile-mfpf-server</h4>

                <ul>
                    <li><b>Dockerfile-mfpf-server</b>: {{ site.data.keys.mf_server }} イメージをビルドするのに必要なコマンドがすべて含まれているテキスト文書です。</li>
                    <li><b>Dockerfile-mfpf-analytics</b>: {{ site.data.keys.mf_analytics }} イメージをビルドするのに必要なコマンドがすべて含まれているテキスト文書です。</li>
                    <li><b>scripts</b> フォルダー: このフォルダーには、<b>args</b> フォルダー (構成ファイルのセットを含む) が含まれます。 また、IBM Cloud へのログイン、{{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} イメージのビルド、およびイメージのプッシュと IBM Cloud での実行に必要なスクリプトも含まれます。 スクリプトは、対話式に実行することも、後述のように、構成ファイルを事前に設定することで実行することもできます。 カスタマイズ可能な args/*.properties ファイル以外、このフォルダー内のエレメントを変更しないでください。 スクリプトの使用法に関するヘルプを表示するには、<code>-h</code> または <code>--help</code> コマンド・ライン引数を使用します (例: <code>scriptname.sh --help</code>)。</li>
                    <li><b>usr-mfpf-server</b> フォルダーと <b>usr-mfpf-analytics</b> フォルダー
                        <ul>
                            <li><b>bin</b> フォルダー: コンテナーの始動時に実行されるスクリプト・ファイル (mfp-init) が入っています。 実行する独自のカスタム・コードを追加できます。</li>
                            <li><b>config</b> フォルダー: {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} によって使用されるサーバー構成フラグメント (鍵ストア、サーバー・プロパティー、ユーザー・レジストリー) が含まれます。</li>
                            <li><b>keystore.xml</b> - SSL 暗号化に使用されるセキュリティー証明書のリポジトリーの構成が含まれています。 リストされたファイルは、./usr/security フォルダー内で参照される必要があります。</li>
                            <li><b>ltpa.xml</b> - LTPA 鍵とそのパスワードを定義する構成ファイル。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }}および {{ site.data.keys.mf_analytics }} の構成プロパティー。 以下の資料トピックにリストされた、サポートされるプロパティーを参照してください。
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a></li>
                                </ul>
                            </li>
                            <li><b>mfpfsqldb.xml</b> - DB2 データベースまたは dashDB データベースに接続するための JDBC データ・ソース定義。</li>
                            <li><b>registry.xml</b> - ユーザー・レジストリー構成。 basicRegistry (基本の XML ベースのユーザー・レジストリー構成がデフォルトとして提供されています。 basicRegistry 用にユーザー名とパスワードを構成できます。または ldapRegistry を構成することができます。</li>
                            <li><b>tracespec.xml</b> - デバッグ・レベルだけでなく、ロギング・レベルを有効にするトレース仕様。</li>
                        </ul>
                    </li>
                    <li><b>jre-security</b> フォルダー: JRE セキュリティー関連のファイル (トラストストア、ポリシー JAR ファイルなど) を、このフォルダーに配置することで更新できます。 このフォルダー内のファイルは、コンテナーの <b>JAVA_HOME/jre/lib/security/</b> フォルダーにコピーされます。</li>
                    <li><b>security</b> フォルダー: 鍵ストア、トラストストア、および LTPA 鍵ファイル (ltpa.keys) の保管場所として使用します。</li>
                    <li><b>env</b> フォルダー: サーバーの初期化に使用される環境プロパティー (server.env) およびカスタム JVM オプション (jvm.options) が含まれています。</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>クリックすると、サポートされているサーバー環境プロパティーのリストが表示されます</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>プロパティー</b></td>
                                            <td><b>デフォルト値</b></td>
                                            <td><b>説明</b></td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>クライアント HTTP 要求に使用されるポート。 このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>SSL (HTTPS) で保護されたクライアント HTTP 要求に使用されるポート。 このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services が使用可能になるコンテキスト・ルート。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>{{ site.data.keys.mf_console }} が使用可能になるコンテキスト・ルート。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>事前定義の役割 <code>mfpadmin</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP	</td>
                                            <td>mfpdeployergroup</td>
                                            <td>事前定義の役割 <code>mfpdeployer</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>事前定義の役割 <code>mfpmonitor</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP	</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>事前定義の役割 <code>mfpoperator</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER	</td>
                                            <td>WorklightRESTUser</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services の Liberty サーバー管理者ユーザー。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin。 実稼働環境にデプロイする前に、デフォルト値を個人用パスワードに変更するようにしてください。</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services の Liberty サーバー管理者ユーザーのパスワード。</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>セクションを閉じる</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>クリックすると、サポートされている分析環境プロパティーのリストが表示されます</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>プロパティー</b></td>
                                            <td><b>デフォルト値</b></td>
                                            <td><b>説明</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>クライアント HTTP 要求に使用されるポート。 このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>クライアント HTTP 要求に使用されるポート。 このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>事前定義のロール <b>worklightadmin</b> を所有しているユーザー・グループの名前。</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>セクションを閉じる</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <li><b>dependencies</b> フォルダー: {{ site.data.keys.mf_bm_short }} ランタイムおよび IBM Java JRE 8 が含まれています。</li>
                    <li><b>mfpf-libs folder</b> フォルダー: {{ site.data.keys.product_adj }} 製品コンポーネント・ライブラリーおよび CLI が含まれています。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

## 前提条件
{: #prerequisites }

この手順を実行するには、操作者に、Kubernetes の実用的知識が必要です。 詳しくは、[Kubernetes 資料](https://kubernetes.io/docs/concepts/)を参照してください。


## IBM Containers を使用して Kubernetes クラスター上の {{ site.data.keys.product_adj }} および Analytics サーバーをセットアップする
{: #setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers }
前述のとおり、スクリプトは、対話式に実行することも、構成ファイルを使用して実行することもできます。

* **構成ファイルを使用する場合**: スクリプトを実行し、個々の構成ファイルを引数として渡します。
* **対話式の場合**: 引数を付けずにスクリプトを実行します。

>**注:** スクリプトを対話式に実行する場合は、この構成をスキップしてかまいませんが、指定することになる引数について一読し、理解しておくことを、強くお勧めします。

対話式に実行する場合、指定された引数のコピーがディレクトリー: `./recorded-args/` に保存されます。 このため、初めて対話モードを使用したあと、その後のデプロイメントの参照としてプロパティー・ファイルを再使用できます。

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。 以下のファイルに引数値を入力します。<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_API_URL - </b>デプロイメントを行う地理的な場所や地域。<br>
                      <blockquote>例: <i>api.ng.bluemix.net</i> は米国地域用、<i>api.eu-de.bluemix.net</i> はドイツ用、<i>api.au-syd.bluemix.net</i> はシドニー用。</blockquote>
                    </li>
                    <li><b>IBM_CLOUD_ACCOUNT_ID - </b>ご使用のアカウント ID。これは、英数字で、例えば <i>a1b1b111d11e1a11d1fa1cc999999999</i> などです。<br>	コマンド <code>bx target</code> を使用してアカウント ID を取得します。</li>
                    <li><b>IBM_CLOUD_USER - </b>ご使用の IBM Cloud ユーザー名 (E メール)。</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>ご使用の IBM Cloud パスワード。</li>
                    <li><b>IBM_CLOUD_ORG - </b>ご使用の IBM Cloud 組織名。</li>
                    <li><b>IBM_CLOUD_SPACE - </b>ご使用の IBM Cloud スペース (前述のとおり)。</li>
                </ul><br/>
                <h4>prepareserverdbs.properties</h4>
                {{ site.data.keys.mf_bm_short }} サービスでは、外部の <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 on Cloud</i></a> インスタンスが必要です。<br/>
                <blockquote><b>注:</b> 独自の DB2 データベースを使用することもできます。 IBM Cloud Kubenetes クラスターは、データベースに接続するように構成する必要があります。</blockquote>
                DB2 インスタンスのセットアップが完了したら、必要な引数を入力します。
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i> (DB2 on Cloud を使用している場合) または <i>DB2</i> (独自の DB2 データベースを使用している場合)。</li>
                    <li>独自の DB2 データベースを使用している (すなわち、DB_TYPE=DB2) 場合は、以下を指定します。
                      <ul><li><b>DB2_HOST</b> - DB2 セットアップのホスト名。</li>
                          <li><b>DB2_DATABASE</b> - データベースの名前。</li>
                          <li><b>DB2_PORT</b> - データベースに接続するポート。</li>
                          <li><b>DB2_USERNAME</b> - DB2 データベース・ユーザー (ユーザーには、指定されたスキーマ内で表を作成するための許可がある必要があります。あるいは、スキーマがまだ存在していない場合、ユーザーはスキーマを作成できる必要があります)</li>
                          <li><b>DB2_PASSWORD</b> - DB2 ユーザーのパスワード。</li>
                      </ul>
                    </li>
                    <li>DB2 on Cloud を使用している (すなわち、DB_TYPE=dashDB) 場合は、以下を指定します。
                      <ul><li><b>ADMIN_DB_SRV_NAME</b> - admin データを保管するための dashDB サービス・インスタンス名。</li>
                          <li><b>RUNTIME_DB_SRV_NAME</b> - ランタイム・データを保管するための dashDB サービス・インスタンス名。 デフォルトは admin のサービス名です。</li>
                          <li><b>PUSH_DB_SRV_NAME</b> - ランタイム・データを保管するための dashDB サービス・インスタンス名。 デフォルトは admin のサービス名です。</li>
                      </ul>
                    </li>
                    <li><b>ADMIN_SCHEMA_NAME</b> - admin データ用のスキーマ名。 デフォルトは <i>MFPDATA</i> です。</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>ランタイム・データ用のスキーマ名。 デフォルトは <i>MFPDATA</i> です。</li>
                    <li><b>PUSH_SCHEMA_NAME</b> - ランタイム・データ用のスキーマ名。 デフォルトは <i>MFPDATA</i> です。</li>
                    <blockquote><b>注:</b> DB2 データベース・サービス・インスタンスが多数のユーザーや複数の {{ site.data.keys.mf_bm_short }} デプロイメントによって共有されている場合は、必ず固有のスキーマ名を指定してください。</blockquote>
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - 当該イメージのタグ。 <em>registry-url/namespace/image:tag</em> の形式でなければなりません。</li>
                  <li><b>ANALYTICS_IMAGE_TAG</b> - 当該イメージのタグ。 <em>registry-url/namespace/image:tag</em> の形式でなければなりません。</li>
                  <blockquote>例: <em>registry.ng.bluemix.net/myuniquenamespace/mymfpserver:v1</em><br/>Docker レジストリーの名前空間をまだ作成していない場合は、次のいずれかのコマンドを使用してレジストリーの名前空間を作成します。<br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">スクリプトの実行</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。 非対話モードでの実行を選択した場合は、コマンド・ライン引数のリストも使用可能です。</p>

            <ol>
                <li><b>initenv.sh – IBM Cloud へのログイン</b><br />
                    <b>initenv.sh</b> スクリプトを実行して、IBM Containers 上で {{ site.data.keys.mf_bm_short }} をビルドおよび実行する環境を作成します。
                    <b>対話モード</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>非対話モード</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareserverdbs.sh - {{ site.data.keys.mf_server }} データベースの準備</b><br />
                    <b>prepareserverdbs.sh</b> スクリプトを使用して、DB2 データベース・サービスが含まれた {{ site.data.keys.mf_server }} を構成します。 DB2 サービスのサービス・インスタンスは、手順 1 でログインした組織およびスペースで使用可能でなければなりません。以下を実行します。
                    <b>対話モード</b>
{% highlight bash %}
./prepareserverdbs.sh
{% endhighlight %}
                    <b>非対話モード</b>
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh(Optional) – IBM Cloud へのログイン</b><br />
                      このステップは、DB2 サービス・インスタンスが使用可能になっている組織およびスペースとは別の組織およびスペースにコンテナーを作成する必要がある場合にのみ必須です。 この条件に当てはまる場合は、コンテナーを作成 (および開始) する必要のある新しい組織およびスペースの情報で initenv.properties を更新し、次のように <b>initenv.sh</b> スクリプトを再実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - {{ site.data.keys.mf_server }} イメージの準備</b><br />
                    {{ site.data.keys.mf_server }} および {{ site.data.keys.mf_analytics }} イメージをビルドし、これを IBM Cloud リポジトリーにプッシュするため、<b>prepareserver.sh</b> スクリプトを実行します。 IBM Cloud リポジトリー内にある使用可能なすべてのイメージを表示するには、次のコマンドを実行します。<code>bx cr image-list</code><br/>
                    リストには、イメージ名、作成日、および ID が表示されます。<br/>
                    <b>対話モード</b>
{% highlight bash %}
./prepareserver.sh
{% endhighlight %}
                    <b>非対話モード</b>
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                </li>
                <li>IBM Cloud Container Service を使用して、{{ site.data.keys.mf_server }} と {{ site.data.keys.mf_analytics }} を Kubernetes クラスター上の Docker コンテナーにデプロイします。
                <ol>
                  <li>ターミナル・コンテキストをクラスターに設定します。<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  クラスター名を知るには、次のコマンドを実行します。 <br/><code>bx cs clusters</code><br/>
                  この出力に、環境変数を設定するコマンドとして構成ファイルへのパスが表示されます。例えば次のとおりです。<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  <em>my-cluster</em> をご使用のクラスター名に置き換えて上記のコマンドをコピーして貼り付けて、ターミナルに環境変数を設定し、<b>Enter</b> を押します。
                  </li>
                  <li><b>[{{ site.data.keys.mf_analytics }} の場合必須]: </b> <b>永続ボリューム要求</b>を作成します。 これは、Analytics データを永続化するために使用されます。 これは 1 回限りの手順です。 以前に <b>PVC</b> を作成済みであれば、それを再使用できます。 <em>yaml</em> ファイル <b>args/mfpf-persistent-volume-claim.yaml</b> を編集し、コマンドを実行します。
                  次の <em>kubectl</em> コマンドを実行する前に、すべての変数をその値に置き換える必要があります。<br/><code>kubectl create -f ./args/mfpf-persistent-volume-claim.yaml</code><br/>
                  後の手順で指定する必要があるため、<b>永続ボリューム要求</b>の名前をメモします。
                  </li>
                  <li><b>入口ドメイン</b>を取得するには、次のコマンドを実行します。<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   入口ドメインをメモします。 TLS を構成する必要がある場合は、<b>入口秘密</b>をメモします。</li>
                  <li>Kubernetes デプロイメントを作成します。<br/>yaml ファイル <b>args/mfpf-deployment-all.yaml</b> を編集して、詳細を設定します。 <em>kubectl</em> コマンドを実行する前に、すべての変数をその値に置き換える必要があります。<br/>
                  <b>./args/mfpf-deployment-all.yaml</b> には次のデプロイメントが含まれています。
                  <ul>
                    <li>1024 MB のメモリーと 1Core CPU で、3 個のインスタンス (レプリカ) で構成される {{ site.data.keys.mf_server }} の Kubernetes デプロイメント。</li>
                    <li>1024 MB のメモリーと 1Core CPU で、2 個のインスタンス (レプリカ) で構成される {{ site.data.keys.mf_analytics }} の Kubernetes デプロイメント。</li>
                    <li>{{ site.data.keys.mf_server }} の Kubernetes サービス。</li>
                    <li>{{ site.data.keys.mf_analytics }} の Kubernetes サービス。</li>
                    <li>{{ site.data.keys.mf_server }} および {{ site.data.keys.mf_analytics }} のすべての REST エンドポイントなど、セットアップ全体のための入口。</li>
                    <li>{{ site.data.keys.mf_server }} および {{ site.data.keys.mf_analytics }} のインスタンスで環境変数を使用可能にするための、configMap。</li>
                  </ul>
                  YAML ファイルの以下の値を編集する必要があります。<br/>
                    <ol><li>上述のように、<b>入口ドメイン</b>の出力の <em>my-cluster.us-south.containers.mybluemix.net</em> が、<code>bx cs cluster-get</code> コマンドの出力と異なります。</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpfanalytics:latest</em> と <em>registry.ng.bluemix.net/repository/mfpfserver:latest</em> - イメージをアップロードするために prepareserver.sh で使用したのと同じ名前を使用します。</li>
                    <li><b>claimName</b>: <em>mfppvc</em> - PVC を作成するために上記で使用した永続ボリューム要求の名前を名前として使用します。<br/></li>
                    </ol>
                    次のコマンドを実行します。<br/>
                    <code>kubectl create -f ./args/mfpf-deployment-all.yaml</code>
                    <blockquote><b>注: <br/></b>以下のテンプレート yaml ファイルが提供されます。<br/>
                    <ul><li><b>mfpf-deployment-all.yaml</b>: {{ site.data.keys.mf_server }} と {{ site.data.keys.mf_analytics }} を http でデプロイします。</li>
                      <li><b>mfpf-deployment-all-tls.yaml</b>: {{ site.data.keys.mf_server }} と {{ site.data.keys.mf_analytics }} を https でデプロイします。</li>
                      <li><b>mfpf-deployment-server.yaml</b>: {{ site.data.keys.mf_server }} を http でデプロイします。</li>
                      <li><b>mfpf-deployment-analytics.yaml</b>: {{ site.data.keys.mf_analytics }} を http でデプロイします。</li></ul></blockquote>
                      作成後、Kubernetes ダッシュボードを使用するには、次のコマンドを実行します。<br/>
                      <code>kubectl proxy</code><br/>ブラウザーに <b>localhost:8001/ui</b> を開きます。
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>

これで、IBM Cloud で実行中の {{ site.data.keys.mf_server }} を使用して、アプリケーション開発を始めることができます。 {{ site.data.keys.product }} [チュートリアルを確認してください。](../../all-tutorials)


## {{ site.data.keys.mf_server }} 修正の適用
{: #applying-mobilefirst-server-fixes }

IBM Containers 上の {{ site.data.keys.mf_server }} 用の暫定修正を [IBM Fix Central](http://www.ibm.com/support/fixcentral) から取得できます。  
暫定修正を適用する前に、既存の構成ファイルのバックアップを取ってください。 構成ファイルは次のフォルダー内にあります。
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry アプリケーション: **package_root/bmx-kubernetes/usr-mfpf-server**

### iFix を適用するためのステップ:

1. 暫定修正アーカイブをダウンロードし、その内容を既存のインストール・フォルダーに解凍して、既存のファイルを上書きします。
2. バックアップした構成ファイルを **package_root/bmx-kubernetes/usr-mfpf-server** および **package_root/bmx-kubernetes/usr-mfpf-analytics** の各フォルダーにリストアし、新規にインストールされた構成ファイルを上書きします。
3. エディターで **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** ファイルを編集して、次の行が存在する場合は削除します。
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    これで、更新したサーバーをビルドおよびデプロイできるようになりました。

    a. `prepareserver.sh` スクリプトを実行してサーバー・イメージを再ビルドし、それを IBM コンテナー・サービスにプッシュします。

    b. 次のコマンドを実行して、ローリング更新を実行します。
      <code>kubectl rolling-update NAME -f FILE</code>

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## IBM Cloud からの Kubernetes デプロイメントの削除
{: #removing-kube-deployments}

次のコマンドを実行して、デプロイされたインスタンスを IBM Cloud Kubernetes クラスターから削除します。

`kubectl delete -f mfpf-deployment-all.yaml` ( yaml で定義されたすべての Kubernetes タイプを削除します )

以下のコマンドを実行して、IBM Cloud レジストリーからイメージ名を削除します。
```bash
bx cr image-list (レジストリー内のイメージをリストします)
bx cr image-rm image-name (レジストリーからイメージを削除します)
```

## IBM Cloud からのデータベース・サービス構成の削除
{: #removing-the-database-service-configuration-from-ibmcloud }
{{ site.data.keys.mf_server }} イメージの構成時に **prepareserverdbs.sh** スクリプトを実行した場合、{{ site.data.keys.mf_server }} に必要な構成およびデータベース・テーブルが作成されます。 このスクリプトは、コンテナー用のデータベース・スキーマも作成します。

IBM Cloud からデータベース・サービス構成を削除するには、IBM Cloud ダッシュボードを使用して、以下の手順を実行します。

1. IBM Cloud ダッシュボードから、使用した DB2 on Cloud サービスを選択します。 **prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定した DB2 サービス名を選択します。
2. 選択した DB2 サービス・インスタンスのスキーマおよびデータベース・オブジェクトを対処するために、DB2 コンソールを「起動」します。
3. IBM {{ site.data.keys.mf_server }} 構成に関連したスキーマを選択します。 スキーマ名は、**prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定したスキーマ名です。
4. スキーマ名とその下のオブジェクトを慎重に調べた後で、それぞれのスキーマを削除します。 IBM Cloud からデータベース構成が削除されます。
