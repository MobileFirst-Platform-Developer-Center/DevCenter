---
layout: tutorial
title: インストールおよび構成
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #installation-and-configuration }

Digital App Builder は、MacOS および Windows プラットフォームにインストールできるようになりました。インストールには、初回インストール時にインストールされ、検証された前提ソフトウェアも含まれます。アダプター生成と開発中のアプリのプレビューのために、Java、Xcode、および Android Studio をインストールできます。

### MacOS でのインストール
{: #installing-on-macos }

1. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から、.dmg (**IBM.Digital.App.Builder-n.n.n.dmg**。`n.n.n` はバージョン番号) をダウンロードします。
2. .dmg ファイルをダブルクリックしてインストーラーをマウントします。
3. インストーラーで開かれたウィンドウで、IBM Digital App Builder を **Applications** フォルダーにドラッグ・アンド・ドロップします。
4. IBM Digital App Builder アイコンまたは実行可能プログラムをダブルクリックして、Digital App Builder を開きます。
    >**注**: Digital App Builder の初回インストール時に、Digital App Builder は、前提ソフトウェアをインストールするためのインターフェースを開きます。
    
    ![Digital App Builder のインストール](dab-install-startup.png)

5. **「セットアップの開始」**をクリックします。これにより、「ご使用条件」の画面が表示されます。

    ![「ご使用条件」画面](dab-install-license.png)

6. ご使用条件に同意し、**「次へ」**をクリックします。これにより、**「前提条件のインストール」**画面が表示されます。
    >**注**: 既にインストールされている前提ソフトウェアがないかチェックされ、各前提ソフトウェアに対して状況が表示されます。

    ![「前提条件のインストール」画面](dab-install-prereq.png)

7. 前提条件のいずれかが**「インストールされるもの」**状況の場合は、**「インストール」**をクリックして前提ソフトウェアをセットアップします。

    ![「前提条件のインストール」画面](dab-install-prereq-tobeinstalled.png)

8. 前提ソフトウェアがインストールされた後、Digital App Builder の開始画面が表示されます。**「ビルドの開始」**をクリックします。

    ![Digital App Builder の開始](dab-install-startup-screen.png)

9. *オプション* - 前提ソフトウェアがインストールされた後、Digital App Builder がデータ・セットを扱うために Java が必要なため、インストーラーは JAVA をチェックします。
    >**注**: JAVA がまだインストールされていない場合は、手動でインストールする必要があります。Java のインストールについては、[Java のインストール](https://www.java.com/en/download/help/download_options.xml)を参照してください。
10. *オプション* - インストーラーはまた、オプションの Xcode (開発中に iOS シミュレーターでアプリをプレビューするため、MacOS のみ) および Android Studio (Android アプリをプレビューするため、MacOS および Windows) のインストールをチェックします。
    >**注**: Xcode と Android Studio を手動でインストールする必要があります。Cocoapods のインストールについては、[CocoaPods の使用](https://guides.cocoapods.org/using/using-cocoapods)を参照してください。Android Studio のインストールについては、[Android Studio のインストール](https://developer.android.com/studio/)を参照してください。 

>**注**: 任意の時点で[前提条件のチェック](#prerequisites-check)を実行して、アプリを開発するインストール済み環境が正常であることを確認できます。エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### Windows でのインストール
{: #installing-on-windows }

管理モードで開かれたコマンド・プロンプトから以下のコマンドを実行します。

1. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から、.exe (**IBM.Digital.App.Builder.Setup.n.n.n.exe**。`n.n.n` はバージョン番号) をダウンロードします。
2. Digital App Builder 実行可能ファイルをダブルクリックしてインストールします。

    ![Digital App Builder のインストール](dab-install-startup.png)

3. **「セットアップの開始」**をクリックします。これにより、「ご使用条件」の画面が表示されます。

    ![「ご使用条件」画面](dab-install-license.png)

4. ご使用条件に同意し、**「次へ」**をクリックします。これにより、**「前提条件のインストール」**画面が表示されます。
    >**注**: 既にインストールされている前提ソフトウェアがないかチェックされ、各前提ソフトウェアに対して状況が表示されます。

    ![「前提条件のインストール」画面](dab-install-prereq.png)

5. 前提条件のいずれかが**「インストールされるもの」**状況の場合は、**「インストール」**をクリックして前提ソフトウェアをセットアップします。

    ![「前提条件のインストール」画面](dab-install-prereq-tobeinstalled.png)

6. 前提ソフトウェアがインストールされた後、Digital App Builder の開始画面が表示されます。**「ビルドの開始」**をクリックします。

    ![Digital App Builder の開始](dab-install-startup-screen.png)

    >**注**: デスクトップの**「スタート」 > 「プログラム」**にショートカットも作成されます。デフォルトのインストール・フォルダーは、`<AppData>&#xa5;Local&#xa5;IBMDigitalAppBuilder&#xa5;app-8.0.2` です。

7. *オプション* - 前提ソフトウェアがインストールされた後、Digital App Builder がデータ・セットを扱うために Java が必要なため、インストーラーは JAVA をチェックします。
    >**注**: JAVA がまだインストールされていない場合は、手動でインストールする必要があります。Java のインストールについては、[Java のインストール](https://www.java.com/en/download/help/download_options.xml)を参照してください。
8. *オプション* - インストーラーはまた、オプションの Xcode (開発中に iOS シミュレーターでアプリをプレビューするため、MacOS のみ) および Android Studio (Android アプリをプレビューするため、MacOS および Windows) のインストールをチェックします。
    >**注**: Android Studio を手動でインストールする必要があります。Android Studio のインストールについては、[Android Studio のインストール](https://developer.android.com/studio/)を参照してください。 

>**注**: 任意の時点で[前提条件のチェック](#prerequisites-check)を実行して、アプリを開発するインストール済み環境が正常であることを確認できます。エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### 前提条件チェック
{: #prerequisites-check }

アプリケーションを開発する前に、**「ヘルプ (Help)」>「前提条件チェック」**を選択して、前提条件チェックを実行できます。

![前提条件チェック](dab-prerequsites-check.png)

エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

>**注**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) は MacOS でのみ必須です。

