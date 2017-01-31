---
layout: tutorial
title: Java アダプターでのロギング
relevantTo: [ios,android,windows,javascript]
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

このチュートリアルでは、Java アダプターにロギング機能を追加するために必要なコード・スニペットを提供します。

## ロギング例
{: #logging-example }

java ロギング・パッケージをインポートします。

```java
import java.util.logging.Logger;
```

ロガーを定義します。

```java
static Logger logger = Logger.getLogger(JavaLoggerTestResource.class.getName());
```

ここで、メソッド内にロギングを組み込みます。

```java
logger.warning("Logging warning message...");
```

このメッセージは、アプリケーション・サーバーの `trace.log` ファイルに出力されます。サーバー管理者が {{site.data.keys.mf_server }} から {{site.data.keys.mf_analytics_server }} にログを転送している場合は、`logger` メッセージは {{site.data.keys.mf_analytics_console }} の**「インフラストラクチャー」→「サーバー・ログの検索」**ビューにも表示されます。

## ログ・ファイルへのアクセス
{: #accessing-the-log-files }

* {{site.data.keys.mf_server }} のオンプレミス・インストールでは、このファイルは基礎となるアプリケーション・サーバーに応じて使用可能です。 
    * [IBM WebSphere Application Server のフル・プロファイル](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server の Liberty プロファイル](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* クラウド・デプロイメントでログを取得するには、以下を使用します。
    * IBM Containers または Liberty Build Pack。[IBM Containers ログおよびトレースの収集](../../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/)チュートリアルを参照してください。
    * Mobile Foundation Bluemix サービス。[Mobile Foundation の使用](../../../bluemix/using-mobile-foundation)チュートリアルの[サーバー・ログへのアクセス](../../../bluemix/using-mobile-foundation/#accessing-server-logs)セクションを参照してください。

## Analytics サーバーへのログの転送
{: #forwarding-logs-to-the-analytics-server }

ログを Analytics コンソールに転送することもできます。

1. {{site.data.keys.mf_console }} のサイドバー・ナビゲーションから、**「設定」**オプションを選択します。
2. **「ランタイム・プロパティー」**タブの**「編集」**ボタンをクリックします。
3. **「Analytics」 → 「追加パッケージ」**セクションで、Java アダプターのクラス名 (`com.sample.JavaLoggerTestResource` など) を指定して、ログを {{site.data.keys.mf_server }} に転送します。

![コンソールからのログ・フィルタリング](java-filter.png)
