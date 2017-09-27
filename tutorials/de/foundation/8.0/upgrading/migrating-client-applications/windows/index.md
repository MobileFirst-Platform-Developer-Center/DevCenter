---
layout: tutorial
title: Vorhandene Windows-Anwendungen umstellen
breadcrumb_title: Windows
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie ein mit der
IBM MobileFirst Platform Foundation ab Version 6.2.0
erstelltes natives Windows-Projekt migrieren möchten, müssen Sie das Projekt so modifizieren, dass es das SDK der aktuellen Version verwendet. Ersetzen Sie
dann die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. Das Unterstützungstool für die
Migration kann Ihren Code scannen und Berichte zu den zu ersetzenden APIs generieren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Vorhandene
native {{ site.data.keys.product_adj }}-Windows-Apps in Vorbereitung eines Versionsupgrades scannen](#scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade)
* [Windows-Projekt umstellen](#migrating-a-windows-project)
* [Windows-Code aktualisieren](#updating-the-windows-code)

## Vorhandene native {{ site.data.keys.product_adj }}-Windows-Apps in Vorbereitung eines Versionsupgrades scannen
{: #scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade }
Das Unterstützungstool für die Migration hilft Ihnen, Ihre
mit einer früheren Version
der IBM MobileFirst Platform Foundation
erstellten Apps vorzubereiten, indem es die Quellen der nativen Windows-App scannt und einen Bericht der in Version
8.0 weggefallenen oder nicht weiter unterstützten APIs generiert. 

Die folgenden Informationen müssen vor Verwendung des Unterstützungstools für die Migration beachtet werden: 

* Sie benötigen eine mit der
IBM MobileFirst Platform Foundation erstellte, native Windows-Anwendung. 
* Sie benötigen Internetzugriff. 
* Node.js ab Version 4.0.0 muss installiert sein. 
* Sie müssen die Einschränkungen des Migrationsprozesses kennen und verstehen. Weitere Informationen
finden Sie unter
[Apps früherer Releases umstellen](../).

Mit früheren Versionen der IBM MobileFirst Platform Foundation
erstellte Apps müssen geändert werden, damit sie in  Version 8.0 unterstützt werden. Das Unterstützungstool für die Migration vereinfacht diesen Änderungsprozess, indem es die Quellendateien der vorhandenen
nativen Windows-App scannt und APIs identifiziert, die in Version 8.0 weggefallen sind oder nicht weiter unterstützt werden bzw. modifiziert wurden. 

Das Unterstützungstool für die Migration modifiziert oder verschiebt keinen Entwicklercode und keine Kommentare Ihrer App. 

1. Wählen Sie eine der folgenden Alternativen, um das Unterstützungstool für die Migration herunterzuladen: 
    * Laden Sie die .tgz-Datei aus dem [Git-Repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli) herunter.
    * Laden Sie das {{ site.data.keys.mf_dev_kit }} über die {{ site.data.keys.mf_console }} herunter. Das Kit enthält die Datei mfpmigrate-cli.tgz mit dem Unterstützungstool für die Migration.
2. Installieren Sie das Unterstützungstool für die Migration. 
    * Navigieren Sie zu dem Verzeichnis, in das Sie das Tool heruntergeladen haben. 
    * Installieren Sie das Tool mit npm. Geben Sie dazu den folgenden Befehl ein: 

   ```bash
   npm install -g
   ```

3. Scannen Sie die mit der IBM MobileFirst Platform Foundation erstellte App. Geben Sie dazu
den folgenden Befehl ein: 

   ```bash
   mfpmigrate scan --in Quellenverzeichnis --out Zielverzeichnis --type windows
   ```

   **Quellenverzeichnis**  
Aktuelle Position des Projekts

   **Zielverzeichnis**  
Verzeichnis, in dem der Bericht erstellt wird

   Wenn der Scanbefehl des Unterstützungstools für die Migration verwendet wird, identifiziert das Tool APIs in der vorhandenen, mit der
IBM MobileFirst Platform Foundation erstellten App,
die in Version 8.0 gelöscht oder geändert wurden oder nicht weiter unterstützt werden und speichert sie im angegebenen Zielverzeichnis. 

## Windows-Projekt umstellen
{: #migrating-a-windows-project }
Wenn Sie ein mit der
IBM MobileFirst Platform Foundation ab Version 6.2.0
erstelltes natives Windows-Projekt verwenden möchten, müssen Sie das Projekt modifizieren. 

MobileFirst Version 8.0
unterstützt nur universelle Windows-Umgebungen, d. h. Windows 10 UWP (universelle Windows-Plattform) und
Windows 8 Universal (Desktop und Phone). Windows Phone 8 Silverlight wird nicht unterstützt. 

Sie können für Ihr Visual-Studio-Projekt ein manuelles Upgrade auf
Version 8.0 durchführen.
In
{{ site.data.keys.product_adj }} Version 8.0
gibt es eine Reihe von Änderungen am Visual-Studio-SDK, durch die Änderungen an Apps erforderlich sein können, die mit früheren Versionen entwickelt wurden. Informationen zu den geänderten APIs finden Sie
unter [Windows-Code aktualisieren](#updating-the-windows-code). 

1. Bringen Sie Ihr {{ site.data.keys.product_adj }}-SDK auf den
Stand von Version 8.0.
    * Entfernen Sie die Pakete des MobileFirst-SDK manuell. Dazu gehören auch die Datei **wlclient.properties** und folgende Referenzen:

        * Newtonsoft.Json
        * SharpCompress
        * worklight-windows8

        > **Hinweis:** Wenn Ihre App das Feature für Anwendungsauthentizität oder erweiterte Authentizität verwendet,
müssen Sie das
Microsoft Visual C++ 2013 Runtime-Paket für Windows oder das Microsoft
Visual C++ 2013 Runtime-Paket für Windows Phone als Referenz zu Ihrer App hinzufügen. Klicken Sie dazu
in
Visual Studio mit der rechten Maustaste auf die Referenzen Ihres nativen Projekts und führen Sie
abhängig von der Umgebung, die Sie zu Ihrer nativen API-App hinzugefügt haben, einen der folgenden Schritte aus:         * Windows-Desktops und -Tablets: Klicken Sie mit der rechten Maustaste auf
**Referenzen** und wählen Sie **Referenz hinzufügen → Windows 8.1 → Erweiterungen → Microsoft Visual C++ 2013 Runtime Package for Windows → OK** aus.
        * Windows Phone 8 Universal: Klicken Sie mit der rechten Maustaste auf
**Referenzen** und wählen Sie **Referenz hinzufügen → Windows 8.1 → Erweiterungen → Microsoft Visual C++ 2013 Runtime Package for Windows Phone → OK** aus.
        * Windows 10 UWP (universelle Windows-Plattform): Klicken Sie mit der rechten Maustaste auf
**Referenzen** und wählen Sie **Referenz hinzufügen → Windows 8.1 → Erweiterungen → Microsoft Visual C++ 2013 Runtime Package for Windows Universal → OK** aus.
    * Fügen Sie mit NuGet die SDK-Pakete für {{ site.data.keys.product_adj }} Version 8.0.0 hinzu (siehe
[{{ site.data.keys.product_adj }}-SDK mit NuGet hinzufügen](../../../application-development/sdk/windows-8-10)).
2. Aktualisieren Sie Ihren Anwendungscode so, dass er {{ site.data.keys.product_adj }}-APIs von
Version 8.0.0 verwendet. 
    * In früheren Releases waren die Windows-APIs Teil von
**IBM.Worklight.namespace**. Diese APIs sind veraltet und wurden durch die äquivalente API
**WorklightNamespace** ersetzt. Sie müssen die App modifizieren. Ersetzen Sie alle Verweise auf
**IBM.Worklight.namespace** durch das Äquivalent in
**WorklightNamespace**.

   Das folgende Snippet ist ein Beispiel für die bisherige Verwendung:


   ```csharp
   WLResourceRequest request = new WLResourceRequest
                            (new Uri(uriBuilder.ToString()), "GET", "accessRestricted");
                            request.send(listener);
   ```

   Das mit der neuen API aktualisierte Snippet würde wie folgt aussehen:

   ```csharp
   WorklightResourceRequest request = newClient.ResourceRequest
                            (new Uri(uriBuilder.ToString(), UriKind.Relative), "GET", "accessRestricted");
                            WorklightResponse response = await request.Send();
   ```

    * Alle Methoden, die asynchrone Operationen ausgeführt haben, verwendeten bisher ein Callback-Modell für Antwortlistener, das durch das Modell **await/async** ersetzt wurde.

Jetzt können Sie mit dem Entwickeln Ihrer nativen Windows-Anwendung mit dem SDK der {{ site.data.keys.product_adj }} beginnen. Möglicherweise müssen Sie Ihren Code aktualisieren, sodass er die Änderungen der {{ site.data.keys.product_adj }}-API von Version 8.0.0 widerspiegelt.

#### Nächste Schritte
{: #what-to-do-next }
Ersetzen Sie die clientseitigen APIs, die weggefallen oder nicht in Version 8.0 enthalten sind. 

## Windows-Code aktualisieren
{: #updating-the-windows-code }
In
{{ site.data.keys.product }} Version 8.0
gibt es eine Reihe von Änderungen am Windows-SDK, durch die Änderungen an Apps erforderlich sein können, die mit früheren Versionen entwickelt wurden. 

#### Nicht weiter verwendete Windows-C#-API-Klassen
{: #deprecated-windows-c-api-classes }

| Kategorie | Beschreibung | Empfohlene Aktion |
|----------|-------------|--------------------|
| `ChallengeHandler`  | Verwenden Sie für angepasste Gateway-Abfragen `GatewayChallengeHandler`. Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`. |
| `ChallengeHandler`, `isCustomResponse()`  | Verwenden Sie `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler `GatewayChallengeHandler`. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`. |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | Verwenden Se für angepasste Abfrage-Handler `GatewayChallengeHandler.Shouldcancel()`. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler.ShouldCancel()`. |
| `WLAuthorizationManager` | Verwenden Sie stattdessen `WorklightClient.WorklightAuthorizationManager`. |
| `WLChallengeHandler` | Verwenden Sie `SecurityCheckChallengeHandler`. |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)`  |	Verwenden Sie `SecurityCheckChallengeHandler.ShouldCancel()`.|
| `WLClient` | 	Verwenden Sie stattdessen `WorklightClient`. |
| `WLErrorCode` | 	Nicht unterstützt |
| `WLFailResponse` | 	Verwenden Sie stattdessen `WorklightResponse`. |
| `WLResponse` | Verwenden Sie stattdessen `WorklightResponse`. |
| `WLProcedureInvocationData` | Verwenden Sie stattdessen `WorklightProcedureInvocationData`. |
| `WLProcedureInvocationFailResponse` | 	Nicht unterstützt |
| `WLProcedureInvocationResult` | 	Nicht unterstützt |
| `WLRequestOptions` | 	Nicht unterstützt |
| `WLResourceRequest` | 	Verwenden Sie stattdessen `WorklightResourceRequest`. |

#### Nicht weiter verwendete Windows-C#-API-Schnittstellen
{: #deprecated-windows-c-api-interfaces }

| Kategorie | Beschreibung | Empfohlene Aktion |
|----------|-------------|--------------------|
| `WLHttpResponseListener` | Nicht unterstützt |
| `WLResponseListener` | Die Antwort ist als ein `WorklightResponse`-Objekt verfügbar. |
| `WLAuthorizationPersistencePolicy` | Nicht unterstützt |
