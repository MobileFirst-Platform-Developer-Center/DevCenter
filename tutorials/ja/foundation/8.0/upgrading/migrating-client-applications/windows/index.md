---
layout: tutorial
title: 既存の Windows アプリケーションのマイグレーション
breadcrumb_title: Windows
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst™ Platform Foundation バージョン 6.2.0 以降で作成された既存のネイティブ Windows プロジェクトをマイグレーションするには、現行バージョンの SDK を使用するようにプロジェクトを変更する必要があります。 次に、v8.0 で使用が中止された、または v8.0 に含まれていないクライアント・サイド API を置き換えます。 マイグレーション・アシスト・ツールはコードをスキャンし、置き換える API のレポートを生成できます。

#### ジャンプ先
{: #jump-to }
* [バージョンアップの前準備として既存の{{ site.data.keys.product_adj }} ネイティブ Windows アプリケーションをスキャン](#scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade)
* [Windows プロジェクトのマイグレーション](#migrating-a-windows-project)
* [Windows コードの更新](#updating-the-windows-code)

## バージョンアップの前準備として既存の {{ site.data.keys.product_adj }} ネイティブ Windows アプリケーションをスキャン
{: #scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade }
マイグレーション・アシスト・ツールは、ネイティブ Windows アプリケーションのソースをスキャンし、V8.0 で非推奨または使用中止となった API のレポートを生成することにより、以前のバージョンの IBM MobileFirst™ Platform Foundation で作成されたアプリケーションのマイグレーションの準備を支援します。

マイグレーション・アシスト・ツールを使用する前に、以下の情報を知っておくことが重要です。

* 既存の IBM MobileFirst Platform Foundation ネイティブ Windows アプリケーションがある必要があります。
* インターネット・アクセスが必要です。
* node.js バージョン 4.0.0 以降がインストールされている必要があります。
* マイグレーション・プロセスの制限についてよく読み、理解します。 詳しくは、[以前のリリースからのアプリケーションのマイグレーション](../)を参照してください。

以前のバージョンの IBM MobileFirst Platform Foundation で作成されたアプリケーションは、一部変更を行わないと V8.0 ではサポートされません。 マイグレーション・アシスト・ツールは、既存のネイティブ Windows アプリケーションのソース・ファイルをスキャンすることによりこのプロセスを簡素化し、V8.0 で非推奨となった API、非サポート対象となった API、または変更された API を識別します。

マイグレーション・アシスト・ツールでは、アプリケーションの開発者コードおよびコメントの変更や移動は行いません。

1. 以下のいずれかの方法を使用してマイグレーション・アシスト・ツールをダウンロードします。
    * [Git リポジトリー](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)から .tgz ファイルをダウンロードします。
    * {{ site.data.keys.mf_console }} から {{ site.data.keys.mf_dev_kit }} をダウンロードします。これには、mfpmigrate-cli.tgz という名前のファイルとしてマイグレーション・アシスト・ツールが含まれています。
2. マイグレーション・アシスト・ツールをインストールします。
    * ツールをダウンロードしたディレクトリーに移動します。
    * 以下のコマンドを入力することにより、NPM を使用してツールをインストールします。

   ```bash
   npm install -g
   ```

3. 以下のコマンドを入力して、IBM MobileFirst Platform Foundation アプリケーションをスキャンします。

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type windows
   ```

   **source_directory**  
   プロジェクトの現在のロケーション。

   **destination_directory**  
   レポートが作成されるディレクトリー。

   マイグレーション・アシスト・ツールを scan コマンドと共に使用すると、ツールは、既存の IBM MobileFirst Platform Foundation アプリケーション内にある、V8.0 で削除された API、非推奨となった API、または変更された API を識別し、識別された宛先ディレクトリーにそれらを保存します。

## Windows プロジェクトのマイグレーション
{: #migrating-a-windows-project }
IBM MobileFirst™ Platform Foundation V6.2.0 以降で作成された既存のネイティブ Windows プロジェクトを使用して作業するには、プロジェクトを変更する必要があります。

MobileFirst V8.0 では、Windows Universal 環境 (つまり、Windows 10 Universal Windows Platform (UWP) および Windows 8 Universal (Desktop および Phone)) のみがサポートされます。 Windows Phone 8 Silverlight はサポートされません。

Visual Studio プロジェクトを V8.0 に手動でアップグレードできます。 {{ site.data.keys.product_adj }} V8.0 では、以前のバージョンで開発されたアプリケーションを変更する必要が生じる可能性がある、Visual Studio SDK に対する多くの変更が導入されています。 変更された API については、[Windows コードの更新](#updating-the-windows-code)を参照してください。

1. {{ site.data.keys.product_adj }} SDK を V8.0 に更新します。
    * MobileFirst SDK パッケージを手動で削除します。 これには、**wlclient.properties** ファイル、および以下の参照が含まれます。
        * Newtonsoft.Json
        * SharpCompress
        * worklight-windows8

        > **注:** アプリケーションでアプリケーション認証性フィーチャーまたは拡張認証性フィーチャーを使用している場合、Microsoft Visual C++ 2013 Runtime Package for Windows または Microsoft Visual C++ 2013 Runtime Package for Windows Phone のいずれかを参照としてアプリケーションに追加する必要があります。 そうするには、Visual Studio で、ネイティブ・プロジェクトの参照を右クリックし、ネイティブ API アプリケーションに追加した環境に応じて以下のいずれかを行います。

        * Windows デスクトップおよびタブレットの場合: **「参照設定」→「参照の追加」→「Windows 8.1」→「拡張機能」→「Microsoft Visual C++ 2013 Runtime Package for Windows」→「OK」**の順に右クリックして選択します。
        * Windows Phone 8 Universal の場合: **「参照設定」→「参照の追加」→「Windows 8.1」→「拡張機能」→「Microsoft Visual C++ 2013 Runtime Package for Windows Phone」→「OK」**の順に右クリックして選択します。
        * Windows 10 Universal Windows Platform (UWP) の場合: **「参照設定」→「参照の追加」→「Windows 8.1」→「拡張機能」→「Microsoft Visual C++ 2013 Runtime Package for Windows Universal」→「OK」**の順に右クリックして選択します。
    * NuGet を使用して {{ site.data.keys.product_adj }} V8.0.0 SDK パッケージを追加します。 『[NuGet を使用した {{ site.data.keys.product_adj }} SDK の追加](../../../application-development/sdk/windows-8-10)』を参照してください。
2. {{ site.data.keys.product_adj }} V8.0.0 API を使用するようにアプリケーション・コードを更新します。
    * 以前のリリースの場合、Windows API は、**IBM.Worklight.namespace** の一部でした。 これらの API は現在、廃止され、同等の **WorklightNamespace** API に置き換えられています。 **IBM.Worklight.namespace** へのすべての参照を、**WorklightNamespace** の対応する同等の参照に置き換えるようにアプリケーションを変更する必要があります。

   例えば、以下のようなスニペットを使用します。

   ```csharp
   WLResourceRequest request = new WLResourceRequest
                            (new Uri(uriBuilder.ToString()), "GET", "accessRestricted");
                            request.send(listener);
   ```

   新しい API で更新したスニペットは、以下のようになります。

   ```csharp
   WorklightResourceRequest request = newClient.ResourceRequest
                            (new Uri(uriBuilder.ToString(), UriKind.Relative), "GET", "accessRestricted");
                            WorklightResponse response = await request.Send();
   ```

    * 非同期操作を実行するすべてのメソッドは以前、応答リスナー・コールバック・モデルを使用していました。 これらは、**await/async** モデルに置き換えられています。

これで、{{ site.data.keys.product_adj }} SDK を使用してネイティブ Windows アプリケーションの開発を始めることができます。 {{ site.data.keys.product_adj }} V8.0.0 での API の変更を反映するため、コードの更新が必要になる場合があります。

#### 次の作業
{: #what-to-do-next }
使用が中止された、または V8.0 に含まれていないクライアント・サイド API を置き換えます。

## Windows コードの更新
{: #updating-the-windows-code }
{{ site.data.keys.product }} V8.0 では、Windows SDK に対する多くの変更が導入されています。これにより、以前のバージョンで開発されたアプリケーションの変更が必要になる可能性があります。

#### 非推奨となった Windows C# API クラス
{: #deprecated-windows-c-api-classes }

| カテゴリー | 説明 | 推奨処置 |
|----------|-------------|--------------------|
| `ChallengeHandler`  | カスタム・ゲートウェイ・チャレンジには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、`SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler`, `isCustomResponse()`  | `GatewayChallengeHandler.canHandleResponse()` を使用します。 |
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler.Shouldcancel()` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`SecurityCheckChallengeHandler.ShouldCancel()` を使用します。 |
| `WLAuthorizationManager` | 代わりに、`WorklightClient.WorklightAuthorizationManager` を使用してください。 |
| `WLChallengeHandler` | `SecurityCheckChallengeHandler` を使用します。  |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)`  | 	`SecurityCheckChallengeHandler.ShouldCancel()` を使用します。 |
| `WLClient` | 	代わりに、`WorklightClient` を使用してください。 |
| `WLErrorCode` | 	サポートされません。 |
| `WLFailResponse` | 	代わりに、`WorklightResponse` を使用してください。 |
| `WLResponse` | 代わりに、`WorklightResponse` を使用してください。 |
| `WLProcedureInvocationData` | 代わりに、`WorklightProcedureInvocationData` を使用してください。 |
| `WLProcedureInvocationFailResponse` | 	サポートされません。 |
| `WLProcedureInvocationResult` | 	サポートされません。 |
| `WLRequestOptions` | 	サポートされません。 |
| `WLResourceRequest` | 	代わりに、`WorklightResourceRequest` を使用してください。 |

#### 非推奨となった Windows C# API インターフェース
{: #deprecated-windows-c-api-interfaces }

| カテゴリー | 説明 | 推奨処置 |
|----------|-------------|--------------------|
| `WLHttpResponseListener` | サポートされません。 |
| `WLResponseListener` | 応答は `WorklightResponse` オブジェクトとして使用可能です。 |
| `WLAuthorizationPersistencePolicy` | サポートされません。 |
