---
layout: tutorial
title: API プロキシーを使用したマイクロサービスへの接続
weight: 15
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## API プロキシー
{: #dab-api-proxy }

エンタープライズ・バックエンドに接続するときは、API プロキシーを使用して、MobileFirst プラットフォームのセキュリティーと分析機能を利用できます。 名前が示すとおり、これは実際のバックエンドに要求を送信するために使用できるプロキシーです。

### API プロキシーを使用することの利点

* 実際のバックエンド・ホストがモバイル・アプリケーションに公開されることがなく、MobileFirst サーバー内で保護される。
* バックエンドに対して行われる要求の分析を取得できる。

### API プロキシーの使用法

1. Mobile Foundation コンソールからモバイル API プロキシー・アダプターをダウンロードします。

    ![API プロキシー](dab-api-proxy.png)

2. Mobile Foundation サーバーに API プロキシー・アダプターをデプロイします。

3. API プロキシー・アダプター構成内にバックエンド URI を構成します。 URI の形式は、`protocol:host:port/context` のようにする必要があります。 例えば、`http://secure-backend/basecontext/` です。
4. `WLResourceRequest API` を使用してバックエンドへの要求を行います。 **「モバイル・コア (MOBILE CORE)」**セクションにある API 呼び出しのコード・スニペットを使用します。 オプション・オブジェクトを変更して、`useAPIProxy` キーを true に設定します。

    例:
    ```
    var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
    );
    resourceRequest.send().then(
        function(response) {
            alert("Success: " + response.responseText);
        },
        function(response) {
            alert("Failure: " + JSON.stringify(response));
        }
    );
    ```
