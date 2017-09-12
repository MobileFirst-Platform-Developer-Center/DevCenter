---
layout: tutorial
title: Windows 8.1 Universal 또는 Windows 10 UWP 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product }} SDK는  [Nuget](https://www.nuget.org/)을 통해 사용 가능한 종속 항목 콜렉션으로 구성되며, Visual Studio 프로젝트에 추가할 수 있습니다. 종속 항목은 핵심 기능 및 다른 기능에 해당됩니다. 

* **IBMMobileFirstPlatformFoundation** - 클라이언트 대 서버 연결을 구현하고 인증 및 보안 측면, 자원 요청과 기타 필수 핵심 기능을 처리합니다. 

이 학습서에서는 Nuget을 사용하여 신규 또는 기존 Windows 8.1 Universal 애플리케이션이나 Windows 10 UWP(Universal Windows Platform) 애플리케이션에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법 및 프로젝트에 추가되는 {{ site.data.keys.product_adj }} 구성 파일에 대한 정보를 찾는 방법에 대해서도 학습합니다. 

**전제조건:**

- 개발자 워크스테이션에 Microsoft Visual Studio 2013 또는 2015 및 {{ site.data.keys.mf_cli }}가 설치되어 있습니다. Windows 10 UWP 솔루션을 개발하려면 Visual Studio 2015 이상이 필요합니다. 
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다. 
- [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/development/mobilefirst)과 [Windows 8 Universal 및 Windows 10 UWP 개발 환경 설정](../../../installation-configuration/development/windows) 학습서를 읽으십시오. 

#### 다음으로 이동:
{: #jump-to }
- [{{ site.data.keys.product_adj }} 고유 SDK 추가](#adding-the-mobilefirst-native-sdk)
- [수동으로 {{ site.data.keys.product_adj }} 고유 SDK 추가](#manually-adding-the-mobilefirst-win-native-sdk)
- [{{ site.data.keys.product_adj }} 고유 SDK 업데이트](#updating-the-mobilefirst-native-sdk)
- [생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트](#generated-mobilefirst-native-sdk-artifacts)
- [다음 학습서](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} 고유 SDK 추가
{: #adding-the-mobilefirst-native-sdk }
아래 지시사항에 따라 신규 또는 기존 Visual Studio 프로젝트에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하고 {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오. 

시작하기 전에 {{ site.data.keys.mf_server }} 인스턴스가 실행 중인지 확인하십시오.   
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.cmd` 명령을 실행하십시오. 

### 애플리케이션 작성
{: #creating-an-application }
Visual Studio 2013/2015를 사용하여 Windows 8.1 Universal 또는 Windows 10 UWP 프로젝트를 작성하거나 기존 프로젝트를 사용하십시오.   

### SDK 추가
{: #adding-the-sdk }
1. {{ site.data.keys.product_adj }} 패키지를 가져오려면 NuGet 패키지 관리자를 사용하십시오.
NuGet은 .NET를 포함하여 Microsoft 개발 플랫폼에 대한 패키지 관리자입니다. NuGet 클라이언트 도구는 패키지를 생성하고 사용하는 기능을 제공합니다. NuGet Gallery는 모든 패키지 작성자 및 사용자가 사용하는 중앙 패키지 저장소입니다. 

2. Visual Studio 2013/2015에서 Windows 8.1 Universal 또는 Windows 10 UWP 프로젝트를 여십시오. 프로젝트 솔루션을 마우스 오른쪽 단추로 클릭하고 **Nuget 패키지 관리**를 선택하십시오. 

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. 검색 옵션에서 "IBM MobileFirst Platform"을 검색하십시오. **IBM.MobileFirstPlatform{{ site.data.keys.product_V_R_M_I }}**을 선택하십시오. 

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. **설치**를 클릭하십시오. 이 조치는 {{ site.data.keys.product }} 고유 SDK 및 해당 종속 항목을 설치합니다. 또한 이 단계는 Visual Studio 프로젝트의 `strings` 폴더에 비어 있는 `mfpclient.resw` 파일을 생성합니다. 

5. 최소한 다음 기능이 `Package.appxmanifest`에서 사용되는지 확인하십시오. 

    - 인터넷(클라이언트)

### {{ site.data.keys.product_adj }} 고유 SDK를 수동으로 추가
{: #manually-adding-the-mobilefirst-win-native-sdk }

{{ site.data.keys.product }} SDK를 다음과 같이 수동으로 추가할 수도 있습니다. 

<div class="panel-group accordion" id="adding-the-win-sdk" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                <p>프레임워크와 라이브러리 파일을 수동으로 가져와서 MobileFirst 애플리케이션 개발을 위한 환경을 준비할 수 있습니다. Windows 8 및 Windows 10 UWP(Universal Windows Platform)용 {{ site.data.keys.product }} SDK도 NuGet에서 제공합니다. </p>

                <ol>
                    <li><b>{{ site.data.keys.mf_console }} → Download Center → SDK</b> 탭에서 {{ site.data.keys.product }} SDK를 가져오십시오.
                    </li>
                    <li>1단계에서 얻은 다운로드한 SDK의 컨텐츠를 추출하십시오. </li>
                    <li>Windows 유니버셜 고유 프로젝트를 Visual Studio에서 여십시오. 다음 단계를 수행하십시오.
                        <ol>
                            <li><b>도구 → NuGet 패키지 관리자 → 패키지 관리자 설정</b>을 선택하십시오. </li>
                            <li><b>패키지 소스</b> 옵션을 선택하십시오. <b>+</b> 아이콘을 클릭하여 새 패키지 소스를 추가하십시오. </li>
                            <li>패키지 소스의 이름을 제공하십시오(예: <em>windows8nuget</em>). </li>
                            <li>다운로드하여 추출한 MobileFirst SDK 폴더로 이동하십시오. <b>확인</b>을 클릭하십시오. </li>
                            <li><b>업데이트</b>를 클릭한 다음 <b>확인</b>을 클릭하십시오. </li>
                            <li>화면의 오른쪽에 있는 <b>솔루션 탐색기</b> 탭에서 <b>솔루션 프로젝트 이름</b>을 마우스 오른쪽 단추로 클릭하십시오. </li>
                            <li><b>솔루션의 NuGet 패키지 선택 → 온라인 → windows8nuget</b>을 선택하십시오. </li>
                            <li><b>설치</b> 옵션을 클릭하십시오. <b>프로젝트 선택</b> 옵션이 표시됩니다. </li>
                            <li>선택란이 모두 선택되어 있는지 확인하십시오. <b>확인</b>을 클릭하십시오. </li>
                        </ol>

                    </li>
                </ol>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

### 애플리케이션 등록
{: #reigstering-the-application }
1. **명령행**을 열고 Visual Studio 프로젝트의 루트로 이동하십시오.   

2. 다음 명령을 실행하십시오. 

   ```bash
   mfpdev app register
   ```
    - 원격 서버를 사용하는 경우 [`mfpdev server add` 명령을 사용](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)하여 추가하십시오. 

`mfpdev app register` CLI 명령은 먼저 {{ site.data.keys.mf_server }}에 연결하여 애플리케이션을 등록한 후에 Visual Studio 프로젝트의 **strings** 폴더에서 **mfpclient.resw** 파일을 업데이트하고 {{ site.data.keys.mf_server }}를 식별하는 메타데이터에 추가합니다. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** {{ site.data.keys.mf_console }}에서 애플리케이션을 등록할 수도 있습니다.     
>
> 1. {{ site.data.keys.mf_console }}을 로드하십시오.   
> 2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.   
> 3. 애플리케이션이 등록된 후에 애플리케이션의 **구성 파일** 탭으로 이동하고 **mfpclient.resw** 파일을 복사하거나 다운로드하십시오. 화면의 지시사항에 따라 프로젝트에 파일을 추가하십시오.

## {{ site.data.keys.product_adj }} 고유 SDK 업데이트
{: #updating-the-mobilefirst-native-sdk }
최신 릴리스로 {{ site.data.keys.product_adj }} 고유 SDK를 업데이트하려면 **명령행** 창의 Visual Studio 프로젝트 루트 폴더에서 다음 명령을 실행하십시오. 

```bash
Nuget update
```

## 생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.resw
{: #mfpclientresw }
이 파일은 프로젝트의 `strings` 폴더에 있으며, 서버 연결 특성을 포함하고 사용자가 편집할 수 있습니다. 

- `protocol` – {{ site.data.keys.mf_server }}에 대한 통신 프로토콜입니다. `HTTP` 또는 `HTTPS`입니다. 
- `WlAppId` - 애플리케이션의 ID입니다. 이는 서버의 애플리케이션 ID와 동일해야 합니다. 
- `host` – {{ site.data.keys.mf_server }} 인스턴스의 호스트 이름입니다. 
- `port` – {{ site.data.keys.mf_server }} 인스턴스의 포트입니다. 
- `wlServerContext` – {{ site.data.keys.mf_server }} 인스턴스에서 애플리케이션의 컨텍스트 루트 경로입니다. 
- `languagePreference` - 클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다. 

## 다음 학습서
{: #tutorials-to-follow-next }
이제 MobileFirst 고유 SDK가 통합되었으므로 다음을 수행할 수 있습니다. 

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
