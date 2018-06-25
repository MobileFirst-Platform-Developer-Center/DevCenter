---
layout: tutorial
title: アプリケーションの開発
show_children: true
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 開発の概念および概要
{: #development-concepts-and-overview }
{{ site.data.keys.product_full }} ツール・セットを使用してアプリケーションを開発する際、さまざまなコンポーネントおよびエレメントを開発したり構成したりする必要があります。 アプリケーションの開発時に必要になるコンポーネントおよびエレメントについて理解すると、開発を円滑に進める上で役立ちます。

これらの概念に精通することに加え、JSONStore や WLResourceRequest など、ネイティブ、Cordova、および Web のアプリケーション用の {{ site.data.keys.product_adj }} 提供の API についても学習します。また、アプリケーションのデバッグ、ダイレクト・アップデートを使用した Web リソースの更新、ライブ・アップデートを使用した userbase のセグメント化の方法を学習し、{{ site.data.keys.mf_cli }} を使用したアプリケーション、アダプター、およびその他の成果物の処理方法も学習します。

これらのさまざまな {{ site.data.keys.product_adj }} コンポーネントについて詳細を学習するには、サイドバー・ナビゲーションから関連トピックにナビゲートすることも、このまま読み続けることもできます。

#### ジャンプ先
{: #jump-to }
* [アプリケーション](#applications)
* [{{ site.data.keys.mf_server }}](#mobilefirst-server)
* [アダプター](#adapters)
* [次に使用するクライアント・サイドのチュートリアル](#client-side-tutorials-to-follow)

### アプリケーション
{: #applications }
アプリケーションは、ターゲット {{ site.data.keys.mf_server }} 用にビルドされ、ターゲット・サーバー上にサーバー・サイドの構成があります。 アプリケーションは、構成する前に {{ site.data.keys.mf_server }} に登録する必要があります。

アプリケーションは次のエレメントで識別されます。

* アプリケーション ID
* バージョン番号
* ターゲット・デプロイメント・プラットフォーム

> **注:** バージョン番号は、Web アプリケーションには適用されません。 同じ Web アプリケーションについて複数のバージョンを持つことはできません。

これらの ID は、アプリケーションが正しくデプロイされ、アプリケーションに割り当てられたリソースのみを使用することを確実にするために、クライアント・サイドとサーバー・サイドの両方で使用されます。 {{ site.data.keys.product }} のさまざまな部分が、これらの ID のいろいろな組み合わせを異なる方法で使用します。

アプリケーション ID はターゲット・デプロイメント・プラットフォームにより異なります。

**Android**  
ID はアプリケーション・パッケージ名です。

**iOS**  
ID はアプリケーション・バンドル ID です。

**Windows**  
ID はアプリケーション・アセンブリー名です。

**Web**  
ID は開発者によって割り当てられる固有の ID です。

異なるターゲット・プラットフォームのアプリケーションがすべて同じアプリケーション ID を持つ場合、{{ site.data.keys.mf_server }} は、これらのすべてのアプリケーションを、異なるプラットフォーム・インスタンスを持つ同じアプリケーションであるとみなします。 例えば、次のアプリケーションは、*同じアプリケーション* の異なるプラットフォーム・インスタンスであるとみなされます。

* `com.mydomain.mfp` というバンドル ID を持つ iOS アプリケーション。
* `com.mydomain.mfp` というパッケージ名を持つ Android アプリケーション。
* `com.mydomain.mfp` というアセンブリー名を持つ Windows 10 Universal Windows Platform アプリケーション。
* `com.mydomain.mfp` という割り当てられた ID を持つ Web アプリケーション。

アプリケーションのターゲット・デプロイメント・プラットフォームは、アプリケーションがネイティブ・アプリケーションとして開発されたか Cordova アプリケーションとして開発されたかに依存しません。 例えば、次のアプリケーションは両方とも {{ site.data.keys.product }} の iOS アプリケーションとみなされます。

* Xcode およびネイティブ・コードを使用して開発する iOS アプリケーション
* Cordova クロスプラットフォーム開発テクノロジーを使用して開発する iOS アプリケーション

> **注:** Xcode 8 を使用する場合、iOS シミュレーターでの iOS アプリケーションの実行中は、**キーチェーン共有**機能が必須です。Xcode プロジェクトをビルドする前に、この機能を手動で有効にする必要があります。

### アプリケーション構成
{: #application-configuration }
上述のように、アプリケーションはクライアント・サイドとサーバー・サイドの両方で構成されます。  

ネイティブおよび Cordova iOS、Android、および Windows のアプリケーションの場合、クライアント構成はクライアント・プロパティー・ファイル (iOS の場合は **mfpclient.plist**、Android の場合は **mfpclient.properties**、Windows の場合は **mfpclient.resw**) に保管されます。 Web アプリケーションの場合、構成プロパティーは SDK [初期化メソッド ](../application-development/sdk/web)にパラメーターとして渡されます。

クライアント構成プロパティーには、アプリケーション ID、およびサーバーにアクセスするために必要な {{ site.data.keys.mf_server }} ランタイムの URL やセキュリティー・キーなどの情報が含まれます。  
アプリケーションのサーバー構成には、アプリケーション管理ステータス、ダイレクト・アップデート用の Web リソース、構成されたセキュリティー・スコープ、ログ構成などの情報が含まれます。

> {{ site.data.keys.product_adj }} クライアント SDK の追加方法は、[『{{ site.data.keys.product }} SDK の追加』チュートリアル](sdk)を参照してください。

クライアント構成は、アプリケーションをビルドする前に定義する必要があります。 クライアント・アプリケーションの構成プロパティーは、{{ site.data.keys.mf_server }} ランタイムでこのアプリケーションに対して定義されているプロパティーと一致している必要があります。 例えば、クライアント構成内のセキュリティー・キーは、サーバー上のキーと一致している必要があります。 Web 以外のアプリケーションの場合は、クライアント構成を {{ site.data.keys.mf_cli }} で変更することができます。

アプリケーションのサーバー構成は、アプリケーション ID、バージョン番号、ターゲット・プラットフォームの組み合わせに関係しています。 アプリケーションのサーバー・サイド構成を追加するには、事前にアプリケーションを {{ site.data.keys.mf_server }} ランタイムに登録する必要があります。 アプリケーションのサーバー・サイドは、通常は {{ site.data.keys.mf_console }} を使用して構成されます。 アプリケーションのサーバー・サイドは、以下の方法でも構成することができます。

* `mfpdev app pull` コマンドを使用して既存の JSON 構成ファイルをサーバーから取得して、ファイルを更新し、変更された構成を `mfpdev app push` コマンドを使用してアップロードします。
* **mfpadm** プログラムまたは Ant タスクを使用します。 mfpadm の使用については、『[コマンド・ラインを通じた {{ site.data.keys.product_adj }} アプリケーションの管理](../administering-apps/using-cli)』および『[Ant を通じた {{ site.data.keys.product_adj }} アプリケーションの管理](../administering-apps/using-ant)』を参照してください。
* {{ site.data.keys.product_adj }} 管理サービスの REST API を使用します。 REST API については、[『{{ site.data.keys.mf_server }} 管理サービス用の REST API』](../api/rest/admin-apis/)を参照してください。

また、これらの方式を使用して {{ site.data.keys.mf_server }} の構成を自動化することもできます。

> **留意点:** {{ site.data.keys.mf_server }} が稼働中でアプリケーションからトラフィックを受信中であっても、サーバー構成を変更することができます。 アプリケーションのサーバー構成を変更するためにサーバーを停止する必要はありません。

実動サーバーでは、アプリケーションのバージョンは通常、アプリケーション・ストアにパブリッシュされたアプリケーションのバージョンに相当します。 アプリケーションの認証性のための構成など、一部のサーバー構成エレメントは、ストアにパブリッシュされたアプリケーションに固有です。

## {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
モバイル・アプリケーションのサーバー・サイドは、{{ site.data.keys.mf_server }} です。 {{ site.data.keys.mf_server }} により、ユーザーはアプリケーション管理やアプリケーション・セキュリティーなどの機能にアクセスでき、またモバイル・アプリケーションはアダプターを介して他のバックエンド・システムにセキュアにアクセスできます。

{{ site.data.keys.mf_server }} は、多くの {{ site.data.keys.product }} 機能を提供するコア・コンポーネントです。機能の例を以下に示します。

* アプリケーション管理
* デバイスおよびユーザーの認証やアプリケーション認証性の検査などのアプリケーション・セキュリティー
* アダプターを介したバックエンド・サービスへのセキュア・アクセス
* ダイレクト・アップデートを使用した Cordova アプリケーションの Web リソースの更新
* プッシュ通知およびプッシュ・サブスクリプション
* アプリケーション分析

開発から、テスト、実動デプロイメント、保守に至るまでのアプリケーションのライフサイクル全体で、{{ site.data.keys.mf_server }} を使用する必要があります。  

> アプリケーションを開発する際に使用可能な事前構成済みのサーバーが用意されています。 アプリケーションの開発時に使用する {{ site.data.keys.mf_server }} については、[『{{ site.data.keys.product_adj }} 開発環境のセットアップ』](../installation-configuration/development)を参照してください。

{{ site.data.keys.mf_server }} は、以下のコンポーネントで構成されます。 これらのすべてのコンポーネントは、{{ site.data.keys.mf_server }}にも含まれています。 単純なケースでは、すべて同じアプリケーション・サーバー上で実行されますが、実動環境またはテスト環境では、コンポーネントは異なるアプリケーション・サーバーで実行される可能性があります。 これらの {{ site.data.keys.mf_server }} コンポーネントの可能なトポロジーについては、『[トポロジーおよびネットワーク・フロー (Topologies and network flows)](../installation-configuration/production/topologies)』を参照してください。

### {{ site.data.keys.product_adj }} および {{ site.data.keys.mf_server }} 管理サービス
{: #mobilefirst-and-the-mobilefirst-server-administration-service }
Operations Console は、{{ site.data.keys.mf_server }} 構成を表示および編集するために使用できる Web インターフェースです。 ここから {{ site.data.keys.mf_analytics_console }} にアクセスすることもできます。 開発サーバーにおける Operations Console のコンテキスト・ルートは、**/mfpconsole** です。

管理サービスは、アプリケーションを管理するためのメインエントリー・ポイントです。 {{ site.data.keys.mf_console }} を使用して Web ベースのインターフェースから管理サービスにアクセスできます。 また、**mfpadm** コマンド・ライン・ツールまたは管理サービス REST API を使用して管理サービスにアクセスすることもできます。

> 詳しくは、[{{ site.data.keys.mf_console }} フィーチャー](../product-overview/components/console)に関する説明を参照してください。

### {{ site.data.keys.product_adj }} runtime
{: #mobilefirst-runtime }
ランタイムは、{{ site.data.keys.product_adj }} クライアント・アプリケーションのメインエントリー・ポイントです。 ランタイムは、{{ site.data.keys.product }} OAuth 実装のデフォルトの許可サーバーでもあります。

高度でまれなケースですが、単一の {{ site.data.keys.mf_server }} でデバイス・ランタイムの複数のインスタンスを使用できます。 各インスタンスには、独自のコンテキスト・ルートがあります。 コンテキスト・ルートは、Operations Console でランタイムの名前を表示するために使用されます。 異なるサーバー・レベルの構成 (鍵ストアの秘密鍵など) が必要な場合、複数のインスタンスを使用します。

{{ site.data.keys.mf_server }} に含まれているデバイス・ランタイムのインスタンスが 1 つだけの場合、通常、ランタイムのコンテキスト・ルートを知る必要はありません。 例えば、{{ site.data.keys.mf_server }} にランタイムが 1 つだけ含まれている場合に `mfpdev app register` コマンドを使用してランタイムにアプリケーションを登録すると、そのアプリケーションはそのランタイムに自動的に登録されます。

### {{ site.data.keys.mf_server }} プッシュ・サービス
{: #mobilefirst-server-push-service }
プッシュ・サービスは、プッシュ通知やプッシュ・サブスクリプションなどのプッシュ関連操作のメインアクセス・ポイントです。 プッシュ・サービスに接続するために、クライアント・アプリケーションはランタイムの URL を使用しますが、コンテキスト・ルートを /mfppush に置き換えます。 {{ site.data.keys.mf_console }} またはプッシュ・サービス REST API を使用してプッシュ・サービスを構成および管理できます。

{{ site.data.keys.product_adj }} ランタイムとは異なるアプリケーション・サーバーでプッシュ・サービスを実行する場合、HTTP サーバーでプッシュ・サービス・トラフィックを正しいアプリケーション・サーバーに経路指定する必要があります。

### {{ site.data.keys.mf_analytics }} および {{ site.data.keys.mf_analytics_console }}
{: #mobilefirst-analytics-and-the-mobilefirst-analytics-console }
{{ site.data.keys.mf_analytics_full }} は、{{ site.data.keys.mf_console }} からアクセスできる拡張が容易な分析機能を提供するオプションのコンポーネントです。 この分析機能により、デバイス、アプリケーション、およびサーバーから収集されたログおよびイベント全体でパターン、問題、およびプラットフォーム使用統計を検索できます。

{{ site.data.keys.mf_console }} で、分析サービスへのデータの転送を有効または無効にするフィルターを定義できます。 また、送信される情報のタイプをフィルターに掛けることもできます。 クライアント・サイドでは、クライアント・サイド・ログ・キャプチャー API を使用して、イベントおよびデータを分析サーバーに送信できます。

目的のトポロジーに {{ site.data.keys.mf_server }} をインストールして構成した後には、以下の方法のいずれかを使用して、{{ site.data.keys.mf_server }} およびそのアプリケーションの追加構成をすべて行えます。

* {{ site.data.keys.mf_console }}
* {{ site.data.keys.mf_server }} 管理サービス REST API
* **mfpadm** コマンド・ライン・ツール

初期インストールおよび構成が終わると、{{ site.data.keys.product }} を構成する場合に、アプリケーション・サーバー・コンソールやインターフェースにアクセスする必要はありません。  
アプリケーションを実動にデプロイする場合、アプリケーションを以下の {{ site.data.keys.mf_server }} 実稼働環境にデプロイできます。

#### オンプレミス
{: #on-premises }
> オンプレミス環境での {{ site.data.keys.mf_server }} のインストールおよび構成については、[IBM {{ site.data.keys.mf_server }} のインストール](../installation-configuration/production/appserver)を参照してください。

#### クラウド
{: #on-the-cloud }
* [IBM Cloud 上での {{ site.data.keys.mf_server }} の使用](../bluemix)。
* [IBM PureApplication 上での {{ site.data.keys.mf_server }} の使用](../installation-configuration/production/pure-application)。

## アダプター
{: #adapters }
{{ site.data.keys.product }} のアダプターは、クライアント・アプリケーションとクラウド・サービスにバックエンド・システムをセキュアに接続します。  

アダプターは、JavaScript または Java で作成することができ、Maven プロジェクトとしてビルドおよびデプロイすることができます。  
アダプターは、{{ site.data.keys.mf_server }} の {{ site.data.keys.product_adj }} ランタイムにデプロイされます。

実動システムでは、アダプターは通常、アプリケーション・サーバーのクラスターで実行されます。 サーバーでセッション情報をローカルに保管せずに、アダプターを REST サービスとして実装し、アダプターがクラスター環境で正常に機能するようにします。

アダプターには、ユーザー定義のプロパティーを指定することができます。 これらのプロパティーは、アダプターを再デプロイせずにサーバー・サイドで構成することができます。 例えば、テストから実動に移行する際に、アダプターがリソースにアクセスするために使用する URL を変更できます。

アダプターを {{ site.data.keys.product_adj }} ランタイムにデプロイするには、mfpdev adapter deploy コマンドを使用して {{ site.data.keys.mf_console }} からデプロイするか、または Maven から直接デプロイすることができます。

> アダプターについて、および JavaScript アダプターおよび Java アダプターの開発方法についての詳細は、[アダプターのカテゴリー](../adapters)を参照してください。

## 次に使用するクライアント・サイドのチュートリアル
{: #client-side-tutorials-to-follow }
