---
layout: tutorial
title: Webentwicklungsumgebung einrichten
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das Entwickeln und Testen von Webanwendungen ist so einfach wie das Anzeigen der Vorschau einer loaklen HTML-Datei in einem Webbrowser Ihrer Wahl.   
Entwickler können ihre bevorzugte IDE und für ihre Zwecke geeignete Frameworks nutzen. 

Bei der Entwicklung von Webanwendungen kann allerdings ein Hindernis auftauchen. Bei Webanwendungen kann es zu Fehlern wegen einer Verletzung der
[Same-Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) kommen. Die Same-Origin Policy ist eine Einschränkung von Web-Browsern. Wenn eine Anwendung beispielsweise in der Domäne **example.com** gehostet wird,
darf diese Anwendung nicht auf Inhalte zugreifen, die auf einem anderen Server oder
auf dem {{ site.data.keys.mf_server }} verfügbar sind. 

[Web-Apps, die das
Web-SDK der {{ site.data.keys.product }} verwenden sollen](../../../application-development/sdk/web),
benötigen eine unterstützende Topologie. Sie könnten beispielsweise
einen Reverse Proxy verwenden, der Anforderungen indirekt und unter Wahrung des einheitlichen Ursprungs zum vorgesehenen Server weiterleitet. 

Sie können eine der folgenden Methoden anwenden, um den Richtlinienanforderungen zu genügen: 

- Stellen Sie die Webanwendungsressourcen
über einen Anwendungsserver (WebSphere Full/Liberty Profile) bereit, der auch {{ site.data.keys.mf_server }} bereitstellt. 
- Verwenden Sie Node.js als Proxy, um Anwendungsanforderungen an {{ site.data.keys.mf_server }} weiterzuleiten.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Voraussetzungen](#prerequisites)
- [Webanwendungsressourcen mit WebSphere Liberty Profile bereitstellen](#using-websphere-liberty-profile-to-serve-the-web-application-resources)
- [Node.js](#using-nodejs)
- [Nächste Schritte](#next-steps)

## Voraussetzungen
{: #prerequisites }
-   {: #web-app-supported-browsers }
    Für Webanwendungen werden die folgenden Browserversionen unterstützt. Die Versionsnummern geben die älteste Version des jeweiligen Browsers mit Unterstützung für Webanwendungen an. 

    | Browser| Chrome| Safari<sup>*</sup>   | Internet Explorer| Firefox| Android-Browser|
    |-----------------------|:--------:|:--------------------:|:-------------------:|:---------:|:-----------------:|
    | **Unterstützte Version** |  {{ site.data.keys.mf_web_browser_support_chrome_ver }} | {{ site.data.keys.mf_web_browser_support_safari_ver }} | {{ site.data.keys.mf_web_browser_support_ie_ver }} | {{ site.data.keys.mf_web_browser_support_firefox_ver }} | {{ site.data.keys.mf_web_browser_support_android_ver }}  |

    <sup>*</sup> In Safari wird der private Browsermodus nur für aus einer Seite bestehende Anwendungen unterstützt. Bei anderen Anwendungen kann es zu einem nicht erwarteten Verhalten kommen. 

    {% comment %} [sharonl][c-web-browsers-ms-edge] See information regarding Microsoft Edge support in Task 111165. {% endcomment %}

-   Für die folgenden Setup-Anweisungen muss Apache Maven oder Node.js auf der Entwicklerworkstation installiert sein. Weitere Anweisungen entnehmen Sie bitte dem [Installationshandbuch](../mobilefirst/installation-guide/).



## Webanwendungsressourcen mit WebSphere Liberty Profile bereitstellen
{: #using-websphere-liberty-profile-to-serve-the-web-application-resources }
Die Webanwendungsressourcen müssen für ihre Bereitstellung in einer Maven-Webanwendung (einer **.war**-Datei) gespeichert werden. 

### Maven-Archetyp webapp erstellen
{: #creating-a-maven-webapp-archetype }
1. Navigieren Sie in einem **Befehlszeilenfenster** zu einer Position Ihrer Wahl. 
2. Führen Sie den folgenden Befehl aus: 

   ```bash
   mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```
    - Ersetzen Sie **MyCompany** und **MyWebApp** durch eigene Werte. 
    - Entfernen Sie das Attribut `-DinteractiveMode=false`, wenn Sie die Werte einzeln eingeben möchten. 

### Maven-Webanwendung mit den Webanwendungsressourcen erstellen 
{: #building-the-maven-webapp-with-the-web-applications-resources }
1. Stellen Sie die Webanwendungsressourcen (HTML-, CSS-, JavaScript- und Bilddateien) in den generierten Ordner
**[MyWebApp] → src → Main → webapp**. 

    > Ab jetzt ist der Ordner **webapp** die Position für die Entwicklung der Webanwendung. 

2. Führen Sie den Befehl `mvn clean install` aus, um eine WAR-Datei mit den Webressourcen der Anwendung zu generieren.
     
   Die generierte WAR-Datei finden Sie im Ordner **[MyWebApp] → target**.
   
    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:** Sie müssen `mvn clean install` jedes Mal ausführen, wenn Sie eine Webressource aktualisieren.

### Maven-Webanwendung zum Anwendungsserver hinzufügen
{: #adding-the-maven-webapp-to-the-application-server }
1. Bearbeiten Sie die Datei **server.xml** Ihres WebSphere-Anwendungsservers.  
    Wenn Sie das {{ site.data.keys.mf_dev_kit }} verwenden, befindet sich die Datei im Ordner [**{{ site.data.keys.mf_dev_kit }}] → mfp-server → user → servers → mfp**. Fügen Sie den folgenden Eintrag hinzu:

   ```xml
   <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
   ```
    - Ersetzen Sie **name** und **path-to/MyWebApp.war** durch eigene Werte.
    - Der Anwendungsserver wird nach dem Speichern der Änderungen in der Datei **server.xml** automatisch neu gestartet.  

### Webanwendung testen
{: #testing-the-web-application }
Wenn Sie bereit sind, Ihre Webanwendung zu testen, öffnen Sie die URL **localhost:9080/MyWebApp**.
    - Ersetzen Sie **MyWebApp** durch Ihren eigenen Wert. 

## Node.js
{: #using-nodejs }
Node.js kann als ein Reverse Proxy genutzt werden, um Anforderungen von der Webanwendungen
an {{ site.data.keys.mf_server }} weiterzuleiten.

1. Navigieren Sie in einem **Befehlszeilenfenster** zum Ordner Ihrer Webanwendung und führen Sie die folgenden Befehle aus:  

   ```bash
   npm init
   npm install --save express
   npm install --save request
   ```

2. Erstellen Sie im Ordner **node_modules** eine neue Datei, z. B. **proxy.js**.
3. Fügen Sie folgenden Code zu der Datei hinzu: 

   ```javascript
   var express = require('express');
   var http = require('http');
   var request = require('request');

   var app = express();
   var server = http.createServer(app);
   var mfpServer = "http://localhost:9080";
   var port = 9081;

   server.listen(port);
   app.use('/myapp', express.static(__dirname + '/'));
   console.log('::: server.js ::: Listening on port ' + port);

   // Web-Server - bedient die Webanwendung
   app.get('/home', function(req, res) {
        // Website, zu der eine Verbindung möglich sein soll
        res.sendFile(__dirname + '/index.html');
   });

   // Reverse Proxy, der die Anforderung an/von {{ site.data.keys.mf_server }} weiterleitet
   app.use('/mfp/*', function(req, res) {
        var url = mfpServer + req.originalUrl;
        console.log('::: server.js ::: Passing request to URL: ' + url);
        req.pipe(request[req.method.toLowerCase()](url)).pipe(res);
   });
   ```
    - Ersetzen Sie **port** durch Ihren bevorzugten Wert. 
    - Ersetzen Sie `/myapp` durch Ihren bevorzugten Pfadnamen für Ihre Webanwendung. 
    - Ersetzen Sie `/index.html` durch den Namen Ihrer Haupt-HTML-Datei. 
    - Aktualisieren Sie ggf. `/mfp/*` mit dem Kontextstammverzeichnis Ihrer MobileFirst-Foundation-Laufzeit. 

4. Führen Sie zum Starten des Proxys den Befehl `node proxy.js` aus.
5. Wenn Sie bereit sind, Ihre Webanwendung zu testen, öffnen Sie die URL **Serverhostname:Port/App-Name** (z. B. **http://localhost:9081/myapp**). 
    - Ersetzen Sie **Serverhostname** durch Ihren eigenen Wert. 
    - Ersetzen Sie **Port** durch Ihren eigenen Wert. 
    - Ersetzen Sie **App-Name** durch Ihren eigenen Wert. 

## Nächste Schritte
{: #next-steps }
Wenn Sie mit der {{ site.data.keys.product }}-Entwicklung von Webanwendungen fortfahren möchten,
muss das Web-SDK der {{ site.data.keys.product }} zu den Webanwendungen hinzugefügt werden. 

* Informieren Sie sich darüber, wie das [SDK der {{ site.data.keys.product }}
zu Webanwendungen hinzugefügt wird](../../../application-development/sdk/web/).
* Informationen zur Anwendungsentwicklung enthalten die Lernprogramme unter [SDK der {{ site.data.keys.product }} verwenden](../../../application-development/). 
* Informationen zur Adapterentwicklung findne Sie in der Kategorie [Adapter](../../../adapters/). 
