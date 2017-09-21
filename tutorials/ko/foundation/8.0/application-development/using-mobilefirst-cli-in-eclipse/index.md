---
layout: tutorial
title: Eclipse에서 MobileFirst CLI 사용
relevantTo: [ios,android,windows,cordova]
breadcrumb_title: MobileFirst Eclipse 플러그인
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Cordova CLI를 사용하여 Cordova 애플리케이션을 작성하고 관리할 수 있습니다. 또한 Eclipse IDE에서 [THyM](https://www.eclipse.org/thym/) 플러그인을 사용하여 동일한 작업을 수행할 수 있습니다. 

THyM을 통해 Eclipse에서 Cordova 프로젝트를 가져오고 관리할 수 있습니다. 새 Cordova 프로젝트를 작성하고 기존 Cordova 프로젝트를 가져올 수 있습니다. 또한 이 플러그인을 통해 프로젝트에 Cordova 플러그인을 설치할 수도 있습니다. 

[공식 웹 사이트](https://www.eclipse.org/thym/)에서 THyM에 대해 자세히 알아보십시오. 

Eclipse용 {{ site.data.keys.mf_studio }} 플러그인은 Eclipse IDE에서 여러 {{ site.data.keys.product_adj }} 명령을 공개합니다.
특히 Open Server Console, Preview App, Register App, Encrypt App, Pull App, Push App, Update App 명령을 제공합니다. 

이 학습서에서는 THyM 및 MobileFirst Eclipse 플러그인 설치에 대해 안내합니다. 

**전제조건:**

* 로컬로 실행되는 {{ site.data.keys.mf_server }} 또는 원격으로 실행되는 {{ site.data.keys.mf_server }}가 있습니다. 
* 개발자 워크스테이션에 {{ site.data.keys.mf_cli }}가 설치되어 있습니다. 

#### 다음으로 이동:
{: #jump-to }
* [{{ site.data.keys.mf_studio }} 플러그인 설치](#installing-the-mobilefirst-studio-plug-in)
* [THyM 플러그인 설치](#installing-the-thym-plug-in)
* [Cordova 프로젝트 작성](#creating-a-cordova-project)
* [기존 Cordova 프로젝트 가져오기](#importing-an-existing-cordova-project)
* [Cordova 프로젝트에 {{ site.data.keys.product_adj }} SDK 추가](#adding-the-mobilefirst-sdk-to-cordova-project)
* [{{ site.data.keys.product_adj }} 명령](#mobilefirst-commands)
* [팁과 요령](#tips-and-tricks)


## {{ site.data.keys.mf_studio }} 플러그인 설치
{: #installing-the-mobilefirst-studio-plug-in}
1. Eclipse에서 **도움말 → Eclipse 마켓플레이스...**를 클릭하십시오. 
2. 찾기 필드에서 "{{ site.data.keys.product_adj }}"를 검색한 후 "이동"을 클릭하십시오. 
3. "설치"를 클릭하십시오. 

	![{{ site.data.keys.mf_studio }} 설치 이미지](mff_install.png)

4. 설치 프로세스를 완료하십시오. 
5. 설치를 적용하려면 Eclipse를 다시 시작하십시오. 


## THyM 플러그인 설치
{: #installing-the-thym-plug-in }
**참고:** THyM을 실행하려면 Eclipse Mars 이상을 실행 중이어야 합니다. 

1. Eclipse에서 **도움말 → Eclipse 마켓플레이스...**를 클릭하십시오. 
2. 찾기 필드에서 "thym"을 검색한 후 "이동"을 클릭하십시오. 
3. Eclipse Thym에 대해 "설치"를 클릭하십시오. 

	![THyM 설치 이미지](Thym_install.png)

4. 설치 프로세스를 완료하십시오. 
5. 설치를 적용하려면 Eclipse를 다시 시작하십시오. 

## Cordova 프로젝트 작성
{: #creating-a-cordova-project }
이 절에서는 THyM을 사용하여 새 Cordova 프로젝트를 작성하는 방법에 대해 설명합니다. 

1. Eclipse에서 **파일 → 새로 작성 → 기타...**를 클릭하십시오. 
2. "Cordova"를 검색하여 옵션 수를 줄이고 **모바일** 디렉토리에서 **하이브리드 모바일(Cordova) 애플리케이션 프로젝트**를 선택하고 **다음**을 클릭하십시오. 

	![새 Cordova 마법사 이미지](New_cordova_wizard.png)

3. 프로젝트의 이름을 지정하고 **다음**을 클릭하십시오. 

	![새 Cordova 이름 지정 이미지](New_cordova_naming.png)

4. 프로젝트에 사용하려는 플랫폼을 추가하고 **완료**를 클릭하십시오. 

**참고**: 작성 후에 추가 플랫폼이 필요한 경우 [플랫폼 추가](#adding-platforms)를 참조하십시오. 

## 기존 Cordova 프로젝트 가져오기
{: #importing-an-existing-cordova-project }
이 절에서는 Cordova CLI를 사용하여 이미 작성된 기존 Cordova 프로젝트를 가져오는 방법에 대해 설명합니다. 

1. Eclipse에서 **파일 → 가져오기...**를 클릭하십시오. 
2. **모바일** 디렉토리에서 **Cordova 프로젝트 가져오기**를 선택하고 **다음>**을 클릭하십시오. 
3. **찾아보기...**를 클릭하고 기존 Cordova 프로젝트의 루트 디렉토리를 선택하십시오. 
4. "프로젝트:" 섹션에서 프로젝트가 선택되었는지 확인하고 **완료**를 클릭하십시오.
	![Cordova 프로젝트 가져오기 이미지](Import_cordova.png)

플랫폼 없이 프로젝트를 가져오면 다음 오류가 표시됩니다. 이 오류를 해결하는 방법은 [플랫폼 추가](#adding-platforms) 절을 참조하십시오.
![플랫폼 없음 오류 이미지](no-platforms-error.png)

**참고**: 가져오기 후에 추가 플랫폼이 필요한 경우 [플랫폼 추가](#adding-platforms)를 참조하십시오. 

## Cordova 프로젝트에 {{ site.data.keys.product_adj }} SDK 추가
{: #adding-the-mobilefirst-sdk-to-cordova-project }
Eclipse에 [THyM](#installing-the-thym-plug-in) 및 [{{ site.data.keys.mf_cli }} 플러그인을 설치](#installing-the-mobilefirst-studio-plug-in)하고 [Cordova 프로젝트를 작성](#creating-a-cordova-project)하거나 [Cordova 프로젝트를 가져온](#importing-an-existing-cordova-project) 후에 아래 단계에 따라 Cordova 플러그인을 통해 {{ site.data.keys.product_adj }} SDK를 설치할 수 있습니다. 

1. 프로젝트 탐색기에서 **플러그인** 디렉토리를 마우스 오른쪽 단추로 클릭하고 **Cordova 플러그인 설치**를 선택하십시오. 
2. 표시되는 대화 상자의 레지스트리 탭에서 **mfp**를 검색하고 **cordova-plugin-mfp**를 선택한 다음 **완료**를 클릭하십시오. 

	![새 Cordova 플러그인 설치 이미지](New_installing_cordova_plugin.png)

## {{ site.data.keys.product_adj }} 명령
{: #mobilefirst-commands }
{{ site.data.keys.product }} 단축 아이콘에 액세스하려면 루트 프로젝트 디렉토리를 마우스 오른쪽 단추로 클릭하고 **IBM MobileFirst Foundation**으로 이동하십시오. 

여기에서 다음 명령 중에 선택할 수 있습니다. 

| 메뉴 옵션| 조치| 해당 MobileFirst 명령행 인터페이스|
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| 서버 콘솔 열기| 서버 정의가 있는 경우 지정된 서버의 조치를 볼 수 있도록 콘솔을 엽니다.| mfpdev server console
|
| 앱 미리보기| 브라우저 미리보기 모드에서 앱을 엽니다.| 브라우저 미리보기 모드에서 앱을 엽니다.|
| 앱 등록| 서버 정의에 지정된 서버에 앱을 등록합니다.| mfpdev app register
|
| 앱 암호화| 앱에서 웹 자원 암호화 도구를 실행합니다.| mfpdev app webencrypt|
| 앱 가져오기| 서버 정의에 지정된 서버에서 기존 앱 구성을 검색합니다.| mfpdev app pull
|
| 앱 푸시| 현재 앱의 앱 구성을 빌드 정의에 지정된 서버에 전송하여 다른 앱에 재사용할 수 있도록 합니다.| mfpdev app push
|
| 업데이트된 앱| www 폴더의 컨텐츠를 .zip 파일에 패키지하고 해당 패키지로 서버의 버전을 대체합니다.| mfpdev app webupdate
|


## 팁과 요령
{: #tips-and-tricks }
<img src="runAsContextMenu.png" alt="외부 IDE에서 열 Eclipse의 컨텍스트 메뉴" style="float:right;width:35%;margin-left: 10px"/>
### 외부 IDE
{: #external-ides }
외부 IDE(Android Studio 또는 Xcode)를 통해 디바이스를 테스트하거나 배치하려는 경우 컨텍스트 메뉴를 통해 수행할 수 있습니다. 

**참고**: Android Studio에 프로젝트를 수동으로 가져와서 Gradle 구성을 설정한 후 Eclipse에서 실행하십시오. 그렇지 않으면 불필요한 단계 또는 오류가 발생할 수 있습니다. Android Studio에서 **프로젝트(Eclipse ADT Gradle 등) 가져오기** 가져오기를 선택하고 프로젝트로 이동한 다음 **platforms** 디렉토리 내의 **android** 디렉토리를 선택하십시오. 

Eclipse 프로젝트 탐색기에서 원하는 플랫폼(예: **platforms** 디렉토리의 **android** 또는 **ios**)을 마우스 오른쪽 단추로 클릭하고 컨텍스트 메뉴의 **다음으로 실행**에 마우스 커서를 둔 다음 적절한 외부 IDE를 선택하십시오. 

### 플랫폼 추가
{: #adding-platforms }

플랫폼 추가는 THyM 플러그인으로 직관적으로 수행할 수 있는 단순 프로세스가 아닙니다. 다음과 같은 두 가지 옵션을 통해 동일한 태스크를 수행할 수 있습니다. 

1. 특성을 통해
	1. 프로젝트를 마우스 오른쪽 단추로 클릭하고 컨텍스트 메뉴에서 **특성**을 선택하십시오. 
	1. 표시되는 대화 상자의 왼쪽 메뉴에서 **하이브리드 모바일 엔진**을 선택하십시오. 
	1. 이 분할창에서 원하는 플랫폼을 선택하거나 다운로드할 수 있습니다. 

1. 터미널을 통해
	1. 프로젝트를 마우스 오른쪽 단추로 클릭하고 **표시 대상** 위에 마우스 커서를 두고 컨텍스트 메뉴에서 **터미널**을 선택하십시오. 
	1. 이를 수행하면 Eclipse에서 콘솔 옆에 탭이 추가되어야 합니다. 
	1. 여기서 Cordova CLI 명령을 사용하여 플랫폼을 수동으로 추가할 수 있습니다. 
		*  `cordova platform ls`는 설치되고 사용 가능한 플랫폼을 나열합니다. 
		*  `cordova platform add <platform>`. 여기서 *<platform>*은 원하는 플랫폼이며, 해당 명령은 지정된 플랫폼을 프로젝트에 추가합니다.
		*  Cordova 플랫폼 특정 명령에 대한 자세한 정보는 <a href="https://cordova.apache.org/docs/en/latest/reference/cordova-cli/#cordova-platform-command" target="blank">Cordova platform command 문서</a>를 참조하십시오. 

### 디버그 모드
{: #debug-mode }
디버그 모드를 사용하면 브라우저에서 애플리케이션을 미리 보는 동안 Eclipse 콘솔에 디버그 레벨 로그가 표시됩니다. 디버그 모드를 사용하려면 다음을 수행하십시오. 

1. Eclipse 환경 설정을 여십시오. 
2. **MobileFirst Studio 플러그인**을 선택하여 플러그인 환경 설정 페이지를 표시하십시오. 
3. **디버그 모드 사용** 선택란이 선택되었는지 확인한 후 **적용 → 확인**을 클릭하십시오. 

### 활성 업데이트
{: #live-update }
애플리케이션 미리보기 중에 활성 업데이트를 사용할 수 있습니다. 업데이트를 작성하고 변경사항을 저장한 다음 미리보기에서 자동으로 새로 고치기가 수행되는 것을 볼 수 있습니다. 

### Eclipse에 {{ site.data.keys.mf_server }} 통합
{: #integrating-mobilefirst-server-into-eclipse }
{{ site.data.keys.mf_dev_kit }}을 사용하여 위 사항과 함께 [Eclipse에서 {{ site.data.keys.mf_server }}를 실행](../../installation-configuration/development/mobilefirst/using-mobilefirst-server-in-eclipse)함으로써 보다 통합된 개발 환경을 작성할 수 있습니다. 

### 데모 비디오
{: #demo-video }
<div class="sizer">
	<div class="embed-responsive embed-responsive-16by9">
   		<iframe src="https://www.youtube.com/embed/yRe2AprnUeg"></iframe>
	</div>
</div>
