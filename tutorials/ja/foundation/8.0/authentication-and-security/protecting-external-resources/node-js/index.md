---
layout: tutorial
title: Node.js バリデーター
breadcrumb_title: Node.js validator
relevantTo: [android,ios,windows,javascript]
weight: 3
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} は、外部リソースにセキュリティー機能を適用するための Node.js フレームワークを提供しています。  
Node.js フレームワークは、npm モジュール (**passport-mfp-token-validation**) として提供されます。

このチュートリアルでは、スコープ (`accessRestricted`) を使用して、単純な Node.js リソース `GetBalance` を保護する方法を示します。

**前提条件:**  

* [{{ site.data.keys.mf_server }} を使用した外部リソースの認証](../)チュートリアルをお読みください。
* [{{ site.data.keys.product }} セキュリティー・フレームワーク](../../)の知識が必要です。

## passport-mfp-token-validation モジュール
{: #the-passport-mfp-token-validation-module }
passport-mfp-token-validation モジュールは、{{ site.data.keys.mf_server }} によって発行されるアクセス・トークンを検証するための認証メカニズムを提供します。

モジュールをインストールするには、以下を実行します。

```bash
npm install passport-mfp-token-validation@8.0.X
```

## 使用法
{: #usage }
* サンプルでは、`express` モジュールと `passport-mfp-token-validation` モジュールが使用されます。

  ```javascript
  var express = require('express');
  var passport = require('passport-mfp-token-validation').Passport;
  var mfpStrategy = require('passport-mfp-token-validation').Strategy;
  ```

* `Strategy` を以下のようにセットアップします。

  ```javascript
  passport.use(new mfpStrategy({
    authServerUrl: 'http://localhost:9080/mfp/api',
    confClientID: 'testclient',
    confClientPass: 'testclient',
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
  }));
  ```
  
 * `authServerUrl`: `localhost:9080` を実際の {{ site.data.keys.mf_server }} IP アドレスとポート番号に置き換えてください。
 * `confClientID`、`confClientPass`: 機密クライアント ID とパスワードを {{ site.data.keys.mf_console }} で定義したものに置き換えてください。
 * `analytics`: Analytics 項目はオプションです。Analytics のイベントを {{ site.data.keys.product }} のログに記録する場合にのみ必要です。  
 `localhost:9080`、`username`、および `password` を Analytics Server の IP アドレス、ポート番号、ユーザー名、およびパスワードに置き換えてください。

* `passport.authenticate` を呼び出して、要求を認証します。

  ```javascript
  var app = express();
  app.use(passport.initialize());

  app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
      session: false,
      scope: 'accessRestricted'
  }),
  function(req, res) {
      res.send('17364.9');
  });

  var server = app.listen(3000, function() {
      var port = server.address().port
      console.log("Sample app listening at http://localhost:%s", port)
  });
  ```

 * 採用する `Strategy` は、`mobilefirst-strategy` にする必要があります。
 * `session` を `false` に設定します。
 * `scope` 名を指定します。

## サンプル・アプリケーション 
{: #sample-application }
[Node.js サンプルをダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80)します。

### サンプルの使用法
{: #sample-usage }
1. サンプルのルート・フォルダーにナビゲートし、コマンド `npm install` を実行し、続けて、`npm start` も実行します。
2. {{ site.data.keys.mf_console }} で、必ず[機密クライアントと秘密鍵の値を更新](../#confidential-client)してください。
3. **[UserLogin](../../user-authentication/security-check/)** または **[PinCodeAttempts](../../credentials-validation/security-check/)** のいずれかのセキュリティー検査をデプロイします。
4. 一致するアプリケーションを登録します。
5. `accessRestricted` スコープをセキュリティー検査にマップします。
6. クライアント・アプリケーションを更新して、サーブレット URL に `WLResourceRequest` を発行します。
