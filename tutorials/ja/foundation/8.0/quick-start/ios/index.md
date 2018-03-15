---
layout: tutorial
title: iOS のエンドツーエンドのデモンストレーション
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
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
* Xcode
* *オプション*。 {{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。 スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### 2. アプリケーションの作成
{: #2-creating-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。 ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。 ユーザー名/パスワードは *admin/admin* です。

1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * **iOS** プラットフォームを選択します。
    * (次のステップでダウンロードするアプリケーション・スキャフォールドに応じて) **com.ibm.mfpstarteriosobjectivec** または **com.ibm.mfpstarteriosswift** を **アプリケーション ID** として入力します。
    * **1.0** を **version** の値として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-ios.png"/>

2. **「スターター・コードの取得」**タイルをクリックして、iOS Objective-C または iOS Swift サンプル・アプリケーションをダウンロードすることを選択します。

    <img class="gifplayer" alt="サンプル・アプリケーションのダウンロード" src="download-starter-code-ios.png"/>

### 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. **.xcworkspace** ファイルをダブルクリックして Xcode プロジェクトを開きます。

2. **[project-root]/ViewController.m/swift** ファイルを選択し、以下のコード・スニペットを貼り付けて、既存の `getAccessToken()` 関数を置換します。

   Objective-C の場合:

   ```objc
   - (IBAction)getAccessToken:(id)sender {
   _testServerButton.enabled = NO;
   NSURL *serverURL = [[WLClient sharedInstance] serverUrl];
   _connectionStatusLabel.text = [NSString stringWithFormat:@"Connecting to server...\n%@", serverURL];

   NSLog(@"Testing Server Connection");
   [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:@"" withCompletionHandler:^(AccessToken *token, NSError *error) {
        if (error != nil) {
            _titleLabel.text = @"Bummer...";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Failed to connect to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Did not receive an access token from server: %@", error.description);
        } else {
            _titleLabel.text = @"Yay!";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Connected to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Received the following access token value: %@", token.value);

            NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/resource/greet/"];
            WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];

            [request setQueryParameterValue:@"world" forName:@"name"];
            [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                if (error != nil){
                    NSLog(@"Failure: %@",error.description);
                }
                else if (response != nil){
                    // Will print "Hello world" in the Xcode Console.
                    NSLog(@"Success: %@",response.responseText);
                }
            }];
        }

        _testServerButton.enabled = YES;
    }];
}
   ```

   Swift の場合:

   ```swift
   @IBAction func getAccessToken(sender: AnyObject) {
        self.testServerButton.enabled = false

        let serverURL = WLClient.sharedInstance().serverUrl()

        connectionStatusLabel.text = "Connecting to server...\n\(serverURL)"
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in

            if (error != nil) {
                self.titleLabel.text = "Bummer..."
                self.connectionStatusLabel.text = "Failed to connect to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Did not recieve an access token from server: " + error.description)
            } else {
                self.titleLabel.text = "Yay!"
                self.connectionStatusLabel.text = "Connected to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Recieved the following access token value: " + token.value)

                let url = NSURL(string: "/adapters/javaAdapter/resource/greet/")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)

                request.setQueryParameterValue("world", forName: "name")
                request.sendWithCompletionHandler { (response, error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }

            self.testServerButton.enabled = true
        }
   }
   ```

### 4. アダプターのデプロイ
{: #4-deploy-an-adapter }
[この作成済みの .adapter 成果物](../javaAdapter.adapter)をダウンロードし、{{ site.data.keys.mf_console }} から**「アクション」→「アダプターのデプロイ」**アクションを使用して、この成果物をデプロイします。

あるいは、**「アダプター」**の隣の**「新規」**ボタンをクリックします。  

1. **「アクション」→「サンプルのダウンロード」**オプションを選択します。 「Hello World」**Java** アダプターのサンプルをダウンロードします。

   > Maven および {{ site.data.keys.mf_cli }} がインストールされていない場合は、スクリーン内の**「開発環境をセットアップします」**の説明に従います。

2. **コマンド・ライン**・ウィンドウからアダプターの Maven プロジェクト・ルート・フォルダーにナビゲートし、以下のコマンドを実行します。

   ```bash
   mfpdev adapter build
   ```

3. ビルドが終了したら、**「アクション」→「アダプターのデプロイ」**アクションを使用して {{ site.data.keys.mf_console }} からアダプターをデプロイします。 アダプターは、**[adapter]/target** フォルダー内にあります。

    <img class="gifplayer" alt="アダプターのデプロイ" src="create-an-adapter.png"/>   

<img src="iosQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>
### 5. アプリケーションのテスト
{: #5-testing-the-application }
1. Xcode で、**mfpclient.plist** ファイルを選択し、**protocol**、**host**、**port** の各プロパティーをご使用の {{ site.data.keys.mf_server }} の正しい値で編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (IBM Cloud 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。
    * IBM Cloud Private 上で Kubernetes クラスターを使用していて、デプロイメントのタイプが **NodePort** の場合、通常、ポートの値は、Kubernetes クラスターのサービスによって公開される **NodePort** です。

    あるいは、{{ site.data.keys.mf_cli }} がインストール済みの場合は、プロジェクト・ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。 リモート {{ site.data.keys.mf_server }} が使用されている場合は、[コマンド `mfpdev server add` を実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加し、続いて、例えば、`mfpdev app register myIBMCloudServer` を実行します。
    
2. **「再生」**ボタンを押します。

<br clear="all"/>
### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。

その場合、アダプター応答が Xcode コンソールに出力されます。

![ {{ site.data.keys.mf_server }} からリソースを正常に呼び出したアプリケーションのイメージ](success_response.png)

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
