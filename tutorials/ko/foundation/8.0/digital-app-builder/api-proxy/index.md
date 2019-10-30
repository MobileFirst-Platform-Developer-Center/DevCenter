---
layout: tutorial
title: API 프록시를 사용하여 마이크로서비스에 연결
weight: 15
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## API 프록시
{: #dab-api-proxy }

엔터프라이즈 백엔드에 연결 시에 API 프록시를 사용하여 MobileFirst 플랫폼의 보안 및 분석을 활용할 수 있습니다. 이름이 암시하듯, 이는 실제 백엔드에 대한 요청에서 프록싱에 사용될 수 있는 프록시입니다.

### API 프록시 사용의 일부 장점

* 실제 백엔드 호스트는 모바일 앱에 공개되지 않으며 MobileFirst 서버에서 보안 상태를 유지합니다.
* 백엔드에 대해 작성된 요청의 분석을 가져옵니다.

### API 프록시 사용법

1. Mobile Foundation Console에서 모바일 API 프록시 어댑터를 다운로드하십시오.

    ![API 프록시](dab-api-proxy.png)

2. API 프록시 어댑터를 Mobile Foundation 서버에 배치하십시오.

3. API 프록시 어댑터 구성에서 백엔드 URI를 구성하십시오. URI는 `protocol:host:port/context` 형식이어야 합니다. 예: `http://secure-backend/basecontext/`.
4. `WLResourceRequest API`를 사용하여 백엔드에 대한 요청을 작성하십시오. **MOBILE CORE** 섹션에서 API 호출 코드 스니펫을 사용하십시오. 옵션 오브젝트를 변경하여 `useAPIProxy` 키를 true로 설정하십시오.

    예:
    ```
        var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
    );
    resourceRequest.send().then(
        function(response) {
            alert("Success: " + response.responseText);
        },
        function(response) {
            alert("Failure: " + JSON.stringify(response));
        }
    );
    ```
