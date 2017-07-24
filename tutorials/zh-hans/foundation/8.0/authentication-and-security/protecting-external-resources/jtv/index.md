---
layout: tutorial
title: Java 令牌验证程序
breadcrumb_title: Java 令牌验证程序
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: 下载样本
    url: https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 提供 Java 库以对外部资源实施安全功能。  
Java 库是作为 JAR 文件 (**mfp-java-token-validator-8.0.0.jar**) 提供的。

本教程显示如何使用作用域 (`accessRestricted`) 来保护简单 Java Servlet `GetBalance`。

**先决条件：**

* 阅读[使用 {{ site.data.keys.mf_server }} 来认证外部资源](../)教程。
* 了解 [{{ site.data.keys.product_adj }} Foundation 安全框架](../../)。

![流程](JTV_flow.jpg)

## 添加 .jar 文件依赖关系
{: #adding-the-jar-file-dependency }
**mfp-java-token-validator-8.0.0.jar** 文件可用作 **maven 依赖关系**：

```xml
<dependency>
  <groupId>com.ibm.mfp</groupId>
  <artifactId>mfp-java-token-validator</artifactId>
  <version>8.0.0</version>
</dependency>
```

## 实例化 TokenValidationManager
{: #instantiating-the-tokenvalidationmanager }
为了能够验证令牌，请实例化 `TokenValidationManager`。

```java
TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret);
```

- `authorizationURI`：授权服务器的 URI，通常为 {{ site.data.keys.mf_server }}。例如，**http://localhost:9080/mfp/api**。
- `clientId`：在 {{ site.data.keys.mf_console }} 中配置的保密客户机标识。
- `clientSecret`：在 {{ site.data.keys.mf_console }} 中配置的保密客户机密钥。

> 该库会公开一个 API，用于封装并简化与授权服务器的自省端点的交互。有关详细 API 参考，[请参阅 {{ site.data.keys.product_adj }} Java 令牌验证程序 API 参考](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_mfpf_java_token_validator_api.html?view=kc)。
## 验证凭证
{: #validating-the-credentials }
`validate` API 方法会要求授权服务器验证授权头：

```java
public TokenValidationResult validate(java.lang.String authorizationHeader, java.lang.String expectedScope);
```

- `authorizationHeader`：`Authorization` HTTP 头的内容，这是访问令牌。例如，可以从 `HttpServletRequest` (`httpServletRequest.getHeader("Authorization")`) 中获取。
- `expectedScope`：用于验证令牌的作用域，例如，`accessRestricted`。

您可以查询生成的 `TokenValidationResult` 对象以查找错误或有效的自省数据：

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

## 自省数据
{: #introspection-data }
`getIntrospectionData()` 返回的 `TokenIntrospectionData` 对象为您提供有关客户机的一些信息，例如，当前活动用户的用户名：

```java
httpServletRequest.setAttribute("introspection-data", tokenValidationRes.getIntrospectionData());
```

```java
TokenIntrospectionData introspectionData = (TokenIntrospectionData) request.getAttribute("introspection-data");
String username = introspectionData.getUsername();
```

## 高速缓存
{: #cache }
`TokenValidationManager` 类随附一个内部高速缓存，用于高速缓存令牌和自省数据。高速缓存的目的是减少针对授权服务器完成的令牌*自省*总量（如果使用相同的头发出请求）。

缺省高速缓存大小为 **50000 个项**。在到达此容量后，将除去最旧的令牌。  

`TokenValidationManager` 的构造方法也可接受要存储的 `cacheSize`（自省数据项的数量）：

```java
public TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret, long cacheSize);
```

## 保护简单 Java Servlet
{: #protecting-a-simple-java-servlet }
1. 创建名为 `GetBalance` 的简单 Java Servlet，这将返回硬编码值：

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

2. 创建名为 `JTVFilter` 的 `javax.servlet.Filter` 实现，这将针对指定作用域验证授权头：

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

3. 在 servlet 的 **web.xml** 文件中，声明 `JTVFilter` 的实例，并传递 **scope**`accessRestricted` 作为参数：

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

   然后，使用过滤器保护 servlet：

   ```xml
   <filter-mapping>
      <filter-name>accessRestricted</filter-name>
      <url-pattern>/GetBalance</url-pattern>
   </filter-mapping>
   ```

## 样本应用程序
{: #sample-application }

您可以在受支持的应用程序服务器（Tomcat、WebSphere Application Server Full Profile 和 WebSphere Application Server Liberty Profile）上部署项目。  
[下载简单 Java servlet](https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80)。

### 样本用法
{: #sample-usage }
1. 确保[更新保密客户机](../#confidential-client)和 {{ site.data.keys.mf_console }} 中的密钥值。
2. 部署安全性检查：**[UserLogin](../../user-authentication/security-check/)** 或 **[PinCodeAttempts](../../credentials-validation/security-check/)**。
3. 注册匹配应用程序。
4. 将 `accessRestricted` 作用域映射到安全性检查。
5. 更新客户机应用程序以针对 servlet URL 生成 `WLResourceRequest`。
