---
layout: tutorial
title: 데이터 보존 및 제거
breadcrumb_title: Data Retention and Purging
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics }} 데이터는 서버에 저장되며 데이터가 제거될 때까지 보고를 위해 사용할 수 있습니다. 유지되거나 제거되는 이벤트 유형 데이터를 제어할 수 있습니다. 데이터는 정기적으로 또는 수동으로 제거할 수 있습니다.

## Analytics Console에서 데이터 보존 구성
{: #configuring-data-retention-from-the-analytics-console }

1. {{ site.data.keys.mf_analytics_console }}에서 **관리** 아이콘(<img  alt="렌치 아이콘" style="margin:0;display:inline" src="wrench.png"/>)을 클릭하십시오.
2. **설정** 탭을 선택하십시오.

   ![데이터 보존 구성](analytics_console_data_retention.png)

   * 데이터를 즉시 삭제하려면 **버리기** 단일 선택 단추를 선택하십시오.
   * **데이터 보관 기간** 열에서 유지할 일 수를 선택하거나 기본값인 **무기한 데이터 보관** 값을 그대로 두십시오.

3. **변경사항 저장**을 클릭하십시오.

새 보존 정책이 적용됩니다.
