---
layout: tutorial
title: Java HTTP 适配器
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

Java 适配器可自由控制与后端系统的连接。 因此，开发人员有责任确保有关性能和其他实施细节的最佳实践。 本教程包含 Java 适配器的示例，该适配器通过 Java `HttpClient` 连接到 RSS 订阅源。

**先决条件：**请务必先阅读 [Java 适配器](../)教程。

>**要点：**如果在适配器实现中使用对 `javax.ws.rs.*` 或 `javax.servlet.*` 中的类的静态引用，那么应确保使用以下选项之一来配置 **RuntimeDelegate**：
*	在 Liberty `jvm.options` 中设置 `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl`，或者
*	设置系统属性或 JVM 定制属性 `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl`

## 初始化适配器
{: #initializing-the-adapter }

在提供的样本适配器中，`JavaHTTPApplication` 类用于扩展 `MFPJAXRSApplication`，可用于触发应用程序所需的任何初始化。

```java
@Override
    protected void init() throws Exception {
    JavaHTTPResource.init();
    logger.info("Adapter initialized!");
}
```

## 实现适配器资源类
{: #implementing-the-adapter-resource-class }

适配器资源类用于处理服务器的请求。  
在提供的样本适配器中，类名是 `JavaHTTPResource`。

```java
@Path("/")
public class JavaHTTPResource {

}
```

`@Path("/")` 表示可从 URL `http(s)://host:port/ProjectName/adapters/AdapterName/` 获取资源。

### HTTP 客户机
{: #http-client }

```java
private static CloseableHttpClient client;
private static HttpHost host;

public static void init() {
  client = HttpClientBuilder.create().build();
  host = new HttpHost("mobilefirstplatform.ibmcloud.com");
}
```

因为资源的每个请求都将创建一个新 `JavaHTTPResource` 实例，所以复用可能影响性能的对象很重要。 在此示例中，我们将为 Http 客户机生成一个 `static` 对象，并使用静态 `init()` 方法对其初始化，可通过如上所述的 `JavaHTTPApplication` 的 `init()` 来调用该方法。

### 过程资源
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

样本适配器仅公开一个资源 URL，其允许从后端服务检索 RSS 订阅源。

* `@GET` 表示此过程仅响应 `HTTP GET` 请求。
* `@Produces("application/json")` 指定送回的响应的内容类型。 我们选择将响应作为 `JSON` 对象发送，使其在客户机端上更加简单。
* `@Context HttpServletResponse response` 用于写入响应输出流。 这使我们能够返回更加详细的内容，而不是简单的字符串。
* `@QueryParam("tag")` 字符串标记使过程能够接收参数。 选择 `QueryParam` 表示将在查询（`/JavaHTTP/?tag=MobileFirst_Platform`）中传递参数。 其他选项包括 `@PathParam`、`@HeaderParam`、`@CookieParam`、`@FormParam` 等。
* `throws IOException, ...` 表示将任何异常转发回客户机。 客户机代码负责处理将接收为 `HTTP 500` 错误的潜在异常。 另一个解决方案（很可能在生产代码中出现）处理服务器 Java 代码中的异常，并根据确切的错误，确定发送到客户机的内容。
* `execute(new HttpGet("/feed.xml"), response)`. 后端服务的实际 HTTP 请求由稍后定义的其他方法处理。

根据是否传递 `tag` 参数，`execute` 将检索其他构建的不同路径并检索其他 RSS 文件。

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

* `HttpResponse RSSResponse = client.execute(host, req)`. 我们使用静态 HTTP 客户机来执行 HTTP 请求并存储响应。
* `ServletOutputStream os = resultResponse.getOutputStream()`. 这是用于写入客户机响应的输出流。
* `resultResponse.addHeader("Content-Type", "application/json")`. 如上所述，我们选择以 JSON 格式发送响应。
* `String json = XML.toJson(RSSResponse.getEntity().getContent())`. 我们使用 `org.apache.wink.json4j.utils.XML` 将 XML RSS 转换为 JSON 字符串。
* `os.write(json.getBytes(Charset.forName("UTF-8")))` 生成的 JSON 字符串将写入到输出流中。

然后 `flush` 并 `close` 输出流。

如果 `RSSResponse` 不是 `200 OK`，我们将在响应中写入状态码和原因。

## 样本适配器
{: #sample-adapter }

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

适配器 Maven 项目包含上面所述的 **JavaHTTP** 适配器。

### 样本用法
{: #sample-usage }

* 使用 Maven {{ site.data.keys.mf_cli }} 或您选择的 IDE 来[构建和部署 JavaHTTP 适配器](../../creating-adapters/)。
* 要测试或调试适配器，请参阅[测试和调试适配器](../../testing-and-debugging-adapters)教程。
