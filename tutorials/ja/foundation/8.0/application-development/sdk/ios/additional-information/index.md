---
layout: tutorial
title: 追加情報
breadcrumb_title: additional information
relevantTo: [ios]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### iOS アプリケーションにおけるビットコードでの作業
{: #working-with-bitcode-in-ios-apps }
* アプリケーション認証性セキュリティー検査は、ビットコードではサポートされません。
* watchOS アプリケーションの場合は、ビットコードが有効になっている必要があります。

ビットコードを有効にするには、Xcode プロジェクトで**「Build Settings」**タブに移動し、**「Enable Bitcode」**を**「Yes」**に設定します。

### iOS アプリケーションでの TLS セキュア接続の適用
{: #enforcing-tls-secure-connections-in-ios-apps }
iOS 9 以降、すべてのアプリケーションでバージョン 1.2 の Transport Layer Security (TLS) プロトコルを適用する必要があります。 開発目的のため、このプロトコルを無効にして iOS 9 の要件を回避することができます。

Apple の App Transport Security (ATS) は、アプリケーションとサーバーの間の接続にベスト・プラクティスを適用する iOS 9 の新しいフィーチャーです。 デフォルトでは、このフィーチャーはセキュリティーを向上させるいくつかの接続要件を適用します。 これには、クライアント・サイドの HTTPS 要求とサーバー・サイド証明書、および前方秘匿性を使用して Transport Layer Security (TLS) バージョン 1.2 に準拠する接続暗号が含まれます。

**開発目的**のため、App Transport Security Technote で説明するように、アプリケーション内の info.plist ファイルで例外を指定することによって、デフォルトの動作をオーバーライドすることができます。 ただし**完全な実稼働**環境では、すべての iOS アプリケーションで、正しく機能するために TLS セキュア接続を適用する必要があります。

非 TLS 接続を有効にするには、**project-name\Resources** フォルダーにある **project-name-info.plist** ファイル内に、以下の例外が記述されている必要があります。

```xml
<key>NSExceptionDomains</key>
    <dict>
        <key>yourserver.com</key>
    
            <dict>
            <!--Include to allow subdomains-->
            <key>NSIncludesSubdomains</key>
            <true/>

            <!--Include to allow insecure HTTP requests-->
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
```

実働の準備手順

1. このページの前述のコードを削除またはコメント化します。  
2. 以下のエントリーを使用して HTTPS 要求をディクショナリーに送信するようにクライアントをセットアップします。  

   ```xml
   <key>protocol</key>
   <string>https</string>

   <key>port</key>
   <string>10443</string>
   ```
   
   SSL ポート番号は、サーバー上の **server.xml** 内の `httpEndpoint` 定義で定義されています。
    
3. TLS 1.2 プロトコル用に有効になっているサーバーを構成します。 詳しくは、[『Configuring {{ site.data.keys.mf_server }} to enable TLS V1.2』を参照してください](http://www-01.ibm.com/support/docview.wss?uid=swg21965659)。
4. ご使用のセットアップに適用される暗号および証明書の設定を行います。 詳しくは、「[App Transport Security Technote](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/)」、『[Secure communications using Secure Sockets Layer (SSL) for WebSphere Application Server Network Deployment](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en)』、および『[Liberty プロファイルの SSL 通信の使用可能化](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0)』を参照してください。

### iOS での OpenSSL の有効化
{: #enabling-openssl-for-ios }
{{ site.data.keys.product_adj }} iOS SDK は、暗号化にネイティブ iOS API を使用しています。 iOS アプリケーションで OpenSSL の暗号化ライブラリーを使用するように、{{ site.data.keys.product_full }} を構成できます。

暗号化/暗号化解除は、`WLSecurityUtils.encryptText()` と `WLSecurityUtils.decryptWithKey()` の API で提供されます。

#### オプション 1: ネイティブの暗号化および暗号化解除
{: #option-1-native-encryption-and-decryption }
ネイティブの暗号化および暗号化解除は、OpenSSL を使用せずにデフォルトで提供されます。 これは、以下のように暗号化または暗号化解除の動作を明示的に設定することと同等です。

```xml
WLSecurityUtils enableOSNativeEncryption:YES
```

#### オプション 2: OpenSSL の有効化
{: #option-2-enabling-openssl }
OpenSSL はデフォルトで無効になっています。 有効にするには、以下を実行してください。

1. 以下のように OpenSSL フレームワークをインストールします。
    * CocoaPods を使用する: CocoaPods を使用して `IBMMobileFirstPlatformFoundationOpenSSLUtils` pod をインストールします。
    * Xcode で手動で行う: 「Build Phases」タブの「Link Binary With Libraries」セクションで `IBMMobileFirstPlatformFoundationOpenSSLUtils` および openssl フレームワークを手動でリンクします。
2. 以下のコードは、暗号化/暗号化解除の OpenSSL オプションを有効にします。

   ```xml
   WLSecurityUtils enableOSNativeEncryption:NO
   ```
    
   これで、コードは、OpenSSL 実装が検出された場合はその実装を使用し、フレームワークが正しくインストールされていない場合は、エラーをスローします。

このセットアップでは、暗号化/暗号化解除の呼び出しは、製品の以前のバージョンと同様に OpenSSL を使用します。

### マイグレーション・オプション
{: #migration-options }
以前のバージョンで作成された {{ site.data.keys.product_adj }} プロジェクトがある場合は、OpenSSL の使用を継続するために変更を取り込む必要がある場合があります。
    * アプリケーションが暗号化/暗号化解除 API を使用しておらず、デバイスでキャッシュに入れられた暗号化データがない場合、アクションは不要です。
    * アプリケーションが暗号化/暗号化解除の API を使用している場合、これらの暗号化/暗号化解除の API を使用する際に、OpenSSL を使用するか使用しないかを選択することができます。

#### ネイティブ暗号化へのマイグレーション
{: #migrating-to-native-encryption }
1. デフォルトのネイティブの暗号化/暗号化解除オプションが選択されていることを確認します (『オプション 1』を参照)。
2. キャッシュ・データのマイグレーション: {{ site.data.keys.product_full }} の以前のインストール済み環境が OpenSSL を使用してデバイスに暗号化データを保存している場合、『オプション 2』の説明のように OpenSSL フレームワークがインストールされている必要があります。アプリケーションが初めてデータを暗号化解除しようとしたとき、OpenSSL にフォールバックし、ネイティブ暗号化を使用してデータが暗号化されます。 OpenSSL フレームワークがインストールされていない場合、エラーがスローされます。 このように、データはネイティブ暗号化に自動的にマイグレーションされ、後続のリリースで OpenSSL フレームワークなしで動作できるようになります。

#### OpenSSL の継続
{: #continuing-with-openssl }
OpenSSL が必要な場合は、オプション 2 で述べられているセットアップを使用してください。
