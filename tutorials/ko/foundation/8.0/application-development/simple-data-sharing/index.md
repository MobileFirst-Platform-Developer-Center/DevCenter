---
layout: tutorial
title: 단순 데이터 공유
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
단순 데이터 공유 기능을 사용하여 단일 디바이스에서 애플리케이션 패밀리 간에 경량 정보를 안전하게 공유할 수 있습니다. 이 기능은 여러 모바일 SDK에 이미 존재하는 고유 API를 사용하여 하나의 통합된 개발자 API를 제공합니다. 이 {{ site.data.keys.product_adj }} API는 여러 플랫폼 복잡도를 요약하므로 개발자가 애플리케이션 간 통신에 대해 허용되는 코드를 보다 쉽고 빠르게 구현할 수 있습니다. 

이 기능은 iOS 및 Android에서 Cordova 및 고유 애플리케이션 둘 다에 대해 지원됩니다. 

단순 데이터 공유 기능을 사용으로 설정하면 제공된 Cordova 및 고유 API를 사용하여 디바이스의 애플리케이션 패밀리 간에 단순 문자열 토큰을 교환할 수 있습니다. 

#### 다음으로 이동
{: #jump-to}
* [용어](#terminology)
* [단순 데이터 공유 기능 사용](#enabling-the-simple-data-sharing-feature)
* [단순 데이터 공유 API 개념](#simple-data-sharing-api-concepts)
* [제한사항 및 고려사항](#limitations-and-considerations)

## 용어
{: #terminology }
### {{ site.data.keys.product_adj }} 애플리케이션 패밀리
{: #mobilefirst-application-family }
애플리케이션 패밀리는 동일한 신뢰 레벨을 공유하는 여러 애플리케이션을 연관시키는 방법입니다. 동일한 패밀리에 포함된 애플리케이션은 서로 안전하게 정보를 공유할 수 있습니다. 

동일한 {{ site.data.keys.product_adj }} 애플리케이션 패밀리의 일부로 간주되려면 동일한 패밀리에 포함된 모든 애플리케이션이 다음 요구사항을 준수해야 합니다. 

* 애플리케이션 디스크립터에서 애플리케이션 패밀리에 대해 동일한 값을 지정하십시오. 
	* iOS 애플리케이션의 경우 이 요구사항은 액세스 그룹 인타이틀먼트 값과 동일한 의미입니다. 
	* Android 애플리케이션의 경우 이 요구사항은 **AndroidManifest.xml** 파일의 **sharedUserId** 값과 동일한 의미입니다. 

    > **참고:** Android의 경우 이름이 **x.y** 형식이어야 합니다. 

* 애플리케이션은 동일한 서명 ID로 서명되어야 합니다. 이 요구사항은 동일한 조직의 애플리케이션만 이 기능을 사용할 수 있음을 의미합니다. 
    * iOS 애플리케이션의 경우 이 요구사항은 애플리케이션에 서명하는 데 동일한 애플리케이션 ID 접두부, 프로비저닝 프로파일 및 서명 ID가 사용됨을 의미합니다. 
	* Android 애플리케이션의 경우 이 요구사항은 동일한 서명 인증서 및 키를 의미합니다. 

{{ site.data.keys.product }} 제공 API 외에도, 동일한 {{ site.data.keys.product_adj }} 애플리케이션 패밀리에 포함되는 애플리케이션은 각 고유 모바일 SDK API를 통해 사용 가능한 데이터 공유 API도 사용할 수 있습니다. 

### 문자열 토큰
{: #string-tokens }
이제 단순 데이터 공유 기능을 통해 하이브리드 또는 고유 iOS 및 Android 애플리케이션에서 동일한 {{ site.data.keys.product_adj }} 애플리케이션 패밀리의 애플리케이션 간에 문자열 토큰을 공유할 수 있습니다. 

문자열 토큰은 단순 문자열(예: 비밀번호 또는 쿠키)로 간주됩니다. 긴 문자열을 사용하면 성능이 상당히 저하됩니다. 

API를 사용하는 경우 토큰을 암호화하여 보안을 강화할 것을 고려하십시오. 

> 자세한 정보는 [JSONStore 보안 유틸리티](../jsonstore/security-utilities/)를 참조하십시오. 

## 단순 데이터 공유 기능 사용
{: #enabling-the-simple-data-sharing-feature }
고유 앱 및 Cordova 기반 앱 모두에 대해 아래 지시사항이 적용됩니다.   
Xcode/Android Studio에서 애플리케이션을 열고 다음을 수행하십시오. 

### iOS
{: #ios }
1. Xcode에서 동일한 애플리케이션 패밀리에 포함시키려는 모든 앱에 대해 고유 이름이 있는 키 체인 액세스 그룹을 추가하십시오. 애플리케이션 ID 인타이틀먼트는 패밀리의 모든 애플리케이션에 대해 동일해야 합니다. 
2. 동일한 애플리케이션 패밀리에 속한 애플리케이션이 동일한 애플리케이션 ID 접두부를 공유하는지 확인하십시오. 자세한 정보는 3. iOS 개발자 라이브러리의 여러 앱 ID 접두부 관리를 참조하십시오. 
4. 애플리케이션을 저장하고 서명하십시오. 이 그룹의 모든 애플리케이션이 동일한 iOS 인증서 및 프로비저닝 프로파일에 의해 서명되었는지 확인하십시오. 
5. 동일한 애플리케이션 패밀리에 포함시킬 모든 애플리케이션에 대해 단계를 반복하십시오. 

이제 고유 단순 데이터 공유 API를 사용하여 동일한 패밀리의 애플리케이션 그룹 간에 단순 문자열을 공유할 수 있습니다. 

### Android
{: #android }
1. 애플리케이션 패밀리 이름을 **AndroidManifest.xml** 파일의 Manifest 태그에 있는 **android:sharedUserId** 요소로 지정하여 단순 데이터 공유 옵션을 사용하도록 설정하십시오. 예: 

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
   ```

2. 동일한 패밀리에 속한 애플리케이션이 동일한 서명 신임 정보로 서명되었는지 확인하십시오. 
3. **sharedUserId**를 지정하지 않았거나 다른 **sharedUserId**를 사용한 이전 버전의 애플리케이션을 모두 설치 제거하십시오. 
4. 디바이스에서 애플리케이션을 설치하십시오. 
5. 동일한 애플리케이션 패밀리에 포함시킬 모든 애플리케이션에 대해 단계를 반복하십시오. 

이제 제공되는 고유 단순 데이터 공유 API를 사용하여 동일한 패밀리의 애플리케이션 그룹 간에 단순 문자열을 공유할 수 있습니다. 

## 단순 데이터 공유 API 개념
{: #simple-data-sharing-api-concepts }
단순 데이터 공유 API를 사용하여 동일한 패밀리에 속한 애플리케이션이 공통된 위치에서 키-값 쌍을 설정하고 가져오며 지울 수 있습니다. 단순 데이터 공유 API는 모든 플랫폼에 대해 유사하며, 추상 계층을 제공하여 각 고유 SDK의 API에 존재하는 복잡도를 숨기고 쉽게 사용하도록 합니다. 

다음 예제는 서로 다른 환경에 대한 공유 신임 정보 스토리지에서 토큰을 설정하고 가져오며 삭제할 수 있는 방법을 보여줍니다. 

### JavaScript
{: #javascript }
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> Cordova API에 대한 자세한 정보는 `WL.Client` API 참조의 [getSharedToken](../../api/client-side-api/javascript/client/), [setSharedToken](../../api/client-side-api/javascript/client/) 및 [clearSharedToken](../../api/client-side-api/javascript/client/) 함수를 참조하십시오.

### Objective-C
{: #objective-c }
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> Objective-C API에 대한 자세한 정보는 API 참조의 [WLSimpleDataSharing](../../api/client-side-api/objc/client/) 클래스를 참조하십시오.

### Java
{: #java }
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> Java API에 대한 자세한 정보는 API 참조의 [WLSimpleDataSharing](../../api/client-side-api/java/client/) 클래스를 참조하십시오.

## 제한사항 및 고려사항
{: #limitations-and-considerations }
### 보안 고려사항
{: #security-considerations }
이 기능은 여러 애플리케이션 간에 데이터 액세스를 허용하므로 권한 없는 사용자가 디바이스에 액세스하는 것을 방지하도록 특히 주의해야 합니다. 다음 보안 측면을 고려하십시오. 

#### 디바이스 잠금
{: #device-lock }
보안을 강화하려면 디바이스 비밀번호, 패스코드 또는 핀으로 디바이스를 보호하여 디바이스 유실 또는 도난 시에 디바이스에 대한 액세스를 안전하게 보호하십시오. 

#### 탈옥 발견
{: #jailbreak-detection }
엔터프라이즈의 디바이스가 탈옥 또는 루팅되지 않도록 모바일 디바이스 관리 솔루션을 사용할 것을 고려하십시오. 

#### 암호화
{: #encryption }
토큰을 암호화한 후 공유하여 보안을 강화할 것을 고려하십시오. 자세한 정보는 JSONStore 보안 유틸리티를 참조하십시오. 

### 크기 한계
{: #size-limit }
이 기능은 짧은 문자열(예: 비밀번호 또는 쿠키) 공유에 사용됩니다. 큰 값의 데이터를 암호화 및 복호화하거나 읽고 쓰는 경우 성능에 영향을 주므로 이 기능을 남용하지 않도록 하십시오. 

### 유지보수 과제
{: #maintenance-challenges }
Android 개발자는 이 기능을 사용하도록 설정하거나 애플리케이션 패밀리 값을 변경하는 경우 다른 패밀리 이름으로 설치된 기존 애플리케이션을 업그레이드할 수 없다는 점에 유의해야 합니다. 보안상의 이유로 인해 Android에서 새 패밀리 이름으로 애플리케이션을 설치하려면 먼저 이전 애플리케이션을 설치 제거해야 합니다. 
