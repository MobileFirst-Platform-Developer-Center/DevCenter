---
layout: tutorial
title: アプリケーション認証性
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

アプリケーションを適切に保護するには、事前定義の{{ site.data.keys.product_adj }}アプリケーション認証性[セキュリティー検査](../#security-checks) (`appAuthenticity`) を有効にします。この検査は、有効になっている場合、アプリケーションにサービスを提供する前に、アプリケーションの認証性を検証します。実稼働環境のアプリケーションでは、この機能が有効になっている必要があります。

アプリケーション認証性を有効にするには、**{{ site.data.keys.mf_console }}** →**「 [ご使用のアプリケーション] 」**→**「認証性」**の画面上の指示に従うか、下記の情報を参考にできます。

#### 可用性
{: #availability }
* アプリケーション認証性は、サポートされるすべてのプラットフォーム (iOS、Android、Windows 8.1 Universal、Windows 10 UWP) において Cordova アプリケーションとネイティブ・アプリケーションの両方で使用できます。

#### 制限
{: #limitations }
* アプリケーション認証性は、iOS の **Bitcode** はサポートしません。したがって、アプリケーション認証性を使用する前に、Xcode プロジェクトのプロパティーで Bitcode を使用不可に設定してください。

#### ジャンプ先:
{: #jump-to }
- [アプリケーション認証性フロー](#application-authenticity-flow)
- [アプリケーション認証性の有効化](#enabling-application-authenticity)
- [アプリケーション認証性の構成](#configuring-application-authenticity)
- [Build Time Secret (BTS)](#bts)
- [トラブルシューティング](#troubleshooting)
  - [リセット](#reset)
  - [検証タイプ](#validation)
  - [SDK バージョン 8.0.0.0-MFPF-IF201701250919 以前のサポート](#legacy)

## アプリケーション認証性フロー
{: #application-authenticity-flow }
アプリケーション認証性セキュリティー検査は、{{ site.data.keys.mf_server }} へのアプリケーションの登録中に実行されます。これは、アプリケーションのインスタンスが初めてサーバーに接続しようとしたときに行われます。デフォルトでは、認証性チェックは再実行されません。

この動作をカスタマイズする方法については、[アプリケーション認証性の構成](#configuring-application-authenticity)を参照してください。

## アプリケーション認証性の有効化
{: #enabling-application-authenticity }
アプリケーションでアプリケーション認証性を有効にするには、以下のようにします。

1. 任意のブラウザーで {{ site.data.keys.mf_console }} を開きます。
2. ご使用のアプリケーションをナビゲーション・サイドバーから選択し、**「認証性」**メニュー項目をクリックします。
3. **「状況」**ボックスで**「オン/オフ」**ボタンを切り替えます。

![アプリケーション認証性を有効にする](enable_application_authenticity.png)

### アプリケーション認証性の無効化
{: #disabling-application-authenticity }
開発中に行われたアプリケーションに対する変更によっては、認証性の検証が失敗することがあります。したがって、開発プロセス中にはアプリケーション認証性を無効にすることをお勧めします。実稼働環境のアプリケーションでは、この機能が有効になっている必要があります。

アプリケーション認証性を無効にするには、**「状況」**ボックスで**「オン/オフ」**ボタンを再度切り替えます。

## アプリケーション認証性の構成
{: #configuring-application-authenticity }
デフォルトで、アプリケーション認証性はクライアント登録時にのみチェックされます。ただし、その他のセキュリティー検査と同じように、[リソースの保護](../#protecting-resources)の説明に従って、コンソールから `appAuthenticity` セキュリティー検査を使用してアプリケーションやリソースを保護できます。

以下のプロパティーを使用して、事前定義されているアプリケーション認証性セキュリティー検査を構成できます。

- `expirationSec`: デフォルトは、3600 秒 (1 時間) に設定されます。認証性トークンが期限切れになるまでの期間を定義します。

認証性チェックが完了した後は、設定されている値に基づいてトークンが期限切れになるまで、チェックが再度行われることはありません。

#### `expirationSec` プロパティーを構成するには、次のようにします。
{: #to-configure-the-expirationsec property }
1. {{ site.data.keys.mf_console }} をロードし、**「 [ご使用のアプリケーション] 」**→**「セキュリティー」**→**「セキュリティー検査の構成」**にナビゲートし、**「新規」**をクリックします。

2. `appAuthenticity` スコープ・エレメントを検索します。

3. 新しい値を秒数で設定します。

![コンソールでの expirationSec プロパティーの構成](configuring_expirationSec.png)

## Build Time Secret (BTS)
{: #bts }
Build Time Secret (BTS) は、iOS アプリケーション専用の、**認証性の検証を強化するためのオプション・ツール**です。このツールは、ビルド時に決定され、かつ後から認証性の検証プロセスで使用される秘密鍵をアプリケーションに注入します。

BTS ツールは、**{{ site.data.keys.mf_console }}** →**「ダウンロード・センター」**からダウンロードできます。

Xcode で BTS ツールを使用するには、以下のようにします。
1. **「ビルド・フェーズ (Build Phases)」**タブで、**+** ボタンをクリックして、新規の**「スクリプト・フェーズの実行 (Run Script Phase)」**を作成します。
2. BTS ツールのパスをコピーして、作成した新規の「スクリプト・フェーズの実行 (Run Script Phase)」に貼り付けます。
3. 「スクリプト・フェーズの実行 (run script phase)」を**「ソースのコンパイル (Compile sources)」**フェーズの上にドラッグします。

実動バージョンのアプリケーションをビルドする際には、このツールを使用する必要があります。

## トラブルシューティング
{: #troubleshooting }

### リセット
{: #reset }
アプリケーション認証性アルゴリズムは、アプリケーション・データとメタデータを検証で使用します。アプリケーション認証性を有効にした後でサーバーに接続する最初のデバイスが、このデータの一部を含む、アプリケーションの「指紋」を提供します。

この指紋は、アルゴリズムに新規データを提供することでリセットできます。これは、開発中 (例えば、Xcode でのアプリケーションの変更後) に役立ちます。指紋をリセットするには、[**mfpadm** CLI](../../administering-apps/using-cli/) から **reset** コマンドを使用します。

指紋のリセット後に、appAuthenticity セキュリティー検査は以前と同じように動作し続けます (これは、ユーザーには認識されません)。

### 検証タイプ
{: #validation }

デフォルトでは、アプリケーション認証性が有効になっている場合、**動的**検証アルゴリズムが使用されます。動的なアプリケーション認証性検証では、モバイル・プラットフォーム固有の機能を使用して、アプリケーションの認証性を判別します。したがって、後方互換性のない変更をモバイル・オペレーティング・システムに導入した場合、検証が影響を受け、信頼できるアプリケーションがサーバーに接続できなくなる可能性があります。

そのような潜在的な問題を緩和するには、**静的**検証アルゴリズムを使用できます。この検証タイプは、OS 固有の変更に左右されにくくなっています。

検証タイプを切り替えるには、以下の [**mfpadm** CLI](../../administering-apps/using-cli/) を使用します。

```bash
app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-validation TYPE
```
`TYPE` には、`dynamic` または `static` のいずれかを指定できます。

### SDK バージョン 8.0.0.0-MFPF-IF201701250919 以前のサポート
{: #legacy }
動的検証タイプと静的検証タイプは、**2017 年 2 月以降**にリリースされたクライアント SDK でのみサポートされます。SDK バージョン **8.0.0.0-MFPF-IF201701250919 以前**では、レガシー・アプリケーション認証性ツールを使用してください。

mfp-app-authenticity ツールを使用してアプリケーション・バイナリー・ファイルに署名する必要があります。適格なバイナリー・ファイルは、iOS の場合は `ipa`、Android の場合は `apk`、および Windows 8.1 Universal と Windows 10 UWP の場合は `appx` です。

1. **{{ site.data.keys.mf_console }} →「ダウンロード・センター」**から mfp-app-authenticity ツールをダウンロードします。
2. **コマンド・ライン**・ウィンドウを開き、コマンド `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file` を実行します。

   例えば、次のとおりです。

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   このコマンドは、`MyBankApp.ipa` ファイルの次に `MyBankApp.authenticity_data` という名前の `.authenticity_data` ファイルを生成します。
3. 以下の [**mfpadm** CLI](../../administering-apps/using-cli/) を使用して `.authenticity_data` ファイルをアップロードします。
  ```bash
  app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-data FILE
  ```
