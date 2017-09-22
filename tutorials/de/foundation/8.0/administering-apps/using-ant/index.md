---
layout: tutorial
title: Anwendungen mit Ant verwalten
breadcrumb_title: Verwaltung mit Ant
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können MobileFirst-Anwendungen mit der Ant-Task **mfpadm** verwalten.

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
* Ant-Task **mfpadm**
* Programm **mfpadm**
* {{ site.data.keys.product_adj }}-REST-Services für Administration

Die Ant-Task **mfpadm**, das Programm **mfpadm** und die REST-Services
sind für eine automatisierte oder unbeaufsichtigte Ausführung von Operationen in folgenden Situationen hilfreich: 

* Vermeidung von Bedienerfehlern bei sich wiederholenden Operationen
* Ausführen von Operationen außerhalb der Regelarbeitszeit des Bedieners
* Konfigurieren eines Produktionsservers mit denselben Einstellungen wie ein Test- oder Vorproduktionsserver 

Die Ant-Task **mfpadm**
und das Programm **mfpadm** sind einfacher zu verwenden und geben bessere Fehlermeldungen als die REST-Services. Die Ant-Task
**mfpadm** hat gegenüber dem Programm mfpadm den Vorteil, dass sie plattformunabhängig und leichter zu integrieren ist, sofern bereits
eine Ant-Einbindung verfügbar ist.

## Voraussetzungen
{: #prerequisites }
Das Tool
**mfpadm** wird mit dem Installationsprogramm für
{{ site.data.keys.mf_server }} installiert. In den folgenden Ausführungen
steht **Produktinstallationsverzeichnis** für das Installationsverzeichnis des Installationsprogramms für {{ site.data.keys.mf_server }}. 

Für die Ausführung der Task
**mfpadm** ist Apache Ant erforderlich. Informationen
zur unterstützten Mindestversion von Ant finden Sie in
den Systemvoraussetzungen.

Für Ihren Komfort ist Apache Ant 1.9.4
im Lieferumfang von {{ site.data.keys.mf_server }} enthalten. Im
Verzeichnis **Produktinstallationsverzeichnis/shortcuts/** stehen die folgenden Scripts
zur Verfügung.

* ant für UNIX/Linux
* ant.bat für Windows

Diese Scripts können sofort ausgeführt werden. Sie erfordern keine bestimmten
Umgebungsvariablen. Wenn die Umgebungsvariable JAVA_HOME gesetzt ist, wird sie von den Scripts akzeptiert.

Sie müssen die
Ant-Task **mfpadm** nicht auf dem Computer verwenden, auf dem Sie
{{ site.data.keys.mf_server }} installiert haben.

* Kopieren Sie die Datei **Produktinstallationsverzeichnis/MobileFirstServer/mfp-ant-deployer.jar** auf den Computer. 
* Sie müssen sicherstellen, dass auf dem Computer eine unterstützte Version von Apache Ant und eine Java Runtime Environment
installiert sind.

Fügen Sie für die Verwendung der Ant-Task **mfpadm** den folgenden
Initialisierungsbefehl zum Ant-Script hinzu:

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="Produktinstallationsverzeichnis/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Andere Initialisierungsbefehle, die sich auf dieselbe Datei
**mfp-ant-deployer.jar** beziehen, sind redundant, denn die von
**defaults.properties** durchgeführte Initialisierung wird implizit auch von antlib.xml durchgeführt. Nachfolgend sehen Sie ein Beispiel für einen redundanten
Initialisierungsbefehl:

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="Produktinstallationsverzeichnis/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Weitere Informationen zum Ausführen des Installationsprogramms für
{{ site.data.keys.mf_server }} finden Sie unter
[IBM Installation Manager ausführen](../../installation-configuration/production/installation-manager/).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-1 }

* [Ant-Task **mfpadm** aufrufen](#calling-the-mfpadm-ant-task)
* [Befehle für allgemeine Konfiguration](#commands-for-general-configuration)
* [Befehle für Adapter](#commands-for-adapters)
* [Befehle für Apps](#commands-for-apps)
* [Befehle für Geräte](#commands-for-devices)
* [Befehle für Fehlersuche](#commands-for-troubleshooting)

### Ant-Task 'mfpadm' aufrufen
{: #calling-the-mfpadm-ant-task }
Mit der Ant-Task **mfpadm** können Sie
MobileFirst-Anwendungen verwalten. Die Ant-Task **mfpadm** wird wie folgt
aufgerufen: 

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    Befehle
</mfpadm>
```

#### Attribute
{: #attributes }
Die Ant-Task **mfpadm** wird mit folgenden Attributen
verwendet: 

| Attribut| Beschreibung | Erforderlich| Standardwert| 
|----------------|-------------|----------|---------|
| url	         | Basis-URL der {{ site.data.keys.product_adj }}-Webanwendung für Verwaltungsservices| Ja | |
| secure	     | Angabe, ob Operationen mit Sicherheitsrisiko vermieden werden sollen| Nein| true|
| user	         | Benutzername für den Zugriff auf die {{ site.data.keys.product_adj }}-Verwaltungsservices| Ja| |
| password	     | Kennwort für den Benutzer | Kennwort oder Datei ist erforderlich. | |
| passwordfile |	Datei, die das Kennwort für den Benutzer enthält | Datei oder Kennwort ist erforderlich. | |	 
| timeout	     | Zeitlimit für den Zugriff auf den gesamten REST-Service in Sekunden | Nein| |
| connectTimeout|	Zeitlimit für das Herstellen einer Netzverbindung in Sekunden| Nein| |	 
| socketTimeout|	Zeitlimit für das Erkennen des Verlusts einer Netzverbindung in Sekunden| Nein| |
| connectionRequestTimeout|	Zeitlimit (in Sekunden) für das Abrufen eines Eintrags aus einem Pool für Verbindungsanforderungen| Nein| |
| lockTimeout|	Zeitlimit für das Anfordern einer Sperre| Nein| |

**url**<br/>
In der Basis-URL wird bevorzugt das Protokoll HTTPS verwendet. Wenn Sie beispielsweise die Standardports und -kontextstammelemente nutzen, verwenden Sie die
folgende URL. 

* WebSphere Application Server: [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* Tomcat: [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
Der Standardwert ist **true**. Die Einstellung **secure="false"** kann folgende Auswirkungen haben: 

* Der Benutzer und das Kennwort könnten auf ungeschütztem Wege, möglicherweise sogar mit unverschlüsseltem HTTP,
übertragen werden. 
* Die SSL-Zertifikate des Servers werden auch dann akzeptiert, wenn es sich um selbst signierte Zertifikate handelt oder um Zertifikate, die für einen anderen als den angegebenen Hostnamen des Servers
erstellt wurden. 

**password**<br/>
Geben Sie das Kennwort im Ant-Script mit der Option
**password** oder in einer gesonderten, mit dem Attribut
**passwordfile** übergebenen Datei an. Ein Kennwort ist eine sensible Information, die geschützt werden muss.
Sie müssen verhindern, dass andere Benutzer desselben Computers dieses Kennwort kennen.
Bevor Sie das Kennwort in einer Datei eingeben, entfernen Sie die Leseberechtigung für die Datei für alle Benutzer bis auf Sie selbst,
um das Kennwort zu schützen. Sie
können beispielsweise einen der folgenden Befehle verwenden:

* UNIX: `chmod 600 adminpassword.txt`
* Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Sie können das Kennwort zusätzlich verschleiern, um es vor zufälliger Einsichtnahme
zu schützen. Verwenden Sie in dem Fall den Befehl **mfpadm**
config password, um das verschleierte Kennwort in einer Konfigurationsdatei zu speichern. Anschließend können Sie das verschleierte
Kennwort kopieren und in das Ant-Script oder in die Kennwortdatei einfügen.


Der Aufruf von **mfpadm** enthält Befehle, die in inneren Elementen
codiert werden. Diese Befehle werden in der Reihenfolge ihrer Auflistung ausgeführt. Wenn die Ausführung eines Befehls fehlschlägt, werden die verbleibenden Befehle nicht ausgeführt, sodass der
Aufruf von **mfpadm** scheitert. 

#### Elemente
{: #elements }
In
Aufrufen von **mfpadm** können Sie die folgenden Elemente verwenden: 

| Element| Beschreibung | Anzahl |
|-------------------------------|-------------|-------|
| show-info	                    | Zeigt Benutzer- und Konfigurationsdaten an| 0..∞| 
| show-global-config	        | Zeigt globale Konfigurationsdaten an | 0..∞| 
| show-diagnostics| Zeigt Diagnoseinformationen an| 0..∞| 
| show-versions	                | Zeigt Versionsinformationen an | 0..∞| 
| unlock	                    | Hebt die allgemeine Sperre auf| 0..∞| 
| list-runtimes	                | Listet die Laufzeiten auf | 0..∞| 
| show-runtime      	        | Zeigt Informationen zu einer Laufzeit an| 0..∞| 
| delete-runtime	            | Löscht eine Laufzeit| 0..∞| 
| show-user-config	            | Zeigt die Benutzerkonfiguration einer Laufzeit an | 0..∞| 
| set-user-config	            | Gibt die Benutzerkonfiguration einer Laufzeit an| 0..∞| 
| show-confidential-clients| Zeigt die Konfiguration geheimer Clients einer Laufzeit an| 0..∞| 
| set-confidential-clients| Gibt die Konfiguration geheimer Clients einer Laufzeit an| 0..∞| 
| set-confidential-clients-rule| Gibt eine Regel für die Konfiguration vertraulicher Clients einer Laufzeit an| 0..∞| 
| list-adapters	                | Listet die Adapter auf | 0..∞| 
| deploy-adapter	            | Implementiert einen Adapter| 0..∞| 
| show-adapter	                | Zeigt Informationen zu einem Adapter an| 0..∞| 
| delete-adapter	            | Löscht einen Adapter| 0..∞| 
| adapter	                    | Weitere Operationen für einen Adapter| 0..∞| 
| list-apps	                    | Listet die Apps auf | 0..∞| 
| deploy-app	                | Implementiert eine App| 0..∞| 
| show-app	                    | Zeigt Informationen zu einer App an| 0..∞| 
| delete-app	                | Löscht eine App| 0..∞| 
| show-app-version| Zeigt Informationen zu einer App-Version an| 0..∞| 
| delete-app-version| Löscht eine App-Version| 0..∞| 
| app	                        | Weitere Operationen für eine App| 0..∞| 
| app-version	                | Weitere Operationen für eine App-Version| 0..∞| 
| list-devices	                | Listet die Geräte auf | 0..∞| 
| remove-device	                | Entfernt ein Gerät| 0..∞| 
| device	                    | Weitere Operationen für ein Gerät| 0..∞| 
| list-farm-members	            | Listet die Member einer Server-Farm auf| 0..∞| 
| remove-farm-member	        | Entfernt ein Member einer Server-Farm| 0..∞| 

#### XML-Format
{: #xml-format }
Die Ausgabe der meisten Befehle ist in XML abgefasst. Die Eingabe für bestimmte Befehle wie `<set-accessrule>` ist ebenfalls in XML abgefasst. Sie finden die XML-Schemata dieser XML-Formate
im Verzeichnis **Produktinstallationsverzeichnis/MobileFirstServer/mfpadm-schemas/**. Bei Befehlen, die vom Server eine XML-Antwort empfangen, wird überprüft, ob diese Antwort
dem konkreten Schema entspricht. Sie können diese Überprüfung durch Angabe des Attributs
**xmlvalidation="none"** inaktivieren. 

#### Ausgabezeichensatz
{: #output-character-set }
Normale Ausgaben der Ant-Task
mfpadm haben das Codierformat der aktuellen Ländereinstellung. Unter Windows wird dieses Codierformat
als "ANSI-Codepage" bezeichnet. Die Codierung hat folgende
Auswirkungen: 

* Nicht zu diesem Zeichensatz gehörende Zeichen werden bei der Ausgabe in Fragezeichen konvertiert. 
* Wenn die Ausgabe an ein Fenster mit Windows-Eingabeaufforderung
(cmd.exe) gesendet wird, werden Nicht-ASCII-Zeichen nicht ordnungsgemäß angezeigt, weil ein solches Fenster davon ausgeht, dass
Zeichen in der so genannten
"OEM-Codepage" codiert sind.

Diese Einschränkung können Sie wie folgt umgehen: 

* Verwenden Sie unter anderen Betriebssystemen als Windows
eine Ländereinstellung mit der Codierung UTF-8. Für
Red Hat Linux und macOS ist dies die Standardländereinstellung. Viele andere Betriebssysteme haben
die Ländereinstellung
en_US.UTF-8.
* Sie können auch das Attribut **output="Dateiname"** verwenden, um die Ausgabe eines
mfpadm-Befehls an eine Datei zu senden. 

### Befehle für allgemeine Konfiguration
{: #commands-for-general-configuration }
Wenn Sie die Ant-Task **mfpadm** aufrufen, können Sie diverse Befehle für den Zugriff auf IBM {{ site.data.keys.mf_server }} oder auf
eine Laufzeit
einbeziehen. 

#### Befehl `show-global-config`
{: #the-show-global-config-command }
Der Befehl `show-global-config` zeigt die globale Konfiguration an. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output	     | Name der Ausgabedatei | |	Nein | Nicht verfügbar|
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar|

**Beispiel**  

```xml
<show-global-config/>
```

Dieser Befehl basiert auf dem REST-Service [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-).

<br/>
#### Befehl `show-user-config`
{: #the-show-user-config-command }
Der Befehl `show-user-config` außerhalb der Elemente `<adapter>` und `<app-version>` zeigt die Benutzerkonfiguration einer Laufzeit an. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime	     | Name der Laufzeit| Ja|	Nicht verfügbar|
| format	     | Gibt das Ausgabeformat an (json oder xml) | Ja| Nicht verfügbar| 
| output	     | Name der Datei, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 
| outputproperty| Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar|

**Beispiel**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

Dieser Befehl basiert
auf dem REST-Service [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-).

<br/>
#### Befehl `set-user-config`
{: #the-set-user-config-command }
Der Befehl `set-user-config` außerhalb der Elemente `<adapter>` und `<app-version>` gibt die Benutzerkonfiguration einer Laufzeit an. Er wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime        | Name der Laufzeit| Ja| Nicht verfügbar| 
| file	         | Name der JSON- oder XML-Datei mit der neuen Konfiguration| Ja| Nicht verfügbar| 

Der Befehl `set-user-config` wird mit folgenden Attributen verwendet, um eine einzelne Eigenschaft in der Konfiguration festzulegen.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime	     | Name der Laufzeit| Ja| Nicht verfügbar| 
| property	     | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. | Ja| Nicht verfügbar| 
| value	         | Wert der Eigenschaft| Ja| Nicht verfügbar|

**Beispiel**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

Dieser Befehl basiert
auf dem REST-Service [Runtime Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-). 

<br/>
#### Befehl `show-confidential-clients`
{: #the-show-confidential-clients-command }
Der Befehl `show-confidential-clients` zeigt die Konfiguration der vertraulichen Clients an, die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). Dieser Befehl wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime        | Name der Laufzeit| Ja| Nicht verfügbar| 
| format| Gibt das Ausgabeformat an (json oder xml) | Ja| Nicht verfügbar| 
| output| Name der Datei, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 
| outputproperty| Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc). 

<br/>
#### Befehl `set-confidential-clients`
{: #the-set-confidential-clients-command }
Der Befehl `set-confidential-clients` gibt die Konfiguration der vertrauliche Clients an,
die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). Dieser Befehl wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime        | Name der Laufzeit| Ja| Nicht verfügbar| 
| file	         | Name der JSON- oder XML-Datei mit der neuen Konfiguration| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-). 

<br/>
#### Befehl `set-confidential-clients-rule`
{: #the-set-confidential-clients-rule-command }
Der Befehl `set-confidential-clients-rule` gibt eine Regel für
die Konfiguration der vertraulichen Clients an, die auf eine Laufzeit zugreifen können. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). Dieser Befehl wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime        | Name der Laufzeit| Ja| Nicht verfügbar| 
| id             | Kennung der Regel| Ja| Nicht verfügbar| 
| displayName    | Anzeigename der Regel| Ja| Nicht verfügbar| 
| secret         | Geheimer Schlüssel der Regel| Ja| Nicht verfügbar| 
| allowedScope   | Liste mit durch Leerzeichen getrennten Token als Bereich für die Regel. | Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

Dieser Befehl basiert
auf dem REST-Service [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-). 

### Befehle für Adapter
{: #commands-for-adapters }
Wenn Sie die Ant-Task **mfpadm** aufrufen, können Sie diverse Befehle für Adapter
einbeziehen. 

#### Befehl `list-adapters`
{: #the-list-adapters-command }
Der Befehl `list-adapters` gibt eine Liste der für eine gegebene
Laufzeit implementierten Adapter zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime        | Name der Laufzeit| 	Ja| Nicht verfügbar| 
| output	     | Name der Ausgabedatei| 	Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<list-adapters runtime="mfp"/>
```

Dieser Befehl basiert
auf dem REST-Service [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-). 

<br/>
#### Befehl `deploy-adapter`
{: #the-deploy-adapter-command }
Mit dem Befehl `deploy-adapter` wird ein Adapter in einer Laufzeit implementiert. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime	     | Name der Laufzeit| Ja| Nicht verfügbar| 
| file           | Binäre Adapterdatei (.adapter) | Ja| Nicht verfügbar|

**Beispiel**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-). 

<br/>
#### Befehl `show-adapter`
{: #the-show-adapter-command }
Der Befehl `show-adapter` zeigt Details zu einem Adapter an. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name eines Adapters| Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Befehl `delete-adapter`
{: #the-delete-adapter-command }
Mit dem Befehl `delete-adapter` wird ein Adapter aus einer Laufzeit entfernt (deimplementiert). Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name    | Name eines Adapters| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Befehlsgruppe `adapter`
{: #the-adapter-command-group }
Die Befehlsgruppe `adapter` wird mit folgenden
Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name eines Adapters| Ja| Nicht verfügbar| 

Der Befehl
`adapter` unterstützt die folgenden Elemente.


| Element| Beschreibung |	Anzahl| 
|------------------|-------------|-------------|
| get-binary	   | Ruft die Binärdaten ab| 0..∞| 
| show-user-config| Zeigt die Benutzerkonfiguration an| 0..∞| 
| set-user-config| Gibt die Benutzerkonfiguration an| 0..∞| 

<br/>
#### Befehl `get-binary`
{: #the-get-binary-command }
Der Befehl `get-binary` innerhalb eines Elements `<adapter>` gibt die binäre Adapterdatei zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut | Beschreibung |	Erforderlich | Standardwert |
|----------------|-------------|-------------|---------|
| tofile | Name der Ausgabedatei | Ja | Nicht verfügbar | 

**Beispiel**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

Dieser Befehl basiert
auf dem REST-Service [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-).

<br/>
#### Befehl `show-user-config`
{: #the-show-user-config-command-1 }
Der Befehl `show-user-config` innerhalb eines `<adapter>`-Elements zeigt die Benutzerkonfiguration des Adapters an. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| format	     | Gibt das Ausgabeformat an (json oder xml) | Ja| Nicht verfügbar| 
| output	     | Name der Datei, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 
| outputproperty| Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar|

**Beispiel**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

Dieser Befehl basiert
auf dem REST-Service [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-). 

<br/>
#### Befehl `set-user-config`
{: #the-set-user-config-command-1 }
Der Befehl `set-user-config` innerhalb eines `<adapter>`-Elements gibt die Benutzerkonfiguration des Adapters an. Er wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| file | Name der JSON- oder XML-Datei mit der neuen Konfiguration | Ja| Nicht verfügbar| 

Der Befehl wird mit folgenden Attributen verwendet, um eine einzelne Eigenschaft in der Konfiguration festzulegen.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| property | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. | Ja| Nicht verfügbar| 
| value | Wert der Eigenschaft| Ja| Nicht verfügbar| 

**Beispiele**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

Dieser Befehl basiert
auf dem REST-Service [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc).

### Befehle für Apps
{: #commands-for-apps }
Wenn Sie die Ant-Task **mfpadm** aufrufen, können Sie diverse Befehle für Apps
einbeziehen. 

#### Befehl `list-apps`
{: #the-list-apps-command }
Der Befehl `list-apps` gibt eine Liste der in einer Laufzeit implementierten Apps zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja | Nicht verfügbar | 
| output| Name der Ausgabedatei | | Nein | Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<list-apps runtime="mfp"/>
```

Dieser Befehl basiert
auf dem REST-Service [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-).

<br/>
#### Befehl `deploy-app`
{: #the-deploy-app-command }
Mit dem Befehl `deploy-app` wird eine App-Version in einer Laufzeit implementiert. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| file | Anwendungsdeskriptor (eine JSON-Datei)| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

Dieser Befehl basiert
auf dem REST-Service [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).

<br/>
#### Befehl `show-app`
{: #the-show-app-command }
Der Befehl `show-app` gibt eine Liste der in einer Laufzeit implementierten App-Versionen zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name einer App| Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

Dieser Befehl basiert
auf dem REST-Service [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-).

<br/>
#### Befehl `delete-app`
{: #the-delete-app-command }
Mit dem Befehl `delete-app` wird eine App mit allen Versionen und für alle Umgebungen, in denen sie implementiert ist,
aus einer Laufzeit entfernt (deimplementiert). Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name einer App| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

Dieser Befehl basiert
auf dem REST-Service [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Befehl `show-app-version`
{: #the-show-app-version-command }
Mit dem Befehl `show-app-version` werden Details zu einer App-Version in einer Laufzeit angezeigt. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name der App| Ja| Nicht verfügbar| 
| environment | Mobile Plattform| Ja| Nicht verfügbar| 
| version | Nummer der App-Version| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Dieser Befehl basiert
auf dem REST-Service [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-).

<br/>
#### Befehl `delete-app-version`
{: #the-delete-app-version-command }
Mit dem Befehl `delete-app-version` wird eine App-Version aus einer Laufzeit entfernt (deimplementiert). Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name der App| Ja| Nicht verfügbar| 
| environment | Mobile Plattform| Ja| Nicht verfügbar| 
| version | Nummer der App-Version| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

Dieser Befehl basiert
auf dem REST-Service [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-).

<br/>
#### Befehlsgruppe `app`
{: #the-app-command-group }
Die Befehlsgruppe `app` wird mit folgenden
Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name der App| Ja| Nicht verfügbar| 

Die Befehlsgruppe
app unterstützt die folgenden Elemente.


| Element| Beschreibung | Anzahl| 
|---------|-------------|-------|
| show-license-config| Zeigt die Tokenlizenzkonfiguration an| 0..| 
| set-license-config| Gibt die Tokenlizenzkonfiguration an| 0..| 
| delete-license-config| Entfernt die Tokenlizenzkonfiguration| 0..| 

<br/>
#### Befehl `show-license-config`
{: #the-show-license-config-command }
Der Befehl `show-license-config` zeigt die Tokenlizenzkonfiguration für eine App an. Er wird mit folgenden Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output|	Name einer Datei, in der die Ausgabe gespeichert werden soll| Ja| Nicht verfügbar|
| outputproperty| 	Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Ja | Nicht verfügbar|

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Application License Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc).

<br/>
#### Befehl `set-license-config`
{: #the-set-license-config-command }
Der Befehl `set-license-config` gibt die Tokenlizenzkonfiguration für eine App an. Er wird mit folgenden Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| appType | Typ einer App (B2C oder B2E)| Ja| Nicht verfügbar| 
| licenseType | Typ für eine Anwendung (APPLICATION, ADDITIONAL_BRAND_DEPLOYMENT oder NON_PRODUCTION) | Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc).

<br/>
#### Befehl `delete-license-config`
{: #the-delete-license-config-command }
Der Befehl `delete-license-config` setzt die Tokenlizenzkonfiguration für eine App zurück (und versetzt sie damit in ihren ursprünglichen Zustand). 

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [License Configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-).

<br/>
#### Befehlsgruppe `app-version`
{: #the-app-version-command-group }
Die Befehlsgruppe `app-version` wird mit folgenden
Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| name | Name einer App| Ja| Nicht verfügbar| 
| environment | Mobile Plattform| Ja| Nicht verfügbar| 
| version | Version der App | Ja| Nicht verfügbar| 

Die Befehlsgruppe `app-version` unterstützt die folgenden
Elemente: 

| Element| Beschreibung | Anzahl| 
|---------|-------------|-------|
| get-descriptor| Ruft den Deskriptor ab| 0..| 
| get-web-resources| Ruft die Webressourcen ab| 0..| 
| set-web-resources| Gibt die Webressourcen an| 0..| 
| get-authenticity-data| Ruft die Authentizitätsdaten ab| 0..| 
| set-authenticity-data| Gibt die Authentizitätsdaten an| 0..| 
| delete-authenticity-data| Löscht die Authentizitätsdaten| 0..| 
| show-user-config| Zeigt die Benutzerkonfiguration an| 0..| 
| set-user-config| Gibt die Benutzerkonfiguration an| 0..| 

<br/>
#### Befehl `get-descriptor`
{: #the-get-descriptor-command }
Der Befehl `get-descriptor` innerhalb eines Elements `<app-version>` gibt den Anwendungsdeskriptor für eine App-Version zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output| Name einer Datei, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 
| outputproperty| Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

Dieser Befehl basiert
auf dem Service [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

<br/>
#### Befehl `get-web-resources`
{: #the-get-web-resources-command }
Der Befehl `get-web-resources` innerhalb eines Elements `<app-version>` gibt die Webressourcen für eine App-Version als .zip-Datei zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut | Beschreibung |	Erforderlich | Standardwert |
|----------------|-------------|-------------|---------|
| tofile | 	Name der Ausgabedatei | Ja |Nicht verfügbar | 

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

Dieser Befehl basiert auf dem REST-Service [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-).

<br/>
#### Befehl `set-web-resources`
{: #the-set-web-resources-command }
Der Befehl `set-web-resources` innerhalb eines Elements `<app-version>` gibt die Webressourcen für eine App-Version an. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| file | Name der Eingabedatei (muss eine .zip-Datei sein) | Ja|Nicht verfügbar|

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Deploy a Web Resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-).

<br/>
#### Befehl `get-authenticity-data`
{: #the-get-authenticity-data-command }
Der Befehl `get-authenticity-data` innerhalb eines Elements `<app-version>` gibt die Authentizitätsdaten für eine App-Version zurück. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output| 	Name einer Datei, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 
| outputproperty| Name einer Ant-Eigenschaft, in der die Ausgabe gespeichert werden soll| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Export Runtime Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc). 

<br/>
#### Befehl `set-authenticity-data`
{: #the-set-authenticity-data-command }
Der Befehl `set-authenticity-data` innerhalb eines Elements `<app-version>` gibt die Authentizitätsdaten für eine App-Version an. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| file | Name der Eingabedatei <ul><li>Datei authenticity_data </li><li>Gerätedatei (.ipa, .apk oder .appx), aus der die Authentizitätsdaten extrahiert werden</li></ul> |  Ja| Nicht verfügbar| 

**Beispiele**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).

<br/>
#### Befehl `delete-authenticity-data`
{: #the-delete-authenticity-data-command }
Der Befehl `delete-authenticity-data` innerhalb eines Elements `<app-version>` löscht die Authentizitätsdaten für eine App-Version. Der Befehl wird ohne Attribute verwendet.

**Beispiel**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc). 

<br/>
#### Befehl `show-user-config`
{: #the-show-user-config-command-2 }
Der Befehl `show-user-config` innerhalb eines Elements `<app-version>` zeigt die Benutzerkonfiguration für eine App-Version an. Der Befehl wird mit folgenden Attributen verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| format| Gibt das Ausgabeformat an (json oder xml) | Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei | Nein | Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiele**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

Dieser Befehl basiert
auf dem REST-Service [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-).

<br/>
#### Befehl `set-user-config`
{: #the-set-user-config-command-2 }
Der Befehl `set-user-config` innerhalb eines Elements `<app-version>` gibt die Benutzerkonfiguration für eine App-Version an. Der Befehl wird mit folgenden Attributen zum Definieren der gesamten Konfiguration verwendet.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| file | Name der JSON- oder XML-Datei mit der neuen Konfiguration| Ja| Nicht verfügbar| 

Der Befehl `set-user-config` wird mit folgenden Attributen verwendet, um eine einzelne Eigenschaft in der Konfiguration festzulegen.

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| property | Name der JSON-Eigenschaft. Verwenden Sie für eine verschachtelte Eigenschaft die Syntax Eigenschaft1.Eigenschaft2.....EigenschaftN. Verwenden Sie für ein JSON-Array-Element den Index anstelle eines Eigenschaftsnamens. | Ja| Nicht verfügbar| 
| value	| Wert der Eigenschaft| Ja| Nicht verfügbar| 

**Beispiele**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### Befehle für Geräte
{: #commands-for-devices }
Wenn Sie die Ant-Task **mfpadm** aufrufen, können Sie diverse Befehle für Geräte
einbeziehen. 

#### Befehl `list-devices`
{: #the-list-devices-command }
Der Befehl `list-devices` gibt
die Liste der Geräte zurück, die Kontakt mit den Apps einer Laufzeit hatten. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| query	 | Ein Anzeigename oder eine Benutzer-ID, nach dem bzw. der gesucht werden soll. Dieser Parameter gibt die zu suchende Zeichenfolge an. Zurückgegeben werden alle Geräte, deren Anzeigename oder Benutzer-ID diese Zeichenfolge enthält (wobei die Groß-/Kleinschreibung nicht unterschieden wird). | Nein | Nicht verfügbar | 
| output| 	Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| 	Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiele**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

Dieser Befehl basiert
auf dem REST-Service [Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-).

<br/>
#### Befehl `remove-device`
{: #the-remove-device-command }
Mit dem Befehl `remove-device` wird
der Datensatz eines Gerätes gelöscht, das Kontakt zu den Apps einer Laufzeit hatte. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| id | Eindeutige Gerätekennung| Ja| Nicht verfügbar| 

**Beispiel**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

Dieser Befehl basiert
auf dem REST-Service [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-).

<br/>
#### Befehlsgruppe `device`
{: #the-device-command-group }
Die Befehlsgruppe `device` wird mit folgenden
Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| id | Eindeutige Gerätekennung| Ja| Nicht verfügbar| 

Der Befehl
`device` unterstützt die folgenden Elemente.


| Element| Beschreibung |       Anzahl|
|----------------|-------------|-------------|
| set-status| Ändert den Status| 0..∞| 
| set-appstatus| Ändert den Status einer App| 0..∞| 

<br/>
#### Befehl `set-status`
{: #the-set-status-command }
Mit dem Befehl `set-status` wird
der Status eines Geräts im Geltungsbereich einer Laufzeit geändert. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| status| Neuer Status| Ja| Nicht verfügbar| 

Folgende Statuswerte sind möglich:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Beispiel**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

Dieser Befehl basiert
auf dem REST-Service [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-).

<br/>
#### Befehl `set-appstatus`
{: #the-set-appstatus-command }
Mit dem Befehl `set-appstatus` wird der Status eines Geräts hinsichtlich einer App in einer Laufzeit geändert. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| app	| Name einer App| Ja| Nicht verfügbar| 
| status| 	Neuer Status| Ja| Nicht verfügbar| 

Folgende Statuswerte sind möglich:

* ENABLED
* DISABLED

**Beispiel**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

Dieser Befehl basiert
auf dem REST-Service [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-).

### Befehle für Fehlersuche
{: #commands-for-troubleshooting }
Mithilfe von Ant-Task-Befehlen können Sie
Probleme
mit MobileFirst-Server-Webanwendungen untersuchen. 

#### Befehl `show-info`
{: #the-show-info-command }
Der Befehl `show-info` zeigt Basisinformationen
zu den MobileFirst-Verwaltungsservices an, die ohne Zugriff auf eine Laufzeit oder Datenbank zurückgegeben werden können.
Mit diesem Befehl
können Sie testen, ob die MobileFirst-Verwaltungsservices überhaupt ausgeführt werden. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output| 	Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| 	Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-info/>
```

<br/>
#### Befehl `show-versions`
{: #the-show-versions-command }
Der Befehl `show-versions` zeigt die MobileFirst-Versionen verschiedener Komponenten an. 

* **mfpadmVersion**: Die genaue Nummer der MobileFirst-Server-Version, deren Datei **mfp-ant-deployer.jar** verwendet wird.
* **productVersion**: Die genaue Nummer der MobileFirst-Server-Version, deren Datei **mfp-admin-service.war** verwendet wird.
* **mfpAdminVersion**: Die genaue Nummer der Buildversion der Datei **mfp-admin-service.war**.

Der Befehl wird mit folgenden Attributen verwendet: 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output| 	Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| 	Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-versions/>
```

<br/>
#### Befehl `show-diagnostics`
{: #the-show-diagnostics-command }
Der Befehl `show-diagnostics` zeigt den Status diverser Komponenten an, die für einen ordnungsgemäßen Betrieb des
{{ site.data.keys.product_adj }}-Verwaltungsservice erforderlich sind, z. B.
die Verfügbarkeit der Datenbank und von Zusatzservices. Er wird mit folgenden Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| output| 	Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| 	Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**  

```xml
<show-diagnostics/>
```

<br/>
#### Befehl `unlock`
{: #the-unlock-command }
Mit dem Befehl `unlock` wird die allgemeine Sperre aufgehoben. Einige zerstörerische Operationen nutzen diese Sperre, um zu verhindern, dass Konfigurationsdaten parallel
von verschiedenen Personen geändert wird. Wenn eine solche Operation unterbrochen wird, kann die Sperre bestehen bleiben, sodass weitere zerstörerische Operationen
nicht möglich sind. Verwenden Sie in solchen Fällen den Befehl unlock, um die Sperre aufzuheben. Der Befehl wird ohne Attribute verwendet. 

**Beispiel**  

```xml
<unlock/>
```

<br/>
#### Befehl `list-runtimes`
{: #the-list-runtimes-command }
Der Befehl `list-runtimes` gibt eine
Liste der implementierten Laufzeiten zurück. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiele**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

Dieser Befehl basiert
auf dem REST-Service [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-).

<br/>
#### Befehl `show-runtime`
{: #the-show-runtime-command }
Der Befehl `show-runtime`
zeigt Informationen zu einer gegebenen implementierten Laufzeit an. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**

```xml
<show-runtime runtime="mfp"/>
```

Dieser Befehl basiert
auf dem REST-Service [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-).

<br/>
#### Befehl `delete-runtime`
{: #the-delete-runtime-command }
Mit dem Befehl `delete-runtime` wird die
Laufzeit, einschließlich der zugehörigen Apps und Adapter, aus der Datenbank gelöscht.
Eine Laufzeit kann nur gelöscht werden, wenn
die zugehörige Webanwendung gestoppt ist. Der Befehl wird mit folgenden Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime |  Name der Laufzeit| Ja| Nicht verfügbar|
| condition | Bedingung für das Löschen (empty oder always). **Achtung:** Die Verwendung der Option always ist gefährlich. | Nein| Nicht verfügbar|

**Beispiel**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

Dieser Befehl basiert
auf dem REST-Service [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-).

<br/>
#### Befehl `list-farm-members`
{: #the-list-farm-members-command }
Der Befehl `list-farm-members` gibt eine Liste der Farmmemberserver
zurück, auf denen eine gegebene Laufzeit implementiert ist. Er wird mit folgenden Attributen verwendet:

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| output| Name der Ausgabedatei| Nein| Nicht verfügbar| 
| outputproperty| Name der Ant-Eigenschaft für die Ausgabe| Nein| Nicht verfügbar| 

**Beispiel**

```xml
<list-farm-members runtime="mfp"/>
```

Dieser Befehl basiert
auf dem REST-Service für [Farm Topology Members
(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-). 

<br/>
#### Befehl `remove-farm-member`
{: #the-remove-farm-member-command }
Der Befehl `remove-farm-member` entfernt einen Server aus der Liste der Farmmember, auf denen eine
gegebene Laufzeit implementiert ist. Verwenden Sie diesen Befehl, wenn der Server nicht mehr verfügbar ist oder die Verbindung zum Server
unterbrochen wurde. Der Befehl wird mit folgenden Attributen verwendet. 

| Attribut| Beschreibung |	Erforderlich| Standardwert|
|----------------|-------------|-------------|---------|
| runtime | Name der Laufzeit| Ja| Nicht verfügbar| 
| serverId| Kennung des Servers| Ja| Nicht verfügbar| 
| force| Das Farmmember wird auch dann entfernt, wenn es verfügbar und verbunden ist. | Nein| false| 

**Beispiel**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

Dieser Befehl basiert
auf dem REST-Service [Farm Topology Members
(DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc). 
