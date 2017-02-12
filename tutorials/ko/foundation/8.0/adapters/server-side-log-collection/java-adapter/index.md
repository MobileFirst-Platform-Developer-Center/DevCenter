---
layout: tutorial
title: Java 어댑터에서 로깅
relevantTo: [ios,android,windows,javascript]
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

이 학습서는 로깅 기능을 Java 어댑터에 추가하기 위해 필요한 코드 스니펫을 제공합니다. 

## 로깅 예제
{: #logging-example }

java 로깅 패키지를 가져오십시오.

```java
import java.util.logging.Logger;
```

로거를 정의하십시오.

```java
static Logger logger = Logger.getLogger(JavaLoggerTestResource.class.getName());
```

이제 메소드 내부에 로깅을 포함하십시오. 

```java
logger.warning("Logging warning message...");
```

이 메시지는 애플리케이션 서버의 `trace.log` 파일에 출력됩니다. 서버 관리자가 로그를 {{ site.data.keys.mf_server }}에서
{{ site.data.keys.mf_analytics_server }}로 전달 중인 경우 `logger` 메시지가 {{ site.data.keys.mf_analytics_console }}의 **인프라스트럭처 → 서버 로그 검색** 보기에도 표시됩니다. 

## 로그 파일에 액세스
{: #accessing-the-log-files }

* {{ site.data.keys.mf_server }}의 사내 구축형 설치에서 파일은 기반이 되는 애플리케이션 서버에 따라 사용 가능합니다. 
    * [IBM WebSphere Application Server 전체 프로파일](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty 프로파일](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* 다음에서 클라우드 배치의 로그를 얻을 수 있습니다. 
    * IBM Containers 또는 Liberty 빌드 팩, [IBM Containers 로그 및 추적 콜렉션](../../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/) 학습서를 참조하십시오.
    * Mobile Foundation Bluemix 서비스, [Mobile Foundation 사용](../../../bluemix/using-mobile-foundation) 학습서에서 [서버 로그에 액세스](../../../bluemix/using-mobile-foundation/#accessing-server-logs) 섹션을 참조하십시오. 

## Analytics 서버로 로그 전달
{: #forwarding-logs-to-the-analytics-server }

로그는 또한 Analytics 콘솔에 전달될 수 있습니다. 

1. {{ site.data.keys.mf_console }}의 사이드바 탐색에서 **설정** 옵션을 선택하십시오. 
2. **런타임 특성 탭**에 있는 **편집** 단추를 클릭하십시오. 
3. **Analytics → 추가 패키지** 섹션에서 로그를 {{ site.data.keys.mf_server }}로 전달하려면 Java 어댑터의 클래스 이름을 예를 들어 `com.sample.JavaLoggerTestResource`로 지정하십시오. 

![콘솔에서 로그 필터링](java-filter.png)
