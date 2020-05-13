---
layout: tutorial
title: MobileFirst Analytics Receiver Server 構成ガイド
breadcrumb_title: 構成ガイド
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_analytics_receiver_server }} の構成。

#### ジャンプ先
{: #jump-to }

* [構成プロパティー](#configuration-properties)

### プロパティー
{: #properties }
構成プロパティーの完全リスト、およびアプリケーション・サーバーでの設定方法については、[構成プロパティー](#configuration-properties)のセクションを参照してください。

## 構成プロパティー
{: #configuration-properties }
{{ site.data.keys.mf_analytics_receiver_server }} は、次の追加の構成を行うことで正常に開始できます。

構成は、JNDI プロパティーを通じて {{ site.data.keys.mf_server }} と {{ site.data.keys.mf_analytics_receiver_server }} の両方で行われます。
さらに、{{ site.data.keys.mf_analytics_receiver_server }} では、構成を制御するための環境変数の使用をサポートします。 環境変数は、JNDI プロパティーより優先されます。

これらのプロパティーの変更を有効にするには、Analytics Receiver ランタイム Web アプリケーションを再始動する必要があります。アプリケーション・サーバー全体を再始動する必要はありません。

WebSphere Application Server Liberty で JNDI プロパティーを設定するには、`server.xml` ファイルに以下のようにタグを追加します。

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Tomcat で JNDI プロパティーを設定するには、`context.xml` ファイルに以下のようにタグを追加します。

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

WebSphere Application Server の JNDI プロパティーは、環境変数として確認できます。

* WebSphere Application Server コンソールで、**「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」**を選択します。
* **{{ site.data.keys.product_adj }} 管理サービス**・アプリケーションを選択します。
* **「Web モジュール・プロパティー」**で**「Web モジュールの環境項目」**をクリックして、JNDI プロパティーを表示します。

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
以下の表は、{{ site.data.keys.mf_analytics_receiver_server }} で設定可能なプロパティーを示しています。

| プロパティー                           | 説明                                           | デフォルト値 |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | このプロパティーには、{{ site.data.keys.mf_analytics_console }} の URL を設定します。 例えば、`http://hostname:port/analytics/console` などです。このプロパティーを設定すると、{{ site.data.keys.mf_console }} で分析アイコンが有効になります。 | なし |
| receiver.analytics.url                  |必須。 着信する分析データを受け取る、{{ site.data.keys.mf_analytics_server }} により公開される URL。 例えば、`http://hostname:port/analytics-service/rest` などです。| なし |
| receiver.analytics.username             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名。 | なし |
| receiver.analytics.password             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるパスワード。 | なし |
| receiver.analytics.event.qsize          | 分析イベント・キュー・サイズのサイズ。これは、十分な JVM ヒープ・サイズを提供することによって、慎重に追加する必要があります。デフォルトのキュー・サイズは 10000  | なし |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
以下の表は、{{ site.data.keys.mf_server }} で設定可能なプロパティーを示しています。

| プロパティー                           | 説明                                           | デフォルト値 |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  | 必須。着信する分析データを受信して {{ site.data.keys.mf_analytics_server }} に転送する {{ site.data.keys.mf_analytics_receiver_server }} によって公開される URL。例えば、`http://hostname:port/analytics-receiver/rest`などです。 | なし |
| mfp.analytics.receiver.username             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名。 | なし |
| mfp.analytics.receiver.password             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるパスワード。 | なし |
