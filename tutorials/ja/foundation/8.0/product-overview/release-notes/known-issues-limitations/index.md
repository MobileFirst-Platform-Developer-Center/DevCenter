---
layout: tutorial
title: 既知の問題および制限
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 既知の問題
{: #known-issues }
次のリンクをクリックし、この特定のリリースおよびその全フィックス・パックに関して、既知の問題とその解決策および関連のダウンロードを含む、動的に生成される資料リストを入手してください。[http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0)

## 既知の制限
{: #known-limitations }
本書では、以下のように、さまざまな場所に {{ site.data.keys.product_full }} の既知の制限の説明があります。

* 既知の制限が特定の機能に適用される場合、その記述は、その特定の機能を説明するトピックに含まれています。そのため、その制限が機能に与える影響を直ちに特定できます。
* 既知の制限が一般的なもので、直接関係しない可能性のある、さまざまなトピックに適用される場合は、ここで説明されています。

### グローバリゼーション
{: #globalization }
グローバル化されたアプリケーションを開発している場合は、以下の制約事項が適用されます。

* 部分的な翻訳: {{ site.data.keys.product }} v8.0 製品の一部 (資料を含む) は、中国語 (簡体字)、中国語 (繁体字)、フランス語、ドイツ語、イタリア語、日本語、韓国語、ポルトガル語 (ブラジル)、ロシア語、およびスペイン語に翻訳されています。ユーザーが直接目にするテキストが翻訳されています。
* 双方向言語サポート: {{ site.data.keys.product }}によって生成されたアプリケーションでは、完全な双方向が使用できるようにはなっていません。グラフィック・ユーザー・インターフェース (GUI) 要素の反映とテキスト方向の制御は、デフォルトでは提供されません。ただし、生成されたアプリケーションは、この制限に強く依存しているわけではありません。開発者は、生成されたコードを手動で調整することによって、完全な双方向準拠を達成することができます。

ヘブライ語への翻訳は、{{ site.data.keys.product }} の中核機能に用意されていますが、反映されない GUI 要素があります。

* アダプター名の制約: アダプターの名前は、Java クラス名を作成する際に有効な名前でなければなりません。また、名前に使用できるのは以下の文字のみです。
    * 大文字および小文字の英字 (A から Z および a から z)
    * 数字 (0 から 9)
    * 下線 (_)

* Unicode 文字: 基本多言語面の範囲外の Unicode 文字はサポートされません。
* 言語センシティビティーと Unicode 正規化形式: 以下のユース・ケースでは、さまざまな言語で検索機能が正しく実行されるように、通常のマッチング、アクセント・インセンシティブ、ケース・インセンシティブ、および 1 対 2 のマッピングなどの言語センシティビティーは照会で考慮されません。また、データに対する検索では正規化形式 C (NFC) を使用しません。
    * {{ site.data.keys.mf_analytics_console }} から、カスタム・グラフ用のカスタム・フィルターを作成する場合。ただし、このコンソールでは、メッセージ・プロパティーは正規化形式 C (NFC) を使用し、言語センシティビティーを考慮します。
    * {{ site.data.keys.mf_console }} から、「アプリケーションの参照」ページでアプリケーションを検索するか、「アダプターの参照」ページでアダプターを検索するか、「プッシュ」ページでタグを検索するか、「デバイス」ページでデバイスを検索する場合。
    * JSONStore API の Find 関数内。

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} には、以下の制限があります。

* セキュリティー分析 (セキュリティー検査に合格しなかった要求のデータ) はサポートされていません。
* {{ site.data.keys.mf_analytics_console }} では、数値の形式は、International Components for Unicode (ICU) の規則に従いません。
* {{ site.data.keys.mf_analytics_console }} では、数値はユーザーの推奨数値スクリプトを使用しません。
* {{ site.data.keys.mf_analytics_console }} では、日時および数値の形式は、Microsoft Internet Explorer のロケールではなく、オペレーティング・システムの言語設定に従って表示されます。
* カスタム・グラフ用のカスタム・フィルターを作成する場合、数値データは、0、1、2、3、4 、5 、6、 7、8、9 などの 10 進数 (Western/European) 表示にする必要があります。
* {{ site.data.keys.mf_analytics_console }} の「アラート管理 (Alert Management)」ページでアラートを作成する場合、数値データは、0、1、2、3、4、5、6、7、8、9 などの 10 進数 (西欧式) 表示にする必要があります。
* {{ site.data.keys.mf_console }} の「分析」ページは、以下のブラウザーをサポートします。
    * Microsoft Internet Explorer バージョン 10 以降
    * Mozilla Firefox ESR 以降
    * Apple Safari on iOS バージョン 7.0 以降
    * Google Chrome 最新バージョン
* Windows 用の Analytics クライアント SDK は提供されていません。


### {{ site.data.keys.mf_app_center_full }} モバイル・クライアント
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
Application Center モバイル・クライアントは、稼働しているデバイスの国/地域別情報 (日付の形式など) に従います。より厳密な International Components for Unicode (ICU) 規則に常に従うわけではありません。

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
{{ site.data.keys.mf_console }} には、以下の制限があります。

* 双方向言語については部分的なサポートのみを提供します。
* 通知メッセージが Android デバイスに送信されるときに、以下の場合はテキストの方向を変更できません。
    * 入力された最初の文字が、アラビア語やヘブライ語などのように右から左に記述される言語である場合、テキスト全体の方向は自動的に右から左になります。
    * 入力された最初の文字が、左から右に記述される言語である場合、テキスト全体の方向は自動的に左から右になります。
* 文字の順序とテキストの桁揃えは、双方向言語の文化的な方法には一致しません。
* 数値フィールドは、ロケールのフォーマット設定規則に従って数値を構文解析しません。コンソールは、フォーマット設定された数値を表示しますが、入力として受け入れるのは*未加工の* (フォーマット設定されていない) 数値のみです。例えば、1000 は受け入れ、1 000 や 1,000 は受け入れません。
* {{ site.data.keys.mf_console }} の「分析」ページの応答時間は、いくつかの要因に依存します。例えばハードウェア (RAM、CPU)、累積された分析データの量、および {{ site.data.keys.mf_analytics }} のクラスタリングなどです。{{ site.data.keys.mf_analytics }} を実稼働環境に統合する前に、負荷をテストすることを検討してください。

### サーバー構成ツール
{: #server-configuration-tool }
サーバー構成ツールには、以下の制約事項があります。

* サーバー構成の記述名に使用できる文字は、システムの文字セットに含まれる文字のみです。Windows の場合は、ANSI 文字セットです。
* 単一引用符または二重引用符文字を含むパスワードは、正しく機能しない可能性があります。
* サーバー構成ツールのコンソールには、デフォルト・コード・ページに含まれていないストリングの表示に関して、Windows コンソールと同じグローバリゼーション制限があります。

また、使用されているブラウザー、データベース管理システム、または Software Development Kit などの他の製品における制限のために、グローバリゼーションのさまざまな側面で、制約または異常が発生することがあります。例:

* Application Center のユーザー名およびパスワードは、ASCII 文字のみを使用して定義する必要があります。この制限は、WebSphere Application Server (完全プロファイルまたは Liberty プロファイル) が非 ASCII パスワードおよびユーザー名をサポートしないために存在します。ユーザー ID およびパスワードに有効な文字を参照してください。
* Windows の場合:
    * テスト・サーバーによって作成されたログ・ファイル内のローカライズされたメッセージを表示するには、UTF8 エンコードでこのログ・ファイルを開く必要があります。
    * これらの制限の原因は以下のとおりです。
        * テスト・サーバーが WebSphere Application Server Liberty プロファイル上にインストールされている場合、ローカライズされたメッセージには UTF8 エンコードを使用し、それ以外のメッセージには ANSI エンコードを使用してログ・ファイルが作成されます。

* Java 7.0 Service Refresh 4-FP2 およびそれより前のバージョンでは、Basic Multilingual Plane の一部でない Unicode 文字を入力フィールドに貼り付けられませんでした。この問題を回避するには、パス・フォルダーを手動で作成し、インストール時にそのフォルダーを選択してください。
* アラート、確認、およびプロンプトの各メソッドのカスタム・タイトル名とボタン名は、画面の端で切り捨てられないように短いものにしてください。
* JSONStore では正規化は処理されません。JSONStore API の Find 関数は、アクセント・インセンシティブ、ケース・インセンシティブ、および 1 対 2 のマッピングなどの言語センシティビティーを考慮しません。

### アダプターおよびサード・パーティー依存関係
{: #adapters-and-third-party-dependencies }
以下の既知の問題は、{{ site.data.keys.product_adj }} 共有ライブラリーを含め、アプリケーション・サーバー内の依存関係およびクラス間の対話に関係します。

#### Apache HttpClient
{: #apache-httpclient }
{{ site.data.keys.product }} は、内部で Apache HttpClient を使用します。Apache HttpClient インスタンスを Java アダプターへの依存関係として追加する場合、アダプターで `AdaptersAPI.executeAdapterRequest、AdaptersAPI.getResponseAsJSON`、および `AdaptersAPI.createJavascriptAdapterRequest` の各 API は正しく機能しません。API でシグニチャーに Apache HttpClient の型が含まれていることがその理由です。回避策は、提供された **pom.xml** 内の依存関係スコープを変更して、内部の Apache HttpClient を使用することです。

#### Bouncy Castle 暗号ライブラリー
{: #bouncy-castle-cryptographic-library }
{{ site.data.keys.product }} は Bouncy Castle 自体を使用します。アダプターで別のバージョンの Bouncy Castle を使用することは可能ですが、その結果を注意深く検査する必要があります。時には、{{ site.data.keys.product_adj }} Bouncy Castle コードによって `javax.security` パッケージ・クラスの特定の静的なシングルトン・フィールドにデータが設定され、アダプター内部にある Bouncy Castle のバージョンで、それらのフィールドに依存する機能を使用できなくなることがあります。

#### JAR ファイルの Apache CXF 実装
{: #apache-cxf-implementaton-of-jar-files }
CXF が {{ site.data.keys.product_adj }} JAX-RS 実装で使用され、Apache CXF JAR ファイルがアダプターに追加されないようにします。

### Application Center モバイル・クライアント: Android 4.0.x での最新表示の問題
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Android 4.0.x WebView コンポーネントでは、最新表示に関していくつかの問題があることが知られています。デバイスを Android 4.1.x にアップデートすると、ユーザー・エクスペリエンスが向上します。

ソースから Application Center クライアントをビルドする場合、Android マニフェスト内のアプリケーション・レベルでハードウェア・アクセラレーションを無効にすると、Android 4.0.x の状態が改善されます。その場合、Android SDK 11 以降を使用してアプリケーションをビルドする必要があります。

### Application Center では Application Center モバイル・クライアントのインポートとビルドに MobileFirst Studio V7.1が必要
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Application Center モバイル・クライアントをビルドするには、MobileFirst Studio V7.1 が必要です。MobileFirst Studio は[「ダウンロード」ページ]({{site.baseurl}}/downloads)からダウンロードできます。**「Previous MobileFirst Platform Foundation releases」**タブをクリックすると、ダウンロード・リンクが表示されます。インストール手順については、7.1 の IBM Knowledge Center 内の 『[MobileFirst Studio のインストール](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)』を参照してください。Application Center モバイル・クライアントのビルドについて詳しくは、『[モバイル・クライアントを使用するための準備](../../../appcenter/preparations)』を参照してください。

### Application Center と Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Application Center は、Microsoft Windows Phone 8.0 および Microsoft Windows Phone 8.1 用の Windows Phone アプリケーション・パッケージ (.xap) ファイルによるアプリケーションの配布をサポートします。Microsoft Windows Phone 8.1 で、Microsoft は Windows Phone 用にアプリケーション・パッケージ (.appx) ファイルという新しいユニバーサル・フォーマットを導入しました。現時点では、Application Center は、Microsoft Windows Phone 8.1 のアプリケーション・パッケージ (.appx) ファイルの配布をサポートせず、Windows Phone アプリケーション・パッケージ (.xap) ファイルのみに制限されています。

Application Center は、Microsoft Windows Store (デスクトップ・アプリケーション) の場合にのみ、アプリケーション・パッケージ (.appx) ファイルの配布をサポートします。

### Ant またはコマンド・ラインを使用した {{ site.data.keys.product_adj }} アプリケーションの管理
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
{{ site.data.keys.mf_dev_kit_full }} のみをダウンロードしてインストールした場合、**mfpadm** ツールは使用できません。mfpadm ツールは、インストーラーで、{{ site.data.keys.mf_server }} と共にインストールされます。

### 機密クライアント
{: #confidential-clients }
ASCII 文字は、機密クライアント ID と秘密の値にのみ使用します。

### ダイレクト・アップデート
{: #direct-update }
Windows でのダイレクト・アップデートは、V8.0.0 ではサポートされていません。

### FIPS 140-2 機能の制限
{: #fips-104-2-feature-limitations }
{{ site.data.keys.product }} で FIPS 140-2 機能を使用している場合、以下の既知の制限が適用されます。
* この FIPS 140-2 検証モードは、JSONStore 機能によって保管されたローカル・データの保護 (暗号化)、および {{ site.data.keys.product_adj }} クライアントと {{ site.data.keys.mf_server }} の間の HTTPS 通信の保護にのみ適用されます。
    * HTTPS 通信の場合、{{ site.data.keys.product_adj }} クライアントと {{ site.data.keys.mf_server }} の間の通信のみが、クライアントで FIPS 140-2 ライブラリーを使用します。その他のサーバーまたはサービスへの直接接続では、FIPS 140-2 ライブラリーを使用しません。
* この機能は、iOS および Android プラットフォームでのみサポートされます。
    * Android では、この機能は、x86 または armeabi アーキテクチャーを使用するデバイスまたはシミュレーターでのみサポートされます。armv5 または armv6 アーキテクチャーを使用する Android ではサポートされません。これは、使用される OpenSSL ライブラリーが、Android の armv5 または armv6 のための FIPS 140-2 検証を取得していないためです。{{ site.data.keys.product_adj }} ライブラリーは 64 ビット・アーキテクチャーをサポートしていますが、 FIPS 140-2 は 64 ビット・アーキテクチャーではサポートされていません。FIPS 140-2 を 64 ビットのデバイス上で実行できるのは、プロジェクトに 32 ビットのネイティブ NDK ライブラリーのみが含まれる場合です。
    * iOS では、i386、x86_64、armv7、armv7s、および arm64 アーキテクチャーでサポートされます。
* この機能は、ハイブリッド・アプリケーションのみで機能します (ネイティブ・アプリケーションでは機能しません)。
* ネイティブ iOS の場合、FIPS は iOS FIPS ライブラリーを通じて有効になります。これはデフォルトで有効になっています。FIPS 140-2 を有効にするために、アクションは必要ありません。
* クライアントでのユーザー登録機能の使用は、FIPS 140-2 機能ではサポートされていません。
* Application Center クライアントは、FIPS 140-2 機能をサポートしません。

### Application Center または {{ site.data.keys.mf_server }} へのフィックスパックまたは暫定修正のインストール
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Application Center または {{ site.data.keys.mf_server }} にフィックスパックまたは暫定修正を適用する際には、手動操作が必要であり、一定の時間、アプリケーションをシャットダウンしなければならないことがあります。

### JSONStore でサポートされるアーキテクチャー
{: #jsonstore-supported-architectures }
Android の場合、JSONStore は、ARM、ARM v7、および x86 32 ビットの各アーキテクチャーをサポートしています。他のアーキテクチャーは、現在サポートされていません。他のアーキテクチャーを使用しようとした場合、例外が発生し、アプリケーションの異常終了が発生する可能性もあります。

Windows ネイティブ・アプリケーションでは、JSON ストアはサポートされていません。

### Liberty サーバーの制限
{: #liberty-server-limitations }
32 ビット JDK 7 で Liberty サーバーを使用すると、Eclipse が開始しない場合があります。そして、次のエラーを受信する場合があります。"Error occurred during initialization of VM. Could not reserve enough space for object heap. Error: Could not create the Java Virtual Machine. Error: A fatal exception has occurred. Program will exit."

この問題を修正するには、64 ビット Windows と 64 ビット Eclipse の環境で 64 ビット JDK を使用してください。64 ビット・コンピューターで 32 ビット JDK を使用する場合は、JVM の設定を **mx512m** と **-Xms216m** に構成する場合があります。

### LTPA トークン制限
{: #ltpa-token-limitations }
ユーザー・セッションの有効期限が切れ前に LTPA トークンの有効期限が切れると、`SESN0008E` 例外が発生します。

LTPA トークンは、同時ユーザー・セッションと関連しています。LTPA トークンの有効期限が切れる前にこのセッションの有効期限が切れると、新しいセッションが自動的に作成されます。しかし、ユーザー・セッションの有効期限が切れる前に LTPA トークンの有効期限が切れると、以下の例外が発生します。

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E: A user authenticated as anonymous has attempted to access a session owned by {user name}`

この制限を解決するには、LTPA トークンの有効期限が切れる際に、ユーザー・セッションの有効期限を強制的に切る必要があります。
* WebSphere Application Server Liberty で、server.xml ファイルの httpSession 属性 invalidateOnUnauthorizedSessionRequestException を true に設定します。
* WebSphere Application Server で、セッション管理カスタム・プロパティー InvalidateOnUnauthorizedSessionRequestException に値 true を追加して問題を修正します。

**注:** 特定のバージョンの WebSphere Application Server または WebSphere Application Server Liberty で、例外が記録されますが、セッションは正しく無効化されています。詳しくは、[APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141) を参照してください。

### Microsoft Windows Phone 8
{: #microsoft-windows-phone-8 }
Windows Phone 8.1 環境では、x64 アーキテクチャーはサポートされていません。

### Microsoft Windows 10 UWP アプリケーション
{: #microsoft-windows-10-uwp-apps }
{{ site.data.keys.product_adj }} SDK が NuGet パッケージを通じてインストールされた場合、アプリケーション認証性フィーチャーは、{{ site.data.keys.product_adj }} Windows 10 UWP アプリケーションでは機能しません。回避策として、開発者は NuGet パッケージをダウンロードして {{ site.data.keys.product_adj }} SDK 参照を手動で追加することができます。

### ネストされたプロジェクトは CLI では予測不能な結果になることがある
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
{{ site.data.keys.mf_cli }} を使用しているときには、プロジェクトが互いの内部に入るようにネストさせないでください。そのようにネストしている場合、影響を受けるプロジェクトが、予期したものではない可能性があります。

### {{ site.data.keys.mf_mbs }} を使用した Cordova Web リソースのプレビュー
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
{{ site.data.keys.mf_mbs }} で Web リソースをプレビューすることができますが、そのシミュレーターですべての {{ site.data.keys.product_adj }} JavaScript API がサポートされているわけではありません。特に、OAuth プロトコルは完全にはサポートされていません。ただし、`WLResourceRequest` を使用したアダプターの呼び出しをテストすることはできます。

### 拡張アプリケーション認証性のテストには物理 iOS デバイスが必要
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
拡張アプリケーション認証性機能のテストには、物理 iOS デバイスが必要です。これは、iOS シミュレーターに IPA をインストールできないためです。

### {{ site.data.keys.mf_server }} による Oracle 12c のサポート
{: #support-of-oracle-12c-by-mobilefirst-server }
{{ site.data.keys.mf_server }} のインストール・ツール (Installation Manager、サーバー構成ツール、および Ant タスク) は、データベースとして Oracle 12c を用いるインストールをサポートしています。

インストール・ツールでユーザーおよび表を作成できますが、インストール・ツールを実行する前に 1 つ以上のデータベースが存在している必要があります。

### プッシュ通知のサポート
{: #support-for-push-notification }
非セキュア・プッシュは、Cordova でサポートされています (iOS および Android 上)。

### cordova-ios プラットフォームの更新
{: #updating-cordova-ios-platform }
Cordova アプリケーションの cordova-ios プラットフォームを更新するには、以下のステップを完了することによって、プラットフォームをアンインストールして、再インストールする必要があります。

1. コマンド・ライン・インターフェースを使用して、アプリケーションのプロジェクト・ディレクトリーに移動します。
2. `cordova platform rm ios` コマンドを実行して、プラットフォームを削除します。
3. `cordova platform add ios@version` コマンドを実行して、アプリケーションに新しいプラットフォームを追加します。ここで、version は Cordova iOS プラットフォームのバージョンです。
4. `cordova prepare` コマンドを実行して、変更を組み込みます。

`cordova platform update ios` コマンドを使用すると、更新は失敗します。

### Web アプリケーション
{: #web-applications }
Web アプリケーションには以下の制限があります。
- {: #web_app_limit_ms_ie_n_edge }
Microsoft Internet Explorer (IE) および Microsoft Edge では、管理アプリケーション・メッセージとクライアント Web SDK メッセージはオペレーティング・システムの地域形式の設定に従って表示されます。構成されているブラウザーやオペレーティング・システムの表示言語の設定に従って表示されるものではありません。[複数言語での管理者メッセージの定義](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages)も参照してください。

### iOS Cordova アプリケーション用の WKWebView のサポート
{: #wkwebview-support-for-ios-cordova-applications }
アプリケーション通知およびダイレクト・アップデート機能は、 WKWebView を使用する場合、iOS Cordova アプリケーションで適切に機能しない可能性があります。

この制限は、**cordova-plugin-wkwebview-engine** において file:// url XmlHttpRequests が WKWebViewEgine で許可されないという障害によるものです。

この問題を回避するには、Cordova プロジェクト内で次のコマンドを実行します。`cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`

このコマンドを実行すると Cordova アプリケーション内のローカル Web サーバーを実行することになり、これで、ファイル URI スキーム (file://) を使用しないでローカル・ファイルのホストおよびアクセスを行って、これらのファイルを操作できます。

**注:** この Cordova プラグインは、ノード・パッケージ・マネージャー (npm) には公開されません。

### cordova-plugin-statusbar は、cordova-plugin-mfp を使用してロードされた Cordova アプリケーションでは動作しません。
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
cordova-plugin-statusbar は、cordova-plugin-mfp を使用してロードされた Cordova アプリケーションでは動作しません。

この問題を回避するには、開発者は、`CDVViewController` をルート・ビュー・コントローラーとして設定する必要があります。Cordova iOS プロジェクトの **MFPAppdelegate.m** ファイル内で、`wlInitDidCompleteSuccessfully` メソッド内のコード・スニペットを以下に推奨するように置き換えます。

既存のコード・スニペット:

```objc
(void)wlInitDidCompleteSuccessfully
{
UIViewController* rootViewController = self.window.rootViewController; 
// Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
// Adjust the Cordova view controller view frame to match its parent view bounds 
cordovaViewController.view.frame = rootViewController.view.bounds; 
// Display the Cordova view [rootViewController addChildViewController:cordovaViewController]; 
[rootViewController.view addSubview:cordovaViewController.view]; 
[cordovaViewController didMoveToParentViewController:rootViewController]; 
}
```

制限の回避策として推奨されるコード・スニペット:

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Create a Cordova View Controller 
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ; 
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath]; 
[self.window setRootViewController:cordovaViewController]; 
[self.window makeKeyAndVisible];
}
```

### 未加工の IPv6 アドレスは Android アプリケーションでサポートされない
{: #raw-ipv6-address-not-supported-in-android-applications }
ネイティブ Android アプリケーションの **mfpclient.properties** の構成時に、{{ site.data.keys.mf_server }} が IPv6 アドレスのホスト上にある場合、IPv6 アドレスのマップされたホスト名を使用して **mfpclient.properties** 内の **wlServerHost** プロパティーを構成します。**wlServerHost** プロパティーを未加工の IPv6 アドレスを使用して構成すると、アプリケーションの {{ site.data.keys.mf_server }} への接続は失敗します。

### Cordova アプリケーションのデフォルトの動作の変更は推奨されない
{:  #modifying_default_behaviour_of_a_cordova_app_is_not_recommended}
{{ site.data.keys.product_adj }} Cordova SDK がプロジェクトに追加されるときに、Cordova アプリケーションのデフォルトの動作を変更する (「戻る」ボタンの動作をオーバーライドするなど) と、送信時に、Google Play Store によってアプリケーションが拒否される原因となることがあります。
Google Play Store へのサブミットに関する他の障害については、Google サポートにお問い合わせください。
