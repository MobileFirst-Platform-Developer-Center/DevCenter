---
layout: tutorial
title: MobileFirst Foundation의 연방 표준 지원
breadcrumb_title: 연방 표준 지원
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{site.data.keys.product_full }}은 FDCC(Federal Desktop Core Configuration) 스펙과 USGCB(United States Government Configuration Baseline) 스펙을 지원합니다. 또한 {{site.data.keys.product }}은 암호화 모듈을 승인하는 데 사용되는 보안 표준인 FIPS(Federal Information Processing Standards) 140-2를 지원합니다. 

#### 다음으로 이동
{: #jump-to }

* [FDCC 및 USGCB 지원](#fdcc-and-usgcb-support)
* [FIPS-140-2 지원](#fips-140-2-support)
* [FIPS 140-2 사용](#enabling-fips-140-2)
* [HTTPS 및 JSONStore 암호화를 위해 FIPS 140-2 모드 구성](#configure-fips-140-2-mode-for-https-and-jsonstore-encryption)
* [기존 애플리케이션에 대한 FIPS 140-2 구성](#configuring-fips-140-2-for-existing-applications)

## FDCC 및 USGCB 지원
{: #fdcc-and-usgcb-support }
미국 연방 정부는 Microsoft Windows 플랫폼에서 실행되는 연방 기관 데스크탑이 FDCC(Federal Desktop Core Configuration) 또는 최신 USGCB(United States Government Configuration Baseline) 보안 설정을 채택하도록 지시합니다. 

IBM Worklight V5.0.6은 자체 인증 프로세스를 통해 USGCB 보안 설정과 FDCC 보안 설정을 사용하여 테스트되었습니다. 테스트는 설치와 핵심 기능이 이 구성에서 작동하도록 합리적인 레벨의 테스트를 포함합니다. 

#### 참조
{: #references }
자세한 정보는 [USGCB](http://usgcb.nist.gov/)의 내용을 참조하십시오. 

## FIPS 140-2 지원
{: #fips-140-2-support }
FIPS(Federal Information Processing Standards)는 연방 정부 컴퓨터 시스템에 대해 미국 NIST(National Institute of Standards and Technology)에서 발행한 표준이며 가이드라인입니다. FIPS Publication 140-2는 암호화 모듈을 승인하는 데 사용되는 보안 표준입니다. {{site.data.keys.product }}에서는 Android와 iOS Cordova 앱에 대한 FIPS 140-2 지원을 제공합니다. 

### {{site.data.keys.mf_server }}의 FIPS 140-2 및 {{site.data.keys.mf_server }}와 SSL 통신
{: #fips-140-2-on-the-mobilefirst-server-and-ssl-communications-with-the-mobilefirst-server }
{{site.data.keys.mf_server }}는 WebSphere Application Server 같은 애플리케이션 서버에서 실행됩니다. 인바운드 및 아웃바운드 SSL(Secure Socket Layer) 연결에 FIPS 140-2 유효성 검증된 암호화 모듈 사용을 적용하도록 WebSphere Application Server를 구성할 수 있습니다. 암호화 모듈은 애플리케이션에서 JCE(Java Cryptography Extension)를 사용하여 수행하는 암호화 조작에도 사용됩니다. {{site.data.keys.mf_server }}는 애플리케이션 서버에서 실행되는 애플리케이션이므로 인바운드 및 아웃바운드 SSL 연결에 FIPS 140-2 유효성 검증된 암호화 모듈을 사용합니다. 

{{site.data.keys.product_adj }} 클라이언트가 FIPS 140-2 모드를 사용하는 애플리케이션 서버에서 실행 중인 {{site.data.keys.mf_server }}에 대한 SSL(Secure Socket Layer) 연결을 트랜잭션하면 FIPS 140-2 승인 암호 스위트가 사용됩니다. 클라이언트 플랫폼에서 FIPS 140-2 승인 암호 스위트 중 하나를 지원하지 않는 경우 SSL 트랜잭션은 실패하고 클라이언트는 서버에 대한 SSL 연결을 설정할 수 없습니다. 성공하는 경우에는 클라이언트에서 FIPS 140-2 승인 암호 스위트를 사용합니다. 

> **참고:** 클라이언트에서 사용되는 암호화 모듈 인스턴스가 반드시 FIPS 140-2 유효성 검증되어야 하는 것은 아닙니다. 클라이언트 디바이스에서 FIPS 140-2 유효성 검증된 라이브러리를 사용하는 옵션은 아래 내용을 참조하십시오.

구체적으로 말하면 클라이언트와 서버에서 동일한 암호 스위트(예: SSL_RSA_WITH_AES_128_CBC_SHA)를 사용하지만 클라이언트 측 암호화 모듈은 FIPS 140-2 유효성 검증 프로세스를 거치지 않은 반면 서버 측에서는 FIPS 140-2 인증 모듈을 사용 중입니다. 

### JSONStore의 저장 데이터와 HTTPS 통신 사용 시 전송되는 데이터의 보호를 위한 {{site.data.keys.product_adj }} 클라이언트 디바이스의 FIPS 140-2
{: #fips-140-2-on-the-mobilefirst-client-device-for-protection-of-data-at-rest-in-jsonstore-and-data-in-motion-when-using-https-communications }
{{site.data.keys.product }}의 JSONStore 기능을 사용하여 클라이언트 디바이스의 저장 데이터를 보호합니다. 전송 중 데이터는 {{site.data.keys.product_adj }} 클라이언트와 {{site.data.keys.mf_server }} 간 HTTPS 통신을 사용하여 보호됩니다. 

iOS 디바이스에서는 저장 데이터와 전송 중 데이터 모두에 대해 FIPS 140-2가 기본적으로 지원됩니다. 

Android 디바이스에서는 기본적으로 FIPS 140-2로 유효성 검증되지 않은 라이브러리를 사용합니다. JSONStore에서 저장하는 로컬 데이터의 보호(암호화, 복호화)와 {{site.data.keys.mf_server }}에 대한 HTTP 통신에 FIPS 140-2 유효성 검증된 라이브러리를 사용하는 옵션이 있습니다. FIPS 140-2 유효성 검증(인증서 #1747)을 달성한 OpenSSL 라이브러리를 사용하여 이를 지원할 수 있습니다. {{site.data.keys.product_adj }} 클라이언트 프로젝트에서 이 옵션을 사용하려면 선택적 Android FIPS 140-2 플러그인을 추가하십시오. 

**참고:** 유념해야 하는 몇몇 제한사항이 있습니다. 

* 이 FIPS 140-2 유효성 검증 모드는 JSONStore 기능으로 저장되는 로컬 데이터의 보호(암호화) 및 {{site.data.keys.product_adj }} 클라이언트와 {{site.data.keys.mf_server }} 간 HTTPS 통신의 보호에만 적용됩니다. 
* 이 기능은 iOS 플랫폼과 Android 플랫폼에서만 지원됩니다. 
    * Android에서는 x86 또는 armeabi 아키텍처를 사용하는 디바이스 또는 시뮬레이터에서만 이 기능이 지원됩니다. armv5 또는 armv6 아키텍처를 사용하는 Android에서는 지원되지 않습니다. 사용되는 OpenSSL 라이브러리가 Android의 armv5 또는 armv6에 대한 FIPS 140-2 유효성 검증을 얻지 못했기 때문입니다. {{site.data.keys.product_adj }} 라이브러리에서 64비트 아키텍처를 지원해도 64비트 아키텍처에서 FIPS 140-2는 지원되지 않습니다. 프로젝트에 32비트 기본 NDK 라이브러리만 포함되어 있는 경우 FIPS 140-2를 64비트 디바이스에서 실행할 수 있습니다. 
    * iOS에서는 i386, x86_64, armv7, armv7s, arm64 아키텍처에서 이 기능이 지원됩니다. 
* 이 기능은 기본 애플리케이션이 아닌 하이브리드 애플리케이션에서 작동합니다. 
* 고유 iOS의 경우 iOS FIPS 라이브러리를 통해 FIPS를 사용할 수 있으며 기본적으로 사용으로 설정되어 있습니다. FIPS 140-2를 사용으로 설정하는 조치가 필요하지 않습니다. 
* HTTPS 통신의 경우:
    * Android 디바이스의 경우 {{site.data.keys.product_adj }} 클라이언트와 {{site.data.keys.mf_server }} 간 통신에서만 클라이언트의 FIPS 140-2 라이브러리를 사용합니다. 기타 서버 또는 서비스로 직접 연결하는 경우 FIPS 140-2 라이브러리를 사용하지 않습니다. 
    * {{site.data.keys.product_adj }} 클라이언트는 지원되는 환경에서 실행되는 {{site.data.keys.mf_server }}하고만 통신할 수 있습니다. 지원되는 환경은 [시스템 요구사항](http://www-01.ibm.com/support/docview.wss?uid=swg27024838)에 나열되어 있습니다. {{site.data.keys.mf_server }}가 지원되지 않는 환경에서 실행되는 경우에는 HTTPS 연결에 실패하고 키 크기가 너무 작음 오류가 발생합니다. 이 오류는 HTTP 통신에서는 발생하지 않습니다. 
* {{site.data.keys.mf_app_center_full }} 클라이언트는 FIPS 140-2 기능을 지원하지 않습니다. 

이 학습서에 설명된 사항을 이전에 변경한 경우 먼저 기타 환경별 변경사항을 저장한 후 Android 또는 iOS 환경을 삭제하고 다시 작성해야 합니다. 

![FIPS 다이어그램](FIPS.jpg)

> JSONStore에 대한 자세한 정보는 [JSONStore 개요](../../application-development/jsonstore)를 참조하십시오. 

## 참조
{: #references-1 }
WebSphere Application Server에서 FIPS 140-2 모드를 사용하는 방법에 대한 정보는 [FIPS(Federal Information Processing Standard) 지원](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/rovr_fips.html)을 참조하십시오. 

WebSphere Application Server Liberty 프로파일의 경우 관리 콘솔에서 FIPS 140-2 모드를 사용할 수 있는 옵션이 없습니다. 그러나 FIPS 140-2 유효성 검증된 모듈을 사용하도록 JRE(Java™ Runtime Environment)를 구성하여 FIPS 140-2를 사용할 수 있습니다. 자세한 정보는 JSSE(Java Secure Socket Extension) IBMJSSE2 제공자 참조 안내서를 확인하십시오. 

## FIPS 140-2 사용
{: #enabling-fips-140-2 }
iOS 디바이스에서는 저장 데이터와 전송 중 데이터 모두에 대해 FIPS 140-2가 기본적으로 지원됩니다.   
Android 디바이스의 경우 `cordova-plugin-mfp-fips` Corodva 플러그인을 추가하십시오. 

플러그인이 추가되면 HTTPS 및 JSONStore 데이터 암호화에 기능이 적용됩니다. 

**참고:** 

* FIPS 140-2는 Android와 iOS에서만 지원됩니다. FIPS 140-2를 지원하는 iOS 아키텍처는 i386, armv7, armv7s, x86_64, arm64입니다. FIPS 140-2를 지원하는 Android 아키텍처는 x86과 armeambi입니다. 
* Android에서는 {{site.data.keys.product_adj }} 라이브러리가 64비트 아키텍처를 지원해도 64비트 아키텍처에서 FIPS 140-2는 지원되지 않습니다. 64비트 디바이스에서 FIPS 140-2를 사용하는 경우 다음 오류가 표시될 수 있습니다.  
        
```bash
java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit
```

이 오류는 Android 프로젝트에 64비트 기본 라이브러리가 있고 해당 라이브러리 사용 시 FIPS 140-2가 작동하지 않음을 의미합니다. 확인하려면 Android 프로젝트에서 src/main/libs 또는 src/main/jniLibs로 이동하여 x86_64 또는 arm64-v8a 폴더가 있는지 확인하십시오. 폴더가 있는 경우 이들 폴더를 삭제하면 FIPS 140-2가 다시 작동합니다. 

## HTTPS 및 JSONStore 암호화를 위해 FIPS 140-2 모드 구성
{: #configure-fips-140-2-mode-for-https-and-jsonstore-encryption }
iOS 앱의 경우 iOS FIPS 라이브러리를 통해 FIPS 140-2가 사용됩니다. 이는 기본적으로 사용되므로 사용으로 설정하거나 구성하는 조치가 필요하지 않습니다. 

다음 코드 스니펫은 FIPS 140-2를 구성하기 위해 Android 운영 체제의 index.js에서 initOptions 오브젝트에 있는 새 {{site.data.keys.product_adj }} 애플리케이션을 채웁니다. 

```javascript
var wlInitOptions = {
  ...
  // # Enable FIPS 140-2 for data-in-motion (network) and data-at-rest (JSONStore) on Android.
  //   Requires the FIPS 140-2 optional feature to be enabled also.
  // enableFIPS : false
  ...
};
```

Android 운영 체제의 경우 **enableFIPS**의 기본값은 `false`입니다. HTTPS와 JSONStore 데이터 암호화에 FIPS 140-2를 사용하려면 주석 해제하고 옵션을 `true`로 설정하십시오. **enableFIPS**의 값을 `true`로 설정한 후 다음 샘플과 유사한 청취 이벤트를 작성하여 FIPS 준비 JavaScript 이벤트를 청취해야 합니다. 

```javascript
document.addEventListener('WL/FIPS/READY', 
    this.onFipsReady, false);

onFipsReady: function() {
  // FIPS SDK is loaded and ready
}
```

**enableFIPS** 특성의 값을 설정한 후 Android 플랫폼을 다시 빌드하십시오. 

**참고: **enableFIPS 특성 값을 true로 설정하기 전에 FIPS Cordova 플러그인을 설치해야 합니다. 그렇지 않으면 initOption 값이 설정되었지만 선택적 기능을 찾을 수 없음을 표시하는 경고 메시지가 로그됩니다. Android 운영 체제에서는 FIPS 140-2 기능과 JSONStore 기능 모두 선택사항입니다. JSONStore 선택적 기능도 사용되는 경우에만 FIPS 140-2가 JSONStore 데이터 암호화에 영향을 미칩니다. JSONStore가 사용되지 않으면 FIPS 140-2가 JSONStore에 영향을 미치지 않습니다. iOS에서는 JSONStore FIPS 140-2(저장 데이터) 또는 HTTPS 암호화(전송 데이터) 모두 iOS에서 처리되므로 FIPS 140-2 선택적 기능이 필요하지 않습니다. Android에서는 JSONStore FIPS 140-2 또는 HTTPS 암호화를 사용하려는 경우 FIPS 140-2 선택적 기능을 사용해야 합니다. 

```bash
[WARN] FIPSHttp feature not found, but initOptions enables it on startup
```

## 기존 애플리케이션에 대한 FIPS 140-2 구성
{: #configuring-fips-140-2-for-existing-applications }
FIPS 140-2 선택적 기능은 Android 운영 체제 버전에서 사용하도록 작성된 앱과 버전 8.0 이전의 {{site.data.keys.product_full }} 버전에 있는 iOS 앱에서 기본적으로 사용되지 않습니다. Android 운영 체제에서 FIPS 140-2 선택적 기능을 사용하려면 FIPS 140-2 사용을 참조하십시오. 선택적 기능이 사용으로 설정된 후 FIPS 140-2를 구성할 수 있습니다. 

FIPS 140-2 사용에 설명된 단계를 완료한 후에는 FIPS 구성 특성을 추가하도록 index.js 파일에서 initOptions 오브젝트를 수정하여 FIPS 140-2를 구성해야 합니다. 

**참고:** FIPS 140-2 기능은 JSONStore 기능과 함께 JSONStore에 대해 FIPS 140-2를 지원합니다. 이 조합은 학습서 JSONStore - IBM Worklight V6.0 이하에서 사용 가능한 FIPS 140-2로 민감한 데이터 암호화에 표시되었던 내용을 대체합니다. 이전에 이 학습서의 지시사항을 수행하여 애플리케이션을 수정한 경우 해당 iPhone, iPad, Android 환경을 삭제하고 다시 작성하십시오. 이전에 작성한 환경별 변경사항은 환경 삭제 시 손실되므로 환경을 삭제하기 전에 해당 변경사항을 백업해야 합니다. 환경을 다시 작성한 후 새 환경에 이러한 변경사항을 다시 적용할 수 있습니다. 

index.js 파일에 있는 initOptions 오브젝트에 다음 특성을 추가하십시오. 

```javascript
enableFIPS : true
```

Android 플랫폼을 다시 빌드하십시오. 
