---
layout: tutorial
breadcrumb_title: Foundation on Bluemix
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}을 Bluemix에서 호스팅할 수 있습니다. Bluemix에 대한 몇몇 기본 정보는 다음과 같습니다. 

IBM Bluemix는 IBM 개방형 클라우드 아키텍처의 구현입니다. Bluemix에서는 Cloud Foundry를 이용해 개발자가 클라우드 애플리케이션을 신속하게 빌드하고 배치하며 관리하는 한편 사용 가능한 서비스와 런타임 프레임워크의 성장하는 에코시스템을 이용할 수 있습니다. 

> [Bluemix 웹 사이트](https://console.ng.bluemix.net/docs/overview/whatisbluemix.html#bluemixoverview)에서 Bluemix 아키텍처와 Bluemix 개념에 대해 자세히 알아보십시오.



### 작동 방식
{: #how-does-it-work }
간단히 말하면 라이센스 부여 유형에 따라 {{ site.data.keys.product }} on Bluemix를 실행하는 두 가지 방법이 있습니다. 

* Bluemix 등록 또는 PayGo 라이센스: {{ site.data.keys.mf_bm_full }} 서비스
* 사내 구축형 라이센스: IBM에서 제공하는 스크립트를 사용하여 IBM Containers 또는 Liberty for Java 런타임에 {{ site.data.keys.product_full }} 인스턴스를 설정합니다. 

{{ site.data.keys.product }} on Bluemix IBM Containers를 실행하려면 여러 컴포넌트가 서로 상호작용해야 합니다. 첫 번째 컴포넌트는 **WebSphere Liberty 설치가 있는 Linux 배포**가 포함된 **이미지**이며 **{{ site.data.keys.mf_server }} 인스턴스**가 배치되어 있습니다. 그런 다음 이미지는 **IBM Container**에 저장되고 **Bluemix**에서 IBM Container를 관리합니다. 

Bluemix Liberty for Java 런타임에서 {{ site.data.keys.product}}을 실행하기 위해 **WebSphere Liberty 설치**를 포함하고 **{{ site.data.keys.mf_server }} 인스턴스**가 배치되어 있는 **Cloudfoundry 앱** 컴포넌트를 사용합니다. 

### Bluemix의 Kubernetes Cluster
Kubernetes는 컴퓨팅 머신의 클러스터에 대한 앱 컨테이너를 스케줄링하는 오케스트레이션 도구입니다. Kubernetes를 통해 개발자는 컨테이너의 성능과 유연성을 활용하여 고가용성 애플리케이션을 신속하게 개발할 수 있습니다.
Kubernetes Cluster를 작성하고 관리하는 데 IBM Bluemix Container Service CLI 또는 Kubernetes CLI를 사용할 수 있습니다. 

[Bluemix에서 Kubernetes Cluster에 대해 자세히 알아보기](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

### IBM Containers
{: #ibm-containers }
IBM Containers는 호스팅된 클라우드 환경에서 이미지를 실행하는 데 사용되는 오브젝트입니다. IBM Containers는 앱에서 실행해야 하는 모든 항목을 보유합니다. 

IBM Container 인프라는 이미지에 사용할 개인용 레지스트리를 포함하고 있어 이미지를 업로드하고 저장하며 검색할 수 있습니다. Bluemix에서 이러한 이미지를 관리하도록 할 수 있습니다. 그러면 명령 인터페이스를 사용해 Bluemix에서 컨테이너를 관리합니다. 이에 대한 자세한 내용은 다음 학습에서 다룹니다. 

[IBM Containers에 대해 자세히 알아보십시오](https://www.ng.bluemix.net/docs/containers/container_index.html).

### Liberty for Java 런타임
{: #liberty-for-java-runtime }
Liberty for Java 런타임은 liberty-for-java 빌드팩으로 구현됩니다. liberty-for-java 빌드팩은 WebSphere Liberty 프로파일 외에 애플리케이션을 실행하는 데 필요한 전체 런타임 환경을 제공합니다. 그런 다음 명령 인터페이스를 사용해 Bluemix에서 앱을 관리합니다. 

[Liberty for Java에 대해 자세히 알아보십시오](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html). 


## 다음 학습서
{: #tutorials-to-follow-next }

* Kubernetes Cluster를 사용하여 [IBM에서 제공하는 스크립트를 통해](mobilefirst-server-using-kubernetes/) Bluemix에서 {{ site.data.keys.mf_bm_short }} 인스턴스를 작성합니다. 
* [{{ site.data.keys.mf_bm }} 서비스를 사용해](using-mobile-foundation/) {{ site.data.keys.mf_server }} 인스턴스를 작성합니다. 
* IBM Containers를 사용하여 [IBM에서 제공하는 스크립트를 통해](mobilefirst-server-using-scripts/) Bluemix에서 {{ site.data.keys.mf_server }} 인스턴스를 작성합니다. 
* Liberty를 사용하여 [IBM에서 제공하는 스크립트를 통해](mobilefirst-server-using-scripts-lbp/) Bluemix에서 {{ site.data.keys.mf_server }} 인스턴스를 작성합니다. 
