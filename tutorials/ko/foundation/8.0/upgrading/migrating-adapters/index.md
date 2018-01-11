---
layout: tutorial
title: MobileFirst Server V8.0.0에서 작동하도록 기존 어댑터 마이그레이션
breadcrumb_title: 기존 어댑터 마이그레이션
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server }} v8.0부터 어댑터는 Maven 프로젝트입니다. 이전 버전의 {{ site.data.keys.mf_server }}에서 개발된 어댑터를 업그레이드하는 방법에 대해 학습합니다. 

이 페이지에서는 MobileFirst Server V6.2 이상에 대해 작동하도록 개발된 어댑터를 {{ site.data.keys.mf_server }} v8.0에 대해 작동하도록 마이그레이션하기 위해 수행해야 하는 단계를 설명합니다.   
우선 [v8.0에서 더 이상 사용되지 않는 기능 및 API 요소와 서버 측 API 변경사항](../../product-overview/release-notes/deprecated-discontinued/)에서 설명하는 어댑터 API의 변경사항을 살펴보십시오. 

* 특정 조건 하에서 기존 어댑터는 {{ site.data.keys.mf_server }} v8.0에 대해서도 그대로 작동합니다. [{{ site.data.keys.mf_server }} V8.0에서 기존 어댑터를 그대로 사용](#using-older-adapters-as-is-under-mobilefirst-server-v-80)을 참조하십시오. 
* 대부분의 경우 어댑터를 업그레이드해야 합니다. Java™ 어댑터의 경우 [Java 어댑터를 {{ site.data.keys.mf_server }} v8.0을 위한 Maven 프로젝트로 마이그레이션](#migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80)을 참조하십시오. JavaScript 어댑터의 경우 [JavaScript 어댑터를 {{ site.data.keys.mf_server }} v8.0을 위한 Maven 프로젝트로 마이그레이션](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)을 참조하십시오. 

## {{ site.data.keys.mf_server }} v8.0에서 기존 어댑터를 그대로 사용
{: #using-older-adapters-as-is-under-mobilefirst-server-v-80 }
다음 기준에 일치하지 않는 경우 기존 어댑터를 {{ site.data.keys.mf_server }} v8.0에 그대로 배치할 수 있습니다. 

| 어댑터 유형| 조건| 
|--------------|-----------|
| Java| PushAPI 또는 SecurityAPI 인터페이스 사용| 
| JavaScript| {::nomarkdown}<ul><li>IBM Worklight V6.2 이하를 사용하여 빌드되었습니다. </li><li>HTTP 또는 SQL이 아닌 연결 유형을 사용합니다. </li><li>securityTest 사용자 정의가 있는 프로시저 포함</li><li>사용자 ID로 백엔드에 연결하는 프로시저 포함</li><li>다음 API를 사용합니다. <ul><li>WL.Device.*</li><li>WL.Geo.\*</li><li>WL.Server.readSingleJMSMessage</li><li>WL.Server.readAllJMSMessages</li><li>WL.Server.writeJMSMessage</li><li>WL.Server.requestReplyJMSMessage</li><li>WL.Server.getActiveUser</li><li>WL.Server.setActiveUser</li><li>WL.Server.getCurrentUserIdentity</li><li>WL.Server.getCurrentDeviceIdentity</li><li>WL.Server.createEventSource</li><li>WL.Server.createDefaultNotification</li><li>WL.Server.getUserNotificationSubscription</li><li>WL.Server.notifyAllDevices</li><li>WL.Server.notifyDeviceToken</li><li>WL.Server.notifyDeviceSubscription</li><li>WL.Server.sendMessage</li><li>WL.Server.createEventHandler</li><li>WL.Server.setEventHandlers</li><li>WL.Server.setApplicationContext</li><li>WL.Server.fetchNWBusinessObject</li><li>WL.Server.createNWBusinessObject</li><li>WL.Server.deleteNWBusinessObject</li><li>WL.Server.updateNWBusinessObject</li><li>WL.Server.getBeaconsAndTriggers</li><li>WL.Server.signSoapMessage</li><li>WL.Server.createSQLStatement</li></ul></li></ul>{:/} |

## Java 어댑터를 {{ site.data.keys.mf_server }} v8.0을 위한 Maven 프로젝트로 마이그레이션
{: #migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80}
1. **adapter-maven-archetype-java** 원형을 사용하여 Maven 어댑터 프로젝트를 작성하십시오. **artifactId** 매개변수를 설정하는 경우 어댑터 이름을 사용하고 **package** 매개변수의 경우 기존 Java 어댑터의 패키지와 동일한 패키지를 사용하십시오. 자세한 정보는 [Java 어댑터 작성](../../adapters/creating-adapters)을 참조하십시오. 
2. 1단계에서 작성한 새 어댑터 프로젝트의 **src/main/adapter-resources** 폴더에 있는 어댑터 디스크립터 파일(**adapter.xml**)을 겹쳐쓰십시오. 디스크립터에 대한 세부사항은 [Java 어댑터 디스크립터 파일](../../adapters/java-adapters/#the-adapter-resources-folder)을 참조하십시오. 
3. 새 어댑터 프로젝트의 **src/main/java** 폴더에서 모든 파일을 제거하십시오. 그런 다음 폴더 구조는 동일하게 유지하면서 이전 Java 어댑터 프로젝트의 **src/** 폴더에서 모든 Java 파일을 복사하십시오. 이전 어댑터의 **src** 폴더에 있는 모든 비Java 파일을 새 어댑터의 **src/main/resources** 폴더로 복사하십시오. 기본적으로 **src/main/resources**는 존재하지 않습니다. 따라서 어댑터에 비Java 파일이 포함되어 있는 경우 이를 작성하십시오. Java 어댑터 API의 변경사항에 대한 자세한 정보는 [v8.0에서 서버 측 API 변경사항](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)을 참조하십시오. 

   다음 다이어그램은 v7.1까지의 어댑터 구조와 v8.0부터의 Maven 어댑터 구조를 설명합니다. 

   ```xml
├── adapters
    │   └── RSSAdapter
    │       ├── RSSAdapter.xml
    │       ├── lib
    │       └── src
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```
    
   Java 어댑터의 새 구조:

   ```xml
├── pom.xml
    ├── src
    │   └── main
    │       ├── adapter-resources
    │       │   └── adapter.xml
    │       └── java
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```

4. 다음 메소드 중 하나를 사용하여 Maven 저장소에 없는 JAR 파일을 추가하십시오. 
    * [Guide to installing third-party JARs](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html)의 설명에 따라 로컬 저장소에 JAR 파일을 추가한 후 **dependencies** 요소에 해당 파일을 추가하십시오. 
    * **systemPath** 요소를 사용하여 dependencies 요소에 JAR 파일을 추가하십시오. 자세한 정보는 [Introduction to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)을 참조하십시오. 

## JavaScript 어댑터를 {{ site.data.keys.mf_server }} v8.0을 위한 Maven 프로젝트로 마이그레이션
{: #migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80 }
1. **adapter-maven-archetype-http 또는 adapter-maven-archetype-sql** 원형을 사용하여 Maven 어댑터 프로젝트를 작성하십시오. **artifactId** 매개변수를 설정하는 경우 어댑터 이름을 사용하십시오. 자세한 정보는 [JavaScript 어댑터 작성](../../adapters/creating-adapters)을 참조하십시오. 
2. 1단계에서 작성한 새 어댑터 프로젝트의 **src/main/adapter-resources** 폴더에 있는 어댑터 디스크립터 파일(**adapter.xml**)을 겹쳐쓰십시오. 디스크립터에 대한 세부사항은 [JavaScript 어댑터 디스크립터 파일](../../adapters/javascript-adapters/#the-adapter-resources-folder)을 참조하십시오. 
3. 새 어댑터 프로젝트의 **src/main/adapter-resources/js** 폴더에 있는 Javascript 파일을 겹쳐쓰십시오. 
