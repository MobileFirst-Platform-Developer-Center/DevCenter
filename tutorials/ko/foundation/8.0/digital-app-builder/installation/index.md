---
layout: tutorial
title: 설치 및 구성
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #installation-and-configuration }

MacOS 및 Windows 플랫폼에서 Digital App Builder를 설치할 수 있습니다.

### MacOS에 설치
{: #installing-on-macos }

1. [https://nodejs.org/en/download](https://nodejs.org/en/download)(Node.js 8.x 이상)에서 설치를 다운로드하여 **Node.js** 및 **npm**을 설치하십시오. 설치 지시사항에 대한 자세한 정보는 [여기](https://nodejs.org/en/download/package-manager/)를 참조하십시오. 아래에 표시되는 대로 노드 및 npm 버전을 확인하십시오.
    ```java
    $node -v
    v8.10.0
    $npm -v
    6.4.1
    ```
2. **Cordova**를 설치하십시오. [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html)에서 패키지를 다운로드 및 설치할 수 있습니다.
    ```java
    $ npm install -g cordova
    $ cordova –version
    7.0.1
    ```

    >**참고**: `$ npm install -g cordova` 명령 실행 중에 권한 문제가 발생하는 경우 높은 권한을 사용하여 설치하십시오(`$ sudo npm install -g cordova`).

3. **ionic**을 설치하십시오. [ionic](https://ionicframework.com/docs/cli/)에서 패키지를 다운로드 및 설치할 수 있습니다.
    ```java
    $ npm install -g ionic
    $ ionic –version
    4.2.0
    ```

    >**참고**: `$ npm install -g ionic` 명령 실행 중에 권한 문제가 발생하는 경우 높은 권한을 사용하여 설치하십시오(`$ sudo npm install -g ionic`).

4. [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) 또는 [여기](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)에서 .dmg(**IBM.Digital.App.Builder-8.0.0.dmg**)를 다운로드하십시오.
5. .dmg 파일을 두 번 클릭하여 설치 프로그램을 마운트하십시오.
6. 설치 프로그램이 열리는 창에서 IBM Digital App Builder를 **애플리케이션** 폴더에 끌어서 놓기하십시오.
7. IBM Digital App Builder 아이콘 또는 실행 파일을 두 번 클릭하여 Digital App Builder를 여십시오.
>**참고**: Digital App Builder가 처음으로 설치되면 Digital App Builder는 인터페이스를 열고 [필수 소프트웨어 확인](#prerequisites-check)을 수행합니다. 오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

### Windows에 설치
{: #installing-on-windows }

관리 모드에서 열린 명령 프롬프트에서 다음 명령을 실행하십시오.

1. [https://nodejs.org/en/download](https://nodejs.org/en/download)(Node.js 8.x 이상)에서 설치를 다운로드하여 **Node.js** 및 **npm**을 설치하십시오. 설치 지시사항에 대한 자세한 정보는 [여기](https://nodejs.org/en/download/package-manager/)를 참조하십시오. 아래에 표시되는 대로 노드 및 npm 버전을 확인하십시오. 

    ```java
    C:\>node -v
    v8.10.0
    C:\>npm -v
    6.4.1
    ```

2. **Cordova**를 설치하십시오. [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html)에서 패키지를 다운로드 및 설치할 수 있습니다.

    ```java
    C:\>npm install -g cordova
    C:\>cordova –v
    7.0.1
    ```

3. **ionic**을 설치하십시오. [ionic](https://ionicframework.com/docs/cli/)에서 패키지를 다운로드 및 설치할 수 있습니다.

    ```java
    C:\>npm install -g ionic
    C:\> ionic –version
    4.2.0
    ``` 

4. [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) 또는 [여기](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)에서 .exe(**IBM.Digital.App.Builder.Setup.8.0.0.exe**)를 다운로드하십시오.
5. 설치할 Digital App Builder 실행 파일을 두 번 클릭하십시오. 데스크탑의 **시작 > 프로그램**에 바로가기가 작성됩니다. 기본 설치 폴더는 `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.0`입니다.
>**참고**: Digital App Builder가 처음으로 설치되면 Digital App Builder는 인터페이스를 열고 [필수 소프트웨어 확인](#prerequisites-check)을 수행합니다. 오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

### 필수 소프트웨어 확인
{: #prerequisites-check }

앱을 개발하기 전에 **도움말 > 필수 소프트웨어 확인**을 선택하여 필수 소프트웨어 확인을 수행할 수 있습니다.

![필수 소프트웨어 확인](dab-prerequsites-check.png)

오류의 경우 앱을 작성하기 전에 오류를 수정하고 Digital App Builder를 다시 시작하십시오.

>**참고**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods)는 MacOS에만 필요합니다.

