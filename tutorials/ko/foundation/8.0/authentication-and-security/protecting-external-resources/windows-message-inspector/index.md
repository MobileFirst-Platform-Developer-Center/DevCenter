---
layout: tutorial
title: Windows .NET 메시지 검사기
breadcrumb_title: Windows .NET 메시지 검사기
relevantTo: [android,ios,windows,javascript]
weight: 4
다운로드:
  - 이름: 샘플 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 학습서는 범위(`accessRestricted`)를 사용하여 단순 Windows .NET 자원, `GetBalanceService`를 보호하는 방법을 보여줍니다. 샘플에서는 DotNetTokenValidator라는 콘솔 애플리케이션으로 자체 호스트되는 서비스를 보호합니다.

먼저 `GetBalanceService` 자원에 대한 수신 요청을 제어하도록 도울 **메시지 검사기**를 정의합니다.
이 메시지 검사기를 사용하여 수신 요청을 검사하고 **{{ site.data.keys.product_adj }} 권한 부여 서버**에서 요구하는 모든 필수 헤더를 제공하는지를 유효성 검증합니다.

**전제조건:
**

* [외부 자원을 인증하기 위해 {{ site.data.keys.mf_server }} 사용](../) 학습서를 읽으십시오.
* [{{ site.data.keys.product_adj }} 보안 프레임워크](../../)를 이해하십시오.

#### 다음으로 이동:
{: #jump-to }
* [WCF 웹 HTTP 서비스 작성 및 구성](#create-and-configure-wcf-web-http-service)
* [메시지 검사기 정의](#define-a-message-inspector)
* [메시지 검사기 구현](#message-inspector-implementation)
    * [사전 프로세스 유효성 검증](#pre-process-validation)
    * [{{ site.data.keys.product_adj }} 권한 부여 서버에서 액세스 토큰 얻기](#obtain-access-token-from-mobilefirst-authorization-server)
    * [클라이언트 토큰과 함께 자체 점검 엔드포인트에 요청 전송](#send-request-to-introspection-endpoint-with-client-token)
    * [사후 프로세스 유효성 검증](#post-process-validation)

## WCF 웹 HTTP 서비스 작성 및 구성
{: #create-and-configure-wcf-web-http-service }
먼저 **WCF 서비스**를 작성하고 이를 `GetBalanceService`라고 이름 지정합니다. 이는 나중에 **메시지 검사기**로 보호할 서비스입니다.
이 예제에서는 서비스에 대한 호스팅 프로그램으로 콘솔 애플리케이션을 사용하고 있습니다.

다음은 `getBalance`(보호된 자원)의 코드입니다.

```csharp
public class GetBalanceService : IGetBalanceService {
  public string getBalance()
  {
    Console.WriteLine("getBalance()");
    return "19938.80";
  }
}
```

`ServiceContract`도 정의해야 합니다.

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

이제 서비스가 준비가 되었으며 호스트 애플리케이션에서 어떻게 사용할지를 구성할 수 있습니다.이는 다음과 같이 App.config 파일에서 수행됩니다.

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
마지막으로 호스팅 프로그램 `Main` 메소드에서 이를 실행해야 합니다.

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

> WCF REST 서비스에 대한 자세한 정보는 [기본 WCF 웹 HTTP 서비스 작성](https://msdn.microsoft.com/en-us/library/bb412178(v=vs.100)을 참조하십시오.

## 메시지 검사기 정의
{: #define-a-message-inspector }
유효성 검증 프로세스를 시작하기 전에 자원(서비스 엔드포인트)을 보호하기 위해 사용할 **메시지 검사기**를 작성하고 정의해야 합니다.
메시지 검사기는 메시지가 전송되기 전 또는 수신된 후 메시지를 검사하고 변경하기 위해 서비스에서 사용될 수 있는 확장성 오브젝트입니다. 서비스 메시지 검사기는 `IDispatchMessageInspector` 인터페이스를 구현해야 합니다.

```csharp
public class MyInspector : IDispatchMessageInspector
```

서비스 메시지 검사기는 두 개의 `IDispatchMessageInspector` 메소드인 `AfterReceiveRequest` 및 `BeforeSendReply`를 구현해야 합니다.

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

메시지 검사기를 작성한 후에는 특정 엔드포인트를 보호하도록 정의되어야 합니다. 이는 behavior를 사용하여 수행됩니다.  **behavior**는 기본 구성을 변경하거나 확장기능(메시지 검사기 등)을 추가하여 서비스 런타임 모델의 동작을 변경하는 클래스입니다. 두 개의 클래스를 사용하여 수행되는 데 하나는 애플리케이션 엔드포인트를 보호하기 위해 메시지 검사기를 구성하는 클래스이고 다른 하나는 이 behavior 클래스 인스턴스와 유형을 리턴하기 위한 클래스입니다.

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

`App.config` 파일에서 `behaviorExtension`를 정의하고 방금 작성한 behavior 클래스에 이를 첨부합니다.

```xml
<extensions>
  <behaviorExtensions>
    <add name="extBehavior" type="DotNetTokenValidator.Inspector.MyCustomBehaviorExtension, DotNetTokenValidator"/>
  </behaviorExtensions>
</extensions>
```

그런 다음 이 behaviorExtension을 서비스에 구성된 webBehavior 요소에 엔드포인트 동작으로 추가합니다.

```xml
<behavior name="webBehavior">
  <webHttp />
  <extBehavior />
</behavior>
```

## 메시지 검사기 구현
{: #message-inspector-implementation}

먼저 메시지 검사기에 클래스 멤버로 일부 상수를 정의합니다. 즉, {{ site.data.keys.mf_server }} URL, 기밀 클라이언트 신임 정보 및 `scope`를 정의하며 이는 서비스를 보호하기 위해 사용됩니다. 또한 {{ site.data.keys.product_adj }} 권한 서버에서 수신한 토큰을 유지하기 위해 정적 변수를 정의하여 모든 사용자가 이용할 수 있게 할 수 있습니다.

```csharp
private const string azServerBaseURL = "http://YOUR-SERVER-URL:9080/mfp/api/az/v1/";
private const string scope = "accessRestricted";
private static string filterIntrospectionToken = null;
private const string filterUserName = "USERNAME"; // Confidential Client Username
private const string filterPassword = "PASSWORD";  // Confidential Client Secret
```

그 다음 `validateRequest` 메소드를 작성하며 이 메소드는 메시지 검사기에서 구현할 유효성 검증 프로세스의 시작점이 됩니다. 그리고 나서 앞에서 언급한 `AfterReceiveRequest` 메소드 내부에 이 메소드에 대한 호출을 추가합니다.

```csharp
public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext) {
  validateRequest(request);
  return null;
}
```

`validateRequest` 내부에는 구현할 3개의 단계가 있습니다.

1. **사전 프로세스 유효성 검증** - 요청에 **권한 부여 헤더**가 있는지, 만약 있다면 **"Bearer"** 접두부로 시작하는지를 확인합니다.
2. {{ site.data.keys.product_adj }} 권한 부여 서버에서 **토큰 가져오기** - 이 토큰은 {{ site.data.keys.product_adj }} 권한 부여 서버에 대해 클라이언트의 토큰을 인증하는 데 사용됩니다.
3. **사후 프로세스 유효성 검증** - **충돌**을 확인하고 요청이 올바른 **범위**를 전송했는지 및 요청이 **활성**인지를 확인합니다.

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

## 사전 프로세스 유효성 검증
{: #pre-process-validation }
사전 프로세스 유효성 검증은 getClientTokenFromHeader() 메소드의 일부로 수행됩니다.
이 프로세스는 2개의 검사를 기반으로 합니다.

1. 요청의 권한 부여 헤더가 비어 있지 않은지 검사합니다.
2. 비어 있지 않으면 권한 부여 헤더가 "Bearer" 접두부로 시작하는지 확인합니다.

두 경우 모두 **권한 없는 응답 상태**(401)로 응답해야 하고 **WWW-Authenticate:Bearer** 헤더를 추가해야 합니다.  
권한 부여 헤더를 유효성 검증한 후 이 메소드는 클라이언트 애플리케이션에서 수신한 토큰을 리턴합니다.

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

`returnErrorResponse`는 httpStatusCode 및 WebHeaderCollection을 수신하고 응답을 준비하며 클라이언트 애플리케이션에 이를 다시 전송하는 헬퍼 메소드입니다. 응답을 클라이언트 애플리케이션에 전송한 후 요청을 완료합니다.

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

## {{ site.data.keys.product_adj }} 권한 부여 서버에서 액세스 토큰 얻기
{: #obtain-access-token-from-mobilefirst-authorization-server}

클라이언트 토큰을 인증하기 위해서는 **토큰 엔드포인트**에 대한 요청을 작성하여 **메시지 검사기로서 액세스 토큰을 획득**해야 합니다.
나중에 수신된 이 토큰을 사용하여 자체 점검을 위해 클라이언트 토큰을 전달합니다.

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

`sendRequest` 메소드는 요청을 {{ site.data.keys.product_adj }} 권한 서버로 전송하는 것을 책임지는 헬퍼 메소드입니다.  
토큰 엔드포인트로 요청을 전송하기 위해 `getIntrospectionToken`에서, 그리고 자체 점검 엔드포인트에 요청을 전송하기 위해 `introspectClientRequest` 메소드에서 사용됩니다. 이 메소드는 `HttpWebResponse`를 리턴하며, 이는 액세스 토큰을 추출하고 메시지 검사기 토큰으로 저장하기 위해 `getIntrospectionToken`에서 사용됩니다. `introspectClientRequest` 메소드에서는 MFP 인증 서버 응답을 리턴하기 위해서만 사용됩니다.

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

## 클라이언트 토큰과 함께 자체 점검 엔드포인트에 요청 전송
{: #send-request-to-introspection-endpoint-with-client-token }
이제 {{ site.data.keys.product_adj }} 권한 서버에 의해 권한이 부여되었으므로 **클라이언트 토큰 컨텐츠를 유효성 검증**할 수 있습니다.  이전 단계에서 수신한 토큰(`filterIntrospectionToken`)을 요청의 포스트 데이터에 있는 클라이언트 토큰 및 요청 헤더에 추가하여 요청을 **자체 점검 엔드포인트**로 전송할 수 있습니다.   
그 다음 `postProcess` 메소드에서 {{ site.data.keys.product_adj }} 권한 서버로부터 응답을 검사합니다.

```csharp
private HttpWebResponse introspectClientRequest(string clientToken) {
  // Prepare the Post Data - add the client token to the postParameters dictionary with the key "token"
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("token", clientToken);

  // send the request using the sendRequest() method and return an HttpWebResponse
  return sendRequest(postParameters, "introspection", "Bearer " + filterIntrospectionToken);
}
```

## 사후 프로세스 유효성 검증
{: #post-process-validation }
`postProcess` 메소드를 진행하기 전에 응답 상태가 **401(권한 없음)**이 아닌지 확인하려고 합니다.  
이 위치에서 401(권한 없음) 응답 상태는 메시지 검사기 토큰(`filterIntrospectionToken`)이 만료되었음을 표시합니다.만약 응답 상태가 401(권한 없음)이면 `getIntrospectionToken`을 호출하여 메시지 검사기에 대해 새 토큰을 가져오고 새 토큰과 함께 `introspectClientRequest`를 다시 호출합니다.

```csharp
if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
{
  filterIntrospectionToken = getIntrospectionToken();
  introspectionResponse = introspectClientRequest(clientToken);
}
```

postProcess 메소드의 기본 목적은 {{ site.data.keys.product_adj }} 권한 부여 서버에서 수신한 응답을 검사하는 것이지만 응답을 추출하고 검사하기 전에 **응답 상태가 200(OK)인지 확인**해야 합니다. 응답 상태가 **409(충돌)**이면 이 응답을 클라이언트 애플리케이션으로 전달해야 합니다. 그렇지 않으면 예외를 발생시켜야 합니다.   
응답 상태가 200(OK)이면 `AzResponse` 클래스를 인스턴스화하는데 이는 현재 응답으로 {{ site.data.keys.product_adj }} 권한 부여 서버 응답을 나타내기 위해 정의된 클래스입니다. **응답이 활성**인지 그리고 올바른 **범위**가 포함되어 있는지 확인합니다.

```csharp
private void postProcess(HttpWebResponse introspectionResponse)
{
  if (introspectionResponse.StatusCode != HttpStatusCode.OK) // Make sure that HttpStatusCode = 200 ok (before checking active==true & scope)
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
  }
  else
  {                
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

## 샘플 애플리케이션
{: #sample-application }
[.NET 메시지 검사기 샘플을 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80)하십시오.

### 샘플 사용법
{: #sample-usage }
1. Visual Studio를 사용하여 서비스로 샘플을 열고, 빌드하고 실행하십시오(관리자로 Visual Studio를 실행).
2. [기밀 클라이언트](../#confidential-client) 및 본인확인정보 값을 {{ site.data.keys.mf_console }}에서 업데이트하십시오.
3. **[UserLogin](../../user-authentication/security-check/)** 또는 **[PinCodeAttempts](../../credentials-validation/security-check/)** 보안 검사 중 하나를 배치하십시오.
4. 일치하는 애플리케이션을 등록하십시오.
5. `accessRestricted` 범위를 보안 검사에 맵핑하십시오.
6. 서블릿 URL에 대한 `WLResourceRequest`를 작성하기 위해 클라이언트 애플리케이션을 업데이트하십시오.
