---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.mf_server }} は複数のコンポーネントで構成されています。 各コンポーネントの機能を理解するために、{{site.data.keys.mf_server }} アーキテクチャーの概要が提供されています。

{{site.data.keys.mf_server }} V7.1 以前と異なり、V8.0.0 のインストール・プロセスは、モバイル・アプリ操作の開発およびデプロイメントとは切り離されています。V8.0.0 では、サーバー・コンポーネントとデータベースをインストールして構成した後、ほとんどの操作で、アプリケーション・サーバーまたはデータベース構成にアクセスせずに、{{site.data.keys.mf_server }} を操作することができます。

{{site.data.keys.product_adj }} 成果物の管理操作およびデプロイメント操作は、{{site.data.keys.mf_console }}、または {{site.data.keys.mf_server }} 管理サービスの REST API を使用して実行されます。また、これらの操作は、mfpdev または mfpadm など、この API をラップするコマンド・ライン・ツールを使用しても実行できます。{{site.data.keys.mf_server }} の許可ユーザーは、モバイル・アプリケーションのサーバー・サイド構成を変更したり、サーバー・サイド・コード (アダプター) をアップロードまたは構成したり、Cordova モバイル・アプリの新規 Web リソースをアップロードしたり、アプリケーション管理操作を実行したりすることができます。

{{site.data.keys.mf_server }} は、ネットワーク・インフラストラクチャーまたはアプリケーション・サーバーのセキュリティー層に加え、追加のセキュリティー層を提供しています。セキュリティー・フィーチャーには、アプリケーションの認証性の制御、およびサーバー・サイド・リソースとアダプターへのアクセス制御が含まれます。これらのセキュリティー構成は、{{site.data.keys.mf_console }} および管理サービスの許可ユーザーも実行できます。{{site.data.keys.product_adj }} 管理者の許可を決定するには、『[{{site.data.keys.mf_server }} 管理用のユーザー認証の構成](../../../installation-configuration/production/server-configuration)』の説明に従ってそれらの管理者をセキュリティー・ロールにマップします。

事前構成済みで、データベースやアプリケーション・サーバーなどのソフトウェア前提条件が必要ない、{{site.data.keys.mf_server }} の簡素化バージョンが開発者用に使用可能です。[{{site.data.keys.product_adj }} 開発サーバーのセットアップ](../../../installation-configuration/development)を参照してください。

## {{site.data.keys.mf_server }} コンポーネント
{ #mobilefirst-server-components }
{{site.data.keys.mf_server }} コンポーネントのアーキテクチャーを以下に示します。

![{{site.data.keys.mf_server }} を構成するコンポーネント](server_components.jpg)

### {{site.data.keys.mf_server }} のコア・コンポーネント
{: #core-components-of-mobilefirst-server }
{{site.data.keys.mf_console }}、
{{site.data.keys.mf_server }} 管理サービス、{{site.data.keys.mf_server }} ライブ更新サービス、
{{site.data.keys.mf_server }} 成果物、および {{site.data.keys.product_adj }} ランタイムは、インストールする最小コンポーネント・セットです。 

* ランタイムは、モバイル・デバイスで稼働するモバイル・アプリに {{site.data.keys.product_adj }} サービスを提供します。
* 管理サービスは、構成機能と管理機能を提供します。この管理サービスは、{{site.data.keys.mf_console }}、ライブ更新サービスの REST API、または mfpadm や mfpdev などのコマンド・ライン・ツールを介して使用します。 
* ライブ更新サービスは構成データを管理し、管理サービスによって使用されます。

これらのコンポーネントにはデータベースが必要です。各コンポーネントのデータベース表名には交点はありません。そのため、これらのコンポーネントのすべての表を保管するために、同じデータベース、または同じスキーマさえも使用することができます。詳しくは、[データベースのセットアップ](../../../installation-configuration/production/server-configuration)を参照してください。

ランタイムの複数のインスタンスをインストールできます。この場合、各インスタンスはそれぞれ独自のデータベースを持っている必要があります。成果物コンポーネントは、{{site.data.keys.mf_console }} 用のリソースを提供します。データベースは不要です。

### {{site.data.keys.mf_server }} のオプション・コンポーネント
{: #optional-components-of-mobliefirst-server }
{{site.data.keys.mf_server }} プッシュ・サービスは、プッシュ通知機能を提供します。モバイル・アプリケーションのこれらの機能が {{site.data.keys.product_adj }} プッシュ機能を使用するには、このサービスがインストールされている必要があります。モバイル・アプリの側からすると、プッシュ・サービスの URL は、コンテキスト・ルートが `/imfpush` である点を除き、ランタイムの URL と同じです。

プッシュ・サービスを、ランタイムと異なるサーバーまたはクラスターにインストールすることを計画している場合は、HTTP サーバーの経路指定ルールを構成する必要があります。この構成により、プッシュ・サービスおよびランタイムへの要求が正しく経路指定されるようになります。 

プッシュ・サービスにはデータベースが必要です。プッシュ・サービスの表には、ランタイム、管理サービス、およびライブ更新サービスの表との交点はありません。したがって、同じデータベースまたはスキーマにインストールすることもできます。

{{site.data.keys.mf_analytics }} サービスおよび {{site.data.keys.mf_analytics_console }} は、モバイル・アプリの使用に関するモニターおよび分析の情報を提供します。モバイル・アプリは、Logger SDK を使用することにより、より多くの洞察を提供することができます。{{site.data.keys.mf_analytics }} サービスにはデータベースは必要ありません。データは、Elasticsearch を使用してディスク上にローカルに保管されます。データは、Analytics サービスのクラスターのメンバー間で複製できるシャードで構造化されます。

ネットワーク・フローおよびこれらのコンポーネントのトポロジー制約について詳しくは、『[トポロジーとネットワーク・フロー](../../../installation-configuration/production/server-configuration)』を参照してください。

### インストール・プロセス
{: #installation-process }
オンプレミスでの {{site.data.keys.mf_server }} のインストールは、以下の方法を使用して実行できます。

* サーバー構成ツール - グラフィカル・ウィザード
* コマンド・ライン・ツールを介した Ant タスク
* 手動インストール

オンプレミスでの {{site.data.keys.mf_server }} のインストールについて、以下に詳しい情報が提供されています。

* WebSphere Application Server Liberty プロファイルへの {{site.data.keys.mf_server }} ファームの[完全インストールのガイド](../../../installation-configuration/production/)。このガイドは、グラフィカル・モードまたはコマンド・ライン・モードのいずれかでインストールを試すためのシンプルなシナリオに基づいています。
* インストールの前提条件、データベースのセットアップ、サーバー・トポロジー、アプリケーション・サーバーへのコンポーネントのデプロイメント、およびサーバー構成に関する詳細が含まれた[詳細セクション](../../../installation-configuration/production/)。

