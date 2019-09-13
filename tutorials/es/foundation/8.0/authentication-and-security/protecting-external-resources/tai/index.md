---
layout: tutorial
title: Interceptor de asociaciones de confianza
breadcrumb_title: Trust Association Interceptor
relevantTo: [android,ios,windows,javascript]
weight: 2
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona una biblioteca Java para facilitar la autenticación de recursos externos mediante [los interceptores de asociación de confianza de IBM WebSphere](https://www.ibm.com/support/knowledgecenter/SSHRKX_8.5.0/mp/security/sec_ws_tai.dita).

La biblioteca Java se proporciona como un archivo JAR (**com.ibm.mfp.oauth.tai-8.0.0.jar**).

Esta guía de aprendizaje muestra cómo proteger un Servlet Java simple, `TAI/GetBalance`, utilizando un ámbito (`accessRestricted`).

**Requisito previos:**

* Lea la guía de aprendizaje [Utilización de {{ site.data.keys.mf_server }} para autenticar recursos externos](../).
* Conozca mejor la [infraestructura de seguridad de {{ site.data.keys.product }}](../../).

![Flujo](TAI_flow.jpg)

## Configuración de servidor
{: #server-setup }
1. Descargue el archivo .zip de las herramientas de seguridad en el separador **{{ site.data.keys.mf_console }} → Centro de descargas → Herramientas**. Encontrará un archivo `mfp-oauth-tai.zip`. Desempaquete el zip.
2. Añada el archivo `com.ibm.mfp.oauth.tai.jar` a la instancia de WebSphere Application Server en **usr/extension/lib**.
3. Añada el archivo `OAuthTai.mf` a la instancia de WebSphere Application Server en **usr/extension/lib/features**.

### web.xml setup
{: #webxml-setup }
Añada una restricción de seguridad y un rol de seguridad al archivo `web.xml` de la instancia WebSphere Application Server:

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
Modifique el archivo `server.xml` de WebSphere Application Server en el recurso externo.

* Configure el gestor de características para incluir las características siguientes:

  ```xml
  <featureManager>
           <feature>jsp-2.2</feature>
           <feature>appSecurity-2.0</feature>
           <feature>usr:OAuthTai-8.0</feature>
           <feature>servlet-3.0</feature>
           <feature>jndi-1.0</feature>
  </featureManager>
  ```

* Añada un rol de seguridad como anotación de clase en el servlet de Java :

```java
@ServletSecurity(@HttpConstraint(rolesAllowed = "TAIUserRole"))
```

Si está utilizando servlet-2.x, debe definir el rol de seguridad del archivo web.xml:

```xml
<application contextRoot="TAI" id="TrustAssociationInterceptor" location="TAI.war" name="TrustAssociationInterceptor"/>
   <application-bnd>
      <security-role name="TAIUserRole">
         <special-subject type="ALL_AUTHENTICATED_USERS"/>
      </security-role>
   </application-bnd>
</application>
```

* Configure OAuthTAI. Aquí se fijan los URL para protegerlos:

  ```xml
  <usr_OAuthTAI id="myOAuthTAI" authorizationURL="http://localhost:9080/mfp/api" clientId="ExternalResourceId" clientSecret="ExternalResourcePass" cacheSize="500">
            <securityConstraint httpMethods="GET POST" scope="accessRestricted" securedURLs="/GetBalance"></securityConstraint>
  </usr_OAuthTAI>
  ```
    - **authorizationURL**: Su {{ site.data.keys.mf_server }} (`http(s):/your-hostname:port/runtime-name/api`), o un servidor AZ externo como IBM DataPower.

    - **clientID**: El servidor de recurso debe ser un cliente confidencial registrado. Para saber cómo registrar un cliente confidencial, lea la guía de aprendizaje [Clientes confidenciales](../../confidential-clients/). *El cliente confidencial **DEBE** tener el ámbito permito `authorization.introspect` para poder validar las señales.

    - **clientSecret**: El servidor de recurso debe ser un cliente confidencial registrado. Para saber cómo registrar un cliente confidencial, lea la guía de aprendizaje [Clientes confidenciales](../../confidential-clients/).
    - **cacheSize (opcional)**: El interceptor de asociación de confianza (TAI) utiliza la memoria caché del validador de señal Java para copiar en caché las señales y los datos de introspección en forma de valores, para que no sea necesario volver a hacer una introspección de la señal de la solicitud del cliente en un intervalo de tiempo breve.

        El tamaño predeterminado es de 50,000 señales.  

        Si desea asegurar que se ha realizado una introspección de cada solicitud, establezca el valor de la memoria caché en 0.  

    - **scope**: El servidor de recurso se autentica en relación con uno o más ámbitos. Un ámbito puede ser una comprobación de seguridad o un elemento de ámbito correlacionado con comprobaciones de seguridad.

## Utilización de los datos de introspección de la señal del interceptor de asociación de confianza (TAI)
{: #using-the-token-introspection-data-from-the-tai }
En su recurso, es posible que desee acceder a la información de la señal interceptada y validada por el TAI. Encontrará la lista de los datos encontrados en la señal [de la referencia de API](../../../api/java-token-validator). Para obtenerlos, utilice la [API WSSubject](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_sec_apis.html):

```java
Map<String, String> credentials = WSSubject.getCallerSubject().getPublicCredentials(Hashtable.class).iterator().next();
JSONObject securityContext = new JSONObject(credentials.get("securityContext"));
...
securityContext.get('mfp-device')
```

## Aplicación de ejemplo
{: #sample-application }
Puede desplegar el proyecto en los servidores de aplicaciones soportados (el perfil completo de WebSphere Application Server y el perfil de WebSphere Application Server Liberty).  
[Descargue el servlet Java simple](https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80).

### Uso de ejemplo
{: #sample-usage }
1. Asegúrese de [actualizar el cliente confidencial](../#confidential-client) y los valores secretos en {{ site.data.keys.mf_console }}.
2. Despliegue alguna de las comprobaciones de seguridad: **[UserLogin](../../user-authentication/security-check/)** o **[PinCodeAttempts](../../credentials-validation/security-check/)**.
3. Registre la aplicación coincidente.
4. Correlacione el ámbito `accessRestricted` en la comprobación de seguridad.
5. Actualice la aplicación de cliente para crear `WLResourceRequest` en su URL de servlet.
6. Establezca el ámbito de securityConstraint para que sea la comprobación de seguridad que su cliente debe autenticar.
