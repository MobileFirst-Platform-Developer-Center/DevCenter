---
layout: tutorial
title: JavaScript SQL 适配器
breadcrumb_title: SQL 适配器
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

SQL 适配器旨在与任何 SQL 数据源进行通信。您可以使用普通 SQL 查询或存储过程。

要连接到数据库，JavaScript 代码需要特定数据库类型的 JDBC 连接器驱动程序。您必须单独下载特定数据库类型的 JDBC 连接器驱动程序并将其作为依赖关系添加到项目中。有关如何添加依赖关系的更多信息，请参阅[创建 Java 和 JavaScript 适配器](../../creating-adapters/#dependencies)教程的“依赖关系”部分。

在此教程和随附的样本中，您将了解如何使用适配器连接到 MySQL 数据库。

**先决条件：**确保首先阅读 [JavaScript 适配器](../)教程。

## XML 文件
{: #the-xml-file }

此 XML 文件中包含设置和元数据。

在 **adapter.xml** 文件中，声明以下参数：

 * JDBC 驱动程序类
 * 数据库 URL
 * 用户名
 * 密码<br/><br/>

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
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击获取 adapter.xml 属性和子元素</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>：<i>必填。</i> 此属性的值必须设置为 sql:SQLConnectionPolicy。</li>
                    <li><b>dataSourceDefinition</b>：<i>可选。</i>包含连接到数据源所需的参数。适配器会为每个请求创建连接。例如：

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

                    <li><b>dataSourceJNDIName</b>：<i>可选。</i>使用应用程序服务器提供的数据源的 JNDI 名称来连接到数据源。适配器从与该 JNDI 名称关联的服务器连接池中获取连接。应用程序服务器提供了一种配置数据源的方式。有关更多信息，请参阅“将 {{ site.data.keys.mf_server }} 安装到应用程序服务器”。例如：
                    
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


配置 `connectionPolicy` 后，在适配器 XML 文件中声明过程。

```js
<procedure name="getAccountTransactions1"/>
```

## JavaScript 实施
{: #javascript-implementation }

适配器 JavaScript 文件用于实施过程逻辑。  
可通过以下两种方式运行 SQL 语句：

* SQL 语句查询
* SQL 存储过程

### SQL 语句查询
{: #sql-statement-query }

1. 将 SQL 查询分配给变量。该操作必须始终在函数作用域以外完成。
2. 根据需要添加参数。
3. 使用 `MFP.Server.invokeSQLStatement` 方法调用 prepared 查询。
4. 将结果返回到应用程序或其他过程。

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

### SQL 存储过程
{: #sql-stored-procedure }

要运行 SQL 存储过程，请使用 `MFP.Server.invokeSQLStoredProcedure` 方法。将 SQL 存储过程名称指定为调用参数。

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

### 使用多个参数
{: #using-multiple-parameters }
 
在 SQL 查询中使用单个或多个参数时，请确保接受函数中的变量，并将其传递给 **array** 中的 `invokeSQLStatement` 或 `invokeSQLStoredProcedure` 参数。

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

## 调用结果
{: #invocation-results }

将结果作为 JSON 对象进行检索：

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
* `isSuccessful` 属性定义调用是否成功。
* `resultSet` 对象是包含返回记录的数组。
 * 要在客户机端访问 `resultSet` 对象：`result.invocationResult.resultSet`
 * 要在服务器端访问 `resultSet` 对象：`result.ResultSet`

## 样本适配器
{: #sample-adapter }

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Adapters)适配器 Maven 项目。

适配器 Maven 项目包含上面所述的 **JavaScriptSQL** 适配器。  
另外，还包含 **Utils** 文件夹中的 SQL 脚本。

### 样本用法
{: #sample-usage }

* 运行关系型数据库中的 .sql 脚本。
* 确保 `mobilefirst@%` 用户具有分配的所有访问许可权。
* 使用 Maven、{{ site.data.keys.mf_cli }} 或您所选的 IDE 来[构建和部署 JavaScriptSQL 适配器](../../creating-adapters/)。
* 要测试或调试适配器，请参阅[测试和调试适配器](../../testing-and-debugging-adapters)教程。

测试时，应当在数组 `["12345"]` 中传递帐户值。
