---
layout: tutorial
title: インストールおよび構成
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_full }} は、オンプレミスでインストールするか、クラウドにデプロイして、テストまたは実動で使用することができる開発ツールおよびサーバー・サイド・コンポーネントを提供します。自分のインストール・シナリオに適したインストール・トピックを確認してください。

### 開発環境のインストール
{: #installing-a-development-environment }
モバイル・アプリのクライアント・サイドまたはサーバー・サイドを開発する場合、[{{site.data.keys.mf_dev_kit }}](development/mobilefirst/) または [{{site.data.keys.mf_bm }} サービス](../bluemix/using-mobile-foundation)を使用して始めてください。

* [MobileFirst 開発環境のセットアップ](development/mobilefirst/)
* [Cordova 開発環境のセットアップ](development/cordova)
* [iOS 開発環境のセットアップ](development/ios)
* [Android 開発環境のセットアップ](development/android)
* [Windows 開発環境のセットアップ](development/windows)
* [Xamarin 開発環境のセットアップ](development/xamarin)
* [Web 開発環境のセットアップ](development/web)

### テスト・サーバーまたは実動サーバーのオンプレミス・インストール
{: #installing-a-test-or-production-server-on-premises }
IBM インストールは、IBM Installation Manager と呼ばれる IBM 製品に基づきます。{{site.data.keys.product }} をインストールする前に、別に IBM Installation Manager V1.8.4 以降をインストールしてください。

> **重要:** 必ず IBM Installation Manager V1.8.4 以降を使用してください。製品のポストインストール操作に Java 7 が必要なため、古いバージョンの Installation Manager は {{site.data.keys.product }} {{site.data.keys.product_version }} をインストールできません。古いバージョンの Installation Manager には Java 6 が装備されています。{{site.data.keys.mf_server }} インストーラーは、{{site.data.keys.mf_server }} コンポーネント、およびオプションで {{site.data.keys.mf_app_center_full }} をアプリケーション・サーバーにデプロイするために必要なすべてのツールおよびライブラリーをユーザーのコンピューターにコピーします。

テスト・サーバーまたは実動サーバーをインストールする場合、次の **{{site.data.keys.mf_server }} のインストールについてのチュートリアル**を使用して開始すると、シンプルなインストールを実行して、{{site.data.keys.mf_server }} のインストールについて学習することができます。ご使用の特定の環境を対象としたインストールの準備について詳しくは、[実稼働環境用の {{site.data.keys.mf_server }} のインストール](production)を参照してください。

**{{site.data.keys.mf_server }} のインストールについてのチュートリアル**  
機能する {{site.data.keys.mf_server }} として、2 つのノードを持つクラスターを WebSphere Application Server Liberty プロファイル上に作成する手順をたどることで、{{site.data.keys.mf_server }} のインストール・プロセスを説明します。インストールは、以下の 2 つの方法で実行できます。

* [グラフィカル・モードの IBM Installation Manager およびサーバー構成ツールを使用する方法](production/tutorials/graphical-mode)。
* [コマンド・ライン・ツールを使用する方法](production/tutorials/command-line)。

これを行うと、{{site.data.keys.mf_server }} が動作します。ただし、サーバーを使用する前に、特にセキュリティーに関して、構成を行う必要があります。詳しくは、[{{site.data.keys.mf_server }} の構成](production/server-configuration)を参照してください。

**追加情報**  

* ご使用のインストール済み環境に {{site.data.keys.mf_analytics_server }} を追加するには、[{{site.data.keys.mf_analytics_server }} インストール・ガイド](production/analytics/installation/)を参照してください。  
* {{site.data.keys.mf_app_center }} をインストールするには、[Application Center のインストールおよび構成](production/appcenter)を参照してください。

### {{site.data.keys.mf_server }} のクラウドへのデプロイ
{: #deploying-mobilefirst-server-to-the-cloud }
{{site.data.keys.mf_server }} をクラウドにデプロイする予定の場合は、次のオプションを参照してください。

* [IBM Bluemix での {{site.data.keys.mf_server }} の使用](../bluemix)。
* [IBM PureApplication での {{site.data.keys.mf_server }} の使用](production/pure-application)。

### 以前のバージョンからのアップグレード
{: #upgrading-from-earlier-versions }
既存のインストール済み環境およびアプリケーションを新バージョンにアップグレードする方法については、[{{site.data.keys.product_full }} {{site.data.keys.product_version }} へのアップグレード](../all-tutorials/#upgrading_to_current_version)を参照してください。


