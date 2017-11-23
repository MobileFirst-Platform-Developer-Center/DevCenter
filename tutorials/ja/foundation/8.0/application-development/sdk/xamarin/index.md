---
layout: tutorial
title: Xamarin アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product }} SDK は、[Xamarin Component ストア](https://components.xamarin.com/)を通じて入手可能な依存関係の集合で構成されます。この SDK は、Xamarin プロジェクトに追加できます。  
これらの pod は、次のようなコア機能およびその他の機能に対応しています。

* **MobileFirst.Xamarin** - クライアントとサーバー間の接続を実装し、認証およびセキュリティーの各側面、リソース要求、およびその他の必要なコア機能を処理します。
* **MobileFirst.JSONStore** - JSONStore のフレームワークを含んでいます。  
* **MobileFirst.Push** - プッシュ通知のフレームワークを含んでいます。詳しくは、[通知に関するチュートリアル](../../../notifications/)を参照してください。

このチュートリアルでは、Xamarin Component ストアを使用して {{ site.data.keys.product_adj }} ネイティブ SDK を新規または既存の Xamarin Android アプリケーションまたは Xamarin iOS アプリケーションに追加する方法について学習します。また、アプリケーションを認識するように {{ site.data.keys.mf_server }} を構成する方法についても学習します。

**前提条件:**

- Xamarin Studio が開発者のワークステーションにインストールされている。  
- {{ site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/development/)、および [Xamarin 開発環境のセットアップ](../../../installation-configuration/development/xamarin/)の両チュートリアルを読む。

#### ジャンプ先:
{: #jump-to }
- [{{ site.data.keys.product_adj }} ネイティブ SDK の追加](#adding-the-mobilefirst-native-sdk)
- [{{ site.data.keys.product_adj }} ネイティブ SDK の更新](#updating-the-mobilefirst-native-sdk)
- [次に使用するチュートリアル](#tutorials-to-follow-next)

## {{ site.data.keys.product_adj }} ネイティブ SDK の追加
{: #adding-the-mobilefirst-native-sdk }
以下の手順に従って、新規または既存の Xcode プロジェクトに {{ site.data.keys.product_adj }} ネイティブ SDK を追加し、アプリケーションを {{ site.data.keys.mf_server }} に登録します。

開始する前に、{{ site.data.keys.mf_server }} が稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、コマンド `./run.sh` を実行します。

### アプリケーションの作成
{: #creating-an-application }
Xamarin Studio または Visual Studio を使用して Xamarin ソリューションを作成するか、または既存の Xamarin ソリューションを使用します。

### SDK の追加
{: #adding-the-sdk }
1. {{ site.data.keys.product_adj }} ネイティブ SDK は、Xamarin Components ストア経由で提供されます。
2. Android プロジェクトまたは iOS プロジェクトを展開します。
3. Android プロジェクトまたは iOS プロジェクトで、**「コンポーネント (Components)」**を右クリックします。
4. **「さらにコンポーネントを取得 (Get More Components)」**を選択します。
![Add-XamarinSDK-tosolution-search](Add-Xamarin-tosolution.png)
5. **「IBM MobileFirst SDK」**を検索します。**「アプリケーションに追加 (Add to App)」**を選択して実行します。![Add-XamarinSDK-tosolution](Add-XamarinSDK-toApp.png)
6. **「パッケージ (Packages)」**を右クリックして、**「パッケージの追加 (Add packages)」**を選択します。**「Json.NET」**を検索して追加します。これで Nuget から Newtonsoft 依存関係が取り込まれます。これは、Android プロジェクトと iOS プロジェクトの両方について別々に実行する必要があります。
7. **「参照 (References)」**を右クリックして、**「参照を編集 (Edit References)」**を選択します。**「.Net アセンブリー (.Net Assembly)」**タブに移動して、「参照 (Browse)」をクリックします。プロジェクト・フォルダーのルートから、`「コンポーネント (Components)」->「ibm-worklight-8.0.0.1」->「lib」->「pcl」`に移動します。**Worklight.Core.dll** を選択します。

### アプリケーションの登録
{: #registering-the-application }
1. {{ site.data.keys.mf_console }} をロードします。
2. 「アプリケーション」の横の「新規」ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。
3. Android アプリケーションと iOS アプリケーションは別々に登録する必要があります。そうすることで、Android アプリケーションと iOS アプリケーションの両方が正常にサーバーに接続できるようになります。Android アプリケーションと iOS アプリケーションの登録の詳細は、それぞれ `AndroidManifest.xml` と `Info.plist` に記載されています。
3. アプリケーションが登録されたら、そのアプリケーションの「構成ファイル」タブに移動して、mfpclient.plist ファイルと mfpclient.properties ファイルをコピーまたはダウンロードします。画面上に表示される指示に従って、ファイルをプロジェクトに追加します。

### セットアップ・プロセスの完了
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Xamarin iOS プロジェクトを右クリックして**「ファイルの追加.. (Add files..)」**を選択します。プロジェクトのルートに配置されている `mfpclient.plist` を参照で検索します。**「ファイルをプロジェクトにコピー (Copy file to project)」**を選択するようにプロンプトが出されたら、選択します。
2. `mfpclient.plist` ファイルを右クリックし、**「ビルド・アクション (Build action)」**を選択します。**「コンテンツ (Content)」**を選択します。

#### mfpclient.properties
{: #mfpclientproperties }
1. Xamarin Android プロジェクトの*「アセット (Assets)」*フォルダーを右クリックし、**「ファイルの追加.. (Add files..)」**を選択します。フォルダーの参照で `mfpclient.properties` を検索します。**「ファイルをプロジェクトにコピー (Copy file to project)」**を選択するようにプロンプトが出されたら、選択します。
2. `mfpclient.properties` ファイルを右クリックし、**「ビルド・アクション (Build action)」**を選択します。**「Android アセット (Android asset)」**を選択します。

### SDK の参照
{: #referencing-the-sdk }
{{ site.data.keys.product_adj }} ネイティブ SDK を使用する場合はいつでも、必ず {{ site.data.keys.product }} フレームワークをインポートするようにしてください。

CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## {{ site.data.keys.product_adj }} ネイティブ SDK の更新
{: #updating-the-mobilefirst-native-sdk }
{{ site.data.keys.product_adj }} ネイティブ SDK を最新リリースで更新するには、Xamarin Components ストア経由で SDK のバージョンを更新します。

## 生成される{{ site.data.keys.product_adj }} ネイティブ SDK 成果物
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
このファイルは、{{ site.data.keys.mf_server }} に iOS アプリケーションを登録するために使用される、クライアント・サイドのプロパティーを定義します。

| プロパティー| 説明| 値の例|
|---------------------|---------------------------------------------------------------------|----------------|
| protocol| {{ site.data.keys.mf_server }} との通信プロトコル。| http または https|
| host| {{ site.data.keys.mf_server }} のホスト名。| 192.168.1.63|
| port| {{ site.data.keys.mf_server }} のポート。| 9080|
| wlServerContext| {{ site.data.keys.mf_server }} 上のアプリケーションのコンテキスト・ルート・パス。| /mfp/|
| languagePreferences| クライアントの SDK システム・メッセージのデフォルト言語を設定します。| en|

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで {{ site.data.keys.product_adj }} ネイティブ SDK が組み込まれたので、以下の作業を行うことができます。

- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
