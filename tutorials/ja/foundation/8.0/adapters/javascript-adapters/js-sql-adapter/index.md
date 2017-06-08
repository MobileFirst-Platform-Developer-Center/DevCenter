---
layout: tutorial
title: JavaScript SQL アダプター
breadcrumb_title: SQL アダプター
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: アダプター Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

SQL アダプターは、任意の SQL データ・ソースと通信するように設計されています。プレーン SQL 照会またはストアード・プロシージャーを使用できます。

データベースに接続するには、JavaScript コードで、特定のデータベース・タイプの JDBC コネクター・ドライバーが必要です。特定のデータベース・タイプに対応する JDBC コネクター・ドライバーを別個にダウンロードして、プロジェクトで依存関係としてそのドライバーを追加する必要があります。依存関係の追加方法について詳しくは、[Java アダプターおよび JavaScript アダプターの作成](../../creating-adapters/#dependencies)チュートリアルの『依存関係』セクションを参照してください。

このチュートリアルおよび付属のサンプルでは、アダプターを使用して MySQL データベースに接続する方法について学習します。

**前提条件:** 最初に必ず、[JavaScript アダプター](../)チュートリアルをお読みください。

## XML ファイル
{: #the-xml-file }

XML ファイルには、設定およびメタデータが含まれています。

**adapter.xml** ファイルで、以下のパラメーターを宣言します。

 * JDBC ドライバー・クラス
 * データベース URL
 * ユーザー名
 * パスワード<br/><br/>

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
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>ここをクリックして adapter.xml 属性とサブエレメントを表示</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>必須。</i> この属性の値は sql:SQLConnectionPolicy に設定される必要があります。</li>
                    <li><b>dataSourceDefinition</b>: <i>オプション。</i> データ・ソースへの接続に必要なパラメーターを含みます。アダプターは、各要求で接続を作成します。以下に例を示します。

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

                    <li><b>dataSourceJNDIName</b>: <i>オプション。</i> アプリケーション・サーバーで提供されているデータ・ソースの JNDI 名を使用して、データ・ソースに接続します。アダプターは、JNDI 名に関連付けられたサーバー接続プールから接続を受け取ります。アプリケーション・サーバーには、データ・ソースを構成する方法が用意されています。詳しくは、アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストールを参照してください。以下に例を示します。
                    
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


`connectionPolicy` を構成して、アダプター XML ファイル内でプロシージャーを宣言します。

```js
<procedure name="getAccountTransactions1"/>
```

## JavaScript 実装
{: #javascript-implementation }

アダプター JavaScript ファイルを使用してプロシージャー・ロジックを実装します。  
SQL ステートメントを実行するには以下の 2 つの方法があります。

* SQL ステートメント照会
* SQL ストアード・プロシージャー

### SQL ステートメント照会
{: #sql-statement-query }

1. SQL 照会を変数に割り当てます。これは、常に関数のスコープの外部で行う必要があります。
2. 必要に応じて、パラメーターを追加します。
3. `MFP.Server.invokeSQLStatement` メソッドを使用して、作成した照会を呼び出します。
4. 結果をアプリケーションまたは別のプロシージャーに返します。

   ```javascript
   // 1. SQL 照会を変数に (関数のスコープの外部で）割り当てます。
   // 2. 必要に応じてパラメーターを追加します。
   var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
    "FROM accounttransactions " +
    "WHERE accounttransactions.fromAccount = ? OR accounttransactions.toAccount = ? " +
    "ORDER BY transactionDate DESC " +
    "LIMIT 20;";

    // 準備した SQL 照会を呼び出し、呼び出し結果を返します。
   function getAccountTransactions1(accountId){
   // 3. 「MFP.Server.invokeSQLStatement」メソッドを使用して、作成した照会を呼び出します。
   // 4. 結果をアプリケーションまたは別のプロシージャーに返します。
        return MFP.Server.invokeSQLStatement({
	       preparedStatement : getAccountsTransactionsStatement,
	       parameters : [accountId, accountId]
        });
   }
   ```       

### SQL ストアード・プロシージャー
{: #sql-stored-procedure }

SQL ストアード・プロシージャーを実行するには、`MFP.Server.invokeSQLStoredProcedure` メソッドを使用します。SQL ストアード・プロシージャーの名前を呼び出しパラメーターとして指定します。

```javascript
// ストアード SQL プロシージャーを呼び出し、呼び出し結果を返します。
function getAccountTransactions2(accountId){
  // SQL ストアード・プロシージャーを実行するには、「MFP.Server.invokeSQLStoredProcedure」メソッドを使用します。
  return MFP.Server.invokeSQLStoredProcedure({
    procedure : "getAccountTransactions",
    parameters : [accountId]
  });
}
```  

### 複数のパラメーターの使用
{: #using-multiple-parameters }
 
SQL 照会で単一または複数のパラメーターを使用する場合には、関数で変数を受け入れ、変数を `invokeSQLStatement` または `invokeSQLStoredProcedure` のパラメーターに**配列**で渡してください。

```javascript
var getAccountsTransactionsStatement = "SELECT transactionId, fromAccount, toAccount, transactionDate, transactionAmount, transactionType " +
	"FROM accounttransactions " +
	"WHERE accounttransactions.fromAccount = ? AND accounttransactions.toAccount = ? " +
	"ORDER BY transactionDate DESC " +
	"LIMIT 20;";

//作成した SQL 照会を呼び出し、呼び出し結果を返します。
function getAccountTransactions1(fromAccount, toAccount){
	return MFP.Server.invokeSQLStatement({
		preparedStatement : getAccountsTransactionsStatement,
		parameters : [fromAccount, toAccount]
	});
}
```

## 呼び出し結果
{: #invocation-results }

結果は、JSON オブジェクトとして取得されます。

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
* ` isSuccessful` プロパティーは、呼び出しが正常に終了したかどうかを定義します。
* `resultSet` は、返されたレコードの配列です。 
 * クライアント・サイドの `resultSet` オブジェクトにアクセスする場合: `result.invocationResult.resultSet`
 * サーバー・サイドの `resultSet` オブジェクトにアクセスする場合: `result.ResultSet`

## サンプル・アダプター
{: #sample-adapter }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters) してアダプター Maven プロジェクトをダウンロードします。

アダプター Maven プロジェクトには、前に説明した **JavaScriptSQL** アダプターが含まれています。  
また、**Utils** フォルダーに SQL スクリプトも含まれています。

### 使用例
{: #sample-usage }

* SQL データベースで .sql スクリプトを実行します。
* `mobilefirst@%` ユーザーが、すべてのアクセス権限を割り当てられていることを確認します。
* Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[JavaScriptSQL アダプターのビルドとデプロイ](../../creating-adapters/)を行います。
* アダプターをテストまたはデバッグするには、[アダプターのテストおよびデバッグ](../../testing-and-debugging-adapters)チュートリアルを参照してください。

テスト時には、アカウント値を配列 (`["12345"]`) で渡す必要があります。
