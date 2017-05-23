---
layout: tutorial
title: Trust Association Interceptor
breadcrumb_title: Trust Association Interceptor
relevantTo: [android,ios,windows,javascript]
weight: 2
downloads:
  - name: Beispiel herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} stellt eine Java-Bibliothek zur Vereinfachung der Authentifizierung externer Ressourcen
mit [WebSphere Trust Association Interceptors](https://www.ibm.com/support/knowledgecenter/SSHRKX_8.5.0/mp/security/sec_ws_tai.dita) zur Verfügung.

Die Java-Bibliothek wird als JAR-Datei (**com.ibm.mfp.oauth.tai-8.0.0.jar**) bereitgestellt.

Dieses Lernprogramm zeigt, wie ein einfaches Java-Servlet (`TAI/GetBalance`) mit einem Gültigkeitsbereich
(`accessRestricted`) geschützt wird.

**Voraussetzungen:**

* Gehen Sie das Lernprogramm [Externe Ressource mit {{ site.data.keys.mf_server }} authentifizieren](../) durch. 
* Machen Sie sich mit dem [Sicherheitsframework der {{ site.data.keys.product }}](../../) vertraut.

![Ablauf](TAI_flow.jpg)

## Server-Setup
{: #server-setup }
1. Öffnen Sie in der {{ site.data.keys.mf_console }} das **Download-Center** und die Registerkarte **Tools**, um die ZIP-Datei mit den Sicherheitstools herunterzuladen. Sie erhalten ein
Archiv `mfp-oauth-tai.zip`. Entpacken Sie diese ZIP-Datei. 
2. Fügen Sie die Datei `com.ibm.mfp.oauth.tai.jar` in der
WebSphere-Application-Server-Instanz zum Verzeichnis **usr/extension/lib** hinzu.
3. Fügen Sie die Datei `OAuthTai.mf` in der
WebSphere-Application-Server-Instanz zum Verzeichnis **usr/extension/lib/features** hinzu.

### Setup für web.xml
{: #webxml-setup }
Fügen Sie eine Integritätsbedingung für die Sicherheit und eine Sicherheitsrolle zur Datei
`web.xml` der WebSphere-Application-Server-Instanz hinzu. 

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
Passen Sie die WebSphere-Application-Server-Datei `server.xml` an Ihre externe Ressource an. 

* Konfigurieren Sie den Feature-Manager so, dass er die folgenden Features enthält: 

  ```xml
  <featureManager>
           <feature>jsp-2.2</feature>
           <feature>appSecurity-2.0</feature>
           <feature>usr:OAuthTai-8.0</feature>
           <feature>servlet-3.0</feature>
           <feature>jndi-1.0</feature>
  </featureManager>
  ```

* Fügen Sie eine Sicherheitsrolle in Form einer Klassenannotation zu Ihrem Java-Servlet hinzu: 

```java
@ServletSecurity(@HttpConstraint(rolesAllowed = "TAIUserRole"))
```

Wenn Sie servlet-2.x verwenden, müssen Sie die Sicherheitsrolle wie folgt in Ihrer Datei web.xml definieren: 

```xml
<application contextRoot="TAI" id="TrustAssociationInterceptor" location="TAI.war" name="TrustAssociationInterceptor"/>
   <application-bnd>
      <security-role name="TAIUserRole">
         <special-subject type="ALL_AUTHENTICATED_USERS"/>
      </security-role>
   </application-bnd>
</application>
```

* Konfigurieren Sie den OAuthTAI, in dem der Schutz Ihrer URLs festgelegt wird: 

  ```xml
  <usr_OAuthTAI id="myOAuthTAI" authorizationURL="http://localhost:9080/mfp/api" clientId="ExternalResourceId" clientSecret="ExternalResourcePass" cacheSize="500">
            <securityConstraint httpMethods="GET POST" scope="accessRestricted" securedURLs="/GetBalance"></securityConstraint>
  </usr_OAuthTAI>
  ```
    - **authorizationURL**: Ihr {{ site.data.keys.mf_server }} (`http(s):/Name_Ihres_Hosts:Port/Laufzeitname/api`)
oder ein externer Autorisierungsserver wie IBM DataPower.

    - **clientID**: Der Ressourcenserver muss ein registrierter vertraulicher Client sein. Im Lernprogramm [Vertrauliche Clients](../../confidential-clients/) erfahren Sie, wie ein vertraulicher Client registriert wird. *Der vertrauliche Client **MUSS** den zulässigen Bereich `authorization.introspect` haben, damit er Token validieren kann. 

    - **clientSecret**: Der Ressourcenserver muss ein registrierter vertraulicher Client sein. Im Lernprogramm [Vertrauliche Clients](../../confidential-clients/) erfahren Sie, wie ein vertraulicher Client registriert wird. 
    - **cacheSize (optional)**: Der TAI verwendet den Java-Token-Validator-Cache, um Token und Introspektionsdaten
als Werte zwischenzuspeichern, damit ein Token, das in der Anforderung vom Client kommt, nicht innerhalb einer kurzen Zeit erneut inspiziert werden muss. 

        Die Standardgröße liegt bei 50.000 Token.   

        Wenn Sie garantieren möchten, dass die Token bei jeder Anforderung inspiziert werden, setzen Sie den Cachewert auf 0.   

    - **scope**: Der Ressourcenserver führt die Authentifizierung anhand von Gültigkeitsbereichen durch. Ein Bereich kann eine Sicherheitsüberprüfung oder ein Sicherheitsüberprüfungen zugeordnetes Element "scope" sein. 

## Tokenintrospektionsdaten vom TAI verwenden
{: #using-the-token-introspection-data-from-the-tai }
Vielleicht möchten Sie von Ihrer Ressource aus auf die Tokeninformationen zugreifen, die vom TAI abgefangen und validiert wurden. Die Liste der für das Token gefundenen
Daten ist in den [API-Referenzinformationen](../../../api/java-token-validator) enthalten. Mit der [API WSSubject](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_sec_apis.html) können Sie diese Daten abrufen:

```java
Map<String, String> credentials = WSSubject.getCallerSubject().getPublicCredentials(Hashtable.class).iterator().next();
JSONObject securityContext = new JSONObject(credentials.get("securityContext"));
...
securityContext.get('mfp-device')
```

## Beispielanwendung
{: #sample-application }
Sie können das Projekt in unterstützten Anwendungsservern (WebSphere Application Server Full Profile und WebSphere Application Server Liberty Profile) implementieren.  
[Laden Sie das einfache Java-Servlet herunter](https://github.com/MobileFirst-Platform-Developer-Center/TrustAssociationInterceptor/tree/release80).

### Verwendung des Beispiels
{: #sample-usage }
1. Sie müssen [den vertraulichen Client](../#confidential-client)
und die geheimen Schlüssel in der {{ site.data.keys.mf_console }} aktualisieren.
2. Implementieren Sie eine der Sicherheitsüberprüfungen: **[UserLogin](../../user-authentication/security-check/)**
oder **[PinCodeAttempts](../../credentials-validation/security-check/)**.
3. Registrieren Sie die passende Anwendung. 
4. Ordnen Sie der Sicherheitsüberprüfung den Bereich `accessRestricted` zu. 
5. Aktualisieren Sie die Clientanwendung so, dass `WLResourceRequest` Ihre Servlet-URL ist. 
6. Legen Sie securityConstraint als Ihren Bereich für die Sicherheitsüberprüfung fest, die Ihre Clients für ihre Authentifizierung durchlaufen müssen. 
