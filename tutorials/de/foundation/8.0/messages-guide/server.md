---
layout: tutorial
title: MobileFirst-Server-, Laufzeit- und Konsolennachrichten
breadcrumb_title: Foundation Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Übersicht
{: #overview }
Hier finden Sie Informationen, die Ihnen beim Lösen von Problemen helfen, die mit Mobile Foundation Server auftreten können.

## Mobile-Foundation-Laufzeitnachrichten
{: #mfp-runtime-error-codes }
**Präfix:** FWLSE<br/>
**Bereich:** 0000-0012

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE0000E** | *AuthorizationGrant {0} konnte nicht in TransientStorage gespeichert werden.* |
| **FWLSE0001E** | *Fehler beim Abrufen des Clients {0}.* |
| **FWLSE0002E** | *Ungültige Anforderung; fehlende oder ungültige Parameter: {0}.* |
| **FWLSE0003E** | *Nicht unterstützter Grant-Typ {0}.* |
| **FWLSE0004E** | *RedirectUri wurde an den Autorisierungsendpunkt {0} übergeben, jedoch nicht an den Tokenendpunkt.* |
| **FWLSE0005E** | *RedirectUri-Konflikt. Autorisierungsendpunkt: {0}, Tokenendpunkt: {1}* |
| **FWLSE0006E** | *Fehler beim Parsing des Grant-Codes in der Tokenanforderung: {0}.* |
| **FWLSE0007E** | *Die Validierung des Grant-Codes ist fehlgeschlagen. Der Grant-Code {0} wurde für Client-ID {1} bereitgestellt, jeoch von Client-ID {2} verwendet.* |
| **FWLSE0008E** | *Die Parsing-Aktion für das AccessToken ist mit einer Ausnahme fehlgeschlagen.* |
| **FWLSE0009E** | *Zugriffstoken kann nicht signiert werden.* |
| **FWLSE0010E** | *JWT kann nicht validiert werden; Fehler im Keystore des Servers.* |
| **FWLSE0011E** | *JWT kann nicht validiert werden ({0}).* |
| **FWLSE0012E** | *Client-JWT-Authentifizierung fehlgeschlagen; ungültige JTI.* |


### Java-Adapternachrichten

**Präfix:** FWLSE<br/>
**Bereich:** 0290-0299

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE0290E** | *JAX-RS-Anwendungsklasse {0} wurde nicht gefunden (oder kann nicht geladen werden). Stellen Sie sicher, dass der Klassenname in der XML-Datei des Adapters korrekt ist und dass die Klasse tatsächlich im Ordner 'bin' des Adapters oder in einer der JAR-Dateien im Ordner 'lib' des Adapters vorhanden ist.* |
| **FWLSE0291E** | *JAX-RS-Anwendungsklasse {0} kann nicht instanziiert werden. Stellen Sie sicher, dass die Klasse über einen öffentlichen Nullargumentkonstruktor verfügt. Wenn ein Konstruktor vorhanden ist, sehen Sie sich das Serverprotokoll an, um die eigentliche Ursache für den Fehler bei der Instanzerstellung festzustellen.* |
| **FWLSE0292E** | *Die JAX-RS-Anwendungsklasse {0} muss javax.ws.rs.Application erweitern.* |
| **FWLSE0293E** | *Die Adapterimplementierung ist fehlgeschlagen. Der Eigenschaftstyp {0} wird nicht unterstützt.* |
| **FWLSE0294E** | *Die Adapterimplementierung ist fehlgeschlagen. Der Wert {0} ist für den Typ {1} unzulässig.* |
| **FWLSE0295E** | *Die Implementierung der Adapterkonfiguration ist fehlgeschlagen. Die Eigenschaft {0} ist nicht im Adapter {1} definiert.* |
| **FWLSE0296E** | *Die Implementierung der Adapterkonfiguration ist fehlgeschlagen. Die Eigenschaft {0} ist für den Typ {1} ungültig.* |
| **FWLSE0297W** | *Für den Adapter {0} konnte keine Swagger-Dokumentation generiert werden.* |
| **FWLSE0298W** | *In der Prozedur {0} von Adapter {1} ist das Attribut 'connectAs' auf 'enduser' gesetzt. Dieses Feature wird nicht unterstützt.* |
| **FWLSE0299E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Die Eigenschaften {0} sind nicht vorhanden.* |


**Präfix:** FWLSE<br/>
**Bereich:** 0500-0506

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE0500E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Der Wert des Parameters {0} muss eine ganze Zahl sein.* |
| **FWLSE0501E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Der Parameter {0} muss einen positiven Wert haben.* |
| **FWLSE0502E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Der Wert des Parameters {0} iegt außerhalb des gültigen Bereichs.* |
| **FWLSE0503E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Der Parameter {0} muss einen booleschen Wert haben.* |
| **FWLSE0504E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. {0} muss http oder https sein.* |
| **FWLSE0505E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Die Cookierichtlinie {0} wird nicht unterstützt.* |
| **FWLSE0506E** | *Die Implementierung der Adapterkonnektivitätskonfiguration ist fehlgeschlagen. Der Wert des Parameters {0} muss eine Zeichenfolge sein.* |

### Registrierungsnachrichten

**Präfix:** FWLSE<br/>
**Bereich:** 4200-4229

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE4200E** | *Der Status der Geräteanwendung konnte nicht geändert werden.* |
| **FWLSE4201E** | *Der Gerätestatus konnte nicht geändert werden.* |
| **FWLSE4202E** | *Es konnten keine Geräte abgerufen werden.* |
| **FWLSE4203E** | *Das Gerät konnte nicht entfernt werden.* |
| **FWLSE4204E** | *Dem Gerät zugeordnete Clients konnten nicht abgerufen werden.* |
| **FWLSE4205E** | *getAll für pageInfo {0} fehlgeschlagen.* |
| **FWLSE4206E** | *GetByAttributes fehlgeschlagen.* |
| **FWLSE4207E** | *Die Daten konnten nicht in persistente Daten konvertiert werden.* |
| **FWLSE4208E** | *Der Client {0} konnte nicht gelesen werden.* |
| **FWLSE4209E** | *Der Anzeigename des Geräts konnte nicht aktualisiert werden.* |
| **FWLSE4210E** | *Die Signatur konnte nicht erstellt werden.* |
| **FWLSE4211E** | *Die Clientregistrierungsdaten konnten nicht gespeichert werden, da sie nicht ordnungsgemäß abgerufen wurden. Client-ID: {0}.* |
| **FWLSE4212E** | *Die Aktualisierung des Anzeigenamens ist für alle Geräteclients fehlgeschlagen.* |
| **FWLSE4213E** | *Client-JWT-Authentifizierung fehlgeschlagen; die öffentlichen Schlüssel stimmen nicht überein.* |
| **FWLSE4214E** | *Die Clientdaten sind null. Dies ist möglich, wenn die Clientdaten gerade eben archiviert (gelöscht) wurden.* |
| **FWLSE4215E** | *Nach mehreren vergeblichen Versuchen, auf die Konsole zuzugreifen, werden keine weiteren Versuche unternommen.* |
| **FWLSE4216E** | *GetDeviceClientsError für deviceId {0}.* |
| **FWLSE4217E** | *Fehler bei dem Versuch, Geräte mit pageStart {0} und pageSize {1} abzurufen.* |
| **FWLSE4218E** | *Fehler bei dem Versuch, Geräte für den Namen {0} mit pageStart {1} und pageSize {2} abzurufen.* |
| **FWLSE4219E** | *RemoveDeviceError für deviceId {0}.* |
| **FWLSE4220E** | *Für den Client {0} konnte kein Webschlüssel erstellt werden.* |
| **FWLSE4221E** | *Das Durchsuchen von Geräte ist mit pageInfo {0}, searchMethod {1} und Filter {2} fehlgeschlagen.* |
| **FWLSE4222E** | *Clientregistrierung fehlgeschlagen; ungültige Signatur.* |
| **FWLSE4223E** | *Clientregistrierung fehlgeschlagen; ungültige Anwendung. Fehler: {0}.* |
| **FWLSE4224E** | *Fehler beim Verarbeiten der Registrierungsanforderung.* |
| **FWLSE4225E** | *Ungültige Anforderung für eine Aktualisierung der Selbstregistrierung. Die Clientsignatur konnte nicht bestätigt werden.* |
| **FWLSE4226E** | *Fehler bei der App-Authentizität während der Registrierungsaktualisierung; Aktualisierung fehlgeschlagen ({0}).* |
| **FWLSE4227E** | *Die Registrierung konnte nicht aktualisiert werden.* |
| **FWLSE4228E** | *applyRegistrationValidations für Registrierung fehlgeschlagen; der Client {0} wird entfernt.* |
| **FWLSE4229W** | *Der initialisierte Clientkontext wird erneut gelesen. Möglicherweise sind Änderungen verlorengegangen.* |

### App-Nachrichten

**Präfix:** FWLST<br/>
**Bereich:** 0100-0106

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLST0100E** | *Es wurde versucht, auf die direkte Aktualisierung für eine Anwendung zuzugreifen, der keine Sicherheit für direkte Aktualisierungen zugeordnet ist.* |
| **FWLST0101E** | *Keine Anwendung mit dem Namen {0} gefunden.* |
| **FWLST0102E** | *Die direkte Aktualisierung kann nicht abgeschlossen werden. (Ursache: {0})* |
| **FWLST0110E** | *Es wurde versucht, auf die native Aktualisierung für eine Anwendung zuzugreifen, der keine Sicherheit für native Aktualisierungen zugeordnet ist.* |
| **FWLST0111E** | *Keine Anwendung mit dem Namen {0} gefunden.* |
| **FWLST0112E** | *Die native Aktualisierung kann nicht abgeschlossen werden. (Ursache: {0})* |
| **FWLST0120E** | *Es wurde versucht, auf die Modellaktualisierung für eine Anwendung zuzugreifen, der keine Sicherheit für Modellaktualisierungen zugeordnet ist.* |
| **FWLST0121E** | *Keine Anwendung mit dem Namen {0} gefunden.* |
| **FWLST0122E** | *Die Modellaktualisierung kann nicht abgeschlossen werden. (Ursache: {0})* |
| **FWLST0103E** | *Ungültiges Clientprotokollprofil; die Ebene muss ungleich null sein.* |
| **FWLST0104E** | *Ungültiges Clientprotokollprofil; mehr als ein globales Profil gefunden.* |
| **FWLST0105E** | *Die Benutzerprotokolldatei kann nicht hochgeladen werden. (Ursache: {0})* |
| **FWLST0106E** | *Die Anwendungsimplementierung ist fehlgeschlagen. Die Anwendungs-ID {0} ist unzulässig. Die Anwendungs-ID darf nur die Zeichen a-z, A-Z, _, - und . enthalten.*|

### JavaScript-Adapternachrichten

**Präfix:** FWLST<br/>
**Bereich:** 0900-0906

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLST0900E** | *Die Implementierung des Adapterdeskriptors ist fehlgeschlagen. Der Keystore ist ungültig.* |
| **FWLST0901W** | *Der SSL-Alias {0} ist nicht im Keystore vorhanden. Back-End-Aufrufe, für die der Keystore erforderlich ist, schlagen fehl.* |
| **FWLST0902W** | *Im Deskriptor ist ein SSL-Alias, aber kein Kennwort vorhanden. Back-End-Aufrufe, für die der Keystore erforderlich ist, schlagen fehl.* |
| **FWLST0902W** | *Im Deskriptor ist ein SSL-Kennwort, aber kein Alias vorhanden. Back-End-Aufrufe, für die der Keystore erforderlich ist, schlagen fehl.* |
| **FWLST0903W** | *SSL-Alias und -Kennwort ungültig. Back-End-Aufrufe, für die der Keystore erforderlich ist, schlagen fehl.* |
| **FWLST0904E** | *Beim Aufrufen der Prozedur {0} im Adapter {1} wurde eine Ausnahme ausgelöst.* |
| **FWLST0905E** | *Die Adapterimplementierung ist fehlgeschlagen. Der SQL-Treiber {0} wurde nicht in den Adapterressourcen gefunden.* |
| **FWLST0906E** | *Beim Aufrufen der SQL {0} wurde eine Ausnahme ausgelöst.* |


**Präfix:** FWLSE<br/>

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE0014W** | *Der Parameter {0} ist unbekannt und wird ignoriert.* |
| **FWLSE0152E** | *Es wurde keine Zertifikatkette mit dem Alias {0} gefunden.* |
| **FWLSE0207E** | *Fehler beim Lesen des HTTP-Antworteingabedatenstroms.* |
| **FWLSE0299W** | *Antwort auf die Anforderung: {0} wurde in 0 ms zurückgegeben. Der HTTP-Nachrichtenfluss muss untersucht werden.* |
| **FWLSE0310E** | *JSON-Parsing-Fehler.* |
| **FWLSE0311E** | *XML-Parsing- oder -Umsetzungsfehler.* |
| **FWLSE0318I** | *{0}.* |
| **FWLSE0319W** | *Der Inhaltstyp {0} der Back-End-Antwort stimmt nicht mit dem erwarteten Inhaltstyp {1} überein. Die Verarbeitung der Antwort wird fortgesetzt. Anforderungs- und Antworttext mit dem jeweiligen Header: {2}.* |
| **FWLSE0330E** | *Der WebSphere-SSL-Kontext kann nicht initialisiert werden.* |


### Core-Nachrichten

**Präfix:** FWLST<br/>

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLST3022W** | *In den Ordner {0} kann nicht geschrieben werden. Das benutzerbasierte Ausgangsverzeichnis wird verwendet.* |
| **FWLST3023E** | *Der Start des Projekts {0} ist fehlgeschlagen. Dsa Verzeichnis {1} konnte nicht erstellt werden.* |
| **FWLST3024I** | *MFP Server verwendet den Ordner {0} als Dateisystemcache.* |
| **FWLST3025W** | *MFP-Server-Analytics-Berichte sind inaktiviert, weil die URL in der Registry-Konfiguration leer ist.* |
| **FWLST3026W** | *Fehler bei MFP Sever während des Aufrufs des Analyseservice: {0}.* |
| **FWLST3027I** | *Konfiguration geändert. Analytics Server ist jetzt für {0} aktiviert.* |
| **FWLST4047W** | *Die Produktversion konnte nicht gefunden werden. Durchsucht wurden die Datei {0} und die Eigenschaft {1}.* |
| **FWLST4048W** | *Die Laufzeitversion konnte nicht gefunden werden. Durchsucht wurden die Datei {0} und die Eigenschaft {1}.* |

### Sicherheitsnachrichten

**Präfix:** FWLSE<br/>
**Bereich:** 4010-4068

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE4010E** | *Die ZIP-Datei für die Keystore-Implementierung kann nicht gelesen werden.* |
| **FWLSE4011E** | *Die ZIP-Datei enthält keine Keystore-Datei.* |
| **FWLSE4012E** | *Die ZIP-Datei enthält keine Eigenschaftendatei.* |
| **FWLSE4016E** | *Der Keystore-Zertifikatalgorithmus ist nicht vom Typ RSA. Folgen Sie dem Leitfaden für die Konsole, um einen Keystore mit einem RSA-Algorithmus zu erstellen.* |
| **FWLSE4017E** | *Der Keystore kann nicht erstellt werden. Keystore-Typ: {0}* |
| **FWLSE4018E** | *Einer der Verschlüsselungsalgorithmen wird in dieser Umgebung nicht unterstützt. Keystore-Typ: {0}* |
| **FWLSE4019E** | *Diese Ausnahme deutet auf eines von diversen Zertifikatproblemen hin. Keystore-Typ: {0}* |
| **FWLSE4021E** | *Der Keystore kann nicht erstellt werden. Pfadtyp: {0}* |
| **FWLSE4022E** | *Der Schlüssel aus dem Keystore kann nicht wiederhergestellt werden. Keystore-Typ: {0}* |
| **FWLSE4023E** | *Der private Schlüssel kann nicht aus dem Keystore extrahiert werden; ungültiger oder fehlender Alias. Alias: {0}* |
| **FWLSE4024W** | *Doppelt vorhandene Konfiguration für die Sicherheitsüberprüfung {0} in diesem Adapter. Verwendete Konfiguration: {1}.* |
| **FWLSE4025W** | *Die Sicherheitsüberprüfung {0} wurde bereits für einen anderen Adapter konfiguriert. Die neue Konfiguration wird nicht verwendet.* |
| **FWLSE4026E** | *Die Klasse {1} für die Sicherheitsüberprüfung {0} wurde nicht gefunden.* |
| **FWLSE4027E** | *Die Sicherheitsüberprüfung {0} kann nicht erstellt werden. Klasse: {1}, Fehler: {2}.* |
| **FWLSE4028E** | *Die Klasse {1} für die Sicherheitsüberprüfung {0} implementiert nicht die SecurityCheck-Schnittstelle.* |
| **FWLSE4029E** | *Die Implementierung der Authentizitätsdaten ist fehlgeschlagen. Fehlernachricht: {0}.* |
| **FWLSE4030E** | *Für das Bereichselement {0} wurde eine doppelte Elementzuordnung gefunden. Verwendete Zuordnung: {1}.* |
| **FWLSE4031E** | *Für die Sicherheitsprüfung {0} wurde eine doppelte vorhandene Konfiguration gefunden.* |
| **FWLSE4032E** | *Der Anwendungsdeskriptor der Anwendung {0} enthält eine Konfiguration für die Sicherheitsüberprüfung {1}. Die Sicherheitsüberprüfung fehlt, oder es wurde versucht, sie zu entfernen.* |
| **FWLSE4033E** | *Der Anwendungsdeskriptor der Anwendung {0} enthält eine Konfiguration für die Sicherheitsüberprüfung {1}. Die Konfiguration der Sicherheitsüberprüfung konnte nicht angewendet werden.* |
| **FWLSE4034E** | *In der Sicherheitsüberprüfung {0} gibt es beim Parameter {1} einen Konfigurationsfehler: {2}.* |
| **FWLSE4035W** | *In der Sicherheitsüberprüfung ''{0}'' gibt es beim Parameter {1} eine Warnung zur Konfiguration: {2}.* |
| **FWLSE4036W** | *Der Anwendungsdeskriptor der Anwendung {0} enthält eine Konfiguration für einen obligatorischen Anwendungsbereich ({1}). Es fehlt mindestens ein Bereichselement, oder es wurde versucht, Bereichselemente zu entfernen.* |
| **FWLSE4037E** | *Die Sicherheitsüberprüfung {0} darf nicht den gleichen Namen wie eine Bereichselementzuordnung haben.* |
| **FWLSE4038E** | *Der Anwendungsdeskriptor der Anwendung {0} enthält eine Konfiguration für den Bereich ({1}), der der Sicherheitsüberprüfung {2} zugeordnet ist. Die Sicherheitsüberprüfung fehlt, oder es wurde versucht, sie zu entfernen.* |
| **FWLSE4039W** | *Ein leeres Bereichselement kann nicht zugeordnet werden. Versuchte Zuordnung zu: {0}.* |
| **FWLSE4040E** | *Das Feld {0} für die Adaperkonfiguration ist nicht ordnungsgemäß formatiert.* |
| **FWLSE4041W** | *Ungültige Zeichen im Bereichselement {0}. Gültige Zeichen sind Buchstaben, Zahlen, '-' und '_'.* |
| **FWLSE4042I** | *Konfiguration für Parameter {1} der Sicherheitsüberprüfung {0}: {2}.* |
| **FWLSE4043E** | *Die maximale Tokenverfallszeit der Anwendung muss ein positiver Wert sein. Konfigurierter Wert: {0}.* |
| **FWLSE4044I** | *Der Benutzer {0} wird über die LTPA-basierte SSO-Sicherheit authentifiziert.* |
| **FWLSE4045I** | *Der Benutzer wird NICHT über die LTPA-basierte SSO-Sicherheit authentifiziert.* |
| **FWLSE4046** | *Es wird überprüft, ob das Gerät inaktiviert wurde, weil die Registrierung mit einer Ausnahme fehlgeschlagen ist.* |
| **FWLSE4047:** | *Die maximale Tokenverfallszeit der Anwendung {0} überschreitet das Verfallsdatum. Wert: {1}, Verfallsdatum: {2}.* |
| **FWLSE4048E** | *Das Zugriffstoken konnte nicht mit dem externen AZ-Server {0} validiert werden.* |
| **FWLSE4049E** | *Die Sortierung der Sicherheitsüberprüfungen ist fehlgeschlagen.* |
| **FWLSE4050E** | *Ungültige Clientdaten.* |
| **FWLSE4051E** | *Die Anwendung ist nicht vorhanden.* |
| **FWLSE4052E** | *Die externalisierten Sicherheitsüberprüfungen konnten nicht gelesen werden. Der Kontext für den Client {0} wurde neu initialisiert.* |
| **FWLSE4053E** | *Die Sicherheitsprüfung ist nicht vorhanden ({0}).* |
| **FWLSE4054E** | *Die Sicherheitsüberprüfungen konnten nicht externalisiert werden. Die Sicherheitsüberprüfungen für den Client {0} werden gelöscht.* |
| **FWLSE4055E** | *Der Ablauf des Bereichs konnte nicht abgerufen werden. Zurückgegeben wurde 0.* |
| **FWLSE4056E** | *Die Introspektion ist mit einer Ausnahme fehlgeschlagen.* |
| **FWLSE4057E** | *Unerwartetes Ergebnis der Tokenvalidierung: {0}.* |
| **FWLSE4058E** | *Fehler beim Verschlüsseln des Headers und der Nutzdaten.* |
| **FWLSE4059E** | *Fehler beim Erstellen des Header-Objekts aus dem entschlüsselten Header: {0}.* |
| **FWLSE4060E** | *Fehler beim Erstellen des Nutzdatenobjekts aus den entschlüsselten Nutzdaten: {1}.* |
| **FWLSE4061E** | *Fehler bei der Verschlüsselung von header64 + payload64.* |
| **FWLSE4062E** | *Fehler beim Verschlüsseln des Headers für die Signatur oder beim Erstellen des Headers.* |
| **FWLSE4063E** | *Fehler beim Verschlüsseln der Nutzdaten.* |
| **FWLSE4064E** | *Der Bereich {0} ist für den Client unzulässig.* |
| **FWLSE4065E** | *Der Client ist nicht autorisiert.* |
| **FWLSE4066E** | *Der implizite Grant-Datenfluss ist nur für die Swagger-Benutzerschnittstelle verfügbar.* |
| **FWLSE4067E** | *Der Client ist nicht autorisiert.* |
| **FWLSE4068E** | *Der Client ist nicht autorisiert.* |


### Peristenznachrichten des Servers

**Präfix:** FWLSE<br/>
**Bereich:** 3000-3009

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE3000E** | *Keine JNDI-Bindung der Datenquelle für die Namen {0} und {1} gefunden.* |
| **FWLSE3001E** | *Die Liste kann nicht in ein JSON-Array serialisiert werden.* |
| **FWLSE3002E** | *Das persitente Datenelement {0} kann nicht erstellt werden.* |
| **FWLSE3003E** | *Problem bei der Deserialisierung des JSON-Arrays.* |
| **FWLSE3004E** | *Die Spalte mit den CLOB-Werten kann nicht gelesen werden.* |
| **FWLSE3005E** | *Die Liste kann nicht in ein JSON-Array serialisiert werden.* |
| **FWLSE3006E** | *Die Transaktion {0} konnte nicht gestartet werden.* |
| **FWLSE3007E** | *Unerwarteter Fehler.* |
| **FWLSE3008E** | *Der Hashwert konnte nicht generiert werden.* |
| **FWLSE3009E** | *Bei dem Versuch, die Transaktion festzuschreiben, ist ein Fehler aufgetreten.* |

### WAR-Nachrichten des Servers

**Präfix:** FWLSE<br/>
**Bereich:** 3100-3103

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE3100E** | *Nicht erkannter Modus des Autorisierungsservers: {0}.* |
| **FWLSE3101E** | *Der JNDI-Eintrag {0} wurde nicht gefunden. Unbekannter Modus des Autorisierungsservers.* |
| **FWLSE3102I** | *Es konnten keine Annotationen für die Klasse {0} zusammengestellt werden. Möglicherweise fehlt ein Bereich der Swagger-Benutzerschnittstelle.* |
| **FWLSE3103I** | *Die Klasse für die Bean {0} konnte nicht bestimmt werden. Möglicherweise fehlen Bereiche der Swagger-Benutzerschnittstelle.* |
| **FWLSE3103I** | *Der Start erfolgt mit dem eingebetteten Autorisierungsserver.* |
| **FWLSE3103I** | *Der Start erfolgt mit der Integration eines externen Autorisierungsservers.* |

### Lizenznachrichten

**Präfix:** FWLSE<br/>

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE0277I** | *Ein ILMT-Datensatz wird in der Datei {0} erstellt.* |
| **FWLSE0278I** | *Das ILMT-Standardverzeichnis {0} kann nicht verwendet werden.* |
| **FWLSE0279E** | *Fehler beim Erstellen eines ILMT-Datensatzes.* |
| **FWLSE0280I** | *Der ILMT-Debugmodus wurde von der Umgebungsvariablen {0} aktiviert.* |
| **FWLSE0281E** | *Fehler beim Erstellen eines ILMT-Loggers.* |
| **FWLSE0282I** | *Das ILMT-Verzeichnis {0} wird verwendet.* |
| **FWLSE0283E** | *Das ILMT-Verzeichnis ist nicht kompatibel. Sie können ein geeignetes Verzeichnis für die Eigenschaft 'license.metric.logger.output.dir' in der Datei 'license_metric_logger.properties' definieren und die JVM-Eigenschaft '-Dlicense_metric_logger_configuration=\<Pfad_zu_license_metric_logger.properties\>' verwenden.* |
| **FWLSE0284E** | *Der Ausführungspfad für diese Instanz von {0} konnte nicht abgerufen werden. Dies ist nicht ILMT-kompatibel.* |
| **FWLSE0286I** | *Unerwartete Ausnahme.* |
| **FWLSE0287E** | *Ein ILMT-Datensatz konnte nicht erstellt werden, weil der ILMT-Logger nicht ordnungsgemäß initialisiert wurde. Dies ist nicht ILMT-kompatibel. Suchen Sie in den Protokolldateien nach der Ursache für den Initialisierungsfehler.* |
| **FWLSE0367E** | *Fehlende Lizenzberichtsdaten. Es konnte kein ILMT-Datensatz erstellt werden.* |

### Bereinigungsnachrichten

**Präfix:** FWLSE<br/>
**Bereich:** 0290-0292

| **FWLSE0290I** | *Löschung von {0} Datensätzen in {1} ms abgeschlossen.* |
| **FWLSE0291I** | *Löschung von {0} Stapeln in {1} ms abgeschlossen.* |
| **FWLSE0292I** | *Die Löschung persistenter Daten wird fär Datensätze, die älter als {0} Tage sind, empfohlen.* |

### Weitere Nachrichten

**Präfix:** FWLSE<br/>

| **FWLSE0211W** | *Das empfohlene Stilllegungsintervall ({0}) liegt bei 86.400 Sekunden, was einem Tag entspricht.* |
| **FWLSE0801E** | *Das Dienstprogramm für Kennwortentschlüsselung com.ibm.websphere.crypto.PasswordUtil ist nicht verfügbar. Für {0} werden daher keine verschlüsselten Kennwörter unterstützt.* |
| **FWLSE0802E** | *Das Kennwort für {0} kann nicht entschlüsselt werden.* |
| **FWLSE0803E** | *Die Nachricht für ID {0} im Bundle {1} " + " wurde nicht gefunden. Fehler: {2}.* |
| **FWLSE0802E** | *Das Kennwort für {0} kann nicht entschlüsselt werden.* |



## Nachrichten des Mobile-Foundation-Verwaltungsservice
{: #admin-services-error-codes }
<!-- Messages taken from mfp-admin-services/mfp-admin-util/src/main/resources/com/ibm/worklight/admin/resources/messages.properties-->
**Präfix:** FWLSE<br/>
**Bereich:** 3000-3299

| **Fehlercode**  | **Beschreibung** |
|-----------------|-----------------|
| **FWLSE3000E** | **Es wurde ein Serverfehler festgestellt.** |
| **FWLSE3001E** | **Ein Konflikt wurde festgestellt.** |
| **FWLSE3002E** | **Die Ressource wurde nicht gefunden.** |
| **FWLSE3003E** | **Die Laufzeit kann nicht hinzugefügt werden, weil die zugehörigen Nutzdaten keinen Namen enthalten.** |
| **FWLSE3010E** | **Es wurde ein Datenbankfehler festgestellt.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste die Datenbank falsch konfiguriert werden. |
| **FWLSE3011E** | **Die Portnummer "{0}" der JNDI-Eigenschaft mfp.admin.proxy.port ist nicht gültig.** <br/><br/>{0} ist die Portnummer, z. B. 9080.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste die JNDI-Eigenschaft mfp.admin.proxy.port auf einen unsinnigen Wert gesetzt werden. Anschließend muss die Operations Console geöffnet werden. Es könnte sein, dass die Nachricht dann in den Serverprotokollen erscheint. |
| **FWLSE3012E** | **JMX-Verbindungsfehler. Ursache: "{0}". Überprüfen Sie, ob die Anwendungsserverprotokolle Details enthalten.** <br/><br/>{0} ist eine Fehlernachricht vom JMX-Protokoll des Web-Servers. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste JMX falsch konfiguriert werden, damit eine Ausnahme ausgelöst wird. |
| **FWLSE3013E** | **Zeitlimitüberschreitung nach {0} Millisekunden bei dem Versuch, die Transaktionssperre anzufordern.** <br/><br/>{0} ist die Anzahl der Millisekunden, z. B. 32000.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch tritt dieser Fehler bei einer Datenbank auf, die über ein instabiles oder langsames Netz verbunden ist. |
| **FWLSE3017E** | **Es wurde ein Datenbankfehler festgestellt: {0}. Ursache: {1}** <br/><br/>{0} ist die Fehlernachricht von Cloudant. <br/>{1} ist die Nachricht zur Fehlerursache von Cloudant. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste Cloudant falsch konfiguriert werden. |
| **FWLSE3018E** | **Die Cloudant-Operation konnte nicht binnen {0} Millisekunden abgeschlossen werden.** <br/><br/>{0} ist die Anzahl der Millisekunden, z. B. 32000.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müssten Sie die Cloudant-Datenbank verwenden und die JNDI-Eigenschaft mfp.db.cloudant.documentOperation.timeout auf 1 setzen. Wenn die Verbindung zu Cloudant langsam ist, müssten Sie die Operations Console öffnen. Es könnte sein, dass die Nachricht dann in den Serverprotokollen erscheint. |
| **FWLSE3019E** | **Es kann keine Transaktionssperre angefordert werden. Ursache: {0}** <br/><br/>{0} ist eine Ausnahmenachricht, die von einer externen Quelle zurückgegeben wurde. Es kann sich um eine beliebige Zeichenfolge handeln. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kann der Fehler reproduziert werden, wenn Sie eine Farm mit Cloudant haben und den Lock Master während der Sperrung abschalten. Anschließend muss die Operations Console geöffnet werden. Es könnte sein, dass die Nachricht dann in den Serverprotokollen erscheint. |
| **FWLSE3021E** | **Zeitlimitüberschreitung nach {0} Millisekunden bei dem Versuch, die Transaktionssperre anzufordern. Erhöhen Sie den Wert der Eigenschaft {1}.**<br/><br/>{0} ist die Anzahl der Millisekunden, z. B. 32000.<br/>{1} ist der Name der JNDI-Eigenschaft, von der das Zeitlimit übernommen wird. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch tritt dieser Fehler bei einer Datenbank auf, die über ein instabiles oder langsames Netz verbunden ist. |
| **FWLSE3030E** | **Die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>**Folgendes gilt:** {0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/><br/>Dieser Fehler tritt auf, wenn {{site.data.keys.mf_server }} die in der Datenbank gespeicherte Laufzeit nicht laden kann. Für diese Nachricht wurde [APAR PI71317](http://www-01.ibm.com/support/docview.wss?uid=swg1PI71317) geöffnet. Wenn der Fix-Level des Servers älter als **iFix 8.0.0.0-IF20170125-0919** ist, führen Sie ein Upgrade auf den [neuesten vorläufigen Fix](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all) durch. |
| **FWLSE3031E** | **Die Laufzeit "{0}" kann nicht hinzugefügt oder gelöscht werden, weil sie noch aktiv ist.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).|
| **FWLSE3032E** | **Die Laufzeit "{0}" kann nicht hinzugefügt werden, weil sie bereits vorhanden ist.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).|
| **FWLSE3033E** | **Die Laufzeit "{0}" ist nicht leer. Sie haben gefordert, die Laufzeit nur zu löschen, wenn sie leer ist.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste eine gestoppte Laufzeit, die noch Apps enthält, gelöscht werden. |
| **FWLSE3034E** | **Die Anwendung "{1}" für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).|
| **FWLSE30302E** | **Die Lizenzkonfiguration der Anwendung "{1}" für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden.**<br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).|
| **FWLSE30303E** | **Die Lizenzkonfiguration kann nicht gelöscht werden, weil die Anwendung "{1}" für die Laufzeit "{0}" in der MobileFirst-Verwaltungsdatenbank vorhanden ist oder weil es die Konfiguration nicht gibt.** <br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).|
| **FWLSE30035E** | **Die Anwendung "{1}" kann nicht hinzugefügt werden, weil sie bereits in der Laufzeit "{0}" vorhanden ist.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Fehler tritt nur bei Komponententests auf. |
| **FWLSE3035E** | **Die Anwendung "{1}" mit der Umgebung "{2}" für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/>{2} ist der Umgebungsname: android, ios ... |
| **FWLSE30304E** | **Die Authentizitätsdaten für die Anwendung "{1}" Version "{3}" mit der Umgebung "{2}" für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/>{2} ist der Umgebungsname: android, ios ... |
| **FWLSE3036E** | **Die Anwendung "{1}" Version "{3}" mit der Umgebung "{2}" für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge).<br/>{1} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/>{2} ist der Umgebungsname: android, ios ... <br/>{3} ist die Version: 1.0, 2.0 ... |
| **FWLSE3037E** | **Die Umgebung "{1}" der Version "{2}" kann nicht hinzugefügt werden, weil sie bereits in der Anwendung "{0}" vorhanden ist.** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/>{1} ist der Umgebungsname: android, ios ... <br/>{2} ist die Version: 1.0, 2.0 ...<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Fehler tritt nur bei Komponententests auf. |
| **FWLSE3038E** | **Der Adapter "{1}" der Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge). {1} ist der Adaptername (eine beliebige Zeichenfolge).|
| **FWLSE3039E:** | **Der Adapter "{0}" kann nicht hinzugefügt werden, weil er bereits in der Laufzeit "{1}" vorhanden ist.** <br/>{0} ist der Name der Laufzeit (eine beliebige Zeichenfolge). {1} ist der Adaptername (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Fehler tritt nur bei Komponententests auf. |
| **FWLSE3040E** | **Das Konfigurationsprofil "{0}" wurde für keine Laufzeit in der MobileFirst-Verwaltungsdatenbank gefunden. Möglicherweise ist die Datenbank beschädigt.** <br/><br/>{0} ist die ID des Konfigurationsprofils (eine beliebige Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch könnte der Fehler im Traceprotokoll erscheinen, wenn ein nicht vorhandenes Clientkonfigurationsprofil gelöscht wird. |
| **FWLSE3045E** | **Für die {0}-Verwaltung wurde keine MBean gefunden.** <br/><br/>{0} ist das Wort MobileFirst.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3041E** | **Für das {0}-Projekt ''{1}'' wurde keine MBean gefunden. Möglicherweise ist die {0}-Laufzeitwebanwendung für das {0}-Projekt ''{1}'' nicht aktiv. Sollte sie aktiv sein, inspizieren Sie die verfügbaren MBeans in der JConsole. Falls sie nicht aktiv ist, enthalten die Protokolldateien des Servers sämtliche Fehlerdetails.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Projekt-/Laufzeitname (eine beliebige Zeichenfolge). |
| **FWLSE3042E** | **Fehler bei der Kommunikation mit der MBean ''{0}''. Überprüfen Sie die Anwendungsserverprotokolle.** <br/><br/>{0} ist die kanonische MBean-ID (eine Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler könnte auftreten, wenn eine Worklight-JEE-Bibliothek der Version 6.2 in einem MobileFirst Server der Version 7.1 installiert wird. |
| **FWLSE3043E** | **Die MBean ''{0}'' ist nicht mehr vorhanden. Überprüfen Sie die Anwendungsserverprotokolle.** <br/><br/>{0} ist die kanonische MBean-ID (eine Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch tritt der Fehler ineiner Serverfarm auf, wenn ein Server während einer laufenden Implementierung heruntergefahren wird. |
| **FWLSE3044E** | **Die MBean ''{1}'' bietet keine Unterstützung für die erwarteten Operationen. Überprüfen Sie, ob die {0}-Laufzeitversion mit der Version der Verwaltungsservices übereinstimmt.**<br/><br/>{0} ist das Wort MobileFirst. {1} ist die kanonische MBean-ID (eine Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler könnte auftreten, wenn eine Worklight-JEE-Bibliothek der Version 6.2 in einem MobileFirst Server der Version 7.1 installiert wird. |
| **FWLSE3050E** | **Die MBean-Operation gibt einen unbekannten Typ zurück. Überprüfen Sie, ob die {0}-Laufzeitversion mit der Version der Verwaltungsservices übereinstimmt.**<br/><br/>{0} ist das Wort MobileFirst.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler könnte auftreten, wenn eine Worklight-JEE-Bibliothek der Version 6.2 in einem MobileFirst Server der Version 7.1 installiert wird. |
| **FWLSE3051E** | **Ungültige Nutzdaten. Überprüfen Sie, ob zusätzliche Nachrichten Details enthalten.** |
| **FWLSE3052E** | **Nicht erkannte Nutzdaten: "{0}".** <br/><br/>{0} ist ein Auszug aus den Nutzdaten in JSON-Syntax, z. B. "{ a : 0 }". |
| **FWLSE3053E** | **Ungültige Parameter. Überprüfen Sie, ob zusätzliche Nachrichten Details enthalten.** |
| **FWLSE3061E** | **Die Umgebung "{0}", auf die in der Datei "{1}" der WLAPP-Datei verwiesen wird, ist unbekannt. Überprüfen Sie, ob die Anwendung ordnungsgemäß erstellt wurde.** <br/><br/>{0} ist die Umgebung: android, ios. {1} ist ein Dateiname. |
| **FWLSE3063E** | **Die Anwendung kann nicht implementiert werden, weil der Ordner "{0}" in der WLAPP-Datei fehlt. Überprüfen Sie, ob die Anwendung ordnungsgemäß erstellt wurde.** <br/><br/>{0} ist ein Ordnername, z. B. "meta".<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Implementieren Sie eine WLAPP-Datei, die nicht den Ordner "meta" enthält. |
| **FWLSE3065E** | **Die Anwendung kann nicht implementiert werden, weil das Feld "{0}" in der WLAPP-Datei fehlt. Überprüfen Sie, ob die Anwendung ordnungsgemäß erstellt wurde.** <br/><br/>{0} ist ein Pflichtfeld, z. B. "app.id". |
| **FWLSE3066E** | **Die Anwendung kann nicht implementiert werden, weil die Anwendungsversion "{2}" von der Version der {0}-Laufzeit ("{3}") abweicht. Verwenden Sie {1} "{4}", um die Anwendung zu erstellen und zu implementieren.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist eine Anwendungsversion: 1.0, 2.0... {3} ist die Laufzeitversion. {4} ist die erforderliche Studio-Version. |
| **FWLSE3067E** | **Die Anwendung kann nicht implementiert werden, weil die Anwendungsversion älter als die Version der {0}-Laufzeit ("{2}") ist. Verwenden Sie {1} "{3}", um die Anwendung zu erstellen und zu implementieren.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist die Laufzeitversion. {3} ist die erforderliche Studio-Version. |
| **FWLSE3068E** | **Der Adapter kann nicht implementiert werden, weil die Adapterversion "{2}" von der Version der {0}-Laufzeit ("{3}") abweicht. Verwenden Sie {1} "{4}", um den Adapter zu erstellen und zu implementieren.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist eine Adapterversion: 1.0, 2.0... {3} ist die Laufzeitversion. {4} ist die erforderliche Studio-Version. |
| **FWLSE3069E** | **Der Adapter kann nicht implementiert werden, weil die Adapterversion älter als die Version der {0}-Laufzeit ("{2}") ist. Verwenden Sie {1} "{3}", um den Adapter zu erstellen und zu implementieren.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist die Laufzeitversion. {3} ist die erforderliche Studio-Version. |
| **FWLSE3070E** | **Die Aktualisierung der Anwendung "{1}" Version "{3}" mit der Umgebung "{2}" ist fehlgeschlagen, weil die Anwendung gesperrt ist. Sie kann in der {0} Operations Console freigegeben werden.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Anwendungsname (eine beliebige Zeichenfolge). {2} ist die Anwendungsumgebung: android, ios ... {3} ist die Anwendungsversion: 1.0, 2.0 ... |
| **FWLSE3071E** | **Die Hybridanwendung "{0}" kann nicht implementiert werden, weil es bereits eine native Anwendung mit diesem Namen gibt. ** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Erstellen Sie eine native Anwendung und eine Hybridanwendung mit identischen Namen und implementieren Sie beide in der Operations Console. |
| **FWLSE3072E** | **Die native Anwendung "{0}" kann nicht implementiert werden, weil es bereits eine Hybridanwendung mit diesem Namen gibt. ** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Erstellen Sie eine native Anwendung und eine Hybridanwendung mit identischen Namen und implementieren Sie beide in der Operations Console. |
| **FWLSE3073E** | **Die AIR-Installationsdatei wurde nicht in der Anwendung "{1}" Version "{2}" gefunden. \nVerwenden Sie {0}, um die WLAPP-Datei für diese Anwendung neu zu erstellen und zu implementieren.** <br/><br/>{0} ist der Studio-Name, z. B. MobileFirst Studio. {1} ist der Anwendungsname (eine beliebige Zeichenfolge). {2} ist die Anwendungsversion: 1.0, 2.0 ...<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Fehler tritt auf, wenn die Adobe-Anwendung beschädigt ist. |
| **FWLSE3074W** | **Die Sperre für die Anwendung "{0}" Version "{2}" mit der Umgebung "{1}" wurde ordnungsgemäß aktualisiert. Diese Einstellung hat jedoch keine Auswirkung auf die Umgebung "{1}", weil diese keine Unterstützung für eine direkte Aktualisierung bietet.** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge). {1} ist die Anwendungsumgebung: android, ios ... {2} ist die Anwendungsversion: 1.0, 2.0 ... <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3075W** | **Die Anwendungsauthentifizierungsregel für die Anwendung "{0}" Version "{2}" mit der Umgebung "{1}" wurde ordnungsgemäß aktualisiert. Diese Einstellung hat jedoch keine Auswirkung auf die Umgebung "{1}" der Anwendung "{0}", weil diese Umgebung keine Unterstützung für die Überprüfung der Anwendungsauthentifizierung bietet. Sie können diese Unterstützung für diese Anwendungsumgebung aktivieren, indem Sie in application-descriptor.xml eine in authenticationConfig.xml definierte Sicherheitskonfiguration deklarieren.** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge). {1} ist die Anwendungsumgebung: android, ios ... {2} ist die Anwendungsversion: 1.0, 2.0 ... <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3076W** | **Die Anwendung "{0}" Version "{2}" mit der Umgebung "{1}" wurde nicht implementiert, weil sie seit der letzten Implementierung nicht geändert wurde.** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge). {1} ist die Anwendungsumgebung: android, ios ... {2} ist die Anwendungsversion: 1.0, 2.0 ... <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müssten Sie genau dieselbe (gültige) WLAPP-Datei zweimal in der Operations Console implementieren. |
| **FWLSE3077W** | **Der Adapter "{0}" wurde nicht implementiert, weil er seit der letzten Implementierung nicht geändert wurde.** <br/><br/>{0} ist der Adaptername (eine beliebige Zeichenfolge).<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müssten Sie genau denselben (gültigen) Adapter zweimal in der Operations Console implementieren. |
| **FWLSE3078W** | **Die Piktogrammdatei fehlt in der WLAPP-Datei für die Anwendung "{0}" Version "{2}" mit der Umgebung "{1}".** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge). {1} ist die Anwendungsumgebung: android, ios ... {2} ist die Anwendungsversion: 1.0, 2.0 ... |
| **FWLSE3079W** | **Es kann nicht überprüft werden, ob die Anwendung "{2}" Version "{4}" mit der Umgebung "{3}" mit derselben Version von {1} wie die {0}-Laufzeit erstellt wurde, weil die Anwendungs- und Laufzeitversion mit einer äteren Worklight-Studio-Version als Version 6.0 erstellt wurde. Stellen Sie sicher, dass beide mit derselben Version von {1} erstellt wurden.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist der Anwendungsname (eine beliebige Zeichenfolge). {3} ist die Anwendungsumgebung: android, ios ... {4} ist die Anwendungsversion: 1.0, 2.0 ... <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste eine mit Worklight Studio 5.0.6 oder einer älteren Version erstellte WLAPP-Datei in MobileFirst Server 7.1 implementiert werden. |
| **FWLSE3080W** | **Es kann nicht überprüft werden, ob der Adapter "{2}" mit derselben Version von {1} wie die {0}-Laufzeit erstellt wurde, weil die Adapter- und Laufzeitversion mit einer äteren Worklight-Studio-Version als Version 6.0 erstellt wurde. Stellen Sie sicher, dass beide mit derselben Version von {1} erstellt wurden.** <br/><br/>{0} ist das Wort MobileFirst. {1} ist der Studio-Name, z. B. MobileFirst Studio. {2} ist der Adaptername (eine beliebige Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müsste ein mit Worklight Studio 5.0.6 oder einer älteren Version erstellter Adapter in MobileFirst Server 7.1 implementiert werden. |
| **FWLSE3081E** | **Die Überprüfung der Anwendungsauthentizität wird für die Umgebung "{0}" nicht unterstützt. Es werden nur iOS- und Android-Umgebungen unterstützt.** <br/><br/>{0} ist die Anwendungsumgebung: android, ios ...<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch müssten Sie die Android-App mit aktivierter Authentizitätsprüfung bearbeiten, die Umgebung modifizieren und die App dann implementieren. |
| **FWLSE3082E** | **Die Datei "{0}" hat keinen Inhalt und kann daher nicht implementiert werden.** <br/><br/>{0} ist ein Dateiname. |
| **FWLSE3084E** | **Die Adapterdatei kann nicht implementiert werden, weil sie nicht die obligatorische Adapter-XML-Datei enthält. Überprüfen Sie, ob die Datei ordnungsgemäß erstellt wurde.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Implementieren Sie einen Adapter ohne XML-Datei. |
| **FWLSE3085E** | **Die Anwendungsdatei kann nicht implementiert werden, weil sie die obligatorische Datei "{0}" nicht enthält. Überprüfen Sie, ob die Datei ordnungsgemäß erstellt wurde.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Implementieren Sie eine WLAPP-Datei ohne die Datei meta/deployment.data. |
| **FWLSE3090E** | **Die Transaktion wurde nie beendet. Überprüfen Sie die Anwendungsserverprotokolle.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler tritt theoretisch auf, wenn eine Transaktion aus unbekannten Gründen 30 Minuten blockiert wird. |
| **FWLSE3091W** | **Die Verarbeitung der Transaktion {0} ist fehlgeschlagen. Überprüfen Sie die Anwendungsserverprotokolle.** <br/><br/>{0} ist die Transaktions-ID, in der Regel eine Zahl.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Möglicherweise kann der Fehler dadurch reproduziert werden, dass eine Laufzeit während der Ausführung einer Transaktion heruntergefahren wird. |
| **FWLSE3092W** | **Die Transaktion {0} wurde abgebrochen, bevor ihre Verarbeitung gestartet wurde. Überprüfen Sie die Anwendungsserverprotokolle.** <br/><br/>{0} ist die Transaktions-ID, in der Regel eine Zahl.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Diese Warnung tritt auf, wenn Sie mehrere Implementierungstransaktionen erstellen und beim Herunterfahren des Servers mindestens eine dieser Transaktionen noch nicht verarbeitet wurde. Beim Neustart des Servers wird die nicht verarbeitete Transaktion abgebrochen. |
| **FWLSE3100W** | **Auf die binäre Ressource {3} kann nicht zugegriffen werden. Die HTTP-Bereichsanforderung {0}-{1} kann nicht erfüllt werden. Die maximale Inhaltslänge liegt bei {2} Bytes.** <br/><br/>{0} ist der Beginn des Bytebereichs, z. B. 0. {1} ist das Ende des Bytebereichs, z. B. 6666. {2} ist die Anzahl der verfügbaren Bytes, z. B. 25. {3} ist der Ressourcenname (z. B. ein Dateiname). |
| **FWLSE3101W** | **Die mit {0} Version {4} erstellte Anwendung {1} Version {3} mit der Umgebung {2} wurde von der mit {0} Version {5} erstellten Umgebung überschrieben.** <br/><br/>{0} ist der Studio-Name MobileFirst Studio. {1} ist der Anwendungsname (eine beliebige Zeichenfolge). {2} ist die Anwendungsumgebung: android, ios ... {3} ist die Anwendungsversion: 1.0, 2.0 ... {4} ist die Studio-Version, z. B. 3.0. {5} ist die andere Studio-Version, z. B. 4.0.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch benötigen Sie einen mit zwei verschiedenen Studio-Versionen erstellten App-Build. Die Apps müssen aber dieselbe Versionsnummer und dieselbe Umgebung haben. Werden dann beide Apps in demselben Server implementiert, könnte diese Nachricht erscheinen. Es kann auch sein, dass die Nachricht von anderen Nachrichten verdeckt wird, sodass sie nie zu sehen ist. |
| **FWLSE3102W** | **Für die Anwendung {0} sind keine Push-Benachrichtigungen aktiviert.** <br/><br/>{0} ist der Anwendungsname (eine beliebige Zeichenfolge).|
| **FWLSE3103E** | **Für die Anwendung {2} der Laufzeit {1} wurde der Push-Benachrichtigungstag {0} nicht gefunden.** <br/><br/>{0} ist der Push-Benachrichtigungstag (eine beliebige Zeichenfolge). {1} ist der Laufzeitname (eine beliebige Zeichenfolge). {2} ist der Anwendungsname (eine beliebige Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Fehler tritt nur bei Komponententests auf. |
| **FWLSE3104E** | **Der Push-Benachrichtigungstag {0} ist bereits für die Anwendung {2} der Laufzeit {1} vorhanden.** <br/><br/>{0} ist der Push-Benachrichtigungstag (eine beliebige Zeichenfolge). {1} ist der Laufzeitname (eine beliebige Zeichenfolge). {2} ist der Anwendungsname (eine beliebige Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3105W** | **Das Push-Benachrichtigungszertifikat für {0} ist abgelaufen.** <br/><br/>{0} ist der Name des Push-Mediators (eine beliebige Zeichenfolge). <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3113E** | **Mehrere Fehler beim Synchronisieren der Laufzeit {0}.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch tritt dieser Fehler bei einem Farm-Setup (mit mehreren Knoten) auf, wenn der Server gestartet wird, aber jeder Knoten einen anderen Fehler meldet. |
| **FWLSE3199I** | **========= {0} Version {1} gestartet.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Diese Informationen ist bei jedem Serverstart im Serverprotokoll vorhanden. |
| **FWLSE3210W** | **Die Umgebung {1} der Anwendung {0} Version {2} wurde mit einer anderen Version des nativen MobileFirst-SDK implementiert. Für vorhandene Clients mit anderen Versionen des MobileFirst-SDK sind keine direkten Aktualisierungen mehr verfügbar. Wenn Sie weiter direkte Aktualisierungen durchführen möchten, erhöhen Sie die App-Versionsnummer, veröffentlichen Sie die App im öffentlichen App Store, implementieren Sie sie im Server und (bei Bedarf) blockieren Sie ältere Versionen der App oder senden Sie für diese eine Benachrichtigung, damit Kunden ein Upgrade auf die neue Version aus dem App Store durchführen müssen.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kommt diese Warnung vor, wenn eine App mit einer älteren Version von MobileFirst Studio unter Verwendung eines anderen, älteren MobileFirst-SDK erstellt wurde. Es liegen allerdings nicht genug Informationen zu den Versionen des nativen MobileFirst-SDK vor. |
| **FWLSE3119E** | **Die Validierung des APNS-Zertifikats ist fehlgeschlagen. Überprüfen Sie, ob zusätzliche Nachrichten Details enthalten.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler tritt auf, wenn das Zertifikat des Apple Push Notification Service ungültig ist. |
| **FWLSE3120E** | **Diese API kann erst nach der Migration der Anwendung auf MobileFirst Platform 6.3 verwendet werden. Die aktuelle Version der Anwendung ist {0}.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler tritt auf, wenn neue Push-Benachrichtigungen mit alten Apps verwendet werden. |
| **FWLSE3121E** | **Diese API ist auf dem Server nicht mehr verfügbar. Überprüfen Sie, ob zusätzliche Nachrichten Details enthalten.** |
| **FWLSE3122E** | **Die Authentizitätsprüfregel für eine Anwendung kann nicht mehr im Server geändert werden. Sie müssen Ihre Anwendung neu erstellen, um die Authentizitätsprüfregel modifizieren zu können. Implementieren Sie die Anwendung dann erneut.** |
| **FWLSE3123W** | **Die Umgebung {1} der Anwendung {0} Version {2} wurde mit inaktivierter erweiterter Anwendungsauthentizität implementiert. Sie sollten die erweiterte App-Authentizität nutzen, um einen wirksameren Schutz vor nicht autorisierten Apps zu etablieren. Verwenden Sie vor der Implementierung der Anwendung den Befehl enable extended-authenticity des Tools mfpadm.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Implementieren Sie in der Operations Console eine App mit Basisauthentizität. Alle Apps vor 7.0 haben keine erweiterte Authentizität und sollten diese oder die nächste Warnung anzeigen. Die Warnung erscheint nicht, wenn Sie die in Worklight Studio eingebettete Operations Console verwenden. |
| **FWLSE3124W** | **Die Umgebung {1} der Anwendung {0} Version {2} wurde mit inaktivierter Anwendungsauthentizität implementiert. Aktivieren Sie sie für zusätzlichen Schutz vor nicht autorisierten Apps.** |

### Tokenlizenznachrichten

| **FWLSE3125E** | **Die native Bibliothek von Rational Common Licensing wurde nicht gefunden. Stellen Sie sicher, dass die JVM-Eigenschaft (java.library.path) mit dem richtigen Pfad definiert ist und dass die native Bibliothek ausgeführt werden kann. Starten Sie IBM MobileFirst Platform Server nach der Fehlerberichtigung neu.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Setzen Sie in der Anwendungsserverkonfiguration nicht die JVM-Eigenschaft (java.library.path), die auf die native RCL-Bibliothek zeigt. Dann wird diese Nachricht bei der Laufzeitsynchronisation ausgelöst. |
| **FWLSE3126E** | **Die gemeinsame Bibliothek von Rational Common Licensing wurde nicht gefunden. Stellen Sie sicher, dass die gemeinsame Bibliothek konfiguriert ist. Starten Sie IBM MobileFirst Platform Server nach der Fehlerberichtigung neu.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Definieren Sie in der Anwendungsserverkonfiguration nicht den Pfad, der auf die RCL-Java-Bibliothek zeigt. Dann wird diese Nachricht bei der Laufzeitsynchronisation ausgelöst. |
| **FWLSE3127E** | **Die Rational-License-Key-Server-Verbindung ist nicht konfiguriert. Stellen Sie sicher, dass die JNDI-Verwaltungseigenschaften "{0}" und "{1}" definiert sind. Starten Sie IBM MobileFirst Platform Server nach der Fehlerberichtigung neu.**<br/><br/>{0} ist der Hostname des Lizenzservers. {1} ist der Port des Lizenzservers.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Setzen Sie in der Anwendungsserverkonfiguration nicht die JNDI-Eigenschaften (für Tokenlizenzierung). Dann wird diese Nachricht bei der Laufzeitsynchronisation ausgelöst. |
| **FWLSE3128E** | **Auf den Rational License Key Server "{0}" kann nicht zugegriffen werden. Stellen Sie sicher, dass der Lizenzserver aktiv und für IBM MobileFirst Platform Server zugänglich ist. Tritt dieser Fehler beim Start der Laufzeit auf, starten Sie IBM MobileFirst Platform Server nach der Fehlerberichtigung neu.**<br/><br/>{0} ist die vollständige Adresse des Lizenzservers.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Starten Sie den Lizenzserver nicht. Dann wird diese Nachricht bei der Laufzeitsynchronisation oder der Anwendungsimplementierung ausgelöst. |
| **FWLSE3129E** | **Nicht ausreichende Tokenlizenzen für das Feature "{0}".** <br/><br/>{0} ist der Name des Lizenzfeatures. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Verbrauchen Sie alle Lizenzen des Lizenzservers. Dann wird diese Nachricht bei der Laufzeitsynchronisation oder der Anwendungsimplementierung ausgelöst. |
| **FWLSE3130E** | **Die Tokenlizenzen für das Feature "{0}" sind abgelaufen.** <br/><br/>{0} ist der Name des Lizenzfeatures. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Lassen Sie zu, dass die Tokenlizenzen ablaufen. Dann wird diese Nachricht bei der Laufzeitsynchronisation oder der Anwendungsimplementierung ausgelöst. |
| **FWLSE3131E** | **Ein Lizenzfehler wurde festgestellt. Überprüfen Sie, ob die Anwendungsserverprotokolle weitere Details enthalten.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. |
| **FWLSE3132E** | **Die Verbindung zu Rational License Key Server ist mit den JNDI-Verwaltungseigenschaften "{0}" und "{1}" konfiguriert. Für diesen IBM MobileFirst Platform Server ist jedoch keine Tokenlizenzierung aktiviert. ** <br/><br/>{0} ist der Hostname des Lizenzservers. {1} ist der Port des Lizenzservers.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Aktivieren Sie keine Tokenlizenzierung. Setzen Sie aber in der Anwendungsserverkonfiguration die JNDI-Eigenschaften (für Tokenlizenzierung). Dann wird diese Nachricht bei der Laufzeitsynchronisation ausgelöst. |
| **FWLSE3133I** | **Diese Anwendung ist inaktiviert. Bitten Sie den Administrator um weitere Informationen.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Lassen Sie zu, dass die Tokenlizenzen ablaufen. Dann werden alle Anwendungen automatisch inaktiviert. Greift danach ein Gerät auf die Anwendung zu, erscheint diese Nachricht. |
| **FWLSE3134E** | **Die native Bibliothek von Rational Common Licensing wurde nicht gefunden.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3135E** | **Die gemeinsame Bibliothek von Rational Common Licensing wurde nicht gefunden.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3136E** | **Die Details von Rational License Key Server sind nicht konfiguriert.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3137E** | **Auf den Rational License Key Server "{0}" kann nicht zugegriffen werden.** <br/><br/>{0} ist die vollständige Adresse des Lizenzservers.<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3138E** | **Nicht ausreichende Tokenlizenzen für das Feature "{0}".** <br/><br/>{0} ist der Name des Lizenzfeatures. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3139E** | **Die Tokenlizenzen für das Feature "{0}" sind abgelaufen.** <br/><br/>{0} ist der Name des Lizenzfeatures. <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3140E** | **Ein Lizenzfehler wurde festgestellt.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |
| **FWLSE3141E** | **Die Details von Rational License Key Server sind konfiguriert.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Erfordert interne Speicherung in einer Datenbank. |

### Nachrichten zur Farmkonfiguration

| **FWLSE3200W** | **Der Server "{0}" kann nicht als neues Farm-Member hinzugefügt werden, weil bereits ein Server mit dieser ID für die Laufzeit "{1}" registriert ist. Dies kann passieren, wenn die JNDI-Eigenschaft mfp.admin.serverid auf einem anderen aktiven Knoten denselben Wert hat oder Ihr Server beim letzten Herunterfahren seine Registrierung nicht ordnungsgemäß aufgehoben hat.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch tritt dieser Fehler auf, wenn Sie eine Server-Farm falsch konfigurieren. Eine Server-Farm besteht aus mehreren Computern (Knoten). Jeder Computer muss eine ID haben (JNDI-Eigenschaft mfp.admin.serverid). Wenn Sie dieselbe ID für zwei verschiedene Knoten verwenden, erscheint diese Nachricht im Serverprotokoll. |
| **FWLSE3201E** | **Die Registrierung des Farm-Members "{0}" für die Laufzeit "{1}" konnte nicht aufgehoben werden.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kann der Fehler in den Serverprotokollen auftauchen, wenn Sie eine Server-Farm haben, jedoch einen Knoten der Farm herunterfahren und bei diesem Prozess ein Fehler auftritt. |
| **FWLSE3202E** | **Für den Server "{0}" konnte die Liste der Farm-Member nicht abgerufen werden.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kann der Fehler in den Serverprotokollen auftauchen, wenn die Verwaltungsservices in einer Server-Farm heruntergefahren werden und danach versucht wird, die Farm-Member darüber zu informieren. Dafür wird eine Liste der Farm-Member benötigt. |
| **FWLSE3203E** | **Kein Farmknoten ist mit der Server-ID "{0}" für die Laufzeit "{1}" registriert.** |
| **FWLSE3204W** | **Der Knoten "{0}" scheint nicht erreichbar zu sein. Diese Transaktion wurde auf diesem Knoten nicht ausgeführt.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kommt diese Warnung bei einer Server-Farm vor, wenn Sie einen Farmknoten vom Netz trennen und lange genug warten. Die Warnung erscheint dann im Serverprotokoll. |
| **FWLSE3205W** | **Die Laufzeit "{0}" des Servers "{1}" kann nicht in den Denial-of-Service-Modus versetzt werden. Sie können diese Warnung ignorieren, wenn die Laufzeit auch beendet wird.** <br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kommt diese Warnung bei einer Server-Farm vor, wenn Sie einen Farmknoten vom Netz trennen und lange genug warten oder den Server herunterfahren. Zusätzlich zur normalen Verarbeitung muss jedoch eine Ausnahme eintreten (z. B. eine OutOfMemory-Ausnahme). |
| **FWLSE3206E** | **Die Aufhebung der Registrierung des Servers "{0}" für die Laufzeit "{1}" ist nicht zulässig, weil der Server noach aktiv zu sein scheint.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch könnten Sie diesen Fehler reproduzieren, indem Sie die REST-API aufrufen, um einen Farm-Knoten zu entfernen, während dieser aktiv ist. |
| **FWLSE3207E** | **Der Farm-Member mit der Server-ID "{0}" ist nicht erreichbar. Versuchen Sie es später erneut.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Theoretisch kommt dieser Fehler bei einer Server-Farm vor, wenn Sie einen Farmknoten vom Netz trennen und dann versuchen, eine WLAPP zu implementieren. Die Transaktion wird scheitern, und diese Nchricht erscheint im Fehlerprotokoll (in dem über die Benutzerschnittstelle zugänglichen Transaktionsprotokoll). |
| **FWLSE3208E** | **Der ungültige Statuscode "{0}" wurde zurückgegeben. Inhalt der Antwort: "{1}".**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Dieser Fehler kann immer dann auftreten, wenn von einem REST-Aufruf des Konfigurationsservice ein unerwarteter Statuscode zurückgegeben wird. |
| **FWLSE3209E** | **Beim Aufrufen des Konfigurationsservice ist eine Ausnahme eingetreten. Ausnahmenachricht: "{0}".**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Dieser Fehler kann immer dann auftreten, wenn es im Konfigurationsservice Probleme mit CRUD-Operationen bezogen auf Konfigurationen gibt. Diese Ausnahme ist generisch und bezieht sich auf mehrere Fehler. |
| **FWLSE3210E** | **Die Ressource(n), die Sie zu exportieren versuchen ({0}), wurde(n) nicht gefunden.** |
| **FWLSE3211E** | **Der resourceInfos-Parameter {0} ist falsch angegeben. Der Parameter muss einen Wert im Format Ressourcenname\|\|Ressourcentyp haben.** |

## Nachrichten der {{ site.data.keys.mf_console }}

**Präfix:** FWLSE<br/>
**Bereich:** 3300-3399

| **FWLSE3301E** | **Es liegt ein Problem mit SSL-Zertifikaten vor. Mögliche Lösung: Stellen Sie das Zertifikat des Anwendungsservers in den Truststore oder setzen Sie die JNDI-Eigenschaft {0} auf {1} (nicht in Produktionsumgebungen).**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Schwierig. Der Fehler tritt auf, wenn Sie den Server mit SSL einrichten, aber ein falsches SSL-Zertifikat verwenden. Unter bestimmten Umständen kann er auch bei Verwendung selbst signierter Zertifikate auftreten. |
| **FWLSE3302E** | **Der Keystore für die Laufzeit "{0}" ist nicht in der MobileFirst-Verwaltungsdatenbank vorhanden. Möglicherweise ist die Datenbank beschädigt.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Der Keystore fehlt. |
| **FWLSE3303E** | **Der Anwendungsname "{0}", die Umgebung "{1}" und die Version "{2}" aus den Webressourcen-/Authentizitätsdaten stimmen nicht mit den Werten der implementierten Anwendung überein.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Laden Sie eine Webressource hoch, die für eine andere Anwendung generiert wurde. |
| **FWLSE3304E** | **Die JNDI-Eigenschaft "{0}" ist nicht gesetzt. Der Push-Service ist für diesen Server nicht aktiviert.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Geben Sie eine falsche Push-Server-URL an. |
| **FWLSE3305E** | **Der Keystore-Alias darf nicht null sein.**<br/><br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Versuchen Sie, einen Keystore hochzuladen, und übergehen Sie die Angaben in den Feldern für Kennwort und Alias. |
| **FWLSE3306E** | **Das Keystore-Kennwort darf nicht null sein.**|
| **FWLSE3307E** | **Der Alias "{0}" wurde nicht in diesem Keystore gefunden.** |
| **FWLSE3308E** | **Abweichung beim Aliaskennwort.** |
| **FWLSE3309E** | **Das Aliaskennwort darf nicht null sein.**|
| **FWLSE3310W** | **Der Server erlaubt nur die Implementierung von "{0}" Anwendungen.** <br/>{::nomarkdown}<i>Reproduzieren des Fehlers:</i>{:/}<br/> Versuchen Sie, Apps über die von der JNDI-Eigenschaft mfp.admin.max.apps festgelegte Begrenzung hinaus zu implementieren. |
