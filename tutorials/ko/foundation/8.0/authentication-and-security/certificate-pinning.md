---
layout: tutorial
title: 인증서 고정
relevantTo: [ios,android,cordova]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
공용 네트워크를 통해 통신할 때는 정보를 안전하게 보내고 받는 일이 매우 중요합니다. 이러한 통신을 보호하는 데 널리 사용되는 프로토콜이 SSL/TLS입니다. (SSL/TLS는 Secure Sockets Layer 또는 이의 후속인 Transport Layer Security(TLS)를 지칭합니다). SSL/TLS는 디지털 인증서를 사용하여 인증 및 암호화를 제공합니다. 인증서가 올바른 인증서이고 유효한지 신뢰할 수 있도록 신뢰 인증 기관(CA)에 속하는 루트 인증서에서 디지털 서명을 수행합니다. 운영 체제 및 브라우저는 신뢰할 수 있는 CA에서 발행하고 서명한 인증서를 쉽게 확인할 수 있도록 이러한 신뢰 CA 루트 인증서의 목록을 유지보수합니다.

인증서 체인 검증(예: SSL/TLS)에 의존하는 프로토콜은 모바일 디바이스와 백엔드 시스템 사이에 전달되는 모든 트래픽을 권한 없는 사용자가 보고 수정할 수 있을 때 발생하는 중간자 공격을 포함하여 많은 위험한 공격에 취약합니다.

{{ site.data.keys.product_full }}은 **인증서 고정**을 활성화할 수 있는 API를 제공합니다. 이는 고유 iOS, 고유 Android 및 크로스 플랫폼 Cordova {{ site.data.keys.product_adj }} 애플리케이션에서 지원됩니다.

## 인증서 고정 프로세스
{: #certificate-pinning-process }
인증서 고정은 호스트를 예상되는 공개 키와 연관시키는 프로세스입니다. 서버 측 코드와 클라이언트 측 코드 모두 소유하고 있으므로 운영 체제나 브라우저에서 인식하는 신뢰 CA 루트 인증서에 대응하는 인증서 대신, 도메인 이름에 특정한 인증서만 채택하도록 클라이언트 코드를 구성할 수 있습니다.
인증서의 사본이 클라이언트 애플리케이션에 위치합니다. SSL 핸드쉐이크(서버에 대한 첫 번째 요청) 중에 {{ site.data.keys.product_adj }} 클라이언트 SDK는 서버 인증서의 공개 키가 앱에 저장된 인증서의 공개 키와 일치하는지 확인합니다.

클라이언트 애플리케이션의 다중 인증서도 고정할 수 있습니다. 모든 인증서의 사본이 클라이언트 애플리케이션에 위치해야 합니다. SSL 핸드쉐이크(서버에 대한 첫 번째 요청) 중에 {{ site.data.keys.product_adj }} 클라이언트 SDK는 서버 인증서의 공개 키가 앱에 저장된 인증서 중 하나의 공개 키와 일치하는지 확인합니다.

#### 중요:
{: #important }
* 일부 모바일 운영 체제가 인증서 유효성 검증 확인 결과를 캐시할 수 있습니다. 따라서 코드에서 보안 요청을 작성하기 **전에** 인증서 고정 API 메소드를 호출해야 합니다. 그렇지 않으면 후속 요청에서 인증서 유효성 검증 및 고정 확인을 건너뛸 수 있습니다.
* 인증서 고정 후에도 관련된 호스트와의 모든 통신을 위해 {{ site.data.keys.product }} API만 사용해야 합니다. 동일한 호스트와 상호작용하기 위해 써드파티 API를 사용하면 모바일 운영 체제에서 검증되지 않은 인증서를 캐싱하는 것과 같이 예상치 못한 동작이 발생할 수 있습니다.
* 인증서 고정 API 메소드를 다시 호출하면 이전의 고정 작업을 대체합니다.

고정 프로세스에 성공하면 제공된 인증서 내부의 공개 키가 보안된 요청 SSL/TLS 핸드쉐이크 동안 {{ site.data.keys.mf_server }} 인증서의 무결성을 확인하는 데 사용됩니다. 고정 프로세스에 실패하면 서버에 대한 모든 SSL/TLS 요청이 클라이언트 애플리케이션에서 거부됩니다.

## 인증서 설정
{: #certificate-setup }
인증 기관에서 구매한 인증서를 사용해야 합니다. 자가 서명한 인증서는 **지원되지 않습니다**. 지원되는 환경과의 호환성을 위해 **DER**(Distinguished Encoding Rules, International Telecommunications Union X.690 표준에 정의됨) 형식으로 인코딩된 인증서를 사용해야 합니다.

인증서는 {{ site.data.keys.mf_server }} 및 사용자 애플리케이션 둘 다에 위치해야 합니다. 인증서를 다음과 같이 배치하십시오.

* {{ site.data.keys.mf_server }} (WebSphere  Application Server, WebSphere Application Server Liberty, 또는 Apache Tomcat)의 경우: SSL/TLS 및 인증서 구성 방법에 관한 정보는 특정 애플리케이션 서버에 대한 문서를 참조하십시오.
* 애플리케이션에서:
    - 기본 iOS: 애플리케이션 **번들**에 인증서 추가
    - 기본 Android: **assets** 폴더에 인증서 배치
    - Cordova: 인증서를 **app-name\www\certificates** 폴더에 배치(폴더가 해당 위치에 없으면 새로 작성)

## 인증서 고정 API
{: #certificate-pinning-api }
인증서 고정은 과부화된 API 메소드 즉, 매개변수 `certificateFilename`이 있는 하나의 메소드(`certificateFilename`은 인증 파일임)와 매개변수 `certificateFilenames`가 있는 두 번째 메소드(`certificateFilenames`은 인증 파일에 대한 이름의 배열임)로 구성됩니다.

### Android
{: #android }
단일 인증서:
구문:
pinTrustedCertificatePublicKeyFromFile(String certificateFilename);
예제:
```java
WLClient.getInstance().pinTrustedCertificatePublicKey("myCertificate.cer");
```
다중 인증서:

구문:
pinTrustedCertificatePublicKeyFromFile(String[] certificateFilename);
예제:
```java
String[] certificates={"myCertificate.cer","myCertificate1.cer"};
WLClient.getInstance().pinTrustedCertificatePublicKey(certificates);
```
인증서 고정 메소드는 다음 두 가지 경우에 예외를 발생시킵니다.
* 파일이 존재하지 않습니다.
* 파일 형식이 잘못되었습니다.


### iOS
{: #ios }
단일 인증서 고정 구문:
pinTrustedCertificatePublicKeyFromFile:(NSString*) certificateFilename;

인증서 고정 메소드는 다음 두 가지 경우에 예외를 발생시킵니다.
* 파일이 존재하지 않습니다.
* 파일 형식이 잘못되었습니다.

다중 인증서 고정 구문:
pinTrustedCertificatePublicKeyFromFiles:(NSArray*) certificateFilenames;

인증서 고정 메소드는 다음 두 가지 경우에 예외를 발생시킵니다.
* 인증 파일이 존재하지 않습니다.
* 올바른 형식으로 된 인증 파일이 없습니다.

**Objective-C의 경우:**
예제:
단일 인증서:
```objc
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFile:@"myCertificate.cer"];

```
다중 인증서:
예제:
```objc
NSArray *arrayOfCerts = [NSArray arrayWithObjects:@“Cert1”,@“Cert2”,@“Cert3",nil];
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFiles:arrayOfCerts];
```

**Swift의 경우:**

단일 인증서:
예제:
```swift
WLClient.sharedInstance().pinTrustedCertificatePublicKeyFromFile("myCertificate.cer")
```
다중 인증서:
예제:
```swift
let arrayOfCerts : [Any] = ["Cert1", "Cert2”, "Cert3”];
WLClient.sharedInstance().pinTrustedCertificatePublicKey( fromFiles: arrayOfCerts)
```

인증서 고정 메소드는 다음 두 가지 경우에 예외를 발생시킵니다.

* 파일이 존재하지 않습니다.
* 파일 형식이 잘못되었습니다.

### Cordova
{: #cordova }

단일 인증서 고정:

```javascript
WL.Client.pinTrustedCertificatePublicKey('myCertificate.cer').then(onSuccess, onFailure);
```

다중 인증서 고정:

```javascript
WL.Client.pinTrustedCertificatePublicKey(['Cert1.cer','Cert2.cer','Cert3.cer']).then(onSuccess, onFailure);
```

인증서 고정 메소드는 다음과 같은 promise를 리턴합니다.

* 인증서 고정 메소드는 고정이 완료되는 경우 onSuccess 메소드를 호출합니다.
* 인증서 고정 메소드는 다음과 같은 두 가지 경우에 onFailure 콜백을 트리거합니다.
* 파일이 존재하지 않습니다.
* 파일 형식이 잘못되었습니다.

나중에 인증서가 고정되지 않은 서버로 보안된 요청이 작성되면 특정 요청(예: `obtainAccessToken` 또는 `WLResourceRequest`)의 `onFailure` 콜백이 호출됩니다.

> [API 참조](../../api/client-side-api/)에서 인증서 고정 API에 대해 자세히 알아보십시오.
