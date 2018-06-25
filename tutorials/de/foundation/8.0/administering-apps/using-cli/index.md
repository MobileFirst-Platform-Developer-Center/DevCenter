---
layout: tutorial
title: Anwendungen mit einem Terminal verwalten
breadcrumb_title: Administrating using terminal
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können MobileFirst-Anwendungen mit dem Prgramm **mfpadm** verwalten.

>Versionen des {{ site.data.keys.product_full }} SDK, die aktueller als Version **8.0.0.0-MFPF-IF201701250919** sind, stellen eine aktualisierte Unterstützung für die App-Authentizität bereit und können mit `mfpadm`-Befehlen zwischen der dynamischen und statischen Validierung (`dynamic` oder `static`)umschalten oder die Validierung zurücksetzen.

>
Navigieren Sie im Installationsverzeichnis der {{ site.data.keys.product_full }} zu `/MobilefirstPlatformServer/shortcuts` und führen Sie die `mfpadm`-Befehle aus. 
>
1. Umschaltung zwischen den Validierungstypen: 
```bash
	mfpadm --url=  --user=  --passwordfile= --secure=false app version [LAUFZEIT] [APP-NAME] [UMGEBUNG] [VERSION] set authenticity-validation TYP
```  
Der Wert für *TYP* kann `static` oder `dynamic` sein.
>
Beispiel für die Festlegung des Validierungstyps `dynamic` unter Android: 
```bash
 mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp test android 1.0 set authenticity-validation dynamic
```
>
2. Zurücksetzen der Daten und damit verbundenes Löschen des elektronischen Fingerabdrucks der App: 
```bash
 mfpadm --url=  --user=  --passwordfile= --secure=false app version [LAUFZEIT] [APP-NAME] [UMGEBUNG] [VERSION] reset authenticity
```
Beispiel:
>
```bash
 mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp sample.com.pincodeandroid android 1.0 reset authenticity
```

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Vergleich mit anderen Funktionen](#comparison-with-other-facilities)
* [Voraussetzungen](#prerequisites)

## Vergleich mit anderen Funktionen
{: #comparison-with-other-facilities }
In der
{{ site.data.keys.product_full }} gibt es folgende
Möglichkeiten für die Ausführung von Verwaltungsoperationen: 

* Interaktive {{ site.data.keys.mf_console }}
* Ant-Task mfpadm
* Programm **mfpadm**
* {{ site.data.keys.product_adj }}-REST-Services für Administration

Die Ant-Task **mfpadm**, das Programm mfpadm und die REST-Services
sind für eine automatisierte oder unbeaufsichtigte Ausführung von Operationen in folgenden Situationen hilfreich: 

* Vermeidung von Bedienerfehlern bei sich wiederholenden Operationen
* Ausführen von Operationen außerhalb der Regelarbeitszeit des Bedieners
* Konfigurieren eines Produktionsservers mit denselben Einstellungen wie ein Test- oder Vorproduktionsserver 

Das Programm **mfpadm** und die Ant-Task mfpadm sind einfacher zu verwenden und geben bessere Fehlermeldungen als die REST-Services. Das Programm
mfpadm hat gegenüber der Ant-Task mfpadm den Vorteil, dass es leichter zu integrieren ist, sofern bereits
eine Betriebssystembefehlseinbindung verfügbar ist. Außerdem ist das Programm besser für die interaktive Verwendung geeignet.

## Voraussetzungen
{: #prerequisites }
Das Tool
**mfpadm** wird mit dem Installationsprogramm für
{{ site.data.keys.mf_server }} installiert. In den folgenden Ausführungen
steht **Produktinstallationsverzeichnis** für das Installationsverzeichnis des Installationsprogramms für {{ site.data.keys.mf_server }}. 

Der Befehl **mfpadm** wird im Verzeichnis **Produktinstallationsverzeichnis/shortcuts/** in Form von Scripts bereitgestellt:

* mfpadm für UNIX/Linux
* mfpadm.bat für Windows

Diese Scripts können sofort ausgeführt werden. Sie erfordern keine bestimmten
Umgebungsvariablen. Wenn die Umgebungsvariable **JAVA_HOME** gesetzt ist, wird sie von den Scripts akzeptiert.  
Für die Verwendung
des Programms **mfpadm** müssen Sie das Verzeichnis
**Produktinstallationsverzeichnis/shortcuts/** in Ihre Umgebungsvariable PATH aufnehmen oder bei jedem Aufruf auf den absoluten Dateinamen verweisen.

Weitere Informationen zum Ausführen des Installationsprogramms für
{{ site.data.keys.mf_server }} finden Sie unter
[IBM Installation Manager ausführen](../../installation-configuration/production/installation-manager/).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-1 }

* [Programm **mfpadm** aufrufen](#calling-the-mfpadm-program)
* [Befehle für allgemeine Konfiguration](#commands-for-general-configuration)
* [Befehle für Adapter](#commands-for-adapters)
* [Befehle für Apps](#commands-for-apps)
* [Befehle für Geräte](#commands-for-devices)
* [Befehle für Fehlersuche](#commands-for-troubleshooting)


### Programm **mfpadm** aufrufen
{: #calling-the-mfpadm-program }
Mit dem Programm **mfpadm** können Sie MobileFirst-Anwendungen verwalten. 

#### Syntax
{: #syntax }
Das Programm mfpadm wird wie folgt
aufgerufen: 

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] ein Befehl
```

Das Programm **mfpadm** wird mit folgenden Optionen verwendet: 

| Option	| Typ| Beschreibung | Erforderlich | Standardwert |
|-----------|------|-------------|----------|---------|
| --url| 	 | URL| Basis-URL der {{ site.data.keys.product_adj }}-Webanwendung für Verwaltungsservices| Ja | |
| --secure	 | Boolescher Wert| Angabe, ob Operationen mit Sicherheitsrisiko vermieden werden sollen| Nein | true |
| --user	 | Name | Benutzername für den Zugriff auf die MobileFirst-Verwaltungsservices| Ja |  | 	 
| --passwordfile | Datei | Datei mit dem Kennwort für den Benutzer | Nein |
| --timeout	     | Zahl | Zeitlimit für den Zugriff auf den gesamten REST-Service in Sekunden | Nein | 	 
| --connect-timeout| Zahl| Zeitlimit für das Herstellen einer Netzverbindung in Sekunden| Nein |
| --socket-timeout| Zahl| Zeitlimit für das Erkennen des Verlusts einer Netzverbindung in Sekunden| Nein |
| --connection-request-timeout| Zahl | Zeitlimit (in Sekunden) für das Abrufen eines Eintrags aus einem Pool für Verbindungsanforderungen| Nein |
| --lock-timeout| Zahl| Zeitlimit für das Anfordern einer Sperre in Sekunden| Nein | 2 |
| --verbose	   | | Ausführliche Ausgabe| Nein | |  

**url**  
In der URL wird bevorzugt das Protokoll HTTPS verwendet. Wenn Sie beispielsweise die Standardports und -kontextstammelemente nutzen, verwenden Sie die
folgende URL: 

* WebSphere Application Server: https://server:9443/mfpadmin
* Tomcat: https://server:8443/mfpadmin

**secure**  
Die Option `--secure` ist
standardmäßig auf "true" gesetzt. Die Einstellung `--secure=false` kann folgende Auswirkungen haben: 

* Der Benutzer und das Kennwort könnten auf ungeschütztem Wege (möglicherweise sogar mit unverschlüsseltem HTTP)
übertragen werden. 
* Die SSL-Zertifikate des Servers werden auch dann akzeptiert, wenn es sich um selbst signierte Zertifikate handelt oder um Zertifikate, die für einen anderen als den Hostnamen des Servers
erstellt wurden. 

**password**  
Geben Sie das Kennwort in einer gesonderten, mit der Option
`--passwordfile` übergebenen Datei an.
Im interaktiven Modus können Sie das Kennwort interaktiv angeben (siehe "Interaktiver Modus"). Ein Kennwort ist eine sensible Information, die geschützt werden muss.
Sie müssen verhindern, dass andere Benutzer desselben Computers diese Kennwörter kennen.
Bevor Sie das Kennwort in einer Datei eingeben, müssen Sie die Leseberechtigung für die Datei für alle Benutzer bis auf Sie selbst
entfernen, um das Kennwort zu schützen. Sie
können beispielsweise einen der folgenden Befehle verwenden:

* UNIX: `chmod 600 adminpassword.txt`
* Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Aus denselben Gründen sollten Sie das Kennwort nicht als Befehlszeilenargument
an einen Prozess übergeben. Unter vielen Betriebssystemen können andere Benutzer die Befehlszeilenargumente
Ihrer Prozesse überprüfen. 

Der Aufruf von mfpadm enthält einen Befehl. Die folgenden Befehle werden unterstützt:

| Befehl| Beschreibung |
|-----------------------------------|-------------|
| show info	| Zeigt Benutzer- und Konfigurationsdaten an|
| show global-config| Zeigt globale Konfigurationsdaten an |
| show diagnostics| Zeigt Diagnoseinformationen an|
| show versions	| Zeigt Versionsinformationen an |
| unlock| Hebt die allgemeine Sperre auf|
| list runtimes [--in-database]| Listet die Laufzeiten auf |
| show runtime [Laufzeitname] | Zeigt Informationen zu einer Laufzeit an|
| delete runtime [Laufzeitname] Bedingung | Löscht eine Laufzeit|
| show user-config [Laufzeitname]| Zeigt die Benutzerkonfiguration einer Laufzeit an|
| set user-config [Laufzeitname] Datei| Gibt die Benutzerkonfiguration einer Laufzeit an|
| set user-config [Laufzeitname] Eigenschaft = Wert| Gibt eine Eingenschaft in der Benutzerkonfiguration einer Laufzeit an|
| show confidential-clients [Laufzeitname]| Zeigt die Konfiguration geheimer Clients einer Laufzeit an|
| set confidential-clients [Laufzeitname] Datei| Gibt die Konfiguration geheimer Clients einer Laufzeit an|
| set confidential-clients-rule [Laufzeitname] ID Anzeigename geheimer Schlüssel zulässiger Bereich| Gibt eine Regel für die Konfiguration vertraulicher Clients einer Laufzeit an|
| list adapters [Laufzeitname] | Listet die Adapter auf |
| deploy adapter [Laufzeitname] Eigenschaft = Wert| Implementiert einen Adapter|
| show adapter [Laufzeitname] Adaptername | Zeigt Informationen zu einem Adapter an|
| delete adapter [Laufzeitname] Adaptername | Löscht einen Adapter|
| adapter [Laufzeitname] Adaptername get binary [> Zieldatei]| Ruft die Binärdaten eines Adapters ab|
| list apps [Laufzeitname] | Listet die Apps auf |
| deploy app [Laufzeitname] Datei | Implementiert eine App|
| show app [Laufzeitname] App-Name | Zeigt Informationen zu einer App an|
| delete app [Laufzeitname] App-Name | Löscht eine App |
| show App-Version [Laufzeitname] App-Name Umgebung Version| Zeigt Informationen zu einer App-Version an|
| delete App-Version [Laufzeitname] App-Name Umgebung Version| Löscht eine App-Version|
| app [Laufzeitname] App-Name show license-config| Zeigt die Tokenlizenzkonfiguration einer App an|
| app [Laufzeitname] App-Name set license-config App-Typ für Lizenzierung Lizenztyp| Gibt die Tokenlizenzkonfiguration einer App an|
| app [Laufzeitname] App-Name delete license-config| Entfernt die Tokenlizenzkonfiguration einer App |
| app version [Laufzeitname] App-Name Umgebung Version get descriptor [> Zieldatei] | Ruft den Deskriptor für eine App-Version ab|
| app version [Laufzeitname] App-Name Umgebung Version get web-resources [> Zieldatei] | Ruft die Webressourcen für eine App-Version ab|
| app version [Laufzeitname] App-Name Umgebung Version set web-resources Datei| Gibt die Webressourcen für eine App-Version an|
| app version [Laufzeitname] App-Name Umgebung Version get authenticity-data [> Zieldatei] | Ruft die Authentizitätsdaten für eine App-Version ab|
| app version [Laufzeitname] App-Name Umgebung Version set authenticity-data [Datei] | Gibt die Authentizitätsdaten für eine App-Version an|
| app version [Laufzeitname] App-Name Umgebung Version delete authenticity-data | Löscht die Authentizitätsdaten für eine App-Version|
| app version [Laufzeitname] App-Name Umgebung Version show user-config | Zeigt die Benutzerkonfiguration einer App an|
| app version [Laufzeitname] App-Name Umgebung Version set user-config Datei | Gibt die Benutzerkonfiguration einer App an|
| app version [Laufzeitname] App-Name Umgebung Version set user-config Eigenschaft = Wert | Gibt eine Eingenschaft in der Benutzerkonfiguration einer App-Version an|
| list devices [Laufzeitname][--query Abfrage] | Listet die Geräte auf |
| remove device [Laufzeitname] ID | Entfernt ein Gerät|
| device [Laufzeitname] ID set status neuer_Status | Ändert den Status eines Geräts|
| device [Laufzeitname] ID set appstatus App-Name neuer_Status| Ändert den Status eines Geräts für eine App|
| list farm-members [Laufzeitname]| Listet die Server auf, die Member einer Server-Farm sind|
| remove farm-member [Laufzeitname] Server-ID| Entfent einen Server aus der Liste der Farmmember|

#### Interaktiver Modus
{: #interactive-mode }
Alternativ können Sie
**mfpadm** ohne Angabe eines Befehls in der Befehlszeile aufrufen. Bei der interaktiven Befehlseingabe geben Sie jeweils einen Befehl pro Zeile ein. Mit dem Befehl
`exit` oder einem Dateiendezeichen (EOF, end-of-file)
in der Standardeingabe (auf UNIX-Terminals **Strg-D**)
wird mfpadm beendet. 

In diesem Modus sind auch Hilfebefehle (`help`) wie die folgenden verfügbar: 

* help
* help show versions
* help device
* help device set status

#### Befehlsprotokoll im interaktiven Modus
{: #command-history-in-interactive-mode }
Unter einigen Betriebssystemen
merkt sich der interaktive Befehl mfpadm das Befehlsprotokoll. Im Befehlsprotokoll können Sie über die Taste mit dem Aufwärtspfeil und die Taste mit dem Abwärtspfeil
einen vorherigen Befehl auswählen, bearbeiten und dann ausführen. 

**Linux**  
Das Befehlsprotokoll wird in Terminalemulatorfenstern
aktiviert, wenn das Paket rlwrap installiert ist und im
PATH gefunden wird. Installieren Sie das Paket rlwrap wie folgt: 

* Red Hat Linux: `sudo yum install rlwrap`
* SUSE Linux: `sudo zypper install rlwrap`
* Ubuntu: `sudo apt-get install rlwrap`

**OS X**  
Das Befehlsprotokoll wird im Terminalprogramm
aktiviert, wenn das Paket rlwrap installiert ist und im
PATH gefunden wird. Installieren Sie das Paket rlwrap wie folgt: 

1. Installieren Sie MacPorts mit dem Installationsprogramm von [www.macports.org](http://www.macports.org).
2. Führen Sie den Befehl `sudo /opt/local/bin/port install rlwrap` aus. 
3. Machen Sie das Programm rlwrap dann über den
PATH verfügbar. Verwenden Sie in einer Bourne-kompatiblen Shell den folgenden
Befehl: `PATH=/opt/local/bin:$PATH`. 

**Windows**  
Das Befehlsprotokoll wird in Konsolenfenstern, die mit
cmd.exe aufgerufen werden, aktiviert. 

In Umgebungen, in denen rlwrap nicht funktioniert oder nicht
erforderlich ist, können Sie das Programm mit der Option `--no-readline` inaktivieren. 

#### Konfigurationsdatei
{: #the-configuration-file }
Sie können die Optionen auch in einer Konfigurationsdatei
speichern, anstatt sie bei jedem Aufruf in der Befehlszeile zu übergeben. Wenn eine
Konfigurationsdatei vorhanden und die Option
–configfile=Datei angegeben ist, können Sie die folgenden Optionen weglassen: 

* --url=URL
* --secure=boolescher Wert
* --user=Name
* --passwordfile=Datei
* --timeout=Sekunden
* --connect-timeout=Sekunden
* --socket-timeout=Sekunden
* --connection-request-timeout=Sekunden
* --lock-timeout=Sekunden
* Laufzeitname

In der Konfigurationsdatei werden diese Werte mit folgenden Befehlen gespeichert: 

| Befehl| Kommentar|
|---------|---------|
| mfpadm [--configfile=Datei] config url URL| |
| mfpadm [--configfile=Datei] config secure boolescher Wert| |
| mfpadm [--configfile=Datei] config user Name| |
| mfpadm [--configfile=Datei] config password| Fordert zur Eingabe des Kennworts auf|
| mfpadm [--configfile=Datei] config timeout Sekunden| |
| mfpadm [--configfile=Datei] config connect-timeout Sekunden| |
| mfpadm [--configfile=Datei] config socket-timeout Sekunden| |
| mfpadm [--configfile=Datei] config connection-request-timeout Sekunden| |
| mfpadm [--configfile=Datei] config lock-timeout Sekunden| |
| mfpadm [--configfile=Datei] config runtime Laufzeitname| |

Die in der Konfigurationsdatei gespeicherten Werte können mit dem Befehl `mfpadm [--configfile=Datei] config` aufgelistet werden. 

Die Konfigurationsdatei ist eine Textdatei in der Codierung der aktuellen Ländereinstellung und mit der Java-**.properties**-Syntax.
Die Standardkonfigurationsdateien sind folgende: 

* UNIX: **${HOME}/.mfpadm.config**
* Windows: **{{ site.data.keys.prod_server_data_dir_win }}\mfpadm.config**

**Hinweis:** Wenn Sie die Option `--configfile` nicht angeben, wird die
Standardkonfigurationsdatei nur im interaktiven Modus und in config-Befehlen verwendet. Bei der nicht interaktiven Verwendung der anderen Befehle müssen Sie
die Konfigurationsdatei explizit angeben, sofern Sie eine Konfigurationsdatei verwenden möchten. 

> **Wichtiger Hinweis:** Das Kennwort wird in einem verschleierten Format gespeichert, um es vor
zufälliger Einsichtnahme zu schützen. Diese Verschleierung bietet jedoch keine Sicherheit. 

#### Generische Optionen
{: #generic-options }
Zusätzlich stehen die üblichen generischen Optionen zur Verfügung: 

| Option	| Beschreibung |
|-----------|-------------|
| --help	| Zeigt Hilfe zur Verwendung an |
| --version	| Zeigt die Version an |

#### XML-Format
{: #xml-format }
Bei Befehlen, die vom Server eine XML-Antwort empfangen, wird überprüft, ob diese Antwort
dem konkreten Schema entspricht. Sie können diese Überprüfung durch Angabe von `--xmlvalidation=none` inaktivieren. 

#### Ausgabezeichensatz
{: #output-character-set }
Vom Programm
mfpadm erzeugte normale Ausgaben haben das Codierformat der aktuellen Ländereinstellung. Unter Windows wird dieses Codierformat
als "ANSI-Codepage" bezeichnet. Die Codierung hat folgende
Auswirkungen: 

* Nicht zu diesem Zeichensatz gehörende Zeichen werden bei der Ausgabe in Fragezeichen konvertiert. 
* Wenn die Ausgabe an ein Fenster mit Windows-Eingabeaufforderung
(cmd.exe) gesendet wird, werden Nicht-ASCII-Zeichen nicht ordnungsgemäß angezeigt, weil ein solches Fenster davon ausgeht, dass
Zeichen in der
"OEM-Codepage" codiert sind.

Diese Einschränkung können Sie wie folgt umgehen: 

* Verwenden Sie unter anderen Betriebssystemen als Windows
eine Ländereinstellung mit der Codierung UTF-8. Für
Red Hat Linux und OS X ist dieses Format die Standardländereinstellung. Viele andere Betriebssysteme haben
die Ländereinstellung
`en_US.UTF-8`. 
* Sie können auch die Ant-Task mfpadm mit dem Attribut `output="Dateiname"` verwenden, um die Ausgabe eines
Befehls an eine Datei zu senden. 

### Befehle für allgemeine Konfiguration
{: #commands-for-general-configuration }
Wenn Sie das Programm **mfpadm** aufrufen, können Sie diverse Befehle für den Zugriff auf {{ site.data.keys.mf_server }} oder auf
eine Laufzeit
einbeziehen. 

#### Befehl `show global-config`
{: #the-show-global-config-command }
Der Befehl `show global-config` zeigt die globale Konfiguration an. 

Syntax: `show global-config`

Der Befehl wird mit folgenden Optionen verwendet:

| Argument | Beschreibung |
|----------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**  

```bash
show global-config
```

Dieser Befehl basiert auf dem REST-Service [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-).

<br/>
#### Befehl `show user-config`
{: #the-show-user-config-command }
Der Befehl `show user-config` zeigt die Benutzerkonfiguration für eine Laufzeit an.

Syntax: `show user-config [--xml] [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `show user-config` kann mit folgenden Optionen nach dem Verb angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|-------------|----------|---------|
| --xml | Erzeugt Ausgaben nicht im JSON-Format, sondern im XML-Format | Nein | Standardausgabe |

**Beispiel**  

```bash
show user-config mfp
```

Dieser Befehl basiert auf dem REST-Service [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Befehl `set user-config`
{: #the-set-user-config-command }
Der Befehl `set user-config` gibt die Benutzerkonfiguration für eine Laufzeit oder eine einzelne Eigenschaft innerhalb dieser Konfiguration an. 

Syntax für die gesamte Konfiguration: `set user-config [Laufzeitname] Datei`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Attribut | Beschreibung |
|-----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Datei | Name der JSON- oder XML-Datei mit der neuen Konfiguration |

Syntax für eine einzelne Eigenschaft: `set user-config [Laufzeitname] Eigenschaft = Wert`

Der Befehl `set user-config` wird mit folgenden Argumenten verwendet: 

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Eigenschaft | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. |
| Wert | Wert der Eigenschaft |

**Beispiele**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

Dieser Befehl basiert
auf dem REST-Service [Runtime Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-). 

<br/>
#### Befehl `show confidential-clients`
{: #the-show-confidential-clients-command }
Der Befehl `show
confidential-clients` zeigt die Konfigration der vertraulichen Clients an, die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). 

Syntax: `show confidential-clients [--xml] [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Attribut | Beschreibung |
|-----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `show
confidential-clients` kann mit folgenden Optionen nach dem
Verb
angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|-------------|----------|---------|
| --xml | Erzeugt Ausgaben nicht im JSON-Format, sondern im XML-Format | Nein | Standardausgabe |

**Beispiel**

```bash
show confidential-clients --xml mfp
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-). 

<br/>
#### Befehl `set confidential-clients`
{: #the-set-confidential-clients-command }
Der Befehl `set
confidential-clients` gibt die Konfigration der vertraulichen Clients an, die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). 

Syntax: `set confidential-clients [Laufzeitname] Datei`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Attribut | Beschreibung |
|-----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Datei | Name der JSON- oder XML-Datei mit der neuen Konfiguration |

**Beispiel**

```bash
set confidential-clients mfp clients.xml
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-). 

<br/>
#### Befehl `set confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
Der Befehl `set confidential-clients-rule` gibt eine Regel für
die Konfiguration der vertraulichen Clients an, die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). 

Syntax: `set confidential-clients-rule [Laufzeitname] ID Anzeigename geheimer_Schlüssel zulässiger_Bereich`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Attribut	| Beschreibung |
|-----------|-------------|
| Laufzeitname | Name der Laufzeit |
| ID | Kennung der Regel |
| Anzeigename | Anzeigename der Regel |
| geheimer_Schlüssel | Geheimer Schlüssel der Regel|
| zulässiger_Bereich | Liste mit durch Leerzeichen getrennten Token als Bereich für die Regel. Setzen Sie eine Liste mit zwei oder mehr Token in Anführungszeichen. |

**Beispiel**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-). 

### Befehle für Adapter
{: #commands-for-adapters }
Wenn Sie das Programm **mfpadm** aufrufen, können Sie diverse Befehle für Adapter
einbeziehen.

### Befehl `list adapters`
{: #the-list-adapters-command }
Der Befehl `list
adapters` gibt eine Liste der für eine Laufzeit implementierten Adapter zurück. 

Syntax: `list adapters [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `list
adapters` kann mit folgenden Optionen nach dem
Objekt
angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**  

```xml
list adapters mfp
```

Dieser Befehl basiert
auf dem REST-Service [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-). 

<br/>
#### Befehl `deploy adapter`
{: #the-deploy-adapter-command }
Mit dem Befehl `deploy
adapter` wird ein Adapter in einer Laufzeit implementiert.

Syntax: `deploy adapter [Laufzeit] Datei`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Datei | Binäre Adapterdatei (.adapter) |

**Beispiel**

```bash
deploy adapter mfp MyAdapter.adapter
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-). 

<br/>
#### Befehl `show adapter`
{: #the-show-adapter-command }
Der Befehl `show
adapter` zeigt Details zu einem Adapter an.

Syntax: `show adapter [Laufzeitname] Adaptername`

Der Befehl wird mit folgenden Argumenten verwendet.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Adaptername | Name eines Adapters |

Der Befehl `show
adapter` kann mit folgenden Optionen nach dem
Objekt
angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show adapter mfp MyAdapter
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Befehl `delete adapter`
{: #the-delete-adapter-command }
Mit dem Befehl `delete
adapter` wird ein Adapter aus einer Laufzeit entfernt (deimplementiert).

Syntax: `delete adapter [Laufzeitname] Adaptername`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Adaptername | Name eines Adapters |

**Beispiel**

```bash
delete adapter mfp MyAdapter
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-).

<br/>
#### Befehlspräfix `adapter`
{: #the-adapter-command-prefix }
Das Befehlspräfix `adapter` wird vor dem Verb mit folgenden Argumenten
angegeben.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Adaptername | Name eines Adapters |

<br/>
#### Befehl `adapter get binary`
{: #the-adapter-get-binary-command }
Der Befehl `adapter get binary` gibt die binäre Adapterdatei zurück.

Syntax: `adapter [Laufzeitname] Adaptername get binary [> Zieldatei]`

Nach dem Verb können die folgenden Optionen angegeben werden.

| Option | Beschreibung | Erforderlich | Standardwert |
|--------|-------------|----------|---------|
| > Zieldatei | Name der Ausgabedatei | Nein | Standardausgabe |

**Beispiel**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

Dieser Befehl basiert auf dem REST-Service [Export Runtime Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc). 

<br/>
#### Befehl `adapter show user-config`
{: #the-adapter-show-user-config-command }
Der Befehl
`adapter show user-config` zeigt die Benutzerkonfiguration des Adapters an. 

Syntax: `adapter [Laufzeitname] Adaptername show user-config [--xml]`

Nach dem Verb können die folgenden Optionen angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt Ausgaben nicht im JSON-Format, sondern im XML-Format |

**Beispiel**

```bash
adapter mfp MyAdapter show user-config
```

Dieser Befehl basiert
auf dem REST-Service [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-). 

<br/>
#### Befehl `adapter set user-config`
{: #the-adapter-set-user-config-command }
Der Befehl
`adapter set user-config` gibt die Benutzerkonfiguration des Adapters oder eine einzelne Eigenschaft innerhalb dieser Konfiguration
an. 

Syntax für die gesamte Konfiguration: `adapter [Laufzeitname] Adaptername set user-config Datei`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| Datei | Name der JSON- oder XML-Datei mit der neuen Konfiguration |

Syntax für eine einzelne Eigenschaft: `adapter [Laufzeitname] Adaptername set user-config Eigenschaft = Wert`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| Eigenschaft | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. |
| Wert | Wert der Eigenschaft |

**Beispiele**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

Dieser Befehl basiert auf dem REST-Service [Adapter Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc). 

### Befehle für Apps
{: #commands-for-apps }
Wenn Sie das Programm **mfpadm** aufrufen, können Sie diverse Befehle für Apps einbeziehen. 

#### Befehl `list apps`
{: #the-list-apps-command }
Der Befehl `list apps` gibt eine Liste der in einer Laufzeit implementierten Apps zurück.

Syntax: `list apps [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `list apps` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
list apps mfp
```

Dieser Befehl basiert auf dem REST-Service [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

#### Befehl `deploy app`
{: #the-deploy-app-command }
Mit dem Befehl `deploy app` wird eine App-Version in einer Laufzeit implementiert. 

Syntax: `deploy app [Laufzeit] Datei`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Datei | Anwendungsdeskriptor (eine JSON-Datei) |

**Beispiel**

```bash
deploy app mfp MyApp/application-descriptor.json
```

Dieser Befehl basiert auf dem REST-Service [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

#### Befehl `show app`
{: #the-show-app-command }
Der Befehl `show app` zeigt Einzelheiten einer App in einer Laufzeit an, insbesondere die Umgebungen und Versionen.

Syntax: `show app [Laufzeitname] App-Name`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |

Der Befehl `show app` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml	| Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show app mfp MyApp
```

Dieser Befehl basiert auf dem REST-Service [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

#### Befehl `delete app`
{: #the-delete-app-command }
Mit dem Befehl `delete app` wird eine App aus einer Laufzeit, d. h. allen Umgebungen und Versionen, entfernt (deimplementiert). 

Syntax: `delete app [Laufzeitname] App-Name`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |

**Beispiel**

```bash
delete app mfp MyApp
```

Dieser Befehl basiert auf dem REST-Service [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Befehl `show app version`
{: #the-show-app-version-command }
Mit dem Befehl `show app version` werden Details zu einer App-Version in einer Laufzeit angezeigt. 

Syntax: `show app version [Laufzeitname] App-Name Umgebung Version`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |
| Umgebung | Mobile Plattform |
| Version | Version der App |

Der Befehl `show app version` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Argument | Beschreibung |
| ---------|-------------|
| -- xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show app version mfp MyApp iPhone 1.1
```

Dieser Befehl basiert auf dem REST-Service [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

#### Befehl `delete app version`
{: #the-delete-app-version-command }
Mit dem Befehl `delete app version` wird eine App-Version aus einer Laufzeit entfernt (deimplementiert).

Syntax: `delete app version [Laufzeitname] App-Name Umgebung Version`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |
| Umgebung | Mobile Plattform |
| Version | Version der App |

**Beispiel**

```bash
delete app version mfp MyApp iPhone 1.1
```

Dieser Befehl basiert auf dem REST-Service [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

#### Befehlspräfix `app`
{: #the-app-command-prefix }
Das Befehlspräfix `app` wird mit folgenden Argumenten vor dem Verb angegeben.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |

#### Befehl `app show license-config`
{: #the-app-show-license-config-command }
Der Befehl `app show license-config` zeigt die Tokenlizenzkonfiguration für eine App an. 

Syntax: `app [Laufzeitname] App-Name show license-config`

Nach dem Objekt können die folgenden Optionen angegeben werden:

| Argument | Beschreibung |
|----------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
app mfp MyApp show license-config
```

Dieser Befehl basiert auf dem REST-Service [Application License Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

#### Befehl `app set license-config`
{: #the-app-set-license-config-command }
Der Befehl `app set license-config` gibt die Tokenlizenzkonfiguration für eine App an. 

Syntax: `app [Laufzeitname] App-Name set license-config App-Typ Lizenztyp`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung |
|----------|-------------|
| App-Typ | Typ einer App (B2C oder B2E) |
| Lizenztyp | Typ für eine Anwendung (APPLICATION, ADDITIONAL_BRAND_DEPLOYMENT oder NON_PRODUCTION) |

**Beispiel**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

Dieser Befehl basiert auf dem REST-Service [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc).

#### Befehl `app delete license-config`
{: #the-app-delete-license-config-command }
Der Befehl `app delete license-config` setzt die Tokenlizenzkonfiguration für eine App zurück (und versetzt sie damit in ihren ursprünglichen Zustand). 

Syntax: `app [Laufzeitname] App-Name delete license-config`

**Beispiel**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

Dieser Befehl basiert auf dem REST-Service [License Configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

#### Befehlspräfix `app version`
{: #the-app-version-command-prefix }
Das Befehlspräfix `app version` wird vor dem Verb mit folgenden Argumenten angegeben.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| App-Name | Name einer App |
| Umgebung | Mobile Plattform |
| Version | Version der App |

#### Befehl `app version get descriptor`
{: #the-app-version-get-descriptor-command }
Der Befehl `app version get descriptor` gibt den Anwendungsdeskriptor für eine App-Version zurück. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version get descriptor [> Zieldatei]`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|-------------|----------|---------|
| > Zieldatei | Name der Ausgabedatei | Nein | Standardausgabe |

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

Dieser Befehl basiert auf dem REST-Service [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

#### Befehl `app version get web-resources`
{: #the-app-version-get-web-resources-command }
Der Befehl `app version get web-resources` gibt die Webressourcen für eine App-Version als .zip-Datei zurück. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version get web-resources [> Zieldatei]`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|-------------|----------|---------|
| > Zieldatei | Name der Ausgabedatei | Nein | Standardausgabe |

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

Dieser Befehl basiert auf dem REST-Service [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

#### Befehl `app version set web-resources`
{: #the-app-version-set-web-resources-command }
Der Befehl `app version set web-resources` gibt die Webressourcen für eine App-Version an. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version set web-resources Datei` 

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung |
|----------|--------------|
| Datei | Name der Eingabedatei (muss eine ZIP-Datei sein) |

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

Dieser Befehl basiert auf dem REST-Service [Deploy a Web Resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

#### Befehl `app version get authenticity-data`
{: #the-app-version-get-authenticity-data-command }
Der Befehl `app version get authenticity-data` gibt die Authentizitätsdaten für eine App-Version zurück. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version get authenticity-data [> Zieldatei]`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|--------------|--------------|--------------|
| > Zieldatei | Name der Ausgabedatei | Nein | Standardausgabe |

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

Dieser Befehl basiert auf dem REST-Service [Export Runtime Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc). 

#### Befehl `app version set authenticity-data`
{: #the-app-version-set-authenticity-data-command }
Der Befehl `app version set authenticity-data` gibt die Authentizitätsdaten für eine App-Version an. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version set authenticity-data Datei` 

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung |
|----------|-------------|
| Datei | Name der Eingabedatei:<ul><li>Datei .authenticity_data</li><li>Gerätedatei (.ipa, .apk oder .appx), aus der die Authentizitätsdaten extrahiert werden</li></ul>|

**Beispiele**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

Dieser Befehl basiert auf dem REST-Service [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

#### Befehl `app version delete authenticity-data`
{: #the-app-version-delete-authenticity-data-command }
Der Befehl `app version delete authenticity-data` löscht die Authentizitätsdaten für eine App-Version. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version delete authenticity-data`

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

Dieser Befehl basiert auf dem REST-Service [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc). 

#### Befehl `app version show user-config`
{: #the-app-version-show-user-config-command }
Der Befehl `app version show user-config` zeigt die Benutzerkonfiguration für eine App-Version an. 

Syntax: `app version [Laufzeitname] App-Name Umgebung Version show user-config [--xml]`

Nach dem Verb können die folgenden Optionen angegeben werden.

| Argument | Beschreibung | Erforderlich | Standardwert |
|----------|-------------|----------|---------|
| [--xml] | Erzeugt Ausgaben nicht im JSON-Format, sondern im XML-Format | Nein | Standardausgabe |

**Beispiel**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

Dieser Befehl basiert auf dem REST-Service [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

### Befehl `app version set user-config`
{: #the-app-version-set-user-config-command }
Der Befehl `app version set user-config` gibt die Benutzerkonfiguration für eine App-Version oder eine einzelne Eigenschaft innerhalb dieser Konfiguration an. 

Syntax für die gesamte Konfiguration: `app version [Laufzeitname] App-Name Umgebung Version set user-config Datei`

Nach dem Verb können die folgenden Argumente angegeben werden.

| Argument | Beschreibung |
|----------|-------------|
| Datei | Name der JSON- oder XML-Datei mit der neuen Konfiguration |

Syntax für eine einzelne Eigenschaft: `app version [Laufzeitname] App-Name Umgebung Version set user-config Eigenschaft = Wert`

Der Befehl `app version set user-config` kann mit folgenden Argumenten nach dem Verb angegeben werden. 

| Argument | Beschreibung |
|----------|-------------|
| Eigenschaft | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. |
| Wert | Wert der Eigenschaft |

**Beispiele**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

Dieser Befehl basiert auf dem REST-Service [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc).

### Befehle für Geräte
{: #commands-for-devices }
Wenn Sie das Programm **mfpadm** aufrufen, können Sie diverse Befehle für Geräte einbeziehen.

#### Befehl `list devices`
{: #the-list-devices-command }
Der Befehl `list devices` gibt die Liste der Geräte zurück, die Kontakt mit den Apps einer Laufzeit hatten. 

Syntax: `list devices [Laufzeitname] [--query Abfrage]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Abfrage | Ein Anzeigename oder eine Benutzer-ID, nach dem bzw. der gesucht werden soll. Dieser Parameter gibt die zu suchende Zeichenfolge an. Zurückgegeben werden alle Geräte, deren Anzeigename oder Benutzer-ID diese Zeichenfolge enthält (wobei die Groß-/Kleinschreibung nicht unterschieden wird). |

Der Befehl `list devices` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiele**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

Dieser Befehl basiert auf dem [REST-Service Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-). 

#### Befehl `remove device`
{: #the-remove-device-command }
Mit dem Befehl `remove device` wird der Datensatz eines Gerätes gelöscht, das Kontakt zu den Apps einer Laufzeit hatte.

Syntax: `remove device [Laufzeitname] ID`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| ID | Eindeutige Gerätekennung |

**Beispiel**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

Dieser Befehl basiert auf dem REST-Service [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

#### Befehlspräfix `device`
{: #the-device-command-prefix }
Das Befehlspräfix `device` wird mit folgenden Argumenten vor dem Verb angegeben.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| ID | Eindeutige Gerätekennung |

#### Befehl `device set status`
{: #the-device-set-status-command }
Mit dem Befehl `device set status` wird der Status eines Geräts im Geltungsbereich einer Laufzeit geändert.

Syntax: `device [Laufzeitname] ID set status neuer_Status`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| neuer_Status | Neuer Status |

Folgende Statuswerte sind möglich:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Beispiel**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

Dieser Befehl basiert auf dem REST-Service [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

#### Befehl `device set appstatus`
{: #the-device-set-appstatus-command }
Mit dem Befehl `device set appstatus` wird der Status eines Geräts hinsichtlich einer App in einer Laufzeit geändert.

Syntax: `device [Laufzeitname] ID set appstatus App-Name neuer_Status`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| App-Name | Name einer App |
| neuer_Status | Neuer Status |

Folgende Statuswerte sind möglich:

* ENABLED
* DISABLED


**Beispiel**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

Dieser Befehl basiert auf dem REST-Service [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Befehle für Fehlersuche
{: #commands-for-troubleshooting }
Wenn Sie das Programm **mfpadm** aufrufen, können Sie diverse Befehle für die Fehlersuche einbeziehen.

#### Befehl `show info`
{: #the-show-info-command }
Der Befehl `show info` zeigt Basisinformationen zu den MobileFirst-Verwaltungsservices an, die ohne Zugriff auf eine Laufzeit oder Datenbank zurückgegeben werden können. Mit diesem Befehl können Sie testen, ob die MobileFirst-Verwaltungsservices überhaupt ausgeführt werden.

Syntax: `show info`

Nach dem Objekt können die folgenden Optionen angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show info
```

#### Befehl `show versions`
{: #the-show-versions-command }
Der Befehl `show versions` zeigt die MobileFirst-Versionen verschiedener Komponenten an. 

* **mfpadmVersion**: Die genaue Nummer der MobileFirst-Server-Version, deren Datei **which mfp-ant-deployer.jar** verwendet wird.
* **productVersion**: Die genaue Nummer der MobileFirst-Server-Version, deren Datei **mfp-admin-service.war** verwendet wird.
* **mfpAdminVersion**: Die genaue Nummer der Buildversion der Datei **mfp-admin-service.war**

Syntax: `show versions`

Nach dem Objekt können die folgenden Optionen angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show versions
```

#### Befehl `show diagnostics`
{: #the-show-diagnostics-command }
Der Befehl `show diagnostics` zeigt den Status diverser Komponenten an, die für einen ordnungsgemäßen Betrieb des {{ site.data.keys.product_adj }}-Verwaltungsservice erforderlich sind, z. B. die Verfügbarkeit der Datenbank und von Zusatzservices. 

Syntax: `show diagnostics`

Nach dem Objekt können die folgenden Optionen angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
show diagnostics
```

#### Befehl `unlock`
{: #the-unlock-command }
Mit dem Befehl `unlock` wird die allgemeine Sperre aufgehoben. Einige zerstörerische Operationen nutzen diese Sperre, um zu verhindern, dass Konfigurationsdaten parallel von verschiedenen Personen geändert wird. Wenn eine solche Operation unterbrochen wird, kann die Sperre bestehen bleiben, sodass weitere zerstörerische Operationen nicht möglich sind. Verwenden Sie in solchen Fällen den Befehl unlock, um die Sperre aufzuheben. 

**Beispiel**

```bash
unlock
```

#### Befehl `list runtimes`
{: #the-list-runtimes-command }
Der Befehl `list runtimes` gibt eine Liste der implementierten Laufzeiten zurück. 

Syntax: `list runtimes [--in-database]`

Der Befehl wird mit folgenden Optionen verwendet:

| Option | Beschreibung |
|--------|-------------|
| --in-database	| Angabe, ob in der Datenbank gesucht werden soll, anstatt MBeans zu verwenden |
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiele**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

Dieser Befehl basiert auf dem REST-Service [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

#### Befehl `show runtime`
{: #the-show-runtime-command }
Der Befehl `show runtime` zeigt Informationen zu einer gegebenen implementierten Laufzeit an. 

Syntax: `show runtime [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `show runtime` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

Dieser Befehl basiert auf dem REST-Service [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

**Beispiel**

```bash
show runtime mfp
```

#### Befehl `delete runtime`
{: #the-delete-runtime-command }
Mit dem Befehl `delete runtime` wird eine Laufzeit, einschließlich der zugehörigen Apps und Adapter, aus der Datenbank gelöscht. Eine Laufzeit kann nur gelöscht werden, wenn die zugehörige Webanwendung gestoppt ist. 

Syntax: `delete runtime [Laufzeitname] Bedingung`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Bedingung | Bedingung für das Löschen (empty oder always). **Achtung:** Die Verwendung der Option always ist gefährlich. |

**Beispiel**

```bash
delete runtime mfp empty
```

Dieser Befehl basiert auf dem REST-Service [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

#### Befehl `list farm-members`
{: #the-list-farm-members-command }
Der Befehl `list farm-members` gibt eine Liste der Farmmemberserver zurück, auf denen eine gegebene Laufzeit implementiert ist. 

Syntax: `list farm-members [Laufzeitname]`

Der Befehl
wird mit folgenden Argumenten verwendet:

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |

Der Befehl `list farm-members` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --xml | Erzeugt anstelle der Tabellenausgabe eine XML-Ausgabe |

**Beispiel**

```bash
list farm-members mfp
```

Dieser Befehl basiert auf dem REST-Service für [Farm Topology Members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-). 

#### Befehl `remove farm-member`
{: #the-remove-farm-member-command }
Der Befehl `remove farm-member` entfernt einen Server aus der Liste der Farmmember, auf denen die gegebene Laufzeit implementiert ist. Verwenden Sie diesen Befehl, wenn der Server nicht mehr verfügbar ist oder die Verbindung zum Server unterbrochen wurde. 

Syntax: `remove farm-member [Laufzeitname] Server-ID`

Der Befehl wird mit folgenden Argumenten verwendet.

| Argument | Beschreibung |
|----------|-------------|
| Laufzeitname | Name der Laufzeit |
| Server-ID | Kennung des Servers |

Der Befehl `remove farm-member` kann mit folgenden Optionen nach dem Objekt angegeben werden.

| Option | Beschreibung |
|--------|-------------|
| --force | Das Farmmember wird auch dann entfernt, wenn es verfügbar und verbunden ist. |

**Beispiel**

```bash
remove farm-member mfp srvlx15
```

Dieser Befehl basiert auf dem REST-Service [Farm Topology Members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc). 
