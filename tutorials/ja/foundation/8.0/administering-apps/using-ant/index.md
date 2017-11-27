---
layout: tutorial
title: Ant を使用したアプリケーションの管理
breadcrumb_title: Ant を使用した管理
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**mfpadm** Ant タスクを通じて {{ site.data.keys.product_adj }} アプリケーションを管理することができます。

#### ジャンプ先
{: #jump-to }

* [他の機能との比較](#comparison-with-other-facilities)
* [前提条件](#prerequisites)

## 他の機能との比較
{: #comparison-with-other-facilities }
{{ site.data.keys.product_full }} の管理操作は、以下の方法で実行できます。

* {{ site.data.keys.mf_console }}。対話式です。
* **mfpadm** Ant タスク。
* **mfpadm** プログラム。
* {{ site.data.keys.product_adj }} 管理 REST サービス。

**mfpadm** Ant タスク、**mfpadm** プログラム、および REST サービスは、次のような操作の自動化または無人実行に役立ちます。

* 繰り返しの多い操作でオペレーターのエラーを防止する。
* オペレーターの通常の作業時間外に操作を行う。
* テスト・サーバーまたは実動前サーバーと同じ設定で実動サーバーを構成する。

**mfpadm** Ant タスクと **mfpadm** プログラムは、REST サービスよりも使い方が簡単で、エラー・レポートも充実しています。mfpadm プログラムよりも **mfpadm** Ant タスクが優れている点は、プラットフォームに依存しないことと、Ant との統合がすでに使用可能なときに統合が容易であることです。

## 前提条件
{: #prerequisites }
**mfpadm** ツールは、{{ site.data.keys.mf_server }} インストーラーを使用してインストールされます。このページの残りの部分では、**product\_install\_dir** は {{ site.data.keys.mf_server }} インストーラーのインストール・ディレクトリーを示します。

**mfpadm** タスクを実行するために Apache Ant が必要です。サポートされる Ant の最小バージョンについて詳しくは、システム要件を参照してください。

利便性を考慮して、{{ site.data.keys.mf_server }} には Apache Ant 1.9.4 が組み込まれています。**product\_install\_dir/shortcuts/** ディレクトリーで、以下のスクリプトが提供されます。

* ant (UNIX / Linux の場合)
* ant.bat (Windows の場合)

これらのスクリプトはいつでも実行できる状態にあります。つまり、特定の環境変数を必要としないということです。環境変数 JAVA_HOME が設定された場合、スクリプトはこれを受け入れます。

**mfpadm** Ant タスクは、{{ site.data.keys.mf_server }} をインストールしたコンピューターとは別のコンピューターで使用できます。

* ファイル **product\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar** を目的のコンピューターにコピーします。
* サポートされているバージョンの Apache Ant と Java ランタイム環境が、目的のコンピューターにインストールされていることを確認します。

**mfpadm** Ant タスクを使用するには、次の初期化コマンドを Ant スクリプトに追加します。

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

**defaults.properties** によって実行される初期化は antlib.xml によっても暗黙的に実行されるため、同じ **mfp-ant-deployer.jar** ファイルを参照する他の初期化コマンドは冗長となります。冗長な初期化コマンドの例を以下に示します。

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

{{ site.data.keys.mf_server }} インストーラーの実行について詳しくは、[IBM インストール・マネージャーの実行 (Running IBM Installation Manager) ](../../installation-configuration/production/installation-manager/)を参照してください。

#### ジャンプ先
{: #jump-to-1 }

* [**mfpadm** Ant タスクの呼び出し](#calling-the-mfpadm-ant-task)
* [一般構成用のコマンド](#commands-for-general-configuration)
* [アダプター用のコマンド](#commands-for-adapters)
* [アプリケーション用のコマンド](#commands-for-apps)
* [デバイス用のコマンド](#commands-for-devices)
* [トラブルシューティング用のコマンド](#commands-for-troubleshooting)

### mfpadm Ant タスクの呼び出し
{: #calling-the-mfpadm-ant-task }
**mfpadm** Ant タスクとその関連コマンドを使用して、{{ site.data.keys.product_adj }} アプリケーションを管理することができます。
次のようにして **mfpadm** Ant タスクを呼び出します。

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    some commands
</mfpadm>
```

#### 属性
{: #attributes }
**mfpadm** Ant タスクには以下の属性があります。

| 属性| 説明| 必須| デフォルト | 
|----------------|-------------|----------|---------|
| url	         | 管理サービスの {{ site.data.keys.product_adj }} Web アプリケーションのベース URL| はい| |
| secure	     | セキュリティー・リスクをともなう操作を回避するかどうか| いいえ| true|
| user	         | {{ site.data.keys.product_adj }} 管理サービスにアクセスするためのユーザー名| はい| |
| password	     | ユーザーのパスワード| どちらか 1 つが必要| |
| passwordfile|	ユーザーのパスワードを含むファイル| どちらか 1 つが必要| |	 
| timeout	     | REST サービス・アクセス全体のタイムアウト (秒単位)| いいえ| |
| connectTimeout|	ネットワーク接続確立のタイムアウト (秒単位)| いいえ| |	 
| socketTimeout|	ネットワーク接続の損失検出のタイムアウト (秒単位)| いいえ| |
| connectionRequestTimeout|	接続要求プールからのエントリー取得のタイムアウト (秒単位)| いいえ| |
| lockTimeout|	ロック取得のタイムアウト| いいえ| |

**url**<br/>
ベース URL には、HTTPS プロトコルを使用することを推奨します。例えば、デフォルト・ポートとコンテキスト・ルートを使用する場合、次の URL を使用します。

* WebSphere Application Server の場合: [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* Tomcat の場合: [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
デフォルト値は **true** です。**secure="false"** を設定すると、以下の影響がある場合があります。

* ユーザーとパスワードが、セキュアでない方法で送信される可能性があります (暗号化されていない HTTP で送信される可能性もあります)。
* サーバーの SSL 証明書は、たとえ自己署名された場合でも、あるいは指定されたサーバーのホスト名とは異なるホスト名のために作成された場合でも、受け入れられます。

**password**<br/>
パスワードは、Ant スクリプトで **password** 属性を使用して指定するか、**passwordfile** 属性で渡す別のファイルで指定します。
パスワードは機密情報であり、保護する必要があります。同じコンピューター上の他のユーザーがこのパスワードを知ることができないようにしてください。パスワードを保護するには、パスワードをファイルに入力する前に、自分以外のユーザーに対しファイルの読み取り権限を削除します。例えば、以下のいずれかのコマンドを使用できます。

* UNIX の場合: `chmod 600 adminpassword.txt`
* Windows の場合: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

また、偶発的な表示からパスワードを隠すために、パスワードを難読化してことをお勧めします。このためには、**mfpadm** config password コマンドを使用して、難読化したパスワードを構成ファイルに保管します。次に、Ant スクリプトまたはパスワード・ファイルに、難読化したパスワードをコピーして貼り付けることができます。

**mfpadm** の呼び出しには、エンコードされたコマンドが内部エレメントに含まれます。これらのコマンドは、リストされた順番で実行されます。これらのいずれかのコマンドが失敗すると、残りのコマンドは実行されず、**mfpadm** 呼び出しは失敗となります。

#### エレメント
{: #elements }
**mfpadm** 呼び出しでは以下のエレメントを使用できます。

| エレメント| 説明| カウント|
|-------------------------------|-------------|-------|
| show-info	                    | ユーザーと構成の情報を表示します| 0..∞| 
| show-global-config	        | グローバル構成情報を表示します| 0..∞| 
| show-diagnostics| 診断情報を表示します| 0..∞| 
| show-versions	                | バージョン情報を表示します| 0..∞| 
| unlock	                    | 汎用ロックをリリースします| 0..∞| 
| list-runtimes	                | ランタイムをリストします| 0..∞| 
| show-runtime      	        | ランタイムに関する情報を表示します| 0..∞| 
| delete-runtime	            | ランタイムを削除します| 0..∞| 
| show-user-config	            | ランタイムのユーザー構成を表示します| 0..∞| 
| set-user-config	            | ランタイムのユーザー構成を指定します| 0..∞| 
| show-confidential-clients| ランタイムの機密クライアントの構成を表示します| 0..∞| 
| set-confidential-clients| ランタイムの機密クライアントの構成を指定します| 0..∞| 
| set-confidential-clients-rule| ランタイムの機密クライアント構成のルールを指定します| 0..∞| 
| list-adapters	                | アダプターをリストします| 0..∞| 
| deploy-adapter	            | アダプターをデプロイします| 0..∞| 
| show-adapter	                | アダプターに関する情報を表示します| 0..∞| 
| delete-adapter	            | アダプターを削除します| 0..∞| 
| adapter	                    | アダプターへの他の操作| 0..∞| 
| list-apps	                    | アプリケーションをリストします| 0..∞| 
| deploy-app	                | アプリケーションをデプロイします| 0..∞| 
| show-app	                    | アプリケーションに関する情報を表示します| 0..∞| 
| delete-app	                | アプリケーションを削除します| 0..∞| 
| show-app-version| アプリケーション・バージョンに関する情報を表示します| 0..∞| 
| delete-app-version| アプリケーションのバージョンを削除します| 0..∞| 
| app	                        | アプリケーションへの他の操作| 0..∞| 
| app-version	                | アプリケーション・バージョンに関する他の操作| 0..∞| 
| list-devices	                | デバイスをリストします| 0..∞| 
| remove-device	                | デバイスを削除します| 0..∞| 
| device	                    | デバイスの他の操作| 0..∞| 
| list-farm-members	            | サーバー・ファームのメンバーをリストします| 0..∞| 
| remove-farm-member	        | サーバー・ファーム・メンバーを削除します| 0..∞| 

#### XML 形式
{: #xml-format }
ほとんどのコマンドの出力は XML であり、`<set-accessrule>` などの特定のコマンドの入力も XML です。これらの XML 形式の XML スキーマは、**product\_install\_dir/MobileFirstServer/mfpadm-schemas/** ディレクトリーにあります。サーバーから XML 応答を受け取るコマンドは、その応答が特定のスキーマに適合するか検証します。**xmlvalidation="none"** 属性を指定することで、この検証を無効にすることができます。 

#### 出力文字セット
{: #output-character-set }
mfpadm Ant タスクの通常の出力は、現行のロケールのエンコード・フォーマットでエンコードされます。Windows では、このエンコード・フォーマットは、いわゆる「ANSI コード・ページ」です。以下のような影響があります。

* この文字セット以外の文字は、出力時に疑問符 (?) に変換されます。
* 出力が Windows コマンド・プロンプト・ウィンドウ (cmd.exe) に送られた場合、そのようなウィンドウでは、いわゆる「OEM コード・ページ」で文字がエンコードされていると仮定しているため、非 ASCII 文字は正しく表示されません。

この制約を回避するには、以下の手順を実行してください。

* Windows 以外のオペレーティング・システムでは、エンコード・フォーマットが UTF-8 のロケールを使用します。これは、Red Hat Linux および macOS ではデフォルト・ロケールです。他の多くのオペレーティング・システムには、en_US.UTF-8 という名前のロケールがあります。
* それ以外の場合は、**output="some file name"** 属性を使用して、mfpadm コマンドの出力をファイルにリダイレクトします。

### 一般構成用のコマンド
{: #commands-for-general-configuration }
**mfpadm** Ant タスクを呼び出すときに、IBM {{ site.data.keys.mf_server }} またはランタイムのグローバル構成にアクセスするさまざまなコマンドを含めることができます。

#### `show-global-config` コマンド
{: #the-show-global-config-command }
`show-global-config` コマンドは、グローバル構成を表示します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output	     | 出力ファイルの名前。|	いいえ| 該当なし|
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし|

**例**  

```xml
<show-global-config/>
```

このコマンドは、[グローバル構成 (GET) (Global Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `show-user-config` コマンド
{: #the-show-user-config-command }
`<adapter>` エレメントおよび `<app-version>` エレメントの外にある `show-user-config` コマンドは、ランタイムのユーザー構成を表示します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	     | ランタイムの名前。| はい|	使用不可|
| format	     | 出力形式を指定します。json または xml のいずれか。| はい| 使用不可| 
| output	     | 出力を保存する先のファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力を保存する先の Ant プロパティーの名前。| いいえ| 該当なし|

**例**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

このコマンドは、[ランタイム構成 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `set-user-config` コマンド
{: #the-set-user-config-command }
`<adapter>` エレメントおよび `<app-version>` エレメントの外にある `set-user-config` コマンドは、ランタイムのユーザー構成を指定します。構成全体の設定用に、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| file	         | 新しい構成を含む JSON または XML ファイルの名前。| はい| 使用不可| 

`set-user-config` コマンドには、構成内の単一のプロパティーを設定するための以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	     | ランタイムの名前。| はい| 使用不可| 
| property	     | JSON プロパティーの名前。ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。| はい| 使用不可| 
| value	         | プロパティーの値。| はい| 使用不可|

**例**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

このコマンドは、[ランタイム構成 (PUT) (Runtime configuration (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST サービスに基づいています。

<br/>
#### `show-confidential-clients` コマンド
{: #the-show-confidential-clients-command }
`show-confidential-clients` コマンドは、ランタイムにアクセスできる機密クライアントの構成を表示します。機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。このコマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| format| 出力形式を指定します。json または xml のいずれか。| はい| 使用不可| 
| output| 出力を保存する先のファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力を保存する先の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

このコマンドは、[機密クライアント (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc) REST サービスに基づいています。

<br/>
#### `set-confidential-clients` コマンド
{: #the-set-confidential-clients-command }
`set-confidential-clients` コマンドは、ランタイムにアクセスできる機密クライアントの構成を指定します。機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。このコマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| file	         | 新しい構成を含む JSON または XML ファイルの名前。| はい| 使用不可| 

**例**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

このコマンドは、[機密クライアント (PUT) (Confidential Clients (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST サービスに基づいています。

<br/>
#### `set-confidential-clients-rule` コマンド
{: #the-set-confidential-clients-rule-command }
`set-confidential-clients-rule` コマンドは、ランタイムにアクセスできる機密クライアントの構成におけるルールを指定します。機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。このコマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| id| ルールの ID。| はい| 使用不可| 
| displayName| ルールの表示名。| はい| 使用不可| 
| secret| ルールのシークレット。| はい| 使用不可| 
| allowedScope| ルールの適用範囲。スペースで区切られたトークンのリスト。| はい| 使用不可| 

**例**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

このコマンドは、[機密クライアント (PUT) (Confidential Clients (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST サービスに基づいています。

### アダプター用のコマンド
{: #commands-for-adapters }
**mfpadm** Ant タスクを呼び出すときに、アダプター用のさまざまなコマンドを含めることができます。

#### `list-adapters` コマンド
{: #the-list-adapters-command }
`list-adapters` コマンドは、指定されたランタイムにデプロイされたアダプターのリストを返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| 	はい| 使用不可| 
| output	     | 出力ファイルの名前。| 	いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<list-adapters runtime="mfp"/>
```

このコマンドは、[Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST サービスに基づいています。

<br/>
#### `deploy-adapter` コマンド
{: #the-deploy-adapter-command }
`deploy-adapter` コマンドは、アダプターをランタイムにデプロイします。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	     | ランタイムの名前。| はい| 使用不可| 
| file           | バイナリー・アダプター・ファイル (.adapter)。| はい| 使用不可|

**例**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

このコマンドは、[Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST サービスに基づいています。

<br/>
#### `show-adapter` コマンド
{: #the-show-adapter-command }
`show-adapter` コマンドは、アダプターに関する詳細を表示します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name | アダプターの名前。| はい| 使用不可| 
| output| 出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

このコマンドは、[Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST サービスに基づいています。

<br/>
#### `delete-adapter` コマンド
{: #the-delete-adapter-command }
`delete-adapter` コマンドは、アダプターをランタイムから削除 (アンデプロイ) します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name    | アダプターの名前。| はい| 使用不可| 

**例**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

このコマンドは、[Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST サービスに基づいています。

<br/>
#### `adapter` コマンド・グループ
{: #the-adapter-command-group }
`adapter` コマンド・グループには以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name | アダプターの名前。| はい| 使用不可| 

`adapter` コマンドは以下のエレメントをサポートします。

| エレメント| 説明|	カウント| 
|------------------|-------------|-------------|
| get-binary	   | バイナリー・データを取得します。| 0..∞| 
| show-user-config| ユーザー構成を表示します。| 0..∞| 
| set-user-config| ユーザー構成を指定します。| 0..∞| 

<br/>
#### `get-binary` コマンド
{: #the-get-binary-command }
`<adapter>` エレメント内の `get-binary` コマンドは、バイナリー・アダプター・ファイルを返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| tofile	     | 出力ファイルの名前。| はい| 使用不可| 

**例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

このコマンドは、[Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST サービスに基づいています。

<br/>
#### `show-user-config` コマンド
{: #the-show-user-config-command-1 }
`<adapter>` エレメント内の `show-user-config` コマンドは、アダプターのユーザー構成を表示します。以下の属性があります。

| 属性| 説明|	必須| デフォルト  |
|----------------|-------------|-------------|---------|
| format	     | 出力形式を指定します。json または xml のいずれか。| はい| 使用不可| 
| output	     | 出力を保存する先のファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力を保存する先の Ant プロパティーの名前。| いいえ| 該当なし|

**例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

このコマンドは、[ アダプター構成 (GET) (Adapter Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `set-user-config` コマンド
{: #the-set-user-config-command-1 }
`<adapter>` エレメント内の `set-user-config` コマンドは、アダプターのユーザー構成を指定します。構成全体の設定用に、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| file | 新しい構成を含む JSON または XML ファイルの名前。| はい| 使用不可| 

このコマンドには、構成内の単一プロパティーを設定するための次の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| property| JSON プロパティーの名前。ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。| はい| 使用不可| 
| value| プロパティーの値。| はい| 使用不可| 

**例**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

このコマンドは、[アプリケーション構成 (PUT) (Application Configuration (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST サービスに基づいています。

### アプリケーション用のコマンド
{: #commands-for-apps }
**mfpadm** Ant タスクを呼び出すときに、アプリケーション用のさまざまなコマンドを含めることができます。

#### `list-apps` コマンド
{: #the-list-apps-command }
`list-apps` コマンドは、ランタイムにデプロイされたアプリケーションのリストを返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい	使用不可| 
| output| 出力ファイルの名前。| いいえ	該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<list-apps runtime="mfp"/>
```

このコマンドは、[Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST サービスに基づいています。

<br/>
#### `deploy-app` コマンド
{: #the-deploy-app-command }
`deploy-app` コマンドは、アプリケーション・バージョンをランタイムにデプロイします。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| file | アプリケーション記述子、JSON ファイル。| はい| 使用不可| 

**例**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

このコマンドは、[Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST サービスに基づいています。

<br/>
#### `show-app` コマンド
{: #the-show-app-command }
`show-app` コマンドは、ランタイムにデプロイされたアプリケーション・バージョンのリストを返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name | アプリケーションの名前。| はい| 使用不可| 
| output| 出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

このコマンドは、[Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST サービスに基づいています。

<br/>
#### `delete-app` コマンド
{: #the-delete-app-command }
`delete-app` コマンドは、デプロイされていたすべての環境について、アプリケーションとそのすべてのアプリケーション・バージョンをランタイムから削除 (アンデプロイ) します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name | アプリケーションの名前。| はい| 使用不可| 

**例**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

このコマンドは、[アプリケーション・バージョン (DELETE) (Application Version (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST サービスに基づいています。

<br/>
#### `show-app-version` コマンド
{: #the-show-app-version-command }
`show-app-version` コマンドは、ランタイムのアプリケーション・バージョンに関する詳細を表示します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	ランタイムの名前。| はい| 使用不可| 
| name	アプリケーションの名前。| はい| 使用不可| 
| environment	モバイル・プラットフォーム。| はい| 使用不可| 
| version	アプリケーションのバージョン番号。| はい| 使用不可| 

**例**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

このコマンドは、[アプリケーション・バージョン (GET) (Application Version (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST サービスに基づいています。

<br/>
#### `delete-app-version` コマンド
{: #the-delete-app-version-command }
`delete-app-version` コマンドは、アプリケーション・バージョンをランタイムから削除 (アンデプロイ) します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	ランタイムの名前。| はい| 使用不可| 
| name	アプリケーションの名前。| はい| 使用不可| 
| environment	モバイル・プラットフォーム。| はい| 使用不可| 
| version	アプリケーションのバージョン番号。| はい| 使用不可| 

**例**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

このコマンドは、[アプリケーション・バージョン (DELETE) (Application Version (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST サービスに基づいています。

<br/>
#### `app` コマンド・グループ
{: #the-app-command-group }
`app` コマンド・グループには以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime	ランタイムの名前。| はい| 使用不可| 
| name	アプリケーションの名前。| はい| 使用不可| 

app コマンド・グループは以下のエレメントをサポートしています。

| エレメント| 説明| カウント| 
|---------|-------------|-------|
| show-license-config| トークン・ライセンス構成を表示します。| 0..| 
| set-license-config| トークン・ライセンス構成を指定します。| 0..| 
| delete-license-config| トークン・ライセンス構成を削除します。| 0..| 

<br/>
#### `show-license-config` コマンド
{: #the-show-license-config-command }
`show-license-config` コマンドは、アプリケーションのトークン・ライセンス構成を表示します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output|	出力を保存する先のファイルの名前。| はい| 使用不可|
| outputproperty| 	出力を保存する先の Ant プロパティーの名前。| はい| 使用不可|

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

このコマンドは、[ アプリケーション・ライセンス構成 (GET) (Application license configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST サービスに基づいています。

<br/>
#### `set-license-config` コマンド
{: #the-set-license-config-command }
`set-license-config` コマンドは、アプリケーションのトークン・ライセンス構成を指定します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| appType| アプリケーションのタイプ: B2C または B2E| はい| 使用不可| 
| licenseType| アプリケーションのタイプ: APPLICATION または ADDITIONAL_BRAND_DEPLOYMENT または NON_PRODUCTION| はい| 使用不可| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

このコマンドは、[アプリケーション・ライセンス構成 (POST) (Application License Configuration (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST サービスに基づいています。

<br/>
#### `delete-license-config` コマンド
{: #the-delete-license-config-command }
`delete-license-config` コマンドは、アプリケーションのトークン・ライセンス構成をリセットします。つまり、構成を初期状態に戻します。

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

このコマンドは、[ライセンス構成 (DELETE) (License configuration (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST サービスに基づいています。

<br/>
#### `app-version` コマンド・グループ
{: #the-app-version-command-group }
`app-version` コマンド・グループには以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| name | アプリケーションの名前。| はい| 使用不可| 
| environment| モバイル・プラットフォーム。| はい| 使用不可| 
| version| アプリケーションのバージョン。| はい| 使用不可| 

`app-version` コマンド・グループは、以下のエレメントをサポートしています。

| エレメント| 説明| カウント| 
|---------|-------------|-------|
| get-descriptor| 記述子を取得します。| 0..| 
| get-web-resources| Web リソースを取得します。| 0..| 
| set-web-resources| Web リソースを指定します。| 0..| 
| get-authenticity-data| 認証データを取得します。| 0..| 
| set-authenticity-data| 認証データを指定します。| 0..| 
| delete-authenticity-data| 認証データを削除します。| 0..| 
| show-user-config| ユーザー構成を表示します。| 0..| 
| set-user-config| ユーザー構成を指定します。| 0..| 

<br/>
#### `get-descriptor` コマンド
{: #the-get-descriptor-command }
`<app-version>` エレメント内の `get-descriptor` コマンドは、アプリケーションのバージョンのアプリケーション記述子を返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output| 出力を保存する先のファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力を保存する先の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

このコマンドは、[アプリケーション記述子 (GET) (Application Descriptor (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST サービスに基づいています。

<br/>
#### `get-web-resources` コマンド
{: #the-get-web-resources-command }
`<app-version>` エレメント内の `get-web-resources` コマンドは、アプリケーションのバージョンの Web リソースを .zip ファイルとして返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| tofile| 	出力ファイルの名前。| はい|使用不可| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

このコマンドは、[Web リソースの取得 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST サービスに基づいています。

<br/>
#### `set-web-resources` コマンド
{: #the-set-web-resources-command }
`<app-version>` エレメント内の `set-web-resources` コマンドは、アプリケーションのバージョンの Web リソースを指定します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| file | 入力ファイルの名前 (.zip ファイルでなければなりません)。| はい|使用不可|

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

このコマンドは、[Web リソースのデプロイ (POST) (Deploy a web resource (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST サービスに基づいています。

<br/>
#### `get-authenticity-data` コマンド
{: #the-get-authenticity-data-command }
`<app-version>` エレメント内の `get-authenticity-data` コマンドは、アプリケーションのバージョンの認証データを返します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output| 	出力を保存する先のファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力を保存する先の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

このコマンドは、[ ランタイム・リソースのエクスポート (GET) (Export runtime resources (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST サービスに基づいています。

<br/>
#### `set-authenticity-data` コマンド
{: #the-set-authenticity-data-command }
`<app-version>` エレメント内の `set-authenticity-data` コマンドは、アプリケーションのバージョンの認証データを指定します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| file | 入力ファイルの名前。以下のいずれかです。<ul><li>authenticity_data ファイルまたは</li><li>認証データの抽出元である装置ファイル (.ipa、.apk、または .appx ファイル)</li></ul> |  はい| 使用不可| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

このコマンドは、[アプリケーション認証データのデプロイ (POST) (Deploy Application Authenticity Data (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST サービスに基づいています。

<br/>
#### `delete-authenticity-data` コマンド
{: #the-delete-authenticity-data-command }
`<app-version>` エレメント内の `delete-authenticity-data` コマンドは、アプリケーションのバージョンの認証データを削除します。属性はありません。

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

このコマンドは、[ アプリケーション認証性 (DELETE) (Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST サービスに基づいています。

<br/>
#### `show-user-config` コマンド
{: #the-show-user-config-command-2 }
`<app-version>` エレメント内の `show-user-config` コマンドは、アプリケーションのバージョンのユーザー構成を表示します。以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| format| 出力形式を指定します。json または xml のいずれか。| はい| 使用不可| 
| output| 出力ファイルの名前。いいえ	該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

このコマンドは、[アプリケーション構成 (GET) (Application Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `set-user-config` コマンド
{: #the-set-user-config-command-2 }
`<app-version>` エレメント内の `set-user-config` コマンドは、アプリケーションのバージョンのユーザー構成を指定します。構成全体の設定用に、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| file | 新しい構成を含む JSON または XML ファイルの名前。| はい| 使用不可| 

`set-user-config` コマンドには、構成内の単一のプロパティーを設定するための以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| property| JSON プロパティーの名前。ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。| はい| 使用不可| 
| value	| プロパティーの値。| はい| 使用不可| 

**例**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### デバイス用のコマンド
{: #commands-for-devices }
**mfpadm** Ant タスクを呼び出すときに、デバイス用のさまざまなコマンドを含めることができます。

#### `list-devices` コマンド
{: #the-list-devices-command }
`list-devices` コマンドは、ランタイムのアプリケーションと接触のあるデバイスのリストを返します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| query	 | 検索対象の分かりやすい名前またはユーザー ID。このパラメーターには、検索対象のストリングを指定します。このストリングが含まれる (大/小文字を区別しないマッチングによって)、 | 分かりやすい名前またはユーザー ID を持つすべてのデバイスが返されます。| いいえ| 該当なし| 
| output| 	出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 	出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

このコマンドは、[Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) REST サービスに基づいています。

<br/>
#### `remove-device` コマンド
{: #the-remove-device-command }
`remove-device` コマンドは、ランタイムのアプリケーションと接触のあるデバイスに関するレコードを消去します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| id| 固有のデバイス ID。| はい| 使用不可| 

**例**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

このコマンドは、[Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST サービスに基づいています。

<br/>
#### `device` コマンド・グループ
{: #the-device-command-group }
`device` コマンド・グループには以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| id| 固有のデバイス ID。| はい| 使用不可| 

`device` コマンドは以下のエレメントをサポートします。

| エレメント| 説明|       カウント|
|----------------|-------------|-------------|
| set-status| 状況を変更します。| 0..∞| 
| set-appstatus| アプリケーションの状況を変更します。| 0..∞| 

<br/>
#### `set-status` コマンド
{: #the-set-status-command }
`set-status` コマンドは、ランタイムの有効範囲でデバイスの状況を変更します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| status| 新しい状況。| はい| 使用不可| 

この状況の値は、以下のいずれかになります。

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**例**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

このコマンドは、[Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST サービスに基づいています。

<br/>
#### `set-appstatus` コマンド
{: #the-set-appstatus-command }
`set-appstatus` コマンドは、ランタイム内のアプリケーションに関して、デバイスの状況を変更します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| app	| アプリケーションの名前。| はい| 使用不可| 
| status| 	新しい状況。| はい| 使用不可| 

この状況の値は、以下のいずれかになります。

* ENABLED
* DISABLED

**例**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

このコマンドは、[Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST サービスに基づいています。

### トラブルシューティング用のコマンド
{: #commands-for-troubleshooting }
Ant タスク・コマンドを使用して、{{ site.data.keys.mf_server }} Web アプリケーションでの問題を調査することができます。

#### `show-info` コマンド
{: #the-show-info-command }
`show-info` コマンドは、ランタイムやデータベースにアクセスせずに返されることが可能な、{{ site.data.keys.product_adj }} 管理サービスに関する基本情報を表示します。このコマンドを使用して、{{ site.data.keys.product_adj }} 管理サービスが実行されているかどうかをテストします。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output| 	出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 	出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-info/>
```

<br/>
#### `show-versions` コマンド
{: #the-show-versions-command }
`show-versions` コマンドは、各種コンポーネントの {{ site.data.keys.product_adj }} バージョンを表示します。

* **mfpadmVersion**: **mfp-ant-deployer.jar** ファイルが取得される {{ site.data.keys.mf_server }} の正確なバージョン番号。
* **productVersion**: **mfp-admin-service.war** ファイルが取得される {{ site.data.keys.mf_server }} の正確なバージョン番号。
* **mfpAdminVersion**: **mfp-admin-service.war** のみの正確なビルド・バージョン番号。

コマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output| 	出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 	出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-versions/>
```

<br/>
#### `show-diagnostics` コマンド
{: #the-show-diagnostics-command }
`show-diagnostics` コマンドは、データベースや補助サービスの可用性など、{{ site.data.keys.product_adj }} 管理サービスの正しい運用に必要な各種コンポーネントの状況を表示します。このコマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| output| 	出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 	出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<show-diagnostics/>
```

<br/>
#### `unlock` コマンド
{: #the-unlock-command }
`unlock` コマンドは汎用ロックをリリースします。破棄する動作の一部は、同じ構成データの同時修正を防ぐために、このロックを取得します。まれに、そのような動作が中断されると、ロックはロック状態のままとなり、それ以上の破棄操作が不可能になります。このような状況でロックをリリースするには、unlock コマンドを使用してください。このコマンドには属性はありません。

**例**  

```xml
<unlock/>
```

<br/>
#### `list-runtimes` コマンド
{: #the-list-runtimes-command }
`list-runtimes` コマンドは、デプロイ済みのランタイムのリストを返します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| output| 出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

このコマンドは、[Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST サービスに基づいています。

<br/>
#### `show-runtime` コマンド
{: #the-show-runtime-command }
`show-runtime` コマンドは、指定されたデプロイ済みのランタイムに関する情報を表示します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| output| 出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**

```xml
<show-runtime runtime="mfp"/>
```

このコマンドは、[Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST サービスに基づいています。

<br/>
#### `delete-runtime` コマンド
{: #the-delete-runtime-command }
`delete-runtime` コマンドは、ランタイム (そのアプリケーションとアダプターを含む) をデータベースから削除します。ランタイムを削除できるのは、その Web アプリケーションが停止している場合のみです。コマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime|  ランタイムの名前。| はい| 使用不可|
| condition| 削除する条件。empty または always のいずれかです。**注意:** always オプションは危険です。| いいえ| 該当なし|

**例**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

このコマンドは、[Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST サービスに基づいています。

<br/>
#### `list-farm-members` コマンド
{: #the-list-farm-members-command }
`list-farm-members` コマンドは、所定のランタイムがデプロイされているファーム・メンバー・サーバーのリストを返します。これには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| output| 出力ファイルの名前。| いいえ| 該当なし| 
| outputproperty| 出力用の Ant プロパティーの名前。| いいえ| 該当なし| 

**例**

```xml
<list-farm-members runtime="mfp"/>
```

このコマンドは、[ファーム・トポロジー・メンバー (GET) (Farm topology members (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST サービスに基づきます。

<br/>
#### `remove-farm-member` コマンド
{: #the-remove-farm-member-command }
`remove-farm-member` コマンドは、所定のランタイムがデプロイされているファーム・メンバーのリストからサーバーを削除します。サーバーが使用不可になったとき、または切断されたときに、このコマンドを使用します。コマンドには、以下の属性があります。

| 属性| 説明|	必須| デフォルト |
|----------------|-------------|-------------|---------|
| runtime| ランタイムの名前。| はい| 使用不可| 
| serverId| サーバーの ID。| はい| 該当なし| 
| force| ファーム・メンバーが使用可能の場合、または接続されている場合でも、ファーム・メンバーの削除を強制します。| いいえ| false| 

**例**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

このコマンドは、[ファーム・トポロジー・メンバー (Farm topology members (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST サービスに基づきます。
