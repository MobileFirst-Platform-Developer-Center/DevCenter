---
layout: tutorial
title: モバイル・クライアントを使用するための準備
breadcrumb_title: 準備
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
AppCenter Installer アプリケーションは、モバイル・デバイスにアプリケーションをインストールするために使用されます。提供されている Cordova プロジェクト、Visual Studio プロジェクト、MobileFirst Studio プロジェクトのいずれかを使用してこのアプリケーションを生成することも、Android、iOS、または Windows 8 Universal 用の MobileFirst Studio プロジェクトの事前ビルド・バージョンを直接使用することもできます。

#### ジャンプ先
{: #jump-to }
* [前提条件](#prerequisites)
* [Cordova ベースの IBM AppCenter クライアント](#cordova-based-ibm-appcenter-client)
* [MobileFirst Studio ベースの IBM AppCenter クライアント](#mobilefirst-studio-based-ibm-appcenter-client)
* [フィーチャーのカスタマイズ (エキスパート向け): Android、iOS、Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [Application Center でのモバイル・クライアントのデプロイ](#deploying-the-mobile-client)

## 前提条件
{: #prerequisites }
### Android オペレーティング・システム固有の前提条件
{: #prerequisites-specific-to-the-android-operating-system }
モバイル・クライアントのネイティブ Android バージョンは、Android アプリケーション・パッケージ (.apk) ファイルの形でソフトウェア配信に組み込まれます。**IBMApplicationCenter.apk** ファイルがディレクトリー **ApplicationCenter/installer** に入っています。プッシュ通知は使用不可です。プッシュ通知を使用可能にしたい場合は、.apk ファイルを再ビルドする必要があります。Application Center でのプッシュ通知について詳しくは、[『アプリケーション更新のプッシュ通知』](../push-notifications)を参照してください。

Android バージョンをビルドするには、Android 開発ツールの最新バージョンが必要です。

### Apple iOS オペレーティング・システム固有の前提条件
{: #prerequisites-specific-to-apple-ios-operating-system }
iPad および iPhone のネイティブ iOS バージョンはコンパイル済みアプリケーションとして配信されません。**IBMAppCenter** という名前の {{ site.data.keys.product_full }} プロジェクトからそのアプリケーションを作成する必要があります。このプロジェクトは、**ApplicationCenter/installer** ディレクトリーの配布の一部としても配信されます。

iOS バージョンをビルドするには、適切な {{ site.data.keys.product_full }} および Apple ソフトウェアが必要です。{{ site.data.keys.mf_studio }} のバージョンは、この資料の基礎となっている {{ site.data.keys.mf_server }} のバージョンと同じでなければなりません。Apple Xcode のバージョンは V6.1 です。

### Microsoft Windows Phone オペレーティング・システム固有の前提条件
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
モバイル・クライアントの Windows Phone バージョンは、未署名の Windows Phone アプリケーション・パッケージ (.xap) ファイルとしてソフトウェア配信に組み込まれます。**IBMApplicationCenterUnsigned.xap** ファイルが **ApplicationCenter/installer** ディレクトリーに入っています。

> **重要:** 未署名の .xap ファイルを直接使用することはできません。これをデバイスにインストールする前に、Symantec/Microsoft から取得した企業証明書を使用してこれに署名する必要があります。



オプション: 必要なら、Windows Phone バージョンをソースからビルドすることもできます。そのためには、Microsoft Visual Studio の最新バージョンが必要です。

### Microsoft Windows 8 オペレーティング・システム固有の前提条件
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
モバイル・クライアントの Windows 8 バージョンは、.zip アーカイブ・ファイルとして組み込まれます。**IBMApplicationCenterWindowsStore.zip** ファイルには、実行可能ファイル (.exe) および依存するダイナミック・リンク・ライブラリー (.dll) ファイルが含まれます。このアーカイブの内容を使用するには、ローカル・ドライブのあるロケーションにアーカイブをダウンロードしてから実行可能ファイルを実行します。

オプション: 必要なら、Windows 8 バージョンをソースからビルドすることもできます。そのためには、Microsoft Visual Studio の最新バージョンが必要です。

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

## MobileFirst Studio ベースの IBM AppCenter クライアント
{: #mobilefirst-studio-based-ibm-appcenter-client }
iOS および Android 用の Cordova プロジェクトを使用する代わりに、App Center クライアント・アプリケーションの以前のリリースを使用することを選択することもできます。これは、MobileFirst Studio 7.1 に基づいており、iOS、Android、および Windows Phone をサポートします。

### プロジェクトのインポートとビルド (Android、iOS、Windows Phone)
{: #importing-and-building-the-project-android-ios-windows-phone }
**IBMAppCenter** プロジェクトを {{ site.data.keys.mf_studio }} にインポートし、インポートしたプロジェクトをビルドする必要があります。

> **注:** V8.0.0 の場合は、MobileFirst Studio 7.1 を使用してください。MobileFirst Studio は[「ダウンロード」ページ]({{site.baseurl}}/downloads)からダウンロードできます。インストール手順については、7.1 の IBM Knowledge Center の [MobileFirst Studio のインストール](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html)を参照してください。



1. **「ファイル」→「インポート」**を選択します。
2. **「一般 (General)」→「既存のプロジェクトをワークスペースへ (Existing Project into Workspace)」**を選択します。
3. 次のページで、**「ルート・ディレクトリーの選択 (Select root directory)」**を選択し、**「IBMAppCenter」**プロジェクトのルートを見つけます。
4. **「IBMAppCenter プロジェクト」**を選択します。
5. **「プロジェクトをワークスペースにコピー」**を選択します。この選択により、プロジェクトのコピーがワークスペースに作成されます。 UNIX システムでは、IBMAppCenter プロジェクトは元の場所でしか読み取られないので、プロジェクトをワークスペースにコピーすることでファイル許可の問題が回避されます。
6. **「完了」**をクリックすると、**IBMAppCenter** プロジェクトが MobileFirst Studio にインポートされます。

**IBMAppCenter** プロジェクトをビルドします。MobileFirst プロジェクトには、**AppCenter** という名前のアプリケーションが 1 つだけ入っています。このアプリケーションを右クリックし、**「実行 (Run as)」→「すべての環境をビルド (Build All Environments)」**を選択します。

#### Android でのプロジェクトのインポートとビルド
{: #importing-building-projects-android }
MobileFirst Studio は、ネイティブの Android プロジェクトを **IBMAppCenter/apps/AppCenter/android/native** に生成します。ネイティブの Android 開発ツール (ADT) プロジェクトが android/native フォルダーに入っています。この ADT ツールを使用して、このプロジェクトをコンパイルし、それに署名することができます。このプロジェクトを使用するには Android SDK レベル 16 をインストールする必要があります。その結果生じる APK は 2.3 以降のすべての Android バージョンと互換性があります。このプロジェクトのビルド時にこれより高いレベルの Android SDK を選択すると、結果の APK は Android バージョン 2.3 と非互換になります。

モバイル・クライアント・アプリケーションに影響する詳細な Android 情報については、[開発者向けの Android サイト](https://developer.android.com/index.html)を参照してください。

アプリケーション更新に対してプッシュ通知を使用可能にしたい場合は、まず Application Center クライアント・プロパティーを構成する必要があります。[アプリケーション更新のためのプッシュ通知の構成](../push-notifications)を参照してください。

#### iOS でのプロジェクトのインポートとビルド
{: #importing-building-projects-ios }
MobileFirst Studio は、ネイティブの iOS プロジェクトを **IBMAppCenter/apps/AppCenter/iphone/native** に生成します。**IBMAppCenterAppCenterIphone.xcodeproj** ファイルが iphone/native フォルダーに入っています。このファイルは、Xcode を使用してコンパイルと署名を行う必要がある Xcode プロジェクトです。

iOS モバイル・クライアント・アプリケーションに署名する方法についてさらに学ぶためには、[Apple 開発者サイト](https://developer.apple.com/)を参照してください。iOS アプリケーションに署名するためには、そのアプリケーションのバンドル ID を、ご使用のプロビジョニング・プロファイルと一緒に使用できるバンドル ID に変更する必要があります。値は Xcode プロジェクト設定で **com.your\_internet\_domain\_name.appcenter** と定義されています。ここで、**your\_internet\_domain\_name** は、ご自分のインターネット・ドメインの名前です。

アプリケーション更新に対してプッシュ通知を使用可能にしたい場合は、まず Application Center クライアント・プロパティーを構成する必要があります。[アプリケーション更新のためのプッシュ通知の構成](../push-notifications)を参照してください。

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio は、ネイティブの Windows Phone 8 プロジェクトを **IBMAppCenter/apps/AppCenter/windowsphone8/native** に生成します。**AppCenter.csproj** ファイルが windowsphone8/native フォルダーに入っています。このファイルは、Visual Studio および Windows Phone 8.0 SDK を使用してコンパイルを行う必要がある Visual Studio プロジェクトです。

このアプリケーションは、Windows Phone 8.0 および 8.1 のデバイスで実行できるように、[Windows Phone 8.0 SDK](https://www.microsoft.com/en-in/download/details.aspx?id=35471) でビルドされています。Windows Phone 8.1 SDK でビルドすると、それより前の Windows Phone 8.0 のデバイスでは実行できなくなるため、Windows Phone 8.1 SDK ではビルドされていません。

Visual Studio 2013 をインストールすると、Windows Phone 8.1 SDK に加えて 8.0 SDK のインストールを選択できるようになります。Windows Phone 8.0 SDK は、[Windows Phone SDK Archives](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive) からも入手可能です。

Windows Phone モバイル・クライアント・アプリケーションをビルドして、それに署名する方法についてさらに学ぶためには、[Windows Phone Dev Center](https://developer.microsoft.com/en-us) を参照してください。

#### Microsoft Windows 8: プロジェクトのビルド
{: #microsoft-windows-8-building-the-project }
Windows 8 Universal プロジェクトは、Visual Studio プロジェクトとして提供され、**IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj.** にあります。  
Microsoft Visual Studio 2013 でクライアント・プロジェクトをビルドしてから配布する必要があります。

プロジェクトのビルドは、ユーザーへの配布の前提条件ですが、Windows 8 アプリケーションは、後で配布するために Application Center にデプロイすることを意図していません。

Windows 8 プロジェクトをビルドするには、次のようにします。

1. Microsoft Visual Studio 2013 で **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** という名前の Visual Studio プロジェクト・ファイルを開きます。
2. アプリケーションのフルビルドを実行します。

Application Center のユーザーにモバイル・クライアントを配布するには、生成された実行可能 (.exe) ファイルおよび依存するダイナミック・リンク・ライブラリー (.dll) ファイルをインストールするインストーラーを後で生成できます。代わりに、これらのファイルをインストーラーに含めずに提供することもできます。

####  Microsoft Windows 10 Universal (ネイティブ) IBM AppCenter クライアント
{: #microsoft-windows-10-universal-(native)-ibm-appcenter-client}

ネイティブ Windows 10 Universal IBM AppCenter クライアントを使用して、Windows 10 Universal アプリケーションを Windows 10 Phone にインストールできます。Windows デスクトップに Windows 10 アプリケーションをインストールする場合は、**IBMApplicationCenterWindowsStore** を使用します。

#### Microsoft Windows 10 Universal: プロジェクトのビルド
{: #microsoft-windows-10-universal-building-the-project}

Windows 10 Universal プロジェクトは、Visual Studio プロジェクトとして提供され、**IBMAppCenterUWP\IBMAppCenterUWP.csproj** にあります。             
Microsoft Visual Studio 2015 でクライアント・プロジェクトをビルドしてから配布する必要があります。
>プロジェクトのビルドは、ユーザーに配布する前の前提条件です。

Windows 10 Universal プロジェクトをビルドするには、以下のステップを実行します。
1.  Microsoft Visual Studio 2015 で **IBMAppCenterUWP\IBMAppCenterUWP.csproj** という名前の Visual Studio プロジェクト・ファイルを開きます。
+ アプリケーションのフルビルドを実行します。
+ 以下のステップを使用して、**.appx** ファイルを生成します。
  * プロジェクトを右クリックし、**「ストア」 → 「アプリケーション・パッケージの作成 (Create App Packages)」**を選択します。

## フィーチャーのカスタマイズ (エキスパート向け): Android、iOS、Windows Phone
{: #customizing-features-for-experts-android-ios-windows-phone }
セントラル・プロパティー・ファイルを編集し、その他のいくつかのリソースを操作することによって、フィーチャーをカスタマイズすることができます。
>これは、Android、iOS、Windows 8 (Windows Store パッケージのみ)、または Windows Phone 8 でのみサポートされています。


フィーチャーをカスタマイズするため: 一部のフィーチャーは、ディレクトリー **IBMAppCenter/apps/AppCenter/common/js/appcenter/** または **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter** 内の **config.json** というセントラル・プロパティー・ファイルによって制御されます。デフォルトのアプリケーション動作を変更したい場合は、プロジェクトをビルドする前に、このプロパティー・ファイルを改作することができます。

このファイルには、次の表に示されているプロパティーが含まれています。

| プロパティー| 説明|
|----------|-------------|
| url| Application Center サーバーのハードコーディングされたアドレス。このプロパティーが設定されると、「ログイン」ビューのアドレス・フィールドは表示されません。 |
| defaultPort| url プロパティーがヌルの場合は、このプロパティーが、電話の「ログイン」ビューの port フィールドを事前に埋めます。これがデフォルト値です。ユーザーはこのフィールドを編集することができます。 |
| defaultContext| url プロパティーがヌルの場合は、このプロパティーが、電話の「ログイン」ビューの context フィールドを事前に埋めます。これがデフォルト値です。ユーザーはこのフィールドを編集することができます。 |
| ssl| 「ログイン」ビューの SSL スイッチのデフォルト値。 |
| allowDowngrade| このプロパティーは、古いバージョンのインストールが許可されているかどうかを示します。古いバージョンをインストールできるのは、オペレーティング・システムとバージョンがダウングレードを容認した場合だけです。|
| showPreviousVersions| このプロパティーは、デバイス・ユーザーがアプリケーションの全バージョンの詳細を表示できるか、それとも最新バージョンの詳細しか表示できないかを示します。 |
| showInternalVersion| このプロパティーは、内部バージョンが表示されるかどうかを示します。 値が false ならば、商用バージョンが設定されていない場合にのみ内部バージョンが表示されます。 |
| listItemRenderer| このプロパティーは次のいずれかの値を取ることができます。<br/>- **full**: (デフォルト値): アプリケーション・リストは、アプリケーション名、評価、および最新バージョンを示します。<br/>- **simple**: アプリケーション・リストはアプリケーション名のみを示します。|
| listAverageRating| このプロパティーは次のいずれかの値を取ることができます。<br/>-  **latestVersion**: アプリケーション・リストは、アプリケーションの最新バージョンの平均評価を示します。<br/>-  **allVersions**: アプリケーション・リストは、アプリケーションの全バージョンの平均評価を示します。|
| requestTimeout| このプロパティーは、Application Center サーバーへの要求のタイムアウト (ミリ秒) を示します。 |
| gcmProjectId| Android プッシュ通知のために必要な Google API プロジェクト ID (project name = com.ibm.appcenter)。例えば、123456789012 など。|
| allowAppLinkReview| このプロパティーは、外部アプリケーション・ストアからのアプリケーションのローカル・レビューを Application Center に登録して参照できるかどうかを示します。 これらのローカル・レビューは外部アプリケーション・ストアでは不可視です。 これらのレビューは Application Center サーバーに保管されます。 |

### その他のリソース 
{: #other-resources }
使用可能なその他のリソースは、アプリケーション・アイコン、アプリケーション名、スプラッシュ画面イメージ、アイコン、およびアプリケーションの変換可能リソースです。 

#### アプリケーション・アイコン
{: #application-icons }
* **Android:** Android Studio プロジェクトの **/res/drawabledensity** ディレクトリー内の **icon.png** という名前のファイル。density ごとに 1 つのディレクトリーが存在します。
* **iOS:** Xcode プロジェクトの **Resources** ディレクトリー内の **iconsize.png** という名前のファイル。
* **Windows Phone:** Windows Phone 用の MobileFirst Studio 環境フォルダーの **native** ディレクトリー内の **ApplicationIcon.png**、**IconicTileSmallIcon.png**、および **IconicTileMediumIcon.png** という名前のファイル。
* **Windows 10 Universal:** Visual Studio の **IBMAppCenterUWP/Assets** ディレクトリー内の **Square\*Logo\*.png**、**StoreLogo.png**、および **Wide\*Logo\*.png** という名前のファイル。


#### アプリケーション名
{: #application-name }
* **Android:** Android Studio プロジェクトの **res/values/strings.xml** ファイル内の **app_name** プロパティーを編集します。
* **iOS:** Xcode プロジェクトの **IBMAppCenterAppCenterIphone-Info.plist** ファイル内の **CFBundleDisplayName** キーを編集します。
* **Windows Phone:** Visual Studio の **Properties/WMAppManifest.xml** ファイル内の App エントリーの **Title** 属性を編集します。
* **Windows 10 Universal:** Visual Studio の **IBMAppCenterUWP/Package.appxmanifest** ファイル内の App エントリーの **Title** 属性を編集します。


#### スプラッシュ画面イメージ
{: #splash-screen-images }
* **Android:** Android Studio プロジェクトの **res/drawable/density** ディレクトリー内の **splashimage.9.png** という名前のファイルを編集します。density ごとに 1 つのディレクトリーが存在します。このファイルはパッチ 9 イメージです。
* **iOS:** Xcode プロジェクトの **Resources** ディレクトリー内の **Default-size.png** という名前のファイル。
* 自動ログイン時の Cordova/MobileFirst Studio ベースのプロジェクトのスプラッシュ画面: **js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone:** Windows Phone 用の MobileFirst Studio 環境フォルダーの **native** ディレクトリー内の **SplashScreenImage.png** という名前のファイルを編集します。
* **Windows 10 Universal:** Visual Studio の *IBMAppCenterUWP/Assets** ディレクトリー内の **SplashScreen*.png** という*名前のファイルを編集します。 

#### アプリケーションのアイコン (ボタン、星印、および同様のオブジェクト)
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**.

#### アプリケーションの変換可能リソース
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**.

## Application Center でのモバイル・クライアントのデプロイ
{: #deploying-the-mobile-client }
クライアント・アプリケーションの異なるバージョンを Application Center にデプロイします。

Windows 8 モバイル・クライアントは、後で配布するために Application Center にデプロイすることを意図していません。Windows 8 モバイル・クライアントは、クライアントの .exe 実行可能ファイルとダイナミック・リンク・ライブラリーの .dll ファイルをアーカイブに直接パッケージしてユーザーに提供する方法か、または Windows 8 モバイル・クライアント用の実行可能インストーラーを作成する方法で配布できます。

Android、iOS、Windows Phone、および Windows 10 Universal (Phone) のバージョンのモバイル・クライアントを Application Center にデプロイする必要があります。そうするには、Android アプリケーション・パッケージ (.apk) ファイル、iOS アプリケーション (.ipa) ファイル、Windows Phone アプリケーション (.xap) ファイル、Windows 10 Universal (.appx) ファイル、または Web ディレクトリー・アーカイブ (.zip) ファイルを Application Center にアップロードする必要があります。

[『モバイル・アプリケーションの追加』](../appcenter-console/#adding-a-mobile-application)で説明されているステップに従って、Android、iOS、Windows Phone、および Windows 10 Universal 用のモバイル・クライアント・アプリケーションを追加します。Installer アプリケーション・プロパティーを選択して、当該アプリケーションがインストーラーであることを指定します。このプロパティーを選択すると、モバイル・デバイス・ユーザーがモバイル・クライアント・アプリケーションのインストールを無線で簡単に行えるようになります。 モバイル・クライアントをインストールするには、オペレーティング・システムで決まるモバイル・クライアント・アプリケーションのバージョンに対応する関連タスクを参照してください。 
