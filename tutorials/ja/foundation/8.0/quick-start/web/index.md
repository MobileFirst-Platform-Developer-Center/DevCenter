---
layout: tutorial
title: Web アプリケーションのエンドツーエンドのデモンストレーション
breadcrumb_title: Web
relevantTo: [javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このデモンストレーションの目的は、エンドツーエンドのフローを体験することです。

1. {{ site.data.keys.product_adj }} クライアント SDK と事前にバンドルされているサンプル・アプリケーションは登録済みで、{{ site.data.keys.mf_console }} からダウンロードされています。
2. 新規または提供済みのアダプターは {{ site.data.keys.mf_console }} にデプロイされています。  
3. アプリケーション・ロジックは、リソース要求を行うために変更されています。

**終了結果**:

* {{ site.data.keys.mf_server }} を正常に ping している。
* アダプターを使用してデータを正常に取得している。

#### 前提条件:
{: #prerequisites }
* 最新 Web ブラウザー
* *オプション*。{{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### 2. アプリケーションの作成および登録
{: #creating-and-registering-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。ユーザー名/パスワードは *admin/admin* です。
 
1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * **Web** プラットフォームを選択します。
    * **com.ibm.mfpstarterweb** を**アプリケーション ID** として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-web.png"/>
 
2. **「スターター・コードの取得」**タイルをクリックして、Web サンプル・アプリケーションをダウンロードすることを選択します。

    <img class="gifplayer" alt="サンプル・アプリケーションのダウンロード" src="download-starter-code-web.png"/>
 
### 3. アプリケーション・ロジックの編集
{: #editing-application-logic }
1. お好きなコード・エディターでプロジェクトを開きます。

2. **client/js/index.js** ファイルを選択し、以下のコード・スニペットを貼り付けて、既存の `WLAuthorizationManager.obtainAccessToken()` 関数を置換します。

   ```javascript
   WLAuthorizationManager.obtainAccessToken()
        .then(
            function(accessToken) {
                titleText.innerHTML = "Yay!";
                statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
                
                var resourceRequest = new WLResourceRequest(
                    "/adapters/javaAdapter/resource/greet/",
                    WLResourceRequest.GET
                );
                
                resourceRequest.setQueryParameter("name", "world");
                resourceRequest.send().then(
                    function(response) {
                        // Will display "Hello world" in an alert dialog.
                        alert("Success: " + response.responseText);
                    },
                    function(response) {
                        alert("Failure: " + JSON.stringify(response));
                    }
                );
            },

            function(error) {
                titleText.innerHTML = "Bummer...";
                statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
            }
        );
   ```
    
### 4. アダプターのデプロイ
{: #deploy-an-adapter }
[この作成済みの .adapter 成果物](../javaAdapter.adapter)をダウンロードし、{{ site.data.keys.mf_console }} から**「アクション」→「アダプターのデプロイ」**アクションを使用して、この成果物をデプロイします。

あるいは、**「アダプター」**の隣の**「新規」**ボタンをクリックします。  
        
1. **「アクション」→「サンプルのダウンロード」**オプションを選択します。「Hello World」**Java** アダプターのサンプルをダウンロードします。

   > Maven および {{ site.data.keys.mf_cli }} がインストールされていない場合は、スクリーン内の**「開発環境をセットアップします」**の説明に従います。

2. **コマンド・ライン**・ウィンドウからアダプターの Maven プロジェクト・ルート・フォルダーにナビゲートし、以下のコマンドを実行します。

   ```bash
   mfpdev adapter build
   ```

3. ビルドが終了したら、**「アクション」→「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からアダプターをデプロイします。アダプターは、**[adapter]/target** フォルダー内にあります。
    
    <img class="gifplayer" alt="アダプターのデプロイ" src="create-an-adapter.png"/>   


<img src="web-success.png" alt="サンプル・アプリケーション" style="float:right"/>
### 5. アプリケーションのテスト
{: #testing-the-application }
1. **コマンド・ライン**・ウィンドウから **[project root] → node-server** フォルダーにナビゲートします。
2. コマンド `npm start` を実行して、必要な Node.js 構成をインストールして Node.js サーバーを始動します。
3. **[project root] → node-server → server.js** ファイルを開き、**host** 変数および **port** 変数をご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (Bluemix 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。 

   以下に例を示します。  
    
   ```javascript
   var host = 'https://mobilefoundation-xxxx.mybluemix.net'; // The Mobile Foundation server address
   var port = 9081; // The local port number to use
   var mfpURL = host + ':443'; // The Mobile Foundation server port number
   ```
   
4. ブラウザーで次の URL にアクセスします。 [http://localhost:9081/home](http://localhost:9081/home)

<br>
#### Secure Origins ポリシー
{: #secure-origins-policy }
開発時に Chrome を使用している場合、このブラウザーでは、HTTP と「localhost」**ではない**ホストの両方を使用しているときにアプリケーションをロードすることができません。これは、このブラウザーでデフォルトで実装および使用されている Secure Origins ポリシーのためです。

これを打開するために、Chrome ブラウザーを以下のフラグを付けて開始できます。

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- フラグが機能するように、「test-to-new-user-profile/myprofile」を新規 Chrome ユーザー・プロファイルとして機能するフォルダーのロケーションに置換します。

<br clear="all"/>
### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。

その場合、アダプター応答がアラートに表示されます。

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
