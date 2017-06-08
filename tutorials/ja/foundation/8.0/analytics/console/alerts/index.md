---
layout: tutorial
title: アラートの管理
breadcrumb_title: アラート
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

アラートにより、{{ site.data.keys.mf_analytics_console_full }} を定期的にチェックせずに、モバイル・アプリケーションの正常性をモニターするための事前対応手段が提供されます。  
特定の条件が満たされたときにアラートを起動するための反応しきい値を {{ site.data.keys.mf_analytics_console }} で設定できます。

しきい値は、幅広いレベル (特定アプリケーション) または細かいレベル (特定アプリケーション・インスタンスまたはデバイス) で設定できます。アラート通知は、{{ site.data.keys.mf_analytics_console_short }} に表示するように構成でき、事前構成された REST エンドポイントまたはカスタム Web フックに送信することも可能です。

アラートが起動されると、({{ site.data.keys.mf_analytics_console_short }} のタイトル・バー内の) **「アラート」**アイコンにアラート数が赤で表示されます (<img  alt="アラート・アイコン" style="margin:0;display:inline" src="alertIcon.png"/>)。**「アラート」**アイコンをクリックすると、アラートが表示されます。

アラートを配布する代替方法があります。

**前提条件:** {{ site.data.keys.mf_analytics_server }}が始動されていて、クライアント・ログを受信する準備ができていることを確認します。

## アラートの管理
{: #alert-management }

### アラートの作成
{: #creating-an-alert }

{{ site.data.keys.mf_analytics_console }} で、次のようにします。

1. **「ダッシュボード」→「アラートの管理」**タブを選択します。**「アラートの作成 (Create Alert)」** ボタンをクリックします。

   ![「アラートの管理」タブ](alert_management_tab.png)

2. 「アラート名」、「メッセージ」、「照会頻度」、および「イベント・タイプ」の値を指定します。「イベント・タイプ」に応じて、表示される追加のテキスト・ボックスに適切な値が設定されます。
3. すべての値が入力されたら、**「次へ」**をクリックします。**「配布方式」** タブが表示されます。

### 「配布方式」タブ
{: #distribution-method-tab }

デフォルトでは、アラートは {{ site.data.keys.mf_analytics_console_short }}に表示されます。

**「Analytics コンソールおよびネットワーク・ポスト」**オプションを選択することによって、JSON ペイロードを含む POSTメッセージを、{{ site.data.keys.mf_analytics_console_short }}とカスタマイズされた URL の両方に送信することもできます。

このオプションを選択すると、以下のフィールドが使用可能になります。

* ネットワーク POST URL (Network POST URL) (*必須*)
* ヘッダー (Headers) (*オプション*)
* 認証タイプ (Authentication Type) (*必須*)

<img class="gifplayer"  alt="アラートの作成" src="creating-an-alert.png"/>

## カスタム Web フック
{: #custom-web-hook }

アラートのカスタム配布方式をセットアップすることができます。例えば、アラートしきい値が起動されたときに、ペイロードが送信される先の Web フックを定義します。

ペイロードの例:

```json
{
  "timestamp": 1442848504431,
  "condition": {"value":5.0,"operator":"GTE"},
  "value": "CRASH",
  "offenders": [
    { "XXX 1.0": 5.0 },
    { "XXX 2.0": 1.0 }
  ],
  "property":"closedBy",
  "eventType":"MfpAppSession",
  "title":" Crash Count Alert for Application ABC",
  "message": "The crash count for a application ABC exceeded XYZ.
    View the Crash Summary table in the Crashes tab in the Apps
    section of the MobileFirst Analytics Console
    to see a detailed stacktrace of this crash instance."
}
```

POST 要求には、以下の属性が含まれます。

* **timestamp** - アラート通知が作成された時刻。
* **condition** - ユーザーが設定したしきい値 (例えば、 5 以上など)。
* **eventType** - 照会された eventType。
* **property** - 照会された eventType のプロパティー。
* **value** - 照会されたプロパティーの値。
* **offenders** - アラートを起動したアプリケーションまたはデバイスのリスト。
* **title** - ユーザー定義のタイトル。
* **message** - ユーザー定義のメッセージ。

## アラート詳細の表示
{: #viewing-alert-details }

アラート詳細は、{{ site.data.keys.mf_analytics_console }}で**「ダッシュボード」→「アラート・ログ」**タブから表示できます。

![新規アラート・ログ](alert-log.png)

使用可能な任意の着信アラートの**「+」**アイコンをクリックします。このアクションにより、**「アラート定義」**と**「アラート・インスタンス (Alert Instances)」**のセクションが表示されます。以下の画像は、「アラート定義」と「アラート・インスタンス (Alert Instances)」のセクションを示しています。

![アラート定義およびインスタンス](alert-definitions-and-instances.png)
