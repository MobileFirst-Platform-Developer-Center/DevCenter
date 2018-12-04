---
layout: tutorial
title: Java SQL 适配器
breadcrumb_title: SQL Adapter
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight:
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

Java 适配器能够使开发人员控制到后端系统的连接。 因此，开发人员应负责确保有关性能和其他实施细节的最佳实践。
本教程中包含一个 Java 适配器示例，该适配器使用 REST 概念连接到 MySQL 后端，以对 `users` 表进行 CRUD（创建、读取、更新和删除）操作。

**先决条件：**

* 确保首先阅读 [Java 适配器](../)教程。
* 本教程默认您已具备 SQL 知识。

#### 跳转至
{: #jump-to }

* [设置数据源](#setting-up-the-data-source)
* [在适配器资源类中实施 SQL](#implementing-sql-in-the-adapter-resource-class)
* [样本适配器](#sample-adapter)

## 设置数据源
{: #setting-up-the-data-source }

为了将 {{ site.data.keys.mf_server }} 配置为能够连接到 MySQL 服务器，需要为适配器的 XML 文件配置**配置属性**。 之后，可以通过 {{ site.data.keys.mf_console }} 对这些属性进行编辑。

编辑 adapter.xml 文件并添加以下属性：

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

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注：**配置属性元素必须始终位于 `JAXRSApplicationClass` 元素*下*。  
在此，我们将定义一些连接设置并为其提供缺省值，以便稍后可以在 AdapterApplication 类中使用这些设置。

## 在适配器资源类中实施 SQL
{: #implementing-sql-in-the-adapter-resource-class }

适配器资源类用于处理服务器的请求。

在提供的样本适配器中，类名为 `JavaSQLResource`。

```java
@Path("/")
  public class JavaSQLResource {
}
```

`@Path("/")` 表示可从 URL `http(s)://host:port/ProjectName/adapters/AdapterName/` 获取资源。

### 使用 DataSource
{: #using-datasource }

部署适配器后或从 {{ site.data.keys.mf_console }} 更改配置时，都会调用适配器的 `MFPJAXRSApplication` 的 `init` 方法。 这是[装入连接属性](../#configuration-api)和创建 `DataSource` 的最佳选择。

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

在资源类中，创建 helper 方法以获取 SQL 连接。
使用 `AdaptersAPI` 以获取当前的 `MFPJAXRSApplication` 实例：

```java
@Context
AdaptersAPI adaptersAPI;

public Connection getSQLConnection() throws SQLException{
  // Create a connection object to the database
  JavaSQLApplication app = adaptersAPI.getJaxRsApplication(JavaSQLApplication.class);
  return app.dataSource.getConnection();
}
```


### 创建用户
{: #create-user }

用于在数据库中创建新的用户记录。

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

由于此方法不具有任何 `@Path`，因此可作为资源的根 URL 进行访问。 由于它使用 `@POST`，因此仅可通过 `HTTP POST` 进行访问。  
此方法具有一系列 `@FormParam` 自变量，这意味着可将其作为 `x-www-form-urlencoded` 参数在 HTTP 主体中发送。

还可以使用 `@Consumes(MediaType.APPLICATION_JSON)` 在 HTTP 主体中将参数作为 JSON 对象进行传递，在此情况下，该方法需要一个 `JSONObject` 自变量，或一个具有与 JSON 属性名称匹配的属性的简单 Java 对象。

`Connection con = getSQLConnection();` 方法从先前定义的数据源中获取连接。

SQL 查询通过 `PreparedStatement` 方法构建。

如果插入成功，那么会使用 `return Response.ok().build()` 方法将 `200 OK`发送回客户机。 如果出现错误，那么将构建具有特定 HTTP 状态代码的其他 `Response` 对象。 在此示例中，将发送 `409 Conflict` 错误代码。 另外，还建议检查所有参数是否都发送（此处未显示）或任何其他数据验证。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：**确保关闭资源，如 prepared 语句和连接。

### 获取用户
{: #get-user }

从数据库中检索用户。

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

此方法使用 `@GET` 与 `@Path("/{userId}")`，这表示可通过 `HTTP GET /adapters/UserAdapter/{userId}` 获得此方法，并可通过此方法的 `@PathParam("userId")` 自变量检索 `{userId}`。

如果未找到此用户，那么将返回 `404 NOT FOUND` 错误代码。  
如果找到了此用户，那么将通过生成的 JSON 对象构建响应。

为此方法前置 `@Produces("application/json")`，以确保输出的 `Content-Type` 正确。

### 获取所有用户
{: #get-all-users }

除针对 `ResultSet` 进行循环外，此方法与 `getUser` 类似。

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

### 更新用户
{: #update-user }

更新数据库中的用户记录。

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

更新现有的资源时，常规做法是使用 `@PUT`（表示 `HTTP PUT`）并在 `@Path` 中使用资源标识。

### 删除用户
{: #delete-user }

从数据库中删除用户记录。

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

`@DELETE`（表示 `HTTP DELETE`）与 `@Path` 中的资源标识一起用于删除某个用户。

## 样本适配器
{: #sample-adapter }

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)适配器 Maven 项目。

适配器 Maven 项目包含上面所述的 **JavaSQL** 适配器。  
另外，还包含 **Utils** 文件夹中的 SQL 脚本。

### 样本用法
{: #sample-usage }

* 运行关系型数据库中的 .sql 脚本。
* 确保 `mobilefirst@%` 用户具有分配的所有访问许可权。
* 使用 Maven、{{ site.data.keys.mf_cli }} 或您所选的 IDE 来[构建和部署 JavaSQL 适配器](../../creating-adapters/)。
* 要测试或调试适配器，请参阅[测试和调试适配器](../../testing-and-debugging-adapters)教程。
