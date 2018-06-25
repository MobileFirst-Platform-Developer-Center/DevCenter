---
layout: tutorial
title: Java-SQL-Adapter
breadcrumb_title: SQL-Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight:
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit Java-Adaptern haben Entwickler die Kontrolle über die Möglichkeiten von Verbindungen zu einem Back-End-System. Der Entwickler ist daher dafür verantwortlich, bewährte Verfahren hinsichtlich der Leistung und anderer Implementierungsdetails anzuwenden. In diesem Lernprogramm gibt es ein Beispiel für einen Java-Adapter, der eine Verbindung
zu einem MySQL-Back-End herstellt, um mit REST-Konzepten CRUD-Operationen (Create, Read, Update, Delete) für eine Tabelle `users` auszuführen. 

**Voraussetzungen: **

* Arbeiten Sie zuerst das Lernprogramm [Java-Adapter](../) durch. 
* In diesem Lernprogramm werden SQL-Kenntnisse vorausgesetzt. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Datenquelle einrichten](#setting-up-the-data-source)
* [SQL in der Adapterressourcenklasse implementieren](#implementing-sql-in-the-adapter-resource-class)
* [Beispieladapter](#sample-adapter)

## Datenquelle einrichten
{: #setting-up-the-data-source }

Für eine Konfiguration, die es {{ site.data.keys.mf_server }} ermöglicht, eine Verbindung zum MySQL-Server herzustellen,
müssen **Konfigurationseigenschaften** in der Adapter-XML-Datei definiert werden. Diese Eigenschaften können später in der {{ site.data.keys.mf_console }} bearbeitet werden.

Bearbeiten Sie die Datei adater.xml und fügen Sie die folgenden Eigenschaften hinzu: 

```xml
<mfp:adapter name="JavaSQL"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaSQL</displayName>
	<description>JavaSQL</description>

	<JAXRSApplicationClass>com.sample.JavaSQLApplication</JAXRSApplicationClass>

	<property name="DB_url" displayName="Database URL" defaultValue="jdbc:mysql://127.0.0.1:3306/mobilefirst_training"  />
	<property name="DB_username" displayName="Database username" defaultValue="mobilefirst"  />
	<property name="DB_password" displayName="Database password" defaultValue="mobilefirst"  />
</mfp:adapter>
```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Hinweis:** Die Elemente für die Konfigurationseigenschaften müssen
sich immer *unter* dem Element `JAXRSApplicationClass` befinden.   
Mit diesen Eigenschaften werden die Verbindungseinstellungen definiert und ihre Standardwerte festgelegt, die dann später in der Klasse AdapterApplication verwendet werden können.

## SQL in der Adapterressourcenklasse implementieren
{: #implementing-sql-in-the-adapter-resource-class }

Die Adapterressourcenklasse behandelt Anforderungen an den Server. 

Im bereitgestellten Beispieladapter hat die Klasse den Namen `JavaSQLResource`.

```java
@Path("/")
public class JavaSQLResource {
}
```

`@Path("/")` bedeutet, dass die Ressourcen unter der URL `http(s)://host:port/ProjectName/adapters/AdapterName/` verfügbar sind.

### Datenquelle verwenden
{: #using-datasource }

Wenn der Adapter implementiert wird oder die Konfiguration in der {{ site.data.keys.mf_console }} geändert wird,
wird die Methode `init` der Adapterklasse `MFPJAXRSApplication` aufgerufen. Dies ist eine geeignete Stelle für
das [Laden der Verbindungseigenschaften](../#configuration-api) und das Erstellen einer Datenquelle (`DataSource`).

```java
public class JavaSQLApplication extends MFPJAXRSApplication{

	public BasicDataSource dataSource = null;

	@Context
	ConfigurationAPI configurationAPI;

	@Override
	protected void init() throws Exception {		
		dataSource= new BasicDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl(configurationAPI.getPropertyValue("DB_url"));
		dataSource.setUsername(configurationAPI.getPropertyValue("DB_username"));
		dataSource.setPassword(configurationAPI.getPropertyValue("DB_password"));
	}
}
```

Erstellen Sie in der Ressourcenklasse eine Helper-Methode, um eine SQL-Verbindung zu erhalten.
Rufen Sie mit `AdaptersAPI` die aktuelle `MFPJAXRSApplication`-Instanz ab: 

```java
@Context
AdaptersAPI adaptersAPI;

public Connection getSQLConnection() throws SQLException{
  // Verbindungsobjekt für die Datenbankverbindung erstellen
  JavaSQLApplication app = adaptersAPI.getJaxRsApplication(JavaSQLApplication.class);
  return app.dataSource.getConnection();
}
```


### Benutzer erstellen
{: #create-user }

Der Benutzer wird für die Erstellung eines neuen Benutzerdatensatzes in der Datenbank benötigt. 

```java
@POST
public Response createUser(@FormParam("userId") String userId,
                            @FormParam("firstName") String firstName,
                            @FormParam("lastName") String lastName,
                            @FormParam("password") String password)
                                    throws SQLException{

    Connection con = getSQLConnection();
    PreparedStatement insertUser = con.prepareStatement("INSERT INTO users (userId, firstName, lastName, password) VALUES (?,?,?,?)");

    try{
        insertUser.setString(1, userId);
        insertUser.setString(2, firstName);
        insertUser.setString(3, lastName);
        insertUser.setString(4, password);
        insertUser.executeUpdate();
        // Meldung "200 OK" zurückgeben
        return Response.ok().build();
    }
    catch (SQLIntegrityConstraintViolationException violation) {
        // Versuch, einen bereits vorhandenen Benutzer zu erstellen
        return Response.status(Status.CONFLICT).entity(violation.getMessage()).build();
    }
    finally{
        // Ressourcen in allen Klassen schließen
        insertUser.close();
        con.close();
    }
}
```

Da diese Methode keinen `@Path` hat, ist sie als Stamm-URL der Ressource zugänglich. Die Methode verwendet `@POST` und ist daher nur über `HTTP POST` zugänglich.   
Die Methode hat eine Reihe von `@FormParam`-Argumenten, die im HTTP-Hauptteil als `x-www-form-urlencoded`-Parameter gesendet werden können. 

Es ist auch möglich, die Parameter im HTTP-Hauptteil unter Verwendung von
`@Consumes(MediaType.APPLICATION_JSON)` als JSON-Objekte zu übergeben.
In dem Fall benötigt die Methode ein Argument `JSONObject` oder ein einfaches Java-Objekt mit
Eigenschafften, die den JSON-Eigenschaftsnamen entsprechen. 

Die Methode `Connection con = getSQLConnection();` ruft die Verbindung von der zuvor definierten Datenquelle ab. 

Die SQL-Abfragen werden von der Methode `PreparedStatement` erstellt. 

Wenn die Einfügung erfolgreich verlaufen ist, wird die Methode `return Response.ok().build()` verwendet,
um an den Client `200 OK` zurückzusenden. Sollte ein Fehler aufgetreten sein,
kann ein anderes `Response`-Objekt mit einem bestimmten HTTP-Statuscode erstellt werden. In diesem Beispiel wird er Fehlercode `409 Conflict` gesendet. Sie sollten zudem überprüfen, ob alle Parameter gesendet wurden (was hier nicht demonstriert wird) oder ob eine andere Form der Datenvalidierung durchgeführt wurde. 

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:** Stellen Sie sicher, dass Ressourcen
wie vorbereitete Anweisungen und Verbindungen geschlossen werden.



### Benutzer abrufen
{: #get-user }

Rufen Sie einen Benutzer aus der Datenbank ab. 

```java
@GET
@Produces("application/json")
@Path("/{userId}")
public Response getUser(@PathParam("userId") String userId) throws SQLException{
    Connection con = getSQLConnection();
    PreparedStatement getUser = con.prepareStatement("SELECT * FROM users WHERE userId = ?");

    try{
        JSONObject result = new JSONObject();

        getUser.setString(1, userId);
        ResultSet data = getUser.executeQuery();

        if(data.first()){
            result.put("userId", data.getString("userId"));
            result.put("firstName", data.getString("firstName"));
            result.put("lastName", data.getString("lastName"));
            result.put("password", data.getString("password"));
            return Response.ok(result).build();

        } else{
            return Response.status(Status.NOT_FOUND).entity("User not found...").build();
        }

    }
    finally{
        // Ressourcen in allen Klassen schließen
        getUser.close();
        con.close();
    }

}
```

Diese Methode verwendet `@GET` mit `@Path("/{userId}")`, sodass
sie über `HTTP GET /adapters/UserAdapter/{userId}` verfügbar ist.
Die `{userId}` wird mit dem Argument `@PathParam("userId")` der Methode abgerufen. 

Wenn der Benutzer nicht gefunden wird, wird der Fehlercode `404 NOT FOUND` zurückgegeben.   
Wenn der Benutzer gefunden wird, wird aus dem generierten JSON-Objekt eine Antwort erstellt. 

Wenn der Methode `@Produces("application/json")` vorangestellt wird, wird sichergestellt, dass der `Content-Type` der Ausgabe korrekt ist. 

### Alle Benutzer abrufen
{: #get-all-users }

Diese Methode ist abgesehen von der `ResultSet`-Schleife mit `getUser` vergleichbar. 

```java
@GET
@Produces("application/json")
public Response getAllUsers() throws SQLException{
    JSONArray results = new JSONArray();
    Connection con = getSQLConnection();
    PreparedStatement getAllUsers = con.prepareStatement("SELECT * FROM users");
    ResultSet data = getAllUsers.executeQuery();

    while(data.next()){
        JSONObject item = new JSONObject();
        item.put("userId", data.getString("userId"));
        item.put("firstName", data.getString("firstName"));
        item.put("lastName", data.getString("lastName"));
        item.put("password", data.getString("password"));

        results.add(item);
    }

    getAllUsers.close();
    con.close();

    return Response.ok(results).build();
}
```

### Benutzer aktualisieren
{: #update-user }

Aktualisieren Sie einen Benutzerdatensatz in der Datenbank. 

```java
@PUT
@Path("/{userId}")
public Response updateUser(@PathParam("userId") String userId,
                            @FormParam("firstName") String firstName,
                            @FormParam("lastName") String lastName,
                            @FormParam("password") String password)
                                    throws SQLException{
    Connection con = getSQLConnection();
    PreparedStatement getUser = con.prepareStatement("SELECT * FROM users WHERE userId = ?");

    try{
        getUser.setString(1, userId);
        ResultSet data = getUser.executeQuery();

        if(data.first()){
            PreparedStatement updateUser = con.prepareStatement("UPDATE users SET firstName = ?, lastName = ?, password = ? WHERE userId = ?");

            updateUser.setString(1, firstName);
            updateUser.setString(2, lastName);
            updateUser.setString(3, password);
            updateUser.setString(4, userId);

            updateUser.executeUpdate();
            updateUser.close();
            return Response.ok().build();


        } else{
            return Response.status(Status.NOT_FOUND).entity("User not found...").build();
        }
    }
    finally{
        // Ressourcen in allen Klassen schließen
        getUser.close();
        con.close();
    }

}
```

Für die Aktualisierung einer vorhandenen Ressource hat sich die Verwendung von `@PUT` (für `HTTP PUT`) und
die Verwendung der Ressourcen-ID im `@Path` bewährt.

### Benutzer löschen
{: #delete-user }

Löschen Sie einen Benutzerdatensatz aus der Datenbank. 

```java
@DELETE
@Path("/{userId}")
public Response deleteUser(@PathParam("userId") String userId) throws SQLException{
    Connection con = getSQLConnection();
    PreparedStatement getUser = con.prepareStatement("SELECT * FROM users WHERE userId = ?");

    try{
        getUser.setString(1, userId);
        ResultSet data = getUser.executeQuery();

        if(data.first()){
            PreparedStatement deleteUser = con.prepareStatement("DELETE FROM users WHERE userId = ?");
            deleteUser.setString(1, userId);
            deleteUser.executeUpdate();
            deleteUser.close();
            return Response.ok().build();

        } else{
            return Response.status(Status.NOT_FOUND).entity("User not found...").build();
        }
    }
    finally{
        // Ressourcen in allen Klassen schließen
        getUser.close();
        con.close();
    }

}
```

`@DELETE` (für `HTTP DELETE`) wird zusammen mit der Ressourcen-ID im `@Path` verwendet, um einen Benutzer zu löschen. 

## Beispieladapter
{: #sample-adapter }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Maven-Adapterprojekt herunterzuladen. 

Zum Maven-Adapterprojekt gehört der oben beschriebene **JavaSQL**-Adapter.   
Außerdem ist im Ordner **Utils** des Projekts ein SQL-Script enthalten. 

### Verwendung des Beispiels
{: #sample-usage }

* Führen Sie in Ihrer SQL-Datenbank das SQL-Script aus. 
* Stellen Sie sicher, dass dem Benutzer `mobilefirst@%` alle Zugriffsberechtigungen erteilt wurden. 
* Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
den [Java-SQL-Adapter zu erstellen und zu implementieren](../../creating-adapters/). 
* Informationen zum Testen oder Debuggen eines Adapters enthält das Lernprogramm [Adapter testen und debuggen](../../testing-and-debugging-adapters). 
