---
layout: tutorial
title: トラブルシューティング
weight: 19
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #troubleshooting }

IBM Digital App Builder の使用中に発生する可能性があるいくつかの問題には、解決策があります。

* エラーが発生した場合は、以下を参照してください。

    * 以下の各プラットフォームのフォルダー・パスの `log.log` ファイル:

        * mac OS の場合: `~/Library/Logs/IBM Digital App Builder/log.log`

        * Windows の場合: `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`

    * `<APP LOCATION>/ibm/applog.log` にある、アプリケーション関連のログ `applog.log`。

* swagger ファイルを使用してマイクロサービスのデータ・セットを作成できない

    このビルダーを初めて使用しているユーザーの場合、ネットワーク待ち時間が原因でマイクロサービスの作成が失敗することがあります。
    これを回避するには、以下のステップに従います。
    1. コマンド・プロンプトを開き、アプリケーションのインストール済みロケーションに移動します。
    2. `cd ibm\adapterGenerator`
    3. 以下のコマンドを実行します。
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. 上記のコマンドが正常に実行されると、Digital App Builder からのマイクロサービス (swagger ファイル) の使用を開始できます。

* Windows でアプリケーションをプレビューできない

    Digital App Builder で、**「設定」>「プロジェクトの修復」**に移動し、**「依存関係の再ビルド」**ボタンおよび**「プラットフォームの再ビルド」**ボタンをクリックします。

* Android アプリケーションが、リスト・コンポーネントをアプリケーションに追加した後に機能しない

    これは、Android WebView バージョンが 68.X.XXXX.XX 未満であるためです。 これを解決するには、Android WebView バージョンを 68.X.XXXX.XX 以上にアップグレードしてください。

* MacOS で、Android シミュレーターでのアプリケーションのプレビューが失敗してアプリケーションが異常終了する。 以下のエラーが発生する:

    `java.lang.RuntimeException: Unable to create application com.ibm.MFPApplication: java.lang.RuntimeException: Client configuration file mfpclient.properties not found in application assets. Use the MFP CLI command 'mfpdev app register' to create the file.`

    これを解決するには、端末からアプリケーション ionic ディレクトリーにナビゲートし、以下のコマンドを実行します。

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    次に、再度 Digital App Builder からプレビューします。

* swagger json/yaml ファイルのインポート時にアダプターを生成できない

    swagger json/yaml ファイルのインポート時にエラーが発生します。このエラーの原因は、Maven の依存関係です。

    理想的には、すべての Maven 依存関係は、存在しなければ、背後でダウンロードしてインストールされます。 しかし、複数の Maven バージョンがシステムに存在していることが原因で、Maven が失敗することがあります。 この問題を解決するには、以下のステップに従います。

    a. アプリのロケーションに移動し、OS に応じて execute.sh / execute.bat ファイルを開きます。 (`<APP_LOCATION>&#xa5;ibm&#xa5;adapterGenerator`)

    b. すべての `call %MAVEN_HOME% clean install` を `call %MAVEN_HOME% -U clean install` に編集します。

        `-U` を追加すると、POM ファイルに基づいて更新する必要がある外部依存関係を検査するように maven を強制できます。

* Android Studio がインストールされている場合でも、Android Studio の前提条件のチェックは失敗します。

    パスに Android 実行可能プログラム (`<path to android sdk>/tools`) が含まれるようにし、前提条件を確認します。

* Windows 7 でのアプリの作成とプレビューの問題

    `C:` 以外の別のディスク・ドライブの場所に新しいアプリを作成しようとすると、エラーが発生することがあります。

    ドライブ `C://<your folder name/app name>` の下にアプリケーション・プロジェクトを作成するようにしてください。

* Digital App Builder が赤い画面で異常終了する。

    赤い画面で異常終了した場合、以下の場所にあるログを確認してください。
    * MacOS- `/Users/<username>/Library/Logs/IBM Digital App Builder/log.log`
    * Windows - `C:&#xa5;&#xa5;Users&#xa5;<username>&#xa5;AppData&#xa5;Roming&#xa5;IBM Digital App Builder&#xa5;log.log`

    エラーが `rendered.js` の `getPath` に関するものである場合、それは、既知の [electron の問題](https://github.com/electron/electron/issues/8205)です。

    これはランダムに発生します。

    Digital App Builder を再始動してください。通常、これでシナリオは機能します。
