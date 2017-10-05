---
layout: tutorial
title: MobileFirst Analytics Server 설치 및 구성	
breadcrumb_title: MobileFirst Analytics Server 설치
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_analytics_server }}는 별도의 두 WAR 파일로 제공됩니다. WebSphere Application Server 또는 WebSphere Application Server Liberty에서 편리하게 배치하기 위해 {{ site.data.keys.mf_analytics_server }}는 두 개의 WAR 파일이 포함된 하나의 EAR 파일로도 제공됩니다. 

> **참고:** 하나의 호스트 머신에 {{ site.data.keys.mf_analytics_server }}의 인스턴스를 둘 이상 설치하지 마십시오. 클러스터 관리에 대한 자세한 정보는 Elasticsearch 문서를 참조하십시오.

Analytics WAR 및 EAR 파일은 MobileFirst Server 설치에 포함되어 있습니다. 자세한 정보는 MobileFirst Server의 배포 구조를 참조하십시오. WAR 파일을 배치할 때 `http://<hostname>:<port>/analytics/console`(예: `http://localhost:9080/analytics/console`)에서 MobileFirst Analytics Console을 사용할 수 있습니다.

* {{ site.data.keys.mf_analytics_server }} 설치 방법에 대한 자세한 정보는 [{{ site.data.keys.mf_analytics_server }} 설치 안내서](installation)를 참조하십시오. 
* IBM MobileFirst Analytics 구성 방법에 대한 자세한 정보는 [구성 안내서](configuration)를 참조하십시오. 
