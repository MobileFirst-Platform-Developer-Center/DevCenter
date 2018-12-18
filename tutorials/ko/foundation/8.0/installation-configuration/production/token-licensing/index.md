---
layout: tutorial
title: 토큰 라이센싱을 위한 설치 및 구성
breadcrumb_title: Token licensing
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server }}에 토큰 라이센싱을 사용하려면, Rational Common Licensing 라이브러리를 설치하고 {{ site.data.keys.mf_server }}를 Rational License Key Server에 연결하도록 애플리케이션 서버를 구성해야 합니다.

다음 주제에서는 토큰 라이센싱을 위한 설치 개요, Rational Common Licensing 라이브러리의 수동 설치, 애플리케이션 서버의 구성 및 플랫폼 제한사항에 대해 설명합니다.

#### 다음으로 이동
{: #jump-to }

* [토큰 라이센싱의 사용 계획](#planning-for-the-use-of-token-licensing)
* [토큰 라이센싱을 위한 설치 개요](#installation-overview-for-token-licensing)
* [Apache Tomcat에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [WebSphere Application Server Liberty 프로파일에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [WebSphere Application Server에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [토큰 라이센싱용으로 지원되는 플랫폼의 제한사항](#limitations-of-supported-platforms-for-token-licensing)
* [토큰 라이센싱 문제점 해결](#troubleshooting-token-licensing-problems)

## 토큰 라이센싱의 사용 계획
{: #planning-for-the-use-of-token-licensing }
{{ site.data.keys.mf_server }}에 대한 토큰 라이센싱을 구매하는 경우 설치 계획에서 고려해야 할 추가 단계가 있습니다.

### 기술 제한사항
{: #technical-restrictions }
토큰 라이센싱 사용에 대한 기술 제한사항은 다음과 같습니다.

#### 지원 플랫폼:
{: #supported-platforms }
토큰 라이센싱을 지원하는 플랫폼의 목록은 [토큰 라이센싱용으로 지원되는 플랫폼의 제한사항](#limitations-of-supported-platforms-for-token-licensing)에 나열되어 있습니다. 나열되지 않은 플랫폼에서 실행되는 {{ site.data.keys.mf_server }}는 토큰 라이센싱용으로 설치 및 구성하지 못할 수도 있습니다. Rational Common Licensing 클라이언트용 네이티브 라이브러리가 플랫폼에 사용 불가능하거나 지원되지 않을 수 있습니다.

#### 지원되는 토폴로지:
{: #supported-topologies }
토큰 라이센싱에서 지원하는 토폴로지는 [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임에 대한 제한조건](../prod-env/topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)에 나열되어 있습니다.

### 네트워크 요구사항
{: #network-requirement }
{{ site.data.keys.mf_server }}는 Rational License Key Server와 통신할 수 있어야 합니다.

이러한 통신을 위해서는 라이센스 서버의 다음 두 포트에 액세스할 수 있어야 합니다.

* 라이센스 관리자 디먼(**lmgrd**) 포트 - 기본 포트 번호는 27000입니다.
* 공급업체 디먼(**ibmratl**) 포트

정적 값을 사용하도록 포트를 구성하려면 방화벽을 통해 클라이언트 머신에 라이센스 키를 제공하는 방법을 참조하십시오.

### 설치 프로세스
{: #installation-process }
설치 시 IBM  Installation Manager를 실행할 때 토큰 라이센싱을 활성화해야 합니다. 토큰 라이센싱을 사용하기 위한 지시사항은 [토큰 라이센싱을 위한 설치 개요](#installation-overview-for-token-licensing)를 참조하십시오.

{{ site.data.keys.mf_server }}가 설치되면 이 서버를 토큰 라이센싱용으로 수동으로 구성해야 합니다. 자세한 정보는 이 절의 다음 주제를 참조하십시오.

이러한 수동 구성을 완료하기 전에는 {{ site.data.keys.mf_server }}가 작동하지 않습니다. Rational Common Licensing 클라이언트 라이브러리가 애플리케이션 서버에 설치되면 License Key Server의 위치를 정의할 수 있습니다.

### 조작
{: #operations }
{{ site.data.keys.mf_server }}를 설치하고 토큰 라이센싱용으로 구성하면 이 서버는 다양한 시나리오에서 라이센스를 유효성 검증합니다. 조작 시 토큰 검색에 대한 자세한 정보는 [토큰 라이센스 유효성 검증](../../../administering-apps/license-tracking/#token-license-validation)을 참조하십시오.

토큰 라이센싱이 사용되는 프로덕션 서버에서 비프로덕션 애플리케이션을 테스트해야 하는 경우, 애플리케이션을 비프로덕션으로 선언할 수 있습니다. 애플리케이션 유형 선언에 대한 자세한 정보는 [애플리케이션 라이센스 정보 설정](../../../administering-apps/license-tracking/#setting-the-application-license-information)을 참조하십시오.

## 토큰 라이센싱을 위한 설치 개요
{: #installation-overview-for-token-licensing }
{{ site.data.keys.product }}에서 토큰 라이센싱을 사용하려면 다음 예비 단계를 다음 순서로 수행해야 합니다.

> **중요:** 토큰 라이센싱을 지원하는 설치의 일부로서 수행한 토큰 라이센싱에 대한 선택(활성화 여부)은 수정할 수 없습니다. 나중에 토큰 라이센싱 옵션을 변경해야 하는 경우, {{ site.data.keys.product }}을 설치 제거한 후 다시 설치해야 합니다.

1. IBM  Installation Manager를 실행하여 {{ site.data.keys.product }}을 설치할 때 토큰 라이센싱을 활성화하십시오.

   #### 그래픽 모드 설치
   그래픽 모드에서 제품을 설치하는 경우, 설치 시 **일반 설정** 패널에서 **Rational License Key Server에서 토큰 라이센싱 활성화** 옵션을 선택하십시오.

   ![IBM Installation Manager에서 토큰 라이센싱 활성화](licensing_with_tokens_activate.jpg)

   #### 명령행 모드 설치
   자동 모드로 설치하는 경우, 응답 파일에서 **user.licensed.by.tokens** 매개변수의 값을 **true**로 설정하십시오.  
   예를 들어, 다음을 사용할 수 있습니다.

   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```

2. 제품 설치가 완료된 후 애플리케이션 서버에 {{ site.data.keys.mf_server }}를 배치하십시오. 자세한 정보는 [애플리케이션 서버에 {{ site.data.keys.mf_server }} 설치](../prod-env/appserver)를 참조하십시오.

3. 토큰 라이센싱용으로 {{ site.data.keys.mf_server }}를 구성하십시오. 단계는 사용하는 애플리케이션 서버에 따라 다릅니다.

* WebSphere Application Server Liberty 프로파일의 경우 [WebSphere Application Server Liberty 프로파일에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)을 참조하십시오.
* Apache Tomcat의 경우 [Apache Tomcat에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)을 참조하십시오.
* WebSphere Application Server 전체 프로파일의 경우 [WebSphere Application Server에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)을 참조하십시오.

## Apache Tomcat에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
{{ site.data.keys.mf_server }}를 Rational License Key Server에 연결하기 전에 Apache Tomcat 애플리케이션 서버에 Rational Common Licensing 네이티브 및 Java 라이브러리를 설치해야 합니다.

* Rational License Key Server 8.1.4.8 이상을 설치하고 구성해야 합니다. 네트워크는 양방향 통신 포트(**lmrgd** 및 **ibmratl**)를 열어 {{ site.data.keys.mf_server }}와의 통신을 허용해야 합니다. 자세한 정보는 [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) 및 [방화벽을 통해 클라이언트 머신에 라이센스 키를 제공하는 방법](http://www.ibm.com/support/docview.wss?uid=swg21257370)을 참조하십시오.
* {{ site.data.keys.product }}의 라이센스 키가 생성되었는지 확인하십시오. IBM Rational License Key Center를 사용한 라이센스 키 생성 및 관리에 대한 자세한 정보는 [IBM  지원 센터 - 라이센싱](http://www.ibm.com/software/rational/support/licensing/) 및 [IBM Rational License Key Center를 사용하여 라이센스 키 얻기](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)를 참조하십시오.
* [토큰 라이센싱을 위한 설치 개요](#installation-overview-for-token-licensing)에 설명된 대로 {{ site.data.keys.mf_server }}를 설치하고 Rational License Key Server에서 토큰 라이센싱 활성화 옵션을 사용하여 구성해야 합니다.

### Rational Common Licensing 라이브러리 설치
{: #installing-rational-common-licensing-libraries }

1. Rational Common Licensing 네이티브 라이브러리를 선택하십시오. 사용하는 운영 체제와 Apache Tomcat이 실행 중인 JRE(Java Runtime Environment)의 비트 버전에 따라 **product\_install\_dir/MobileFirstServer/tokenLibs/bin/your\_corresponding\_platform/the\_native\_library\_file**에서 올바른 네이티브 라이브러리를 선택해야 합니다. 예를 들어, 64비트 JRE가 설치된 Linux x86의 경우, 라이브러리는 **product\_install\_dir/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**에 있습니다.
2. {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 컴퓨터로 네이티브 라이브러리를 복사하십시오. 디렉토리는 **${CATALINA_HOME}/bin**일 수 있습니다.
    > **참고:** **${CATALINA_HOME}**은 Apache Tomcat의 설치 디렉토리입니다.
3. **rcl_ibmratl.jar** 파일을 **${CATALINA_HOME}/lib**로 복사하십시오. **rcl_ibmratl.jar** 파일은 **product\_install\_dir/MobileFirstServer/tokenLibs** 디렉토리에 있는 Rational Common Licensing Java 라이브러리입니다. 이 라이브러리는 2단계에서 복사한 네이티브 라이브러리를 사용하며 Apache Tomcat에서 한 번만 로드할 수 있습니다. 이 파일은 **${CATALINA_HOME}/lib** 디렉토리나 Apache Tomcat 공통 클래스 로더의 경로에 있는 임의의 디렉토리에 저장해야 합니다.
    > **중요:** Apache Tomcat의 JVM(Java Virtual Machine)은 복사된 네이티브 및 Java 라이브러리에 대해 읽기 및 실행 권한이 필요합니다. 또한 사용하는 운영 체제에서 최소한 애플리케이션 서버 프로세스 동안 복사된 두 파일을 모두 읽고 실행할 수 있어야 합니다.
4. 애플리케이션 서버의 JVM에 의한 Rational Common Licensing 라이브러리로의 액세스를 구성하십시오. 모든 운영 체제에서 다음 행을 추가하여 **${CATALINA_HOME}/bin/setenv.bat** 파일(UNIX의 경우, **setenv.sh** 파일)을 구성하십시오.

   **Windows:**  

   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```

   **UNIX:**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```

   > **참고:** 관리 서비스가 실행 중인 서버의 구성 폴더를 이동시키는 경우, **java.library.path**를 새 절대 경로로 업데이트해야 합니다.

5. Rational License Key Server에 액세스하도록 {{ site.data.keys.mf_server }}를 구성하십시오. **${CATALINA_HOME}/conf/server.xml** 파일에서 관리 서비스 애플리케이션의 `Context` 요소를 찾아 다음 JNDI 구성 행에 추가하십시오.

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname**은 Rational License Key Server의 호스트 이름입니다.
   * **rlks_port**는 Rational License Key Server의 포트입니다. 기본적으로 이 값은 **27000**입니다.

JNDI 특성에 대한 자세한 정보는 [관리 서비스의 JNDI 특성: 라이센싱](../server-configuration/#jndi-properties-for-administration-service-licensing)을 참조하십시오.

### Apache Tomcat 서버 팜에 설치
{: #installing-on-apache-tomcat-server-farm }
Apache Tomcat 서버 팜에서 {{ site.data.keys.mf_server }}의 연결을 구성하려면 {{ site.data.keys.mf_server }}가 실행 중인 서버 팜의 각 노드에 대해 [Rational Common Licensing 라이브러리 설치](#installing-rational-common-licensing-libraries)에 설명된 모든 단계를 수행해야 합니다. 서버 팜에 대한 자세한 정보는 [서버 팜 토폴로지](../prod-env/topologies/#server-farm-topology) 및 [서버 팜 설치](../prod-env/appserver/#installing-a-server-farm)를 참조하십시오.

## WebSphere Application Server Liberty 프로파일에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
{{ site.data.keys.mf_server }}를 Rational License Key Server에 연결하기 전에 Liberty 프로파일에 Rational Common Licensing 네이티브 및 Java 라이브러리를 설치해야 합니다.

* Rational License Key Server 8.1.4.8 이상을 설치하고 구성해야 합니다. 네트워크는 양방향 통신 포트(**lmrgd** 및 **ibmratl**)를 열어 {{ site.data.keys.mf_server }}와의 통신을 허용해야 합니다. 자세한 정보는 [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) 및 [방화벽을 통해 클라이언트 머신에 라이센스 키를 제공하는 방법](http://www.ibm.com/support/docview.wss?uid=swg21257370)을 참조하십시오.
* {{ site.data.keys.product }}의 라이센스 키가 생성되었는지 확인하십시오. IBM Rational License Key Center를 사용한 라이센스 키 생성 및 관리에 대한 자세한 정보는 [IBM  지원 센터 - 라이센싱](http://www.ibm.com/software/rational/support/licensing/) 및 [IBM Rational License Key Center를 사용하여 라이센스 키 얻기](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)를 참조하십시오.
* [토큰 라이센싱을 위한 설치 개요](#installation-overview-for-token-licensing)에 설명된 대로 {{ site.data.keys.mf_server }}를 설치하고 Rational License Key Server에서 토큰 라이센싱 활성화 옵션을 사용하여 구성해야 합니다.

### Rational Common Licensing 라이브러리 설치
{: #common-licensing-libraries-liberty }

1. Rational Common Licensing 클라이언트용 공유 라이브러리를 정의하십시오. 이 라이브러리는 네이티브 코드를 사용하며 애플리케이션 서버에서 한 번만 로드할 수 있습니다. 따라서 이 라이브러리를 사용하는 애플리케이션은 이를 공통 라이브러리로 참조해야 합니다.
   * Rational Common Licensing 네이티브 라이브러리를 선택하십시오. 사용하는 운영 체제와 Liberty 프로파일이 실행 중인 JRE(Java Runtime Environment)의 비트 버전에 따라 **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**에서 올바른 네이티브 라이브러리를 선택해야 합니다. 예를 들어, 64비트 JRE가 설치된 Linux x86의 경우, 라이브러리는 **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**에 있습니다.
   * {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 컴퓨터로 네이티브 라이브러리를 복사하십시오. 디렉토리는 **${shared.resource.dir}/rcllib**일 수 있습니다. **${shared.resource.dir}** 디렉토리는 보통 **usr/shared/resources**에 있습니다. 여기서 usr은 usr/servers 디렉토리도 포함된 디렉토리입니다. **${shared.resource.dir}**의 표준 위치에 대한 자세한 정보는 [WebSphere  Application Server Liberty Core - 디렉토리 위치 및 특성](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc)을 참조하십시오. **rcllib** 폴더가 없으면 이 폴더를 작성한 후 네이티브 라이브러리 파일을 여기로 복사하십시오.

   > **참고:** 애플리케이션 서버의 JVM(Java Virtual Machine)에 네이티브 라이브러리에 대한 읽기 및 실행 권한이 모두 있어야 합니다. Windows에서는, 애플리케이션 서버의 JVM에 복사된 네이티브 라이브러리에 대한 실행 권한이 없는 경우 다음 예외가 표시됩니다.

   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * **rcl_ibmratl.jar** 파일을 **${shared.resource.dir}/rcllib**로 복사하십시오. **rcl_ibmratl.jar** 파일은 **product_install_dir/MobileFirstServer/tokenLibs** 디렉토리에 있는 Rational Common Licensing Java 라이브러리입니다.

   > **참고:** Liberty 프로파일의 JVM(Java Virtual Machine)은 복사된 Java 라이브러리를 읽을 수 있어야 합니다. 또한 사용하는 운영 체제에서(최소한 애플리케이션 서버 프로세스를 위해) 이 파일을 읽을 수 있어야 합니다.    
   * **${server.config.dir}/server.xml** 파일에서 **rcl_ibmratl.jar** 파일을 사용하는 공유 라이브러리를 선언하십시오.

   ```xml
   <!-- Declare a shared Library for the RCL client. -->
   <!- This library can be loaded only once because it uses native code. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * 애플리케이션의 클래스 로더에 속성(**commonLibraryRef**)을 추가하여 공유 라이브러리를 {{ site.data.keys.mf_server }} 관리 서비스 애플리케이션의 공통 라이브러리로 선언하십시오. 이 라이브러리는 한 번만 로드할 수 있으므로 개인용 라이브러리가 아니라 공통 라이브러리로 사용해야 합니다.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Declare the shared library as an attribute commonLibraryRef to
          the class loader of the application. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * Oracle을 데이터베이스로 사용 중인 경우, **server.xml**에는 이미 다음 클래스 로더가 있습니다.

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```

   또한 다음과 같이 Oracle 라이브러리에 Rational Common Licensing 라이브러리를 공통 라이브러리로서 추가해야 합니다.

   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * 애플리케이션 서버의 JVM에 의한 Rational Common Licensing 라이브러리로의 액세스를 구성하십시오. 모든 운영 체제에서 다음 행을 추가하여 **${wlp.user.dir}/servers/server_name/jvm.options** 파일을 구성하십시오.

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```

   > **참고:** 관리 서비스가 실행 중인 서버의 구성 폴더를 이동시키는 경우, **java.library.path**를 새 절대 경로로 업데이트해야 합니다.

   **${wlp.user.dir}** 디렉토리는 보통 **liberty_install_dir/usr**에 있고 servers 디렉토리를 포함합니다. 그러나 해당 위치를 사용자 정의할 수 있습니다. 자세한 정보는 [Liberty 환경 사용자 정의](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc)를 참조하십시오.

2. Rational License Key Server에 액세스하도록 {{ site.data.keys.mf_server }}를 구성하십시오.

   **${wlp.user.dir}/servers/server_name/server.xml** 파일에서 다음 JNDI 구성 행을 추가하십시오.

   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/>
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/>
   ```
   * **rlks_hostname**은 Rational License Key Server의 호스트 이름입니다.
   * **rlks_port**는 Rational License Key Server의 포트입니다. 기본적으로 이 값은 27000입니다.

   JNDI 특성에 대한 자세한 정보는 [관리 서비스의 JNDI 특성: 라이센싱](../server-configuration/#jndi-properties-for-administration-service-licensing)을 참조하십시오.

### Liberty 프로파일 서버 팜에 설치
{: #installing-on-liberty-profile-server-farm }
Liberty 프로파일 서버 팜에서 {{ site.data.keys.mf_server }}의 연결을 구성하려면 {{ site.data.keys.mf_server }}가 실행 중인 서버 팜의 각 노드에 대해 [Rational Common Licensing 라이브러리 설치](#installing-rational-common-licensing-libraries)에 설명된 모든 단계를 수행해야 합니다. 서버 팜에 대한 자세한 정보는 [서버 팜 토폴로지](../prod-env/topologies/#server-farm-topology) 및 [서버 팜 설치](../prod-env/appserver/#installing-a-server-farm)를 참조하십시오.

## WebSphere Application Server에 설치된 {{ site.data.keys.mf_server }}와 Rational License Key Server의 연결
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
{{ site.data.keys.mf_server }}를 Rational License Key Server에 연결하기 전에 WebSphere  Application Server에 Rational Common Licensing 라이브러리용 공유 라이브러리를 구성해야 합니다.

* Rational License Key Server 8.1.4.8 이상을 설치하고 구성해야 합니다. 네트워크는 양방향 통신 포트(**lmrgd** 및 **ibmratl**)를 열어 {{ site.data.keys.mf_server }}와의 통신을 허용해야 합니다. 자세한 정보는 [Rational License Key Server Portal](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) 및 [방화벽을 통해 클라이언트 머신에 라이센스 키를 제공하는 방법](http://www.ibm.com/support/docview.wss?uid=swg21257370)을 참조하십시오.
* {{ site.data.keys.product }}의 라이센스 키가 생성되었는지 확인하십시오. IBM Rational License Key Center를 사용한 라이센스 키 생성 및 관리에 대한 자세한 정보는 [IBM  지원 센터 - 라이센싱](http://www.ibm.com/software/rational/support/licensing/) 및 [IBM Rational License Key Center를 사용하여 라이센스 키 얻기](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)를 참조하십시오.
* [토큰 라이센싱을 위한 설치 개요](#installation-overview-for-token-licensing)에 설명된 대로 {{ site.data.keys.mf_server }}를 설치하고 Rational License Key Server에서 토큰 라이센싱 활성화 옵션을 사용하여 구성해야 합니다.

### 독립형 서버에 Rational Common Licensing 라이브러리 설치
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. Rational Common Licensing 라이브러리용 공유 라이브러리를 정의하십시오. 이 라이브러리는 네이티브 코드를 사용하며 애플리케이션 서버 라이프사이클 동안 클래스 로더로 한 번만 로드할 수 있습니다. 이러한 이유로, 이 라이브러리는 공유 라이브러리로 선언되며 {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 모든 애플리케이션 서버와 연관됩니다. 이 라이브러리를 공유 라이브러리로 선언하는 이유에 대한 자세한 정보는 [공유 라이브러리에서 네이티브 라이브러리 구성](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc)을 참조하십시오.
    * Rational Common Licensing 네이티브 라이브러리를 선택하십시오. 사용하는 운영 체제와 WebSphere Application Server가 실행 중인 JRE(Java Runtime Environment)의 비트 버전에 따라 **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file**에서 올바른 네이티브 라이브러리를 선택해야 합니다.

        예를 들어, 64비트 JRE가 설치된 Linux x86의 경우, 라이브러리는 **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**에 있습니다.

        독립형 WebSphere Application Server 또는 WebSphere Application Server Network Deployment 설치의 JRE(Java Runtime Environment) 비트 버전을 판별하려면 **bin** 디렉토리에서 **versionInfo.bat**(Windows의 경우) 또는 **versionInfo.sh**(UNIX의 경우)를 실행하십시오. **versionInfo.sh** 파일은 **/opt/IBM/WebSphere/AppServer/bin**에 있습니다. **설치된 제품** 섹션의 아키텍처 값을 확인하십시오. 아키텍처 값에 명시적으로 표시되어 있거나 64 또는 _64라는 접미부가 있는 경우 JRE(Java Runtime Environment)는 64비트입니다.
    * 사용하는 플랫폼에 해당하는 네이티브 라이브러리를 운영 체제의 폴더에 배치하십시오. 예를 들면, **/opt/IBM/RCL_Native_Library/**입니다.
    * **rcl_ibmratl.jar** 파일을 **/opt/IBM/RCL_Native_Library/**로 복사하십시오. **rcl_ibmratl.jar** 파일은 **product_install_dir/MobileFirstServer/tokenLibs** 디렉토리에 있는 Rational Common Licensing Java 라이브러리입니다.

        > **중요:** 애플리케이션 서버의 JVM(Java Virtual Machine)은 복사된 네이티브 및 Java 라이브러리에 대해 읽기 및 실행 권한이 필요합니다. 또한 사용하는 운영 체제에서 최소한 애플리케이션 서버 프로세스 동안 복사된 두 파일을 모두 읽고 실행할 수 있어야 합니다.    
    * WebSphere Application Server 관리 콘솔에서 공유 라이브러리를 선언하십시오.
        * WebSphere Application Server 관리 콘솔에 로그인하십시오.
        * **환경 → 공유 라이브러리**를 펼치십시오.
        * {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 모든 서버에 표시할 수 있는 범위를 선택하십시오( 예: 클러스터).
        * **새로 작성**을 클릭하십시오.
        * 이름 필드에 라이브러리의 이름을 입력하십시오. 예: "RCL Shared Library".
        * 클래스 경로 필드에 **rcl_ibmratl.jar** 파일의 경로를 입력하십시오. 예: **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * **확인**을 클릭하여 변경사항을 저장하십시오. 이 설정은 서버가 다시 시작될 때 적용됩니다.

        > **참고:** 이 라이브러리의 네이티브 라이브러리 경로는 3단계에서 서버의 JVM(Java Virtual Machine)의 **ld.library.path** 특성에 설정됩니다.
    * {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 모든 서버와 공유 라이브러리를 연관시키십시오.

        서버에 공유 라이브러리를 연관시키면 여러 애플리케이션에서 공유 라이브러리를 사용할 수 있습니다. {{ site.data.keys.mf_server }} 관리 서비스에만 Rational Common Licensing 클라이언트가 필요한 경우, 격리된 클래스 로더를 사용하여 공유 라이브러리를 작성하고 관리 서비스 애플리케이션과 연관시킬 수 있습니다.

        다음 지시사항에 따라 라이브러리를 서버와 연관시킬 수 있습니다. WebSphere Application Server Network Deployment의 경우, {{ site.data.keys.mf_server }} 관리 서비스를 실행하는 모든 서버에 대해 이 지시사항을 완료해야 합니다.    
        * 클래스 로더 정책 및 모드를 설정하십시오.    
            1. WebSphere Application Server 관리 콘솔에서 **서버 → 서버 유형 → WebSphere Application Server → server_name**을 클릭하여 애플리케이션 서버 설정 페이지에 액세스하십시오.
            2. 서버의 애플리케이션 클래스 로더 정책 및 클래스 로딩 모드의 값을 설정하십시오.
                * **클래스 로더 정책**: Multiple
                * **클래스 로딩 모드**: 처음에 상위 클래스 로더를 로드한 클래스
            3. **서버 인프라** 섹션에서 **Java 및 프로세스 관리 → 클래스 로더**를 클릭하십시오.
            4. **새로 작성**을 클릭하고 클래스 로더 순서가 **처음에 상위 클래스 로더를 로드한 클래스**로 설정되었는지 확인하십시오.
            5. **적용**을 클릭하여 새 클래스 로더 ID를 작성하십시오.                
        * 애플리케이션에 필요한 각 공유 라이브러리 파일의 라이브러리 참조를 작성하십시오.
            1. 이전 단계에서 작성한 클래스 로더의 이름을 클릭하십시오.
            2. **추가 특성** 섹션에서 **공유 라이브러리 참조**를 클릭하십시오.
            3. **추가**를 클릭하십시오.
            4. 라이브러리 참조 설정 페이지에서 적절한 라이브러리 참조를 선택하십시오. 이 이름은 애플리케이션에서 사용하는 공유 라이브러리 파일을 식별합니다. 예를 들어, RCL Shared Library입니다.
            5. **적용**을 클릭하여 변경사항을 저장하십시오.
2. {{ site.data.keys.mf_server }} 관리 서비스 웹 애플리케이션의 환경 항목을 구성하십시오.
    * WebSphere Application Server 관리 콘솔에서 **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션**을 클릭하고 관리 서비스 애플리케이션 **MobileFirst_Administration_Service**를 선택하십시오.
    * **웹 모듈 특성** 섹션에서 **웹 모듈의 환경 항목**을 클릭하십시오.
    * **mfp.admin.license.key.server.host** 및 **mfp.admin.license.key.server.port**의 값을 입력하십시오.
        * **mfp.admin.license.key.server.host**는 Rational License Key Server의 호스트 이름입니다.
        * **mfp.admin.license.key.server.port**는 Rational License Key Server의 포트입니다. 기본적으로 이 값은 27000입니다.
    * **확인**을 클릭하여 변경사항을 저장하십시오.
3. 애플리케이션 서버 JVM에 의한 Rational Common Licensing 라이브러리로의 액세스를 구성하십시오.
    * WebSphere Application Server 관리 콘솔에서 **서버 → 서버 유형 → WebSphere Application Server**를 클릭하고 서버를 선택하십시오.
    * **서버 인프라** 섹션에서 **Java 및 프로세스 관리 → 프로세스 정의 → JVM(Java Virtual Machine) → 사용자 정의 특성 → 새로 작성**을 클릭하여 사용자 정의 특성을 추가하십시오.
    * **이름** 필드에 사용자 정의 특성의 이름을 **java.library.path**로 입력하십시오.
    * **값** 필드에 1b 단계에서 네이티브 라이브러리 파일을 저장한 폴더의 경로를 입력하십시오. 예를 들면, **/opt/IBM/RCL_Native_Library/**입니다.
    * **확인**을 클릭하여 변경사항을 저장하십시오.
4. 애플리케이션 서버를 다시 시작하십시오.

### WebSphere Application Server Network Deployment에 Rational Common Licensing 라이브러리 설치
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
WebSphere Application Server Network Deployment에 네이티브 라이브러리를 설치하려면 위의 [독립형 서버에 Rational Common Licensing 라이브러리 설치](#installing-rational-common-licensing-library-on-a-stand-alone-server)에 설명된 모든 단계를 수행해야 합니다. 변경사항을 적용하려면 구성한 서버 또는 클러스터를 다시 시작해야 합니다.

WebSphere Application Server Network Deployment의 각 노드에 Rational Common Licensing 네이티브 라이브러리의 사본이 있어야 합니다.

{{ site.data.keys.mf_server }} 관리 서비스가 실행되는 각 서버는 로컬 컴퓨터에 복사된 네이티브 라이브러리에 액세스할 수 있도록 구성해야 합니다. 이러한 서버는 또한 Rational License Key Server에 연결하도록 구성해야 합니다.

> **중요:** WebSphere Application Server Network Deployment와 함께 클러스터를 사용하는 경우 클러스터가 변경될 수 있습니다. 클러스터에 새로 추가된 각 서버를 구성해야 하며, 이러한 서버에서 관리 서비스가 실행됩니다.

## 토큰 라이센싱용으로 지원되는 플랫폼의 제한사항
{: #limitations-of-supported-platforms-for-token-licensing }
토큰 라이센싱이 사용되는 {{ site.data.keys.mf_server }}를 지원하는 운영 체제, 해당 버전 및 하드웨어 아키텍처의 목록입니다.

토큰 라이센싱을 위해 {{ site.data.keys.mf_server }}는 Rational Common Licensing 라이브러리를 사용하여 Rational License Key Server에 연결해야 합니다.

이 라이브러리는 Java 라이브러리와 네이티브 라이브러리로 구성됩니다. 이러한 네이티브 라이브러리는 {{ site.data.keys.mf_server }}가 실행 중인 플랫폼에 의존합니다. 따라서 {{ site.data.keys.mf_server }}에 의한 토큰 라이센싱은 Rational Common Licensing 라이브러리가 실행될 수 있는 플랫폼에서만 지원됩니다.

다음 표에서는 토큰 라이센싱이 사용되는 {{ site.data.keys.mf_server }}를 지원하는 플랫폼에 대해 설명합니다.

| 운영 체제             | 운영 체제 버전 |	하드웨어 아키텍처 |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8(64비트 전용) |
| SUSE Linux Enterprise Server | 11	                      | x86-64 전용           |
| Windows Server               | 2012	                  | x86-64 전용           |

토큰 라이센싱은 32비트 JRE(Java Runtime Environment)를 지원하지 않습니다. 애플리케이션 서버가 64비트 JRE를 사용하는지 확인하십시오.

## 토큰 라이센싱 문제점 해결
{: #troubleshooting-token-licensing-problems }
{{ site.data.keys.mf_server }} 설치 시 토큰 라이센싱 기능을 활성화한 경우, 토큰 라이센싱에서 발생할 수 있는 문제를 해결하는 데 도움이 되는 정보를 제공합니다.

토큰 라이센싱을 위한 설치 및 구성을 완료한 후 {{ site.data.keys.mf_server }} 관리 서비스를 시작하면 애플리케이션 서버 로그 또는 {{ site.data.keys.mf_console }}에 몇 가지 오류 또는 예외가 생성될 수 있습니다. Rational Common Licensing 라이브러리의 올바르지 않은 설치 및 애플리케이션 서버의 올바르지 않은 구성으로 인해 이러한 예외가 발생할 수 있습니다.

**Apache Tomcat**  
사용하는 플랫폼에 따라 **catalina.log** 또는 catalina.out 파일을 확인하십시오.

**WebSphere® Application Server Liberty 프로파일**  
**messages.log** 파일을 확인하십시오.

**WebSphere Application Server 전체 프로파일**  
**SystemOut.log** 파일을 확인하십시오.

> **중요:** 토큰 라이센싱이 WebSphere Application Server Network Deployment 또는 클러스터에 설치된 경우에는 각 서버의 로그를 확인해야 합니다.

다음은 토큰 라이센싱을 위한 설치 및 구성 후에 발생할 수 있는 예외의 목록입니다.

* [Rational Common Licensing 네이티브 라이브러리를 찾을 수 없음](#rational-common-licensing-native-library-is-not-found)
* [Rational Common Licensing 공유 라이브러리를 찾을 수 없음](#rational-common-licensing-shared-library-is-not-found)
* [Rational License Key Server 연결이 구성되지 않았음](#the-rational-license-key-server-connection-is-not-configured)
* [Rational License Key Server에 액세스할 수 없음](#the-rational-license-key-server-is-not-accessible)
* [Rational Common Licensing API 초기화 실패](#failed-to-initialize-rational-common-licensing-api)
* [충분하지 않은 토큰 라이센스](#insufficient-token-licenses)
* [올바르지 않은 rcl_ibmratl.jar 파일](#invalid-rcl_ibmratljar-file)

### Rational Common Licensing 네이티브 라이브러리를 찾을 수 없음
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: Rational Common Licensing 네이티브 라이브러리를 찾을 수 없습니다. JVM 특성(java.library.path)이 올바른 경로로 정의되어 있으며 네이티브 라이브러리가 실행될 수 있는지 확인하십시오. 정정 조치를 수행한 후 {{ site.data.keys.mf_server }}를 다시 시작하십시오.

#### WebSphere Application Server 전체 프로파일의 경우
{: #for-websphere-application-server-full-profile }
이 오류의 가능한 원인은 다음과 같습니다.

* **java.library.path**라는 공통 특성이 서버 레벨에 정의되어 있지 않습니다.
* **java.library.path** 특성의 값으로 제공된 경로에 Rational Common Licensing 네이티브 라이브러리가 없습니다.
* 네이티브 라이브러리에 적절한 권한이 없습니다. 기본 라이브러리는 애플리케이션 서버의 Java™ Runtime Environment를 사용하여 액세스하는 사용자를 위해 UNIX 및 Windows에서
* 읽기 및 실행 권한이 있어야 합니다.

#### WebSphere Application Server Liberty 프로파일 및 Apache Tomcat의 경우
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
이 오류의 가능한 원인은 다음과 같습니다.

* java.library.path 특성의 값으로 제공된 Rational Common Licensing 네이티브 라이브러리의 경로가 설정되어 있지 않거나 올바르지 않습니다.
    * Liberty 프로파일의 경우, **${wlp.user.dir}/servers/server_name/jvm.options** 파일을 확인하십시오.
    * Apache Tomcat의 경우, 사용하는 플랫폼에 따라 **${CATALINA_HOME}/bin/setenv.bat** 파일 또는 setenv.sh 파일을 확인하십시오.
* 네이티브 라이브러리가 **java.library.path** 특성에 정의된 경로에 없습니다. 네이티브 라이브러리가 정의된 경로에 예상된 이름으로 존재하는지 확인하십시오.
* 네이티브 라이브러리에 적절한 권한이 없습니다. 이 오류 전에 다음 예외가 발생했을 수 있습니다. `com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: Access is denied`.

애플리케이션 서버의 Java Runtime Environment에 이 네이티브 라이브러리에 대한 읽기 및 실행 권한이 필요합니다. 또한 사용하는 운영 체제에서 최소한 애플리케이션 서버 프로세스 동안 라이브러리 파일을 읽고 실행할 수 있어야 합니다.

* **rcl_ibmratl.jar** 파일을 사용하는 공유 라이브러리가 Liberty 프로파일의 **${server.config.dir}/server.xml** 파일에 정의되어 있지 않습니다. 또한 **rcl_ibmratl.jar**이 올바른 디렉토리에 없거나 해당 디렉토리에 적절한 권한이 없을 수도 있습니다.
* **rcl_ibmratl.jar** 파일을 사용하는 공유 라이브러리가 Liberty 프로파일의 **${server.config.dir}/server.xml** 파일에 {{ site.data.keys.mf_server }} 관리 서비스 애플리케이션의 공통 라이브러리로 선언되어 있지 않습니다.
* 애플리케이션 서버의 Java Runtime Environment와 네이티브 라이브러리 간에 32비트 오브젝트와 64비트 오브젝트가 혼용됩니다. 예를 들어, 32비트 Java Runtime Environment가 64비트 네이티브 라이브러리와 함께 사용됩니다. 이러한 혼용은 지원되지 않습니다.

### Rational Common Licensing 공유 라이브러리를 찾을 수 없음
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: Rational Common Licensing 공유 라이브러리를 찾을 수 없습니다. 공유 라이브러리가 구성되어 있는지 확인하십시오. 정정 조치를 수행한 후 {{ site.data.keys.mf_server }}를 다시 시작하십시오.

이 오류의 가능한 원인은 다음과 같습니다.

* **rcl_ibmratl.jar** 파일이 예상 디렉토리에 없습니다.
    * Apache Tomcat의 경우, 이 파일이 **${CATALINA_HOME}/lib** 디렉토리에 있는지 확인하십시오.
    * WebSphere Application Server Liberty 프로파일의 경우, 이 파일이 server.xml 파일에 정의된 Rational Common Licensing 클라이언트의 공유 라이브러리용 디렉토리에 있는지 확인하십시오. 예를 들어, **${shared.resource.dir}/rcllib**입니다. **server.xml** 파일에서 이 공유 라이브러리가 {{ site.data.keys.mf_server }} 관리 서비스 애플리케이션의 공통 라이브러리로 올바르게 참조되었는지 확인하십시오.
    * WebSphere Application Server의 경우, 이 파일이 WebSphere Application Server 공유 라이브러리의 클래스 경로에 지정된 디렉토리에 있는지 확인하십시오. 해당 공유 라이브러리의 클래스 경로에 **absolute\_path/rcl\_ibmratl.jar** 항목이 있는지 확인하십시오. 여기서 absolute_path는 **rcl_ibmratl.jar** 파일의 절대 경로입니다.

애플리케이션 서버의 **java.library.path** 특성이 설정되어 있지 않습니다. **java.library.path** 특성을 정의하고 값으로 Rational Common Licensing 네이티브 라이브러리의 경로를 설정하십시오. 예를 들면, **/opt/IBM/RCL\_Native\_Library/**입니다.
* 네이티브 라이브러리에 예상 권한이 없습니다. Windows에서 애플리케이션 서버의 Java Runtime Environment는 네이티브 라이브러리에 대한 읽기 및 실행 권한이 있어야 합니다.
* 애플리케이션 서버의 Java Runtime Environment와 네이티브 라이브러리 간에 32비트 오브젝트와 64비트 오브젝트가 혼용됩니다. 예를 들어, 32비트 Java Runtime Environment가 64비트 네이티브 라이브러리와 함께 사용됩니다. 이러한 혼용은 지원되지 않습니다.

### Rational License Key Server 연결이 구성되지 않았음
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: Rational License Key Server 연결이 구성되지 않았습니다. 관리 JNDI 특성 "mfp.admin.license.key.server.host" 및 "mfp.admin.license.key.server.port"가 설정되어 있는지 확인하십시오. 정정 조치를 수행한 후 {{ site.data.keys.mf_server }}를 다시 시작하십시오.

이 오류의 가능한 원인은 다음과 같습니다.

* **rcl_ibmratl.jar** 파일을 사용하는 Rational Common Licensing 네이티브 라이브러리 및 공유 라이브러리가 올바르게 구성되었지만 JNDI 특성(**mfp.admin.license.key.server.host** 및 **mfp.admin.license.key.server.port**)의 값이 {{ site.data.keys.mf_server }} 관리 서비스 애플리케이션에 설정되어 있지 않습니다.
* Rational License Key Server가 작동 중지되었습니다.
* Rational License Key Server가 설치된 호스트 컴퓨터에 도달할 수 없습니다. 지정된 포트와 IP 주소 또는 호스트 이름을 확인하십시오.

### Rational License Key Server에 액세스할 수 없음
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: Rational License Key Server "{포트}@{IP 주소 또는 호스트 이름}"에 액세스할 수 없습니다. 라이센스 서버가 실행 중이고 {{ site.data.keys.mf_server }}에서 액세스할 수 있는지 확인하십시오. 런타임 시작 시 이 오류가 발생하는 경우, 정정 조치를 수행한 후 {{ site.data.keys.mf_server }}를 다시 시작하십시오.

이 오류의 가능한 원인은 다음과 같습니다.

* Rational Common Licensing 공유 라이브러리 및 네이티브 라이브러리가 올바르게 정의되어 있지만 Rational License Key Server에 연결하기 위한 올바른 구성이 없습니다. 라이센스 서버의 IP 주소, 호스트 이름 및 포트를 확인하십시오. 라이센스 서버가 시작되었고 애플리케이션 서버가 설치된 컴퓨터에서 액세스 가능한지 확인하십시오.
* 네이티브 라이브러리가 **java.library.path** 특성에 정의된 경로에 없습니다.
* 네이티브 라이브러리에 적절한 권한이 없습니다.
* 네이티브 라이브러리가 정의된 디렉토리에 없습니다.
* Rational License Key Server가 방화벽 뒤에 있습니다. 이 오류 전에 다음 예외가 발생했을 가능성이 있습니다. [오류] Rational Licence Key Server({포트}@{IP 주소 또는 호스트 이름})가 작동하지 않거나 액세스 불가능하기 때문에 애플리케이션 'WorklightStarter'의 라이센스를 가져오지 못했습니다. com.ibm.rcl.ibmratl.LicenseServerUnreachableException. 모든 라이센스 파일이 기능을 검색했습니다. {포트}@{IP 주소 또는 호스트 이름}

라이센스 관리자 디먼(lmgrd) 포트 및 공급업체 디먼(ibmratl) 포트가 방화벽에서 열려 있는지 확인하십시오. 자세한 정보는 방화벽을 통해 클라이언트 시스템에 라이센스 키를 제공하는 방법을 참조하십시오.

### Rational Common Licensing API 초기화 실패
{: #failed-to-initialize-rational-common-licensing-api }

> 네이티브 라이브러리를 찾거나 로드할 수 없기 때문에 RCL(Rational Common Licensing) API를 초기화하는 데 실패했습니다. com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl(java.library.path에 없음)

이 오류의 가능한 원인은 다음과 같습니다.

* Rational Common Licensing 네이티브 라이브러리가 **java.library.path** 특성에 정의된 경로에 없습니다. 네이티브 라이브러리가 정의된 경로에 예상된 이름으로 존재하는지 확인하십시오.
* 애플리케이션 서버의 **java.library.path** 특성이 설정되어 있지 않습니다. **java.library.path** 특성을 정의하고 값으로 Rational Common Licensing 네이티브 라이브러리의 경로를 설정하십시오. 예를 들면, **/opt/IBM/RCL_Native_Library/**입니다.
* 애플리케이션 서버의 Java Runtime Environment와 네이티브 라이브러리 간에 32비트 오브젝트와 64비트 오브젝트가 혼용됩니다. 예를 들어, 32비트 Java Runtime Environment가 64비트 네이티브 라이브러리와 함께 사용됩니다. 이러한 혼용은 지원되지 않습니다.

### 충분하지 않은 토큰 라이센스
{: #insufficient-token-licenses }

> FWLSE3129E: "{0}" 기능의 토큰 라이센스가 충분하지 않습니다.

Rational License Key Server의 남은 토큰 라이센스 수가 새 {{ site.data.keys.product_adj }} 애플리케이션을 배치하기에 부족한 경우 이 오류가 발생합니다.

### 올바르지 않은 rcl_ibmratl.jar 파일
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: 공유 라이브러리 RCL Shared Library에 올바른 jar 파일로 분석되지 않는 클래스 경로 항목이 포함되어 있습니다. 이 라이브러리 jar 파일은 {0}/rcl_ibmratl.jar에 있을 것으로 예상됩니다.

**참고:** WebSphere Application Server 및 WebSphere Application Server Network Deployment에만 해당됩니다.

이 오류의 가능한 원인은 다음과 같습니다.

* **rcl_ibmratl.jar** Java 라이브러리에 적절한 권한이 없습니다. 이 오류 후에 다음 예외가 발생할 수 있습니다. java.util.zip.ZipException: zip 파일을 여는 중에 오류 발생. **rcl_ibmratl.jar** 파일에 WebSphere Application Server를 설치하는 사용자를 위한 읽기 권한이 있는지 확인하십시오.
* 다른 예외가 없는 경우, 공유 라이브러리의 클래스 경로에서 참조되는 **rcl_ibmratl.jar** 파일이 올바르지 않거나 존재하지 않을 가능성이 있습니다. **rcl_ibmratl.jar** 파일이 올바른지 또는 정의된 경로에 있는지 확인하십시오.
