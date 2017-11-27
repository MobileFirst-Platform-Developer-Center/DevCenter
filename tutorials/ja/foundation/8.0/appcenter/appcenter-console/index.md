---
layout: tutorial
title: Application Center コンソール
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Application Center コンソールを使用して、Application Center のリポジトリーおよびアプリケーションを管理することができます。

Application Center コンソールは、Application Center のリポジトリーを管理する Web アプリケーションです。Application Center のリポジトリーは、モバイル・デバイスにインストールできるモバイル・アプリケーションが集中的に保管される中心的な場所です。

Application Center コンソールを使用して以下のことを行います。

* Android、iOS、Windows 8 (Windows Store パッケージのみ)、Windows Phone 8、または Windows 10 Universal の各オペレーティング・システム用に作成されたアプリケーションをアップロードする。
* バージョンの異なる複数のモバイル・アプリケーションを管理する。
* モバイル・アプリケーションのテスターのフィードバックを検討する。
* アプリケーションをリストしてモバイル・デバイスにインストールする権限を有するユーザーを定義する。
* どのアプリケーションがどのデバイスにインストールされているかをトラッキングする。

> **注:**
>
> * Application Center コンソールにログインできるユーザーは、管理者ロールを持つユーザーのみです。
> * 多文化サポート: Application Center コンソールのユーザー・インターフェースは翻訳されていません。

#### ジャンプ先
{: #jump-to }
* [Application Center コンソールの開始](#starting-the-application-center-console)
* [破損したログイン・ページのトラブルシューティング (Apache Tomcat)](#troubleshooting-a-corrupted-login-page-apache-tomcat)
* [Safari ブラウザーでの破損したログイン・ページのトラブルシューティング](#troubleshooting-a-corrupted-login-page-in-safari-browsers)
* [Application Management ](#application-management)
* [モバイル・アプリケーションの追加](#adding-a-mobile-application)
* [公開アプリケーション・ストアからのアプリケーションの追加](#adding-an-application-from-a-public-app-store)
* [アプリケーション・プロパティー](#application-properties)
* [アプリケーション・プロパティーの編集](#editing-application-properties)
* [{{ site.data.keys.mf_server }} および Application Center でのモバイル・アプリケーションのアップグレード](#upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center)
* [アプリケーション・ファイルのダウンロード](#downloading-an-application-file)

Application Center コンソールで、ユーザーから送られてきたモバイル・アプリケーション・バージョンに関するレビューを見ることができます。

* [ユーザーおよびグループ管理](#user-and-group-management)
* [アクセス制御](#access-control)
* [アクセス制御の管理](#managing-access-control)
* [デバイス管理](#device-management)
* [Windows 8 Universal のアプリケーション登録トークン](#application-enrollment-tokens-in-windows-8-universal)
* [Application Center コンソールからのサインアウト](#signing-out-of-the-application-center-console)

## Application Center コンソールの開始
{: #starting-the-application-center-console }
管理者ロールを持っていれば、Web ブラウザーで Application Center を開始してログインすることができます。

1. デスクトップで Web ブラウザー・セッションを開始します。
2. Application Center がインストールされているサーバーのアドレスとポートをシステム管理者から取得します。
3. 次の URL を入力します。`http://server/appcenterconsole`
4. ここで **server** は、Application Center がインストールされているサーバーのアドレスとポートです。`http://localhost:9080/appcenterconsole`

Application Center コンソールにログインします。Application Center コンソールにログインできるように、システム管理者から資格情報を取得します。

![Application Center コンソールのログイン](ac_startconsole.jpg)

> **注:** Application Center コンソールにログインできるユーザーは、管理者ロールを持つユーザーのみです。

## 破損したログイン・ページのトラブルシューティング (Apache Tomcat)
{: #troubleshooting-a-corrupted-login-page-apache-tomcat }
Application Center が Apache Tomcat で稼働しているときは、Application Center コンソールの破損したログイン・ページから復旧することができます。

Application Center が Apache Tomcat で稼働しているとき、誤ったユーザー名やパスワードを使用すると、Application Center コンソールのログイン・ページでエラーが発生することがあります。

正しくないユーザー名またはパスワードを使用してコンソールへのログインを試みると、エラー・メッセージが表示されます。ユーザー名またはパスワードを修正すると、正常にログインせずに、次のいずれかのエラーが発生します。メッセージは Web ブラウザーによって異なります。

* 前と同じエラー・メッセージ
* メッセージ「**接続がリセットされました**」
* メッセージ「**ログインに許可された時間を超過しました**」

この動作は、Apache Tomcat による j_security_check サーブレットの管理に関連しています。この動作は Apache Tomcat に特有のものであり、どの WebSphere Application Server プロファイルでも発生しません。

回避策としては、ログインの失敗後、ブラウザーの最新表示ボタンをクリックして、Web ページを最新表示します。次に、正しい資格情報を入力します。

## Safari ブラウザーでの破損したログイン・ページのトラブルシューティング
{: #troubleshooting-a-corrupted-login-page-in-safari-browsers }
Safari ブラウザーを使用している場合、Application Center コンソールの破損したログイン・ページから復旧することができます。

Safari ブラウザーで Application Center コンソールを開いているときは、コンソールから離れてナビゲートする場合があります。コンソールに戻ると、ログイン・ページが表示される場合があります。正しいログイン詳細を入力したとしても、ログイン成功の代わりに次のメッセージ **HTTP 状況 404 - appcenterconsole/j_security_check** が表示されます。

この動作は、Safari ブラウザーでのキャッシュの問題に関係しています。

回避策は、ログイン・ページが表示されたときに、資格情報を入力せず、自動入力された資格情報も使用せずに、強制再ロードを起動することです。以下に、強制再ロードを起動する方法を示します。

* Mac コンピューターの場合、Shift +**「更新」**ボタンを押します。
* iPad デバイスまたは iPhone デバイスの場合、更新ボタンをダブルクリックするか、Safari を閉じてキャッシュを消去します。ホーム・ボタンをダブルクリックし、Safari をスワイプで一掃します。

## Application Management 
{: #application-management }
Application Management を使用して、新しいアプリケーションやバージョンを追加したり、それらのアプリケーションを管理したりすることができます。  
Application Center を使用して、新しいアプリケーションやバージョンを追加したり、それらのアプリケーションを管理したりすることができます。

**「アプリケーション」**をクリックして Application Management にアクセスします。

### WebSphere Application Server Liberty プロファイルまたは Apache Tomcat にインストールされる Application Center
{: #application-center-installed-on-websphere-application-server-liberty-profile-or-on-apache-tomcat }
これらのアプリケーション・サーバーへの Application Center のインストールでは、IBM Installation Manager パッケージを使用した {{ site.data.keys.product_full }} のインストールで初めに使用できる 2 つの異なるユーザーが定義されています。

* ログイン **demo** とパスワード **demo** を持つユーザー
* ログイン **appcenteradmin** とパスワード **admin** を持つユーザー

### WebSphere Application Server フル・プロファイル
{: #websphere-application-server-full-profile }
Application Center を WebSphere Application Server フル・プロファイルにインストールした場合は、appcenteradmin という名前の 1 人のユーザーが、デフォルトではインストーラーによって指示されたパスワードで作成されます。

![使用可能なアプリケーション](ac_app_mgt.jpg)

## モバイル・アプリケーションの追加
{: #adding-a-mobile-application }
Application Center コンソールを使用して、サーバー上のリポジトリーにアプリケーションを追加できます。その後、モバイル・クライアントを使用して、これらのアプリケーションをモバイル・デバイスにインストールすることができます。

「アプリケーション」ビューで、Application Center にアプリケーションを追加することができます。初めはアプリケーションのリストが空になっています。アプリケーション・ファイルをアップロードする必要があります。アプリケーション・ファイルについては、この手順で説明します。

アプリケーションを追加して、モバイル・デバイスにインストールできるようにするには、次のようにします。

1. **「アプリケーションの追加 (Add Application)」**をクリックします。
2. **「アップロード (Upload)」**をクリックします。
3. Application Center リポジトリーにアップロードするアプリケーション・ファイルを選択します。

   ### Android
   {: #android }
   アプリケーション・ファイル名拡張子は **.apk** です。

   ### iOS
   {: #ios }
   通常の iOS アプリケーションのアプリケーション・ファイル名拡張子は **.ipa** です。

   ### Windows Phone 8
   {: #windows-phone-8 }
   アプリケーション・ファイル名拡張子は **.xap** です。企業アカウントを使用してアプリケーションに署名する必要があります。アプリケーションをデバイスにインストールする前に、Windows Phone 8 デバイスがこの企業アカウントのアプリケーション登録トークンを使用できるようにする必要があります。詳しくは、[Windows 8 Universal のアプリケーション登録トークン](#application-enrollment-tokens-in-windows-8-universal)を参照してください。

   ### Windows 8
   {: #windows-8 }
   このアプリケーションは、Windows Store パッケージとして提供されます。ファイル拡張子は **.appx** です。

   Windows Store .appx パッケージは、1 つ以上の Windows コンポーネント・ライブラリー・アプリ・パッケージ (別名「フレームワーク」パッケージ) に依存します。Windows 8 用の MobileFirst ハイブリッド・アプリケーションは、Microsoft.WinJS フレームワーク・パッケージに依存します。Microsoft Visual Studio を使用してアプリケーション・パッケージを生成すると、依存パッケージも生成され、別箇の .appx ファイルとしてパッケージされます。モバイル・クライアントを使用してそのようなアプリケーションを正常にインストールするには、アプリケーションの .appx パッケージおよびその他すべての依存パッケージを Application Center サーバーにアップロードする必要があります。依存パッケージをアップロードすると、Application Center コンソールでは非アクティブとして表示されます。これは、クライアントでフレームワーク・パッケージがインストール可能なアプリケーションとして表示されないようにするための正常な動作です。 その後、ユーザーがアプリケーションをインストールするときに、モバイル・クライアントは依存パッケージがデバイスにすでにインストールされているかどうかをチェックします。依存パッケージがインストールされていない場合、クライアントは、Application Center サーバーから依存パッケージを自動的に取得してデバイスにインストールします。依存関係について詳しくは、パッケージおよびアプリケーションのデプロイメントに関する Windows 開発者向け資料の[依存関係](http://msdn.microsoft.com/library/windows/apps/hh464929.aspx#dependencies)を参照してください。

   ### Windows 10 Universal
   {: windows-10-universal}
   アプリケーション・ファイル名拡張子は **.appx** です。
   


4. **「次へ (Next)」**をクリックして、アプリケーションの定義を完了するプロパティーにアクセスします。
5. アプリケーションを定義するプロパティーを完了します。プロパティー値を完了する方法については、[アプリケーション・プロパティー](#application-properties)を参照してください。
6. **「終了 (Finish)」**をクリックします。

![アプリケーション・プロパティー、アプリケーションの追加](ac_add_app_props.jpg)

## 公開アプリケーション・ストアからのアプリケーションの追加
{: #adding-an-application-from-a-public-app-store }
Application Center は、サード・パーティーのアプリケーション・ストア (Google play や Apple iTunes など) に保管されているアプリケーションをカタログに追加する操作をサポートします。

サード・パーティーのアップストアからのアプリケーションは他のアプリケーションと同様に Application Center のカタログに表示されますが、ユーザーはアプリケーションをインストールするための対応する公開アプリケーション・ストアに誘導されます。コンソールで公開アプリケーション・ストアからのアプリケーションを追加する場所は、自社内で作成されたアプリケーションを追加する場所と同じです。[『モバイル・アプリケーションの追加』](#adding-a-mobile-application)を参照してください。

> **注:** 現在、Application Center は Google Play と Apple iTunes のみをサポートします。Windows Phone Store、および Windows Store はまだサポートされていません。



アプリケーションの実行可能ファイルではなく、アプリケーションが保管されているサード・パーティー・アプリケーション・ストアへの URL を提供する必要があります。正しいアプリケーション・リンクを見つけやすいように、コンソールでは、サポートされているサード・パーティー・アプリケーション・ストアの Web サイトへの直接リンクを**「アプリケーションの追加」**ページで提供しています。

Google play ストアのアドレスは [https://play.google.com/store/apps](https://play.google.com/store/apps) です。

Apple iTunes ストアのアドレスは [https://linkmaker.itunes.apple.com/](https://linkmaker.itunes.apple.com/) です。iTunes サイトではなく linkmaker サイトを使用してください。というのは、このサイトを検索してあらゆる種類の iTunes アイテム (曲、ポッドキャスト、および Apple が提供するその他のアイテムなど) を見つけることができるからです。iOS アプリケーションを選択したときのみ、アプリケーション・リンクを作成する互換リンクが提供されます。

1. ブラウズする公開アプリケーション・ストアの URL をクリックします。
2. サード・パーティー・アプリケーション・ストア内のアプリケーションの URL を、Application Center コンソールの**「アプリケーションの追加」**ページにある**「アプリケーション URL (Application URL)」**テキスト・フィールドにコピーします。
    * **Google Play:**
        * ストア内のアプリケーションを選択します。
        * そのアプリケーションの詳細ページをクリックします。
        * アドレス・バーの URL をコピーします。
    * **Apple iTunes:**
        * 検索結果でアイテムのリストが返されたら、必要なアイテムを選択します。 

        * 選択したアプリケーションの下部で、**「直接リンク」**をクリックしてアプリケーションの詳細ページを開きます。

        * アドレス・バーの URL をコピーします。

          **注:** **直接リンク**を Application Center にコピーしないでください。**直接リンク** は、リダイレクトを含む URL です。リダイレクト先の URL を取得する必要があります。

3. アプリケーション・リンクがコンソールの**「アプリケーション URL (Application URL)」**テキスト・フィールドに表示されたら、**「次へ (Next)」**をクリックしてアプリケーション・リンクの作成を検証します。
    * 検証が失敗した場合は、**「アプリケーションの追加」**ページにエラー・メッセージが表示されます。別のリンクで試すか、さもなければ現行リンクを作成する試みを取り消すことができます。 
    * 検証が成功した場合は、このアクションによってアプリケーション・プロパティーが表示されます。これで、次のステップに進む前に、アプリケーション・プロパティー内のアプリケーション記述を変更することができます

    ![アプリケーション・プロパティーで変更したアプリケーション記述](ac_add_public_app_details.jpg)

4. **「完了 (Done)」**をクリックしてアプリケーション・リンクを作成します。

    このアクションにより、アプリケーションは Application Center モバイル・クライアントの対応するバージョンで使用可能になります。このアプリケーションが公開アプリケーション・ストアに保管され、かつバイナリー・アプリケーションとは異なることを示すために、アプリケーション・アイコンの上に小さいリンク・アイコンが表示されます。

    ![Google Play に保管されたアプリケーションへのリンク](ac_public_app_available.jpg)

## アプリケーション・プロパティー
{: #application-properties }
アプリケーションには、モバイル・デバイスのオペレーティング・システムに依存し、かつ編集できない独自の一連のプロパティーがあります。アプリケーションにはまた、共通プロパティーおよび編集可能プロパティーもあります。

以下のフィールドの値はアプリケーションから取得されるもので、編集することはできません。 

* **Package**。
* **Internal Version**。
* **Commercial Version**。
* **Label**。
* **External URL**; このプロパティーは、Android、iOS、および Windows Phone 8 上で稼働するアプリケーション用にサポートされています。

### Android アプリケーションのプロパティー
{: #properties-of-android-applications }
次のプロパティーについて詳しくは、Android SDK の資料を参照してください。

* **Package** はアプリケーションのパッケージ名です; アプリケーションのマニフェスト・ファイル内の manifest 要素の **package** 属性。
* **Internal Version** はアプリケーションの内部バージョン識別です; アプリケーションのマニフェスト・ファイル内の **manifest** 要素の **android:versionCode** 属性。 
* **Commercial Version** はアプリケーションの公開バージョンです。 
* **Label** はアプリケーションのラベルです; アプリケーションの **manifest** ファイル内のアプリケーション・エレメントの **android:label 属性**。
* **External URL** は、Application Center のモバイル・クライアントを現行アプリケーションの最新バージョンの「詳細」ビューで自動的に始動できるようにするための URL です。

### iOS アプリケーションのプロパティー
{: #properties-of-ios-applications }
次のプロパティーについて詳しくは、iOS SDK の資料を参照してください。

* **Package** は会社 ID および製品名です; **CFBundleIdentifier** キー。 
* **Internal Version** はアプリケーションのビルド番号です; アプリケーションの **CFBundleVersion** キー。 
* **Commercial Version** はアプリケーションの公開バージョンです。 
* **Label** はアプリケーションのラベルです; アプリケーションの **CFBundleDisplayName** キー。 
* **External URL** は、Application Center のモバイル・クライアントを現行アプリケーションの最新バージョンの「詳細」ビューで自動的に始動できるようにするための URL です。

### Windows Phone 8 アプリケーションのプロパティー
{: #properties-of-windows-phone-8-applications }
以下のプロパティーについて詳しくは、Windows Phone の資料を参照してください。

* **Package** はアプリケーションの製品 ID です; アプリケーションのマニフェスト・ファイル内の App 要素の **ProductID** 属性。
* **Internal Version** はアプリケーションのバージョン識別です; アプリケーションのマニフェスト・ファイル内の App 要素の **Version** 属性。
* **Commercial Version** は、Internal Version と同様、アプリケーションのバージョンです。
* **Label**() はアプリケーションの表題です; アプリケーションのマニフェスト・ファイル内の **App** 要素の **Title** 属性。
* **Vendor** はアプリケーションを作成したベンダーです; アプリケーションのマニフェスト・ファイル内の **App** 要素の **Publisher** 属性。 
* **External URL** は、Application Center のモバイル・クライアントを現行アプリケーションの最新バージョンの「詳細」ビューで自動的に始動できるようにするための URL です。
* **Commercial Version** は、**Internal Version** と同様、アプリケーションのバージョンです。

### Windows Store アプリケーションのプロパティー
{: #properties-of-windows-store-applications }
次のプロパティーについて詳しくは、アプリケーション開発に関する Windows Store の資料を参照してください。

* **Package** はアプリケーションの製品 ID です; アプリケーションのマニフェスト・ファイル内の **Package** 名前属性。
* **Internal Version** はアプリケーションのバージョン識別です; アプリケーションのマニフェスト・ファイル内の  **Version** 属性。
* **Commercial Version** は、**Internal Version** と同様、アプリケーションのバージョンです。
* **Label** はアプリケーションの表題です; アプリケーションのマニフェスト・ファイル内の **Package** 表示名属性。 
* **Vendor** はアプリケーションを作成したベンダーです; アプリケーションのマニフェスト・ファイル内の **Publisher** 属性。

### Windows 10 Universal アプリケーションのプロパティー
{: #properties-of-windows-10-universal-applications}

* **Package** はアプリケーションの製品 ID です; アプリケーションのマニフェスト・ファイル内の **Package** 名前属性。
* **Internal Version** はアプリケーションのバージョン識別です; アプリケーションのマニフェスト・ファイル内の  **Version** 属性。
* **Commercial Version** は、**Internal Version** と同様、アプリケーションのバージョンです。
* **Label** はアプリケーションの表題です; アプリケーションのマニフェスト・ファイル内の **Package** 表示名属性。 
* **Vendor** はアプリケーションを作成したベンダーです; アプリケーションのマニフェスト・ファイル内の **Publisher** 属性。

### 共通プロパティー: Author
{: #common-property-author }
**Author** フィールドは読み取り専用です。ここには、アプリケーションをアップロードしたユーザーの **username** 属性が表示されます。

### 編集可能プロパティー 
{: #editable-properties }
以下のフィールドは編集可能です。

**Description**  
このフィールドを使用して、モバイル・ユーザーにアプリケーションを説明します。 

**Recommended**  
このアプリケーションのインストールをユーザーに推奨することを示すには **Recommended** を選択します。推奨アプリケーションは、モバイル・クライアントに特殊リストとして表示されます。

**Installer**  
管理者の場合のみ: このプロパティーは、当該アプリケーションが、他のアプリケーションをモバイル・デバイスにインストールして、アプリケーションに関するフィードバックをモバイル・デバイスから Application Center に送信するために使用されることを示します。通常、**Installer** の資格を与えられるアプリケーションは 1 つだけで、モバイル・クライアントと呼ばれます。このアプリケーションは、[『モバイル・クライアント』](../mobile-client)に記載されています。

**Active**  
アプリケーションをモバイル・デバイスにインストールできることを示すには、Active を選択します。

* **Active** を選択しなかった場合、そのアプリケーションは非アクティブになり、モバイル・ユーザー用にデバイスに表示される使用可能アプリケーションのリストには表示されません。
* Application Management の使用可能アプリケーションのリストで、**Show inactive** が選択されていないと、そのアプリケーションは使用不可です。 **Show inactive** が選択されないと、そのアプリケーションは使用可能アプリケーションのリストに表示されません。 

**Ready for production**  
アプリケーションが実稼働環境にデプロイできる状態になっていること、したがってそのアプリケーションは Tivoli Endpoint Manager がそのアプリケーション・ストアを介して管理する対象として適切であることを示すには、**Ready for production** を選択します。このプロパティーが選択されたアプリケーションのみが、Tivoli Endpoint Manager に対するフラグが立てられるアプリケーションになります。

## アプリケーション・プロパティーの編集
{: #editing-application-properties }
アップロードされたアプリケーションのリストにあるアプリケーションのプロパティーを編集することができます。   
アップロードされたアプリケーションのプロパティーを編集するには、次のようにします。

1. **「アプリケーション (Applications)」**を選択してアップロード済みアプリケーションのリストを表示します: 「使用可能なアプリケーション (Available Applications)」。
2. プロパティーを編集するアプリケーションのバージョンをクリックします: 「アプリケーションの詳細」。
3. 目的の編集可能プロパティーを編集します。 これらのプロパティーについて詳しくは、[アプリケーション・プロパティー](#application-properties)を参照してください。現在のアプリケーション・ファイルの名前がプロパティーの後に表示されます。

    > **重要:** ファイルを更新したい場合、そのファイルは同じパッケージに属し、かつ同じバージョン番号でなければなりません。これらのプロパティーのうちのどれかが同じでない場合は、アプリケーション・リストに戻り、まず新しいバージョンを追加する必要があります。

4. **「OK」**をクリックして、変更を保存し、「使用可能なアプリケーション」に戻るか、または**「適用 (Apply)」**をクリックして、変更を保存し、「アプリケーションの詳細」を開いたままにしておきます。 

![編集のためのアプリケーション・プロパティー ](ac_edit_app_props.jpg)

## {{ site.data.keys.mf_server }} および Application Center でのモバイル・アプリケーションのアップグレード
{: #upgrading-a-mobile-application-in-mobilefirst-server-and-the-application-center }

> これは、Android、iOS、および Windows Phone でのみサポートされており、Windows 10 Universal、Blackberry、および Windows 8 Universal では現在サポートされていません。





{{ site.data.keys.mf_console }} と Application Center を組み合わせて、デプロイされたモバイル・アプリケーションを簡単にアップグレードできます。

モバイル・デバイス上に Application Center のモバイル・クライアントをインストールする必要があります。HelloWorld アプリケーションはモバイル・デバイス上にインストールし、アプリケーションの実行時に {{ site.data.keys.mf_server }} に接続する必要があります。

この手順を使用して、{{ site.data.keys.mf_server }} 上および Application Center 内にデプロイされた Android、iOS、および Windows Phone のアプリケーションを更新できます。このタスクでは、アプリケーション HelloWorld バージョン 1.0 は、{{ site.data.keys.mf_server }}上および Application Center 内にすでにデプロイされています。

HelloWorld バージョン 2.0 はリリースされており、バージョン 1.0 のユーザーに最新バージョンへアップグレードしてもらうことを考えています。アプリケーションの新しいバージョンをデプロイするには、次のようにします。

1. Application Center に HelloWorld 2.0 をデプロイします。[『モバイル・アプリケーションの追加』](#adding-a-mobile-application)を参照してください。
2. 「アプリケーション詳細 (Application Details)」ページから、外部 URL の設定をコピーします。

    ![「アプリケーション詳細」からの外部 URL のコピー](ac_copy_ext_url.jpg)

3. 外部 URL をクリップボードにコピーした場合、{{ site.data.keys.mf_console }} を開きます。
4. HelloWorld バージョン 1.0 のアクセス・ルールを"「アクセス無効」"に変更します。
5. 外部 URL を URL フィールドに貼り付けます。

    クライアントの実行: モバイル・デバイスが {{ site.data.keys.mf_server }} に接続して HelloWorld バージョン 1.0 を実行しようとすると、デバイス・ユーザーは、アプリケーション・バージョンのアップグレードを要求されます。

    ![リモート側で古いバージョンのアプリケーションを無効化](ac_remote_disable_app_cli.jpg)

6. **「アップグレード (Upgrade)」**をクリックして、Application Center クライアントを開きます。ログイン詳細を正しく入力して、HelloWorld バージョン 2.0 の「詳細 (Details)」ページに直接アクセスします。

    ![Application Center クライアントでの HelloWorld 2.0 の詳細](ac_cli_app_details_upgrade.jpg)

## アプリケーション・ファイルのダウンロード 
{: #downloading-an-application-file }
Application Center に登録されているアプリケーションのファイルをダウンロードすることができます。 

1. **「アプリケーション (Applications)」**を選択してアップロード済みアプリケーションのリストを表示します: **「使用可能なアプリケーション (Available Applications)」**。
2. **「アプリケーションの詳細 (Application Details)」**でアプリケーションのバージョンをタップします。
3. 「アプリケーション・ファイル」セクションでファイル名をタップします。

## アプリケーション・レビューの表示
{: #viewing-application-reviews }
Application Center コンソールで、ユーザーから送られてきたモバイル・アプリケーション・バージョンに関するレビューを見ることができます。

モバイル・アプリケーションのユーザーは、評価とコメントを含むレビューを書き、Application Center クライアントを通じてそのレビューを送信することができます。 レビューは、Application Center コンソールおよびクライアントで入手できます。 個々のレビューは、常にアプリケーションの特定のバージョンと関連付けられます。 

モバイル・ユーザーやテスターからの、アプリケーション・バージョンに関するレビューを表示するには、次のようにします。 

1. **「アプリケーション (Applications)」**を選択してアップロード済みアプリケーションのリストを表示します: **「使用可能なアプリケーション (Available Applications)」**。
2. アプリケーションのバージョンを選択します。
3. メニューで、**「レビュー (Reviews)」**を選択します。

    ![アプリケーション・バージョンのレビュー](ac_appfeedbk.jpg)

    評価は、記録されたすべてのレビューにある評価の平均です。 評価は 1 から 5 個の星で構成されます。星 1 つはアプリケーションのレベルが最低であることを表します。5 つ星はアプリケーションのレベルが最高であることを表します。 クライアントは星ゼロの評価を送ることはできません。

    平均評価は、アプリケーションがアプリケーションの使用目的をどの程度満たしているかを示すものです。 

4. 二重矢印 <img src="down-arrow.jpg" style="margin:0;display:inline" alt="二重矢印ボタン"/>をクリックして、レビューの一部であるコメントを展開し、レビューが生成されたモバイル・デバイスの詳細を表示します。

    例えば、コメントは、レビューを送った理由 (インストールの失敗など) を示すことができます。
    レビューを削除したい場合は、削除するレビューの右側のごみ箱アイコンをクリックしてください。 

## ユーザーおよびグループ管理 
{: #user-and-group-management }
ユーザーとグループを使用して、どのユーザーまたはグループが Application Center の一部のフィーチャー (モバイル・デバイスへのアプリケーションのインストールなど) にアクセスできるかを定義することができます。   
アクセス制御リスト (ACL) の定義でユーザーとグループを使用するため。 

### 登録済みユーザーの管理 
{: #managing-registered-users }
登録済みユーザーを管理するには、 **「ユーザー/グループ」**タブをクリックし、**「登録済みユーザー」 **を選択します。Application Center の登録済みユーザーのリストを取得します。以下のユーザーが含まれます。 

* モバイル・クライアント・ユーザー
* コンソール・ユーザー
* ローカル・グループ・メンバー
* アクセス制御リストのメンバー

![Application Center の登録済みユーザーのリスト](ac_reg_users.jpg)

Application Center が LDAP リポジトリーに接続されている場合は、ユーザー表示名を編集できません。 リポジトリーが LDAP でない場合は、選択して編集することでユーザー表示名を変更できます。 

新しいユーザーを登録するには、**「ユーザーの登録」**をクリックし、ログイン名と表示名を入力し、**「OK」**をクリックします。   
ユーザーを登録抹消するには、ユーザー名の横にあるごみ箱アイコンをクリックします。 

* そのユーザーが提供したフィードバックが削除される。
* アクセス制御リストからそのユーザーが削除される。
* ローカル・グループからそのユーザーが削除される。

> **注:** ユーザーを登録抹消すると、そのユーザーはアプリケーション・サーバーまたは LDAP リポジトリーから削除されません。

### ローカル・グループの管理 
{: #managing-local-groups }
ローカル・グループを管理するには、 **「ユーザー/グループ」**タブをクリックし、**「ユーザー・グループ」 **を選択します。  
ローカル・グループを作成するには、**「グループの作成 (Create group)」**をクリックします。 その新しいグループの名前を入力し、**「OK」**をクリックします。 

Application Center が LDAP リポジトリーに接続されている場合は、ローカル・グループのほかに LDAP リポジトリーで定義されているグループが検索に組み込まれます。 リポジトリーが LDAP でない場合は、ローカル・グループのみが検索に有効です。 

![ローカル・ユーザー・グループ](ac_loc_group.jpg)

グループを削除するには、グループ名の横にあるごみ箱アイコンをクリックします。このグループはアクセス制御リストからも削除されます。  
グループのメンバーを追加または削除するには、そのグループの**「メンバーの編集 (Edit members)」**リンクをクリックします。

![グループ・メンバーシップの管理](ac_grp_members.jpg)

新しいメンバーを追加するには、ユーザー表示名を入力してユーザーを検索し、ユーザーを選択し、**「追加 (Add)」**をクリックします。

Application Center が LDAP リポジトリーに接続されている場合は、LDAP リポジトリーでユーザーの検索が行われます。リポジトリーが LDAP でない場合は、登録済みユーザーのリストで検索が行われます。

グループからメンバーを削除するには、ユーザー名の右側にある×アイコンをクリックします。

## アクセス制御
{: #access-control }
モバイル・デバイスへのアプリケーションのインストールがすべてのユーザーに開放されているか、それともアプリケーションをインストールする能力を制限したいかを決定することができます。

モバイル・デバイスへのアプリケーションのインストールは、特定のユーザーに制限することもできれば、すべてのユーザーに利用可能にすることもできます。

アクセス制御はアプリケーション・レベルで定義され、バージョン・レベルでは定義されません。

デフォルトでは、アプリケーションがアップロードされた後、そのアプリケーションをモバイル・デバイスにインストールする権限がすべてのユーザーに付与されます。

アプリケーションの現在のアクセス制御は、アプリケーションごとに「使用可能なアプリケーション (Available Applications)」に表示されます。インストールのアクセス状況 (無制限または制限付き) は、アクセス制御を編集するためのページへのリンクとして示されます。

インストール権限は、モバイル・デバイスへのアプリケーションのインストールのみに関する権限です。アクセス制御が使用可能になっていないと、誰でもアプリケーションにアクセスすることができます。

## アクセス制御の管理
{: #managing-access-control }
ユーザーまたはグループがモバイル・デバイスにアプリケーションをインストールするアクセス権限を追加したり削除したりすることができます。  
アクセス制御を編集することができます。

1. 「Application Management」の「使用可能なアプリケーション (Available Applications)」で、アプリケーションのインストールの「無制限 (unrestricted)」または「制限付き (restricted)」状態をクリックします。

    ![無制限モードまたは制限付きモードをクリックする場所](ac_app_access_state.jpg)

2. **「アクセス制御使用可能 (Access control enabled)」**を選択して、アクセス制御を使用可能にします。
3. ユーザーまたはグループをアクセス・リストに追加します。

ユーザーまたはグループを 1 つだけ追加するには、名前を入力し、見つかった一致項目の中からその項目を選択し、**「追加 (Add)」**をクリックします。

Application Center が LDAP リポジトリーに接続されている場合は、リポジトリー内のユーザーとグループ、およびローカルで定義されたグループを検索することができます。リポジトリーが LDAP でない場合は、ローカル・グループと登録済みユーザーのみを検索することができます。ローカル・グループは、**「ユーザー/グループ (Users/Groups)」**タブで排他的に定義されます。Liberty プロファイル統合レジストリーを使用すると、ログイン名を使用したユーザーしか検索できません。結果は最大 15 ユーザーおよび 15 グループ (50 ユーザーおよび 50 グループではない) に制限されます。

ユーザーをアクセス・リストへの追加と同時に登録するには、ユーザーの名前を入力して**「追加」**をクリックします。 その後、そのユーザーのログイン名と表示名を指定する必要があります。

アプリケーションのすべてのユーザーを追加するには、**「アプリケーションからユーザーを追加 (Add users from application)」**をクリックし、該当するアプリケーションを選択します。  
ユーザーまたはグループからアクセス権限を削除するには、その名前の右側にある×アイコンをクリックします。

![ユーザーのアクセス・リストへの追加またはアクセス・リストからの削除](ac_instal_access.jpg)

## デバイス管理
{: #device-management }
Application Center モバイル・クライアントから Application Center に接続したデバイスと、それらのデバイスのプロパティーを確認することができます。

**「デバイス管理 (Device Management)」**は、**「登録済みデバイス (Registered Devices)」**の下に、Application Center モバイル・クライアントから少なくとも 1 回は Application Center に接続したデバイスのリストを表示します。

![デバイス・リスト](ac_reg_devices.jpg)

### デバイス・プロパティー
{: #device-properties }
デバイスのリストでデバイスをどれかクリックすると、そのデバイスのプロパティーまたはそのデバイスにインストールされているアプリケーションが表示されます。

![デバイス・プロパティー](ac_edit_deviceprops.jpg)

**「プロパティー (Properties)」**を選択するとデバイス・プロパティーが表示されます。

**「名前 (Name)」**  
装置の名前。 このプロパティーは編集可能です。 

> **注:** iOS の場合は、「設定」>「一般」>「情報」>「名前」のデバイス設定で、この名前を定義することができます。同じ名前が iTunes に表示されます。



**「ユーザー名 (User Name)」**  
当該デバイスに最初にログインしたユーザーの名前。 

**「メーカー (Manufacturer)」**  
デバイスのメーカー。 

**「モデル (Model)」**  
モデル ID。 

**「オペレーティング・システム (Operating System)」**  
モバイル・デバイスのオペレーティング・システム。 

**「固有 ID (Unique identifier)」**  
モバイル・デバイスの固有 ID。 

デバイス名を編集した場合は、**「OK」**をクリックすると、その名前が保存されて「登録済みデバイス」に戻ります。**「適用 (Apply)」**をクリックすると、その名前が保存されて「デバイス・プロパティーの編集 (Edit Device Properties)」は開いたままになります。

### デバイスにインストールされているアプリケーション
{: #applications-installed-on-device }
**「デバイスにインストールされているアプリケーション (Applications installed on device)」**を選択すると、当該デバイスにインストールされているすべてのアプリケーションがリストされます。

![デバイスにインストールされているアプリケーション ](ac_apps_on_device.jpg)

## Windows 8 Universal のアプリケーション登録トークン
{: #application-enrollment-tokens-in-windows-8-universal }
Windows 8 Universal オペレーティング・システムでは、各デバイスを会社に登録して初めてユーザーは企業アプリケーションを各自のデバイスにインストールできるようになります。デバイスを登録する一つの方法は、アプリケーション登録トークンを使用する方法です。

アプリケーション登録トークンを使用して、企業アプリケーションを Windows 8 Universal デバイスにインストールすることができます。まず、指定された会社の登録トークンをデバイスにインストールしてデバイスをその会社に登録する必要があります。登録が完了したら、該当する会社が作成および署名したアプリケーションをインストールできるようになります。
Application Center は登録トークンの配信を簡略化します。Application Center カタログの管理者のロールで、Application Center コンソールから登録トークンを管理することができます。Application Center コンソールで登録トークンが宣言されると、Application Center ユーザーはそれらのトークンを使用して各自のデバイスを登録することができます。

「設定」ビューの、Application Center コンソールから利用できる登録トークン・インターフェースにより、Windows 8 Universal のアプリケーション登録トークンを登録したり、更新したり、削除したりして、これらのトークンを管理することができます。

### アプリケーション登録トークンの管理
{: #managing-application-enrollment-tokens }
Application Center の管理者のロールで、画面ヘッダーにある歯車アイコンをクリックして Application Center の「設定」を表示することにより、登録済みトークンのリストにアクセスすることができます。次に、**「登録トークン (Enrollment Tokens)」**を選択すると、登録済みトークンのリストが表示されます。

デバイスを登録するには、デバイス・ユーザーが、Application Center モバイル・クライアントをインストールする前に、トークン・ファイルをアップロードしてインストールする必要があります。モバイル・クライアントも企業アプリケーションです。したがって、デバイスを登録して初めてモバイル・クライアントをインストールできるようになります。

登録済みトークンはブートストラップ・ページ (`http://hostname:portnumber/applicationcenter/installers.html`) を通じて使用できます。ここで、**hostname** は Application Center をホストするサーバーのホスト名、**portnumber** は対応するポート番号です。

Application Center コンソールでトークンを登録するには、**「トークンのアップロード (Upload Token)」**をクリックし、トークン・ファイルを選択します。トークン・ファイル拡張子は aetx です。  
トークンの証明書所有者を更新するには、リストでそのトークン名を選択し、値を変更し、「OK」をクリックします。  
トークンを削除するには、リストでそのトークンの右側にあるごみ箱アイコンをクリックします。

## Application Center コンソールからのサインアウト
{: #signing-out-of-the-application-center-console }
セキュリティーのために、管理用タスクを終了したときはコンソールからサインアウトする必要があります。

Application Center コンソールへのセキュア・サインオンからログアウトすること。  
Application Center コンソールからサインアウトするには、各ページのバナーに表示されているウェルカム・メッセージの隣にある**「サインアウト」**をクリックします。
