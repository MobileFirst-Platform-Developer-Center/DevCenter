---
layout: tutorial
title: IBM Application Center を使用したモバイル・アプリケーションの配布
relevantTo: [ios,android,windows8,cordova]
show_in_nav: false
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_app_center_full }} は、公開アプリケーション・ストアに似た**モバイル・アプリケーションのリポジトリー **ですが、組織やチームのニーズに焦点を置いています。これは専用アプリケーション・ストアです。

Application Center を使用すると、簡単にモバイル・アプリケーションを共有できます。

* **フィードバックおよび評価情報の共有**を行うことができます。  
* アプリケーションをインストールできるユーザーを制限するためにアクセス制御リストを使用できます。

Application Center は、{{ site.data.keys.product_adj }} アプリケーションおよび非 {{ site.data.keys.product_adj }} アプリケーションと連携し、**iOS、Android**、**BlackBerry 6/7**、および **Windows/Phone 8.x** の各種アプリケーションをすべてサポートします。

> **注:** iOS アプリケーションのストアへの提出および検証のために Test Flight または iTunes Connect を使用して生成されたアーカイブ・ファイルおよび IPA ファイルにより、ランタイムの異常終了や失敗が発生する場合があります。詳細については、ブログ[『Preparing iOS apps for App Store submission in IBM MobileFirst Foundation 8.0』](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/)をご覧ください。

Application Center はさまざまな状況で使用できます。例えば、以下があります。 

* 組織全体の企業アプリケーション・ストアとして。
* 開発中、チーム内にアプリケーションを配布するため。

> **注:** iOS AppCenter Installer アプリケーションのビルドには、MobileFirst 7.1 が必要です。

#### ジャンプ先
{: #jump-to}
* [インストールおよび構成](#installing-and-configuring)
* [Cordova ベースの IBM AppCenter クライアント](#cordova-based-ibm-appcenter-client)
* [モバイル・クライアントの準備](#preparing-mobile-clients)
* [Application Center コンソールでのアプリケーションの管理](#managing-applications-in-the-application-center-console)
* [Application Center モバイル・クライアント](#the-application-center-mobile-client)
* [Application Center コマンド・ライン・ツール](#application-center-command-line-tools)

## インストールおよび構成
{: #installing-and-configuring }
Application Center は、IBM Installation Manager によって {{ site.data.keys.mf_server }} のインストールの一部としてインストールされます。

**前提条件:** Application Center をインストールする前に、アプリケーション・サーバーおよびデータベースをインストールしておく必要があります。

* アプリケーション・サーバー: Tomcat、または WebSphere Application Server フル・プロファイルまたは Liberty プロファイル
* データベース: DB2、Oracle、または MySQL

データベースをインストールしていない場合は、インストール・プロセスで Apache Derby データベースをインストールすることもできます。ただし、Derby データベースの使用は実動シナリオでは推奨されません。

1. IBM Installation Manager に従って、データベースおよびアプリケーション・サーバーを選択して Application Center をインストールします。

    > 詳しくは、トピック[『{{ site.data.keys.mf_server }} のインストール』](../../installation-configuration)を参照してください。

    iOS 7.1 は https プロトコルのみをサポートしているため、iOS 7.1 以降を実行するデバイス用のアプリケーションを配布することを計画している場合は、Application Center サーバーを SSL (少なくとも TLS v.1) で保護する必要があります。自己署名証明書は推奨されませんが、自己署名 CA 証明書がデバイスに配布されている場合は、テストの目的で使用できます。

2. Application Center が IBM Installation Manager を使用してインストールされた後に、コンソール `http://localhost:9080/appcenterconsole` を開きます。

3. ユーザー/パスワードの組み合わせ demo/demo を使用してログインします。

4. この時点で、ユーザー認証を構成できます。例えば、LDAP リポジトリーに接続できます。

    > 詳しくは、トピック[『インストール後の Application Center の構成』](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation)を参照してください。

5. Android、iOS、BlackBerry 6/7、および Windows Phone 8 用にモバイル・クライアントを準備します。

モバイル・クライアントは、カタログの参照およびアプリケーションのインストールに使用するモバイル・アプリケーションです。

> **注:** 実動インストールの場合は、提供されている Ant タスクを実行して Application Center をインストールすることを検討してください。これにより、サーバーへの更新を Application Center への更新から分離できるようになります。

## Cordova ベースの IBM AppCenter クライアント
{: #cordova-based-ibm-appcenter-client }
Cordova ベースの AppCenter クライアント・プロジェクトは、**install_dir/ApplicationCenter/installer/CordovaAppCenterClient** の `install` ディレクトリーにあります。

このプロジェクトは、Cordova フレームワークのみに基づいており、{{ site.data.keys.product }} クライアント/サーバー API にまったく依存していません。  
これは標準 Cordova アプリケーションであるため、{{ site.data.keys.mf_studio }} にも依存していません。このアプリケーションは、UI には Dojo を使用します。

以下の手順に従って開始してください。

1. Cordova をインストールします。

```bash
npm install -g cordova@latest
```

2. Android SDK をインストールし、`ANDROID_HOME` を設定します。  
3. このプロジェクトをビルドし、実行します。

すべてのプラットフォームのビルド:

```bash
cordova build
```

Android のみのビルド:

```bash
cordova build android
```

iOS のみのビルド:

```bash
cordova build ios
```

### AppCenter Installer アプリケーションのカスタマイズ
{: #customizing-appcenter-installer-application }
特定の企業またはニーズに合わせてユーザー・インターフェースを更新するなど、さらにアプリケーションをカスタマイズできます。

> **注:** アプリケーションの UI および動作を自由にカスタマイズできる一方、このような変更は IBM によるサポート契約の対象外です。

#### Android
{: #android }
* Android Studio を開きます。
* **「Import project (Eclipse ADT, Gradle, etc.)」**を選択します。
* **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android** から android フォルダーを選択します。

これには時間がかかる場合があります。これが行われた後、カスタマイズする準備が整います。

> **注:** ポップアップ・ウィンドウに表示される Gradle バージョンのアップグレードのための更新オプションはスキップすることを選択してください。このバージョンについては、`grade-wrapper.properties` を参照してください。

#### iOS
{: #ios }
* **install_dir/ApplicationCenter/installer/CordovaAppCenterClient/platforms** に進みます。
* **IBMAppCenterClient.xcodeproj** ファイルをクリックして開くと、プロジェクトが Xcode で開かれ、カスタマイズする準備が整います。

## モバイル・クライアントの準備
{: #preparing-mobile-clients }
### Android 電話およびタブレットの場合
{: #for-android-phones-and-tablets }
モバイル・クライアントは、コンパイル済みアプリケーション (APK) として配布され、**install_dir/ApplicationCenter/installer/IBMApplicationCenter.apk** にあります。

> **注:** Android および iOS の AppCenter クライアントのビルドに Cordova フレームワークを使用する場合は、[『Cordova ベースの IBM AppCenter クライアント』](#cordova-based-ibm-appcenter-client)を参照してください。

### iPad および iPhone の場合
{: #for-ipad-and-iphone }
1. ソース・コードで提供されているクライアント・アプリケーションをコンパイルし、それに署名します。これは必須です。

2. MobileFirst Studio で、**install\_dir/ApplicationCenter/installer** にある IBMAppCenter プロジェクトを開きます。

3. **「実行 (Run As)」→「MobileFirst Development Server 上で実行 (Run on MobileFirst Development Server)」**を使用して、プロジェクトをビルドします。

4. Xcode を使用して、Apple iOS 企業プロファイルを使用してアプリケーションをビルドし、それに署名します。  
結果のネイティブ・プロジェクト (**iphone\native** 内にあります) を Xcode で手動で開くか、iPhone フォルダーを右クリックして**「実行 (Run As)」→「Xcode プロジェクト (Xcode project)」**を選択します。このアクションにより、プロジェクトが生成され、Xcode で開きます。

> **注:** Android および iOS の AppCenter クライアントのビルドに Cordova フレームワークを使用する場合は、[『Cordova ベースの IBM AppCenter クライアント』](#cordova-based-ibm-appcenter-client)を参照してください。

### Blackberry の場合
{: #for-blackberry }
* BlackBerry バージョンをビルドするには、BlackBerry Eclipse IDE (または BlackBerry Java プラグインがインストールされた Eclipse) と BlackBerry SDK 6.0 が必要です。BlackBerry SDK 6.0 でコンパイルすると、アプリケーションは BlackBerry OS 7 上でも実行されます。

BlackBerry プロジェクトは、**install\_dir/ApplicationCenter/installer/IBMAppCenterBlackBerry6** 内にあります。

### Windows Phone 8 の場合
{: #for-windows-phone-8}
1.  Microsoft に企業アカウントを登録します。  
Application Center は、企業アカウントに付随する企業証明書を使用して署名された企業アプリケーションのみを管理します。

2. モバイル・クライアントの Windows Phone バージョンは、**install\_dir/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap** に含まれています。

* Application Center モバイル・クライアントもこの企業証明書を使用して署名されていることを確認してください。

* デバイスに企業アプリケーションをインストールするには、まず企業登録トークンをインストールして、デバイスをその企業で登録します。

> 企業アカウントおよび登録トークンについて詳しくは、[Microsoft Developer Web サイト→「Windows Phone 用の自社アプリの配布」](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).aspx) ページを参照してください。

> Windows Phone モバイル・クライアント・アプリケーションの署名方法について詳しくは、[Microsoft Developer Web サイト](http://dev.windows.com/en-us/develop)を参照してください。

<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:**  未署名の `.xap` ファイルを直接使用することは**できません**。デバイスにこのファイルをインストールする前に、事前に、Symantec または Microsoft から取得した企業証明書を使用してファイルに署名する必要があります。

### Windows Store Apps for Windows 8.1 Pro の場合
{: #for-windows-store-apps-for-windows-81-pro }
* **install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** ファイルには、Application Center クライアントの実行可能ファイルが含まれています。このファイルをクライアント・コンピューターに配布し、unzip します。これには、実行可能プログラムが含まれています。

* Microsoft Windows Store を使用せずに、Windows Store アプリ (タイプ `appx` のファイル) をインストールすることは、アプリケーションの<em>サイドローディング</em> と呼ばれます。アプリケーションをサイドローディングするには、[アプリケーションのサイドローディングの準備 (Prepare to Sideload Apps)](https://technet.microsoft.com/fr-fr/library/dn613842.aspx. The Windows 8.1.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading Store Apps to Windows 8.1.1 Devices]( http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx) の前提条件に従う必要があります。

## Application Center コンソールでのアプリケーションの管理
{: #managing-applications-in-the-application-center-console }
![Application Center でのアプリケーション管理のイメージ]({{ site.baseurl }}/assets/backup/overview1.png)

Application Center コンソールを使用して、以下の方法でカタログ内でアプリケーションを管理します。

* アプリケーションの追加および削除
* アプリケーションのバージョン管理    
* アプリケーションの詳細の閲覧
* 特定のユーザーまたはユーザーのグループへのアプリケーションのアクセス権限の制限
* 各アプリケーションのレビューを読む
* 登録ユーザーおよびデバイスの確認

### ストアへの新規アプリケーションの追加
{: #adding-new-applications-to-the-store }
![App Center にアプリケーションを追加するイメージ]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

ストアに新規アプリケーションを追加するには、以下のようにします。

1. Application Center コンソールを開きます。
2. **「アプリケーションの追加 (Add Application)」**をクリックします。
3. アプリケーション・ファイルを選択します。
    * `.ipa`: iOS
    * `.apk`: Android
    * `.zip`: BlackBerry 6/7
    * `.xap`: Windows Phone 8.x
    * `.appx`: Windows Store 8.x

* **「次へ」**をクリックします。

    「アプリケーション詳細」ビューで、新規アプリケーションについての情報を確認し、説明などの情報をさらに入力できます。カタログ内のすべてのアプリケーションについて、後でこのビューに戻ることができます。

    ![「アプリケーション詳細」画面のイメージ]({{ site.baseurl }}/assets/backup/appDetails1.png)

* **「終了」**をクリックしてタスクを終了します。

新規アプリケーションがストアに追加されます。

![App Center でのアクセス制御のイメージ]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)

デフォルトでは、アプリケーションをインストールできるのはストアの許可ユーザーです。

### ユーザーのグループにアクセス権限を制限
{: #restricting-access-to-a-group-of-users }
ユーザーのグループにアクセス権限を制限するには、以下のようにします。

1. カタログ・ビューで、アプリケーション名の隣の**無制限リンク**をクリックします。「アクセス制御のインストール (Installation Access Control)」ページが開きます。
2. **「アクセス制御使用可能 (Access control enabled)」**を選択します。これで、アプリケーションをインストールすることが許可されているユーザーまたはグループのリストを入力できます。
3. LDAP を構成済みの場合は、LDAP リポジトリーに定義されているユーザーおよびグループを追加します。

Google Play や Apple App Store などの公開アプリケーション・ストアのアプリケーションの URL を入力して、それらを追加することもできます。

## Application Center モバイル・クライアント
{: #the-application-center-mobile-client }
Application Center モバイル・クライアントは、デバイス上のアプリケーションを管理するためのモバイル・アプリケーションです。このモバイル・クライアントを使用して、以下を行うことができます。

* カタログ内のすべてのアプリケーション (アクセス権限を持っているもの) のリスト作成。
* お気に入りのアプリケーションのリスト作成。
* アプリケーションのインストールや新規バージョンへのアップグレード。
* アプリケーションに関するフィードバックおよび 5 つ星の評価を提供。

### カタログへのモバイル・クライアント・アプリケーションの追加
{: #adding-mobile-client-applications-to-the-catalog }
Application Center モバイル・クライアント・アプリケーションをカタログに追加する必要があります。

1. Application Center コンソールを開きます。
2. **「アプリケーションの追加 (Add Application)」**ボタンをクリックして、モバイル・クライアントのファイル `.apk`、`.ipa`、`.zip`、または `.xap` を追加します。
3. **「次へ」**をクリックすると、「アプリケーション詳細」ページが開きます。
4. 「アプリケーション詳細」ページで、**「インストーラー」**を選択して、このアプリケーションがモバイル・クライアントであることを指定します。
5. **「終了」**をクリックして、Application Center アプリケーションをカタログに追加します。

Windows 8.1 Pro 向けの Application Center クライアントは、カタログに追加する必要がありません。このクライアントは、**install\_dir/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** ファイル内に含まれている正規の Windows `.exe` プログラムです。クライアント・コンピューターにコピーするだけで済みます。

### Windows Phone 8
{: #windows-phone-8 }
Windows Phone 8 の場合、Application Center コンソールで、企業アカウントを使用して受け取った登録トークンもインストールする必要があります。 この結果、ユーザーがデバイスを登録できるようになります。Application Center の「設定」ページを使用します。このページは、歯車のアイコンを使用して開くことができます。

![Windows Phone 8 アプリケーション登録のイメージ]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

モバイル・クライアントをインストールするには、事前に登録トークンをインストールしてデバイスを企業に登録する必要があります。

1. デバイス上で Web ブラウザーを開きます。
2. 次の URL を入力します。`http://hostname:9080/appcenterconsole/installers.html`
3. ユーザー名とパスワードを入力します。
4. **「トークン」**をクリックすると、登録トークンのリストが開きます。
5. リスト内でその企業を選択します。企業アカウントの詳細が表示されます。
6. **「企業アカウントの追加 (Add Company Account)」**をクリックします。デバイスが登録されます。

### モバイル・デバイスへのモバイル・クライアントのインストール
{: #installing-the-mobile-client-on-the-mobile-device }
モバイル・デバイスにモバイル・クライアントをインストールするには、以下のようにします。
![アプリケーション・インストーラー・アプリケーションのイメージ]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. デバイス上で Web ブラウザーを開きます。
2. 次の URL を入力します。`http://hostname:9080/appcenterconsole/installers.html`
3. ユーザー名とパスワードを入力します。
4. Application Center アプリケーションを選択してインストールを開始します。

**Android** デバイスの場合、Android Download アプリケーションを開き、インストールの対象として**「IBM App Center」**を選択します。

### モバイル・クライアントへのログイン
{: #logging-in-to-the-mobile-client }
モバイル・クライアントにログインするには、以下のようにします。

1. サーバーにアクセスするための資格情報を入力してください。
2. サーバーのホスト名または IP アドレスを入力します。
3. ポート番号がデフォルトのもの (`9080`) でない場合は、**「サーバー・ポート」**フィールドに、ポート番号を入力します。
4. **「アプリケーション・コンテキスト」**フィールドにコンテキスト `applicationcenter` を入力します。

![「ログイン」画面]({{ site.baseurl }}/assets/backup/login.png)

### Application Center モバイル・クライアント・ビュー
{: #application-center-mobile-client-views }
* **「カタログ」**ビューには、使用可能なアプリケーションのリストが表示されます。
* アプリケーションを選択すると、アプリケーション上で**「詳細」**ビューが開きます。「詳細」ビューからはアプリケーションをインストールできます。「詳細」ビューで星形のアイコンを使用して、アプリケーションにお気に入りのマークを付けることもできます。

    ![カタログ詳細]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* **「お気に入り」**ビューには、お気に入りのアプリケーションがリストされます。このリストは、特定のユーザーのすべてのデバイス上で使用できます。
* **「更新」**ビューには、使用可能なすべての更新がリストされます。「更新」ビューで、「詳細」ビューにナビゲートできます。より新しいアプリケーション・バージョンを選択することも、使用可能な最新のバージョンを取得することも可能です。Application Center がプッシュ通知を送信するように構成されている場合は、プッシュ通知メッセージによって更新についての通知を受け取る場合があります。

モバイル・クライアントからこのアプリケーションを評価し、レビューを送信できます。レビューは、コンソール上でもモバイル・デバイス上でも閲覧できます。

![レビュー]({{ site.baseurl }}/assets/backup/reviewss.png)

## Application Center コマンド・ライン・ツール
{: #application-center-command-line-tools }
**install_dir/ApplicationCenter/tools** ディレクトリーには、ストア内のアプリケーションを管理するためのコマンド・ライン・ツールまたは Ant タスクを使用するのに必要なすべてのファイルが含まれています。

* `applicationcenterdeploytool.jar`: アップロード・コマンド・ライン・ツール。
* `json4jar`: アップロード・ツールで必要な JSON フォーマットのライブラリー。
* `build.xml`: 1 つのファイルまたは一連のファイルを Application Center にアップロードする際に使用できるサンプル Ant スクリプト。
* `acdeploytool.sh` および `acdeploytool.bat`: `applicationcenterdeploytool.jar` ファイルで Java を呼び出すための簡単なスクリプト。

例えば、アプリケーション `app.apk` ファイルを `localhost:9080/applicationcenter` 内のストアにユーザー ID `demo` およびパスワード  `demo` を使用してデプロイするには、以下を書き込みます。

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
