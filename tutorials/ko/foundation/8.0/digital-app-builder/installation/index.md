---
layout: tutorial
title: 설치 및 구성
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #installation-and-configuration }

Digital App Builder는 MacOS 및 Windows 플랫폼에 설치될 수 있습니다. 설치는 또한 첫 번째 설치 중에 설치되고 확인된 필수 소프트웨어를 포함합니다. 배치 중에 앱 미리보기 및 어댑터 생성을 위해 Java, Xcode 및 Android Studio를 설치하십시오.

### MacOS에 설치
{: #installing-on-macos }

1. [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) 또는 [여기](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)에서 .dmg(**IBM.Digital.App.Builder-n.n.n.dmg**, 여기서`n.n.n`은 버전 번호임)를 다운로드하십시오.
2. .dmg 파일을 두 번 클릭하여 설치 프로그램을 마운트하십시오.
3. 설치 프로그램이 열리는 창에서 IBM Digital App Builder를 **애플리케이션** 폴더에 끌어서 놓기하십시오.
4. IBM Digital App Builder 아이콘 또는 실행 파일을 두 번 클릭하여 Digital App Builder를 여십시오.
    >**참고**: Digital App Builder가 처음으로 설치되면 Digital App Builder는 인터페이스를 열어 필수 소프트웨어를 설치합니다. Digital App Builder의 이전 버전이 존재하는 경우, 필수 소프트웨어 검사가 수행되며 필수 소프트웨어를 충족하기 위해 일부 소프트웨어를 업그레이드 또는 다운그레이드해야 할 수 있습니다.
    
    >버전 8.0.6부터 설치 프로그램에 Mobile Foundation 개발 서버가 포함됩니다. 설치 중에 개발 서버가 다른 필수 소프트웨어와 함께 설치됩니다. 개발 서버의 라이프사이클(예: 서버 시작/중지)이 Digital App Builder 내에서 처리됩니다.
    
    ![Digital App Builder 설치](dab-install-startup.png)

5. **설정 시작**을 클릭하십시오. 그러면 라이센스 계약 화면이 표시됩니다.

    ![라이센스 계약 화면](dab-install-license.png)

6. 라이센스 계약에 동의하고 **다음**을 클릭하십시오. 그러면 **필수 소프트웨어 설치** 화면이 표시됩니다.
    >**참고**: 필수 소프트웨어가 이미 설치되어 있는지 여부를 확인하기 위해 검사가 수행되고 각각에 대해 상태가 표시됩니다.

    ![필수 소프트웨어 설치 화면](dab-install-prereq.png)

7. 필수 소프트웨어가 **설치 예정** 상태에 있는 경우 **설치**를 클릭하여 필수 소프트웨어를 설치하십시오.

    ![필수 소프트웨어 설치 화면](dab-install-prereq-tobeinstalled.png)

8. *선택사항* - 필수 소프트웨어를 설치한 이후, Digital App Builder에서 데이터 세트 관련 작업을 위해 JAVA가 필요하므로 설치 프로그램이 JAVA를 확인합니다. 
    >**참고**: 아직 설치되지 않았으면 Java의 수동 설치가 필요할 수 있습니다. Java 설치를 위해 [Java 설치](https://www.java.com/en/download/help/download_options.xml)를 참조하십시오.

9. 필수 소프트웨어를 설치한 후에는 Digital App Builder 스타트업 화면이 표시됩니다. **빌드 시작**을 클릭하십시오.

    ![Digital App Builder 스타트업](dab-install-startup-screen.png)

10. *선택사항* - 또한 설치 프로그램은 Xcode(MacOS에만 해당되며, 배치 중에 iOS 시뮬레이터에서 앱 미리보기를 위함) 및 Android Studio(MacOS 및 Windows의 경우, Android 앱 미리보기를 위함)의 선택적 설치도 확인합니다.
    >**참고**: Xcode 및 Android Studio의 수동 설치가 필요할 수 있습니다. Cocoapods 설치의 경우 [CocoaPods 사용](https://guides.cocoapods.org/using/using-cocoapods)을 참조하십시오. Android Studio 설치의 경우 [Android Studio 설치](https://developer.android.com/studio/)를 참조하십시오. 

>**참고**: 지정된 시점에 [필수 소프트웨어 확인](#prerequisites-check)을 수행하여 설치가 앱 개발에 적합한지 확인할 수 있습니다. 오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

### Windows에 설치
{: #installing-on-windows }

1. [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) 또는 [여기](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)에서 .exe(**IBM.Digital.App.Builder.Setup.n.n.n.exe**, 여기서 `n.n.n`은 버전 번호임)를 다운로드하십시오.
2. 관리 모드에서 다운로드된 실행 파일(**IBM.Digital.App.Builder.Setup.n.n.n.exe**)을 실행하십시오.
    >**참고**: Digital App Builder가 처음으로 설치되면 Digital App Builder는 인터페이스를 열어 필수 소프트웨어를 설치합니다. Digital App Builder의 이전 버전이 존재하는 경우, 필수 소프트웨어 검사가 수행되며 필수 소프트웨어를 충족하기 위해 일부 소프트웨어를 업그레이드 또는 다운그레이드해야 할 수 있습니다.
    
    >버전 8.0.6부터 설치 프로그램에 Mobile Foundation 개발 서버가 포함됩니다. 설치 중에 개발 서버가 다른 필수 소프트웨어와 함께 설치됩니다. 개발 서버의 라이프사이클(예: 서버 시작/중지)이 Digital App Builder 내에서 처리됩니다.

    ![Digital App Builder 설치](dab-install-startup.png)

3. **설정 시작**을 클릭하십시오. 그러면 라이센스 계약 화면이 표시됩니다.

    ![라이센스 계약 화면](dab-install-license.png)

4. 라이센스 계약에 동의하고 **다음**을 클릭하십시오. 그러면 **필수 소프트웨어 설치** 화면이 표시됩니다.
    >**참고**: 필수 소프트웨어가 이미 설치되어 있는지 여부를 확인하기 위해 검사가 수행되고 각각에 대해 상태가 표시됩니다.

    ![필수 소프트웨어 설치 화면](dab-install-prereq.png)

5. 필수 소프트웨어가 **설치 예정** 상태에 있는 경우 **설치**를 클릭하여 필수 소프트웨어를 설치하십시오.

    ![필수 소프트웨어 설치 화면](dab-install-prereq-tobeinstalled.png)

6. *선택사항* - 필수 소프트웨어를 설치한 후 Digital App Builder에서는 데이터 세트 관련 작업을 위해 JAVA가 필요하므로 설치 프로그램이 JAVA를 확인합니다. 
    >**참고**: 아직 설치되지 않았으면 Java의 수동 설치가 필요할 수 있습니다. Java 설치를 위해 [Java 설치](https://www.java.com/en/download/help/download_options.xml)를 참조하십시오.

7. 필수 소프트웨어를 설치한 후 Digital App Builder 스타트업 화면이 표시됩니다. **빌드 시작**을 클릭하십시오.

    ![Digital App Builder 스타트업](dab-install-startup-screen.png)

    >**참고**: 데스크탑의 **시작 > 프로그램**에도 바로가기가 작성됩니다. 기본 설치 폴더는 `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.3`입니다.

8. *선택사항* - 설치 프로그램은 또한 Xcode(MacOS의 경우 배치 중에 iOS 시뮬레이터에서 앱 미리보기) 및 Android Studio(MacOS 및 Windows의 경우 Android 앱 미리보기)의 선택적 설치를 확인합니다.
    >**참고**: Android Studio를 수동으로 설치하십시오. Android Studio 설치의 경우 [Android Studio 설치](https://developer.android.com/studio/)를 참조하십시오. 

>**참고**: 지정된 시점에 [필수 소프트웨어 확인](#prerequisites-check)을 수행하여 설치가 앱 개발에 적합한지 확인할 수 있습니다. 오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

### 필수 소프트웨어 확인
{: #prerequisites-check }

앱을 개발하기 전에 **도움말 > 필수 소프트웨어 확인**을 선택하여 필수 소프트웨어 확인을 수행하십시오.

![필수 소프트웨어 확인](dab-prerequsites-check.png)

오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

>**참고**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods)는 MacOS에만 필요합니다.
