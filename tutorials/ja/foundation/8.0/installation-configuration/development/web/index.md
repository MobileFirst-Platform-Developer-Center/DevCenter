---
layout: tutorial
title: Web 開発環境のセットアップ
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Web アプリケーションの開発およびテストは、任意の Web ブラウザーでローカル HTML ファイルをプレビューするのと同じくらいに簡単です。  
開発者は、任意の IDE、およびニーズに合ったフレームワークを使用できます。

ただし、Web アプリケーションの開発で壁となる可能性があることが 1 つあります。Web アプリケーションで、[同一オリジン・ポリシー](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)違反によるエラーが発生することがあります。同一オリジン・ポリシーは、Web ブラウザーに課された制限です。例えば、あるアプリケーションがドメイン **example.com** でホストされている場合、同じアプリケーションが別のサーバー、つまり {{ site.data.keys.mf_server }} から使用可能なコンテンツにもアクセスすることは許されません。

[{{ site.data.keys.product }} Web SDK を使用する Web アプリケーション](../../../application-development/sdk/web)は、サポートされるトポロジーで処理される必要があります。例えば、リバース・プロキシーを使用して、同じ単一オリジンを維持しながら適切なサーバーに要求を内部的にリダイレクトして行います。

ポリシーの要件は、以下のいずれかの方法で満たすことができます。

- {{ site.data.keys.mf_server }} もホストする同一 WebSphere フル/Liberty プロファイル・アプリケーション・サーバーから Web アプリケーション・リソースを処理します。
- Node.js をプロキシーとして使用し、アプリケーション要求を {{ site.data.keys.mf_server }} にリダイレクトします。

#### ジャンプ先
{: #jump-to }
- [前提条件](#prerequisites)
- [WebSphere Liberty プロファイルを使用した Web アプリケーション・リソースの処理](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [Node.js の使用](#using-nodejs)
- [次のステップ](#next-steps)

## 前提条件
{: #prerequisites }
-   {: #web-app-supported-browsers }
    Web アプリケーションは、以下のブラウザーのバージョンでサポートされています。バージョン番号は、それぞれのブラウザーで完全にサポートされる最初のバージョンを示します。

    | ブラウザー| Chrome| Safari<sup>*</sup>   | Internet Explorer| Firefox| Android ブラウザー|
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **サポートされるバージョン** | {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> Safari では、プライベート・ブラウズ・モードは SPA (Single-page Application) に対してのみサポートされます。他のアプリケーションでは予期しない動作を生じる可能性があります。

    {% comment %} [sharonl][c-web-browsers-ms-edge] タスク 111165 での Microsoft Edge サポートに関する情報を参照してください。{% endcomment %}

-   以下のセットアップ手順では、Apache Maven または Node.js が開発者のワークステーションにインストールされていることが必要です。詳しい手順については、[インストール・ガイド](../mobilefirst/installation-guide/)を参照してください。

## WebSphere Liberty プロファイルを使用した Web アプリケーション・リソースの処理
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
Web アプリケーションのリソースを処理するには、これらが Maven webapp (**.war** ファイル) に保管されている必要があります。

### Maven webapp アーキタイプの作成
{: #creating-a-maven-webapp-archetype }
1. **コマンド・ライン**・ウィンドウから、自分で選択した場所にナビゲートします。
2. 次のコマンドを実行します:

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - **MyCompany** と **MyWebApp** を独自の値に置き換えます。
    - 値を 1 つずつ入力する場合は、`-DinteractiveMode=false` フラグを削除します。

### Web アプリケーションのリソースでの Maven webapp のビルド 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. 生成された **[MyWebApp] →「src」→「Main」→「webapp」**フォルダーに Web アプリケーションのリソース (HTML、CSS、JavaScript、イメージ・ファイルなど) を入れます。

    > これ以降、**webapp** フォルダーを Web アプリケーションの開発場所とします。

2. コマンド `mvn clean install` を実行し、アプリケーションの Web リソースが入った .war ファイルを生成します。  
   生成された .war ファイルは、**[MyWebApp] →「target」**フォルダーで入手できます。
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:** Web リソースを更新するたびに `mvn clean install` を実行する必要があります。



### アプリケーション・サーバーへの Maven webapp の追加
{: #adding-the-maven-webapp-to-the-application-server }
1. WebSphere Application Server の **server.xml ファイル**を編集します。  
    {{ site.data.keys.mf_dev_kit }} を使用している場合、ファイルは [**{{ site.data.keys.mf_dev_kit }}] →「mfp-server」→「user」→「servers」→「mfp」**フォルダーにあります。以下の項目を追加します。

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - **name** と **path-to/MyWebApp.war** を独自の値に置き換えます。
    - アプリケーション・サーバーは、**server.xml** ファイルへの変更を保存後、自動的に再始動されます。  

### Web アプリケーションのテスト
{: #testing-the-web-application }
Web アプリケーションをテストする準備ができたら、次の URL にアクセスします。**localhost:9080/MyWebApp**
    - **MyWebApp** を独自の値に置き換えます。

## Node.js の使用
{: #using-nodejs }
Node.js をリバース・プロキシーとして使用して、Web アプリケーションから {{ site.data.keys.mf_server }} に要求をトンネリングできます。

1. **コマンド・ライン**・ウィンドウから、Web アプリケーションのフォルダーにナビゲートし、以下の一連のコマンドを実行します。 

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. **node_modules** フォルダーに新規ファイル (例えば、**proxy.js** など) を作成します。
3. 以下のコードをファイルに追加します。

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Web server - serves the web application
   app.get('/home', function(req, res) {
        // Website you wish to allow to connect
        res.sendFile(__dirname + '/index.html');
   });

   // Reverse proxy, pipes the requests to/from {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - **port** 値を希望する値に置き換えます。
    - `/myapp` を Web アプリケーションの希望するパス名に置き換えます。
    - `/index.html` をメイン HTML ファイルの名前に置き換えます。
    - 必要な場合、`/mfp/*` を {{ site.data.keys.product }} ランタイムのコンテキスト・ルートで更新します。

4. プロキシーを開始するには、コマンド `node proxy.js` を実行します。
5. Web アプリケーションをテストする準備ができたら、**server-hostname:port/app-name** の URL にアクセスします。例えば、**http://localhost:9081/myapp** などです。
    - **server-hostname** を独自の値に置き換えます。
    - **port** を独自の値に置き換えます。
    - **app-name** を独自の値に置き換えます。

## 次のステップ
{: #next-steps }
Web アプリケーションで {{ site.data.keys.product }} 開発を続けるには、{{ site.data.keys.product }} Web SDK が Web アプリケーションに追加されなければなりません。

* [{{ site.data.keys.product }} SDK を Web アプリケーションに](../../../application-development/sdk/web/)追加する方法を確認します。
* アプリケーション開発については、[{{ site.data.keys.product }} SDK の使用](../../../application-development/)のチュートリアルを参照してください。
* アダプター開発については、[アダプター](../../../adapters/)のカテゴリーを参照してください。
