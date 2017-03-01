---
layout: tutorial
title: アプリケーションをアップロードまたは削除するためのコマンド・ライン・ツール
breadcrumb_title: アプリケーションのアップロードまたは削除
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
ビルド・プロセスを通じてアプリケーションを Application Center にデプロイするには、コマンド・ライン・ツールを使用します。 

Application Center コンソールの Web インターフェースを使用して、アプリケーションを Application Center にアップロードすることができます。 また、コマンド・ライン・ツールを使用して新しいアプリケーションをアップロードすることもできます。 

これは、Application Center へのアプリケーションのデプロイメントをビルド・プロセスに組み込みたいときに特に役立ちます。 このツールは **installDir/ApplicationCenter/tools/applicationcenterdeploytool.jar** にあります。

このツールは、拡張子が APK または IPA のアプリケーション・ファイルに対して使用できます。スタンドアロンで使用することもできれば、Ant タスクとして使用することもできます。 

このツールの使用をサポートするために必要なファイルはすべて tools ディレクトリーに入っています。

* **applicationcenterdeploytool.jar**: アップロード・ツール。 
* **json4j.jar**: アップロード・ツールで必要な JSON フォーマットのライブラリー。 
* **build.xml**: 1 つのファイルまたは一連のファイルを Application Center にアップロードする際に使用できるサンプル Ant スクリプト。 
* **acdeploytool.sh** および **acdeploytool.bat**: **applicationcenterdeploytool.jar** で java を呼び出すための簡単なスクリプト。 

#### ジャンプ先
{: #jump-to }
* [スタンドアロン・ツールを使用したアプリケーションのアップロード](#using-the-stand-alone-tool-to-upload-an-application)
* [スタンドアロン・ツールを使用したアプリケーションの削除](#using-the-stand-alone-tool-to-delete-an-application)
* [スタンドアロン・ツールを使用した LDAP キャッシュのクリア](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [アプリケーションをアップロードまたは削除するための Ant タスク](#ant-task-for-uploading-or-deleting-an-application)

### スタンドアロン・ツールを使用したアプリケーションのアップロード
{: #using-the-stand-alone-tool-to-upload-an-application }
アプリケーションをアップロードするには、コマンド・ラインからスタンドアロン・ツールを呼び出します。   
以下のステップに従ってスタンドアロン・ツールを使用してください。

1. **applicationcenterdeploytool.jar** および **json4j.jar** を java classpath 環境変数に追加します。
2. コマンド・ラインからアップロード・ツールを呼び出します。
  
   ```bash
   java com.ibm.appcenter.Upload [options] [files]
   ```
    
コマンド・ラインにある使用可能なオプションならどれでも渡すことができます。

| オプション | 内容 | 説明 | 
|--------|----------------------|-------------|
| -s | serverpath | Application Center サーバーへのパス。 | 
| -c | context | Application Center Web アプリケーションのコンテキスト。 | 
| -u | user | Application Center にアクセスするためのユーザー資格情報。 | 
| -p | password | ユーザーのパスワード。 | 
| -d | description | アップロードするアプリケーションの説明。 | 
| -l | label | フォールバック・ラベル。 通常、ラベルは、アップロードされるファイルに保管されたアプリケーション記述子から取得されます。 アプリケーション記述子にラベルが含まれていない場合は、フォールバック・ラベルが使用されます。  | 
| -isActive | true または false | アプリケーションは、アクティブまたは非アクティブ・アプリケーションとして Application Center に保管されます。  | 
| -isInstaller | true または false | アプリケーションは、「installer」フラグが適切に設定された Application Center に保管されます。  | 
| -isReadyForProduction | true または false | アプリケーションは、「ready-for-production」フラグが適切に設定された Application Center に保管されます。  | 
| -isRecommended | true または false | アプリケーションは、「recommended」フラグが適切に設定された Application Center に保管されます。  | 
| -e	  |  | 失敗時にフル例外スタック・トレースを表示します。 | 
| -f	  |  | 既に存在する場合でもアプリケーションのアップロードを強制します。  | 
| -y	  |  | SSL セキュリティー検査を使用不可にします。SSL 証明書の検査なしで、機密保護機能のあるホストでの公開が許可されます。  |  このフラグの使用はセキュリティー・リスクですが、一時自己署名 SSL 証明書による localhost のテストには適している場合があります。  | 

files パラメーターには、タイプが Android アプリケーション・パッケージ (.apk) のファイルまたは iOS アプリケーション (.ipa) のファイルを指定することができます。  
この例では、ユーザー demo はパスワード demopassword を持っています。次のコマンド・ラインを使用してください。 

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### スタンドアロン・ツールを使用したアプリケーションの削除
{: #using-the-stand-alone-tool-to-delete-an-application }
Application Center からアプリケーションを削除するには、コマンド・ラインからスタンドアロン・ツールを呼び出します。   
以下のステップに従ってスタンドアロン・ツールを使用してください。

1. **applicationcenterdeploytool.jar** および **json4j.jar** を java classpath 環境変数に追加します。
2. コマンド・ラインからアップロード・ツールを呼び出します。

   ```bash
   java com.ibm.appcenter.Upload -delete [options] [files or applications]
   ```
    
コマンド・ラインにある使用可能なオプションならどれでも渡すことができます。 

| オプション | 内容	| 説明 | 
|--------|----------------------|-------------|
| -s |serverpath | Application Center サーバーへのパス。 | 
| -c | context | Application Center Web アプリケーションのコンテキスト。 | 
| -u | user | Application Center にアクセスするためのユーザー資格情報。 | 
| -p | password | ユーザーのパスワード。 | 
| -y | | SSL セキュリティー検査を使用不可にします。SSL 証明書の検査なしで、機密保護機能のあるホストでの公開が許可されます。 このフラグの使用はセキュリティー・リスクですが、一時自己署名 SSL 証明書による localhost のテストには適している場合があります。  | 

ファイルまたはアプリケーション・パッケージ、オペレーティング・システム、およびバージョンを指定することができます。 ファイルが指定された場合は、パッケージ、オペレーティング・システム、およびバージョンはファイルから決定され、対応するアプリケーションが Application Center から削除されます。 アプリケーションが指定された場合は、アプリケーションは次のいずれかの形式を持たなければなりません。 

* `package@os@version`: ここで指定されたバージョンは Application Center から削除されます。 バージョン部分は、アプリケーションの「商用バージョン」ではなく、「内部バージョン」を指定しなければなりません。 
* `package@os`: このアプリケーションのすべてのバージョンが Application Center から削除されます。 
* `package`: このアプリケーションのすべてのオペレーティング・システムのすべてのバージョンが Application Center から削除されます。 

#### 例
{: #example-delete }
この例では、ユーザー demo はパスワード demopassword を持っています。このコマンド・ラインを使用して、iOS アプリケーション demo.HelloWorld を内部バージョン 3.0 と一緒に削除します。

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### スタンドアロン・ツールを使用した LDAP キャッシュのクリア
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
スタンドアロン・ツールを使用して、LDAP キャッシュをクリアしたり、LDAP ユーザーおよびグループに対する変更が Application Center にただちに表示されるようにしたりします。 

Application Center が LDAP で構成されると、LDAP サーバー上のユーザーとグループに対する変更は少し遅れて Application Center に表示されます。 Application Center は LDAP データのキャッシュを保守管理し、変更はキャッシュの有効期限が切れた後初めて可視になります。 デフォルトでは、遅延は 24 時間です。ユーザーまたはグループに対する変更の後でこの遅延が満了するのを待ちたくない場合は、コマンド・ラインからスタンドアロン・ツールを呼び出して LDAP データのキャッシュをクリアすることができます。 スタンドアロン・ツールを使用してキャッシュをクリアすると、変更はただちに可視になります。 

以下のステップに従ってスタンドアロン・ツールを使用してください。

1. applicationcenterdeploytool.jar および json4j.jar を java classpath 環境変数に追加します。
2. コマンド・ラインからアップロード・ツールを呼び出します。

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [options]
   ```
   
コマンド・ラインにある使用可能なオプションならどれでも渡すことができます。 

| オプション | 内容 | 説明 | 
|--------|----------------------|-------------|
| -s | serverpath | Application Center サーバーへのパス。| 
| -c | context | Application Center Web アプリケーションのコンテキスト。| 
| -u | user | Application Center にアクセスするためのユーザー資格情報。| 
| -p | password | ユーザーのパスワード。| 
| -y | | SSL セキュリティー検査を使用不可にします。SSL 証明書の検査なしで、機密保護機能のあるホストでの公開が許可されます。 このフラグの使用はセキュリティー・リスクですが、一時自己署名 SSL 証明書による localhost のテストには適している場合があります。 | 

#### 例
{: #example-cache }
この例では、ユーザー demo はパスワード demopassword を持っています。

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### アプリケーションをアップロードまたは削除するための Ant タスク
{: ant-task-for-uploading-or-deleting-an-application }
アップロード・ツールおよび削除ツールを Ant タスクとして使用し、その Ant タスクを独自の Ant スクリプトの中で使用することができます。   
これらのタスクを実行するには Apache Ant が必要です。 サポートされる Apache Ant の最小バージョンは、[システム要件](../../product-overview/requirements)にリストされています。

利便性を考慮して、{{ site.data.keys.mf_server }} には Apache Ant 1.8.4 が組み込まれています。product_install_dir/shortcuts/ ディレクトリーで、以下のスクリプトが提供されます。

* ant (UNIX / Linux の場合)
* ant.bat (Windows の場合)

これらのスクリプトはいつでも実行できる状態にあります。つまり、特定の環境変数を必要としないということです。 環境変数 JAVA_HOME が設定された場合、スクリプトはこれを受け入れます。

アップロード・ツールを Ant タスクとして使用した場合、upload Ant タスクの classname 値は **com.ibm.appcenter.ant.UploadApps** です。delete Ant タスクの classname 値は **com.ibm.appcenter.ant.DeleteApps** です。

| Ant タスクのパラメーター | 説明 | 
|------------------------|-------------|
| serverPath | Application Center に接続するため。デフォルト値は http://localhost:9080 です。 | 
| context | Application Center のコンテキスト。デフォルト値は /applicationcenter です。 | 
| loginUser | アプリケーションをアップロードする権限があるユーザー名。 | 
| loginPass | アプリケーションをアップロードする権限があるユーザーのパスワード。 | 
| forceOverwrite | このパラメーターが true に設定されると、Ant タスクは、既に存在するアプリケーションをアップロードするとき、Application Center 内のアプリケーションを上書きしようと試みます。このパラメーターは upload Ant タスクでのみ使用可能です。
| file | Application Center にアップロードする、または Application Center から削除する .apk ファイルまたは .ipa ファイル。このパラメーターにはデフォルト値がありません。  | 
| fileset | 複数のファイルをアップロードまたは削除するため。 | 
| application | アプリケーションのパッケージ名。このパラメーターは delete Ant タスクでのみ使用可能です。 | 
| os | アプリケーションのオペレーティング・システム。(例えば、Android または iOS。) このパラメーターは delete Ant タスクでのみ使用可能です。 | 
| version | アプリケーションの内部バージョン。このパラメーターは delete Ant タスクでのみ使用可能です。ここで商用バージョンを使用しないでください。商用バージョンはバージョンを正確に識別するのには適さないからです。  | 

#### 例
{: #example-ant }
**ApplicationCenter/tools/build.xml** ディレクトリーに拡張された例があります。  
次の例は、Ant タスクを独自の Ant スクリプトの中で使用する方法を示しています。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Server Properties -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" /> 
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!--  Authentication Properties -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps"> 
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

このサンプル Ant スクリプトは **tools** ディレクトリーにあります。 これを使用して、アプリケーションを 1 つだけ Application Center にアップロードすることができます。

```bash
ant upload.App -Dupload.file=sample.ipa
```

また、これを使用して、特定のディレクトリー階層にあるすべてのアプリケーションをアップロードすることもできます。

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### サンプル Ant スクリプトのプロパティー
{: #properties-of-the-sample-ant-script }

| プロパティー | コメント | 
|----------|---------|
| install.dir | デフォルトの ../../ になります。 | 
| server.path | デフォルト値は http://localhost:9080 です。 | 
| context.path | デフォルト値は applicationcenter です。 | 
| upload.file | このプロパティーにはデフォルト値がありません。 正確なファイル・パスを含む必要があります。  | 
| workspace.root | デフォルトの ../../ になります。 | 
| login.user | デフォルト値は appcenteradmin です。 | 
| login.pass | デフォルト値は admin です。 | 
| force	デフォルト値は true です。 | 

Ant の呼び出し時にこれらのパラメーターをコマンド・ラインで指定するには、プロパティー名の前に -D を追加してください。例えば、次のとおりです。 

```xml
-Dserver.path=http://localhost:8888/
```
