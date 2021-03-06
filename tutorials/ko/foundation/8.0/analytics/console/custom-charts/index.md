---
layout: tutorial
title: 사용자 정의 차트 작성
breadcrumb_title: 사용자 정의 차트
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

사용자 정의 차트를 사용하면 Analytics 데이터 저장소에서 수집된 Analytics 데이터를 {{ site.data.keys.mf_analytics_console }}에서 기본적으로 사용할 수 없는 차트로 시각화할 수 있습니다. 이 시각화 기능은 비즈니스에 필수적인 데이터를 분석하는 강력한 방법입니다.

사용 가능한 사용자 정의 차트 유형: **앱 세션**, **네트워크 트랜잭션**, **푸시 알림**, **클라이언트 로그**, **서버 로그**, **사용자 정의 데이터**

#### 다음으로 이동
{: #jump-to }

* [사용자 정의 차트 작성](#creating-a-custom-chart)
* [차트 유형](#chart-types)
* [클라이언트 로그에 대한 사용자 정의 차트 작성](#creating-custom-charts-for-client-logs)
* [사용자 정의 차트 데이터 내보내기](#exporting-custom-chart-data)
* [사용자 정의 차트 정의 내보내기 및 가져오기](#exporting-and-importing-custom-chart-definitions)

## 사용자 정의 차트 작성
{: #creating-a-custom-chart }

{{ site.data.keys.mf_analytics_console }}의 **대시보드** 패널에서 사용자 정의 차트 작성 빌더는 네 가지 기본 단계를 진행합니다.

### 1. 일반 설정
{: #1-general-settings }

**사용자 정의 차트** 탭에서 **차트 작성** 단추를 클릭하십시오.  

**일반 설정** 탭에서 차트 제목, 이벤트 유형 및 차트 유형을 선택하십시오.  
이벤트 유형 및 차트 유형을 선택하면 **차트 정의** 탭이 표시됩니다.

### 2. 차트 정의 탭
{: #2-the-chart-definition-tab }

**차트 정의** 탭을 사용하여 이전에 선택한 지정된 차트 유형에 대한 차트를 정의하십시오. 차트를 정의한 후 차트 필터 및 차트 특성을 설정할 수 있습니다.

### 3. 차트 필터 탭
{: #3-the-chart-filters-tab }

**차트 필터**는 사용자 정의 차트를 미세 조정하는 데 사용됩니다. 모든 차트에 대해 복수의 필터를 정의할 수 있습니다.  
예를 들어, 특정 앱의 평균 앱 세션 지속 기간을 확인하는 데 관심이 있는 경우 다음과 같은 옵션을 지정할 수 있습니다.

1. **특성**에 대해 **애플리케이션 이름**을 선택하십시오.
2. **연산자**에 대해 **등호**를 선택하십시오.
3. **값**에 대해 앱의 이름을 선택하십시오.
4. **필터 추가**를 클릭하십시오.

앱 이름 필터가 차트의 필터 테이블에 추가됩니다.

### 4. 차트 특성
{: #4-chart-properties }

차트 특성은 **테이블**, **막대 그래프** 및 **선 그래프** 차트 유형에 사용할 수 있습니다. 차트 특성의 목표는 더 효과적으로 시각화를 수행하도록 데이터가 제공되는 방식을 개선하는 것입니다.

**테이블 차트**를 작성한 경우 차트 특성을 설정하여 테이블 페이지 크기, 정렬할 필드 및 필드 정렬 순서를 정의할 수 있습니다.

**막대 그래프** 또는 **선 그래프** 차트를 작성한 경우 차트 특성을 설정하여 차트를 모니터링하는 모든 사용자를 위한 참조 프레임을 추가할 임계값 선에 레이블을 지정할 수 있습니다.

<img class="gifplayer"  alt="사용자 정의 차트 작성" src="creating-custom-charts.png"/>

## 차트 유형
{: #chart-types }

### 막대 그래프
{: #bar-graph }

막대 그래프를 사용하면 X축 위에 숫자 데이터를 시각화할 수 있습니다. 막대 그래프를 정의하는 경우 먼저 X축의 값을 선택해야 합니다. 다음과 같은 가능한 값 중에서 선택할 수 있습니다.

* **타임라인** - 데이터를 상태동향으로 보려는 경우(예: 시간 경과에 따른 평균 앱 세션 지속 기간) X축에 대해 타임라인을 선택하십시오.
* **특성** - 특정 특성에 대한 개수 내역을 보려는 경우 특성을 선택하십시오. X축에 대해 특성을 선택하는 경우 Y축에 대해서는 총계가 내재적으로 선택됩니다. 예를 들어, X축에 대해 특성을 선택하고 특성에 대해 애플리케이션 이름을 선택하면 지정된 이벤트 유형에 대한 개수가 표시되며 앱 이름별로 구분됩니다.

X축에 대해 값을 정의한 후 Y축에 대한 값을 정의할 수 있습니다. X축에 대해 타임라인을 선택하는 경우 Y축에 대해 다음과 같은 가능한 값을 선택할 수 있습니다.

* **평균** - 제공된 이벤트 유형의 숫자 특성의 평균입니다.
* **총계** - 제공된 이벤트 유형의 특성의 총 개수입니다.
* **고유** - 제공된 이벤트 유형의 특성의 고유 개수입니다.

차트 축을 정의한 후 특성의 값을 선택해야 합니다.

### 선 그래프
{: #line-graph }

선 그래프를 사용하면 시간 경과에 따라 일부 메트릭을 시각화할 수 있습니다. 이 유형의 차트는 시간 경과에 따른 상태동향의 관점에서 데이터를 시각화하려는 경우에 유용합니다. 선 그래프를 작성할 때 정의할 첫 번째 값은 측정치이며 다음과 같은 값을 사용할 수 있습니다.

* **평균** - 제공된 이벤트 유형의 숫자 특성의 평균입니다.
* **총계** - 제공된 이벤트 유형의 특성의 총 개수입니다.
* **고유** - 제공된 이벤트 유형의 특성의 고유 개수입니다.

측정치를 정의한 후 특성의 값을 선택해야 합니다.

### 플로우 차트
{: #flow-chart }

플로우 차트를 사용하면 한 특성에서 다른 특성으로의 플로우 내역을 시각화할 수 있습니다. 플로우 차트의 경우 다음과 같은 특성을 설정해야 합니다.

* **소스** - 다이어그램에서 소스 노드의 값입니다.
* **대상** - 다이어그램에서 대상 노드의 값입니다.
* **특성** - 소스 노드 또는 대상 노드의 특성 값입니다.

플로우 차트를 사용하는 경우 대상으로 플로우하는 다양한 소스의 밀도 내역을 볼 수 있으며 그 반대의 경우도 마찬가지입니다. 예를 들어, 앱에 대한 로그 심각도 내역을 확인하려는 경우 다음과 같은 값을 정의할 수 있습니다.

* 소스에 대해 애플리케이션 이름을 선택하십시오.
* 대상에 대해 로그 레벨을 선택하십시오.
* 특성에 대해 앱의 이름을 선택하십시오.

### 메트릭 그룹
{: #metric-group }

메트릭 그룹은 평균값, 총 개수 또는 고유 개수로 측정되는 단일 메트릭을 시각화하는 데 사용할 수 있습니다. 메트릭 그룹을 정의하려면 측정치에 대해 다음 가능한 값 중 하나를 정의해야 합니다.

* **평균** - 제공된 이벤트 유형의 숫자 특성의 평균입니다.
* **총계** - 제공된 이벤트 유형의 특성의 총 개수입니다.
* **고유** - 제공된 이벤트 유형의 특성의 고유 개수입니다.

측정치를 정의한 후 특성의 값을 선택해야 합니다. 이 메트릭은 메트릭 그룹에 표시됩니다.

### 원형 차트
{: #pie-chart }

원형 차트는 특정 특성에 대한 값의 개수 내역을 시각화하는 데 사용할 수 있습니다. 예를 들어, 충돌 내역을 보려는 경우 다음과 같은 값을 정의하십시오.

* 이벤트 유형에 대해 앱 세션을 선택하십시오.
* 차트 유형에 대해 원형 차트를 선택하십시오.
* 특성에 대해 처리완료자를 선택하십시오.

결과 원형 차트에는 충돌에 의해 처리완료된 앱 세션과 대조적으로 사용자가 처리완료한 앱 세션의 내역이 표시됩니다.

### 테이블
{: #table }

테이블은 원시 데이터를 보려는 경우에 유용합니다. 테이블을 빌드하는 것은 보려는 원시 데이터에 대한 열을 추가하는 것만큼 단순합니다.  
특정 이벤트 유형의 경우 일부 특성이 필요하지 않으므로 널값이 테이블에 표시될 수 있습니다. 이 행이 테이블에 표시되지 않게 하려면 차트 필터 탭에서 특정 특성에 대해 존재함 필터를 추가하십시오.

## 클라이언트 로그에 대한 사용자 정의 차트 작성
{: #creating-custom-charts-for-client-logs }

플랫폼의 Logger API를 사용하여 전송되는 로그 정보가 포함된 클라이언트 로그에 대한 사용자 정의 차트를 작성할 수 있습니다.  
이 로그 정보에는 환경, 앱 이름 및 앱 버전을 포함하여 디바이스에 대한 컨텍스트 정보도 포함되어 있습니다.

> **참고:** 사용자 정의 차트를 채우기 위해 사용자 정의 이벤트를 로그해야 합니다. 클라이언트 앱에서 사용자 정의 이벤트를 전송하는 것에 대한 정보는 [사용자 정의 데이터 캡처](../../analytics-api/#custom-events)를 참조하십시오.

1. 클라이언트 앱에서 캡처한 로그를 서버에 전송하여 데이터를 채우십시오. [캡처된 로그 전송](../../analytics-api/#sending-analytics-data)을 참조하십시오.
2. {{ site.data.keys.mf_analytics_console }}에서 **사용자 정의 차트** 탭을 클릭한 후 차트 작성을 계속 수행하십시오.
    * **차트 제목**: 애플리케이션 및 로그 레벨
    * **이벤트 유형**: 클라이언트 로그
    * **차트 유형**: 플로우 차트

3. **차트 정의** 탭을 클릭한 후 다음과 같은 값을 제공하십시오.
    * **소스**: 애플리케이션 이름
    * **대상**: 로그 레벨
    * **특성**: 앱 이름

4. **저장** 단추를 클릭하십시오.

## 사용자 정의 차트 데이터 내보내기
{: #exporting-custom-chart-data }

사용자 정의 차트에 대해 표시되는 데이터를 다운로드할 수 있습니다.  

![이 아이콘을 사용하여 사용자 정의 차트 데이터 내보내기](export-data.png)

* **URL로 내보내기** - 체인 링크 모양
* **차트 다운로드** - 아래로 화살표 모양
* **차트 편집** - 연필 모양
* **차트 삭제** - 휴지통 모양

{{ site.data.keys.mf_analytics_console_short }}에서 JSON 형식의 파일을 다운로드하려면 **차트 다운로드** 아이콘을 클릭하십시오.  
{{ site.data.keys.mf_analytics_console_short }}에서 HTTP 클라이언트로부터 호출하기 위한 내보내기 링크를 생성하려면 **URL로 내보내기** 아이콘을 클릭하십시오. 이 옵션은 지정된 시간 간격으로 내보내기 프로세스를 자동화하는 스크립트를 작성하려는 경우에 유용합니다.

## 사용자 정의 차트 정의 내보내기 및 가져오기
{: #exporting-and-importing-custom-chart-definitions }

{{ site.data.keys.mf_analytics_console_short }}에서 사용자 정의 차트 정의를 내보내고 가져올 수 있습니다. 테스트 환경에서 프로덕션 배치로 이동하는 경우 새 클러스터에 대한 사용자 정의 차트를 다시 작성하는 대신 사용자 정의 차트 정의를 내보내서 시간을 절약할 수 있습니다.

1. {{ site.data.keys.mf_analytics_console_short }} 대시보드에서 **사용자 정의 차트** 탭을 클릭하십시오.
2. **차트 내보내기**를 클릭하여 차트 정의를 가진 JSON 파일을 다운로드하십시오.
3. JSON 파일을 저장할 위치를 선택하십시오.
4. **차트 가져오기**를 클릭하여 JSON 파일을 가져오십시오. 이미 존재하는 사용자 정의 차트 정의를 가져오는 경우 중복 정의를 작성할 수 있습니다. 이는 {{ site.data.keys.mf_analytics_console_short }}에 중복 사용자 정의 차트가 표시된다는 것도 의미합니다.
