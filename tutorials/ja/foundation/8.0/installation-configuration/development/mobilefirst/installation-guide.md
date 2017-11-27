---
layout: tutorial
title: ワークステーション・インストール・ガイド
breadcrumb_title: インストール・ガイド
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product }} を使用した開発のためにワークステーションをセットアップするには、以下のインストール・ガイドに従ってください。

## DevKit インストーラー
{: #devkit-installer }
[{{ site.data.keys.mf_dev_kit }} インストーラー]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst)は、すぐに使用できる {{ site.data.keys.mf_server }}、データベース、およびランタイムを開発者マシンにインストールします。  

**前提条件:**  
このインストーラーでは、Java がインストールされていることが必要です。

1. [Oracle の JRE をインストールします](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html)。

2. JRE を指す `JAVA_HOME` 変数を追加します。

    *Mac および Linux:* **~/.bash_profile** を次のように編集します。

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows:*  
    [このガイドに従ってください](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html)。

### インストール
{: #installation }
DevKit インストーラーを[ダウンロード・ページ]({{site.baseurl}}/downloads/)から入手し、画面の指示に従います。

![devkit インストーラー](devkit-installer.png)

### サーバーの始動および停止
{: #starting-and-stopping-the-server }
コマンド・ライン・ウィンドウを開き、解凍したフォルダーの場所にナビゲートします。

*Mac および Linux:*  

* サーバーを始動するには、以下のようにします。`./run.sh -bg`
* サーバーを停止するには、以下のようにします。`./stop.sh`

*Windows:*  

* サーバーを始動するには、以下のようにします。`./run.cmd -bg`
* サーバーを停止するには、以下のようにします。`./stop.cmd`

### {{ site.data.keys.mf_console }} へのアクセス
{: #accessing-the-mobilefirst-operations-console }
[{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) には、以下の方法でアクセスできます。

* コマンド・ラインから、以下を実行します。`mfpdev server console`
* ブラウザーから、以下にアクセスします。[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![コンソール]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
[{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) は、{{ site.data.keys.mf_server }} でのアプリケーションの登録、{{ site.data.keys.mf_server }} に対するアプリケーションのプル/プッシュ、Java アダプターおよび JavaScript アダプターの作成、複数のローカル・サーバーおよびリモート・サーバーの管理、ダイレクト・アップデートを使用したライブ・アプリケーションの更新などを可能にするコマンド・ライン・インターフェースです。

**前提条件:**  
1. NodeJS は、{{ site.data.keys.mf_cli }} をインストールするための要件です。  
 [NodeJS v4.4.3 LTS](https://nodejs.org/en/) をダウンロードしてインストールします。

 インストールを検証するには、コマンド・ライン・ウィンドウを開いて以下を実行します。`node -v`

2. アダプターの作成、ビルド、デプロイなど、一部の CLI コマンドには Maven が必要です。インストール手順については、次のセクションを参照してください。

### {{ site.data.keys.mf_cli }} のインストール
{: #installation-cli }
ターミナルを開き、以下を実行します。`npm install -g mfpdev-cli`  

*Mac および Linux:* `sudo` を使用してコマンドを実行する必要がある場合があります。  
[NPM アクセス権の修正](https://docs.npmjs.com/getting-started/fixing-npm-permissions)に関する詳細をお読みください。

インストールを検証するには、コマンド・ライン・ウィンドウを開いて以下を実行します。`mfpdev -v` または `mfpdev help`

![コンソール](mfpdev-cli.png)

## アダプターおよびセキュリティー検査
{: #adapters-and-security-checks }
[アダプター]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters)および[セキュリティー検査]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security)は、認証やその他のセキュリティー層をアプリケーションに導入するための入り口となります。

**前提条件:**  
アダプターおよびセキュリティー検査を作成するには、その前に Apache Maven をセットアップする必要があります。  

1. [Apache Maven .zip をダウンロードします](https://maven.apache.org/download.cgi)。
2. Maven フォルダーを指す `MVN_PATH` 変数を追加します。

    *Mac および Linux:* **~/.bash_profile** を次のように編集します。

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows:*  
    [このガイドに従ってください](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/)。
以下を実行してインストールを検証します。`mvn -v`

### 使用法
{: #usage }
Apache Maven がインストールされたら、Maven コマンド・ライン・コマンド経由で、または {{ site.data.keys.mf_cli }} を使用して、アダプターを作成できます。  
詳しくは、[アダプターのチュートリアル]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters)を参照してください。
