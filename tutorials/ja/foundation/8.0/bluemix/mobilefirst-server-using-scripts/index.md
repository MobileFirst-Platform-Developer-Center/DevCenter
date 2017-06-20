---
layout: tutorial
title: IBM Containers 用のスクリプトを使用して IBM Bluemix 上に MobileFirst Server をセットアップする
breadcrumb_title: IBM Containers
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
下記の指示に従って {{ site.data.keys.mf_server }} インスタンスおよび {{ site.data.keys.mf_analytics }} インスタンスを IBM Bluemix 上で構成します。これは、次のような手順で行います。

* 必要なツール (Cloud Foundry CLI、Docker、および IBM Containers 拡張機能 (cf ic) プラグイン) を使用して、ホスト・コンピューターをセットアップする
* Bluemix アカウントをセットアップする
* {{ site.data.keys.mf_server }} イメージをビルドし、これを Bluemix リポジトリーにプッシュする

最後に、このイメージを IBM Containers 上で単一コンテナーまたはコンテナー・グループとして実行し、アプリケーションを登録して、アダプターをデプロイします。

**注:**  

* Windows OS でのこれらのスクリプトの実行は現在サポートされていません。  
* {{ site.data.keys.mf_server }} 構成ツールは IBM Containers へのデプロイメントには使用できません。

#### ジャンプ先:
{: #jump-to }
* [Bluemix でアカウントを登録する](#register-an-account-at-bluemix)
* [ホスト・マシンをセットアップする](#set-up-your-host-machine)
* [{{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする](#download-the-ibm-mfpf-container-8000-archive)
* [前提条件](#prerequisites)
* [IBM Containers 上での {{ site.data.keys.product_adj }} Server と Analytics Server のセットアップ](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [{{ site.data.keys.mf_server }} 修正の適用](#applying-mobilefirst-server-fixes)
* [Bluemix からのコンテナーの削除](#removing-a-container-from-bluemix)
* [Bluemix からのデータベース・サービス構成の削除](#removing-the-database-service-configuration-from-bluemix)

## Bluemix でアカウントを登録する
{: #register-an-account-at-bluemix }
まだアカウントをお持ちでない場合は、[Bluemix Web サイト](https://bluemix.net)にアクセスし、**「無料で開始」**、または**「登録」**をクリックします。次のステップに進むため、登録フォームに記入する必要があります。

### Bluemix ダッシュボード
{: #the-bluemix-dashboard }
Bluemix にサインインすると Bluemix ダッシュボードが表示され、アクティブな Bluemix **スペース**の概略が示されます。デフォルトでは、この作業領域の名前は「dev」です。必要に応じて、複数の作業領域/スペースを作成できます。

## ホスト・マシンをセットアップする
{: #set-up-your-host-machine }
コンテナーとイメージを管理するには、ツールとして Docker、Cloud Foundry CLI、および IBM Containers (cf ic) プラグインをインストールする必要があります。

### Docker
{: #docker }
[Docker 資料](https://docs.docker.com/)  左側のメニューで、**「Install」→「Docker Engine」** を選択し、OS の種類を選択し、指示に従って Docker Toolbox をインストールします。

**注:** IBM では、Docker の Kitematic はサポートしていません。

macOS では、Docker コマンドを実行するには、次の 2 つのオプションがあります。

* macOS の Terminal.app から: 追加のセットアップは必要ありません。このターミナルだけから作業できます。
* Docker Quickstart Terminal から: 次の手順を行います。

* 次のコマンドを実行します:

  ```bash
  docker-machine env default
  ```

* 結果を環境変数として設定します。例:

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> 詳しくは、Docker の資料を参照してください。

### Cloud Foundry プラグインと IBM Containers プラグイン
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195) をインストールします。
2. [IBM Containers プラグイン (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html) をインストールします。

## {{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする
{: #download-the-ibm-mfpf-container-8000-archive}
IBM Containers 上で {{ site.data.keys.product }} をセットアップするには、まず最初にイメージを作成する必要があります。このイメージは、のちほど Bluemix にプッシュします。  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">このページの指示に従って</a>、{{ site.data.keys.mf_server }} の IBM Containers 用アーカイブ (.zip ファイル。*CNBL0EN* で検索) をダウンロードしてください。

このアーカイブ・ファイルには、イメージをビルドするためのファイル (**dependencies** と **mfpf-libs**)、{{ site.data.keys.mf_analytics }} コンテナーをビルドしてデプロイするためのファイル (**mfpf-analytics**)、および {{ site.data.keys.mf_server }} コンテナーを構成するためのファイル (**mfpf-server**) が含まれています。

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
                <h4>dependencies フォルダー</h4>
                <p>{{ site.data.keys.product }} ランタイムおよび IBM Java JRE 8 が含まれています。</p>

                <h4>mfpf-libs フォルダー</h4>
                <p>{{ site.data.keys.product_adj }} 製品コンポーネント・ライブラリーおよび CLI が含まれています。</p>

                <h4>mfpf-server フォルダーと mfpf-analytics フォルダー</h4>

                <ul>
                    <li><b>Dockerfile</b>: イメージをビルドするのに必要なコマンドがすべて含まれているテキスト文書です。</li>
                    <li><b>scripts</b> フォルダー: このフォルダーには、<b>args</b> フォルダー (構成ファイルのセットを含む) が含まれます。また、Bluemix へのログイン、{{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} イメージのビルドおよび Bluemix へのイメージのプッシュと実行に必要なスクリプトも含まれます。スクリプトは、対話式に実行することも、(後述のように) 構成ファイルを事前に設定することで実行することもできます。カスタマイズ可能な args/*.properties ファイル以外、このフォルダー内のエレメントを変更しないでください。スクリプトの使用法に関するヘルプを表示するには、<code>-h</code> または <code>--help</code> コマンド・ライン引数を使用します (例: <code>scriptname.sh --help</code>)。</li>
                    <li><b>usr</b> フォルダー:
                        <ul>
                            <li><b>bin</b> フォルダー: コンテナーの始動時に実行されるスクリプト・ファイルが入っています。実行する独自のカスタム・コードを追加できます。</li>
                            <li><b>config</b> フォルダー: {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} によって使用されるサーバー構成フラグメント (鍵ストア、サーバー・プロパティー、ユーザー・レジストリー) が含まれます。</li>
                            <li><b>keystore.xml</b> - SSL 暗号化に使用されるセキュリティー証明書のリポジトリーの構成が含まれています。リストされたファイルは、./usr/security フォルダー内で参照される必要があります。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }}および {{ site.data.keys.mf_analytics }} の構成プロパティー。以下の資料トピックにリストされた、サポートされるプロパティーを参照してください。
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - ユーザー・レジストリー構成。basicRegistry (基本の XML ベースのユーザー・レジストリー構成がデフォルトとして提供されています。basicRegistry 用にユーザー名とパスワードを構成できます。または ldapRegistry を構成することができます。</li>
                        </ul>
                    </li>
                    <li><b>env</b> フォルダー: サーバーの初期化に使用される環境プロパティー (server.env) およびカスタム JVM オプション (jvm.options) が含まれています。</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>クライアント HTTP 要求に使用されるポート。このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT</td>
                                            <td>9443*	</td>
                                            <td>SSL (HTTPS) で保護されたクライアント HTTP 要求に使用されるポート。このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>構成は必要ありません。有効値は <code>Standalone</code> または <code>Farm</code> です。コンテナーがコンテナー・グループとして実行される場合、<code>Farm</code> 値が自動的に設定されます。</td>
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
                                            <td>MFPF_DEPLOYER_GROUP</td>
                                            <td>mfpdeployergroup</td>
                                            <td>事前定義の役割 <code>mfpdeployer</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>事前定義の役割 <code>mfpmonitor</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>事前定義の役割 <code>mfpoperator</code> が割り当てられたユーザー・グループの名前。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER</td>
                                            <td>WorklightRESTUser</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services の Liberty サーバー管理者ユーザー。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD</td>
                                            <td>mfpadmin。実稼働環境にデプロイする前に、デフォルト値を個人用パスワードに変更するようにしてください。</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services の Liberty サーバー管理者ユーザーのパスワード。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 操作の管理者役割のユーザー名。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 操作の管理者役割のパスワード。</td>
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
                                            <td>クライアント HTTP 要求に使用されるポート。このポートを無効にする場合は、-1 を使用します。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>クライアント HTTP 要求に使用されるポート。このポートを無効にする場合は、-1 を使用します。</td>
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


                    </li>
                    <li><b>jre-security</b> フォルダー: JRE セキュリティー関連のファイル (トラストストア、ポリシー JAR ファイルなど) を、このフォルダーに配置することで更新できます。このフォルダー内のファイルは、コンテナーの JAVA_HOME/jre/lib/security/ フォルダーにコピーされます。</li>
                    <li><b>security</b> フォルダー: 鍵ストア、トラストストア、および LTPA 鍵ファイル (ltpa.keys) の保管場所として使用します。</li>
                    <li><b>ssh</b> フォルダー: SSH 公開鍵ファイル (id_rsa.pub) の保管場所として使用されます。SSH 公開鍵ファイルは、コンテナーへの SSH アクセスを可能にするために使用されます。</li>
                    <li><b>wxs</b> フォルダー ({{ site.data.keys.mf_server }} 用のみ): データ・キャッシュをサーバーの属性ストアとして使用する場合に、データ・キャッシュ / extreme-scale クライアント・ライブラリーが含まれます。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

## 前提条件
{: #prerequisites }
この後のセクションで IBM Containers コマンドを実行するため、以下の手順は必須です。

1. IBM Bluemix 環境にログインします。  

    次のコマンドを実行します。`cf login`  
    プロンプトが出されたら、次の情報を入力します。
      * Bluemix API エンドポイント
      * E メール
      * パスワード
      * 組織 (複数ある場合)
      * スペース (複数ある場合)

2. IBM Containers コマンドを実行するには、まず最初に IBM Container Cloud Service にログインする必要があります。  
次のコマンドを実行します。`cf ic login`

3. コンテナー・レジストリーの`名前空間`が設定されていることを確認します。`名前空間`は、Bluemix レジストリー上のプライベート・リポジトリーを識別する固有の名前です。名前空間は 1 つの組織に一度割り当てられ、変更することはできません。次のルールに従って名前空間を選択します。
     * 使用できるのは、小文字、数字、下線のみです。
     * 4 文字から 30 文字までの長さにすることができます。コマンド・ラインからコンテナーを管理する予定の場合は、素早く入力できる短い名前空間を使用することをお勧めします。
     * Bluemix レジストリー内で固有でなければなりません。

    名前空間を設定するには、次のコマンドを実行します。`cf ic namespace set <new_name>`  
    設定した名前空間を取得するには、次のコマンドを実行します。`cf ic namespace get`。

> IC コマンドについて詳しく知るには、`ic help` コマンドを使用します。

## IBM Containers 上での {{ site.data.keys.product_adj }} Server、Analytics Server、および {{ site.data.keys.mf_app_center_short }} のセットアップ
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
前述のとおり、スクリプトは、対話式に実行することも、構成ファイルを使用して実行することもできます。

* 構成ファイルを使用する場合: スクリプトを実行し、個々の構成ファイルを引数として渡します。
* 対話式の場合: 引数を付けずにスクリプトを実行します。

**注:** スクリプトを対話式に実行する場合は、この構成をスキップしてかまいませんが、少なくとも、指定することになる引数について一読し、理解しておくことを、強くお勧めします。


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }
{{ site.data.keys.mf_app_center }} を使用する場合は、ここから開始します。

>**注:** インストーラーと DB ツールは、オンプレミスの {{ site.data.keys.mf_app_center }} インストール・フォルダー (`installer` フォルダーと `tools` フォルダー) からダウンロードできます。

<div class="panel-group accordion" id="scripts" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1appcenter" aria-expanded="false" aria-controls="collapseStep1appcenter">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapseStep1appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。以下のファイルに引数値を入力します。<br/>
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>BLUEMIX_USER - </b>ご使用の Bluemix ユーザー名 (E メール)。</li>
                  <li><b>BLUEMIX_PASSWORD - </b>ご使用の Bluemix パスワード。</li>
                  <li><b>BLUEMIX_ORG - </b>ご使用の Bluemix 組織名。</li>
                  <li><b>BLUEMIX_SPACE - </b>ご使用の Bluemix スペース (前述のとおり)。</li>
              </ul>
              <h4>prepareappcenterdbs.properties</h4>
              {{ site.data.keys.mf_app_center }} には、外部 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="_blank">dashDB Enterprise Transactional データベース・インスタンス</a> (Enterprise Transactional 2.8.500 または Enterprise Transactional 12.128.1400) が必要です。
              <blockquote><p><b>注:</b> dashDB Enterprise Transactional プランのデプロイメントは即時に行われない場合があります。サービスのデプロイメントの前に、販売チームから問い合わせを受けることがあります。</p></blockquote>

              dashDB インスタンスのセットアップが完了したら、以下の必須引数を指定します。
              <ul>
                  <li><b>APPCENTER_DB_SRV_NAME - </b>Application Center データを保管するための dashDB サービス・インスタンス名。</li>
                  <li><b>APPCENTER_SCHEMA_NAME - </b>Application Center データを保管するために使用されるデータベース・スキーマ名。</li>
                  <blockquote><b>注:</b> dashDB サービス・インスタンスを複数のユーザーが共有している場合は、必ず固有のスキーマ名を指定してください。</blockquote>

              </ul>
              <h4>prepareappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>当該イメージのタグ。<em>registry-url/namespace/your-tag</em> の形式でなければなりません。</li>
              </ul>
              <h4>startappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b><em>prepareappcenter.sh</em> で指定するものと同じ。</li>
                  <li><b>SERVER_CONTAINER_NAME - </b>ご使用の Bluemix コンテナーの名前。</li>
                  <li><b>SERVER_IP - </b>Bluemix コンテナーのバインド先とする IP アドレス。</li>
                  <blockquote>                    IP アドレスを割り当てるには、次のコマンドを実行します。<code>cf ic ip request</code>IP アドレスは、特定の Bluemix スペース内の複数のコンテナーで再使用できます。
                  既に割り当て済みの IP がある場合、<code>cf ic ip list</code> を実行できます。</blockquote>
              </ul>
              <h4>startappcentergroup.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b><em>prepareappcenter.sh</em> で指定するものと同じ。</li>
                  <li><b>SERVER_CONTAINER_GROUP_NAME - </b>ご使用の Bluemix コンテナー・グループの名前。</li>
                  <li><b>SERVER_CONTAINER_GROUP_HOST - </b>ホスト名。</li>
                  <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>ドメイン名。デフォルトは <code>mybluemix.net</code> です。</li>
              </ul>    
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="appcenterstep2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2appcenter" aria-expanded="false" aria-controls="collapseStep2appcenter">スクリプトの実行</a>
            </h4>
        </div>

        <div id="collapseStep2appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。対話モードを使用せずに実行することを選択した場合は、コマンド・ライン引数のリストも利用できます。</p>
                <ol>
                    <li><b>initenv.sh – Bluemix へのログイン</b><br />
次のように <b>initenv.sh</b> スクリプトを実行して、IBM Containers 上で {{ site.data.keys.product }} をビルドして実行するための環境を作成します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                                </div>

                                <div id="collapse-script-appcenter-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] BLUEMIX_USER</td>
                                                <td>Bluemix ユーザー ID または E メール・アドレス</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                                <td>Bluemix パスワード</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] BLUEMIX_ORG	</td>
                                                <td>Bluemix 組織名</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] BLUEMIX_SPACE	</td>
                                                <td>Bluemix スペース名</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-a|--api] BLUEMIX_API_URL	</td>
                                                <td>Bluemix API エンドポイント。(デフォルトでは https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>セクションを閉じる</b></a>
                                </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareappcenterdbs.sh - {{ site.data.keys.mf_app_center }} データベースの準備</b><br/>
                    <b>prepareappcenterdbs.sh</b> スクリプトを使用して、dashDB データベース・サービスが含まれた {{ site.data.keys.mf_app_center }} を構成します。手順 1 でログインした組織およびスペースにおいて、dashDB サービスのサービス・インスタンスが使用可能になっている必要があります。
                    次のコマンドを実行します。

{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenterdbs">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenterdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenterdbs">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>コマンド・ライン引数</b></td>
                                              <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-db | --acdb ] APPCENTER_DB_SRV_NAME	</td>
                                              <td>Bluemix dashDB サービス (Bluemix サービス・プラン「Enterprise Transactional」を使用)。</td>
                                            </tr>    
                                            <tr>
                                              <td>オプション: [-ds | --acds ] APPCENTER_SCHEMA_NAME	</td>
                                              <td>Application Center サービスのデータベース・スキーマ名。デフォルトは <i>APPCNTR</i> です。</td>
                                            </tr>    
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
prepareappcenterdbs.sh --acdb AppCenterDashDBService
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>セクションを閉じる</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>initenv.sh(Optional) – Bluemix へのログイン</b><br />
                    このステップは、dashDB サービス・インスタンスが使用可能になっている組織およびスペースとは別の組織およびスペースにコンテナーを作成する必要がある場合にのみ必須です。この条件に当てはまる場合は、コンテナーを作成 (および開始) する必要のある新しい組織およびスペースの情報で <b>initenv.properties</b> を更新し、次のように <b>initenv.sh</b> スクリプトを再実行します。</li>

{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}


                    <li><b>prepareappcenter.sh - {{ site.data.keys.mf_app_center }} イメージの準備</b><br />
                    {{ site.data.keys.mf_app_center }} イメージをビルドし、これを Bluemix リポジトリーにプッシュするため、<b>prepareappcenter.sh</b> スクリプトを実行します。Bluemix リポジトリー内で使用可能なすべてのイメージを表示するには、<code>cf ic images</code> を実行します。
                    リストには、イメージ名、作成日、および ID が表示されます。

                        次のコマンドを実行します。
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                                <td>カスタマイズされた MobileFirst Application Center イメージに使用する名前。フォーマット: <em>registryUrl/namespace/imagename</em></td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
prepareappcenter.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>セクションを閉じる</b></a>
                                </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcenter.sh - IBM コンテナーでのイメージの実行</b><br/>
                    IBM コンテナーで {{ site.data.keys.mf_app_center }} イメージを実行するために使用される <b>startappcenter.sh</b> スクリプト。また、このスクリプトを実行すると、<b>SERVER_IP</b> プロパティーで構成したパブリック IP にイメージがバインドされます。

                        次のコマンドを実行します。
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>{{ site.data.keys.mf_app_center }} イメージの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] SERVER_IP	</td>
                                                <td>{{ site.data.keys.mf_app_center }} コンテナーのバインド先の IP アドレス。(使用可能なパブリック IP を指定するか、<code>cf ic ip request</code> コマンドを使用してパブリック IP を要求できます。)</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-si|--services] SERVICE_INSTANCES	</td>
                                                <td>コンテナーにバインドする、コンマ区切りの Bluemix サービス・インスタンス。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-h|--http] EXPOSE_HTTP </td>
                                                <td>HTTP ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-s|--https] EXPOSE_HTTPS </td>
                                                <td>HTTPS ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-m|--memory] SERVER_MEM </td>
                                                <td>コンテナーに対してメモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-se|--ssh] SSH_ENABLE </td>
                                                <td>コンテナーに対して SSH を有効にします。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-sk|--sshkey] SSH_KEY </td>
                                                <td>コンテナーに注入される SSH 鍵。(id_rsa.pub ファイルの内容を指定します。)</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-tr|--trace] TRACE_SPEC </td>
                                                <td>適用されるトレース仕様。デフォルト: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-ml|--maxlog] MAX_LOG_FILES </td>
                                                <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション:  [-v|--volume] ENABLE_VOLUME </td>
                                                <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>

                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
startappcenter.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>セクションを閉じる</b></a>
                                </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcentergroup.sh - IBM コンテナー・グループでのイメージの実行</b><br/>
                    <b>startappcentergroup.sh</b> スクリプトを使用して、{{ site.data.keys.mf_app_center }} イメージを IBM コンテナー・グループ上で実行します。また、このスクリプトを実行すると、<b>SERVER_CONTAINER_GROUP_HOST</b> プロパティーで構成したホスト名にイメージがバインドされます。

                        次のコマンドを実行します。
{% highlight bash %}
./startappcentergroup.sh args/startappcentergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcentergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcentergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcentergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Bluemix レジストリー内の {{ site.data.keys.mf_app_center }} コンテナー・イメージの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>{{ site.data.keys.mf_app_center }} コンテナー・グループの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>ルートのホスト名。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>ルートのドメイン名。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-gm|--min] SERVERS_CONTAINER_GROUP_MIN </td>
                                                <td>コンテナー・インスタンスの最小数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-gx|--max] SERVER_CONTAINER_GROUP_MAX </td>
                                                <td>コンテナー・インスタンスの最大数。デフォルト値は 2 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED </td>
                                                <td>コンテナー・インスタンスの希望数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-a|--auto] ENABLE_AUTORECOVERY </td>
                                                <td>コンテナー・インスタンスの自動リカバリー・オプションを使用可能にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-si|--services] SERVICES </td>
                                                <td>コンテナーにバインドする、コンマ区切りの Bluemix サービス・インスタンス名。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-tr|--trace] TRACE_SPEC </td>
                                                <td>適用されるトレース仕様。デフォルトは </code>*=info</code> です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-ml|--maxlog] MAX_LOG_FILESC </td>
                                                <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-m|--memory] SERVER_MEM </td>
                                                <td>コンテナーに対して、メモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション: [-v|--volume] ENABLE_VOLUME </td>
                                                <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>

                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
startappcentergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>セクションを閉じる</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_server }} で分析を使用する場合は、ここから開始します。

<div class="panel-group accordion" id="scripts" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。以下のファイルに引数値を入力します。<br/>
            <b>注:</b> ここには、必要な引数値のみを含めています。その他の引数については、プロパティー・ファイル内の資料を参照してください。
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>BLUEMIX_USER - </b>ご使用の Bluemix ユーザー名 (E メール)。</li>
                  <li><b>BLUEMIX_PASSWORD - </b>ご使用の Bluemix パスワード。</li>
                  <li><b>BLUEMIX_ORG - </b>ご使用の Bluemix 組織名。</li>
                  <li><b>BLUEMIX_SPACE - </b>ご使用の Bluemix スペース (前述のとおり)。</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>当該イメージのタグ。<em>registry-url/namespace/your-tag</em> の形式でなければなりません。</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b><em>prepareserver.sh</em> で指定するものと同じ。</li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>ご使用の Bluemix コンテナーの名前。</li>
                  <li><b>ANALYTICS_IP - </b>Bluemix コンテナーのバインド先とする IP アドレス。<br/>
                    IP アドレスを割り当てるには、次のコマンドを実行します。<code>cf ic ip request</code><br/>
                    IP アドレスは、スペース内の複数のコンテナーで再使用できます。<br/>
                    既に割り当て済みの IP アドレスがある場合は、次のコマンドを実行できます。<code>cf ic ip list</code></li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b><em>prepareserver.sh</em> で指定するものと同じ。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>ご使用の Bluemix コンテナー・グループの名前。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>ホスト名。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>ドメイン名。デフォルトは <code>mybluemix.net</code> です。</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">スクリプトの実行</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。対話モードを使用せずに実行することを選択した場合は、コマンド・ライン引数のリストも利用できます。</p>
                <ol>
                    <li><b>initenv.sh – Bluemix へのログイン</b><br />
                    次のように <b>initenv.sh</b> スクリプトを実行して、IBM Containers 上で {{ site.data.keys.mf_analytics }} をビルドして実行するための環境を作成します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] BLUEMIX_USER</td>
                                                <td>Bluemix ユーザー ID または E メール・アドレス</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                                <td>Bluemix パスワード</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] BLUEMIX_ORG	</td>
                                                <td>Bluemix 組織名</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] BLUEMIX_SPACE	</td>
                                                <td>Bluemix スペース名</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-a|--api] BLUEMIX_API_URL	</td>
                                                <td>Bluemix API エンドポイント。(デフォルトでは https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>セクションを閉じる</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - {{ site.data.keys.mf_analytics }} イメージの準備</b><br />
                        次のように <b>prepareanalytics.sh</b> スクリプトを実行して、{{ site.data.keys.mf_analytics }} イメージをビルドし、これを Bluemix リポジトリーにプッシュします。

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        Bluemix リポジトリー内にあるすべてのイメージを表示するには、次のコマンドを実行します。<code>cf ic images</code><br/>
                        リストには、イメージ名、作成日、および ID が表示されます。

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>コマンド・ライン引数</b></td>
                                              <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>カスタマイズされた Analytics イメージに使用する名前。フォーマット: Bluemix registry URL/private namespace/image name</td>
                                            </tr>      
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>セクションを閉じる</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - IBM コンテナーでのイメージの実行</b><br />
                    <b>startanalytics.sh</b> スクリプトを使用して {{ site.data.keys.mf_analytics }} イメージを IBM コンテナー上で実行します。また、このスクリプトを実行すると、<b>ANALYTICS_IP</b> プロパティーで構成したパブリック IP にイメージがバインドされます。</li>

                    次のコマンドを実行します。
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>IBM Containers レジストリーにロードされた Analytics コンテナー・イメージの名前。フォーマット: BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>Analytics コンテナーの名前</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>コンテナーのバインド先の IP アドレス。(使用可能なパブリック IP を指定するか、<code>cf ic ip request</code> コマンドを使用してパブリック IP を要求できます。)</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-h|--http] EXPOSE_HTTP	</td>
                                                <td>HTTP ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-s|--https] EXPOSE_HTTPS	</td>
                                                <td>HTTPS ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-m|--memory] SERVER_MEM	</td>
                                                <td>コンテナーに対して、メモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-se|--ssh] SSH_ENABLE	</td>
                                                <td>コンテナーに対して SSH を有効にします。許容値は、Y (デフォルト) または N です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-sk|--sshkey] SSH_KEY	</td>
                                                <td>コンテナーに注入される SSH 鍵。(id_rsa.pub ファイルの内容を指定します。)</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>適用されるトレース仕様。デフォルト: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME	</td>
                                                <td>Analytics データ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Analytic データ用に作成してマウントされるボリュームの名前を指定します。デフォルトの名前は <b>mfpf_analytics_container_name</b> です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>データを保管する場所を指定します。デフォルトのフォルダー名は <b>/analyticsData</b> です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.mf_analytics }} のプロパティーをコンマ区切りの「キー:値」ペアとして指定します。注: このスクリプトを使用してプロパティーを指定する場合、同じプロパティーが usr/config フォルダー内の構成ファイルに設定されていないことを確認してください。</td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
                        {% highlight bash %}
                        startanalytics.sh --tag image_tag_name --name container_name --ip container_ip_address
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>セクションを閉じる</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - IBM コンテナー・グループでのイメージの実行</b><br />
                    <b>startanalyticsgroup.sh</b> スクリプトを使用して {{ site.data.keys.mf_analytics }} イメージを IBM コンテナー・グループ上で実行します。また、このスクリプトを実行すると、<b>ANALYTICS_CONTAINER_GROUP_HOST</b> プロパティーで構成したホスト名にイメージがバインドされます。

                        次のコマンドを実行します。
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>IBM Containers レジストリーにロードされた Analytics コンテナー・イメージの名前。フォーマット: BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>Analytics コンテナー・グループの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>ルートのホスト名。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>ルートのドメイン名。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN</td>
                                                <td>コンテナー・インスタンスの最小数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX	</td>
                                                <td>コンテナー・インスタンスの最大数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED	</td>
                                                <td>コンテナー・インスタンスの希望数。デフォルト値は 2 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>適用されるトレース仕様。デフォルト: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.product_adj }} のプロパティーをコンマ区切りの「キー:値」ペアとして指定します。例: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-m|--memory] SERVER_MEM	</td>
                                                <td>コンテナーに対して、メモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Analytics データ用に作成してマウントされるボリュームの名前を指定します。デフォルト値は <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b> です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>Analytics データを保管するために使用するディレクトリーを指定します。デフォルト値は <b>/analyticsData</b> です。</td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
startanalyticsgroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>セクションを閉じる</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                次の URL をロードして Analytics Console を起動します。http://ANALYTICS-CONTAINER-HOST/analytics/console (しばらく時間がかかる場合があります)。  
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。以下のファイルに引数値を入力します。<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>BLUEMIX_USER - </b>ご使用の Bluemix ユーザー名 (E メール)。</li>
                    <li><b>BLUEMIX_PASSWORD - </b>ご使用の Bluemix パスワード。</li>
                    <li><b>BLUEMIX_ORG - </b>ご使用の Bluemix 組織名。</li>
                    <li><b>BLUEMIX_SPACE - </b>ご使用の Bluemix スペース (前述のとおり)。</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                {{ site.data.keys.mf_bm_short }} サービスには、外部 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>dashDB Enterprise Transactional データベース</i> ・インスタンス</a> (<i>Enterprise Transactional 2.8.500</i> または <i>Enterprise Transactional 12.128.1400</i>) が必要です。<br/>
                <b>注:</b> dashDB Enterprise Transactional プランのデプロイメントは即時に行われない場合があります。サービスのデプロイメントの前に、販売チームから問い合わせを受けることがあります。<br/><br/>
                dashDB インスタンスのセットアップが完了したら、必要な引数を入力します。
                <ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>admin データを保管するための dashDB サービス・インスタンス名。</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>admin データ用のスキーマ名。デフォルトは MFPDATA です。</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>ランタイム・データを保管するための dashDB サービス・インスタンス名。デフォルトは admin のサービス名です。</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>ランタイム・データ用のスキーマ名。デフォルトは MFPDATA です。</li>
                    <b>注:</b> dashDB サービス・インスタンスを多数のユーザーが共有している場合は、必ず固有のスキーマ名を指定してください。
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>当該イメージのタグ。<em>registry-url/namespace/your-tag</em> の形式でなければなりません。</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b><em>prepareserver.sh</em> で指定するものと同じ。</li>
                    <li><b>SERVER_CONTAINER_NAME - </b>ご使用の Bluemix コンテナーの名前。</li>
                    <li><b>SERVER_IP - </b>Bluemix コンテナーのバインド先とする IP アドレス。<br/>
                    IP アドレスを割り当てるには、次のコマンドを実行します。<code>cf ic ip request</code><br/>
                    IP アドレスは、スペース内の複数のコンテナーで再使用できます。<br/>
                    既に割り当て済みの IP アドレスがある場合は、次のコマンドを実行できます。<code>cf ic ip list</code></li>
                    <li><b>MFPF_PROPERTIES - </b>コンマ区切り (<b>スペースなし</b>) の {{ site.data.keys.mf_server }} JNDI プロパティー。ここで、次のように分析関連のプロパティーを定義します。<code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b><em>prepareserver.sh</em> で指定するものと同じ。</li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>ご使用の Bluemix コンテナー・グループの名前。</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>ホスト名。</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>ドメイン名。デフォルトは <code>mybluemix.net</code> です。</li>
                    <li><b>MFPF_PROPERTIES - </b>コンマ区切り (<b>スペースなし</b>) の {{ site.data.keys.mf_server }}JNDI プロパティー。ここで、次のように分析関連のプロパティーを定義します。 <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
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
            <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。対話モードを使用せずに実行することを選択した場合は、コマンド・ライン引数のリストも利用できます。</p>

            <ol>
                <li><b>initenv.sh – Bluemix へのログイン</b><br />
                    次のように <b>initenv.sh</b> スクリプトを実行して、IBM Containers 上で {{ site.data.keys.product }} をビルドして実行するための環境を作成します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>コマンド・ライン引数</b></td>
                                            <td><b>説明</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] BLUEMIX_USER</td>
                                            <td>Bluemix ユーザー ID または E メール・アドレス</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                            <td>Bluemix パスワード</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] BLUEMIX_ORG	</td>
                                            <td>Bluemix 組織名</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] BLUEMIX_SPACE	</td>
                                            <td>Bluemix スペース名</td>
                                        </tr>
                                        <tr>
                                            <td>オプション。[-a|--api] BLUEMIX_API_URL	</td>
                                            <td>Bluemix API エンドポイント。(デフォルトでは https://api.ng.bluemix.net)</td>
                                        </tr>
                                    </table>

                                    <p>例えば、次のとおりです。</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>セクションを閉じる</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - {{ site.data.keys.mf_server }} データベースの準備</b><br />
                    <b>prepareserverdbs.sh</b> スクリプトを使用して、dashDB データベース・サービスが含まれた {{ site.data.keys.mf_server }} を構成します。手順 1 でログインした組織およびスペースにおいて、dashDB サービスのサービス・インスタンスが使用可能になっている必要があります。次のコマンドを実行します。
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>コマンド・ライン引数</b></td>
                                            <td><b>説明</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>Bluemix dashDB™ サービス (Bluemix サービス・プラン「Enterprise Transactional」を使用)</td>
                                        </tr>
                                        <tr>
                                            <td>オプション。[-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>管理サービスのデータベース・スキーマ名。デフォルトは MFPDATA</td>
                                        </tr>
                                        <tr>
                                            <td>オプション。[-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>ランタイム・データを保管するための Bluemix データベース・サービス・インスタンス名。デフォルトは、管理データに対して指定されたものと同じサービスです。</td>
                                        </tr>
                                        <tr>
                                            <td>オプション。[-p |--push ] ENABLE_PUSH	</td>
                                            <td>プッシュ・サービス用のデータベースの構成を使用可能にします。許容値は、Y (デフォルト) または N です。</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>プッシュ・データを保管するための Bluemix データベース・サービス・インスタンス名。デフォルトは、ランタイム・データに対して指定されたものと同じサービスです。</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>プッシュ・サービスのデータベース・スキーマ名。デフォルトは、ランタイム・スキーマ名です。</td>
                                        </tr>
                                    </table>

                                    <p>例えば、次のとおりです。</p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>セクションを閉じる</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh(Optional) – Bluemix へのログイン</b><br />
                      このステップは、dashDB サービス・インスタンスが使用可能になっている組織およびスペースとは別の組織およびスペースにコンテナーを作成する必要がある場合にのみ必須です。この条件に当てはまる場合は、コンテナーを作成 (および開始) する必要のある新しい組織およびスペースの情報で initenv.properties を更新し、次のように <b>initenv.sh</b> スクリプトを再実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - {{ site.data.keys.mf_server }} イメージの準備</b><br />
                    {{ site.data.keys.mf_server }} イメージをビルドし、これを Bluemix リポジトリーにプッシュするため、<b>prepareserver.sh</b> スクリプトを実行します。Bluemix リポジトリー内にある使用可能なすべてのイメージを表示するには、次のコマンドを実行します。<code>cf ic images</code><br/>
                    リストには、イメージ名、作成日、および ID が表示されます。<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>コマンド・ライン引数</b></td>
                                            <td><b>説明</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>カスタマイズされた {{ site.data.keys.mf_server }} イメージに使用する名前。フォーマット: registryUrl/namespace/imagename</td>
                                        </tr>
                                    </table>

                                    <p>例えば、次のとおりです。</p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                  <br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>セクションを閉じる</b></a>
                                </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - IBM コンテナーでのイメージの実行</b><br />
                    <b>startserver.sh</b> スクリプトを使用して {{ site.data.keys.mf_server }} イメージを IBM コンテナー上で実行します。また、このスクリプトを実行すると、<b>SERVER_IP</b> プロパティーで構成したパブリック IP にイメージがバインドされます。次のコマンドを実行します。</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>コマンド・ライン引数</b></td>
                                        <td><b>説明</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>{{ site.data.keys.mf_server }} イメージの名前。</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>{{ site.data.keys.mf_server }} コンテナーのバインド先の IP アドレス。(使用可能なパブリック IP を指定するか、<code>cf ic ip request</code> コマンドを使用してパブリック IP を要求できます。)</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-si|--services] SERVICE_INSTANCES	</td>
                                        <td>コンテナーにバインドする、コンマ区切りの Bluemix サービス・インスタンス。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-h|--http] EXPOSE_HTTP	</td>
                                        <td>HTTP ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-s|--https] EXPOSE_HTTPS	</td>
                                        <td>HTTPS ポートの公開。許容値は、Y (デフォルト) または N です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-m|--memory] SERVER_MEM	</td>
                                        <td>コンテナーに対して、メモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-se|--ssh] SSH_ENABLE	</td>
                                        <td>コンテナーに対して SSH を有効にします。許容値は、Y (デフォルト) または N です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-sk|--sshkey] SSH_KEY	</td>
                                        <td>コンテナーに注入される SSH 鍵。(id_rsa.pub ファイルの内容を指定します。)</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-tr|--trace] TRACE_SPEC	</td>
                                        <td>適用されるトレース仕様。デフォルト: <code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                        <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                        <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-v|--volume] ENABLE_VOLUME	</td>
                                        <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                    </tr>
                                    <tr>
                                        <td>オプション。[-e|--env] MFPF_PROPERTIES	</td>
                                        <td>{{ site.data.keys.product_adj }} のプロパティーをコンマ区切りの「キー:値」ペアとして指定します。例: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>。<b>注</b>: このスクリプトを使用してプロパティーを指定する場合、同じプロパティーが usr/config フォルダー内の構成ファイルに設定されていないことを確認してください。</td>
                                    </tr>
                                </table>

                                <p>例えば、次のとおりです。</p>
{% highlight bash %}
startserver.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>セクションを閉じる</b></a>
                            </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - IBM コンテナー・グループでのイメージの実行</b><br />
                    <b>startservergroup.sh</b> スクリプトを使用して {{ site.data.keys.mf_server }} イメージを IBM コンテナー・グループ上で実行します。また、このスクリプトを実行すると、<b>SERVER_CONTAINER_GROUP_HOST</b> プロパティーで構成したホスト名にイメージがバインドされます。</li>
                    次のコマンドを実行します。
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>クリックすると、コマンド・ライン引数のリストが表示されます</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>コマンド・ライン引数</b></td>
                                                <td><b>説明</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Bluemix レジストリー内の {{ site.data.keys.mf_server }} コンテナー・イメージの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>{{ site.data.keys.mf_server }} コンテナー・グループの名前。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>ルートのホスト名。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>ルートのドメイン名。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gm|--min] SERVERS_CONTAINER_GROUP_MIN	</td>
                                                <td>コンテナー・インスタンスの最小数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gx|--max] SERVER_CONTAINER_GROUP_MAX	</td>
                                                <td>コンテナー・インスタンスの最大数。デフォルト値は 1 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED	</td>
                                                <td>コンテナー・インスタンスの希望数。デフォルト値は 2 です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-a|--auto] ENABLE_AUTORECOVERY	</td>
                                                <td>コンテナー・インスタンスの自動リカバリー・オプションを使用可能にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>

                                            <tr>
                                                <td>オプション。[-si|--services] SERVICES	</td>
                                                <td>コンテナーにバインドする、コンマ区切りの Bluemix サービス・インスタンス名。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>適用されるトレース仕様。デフォルトは <code>*=info</code> です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>上書きされるまで維持するログ・ファイルの最大数。デフォルトは 5 ファイルです。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>ログ・ファイルの最大サイズ。デフォルトのサイズは 20 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.product_adj }} のプロパティーをコンマ区切りの「キー:値」ペアとして指定します。例: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>注:</b> このスクリプトを使用してプロパティーを指定する場合、同じプロパティーが usr/config フォルダー内の構成ファイルに設定されていないことを確認してください。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-m|--memory] SERVER_MEM	</td>
                                                <td>コンテナーに対して、メモリー・サイズ制限をメガバイト (MB) 単位で割り当てます。許容値は、1024 MB (デフォルト) および 2048 MB です。</td>
                                            </tr>
                                            <tr>
                                                <td>オプション。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>コンテナー・ログ用のボリュームのマウントを有効にします。許容値は、Y または N (デフォルト) です。</td>
                                            </tr>
                                        </table>

                                        <p>例えば、次のとおりです。</p>
{% highlight bash %}
startservergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>セクションを閉じる</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **注:** 何らかの構成変更が行われた後は、コンテナーを再始動する必要があります (`cf ic restart containerId`)。コンテナー・グループの場合は、グループ内の各コンテナー・インスタンスを再始動する必要があります。例えば、ルート証明書を変更する場合、新規の証明書が追加された後で、各コンテナー・インスタンスを再始動する必要があります。

次の URL をロードして {{ site.data.keys.mf_console }} を起動します。http://MF\_CONTAINER\_HOST/mfpconsole (しばらく時間がかかる場合があります)。  
[{{ site.data.keys.mf_cli }} を使用した {{ site.data.keys.product_adj }} 成果物の管理](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)チュートリアルの指示に従って、リモート・サーバーを追加します。  

これで、IBM Bluemix で実行中の {{ site.data.keys.mf_server }} を使用して、アプリケーション開発を始めることができます。{{ site.data.keys.product }} [チュートリアルを確認してください。](../../all-tutorials)

#### ポート番号に関する制約
{: #port-number-limitation }
現在、IBM Containers には、パブリック・ドメインに使用可能なポート番号に関して制約があります。そのため、{{ site.data.keys.mf_analytics }} コンテナーと {{ site.data.keys.mf_server }} コンテナーに指定されたデフォルトのポート番号 (HTTP の場合は 9080、HTTPS の場合は 9443) を変更することはできません。コンテナー・グループ内のコンテナーは、HTTP ポート 9080 を使用する必要があります。コンテナー・グループでは、複数のポート番号および  HTTPS 要求の使用はサポートされません。


## {{ site.data.keys.mf_server }} 修正の適用
{: #applying-mobilefirst-server-fixes }

IBM Containers 上の {{ site.data.keys.mf_server }} 用の暫定修正を [IBM Fix Central](http://www.ibm.com/support/fixcentral) から取得できます。  
暫定修正を適用する前に、既存の構成ファイルのバックアップを取ってください。構成ファイルは次のフォルダー内にあります。
* {{ site.data.keys.mf_analytics }}: **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry アプリケーション: **package_root/mfpf-server/usr**
* {{ site.data.keys.mf_app_center_short }}: **package_root/mfp-appcenter/usr**

### iFix を適用するためのステップ:

1. 暫定修正アーカイブをダウンロードし、その内容を既存のインストール・フォルダーに解凍して、既存のファイルを上書きします。
2. バックアップした構成ファイルを **package_root/mfpf-analytics/usr**、**package_root/mfpf-server/usr**、および **package_root/mfp-appcenter/usr** の各フォルダーにリストアし、新規にインストールされた構成ファイルを上書きします。
3. エディターで **package_root/mfpf-server/usr/env/jvm.options** ファイルを編集して、次の行が存在する場合は削除します。
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    これで、更新したサーバーをビルドおよびデプロイできるようになりました。

    a. `prepareserver.sh` スクリプトを実行してサーバー・イメージを再ビルドし、それを IBM コンテナー・サービスにプッシュします。

    b. `startserver.sh` スクリプトを実行してサーバー・イメージをスタンドアロン・コンテナーとして実行するか、`startservergroup.sh` を実行してサーバー・イメージをコンテナー・グループとして実行します。

<!--**Note:** When applying fixes for {{ site.data.keys.mfp-appcenter }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Bluemix からのコンテナーの削除
{: #removing-a-container-from-bluemix }
Bluemix からコンテナーを削除する場合、レジストリーからイメージ名も削除する必要があります。  
次のコマンドを実行して、Bluemix からコンテナーを削除します。

1. `cf ic ps` (現在実行中のコンテナーをリストします)
2. `cf ic stop container_id` (コンテナーを停止します)
3. `cf ic rm container_id` (コンテナーを削除します)

以下の cf ic コマンドを実行して、Bluemix レジストリーからイメージ名を削除します。

1. `cf ic images` (レジストリー内のイメージをリストします)
2. `cf ic rmi image_id` (レジストリーからイメージを削除します)

## Bluemix からのデータベース・サービス構成の削除
{: #removing-the-database-service-configuration-from-bluemix }
{{ site.data.keys.mf_server }} イメージの構成時に **prepareserverdbs.sh** スクリプトを実行した場合、{{ site.data.keys.mf_server }} に必要な構成およびデータベース・テーブルが作成されます。このスクリプトは、コンテナー用のデータベース・スキーマも作成します。

Bluemix からデータベース・サービス構成を削除するには、Bluemix ダッシュボードを使用して、以下の手順を実行します。

1. Bluemix ダッシュボードから、使用した dashDB サービスを選択します。**prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定した dashDB サービス名を選択します。
2. 選択した dashDB サービス・インスタンスのスキーマおよびデータベース・オブジェクトを対処するために、dashDB コンソールを「起動」します。
3. IBM {{ site.data.keys.mf_server }} 構成に関連したスキーマを選択します。スキーマ名は、**prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定したスキーマ名です。
4. スキーマ名とその下のオブジェクトを慎重に調べた後で、それぞれのスキーマを削除します。Bluemix からデータベース構成が削除されます。

同様に、{{ site.data.keys.mf_app_center }} の構成中に **prepareappcenterdbs.sh** を実行した場合、上のステップに従って、Bluemix でデータベース・サービス構成を削除します。
