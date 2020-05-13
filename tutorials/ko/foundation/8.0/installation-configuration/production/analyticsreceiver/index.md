---
layout: tutorial
title: MobileFirst Analytics Receiver Server 설치 및 구성
breadcrumb_title: MobileFirst Analytics Receiver Server 설치
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Mobile Analytics Receiver 서버는 선택적 서버이며 이를 배치하여 Mobile Foundation Server 런타임 대신 모바일 클라이언트 애플리케이션에서 Mobile Foundation Analytics 이벤트에 전송할 수 있습니다. 이 배치 옵션으로 Mobile Foundation 서버에서 분석 이벤트 처리를 오프로딩하여 해당 리소스를 완전히 런타임 기능에 사용할 수 있습니다.   

{{ site.data.keys.mf_analytics_receiver_server }}는 단일 WAR 파일로 제공됩니다. 이 파일은 별도의 서버에 설치해야 합니다. 다음 방법 중 하나를 사용하여 설치할 수 있습니다.

* Ant 태스크를 사용한 설치
* 수동 설치

선택한 웹 애플리케이션 서버에서 {{ site.data.keys.mf_analytics_receiver_server }}를 설치한 후에는 추가 구성을 수행해야 합니다. 자세한 정보는 아래의 설치 후 {{ site.data.keys.mf_analytics_receiver_server }} 구성을 참조하십시오. 설치 프로그램에서 수동 설치를 선택한 경우에는 선택한 애플리케이션 서버의 문서를 참조하십시오.

> **참고:** 하나의 호스트 머신에 {{ site.data.keys.mf_analytics_receiver_server }}의 인스턴스를 둘 이상 설치하지 마십시오.

Analytics Receiver WAR 파일은 MobileFirst Server 설치에 포함되어 있습니다. 자세한 정보는 MobileFirst Server의 배포 구조를 참조하십시오.

* {{ site.data.keys.mf_analytics_receiver_server }} 설치 방법에 대한 자세한 정보는 [{{ site.data.keys.mf_analytics_receiver_server }} 설치 안내서](installation)를 참조하십시오.
* IBM MobileFirst Analytics Receiver 구성 방법에 대한 자세한 정보는 [구성 안내서](configuration)를 참조하십시오.
