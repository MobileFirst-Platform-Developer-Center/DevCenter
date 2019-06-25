---
layout: tutorial
title: インストールおよび構成
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #installation-and-configuration }

Digital App Builder は、MacOS および Windows プラットフォームにインストールできます。

### MacOS でのインストール
{: #installing-on-macos }

1. [https://nodejs.org/ja/download/](https://nodejs.org/ja/download/) (Node.js 8.x 以上) からセットアップをダウンロードして、**Node.js** および **npm** をインストールします。インストールの説明について詳しくは、[こちら](https://nodejs.org/ja/download/package-manager/)を参照してください。以下に示すように、node および npm のバージョンを確認します。
    ```java
    $node -v
    v8.10.0
    $npm -v
    6.4.1
    ```
2. **Cordova** をインストールします。[Cordova](https://cordova.apache.org/docs/ja/latest/guide/cli/index.html) からパッケージをダウンロードしてインストールできます。
    ```java
    $ npm install -g cordova
    $ cordova –version
    7.0.1
    ```

    >**注**: `$ npm install -g cordova` コマンドの実行で許可の問題が発生している場合は、上位の特権を使用してインストールしてください (`$ sudo npm install -g cordova`)。

3. **ionic** をインストールします。[ionic](https://ionicframework.com/docs/cli/) からパッケージをダウンロードしてインストールできます。
    ```java
    $ npm install -g ionic
    $ ionic –version
    4.2.0
    ```

    >**注**: `$ npm install -g ionic` コマンドの実行で許可の問題が発生している場合は、上位の特権を使用してインストールしてください (`$ sudo npm install -g ionic`)。

4. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から .dmg (**IBM.Digital.App.Builder-8.0.0.dmg**) をダウンロードします。
5. .dmg ファイルをダブルクリックしてインストーラーをマウントします。
6. インストーラーで開かれたウィンドウで、IBM Digital App Builder を **Applications** フォルダーにドラッグ・アンド・ドロップします。
7. IBM Digital App Builder アイコンまたは実行可能ファイルをダブルクリックして、Digital App Builder を開きます。
>**注**: Digital App Builder の初回インストール時には、Digital App Builder はインターフェースを開き、[前提条件チェック](#prerequisites-check)を実行します。エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### Windows でのインストール
{: #installing-on-windows }

管理モードで開かれたコマンド・プロンプトから以下のコマンドを実行します。

1. [https://nodejs.org/ja/download/](https://nodejs.org/ja/download/) (Node.js 8.x 以上) からセットアップをダウンロードして、**Node.js** および **npm** をインストールします。インストールの説明について詳しくは、[こちら](https://nodejs.org/ja/download/package-manager/)を参照してください。以下に示すように、node および npm のバージョンを確認します。 

    ```java
    C:\>node -v
    v8.10.0
    C:\>npm -v
    6.4.1
    ```

2. **Cordova** をインストールします。[Cordova](https://cordova.apache.org/docs/ja/latest/guide/cli/index.html) からパッケージをダウンロードしてインストールできます。

    ```java
    C:\>npm install -g cordova
    C:\>cordova –v
    7.0.1
    ```

3. **ionic** をインストールします。[ionic](https://ionicframework.com/docs/cli/) からパッケージをダウンロードしてインストールできます。

    ```java
    C:\>npm install -g ionic
    C:\> ionic –version
    4.2.0
    ``` 

4. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から .exe (**IBM.Digital.App.Builder.Setup.8.0.0.exe**) をダウンロードします。
5. Digital App Builder 実行可能ファイルをダブルクリックしてインストールします。デスクトップの**「スタート」>「プログラム」**にショートカットも作成されます。デフォルトのインストール・フォルダーは、`<AppData>\Local\IBMDigitalAppBuilder\app-8.0.0` です。
>**注**: Digital App Builder の初回インストール時には、Digital App Builder はインターフェースを開き、[前提条件チェック](#prerequisites-check)を実行します。エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### 前提条件チェック
{: #prerequisites-check }

アプリケーションを開発する前に、**「ヘルプ (Help)」>「前提条件チェック」**を選択して、前提条件チェックを実行できます。

![前提条件チェック](dab-prerequsites-check.png)

エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

>**注**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) は MacOS でのみ必須です。

