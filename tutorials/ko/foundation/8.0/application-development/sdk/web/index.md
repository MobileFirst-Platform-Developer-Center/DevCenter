---
layout: tutorial
title: 웹 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: 웹
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
선호하는 개발 환경 및 도구를 사용하여 모바일 또는 데스크탑 {{ site.data.keys.product_adj }} 웹 애플리케이션을 개발할 수 있습니다.   
이 학습서에서는 웹 애플리케이션에 {{ site.data.keys.product_adj }} 웹 SDK를 추가하는 방법 및 {{ site.data.keys.mf_server }}에 웹 애플리케이션을 등록하는 방법에 대해 학습합니다.

{{ site.data.keys.product_adj }} 웹 SDK는 JavaScript 파일 세트로 제공되며 [NPM에서 사용 가능](https://www.npmjs.com/package/ibm-mfp-web-sdk)합니다.   
SDK에는 다음 파일이 포함됩니다.

- **ibmmfpf.js** - SDK의 핵심입니다.
- **ibmmfpfanalytics.js** - {{ site.data.keys.mf_analytics }}에 대한 지원을 제공합니다.

#### 다음으로 이동
{: #jump-to }
- [전제조건](#prerequisites)
- [{{ site.data.keys.product_adj }} 웹 SDK 추가](#adding-the-mobilefirst-web-sdk)
- [{{ site.data.keys.product_adj }} 웹 SDK 초기화](#initializing-the-mobilefirst-web-sdk)
- [웹 애플리케이션 등록](#registering-the-web-application)
- [{{ site.data.keys.product_adj }} 웹 SDK 업데이트](#updating-the-mobilefirst-web-sdk)
- [동일 출처 정책](#same-origin-policy)
- [보안 출처 정책](#secure-origins-policy)
- [다음 학습서](#tutorials-to-follow-next)

## 전제조건
{: #prerequisites }
-   웹 개발 환경 설정에 대해서는 [지원되는 웹 브라우저](../../../installation-configuration/development/web/#web-app-supported-browsers)
전제조건을 참조하십시오.

-   NPM 명령을 실행하려면 [Node.js](https://nodejs.org)를 설치해야 합니다.

## {{ site.data.keys.product_adj }} 웹 SDK 추가
{: #adding-the-mobilefirst-web-sdk }
신규 또는 기존 웹 애플리케이션에 SDK를 추가하려면 먼저 워크스테이션에 다운로드한 후 웹 애플리케이션에 추가하십시오.

### SDK 다운로드
{: #downloading-the-sdk }
1. **명령행** 창에서 웹 애플리케이션의 루트 폴더로 이동하십시오.
2. `npm install ibm-mfp-web-sdk` 명령을 실행하십시오.

이 명령은 다음 디렉토리 구조를 작성합니다.

![SDK 폴더 컨텐츠](sdk-folder.png)

### SDK 추가
{: #adding-the-sdk }
{{ site.data.keys.product }} 웹 SDK를 추가하려면 웹 애플리케이션에서 표준 방식으로 참조하십시오.   
또한 SDK는 [AMD를 지원](https://en.wikipedia.org/wiki/Asynchronous_module_definition)하므로 모듈 로더(예: [RequireJS](http://requirejs.org/))를 사용하여 SDK를 로드할 수 있습니다.

#### 표준
`HEAD` 요소의 **ibmmfpf.js** 파일을 참조하십시오.   

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

#### RequireJS 사용

**HTML**  

```html
<script type="text/javascript" src="node_modules/requirejs/require.js" data-main="index"></script>
```

**JavaScript**

```javascript
require.config({
	'paths': {
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['mfp'], function(WL) {
    // application logic.
});
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 분석 지원을 추가하는 경우 **ibmmfpfanalytics.js** 파일 참조를 **ibmmfpf.js** 파일 참조 **앞**에 두십시오.

## {{ site.data.keys.product_adj }} 웹 SDK 초기화
{: #initializing-the-mobilefirst-web-sdk }
웹 애플리케이션의 기본 JavaScript 파일에서 **컨텍스트 루트** 및 **애플리케이션 ID** 값을 지정하여 {{ site.data.keys.product }} 웹 SDK를 초기화하십시오.

```javascript
var wlInitOptions = {
    mfpContextRoot : '/mfp', // "mfp" is the default context root in the {{ site.data.keys.product }}
    applicationId : 'com.sample.mywebapp' // Replace with your own value.
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Application logic.
});
```

- **mfpContextRoot:** {{ site.data.keys.mf_server }}에서 사용하는 컨텍스트 루트입니다.
- **applicationId:** 애플리케이션 패키지 이름으로, [애플리케이션 등록](#registering-the-web-application) 시에 정의됩니다.

### 웹 애플리케이션 등록
{: #registering-the-web-application }
{{ site.data.keys.mf_console }} 또는 {{ site.data.keys.mf_cli }}에서 애플리케이션을 등록할 수 있습니다.

#### {{ site.data.keys.mf_console }}에서
{: #from-mobilefirst-operations-console }
1. 선호하는 브라우저를 열고 `http://localhost:9080/mfpconsole/` URL을 입력하여 {{ site.data.keys.mf_console }}을 로드하십시오.
2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 작성하십시오.
3. **웹**을 플랫폼으로 선택하고 이름 및 ID를 제공하십시오.
4. **애플리케이션 등록**을 클릭하십시오.

![웹 플랫폼 추가](add-web-platform.png)

#### {{ site.data.keys.mf_cli }}에서
{: #from-mobilefirst-cli }
**명령행** 창에서 웹 애플리케이션의 루트 폴더로 이동하고 `mfpdev app register` 명령을 실행하십시오.

## {{ site.data.keys.product_adj }} 웹 SDK 업데이트
{: #updating-the-mobilefirst-web-sdk }
SDK 릴리스는 SDK의 [NPM 저장소](https://www.npmjs.com/package/ibm-mfp-web-sdk)에 있습니다.   
최신 릴리스로 {{ site.data.keys.product_adj }} 웹 SDK를 업데이트하려면 다음을 수행하십시오.

1. 웹 애플리케이션의 루트 폴더로 이동하십시오.
2. `npm update ibm-mfp-web-sdk` 명령을 실행하십시오.

## 동일 출처 정책
{: #same-origin-policy }
{{ site.data.keys.mf_server }}가 설치된 서버 시스템이 아닌 다른 서버 시스템에서 웹 자원이 호스팅되는 경우 [동일 출처 정책](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) 위반이 트리거됩니다. 동일 출처 정책 보안 모델은 확인되지 않은 소스의 잠재적 보안 위협에 대해 보호하도록 디자인되어 있습니다. 이 정책에 따라 브라우저에서 웹 자원(예: 스크립트)은 출처(URI 스키마, 호스트 이름 및 포트 번호의 조합으로 정의됨)가 동일한 자원과 상호작용하는 것만 허용됩니다. 동일 출처 정책에 대한 자세한 정보는 [Web Origin Concept](https://tools.ietf.org/html/rfc6454) 스펙, 특히 [3. Principles of the Same-Origin Policy](https://tools.ietf.org/html/rfc6454#section-3)를 참조하십시오.

{{ site.data.keys.product_adj }} 웹 SDK를 사용하는 웹 앱은 지원되는 토폴로지에서 처리되어야 합니다. 예를 들어 동일한 단일 출처를 유지하지만 역방향 프록시를 사용하여 내부에서 적절한 서버로 요청의 경로를 재지정하십시오.

### 대체
{: #alternatives }
다음 메소드 중 하나를 사용하여 정책 요구사항을 충족할 수 있습니다.

- 예를 들어 {{ site.data.keys.mf_dev_kit_full }}에서 사용되는 동일한 WAS(WebSphere Application Server) Liberty 프로파일 애플리케이션 서버에서 웹 애플리케이션 자원 제공
- Node.js를 역방향 프록시로 사용하여 {{ site.data.keys.mf_server }}로 애플리케이션 요청의 경로 재지정

> [웹 개발 환경 설정](../../../installation-configuration/development/web) 학습서에서 자세히 알아보십시오.

## 보안 출처 정책
{: #secure-origins-policy }
개발 중에 Chrome을 사용하는 경우 `localhost`가 **아닌** 호스트 및 HTTP를 둘 다 사용하면 브라우저에서 애플리케이션을 로드할 수 없습니다. 이 브라우저에서는 기본적으로 보안 출처 정책이 구현 및 사용되기 때문입니다.

다음 플래그로 Chrome 브라우저를 시작하여 이를 해결할 수 있습니다.

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- 플래그가 작동하게 하려면 "test-to-new-user-profile/myprofile"을 새 Chrome 사용자 프로파일로 작동하는 폴더 위치로 대체하십시오.

[이 Chormium 개발자 문서](https://www.chromium.org/Home/chromium-security/prefer-secure-origins-for-powerful-new-features)에서 보안 출처에 대해 자세히 알아보십시오.

## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product_adj }} 웹 SDK가 통합되었으므로 다음을 수행할 수 있습니다.

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [모든 학습서](../../../all-tutorials) 검토
