---
layout: tutorial
title: MobileFirst Analytics 実動クラスターのセットアップのベスト・プラクティス
breadcrumb_title: Best Practices
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

このトピックでは、実動での Analytics サーバーのセットアップ時に従う必要のある、するべきこと、してはならないことなど、一連のベスト・プラクティスを示します。


## {{ site.data.keys.mf_analytics_server }} - 構成設定
{: #mfp-analytics-config }

文書セットの最初からのすべてを永続的に保持しないようにするため、実稼働環境にはデータ・パージの適用が必須です。さまざまなイベント文書に対して適切な TTL 値を設定することによって、Elasticsearch 照会の検索スコープをかなり小さくすることができます。
MobileFirst Analytics v8.0 Server に対して設定される TTL 値は次のとおりです。

**分析イベント/文書に対する TTL プロパティー**

* TTL_PushNotification
*  TTL_PushSubscriptionSummarizedHourly
*  TTL_ServerLog
*  TTL_AppLog 
* TTL_NetworkTransaction 
* TTL_AppSession
*  TTL_AppSessionSummarizedHourly
*  TTL_NetworkTransactionSummarizedHourly 
* TTL_CustomData
* TTL_AppPushAction
*  TTL_AppPushActionSummarizedHourly
*  TTL_PushSubscription

**使用例:**
```xml
<jndiEntry jndiName="analytics/TTL_AppLog" value= '"20d"' />
```

> TTL 値はストリング・リテラルと予期されていて、単一引用符で囲んで渡す必要があります。

## {{ site.data.keys.mf_analytics_server }} - トポロジー
{: #mfp-analytics-topology }

マルチノードの分析クラスター
*	ノードの前面にロード・バランサーを置いて、分析層のノード間で負荷が均等に配分されるようにすることが重要です。
*	2 つのノードがある分析クラスターでロード・バランサーが使用されない場合は、MobileFirst Server からのデータの受け入れに使用されないノードの Analytics コンソールを構成または使用することをお勧めします。

**以下に例を示します。**

分析サーバー用に 2 つのノードがあるとします。
そういった場合、分析用の MobileFirst サーバー構成の推奨は次のようになります。

**推奨:**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node2:9080/analytic/console*

**非推奨:**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node1:9080/analytic/console*

これにより、ユーザーは Analytics コンソールを表示するときにノードへの負荷を減らすことができます。

## {{ site.data.keys.mf_analytics_server }} - パフォーマンスのチューニング
{: #mfp-analytics-perf-tuning }

### オペレーティング・システムのチューニング
{: #os-tuning }

* 許容されるオープン・ファイル記述子の数を 32 k または 64 k に増やします。
* 仮想メモリー・マップ数を増やします。

>**注:** オペレーティング・システムの対応する文書を確認してください。

### アプリケーション・サーバーのチューニング
{: #app-server-tuning }

WebSphere Application Server v8.5.5.6 Liberty Profile またはそれより前のバージョンを使用している場合、JVM スレッド・プールのサイズ設定を明示的に調整してください。

この動作の結果、多くのユーザーでは、executor が決してデッドロックにならないことを確実にするため、 executor の **coreThreads** 値が大きい数に設定されています。しかし、v8.5.5.6 で自動チューニングのアルゴリズムが変更され、積極的にデッドロックに対処するようになりました。現在は、executor がデッドロックになることはほとんどありません。したがって、executor のデッドロックを回避するために過去に **coreThreads** を手動で設定した場合、v8.5.5.6 に移行した時点でデフォルト値に戻すことを検討してください。

**例:**

```xml
<executor name="LargeThreadPool" id="default"  coreThreads="200" maxThreads="400" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```     

### Analytics のチューニング
{: #analytics-tuning }

* Java **Xms** と **Xmx** の両方 (最小および最大) に同じ値が設定される必要があります。
* JVM 当たりの許容される最大ヒープ・サイズ <= RAM サイズ/2。
* プライマリー・シャードの数 = 分析クラスターのノード数。
* シャード当たりのレプリカ数 >= 2。

> **注:** ノードが 1 つのみの場合、レプリカの必要はありません。

### Elasticsearch のチューニング
{: #es-tuning }

Elasticsearch のチューニングは、別個の YAML ファイル (例えば、`elasticsearchconfig.yml` のような名前にすることができます) で実行でき、このファイルへのパスを分析サーバー構成内に (JNDI プロパティーを使用して) 構成できます。

**プロパティー名:**  *analytics/settingspath*<br/>
**値:** *\<path_to_the_ES_config_yml\>*

Elasticsearch チューニング・パラメーターを適用するには、それらの値を `.yml` ファイルに追加し、JNDI 項目を使用してアクセスします。

Elasticsearch チューニング・パラメーターには環境の基本的なチューニングが考慮され、インフラストラクチャー・リソースに基づいてさらに調整できます。

1. **indices.fielddata.cache.size** の値を設定します。

   以下に例を示します。
   ```
   indices.fielddata.cache.size:  35%
   ```  

   >**注:** **analytics/indices.fielddata.cache.size** は注意して使用してください。
   >この値を増やすとメモリー不足が起こる可能性があるため、大きい値に増やさないでください。Analytics プラットフォームの基礎にあるテクノロジーでは、文書へのアクセスをより早くするためにいくつかのフィールド値がメモリーにロードされます。これはフィールド・キャッシュと呼ばれるものです。デフォルトでは、フィールド・キャッシュによってメモリーにロードされるデータの量は無制限です。フィールド・キャッシュが大きくなりすぎると、それが原因でメモリー不足例外が起こり、Analytics プラットフォームが異常終了することがあります。

2. **indices.fielddata.breaker.limit** の値を設定します。

   **indices.fielddata.breaker.limit** を **indices.fielddata.cache.size** より大きい値に設定します。

   したがって、キャッシュ・サイズが *35%* の場合、ブレーカー限度をこのキャッシュ・サイズより大きい値に設定してください。

3. **indices.fielddata.cache.expire** の値を設定します。

   この値は、Elasticsearch キャッシュの有効期限時刻を設定し、キャッシュが無制限に大きくなってヒープが満杯になることを防止します。

   > **indices.fielddata.cache.expire**
   >
   > 一定の期間アクティブでないとフィールド・データが期限切れになる、時刻ベースの設定値です。デフォルトは -1 です。 例えば、5 分の有効期限にするには、5 m と設定します。

4. Analytics のデフォルト設定では、データはパージされません。

   データが確実にパージされるように TTL を適切に構成してください。そうしないと、データ・ストアは無制限に大きくなる可能性があります。

## {{ site.data.keys.mf_analytics_server }} - するべきこと、してはならないこと
{: #mfp-analytics-dos-donts }

-	分析ノードが実行中のときに analyticsData ディレクトリーをクリアするのを避けてください。
-	マルチノード・クラスターでは、イベントを分析クラスターにプッシュするためとコンソールにアクセスするために、同じノードを使用するのを避けてください。ベスト・プラクティスは、分析クラスターの前面でロード・バランサーを使用することです。
-	分析クラスター用に他の Application Server クラスタリング方法を使用するのを避けてください。基礎にある Elasticsearch は、ノード検出メカニズムを使用して独自にクラスターを作成します。
-	IBM WebSphere Application Server フル・プロファイルまたは IBM WebSphere Application Server Network Deployment 上の Analytics 用に Open JDK (または Sun Java) を使用するのを避けてください。
-	Analytics 最小/最大ヒープ・サイズを、ノードの RAM サイズの半分より大きい値にまで増やさないでください。例えば、RAM サイズが 16 GB のノードがある場合、Analytics 用に許容される最大ヒープ・サイズは 8 GB です。
- 分析クラスター名 (**analytics/clustername** JNDI プロパティー) には、固有のクラスター名を使用してください。デフォルト名 *worklight* を使用するのは避けてください。

## {{ site.data.keys.mf_analytics_server }} - SDK の問題
{: #mfp-analytics-sdk-issues }

### 1. Cordova アプリケーションは、ライフサイクル・イベントでのアプリケーション・セッションのキャプチャーを有効にするために、ネイティブ・プラットフォームで初期化する必要があります。
{: #mfp-cordova-apps-appsession }

MobileFirst Platform Foundation v8.0 では、アプリケーションがバックグラウンドからフォアグラウンドに移ると、アプリケーション・セッション数が増加/記録されます。  

アプリケーション・セッション数のキャプチャーは、ライフサイクル・イベントのリスナーを追加することによって有効になります。ネイティブ SDK には、こういったリスナーを追加するための適切な API が備わっています。しかし、Cordova の場合、これらのライフサイクル・イベント・リスナーを追加するための JavaScript API はありません。代わりに、Cordova アプリケーションであってもネイティブ・プラットフォーム API を使用してリスナーを追加する必要があります。

[資料](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/analytics-api/#client-lifecycle-events)からの抜粋:

<blockquote>Analytics SDK が構成された後、ユーザーのデバイス上でアプリケーション・セッションの記録が開始されます。MobileFirst Analytics のセッションは、アプリケーションがフォアグラウンドからバックグラウンドに移され、それによって Analytics コンソールでセッションが作成されると、記録されます。セッションを記録するようにデバイスがセットアップされ、ユーザーがデータを送信するとすぐに、以下に示すように Analytics コンソールにデータが設定されているのを確認できます。</blockquote>

例えば、iOS プラットフォーム (iOS) にある Cordova アプリケーションの場合、`AppDelegate.m` の下に以下を追加することが必須です。
```
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
[[WLAnalytics sharedInstance] send];
```
### 2. Analytics コンソールでのカスタム・データの表示
{: #view-custom-data-console }

Analytics Client SDK API を使用して、Analytics サーバーに送信されたカスタム・データを素早く見つけるために、以下の手順を実行できます。

**「Analytics コンソール」 > 「ダッシュボード」 > 「カスタム・グラフ」 > 「カスタム・グラフの作成」**と進みます。

![カスタム・グラフの作成]({{ site.baseurl }}/tutorials/en/foundation/8.0/analytics/bestpractices-prod/create_custom_chart.png)

詳しくは、[ここ](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/console/custom-charts/)の資料を参照してください。

## {{ site.data.keys.mf_analytics_server }} - トラブルシューティング手順
{: #mfp-analytics-troubleshooting }

1.	カスタマー環境バージョン:<br/>
OS、JDK/JRE、AppServer、MobileFirst Platform Foundation バージョン、および MobileFirst Platform Foundation ビルド・バージョンを含めて、完全なソフトウェア・スタックの詳細を収集します。
2.	環境詳細を IBM MobileFirst Analytics ソフトウェア互換性マトリックス/要件と比較します。
3.	使用される Analytics トポロジー & ハードウェア仕様を収集します。
4.	何らかのパフォーマンス・チューニングが実行されたかどうかを確認します (パフォーマンス問題の場合)。
5.	MobileFirst Platform Foundation Server の `server.xml` (Liberty) および JNDI 環境項目/プロパティー (WAS フル・プロファイル/ND) を収集して、Analytics 統合構成を検証します。
6.	Analytics 管理コンソールのスクリーン・ショットを収集します。
7.	Analytics `server.xml` (Liberty) および JNDI 環境項目/プロパティー (WAS フル・プロファイル/ND) を収集して、Analytics 統合構成を検証します。
8.	次の REST API の出力を収集します (セクション – **Analytics 問題のトラブルシューティングのための重要なコマンド & API** にリストされています)。

## トラブルシューティング用のユーティリティー
{: #urilities-for-troubleshooting }

以下は、Elasticsearch 索引やデータ/シャードの割り振りなどを視覚化および管理するために効果的に使用できる、オープン・ソース・ツールです。

-	[Cerebro](https://github.com/lmenezes/cerebro)
-	[Sense (ベータ)](https://github.com/cheics/sense)

### Analytics 問題のトラブルシューティングのための重要なコマンド & API
{: #commands-apis}

cURL を使用して以下の REST API を実行して、クラスター/シャード/索引に関するさまざまな情報を識別するための応答をキャプチャーしてください。
```
http://<es_node>:9500/_cluster/health
http://<es_node>:9500/_cluster/stats
http://<es_node>:9500/_cat/shards
http://<es_node>:9500/_node/status
http://<es_node>:9500/_cat/indices
```

## 参照
{: #references}

*	[MobileFirst Analytics - Quick & Dirty clusters](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/10/mobilefirst-analytics-quick-dirty-clusters/)
*	[MobileFirst Analytics - Planning for Production](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/01/mobilefirst-analytics-planning-for-production/)
*	[MobileFirst Analytics – Installation Guide](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/analytics/installation/)
*	[Setting JNDI property for Mobile Analytics Time To Live(TTL) value as days in Liberty Profile](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/03/liberty-analytics-jndi-ttl-setting/)
