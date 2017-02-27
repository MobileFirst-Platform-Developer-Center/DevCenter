---
layout: tutorial
title: iOS アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
MobileFirst Foundation SDK は、[CocoaPods](http://guides.cocoapods.org) を通じて入手可能な pod の集合で構成されます。この SDK は、Xcode プロジェクトに追加できます。  
これらの pod は、次のようなコア機能およびその他の機能に対応しています。

* **IBMMobileFirstPlatformFoundation** - クライアントとサーバー間の接続を実装し、認証およびセキュリティーの各側面、リソース要求、およびその他の必要なコア機能を処理します。
* **IBMMobileFirstPlatformFoundationJSONStore** - JSONStore のフレームワークを含んでいます。詳しくは、[iOS 用 JSONStore に関するチュートリアル](../../jsonstore/ios/)を参照してください。
* **IBMMobileFirstPlatformFoundationPush** - プッシュ通知のフレームワークを含んでいます。詳しくは、[通知に関するチュートリアル](../../../notifications/)を参照してください。
* **IBMMobileFirstPlatformFoundationWatchOS** - Apple WatchOSのサポートを含んでいます。

このチュートリアルでは、CocoaPods を使用して MobileFirst ネイティブ SDK を新規または既存の iOS アプリケーションに追加する方法について学習します。また、アプリケーションを認識するように {{ site.data.keys.mf_server }} を構成する方法についても学習します。

**前提条件:**

- Xcode と MobileFirst CLI が開発者のワークステーションにインストールされている。  
- {{ site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [MobileFirst 開発環境のセットアップ](../../../installation-configuration/development/mobilefirst)、および [iOS 開発環境のセットアップ](../../../installation-configuration/development/ios)の両チュートリアルを読む。

> **注:** XCode 8 を使用してシミュレーターで iOS アプリケーションを実行している間は、**キーチェーン共有**機能が必須です。

#### ジャンプ先:
{: #jump-to }
- [MobileFirst ネイティブ SDK の追加](#adding-the-mobilefirst-native-sdk)
- [MobileFirst Native SDK の手動での追加](#manually-adding-the-mobilefirst-native-sdk)
- [Apple watchOS のサポートの追加](#adding-support-for-apple-watchos)
- [MobileFirst ネイティブ SDK の更新](#updating-the-mobilefirst-native-sdk)
- [生成される MobileFirst Native SDK 成果物](#generated-mobilefirst-native-sdk-artifacts)
- [ビットコードと TLS 1.2](#bitcode-and-tls-12)
- [次に使用するチュートリアル](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} ネイティブ SDK の追加
{: #adding-the-mobilefirst-native-sdk }
以下の手順に従って、新規または既存の Xcode プロジェクトに {{ site.data.keys.product }} ネイティブ SDK を追加し、アプリケーションを {{ site.data.keys.mf_server }} に登録します。

開始する前に、{{ site.data.keys.mf_server }} が稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、コマンド `./run.sh` を実行します。

### アプリケーションの作成
{: #creating-an-application }
Xcode プロジェクトを作成するか、または既存のプロジェクト (Swift または Objective-C) を使用します。  

### SDK の追加
{: #adding-the-sdk }
1. {{ site.data.keys.product }} ネイティブ SDK は CocoaPods 経由で提供されます。
    - [CocoaPods](http://guides.cocoapods.org) が既に開発環境にインストールされている場合は、ステップ 2 に進みます。
    - CocoaPods がインストールされていない場合は、次のようにしてインストールしてください。  
        - **コマンド・ライン**・ウィンドウを開き、Xcode プロジェクトのルートに移動します。
        - `sudo gem install cocoapods` コマンドに続けて `pod setup` コマンドを実行します。**注:** これらのコマンドは、完了するのに数分かかることがあります。
2. 次のコマンドを実行します。`pod init`。これは `Podfile` を作成します。
3. 好みのコード・エディターを使用して、この `Podfile` を開きます。
    - このファイルのコンテンツをコメントにして取り除くか、削除します。
    - 以下の行を追加し、変更を保存します。

      ```xml
      use_frameworks!

      platform :ios, 8.0
      target "Xcode-project-target" do
          pod 'IBMMobileFirstPlatformFoundation'
      end
      ```
      - **Xcode-project-target** を、Xcode プロジェクトのターゲットの名前に置き換えます。

4. コマンド・ライン・ウィンドウに戻り、`pod install` コマンドに続けて、`pod update` コマンドを実行します。これらのコマンドは、{{ site.data.keys.product }} ネイティブ SDK ファイルの追加、**mfpclient.plist** ファイルの追加、および Pod プロジェクトの生成を行います。  
    **注:** コマンドは、完了するのに数分かかることがあります。

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要**: これ以降、プロジェクトを Xcode で開くには、`[ProjectName].xcworkspace` ファイルを使用してください。`[ProjectName].xcodeproj` ファイルは使用**しないでください**。CocoaPods ベースのプロジェクトは、アプリケーション (実行可能ファイル) およびライブラリー (CocoaPods マネージャーがプルするすべてのプロジェクト依存関係) を含むワークスペースとして管理されます。

### {{ site.data.keys.product_adj }} ネイティブ SDK の手動での追加
{: manually-adding-the-mobilefirst-native-sdk }
次のように、{{ site.data.keys.product }} SDK を手動で追加することもできます。

<div class="panel-group accordion" id="adding-the-sdk" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>クリックして手順を表示</b></a>
            </h4>
        </div>

        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} SDK を手動で追加するには、まず最初に<b>「{{ site.data.keys.mf_console }}」→「ダウンロード・センター」→「SDK」</b>タブで SDK の .zip ファイルをダウンロードします。</p>

                <ul>
                    <li>Xcode プロジェクト内で、{{ site.data.keys.product }} フレームワーク・ファイルをプロジェクトに追加します。
                        <ul>
                            <li>プロジェクト・エクスプローラーでプロジェクト・ルート・アイコンを選択します。</li>
                            <li><b>「ファイル (File)」→「ファイルの追加 (Add Files)」</b>を選択し、前にダウンロードしたフレームワーク・ファイルが含まれているフォルダーに移動します。</li>
                            <li><b>「オプション (Options)」</b>ボタンをクリックします。</li>
                            <li><b>「必要な場合は項目をコピー (Copy items if needed)」</b>と、<b>「追加されたすべてのフォルダー用にグループを作成 (Create groups for any added folders)」</b>を選択します。<br/>
                            <b>注:</b> <b>「必要な場合は項目をコピー (Copy items if needed)」</b>オプションが選択されていないと、フレームワーク・ファイルは、コピーされずに、元の場所からリンクされます。</li>
                            <li>メイン・プロジェクト (最初のオプション) を選択し、アプリケーション・ターゲットを選択します。</li>
                            <li><b>「一般 (General)」</b>タブで、<b>「リンクされたフレームワークおよびライブラリー (Linked Frameworks and Libraries)」</b>に自動的に追加されるフレームワークがあれば除去します。</li>
                            <li>必須: <b>「組み込みバイナリー (Embedded Binaries)」</b>で、次のフレームワークを追加します。
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundation.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationOpenSSLUtils.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationWatchOS.framework</li>
                                    <li>Localizations.bundle</li>
                                </ul>
                                このステップを実行すると、これらのフレームワークが<b>「リンクされたフレームワークおよびライブラリー (Linked Frameworks and Libraries)」</b>に自動的に追加されます。
                            </li>
                            <li><b>「リンクされたフレームワークおよびライブラリー (Linked Frameworks and Libraries)」</b>で、以下のフレームワークを追加します。
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundationJSONStore.framework</li>
                                    <li>sqlcipher.framework</li>
                                    <li>openssl.framework</li>
                                </ul>
                            </li>
                            <blockquote><b>注:</b> これらのステップでは、関連する {{ site.data.keys.product }} フレームワークをプロジェクトにコピーし、「ビルド・フェーズ (Build Phases)」タブの「バイナリーをライブラリーとリンク (Link Binary with Libraries)」リスト内でこれらのファイルをリンクします。これらのファイルを元のロケーションにリンクする (前の説明のように「必要な場合は項目をコピー (Copy items if needed)」オプションを選択しない) には、以下に説明されているように「フレームワーク検索パス (Framework Search Paths)」を設定する必要があります。</blockquote>
                        </ul>
                    </li>
                    <li>ステップ 1 で追加されたフレームワークは、<b>「ビルド・フェーズ (Build Phases)」</b>タブの<b>「バイナリーをライブラリーとリンク (Link Binary with Libraries)」</b>セクションに自動的に追加されます。</li>
                    <li><i>オプション:</i> 上に記述されているようにフレームワーク・ファイルをプロジェクトにコピーしなかった場合、<b>「ビルド・フェーズ (Build Phases)」</b>タブで、<b>「必要な場合は項目をコピー (Copy items if needed)」</b>オプションを使用して以下の手順を行います。
                        <ul>
                            <li><b>「ビルド設定 (Build Settings)」</b>ページを開きます。</li>
                            <li><b>「検索パス (Search Paths)」</b>セクションを見つけます。</li>
                            <li>フレームワークが含まれているフォルダーのパスを<b>「フレームワーク検索パス (Framework Search Paths)」</b>フォルダーに追加します。</li>
                        </ul>
                    </li>
                    <li><b>「ビルド設定 (Build Settings)」</b>タブの<b>「デプロイメント (Deployment)」</b>セクションで、<b>「iOS デプロイメント・ターゲット (iOS Deployment Target)」</b>フィールドに 8.0 以上の値を選択します。</li>
                    <li><i>オプション:</i> Xcode 7 以降、デフォルトでビットコードが設定されるようになりました。制限事項および要件については、『<a href="additional-information/#working-with-bitcode-in-ios-apps">iOS アプリケーションでのビットコードの処理 (Working with bitcode in iOS apps)</a>』を参照してください。ビットコードを無効にするには、以下のようにします。
                        <ul>
                            <li><b>「ビルド・オプション (Build Options)」</b>セクションを開きます。</li>
                            <li><b>「ビットコードを有効にする (Enable Bitcode)」</b>を 「<b>いいえ</b>」に設定します。</li>
                        </ul>
                    </li>
                    <li>Xcode 7 以降、TLS の適用が必須になりました。『<a href="additional-information/#enforcing-tls-secure-connections-in-ios-apps">iOS アプリケーションでの TLS セキュア接続の適用</a>』を参照してください。</li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

### アプリケーションの登録
{: #registering-the-application }
1. **コマンド・ライン**・ウィンドウを開き、Xcode プロジェクトのルートに移動します。  

2. 次のコマンドを実行します:

    ```bash
    mfpdev app register
    ```
    - リモート・サーバーを使用する場合は、[`mfpdev server add` コマンドを使用](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)して、そのサーバーを追加します。

    アプリケーションのバンドル ID を指定するよう求められます。**重要**: バンドル ID **は大/小文字が区別**されます。  

`mfpdev app register` CLI コマンドは、まず最初に {{ site.data.keys.mf_server }} に接続してアプリケーションを登録した後、Xcode プロジェクトのルートに **mfpclient.plist** ファイルを生成し、これに {{ site.data.keys.mf_server }} を識別するメタデータを追加します。  

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** 次のように、{{ site.data.keys.mf_console }} からアプリケーションを登録することもできます。    
>
> 1. {{ site.data.keys.mf_console }} をロードします。
> 2. **「アプリケーション」**の横の**「新規」**ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。  
> 3. アプリケーションが登録されたら、そのアプリケーションの**「構成ファイル」**タブに移動して、**mfpclient.plist** ファイルをコピーまたはダウンロードします。画面上に表示される指示に従って、ファイルをプロジェクトに追加します。

### セットアップ・プロセスの完了
{: #completing-the-setup-process }
Xcode で、プロジェクト・エントリーを右クリックし、**「ファイルを [プロジェクト名] に追加 (Add Files To [ProjectName])」**をクリックし、Xcode プロジェクトのルートに配置されている **mfpclient.plist** ファイルを選択します。

### SDK の参照
{: #referencing-the-sdk }
{{ site.data.keys.product }} ネイティブ SDK を使用する場合はいつでも、必ず {{ site.data.keys.product }} フレームワークをインポートするようにしてください。

Objective-C:

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
```

Swift:

```swift
import IBMMobileFirstPlatformFoundation
```

<br>
#### iOS 9 以上に関する注:
{: #note-about-ios-9-and-above }
> Xcode 7 以降、[アプリケーション・トランスポート・セキュリティー (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14) がデフォルトで有効になっています。開発中にアプリケーションを実行する場合、ATS ([詳しく読む](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)) を無効にすることができます。
>   1. Xcode で、右クリックにより**「[プロジェクト]/info.plist ファイル」→「指定して開く」→「ソース・コード」**を選択します。
>   2. 以下を貼り付けます。
> 
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```

## Apple watchOS のサポートの追加
{: #adding-support-for-apple-watchos}
Apple watchOS 2 以降用に開発している場合、Podfile には、メイン・アプリケーションおよび watchOS 拡張に対応したセクションが含まれている必要があります。
watchOS 2 の場合の次の例を参照してください。

```xml
# Replace with the name of your watchOS application
xcodeproj 'MyWatchApp'

use_frameworks!

#use the name of the iOS target
target :MyWatchApp do
    platform :ios, 9.0
    pod 'IBMMobileFirstPlatformFoundation'
    end

#use the name of the watch extension target
target :MyWatchApp WatchKit Extension do
    platform :watchos, 2.0
    pod 'IBMMobileFirstPlatformFoundation'
end
```

Xcode プロジェクトが閉じていることを確認して、`pod install` コマンドを実行します。

## {{ site.data.keys.product_adj }} ネイティブ SDK の更新
{: #updating-the-mobilefirst-native-sdk }
{{ site.data.keys.product }} ネイティブ SDK を最新リリースで更新するには、**コマンド・ライン**・ウィンドウで、Xcode プロジェクトのルート・フォルダーから次のコマンドを実行します。

```bash
pod update
```

SDK のリリースは、SDK の [CocoaPods リポジトリー](https://cocoapods.org/?q=ibm%20mobilefirst)で調べることができます。

## 生成される{{ site.data.keys.product_adj }} ネイティブ SDK 成果物
{: generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
プロジェクトのルートに配置されているこのファイルは、{{ site.data.keys.mf_server }} に iOS アプリケーションを登録するために使用される、クライアント・サイドのプロパティーを定義します。

| プロパティー            | 説明                                                         | 値の例 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | {{ site.data.keys.mf_server }} との通信プロトコル。             | http または https  |
| wlServerHost        | {{ site.data.keys.mf_server }} のホスト名。                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }} のポート。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上のアプリケーションのコンテキスト・ルート・パス。 | /mfp/          |
| languagePreferences | クライアントの SDK システム・メッセージのデフォルト言語を設定します。           | en             |

## ビットコードと TLS 1.2
{: #bitcode-and-tls-12 }
ビットコードおよび TLS 1.2 のサポートについては、[追加情報](additional-information)のページを参照してください。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで {{ site.data.keys.product }} ネイティブ SDK が組み込まれたので、以下の作業を行うことができます。

- [{{ site.data.keys.product }} SDK の使用に関するチュートリアル](../)を検討する
- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
