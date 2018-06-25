---
layout: tutorial
title: インストールおよび構成
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} は、オンプレミスでインストールするか、クラウドにデプロイして、テストまたは実動で使用することができる開発ツールおよびサーバー・サイド・コンポーネントを提供します。 自分のインストール・シナリオに適したインストール・トピックを確認してください。

### 開発環境のセットアップ
{: #installing-a-development-environment }
モバイル・アプリケーションのクライアント・サイドまたはサーバー・サイドを開発する場合、[{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) または [{{ site.data.keys.mf_bm }} サービス](../bluemix/using-mobile-foundation)を使用して始めてください。

**{{ site.data.keys.mf_dev_kit }}** の使用
{: #using-the-dev-kit }

{{ site.data.keys.mf_dev_kit }} には、個人用ワークステーションでモバイル・アプリケーションを実行してデバッグするために必要なものがすべて含まれています。{{ site.data.keys.mf_dev_kit }} を使用してアプリケーションを開発するには、[MobileFirst 開発環境のセットアップ](development/mobilefirst)のチュートリアルに従ってください。

**{{ site.data.keys.mf_bm }}** の使用
{: #using-mf-bluemix }

{{ site.data.keys.mf_bm }} サービスは、{{ site.data.keys.mf_dev_kit }} と似た機能を提供しますが、このサービスは IBM Cloud で実行されます。

**{{ site.data.keys.product }} アプリケーションの開発環境のセットアップ**
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }} は、{{ site.data.keys.product }} アプリケーションの開発に使用できるプラットフォームとツールに関してすばらしい柔軟性を備えています。ただし、選択したツールが {{ site.data.keys.product }} と対話できるようにするには、いくつかの基本的なセットアップを行う必要があります。  

アプリケーションで使用する開発方法に対応する開発環境をセットアップするには、以下のリンクの中から選択してください。

* [Cordova 開発環境のセットアップ](development/cordova)
* [iOS 開発環境のセットアップ](development/ios)
* [Android 開発環境のセットアップ](development/android)
* [Windows 開発環境のセットアップ](development/windows)
* [Xamarin 開発環境のセットアップ](development/xamarin)
* [Web 開発環境のセットアップ](development/web)

### テスト・サーバーまたは実動サーバーのオンプレミス・セットアップ
{: #installing-a-test-or-production-server-on-premises }

{{ site.data.keys.product }} Server をインストールする際の最初の部分では、IBM Installation Manager という IBM 製品を使用します。{{ site.data.keys.product }} Server コンポーネントをインストールするには、その前に IBM Installation Manager v1.8.4 以降をインストールしておく必要があります。

> **重要:** 必ず IBM Installation Manager V1.8.4 以降を使用してください。 製品のポストインストール操作に Java 7 が必要なため、古いバージョンの Installation Manager は {{ site.data.keys.product }} {{ site.data.keys.product_version }} をインストールできません。古いバージョンの Installation Manager には Java 6 が装備されています。

{{ site.data.keys.mf_server }} のインストール・ウィザードでは、IBM Installation Manager を使用して、すべてのサーバー・コンポーネントをサーバーに配置します。{{ site.data.keys.product }} Server コンポーネントをアプリケーション・サーバーにデプロイするために必要なツールとライブラリーもインストールされます。ベスト・プラクティスとして、開発サーバーの場合を除き、すべてのコンポーネントを同じアプリケーション・サーバー・インスタンスにインストールしないでください。デプロイメント・ツールを使用すると、選択したコンポーネントをインストールできます。サーバーをインストールする前に考慮すべき点については、[トポロジーとネットワーク・フロー](production/topologies)を参照してください。

特定の環境での {{ site.data.keys.mf_server }} およびオプション・サービスの準備とインストールについては、以下をお読みください。単純なセットアップについては、[テスト環境または実稼働環境のセットアップ](production)のチュートリアルを参照してください。

* [前提条件の確認](production/#prerequisites)
* [{{ site.data.keys.mf_server }} コンポーネントの概要](production/topologies)
* MobileFirst Server コンポーネントおよびオプションで Application Center をデプロイするためにツールとライブラリーをロードする前に考慮すべき要因
  * トークン・ライセンス
  * MobileFirst Foundation Application Center
  * 管理者モード対ユーザー・モード
* ファイルのロード後の MobileFirst Server の配布構造
* 以下の方法によるファイルのロード
  * IBM Installation Manager インストール・ウィザードの使用
  * コマンド・ラインでの IBM Installation Manager の実行
  * XML 応答ファイルの使用 - サイレント・インストール
* [MobileFirst Foundation Server コンポーネントのバックエンド・データベースの構成](production/databases)
* [アプリケーション・サーバーへの MobileFirst Server のインストール](production/appserver)
* [MobileFirst Server の構成](production/server-configuration)
* [MobileFirst Analytics Server のインストール](production/analytics/installation)
* [Application Center のインストール](production/appcenter)
* [IBM PureApplication System への MobileFirst Server のデプロイ](production/pure-application)

### テスト環境または実稼働環境のセットアップ
{: #setting-up-test-or-production-server}

2 つのノードを持つ機能する {{ site.data.keys.mf_server }} クラスターを WebSphere Application Server Liberty プロファイル上に作成する手順を行うことで、{{ site.data.keys.mf_server }} のインストール・プロセスを説明します。このインストールは、グラフィック・ツール (GUI) を使用するかコマンド・ラインから実行できます。

* [IBM Installation Manager とサーバー構成ツールを使用した GUI モードでのインストール](production/tutorials/graphical-mode)。
* [コマンド・ライン・ツールを使用したコマンド・ラインでのインストール](production/tutorials/command-line)。

上記の 2 つの方法のいずれかを使用してインストールを実行したら、セットアップを完了するために、要件に応じてさらに[構成](production/server-configuration)が必要になることがあります。

### テスト環境または実稼働環境でのオプション・フィーチャーのセットアップ
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }} には、テスト環境または実稼働環境を拡張するために使用できるオプション・コンポーネントが含まれています。詳しくは、以下のチュートリアルを参照してください。

* [{{ site.data.keys.mf_analytics_server }} のインストールおよび構成](production/analytics/installation/)
* [{{ site.data.keys.mf_app_center }} のインストールおよび構成](production/appcenter)

### クラウドへの {{ site.data.keys.mf_server }} テスト環境または実稼働環境のデプロイ
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

{{ site.data.keys.mf_server }} をクラウドにデプロイする予定の場合は、次のオプションを参照してください。

* [IBM Cloud での {{ site.data.keys.mf_server }} の使用](../bluemix)。
* [IBM PureApplication での {{ site.data.keys.mf_server }} の使用](production/pure-application)。

### 以前のバージョンからのアップグレード
{: #upgrading-from-earlier-versions }
既存のインストール済み環境およびアプリケーションを新バージョンにアップグレードする方法については、[{{ site.data.keys.product_full }} {{ site.data.keys.product_version }} へのアップグレード](../all-tutorials/#upgrading_to_current_version)を参照してください。
