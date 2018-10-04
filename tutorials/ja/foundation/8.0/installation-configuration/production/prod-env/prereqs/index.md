---
layout: tutorial
title: インストール前提条件
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
MobileFirst Server のインストールを円滑に進めるために、すべてのソフトウェア前提条件が満たされていることを確認してください。

MobileFirst Server をインストールする前に、以下のソフトウェアがインストールされている必要があります。

* **Database Management System (DBMS)**
  MobileFirst Server コンポーネントの技術データを保管するために、DBMS が必要です。サポートされている、次の DBMS のいずれかを使用する必要があります。

  * IBM DB2
  * MySQL
  * Oracle

  製品でサポートされている DBMS のバージョンについて詳しくは、[システム要件](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)を参照してください。リレーショナル DBMS (IBM DB2、Oracle、または MySQL) を使用している場合は、インストール・プロセス中にそのデータベース用の JDBC ドライバーが必要になります。JDBC ドライバーは、MobileFirst Server インストーラーによって提供されません。 JDBC ドライバーを用意しておいてください。

  * DB2 の場合、DB2 JDBC ドライバー V4.0 (db2jcc4.jar) を使用します。
  * MySQL の場合、Connector/J JDBC ドライバーを使用します。
  * Oracle の場合、Oracle Thin JDBC ドライバーを使用します。

* **Java™ アプリケーション・サーバー**
  MobileFirst Server アプリケーションを実行するには Java アプリケーション・サーバーが必要です。 以下のアプリケーション・サーバーのうち任意のものを使用できます。

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  製品でサポートされているアプリケーション・サーバーのバージョンについて詳しくは、[システム要件](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)を参照してください。アプリケーション・サーバーは Java 7 以降で稼働する必要があります。デフォルトで、WebSphere Application Server の一部のバージョンは Java 6 を使用して稼働します。このデフォルトを使用すると、それらのバージョンでは MobileFirst Server を実行できません。

* **IBM Installation Manager V1.8.4 以降**
  MobileFirst Server のインストーラーを実行するために Installation Manager が使用されます。Installation Manager V1.8.4 以降をインストールする必要があります。それより古いバージョンの Installation Manager では IBM MobileFirst Platform Foundation V8.0 をインストールできません。これは製品のポストインストール操作に Java 7 が必要なためです。古いバージョンの Installation Manager には Java 6 が付属しています。

  IBM Installation Manager V1.8.4 以降のインストーラーは、[Installation Manager and Packaging Utility download links](http://www-01.ibm.com/support/docview.wss?uid=swg27025142) からダウンロードします。

* **MobileFirst Server 用の Installation Manager リポジトリー**
  このリポジトリーは、[IBM パスポート・アドバンテージ](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm)の IBM MobileFirst Platform Foundation eAssembly からダウンロードできます。パックの名前は、IBM MobileFirst Platform Server 用の Installation Manager リポジトリーの `IBM MobileFirst Platform Foundation V8.0.zip` ファイルです。

  [IBM サポート・ポータル](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation)からダウンロード可能な最新のフィックスパックを適用することもできます。このフィックスパックは、Installation Manager のリポジトリー内に基本バージョンのリポジトリーがないとインストールできません。

IBM MobileFirst Platform Foundation eAssembly には、以下のインストーラーが含まれています。
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Liberty の場合、IBM WebSphere Application Server Liberty Core が補足された IBM WebSphere SDK Java Technology Edition も使用できます。

## 親トピック
{: #parent-topic }

* [実稼働環境での MobileFirst Server のインストール](../)
