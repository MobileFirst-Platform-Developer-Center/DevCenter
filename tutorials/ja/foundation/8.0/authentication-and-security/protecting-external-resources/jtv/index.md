---
layout: tutorial
title: Java トークン・バリデーター
breadcrumb_title: Java Token Validator
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} は、外部リソースにセキュリティー機能を適用するための Java ライブラリーを提供しています。  
Java ライブラリーは、JAR ファイル (**mfp-java-token-validator-8.0.0.jar**) として提供されます。

このチュートリアルでは、スコープ (`accessRestricted`) を使用して、単純な Java サーブレット `GetBalance` を保護する方法を示します。

**前提条件:**

* [{{ site.data.keys.mf_server }} を使用した外部リソースの認証](../)チュートリアルをお読みください。
* [{{ site.data.keys.product_adj }} Foundation セキュリティー・フレームワーク](../../)の知識が必要です。

![フロー](JTV_flow.jpg)

## .jar ファイル依存関係の追加
{: #adding-the-jar-file-dependency }
**mfp-java-token-validator-8.0.0.jar** ファイルは、**maven dependency** として使用できます。

```xml
<dependency>
  <groupId>com.ibm.mfp</groupId>
  <artifactId>mfp-java-token-validator</artifactId>
  <version>8.0.0</version>
</dependency>
```

## TokenValidationManager のインスタンス化
{: #instantiating-the-tokenvalidationmanager }
トークンの検証を可能にするために、`TokenValidationManager` をインスタンス化します。

```java
TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret);
```

- `authorizationURI`: 許可サーバーの URI。通常は、{{ site.data.keys.mf_server }} です。 例えば、**http://localhost:9080/mfp/api** です。
- `clientId`: {{ site.data.keys.mf_console }} で構成した機密クライアント ID。
- `clientSecret`: {{ site.data.keys.mf_console }} で構成した機密クライアント秘密鍵。

> このライブラリーは、許可サーバーのイントロスペクション・エンドポイントとの対話をカプセル化および簡素化する API を公開します。 詳細な API リファレンスについては、[{{ site.data.keys.product_adj }} Java トークン・バリデーター API リファレンス](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_mfpf_java_token_validator_api.html?view=kc)を参照してください。

## 資格情報の検証
{: #validating-the-credentials }
`validate` API メソッドは、許可ヘッダーの検証を許可サーバーに依頼します。

```java
public TokenValidationResult validate(java.lang.String authorizationHeader, java.lang.String expectedScope);
```

- `authorizationHeader`: `Authorization` HTTP ヘッダーのコンテンツ、すなわち、アクセス・トークンです。 例えば、`HttpServletRequest` (`httpServletRequest.getHeader("Authorization")`) から取得されます。
- `expectedScope`: トークンを検証するための基準となるスコープ。例えば、`accessRestricted` です。

結果の `TokenValidationResult` オブジェクトを照会して、エラーまたは有効なイントロスペクション・データを確認できます。

```java
TokenValidationResult tokenValidationRes = validator.validate(authCredentials, expectedScope);
if (tokenValidationRes.getAuthenticationError() != null) {
    // Error
    AuthenticationError error = tokenValidationRes.getAuthenticationError();
    httpServletResponse.setStatus(error.getStatus());
    httpServletResponse.setHeader("WWW-Authenticate", error.getAuthenticateHeader());
} else if (tokenValidationRes.getIntrospectionData() != null) {
    // Success logic here
}
```                    

## イントロスペクション・データ
{: #introspection-data }
`getIntrospectionData()` によって返される `TokenIntrospectionData` オブジェクトは、現在のアクティブ・ユーザーのユーザー名など、クライアントに関する情報を提供します。

```java
httpServletRequest.setAttribute("introspection-data", tokenValidationRes.getIntrospectionData());
```

```java
TokenIntrospectionData introspectionData = (TokenIntrospectionData) request.getAttribute("introspection-data");
String username = introspectionData.getUsername();
```

## キャッシュ
{: #cache }
`TokenValidationManager` クラスには、トークンおよびイントロスペクション・データをキャッシュに入れる内部キャッシュが付いてきます。 キャッシュの目的は、同じヘッダーを使用して要求が発行された場合に、許可サーバーに対して行われるトークンの*イントロスペクション* の量を減らすことです。

デフォルトのキャッシュ・サイズは **50000 項目**です。 この容量に達すると、一番古いトークンから削除されます。  

`TokenValidationManager` のコンストラクターは、保管する `cacheSize` (イントロスペクション・データ項目の数) も受け入れます。

```java
public TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret, long cacheSize);
```

## 単純な Java サーブレットの保護
{: #protecting-a-simple-java-servlet }
1. ハードコーディングされた値を返す、`GetBalance` という単純な Java サーブレットを作成します。

   ```java
   @WebServlet("/GetBalance")
   public class GetBalance extends HttpServlet {
    	private static final long serialVersionUID = 1L;

    	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		//Return hardcoded value
    		response.getWriter().append("17364.9");
    	}

   }
   ```

2. `JTVFilter` という `javax.servlet.Filter` 実装を作成します。これは、指定されたスコープの許可ヘッダーを検証します。

   ```java
   public class JTVFilter implements Filter {

    	public static final String AUTH_HEADER = "Authorization";
    	private static final String AUTHSERVER_URI = "http://localhost:9080/mfp/api"; //Set here your authorization server URI
    	private static final String CLIENT_ID = "jtv"; //Set here your confidential client ID
    	private static final String CLIENT_SECRET = "jtv"; //Set here your confidential client SECRET

    	private TokenValidationManager validator;
    	private FilterConfig filterConfig = null;

    	@Override
    	public void init(FilterConfig filterConfig) throws ServletException {
    		URI uri = null;
    		try {
    			uri = new URI(AUTHSERVER_URI);
    			validator = new TokenValidationManager(uri, CLIENT_ID, CLIENT_SECRET);
    			this.filterConfig = filterConfig;
    		} catch (Exception e1) {
    			System.out.println("Error reading introspection URI");
    		}
    	}

    	@Override
    	public void doFilter(ServletRequest req, ServletResponse res, FilterChain filterChain) throws IOException, ServletException {
    		String expectedScope = filterConfig.getInitParameter("scope");
    		HttpServletRequest httpServletRequest = (HttpServletRequest) req;
    		HttpServletResponse httpServletResponse = (HttpServletResponse) res;

    		String authCredentials = httpServletRequest.getHeader(AUTH_HEADER);

    		try {
    			TokenValidationResult tokenValidationRes = validator.validate(authCredentials, expectedScope);
    			if (tokenValidationRes.getAuthenticationError() != null) {
    				// Error
    				AuthenticationError error = tokenValidationRes.getAuthenticationError();
    				httpServletResponse.setStatus(error.getStatus());
    				httpServletResponse.setHeader("WWW-Authenticate", error.getAuthenticateHeader());
    			} else if (tokenValidationRes.getIntrospectionData() != null) {
    				// Success
    				httpServletRequest.setAttribute("introspection-data", tokenValidationRes.getIntrospectionData());
    				filterChain.doFilter(req, res);
    			}
    		} catch (TokenValidationException e) {
    			httpServletResponse.setStatus(500);
    		}
    	}

   }
   ```

3. サーブレットの **web.xml** ファイル内に `JTVFilter` のインスタンスを宣言し、**scope** `accessRestricted` をパラメーターとして渡します。

   ```xml
   <filter>
      <filter-name>accessRestricted</filter-name>
      <filter-class>com.sample.JTVFilter</filter-class>
      <init-param>
        <param-name>scope</param-name>
        <param-value>accessRestricted</param-value>
      </init-param>
   </filter>
   ```

   サーブレットをこのフィルターで保護します。

   ```xml
   <filter-mapping>
      <filter-name>accessRestricted</filter-name>
      <url-pattern>/GetBalance</url-pattern>
   </filter-mapping>
   ```

## サンプル・アプリケーション
{: #sample-application }

サポートされるアプリケーション・サーバー (Tomcat、WebSphere Application Server フル・プロファイル、および WebSphere Application Server Liberty プロファイル) にプロジェクトをデプロイできます。  
[単純な Java サーブレットをダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80)します。

### サンプルの使用法
{: #sample-usage }
1. {{ site.data.keys.mf_console }} で、必ず[機密クライアントと秘密鍵の値を更新](../#confidential-client)してください。
2. **[UserLogin](../../user-authentication/security-check/)** または **[PinCodeAttempts](../../credentials-validation/security-check/)** のいずれかのセキュリティー検査をデプロイします。
3. 一致するアプリケーションを登録します。
4. `accessRestricted` スコープをセキュリティー検査にマップします。
5. クライアント・アプリケーションを更新して、サーブレット URL に `WLResourceRequest` を発行します。
