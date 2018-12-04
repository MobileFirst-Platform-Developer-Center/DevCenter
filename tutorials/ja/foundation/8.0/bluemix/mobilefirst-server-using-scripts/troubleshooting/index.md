---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Troubleshooting
#relevantTo: [ios,android,windows,javascript]
#weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### IBM Containers 上の {{ site.data.keys.product_full }} に関する問題の解決
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
IBM Containers 上の {{ site.data.keys.product_full }} で作業中に検出された問題を解決できない場合、IBM サポートに連絡する前に、必ず以下の主要な情報を収集してください。

トラブルシューティングの処理を迅速に進めるために、以下の情報を収集してください。

* 使用している {{ site.data.keys.product }} のバージョン (V8.0.0 以降が必要) および適用された暫定修正。
* 選択されたコンテナー・サイズ。 例えば、Medium 2GB。
* IBM Cloud dashDB データベース・プランのタイプ。 例えば、EnterpriseTransactional 2.8.50 です。
* コンテナー ID
* パブリック IP アドレス (割り当てられている場合)
* Docker と Cloud Foundry のバージョン: `cf -v` and `docker version`
* 以下の IBM Containers 用 Cloud Foundry CLI プラグイン (cf ic) コマンドの実行時に、{{ site.data.keys.product }} コンテナーがデプロイされている組織およびスペースから返された情報。
 - `cf ic info`
 - `cf ic ps -a` (複数のコンテナー・インスタンスがリストされている場合は、必ず問題のあるコンテナー・インスタンスを示してください。)
* コンテナーの作成時 (**startserver.sh** スクリプトの実行中) にセキュア・シェル (SSH) およびボリュームが有効にされた場合、以下のフォルダー内のすべてのファイルを収集します。 /opt/ibm/wlp/usr/servers/mfp/logs and /var/log/rsyslog/syslog
* ボリュームのみが有効にされ、SSH は有効にされなかった場合は、IBM Cloud ダッシュボードを使用して、入手できるログ情報を収集します。 IBM Cloud ダッシュボードでコンテナー・インスタンスをクリックした後、サイドバーにある「モニタリングおよびログ」リンクをクリックします。 「ロギング」タブに移動して、「詳細ビュー」をクリックします。 Kibana ダッシュボードが別個に開きます。 検索ツールバーを使用して、例外スタック・トレースを検索し、例外の詳細 @time-stamp, _id を収集します。

### スクリプトの実行中の Docker 関連エラー
{: #docker-related-error-while-running-script }
initenv.sh スクリプトまたは  prepareserver.sh スクリプトの実行後に Docker 関連のエラーを検出した場合、Docker サービスを再始動してみてください。

**メッセージの例**

> Pulling repository docker.io/library/ubuntu  
> Error while pulling image: Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS message ID mismatch

**説明**  
このエラーは、インターネット接続が変更されていて (VPN への接続、または VPN からの切断、あるいはネットワーク構成の変更など)、Docker ランタイム環境がまだ再始動されていない場合に発生する可能性があります。 このシナリオでは、いずれかの Docker コマンドが発行されると、エラーが発生します。

**解決方法**  
Docker サービスを再始動します。 エラーが続く場合は、コンピューターをリブートしてから、Docker サービスを再始動してください。

### IBM Cloud レジストリー・エラー
{: #bluemix-registry-error }
prepareserver.sh スクリプトまたは  prepareanalytics.sh スクリプトの実行後にレジストリー関連のエラーが検出された場合は、最初に initenv.sh スクリプトを実行してみてください。

**説明**  
一般に、prepareserver.sh スクリプトまたは  prepareanalytics.sh スクリプトの実行中に何らかのネットワーク問題が発生すると、処理が停止して、失敗する可能性があります。

**解決方法**  
最初に、initenv.sh スクリプトを実行し直して IBM Cloud 上のコンテナー・レジストリーにログインします。 次に、前に失敗したスクリプトを再実行します。

### mfpfsqldb.xml ファイルを作成できない
{: #unable-to-create-the-mfpfsqldbxml-file }
**prepareserverdbs.sh** スクリプトの実行の終わりに、次のエラーが発生します。

> Error : unable to create mfpfsqldb.xml

**解決方法**  
この問題は、偶発的なデータベース接続問題である可能性があります。 スクリプトをもう一度実行してみてください。

### イメージをプッシュするのに長い時間がかかる
{: #taking-a-long-time-to-push-image }
prepareserver.sh スクリプトを実行しているとき、イメージを IBM Containers レジストリーにプッシュするのに 20 分より長い時間がかかります。

**説明**  
**prepareserver.sh** スクリプトは {{ site.data.keys.product }} スタック全体をプッシュするため、20 分から 60 分かかる可能性があります。

**解決方法**  
60 分の時間枠が経過してもスクリプトが完了していない場合は、接続問題が原因でプロセスが停止している可能性があります。 安定した接続が再確立されたら、スクリプトを再始動してください。

### バインディングが未完了エラー
{: #binding-is-incomplete-error }
コンテナーを開始するためのスクリプト (**startserver.sh** または **startanalytics.sh** など) の実行時に、バインディングが未完了であるというエラーにより、手動で IP アドレスをバインドするよう求めるプロンプトが出されます。

**説明**  
このスクリプトは、特定の時間間隔が経過した後に終了するように設計されています。

**解決方法**  
関連の cf ic コマンドを実行して、手動で IP アドレスをバインドします。 例: cf ic ip bind。

手動での IP アドレスのバインドが正常に行われない場合は、コンテナーの状況が「実行中」であることを確認して、バインディングを再試行してください。  
**注:** バインドを正常に行うためには、コンテナーが実行中状態でなければなりません。

### スクリプトが失敗し、トークンに関するメッセージを返す
{: #script-fails-and-returns-message-about-tokens }
スクリプトの実行が成功せず、Refreshing cf tokens または Failed to refresh token に類似したメッセージを返します。

**説明**  
IBM Cloud セッションがタイムアウトになった可能性があります。 ユーザーは、コンテナー・スクリプトを実行する前に、IBM Cloud にログインする必要があります。

**解決方法**
initenv.sh スクリプトを再実行して IBM Cloud にログインし、失敗したスクリプトを再実行してください。

### 管理 DB、ライブ・アップデート、およびプッシュ・サービスが非アクティブとして表示される
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
**prepareserver.sh** スクリプトが正常に完了しても、「管理 DB」、「ライブ・アップデート」、および「プッシュ・サービス」が非アクティブとして表示されるか、{{ site.data.keys.mf_console }} にランタイムがリストされません。

**説明**  
データベース・サービスへの接続が確立されなかったか、デプロイメント中に値が追加されたときに、server.env ファイルでフォーマット設定の問題が発生した可能性があります。

追加の値が、改行文字なしで server.env ファイルに追加された場合、プロパティーは解決されません。 この問題の可能性については、未解決のプロパティーが原因で発生したエラーがないかログ・ファイルをチェックすることによって確認できます。エラーは、次のようなものです。

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**解決方法**  
手動でコンテナーを再始動します。 それでも問題が解決されない場合は、データベース・サービスへの接続数が、データベース計画によってプロビジョンされた接続数を超えていないかどうか確認してください。 超えている場合は、続行する前に、必要な調整を実行してください。

問題の原因が未解決のプロパティーだった場合は、提供されたファイルを編集しているときに、行の終わりを区別するために、エディターが確実に改行 (LF) 文字を追加するようにしてください。 例えば、macOS の TextEdit アプリは、行の終わりのマークを付けるために、LF 文字の代わりに CR 文字を使用する場合があり、それによりこの問題が発生することになります。

### prepareserver.sh スクリプトが失敗する
{: #prepareserversh-script-fails }
**prepareserver.sh** スクリプトが失敗し、エラー 405 Method Not Allowed が返されます。

**説明**  
イメージを IBM Containers レジストリーにプッシュするために **prepareserver.sh** スクリプトを実行しているときに、以下のエラーが発生します。

> Pushing the {{ site.data.keys.mf_server }} image to the IBM Containers registry..  
> Error response from daemon:  
> 405 Method Not Allowed  
> Method Not Allowed  
> The method is not allowed for the requested URL.

このエラーは通常、ホスト環境で Docker 変数が変更された場合に発生します。 initenv.sh スクリプトの実行後に、ツールにより、ネイティブ Docker コマンドを使用して IBM Containers に接続するローカル Docker 環境をオーバーライドするためのオプションが提供されます。

**解決方法**  
Docker 変数 (DOCKER\_HOST や DOCKER\_CERT\_PATH など) を、IBM Containers レジストリー環境を指すように変更することはしないでください。 **prepareserver.sh** スクリプトが正常に機能するためには、Docker 変数がローカル Docker 環境を指している必要があります。
