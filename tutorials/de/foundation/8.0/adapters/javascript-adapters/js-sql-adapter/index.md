---
layout: tutorial
title: JavaScript-SQL-Adapter
breadcrumb_title: SQL Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Ein SQL-Adapter ist für die Kommunikation mit SQL-Datenquellen bestimmt.
Sie können einfache SQL-Abfragen oder gespeicherte Prozeduren verwenden. 

Für das Herstellen einer Verbindung zu einer
Datenbank benötigt der JavaScript-Code einen JDBC-Connector-Treiber für den konkreten Datenbanktyp. Sie müssen den
zum Datenbanktyp passenden JDBC-Connector-Treiber herunterladen und als Abhängigkeit zu Ihrem Projekt hinzufügen. Weitere Informationen zum Hinzufügen einer Abhängigkeit finden Sie im Abschnitt "Abhängigkeiten"
des Lernprogramms [Java- und JavaScript-Adapter erstellen](../../creating-adapters/#dependencies). 

In diesem Lernprogramm mit dem zugehörigen Beispiel erfahren Sie, wie ein Adapter zum Herstellen einer Verbindung zu einer MySQL-Datenbank verwendet wird. 

**Voraussetzung:** Arbeiten Sie zuerst das Lernprogramm [JavaScript-Adapter](../) durch. 

## XML-Datei
{: #the-xml-file }

Die XML-Datei enthält Einstellungen und Metadaten. 

Deklarieren Sie in der Datei **adapter.xml** die folgenden Parameter: 

 * JDBC-Treiberklasse
 * Datenbank-URL
 * Benutzername
 * Kennwort<br/><br/>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptSQL"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:sql="http://www.ibm.com/mfp/integration/sql">

	<displayName>JavaScriptSQL</displayName>
	<description>JavaScriptSQL</description>
	<connectivity>
		<connectionPolicy xsi:type="sql:SQLConnectionPolicy">
			<dataSourceDefinition>
				<driverClass>com.mysql.jdbc.Driver</driverClass>
				<url>jdbc:mysql://localhost:3306/mobilefirst_training</url>
			    <user>mobilefirst</user>
    			<password>mobilefirst</password>
			</dataSourceDefinition>
		</connectionPolicy>
	</connectivity>
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Für Attribute und untergeordnete Elemente in adapter.xml hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: Dieses <i>obligatorische</i> Attribut muss auf den Wert sql:SQLConnectionPolicy gesetzt sein.</li>
                    <li><b>dataSourceDefinition</b>: Enthält die Parameter für die Verbindung zu einer Datenquelle (<i>optional</i>). Der Adapter erstellt für jede Anforderung eine Verbindung. Beispiel:

{% highlight xml %}
<connectionPolicy xsi:type="sql:SQLConnectionPolicy">
    <dataSourceDefinition>
        <driverClass>com.mysql.jdbc.Driver</driverClass>
        <url>jdbc:mysql://localhost:3306/mysqldbname</url>
        <user>user_name</user>
        <password>password</password>
    </dataSourceDefinition>
</connectionPolicy>
{% endhighlight %}</li>

                    <li><b>dataSourceJNDIName</b>: Sie können Sie für die Verbindung zur Datenquelle den JNDI-Namen einer vom Anwendungsserver verwendeten Datenquelle verwenden (<i>optional</i>). Der Adapter entnimmt die Verbindung aus dem Serververbindungspool, der dem JNDI-Namen zugeordnet ist. Anwendungsserver bieten eine Möglichkeit, Datenquellen zu konfigurieren. Weitere Informationen finden Sie unter "{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren". Beispiel:

{% highlight xml %}                        
<connectionPolicy xsi:type="sql:SQLConnectionPolicy">
    <dataSourceJNDIName>my-adapter-ds</dataSourceJNDIName>
</connectionPolicy>
{% endhighlight %}</li>
                </ul>
            </div>
        </div>
    </div>
</div>


Wenn Sie die Verbindungsrichtlinie (`connectionPolicy`) konfiguriert haben, deklarieren Sie in der Adapter-XML-Datei eine Prozedur. 

```js
<procedure name="getAccountTransactions1"/>
```

## JavaScript-Implementierung
{: #javascript-implementation }

Die Adapter-JavaScript-Datei wird für die Implementierung der Prozedurlogik verwendet.   
Es gibt zwei Möglichkeiten, SQL-Anweisungen auszuführen: 

* Abfrage mit SQL-Anweisung
* Gespeicherte SQL-Prozedur

### Abfrage mit SQL-Anweisung
{: #sql-statement-query }

1. Weisen Sie Ihre SQL-Abfrage einer Variablen zu. Diese Zuweisung muss immer außerhalb des Funktionsbereichs erfolgen.
2. Fügen Sie ggf. Parameter hinzu.
3. Verwenden Sie die Methode `MFP.Server.invokeSQLStatement`, um vorbereitete Abfragen aufzurufen.
4. Geben Sie das Ergebnis an die Anwendung oder an eine andere Prozedur zurück.

   ```javascript
   // 1. Weisen Sie Ihre SQL-Abfrage (außerhalb des Funktionsbereichs) einer Variablen zu.
   // 2. Fügen Sie ggf. Parameter hinzu.
   var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
    "FROM accounttransactions " +
    "WHERE accounttransactions.fromAccount = ? OR accounttransactions.toAccount = ? " +
    "ORDER BY transactionDate DESC " +
    "LIMIT 20;";

    // Vorbereitete SQL-Abfrage aufrufen und Aufrufergebnis zurückgeben
   function getAccountTransactions1(accountId){
   // 3. Verwenden Sie die Methode `MFP.Server.invokeSQLStatement`, um vorbereitete Abfragen aufzurufen.
   // 4. Geben Sie das Ergebnis an die Anwendung oder an eine andere Prozedur zurück.
        return MFP.Server.invokeSQLStatement({
	       preparedStatement : getAccountsTransactionsStatement,
	       parameters : [accountId, accountId]
        });
   }
   ```       

### Gespeicherte SQL-Prozedur
{: #sql-stored-procedure }

Führen Sie eine gespeicherte SQL-Prozedur mit der Methode `MFP.Server.invokeSQLStoredProcedure` aus. Geben Sie den Namen einer gespeicherten SQL-Prozedur als Aufrufparameter a. 

```javascript
// Gespeicherte SQL-Prozedur aufrufen und Aufrufergebnis zurückgeben
function getAccountTransactions2(accountId){
  // Gespeicherte SQL-Prozedur mit der Methode MFP.Server.invokeSQLStoredProcedure ausführen
  return MFP.Server.invokeSQLStoredProcedure({
    procedure : "getAccountTransactions",
    parameters : [accountId]
  });
}
```  

### Mehrere Parameter verwenden
{: #using-multiple-parameters }

Wenn Sie in einer SQL-Abfrage einen oder mehrere Parameter verwenden, müssen die Variablen in der Funktion akzeptiert und als **Array**
an den Parameter `invokeSQLStatement` oder `invokeSQLStoredProcedure` übergeben werden. 

```javascript
var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
	"FROM accounttransactions " +
	"WHERE accounttransactions.fromAccount = ? AND accounttransactions.toAccount = ? " +
	"ORDER BY transactionDate DESC " +
	"LIMIT 20;";

// Vorbereitete SQL-Abfrage aufrufen und Aufrufergebnis zurückgeben
function getAccountTransactions1(fromAccount, toAccount){
	return MFP.Server.invokeSQLStatement({
		preparedStatement : getAccountsTransactionsStatement,
		parameters : [fromAccount, toAccount]
	});
}
```

## Aufrufergebnis
{: #invocation-results }

Das Ergebnis wird als JSON-Objekt abgerufen. 

```json
{
  "isSuccessful": true,
  "resultSet": [{
    "fromAccount": "12345",
    "toAccount": "54321",
    "transactionAmount": 180.00,
    "transactionDate": "2009-03-11T11:08:39.000Z",
    "transactionId": "W06091500863",
    "transactionType": "Funds Transfer"
  }, {
    "fromAccount": "12345",
    "toAccount": null,
    "transactionAmount": 130.00,
    "transactionDate": "2009-03-07T11:09:39.000Z",
    "transactionId": "W214122\/5337",
    "transactionType": "ATM Withdrawal"
  }]
}
```
* Die Eigenschaft `isSuccessful` definiert, ob der Aufruf erfolgreich war.
* Das Objekt `resultSet` ist ein Array mit zurückgegebenen Datensätzen.
 * Schreiben Sie Folgendes, um auf der Clientseite auf das `resultSet`-Objekt zuzugreifen: `result.invocationResult.resultSet`.
 * Schreiben Sie Folgendes, um auf der Serverseite auf das `resultSet`-Objekt zuzugreifen: `result.ResultSet`.

## Beispieladapter
{: #sample-adapter }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters), um das Maven-Adapterprojekt herunterzuladen. 

Zum Maven-Adapterprojekt gehört der oben beschriebene **JavaScriptSQL**-Adapter.   
Außerdem ist im Ordner **Utils** des Projekts ein SQL-Script enthalten. 

### Verwendung des Beispiels
{: #sample-usage }

* Führen Sie in Ihrer SQL-Datenbank das SQL-Script aus. 
* Stellen Sie sicher, dass dem Benutzer `mobilefirst@%` alle Zugriffsberechtigungen erteilt wurden. 
* Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
den [JavaScript-SQL-Adapter zu erstellen und zu implementieren](../../creating-adapters/). 
* Informationen zum Testen oder Debuggen eines Adapters enthält das Lernprogramm [Adapter testen und debuggen](../../testing-and-debugging-adapters). 

Für Tests muss der Accountwert als Array (`["12345"]`) übergeben werden.
