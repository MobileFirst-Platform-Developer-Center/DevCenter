---
layout: tutorial
title: 更新のための IBM Installation Manager の実行
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## グラフィカル・モードでの Installation Manager の実行
{: #graphical-mode}

* 初期インストール時に使用したユーザー・アカウントから Installation Manager を実行します。
  アップデートを適用するには、初期インストール時に使用したのと同じレジストリー・ファイルのリストを使用して Installation Manager を実行する必要があります。インストールされたソフトウェアとインストール中に使用されたオプションのリストが、それらのレジストリー・ファイルに保管されます。管理者モードで Installation Manager を実行すると、レジストリー・ファイルはシステム・レベルでインストールされます。UNIX または Linux では `/var` フォルダー内です。Windows では `c:\ProgramData` フォルダー内です。この場所は、Installation Manager を実行するユーザーとは無関係です (ただし、UNIX および Linux では root が必要です)。ただし、シングル・ユーザー・モードで Installation Manager を実行した場合、レジストリー・ファイルはデフォルトでユーザーのホーム・ディレクトリーに保管されます。

* **「ファイル」>「設定」**を選択します。既存の IBM MobileFirst Platform Foundation V8.0.0 を更新する (フィックスパックまたは暫定修正を適用する) 予定の場合、製品のリポジトリーは必要ありません。

* **「OK」**をクリックして**「設定」**表示を閉じます。

* **「更新」**をクリックし、更新する必要のあるパッケージを選択します。Installation Manager によってパッケージのリストが表示されます。デフォルトでは、更新するパッケージの名前は IBM MobileFirst Platform Server です。

* ライセンス条項に同意し、**「次へ」**をクリックします。

* **「ありがとうございました」**パネルで**「次へ」**をクリックします。要約が表示されます。

* **「更新」**をクリックして更新プロシージャーを開始します。

## コマンド・ライン・モードでの Installation Manager の実行
{: #cli-mode}

1. サイレント・インストール・ファイルを[ここ](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip)からダウンロードします。

2. ファイルを解凍し、`8.0/upgrade-initially-mfpserver.xml` ファイルを選択します。
  - 最初にインストールしたのが V6.0.0、V6.1.0、または V6.2.0 の製品だった場合、代わりに `8.0/upgrade-initially-worklightv6.xmlfile` を選択してください。
  - 最初にインストールしたのが V5.x の製品だった場合、代わりに `8.0/upgrade-initially-worklightv5.xml` ファイルを選択してください。このファイルには、製品のプロファイル ID が含まれています。この ID のデフォルト値は、製品のリリースが進むにつれて変更されています。V5.x では、Worklight です。V6.0.0、V6.1.0、および V6.2.0 では、IBM Worklight です。V6.3.0、V7.0.0、V7.1.0、および V8.0.0 では、IBM MobileFirst Platform Server です。

3. 選択したファイルのコピーを作成します。

4. テキスト・エディターまたは XML エディターで、コピーした XML ファイルを開きます。以下のエレメントを変更します。

   a. リポジトリー・リストを定義する repository エレメント。既存の IBM MobileFirst Platform Foundation V8.0.0 を更新する (フィックスパックまたは暫定修正を適用する) 予定であるため、製品のリポジトリーは必要ありません。

   b. **オプション:** データベースおよびアプリケーション・サーバーのパスワードを更新します。
      Installation Manager での初期インストール時に Application Center がインストールされ、データベースまたはアプリケーション・サーバーのパスワードが変更された場合、XML ファイル内の値を変更できます。これらのパスワードの使用目的は、データベースのスキーマのバージョンが正しいことを検証し、V8.0.0 よりも古いバージョンの場合はアップグレードすることです。また、WebSphere Application Server フル・プロファイルへの Application Center のインストールのために **wsadmin** を実行するためにも使用されます。XML ファイル内の適切な行のコメントを外します。
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. 2015 年 9 月 15 日以降の暫定修正でリリースされたトークン・ライセンスをアクティブ化するという選択を以前に行っていない場合、行 `<data key=’user.licensed.by.tokens’ value=’false’/>` のコメントを外します。Rational License Key Server でトークン・ライセンスを使用する契約がある場合、値を **true** に設定します。それ以外の場合は、値を **false** に設定します。
      トークン・ライセンスをアクティブ化する場合、Rational License Key Server が構成されていること、および、MobileFirst Server およびそれを利用するアプリケーションを実行するための十分なトークンを取得できることを確認してください。そうでない場合、MobileFirst Server 管理アプリケーションおよびランタイム環境は実行できません。
      > **制約事項:** トークン・ライセンスをアクティブ化するかどうかの決定を後で変更することはできません。値 **true** を指定してアップグレードを実行し、後で値 **false** でもう一度アップグレードを実行すると、2 番目のアップグレードは失敗します。

    d. プロファイル ID およびインストール場所を検討します。プロファイル ID およびインストール場所は、インストール対象と一致している必要があります。
      * この行: `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * およびこの行: `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Installation Manager に認識されているプロファイル ID およびインストール・ディレクトリーをレビューするには、次のコマンドを入力します。
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. version 属性を更新して、暫定修正のバージョンに設定します。
       例えば、暫定修正 (8.0.0.0-MFPF-IF20171006-1725) をインストールする場合、

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      を次で置き換えます。

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager は、インストール・ファイル内にリストされたリポジトリーを使用するだけでなく、Installation Manager の設定でインストールされるリポジトリーも使用します。offering エレメントの version 属性の指定はオプションです。ただし、これを指定することによって、それで定義した暫定修正がインストールするバージョンであることを確実に指定できます。この指定は、Installation Manager の設定にリストされた暫定修正を含んでいる他のリポジトリーに優先します。

5. 初期インストール時に使用したユーザー・アカウントでセッションを開きます。
    アップデートを適用するには、初期インストール時に使用したのと同じレジストリー・ファイルのリストを使用して Installation Manager を実行する必要があります。インストールされたソフトウェアとインストール中に使用されたオプションのリストが、それらのレジストリー・ファイルに保管されます。管理者モードで Installation Manager を実行すると、レジストリー・ファイルはシステム・レベルでインストールされます。UNIX または Linux では `/var` フォルダー内です。Windows では `c:\ProgramData` フォルダー内です。この場所は、Installation Manager を実行するユーザーとは無関係です (ただし、UNIX および Linux では root が必要です)。ただし、シングル・ユーザー・モードで Installation Manager を実行した場合、レジストリー・ファイルはデフォルトでユーザーのホーム・ディレクトリーに保管されます。

6. 次のコマンドを実行します。
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   各部の意味は以下のとおりです。
   * <responseFile> は、ステップ 4 で編集した XML ファイルです。
   * *-log /tmp/installwl.log* はオプションです。これは、Installation Manager の出力のログ・ファイルを指定します。
   * *-acceptLicense* は必須です。これは、IBM MobileFirst Platform Foundation V8.0.0 のライセンス条項に同意することを意味します。このオプションがないと、Installation Manager は更新を進めることができません。

## 次のステップ
{: #next-steps }

[アプリケーション・サーバーの更新](../appserver-update)
