---
layout: tutorial
title: アプリケーション認証性
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
アプリケーションは、HTTP 要求を発行することで、{{site.data.keys.mf_server }} からアクセスできる企業の HTTP サービス (API) にアクセスできます。事前定義されているアプリケーション認証性[セキュリティー検査](../)によって、{{site.data.keys.mf_server }} インスタンスに接続しようとするアプリケーションが認証済みのアプリケーションであることが保証されます。

アプリケーション認証性を有効にするには、**{{site.data.keys.mf_console }}** →**「 [ご使用のアプリケーション] 」**→**「認証性」**の画面上の指示に従うか、下記の情報を参考にできます。

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

## アプリケーション認証性フロー
{: #application-authenticity-flow }
デフォルトで、アプリケーション認証性セキュリティー検査は、{{site.data.keys.mf_server }} へのアプリケーションのランタイム登録時に実行されます。これは、アプリケーションのインスタンスが初めてサーバーに接続しようとしたときに行われます。その後、認証性チャレンジが再度発生することはありません。

この動作をカスタマイズする方法については、[アプリケーション認証性の構成](#configuring-application-authenticity)を参照してください。

## アプリケーション認証性の有効化
{: #enabling-application-authenticity }
Cordova アプリケーションまたはネイティブ・アプリケーションのアプリケーション認証性を有効にするためには、mfp-app-authenticity ツールを使用してアプリケーション・バイナリー・ファイルに署名する必要があります。適格なバイナリー・ファイルは、iOS の場合は `ipa`、Android の場合は `apk`、および Windows 8.1 Universal と Windows 10 UWP の場合は `appx` です。

1. **{{site.data.keys.mf_console }} →「ダウンロード・センター」**から mfp-app-authenticity ツールをダウンロードします。
2. **コマンド・ライン**・ウィンドウを開き、コマンド `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file` を実行します。

   例えば、次のとおりです。


   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   このコマンドは、`MyBankApp.ipa` ファイルの次に `MyBankApp.authenticity_data` という名前の `.authenticity_data` ファイルを生成します。

3. 任意のブラウザーで {{site.data.keys.mf_console }} を開きます。
4. ご使用のアプリケーションをナビゲーション・サイドバーから選択し、**「認証性」**メニュー項目をクリックします。
5. **「認証性ファイルのアップロード」**をクリックして `.authenticity_data` ファイルをアップロードします。

`.authenticity_data` ファイルがアップロードされると、アプリケーション認証性が有効になります。

![アプリケーション認証性を有効にする](enable_application_authenticity.png)

### アプリケーション認証性の無効化
{: #disabling-application-authenticity }
アプリケーション認証性を無効にするには、**「認証性ファイルの削除」**ボタンをクリックします。

## アプリケーション認証性の構成
{: #configuring-application-authenticity }
デフォルトで、アプリケーション認証性はクライアント登録時にのみチェックされます。その他のセキュリティー検査と同じように、[リソースの保護](../#protecting-resources)の説明にしたがって、コンソールから `appAuthenticity` セキュリティー検査を使用してアプリケーションまたはリソースを保護できます。

以下のプロパティーを使用して、事前定義されているアプリケーション認証性セキュリティー検査を構成できます。

- `expirationSec`: デフォルトは、3600 秒 (1 時間) に設定されます。認証性トークンが期限切れになるまでの期間を定義します。

認証性チェックが完了した後は、設定されている値に基づいてトークンが期限切れになるまで、チェックが再度行われることはありません。

#### `expirationSec` プロパティーを構成するには、次のようにします。
{: #to-configure-the-expirationsec property }
1. {{site.data.keys.mf_console }} をロードし、**「 [ご使用のアプリケーション] 」**→**「セキュリティー」**→**「セキュリティー検査の構成」**にナビゲートし、**「新規」**をクリックします。

2. `appAuthenticity` スコープ・エレメントを検索します。

3. 新しい値を秒数で設定します。

![コンソールでの expirationSec プロパティーの構成](configuring_expirationSec.png)
