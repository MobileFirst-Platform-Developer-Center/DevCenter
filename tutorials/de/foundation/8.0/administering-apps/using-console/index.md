---
layout: tutorial
title: Anwendungen in der MobileFirst Operations Console verwalten
breadcrumb_title: Verwaltung in der Konsole
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können {{ site.data.keys.product_adj }}-Anwendungen in der
{{ site.data.keys.mf_console }} verwalten, indem Sie
Apps sperren oder den Zugriff auf Apps verweigern und Benachrichtigungen anzeigen. 

Sie können die Konsole durch Eingabe einer der folgenden URLs starten:

* Sicherer Modus für Produktion oder Tests: `https://Hostname:sicherer_Port/mfpconsole`
* Entwicklung: `http://server_name:port/mfpconsole`

Ihr Benutzername und das zugehörige Kennwort müssen Sie berechtigen,
auf die {{ site.data.keys.mf_console }} zuzugreifen. Weiere Informationen finden Sie unter
[Benutzerauthentifizierung
für die MobileFirst-Server-Verwaltung konfigurieren](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

Sie können Ihre Anwendungen auch über die
{{ site.data.keys.mf_console }}
verwalten. 

Von der {{ site.data.keys.mf_console }} aus haben Sie auch Zugriff auf die
Analytics-Konsole und können die Sammlung mobiler Daten für die Analyse durch den
Analytics-Server steuern. Weitere Informationen finden Sie unter
[Datenerfassung in der {{ site.data.keys.mf_console }} aktivieren und inaktivieren](../../analytics/console/#enabledisable-analytics-support).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Mobile Anwendungen verwalten](#mobile-application-management)
* [Anwendungsstatus und Tokenlizenzierung](#application-status-and-token-licensing)
* [Fehlerprotokoll für Operationen in Laufzeitumgebungen](#error-log-of-operations-on-runtime-environments)
* [Prüfprotokoll für Verwaltungsoperationen](#audit-log-of-administration-operations)

## Mobile Anwendungen verwalten
{: #mobile-application-management }
Die {{ site.data.keys.product_adj }}-Funktionen für die Verwaltung mobiler Anwendungen
ermöglichen Benutzern und Administratoren von {{ site.data.keys.mf_server }} eine detaillierte
Steuerung des Benutzer- und Gerätezugriffs auf Anwendungen. 

{{ site.data.keys.mf_server }} verfolgt alle Versuche, auf Ihre mobile Infrastruktur zuzugreifen,
und speichert Informationen zur Anwendung, zu dem Benutzer und zu dem Gerät, auf dem die Anwendung installiert ist. Die Zuordnung von Anwendung, Benutzer, und Gerät bildet die Basis für die Serverunktionen zur Verwaltung
mobiler Anwendungen. 

Verwenden Sie die IBM {{ site.data.keys.mf_console }} wie folgt für die Überwachung und Verwaltung des Zugriffs auf Ihre
Ressourcen: 

* Suchen Sie über den Namen nach einem Benutzer und zeigen Sie Informationen zu den Geräten und Anwendungen an, die der Benutzer für den Zugriff auf Ihre Ressourcen
verwendet. 
* Suchen Sie über den Anzeigenamen nach einem Gerät und zeigen Sie die dem Gerät zugeordneten Benutzer an
sowie die registrierten
{{ site.data.keys.product_adj }}-Anwendungen, die auf diesem Gerät
verwendet werden. 
* Blockieren Sie den Zugriff auf Ihre Ressourcen für alle Instanzen Ihrer Anwendungen auf einem bestimmten Gerät. Dies ist hilfreich, wenn ein Gerät verlorengeht oder gestohlen wird. 
* Blockieren Sie den Zugriff auf Ihre Ressourcen für eine bestimmte Anwendung auf einem bestimmten Gerät. Wenn ein Mitarbeiter beispielsweise die Abteilung wechselt, können Sie den Zugriff
dieses Mitarbeiters für eine Anwendung der bisherigen Abteilung blockieren, den Zugriff des Mitarbeiters mit anderen Anwendungen auf demselben Gerät jedoch erlauben. 
* Heben Sie die Registrierung eines Gerätes auf und löschen Sie die Registrierung sowie alle für das Gerät gesammelten Überwachungsdaten. 

Für die Blockierung des Zugriffs gilt Folgendes: 

* Die Blockierung ist reversibel. Sie können die Blockierung aufheben, indem Sie in der
{{ site.data.keys.mf_console }} den Geräte- oder Anwendungsstatus ändern.
* Die Blockierung gilt nur für geschützte Ressourcen. Ein blockierter Client kann die Anwendung weiter für den Zugriff auf nicht geschützte Ressourcen
nutzen (siehe
"Ungeschützte Ressourcen").
* Wenn Sie eine Blockierungsoperation auswählen, wird sofort der Zugriff auf Adapterresourcen von
{{ site.data.keys.mf_server }} blockiert. Für Ressourcen eines externen Serverts trifft dies möglicherweise nicht zu, wenn die Anwendung
noch immer über ein gültiges (nicht abgelaufenes) Zugriffstoken verfügt. 

### Gerätestatus
{: #device-status }
{{ site.data.keys.mf_server }} verwaltet Statusinformationen zu jedem Gerät,
das auf den Server zugreift. Gültige Statuswerte sind
**Aktiv**, **Verloren**, **Gestolen**, **Abgelaufen** und
**Inaktiviert**. 

Der Standardgerätestatus is t
**Aktiv**. Er gibt an, dass der Zugriff von diesem Gerät nicht blockiert ist. Sie können den Status
in **Verloren**, **Gestohlen** oder
**Inaktiviert** ändern, um den Zugriff des Geräts auf Ihre Anwendungsressourcen zu blockieren. Es ist jederzeit möglich,
den Status wieder auf **Aktiv** zurückzusetzen, wenn Sie den Zugriff wieder erlauben möchten
(siehe
[Greätezugriff in der
{{ site.data.keys.mf_console }} verwalten](#managing-device-access-in-mobilefirst-operations-console)).

Der Status
**Abgelaufen** ist ein besonderer Status, den
{{ site.data.keys.mf_server }} nach Ablauf einer vorkonfigurierten
Inaktivitätszeit seit der letzten Verbindung des Geräts zu dieser Serverinstanz festlegt. Dieser Status wird für die Lizenzüberwachung genutzt und hat keinen Einfluss
auf die Zugriffsrechte des Gerätes. Wenn ein Gerät mit dem Status **Abgelaufen** wieder eine Verbindung zum Server herstellt, wird
der Gerätestatus wieder auf **Aktiv** gesetzt, um den Gerät den Zugriff auf den Server zu ermöglichen. 

### Anzeigename von Geräten
{: #device-display-name }
{{ site.data.keys.mf_server }} identifiziert Geräte über eine eindeutige,
vom {{ site.data.keys.product_adj }}-Client-SDK zugewiesene Geräte-ID. Wenn Sie einen Anzeigenamen für ein Gerät festlegen, kann über diesen Namen nach dem Gerät
gesucht werden. Anwendungsentwickler können die Methode `setDeviceDisplayName` der Klasse
`WLClient` nutzen, um den Anzeigenamen des Geräts festzulegen. Lesen Sie hierzu die Beschreibung zu `WLClient` unter
[Clientseitige {{ site.data.keys.product_adj }}-API](../../api/client-side-api/javascript/client/). (Die JavaScript-Klasse ist `WL.Client`.) Entwickler von Java-Adaptern (und Sicherheitsüberprüfungen) können den
Anzeigenamen von Geräten mit der Methode `setDeviceDisplayName` der `MobileDeviceData`-Klasse
com.ibm.mfp.server.registration.external.model festlegen (siehe
[MobileDeviceData](../../api/client-side-api/objc/client/)).

### Gerätezugriff in der
{{ site.data.keys.mf_console }} verwalten
{: #managing-device-access-in-mobilefirst-operations-console }
Wählen Sie für die Überwachung und Verwaltung
des Gerätezugriffs auf Ihre Ressourcen im Dashboard der
{{ site.data.keys.mf_console }} das Register Geräte aus. 

Suchen Sie nach einem Gerät, in dem Sie im Suchfeld
die dem Gerät zugeordnete Benutzer-ID oder (sofern definiert) den Anzeigenamen des Geräts eingeben (siehe [Anzeigename von Geräten](#device-display-name)).
Sie können auch nach einem Teil der Benutzer-ID oder des Anzeigenamens des Geräts suchen. (Geben Sie mindestens drei Zeichen ein.) 

Als Suchergebnis werden alle Geräte angezeigt, die mit der angegebenen Benutzer-ID oder dem
angegebenen Anzeigenamen übereinstimmen. Für jedes Gerät sehen Sie die Geräte-ID und den Anzeigenamen, das Gerätemodell, das Betriebssystem sowie eine Liste mit Benutzer-IDs, die dem
Gerät zugeordnet sind. 

In der Spalte Gerätestatus wird der Status der Geräte angezeigt. Sie können den Status
des Geräts in **Verloren**, **Gestohlen** oder
**Inaktiviert** ändern, um den Zugriff des Geräts auf geschützte Ressourcen zu blockieren. Wenn Sie den Status wieder auf
**Aktiv** setzen, werden die ursprünglichen Zugriffsrechte wiederhergestellt. 

Sie können die Registrierung eines Geräts aufheben, indem Sie in der
Spalte **Aktionen** den Eintrag **Registrierung aufheben** auswählen.
Mit dem Aufheben der Registrierung eines Geräts werden alle Registrierungsdaten für
alle auf dem Gerät installierten
{{ site.data.keys.product_adj }}-Anwendungen
gelöscht. Außerdem werden der Anzeigename, die dem Gerät zugeorndete Liste von Benutzern und die öffentlichen Attribute, die die Anwendung für dieses Gerät registriert hat,
gelöscht. 

**Hinweis:** Die Aktion **Registrierung aufheben** kann nicht rückgängig gemacht werden. Versucht eine der {{ site.data.keys.product_adj }}-Anwendungen
danach, auf den Server zuzugreifen, wird sie erneut, mit einer neuen Geräte-ID registriert. Wenn Sie das Gerät erneut registrieren, wird der Gerätestatus
auf **Aktiv** gesetzt, sodass das Gerät unabhängig davon, ob es vorher Zugriffsblockierungen gab oder nicht, Zugriff auf geschützte Ressourcen hat. Wenn Sie ein Gerät blockieren möchten, dürfen Sie daher nicht die Registrierung für dieses
Gerät aufheben. Ändern Sie stattdessen den Gerätestatus in **Verloren**, **Gestohlen** oder
**Inaktiviert**.

Wenn Sie alle Anwendungen sehen möchten, auf die auf einem bestimmten Gerät zugegriffen wurde, wählen Sie in der Gerätetabelle neben der Geräte-ID den Pfeil zum Einblenden aus. Jede Zeile der angezeigten Anwendungstabelle
enthält den Namen der Anwendung und den Zugriffsstatus der Anwendung (d. h. die Angabe, ob der Zugriff auf geschützte Ressourcen für diese Anwendung auf diesem Gerät
aktiviert ist). Sie können den Status der Anwendung auf
**Inakiviert** setzen, um den Zugriff der Anwendung auf diesem konkreten Gerät zu blockieren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-1 }

* [Anwendungszugriff auf geschützte Ressourcen über Fernzugriff inaktivieren](#remotely-disabling-application-access-to-protected-resources)
* [Administratornachricht anzeigen](#displaying-an-administrator-message)
* [Administratornachrichten in mehreren Sprachen definieren](#defining-administrator-messages-in-multiple-languages)

### Anwendungszugriff auf geschützte Ressourcen über Fernzugriff inaktivieren
{: #remotely-disabling-application-access-to-protected-resources }
In der {{ site.data.keys.mf_console }} können Sie
den Benutzerzugriff auf eine bestimmte Version einer Anwendung unter einem bestimmten Betriebssystem für mobile Geräte inaktivieren und für den Benutzer eine
entsprechende Nachricht bereitstellen. 

1. Wählen Sie in der Navigationsseitenleiste der Konsole im Abschnitt **Anwendungen** Ihre Anwendungsversion aus. Wählen Sie dann das Register
**Anwendungsmanagement** aus. 
2. Ändern Sie den Status in **Zugriff inaktiviert**.
3. Im Feld **URL der neuesten Version** können Sie eine URL für eine neuere Version der Anwendung
angeben (die sich in der Regel im entsprechenden pffentlichen oder privaten App Store befindet). In einigen Umgebungen stellt
das Application Center eine URL für den direkten Zugriff auf die Detailansicht einer Anwendungsversion
bereit (siehe [Anwendungseigenschaften](../../appcenter/appcenter-console/#application-properties)).
4. Fügen Sie im Feld **Standardbenachrichtigung** die angepasste Benachrichtigung hinzu, die angezeigt werden soll, wenn der Benutzer versucht,
auf die Anwendung zuzugreifen. Die folgende Beispielnachricht weist den Benutzer an, ein Upgrade auf die neueste Version durchzuführen:


   ```bash
   Diese Version wird nicht mehr unterstützt. Führen Sie ein Upgrade auf die neueste Version durch.
   ```

5. Im Abschnitt **Unterstützte Ländereinstellungen** können Sie die Benachrichtigung auch in anderen Sprachen
angeben.

6. Klicken Sie auf
**Speichern**, um Ihre Änderungen anzuwenden. 

Wenn ein Benutzer eine über Fernzugriff inaktivierte Anwendung ausführen möchte, wird ein Dialogfenster mit Ihrer angepassten Nachricht angezeigt. Die Nachricht wird für jede Anwendungsinteraktion angezeigt, die Zugriff auf eine geschützte
Ressource erfordert, sowie bei jedem Versuch der Anwendung, ein Zugriffstoken anzufordern. Wenn Sie eine URL für ein Versionsupgrade angegeben haben,
gibt es in dem Dialogfenster zusätzlich zur Schaltfläche **Schließen** eine Schaltfläche **Neue
Version abrufen**, um ein Upgrade auf eine neuere Version durchzuführen. Schließt der Benutzer das Dialogfenster, ohne ein Versionsupgrade durchzuführen, kann
er die Teile der Anwendung, die keinen Zugriff auf geschützte Ressourcen erfordern, weiter verwenden. Anwendungsinteraktionen, die den Zugriff auf eine geschützte
Ressource erfordern, bewirken allerdings, dass das Dialogfenster wieder angezeigt wird. Die Anwendung erhält keinen Zugriff auf die Ressource. 

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### Administratornachricht anzeigen
{: #displaying-an-administrator-message }
Folgen Sie zum Konfigurieren der Benachrichtigung der beschriebenen Prozedur. Mit einer solchen Nachricht können
Sie Anwendungsbenutzer über temporäre Situationen, z. B. eine geplante Serviceausfallzeit, benachrichtigen.

1. Wählen Sie in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen** Ihre Anwendungsversion aus. Wählen Sie dann das Register
**Anwendungsmanagement** aus. 
2. Ändern Sie den Status in **Aktiv und Benachrichtigung**.
3. Fügen Sie eine angepasste Startnachricht hinzu. Die folgende Beispielnachricht informiert den Benutzer über eine geplante Anwendungswartung:


   ```bash
   Der Server wird wegen einer geplanten Wartung am Samstag zwischen 4.00 und 16.00 Uhr nicht verfügbar sein.
   ```

4. Im Abschnitt Unterstützte Ländereinstellungen können Sie die Benachrichtigung auch in anderen Sprachen
angeben.


5. Klicken Sie auf
**Speichern**, um Ihre Änderungen anzuwenden. 

Die Nachricht wird angezeigt,
wenn die Anwendung zum ersten Mal {{ site.data.keys.mf_server }} für den Zugriff auf eine geschützte Ressource nutzt
oder ein Zugriffstoken anfordert. Wenn die Anwendung beim Start ein Zugriffstoken anfordert, wird die Nachricht angezeigt. Andernfalls wird die Nachricht angezeigt, wenn die Nachricht das erste Mal den Zugriff auf eine
geschützte Ressource oder ein Zugriffstoken anfordert. Die Nachricht wird nur einmal bei der ersten Interaktion angezeigt. 

### Administratornachrichten in mehreren Sprachen definieren
{: #defining-administrator-messages-in-multiple-languages }
<b>Hinweis:</b> In Microsoft Internet Explorer (IE) und Microsoft Edge werden
Verwaltungsnachrichten
entsprechend den Regions- und Formatvorgaben des Betriebssystems
und nicht gemäß den konfigurierten Vorgaben für die Anzeigesprache des Browsers oder Betriebssystems angezeigt
(siehe [Einschränkungen für IE- und Edge-Webanwendungen](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge)). Folgen Sie der beschriebenen Konfigurationsprozedur für die Anzeige der in der
Konsole definierten Anwendungsverwaltungsnachrichten in mehreren Sprachen. Die Nachrichten werden
ausgehend von der Ländereinstellung des Gerätes gesendet und müssen den Standards entsprechen, die das Betriebssystem für mobile Geräte für die Angabe länderspezifischer Angaben anwendet. 

1. Wählen Sie in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen** Ihre Anwendungsversion aus. Wählen Sie dann das Register
**Anwendungsmanagement** aus. 
2. Wählen Sie den Status **Aktiv und Benachrichtigung** oder
**Zugriff inaktiviert** aus.
3. Wählen Sie **Ländereinstellungen aktualisieren** aus.Wählen Sie in dem daraufhin angezeigten Dialog im Abschnitt **Datei hochladen** die Option **Hochladen** aus. Navigieren Sie zur Position einer CSV-Datei, in der
die Ländereinstellungen definiert sind.


   Jede Zeile der CSV-Datei enthält zwei Zeichenfolgen, die durch ein Komma getrennt sind. Die erste Zeichenfolge ist der
Code für die Ländereinstellung, z. B. fr-FR für Französisch (Frankreich) oder
en für Englisch, und die zweite Zeichenfolge ist der Nachrichtentext in der entsprechenden Sprache. Die angegebenen Codes für die Ländereinstellung müssen den Standards entsprechen, die das Betriebssystem für mobile Geräte für die Angabe länderspezifischer Einstellungen anwendet, z. B. ISO 639-1, ISO 3166-2 und ISO 15924.

   > **Hinweis:** Zum Erstellen der CSV-Datei müssen Sie einen Editor verwenden, der die UTF-8-Codierung unterstützt, z. B. den Windows-Editor.

   In der nachfolgenden CSV-Datei ist eine Nachricht für mehrere
Ländereinstellungen definiert.


   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. Im Abschnitt **Benachrichtigungen überprüfen** sehen Sie eine Tabelle mit den Codes für die Ländereinstellung und Nachrichten aus Ihrer
CSV-Datei. Überprüfen Sie die Nachrichten und klicken Sie auf
**OK**. Sie können jederzeit auf Bearbeiten klicken, um die CSV-Datei mit den Ländereinstellungen
zu ersetzen. Über diese Option können Sie auch eine leere CSV-Datei hochladen, um alle Ländereinstellungen zu entfernen. 
5. Klicken Sie auf
**Speichern**, um Ihre Änderungen anzuwenden. 

Auf dem mobilen Gerät des Benutzers wird die Benachrichtigung gemäß der Ländereinstellung des Gerätes angezeigt. Wenn für die Ländereinstellung des Gerätes keine Nachricht konfiguriert ist, wird die
von Ihnen angegebene Standardnachricht angezeigt. 

## Anwendungsstatus und Tokenlizenzierung
{: #application-status-and-token-licensing }
Wenn in der
{{ site.data.keys.mf_console }} angezeigt wird, dass eine Anwendung
den Status Blockiert hat, weil die Anzahl der Token unzureichend ist, müssen Sie den korrekten Anwendungsstatus manuell wiederherstellen. 

Wenn Sie mit der Tokenlizenzierung arbeiten und nicht mehr genug Token für eine Anwendung vorhanden sind, ändert sich der Status aller Versionen der Anwendung in
**Blockiert**. Sie können den Status der Anwendung nicht mehr ändern. Dies gilt für alle Versionen der Anwendung.
In der {{ site.data.keys.mf_console }} wird die folgende Nachricht angezeigt:

```bash
Die Anwendung wurde blockiert, weil die Lizenz abgelaufen ist.
```

Wenn später Token für die Ausführung der Anwendung freigegeben werden oder Ihre Anwendung mehr Token kauft, erscheint in der
{{ site.data.keys.mf_console }} die folgende Nachricht:

```bash
Die Anwendung wurde blockiert, weil die Lizenz abgelaufen ist. Jetzt ist jedoch eine Lizenz verfügbar.
```

Es wird weiterhin der Status **Blockiert** angezeigt. Sie müssen den Status manuell aus dem Gedächtnis oder aus Ihren eigenen Aufzeichnungen
wiederherstellen. Bearbeiten Sie dazu das Feld
Status. Die {{ site.data.keys.product }} verwaltet nicht die Anzeige des
Status **Blockiert** in der {{ site.data.keys.mf_console }} für eine Anwendung, die wegen unzureichender
Linzenztoken blockiert wurde.
Sie sind dafür verantwortlich, für eine so blockierte Anwendung einen realen Status wiederherzustellen,
der in der {{ site.data.keys.mf_console }} angezeigt werden kann.

## Fehlerprotokoll für Operationen in Laufzeitumgebungen
{: #error-log-of-operations-on-runtime-environments }
Über das Fehlerprotokoll haben Sie Zugriff auf fehlgeschlagene Verwaltungsoperationen, die von der
{{ site.data.keys.mf_console }} oder der Befehlszeile der ausgewählten Laufzeitumgebung
ausgelöst wurden. Im Protokoll sehen Sie auch die Auswirkung des Fehlers auf die Server. 

Wenn eine Transaktion fehlschlägt, werden in der Statusleiste eine Fehlerbenachrichtigung und ein Link zum Fehlerprotokoll angezeigt. Im Fehlerprotokoll finden Sie weitere
Details zum Fehler, z. B. den Status der einzelnen Server mit einer konkreten Fehlernachricht oder einen Fehlerverlauf.
Im Fehlerprotokoll wird die zuletzt ausgeführte Operation als erste angezeigt. 

Klicken Sie in der {{ site.data.keys.mf_console }} für eine Laufzeitumgebung auf
**Fehlerprotokoll**, um auf das Fehlerprotokoll zuzugreifen.

Erweitern Sie die Anzeige für die Zeile, die sich auf die fehlgeschlagene Operation bezieht, um weitere
Informationen zum aktuellen Zustand der einzelnen Server aufzurufen. Wenn Sie auf das vollständige Protokoll zugreifen möchten, laden
Sie das Protokoll herunter. Klicken Sie dazu auf **Protokoll herunterladen**.

![Fehlerprotokoll in der Konsole](error-log.png)

## Prüfprotokoll für Verwaltungsoperationen
{: #audit-log-of-administration-operations }
In der {{ site.data.keys.mf_console }} finden Sie ein
Prüfprotokoll für Verwaltungsoperationen.

Die {{ site.data.keys.mf_console }} ermöglicht den Zugriff auf ein
Prüfprotokoll für Anmeldung, Abmeldung und alle Verwaltungsoperationen, z. B. die Implementierung von Apps oder Adaptern oder das Sperren von Apps. Sie können das
Prüfprotokoll inaktivieren, indem Sie die JNDI-Eigenschaft **mfp.admin.audit** für die
Webanwendung in den {{ site.data.keys.product_adj }}-Verwaltungsservices
(worklightadmin.war) auf **false** setzen.

Klicken Sie für den Zugriff auf das Prüfprotokoll in der Titelleiste auf den Benutzernamen
und wählen Sie **Produktinfo** aus. Klicken Sie auf **Zusätzliche Supportinformationen** und dann auf
**Prüfprotokoll herunterladen**.


| Feldname | Beschreibung |
|------------|-------------|
| Timestamp	 | Datum und Zeit der Erstellung des Eintrags |
| Type	     | Typ der Operation (siehe folgende Liste der Operationstypen für gültige Werte) |
| User	     | Benutzername (**username**) des angemeldeten Benutzers |
| Outcome	 | Ergebnis der Operation (gültige Werte: SUCCESS, ERROR, PENDING) |
| ErrorCode	 | Wenn das Ergebnis ERROR lautet, gibt ErrorCode den genauen Fehler an. |
| Runtime	 | Name des mit der Operation verbundenen {{ site.data.keys.product_adj }}-Projekts |

In der folgenden Liste finden Sie die gültigen Werte für
den Operationstyp (im Feld Type).

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime
