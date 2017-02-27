---
layout: tutorial
title: 実稼働環境用の MobileFirst Server のインストール
breadcrumb_title: 実稼働環境
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このセクションでは、特定の環境に合わせたインストールの計画および準備に役立つ詳細情報を提供します。  
{{ site.data.keys.mf_server }} の構成の構成について詳しくは、[{{ site.data.keys.mf_server }} の構成](server-configuration)を参照してください。

#### ジャンプ先
{: #jump-to }

* [前提条件](#prerequisites)
* [次のステップ](#whats-next)

## 前提条件
{: #prerequisites }
{{ site.data.keys.mf_server }} のインストールを円滑に進めるために、すべてのソフトウェア前提条件が満たされていることを確認してください。

**データベース管理システム (DBMS)**  
DBMS は、{{ site.data.keys.mf_server }} コンポーネントの技術データを保管するために必要です。サポートされている、次の DBMS のいずれかを使用する必要があります。

* IBM DB2 
* MySQL 
* Oracle 

製品でサポートされている DBMS のバージョンについて詳しくは、[システム要件](../../product-overview/requirements)を参照してください。リレーショナル DBMS (IBM DB2、Oracle、または MySQL) を使用している場合は、インストール・プロセス中にそのデータベース用の JDBC ドライバーが必要になります。JDBC ドライバーは、{{ site.data.keys.mf_server }} インストーラーによって提供されません。JDBC ドライバーを用意しておいてください。

* DB2 の場合、DB2 JDBC ドライバー V4.0 (db2jcc4.jar) を使用します。
* MySQL の場合、Connector/J JDBC ドライバーを使用します。
* Oracle の場合、Oracle Thin JDBC ドライバーを使用します。

**Java アプリケーション・サーバー**  
{{ site.data.keys.mf_server }} アプリケーションを実行するには Java アプリケーション・サーバーが必要です。以下のアプリケーション・サーバーのうち任意のものを使用できます。

* WebSphere Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

製品でサポートされているアプリケーション・サーバーのバージョンについて詳しくは、[システム要件](../../product-overview/requirements)を参照してください。アプリケーション・サーバーは Java 7 以降で稼働する必要があります。デフォルトで、WebSphere Application Server の一部のバージョンは Java 6 を使用して稼働します。このデフォルトを使用すると、それらのバージョンでは {{ site.data.keys.mf_server }} を実行できません。

**IBM Installation Manager V1.8.4 以降**  
Installation Manager は、{{ site.data.keys.mf_server }} のインストーラーを稼働するために使用されます。Installation Manager V1.8.4 以降をインストールする必要があります。製品のポストインストール操作に Java 7 が必要なため、古いバージョンの Installation Manager は {{ site.data.keys.product_full }} {{ site.data.keys.product_version }} をインストールできません。古いバージョンの Installation Manager には Java 6 が装備されています。

IBM Installation Manager V1.8.4 以降のインストーラーは、[Installation Manager and Packaging Utility download links](http://www.ibm.com/support/docview.wss?uid=swg27025142) からダウンロードします。

**{{ site.data.keys.mf_server }} の Installation Manager リポジトリー**  
このリポジトリーは、[IBM パスポート・アドバンテージ](http://www.ibm.com/software/passportadvantage/pao_customers.htm)の {{ site.data.keys.product }} eAssembly からダウンロードできます。このパックの名前は、**IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server** です。

[IBM サポート・ポータル](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)からダウンロード可能な最新のフィックスパックを適用することもできます。このフィックスパックは、Installation Manager のリポジトリー内に基本バージョンのリポジトリーがないとインストールできません。

{{ site.data.keys.product }} eAssembly には、以下のインストーラーが含まれています。

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Liberty の場合、IBM WebSphere Application Server Liberty Core が補足された IBM WebSphere SDK Java Technology Edition も使用できます。

## 次のステップ
{: #whats-next }

* [IBM Installation Manager の実行](installation-manager)
* [データベースのセットアップ](databases)
* [トポロジーとネットワーク・フロー](topologies)
* [アプリケーション・サーバーへの {{ site.data.keys.mf_server }} のインストール](appserver)
