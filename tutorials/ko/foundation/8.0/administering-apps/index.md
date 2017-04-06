---
layout: tutorial
title: 애플리케이션 관리
weight: 11
show_children: true
---
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 개발 또는 프로덕션 중에 {{ site.data.keys.product_adj }} 애플리케이션을 관리하는 여러 방법을 제공합니다. {{ site.data.keys.mf_console }}은 중앙 집중식 웹 기반 콘솔에서 배치된 모든 {{ site.data.keys.product_adj }} 애플리케이션을 모니터할 수 있는 기본 도구입니다. 

{{ site.data.keys.mf_console }}을 통해 수행할 수 있는 기본 조작은 다음과 같습니다. 

* 모바일 애플리케이션을 {{ site.data.keys.mf_server }}에 등록하고 구성합니다. 
* 어댑터를 {{ site.data.keys.mf_server }}에 배치하고 구성합니다. 
* 애플리케이션 버전을 관리하여 새 버전을 배치하거나 이전 버전을 원격으로 사용 안함으로 설정합니다. 
* 모바일 디바이스와 사용자를 관리하여 특정 디바이스에 대한 액세스 또는 애플리케이션에 대한 특정 사용자의 액세스를 관리합니다. 
* 애플리케이션 시작 시 알림 메시지를 표시합니다. 
* 푸시 알림 서비스를 모니터합니다. 
* 특정 디바이스에 설치된 특정 애플리케이션의 클라이언트 측 로그를 수집합니다. 

## 관리 역할
{: #administration-roles }
모든 유형의 관리 사용자가 모든 관리 조작을 수행할 수 있는 것은 아닙니다. {{ site.data.keys.mf_console }}과 모든 관리 도구에는 {{ site.data.keys.product_adj }} 애플리케이션의 관리를 위해 네 가지 서로 다른 역할이 정의되어 있습니다. 다음과 같은 

{{ site.data.keys.product_adj }} 관리 역할이 정의되어 있습니다. 

**모니터**  
이 역할의 사용자는 배치된 {{ site.data.keys.product_adj }} 프로젝트와 배치된 아티팩트를 모니터할 수 있습니다. 이 역할은 읽기 전용입니다. 

**운영자**  
운영자는 모든 모바일 애플리케이션 관리 조작을 수행할 수 있지만 애플리케이션 버전 또는 어댑터를 추가하거나 제거할 수 없습니다. 

**배치자**  
이 역할의 사용자는 운영자와 동일한 조작을 수행할 수 있지만 애플리케이션과 어댑터를 배치할 수도 있습니다. 

**관리자**  
이 역할의 사용자는 모든 애플리케이션 관리 조작을 수행할 수 있습니다. 

> {{ site.data.keys.product_adj }} 관리 역할에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리를 위한 사용자 인증 구성](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)을 참조하십시오.

## 관리 도구
{: #administration-tools }
{{ site.data.keys.product_adj }} 애플리케이션을 관리하는 데 {{ site.data.keys.mf_console }}만 사용할 수 있는 것은 아닙니다. {{ site.data.keys.product }}은 빌드와 배치 프로세스에 관리 조작을 통합하는 다른 도구도 제공합니다. 

REST 서비스 세트를 사용하여 관리 조작을 수행할 수 있습니다. 이러한 서비스의 API 참조 문서는 [REST API for the {{ site.data.keys.mf_server }} administration service](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html#restservicesapi)를 참조하십시오. 

이 REST 서비스를 사용하면 {{ site.data.keys.mf_console }}에서 수행할 수 있는 조작을 수행할 수 있습니다. 애플리케이션과 어댑터를 관리하고, 새 버전의 애플리케이션을 업로드하거나 이전 버전을 사용 안함으로 설정하는 등의 작업을 수행할 수 있습니다. 

또한 Ant 태스크나 **mfpadm** 명령행 도구를 사용해 {{ site.data.keys.product_adj }} 애플리케이션을 관리할 수 있습니다. [Ant를 통해 {{ site.data.keys.product_adj }} 애플리케이션 관리](using-ant) 또는 [명령행을 통해 {{ site.data.keys.product_adj }} 애플리케이션 관리](using-cli)를 참조하십시오. 

웹 기반 콘솔과 마찬가지로 REST 서비스, Ant 태스크, 명령행 도구에는 보안이 설정되어 있으며 관리자 신임 정보를 제공해야 합니다. 

### 주제 선택:
{: #select-a-topic }

