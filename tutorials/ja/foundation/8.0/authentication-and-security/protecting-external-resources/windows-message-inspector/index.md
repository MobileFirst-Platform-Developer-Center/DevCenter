---
layout: tutorial
title: Windows .NET メッセージ・インスペクター
breadcrumb_title: Windows .NET メッセージ・インスペクター
relevantTo: [android,ios,windows,javascript]
weight: 4
downloads:
  - name: サンプルのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、スコープ (`accessRestricted`) を使用して、単純な Windows .NET リソース `GetBalanceService` を保護する方法を示します。
このサンプルでは、DotNetTokenValidator というコンソール・アプリケーションによってセルフホストされるサービスを保護します。

まず、`GetBalanceService` リソースへの着信要求を制御するために使用する**メッセージ・インスペクター**を定義します。
このメッセージ・インスペクターを使用して着信要求を検査し、着信要求が **{{ site.data.keys.product_adj }} 許可サーバー**によって必要とされるすべての必要なヘッダーを提供しているか検証します。

**前提条件:**

* 必ず、[{{ site.data.keys.mf_server }} を使用した外部リソースの認証](../)チュートリアルをお読みください。
* [{{ site.data.keys.product_adj }} セキュリティー・フレームワーク](../../)の知識が必要です。

#### ジャンプ先:
{: #jump-to }
* [WCF Web HTTP サービスの作成と構成](#create-and-configure-wcf-web-http-service)
* [メッセージ・インスペクターの定義](#define-a-message-inspector)
* [メッセージ・インスペクターの実装](#message-inspector-implementation)
    * [プリプロセス検証](#pre-process-validation)
    * [{{ site.data.keys.product_adj }} 許可サーバーからのアクセス・トークンの取得](#obtain-access-token-from-mobilefirst-authorization-server)
    * [クライアント・トークンが付いた要求のイントロスペクション・エンドポイントへの送信](#send-request-to-introspection-endpoint-with-client-token)
    * [ポストプロセス検証](#post-process-validation)

## WCF Web HTTP サービスの作成と構成
{: #create-and-configure-wcf-web-http-service }
最初に、**WCF サービス**を作成し、`GetBalanceService` と名前を付けます。このサービスを後から**メッセージ・インスペクター**を使用して保護します。
このサンプルでは、サービスのホスティング・プログラムとしてコンソール・アプリケーションを使用します。

`getBalance` (保護リソース) のコードは以下のとおりです。

```csharp
public class GetBalanceService : IGetBalanceService {
  public string getBalance()
  {
    Console.WriteLine("getBalance()");
    return "19938.80";
  }
}
```

`ServiceContract` も定義する必要があります。

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

これでサービスの準備ができたので、ホスト・アプリケーションによってこのサービスが使用される方法を構成できます。これは、App.config ファイル内で以下のように行います。

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
最後に、これをホスティング・プログラム `Main` メソッドから実行する必要があります。

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

> WCF REST サービスについて詳しくは、[方法 : 基本的な WCF Web HTTP サービスを作成する](https://msdn.microsoft.com/ja-jp/library/bb412178(v=vs.100).aspx を参照してください。

## メッセージ・インスペクターの定義
{: #define-a-message-inspector}
検証プロセスの詳細に進む前に、リソース (サービス・エンドポイント) を保護するために使用する**メッセージ・インスペクター**を作成し、定義する必要があります。
メッセージ・インスペクターは、メッセージの受信後または送信前にメッセージを検査および変更するために、サービス内で使用できる拡張性オブジェクトです。サービス・メッセージ・インスペクターは、`IDispatchMessageInspector` インターフェースを実装する必要があります。

```csharp
public class MyInspector : IDispatchMessageInspector
```

サービス・メッセージ・インスペクターはすべて、`IDispatchMessageInspector` の 2 つのメソッド、`AfterReceiveRequest` と `BeforeSendReply` を実装する必要があります。

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

メッセージ・インスペクターを作成したら、特定のエンドポイントを保護するようにそれを定義する必要があります。これは、behavior を使用して行います。**behavior** は、デフォルト構成を変更するか、拡張 (メッセージ・インスペクターなど) を追加することで、サービス・モデル・ランタイムの振る舞いを変更するクラスです。
これは、2 つのクラスを使用して行います。1 つは、アプリケーション・エンドポイントを保護するメッセージ・インスペクターを構成するクラスで、もう 1 つは、この behavior クラス・インスタンスと型を返すクラスです。

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

`App.config` ファイル内で、`behaviorExtension` を定義し、これを今作成した behavior クラスに付加します。

```xml
<extensions>
  <behaviorExtensions>
    <add name="extBehavior" type="DotNetTokenValidator.Inspector.MyCustomBehaviorExtension, DotNetTokenValidator"/>
  </behaviorExtensions>
</extensions>
```

次に、この behaviorExtension を webBehavior エレメントに追加します。このエレメントは、サービス内でエンドポイント behavior として構成されています。

```xml
<behavior name="webBehavior">
  <webHttp />
  <extBehavior />
</behavior>
```

## メッセージ・インスペクターの実装
{: #message-inspector-implementation}

まず、メッセージ・インスペクター内にクラス・メンバーとしていくつかの定数を定義します。それらは、{{ site.data.keys.mf_server }} URL、機密クライアントの資格情報、およびサービスを保護するために使用する `scope` です。また、{{ site.data.keys.product_adj }} 許可サーバーから受け取ったトークンを保持するための静的変数を定義することもできます。そうすることで、すべてのユーザーがそれを使用できます。

```csharp
private const string azServerBaseURL = "http://YOUR-SERVER-URL:9080/mfp/api/az/v1/";
private const string scope = "accessRestricted";
private static string filterIntrospectionToken = null;
private const string filterUserName = "USERNAME"; // Confidential Client Username
private const string filterPassword = "PASSWORD";  // Confidential Client Secret
```

次に、`validateRequest` メソッドを作成します。これが、メッセージ・インスペクター内に実装する検証プロセスの開始ポイントとなります。その後、このメソッドへの呼び出しを、前述した `AfterReceiveRequest` メソッド内に追加します。

```csharp
public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext) {
  validateRequest(request);
  return null;
}
```

`validateRequest` 内には、3 つのメイン・ステップを実装します。

1. **プリプロセス検証** - 要求に**許可ヘッダー**が含まれているかどうかをチェックし、含まれている場合は、ヘッダーが **"Bearer"** プレフィックスで始まっているかどうかをチェックします。
2. **トークンの取得** ({{ site.data.keys.product_adj }} 許可サーバーから) - このトークンを使用して、{{ site.data.keys.product_adj }} 許可サーバーに対するクライアントのトークンの認証が行われます。
3. **ポストプロセス検証** - **競合**がないかどうかをチェックし、要求が正しい**スコープ**を送信したことを検証し、要求が**アクティブ**であるかチェックします。

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

## プリプロセス検証
{: #pre-process-validation }
プリプロセス検証は、getClientTokenFromHeader() メソッドの一部として実行されます。
このプロセスのベースは 2 つのチェックになります。

1. 要求の許可ヘッダーが空でないことをチェックします。
2. 空でない場合に、許可ヘッダーが "Bearer" プレフィックスで始まることをチェックします。

いずれのケースも、**Unauthorized 応答ステータス** (401) で応答し、**WWW-Authenticate:Bearer** ヘッダーを追加する必要があります。  
許可ヘッダーの検証が終わると、このメソッドは、クライアント・アプリケーションから受け取ったトークンを返します。

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

`returnErrorResponse` は、httpStatusCode と WebHeaderCollection を受け取り、応答を作成してから、それをクライアント・アプリケーションに返信するヘルパー・メソッドです。応答をクライアント・アプリケーションに送信すると、要求は完了します。

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

## {{ site.data.keys.product_adj }} 許可サーバーからのアクセス・トークンの取得
{: #obtain-access-token-from-mobilefirst-authorization-server}

クライアント・トークンを認証するためには、**トークン・エンドポイント**への要求を発行することで、**メッセージ・インスペクターとしてアクセス・トークンを取得**する必要があります。
後で、この受け取ったトークンを使用して、クライアント・トークンをイントロスペクションのために渡します。

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

`sendRequest` メソッドは、{{ site.data.keys.product_adj }} 許可サーバーへの要求の送信を担当するヘルパー・メソッドです。  
`getIntrospectionToken` は要求をトークン・エンドポイントに送信するためにこれを使用し、`introspectClientRequest` メソッドはイントロスペクション・エンドポイントに要求を送信するためにこれを使用します。このメソッドが返す `HttpWebResponse` を `getIntrospectionToken` メソッド内で使用して、そこから access_token を抽出したり、抽出したそのトークンをメッセージ・インスペクター・トークンとして保管したりします。`introspectClientRequest` メソッド内では、単純に MFP 許可サーバー応答を返すために使用されます。

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

## クライアント・トークンが付いた要求のイントロスペクション・エンドポイントへの送信
{: #send-request-to-introspection-endpoint-with-client-token }
これで、{{ site.data.keys.product_adj }} 許可サーバーによって認証されたので、**クライアント・トークンのコンテンツを有効にする**ことができます。そこで、要求を**イントロスペクション・エンドポイント**に送信します。その際、前のステップ (`filterIntrospectionToken`) で受け取ったトークンを要求ヘッダーに追加するとともに、クライアント・トークンを要求のポスト・データに追加します。  
次に、{{ site.data.keys.product_adj }} 許可サーバーからの応答を `postProcess` メソッド内で検査します。

```csharp
private HttpWebResponse introspectClientRequest(string clientToken) {
  // Prepare the Post Data - add the client token to the postParameters dictionary with the key "token"
  Dictionary<string, string> postParameters = new Dictionary<string, string> { };
  postParameters.Add("token", clientToken);

  // send the request using the sendRequest() method and return an HttpWebResponse
  return sendRequest(postParameters, "introspection", "Bearer " + filterIntrospectionToken);
}
```

## ポストプロセス検証
{: #post-process-validation }
`postProcess` メソッドに進む前に、応答ステータスが **401 (Unauthorized)** でないことを確認する必要があります。  
この時点での 401 (Unauthorized) 応答ステータスは、メッセージ・インスペクター・トークン (`filterIntrospectionToken`) の有効期限が切れたことを示しています。応答ステータスが 401 (Unauthorized) である場合、`getIntrospectionToken` を呼び出してメッセージ・インスペクター用の新しいトークンを取得し、新しいトークンを使用して再度 `introspectClientRequest` を呼び出します。

```csharp
if (introspectionResponse.StatusCode == HttpStatusCode.Unauthorized)
{
  filterIntrospectionToken = getIntrospectionToken();
  introspectionResponse = introspectClientRequest(clientToken);
}
```

postProcess メソッドの主な目的は、{{ site.data.keys.product_adj }} 許可サーバーから受け取った応答を調べることですが、応答を抽出してチェックする前に、**応答ステータスが 200 (OK) であることを確認**しなければなりません。応答ステータスが **409 (Conflict)** の場合は、この応答をクライアント・アプリケーションに転送する必要があり、それ以外の場合には例外をスローする必要があります。  
応答ステータスが 200 (OK) であれば、現在の応答で `AzResponse` クラス ({{ site.data.keys.product_adj }} 許可サーバーの応答を表すために定義されるクラス) を初期設定します。その後、**応答がアクティブ**であること、さらに、応答に正しい**スコープ**が組み込まれていることを確認します。

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

## サンプル・アプリケーション
{: #sample-application }
[.NET メッセージ・インスペクター・サンプルをダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/DotNetTokenValidator/tree/release80)します。

### サンプルの使用法
{: #sample-usage }
1. Visual Studio を使用して、サンプルを開き、サービスとしてビルドし、実行します (Visual Studio は管理者として実行してください)。
2. {{ site.data.keys.mf_console }} で、必ず[機密クライアントと秘密鍵の値を更新](../#confidential-client)してください。
3. **[UserLogin](../../user-authentication/security-check/)** または **[PinCodeAttempts](../../credentials-validation/security-check/)** のいずれかのセキュリティー検査をデプロイします。
4. 一致するアプリケーションを登録します。
5. `accessRestricted` スコープをセキュリティー検査にマップします。
6. クライアント・アプリケーションを更新して、サーブレット URL に `WLResourceRequest` を発行します。
