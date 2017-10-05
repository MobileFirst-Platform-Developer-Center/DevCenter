---
layout: tutorial
title: 애플리케이션 업데이트의 푸시 알림
breadcrumb_title: 푸시 알림
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
스토어에서 애플리케이션의 업데이트가 사용 가능한 경우 푸시 알림을 사용자에게 보내도록 Application Center 클라이언트를 구성할 수 있습니다. 

Application Center 관리자는 모든 iOS 또는 Android 디바이스에 알림을 자동으로 보내기 위해 푸시 알림을 사용합니다. Application Center 서버에 배포되고 권장으로 표시되는 새 애플리케이션과 즐겨찾기 애플리케이션의 업데이트에 대해 알림이 전송됩니다. 

### 푸시 알림 프로세스
{: #push-notification-process }
다음 조건이 충족되는 경우 푸시 알림이 디바이스에 전송됩니다. 

* Application Center가 디바이스에 설치되어 있고 적어도 한 번 이상 시작되었습니다. 
* 사용자가 **설정 → 알림** 인터페이스에서 Application Center에 대한 푸시 알림을 사용 안함으로 설정하지 않았습니다. 
* 사용자가 애플리케이션을 설치하도록 허용되어 있습니다. 해당 권한은 Application Center 액세스 권한을 통해 제어됩니다. 
* 애플리케이션이 권장으로 표시되거나 이 디바이스에서 Application Center를 사용 중인 사용자에 대해 선호로 표시되어 있습니다. 이러한 플래그는 사용자가 Application Center를 통해 애플리케이션을 설치할 때 자동으로 설정됩니다. 디바이스의 Application Center **즐겨찾기** 탭에서 선호로 표시된 애플리케이션을 확인할 수 있습니다. 
* 애플리케이션이 디바이스에 설치되어 있지 않거나 디바이스에 설치된 버전보다 최신 버전이 사용 가능합니다. 

Application Center 클라이언트를 디바이스에서 처음 시작할 때 사용자는 입력 푸시 알림의 승인 여부를 묻는 질문을 받을 수 있습니다. 이는 iOS 모바일 디바이스의 경우에 해당합니다. 서비스가 모바일 디바이스에서 사용 안함으로 설정된 경우 푸시 알림 기능이 작동되지 않습니다. 

iOS 및 최신 Android 운영 체제 버전은 개별 애플리케이션에서 이 서비스를 켜거나 끄는 방법을 제공합니다. 

푸시 알림에 대해 모바일 디바이스를 구성하는 방법을 알아보려면 디바이스 벤더에게 문의하십시오. 

#### 다음으로 이동
{: #jump-to }
* [애플리케이션 업데이트에 대해 푸시 알림 구성](#configuring-push-notifications)
* [Google Cloud Messaging에 연결하도록 Application Center 서버 구성](#gcm)
* [Apple 푸시 알림 서비스에 연결하도록 Application Center 서버 구성](#apns)
* [GCM API에 종속되지 않은 모바일 클라이언트 버전 빌드](#no-gcm)

## 애플리케이션 업데이트에 대해 푸시 알림 구성
{: #configuring-push-notifications }
써드파티 푸시 알림 서버와 통신하려면 Application Center 서비스의 신임 정보 또는 인증서를 구성해야 합니다. 

### Application Center의 서버 스케줄러 구성
{: #configuring-the-server-scheduler }
서버 스케줄러는 서버와 함께 자동으로 시작되고 중지되는 백그라운드 서비스입니다. 이 스케줄러는 전송될 푸시 업데이트 메시지로 관리자 조치에 의해 자동으로 채워지는 스택을 주기적으로 비우는 데 사용됩니다. 푸시 업데이트 메시지의 두 개 일괄처리를 전송하는 기본 간격은 12시간입니다. 이 기본값이 적합하지 않은 경우 **ibm.appcenter.push.schedule.period.amount** 및 **ibm.appcenter.push.schedule.period.unit** 서버 환경 변수를 사용하여 간격을 수정할 수 있습니다. 

**ibm.appcenter.push.schedule.period.amount**의 값은 정수입니다. **ibm.appcenter.push.schedule.period.unit**의 값은 초, 분 또는 시간일 수 있습니다. 단위가 지정되지 않은 경우 양은 시간 단위로 표시되는 간격입니다. 이러한 변수는 푸시 메시지의 두 개 일괄처리 간에 경과된 시간을 정의하는 데 사용됩니다. 

이러한 변수를 정의하려면 JNDI 특성을 사용하십시오. 

> **중요:** 프로덕션 환경에서는 단위를 초로 설정하지 마십시오. 경과 시간이 짧을수록 서버의 로드가 더 높아집니다. 초로 표시되는 단위는 테스트 및 평가 목적으로만 구현됩니다. 예를 들어, 경과 시간이 10초로 설정되면 푸시 메시지를 거의 즉시 보내게 됩니다.

설정할 수 있는 전체 특성 목록은 [Application Center의 JNDI 특성](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)을 참조하십시오. 

### Apache Tomcat 서버의 예         
{: tomcat }
server.xml 파일의 JNDI 특성으로 다음 변수를 정의하십시오. 

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server v8.5
{: #websphere }
WebSphere Application Server v8.5에 대해 JNDI 변수를 구성하려면 다음과 같이 진행하십시오. 

1. **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션**을 클릭하십시오. 
2. Application Center 서비스 애플리케이션을 선택하십시오. 
3. **웹 모듈 특성 → 웹 모듈에 대한 환경 항목**을 클릭하십시오. 
4. **값** 열의 문자열을 편집하십시오. 

#### WebSphere Application Server Liberty 프로파일
{: #liberty }
WebSphere Application Server Liberty 프로파일에 맞게 JNDI 변수를 구성하는 방법에 대한 정보는 [서버 구성 파일의 상수에 JNDI 바인딩 사용](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html)을 참조하십시오. 

푸시 알림 서비스를 설정하기 위한 나머지 조치는 대상 애플리케이션이 설치되는 디바이스의 벤더에 따라 다릅니다. 

## Google Cloud Messaging에 연결하도록 Application Center 서버 구성
{: #gcm }
애플리케이션에 GCM(Google Cloud Messaging)을 사용하려면 Google API가 사용으로 설정된 개발자 Google 계정에 GCM 서비스를 연결해야 합니다. 세부사항은 [GCM 시작하기](http://developer.android.com/google/gcm/gs.html)를 참조하십시오. 

> 중요: Google Cloud Messaging이 없는 Application Center의 경우 Application Center는 GCM(Google Cloud Messaging) API의 가용성과 관련이 있습니다. 이 API는 중국과 같은 일부 지역의 디바이스에서 사용 가능하지 않을 수도 있습니다. 이러한 지역을 지원하기 위해 GCM API에 종속되지 않은 Application Center 클라이언트 버전을 빌드할 수 있습니다. 푸시 알림 기능은 Application Center 클라이언트의 해당 버전에서 작동하지 않습니다. 세부사항은 [GCM API에 종속되지 않은 모바일 클라이언트 버전 빌드](#no-gcm)를 참조하십시오.

1. 적절한 Google 계정이 없는 경우 [Google 계정 작성](https://mail.google.com/mail/signup)으로 이동하여 Application Center 클라이언트에 대해 하나를 작성하십시오. 
2. [Google API 콘솔](https://code.google.com/apis/console/)에서 Google API를 사용하여 이 계정을 등록하십시오. 등록하면 이름을 바꿀 수 있는 새 기본 프로젝트가 작성됩니다. 이 GCM 프로젝트에 부여하는 이름은 사용자의 Android 애플리케이션 패키지 이름과 관련이 없습니다. 프로젝트가 작성될 때 GCM 프로젝트 ID가 프로젝트 URL의 끝에 추가됩니다. 나중에 참조하기 위해 이 후미 숫자를 프로젝트 ID로 기록해야 합니다. 
3. 프로젝트에 대해 GCM 서비스를 사용하도록 설정하십시오. Google API 콘솔에서 왼쪽에 있는 **서비스** 탭을 클릭하고 서비스 목록에서 "Google Cloud Messaging for Android" 서비스를 사용으로 설정하십시오. 
4. 단순 API 액세스 서버 키를 애플리케이션 통신에 사용할 수 있는지 확인하십시오. 
    * 콘솔의 왼쪽에 있는 **API 액세스** 세로 탭을 클릭하십시오. 
    * 단순 API 액세스 서버 키를 작성하거나, 기본 키가 이미 작성된 경우 기본 키의 세부사항을 확인하십시오. 현재 관심이 없는 두 가지 유형의 키가 있습니다. 
    * 나중에 GCM을 통해 애플리케이션 통신에 사용할 수 있도록 단순 API 액세스 서버 키를 저장하십시오. 키는 길이가 약 40자이고 서버 측에서 나중에 필요한 Google API 키로 참조됩니다. 
5. Application Center Android 클라이언트의 JavaScript 프로젝트에서 문자열 자원 특성으로 GCM 프로젝트 ID를 입력하십시오. **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** 템플리트 파일에서 고유 값으로 이 행을 수정하십시오. 

   ```xml
   gcmProjectId:""// Google API project (project name = com.ibm.appcenter) ID needed for Android push.
   // example : 123456789012
   ```

6. Application Center 서버의 JNDI 특성으로 Google API 키를 등록하십시오. 키 이름은 **ibm.appcenter.gcm.signature.googleapikey**입니다. 예를 들어, Apache Tomcat 서버에 대해 이 키를 **server.xml** 파일의 JNDI 특성으로 구성할 수 있습니다. 

   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String" 
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   JNDI 특성은 애플리케이션 서버 요구사항에 따라 정의해야 합니다.   
   설정할 수 있는 전체 특성 목록은 [Application Center의 JNDI 특성](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)을 참조하십시오. 
    
**중요:**

* 이전 버전의 Android에서 GCM을 사용하는 경우 GCM이 효과적으로 작동하게 하려면 디바이스를 기존 Google 계정과 쌍으로 지정해야 합니다. [GCM 서비스](http://developer.android.com/google/gcm/gcm.html): "Google 서비스에 기존 연결을 사용합니다. 3.0 이전 디바이스의 경우 사용자가 모바일 디바이스에서 Google 계정을 설정해야 합니다. Google 계정은 Android 4.0.4 이상을 실행하는 디바이스의 요구사항이 아닙니다."를 참조하십시오. 
* 또한 푸시 알림을 작동시키려면 방화벽이 포트 443에서 android.googleapis.com에 대한 출력 연결을 허용하는지도 확인해야 합니다. 

## Apple 푸시 알림 서비스에 연결하도록 Application Center 서버 구성
{: #apns }
Apple 푸시 알림 서비스(APN)에 대해 iOS 프로젝트를 구성하십시오. Application Center 서버에서 다음 서버에 액세스할 수 있는지 확인하십시오. 

**샌드박스 서버**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**프로덕션 서버**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

Apple 푸시 알림 서비스(APN)로 iOS 프로젝트를 구성하려면 사용자가 등록된 Apple 개발자여야 합니다. 회사에서 Apple 개발을 담당하는 관리 역할이 APN 사용을 요청합니다. 이 요청에 대한 응답은 iOS 애플리케이션 번들의 APN 사용 프로비저닝 프로파일, 즉 Xcode 프로젝트의 구성 페이지에 정의된 문자열 값을 제공해야 합니다. 이 프로비저닝 프로파일은 서명 인증서 파일을 생성하는 데 사용됩니다.
두 가지 유형의 프로비저닝 프로파일(각각 개발 및 프로덕션 환경을 처리하는 개발 프로파일과 프로덕션 프로파일)이 있습니다. 개발 프로파일은 독점적으로 Apple 개발 APN 서버를 처리합니다. 프로덕션 프로파일은 독점적으로 Apple 프로덕션 APN 서버를 처리합니다. 이러한 유형의 서버는 동일한 서비스 품질(QoS)을 제공하지 않습니다. 

참고: 방화벽으로 보호되는 회사 WiFi에 연결되는 디바이스는 다음 유형의 주소가 방화벽에 의해 차단되지 않는 경우에만 푸시 알림을 수신할 수 있습니다. 

`x-courier.sandbox.push.apple.com:5223`  
여기서 x는 정수입니다. 

1. Application Center Xcode 프로젝트에 대한 APN 사용 프로비저닝 프로파일을 확보하십시오. 관리자의 APN 사용 요청의 결과는 [https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action)에서 액세스 가능한 목록으로 표시됩니다. 목록의 각 항목은 프로파일에 APN 기능이 있는지 여부를 표시합니다. 프로파일이 있는 경우 프로파일을 두 번 클릭하여 프로파일을 다운로드하고 Application Center 클라이언트 Xcode 프로젝트 디렉토리에 설치할 수 있습니다. 그러면 프로파일이 키 저장소와 Xcode 프로젝트에 자동으로 설치됩니다. 

2. XCode에서 직접 실행하여 디바이스에서 Application Center를 테스트 또는 디버그하려면 "Xcode 구성자" 창에서 "프로비저닝 프로파일" 섹션으로 이동하여 모바일 디바이스에 프로파일을 설치하십시오. 

3. Application Center 서비스에서 사용하는 서명 인증서를 작성하여 APN 서버와 통신에 보안을 설정하십시오. 이 서버는 APN 서버에 대한 각 푸시 요청에 서명하기 위해 인증서를 사용합니다. 이 서명 인증서는 사용자의 프로비저닝 프로파일에서 생성됩니다. 
    
* "키체인 액세스" 유틸리티를 열고 왼쪽 분할창에서 **내 인증서** 카테고리를 클릭하십시오. 
* 설치하려는 인증서를 찾아서 해당 컨텐츠를 공개하십시오. 인증서와 개인 키가 모두 표시됩니다. Application Center의 경우 인증서 행에는 Application Center 애플리케이션 번들 **com.ibm.imf.AppCenter**가 있습니다. 
* **파일 → 항목 내보내기**를 선택하여 인증서 및 키를 모두 선택하고 개인 정보 교환(.p12) 파일로 내보내십시오. 이 .p12 파일에는 APN 서버와 통신하는 데 보안 핸드쉐이킹 프로토콜이 관련된 경우 필요한 개인 키가 있습니다. 
* Application Center 서비스의 실행을 담당하는 컴퓨터에 .p12 인증서를 복사하고 적절한 위치에 설치하십시오. APN 서버에 대한 보안 터널링을 작성하는 데 인증서 파일과 해당 비밀번호가 모두 필요합니다. 또한 개발 인증서 또는 프로덕션 인증서가 실행되는지 여부를 표시하는 일부 정보가 필요합니다. 개발 프로비저닝 프로파일이 개발 인증서를 생성하고 프로덕션 프로파일은 프로덕션 인증서를 제공합니다. Application Center 서비스 웹 애플리케이션은 JNDI 특성을 사용하여 이 보안 데이터를 참조합니다. 

표의 예는 Apache Tomcat 서버의 server.xml 파일에서 JNDI 특성이 정의되는 방식을 보여줍니다. 

| JNDI 특성     | 유형 및 설명        | Apache Tomcat 서버의 예         | 
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location| .p12 인증서의 전체 경로를 정의하는 문자열 값.| `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password| 인증서에 액세스하는 데 필요한 비밀번호를 정의하는 문자열 값.| `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` | 
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate|	인증서를 생성하는 데 사용된 프로비저닝 프로파일이 개발 인증서인지 여부를 정의하는 부울 값(true 또는 false로 식별됨).| `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` | 

설정할 수 있는 JNDI 특성의 전체 목록은 [Application Center의 JNDI 특성](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)을 참조하십시오. 

## GCM API에 종속되지 않은 모바일 클라이언트 버전 빌드
{: #no-gcm }
일부 지역의 제한조건을 준수하기 위해 Android 버전의 클라이언트에서 GCM(Google Cloud Messaging) API에 대한 종속성을 제거할 수 있습니다. 푸시 알림은 이 버전의 클라이언트에서 작동되지 않습니다. 

Application Center는 GCM(Google Cloud Messaging) API의 가용성과 관련이 있습니다. 이 API는 중국과 같은 일부 지역의 디바이스에서 사용 가능하지 않을 수도 있습니다. 이러한 지역을 지원하기 위해 GCM API에 종속되지 않은 Application Center 클라이언트 버전을 빌드할 수 있습니다. 푸시 알림 기능은 Application Center 클라이언트의 해당 버전에서 작동하지 않습니다. 

1. **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** 파일에 `"gcmProjectId": "" ,` 행이 있는지 확인하여 푸시 알림이 사용 안함으로 설정되었는지 확인하십시오. 
2. **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** 파일의 두 위치, 즉 `<!-- AppCenter Push configuration -->` 및 `<!-- end of AppCenter Push configuration -->` 주석 사이의 모든 행을 제거하십시오. 
3. **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java** 클래스를 삭제하십시오. 
4. Eclipse의 IBMAppCenter/apps/AppCenter/android 폴더에서 "Android 환경 빌드"를 실행하십시오. 
5. 이전 "Android 환경 빌드" 명령을 실행할 때 MobileFirst 플러그인에서 작성한 **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar** 파일을 삭제하십시오. 
6. GCM 라이브러리의 제거를 고려하기 위해 새로 작성된 IBMAppCenterAppCenterAndroid 프로젝트를 새로 고치십시오. 
7. Application Center의 .apk 파일을 빌드하십시오. 

Android 환경이 빌드될 때마다 MobileFirst Eclipse 플러그인이 **gcm.jar** 라이브러리를 자동으로 추가합니다. 따라서 MobileFirst Android 빌드 프로세스가 실행될 때마다 **IBMAppCenter/apps/AppCenter/android/native/libs/** 디렉토리에서 이 Java 아카이브 파일을 삭제해야 합니다. 그렇지 않으면 생성되는 **appcenter.apk** 파일에 **gcm.jar** 라이브러리가 남게 됩니다. 
