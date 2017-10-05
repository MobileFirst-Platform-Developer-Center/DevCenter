---
layout: tutorial
title: JavaScript-Adapter
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

JavaScript-Adapter sind Schablonen für die Verbindung zu HTTP- und SQL-Back-Ends, die eine Reihe von Services bereitstellen, die als Prozeduren bezeichnet werden,
sowie mobile Apps, die diese Prozeduren durch das Absetzen von Ajax-Anforderungen aufrufen können. 

**Voraussetzung:** Arbeiten Sie zuerst das Lernprogramm [Java- und JavaScript-Adapter erstellen](../creating-adapters) durch. 

## Dateistruktur
{: #file-structure }

![mvn-adapter](js-adapter-fs.png)

### Ordner 'adapter-resources'
{: #the-adapter-resources-folder }

Der Ordner **adapter-resources** enthält eine XML-Konfigurationsdatei. Diese Konfigurationsdatei beschreibt die Konnektivitätsoptionen und listet die Prozeduren auf, die für die Anwendung oder andere Adapter zugänglich gemacht werden. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">
    <displayName>JavaScriptAdapter</displayName>
    <description>JavaScriptAdapter</description>
    
    <connectivity>
        <connectionPolicy>
        ...
        </connectionPolicy>
    </connectivity>

    <procedure name="procedure1"></procedure>
    <procedure name="procedure2"></procedure>

    <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a name="click-for-adapter-xml-attributes-and-subelements" class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Für Attribute und untergeordnete Elemente in adapter.xml hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><code>name</code>: Dieses <i>obligatorische</i> Attribut gibt den Namen des Adapters an. Dieser Name muss innerhalb von {{ site.data.keys.mf_server }} eindeutig sein. Er kann aus alphanumerischen Zeichen und Unterstreichungszeichen bestehen und muss mit einem Buchstaben beginnen. Den Namen eines definierten und implementierten Adapters können Sie nicht mehr ändern.</li>
					<li><b>&lt;displayName&gt;</b>: Dieses <i>optionale</i> Attribut gibt den Namen des Adapters an, der in der {{ site.data.keys.mf_console }} angezeigt wird. Wenn dieses Element nicht angegeben ist, wird stattdessen der Wert des Attributs name verwendet.</li>
					<li><b>&lt;description&gt;</b>: Dieses <i>optionale</i> Attribut gibt zusätzliche Informationen zum Adapter an. Die Informationen werden in der {{ site.data.keys.mf_console }} angezeigt.</li>
					<li><b>&lt;connectivity&gt;</b>: Dieses <i>obligatorische</i> Attribut definiert den Mechanismus, über den der Adapter eine Verbindung zur Back-End-Anwendung herstellt. Es enthält das Unterelement &lt;connectionPolicy&gt;.
                        <ul>
                            <li><b>&lt;connectionPolicy&gt;</b>: Dieses <i>obligatorische</i> Element definiert Verbindungseigenschaften. Die Struktur dieses Unterelements hängt von der Integrationstechnologie der Back-End-Anwendung ab. Weitere Informationen zu &lt;connectionPolicy&gt; finden Sie in der Beschreibung zum <a href="js-http-adapter">Element &lt;connectionPolicy&gt; für HTTP-Adapter</a> und zum <a href="js-sql-adapter">Element &lt;connectionPolicy&gt; für SQL-Adapter</a>.</li>
                        </ul>
                    </li>
                    <li><b>&lt;procedure&gt;</b>: Dieses <i>obligatorische</i> Attribut definiert einen Prozess für den Zugriff auf einen Service, der über eine Back-End-Anwendung zugänglich gemacht wird.
                        <ul>
                            <li><code>name</code>: Dieses <i>obligatorische</i> Element gibt den Namen der Prozedur an. Dieser Name muss innerhalb des Adapters eindeutig sein. Er kann aus alphanumerischen Zeichen und Unterstreichungszeichen bestehen und muss mit einem Buchstaben beginnen.</li>
                            <li><code>audit</code>: Dieses <i>optionale</i> Element definiert, ob Aufrufe der Prozedur im Prüfprotokoll erfasst werden. Folgende Werte sind gültig:
                                <ul>
                                    <li><code>true</code>: Aufrufe der Prozedur werden im Prüfprotokoll erfasst.</li>
                                    <li><code>false</code>: Standardwert. Aufrufe der Prozedur werden nicht im Prüfprotokoll erfasst.</li>
                                </ul>
                            </li>
                            <li><code>scope</code>: Dieses <i>optionale</i> Element gibt den Sicherheitsbereich, der die Adapterressourcenprozedur schützt, an. Der Bereich kann eine Zeichenfolge mit null oder mehr Bereichselementen ("scope") sein, die jeweils durch ein Leerzeichen getrennt sind, oder auf null gesetzt werden, damit der Standardbereich angewendet wird. Ein Bereichselement kann ein Schlüsselwort sein, das einer Sicherheitsüberprüfung zugeordnet ist, oder der Name einer Sicherheitsüberprüfung. Der Standardbereich ist <code>RegisteredClient</code>, wobei es sich um ein reserviertes {{ site.data.keys.product_adj }}-Schlüsselwort handelt. Nach Standardschutz ist ein Zugriffstoken für den Zugriff auf die Ressource erforderlich. <br/>
								Weitere Informationen zum {{ site.data.keys.product_adj }}-OAuth-Ressourcenschutz und zum Konfigurieren des Ressourcenschutzes für JavaScript-Adapterressourcen finden Sie unter <a href="../../authentication-and-security/#protecting-adapter-resources">Adapterressourcen schützen</a>.<br/>
								Wenn das Attribut <code>secured</code> den Wert <code>false</code> hat, wird das Attribut <code>scope</code> ignoriert. </li>
                            <li><code>secured</code>: Dieses <i>optionale</i> Element definiert, ob die Adapterprozedur vom Sicherheitsframework der {{ site.data.keys.product_adj }} geschützt wird. Folgende Werte sind gültig:
                                <ul>
                                    <li><code>true</code>: Standardwert. Die Prozedur wird geschützt. Zum Aufrufen der Prozedur ist ein gültiges Zugriffstoken erforderlich.</li>
                                    <li><code>false</code>: Die Prozedur wird nicht geschützt. Zum Aufrufen der Prozedur ist kein Zugriffstoken erforderlich (siehe <a href="../../authentication-and-security/#unprotected-resources">Ungeschützte Ressourcen</a>). Wenn dieser Wert festgelegt ist, wird das Attribut <code>scope</code> ignoriert. </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><b>&lt;securityCheckDefinition&gt;</b>: Dieses <i>optionale</i> Attribut definiert ein Sicherheitsüberprüfungsobjekt. Weitere Informationen zu Sicherheitsüberprüfungen enthält das Lernprogramm <a href="../../authentication-and-security/creating-a-security-check">Sicherheitsüberprüfungen erstellen</a>.</li>
        			<li><code>property</code>: Dieses <i>optionale</i> Attribut deklariert eine benutzerdefinierte Eigenschaft. Weiteres erfahren Sie im Abschnitt <a href="#custom-properties">Angepasste Eigenschaften</a> dieses Lernprogramms. </li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

#### Angepasste Eigenschaften
{: #custom-properties }

Die Datei **adapter.xml** kann auch benutzerdefinierte Eigenschaften enthalten. Die Werte, die Entwickler diesen Eigenschaften während der Adaptererstellung zuweisen, können in der {{ site.data.keys.mf_console }}
auf der Registerkarte **Konfigurationen** für Ihren Adapter überschrieben werden, ohne dass der Adapter neu implementiert werden muss. Benutzredefinierte Eigenschaften können mit
der API [getPropertyValue](#getpropertyvalue) gelesen
und später zur Laufzeit weiter angepasst werden. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Hinweis:** Die Elemente für die Konfigurationseigenschaften müssen
sich immer *unterhalb* der &lt;procedure&gt;-Elemente befinden. Im obigen Beispiel wurde eine Eigenschaft &lt;displayName&gt; mit einem Standardwert definiert, sodass sie später verwendet werden kann.

Das Element &lt;property&gt; wird mit folgenden Attributen verwendet:


- `name`: Name der Eigenschaft, wie er in der Konfigurationsklasse definiert ist
- `defaultValue`: Setzt den in der Konfigurationsklasse definierten Wert außer Kraft
- `displayName`: Anzeigename, der in der Konsole erscheint (*optional*) 
- `description`: Beschreibung, die in der Konsole angezeigt wird (*optional*)
- `type`: Stellt sicher, dass die Eigenschaft einen bestimmten Typ hat, z. B. `integer`, `string` oder `boolean` bzw. eine Liste mit gültigen Werten wie `type="['1','2','3']"` (*optional*) 

![Eigenschaften in der Konsole](console-properties.png)

#### Pull- und Push-Konfiguration
{: #pull-and-push-configurations }

Angepasste Adaptereigenschaften können über die auf der Registerkarte
**Konfigurationsdateien** angezeigte Adapterkonfiguraionsdatei gemeinsam genutzt werden.
  
Verwenden Sie dazu die nachfolgend beschriebenen Befehle `pull` und `push` in Maven
oder in der {{ site.data.keys.mf_cli }}. Damit die Eigenschaften gemeinsam genutzt werden können, müssen Sie die *Standardwerte der Eigenschaften ändern*.

Führen Sie die Befehle im Stammordner des Maven-Adapterprojekts aus. 

**Maven**  

* Konfigurationsdatei mit **pull** übertragen  
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```

* Konfigurationsdatei mit **push** übertragen
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* Konfigurationsdatei mit **pull** übertragen
  ```bash
  mfpdev adapter pull
  ```

* Konfigurationsdatei mit **push** übertragen
  ```bash
  mfpdev adapter push
  ```

#### Konfigurationen per Push-Operation auf mehrere Server übertragen
{: #pushing-configurations-to-multiple-servers }

Die Befehle **pull** und **push** können helfen, diverse DevOps-Abläufe zu erstellen,
die je nach Umgebung (DEV, QA, UAT, PRODUCTION) unterschiedliche Werte für Adapter erfordern.

**Maven**  
Oben ist beschrieben, wie standardmäßig eine Datei **config.json** angegeben wird. Erstellen Sie Dateien mit unterschiedlichen Namen für verschiedene Ziele. 

**{{ site.data.keys.mf_cli }}**  
Verwenden Sie die Option **--configFile** oder **-c**, um eine von der Standarddatei abweichende Konfigurationsdatei anzugeben. 

```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> Weitere Informationen erhalten Sie, wenn Sie `mfpdev help adapter pull/push` eingeben.

### Ordner 'js'
{: #the-js-folder }

Dieser Ordner enthält die JavaScript-Implementierungsdatei für alle Prozeduren, die in der Datei **adapter.xml** deklariert sind. Außerdem kann der Ordner XSL-Dateien mit einem Umwandlungsschema für abgerufene XML-Rohdaten enthalten. Von einem Adapter abgerufene Daten können als Rohdaten oder als vom Adapter vorverarbeitete Daten zurückgegeben werden. In beiden Fällen werden die Daten der Anwendung als **JSON-Objekt** präsentiert.

## Prozeduren von JavaScript-Adaptern
{: #javascript-adapter-procedures }

Prozeduren werden in XML deklariert und mit serverseitigem JavaScript für folgende Zwecke implementiert: 

* Bereitstellung von Adapterfunktionen für die Anwendung
* Aufruf von Back-End-Services zum Abrufen von Daten oder Ausführen von Aktionen

Für jede in der Datei **adapter.xml** deklarierte Prozedur muss es eine entsprechende Funktion in der JavaScript-Datei geben. 

Durch serverseitiges JavaScript kann eine Prozedur die Daten vor oder nach dem Aufrufen des Service verarbeiten. Sie können auf abgerufene Daten mit einfachem XSLT-Code weitere Filter anwenden.   
Prozeduren von JavaScript-Adaptern werden in JavaScript implementiert. Da ein Adapter jedoch eine serverseitige Entität ist,
besteht die Möglichkeit, [Java im Adaptercode](../javascript-adapters/using-java-in-javascript-adapters) zu verwenden. 

### Globale Variablen verwenden
{: #using-global-variables }

{{ site.data.keys.mf_server }} ist
nicht auf HTTP-Sitzungen angewiesen, und jede Anforderung kann von einem anderen Knoten empfangen werden. Sie sollten nicht darauf setzen, dass Daten von einer Anforderung zur nächsten durch
globale Variablen erhalten bleiben können. 

### Schwellenwert für Adapterantwort
{: #adapter-response-threshold }

Adapteraufrufe sind nicht dafür gedacht, riesige Datenblöcke zurückzugeben, weil die Adapterantwort
als Zeichenfolge im MobileFirst-Server-Speicher gespeichert wird. Wenn die Datenmenge daher nicht in den verfügbaren Speicher
passt, kann der Adapteraufruf fehlschlagen.
Konfigurieren Sie vorbeugend einen Schwellenwert, ab dem
{{ site.data.keys.mf_server }} mit gzip komprimierte HTTP-Antworten
zurückgibt. Das HTTP-Protokoll hat Standardheader zur Unterstützung der gzip-Komprimierung. Die Clientanwendung muss auch in der Lage sein, gzip-Inhalte in
HTTP zu unterstützen. 

#### Serverseite
{: #server-side }

Legen Sie in der {{ site.data.keys.mf_console }} unter
**Laufzeiten > Einstellungen > GZIP-Komprimierungsschwellenwert
für Adapterantworten** den gewünschten Schwellenwert fest. Der Standardwert
ist 20 KB.   
**Hinweis:** Wenn Sie die Änderung in der {{ site.data.keys.mf_console }} speichern, tritt sie sofort in der Laufzeit in Kraft. 

#### Clientseite
{: #client-side }

Sie müssen den Client so konfigurieren, dass er eine gzip-Antwort analysieren kann.
Setzen Sie dazu in jeder Clientanforderung den Wert des Headers `Accept-Encoding` auf `gzip`. Verwenden Sie die Methode
`addHeader` mit Ihrer Anforderungsvariablen, z. B. `request.addHeader("Accept-Encoding","gzip");`. 

## Serverseitige APIs
{: #server-side-apis }

JavaScript-Adapter können serverseitige APIs verwenden, um Operationen im Zusammenhang mit {{ site.data.keys.mf_server }} auszuführen:
Aufrufen anderer JavaScript-Adapter, Anmeldung beim Serverprotokoll, Abrufen der Werte von Konfigurationseigenschaften, Melden von Aktivitäten an Analytics, Abrufen der Identität des Anforderungsausstellers.   

### getPropertyValue
{: #getpropertyvalue }

Verwenden Sie die API `MFP.Server.getPropertyValue(propertyName)`, um
in der Datei **adapter.xml** oder in der {{ site.data.keys.mf_console }} definierte Eigenschaften abzurufen:

```js
MFP.Server.getPropertyValue("name");
```

### getTokenIntrospectionData
{: #gettokenintrospectiondata }

Verwenden Sie die API `MFP.Server.getTokenIntrospectionData()`, um die aktuell verwendete
Benutzer-ID abzurufen: 

```js
function getAuthUserId(){
   var securityContext = MFP.Server.getTokenIntrospectionData();
   var user = securityContext.getAuthenticatedUser();

   return "User ID: " + user.getId;
}
```

### getAdapterName
{: #getadaptername }

Verwenden Sie die API `getAdapterName()`, um den Adapternamen abzurufen. 

### invokeHttp
{: #invokehttp }

Verwenden Sie die API `MFP.Server.invokeHttp(options)` in HTTP-Adaptern.   
Verwendungsbeispiele enthält das Lernprogramm [JavaScript-HTTP-Adapter](js-http-adapter). 

### invokeSQL
{: #invokesql }

Verwenden Sie die APIs `MFP.Server.invokeSQLStatement(options)` und `MFP.Server.invokeSQLStoredProcedure(options)` in SQL-Adaptern.   
Verwendungsbeispiele enthält das Lernprogramm [JavaScript-SQL-Adapter](js-sql-adapter). 

### addResponseHeader
{: #addresponseheader }

Verwenden Sie die API `MFP.Server.addResponseHeader(name,value)`, um neue Header zur Antwort hinzuzufügen: 

```js
MFP.Server.addResponseHeader("Expires","Sun, 5 October 2014 18:00:00 GMT");
```
### getClientRequest
{: #getclientrequest }

Verwenden Sie die API `MFP.Server.getClientRequest()`, um einen Verweis auf das
Java-Objekt HttpServletRequest zu erhalten, mit dem eine Adapterprozedur aufgerufen wurde: 

```js
var request = MFP.Server.getClientRequest();
var userAgent = request.getHeader("User-Agent");
```

### invokeProcedure
{: #invokeprocedure }

Verwenden Sie `MFP.Server.invokeProcedure(invocationData)`, um andere JavaScript-Adapter aufzurufen.   
Verwendungsbeispiele enthält das Lernprogramm [Erweiterte Nutzung von Adaptern und Adapterkombinationen](../advanced-adapter-usage-mashup). 

### Protokollierung
{: #logging }

Die JavaScript-API stellt über die Klasse MFP.Logger Protokollierungsfunktionen bereit. Es gibt vier Funktionen, die vier Standardprotokollierungsstufen entsprechen.   
Weitere Informationen enthält das Lernprogramm [Serverseitige Protokollerfassung](../server-side-log-collection). 

## Beispiele für JavaScript-Adapter
{:# javascript-adapter-examples }
