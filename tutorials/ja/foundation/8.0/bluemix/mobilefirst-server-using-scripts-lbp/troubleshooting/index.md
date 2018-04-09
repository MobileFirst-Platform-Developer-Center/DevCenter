---
layout: tutorial
title: トラブルシューティング
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Liberty for Java ランタイム上の {{ site.data.keys.product_full }} に関する問題の解決
{: resolving-problems-with-ibm-mobilefirst-foundation-on-liberty-for-java-runtime }
Liberty for Java ランタイム上の IBM MobileFirst Foundation で作業中に検出された問題を解決できない場合、IBM サポートに連絡する前に、必ず以下の主要な情報を収集してください。

トラブルシューティングの処理を迅速に進めるために、以下の情報を収集してください。

* 使用している IBM MobileFirst Foundation のバージョン (V8.0.0 以降が必要) および適用された暫定修正。
* 選択した Liberty for Java ランタイムのサイズ。 例えば、2GB。
* IBM Cloud dashDB データベース・プランのタイプ。 例えば、EnterpriseTransactional 2.8.500。
* mfpconsole ルート
* Cloud Foundry のバージョン: `cf -v`
* 以下の  Cloud Foundry CLI コマンドの実行時に、MobileFirst Foundation サーバーがデプロイされている組織およびスペースから返された情報。
 - `cf app APP_NAME`

### mfpfsqldb.xml ファイルを作成できない
{: #unable-to-create-the-mfpfsqldbxml-file }
**prepareserverdbs.sh** スクリプトの実行の終わりに、次のエラーが発生します。

> Error : unable to create mfpfsqldb.xml

**解決方法**  
この問題は、偶発的なデータベース接続問題である可能性があります。 スクリプトをもう一度実行してみてください。

### スクリプトが失敗し、トークンに関するメッセージを返す	
{: #script-fails-and-returns-message-about-tokens }
スクリプトの実行が成功せず、Refreshing cf tokens または Failed to refresh token に類似したメッセージを返します。

**説明**  
IBM Cloud セッションがタイムアウトになった可能性があります。 ユーザーは、スクリプトを実行する前に、IBM Cloud にログインする必要があります。

**解決方法**
initenv.sh スクリプトを再実行して IBM Cloud にログインし、失敗したスクリプトを再実行してください。

### 管理 DB、ライブ・アップデート、およびプッシュ・サービスが非アクティブとして表示される
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
**prepareserver.sh** スクリプトが正常に完了しても、「管理 DB」、「ライブ・アップデート」、および「プッシュ・サービス」が非アクティブとして表示されるか、MobileFirst Foundation Operations Console にランタイムがリストされません。

**説明**  
データベース・サービスへの接続が確立されなかったか、デプロイメント中に値が追加されたときに、server.env ファイルでフォーマット設定の問題が発生した可能性があります。

追加の値が、改行文字なしで server.env ファイルに追加された場合、プロパティーは解決されません。 この問題の可能性については、未解決のプロパティーが原因で発生したエラーがないかログ・ファイルをチェックすることによって確認できます。エラーは、次のようなものです。

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**解決方法**  
手動で Liberty アプリケーションを再始動します。 それでも問題が解決されない場合は、データベース・サービスへの接続数が、データベース計画によってプロビジョンされた接続数を超えていないかどうか確認してください。 超えている場合は、続行する前に、必要な調整を実行してください。

問題の原因が未解決のプロパティーだった場合は、提供されたファイルを編集しているときに、行の終わりを区別するために、エディターが確実に改行 (LF) 文字を追加するようにしてください。 例えば、macOS の TextEdit アプリは、行の終わりのマークを付けるために、LF 文字の代わりに CR 文字を使用する場合があり、それによりこの問題が発生することになります。
