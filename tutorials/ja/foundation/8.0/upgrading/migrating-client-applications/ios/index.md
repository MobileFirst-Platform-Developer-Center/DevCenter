---
layout: tutorial
title: 既存の iOS アプリケーションのマイグレーション
breadcrumb_title: iOS
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst™ Platform Foundation バージョン 6.2.0 以降で作成された既存のネイティブ iOS プロジェクトをマイグレーションするには、現行バージョンの SDK を使用するようにプロジェクトを変更する必要があります。 次に、v8.0 で使用が中止された、または v8.0 に含まれていないクライアント・サイド API を置き換えます。 マイグレーション・アシスト・ツールはコードをスキャンし、置き換える API のレポートを生成できます。

#### ジャンプ先
{: #jump-to }
* [バージョンアップの前準備として既存の {{ site.data.keys.product_adj }} ネイティブ iOS アプリケーションをスキャン](#scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade)
* [既存の iOS プロジェクトを手動でマイグレーション](#migrating-an-existing-ios-project-manually)
* [既存のネイティブ iOS プロジェクトを CocoaPods を使用してマイグレーション](#migrating-an-existing-native-ios-project-with-cocoapods)
* [iOS での暗号化のマイグレーション](#migrating-encryption-in-ios)
* [iOS コードの更新](#updating-the-ios-code)

## バージョンアップの前準備として既存の {{ site.data.keys.product_adj }} ネイティブ iOS アプリケーションをスキャン
{: #scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade }
マイグレーション・アシスト・ツールは、Swift または Objective-C を使用して開発されたネイティブ iOS アプリケーションのソースをスキャンし、V8.0 で非推奨または使用中止となった API のレポートを生成することにより、以前のバージョンの IBM MobileFirst™ Platform Foundation で作成されたアプリケーションのマイグレーションの準備を支援します。

マイグレーション・アシスト・ツールを使用する前に、以下の情報を知っておくことが重要です。

* 既存の IBM MobileFirst Platform Foundation ネイティブ iOS アプリケーションがある必要があります。
* インターネット・アクセスが必要です。
* node.js バージョン 4.0.0 以降がインストールされている必要があります。
* マイグレーション・プロセスの制限についてよく読み、理解します。 詳しくは、[以前のリリースからのアプリケーションのマイグレーション](../)を参照してください。

以前のバージョンの IBM MobileFirst Platform Foundation で作成されたアプリケーションは、一部変更を行わないと {{ site.data.keys.product }} 8.0 ではサポートされません。 マイグレーション・アシスト・ツールは、既存バージョンのアプリケーションのソース・ファイルをスキャンすることによりこのプロセスを簡素化し、V8.0 で非推奨となった API、非サポート対象となった API、または変更された API を識別します。

マイグレーション・アシスト・ツールでは、アプリケーションの開発者コードおよびコメントの変更や移動は行いません。

1. 以下のいずれかの方法を使用してマイグレーション・アシスト・ツールをダウンロードします。
    * [Git リポジトリー](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)から .tgz ファイルをダウンロードします。
    * {{ site.data.keys.mf_console }} から {{ site.data.keys.mf_dev_kit }} をダウンロードします。これには、**mfpmigrate-cli.tgz** という名前のファイルとしてマイグレーション・アシスト・ツールが含まれています。
2. マイグレーション・アシスト・ツールをインストールします。
    * ツールをダウンロードしたディレクトリーに移動します。
    * 以下のコマンドを入力することにより、NPM を使用してツールをインストールします。

   ```bash
   npm install -g
   ```

3. 以下のコマンドを入力して、IBM MobileFirst Platform Foundation アプリケーションをスキャンします。

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type ios
   ```

    **source_directory**  
    このバージョンのプロジェクトの現在のロケーション。

    **destination_directory**  
    レポートが作成されるディレクトリー。  
    <br/>
    マイグレーション・アシスト・ツールを scan コマンドと共に使用すると、ツールは、既存の IBM MobileFirst Platform Foundation アプリケーション内にある、V8.0 で削除された API、非推奨となった API、または変更された API を識別し、識別された宛先ディレクトリーにそれらを保存します。

## 既存の iOS プロジェクトを手動でマイグレーション
{: #migrating-an-existing-ios-project-manually }
Xcode プロジェクト内の既存のネイティブ iOS プロジェクトを手動でマイグレーションし、{{ site.data.keys.product }} V8.0 での開発を続行します。

開始前に、以下が必要です。

* Xcode 7.0 (iOS 9) 以降で作業している。
* IBM MobileFirst Platform Foundation 6.2.0 以降で作成された既存のネイティブ iOS プロジェクトがある。
* V8.0.0 {{ site.data.keys.product_adj }} iOS SDK ファイルのコピーにアクセスできなければならない。

1. **「Build Phases」**セクションの**「Link Binary With Libraries」**タブで静的ライブラリー **libWorklightStaticLibProjectNative.a** への既存のすべての参照を削除します。
2. **WorklightAPI** フォルダーから Headers フォルダーを削除します。
3. **「Build Phases」**セクションの**「Link Binary With Libraries」**タブで、必要なメイン・フレームワーク **IBMMobileFirstPlatformFoundation.framework** ファイルをリンクします。

    このフレームワークは、コア {{ site.data.keys.product_adj }} 機能を提供します。 同様に、[オプション機能用の他のフレームワーク](../../../application-development/sdk/ios/#manually-adding-the-mobilefirst-native-sdk)を追加できます。

4. 上記ステップと同様に、**「Build Phases」**タブの**「Link Binary With Libraries」**セクションで以下のリソースをプロジェクトにリンクします。
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * Security.framework
    * 注: 一部のフレームワークが既にリンクされている可能性があります。
        * libstdc++.6.tbd
        * libz.tbd
        * libc++.tbd
5. ヘッダー検索パスから **$(SRCROOT)/WorklightAPI/include** を削除します。
6. ヘッダーの既存の {{ site.data.keys.product_adj }} import をすべて、次の新しいアンブレラ・ヘッダーの単一エントリーに置換します。
    * Objective-C:

      ```objc
      #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
      ```
    * Swift:

      ```swift
      import IBMMobileFirstPlatformFoundation
      ```

これで、{{ site.data.keys.product }}、V8.0 iOS SDK で機能するようにアプリケーションがアップグレードされました。

#### 次の作業
{: #what-to-do-next }
使用が中止された、または V8.0 に含まれていないクライアント・サイド API を置き換えます。

## 既存のネイティブ iOS プロジェクトを CocoaPods を使用してマイグレーション
{: #migrating-an-existing-native-ios-project-with-cocoapods }
CocoaPods 使用して {{ site.data.keys.product }} iOS SDK を入手し、プロジェクト構成を変更することにより、V8.0 で動作するように既存のネイティブ iOS プロジェクトをマイグレーションします。

> **注:** {{ site.data.keys.product_adj }} の開発は、iOS 8.0 以降を使用して Xcode バージョン 7.1 以降でサポートされます。

以下が必要です。

* 開発環境にインストールされた CocoaPods。
* 開発環境に iOS 8.0 以上がインストールされている Xcode 7.1。
* MobileFirst 6.2 以降と統合されたアプリケーション。

SDK には、必須の SDK とオプションの SDK があります。 必須またはオプションの SDK にはそれぞれ、独自の pod があります。  
必須の IBMMobileFirstPlatformFoundation pod は、システムのコアです。 これは、クライアントとサーバー間の接続を実装し、セキュリティー、分析、およびアプリケーション管理を処理します。

以下のオプションの pod は、追加機能を提供します。

| Pod | 機能 |
|-----|---------|
| IBMMobileFirstPlatformFoundationPush | プッシュを有効にするための IBMMobileFirstPlatformFoundationPush フレームワークを追加します。 |
| IBMMobileFirstPlatformFoundationJSONStore | JSONStore 機能を実装します。 アプリケーションで JSONStore 機能を使用する予定である場合は、Podfile でこの pod を組み込みます。 |
| IBMMobileFirstPlatformFoundationOpenSSLUtils | {{ site.data.keys.product_adj }} 組み込み OpenSSL 機能を含んでおり、openssl フレームワークを自動的にロードします。 {{ site.data.keys.product_adj }} で提供されている OpenSSL を使用する予定である場合は、Podfile でこの pod を組み込みます。 |

1. Xcode でプロジェクトを開きます。
2. Xcode プロジェクトから **WorklightAPI** フォルダーを削除します (ごみ箱へ移動します)。
3. 以下の方法で、既存のコードを変更します。
    * ヘッダー検索パスから **$(SRCROOT)/WorklightAPI/include** を削除します。
    * **$(PROJECTDIR)/WorklightAPI/frameworks** をフレームワーク検索パスから削除します。
    * 静的ライブラリー **librarylibWorklightStaticLibProjectNative.a** の参照をすべて削除します。
4. **「Build Phases」**タブで、次のフレームワークおよびライブラリーへのリンクを削除します (これらは、CocoaPods によって自動的に再び追加されます)。
    * libWorklightStaticLibProjectNative.a
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * CoreData.framework
    * CoreLocation.framework
    * Security.framework
    * sqlcipher.framework
    * libstdc++.6.dylib
    * libz.dylib
5. Xcode を閉じます。
6. CocoaPods から {{ site.data.keys.product_adj }} iOS SDK を取得します。 SDK を取得するには、以下のステップを実行します。
    * 新規 Xcode プロジェクトのロケーションで**「Terminal」**を開きます。
    * `pod init` コマンドを実行して **Podfile** ファイルを作成します。
    * テキスト・エディターを使用して、プロジェクトのルートにある Podfile ファイルを開きます。
    * 既存の内容をコメント化するか削除します。
    * iOS バージョンを含め、以下の行を追加し、変更を保存します。

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      ```

    * アプリケーションで、pod が提供する追加機能を使用する必要がある場合は、上記リストからファイルに追加の pod を指定します。 例えば、アプリケーションで OpenSSL を使用する場合、**Podfile** は以下のようになります。

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationOpenSSLUtils'
      ```

      > **注:** 上記の構文は、**IBMMobileFirstPlatformFoundation** pod の最新バージョンをインポートします。 {{ site.data.keys.product_adj }} の最新バージョンを使用しない場合は、メジャー番号、マイナー番号、パッチ番号を含んだ完全なバージョン番号を追加する必要があります。 パッチ番号は、YYYYMMDDHH という形式です。 例えば、**IBMMobileFirstPlatformFoundation** pod の特定のパッチ・バージョンである 8.0.2016021411 をインポートする場合は、以下のような行になります。

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '8.0.2016021411'
      ```

      あるいは、マイナー・バージョン番号の最新パッチを取得する場合の構文は、以下のようになります。

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '~>8.0.0'
      ```

    * Xcode プロジェクトが閉じていることを確認します。
    * `pod install` コマンドを実行します。

    このコマンドは、{{ site.data.keys.product_adj }} SDK **IBMMobileFirstPlatformFoundation.framework** と、Podfile に指定されている他のすべてのフレームワークおよびそれらの依存関係をインストールします。 次に、このコマンドは、pod プロジェクトを生成し、クライアント・プロジェクトを {{ site.data.keys.product_adj }} SDK と統合します。
7. コマンド・ラインから open **ProjectName.xcworkspace** と入力することによって、Xcode で **ProjectName.xcworkspace** ファイルを開きます。 このファイルは、**ProjectName.xcodeproj** ファイルと同じディレクトリーにあります。
8. ヘッダーの既存の {{ site.data.keys.product_adj }} import をすべて、次の新しいアンブレラ・ヘッダーの単一エントリーに置換します。

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundation
   ```

   プッシュまたは JSONStore を使用している場合は、独立した import を組み込む必要があります。

   #### プッシュ
   {: #push }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationPush/IBMMobileFirstPlatformFoundationPush.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationPush
   ```

   ##### JSONStore
   {: #jsonstore }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationJSONStore
   ```

9. **「Build Settings」**タブの**「Other Linker Flags」**で、`-ObjC` フラグの始めに `$(inherited)` を追加します。 以下に例を示します。

    ![$(inherited) を Xcode Build Settings の ObjC フラグに追加](add_inherited_to_ObjC.jpg)

10. Xcode 7 以降、TLS の適用が必須になりました。「iOS アプリケーションでの TLS セキュア接続の強制」を参照してください。  

<br/>
これで、{{ site.data.keys.product }}、V8.0 iOS SDK で機能するようにアプリケーションがアップグレードされました。

#### 次のステップ
{: #what-next }
使用が中止された、または V8.0 に含まれていないクライアント・サイド API を置き換えます。

## iOS での暗号化のマイグレーション
{: #migrating-encryption-in-ios }
iOS アプリケーションで OpenSSL 暗号化を使用していた場合、アプリケーションを新しい V8.0 ネイティブ暗号化にマイグレーションできます。 また、OpenSSL の使用を継続する場合は、追加のフレームワークをいくつかインストールする必要があります。

マイグレーションに関する iOS 暗号化オプションについて詳しくは、[iOS でのOpenSSL の有効化](../../../application-development/sdk/ios/additional-information/#enabling-openssl-for-ios)を参照してください。

## iOS コードの更新
{: #updating-the-ios-code }
iOS フレームワークを更新し、必要な構成変更を行った後に、ご使用の特定のアプリケーション・コードにいくつかの問題が発生することがあります。  
次の表に iOS API の変更をリストします。

| API エレメント | マイグレーション・パス |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>[WLClient getWLDevice][WLClient transmitEvent:]</code></li><li><code>[WLClient setEventTransmissionPolicy]</code></li><li><code>[WLClient purgeEventTransmissionBuffer]</code></li></ul>{:/} | 地理位置情報は削除されました。 GeoLocation 用のネイティブ iOS またはサード・パーティー・パッケージを使用してください。 |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 代替はありません。 |
| `WL.Client.deleteUserPref(key, options)` | 代替はありません。 アダプターおよび [`MFP.Server.getAuthenticatedUser`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser:) を使用してユーザー設定を管理することができます。 |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:) を使用してください。 |
| `[WLClient login:withDelegate:]` | [`WLAuthorizationManager login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/login:withCredentials:withCompletionHandler:) を使用してください。 |
| `[WLClient logout:withDelegate:]` | [`WLAuthorizationManager logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/logout:withCompletionHandler:) を使用してください。 |
| {::nomarkdown}<ul><li><code>[WLClient lastAccessToken]</code></li><li><code>[WLClient lastAccessTokenForScope:]</code></li></ul>{:/} | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:) を使用してください。 |
| {::nomarkdown}<ul><li><code>[WLClient obtainAccessTokenForScope:withDelegate:]</code></li><li><code>[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]</code></li></ul>{:/} | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:) を使用してください。 |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | IBMMobileFirstPlatformFoundationPush フレームワークの [iOS アプリケーション用 Objective-C クライアント・サイド・プッシュ API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps) を使用してください。 |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | IBMMobileFirstPlatformFoundationPush フレームワークの [iOS アプリケーション用 Objective-C クライアント・サイド・プッシュ API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps) を使用してください。 |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | 非推奨。 代わりに [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:) を使用してください。 |
| `[WLClient sendUrlRequest:delegate:]` | 代わりに [`[WLResourceRequest sendWithDelegate:delegate]`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:) を使用してください。 |
| `[WLClient (void) logActivity:(NSString *) activityType]`	| 削除されました。 Objective C ロガーを使用してください。 |
| {::nomarkdown}<ul><li><code>[WLSimpleDataSharing setSharedToken: myName value: myValue]</code></li><li><code>[WLSimpleDataSharing getSharedToken: myName]]</code></li><li><code>[WLSimpleDataSharing clearSharedToken: myName]</code></li></ul>{:/} | OS API を使用して、アプリケーション間でトークンを共有してください。 |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/BaseChallengeHandler.html?view=kc) を使用します。 |
| `BaseProvisioningChallengeHandler` | 代替はありません。 デバイス・プロビジョニングは、自動的にセキュリティー・フレームワークによって処理されるようになりました。 |
| `ChallengeHandler` | カスタム・ゲートウェイ・チャレンジには、[`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc) を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、[`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc) を使用します。 |
| `WLChallengeHandler` | [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc) を使用します。 |
| `ChallengeHandler.isCustomResponse()` | [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc) を使用します。 |
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、[`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc) を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、[`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc) を使用します。 |
