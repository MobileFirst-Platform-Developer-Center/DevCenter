---
layout: tutorial
title: Xamarin のエンドツーエンドのデモンストレーション
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このデモンストレーションの目的は、エンドツーエンドのフローを体験することです。

1. {{ site.data.keys.product_adj }} Xamarin クライアント SDK と事前にバンドルされているサンプル・アプリケーションは、{{ site.data.keys.mf_console }} に登録済みです。
2. 新規または提供済みのアダプターは {{ site.data.keys.mf_console }} にデプロイされています。  
3. アプリケーション・ロジックは、リソース要求を行うために変更されています。

**終了結果**:

* {{ site.data.keys.mf_server }} を正常に ping している。

#### 前提条件:
{: #prerequisites }
* Xamarin Studio
* *オプション*。スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### 2. アプリケーションの作成
{: #2-creating-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。ユーザー名/パスワードは *admin/admin* です。

1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * **Android** プラットフォームを選択します。
    * (次のステップでダウンロードするアプリケーション・スキャフォールドに応じて) **com.ibm.mfpstarterxamarin** を **アプリケーション ID** として入力します。
    * **1.0** を **version** の値として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-xamarin.gif"/>

### 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
* Xamarin プロジェクトを作成します。
* Xamarin SDK を [SDK の追加](../../application-development/sdk/xamarin/)チュートリアルで言及されているとおりに追加します。
* 下記に示すように、`IWorklightClient` タイプのプロパティーを任意のクラス・ファイル内に追加します。

   ```csharp
   /// <summary>
   /// Gets or sets the worklight sample client.
   /// </summary>
   /// <value>The worklight client.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* iOS 向けに開発している場合は、**AppDelegate.cs** ファイルの **FinishedLaunching** メソッド内に以下のコードを貼り付けます。

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance();
  ```
  >`<ClassName>` をクラスの名前で置き換えます。
* Android 向けに開発している場合は、**MainActivity.cs** ファイルの **OnCreate** メソッド内に以下のコード行を含めます。

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance(this);
  ```
  >`<ClassName>` をクラスの名前で置き換えます。
* 下記に示すように、アクセス・トークンを取得するようにメソッドを定義し、MFP サーバーへのリソース要求を実行します。

    ```csharp
    public async void ObtainToken()
           {
            try
                   {

                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
       
                       if (accessToken.Value != null &&  accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");
       
                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();
       
                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```

* クラス・コンストラクター内で、またはボタンのクリックで **ObtainToken** メソッドを呼び出します。

### 4. アダプターのデプロイ
{: #4-deploy-an-adapter }
[この準備された .adapter 成果物](../javaAdapter.adapter) をダウンロードし、それを {{ site.data.keys.mf_console }} から **「アクション」 → 「アダプターのデプロイ」** アクションを使用してデプロイします。

あるいは、**「アダプター」** の隣の **「新規」** ボタンをクリックします。

1. **「アクション」 → 「サンプルのダウンロード」** オプションを選択します。「Hello World」 **Java** アダプターのサンプルをダウンロードします。

   > Maven および {{ site.data.keys.mf_cli }} がインストールされていない場合は、スクリーン内の **「開発環境をセットアップします」** の説明に従います。

2. **コマンド・ライン** ・ウィンドウからアダプターの Maven プロジェクト・ルート・フォルダーにナビゲートし、以下のコマンドを実行します。

   ```bash
   mfpdev adapter build
   ```

3. ビルドが終了したら、それを {{ site.data.keys.mf_console }} から **「アクション」 → 「アダプターのデプロイ」** アクションを使用してデプロイします。アダプターは、**[アダプター]/target** フォルダー内にあります。

   <img class="gifplayer" alt="アダプターのデプロイ" src="create-an-adapter.png"/>

<!-- <img src="device-screen.png" alt="サンプル・アプリケーション" style="float:right"/>-->
### 5. アプリケーションのテスト
{: #5-testing-the-application }
1. Xamarin Studio で、`mfpclient.properties` ファイルを選択し、**protocol**、**host**、**port** の各プロパティーをご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (Bluemix 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。

2. **「再生」** ボタンを押します。

<br clear="all"/>
### 結果
{: #results }
* **「MobileFirst Server の ping (Ping MobileFirst Server)」** ボタンをクリックすると、**「MobileFirst Server に接続 (Connected to MobileFirst Server)」** が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。

その場合、アダプター応答が Xamarin Studio コンソールに出力されます。![{{ site.data.keys.mf_server }} から正常にリソースを呼び出したアプリケーションの画像](console-output.png)

## 次のステップ
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アダプター開発に関するチュートリアル](../../adapters/) を検討する
- [認証とセキュリティーに関するチュートリアル](../../authentication-and-security/) を検討する
- [すべてのチュートリアル](../../all-tutorials) を検討する
