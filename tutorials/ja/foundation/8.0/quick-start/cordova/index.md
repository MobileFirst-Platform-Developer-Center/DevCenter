---
layout: tutorial
title: Cordova のエンドツーエンドのデモンストレーション
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
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
* Xcode for iOS、Android Studio for Android または Visual Studio 2013/2015 for Windows 8.1 Universal / Windows 10 UWP
* Cordova CLI 6.x.
* *オプション*。{{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### 2. アプリケーションの作成および登録
{: #2-creating-and-registering-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。ユーザー名/パスワードは *admin/admin* です。
 
1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * プラットフォーム **Android, iOS, Windows** を選択します。
    * **com.ibm.mfpstartercordova** を**アプリケーション ID** として入力します。
    * **1.0.0** を **version** として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-cordova.png"/>
 
2. **「スターター・コードの取得」**タイルをクリックして、Cordova サンプル・アプリケーションをダウンロードすることを選択します。

    <img class="gifplayer" alt="サンプル・アプリケーションのダウンロード" src="download-starter-code-cordova.png"/>
 
### 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. お好きなコード・エディターで Cordova プロジェクトを開きます。

2. **www/js/index.js** ファイルを選択し、以下のコード・スニペットを貼り付けて、既存の `WLAuthorizationManager.obtainAccessToken()` 関数を置換します。

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
{: #4-deploy-an-adapter }
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


<img src="cordovaQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>
### 5. アプリケーションのテスト
{: #5-testing-the-application }
1. **コマンド・ライン**・ウィンドウから Cordova プロジェクトのルート・フォルダーにナビゲートします。
2. コマンド `cordova platform add ios|android|windows` を実行してプラットフォームを追加します。
3. Cordova プロジェクトで、**config.xml** ファイルを選択し、**protocol**、**host**、および **port** の各プロパティーを含む `<mfp:server ... url=" "/>` 値を、ご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (Bluemix 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。

    あるいは、{{ site.data.keys.mf_cli }} がインストール済みの場合は、プロジェクト・ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。リモート {{ site.data.keys.mf_server }} が使用されている場合は、 [コマンド `mfpdev server add` を実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加し、続いて、例えば、`mfpdev app register myBluemixServer` を実行します。
	
デバイスが接続されている場合は、アプリケーションがデバイスにインストールされ、起動されます。  
接続されていない場合は、シミュレーターまたはエミュレーターが使用されます。

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
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
