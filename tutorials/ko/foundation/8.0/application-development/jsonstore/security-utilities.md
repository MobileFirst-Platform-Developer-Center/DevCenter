---
layout: tutorial
title: JSONStore 보안 유틸리티
breadcrumb_title: 보안 유틸리티
relevantTo: [ios,android,cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{{ site.data.keys.product_full }} 클라이언트 측 API는 사용자 데이터를 보호하는 데 도움이 되는 일부 보안 유틸리티를 제공합니다. JSON 오브젝트를 보호하려는 경우 JSONStore와 같은 기능이 매우 유용합니다. 그러나 JSONStore 콜렉션에 2진 BLOB을 저장하는 것은 권장하지 않습니다. 

대신 파일 시스템에 2진 데이터를 저장하고 파일 경로 및 기타 메타데이터를 JSONStore 콜렉션 내에 저장하십시오. 이미지와 같은 파일을 보호하려면 base64 문자열로 인코딩하고 암호화한 후 디스크에 출력을 쓸 수 있습니다. 데이터를 복호화할 때 JSONStore 콜렉션에서 메타데이터를 찾고 디스크에서 암호화된 데이터를 읽은 후에 저장된 메타데이터를 사용하여 복호화하십시오. 이 메타데이터에는 키, salt, IV(Initialization Vector), 파일 유형, 파일 경로 등이 포함될 수 있습니다. 

상위 레벨에서 SecurityUtils API는 다음 API를 제공합니다. 

* 키 생성 - 이 키 생성 기능은 암호화 기능으로 비밀번호를 전달하는 대신 PBKDF2(Password Based Key Derivation Function v2)를 사용하여 암호화 API에 대한 강력한 256비트 키를 생성합니다. 반복 횟수에 대한 매개변수를 사용합니다. 숫자가 클수록 공격자가 키를 무차별 대입공격하는 데 더 많은 시간이 소요됩니다. 10,000 이상의 값을 사용하십시오. salt는 고유해야 하며, 이는 공격자가 기존 해시 정보를 사용하여 비밀번호를 공격하는 것을 어렵게 하는 데 도움이 됩니다. 32바이트 길이를 사용하십시오. 
* 암호화 - AES(Advanced Encryption Standard)를 사용하여 입력이 암호화됩니다. API는 키 생성 API로 생성되는 키를 사용합니다. 이는 내부에서 첫 번째 블록 암호에 랜덤화를 추가하는 데 사용되는 보안 IV를 생성합니다. 텍스트는 암호화됩니다. 이미지 또는 다른 2진 형식을 암호화하려면 이 API를 사용하여 2진을 base64 텍스트로 바꾸십시오. 이 암호화 기능은 다음 파트가 포함된 오브젝트를 리턴합니다. 
    * ct(암호화된 텍스트로도 불리는 암호 텍스트)
    * IV
    * v(API가 전개되면서도 이전 버전과 계속 호환될 수 있도록 하는 버전)
* 복호화 - 암호화 API의 출력을 입력으로 사용하고 암호 또는 암호화된 텍스트를 일반 텍스트로 복호화합니다. 
* 원격 랜덤 문자열 - {{ site.data.keys.mf_server }}에서 랜덤 생성기에 접속하여 랜덤 16진 문자열을 가져옵니다. 기본값은 20바이트지만 최대 64바이트로 숫자를 변경할 수 있습니다. 
* 로컬 랜덤 문자열 - 네트워크 액세스가 필요한 원격 랜덤 문자열 API와는 달리 로컬로 생성하여 랜덤 16진 문자열을 가져옵니다. 기본값은 32바이트이고 최대값은 없습니다. 조작 시간은 바이트 수에 비례합니다. 
* base64로 인코딩 - 문자열을 가져오고 base64 인코딩을 적용합니다. 알고리즘의 네이처로 인해 base64 인코딩이 발생하면 데이터 크기가 원래 크기보다 약 1.37배 증가합니다. 
* base64로 디코딩 - base64로 인코딩된 문자열을 가져오고 base64 디코딩을 적용합니다. 

## 설정
JSONStore 보안 유틸리티 API를 사용하려면 다음 파일을 가져오십시오. 

### iOS

```objc
#import "WLSecurityUtils.h"
```

### Android

```java
import com.worklight.wlclient.api.SecurityUtils
```

### JavaScript
설정이 필요하지 않습니다. 

## 예제
### iOS
#### 암호화 및 복호화

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

#### base64로 인코딩 및 디코딩

```objc
// Input string.
NSString* originalString = @"Hello world!";

// Encode to base64.
NSData* originalStringData = [originalString dataUsingEncoding:NSUTF8StringEncoding];
NSString* encodedString = [WLSecurityUtils base64StringFromData:originalStringData length:originalString.length];

// Should return: 'Hello world!'.
NSString* decodedString = [[NSString alloc] initWithData:[WLSecurityUtils base64DataFromString:encodedString] encoding:NSUTF8StringEncoding];
```

#### 원격 랜덤 가져오기

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
#### 암호화 및 복호화

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

#### base64로 인코딩 및 디코딩

```java
import android.util.Base64;

String originalText = "Hello World";
byte[] base64Encoded = Base64.encode(text.getBytes("UTF-8"), Base64.DEFAULT);

String encodedText = new String(base64Encoded, "UTF-8");

byte[] base64Decoded = Base64.decode(text.getBytes("UTF-8"), Base64.DEFAULT);

// Decoded text will be the same as the original text.
String decodedText = new String(base64Decoded, "UTF-8");
```

#### 원격 랜덤 가져오기

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

#### 로컬 랜덤 가져오기

```java
int byteLength = 32;
String randomString = SecurityUtils.getRandomString(byteLength);
```

### JavaScript
#### 암호화 및 복호화

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

#### base64로 인코딩 및 디코딩

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

#### 원격 랜덤 가져오기

```javascript
WL.SecurityUtils.remoteRandomString(32)
.then(function (res) {
  // res => deba58e9601d24380dce7dda85534c43f0b52c342ceb860390e15a638baecc7b
})
.fail(function (err) {
  // Handle failure.
});
```

#### 로컬 랜덤 가져오기

```javascript
WL.SecurityUtils.localRandomString(32)
.then(function (res) {
  // res => 40617812588cf3ddc1d1ad0320a907a7b62ec0abee0cc8c0dc2de0e24392843c
})
.fail(function (err) {
  // Handle failure.
});
```
