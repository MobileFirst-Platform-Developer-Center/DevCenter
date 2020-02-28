---
layout: tutorial
title: インストールおよび構成
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #installation-and-configuration }

Digital App Builder は、MacOS および Windows プラットフォーム上にインストールできます。 インストールには、初回インストール時にインストールされ、検証された前提ソフトウェアも含まれます。 アダプター生成および開発中のアプリケーションのプレビューのために、Java、Xcode、および Android Studio をインストールします。

### MacOS でのインストール
{: #installing-on-macos }

1. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から、.dmg (**IBM.Digital.App.Builder-n.n.n.dmg**。`n.n.n` はバージョン番号) をダウンロードします。
2. .dmg ファイルをダブルクリックしてインストーラーをマウントします。
3. インストーラーで開かれたウィンドウで、IBM Digital App Builder を **Applications** フォルダーにドラッグ・アンド・ドロップします。
4. IBM Digital App Builder アイコンまたは実行可能プログラムをダブルクリックして、Digital App Builder を開きます。
    >**注**: Digital App Builder の初回インストール時、Digital App Builder は、前提ソフトウェアをインストールするためのインターフェースを開きます。 Digital App Builder の前のバージョンが存在する場合、前提条件チェックが実行され、前提条件を満たすために一部のソフトウェアのアップグレードまたはダウングレードが必要になることがあります。
    
    >バージョン 8.0.6 以降、インストーラーには Mobile Foundation 開発サーバーが含まれています。インストール時に、この開発サーバーが他の前提条件と共にインストールされます。開発サーバーのライフサイクル (サーバーの開始と停止など) は、Digital App Builder 内部で処理されます。
    
    ![Digital App Builder のインストール](dab-install-startup.png)

5. **「セットアップの開始」**をクリックします。 これにより、「ご使用条件」の画面が表示されます。

    ![「ご使用条件」画面](dab-install-license.png)

6. ご使用条件に同意し、**「次へ」**をクリックします。 これにより、**「前提条件のインストール」**画面が表示されます。
    >**注**: 既にインストールされている前提ソフトウェアがないかチェックされ、各前提ソフトウェアに対して状況が表示されます。

    ![「前提条件のインストール」画面](dab-install-prereq.png)

7. 前提条件のいずれかが**「インストールされるもの」**状況の場合は、**「インストール」**をクリックして前提ソフトウェアをセットアップします。

    ![「前提条件のインストール」画面](dab-install-prereq-tobeinstalled.png)

8. *オプション* - Digital App Builder はデータ・セットを扱うために Java を必要とするため、前提ソフトウェアがインストールされた後、インストーラーによって JAVA がチェックされます。 
    >**注**: Java がまだインストールされていない場合、Java の手動インストールが必要になることがあります。 Java のインストールについては、[Java のインストール](https://www.java.com/en/download/help/download_options.xml)を参照してください。

9. 必要なソフトウェアがインストールされた後、Digital App Builder の開始画面が表示されます。 **「ビルドの開始」**をクリックします。

    ![Digital App Builder の開始](dab-install-startup-screen.png)

10. *オプション* - インストーラーは、オプションの Xcode (開発中に iOS シミュレーターでアプリケーションをプレビューするために必要。MacOS のみ) および Android Studio (Android アプリケーションをプレビューするために必要。MacOS および Windows) のインストールもチェックします。
    >**注**: Xcode および Android Studio の手動インストールが必要な場合があります。 Cocoapods のインストールについては、[CocoaPods の使用](https://guides.cocoapods.org/using/using-cocoapods)を参照してください。 Android Studio のインストールについては、[Android Studio のインストール](https://developer.android.com/studio/)を参照してください。 

>**注**: 任意の時点で、[前提条件チェック](#prerequisites-check)を実行して、インストール済み環境がアプリケーション開発のために適切であるか検証してください。 エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### Windows でのインストール
{: #installing-on-windows }

1. [IBM パスポート・アドバンテージ](https://www.ibm.com/software/passportadvantage/)または[こちら](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)から、.exe (**IBM.Digital.App.Builder.Setup.n.n.n.exe**。`n.n.n` はバージョン番号) をダウンロードします。
2. ダウンロードした実行可能ファイル (**IBM.Digital.App.Builder.Setup.n.n.n.exe**) を管理モードで実行します。
    >**注**: Digital App Builder の初回インストール時、Digital App Builder は、前提ソフトウェアをインストールするためのインターフェースを開きます。 Digital App Builder の前のバージョンが存在する場合、前提条件チェックが実行され、前提条件を満たすために一部のソフトウェアのアップグレードまたはダウングレードが必要になることがあります。
    
    >バージョン 8.0.6 以降、インストーラーには Mobile Foundation 開発サーバーが含まれています。インストール時に、この開発サーバーが他の前提条件と共にインストールされます。開発サーバーのライフサイクル (サーバーの開始と停止など) は、Digital App Builder 内部で処理されます。

    ![Digital App Builder のインストール](dab-install-startup.png)

3. **「セットアップの開始」**をクリックします。 これにより、「ご使用条件」の画面が表示されます。

    ![「ご使用条件」画面](dab-install-license.png)

4. ご使用条件に同意し、**「次へ」**をクリックします。 これにより、**「前提条件のインストール」**画面が表示されます。
    >**注**: 既にインストールされている前提ソフトウェアがないかチェックされ、各前提ソフトウェアに対して状況が表示されます。

    ![「前提条件のインストール」画面](dab-install-prereq.png)

5. 前提条件のいずれかが**「インストールされるもの」**状況の場合は、**「インストール」**をクリックして前提ソフトウェアをセットアップします。

    ![「前提条件のインストール」画面](dab-install-prereq-tobeinstalled.png)

6. *オプション* - 前提ソフトウェアがインストールされた後、Digital App Builder がデータ・セットを扱うために Java が必要なため、インストーラーは JAVA をチェックします。 
    >**注**: Java がまだインストールされていない場合、Java の手動インストールが必要になることがあります。 Java のインストールについては、[Java のインストール](https://www.java.com/en/download/help/download_options.xml)を参照してください。

7. 前提ソフトウェアがインストールされた後、Digital App Builder の開始画面が表示されます。 **「ビルドの開始」**をクリックします。

    ![Digital App Builder の開始](dab-install-startup-screen.png)

    >**注**: デスクトップの**「スタート」 > 「プログラム」**にショートカットも作成されます。 デフォルトのインストール・フォルダーは、`<AppData>&#xa5;Local&#xa5;IBMDigitalAppBuilder&#xa5;app-8.0.3` です。

8. *オプション* - インストーラーはまた、オプションの Xcode (開発中に iOS シミュレーターでアプリをプレビューするため、MacOS のみ) および Android Studio (Android アプリをプレビューするため、MacOS および Windows) のインストールをチェックします。
    >**注**: Android Studio を手動でインストールしてください。 Android Studio のインストールについては、[Android Studio のインストール](https://developer.android.com/studio/)を参照してください。 

>**注**: 任意の時点で、[前提条件チェック](#prerequisites-check)を実行して、インストール済み環境がアプリケーション開発のために適切であるか検証してください。 エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

### 前提条件チェック
{: #prerequisites-check }

アプリケーションを開発する前に、**「ヘルプ」>「前提条件チェック」**を選択して、前提条件チェックを実行します。

![前提条件チェック](dab-prerequsites-check.png)

エラーが発生した場合は、エラーを修正し、Digital App Builder を再始動してから、アプリケーションを作成してください。

>**注**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) は MacOS でのみ必須です。
