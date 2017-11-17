---
layout: tutorial
title: 以前のリリースからのマイグレーション
weight: 12
---
## 概説
{: #overview }
{{ site.data.keys.product_full }} v8.0 では、アプリケーション開発とデプロイメントの新概念、およびいくつかの API の変更が導入されています。MobileFirst アプリケーションのマイグレーションについて準備し計画を立てるために、これらの変更について学びます。

> [マイグレーションの手引きを検討](migration-cookbook)して、手早くマイグレーション・プロセスを開始します。

#### ジャンプ先
{: #jump-to }
* [{{ site.data.keys.product_full }} 8.0 にマイグレーションする理由](#why-migrate-to-ibm-mobilefirst-foundation-80)
* [開発およびデプロイメント・プロセスの変更](#changes-in-the-development-and-deployment-process)
* [Cordova アプリケーションまたはハイブリッド・アプリケーションのマイグレーション](#migrating-a-cordova-or-hybrid-application)
* [ネイティブ・アプリケーションのマイグレーション](#migrating-a-native-application)
* [アダプターおよびセキュリティーのマイグレーション](#migrating-adapters-and-security)
* [プッシュ通知サポートのマイグレーション](#migrating-push-notifications-support)
* [サーバー・データベースおよびサーバー構造の変更](#changes-in-the-server-databases-and-in-the-server-structure)
* [Cloudant でのモバイル・データの保管](#storing-mobile-data-in-cloudant)
* [フィックスパックの {{ site.data.keys.mf_server }}](#applying-a-fix-pack-to-mobilefirst-server) への適用

## IBM MobileFirst Foundation 8.0 にマイグレーションする理由
{: #why-migrate-to-ibm-mobilefirst-foundation-80}

### アプリケーションのビルドに必要な作業、スキル、および時間の削減
* Java アダプターのビルドを自動化するための標準のパッケージ・マネージャー (npm、CocoaPods、Gradle、NuGet) および Maven を使用した、アプリケーションをより高速、簡単、およびスマートにビルド
* 簡単に接続できる、新規のより単純なモジュラー式の MobileFirst SDK
* ユーザーの次に最適なアクションを予測したり、アプリケーションの登録、構成、およびデプロイ全体を通じてガイド付きヘルプを提供したりするなど、全体的に改善された新しいユーザー・エクスペリエンス

### 拡張された自動化と、新しい開発および IT セルフサービス
* アプリケーションの構成可能情報 (プッシュ通知、認証、アダプター、アプリケーションの動作、およびワークフロー) を外部化して動的に変更する、新しいライブ・アップデート機能
* アプリケーションを登録、デプロイ、および管理するために、完全に再考されて徹底的に簡素化されたコンソールのユーザー・エクスペリエンス
* 開発と IT の相互依存の必要性をなくした、新しいより単純なアプリケーション・アーキテクチャー
* 新しい異常終了分析、構成可能なアラート、および根本原因分析を備えた、改善された問題判別
* 改善されたプッシュ通知サービスにより、ターゲットとしたサブスクリプション・ベースの通知を Web コンソールから送信可能

### さらに多くのハイブリッド・クラウド・デプロイメント・オプション
* Bluemix Public における MobileFirst Foundation の開発環境、テスト環境、および完全にスケーラブルな実稼働環境のワンクリックのプロビジョン
* デプロイメント・パイプラインをビルドするために IBM DevOps Services および Urban Code と統合済み

### マルチチャネルの API 作成および管理
* 最大限の保護のために、モバイル固有のセキュリティー拡張機能 (例えば、Step Up や Multifactor) を使用して API Connect マルチチャネル・セキュリティーをステップアップし、IBM DataPower を使用して DMZ で実施
* Foundation v8 で API Connect 互換の Swagger REST API を作成して定義し、次に API Connect で管理してセキュリティー保護

## 開発およびデプロイメント・プロセスの変更
{: #changes-in-the-development-and-deployment-process }
> {{ site.data.keys.product }} V8.0.0 を使用した開発プロセスのクイック・ハンズオン体験については、[クイック・スタート・チュートリアル](../quick-start)を検討することができます。

製品のこのバージョンでは、アプリケーションをアップロードする前に、{{ site.data.keys.mf_server }} を実行しているアプリケーション・サーバーにインストールする必要があるプロジェクト WAR ファイルの作成は行わなくなりました。代わりに、{{ site.data.keys.mf_server }} は 1 回インストールされ、ユーザーはアプリケーション、リソース・セキュリティー、またはプッシュ・サービスのサーバー・サイド**構成**をサーバーにアップロードします。{{ site.data.keys.mf_console }} を使用してアプリケーションの構成を変更できます。また、コマンド・ライン・ツールまたはサーバー REST API を使用してアプリケーションの新規**構成ファイル**をアップロードすることもできます。

MobileFirst プロジェクトは、存在しなくなりました。代わりに、任意の開発環境でモバイル・アプリケーションを開発します。アプリケーションのサーバー・サイドは、Java™ または JavaScript で別個に開発します。アダプターの開発は、Apache Maven を使用するか、Eclipse および IntelliJ などの Maven 対応 IDE を使用して行うことができます。

以前のバージョンでは、アプリケーションは、.wlapp ファイルをアップロードすることによってサーバーにデプロイされました。このファイルには、アプリケーションを記述したデータと、ハイブリッド・アプリケーションの場合は Web リソースを記述したデータも含まれていました。v8.0 では、.wlapp ファイルは、アプリケーションをサーバーに登録するためのアプリケーション記述子 JSON ファイルに置き換えられました。ダイレクト・アップデートを使用する Cordova アプリケーションでは、新しいバージョンの .wlapp をアップロードする代わりに、Web リソース・アーカイブをサーバーにアップロードするようになりました。

アプリケーションの開発時には、ターゲット・サーバーへのアプリケーションの登録やサーバー・サイド構成のアップロードなどの多くのタスクに {{ site.data.keys.mf_cli }} を使用します。

### 使用が中止されたフィーチャーと置換パス
{: #discontinued-features-and-replacement-path}
{{ site.data.keys.product }} V8.0.0 は、以前のバージョンと比較して徹底的に簡素化されています。この簡素化の結果、V7.1 で使用可能だったフィーチャーの一部は V8.0 で使用が中止されています。

> 使用が中止されたフィーチャーおよび置換パスについて詳しくは、[V8.0 で廃止された機能および V8.0 に含まれない機能](../product-overview/release-notes/deprecated-discontinued)を参照してください。



## Cordova アプリケーションまたはハイブリッド・アプリケーションのマイグレーション
{: #migrating-a-cordova-or-hybrid-application }
Apache Cordova コマンド・ライン・ツール、または Visual Studio Code、Eclipse、IntelliJ などの Cordova 対応 IDE を使用して Cordova アプリケーションの開発を開始します。

アプリケーションに {{ site.data.keys.product_adj }} プラグインを追加することで、{{ site.data.keys.product_adj }} 機能のサポートを追加します。V7.1 の Cordova アプリケーションまたはハイブリッド・アプリケーションと V8.0 の Cordova アプリケーションの違いについて詳しくは、[V8.0 を使用して開発した Cordova アプリケーションと V7.1 以前を使用して開発した Cordova アプリケーションの比較](migrating-client-applications/cordova/#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)を参照してください。

Cordova アプリケーションまたはハイブリッド・アプリケーションをマイグレーションするには、以下を実行する必要があります。

* 計画を立てるため、マイグレーション・アシスト・ツールを既存のプロジェクトで実行します。生成されたレポートを検討し、マイグレーションに必要な作業を評価します。詳しくは、[マイグレーション・アシスト・ツールを使用した Cordova アプリケーションのマイグレーションの開始](migrating-client-applications/cordova/#starting-the-cordova-app-migration-with-the-migration-assistance-tool)を参照してください。
* 使用が中止された、または V8.0.0 に含まれていないクライアント・サイド API を置き換えます。API の変更のリストについては、[WebView のアップグレード](migrating-client-applications/cordova/#upgrading-the-webview)を参照してください。
* クラシック・セキュリティー・モデルを使用するクライアント・リソースへの呼び出しを変更します。例えば、非推奨の `WL.Client.invokeProcedure` の代わりに、`WLResourceRequest` API を使用します。
* ダイレクト・アップデートを使用する場合は、[ダイレクト・アップデートのマイグレーション](migrating-client-applications/cordova/#migrating-direct-update)を検討してください。
* Cordova アプリケーションおよびハイブリッド・アプリケーションのマイグレーションについて詳しくは、[既存の Cordova アプリケーションおよびハイブリッド・アプリケーションのマイグレーション](migrating-client-applications/cordova)を参照してください。

> **注:** プッシュ通知サポートのマイグレーションには、クライアント・サイドとサーバー・サイドの変更が必要です。これについては、後述の『プッシュ通知サポートのマイグレーション』に説明があります。



## ネイティブ・アプリケーションのマイグレーション
{: #migrating-a-native-application }
ネイティブ・アプリケーションをマイグレーションするには、以下のステップを実行する必要があります。

* 計画の目的のために、マイグレーション・アシスト・ツールを既存のプロジェクトで実行します。生成されたレポートを検討し、マイグレーションに必要な作業を評価します。
* {{ site.data.keys.product }} v8.0 の SDK を使用するようにプロジェクトを更新します。
* 使用が中止された、または v8.0 に含まれていないクライアント・サイド API を置き換えます。マイグレーション・アシスト・ツールはコードをスキャンし、置き換える API のレポートを生成できます。
* クラシック・セキュリティー・モデルを使用するクライアント・リソースへの呼び出しを変更します。例えば、非推奨の `invokeProcedure` の代わりに、`WLResourceRequest` API を使用します。
    * ネイティブ iOS アプリケーションのマイグレーションについて詳しくは、[既存のネイティブ iOS アプリケーションのマイグレーション](migrating-client-applications/ios)を参照してください。
    * ネイティブ Android アプリケーションのマイグレーションについて詳しくは、[既存のネイティブ Android アプリケーションのマイグレーション](migrating-client-applications/android)を参照してください。
    * ネイティブ Windows アプリケーションのマイグレーションについて詳しくは、[既存のネイティブ Windows アプリケーションのマイグレーション](migrating-client-applications/windows)を参照してください。

> **注:** プッシュ通知サポートのマイグレーションには、クライアント・サイドとサーバー・サイドの変更が必要です。これについては、後述の[プッシュ通知サポートのマイグレーション](#migrating-push-notifications-support)に説明があります。



## アダプターおよびセキュリティーのマイグレーション
{: #migrating-adapters-and-security }
v8.0 以降、アダプターは Maven プロジェクトになりました。{{ site.data.keys.product_adj }} セキュリティー・フレームワークは、OAuth、セキュリティー・スコープ、およびセキュリティー検査に基づきます。セキュリティー・スコープは、リソースにアクセスするためのセキュリティー要件を定義します。セキュリティー検査は、セキュリティー要件の検査方法を定義します。セキュリティー検査は、Java アダプターとして作成されます。アダプターおよびセキュリティーのハンズオン体験については、[Java アダプターおよび JavaScript アダプターの作成](../adapters/creating-adapters)および[許可の概念](../authentication-and-security)のチュートリアルを参照してください。

{{ site.data.keys.mf_server }} はセッション独立モードでのみ作動します。また、アダプターは Java仮想マシン (JVM) に対してローカルに状態を保管すべきではありません。

アダプターのプロパティーを外部化して、実行されるコンテキスト (例えば、テスト・サーバーまたは実動サーバー) 用にアダプターを構成することができます。ただし、これらのプロパティーの値は、プロジェクト WAR ファイルのプロパティー・ファイルには含まれないようになりました。代わりに、{{ site.data.keys.mf_console }} から、またはコマンド・ライン・ツールやサーバー REST API を使用してそれらを定義します。

* アダプターのマイグレーションについて詳しくは、{{ site.data.keys.mf_server }} V8.0 で動作するようにするための[既存のアダプターのマイグレーション](migrating-adapters)を参照してください。
* サーバー・サイド API の変更について詳しくは、v8.0 での[サーバー・サイド API](../product-overview/release-notes/deprecated-discontinued/#server-side-api-changes) の変更を参照してください。
* アダプターを開発するために使用される Apache Maven の概要については、『[Apache Maven プロジェクトとしてのアダプター](../adapters)』を参照してください。
* 認証とセキュリティーのマイグレーションについて詳しくは、{{ site.data.keys.product_adj }} v8.0 への[認証とセキュリティーのマイグレーション](migrating-security)を参照してください。

## プッシュ通知サポートのマイグレーション
{: #migrating-push-notifications-support }
イベント・ソース・ベースのモデルはサポートされなくなりました。代わりに、タグ・ベースの通知を使用してください。クライアント・アプリケーションおよびサーバー・サイド・コンポーネント用のプッシュ通知のマイグレーションについて詳しくは、イベント・ソース・ベースの通知からの[プッシュ通知のマイグレーション](migrating-push-notifications)と、[マイグレーション・シナリオ](migrating-push-notifications/#migration-scenarios)を参照してください。

v8.0 以降、プッシュ・サービスはサーバー・サイドで構成します。プッシュ証明書はサーバーに保管されます。それらの設定は、{{ site.data.keys.mf_console }} から行うことができます。または、コマンド・ライン・ツールやプッシュ・サービス REST API を使用して、証明書のアップロードを自動化することができます。{{ site.data.keys.mf_console }} からプッシュ通知を送信することもできます。

プッシュ・サービスは、OAuth セキュリティー・モデルによって保護されています。プッシュ・サービス REST API を使用するサーバー・サイド・コンポーネントは、{{ site.data.keys.mf_server }} の機密クライアントとして構成する必要があります。

### プッシュ通知データ・マイグレーション・ツール
{: #push-notifications-data-migration-tool }
プッシュ通知データ用のマイグレーション・ツールも使用できます。マイグレーション・ツールは、MobileFirst Platform Foundation 7.1 のプッシュ・データ (デバイス、ユーザーのサブスクリプション、資格情報、およびタグ) を {{ site.data.keys.product }} 8.0 にマイグレーションする際に役立ちます。

> [マイグレーション・ツールについてもっとよく知る](migrating-push-notifications/#migration-tool)。

## サーバー・データベースおよびサーバー構造の変更
{: #changes-in-the-server-databases-and-in-the-server-structure }
{{ site.data.keys.mf_server }} は、アプリケーション・セキュリティーの変更、コード変更なしの接続およびプッシュ、アプリケーションの再ビルドまたは再デプロイメントを可能にします。ただし、これらの変更は、データベース・スキーマ、データベースに保管されたデータ、およびインストール・プロセスの変更を暗黙に示しています。

これらの変更のため、{{ site.data.keys.product }} には、データベースを以前のバージョンから V8.0.0 にマイグレーションしたり、既存のサーバー・インストール済み環境をアップグレードしたりするための自動化スクリプトは含まれていません。アプリケーションの新しいバージョンを V8.0.0 に移行するには、以前のサーバーと横並びで実行できる新しいサーバーをインストールします。次に、アプリケーションおよびアダプターを V8.0.0 にアップグレードし、新しいサーバーにそれらをデプロイします。

## Cloudant でのモバイル・データの保管
{: #storing-mobile-data-in-cloudant }
IMFData フレームワークまたは CloudantToolkit を使用した Cloudant でのモバイル・データの保管は、サポートされなくなっています。代替 API については、[IMFData または Cloudant SDK を使用して Cloudant にモバイル・データを保管するアプリケーションのマイグレーション](migrating-data)を参照してください。

## フィックスパックの {{ site.data.keys.mf_server }} への適用
{: #applying-a-fix-pack-to-mobilefirst-server }
サーバー構成ツールを使用して {{ site.data.keys.mf_server }} V8.0.0 をフィックスパックまたは暫定修正にアップグレードする方法を紹介します。または、Ant タスクを使用して {{ site.data.keys.mf_server }} をインストールした場合は、Ant タスクを使用してフィックスパックまたは暫定修正を適用することもできます。

{{ site.data.keys.mf_server }} にフィックスパックまたは暫定修正を適用するには、初期インストール方式に基づいて、以下のいずれかのトピックを選択してください。

* [サーバー構成ツールを使用したフィックスパックまたは暫定修正の適用](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-server-configuration-tool)
* [Ant ファイルを使用したフィックスパックの適用](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-ant-files)
