---
layout: tutorial
title: Java HTTP アダプター
breadcrumb_title: HTTP Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

Java アダプターでは、バックエンド・システムへの接続を自由に制御できます。 したがって、開発者の責任で、パフォーマンスおよびその他の実装の詳細についてのベスト・プラクティスを実現する必要があります。 このチュートリアルでは、Java `HttpClient` を使用して RSS フィードに接続する Java アダプターの例を取り上げます。

**前提条件:** 最初に必ず、[Java アダプター](../)チュートリアルをお読みください。

>**重要:** アダプター実装内で `javax.ws.rs.*` または `javax.servlet.*` からクラスへの静的参照を使用する場合、以下のいずれかのオプションを使用して必ず **RuntimeDelegate** を構成する必要があります。
*	Liberty `jvm.options` で `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` を設定します
または
*	システム・プロパティーまたは JVM カスタム・プロパティー `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` を設定します

## アダプターの初期化
{: #initializing-the-adapter }

提供されているサンプル・アダプターでは、`JavaHTTPApplication` クラスは `MFPJAXRSApplication` を拡張するために使用されていて、アプリケーションで必要な初期化をトリガーする場合に適しています。

```java
@Override
    protected void init() throws Exception {
    JavaHTTPResource.init();
    logger.info("Adapter initialized!");
}
```

## アダプター・リソース・クラスの実装
{: #implementing-the-adapter-resource-class }

アダプター・リソース・クラスは、サーバーに対する要求を処理する場所です。  
提供されているサンプル・アダプターでは、クラス名は `JavaHTTPResource` です。

```java
@Path("/")
public class JavaHTTPResource {

}
```

`@Path("/")` は、URL `http(s)://host:port/ProjectName/adapters/AdapterName/` でリソースが使用可能であることを意味します。

### HTTP クライアント
{: #http-client }

```java
private static CloseableHttpClient client;
private static HttpHost host;

public static void init() {
  client = HttpClientBuilder.create().build();
  host = new HttpHost("mobilefirstplatform.ibmcloud.com");
}
```

リソースに対する要求を出すたびに `JavaHTTPResource` の新規インスタンスが作成されるため、パフォーマンスに影響する可能性があるオブジェクトを再利用することが重要です。 この例では、HTTP クライアントを `static` オブジェクトにし、それを静的 `init()` メソッドで初期化します。このメソッドは、前述のように、`JavaHTTPApplication` の `init()` によって呼び出されます。

### プロシージャー・リソース
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

このサンプル・アダプターは、バックエンド・サービスからの RSS フィードの取得を可能にするリソース URL を 1 つだけ公開します。

* `@GET` は、このプロシージャーが `HTTP GET` 要求のみに応答することを示します。
* `@Produces("application/json")` は、送り返す応答のコンテンツ・タイプを指定します。 クライアント・サイドで処理しやすいように、応答を `JSON` オブジェクトとして送信することにします。
* `@Context HttpServletResponse response` を使用して、応答出力ストリームに書き込みます。 これにより、単純なストリングを返す場合より細分性を高めることができます。
* `@QueryParam("tag")` ストリング・タグにより、プロシージャーがパラメーターを受け取ることができます。 `QueryParam` を選択することは、照会 (`/JavaHTTP/?tag=MobileFirst_Platform`) でパラメーターを渡すことを意味します。 その他のオプションとしては、`@PathParam`、 `@HeaderParam`、`@CookieParam`、`@FormParam` などがあります。
* `throws IOException, ...` は、例外をすべてクライアントに転送することを表します。 `HTTP 500` エラーとして受信される潜在的な例外をクライアント・コードで処理する必要があります。 別の解決策として (多くの場合は実動コードで使用されますが)、サーバーの Java コードで例外を処理し、クライアントに何を送信するかを具体的なエラーに基づいて決定するという方法があります。
* `execute(new HttpGet("/feed.xml"), response)`。 バックエンド・サービスに対する実際の HTTP 要求は、後で定義される別のメソッドで処理されます。

`tag` パラメーターを渡すかどうかによって、`execute` がビルドするパス、および取得する RSS ファイルが異なります。

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

* `HttpResponse RSSResponse = client.execute(host, req)`。 統計 HTTP クライアントを使用して HTTP 要求を実行し、応答を保管します。
* `ServletOutputStream os = resultResponse.getOutputStream()`。 応答をクライアントに書き込む出力ストリームです。
* `resultResponse.addHeader("Content-Type", "application/json")`。 前に述べたように、応答を JSON として送信することを選択します。
* `String json = XML.toJson(RSSResponse.getEntity().getContent())`。 `org.apache.wink.json4j.utils.XML` を使用して、XML RSS を JSON ストリングに変換します。
* `os.write(json.getBytes(Charset.forName("UTF-8")))` で、結果の JSON ストリングを出力ストリームに書き込みます。

その後、出力ストリームが`フラッシュ`されて`閉じられます`。

`RSSResponse` が `200 OK` でない場合、代わりに状況コードと理由を応答に書き込みます。

## サンプル・アダプター
{: #sample-adapter }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

アダプター Maven プロジェクトには、前に説明した **JavaHTTP** アダプターが含まれています。

### 使用例
{: #sample-usage }

* Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[JavaHTTP アダプターのビルドとデプロイ](../../creating-adapters/)を行います。
* アダプターをテストまたはデバッグするには、[アダプターのテストおよびデバッグ](../../testing-and-debugging-adapters)チュートリアルを参照してください。
