---
layout: tutorial
title: 기존 Cordova 및 하이브리드 애플리케이션 마이그레이션
breadcrumb_title: Cordova and hybrid
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM MobileFirst Foundation 버전 6.2.0 이상으로 작성된 기존 Cordova 또는 하이브리드 애플리케이션을 마이그레이션하려면 현재 버전의 플러그인을 사용하는 Cordova 프로젝트를 작성해야 합니다. 그런 다음 v8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 마이그레이션 지원 도구를 사용하면 이 태스크를 수행할 수 있습니다.

#### 다음으로 이동
{: #jump-to }
* [v8.0으로 개발된 Cordova 앱과 v7.1 이하 버전으로 개발된 Cordova 앱의 비교](#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)
* [기존 하이브리드 또는 크로스 플랫폼 앱을 {{ site.data.keys.product_full }} 8.0이 지원하는 Cordova 앱으로 마이그레이션](#migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80)
* [iOS Cordova의 암호화 마이그레이션](#migrating-encryption-for-ios-cordova)
* [직접 업데이트 마이그레이션](#migrating-direct-update)
* [WebView 업그레이드](#upgrading-the-webview)
* [제거된 컴포넌트](#removed-components)

## v8.0으로 개발된 Cordova 앱과 v7.1 이하 버전으로 개발된 Cordova 앱의 비교
{: #comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before }
{{ site.data.keys.product_adj }} v8.0으로 개발된 Cordova 앱과 IBM MobileFirst Platform Foundation v7.1로 개발된 하이브리드 앱을 비교하십시오.

|기능 |Cordova 앱<br/>IBM {{ site.data.keys.product }} v8.0으로 개발 |	Cordova 앱<br/>IBM MobileFirst Platform Foundation v7.1로 개발 |MobileFirst 하이브리드 앱<br/>IBM MobileFirst Platform Foundation V7.1로 개발 |
|---------|-------|---------|-------|------|
|**IDE Eclipse Studio** | | | |  	 	 
|Eclipse 플러그인 및 통합 |예 |지원되지 않음 |예(전용) |
|애플리케이션 컴포넌트 |예(Cordova)<br/><br/>참고: 조직에서 애플리케이션 컴포넌트를 관리하려면 고유의 Cordova 플러그인을 작성하십시오. |예(Cordova)<br/><br/>참고: 조직에서 애플리케이션 컴포넌트를 관리하려면 고유의 Cordova 플러그인을 작성하십시오. |예(전용) |
|프로젝트 템플리트 |예(Cordova)<br/><br/>참고: Apache Cordova `cordova create --template` 명령을 사용하십시오. |예(Cordova)<br/><br/>참고: `mfp cordova create --template` 또는 Apache Cordova 명령 `cordova create --copy-from`을 사용하십시오. |예(전용) |
|Dojo 및 jQuery IDE 인스트루먼테이션 |예<br/><br/>참고: Dojo 및 jQuery Mobile은 Cordova 앱에서 사용할 수 있는 JavaScript 프레임워크입니다. |예<br/><br/>참고: Dojo 및 jQuery Mobile은 Cordova 앱에서 사용할 수 있는 JavaScript 프레임워크입니다. |예 |
|모바일 UI 패턴 |지원되지 않음 |지원되지 않음 |더 이상 사용되지 않음 |
|**애플리케이션 하위 유형** | | |
|쉘 컴포넌트 |지원되지 않음<br/><br/>참고: 이전 하이브리드 앱에서 쉘 및 내부 애플리케이션을 사용한 경우 Cordova 디자인 패턴을 채택하고 쉘 컴포넌트를 애플리케이션 간에 공유될 수 있는 Cordova 플러그인으로 구현할 것을 권장합니다. |지원되지 않음 |예 |
|내부 하이브리드 애플리케이션 |지원되지 않음<br/><br/>참고: 이전 하이브리드 앱에서 쉘 및 내부 애플리케이션을 사용한 경우 Cordova 디자인 패턴을 채택하고 쉘 컴포넌트를 애플리케이션 간에 공유될 수 있는 Cordova 플러그인으로 구현할 것을 권장합니다. |지원되지 않음 |예 |
|**애플리케이션 기능** | | | 	 	 	 
|모바일 OS	|iOS 8 이상, Android 4.1 이상, Windows Phone 8.1, Windows Phone 10. |iOS 7 이상, Android 4 이상. |iOS, Android 및 Windows Phone 8 |
|웹 애플리케이션 |예. Apache Cordova 없이 개발된 JavaScript 애플리케이션. |지원되지 않음 |예. desktopbrowser 또는 mobilewebapp 환경. |
|직접 업데이트 |예. |예 |예 |
|{{ site.data.keys.product_adj }} 보안 프레임워크 |예 |예 |예 |
|애플리케이션 인증 |예 |예 |예 |
|인증서 고정 |예 |아니오 |예 |
|JSONStore |예. |cordova-plugin-mfp-jsonstore 플러그인을 사용하십시오. |예 |
|FIPS 140-2 |예. cordova-plugin-mfp-fips 플러그인을 사용하십시오.<br/><br/>제한사항: FIPS는 Android 및 iOS를 위해 지원됩니다. FIPS는 Windows를 위해 지원되지 않습니다. |아니오 |예 |
|애플리케이션 2진 파일 내에서 애플리케이션과 연관된 웹 리소스의 암호화 |예 |	아니오 |예 |
|앱이 실행을 시작할 때마다 체크섬을 사용하여 웹 리소스의 무결성 검증 |예 |지원되지 않음 |예 |
|주소 지정 가능 디바이스 라이센스 추적을 위한 앱의 대상 카테고리(B2E 또는 B2C) 스펙 |예 |아니오 |예 |
|단순 데이터 공유 |아니오 |예 |예 |
|싱글 사인온 |예<br/><br/>참고: 디바이스 싱글 사인온(SSO)은 이제 새 사전 정의된 enableSSO 보안 검사 애플리케이션 디스크립터 구성 특성을 사용하여 지원됩니다. |예 |예 |
|{{ site.data.keys.product_adj }} 애플리케이션 스킨 |아니오<br/><br/>참고: 여러 디바이스 화면 크기를 감지하고 처리하려면 빠른 응답 웹 디자인과 같은 표준 웹 개발 사례를 사용하십시오. |아니오<br/><br/>참고: 여러 디바이스 화면 크기를 감지하고 처리하려면 빠른 응답 웹 디자인과 같은 표준 웹 개발 사례를 사용하십시오. |예 |
|환경 최적화 |예(Cordova). |merges 디렉토리를 사용하여 특정 플랫폼에 대한 웹 리소스를 정의하십시오. |예(Cordova). merges 디렉토리를 사용하여 특정 플랫폼에 대한 웹 리소스를 정의하십시오. 자세한 정보는 Apache Cordova 문서의 merges를 사용하여 각 플랫폼 사용자 정의를 참조하십시오. |
|푸시 알림 |예. cordova-plugin-mfp-push 플러그인을 사용하십시오.<br/><br/>제한사항: 사전 정의된 {{ site.data.keys.product_adj }} 보안 검사는 push.mobileclient 범위에만 맵핑할 수 있습니다. JavaScript 인증 확인 핸들러가 호출되지 않으므로 사용자 정의 보안 검사는 지원되지 않습니다. |예<br/><br/>참고: Android의 경우, cordova-plugin-mfp-push 플러그인을 추가해야 합니다. 코어 mfp 플러그인에 iOS에 대한 푸시 클라이언트 측 지원이 포함되어 있으므로 iOS의 경우에는 이 플러그인이 필요하지 않습니다. |예 |
|Cordova 플러그인 관리 |예 |예 |아니오 |
|MESSAGES(i18n) |예 |예 |예 |
|토큰 라이센싱 |예 |예 |예 |
|**애플리케이션 최적화** | | |
|축소 |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(전용) |
|JS 및 CSS의 연결 |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(전용) |
|난독화 |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(Cordova)<br/><br/>참고: 공통 개방형 소스 도구를 사용하십시오. |예(전용) |
|Android Pro Guard |예<br/><br/>참고: {{ site.data.keys.product }} V8.0.0에는 Android ProGuard 난독화를 위해 {{ site.data.keys.product_adj }} Android 애플리케이션과 함께 사전 정의된 proguard-project.txt 구성 파일이 포함되지 않습니다. |예<br/><br/>참고: Pro Guard를 사용하려면 Android 문서를 참조하십시오. |예 |

## 기존 하이브리드 또는 크로스 플랫폼 앱을 {{ site.data.keys.product }} 8.0이 지원하는 Cordova 앱으로 마이그레이션
{: #migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80 }
IBM MobileFirst Platform Foundation 버전 6.2 이상으로 개발된 기존 하이브리드 또는 크로스 플랫폼(Cordova) 앱을 {{ site.data.keys.product }} v8.0에서 지원되는 Cordova 앱으로 마이그레이션할 수 있습니다.

#### 다음 섹션으로 이동
{: #jump-to-section }
* [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)
* [{{ site.data.keys.product_adj }} 하이브리드 앱의 마이그레이션 완료](#completing-migration-of-a-mobilefirst-hybrid-app)
* [{{ site.data.keys.product_adj }} Cordova 앱의 마이그레이션 완료](#completing-migration-of-a-mobilefirst-cordova-app)

### 마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작
{: #starting-the-cordova-app-migration-with-the-migration-assistance-tool }
마이그레이션 지원 도구는 더 이상 유효하지 않은 API를 식별하고 v8.0에서 지원되는 Cordova 앱으로 프로젝트를 복사하여 이전 버전의 {{ site.data.keys.product_adj }}에서 작성된 크로스 플랫폼 앱의 준비를 도와줍니다.

마이그레이션 지원 도구를 사용하기 전에 다음 정보를 파악하는 것이 중요합니다.

* 기존 IBM MobileFirst Platform Foundation 하이브리드 애플리케이션 또는 `mfp cordova create` 명령으로 작성한 Cordova 애플리케이션이 있어야 합니다.
* 인터넷에 액세스할 수 있어야 합니다.
* node.js 버전 4.0.0 이상이 설치되어 있어야 합니다.
* Cordova 명령행 인터페이스(CLI)와 대상 플랫폼에 대해 Cordova CLI를 사용하는 데 필요한 필수 소프트웨어가 설치되어 있어야 합니다. 자세한 정보는 Apache Cordova 웹 사이트에서 [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)를 참조하십시오.
* 마이그레이션 프로세스의 제한사항을 검토하고 숙지하십시오. 자세한 정보는 [이전 릴리스에서 앱 마이그레이션](../)을 참조하십시오.

이전 버전의 IBM MobileFirst Platform Foundation 명령으로 작성한 크로스 플랫폼 앱 또는 IBM MobileFirst Platform Foundation 명령으로 작성한 Cordova는 몇 가지를 변경하지 않으면 버전 8.0에서 지원되지 않습니다. 마이그레이션 지원 도구를 사용하면 다음 기능을 간단하게 처리할 수 있습니다.

* 기존 하이브리드 앱 또는 IBM MobileFirst Platform Foundation 앱이 있는 Cordova에서 JavaScript 및 HTML 파일을 스캔하고, 버전 8.0에서 더 이상 사용되지 않거나 더 이상 지원되지 않거나 수정된 API를 식별합니다.
* 내부 하이브리드 앱 또는 IBM MobileFirst Platform Foundation 앱이 있는 Cordova의 구조, 스크립트 및 구성 파일을 버전 8.0에서 지원되는 Cordova 구조에 복사합니다.

마이그레이션 지원 도구는 앱의 주석 또는 개발자 코드를 수정하거나 이동하지 않습니다. 이 도구를 실행한 후 [MobileFirst 하이브리드 앱 마이그레이션 완료](#completing-migration-of-a-mobilefirst-hybrid-app) 또는 [MobileFirst Cordova 앱의 마이그레이션 완료](#completing-migration-of-a-mobilefirst-cordova-app)로 마이그레이션 프로세스를 계속해야 합니다.

<!--1. Download the migration assistance tool by using one of the following methods:
    * Download the .tgz file from the [Git repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli).
    * Download the {{ site.data.keys.mf_dev_kit }}, which contains the migration assistance tool as a file named mfpmigrate-cli.tgz, from the MobileFirst Operations Console.
    * Download the tool by using the instructions that are provided. -->
1. 마이그레이션 지원 도구를 설치하십시오.
    * .tgz 파일을 다운로드한 디렉토리로 이동하십시오.
    * 다음 명령을 입력하여 NPM을 사용하여 도구를 설치하십시오.

   ```bash
   npm install -g tgz_filename
   ```
      **mfpmigrate-cli** npm 패키지에 대한 세부사항은 [여기](https://www.npmjs.com/package/mfpmigrate-cli)를 클릭하십시오.
2. 다음 명령을 입력하여 IBM MobileFirst Platform Foundation 앱을 스캔하고 복사하십시오.

   ```bash
   mfpmigrate client --in source_directory --out destination_directory --projectName new-project-directory
   ```

   * **source_directory**  
   마이그레이션 중인 프로젝트의 현재 위치입니다. 하이브리드 애플리케이션에서 이 위치는 애플리케이션의 **application** 폴더를 가리켜야 합니다.
   * **destination_directory**    
   새 버전 8.0 호환 가능 Cordova 구조가 출력되는 디렉토리의 선택적 이름입니다. 이 디렉토리는 **new-project-directory** 폴더의 상위입니다. 이 옵션이 지정되지 않으면 이 폴더는 명령이 실행되는 디렉토리에 작성됩니다.
   * **new-project-directory**
   프로젝트의 새 컨텐츠가 있는 폴더의 선택적 이름입니다.
   이 폴더는 *destination_directory* 폴더 내에 있으며 Cordova 앱에 대한 모든 정보를 포함합니다. 이 옵션이 지정되지 않으면 기본 이름은 `app_name-app_id-version`입니다.
   <br/>
      클라이언트 명령과 함께 사용되는 경우 마이그레이션 지원 도구는 다음 조치를 완료합니다.  
        * 버전 8.0에서 제거되었거나 더 이상 사용되지 않거나 변경된 API를 기존 IBM MobileFirst Platform Foundation 앱에서 식별합니다.
        * 초기 앱의 구조를 기반으로 Cordova 구조를 작성합니다.
        * 적용 가능한 경우 다음 항목을 복사하거나 추가합니다.
            * Android 운영 체제
            * iPhone 및 iPad 운영 체제
            * Windows 운영 체제
            * Cordova-mfp-plugin
            * 이전 프로젝트에 JSONStore 기능이 설치된 경우 Cordova-plugin-mfp-jsonstore 플러그인
            * 이전 프로젝트에 FIPS 기능이 설치된 경우 Cordova-plugin-mfp-fips 플러그인
            * 이전 프로젝트에 푸시 알림 기능이 설치된 경우 Cordova-plugin-mfp-push 플러그인
            * 이전 프로젝트에서 인증서 고정이 사용된 경우 하이브리드 인증서
            * 애플리케이션, 스크립트 및 XML 파일
		* 명령을 완료한 후 기본 브라우저에서 결과 정보 파일을 엽니다.

        > **중요:** 마이그레이션 지원 도구는 개발자 코드 또는 주석 텍스트를 새 구조로 복사하지 않습니다.
3. 새 Cordova 앱에서 API 문제를 해결하십시오.
    * 명령이 완료될 때 **destination_directory** 디렉토리에 작성되고 기본 브라우저에 열린 **api-report.html** 파일을 검토하십시오. 이 파일에서 테이블의 각 행은 앱에서 사용되지만 버전 8.0과 호환 불가능한 더 이상 사용되지 않거나 변경되거나 제거된 API를 식별합니다. 이 파일에는 사용 가능한 경우 제거된 API의 대체 API도 지정됩니다.

    |파일 경로 |행 번호 |API |행 컨텐츠 |API 변경 카테고리 |설명 및 조치 항목 |
    |-----------|-------------|-----|--------------|------------|-----------|
    |c:\local\Cordova\www\js\index.js |	15 |`WL.Client.getAppProperty` | {::nomarkdown}<ul><li><code>document.getElementById('app_version')</code></li><li><code>textContent = WL.Client.getAppProperty("APP_VERSION");</code></li></ul>{:/} |지원되지 않음 |8.0에서 제거되었습니다. Cordova 플러그인을 사용하여 앱 버전을 가져오십시오. 대체 API가 없습니다. |

    * **api-report.html** 파일에서 식별된 API 문제를 해결하십시오.
4. 초기 앱 구조에서 새 Cordova 구조의 올바른 위치로 개발자 코드를 수동으로 복사하십시오. 소스 IBM MobileFirst Platform Foundation 앱의 유형에 따라 다음 디렉토리의 컨텐츠를 복사하십시오.
    * **IBM MobileFirst Platform Foundation 하이브리드 앱**  
    소스 앱의 **common** 디렉토리에 있는 컨텐츠를 새 Cordova 앱의 **www** 디렉토리에 복사하십시오.
    * **IBM MobileFirst Platform Foundation 앱이 있는 Cordova**
    소스 앱의 **www** 디렉토리에 있는 컨텐츠를 새 Cordova 앱의 **www** 디렉토리에 복사하십시오.
5. 새 앱에서 scan 명령으로 마이그레이션 지원 도구를 실행하여 API 변경이 완료되었는지 확인하십시오.
    * 다음 명령을 입력하여 스캔을 실행하십시오.

      ```bash
      mfpmigrate scan --in source_directory --out destination_directory --type hybrid
      ```
        * **source_directory**  
        스캔할 파일의 현재 위치입니다. IBM MobileFirst Platform Foundation 하이브리드 앱에서 이 위치는 앱의 **common** 디렉토리입니다. {{ site.data.keys.product }} 버전 8.0 Cordova 크로스 플랫폼 앱에서 이 위치는 **www** 디렉토리입니다.
        * **destination_directory**  
        스캔 결과가 출력되는 디렉토리입니다.
		* **scan_type**  
        스캔할 프로젝트 유형입니다.
    * **api-report.html** 파일에서 식별된 나머지 API 문제를 해결하십시오.
6. 6단계를 반복하여 모든 문제가 해결될 때까지 새 Cordova 앱에 대해 스캔 도구를 실행하십시오.

### {{ site.data.keys.product_adj }} 하이브리드 앱의 마이그레이션 완료
{: #completing-migration-of-a-mobilefirst-hybrid-app }
마이그레이션 지원 도구를 사용한 후 코드의 일부를 수동으로 수정하여 마이그레이션 프로세스를 완료해야 합니다.

* 기존 하이브리드 앱에 대해 이미 mfpmigrate 마이그레이션 지원 도구를 실행했을 것입니다. 자세한 정보는 [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)을 참조하십시오.
* 추가 Cordova 플러그인을 설치해야 하는 경우, Cordova CLI(Command-Line Interface) 및 대상 플랫폼에 대해 Cordova CLI를 사용하는 데 필요한 필수 소프트웨어가 설치되어 있어야 합니다. (6단계 참조) 자세한 정보는 Apache Cordova 웹 사이트에서 [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)를 참조하십시오.
* 새 버전의 JQuery를 다운로드(1c단계)해야 하거나 추가 Cordova 플러그인을 설치(6단계)해야 하는 경우, 인터넷 액세스 권한이 있어야 합니다.
* 추가 Cordova 플러그인을 설치(6단계)해야 하는 경우, node.js 버전 4.0.0 이상이 설치되어 있어야 합니다.

이 태스크의 단계를 완료하여 IBM MobileFirst Platform Foundation 7.1에서 {{ site.data.keys.product }} 8.0에 대한 지원을 포함하는 Cordova 애플리케이션으로의 MobileFirst 하이브리드 애플리케이션 마이그레이션을 완료하십시오.

마이그레이션을 완료한 후 앱은 IBM MobileFirst Platform Foundation과 별도로 얻은 Cordova 플랫폼 및 플러그인을 사용할 수 있으며, 선호하는 Cordova 개발 도구를 사용하여 앱을 계속 개발할 수 있습니다.

1. **www/index.html** 파일을 업데이트하십시오.
    * 다음 CSS 코드를 index.html 파일의 헤드 부분에서 이미 존재하는 CSS 코드 앞에 추가하십시오.

      ```html
      <link rel="stylesheet" href="worklight/worklight.css">
      <link rel="stylesheet" href="css/main.css">
      ```

      > **참고:** **worklight.css** 파일은 body 속성을 relative로 설정합니다. 이 항목이 앱의 스타일에 영향을 미치는 경우 사용자의 CSS 코드에서 해당 위치에 대해 다른 값을 선언하십시오. 예:

      ```css
      body {
            position: absolute;
      }
      ```

    * 파일 헤드에서 CSS 정의 다음에 Cordova JavaScript를 추가하십시오.

      ```html
      <script type="text/javascript" src="cordova.js"></script>
      ```    

    * 다음 코드 행이 있는 경우 제거하십시오.

      ```html
      <script>window.$ = window.jQuery = WLJQ;</script>
      ```

      사용자 고유 버전의 JQuery를 다운로드하여 다음 코드 행에 표시된 것처럼 로드할 수 있습니다.

      ```html
      <script src="lib/jquery.min.js"></script>
      ```

      선택적 jQuery 추가 내용을 **lib** 폴더로 이동할 필요는 없습니다. 원하는 위치로 이 추가 내용을 이동할 수 있지만 **index.html** 파일에서 올바르게 참조해야 합니다.

2. `WL.Client.init`를 자동으로 호출하도록 **www/js/InitOptions.js** 파일을 업데이트하십시오.
    * **InitOptions.js**에서 다음 코드를 제거하십시오.

      `WL.Client.init` 함수는 글로벌 변수 **wlInitOptions**를 사용하여 자동으로 호출됩니다.

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

3. 선택사항: `WL.Client.init`를 수동으로 호출하도록 **www/InitOptions.js**를 업데이트하십시오.
    * **config.xml** 파일을 편집하고 `<mfp:clientCustomInit>` 요소의 enabled 속성을 true로 설정하십시오.
    * MobileFirst 하이브리드 기본 템플리트를 사용 중인 경우 다음 코드를 찾으십시오.

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

      그런 다음, 다음 코드로 대체하십시오.

      ```javascript
      if (document.addEventListener) {
            document.addEventListener('mfpready', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            document.attachEvent('mfpready',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

4. 선택사항: 하이브리드 환경(예: **app/iphone/js/main.js**)에 특정한 로직이 있는 경우, `wlEnvInit()` 함수를 복사하여 **www/main.js**의 마지막에 추가하십시오.

   ```javascript
   // This wlEnvInit method is invoked automatically by MobileFirst runtime after successful initialization.
   function wlEnvInit() {
        wlCommonInit();
        if (cordova.platformId === "ios") {
            // Environment initialization code goes here for ios
        } else if (cordova.platformId === "android") {
            // Environment initialization code goes here for android
        }
   }
   ```

5. 선택사항: 원래 애플리케이션이 FIPS 기능을 사용하는 경우, JQuery 이벤트 리스너를 WL/FIPS/READY 이벤트를 청취하는 JavaScript 이벤트 리스너로 변경하십시오. FIPS에 대한 자세한 정보는 [FIPS 140-2 지원](../../../administering-apps/federal/#fips-140-2-support)을 참조하십시오.
6. 선택사항: 원래 애플리케이션이 마이그레이션 지원 도구로 대체되지 않거나 제공되지 않는 서드파티 Cordova 플러그인을 사용하는 경우, `cordova plugin add` 명령을 사용하여 해당 플러그인을 Cordova 앱에 수동으로 추가하십시오. 도구에 의해 대체되는 플러그인에 대한 정보는 [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)을 참조하십시오.

### {{ site.data.keys.product_adj }} Cordova 앱의 마이그레이션 완료
{: #completing-migration-of-a-mobilefirst-cordova-app }
마이그레이션 지원 도구를 사용한 후 코드의 일부를 수동으로 수정하여 마이그레이션 프로세스를 완료해야 합니다.

* 기존 Cordova 앱에 대해 이미 **mfpmigrate** 마이그레이션 지원 도구를 실행했을 것입니다. 자세한 정보는 [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)을 참조하십시오.
* Cordova 명령행 인터페이스(CLI)와 대상 플랫폼에 대해 Cordova CLI를 사용하는 데 필요한 필수 소프트웨어가 설치되어 있어야 합니다. 자세한 정보는 Apache Cordova 웹 사이트에서 [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)를 참조하십시오.
* 인터넷에 액세스할 수 있어야 합니다.
* node.js 버전 4.0.0 이상이 설치되어 있어야 합니다.

**mfp cordova create**로 작성한 Cordova 앱은 IBM MobileFirst Platform Foundation 이전 버전과 함께 제공된 Cordova 플랫폼 및 플러그인 버전을 사용합니다. 마이그레이션을 완료하면 마이그레이션된 앱에서 {{ site.data.keys.product }}과 별도로 얻은 Cordova 플랫폼 및 플러그인을 사용할 수 있습니다. 이는 Cordova 애플리케이션에 대해 IBM MobileFirs Foundation v8.0과 함께 사용 가능한 유일한 지원 유형입니다.

마이그레이션하려면 마이그레이션 지원 도구를 실행한 후 앱의 기타 사항을 수정하십시오.

1. 선택한 Cordova 개발 도구를 사용하여 원래 애플리케이션에 있었던 {{ site.data.keys.product_adj }} 기능을 사용하는 Cordova 플러그인 외의 Cordova 플러그인을 추가하십시오. 예를 들어 Cordova CLI를 사용하여 **cordova-plugin-file** 및 **cordova-plugin-file-transfer** 플러그인을 추가하려면 다음을 입력하십시오.

   ```bash
   cordova plugin add cordova-plugin-file cordova-plugin-file-transfer
   ```

   > **참고:** **mfpmigrate** 마이그레이션 지원 도구가 {{ site.data.keys.product_adj }} 기능을 위한 Cordova 플러그인을 추가했으므로 이를 추가할 필요가 없습니다. 이러한 플러그인에 대한 자세한 정보는 [{{ site.data.keys.product_adj }}용 Cordova 플러그인](../../../application-development/sdk/cordova)을 참조하십시오.

2. 선택사항: 원래 애플리케이션이 FIPS 기능을 사용하는 경우, JQuery 이벤트 리스너를 WL/FIPS/READY 이벤트를 청취하는 JavaScript 이벤트 리스너로 변경하십시오. FIPS에 대한 자세한 정보는 [FIPS 140-2 지원](../../../administering-apps/federal/#fips-140-2-support)을 참조하십시오.
3. 선택사항: 원래 애플리케이션이 마이그레이션 지원 도구로 대체되지 않거나 제공되지 않는 서드파티 Cordova 플러그인을 사용하는 경우, **cordova plugin add** 명령을 사용하여 해당 플러그인을 Cordova 앱에 수동으로 추가하십시오. 도구에 의해 대체되는 플러그인에 대한 정보는 [마이그레이션 지원 도구로 Cordova 앱 마이그레이션 시작](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)을 참조하십시오.
4. 선택사항: (iOS 플랫폼을 포함하는 앱과 OpenSSL을 사용하는 앱만 해당) **cordova-plugin-mfp-encrypt-utils** 플러그인을 앱에 추가하십시오. **cordova-plugin-mfp-encrypt-utils** 플러그인은 Cordova 애플리케이션의 암호화를 위해 iOS 플랫폼과 함께 iOS OpenSSL 프레임워크를 제공합니다.

이제 선호하는 Cordova 도구를 사용하여 Cordova 앱을 계속 개발할 수 있지만 {{ site.data.keys.product_adj }} 기능도 포함됩니다.

## iOS Cordova의 암호화 마이그레이션
{: #migrating-encryption-for-ios-cordova }
iOS 하이브리드 또는 Cordova 애플리케이션이 OpenSSL 암호화를 사용한 경우, 앱을 새 V8.0.0 고유 암호화로 마이그레이션할 수 있습니다. OpenSSL을 계속 사용하려면 추가적인 Cordova 플러그인을 추가해야 합니다.

마이그레이션을 위한 iOS Cordova 암호화 옵션에 대한 자세한 정보는 [Cordova 애플리케이션에서 OpenSSL 사용](../../../application-development/sdk/cordova/additional-information/#enabling-openssl-in-cordova-applications) 주제의 [마이그레이션 옵션](../../../application-development/sdk/cordova/additional-information/#migration-options) 절을 참조하십시오.

## 직접 업데이트 마이그레이션
{: #migrating-direct-update }
직접 업데이트는 보호된 리소스에 처음 액세스한 후 트리거됩니다. 새 웹 리소스를 배치하기 위한 프로세스는 v8.0에서 변경되었습니다.

이전 버전과 달리, v8.0에서는 애플리케이션이 보안 {{ site.data.keys.product_adj }} 리소스에 액세스하지 않는 경우 클라이언트 애플리케이션은 서버에서 업데이트가 사용 가능한 경우에도 업데이트를 수신하지 않습니다. 예를 들어, `@OAuth(security=false)` 어노테이션 또는 구성에 의해 OAuth가 사용 안함으로 설정되어서 리소스가 보호되지 않을 수 있습니다. 다음 방법 중 하나로 이 위험을 임시로 해결할 수 있습니다.

* 액세스 토큰을 명시적으로 얻으십시오. [`WLAuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc) 클래스에서 `obtainAccessToken` API를 참조하십시오.
* 보호된 다른 리소스를 호출하십시오. [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html?view=kc) 클래스를 참조하십시오.

직접 업데이트를 사용하려면 v8.0부터는 더 이상 **.wlapp** 파일을 {{ site.data.keys.mf_server }}로 업로드할 필요가 없습니다. 대신 작은 웹 리소스 아카이브(.zip 파일)를 업로드합니다. 이 아카이브 파일에는 이전 버전에서 광범위하게 사용되던 웹 미리보기 파일이나 스킨이 더 이상 포함되지 않습니다. 이는 더 이상 사용되지 않습니다. 아카이브에는 클라이언트로 전송되는 웹 리소스 및 직접 업데이트 유효성 검증을 위한 체크섬만 포함됩니다.

> 자세한 정보는 [직접 업데이트 문서](../../../application-development/direct-update)를 참조하십시오.

## WebView 업그레이드
{: #upgrading-the-webview }
IBM MobileFirs Foundation v8.0 Cordova SDK(JavaScript)는 코드 조정이 필요한 많은 변경사항을 소개했습니다.

수동 마이그레이션 프로세스에는 몇 가지 스테이지가 포함되어 있습니다.

* 새 Cordova 프로젝트 작성
* 필수 웹 리소스 요소를 이전 버전의 코드로 대체
* SDK 변경사항을 충족하도록 JavaScript 코드에 필수 변경사항 작성

많은 {{ site.data.keys.product_adj }} API 요소가 v8.0에서 제거되었습니다. 제거된 요소는 JavaScript의 자동 정정을 지원하는 IDE에서 존재하지 않는 항목으로 명확하게 표시됩니다.

다음 표는 제거해야 하는 API 요소와 해당 기능을 대체할 방법에 대한 제한을 나열합니다. 제거된 요소 중 많은 항목이 Cordova 플러그인 또는 HTML 5 요소로 대체할 수 있는 UI 요소입니다. 일부 메소드가 변경되었습니다.

#### 중단된 JavaScript UI 요소
{: #discontinued-javascript-ui-elements }

|API 요소 |마이그레이션 경로 |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>WL.BusyIndicator</code></li><li><code>WL.OptionsMenu</code></li><li><code>WL.TabBar</code></li><li><code>WL.TabBarItem</code></li></ul>{:/} |Cordova 플러그인 또는 HTML 5 요소를 사용하십시오. |
|`WL.App.close()` |{{ site.data.keys.product_adj }} 외부에서 이 이벤트를 처리하십시오. |
|`WL.App.copyToClipboard()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. |
|`WL.App.openUrl(url, target, options)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/>참고: Cordova InAppBrowser 플러그인이 이 기능을 제공합니다. |
| {::nomarkdown}<ul><li><code>WL.App.overrideBackButton(callback)</code></li><li><code>WL.App.resetBackButton()</code></li></ul> |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/>참고: Cordova backbutton 플러그인이 이 기능을 제공합니다. |
|`WL.App.getDeviceLanguage()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/>참고: Cordova **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.App.getDeviceLocale()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/> 참고: Cordova **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.App.BackgroundHandler` |사용자 정의 핸들러 함수를 실행하려면 표준 Cordova 일시정지 이벤트 리스너를 사용하십시오. 개인정보 보호를 제공하는 Cordova 플러그인을 사용하여 iOS 및 Android 시스템과 사용자의 스냅샷 또는 화면 캡처를 방지하십시오. 자세한 정보는 [https://github.com/devgeeks/PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)에서 PrivacyScreenPlugin의 설명을 참조하십시오. |
| {::nomarkdown}<ul><li><code>WL.Client.close()</code></li><li><code>WL.Client.restore()</code></li><li><code>WL.Client.minimize()</code></li></ul>{:/}|이 함수는 {{ site.data.keys.product }} v8.0에서는 지원되지 않는 Adobe AIR 플랫폼을 지원하기 위해 제공되었습니다. |
|`WL.Toast.show(string)` |Toast에 대한 Cordova 플러그인을 사용하십시오. |

#### 기타 중단된 JavaScript 요소
{: #other-discontinued-javascript-elements }

|API |마이그레이션 경로 |
|-----|----------------|
|`WL.Client.checkForDirectUpdate(options)` |대체 없음.<br/><br/>참고: 사용 가능한 경우 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)을 호출하여 직접 업데이트를 트리거할 수 있습니다. 서버에서 직접 업데이트를 사용할 수 있는 경우 보안 토큰에 액세스하면 직접 업데이트가 트리거됩니다. 그러나 요청 시 직접 업데이트를 트리거할 수 없습니다. |
| {::nomarkdown}<ul><li><code>WL.Client.setSharedToken({key: myName, value: myValue})</code></li><li><code>WL.Client.getSharedToken({key: myName})</code></li><li><code>WL.Client.clearSharedToken({key: myName})</code></li></ul>{:/} |대체 없음. |
| {::nomarkdown}<ul><li><code>WL.Client.isConnected()</code></li><li><code>connectOnStartup</code> init option</li></ul> |[`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)을 사용하여 서버에 대한 연결을 확인하고 애플리케이션 관리 규칙을 적용하십시오. |
| {::nomarkdown}<ul><li><code>WL.Client.setUserPref(key,value, options)</code></li><li><code>WL.Client.setUserPrefs(userPrefsHash, options)</code></li><li><code>WL.Client.deleteUserPrefs(key, options)</code></li></ul>{:/} |대체 없음. 어댑터와 [MFP.Server.getAuthenticatedUser](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser) API를 사용하여 사용자 환경 설정을 관리할 수 있습니다. |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} |대체 없음. |
|`WL.Client.logActivity(activityType)` |[`WL.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Logger.html?view=kc)를 사용하십시오. |
|`WL.Client.login(realm, options)` |[`WLAuthorizationManager.login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#login)을 사용하십시오. |
|`WL.Client.logout(realm, options)` |[`WLAuthorizationManager.logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#logout)을 사용하십시오. |
|`WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` |[`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)을 사용하십시오. |
| {::nomarkdown}<ul><li><code>WL.Client.transmitEvent(event, immediate)</code></li><li><code>WL.Client.purgeEventTransmissionBuffer()</code></li><li><code>WL.Client.setEventTransmissionPolicy(policy)</code></li></ul>{:/} |이러한 이벤트의 알림을 수신할 사용자 정의 어댑터를 작성하십시오. |
| {::nomarkdown}<ul><li><code>WL.Device.getContext()</code></li><li><code>WL.Device.startAcquisition(policy, triggers, onFailure)</code></li><li><code>WL.Device.stopAcquisition()</code></li><li><code>WL.Device.Wifi</code></li><li><code>WL.Device.Geo.Profiles</code></li><li><code>WL.Geo</code></li></ul>{:/} |위치정보에 대한 네이티브 API 또는 서드파티 Cordova 플러그인을 사용하십시오. |
|`WL.Client.makeRequest (url, options)` |동일한 기능을 제공하는 사용자 정의 어댑터를 작성하십시오. |
|`WL.Device.getID(options)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/>참고: **cordova-plugin-device** 플러그인의 **device.uuid**가 이 기능을 제공합니다. |
|`WL.Device.getFriendlyName()` |`WL.Client.getDeviceDisplayName`을 사용하십시오. |
|`WL.Device.setFriendlyName()` |`WL.Client.setDeviceDisplayName`을 사용하십시오. |
|`WL.Device.getNetworkInfo(callback)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오.<br/><br/>참고: **cordova-plugin-network-information** 플러그인이 이 기능을 제공합니다. |
|`WLUtils.wlCheckReachability()` |사용자 정의 어댑터를 작성하여 서버 가용성을 확인하십시오. |
|`WL.EncryptedCache` |JSONStore를 사용하여 암호화된 데이터를 로컬로 저장하십시오. JSONStore는 **cordova-plugin-mfp-jsonstore**에 있습니다. |
|`WL.SecurityUtils.remoteRandomString(bytes)` |동일한 기능을 제공하는 사용자 정의 어댑터를 작성하십시오. |
|`WL.Client.getAppProperty(property)` |cordova plugin add **cordova-plugin-appversion** 플러그인을 사용하여 앱 버전 특성을 검색할 수 있습니다. 리턴되는 버전은 네이티브 앱 버전입니다(Android 및 iOS만 해당). |
|`WL.Client.Push.*` |**cordova-plugin-mfp-push** 플러그인에서 [JavaScript client-side push API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_js_client_push_api.html?view=kc#r_client_push_api)를 사용하십시오. 자세한 정보는 [이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션](../../migrating-push-notifications)을 참조하십시오. |
|`WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` |[`MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-mfp-push-hybrid/html/MFPPush.html?view=kc#registerDevice)를 사용하여 푸시 및 SMS를 위해 디바이스를 등록하십시오. |
|`WLAuthorizationManager.obtainAuthorizationHeader(scope)` |[`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)을 사용하여 필요한 범위에 대한 토큰을 얻으십시오. |
|`WLClient.getLastAccessToken(scope)` |[`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)을 사용하십시오. |
| {::nomarkdown}<ul><li><code>WLClient.getLoginName()</code></li><li><code>WL.Client.getUserName(realm)</code></li></ul>{:/} |대체 없음. |
|`WL.Client.getRequiredAccessTokenScope(status, header)` |[`WLAuthorizationManager.isAuthorizationRequired`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#isAuthorizationRequired) 및 [`WLAuthorizationManager.getResourceScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#getResourceScope)를 사용하십시오. |
|`WL.Client.isUserAuthenticated(realm)` |대체 없음. |
|`WLUserAuth.deleteCertificate(provisioningEntity)` |대체 없음. |
|`WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` |대체 없음. |
|`WL.Client.createChallengeHandler(realmName)` |사용자 정의 게이트웨이 인증 확인을 처리하기 위한 인증 확인 핸들러를 작성하려면 [`WL.Client.createGatewayChallengeHandler(gatewayName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler)를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인을 처리하기 위한 인증 확인 핸들러를 작성하려면 [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)를 사용하십시오. |
|`WL.Client.createWLChallengeHandler(realmName)` |[`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)를 사용하십시오. |
|`challengeHandler.isCustomResponse()` 여기서 `challengeHandler`는 `WL.Client.createChallengeHandler()`에서 리턴한 인증 확인 핸들러 오브젝트입니다. |`gatewayChallengeHandler.canHandleResponse()`를 사용하십시오. 여기서 `gatewayChallengeHandler`는 [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler)에서 리턴한 인증 확인 핸들러 오브젝트입니다. |
|`wlChallengeHandler.processSucccess()` 여기서 `wlChallengeHandler`는 `WL.Client.createWLChallengeHandler()`에서 리턴한 인증 확인 핸들러 오브젝트입니다. |`securityCheckChallengeHandler.handleSuccess()`를 사용하십시오. 여기서 `securityCheckChallengeHandler`는 [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)에서 리턴한 인증 확인 핸들러 오브젝트입니다. |
|`WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler)에서 리턴한 인증 확인 핸들러 오브젝트를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)에서 리턴한 인증 확인 핸들러 오브젝트를 사용하십시오. |
|`WL.Client.AbstractChallengeHandler.submitFailure(err)` |[`WL.Client.AbstractChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.AbstractChallengeHandler.html?view=kc#cancel)을 사용하십시오. |
|`WL.Client.createProvisioningChallengeHandler()` |대체 없음. 디바이스 프로비저닝은 이제 보안 프레임워크에서 자동으로 처리됩니다. |

#### 더 이상 사용되지 않는 JavaScript API
{: #deprecated-javascript-apis }

|API |마이그레이션 경로 |
|-----|----------------|
| {::nomarkdown}<ul><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)</code></li><li><code>WL.Client.invokeProcedure(invocationData, options)</code></li><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)</code></li><li><code>WLProcedureInvocationResult</code></li></ul>{:/} |대신 `WLResourceRequest`를 사용하십시오. 참고: invokeProcedure의 구현은 WLResourceRequest를 사용합니다. |
|`WLClient.getEnvironment` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. 참고: device.platform 플러그인이 이 기능을 제공합니다. |
|`WL.Client.getLanguage` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. 참고: **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.Client.connect(options)` |`WLAuthorizationManager.obtainAccessToken`을 사용하여 서버에 대한 연결을 확인하고 애플리케이션 관리 규칙을 적용하십시오. |

## 제거된 컴포넌트
{: #removed-components }
MobileFirst Platform Foundation Studio 7.1로 작성한 Cordova 프로젝트에는 적절성 기능을 지원하는 많은 리소스가 포함되었습니다. 그러나 v8.0에서는 순수한 Cordova만 지원되며 {{ site.data.keys.product_adj }} API는 더 이상 이러한 기능을 지원하지 않습니다.

### 스킨
{: #skins }
MobileFirst 애플리케이션 스킨은 여러 디바이스 및 형식에 맞게 조정하기 위해 UI를 최적화하는 방법을 제공했지만 v8.0에서는 더 이상 지원되지 않습니다.  
Cordova 및 HTML 5에서 제공하는 응답 웹 디자인 메소드를 채택하여 이 유형의 기능을 대체할 것을 권장합니다.

### 쉘
{: #shells }
**쉘**을 통해 여러 애플리케이션에서 사용되고 공유되는 기능 세트를 개발할 수 있었습니다. 이러한 방식으로 네이티브 환경 관련 경험이 보다 풍부한 개발자가 코어 기능 세트를 제공할 수 있었습니다. 이러한 쉘은 **내부 애플리케이션**에 번들되고 비즈니스 로직 또는 UI 개발에 관련된 개발자에 의해 사용되었습니다.

이전 하이브리드 앱에서 쉘 및 내부 애플리케이션을 사용한 경우 Cordova 디자인 패턴을 채택하고 쉘 컴포넌트를 애플리케이션 간에 공유될 수 있는 Cordova 플러그인으로 구현할 것을 권장합니다. 개발자는 쉘 코드의 파트를 재사용하고 Cordova 플러그인으로 마이그레이션하는 방법을 찾을 수 있습니다.

예를 들어, 고객의 모든 앱에 공통된 웹 리소스 세트(JavaScript, css files, graphics, html)가 있는 경우 이러한 리소스를 앱의 www 폴더에 복사하는 Cordova 플러그인을 작성할 수 있습니다.

다음은 이러한 리소스가 src/www/acme/ 폴더에 있는 경우입니다.

* src/www/acme/js/acme.js
* src/www/acme/css/acme.css
* src/www/acme/img/acme-logo.png
* src/www/acme/html/banner.html
* src/www/acme/html/footer.html
* plugin.xml

**plugin.xml** 파일에는 `<asset>` 태그가 포함되며, 리소스 복사를 위한 소스와 대상이 포함됩니다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plugin
     xmlns="http://apache.org/cordova/ns/plugins/1.0"     
     xmlns:rim="http://www.blackberry.com/ns/widgets"
     xmlns:android="http://schemas.android.com/apk/res/android"
     id="cordova-plugin-acme"
     version="1.0.1">
<name>ACME Company Shell Component</name>
<description>ACME Company Shell Component</description>
<license>MIT</license>
<keywords>cordova,acme,shell,components</keywords>
<issue>https://www.acme.com/support</issue>
<asset src="src/www/acme" target="www/acme"/>
</plugin>
```

**plugin.xml**을 Cordova **config.xml** 파일에 추가하면 asset src에 나열된 리소스가 컴파일 중에 asset target에 복사됩니다.  
그런 다음 해당 **index.html** 파일 또는 해당 앱 내의 모든 위치에서 이러한 리소스를 재사용할 수 있습니다.

```html
<link rel="stylesheet" type="text/css" href="acme/css/acme.css">
<script type="text/javascript" src="acme/js/acme.js"></script>
<div id="banner"></div>
<div id="app"></div>
<div id="footer"></div>
<script type="text/javascript">
    $("#banner").load("acme/html/banner.html");
    $("#footer").load("acme/html/footer.html");
</script>
```

### 설정 페이지
{: #settings-page }
**설정 페이지**는 개발자가 테스트 용도로 런타임에 서버 URL을 변경할 수 있는 MobileFirst 하이브리드 앱에서 사용 가능한 UI입니다. 이제 개발자는 기존 {{ site.data.keys.product_adj }} 클라이언트 API를 사용하여 런타임 시 서버 URL을 변경할 수 있습니다. 자세한 정보는 [WL.App.setServerUrl](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html?cp=SSHS8R_8.0.0#setServerUrl)을 참조하십시오.

### 축소
{: #minification }
MobileFirst Studio 7.1은 컴파일 전에 불필요한 문자를 모두 제거하여 JavaScript 코드의 크기를 줄이는 OOTB 메소드를 제공했습니다. 프로젝트에 Cordova 후크를 추가하여 이 제거된 기능을 대체할 수 있습니다.

여러 후크를 사용하여 JavaScript 및 CSS 파일을 축소할 수 있습니다. 앱의 **config.xml** 파일에서 `before_prepare` 이벤트에 후크를 배치할 수 있습니다.

다음은 일부 권장되는 후크입니다.

* [https://www.npmjs.com/package/uglify-js](https://www.npmjs.com/package/uglify-js)
* [https://www.npmjs.com/package/clean-css](https://www.npmjs.com/package/clean-css)

이러한 후크는 `<hook>` 요소를 사용하여 플러그인 파일 또는 앱의 **config.xml** 파일에서 정의할 수 있습니다.  
다음 예제에서는 Cordova가 각 플랫폼의 **www/** 폴더에 파일을 복사하기 전에 `before_prepare` 후크 이벤트를 사용하여 코드를 축소하는 스크립트를 실행합니다.

```html
<hook type="before_prepare" src="scripts/uglify.js" />
```
