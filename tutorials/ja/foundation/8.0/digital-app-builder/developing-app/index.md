---
layout: tutorial
title: アプリケーションの開発
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #developing-an-app }

アプリケーションの開発では、以下のステップを実行します。

1. アプリケーションを作成します。 [アプリケーションの作成](../getting-started/)のセクションを参照してください。
2. 必要なコントロールを追加して、アプリケーションを設計します。 詳しくは、『[Digital App Builder インターフェース](../dab-interface/)』を参照してください。
3. 必要なサービス (Watson Chat、Watson Visual Recognition、Push Notifications、Data Set、Live Update) をアプリケーションに追加します。
4. 必要に応じて、プラットフォームを追加または変更します。 [『設定』>『アプリケーションの詳細』](../settings/)セクションを参照してください。
5. アプリケーションをプレビューします。 『[シミュレーターを使用したアプリケーションのプレビュー](#preview-the-app-using-the-simulator)』を参照してください。
6. アプリケーションをプレビューした後、エラーの修正後にビルドの準備ができたら、アプリケーションをビルドするための以下のステップを実行します。

    * **Android アプリケーションの場合:**

        a. アプリケーションの作成時に指定したディレクトリーにナビゲートします。

        b. ionic フォルダーに移動します。

        c. **「Platform」>「Android」**に移動します。

        d. Android Studio を開き、**「File」>「Open Project」**に移動します。ステップ c に記載されている android フォルダーを選択します。

        e. プロジェクトをビルドします。 

        >**注**: 公開およびビルドについては、[https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/) のチュートリアルのステップに従ってください。

    * **iOS アプリケーションの場合**:
 
        a. アプリケーションの作成時に指定したディレクトリーにナビゲートします。

        b. ionic フォルダーに移動します。

        c. 「Platform」>「iOS」に移動します。

        d. **Xcode** を開き、プロジェクトをビルドします。 

        >**注**: 公開およびビルドについては、[https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/) のチュートリアルのステップに従ってください。


### アプリケーションのプレビュー
{: #preview-the-app }

選択したチャネルにシミュレーションを接続して、開発したアプリケーションをプレビューできます。

* iOS でアプリケーションをプレビューするには、Apple App Store から **XCode** をダウンロードしてインストールします。
* Android でアプリケーションをプレビューするには、以下のようにします。 
    * Android Studio をインストールし、その指示に従います。 [https://developer.android.com/studio/](https://developer.android.com/studio/)
    * Android 仮想マシンを構成します。 [こちら](https://developer.android.com/studio/releases/emulator)の説明を参照してください。

>**注**: アプリケーションを素早くプレビューするには、「アプリケーションのプレビュー (Preview App)」オプションを選択します。そうすると、新しいウィンドウが開いてアプリケーションが実行されます。 別のプラットフォーム・モデル対応に設定したり、画面方向を変更したりすることもできます。 アプリケーションに加えられた変更は、このプレビュー・ウィンドウでライブに反映されます。

>**注**: 「File」>「Export to Code」を選択すると、プロジェクトがコード・モードにエクスポートされます。 (アプリケーション・コードは新規フォルダー内に保存されるので、設計モードは妨害されません。) コード・モードにエクスポートした後に、エクスポートされたプロジェクトを設計モードで開くことはできません。
