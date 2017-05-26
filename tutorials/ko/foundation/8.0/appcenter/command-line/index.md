---
layout: tutorial
title: 애플리케이션 업로드 또는 삭제를 위한 명령행 도구
breadcrumb_title: 앱 업로드 또는 삭제
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
빌드 프로세스를 통해 애플리케이션을 Application Center에 배치하려면 명령행 도구를 사용하십시오. 

Application Center 콘솔의 웹 인터페이스를 사용하여 Application Center에 애플리케이션을 업로드할 수 있습니다. 또한 명령행 도구를 사용하여 새 애플리케이션을 업로드할 수 있습니다. 

Application Center에 대한 애플리케이션 배치를 빌드 프로세스에 통합하려는 경우 특히 유용합니다. 이 도구는 다음 위치에 있습니다. **installDir/ApplicationCenter/tools/applicationcenterdeploytool.jar**.

이 도구는 확장자가 APK 또는 IPA인 애플리케이션 파일에 사용할 수 있습니다. 독립형 또는 Ant 태스크로 사용할 수 있습니다. 

도구 디렉토리에는 도구 사용을 지원하는 데 필요한 모든 파일이 포함되어 있습니다. 

* **applicationcenterdeploytool.jar**: 업로드 도구. 
* **json4j.jar**: 업로드 도구에 필요한 JSON 형식의 라이브러리. 
* **build.xml**: 단일 파일 또는 일련의 파일을 Application Center에 업로드하는 데 사용할 수 있는 샘플 Ant 스크립트. 
* **acdeploytool.sh** 및 **acdeploytool.bat**: **applicationcenterdeploytool.jar**을 사용하여 java를 호출하기 위한 간단한 스크립트. 

#### 다음으로 이동
{: #jump-to }
* [애플리케이션을 업로드하는 데 독립형 도구 사용](#using-the-stand-alone-tool-to-upload-an-application)
* [애플리케이션을 삭제하는 데 독립형 도구 사용](#using-the-stand-alone-tool-to-delete-an-application)
* [LDAP 캐시를 지우는 데 독립형 도구 사용](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [애플리케이션을 업로드 또는 삭제하기 위한 Ant 태스크](#ant-task-for-uploading-or-deleting-an-application)

### 애플리케이션을 업로드하는 데 독립형 도구 사용
{: #using-the-stand-alone-tool-to-upload-an-application }
애플리케이션을 업로드하려면 명령행에서 독립형 도구를 호출하십시오.   
다음 단계를 수행하여 독립형 도구를 사용하십시오. 

1. **applicationcenterdeploytool.jar** 및 **json4j.jar**을 java 클래스 경로 환경 변수에 추가하십시오. 
2. 명령행에서 업로드 도구를 호출하십시오. 

   ```bash
   java com.ibm.appcenter.Upload [options] [files]
   ```

명령행에서 사용 가능한 옵션을 전달할 수 있습니다. 

| 옵션   | 컨텐츠 표시          | 설명        |
|--------|----------------------|-------------|
| -s | serverpath | Application Center 서버에 대한 경로.  |
| -c | context | Application Center 웹 애플리케이션의 컨텍스트.  |
| -u | user | Application Center에 액세스하기 위한 사용자 신임 정보.  |
| -p | password | 사용자의 비밀번호.  |
| -d | description | 업로드할 애플리케이션에 대한 설명.  |
| -l | label | 대체 레이블. 일반적으로 업로드할 파일에 저장되어 있는 애플리케이션 디스크립터에서 레이블을 가져옵니다. 애플리케이션 디스크립터에 레이블이 없는 경우 대체 레이블이 사용됩니다.  |
| -isActive | true 또는 false | 애플리케이션이 활성 또는 비활성 애플리케이션으로 Application Center에 저장됩니다.  |
| -isInstaller | true 또는 false | 애플리케이션이 "설치 프로그램" 플래그가 적절히 설정되어 Application Center에 저장됩니다.  |
| -isReadyForProduction | true 또는 false | 애플리케이션이 "프로덕션 준비 완료" 플래그가 적절히 설정되어 Application Center에 저장됩니다.  |
| -isRecommended | true 또는 false | 애플리케이션이 "권장" 플래그가 적절히 설정되어 Application Center에 저장됩니다.  |
| -e	  |  | 실패 시 전체 예외 스택 추적을 표시합니다.  |
| -f	  |  | 애플리케이션이 이미 있는 경우에도 애플리케이션을 강제로 업로드합니다.  |
| -y	  |  | SSL 보안 검사를 사용 안함으로 설정합니다. 이를 통해 SSL 인증서의 유효성을 검증하지 않고 보안 호스트에 공개할 수 있습니다.  |  이 플래그를 사용하면 보안 위험이 발생할 수 있지만, 임시 자체 서명 SSL 인증서로 로컬 호스트를 테스트하는 데 적합합니다.  |

파일 매개변수는 Android 애플리케이션 패키지(.apk) 파일 또는 iOS 애플리케이션(.ipa) 파일의 파일 유형을 지정할 수 있습니다.   
이 예에서 사용자 demo의 비밀번호는 demopassword입니다. 이 명령행을 사용하십시오. 

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### 애플리케이션을 삭제하는 데 독립형 도구 사용
{: #using-the-stand-alone-tool-to-delete-an-application }
Application Center에서 애플리케이션을 삭제하려면 명령행에서 독립형 도구를 호출하십시오.   
다음 단계를 수행하여 독립형 도구를 사용하십시오. 

1. **applicationcenterdeploytool.jar** 및 **json4j.jar**을 java 클래스 경로 환경 변수에 추가하십시오. 
2. 명령행에서 업로드 도구를 호출하십시오. 

   ```bash
   java com.ibm.appcenter.Upload -delete [options] [files or applications]
   ```

명령행에서 사용 가능한 옵션을 전달할 수 있습니다. 

| 옵션   | 컨텐츠 표시         	| 설명        |
|--------|----------------------|-------------|
| -s |serverpath | Application Center 서버에 대한 경로.  |
| -c | context | Application Center 웹 애플리케이션의 컨텍스트.  |
| -u | user | Application Center에 액세스하기 위한 사용자 신임 정보.  |
| -p | password | 사용자의 비밀번호.  |
| -y | | SSL 보안 검사를 사용 안함으로 설정합니다. 이를 통해 SSL 인증서의 유효성을 검증하지 않고 보안 호스트에 공개할 수 있습니다. 이 플래그를 사용하면 보안 위험이 발생할 수 있지만, 임시 자체 서명 SSL 인증서로 로컬 호스트를 테스트하는 데 적합합니다.  |

파일 또는 애플리케이션 패키지, 운영 체제, 버전을 지정할 수 있습니다. 파일이 지정되는 경우 패키지, 운영 체제 및 버전은 파일에서 결정되고 해당 애플리케이션이 Application Center에서 삭제됩니다. 애플리케이션이 지정되는 경우 형식은 다음 중 하나여야 합니다. 

* `package@os@version`: 정확히 이 버전이 Application Center에서 삭제됩니다. 버전 부분은 애플리케이션의 "상업용 버전"이 아닌 "내부 버전"을 지정해야 합니다. 
* `package@os`: 이 애플리케이션의 모든 버전이 Application Center에서 삭제됩니다. 
* `package`: 이 애플리케이션의 모든 운영 체제에 대한 모든 버전이 Application Center에서 삭제됩니다. 

#### 예
{: #example-delete }
이 예에서 사용자 demo의 비밀번호 demopassword입니다. 이 명령행을 사용하여 내부 버전 3.0의 iOS 애플리케이션 demo.HelloWorld를 삭제하십시오. 

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### LDAP 캐시를 지우는 데 독립형 도구 사용
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
독립형 도구를 사용하여 LDAP 캐시를 지우고 LDAP 사용자 및 그룹의 변경사항이 Application Center에 즉시 표시되도록 지정하십시오. 

Application Center가 LDAP으로 구성된 경우 LDAP 서버에 있는 사용자 및 그룹의 변경사항은 지연 이후에 Application Center에 표시됩니다. Application Center는 LDAP 데이터의 캐시를 유지하며 변경사항은 캐시가 만료된 후에만 표시됩니다. 기본적으로 지연 시간은 24시간입니다. 사용자 또는 그룹을 변경한 후 이 지연 시간이 만료될 때까지 기다리지 않으려면, 명령행에서 독립형 도구를 호출하여 LDAP 데이터의 캐시를 지울 수 있습니다. 독립형 도구를 사용하여 캐시를 지우면 변경사항이 즉시 표시됩니다. 

다음 단계를 수행하여 독립형 도구를 사용하십시오. 

1. applicationcenterdeploytool.jar 및 json4j.jar을 java 클래스 경로 환경 변수에 추가하십시오. 
2. 명령행에서 업로드 도구를 호출하십시오. 

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [options]
   ```

명령행에서 사용 가능한 옵션을 전달할 수 있습니다. 

| 옵션   | 컨텐츠 표시          | 설명        |
|--------|----------------------|-------------|
| -s | serverpath | Application Center 서버에 대한 경로. |
| -c | context | Application Center 웹 애플리케이션의 컨텍스트. |
| -u | user | Application Center에 액세스하기 위한 사용자 신임 정보. |
| -p | password | 사용자의 비밀번호. |
| -y | | SSL 보안 검사를 사용 안함으로 설정합니다. 이를 통해 SSL 인증서의 유효성을 검증하지 않고 보안 호스트에 공개할 수 있습니다. 이 플래그를 사용하면 보안 위험이 발생할 수 있지만, 임시 자체 서명 SSL 인증서로 로컬 호스트를 테스트하는 데 적합합니다. |

#### 예
{: #example-cache }
이 예에서 사용자 demo의 비밀번호 demopassword입니다. 

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### 애플리케이션을 업로드하거나 삭제하기 위한 Ant 태스크
{: #ant-task-for-uploading-or-deleting-an-application}
업로드 및 삭제 도구를 Ant 태스크로 사용하고 사용자의 Ant 스크립트에서 Ant 태스크를 사용할 수 있습니다.   
이 태스크를 실행하려면 Apache Ant가 필요합니다. Apache Ant의 최소 지원 버전은 [시스템 요구사항](../../product-overview/requirements)에 나열되어 있습니다. 

편의를 위해 Apache Ant 1.8.4는 {{ site.data.keys.mf_server }}에 포함되어 있습니다. product_install_dir/shortcuts/ 디렉토리에서 다음 스크립트가 제공됩니다. 

* UNIX/Linux용 ant
* Windows용 ant.bat

이러한 스크립트는 실행할 준비가 되어 있으며, 특정 환경 변수가 필요하지 않음을 의미합니다. 환경 변수 JAVA_HOME이 설정되어 있는 경우 스크립트는 이를 허용합니다. 

업로드 도구로 Ant 태스크를 사용하는 경우 업로드 Ant 태스크의 클래스 이름 값은 **com.ibm.appcenter.ant.UploadApps**입니다. 삭제 Ant 태스크의 클래스 이름 값은 **com.ibm.appcenter.ant.DeleteApps**입니다. 

| Ant 태스크의 매개변수  | 설명        |
|------------------------|-------------|
| serverPath | Application Center에 연결합니다. 기본값은 http://localhost:9080입니다.  |
| context | Application Center의 컨텍스트입니다. 기본값은 /applicationcenter입니다.  |
| loginUser | 애플리케이션을 업로드할 권한이 있는 사용자 이름입니다.  |
| loginPass | 애플리케이션을 업로드할 권한이 있는 사용자의 비밀번호입니다.  |
| forceOverwrite | 이 매개변수가 true로 설정되어 있는 경우 이미 있는 애플리케이션을 업로드할 때 Ant 태스크가 Application Center의 애플리케이션을 겹쳐쓰려고 시도합니다. 이 매개변수는 업로드 Ant 태스크에서만 사용할 수 있습니다.
| file | Application Center에 업로드되거나 Application Center에서 삭제될 .apk 또는 .ipa 파일. 이 매개변수는 기본값이 없습니다.  |
| fileset | 여러 파일을 업로드하거나 삭제합니다.  |
| application | 애플리케이션의 패키지 이름. 이 매개변수는 삭제 Ant 태스크에서만 사용할 수 있습니다.  |
| os | 애플리케이션의 운영 체제. (예: Android 또는 iOS.) 이 매개변수는 삭제 Ant 태스크에서만 사용할 수 있습니다.  |
| version | 애플리케이션의 내부 버전. 이 매개변수는 삭제 Ant 태스크에서만 사용할 수 있습니다. 상업용 버전은 버전을 정확히 식별하는 데 적합하지 않으므로 여기에 상업용 버전을 사용하지 마십시오.  |

#### 예
{: #example-ant }
**ApplicationCenter/tools/build.xml** 디렉토리에서 확장된 예를 찾을 수 있습니다.   
다음 예는 사용자의 Ant 스크립트에서 Ant 태스크를 사용하는 방법을 나타냅니다. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Server Properties -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" />
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!--  Authentication Properties -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps">
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

이 샘플 Ant 스크립트는 **tools** 디렉토리에 있습니다. 이 스크립트를 사용하여 단일 애플리케이션을 Application Center에 업로드할 수 있습니다. 

```bash
ant upload.App -Dupload.file=sample.ipa
```

또한 이 스크립트를 사용하여 디렉토리 계층 구조에서 찾은 모든 애플리케이션을 업로드할 수 있습니다. 

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### 샘플 Ant 스크립트의 특성
{: #properties-of-the-sample-ant-script }
| 특성     | 주석    |
|----------|---------|
| install.dir | 기본값이 ../../로 지정됩니다.  |
| server.path | 기본값은 http://localhost:9080입니다.  |
| context.path | 기본값은 applicationcenter입니다.  |
| upload.file | 이 특성에는 기본값이 없습니다. 여기에는 정확한 파일 경로가 포함되어 있어야 합니다.  |
| workspace.root | 기본값이 ../../로 지정됩니다.  |
| login.user | 기본값은 appcenteradmin입니다. |
| login.pass | 기본값은 admin입니다. |
| force |	기본값은 true입니다.  |

Ant를 호출할 때 명령행에 이러한 매개변수를 지정하려면, 특성 이름 앞에 -D를 추가하십시오. 예: 

```xml
-Dserver.path=http://localhost:8888/
```
