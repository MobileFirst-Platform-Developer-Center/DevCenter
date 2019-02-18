---
layout: tutorial
title: Adaptador JavaScript SQL
breadcrumb_title: SQL Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Un adaptador SQL se diseña con el propósito de comunicarse con un origen de datos SQL. Utilice consultas SQL simples o procedimientos almacenados.

Para conectarse a una base de datos, el código JavaScript necesita un controlador de conector JDBC para el tipo de base de datos específico. El controlador del conector JDBC se debe descargar de forma independiente para el tipo de base de datos específico y añadirlo como una dependencia en su proyecto. Para obtener más información sobre cómo añadir una dependencia, consulte la sección de Dependencias en la guía de aprendizaje [Creación de adaptadores Java y JavaScript](../../creating-adapters/#dependencies).

En esta guía de aprendizaje y en el ejemplo que lo acompaña, aprenderá a utilizar un adaptador para conectarse a una base de datos MySQL.

**Requisito previo:** Asegúrese de leer primero la guía de aprendizaje [Adaptadores JavaScript](../).

## El archivo XML
{: #the-xml-file }

El archivo XML contiene los valores y metadatos.

En el archivo **adapter.xml**, declare los siguientes parámetros:

 * Clase de controlador JDBC
 * URL de base de datos
 * Nombre de usuario
 * Contraseña<br/><br/>

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
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Pulse para los subelementos y atributos de adapter.xml</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>Obligatorio</i>. El valor de este atributo debe ser sql:SQLConnectionPolicy.</li>
                    <li><b>dataSourceDefinition</b>: <i>Opcional.</i> Contiene los parámetros necesarios para conectarse a un origen de datos. El adaptador crea una conexión para cada solicitud. Por ejemplo:

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

                    <li><b>dataSourceJNDIName</b>: <i>Opcional.</i> Conecta al origen de datos mediante el nombre JNDI de un origen de datos que el servidor de aplicaciones proporciona. El adaptador toma la conexión de la agrupación de conexiones del servidor que está asociado con el nombre JNDI. Los servidores de aplicaciones proporcionan una forma de configurar orígenes de datos. Para obtener más información, consulte Instalación de {{ site.data.keys.mf_server }} en un servidor de aplicaciones. Por ejemplo:

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


Con `connectionPolicy` configurado, declare un procedimiento en el archivo XML del adaptador.

```js
<procedure name="getAccountTransactions1"/>
```

## Implementación JavaScript
{: #javascript-implementation }

El archivo JavaScript del adaptador se utiliza para implementar la lógica del procedimiento.  
Hay dos formas de ejecutar sentencias SQL:

* Consulta de sentencia SQL
* Procedimiento almacenado SQL

### Consulta de sentencia SQL
{: #sql-statement-query }

1. Asigne su consulta SQL a una variable. Esto se debe realizar siempre fuera del ámbito de la función.
2. Añada parámetros, si es necesario.
3. Utilice el método `MFP.Server.invokeSQLStatement` para llamar a consultas preparadas.
4. Devuelva el resultado a la aplicación o a otro procedimiento.

   ```javascript
   // 1. Assign your SQL query to a variable (outside the function scope)
   // 2. Add parameters, if necessary
   var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
    "FROM accounttransactions " +
    "WHERE accounttransactions.fromAccount = ? OR accounttransactions.toAccount = ? " +
    "ORDER BY transactionDate DESC " +
    "LIMIT 20;";

    // Invoke prepared SQL query and return invocation result
   function getAccountTransactions1(accountId){
   // 3. Use the `MFP.Server.invokeSQLStatement` method to call prepared queries
   // 4. Return the result to the application or to another procedure.
        return MFP.Server.invokeSQLStatement({
	       preparedStatement : getAccountsTransactionsStatement,
	       parameters : [accountId, accountId]
        });
   }
   ```       

### Procedimiento almacenado SQL
{: #sql-stored-procedure }

Para ejecutar un procedimiento almacenado SQL, utilice el método `MFP.Server.invokeSQLStoredProcedure`. Especifique un nombre de procedimiento almacenado SQL como parámetro de invocación.

```javascript
// Invoke stored SQL procedure and return invocation result
function getAccountTransactions2(accountId){
  // To run a SQL stored procedure, use the `MFP.Server.invokeSQLStoredProcedure` method
  return MFP.Server.invokeSQLStoredProcedure({
    procedure : "getAccountTransactions",
    parameters : [accountId]
  });
}
```  

### Utilización de varios parámetros
{: #using-multiple-parameters }

Cuando se utiliza un único parámetro o varios parámetros en una consulta SQL asegúrese de aceptar las variables en la función y pasarlas a los parámetros `invokeSQLStatement` o `invokeSQLStoredProcedure` en una **matriz**.

```javascript
var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
	"FROM accounttransactions " +
	"WHERE accounttransactions.fromAccount = ? AND accounttransactions.toAccount = ? " +
	"ORDER BY transactionDate DESC " +
	"LIMIT 20;";

//Invoke prepared SQL query and return invocation result
function getAccountTransactions1(fromAccount, toAccount){
	return MFP.Server.invokeSQLStatement({
		preparedStatement : getAccountsTransactionsStatement,
		parameters : [fromAccount, toAccount]
	});
}
```

## Resultados de invocación
{: #invocation-results }

El resultado se recupera como un objeto JSON:

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
* La propiedad `isSuccessful` define si la invocación ha sido satisfactoria.
* El objeto `resultSet` es una matriz con los registros devueltos.
 * Para acceder al objeto `resultSet` en el lado del cliente: `result.invocationResult.resultSet`
 * Para acceder al objeto `resultSet` en el lado del servidor: `result.ResultSet`

## Adaptador de ejemplo
{: #sample-adapter }

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters) el proyecto Maven Adapters.

El proyecto Maven Adapters incluye el adaptador **JavaScriptSQL** descrito con anterioridad.  
También se incluye un script SQL en la carpeta **Utils**.

### Uso de ejemplo
{: #sample-usage }

* Ejecute el script .sql script en su base de datos SQL.
* Asegúrese de que el usuario `mobilefirst@%` tiene todos los permisos de acceso asignados.
* Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar el adaptador JavaScriptSQL](../../creating-adapters/).
* Para probar o depurar un adaptador, consulte la guía de aprendizaje [Pruebas y depuración de adaptadores](../../testing-and-debugging-adapters).

Al realizar pruebas, el valor de la cuenta se debería pasar en una matriz: `["12345"]`.
