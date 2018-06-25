---
layout: tutorial
title: Kombinierter Einsatz mit Cloudant
relevantTo: [javascript]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Cloudant ist eine auf CouchDB basierende NoSQL-Datenbank, die als eigenständiges Produkt und als DBaaS (Database-as-a-Service) in IBM Cloud und unter `cloudant.com` verfügbar ist.

Es folgt ein Auszug aus der Cloudant-Dokumentation: 
> Dokumente sind JSON-Objekte. Sie sind Container für Ihre Daten und bilden die Basis der Cloudant-Datenbank.   
Für alle Dokumente muss es die beiden folgenden Felder geben: ein eindeutiges Feld `_id` und ein Feld `_rev`. Das Feld
`_id` wird von Ihnen erstellt oder von Cloudant automatisch als UUID generiert. Das Feld `_rev` ist eine Revisionsnummer und von entscheidender Bedeutung für das Cloudant-Replikationsprotokoll. Neben diesen beiden obligatorischen Feldern können Dokumente beliebige weitere Inhalte im JSON-Format enthalten.



Die Cloudant-API ist auf der Website [IBM Cloudant Documentation](https://docs.cloudant.com/index.html) dokumentiert. 

Für die Kommunikation mit einer fernen Cloudant-Datenbank können Sie Adapter nutzen. In diesem Lernprogramm finden Sie einige Beispiele. 

Für dieses Lernprogramm wird vorausgesetzt, dass Sie sich mit Adaptern auskennen (siehe [JavaScript-HTTP-Adapter](../javascript-adapters/js-http-adapter) oder [Java-Adapter](../java-adapters)).

### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [JavaScript-HTTP-Adapter](#javascript-http-adapter)
* [Java-Adapter](#java-adapters)
* [Beispielanwendung](#sample-application)


## JavaScript-HTTP-Adapter
{: #javascript-http-adapter }
Die Cloudant-API ist als einfacher HTTP-Web-Service zugänglich. 

Sie können einen HTTP-Adapter verwenden und mit der Methode `invokeHttp` eine Verbindung zum Cloudant-HTTP-Service herstellen. 

### Authentifizierung
{: #authentication }
Cloudant unterstützt unterschiedliche Formen der Authentifizierung. Informieren Sie sich in der Cloudant-Dokumentation unter
[https://docs.cloudant.com/authentication.html](https://docs.cloudant.com/authentication.html) über die Authentifizierung. Mit einem JavaScript-HTTP-Adapter können Sie
die **Basisauthentifizierung** verwenden.

Geben Sie in Ihrer Adapter-XML-Datei die Domäne (`domain`) für Ihre Cloudant-Instanz
und den Port (`port`) an. Fügen Sie ein Element `authentication` vom Typ `basic` hinzu. Das Framework verwendet diese Berechtigungsnachweise, um einen
HTTP-Header `Authorization: Basic` zu generieren. 

**Hinweis:** Cloudant ermöglicht die Generierung eindeutiger API-Schlüssel, die Sie anstelle Ihres eigentlichen Benutzernamens und Ihres Kennworts verwenden können. 

```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>https</protocol>
    <domain>CLOUDANT_ACCOUNT.cloudant.com</domain>
    <port>443</port>
    <connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
    <socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
    <authentication>
      <basic/>
        <serverIdentity>
          <username>CLOUDANT_KEY</username>
          <password>CLOUDANT_PASSWORD</password>
        </serverIdentity>
    </authentication>
    <maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
    <!-- Following properties used by adapter's key manager for choosing specific certificate from key store
    <sslCertificateAlias></sslCertificateAlias>
    <sslCertificatePassword></sslCertificatePassword>
    -->
  </connectionPolicy>
</connectivity>
```

### Prozeduren
{: #procedures }
Ihre Adapterprozeduren verwenden die Methode `invokeHttp`, um eine HTTP-Anforderung an eine der von Cloudant definierten URLs zu senden.   
Sie können beispielsweise ein neues Dokument erstellen, indem Sie
eine `POST`-Anforderung an `/{*your-database*}/` senden. Der Hauptteil der Anforderung
muss dabei eine JSON-Darstellung des Dokuments sein, das Sie speichern möchten. 

```js
function addEntry(entry){

    var input = {
            method : 'post',
            returnedContentType : 'json',
            path : DATABASE_NAME + '/',
            body: {
                contentType : 'application/json',        
                content : entry
            }
        };

    var response = MFP.Server.invokeHttp(input);
    if(!response.id){
        response.isSuccessful = false;
    }
    return response;

}
```

Diese Idee ist auf alle Cloudant-Funktionen anwendbar. Informieren Sie sich in der Cloudant-Dokumentation unter
[https://docs.cloudant.com/document.html](https://docs.cloudant.com/document.html) über Dokumente. 

## Java-Adapter
{: #java-adapters }
Cloudant stellt eine [Java-Clientbibliothek](https://github.com/cloudant/java-cloudant) bereit, damit Sie alle Cloudant-Features ohne großen Aufwand nutzen können. 

Konfigurieren Sie während der Initialisierung Ihres Java-Adapters eine `CloudantClient`-Instanz für Ihre Arbeit.   
**Hinweis:** Cloudant ermöglicht die Generierung eindeutiger API-Schlüssel, die Sie anstelle Ihres eigentlichen Benutzernamens und Ihres Kennworts verwenden können. 

```java
CloudantClient cloudantClient = new CloudantClient(cloudantAccount,cloudantKey,cloudantPassword);
db = cloudantClient.database(cloudantDBName, false);
```
<br/>
Wenn Sie [Plain Old Java Objects](https://en.wikipedia.org/wiki/Plain_Old_Java_Object) und JAX-RS 2.0 (Java-API für REST-konforme Web-Services) verwenden, können Sie in Cloudant ein neues Dokument erstellen, indem Sie eine JSON-Darstellung des Dokuments in der HTTP-Anforderung senden.



```java
@POST
@Consumes(MediaType.APPLICATION_JSON)
public Response addEntry(User user){
    if(user!=null && user.isValid()){
        db.save(user);
        return Response.ok().build();
    }
    else{
        return Response.status(418).build();
    }
}
```

<img alt="Beispielanwendung" src="cloudant-app.png" style="float:right"/>
## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/CloudantAdapter/tree/release80), um das Cordova-Projekt herunterzuladen. 

Das Beispiel enthält zwei Adapter (einen JavaScript- und einen Java-Adapter).   
Darüber hinaus enthält es eine Cordova-Anwendung, die mit den beiden Adaptern arbeitet. 

> **Hinweis:** Das Beispiel verwendet aufgrund einer bekannten Einschränkung Cloudant Java Client Version 1.2.3. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
