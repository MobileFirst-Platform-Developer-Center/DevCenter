---
layout: tutorial
title: Liberty for Java 用のスクリプトを使用した IBM Cloud 上での MobileFirst Server のセットアップ
breadcrumb_title: Foundation on Liberty for Java
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
下記の指示に従って、Liberty for Java ランタイム上の {{ site.data.keys.mf_server }} インスタンスを IBM Cloud 上で構成します。<!--({{ site.data.keys.mf_analytics }} instances can be run on IBM containers only.)--> これは、次のような手順で行います。

* 必要なツール (Cloud Foundry CLI) を使用してホスト・コンピューターをセットアップする
* IBM Cloud アカウントをセットアップする
* {{ site.data.keys.mf_server }} をビルドし、これを Cloud Foundry アプリケーションとして IBM Cloud にプッシュする

最後に、モバイル・アプリケーションを登録し、アダプターをデプロイします。

**注:**  

* Windows OS でのこれらのスクリプトの実行は現在サポートされていません。  
* {{ site.data.keys.mf_server }} 構成ツールは IBM Cloud へのデプロイメントには使用できません。

#### ジャンプ先:
{: #jump-to }

* [IBM Cloud でアカウントを登録する](#register-an-account-at-ibmcloud)
* [ホスト・マシンをセットアップする](#set-up-your-host-machine)
* [{{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする](#download-the-ibm-mfpf-container-8000-archive)
* [分析サーバー情報の追加](#adding-analytics-server-configuration-to-mobilefirst-server)
* [{{ site.data.keys.mf_server }} 修正の適用](#applying-mobilefirst-server-fixes)
* [IBM Cloud からのデータベース・サービス構成の削除](#removing-the-database-service-configuration-from-ibmcloud)

## IBM Cloud でアカウントを登録する
{: #register-an-account-at-ibmcloud }
まだアカウントをお持ちでない場合は、[IBM Cloud Web サイト](https://bluemix.net)にアクセスし、**「無料で開始」**、または**「登録」**をクリックします。 次のステップに進むため、登録フォームに記入する必要があります。

### IBM Cloud ダッシュボード
{: #the-ibmcloud-dashboard }
IBM Cloud にサインインすると IBM Cloud ダッシュボードが表示され、アクティブな IBM Cloud **スペース**の概略が示されます。 デフォルトでは、この作業領域の名前は「dev」です。 必要に応じて、複数の作業領域/スペースを作成できます。

## ホスト・マシンをセットアップする
{: #set-up-your-host-machine }
IBM Cloud Cloud Foundry アプリケーションを管理するには、Cloud Foundry CLI をインストールする必要があります。  
macOS の Terminal.app または Linux の Bash シェルを使用してスクリプトを実行できます。

[Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195) をインストールします。

## {{ site.data.keys.mf_bm_pkg_name }} アーカイブをダウンロードする
{: #download-the-ibm-mfpf-container-8000-archive}
Liberty for Java 上で {{ site.data.keys.product }} をセットアップするには、まず最初にファイル・レイアウトを作成する必要があります。このファイル・レイアウトは、のちほど IBM Cloud にプッシュします。  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">このページの指示に従って</a>、{{ site.data.keys.mf_server }} 8.0 の IBM Containers 用アーカイブ (.zip ファイル。*CNBL0EN* で検索) をダウンロードしてください。

このアーカイブ・ファイルには、ファイル・レイアウトをビルドするためのファイル (**dependencies** と **mfpf-libs**)、{{ site.data.keys.mf_analytics }} コンテナーをビルドしてデプロイするためのファイル (**mfpf-analytics**)、および {{ site.data.keys.mf_server }} Cloud Foundry アプリケーションを構成するためのファイル (**mfpf-server-libertyapp**) が含まれています。

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>クリックすると、アーカイブ・ファイルの内容について、詳細情報が表示されます</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="アーカイブ・ファイルのファイル・システム構成を示すイメージ" style="float:right;width:570px"/>
                <h4>dependencies フォルダー</h4>
                <p>{{ site.data.keys.product }} ランタイムおよび IBM Java JRE 8 が含まれています。</p>

                <h4>mfpf-libs フォルダー</h4>
                <p>{{ site.data.keys.product_adj }} 製品コンポーネント・ライブラリーおよび CLI が含まれています。</p>

                <h4>mfpf-server-libertyapp フォルダー</h4>

                <ul>

                    <li><b>scripts</b> フォルダー: このフォルダーには、<b>args</b> フォルダー (構成ファイルのセットを含む) が含まれます。 また、IBM Cloud へのログイン、IBM Cloud にプッシュするための {{ site.data.keys.product }} アプリケーションのビルド、IBM Cloud 上でのサーバーの実行を行うための各スクリプトも含まれています。 スクリプトは、対話式に実行することも、(後述のように) 構成ファイルを事前に設定することで実行することもできます。 カスタマイズ可能な args/*.properties ファイル以外、このフォルダー内のエレメントを変更しないでください。 スクリプトの使用法に関するヘルプを表示するには、<code>-h</code> または <code>--help</code> コマンド・ライン引数を使用します (例: <code>scriptname.sh --help</code>)。</li>
                    <li><b>usr</b> フォルダー:
                        <ul>
                            <li><b>config</b> フォルダー: {{ site.data.keys.mf_server }} によって使用されるサーバー構成フラグメント (鍵ストア、サーバー・プロパティー、ユーザー・レジストリー) が含まれます。</li>
                            <li><b>keystore.xml</b> - SSL 暗号化に使用されるセキュリティー証明書のリポジトリーの構成が含まれています。 リストされたファイルは、./usr/security フォルダー内で参照される必要があります。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }}の構成プロパティー。 以下の資料トピックにリストされた、サポートされるプロパティーを参照してください。
                                <ul>
                                <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - ユーザー・レジストリー構成。 basicRegistry (基本の XML ベースのユーザー・レジストリー構成がデフォルトとして提供されています。 basicRegistry 用にユーザー名とパスワードを構成できます。または ldapRegistry を構成することができます。</li>
                        </ul>
                    </li>
                    <li><b>env</b> フォルダー: サーバーの初期化に使用される環境プロパティー (server.env) およびカスタム JVM オプション (jvm.options) が含まれています。
                    <br/>
                    </li>

                    <li><b>security</b> フォルダー: 鍵ストア、トラストストア、および LTPA 鍵ファイル (ltpa.keys) の保管場所として使用します。</li>

                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>


## {{ site.data.keys.mf_server }} および {{ site.data.keys.mf_app_center }} のセットアップ
{: #setting-up-the-mobilefirst-server }
スクリプトは、対話式に実行することも、構成ファイルを使用して実行することもできます。
推奨されるのは、開始時に一度スクリプトを対話式に実行することです。これによって引数も記録されます (**recorded-args**)。 その後、args ファイルを使用して非対話式でスクリプトを実行できます。

> **注:** パスワードは記録されません。パスワードは、引数ファイルに手動で追加する必要があります。

* 構成ファイルを使用する場合: スクリプトを実行し、個々の構成ファイルを引数として渡します。
* 対話式の場合: 引数を付けずにスクリプトを実行します。

スクリプトを対話式に実行する場合は、この構成をスキップしてかまいませんが、少なくとも、指定することになる引数について一読し、理解しておくことを、強くお勧めします。


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }

>**注:** インストーラーと DB ツールは、オンプレミスの {{ site.data.keys.mf_app_center }} インストール・フォルダー (`installer` フォルダーと `tools` フォルダー) からダウンロードできます。

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-1" aria-expanded="false" aria-controls="collapse-step-appcenter-1">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。 空のテンプレート・ファイルや引数の説明は、<b>args</b> フォルダーにあります。また、対話式のスクリプト実行の後は <b>recorded-args</b> フォルダーにあります。 以下のファイルがあります。<br/>

              <h4>initenv.properties</h4>
              このファイルには、環境の初期化を実行するときに使用するプロパティーが含まれています。
              <h4>prepareappcenterdbs.properties</h4>
              {{ site.data.keys.mf_app_center }} には、外部 <a href="https://console.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB Enterprise Transactional データベース・インスタンス</a> (OLTP または Transactional のマークが付いた任意のプラン) が必要です。<br/>
              <b>注:</b> dashDB Enterprise Transactional プランのデプロイメントは、「従量制課金」のマークが付いたプランに対しては即時に行われます。 <i>Enterprise for Transactions High Availability 2.8.500 (従量課金)</i> のような、適したプランを選択するようにしてください。 <br/><br/>
              dashDB インスタンスのセットアップが完了したら、必要な引数を入力します。

              <h4>prepareappcenter.properties</h4>
              このファイルは prepareappcenter.sh スクリプトに使用されます。 このファイルは {{ site.data.keys.mf_app_center_short }} ファイル・レイアウトを準備し、これを IBM Cloud に Cloud Foundry アプリケーションとしてプッシュします。
              <h4>startappcenter.properties</h4>
              このファイルは、サーバーのランタイム属性を構成し、これを開始します。 最小でも 1024 MB (<b>SERVER_MEM=1024</b>) と 3 つのノードを使用して高可用性を確保 (<b>INSTANCES=3</b>) することを強く推奨します。

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-appcenter-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-2" aria-expanded="false" aria-controls="collapse-step-appcenter-2">スクリプトの実行</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。 対話モードを使用せずに実行することを選択した場合は、コマンド・ライン引数のリストも利用できます。</p>
              <ol>
                  <li><b>initenv.sh – IBM Cloud へのログイン</b><br />
                      <b>initenv.sh</b> スクリプトを実行して IBM Cloud にログインします。 dashDB サービスがバインドされている組織およびスペースに対して、次のコマンドを実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
initenv.sh --user IBM_Cloud_user_ID --password IBM_Cloud_password --org IBM_Cloud_organization_name --space IBM_Cloud_space_name
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenterdbs.sh - {{ site.data.keys.mf_app_center }} データベースの準備</b><br />
                  <b>prepareappcenterdbs.sh</b> スクリプトを使用して、dashDB データベース・サービスまたはアクセス可能な DB2 データベース・サーバーが含まれた {{ site.data.keys.mf_app_center }} を構成します。 DB2 オプションは、DB2 サーバーがインストールされているデータ・センターと同じデータ・センターで IBM Cloud をローカルに実行する場合に、特に有用です。 dashDB サービスを使用する場合、手順 1 でログインした組織およびスペースにおいて、dashDB サービスのサービス・インスタンスが使用可能である必要があります。次のコマンドを実行します。
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
prepareappcenterdbs.sh --acdb MFPAppCenterDashDBService
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./prepareappcenterdbs.sh --help
{% endhighlight %}

                  </li>
                  <li><b>initenv.sh(Optional) – IBM Cloud へのログイン</b><br />
                      このステップは、dashDB サービス・インスタンスが使用可能になっている組織およびスペースとは別の組織およびスペースにサーバーを作成する必要がある場合にのみ必須です。 この条件に当てはまる場合は、コンテナーを作成 (および開始) する必要のある新しい組織およびスペースの情報で initenv.properties を更新し、次のように <b>initenv.sh</b> スクリプトを再実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenter.sh - {{ site.data.keys.mf_app_center }}</b> の準備<br />
                    {{ site.data.keys.mf_app_center }} をビルドし、これを IBM Cloud に Cloud Foundry アプリケーションとしてプッシュするため、<b>prepareappcenter.sh</b> スクリプトを実行します。 ログインした組織およびスペース内にあるすべての Cloud Foundry アプリケーションとその URL を表示するには、<code>cf apps</code> を実行します。<br/>


{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
prepareappcenter.sh --name APP_NAME
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./prepareappcenter.sh --help
{% endhighlight %}                  

                  </li>
                  <li><b>startappcenter.sh - {{ site.data.keys.mf_app_center }}</b> の始動<br />
                  <b>startappcenter.sh</b> スクリプトを使用して、Liberty for Java Cloud Foundry アプリケーション上で {{ site.data.keys.mf_app_center }} を始動します。 次のコマンドを実行します。<p/>
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
./startappcenter.sh --name APP_NAME
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./startappcenter.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>
次の URL をロードして、{{ site.data.keys.mf_app_center }} コンソールを起動します。`http://APP_HOST.mybluemix.net/appcenterconsole` (しばらく時間がかかる場合があります)。   

これで、IBM Cloud で実行中の {{ site.data.keys.mf_app_center }} を使用して、モバイル・アプリケーションを Application Center にアップロードできます。


### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
<div class="panel-group accordion" id="scripts2-mf" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1-mf">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-1-mf" aria-expanded="false" aria-controls="collapse-step-foundation-1-mf">構成ファイルの使用</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1-mf" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <b>args</b> フォルダーに、構成ファイルのセットが含まれています。スクリプトの実行に必要な引数は、これらの構成ファイルに含まれています。 空のテンプレート・ファイルや引数の説明は、<b>args</b> フォルダーにあります。また、対話式のスクリプト実行の後は <b>recorded-args</b> フォルダーにあります。 以下のファイルがあります。<br/>

              <h4>initenv.properties</h4>
              このファイルには、環境の初期化を実行するときに使用するプロパティーが含まれています。
              <h4>prepareserverdbs.properties</h4>
              {{ site.data.keys.mf_bm_short }} サービスには、外部 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB Enterprise Transactional データベース・ インスタンス</a> (OLTP または Transactional のマークが付いていればどのプランでも可) が必要です。<br/>
              <b>注:</b> dashDB Enterprise Transactional プランのデプロイメントは、「従量制課金」のマークが付いたプランに対しては即時に行われます。 <i>Enterprise for Transactions High Availability 2.8.500 (従量課金)</i> のような、適したプランを選択するようにしてください。 <br/><br/>
              dashDB インスタンスのセットアップが完了したら、必要な引数を入力します。

              <h4>prepareserver.properties</h4>
              このファイルは prepareserver.sh スクリプトで使用します。 このファイルは、サーバー・ファイル・レイアウトを準備し、これを IBM Cloud に Cloud Foundry アプリケーションとしてプッシュします。
              <h4>startserver.properties</h4>
              このファイルは、サーバーのランタイム属性を構成し、これを開始します。 最小でも 1024 MB (<b>SERVER_MEM=1024</b>) と 3 つのノードを使用して高可用性を確保 (<b>INSTANCES=3</b>) することを強く推奨します。

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">スクリプトの実行</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>以下の説明は、構成ファイルを使用してスクリプトを実行する方法を示しています。 対話モードを使用せずに実行することを選択した場合は、コマンド・ライン引数のリストも利用できます。</p>
              <ol>
                  <li><b>initenv.sh – IBM Cloud へのログイン</b><br />
                      <b>initenv.sh</b> スクリプトを実行して IBM Cloud にログインします。 dashDB サービスがバインドされている組織およびスペースに対して、次のコマンドを実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
initenv.sh --user IBM_Cloud_user_ID --password IBM_Cloud_password --org IBM_Cloud_organization_name --space IBM_Cloud_space_name
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareserverdbs.sh - {{ site.data.keys.mf_server }} データベースの準備</b><br />
                  <b>prepareserverdbs.sh</b> スクリプトを使用して、dashDB データベース・サービスまたはアクセス可能な DB2 データベース・サーバーが含まれた {{ site.data.keys.mf_server }} を構成します。 DB2 オプションは、DB2 サーバーがインストールされているデータ・センターと同じデータ・センターで IBM Cloud をローカルに実行する場合に、特に有用です。 dashDB サービスを使用する場合、手順 1 でログインした組織およびスペースにおいて、dashDB サービスのサービス・インスタンスが使用可能である必要があります。次のコマンドを実行します。
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./prepareserverdbs.sh --help
{% endhighlight %}

                  </li>
                  <li><b>initenv.sh(Optional) – IBM Cloud へのログイン</b><br />
                      このステップは、dashDB サービス・インスタンスが使用可能になっている組織およびスペースとは別の組織およびスペースにサーバーを作成する必要がある場合にのみ必須です。 この条件に当てはまる場合は、コンテナーを作成 (および開始) する必要のある新しい組織およびスペースの情報で initenv.properties を更新し、次のように <b>initenv.sh</b> スクリプトを再実行します。
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareserver.sh - {{ site.data.keys.mf_server }} の準備</b><br />
                    {{ site.data.keys.mf_server }} をビルドし、これを IBM Cloud に Cloud Foundry アプリケーションとしてプッシュするため、<b>prepareserver.sh</b> スクリプトを実行します。 ログインした組織およびスペース内にあるすべての Cloud Foundry アプリケーションとその URL を表示するには、<code>cf apps</code> を実行します。<br/>


{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
prepareserver.sh --name APP_NAME
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./prepareserver.sh --help
{% endhighlight %}                  

                  </li>
                  <li><b>startserver.sh - サーバーの始動</b><br />
                  <b>startserver.sh</b> スクリプトを使用して {{ site.data.keys.mf_server }} を Liberty for Java の Cloud Foundry アプリケーション上で始動します。 次のコマンドを実行します。<p/>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                        コマンド・ラインでパラメーターを渡すこともできます。

{% highlight bash %}
./startserver.sh --name APP_NAME
{% endhighlight %}

                        サポートされているすべてのパラメーターとその説明を見るには、help オプションを実行します。

{% highlight bash %}
./startserver.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>


次の URL をロードして {{ site.data.keys.mf_console }} を起動します。`http://APP_HOST.mybluemix.net/mfpconsole` (しばらく時間がかかる場合があります)。  
[{{ site.data.keys.mf_cli }} を使用した {{ site.data.keys.product_adj }} 成果物の管理](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)チュートリアルの指示に従って、リモート・サーバーを追加します。  

これで、IBM Cloud で実行中の {{ site.data.keys.mf_server }} を使用して、アプリケーション開発を始めることができます。

#### 変更の適用
{: #applying-changes }
一度サーバーをデプロイした後で、サーバー・レイアウトに変更を適用する必要がある場合があります。例えば、**/usr/config/mfpfproperties.xml** 内の分析 URL を更新するような場合です。 変更を行った後、同じ引数のセットを指定して、次のスクリプトを再実行します。

1. ./prepareserver.sh
2. ./startserver.sh

### {{ site.data.keys.mf_server }} への分析サーバー構成の追加
{: #adding-analytics-server-configuration-to-mobilefirst-server }
分析サーバーをセットアップ済みで、それをこの {{ site.data.keys.mf_server }} に接続する場合は、 **package_root/mfpf-server-libertyapp/usr/config** フォルダー内の **mfpfproperties.xml** ファイルを、以下に示すとおりに編集します。 `<>` のマークがついたトークンを、デプロイメントからの正しい値で置き換えます。

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value='"https://<AnalyticsContainerPublicRoute>:443/analytics/console"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.username" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.password" value='"<AnalyticsPassword>"'/>


<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.endpoint" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.services.ext.analytics" value="com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.user" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.password" value='"<AnalyticsPassword>"'/>
```

## {{ site.data.keys.mf_server }} 修正の適用
{: #applying-mobilefirst-server-fixes }

IBM Cloud 上の {{ site.data.keys.mf_server }} 用の暫定修正を [IBM Fix Central](http://www.ibm.com/support/fixcentral) から取得できます。  
暫定修正を適用する前に、既存の構成ファイルのバックアップを取ってください。 構成ファイルは
次のフォルダー内にあります。
* {{ site.data.keys.mf_analytics }}:  **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry アプリケーション: **package_root/mfpf-server-libertyapp/usr**
* {{ site.data.keys.mf_app_center_short }}:  **package_root/mfp-appcenter-libertyapp/usr**

### iFix を適用するためのステップ:

1. 暫定修正アーカイブをダウンロードし、その内容を既存のインストール・フォルダーに解凍して、既存のファイルを上書きします。
2. バックアップした構成ファイルを **package_root/mfpf-analytics/usr**、**package_root/mfpf-server-libertyapp/usr**、および **package_root/mfp-appcenter-libertyapp/usr** の各フォルダーにリストアし、新規にインストールされた構成ファイルを上書きします。
3. エディターで **package_root/mfpf-server/usr/env/jvm.options** ファイルを編集して、次の行が存在する場合は削除します。
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar
```
    これで、更新したサーバーをビルドおよびデプロイできるようになりました。 同じ引数のセットを指定して、次のスクリプトを再実行します。

    a. `./prepareserver.sh`: 更新した成果物を IBM Cloud にアップロードします。

    b. `./startserver.sh`: 更新したサーバーを始動します。

    前のデプロイメントで使用した引数のコピーは `recorded-args/` ディレクトリーに保存されています。 これらのプロパティーをデプロイメントに使用できます。

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## IBM Cloud からのデータベース・サービス構成の削除
{: #removing-the-database-service-configuration-from-ibmcloud }
{{ site.data.keys.mf_server }} イメージの構成時に **prepareserverdbs.sh** スクリプトを実行した場合、{{ site.data.keys.mf_server }} に必要な構成およびデータベース・テーブルが作成されます。 このスクリプトは、{{ site.data.keys.mf_server }}用のデータベース・スキーマも作成します。

IBM Cloud からデータベース・サービス構成を削除するには、IBM Cloud ダッシュボードを使用して、以下の手順を実行します。

1. IBM Cloud ダッシュボードから、使用した dashDB サービスを選択します。 **prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定した dashDB サービス名を選択します。
2. 選択した dashDB サービス・インスタンスのスキーマおよびデータベース・オブジェクトを対処するために、dashDB コンソールを「起動」します。
3. IBM {{ site.data.keys.mf_server }} 構成に関連したスキーマを選択します。 スキーマ名は、**prepareserverdbs.sh** スクリプトの実行時にパラメーターとして指定したスキーマ名です。
4. スキーマ名とその下のオブジェクトを慎重に調べた後で、それぞれのスキーマを削除します。 IBM Cloud からデータベース構成が削除されます。

同様に、{{ site.data.keys.mf_app_center }} の構成中に **prepareappcenterdbs.sh** を実行した場合、上のステップに従って、IBM Cloud でデータベース・サービス構成を削除します。
