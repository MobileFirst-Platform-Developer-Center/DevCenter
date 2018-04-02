---
layout: tutorial
title: ログ・フィルターの構成
breadcrumb_title: Log Filters
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

管理者は、**{{ site.data.keys.mf_console }} →「 [ご使用のアプリケーション] 」→「 [バージョン] 」→「ログ・フィルター 」**から、{{ site.data.keys.product_adj }} クライアント SDK ログのキャプチャーおよびレベルを制御できます。  
`「ログ・フィルター」`を使用して、ログに記録できるフィルター・レベルを作成できます。 ログ・レベルは、グローバル (すべてのロガー・インスタンス) に設定することも、特定のパッケージ (複数可) に設定することも可能です。

<img class="gifplayer"  alt="ログ・フィルターの作成" src="add-log-filter.png"/>

サーバーで設定された構成オーバーライドをアプリケーションが取り出すには、アプリケーション・ライフサイクル・コールバック内など、定期的に実行されるコード内の場所から `updateConfigFromServer` メソッドを呼び出す必要があります。


#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

サーバーが返す `Logger` 構成値は、クライアント・サイドに設定されているすべての値に優先します。 クライアント・ログ・プロファイルが削除されている場合、クライアントは、クライアント・ログ・プロファイルの取得を試みても空のペイロードを受け取ります。 この場合、`Logger` 構成は、デフォルトである、クライアントに元々構成されていたものになります。

## サーバー・ログの転送
{: #forwarding-server-logs }

{{ site.data.keys.mf_console }} を使用して、サーバー管理者はログを維持し、それらのログを {{ site.data.keys.mf_analytics_console }}に送信することもできます。

サーバー・ログを転送するには、**「ランタイム設定」**画面にナビゲートし、**「追加パッケージ」**の下のロガー・パッケージを指定します。  
その後、収集されたログは {{ site.data.keys.mf_analytics_console_short }}で表示できます。 これは、すべてのサーバー・ログを収集することなく {{ site.data.keys.mf_analytics_console_short }}でユーザーがアダプター・ログを選別する場合に便利です。
