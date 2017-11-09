---
layout: tutorial
title: Validador de señal Java
breadcrumb_title: Validador de señal Java
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Descargar ejemplo
    url: https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona una biblioteca Java para imponer funciones de seguridad en recursos externos.  
La biblioteca Java se proporciona como un archivo JAR (**mfp-java-token-validator-8.0.0.jar**).

Esta guía de aprendizaje muestra cómo proteger un Servlet Java simple, `GetBalance`, utilizando un ámbito (`accessRestricted`).

**Requisitos previos:**

* Lea la guía de aprendizaje [Utilización de {{ site.data.keys.mf_server }} para autenticar recursos externos](../).
* Compresión de la [{{ site.data.keys.product_adj }} Infraestructura de seguridad de Foundation](../../).

![Flujo](JTV_flow.jpg)

## Añadir la dependencia de archivo de .jar
{: #adding-the-jar-file-dependency }
El archivo **mfp-java-token-validator-8.0.0.jar** está disponible como **dependencia maven**:

```xml
<dependency>
  <groupId>com.ibm.mfp</groupId>
  <artifactId>mfp-java-token-validator</artifactId>
  <version>8.0.0</version>
</dependency>
```

## Creación de una instancia de TokenValidationManager
{: #instantiating-the-tokenvalidationmanager }
Para poder validar señales, cree la instancia `TokenValidationManager`.

```java
TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret);
```

- `authorizationURI`: el identificador universal de recursos (URI) del servidor de autorización, normalmente {{ site.data.keys.mf_server }}. Por ejemplo **http://localhost:9080/mfp/api**.
- `clientId`: El ID de cliente confidencial que ha configurado en {{ site.data.keys.mf_console }}.
- `clientSecret`: El secreto de cliente confidencial que ha configurado en {{ site.data.keys.mf_console }}.

> La biblioteca expone una API que encapsula y simplifica la interacción con el punto final de introspección del servidor de autorización. Para obtener una referencia de API detallada, [consulte la {{ site.data.keys.product_adj }} referencia de API del validador de señal Java](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_mfpf_java_token_validator_api.html?view=kc).


## Validación de credenciales
{: #validating-the-credentials }
El método API `validate` ofrece al servidor de autorización la validación de la cabecera de autorización: 

```java
public TokenValidationResult validate(java.lang.String authorizationHeader, java.lang.String expectedScope);
```

- `authorizationHeader`: El contenido de la cabecera HTTP `Authorization`, que es la señal de acceso.Por ejemplo, puede obtenerse a partir de `HttpServletRequest` (`httpServletRequest.getHeader("Authorization")`).
- `expectedScope`: El ámbito para validar la señal, por ejemplo `accessRestricted`.

Puede consultar el objeto `TokenValidationResult` resultante para un error o para los datos de introspección válidos:

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

## Datos de introspección
{: #introspection-data }
El objeto `TokenIntrospectionData` devuelto por `getIntrospectionData()` le proporciona información acerca del cliente como, por ejemplo, el nombre de usuario del usuario activo actual:

```java
httpServletRequest.setAttribute("introspection-data", tokenValidationRes.getIntrospectionData());
```

```java
TokenIntrospectionData introspectionData = (TokenIntrospectionData) request.getAttribute("introspection-data");
String username = introspectionData.getUsername();
```

## Memoria caché
{: #cache }
La clase `TokenValidationManager` tiene una memoria caché interna que copia en caché las señales y los datos de introspección. El propósito de la memoria caché es reducir la cantidad de *introspecciones* de señal realizadas en relación con el servidor de autorización, si se realiza una solicitud con la misma cabecera.

El tamaño de la memoria caché predeterminada es **50000 elementos**. Después de alcanzar la capacidad, se elimina la señal más antigua.  

El constructor de `TokenValidationManager` también acepta `cacheSize` (número de elementos de datos de introspección) para almacenar:

```java
public TokenValidationManager(java.net.URI authorizationURI, java.lang.String clientId, java.lang.String clientSecret, long cacheSize);
```

## Protección de un servlet Java simple
{: #protecting-a-simple-java-servlet }
1. Cree un servlet Java simple llamado `GetBalance`, que devuelve un valor no modificable:

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

2. Cree una implementación `javax.servlet.Filter`, llamada `JTVFilter`, que validará la cabecera de autorización para un ámbito proporcionado:

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

3. En el archivo **web.xml** del servlet, declare una instancia de `JTVFilter` y pase el **ámbito** `accessRestricted` como un parámetro:

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

   Proteja el servlet con el filtro:

   ```xml
   <filter-mapping>
      <filter-name>accessRestricted</filter-name>
      <url-pattern>/GetBalance</url-pattern>
   </filter-mapping>
   ```

## Aplicación de ejemplo
{: #sample-application }

Puede desplegar el proyecto en los servidores de aplicaciones soportados (Tomcat, el perfil completo de WebSphere Application Server y el perfil de WebSphere Application Server Liberty).  
[Descargue el servlet Java simple](https://github.com/MobileFirst-Platform-Developer-Center/JavaTokenValidator/tree/release80).

### Uso de ejemplo
{: #sample-usage }
1. Asegúrese de [actualizar el cliente confidencial](../#confidential-client) y los valores secretos en {{ site.data.keys.mf_console }}.
2. Despliegue alguna de las comprobaciones de seguridad: **[UserLogin](../../user-authentication/security-check/)** o **[PinCodeAttempts](../../credentials-validation/security-check/)**.
3. Registre la aplicación coincidente.
4. Correlacione el ámbito `accessRestricted` en la comprobación de seguridad.
5. Actualice la aplicación de cliente para crear `WLResourceRequest` en su URL de servlet.
