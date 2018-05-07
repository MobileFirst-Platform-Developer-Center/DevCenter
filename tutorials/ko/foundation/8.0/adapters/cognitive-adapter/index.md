---
layout: tutorial
title: Watson 코그너티브 서비스용 어댑터
breadcrumb_title: Adapters for Watson services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

IBM Cloud의 Watson은 스마트한 애플리케이션을 빠르고 안전하게 빌드할 수 있도록 현재 사용 가능한 다양한 코그너티브 기술에 대한 액세스를 제공합니다. Watson 서비스로 사용 가능한 기능 중에는 감성을 이해하도록 이미지와 비디오를 분석하고 텍스트에서 키워드 및 엔티티를 추출하는 기능이 있습니다.

Watson은 코그너티브 컴퓨팅에 대한 더 많은 기능을 제공합니다. 자연어 이해, 시각적 인식, 발견은 오퍼레이션을 재창조하고 산업을 혁신할 수 있는 구조화되지 않은 데이터에서 얻은 통찰력을 제공합니다. IBM Cloud의 Watson 코그너티브 서비스에 대해 자세히 알아보려면 [여기](https://www.ibm.com/watson/developercloud/)를 클릭하십시오. 

{{ site.data.keys.product }} 어댑터는 필요한 서버 측 논리를 수행하고 백엔드 시스템에서 클라이언트 애플리케이션과 클라우드 서비스로 정보를 전송 및 검색하는 데 사용됩니다. {{ site.data.keys.product }}은 이제 일부 Watson 코그너티브 서비스용 어댑터를 제공합니다.

##  Watson 서비스용 어댑터
{: #watson-adapter}

{{ site.data.keys.product_full }}은 [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/)부터 [대화](https://www.ibm.com/watson/developercloud/conversation.html), [발견](https://www.ibm.com/watson/developercloud/discovery.html) 및 [자연어 이해](https://www.ibm.com/watson/developercloud/natural-language-understanding.html)와 같은 일부 Watson 코그너티브 서비스의 즉각적인 어댑터를 제공합니다. Mobile Foundation 콘솔의 **Download Center**에서 이 어댑터를 다운로드할 수 있습니다.

애플리케이션에서 Watson 코그너티브 서비스에 연결하려면 코그너티브 서비스 어댑터를 다운로드한 후 어댑터를 {{ site.data.keys.product_adj }} 서버에 배치하십시오. 이제 애플리케이션은 어댑터 API를 호출(call)하여 Watson 서비스를 호출(invoke)할 수 있습니다.

어댑터가 배치되면 Watson 서비스에 연결하도록 구성하십시오. 이를 수행하려면 **어댑터 구성** 페이지로 이동하여 **어댑터 구성** 페이지에 있는 _**사용자 이름**_ 및 _**비밀번호**_ 필드의 **서비스 신임 정보**로부터 *사용자 이름* 및 *비밀번호*를 제공하고 구성을 저장하십시오.

어댑터를 수정해야 하는 경우 github 저장소에서 어댑터 소스 코드를 다운로드하십시오.<br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU(자연어 이해)**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
