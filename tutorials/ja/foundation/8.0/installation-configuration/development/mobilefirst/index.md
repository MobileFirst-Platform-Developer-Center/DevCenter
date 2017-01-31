---
layout: tutorial
title: MobileFirst 開発環境のセットアップ
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_full }} は、クライアント SDK、アダプター・アーキタイプ、セキュリティー検査、認証ツールなど、いくつかのコンポーネントから構成されます。

これらのコンポーネントは、オンライン・リポジトリーから入手可能で、パッケージ・マネージャーを使用してインストール可能です。これらのオンライン・リポジトリーに、各コンポーネントの最新リリースが用意されています。また、ローカルで使用するために、同じコンポーネントが {{site.data.keys.mf_dev_kit }} からダウンロード可能です。{{site.data.keys.mf_dev_kit_short }} から入手可能なバージョンは、特定の {{site.data.keys.mf_dev_kit_short }} ビルドのリリース時点で入手可能であったバージョンを表し、最新を使用するには、新しい {{site.data.keys.mf_dev_kit_short }} ビルドのダウンロードが必要になることに注意してください。 

{{site.data.keys.product }} のコンポーネントの詳細については、以下で説明します。

> {{site.data.keys.product }} を評価するために必要なことは、Mobile Foundation Bluemix サービスを使用して Bluemix で {{site.data.keys.mf_server }} のインスタンスをスピンすることだけです。手順については、[Mobile Foundation の使用](../../../bluemix/using-mobile-foundation/)のチュートリアルを参照してください。ローカル・インストールの場合は、{{site.data.keys.mf_dev_kit_short }} のインストールを選択することもできます。

#### ジャンプ先:
{: #jump-to }

* [インストール・ガイド](#installation-guide)
* [{{site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [{{site.data.keys.product }} コンポーネント](#mobilefirst-foundation-components)
* [アプリケーションおよびアダプターの開発](#applications-and-adapters-development)
* [次に使用するチュートリアル](#tutorials-to-follow-next)

## インストール・ガイド
{: #installation-guide }
MobileFirst Foundation をワークステーションに迅速にセットアップするには、[インストール・ガイドをお読みください](installation-guide)。

## {{site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
{{site.data.keys.mf_dev_kit_short }} には、最小限の必要構成ですぐに開発できる環境が用意されています。キットは、{{site.data.keys.mf_server }} および {{site.data.keys.mf_console }}、MobileFirst Developer コマンド・ライン・インターフェース (CLI) のコンポーネントで構成されるほか、オプションで、ダウンロード用のクライアント SDK およびアダプター・ツールを用意しています。

> **注:**インターネットにアクセスできないコンピューターで開発環境をセットアップする必要がある場合、オフラインでコンポーネントをインストールすることが可能です。「[How to set up an offline IBM MobileFirst development environment]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment)」を参照してください。### {{site.data.keys.mf_dev_kit_short }}Installer
{: #developer-kit-installer }
インストーラーでは、インターネット接続を利用できないローカル・インストール用のコンポーネントをパッケージ化しています。  
コンポーネントは、{{site.data.keys.mf_console }} のダウンロード・センターから入手できます。

> インストーラーをダウンロードするには、[ダウンロード]({{site.baseurl}}/downloads/)・ページを参照してください。

## {{site.data.keys.product }} コンポーネント
{: #mobilefirst-foundation-components }

### {{site.data.keys.mf_server }}
{: #mobilefirst-server }
{{site.data.keys.mf_dev_kit_short }} の一部として、{{site.data.keys.mf_server }} は、WebSphere Liberty プロファイル・アプリケーション・サーバーに事前デプロイされて提供されています。このサーバーは、「mfp」ランタイムで事前構成されており、ファイル・システム・ベースの Apache Derby データベースを使用します。

{{site.data.keys.mf_dev_kit_short }} のルート・ディレクトリーで、コマンド・ラインから実行できる以下のスクリプトが使用可能です。

* `run.[sh|cmd]`: {{site.data.keys.mf_server }} を実行します。Liberty サーバーのメッセージがその後に表示されます。
    * `-bg` フラグを追加すると、このプロセスがバックグラウンドで実行されます。
* `stop.[sh|cmd]`: 現行の {{site.data.keys.mf_server }} インスタンスを停止します。
* `console.[sh|cmd]`: {{site.data.keys.mf_console }} を開きます。

ファイル拡張子 `.sh` は Mac および Linux 用で、ファイル拡張子 `.cmd` は Windows 用です。

### {{site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
{{site.data.keys.mf_console }} により、以下の機能が提供されます。  
開発者は以下を行えます。

- アプリケーションとアダプターの登録およびデプロイ
- ネイティブ/Cordova アプリケーションおよびアダプターのスターター・コード・テンプレートをオプションでダウンロード 
- アプリケーションの認証およびセキュリティー・プロパティーの構成
- アプリケーションの管理:
    - アプリケーション認証性
    - ダイレクト・アップデート
    - リモートでの無効化/通知
- iOS デバイスおよび Android デバイスにプッシュ通知を送信
- DevOps スクリプトの生成。これにより、継続的統合ワークフローが実現され、開発サイクルが短縮されます。

> [MobilFirst Operations Console の使用](../../../product-overview/components/console/)のチュートリアルで、{{site.data.keys.mf_console }} が詳細に説明されています。

### {{site.data.keys.product }} コマンド・ライン・インターフェース
{: #mobilefirst-foundation-command-line-interface }
アプリケーションを開発および管理するために、{{site.data.keys.mf_console }} に加えて {{site.data.keys.mf_cli }} を使用できます。CLI コマンドは、接頭部 `mfpdev` が付き、以下のタイプのタスクをサポートします。

* {{site.data.keys.mf_server }} へのアプリケーションの登録
* アプリケーションの構成
* アダプターの作成、ビルド、およびデプロイ
* Cordova アプリケーションのプレビューおよび更新

> {{site.data.keys.mf_cli }} をダウンロードしてインストールするには、[ダウンロード]({{site.baseurl}}/downloads/)・ページを参照してください。  
> [CLI を使用した MobileFirst 成果物の管理](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)のチュートリアルで、各種 CLI コマンドが詳細に説明されています。

### {{site.data.keys.product }} クライアント SDK およびアダプター・ツール
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{site.data.keys.product }} では、Cordova アプリケーション用のほか、ネイティブ・プラットフォーム (iOS、Android、Windows 8.1 Universal および Windows 10 UWP) 用のクライアント SDK を提供します。また、アダプターおよびセキュリティー検査の開発用のアダプター・ツールも使用可能です。

* {{site.data.keys.product_adj }} クライアント SDK を使用するには、[{{site.data.keys.product }} SDK の追加](../../../application-development/sdk/)のチュートリアル・カテゴリーを参照してください。  
* アダプターを開発するには、[アダプター](../../../adapters/)のチュートリアル・カテゴリーを参照してください。  
* セキュリティー検査を開発するには、[認証およびセキュリティー](../../../authentication-and-security/)のチュートリアル・カテゴリーを参照してください。  

## アプリケーションおよびアダプターの開発
{: #applications-and-adapters-development }

### アプリケーション
{: #applications }
* Cordova アプリケーションには NodeJS および Cordova CLI が必要です。[Cordova 開発環境のセットアップ](../cordova)に関する詳細をお読みください。

    アプリケーションおよびアダプターの実装には、任意のコード・エディター (Atom.io、Visual Studio Code、Eclipse、IntelliJ、その他) を使用できます。  
    
* ネイティブ・アプリケーションには、Xcode、Android Studio、または Visual Studio が必要です。[iOS/Android/Windows 開発環境のセットアップ](../)に関する詳細をお読みください。

### アダプター
{: #adapters }
アダプターには、Apache Maven がインストールされていることが必要です。アダプターの詳細、および作成、開発、デプロイ方法については、[アダプター](../../../adapters/)のカテゴリーを参照してください。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
[すべてのチュートリアル](../../../all-tutorials/)のページにアクセスし、次に使用するチュートリアル・カテゴリーを選択してください。

