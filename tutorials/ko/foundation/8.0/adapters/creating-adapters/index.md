---
layout: tutorial
title: Java 및 JavaScript 어댑터 작성
breadcrumb_title: Creating Adapters
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
어댑터는 Maven 명령 또는 {{ site.data.keys.mf_cli }}(설치 및 구성되는 Maven에 종속된)를 사용하여 작성될 수 있습니다. 어댑터 코드는 Eclipse 및 IntelliJ와 같이 사용자가 선택한 IDE를 사용하여 편집 및 빌드할 수 있습니다. 이 학습서에서는 Maven 및 {{ site.data.keys.mf_cli }}를 사용하여 **Java 또는 JavaScript 어댑터**를 작성, 빌드 및 배치하는 방법을 설명합니다. 어댑터를 작성하고 빌드하기 위해 Eclipse 또는 IntelliJ IDE를 사용하는 방법을 알아보려면 [Eclipse에서 어댑터 개발](../developing-adapters) 학습서를 검토하십시오.

**전제조건:** 먼저 [어댑터 개요](../)를 읽어야 합니다.

#### 다음으로 이동
{: #jump-to }
* [Maven 설치](#install-maven)
* [{{ site.data.keys.mf_cli }}를 사용하여 어댑터 작성](#creating-adapters-using-mobilefirst-cli)
* [{{ site.data.keys.mf_cli }} 설치](#install-mobilefirst-cli)
* [어댑터 작성](#creating-an-adapter)
* [Maven 아키타입을 사용하여 어댑터 작성](#creating-adapters-using-maven-archetype-adapter-maven-archetype)
* [파일 구조](#file-structure)
* [어댑터 빌드 및 배치](#build-and-deploy-adapters)
* [종속성](#dependencies)
* [단일 Maven 프로젝트에서 어댑터 그룹화](#grouping-adapters-in-a-single-maven-project)
* [{{ site.data.keys.mf_console }}을 사용하여 어댑터 다운로드 또는 배치](#downloading-or-deploying-adapters-using-mobilefirst-operations-console)
* [어댑터 Maven 프로젝트 업데이트](#updating-the-adapter-maven-project)
* [오프라인으로 작업](#working-offline)
* [다음 학습서](#tutorials-to-follow-next)

## Maven 설치
{: #install-maven }
어댑터를 작성하려면 먼저 Maven을 다운로드하고 설치해야 합니다. [Apache Maven 웹 사이트](https://maven.apache.org/)로 이동하여 Maven을 다운로드하고 설치하는 방법에 대한 지시사항을 따르십시오.

## {{ site.data.keys.mf_cli }}를 사용하여 어댑터 작성
{: #creating-adapters-using-mobilefirst-cli }

### {{ site.data.keys.mf_cli }} 설치
{: #install-mobilefirst-cli }
{{ site.data.keys.mf_cli }}를 설치하려면 [다운로드]({{site.baseurl}}/downloads/) 페이지에서 설치 지시사항을 따르십시오.  
**전제조건:** Developer CLI를 사용하여 어댑터를 작성하려면 Maven이 설치되어 있어야 합니다.

### 어댑터 작성
{: #creating-an-adapter }
Maven 어댑터 프로젝트를 작성하려면 `mfpdev adapter create` 명령을 사용하십시오.
명령을 직접 또는 대화식으로 실행하도록 선택할 수 있습니다.

#### 대화식 모드
{: #interactive-mode }
1. **명령행** 창을 열고 다음을 실행하십시오.

   ```bash
   mfpdev adapter create
   ```

2. 어댑터 이름을 입력하십시오. 예:

   ```bash
   ? Enter Adapter Name: SampleAdapter
   ```

3. 화살표와 Enter 키를 사용하여 어댑터 유형을 선택하십시오.

   ```bash
   ? Select Adapter Type:
      HTTP
      SQL
   ❯ Java
   ```
  * `HTTP`를 선택하여 JavaScript HTTP 어댑터를 작성하십시오.
  * `SQL`를 선택하여 JavaScript SQL 어댑터를 작성하십시오.  
  * `Java`를 선택하여 Java 어댑터를 작성하십시오.

4. 어댑터 패키지를 입력하십시오(이 옵션은 Java 어댑터에만 유효합니다.). 예:

   ```bash
   ? Enter Package: com.mypackage
   ```

5. 빌드할 Maven 프로젝트의 [그룹 ID](https://maven.apache.org/guides/mini/guide-naming-conventions.html)를 입력하십시오. 예:

   ```bash
   ? Enter Group ID: com.mycompany
   ```

#### 직접 모드
{: #direct-mode }
실제 값으로 플레이스홀더를 대체하고 명령을 실행하십시오.

```bash
mfpdev adapter create <adapter_name> -t <adapter_type> -p <adapter_package_name> -g <maven_project_groupid>
```

## Maven 아키타입 "adapter-maven-archetype"을 사용하여 어댑터 작성
{: #creating-adapters-using-maven-archetype-adapter-maven-archetype }

"adapter-maven-archetype"은 [Maven 아키타입 툴킷](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html)을 기반으로 하는 {{ site.data.keys.product }} 제공 아키타입이며 어댑터 Maven 프로젝트를 작성하기 위해 Maven에서 사용합니다.

Maven 어댑터 프로젝트를 작성하려면 `archetype:generate` Maven 명령을 사용하십시오. 명령이 실행되면, Maven은 어댑터 Maven 프로젝트를 생성하기 위해 필수 파일을 다운로드하거나 위에 언급된 로컬 저장소를 사용합니다.

명령을 직접 또는 대화식으로 실행하도록 선택할 수 있습니다.

#### 대화식 모드
{: #interactive-mode-archetype }

1. **명령행** 창에서 사용자가 선택한 위치로 이동하십시오.  
이는 또한 Maven 프로젝트가 생성될 위치입니다.

2. **DarchetypeArtifactId** 플레이스홀더를 실제 값으로 대체하고 다음을 실행하십시오.

   ```bash
   mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=replace-with-the-adapter-type-artifact-ID
   ```
   
  * `Archetype Group Id` 및 Archetype Version은 아키타입을 식별하기 위한 필수 매개변수입니다.
  * `Archetype Artifact Id`는 어댑터 유형을 식별하기 위한 필수 매개변수입니다.
     * Java 어댑터를 작성하려면 `adapter-maven-archetype-java`를 사용하십시오.
     * JavaScript HTTP 어댑터를 작성하려면 `adapter-maven-archetype-http`를 사용하십시오.
     * JavaScript SQL 어댑터를 작성하려면 `adapter-maven-archetype-sql`을 사용하십시오.  

3. 빌드할 Maven 프로젝트의 [그룹 ID](https://maven.apache.org/guides/mini/guide-naming-conventions.html)를 입력하십시오. 예:

   ```bash
   Define value for property 'groupId': : com.mycompany
   ```

4. Maven 프로젝트의 아티팩트를 입력하십시오. **이 아티팩트는 나중에 어댑터 이름으로도 사용됩니다**. 예:

   ```bash
   Define value for property 'artifactId': : SampleAdapter
   ```

5. Maven 프로젝트 버전을 입력하십시오(기본값은 `1.0-SNAPSHOT`). 예:

   ```bash
   Define value for property 'version':  1.0-SNAPSHOT: : 1.0
   ```

6. 어댑터 패키지 이름을 입력하십시오(기본값은 `groupId`). 예:

   ```bash
   Define value for property 'package':  com.mycompany: : com.mypackage
   ```

7. `y`를 눌러 다음을 확인하십시오.

   ```bash
   Confirm properties configuration:
   groupId: com.mycompany
   artifactId: SampleAdapter
   version: 1.0
   package: com.mypackage
   archetypeVersion: 8.0.0
   Y: : y
   ```

#### 직접 모드
{: #direct-mode-archetype }
실제 값으로 플레이스홀더를 대체하고 명령을 실행하십시오.

```bash
mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=<adapter type artifact ID> -DgroupId=<maven_project_groupid> -DartifactId=<maven_project_artifactid>  -Dpackage=<adapter_package_name>
```

> `archetype:generate` 명령에 대한 자세한 정보는 [Maven 문서](http://maven.apache.org/)를 참조하십시오.

## 파일 구조
{: #file-structure }
어댑터를 작성한 후 결과는 **src** 폴더와 **pom.xml** 파일을 포함하는 Maven 프로젝트가 됩니다.

![mvn-adapter](adapter-fs.png)

## 어댑터 빌드 및 배치
{: #build-and-deploy-adapters }

### 빌드
{: #build }

* **{{ site.data.keys.mf_cli }} 사용** - 프로젝트의 루트 폴더에서 `adapter build` 명령을 실행하십시오.
    
  ```bash
  mfpdev adapter build
  ```
    
* **Maven 사용** - Maven 프로젝트를 빌드하기 위해 `install` 명령을 실행할 때마다 어댑터가 빌드됩니다.

  ```bash
  mvn install
  ```

### 모두 빌드
{: #build-all }
파일 시스템 폴더에 여러 개의 어댑터가 있고 모두를 빌드하려면 다음을 사용하십시오.

```bash
mfpdev adapter build all
```

결과는 각 어댑터의 **target** 폴더에서 볼 수 있는 **.adapter** 아카이브 파일입니다.

![java-adapter-result](adapter-result.png)

### 배치
{: #deploy }

1. **pom.xml** 파일은 다음 `properties`를 포함합니다.

   ```xml
   <properties>
    	<!-- parameters for deploy mfpf adapter -->
    	<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    	<mfpfUser>admin</mfpfUser>
    	<mfpfPassword>admin</mfpfPassword>
    	<mfpfRuntime>mfp</mfpfRuntime>
   </properties>
   ```
   
   * **localhost:9080**을 {{ site.data.keys.mf_server }} IP 주소 및 포트 번호로 대체하십시오.
   * **선택사항**. **mfpfUser** 및 **mfpfPassword** 기본값을 admin 사용자 이름 및 비밀번호로 대체하십시오.
   * **선택사항**. **mfpfRuntime** 기본값을 런타임 이름으로 대체하십시오.
2. 프로젝트의 루트 폴더에서 배치 명령을 실행하십시오.
 * **{{ site.data.keys.mf_cli }} 사용**:

   ```bash
   mfpdev adapter deploy -x
   ```
   
   `-x` 옵션은 어댑터의 **pom.xml** 파일에 지정된 {{ site.data.keys.mf_server }}에 어댑터를 배치합니다.  
옵션이 사용되지 않으면 CLI가 CLI 설정에 지정된 기본 서버를 사용합니다.
    
   > 추가 CLI 배치 옵션에 대해서는 다음 명령을 실행하십시오. `mfpdev help adapter deploy`.
   
 * **Maven 사용**:

   ```bash
   mvn adapter:deploy
   ```

### 모두 배치
{:# deploy-all }
파일 시스템 폴더에 여러 개의 어댑터가 있고 모두 배치하려면 다음을 사용하십시오.

```bash
mfpdev adapter deploy all
```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** 단일 명령 `mvn install adapter:deploy`를 사용하여 어댑터를 빌드하고 배치할 수도 있습니다.

### 여러 런타임에 배치
{: #deploying-to-different-runtimes }
다중 런타임이 있는 경우 [애플리케이션 등록 및 여러 런타임에 어댑터 배치](../../installation-configuration/production/server-configuration/#registering-applications-and-deploying-adapters-to-different-runtimes)를 참조하십시오.

## 종속성
{: #dependencies }
어댑터에서 외부 라이브러리를 사용하려면 다음 제안된 지시사항 중 하나를 따르십시오.

#### 로컬 종속성 추가
{: #adding-a-local-dependency }

1. 루트 Maven 프로젝트 폴더 아래에 **lib** 폴더를 추가하고 그 안에 외부 라이브러리를 넣으십시오.
2. Maven 프로젝트의 **pom.xml** 파일에서 `dependencies` 요소 아래에 라이브러리 경로를 추가하십시오.  

예:

```xml
<dependency>
<groupId>sample</groupId>
<artifactId>com.sample</artifactId>
<version>1.0</version>
<scope>system</scope>
<systemPath>${project.basedir}/lib/</systemPath>
</dependency>
```

#### 외부 종속성 추가
{: #adding-an-external-dependency }

1. [중앙 저장소](http://search.maven.org/)와 같은 온라인 저장소에서 종속성을 검색하십시오.
2. POM 종속성 정보를 복사하고 Maven 프로젝트의 **pom.xml** 파일에서 `dependencies` 요소 아래에 붙여넣으십시오.

다음 예제는 `cloudant-client artifactId`를 사용합니다.

```xml
<dependency>
  <groupId>com.cloudant</groupId>
  <artifactId>cloudant-client</artifactId>
  <version>1.2.3</version>
</dependency>
```

> 종속성에 관한 자세한 정보는 Maven 문서를 참조하십시오.

## 단일 Maven 프로젝트에서 어댑터 그룹화
{: #grouping-adapters-in-a-single-maven-project }

프로젝트에 여러 어댑터가 있다면 단일 Maven 프로젝트 하에서 배열하고 싶을 수 있습니다. 어댑터를 그룹화하면 모두 빌드, 모두 배치 및 종속성 공유와 같은 장점이 있습니다. 또한 `mfpdev adapter build all` 및 `mfpdev adapter deploy all` CLI 명령을 사용하여 단일 Maven 프로젝트에서 그룹화하지 않은 경우에도 모든 어댑터를 빌드하고 배치할 수 있습니다.

어댑터를 그룹화하려면 다음을 수행해야 합니다.

1. 루트 폴더를 작성하고 이름 지정(예를 들어 "GroupAdapters")하십시오.
2. Maven 어댑터 프로젝트를 루트 폴더 안에 넣으십시오.
3. **pom.xml** 파일을 작성하십시오.

   ```xml
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    	<modelVersion>4.0.0</modelVersion>
    	<groupId>com.sample</groupId>
    	<artifactId>GroupAdapters</artifactId>
    	<version>1.0-SNAPSHOT</version>
    	<packaging>pom</packaging>

    	<modules>
				<module>Adapter1</module>
				<module>Adapter2</module>
    	</modules>

    	<properties>
    		<!-- parameters for deploy mfpf adapter -->
    		<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    		<mfpfUser>admin</mfpfUser>
    		<mfpfPassword>admin</mfpfPassword>
        <mfpfRuntime>mfp</mfpfRuntime>
    	</properties>

   <build>
        <plugins>
			<plugin>
				<groupId>com.ibm.mfp</groupId>
				<artifactId>adapter-maven-plugin</artifactId>
				<extensions>true</extensions>
			</plugin>
		</plugins>
   </build>

   </project>
   ```
   
  1. 선택한 **`groupId`** 요소를 정의하십시오.
  2. **`artifactId`** 요소 - 루트 폴더의 이름을 추가하십시오.
  3. 각 어댑터에 대해 **`module`** 요소를 추가하십시오.
  4. **`build`** 요소를 추가하십시오.
  5. **선택사항**. **localhost:9080**을 특정 {{ site.data.keys.mf_server }} IP 주소 및 포트 번호로 대체하십시오.
  6. **선택사항**. **`mfpfUser`** 및 **`mfpfPassword`** 기본값을 admin 사용자 이름 및 비밀번호로 대체하십시오.
  7. **선택사항**. **`mfpfRuntime`** 기본값을 런타임 이름으로 대체하십시오.

4. 모든 어댑터를 [빌드 또는 배치](#build-and-deploy-adapters)하려면 루트 "GroupAdapters" 프로젝트에서 Maven 명령을 실행하십시오.

## {{ site.data.keys.mf_console }}을 사용하여 어댑터 다운로드 또는 배치
{: #downloading-or-deploying-adapters-using-mobilefirst-operations-console}

1. 선택한 브라우저를 열고 주소 `http://<IP>:<PORT>/mfpconsole/`을 사용하여 {{ site.data.keys.mf_console }}을 로드하십시오.  
2. 어댑터 옆의 "새로 작성" 단추를 클릭하십시오. 어댑터를 작성하는 두 개의 옵션이 있습니다.
 * 위에서 이미 설명한 것처럼 Maven 또는 {{ site.data.keys.mf_cli }}를 사용합니다.
 * 템플리트 어댑터 프로젝트를 다운로드합니다(2 단계).
3. Maven 또는 {{ site.data.keys.mf_cli }}를 사용하여 어댑터를 빌드하십시오.
4. 다음 방법 중 하나를 선택하여, 어댑터 프로젝트의 대상 폴더에서 찾을 수 있는 생성된 **.adapter** 파일을 업로드하십시오.
 * 어댑터 배치 단추를 클릭하십시오(5 단계).
 * 어댑터 "새로 작성" 화면으로 파일을 끌어서 놓으십시오.

    ![콘솔을 사용하여 어댑터 작성](Create_adapter_console.png)

5. 어댑터 배치를 완료한 후 다음 탭을 포함하는 세부사항 페이지가 표시됩니다.
 * 구성 - 어댑터 XML 파일에 정의된 특성. 다시 배치할 필요 없이 여기서 구성을 변경할 수 있습니다.
 * 자원 - 어댑터 자원의 목록.
 * 구성 파일 - DevOps 환경에서 사용될 어댑터 구성 데이터.

## 어댑터 Maven 프로젝트 업데이트
{: #updating-the-adapter-maven-project }

최신 릴리스로 어댑터 Maven 프로젝트를 업데이트하려면 [Maven의 중앙 저장소](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation)에서 "IBM MobileFirst Platform"을 검색하여 API 및 플러그인 아티팩트의 **버전 번호**를 찾은 다음, 어댑터 Maven 프로젝트의 **pom.xml** 파일에서 다음 특성을 업데이트하십시오.

1. `adapter-maven-api` 버전:

   ```xml
   <dependency>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-api</artifactId>
      <scope>provided</scope>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
   </dependency>
   ```
   
2. `adapter-maven-plugin` 버전:

   ```xml
   <plugin>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-plugin</artifactId>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
      <extensions>true</extensions>
   </plugin>
   ```

## 오프라인으로 작업
{: #working-offline }

Maven 중앙 저장소에 대한 온라인 액세스 권한이 없는 경우 조직의 내부 저장소에 있는 {{ site.data.keys.product }} Maven 아티팩트를 공유할 수 있습니다.

1. [다운로드 페이지를 방문]({{site.baseurl}}/downloads/)하여 {{ site.data.keys.mf_dev_kit_full }} 설치 프로그램을 다운로드하십시오.
2. {{ site.data.keys.mf_server }}를 시작하고 브라우저에서 URL: `http://<your-server-host:server-port>/mfpconsole`을 통해 {{ site.data.keys.mf_console }}을 로드하십시오.
3. **다운로드 센터**를 클릭하십시오. **도구 → 어댑터 아키타입** 아래에서 **다운로드**를 클릭하십시오. **mfp-maven-central-artifacts-adapter.zip** 아카이브가 다운로드됩니다.
4. **install.sh** 스크립트(Linux 및 Mac의 경우) 또는 **install.bat** 스크립트(Windows의 경우)를 실행하여 내부 Maven 저장소에 어댑터 아키타입 및 보안 검사를 추가하십시오.
5. 다음 JAR 파일은 adapter-maven-api에 필요합니다. 이러한 파일들이 개발자의 로컬 **.m2** 폴더 또는 사용자 조직의 Maven 저장소 중 하나에 위치하는지 확인하십시오. 중앙 저장소에서 JAR 파일을 다운로드할 수 있습니다.
    * javax.ws.rs:javax.ws.rs-api:2.0
    * javax:javaee-web-api:6.0
    * org.apache.httpcomponents:httpclient:4.3.4
    * org.apache.httpcomponents:httpcore:4.3.2
    * commons-logging:commons-logging:1.1.3
    * javax.xml:jaxp-api:1.4.2
    * org.mozilla:rhino:1.7.7
    * io.swagger:swagger-annotations:1.5.6
    * com.ibm.websphere.appserver.api:com.ibm.websphere.appserver.api.json:1.0
    * javax.servlet:javax.servlet-api:3.0.1

## 다음 학습서
{: #tutorials-to-follow-next }

* [Java 어댑터 학습](../java-adapters/)
* [JavaScript 어댑터 학습](../javascript-adapters/)
* [IDE에서 어댑터 개발](../developing-adapters/)
* [어댑터 테스트 및 디버깅](../testing-and-debugging-adapters/)
* [모든 어댑터 학습서 검토](../#tutorials-to-follow-next)
