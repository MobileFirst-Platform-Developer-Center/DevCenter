---
layout: tutorial
title: Windows 8.1 Universal および Windows 10 UWP のエンドツーエンドのデモンストレーション
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
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
* 構成済み Visual Studio 2013/5
* *オプション*。{{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、コマンド `./run.cmd` を実行します。

### 2. アプリケーションの作成
{: #2-creating-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。ユーザー名/パスワードは *admin/admin* です。

1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * **Windows** プラットフォームを選択します。
    * **アプリケーション ID** として、Windows の場合は **MFPStarterCSharp.Windows** を、Windows Phone の場合は **MFPStarterCSharp.WindowsPhone** を入力します。
    * **1.0.0** を **version** の値として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-windows.png"/>

2. **「スターター・コードの取得」**タイルをクリックして、Windows 8.1 または Windows 10 サンプル・アプリケーションをダウンロードすることを選択します。

    <img class="gifplayer" alt="サンプル・アプリケーションのダウンロード" src="download-starter-code-windows.png"/>

### 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. Visual Studio プロジェクトを開きます。

2. ソリューションの **MainPage.xaml.cs** ファイルを選択し、以下のコード・スニペットを GetAccessToken() メソッドに貼り付けます。

   ```csharp
   try
      {
          IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken && accessToken.Value != null && accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. アダプターのデプロイ
{: 4-deploy-an-adapter }
[この作成済みの .adapter 成果物](../javaAdapter.adapter)をダウンロードし、{{ site.data.keys.mf_console }} から**「アクション」→「アダプターのデプロイ」**アクションを使用して、この成果物をデプロイします。

<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>
### 5. アプリケーションのテスト
{: 5-testing-the-application }
1. Visual Studio で、**mfpclient.resw** ファイルを選択し、**protocol**、**host**、**port** の各プロパティーをご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (Bluemix 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。

    あるいは、{{ site.data.keys.mf_cli }} がインストール済みの場合は、プロジェクト・ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。リモート {{ site.data.keys.mf_server }} が使用されている場合は、 [コマンド `mfpdev server add` を実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加し、続いて、例えば、`mfpdev app register myBluemixServer` を実行します。

2. **「アプリケーションの実行 (Run App)」**ボタンを押します。

### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。

その場合、アダプター応答が Visual Studio の出力コンソールに出力されます。

![ {{ site.data.keys.mf_server }} からリソースを正常に呼び出したアプリケーションのイメージ](success_response.png)

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
