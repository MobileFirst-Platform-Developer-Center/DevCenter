---
layout: tutorial
title: 경보 관리
breadcrumb_title: 경보
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

경보는 {{ site.data.keys.mf_analytics_console_full }}을 정기적으로 확인하지 않고도 모바일 앱의 상태를 모니터할 수 있는 사전 예방적 수단을 제공합니다.   
특정 기준이 충족되면 경보를 트리거하도록 {{ site.data.keys.mf_analytics_console }}에서 반응 임계값을 설정할 수 있습니다. 

일반 레벨(특정 앱) 또는 세부 단위 레벨(특정 앱 인스턴스 또는 디바이스)에서 임계값을 설정할 수 있습니다. 경보 알림은 {{ site.data.keys.mf_analytics_console_short }}에 표시되도록 구성될 수 있으며 사전 구성된 REST 엔드포인트 또는 사용자 정의 웹 후크에 전송될 수도 있습니다. 

경보가 트리거되면 {{ site.data.keys.mf_analytics_console_short }}의 제목 표시줄에 있는 **경보** 아이콘에 경보 개수가 빨간색으로 표시됩니다(<img  alt="경보 아이콘" style="margin:0;display:inline" src="alertIcon.png"/>). **경보** 아이콘을 클릭하여 경보를 보십시오. 

경보 분배를 위해 대체 방법을 사용할 수 있습니다. 

**전제조건:** {{ site.data.keys.mf_analytics_server }}가 시작되어 클라이언트 로그를 수신할 준비가 되어 있어야 합니다. 

## 경보 관리
{: #alert-management }

### 경보 작성
{: #creating-an-alert }

{{ site.data.keys.mf_analytics_console }}에서 다음을 수행하십시오. 

1. **대시보드 → 경보 관리** 탭을 선택하십시오. **경보 작성** 단추를 클릭하십시오. 

   ![경보 관리 탭](alert_management_tab.png)

2. 경보 이름, 메시지, 조회 빈도 및 이벤트 유형 값을 제공하십시오. 이벤트 유형에 따라 적절한 값으로 표시되는 추가적인 텍스트 상자를 채우십시오. 
3. 모든 값을 입력했으면 **다음**을 클릭하십시오. **분배 방법** 탭이 표시됩니다. 

### 분배 방법 탭
{: #distribution-method-tab }

기본적으로 경보는 {{ site.data.keys.mf_analytics_console_short }}에 표시됩니다. 

**Analytics Console 및 네트워크 POST** 옵션을 선택하여 JSON 페이로드와 함께 POST 메시지를 {{ site.data.keys.mf_analytics_console_short }}과 사용자 정의된 URL에 모두 전송할 수도 있습니다. 

이 옵션을 선택하면 다음과 같은 필드를 사용할 수 있습니다. 

* 네트워크 POST URL(*필수*)
* 헤더(*선택사항*)
* 인증 유형(*필수*)

<img class="gifplayer"  alt="경보 작성" src="creating-an-alert.png"/>

## 사용자 정의 웹 후크
{: #custom-web-hook }

경보에 대해 사용자 정의 분배 방법을 설정할 수 있습니다. 예를 들어, 경보 임계값이 트리거될 때 페이로드가 전송되는 웹 후크를 정의하십시오. 

예제 페이로드: 

```json
{
  "timestamp": 1442848504431,
  "condition": {"value":5.0,"operator":"GTE"},
  "value": "CRASH",
  "offenders": [
    { "XXX 1.0": 5.0 },
    { "XXX 2.0": 1.0 }
  ],
  "property":"closedBy",
  "eventType":"MfpAppSession",
  "title":" Crash Count Alert for Application ABC",
  "message": "The crash count for a application ABC exceeded XYZ.
    View the Crash Summary table in the Crashes tab in the Apps
    section of the MobileFirst Analytics Console
    to see a detailed stacktrace of this crash instance."
}
```

POST 요청에는 다음과 같은 속성이 포함됩니다. 

* **timestamp** - 경보 알림이 작성된 시간입니다. 
* **condition** - 사용자가 설정한 임계값입니다(예: 5 이상). 
* **eventType** - 조회된 eventType입니다. 
* **property** - 조회된 eventType의 특성입니다. 
* **value** - 조회된 특성의 값입니다. 
* **offenders** - 경보를 트리거한 앱 또는 디바이스의 목록입니다. 
* **title** - 사용자 정의 제목입니다. 
* **message** - 사용자 정의 메시지입니다. 

## 경보 세부사항 보기
{: #viewing-alert-details }

{{ site.data.keys.mf_analytics_console }}의 **대시보드 → 경보 로그** 탭에서 경보 세부사항을 볼 수 있습니다. 

![새 경보 로그](alert-log.png)

사용 가능한 수신 경보의 **+** 아이콘을 클릭하십시오. 이 조치는 **경보 정의** 및 **경보 인스턴스** 섹션을 표시합니다. 다음 이미지는 경보 정의 및 경보 인스턴스 섹션을 보여줍니다. 

![경보 정의 및 인스턴스](alert-definitions-and-instances.png)
