---
layout: tutorial
title: 추가 정보
breadcrumb_title: 추가 정보
relevantTo: [ios]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### iOS 앱에서 비트 코드 작업
{: #working-with-bitcode-in-ios-apps }
* 애플리케이션 인증 보안 검사는 비트 코드에 지원되지 않습니다. 
* watchOS 애플리케이션에서는 비트 코드를 사용해야 합니다. 

비트 코드를 사용하려면 Xcode 프로젝트에서 **Build Settings** 탭으로 이동하고 **비트 코드 사용**을 **예**로 설정하십시오. 

### iOS 앱에서 TLS 보안 연결 강제 실행
{: #enforcing-tls-secure-connections-in-ios-apps }
iOS 9부터 모든 앱에서 TLS(Transport Layer Security) 프로토콜 버전 1.2를 강제 실행해야 합니다. 개발이 목적인 경우 이 프로토콜을 사용 안함으로 설정하고 iOS 9 요구사항을 우회할 수 있습니다. 

Apple ATS(App Transport Security)는 iOS 9의 새로운 기능으로, 앱과 서버 간 연결에 대해 우수 사례를 적용합니다. 기본적으로 이 기능은 보안을 개선하는 일부 연결 요구사항을 적용합니다. 해당 요구사항에는 클라이언트 측 HTTPS 요청 및 서버 측 인증서와 FS(Forward Secrecy)를 사용하여 TLS(Transport Layer Security) 버전 1.2를 준수하는 연결 암호가 포함됩니다. 

**개발 용도**로 사용하는 경우 ATS(App Transport Security) 기술 노트에 설명된 것처럼 앱의 info.plist 파일에서 예외를 지정하여 기본 동작을 대체할 수 있습니다. 그러나 **전체 프로덕션** 환경에서는 TLS 보안 연결을 강제 실행하여 모든 iOS 앱이 올바르게 작동하도록 해야 합니다. 

비TLS 연결을 사용하려면 **project-name\Resources** 폴더의 **project-name-info.plist** 파일에 다음 예외가 표시되어야 합니다. 

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

프로덕션에 대해 준비하려면 다음을 수행하십시오. 

1. 이 페이지 앞쪽에 표시되는 코드를 제거하거나 주석 처리하십시오.   
2. 다음 항목을 사용하여 사전에 HTTPS 요청을 보내도록 클라이언트를 설정하십시오.   

   ```xml
   <key>protocol</key>
   <string>https</string>

   <key>port</key>
   <string>10443</string>
   ```
   
   SSL 포트 번호는 `httpEndpoint` 정의의 **server.xml**에 포함된 서버에 정의되어 있습니다. 
    
3. TLS 1.2 프로토콜에 사용되는 서버를 구성하십시오. 자세한 정보는 [TLS V1.2를 사용하도록 {{ site.data.keys.mf_server }} 구성을 참조](http://www-01.ibm.com/support/docview.wss?uid=swg21965659)하십시오. 
4. 암호 및 인증서에 대한 설정을 작성하여 설정에 적용하십시오. 자세한 정보는 [App Transport Security 기술 노트](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/), [WebSphere Application Server Network Deployment에 SSL(Secure Sockets Layer)을 사용하는 보안 통신](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en) 및 [Liberty 프로파일에 SSL 통신 사용](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0)을 참조하십시오. 

### iOS에 OpenSSL 사용
{: #enabling-openssl-for-ios }
{{ site.data.keys.product_adj }} iOS SDK는 암호화에 고유 iOS API를 사용합니다. iOS 앱에서 OpenSSL 암호화 라이브러리를 사용하도록 {{ site.data.keys.product_full }}을 구성할 수 있습니다. 

암호화/복호화는 `WLSecurityUtils.encryptText()` 및 `WLSecurityUtils.decryptWithKey()` API에 제공됩니다. 

#### 옵션 1: 고유 암호화 및 복호화
{: #option-1-native-encryption-and-decryption }
고유 암호화 및 복호화가 기본적으로 제공되며 OpenSSL은 사용되지 않습니다. 이는 다음과 같이 암호화 또는 복호화 동작을 명시적으로 설정하는 것과 같습니다. 

```xml
WLSecurityUtils enableOSNativeEncryption:YES
```

#### 옵션 2: OpenSSL 사용
{: #option-2-enabling-openssl }
OpenSSL은 기본적으로 사용 안함으로 설정됩니다. 이를 사용하려면 다음을 수행하십시오. 

1. OpenSSL 프레임워크를 설치하십시오. 
    * CocoaPods 사용: CocoaPods를 사용하여 `IBMMobileFirstPlatformFoundationOpenSSLUtils` POD를 설치하십시오. 
    * Xcode에서 수동으로: 빌드 단계(Phase) 탭의 라이브러리가 포함된 2진 링크 섹션에서 `IBMMobileFirstPlatformFoundationOpenSSLUtils` 및 OpenSSL 프레임워크를 수동으로 링크하십시오. 
2. 다음 코드는 암호화/복호화에 OpenSSL 옵션을 사용하도록 설정합니다. 

   ```xml
   WLSecurityUtils enableOSNativeEncryption:NO
   ```
    
   이제 코드는 OpenSSL 구현이 있는 경우 이를 사용하고, 그렇지 않고 프레임워크가 올바르게 설치되지 않은 경우 오류 처리합니다. 

이렇게 설정하면 이전 버전의 제품과 마찬가지로 암호화/복호화 호출에서 OpenSSL을 사용합니다. 

### 마이그레이션 옵션
{: #migration-options }
이전 버전에 작성된 {{ site.data.keys.product_adj }} 프로젝트가 있는 경우 OpenSSL을 계속 사용하려면 변경사항을 통합해야 합니다. 
    * 애플리케이션에서 암호화/복호화 API를 사용하지 않고 디바이스에 캐시된 암호화 데이터가 없는 경우 조치가 필요하지 않습니다. 
    * 애플리케이션에서 암호화/복호화 API를 사용하는 경우 이러한 API를 OpenSSL과 함께 사용하거나 OpenSSL 없이 사용하는 것 중에 선택할 수 있습니다. 

#### 고유 암호화로 마이그레이션
{: #migrating-to-native-encryption }
1. 기본 고유 암호화/복호화 옵션이 선택되었는지 확인하십시오(옵션 1 참조). 
2. 캐시된 데이터 마이그레이션: {{ site.data.keys.product_full }}의 이전 설치에서 OpenSSL을 사용하여 디바이스에 암호화된 데이터를 저장한 경우 옵션 2에 설명된 대로 OpenSSL 프레임워크를 설치해야 합니다. 애플리케이션에서 데이터를 처음 복호화할 때 이는 OpenSSL로 대체된 후에 고유 암호화를 사용하여 암호화됩니다. OpenSSL 프레임워크가 설치되어 있지 않으면 오류 처리됩니다. 이 방식으로 데이터가 고유 암호화로 자동 마이그레이션되어 OpenSSL 프레임워크를 사용하지 않고 후속 릴리스 작업을 허용합니다. 

#### OpenSSL 계속 사용
{: #continuing-with-openssl }
penSSL이 필요한 경우 옵션 2에 설명된 설정을 사용하십시오. 
