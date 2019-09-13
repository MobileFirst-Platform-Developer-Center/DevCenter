---
layout: tutorial
title: 追加情報
breadcrumb_title: Additional information
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
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

## Cordova アプリケーションでの OpenSSL の有効化
{: #enabling-openssl-in-cordova-applications }
{{ site.data.keys.product_adj }} Cordova SDK for iOS は、暗号化にネイティブの iOS API を使用します。 代わりに Cordova iOS アプリケーションで OpenSSL 暗号化ライブラリーが使用されるように、アプリケーションを構成できます。

暗号化/暗号化解除機能は、以下の JavaScript API を使用して提供されます。

* WL.SecurityUtils.encryptText
* WL.SecurityUtils.decryptWithKey

### オプション 1: ネイティブの暗号化/暗号化解除
{: #option-1-native-encryptiondecryption }
デフォルトで、{{ site.data.keys.product_adj }} は OpenSSLを使用しないネイティブの暗号化/暗号化解除を提供します。 これは、以下の暗号化/暗号化解除の動作を明示的に設定することと同じです。

* WL.SecurityUtils.enableNativeEncryption(true)

## オプション 2: OpenSSL の有効化
{: #option-2-enabling-openssl }
{{ site.data.keys.product_adj }} 提供の OpenSSL は、デフォルトでは無効になっています。

OpenSSL をサポートするために必要なフレームワークをインストールするには、まず、以下のように Cordova プラグインをインストールします。

```bash
cordova plugin add cordova-plugin-mfp-encrypt-utils
```

以下のコードは、暗号化/暗号化解除の OpenSSL オプションを有効にします。

* WL.SecurityUtils.enableNativeEncryption(false)

このセットアップにより、暗号化/暗号化解除の呼び出しは、以前のバージョンの {{ site.data.keys.product }} と同様に OpenSSL を使用します。

### マイグレーション・オプション
{: #migration-options }
以前のバージョンの {{ site.data.keys.product_adj }} 製品で作成されたプロジェクトがある場合、引き続き OpenSSL を使用するためには、変更の組み込みが必要になる場合があります。

* アプリケーションが暗号化/暗号化解除 API を使用しておらず、デバイスでキャッシュに入れられた暗号化データがない場合、アクションは不要です。
* アプリケーションが暗号化/暗号化解除 API を使用している場合、これらの API で OpenSSL を使用することも、使用しないことも可能です。
    - **ネイティブ暗号化へのマイグレーション: **
        1. デフォルトのネイティブの暗号化/暗号化解除オプションが選択されていることを確認します (『**オプション 1**』を参照)。
        2. **キャッシュ・データのマイグレーション**: 製品の以前のインストール済み環境において OpenSSL を使用してデバイスに暗号化データを保存していたが、今回、ネイティブの暗号化/暗号化解除オプションを選択した場合、保管されているデータは暗号化解除される必要があります。 アプリケーションが初めてデータを暗号化解除しようとしたとき、OpenSSL にフォールバックし、ネイティブ暗号化を使用してデータが暗号化されます。 このように、データはネイティブ暗号化に自動的にマイグレーションされます。
        **注:** OpenSSL からの暗号化解除を可能にするには、次のように入力して Cordova プラグインをインストールすることによって、OpenSSL フレームワークを追加する必要があります。`cordova plugin add cordova-plugin-mfp-encrypt-utils`
    - **OpenSSL の継続:** OpenSSL が必要な場合は、『**オプション 2**』に記載されているセットアップを使用します。
