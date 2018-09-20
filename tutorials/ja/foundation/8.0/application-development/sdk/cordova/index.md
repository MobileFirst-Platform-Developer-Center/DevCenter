---
layout: tutorial
title: Cordova アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、Apache Cordova、Ionic、またはその他のサード・パーティー・ツールを使用して作成された新規または既存の Cordova アプリケーションに {{ site.data.keys.product_adj }} SDK を追加する方法について学習します。 また、アプリケーションを認識するように {{ site.data.keys.mf_server }} を構成する方法と、プロジェクト内で変更する {{ site.data.keys.product_adj }} 構成ファイルに関する情報を見つける方法についても学習します。

{{ site.data.keys.product_adj }} Cordova SDK は、Cordova プラグインのセットとして提供されており、[NPM に登録されています](https://www.npmjs.com/package/cordova-plugin-mfp)。  
入手可能なプラグインは次のとおりです。

* **cordova-plugin-mfp** - コアの SDKプラグイン
* **cordova-plugin-mfp-push** - プッシュ通知サポートを提供します
* **cordova-plugin-mfp-jsonstore** - JSONStore サポートを提供します
* **cordova-plugin-mfp-fips** - *Android のみ*。 FIPS サポートを提供します
* **cordova-plugin-mfp-encrypt-utils** - *iOS のみ*。 暗号化および暗号化解除がサポートされるようにします

#### サポート・レベル
{: #support-levels }
MobileFirst プラグインでサポートされる Cordova プラットフォームのバージョンは次のとおりです。

* cordova-ios: **>= 4.1.1 と < 5.0**
* cordova-android: **>= 6.1.2 と <= 7.0**
* cordova-windows: **>= 4.3.2 と < 6.0**

#### ジャンプ先:
{: #jump-to }
- [Cordova SDK コンポーネント](#cordova-sdk-components)
- [{{ site.data.keys.product_adj }} Cordova SDK の追加](#adding-the-mobilefirst-cordova-sdk)
- [{{ site.data.keys.product_adj }} Cordova SDK の更新](#updating-the-mobilefirst-cordova-sdk)
- [生成される {{ site.data.keys.product_adj }} Cordova SDK 成果物](#generated-mobilefirst-cordova-sdk-artifacts)
- [Cordova Browser プラットフォームのサポート](#cordova-browser-platform)
- [次に使用するチュートリアル](#tutorials-to-follow-next)

> **注:** Xcode 8 を使用する場合、iOS シミュレーターでの iOS アプリケーションの実行中は、**キーチェーン共有**機能が必須です。Xcode プロジェクトをビルドする前に、この機能を手動で有効にする必要があります。

## Cordova SDK コンポーネント
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
cordova-plugin-mfp プラグインは、Cordova 用のコア {{ site.data.keys.product_adj }} プラグインであり、必須です。 他の {{ site.data.keys.product_adj }} プラグインのいずれかをインストールすると、cordova-plugin-mfp プラグインも自動的にインストールされます (まだインストールされていない場合)。

> 次の Cordova プラグインは、cordova-plugin-mfp の依存関係としてインストールされます。
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
cordova-plugin-mfp-jsonstore プラグインを使用すると、アプリケーションで JSONstore を使用できるようになります。 JSONstore について詳しくは、[JSONStore に関するチュートリアル](../../jsonstore/cordova/)を参照してください。  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
cordova-plugin-mfp-push プラグインは、Android アプリケーション用の {{ site.data.keys.mf_server }} からプッシュ通知を使用するために必要な許可を提供します。 プッシュ通知を使用するための追加セットアップが必要です。 プッシュ通知について詳しくは、[プッシュ通知に関するチュートリアル](../../../notifications/)を参照してください。

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
cordova-plugin-mfp-fips  プラグインは、Android プラットフォームの FIPS 140-2 をサポートします。 詳しくは、[FIPS 140-2 サポートを参照してください](../../../administering-apps/federal/#fips-140-2-support)。

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
cordova-plugin-mfp-encrypt-utils  プラグインは、iOS プラットフォームを使用する Cordova アプリケーションの暗号化のための iOS OpenSSL フレームワークを提供します。 詳しくは、[Cordova iOS での OpenSSL の有効化](additional-information)を参照してください。

**前提条件:**

- [Apache Cordova CLI](https://www.npmjs.com/package/cordova) および {{ site.data.keys.mf_cli }} が開発者のワークステーションにインストールされている。
- {{ site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/development/mobilefirst)、および [Cordova 開発環境のセットアップ](../../../installation-configuration/development/cordova)の両チュートリアルを読む。
- cordova-windows の場合、マシンにインストールされている Visual Studio と .NET のバージョンと互換性のある Visual C++ のバージョンがインストールされている必要があります。
- Universal Windows アプリケーションの Windows Phone SDK 8.0 および Visual Studio Tools の場合、作成された cordova-windows アプリケーションが必要なすべてのサポート・ライブラリーを持つようにしてください。

## {{ site.data.keys.product }} Cordova SDK の追加
{: #adding-the-mobilefirst-cordova-sdk }
以下の手順に従って、新規または既存の Cordova プロジェクトに {{ site.data.keys.product }} Cordova SDKを追加し、そのプロジェクトを {{ site.data.keys.mf_server }} に登録します。

開始する前に、{{ site.data.keys.mf_server }} が稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、コマンド `./run.sh` を実行します。

> **注:** SDK を既存の Cordova アプリケーションに追加すると、プラグインによって、Android 用の `MainActivity.java` ファイルと iOS 用の `Main.m` ファイルが上書きされます。

### SDK の追加
{: #adding-the-sdk }
{{ site.data.keys.product_adj }} Cordova **アプリケーション・テンプレート**を使用することによってプロジェクトを作成することを検討します。 テンプレートを使用すると、{{ site.data.keys.product_adj }} 固有の必須プラグイン・エントリーが Cordova プロジェクトの **config.xml** ファイルに追加され、{{ site.data.keys.product_adj }} 固有の、使用準備の整った **index.js** ファイル ({{ site.data.keys.product_adj }} アプリケーション開発用に調整されている) が提供されます。

#### 新規アプリケーション
{: #new-application }
1. 次のコマンドで Cordova プロジェクトを作成します。`cordova create projectName applicationId applicationName --template cordova-template-mfp`  
   例えば、次のとおりです。

   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - 「Hello」は、アプリケーションのフォルダー名です。
     - 「com.example.helloworld」は、アプリケーションの ID です。
     - 「HelloWorld」は、アプリケーションの名前です。
     - --template を指定すると、{{ site.data.keys.product_adj }} 固有の追加によってアプリケーションが変更されます。

    > テンプレートとして用意された **index.js** を使用することで、[アプリケーションのマルチリンガル・トランスレーション](../../translation)や初期化オプションといった、{{ site.data.keys.product_adj }} の追加機能を使用できます (詳しくはユーザー向け資料を参照してください)。

2. `cd hello` コマンドで、ディレクトリーを Cordova プロジェクトのルートに変更します。

3. 次の Cordova CLI コマンドを使用して、サポートされているプラットフォームを 1 つ以上 Cordova プロジェクトに追加します。`cordova platform add ios|android|windows` 例えば、次のとおりです。

   ```bash
   cordova platform add ios
   ```

   > **注:** このアプリケーションは {{ site.data.keys.product_adj }} テンプレートを使用して構成されたため、ステップ 3 でプラットフォームが追加されたときに {{ site.data.keys.product_adj }} のコア Cordova プラグインが自動的に追加されます。

4. 次のように `cordova prepare コマンド`を実行することで、アプリケーション・リソースを準備します。

   ```bash
   cordova prepare
   ```

#### アプリケーションの終了
{: #existing-application }
1. 既存の Cordova プロジェクトのルートに移動し、次のように {{ site.data.keys.product_adj }} コア Cordova プラグインを追加します。

   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. **www\js** フォルダーに移動し、**index.js** ファイルを選択します。

3. 次の関数を追加します。

   ```javascript
   function wlCommonInit() {

   }
   ```

{{ site.data.keys.product_adj }} API メソッドは、{{ site.data.keys.product_adj }} クライアント SDK がロードされた後で使用可能になります。 これで `wlCommonInit` 関数が呼び出されます。  
この関数を使用して、各種 {{ site.data.keys.product_adj }} API メソッドを呼び出します。

### アプリケーションの登録
{: #registering-the-application }
1. **コマンド・ライン**・ウィンドウを開き、Cordova プロジェクトのルートに移動します。  

2. 次のコマンドで、{{ site.data.keys.mf_server }} にアプリケーションを登録します。

   ```bash
   mfpdev app register
   ```
    - リモート・サーバーを使用する場合は、[`mfpdev server add` コマンドを使用](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)して、そのサーバーを追加します。

`mfpdev app register` CLI コマンドは、まず最初に {{ site.data.keys.mf_server }} に接続してアプリケーションを登録した後、{{ site.data.keys.mf_server }} を識別するメタデータを使用して、Cordova プロジェクトのルートにある **config.xml** ファイルを更新します。

各プラットフォームはアプリケーションとして {{ site.data.keys.mf_server }} に登録されます。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** 次のように、{{ site.data.keys.mf_console }} からアプリケーションを登録することもできます。    
>
> 1. {{ site.data.keys.mf_console }} をロードします。  
> 2. **「アプリケーション」**の横の**「新規」**ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。  

### SDK の使用
{: #using-the-sdk }
{{ site.data.keys.product_adj }} API メソッドは、{{ site.data.keys.product_adj }} クライアント SDK がロードされた後で使用可能になります。 これで `wlCommonInit` 関数が呼び出されます。  
この関数を使用して、各種 {{ site.data.keys.product_adj }} API メソッドを呼び出します。

## {{ site.data.keys.product_adj }} Cordova SDK の更新
{: #updating-the-mobilefirst-cordova-sdk }
{{ site.data.keys.product_adj }} Cordova SDK を最新リリースで更新するには、`cordova plugin remove cordova-plugin-mfp` コマンドを実行して **cordova-plugin-mfp** プラグインを削除した後、`cordova plugin add cordova-plugin-mfp` コマンドを実行してこのプラグインを再度追加します。

SDK のリリースは、SDK の [NPM リポジトリー](https://www.npmjs.com/package/cordova-plugin-mfp)で調べることができます。

## 生成される {{ site.data.keys.product_adj }} Cordova SDK 成果物
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
Cordova 構成ファイルは、アプリケーション・メタデータを含む必須の XML ファイルであり、アプリケーションのルート・ディレクトリーに保管されています。  
{{ site.data.keys.product_adj }} Cordova SDK がプロジェクトに追加されると、Cordova が生成した **config.xml** ファイルは、名前空間 `mfp:` で識別された新規エレメントのセットを受け取ります。 追加されるエレメントには、{{ site.data.keys.product_adj }} の各種フィーチャーおよび {{ site.data.keys.mf_server }} に関連した情報が含まれています。

### **config.xml** ファイルに追加される {{ site.data.keys.product_adj }} 設定の例
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>クリックして config.xml プロパティーの完全なリストを表示</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>エレメント</b></td>
                        <td><b>説明</b></td>
                        <td><b>構成</b></td>
                    </tr>
                    <tr>
                        <td><b>widget</b></td>
                        <td><a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">config.xml 文書のルート・エレメント</a>。 このエレメントには 2 つの必須属性が含まれています。 <ul><li><b>id</b>: これは Cordova プロジェクト作成時に指定されたアプリケーション・パッケージ名です。 アプリケーションが {{ site.data.keys.mf_server }} に登録された後にこの値が手動で変更された場合、アプリケーションの再登録が必要です。</li><li><b>xmlns:mfp</b>: {{ site.data.keys.product_adj }} プラグインの XML 名前空間。</li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>必須。 アプリケーションが開発された製品バージョン。</td>
                        <td>デフォルトで設定されます。 変更してはなりません。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>オプション。 ダイレクト・アップデート認証性機能を有効にした場合、デプロイメント時にダイレクト・アップデート・パッケージがデジタル署名されます。 クライアントがパッケージをダウンロードした後、パッケージの認証性を検証するためにセキュリティー検査が実行されます。 このストリング値は、ダイレクト・アップデート .zip ファイルの認証に使用される公開鍵です。</td>
                        <td><code>mfpdev app config direct_update_authenticity_public_key key-value</code> コマンドで設定されます。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>オプション。 システム・メッセージの表示に使用されるロケールのコンマ区切りリストを含みます。</td>
                        <td><code>mfpdev app config language_preferences key-value</code> コマンドで設定されます。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td><code>WL.Client.init</code> メソッドがどのように呼び出されるのかを制御します。 デフォルトでは、この値は false に設定され、<code>WL.Client.init</code> メソッドは {{ site.data.keys.product_adj }} プラグインが初期化された後に自動的に呼び出されます。 <code>WL.Client.init</code> が呼び出されるタイミングをクライアント・コードで明示的に制御するには、この値を <b>true</b> に設定します。</td>
                        <td>手動で編集されます。 <b>enabled</b> 属性に設定できる値は <b>true</b> または <b>false</b> です。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>クライアント・アプリケーションが {{ site.data.keys.mf_server }} との通信に使用する、デフォルトのリモート・サーバー接続情報。 <ul><li><b>url:</b> url 値は、クライアントがサーバーに接続するためにデフォルトで使用する、{{ site.data.keys.mf_server }} プロトコル、ホスト、およびポートの値を指定します。</li><li><b>runtime:</b> runtime 値は、アプリケーションが登録された {{ site.data.keys.mf_server }} ランタイムを指定します。 {{ site.data.keys.product_adj }} ランタイムについて詳しくは、{{ site.data.keys.mf_server }} 概要を参照してください。</li></ul></td>
                        <td><ul><li>サーバー url 値は <code>mfpdev app config server</code> コマンドで設定されます。</li><li>サーバー runtime 値は <code>mfpdev app config runtime</code> コマンドで設定されます。</li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>このエレメントは、iOS プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>このエレメントは、Android プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>このエレメントは、Windows プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>このエレメントは、Windows 8.1 プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>このエレメントは、Windows 10 プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>このエレメントは、Windows Phone 8.1 プラットフォーム用のすべての {{ site.data.keys.product_adj }} 関連のクライアント・アプリケーション構成を含みます。
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>この値は、アプリケーション Web リソースのチェックサムです。 <code>mfpdev app webupdate</code> が実行されるときに計算されます。</td>
                        <td>ユーザーによる構成はできません。 チェックサム値は <code>mfpdev app webupdate</code> コマンドが実行されると更新されます。 <code>mfpdev app webupdate</code> コマンドについて詳しくは、コマンド・ウィンドウで <code>mfpdev help app webupdate</code> と入力してください。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>この値は、{{ site.data.keys.mf_console }} SDK チェックサムであり、固有の {{ site.data.keys.product_adj }} SDK レベルを識別するために使用されます。</td>
                        <td>ユーザーによる構成はできません。 この値はデフォルトで設定されます。</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>このエレメントには、{{ site.data.keys.product_adj }} セキュリティーについての、クライアント・アプリケーションのプラットフォーム固有構成が含まれます。 次を含む<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>アプリケーションがモバイル・デバイス上で実行を開始するたびにその Web リソースの保全性を検証するかどうかを制御します。 属性: <ul><li><b>enabled:</b> 有効な値は <b>true</b> および <b>false</b> です。 この属性が <b>true</b> に設定されている場合、アプリケーションは Web リソースのチェックサムを計算し、アプリケーションが最初に実行されたときに保存しておいた値とこのチェックサムを比較します。</li><li><b>ignoreFileExtensions:</b> チェックサム計算には、Web リソースのサイズによって、数秒かかる場合があります。 この時間を短縮するには、この計算において無視するファイル拡張子のリストを指定します。 この値は、<b>enabled</b> 属性が <b>false</b> の場合は無視されます。</li></ul></td>
                        <td><ul><li><b>enabled</b> enabled 属性は <code>mfpdev app config android_security_test_web_resources_checksum key-value</code> コマンドで設定されます。</li><li><b>ignoreFileExtensions</b> 属性は <code>mfpdev app config android_security_ignore_file_extensions value</code> コマンドで設定されます。</li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

### config.xml ファイルの {{ site.data.keys.product_adj }} 設定の編集
{: #editing-mobilefirst-settings-in-the-configxml-file }
{{ site.data.keys.mf_cli }} を使用して次のコマンドを実行することで、上記の設定を編集できます。

```bash
mfpdev app config
```
## Cordova Browser プラットフォームのサポート
{: #cordova-browser-platform}

MobileFirst Platform では、Cordova Windows、Cordova Android、および Cordova iOS のサポートされるプラットフォームと共に、Cordova Browser プラットフォームがサポートされるようになりました。

MobileFirst Platform (MFP) と共に Cordova Browser プラットフォームを使用することは、他のプラットフォームのいずれかと共に MFP を使用することに似ています。この機能を示すサンプルを以下に示します。

以下のコマンドを使用して、Cordova アプリケーションを作成します。
```bash
cordova create <your-appFolder-name> <package-name>
```
これによって、簡素な Cordova アプリが作成されます。

以下のコマンドを使用して、MFP プラグインを追加します。
```bash
cordova plugin add cordova-plugin-mfp
```
MFP サーバーを ping するために使用できるボタンを追加します (このサーバーは、ローカルにホストされているサーバーであっても、IBM Cloud にあるサーバーであってもかまいません)。 このボタンがクリックされたときに MFP サーバーを ping します。
以下のサンプル・コードを使用できます。

#### index.html

```html
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
  <meta name="format-detection" content="telephone=no">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">


  <link rel="stylesheet" type="text/css" href="css/index.css" />

  <!-- load script with wlCommonInit defined before loading cordova.js -->
  <script type="text/javascript" src="js/index.js"></script>
  <script type="text/javascript" src="cordova.js"></script>

  <title>MFP Starter - Cordova</title>
</head>

<body>

  <div id="main">
    <div id="main_title">Hello MobileFirst</div>
    <div id="main_status"></div>
    <div id="main_info"></div>
  </div>

  <div id="button_content">
    <button id="ping_button" style="display:none">Ping MobileFirst Server</button>
  </div>

</body>

</html>
```

#### index.js

```javascript

var Messages = {
  // Add here your messages for the default language.
  // Generate a similar file with a language suffix containing the translated messages.
  // key1 : message1,
};

var wlInitOptions = {
  // Options to initialize with the WL.Client object.
  // For initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development server
    applicationId : 'io.cordova.hellocordova' // Replace with your own app id/package name.
};

function wlCommonInit() {
  app.init();
}

var app = {
  //initialize app
  "init": function init() {
    var buttonElement = document.getElementById("ping_button");
    buttonElement.style.display = "block";
    buttonElement.addEventListener('click', app.testServerConnection, false);
  },
  //test server connection
  "testServerConnection": function testServerConnection() {

    var titleText = document.getElementById("main_title");
    var statusText = document.getElementById("main_status");
    var infoText = document.getElementById("main_info");
    titleText.innerHTML = "Hello MobileFirst";
    statusText.innerHTML = "Connecting to Server...";
    infoText.innerHTML = "";

    WLAuthorizationManager.obtainAccessToken()
      .then(
        function (accessToken) {
          titleText.innerHTML = "Yay!";
          statusText.innerHTML = "Connected to MobileFirst Server";
        },
        function (error) {
          titleText.innerHTML = "Bummer...";
          statusText.innerHTML = "Failed to connect to MobileFirst Server";
        }
        );
    },
 }

```

>**注:** index.js ファイルの **wlInitOptions** で `mfpContextRoot` および `applicationId` を記述することは重要です。

#### index.css

```css
body {
    position: static;
    font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    font-weight: 300;
    margin: 0px;
	padding: 0px;
}

#button_content {
  position: absolute;
  bottom: 10%;
  width: 100%;
}

#ping_button {
  display: block;
  margin: 0 auto;
  height: 50px;
  width: 240px;
  font-size: 20px;
  color: white;
  background-color: #325c80;
}

#main {
  top: 10%;
  position: absolute;
  text-align: center;
  width: 100%
}

#main_title {
  font-size: 40px;
}

#main_status {
  font-size: 20px;
  margin-top: 10px;
}

#main_info {
  font-size: 14px;
  margin-top: 10px;
}

```


以下のコマンドを使用して、Browser プラットフォームを追加します。
```bash
cordova platform add browser
```
<!--
 (Register the app to the MFP server. The **mfpdev-cli** from version -.-.- and above recognizes cordova browser applications as web platform applications. If you are using a lower version then you can either upgrade to the latest version or manually register your application. -->

> アプリケーションを手動で登録するには、以下のようにします。
>
* MFP サーバーのコンソールにログインします。
* _*「アプリケーション」*_オプションの横の**「新規」**ボタンをクリックします。
* アプリケーションの名前を指定し、プラットフォームとして**「Web」**を選択し、アプリケーションの ID (`index.js` 内の **wlInitOptions** 関数で定義されたもの) を指定します。
>
>**注意:** サーバー詳細をアプリケーションの `config.xml` に追加してください。

<!--If you are using **mfpdev-cli** (more about the `cli` commands can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/t_gs_cli.html)), add the MFP server using the following command:

```bash
mfpdev server add
```
Set it as the default server.

Register your application with the following command:

```bash
mfpdev app register
```
-->


 >**注:** ブラウザー・プラットフォーム・アプリを登録するための *mfpdev-cli* はまもなくリリースされる予定です。

次に、以下のコマンドを実行します。

```bash
cordova prepare
cordova build
cordova run
```

<!--This will launch two browsers. One of the browser runs on cordova browser's proxy server (that runs on port `8000`, generally) which cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)). The other browser would be an MFP proxy server (this runs on port `9081`) that will serve MFP requests.

If you click the button to ping MFP on the browser running on port `8000`, the ping will fail whereas clicking the button that runs on localhost port `9081` will be successful. All the cordova browser compatible cordova plugins and MFP features can be used without issues.-->

これにより、プロキシー・サーバー (ポート `9081`) で実行するブラウザーが起動され、MFP サーバーに接続されます。Cordova ブラウザーのデフォルトのプロキシー・サーバー (ポート `8000` で実行) は、[same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) が原因で MFP サーバーに接続できないため抑止されました。

> 実行されるデフォルト・ブラウザーは、**Chrome** に設定されます。 異なるブラウザー上で実行するには、以下のコマンドで `--target` オプションを使用できます。
```bash
 cordova run --target=Firefox
 ```

次のコマンドを使用して、アプリをプレビューできます。

```bash
mfpdev app preview
```

サポートされるブラウザー・オプションは*「Simple Browser Rendering」* のみです。*「Mobile Browser Support」*オプションは Browser プラットフォームではサポートされません。

### Cordova ブラウザー・リソースにサービス提供するための WebSphere Liberty の使用
{: #using-liberty-cordova-browser}

<a href="http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/">この</a>チュートリアルの WebSphere Liberty 使用手順に従い、以下の変更を行います。

このチュートリアルの『**Building the Maven webapp with the web application’s resources**』セクションのステップ 1 に記述されているように、ブラウザー・プロジェクトの `www` フォルダーの内容を `[MyWebApp] → src → Main → webapp ` に追加します。最後に、Liberty サーバーでアプリケーションを登録し、パス `localhost:9080/MyWebApp` を指定してブラウザーで実行することによってアプリケーションをテストします。また、`sjcl` フォルダーと `jssha` フォルダーを親フォルダーに追加し、`ibmmfpf.js` ファイル内でのそれらの参照を変更します。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで {{ site.data.keys.product_adj }} Cordova SDK が組み込まれたので、以下の作業を行うことができます。

- [{{ site.data.keys.product }} SDK の使用に関するチュートリアル](../)を検討する
- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
