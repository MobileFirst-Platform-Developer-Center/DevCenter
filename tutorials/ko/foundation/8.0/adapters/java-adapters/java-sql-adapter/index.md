---
layout: tutorial
title: Java SQL 어댑터
breadcrumb_title: SQL 어댑터
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 어댑터 Maven 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight:
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

Java 어댑터는 백엔드 시스템으로 연결에 대한 제어를 개발자에게 부여합니다. 따라서 성능 및 기타 구현 세부사항을 최적화하는 것은 개발자의 책임입니다. 
이 학습서는 REST 개념을 사용하여 `users` 테이블에 CRUD(작성, 읽기, 업데이트, 삭제) 조작을 수행하기 위해 MySQL 백엔드에 연결하는 Java 어댑터의 예를 다룹니다. 

**전제조건:**

* [Java 어댑터](../) 학습서를 먼저 읽으십시오. 
* 이 학습서는 SQL에 대한 지식을 가지고 있다고 가정합니다. 

#### 다음으로 이동
{: #jump-to }

* [데이터 소스 설정](#setting-up-the-data-source)
* [어댑터 자원 클래스에서 SQL 구현](#implementing-sql-in-the-adapter-resource-class)
* [샘플 어댑터](#sample-adapter)

## 데이터 소스 설정
{: #setting-up-the-data-source }

MySQL 서버에 연결할 수 있도록 {{site.data.keys.mf_server }}를 구성하려면 어댑터의 XML 파일이 **configuration properties**로 구성되어야 합니다. 이러한 특성은 {{site.data.keys.mf_console }}을 통해 나중에 편집될 수 있습니다. 

adater.xml 파일을 편집하고 다음 특성을 추가하십시오.

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

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **참고:** 구성 특성 요소는 항상 `JAXRSApplicationClass` 요소 *아래*에 위치해야 합니다.   
여기서 연결 설정을 정의하고 기본값을 제공하여 나중에 AdapterApplication 클래스에 사용할 수 있습니다.

## 어댑터 자원 클래스에서 SQL 구현
{: #implementing-sql-in-the-adapter-resource-class }

어댑터 자원 클래스는 서버에 대한 요청이 처리되는 위치입니다. 

제공된 샘플 어댑터에서 클래스 이름은 `JavaSQLResource`입니다.

```java
@Path("/")
public class JavaSQLResource {
}
```

`@Path("/")`는 자원이 URL `http(s)://host:port/ProjectName/adapters/AdapterName/`에서 사용 가능함을 의미합니다. 

### 데이터 소스 사용 
{: #using-datasource }

어댑터가 배치될 때 또는 구성이 {{site.data.keys.mf_console }}에서 변경될 때마다 어댑터의 `MFPJAXRSApplication`의 `init` 메소드가 호출됩니다. 이는 [연결 특성 로드](../#configuration-api) 및 `DataSource`를 작성하는 좋은 위치입니다. 

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

자원 클래스에서 SQL 연결을 얻기 위한 헬퍼 방법을 작성하십시오.
현재 `MFPJAXRSApplication` 인스턴스를 얻으려면 `AdaptersAPI`를 사용하십시오.

```java
@Context
AdaptersAPI adaptersAPI;

public Connection getSQLConnection() throws SQLException{
  // Create a connection object to the database
  JavaSQLApplication app = adaptersAPI.getJaxRsApplication(JavaSQLApplication.class);
  return app.dataSource.getConnection();
}
```


### 사용자 작성
{: #create-user }

데이터베이스에서 새 사용자 레코드를 작성하는 데 사용됩니다. 

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

이 메소드가 `@Path`를 가지지 않으므로, 자원의 루트 URL로 액세스 가능합니다. `@POST`을 사용하기 때문에, `HTTP POST`를 통해서만 액세스 가능합니다.   
메소드는 일련의 `@FormParam` 인수를 가지고 있으며, 이러한 인수는 `x-www-form-urlencoded` 매개변수로서 HTTP 본문에서 전송될 수 있습니다. 

`@Consumes(MediaType.APPLICATION_JSON)`를 사용하여 JSON 오브젝트로서 HTTP 본문에서 매개변수를 전달할 수도 있습니다. 이 경우에 메소드에 `JSONObject` 인수 또는 JSON 특성 이름과 일치하는 특성을 가진 단순한 Java 오브젝트가 필요합니다. 

`Connection con = getSQLConnection();` 메소드는 더 먼저 정의된 데이터 소스에서 연결을 얻습니다. 

SQL 조회는 `PreparedStatement` 메소드에 의해 빌드됩니다. 

삽입에 성공하면, `return Response.ok().build()` 메소드는 `200 OK`를 클라이언트로 다시 전송하는 데 사용됩니다. 오류가 있으면, 다른 `Response` 오브젝트가 특정 HTTP 상태 코드로 빌드될 수 있습니다. 이 예에서, `409 Conflict` 오류 코드가 전송됩니다. 또한 모든 매개변수가 전송되는지 여부(여기에 표시되지 않음) 또는 기타 데이터 유효성 검증을 확인하는 것이 권장됩니다.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 준비된 명령문 및 연결과 같은 자원을 닫았는지 확인하십시오.

### 사용자 가져오기
{: #get-user }

사용자를 데이터베이스에서 검색하십시오. 

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

이 메소드는 `@GET`을 `@Path("/{userId}")`와 함께 사용하며 이는 메소드가 `HTTP GET /adapters/UserAdapter/{userId}`를 통해 사용 가능하고 `{userId}`가 메소드의 `@PathParam("userId")` 인수에 의해 검색됨을 의미합니다. 

사용자를 찾을 수 없는 경우, `404 NOT FOUND` 오류 코드가 리턴됩니다.   
사용자가 발견되면, 응답은 생성된 JSON 오브젝트에서 빌드됩니다. 

`@Produces("application/json)`를 메소드 앞에 추가하여 출력의 `Content-Type`이 정확하다는 것을 확인합니다. 

### 모든 사용자 가져오기
{: #get-all-users }

이 메소드는 `ResultSet`에 대한 루프를 제외하고 `getUser`와 유사합니다. 

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

### 사용자 업데이트
{: #update-user }

데이터베이스에서 사용자 레코드를 업데이트하십시오. 

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

기존 자원을 업데이트할 때 (`HTTP PUT`에 대해) `@PUT`을 사용하고 `@Path`에서 자원 ID을 사용하는 것이 일반적 사례입니다. 

### 사용자 삭제
{: #delete-user }

사용자를 데이터베이스에서 삭제하십시오. 

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

(`HTTP DELETE`에 대해) `@DELETE`는 사용자를 삭제하기 위해 `@Path`에서 자원 ID와 함께 사용됩니다. 

## 샘플 어댑터
{: #sample-adapter }

어댑터 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오. 

어댑터 Maven 프로젝트는 위에서 설명한 **JavaSQL** 어댑터를 포함합니다.   
또한 **Utils** 폴더에 SQL 스크립트가 포함됩니다. 

### 샘플 사용법
{: #sample-usage }

* SQL 데이터베이스에서.sql 스크립트를 실행하십시오. 
* `mobilefirst@%` 사용자가 지정된 모든 액세스 권한이 있는지 확인하십시오. 
* [JavaSQL 어댑터를 빌드 및 배치](../../creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오. 
* 어댑터를 테스트하거나 디버깅하려면 [어댑터 테스트 및 디버깅](../../testing-and-debugging-adapters) 학습서를 참조하십시오. 
