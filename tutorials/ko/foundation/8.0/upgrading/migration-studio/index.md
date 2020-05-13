---
layout: tutorial
title: Migration Studio
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Mobile Foundation Migration Studio
{: #mf-migration-studio}

> [Mobile Foundation Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip)를 다운로드하십시오. 

## Migration Studio의 개념
{: #what-is-migration-studio}

Mobile Foundation Migration Studio 플러그인은 MobileFirst Platform Foundation v7.1의 하이브리드 프로젝트를 현재 위치에서 업그레이드하여 Mobile Foundation v8 서버에 연결할 수 있게 하는 Eclipse 플러그인입니다. 이 플러그인은 MobileFirst v7.1 Studio 플러그인과 유사하며 MobileFirst Platform Foundation v7.1 Studio와 동일한 지원 환경에 설치할 수 있습니다. 

## Migration Studio를 사용해야 하는 이유
{: #why-use-migration-studio}

Mobile Foundation Migration Studio 플러그인은 기존 MobileFirst Platform Foundation v7.1 하이브리드 앱을 업그레이드하여 Mobile Foundation v8에서 작동할 수 있게 하는 빠른 경로입니다. 

> Mobile Foundation Migration Studio는 Mobile Foundation v8에 제한된 마이그레이션을 수행하므로 표준 마이그레이션 접근법을 더 선호합니다. 

## Migration Studio를 사용한 마이그레이션과 표준 마이그레이션 접근법 비교
{: #compare-with-standard-migration}

[마이그레이션 쿡북]({{site.baseurl}}/tutorials/en/foundation/8.0/upgrading/migration-cookbook/)에 설명된 MobileFirst Platform Foundation v7.1 하이브리드 앱의 표준 마이그레이션 접근법을 사용하면 Mobile Foundation v8 서버에 연결하는 완전한 Cordova 앱을 사용할 수 있습니다. 하지만 Migration Studio 접근법에서는 앱의 레거시 하이브리드 구조를 보존합니다(예: 임베디드 Cordova 플러그인을 사용하는 MobileFirst 프로젝트). 따라서, Migration Studio를 사용하여 마이그레이션된 앱은 일반적인 Mobile Foundation v8.0 앱에 제공되는 전체 기능을 다 활용하지 못합니다. 전체 알려진 제한사항 목록은 이 [절](#known-limitations-of-migration-studio)을 확인하십시오.   

## Migration Studio 시작
{: #get-started-with-migration-studio}

Migration Studio를 시작하려면 다음 태스크를 수행해야 합니다. 

* **태스크 1**: 프로젝트 설정. 

  다음 단계를 수행하여 이 태스크를 완료합니다. 

  1. MobileFirst Platform Foundation v7.1 Studio 플러그인에서 지원하는 Eclipse 버전을 설치합니다. 

  2. [Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip)를 다운로드하여 Eclipse IDE에 플러그인을 설치합니다. 이 단계는 MobileFirst Platform Foundation v7.1 Studio 플러그인 설치 방법과 다르지 않습니다.
     > **중요:** 기존 MobileFirst Studio 설치에서 그대로 업그레이드를 수행하지 마십시오. 

  3. **파일 > 가져오기 > 파일 시스템** 옵션을 사용하여 MobileFirst Platform Foundation v7.1 프로젝트를 Mobile Foundation Migration Studio로 가져옵니다. 또는, 이미 내보낸 프로젝트가 있는 경우, 파일 시스템에서 내보낸 `.zip` 파일을 가져올 수 있습니다. Migration Studio 인터페이스는 MobileFirst Platform Foundation v7.1 Studio와 매우 유사합니다. 

  4. 환경 폴더(android, iphone, ipad)의 백업을 보존합니다. `application-descriptor.xml`을 열고 환경을 삭제합니다. 모든 작업공간 리소스를 삭제하는 옵션을 선택합니다.
  ![프로젝트 설정](set-up-project.gif)

  5. 환경을 프로젝트에 다시 추가하고 빌드가 완료될 때까지 대기합니다. 이 단계에서는 이전 프로젝트에서 네이티브 프로젝트에 사용자 정의를 수행한 경우(예: 사용자 정의 Cordova 플러그인 추가), 다시 반복해야 합니다. 
  > Migration Studio는 프로젝트 내 Cordova 버전을 업그레이드하므로 기존의 일부 서드파티 Cordova 플러그인이 새 Cordova 버전과 호환되지 않을 수 있습니다. 이러한 경우, 플러그인에 제공되는 업데이트를 확인하여 Cordova 플러그인을 적절한 버전으로 업데이트하십시오. 

* **태스크 2**: 애플리케이션 설정. 

  다음 단계를 수행하여 이 태스크를 완료합니다. 

  1. 사용자 정의 인증 확인 핸들러를 수정하여 Mobile Foundation v8의 인증 확인 핸들러 프레임워크에서 작동할 수 있게 합니다. 그러나 인증 확인 핸들러의 `createChallengeHandler` 메소드와 인증 확인에 제출된 응답을 Mobile Foundation v8.0 보안 검사에 맞게 수정해야 합니다.
      **7.1 앱**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginRealm");
      options.parameters = {
              j_username : $('#AuthUsername').val(),
              j_password : $('#AuthPassword').val()
       };
      ```

      **마이그레이션된 앱**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginSecurityCheck");
      options.parameters = {
              username : $('#AuthUsername').val(),
              password : $('#AuthPassword').val()
       };
      ```

      >**참고**: 매개변수와 이름은 보안 검사 구성 방법에 따라 달라집니다. 

  2. [**선택사항**] 앱에 html 페이지가 여러 개 있는 경우, 개별 html 파일을 편집하고 JavaScript와 CSS 파일에 대한 경로 참조를 편집해서 새 프로젝트에서 작업할 수 있게 합니다. 

* **태스크 3**: Mobile Foundation v8.0 구성.

  다음 단계를 수행하여 이 태스크를 완료합니다. 

  1. Mobile Foundation v8 서버(Mobile Foundation v8 DevKit 서버 또는 Mobile Foundation의 OpenShift Container Platform 설치 또는 Mobile Foundation의 기존 온프레미스 설치 사용)를 시작하고 Mobile Foundation v8 서버에서 앱을 등록합니다. v8 Cordova 앱 등록에 관한 자세한 정보는 [여기](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/cordova/#2-creating-and-registering-an-application)에 있습니다.

  2. 어댑터와 인증 또는 로그인 모듈을 마이그레이션하여 Mobile Foundation 인스턴스에 배치합니다. 어댑터 마이그레이션에 관한 자세한 정보는 이 [절](../migrating-adapters/)을 참조하십시오. 

* **태스크 4**: 애플리케이션 실행. 

  다음 단계를 수행하여 이 태스크를 완료합니다. 

  **Android**

  1. Android Studio(3.2 이상)를 엽니다. 
  2. **기존 Android Studio 프로젝트 열기**를 클릭하고 폴더 `Eclipse Workspace/<ProjectName>/apps/<AppName>/android/native`로 이동합니다. 
  3. Gradle 랩퍼를 다시 생성하거나 Gradle 랩퍼 버전을 업그레이드 또는 변경하는 프롬프트와 파일의 읽기 전용 상태를 지우는 프롬프트를 승인합니다. 
  4. **프로젝트** 보기의 `mfpclient.properties` 파일로 이동하여 서버 연결 매개변수를 수정합니다. 
  5. 프로젝트를 실행합니다. 필요한 경우, `compileSdk` 버전을 변경하고 `build.gradle` 파일의 도구를 빌드합니다. 
  6. 푸시 알림을 사용하는 경우, `google-services.json` 파일을 생성하여 프로젝트에서 교체합니다. 자세한 정보는 이 [블로그 게시물]({{site.baseurl}}/blog/2018/10/09/FCM-Support-in-MFP-7.1-Android/)을 확인하십시오. 

  **iOS**

  1. XCode를 사용하여 `Eclipse_Workspace/<ProjectName>/apps/<AppName>/iphone/native`에 있는 iOS 네이티브 프로젝트를 엽니다.
  2. **프로젝트** 보기의 `mfpclient.plist` 파일로 이동하여 서버 연결 매개변수를 수정합니다. 
  3. 애플리케이션에서 푸시 알림 기능을 사용하는 경우, Xcode 프로젝트 설정에서 푸시 알림 기능을 사용하고 유효한 프로비저닝 프로파일을 추가합니다. 자세한 정보는 [여기]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/handling-push-notifications/cordova/#ios-platform)를 참조하십시오. 
  4. iOS에 추가 구성이 필요하지 않으며 XCode에서 프로젝트를 실행할 수 있습니다. 
  > iPad 환경에서는 동일한 단계를 따릅니다. 

  >**참고**: 앱을 빌드하여 실행하기 전에 버전, 패키지 이름 또는 번들 ID와 같은 애플리케이션 세부사항으로 모든 환경(Android, iOS 및 iPad)에서 `static_app_props.js`(`www/default/plugins/cordova-plugin-mfp/worklight`) 파일을 수정해야 합니다. 

## Migration Studio의 알려진 제한사항
{: #known-limitations-of-migration-studio}

* Migration Studio는 Android, iPhone 및 iPad 환경만 업그레이드합니다. 기타 환경은 업그레이드되지 않습니다. 
* 이 플러그인에서는 미리보기를 지원하지 않습니다. 
* Migration Studio는 `cordova-android`의 임베디드 버전을 8.1.0로 `cordova-ios`를 5.1.1로 업그레이드합니다. 이 버전은 고정되어 수정할 수 없습니다. 
* 기본 스킨만 지원됩니다. 
* 직접 업데이트 패키지를 이 프로젝트가 있는 MobileFirst 서버에 공개할 수 없습니다. 
* JSON 저장소 API는 이 릴리스에서 아직 지원되지 않습니다. 
  > **참고**: 파일을 프로젝트에 직접 추가하여 JSON 저장소를 계속 사용할 수 있습니다. 예: `cordova-plugin-mfp-jsonstore`를 플러그인 폴더에 추가, 플러그인 참조를 `cordova_plugins.js` 파일에 추가, 필수 JAR/Framework 파일 첨부. 

* Mobile Foundation v8.0의 새 기능은 지원되지 않습니다. 
* [더 이상 사용되지 않거나 사용이 중단된]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes) API의 동작이 수정되었습니다. 다음 절에서 동작의 변경에 대한 세부사항을 볼 수 있습니다. 

## JSONStore를 사용하여 애플리케이션 마이그레이션
{: #migrating-apps-using-jsonstore}

Migration Studio에서는 JSONStore를 사용하여 애플리케이션에서 JSONStore 플러그인을 마이그레이션하는 작업이 자동화되지 않습니다. 다음 단계를 수행하여 JSONStore 프로젝트를 수동으로 마이그레이션합니다. 

`cordova-plugin-mfp-jsonstore`를 [여기](https://us-south.git.cloud.ibm.com/ibmmfpf/cordova-plugin-mfp-jsonstore/tree/master)에서 다운로드합니다. 

### Android의 경우

1. 다음 `cordova-plugin-mfp-jsonstore/bootstrap.js` 파일과 `cordova-plugin-mfp-jsonstore/worklight` 폴더를 `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/assets/www/default/plugins/cordova-plugin-mfp-jsonstore` 폴더에 복사합니다. 

2. `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/assets/www/default/cordova_plugins.js` 파일을 열고 `module.exports` 배열에서 JSONStore에 다음 항목을 추가합니다. 
 ```json
 {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
   }
 ```

3. 다운로드된 ``cordova-plugin-mfp-jsonstore/src/android/libs``에서 종속 항목(JAR 파일만)을 ``<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/libs` 폴더에 복사하고 이러한 항목을 ``<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/build.gradle` 파일 종속 항목 섹션에 추가합니다. 
   ```text
   compile files('libs/commons-codec.jar')
   compile files('libs/guava.jar')
   compile files('libs/jackson-core-asl.jar')
   compile files('libs/jackson-mapper-asl.jar')
   compile files('libs/ibmmobilefirstplatformfoundationjsonstore.jar')
   compile files('libs/sqlcipher.jar')
   ```

4. 다음 항목을 `<ProjectName>/apps/<AppName>/android/native/<ProjectName><AppName>android/src/main/res/config.xml` 파일에 추가합니다. 
   ```xml
   <feature name="StoragePlugin">        
   <param name="android-package" value="com.worklight.androidgap.jsonstore.dispatchers.StoragePlugin" />    
   </feature>
   ```

### iOS의 경우

1. 다음 `cordova-plugin-mfp-jsonstore/bootstrap.js` 파일과 `cordova-plugin-mfp-jsonstore/worklight` 폴더를 `<ProjectName>/apps/<AppName>/iphone/native/www/default/plugins/cordova-plugin-mfp-jsonstore` 폴더에 복사합니다. 

2. `<ProjectName>/apps/<AppName>/iphone/native/www/default/cordova_plugins.js` 파일을 열고 JSON Store의 다음 항목을 `module.exports` 배열에 추가합니다. 
  ```JSON
  {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
      }
  ```
3. 다운로드된 `cordova-plugin-mfp-jsonstore /src/ios/Frameworks/IBMMobileFirstPlatformFoundationHybridJSONStore.framework to<ProjectName>/apps/<AppName>/iphone/native/Frameworks` 폴더에서 프레임워크를 복사하여 일반 탭의 XCode에서 **프레임워크, 라이브러리, 임베디드 컨텐츠**에 추가합니다. 

   >**참고**: 이미 XCode 프로젝트에 있는 SQLCipher 프레임워크를 대체하지 마십시오. 



## 더 이상 사용되지 않거나 사용 중지된 API의 사용
{: #deprecated-n-discontinued-apis}

다음 API는 사용이 중단되어 대체 항목으로 직접 교체해야 합니다.
[이 문서]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes)를 확인하여 대체 정보를 알아보십시오. 

|API |
|-----------------------|
|WL.App.BackgroundHandler|
|WL.Badge|
|WL.EncryptedCache|
|WL.TabBar|
|WL.TabBarItem|
|WL.Trusteer|
|WL.Client.createProvisioningChallengeHandler|
|WL.Client.createWLChallengeHandler|
|WL.SecurityUtils.remoteRandomString|

다음 API는 더 이상 지원되지 않으며 호출 시 콘솔에 오류 메시지가 표시됩니다. 

|API |
|-----------------------|
|WL.Client.checkForDirectUpdate|
|WL.Client.close (android only)|
|WL.Client.getLoginName|
|WL.Client.getUserInfo|
|WL.Client.getUserName|
|WL.Client.getUserPref|
|WL.Client.getLoginName|
|WL.Client.isUserAuthenticated|
|WL.Client.getUserPref|
|WL.Client.setUserPrefs|
|WL.Client.hasUserPrefs|
|WL.Client.deleteUserPref|
|WL.Client.updateUserInfo|
|WL.Toast.show (android only)|
|WLAuthorizationManager.getUserIdentity|
|WLAuthorizationManager.getDeviceIdentity|
|WLAuthorizationManager.getAppIdentity|

## 지원 
{: #ms-support}

Mobile Foundation Migration Studio는 MobileFirst Platform Foundation v7.1에서 Mobile Foundation v8.0으로 쉽게 마이그레이션하기 위해 제공되는 추가 기능입니다. IBM 지원 포털의 사례를 여는 일반 IBM 지원 프로세스는 Migration Studio 관련 문제에는 적용되지 않습니다. 지원을 받으려면, [Slack 채널에 가입하여 요청을 제출하거나]({{site.baseurl}}/blog/2017/05/26/come-chat-with-us/) [GitHub 문제](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/issues)를 여십시오. 
