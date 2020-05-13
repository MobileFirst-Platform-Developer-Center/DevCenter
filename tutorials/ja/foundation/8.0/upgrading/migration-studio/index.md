---
layout: tutorial
title: Migration Studio
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Mobile Foundation Migration Studio
{: #mf-migration-studio}

> [Mobile Foundation Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip) をダウンロードします。

## Migration Studio とは
{: #what-is-migration-studio}

Mobile Foundation Migration Studio プラグインは、MobileFirst Platform Foundation v7.1 でハイブリッド・プロジェクトのインプレース・アップグレードを実行する Eclipse プラグインであり、それらのプロジェクトを Mobile Foundation v8 サーバーに接続できるようにします。このプラグインは MobileFirst v7.1 Studio プラグインと似ていて、MobileFirst Platform Foundation v7.1 Studio と同じサポート対象環境にインストールできます。

## Migration Studio を使用する理由
{: #why-use-migration-studio}

Mobile Foundation Migration Studio プラグインは、既存の MobileFirst Platform Foundation v7.1 ハイブリッド・アプリケーションのアップグレードを可能にするクイック・パスを提供し、これらのアプリケーションが Mobile Foundation v8 で機能するようにします。

> Mobile Foundation Migration Studio による Mobile Foundation v8 へのマイグレーションには制限があるため、標準のマイグレーション・アプローチを優先する必要があります。

## Migration Studio の使用と標準マイグレーション・アプローチの比較
{: #compare-with-standard-migration}

[マイグレーションの手引き]({{site.baseurl}}/tutorials/en/foundation/8.0/upgrading/migration-cookbook/)に記載されているように、MobileFirst Platform Foundation v7.1 ハイブリッド・アプリケーションに標準マイグレード・アプローチを実行すると、結果として、Mobile Foundation v8 サーバーに接続する本格的な Cordova アプリケーションが得られます。しかし、Migration Studio アプローチでは、アプリケーションのレガシー・ハイブリッド構造 (つまり、Cordova プラグインが組み込まれた MobileFirst プロジェクト) が維持されます。このため、Migration Studio を使用してマイグレーションされたアプリケーションは、従来型の Mobile Foundation v8.0 アプリケーションが利用できる全範囲の機能を持つことにはなりません。既知の制限をすべて示すリストついては、この[セクション](#known-limitations-of-migration-studio)を参照してください。  

## Migration Studio の開始
{: #get-started-with-migration-studio}

Migration Studio の使用を開始するには、以下のタスクを実行する必要があります。

* **タスク 1**: プロジェクトをセットアップします。

  このタスクを完了するには、以下のステップを実行します。

  1. MobileFirst Platform Foundation v7.1 Studio プラグインによってサポートされているバージョンの Eclipse をインストールします。

  2. [Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip) をダウンロードし、ご使用の Eclipse IDE にこのプラグインをインストールします。このステップは、 MobileFirst Platform Foundation v7.1 Studio プラグインのインストールと同じです。
     > **重要:** 既存の MobileFirst Studio インストール済み環境上でインプレース・アップグレードを行わないでください。

  3. **「ファイル」>「インポート」>「ファイル・システム」**オプションを使用して、MobileFirst Platform Foundation v7.1 プロジェクトを Mobile Foundation Migration Studio にインポートします。別の方法として、プロジェクトを既にファイル・システムにエクスポートした場合は、エクスポート済みの `.zip` ファイルをインポートできます。Migration Studio のインターフェースが MobileFirst Platform Foundation v7.1 Studio によく似ていることがわかります。

  4. 環境フォルダーのバックアップを保存します (android、iphone、ipad)。`application-descriptor.xml` を開き、これらの環境を削除します。すべてのワークスペース・リソースを削除するオプションを選択します。
  ![Set up your project](set-up-project.gif)

  5. 環境を再びプロジェクトに追加し、ビルドが完了するのを待ちます。前のプロジェクトでネイティブ・プロジェクトにカスタマイズ (例えば、カスタム Cordova プラグインの追加など) を行っていた場合は、このステップで同じカスタマイズを繰り返す必要があります。
  > Migration Studio はプロジェクト内で Cordova のバージョンをアップグレードするため、既存のサード・パーティー Cordova プラグインの一部で、新規バージョンの Cordova との互換性がなくなる可能性があります。そのような場合は、プラグインに使用可能な更新を調べ、Cordova プラグインを適切なバージョンに更新します。

* **タスク 2**: アプリケーションをセットアップします。

  このタスクを完了するには、以下のステップを実行します。

  1. カスタム・チャレンジ・ハンドラーは、Mobile Foundation v8 のチャレンジ・ハンドラー・フレームワークで機能するよう変更されます。ただし、Mobile Foundation v8.0 のセキュリティー検査に適合させるために、チャレンジ・ハンドラーの `createChallengeHandler` メソッドと、チャレンジに送信される応答を変更する必要があります。
      **7.1 アプリケーション**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginRealm");
      options.parameters = {
              j_username : $('#AuthUsername').val(),
              j_password : $('#AuthPassword').val()
       };
      ```

      **マイグレーションされたアプリケーション**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginSecurityCheck");
      options.parameters = {
              username : $('#AuthUsername').val(),
              password : $('#AuthPassword').val()
       };
      ```

      >**注**: パラメーターと名前は、セキュリティー検査を構成する方法によって異なります。

  2. [**オプション**] アプリケーションに複数の html ページがある場合は、それぞれの html ファイルを編集し、新規プロジェクトで機能するように JavaScript ファイルと CSS ファイルへのパス参照を編集してください。

* **タスク 3**: Mobile Foundation v8.0 を構成します。

  このタスクを完了するには、以下のステップを実行します。

  1. Mobile Foundation v8 サーバーを始動し (Mobile Foundation の OpenShift Container Platform インストール済み環境または Mobile Foundation の従来型オンプレミス・インストール済み環境のどちらかにある Mobile Foundation v8 DevKit サーバーを使用)、アプリケーションを Mobile Foundation v8 サーバーに登録します。v8 Cordova アプリケーションの登録について詳しくは、[こちら](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/cordova/#2-creating-and-registering-an-application)を参照してください。

  2. アダプターと、認証モジュールまたはログイン・モジュールをマイグレーションしてから、Mobile Foundation インスタンスにデプロイします。アダプターのマイグレーションについて詳しくは、この[セクション](../migrating-adapters/)を参照してください。

* **タスク 4**: アプリケーションを実行します。

  このタスクを完了するには、以下のステップを実行します。

  **Android**

  1. Android Studio (3.2 以上) を開きます。
  2. **「Open an existing Android Studio Project」**をクリックし、フォルダー `Eclipse Workspace/<ProjectName>/apps/<AppName>/android/native` に移動します。
  3. すべてのプロンプトを受け入れて、Gradle ラッパーを再作成するか、Gradle ラッパーのバージョンをアップグレードまたは変更します。さらに、すべてのプロンプトを受け入れて、ファイルの読み取り専用状態をクリアします。
  4. **「Project」**ビューで `mfpclient.properties` ファイルに移動し、サーバー接続パラメーターを変更します。
  5. プロジェクトを実行します。必要であれば、`compileSdk` のバージョンを変更し、`build.gradle` ファイルでツールをビルドします。
  6. プッシュ通知を使用している場合は、`google-services.json` ファイルを生成し、プロジェクト内でそれを置換する必要があります。詳しくは、この[ブログ投稿]({{site.baseurl}}/blog/2018/10/09/FCM-Support-in-MFP-7.1-Android/)を参照してください。

  **iOS**

  1. XCode を使用して、`Eclipse_Workspace/<ProjectName>/apps/<AppName>/iphone/native` にある iOS ネイティブ・プロジェクトを開きます。
  2. **「Project」**ビューで `mfpclient.plist` ファイルに移動し、サーバー接続パラメーターを変更します。
  3. アプリケーションでプッシュ通知機能を使用している場合は、Xcode プロジェクト設定でプッシュ通知機能を使用可能にして、有効なプロビジョニング・プロファイルを追加します。詳しくは、[こちら]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/handling-push-notifications/cordova/#ios-platform)を参照してください。
  4. iOS の場合は追加構成は不要で、XCode からプロジェクトを実行できます。
  > iPad 環境がある場合は、同じステップに従います。

  >**注**: どの環境 (Android、iOS、iPad) でも、アプリケーションをビルドして実行する前に、アプリケーションの詳細情報 (バージョン、パッケージ名またはバンドル ID など) を用いて `static_app_props.js` (`www/default/plugins/cordova-plugin-mfp/worklight`) ファイルを変更する必要があります。

## Migration Studio の既知の制限
{: #known-limitations-of-migration-studio}

* Migration Studio は、Android、iPhone、iPad の各環境のみアップグレードします。他の環境はアップグレードしません。
* このプラグインでは、プレビューはサポートされません。
* Migration Studio は、`cordova-android` の組み込みバージョンを 8.1.0 にアップグレードし、`cordova-ios` を 5.1.1 にアップグレードします。このバージョンは固定されており、変更できません。
* デフォルトのスキンのみサポートされます。
* このプロジェクトでは、直接更新パッケージを MobileFirst サーバーに発行することはできません。
* このリリースでは、JSON Store API はまだサポートされていません。
  > **注**: JSON Store は、ファイルを手動でプロジェクトに追加することでまだ使用できます。つまり、`cordova-plugin-mfp-jsonstore` をプラグイン・フォルダーに追加し、プラグイン参照を `cordova_plugins.js` ファイルに追加し、必要な JAR/Framework ファイルをアタッチします。

* Mobile Foundation v8.0 の新機能はサポートされません。
* [非推奨または廃止された]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes) API は、変更された動作となります。動作の変更について詳しくは、次のセクションを参照してください。

## JSONStore を使用したアプリケーションのマイグレーション
{: #migrating-apps-using-jsonstore}

JSONStore を使用した、アプリケーションからの JSONStore プラグインのマイグレーションは、Migration Studio では自動化されていません。以下のステップを実行して、JSONStore プロジェクトを手動でマイグレーションしてください。

[こちら](https://us-south.git.cloud.ibm.com/ibmmfpf/cordova-plugin-mfp-jsonstore/tree/master)から、`cordova-plugin-mfp-jsonstore` をダウンロードします。

### Android

1. 次の `cordova-plugin-mfp-jsonstore/bootstrap.js` ファイルと `cordova-plugin-mfp-jsonstore/worklight` フォルダーを `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/assets/www/default/plugins/cordova-plugin-mfp-jsonstore` フォルダーにコピーします。

2. `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/assets/www/default/cordova_plugins.js` ファイルを開き、JSONStore 用の以下のエントリーを `module.exports` 配列内に追加します。
 ```json
 {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
   }
 ```

3. ダウンロードした ``cordova-plugin-mfp-jsonstore/src/android/libs`` から ``<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/libs` フォルダーに依存関係 (JAR ファイルのみ) をコピーし、以下のエントリーを ``<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/build.gradle` ファイルの依存関係セクションに追加します。
   ```text
   compile files('libs/commons-codec.jar')
   compile files('libs/guava.jar')
   compile files('libs/jackson-core-asl.jar')
   compile files('libs/jackson-mapper-asl.jar')
   compile files('libs/ibmmobilefirstplatformfoundationjsonstore.jar')
   compile files('libs/sqlcipher.jar')
   ```

4. 以下のエントリーを `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/res/config.xml` ファイルに追加します。
   ```xml
   <feature name="StoragePlugin">        
   <param name="android-package" value="com.worklight.androidgap.jsonstore.dispatchers.StoragePlugin" />    
   </feature>
   ```

### iOS

1. 次の `cordova-plugin-mfp-jsonstore/bootstrap.js` ファイルと `cordova-plugin-mfp-jsonstore/worklight` フォルダーを `<ProjectName>/apps/<AppName>/iphone/native/www/default/plugins/cordova-plugin-mfp-jsonstore` フォルダーにコピーします。

2. `<ProjectName>/apps/<AppName>/iphone/native/www/default/cordova_plugins.js` ファイルを開き、JSON Store 用の以下のエントリーを `module.exports` 配列内に追加します。
  ```JSON
  {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
      }
  ```
3. ダウンロードした `cordova-plugin-mfp-jsonstore /src/ios/Frameworks/IBMMobileFirstPlatformFoundationHybridJSONStore.framework から <ProjectName>/apps/<AppName>/iphone/native/Frameworks` フォルダーにフレームワークをコピーし、それを XCode の一般タブの **Frameworks、Libraries、Embedded Content** に追加します。

   >**注**: 既に XCode プロジェクトに存在する SQLCipher フレームワークは置き換えないでください。



## 非推奨または廃止された API の使用
{: #deprecated-n-discontinued-apis}

以下の API は廃止されたので、手動で代替 API に置換する必要があります。 
この置換について詳しくは、 [こちらの文書]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes)を参照してください。

| API |
|-----------------------|
|WL.App.BackgroundHandler|
|WL.Badge|
|WL.EncryptedCache|
|WL.TabBar|
|WL.TabBarItem|
|WL.Trusteer|
|WL.Client.createProvisioningChallengeHandler|
|WL.Client.createWLChallengeHandler|
|WL.SecurityUtils.remoteRandomString|

以下の API はサポートされなくなっていますが、呼び出されたときにエラー・メッセージがコンソールに表示されます。

| API |
|-----------------------|
|WL.Client.checkForDirectUpdate|
|WL.Client.close (android のみ)|
|WL.Client.getLoginName|
|WL.Client.getUserInfo|
|WL.Client.getUserName|
|WL.Client.getUserPref|
|WL.Client.getLoginName|
|WL.Client.isUserAuthenticated|
|WL.Client.getUserPref|
|WL.Client.setUserPrefs|
|WL.Client.hasUserPrefs|
|WL.Client.deleteUserPref|
|WL.Client.updateUserInfo|
|WL.Toast.show (android のみ)|
|WLAuthorizationManager.getUserIdentity|
|WLAuthorizationManager.getDeviceIdentity|
|WLAuthorizationManager.getAppIdentity|

## サポート
{: #ms-support}

Mobile Foundation Migration Studio は、MobileFirst Platform Foundation v7.1 から Mobile Foundation v8.0 へのマイグレーションを簡単に行うためのアドオンです。IBM サポート・ポータルで Case をオープンする通常の IBM サポート・プロセスは、Migration Studio に関連するいかなる問題にも適用されません。サポートについては、[IBM の Slack チャネルへの参加要求を]({{site.baseurl}}/blog/2017/05/26/come-chat-with-us/)を行うか、 [GitHub 問題](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/issues)をオープンしてください。
