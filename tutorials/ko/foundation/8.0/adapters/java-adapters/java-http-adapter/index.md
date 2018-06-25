---
layout: tutorial
title: Java HTTP 어댑터
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

Java 어댑터는 백엔드 시스템으로 연결에 대해 완전한 자유를 제공합니다. 따라서 성능 및 기타 구현 세부사항을 최적화하는 것은 개발자의 책임입니다. 이 학습서는 Java `HttpClient`를 사용하여 RSS 피드에 연결하는 Java 어댑터의 예제를 다룹니다.

**전제조건:** [Java 어댑터](../) 학습서를 먼저 읽으십시오.

>**중요:** 어댑터 구현 내에서 `javax.ws.rs.*` 또는 `javax.servlet.*`의 클래스에 대해 정적 참조를 사용하는 경우에는 아래 옵션 중 하나를 사용하여 **RuntimeDelegate**를 구성해야 합니다.
*	Liberty `jvm.options`의 `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` 설정
또는
*	시스템 특성 또는 JVM 사용자 정의 특성 `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` 설정

## 어댑터 초기화
{: #initializing-the-adapter }

제공된 샘플 어댑터에서 `JavaHTTPApplication` 클래스가 `MFPJAXRSApplication`을 확장하는 데 사용되고 이는 애플리케이션에서 요구하는 초기화를 트리거하기 좋은 위치입니다.

```java
@Override
protected void init() throws Exception {
    JavaHTTPResource.init();
    logger.info("Adapter initialized!");
}
```

## 어댑터 자원 클래스 구현
{: #implementing-the-adapter-resource-class }

어댑터 자원 클래스는 서버에 대한 요청이 처리되는 위치입니다.  
제공된 샘플 어댑터에서 클래스 이름은 `JavaHTTPResource`입니다.

```java
@Path("/")
public class JavaHTTPResource {

}
```

`@Path("/")`는 자원이 URL `http(s)://host:port/ProjectName/adapters/AdapterName/`에서 사용 가능함을 의미합니다.

### HTTP 클라이언트
{: #http-client }

```java
private static CloseableHttpClient client;
private static HttpHost host;

public static void init() {
  client = HttpClientBuilder.create().build();
  host = new HttpHost("mobilefirstplatform.ibmcloud.com");
}
```

자원에 대한 모든 요청이 `JavaHTTPResource`의 새 인스턴스를 작성하므로, 성능에 영향을 줄 수 있는 오브젝트를 재사용하는 것은 중요합니다. 이 예에서 Http 클라이언트를 `static` 오브젝트로 만들었고, static `init()` 메소드에서 초기화했으며, 위에서 설명한 바와 같이 `JavaHTTPApplication`의 `init()`에 의해 호출됩니다.

### 프로시저 자원
{: #procedure-resource }

```java
@GET
@Produces("application/json")
public void get(@Context HttpServletResponse response, @QueryParam("tag") String tag)
    throws IOException, IllegalStateException, SAXException {
  if(tag!=null &&  !tag.isEmpty()){
    execute(new HttpGet("/blog/atom/"+ tag +".xml"), response);
  }
  else{
    execute(new HttpGet("/feed.xml"), response);
  }

}
```

샘플 어댑터는 RSS 피드를 백 엔드 서비스에서 검색하도록 허용하는 하나의 자원 URL만 노출시킵니다.

* `@GET`은 이 프로시저가 `HTTP GET` 요청에 응답함을 의미합니다.
* `@Produces("application/json)`는 보낼 응답의 컨텐츠 유형을 지정합니다. 클라이언트 측에서 용이하도록 `JSON` 오브젝트로 응답을 보내기로 선택했습니다.
* `@Context HttpServletResponse response`는 응답 출력 스트림에 쓰는 데 사용됩니다. 이는 단순 문자열을 리턴하는 것보다 더 세분화할 수 있게 합니다.
* `@QueryParam("tag)` 문자열 태그는 프로시저가 매개변수를 수신할 수 있게 합니다. `QueryParam`을 선택하는 것은 매개변수가 조회( `/JavaHTTP/?tag=MobileFirst_Platform`)에서 전달됨을 의미합니다. 다른 옵션에는 `@PathParam`, `@HeaderParam`, `@CookieParam`, `@FormParam` 등이 포함됩니다.
* `throws IOException, ...`은 클라이언트로 예외를 다시 전달하고 있음을 의미합니다. 클라이언트 코드는 `HTTP 500` 오류로 수신되는 잠재적 예외를 처리하는 것을 담당합니다. (프로덕션 코드에서 더 가능성이 많은) 다른 솔루션은 서버 Java 코드에서 예외를 처리하고 정확한 오류를 기반으로 클라이언트에 전송할 내용을 결정하는 것입니다.
* `execute(new HttpGet("/feed.xml"), response)`. 백 엔드 서비스에 대한 실제 HTTP 요청은 나중에 정의된 다른 메소드에서 처리합니다.

`tag` 매개변수를 전달하는지 여부에 따라 `execute`는 다양한 빌드, 경로 및 RSS 파일을 검색합니다.

### execute()
{: #execute }

```java
public void execute(HttpUriRequest req, HttpServletResponse resultResponse)
        throws IOException,
        IllegalStateException, SAXException {
    HttpResponse RSSResponse = client.execute(host, req);
    ServletOutputStream os = resultResponse.getOutputStream();
    if (RSSResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){  
        resultResponse.addHeader("Content-Type", "application/json");
        String json = XML.toJson(RSSResponse.getEntity().getContent());
        os.write(json.getBytes(Charset.forName("UTF-8")));

    }else{
        resultResponse.setStatus(RSSResponse.getStatusLine().getStatusCode());
        RSSResponse.getEntity().getContent().close();
        os.write(RSSResponse.getStatusLine().getReasonPhrase().getBytes());
    }
    os.flush();
    os.close();
}
```

* `HttpResponse RSSResponse = client.execute(host, req)`. HTTP 요청을 실행하고 응답을 저장하기 위해 정적 HTTP 클라이언트를 사용합니다.
* `ServletOutputStream os = resultResponse.getOutputStream()`. 이는 응답을 클라이언트에 쓰기 위한 출력 스트림입니다.
* `resultResponse.addHeader("Content-Type", "application/json")`. 앞에서 언급한 것처럼 JSON으로 응답을 보내기로 선택했습니다.
* `String json = XML.toJson(RSSResponse.getEntity().getContent())`. JSON 문자열로 XML RSS를 변환하기 위해 `org.apache.wink.json4j.utils.XML`을 사용했습니다.
* `os.write(json.getBytes(Charset.forName("UTF-8")))` 결과로 생긴 JSON 문자열이 출력 스트림에 작성됩니다.

그런 다음 출력 스트림은 `flush`되고 `close`됩니다.

만약 `RSSResponse`가 `200 OK`가 아니면 그 대신 상태 코드 및 이유를 응답에 작성합니다.

## 샘플 어댑터
{: #sample-adapter }

어댑터 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오.

어댑터 Maven 프로젝트는 위에서 설명한 **JavaHTTP** 어댑터를 포함합니다.

### 샘플 사용법
{: #sample-usage }

* [JavaHTTP 어댑터를 빌드 및 배치](../../creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오.
* 어댑터를 테스트하거나 디버깅하려면 [어댑터 테스트 및 디버깅](../../testing-and-debugging-adapters) 학습서를 참조하십시오.
