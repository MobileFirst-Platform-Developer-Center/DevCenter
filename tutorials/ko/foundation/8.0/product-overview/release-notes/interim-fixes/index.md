---
layout: tutorial
title: 임시 수정사항의 새로운 기능
breadcrumb_title: 임시 수정사항
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
임시 수정사항은 문제점 정정을 위한 패치 및 업데이트를 제공하고 모바일 운영 체제의 새 릴리스에 대해 현재 {{site.data.keys.product_full }}을 유지합니다.

임시 수정사항은 누적됩니다. 최신 v8.0 임시 수정사항을 다운로드할 경우, 이전 임시 수정사항에서 모든 수정사항을 얻습니다. 

다음 섹션에 설명된 모든 수정사항을 획득하기 위해 최근 임시 수정사항을 다운로드하고 설치하십시오. 이전 수정사항을 설치할 경우, 여기 설명된 일부 수정사항을 가져오지 않습니다.

> {{site.data.keys.product }} 8.0의 iFix 릴리스 목록의 경우, [이러한 블로그 게시물을 참조]({{site.baseurl}}/blog/tag/iFix_8.0/)하십시오.

APAR 번호가 나열되면 해당 APAR 번호에 대한 임시 수정사항 README 파일을 검색함으로써 사용자는 임시 수정사항이 해당 기능을 가졌는지 확인할 수 있습니다.

### 라이센싱
{: #licensing }
#### PVU 라이센싱
{: #pvu-licensing }
새 오퍼링인 {{site.data.keys.product }} Extension V8.0.0은 PVU(Processor Value Unit) 라이센싱을 통해 사용 가능합니다. {{site.data.keys.product }} Extension용 PVU 라이센싱에 대한 자세한 정보는 [{{site.data.keys.product_adj }} 라이센싱](../../licensing)을 참조하십시오.

### 웹 애플리케이션
{: #web-applications }
#### {{site.data.keys.mf_cli }}에서 웹 애플리케이션 등록(APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
이제 {{site.data.keys.mf_console }}에서 등록에 대한 대안으로 {{site.data.keys.mf_cli }}(mfpdev)를 사용하여 클라이언트 웹 애플리케이션을 {{site.data.keys.mf_server }}에 등록할 수 있습니다. 자세한 정보는 {{site.data.keys.mf_cli }}로부터 웹 애플리케이션 등록을 참조하십시오.

### Cordova 애플리케이션
{: #cordova-applications }
#### Studio 플러그인으로 Eclipse에서 Cordova 프로젝트에 대한 고유 IDE 열기
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Eclipse IDE에 설치된 Studio 플러그인을 통해 사용자는 기존 Cordova 프로젝트를 Android Studio에서 열거나 Xcode를 Eclipse 인터페이스로부터 열어 프로젝트를 빌드 및 실행할 수 있습니다. 

#### 마이그레이션 지원 도구를 사용할 때 옵션으로 추가된 *projectName* 디렉토리
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
마이그레이션 지원 도구를 사용하여 프로젝트를 마이그레이션할 때 Cordova 프로젝트 디렉토리의 이름을 지정할 수 있습니다. 이름을 제공하지 않을 경우, 기본 이름은 *app_name-app_id-version*입니다.

#### 마이그레이션 지원 도구에 대한 사용성 개선사항
{: #usability-improvements-to-the-migration-assistance-tool }
마이그레이션 지원 도구의 사용성을 개선하기 위해 다음 변경사항이 작성되었습니다. 

* 마이그레이션 지원 도구는 HTML 파일 및 JavaScript 파일을 스캔합니다. 
* 스캔 보고서는 스캔이 완료된 후에 자동으로 기본 브라우저에서 열립니다.
* *--out* 플래그는 선택사항입니다. 지정되지 않은 경우 작업 디렉토리가 사용됩니다.
* *--out* 플래그가 지정되고 디렉토리가 존재하지 않는 경우, 디렉토리가 작성됩니다.

### 어댑터 
{: #adapters }
#### Java 및 JavaScript 어댑터 구성에 대해 추가된 `mfpdev push` 및 `pull` 명령
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
{{site.data.keys.mf_cli }}를 사용하여 Java 및 JavaScript 어댑터 구성을 {{site.data.keys.mf_server }}에 푸시하고 {{site.data.keys.mf_server }}로부터 어댑터 구성을 풀링할 수 있습니다.
