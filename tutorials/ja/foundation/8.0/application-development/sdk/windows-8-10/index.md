---
layout: tutorial
title: Windows 8.1 Universal アプリケーションまたは Windows 10 UWP アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product }} SDK は、[NuGet](https://www.nuget.org/) を通じて入手可能な依存関係の集合で構成されます。この SDK は、Visual Studio プロジェクトに追加できます。これらの依存関係は、次のようなコア機能およびその他の機能に対応しています。

* **IBMMobileFirstPlatformFoundation** - クライアントとサーバー間の接続を実装し、認証およびセキュリティーの各側面、リソース要求、およびその他の必要なコア機能を処理します。

このチュートリアルでは、Nuget を使用して {{site.data.keys.product_adj }} ネイティブ SDK を新規または既存の Windows 8.1 Universal アプリケーションまたは Windows 10 UWP (Universal Windows Platform) アプリケーションに追加する方法について学習します。また、アプリケーションを認識するように {{site.data.keys.mf_server }} を構成する方法と、プロジェクトに追加する {{site.data.keys.product_adj }} 構成ファイルに関する情報を見つける方法についても学習します。

**前提条件:**

- Microsoft Visual Studio 2013 または 同 2015 と {{site.data.keys.mf_cli }} が開発者のワークステーションにインストールされている。Windows 10 UWP ソリューションの開発には、最低でも Visual Studio 2015 が必要です。
- {{site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [{{site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/development/mobilefirst)、および [Windows 8 Universal 開発環境と Windows 10 UWP 開発環境のセットアップ](../../../installation-configuration/development/windows)の両チュートリアルを読む。

#### ジャンプ先:
{: #jump-to }
- [{{site.data.keys.product_adj }} ネイティブ SDK の追加](#adding-the-mobilefirst-native-sdk)
- [{{site.data.keys.product_adj }} ネイティブ SDK の更新](#updating-the-mobilefirst-native-sdk)
- [生成される {{site.data.keys.product_adj }} ネイティブ SDK 成果物](#generated-mobilefirst-native-sdk-artifacts)
- [次に使用するチュートリアル](#tutorials-to-follow-next)

## {{site.data.keys.product_adj }} ネイティブ SDK の追加
{: #adding-the-mobilefirst-native-sdk }
以下の手順に従って、新規または既存の Visual Studio プロジェクトに {{site.data.keys.product_adj }} ネイティブ SDK を追加し、アプリケーションを {{site.data.keys.mf_server }} に登録します。

開始する前に、{{site.data.keys.mf_server }} インスタンスが稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、コマンド `./run.cmd` を実行します。

### アプリケーションの作成
{: #creating-an-application }
Visual Studio 2013/2015 を使用して Windows 8.1 Universal プロジェクトまたは Windows 10 UWP プロジェクトを作成するか、または既存のプロジェクトを使用します。  

### SDK の追加
{: #adding-the-sdk }
1. {{site.data.keys.product_adj }} パッケージをインポートするには、NuGet パッケージ・マネージャーを使用します。
NuGet は、.NET などの Microsoft 開発プラットフォーム用のパッケージ・マネージャーです。NuGet クライアント・ツールは、パッケージを作成および使用するための機能を提供します。NuGet Gallery は、パッケージの作成者およびユーザー全員が使用する、中央のパッケージ・リポジトリーです。

2. Visual studio 2013/2015 で Windows 8.1 Universal プロジェクトまたは Windows 10 UWP プロジェクトを開きます。プロジェクト・ソリューションを右クリックし、**「NuGet パッケージの管理」**を選択します。

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. 検索オプションで、「IBM MobileFirst Platform」を検索します。**IBM.MobileFirstPlatform.{{site.data.keys.product_V_R_M_I }}** を選択します。

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. **「インストール」**をクリックします。このアクションにより、{{site.data.keys.product }} ネイティブ SDK とその依存関係がインストールされます。また、このステップにより、Visual Studio プロジェクトの `strings` フォルダーに空の `mfpclient.resw` ファイルが生成されます。

5. `Package.appxmanifest` 内で、少なくとも次の機能が有効になっているようにします。

    - インターネット (クライアント)

### アプリケーションの登録
{: #reigstering-the-application }
1. **コマンド・ライン**を開き、Visual Studio プロジェクトのルートに移動します。  

2. 次のコマンドを実行します:

   ```bash
    mfpdev app register
    ```
    - リモート・サーバーを使用する場合は、[`mfpdev server add` コマンドを使用](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)して、そのサーバーを追加します。

`mfpdev app register` CLI コマンドは、まず最初に {{site.data.keys.mf_server }} に接続してアプリケーションを登録した後、Visual Studio プロジェクトの **strings** フォルダー内にある **mfpclient.resw** ファイルを更新し、これに {{site.data.keys.mf_server }} を識別するメタデータを追加します。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** 次のように、{{site.data.keys.mf_console }} からアプリケーションを登録することもできます。    
>
> 1. {{site.data.keys.mf_console }} をロードします。  
> 2. **「アプリケーション」**の横の**「新規」**ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。  
> 3. アプリケーションが登録されたら、そのアプリケーションの**「構成ファイル」**タブに移動して、**mfpclient.resw** ファイルをコピーまたはダウンロードします。画面上に表示される指示に従って、ファイルをプロジェクトに追加します。

## {{site.data.keys.product_adj }} ネイティブ SDK の更新
{: #updating-the-mobilefirst-native-sdk }
{{site.data.keys.product_adj }} ネイティブ SDK を最新リリースで更新するには、**コマンド・ライン**・ウィンドウで、Visual Studio プロジェクトのルート・フォルダーから次のコマンドを実行します。

```bash
Nuget update
```

## 生成される{{site.data.keys.product_adj }} ネイティブ SDK 成果物
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.resw
{: #mfpclientresw }
プロジェクトの `strings` フォルダー内にあるこのファイルは、ユーザーによる編集が可能で、次のサーバー接続プロパティーを含んでいます。

- `protocol` – {{site.data.keys.mf_server }} に対する通信プロトコル。`HTTP` または `HTTPS` のいずれかです。
- `WlAppId` - アプリケーションの ID。これは、サーバー内のアプリケーション ID と同じである必要があります。
- `host` – {{site.data.keys.mf_server }} インスタンスのホスト名。
- `port` – {{site.data.keys.mf_server }} インスタンスのポート。
- `wlServerContext` – {{site.data.keys.mf_server }} インスタンス上のアプリケーションのコンテキスト・ルート・パス。
- `languagePreference` - クライアントの SDK システム・メッセージのデフォルト言語を設定します。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで MobileFirst ネイティブ SDK が組み込まれたので、以下の作業を行うことができます。

- [{{site.data.keys.product }} SDK の使用に関するチュートリアル](../)を検討する
- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
