---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics_full }}は、データの保管および検索照会の実行に **Elasticsearch 1.5x** を使用します。  

Elasticsearch は、スピードを向上させるリアルタイムの分散検索および分析のエンジンで、データの保管および探索の速度が上がります。 Elasticsearch は、全文検索の構造化検索で使用されます。

Elasticsearch は、{{ site.data.keys.mf_analytics_server }}上の Elasticsearch インスタンスでの JSON フォーマットのすべてのモバイル・データおよびサーバー・データの保管に使用されます。

Elasticsearch インスタンスはリアルタイムで照会され、{{ site.data.keys.mf_analytics_console_full }}にデータが取り込まれます。

{{ site.data.keys.mf_analytics }} はすべての Elasticsearch 機能を公開しています。 ユーザーは、Elasticsearch の照会、デバッグ、および最適化を最大限に利用できます。

ここに記載されている以外の Elasticsearch 機能について詳しくは、[Elasticsearch 資料](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)を参照してください。

## {{ site.data.keys.mf_analytics_server }}での Elasticsearch の管理
{: #managing-elasticsearch-on-the-mobilefirst-analytics-server }

Elasticsearch は、{{ site.data.keys.mf_analytics_server }}に組み込まれており、ノードおよびクラスターの動作に参加します。

> Analytics サーバー上の Elasticsearch の構成について詳しくは、[{{ site.data.keys.mf_analytics_server }}構成ガイド](../../installation-configuration/production/analytics/configuration)の[『クラスター管理および Elasticsearch』](../../installation-configuration/production/analytics/configuration#cluster-management-and-elasticsearch)のトピックを参照してください。

### Elasticsearch のプロパティー
{: #elasticsearch properties }

Elasticsearch のプロパティーは、JNDI 変数または環境の項目を通じて使用できます。  
Elasticsearch データの表示を開始するための、より便利な JNDI プロパティーの 1 つは、次のとおりです。

```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
```

この JNDI プロパティーを使用すると、Elasticsearch によって定義されたポートを通じて JSON フォーマットの {{ site.data.keys.mf_analytics_short }} 生データを表示でき、 Elasticsearch インスタンスにアクセスすることができます。 デフォルト・ポートは 9500 です。

> **注**: この設定は安全ではなく、実稼働環境では有効にしないでください。

## Elasticsearch REST API
{: #elasticsearch-rest-api }

Elasticsearch インスタンスにアクセスできると、カスタム照会を実行できると共に、Elasticsearch クラスターについてより詳細な情報を表示できるようになります。

**データの検索および表示**  
テナントの `_search` REST エンドポイントにアクセスすると、すべてのデータを表示できます。  

```
http://localhost:9500/*/_search
```

**クラスターの正常性の確認**  

```
http://localhost:9500/_cluster/health
```

**現行ノードについての情報の表示**  

```
http://localhost:9500/_nodes
```

**現行マッピングの表示**  

```
http://localhost:9500/*/_mapping
```

> Elasticsearch は、さらに多くの REST エンドポイントを公開しています。 詳細については、[Elasticsearch 資料](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)を参照してください。
