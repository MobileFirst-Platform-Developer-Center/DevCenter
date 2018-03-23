---
layout: tutorial
title: IBM MobileFirst Foundation의 내게 필요한 옵션 기능
breadcrumb_title: Accessibility features
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
내게 필요한 옵션 기능은 정보 기술 컨텐츠를 올바르게 사용하기 위해 활동 제약 또는 시력 손상과 같은 장애를 가지고 있는 사용자만 지원합니다.

### 내게 필요한 옵션 기능
{: #accessibility-features }
{{ site.data.keys.product_full }}에는 다음과 같은 주요 내게 필요한 옵션 기능이 포함되어 있습니다.

* 키보드로만 조작
* 스크린 리더 사용을 지원하는 조작

[US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards) 및 [WCAG(Web Content Accessibility Guidelines) 2.0](http://www.w3.org/TR/WCAG20/)에 대한 준수를 보장하기 위해 {{ site.data.keys.product }}에서는 최신 W3C 표준 [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/)을 사용합니다. 내게 필요한 옵션 기능을 이용하려면 이 제품이 지원하는 최신 웹 브라우저와 함께 최신 릴리스의 스크린 리더를 사용하십시오.

### 키보드 탐색
{: #keyboard-navigation }
이 제품은 표준 탐색 키를 사용합니다.

### 인터페이스 정보
{: #interface-informaton }
{{ site.data.keys.product }} 사용자 인터페이스에는 초당 2 - 55회 깜박이는 컨텐츠가 없습니다.

스크린 리더를 디지털 음성 합성기와 함께 사용하여 화면에 표시되는 내용을 들을 수 있습니다. 이 제품에 보조 기술을 사용하는 방법에 대한 세부사항 및 해당 문서는 해당 보조 기술이 포함된 문서를 참조하십시오.

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
기본적으로 {{ site.data.keys.mf_cli }}에 의해 표시되는 상태 메시지는 성공, 오류 및 경고를 보여주기 위해 다양한 색상을 사용합니다. `--no-color` 옵션을 {{ site.data.keys.mf_cli }} 명령에 사용하여 해당 명령에 대해 이러한 색상의 사용을 억제할 수 있습니다. `--no-color`가 지정되면 운영 체제 콘솔에 대해 설정된 텍스트 표시 색상으로 출력이 표시됩니다.

### 웹 인터페이스 
{: #web-interface }
{{ site.data.keys.product }} 웹 사용자 인터페이스에서는 컨텐츠를 올바로 렌더링하고 사용 가능한 경험을 제공하기 위해 캐스케이딩 스타일시트를 이용합니다. 이 애플리케이션은 시력이 좋지 않은 사용자가 고대비 모드를 포함하여 사용자 시스템 표시 설정을 사용하는 것과 동일한 방법을 제공합니다. 디바이스 또는 웹 브라우저 설정을 사용하여 글꼴 크기를 제어할 수 있습니다.

키보드 단축키를 사용하여 여러 {{ site.data.keys.product_adj }} 환경 및 해당 문서를 탐색할 수 있습니다. Eclipse는 해당 개발 환경에 내게 필요한 옵션 기능을 제공합니다. 인터넷 브라우저는 또한 {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_analytics_console }}, {{ site.data.keys.product }} Application Center 콘솔 및 {{ site.data.keys.product }} Application Center 모바일 클라이언트 등의 웹 애플리케이션에 대한 내게 필요한 옵션 기능도 제공합니다.

{{ site.data.keys.product }} 웹 사용자 인터페이스에는 애플리케이션의 기능 영역을 빠르게 탐색하는 데 사용할 수 있는 WAI-ARIA 탐색 랜드마크가 포함되어 있습니다.

### 설치 및 구성
{: #installation-and-configuration }
{{ site.data.keys.product }}을 설치하고 구성하는 데 두 가지 방법(그래픽 사용자 인터페이스(GUI) 또는 명령행)이 있습니다.

그래픽 사용자 인터페이스(마법사 모드의 IBM Installation Manager 또는 Server Configuration Tool)에서 사용자 인터페이스 오브젝트에 대한 정보를 제공하지는 않지만 명령행 인터페이스를 사용하여 동일한 기능을 사용할 수 있습니다. GUI의 모든 기능이 명령행을 통해 지원되고, 일부 특정한 설치 및 구성 기능이 명령행에서만 사용 가능합니다. IBM Knowledge Center에서 [IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc)의 내게 필요한 옵션 기능 관련 정보를 읽을 수 있습니다.

다음 주제에서는 GUI를 사용하지 않고 설치 및 구성이 완료되는 방법에 대한 정보를 제공합니다.

* IBM Installation Manager용 샘플 응답 파일에 대한 작업
이 방법을 통해 {{ site.data.keys.mf_server }} 및 Application Center를 무인으로 설치 및 구성할 수 있습니다. install-no-appcenter.xml이라는 응답 파일을 사용하여 Application Center를 설치하지 않을 수 있습니다. 그런 다음 Ant 태스크를 사용하여 나중 단계에서 이를 설치할 수 있습니다. Ant 태스크를 사용하여 Application Center 설치를 참조하십시오. 이런 경우 Application Center의 설치 및 업그레이드가 독립적으로 수행될 수 있습니다.
* Ant 태스크를 사용하여 설치
* Ant 태스크를 사용한 Application Center 설치

### 벤더 소프트웨어
{: #vendor-software }
{{ site.data.keys.product }}에는 IBM 라이센스 계약이 적용되지 않는 특정 벤더 소프트웨어가 포함되어 있습니다. IBM은 이러한 제품의 내게 필요한 옵션 기능에 대한 정보를 제공하지 않습니다. 이 제품의 내게 필요한 옵션 정보에 대해서는 해당 벤더에 문의하십시오.

### 관련된 내게 필요한 옵션 정보
{: #related-accessibility-information }
IBM에서는 표준 IBM 도움말 데스크 및 지원 웹 사이트 외에 청각 장애인 또는 청력이 약한 고객이 영업 및 지원 서비스에 액세스하는 데 사용할 수 있는 TTY 전화 서비스를 확립했습니다.

TTY 서비스  
800-IBM-3383(800-426-3383)  
(북미 지역 내)

### IBM 및 내게 필요한 옵션
{: #ibm-and-accessibility }
내게 필요한 옵션에 대한 IBM의 약정에 대한 자세한 정보는 [IBM 내게 필요한 옵션](http://www.ibm.com/able)을 참조하십시오.


