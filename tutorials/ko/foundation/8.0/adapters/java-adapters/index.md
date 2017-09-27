---
layout: tutorial
title: Java 어댑터
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

Java 어댑터는 JAX-RS 2.0 스펙을 기반으로 합니다. 즉, Java 어댑터는 JAX-RS 2.0 서비스로 {{ site.data.keys.mf_server }} 인스턴스에 쉽게 배치될 수 있으며 {{ site.data.keys.mf_server }} API 및 기타 써드파티 API에 대한 액세스 권한을 가집니다. 

**전제조건:** [Java 및 JavaScript 어댑터 작성](../creating-adapters) 학습서를 먼저 읽으십시오.

#### 다음으로 이동
{: #jump-to }

* [파일 구조](#file-structure)
* [JAX-RS 2.0 애플리케이션 클래스](#jax-rs-20-application-class)
* [JAX-RS 2.0 자원 구현](#implementing-a-jax-rs-20-resource)
* [HTTP 세션](#http-session)
* [서버 측 API](#server-side-apis)

## 파일 구조
{: #file-structure }

![mvn-adapter](java-adapter-fs.png)

### adapter-resources 폴더  
{: #the-adapter-resources-folder }

**adapter-resources** 폴더는 XML 구성 파일(**adapter.xml**)을 포함합니다. 이 구성 파일에서 이 어댑터에 대해 JAX-RS 2.0 애플리케이션의 클래스 이름을 구성합니다. 예: `com.sample.JavaAdapterApplication`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaAdapter"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaAdapter</displayName>
	<description>JavaAdapter</description>

	<JAXRSApplicationClass>com.sample.JavaAdapterApplication</JAXRSApplicationClass>

	<property name="DB_url" displayName="Database URL" defaultValue="jdbc:mysql://127.0.0.1:3306/mobilefirst_training"  />
	<property name="DB_username" displayName="Database username" defaultValue="mobilefirst"  />
	<property name="DB_password" displayName="Database password" defaultValue="mobilefirst"  />

	<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    	<property name="maxAttempts" defaultValue="3"/>
	</securityCheckDefinition>
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>adapter.xml 속성 및 하위 요소에 대해 클릭</b></a>
        </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>name</b>: <i>필수.</i> 어댑터 이름입니다. 이 이름은 {{ site.data.keys.mf_server }} 내에서 고유해야 합니다. 이름은 영숫자 문자 및 밑줄을 포함할 수 있으며 문자로 시작해야 합니다. 어댑터를 정의하고 배치한 후에는 이름을 수정할 수 없습니다. </li>
					<li><b>displayName</b>: <i>선택사항.</i> {{ site.data.keys.mf_console }}에 표시되는 어댑터의 이름입니다. 이 요소가 지정되지 않으면 이름 속성 값이 대신 사용됩니다. </li>
					<li><b>description</b>: <i>선택사항.</i> 어댑터에 대한 추가 정보입니다. {{ site.data.keys.mf_console }}에 표시됩니다. </li>
					<li><b>JAXRSApplicationClass</b>: <i>어댑터 엔드포인트를 노출하기 위해 필수. </i> 이 어댑터의 JAX-RS 애플리케이션의 클래스 이름을 정의합니다. 이 예에서는 <b>com.sample.JavaAdapterApplication</b>입니다. </li>
					<li><b>securityCheckDefinition</b>: <i>선택사항.</i> 보안 검사 오브젝트를 정의합니다. <a href="../../authentication-and-security/creating-a-security-check">보안 검사 작성</a> 학습서에서 보안 검사에 대해 자세히 알아보십시오. </li>
					<li><b>property</b>: <i>선택사항.</i> 사용자 정의 특성을 선언합니다. 아래 사용자 정의 특성 주제에서 자세히 알아보십시오. </li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>섹션 닫기</b></a>.
            </div>
        </div>
    </div>
</div>

#### 사용자 정의 특성
{: #custom-properties }

**adapter.xml** 파일은 또한 사용자 정의 사용자 정의 특성을 포함할 수 있습니다. 어댑터 작성 동안 개발자가 지정하는 값은 어댑터를 재배치하지 않고 **{{ site.data.keys.mf_console }} → [사용자의 어댑터] → 구성 탭**에서 대체될 수 있습니다.사용자 정의 특성은 [구성 API 인터페이스](#configuration-api)를 사용하여 읽은 후 런타임 시 추가로 사용자 정의될 수 있습니다.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **참고:** 구성 특성 요소는 `JAXRSApplicationClass` 요소 **아래**에 위치해야 합니다.   
위의 예제에서 연결 설정을 정의했고 기본값을 제공했으므로 나중에 AdapterApplication 클래스에 사용할 수 있습니다.

`<property>` 요소는 다음 속성을 사용합니다. 

- **name**: 구성 클래스에 정의된 특성의 이름입니다. 
- **defaultValue**: 구성 클래스에 정의된 기본값을 대체합니다. 
- **displayName**: *선택사항*, 콘솔에 표시될 친근한 이름.
- **description**: *선택사항*, 콘솔에 표시될 설명.
- **type**: *선택사항*, `integer`, `string`, `boolean` 또는 유효값의 목록과 같이 특정 유형의 특성을 확인합니다(예: `type="['1','2','3']"`).

![콘솔 특성](console-properties.png)

#### 구성 풀 및 푸시
{: #pull-and-push-configurations }

사용자 정의된 어댑터 특성은 **구성 파일 탭**에서 발견되는 어댑터 구성 파일을 사용하여 공유될 수 있습니다.   
이를 수행하기 위해서 Maven 또는 {{ site.data.keys.mf_cli }} 중 하나를 사용하여 아래 설명된 `pull` 및 `push` 명령을 사용하십시오. 공유할 특성에 대해서는 *특성에 제공된 기본값을 변경*해야 합니다. 

어댑터 Maven 프로젝트의 루트 폴더에서 명령을 실행하십시오. 

**Maven**  

* 구성 파일을 **풀**하려면 다음을 실행하십시오.   
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```

* 구성 파일을 **푸시**하려면 다음을 실행하십시오. 
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* 구성 파일을 **풀**하려면 다음을 실행하십시오. 
  ```bash
  mfpdev adapter pull
  ```

* 구성 파일을 **푸시**하려면 다음을 실행하십시오. 
  ```bash
  mfpdev adapter push
  ```

#### 다중 서버에 구성 푸시
{: #pushing-configurations-to-multiple-servers }

**pull** 및 **push** 명령은 다양한 DevOps 플로우를 작성하도록 도울 수 있으며 이러한 플로우에서는 사용자가 위치한 환경(DEV, QA, UAT, PRODUCTION)에 따라 어댑터에 여러 다양한 값이 필요합니다. 

**Maven**  
위의 **config.json** 파일을 기본적으로 지정하는 방법을 기록하십시오. 여러 대상을 다루기 위해 여러 이름으로 파일을 작성하십시오. 

**{{ site.data.keys.mf_cli }}**  
**--configFile** 또는 **-c** 플래그를 사용하여 기본값과 다른 구성 파일을 지정하십시오. 

```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> `mfpdev help adapter pull/push`를 사용하여 자세히 알아보십시오. 

### java 폴더
{: #the-java-folder }

JAX-RS 2.0 서비스의 Java 소스는 이 폴더에 있습니다. JAX-RS 2.0 서비스는 애플리케이션 클래스(`com.ibm.mfp.adapter.api.MFPJAXRSApplication`을 확장) 및 자원 클래스로 구성됩니다. 

JAX-RS 2.0 애플리케이션 및 자원 클래스는 Java 메소드 및 URL로의 맵핑을 정의합니다.   
`com.sample.JavaAdapterApplication`은 JAX-RS 2.0 애플리케이션 클래스 및 `com.sample.JavaAdapterResource`는 애플리케이션에 포함된 JAX-RS 2.0 자원입니다. 

## JAX-RS 2.0 애플리케이션 클래스
{: #jax-rs-20-application-class }

JAX-RS 2.0 애플리케이션 클래스는 애플리케이션에 포함된 자원을 JAX-RS 2.0 프레임워크에 알립니다. 

```java
package com.sample.adapter;

import java.util.logging.Logger;
import com.ibm.mfp.adapter.api.MFPJAXRSApplication;

public class JavaAdapterApplication extends MFPJAXRSApplication{

    static Logger logger = Logger.getLogger(JavaAdapterApplication.class.getName());

    @Override
    protected void init() throws Exception {
        logger.info("Adapter initialized!");
    }

    @Override
    protected String getPackageToScan() {
        //The package of this class will be scanned (recursively) to find JAX-RS 2.0 resources.
        return getClass().getPackage().getName();
    }
}
```

`MFPJAXRSApplication` 클래스는 JAX-RS 2.0 자원에 대한 패키지를 스캔하고 목록을 자동으로 작성합니다. 또한 `init` 메소드는 어댑터가 배치된 즉시(제공을 시작하기 전에) 및 {{ site.data.keys.product }} 런타임이 시작될 때 {{ site.data.keys.mf_server }}에서 호출합니다. 

## JAX-RS 2.0 자원 구현
{: #implementing-a-jax-rs-20-resource }

JAX-RS 2.0 자원은 POJO (Plain Old Java Object)이며 루트 URL에 맵핑되고 이 루트 URL 및 하위 URL에 대한 요청을 제공하는 Java 메소드를 가집니다.모든 자원에는 별도의 URL 세트가 있을 수 있습니다. 

```java
package com.sample.adapter;

import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/")
public class JavaAdapterResource {

    //Define logger (Standard java.util.Logger)
    static Logger logger = Logger.getLogger(JavaAdapterResource.class.getName());

    //Path for method: "<server address>/Adapters/adapters/JavaAdapter/{username}"
    @GET
    @Path("/{username}")
    public String helloUser(@PathParam("username") String name){
        return "Hello " + name;
    }
}
```

* 클래스 정의 앞에 `@Path("/")`는 이 자원의 루트 경로를 판별합니다. 다중 자원 클래스가 있는 경우 각 자원에 다른 경로를 설정해야 합니다.   

	예를 들어 블로그의 사용자를 관리하기 위해 `UserResource`를 `@Path("/users")`와 함께 사용하면 해당 자원은 `http(s)://host:port/ProjectName/adapters/AdapterName/users/`를 통해 액세스 가능합니다. 

	동일한 어댑터가 블로그의 포스트를 관리하기 위해 다른 자원 `PostResource`을 `@Path("/posts")`와 함께 포함할 수 있습니다. 해당 자원은 `http(s)://host:port/ProjectName/adapters/AdapterName/posts/` URL을 통해 액세스 가능합니다.   

	위의 예제에서는 하나의 자원 클래스만 있으므로 `http(s)://host:port/Adapters/adapters/JavaAdapter/`를 통해 액세스 가능하도록 `@Path("/")`로 설정됩니다.  

* 각 메소드의 앞에 하나 이상의 JAX-RS 2.0 어노테이션이 선행합니다. 예를 들어 `@GET`, `@PUT`, `@POST`, `@DELETE`, 또는 `@HEAD`와 같은 "HTTP 요청" 유형의 어노테이션입니다. 이러한 어노테이션은 메소드가 액세스되는 방법을 정의합니다.  

* 다른 예는 `@Path("/{username}")`이며 (자원 레벨 경로에 추가로) 이 프로시저에 액세스하기 위한 경로를 정의합니다.표시된 것처럼 이 경로는 변동 파트를 포함할 수 있습니다. 그런 다음 이 변수는 `@PathParam("username") String name`에 정의된 대로 메소드의 매개변수로 사용됩니다.   

> 다른 많은 어노테이션을 사용할 수 있습니다. 여기에서 **어노테이션 유형 요약**을 참조하십시오. 
[https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html](https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html)

>**중요:** 어댑터 구현 내에서 `javax.ws.rs.*` 또는 `javax.servlet.*`의 클래스에 대해 정적 참조를 사용하는 경우에는 아래 옵션 중 하나를 사용하여 **RuntimeDelegate**를 구성해야 합니다.
*	Liberty `jvm.options`의 `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` 설정
또는
*	시스템 특성 또는 JVM 사용자 정의 특성 `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` 설정


## HTTP 세션
{: #http-session }

{{ site.data.keys.mf_server }}는 HTTP 세션에 의존하지 않으며 각 요청은 다른 노드에 도달할 수 있습니다. 한 요청에서 다른 요청까지 데이터를 유지하려면 HTTP 세션에 의존하면 안 됩니다. 

## 서버 측 API
{: #server-side-apis}

Java 어댑터는 다른 어댑터 호출, 서버 로그에 로깅, 구성 특성 값 획득, Analytics에 활동 보고, 요청 발행자 ID 획득과 같이 {{ site.data.keys.mf_server }}와 관련된 조작을 수행하기 위해 서버 측 Java API를 사용할 수 있습니다.   

### 구성 API
{: #configuration-api }

`ConfigurationAPI` 클래스는 **adapter.xml** 또는 {{ site.data.keys.mf_console }}에 정의된 특성을 검색하기 위해 API를 제공합니다. 

Java 클래스 내부에서 클래스 레벨로 다음을 추가하십시오. 

```java
@Context
ConfigurationAPI configurationAPI;
```

그런 다음 `configurationAPI` 인스턴스를 사용하여 특성을 가져올 수 있습니다. 

```java
configurationAPI.getPropertyValue("DB_url");
```

어댑터 구성이 {{site.data.keys.mf_console }}에서 수정될 때 JAX-RS 애플리케이션 클래스가 다시 로드되고 해당 `init` 메소드가 다시 호출됩니다. 

`getServerJNDIProperty` 메소드는 서버 구성에서 JNDI 특성을 검색하도록 사용될 수도 있습니다. 

[Java SQL 어댑터 학습서](java-sql-adapter)에서 사용법 예제를 참조할 수 있습니다. 

### 어댑터 API
{: #adapters-api }

`AdaptersAPI` 클래스는 현재 어댑터에 대한 정보를 검색하고 REST 요청을 다른 어댑터에 보내기 위해 API를 제공합니다. 

Java 클래스 내부에서 클래스 레벨로 다음을 추가하십시오. 

```java
@Context
AdaptersAPI adaptersAPI;
```

[고급 어댑터 사용법 매시업 학습서](../advanced-adapter-usage-mashup)에서 사용 예제를 볼 수 있습니다. 

### 분석 API
{: #analytics-api }

`AnalyticsAPI` 클래스는 분석에 정보를 보고하기 위해 API를 제공합니다. 

Java 클래스 내부에서 클래스 레벨로 다음을 추가하십시오. 

```java
@Context
AnalyticsAPI analyticsAPI;
```

[Analytics API 학습서](../../analytics/analytics-api)에서 사용법 예제를 참조할 수 있습니다. 

### 보안 API
{: #security-api }

`AdapterSecurityContext` 클래스는 어댑터 REST 호출의 보안 컨텍스트를 제공합니다. 

Java 클래스 내부에서 클래스 레벨로 다음을 추가하십시오. 

```java
@Context
AdapterSecurityContext securityContext;
```

그런 다음 예를 들면, 다음을 사용하여 현재 `AuthenticatedUser`를 가져올 수 있습니다.

```java
AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
```

## Java 어댑터 예제
{: #java-adapter-examples }

HTTP 또는 SQL 백엔드와 통신하는 Java 어댑터와 관련된 예제는 다음을 참조하십시오.
