---
layout: tutorial
title: Java アダプター
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

Java アダプターは、JAX-RS 2.0 仕様に基づいています。言い換えれば、Java アダプターは、{{ site.data.keys.mf_server }} インスタンスに容易にデプロイでき、{{ site.data.keys.mf_server }} API およびその他のサード・パーティー API にアクセスできる JAX-RS 2.0 サービスです。

**前提条件:** 最初に必ず、[Java アダプターおよび JavaScript アダプターの作成](../creating-adapters)チュートリアルをお読みください。

#### ジャンプ先
{: #jump-to }

* [ファイル構造](#file-structure)
* [JAX-RS 2.0 アプリケーション・クラス](#jax-rs-20-application-class)
* [JAX-RS 2.0 リソースの実装](#implementing-a-jax-rs-20-resource)
* [HTTP セッション](#http-session)
* [サーバー・サイド API](#server-side-apis)

## ファイル構造
{: #file-structure }

![mvn-adapter](java-adapter-fs.png)

### adapter-resources フォルダー  
{: #the-adapter-resources-folder }

**adapter-resources** フォルダーには、XML 構成ファイル (**adapter.xml**) が含まれています。この構成ファイルで、このアダプター用の JAX-RS 2.0 アプリケーションのクラス名を構成します。例: `com.sample.JavaAdapterApplication`。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaAdapter"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaAdapter</displayName>
	<description>JavaAdapter</description>

	<JAXRSApplicationClass>com.sample.JavaAdapterApplication</JAXRSApplicationClass>
	
	<property name="DB_url" displayName="Database URL" defaultValue="jdbc:mysql://127.0.0.1:3306/mobilefirst_training"  />
	<property name="DB_username" displayName="Database username" defaultValue="mobilefirst"  />
	<property name="DB_password" displayName="Database password" defaultValue="mobilefirst"  />
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    	<property name="maxAttempts" defaultValue="3"/>
	</securityCheckDefinition>
	
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
                    <li><b>name</b>: <i>必須。</i> アダプターの名前。この名前は {{ site.data.keys.mf_server }} 内で固有でなければなりません。 英数字およびアンダースコアーを含めることができ、先頭は文字である必要があります。 アダプターを定義してデプロイした後に、その名前を変更することはできません。</li>
					<li><b>displayName</b>: <i>オプション。</i> {{ site.data.keys.mf_console }} に表示されるアダプターの名前。このエレメントが指定されない場合は、代わりに name 属性の値が使用されます。</li>
					<li><b>description</b>: <i>オプション。</i> アダプターに関する追加情報。{{ site.data.keys.mf_console }} に表示されます。</li>
					<li><b>JAXRSApplicationClass</b>: <i>/adapter エンドポイントを公開するために必須。</i> このアダプターの JAX-RS アプリケーションのクラス名を定義します。例では、<b>com.sample.JavaAdapterApplication</b> です。</li>
					<li><b>securityCheckDefinition</b>: <i>オプション。</i> セキュリティー検査オブジェクトを定義します。<a href="../../authentication-and-security/creating-a-security-check">セキュリティー検査の作成</a>チュートリアルで、セキュリティー検査についての詳細を参照してください。</li>
					<li><b>property</b>: <i>オプション。</i> ユーザー定義プロパティーを宣言します。以下の『カスタム・プロパティー』トピックで詳細を参照してください。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

#### カスタム・プロパティー
{: #custom-properties }

**adapter.xml** ファイルには、ユーザー定義のカスタム・プロパティーを含めることもできます。開発者がアダプターの作成中にそれらのプロパティーに割り当てた値は、アダプターを再デプロイせずに、**{{ site.data.keys.mf_console }} → 「[ご使用のアダプター]」→ 「構成」タブ**でオーバーライドすることができます。ユーザー定義プロパティーは、[ConfigurationAPI インターフェース](#configuration-api)を使用して読み取り、実行時にさらにカスタマイズできます。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注:**  構成プロパティー・エレメントは、`JAXRSApplicationClass` エレメントの**下に**配置する必要があります。  
上の例では、デフォルト値を指定して接続設定を定義し、これらの接続設定を後で AdapterApplication クラスで使用できるようにしてあります。

`<property>` エレメントには以下の属性があります。

- **name**: 構成クラスで定義されている、プロパティーの名前。 
- **defaultValue**: 構成クラスで定義されたデフォルト値をオーバーライドします。
- **displayName**: *オプション*。コンソールに表示される分かりやすい名前。
- **description**: *オプション*。コンソールに表示される説明。
- **type**: *オプション*。プロパティーが確実に、特定タイプ (`integer`、`string`、`boolean` など) または有効な値のリスト (例えば `type="['1','2','3']"`) になるようにします。

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

### java フォルダー
{: #the-java-folder }

JAX-RS 2.0 サービスの Java ソースは、このフォルダーに入っています。JAX-RS 2.0 サービスは、アプリケーション・クラス (これで `com.ibm.mfp.adapter.api.MFPJAXRSApplication` を拡張します) とリソース・クラスで構成されます。

JAX-RS 2.0 のアプリケーション・クラスおよびリソース・クラスは、Java メソッドおよび URL に対するそれらのメソッドのマッピングを定義します。  
`com.sample.JavaAdapterApplication` が JAX-RS 2.0 アプリケーション・クラスで、`com.sample.JavaAdapterResource` がアプリケーション内に含まれる JAX-RS 2.0 リソースです。

## JAX-RS 2.0 アプリケーション・クラス
{: #jax-rs-20-application-class }

JAX-RS 2.0 アプリケーション・クラスは、そのアプリケーションに含まれるリソースを JAX-RS 2.0 フレームワークに通知します。

```java
package com.sample.adapter;

import java.util.logging.Logger;
import com.ibm.mfp.adapter.api.MFPJAXRSApplication;

public class JavaAdapterApplication extends MFPJAXRSApplication{

    static Logger logger = Logger.getLogger(JavaAdapterApplication.class.getName());

    @Override
    protected void init() throws Exception {
        logger.info("Adapter initialized!");
    }

    @Override
    protected String getPackageToScan() {
        //The package of this class will be scanned (recursively) to find JAX-RS 2.0 resources.
        return getClass().getPackage().getName();
    }
}
```

`MFPJAXRSApplication` クラスは、パッケージをスキャンして JAX-RS 2.0 リソースを見つけ、自動的にリストを作成します。さらに、アダプターがデプロイされるとすぐ (サービスを開始する前) に、{{ site.data.keys.product }} ランタイムの開始時に、{{ site.data.keys.mf_server }} によってこのクラスの `init` メソッドが呼び出されます。

## JAX-RS 2.0 リソースの実装
{: #implementing-a-jax-rs-20-resource }

JAX-RS 2.0 リソースは、ルート URL にマップされる POJO (Plain Old Java Object) です。このリソースには、このルート URL とその子 URL への要求にサービスを提供する Java メソッドが含まれています。どのリソースも、別々の URL セットを持つことができます。

```java
package com.sample.adapter;

import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/")
public class JavaAdapterResource {

    //Define logger (Standard java.util.Logger)
    static Logger logger = Logger.getLogger(JavaAdapterResource.class.getName());

    //Path for method: "<server address>/Adapters/adapters/JavaAdapter/{username}"
    @GET
    @Path("/{username}")
    public String helloUser(@PathParam("username") String name){
        return "Hello " + name;
    }
}
```

* クラス定義の前の `@Path("/")` は、このリソースのルート・パスを判別します。複数のリソース・クラスがある場合は、各リソースに異なるパスを設定する必要があります。  

	例えば、ブログのユーザーを管理するために `@Path("/users")` が指定された `UserResource` がある場合、そのリソースには `http(s)://host:port/ProjectName/adapters/AdapterName/users/` を介してアクセスできます。

	同じアダプターに、ブログの投稿を管理するための、`@Path("/posts")` が指定された別のリソース `PostResource` を含めることもできます。これには、`http(s)://host:port/ProjectName/adapters/AdapterName/posts/` という URL を介してアクセスできます。  

	上の例ではリソース・クラスは 1 つのみであるため、`http(s)://host:port/Adapters/adapters/JavaAdapter/` を介してアクセスできるように、`@Path("/")` に設定されます。  

* 各メソッドの前には 1 つ以上の JAX-RS 2.0 アノテーション (例えば、`@GET`、`@PUT`、`@POST`、`@DELETE`、または`@HEAD` などの「HTTP 要求」タイプのアノテーション) を指定します。これらのアノテーションは、そのメソッドにアクセス可能な方法を定義します。  

* もう 1 つの例 `@Path("/{username}")` は、(リソース・レベルのパスに加えて) このプロシージャーにアクセスするためのパスを定義しています。見ると分かるとおり、このパスには変数部分が含まれています。この変数は、後で、`@PathParam("username") String name` のように定義して、メソッドのパラメーターとして使用されます。  

> その他のさまざまなアノテーションを使用できます。以下で、**『Annotation Types Summary』** を参照してください。
[https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html](https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html)

>**重要:** アダプター実装内で `javax.ws.rs.*` または `javax.servlet.*` からクラスへの静的参照を使用する場合、以下のいずれかのオプションを使用して必ず **RuntimeDelegate** を構成する必要があります。
*	Liberty `jvm.options` で `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` を設定します
または
*	システム・プロパティーまたは JVM カスタム・プロパティー `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl` を設定します


## HTTP セッション
{: #http-session }

{{ site.data.keys.mf_server }} は HTTP セッションに依存しないため、各要求が異なるノードに到達する可能性があります。データをある要求から次の要求へと保持するためには、HTTP セッションに依存しないようにする必要があります。

## サーバー・サイド API
{: #server-side-apis}

Java アダプターは、サーバー・サイド Java API を使用して、{{ site.data.keys.mf_server }}に関連する操作 (他のアダプターの呼び出し、サーバー・ログへの記録、構成プロパティーの値の取得、Analytics へのアクティビティーの報告、要求の発行者の ID の取得など) を実行できます。  

### 構成 API
{: #configuration-api }

`ConfigurationAPI` クラスは、**adapter.xml** または {{ site.data.keys.mf_console }} で定義されているプロパティーを取得するための API を提供します。

Java クラス内に、クラス・レベルで以下を追加します。

```java
@Context
ConfigurationAPI configurationAPI;
```

その後、`configurationAPI` インスタンスを使用してプロパティーを取得できます。

```java
configurationAPI.getPropertyValue("DB_url");
```

アダプター構成が {{ site.data.keys.mf_console }} から変更されると、JAX-RS アプリケーション・クラスが再ロードされ、その `init` メソッドが再び呼び出されます。

`getServerJNDIProperty` メソッドを使用して、サーバー構成の JNDI プロパティーを取得することも可能です。

[Java SQL アダプター](java-sql-adapter)チュートリアルで使用例を参照できます。

### アダプター API
{: #adapters-api }

`AdaptersAPI` クラスは、現行アダプターに関する情報を取得し、他のアダプターに REST 要求を送信するための API を提供します。

Java クラス内に、クラス・レベルで以下を追加します。

```java
@Context
AdaptersAPI adaptersAPI;
```

[拡張アダプターの使用法とマッシュアップ](../advanced-adapter-usage-mashup)チュートリアルで使用例を参照できます。

### Analytics API
{: #analytics-api }

`AnalyticsAPI` クラスは、Analytics に情報を報告するための API を提供します。

Java クラス内に、クラス・レベルで以下を追加します。

```java
@Context
AnalyticsAPI analyticsAPI;
```

[Analytics API ](../../analytics/analytics-api)チュートリアルで使用例を参照できます。

### セキュリティー API
{: #security-api }

`AdapterSecurityContext` クラスは、アダプター REST 呼び出しのセキュリティー・コンテキストを提供します。

Java クラス内に、クラス・レベルで以下を追加します。

```java
@Context
AdapterSecurityContext securityContext;
```

その後、例えば、以下を使用して現行の `AuthenticatedUser` を取得することができます。

```java
AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
```

## Java アダプターの例
{: #java-adapter-examples }

HTTP または SQL のバックエンドと通信する Java アダプターの例については、以下を参照してください。
