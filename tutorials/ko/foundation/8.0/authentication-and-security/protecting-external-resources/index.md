---
layout: tutorial
title: 외부 자원을 인증하기 위해 MobileFirst 서버 사용
breadcrumb_title: 외부 자원 보호
relevantTo: [android,ios,windows,javascript]
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
보호된 자원은 {{ site.data.keys.mf_server }} (예: **어댑터**), 또는 **외부 서버**에서 실행될 수 있습니다. {{ site.data.keys.product }}과 함께 제공되는 유효성 검증 모듈을 사용하여 외부 서버에서 자원을 보호할 수 있습니다.

이 학습서에서는 {{ site.data.keys.product_adj }} **액세스 토큰**을 유효성 검증하는 **필터**를 구현하여 외부 **자원 서버**를 보호하는 방법에 대해 학습합니다.   
사용자 정의 코드로 그러한 보호를 전체적으로 구현하거나 플로우의 일부를 캡슐화하는 {{ site.data.keys.product }} 헬퍼 라이브러리 중 하나를 사용하여 구현할 수 있습니다.

**전제조건**  

* [{{ site.data.keys.product_adj }} 보안 프레임워크](../)를 이해하십시오. 

## 플로우
{: #flow }
![외부 자원 보호 다이어그램](external_resources_flow.jpg)

{{ site.data.keys.mf_server }} 서버는 **자체 점검 엔드포인트**라는 컴포넌트를 가지며, 이 컴포넌트는 {{ site.data.keys.product_adj }} **액세스 토큰**에서 데이터를 유효성 검증하고 추출할 수 있습니다. 이 자체 점검 엔드포인트는 REST API를 통해 사용 가능합니다.

1. {{ site.data.keys.product }} 클라이언트 SDK가 있는 애플리케이션은 `Authorization` 헤더(**클라이언트 액세스 토큰**)와 관계없이 보호된 자원에 자원 요청 호출(또는 HTTP 요청)을 작성합니다.
2. 자체 점검 엔드포인트와 통신하기 위해서는 자원 서버의 **필터**가 자체용 개별 토큰을 얻어야 합니다(**기밀 클라이언트** 섹션 참조).
3. 자원 서버의 **필터**는 단계 1에서 **클라이언트 액세스 토큰**을 추출하고 이를 유효성 검증을 위해 자체 점검 엔드포인트로 전송합니다. 
4. {{ site.data.keys.product_adj }} 인증 서버가 토큰이 유효하지 않다고(또는 존재하지 않는다고) 판별한 경우 자원 서버는 필수 범위에 대해 새 토큰을 얻기 위해 클라이언트를 경로 재지정합니다. 이 파트는 {{ site.data.keys.product_adj }} 클라이언트 SDK가 사용될 때 내부적으로 발생합니다. 

## 기밀 클라이언트
{: #confidential-client }
자체 점검 엔드포인트가 `authorization.introspect` 범위로 보호되는 내부 자원이므로 자원 서버는 데이터를 보내기 위해서 별도의 토큰을 얻어야 합니다. 권한 부여 헤더 없이 자체 점검 엔드포인트로 요청을 작성하려고 시도하면 401 응답이 리턴됩니다. 

외부 자원 서버가 `authorization.introspect` 범위에 대해 토큰을 요청할 수 있으려면 서버가 {{ site.data.keys.mf_console }}을 통해 **기밀 클라이언트**로 등록되어야 합니다.   

> [기밀 클라이언트](../confidential-clients/) 학습서에서 자세히 알아보십시오. 

{{ site.data.keys.mf_console }}의 **설정 → 기밀 클라이언트** 아래에서 새 항목을 추가하십시오. **클라이언트 본인확인정보** 및 **API 본인확인정보** 값을 선택하십시오. `authorization.introspect`를 **허용 범위**로 설정하십시오. 

<img class="gifplayer" alt="기밀 클라이언트 구성" src="confidential-client.png"/>

## 구현
{: #implementations }
이 플로우는 다양한 REST API에 대한 직접 HTTP 요청을 작성하여 수동으로 구현될 수 있습니다(문서 참조).  
{{ site.data.keys.product }}는 또한 제공된 **신뢰 연관 인터셉터** 또는 제공된 **Java 토큰 유효성 검증기**를 사용하는 기타 다른 Java 기반 필터를 사용하여 **WebSphere** 서버에서 이를 달성하도록 돕기 위해 라이브러리를 제공합니다. 
