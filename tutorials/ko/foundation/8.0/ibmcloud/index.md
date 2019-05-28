---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Cloud의 IBM Mobile Foundation
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **참고:** * IBM Bluemix는 이제 IBM Cloud라고 합니다. 자세히 알려면 [여기](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/)를 참조하십시오. *

## 개요
{: #overview }
{{ site.data.keys.product_full }}을 IBM Cloud에서 호스팅할 수 있습니다. IBM Cloud에 대한 몇몇 기본 정보는 다음과 같습니다.

IBM Cloud는 IBM 개방형 클라우드 아키텍처의 구현입니다. Bluemix에서는 Cloud Foundry를 이용해 개발자가 클라우드 애플리케이션을 신속하게 빌드하고 배치하며 관리하는 한편 사용 가능한 서비스와 런타임 프레임워크의 성장하는 에코시스템을 이용할 수 있습니다.

> IBM Cloud 아키텍처 및 IBM Cloud 개념에 대해서는 [여기](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview)에서 자세히 알아보십시오.

### 작동 방식
{: #how-does-it-work }
간단히 말하면 라이센스 부여 유형에 따라 IBM Cloud에서 {{ site.data.keys.product }}을 실행하는 두 가지 방법이 있습니다.

> **참고:** *IBM Containers 서비스는 이제 더 이상 사용되지 않으므로 IBM Containers의 Mobile Foundation은 지원되지 않습니다. [자세히 알아보기](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/).*

* IBM Cloud 등록 또는 PayGo 라이센스: {{ site.data.keys.mf_bm_full }} 서비스.
* 사내 구축형 라이센스: IBM에서 제공하는 스크립트를 사용하여 Kubernetes Clusters 또는 Liberty for Java 런타임에 {{ site.data.keys.product_full }} 인스턴스를 설정합니다.

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

IBM Cloud Liberty for Java 런타임에서 {{ site.data.keys.product}}을 실행하기 위해 **WebSphere Liberty 설치**를 포함하고 **{{ site.data.keys.mf_server }} 인스턴스**가 배치되어 있는 **Cloudfoundry 앱** 컴포넌트를 사용합니다.

### IBM Cloud의 Kubernetes Cluster
Kubernetes는 컴퓨팅 머신의 클러스터에 대한 앱 컨테이너를 스케줄링하는 오케스트레이션 도구입니다. Kubernetes를 통해 개발자는 컨테이너의 성능과 유연성을 활용하여 고가용성 애플리케이션을 신속하게 개발할 수 있습니다.
Kubernetes CLI를 사용하여 Kubernetes 클러스터를 작성하고 관리할 수 있습니다.

[IBM Cloud의 Kubernetes Cluster에 대해 자세히 알아보기](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Liberty for Java 런타임
{: #liberty-for-java-runtime }
Liberty for Java 런타임은 liberty-for-java 빌드팩으로 구현됩니다. liberty-for-java 빌드팩은 WebSphere Liberty 프로파일 외에 애플리케이션을 실행하는 데 필요한 전체 런타임 환경을 제공합니다. 그런 다음 명령 인터페이스를 사용하여 IBM Cloud에서 앱을 관리합니다.

[Liberty for Java에 대해 자세히 알아보기](https://console.bluemix.net/docs/runtimes/liberty/index.html)


## 다음 학습서
{: #tutorials-to-follow-next }

* [IBM에서 제공하는 스크립트를 사용](mobilefirst-server-on-kubernetes-using-scripts/)하여 IBM Cloud의 Kubernetes Cluster에서 {{ site.data.keys.mf_bm_short }} 인스턴스를 작성하십시오.
* [{{ site.data.keys.mf_bm }} 서비스 설정](using-mobile-foundation/) 학습서를 사용하여 {{ site.data.keys.mf_server }} 인스턴스를 작성하십시오.
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* [IBM에서 제공하는 스크립트를 사용](mobilefirst-server-using-scripts-lbp/)하여 IBM Cloud의 Liberty for Java를 사용하여 {{ site.data.keys.mf_server }} 인스턴스를 작성하십시오.
