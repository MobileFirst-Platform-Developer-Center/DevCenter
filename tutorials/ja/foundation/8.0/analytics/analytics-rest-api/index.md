---
layout: tutorial
title: Analytics REST API の使用
breadcrumb_title: Analytics REST API
relevantTo: [ios,android,cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics_full }} は、分析データのインポート (POST) およびエクスポート (GET) において開発者を支援する REST API を提供します。

## ジャンプ先:
{: #jump-to }

* [Analytics REST API](#analytics-rest-api)
* [Swagger Docs 上の「Try It Out」](#try-it-out-on-swagger-docs)

## Analytics REST API
{: #analytics-rest-api }

Analytics REST API を使用する場合は、以下のようにします。

**基本 URL**

`/analytics-service/rest`

**例**

`https://example.com:9080/analytics-service/v3/applogs`


REST API メソッド| エンドポイント| 説明
--- | --- | ---
アプリケーション・ログ (POST)| /v3/applogs| 新規アプリケーション・ログを作成します。 
アプリケーション・セッション (POST)| /v3/appsession| アプリケーション・セッションを作成するか、同じ appSessionID を使用してレポートを作成する場合は既存のセッションを更新します。 
一括 (POST)| /v3/bulk| 一括でイベントのレポートを作成します。 
カスタム・グラフ (GET)| /v3/customchart| すべてのカスタム・グラフ定義をエクスポートします。 
カスタム・グラフ (POST)| /v3/customchart/import| カスタム・グラフのリストをインポートします。 
カスタム・データ (POST)| /v3/customdata| 新規カスタム・データを作成します。 
デバイス (POST)| /v3/device| デバイスを作成または更新します。 
データのエクスポート (GET)| /v3/export| データを指定されたデータ・フォーマットにエクスポートします。 
ネットワーク・トランザクション (POST)| /v3/networktransaction|  新規ネットワーク・トランザクションを作成します。 
サーバー・ログ (POST)| /v3/serverlog| 新規サーバー・ログを作成します。 
ユーザー (POST)| /v3/user| 新規ユーザーを作成します。 

## Swagger Docs 上の「Try it out」
{: #try-it-out-on-swagger-docs }

Swagger Docs 上にある Analytics REST API を実際に使用してみましょう。  
{{ site.data.keys.mf_server }} 構成で Analytics を有効にした状態で、`<ipaddress>:<port>/analytics-service` にアクセスします。

![{{ site.data.keys.mf_analytics }} Swagger Docs UI](analytics-swagger.png)

**「命令の展開 (Expand Operations)」**をクリックすると、各メソッドの実装メモ、パラメーター、および応答メッセージを閲覧できます。

> 警告: **「Try it out!」**を使用して送信されるデータはすべて、既にデータ・ストア内にあるデータに干渉する場合があります。特に実稼働環境へのデータ送信を試みていない場合は、`x-mfp-analytics-api-key` のテスト名を使用してください。

![Swagger Docs のテスト](test-swagger.png)
