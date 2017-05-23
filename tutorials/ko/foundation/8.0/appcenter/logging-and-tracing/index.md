---
layout: tutorial
title: 애플리케이션 서버에서 Application Center에 대한 로깅 및 추적 설정
breadcrumb_title: 로깅 및 추적 설정
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
특정 애플리케이션 서버에 대한 로깅 및 추적 매개변수를 설정하고 JNDI 특성을 사용하여 지원되는 모든 애플리케이션 서버의 출력을 제어할 수 있습니다.

특정 애플리케이션 서버에 고유한 방식으로 Application Center에 대한 추적 조작의 로깅 레벨과 출력 파일을 설정할 수 있습니다. 또한 {{ site.data.keys.product_full }}에서는 JNDI(Java™ Naming and Directory Interface) 특성을 제공하여 추적 출력의 형식화 및 경로 재지정을 제어하고 생성된 SQL문을 인쇄합니다. 

#### 다음으로 이동
{: #jump-to }
* [WebSphere Application Server 전체 프로파일에서 로깅 및 추적 사용](#logging-in-websphere)
* [WebSphere Application Server Liberty에서 로깅 및 추적 사용](#logging-in-liberty)
* [Apache Tomcat에서 로깅 및 추적 사용](#logging-in-tomcat)
* [추적 출력 제어를 위한 JNDI 특성](#jndi-properties-for-controlling-trace-output)

## WebSphere Application Server 전체 프로파일에서 로깅 및 추적 사용
{: #logging-in-websphere }
애플리케이션 서버에서 추적 조작에 대한 로깅 레벨 및 출력 파일을 설정할 수 있습니다. 

Application Center(또는 {{ site.data.keys.product }}의 다른 컴포넌트)에서 문제점을 진단하려고 시도하는 경우 로그 메시지를 볼 수 있다는 점이 중요합니다. 로그 파일에서 읽을 수 있는 로그 메시지를 인쇄하려면, JVM(Java™ virtual machine) 특성으로 적용 가능한 설정을 지정해야 합니다. 

1. WebSphere  Application Server 관리 콘솔을 여십시오. 
2. **문제점 해결 → 로그 및 추적**을 선택하십시오.
3. **로깅 및 추적**에서 적절한 애플리케이션 서버를 선택한 후 **로그 세부사항 레벨 변경**을 선택하십시오. 
4. 패키지 및 해당하는 세부사항 레벨을 선택하십시오. 이 예는 Application Center를 포함하여 {{ site.data.keys.product }}에 대한 로깅을 **FINEST**(**ALL**과 동등한) 레벨로 설정합니다. 

```xml
com.ibm.puremeap.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

여기서: 

* **com.ibm.puremeap.***는 Application Center용입니다.
* **com.ibm.worklight.*** 및 **com.worklight.***는 다른 {{ site.data.keys.product_adj }} 컴포넌트에 대한 것입니다. 

추적은 **SystemOut.log** 또는 **SystemErr.log**가 아닌 **trace.log**라는 파일로 전송됩니다. 

## WebSphere Application Server Liberty에서 로깅 및 추적 사용
{: #logging-in-liberty }
Liberty 애플리케이션 서버의 Application Center에 대한 추적 조작의 로깅 레벨 및 출력 파일을 설정할 수 있습니다. 

Application Center에서 문제점을 진단하려고 시도하는 경우 로그 메시지를 볼 수 있다는 점이 중요합니다. 로그 파일에서 읽을 수 있는 로그 메시지를 인쇄하려면, 적용 가능한 설정을 지정해야 합니다. 

Application Center를 포함하여 {{ site.data.keys.product }}에 대한 로깅을 FINEST(ALL과 동등한) 레벨로 사용하도록 설정하려면, server.xml 파일에 행을 추가하십시오. 예: 

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

이 예에서, 패키지의 여러 항목 및 해당하는 로깅 레벨은 콜론(:)으로 구분됩니다. 

추적은 **messages.log** 또는 **console.log**가 아닌 **trace.log**라는 파일로 전송됩니다. 

자세한 정보는 [Liberty 프로파일: 로깅 및 추적](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc)을 참조하십시오. 

## Apache Tomcat에서 로깅 및 추적 사용
{: #logging-in-tomcat }
Apache Tomcat 애플리케이션 서버에서 수행되는 추적 조작에 대한 로깅 레벨 및 출력 파일을 설정할 수 있습니다.

Application Center에서 문제점을 진단하려고 시도하는 경우 로그 메시지를 볼 수 있다는 점이 중요합니다. 로그 파일에서 읽을 수 있는 로그 메시지를 인쇄하려면, 적용 가능한 설정을 지정해야 합니다. 

Application Center를 포함하여 {{ site.data.keys.product }}에 대한 로깅을 **FINEST**(**ALL**과 동등한) 레벨로 사용하도록 설정하려면, **conf/logging.properties** 파일을 편집하십시오. 예를 들어, 다음 행과 유사한 행을 추가하십시오. 

```xml
com.ibm.puremeap.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

자세한 정보는 [Tomcat에서 로깅](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)을 참조하십시오. 

## 추적 출력 제어를 위한 JNDI 특성
{: #jndi-properties-for-controlling-trace-output }
지원되는 모든 플랫폼에서 JNDI(Java™ Naming and Directory Interface) 특성을 사용하여 Application Center에 대한 추적 출력의 형식화 및 경로를 재지정하고 생성된 SQL문을 인쇄할 수 있습니다. 

다음 JNDI 특성을 Application Center 서비스(**applicationcenter.war**)에 대한 웹 애플리케이션에 적용할 수 있습니다. 

| 특성 설정         | 설정    | 설명        | 
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | 기본적으로 이 특성은 false로 설정됩니다. true로 설정하면 로그 파일에서 쉽게 읽을 수 있도록 JSON 출력을 공백으로 형식화합니다. | 
| ibm.appcenter.logging.tosystemerror | true | 기본적으로 이 특성은 false로 설정됩니다. true로 설정하면 모든 로그 메시지를 로그 파일의 시스템 오류에 인쇄합니다. 해당 특성을 사용하여 글로벌 로깅을 켜십시오. | 
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE | 이 설정은 생성된 모든 SQL문을 로그 파일에 인쇄합니다. | 
