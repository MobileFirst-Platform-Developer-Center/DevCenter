---
layout: tutorial
title: 既存の Cordova アプリケーションおよびハイブリッド・アプリケーションのマイグレーション
breadcrumb_title: Cordova とハイブリッド
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst Foundation バージョン 6.2.0 以降で作成された既存の Cordova アプリケーションまたはハイブリッド・アプリケーションをマイグレーションするには、現行バージョンのプラグインを使用する Cordova プロジェクトを作成する必要があります。次に、v8.0 で使用が中止された、または v8.0 に含まれていないクライアント・サイド API を置き換えます。このタスクでは、マイグレーション・アシスト・ツールが役立ちます。

#### ジャンプ先
{: #jump-to }
* [v8.0 を使用して開発した Cordova アプリケーションと v7.1 以前を使用して開発した Cordova アプリケーションの比較](#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)
* [{{ site.data.keys.product_full }} 8.0 でサポートされる Cordova アプリケーションへの、既存のハイブリッド・アプリケーションまたはクロスプラットフォーム・アプリケーションのマイグレーション](#migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80)
* [iOS Cordova での暗号化のマイグレーション](#migrating-encryption-for-ios-cordova)
* [ダイレクト・アップデートのマイグレーション](#migrating-direct-update)
* [WebView のアップグレード](#upgrading-the-webview)
* [削除されたコンポーネント](#removed-components)

## v8.0 を使用して開発した Cordova アプリケーションと v7.1 以前を使用して開発した Cordova アプリケーションの比較
{: #comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before }
{{ site.data.keys.product_adj }} v8.0 で開発された Cordova アプリケーションと、IBM MobileFirst Platform Foundation v7.1 で開発された Cordova アプリケーションおよびハイブリッド・アプリケーションを比較します。

| 機能| Cordova アプリケーション<br/>(IBM {{ site.data.keys.product }} v8.0 を使用)|	Cordova アプリケーション<br/>(IBM MobileFirst Platform Foundation v7.1 を使用)| MobileFirstハイブリッド<br/>(IBM MobileFirst Platform Foundation V7.1 を使用)|
|---------|-------|---------|-------|------|
| **IDE Eclipse Studio** | | | |  	 	 
| Eclipse プラグインおよび統合| はい| サポートされない| はい (プロプラエタリー)|
| アプリケーション・コンポーネント| はい (Cordova)<br/><br/>注: ユーザー独自の Cordova プラグインを作成して、組織のアプリケーション・コンポーネントを管理します。| はい (Cordova)<br/><br/>注: ユーザー独自の Cordova プラグインを作成して、組織のアプリケーション・コンポーネントを管理します。| はい (プロプラエタリー)|
| プロジェクト・テンプレート| はい (Cordova)<br/><br/>注: Apache Cordova `cordova create --template` コマンドを使用します。| はい (Cordova)<br/><br/>注: `mfp cordova create --template`、または Apache Cordova コマンドの `cordova create --copy-from` を使用します。| はい (プロプラエタリー)|
| Dojo および jQuery IDE インスツルメンテーション| はい<br/><br/>注: Dojo および jQuery Mobile は、Cordova アプリケーション内で使用できる JavaScript フレームワークです。| はい<br/><br/>注: Dojo および jQuery Mobile は、Cordova アプリケーション内で使用できる JavaScript フレームワークです。| はい|
| モバイル UI パターン| サポートされない| サポートされない| 推奨されない|
| **アプリケーション・サブタイプ** | | |
| シェル・コンポーネント| サポートされない<br/><br/>注: 以前のハイブリッド・アプリケーションでシェルおよび内部アプリケーションを使用していた場合、Cordova 設計パターンを採用して、シェル・コンポーネントを Cordova プラグインとして実装し、複数のアプリケーションで共有できるようにすることをお勧めします。| サポートされない| はい|
| 内部ハイブリッド・アプリケーション| サポートされない<br/><br/>注: 以前のハイブリッド・アプリケーションでシェルおよび内部アプリケーションを使用していた場合、Cordova 設計パターンを採用して、シェル・コンポーネントを Cordova プラグインとして実装し、複数のアプリケーションで共有できるようにすることをお勧めします。| サポートされない| はい|
| **アプリケーションの機能** | | | 	 	 	 
| モバイル OS	| iOS 8 以上、Android 4.1 以上、Windows Phone 8.1、Windows Phone 10。| iOS 7 以上、Android 4 以上。| iOS、Android、および Windows Phone 8。|
| Web アプリケーション| はい、Apache Cordova を使用せずに開発された JavaScript アプリケーションとして。| サポートされない| はい、desktopbrowser 環境または mobilewebapp 環境として。|
| ダイレクト・アップデート| はい。| はい| はい|
| {{ site.data.keys.product_adj }} セキュリティー・フレームワーク| はい| はい| はい|
| アプリケーション認証性| はい| はい| はい|
| 証明書ピン留め| はい| いいえ| はい|
| JSONStore| はい。| cordova-plugin-mfp-jsonstore プラグインを使用してください。| はい|
| FIPS 140-2 | はい。cordova-plugin-mfp-fips プラグインを使用してください。<br/><br/>制限: FIPS は、Android および iOS でサポートされます。FIPS は、Windows ではサポートされません。| いいえ| はい|
| アプリケーション・バイナリー・ファイル内でのアプリケーションに関連付けられている Web リソースの暗号化| はい|	いいえ| はい|
| アプリケーションの実行開始時に毎回チェックサムを使用して行われる Web リソースの整合性検証| はい| サポートされない| はい|
| アドレス可能なデバイスのライセンス・トラッキングのためのアプリケーションのターゲット・カテゴリー (B2E または B2C) の指定| はい| いいえ| はい|
| 単純データ共有| いいえ| はい| はい|
| シングル・サインオン| はい<br/><br/>注: デバイスのシングル・サインオン(SSO) が、新しい定義済みの enableSSO セキュリティー検査アプリケーション記述子構成プロパティーを通じてサポートされるようになりました。| はい| はい|
| {{ site.data.keys.product_adj }} アプリケーション・スキン| いいえ<br/><br/>注: さまざまなデバイス画面サイズを検出および処理するには、レスポンシブ Web デザインなどの標準 Web 開発手法を使用してください。| いいえ<br/><br/>注: さまざまなデバイス画面サイズを検出および処理するには、レスポンシブ Web デザインなどの標準 Web 開発手法を使用してください。| はい|
| 環境の最適化| はい (Cordova)。|  merges ディレクトリーを使用して、プラットフォームに固有の Web リソースを定義します。| はい (Cordova)。merges ディレクトリーを使用して、プラットフォームに固有の Web リソースを定義します。詳しくは、Apache Cordova 資料の『Using Merges to Customize Each Platform』を参照してください。|
| プッシュ通知| はい。cordova-plugin-mfp-push プラグインを使用してください。<br/><br/>制限: 事前定義の {{ site.data.keys.product_adj }} セキュリティー検査は、push.mobileclient スコープにのみマップできます。カスタム・セキュリティー検査は、JavaScript チャレンジ・ハンドラーが呼び出されないためサポートされません。| はい<br/><br/>注: Android の場合、cordova-plugin-mfp-push プラグインを追加する必要があります。iOS では、このプラグインは不要です。これは、iOS 用のプッシュ・クライアント・サイド・サポートがコア mfp プラグインに含まれているためです。| はい|
| Cordova プラグイン管理| はい| はい| いいえ|
| メッセージ (国際化対応)| はい| はい| はい|
| トークン・ライセンス| はい| はい| はい|
| **アプリケーションの最適化** | | |
| ミニファイ| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (プロプラエタリー)|
| JS と CSS の連結| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (プロプラエタリー)|
| 難読化| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (Cordova)<br/><br/>注: 一般的なオープン・ソース・ツールを使用してください。| はい (プロプラエタリー)|
| Android Pro Guard| はい<br/><br/>注: {{ site.data.keys.product }} V8.0.0 には、{{ site.data.keys.product_adj }} Android アプリケーションでの Android ProGuard 難読化用の事前定義の proguard-project.txt 構成ファイルは含まれていません。| はい<br/><br/>注: Pro Guard を有効にするには、Android 資料を参照してください。| はい|

## {{ site.data.keys.product }} 8.0 でサポートされる Cordova アプリケーションへの既存のハイブリッドまたはクロスプラットフォーム・アプリケーションのマイグレーション
{: #migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80 }
IBM MobileFirst Platform Foundation バージョン 6.2 以降で開発された既存のハイブリッドまたはクロスプラットフォーム (Cordova) のアプリケーションを、{{ site.data.keys.product }} v8.0 でサポートされる Cordova アプリケーションにマイグレーションできます。

#### ジャンプ先のセクション
{: #jump-to-section }
* [マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)
* [{{ site.data.keys.product_adj }} ハイブリッド・アプリケーションのマイグレーションの完了](#completing-migration-of-a-mobilefirst-hybrid-app)
* [{{ site.data.keys.product_adj }} Cordova アプリケーションのマイグレーションの完了](#completing-migration-of-a-mobilefirst-cordova-app)

### マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始
{: #starting-the-cordova-app-migration-with-the-migration-assistance-tool }
マイグレーション・アシスト・ツールは、もう有効でない API を識別し、v8.0 でサポートされる Cordova アプリケーションにプロジェクトをコピーすることにより、{{ site.data.keys.product_adj }} の以前のバージョンで作成されたクロスプラットフォーム・アプリケーションをマイグレーションする準備を支援します。

マイグレーション・アシスト・ツールを使用する前に、以下の情報を知っておくことが重要です。

* 既存の IBM MobileFirst Platform Foundation ハイブリッド・アプリケーション、または `mfp cordova create` コマンドを使用して作成した Cordova アプリケーションがある必要があります。
* インターネット・アクセスが必要です。
* node.js バージョン 4.0.0 以降がインストールされている必要があります。
* Cordova コマンド・ライン・インターフェース (CLI)、およびターゲット・プラットフォームで Cordova CLI を使用するために必要なすべての前提条件がインストールされている必要があります。詳しくは、Apache Cordova Web サイトの『[The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)』を参照してください。
* マイグレーション・プロセスの制限についてよく読み、理解します。詳しくは、[以前のリリースからのアプリケーションのマイグレーション](../)を参照してください。

以前のバージョンの IBM MobileFirst Platform Foundation のコマンドを使用して作成されたクロスプラットフォーム・アプリケーション、または IBM MobileFirst Platform Foundation コマンドを使用して作成された Cordova アプリケーションは、一部変更を行わないとバージョン 8.0 ではサポートされません。マイグレーション・アシスト・ツールは、以下の機能を使用してこのプロセスを簡素化します。

* 既存のハイブリッド・アプリケーション、または IBM MobileFirst Platform Foundation を使用して開発された Cordova アプリケーション内の JavaScript ファイルおよび  HTML ファイルをスキャンし、バージョン 8.0 で非推奨となった API、サポートされなくなった API、または変更された API を識別します。
* 初期ハイブリッド・アプリケーション、または IBM MobileFirst Platform Foundation を使用して開発された Cordova アプリケーションの構造、スクリプト、および構成ファイルを、バージョン 8.0 でサポートされている Cordova 構造にコピーします。

マイグレーション・アシスト・ツールは、アプリケーションの開発者コードやコメントの変更も移動も行いません。このツールを実行した後、[MobileFirst ハイブリッド・アプリケーションのマイグレーションの完了](#completing-migration-of-a-mobilefirst-hybrid-app)または [MobileFirst Cordova アプリケーションのマイグレーションの完了](#completing-migration-of-a-mobilefirst-cordova-app)に進んで、マイグレーション・プロセスを続ける必要があります。

<!--1. Download the migration assistance tool by using one of the following methods:
    * Download the .tgz file from the [Git repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli).
    * Download the {{ site.data.keys.mf_dev_kit }}, which contains the migration assistance tool as a file named mfpmigrate-cli.tgz, from the MobileFirst Operations Console.
    * Download the tool by using the instructions that are provided. -->
1. マイグレーション・アシスト・ツールをインストールします。
    * .tgz ファイルをダウンロードしたディレクトリーに移動します。
    * 以下のコマンドを入力することにより、NPM を使用してツールをインストールします。

   ```bash
   npm install -g tgz_filename
   ```
      NPM の **mfpmigrate-cli** パッケージの詳細については、[ここを](https://www.npmjs.com/package/mfpmigrate-cli)クリックしてください。
2. 以下のコマンドを入力して、IBM MobileFirst Platform Foundation アプリケーションをスキャンおよびコピーします。

   ```bash
   mfpmigrate client --in source_directory --out destination_directory --projectName new-project-directory
   ```

   * **source_directory**  
   マイグレーションするプロジェクトの現在のロケーション。ハイブリッド・アプリケーションの場合、これはアプリケーションの **application** フォルダーをポイントしていなければなりません。
   * **destination_directory**    
   新しいバージョン 8.0 互換の Cordova 構造が出力されるディレクトリーのオプション名。このディレクトリーは、**new-project-directory** フォルダーの親です。これが指定されていない場合、フォルダーはコマンドが実行されたディレクトリーに作成されます。
   * **new-project-directory**
   新しいプロジェクトの内容が配置されるフォルダーのオプション名。
   このフォルダーは *destination_directory* フォルダー内に配置され、Cordova アプリケーションのすべての情報がこのフォルダーに含まれます。このオプションが指定されていない場合、デフォルト名は `app_name-app_id-version` です。
   <br/>
これを client コマンドと共に使用すると、マイグレーション・アシスト・ツールが以下のアクションを実行します。  
        * バージョン 8.0 で削除された、非推奨となった、または変更された、既存の IBM MobileFirst Platform Foundation アプリケーション内の API を識別します。
        * 初期アプリケーションの構造に基づいて Cordova 構造を作成します。
        * 該当する場合、以下の項目をコピーまたは追加します。
            * Android オペレーティング・システム
            * iPhone および iPad のオペレーティング・システム
            * Windows オペレーティング・システム
            * Cordova-mfp-plugin
            * JSONStore フィーチャーが旧プロジェクトでインストールされていた場合、Cordova-plugin-mfp-jsonstore プラグイン。
            * FIPS が旧プロジェクトでインストールされていた場合、Cordova-plugin-mfp-fips プラグイン。
            * プッシュ通知フィーチャーが旧プロジェクトでインストールされていた場合、Cordova-plugin-mfp-push プラグイン。
            * 旧プロジェクトで証明書のピン留めが有効になっていた場合、ハイブリッド証明書。
            * アプリケーション、スクリプト、および XML ファイル
		* コマンド完了後、結果として得られた情報ファイルをデフォルト・ブラウザーで開きます。

        > **重要:** マイグレーション・アシスト・ツールは、開発者コードおよびコメント・テキストを新しい構造にコピーしません。
3. 新しい Cordova アプリケーションでの API 問題を解決します。
    * **destination_directory** ディレクトリーに作成される **api-report.html** ファイル (コマンド完了時にデフォルト・ブラウザーで開かれるファイル) を調べます。このファイル内の表の各行によって、バージョン 8.0 と互換性がないアプリケーション内で使用されている非推奨の API、変更された API、または削除された API が識別されます。また、このファイルは、削除された API に置き換わるものも指定します (置き換えが使用可能な場合)。 

    | ファイル・パス| 行番号| API| 行の内容| API 変更のカテゴリー| 説明およびアクション項目|
    |-----------|-------------|-----|--------------|------------|-----------|
    | c:&#xa5;local&#xa5;Cordova&#xa5;www&#xa5;js&#xa5;index.js|	15| `WL.Client.getAppProperty` | {::nomarkdown}<ul><li><code>document.getElementById('app_version')</code></li><li><code>textContent = WL.Client.getAppProperty("APP_VERSION");</code></li></ul>{:/} | サポートされない| 8.0 から削除されました。Cordova プラグインを使用してアプリケーションのバージョンを取得します。代わりの API はありません。|

    * **api-report.html** ファイル内で識別された API の問題に対処します。
4. 初期アプリケーション構造から新しい Cordova 構造内の正しいロケーションに開発者コードを手動でコピーします。ソース IBM MobileFirst Platform Foundation アプリケーションのタイプに従って、以下のディレクトリー内の内容をコピーします。 
    * **IBM MobileFirst Platform Foundation ハイブリッド・アプリケーション**  
ソース・アプリケーションの **common** ディレクトリーの内容を、新しい Cordova アプリケーション内の **www** ディレクトリーにコピーします。
    * **IBM MobileFirst Platform Foundation を使用して開発された Cordova アプリケーション**
    ソース・アプリケーションの **www** ディレクトリーの内容を、新しい Cordova アプリケーションの **www** ディレクトリーにコピーします。
5. 新規アプリケーションに対して scan コマンドと共にマイグレーション・アシスト・ツールを実行して、API の変更が完了していることを確認します。
    * 以下のコマンドを入力して、スキャンを実行します。

      ```bash
      mfpmigrate scan --in source_directory --out destination_directory --type hybrid
      ```
        * **source_directory**  
スキャンするファイルの現在のロケーション。IBM MobileFirst Platform Foundation ハイブリッド・アプリケーションでは、このロケーションは、アプリケーションの **common** ディレクトリーです。{{ site.data.keys.product }} バージョン 8.0 の Cordova クロスプラットフォーム・アプリケーションでは、このロケーションは **www** ディレクトリーです。
        * **destination_directory**  
スキャンの結果が出力されるディレクトリー。
		* **scan_type**  
スキャンするプロジェクトのタイプ。
    * **api-report.html** ファイル内で特定された残りの API の問題に対処します。
6. すべての問題が解決されるまで、ステップ 6 を繰り返して、新しい Cordova アプリケーションに対してスキャン・ツールを実行します。

### {{ site.data.keys.product_adj }} ハイブリッド・アプリケーションのマイグレーションの完了
{: #completing-migration-of-a-mobilefirst-hybrid-app }
マイグレーション・アシスト・ツールを使用した後、コードの一部を手動で変更してマイグレーション・プロセスを完了する必要があります。

* 既存のハイブリッド・アプリケーションに対して、既に mfpmigrate マイグレーション・アシスト・ツールを実行済みである必要があります。詳しくは、[マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)を参照してください。
* Cordova コマンド・ライン・インターフェース (CLI) をインストール済みである必要があります。また、追加の Cordova プラグインをインストールする必要がある場合は、ターゲット・プラットフォームで Cordova CLI を使用するために必要な前提条件ソフトウェアもインストール済みである必要があります (ステップ 6 を参照)。詳しくは、Apache Cordova Web サイトの [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html) を参照してください。
* JQuery の新規バージョンをダウンロードする必要がある (ステップ 1c) 場合、または追加の Cordova プラグインをインストールする必要がある (ステップ 6) 場合は、インターネット・アクセスが必要です。
* 追加の Cordova プラグインをインストールする必要がある (ステップ 6) 場合は、node.js バージョン 4.0.0 以降がインストールされている必要があります。

このタスクのステップを完了して、IBM MobileFirst Platform Foundation 7.1 から、{{ site.data.keys.product }}  8.0 のサポートが組み込まれた Cordova アプリケーションへの、MobileFirst ハイブリッド・アプリケーションのマイグレーションを完了します。

マイグレーションが完了すると、マイグレーション後のアプリケーションでは、IBM MobileFirst Platform Foundation とは独立して入手する Cordova のプラットフォームやプラグインを使用できます。また、引き続き、任意の Cordova 開発ツールを使用してアプリケーションを開発できます。

1. **www/index.html** ファイルを更新します。
    * 以下の CSS コードを、index.html ファイルの先頭、既にある CSS コードの前に追加します。

      ```html
      <link rel="stylesheet" href="worklight/worklight.css">
      <link rel="stylesheet" href="css/main.css">
      ```

      > **注:** **worklight.css** ファイルは、body 属性を relative に設定します。これがアプリケーションのスタイルに影響する場合は、ユーザー自身の CSS コードで position に別の値を宣言してください。 以下に例を示します。

      ```css
body {
position: absolute;
      }
      ```

    * Cordova JavaScript を、ファイルの先頭、CSS 定義の後に追加します。

      ```html
      <script type="text/javascript" src="cordova.js"></script>
      ```    

    * 以下のコード行がある場合は削除します。

      ```html
      <script>window.$ = window.jQuery = WLJQ;</script>
      ```

      ユーザー独自のバージョンの JQuery をダウンロードし、以下のコード行で示すように、それをロードすることができます。

      ```html
      <script src="lib/jquery.min.js"></script>
      ```

      このオプションの jQuery 追加を **lib** フォルダーへ移動する必要はありません。 この追加はどこでも必要な場所に移動できますが、その追加を **index.html** ファイル内で正しく参照している必要があります。

2. **www/js/InitOptions.js** ファイルを更新して `WL.Client.init` を自動的に呼び出すようにします。
    * **InitOptions.js** から以下のコードを削除します。

      関数 `WL.Client.init` は自動的にグローバル変数 **wlInitOptions** を指定して呼び出されます。

      ```javascript
if (window.addEventListener) {
window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

3. **www/InitOptions.js** を更新して `WL.Client.init` を手動で呼び出すようにします。
    * **config.xml** ファイルを編集し、`<mfp:clientCustomInit>` エレメントの enabled 属性を true に設定します。
    * MobileFirst ハイブリッド・デフォルト・テンプレートを使用している場合、以下のコードを置き換えます。

      ```javascript
if (window.addEventListener) {
window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

      上記を、以下のコードにします。

      ```javascript
if (document.addEventListener) {
document.addEventListener('mfpready', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            document.attachEvent('mfpready',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

4. (例えば、**app/iphone/js/main.js** 内に) ハイブリッド環境に固有のロジックがある場合は、関数 `wlEnvInit()` をコピーし、これを **www/main.js** の末尾に追加します。

   ```javascript
// This wlEnvInit method is invoked automatically by MobileFirst runtime after successful initialization.
function wlEnvInit() {
        wlCommonInit();
        if (cordova.platformId === "ios") {
            // Environment initialization code goes here for ios
        } else if (cordova.platformId === "android") {
            // Environment initialization code goes here for android
        }
   }
   ```

5. オプション: 元のアプリケーションで FIPS フィーチャーを使用している場合は、JQuery イベント・リスナーを、WL/FIPS/READY イベントを listen する JavaScript イベント・リスナーに変更します。FIPS について詳しくは、『[FIPS 140-2 サポート](../../../administering-apps/federal/#fips-140-2-support)』を参照してください。
6. オプション: 元のアプリケーションで、マイグレーション・アシスト・ツールによって置き換えも提供もされない、サード・パーティーの Cordova プラグインを使用している場合は、`cordova plugin add` コマンドを使用して、手動でそれらのプラグインを Cordova アプリケーションに追加してください。このツールでどのプラグインが置き換えられるかについて詳しくは、[マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)を参照してください。

### {{ site.data.keys.product_adj }} Cordova アプリケーションのマイグレーションの完了
{: #completing-migration-of-a-mobilefirst-cordova-app }
マイグレーション・アシスト・ツールを使用した後、コードの一部を手動で変更してマイグレーション・プロセスを完了する必要があります。

* 既存の Cordova アプリケーションで **mfpmigrate** マイグレーション・アシスト・ツールを既に実行している必要があります。詳しくは、[マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)を参照してください。
* Cordova コマンド・ライン・インターフェース (CLI)、およびターゲット・プラットフォームで Cordova CLI を使用するために必要なすべての前提条件がインストールされている必要があります。詳しくは、Apache Cordova Web サイトの [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html) を参照してください。
* インターネット・アクセスが必要です。
* node.js バージョン 4.0.0 以降がインストールされている必要があります。

**mfp cordova create** を使用して作成した Cordova アプリケーションは、IBM MobileFirst Platform Foundation の以前のバージョンで提供されていた Cordova のプラットフォームとプラグインを使用します。マイグレーションが完了すると、マイグレーション後のアプリケーションは、{{ site.data.keys.product }} とは独立して入手した Cordova プラットフォームおよびプラグインを使用できます。これは、IBM MobileFirs Foundation v8.0 で使用可能な唯一のタイプの Cordova アプリケーション・サポートです。

マイグレーションするには、マイグレーション・アシスト・ツールを実行し、次にアプリケーションに他の変更を行います。

1. 任意の Cordova 開発ツールを使用して、元のアプリケーションに含まれていた {{ site.data.keys.product_adj }}機能を有効にする Cordova プラグイン以外の任意の Cordova プラグインを追加します。例えば、Cordova CLI では、プラグイン **cordova-plugin-file** および **cordova-plugin-file-transfer** を追加するには、以下を入力します。 

   ```bash
   cordova plugin add cordova-plugin-file cordova-plugin-file-transfer
   ```

   > **注:** **mfpmigrate** マイグレーション・アシスト・ツールによって {{ site.data.keys.product_adj }} フィーチャー用の Cordova プラグインが追加されていますので、ユーザーがそれらを追加する必要はありません。これらのプラグインについて詳しくは、[{{ site.data.keys.product_adj }} 用の Cordova プラグイン](../../../application-development/sdk/cordova)を参照してください。

2. オプション: 元のアプリケーションで FIPS フィーチャーを使用している場合は、JQuery イベント・リスナーを、WL/FIPS/READY イベントを listen する JavaScript イベント・リスナーに変更します。FIPS について詳しくは、『[FIPS 140-2 サポート](../../../administering-apps/federal/#fips-140-2-support)』を参照してください。
3. オプション: 元のアプリケーションで、マイグレーション・アシスト・ツールによって置き換えも提供もされない、サード・パーティーの Cordova プラグインを使用している場合は、**cordova plugin add** コマンドを使用して、手動でそれらのプラグインを Cordova アプリケーションに追加してください。このツールでどのプラグインが置き換えられるかについて詳しくは、[マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)を参照してください。
4. オプション: (iOS プラットフォームを含み、OpenSSL を使用するアプリケーションの場合のみ。) **cordova-plugin-mfp-encrypt-utils ** プラグインをアプリケーションに追加します。**cordova-plugin-mfp-encrypt-utils ** プラグインは、iOS プラットフォームを使用する Cordova アプリケーションの暗号化のための iOS OpenSSL フレームワークを提供します。

これで、任意の Cordova ツールを使用して開発を続行できるが、{{ site.data.keys.product_adj }} 機能も含まれている Cordova アプリケーションが用意できました。

## iOS Cordova での暗号化のマイグレーション
{: #migrating-encryption-for-ios-cordova }
iOS ハイブリッドまたは Cordova のアプリケーションで OpenSSL 暗号化を使用していた場合、アプリケーションを新しい V8.0.0 のネイティブ暗号化にマイグレーションできます。OpenSSL の使用を継続する場合は、追加の Cordova プラグインを追加する必要があります。

マイグレーションに関する iOS Cordova 暗号化オプションについて詳しくは、[Cordova アプリケーションでの OpenSSL の有効化](../../../application-development/sdk/cordova/additional-information/#enabling-openssl-in-cordova-applications)トピックの [マイグレーション・オプション](../../../application-development/sdk/cordova/additional-information/#migration-options)・セクションを参照してください。

## ダイレクト・アップデートのマイグレーション
{: #migrating-direct-update }
ダイレクト・アップデートは、保護リソースに初めてアクセスした後にトリガーされます。新規 Web リソースのデプロイ・プロセスが v8.0 で変更されました。

以前のバージョンと異なり、v8.0 では、アプリケーションがセキュア {{ site.data.keys.product_adj }} リソースにアクセスしない場合、サーバーで更新が使用可能になっても、クライアント・アプリケーションは更新を受け取りません。OAuth がアノテーション `@OAuth(security=false)` または構成によって無効にされているなどのため、リソースが無保護の可能性があります。このリスクは、以下のいずれかの方法で回避できます。

* アクセス・トークンを明示的に取得する。[`WLAuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc) クラスの `obtainAccessToken` API を参照してください。
* 別の保護リソースを呼び出す。[`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html?view=kc)クラスを参照してください。

ダイレクト・アップデートを使用するには: v8.0 以降、**.wlapp** ファイルを {{ site.data.keys.mf_server }} にアップロードしなくなりました。代わりに、それより小さい Web リソース・アーカイブ (.zip ファイル) をアップロードします。このアーカイブ・ファイルには、以前のバージョンで広く使用されていた Web プレビュー・ファイルまたはスキンは含まれなくなりました。それらは廃止されました。アーカイブに含まれるのは、クライアントに送信される Web リソースと、ダイレクト・アップデートの妥当性検査のためのチェックサムのみです。

> 詳しくは、[ダイレクト・アップデートの資料](../../../application-development/direct-update)を参照してください。

## WebView のアップグレード
{: #upgrading-the-webview }
IBM MobileFirs Foundation v8.0 の Cordova SDK (JavaScript) では、コードの適応を必要とする数多くの変更が導入されました。

手動マイグレーション・プロセスには、以下のいくつかのステージがあります。

* 新規 Cordova プロジェクトを作成する
* 必要な Web リソース・エレメントを前のバージョンのコードで置き換える
* SDK の変更に準拠するように JavaScript コードに必要な変更を行う

v8.0 では、多くの {{ site.data.keys.product_adj }} API エレメントが削除されました。削除されたエレメントは、JavaScript の自動修正をサポートする IDE 内では、存在しないものとして明確なマークがついています。

以下の表では、削除する必要がある API エレメント、および機能を置き換える方法の推奨をリストします。削除されたエレメントの多くは、Cordova プラグインまたは HTML 5 エレメントに置き換えることができる UI エレメントです。一部のメソッドが変更されています。

#### 使用が中止された JavaScript UI エレメント
{: #discontinued-javascript-ui-elements }

| API エレメント| マイグレーション・パス|
|-------------|----------------|
| {::nomarkdown}<ul><li><code>WL.BusyIndicator</code></li><li><code>WL.OptionsMenu</code></li><li><code>WL.TabBar</code></li><li><code>WL.TabBarItem</code></li></ul>{:/} | Cordova プラグインまたは HTML 5 エレメントを使用してください。|
| `WL.App.close()` | {{ site.data.keys.product_adj }} の外部でこのイベントを処理してください。|
| `WL.App.copyToClipboard()` | この機能を提供する Cordova プラグインを使用してください。|
| `WL.App.openUrl(url, target, options)` | この機能を提供する Cordova プラグインを使用してください。<br/><br/>注: ご参考までに、Cordova の InAppBrowser プラグインがこの機能を提供しています。|
| {::nomarkdown}<ul><li><code>WL.App.overrideBackButton(callback)</code></li><li><code>WL.App.resetBackButton()</code></li></ul> | この機能を提供する Cordova プラグインを使用してください。<br/><br/>注: ご参考までに、Cordova の backbutton プラグインがこの機能を提供しています。|
| `WL.App.getDeviceLanguage()` | この機能を提供する Cordova プラグインを使用してください。<br/><br/>注: ご参考までに、Cordova の **cordova-plugin-globalization** プラグインがこの機能を提供しています。|
| `WL.App.getDeviceLocale()` | この機能を提供する Cordova プラグインを使用してください。<br/><br/> 注: ご参考までに、Cordova の **cordova-plugin-globalization** プラグインがこの機能を提供しています。|
| `WL.App.BackgroundHandler` | カスタム・ハンドラー関数を実行するには、標準 Cordova pause イベント・リスナーを使用してください。プライバシーを保護し、iOS システム、Android システム、およびユーザーがスナップショットまたは画面キャプチャーを取るのを防止する Cordova プラグインを使用します。詳しくは、PrivacyScreenPlugin ([https://github.com/devgeeks/PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)) を参照してください。|
| {::nomarkdown}<ul><li><code>WL.Client.close()</code></li><li><code>WL.Client.restore()</code></li><li><code>WL.Client.minimize()</code></li></ul>{:/}| これらの関数は、{{ site.data.keys.product }} v8.0 ではサポートされていない Adobe AIR プラットフォームをサポートするために提供されていました。|
| `WL.Toast.show(string)` | Toast 用 Cordova プラグインを使用してください。|

#### 使用が中止されたその他の JavaScript エレメント
{: #other-discontinued-javascript-elements }

| API| マイグレーション・パス|
|-----|----------------|
| `WL.Client.checkForDirectUpdate(options)` | 代替はありません。<br/><br/>注: ダイレクト・アップデートが使用可能な場合は、[`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) を呼び出してトリガーすることができます。サーバーでダイレクト・アップデートが使用可能な場合は、セキュリティー・トークンにアクセスするとダイレクト・アップデートがトリガーされます。ただし、ダイレクト・アップデートをオンデマンドでトリガーすることはできません。|
| {::nomarkdown}<ul><li><code>WL.Client.setSharedToken({key: myName, value: myValue})</code></li><li><code>WL.Client.getSharedToken({key: myName})</code></li><li><code>WL.Client.clearSharedToken({key: myName})</code></li></ul>{:/} | 代替はありません。|
| {::nomarkdown}<ul><li><code>WL.Client.isConnected()</code></li><li><code>connectOnStartup</code> init オプション</li></ul> | [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。|
| {::nomarkdown}<ul><li><code>WL.Client.setUserPref(key,value, options)</code></li><li><code>WL.Client.setUserPrefs(userPrefsHash, options)</code></li><li><code>WL.Client.deleteUserPrefs(key, options)</code></li></ul>{:/} | 代替はありません。アダプターおよび [MFP.Server.getAuthenticatedUser](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser) を使用してユーザー設定を管理することができます。|
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 代替はありません。|
| `WL.Client.logActivity(activityType)` | [`WL.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Logger.html?view=kc) を使用してください。|
| `WL.Client.login(realm, options)` | [`WLAuthorizationManager.login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#login) を使用してください。|
| `WL.Client.logout(realm, options)` | [`WLAuthorizationManager.logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#logout) を使用してください。|
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) を使用してください。|
| {::nomarkdown}<ul><li><code>WL.Client.transmitEvent(event, immediate)</code></li><li><code>WL.Client.purgeEventTransmissionBuffer()</code></li><li><code>WL.Client.setEventTransmissionPolicy(policy)</code></li></ul>{:/} | これらのイベントの通知を受け取るためのカスタム・アダプターを作成してください。|
| {::nomarkdown}<ul><li><code>WL.Device.getContext()</code></li><li><code>WL.Device.startAcquisition(policy, triggers, onFailure)</code></li><li><code>WL.Device.stopAcquisition()</code></li><li><code>WL.Device.Wifi</code></li><li><code>WL.Device.Geo.Profiles</code></li><li><code>WL.Geo </code></li></ul>{:/} | GeoLocation 用のネイティブ API またはサード・パーティーの Cordova プラグインを使用します。|
| `WL.Client.makeRequest (url, options)` | 同じ機能を提供するカスタム・アダプターを作成してください。|
| `WL.Device.getID(options)` | この機能を提供する Cordova プラグインを使用してください。<br/><br/>注: ご参考までに、**cordova-plugin-device** プラグインの **device.uuid** がこの機能を提供しています。|
| `WL.Device.getFriendlyName()` | `WL.Client.getDeviceDisplayName` を使用してください。|
| `WL.Device.setFriendlyName()` | `WL.Client.setDeviceDisplayName` を使用してください。|
| `WL.Device.getNetworkInfo(callback)` | この機能を提供する Cordova プラグインを使用してください。<br/><br/>注: ご参考までに、**cordova-plugin-network-information** プラグインがこの機能を提供しています。|
| `WLUtils.wlCheckReachability()` | サーバーの可用性を検査するカスタム・アダプターを作成してください。|
| `WL.EncryptedCache` | JSONStore を使用して暗号化されたデータをローカルに保管します。JSONStore は **cordova-plugin-mfp-jsonstore** 内にあります。|
| `WL.SecurityUtils.remoteRandomString(bytes)` | 同じ機能を提供するカスタム・アダプターを作成してください。|
| `WL.Client.getAppProperty(property)` | cordova plugin add **cordova-plugin-appversion** プラグインを使用して、アプリケーション・バージョン・プロパティーを取得できます。返されるバージョンは、ネイティブ・アプリケーション・バージョンです (Android および iOS のみ)。|
| `WL.Client.Push.*` | **cordova-plugin-mfp-push** プラグインに含まれている [JavaScript クライアント・サイドのプッシュ API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_js_client_push_api.html?view=kc#r_client_push_api) を使用してください。詳しくは、[イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション](../../migrating-push-notifications)を参照してください。|
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | [`MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-mfp-push-hybrid/html/MFPPush.html?view=kc#registerDevice) を使用して、プッシュおよび SMS 用のデバイスを登録します。|
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) を使用して、必要なスコープのトークンを取得します。|
| `WLClient.getLastAccessToken(scope)` | [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) を使用してください。|
| {::nomarkdown}<ul><li><code>WLClient.getLoginName()</code></li><li><code>WL.Client.getUserName(realm)</code></li></ul>{:/} | 代替はありません。|
| `WL.Client.getRequiredAccessTokenScope(status, header)` |  [`WLAuthorizationManager.isAuthorizationRequired `](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#isAuthorizationRequired) および [`WLAuthorizationManager.getResourceScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#getResourceScope) を使用してください。|
| `WL.Client.isUserAuthenticated(realm)` | 代替はありません。|
| `WLUserAuth.deleteCertificate(provisioningEntity)` | 代替はありません。|
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | 代替はありません。|
| `WL.Client.createChallengeHandler(realmName)` | カスタム・ゲートウェイ・チャレンジを処理するためのチャレンジ・ハンドラーを作成するには、[`WL.Client.createGatewayChallengeHandler(gatewayName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) を使用します。{{ site.data.keys.product_adj }} セキュリティー検査チャレンジを処理するためのチャレンジ・ハンドラーを作成するには、[`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) を使用します。|
| `WL.Client.createWLChallengeHandler(realmName)` | [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) を使用します。|
| `challengeHandler.isCustomResponse()`。ここで、`challengeHandler` は、`WL.Client.createChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。| `gatewayChallengeHandler.canHandleResponse()` を使用します。ここで、`gatewayChallengeHandler` は、[`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) によって返されるチャレンジ・ハンドラー・オブジェクトです。|
| `wlChallengeHandler.processSucccess()`。ここで、`wlChallengeHandler` は、`WL.Client.createWLChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。| `securityCheckChallengeHandler.handleSuccess()` を使用します。ここで、`securityCheckChallengeHandler` は、[`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) によって返されるチャレンジ・ハンドラー・オブジェクトです。|
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | チャレンジ・ハンドラーで同様のロジックを実装してください。カスタム・ゲートウェイ・チャレンジ・ハンドラーには、[`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) によって返されるチャレンジ・ハンドラー・オブジェクトを使用します。{{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、[`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) によって返されるチャレンジ・ハンドラー・オブジェクトを使用します。|
| `WL.Client.AbstractChallengeHandler.submitFailure(err)` | [`WL.Client.AbstractChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.AbstractChallengeHandler.html?view=kc#cancel) を使用します。|
| `WL.Client.createProvisioningChallengeHandler()` | 代替はありません。デバイス・プロビジョニングは、自動的にセキュリティー・フレームワークによって処理されるようになりました。|

#### 非推奨になった JavaScript API
{: #deprecated-javascript-apis }

| API| マイグレーション・パス|
|-----|----------------|
| {::nomarkdown}<ul><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener) </code></li><li><code>WL.Client.invokeProcedure(invocationData, options) </code></li><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)</code></li><li><code>WLProcedureInvocationResult</code></li></ul>{:/} | 代わりに `WLResourceRequest` を使用してください。注: invokeProcedure の実装は、WLResourceRequest を使用します。|
| `WLClient.getEnvironment` | この機能を提供する Cordova プラグインを使用してください。注: ご参考までに、device.platform プラグインがこの機能を提供しています。|
| `WL.Client.getLanguage` | この機能を提供する Cordova プラグインを使用してください。注: ご参考までに、**cordova-plugin-globalization** プラグインがこの機能を提供しています。|
| `WL.Client.connect(options)` | `WLAuthorizationManager.obtainAccessToken` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。|

## 削除されたコンポーネント
{: #removed-components }
MobileFirst Platform Foundation Studio 7.1 によって作成された Cordova プロジェクトには、専有機能をサポートする多くのリソースが含まれていました。ただし、v8.0 では、ピュア Cordova のみがサポートされ、{{ site.data.keys.product_adj }} API ではこれらの機能はサポートされなくなっています。

### スキン
{: #skins }
MobileFirst アプリケーション・スキン は、各種デバイスおよびフォーマットに適合させるために UI を最適化する手段を提供していましたが、v8.0 ではサポートされなくなっています。  
このタイプの機能を置き換えるために、Cordova および HTML 5 で提供されているレスポンシブ Web デザイン方式を採用することをお勧めします。

### シェル
{: #shells }
**シェル**により、複数のアプリケーションで使用および共有する一連の機能の開発が可能でした。この方法で、ネイティブ環境を熟知した開発者は、一連のコア機能を提供できていました。このようなシェルは、**内部アプリケーション**にバンドルされ、ビジネス・ロジックまたは UI の開発に関わる開発者によって使用されていました。

以前のハイブリッド・アプリケーションでシェルおよび内部アプリケーションを使用していた場合、Cordova 設計パターンを採用して、シェル・コンポーネントを Cordova プラグインとして実装し、複数のアプリケーションで共有できるようにすることをお勧めします。開発者は、シェル・コードの一部を再使用し、Cordova プラグインにマイグレーションする方法を探ることもできます。

例えば、すべてのアプリケーションで共通の一連の Web リソース (JavaScript、CSS ファイル、グラフィックス、HTML) がある場合、そのようなリソースをアプリケーションの www フォルダーにコピーする Cordova プラグインを作成できます。

例えば、このようなリソースが、以下のように、src/www/acme/ フォルダー内にあるものとします。

* src/www/acme/js/acme.js
* src/www/acme/css/acme.css
* src/www/acme/img/acme-logo.png
* src/www/acme/html/banner.html
* src/www/acme/html/footer.html
* plugin.xml

以下のように、**plugin.xml** ファイルに `<asset>` タグが含まれていて、このタグに、リソースをコピーするためのソースとターゲットが入っています。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plugin
     xmlns="http://apache.org/cordova/ns/plugins/1.0"     
     xmlns:rim="http://www.blackberry.com/ns/widgets"
     xmlns:android="http://schemas.android.com/apk/res/android"
     id="cordova-plugin-acme"
     version="1.0.1">
<name>ACME Company Shell Component</name>
<description>ACME Company Shell Component</description>
<license>MIT</license>
<keywords>cordova,acme,shell,components</keywords>
<issue>https://www.acme.com/support</issue>
<asset src="src/www/acme" target="www/acme"/>
</plugin>
```

**plugin.xml** を Cordova **config.xml** ファイルに追加すると、asset src にリストされているリソースがコンパイル時に asset target にコピーされます。  
これで、**index.html** ファイル内、またはアプリケーション内の任意の場所で、これらのリソースを再使用できます。

```html
<link rel="stylesheet" type="text/css" href="acme/css/acme.css">
<script type="text/javascript" src="acme/js/acme.js"></script>
<div id="banner"></div>
<div id="app"></div>
<div id="footer"></div>
<script type="text/javascript">
    $("#banner").load("acme/html/banner.html");
    $("#footer").load("acme/html/footer.html");
</script>
```

### 「設定」ページ
{: #settings-page }
**「設定」ページ**は、MobileFirst ハイブリッド・アプリケーションで使用可能な UI でした。このページにより、開発者は、テスト目的のためにサーバー URL を実行時に変更できました。現在、開発者は、既存の {{ site.data.keys.product_adj }} クライアント API を使用してサーバー URL を実行時に変更できるようになっています。詳しくは、[WL.App.setServerUrl](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html?cp=SSHS8R_8.0.0#setServerUrl) を参照してください。

### ミニファイ
{: #minification }
MobileFirst Studio 7.1 には、コンパイル前に不要なすべての文字を削除することで JavaScript コードのサイズを削減する OOTB 方式が用意されていました。この削除された機能は、Cordova フックをプロジェクトに追加することで置き換えることができます。

JavaScript および CSS ファイルをミニファイするための多くのフックが使用可能です。これらのフックは、アプリケーションの **config.xml** ファイルの `before_prepare` イベント内に配置できます。

以下に、推奨されるフックをいくつか示します。

* [https://www.npmjs.com/package/uglify-js](https://www.npmjs.com/package/uglify-js)
* [https://www.npmjs.com/package/clean-css](https://www.npmjs.com/package/clean-css)

これらのフックは、プラグイン・ファイル内、またはアプリケーションの **config.xml** ファイル内で `<hook>` エレメントを使用して定義できます。  
以下の例では、`before_prepare` フック・イベントを使用して、Cordova がファイルを各プラットフォームの **www/** フォルダーにコピーする準備を始める前にコードをミニファイするためのスクリプトを実行します。

```html
<hook type="before_prepare" src="scripts/uglify.js" />
```
