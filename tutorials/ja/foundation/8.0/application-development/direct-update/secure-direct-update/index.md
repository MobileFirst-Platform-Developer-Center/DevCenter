---
layout: tutorial
title: セキュアなダイレクト・アップデートの実装
breadcrumb_title: セキュアなダイレクト・アップデート
relevantTo: [cordova]
weight: 2
---

## 概説
{: #overview }
セキュアなダイレクト・アップデートが機能するためには、ユーザー定義の鍵ストア・ファイルが {{ site.data.keys.mf_server }} にデプロイされている必要があり、マッチングする公開鍵のコピーが、デプロイされたクライアント・アプリケーションに組み込まれている必要があります。

このトピックでは、新規クライアント・アプリケーションとアップグレードされた既存のクライアント・アプリケーションに公開鍵をバインドする方法を説明します。{{ site.data.keys.mf_server }} で鍵ストアを構成する方法について詳しくは、[『{{ site.data.keys.mf_server }}鍵ストアの構成』](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。

サーバーは、開発フェーズのセキュアなダイレクト・アップデートをテストするために使用できる組み込み鍵ストアを提供します。

**注:** 公開鍵をクライアント・アプリケーションにバインドして再ビルドした後、それを {{ site.data.keys.mf_server }} に再度アップロードする必要はありません。ただし、以前にアプリケーションを公開鍵なしでマーケットに公開している場合は、リパブリッシュする必要があります。

開発目的の場合、以下のデフォルトのダミー公開鍵は、{{ site.data.keys.mf_server }} で提供されます。

```xml
-----BEGIN PUBLIC KEY-----
MIIDPjCCAiagAwIBAgIEUD3/bjANBgkqhkiG9w0BAQsFADBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxETA
PBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wgRG
V2MCAXDTEyMDgyOTExMzkyNloYDzQ3NTAwNzI3MTEzOTI2WjBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxE
TAPBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wg
RGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzQN3vEB2/of7KAvuvyoIt0T7cjaSTjnOBm0N3+q
zx++dh92KpNJXj/a3o4YbwJXkJ7jU8ykjCYvjXRf0hme+HGhiIVwxJo54iqh76skDS5m7DaseFdndZUJ4p7NFVw
I5ixA36ZArSZ/Pn/ej56/RRjBeRI7AEGXUSGojBUPA6J6DYkwaXQRew9l+Q1kj4dTigyKL5Os0vNFaQyYu+bT2E
vnOixQ0DXm94IqmHZamZKbZLrWcOEfuAsSjKYOdMSM9jkCiHaKcj7fpEZhUxRRs7joKs1Ri4ihs6JeUvMEiG4gK
l9V3FP/Huy0pfkL0F8xMHgaQ4c/lxS/s3PV0OEg+7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgEhhqRl2Rgkt
MJeqOCRcT3uyr4XDK3hmuhEaE0nOvLHi61PoLKnDUNryWUicK/W+tUP9jkN5xRckdzG6TJ/HPySmZ7Adr6QRFu+
xcIMY+/S8j4PHLXBjoqgtUMhkt7S2/thN/VA6mwZpw4Ol0Pa2hyT2TkhQoYYkRwYCk9pxmuBCoH/eCWpSxquNny
RwrY25x0YzccXUaMI8L3/3hzq3mW40YIMiEdpiD5HqjUDpzN1funHNQdsxEIMYsWmGAwOdV5slFzyrH+ErUYUFA
pdGIdLtkrhzbqHFwXE0v3dt+lnLf21wRPIqYHaEu+EB/A4dLO6hm+IjBeu/No7H7TBFm
-----END PUBLIC KEY-----
```

> 重要: 実稼働目的で公開鍵を使用しないでください。

## 鍵ストアの生成およびデプロイ
{: #generating-and-deploying-the-keystore }
証明書を生成して鍵ストアから公開鍵を抽出するために、複数のツールを利用できます。以下の例では、JDK 鍵ツール・ユーティリティーと OpenSSL を使用した手順を説明します。

1. {{ site.data.keys.mf_server }} にデプロイされる鍵ストア・ファイルから公開鍵を抽出します。  
   注: 公開鍵は Base64 でエンコードされる必要があります。
    
   例えば、エイリアス名が `mfp-server` で、鍵ストア・ファイルが **keystore.jks** であるとします。  
証明書を生成するには、次のコマンドを実行します。
    
   ```bash
   keytool -export -alias mfp-server -file certfile.cert
   -keystore keystore.jks -storepass keypassword
   ```
    
   証明書ファイルが生成されます。  
次のコマンドを実行して公開鍵を抽出します。
    
   ```bash
openssl x509 -inform der -in certfile.cert -pubkey -noout```
    
   **注:** 鍵ツール単独で公開鍵を Base64 形式で抽出することはできません。
    
2. 以下の手順のいずれかを実行します。
    * 結果のテキスト (`BEGIN PUBLIC KEY` マーカーおよび `END PUBLIC KEY` マーカーを除いた部分) をアプリケーションの mfpclient プロパティー・ファイル内の `wlSecureDirectUpdatePublicKey` の直後にコピーします。
    * コマンド・プロンプトから、次のコマンドを実行します。`mfpdev app config direct_update_authenticity_public_key <public_key>`
    
    `<public_key>` には、手順 1 の結果として得られたテキスト (`BEGIN PUBLIC KEY` マーカーおよび `END PUBLIC KEY` マーカーを除いた部分) を貼り付けます。

3. cordova build コマンドを実行して、アプリケーションに公開鍵を保存します。


