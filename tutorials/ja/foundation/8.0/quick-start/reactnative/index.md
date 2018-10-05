---
layout: tutorial
title: React Native のエンドツーエンドのデモンストレーション
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このデモンストレーションの目的は、エンドツーエンドのフローを説明することです。

1. {{ site.data.keys.product_adj }} クライアント SDK と事前にバンドルされているサンプル・アプリケーションは登録済みで、{{ site.data.keys.mf_console }} からダウンロードされています。
2. 新規または提供済みのアダプターは {{ site.data.keys.mf_console }} にデプロイされています。  
3. アプリケーション・ロジックは、リソース要求を行うために変更されています。

**終了結果**:

* {{ site.data.keys.mf_server }} を正常に ping している。
* アダプターを使用してデータを正常に取得している。

### 前提条件:
{: #prerequisites }
* Xcode for iOS、Android Studio for Android
* React Native CLI
* *オプション*。 {{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。 スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### ステップ 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスを作成済み](../../bluemix/using-mobile-foundation)であることを確認します。あるいは、[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### ステップ 2. アプリケーションの作成および登録
{: #2-creating-and-registering-an-application }
ブラウザーで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。 サーバーがローカルで実行されている場合は、`http://localhost:9080/mfpconsole` を使用します。*ユーザー名/パスワード* は **admin/admin** です。

1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * 次のいずれかのプラットフォームを選択します。**Android、iOS**
    * **「アプリケーション ID」**として「**com.ibm.mfpstarter.reactnative**」を入力します。
    * **1.0.0** を **version** として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-reactnative.png"/>

2. [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative) から、React Native サンプル・アプリケーションをダウンロードします。

### ステップ 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. 任意のコード・エディターで React Native プロジェクトを開きます。

2. プロジェクトのルート・フォルダーにある、**app.js** ファイルを選択し、以下のコード・スニペットを貼り付けて、既存の `WLAuthorizationManager.obtainAccessToken()` 関数を置き換えます。

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
        resourceRequest.send().then(
          (response) => {
            // Will display "Hello world" in an alert dialog.
            alert("Success: " + response.responseText);
          },
          (error) => {
            alert("Failure: " + JSON.stringify(error));
          }
        );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        alert("Failed to connect to MobileFirst Server");
      });
```

### ステップ 4. アダプターのデプロイ
{: #4-deploy-an-adapter }
[.adapter 成果物](../javaAdapter.adapter)をダウンロードし、これを、**「アクション」 → 「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からデプロイします。

あるいは、**「アダプター」**の隣の**「新規」**ボタンをクリックします。  

1. **「アクション」→「サンプルのダウンロード」**オプションを選択します。 *Hello World* **Java** アダプターのサンプルをダウンロードします。

    > Maven および {{ site.data.keys.mf_cli }} がインストールされていない場合は、スクリーン内の**「開発環境をセットアップします」**の説明に従います。

2. **コマンド・ライン**・ウィンドウからアダプターの Maven プロジェクト・ルート・フォルダーにナビゲートし、以下のコマンドを実行します。

    ```bash
    mfpdev adapter build
    ```

3. ビルドが終了したら、**「アクション」→「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からアダプターをデプロイします。 アダプターは、**[adapter]/target** フォルダー内にあります。

    <img class="gifplayer" alt="アダプターのデプロイ" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>

### ステップ 5. アプリケーションのテスト
{: #5-testing-the-application }
1.  {{ site.data.keys.mf_cli }} がインストールされていることを確認し、特定のプラットフォームの (iOS または Android) ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。リモート {{ site.data.keys.mf_server }} が使用されている場合は、次の[コマンドを実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加します。
```bash
mfpdev server add
```
次に、アプリを登録するコマンドを実行します。例えば次のとおりです。
```bash
mfpdev app register myIBMCloudServer
```
2. 次のコマンドを実行してアプリケーションを実行します。
```bash
react-native run-ios|run-android
```

デバイスが接続されている場合は、アプリケーションがデバイスにインストールされ、起動されます。接続されていない場合は、シミュレーターまたはエミュレーターが使用されます。

<br clear="all"/>
### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。その場合、アダプター応答がアラートに表示されます。

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
