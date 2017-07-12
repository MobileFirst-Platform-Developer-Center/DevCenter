---
layout: tutorial
title: Android アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} SDK は、[Maven Central](http://search.maven.org/) を通じて入手可能な依存関係の集合で構成されます。この SDK は、Android Studio プロジェクトに追加できます。これらの依存関係は、次のようなコア機能およびその他の機能に対応しています。

* **IBMMobileFirstPlatformFoundation** - クライアントとサーバー間の接続を実装し、認証およびセキュリティーの各側面、リソース要求、およびその他の必要なコア機能を処理します。
* **IBMMobileFirstPlatformFoundationJSONStore** - JSONStore のフレームワークを含んでいます。詳しくは、[Android 用 JSONStore に関するチュートリアル](../../jsonstore/android/)を参照してください。
* **IBMMobileFirstPlatformFoundationPush** - プッシュ通知のフレームワークを含んでいます。詳しくは、[通知に関するチュートリアル](../../../notifications/)を参照してください。

このチュートリアルでは、Gradle を使用して {{ site.data.keys.product_adj }} ネイティブ SDK を新規または既存の Android アプリケーションに追加する方法について学習します。また、アプリケーションを認識するように {{ site.data.keys.mf_server }} を構成する方法と、プロジェクトに追加する {{ site.data.keys.product_adj }} 構成ファイルに関する情報を見つける方法についても学習します。

**前提条件:**

- Android Studio と {{ site.data.keys.mf_cli }} が開発者のワークステーションにインストールされている。  
- {{ site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/development/mobilefirst)、および [Android 開発環境のセットアップ](../../../installation-configuration/development/android) の両チュートリアルを読む。

#### ジャンプ先:
{: #jump-to }
- [{{ site.data.keys.product_adj }} ネイティブ SDK の追加](#adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} ネイティブ SDK の手動での追加](#manually-adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} ネイティブ SDK の更新](#updating-the-mobilefirst-native-sdk)
- [生成される {{ site.data.keys.product_adj }} ネイティブ SDK 成果物](#generated-mobilefirst-native-sdk-artifacts)
- [Javadoc および Android Service のサポート](#support-for-javadoc-and-android-service)
- [次に使用するチュートリアル](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} ネイティブ SDK の追加
{: #adding-the-mobilefirst-native-sdk }
以下の手順に従って、新規または既存の Android Studio プロジェクトに {{ site.data.keys.product_adj }} ネイティブ SDK を追加し、アプリケーションを {{ site.data.keys.mf_server }} インスタンスに登録します。

開始する前に、{{ site.data.keys.mf_server }} が稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、次のコマンドを実行します。`./run.sh` (Mac または Linux OS の場合) または `run.cmd` (Windows の場合)

### Android アプリケーションの作成
{: #creating-an-android-application }
Android Studio プロジェクトを作成するか、または既存のプロジェクトを使用します。  

### SDK の追加
{: #adding-the-sdk }
1. **「Android」→「Gradle Scripts」**で、**build.gradle (Module: app)** ファイルを選択します。

2. 次の行を、`apply plugin: 'com.android.application'` の後に追加します。

   ```xml
   repositories{
        jcenter()
   }
   ```

3. 次の行を、`android` セクション内に追加します。

   ```xml
   packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
   }
   ```

4. 次の行を、`dependencies` セクション内に追加します。

   ```xml
   compile group: 'com.ibm.mobile.foundation',
   name: 'ibmmobilefirstplatformfoundation',
   version: '8.0.+',
   ext: 'aar',
   transitive: true
   ```

   または、次のように 1 行で追加します。

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
   ```

5. **「Android」→「app」→「manifests」**で、`AndroidManifest.xml` ファイルを開きます。次のアクセス権を、**application** エレメントの上に追加します。

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   ```

6. 既存の **activity** エレメントの後に、次の {{ site.data.keys.product_adj }} UI アクティビティーを追加します。

   ```xml
   <activity android:name="com.worklight.wlclient.ui.UIActivity" />
   ```

> Gradle Sync 要求が表示された場合は、同意します。

### {{ site.data.keys.product_adj }} ネイティブ SDK の手動での追加
{: #manually-adding-the-mobilefirst-native-sdk }
次のように、{{ site.data.keys.product_adj }} SDK を手動で追加することもできます。

<div class="panel-group accordion" id="adding-the-sdk" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>クリックして手順を表示</b></a>
            </h4>
        </div>

        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} SDK を手動で追加するには、まず最初に<b>「{{ site.data.keys.mf_console }}」→「ダウンロード・センター」→「SDK」</b>タブで SDK の .zip ファイルをダウンロードします。上記の手順を完了した後、以下の手順にも従います。</p>

                <ul>
                    <li>ダウンロードした .zip ファイルを解凍し、関連する aar ファイルを <b>app\libs</b> フォルダーに入れます。</li>
                    <li>次の行を <b>dependencies</b> クロージャーに追加します。
{% highlight xml %}
compile(name:'ibmmobilefirstplatformfoundation', ext:'aar')
compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'   
compile 'com.squareup.okhttp3:okhttp:3.4.1'
{% endhighlight %}
                    </li>
                    <li>次の行を <b>repositories</b> クロージャーに追加します。
{% highlight xml %}
repositories {
    flatDir {
        dirs 'libs'
    }
}
{% endhighlight %}
                    </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>



### アプリケーションの登録
{: #registering-the-application }
1. **コマンド・ライン**・ウィンドウを開き、Android Studio プロジェクトのルートに移動します。  

2. 次のコマンドを実行します:

    ```bash
    mfpdev app register
    ```
    - リモート・サーバーを使用する場合は、[`mfpdev server add` コマンドを使用](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)して、そのサーバーを追加します。

`mfpdev app register` CLI コマンドは、まず最初に {{ site.data.keys.mf_server }} に接続してアプリケーションを登録し、続けて **mfpclient.properties** ファイルを Android Studio プロジェクトの **[project root]/app/src/main/assets/** フォルダーに作成し、これに、{{ site.data.keys.mf_server }} を識別するメタデータを追加します。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** 次のように、{{ site.data.keys.mf_console }} からアプリケーションを登録することもできます。    
>
> 1. {{ site.data.keys.mf_console }} をロードします。  
> 2. **「アプリケーション」**の横の**「新規」**ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。  
> 3. アプリケーションが登録されたら、そのアプリケーションの**「構成ファイル」**タブに移動して、**mfpclient.properties** ファイルをコピーまたはダウンロードします。画面上に表示される指示に従って、ファイルをプロジェクトに追加します。

### WLClient インスタンスの作成
{: #creating-a-wlclient-instance }
{{ site.data.keys.product_adj }} API を使用する前に、次のように `WLClient` インスタンスを作成します。

```java
WLClient.createInstance(this);
```

**注:** `WLClient` インスタンスの作成は、アプリケーションのライフサイクル全体で一度だけ行います。このインスタンスの作成には、Android の Application クラスを使用することを推奨します。

## {{ site.data.keys.product_adj }} ネイティブ SDK の更新
{: #updating-the-mobilefirst-native-sdk }
{{ site.data.keys.product_adj }} ネイティブ SDK を最新リリースで更新するには、リリースのバージョン番号を調べ、**build.gradle** ファイル内の `version` プロパティーを適宜更新します。  
上記のステップ 4 を参照してください。

SDK のリリースは、SDK の [JCenter リポジトリー](https://bintray.com/bintray/jcenter/com.ibm.mobile.foundation%3Aibmmobilefirstplatformfoundation/view#)で調べることができます。

## 生成される{{ site.data.keys.product_adj }} ネイティブ SDK 成果物
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.properties
{: #mfpclient.properties }
Android Studio プロジェクトの **./app/src/main/assets/** フォルダー内に配置されているこのファイルは、{{ site.data.keys.mf_server }} に Android アプリケーションを登録するために使用される、クライアント・サイドのプロパティーを定義します。

| プロパティー            | 説明                                                         | 値の例 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | {{ site.data.keys.mf_server }} との通信プロトコル。             | http または https  |
| wlServerHost        | {{ site.data.keys.mf_server }} のホスト名。                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }} のポート。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上のアプリケーションのコンテキスト・ルート・パス。 | /mfp/          |
| languagePreferences | クライアントの SDK システム・メッセージのデフォルト言語を設定します。           | en             |

## Javadoc および Android Service のサポート
{: #support-for-javadoc-and-android-service }
Javadoc および Android Service のサポートについては、[追加情報](additional-information)のページを参照してください。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで {{ site.data.keys.product_adj }} ネイティブ SDK が組み込まれたので、以下の作業を行うことができます。

- [{{ site.data.keys.product }} SDK の使用に関するチュートリアル](../)を検討する
- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
