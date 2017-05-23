---
layout: tutorial
title: iOS 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
MobileFirst Foundation SDK는 [CocoaPods](http://guides.cocoapods.org)를 통해 사용 가능하며 Xcode 프로젝트에 추가할 수 있는 POD 콜렉션으로 구성됩니다.   
POD는 핵심 기능 및 다른 기능에 해당됩니다.

* **IBMMobileFirstPlatformFoundation** - 클라이언트 대 서버 연결을 구현하고 인증 및 보안 측면, 자원 요청과 기타 필수 핵심 기능을 처리합니다.
* **IBMMobileFirstPlatformFoundationJSONStore** - JSONStore 프레임워크를 포함합니다. 자세한 정보는 [iOS용 JSONStore 학습서](../../jsonstore/ios/)를 검토하십시오.
* **IBMMobileFirstPlatformFoundationPush** - 푸시 알림 프레임워크를 포함합니다. 자세한 정보는 [알림 학습서](../../../notifications/)를 검토하십시오.
* **IBMMobileFirstPlatformFoundationWatchOS** - Apple WatchOS에 대한 지원을 포함합니다.

이 학습서에서는 신규 또는 기존 iOS 애플리케이션에 CocoaPods를 사용하여 MobileFirst 고유 SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법도 학습합니다.

**전제조건:**

- 개발자 워크스테이션에 Xcode 및 MobileFirst CLI가 설치되어 있습니다.   
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다.
- [MobileFirst 개발 환경 설정](../../../installation-configuration/development/mobilefirst) 및 [iOS 개발 환경 설정](../../../installation-configuration/development/ios) 학습서를 읽으십시오.

> **참고:** XCode 8을 사용하여 시뮬레이터에서 iOS 앱을 실행 중인 경우 **키 체인 공유** 기능은 필수입니다.

#### 다음으로 이동:
{: #jump-to }
- [MobileFirst 고유 SDK 추가](#adding-the-mobilefirst-native-sdk)
- [MobileFirst 고유 SDK를 수동으로 추가](#manually-adding-the-mobilefirst-native-sdk)
- [Apple watchOS에 대한 지원 추가](#adding-support-for-apple-watchos)
- [MobileFirst 고유 SDK 업데이트](#updating-the-mobilefirst-native-sdk)
- [생성된 MobileFirst 고유 SDK 아티팩트](#generated-mobilefirst-native-sdk-artifacts)
- [비트 코드 및 TLS 1.2](#bitcode-and-tls-12)
- [다음 학습서](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} 고유 SDK 추가
{: #adding-the-mobilefirst-native-sdk }
아래 지시사항에 따라 신규 또는 기존 Xcode 프로젝트에 {{ site.data.keys.product }} 고유 SDK를 추가하고 {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오.

시작하기 전에 {{ site.data.keys.mf_server }}가 실행 중인지 확인하십시오.   
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.sh` 명령을 실행하십시오.

### 애플리케이션 작성
{: #creating-an-application }
Xcode 프로젝트를 작성하거나 기존 항목(Swift 또는 Objective-C)을 사용하십시오.   

### SDK 추가
{: #adding-the-sdk }
1. {{site.data.keys.product }} 고유 SDK는 CocoaPods를 통해 제공됩니다.
    - 개발 환경에 [CocoaPods](http://guides.cocoapods.org)가 이미 설치되어 있는 경우 2단계로 건너뛰십시오.
    - CocoaPods가 설치되지 않은 경우 다음과 같이 설치하십시오.   
        - **명령행** 창을 열고 Xcode 프로젝트의 루트로 이동하십시오.
        - `sudo gem install cocoapods` 및 `pod setup` 명령을 순서대로 실행하십시오. **참고:** 이러한 명령을 완료하려면 몇 분 정도 소요될 수 있습니다.
2. `pod init` 명령을 실행하십시오. `Podfile` 파일이 작성됩니다.
3. 선호하는 코드 편집기에서 `Podfile`을 여십시오.
    - 파일 컨텐츠를 주석 처리하거나 삭제하십시오.
    - 다음 행을 추가하고 변경사항을 저장하십시오.

      ```xml
      use_frameworks!

      platform :ios, 8.0
      target "Xcode-project-target" do
          pod 'IBMMobileFirstPlatformFoundation'
      end
      ```
      - Xcode 프로젝트의 대상 이름으로 **Xcode-project-target**을 대체하십시오.

4. 명령행 창으로 돌아가서 `pod install` 및 `pod update` 명령을 순서대로 실행하십시오. 이러한 명령은 {{ site.data.keys.product }} 고유 SDK 파일 및 **mfpclient.plist** 파일을 추가하고 Pod 프로젝트를 생성합니다.

    **참고:** 명령을 완료하려면 몇 분 정도 소요될 수 있습니다.

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요**: 여기서부터 `[ProjectName].xcworkspace` 파일을 사용하여 Xcode에서 프로젝트를 여십시오. `[ProjectName].xcodeproj` 파일을 사용하지 **마십시오**. CocoaPods 기반 프로젝트는 애플리케이션(실행 파일) 및 라이브러리(CocoaPod 관리자가 가져오는 모든 프로젝트 종속 항목)를 포함하는 작업공간으로 관리됩니다.

### {{ site.data.keys.product_adj }} 고유 SDK를 수동으로 추가
{: #manually-adding-the-mobilefirst-native-sdk}

{{ site.data.keys.product }} SDK를 다음과 같이 수동으로 추가할 수도 있습니다.

<div class="panel-group accordion" id="adding-the-sdk" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} SDK를 수동으로 추가하려면 먼저 <b>{{ site.data.keys.mf_console }} → 다운로드 센터 → SDK</b> 탭에서 SDK .zip 파일을 다운로드하십시오. </p>

                <ul>
                    <li>Xcode 프로젝트에서 {{ site.data.keys.product }} 프레임워크 파일을 다음과 같이 프로젝트에 추가하십시오.
                        <ul>
                            <li>프로젝트 탐색기에서 프로젝트 루트 아이콘을 선택하십시오. </li>
                            <li><b>파일 → 파일 추가</b>를 선택하고 이전에 다운로드된 프레임워크 파일이 있는 폴더로 이동하십시오. </li>
                            <li><b>옵션</b> 단추를 클릭하십시오. </li>
                            <li><b>필요한 경우 항목 복사</b> 및 <b>추가된 폴더에 대한 그룹 작성</b>을 선택하십시오.<br/>
                            <b>참고:</b> <b>필요한 경우 항목 복사</b> 옵션을 선택하지 않는 경우 프레임워크 파일이 복사되지는 않지만 원래 위치에 링크됩니다. </li>
                            <li>기본 프로젝트(첫 번째 옵션)를 선택하고 앱 대상을 선택하십시오. </li>
                            <li><b>일반</b> 탭에서 <b>링크된 프레임워크 및 라이브러리</b>에 자동으로 추가될 프레임워크를 모두 제거하십시오. </li>
                            <li>필수: <b>임베디드 2진</b>에서 다음 프레임워크를 추가하십시오.
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundation.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationOpenSSLUtils.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationWatchOS.framework</li>
                                    <li>Localizations.bundle</li>
                                </ul>
                                이 단계를 수행하면 이러한 프레임워크가 <b>링크된 프레임워크 및 라이브러리</b>에 자동으로 추가됩니다.
                            </li>
                            <li><b>링크된 프레임워크 및 라이브리러</b>에 다음 프레임워크를 추가하십시오.
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundationJSONStore.framework</li>
                                    <li>sqlcipher.framework</li>
                                    <li>openssl.framework</li>
                                </ul>
                            </li>
                            <blockquote><b>참고:</b> 이 단계는 프로젝트에 관련 {{ site.data.keys.product }} 프레임워크를 추가하고 빌드 단계(Phase) 탭의 라이브러리가 포함된 2진 링크 목록 내에 링크합니다. 앞의 설명대로 필요한 항목 복사 옵션을 선택하지 않고 원래 위치로 파일을 링크하는 경우 아래 설명된 대로 프레임워크 검색 경로를 설정해야 합니다. </blockquote>
                        </ul>
                    </li>
                    <li>1단계에서 추가된 프레임워크는 <b>빌드 단계(Phase)</b> 탭의 <b>라이브러리가 포함된 2진 링크</b> 섹션에 자동으로 추가됩니다. </li>
                    <li><i>선택사항:</i> 앞의 설명대로 프레임워크 파일을 프로젝트에 복사하지 않은 경우 <b>빌드 단계(Phase)</b> 탭에서 <b>필요한 항목 목사</b> 옵션을 사용하여 다음 단계를 수행하십시오.
                        <ul>
                            <li><b>빌드 설정</b> 페이지를 여십시오. </li>
                            <li><b>검색 경로</b> 섹션을 찾으십시오. </li>
                            <li><b>프레임워크 검색 경로</b> 폴더에 프레임워크가 있는 폴더의 경로를 추가하십시오. </li>
                        </ul>
                    </li>
                    <li><b>빌드 설정</b> 탭의 <b>배치</b> 섹션에서 <b>iOS 배치 대상</b> 필드의 값을 8.0 이상으로 선택하십시오. </li>
                    <li><i>선택사항:</i> Xcode 7부터 비트 코드가 기본적으로 설정됩니다. 제한사항 및 요구사항은 <a href="additional-information/#working-with-bitcode-in-ios-apps">iOS 앱의 비트 코드 작업</a>을 참조하십시오. 비트 코드를 사용 안함으로 설정하려면 다음을 수행하십시오.
                        <ul>
                            <li><b>빌드 옵션</b> 섹션을 여십시오. </li>
                            <li><b>비트 코드 사용</b>을 <b>아니오</b>로 설정하십시오. </li>
                        </ul>
                    </li>
                    <li>Xcode 7부터 TLS를 강제 실행해야 합니다. <a href="additional-information/#enforcing-tls-secure-connections-in-ios-apps">iOS 앱에서 TLS 보안 연결 강제 실행</a>을 참조하십시오. </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

### 애플리케이션 등록
{: #registering-the-application }
1. **명령행** 창을 열고 Xcode 프로젝트의 루트로 이동하십시오.   

2. 다음 명령을 실행하십시오.

    ```bash
    mfpdev app register
    ```
    - 원격 서버를 사용하는 경우 [`mfpdev server add` 명령을 사용](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)하여 추가하십시오.

    애플리케이션의 번들 ID를 제공하라는 메시지가 표시됩니다. **중요**: 번들 ID는 **대소문자를 구분**합니다.   

`mfpdev app register` CLI 명령은 먼저 {{ site.data.keys.mf_server }}에 연결하여 애플리케이션을 등록한 후에 Xcode 프로젝트의 루트에서 **mfpclient.plist** 파일을 생성하고 {{ site.data.keys.mf_server }}를 식별하는 메타데이터에 추가합니다.   

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** {{ site.data.keys.mf_console }}에서 애플리케이션을 등록할 수도 있습니다.     
>
> 1. {{ site.data.keys.mf_console }}을 로드하십시오.
> 2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.   
> 3. 애플리케이션이 등록된 후에 애플리케이션의 **구성 파일** 탭으로 이동하고 **mfpclient.plist** 파일을 복사하거나 다운로드하십시오. 화면의 지시사항에 따라 프로젝트에 파일을 추가하십시오.

### 설정 프로세스 완료
{: #completing-the-setup-process }
Xcode에서 프로젝트 항목을 마우스 오른쪽 단추로 클릭하고 **[프로젝트 이름]에 파일 추가**를 클릭한 다음 Xcode 프로젝트의 루트에 있는 **mfpclient.plist** 파일을 선택하십시오.

### SDK 참조
{: #referencing-the-sdk }
{{ site.data.keys.product }} 고유 SDK를 사용할 때마다 {{ site.data.keys.product }} 프레임워크를 가져오십시오.

Objective-C:

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
```

Swift:

```swift
import IBMMobileFirstPlatformFoundation
```

<br>
#### iOS 9 이상에 대한 참고사항:
{: #note-about-ios-9-and-above }
> Xcode 7부터 [ATS(Application Transport Security)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14)가 기본적으로 사용됩니다. 개발 중에 앱을 실행하려는 경우 ATS를 사용 안함으로 설정할 수 있습니다([자세히 보기](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error)).
>   1. Xcode에서 **[프로젝트]/info.plist 파일 → 다른 이름으로 열기 → 소스 코드**를 마우스 오른쪽 단추로 클릭하십시오.
>   2. 다음을 붙여넣으십시오.
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```

## Apple watchOS에 대한 지원 추가
{: #adding-support-for-apple-watchos}
Apple watchOS 2 이상에 대해 개발 중인 경우 Podfile에는 기본 앱 및 watchOS 확장에 해당하는 섹션이 포함되어 있어야 합니다. watchOS 2에 대한 아래 예제를
참조하십시오.

```xml
# Replace with the name of your watchOS application
xcodeproj 'MyWatchApp'

use_frameworks!

#use the name of the iOS target
target :MyWatchApp do
    platform :ios, 9.0
    pod 'IBMMobileFirstPlatformFoundation'
    end

#use the name of the watch extension target
target :MyWatchApp WatchKit Extension do
    platform :watchos, 2.0
    pod 'IBMMobileFirstPlatformFoundation'
end
```

Xcode 프로젝트가 처리완료되었는지 확인하고 `pod install` 명령을 실행하십시오.

## {{ site.data.keys.product_adj }} 고유 SDK 업데이트
{: #updating-the-mobilefirst-native-sdk }
최신 릴리스로 {{ site.data.keys.product }} 고유 SDK를 업데이트하려면 **명령행** 창의 Xcode 프로젝트 루트 폴더에서 다음 명령을 실행하십시오.

```bash
pod update
```

SDK 릴리스는 SDK의 [CocoaPods 저장소](https://cocoapods.org/?q=ibm%20mobilefirst)에 있습니다.

## 생성된 {{ site.data.keys.product_adj }} 고유 SDK 아티팩트
{: #generated-mobilefirst-native-sdk-artifacts}

### mfpclient.plist
{: #mfpclientplist }
이 파일은 프로젝트의 루트에 있으며 {{ site.data.keys.mf_server }}에서 iOS 앱을 등록하는 데 사용되는 클라이언트 측 특성을 정의합니다.

| 특성            | 설명                                                         | 예제 값 |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | {{ site.data.keys.mf_server }}에 사용되는 통신 프로토콜입니다.             | HTTP 또는 HTTPS  |
| host        | {{ site.data.keys.mf_server }}의 호스트 이름입니다.                            | 192.168.1.63   |
| port        | {{ site.data.keys.mf_server }}의 포트입니다.                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }}에서 애플리케이션의 컨텍스트 루트 경로입니다.  | /mfp/          |
| languagePreferences | 클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다.            | en             |

## 비트 코드 및 TLS 1.2
{: #bitcode-and-tls-12 }
비트 코드 및 TLS 1.2의 지원에 대한 정보는 [추가 정보](additional-information) 페이지를 참조하십시오.

## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product }} 고유 SDK가 통합되었으므로 다음을 수행할 수 있습니다.

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
