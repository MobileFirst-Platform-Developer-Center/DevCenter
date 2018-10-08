---
layout: tutorial
title: 非推奨および廃止された機能と API
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
削除された機能および API エレメントが、ご使用の {{ site.data.keys.product_full }} 環境にどのように影響するかを慎重に検討してください。

#### ジャンプ先
{: #jump-to }
* [V8.0 で廃止された機能および V8.0 に含まれない機能](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [サーバー・サイド API の変更](#server-side-api-changes)
* [クライアント・サイド API の変更](#client-side-api-changes)

## V8.0 で廃止された機能および V8.0 に含まれない機能
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }} v8.0 は、以前のバージョンと比較して徹底的に簡素化されています。 その簡素化の結果、V7.1 で使用可能であった機能の一部が、V8.0 では廃止されました。 ほとんどの場合、その機能を実装するための代替手段が提示されています。 そのような機能については、「廃止されました」と記載しています。 ほかに、V7.1 には存在し、V8.0 では存在しなくなったが、それは V8.0 で設計が新しくなったことが理由ではないという機能もあります。 そのように除外された機能については、v8.0 で廃止された機能と区別するために「v8.0 にはありません」と記載しています。

<table class="table table-striped">
    <tr>
        <td>機能</td>
        <td>状況および代替手段</td>
    </tr>
    <tr>
        <td><p>{{ site.data.keys.mf_studio }} に代わって、Eclipse 用の MobileFirst Studio プラグインが使用されます。</p></td>
        <td><p>標準およびコミュニティー・ベースの Eclipse プラグインによって駆動される Eclipse 用の {{ site.data.keys.mf_studio }} プラグインに置き換えられました。 Apache Cordova CLI を使用するか、または Visual Studio Code、Eclipse、IntelliJ などの Cordova 対応 IDE を使用して、直接、ハイブリッド・アプリケーションを開発することができます。Eclipse を Cordova 対応 IDE として使用する方法について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">Cordova プロジェクトを Eclipse で管理するための IBM {{ site.data.keys.mf_studio }} プラグイン</a>を参照してください。</p>

        <p>アダプターの開発は、Apache Maven を使用するか、Eclipse および IntelliJ などの Maven 対応 IDE を使用して行うことができます。 アダプターの開発について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">アダプターのカテゴリー (Adapters category)</a>を参照してください。 Eclipse を Maven 対応 IDE として使用する方法について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">Eclipse でのアダプターの開発</a>のチュートリアルを参照してください。</p>

        <p>{{ site.data.keys.mf_dev_kit_full }} をインストールして、{{ site.data.keys.mf_server }} でアダプターおよびアプリケーションをテストします。 NPM、Maven、Cocoapod、または NuGet などのインターネット・ベースのリポジトリーからダウンロードしたくない場合は、{{ site.data.keys.product_adj }} 開発ツールおよび SDK にアクセスすることもできます。 {{ site.data.keys.mf_dev_kit }} について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>を参照してください。</p>
        </td>
    </tr>
    <tr>
        <td><p>ハイブリッド・アプリケーション用のスキン、シェル「設定」ページ、ミニファイ、および JavaScript UI エレメントは、廃止されました。</p></td>
        <td><p>廃止されました。 ハイブリッド・アプリケーションは、直接、Apache Cordova を使用して開発されます。 スキン、シェル、「設定」ページ、およびミニファイの置き換えについて詳しくは、『削除されたコンポーネント』および『V8.0 を使用して開発した Cordova アプリケーションと V7.1 以前を使用して開発した Cordova アプリケーションの比較』を参照してください。</p>
        </td>
    </tr>
    <tr>
        <td><p>ハイブリッド・アプリケーションの場合、Sencha Touch を {{ site.data.keys.product_adj }} プロジェクトにインポートすることはできなくなりました。</p></td>
        <td><p>廃止されました。 {{ site.data.keys.product_adj }} ハイブリッド・アプリケーションは、直接、Apache Cordova を使用して開発され、{{ site.data.keys.product_adj }} 機能は Cordova プラグインとして提供されます。 Sencha Touch および Cordova を統合するには、Sencha Touch の資料を参照してください。</p>
        </td>
    </tr>
    <tr>
        <td><p>暗号化されたキャッシュは廃止されました。</p></td>
        <td><p>廃止されました。 暗号化されたデータをローカルに保管するには、JSONStore を使用してください。 JSONStore について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">JSONStore</a> のチュートリアルを参照してください。</p>
        </td>
    </tr>
    <tr>        
        <td><p>オンデマンドのダイレクト・アップデートのトリガー機能は v8.0 にはありません。 クライアント・アプリケーションは、セッション用の OAuth トークンを取得するときにダイレクト・アップデートをチェックします。 v8.0 では、異なる時点でダイレクト・アップデートをチェックするようにクライアント・アプリケーションのプログラムを作成することはできません。</p></td>
        <td><p>v8.0 にはありません。</p></td>
    </tr>
    <tr>
        <td><p>セッション依存関係構成を持つアダプター。 V7.1.0 では、セッション非依存モード (デフォルト) またはセッション依存モードで作業するように {{ site.data.keys.mf_server }} を構成することができました。 v8.0 から、セッション依存モードはサポートされなくなりました。 サーバーは、基本的に HTTP セッションから独立しており、関連する構成は必要ありません。</p></td>
        <td><p>廃止されました。</p></td>
    </tr>
    <tr>
        <td><p>IBM WebSphere eXtreme Scale を介した属性ストアは v8.0 ではサポートされません。</p></td>
        <td><p>v8.0 にはありません。</p></td>
    </tr>
    <tr>
        <td><p>IBM Business Process Manager (IBM BPM) プロセス・アプリケーション、Microsoft Azure Marketplace DataMarket、OData RESTful API、RESTful リソース、SAP Netweaver Gateway が公開するサービス、および Web サービス向けの、サービス・ディスカバリーおよびアダプター生成機能は、v8.0 にはありません。</p></td>
        <td><p>v8.0 にはありません。</p></td>
    </tr>
    <tr>
        <td>JMS JavaScript アダプターは v8.0 にはありません。</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>SAP ゲートウェイ JavaScript アダプターは v8.0 にはありません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>SAP JCo JavaScript アダプターは v8.0 にはありません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>Cast Iron JavaScript アダプターは v8.0 にはありません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>OData および Microsoft Azure OData JavaScript アダプターは v8.0 にはありません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>USSD 向けのプッシュ通知は、v8.0 ではサポートされていません。	</td>
        <td>廃止されました。</td>
    </tr>
    <tr>
        <td>イベント・ベースのプッシュ通知は、v8.0 ではサポートされていません。	</td>
        <td>廃止されました。 プッシュ通知サービスを使用してください。 プッシュ通知サービスへのマイグレーションについて詳しくは、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』のトピックを参照してください。</td>
    </tr>
    <tr>
      <td>
        セキュリティー: アンチクロスサイト・リクエスト・フォージェリー (アンチ XSRF) レルム (<code>wl_antiXSRFRealm</code>) は V8.0 では必要ありません。
      </td>
      <td>
        V7.1.0 では、認証コンテキストは HTTP セッションに保管され、セッション Cookie によって識別され、それは、ブラウザーによってクロスサイト要求内で送信されます。 このバージョンでのアンチ XSRF レルムは、クライアントからサーバーに送信される追加のヘッダーを使用して、XSRF 攻撃に対して Cookie の伝送を保護するために使用されます。
        <br />
        V8.0.0 では、セキュリティー・コンテキストは HTTP セッションに関連付けられることがなく、セッション Cookie によって識別されることもなくなりました。
        代わりに、Authorization ヘッダーに渡される OAuth 2.0 アクセス・トークンを使用して、許可されます。
        Authorization ヘッダーはブラウザーによってクロスサイト要求内で送信されないため、XSRF 攻撃に対して保護する必要はありません。
      </td>
    </tr>
    <tr>
        <td>セキュリティー: ユーザー証明書認証。 v8.0 には、X.509 クライアント・サイド証明書によってユーザーを認証するための定義済みセキュリティー検査は含まれていません。</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>セキュリティー: IBM Trusteer との統合。 v8.0 には、IBM Trusteer のリスク要因をテストするための定義済みのセキュリティー検査もチャレンジも含まれていません。</td>
        <td>v8.0 にはありません。 IBM Trusteer Mobile SDK を使用してください。</td>
    </tr>
    <tr>
        <td>セキュリティー: デバイス・プロビジョニングおよびデバイス自動プロビジョニング。	</td>
        <td><p>廃止されました。</p><p>注: デバイス・プロビジョニングは、通常の許可フローで処理されます。 デバイス・データは、セキュリティー・フローの登録プロセスの間に、自動的に収集されます。 セキュリティー・フローについて詳しくは、『エンドツーエンドの許可フロー (End-to-end authorization flow)』を参照してください。</p>
        </td>
    </tr>
    <tr>
        <td>セキュリティー: ProGuard を使用して Android コードを難読化するための構成ファイル。 v8.0 には、MobileFirst Android アプリケーションで Android ProGuard 難読化を行うための定義済みの proguard-project.txt 構成ファイルは含まれていません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>セキュリティー: アダプター・ベースの認証は、置き換えられます。 認証では OAuth プロトコルを使用し、セキュリティー検査を行うように認証が実装されます。</td>
        <td>セキュリティー検査ベースの実装が代わりに使用されます。</td>
    </tr>
    <tr>
        <td><p>セキュリティー: LDAP ログイン。 v8.0 には、LDAP サーバーでユーザーを認証するための定義済みのセキュリティー検査は含まれていません。</p>
        <p>代わりに、WebSphere Application Server または WebSphere Application Server Liberty の場合、アプリケーション・サーバーまたはゲートウェイを使用して LDAP などの ID プロバイダーを LTPA にマップし、LTPA セキュリティー検査を使用してユーザー用の OAuth トークンを生成します。</p></td>
        <td>v8.0 にはありません。 WebSphere Application Server または WebSphere Application Server Liberty の場合、LTPA セキュリティー検査を代わりに使用してください。</td>
    </tr>
    <tr>
        <td>
        HTTP アダプターの認証構成。 定義済みの HTTP アダプターは、リモート・サーバーへのユーザーとしての接続をサポートしません。</td>
        <td><p>v8.0 にはありません。</p><p>HTTP アダプターのソース・コードを編集し、認証コードを追加します。 <code>MFP.Server.invokeHttp</code> を使用して、ID トークンを HTTP 要求のヘッダーに追加します。</p></td>
    </tr>
    <tr>
        <td>
        セキュリティー分析 (MobileFirst Analytics コンソールで MobileFirst セキュリティー・フレームワークのイベントをモニターする機能) は、v8.0 にはありません。</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>プッシュ通知用のイベント・ソース・ベースのモデルは廃止され、代わりにタグ・ベースのプッシュ・サービス・モデルが使用されます。</td>
        <td>これは廃止され、代わりにタグ・ベースのプッシュ・サービス・モデルが使用されます。</td>
    </tr>
    <tr>
        <td>Unstructured Supplementary Service Data (USSD) のサポートは v8.0 にはありません。</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_server }} 用のデータベースとして使用される Cloudant は、V8.0 ではサポートされません。	</td>
        <td>v8.0 にはありません。</td>
    </tr>
    <tr>
        <td>地理位置情報: 地理位置情報のサポートは、{{ site.data.keys.product }} v8.0 では廃止されました。 ビーコンおよびメディエーター用の REST API は廃止されました。 クライアント・サイドおよびサーバー・サイドの API の WL.Geo および WL.Device は廃止されました。	</td>
        <td>廃止されました。 地理位置情報には、ネイティブ・デバイス API またはサード・パーティーの Cordova プラグインを使用してください。</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.product_adj }} データ・プロキシー機能は廃止されました。 Cloudant の IMFData API と CloudantToolkit API も廃止されました。	</td>
        <td>廃止されました。 アプリケーション内の IMFData API と CloudantToolkit API を置き換える方法について詳しくは、『IMFData または Cloudant SDK を使用して Cloudant にモバイル・データを保管するアプリケーションのマイグレーション (Migrating apps storing mobile data in Cloudant with IMFData or Cloudant SDK)』を参照してください。</td>
    </tr>
    <tr>
        <td>IBM Tealeaf SDK は {{ site.data.keys.product }} にバンドルされなくなりました。	</td>
        <td>廃止されました。 IBM Tealeaf SDK を使用してください。 詳しくは、IBM Tealeaf Customer Experience 資料の『<a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a>』および 『<a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a>』を参照してください。</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_test_workbench_full }} は {{ site.data.keys.product }} にバンドルされていません。</td>
        <td>廃止されました。</td>
    </tr>
    <tr>
        <td>BlackBerry、Adobe AIR、Windows Silverlight は、{{ site.data.keys.product }} v8.0 ではサポートされません。 これらのプラットフォーム用の SDK は提供されていません。	</td>
        <td>廃止されました。</td>
    </tr>
</table>

## サーバー・サイド API の変更
{: #server-side-api-changes }
{{ site.data.keys.product_adj }} アプリケーションのサーバー・サイドをマイグレーションするには、API の変更を考慮に入れてください。  
以下の表は、v8.0 で使用が中止されたサーバー・サイド API エレメント、v8.0 で非推奨となったサーバー・サイド API エレメント、および推奨されるマイグレーション・パスをリストしたものです。 アプリケーションのサーバー・サイドのマイグレーションについての詳細情報があります。

### v8.0 で使用が中止された JavaScript API エレメント
{: #javascript-api-elements-discontinued-v-v-80 }
#### セキュリティー
{: #security }

| API エレメント                         | 置換パス                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUser`、`WL.Server.getCurrentUserIdentity`、`WL.Server.getCurrentDeviceIdentity`、`WL.Server.setActiveUser`、`WL.Server.getClientId`、`WL.Server.getClientDeviceContext`、`WL.Server.setApplicationContext` | 代わりに `MFP.Server.getAuthenticatedUser` を使用してください。 |

#### イベント・ソース
{: #event-source }

| API エレメント                         | 置換パス                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | 代わりに `MFP.Server.getAuthenticatedUser` を使用してください。 |
| `WL.Server.setEventHandlers`         | イベント・ソース・ベースの通知からタグ・ベースの通知にマイグレーションするには、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』を参照してください。                                                     |
| `WL.Server.createEventHandler`       |                                                |
| `WL.Server.createSMSEventHandler`	 | SMS メッセージを送信するには、プッシュ・サービス REST API を使用します。 詳しくは、[通知の送信](../../../notifications/sending-notifications)を参照してください。                         |
| `WL.Server.createUSSDEventHandler`	 | サード・パーティー・サービスを使用して USSD を統合します。  |

#### プッシュ
{: #push }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`、`WL.Server.notifyAllDevices`、`WL.Server.sendMessage`、`WL.Server.notifyDevice`、`WL.Server.notifyDeviceSubscription`、`WL.Server.notifyAll`、`WL.Server.createDefaultNotification`、`WL.Server.submitNotification` 	| イベント・ソース・ベースの通知からタグ・ベースの通知にマイグレーションするには、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』を参照してください。 |
| `WL.Server.subscribeSMS`	                | REST API の Push Device Registration (POST) を使用してデバイスを登録します。 SMS 通知を送受信するには、この API を起動している時にペイロードに phoneNumber を指定してください。                               |
| `WL.Server.unsubscribeSMS`	                | REST API Push Device Registration (DELETE) を使用してデバイスを登録抹消します。 |
| `WL.Server.getSMSSubscription`	            | REST API Push Device Registration (GET) を使用してデバイス登録を取得します。 |

#### ロケーション・サービス
{: #location-services }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | サード・パーティー・サービスを使用してロケーション・サービスを統合します。 |

#### WS-Security
{: #ws-security }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | WebSphere Application Server の WS-Security 機能を使用します。 |

### v8.0 で使用が中止された Java API エレメント
{: #java-api-elements-discontinued-in-v-80 }
#### セキュリティー
{: #security-java }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | 代わりに AdapterSecurityContext を使用してください。            |

#### プッシュ
{: #push-java }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| イベント・ソース・ベースの通知からタグ・ベースの通知にマイグレーションするには、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』を参照してください。 |
| `INotification PushAPI.buildNotification();` | イベント・ソース・ベースの通知からタグ・ベースの通知にマイグレーションするには、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』を参照してください。 |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | イベント・ソース・ベースの通知からタグ・ベースの通知にマイグレーションするには、『イベント・ソース・ベースの通知からプッシュ通知へのマイグレーション』を参照してください。 |

#### アダプター
{: #adapters-java }

| API エレメント                                | 置換パス                               |
|-------------------------------------------|------------------------------------------------|
| `com.worklight.adapters.rest.api パッケージ`の `AdaptersAPI` インターフェース | 代わりに、`com.ibm.mfp.adapter.api` パッケージの `AdaptersAPI` インターフェースを使用してください。 |
| `com.worklight.adapters.rest.api` パッケージの `AnalyticsAPI` インターフェース | 代わりに、`com.ibm.mfp.adapter.api` パッケージの `AnalyticsAPI` インターフェースを使用してください。 |
| `com.worklight.adapters.rest.api` パッケージの `ConfigurationAPI` インターフェース | 代わりに、`com.ibm.mfp.adapter.api` パッケージの `ConfigurationAPI` インターフェースを使用してください。 |
| `com.worklight.core.auth` パッケージの `OAuthSecurity` アノテーション | 代わりに、`com.ibm.mfp.adapter.api` パッケージの `OAuthSecurity` アノテーションを使用してください。 |
| `com.worklight.wink.extensions` パッケージの `MFPJAXRSApplication` クラス | 代わりに、`com.ibm.mfp.adapter.api` パッケージの `MFPJAXRSApplication` クラスを使用してください。 |
| `com.worklight.adapters.rest.api` パッケージの `WLServerAPI` インターフェース | JAX-RS `Context` アノテーションを使用して、{{ site.data.keys.product_adj }} API インターフェースに直接アクセスしてください。 |
| `com.worklight.adapters.rest.api` パッケージの `WLServerAPIProvider` クラス | JAX-RS `Context` アノテーションを使用して、{{ site.data.keys.product_adj }} API インターフェースに直接アクセスしてください。 |

## クライアント・サイド API の変更
{: #client-side-api-changes }
以下に示す API の変更は、{{ site.data.keys.product_adj }} クライアント・アプリケーションのマイグレーションに関連しています。  
以下の表は、V8.0.0 で使用が中止されたクライアント・サイド API エレメント、V8.0.0 で非推奨となったクライアント・サイド API エレメント、および推奨されるマイグレーション・パスをリストしたものです。

### JavaScript API
{: #javascript-apis }
ユーザー・インターフェースに影響する以下の JavaScript API は、v8.0 ではサポートされなくなっています。 使用可能なサード・パーティーの Cordova プラグインに置き換えるか、カスタム Cordova プラグインを作成して置き換えることができます。

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WL.BusyIndicator`、`WL.OptionsMenu`、`WL.TabBar`、`WL.TabBarItem` | Cordova プラグインまたは HTML 5 エレメントを使用してください。 |
| `WL.App.close` | {{ site.data.keys.product_adj }} の外部でこのイベントを処理してください。 |
| `WL.App.copyToClipboard()` | この機能を提供する Cordova プラグインを使用してください。 |
| `WL.App.openUrl(url, target, options)` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、Cordova の **InAppBrowser** プラグインがこの機能を提供しています。 |
| `WL.App.overrideBackButton(callback)`、`WL.App.resetBackButton()` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、Cordova の **backbutton** プラグインがこの機能を提供しています。 |
| `WL.App.getDeviceLanguage()` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、Cordova の **cordova-plugin-globalization** プラグインがこの機能を提供しています。 |
| `WL.App.getDeviceLocale()` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、Cordova の **cordova-plugin-globalization** プラグインがこの機能を提供しています。 |
| `WL.App.BackgroundHandler` | カスタム・ハンドラー関数を実行するには、標準 Cordova pause イベント・リスナーを使用してください。 プライバシーを保護し、iOS システム、Android システム、およびユーザーがスナップショットまたは画面キャプチャーを取るのを防止する Cordova プラグインを使用します。 詳しくは、**[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**の説明を参照してください。 |
| `WL.Client.close`、`WL.Client.restore`、`WL.Client.minimize` | これらの関数は、{{ site.data.keys.product }} V8.0.0 でサポートされていない Adobe AIR プラットフォームをサポートするために提供されていました。 |
| `WL.Toast.show(string)` | Toast 用 Cordova プラグインを使用してください。 |

以下の一連の API は、v8.0 でサポートされなくなっています。

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WL.Client.checkForDirectUpdate(options)` | 代替はありません。 **注:** ダイレクト・アップデートが使用可能な場合は、`WLAuthorizationManager.obtainAccessToken` を呼び出してトリガーすることができます。 サーバーでダイレクト・アップデートが使用可能な場合は、セキュリティー・トークンにアクセスするとダイレクト・アップデートがトリガーされます。 ただし、ダイレクト・アップデートをオンデマンドでトリガーすることはできません。 |
| `WL.Client.setSharedToken({key: myName, value: myValue})`、`WL.Client.getSharedToken({key: myName})`、`WL.Client.clearSharedToken({key: myName})` | 代替はありません。 |
| `WL.Client.isConnected()`、`connectOnStartup` init option | `WLAuthorizationManager.obtainAccessToken` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。 |
| `WL.Client.setUserPref(key,value, options)`、`WL.Client.setUserPrefs(userPrefsHash, options)`、`WL.Client.deleteUserPrefs(key, options)` | 代替はありません。 アダプターおよび `MFP.Server.getAuthenticatedUser` API を使用してユーザー設定を管理することができます。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 代替はありません。 |
| `WL.Client.logActivity(activityType)` | `WL.Logger` を使用してください。 |
| `WL.Client.login(realm, options)` | `WLAuthorizationManager.login` を使用してください。 認証およびセキュリティーを開始するには、『認証およびセキュリティー』のチュートリアルを参照してください。 |
| `WL.Client.logout(realm, options)` | `WLAuthorizationManager.logout` を使用してください。 |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | `WLAuthorizationManager.obtainAccessToken` を使用してください。 |
| `WL.Client.transmitEvent(event, immediate)`、`WL.Client.purgeEventTransmissionBuffer()`、`WL.Client.setEventTransmissionPolicy(policy)` | これらのイベントの通知を受け取るためのカスタム・アダプターを作成してください。 |
| `WL.Device.getContext()`、`WL.Device.startAcquisition(policy, triggers, onFailure)`、`WL.Device.stopAcquisition()`、`WL.Device.Wifi`、`WL.Device.Geo.Profiles`、`WL.Geo` | GeoLocation 用のネイティブ API またはサード・パーティーの Cordova プラグインを使用します。 |
| `WL.Client.makeRequest (url, options)` | 同じ機能を提供するカスタム・アダプターを作成してください。 |
| `WLDevice.getID(options)` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、c**ordova-plugin-device** プラグインからの `device.uuid` がこの機能を提供しています。 |
| `WL.Device.getFriendlyName()` | `WL.Client.getDeviceDisplayName` を使用してください。 |
| `WL.Device.setFriendlyName()` | `WL.Client.setDeviceDisplayName` を使用してください。 |
| `WL.Device.getNetworkInfo(callback)` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、**cordova-plugin-network-information** プラグインがこの機能を提供しています。 |
| `WLUtils.wlCheckReachability()` | サーバーの可用性を検査するカスタム・アダプターを作成してください。 |
| `WL.EncryptedCache` | JSONStore を使用して暗号化されたデータをローカルに保管します。 JSONStore は **cordova-plugin-mfp-jsonstore** プラグインに含まれています。 詳しくは、『[JSONStore](../../../application-development/jsonstore)』を参照してください。 |
| `WL.SecurityUtils.remoteRandomString(bytes)` | 同じ機能を提供するカスタム・アダプターを作成してください。 |
| `WL.Client.getAppProperty(property)` | **cordova-plugin-appversion** プラグインを使用して、アプリケーション・バージョン・プロパティーを取得できます。 返されるバージョンは、ネイティブ・アプリケーション・バージョンです (Android および iOS のみ)。 |
| `WL.Client.Push.*` | **cordova-plugin-mfp-push** プラグインの JavaScript クライアント・サイドのプッシュ API を使用してください。 |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)` を使用してプッシュおよび SMS 用のデバイスを登録します。 |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | `WLAuthorizationManager.obtainAccessToken` を使用して、必要なスコープのトークンを取得します。 |
| `WLClient.getLastAccessToken(scope)` | `WLAuthorizationManager.obtainAccessToken` を使用してください。 |
| `WLClient.getLoginName()`、`WL.Client.getUserName(realm)` | 代替はありません。 |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | `WLAuthorizationManager.isAuthorizationRequired` および `WLAuthorizationManager.getResourceScope` を使用してください。 |
| `WL.Client.isUserAuthenticated(realm)` | 代替はありません。 |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | 代替はありません。 |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | 代替はありません。 |
| `WL.Client.createChallengeHandler(realmName)` | カスタム・ゲートウェイ・チャレンジを処理するためのチャレンジ・ハンドラーを作成するには、`WL.Client.createGatewayChallengeHandler(gatewayName)` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジを処理するためのチャレンジ・ハンドラーを作成するには、`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)` を使用します。 |
| `WL.Client.createWLChallengeHandler(realmName)` | `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)` を使用します。 |
| `challengeHandler.isCustomResponse()`。ここで、challengeHandler は、`WL.Client.createChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。 | `gatewayChallengeHandler.canHandleResponse()` を使用します。ここで、`gatewayChallengeHandler` は、`WL.Client.createGatewayChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。 |
| `wlChallengeHandler.processSucccess()`。ここで、`wlChallengeHandler` は、`WL.Client.createWLChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。 | `securityCheckChallengeHandler.handleSuccess()` を使用します。ここで、`securityCheckChallengeHandler` は、`WL.Client.createSecurityCheckChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトです。 |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`WL.Client.createGatewayChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトを使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`WL.Client.createSecurityCheckChallengeHandler()` によって返されるチャレンジ・ハンドラー・オブジェクトを使用します。 |
| `WL.Client.createProvisioningChallengeHandler()` | 代替はありません。 デバイス・プロビジョニングは、自動的にセキュリティー・フレームワークによって処理されるようになりました。 |

#### 非推奨になった JavaScript API
{: #deprecated-javascript-apis }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`、`WL.Client.invokeProcedure(invocationData, options)`、`WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`、`WLProcedureInvocationResult` | 代わりに `WLResourceRequest` を使用してください。 **注:** `invokeProcedure` の実装は、`WLResourceRequest` を使用します。 |
| `WLClient.getEnvironment` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、**device.platform** プラグインがこの機能を提供しています。 |
| `WLClient.getLanguage` | この機能を提供する Cordova プラグインを使用してください。 **注:** ご参考までに、**cordova-plugin-globalization** プラグインがこの機能を提供しています。 |
| `WL.Client.connect(options)` | `WLAuthorizationManager.obtainAccessToken` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。 |

### Android API
{: #android-apis}
####  使用が中止された Android API エレメント
{: #discontinued-android-api-elements }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WLConfig WLClient.getConfig()` | 代替はありません。 |
| `WLDevice WLClient.getWLDevice()`、`WLClient.transmitEvent(org.json.JSONObject event)`、`WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`、`WLClient.purgeEventTransmissionBuffer()` | GeoLocation 用の Android API またはサード・パーティー・パッケージを使用してください。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 代替はありません。 |
| `WL.Client.getUserInfo(realm, key`、`WL.Client.updateUserInfo(options)` | 代替はありません。 |
| `WLClient.checkForNotifications()` | `WLAuthorizationManager.obtainAccessToken("", listener)` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。 |
| `WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`、`WLClient.login(java.lang.String realmName, WLRequestListener listener)` | `AuthorizationManager.login()` を使用してください。 |
| `WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`、`WLClient.logout(java.lang.String realmName, WLRequestListener listener)` | `AuthorizationManager.logout()` を使用してください。 |
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | `WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。 |
| `WLClient.getLastAccessToken()`、`WLClient.getLastAccessToken(java.lang.String scope)` | `AuthorizationManager` を使用してください。 |
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | `AuthorizationManager` を使用してください。 |
| `WLClient.logActivity(java.lang.String activityType)` | `com.worklight.common.Logger` を使用してください。 詳しくは、『ロガー SDK』を参照してください。 |
| `WLAuthorizationPersistencePolicy` | 代替はありません。 許可パーシスタンスを実装するには、許可トークンをアプリケーション・コードに保管し、カスタム HTTP 要求を作成します。 |
| `WLSimpleSharedData.setSharedToken(myName, myValue)`、`WLSimpleSharedData.getSharedToken(myName)`、`WLSimpleSharedData.clearSharedToken(myName)` | Android API を使用して、アプリケーション間でトークンを共有してください。 |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | 代替はありません。 |
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | `BaseChallengeHandler.cancel()` を使用します。 |
| `ChallengeHandler` | カスタム・ゲートウェイ・チャレンジには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、`SecurityCheckChallengeHandler` を使用します。 |
| `WLChallengeHandler` | `SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler.isCustomResponse()` | `GatewayChallengeHandler.canHandleResponse()` を使用します。 |
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler` を使用します。 |

#### 非推奨になった Android API
{: #deprecated-android-apis }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` | 非推奨。 `WLResourceRequest` を使用してください。 **注:** `invokeProcedure` の実装は、`WLResourceRequest` を使用します。 |
| `WLClient.connect(WLResponseListener responseListener)`、`WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` | `WLAuthorizationManager.obtainAccessToken("", listener)` を使用してサーバーへの接続を検査し、アプリケーション管理ルールを適用します。 |

#### サポートされなくなった、レガシー org.apach.http API に依存している Android API
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `org.apache.http.Header[]` は非推奨になっています。 そのため、以下のメソッドは削除されました。||
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | 代わりに、新しい `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API を使用してください。 |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | 代わりに、新しい `WLResourceRequest.addHeader(String name, String value)` API を使用してください。 |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | 代わりに、新しい `List<String> WLResourceRequest.getHeaders(String headerName)` API を使用してください。 |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | 代わりに、新しい `WLResourceRequest.getHeaders(String headerName)` API を使用してください。 |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | 代わりに、新しい `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API を使用してください。 |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | 代わりに、新しい `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API を使用してください。 |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | `ClearableCookieJar WLClient.getPersistentCookies()` に置き換えられました。 |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | 代替はありません。 MFP クライアントでは、サーキュラー・リダイレクトが許可されます。 |
| `WLHttpResponseListener`、`WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`、`WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`、`WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`、`WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`、`WLResourceRequest.send(WLHttpResponseListener listener)`、`WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`、`WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` | 非推奨になった Apache HTTP クライアント依存関係のために削除されました。 要求および応答を完全に制御できる独自の要求を作成してください。 |

#### `com.worklight.androidgap.api` パッケージは、Cordova アプリケーションに Android プラットフォーム機能を提供します。 {{ site.data.keys.product }} では、Cordova 統合に対応するために多くの変更が行われました。
{: #comworklightandroidgapapi }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| Android アクティビティーは Android コンテキストに置き換えられました。 | |
| `static WL.createInstance(android.app.Activity activity)` | `static WL.createInstance(android.content.Context context)` は共有インスタンスを作成します。 |
| `static WL.getInstance()` |  `static WL.getInstance()` は WL クラスのインスタンスを取得します。 このメソッドを `WL.createInstance(Context)` の前に呼び出すことはできません。 |

### Objective-C API
{: #objective-c-apis }
#### 使用が中止された iOS Objective C API
{: #discontinued-ios-objective-c-apis }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `[WLClient getWLDevice][WLClient transmitEvent:]`、`[WLClient setEventTransmissionPolicy]`、`[WLClient purgeEventTransmissionBuffer]` | 地理位置情報は削除されました。 GeoLocation 用のネイティブ iOS またはサード・パーティー・パッケージを使用してください。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 代替はありません。 |
| `WL.Client.deleteUserPref(key, options)` | 代替はありません。 アダプターおよび `MFP.Server.getAuthenticatedUser` API を使用してユーザー設定を管理することができます。 |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | `WLAuthorizationManager obtainAccessTokenForScope` を使用してください。 |
| `[WLClient login:withDelegate:]` | `WLAuthorizationManager login` を使用してください。 |
| `[WLClient logout:withDelegate:]` | `WLAuthorizationManager logout` を使用してください。 |
| `[WLClient lastAccessToken]`、`[WLClient lastAccessTokenForScope:]` | `WLAuthorizationManager obtainAccessTokenForScope` を使用してください。 |
| `[WLClient obtainAccessTokenForScope:withDelegate:]`、`[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` | `WLAuthorizationManager obtainAccessTokenForScope` を使用してください。 |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | IBMMobileFirstPlatformFoundationPush フレームワークの iOS アプリケーション用 Objective-C クライアント・サイド・プッシュ API を使用してください。 |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | IBMMobileFirstPlatformFoundationPush フレームワークの iOS アプリケーション用 Objective-C クライアント・サイド・プッシュ API を使用してください。 |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | 非推奨。 代わりに `WLResourceRequest` を使用してください。 |
| `WLClient sendUrlRequest:delegate:]` | 代わりに `[WLResourceRequest sendWithDelegate:delegate]` を使用してください。 |
| `[WLClient (void) logActivity:(NSString *) activityType]` | 削除されました。 Objective C ロガーを使用してください。 |
| `[WLSimpleDataSharing setSharedToken: myName value: myValue]`、`[WLSimpleDataSharing getSharedToken: myName]]`、`[WLSimpleDataSharing clearSharedToken: myName]` | OS API を使用して、アプリケーション間でトークンを共有してください。 |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | `BaseChallengeHandler.cancel()` を使用します。 |
| `BaseProvisioningChallengeHandler` | 代替はありません。 デバイス・プロビジョニングは、自動的にセキュリティー・フレームワークによって処理されるようになりました。 |
| `ChallengeHandler` | カスタム・ゲートウェイ・チャレンジには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、`SecurityCheckChallengeHandler` を使用します。 |
| `WLChallengeHandler` | `SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler.isCustomResponse()` | `GatewayChallengeHandler.canHandleResponse()` を使用します。 |
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`SecurityCheckChallengeHandler` を使用します。 |

### Windows C# API
{: #windows-c-apis }
#### 非推奨となった Windows C# API エレメント - クラス
{: #deprecated-windows-c-api-elements-classes }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `ChallengeHandler` | カスタム・ゲートウェイ・チャレンジには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジには、`SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler. isCustomResponse()` | `GatewayChallengeHandler.canHandleResponse()` を使用します。 |
| `ChallengeHandler.submitAdapterAuthentication` | チャレンジ・ハンドラーで同様のロジックを実装してください。 カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`SecurityCheckChallengeHandler` を使用します。 |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | カスタム・ゲートウェイ・チャレンジ・ハンドラーには、`GatewayChallengeHandler.Shouldcancel()` を使用します。 {{ site.data.keys.product_adj }} セキュリティー検査チャレンジ・ハンドラーには、`SecurityCheckChallengeHandler.ShouldCancel()` を使用します。 |
| `WLAuthorizationManager` | 代わりに、`WorklightClient.WorklightAuthorizationManager` を使用してください。 |
| `WLChallengeHandler` | `SecurityCheckChallengeHandler` を使用します。 |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)` | `SecurityCheckChallengeHandler.ShouldCancel()` を使用します。 |
| `WLClient` | 代わりに、`WorklightClient` を使用してください。 |
| `WLErrorCode` | サポートされません。 |
| `WLFailResponse` | 代わりに、`WorklightResponse` を使用してください。 |
| `WLResponse` | 代わりに、`WorklightResponse` を使用してください。 |
| `WLProcedureInvocationData` | 代わりに、`WorklightProcedureInvocationData` を使用してください。 |
| `WLProcedureInvocationFailResponse` | サポートされません。 |
| `WLProcedureInvocationResult` | サポートされません。 |
| `WLRequestOptions` | サポートされません。 |
| `WLResourceRequest` | サポートされません。 |

#### 非推奨となった Windows C# API エレメント - インターフェース
{: #deprecated-windows-c-api-elements-interfaces }

| API エレメント           | マイグレーション・パス                           |
|-----------------------|------------------------------------------|
| `WLHttpResponseListener` | サポートされません。 |
| `WLResponseListener` | 応答は `WorklightResponse` オブジェクトとして使用可能です。 |
| `WLAuthorizationPersistencePolicy` | サポートされません。 |
