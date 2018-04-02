---
title: 서버 측 로그 콜렉션
breadcrumb_title: Server-side log collection
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

로깅은 진단과 디버깅을 용이하게 하도록 메시지를 기록하기 위해 API 호출을 사용하는 소스 코드의 인스트루먼테이션입니다. {{ site.data.keys.mf_server }}는 사용자가 원격으로 어떤 로그를 수집해야 하는지를 제어할 수 있게 합니다. 이는 서버 관리자에게 서버 자원에 대한 더 세밀한 제어 능력을 제공합니다.

로깅 라이브러리는 흔히 **레벨**이라고 불리는 상세(verbosity) 제어를 가집니다. 최소에서 최대 상세까지 ERROR, WARN, INFO, 및 DEBUG가 있습니다.

## 어댑터의 로그 콜렉션
{: #log-collection-in-adapters }

어댑터의 로그는 기반이 되는 애플리케이션 서버 로깅 메커니즘으로 볼 수 있습니다.  
WebSphere 전체 프로파일 및 Liberty 프로파일에서 지정된 로깅 레벨에 따라 **messages.log** 및 **trace.log** 파일이 사용됩니다.

이러한 로그는 또한 [Java 어댑터](java-adapter) 및 [JavaScript 어댑터](javascript-adapter)의 학습서에 설명된 대로 Analytics 콘솔로 전달될 수 있습니다.

## 로그 파일에 액세스
{: #accessing-the-log-files }

* {{ site.data.keys.mf_server }}의 사내 구축형 설치에서 파일은 기반이 되는 애플리케이션 서버에 따라 사용 가능합니다.
    * [IBM WebSphere Application Server 전체 프로파일](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty 프로파일](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* 다음에서 클라우드 배치의 로그를 얻을 수 있습니다.
    * IBM Containers 또는 Liberty 빌드 팩, [IBM Containers 로그 및 추적 콜렉션](../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/) 학습서를 참조하십시오.
    * Mobile Foundation IBM Cloud 서비스, [Mobile Foundation 사용](../../bluemix/using-mobile-foundation) 학습서에서 [서버 로그에 액세스](../../bluemix/using-mobile-foundation/#accessing-server-logs) 절을 참조하십시오. 
