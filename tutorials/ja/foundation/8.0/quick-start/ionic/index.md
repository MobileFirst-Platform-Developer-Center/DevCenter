---
layout: tutorial
title: Ionic のエンドツーエンドのデモンストレーション
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このデモンストレーションの目的は、エンドツーエンドのフローを説明することです。 以下の手順を実行します。

1. {{ site.data.keys.product_adj }} クライアント SDK と事前にバンドルされているサンプル・アプリケーションは登録済みで、{{ site.data.keys.mf_console }} からダウンロードされています。
2. 新規または提供済みのアダプターは {{ site.data.keys.mf_console }} にデプロイされています。  
3. アプリケーション・ロジックは、リソース要求を行うために変更されています。

**終了結果**:

* {{ site.data.keys.mf_server }} を正常に ping している。
* アダプターを使用してデータを正常に取得している。

### 前提条件:
{: #prerequisites }
* Xcode for iOS、Android Studio for Android、または Android Studio for Visual Studio 2015 以上 (Windows 10 UWP 用)
* Ionic CLI
* *オプション*。 {{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))。
* *オプション*。 スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))。

### ステップ 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスを作成済み](../../bluemix/using-mobile-foundation)であることを確認します。あるいは、[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### ステップ 2. アプリケーションの作成および登録
{: #2-creating-and-registering-an-application }
ブラウザーで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。 サーバーがローカルで実行されている場合は、`http://localhost:9080/mfpconsole` を使用します。 *ユーザー名/パスワード* は **admin/admin** です。

1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * プラットフォームのリストから、次のいずれかを選択します。**Android、iOS、Windows、Browser**
    * **「アプリケーション ID」**として「**com.ibm.mfpstarterionic**」を入力します。
    * **1.0.0** を **version** として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-ionic.png"/>

2. [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic)から、サンプルの Ionic アプリケーションをダウンロードします。

### ステップ 3: Ionic アプリケーションへの MobileFirst SDK の追加
{: #adding_mfp_ionic_sdk}

ダウンロードした Ionic サンプル・アプリケーションに MobileFirst Ionic SDK を追加するには、以下のステップを行います。

1. 既存の Ionic プロジェクトのルートにナビゲートし、{{ site.data.keys.product_adj }} コア Ionic Cordova プラグインを追加します。

2. 次のコマンドを使用して、ディレクトリーを Ionic プロジェクトのルートに変更します。`cd MFPStarterIonic`

3. 次の Ionic CLI コマンドを使用して、MobileFirst プラグインを追加します。`ionic cordova plugin add cordova-plugin-name` 以下に例を示します。

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > 上記のコマンドは、MobileFirst Core SDK プラグインを Ionic プロジェクトに追加します。

4. 次の Ionic CLI コマンドを使用して、1 つ以上のサポートされているプラットフォームを Cordova プロジェクトに追加します。`ionic cordova platform add ios|android|windows|browser` 以下に例を示します。

   ```bash
   cordova platform add ios
   ```

5. `ionic cordova prepare` コマンドを実行して、アプリケーション・リソースを準備します。

   ```bash
   ionic cordova prepare
   ```

### ステップ 4. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. 任意のコード・エディターで、Ionic プロジェクトを開きます。

2. **src/js/index.js** ファイルを選択し、以下のコード・スニペットを貼り付けて、既存の `WLAuthorizationManager.obtainAccessToken()` 関数を置き換えます。

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
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
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### ステップ 5. アダプターのデプロイ
{: #4-deploy-an-adapter }
この [.adapter 成果物](../javaAdapter.adapter)をダウンロードし、これを、**「アクション」 → 「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からデプロイします。

あるいは、**「アダプター」**の隣の**「新規」**ボタンをクリックします。  

1. **「アクション」→「サンプルのダウンロード」**オプションを選択します。 *Hello World* **Java** アダプターのサンプルをダウンロードします。

    > Maven および {{ site.data.keys.mf_cli }} がインストールされていない場合は、スクリーン内の**「開発環境をセットアップします」**の説明に従います。

2. **コマンド・ライン**・ウィンドウからアダプターの Maven プロジェクト・ルート・フォルダーにナビゲートし、以下のコマンドを実行します。

    ```bash
    mfpdev adapter build
    ```

3. ビルドが終了したら、**「アクション」→「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からアダプターをデプロイします。 アダプターは、**[adapter]/target** フォルダー内にあります。

    <img class="gifplayer" alt="アダプターのデプロイ" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>

### ステップ 6. アプリケーションのテスト
{: #5-testing-the-application }
1. **コマンド・ライン**・ウィンドウから Cordova プロジェクトのルート・フォルダーにナビゲートします。
2. コマンド `ionic cordova platform add ios|android|windows|browser` を実行してプラットフォームを追加します。
3. Ionic プロジェクトで、**config.xml** ファイルを選択し、**protocol**、**host**、および **port** の各プロパティーを含む `<mfp:server ... url=" "/>` 値を、ご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (IBM Cloud 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。
    * IBM Cloud Private 上で Kubernetes クラスターを使用していて、デプロイメントのタイプが **NodePort** の場合、通常、ポートの値は、Kubernetes クラスターのサービスによって公開される **NodePort** です。

    あるいは、{{ site.data.keys.mf_cli }} がインストール済みの場合は、プロジェクト・ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。 リモート {{ site.data.keys.mf_server }} が使用されている場合は、次の[コマンドを実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加します。
    ```bash
    mfpdev server add
    ```
     次に、アプリを登録するコマンドを実行します。例えば次のとおりです。
    ```bash
    mfpdev app register myIBMCloudServer
    ```

デバイスが接続されている場合は、アプリケーションがデバイスにインストールされ、起動されます。
接続されていない場合は、シミュレーターまたはエミュレーターが使用されます。

<br clear="all"/>
### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。 その場合、アダプター応答がアラートに表示されます。

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
