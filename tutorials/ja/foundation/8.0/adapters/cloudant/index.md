---
layout: tutorial
title: Cloudant との統合
relevantTo: [javascript]
downloads:
  - name: Cordova プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Cloudant は、CouchDB をベースとした NoSQL データベースであり、IBM Bluemix および `cloudant.com` で、スタンドアロン製品としても Database-as-a-Service (DBaaS) としても入手できます。

Cloudant 資料で説明されているように:
> ドキュメントは JSON オブジェクトです。ドキュメントはお客様のデータの入れ物であり、Cloudant データベースの基礎となるものです。  
すべてのドキュメントには 2 つのフィールド (固有の `_id` フィールドと `_rev` フィールド) が含まれていなければなりません。`_id` フィールドは、お客様によって作成されるか、または Cloudant によって UUID として自動的に生成されます。`_rev` フィールドは改訂番号であり、Cloudant レプリケーション・プロトコルに必須のフィールドです。この 2 つの必須フィールドのほかに、ドキュメントは JSON で表されるその他の任意のコンテンツを含むことができます。

Cloudant API の資料は [IBM Cloudant Documentation](https://docs.cloudant.com/index.html) サイトに掲載されています。

アダプターを使用すれば、リモート Cloudant データベースと通信できます。このチュートリアルでいくつかの例を示します。

このチュートリアルは、お客様がアダプターに精通していることを前提としています。[JavaScript HTTP アダプター](../javascript-adapters/js-http-adapter)または [Java アダプター](../java-adapters)を参照してください。

### ジャンプ先
{: #jump-to}
* [JavaScript HTTP アダプター](#javascript-http-adapter)
* [Java アダプター](#java-adapters)
* [サンプル・アプリケーション](#sample-application)


## JavaScript HTTP アダプター
{: #javascript-http-adapter }
Cloudant API へのアクセスは単純な HTTP Web サービスとして行えます。

HTTP アダプターを使用すれば、`invokeHttp` メソッドによって Cloudant HTTP サービスに接続できます。

### 認証
{: #authentication }
Cloudant は複数の認証形態をサポートします。認証に関する Cloudant 資料を参照してください ([https://docs.cloudant.com/authentication.html](https://docs.cloudant.com/authentication.html))。JavaScript HTTP アダプターでは、**Basic Authentication** を使用できます。

アダプター XML ファイルで、Cloudant インスタンスの `domain`、`port` を指定し、タイプ `basic` の `authentication` エレメントを追加してください。フレームワークはそれらの資格情報を使用して `Authorization: Basic` HTTP ヘッダーを生成します。

**注:** Cloudant では、実際のユーザー名とパスワードの代わりに使用する固有の API キーを生成できます。

```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>https</protocol>
    <domain>CLOUDANT_ACCOUNT.cloudant.com</domain>
    <port>443</port>
    <connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
    <socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
    <authentication>
      <basic/>
        <serverIdentity>
          <username>CLOUDANT_KEY</username>
          <password>CLOUDANT_PASSWORD</password>
        </serverIdentity>
    </authentication>
    <maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
    <!-- Following properties used by adapter's key manager for choosing specific certificate from key store
    <sslCertificateAlias></sslCertificateAlias>
    <sslCertificatePassword></sslCertificatePassword>
    -->
  </connectionPolicy>
</connectivity>
```

### プロシージャー
{: #procedures }
アダプター・プロシージャーは、`invokeHttp` メソッドを使用して、Cloudant によって定義される URL の 1 つに HTTP 要求を送信します。  
例えば、その本体が保管するドキュメントの JSON 表現である `/{*your-database*}/` に、`POST` 要求を送ることによって新規ドキュメントを作成することができます。

```js
function addEntry(entry){
var input = {
method : 'post',
            returnedContentType : 'json',
            path : DATABASE_NAME + '/',
            body: {
                contentType : 'application/json',        
                content : entry
            }
        };

    var response = MFP.Server.invokeHttp(input);
    if(!response.id){
        response.isSuccessful = false;
    }
    return response;

}
```

同じ考え方をすべての Cloudant 関数に応用できます。ドキュメントに関する Cloudant 資料を参照してください ([https://docs.cloudant.com/document.html](https://docs.cloudant.com/document.html))。

## Java アダプター
{: #java-adapters }
Cloudant のすべてのフィーチャーを簡単に使用できるように、Cloudant は [Java クライアント・ライブラリー](https://github.com/cloudant/java-cloudant)を提供します。

Java アダプターの初期化時に、使用する `CloudantClient` インスタンスをセットアップしてください。  
**注:** Cloudant では、実際のユーザー名とパスワードの代わりに使用する固有の API キーを生成できます。

```java
CloudantClient cloudantClient = new CloudantClient(cloudantAccount,cloudantKey,cloudantPassword);
db = cloudantClient.database(cloudantDBName, false);
```
<br/>
[Plain Old Java Objects](https://en.wikipedia.org/wiki/Plain_Old_Java_Object) および標準 Java API for RESTful Web Services (JAX-RS 2.0) を使用すれば、HTTP 要求でドキュメントの JSON 表現を送ることにより、Cloudant に新規ドキュメントを作成できます。

```java
@POST
@Consumes(MediaType.APPLICATION_JSON)
public Response addEntry(User user){
    if(user!=null && user.isValid()){
        db.save(user);
        return Response.ok().build();
    }
    else{
        return Response.status(418).build();
    }
}
```

<img alt="サンプル・アプリケーションのイメージ" src="cloudant-app.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80) して Cordova プロジェクトをダウンロードします。

サンプルには 2 つのアダプター (JavaScript に 1 つと Java に 1 つ) が含まれています。  
サンプルにはまた、Java アダプターと JavaScript アダプターの両方と連動する Cordova アプリケーションが含まれています。

> **注:** サンプルでは、既知の制限により、Cloudant Java Client v1.2.3 を使用しています。

### 使用例
{: #sample-usage }
手順については、サンプルの README.md ファイルに従ってください。
