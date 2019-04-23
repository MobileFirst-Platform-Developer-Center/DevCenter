---
layout: tutorial
title: Neuerungen der CD-Updates
breadcrumb_title: CD Updates
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Mit vorläufigen Fixes und CD-Updates werden Patches und Aktualisierungen bereitgestellt, um Probleme zu lösen und die {{ site.data.keys.product_full }} hinsichtlich neuer Releases von Betriebssystemen für mobile Geräte auf dem neuesten Stand zu halten. Mit CD-Updates werden zudem neue Features vorgestellt, die die Funktionalität des Produkts erweitern. 

Vorläufige Fixes und CD-Updates sind kumulativ. Wenn Sie den neusten vorläufigen Fix oder das neueste CD-Update für Version 8.0 herunterladen, erhalten Sie gleichzeitig die Korrekturen und Features aus allen früheren vorläufigen Fixes und CD-Updates.

Laden Sie das neueste CD-Update herunter und installieren Sie es. Sie erhalten damit alle in den folgenden Abschnitten beschriebenen Features. 

> Eine Liste der iFix-Releases für {{ site.data.keys.product }} 8.0 finden Sie [hier]({{site.baseurl}}/blog/tag/iFix_8.0/).

### Im CD-Update 4 (8.0.0.0-MFPF-IF201812191602-CDUpdate-04) enthaltene Features

##### <span style="color:NAVY">**HTTP/2-Unterstützung für APNS-Push-Benachrichtigungen**</span>

Neben den traditionellen TCP-Socket-basierten Benachrichtigungen bietet MobileFirst jetzt Unterstützung für HTTP/2-basierte APNS-Push-Benachrichtigungen. [Weitere Informationen finden Sie hier]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/sending-notifications/#http2-support-for-apns-push-notifications).

##### <span style="color:NAVY">**React-Native-SDK für Push freigegeben**</span>

Mit diesem CD-Update wurd das React-Native-SDK für Push (*react-native-ibm-mobilefirst-push 1.0.0*) freigegeben. 


### Mit CD-Update 3 (8.0.0.0-MFPF-IF201811050432-CDUpdate-03) eingeführte Features

##### <span style="color:NAVY">**Unterstützung für Aktualisierungstoken unter iOS**</span>

Die Mobile Foundation stellt das Feature für Aktualisierungstoken ab diesem CD-Update bereit. [Weitere Informationen finden Sie hier]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**CLI für Verwaltung (*mfpadm*) über die Mobile-Foundation-Konsole herunterladen**</span>

Die Mobile-Foundation-CLI für Verwaltung (*mfpadm*) kann jetzt vom *Download-Center* der Mobile-Foundation-Konsole aus heruntergeladen werden.

##### <span style="color:NAVY">**Unterstützung der MobileFirst-CLI für Node Version 8.x**</span>

Ab diesem iFix (*8.0.0.0-MFPF-IF201810040631*) bietet die MobileFirst-CLI der Mobile Foundation Unterstützung für Node Version 8.x.

##### <span style="color:NAVY">**Abhängigkeit von *libstdc++* für Cordova-Projekte entfernen**</span>

Ab diesem iFix (*8.0.0.0-MFPF-IF201809041150*) gibt es eine Änderung. Die Abhängigkeit von *libstdc++* wird für Cordova-Projekte entfernt. Dies ist für neue Apps, die unter iOS 12 ausgeführt werden, erforderlich. Ausführliche Informationen hierzu sowie eine Ausweichlösung finden Sie in [diesem Blogbeitrag](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/).

### Mit CD-Update 2 (8.0.0.0-MFPF-IF201807180449-CDUpdate-02) eingeführte Features

##### <span style="color:NAVY">**Unterstützung für die React-Native-Entwicklung**</span>

Beginnend mit dem CD-Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) wird mit der Verfügbarkeit des IBM Mobile-Foundation-SDK für React-Native-Apps in der Mobile Foundation die Unterstützung der React-Native-Entwicklung [angekündigt]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/). [Weitere Informationen finden Sie hier]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).

##### <span style="color:NAVY">**Automatisierte Synchronisation von JSONStore-Sammlungen mit CouchDB-Datenbanken für das iOS- und Cordova-SDK**</span>

Wenn Sie das MobileFirst-SDK für iOS und Cordova verwenden, können Sie beginnend mit dem CD-Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) die Synchronisation von Daten einer JSONStore-Sammlung auf einem Gerät mit jeder Art von CouchDB-Datenbank, einschließlich [Cloudant](https://www.ibm.com/in-en/marketplace/database-management), automatisieren. Weitere Informationen zu diesem Feature enthält dieser [Blogbeitrag]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/).

##### <span style="color:NAVY">**Einführung von Aktualisierungstoken**</span>

Beginnend mit dem CD-Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) gibt es in der Mobile Foundation eine besondere Art von Token, die als Aktualisierungstoken bezeichnet werden und zum Anfordern eines neuen Zugriffstokens verwendet werden können. [Weitere Informationen finden Sie hier]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Unterstützung für Cordova Version 8 und Cordova Android Version 7**</span>

Beginnend mit diesem iFix (*8.0.0.0-MFPF-IF201804051553*) werden MobileFirst-Cordova-Plug-ins für Cordova Version 8 und Cordova Android Version 7 unterstützt. Um mit der genannten Cordova-Version arbeiten zu können, müssen Sie die neuesten MobileFirst-Plug-ins abrufen und ein Upgrade auf die neueste CLI-Version (mfpdev-cli) durchführen. Ausführliche Informationen zu unterstützten Versionen für einzelne Plattformen finden Sie unter [MobileFirst-Foundation-SDK zu Cordova-Anwendungen hinzufügen]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Automatisierte Synchronisation von JSONStore-Sammlungen mit CouchDB-Datenbanken**</span>

Wenn Sie das MobileFirst-Android-SDK verwenden, können Sie ab diesem iFix (*8.0.0.0-MFPF-IF201802201451*) die Synchronisation von Daten einer JSONStore-Sammlung auf einem Gerät mit jeder Art von CouchDB-Datenbank, einschließlich [Cloudant](https://www.ibm.com/in-en/marketplace/database-management), automatisieren. Weitere Informationen zu diesem Feature enthält dieser [Blogbeitrag]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).

### Mit CD-Update 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01) eingeführte Features

##### <span style="color:NAVY">**Unterstützung für den Eclipse-UI-Editor**</span>

Beginnend mit dem CD-Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* stellt das MobileFirst Studio einen Eclipse-WYSIWYG-Editor bereit. Entwickler können die Benutzeroberfläche für ihre Cordova-Anwendungen mit diesem UI-Editor entwerfen und implementieren. [Weitere Informationen finden Sie hier](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**Neue Adapter zum Erstellen kognitiver Apps**</span>

Beginnend mit dem CD-Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* gibt es in der Mobile Foundation zwei neue vorgefertigte kognitive Serviceadapter für die Services [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) und [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator). Diese Adapter können über das *Download-Center* der Mobile-Foundation-Konsole heruntergeladen und implementiert werden.

##### <span style="color:NAVY">**Dynamische App-Authentizität**</span>

Ab dem iFix *8.0.0.0-MFPF-IF20170220-1900* gibt es eine neue Implementierung der *Anwendungsauthentizität*. Diese Implementierung erfordert nicht das Offlinetool *mfp-app-authenticity* zum Generieren der Datei *.authenticity_data*. Sie können die *Anwendungsauthentizität* vielmehr über die MobileFirst-Konsole aktivieren oder inaktivieren. Weitere Informationen finden Sie unter [Anwendungsauthentizität konfigurieren](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity).

##### <span style="color:NAVY">**Application-Center-Unterstützung (Client & Server) für Windows 10**</span>

Ab dem iFix *8.0.0.0-MFPF-IF20170327-1055* werden Windows-10-UWP-Apps im IBM Application Center unterstützt. Benutzer können jetzt Windows-10-UWP-Apps hochladen und auf ihrem Gerät installieren. Das Windows-10-UWP-Clientprojekt für die Installation der UWP-App wird jetzt mit dem Application Center bereitgestellt. Sie können das Projekt in Visual Studio öffnen und eine Binärdatei (z. B. *.appx *) für die Verteilung erstellen. Das Application Center stellt keine vordefinierte Methode für die Verteilung des mobilen Clients bereit. Weitere Informationen finden Sie unter [IBM Application-Center-Client für Microsoft Windows 10 Universal (nativ)](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

##### <span style="color:NAVY">**Unterstützung des MobileFirst-Eclipse-Plug-ins für Eclipse Neon**</span>

Ab dem iFix *8.0.0.0-MFPF-IF20170426-1210* gibt es ein aktualisiertes MobileFirst-Eclipse-Plug-in mit Unterstützung für Eclipse Neon.

##### <span style="color:NAVY">**Android-SDK für Verwendung einer neueren Version von OkHttp (Version 3.4.1) modifiziert**</span>

Ab dem iFix *8.0.0.0-MFPF-IF20170605-2216* gibt es ein modifiziertes Android-SDK, das eine neuere Version von *OkHttp (Version 3.4.1)* anstelle der alten Version aus dem bisherigen MobileFirst-SDK für Android verwendet. OkHttp ist nicht Bestandteil des SDK-Bundles, sondern wurde als Abängigkeit hinzugefügt. So haben Sie die freie Wahl bei der Verwendung der OkHttp-Bibliothek für Entwickler und können Konflikte durch mehrere Versionen von OkHttp vermeiden.

##### <span style="color:NAVY">**Unterstützung für Cordova Version 7**</span>

Ab dem iFix *8.0.0.0-MFPF-IF20170608-0406* wird Cordova Version 7 unterstützt. Ausführliche Informationen zu unterstützten Versionen für einzelne Plattformen finden Sie unter [MobileFirst-Foundation-SDK zu Cordova-Anwendungen hinzufügen](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

##### <span style="color:NAVY">**Unterstützung für mehrfaches Certificate Pinning**</span>

Ab dem iFix (*8.0.0.0-MFPF-IF20170624-0159*) unterstützt die Mobile Foundation das Pinning für mehrere Zertifikate. Bis zu diesem iFix hat die Mobile Foundation nur das Pinning eines Zertifikats unterstützt. In der Mobile Foundation gibt es eine neue API, die dem Benutzer das Herstellen von Verbindungen zu mehreren Hosts ermöglicht, indem er die öffentlichen Schlüssel von mehreren X509-Zertifikaten in der Clientanwendung verankert. Dieses Feature wird nur für native Android- und iOS-Apps unterstützt. Weitere Informationen zur *Unterstützung für das mehrfache Certificate Pinning* finden Sie unter [Neuerungen](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/) im Abschnitt *Neuerungen bei den MobileFirst-APIs*.

##### <span style="color:NAVY">**Adapter zum Erstellen einer kognitiven App**</span>

Ab dem iFix (*8.0.0.0-MFPF-IF20170710-1834*) gibt es in der Mobile Foundation vorgefertigte Adapter für kognitive Watson-Services wie [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter) und [*WatsonNLU (Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter). Diese Adapter können über das *Download-Center* der Mobile-Foundation-Konsole heruntergeladen und implementiert werden.

##### <span style="color:NAVY">**Cloud-Functions-Adapter zum Erstellen einer serverlosen App**</span>

Ab dem iFix (*8.0.0.0-MFPF-IF20170710-1834*) gibt es in der Mobile Foundation einen vorgefertigten [*Cloud Functions Adapter*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter) für die [Cloud Functions Platform](https://console.bluemix.net/openwhisk/). Dieser Adapter kann über das *Download-Center* der Mobile-Foundation-Konsole heruntergeladen und implementiert werden.

##### <span style="color:NAVY">**Unterstützung für mehrfaches Certificate Pinning im Cordova-SDK**</span>

Ab diesem iFix (*8.0.0.0-MFPF-IF20170803-1112*) wird das mehrfache Certificate Pinning vom Cordova-SDK unterstützt. Weitere Informationen zur *Unterstützung für das mehrfache Certificate Pinning* finden Sie unter [Neuerungen](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/) im Abschnitt *Neuerungen bei den MobileFirst-APIs*.

##### <span style="color:NAVY">**Unterstützung für die Cordova-Browserplattform**</span>

Ab dem iFix (*8.0.0.0-MFPF-IF20170823-1236*) bietet die {{ site.data.keys.product }} neben den bisher unterstützten Plattformen (Cordova Windows, Cordova Android und Cordova iOS) Unterstützung für die Cordova-Browserplattform. [Weitere Informationen finden Sie hier](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**Adapter aus der zugehörigen OpenAPI-Spezifikation generieren**</span>

Ab dem iFix (*8.0.0.0-MFPF-IF20170901-1903*) kann in der {{ site.data.keys.product }} ein Adapter automatisch aus der zugehörigen OpenAPI-Spezifikation generiert werden. Benutzer der {{ site.data.keys.product }} können sich jetzt auf die Anwendungslogik konzentrieren, anstatt den Mobile-Foundation-Adapter zu erstellen, der die Anwendung mit dem gewünschten Back-End-Service verbindet. [Weitere Informationen finden Sie hier]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**Unterstützung für iOS 11 und iPhone X**</span>

Beginnend mit dem CD-Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* wird für Version 8.0 der Mobile Foundation die Untertsützung für iOS 11 und iPhone X angekündigt. Weitere Einzelheiten enthält der Blogbeitrag [IBM MobileFirst Platform Foundation Support for iOS 11 and iPhone X](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/).

##### **<span style="color:NAVY">Unterstützung für Android Oreo</span>**

Beginnend mit dem CD-Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* wird mit diesem [Blogbeitrag](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/) für die Mobile Foundation die Untertsützung für Android Oreo angekündigt. Sowohl native Android-Apps als auch Hybrid-Cordova-Apps, die für ältere Versionen von Android erstellt wurden, funktionieren unter Android Oreo wie erwartet, wenn das Gerät mittels OTA (Over-the-Air-Update) aktualisiert wird.

##### <span style="color:NAVY">**Implementierung der Mobile Foundation in Kubernetes-Clustern möglich**</span>

Ab dem CD-Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01* kann der Benutzer die Mobile Foundation (einschließlich Mobile Foundation Server, Mobile Analytics Server und Application Center) in Kubernetes-Clustern implementieren. Das Implementierungspaket wurde aktualisiert, sodass jetzt eine Kubernetes-Implementierung unterstützt wird. Lesen Sie hierzu die entsprechende [Ankündigung](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/).
