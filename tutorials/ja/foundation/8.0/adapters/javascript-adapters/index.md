---
layout: tutorial
title: JavaScript アダプター
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

JavaScript アダプターは、HTTP および SQL のバックエンドに接続するためのテンプレートを提供します。このアダプターは、プロシージャーと呼ばれるサービスのセットを提供します。モバイル・アプリケーションで AJAX 要求を発行することで、これらのプロシージャーを呼び出すことができます。

**前提条件:** 最初に必ず、 [Java アダプターおよび JavaScript アダプターの作成](../creating-adapters)チュートリアルをお読みください。

## ファイル構造
{: #file-structure }

![mvn-adapter](js-adapter-fs.png)

### adapter-resources フォルダー 
{: #the-adapter-resources-folder }
 
**adapter-resources** フォルダーには、XML 構成ファイルが含まれています。この構成ファイルでは、接続オプションが記述され、アプリケーションまたは他のアダプターに公開されるプロシージャーがリストされています。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">
    <displayName>JavaScriptAdapter</displayName>
    <description>JavaScriptAdapter</description>

    <connectivity>
        <connectionPolicy>
        ...
        </connectionPolicy>
    </connectivity>

    <procedure name="procedure1"></procedure>
    <procedure name="procedure2"></procedure>

    <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a name="click-for-adapter-xml-attributes-and-subelements" class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>ここをクリックして adapter.xml 属性とサブエレメントを表示</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><code>name</code>: <i>必須。</i> アダプターの名前。この名前は {{ site.data.keys.mf_server }} 内で固有でなければなりません。 英数字およびアンダースコアーを含めることができ、先頭は文字である必要があります。 アダプターを定義してデプロイした後に、その名前を変更することはできません。</li>
					<li><b>&lt;displayName&gt;</b>: <i>オプション。</i> {{ site.data.keys.mf_console }} に表示されるアダプターの名前。このエレメントが指定されない場合は、代わりに name 属性の値が使用されます。</li>
					<li><b>&lt;description&gt;</b>: <i>オプション。</i> アダプターに関する追加情報。{{ site.data.keys.mf_console }} に表示されます。</li>
					<li><b>&lt;connectivity&gt;</b>: <i>必須。</i> アダプターがバックエンド・アプリケーションに接続するときのメカニズムを定義します。これには、&lt;connectionPolicy&gt; サブエレメントが含まれています。
                        <ul>
                            <li><b>&lt;connectionPolicy&gt;</b>: <i>必須</i>。接続プロパティーを定義します。このサブエレメントの構造は、バックエンド・アプリケーションの統合テクノロジーによって異なります。&lt;connectionPolicy&gt; について詳しくは、<a href="js-http-adapter">HTTP アダプターの &lt;connectionPolicy&gt; エレメント</a>および <a href="js-sql-adapter">SQL アダプターの &lt;connectionPolicy&gt; エレメント</a>を参照してください。</li>
                        </ul>
                    </li>
                    <li><b>&lt;procedure&gt;</b>: <i>必須。</i> バックエンド・アプリケーションによって公開されるサービスにアクセスするためのプロセスを定義します。
                        <ul>
                            <li><code>name</code>: <i>必須。</i> プロシージャーの名前。この名前はアダプター内で固有でなければなりません。 英数字およびアンダースコアーを含めることができ、先頭は文字である必要があります。 </li>
                            <li><code>audit</code>: <i>オプション。</i> プロシージャーへの呼び出しを監査ログに記録するかどうかを定義します。 以下の値が有効です。
                                <ul>
                                    <li><code>true</code>: プロシージャーへの呼び出しが監査ログに記録されます。 </li> 
                                    <li><code>false</code>: デフォルト。プロシージャーへの呼び出しは監査ログに記録されません。</li>
                                </ul>
                            </li>
                            <li><code>scope</code>: <i>オプション。</i> アダプター・リソース・プロシージャーを保護するセキュリティー・スコープ。スコープは、スペースで区切った 1 つ以上のスコープ・エレメントからなるストリングにすることも、ヌルにしてデフォルトのスコープを適用することもできます。スコープ・エレメントは、セキュリティー検査にマップされたキーワード、または、セキュリティー検査の名前です。デフォルトのスコープは <code>RegisteredClient</code> で、これは予約済みの {{ site.data.keys.product_adj }} キーワードです。デフォルトの保護では、リソースにアクセスするためにアクセス・トークンが必要です。<br/>
								{{ site.data.keys.product_adj }} OAuth リソース保護と、JavaScript アダプター・リソースのリソース保護を構成する方法について詳しくは、<a href="../../authentication-and-security/#protecting-adapter-resources">アダプター・リソースの保護</a>を参照してください。<br/>
								<code>secured</code> 属性の値が <code>false</code> の場合、<code>scope</code> 属性は無視されます。</li>
                            <li><code>secured</code>: <i>オプション。</i> アダプター・プロシージャーが {{ site.data.keys.product_adj }} セキュリティー・フレームワークによって保護されるかどうかを定義します。以下の値が有効です。
                                <ul>
                                    <li><code>true</code>: デフォルト。プロシージャーは保護されます。プロシージャーの呼び出しには、有効なアクセス・トークンが必要です。</li>
                                    <li><code>false</code>: プロシージャーは保護されません。プロシージャーの呼び出しにアクセス・トークンは不要です。<a href="../../authentication-and-security/#unprotected-resources"> 保護されていないリソース (Unprotected resources)</a> を参照してください。この値が設定されている場合、<code>scope</code> 属性は無視されます。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><b>&lt;securityCheckDefinition&gt;</b>: <i>オプション。</i> セキュリティー検査オブジェクトを定義します。<a href="../../authentication-and-security/creating-a-security-check">セキュリティー検査の作成</a>チュートリアルで、セキュリティー検査についての詳細を参照してください。</li>
        			<li><code>property</code>: <i>オプション。</i> ユーザー定義プロパティーを宣言します。このチュートリアルの<a href="#custom-properties">『カスタム・プロパティー』</a>セクションで詳細を参照してください。</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

#### カスタム・プロパティー
{: #custom-properties }

**adapter.xml** ファイルには、ユーザー定義のカスタム・プロパティーを含めることもできます。開発者がアダプターの作成中にそれらのプロパティーに割り当てた値は、アダプターを再デプロイせずに、**{{ site.data.keys.mf_console }} → 「[ご使用のアダプター]」→「構成」タブ**でオーバーライドすることができます。ユーザー定義プロパティーは、[getPropertyValue API](#getpropertyvalue) を使用して読み取り、実行時にさらにカスタマイズできます。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注:**  構成プロパティー・エレメントは、必ず &lt;procedure&gt; エレメントの*下に* 配置する必要があります。上の例では、デフォルト値を使用して &lt;displayName&gt; プロパティーを定義し、このプロパティーを後で使用できるようにしてあります。

&lt;property&gt; エレメントには以下の属性があります。

- `name`: 構成クラスで定義されている、プロパティーの名前。 
- `defaultValue`: 構成クラスで定義されたデフォルト値をオーバーライドします。
- `displayName`: *オプション*。コンソールに表示される分かりやすい名前。
- `description`: *オプション*。コンソールに表示される説明。
- `type`: *オプション*。プロパティーが確実に、特定タイプ (`integer`、`string`、`boolean` など) または有効な値のリスト (例えば `type="['1','2','3']"`) になるようにします。

![コンソール・プロパティー](console-properties.png)

#### 構成のプルとプッシュ
{: #pull-and-push-configurations }

カスタマイズしたアダプター・プロパティーは、**「構成ファイル」タブ**に表示されるアダプター構成ファイルを使用して共有できます。   
共有するためには、Maven または {{ site.data.keys.mf_cli }} を使用して、以下で説明する `pull` コマンドと `push` コマンドを使用します。共有するプロパティーについては、*そのプロパティーに対して指定されたデフォルト値を変更する* 必要があります。

アダプター Maven プロジェクトのルート・フォルダーから以下のコマンドを実行します。

**Maven**  

* 構成ファイルを**プルする**場合  
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```
  
* 構成ファイルを**プッシュする**場合
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* 構成ファイルを**プルする**場合
  ```bash
  mfpdev adapter pull
  ```
  
* 構成ファイルを**プッシュする**場合
  ```bash
  mfpdev adapter push
  ```

#### 複数のサーバーへの構成のプッシュ
{: #pushing-configurations-to-multiple-servers }

**pull** コマンドと **push** コマンドは、使用している環境 (DEV、QA、UAT、PRODUCTION) に応じてアダプターで異なる値が必要となる各種の DevOps フローを作成する場合に役立ちます。

**Maven**  
上記の説明で、デフォルトでの **config.json** ファイルの指定方法を確認してください。異なるターゲットを処理するには、異なる名前のファイルを作成します。

**{{ site.data.keys.mf_cli }}**  
デフォルトとは異なる構成ファイルを指定するには、**--configFile** フラグまたは **-c** フラグを使用します。

```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> `mfpdev help adapter pull/push` を使用して、詳細を参照してください。

### js フォルダー
{: #the-js-folder }
 
このフォルダーには、**adapter.xml** ファイルで宣言されているプロシージャーのすべての JavaScript 実装ファイルが含まれています。また、取得した生の XML データの変換スキームを含む、ゼロまたは 1 つ以上の XSL ファイルも含まれています。アダプターによって取得したデータは、生データとして返すことも、アダプター自体で前処理することもできます。いずれの場合も、**JSON オブジェクト**としてアプリケーションに提示されます。

## JavaScript アダプター・プロシージャー
{: #javascript-adapter-procedures }

プロシージャーは、XML で宣言され、サーバー・サイド JavaScript を使用して以下の目的で実装されます。

* アダプター関数をアプリケーションに提供する
* データを取得するため、またはアクションを実行するために、バックエンド・サービスを呼び出す

**adapter.xml** ファイルで宣言される各プロシージャーに対応する関数を JavaScript ファイルで指定する必要があります。

サービスを呼び出す前または後に、サーバー・サイド JavaScript を使用してデータを処理することができます。簡単な XSLT コードを使用して、取得したデータにさらにフィルタリングを適用することができます。  
JavaScript アダプター・プロシージャーは、JavaScript で実装されます。しかし、アダプターはサーバー・サイド・エンティティーであるため、[アダプター・コードで Java を使用する](../javascript-adapters/using-java-in-javascript-adapters)ことが可能です。

### グローバル変数の使用
{: #using-global-variables }

{{ site.data.keys.mf_server }} は HTTP セッションに依存しないため、各要求が異なるノードに到達する可能性があります。データをある要求から次の要求に保持するためには、グローバル変数に依存しないようにする必要があります。

### アダプター応答しきい値
{: #adapter-response-threshold }

アダプター応答は {{ site.data.keys.mf_server }} メモリーにストリングとして保管されるため、アダプター呼び出しは、大容量データを返すようには設計されていません。したがって、使用可能メモリー量を超えるデータの場合、メモリー不足例外が発生してアダプター呼び出しが失敗することがあります。そういった失敗を防止するため、しきい値を構成して、それを超えると {{ site.data.keys.mf_server }} が HTTP 応答を gzip して返すようにします。HTTP プロトコルには、gzip 圧縮をサポートするための標準ヘッダーがあります。クライアント・アプリケーションでも HTTP の gzip コンテンツをサポートできる必要があります。

#### サーバー・サイド
{: #server-side }

{{ site.data.keys.mf_console }} で、**「ランタイム」>「設定」>「アダプター応答の GZIP 圧縮しきい値」**の下で、適切なしきい値を設定します。デフォルト値は 20 KB です。  
**注:** {{ site.data.keys.mf_console }} で変更を保存すると、変更はすぐにランタイムで有効になります。

#### クライアント・サイド
{: #client-side }

すべてのクライアント要求で `Accept-Encoding` ヘッダーの値を `gzip` に設定することで、クライアントが gzip 応答を構文解析できるようにします。
要求変数を指定した `addHeader` メソッドを使用します。例えば、次のようにします。`request.addHeader("Accept-Encoding","gzip");`

## サーバー・サイド API
{: #server-side-apis }

JavaScript アダプターは、サーバー・サイド API を使用して、{{ site.data.keys.mf_server }} に関連する操作 (他の JavaScript アダプターの呼び出し、サーバー・ログへの記録、構成プロパティーの値の取得、Analytics へのアクティビティーの報告、要求の発行者の ID の取得など) を実行できます。  

### getPropertyValue
{: #getpropertyvalue }

`MFP.Server.getPropertyValue(propertyName)` API を使用して、**adapter.xml** または {{ site.data.keys.mf_console }} で定義されているプロパティーを取得します。

```js
MFP.Server.getPropertyValue("name");
```

### getTokenIntrospectionData
{: #gettokenintrospectiondata }

`MFP.Server.getTokenIntrospectionData()` API を使用して、以下のことを実行します。

現行のユーザー ID を取得するには、以下を使用します。

```js
function getAuthUserId(){
   var securityContext = MFP.Server.getTokenIntrospectionData();
   var user = securityContext.getAuthenticatedUser();
 
   return "User ID: " + user.getId;
}
```

### getAdapterName
{: #getadaptername }

`getAdapterName()` API を使用してアダプター名を取得します。

### invokeHttp
{: #invokehttp }

HTTP アダプターで `MFP.Server.invokeHttp(options)` API を使用します。  
[JavaScript HTTP アダプター](js-http-adapter)チュートリアルで使用例を参照できます。

### invokeSQL
{: #invokesql }

SQL アダプターで `MFP.Server.invokeSQLStatement(options)` API および `MFP.Server.invokeSQLStoredProcedure(options)` API を使用します。  
[JavaScript SQL アダプター](js-sql-adapter)チュートリアルで使用例を参照できます。

### addResponseHeader
{: #addresponseheader }

`MFP.Server.addResponseHeader(name,value)` API を使用して、新規ヘッダーを応答に追加します。

```js
MFP.Server.addResponseHeader("Expires","Sun, 5 October 2014 18:00:00 GMT");
```
### getClientRequest
{: #getclientrequest }

`MFP.Server.getClientRequest()` API を使用して、アダプター・プロシージャーの呼び出しに使用した Java HttpServletRequest オブジェクトへの参照を取得します。

```js
var request = MFP.Server.getClientRequest();
var userAgent = request.getHeader("User-Agent");
```

### invokeProcedure
{: #invokeprocedure }

`MFP.Server.invokeProcedure(invocationData)` を使用して、その他の JavaScript アダプターを呼び出します。  
[拡張アダプターの使用法とマッシュアップ](../advanced-adapter-usage-mashup)チュートリアルで使用例を参照できます。

### ロギング
{: #logging }

JavaScript API は、MFP.Logger クラスによってロギング機能を提供します。これには、4 つの標準ロギング・レベルに対応した 4 つの関数が含まれています。  
詳細については、[サーバー・サイドのログ収集](../server-side-log-collection)チュートリアルを参照してください。

## JavaScript アダプターの例
{:# javascript-adapter-examples }
