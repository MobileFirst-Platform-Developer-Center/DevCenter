---
layout: tutorial
title: React Native アプリケーションへの MobileFirst Foundation SDK の追加
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、React Native CLI を使用して作成された新規または既存の React Native アプリケーションに {{ site.data.keys.product_adj }} SDK を追加する方法について学習します。また、アプリケーションを認識するように {{ site.data.keys.mf_server }} を構成する方法と、プロジェクト内で変更する {{ site.data.keys.product_adj }} 構成ファイルに関する情報を見つける方法についても学習します。

{{ site.data.keys.product_adj }} React Native SDK は、React Native NPM プラグインとして提供され、[NPM](https://www.npmjs.com/package/react-native-ibm-mobilefirst) に登録されます。  

入手可能なプラグインは次のとおりです。

* **react-native-ibm-mobilefirst** - コアの SDK プラグイン

#### ジャンプ先:
{: #jump-to }
- [React Native SDK コンポーネント](#react-native-sdk-components)
- [{{ site.data.keys.product_adj }} React Native SDK の追加](#adding-the-mobilefirst-react-native-sdk)
- [{{ site.data.keys.product_adj }} React Native SDK の更新](#updating-the-mobilefirst-react-native-sdk)
- [生成される {{ site.data.keys.product_adj }} React Native SDK 成果物](#generated-mobilefirst-reactnative-sdk-artifacts)
- [次に使用するチュートリアル](#tutorials-to-follow-next)


## React Native SDK コンポーネント
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
react-native-ibm-mobilefirst プラグインは、React Native 用のコア {{ site.data.keys.product_adj }} プラグインであり、必須です。他の {{ site.data.keys.product_adj }} プラグインのいずれかをインストールすると、react-native-ibm-mobilefirst プラグインも自動的にインストールされます (まだインストールされていない場合)。

**前提条件:**

- [React Native CLI](https://www.npmjs.com/package/react-native) および {{ site.data.keys.mf_cli }} が開発者のワークステーションにインストールされている。
- {{ site.data.keys.mf_server }} のローカル・インスタンスまたはリモート・インスタンスが稼働している。
- [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/development/mobilefirst)および [React Native 開発環境のセットアップ](../../../installation-configuration/development/reactnative)の両チュートリアルを読む。

## {{ site.data.keys.product }} React Native SDK の追加
{: #adding-the-mobilefirst-react-native-sdk }
以下の手順に従って、新規または既存の React Native プロジェクトに {{ site.data.keys.product }} React Native SDK を追加し、それを {{ site.data.keys.mf_server }} に登録します。

開始する前に、{{ site.data.keys.mf_server }} が稼働していることを確認します。  
ローカルにインストールされているサーバーを使用する場合: **コマンド・ライン**・ウィンドウで、サーバーのフォルダーに移動し、コマンド `./run.sh` を実行します。

### SDK の追加
{: #adding-the-sdk }

#### 新規アプリケーション
{: #new-application }
1. React Native プロジェクトを作成します。`react-native init projectName`  
   例えば、次のとおりです。

   ```bash
   react-native init Hello
   ```
     - *Hello* は、フォルダー名であり、アプリケーションの名前です。

    > テンプレートとして用意された **index.js** を使用することで、[アプリケーションのマルチリンガル・トランスレーション](../../translation)や初期化オプションといった、{{ site.data.keys.product_adj }} の追加機能を使用できます (詳しくはユーザー向け資料を参照してください)。

2. `cd hello` コマンドで、ディレクトリーを React Native プロジェクトのルートに変更します。

3. NPM CLI コマンド `npm install react-native-plugin-name` を使用して、MobileFirst プラグインを追加します。
以下に例を示します。

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > 上記のコマンドは、MobileFirst コア SDK プラグインを React Native プロジェクトに追加します。


4. 以下のコマンドを実行して、プラグイン・ライブラリーをリンクします。

   ```bash
   react-native link
   ```

#### アプリケーションの終了
{: #existing-application }

1. 既存の React Native プロジェクトのルートに移動し、次のように {{ site.data.keys.product_adj }} コア React Native プラグインを追加します。

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. 以下のコマンドを実行して、プラグイン・ライブラリーをリンクします。

   ```bash
   react-native link
   ```

### アプリケーションの登録
{: #registering-the-application }

1. **コマンド・ライン**・ウィンドウを開き、プロジェクトの特定のプラットフォーム (iOS または Android) のルートに移動します。  

2. 次のコマンドで、{{ site.data.keys.mf_server }} にアプリケーションを登録します。

   ```bash
   mfpdev app register
   ```

  * **iOS** :

    プラットフォームが iOS の場合は、アプリケーションのバンドル ID を指定するように求められます。**重要**: バンドル ID **は大/小文字が区別**されます。

    `mfpdev app register` CLI コマンドは、まず、MobileFirst Server に接続してアプリケーションを登録し、次に、Xcode プロジェクトのルートに **mfpclient.plist** ファイルを生成し、そこに MobileFirst Server を識別するメタデータを追加します。

  *  **Android** :

      プラットフォームが Android の場合は、アプリケーションのパッケージ名を指定するように求められます。**重要**: パッケージ名は**大/小文字が区別**されます。

       `mfpdev app register` CLI コマンドは、まず、MobileFirst Server に接続してアプリケーションを登録し、続けて **mfpclient.properties** ファイルを Android Studio プロジェクトの **[project root]/app/src/main/assets/** フォルダー内に生成し、そこに MobileFirst Server を識別するメタデータを追加します。


リモート・サーバーを使用する場合は、[`mfpdev server add` コマンドを使用](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)して、そのサーバーを追加します。

`mfpdev app register` CLI コマンドは、まず、{{ site.data.keys.mf_server }} に接続してアプリケーションを登録します。各プラットフォームはアプリケーションとして {{ site.data.keys.mf_server }} に登録されます。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** 次のように、{{ site.data.keys.mf_console }} からアプリケーションを登録することもできます。    
>
> 1. {{ site.data.keys.mf_console }} をロードします。  
> 2. **「アプリケーション」**の横の**「新規」**ボタンをクリックして、新規アプリケーションを登録し、画面に表示される指示に従います。  


## {{ site.data.keys.product_adj }} React Native SDK の更新
{: #updating-the-mobilefirst-react-native-sdk }
{{ site.data.keys.product_adj }} React Native SDK を最新リリースで更新するには、`npm uninstall react-native-ibm-mobilefirst` コマンドを実行して **react-native-ibm-mobilefirst** プラグインを削除してから、`npm install react-native-ibm-mobilefirst` コマンドを実行してこのプラグインを再度追加します。

SDK のリリースは、SDK の [NPM リポジトリー](https://www.npmjs.com/package/react-native-ibm-mobilefirst)で調べることができます。

## 生成される{{ site.data.keys.product_adj }} React Native SDK 成果物
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Android 環境

#### mfpclient.properties
{: #mfpclient.properties }
Android Studio プロジェクトの **./app/src/main/assets/** フォルダー内に配置されているこのファイルは、{{ site.data.keys.mf_server }} に Android アプリケーションを登録するために使用される、クライアント・サイドのプロパティーを定義します。

| プロパティー            | 説明                                                         | 値の例 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | {{ site.data.keys.mf_server }} との通信プロトコル。             | http または https  |
| wlServerHost        | {{ site.data.keys.mf_server }} のホスト名。                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }} のポート。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上のアプリケーションのコンテキスト・ルート・パス。 | /mfp/          |
| languagePreferences | クライアントの SDK システム・メッセージのデフォルト言語を設定します。           | en             |


### iOS 環境

#### mfpclient.plist
{: #mfpclientplist }
プロジェクトのルートに配置されているこのファイルは、{{ site.data.keys.mf_server }} に iOS アプリケーションを登録するために使用される、クライアント・サイドのプロパティーを定義します。

| プロパティー            | 説明                                                         | 値の例 |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | {{ site.data.keys.mf_server }} との通信プロトコル。             | http または https  |
| host        | {{ site.data.keys.mf_server }} のホスト名。                            | 192.168.1.63   |
| port        | {{ site.data.keys.mf_server }} のポート。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上のアプリケーションのコンテキスト・ルート・パス。 | /mfp/          |
| languagePreferences | クライアントの SDK システム・メッセージのデフォルト言語を設定します。           | en             |


## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
これで {{ site.data.keys.product_adj }} React Native SDK が組み込まれたので、以下の作業を行うことができます。

- [{{ site.data.keys.product }} SDK の使用に関するチュートリアル](../)を検討する
- [アダプター開発に関するチュートリアル](../../../adapters/)を検討する
- [認証とセキュリティーに関するチュートリアル](../../../authentication-and-security/)を検討する
- [通知に関するチュートリアル](../../../notifications/)を検討する
- [すべてのチュートリアル](../../../all-tutorials)を検討する
