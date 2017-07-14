---
layout: tutorial
title: Cordova 엔드-투-엔드 데모
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 데모의 목적은 엔드-투-엔드 플로우를 경험해보는 것입니다. 

1. {{ site.data.keys.product_adj }} 클라이언트 SDK가 사전에 번들된 샘플 애플리케이션을 등록하고 {{ site.data.keys.mf_console }}에서 다운로드합니다.
2. 새 어댑터 또는 제공된 어댑터가 {{ site.data.keys.mf_console }}에 배치됩니다.  
3. 자원 요청을 하도록 애플리케이션 로직이 변경됩니다.

**종료 결과**:

* {{ site.data.keys.mf_server }} ping을 실행함.
* 어댑터를 사용하여 데이터를 검색함.

#### 전제조건: 
{: #prerequisites }
* iOS용 Xcode, Android용 Android Studio 또는 Windows 8.1 Universal/Windows 10 UWP용 Visual Studio 2013/2015
* Cordova CLI 6.x.
* *선택사항*. {{ site.data.keys.mf_cli }} ([다운로드]({{site.baseurl}}/downloads))
* *선택사항*. 독립형 {{ site.data.keys.mf_server }} ([다운로드]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} 시작
{: #1-starting-the-mobilefirst-server }
[Mobile Foundation 인스턴스를 작성](../../bluemix/using-mobile-foundation)했는지 확인하십시오. 또는  
[{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst)를 사용하는 경우, 서버의 폴더로 이동해서 Mac 및 Linux의 경우 `./run.sh` 또는 Windows의 경우 `run.cmd` 명령을 실행하십시오. 

### 2. 애플리케이션 작성 및 등록
{: #2-creating-and-registering-an-application }
브라우저 창에서 URL `http://your-server-host:server-port/mfpconsole`을 로드하여 {{ site.data.keys.mf_console }}을 여십시오. 로컬에서 실행 중인 경우 [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)을 사용하십시오. 사용자 이름/비밀번호는 *admin/admin*입니다.
 
1. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하십시오.
    * **Android, iOS, Windows** 플랫폼을 선택하십시오.
    * **com.ibm.mfpstartercordova**를 **애플리케이션 ID**로 입력하십시오.
    * **1.0.0**을 **버전**으로 입력하십시오.
    * **애플리케이션 등록**을 클릭하십시오.

    <img class="gifplayer" alt="애플리케이션 등록" src="register-an-application-cordova.png"/>
 
2. Cordova 샘플 애플리케이션을 다운로드하려면 **스타터 코드 가져오기** 타일에서 클릭하여 선택하십시오.

    <img class="gifplayer" alt="샘플 애플리케이션 다운로드" src="download-starter-code-cordova.png"/>
 
### 3. 애플리케이션 로직 편집
{: #3-editing-application-logic }
1. 선택한 코드 편집기로 Cordova 프로젝트를 여십시오.

2. **www/js/index.js** 파일을 선택하고 다음 코드 스니펫을 붙여넣기하면 다음과 같이 기존 `WLAuthorizationManager.obtainAccessToken()` 함수를 바꿉니다.

```javascript
WLAuthorizationManager.obtainAccessToken()
    .then(
        function(accessToken) {
            titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
            
            var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );
            
            resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                function(response) {
                    alert("Failure: " + JSON.stringify(response));
                }
            );
        },

        function(error) {
            titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
    );
```
    
### 4. 어댑터 배치
{: #4-deploy-an-adapter }
[이 준비된 .adapter 아티팩트](../javaAdapter.adapter)를 다운로드하고 **조치 → 어댑터 배치** 조치를 사용하여 {{ site.data.keys.mf_console }}에서 배치하십시오.

그렇지 않으면 **어댑터** 옆에 있는 **새로 작성** 단추를 클릭하십시오.  
        
1. **조치 → 샘플 다운로드** 옵션을 선택하십시오. "Hello World" **Java** 어댑터 샘플을 다운로드하십시오.

    > Maven 및 {{ site.data.keys.mf_cli }}가 설치되지 않은 경우, 화면상의 **개발 환경 설정** 지시사항을 따르십시오.

2. **명령행** 창에서 어댑터의 Maven 프로젝트 루트 폴더로 이동해서 다음 명령을 실행하십시오.

    ```bash
    mfpdev adapter build
    ```

3. 빌드가 완료되면 **조치 → 어댑터 배치** 조치를 사용하여 {{ site.data.keys.mf_console }}에서 배치하십시오. **[adapter]/target** 폴더에서 어댑터를 찾을 수 있습니다.
    
    <img class="gifplayer" alt="어댑터 배치" src="create-an-adapter.png"/>   


<img src="cordovaQuickStart.png" alt="샘플 애플리케이션" style="float:right"/>
### 5. 애플리케이션 테스트
{: #5-testing-the-application }
1. **명령행** 창에서 Cordova 프로젝트의 루트 폴더로 이동하십시오.
2. `cordova platform add ios|android|windows` 명령을 실행하여 플랫폼을 추가하십시오.
3. Cordova 프로젝트에서 **config.xml** 파일을 선택하고 **프로토콜**, **호스트** 및 **포트** 특성의 `<mfp:server ... url=" "/>` 값을 사용자의 {{ site.data.keys.mf_server }}에 올바른 값으로 편집하십시오.
    * 로컬 {{ site.data.keys.mf_server }}를 사용 중인 경우, 일반적으로 값은 **http**, **localhost** 및 **9080**입니다.
    * 원격 {{ site.data.keys.mf_server }}를 사용 중인 경우(Bluemix에서), 일반적으로 값은 **https**, **your-server-address** 및 **443**입니다.

    또는, {{ site.data.keys.mf_cli }}를 설치한 경우에는 프로젝트 루트 폴더로 이동해서 `mfpdev app register` 명령을 실행하십시오. 원격 {{ site.data.keys.mf_server }}가 사용된 경우, [`mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 명령을 실행하여 서버를 추가하고, 예를 들면 `mfpdev app register myBluemixServer`를 이어서 실행하십시오.
	
디바이스가 연결된 경우 애플리케이션이 그 디바이스에 설치되어 실행됩니다.  
그렇지 않으면 시뮬레이터 또는 에뮬레이터가 사용됩니다.

<br clear="all"/>
### 결과
{: #results }
* **{{ site.data.keys.mf_server }} Ping** 단추를 클릭하면 **{{ site.data.keys.mf_server }}에 연결됨**이 표시됩니다.
* 애플리케이션이 {{ site.data.keys.mf_server }}에 연결할 수 없는 경우, 배치된 Java 어댑터를 사용하는 자원 요청이 발생합니다. 

그 후에 어댑터 응답이 경보에 표시됩니다.

## 다음 단계
{: #next-steps }
애플리케이션에서 어댑터 사용하기 및 {{ site.data.keys.product_adj }} 보안 프레임워크를 사용하여 푸시 알림과 같은 추가 서비스를 통합하는 방법에 대해 더 학습합니다.

- [애플리케이션 개발](../../application-development/) 학습서 검토
- [어댑터 개발](../../adapters/) 학습서 검토
- [인증 및 보안 학습서](../../authentication-and-security/) 검토
- [알림 학습서](../../notifications/) 검토
- [모든 학습서](../../all-tutorials) 검토
