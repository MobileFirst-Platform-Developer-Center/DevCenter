---
layout: tutorial
title: Xamarin 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product }} SDK는 [Nuget 패키지 관리자](https://www.nuget.org/packages?q=mobilefirst)에서 Xamarin 프로젝트에 추가할 수 있는 Nuget 패키지에 패키지된 종속 항목 콜렉션으로 구성됩니다.

패키지는 핵심 기능 및 다른 기능에 해당됩니다.

* **IBM.MobileFirstPlatformFoundation** - 클라이언트 대 서버 연결을 구현하고 인증 및 보안 측면, 자원 요청과 기타 필수 핵심 기능을 JSONStore 프레임워크와 함께 처리하는 MobileFirst 클라이언트 sdk 라이브러리를 포함합니다.
 
* **IBM.MobileFirstPlatformFoundationPush** - 푸시 알림 프레임워크를 포함합니다. 자세한 정보는 [알림 학습서](../../../notifications/)를 검토하십시오.

이 학습서에서는 NuGet 패키지 관리자를 사용하여 신규 또는 기존 Xamarin.Android 또는 Xamarin.iOS 애플리케이션에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법도 학습합니다.

**전제조건:**

- macOS용 개발자 워크스테이션에 Visual Studio 2017이 설치되어 있습니다.
- Windows OS용 개발자 워크스테이션에 Visual Studio 2017 커뮤니티 버전이 설치되어 있습니다. Visual Studio의 Express Edition을 사용하고 있지 않은지 확인하십시오. 사용하고 있다면 Community Edition으로 업데이트할 것을 권장합니다.   
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다.
- [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/development/) 및 [Xamarin 개발 환경 설정](../../../installation-configuration/development/xamarin/) 학습서를 읽으십시오.

#### 다음으로 이동:
{: #jump-to }
- [{{ site.data.keys.product_adj }} 고유 SDK 추가](#adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} 고유 SDK 업데이트](#updating-the-mobilefirst-native-sdk)
- [다음 학습서](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} 고유 SDK 추가
{: #adding-the-mobilefirst-native-sdk }
아래 지시사항에 따라 신규 또는 기존 Xcode 프로젝트에 {{ site.data.keys.product_adj }} 고유 SDK를 추가하고 {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오.

시작하기 전에 {{ site.data.keys.mf_server }}가 실행 중인지 확인하십시오.  
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.sh` 명령을 실행하십시오.

### 애플리케이션 작성
{: #creating-an-application }
Xamarin Studio 또는 Visual Studio를 사용하여 Xamarin 솔루션을 작성하거나 기존 항목을 사용하십시오.

### SDK 추가
{: #adding-the-sdk }
1. {{ site.data.keys.product_adj }} 고유 SDK는 Nuget Gallery 또는 Nuget 저장소를 통해 제공됩니다.
2. MobileFirst 패키지를 가져오려면 NuGet 패키지 관리자를 사용하십시오.
NuGet은 .NET를 포함하여 Microsoft 개발 플랫폼에 대한 패키지 관리자입니다. NuGet 클라이언트 도구는 패키지를 생성하고 사용하는 기능을 제공합니다. NuGet Gallery는 모든 패키지 작성자 및 사용자가 사용하는 중앙 패키지 저장소입니다. 패키지 디렉토리에서 마우스 오른쪽 단추로 클릭하고 패키지 추가를 선택한 후 검색 옵션에서 *IBM MobileFirst Platform*을 검색하십시오. **IBM.MobileFirstPlatformFoundation**을 선택하십시오.
![Adding sdk from nuget.org]({{site.baseurl}}/assets/xamarin-tutorials/add-package1.png)
3. 패키지 추가를 클릭하십시오. 이 조치는 Mobile Foundation 고유 SDK 및 해당 종속 항목을 설치합니다.
![nuget.org에서 SDK 추가]({{site.baseurl}}/assets/xamarin-tutorials/add-package2.png)


### 애플리케이션 등록
{: #registering-the-application }
1. {{ site.data.keys.mf_console }}을 로드하십시오.
2. 애플리케이션 옆에 있는 새로 작성 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.
3. Android 및 iOS 애플리케이션을 별도로 등록해야 합니다. 이렇게 하면 Android 애플리케이션 및 iOS 애플리케이션을 서버에 올바르게 연결할 수 있습니다. Android 및 iOS 애플리케이션의 등록 세부사항은 각각 `AndroidManifest.xml` 및 `Info.plist`에 있습니다.
3. 애플리케이션이 등록된 후에 애플리케이션의 구성 파일 탭으로 이동하고 `mfpclient.plist` 및 `mfpclient.properties` 파일을 복사하거나 다운로드하십시오. 화면의 지시사항에 따라 프로젝트에 파일을 추가하십시오.

### 설정 프로세스 완료
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Xamarin iOS 프로젝트를 마우스 오른쪽 단추로 클릭하고 **파일 추가..**를 선택하십시오. 프로젝트의 루트에서 `mfpclient.plist`를 찾으십시오. 프롬프트가 표시되면 **프로젝트에 파일 복사**를 선택하십시오.
2. `mfpclient.plist` 파일을 마우스 오른쪽 단추로 클릭하고 **빌드 조치**를 선택하십시오. **컨텐츠**를 선택하십시오.

#### mfpclient.properties
{: #mfpclientproperties }
1. Xamarin Android 프로젝트의 *Assets* 폴더를 마우스 오른쪽 단추로 클릭하고 **파일 추가..**를 선택하십시오. 폴더에 대한 `mfpclient.properties`를 찾으십시오. 프롬프트가 표시되면 **프로젝트에 파일 복사**를 선택하십시오.
2. `mfpclient.properties` 파일을 마우스 오른쪽 단추로 클릭하고 **빌드 조치**를 선택하십시오. **Android 자산**을 선택하십시오.

### SDK 참조
{: #referencing-the-sdk }
{{ site.data.keys.product_adj }} 고유 SDK를 사용할 때마다 {{ site.data.keys.product }} 프레임워크를 가져오십시오.

CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## {{ site.data.keys.product_adj }} 고유 SDK 업데이트
{: #updating-the-mobilefirst-native-sdk }
최신 릴리스로 {{ site.data.keys.product_adj }} 고유 SDK를 업데이트하려면 Nuget Gallery를 통해 SDK 버전을 업데이트하십시오.

## 생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
이 파일은 {{ site.data.keys.mf_server }}에서 iOS 앱을 등록하는 데 사용되는 클라이언트 측 특성을 정의합니다.

|특성            |설명                                                         |예제 값 |
|---------------------|---------------------------------------------------------------------|----------------|
|protocol    |{{ site.data.keys.mf_server }}에 사용되는 통신 프로토콜입니다.             |HTTP 또는 HTTPS  |
|host        |{{ site.data.keys.mf_server }}의 호스트 이름입니다.                            |192.168.1.63   |
|port        |{{ site.data.keys.mf_server }}의 포트입니다.                                 |9080           |
|wlServerContext     |{{ site.data.keys.mf_server }}에서 애플리케이션의 컨텍스트 루트 경로입니다. |/mfp/          |
|languagePreferences |클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다.           |en             |

## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product_adj }} 고유 SDK가 통합되었으므로 다음을 수행할 수 있습니다.

- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
