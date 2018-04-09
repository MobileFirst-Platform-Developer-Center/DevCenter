---
layout: tutorial
title: JSONStore セキュリティー・ユーティリティー
breadcrumb_title: Security utilities
relevantTo: [ios,android,cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{{ site.data.keys.product_full }} クライアント・サイド API は、ユーザーのデータを保護するのに役に立つセキュリティー・ユーティリティーをいくつか提供しています。 JSONStore などのフィーチャーは、JSON オブジェクトを保護する場合に優れた能力を発揮します。 ただし、JSONStore コレクションにバイナリー・ブロブを保管することはお勧めできません。

代わりに、バイナリー・データをファイル・システムに保管して、ファイル・パスやその他のメタデータを JSONStore コレクション内に保管します。 イメージなどのファイルを保護したい場合、それを base64 ストリングとしてエンコードし、暗号化して、ディスクに出力を書き込むことができます。 データを暗号化解除するときになったら、JSONStore コレクション内のメタデータを検索して、暗号化されたデータをディスクから読み取り、保管されているメタデータを使用してそれを暗号化解除することができます。 このメタデータには鍵、ソルト、初期設定ベクトル (IV)、ファイルのタイプ、ファイルへのパスなどを含めることができます。

高レベルでは、SecurityUtils API は以下の API を提供します。

* 鍵生成 - パスワードを暗号化関数に直接渡す代わりに、この鍵生成機能では Password Based Key Derivation Function v2 (PBKDF2) を使用して暗号化 API 用に強固な 256 ビット鍵を生成します。 これは、反復回数のパラメーターを使用します。 この数値が大きくなれば、それだけアタッカーによる鍵を破るための総当たり攻撃に時間がかかることになります。 少なくとも 10,000 の値を使用してください。 ソルトは固有である必要があります。これにより、アタッカーが既存のハッシュ情報を使用してパスワードを攻撃することがますます困難になります。 32 バイトの長さを使用してください。
* 暗号化 - 入力は、Advanced Encryption Standard (AES) を使用して暗号化されます。 API は、鍵生成 API によって生成された鍵を使用します。 内部的にこの API は、最初のブロック暗号にランダム化を追加するために使用される Secure IV を生成します。 テキストは暗号化されます。 イメージまたはその他のバイナリー形式を暗号化したい場合、これらの API を使用してバイナリーを base64 テキストに変換します。 この暗号化関数は、以下の部分を持つオブジェクトを返します。
    * ct (暗号テキスト。暗号化テキストとも呼ばれます)
    * IV
    * v (バージョン。前のバージョンとまだ互換性がある間に API の発展を可能にします)
* 暗号化解除 - 暗号化 API からの出力を入力として使用し、暗号テキストまたは暗号化テキストを暗号化解除し、非暗号化テキストにします。
* リモート・ランダム・ストリング - {{ site.data.keys.mf_server }} 上のランダム生成プログラムにアクセスしてランダム 16 進ストリングを取得します。 デフォルト値は 20 ですが、64 バイトまで変更できます。
* ローカル・ランダム・ストリング - リモート・ランダム・ストリング API と異なりネットワーク・アクセスを必要とするものをローカルに生成して、ランダム 16 進ストリングを取得します。 デフォルト値は 32 バイトで、最大値はありません。 操作時間は、バイト数に比例しています。
* base64 のエンコード - ストリングを使用して、Base64 エンコードを適用します。 アルゴリズムの性質上 Base64 エンコードをどうしても使用しなければならない場合、データのサイズがオリジナルのサイズのほぼ 1.37 倍に増加することになります。
* base64 のデコード - エンコードされた base64 ストリングを使用し、base64 デコードを適用します。

## セットアップ
以下のファイルをインポートし、JSONStore セキュリティー・ユーティリティーの API を使用できるようにします。

### iOS

```objc
#import "WLSecurityUtils.h"
```

### Android

```java
import com.worklight.wlclient.api.SecurityUtils
```

### JavaScript
セットアップは不要です。

## 例
### iOS
#### 暗号化と暗号化解除

```objc
// User provided password, hardcoded only for simplicity.
NSString* password = @"HelloPassword";

// Random salt with recommended length.
NSString* salt = [WLSecurityUtils generateRandomStringWithBytes:32];

// Recomended number of iterations.
int iterations = 10000;

// Populated with an error if one occurs.
NSError* error = nil;

// Call that generates the key.
NSString* key = [WLSecurityUtils generateKeyWithPassword:password
                                 andSalt:salt
                                 andIterations:iterations
                                 error:&error];

// Text that is encrypted.
NSString* originalString = @"My secret text";
NSDictionary* dict = [WLSecurityUtils encryptText:originalString
                                      withKey:key
                                      error:&error];

// Should return: 'My secret text'.
NSString* decryptedString = [WLSecurityUtils decryptWithKey:key
                                             andDictionary:dict
                                             error:&error];
```

#### base64 のエンコード/デコード

```objc
// Input string.
NSString* originalString = @"Hello world!";

// Encode to base64.
NSData* originalStringData = [originalString dataUsingEncoding:NSUTF8StringEncoding];
NSString* encodedString = [WLSecurityUtils base64StringFromData:originalStringData length:originalString.length];

// Should return: 'Hello world!'.
NSString* decodedString = [[NSString alloc] initWithData:[WLSecurityUtils base64DataFromString:encodedString] encoding:NSUTF8StringEncoding];
```

#### リモートでのランダム取得

```objc
[WLSecurityUtils getRandomStringFromServerWithBytes:32 
                 timeout:1000
                 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

  // You might want to see the response and the connection error before moving forward.

  // Get the secure random string.
  NSString* secureRandom = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}];
```

### Android
#### 暗号化と暗号化解除

```java
String password = "HelloPassword";
String salt = SecurityUtils.getRandomString(32);
int iterations = 10000;

String key = SecurityUtils.generateKey(password, salt, iterations);

String originalText = "Hello World!";

JSONObject encryptedObject = SecurityUtils.encrypt(key, originalText);

// Deciphered text will be the same as the original text.
String decipheredText = SecurityUtils.decrypt(key, encryptedObject);
```

#### base64 のエンコード/デコード

```java
import android.util.Base64;

String originalText = "Hello World";
byte[] base64Encoded = Base64.encode(text.getBytes("UTF-8"), Base64.DEFAULT);

String encodedText = new String(base64Encoded, "UTF-8");

byte[] base64Decoded = Base64.decode(text.getBytes("UTF-8"), Base64.DEFAULT);

// Decoded text will be the same as the original text.
String decodedText = new String(base64Decoded, "UTF-8");
```

#### リモートでのランダム取得

```java
Context context; // This is the current Activity's context.
int byteLength = 32;

// Listener calls the callback functions after it gets the response from the server.
WLRequestListener listener = new WLRequestListener(){
  @Override
  public void onSuccess(WLResponse wlResponse) {
    // Implement the success handler.
  }

  @Override
  public void onFailure(WLFailResponse wlFailResponse) {
    // Implement the failure handler.
    }
};

SecurityUtils.getRandomStringFromServer(byteLength, context, listener);
```

#### ローカルでのランダム取得

```java
int byteLength = 32;
String randomString = SecurityUtils.getRandomString(byteLength);
```

### JavaScript
#### 暗号化と暗号化解除

```javascript
// Keep the key in a variable so that it can be passed to the encrypt and decrypt API.
var key;

// Generate a key.
WL.SecurityUtils.keygen({
  password: 'HelloPassword',
  salt: Math.random().toString(),
  iterations: 10000
})

.then(function (res) {

  // Update the key variable.
  key = res;

  // Encrypt text.
  return WL.SecurityUtils.encrypt({
    key: key,
    text: 'My secret text'
  });
})

.then(function (res) {

  // Append the key to the result object from encrypt.
  res.key = key;

  // Decrypt.
  return WL.SecurityUtils.decrypt(res);
})

.then(function (res) {

  // Remove the key from memory.
  key = null;

  //res => 'My secret text'
})

.fail(function (err) {
  // Handle failure in any of the previously called APIs.
});
```

#### base64 のエンコード/デコード

```javascript
WL.SecurityUtils.base64Encode('Hello World!')
.then(function (res) {
  return WL.SecurityUtils.base64Decode(res);
})
.then(function (res) {
  //res => 'Hello World!'
})
.fail(function (err) {
  // Handle failure.
});
```

#### リモートでのランダム取得

```javascript
WL.SecurityUtils.remoteRandomString(32)
.then(function (res) {
  // res => deba58e9601d24380dce7dda85534c43f0b52c342ceb860390e15a638baecc7b
})
.fail(function (err) {
  // Handle failure.
});
```

#### ローカルでのランダム取得

```javascript
WL.SecurityUtils.localRandomString(32)
.then(function (res) {
  // res => 40617812588cf3ddc1d1ad0320a907a7b62ec0abee0cc8c0dc2de0e24392843c
})
.fail(function (err) {
  // Handle failure.
});
```
