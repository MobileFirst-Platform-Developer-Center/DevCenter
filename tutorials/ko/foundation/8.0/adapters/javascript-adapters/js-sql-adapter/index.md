---
layout: tutorial
title: JavaScript SQL 어댑터
breadcrumb_title: SQL 어댑터
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 어댑터 Maven 프로젝트 다운로드
url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

SQL 어댑터는 SQL 데이터 소스와 통신하도록 설계되어 있습니다. 일반 SQL 조회 또는 스토어드 프로시저를 사용할 수 있습니다. 

데이터베이스에 연결하려면 JavaScript 코드에 특정 데이터베이스 유형을 위한 JDBC 커넥터 드라이버가 필요합니다. 특정 데이터베이스 유형을 위한 JDBC 커넥터 드라이버를 별도로 다운로드하고 프로젝트에서 종속성으로 추가해야 합니다. 종속성 추가 방법에 대한 자세한 정보는 [Java 및 JavaScript 어댑터 작성](../../creating-adapters/#dependencies) 학습서에서 종속성 섹션을 참조하십시오. 

이 학습서 및 제공된 샘플에서 MySQL 데이터베이스에 연결하기 위해 어댑터를 사용하는 방법을 학습합니다. 

**전제조건:** [JavaScript 어댑터](../) 학습서를 먼저 읽으십시오. 

## XML 파일
{: #the-xml-file }

XML 파일은 설정과 메타데이터를 포함합니다. 

**adapter.xml** 파일에서 다음 매개변수를 선언하십시오.

 * JDBC 드라이버 클래스
 * 데이터베이스 URL
 * 사용자 이름 
 * 비밀번호<br/><br/>

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

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>adapter.xml 속성 및 하위 요소에 대해 클릭</b></a></h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>필수.</i> 이 속성 값은
sql:SQLConnectionPolicy로 설정되어야 합니다.
</li>
                    <li><b>dataSourceDefinition</b>: <i>선택사항.</i> 데이터 소스에 연결하는 데 필요한 매개변수를 포함합니다. 어댑터는
각 요청에 대한 연결을 작성합니다.예: 

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

                    <li><b>dataSourceJNDIName</b>: <i>선택사항.</i> 애플리케이션 서버에서 제공하는 데이터 소스의 JNDI 이름을 사용하여 데이터 소스에 연결합니다. 어댑터는 JNDI 이름과 연관되는 서버 연결 풀에서 연결을 가져옵니다. 애플리케이션 서버에서는 데이터 소스를 구성하는
방법을 보여줍니다. 자세한 정보는 애플리케이션 서버에 {{ site.data.keys.mf_server }} 설치를 참조하십시오. 예: 
                    
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


`connectionPolicy`를 구성하고, 프로시저를 어댑터 XML 파일에 선언합니다. 

```js
<procedure name="getAccountTransactions1"/>
```

## JavaScript 구현
{: #javascript-implementation }

어댑터 JavaScript 파일은 프로시저 논리를 구현하는 데 사용됩니다.   
SQL문을 실행하는 두 가지 방법이 있습니다.

* SQL문 조회
* SQL 스토어드 프로시저

### SQL문 조회
{: #sql-statement-query }

1. SQL 조회를 변수에 할당하십시오. 이는 항상 함수 범위 밖에서 수행되어야 합니다. 
2. 필요한 경우 매개변수를 추가하십시오. 
3. 준비된 조회를 호출하려면 `MFP.Server.invokeSQLStatement` 메소드를 사용하십시오. 
4. 결과를 애플리케이션 또는 다른 프로시저에 리턴하십시오. 

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

### SQL 스토어드 프로시저
{: #sql-stored-procedure }

SQL 스토어드 프로시저를 실행하려면 `MFP.Server.invokeSQLStoredProcedure`
메소드를 사용하십시오. 호출 매개변수로 SQL 스토어드 프로시저 이름을 지정하십시오. 

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

### 다중 매개변수 사용
{: #using-multiple-parameters }
 
SQL 조회에서 단일 또는 다중 매개변수를 사용할 때 함수의 변수를 승인하고 이러한 변수를 **array**의 `invokeSQLStatement` 또는 `invokeSQLStoredProcedure` 매개변수로 전달해야 합니다. 

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

## 호출 결과
{: #invocation-results }

결과는 JSON 오브젝트로 검색됩니다.

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
* `isSuccessful` 특성은 호출 완료 여부를 정의합니다. 
* `resultSet` 오브젝트는 리턴된 레코드의 배열입니다. 
 * 클라이언트 측에서 `resultSet` 오브젝트에 액세스하는 경우: `result.invocationResult.resultSet`
 * 서버 측에서 `resultSet` 오브젝트에 액세스하는 경우: `result.ResultSet`

## 샘플 어댑터
{: #sample-adapter }

어댑터 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/Adapters)하십시오. 

어댑터 Maven 프로젝트는 위에서 설명한 **JavaScriptSQL** 어댑터를 포함합니다.   
또한 **Utils** 폴더에 SQL 스크립트가 포함됩니다. 

### 샘플 사용법
{: #sample-usage }

* SQL 데이터베이스에서.sql 스크립트를 실행하십시오. 
* `mobilefirst@%` 사용자가 지정된 모든 액세스 권한이 있는지 확인하십시오. 
* [JavaScriptSQL 어댑터를 빌드 및 배치](../../creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오. 
* 어댑터를 테스트하거나 디버깅하려면 [어댑터 테스트 및 디버깅](../../testing-and-debugging-adapters) 학습서를 참조하십시오. 

테스트할 때 계정 값은 배열에서 전달되어야 합니다. `["12345"]` 
