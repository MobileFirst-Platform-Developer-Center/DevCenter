---
layout: tutorial
title: IBM Installation Manager 실행
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM  Installation Manager는 컴퓨터에 {{ site.data.keys.mf_server_full }} 파일 및 도구를 설치합니다. 

Installation Manager를 실행하여 {{ site.data.keys.mf_server }}의 2진 파일과 사용하는 컴퓨터의 애플리케이션 서버에 {{ site.data.keys.mf_server }} 애플리케이션을 배치하는 도구를 설치합니다. 설치 프로그램에 의해 설치되는 파일 및 도구에 대해서는 [{{ site.data.keys.mf_server }}의 배포 구조](#distribution-structure-of-mobilefirst-server)에 설명되어 있습니다. 

{{ site.data.keys.mf_server }} 설치 프로그램을 실행하려면 IBM Installation Manager V1.8.4 이상이 필요합니다. 그래픽 모드 또는 명령행 모드에서 이를 실행할 수 있습니다.  
설치 프로세스 동안 두 개의 기본 옵션이 제안됩니다.

* 토큰 라이센싱의 활성화
* {{ site.data.keys.mf_app_center }}의 설치 및 배치

### 토큰 라이센싱
{: #token-licensing }
토큰 라이센싱은 {{ site.data.keys.mf_server }}에 의해 지원되는 두 가지 라이센싱 방법 중 하나입니다. 토큰 라이센싱 활성화가 필요한지 여부를 판별해야 합니다. Rational  License Key Server에서의 토큰 라이센싱 사용을 정의하는 계약이 없는 경우에는 토큰 라이센싱을 활성화하지 마십시오. 토큰 라이센싱을 활성화하는 경우, {{ site.data.keys.mf_server }}를 토큰 라이센싱용으로 구성해야 합니다. 자세한 정보는 [토큰 라이센싱을 위한 설치 및 구성](../token-licensing)을 참조하십시오.

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Application Center는 {{ site.data.keys.product }}의 컴포넌트입니다. Application Center를 사용하면 조직 내에서 개발 중인 모바일 애플리케이션을 모바일 애플리케이션의 단일 저장소에서 공유할 수 있습니다. 

Installation Manager를 사용하여 Application Center를 설치하기로 선택하는 경우, Installation Manager에서 데이터베이스를 구성하고 Application Center를 애플리케이션 서버에 배치하도록 데이터베이스 및 애플리케이션 서버 매개변수를 제공해야 합니다. Installation Manager를 사용하여 Application Center를 설치하지 않기로 선택하는 경우, Installation Manager는 Application Center의 WAR 파일 및 자원을 디스크에 저장합니다. 데이터베이스를 설정하지 않으며 애플리케이션 서버에 Application Center WAR 파일을 배치하지도 않습니다. 이러한 작업은 나중에 Ant 태스크를 사용하거나 수동으로 수행할 수 있습니다. Application Center를 설치하는 이 옵션은 설치 프로세스 동안 그래픽 설치 마법사의 안내를 받으므로 Application Center를 검색하기 위한 편리한 방법입니다. 

그러나 프로덕션 설치의 경우 Ant 태스크를 사용하여 Application Center를 설치하십시오. Ant 태스크를 사용하여 설치하면 {{ site.data.keys.mf_server }}에 대한 업데이트를 Application Center에 대한 업데이트에서 분리할 수 있습니다. 

* Installation Manager를 사용하여 Application Center를 설치할 때의 장점
    * 설치 및 배치 프로세스 동안 그래픽 마법사의 안내를 받습니다. 
* Installation Manager를 사용하여 Application Center를 설치할 때의 단점
    * Installation Manager가 UNIX 또는 Linux에서 루트 사용자로 실행되는 경우, Application Center가 배치되는 애플리케이션 서버의 디렉토리에 루트가 소유하는 파일이 작성될 수 있습니다. 결과적으로 애플리케이션 서버를 루트로서 실행해야 합니다.
    * 데이터베이스 스크립트에 액세스할 수 없기 때문에 설치 프로시저를 실행하기 전 테이블을 작성하는 데 필요한 데이터베이스 스크립트를 데이터베이스 관리자에게 제공할 수 없습니다. Installation Manager가 기본 설정을 사용하여 데이터베이스 테이블을 작성합니다. 
    * 제품을 업그레이드할 때마다(예를 들어, 임시 수정사항을 설치하기 위해) Application Center가 먼저 업그레이드됩니다. Application Center의 업그레이드에는 데이터베이스 및 애플리케이션 서버에 대한 조작이 포함됩니다. Application Center의 업그레이드에 실패하면 Installation Manager가 업그레이드를 완료하지 못하며, 따라서 기타 {{ site.data.keys.mf_server }} 컴포넌트도 업그레이드하지 못합니다. 프로덕션 설치의 경우, Installation Manager를 사용하여 Application Center를 배치하지 마십시오. Installation Manager에 의해 {{ site.data.keys.mf_server }}가 설치된 후 Ant 태스크를 사용하여 Application Center를 별도로 설치하십시오. Application Center에 대한 자세한 정보는 [Application Center 설치 및 구성](../../../appcenter)을 참조하십시오. 

> **중요:** {{ site.data.keys.mf_server }} 설치 프로그램은 사용하는 디스크에 {{ site.data.keys.mf_server }} 2진 파일 및 도구만 설치합니다. {{ site.data.keys.mf_server }} 애플리케이션을 애플리케이션 서버에 배치하지는 않습니다. Installation Manager를 사용하여 설치를 실행한 후, 데이터베이스를 설정하고 {{ site.data.keys.mf_server }} 애플리케이션을 애플리케이션 서버에 배치해야 합니다.   
> 이와 마찬가지로, 기존 설치를 업데이트하기 위해 Installation Manager를 실행하는 경우 디스크의 파일만 업데이트합니다. 애플리케이션 서버에 배치된 애플리케이션을 업데이트하려면 추가 조치를 수행해야 합니다.



#### 다음으로 이동
{: #jump-to }
* [관리자 모드 대 사용자 모드](#administrator-versus-user-mode)
* [IBM Installation Manager 설치 마법사를 사용하여 설치](#installing-by-using-ibm-installation-manager-install-wizard)
* [명령행에서 IBM Installation Manager를 실행하여 설치](#installing-by-running-ibm-installation-manager-in-command-line)
* [XML 응답 파일을 사용하여 설치 - 자동 설치](#installing-by-using-xml-response-files---silent-installation)
* [{{ site.data.keys.mf_server }}의 배포 구조](#distribution-structure-of-mobilefirst-server)

## 관리자 모드 대 사용자 모드
{: #administrator-versus-user-mode }
서로 다른 두 가지 IBM  Installation Manager 모드에서 {{ site.data.keys.mf_server }}를 설치할 수 있습니다. 모드는 IBM Installation Manager 자체의 설치 방법에 따라 달라집니다. 이 모드에 의해 Installation Manager 및 패키지 둘 다에 사용되는 디렉토리 및 명령이 결정됩니다. 

{{ site.data.keys.product }}에서는 다음과 같은 두 가지 Installation Manager 모드를 지원합니다.

* 관리자 모드
* 사용자(비관리자) 모드

Linux 또는 UNIX에서 사용 가능한 그룹 모드는 이 제품에서 지원되지 않습니다. 

### 관리자 모드
{: #administrator-mode }
관리자 모드의 경우, Linux 또는 UNIX에서는 Installation Manager를 루트로 실행하고 Windows에서는 관리자 권한을 사용하여 Installation Manager를 실행해야 합니다. Installation Manager의 저장소 파일(설치된 소프트웨어 및 해당 버전 목록)은 시스템 디렉토리에 설치됩니다. Linux 또는 UNIX의 경우 /var/ibm이고 Windows의 경우 ProgramData입니다. 관리자 모드에서 Installation Manager를 실행하는 경우에는 Installation Manager를 사용하여 Application Center를 배치하지 마십시오. 

### 사용자(비관리자) 모드
{: #user-nonadministrator-mode }
사용자 모드에서는 특정 권한이 없는 임의의 사용자가 Installation Manager를 실행할 수 있습니다. 단, Installation Manager의 저장소 파일은 해당 사용자의 홈 디렉토리에 저장됩니다. 해당 사용자만 제품의 설치를 업그레이드할 수 있습니다. Installation Manager를 루트로 실행하지 않는 경우, 나중에 제품 설치를 업그레이드하거나 임시 수정사항을 적용할 때 사용할 수 있는 사용자 계정이 있는지 확인하십시오. 

Installation Manager 모드에 대한 자세한 정보는 IBM Installation Manager 문서에서 [관리자, 비관리자 또는 그룹으로 설치](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc)를 참조하십시오. 

## IBM Installation Manager 설치 마법사를 사용하여 설치
{: #installing-by-using-ibm-installation-manager-install-wizard }
다음 프로시저의 단계에 따라 {{ site.data.keys.mf_server }}의 자원과 도구(예: Server Configuration Tool, Ant 및 mfpadm 프로그램)를 설치하십시오.   
설치 마법사에서 다음 두 분할창의 의사결정은 필수입니다.

* **일반 설정** 패널
* Application Center를 설치하기 위한 **구성 선택** 패널

1. Installation Manager를 실행하십시오.
2. Installation Manager에서 {{ site.data.keys.mf_server }}의 저장소를 추가하십시오.
    * **파일 → 환경 설정**으로 이동하여 **저장소 추가...**를 클릭하십시오.
    * 설치 프로그램이 추출된 디렉토리에서 저장소 파일을 찾아보십시오.

        {{ site.data.keys.mf_server }}의 {{ site.data.keys.product }} V8.0 .zip 파일을 **mfp\_installer\_directory** 폴더에 압축 해제하는 경우 저장소 파일은 **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**에 있습니다. 

        [IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)에서 다운로드할 수 있는 최신 수정팩을 적용할 수도 있습니다. 수정팩에 대한 저장소를 입력하십시오. **fixpack_directory** 폴더에 수정팩의 압축을 풀면 저장소 파일은 **fixpack\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**에 있습니다. 

        **참고:** Installation Manager의 저장소에 기본 버전의 저장소가 없으면 수정팩을 설치할 수 없습니다. 수정팩은 증분식 설치 프로그램이므로 설치하려면 기본 버전의 저장소가 있어야 합니다.
    * 이 파일을 선택하고 **확인**을 클릭하십시오.
    * **확인**을 클릭하여 **환경 설정** 패널을 닫으십시오.
3. 제품의 라이센스 조항에 동의한 후 **다음**을 클릭하십시오.
4. 제품을 설치하기 위한 패키지 그룹을 선택하십시오.

    {{ site.data.keys.product }} V8.0은 다음과 같은 다른 설치 이름을 가진 이전 릴리스를 대체합니다.
    * Worklight for V5.0.6
    * IBM Worklight for V6.0에서 V6.3
    
    사용하는 컴퓨터에 이러한 이전 제품 버전 중 하나가 설치되어 있는 경우, Installation Manager는 설치 프로세스 시작 시 기존 패키지 그룹 사용 옵션을 제공합니다. 이 옵션은 이전 제품 버전을 설치 제거하고 이전 설치 옵션을 재사용하여 {{ site.data.keys.mf_app_center_full }}(설치된 경우)를 업그레이드합니다. 
    
    별도 설치인 경우, 이전 버전과 함께 새 버전을 설치할 수 있도록 새 패키지 그룹 작성 옵션을 선택하십시오.  
    컴퓨터에 제품의 다른 버전이 설치되어 있지 않으면 새 패키지 그룹 작성 옵션을 선택하여 새 패키지 그룹에 제품을 설치하십시오. 
    
5. **다음**을 클릭하십시오.
6. **일반 설정** 패널의 **토큰 라이센싱 활성화** 섹션에서 토큰 라이센싱 활성화 여부를 결정하십시오.

    Rational  License Key Server에서 토큰 라이센싱을 사용하는 계약이 있는 경우, **Rational License Key Server에서 토큰 라이센싱 활성화** 옵션을 선택하십시오. 토큰 라이센싱을 활성화한 후에는 추가 단계를 수행하여 {{ site.data.keys.mf_server }}를 구성해야 합니다. 그렇지 않은 경우에는 **Rational License Key Server에서 토큰 라이센싱을 활성화하지 않음** 옵션을 선택하여 다음 작업으로 진행하십시오.
7. **일반 설정** 패널의 **{{ site.data.keys.product }} for iOS 설치** 섹션에서 기본 옵션(아니오)을 그대로 두십시오. 
8. **구성 선택** 패널에서 Application Center의 설치 여부를 결정하십시오. 

    프로덕션 설치의 경우, Ant 태스크를 사용하여 Application Center를 설치하십시오. Ant 태스크를 사용하여 설치하면 {{ site.data.keys.mf_server }}에 대한 업데이트를 Application Center에 대한 업데이트에서 분리할 수 있습니다. 이 경우에는 Application Center가 설치되지 않도록 구성 선택 패널에서 아니오 옵션을 선택하십시오. 

    예를 선택하는 경우, 다음 분할창에서 사용할 예정인 데이터베이스에 대한 세부사항과 Application Center를 배치할 예정인 애플리케이션 서버에 대한 세부사항을 입력해야 합니다. 또한 해당 데이터베이스의 JDBC 드라이버도 사용 가능하도록 해야 합니다.
9. **감사** 패널이 표시될 때까지 **다음**을 클릭하십시오. 그런 다음 설치를 계속하십시오.

{{ site.data.keys.product_adj }} 컴포넌트를 설치하기 위한 자원이 포함된 설치 디렉토리가 설치됩니다.

다음 폴더에서 자원을 찾을 수 있습니다.

* {{ site.data.keys.mf_server }}에 대한 **MobileFirstServer** 폴더
* {{ site.data.keys.mf_server }} 푸시 서비스에 대한 **PushService** 폴더
* Application Center에 대한 **ApplicationCenter** 폴더
* {{ site.data.keys.mf_analytics }}에 대한 **Analytics** 폴더

또한 **shortcuts** 폴더에서 Server Configuration Tool, Ant 및 mfpadm 프로그램의 단축 아이콘도 제공됩니다. 

## 명령행에서 IBM Installation Manager를 실행하여 설치
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. {{ site.data.keys.mf_server }}에 대한 라이센스 계약을 검토하십시오. Passport Advantage에서 설치 저장소를 다운로드할 때 라이센스 파일을 볼 수 있습니다. 
2. 다운로드한 {{ site.data.keys.mf_server }} 저장소의 압축 파일을 폴더에 추출하십시오.

    [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm)의 {{ site.data.keys.product }} eAssembly에서 이 저장소를 다운로드할 수 있습니다. 이 팩의 이름은 **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**입니다. 

    이후 단계에서, 설치 프로그램을 추출하는 디렉토리는 **mfp\_repository\_dir**로 참조됩니다. 여기에는 **MobileFirst\_Platform\_Server/disk1** 폴더가 있습니다.
3. 명령행을 시작하여 **installation\_manager\_install\_dir/tools/eclipse/**로 이동하십시오.

    1단계에서 검토 후 라이센스 계약에 동의했으면 {{ site.data.keys.mf_server }}를 설치하십시오. 
    * 토큰 라이센싱이 적용되지 않는 설치의 경우(토큰 라이센싱 사용을 정의하는 계약이 없는 경우) 다음 명령을 입력하십시오. 

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * 토큰 라이센싱이 적용되는 설치의 경우 다음 명령을 입력하십시오. 
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        **user.licensed.by.tokens** 특성의 값이 **true**로 설정됩니다. {{ site.data.keys.mf_server }}를 [토큰 라이센싱](../token-licensing)용으로 구성해야 합니다. 
        
        Application Center를 설치하지 않고 {{ site.data.keys.mf_server }}를 설치하는 경우에는 다음 특성을 설정합니다. 
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        **user.licensed.by.tokens=true/false** 특성은 토큰 라이센싱이 활성화되는지 여부를 표시합니다. 
        
        {{ site.data.keys.product }}을 설치하려면 user.use.ios.edition 특성의 값을 false로 설정하십시오. 
        
5. 최신 임시 수정사항도 함께 설치하려면 **-repositories** 매개변수에 임시 수정사항 저장소를 추가하십시오. **-repositories** 매개변수는 쉼표로 구분된 저장소 목록을 사용합니다.

    **com.ibm.mobilefirst.foundation.server**를 **com.ibm.mobilefirst.foundation.server_version**으로 대체하여 임시 수정사항의 버전을 추가하십시오. **version**의 양식은 **8.0.0.0-buildNumber**입니다. 예를 들어, 임시 수정사항 **8.0.0.0-IF20160103101**5를 설치하는 경우에는 다음 명령을 입력하십시오. `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`.
    
    imcl 명령에 대한 자세한 정보는 [Installation Manager: `imcl` 명령을 사용하여 패키지 설치](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en)를 참조하십시오. 
    
{{ site.data.keys.product_adj }} 컴포넌트를 설치하기 위한 자원이 포함된 설치 디렉토리가 설치됩니다.

다음 폴더에서 자원을 찾을 수 있습니다.

* {{ site.data.keys.mf_server }}에 대한 **MobileFirstServer** 폴더
* {{ site.data.keys.mf_server }} 푸시 서비스에 대한 **PushService** 폴더
* Application Center에 대한 **ApplicationCenter** 폴더
* {{ site.data.keys.mf_analytics }}에 대한 **Analytics** 폴더    

또한 **shortcuts** 폴더에서 Server Configuration Tool, Ant 및 mfpadm 프로그램의 단축 아이콘도 제공됩니다. 

## XML 응답 파일을 사용하여 설치 - 자동 설치
{: #installing-by-using-xml-response-files---silent-installation }
명령행에서 IBM Installation Manager를 사용하여 {{ site.data.keys.mf_app_center_full }}를 설치하려면 광범위한 인수 목록을 제공해야 합니다. 이 경우, XML 응답 파일을 사용하여 해당 인수를 제공하십시오.

자동 설치는 응답 파일이라고 하는 XML 파일에 의해 정의됩니다. 이 파일에는 자동으로 설치 작업을 완료하는 데 필요한 데이터가 포함되어 있습니다. 자동 설치는 명령행 또는 일괄처리 파일에서 시작됩니다. 

Installation Manager를 사용하여 응답 파일용 환경 설정 및 설치 조치를 사용자 인터페이스 모드에서 기록할 수 있습니다. 또는 문서화된 응답 파일 명령 및 환경 설정 목록을 사용하여 수동으로 응답 파일을 작성할 수도 있습니다. 

자동 설치는 Installation Manager 사용자 문서에 설명되어 있습니다. [자동 모드로 작업](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html)을 참조하십시오.

다음 두 가지 방법으로 적합한 응답 파일을 작성할 수 있습니다. 

* {{ site.data.keys.product_adj }} 사용자 문서에서 제공된 샘플 응답 파일로 작업.
* 다른 컴퓨터에 기록된 응답 파일로 작업.

이 두 가지 방법에 대해서는 다음 절에 설명되어 있습니다. 

### IBM Installation Manager용 샘플 응답 파일로 작업
{: #working-with-sample-response-files-for-ibm-installation-manager }
IBM Installation Manager용 샘플 응답 파일은 **Silent\_Install\_Sample_Files.zip** 압축 파일에서 제공됩니다. 다음 프로시저는 이러한 샘플을 사용하는 방법에 대해 설명합니다. 

1. 압축 파일에서 해당 샘플 응답 파일을 선택하십시오. Silent_Install_Sample_Files.zip 파일에는 릴리스당 하나의 서브디렉토리가 포함되어 있습니다. 

    > **중요:**  
    > 
    > * 애플리케이션 서버에 Application Center를 설치하지 않는 설치의 경우, **install-no-appcenter.xml**이라는 파일을 사용하십시오.

    > * Application Center를 설치하는 설치의 경우, 애플리케이션 서버 및 데이터베이스에 따라 다음 표에서 샘플 응답 파일을 선택하십시오.

   #### Application Center를 설치하는 **Silent\_Install\_Sample_Files.zip** 파일의 샘플 설치 응답 파일
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Application Center를 설치하는 애플리케이션 서버</th>
            <th>Derby</th>
            <th>IBM DB2 </th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere  Application Server Liberty 프로파일</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml(참고 참조)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server 전체 프로파일, 독립형 서버</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml(참고 참조)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>n/a</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml(참고 참조), install-wasnd-server-mysql.xml(참고 참조), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml(참고 참조)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>
    
    > **참고:** MySQL과 WebSphere Application Server Liberty 프로파일 또는 WebSphere Application Server 전체 프로파일의 조합은 지원되는 구성으로 분류되지 않습니다. 자세한 정보는 [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)를 참조하십시오. IBM DB2를 사용하거나 WebSphere Application Server에서 지원하는 다른 DBMS를 사용하여 IBM 지원 센터에서 완전하게 지원하는 구성의 이점을 활용할 수 있습니다.



    설치 제거하는 경우, 처음에 특정 패키지 그룹에 설치한 {{ site.data.keys.mf_server }} 또는 Worklight Server의 버전에 따른 샘플 파일을 사용하십시오. 
    
    * {{ site.data.keys.mf_server }}에서는 패키지 그룹 {{ site.data.keys.mf_server }}를 사용합니다. 
    * Worklight Server V6.x 이상에서는 패키지 그룹 IBM Worklight를 사용합니다. 
    * Worklight Server V5.x에서는 패키지 그룹 Worklight를 사용합니다. 

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>{{ site.data.keys.mf_server }}의 초기 버전</th>
            <th>샘플 파일</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server V6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server V6.x 이상</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. 샘플 파일의 파일 액세스 권한을 가능하면 제한적으로 변경하십시오. 4단계에서 일부 비밀번호를 제공해야 합니다. 동일한 컴퓨터의 다른 사용자가 이러한 비밀번호를 모르게 하려면 본인 외의 사용자에 대해 파일의 읽기 권한을 제거해야 합니다. 다음 예와 같이 명령을 사용할 수 있습니다. 
    * UNIX의 경우: `chmod 600 <target-file.xml>`
    * Windows의 경우: `cacls <target-file.xml> /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 마찬가지로, 서버가 WebSphere Application Server Liberty 프로파일 또는 Apache Tomcat 서버이고 사용하는 사용자 계정에서만 시작되도록 설정된 경우, 다음 파일에서도 본인 외의 사용자에 대해 읽기 권한을 제거해야 합니다. 
    * WebSphere Application Server Liberty 프로파일의 경우: `wlp/usr/servers/<server>/server.xml`
    * Apache Tomcat의 경우: `conf/server.xml`
4. <server> 요소의 저장소 목록을 조정하십시오. 이 단계에 대한 자세한 정보는 [저장소](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html)에 있는 IBM Installation Manager 문서를 참조하십시오. 

    `<profile>` 요소에서 각 키/값 쌍의 값을 조정하십시오.  
    `<offering>` 요소(`<install>` 요소에 있음)에서 설치하려는 릴리스와 일치하도록 버전 속성을 설정하거나, 저장소에 있는 최신 버전을 설치하려는 경우, 버전 속성을 제거하십시오.
5. 다음 명령을 입력하십시오. `<InstallationManagerPath>/eclipse/tools/imcl input <responseFile>  -log /tmp/installwl.log -acceptLicense`

    여기서:
    * `<InstallationManagerPath>`는 IBM Installation Manager의 설치 디렉토리입니다. 
    * `<responseFile>`은 1단계에서 선택하고 업데이트한 파일의 이름입니다.

> 자세한 정보는 [응답 파일을 사용하여 패키지 자동 설치](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)에 있는 IBM Installation Manager 문서를 참조하십시오.

    

### 다른 머신에 기록된 응답 파일로 작업
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. GUI가 사용 가능한 머신에서 `-record responseFile` 옵션을 지정하여 마법사 모드로 IBM Installation Manager를 실행하여 응답 파일을 기록하십시오. 세부사항은 [Installation Manager로 응답 파일 기록](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html)을 참조하십시오.
2. 응답 파일의 파일 액세스 권한을 가능한 한 제한적으로 변경하십시오. 4단계에서 일부 비밀번호를 제공해야 합니다. 동일한 컴퓨터의 다른 사용자가 이러한 비밀번호를 모르게 하려면 본인 외의 사용자에 대해 파일의 **읽기** 권한을 제거해야 합니다. 다음 예와 같이 명령을 사용할 수 있습니다. 
    * UNIX의 경우: `chmod 600 response-file.xml`
    * Windows의 경우: `cacls response-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. 마찬가지로, 서버가 WebSphere  Application Server Liberty 또는 Apache Tomcat 서버이고 사용하는 사용자 계정에서만 시작되도록 설정된 경우, 다음 파일에서도 본인 외의 사용자에 대해 읽기 권한을 제거해야 합니다. 
    * WebSphere Application Server Liberty의 경우: `wlp/usr/servers/<server>/server.xml`
    * Apache Tomcat의 경우: `conf/server.xml`
4. 응답 파일이 작성된 머신과 대상 머신 사이의 차이를 고려하도록 응답 파일을 수정하십시오. 
5. [응답 파일을 사용하여 패키지 자동 설치](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html)에 설명된 대로 응답 파일을 사용하여 대상 머신에 {{ site.data.keys.mf_server }}를 설치하십시오. 

### 명령행(자동 설치) 매개변수
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>키</th>
        <th>필요한 경우</th>
        <th>설명</th>
        <th>허용되는 값</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>항상</td>
        <td>{{ site.data.keys.product }}을 설치할 계획인 경우 값을 <code>false</code>로 설정하십시오. iOS 에디션용 제품을 설치할 계획이면 값을 <code>true</code>로 설정해야 합니다. </td>
        <td><code>true</code> 또는 <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>항상</td>
        <td>토큰 라이센싱의 활성화. 제품을 Rational  License Key Server와 함께 사용할 계획인 경우 토큰 라이센싱을 활성화해야 합니다. <br/><br/>이 경우에는 값을 <code>true</code>로 설정하십시오. 제품을 Rational License Key Server와 함께 사용할 계획이 아니면 값을 <code>false</code>로 설정하십시오. <br/><br/>라이센스 토큰을 활성화하는 경우, 애플리케이션 서버에 제품을 배치한 후에 특정 구성 단계를 수행해야 합니다. </td>
        <td><code>true</code> 또는 <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>항상</td>
        <td>애플리케이션 서버의 유형입니다. was는 사전 설치된 WebSphere  Application Server 8.5.5를 의미합니다. tomcat은 Tomcat 7.0을 의미합니다. </td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>WebSphere Application Server 설치 디렉토리입니다. </td>
        <td>절대 디렉토리 이름.</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>애플리케이션을 설치하는 프로파일입니다. WebSphere Application Server Network Deployment의 경우 Deployment Manager 프로파일을 지정하십시오. Liberty는 Liberty 프로파일(서브디렉토리 wlp)을 의미합니다.</td>
        <td>WebSphere Application Server 프로파일 중 하나의 이름.</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>애플리케이션을 설치하는 WebSphere Application Server 셀입니다.</td>
        <td>WebSphere Application Server 셀의 이름. </td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>애플리케이션을 설치하는 WebSphere Application Server 노드입니다. 현재 머신에 해당합니다.</td>
        <td>현재 머신의 WebSphere Application Server 노드 이름.</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
        <td>애플리케이션을 설치하는 서버 세트의 유형입니다. <br/><br/><code>server</code>는 독립형 서버를 의미합니다. <br/><br/><code>nd-cell</code>은 WebSphere Application Server Network Deployment 셀을 의미합니다. <code>nd-cluster</code>은 WebSphere Application Server Network Deployment 클러스터를 의미합니다. <br/><br/><code>nd-node</code>는 WebSphere Application Server Network Deployment 노드(클러스터 제외)를 의미합니다. <br/><br/><code>nd-server</code>는 관리되는 WebSphere Application Server Network Deployment 서버를 의미합니다. </td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == server</td>
      <td>애플리케이션을 설치하는 WebSphere Application Server 서버의 이름입니다.</td>
      <td>현재 머신의 WebSphere Application Server 서버 이름.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-cluster</td>
      <td>애플리케이션을 설치하는 WebSphere Application Server Network Deployment 클러스터의 이름입니다. </td>
      <td>WebSphere Application Server 셀에 있는 WebSphere Application Server Network Deployment 클러스터의 이름.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope} == nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>애플리케이션을 설치하는 WebSphere Application Server Network Deployment 노드의 이름입니다. </td>
      <td>WebSphere Application Server 셀에 있는 WebSphere Application Server Network Deployment 노드의 이름.</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope} == nd-server</td>
      <td>애플리케이션을 설치하는 WebSphere Application Server Network Deployment 서버의 이름입니다. </td>
      <td>지정된 WebSphere Application Server Network Deployment 노드에 있는 WebSphere Application Server Network Deployment 서버의 이름.</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 관리자의 이름입니다.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 관리자의 비밀번호입니다(선택적으로 특정 방식으로 암호화할 수 있음). </td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>WebSphere Application Server 사용자 목록에 추가할 <code>appcenteradmin</code> 사용자의 암호입니다(선택적으로 특정 방식으로 암호화할 수 있음).</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} != Liberty</td>
      <td>설치되는 애플리케이션을 {{ site.data.keys.mf_server }}의 다른 설치와 구별하는 접미부입니다.</td>
      <td>10자리 십진수 문자열.</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was && ${user.appserver.was.profile} == Liberty</td>
      <td>애플리케이션을 설치하는 WebSphere Application Server Liberty 서버의 이름입니다.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Apache Tomcat 설치 디렉토리입니다. <b>CATALINA_HOME</b> 디렉토리와 <b>CATALINA_BASE</b> 디렉토리가 분리되는 Tomcat 설치의 경우, 여기서 <b>CATALINA_BASE</b> 환경 변수의 값을 지정해야 합니다.</td>
      <td>절대 디렉토리 이름.</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>항상</td>
      <td>데이터베이스를 저장하는 데 사용되는 데이터베이스 관리 시스템의 유형입니다.</td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. none 값은 설치 프로그램이 Application Center를 설치하지 않음을 의미합니다. 이 값을 사용하는 경우, <b>user.appserver.selection2</b> 및 <b>user.database.selection2</b>가 모두 none 값을 사용해야 합니다. </td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>항상</td>
      <td><code>true</code>는 사전 설치된 데이터베이스 관리 시스템을 의미하며, <code>false</code>는 Apache Derby를 설치함을 의미합니다.</td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>Derby 데이터베이스를 작성하거나 가정하는 디렉토리입니다. </td>
      <td>절대 디렉토리 이름.</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 데이터베이스 서버의 호스트 이름 또는 IP 주소입니다.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 데이터베이스 서버가 JDBC 연결을 청취하는 포트입니다. 보통 50000입니다.</td>
      <td>1과 65535 사이의 수.</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>db2jcc4.jar의 절대 파일 이름입니다.</td>
      <td>절대 파일 이름.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center용 DB2 데이터베이스에 액세스하는 데 사용되는 사용자 이름입니다.</td>
      <td>비어 있지 않음.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center용 DB2 데이터베이스에 액세스하는 데 사용되는 비밀번호입니다(선택적으로 특정 방식으로 암호화할 수 있음). </td>
      <td>비어 있지 않은 비밀번호.</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>Application Center용 DB2 데이터베이스의 이름입니다. </td>
      <td>비어 있지 않음, 유효한 DB2 데이터베이스 이름.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>선택사항</td>
      <td><b>user.database.mysql.appcenter.dbname</b>이 서비스 이름인지 또는 SID 이름인지 여부를 표시합니다. 이 매개변수가 누락된 경우 <b>user.database.mysql.appcenter.dbname</b>은 SID 이름으로 간주됩니다. </td>
      <td><code>true</code>(서비스 이름을 표시함) 또는 <code>false</code>(SID 이름을 표시함)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>DB2 데이터베이스에 있는 Application Center에 대한 스키마의 이름입니다. </td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>MySQL 데이터베이스 서버의 호스트 이름 또는 IP 주소입니다.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>MySQL 데이터베이스 서버가 JDBC 연결을 청취하는 포트입니다. 보통 3306입니다.</td>
      <td>1과 65535 사이의 수.</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td><b>mysql-connector-java-5.*-bin.jar</b>의 절대 파일 이름입니다.</td>
      <td>절대 파일 이름.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center용 Oracle 데이터베이스에 액세스하는 데 사용되는 사용자 이름입니다. </td>
      <td>1-30자로 구성된 문자열. ASCII 숫자, ASCII 대문자 및 소문자, '_', '#', '$'가 허용됩니다.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center용 Oracle 데이터베이스에 액세스하는 데 사용되는 비밀번호입니다(선택적으로 특정 방식으로 암호화할 수 있음).</td>
      <td>비밀번호는 1-30자로 구성된 문자열이어야 합니다. ASCII 숫자, ASCII 대문자 및 소문자, '_', '#', '$'가 허용됩니다.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle(${user.database.oracle.appcenter.jdbc.url}을 지정하지 않은 경우에 한함)</td>
      <td>Application Center용 Oracle 데이터베이스의 이름입니다.</td>
      <td>비어 있지 않음, 유효한 Oracle 데이터베이스 이름.</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle(${user.database.oracle.appcenter.jdbc.url}을 지정하지 않은 경우에 한함)</td>
      <td>Oracle 데이터베이스 서버의 호스트 이름 또는 IP 주소입니다.</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle(${user.database.oracle.appcenter.jdbc.url}을 지정하지 않은 경우에 한함)</td>
      <td>Oracle 데이터베이스 서버가 JDBC 연결을 청취하는 포트입니다. 보통 1521입니다.</td>
      <td>1과 65535 사이의 수.</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Oracle 씬 드라이버 JAR 파일의 절대 파일 이름입니다. (<b>ojdbc6.jar 또는 ojdbc7.jar</b>)</td>
      <td>절대 파일 이름.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center용 Oracle 데이터베이스에 액세스하는 데 사용되는 사용자 이름입니다. </td>
      <td>1-30자로 구성된 문자열. ASCII 숫자, ASCII 대문자 및 소문자, '_', '#', '$'가 허용됩니다.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>Application Center용 Oracle 데이터베이스에 액세스하는 데 사용되는, JDBC에 적합한 구문의 사용자 이름입니다. </td>
      <td>영문자로 시작하고 소문자를 포함하지 않는 경우 ${user.database.oracle.appcenter.username}과 동일하고, 그렇지 않은 경우 큰따옴표로 묶인 ${user.database.oracle.appcenter.username}이어야 합니다. </td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Application Center용 Oracle 데이터베이스에 액세스하는 데 사용되는 비밀번호입니다(선택적으로 특정 방식으로 암호화할 수 있음).</td>
      <td>비밀번호는 1-30자로 구성된 문자열이어야 합니다. ASCII 숫자, ASCII 대문자 및 소문자, '_', '#', '$'가 허용됩니다.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle(${user.database.oracle.appcenter.jdbc.url}을 지정하지 않은 경우에 한함)</td>
      <td>Application Center용 Oracle 데이터베이스의 이름입니다.</td>
      <td>비어 있지 않음, 유효한 Oracle 데이터베이스 이름.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>선택사항</td>
      <td><code>user.database.oracle.appcenter.dbname</code>이 서비스 이름인지 또는 SID 이름인지 여부를 표시합니다. 이 매개변수가 누락된 경우 <code>user.database.oracle.appcenter.dbname</code>은 SID 이름으로 간주됩니다. </td>
      <td><code>true</code>(서비스 이름을 표시함) 또는 <code>false</code>(SID 이름을 표시함)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle(${user.database.oracle.host}, ${user.database.oracle.port}, ${user.database.oracle.appcenter.dbname}을 모두 지정한 경우는 제외됨)</td>
      <td>Application Center용 Oracle 데이터베이스의 JDBC URL입니다. </td>
      <td>유효한 Oracle JDBC URL. "jdbc:oracle:"로 시작됩니다.</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>항상</td>
      <td>설치된 서버를 실행하도록 허용된 운영 체제 사용자입니다. </td>
      <td>운영 체제 사용자 이름 또는 비어 있음.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>항상</td>
      <td>설치된 서버를 실행하도록 허용된 운영 체제 사용자 그룹입니다.</td>
      <td>운영 체제 사용자 그룹 이름 또는 비어 있음.</td>
    </tr>
</table>

## {{ site.data.keys.mf_server }}의 배포 구조
{: #distribution-structure-of-mobilefirst-server }
{{ site.data.keys.mf_server }} 파일과 도구는 {{ site.data.keys.mf_server }} 설치 디렉토리에 설치됩니다. 

#### Analytics 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| 항목| 설명          |
|------|-------------|
| **analytics.ear** 및 **analytics-*.war** | {{ site.data.keys.mf_analytics }}를 설치하기 위한 EAR 및 WAR 파일.|
| **configuration-samples** | Ant 태스크를 사용하여 {{ site.data.keys.mf_analytics }}를 설치하기 위한 샘플 Ant 파일을 포함합니다.|

#### ApplicationCenter 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| 항목| 설명          |
|------|-------------|
| **configuration-samples** | Application Center를 설치하기 위한 샘플 Ant 파일을 포함합니다. Ant 태스크는 데이터베이스 테이블을 작성하고 애플리케이션 서버에 WAR 파일을 배치합니다.| 
| **console** | Application Center를 설치하기 위한 EAR 및 WAR 파일을 포함합니다. 이 EAR 파일은 IBM  PureApplication  System에 고유하게 사용됩니다.| 
| **databases** | Application Center용 테이블의 수동 작성에 사용되는 SQL 스크립트를 포함합니다. |
| **installer** | Application Center 클라이언트를 작성하기 위한 자원을 포함합니다. | 
| **tools** | Application Center의 도구. | 

#### {{ site.data.keys.mf_server }} 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| 항목| 설명          |
|------|-------------|
| **mfp-ant-deployer.jar** | {{ site.data.keys.mf_server }} Ant 태스크 세트. |
| **mfp-*.war** | {{ site.data.keys.mf_server }} 컴포넌트의 WAR 파일. |
| **configuration-samples** | Ant 태스크를 사용하여 {{ site.data.keys.mf_server }} 컴포넌트를 설치하기 위한 샘플 Ant 파일을 포함합니다.| 
| **ConfigurationTool** | Server Configuration Tool의 2진 파일을 포함합니다. 이 도구는 **mfp_server_install_dir/shortcuts**에서 실행됩니다.|
| **databases** | {{ site.data.keys.mf_server }} 컴포넌트({{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 구성 서비스 및 {{ site.data.keys.product_adj }} 런타임)용 테이블의 수동 작성에 사용되는 SQL 스크립트를 포함합니다.| 
| **external-server-libraries** |  다른 도구(인증 도구 및 OAuth 보안 도구 등)에 의해 사용되는 JAR 파일을 포함합니다.|

#### PushService 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| 항목| 설명          |
|------|-------------|
| **mfp-push-service.war** | {{ site.data.keys.mf_server }} 푸시 서비스를 설치하기 위한 WAR 파일.|
| **databases** | {{ site.data.keys.mf_server }} 푸시 서비스용 테이블의 수동 작성에 사용되는 SQL 스크립트를 포함합니다.| 

#### License 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-license-subdirectory }

| 항목| 설명          |
|------|-------------|
| **Text** | {{ site.data.keys.product }}에 대한 라이센스를 포함합니다.| 

#### {{ site.data.keys.mf_server }} 설치 디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| 항목| 설명          |
|------|-------------|
| **shortcuts** | {{ site.data.keys.mf_server }}와 함께 제공되는 Apache Ant용 실행기 스크립트, Server Configuration Tool 및 mfpadmin 명령.| 

#### tools 서브디렉토리의 파일 및 서브디렉토리
{: #files-and-subdirectories-in-the-tools-subdirectory }

| 항목| 설명          |
|------|-------------|
| **tools/apache-ant-version-number** | Server Configuration Tool에 의해 사용되는 Apache Ant의 2진 설치. 이는 Ant 태스크를 실행하는 데도 사용될 수 있습니다.| 
