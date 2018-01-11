---
layout: tutorial
title: 토폴로지 및 네트워크 플로우
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
여기에서 제공하는 정보는 {{ site.data.keys.mf_server }} 컴포넌트의 가능한 서버 토폴로지 및 사용 가능한 네트워크 플로우에 대해 자세히 설명합니다.   
컴포넌트는 사용하는 서버 토폴로지에 따라 배치됩니다. 네트워크 플로우는 컴포넌트가 서로 통신하는 방법과 일반 사용자 디바이스와 통신하는 방법을 설명합니다. 

#### 다음으로 이동
{: #jump-to }

* [{{ site.data.keys.mf_server }} 컴포넌트 간의 네트워크 플로우](#network-flows-between-the-mobilefirst-server-components)
* [{{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건](#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)
* [복수 {{ site.data.keys.product }} 런타임](#multiple-mobilefirst-foundation-runtimes)
* [동일 서버 또는 WebSphere Application Server 셀의 복수 {{ site.data.keys.mf_server }} 인스턴스](#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell)

## {{ site.data.keys.mf_server }} 컴포넌트 간의 네트워크 플로우
{: #network-flows-between-the-mobilefirst-server-components }
{{ site.data.keys.mf_server }} 컴포넌트는 JMX 또는 HTTP를 통해 서로 통신할 수 있습니다. 이러한 통신을 가능하게 하려면 특정 JNDI 특성을 구성해야 합니다.  
다음 이미지는 컴포넌트와 디바이스 간의 네트워크 플로우를 설명합니다. 

![ {{ site.data.keys.product }} 컴포넌트 네트워크 플로우 다이어그램](mfp_components_network_flows.jpg)

다양한 {{ site.data.keys.mf_server }} 컴포넌트, {{ site.data.keys.mf_analytics }}, 모바일 디바이스 및 애플리케이션 서버 사이의 플로우에 대해서는 다음 절에서 설명합니다.

1. [{{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_server }} 관리 서비스로](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)
2. [{{ site.data.keys.mf_server }} 관리 서비스에서 다른 서버의 {{ site.data.keys.product }} 런타임으로](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers)
3. [{{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.product_adj }} 런타임에서 WebSphere Application Server Network Deployment의 배치 관리자로](#mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment)
4. [{{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_analytics }}](#mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics)로
5. [{{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 라이브 업데이트 서비스로](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service)
6. [{{ site.data.keys.mf_console }}에서 {{ site.data.keys.mf_server }} 관리 서비스로](#mobilefirst-operations-console-to-mobilefirst-server-administration-service)
7. [{{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 푸시 서비스 및 권한 부여 서버로](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)
8. [{{ site.data.keys.mf_server }} 푸시 서비스에서 외부 푸시 알림 서비스로(아웃바운드)](#mobilefirst-server-push-service-to-an-external-push-notification-service-outbound)
9. [모바일 디바이스에서 {{ site.data.keys.product }} 런타임으로](#mobile-devices-to-mobilefirst-foundation-runtime)

### {{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_server }} 관리 서비스로
{: #mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service }
런타임과 관리 서비스는 JMX 및 HTTP를 통해 서로 통신할 수 있습니다. 이 통신은 런타임의 초기화 단계 중에 수행됩니다. 런타임은 해당 애플리케이션 서버에 대해 로컬인 관리 서비스에 접속하여 서비스를 제공해야 하는 어댑터 및 애플리케이션 목록을 가져옵니다. {{ site.data.keys.mf_console }} 또는 관리 서비스에서 일부 관리 조작이 실행되는 경우에도 통신이 수행됩니다. WebSphere  Application Server Network Deployment에서 런타임은 셀의 다른 서버에 설치된 관리 서비스에 접속할 수 있습니다. 이로써 비대칭 배치가 가능해집니다([{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) 참조). 그러나 기타 모든 애플리케이션 서버(Apache Tomcat, WebSphere Application Server Liberty 또는 독립형 WebSphere Application Server)에서는 관리 서비스가 런타임과 동일한 서버에서 실행 중이어야 합니다. 

JMX의 프로토콜은 애플리케이션 서버에 따라 다릅니다. 

* Apache Tomcat - RMI
* WebSphere Application Server Liberty - HTTPS(REST 커넥터 포함)
* WebSphere Application Server - SOAP 또는 RMI

JMX를 통한 통신의 경우, 애플리케이션 서버에서 이러한 프로토콜이 사용 가능해야 합니다. 요구사항에 대한 자세한 정보는 [애플리케이션 서버 전제조건](../appserver/#application-server-prerequisites)을 참조하십시오.

런타임 및 관리 서비스의 JMX Bean은 애플리케이션 서버에서 얻습니다. 그러나 WebSphere Application Server Network Deployment의 경우 배치 관리자에서 JMX Bean을 얻습니다. 배치 관리자에는 WebSphere Application Server Network Deployment에 있는 셀의 모든 Bean에 대한 보기가 있습니다. 따라서 WebSphere Application Server Network Deployment에서는 일부 구성(예: 팜 구성)이 필요 없고 비대칭 배치가 가능합니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)을 참조하십시오. 

동일한 애플리케이션 서버 또는 동일한 WebSphere Application Server 셀에 있는 {{ site.data.keys.mf_server }}의 서로 다른 설치를 구별하기 위해 JNDI 변수인 환경 ID를 사용할 수 있습니다. 기본적으로 이 변수는 빈 값을 가집니다. 지정된 환경 ID를 갖는 런타임은 동일한 환경 ID를 갖는 관리 서비스와만 통신합니다. 예를 들어, 관리 서비스의 환경 ID가 X로 설정되어 있고 런타임의 환경 ID가 이와 다른 경우(예를 들어, Y인 경우), 이 두 컴포넌트는 서로를 인식할 수 없습니다. {{ site.data.keys.mf_console }}에는 사용 가능한 런타임이 표시되지 않습니다. 

관리 서비스는 클러스터의 모든 {{ site.data.keys.product }} 런타임 컴포넌트와 통신할 수 있어야 합니다. 새 버전의 어댑터 업로드 또는 애플리케이션의 활성 상태 변경과 같은 관리 조작이 실행되는 경우, 클러스터의 모든 런타임 컴포넌트에서 이러한 변경에 대한 알림을 수신해야 합니다. 애플리케이션 서버가 WebSphere Application Server Network Deployment가 아닌 경우에는 팜이 구성된 경우에만 이러한 통신이 수행될 수 있습니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)을 참조하십시오. 

또한 런타임은 HTTP 또는 HTTPS를 통해 관리 서비스와 통신하여 어댑터와 같은 대형 아티팩트를 다운로드합니다. 관리 서비스에 의해 URL이 생성되고 런타임이 아웃바운드 HTTP 또는 HTTPS 연결을 열어 이 URL의 아티팩트를 요청합니다. 관리 서비스에서 JNDI 특성(mfp.admin.proxy.port, mfp.admin.proxy.protocol 및 mfp.admin.proxy.host)을 정의하여 기본 URL 생성을 대체할 수 있습니다. 또한 관리 서비스는 푸시 조작을 실행하는 데 사용되는 OAuth 토큰을 얻기 위해 HTTP 또는 HTTPS를 통해 런타임과 통신해야 할 수도 있습니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 푸시 서비스 및 권한 부여 서버로](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)를 참조하십시오. 

런타임과 관리 서비스 사이의 통신에 사용되는 JNDI 특성은 다음과 같습니다. 

#### {{ site.data.keys.mf_server }} 관리 서비스
{: #mobilefirst-server-administration-service }

* [관리 서비스의 JNDI 특성: JMX](../server-configuration/#jndi-properties-for-administration-service-jmx)
* [관리 서비스의 JNDI 특성: 프록시](../server-configuration/#jndi-properties-for-administration-service-proxies)
* [관리 서비스의 JNDI 특성: 토폴로지](../server-configuration/#jndi-properties-for-administration-service-topologies)

#### {{ site.data.keys.product }} 런타임
{: #mobilefirst-foundation-runtime }

* [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

### {{ site.data.keys.mf_server }} 관리 서비스에서 다른 서버의 {{ site.data.keys.product }} 런타임으로
{: #mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers }
[{{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_server }} 관리 서비스로](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)에 설명된 대로, 관리 서비스와 클러스터의 모든 런타임 컴포넌트 사이에는 통신이 필요합니다. 관리 조작이 실행되면 클러스터의 모든 런타임 컴포넌트에서 이러한 수정에 대한 알림을 수신할 수 있습니다. 통신은 JMX를 통해 수행됩니다. 

WebSphere Application Server Network Deployment에서는 특정한 구성 없이 이 통신이 수행될 수 있습니다. 동일한 환경 ID에 해당되는 모든 JMX MBean은 배치 관리자에서 얻습니다.

독립형 WebSphere Application Server, WebSphere Application Server Liberty 프로파일 또는 Apache Tomcat 클러스터에서는 팜이 구성된 경우에만 통신이 수행될 수 있습니다. 자세한 정보는 [서버 팜 설치](../appserver/#installing-a-server-farm)를 참조하십시오.

### {{ site.data.keys.mf_server }} 관리 서비스 및 MobileFirst 런타임에서 WebSphere Application Server Network Deployment의 배치 관리자로
{: #mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment }
WebSphere Application Server Network Deployment에서 런타임 및 관리 서비스는 배치 관리자와 통신하여 [{{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_server }} 관리 서비스로](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service) 및 [{{ site.data.keys.mf_server }} 관리 서비스에서 다른 서버의 {{ site.data.keys.product }} 런타임으로](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers)에서 사용되는 JMX MBean을 얻습니다. 해당하는 JNDI 특성은 [관리 서비스의 JNDI 특성: JMX](../server-configuration/#jndi-properties-for-administration-service-jmx)의 **mfp.admin.jmx.dmgr.***입니다. 

런타임과 관리 서비스 사이의 JMX 통신이 필요한 조작을 수행하려면 배치 관리자가 실행 중이어야 합니다. 이러한 조작은 런타임 초기화이거나 관리 서비스를 통해 수행된 수정의 알림일 수 있습니다.

### {{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.product }} 런타임에서 {{ site.data.keys.mf_analytics }}로
{: #mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics }
런타임은 HTTP 또는 HTTPS를 통해 {{ site.data.keys.mf_analytics }}에 데이터를 전송합니다. 이 통신을 정의하는 데 사용되는 런타임의 JNDI 특성은 다음과 같습니다.

* **mfp.analytics.url** - 런타임으로부터의 수신 분석 데이터를 수신하며 {{ site.data.keys.mf_analytics }} 서비스에 의해 공개되는 URL입니다. 예: `http://<hostname>:<port>/analytics-service/rest`

    {{ site.data.keys.mf_analytics }}가 클러스터로 설치된 경우, 클러스터의 임의의 멤버에 데이터가 전송될 수 있습니다.

* **mfp.analytics.username** - {{ site.data.keys.mf_analytics }} 서비스에 액세스하는 데 사용되는 사용자 이름입니다. 분석 서비스는 보안 역할에 의해 보호됩니다.
* **mfp.analytics.password** - 분석 서비스에 액세스하기 위한 비밀번호입니다. 
* **mfp.analytics.console.url** - {{ site.data.keys.mf_analytics_console }}에 대한 링크를 표시하기 위해 {{ site.data.keys.mf_console }}에 전달되는 URL입니다. 예: `http://<hostname>:<port>/analytics/console`

    이 통신을 정의하는 데 사용되는 푸시 서비스의 JNDI 특성은 다음과 같습니다.
* **mfp.push.analytics.endpoint** - 푸시 서비스로부터의 수신 분석 데이터를 수신하며 {{ site.data.keys.mf_analytics }} 서비스에 의해 공개되는 URL입니다. 예: `http://<hostname>:<port>/analytics-service/rest`

    {{ site.data.keys.mf_analytics }}가 클러스터로 설치된 경우, 클러스터의 임의의 멤버에 데이터가 전송될 수 있습니다.    
* **mfp.push.analytics.username** - {{ site.data.keys.mf_analytics }} 서비스에 액세스하는 데 사용되는 사용자 이름입니다. 분석 서비스는 보안 역할에 의해 보호됩니다.
* **mfp.push.analytics.password** - 분석 서비스에 액세스하기 위한 비밀번호입니다.

### {{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 라이브 업데이트 서비스로
{: #mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service }
관리 서비스는 {{ site.data.keys.product }} 아티팩트에 대한 구성 정보를 저장하고 검색하기 위해 라이브 업데이트 서비스와 통신합니다. 통신은 HTTP 또는 HTTPS를 통해 수행됩니다.

라이브 업데이트 서비스에 접속하기 위한 URL은 관리 서비스에서 자동으로 생성됩니다. 두 서비스 모두 동일한 애플리케이션 서버에 있어야 합니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. `<adminContextRoot>config`. 예를 들어, 관리 서비스의 컨텍스트 루트가 **mfpadmin**이면 라이브 업데이트 서비스의 컨텍스트 루트는 **mfpadminconfig**여야 합니다. 관리 서비스에서 JNDI 특성(**mfp.admin.proxy.port**, **mfp.admin.proxy.protocol** 및 **mfp.admin.proxy.host**)을 정의하여 기본 URL 생성을 대체할 수 있습니다. 

두 서비스 사이에 이 통신을 구성하기 위한 JNDI 특성은 다음과 같습니다.

* **mfp.config.service.user**
* **mfp.config.service.password**
* 및 [관리 서비스의 JNDI 특성: 프록시](../server-configuration/#jndi-properties-for-administration-service-proxies)의 특성.

### {{ site.data.keys.mf_console }}에서 {{ site.data.keys.mf_server }} 관리 서비스로
{: #mobilefirst-operations-console-to-mobilefirst-server-administration-service }
{{ site.data.keys.mf_console }}은 웹 사용자 인터페이스이며 관리 서비스에 대한 프론트 엔드 역할을 수행합니다. HTTP 또는 HTTPS를 통해 관리 서비스의 REST 서비스와 통신합니다. 콘솔 사용이 허용된 사용자는 관리 서비스 사용도 허용되어야 합니다. 콘솔의 특정 보안 역할에 맵핑되는 각 사용자는 서비스의 동일한 보안 역할에도 맵핑되어야 합니다. 이러한 설정을 수행함으로써 서비스는 콘솔에서의 요청을 수락할 수 있습니다. 

이 통신을 구성하기 위한 JNDI 특성은 [{{ site.data.keys.mf_console }}의 JNDI 특성](../server-configuration/#jndi-properties-for-mobilefirst-operations-console)에 있습니다. 

> 참고: **mfp.admin.endpoint** 특성은 콘솔에서 관리 서비스를 찾는 데 사용됩니다.  관리 서비스에 접속하기 위해 콘솔에서 생성되는 URL에 콘솔로 수신되는 HTTP 요청과 동일한 값이 사용되도록 지정하는 데 별표 문자 "\*"를 와일드카드로 사용할 수 있습니다. 예: `*://*:*/mfpadmin`은 콘솔과 동일한 프로토콜, 호스트 및 포트를 사용하지만 컨텍스트 루트로는 **mfpadmin**을 사용함을 의미합니다. 이 특성은 콘솔 애플리케이션에 대해 지정됩니다.



### {{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 푸시 서비스 및 권한 부여 서버로
{: #mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server }
관리 서비스는 다양한 푸시 조작을 요청하기 위해 푸시 서비스와 통신합니다. 이 통신은 OAuth 프로토콜을 통해 보호됩니다. 두 서비스 모두 기밀 클라이언트로 등록되어야 합니다. 초기 등록은 설치 시에 수행할 수 있습니다. 이 프로세스에서는 두 서비스 모두 권한 부여 서버에 접속해야 합니다. 이 권한 부여 서버는 {{ site.data.keys.product }} 런타임일 수 있습니다.

이 통신을 구성하기 위한 관리 서비스의 JNDI 특성은 다음과 같습니다.

* **mfp.admin.push.url** - 푸시 서비스의 URL입니다.
* **mfp.admin.authorization.server.url** - {{ site.data.keys.product }} 권한 부여 서버의 URL입니다. 
* **mfp.admin.authorization.client.id** - OAuth 기밀 클라이언트로서의 관리 서비스의 클라이언트 ID입니다.
* **mfp.admin.authorization.client.secret** - OAuth 기반 토큰을 가져오는 데 사용되는 시크릿 코드입니다.

> 참고: 관리 서비스의 **mfp.push.authorization.client.id** 및 **mfp.push.authorization.client.secret** 특성은 관리 서비스가 시작될 때 푸시 서비스를 기밀 클라이언트로서 자동으로 등록하는 데 사용될 수 있습니다. 푸시 서비스는 동일한 값으로 구성해야 합니다.



이 통신을 구성하기 위한 푸시 서비스의 JNDI 특성은 다음과 같습니다.

* **mfp.push.authorization.server.url** - {{ site.data.keys.product }} 권한 부여 서버의 URL입니다. **mfp.admin.authorization.server.url** 특성과 동일합니다.
* **mfp.push.authorization.client.id** - 권한 부여 서버에 접속하기 위한 푸시 서비스의 클라이언트 ID입니다.
* **mfp.push.authorization.client.secret** - 권한 부여 서버에 접속하는 데 사용되는 시크릿 코드입니다.

### {{ site.data.keys.mf_server }} 푸시 서비스에서 외부 푸시 알림 서비스로(아웃바운드)
{: #mobilefirst-server-push-service-to-an-external-push-notification-service-outbound }
푸시 서비스는 APNS(Apple Push Notification Service) 또는 GCM(Google Cloud Messaging) 등의 외부 알림 서비스에 대한 아웃바운드 트래픽을 생성합니다. 이 통신은 프록시를 통해 수행할 수도 있습니다. 알림 서비스에 따라 다음과 같은 JNDI 특성을 설정해야 합니다. 

* **push.apns.proxy**
* **push.gcm.proxy**

자세한 정보는 [{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)을 참조하십시오.

### 모바일 디바이스에서 {{ site.data.keys.product }} 런타임으로
{: #mobile-devices-to-mobilefirst-foundation-runtime }
모바일 디바이스는 런타임에 접속합니다. 이 통신의 보안은 요청되는 애플리케이션 및 어댑터의 구성에 의해 결정됩니다. 자세한 정보는 [{{ site.data.keys.product_adj }} 보안 프레임워크](../../../authentication-and-security)를 참조하십시오.

## {{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건
{: #constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics }
서버 토폴로지를 결정하기 전에 다양한 {{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건을 이해합니다. 

* [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)
* [{{ site.data.keys.mf_server }} 푸시 서비스에 대한 제한조건](#constraints-on-mobilefirst-server-push-service)

### {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건
{: #constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime }
서버 토폴로지별로 관리 서비스, 라이브 업데이트 서비스 및 런타임의 배치 모드 및 제한조건을 설명합니다.

[{{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 라이브 업데이트 서비스로](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service)에 설명된 대로, 라이브 업데이트 서비스는 항상 관리 서비스와 함께 동일한 애플리케이션 서버에 설치되어 있어야 합니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. `/<adminContextRoot>config`. 예를 들어, 관리 서비스의 컨텍스트 루트가 **/mfpadmin**이면 라이브 업데이트 서비스의 컨텍스트 루트는 **/mfpadminconfig**여야 합니다.

사용 가능한 애플리케이션 서버 토폴로지는 다음과 같습니다. 

* 독립형 서버: WebSphere  Application Server Liberty 프로파일, Apache Tomcat 또는 WebSphere Application Server 전체 프로파일
* 서버 팜: WebSphere Application Server Liberty 프로파일, Apache Tomcat 또는 WebSphere Application Server 전체 프로파일
* WebSphere Application Server Network Deployment 셀
* Liberty Collective

#### 배치 모드
{: #modes-of-deployment }
애플리케이션 서버 인프라에 관리 서비스, 라이브 업데이트 서비스 및 런타임을 배치할 때 사용하는 애플리케이션 서버 토폴로지에 따라 두 가지 배치 모드 중 하나를 선택할 수 있습니다. 비대칭 배치에서는 관리 및 라이브 업데이트 서비스와 다른 애플리케이션 서버에 런타임을 설치할 수 있습니다. 

**대칭 배치**  
대칭 배치의 경우, {{ site.data.keys.product }} 관리 컴포넌트({{ site.data.keys.mf_console }}, 관리 서비스 및 라이브 업데이트 서비스 애플리케이션) 및 런타임을 동일한 애플리케이션 서버에 설치해야 합니다.

**비대칭 배치**  
비대칭 배치의 경우, 런타임을 {{ site.data.keys.product }} 관리 컴포넌트와 다른 애플리케이션 서버에 설치할 수 있습니다.   
비동기 배치는 WebSphere Application Server Network Deployment 셀 토폴로지 및 Liberty Collective 토폴로지에만 지원됩니다. 

#### 토폴로지 선택
{: #select-a-topology }

* [독립형 서버 토폴로지](#stand-alone-server-topology)
* [서버 팜 토폴로지](#server-farm-topology)
* [Liberty Collective 토폴로지](#liberty-collective-topology)
* [WebSphere Application Server Network Deployment 토폴로지](#websphere-application-server-network-deployment-topologies)
* [서버 팜 및 WebSphere Application Server Network Deployment 토폴로지에서 리버스 프록시 사용](#using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies)

### 독립형 서버 토폴로지
{: #stand-alone-server-topology }
WebSphere  Application Server 전체 프로파일, WebSphere Application Server Liberty 프로파일 및 Apache Tomcat에 대해 독립형 토폴로지를 구성할 수 있습니다.
이 토폴로지에서는 모든 관리 컴포넌트 및 런타임이 하나의 JVM(Java Virtual Machine)에 배치됩니다. 

![독립형 토폴로지](standalone_topology.jpg)

하나의 JVM에서는 다음과 같은 특성의 대칭 배치만 가능합니다. 

* 하나 이상의 관리 컴포넌트를 배치할 수 있습니다. 각 {{ site.data.keys.mf_console }}은 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다. 
* 하나 이상의 런타임을 배치할 수 있습니다. 
* 하나의 {{ site.data.keys.mf_console }}이 여러 런타임을 관리할 수 있습니다. 
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 

#### JNDI 특성의 구성
{: #configuration-of-jndi-properties }
관리 서비스와 런타임 간의 JMX(Java Management Extensions) 통신을 가능하게 하고 런타임을 관리하는 관리 서비스를 정의하려면 몇 가지 JNDI 특성이 필요합니다. 이러한 특성에 대한 세부사항은 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) 및 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오. 

**독립형 WebSphere Application Server Liberty 프로파일 서버**  
관리 서비스 및 런타임에는 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |             값
        |
|--------------------------|--------|
|             mfp.topology.platform
        |             Liberty
        |
|             mfp.topology.clustermode
        | Standalone|
|             mfp.admin.jmx.host
        | WebSphere Application Server Liberty 프로파일 서버의 호스트 이름|
|             mfp.admin.jmx.port
        | WebSphere Application Server Liberty 프로파일 서버에 있는 server.xml 파일의 `<httpEndpoint>` 요소에 선언된 httpsPort 속성의 포트인 REST 커넥터의 포트. 이 특성에는 기본값이 없습니다.|
|             mfp.admin.jmx.user
        | WebSphere Application Server Liberty 관리자의 사용자 이름. WebSphere Application Server Liberty 프로파일 서버에 있는 server.xml 파일의 `<administrator-role>` 요소에 정의된 이름과 동일해야 합니다.|
|             mfp.admin.jmx.pwd
        |             WebSphere Application Server Liberty 관리자의 비밀번호
        |

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 **mfp.admin.environmentid** JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid** JNDI 특성의 값

**독립형 Apache Tomcat 서버**
관리 서비스 및 런타임에는 다음과 같은 로컬 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |	            값
        |
|------------------------|------------|
|             mfp.topology.platform
        | Tomcat|
|             mfp.topology.clustermode
        | Standalone|

JVM 특성은 JMX(Java Management Extensions) RMI(Remote Method Invocation)를 정의하는 데도 필요합니다. 자세한 정보는 [Apache Tomcat용 JMX 연결 구성](../appserver/#apache-tomcat-prerequisites)을 참조하십시오. 

Apache Tomcat 서버가 방화벽 뒤에서 실행 중이면 **mfp.admin.rmi.registryPort** 및 **mfp.admin.rmi.serverPort** JNDI 특성이 관리 서비스에 필요합니다. [Apache Tomcat용 JMX 연결 구성](../appserver/#apache-tomcat-prerequisites)을 참조하십시오. 

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다.   
여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 mfp.admin.environmentid JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 mfp.admin.environmentid JNDI 특성의 값

**독립형 WebSphere Application Server**  
관리 서비스 및 런타임에는 다음과 같은 로컬 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |             값
        |
|--------------------------| -----------------------|
|             mfp.topology.platform
        | WAS|
|             mfp.topology.clustermode
        | Standalone|
| mfp.admin.jmx.connector| JMX 커넥터 유형. 가능한 값은 SOAP 또는 RMI입니다.|

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다.   
여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 **mfp.admin.environmentid** JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid** JNDI 특성의 값

### 서버 팜 토폴로지
{: #server-farm-topology }
WebSphere  Application Server 전체 프로파일, WebSphere Application Server Liberty 프로파일 또는 Apache Tomcat 애플리케이션 서버의 팜을 구성할 수 있습니다.

팜은 동일한 컴포넌트가 배치된 개별 서버의 세트이며 이러한 서버 간에는 동일한 관리 서비스 데이터베이스 및 런타임 데이터베이스가 공유됩니다. 팜 토폴로지를 사용하면 {{ site.data.keys.product }} 애플리케이션의 로드를 여러 서버에서 분산시킬 수 있습니다. 팜의 각 서버는 애플리케이션 서버 유형이 동일한 JVM(Java Virtual Machine)이어야 합니다. 즉, 동종 서버 팜이어야 합니다. 예를 들어, 여러 Liberty 서버로 구성된 세트를 하나의 서버 팜으로 구성할 수 있습니다. 반대로, Liberty 서버, Tomcat 서버 또는 독립형 WebSphere Application Server가 혼합된 경우에는 서버 팜으로 구성할 수 없습니다. 

이 토폴로지에서는 모든 관리 컴포넌트({{ site.data.keys.mf_console }}, 관리 서비스 및 라이브 업데이트 서비스) 및 런타임이 팜의 모든 서버에 배치됩니다. 

![서버 팜의 토폴로지](server_farm_topology.jpg)

이 토폴로지는 대칭 배치만 지원합니다. 런타임 및 관리 컴포넌트를 팜의 모든 서버에 배치해야 합니다. 이 토폴로지의 배치 특성은 다음과 같습니다. 

* 하나 이상의 관리 컴포넌트를 배치할 수 있습니다. {{ site.data.keys.mf_console }}의 각 인스턴스는 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다. 
* 관리 컴포넌트는 팜의 모든 서버에 배치되어야 합니다. 
* 하나 이상의 런타임을 배치할 수 있습니다. 
* 런타임은 팜의 모든 서버에 배치되어야 합니다. 
* 하나의 {{ site.data.keys.mf_console }}이 여러 런타임을 관리할 수 있습니다. 
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 동일한 관리 서비스의 배치된 모든 인스턴스는 동일한 관리 데이터베이스 스키마를 공유합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다. 동일한 라이브 업데이트 서비스의 배치된 모든 인스턴스는 동일한 라이브 업데이트 데이터베이스 스키마를 공유합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 동일한 런타임의 배치된 모든 인스턴스는 동일한 런타임 데이터베이스 스키마를 공유합니다. 

#### JNDI 특성의 구성
{: #configuration-of-jndi-properties-1 }
동일한 서버의 관리 서비스와 런타임 간의 JMX 통신을 가능하게 하고 런타임을 관리하는 관리 서비스를 정의하려면 몇 가지 JNDI 특성이 필요합니다. 편의를 위해 다음 표에서 이러한 특성을 나열합니다. 서버 팜 설치 방법에 대한 지시사항은 [서버 팜 설치](../appserver/#installing-a-server-farm)를 참조하십시오. JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) 및 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오.

**WebSphere Application Server Liberty 프로파일 서버 팜**  
팜의 각 서버에서는 관리 서비스 및 런타임에 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

<table>
    <tr>
        <th>
            JNDI 특성
        </th>
        <th>
            값
        </th>
    </tr>
    <tr>
        <td>
            mfp.topology.platform
        </td>
        <td>
            Liberty
        </td>
    </tr>
    <tr>
        <td>
            mfp.topology.clustermode
        </td>
        <td>
            Farm
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.host
        </td>
        <td>
            WebSphere Application Server Liberty 프로파일 서버의 호스트 이름
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.port
        </td>
        <td>
            REST 커넥터의 포트. WebSphere Application Server Liberty 프로파일 서버에 있는 <b>server.xml</b> 파일의 <code>httpEndpoint</code> 요소에 선언된 httpsPort 속성의 값과 동일해야 합니다.

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*" />
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.user
        </td>
        <td>
            WebSphere Application Server Liberty 프로파일 서버에 있는 <b>server.xml</b> 파일의 <code>administrator-role</code> 요소에 정의된 WebSphere Application Server Liberty 관리자의 사용자 이름.            
{% highlight xml %}
<administrator-role>
    <user>MfpRESTUser</user>
</administrator-role>
{% endhighlight %}        
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.pwd
        </td>
        <td>
            WebSphere Application Server Liberty 관리자의 비밀번호
        </td>
    </tr>
</table>

**mfp.admin.serverid** JNDI 특성은 관리 서비스가 서버 팜 구성을 관리하는 데 필요합니다. 해당 값은 서버 ID이며, 팜에 있는 서버마다 값이 달라야 합니다. 

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 mfp.admin.environmentid JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid** JNDI 특성의 값

**Apache Tomcat 서버 팜**  
팜의 각 서버에서는 관리 서비스 및 런타임에 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |	            값
        |
|--------------------------|-----------|
|             mfp.topology.platform
        | Tomcat|
|             mfp.topology.clustermode
        |             Farm
        |

JVM 특성은 JMX(Java Management Extensions) RMI(Remote Method Invocation)를 정의하는 데도 필요합니다. 자세한 정보는 [Apache Tomcat용 JMX 연결 구성](../appserver/#apache-tomcat-prerequisites)을 참조하십시오. 

**mfp.admin.serverid** JNDI 특성은 관리 서비스가 서버 팜 구성을 관리하는 데 필요합니다. 해당 값은 서버 ID이며, 팜에 있는 서버마다 값이 달라야 합니다. 

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 mfp.admin.environmentid JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid** JNDI 특성의 값

**WebSphere Application Server 전체 프로파일 서버 팜**  
팜의 각 서버에서는 관리 서비스 및 런타임에 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |             값
        |
|----------------------------|--------|
| mfp.topology.platform	WAS| WAS|
|             mfp.topology.clustermode
        |             Farm
        |
| mfp.admin.jmx.connector| SOAP|

관리 서비스에서 서버 팜 구성을 관리하려면 다음과 같은 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |             값
        |
|--------------------|--------|
|             mfp.admin.jmx.user
        | WebSphere Application Server의 사용자 이름. WebSphere Application Server 사용자 레지스트리에 이 사용자가 정의되어 있어야 합니다. |
| mfp.admin.jmx.pwd	| WebSphere Application Server 사용자의 비밀번호입니다. |
| mfp.admin.serverid| 서버 ID. 팜에 있는 서버마다 달라야 하며 서버 팜 구성 파일에서 해당 서버에 사용된 이 특성의 값과 동일해야 합니다. |

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트에서 동일한 JVM을 실행할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우 다음 값을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 **mfp.admin.environmentid** JNDI 특성에 고유한 값
* 각 런타임에서, 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid** JNDI 특성의 값

### Liberty Collective 토폴로지
{: #liberty-collective-topology }
Liberty Collective 토폴로지에 {{ site.data.keys.mf_server }} 컴포넌트를 배치할 수 있습니다.

Liberty Collective 토폴로지에서 {{ site.data.keys.mf_server }} 관리 컴포넌트({{ site.data.keys.mf_console }}, 관리 서비스, 라이브 업데이트 서비스)는 집합 제어기와 집합 멤버의 {{ site.data.keys.product }} 런타임에 배치됩니다. 이 토폴로지는 비대칭 배치만 지원하며, 런타임을 집합 제어기에 배치할 수 없습니다.

![Liberty Collective의 토폴로지](liberty_collective_topology.jpg)

이 토폴로지의 배치 특성은 다음과 같습니다. 

* 하나 이상의 관리 컴포넌트를 집합의 하나 이상의 제어기에 배치할 수 있습니다. * * {{ site.data.keys.mf_console }}의 각 인스턴스는 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다.
* 집합의 클러스터 멤버에 하나 이상의 런타임을 배치할 수 있습니다.
* 하나의 {{ site.data.keys.mf_console }}은 집합의 클러스터 멤버에 배치된 여러 런타임을 관리합니다.
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 

#### JNDI 특성의 구성
{: #configuration-of-jndi-properties-2 }
다음 표에서는 관리 서비스와 런타임 간의 JMX 통신을 가능하게 하고 런타임을 관리하는 관리 서비스를 정의하는 데 필요한 JNDI 특성을 나열합니다. 이러한 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) 및 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오. Liberty collective를 수동으로 설치하는 방법에 대한 지시사항은 [WebSphere Application Server Liberty Collective에 수동 설치](../appserver/#manual-installation-on-websphere-application-server-liberty-collective)를 참조하십시오. 

관리 서비스에는 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

<table>
    <tr>
        <th>
            JNDI 특성
        </th>
        <th>
            값
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>Cluster</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>controller</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>Liberty 제어기의 호스트 이름</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>REST 커넥터의 포트. Liberty 제어기에 있는 server.xml 파일의 <code>httpEndpoint</code> 요소에 선언된 <b>httpsPort</b> 속성의 값과 동일해야 합니다.

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>Liberty 제어기에 있는 <b>server.xml</b> 파일의 <code>administrator-role</code> 요소에 정의된 제어기 관리자의 사용자 이름.

{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>Liberty 제어기 관리자의 비밀번호</td>
    </tr>
</table>

여러 관리 컴포넌트를 배치하여 제어기가 서로 다른 런타임을 관리하는 개별 관리 컴포넌트를 실행하도록 할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우, 각 관리 서비스에서 로컬 **mfp.admin.environmentid** JNDI 특성에 고유한 값을 지정해야 합니다.

런타임에는 다음과 같은 글로벌 JNDI 특성이 필요합니다. 

<table>
    <tr>
        <th>
            JNDI 특성
        </th>
        <th>
            값
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>Cluster</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>집합 멤버를 고유하게 식별하는 값. 이 값은 집합의 멤버마다 달라야 합니다. <code>controller</code> 값은 집합 제어기용으로 예약되어 있으므로 사용할 수 없습니다.</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>Liberty 제어기의 호스트 이름</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>REST 커넥터의 포트. Liberty 제어기에 있는 server.xml 파일의 <code>httpEndpoint</code> 요소에 선언된 <b>httpsPort</b> 속성의 값과 동일해야 합니다.

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>Liberty 제어기에 있는 <b>server.xml</b> 파일의 <code>administrator-role</code> 요소에 정의된 제어기 관리자의 사용자 이름.

{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>Liberty 제어기 관리자의 비밀번호</td>
    </tr>
</table>

동일한 관리 컴포넌트를 사용하는 여러 제어기(복제본)가 사용되는 경우 런타임에 다음 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |             값
        | 
|-----------------|--------|
| mfp.admin.jmx.replica| 서로 다른 제어기 복제본의 엔드포인트 목록(`replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` 구문을 사용함)| 

여러 관리 컴포넌트가 제어기에 배치되는 경우, 각 런타임에서 로컬 **mfp.admin.environmentid** JNDI 특성의 값은 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일해야 합니다. 

### WebSphere Application Server Network Deployment 토폴로지
{: #websphere-application-server-network-deployment-topologies }
관리 컴포넌트 및 런타임은 WebSphere  Application Server Network Deployment 셀의 서버 또는 클러스터에 배치됩니다. 

이러한 토폴로지의 예는 비대칭 배치나 대칭 배치, 또는 둘 다를 지원합니다. 예를 들어, 관리 컴포넌트({{ site.data.keys.mf_console }}, 관리 서비스 및 라이브 업데이트 서비스)를 하나의 클러스터에 배치하고 이러한 컴포넌트가 관리하는 런타임을 다른 클러스터에 배치할 수 있습니다.

#### 동일한 서버 또는 클러스터 내의 대칭 배치
{: #symmetric-deployment-in-the-same-server-or-cluster }
아래의 다이어그램은 런타임과 관리 컴포넌트가 동일한 서버 또는 클러스터에 배치된 대칭 배치를 보여줍니다. 

![WAS ND의 토폴로지](was_nd_topology_1.jpg)

이 토폴로지의 배치 특성은 다음과 같습니다. 

* 하나 이상의 관리 컴포넌트를 셀에 있는 하나 이상의 서버 또는 클러스터에 배치할 수 있습니다. * {{ site.data.keys.mf_console }}의 각 인스턴스는 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다.
* 하나 이상의 런타임을 이들을 관리하는 관리 컴포넌트와 동일한 서버 또는 클러스터에 배치할 수 있습니다. 
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 

#### 런타임과 관리 서비스가 서로 다른 서버 또는 클러스터에 있는 비대칭 배치
{: #asymmetric-deployment-with-runtimes-and-administration-services-in-different-server-or-cluster }
아래의 다이어그램은 런타임이 관리 서비스와 다른 서버 또는 클러스터에 배치된 토폴로지를 보여줍니다. 

![WAS ND의 토폴로지](was_nd_topology_2.jpg)

이 토폴로지의 배치 특성은 다음과 같습니다. 

* 하나 이상의 관리 컴포넌트를 셀에 있는 하나 이상의 서버 또는 클러스터에 배치할 수 있습니다. * {{ site.data.keys.mf_console }}의 각 인스턴스는 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다.
* 하나 이상의 런타임을 셀의 다른 서버 또는 클러스터에 배치할 수 있습니다. 
* 하나의 {{ site.data.keys.mf_console }}에서 셀의 다른 서버 또는 클러스터에 배치된 여러 런타임을 관리합니다. 
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 

이 토폴로지는 런타임을 관리 컴포넌트 및 다른 런타임과 격리시킬 수 있기 때문에 많은 장점이 있습니다. 이 토폴로지를 사용하면 성능을 격리시키고 주요 애플리케이션을 격리시키며 서비스 레벨 계약(SLA)을 시행할 수 있습니다. 

#### 대칭 및 비대칭 배치
{: #symmetric-and-asymmetric-deployment }
아래의 다이어그램은 클러스터1의 대칭 배치와 클러스터2의 비대칭 배치를 보여줍니다. 런타임2 및 런타임3이 관리 컴포넌트와 다른 클러스터에 배치되어 있습니다. {{ site.data.keys.mf_console }}에서는 클러스터1 및 클러스터2에 배치된 런타임을 관리합니다. 

![WAS ND의 토폴로지](was_nd_topology_3.jpg)

이 토폴로지의 배치 특성은 다음과 같습니다. 

* 하나 이상의 관리 컴포넌트를 셀에 있는 하나 이상의 서버 또는 클러스터에 배치할 수 있습니다. {{ site.data.keys.mf_console }}의 각 인스턴스는 하나의 관리 서비스 및 하나의 라이브 업데이트 서비스와 통신합니다. 
* 하나 이상의 런타임을 셀에 있는 하나 이상의 서버 또는 클러스터에 배치할 수 있습니다. 
* 하나의 {{ site.data.keys.mf_console }}에서 셀의 동일한 서버 또는 클러스터에 배치되었거나 다른 서버 또는 클러스터에 배치된 여러 런타임을 관리할 수 있습니다. 
* 하나의 런타임은 하나의 {{ site.data.keys.mf_console }}에 의해서만 관리됩니다. 
* 각 관리 서비스는 고유의 관리 데이터베이스 스키마를 사용합니다. 
* 각 라이브 업데이트 서비스는 고유의 라이브 업데이트 데이터베이스 스키마를 사용합니다.
* 각 런타임은 고유의 런타임 데이터베이스 스키마를 사용합니다. 

#### JNDI 특성의 구성
{: #configuration-of-jndi-properties-3 }
관리 서비스와 런타임 간의 JMX 통신을 가능하게 하고 런타임을 관리하는 관리 서비스를 정의하려면 몇 가지 JNDI 특성이 필요합니다. 이러한 특성에 대한 세부사항은 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) 및 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오. 

관리 서비스 및 런타임에는 다음과 같은 로컬 JNDI 특성이 필요합니다. 

|             JNDI 특성
        |	            값
        |
|-----------------|--------|
|             mfp.topology.platform
        | WAS|
|             mfp.topology.clustermode
        | Cluster|
| mfp.admin.jmx.connector|	배치 관리자와 연결하는 데 사용되는 JMX 커넥터 유형. 가능한 값은 SOAP 또는 RMI입니다. SOAP는 기본값이며 선호되는 값이기도 합니다. SOAP 포트가 사용되지 않는 경우에는 RMI를 사용해야 합니다. |
| mfp.admin.jmx.dmgr.host|	배치 관리자의 호스트 이름입니다. |
| mfp.admin.jmx.dmgr.port|	배치 관리자에서 사용하는 RMI 또는 SOAP 포트. mfp.admin.jmx.connector의 값에 따라 다릅니다. |

여러 관리 컴포넌트를 배치하여 서로 다른 런타임을 관리하는 개별 관리 컴포넌트로 동일한 서버 또는 클러스터를 실행할 수 있습니다. 

여러 관리 컴포넌트를 배치하는 경우 다음을 지정해야 합니다. 

* 각 관리 서비스에서, 로컬 **mfp.admin.environmentid** JNDI 특성에 고유한 값
* 각 런타임에서, 해당 런타임을 관리하는 관리 서비스에 대해 정의된 값과 동일한 로컬 **mfp.admin.environmentid**의 값

관리 서비스 애플리케이션에 맵핑된 가상 호스트가 기본 호스트가 아닌 경우 관리 서비스 애플리케이션에서 다음 특성을 설정해야 합니다.

* **mfp.admin.jmx.user**: WebSphere Application Server 관리자의 사용자 이름
* **mfp.admin.jmx.pwd**: WebSphere Application Server 관리자의 비밀번호

### 서버 팜 및 WebSphere Application Server Network Deployment 토폴로지에서 리버스 프록시 사용
{: #using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies }
분산 토폴로지에서 리버스 프록시를 사용할 수 있습니다. 토폴로지에서 리버스 프록시를 사용하는 경우 관리 서비스에 필요한 JNDI 특성을 구성하십시오. 

서버 팜 또는 WebSphere  Application Server Network Deployment 토폴로지의 전면에 IBM  HTTP Server 등의 리버스 프록시를 사용할 수 있습니다. 이 경우 관리 컴포넌트를 적절히 구성해야 합니다. 

다음 위치에서 리버스 프록시를 호출할 수 있습니다.

* {{ site.data.keys.mf_console }}에 액세스하는 경우 브라우저
* 관리 서비스를 호출하는 경우 런타임
* 관리 서비스를 호출하는 경우 {{ site.data.keys.mf_console }} 컴포넌트

리버스 프록시가 DMZ(근거리 통신망을 보안하기 위한 방화벽 구성) 내에 있고 DMZ와 내부 네트워크 사이에서 방화벽이 사용되는 경우, 이 방화벽은 애플리케이션 서버에서 수신되는 모든 요청에 권한을 부여해야 합니다. 

리버스 프록시를 애플리케이션 서버 인프라 전면에서 사용하는 경우 관리 서비스에 대해 다음 JNDI 특성을 정의해야 합니다. 

|             JNDI 특성
        |	            값
        |
|-----------------|--------|
| mfp.admin.proxy.protocol| 리버스 프록시와 통신하는 데 사용되는 프로토콜. HTTP 또는 HTTPS일 수 있습니다.|
| mfp.admin.proxy.host| 리버스 프록시의 호스트 이름|
| mfp.admin.proxy.port| 리버스 프록시의 포트 번호|

리버스 프록시의 URL을 참조하는 **mfp.admin.endpoint** 특성은 {{ site.data.keys.mf_console }}에도 필요합니다. 

### {{ site.data.keys.mf_server }} 푸시 서비스에 대한 제한조건
{: #constraints-on-mobilefirst-server-push-service }
푸시 서비스는 관리 서비스 또는 런타임과 동일한 애플리케이션 서버에 배치하거나 다른 애플리케이션 서버에 배치할 수 있습니다. 클라이언트 앱이 푸시 서비스에 접속하는 데 사용하는 URL은 클라이언트 앱이 런타임에 접속하는 데 사용하는 URL과 동일합니다(단, 런타임의 컨텍스트 루트는 imfpush로 대체됨). 런타임과 다른 서버에 푸시 서비스를 설치하는 경우, HTTP 서버는 /imfpush 컨텍스트 루트로의 트래픽을 푸시 서비스가 실행되는 서버로 경로 지정해야 합니다. 

토폴로지에 적합하게 설치를 구성하는 데 필요한 JNDI 특성에 대해서는 [{{ site.data.keys.mf_server }} 관리 서비스에서 {{ site.data.keys.mf_server }} 푸시 서비스 및 권한 부여 서버로](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)를 참조하십시오. 푸시 서비스는 컨텍스트 루트 **/imfpush**를 사용하여 설치해야 합니다.

## 복수 {{ site.data.keys.product }} 런타임
{: #multiple-mobilefirst-foundation-runtimes }
복수 런타임을 설치할 수 있습니다. 각 런타임은 고유의 컨텍스트 루트를 가져야 하며, 이러한 런타임은 모두 동일한 {{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.mf_console }}에 의해 관리됩니다. 

[{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product }} 런타임에 대한 제한조건](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)에 설명된 제한조건이 적용됩니다. 각 런타임(해당 컨텍스트 루트 포함)에는 자체 고유의 데이터베이스 테이블이 있어야 합니다.

> 지시사항은 [복수 런타임 구성](../server-configuration/#configuring-multiple-runtimes)을 참조하십시오.

## 동일 서버 또는 WebSphere Application Server 셀의 복수 {{ site.data.keys.mf_server }} 인스턴스
{: #multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell }
공통 환경 ID를 정의함으로써 {{ site.data.keys.mf_server }}의 복수 인스턴스를 동일한 서버에 설치할 수 있습니다.

{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.product }} 런타임의 복수 인스턴스를 동일한 애플리케이션 서버 또는 WebSphere  Application Server 셀에 설치할 수 있습니다. 그러나 관리 서비스 및 런타임의 변수인 JNDI 변수, **mfp.admin.environmentid**를 사용하여 설치를 구별해야 합니다. 관리 서비스는 환경 ID가 동일한 런타임만 관리합니다. 따라서 **mfp.admin.environmentid**의 값이 동일한 런타임 컴포넌트 및 관리 서비스만 동일한 설치의 일부로 간주됩니다.
