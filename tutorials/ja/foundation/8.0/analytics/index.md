---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

適切で有効なユーザー・エンゲージメントを維持するためには、ユーザーに対するアプリケーションの振る舞いについての洞察を得る必要があります。 {{ site.data.keys.mf_analytics_full }} は、組み込みの可視化 (グラフとテーブル) でこの機能を提供します。 アプリケーションのインスツルメンテーションを最小限に抑えながらも、次の対処可能な洞察を Mobile Foundation Analytics コンソールですぐに視覚化することができます。

* **ユーザーのオンボードおよび保存のパターン:** オンボードする新規ユーザーがいますか。 既存のユーザーはアプリケーションを使い続けていますか。
* **使用パターン:** アプリケーションの利用が最も多い時間、最も少ない時間はいつですか。それはビジネスと関連性がありますか。
* **デバイスおよび OS の配布:** モバイル・デバイス・モデルとオペレーティング・システム間でのアプリの配布はどのようですか。
* **バックエンドのパフォーマンス:** 最も多く使用されているバックエンド・システムの機能は何ですか。その機能の応答時間と安定性はどうですか。バックエンドのバランスを調整する必要はありますか。
* **アプリケーションの安定性:** アプリケーションは常に安定していますか。異常終了した場合、その原因は何ですか (クラッシュ・ログ)。 アプリケーションの設計や実装を修正する必要はありますか。
* **トラブルシューティング・リード:** クラッシュに向かう前のアプリケーション・フロー・トレースおよび証跡は何ですか。
* **アプリ内のユーザー・エクスペリエンス:** ユーザーがアプリを使用するときの実際のインタラクティブ・エクスペリエンスはどのようなものですか。ユーザーはどう感じているでしょうか。ユーザー調査を再訪する必要はありますか。
* **カスタム証跡:** カスタム・チャートは、アプリケーション固有の証跡とフローの一部としてログに記録されるカスタム・データを中心に定義およびプロットされ、これにより、ビジネス上の意思決定にも役立つ独自の洞察を柔軟に拡張および定義できます。

{{ site.data.keys.mf_analytics_full }} は、アプリケーションからサーバーへのアクティビティー、クライアント・ログ、クライアントの異常終了、アプリ内ユーザー・フィードバック、および {{ site.data.keys.mf_server }} とクライアントのデバイスからのサーバー・サイドのログから、データを収集します。 その後、収集されたデータから、モバイルの状況およびサーバー・インフラストラクチャーを詳しく把握することができます。

{{ site.data.keys.mf_server }} には、ネットワーク・インフラストラクチャー・レポート機能が事前装備されています。 クライアントとサーバーの両方がネットワーク使用状況をレポートしている場合は、データを集約して、ローパフォーマンスの原因がネットワークにあるか、サーバーにあるか、またはバックエンド・システムにあるかを判断できます。 さらに、クライアント・サイドと {{ site.data.keys.mf_analytics_server }} の両方でフィルターを定義して、分析がどのロガー・データにアクセスして使用するかを制御できます。 レポートされるイベントの詳細度とデータ保存ポリシーを選択し、条件付きアラートを設定し、カスタム・グラフを作成し、新規データに取り組みます。

#### プラットフォームのサポート
{: #platform-support }

{{ site.data.keys.mf_analytics }} サポート:

* ネイティブ iOS クライアントおよび Android クライアント
* Cordova アプリケーション (iOS、Android)
* Web アプリケーション
* サポートは、Windows 8.1 Universal および Windows 10 UWP では**使用できません**

IBM {{ site.data.keys.mf_server }} には、ネットワーク・インフラストラクチャー・レポート機能が事前装備されています。 クライアントとサーバーの両方がネットワーク使用状況をレポートしている場合は、データを集約して、ローパフォーマンスの原因がネットワークにあるか、サーバーにあるか、またはバックエンド・システムにあるかを判断できます。

## クライアント開発
{: #client-development }

Logger クラスと Analytics クラスの 2 つのクライアント・クラスが、連携して生データをサーバーに送信します。

### Analytics API
{: #the-analytics-api }

Analytics クライアント API は、さまざまなイベントについてのデータを収集し、それらを {{ site.data.keys.mf_analytics_server }}に送信します。
> [『Analytics クライアント開発』](analytics-api)チュートリアルで詳細を参照してください。

### Logger API
{: #the-logger-api }

Logger は標準ロガーとして機能します。 クライアントから、任意のロギング・レベルで {{ site.data.keys.mf_analytics_server }}にロガー・データを送信することもできます。 ただし、サーバー構成によって、許可されるロギング要求のレベルが制御されます。 このしきい値より下の送信された要求は無視されます。

情報を収集する必要性と、限られたストレージ能力に合わせてデータ量を制限する必要性の 2 つのバランスを取るようにロギング・レベルを制御しなければなりません。

> [『クライアント・ロギング』](../application-development/client-side-log-collection/)チュートリアルで詳細を参照してください。

さらに、クライアント・サイドと {{ site.data.keys.mf_analytics_server }} の両方でフィルターを定義して、分析がどのロガー・データにアクセスして使用するかを制御できます。

## Analytics コンソールおよび Operations Console
{: #the-analytics-and-operations-consoles }

{{ site.data.keys.product_full }} は、Analytics コンソールと Operations Console を提供します。 {{ site.data.keys.mf_console_full }} は、Analytics サーバーとクライアント・アプリケーションとの連携方法を構成します。 {{ site.data.keys.mf_analytics_console_full }}は、さまざまな Analytics レポートを構成および表示します。

> [『オペレーション・コンソール』](console)チュートリアルで詳細を参照してください。

> Analytics コンソールでのカスタム・グラフの作成について詳しくは、 [『カスタム・グラフ』](console/custom-charts)チュートリアルを参照してください。

## Analytics サーバー
{: #the-analytics-server }

Analytics サーバーは、開発環境と実稼働環境の両方で使用できます。

開発の場合、Analytics サーバーは {{ site.data.keys.mf_dev_kit }}と一緒にインストールされます。  詳しくは、[『{{ site.data.keys.product_adj }} 開発環境のセットアップ』](../installation-configuration/development/mobilefirst/)を参照してください。 キットがインストールされると、開発ニーズに合わせた {{ site.data.keys.mf_analytics_console_short }} が使用可能になります。

実動の場合、使用可能なインフラストラクチャー、ビジネス・ニーズ、システム設計などに応じて、さまざまなインストールおよび構成のオプションが用意されています。詳細については、[『{{ site.data.keys.product_adj }} 開発環境のセットアップ 』](../installation-configuration/production/analytics/)を参照してください。

{{ site.data.keys.mf_analytics }} は Elasticsearch を使用します。 {{ site.data.keys.product }} で [Elasticsearch の使用方法を参照してください](elasticsearch)。

## トラブルシューティング
{: #troubleshotting }

{{ site.data.keys.mf_analytics }} のトラブルシューティングについては、[『Analytics のトラブルシューティング』](../troubleshooting/analytics/)を参照してください。

## 推奨資料
{: #what-to-read-next }
