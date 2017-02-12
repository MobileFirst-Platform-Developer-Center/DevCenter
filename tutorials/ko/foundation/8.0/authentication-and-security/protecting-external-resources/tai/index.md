---
layout: tutorial
title: 신뢰 연관 인터셉터
breadcrumb_title: 신뢰 연관 인터셉터
relevantTo: [android,ios,windows,javascript]
weight: 2
다운로드:
  - 이름: 다운로드 샘플
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 [IBM WebSphere의 신뢰 연관 인터셉터](https://www.ibm.com/support/knowledgecenter/SSHRKX_8.5.0/mp/security/sec_ws_tai.dita)를 통한 외부 자원의 인증을 용이하게 하기 위해 Java 라이브러리를 제공합니다. 

Java 라이브러리는 JAR 파일(**com.ibm.mfp.oauth.tai-8.0.0.jar**)로서 제공됩니다. 

이 학습서는 범위(`accessRestricted`)를 사용하여 단순 Java Servlet, `TAI/GetBalance`를 보호하는 방법을 보여줍니다. 

**전제조건:**

* [외부 자원을 인증하기 위해 {{ site.data.keys.mf_server }} 사용](../) 학습서를 읽으십시오. 
* [{{ site.data.keys.product }} 보안 프레임워크](../../)에 익숙해 지십시오.

![플로우](TAI_flow.jpg)

## 서버 설정
{: #server-setup }
1. **{{site.data.keys.mf_console }} → 다운로드 센터 → 도구** 탭에서 Security Tools.zip을 다운로드하십시오. zip 안에는 `mfp-oauth-tai.zip` 아카이브가 있습니다. 이 zip을 압축 해제하십시오. 
2. `com.ibm.mfp.oauth.tai.jar` 파일을 **usr/extension/lib** 안의 WebSphere Application Server 인스턴스에 추가하십시오. 
3. `OAuthTai.mf` 파일을 **usr/extension/lib/features** 안의 WebSphere Application Server 인스턴스에 추가하십시오. 

### web.xml 설정
{: #webxml-setup }
보안 제한조건과 보안 역할을 WebSphere Application Server 인스턴스의 `web.xml` 파일에 추가하십시오.

```xml
<security-constraint>
   <web-resource-collection>
      <web-resource-name>TrustAssociationInterceptor</web-resource-name>
      <url-pattern>/TAI/GetBalance</url-pattern>
   </web-resource-collection>
   <auth-constraint>
      <role-name>TAIUserRole</role-name>
   </auth-constraint>
</security-constraint>

<security-role id="SecurityRole_TAIUserRole">
   <description>This is the role that {{ site.data.keys.product }} OAuthTAI uses to protect the resource, and it is mandatory to map it to 'All Authenticated in Application' in WebSphere Application Server full profile and to 'ALL_AUTHENTICATED_USERS' in WebSphere Application Server Liberty.</description>
   <role-name>TAIUserRole</role-name>
</security-role>
```

### server.xml
{: #serverxml }
사용자의 외부 자원에 대해 WebSphere Application Server `server.xml`
파일을 수정하십시오. 

* 다음 기능을 포함하도록 기능 관리자를 구성하십시오.

  ```xml
  <featureManager>
           <feature>jsp-2.2</feature>
           <feature>appSecurity-2.0</feature>
           <feature>usr:OAuthTai-8.0</feature>
           <feature>servlet-3.0</feature>
           <feature>jndi-1.0</feature>
  </featureManager>
  ```

* 보안 역할을 사용자의 클래스 어노테이션으로 Java 서블릿에 추가하십시오.

```java
@ServletSecurity(@HttpConstraint(rolesAllowed = "TAIUserRole"))
```

servlet-2.x를 사용 중인 경우 보안 역할을 사용자의 web.xml 파일에 정의해야 합니다.

```xml
<application contextRoot="TAI" id="TrustAssociationInterceptor" location="TAI.war" name="TrustAssociationInterceptor"/>
   <application-bnd>
      <security-role name="TAIUserRole">
         <special-subject type="ALL_AUTHENTICATED_USERS"/>
      </security-role>
   </application-bnd>
</application>
```

* OAuthTAI를 구성하십시오. 여기에서 URL이 보호되도록 설정됩니다. 

  ```xml
  <usr_OAuthTAI id="myOAuthTAI" authorizationURL="http://localhost:9080/mfp/api" clientId="ExternalResourceId" clientSecret="ExternalResourcePass" cacheSize="500">
            <securityConstraint httpMethods="GET POST" scope="accessRestricted" securedURLs="/GetBalance"></securityConstraint>
  </usr_OAuthTAI>
  ```
    - **authorizationURL**: 사용자의 {{ site.data.keys.mf_server }} (`http(s):/your-hostname:port/runtime-name/api`) 또는 외부 AZ 서버(예: IBM DataPower) 중 하나입니다. 

    - **clientID**: 자원 서버는 등록된 기밀 클라이언트여야 합니다. 기밀 클라이언트를 등록하는 방법을 알아보려면 [기밀 클라이언트](../../confidential-clients/) 학습서를 읽으십시오. 토큰을 유효성 검증할 수 있도록 *기밀 클라이언트*가 허용 범위 `authorization.introspect`를 *반드시** 가져야 합니다. 

    - **clientSecret**: 자원 서버는 등록된 기밀 클라이언트여야 합니다. 기밀 클라이언트를 등록하는 방법을 알아보려면 [기밀 클라이언트](../../confidential-clients/) 학습서를 읽으십시오. 
    - **cacheSize (선택사항)**: TAI는 클라이언트에서 요청과 함께 제공되는 토큰이 단기간의 간격 동안 다시 자체 점검할 필요가 없도록 토큰과 자체 점검 데이터를 값으로 캐시하기 위해 Java-토큰-유효성 검증기 캐시를 사용합니다. 

        기본 크기는 50,000개 토큰입니다.   

        각 요청에서 토큰이 자체 점검되도록 보장하려면 캐시 값을 0으로 설정하십시오.   

    - **범위**: 자원 서버가 하나 이상의 범위에 대하여 인증합니다. 범위는 보안 검사에 맵핑된 보안 검사 또는 범위 요소일 수 있습니다. 

## TAI로부터 토큰 자체 점검 데이터 사용
{: #using-the-token-introspection-data-from-the-tai }
사용자의 자원에서, TAI가 인터셉트하고 유효성 검증한 토큰 정보에 액세스하고자 할 수 있습니다. [API 참조](../../../api/java-token-validator) 토큰에 있는 데이터 목록을 찾을 수 있습니다. 이 데이터를 얻으려면 [WSSubject API]를 사용하십시오(http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_sec_apis.html). 

```java
Map<String, String> credentials = WSSubject.getCallerSubject().getPublicCredentials(Hashtable.class).iterator().next();
JSONObject securityContext = new JSONObject(credentials.get("securityContext"));
...
securityContext.get('mfp-device')
```

## 샘플 애플리케이션
{: #sample-application }
지원되는 애플리케이션 서버(WebSphere Application Server 전체 프로파일 및 WebSphere Application Server Liberty 프로파일)에서 프로젝트를 배치할 수 있습니다.   
[단순 Java 서블릿을 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80)하십시오.

### 샘플 사용법
{: #sample-usage }
1. [기밀 클라이언트](../#confidential-client) 및 본인확인정보 값을 {{ site.data.keys.mf_console }}에서 업데이트하십시오.
2. **[UserLogin](../../user-authentication/security-check/)** 또는 **[PinCodeAttempts](../../credentials-validation/security-check/)** 보안 검사 중 하나를 배치하십시오. 
3. 일치하는 애플리케이션을 등록하십시오. 
4. `accessRestricted` 범위를 보안 검사에 맵핑하십시오. 
5. 서블릿 URL에 대한 `WLResourceRequest`를 작성하기 위해 클라이언트 애플리케이션을 업데이트하십시오. 
6. 사용자의 securityConstraint 범위의 범위가 클라이언트가 인증해야 하는 보안 검사가 되도록 설정하십시오. 
