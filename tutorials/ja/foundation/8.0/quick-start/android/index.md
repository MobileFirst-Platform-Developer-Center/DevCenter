---
layout: tutorial
title: Android のエンドツーエンドのデモンストレーション
breadcrumb_title: Android
relevantTo: [android]
weight: 3
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
* Android Studio
* *オプション*。{{ site.data.keys.mf_cli }} ([ダウンロード]({{site.baseurl}}/downloads))
* *オプション*。スタンドアロン {{ site.data.keys.mf_server }} ([ダウンロード]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} の開始
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation インスタンスが作成済みである](../../bluemix/using-mobile-foundation)ことを確認してください。作成済みでない場合は、  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)を使用しているときは、サーバーのフォルダーにナビゲートして、Mac および Linux では `./run.sh`、Windows では `run.cmd` のコマンドを実行してください。

### 2. アプリケーションの作成
{: #2-creating-an-application }
ブラウザー・ウィンドウで、URL `http://your-server-host:server-port/mfpconsole` をロードして {{ site.data.keys.mf_console }} を開きます。ローカルで実行している場合は、[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) を使用します。ユーザー名/パスワードは *admin/admin* です。
 
1. **アプリケーション**の隣の**「新規」**ボタンをクリックします。
    * **Android** プラットフォームを選択します。
    * **com.ibm.mfpstarterandroid** を**アプリケーション ID** として入力します。
    * **1.0** を **version** の値として入力します。
    * **「アプリケーションの登録」**をクリックします。

    <img class="gifplayer" alt="アプリケーションの登録" src="register-an-application-android.png"/>
 
2. **「スターター・コードの取得」**タイルをクリックして、Android サンプル・アプリケーションをダウンロードすることを選択します。

    <img class="gifplayer" alt="サンプル・アプリケーションのダウンロード" src="download-starter-code-android.png"/>

### 3. アプリケーション・ロジックの編集
{: #3-editing-application-logic }
1. Android Studio プロジェクトを開いて、プロジェクトをインポートします。

2. **「プロジェクト (Project)」**サイドバー・メニューから、**「app」→「Java」→「com.ibm.mfpstarterandroid」→「ServerConnectActivity.java」**ファイルを選択します。

* 以下のインポートを追加します。

  ```java
  import java.net.URI;
  import java.net.URISyntaxException;
  import android.util.Log;
  ```
    
* 以下のコード・スニペットを貼り付けて、`WLAuthorizationManager.getInstance().obtainAccessToken` への呼び出しを置換します。

  ```java
  WLAuthorizationManager.getInstance().obtainAccessToken("", new WLAccessTokenListener() {
                @Override
                public void onSuccess(AccessToken token) {
                    System.out.println("Received the following access token value: " + token);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Yay!");
                            connectionStatusLabel.setText("Connected to {{ site.data.keys.mf_server }}");
                        }
                    });

                    URI adapterPath = null;
                    try {
                        adapterPath = new URI("/adapters/javaAdapter/resource/greet");
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }

                    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
                    
                    request.setQueryParameter("name","world");
                    request.send(new WLResponseListener() {
                        @Override
                        public void onSuccess(WLResponse wlResponse) {
                            // Will print "Hello world" in LogCat.
                            Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
                        }

                        @Override
                        public void onFailure(WLFailResponse wlFailResponse) {
                            Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
                        }
                    });
                }

                @Override
                public void onFailure(WLFailResponse wlFailResponse) {
                    System.out.println("Did not receive an access token from server: " + wlFailResponse.getErrorMsg());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Bummer...");
                            connectionStatusLabel.setText("Failed to connect to {{ site.data.keys.mf_server }}");
                        }
                    });
                }
            });
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

<img src="androidQuickStart.png" alt="サンプル・アプリケーション" style="float:right"/>
### 5. アプリケーションのテスト
{: #5-testing-the-application }

1. Android Studio で、**「プロジェクト (Project)」**サイドバー・メニューで、**「app」→「src」→「main」→「assets」→「mfpclient.properties」**ファイルを選択し、ご使用の {{ site.data.keys.mf_server }} の正しい値で **protocol**、**host**、および **port** の各プロパティーを編集します。
    * ローカル {{ site.data.keys.mf_server }} を使用している場合、通常、値は **http**、**localhost**、および **9080** です。
    * リモート {{ site.data.keys.mf_server }} (Bluemix 上) を使用している場合、通常、値は **https**、**your-server-address**、および **443** です。

    あるいは、{{ site.data.keys.mf_cli }} がインストール済みの場合は、プロジェクト・ルート・フォルダーにナビゲートし、コマンド `mfpdev app register` を実行します。リモート {{ site.data.keys.mf_server }} が使用されている場合は、 [コマンド `mfpdev server add` を実行して](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)サーバーを追加し、続いて、例えば、`mfpdev app register myBluemixServer` を実行します。

2. **「アプリケーションの実行 (Run App)」**ボタンをクリックします。  

<br clear="all"/>
### 結果
{: #results }
* **「{{ site.data.keys.mf_server }} への ping (Ping MobileFirst Server)」**ボタンをクリックすると、**「{{ site.data.keys.mf_server }} に接続されています (Connected to MobileFirst Server)」**が表示されます。
* アプリケーションが {{ site.data.keys.mf_server }} に接続できた場合は、デプロイした Java アダプターを使用してリソース要求呼び出しが行われます。

その場合、アダプター応答が Android Studio の LogCat ビューに出力されます。

![ {{ site.data.keys.mf_server }} からリソースを正常に呼び出したアプリケーションのイメージ](success_response.png)

## 次の手順
{: #next-steps }
アプリケーションでのアダプターの使用、プッシュ通知などの追加のサービスを統合する方法、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの使用などについて学習します。 

- [アプリケーションの開発](../../application-development/)チュートリアルを検討する
- [アダプターの開発](../../adapters/)チュートリアルを検討する
- [認証およびセキュリティー・チュートリアル](../../authentication-and-security/)を検討する
- [通知チュートリアル](../../notifications/)を検討する
- [すべてのチュートリアル](../../all-tutorials)を検討する
