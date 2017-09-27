---
layout: tutorial
title: Node.js 유효성 검증기
breadcrumb_title: Node.js 유효성 검증기
relevantTo: [android,ios,windows,javascript]
weight: 3
downloads:
  - name: 샘플 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 외부 자원에서 보안 기능을 강제 실행하기 위해 Node.js 프레임워크를 제공합니다.  
Node.js 프레임워크는 npm 모듈(**passport-mfp-token-validation**)로 제공됩니다. 

이 학습서는 범위(`accessRestricted`)를 사용하여 단순 Node.js 자원, `GetBalance`를 보호하는 방법을 보여줍니다. 

**전제조건:**  

* [외부 자원을 인증하기 위해 {{ site.data.keys.mf_server }} 사용](../) 학습서를 읽으십시오. 
* [{{ site.data.keys.product }} 보안 프레임워크](../../)를 이해하십시오. 

## passport-mfp-token-validation 모듈
{: #the-passport-mfp-token-validation-module }
passport-mfp-token-validation 모듈은 {{ site.data.keys.mf_server }}에서 발행한 액세스 토큰을 확인하기 위해 인증 메커니즘을 제공합니다. 

모듈을 설치하려면 다음을 실행하십시오. 

```bash
npm install passport-mfp-token-validation@8.0.X
```

## 사용법
{: #usage }
* 샘플은 `express` 및 `passport-mfp-token-validation` 모듈을 사용합니다. 

  ```javascript
  var express = require('express');
  var passport = require('passport-mfp-token-validation').Passport;
  var mfpStrategy = require('passport-mfp-token-validation').Strategy;
  ```

* 다음과 같이 `Strategy`를 설정하십시오. 

  ```javascript
  passport.use(new mfpStrategy({
    authServerUrl: 'http://localhost:9080/mfp/api',
    confClientID: 'testclient',
    confClientPass: 'testclient',
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
  }));
  ```
  
 * `authServerUrl`: `localhost:9080`을 사용자의 {{ site.data.keys.mf_server }} IP 주소 및 포트 번호로 대체하십시오. 
 * `confClientID`, `confClientPass`: 기밀 클라이언트 ID 및 비밀번호를 사용자가 {{ site.data.keys.mf_console }}에서 정의한 것으로 대체하십시오. 
 * `analytics`: 분석 항목은 선택적이며 분석 이벤트를 {{ site.data.keys.product }}에 로그하려는 경우에만 필요합니다.   
`localhost:9080`, `username`, 및 `password`를 사용자의 Analytics Server IP 주소, 포트 번호, 사용자 이름, 비밀번호로 대체하십시오. 

* `passport.authenticate`를 호출하여 요청을 인증하십시오. 

  ```javascript
  var app = express();
  app.use(passport.initialize());

  app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
      session: false,
      scope: 'accessRestricted'
  }),
  function(req, res) {
      res.send('17364.9');
  });

  var server = app.listen(3000, function() {
      var port = server.address().port
      console.log("Sample app listening at http://localhost:%s", port)
  });
  ```

 * 사용할 `Strategy`는 `mobilefirst-strategy`이어야 합니다. 
 * `session`을 `false`로 설정하십시오. 
 * `scope` 이름을 지정하십시오.

## 샘플 애플리케이션 
{: #sample-application }
[Node.js 샘플을 다운로드하십시오](https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80).

### 샘플 사용법
{: #sample-usage }
1. 샘플의 루트 폴더로 이동하여 다음 명령을 차례로 입력하십시오. `npm install` `npm start`.
2. [기밀 클라이언트](../#confidential-client) 및 본인확인정보 값을 {{ site.data.keys.mf_console }}에서 업데이트하십시오. 
3. **[UserLogin](../../user-authentication/security-check/)** 또는 **[PinCodeAttempts](../../credentials-validation/security-check/)** 보안 검사 중 하나를 배치하십시오. 
4. 일치하는 애플리케이션을 등록하십시오. 
5. `accessRestricted` 범위를 보안 검사에 맵핑하십시오. 
6. 서블릿 URL에 대한 `WLResourceRequest`를 작성하기 위해 클라이언트 애플리케이션을 업데이트하십시오. 
