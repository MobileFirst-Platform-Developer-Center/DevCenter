---
layout: tutorial
title: Cloudant와 통합
relevantTo: [javascript]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Cloudant는 IBM Cloud 및 `cloudant.com`에서 DBaaS(Database-as-a-Service) 및 독립형 제품으로 사용할 수 있는 CouchDB를 기반으로 한 NoSQL 데이터베이스입니다. 

Cloudant 문서에서 설명된 바와 같이,
> 문서는 JSON 오브젝트입니다. 문서는 데이터의 컨테이너이고 Cloudant 데이터베이스의 기초입니다.  
모든 문서는 두 개의 필드 즉, 고유 `_id` 필드와 `_rev` 필드가 있어야 합니다. `_id` 필드는 사용자가 작성하거나 Cloudant가 UUID로 자동으로 생성합니다. `_rev` 필드는 개정 번호이고 Cloudant 애플리케이션 프로토콜에 필수적입니다. 이러한 두 개의 필수 필드 외에 문서는 JSON으로 표현된 기타 컨텐츠를 포함할 수 있습니다.

Cloudant API는 [IBM Cloudant Documentation](https://docs.cloudant.com/index.html) 사이트에 문서화되어 있습니다.

원격 Cloudant 데이터베이스와 통신하기 위해 어댑터를 사용할 수 있습니다. 이 학습서는 사용자에게 일부 예제를 보여줍니다.

이 학습서는 사용자가 어댑터에 익숙하다고 가정하고 있습니다. [JavaScript HTTP 어댑터](../javascript-adapters/js-http-adapter) 또는 [Java 어댑터](../java-adapters)를 참조하십시오.

### 다음으로 이동
{: #jump-to}
* [JavaScript HTTP 어댑터](#javascript-http-adapter)
* [Java 어댑터](#java-adapters)
* [샘플 애플리케이션](#sample-application)


## JavaScript HTTP 어댑터
{: #javascript-http-adapter }
Cloudant API는 단순 HTTP 웹 서비스로 액세스될 수 있습니다.

HTTP 어댑터를 사용할 때 `invokeHttp` 메소드로 Cloudant HTTP 서비스에 연결할 수 있습니다.

### 인증
{: #authentication }
Cloudant는 여러 양식의 인증을 지원합니다. 인증에 대한 Cloudant 문서를 [https://docs.cloudant.com/authentication.html](https://docs.cloudant.com/authentication.html)에서 참조하십시오. JavaScript HTTP 어댑터에서 **기본 인증**을 사용할 수 있습니다.

어댑터 XML 파일에서 Cloudant 인스턴스에 대해 `domain` 및 `port`를 지정하고 `basic` 유형의 `authentication` 요소를 추가하십시오. 프레임워크는 `Authorization: Basic` HTTP 헤더를 생성하기 위해 이러한 신임 정보를 사용합니다.

**참고:** Cloudant에서 실제 사용자 이름과 비밀번호 대신 사용할 고유 API 키를 생성할 수 있습니다.

```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>https</protocol>
    <domain>CLOUDANT_ACCOUNT.cloudant.com</domain>
    <port>443</port>
    <connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
    <socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
    <authentication>
      <basic/>
        <serverIdentity>
          <username>CLOUDANT_KEY</username>
          <password>CLOUDANT_PASSWORD</password>
        </serverIdentity>
    </authentication>
    <maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
    <!-- Following properties used by adapter's key manager for choosing specific certificate from key store
    <sslCertificateAlias></sslCertificateAlias>
    <sslCertificatePassword></sslCertificatePassword>
    -->
  </connectionPolicy>
</connectivity>
```

### 프로시저
{: #procedures }
어댑터 프로시저는 HTTP 요청을 Cloudant가 정의한 URL 중 하나에게 보내기 위해 `invokeHttp` 메소드를 사용합니다.  
예를 들어, 저장하려는 문서에 대한 JSON 표시인 본문과 함께 `POST` 요청을 `/{*your-database*}/`에 전송하여 새 문서를 작성할 수 있습니다.

```js
function addEntry(entry){

    var input = {
            method : 'post',
            returnedContentType : 'json',
            path : DATABASE_NAME + '/',
            body: {
                contentType : 'application/json',        
                content : entry
            }
        };

    var response = MFP.Server.invokeHttp(input);
    if(!response.id){
        response.isSuccessful = false;
    }
    return response;

}
```

동일한 아이디어가 모든 Cloudant 함수에 적용될 수 있습니다. 문서에 대한 Cloudant 문서를 [https://docs.cloudant.com/document.html](https://docs.cloudant.com/document.html)에서 참조하십시오.

## Java 어댑터
{: #java-adapters }
Cloudant는 사용자가 Cloudant의 모든 기능을 쉽게 사용할 수 있도록 [Java 클라이언트 라이브러리](https://github.com/cloudant/java-cloudant)를 제공합니다.

Java 어댑터의 초기화 동안, 작업할 `CloudantClient` 인스턴스를 설정하십시오.  
**참고:** Cloudant에서 실제 사용자 이름과 비밀번호 대신 사용할 고유 API 키를 생성할 수 있습니다.

```java
CloudantClient cloudantClient = new CloudantClient(cloudantAccount,cloudantKey,cloudantPassword);
db = cloudantClient.database(cloudantDBName, false);
```
<br/>
[Plain Old Java Objects](https://en.wikipedia.org/wiki/Plain_Old_Java_Object) 및 JAX-RS 2.0(RESTful 웹 서비스용 표준 Java API)을 사용하여 HTTP 요청에 문서의 JSON 표시를 전송함으로써 Cloudant에서 새 문서를 작성할 수 있습니다.

```java
@POST
@Consumes(MediaType.APPLICATION_JSON)
public Response addEntry(User user){
    if(user!=null && user.isValid()){
        db.save(user);
        return Response.ok().build();
    }
    else{
        return Response.status(418).build();
    }
}
```

<img alt="샘플 애플리케이션의 이미지" src="cloudant-app.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-application }
Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80)하십시오.

샘플은 두 개의 어댑터 즉 JavaScript에서 하나 및 Java에서 하나를 포함합니다.  
또한 Java 및 JavaScript 어댑터 둘 다로 작업하는 Cordova 애플리케이션을 포함합니다.

> **참고:** 샘플은 알려진 제한사항으로 인해 Cloudant Java Client v1.2.3을 사용합니다.

### 샘플 사용법
{: #sample-usage }
샘플 README.md 파일의 지시사항을 따르십시오.
