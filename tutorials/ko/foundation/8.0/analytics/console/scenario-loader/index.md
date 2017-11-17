---
layout: tutorial
title: 시나리오 로더
breadcrumb_title: 시나리오 로더
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

> **참고:** 시나리오 로더는 사실상 *실험적*이므로 완전히 지원되지는 않습니다. 상황에 맞게 적절하게 사용하십시오. 
>
> * 일부 차트는 채워지지 않습니다. 

시나리오 로더는 다양한 {{ site.data.keys.mf_analytics_console_full }} 차트 및 보고서를 더미 데이터로 채웁니다. 이 데이터는 Elasticsearch 데이터 저장소에 저장되며 기존 테스트 또는 프로덕션 데이터와 안전하게 구분됩니다. 

로드된 데이터는 사실상 합성 데이터이며 데이터 저장소에 직접 삽입됩니다. 이는 클라이언트 또는 서버에서 작성한 실제 Analytics 데이터의 결과가 아닙니다. 이 데이터의 용도는 사용자가 UI에 표시된 대로 다양한 보고서 및 차트의 특성을 더 잘 파악할 수 있게 하는 것입니다. 따라서 이 데이터는 테스트 용도로 사용해서는 **안 됩니다**. 

#### 다음으로 이동
{: #jump-to }

* [시작하기 전에](#before-you-start)
* [시나리오 로더에 연결](#connecting-to-the-scenario-loader)
* [데이터 로드 구성](#configuring-the-data-loading)
* [데이터 로드 및 삭제](#loading-and-deleting-the-data)
* [채워진 차트 및 테이블 보기](#viewing-the-populated-charts-and-tables)
* [디버그 모드 사용 안함](#disabling-the-debug-mode)

## 시작하기 전에
{: #before-you-start }

시나리오 로더는 {{ site.data.keys.mf_analytics_console }}에 패키지되어 제공됩니다. 시나리오 로더에 연결하기 전에 {{ site.data.keys.mf_analytics_console_short }}이 실행 중이며 액세스 가능한지 확인하십시오. 

## 시나리오 로더에 연결
{: #connecting-to-the-scenario-loader }

1. 시나리오 로더를 사용하려면 JVM 인수 `-DwlDevEnv=true` 또는 환경 변수 `ANALYTICS_DEBUG=true`를 설정하십시오. 

2. 콘솔 URL `http://<console-path>/scenarioLoader`를 사용하여 브라우저에서 시나리오 로더에 액세스하십시오. 여기서 `<console-path>`는 `mfp-server/usr/servers/mfp/server.xml` 파일에서 정의된 JNDI 특성 값입니다. 예를 들어, 다음과 같습니다. 

    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. 시나리오 로더 페이지가 {{ site.data.keys.mf_analytics_console_short }} 탐색줄과 함께 표시됩니다. 시나리오 로더는 탐색줄에서 액세스 불가능한 상태로 남아 있습니다. 

## 데이터 로드 구성
{: #configuring-the-data-loading}

1. **구성 테스트** 섹션에서는 생성된 데이터의 특성(**기본** 탭) 및 볼륨(**용량 계획** 탭)을 제어하기 위해 다양한 설정을 사용할 수 있습니다. 충분한 데이터를 로드하기 위해 **히스토리 일 수** 설정이 30일 이상으로 설정되어 있는지 확인하십시오. 

    이러한 설정에 대해 사용 가능한 모든 정보가 **구성 테스트** 섹션에 제공됩니다. 

2. **관리** 아이콘 <img  alt="렌치 아이콘" style="margin:0;display:inline" src="wrench.png"/>을 클릭한 후 **설정** 탭을 선택하십시오. **고급** 섹션에서 **기본 테넌트** 값이 `dummy_data_for_demo_purposes_only`로 설정되어 있는지 확인하십시오. 

## 데이터 로드 및 삭제
{: #loading-and-deleting-the-data }

데이터를 로드하려면 **시나리오 조작** 섹션에서 **시나리오 로드 시작** 단추를 클릭하십시오. 

데이터를 삭제하려면 **구성 테스트** 섹션에서 **지금 삭제** 단추를 클릭하십시오. 

**NB:** **시나리오 조작** 섹션에서 데이터 작성 및 삭제에 대한 면책사항을 읽으십시오. 

## 채워진 차트 및 테이블 보기
{: #viewing-the-populated-charts-and-tables }

데이터가 로드되면 Analytics Console에서 사용 가능한 다수의(전부는 아님) 차트 및 테이블이 채워집니다. 

{{ site.data.keys.mf_analytics_console_short }} 탐색줄에서 다양한 페이지 및 탭을 확인하여 채워진 차트 및 테이블을 보십시오. 

## 디버그 모드 사용 안함
{: #disabling-the-debug-mode }

디버그 모드에서 작업한 후 실제 데이터와 합성 데이터에 대해 작업하려면 다음을 수행하십시오. 

1. **구성 테스트** 섹션에서 **지금 삭제** 단추를 클릭하여 데이터를 삭제하십시오. 
2. **설정** → **고급** 섹션에서 **기본 테넌트** 값이 `worklight`로 설정되어 있는지 확인하십시오. 
3. true로 설정된 변수의 경우 false로 설정하십시오(JVM 인수 `-DwlDevEnv=false` 또는 환경 변수 `ANALYTICS_DEBUG=false`). 
4. {{ site.data.keys.mf_analytics_server }}를 다시 시작하십시오. 
