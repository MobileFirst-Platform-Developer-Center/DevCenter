---
layout: tutorial
title: 그래픽 모드에서 MobileFirst Server 설치
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
그래픽 모드의 IBM  Installation Manager와 Server Configuration Tool을 사용하여 {{ site.data.keys.mf_server }}를 설치합니다.

#### 시작하기 전에
{: #before-you-begin }
* 다음 데이터베이스 중 하나와 지원되는 Java 버전이 설치되었는지 확인하십시오. 또한 사용하는 컴퓨터에서 이러한 데이터베이스에 해당하는 JDBC 드라이버도 사용 가능해야 합니다.
    * 지원되는 데이터베이스 목록의 DBMS(Database Management System):
        * DB2
        * MySQL
        * Oracle

        **중요:** 제품에 필요한 테이블을 작성할 수 있는 데이터베이스와 해당 데이터베이스에 테이블을 작성할 수 있는 데이터베이스 사용자가 있어야 합니다.

        이 튜토리얼에서 테이블을 작성하는 단계는 DB2를 대상으로 합니다. DB2 설치 프로그램은 [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm)에서 {{ site.data.keys.product }} eAssembly의 패키지로서 제공됩니다.  

* 사용하는 데이터베이스의 JDBC 드라이버:
    * DB2의 경우, DB2 JDBC 드라이버 유형 4를 사용하십시오.
    * MySQL의 경우, Connector/J JDBC 드라이버를 사용하십시오.
    * Oracle의 경우, Oracle 씬 JDBC 드라이버를 사용하십시오.

* Java 7 이상

* [Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142)에서 IBM Installation Manager V1.8.4 이상의 설치 프로그램을 다운로드하십시오.
* {{ site.data.keys.mf_server }}의 설치 저장소와 WebSphere  Application Server Liberty Core V8.5.5.3 이상의 설치 프로그램도 있어야 합니다. Passport Advantage의 {{ site.data.keys.product }} eAssembly에서 이러한 패키지를 다운로드하십시오.

**{{ site.data.keys.mf_server }} 설치 저장소**  
{{ site.data.keys.product }} V8.0 .zip file of Installation Manager Repository for {{ site.data.keys.mf_server }}

**WebSphere Application Server Liberty 프로파일**  
IBM WebSphere Application Server - Liberty Core V8.5.5.3 이상

다음 운영 체제 중 하나를 사용하고 있으면 그래픽 모드로 설치를 실행할 수 있습니다.

* Windows x86 또는 x86-64
* macOS x86-64
* Linux x86 또는 Linux x86-64

다른 운영 체제에서도 그래픽 모드에서 Installation Manager를 사용하여 설치를 실행할 수 있지만 Server Configuration Tool을 사용할 수 없습니다. Ant 태스크를 사용하여([명령행 모드에서 {{ site.data.keys.mf_server }} 설치](../command-line) 참조) {{ site.data.keys.mf_server }}를 Liberty 프로파일에 배치해야 합니다.

**참고:** 데이터베이스 설치 및 설정에 대해서는 이 튜토리얼에서 다루지 않습니다. 독립형 데이터베이스를 설치하지 않고 이 튜토리얼을 실행하려는 경우 임베디드 Derby 데이터베이스를 사용할 수 있습니다. 단, 이 데이터베이스를 사용하는 경우에는 다음과 같은 제한사항이 적용됩니다.

* 그래픽 모드로 Installation Manager를 실행할 수 있지만, 서버를 배치하기 위해서는 이 튜토리얼의 명령행 절로 건너뛰어 Ant 태스크를 사용하여 설치해야 합니다.
* 서버 팜을 구성할 수 없습니다. 임베디드 Derby 데이터베이스는 복수 서버에서의 액세스를 지원하지 않습니다. 서버 팜을 구성하려면 DB2, MySQL 또는 Oracle이 필요합니다.

#### 다음으로 이동
{: #jump-to }

* [IBM Installation Manager 설치](#installing-ibm-installation-manager)
* [WebSphere Application Server Liberty Core 설치](#installing-websphere-application-server-liberty-core)
* [{{ site.data.keys.mf_server }} 설치](#installing-mobilefirst-server)
* [데이터베이스 작성](#creating-a-database)
* [Server Configuration Tool 실행](#running-the-server-configuration-tool)
* [설치 테스트](#testing-the-installation)
* [{{ site.data.keys.mf_server }}를 실행하는 두 개의 Liberty 서버로 구성된 팜 작성](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [팜 테스트 및 {{ site.data.keys.mf_console }}에서 변경사항 확인](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

### IBM Installation Manager 설치
{: #installing-ibm-installation-manager }
Installation Manager V1.8.4 이상을 설치해야 합니다. 제품의 설치 후 작업에 Java 7이 필요하므로 이전 버전의 Installation Manager는 {{ site.data.keys.product }} V8.0을 설치할 수 없습니다. 이전 버전의 Installation Manager는 Java 6과 함께 제공됩니다.

1. 다운로드한 IBM Installation Manager 아카이브의 압축을 푸십시오. [Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142)에서 설치 프로그램을 찾을 수 있습니다.
2. Installation Manager를 설치하십시오.
    * **install.exe**를 실행하여 관리자로서 Installation Manager를 설치하십시오. Linux 또는 UNIX에서는 루트가 필요합니다. Windows에서는 관리자 권한이 필요합니다. 이 모드에서는 설치된 패키지에 대한 정보가 디스크의 공유 위치에 배치되며 Installation Manager를 실행하도록 허용된 모든 사용자가 애플리케이션을 업데이트할 수 있습니다.
    * **userinst.exe**를 실행하여 사용자 모드로 Installation Manager를 설치하십시오. 특정 권한이 필요하지 않습니다. 단, 이 모드에서는 설치된 패키지에 대한 정보가 사용자의 홈 디렉토리에 배치됩니다. 해당 사용자만 Installation Manager를 사용하여 설치된 애플리케이션을 업데이트할 수 있습니다.

### WebSphere Application Server Liberty Core 설치
{: #installing-websphere-application-server-liberty-core }
WebSphere Application Server Liberty Core의 설치 프로그램은 {{ site.data.keys.product }} 패키지의 일부로 제공됩니다. 이 태스크에서는 Liberty 프로파일을 설치하고 서버 인스턴스를 작성합니다. 그러면 서버 인스턴스에 {{ site.data.keys.mf_server }}를 설치할 수 있습니다.

1. 다운로드한 WebSphere Application Server Liberty Core의 압축 파일을 추출하십시오.
2. Installation Manager를 실행하십시오.
3. Installation Manager에 저장소를 추가하십시오.
    * **파일 → 환경 설정**으로 이동하여 저장소 추가...를 클릭하십시오.
    * 설치 프로그램이 추출된 디렉토리에서 **diskTag.inf** 파일의 **repository.config** 파일을 찾으십시오.
    * 이 파일을 선택하고 **확인**을 클릭하십시오.
    * **확인**을 클릭하여 환경 설정 패널을 닫으십시오.
4. **설치**를 클릭하여 Liberty를 설치하십시오.
    * **IBM WebSphere Application Server Liberty Core**를 선택하고 **다음**을 클릭하십시오.
    * 라이센스 계약의 조항에 동의하고 **다음**을 클릭하십시오.
5. 이 튜토리얼에서는 요구가 있을 때 추가 자산을 설치할 필요가 없습니다. 설치 프로세스를 시작하려면 **설치**를 클릭하십시오.
    * 설치가 완료되면 프로그램에 의해 설치가 완료되었음을 알리는 메시지가 표시됩니다. 프로그램에 의해 중요한 설치 후 작업 지시사항이 표시될 수도 있습니다.
    * 설치에 실패하는 경우 **로그 파일 보기**를 클릭하여 문제점을 해결하십시오.
6. 서버가 포함된 **usr** 디렉토리를 특정 권한이 필요하지 않은 위치로 이동시키십시오.

    관리자 모드에서 Installation Manager를 사용하여 Liberty를 설치하는 경우, 파일은 비관리자 또는 비루트 사용자가 파일을 수정할 수 없는 위치에 있습니다. 이 튜토리얼에서는 서버가 포함된 **usr** 디렉토리를 특정 권한이 필요 없는 위치로 이동시키십시오. 이 방법을 통해 특정 권한 없이 설치 조작을 수행할 수 있습니다.
    * Liberty의 설치 디렉토리로 이동하십시오.
    * **etc**라는 이름의 디렉토리를 작성하십시오. 관리자 또는 루트 권한이 필요합니다.
    * **etc** 디렉토리에 다음 컨텐츠가 포함된 **server.env** 파일을 작성하십시오. `WLP_USER_DIR=<path to a directory where any user can write>`

    예를 들어, Windows에서는 다음과 같습니다. `WLP_USER_DIR=C:\LibertyServers\usr`
7. 이 튜토리얼의 다음 파트에서 {{ site.data.keys.mf_server }}의 첫 번째 노드를 설치하는 데 사용될 Liberty 서버를 작성하십시오.
    * 명령행을 시작하십시오.
    * l**iberty\_install\_dir/bin**으로 이동하여 `server create mfp1`을 입력하십시오.

    이 명령은 mfp1로 이름 지정된 Liberty 서버 인스턴스를 작성합니다. **liberty\_install\_dir/usr/servers/mfp1** 또는 **WLP\_USER\_DIR/servers/mfp1**(6단계에 설명된 대로 디렉토리를 수정한 경우)에서 해당 정의를 볼 수 있습니다.

서버를 작성한 후, **liberty\_install\_dir/bin/**에서 `server start mfp1`을 사용하여 이 서버를 시작할 수 있습니다. 서버를 중지하려면 **liberty\_install\_dir/bin/**에서 `server stop mfp1` 명령을 입력하십시오.  
기본 홈 페이지는 http://localhost:9080에 있습니다.

> **참고:** 프로덕션의 경우, 호스트 컴퓨터가 시작될 때 Liberty 서버가 서비스로 시작되도록 해야 합니다. Liberty 서버가 서비스로 시작되도록 설정하는 것은 이 튜토리얼에서 다루지 않습니다.

### {{ site.data.keys.mf_server }} 설치
{: #installing-mobilefirst-server }
데이터베이스를 작성하고 Liberty 프로파일에 {{ site.data.keys.mf_server }}를 배치하기 전에, Installation Manager를 실행하여 사용하는 디스크에 {{ site.data.keys.mf_server }}의 2진 파일을 설치하십시오. Installation Manager를 사용하여 {{ site.data.keys.mf_server }}를 설치하는 중에 {{ site.data.keys.mf_app_center }}를 설치하는 옵션이 제안됩니다. Application Center는 제품의 다른 컴포넌트입니다. 이 튜토리얼에서는 {{ site.data.keys.mf_server }}와 함께 설치하지 않아도 됩니다.

1. Installation Manager를 실행하십시오.
2. Installation Manager에서 {{ site.data.keys.mf_server }}의 저장소를 추가하십시오.
    * **파일 → 환경 설정**으로 이동하여 저장소 추가...를 클릭하십시오.
    * 설치 프로그램이 추출된 디렉토리에서 저장소 파일을 찾아보십시오.

        {{ site.data.keys.mf_server }}의 {{ site.data.keys.product }} V8.0 .zip 파일을 **mfp\_installer\_directory** 폴더에 압축 해제하는 경우 저장소 파일은 **mfp\_installer\_directory/MobileFirst\_Platform\_Server/disk1/diskTag.inf**에 있습니다.

        [IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)에서 다운로드할 수 있는 최신 수정팩을 적용할 수도 있습니다. 수정팩에 대한 저장소를 입력하십시오. **fixpack_directory** 폴더에 수정팩의 압축을 풀면 저장소 파일은 **fixpack_directory/MobileFirst_Platform_Server/disk1/diskTag.inf**에 있습니다.

        > **참고:** Installation Manager의 저장소에 기본 버전의 저장소가 없으면 수정팩을 설치할 수 없습니다. 수정팩은 증분식 설치 프로그램이므로 설치하려면 기본 버전의 저장소가 있어야 합니다.
    * 이 파일을 선택하고 **확인**을 클릭하십시오.
    * **확인**을 클릭하여 환경 설정 패널을 닫으십시오.

3. 제품의 라이센스 조항에 동의한 후 **다음**을 클릭하십시오.
4. **새 패키지 그룹 작성** 옵션을 선택하여 해당 새 패키지 그룹에 제품을 설치하십시오.
5. **다음**을 클릭하십시오.
6. **일반 설정** 패널의 **토큰 라이센싱 활성화** 섹션에서 **Rational License Key Server에서** **토큰 라이센싱을 활성화하지 않음** 옵션을 선택하십시오.

    이 튜토리얼에서는 토큰 라이센싱이 필요하지 않다고 가정하므로 토큰 라이센싱용으로 {{ site.data.keys.mf_server }}를 구성하는 단계가 포함되지 않습니다. 단, 프로덕션 설치의 경우 토큰 라이센싱 활성화가 필요한지 여부를 판별해야 합니다. Rational License Key Server에서 토큰 라이센싱을 사용하는 계약이 있는 경우에는 Rational License Key Server에서 토큰 라이센싱 활성화 옵션을 선택하십시오. 토큰 라이센싱을 활성화한 후에는 추가 단계를 수행하여 {{ site.data.keys.mf_server }}를 구성해야 합니다.
7. **일반 설정** 패널의 **{{ site.data.keys.product }} for iOS 설치** 섹션에서 기본 옵션(아니오)을 그대로 두십시오.
8. Application Center가 설치되지 않도록 **구성 선택** 패널에서 아니오 옵션을 선택하십시오. 프로덕션 설치의 경우, Ant 태스크를 사용하여 Application Center를 설치하십시오. Ant 태스크를 사용하여 설치하면 {{ site.data.keys.mf_server }}에 대한 업데이트를 Application Center에 대한 업데이트에서 분리할 수 있습니다.
9. **감사** 패널이 표시될 때까지 **다음**을 클릭하십시오. 그런 다음 설치를 계속하십시오.

{{ site.data.keys.product_adj }} 컴포넌트를 설치하기 위한 리소스가 포함된 설치 디렉토리가 설치됩니다.  
다음 폴더에서 리소스를 찾을 수 있습니다.

* {{ site.data.keys.mf_server }}에 대한 MobileFirstServer 폴더
* {{ site.data.keys.mf_server }} 푸시 서비스에 대한 PushService 폴더
* Application Center에 대한 ApplicationCenter 폴더
* {{ site.data.keys.mf_analytics }}에 대한 Analytics 폴더

이 튜토리얼의 목적은 **MobileFirstServer** 폴더의 리소스를 사용하여 {{ site.data.keys.mf_server }}를 설치하는 것입니다.  
또한 **shortcuts** 폴더에서 Server Configuration Tool, Ant 및 mfpadm 프로그램의 단축 아이콘도 제공됩니다.

### 데이터베이스 작성
{: #creating-a-database }
이 태스크는 사용하는 DBMS에 데이터베이스가 있는지와 사용자가 해당 데이터베이스를 사용하고 거기에 테이블을 작성하며 작성한 테이블을 사용할 수 있는지 확인하는 것입니다.  
데이터베이스는 다양한 {{ site.data.keys.product_adj }} 컴포넌트에서 사용되는 기술 데이터를 저장하는 데 사용됩니다.

* {{ site.data.keys.mf_server }} 관리 서비스
* {{ site.data.keys.mf_server }} 라이브 업데이트 서비스
* {{ site.data.keys.mf_server }} 푸시 서비스
* {{ site.data.keys.product_adj }} 런타임

이 튜토리얼에서는 모든 컴포넌트에 대한 테이블이 동일한 스키마 아래에 배치됩니다. Server Configuration Tool은 동일한 스키마에 테이블을 작성합니다. 유연성 향상을 위해 Ant 태스크 또는 수동 설치를 사용할 수도 있습니다.

> **참고:** 이 태스크의 단계는 DB2를 대상으로 합니다. MySQL 또는 Oracle을 사용할 계획인 경우 [데이터베이스 요구사항](../../../prod-env/databases/#database-requirements)을 참조하십시오.

1. DB2 서버를 실행 중인 컴퓨터에 로그온하십시오. DB2 사용자(예: **mfpuser**)가 존재한다고 가정합니다.
2. 이 DB2 사용자에게 페이지 크기가 32768 이상인 데이터베이스에 액세스하고 해당 데이터베이스에 내재적 스키마 및 테이블을 작성할 수 있는 권한이 있는지 확인하십시오.

    기본적으로 이 사용자는 DB2를 실행하는 컴퓨터의 운영 체제에 선언된 사용자입니다. 즉, 해당 컴퓨터로의 로그인이 가능한 사용자입니다. 이러한 사용자가 존재하는 경우에는 다음 3단계의 조치가 필요하지 않습니다. 이 튜토리얼의 다음 파트에서 Server Configuration Tool은 제품에 필요한 모든 테이블을 해당 데이터베이스의 스키마 아래에 작성합니다.

3. 데이터베이스가 없으면 이 설치에 올바른 페이지 크기의 데이터베이스를 작성하십시오.
    * `SYSADM` 또는 `SYSCTRL` 권한이 있는 사용자로 세션을 여십시오. 예를 들어, DB2 설치 프로그램에 의해 작성되는 기본 관리 사용자인 **db2inst1** 사용자를 사용하십시오.
    * DB2 명령행 프로세서를 여십시오.
        * Windows 시스템에서 **시작 → IBM DB2 → 명령행 프로세서**를 클릭하십시오.
        * Linux 또는 UNIX 시스템에서 **~/sqllib/bin**(관리자의 홈 디렉토리에 **sqllib**가 작성되지 않은 경우 **db2\_install\_dir/bin**)으로 이동하여 `./db2`를 입력하십시오.
        * 다음 SQL문을 입력하여 이름이 **MFPDATA**인 데이터베이스를 작성하십시오.

        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

다른 사용자 이름을 정의한 경우 mfpuser를 자신의 사용자 이름으로 대체하십시오.  

> **참고:** 이 명령문은 기본 DB2 데이터베이스에서 PUBLIC에 부여된 기본 권한을 제거하지는 않습니다. 프로덕션의 경우, 해당 데이터베이스 내의 권한을 제품의 최소 요구사항까지 줄여야 할 수도 있습니다. DB2 보안 및 보안 사례에 대한 자세한 정보는 [DB2 security, Part 8: Twelve DB2 security best practices](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/)를 참조하십시오.

### Server Configuration Tool 실행
{: #running-the-server-configuration-tool }
Server Configuration Tool을 사용하여 다음 조작을 실행합니다.

* {{ site.data.keys.product_adj }} 애플리케이션에 필요한 테이블을 데이터베이스에 작성합니다.
* {{ site.data.keys.mf_server }}의 웹 애플리케이션(런타임, 관리 서비스, 라이브 업데이트 서비스, 푸시 서비스 컴포넌트 및 {{ site.data.keys.mf_console }})을 Liberty 서버에 배치합니다.

Server Configuration Tool은 다음 {{ site.data.keys.product_adj }} 애플리케이션을 배치하지 않습니다.

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }}는 메모리 요구사항이 많기 때문에 일반적으로 {{ site.data.keys.mf_server }}와 다른 서버 세트에 배치됩니다. {{ site.data.keys.mf_analytics }}는 수동으로 또는 Ant 태스크를 사용하여 설치할 수 있습니다. 이미 설치되어 있는 경우에는 Server Configuration Tool에서 해당 URL, 사용자 이름 및 비밀번호를 입력하여 데이터를 전송할 수 있습니다. 그러면 Server Configuration Tool에서 {{ site.data.keys.mf_analytics }}에 데이터를 전송하도록 {{ site.data.keys.product_adj }} 앱을 구성합니다.

#### Application Center
{: #application-center }
이 애플리케이션은 모바일 앱을 사용하는 직원들에게 내부적으로 모바일 앱을 분배하는 데 사용되거나 테스트 목적으로 사용될 수 있습니다. 이 애플리케이션은 {{ site.data.keys.mf_server }}와 독립되어 있으므로 {{ site.data.keys.mf_server }}와 함께 설치할 필요는 없습니다.

1. Server Configuration Tool을 시작하십시오.
    * Linux의 경우, 애플리케이션 단축 아이콘에서 **애플리케이션 → {{ site.data.keys.mf_server }} → Server Configuration Tool**을 클릭하십시오.
    * Windows의 경우 **시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool**을 클릭하십시오.
    * macOS의 경우 쉘 콘솔을 여십시오. **mfp_server\_install\_dir/shortcuts**로 이동하여 ./configuration-tool.sh를 입력하십시오.

    mfp_server_install_dir 디렉토리는 {{ site.data.keys.mf_server }}를 설치한 디렉토리입니다.
2. **파일 → 새 구성...**을 선택하여 {{ site.data.keys.mf_server }} 구성을 작성하십시오.
3. 구성의 이름을 "Hello MobileFirst"로 지정하고 **확인**을 클릭하십시오.
4. 구성 세부사항의 기본 항목을 그대로 두고 **다음**을 클릭하십시오.

    이 튜토리얼에서는 환경 ID가 사용되지 않습니다. 환경 ID는 고급 배치 시나리오에서 사용되는 기능입니다.  
    이러한 시나리오의 예로는 동일한 애플리케이션 서버 또는 WebSphere Application Server 셀에 {{ site.data.keys.mf_server }} 및 관리 서비스의 복수 인스턴스를 설치하는 것을 들 수 있습니다.
5. 관리 서비스 및 런타임 컴포넌트의 기본 컨텍스트 루트를 유지하십시오.
6. **콘솔 설정** 패널에서 기본 항목을 변경하지 말고 **다음**을 클릭하여 기본 컨텍스트 루트로 {{ site.data.keys.mf_console }}을 설치하십시오.
7. **IBM DB2**를 데이터베이스로 선택하고 **다음**을 클릭하십시오.
8. **DB2 데이터베이스 설정** 패널에서 세부사항을 완료하십시오.
    * DB2 서버를 실행하는 호스트 이름을 입력하십시오. 사용하는 컴퓨터에서 실행 중이면 **localhost**를 입력하면 됩니다.
    * 사용할 DB2 인스턴스가 기본 포트(50000)를 청취 중이 아니면 포트 번호를 변경하십시오.
    * DB2 JDBC 드라이버의 경로를 입력하십시오. DB2의 경우, **db2jcc4.jar**이라는 이름의 파일이 예상됩니다. 또한 동일한 디렉토리에 **db2jcc\_license\_cu.jar** 파일도 있어야 합니다. 표준 DB2 배포의 경우, 이러한 파일은 **db2\_install\_dir/java**에 있습니다.
    * **다음**을 클릭하십시오.

    입력한 인증 정보로 DB2 서버에 도달할 수 없는 경우, Server Configuration Tool은 **다음** 단추를 사용 불가능하게 설정하고 오류를 표시합니다. JDBC 드라이버에 필요한 클래스가 없는 경우에도 **다음** 단추를 사용할 수 없습니다. 모든 설정이 올바르면 **다음** 단추를 사용할 수 있습니다.

9. **DB2 추가 설정** 패널에서 세부사항을 완료하십시오.
    * DB2 사용자 이름 및 비밀번호로 **mfpuser**를 입력하십시오. 자신의 DB2 사용자 이름이 **mfpuser**가 아닌 경우에는 자신의 DB2 사용자 이름을 사용하십시오.
    * 데이터베이스 이름으로 **MFPDATA**를 입력하십시오.
    * **MFPDATA**는 테이블을 작성할 스키마로서 그대로 두십시오. **다음**을 클릭하십시오. 기본적으로 Server Configuration Tool은 **MFPDATA** 값을 제안합니다.
10. **데이터베이스 작성 요청** 패널에 아무 값도 입력하지 말고 **다음**을 클릭하십시오.

    이 분할창은 이전 분할창에 입력한 데이터베이스가 DB2 서버에 없을 때 사용됩니다. 이 경우 DB2 관리자의 사용자 이름 및 비밀번호를 입력할 수 있습니다. Server Configuration Tool은 DB2 서버에 대한 ssh 세션을 열고 [데이터베이스 작성](#creating-a-database)에 설명된 대로 명령을 실행하여 기본 설정과 올바른 페이지 크기로 데이터베이스를 작성합니다.
11. **애플리케이션 서버 선택** 패널에서 **WebSphere Application Server** 옵션을 선택하고 **다음**을 클릭하십시오.
12. **애플리케이션 서버 설정** 패널에서 세부사항을 완료하십시오.
    * WebSphere Application Server Liberty의 설치 디렉토리를 입력하십시오.
    * 서버 이름 필드에서 제품을 설치할 서버를 선택하십시오. [WebSphere Application Server Liberty Core 설치](#installing-websphere-application-server-liberty-core)의 7단계에서 작성한 **mfp1** 서버를 선택하십시오.
    * **사용자 작성** 옵션을 기본값이 선택된 상태로 두십시오.

    이 옵션은 Liberty 서버의 기본 레지스트리에 사용자를 작성하며, 이로써 {{ site.data.keys.mf_console }} 또는 관리 서비스에 로그인할 수 있게 됩니다. 프로덕션 설치의 경우, 이 옵션을 사용하지 말고, {{ site.data.keys.mf_server }} 관리용 사용자 인증 구성에 설명된 대로 설치 후에 애플리케이션의 보안 역할을 구성하십시오.
    * 배치 유형에 대해 서버 팜 배치 옵션을 선택하십시오.
    * **다음**을 클릭하십시오.
13. **푸시 서비스 설치** 옵션을 선택하십시오.

    푸시 서비스를 설치할 때 관리 서비스에서 푸시 서비스로의 HTTP 또는 HTTPS 플로우와 관리 서비스 및 푸시 서비스에서 런타임 컴포넌트로의 HTTP 또는 HTTPS 플로우가 필요합니다.
14. **푸시 및 권한 부여 서비스 URL 자동 계산** 옵션을 선택하십시오.

    이 옵션을 선택하는 경우, Server Configuration Tool은 애플리케이션을 동일한 서버에 설치된 애플리케이션에 연결하도록 구성합니다. 클러스터를 사용하는 경우, HTTP 로드 밸런서에서 서비스에 연결하는 데 사용되는 URL을 입력하십시오. WebSphere Application Server Network Deployment에 설치하는 경우에는 URL을 수동으로 입력해야 합니다.
15. **관리 서비스와 푸시 서비스 간의 보안 통신을 위한 인증 정보**의 기본 항목을 그대로 유지하십시오.

    푸시 서비스 및 관리 서비스를 권한 부여 서버(기본적으로 런타임 컴포넌트)의 기밀 OAuth 클라이언트로 등록하려면 클라이언트 ID 및 비밀번호가 필요합니다. Server Configuration Tool이 각 서비스에 대한 ID 및 랜덤 비밀번호를 생성하며, 이 시작하기 튜토리얼에서는 해당 값을 그대로 유지해도 됩니다.
16. **다음**을 클릭하십시오.
17. **Analytics 설정** 패널의 기본 항목을 그대로 유지하십시오.

    Analytics 서버로의 연결을 가능하게 하려면 먼저 {{ site.data.keys.mf_analytics }}를 설치해야 합니다. 단, 이 튜토리얼에서는 이 설치를 다루지 않습니다.
18. **배치**를 클릭하십시오.

**콘솔 창**에서 수행된 조작에 대한 세부사항을 볼 수 있습니다.  
Ant 파일이 저장됩니다. Server Configuration Tool은 구성 설치 및 업데이트를 위한 Ant 파일의 작성을 지원합니다. 이 Ant 파일은 **파일 → Ant 파일로 구성 내보내기...**를 사용하여 내보낼 수 있습니다. 이 Ant 파일에 대한 자세한 정보는 [명령행 모드에서](../command-line) {{ site.data.keys.mf_server }} 설치의 Ant 태스크를 사용하여 Liberty에 {{ site.data.keys.mf_server }} 배치를 참조하십시오.

그런 다음, Ant 파일이 실행되어 다음 조작을 수행합니다.

1. 다음 컴포넌트에 대한 테이블이 데이터베이스에 작성됩니다.
    * 관리 서비스 및 라이브 업데이트 서비스. **admdatabases** Ant 대상에 의해 작성됩니다.
    * 런타임. **rtmdatabases** Ant 대상에 의해 작성됩니다.
    * 푸시 서비스. pushdatabases Ant 대상에 의해 작성됩니다.
2. 다양한 컴포넌트의 WAR 파일이 Liberty 서버에 배치됩니다. **adminstall**, **rtminstall** 및 **pushinstall** 대상 아래의 로그에서 조작에 대한 세부사항을 볼 수 있습니다.

DB2 서버에 대한 액세스 권한이 있는 경우, 다음 지시사항에 따라 작성된 테이블을 나열할 수 있습니다.

1. 데이터베이스 작성의 3단계에 설명된 대로 mfpuser로 DB2 명령행 프로세서를 여십시오.
2. SQL문을 입력하십시오.

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser_password
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

다음 데이터베이스 요소에 주의하십시오.

#### 데이터베이스 사용자 고려사항
{: #database-user-consideration }
Server Configuration Tool에서 필요한 데이터베이스 사용자는 한 명뿐입니다. 이 사용자는 테이블을 작성하는 데 사용될 뿐만 아니라 런타임에 애플리케이션 서버에서 데이터 소스 사용자로도 사용됩니다. 프로덕션 환경에서는, 런타임에 사용되는 사용자의 권한을 엄격하게 최소한(`SELECT / INSERT / DELETE / UPDATE)`으로 제한하고 애플리케이션 서버에서의 배치를 위해 다른 사용자를 지정하는 경우가 있습니다. 예로서 제공되는 Ant 파일에서도 두 경우 모두에 동일한 사용자를 사용합니다. 단, DB2의 경우 고유한 파일 버전을 작성할 수 있습니다. 이로써 Ant 태스크에 의해 애플리케이션 서버의 데이터 소스에 사용되는 사용자와 데이터베이스를 작성하는 데 사용되는 사용자를 구별할 수 있습니다.

#### 데이터베이스 테이블 작성
{: #database-tables-creation }
프로덕션의 경우, 수동으로 테이블을 작성해야 하는 경우가 있습니다. 예를 들어, DBA가 일부 기본 설정을 대체하거나 특정 테이블스페이스를 지정하고자 하는 경우입니다. 테이블을 작성하는 데 사용되는 데이터베이스 스크립트가 **mfp\_server\_install\_dir/MobileFirstServer/databases** 및 **mfp_server\_install\_dir/PushService/databases**에 있습니다. 자세한 정보는 [수동으로 데이터베이스 테이블 작성](../../../prod-env/databases/#create-the-database-tables-manually)을 참조하십시오.

**server.xml** 파일 및 일부 애플리케이션 서버 설정이 설치 중에 수정됩니다. 각 수정 전에 **server.xml.bak**, **server.xml.bak1** 및 **server.xml.bak2**와 같은 **server.xml** 파일의 사본이 작성됩니다. 추가된 것을 모두 보려면 **server.xml** 파일을 가장 오래된 백업(server.xml.bak)과 비교하십시오. Linux에서는 diff `--strip-trailing-cr server.xml server.xml.bak` 명령을 사용하여 차이점을 확인할 수 있습니다. AIX에서는 `diff server.xml server.xml.bak` 명령을 사용하여 차이점을 찾으십시오.

#### 애플리케이션 서버 설정 수정(Liberty에만 해당됨):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Liberty 기능이 추가됩니다.

    Liberty 기능은 애플리케이션마다 추가되므로 중복될 수 있습니다. 예를 들어, JDBC 기능은 관리 서비스 및 런타임 컴포넌트 둘 다에 사용됩니다. 이러한 중복으로 인해, 애플리케이션을 설치 제거할 때 다른 애플리케이션을 중단하지 않고 해당 애플리케이션의 기능을 제거할 수 있습니다. 예를 들어, 어느 한 시점에 서버에서 푸시 서비스를 설치 제거하여 이를 다른 서버에 설치하기로 결정하는 경우입니다. 단, 모든 토폴로지가 가능한 것은 아닙니다. 관리 서비스, 라이브 업데이트 서비스 및 런타임 컴포넌트가 Liberty 프로파일과 동일한 애플리케이션 서버에 있어야 합니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임에 대한 제한조건](../../../prod-env/topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)을 참조하십시오. 추가된 기능이 충돌하지 않는 한 기능 중복은 문제가 되지 않습니다. jdbc-40 및 jdbc-41 기능을 추가하면 문제가 발생하지만 동일한 기능을 두 번 추가하는 경우에는 문제가 발생하지 않습니다.

2. `host='*'`가 `httpEndPoint` 선언에 추가됩니다.

    이 설정은 모든 네트워크 인터페이스에서 서버로의 연결을 허용하기 위한 것입니다. 프로덕션의 경우, HTTP 엔드포인트의 호스트 값을 제한하는 경우가 있습니다.
3. 활성 리스너가 없는 포트로의 즉각적인 리바인드를 가능하게 하고 서버의 처리량을 개선하기 위해 **tcpOptions** 요소(**tcpOptions soReuseAddr="true"**)가 서버 구성에 추가됩니다.
4. ID가 **defaultKeyStore**인 키 저장소가 작성됩니다(없는 경우).

    이 키 저장소는 HTTPS 포트를 사용 가능하게 하는 데 필요합니다. 더 구체적으로 말하면, 관리 서비스(mfp-admin-service.war)와 런타임 컴포넌트(mfp-server.war) 간의 JMX 통신을 가능하게 하는 데 사용됩니다. 두 애플리케이션은 JMX를 통해 통신합니다. Liberty 프로파일의 경우, 단일 서버의 애플리케이션 간 통신과 Liberty 팜의 서버 간 통신에 restConnector가 사용됩니다. 여기에는 HTTPS의 사용이 필요합니다. 기본적으로 작성되는 키 저장소에 대해, Liberty 프로파일은 유효 기간이 365일인 인증서를 작성합니다. 이 구성은 프로덕션 용도가 아닙니다. 프로덕션의 경우, 고유의 인증서 사용을 재고해야 합니다.    

    JMX를 사용하기 위해 관리자 역할이 있는 사용자(MfpRESTUser로 이름 지정됨)가 기본 레지스트리에 작성됩니다. 해당 이름 및 비밀번호는 JNDI 특성(mfp.admin.jmx.user and mfp.admin.jmx.pwd)으로 제공되며 런타임 컴포넌트 및 관리 서비스에서 JMX 조회를 실행하는 데 사용됩니다. 글로벌 JMX 특성 중 일부 특성은 클러스터 모드(독립형 서버 또는 팜에서 작동 중)를 정의하는 데 사용됩니다. Server Configuration Tool은 Liberty 서버에서 mfp.topology.clustermode 특성을 Standalone으로 설정합니다. 이 튜토리얼의 다음 파트인 팜 작성 관련 부분에서는 이 특성이 Cluster로 수정됩니다.
5. 사용자가 작성됩니다(Apache Tomcat 및 WebSphere Application Server에도 유효함).
    * 선택적 사용자: 설치 후 콘솔에 로그인하는 데 사용할 수 있도록 Server Configuration Tool에 의해 테스트 사용자(admin/admin)가 작성됩니다.
    * 필수 사용자: 관리 서비스가 로컬 라이브 업데이트 서비스에 접속하는 데 사용되는 사용자(랜덤으로 생성된 비밀번호를 갖는 configUser_mfpadmin라는 이름의 사용자)도 Server Configuration Tool에 의해 작성됩니다. Liberty 서버의 경우 MfpRESTUser가 작성됩니다. 애플리케이션 서버가 기본 레지스트리(예: LDAP 레지스트리)를 사용하도록 구성되어 있지 않는 경우, Server Configuration Tool은 기존 사용자의 이름을 요청할 수 없습니다. 이런 경우에는 Ant 태스크를 사용해야 합니다.
6. **webContainer** 요소가 수정됩니다.

    `deferServletLoad` 웹 컨테이너 사용자 정의 특성이 false로 설정됩니다. 서버가 시작될 때 런타임 컴포넌트 및 관리 서비스가 둘 다 시작되어야 합니다. 그러면 이러한 컴포넌트가 JMX Bean을 등록할 수 있으며, 런타임 컴포넌트가 작동하는 데 필요한 모든 애플리케이션 및 어댑터를 다운로드할 수 있도록 하기 위한 동기화 프로시저를 시작할 수 있습니다.
7. Liberty V8.5.5.5 이하를 사용하는 경우, 기본 실행기는 큰 값을 `coreThreads` 및 `maxThreads`로 설정하도록 사용자 정의됩니다. V8.5.5.6의 경우, 기본 실행기는 Liberty에 의해 자동으로 조정됩니다.

    이 설정으로 인해 일부 Liberty 버전에서 런타임 컴포넌트 및 관리 서비스의 시작 시퀀스를 중단하는 제한시간 초과 문제가 방지됩니다. 이 명령문이 없으면 서버 로그 파일에서 다음과 같은 오류가 발생할 수 있습니다.

    > Failed to obtain JMX connection to access an MBean. There might be a JMX configuration error: Read timed out
FWLSE3000E: A server error was detected.
    > FWLSE3012E: JMX configuration error. Unable to obtain MBeans. Reason: "Read timed out".

#### 애플리케이션 선언
{: #declaration-of-applications }
다음 애플리케이션이 설치됩니다.

* **mfpadmin**, 관리 서비스
* **mfpadminconfig**, 라이브 업데이트 서비스
* **mfpconsole**, {{ site.data.keys.mf_console }}
* **mobilefirs**t, {{ site.data.keys.product_adj }} 런타임 컴포넌트
* **imfpush**, 푸시 서비스

Server Configuration Tool은 모든 애플리케이션을 동일한 서버에 설치합니다. 애플리케이션을 서로 다른 애플리케이션 서버에 분리할 수 있지만 [토폴로지 및 네트워크 플로우](../../../prod-env/topologies)에 설명된 특정 제한조건이 적용됩니다.  
서로 다른 서버에 설치하는 경우에는 Server Configuration Tool을 사용할 수 없습니다. Ant 태스크를 사용하거나 수동으로 제품을 설치하십시오.

#### 관리 서비스
{: #administration-service }
관리 서비스는 {{ site.data.keys.product_adj }} 애플리케이션, 어댑터 및 해당 구성을 관리하기 위한 서비스입니다. 이 서비스는 보안 역할에 의해 보호됩니다. 기본적으로 Server Configuration Tool은 테스트를 위해 콘솔에 로그인하는 데 사용할 수 있는, 관리자 역할이 있는 사용자(admin)를 추가합니다. 보안 역할은 Server Configuration Tool(또는 Ant 태스크)로 설치를 수행한 후에 구성해야 합니다. 애플리케이션 서버에서 구성하는 기본 레지스트리 또는 LDAP 레지스트리 내의 사용자 또는 그룹을 각 보안 역할에 맵핑해야 하는 경우도 있습니다.

Liberty 프로파일과 WebSphere Application Server, 그리고 모든 {{ site.data.keys.product_adj }} 애플리케이션에 대해, 클래스 로더 위임은 상위 마지막으로 설정됩니다. 이 설정은 {{ site.data.keys.product_adj }} 애플리케이션에 패키징된 클래스와 애플리케이션 서버 클래스 간의 충돌을 피하기 위한 것입니다. 클래스 로더 위임을 상위 마지막으로 설정하지 않으면 수동 설치 시 오류가 빈번하게 발생합니다. Apache Tomcat의 경우 이 선언이 필요하지 않습니다.

Liberty 프로파일에서는 JNDI 특성으로 전달되는 비밀번호를 복호화하기 위한 공통 라이브러리가 애플리케이션에 추가됩니다. Server Configuration Tool은 관리 서비스에 대한 두 개의 필수 JNDI 특성(**mfp.config.service.user** 및 **mfp.config.service.password**)을 정의합니다. 이러한 특성은 관리 서비스에서 해당 REST API를 사용하여 라이브 업데이트 서비스에 연결하는 데 사용됩니다. 추가 JNDI 특성을 정의하여 애플리케이션을 설치 세부사항에 적합하게 조정할 수 있습니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.

Server Configuration Tool은 또한 푸시 서비스와의 통신을 위한 JNDI 특성(기밀 클라이언트 등록을 위한 URL 및 OAuth 매개변수)도 정의합니다.  
관리 서비스용 테이블을 포함하는 데이터베이스의 데이터 소스와 해당 JDBC 드라이버의 라이브러리가 선언됩니다.

#### 라이브 업데이트 서비스
{: #live-update-service }
라이브 업데이트 서비스는 런타임 및 애플리케이션 구성에 대한 정보를 저장합니다. 이 서비스는 관리 서비스에 의해 제어되며 항상 관리 서비스와 동일한 서버에서 실행되어야 합니다. 컨텍스트 루트는 **context\_root\_of\_admin\_serverconfig**입니다. 따라서 **mfpadminconfig**입니다. 관리 서비스는 라이브 업데이트 서비스의 REST 서비스에 대한 요청의 URL을 작성하는 데 이 규칙이 적용된다고 가정합니다.

관리 서비스 절에서 설명한 대로 클래스 로더 위임이 상위 마지막으로 설정됩니다.

라이브 업데이트 서비스에는 하나의 보안 역할 **admin_config**가 있습니다. 해당 역할에 사용자를 맵핑해야 합니다. JNDI 특성(**mfp.config.service.user** 및 **mfp.config.service.password**)을 사용하여 해당 비밀번호 및 로그인을 관리 서비스에 제공해야 합니다. JNDI 특성에 대한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) 및 [{{ site.data.keys.mf_server }} 라이브 업데이트 서비스의 JNDI 특성 목록](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service)을 참조하십시오.

또한 Liberty 프로파일에 JNDI 이름을 갖는 데이터 소스도 필요합니다. 규칙은 **context\_root\_of\_config\_server/jdbc/ConfigDS**입니다. 이 튜토리얼에서는 **mfpadminconfig/jdbc/ConfigDS**로 정의됩니다. Server Configuration Tool 또는 Ant 태스크에 의한 설치에서, 라이브 업데이트 서비스의 테이블은 관리 서비스의 테이블과 동일한 데이터베이스 및 스키마에 있습니다. 이러한 테이블에 액세스하는 사용자도 동일합니다.

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{ site.data.keys.mf_console }}은 관리 서비스와 동일한 보안 역할로 선언됩니다. {{ site.data.keys.mf_console }}의 보안 역할에 맵핑되는 사용자는 관리 서비스의 동일한 보안 역할에도 맵핑되어야 합니다. 실제로 {{ site.data.keys.mf_console }}은 콘솔 사용자를 대신하여 관리 서비스에 대한 조회를 실행합니다.

Server Configuration Tool은 하나의 JNDI 특성 **mfp.admin.endpoint**를 배치합니다. 이 특성은 콘솔이 관리 서비스에 연결하는 방법을 표시합니다. Server Configuration Tool에 의해 설정되는 기본값은 `*://*:*/mfpadmin`입니다. 이 설정은 콘솔에 수신되는 HTTP 요청과 동일한 프로토콜, 호스트 이름 및 포트를 사용해야 하고 컨텍스트 루트가 /mfpadmin임을 의미합니다. 웹 프록시를 통해 요청이 전달되도록 설정하려면 기본값을 변경하십시오. 이 URL에 가능한 값에 대한 자세한 정보나 기타 가능한 JNDI 특성에 대한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.

관리 서비스 절에서 설명한 대로 클래스 로더 위임이 상위 마지막으로 설정됩니다.

#### {{ site.data.keys.product_adj }} 런타임
{: #mobilefirst-runtime }
이 애플리케이션은 보안 역할에 의해 보호되지 않습니다. 이 애플리케이션에 액세스하기 위해 Liberty 서버가 인식하는 사용자로 로그인할 필요는 없습니다. 모바일 디바이스 요청은 런타임으로 경로 지정됩니다. 이러한 요청은 다른 제품별 메커니즘(OAuth 등)과 {{ site.data.keys.product_adj }} 애플리케이션의 구성에 고유한 메커니즘에 의해 인증됩니다.

관리 서비스 절에서 설명한 대로 클래스 로더 위임이 상위 마지막으로 설정됩니다.

또한 Liberty 프로파일에 JNDI 이름을 갖는 데이터 소스도 필요합니다. 규칙은 **context\_root\_of\_runtime/jdbc/mfpDS**입니다. 이 튜토리얼에서는 **mobilefirst/jdbc/mfpDS**로 정의됩니다. Server Configuration Tool 또는 Ant 태스크에 의한 설치에서, 런타임의 테이블은 관리 서비스의 테이블과 동일한 데이터베이스 및 스키마에 있습니다. 이러한 테이블에 액세스하는 사용자도 동일합니다.

#### 푸시 서비스
{: #push-service }
이 애플리케이션은 OAuth에 의해 보호됩니다. 서비스에 대한 모든 HTTP 요청에 유효한 OAuth 토큰이 포함되어야 합니다.

OAuth의 구성은 JNDI 특성(권한 부여 서버의 URL, 클라이언트 ID 및 푸시 서비스의 비밀번호)을 통해 작성됩니다. JNDI 특성은 또한 보안 플러그인(**mfp.push.services.ext.security**)을 표시하고 관계형 데이터베이스가 사용된다는 사실(**mfp.push.db.type**)도 표시합니다. 모바일 디바이스에서 푸시 서비스로의 요청은 이 서비스로 경로 지정됩니다. 푸시 서비스의 컨텍스트 루트는 /imfpush여야 합니다. 클라이언트 SDK는 해당 컨텍스트 루트(**/imfpush**)를 사용하는 런타임의 URL을 기반으로 푸시 서비스의 URL을 계산합니다. 런타임과 다른 서버에 푸시 서비스를 설치하려면 디바이스 요청을 관련 애플리케이션 서버로 경로 지정할 수 있는 HTTP 라우터가 있어야 합니다.

관리 서비스 절에서 설명한 대로 클래스 로더 위임이 상위 마지막으로 설정됩니다.

또한 Liberty 프로파일에 JNDI 이름을 갖는 데이터 소스도 필요합니다. JNDI 이름은 **imfpush/jdbc/imfPushDS**입니다. Server Configuration Tool 또는 Ant 태스크에 의한 설치에서, 푸시 서비스의 테이블은 관리 서비스의 테이블과 동일한 데이터베이스 및 스키마에 있습니다. 이러한 테이블에 액세스하는 사용자도 동일합니다.

#### 기타 파일 수정
{: #other-files-modification }
Liberty 프로파일 jvm.options 파일이 수정됩니다. 런타임이 관리 서비스와 동기화될 때 JMX에서의 제한시간 초과 문제를 방지하기 위해 특성(com.ibm.ws.jmx.connector.client.rest.readTimeout)이 정의됩니다.

### 설치 테스트
{: #testing-the-installation }
설치가 완료된 후에 이 프로시저를 사용하여 설치된 컴포넌트를 테스트할 수 있습니다.

1. **server start mfp1** 명령을 사용하여 서버를 시작하십시오. 서버의 2진 파일은 **liberty\_install\_dir/bin**에 있습니다.
2. 웹 브라우저를 사용하여 {{ site.data.keys.mf_console }}을 테스트하십시오. [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)로 이동하십시오. 기본적으로 서버는 9080 포트에서 실행됩니다. 단, **server.xml** 파일에 정의된 요소 `<httpEndpoint>`에서 포트를 확인할 수 있습니다. 로그인 화면이 표시됩니다.

![콘솔의 로그인 화면](mfpconsole_signin.jpg)

3. **admin/admin**으로 로그인하십시오. 이 사용자는 기본적으로 Server Configuration Tool에 의해 작성됩니다.

    > **참고:** HTTP로 연결하는 경우, 로그인 ID 및 비밀번호는 네트워크에서 일반 텍스트로 전송됩니다. 보안 로그인의 경우, HTTPS를 사용하여 서버에 로그인하십시오. **server.xml** 파일에 있는 `<httpEndpoint>` 요소의 httpsPort 속성에서 Liberty 서버의 HTTPS 포트를 볼 수 있습니다. 기본적으로 값은 9443입니다.

4. **Hello Admin → 로그아웃**을 사용하여 콘솔에서 로그아웃하십시오.
5. 웹 브라우저에 URL [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)을 입력하고 인증서를 승인하십시오. 기본적으로 Liberty 서버는 웹 브라우저에 인식되지 않는 기본 인증서를 생성하므로 인증서를 승인해야 합니다. Mozilla Firefox는 이 인증을 보안 예외로서 제공합니다.
6. **admin/admin**으로 다시 로그인하십시오. 웹 브라우저와 {{ site.data.keys.mf_server }} 간에 로그인 및 비밀번호가 암호화됩니다. 프로덕션의 경우, HTTP 포트를 닫아야 하는 경우도 있습니다.

### {{ site.data.keys.mf_server }}를 실행하는 두 개의 Liberty 서버로 구성된 팜 작성
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
이 태스크에서는 동일한 {{ site.data.keys.mf_server }}를 실행하고 동일한 데이터베이스에 연결되는 두 번째 Liberty 서버를 작성합니다. 프로덕션의 경우, 최대 활동 시간에 모바일 애플리케이션에 필요한 초당 트랜잭션 수를 처리하기에 충분한 서버를 확보하기 위해 성능상의 이유로 두 개 이상의 서버를 사용하는 경우가 있습니다. 또한 단일 실패 지점을 피하기 위한 고가용성상의 이유도 있습니다.

{{ site.data.keys.mf_server }}를 실행하는 서버가 둘 이상인 경우에는 해당 서버를 하나의 팜으로 구성해야 합니다. 이와 같이 구성하면 관리 서비스가 팜의 모든 런타임에 접속할 수 있습니다. 클러스터가 팜으로 구성되지 않은 경우에는 관리 조작을 실행하는 관리 서비스와 동일한 애플리케이션 서버에서 실행되는 런타임에만 알림이 제공됩니다. 기타 런타임은 변경사항을 인식하지 못합니다. 예를 들어, 팜으로 구성되지 않은 클러스터에 새 버전의 어댑터를 배치하는 경우, 하나의 서버만 새 어댑터에 서비스를 제공합니다. 나머지 서버는 계속해서 이전 어댑터에 서비스를 제공합니다. 클러스터가 있을 때 팜을 구성하지 않아도 되는 유일한 상황은 WebSphere Application Server Network Deployment에 서버를 설치하는 경우입니다. 관리 서비스는 배치 관리자로 JMX Bean을 조회하여 모든 서버를 찾을 수 있습니다. 배치 관리자는 셀의 {{ site.data.keys.product_adj }} JMX Bean 목록을 제공하는 데 사용되므로 관리 조작을 허용하려면 배치 관리자가 실행 중이어야 합니다.

팜을 작성하는 경우에는 또한 팜의 모든 멤버에 조회를 전송하도록 HTTP 서버를 구성해야 합니다. HTTP 서버의 구성에 대해서는 이 튜토리얼에서 다루지 않습니다. 이 튜토리얼에서는 관리 조작이 클러스터의 모든 런타임 컴포넌트에 복제되도록 팜을 구성하는 것에 대해서만 다룹니다.

1. 동일한 컴퓨터에서 두 번째 Liberty 서버를 작성하십시오.
    * 명령행을 시작하십시오.
    * **liberty\_install\_dir/bin**으로 이동하여 **server create mfp2**를 입력하십시오.
2. mfp1 서버의 포트와 충돌하지 않도록 mfp2 서버의 HTTP 및 HTTPS 포트를 수정하십시오.
    * 두 번째 서버 디렉토리로 이동하십시오. 이 디렉토리는 **liberty\_install\_dir/usr/servers/mfp2** 또는 **WLP\_USER\_DIR/servers/mfp2**([WebSphere Application Server Liberty Core 설치](#installing-websphere-application-server-liberty-core)의 6단계에 설명된 대로 디렉토리를 수정하는 경우)입니다.
    * **server.xml** 파일을 편집하십시오. 다음을 찾으십시오.

    ```xml
    <httpEndpoint id="defaultHttpEndpoint"
    httpPort="9080"
    httpsPort="9443" />
    ```

    이를 다음으로 대체하십시오.

    ```xml
    <httpEndpoint id="defaultHttpEndpoint"
    httpPort="9081"
    httpsPort="9444" />
    ```

    이 변경으로 인해 mfp2 서버의 HTTP 및 HTTPS 포트가 mfp1 서버의 포트와 충돌하지 않습니다. {{ site.data.keys.mf_server }} 설치를 실행하기 전에 포트를 수정해야 합니다. 설치를 실행한 후 포트를 수정하는 경우에는 JNDI 특성(**mfp.admin.jmx.port**)에서 포트 변경을 반영해야 합니다.

3. Server Configuration Tool을 실행하십시오.
    *  **Hello MobileFirst 2** 구성을 작성하십시오.
    * [Server Configuration Tool 실행](#running-the-server-configuration-tool)에 설명된 것과 동일한 설치 프로시저를 수행하십시오. 단, 애플리케이션 서버로서 **mfp2**를 선택하십시오. 동일한 데이터베이스 및 동일한 스키마를 사용하십시오.

    > **참고:**  
    >
    > * mfp1 서버에 대해 환경 ID를 사용하는 경우(튜토리얼에서 권장하지 않음), mfp2 서버에 대해서도 동일한 환경 ID를 사용해야 합니다.
    > * 일부 애플리케이션에 대해 컨텍스트 루트를 수정하는 경우, mfp2 서버에 대해서도 동일한 컨텍스트 루트를 사용하십시오. 팜의 서버는 대칭이어야 합니다.
    > * 기본 사용자(admin/admin)를 작성하는 경우 mfp2 서버에서 동일한 사용자를 작성하십시오.

    Ant 태스크는 데이터베이스가 존재함을 발견하고 테이블을 작성하지 않습니다(다음 로그 추출 참조). 그런 다음 애플리케이션이 서버에 배치됩니다.

    ```xml
    [configuredatabase] Checking connectivity to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser'...
    [configuredatabase] Database MFPDATA exists.
    [configuredatabase] Connection to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser' succeeded.
    [configuredatabase] Getting the version of MobileFirstAdmin database MFPDATA...
    [configuredatabase] Table MFPADMIN_VERSION exists, checking its value...
    [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
    [configuredatabase] Configuring MobileFirstAdmin database MFPDATA...
    [configuredatabase] The database is in latest version (8.0.0), no upgrade required.
    [configuredatabase] Configuration of MobileFirstAdmin database MFPDATA succeeded.
    ```

4. HTTP 연결로 두 서버를 테스트하십시오.
    * 웹 브라우저를 여십시오.
    * 다음 URL을 입력하십시오. [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). 이 콘솔은 mfp1 서버에서 서비스를 제공합니다.
    * **admin/admin**으로 로그인하십시오.
    * 동일한 웹 브라우저에서 탭을 열고 다음 URL을 입력하십시오. [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole). 이 콘솔은 mfp2 서버에서 서비스를 제공합니다.
    * admin/admin으로 로그인하십시오. 설치가 올바르게 수행된 경우, 로그인 후 두 탭에 동일한 시작 페이지가 표시됩니다.
    * 첫 번째 브라우저 탭으로 돌아가서 **Hello, admin → 감사 로그 다운로드**를 클릭하십시오. 콘솔에서 로그아웃되고 로그인 화면이 다시 표시됩니다. 이 로그아웃 동작은 문제점입니다. mfp2 서버에 로그온할 때 LTPA(Lightweight Third Party Authentication) 토큰이 작성되어 브라우저에 쿠키로 저장되기 때문에 이러한 문제가 발생합니다. 단, mfp1 서버에서는 이 LTPA 토큰을 인식하지 않습니다. 프로덕션 환경에서는 클러스터 앞에 HTTP 로드 밸런서가 있는 경우 서버 간 전환이 발생할 가능성이 있습니다. 이 문제를 해결하려면 두 서버(mfp1 및 mfp2) 모두 동일한 비밀 키를 사용하여 LTPA 토큰을 생성하도록 해야 합니다. mfp1 서버에서 mfp2 서버로 LTPA 키를 복사하십시오.
    * 다음 명령을 사용하여 두 서버 모두 중지하십시오.

        ```bash
        server stop mfp1
        server stop mfp2
        ```
    * mfp1 서버의 LTPA 키를 mfp2 서버로 복사하십시오.
        **liberty\_install\_dir/usr/servers** 또는 **WLP\_USER\_DIR/servers**에서, 사용하는 운영 체제에 따라 다음 명령을 실행하십시오.
        * UNIX의 경우: `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * Windows의 경우: `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
    * 서버를 다시 시작하십시오. 하나의 브라우저 탭에서 다른 브라우저 탭으로 전환하기 위해 다시 로그인할 필요가 없습니다. Liberty 서버 팜에서는 모든 서버가 동일한 LTPA 키를 가지고 있어야 합니다.
5. Liberty 서버 간의 JMX 통신을 사용 가능하게 설정하십시오.

    Liberty와의 JMX 통신은 HTTPS 프로토콜을 사용하여 Liberty REST 커넥터를 통해 수행됩니다. 이 통신을 사용하려면 팜의 각 서버가 다른 멤버의 SSL 인증을 인식할 수 있어야 합니다. 해당 신뢰 저장소에서 HTTPS 인증서를 교환해야 합니다. IBM 유틸리티(예: **java/bin**에 있는 IBM JRE 배포의 일부인 Keytool)를 사용하여 신뢰 저장소를 구성하십시오. 키 저장소 및 신뢰 저장소의 위치는 **server.xml** 파일에 정의됩니다. 기본적으로 Liberty 프로파일의 키 저장소는 **WLP\_USER\_DIR/servers/server\_name/resources/security/key.jks**에 있습니다. 이 기본 키 저장소의 비밀번호는 **server.xml** 파일에서 보듯이 **mobilefirst**입니다.

    > **팁:** 이 비밀번호는 Keytool 유틸리티를 사용하여 변경할 수 있지만, Liberty 서버에서 해당 키 저장소를 읽을 수 있도록 server.xml 파일에서도 비밀번호를 변경해야 합니다. 이 튜토리얼에서는 기본 비밀번호를 사용하십시오.
    * **WLP\_USER\_DIR/servers/mfp1/resources/security**에서 `keytool -list -keystore key.jks`를 입력하십시오. 이 명령은 키 저장소의 인증서를 표시합니다. **default**라는 하나의 인증서만 있습니다. 키가 표시되기 전에 키 저장소의 비밀번호(mobilefirst) 입력을 요구하는 프롬프트가 표시됩니다. 이는 Keytool 유틸리티를 사용하는 다음의 모든 명령에 해당됩니다.
    * 다음 명령을 사용하여 mfp1 서버의 기본 인증서를 내보내십시오. `keytool -exportcert -keystore key.jks -alias default -file mfp1.cert`.
        * **WLP\_USER\_DIR/servers/mfp2/resources/security**에서 다음 명령을 사용하여 mfp2 서버의 기본 인증서를 내보내십시오. `keytool -exportcert -keystore key.jks -alias default -file mfp2.cert`.
    * 동일한 디렉토리에서 다음 명령을 사용하여 mfp1 서버의 인증서를 가져오십시오. `keytool -import -file ../../../mfp1/resources/security/mfp1.cert -keystore key.jks`. mfp1 서버의 인증서를 mfp2 서버의 키 저장소로 가져옴으로써 mfp2 서버는 mfp1 서버로의 HTTPS 연결을 신뢰할 수 있습니다. 인증서를 신뢰하는지에 대한 확인을 요구합니다.
    * **WLP_USER_DIR/servers/mfp1/resources/security**에서 다음 명령을 사용하여 mfp2 서버의 인증서를 가져오십시오. `keytool -import -file ../../../mfp2/resources/security/mfp2.cert -keystore key.jks`. 이 단계를 수행하면 두 서버 간의 HTTPS 연결이 가능해집니다.

## 팜 테스트 및 {{ site.data.keys.mf_console }}에서 변경사항 확인
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. 두 서버를 시작하십시오.

    ```bash
    server start mfp1
    server start mfp2
    ```

2. 콘솔에 액세스하십시오. 예를 들어, [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) 또는 [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole)(HTTPS의 경우)입니다. 왼쪽 사이드바에 **서버 팜 노드**라는 레이블이 지정된 추가 메뉴가 표시됩니다. **서버 팜 노드**를 클릭하면 각 노드의 상태가 표시됩니다. 두 노드가 모두 시작되려면 잠시 대기해야 할 수도 있습니다.
