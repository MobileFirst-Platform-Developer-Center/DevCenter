---
layout: tutorial
title: アプリケーションの更新のプッシュ通知
breadcrumb_title: Push notifications
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
ストア内にアプリケーションの更新があるときはプッシュ通知がユーザーに送られるように Application Center クライアントを構成することができます。

Application Center 管理者は、プッシュ通知を使用して、すべての iOS デバイスまたは Android デバイスに通知を自動送信します。 お気に入りのアプリケーションの更新、および Application Centerサーバーにデプロイされるか推奨としてマーク付けされている新規アプリケーションについて、通知が送信されます。

### プッシュ通知プロセス
{: #push-notification-process }
以下の条件を満たしている場合に、プッシュ通知がデバイスに送信されます。

* デバイスに Application Center がインストールされ、少なくとも 1 回は開始されている。
* ユーザーが、**「設定」→「通知」**インターフェースで、このデバイスに対する Application Centerのプッシュ通知を無効にしていない。
* ユーザーに、アプリケーションをインストールする権限がある。 この種のアクセス権は、Application Center のアクセス権を使用して制御されます。
* アプリケーションに推奨としてのマークが付いているか、または、このデバイスで Application Centerを使用しているユーザーの優先としてのマークが付いている。 これらのフラグは、ユーザーが Application Center を介してアプリケーションをインストールする際に、自動的に設定されます。 どのアプリケーションに優先のマークが付いているかは、デバイスの Application Center の**「お気に入り」**タブを見ると表示されています。
* アプリケーションがデバイスにインストールされていないか、デバイスにインストール済みのバージョンより新しいバージョンが利用可能である。

あるデバイスで初めて Application Center クライアントが開始されたとき、着信プッシュ通知を受け取るかどうかとユーザーに聞いてくることがあります。 これは、iOS モバイル・デバイスの場合です。 プッシュ通知フィーチャーは、モバイル・デバイスでサービスが使用不可になっているときは機能しません。

iOS オペレーティング・システム・バージョンと最新の Android オペレーティング・システム・バージョンには、このサービスをアプリケーションごとにオンまたはオフに切り替える方法が備わっています。

プッシュ通知用にモバイル・デバイスを構成する方法については、デバイス・ベンダーにお問い合わせください。

#### ジャンプ先
{: #jump-to }
* [アプリケーション更新のためのプッシュ通知の構成](#configuring-push-notifications)
* [Google Cloud Messaging に接続するための Application Center サーバーの構成](#gcm)
* [Apple Push Notification Services に接続するための Application Center サーバーの構成](#apns)
* [GCM API に依存しないモバイル・クライアントのバージョンのビルド](#no-gcm)

## アプリケーション更新のためのプッシュ通知の構成
{: #configuring-push-notifications }
サード・パーティーのプッシュ通知サーバーと通信できるように Application Center サービスの資格情報または証明書を構成する必要があります。

### Application Center のサーバー・スケジューラーの構成
{: #configuring-the-server-scheduler }
サーバー・スケジューラーは、サーバーと一緒に自動的に開始したり停止したりするバックグラウンド・サービスです。 このスケジューラーは、管理者のアクションによって、送信されるプッシュ更新メッセージで自動的に埋められるスタックを定期的に空にするために使用されます。 プッシュ更新メッセージのバッチを送信するデフォルト間隔は 12 時間です。 このデフォルト値が適切でない場合は、サーバー環境変数 **ibm.appcenter.push.schedule.period.amount** および **ibm.appcenter.push.schedule.period.unit** を使用して変更することができます。

**ibm.appcenter.push.schedule.period.amount** の値は整数です。 **ibm.appcenter.push.schedule.period.unit** の値は、「seconds」、「minutes」、または「hours」です。 単位が指定されなかった場合、数値は時間数で表される間隔です。 これらの変数は、プッシュ・メッセージのバッチとバッチの間の経過時間を定義するために使用されます。

JNDI プロパティーを使用して、これらの変数を定義します。

> **重要:** 実動では単位を「seconds」に設定しないようにしてください。 経過時間が短いほどサーバーの負荷は大きくなります。 秒で表される単位はテストと評価の目的でのみ実装されます。 例えば、経過時間が 10 秒に設定されると、プッシュ・メッセージはほぼすぐに送信されます。

設定できるすべてのプロパティーのリストについては、[Application Center のための JNDI プロパティー](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)を参照してください。

### Apache Tomcat サーバーの場合の例
{: tomcat }
server.xml ファイル内の JNDI プロパティーを使用して以下の変数を定義します。

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server v8.5
{: #websphere }
WebSphere Application Server v8.5 用に JNDI 変数を構成するには、以下のようにします。

1. **「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション (WebSphere Enterprise Applications)」**の順にクリックします。
2. Application Center サービス・アプリケーションを選択します。
3. **「Web モジュール・プロパティー」→ 「Web モジュールの環境項目」**をクリックします。
4. **「値」**列のストリングを編集します。

#### WebSphere Application Server Liberty プロファイル
{: #liberty }
WebSphere Application Server Liberty プロファイルの場合の JNDI 変数の構成方法については、[サーバー構成ファイルからの定数に対する JNDI バインディングの使用](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html)を参照してください。

プッシュ通知サービスをセットアップするための残りのアクションは、ターゲット・アプリケーションがインストールされているデバイスのベンダーによって異なります。

## Google Cloud Messaging に接続するための Application Center サーバーの構成
{: #gcm }
特定のアプリケーションについて Google Cloud Messaging (GCM) を使用可能にするには、GCM サービスを Google API 対応の開発者 Google アカウントに接続する必要があります。 詳しくは、[GCM 入門](http://developer.android.com/google/gcm/gs.html)を参照してください。

> 重要: Google Cloud Messaging のない Application Center クライアント: Application Center は Google Cloud Messaging (GCM) API が使用可能であることを想定しています。 この API は、中国など一部の地域ではデバイスで利用できない可能性があります。 このような地域をサポートするために、GCM API に依存しない Application Center クライアントのバージョンをビルドすることができます。 プッシュ通知フィーチャーは、そのバージョンの Application Center クライアントでは機能しません。 詳しくは、[GCM API に依存しないモバイル・クライアントのバージョンのビルド](#no-gcm)を参照してください。

1. 適切な Google アカウントを持っていない場合は、[Google アカウントの作成](https://mail.google.com/mail/signup)に移動し、Application Center クライアント用の Google アカウントを作成します。
2. [Google API コンソール](https://code.google.com/apis/console/)で Google API を使用して、このアカウントを登録します。 登録によって新しいデフォルト・プロジェクトが作成されます。このプロジェクトは名前変更することができます。 この GCM プロジェクトに付ける名前は、Android アプリケーション・パッケージ名とは無関係です。 プロジェクトが作成されると、GCM プロジェクト ID がプロジェクト URL の最後に追加されます。 この末尾番号は、後で必要になることがあるので、プロジェクト ID として記録してください。
3. GCM サービスをプロジェクト用に使用可能にします。Google API コンソールで、左側にある**「サービス (Services)」**タブをクリックし、サービスのリストにある "Google Cloud Messaging for Android" サービスを使用可能にします。
4. アプリケーション通信に Simple API Access Server キーが使用可能であることを確認します。
    * コンソールの左側にある**「API Access」**垂直タブをクリックします。
    * Simple API Access Server キーを作成します。あるいは、デフォルト・キーが既に作成されている場合、そのデフォルト・キーの詳細を書き留めます。 他に 2 種類のキーが存在しますが、今のところは影響のあるものではありません。
    * 将来 GCM を通じてアプリケーション通信で使用できるように Simple API Access Server キーを保存します。 このキーは長さ約 40 文字で、Google API キーと呼ばれます。このキーは、後でサーバー・サイドで必要になります。
5. Application Center Android クライアントの JavaScript プロジェクトで GCM プロジェクト ID をストリング・リソース・プロパティーとして入力します。**IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** テンプレート・ファイルで、次の行を独自の値で変更します。

   ```xml
   gcmProjectId:""// Google API project (project name = com.ibm.appcenter) ID needed for Android push.
   // example : 123456789012
   ```

6. Google API キーを Application Center サーバーの JNDI プロパティーとして登録します。 キー名は **ibm.appcenter.gcm.signature.googleapikey** です。 例えば、このキーを、**server.xml** ファイル内の JNDI プロパティーとして Apache Tomcat サーバー用に構成することができます。

   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String"
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   JNDI プロパティーは、アプリケーション・サーバーの要件に従って定義する必要があります。  
   設定できるすべてのプロパティーのリストについては、[Application Center のための JNDI プロパティー](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)を参照してください。

**重要:**

* GCM を古い Android バージョンで使用する場合は、GCM を効果的に機能させるために、デバイスと既存の Google アカウントをペアにする必要があるかもしれません。 [GCM サービス](http://developer.android.com/google/gcm/gcm.html)を参照: "GCM は Google サービス用に既存の接続を使用します。 このため、3.0 より前のデバイスでは、ユーザーはそれぞれ自分のモバイル・デバイスで自分の Google アカウントをセットアップする必要があります。 Google アカウントは、Android 4.0.4 以上が稼働するデバイスでは必要条件ではありません。"
* プッシュ通知を動作させるには、ポート 443 での android.googleapis.com への発信接続をファイアウォールが受け入れることも確認する必要があります。

## Apple Push Notification Services に接続するための Application Center サーバーの構成
{: #apns }
iOS プロジェクトを Apple Push Notification Services (APNs) 用に構成します。 以下のサーバーが Application Center サーバーからアクセス可能であることを確認します。

**Sandbox サーバー**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**実動サーバー**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

Apple Push Notification Services (APNs) で iOS プロジェクトを正常に構成するためには登録済みの Apple 開発者でなければなりません。 企業では、Apple 開発を担当する管理ロールは APNs 使用可能化を要求します。 この要求に応えて、iOS アプリケーション・バンドル用の APNs 対応プロビジョニング・プロファイル、つまり、Xcode プロジェクトの構成ページで定義されるストリング値が提供されるはずです。 このプロビジョニング・プロファイルは、シグニチャー証明書ファイルを生成するために使用されます。
プロビジョニング・プロファイルには開発プロファイルと実動プロファイルの 2 種類があり、それぞれ開発環境および実稼働環境を扱います。 開発プロファイルはもっぱら Apple 開発 APNs サーバーを扱います。 実動プロファイルはもっぱら Apple 実動 APNs サーバーを扱います。 これらの種類のサーバーは同じサービス品質を提供しません。

注: ファイアウォールを使用している会社の WiFi に接続されているデバイスは、以下のアドレス・タイプがファイアウォールでブロックされていない場合にのみプッシュ通知を受け取ることができます。

`x-courier.sandbox.push.apple.com:5223`  
ここで x は整数です。

1. Application Center Xcode プロジェクト用の APNs 対応プロビジョニング・プロファイルを取得します。 管理者の APNs 使用可能化要求の結果は、[https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action) からアクセスできるリストとして表示されます。 このリスト内の各項目は、プロファイルが APNs 能力を持っているかどうかを示します。 プロファイルがあるときは、それをダブルクリックすれば、ダウンロードして Application Center クライアント Xcode プロジェクト・ディレクトリーにインストールすることができます。 そうすると、プロファイルは自動的に鍵ストアおよび Xcode プロジェクトにインストールされます。

2. Application Center を XCode から直接起動して、それをデバイスでテストしたりデバッグしたりしたい場合は、「Xcode Organizer」ウィンドウで、「プロビジョニング・プロファイル」セクションに移動し、プロファイルをモバイル・デバイスにインストールします。

3. APNs サーバーとの通信を保護するために Application Center サービスが使用するシグニチャー証明書を作成します。 このサーバーは、APNs サーバーへのすべてのプッシュ要求に署名するためにこの証明書を使用します。 このシグニチャー証明書はプロビジョニング・プロファイルから生成されます。

* 「Keychain Access」ユーティリティーを開き、左側のペインで**「自分の証明書 (My Certificates)」**カテゴリーをクリックします。
* インストールしたい証明書を取得し、その内容を開示します。 証明書と秘密鍵の両方を確認します。Application Center については、証明書行に Application Center アプリケーション・バンドル **com.ibm.imf.AppCenter** が含まれています。
* **「ファイル (File)」→「項目のエクスポート (Export Items)」**を選択して、証明書と鍵の両方を選択し、それらを Personal Information Exchange (.p12) ファイルとしてエクスポートします。 この .p12 ファイルには、APNs サーバーと通信するためにセキュア・ハンドシェーク・プロトコルが使用されるときに必要な秘密鍵が含まれています。
* Application Center サービスの実行を担当するコンピューターに .p12 証明書をコピーし、それを適切な場所にインストールします。 APNs サーバーとのセキュア・トンネリングを作成するためには、証明書ファイルとそのパスワードの両方が必要です。 また、開発証明書と実動証明書のいずれが機能しているかを示す情報も必要です。 開発プロビジョニング・プロファイルは開発証明書を生成し、実動プロファイルは実動証明書を提供します。 Application Center サービス Web アプリケーションは、JNDI プロパティーを使用してこのセキュア・データを参照します。

表中の例は、Apache Tomcat サーバーの server.xml ファイル内で JNDI プロパティーがどのように定義されるかを示したものです。

| JNDI プロパティー	| タイプと説明 | Apache Tomcat サーバーの場合の例 |
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location | .p12 証明書への絶対パスを定義するストリング値。 | `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password | 証明書にアクセスするために必要なパスワードを定義するストリング値。 | `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` |
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate |	認証証明書を生成するために使用されたプロビジョニング・プロファイルが開発証明書であったかどうかを定義するブール値 (true か false で識別される)。 | `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` |

設定できるすべての JNDI プロパティーのリストについては、[Application Center のための JNDI プロパティー](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)を参照してください。

## GCM API に依存しないモバイル・クライアントのバージョンのビルド
{: #no-gcm }
クライアントの Android バージョンから Google Cloud Messaging (GCM) API への依存を取り除くことにより、一部の地域で制約に対応することができます。 クライアントのこのバージョンではプッシュ通知は機能しません。

Application Center は Google Cloud Messaging (GCM) API が使用可能であることを想定しています。 この API は、中国など一部の地域ではデバイスで利用できない可能性があります。 このような地域をサポートするために、GCM API に依存しない Application Center クライアントのバージョンをビルドすることができます。 プッシュ通知フィーチャーは、そのバージョンの Application Center クライアントでは機能しません。

1. **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** ファイルに `"gcmProjectId": "" ,` という行が含まれているかどうかを調べて、プッシュ通知が使用不可であることを確認します。
2. **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** ファイル内の 2 つの場所から、コメント `<!-- AppCenter Push configuration -->` とコメント `<!-- end of AppCenter Push configuration -->` の間にあるすべての行を削除します。
3. **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java** クラスを削除します。
4. Eclipse で、IBMAppCenter/apps/AppCenter/android フォルダー内の「Android 環境のビルド (Build Android Environment)」を実行します。
5. 上記の「Android 環境のビルド (Build Android Environment)」コマンドを実行したときに MobileFirst プラグインによって作成された **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar** ファイルを削除します。
6. 新しく作成された IBMAppCenterAppCenterAndroid プロジェクトを最新の情報に更新します。そうすると、GCM ライブラリーの削除が考慮されます。
7. Application Center の .apk ファイルをビルドします。

Android 環境がビルドされるたびに、MobileFirst Eclipse プラグインによって **gcm.jar** ライブラリーが自動的に追加されます。 したがって、MobileFirst Android ビルド・プロセスが実行されるたびに、この JAR ファイルを **IBMAppCenter/apps/AppCenter/android/native/libs/** ディレクトリーから削除する必要があります。 そうしないと、**gcm.jar** ライブラリーが結果の **appcenter.apk** ファイルに存在することになります。
