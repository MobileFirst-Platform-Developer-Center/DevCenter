---
layout: tutorial
title: Windows .NET 消息检验器
breadcrumb_title: Windows .NET Message Inspector
relevantTo: [android,ios,windows,javascript]
weight: 4
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
本教程显示如何使用作用域 (`accessRestricted`) 来保护简单 Windows .NET 资源 `GetBalanceService`。
在样本中，我们将保护名为 DotNetTokenValidator 的控制台应用程序自托管的服务。

首先，我们将定义**消息检验器**，用于帮助我们控制 `GetBalanceService` 资源的入局请求。
使用此消息检验器，我们将检查入局请求并验证其是否提供 **{{ site.data.keys.product_adj }} 授权服务器**所需的所有必需头。

**先决条件：**

* 确保阅读[使用 {{ site.data.keys.mf_server }} 来认证外部资源](../)教程。
* 了解 [{{ site.data.keys.product_adj }} 安全框架](../../)。

#### 跳转至：
{: #jump-to }
* [创建和配置 WCF Web HTTP 服务](#create-and-configure-wcf-web-http-service)
* [定义消息检验器](#define-a-message-inspector)
* [消息检验器实施](#message-inspector-implementation)
    * [预处理验证](#pre-process-validation)
    * [从 {{ site.data.keys.product_adj }} 授权服务器获取访问令牌](#obtain-access-token-from-mobilefirst-authorization-server)
    * [使用客户机令牌将请求发送到自省端点](#send-request-to-introspection-endpoint-with-client-token)
    * [处理后验证](#post-process-validation)

## 创建和配置 WCF Web HTTP 服务
{: #create-and-configure-wcf-web-http-service }
首先，我们将创建 **WCF 服务**并称之为 `GetBalanceService`，稍后将通过**消息检验器**进行保护。
在示例中，我们将使用控制台应用程序作为服务的托管程序。

以下是 `getBalance`（受保护资源）的代码：

```csharp
public class GetBalanceService : IGetBalanceService {
  public string getBalance()
  {
    Console.WriteLine("getBalance()");
    return "19938.80";
  }
}
```

我们也应定义 `ServiceContract`：

```csharp
[ServiceContract]
public interface IGetBalanceService
{
  [OperationContract]
  [WebInvoke(Method = "GET",
  BodyStyle = WebMessageBodyStyle.Wrapped,
  ResponseFormat = WebMessageFormat.Json,
  UriTemplate = "getBalance")]
  string getBalance();
}
```

现在，我们已准备好服务，可配置主机应用程序如何使用服务。 在 App.config 文件中完成此操作，如下所示：

```xml
<service behaviorConfiguration="Default" name="DotNetTokenValidator.GetBalanceService">
  <endpoint address="" behaviorConfiguration="webBehavior" binding="webHttpBinding" contract="DotNetTokenValidator.IGetBalanceService" />
  <host>
    <baseAddresses>
      <add baseAddress="http://localhost:8732/GetBalanceService" />
    </baseAddresses>
  </host>
</service>
```
最后，我们应通过托管程序 `Main` 方法运行：

```csharp
static void Main(string[] args) {
  // Create the ServiceHost.
  using (ServiceHost host = new ServiceHost(typeof(GetBalanceService)))
  {
    // Enable metadata publishing.
    ServiceMetadataBehavior smb = new ServiceMetadataBehavior();
    smb.HttpGetEnabled = true;

    Console.WriteLine("The service is ready at {0}", host.BaseAddresses[0]);
    host.Open();

    Console.WriteLine("Press <Enter> to stop the service.");
    Console.ReadLine();

    // Close the ServiceHost.
    host.Close();
  }
}
```

> 有关 WCF REST 服务的更多信息，请参阅 [Create a Basic WCF Web HTTP Service](https://msdn.microsoft.com/en-us/library/bb412178(v=vs.100).aspx)

## 定义消息检验器
{: #define-a-message-inspector}
在开始验证过程之前，必须创建并定义用于保护资源（服务端点）的**消息检验器**。
消息检验器是一个扩展性对象，可在服务中用于在接收消息之后或者在发送消息之前检查和更改消息。 服务消息检验器应实现 `IDispatchMessageInspector` 接口：

```csharp
public class MyInspector : IDispatchMessageInspector
```

任何服务消息检验器都必须实现两个 `IDispatchMessageInspector` 方法 `AfterReceiveRequest` 和 `BeforeSendReply`：

```csharp
public class MyInspector : IDispatchMessageInspector {

  public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext){
  ...
  }

  public void BeforeSendReply(ref Message reply, object correlationState){
    // In our case there is no need for any code here
  }
}
```

在创建消息检验器之后，应进行定义以保护特定端点。 使用行为完成此操作。 **行为**是一个类，通过更改缺省配置或添加扩展（例如，消息检验器）更改服务模型运行时的行为。
使用 2 个类完成此操作：一个配置消息检验器以保护应用程序端点，另一个返回此行为类实例和类型。

```csharp
public class MyCustomBehavior : IEndpointBehavior
{
  ...
  public void ApplyDispatchBehavior(ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
  {
    endpointDispatcher.DispatchRuntime.MessageInspectors.Add(new MyInspector());
  }
  ...
}

public class MyCustomBehaviorExtension : BehaviorExtensionElement
{
  public override Type BehaviorType
  {
    get { return typeof(MyCustomBehavior); }
  }

  protected override object CreateBehavior()
  {
    return new MyCustomBehavior();
  }
}
```

在 `App.config` 文件中，我们定义 `behaviorExtension`，并将其附加到刚刚创建的行为类：

```xml
<extensions>
  <behaviorExtensions>
    <add name="extBehavior" type="DotNetTokenValidator.Inspector.MyCustomBehaviorExtension, DotNetTokenValidator"/>
  </behaviorExtensions>
</extensions>
```

然后，将此 behaviorExtension 添加到在服务中配置为端点行为的 webBehavior 元素：

```xml
<behavior name="webBehavior">
  <webHttp />
  <extBehavior />
</behavior>
```

## 消息检验器实施
{: #message-inspector-implementation}

首先，在消息检验器中，将一些常量定义为类成员：{{ site.data.keys.mf_server }} URL、保密客户机凭证以及将用于保护服务的 `scope`。 我们还可以定义静态变量以保留从 {{ site.data.keys.product_adj }} 授权服务器收到的令牌，因此它将可用于所有用户：

```csharp
private const string azServerBaseURL = "http://YOUR-SERVER-URL:9080/mfp/api/az/v1/";
private const string scope = "accessRestricted";
private static string filterIntrospectionToken = null;
private const string filterUserName = "USERNAME"; // Confidential Client Username
private const string filterPassword = "PASSWORD";  // Confidential Client Secret
```

接下来将创建 `validateRequest` 方法，这是将在消息检验器中实施的验证过程的起点。 然后，在之前提及的 `AfterReceiveRequest` 方法中添加对此方法的调用：

```csharp
public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext){
  validateRequest(request);
  return null;
}
```

在 `validateRequest` 中，我们将实施 3 个主要步骤：

1. **预处理验证** - 检查请求是否具有**授权头**，并且如果存在，那么是否以**“Bearer”**前缀开头。
2. 从 {{ site.data.keys.product_adj }} 授权服务器**获取令牌** - 此令牌将用于针对 {{ site.data.keys.product_adj }} 授权服务器认证客户机的令牌。
3. **处理后验证** - 检查**冲突**，验证请求是否已发送正确的**作用域**，并检查请求是否为**活动**状态。

```csharp
private void validateRequest(Message request)
{
  // Pre-process validation: Eextract the clientToken out of the request, check it is not empty and that it starts with "Bearer"
  string clientToken = getClientTokenFromHeader(request);

  // Get token          
  if (filterIntrospectionToken == null)
  {
    filterIntrospectionToken = getIntrospectionToken();
  }

  // Check client auth header against mfp authrorization server using the token I received in previous step
  HttpWebResponse introspectionResponse = introspectClientRequest(clientToken);

  // Check if introspectionToken has expired (401)
  // - if so we should obtain a new token and resend the client request
  if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
  {
    filterIntrospectionToken = getIntrospectionToken();
    introspectionResponse = introspectClientRequest(clientToken);
  }

  // Post-process validation: check that the MFP authrorization server response is valid and includes the requested scope
  postProcess(introspectionResponse);
}
```

## 预处理验证
{: #pre-process-validation }
预处理验证是作为 getClientTokenFromHeader() 方法的一部分完成的。
此过程基于 2 项检查：

1. 检查请求的授权头是否不为空。
2. 如果不为空，检查授权头是否以“Bearer”前缀开头。

在两种情况下，都应以**未经授权的响应状态** (401) 进行响应，并添加 **WWW-Authenticate:Bearer** 头。  
在验证授权头之后，此方法将返回从客户机应用程序收到的令牌。

```csharp
private string getClientTokenFromHeader(Message request)
{
  string token = null;
  string authHeader = null;

  // Extract the authorization header from the request
  var httpRequest = (HttpRequestMessageProperty)request.Properties[HttpRequestMessageProperty.Name];
  authHeader = httpRequest.Headers[HttpRequestHeader.Authorization];

  // Pre-process validation         
  if ((string.IsNullOrEmpty(authHeader) || !authHeader.StartsWith("Bearer", StringComparison.CurrentCulture)))
  {
    WebHeaderCollection webHeaderCollection = new WebHeaderCollection();
    webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer");
    returnErrorResponse(HttpStatusCode.Unauthorized, webHeaderCollection);
  }

  // extract the token without the "Bearer " prefix
  try {               
    token = authHeader.Substring("Bearer ".Length);
  }
  catch (Exception ex) {
    Console.WriteLine(ex);
  }

  return token;
}
```

`returnErrorResponse` 是一个 helper 方法，用于接收 httpStatusCode 和 WebHeaderCollection、准备响应并将其发送回客户机应用程序。 在将响应发送到客户机应用程序之后，它会完成该请求。

```csharp
private void returnErrorResponse(HttpStatusCode httpStatusCode, WebHeaderCollection headers)
{
  OutgoingWebResponseContext outgoingResponse = WebOperationContext.Current.OutgoingResponse;
  outgoingResponse.StatusCode = httpStatusCode;
  outgoingResponse.Headers.Add(headers);
  HttpContext.Current.Response.Flush();
  HttpContext.Current.Response.SuppressContent = true; //Prevent sending content - only headers will be sent
  HttpContext.Current.ApplicationInstance.CompleteRequest();
}
```

## 从 {{ site.data.keys.product_adj }} 授权服务器获取访问令牌
{: #obtain-access-token-from-mobilefirst-authorization-server}

为认证客户机令牌，我们应通过针对**令牌端点**发出请求来**获取访问令牌作为消息检验器**。
稍后，我们将使用此收到的令牌来传递客户机令牌以进行自省。

```csharp
private string getIntrospectionToken()
{
  string returnVal = null;
  string strResponse = null;

  string Base64Credentials = Convert.ToBase64String(
    System.Text.ASCIIEncoding.ASCII.GetBytes(
      string.Format("{0}:{1}", filterUserName, filterPassword)
    )
  );

  // Prepare Post Data
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("grant_type", "client_credentials");
  postParameters.Add("scope", "authorization.introspect");

  try {
    HttpWebResponse resp = sendRequest(postParameters, "token", "Basic " + Base64Credentials);
    Stream dataStream = resp.GetResponseStream();
    StreamReader reader = new StreamReader(dataStream);
    strResponse = reader.ReadToEnd();

    JToken token = JObject.Parse(strResponse);
    returnVal = (string)token.SelectToken("access_token");
  }
  catch (Exception ex) {
    Debug.WriteLine(ex);
  }

  return returnVal;
}
```

`sendRequest` 方法是一个 helper 方法，负责将请求发送到 {{ site.data.keys.product_adj }} 授权服务器。  
`getIntrospectionToken` 使用它将请求发送到令牌端点，`introspectClientRequest` 方法使用它将请求发送到自省端点。 此方法返回 `HttpWebResponse`，在 `getIntrospectionToken` 方法中用于抽取 access_token，并将其存储为消息检验器令牌。 在 `introspectClientRequest` 方法中，它仅用于返回 MFP 授权服务器响应。

```csharp
private HttpWebResponse sendRequest(Dictionary<string, string> postParameters, string endPoint, string authHeader) {
  string postData = "";
  foreach (string key in postParameters.Keys)
  {
    postData += HttpUtility.UrlEncode(key) + "=" + HttpUtility.UrlEncode(postParameters[key]) + "&";
  }

  HttpWebRequest request = (HttpWebRequest)WebRequest.Create(new System.Uri(azServerBaseURL + endPoint));
  request.Method = "POST";
  request.ContentType = "application/x-www-form-urlencoded";
  request.Headers.Add(HttpRequestHeader.Authorization, authHeader);

  // Attach Post Data
  byte[] data = Encoding.ASCII.GetBytes(postData);
  request.ContentLength = data.Length;
  Stream dataStream = request.GetRequestStream();
  dataStream.Write(data, 0, data.Length);
  dataStream.Close();

  return (HttpWebResponse)request.GetResponse();
}
```

## 使用客户机令牌将请求发送到自省端点
{: #send-request-to-introspection-endpoint-with-client-token }
现在，我们已获得 {{ site.data.keys.product_adj }} 授权服务器的授权，可**验证客户机令牌**内容。 我们将请求发送到**自省端点**，将在先前步骤 (`filterIntrospectionToken`) 中收到的令牌添加到请求头，并在请求的发布数据中添加客户机令牌。  
接下来，我们将在 `postProcess` 方法中检查来自 {{ site.data.keys.product_adj }} 授权服务器的响应。

```csharp
private HttpWebResponse introspectClientRequest(string clientToken) {
  // Prepare the Post Data - add the client token to the postParameters dictionary with the key "token"
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("token", clientToken);

  // send the request using the sendRequest() method and return an HttpWebResponse
  return sendRequest(postParameters, "introspection", "Bearer " + filterIntrospectionToken);
}
```

## 处理后验证
{: #post-process-validation }
在进入 `postProcess` 方法之前，我们想要确保响应状态不是 **401（未经授权）**。  
此时的“401（未经授权）”响应状态指示消息检验器令牌 (`filterIntrospectionToken`) 已到期。 如果响应状态为“401（未经授权）”，那么调用 `getIntrospectionToken` 以获取新的消息检验器令牌，并使用新令牌重新调用 `introspectClientRequest`。

```csharp
if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
{
  filterIntrospectionToken = getIntrospectionToken();
  introspectionResponse = introspectClientRequest(clientToken);
}
```

postProcess 方法的主要目的是检查从 {{ site.data.keys.product_adj }} 授权服务器收到的响应，但是在抽取并检查响应之前，必须**确保响应状态为“200（正常）”**。 如果响应状态为 **409（冲突）**，那么应将此响应转发到客户机应用程序，否则应抛出异常。  
如果响应状态为“200（正常）”，那么初始化 `AzResponse` 类，这是定义为使用当前响应表示 {{ site.data.keys.product_adj }} 授权服务器响应的类。 然后，检查**响应是否为“活动”状态**，并且包含正确的**作用域**：

```csharp
private void postProcess(HttpWebResponse introspectionResponse)
{
  if (introspectionResponse.StatusCode != HttpStatusCode.OK) // Make sure that HttpStatusCode = 200 ok (before checking active==true &  scope)
  {
    if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized) // We have a real problem since we already obtained a new token
    {
      throw new WebFaultException<string>("Authentication did not succeed, Please try again...", HttpStatusCode.BadRequest);
    }
    else if (introspectionResponse.StatusCode == HttpStatusCode.Conflict) // Check Conflict response (409)
    {
      returnErrorResponse(HttpStatusCode.Conflict, introspectionResponse.Headers);
    }
    else
    {
      throw new WebFaultException<string>("Authentication did not succeed, Please try again...", HttpStatusCode.BadRequest);
    }
  } else {                
    AzResponse azResp = new AzResponse(introspectionResponse); // Casting the response to an object
    WebHeaderCollection webHeaderCollection = new WebHeaderCollection();

    if (!azResp.isActive)
    {                    
      webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer error=\"invalid_token\"");
      returnErrorResponse(HttpStatusCode.Unauthorized, webHeaderCollection);
    }
    else if (!azResp.scope.Contains(scope))
    {
      webHeaderCollection.Add(HttpResponseHeader.WwwAuthenticate, "Bearer error=\"insufficient_scope\", scope=\"" + scope + "\"");
      returnErrorResponse(HttpStatusCode.Forbidden, webHeaderCollection);
    }               
  }           
}
```

## 样本应用程序
{: #sample-application }
[下载 .NET 消息检验器样本](https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80)。

### 样本用法
{: #sample-usage }
1. 使用 Visual Studio 以服务形式打开、构建和运行样本（以管理员身份运行 Visual Studio）。
2. 确保[更新保密客户机](../#confidential-client)和 {{ site.data.keys.mf_console }} 中的密钥值。
3. 部署安全性检查：**[UserLogin](../../user-authentication/security-check/)** 或 **[PinCodeAttempts](../../credentials-validation/security-check/)**。
4. 注册匹配应用程序。
5. 将 `accessRestricted` 作用域映射到安全性检查。
6. 更新客户机应用程序以针对 servlet URL 生成 `WLResourceRequest`。
