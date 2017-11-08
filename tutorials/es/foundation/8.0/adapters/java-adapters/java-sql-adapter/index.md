---
layout: tutorial
title: Adaptador Java SQL
breadcrumb_title: Adaptador SQL
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight:
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Los adaptadores Java ofrecen a los desarrolladores un amplio control sobre la conectividad con un sistema de fondo.
Es por lo tanto responsabilidad del desarrollador asegurarse de que se siguen los procedimientos recomendados con relación al rendimiento y a otros detalles de implementación.
Esta guía de aprendizaje cubre un ejemplo de un adaptador de Java que se conecta a un sistema de fondo MySQL para realizar operaciones CRUD (Create, Read, Update, Delete) en una tabla `users` mediante la utilización de conceptos REST.


**Requisitos previos:**

* Asegúrese de leer en primer lugar la guía de aprendizaje [Adaptadores Java](../).

* En esta guía de aprendizaje se supone que posee conocimientos de SQL.


#### Ir a
{: #jump-to }

* [Configuración del origen de datos](#setting-up-the-data-source)
* [Implementación de SQL en la clase de Recurso del adaptador](#implementing-sql-in-the-adapter-resource-class)
* [Adaptador de ejemplo](#sample-adapter)

## Configuración del origen de datos
{: #setting-up-the-data-source }

Para poder configurar {{ site.data.keys.mf_server }} de forma que se pueda conectar al servidor MySQL, se debe configurar el archivo XML de adaptador con las **propiedades de configuración**.
Estas propiedades se puede editar más tarde a través de {{ site.data.keys.mf_console }}.

Edite el archivo adater.xml y añada las siguientes propiedades:


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

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Nota:** Los elementos de propiedades de configuración se deben ubicar siempre *debajo* del elemento `JAXRSApplicationClass`.
  
Aquí se definen los valores de conexión y se les proporciona un valor predeterminado, de forma que se puedan utilizar más tarde en la clase AdapterApplication.
## Implementación de SQL en la clase de Recurso del adaptador
{: #implementing-sql-in-the-adapter-resource-class }

La clase de Recurso del adaptador es donde se manejan las solicitudes para el servidor.


En el adaptador de ejemplo proporcionado, el nombre de clase es `JavaSQLResource`.

```java
@Path("/")
  public class JavaSQLResource {
}
```

`@Path("/")` indica que los recursos estarán disponibles en el URL `http(s)://host:port/ProjectName/adapters/AdapterName/`.

### Utilización de un origen de datos
{: #using-datasource }

Cuando se despliega el adaptador, o siempre que cambie la configuración en {{ site.data.keys.mf_console }}, se llama al método `init` de `MFPJAXRSApplication` del adaptador.
Este es un buen lugar para [cargar las propiedades de configuración](../#configuration-api) y crear un `origen de datos`.


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

En la clase de recurso, cree un método de ayudante para obtener la conexión SQL.
Utilice `AdaptersAPI` para obtener la instancia actual de `MFPJAXRSApplication`:


```java
@Context
AdaptersAPI adaptersAPI;

public Connection getSQLConnection() throws SQLException{
  // Create a connection object to the database
  JavaSQLApplication app = adaptersAPI.getJaxRsApplication(JavaSQLApplication.class);
  return app.dataSource.getConnection();
}
```


### Creación de usuario
{: #create-user }

Se utiliza para crear un nuevo registro de usuario en la base de datos.


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
        //Return a 200 OK
        return Response.ok().build();
    }
    catch (SQLIntegrityConstraintViolationException violation) {
        //Trying to create a user that already exists
        return Response.status(Status.CONFLICT).entity(violation.getMessage()).build();
    }
    finally{
        //Close resources in all cases
        insertUser.close();
        con.close();
    }  
}
```

Puesto que este método no tiene ningún `@Path`, es accesible como el URL raíz del recurso.
Puesto que utiliza `@POST`, únicamente es accesible a través de `HTTP POST`.
  
El método tiene un grupo de argumentos `@FormParam`, lo que significa que estos argumentos se pueden enviar en el cuerpo HTTP como parámetros `x-www-form-urlencoded`.


También es posible pasar los parámetros en el cuerpo HTTP como objetos JSON, mediante la utilización de `@Consumes(MediaType.APPLICATION_JSON)`, en cuyo caso el método necesita un argumento `JSONObject`, o un objeto Java simple con propiedades que coincidan con los nombres de propiedad de JSON.


El método `Connection con = getSQLConnection();` obtiene la conexión desde el origen de datos definido con anterioridad.


Las consultas de SQL las crea el método `PreparedStatement`.


Si la inserción es satisfactoria, se utiliza el método `return Response.ok().build()` para enviar un `200 OK` de vuelta al cliente.
Si se produce un error, se pueden crear un objeto `Response` diferente con un código de estado HTTP específico.
En este ejemplo, se envía un código de error `409 Conflict`.
También es recomendable comprobar si se envían todos los parámetros (no se muestra aquí) o cualquier otra validación de datos.


> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** Asegúrese de cerrar recursos como, por ejemplo, sentencias preparadas y conexiones.
### Obtención de usuario
{: #get-user }

Recupera un usuario de la base de datos.


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
        //Close resources in all cases
        getUser.close();
        con.close();
    }

}
```

Este método utiliza `@GET` con `@Path("/{userId}")`, lo que significa que está disponible a través de `HTTP GET /adapters/UserAdapter/{userId}` y el `{userId}` se recupera mediante el argumento `@PathParam("userId")` del método.


Si no se encuentra el usuario, se devuelve un código de error `404 NOT FOUND`.
  
Si se encuentra el usuario, se construye una respuesta desde el objeto JSON generado.


Anteponiendo `@Produces("application/json")` al método se asegura que el `Content-Type` de la salida es correcto.


### Obtención de todos los usuarios
{: #get-all-users }

Este método es similar a `getUser`, excepto por el bucle en que se recorre sobre `ResultSet`.


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

### Actualización de usuario
{: #update-user }

Actualización de un registro de usuarios en la base de datos.


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
        //Close resources in all cases
        getUser.close();
        con.close();
    }

}
```

Cuando se actualiza un recurso existente, es una práctica estándar utilizar `@PUT` (para `HTTP PUT`) y utilizar el ID de recurso en `@Path`.


### Supresión de usuario
{: #delete-user }

Suprime un registro de usuario de la base de datos.


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
        //Close resources in all cases
        getUser.close();
        con.close();
    }

}
```

Se utiliza `@DELETE` (para `HTTP DELETE`) junto con el ID de recurso en el `@Path`, para suprimir un usuario.


## Adaptador de ejemplo
{: #sample-adapter }

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven Adapters.


El proyecto Maven Adapters incluye el adaptador **JavaSQL** descrito con anterioridad.
  
También se incluye un script SQL en la carpeta **Utils**.


### Uso de ejemplo 
{: #sample-usage }

* Ejecute el script .sql script en su base de datos SQL. 
* Asegúrese de que el usuario `mobilefirst@%` tiene todos los permisos de acceso asignados.

* Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar el adaptador JavaSQL](../../creating-adapters/).

* Para probar o depurar un adaptador, consulte la guía de aprendizaje [Pruebas y depuración de adaptadores](../../testing-and-debugging-adapters).

