---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics_full }}는 데이터 저장 및 검색 조회 실행을 위해 **Elasticsearch 1.5x**를 사용합니다.  

Elasticsearch는 데이터 저장 및 탐색의 속도 및 스케일 비율을 늘리는 실시간 분산 검색 및 분석 엔진입니다. Elasticsearch는 전체 텍스트 검색, 구조화된 검색에 사용됩니다.

Elasticsearch는 {{ site.data.keys.mf_analytics_server }}의 Elasticsearch 인스턴스에서 JSON 형식으로 모든 모바일 및 서버 데이터를 저장하는 데 사용됩니다.

Elasticsearch 인스턴스는 {{ site.data.keys.mf_analytics_console_full }}을 채우기 위해 실시간으로 조회됩니다.

{{ site.data.keys.mf_analytics }}는 모든 Elasticsearch 기능을 노출합니다. 사용자는 Elasticsearch 조회, 디버깅 및 최적화를 완전히 활용할 수 있습니다.

여기에 설명된 기능 이상의 Elasticsearch 기능에 대한 자세한 정보는 [Elasticsearch 문서](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)를 참조하십시오.

## {{ site.data.keys.mf_analytics_server }}에서 Elasticsearch 관리
{: #managing-elasticsearch-on-the-mobilefirst-analytics-server }

Elasticsearch는 {{ site.data.keys.mf_analytics_server }}에 임베드되며 노드 및 클러스터 동작에 참여합니다.

> Analytics Server에서 Elasticsearch 구성에 대한 자세한 정보는 [{{ site.data.keys.mf_analytics_server }} 구성 안내서](../../installation-configuration/production/analytics/configuration) 주제에서 [클러스터 관리 및 Elasticsearch](../../installation-configuration/production/analytics/configuration#cluster-management-and-elasticsearch)를 참조하십시오.

### Elasticsearch 특성
{: #elasticsearch properties }

Elasticsearch 특성은 JNDI 변수 또는 환경 항목을 통해 사용할 수 있습니다.  
Elasticsearch 데이터 보기를 시작하는 데 유용한 JNDI 특성 중 하나는 다음과 같습니다.

```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
```

이 JNDI 특성을 사용하면 JSON 형식으로 {{ site.data.keys.mf_analytics_short }} 원시 데이터를 보고 Elasticsearch에 의해 정의되는 포트를 통해 Elasticsearch 인스턴스에 액세스할 수 있습니다. 기본 포트는 9500입니다.

> **참고**: 이 설정은 안전하지 않으므로 프로덕션 환경에서는 사용으로 설정해서는 안 됩니다.

## Elasticsearch REST API
{: #elasticsearch-rest-api }

Elasticsearch 인스턴스에 액세스할 수 있으면 사용자 정의 조회를 실행하고 Elasticsearch 클러스터에 대한 자세한 정보를 볼 수 있습니다.

**데이터 검색 및 보기**  
테넌트의 `_search` REST 엔드포인트를 방문하여 모든 데이터를 볼 수 있습니다.  

```
http://localhost:9500/*/_search
```

**클러스터 상태 보기**  

```
http://localhost:9500/_cluster/health
```

**현재 노드에 대한 정보 보기**  

```
http://localhost:9500/_nodes
```

**현재 맵핑 보기**  

```
http://localhost:9500/*/_mapping
```

> Elasticsearch는 다수의 추가 REST 엔드포인트를 노출합니다. 자세히 학습하려면 [Elasticsearch 문서](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)를 참조하십시오.
