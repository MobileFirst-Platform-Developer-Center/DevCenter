---
layout: tutorial
title: Cordova 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 학습서에서는 Apache Cordova, Ionic 또는 다른 써드파티 도구를 사용하여 작성된 신규 또는 기존 Cordova 애플리케이션에 {{ site.data.keys.product_adj }} SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법 및 프로젝트에서 변경된 {{ site.data.keys.product_adj }} 구성 파일에 대한 정보를 찾는 방법에 대해서도 학습합니다.

{{ site.data.keys.product_adj }} Cordova SDK는 Cordova 플러그인 세트로 제공되며 [NPM에 등록됩니다](https://www.npmjs.com/package/cordova-plugin-mfp).   
사용 가능한 플러그인은 다음과 같습니다.

* **cordova-plugin-mfp** - 핵심 SDK 플러그인
* **cordova-plugin-mfp-push** - 푸시 알림 지원 제공
* **cordova-plugin-mfp-jsonstore** - JSONStore 지원 제공
* **cordova-plugin-mfp-fips** - *Android 전용*. FIPS 지원 제공
* **cordova-plugin-mfp-encrypt-utils** - *iOS 전용*. 암호화 및 복호화에 대한 지원 제공

#### 지원 레벨
{: #support-levels }
MobileFirst 플러그인에서 지원되는 Cordova 플랫폼 버전은 다음과 같습니다.

* cordova-ios: **>= 4.1.1 및 < 5.0**
* cordova-android: **>= 5.1.1 및 < 6.0**
* cordova-windows: **>= 4.3.2 및 < 5.0**

#### 다음으로 이동:
{: #jump-to }
- [Cordova SDK 컴포넌트](#cordova-sdk-components)
- [{{ site.data.keys.product_adj }} Cordova SDK 추가](#adding-the-mobilefirst-cordova-sdk)
- [{{ site.data.keys.product_adj }} Cordova SDK 업데이트](#updating-the-mobilefirst-cordova-sdk)
- [생성된 {{ site.data.keys.product_adj }} Cordova SDK 아티팩트](#generated-mobilefirst-cordova-sdk-artifacts)
- [다음 학습서](#tutorials-to-follow-next)

> **참고:** Xcode 8을 사용하는 경우 iOS 시뮬레이터에서 iOS 앱을 실행 중이면 **키 체인 공유** 기능은 필수입니다. 이 기능을 수동으로 사용하도록 설정한 후에 Xcode 프로젝트를 빌드해야 합니다.

## Cordova SDK 컴포넌트
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
cordova-plugin-mfp 플러그인은 Cordova의 핵심 {{ site.data.keys.product_adj }} 플러그인이며 필수입니다. 아직 설치되지 않은 경우 다른 {{ site.data.keys.product_adj }} 플러그인을 설치하면 cordova-plugin-mfp 플러그인도 자동으로 설치됩니다.

> 다음 Cordova 플러그인이 cordova-plugin-mfp의 종속 항목으로 설치됩니다.
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
cordova-plugin-mfp-jsonstore 플러그인을 통해 앱에서 JSONstore를 사용할 수 있습니다. JSONstore에 대한 자세한 정보는 [JSONStore 학습서](../../jsonstore/cordova/)를 참조하십시오.   

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
cordova-plugin-mfp-push 플러그인은 Android 애플리케이션의 {{ site.data.keys.mf_server }}에서 푸시 알림을 사용하는 데 필요한 권한을 제공합니다. 푸시 알림을 사용하려면 추가 설정이 필요합니다. 푸시 알림에 대한 자세한 정보는 [푸시 알림 학습서](../../../notifications/)를 참조하십시오.

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
cordova-plugin-mfp-fips 플러그인은 Android 플랫폼에 대한 FIPS 140-2 지원을 제공합니다. 자세한 정보는 [FIPS 140-2 지원을 참조](../../../administering-apps/federal/#fips-140-2-support)하십시오.

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
cordova-plugin-mfp-encrypt-utils 플러그인은 iOS 플랫폼에 Cordova 애플리케이션의 암호화에 필요한 iOS OpenSSL을 제공합니다. 자세한 정보는 [Cordova iOS에 OpenSSL 사용](additional-information)을 참조하십시오.

**전제조건:**

- 개발자 워크스테이션에 [Apache Cordova CLI 6.x](https://www.npmjs.com/package/cordova) 및 {{ site.data.keys.mf_cli }}가 설치되어 있습니다.
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다.
- [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/development/mobilefirst) 및 [Cordova 개발 환경 설정](../../../installation-configuration/development/cordova) 학습서를 읽으십시오.

## {{ site.data.keys.product }} Cordova SDK 추가
{: #adding-the-mobilefirst-cordova-sdk }
아래 지시사항에 따라 신규 또는 기존 Cordova 프로젝트에 {{ site.data.keys.product }} Cordova SDK를 추가하고 {{ site.data.keys.mf_server }}에 등록하십시오.

시작하기 전에 {{ site.data.keys.mf_server }}가 실행 중인지 확인하십시오.   
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.sh` 명령을 실행하십시오.

> **참고:** 기존 Cordova 애플리케이션에 SDK를 추가하는 경우 플러그인이 `MainActivity.java` 파일(Android) 및 `Main.m` 파일(iOS)을 겹쳐씁니다.

### SDK 추가
{: #adding-the-sdk }
{{ site.data.keys.product_adj }} Cordova **애플리케이션 템플리트**를 사용하여 프로젝트를 작성할 것을 고려하십시오. 해당 템플리트는 필수 {{ site.data.keys.product_adj }} 특정 플러그인 항목을 Cordova 프로젝트의 **config.xml** 파일에 추가하고 {{ site.data.keys.product_adj }} 애플리케이션 개발에 대해 조정되었으며 바로 사용 가능한 {{ site.data.keys.product_adj }} 특정 **index.js** 파일을 제공합니다.

#### 새 애플리케이션
{: #new-application }
1. 다음과 같이 Cordova 프로젝트를 작성하십시오. `cordova create projectName applicationId --template cordova-template-mfp`

예:

   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - "Hello"는 애플리케이션의 폴더 이름입니다.
     - "com.example.helloworld"는 애플리케이션의 ID입니다.
     - "HelloWorld"는 애플리케이션의 이름입니다.
     - --template는 {{ site.data.keys.product_adj }} 특정 추가로 애플리케이션을 수정합니다.

    > 템플리트된 **index.js**를 통해 추가 {{ site.data.keys.product_adj }} 기능(예: [다국어 애플리케이션 변환](../../translation) 및 초기화 옵션)을 사용할 수 있습니다(자세한 정보는 사용자 문서 참조).

2. Cordova 프로젝트의 루트인 `cd hello`로 디렉토리를 변경하십시오.

3. Cordova CLI 명령 `cordova platform add ios|android|windows`를 사용하여 Cordova 프로젝트에 하나 이상의 지원되는 플랫폼을 추가하십시오. 예:

   ```bash
   cordova platform add ios
   ```

   > **참고:** 애플리케이션이 {{ site.data.keys.product_adj }} 템플리트를 사용하여 구성되었으므로 3단계에서 플랫폼이 추가된 것과 같이 {{ site.data.keys.product_adj }} 핵심 Cordova 플러그인이 자동으로 추가됩니다.

4. `cordova prepare command`를 실행하여 애플리케이션 자원을 준비하십시오.

   ```bash
   cordova prepare
   ```

#### 기존 애플리케이션
{: #existing-application }
1. 기존 Cordova 프로젝트의 루트로 이동하고 {{ site.data.keys.product_adj }} 핵심 Cordova 플러그인을 추가하십시오.

   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. **www\js** 폴더로 이동하고 **index.js** 파일을 선택하십시오.

3. 다음 기능을 추가하십시오.

   ```javascript
   function wlCommonInit() {

   }
   ```

{{ site.data.keys.product_adj }} API 메소드는 {{ site.data.keys.product_adj }} 클라이언트 SDK가 로드된 후에 사용 가능합니다. 그런 다음 `wlCommonInit` 기능이 호출됩니다.   
이 기능으로 여러 {{ site.data.keys.product_adj }} API 메소드를 호출하십시오.

### 애플리케이션 등록
{: #registering-the-application }
1. **명령행** 창을 열고 Cordova 프로젝트의 루트로 이동하십시오.   

2. {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오.

   ```bash
   mfpdev app register
   ```
    - 원격 서버를 사용하는 경우 [`mfpdev server add` 명령을 사용](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)하여 추가하십시오.

`mfpdev app register` CLI 명령은 먼저 {{ site.data.keys.mf_server }}에 연결하여 애플리케이션을 등록한 후에 {{ site.data.keys.mf_server }}를 식별하는 메타데이터를 사용하여 Cordova 프로젝트의 루트에 있는 **config.xml** 파일을 업데이트합니다.

각 플랫폼은 {{ site.data.keys.mf_server }}에 애플리케이션으로 등록됩니다.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** {{ site.data.keys.mf_console }}에서 애플리케이션을 등록할 수도 있습니다.     
>
> 1. {{ site.data.keys.mf_console }}을 로드하십시오.   
> 2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.   

### SDK 사용
{: #using-the-sdk }
{{ site.data.keys.product_adj }} API 메소드는 {{ site.data.keys.product_adj }} 클라이언트 SDK가 로드된 후에 사용 가능합니다. 그런 다음 `wlCommonInit` 기능이 호출됩니다.   
이 기능으로 여러 {{ site.data.keys.product_adj }} API 메소드를 호출하십시오.

## {{ site.data.keys.product_adj }} Cordova SDK 업데이트
{: #updating-the-mobilefirst-cordova-sdk }
최신 릴리스로 {{ site.data.keys.product_adj }} Cordova SDK를 업데이트하려면 **cordova-plugin-mfp** 플러그인을 다음과 같이 제거하십시오. `cordova plugin remove cordova-plugin-mfp` 명령을 실행한 후에 `cordova plugin add cordova-plugin-mfp` 명령을 실행하여 다시 추가하십시오.

SDK 릴리스는 SDK의 [NPM 저장소](https://www.npmjs.com/package/cordova-plugin-mfp)에 있습니다.

## 생성된 {{ site.data.keys.product_adj }} Cordova SDK 아티팩트
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
Cordova 구성 파일은 애플리케이션 메타데이터를 포함하고 앱의 루트 디렉토리에 저장되는 필수 XML 파일입니다.   
프로젝트에 {{ site.data.keys.product_adj }} Cordova SDK가 추가되면 Cordova 생성 **config.xml** 파일은 `mfp:` 네임스페이스로 식별되는 새 요소 세트를 수신합니다. 추가되는 요소에는 {{ site.data.keys.product_adj }} 기능 및 {{ site.data.keys.mf_server }}에 관련된 정보가 포함됩니다.

### **config.xml** 파일에 추가되는 {{ site.data.keys.product_adj }} 설정 예제
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>          
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>클릭하여 config.xml 특성의 전체 목록 확인</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>요소</b></td>
                        <td><b>설명</b></td>
                        <td><b>구성</b></td>
                    </tr>
                    <tr>
                        <td><b>위젯</b></td>
                        <td><a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">config.xml 문서</a>의 루트 요소입니다. 해당 요소에는 두 가지 필수 속성이 포함됩니다. <ul><li><b>ID</b>: Cordova 프로젝트가 작성될 때 지정된 애플리케이션 패키지 이름입니다. {{ site.data.keys.mf_server }}에 애플리케이션이 등록된 이후 이 값이 수동으로 변경되면 애플리케이션을 다시 등록해야 합니다. </li><li><b>xmlns:mfp</b>: {{ site.data.keys.product_adj }} 플러그인 XML 네임스페이스입니다. </li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>필수입니다. 애플리케이션이 개발된 제품 버전입니다. </td>
                        <td>기본적으로 설정됩니다. 변경해서는 안 됩니다. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>선택사항입니다. 직접 업데이트 인증 기능을 사용으로 설정하면 배치 중에 직접 업데이트 패키지가 디지털로 서명됩니다. 클라이언트가 패키지를 다운로드하면 보안 검사가 실행되어 패키지 인증의 유효성을 검증합니다. 이 문자열 값은 직접 업데이트 .zip 파일을 인증하는 데 사용되는 공개 키입니다. </td>
                        <td><code>mfpdev app config direct_update_authenticity_public_key key-value</code> 명령으로 설정됩니다. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>선택사항입니다. 시스템 메시지를 표시하는 쉼표로 구분된 로케일 목록이 포함되어 있습니다. </td>
                        <td><code>mfpdev app config language_preferences key-value</code> 명령으로 설정됩니다. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td><code>WL.Client.init</code> 메소드가 호출되는 방식을 제어합니다. 기본적으로  이 값은 false로 설정되며 <code>WL.Client.init</code> 메소드는 {{ site.data.keys.product_adj }} 플러그인이 초기화된 후에 자동으로 호출됩니다. 이 값을 <b>true</b>로 설정하여 클라이언트 코드에서 <code>WL.Client.init</code>가 호출되는 시점을 명시적으로 제어하도록 하십시오. </td>
                        <td>수동으로 편집됩니다. <b>사용</b> 속성 값을 <b>true</b> 또는 <b>false</b>로 설정할 수 있습니다. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>클라이언트 애플리케이션이 {{ site.data.keys.mf_server }}와 통신하는 데 사용하는 기본 원격 서버 연결 정보입니다. <ul><li><b>url:</b> URL 값은 클라이언트에서 서버에 연결하는 데 기본적으로 사용하는 {{ site.data.keys.mf_server }} 프로토콜, 호스트 및 포트 값을 지정합니다. </li><li><b>runtime:</b> 런타임 값은 애플리케이션이 등록된 {{ site.data.keys.mf_server }} 런타임을 지정합니다. {{ site.data.keys.product_adj }} 런타임에 대한 자세한 정보는 {{ site.data.keys.mf_server }} 개요를 참조하십시오. </li></ul></td>
                        <td><ul><li>서버 URL 값은 <code>the mfpdev app config server</code> 명령으로 설정됩니다. </li><li>서버 런타임 값은 <code>mfpdev app config runtime</code> 명령으로 설정됩니다. </li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>이 요소에는 iOS 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>이 요소에는 Android 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>이 요소에는 Windows 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다. <ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>이 요소에는 Windows 8.1 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>이 요소에는 Windows 10 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>이 요소에는 Windows Phone 8.1 플랫폼에 대한 {{ site.data.keys.product_adj }} 관련 클라이언트 애플리케이션 구성이 모두 포함되어 있습니다.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>이 값은 애플리케이션 웹 자원의 체크섬입니다. <code>mfpdev app webupdate</code> 실행 시에 계산됩니다. </td>
                        <td>사용자가 구성할 수 없습니다. 체크섬 값은 <code>mfpdev app webupdate</code> 명령 실행 시 업데이트됩니다. <code>mfpdev app webupdate</code> 명령에 대한 세부사항을 확인하려면 명령 창에 <code>mfpdev help app webupdate</code>를 입력하십시오. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>이 값은 고유 {{ site.data.keys.product_adj }} SDK 레벨을 식별하는 데 사용되는 {{ site.data.keys.mf_console }} SDK 체크섬입니다. </td>
                        <td>사용자가 구성할 수 없습니다. 이 값은 기본적으로 설정됩니다. </td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>이 요소에는 {{ site.data.keys.product_adj }} 보안에 대한 클라이언트 애플리케이션의 플랫폼별 구성이 포함되어 있습니다. 다음을 포함합니다. <ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>모바일 디바이스에서 애플리케이션이 실행을 시작할 때마다 해당 웹 자원의 무결성을 확인하는지 여부를 제어합니다. 속성: <ul><li><b>enabled:</b> 올바른 값은 <b>true</b> 및 <b>false</b>입니다. 이 속성이 <b>true</b>로 설정되면 애플리케이션은 해당 웹 자원의 체크섬을 계산한 다음 애플리케이션이 처음 실행될 때 저장된 값과 비교합니다. </li><li><b>ignoreFileExtensions:</b> 웹 자원의 크기에 따라 체크섬 계산에 몇 초 정도 걸릴 수 있습니다. 이 계산에서 무시할 파일 확장자 목록을 제공하여 시간을 줄일 수 있습니다. <b>enabled</b> 속성 값이 <b>false</b>로 설정되면 이 값이 무시됩니다. </li></ul></td>
                        <td><ul><li><b>enabled</b> 속성은 <code>mfpdev app config android_security_test_web_resources_checksum key-value</code> 명령으로 설정됩니다. </li><li><b>ignoreFileExtensions</b> 속성은 <code>mfpdev app config android_security_ignore_file_extensions value</code> 명령으로 설정됩니다. </li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

### config.xml 파일에서 {{ site.data.keys.product_adj }} 설정 편집
{: #editing-mobilefirst-settings-in-the-configxml-file }
{{ site.data.keys.mf_cli }}에서 다음 명령을 실행하여 위 설정을 편집할 수 있습니다.

```bash
mfpdev app config
```

## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product_adj }} Cordova SDK가 통합되었으므로 다음을 수행할 수 있습니다.

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
