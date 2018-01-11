---
layout: tutorial
title: Java SQL アダプター
breadcrumb_title: SQL アダプター
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: アダプター Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight:
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

Java アダプターは、バックエンド・システムへの接続に対する制御権を開発者に与えます。したがって、開発者の責任で、パフォーマンスおよびその他の実装の詳細についてのベスト・プラクティスを実現する必要があります。
このチュートリアルでは、MySQL バックエンドに接続し、REST 概念を使用して `users` テーブルに対する CRUD (作成、読み取り、更新、削除) 操作を行う Java アダプターの例を取り上げます。

**前提条件:**

* 最初に必ず、 [Java アダプター](../)チュートリアルをお読みください。
* このチュートリアルでは、SQL の知識があることを前提としています。

#### ジャンプ先
{: #jump-to }

* [データ・ソースのセットアップ](#setting-up-the-data-source)
* [アダプター・リソース・クラスへの SQL の実装](#implementing-sql-in-the-adapter-resource-class)
* [サンプル・アダプター](#sample-adapter)

## データ・ソースのセットアップ
{: #setting-up-the-data-source }

MySQL サーバーに接続できるように {{ site.data.keys.mf_server }} を構成するには、**構成プロパティー**を使用してアダプターの XML ファイルを構成する必要があります。これらのプロパティーは、後で {{ site.data.keys.mf_console }} で編集できます。

adater.xml ファイルを編集して、以下のプロパティーを追加します。

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

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注:**  構成プロパティー・エレメントは、必ず `JAXRSApplicationClass` エレメントの*下に* 配置する必要があります。  
ここでは、デフォルト値を指定して接続設定を定義し、これらの接続設定を後で AdapterApplication クラスで使用できるようにしてあります。

## アダプター・リソース・クラスへの SQL の実装
{: #implementing-sql-in-the-adapter-resource-class }

アダプター・リソース・クラスは、サーバーに対する要求を処理する場所です。

提供されているサンプル・アダプターでは、クラス名は `JavaSQLResource` です。

```java
@Path("/")
public class JavaSQLResource {
}
```

`@Path("/")` は、URL `http(s)://host:port/ProjectName/adapters/AdapterName/` でリソースが使用可能であることを意味します。

### DataSource の使用
{: #using-datasource }

アダプターをデプロイするとき、または {{ site.data.keys.mf_console }}から構成を変更するたびに、アダプターの `MFPJAXRSApplication` の `init` メソッドが呼び出されます。これは、[接続プロパティーをロード](../#configuration-api)して `DataSource` を作成するのに適しています。

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

リソース・クラスでは、ヘルパー・メソッドを作成して SQL 接続を取得します。
`AdaptersAPI` を使用して、現行の `MFPJAXRSApplication` インスタンスを取得します。

```java
@Context
AdaptersAPI adaptersAPI;

public Connection getSQLConnection() throws SQLException{
  // Create a connection object to the database
  JavaSQLApplication app = adaptersAPI.getJaxRsApplication(JavaSQLApplication.class);
  return app.dataSource.getConnection();
}
```


### ユーザーの作成
{: #create-user }

データベースに新規ユーザー・レコードを作成する場合に使用します。

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

このメソッドでは `@Path` が指定されていないため、リソースのルート URL としてアクセスできます。これは、`@POST` を使用するため、`HTTP POST` 経由でのみアクセス可能になります。  
このメソッドには一連の `@FormParam` 引数があります。これは、これらの引数を HTTP 本体で `x-www-form-urlencoded` パラメーターとして送信できることを意味します。

また、`@Consumes(MediaType.APPLICATION_JSON)` を使用して、HTTP 本体でパラメーターを JSON オブジェクトとして渡すこともできます。この場合、メソッドには、`JSONObject` 引数か、JSON プロパティー名と一致するプロパティーが指定された単純 Java オブジェクトが必要です。

`Connection con = getSQLConnection();` メソッドは、以前に定義されたデータ・ソースからの接続を取得します。

SQL 照会は `PreparedStatement` メソッドによってビルドされます。

挿入が成功した場合は、`return Response.ok().build()` メソッドを使用して、クライアントに `200 OK` を返します。エラーが発生した場合は、特定の HTTP 状況コードを持つ別の `Response` オブジェクトをビルドすることができます。この例では、`409 Conflict` エラー・コードが送られます。すべてのパラメーターが送信されているかどうかや (ここでは示されていません)、その他のデータ検証についても確認することをお勧めします。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:** リソース (作成されたステートメントや接続など) を必ず閉じてください。

### ユーザーの取得
{: #get-user }

データベースからユーザーを取得します。

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

このメソッドでは、`@Path("/{userId}")` を指定した `@GET` を使用します。つまり、`HTTP GET /adapters/UserAdapter/{userId}` 経由でメソッドが使用可能になります。また、`{userId}` は、メソッドの `@PathParam("userId")` 引数で取得されます。

ユーザーが検出されない場合は `404 NOT FOUND` エラー・コードが返されます。  
ユーザーが検出されると、生成された JSON オブジェクトから応答がビルドされます。

メソッドの前に `@Produces("application/json")` を指定することで、出力の `Content-Type` が正しいことを確認します。

### すべてのユーザーの取得
{: #get-all-users }

このメソッドは、`ResultSet` をループする以外は、`getUser` と同じです。

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

### ユーザーの更新
{: #update-user }

データベース内のユーザー・レコードを更新します。

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

既存のリソースの更新時には `@PUT` (`HTTP PUT` の場合) を使用して、`@Path` でリソース ID を使用する手法が標準的です。

### ユーザーの削除
{: #delete-user }

データベースからユーザー・レコードを削除します。

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

`@DELETE` (`HTTP DELETE` の場合) は、ユーザーを削除するために `@Path` でリソース ID と一緒に使用されます。

## サンプル・アダプター
{: #sample-adapter }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

アダプター Maven プロジェクトには、前に説明した **JavaSQL** アダプターが含まれています。  
また、**Utils** フォルダーに SQL スクリプトも含まれています。

### 使用例
{: #sample-usage }

* SQL データベースで .sql スクリプトを実行します。
* `mobilefirst@%`  ユーザーが、すべてのアクセス権限を割り当てられていることを確認します。
* Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[JavaSQL アダプターのビルドとデプロイ](../../creating-adapters/)を行います。
* アダプターをテストまたはデバッグするには、[アダプターのテストおよびデバッグ](../../testing-and-debugging-adapters)チュートリアルを参照してください。
