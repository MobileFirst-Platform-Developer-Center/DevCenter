---
layout: tutorial
title: 웹 개발 환경 설정
breadcrumb_title: 웹
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
웹 애플리케이션을 개발하고 테스트하는 것은 사용자가 선택한 웹 브라우저에서 로컬 HTML 파일을 미리 보는 것만큼 쉽습니다.   
개발자는 선택한 IDE를 사용할 수 있고 요구에 맞는 모든 프레임워크를 사용할 수 있습니다. 

하지만 웹 애플리케이션 개발을 방해하는 문제가 하나 있을 수 있습니다. [동일 출처 정책](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) 위반으로 인해 웹 애플리케이션에 오류가 발생할 수 있습니다. 동일 출처 정책은 웹 브라우저에서 적용되는 제한사항입니다. 예를 들어, 애플리케이션이 도메인 **example.com**에서 호스팅되는 경우 동일한 서버는 다른 서버 또는 해당 문제에 대해 {{ site.data.keys.mf_server }}에서 사용할 수 있는 컨텐츠에 액세스할 수 없습니다. 

[{{ site.data.keys.product }} 웹 SDK를 사용해야 하는 웹 앱](../../../application-development/sdk/web)은 지원되는 토폴로지에서 처리되어야 합니다(예: 리버스 프록시를 사용하여 동일한 단일 출처는 유지하면서 적절한 서버로 내부적으로 요청의 경로를 재지정함). 

정책 요구사항은 다음 방법 중 하나를 사용하여 충족할 수 있습니다. 

- {{ site.data.keys.mf_server }}도 호스팅하는 동일한 WebSphere Full/Liberty 프로파일 애플리케이션 서버에서 웹 애플리케이션 자원 제공
- Node.js를 프록시로 사용하여 애플리케이션 요청의 경로를 {{ site.data.keys.mf_server }}로 재지정

<br/>
**전제조건**  
다음을 사용하려면 개발자의 워크스테이션에 Apache Maven 또는 Node.js가 설치되어 있어야 합니다.   
지시사항은 [설치 안내서](../mobilefirst/installation-guide/)를 참조하십시오.

## WebSphere Liberty 프로파일을 사용하여 웹 애플리케이션 자원 제공
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
웹 애플리케이션의 자원을 제공하려면 Maven webapp(**.war** 파일)에 이를 저장해야 합니다. 

### Maven webapp 원형 작성
{: #creating-a-maven-webapp-archetype }
1. **명령행** 창에서 선택하는 위치로 이동하십시오. 
2. 명령을 실행하십시오. 

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - **MyCompany** 및 **MyWebApp**을 사용자의 고유 값으로 바꾸십시오. 
    - 값을 하나씩 입력하려면 `-DinteractiveMode=false` 플래그를 제거하십시오. 

### 웹 애플리케이션의 자원을 사용하여 Maven webapp 빌드 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. 웹 애플리케이션의 자원(예: HTML, CSS, JavaScript 및 이미지 파일)을 생성된 **[MyWebApp] → src → Main → webapp** 폴더 내부에 배치하십시오. 

    > 여기서부터 **webapp** 폴더를 웹 애플리케이션의 개발 위치로 간주하십시오. 

2. `mvn clean install` 명령을 실행하여 애플리케이션의 웹 자원이 포함된 .war 파일을 생성하십시오.
  
생성된 .war 파일은 **[MyWebApp] → target** 폴더에 있습니다. 
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 웹 자원을 업데이트할 때마다 `mvn clean install`을 실행해야 합니다.

### 애플리케이션 서버에 Maven webapp 추가
{: #adding-the-maven-webapp-to-the-application-server }
1. WebSphere Application Server의 **server.xml 파일**을 편집하십시오.
  
{{ site.data.keys.mf_dev_kit }}을 사용하는 경우 파일의 위치는 [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp** 폴더입니다. 다음 항목을 추가하십시오. 

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - **name** 및 **path-to/MyWebApp.war**을 사용자의 고유 값으로 바꾸십시오. 
    - 변경사항을 **server.xml** 파일에 저장하고 나면 애플리케이션 서버가 자동으로 다시 시작됩니다.   

### 웹 애플리케이션 테스트
{: #testing-the-web-application }
웹 애플리케이션을 테스트할 준비가 되면 URL **localhost:9080/MyWebApp**을 방문하십시오. 
    - **MyWebApp**을 사용자의 고유 값으로 바꾸십시오. 

## Node.js 사용
{: #using-nodejs }
Node.js는 웹 애플리케이션에서 {{ site.data.keys.mf_server }}로 요청을 전달하는 리버스 프록시로 사용될 수 있습니다. 

1. **명령행** 창에서 웹 애플리케이션의 폴더로 이동한 후 다음과 같은 명령 세트를 실행하십시오.  

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. **node_modules** 폴더에 새 파일을 작성하십시오(예: **proxy.js**). 
3. 다음 코드를 파일에 추가하십시오. 

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Web server - serves the web application
   app.get('/home', function(req, res) {
        // Website you wish to allow to connect
        res.sendFile(__dirname + '/index.html');
   });

   // Reverse proxy, pipes the requests to/from {{ site.data.keys.mf_server }}
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - **port** 값을 선호하는 값으로 바꾸십시오. 
    - `/myapp`을 웹 애플리케이션에 대해 선호하는 경로 이름으로 바꾸십시오. 
    - `/index.html`을 기본 HTML 파일의 이름으로 바꾸십시오. 
    - 필요한 경우 `/mfp/*`를 {{ site.data.keys.product }} 런타임의 컨텍스트 루트로 업데이트하십시오. 

4. 프록시를 시작하기 위해 `node proxy.js` 명령을 실행하십시오. 
5. 웹 애플리케이션을 테스트할 준비가 되면 URL **server-hostname:port/app-name**을 방문하십시오(예: **http://localhost:9081/myapp**). 
    - **server-hostname**을 사용자의 고유 값으로 바꾸십시오. 
    - **port**를 사용자의 고유 값으로 바꾸십시오. 
    - **app-name**을 사용자의 고유 값으로 바꾸십시오. 

## 다음 단계
{: #next-steps }
웹 애플리케이션에서 {{ site.data.keys.product }} 개발을 계속하려면 {{ site.data.keys.product }} 웹 SDK를 웹 애플리케이션에 추가해야 합니다. 

* [{{ site.data.keys.product }} SDK를 웹 애플리케이션에](../../../application-development/sdk/web/) 추가하는 방법을 학습하십시오. 
* 애플리케이션 개발에 대해서는 [{{ site.data.keys.product }} SDK 사용](../../../application-development/) 학습서를 참조하십시오. 
* 어댑터 개발에 대해서는 [어댑터](../../../adapters/) 카테고리를 참조하십시오. 
