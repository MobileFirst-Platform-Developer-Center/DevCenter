---
layout: tutorial
title: MobileFirst Server の構成
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
バックアップおよびリカバリーの方針を検討し、{{ site.data.keys.mf_server }} Server 構成を最適化し、アクセス制限およびセキュリティー・オプションを適用します。

#### ジャンプ先
{: #jump-to }

* [{{ site.data.keys.mf_server }} 実動サーバーのエンドポイント](#endpoints-of-the-mobilefirst-server-production-server)
* [TLS V1.2 を使用可能にするための {{ site.data.keys.mf_server }} の構成](#configuring-mobilefirst-server-to-enable-tls-v12)
* [{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成](#configuring-user-authentication-for-mobilefirst-server-administration)
* [{{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーのリスト](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [データ・ソースの構成](#configuring-data-sources)
* [ロギングとモニタリングのメカニズムの構成](#configuring-logging-and-monitoring-mechanisms)
* [複数ランタイムの構成](#configuring-multiple-runtimes)
* [ライセンス・トラッキングの構成](#configuring-license-tracking)
* [WebSphere Application Server SSL 構成および HTTP アダプター](#websphere-application-server-ssl-configuration-and-http-adapters)

## {{ site.data.keys.mf_server }} 実動サーバーのエンドポイント
{: #endpoints-of-the-mobilefirst-server-production-server }
IBM {{ site.data.keys.mf_server }} のエンドポイントに対してホワイトリストおよびブラックリストを作成できます。

> **注:** {{ site.data.keys.product }} によって公開されている URL に関する情報を、ガイドラインとして提供しています。組織は、ホワイトリストとブラックリストで有効になっているものに基づいて、それらの URL を企業のインフラストラクチャーで確実にテストする必要があります。

| `<runtime context root>/api/` の下の API URL | 説明                               | ホワイトリストとして推奨されるか? |
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | 指定されたアダプターに関して、アダプターの Swagger 文書を返す | いいえ。管理者と開発者が内部でのみ使用します。 |
| /adapters/*  | アダプターのサービス提供 | はい |
| /az/v1/authorization/* | クライアントが特定のスコープにアクセスすることを許可する | はい |
| /az/v1/introspection | クライアントのアクセス・トークンをイントロスペクトする | いいえ。この API は機密のクライアント専用です。 |
| /az/v1/token | クライアントのアクセス・トークンを生成する | はい |
| /clientLogProfile/* | クライアント・ログ・プロファイルを取得する | はい |
| /directupdate/* | ダイレクト・アップデートの .zip ファイルを取得する | はい (ダイレクト・アップデートの使用を予定している場合) |
| /loguploader | クライアント・ログをサーバーにアップロードする | はい |
| /preauth/v1/heartbeat | クライアントからのハートビートを受け入れ、最後のアクティビティー時刻をメモする | はい |
| /preauth/v1/logout | セキュリティー検査からログアウトする | はい |
| /preauth/v1/preauthorize | 特定のスコープのセキュリティー検査をマップし、実行する | はい |
| /reach | サーバーは到達可能 | いいえ。内部使用専用です。 |
| /registration/v1/clients/* | 登録サービス・クライアント API | いいえ。この API は機密のクライアント専用です。 |
| /registration/v1/self/* | 登録サービス・クライアントのセルフ登録 API | はい |

## TLS V1.2 を使用可能にするための {{ site.data.keys.mf_server }} の構成
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
SSL プロトコルのうち Transport Layer Security v1.2 (TLS) V1.2 のみをサポートするデバイスと {{ site.data.keys.mf_server }} が通信できるようにするには、以下の手順を実行する必要があります。

{{ site.data.keys.mf_server }} を構成して Transport Layer Security (TLS) V1.2 を使用可能にする手順は、 {{ site.data.keys.mf_server }} がどのようにデバイスに接続するのかによって異なります。

* {{ site.data.keys.mf_server }} がリバース・プロキシーの背後にあり、そのリバース・プロキシーがデバイスからの SSL エンコードされたパケットを暗号化解除してからアプリケーション・サーバーに渡す場合、リバース・プロキシー上で TLS V1.2 サポートを有効にする必要があります。リバース・プロキシーとして IBM HTTP Server を使用する場合は、[IBM HTTP Server の保護](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc)で手順を参照してください。
* {{ site.data.keys.mf_server }} がデバイスと直接通信する場合、TLS V1.2 を使用可能にするための手順は、アプリケーション・サーバーとして使用するのが Apache Tomcat なのか、WebSphere Application Server Liberty プロファイルなのか、あるいは WebSphere Application Server フル・プロファイルなのかによって異なります。

### Apache Tomcat
{: #apache-tomcat }
1. Java ランタイム環境 (JRE) が TLS V1.2 をサポートすることを確認します。
    以下の JRE バージョンのいずれかがあることを確認します。
    * Oracle JRE 1.7.0_75 以降
    * Oracle JRE 1.8.0_31 以降
2. **conf/server.xml** ファイルを編集し、 HTTPS ポートを宣言する `Connector` エレメントを変更して **sslEnabledProtocols** 属性の値を次のようにします。`sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`。

### WebSphere Application Server Liberty プロファイル
{: #websphere-application-server-liberty-profile }
1. Java ランタイム環境 (JRE) が TLS V1.2 をサポートすることを確認します。 
    * IBM Java SDK を使用する場合、IBM Java SDK に POODLE 脆弱性に対するパッチが適用済みであることを確認します。ご使用のバージョンの WebSphere Application Server 用のパッチを含んでいる最小の IBM Java SDK バージョンについては、[Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173) を参照してください。

        > **注:** このセキュリティー情報にリストされているバージョンまたはそれ以降のバージョンを使用することができます。
    * Oracle Java SDK を使用する場合、以下のいずれかのバージョンがあることを確認します。
        * Oracle JRE 1.7.0_75 以降
        * Oracle JRE 1.8.0_31 以降
2. IBM Java SDK を使用する場合、**server.xml** ファイルを編集します。
    * 次の行を追加します。`<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * 既存のすべての `<ssl>` エレメントに `sslProtocol="SSL_TLSv2"` 属性を追加します。

### WebSphere Application Server フル・プロファイル
{: #websphere-application-server-full-profile }
1. Java ランタイム環境 (JRE) が TLS V1.2 をサポートすることを確認します。 

    IBM Java SDK に POODLE 脆弱性に対するパッチが適用済みであることを確認します。ご使用のバージョンの WebSphere Application Server 用のパッチを含んでいる最小の IBM Java SDK バージョンについては、[Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173) を参照してください。
    > **注:** このセキュリティー情報にリストされているバージョンまたはそれ以降のバージョンを使用することができます。
2. WebSphere Application Server 管理コンソールにログインし、**「セキュリティー」→「SSL 証明書および鍵管理」→「SSL 構成」**をクリックします。
3. リストされる SSL 構成ごとに、構成を変更して TLS V1.2 を使用可能にします。
    * SSL 構成を選択し、**「追加プロパティー」**の下で**「保護品質 (QoP) 設定」**をクリックします。
    * **「プロトコル」**リストから **SSL_TLSv2** を選択します。
    * **「適用」**をクリックし、変更を保存します。

## {{ site.data.keys.mf_server }} 管理用のユーザー認証の構成
{: #configuring-user-authentication-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} 管理には、ユーザー認証が必要です。ユーザー認証を構成して、認証方式を選択できます。構成手順は、使用する Web アプリケーション・サーバーによって異なります。

> **重要:** スタンドアロンの WebSphere Application Server Full Profile を使用している場合は、グローバル・セキュリティーでのシンプルな WebSphere 認証方式 (SWAM) 以外の認証方式を使用してください。Lightweight Third Party Authentication (LTPA) を使用できます。SWAM を使用した場合、予期しない認証の失敗が発生する可能性があります。

認証の構成は、インストーラーが {{ site.data.keys.mf_server }} 管理 Web アプリケーションを Web アプリケーション・サーバーにデプロイした後に実行する必要があります。

{{ site.data.keys.mf_server }} 管理には、次の Java Platform、Enterprise Edition (Java EE) セキュリティー・ロールが定義されています。

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

これらのロールを、対応するユーザーのセットにマップする必要があります。**mfpmonitor** ロールでは、データを表示できますが、データを変更することはできません。以下の表に、実動サーバーでの MobileFirst のロールと機能をリストします。

#### デプロイメント 
{: #deployment }

|                        | 管理者 | デプロイメント担当者    | オペレーター    | モニター    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE セキュリティー・ロール。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| アプリケーションのデプロイ。 | はい           | はい         | いいえ          | いいえ         |
| アダプターのデプロイ。     | はい           | はい         | いいえ          | いいえ         |

#### {{ site.data.keys.mf_server }} 管理
{: #mobilefirst-server-management }

|                            | 管理者 | デプロイメント担当者    | オペレーター    | モニター    |
|----------------------------|---------------|-------------|-------------|------------|
| Java EE セキュリティー・ロール。     | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| ランタイム設定の構成。| はい           | はい         | いいえ          | いいえ         |

#### アプリケーション管理
{: #mobilefirst-server-management }

|                                     | 管理者 | デプロイメント担当者    | オペレーター    | モニター    |
|-------------------------------------|---------------|-------------|-------------|------------|
| Java EE セキュリティー・ロール。              | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 新規 {{ site.data.keys.product_adj }} アプリケーションのアップロード | はい           | はい         | いいえ          | いいえ         |
| {{ site.data.keys.product_adj }}アプリケーションの削除。	  | はい           | はい         | いいえ          | いいえ         |
| 新規アダプターのアップロード。     | はい           | はい         | いいえ          | いいえ         |
|  アダプターの削除。         | はい           | はい         | いいえ          | いいえ         |
| アプリケーションに対するアプリケーション認証性テストのオン / オフ | はい | はい | いいえ | いいえ    |
| {{ site.data.keys.product_adj }} アプリケーションの状況に関するプロパティーの変更: アクティブ、アクティブ通知、使用不可。 | はい | はい | はい | いいえ |

基本的にすべてのロールが GET 要求を実行でき、**mfpadmin**、**mfpdeployer**、および **mfpmonitor** の各ロールが POST 要求と PUT 要求も実行でき、**mfpadmin** ロールと **mfpdeployer** ロールが DELETE 要求も実行できます。

#### プッシュ通知に関連した要求
{: #requests-related-to-push-notifications }

|                        | 管理者 | デプロイメント担当者    | オペレーター    | モニター    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE セキュリティー・ロール。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| GET 要求{::nomarkdown}<ul><li>アプリケーションに対してプッシュ通知を使用するすべてのデバイスのリストを取得する</li><li>特定のデバイスの詳細を取得する</li><li>サブスクリプションのリストを取得する</li><li>サブスクリプション ID に関連付けられたサブスクライブ情報を取得する</li><li>GCM 構成の詳細を取得する</li><li>APNS 構成の詳細を取得する</li><li>アプリケーションに対して定義されているタグのリストを取得する</li><li>特定のタグの詳細を取得する</li></ul>{:/}| はい           | はい         | はい         | はい        |
| POST 要求および PUT 要求{::nomarkdown}<ul><li>アプリをプッシュ通知に登録する</li><li>プッシュ・デバイス登録を更新する</li><li>サブスクライブを作成する</li><li>GCM 構成を追加または更新する</li><li>APNS 構成を追加または更新する</li><li>デバイスに通知をサブミットする</li><li>タグを作成または更新する</li></ul>{:/} | はい           | はい         | はい         | いいえ         |
| DELETE 要求{::nomarkdown}<ul><li>プッシュ通知へのデバイスの登録を削除する</li><li>サブスクリプションを削除する</li><li>デバイスをタグからアンサブスクライブする</li><li>GCM 構成を削除する</li><li>APNS 構成を削除する</li><li>タグを削除する</li></ul>{:/} | はい           | はい         | いいえ          | いいえ         |

#### 使用不可化
{: #disabling }

|                        | 管理者 | デプロイメント担当者    | オペレーター    | モニター    |
|------------------------|---------------|-------------|-------------|------------|
| Java EE セキュリティー・ロール。 | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| 特定のデバイスを使用不可にし、ステータスを紛失や盗難とマーク付けして、そのデバイス上のアプリケーションからのアクセスをブロック。       | はい           | はい         | はい          | いいえ        |
| 特定のアプリケーションを使用不可にし、状態を無効とマーク付けして、デバイス上にあるその特定のアプリケーションからのアクセスをブロック。              | はい           | はい         | はい         | いいえ         |

LDAP などのユーザー・リポジトリーを介した認証方式を使用することを選択した場合、ユーザー・リポジトリーと共にユーザーおよびグループを使用して {{ site.data.keys.mf_server }} 管理のアクセス制御リスト (ACL) を定義できるように、{{ site.data.keys.mf_server }} 管理を構成することができます。この手順は、使用している Web アプリケーション・サーバーのタイプとバージョンによって異なります。

### {{ site.data.keys.mf_server }} 管理用の WebSphere Application Server フル・プロファイルの構成
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} 管理の Java EE ロールを両方の Web アプリケーションのユーザー・セットにマップすることにより、セキュリティーを構成します。

WebSphere Application Server コンソールで基本的なユーザー構成を定義します。通常、コンソールへのアクセスは次のアドレスで行われます。`https://localhost:9043/ibm/console/`

1. **「セキュリティー (Security)」→「グローバル・セキュリティー (Global Security)」**を選択します。
2. ユーザーを構成するため、**「セキュリティー構成ウィザード (Security Configuration Wizard)」**を選択します。
   **「ユーザーおよびグループ (Users and Groups)」→「ユーザーの管理 (Manage Users)」**を選択することによって、個々のユーザー・アカウントを管理できます。
3. **mfpadmin**、**mfpdeployer**、**mfpmonitor**、および **mfpoperator** の各ロールをユーザーのセットにマップします。
    * **「サーバー」→「サーバー・タイプ」→「WebSphere Application Server」**を選択します。
    * サーバーを選択します。
    * **「構成 (Configuration)」**タブで、**「アプリケーション (Applications)」→「エンタープライズ・アプリケーション (Enterprise applications)」**を選択します。
    * **「MobileFirst_Administration_Service」**を選択します。
    * **「構成 (Configuration)」**タブで、**「詳細 (Details)」→「ユーザー/グループへのセキュリティー・ロールのマッピング」**を選択します。
    * 必要なカスタマイズを実行します。
    * **「OK」**をクリックします。
    * コンソール Web アプリケーションのロールをマップするステップを繰り返します。今回は、**「MobileFirst_Administration_Console」** を選択します。
    * **「保存 (Save)」**をクリックして変更を保存します。

### {{ site.data.keys.mf_server }} 管理用の WebSphere Application Server Liberty プロファイルの構成
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
WebSphere Application Server Liberty Profile で、サーバーの **server.xml** 構成ファイルに、**mfpadmin**、**mfpdeployer**、**mfpmonitor**、および **mfpoperator** の各ロールを構成します。

セキュリティー・ロールを構成するには、**server.xml** ファイルを編集する必要があります。各 `<application>` エレメントの `<application-bnd>` エレメント内に、`<security-role>` エレメントを作成します。各 `<security-role>` エレメントは、**mfpadmin**、mfpdeployer、mfpmonitor、および mfpoperator の各ロール用です。これらのロールを適切なユーザー・グループ名にマップします。この例では、**mfpadmingroup**、**mfpdeployergroup**、**mfpmonitorgroup**、または **mfpoperatorgroup** です。これらのグループは、`<basicRegistry>` エレメントによって定義されます。このエレメントをカスタマイズするか、または、全体を `<safRegistry>` エレメントまたは `<ldapRegistry>` エレメントで置き換えることができます。

次に、多数のインストール済みアプリケーション (例えば、80 個のアプリケーション) がある状態で良好な応答時間を維持するために、管理データベース用の接続プールを構成します。

1. **server.xml** ファイルを編集します。 例えば、次のとおりです。 

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. 以下のようにして、**AppCenterPool** のサイズを定義します。

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. `<dataSource>` エレメント内で、接続マネージャーへの参照を定義します。

   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### {{ site.data.keys.mf_server }} 管理用の Apache Tomcat の構成
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
Apache Tomcat Web アプリケーション・サーバー上に {{ site.data.keys.mf_server }} 管理用の Java EE セキュリティー・ロールを構成する必要があります。

1. {{ site.data.keys.mf_server }} 管理を手動でインストールした場合は、**conf/tomcat-users.xml** ファイルで以下のロールを宣言します。

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. 例えば以下のようにして、選択したユーザーにロールを追加します。

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. Apache Tomcat 資料[レルム構成方法](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html)の説明に従って、ユーザーのセットを定義できます。

## {{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーのリスト
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
アプリケーション・サーバーにデプロイされている {{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーを構成します。

* [{{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーの設定](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [{{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} ライブ更新サービスの JNDI プロパティーのリスト](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト](#list-of-jndi-properties-for-mobilefirst-runtime)
* [{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### {{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーの設定
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
アプリケーション・サーバーにデプロイされている {{ site.data.keys.mf_server }} Web アプリケーションを構成するために、JNDI プロパティーをセットアップします。  
以下のいずれかの方法で JNDI 環境エントリーを設定します。

* サーバー環境エントリーを構成します。サーバー環境エントリーを構成するステップは、ご使用のアプリケーション・サーバーによって異なります。

    * **WebSphere  Application Server:**
        1. WebSphere Application Server 管理コンソールで、**「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」→「application_name」→「Web モジュールの環境エントリー」**と進みます。
        2. 「値」フィールドに、ご使用のサーバー環境に適した値を入力します。

        ![WebSphere の JNDI 環境項目](jndi_was.jpg)
    * WebSphere Application Server Liberty:

      **liberty\_install\_dir/usr/servers/serverName** で、**server.xml** ファイルを編集して以下のように JNDI プロパティーを宣言します。

      ```xml
      <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
      ```

      コンテキスト・ルート (前の例では **app\_context\_root**) は、JNDI エントリーと特定の {{ site.data.keys.product_adj }} アプリケーションを接続します。複数の {{ site.data.keys.product_adj }} アプリケーションが同じサーバー上に存在する場合は、コンテキスト・パスの接頭部を使用して、各アプリケーションに対して固有の JNDI エントリーを定義することができます。

      > **注:** 一部のプロパティーは、コンテキスト・ルートでプロパティー名に接頭部を付けることなく、WebSphere Application Server Liberty でグローバルに定義されます。これらのプロパティーのリストについては、[グローバル JNDI 項目](../appserver/#global-jndi-entries)を参照してください。

      他のすべての JNDI プロパティーでは、名前の接頭部としてアプリケーションのコンテキスト・ルートを付加する必要があります。

       * ライブ更新サービスの場合、コンテキスト・ルートは **/[adminContextRoot]config** でなければなりません。例えば、管理サービスのコンテキスト・ルートが **/mfpadmin** の場合、ライブ更新サービスのコンテキスト・ルートは **/mfpadminconfig** でなければなりません。
       * プッシュ・サービスの場合、コンテキスト・ルートは **/imfpush** と定義する必要があります。さもないと、コンテキスト・ルートは SDK にハードコーディングされているため、クライアント・デバイスはプッシュ・サービスに接続できません。
       * {{ site.data.keys.product_adj }} Administration Service アプリケーション、{{ site.data.keys.mf_console }}、および {{ site.data.keys.product_adj }} ランタイムの場合、コンテキスト・ルートは自由に定義できます。ただし、デフォルトでは、**/mfpadmin** ({{ site.data.keys.product_adj }} Administration Service の場合)、**/mfpconsole** ({{ site.data.keys.mf_console }} の場合)、および **/mfp** ({{ site.data.keys.product_adj }} ランタイムの場合) です。

      例えば、次のとおりです。 

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat:

      **tomcat\_install\_dir/conf** で、**server.xml** ファイルを編集して以下のように JNDI プロパティーを宣言します。

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
      </Context>
      ```

        * コンテキスト・パスの接頭部は不要です。これは、JNDI エントリーが、アプリケーションの `<Context>` エレメント内で定義されるためです。
        * `override="false"` は必須です。
        * `type` 属性は、プロパティーに対して異なる指定がされない限り、常に `java.lang.String` です。

      例えば、次のとおりです。 

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* Ant タスクを使用してインストールする場合、インストール時に JNDI プロパティーの値を設定することもできます。

  **mfp_install_dir/MobileFirstServer/configuration-samples** で、Ant タスク用の構成 XML ファイルを編集し、以下のタグ内で property エレメントを使用して JNDI プロパティーの値を宣言します。

  * `<installmobilefirstadmin>` は、{{ site.data.keys.mf_server }} 管理サービス、{{ site.data.keys.mf_console }} サービス、およびライブ更新サービス用です。詳しくは、[{{ site.data.keys.mf_console }}、{{ site.data.keys.mf_server }} 成果物、{{ site.data.keys.mf_server }} 管理、およびライブ更新サービスのインストール用の Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)を参照してください。
  * `<installmobilefirstruntime>` は、{{ site.data.keys.product_adj }} ランタイム構成プロパティー用です。詳しくは、[{{ site.data.keys.product_adj }} ランタイム環境のインストールに関する Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)を参照してください。
  * `<installmobilefirstpush>` は、プッシュ・サービスの構成用です。詳しくは、[{{ site.data.keys.mf_server }} プッシュ・サービスのインストールに関する Ant タスク](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)を参照してください。

  例えば、次のとおりです。 

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### {{ site.data.keys.mf_server }} 管理サービスの JNDI プロパティーのリスト
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
{{ site.data.keys.mf_server }} 管理サービスと {{ site.data.keys.mf_console }} をご使用のアプリケーション・サーバー用に構成する場合、特に Java Management Extensions (JMX) に対して、オプションまたは必須の JNDI プロパティーを設定します。

管理サービス Web アプリケーション mfp-admin-service.war で、以下のプロパティーを設定できます。

#### 管理サービスの JNDI プロパティー: JMX
{: #jndi-properties-for-administration-service-jmx }

| プロパティー                 | オプションまたは必須 | 説明 | 制限 |
|--------------------------|-----------------------|-------------|--------------|
| mfp.admin.jmx.connector  | オプション	           | Java Management Extensions (JMX) のコネクター・タイプ。<br/>指定可能な値は `SOAP` および `RMI` です。デフォルト値は SOAP です。 | WebSphere Application Server のみ。 |
| mfp.admin.jmx.host       | オプション	           | JMX REST 接続のホスト名。 | Liberty プロファイルのみ。 |
| mfp.admin.jmx.port	   | オプション	           | JMX REST 接続のポート。 | Liberty プロファイルのみ。 |
| mfp.admin.jmx.user       | Liberty プロファイルおよび WebSphere Application Server ファームでは必須、その他の場合はオプション | JMX REST 接続のユーザー名。 | WebSphere Application Server Liberty プロファイル: JMX REST 接続のユーザー名。<br/><br/>WebSphere Application Server ファーム: SOAP 接続のユーザー名。<br/><br/>WebSphere Application Server Network Deployment: {{ site.data.keys.mf_server }} 管理アプリケーションにマップされた仮想ホストがデフォルト・ホストではない場合、WebSphere 管理者のユーザー名。<br/><br/>Liberty 集合: Liberty コントローラーの server.xml ファイルの `<administrator-role>` エレメントで定義されたコントローラー管理者のユーザー名。 |
| mfp.admin.jmx.pwd	| Liberty プロファイルおよび WebSphere Application Server ファームでは必須、その他の場合はオプション | JMX REST 接続のユーザー・パスワード。 | WebSphere Application Server Liberty プロファイル: JMX REST 接続のユーザー・パスワード。<br/><br/>WebSphere Application Server ファーム: SOAP 接続のユーザー・パスワード。<br/><br/>WebSphere Application Server Network Deployment: {{ site.data.keys.mf_server }} サーバー管理アプリケーションにマップされた仮想ホストがデフォルト・ホストではない場合、WebSphere 管理者のユーザー・パスワード。<br/><br/>Liberty 集合: Liberty コントローラーの server.xml ファイルの `<administrator-role>` エレメントで定義されたコントローラー管理者のパスワード。 |
| mfp.admin.rmi.registryPort | オプション | ファイアウォールを介した JMX 接続の RMI レジストリー・ポート。 | Tomcat のみ。 |
| mfp.admin.rmi.serverPort | オプション | ファイアウォールを介した JMX 接続の RMI サーバー・ポート。 | Tomcat のみ。 |
| mfp.admin.jmx.dmgr.host | 必須 | デプロイメント・マネージャーのホスト名。 | WebSphere Application Server Network Deployment のみ。 |
| mfp.admin.jmx.dmgr.port | 必須 | デプロイメント・マネージャー RMI または SOAP ポート。 | WebSphere Application Server Network Deployment のみ。 |

#### 管理サービスの JNDI プロパティー: タイムアウト
{: #jndi-properties-for-administration-service-timeout }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.actions.prepareTimeout | オプション | デプロイメント・トランザクション中に管理サービスからランタイムにデータを転送する際のタイムアウト (ミリ秒)。この時間内にランタイムに到達できない場合、エラーが発生し、デプロイメント・トランザクションは終了します。<br/><br/>デフォルト値: 1800000 ms (30 分) |
| mfp.admin.actions.commitRejectTimeout | オプション | ランタイムへの接続時に、デプロイメント・トランザクションをコミットまたはリジェクトする際のタイムアウト (ミリ秒)。この時間内にランタイムに到達できない場合、エラーが発生し、デプロイメント・トランザクションは終了します。<br/><br/>デフォルト値: 120000 ms (2 分) |
| mfp.admin.lockTimeoutInMillis | オプション |トランザクション・ロックを取得する際のタイムアウト (ミリ秒)。デプロイメント・トランザクションは順番に実行されるため、ロックを使用します。したがって、トランザクションは、前のトランザクションが終了するまで待機する必要があります。このタイムアウトは、トランザクションの最大待機時間です。<br/><br/>デフォルト値: 1200000 ms (20 分) |
| mfp.admin.maxLockTimeInMillis | オプション | プロセスがトランザクション・ロックを取得できる最大時間です。デプロイメント・トランザクションは順番に実行されるため、ロックを使用します。ロックが取得されている間にアプリケーション・サーバーが失敗すると、次回のアプリケーション・サーバーの再始動時にロックが解除されないという状況が発生することがまれにあります。この場合、最大ロック時間が経過した後に自動的にロックが解除されるため、サーバーが永久にブロックされることはありません。通常のトランザクションより長い時間を設定します。<br/><br/>デフォルト値: 1800000 (30 分) |

#### 管理サービスの JNDI プロパティー: ロギング
{: #jndi-properties-for-administration-service-logging }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.logging.formatjson | オプション | 応答およびログ・メッセージで JSON オブジェクトの Pretty フォーマット (余分なブランク・スペース) を使用可能にするには、このプロパティーを true に設定します。このプロパティーを設定すると、サーバーをデバッグする時に役立ちます。デフォルト値: false。 |
| mfp.admin.logging.tosystemerror | オプション | すべてのロギング・メッセージを System.Error にも送信するかどうかを指定します。このプロパティーを設定すると、サーバーをデバッグする時に役立ちます。 |

#### 管理サービスの JNDI プロパティー: プロキシー
{: #jndi-properties-for-administration-service-proxies }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.proxy.port | オプション | {{ site.data.keys.product_adj }} 管理サーバーがファイアウォールまたはリバース・プロキシーの背後にある場合、このプロパティーはホストのアドレスを指定します。このプロパティーを設定すると、ファイアウォールの外のユーザーが {{ site.data.keys.product_adj }} 管理サーバーにアクセスできます。通常、このプロパティーはプロキシーのポートです。例えば、443 など。これは、外部と内部の URI のプロトコルが異なる場合にのみ必要です。 |
| mfp.admin.proxy.protocol | オプション | {{ site.data.keys.product_adj }} 管理サーバーがファイアウォールまたはリバース・プロキシーの背後にある場合、このプロパティーはプロトコル (HTTP または HTTPS) を指定します。このプロパティーを設定すると、ファイアウォールの外のユーザーが {{ site.data.keys.product_adj }} 管理サーバーにアクセスできます。通常、このプロパティーはプロキシーのプロトコルに設定されます。例えば、wl.net などです。このプロパティーは、外部と内部の URI のプロトコルが異なる場合にのみ必要です。 |
| mfp.admin.proxy.scheme | オプション | このプロパティーは、単に mfp.admin.proxy.protocol の代替名です。 |
| mfp.admin.proxy.host | オプション | {{ site.data.keys.product_adj }} 管理サーバーがファイアウォールまたはリバース・プロキシーの背後にある場合、このプロパティーはホストのアドレスを指定します。このプロパティーを設定すると、ファイアウォールの外のユーザーが {{ site.data.keys.product_adj }} 管理サーバーにアクセスできます。通常、このプロパティーはプロキシーのアドレスです。 |

#### 管理サービスの JNDI プロパティー: トポロジー
{: #jndi-properties-for-administration-service-topologies }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.audit | オプション。 | {{ site.data.keys.mf_console }} の監査フィーチャーを使用不可にするには、このプロパティーを false に設定します。 デフォルト値は true です。 |
| mfp.admin.environmentid | オプション。 | MBean の登録のための環境 ID。この ID は、{{ site.data.keys.mf_server }} の異なるインスタンスが同じアプリケーション・サーバー上にインストールされている場合に使用します。この ID は、どの管理サービス、どのコンソール、およびどのランタイムが同じインストールに属しているかを判別します。管理サービスは、同じ環境 ID を持つランタイムのみを管理します。 |
| mfp.admin.serverid | サーバー・ファームおよび Liberty 集合では必須、その他の場合はオプション。 | サーバー・ファーム: サーバー ID。ファーム内のサーバーごとに異なる必要があります。<br/><br/> Liberty 集合: 値はコントローラーでなければなりません。 |
| mfp.admin.hsts | オプション。 | RFC 6797 に従って HTTP Strict Transport Security を有効にする場合は、true に設定します。 |
| mfp.topology.platform | オプション | サーバー・タイプ。有効な値は以下のとおりです。{::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}この値を設定しないと、アプリケーションはサーバー・タイプを推測しようとします。 |
| mfp.topology.clustermode | オプション | サーバー・タイプに加え、ここにサーバー・トポロジーを指定します。有効な値は以下のとおりです。{::nomarkdown}<ul><li>Standalone</li><li>クラスター</li><li>Farm</li></ul>{:/}デフォルト値は Standalone です。 |
| mfp.admin.farm.heartbeat | オプション | このプロパティーにより、サーバー・ファーム・トポロジーで使用するハートビート・レートを分単位で設定することができます。デフォルト値は 2 分です。<br/><br/>1 つのサーバー・ファーム内では、すべてのメンバーが同じハートビート・レートの値を使用しなければなりません。ファーム内の 1 つのサーバーでこの JNDI 値を設定または変更すると、そのファーム内の他のすべてのサーバーでもそれと同じ値を設定する必要があります。詳しくは、[サーバー・ファーム・ノードのライフサイクル ](../appserver/#lifecycle-of-a-server-farm-node)を参照してください。 |
| mfp.admin.farm.missed.heartbeats.timeout | オプション | このプロパティーにより、あるファーム・メンバーで何個のハートビートが欠落すると、そのファーム・メンバーに障害が発生したかダウンしたと見なされるかを設定できます。デフォルト値は 2 です。<br/><br/>1 つのサーバー・ファーム内では、すべてのメンバーが同じ欠落ハートビートの値を使用しなければなりません。ファーム内の 1 つのサーバーでこの JNDI 値を設定または変更すると、そのファーム内の他のすべてのサーバーでもそれと同じ値を設定する必要があります。詳しくは、[サーバー・ファーム・ノードのライフサイクル ](../appserver/#lifecycle-of-a-server-farm-node)を参照してください。 |
| mfp.admin.farm.reinitialize | オプション | ファーム・メンバーを再登録または再初期化するためのブール値 (true または false)。 |
| mfp.swagger.ui.url | オプション | このプロパティーは、管理コンソールで表示される Swagger ユーザー・インターフェースの URL を定義します。 |

#### 管理サービスの JNDI プロパティー: リレーショナル・データベース
{: #jndi-properties-for-administration-service-relational-database }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.db.jndi.name | オプション | データベースの JNDI 名。このパラメーターは、データベースを指定する標準メカニズムです。デフォルト値は **java:comp/env/jdbc/mfpAdminDS** です。 |
| mfp.admin.db.openjpa.ConnectionDriverName | オプション/条件によって必須 | データベース接続ドライバー・クラスの完全修飾名。**mfp.admin.db.jndi.name ** プロパティーによって指定されているデータ・ソースがアプリケーション・サーバー構成に定義されていない場合にのみ必須です。 |
| mfp.admin.db.openjpa.ConnectionURL | オプション/条件によって必須 | データベース接続の URL。**mfp.admin.db.jndi.name ** プロパティーによって指定されているデータ・ソースがアプリケーション・サーバー構成に定義されていない場合にのみ必須です。 |
| mfp.admin.db.openjpa.ConnectionUserName | オプション/条件によって必須 | データベース接続のユーザー名。**mfp.admin.db.jndi.name ** プロパティーによって指定されているデータ・ソースがアプリケーション・サーバー構成に定義されていない場合にのみ必須です。 |
| mfp.admin.db.openjpa.ConnectionPassword | オプション/条件によって必須 | データベース接続のパスワード。**mfp.admin.db.jndi.name ** プロパティーによって指定されているデータ・ソースがアプリケーション・サーバー構成に定義されていない場合にのみ必須です。 |
| mfp.admin.db.openjpa.Log | オプション | このプロパティーは OpenJPA に渡され、JPA ロギングを有効にします。詳細については、[the Apache OpenJPA User's Guide](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html) を参照してください。 |
| mfp.admin.db.type | オプション | このプロパティーは、データベースのタイプを定義します。 デフォルト値は、接続 URL から推定されます。 |

#### 管理サービスの JNDI プロパティー: ライセンス交付
{: #jndi-properties-for-administration-service-licensing }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.license.key.server.host	| {::nomarkdown}<ul><li>永久ライセンスの場合、オプション</li><li>トークン・ライセンスの場合、必須。</li></ul>{:/} | Rational License Key Server のホスト名。 |
| mfp.admin.license.key.server.port	| {::nomarkdown}<ul><li>永久ライセンスの場合、オプション</li><li>トークン・ライセンスの場合、必須。</li></ul>{:/} | Rational License Key Server のポート番号。 |

#### 管理サービスの JNDI プロパティー: JNDI 構成
{: #jndi-properties-for-administration-service-jndi-configurations }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.jndi.configuration | オプション | WAR ファイルに組み入れられたプロパティー・ファイルから JNDI プロパティー (このプロパティー以外) を読み取る必要がある場合は、JNDI 構成の名前。このプロパティーを設定しないと、JNDI プロパティーはプロパティー・ファイルから読み取られません。 |
| mfp.jndi.file | オプション | Web サーバーにインストールされたファイルから JNDI プロパティー (このプロパティー以外) を読み取る必要がある場合は、JNDI 構成を含むファイルの名前。このプロパティーを設定しないと、JNDI プロパティーはプロパティー・ファイルから読み取られません。 |

管理サービスは、さまざまな構成を保管する補助ファシリティーとして、ライブ更新サービスを使用します。これらのプロパティーを使用して、ライブ更新サービスへの到達方法を構成します。

#### 管理サービスの JNDI プロパティー: ライブ更新サービス
{: #jndi-properties-for-administration-service-live-update-service }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.config.service.url | オプション	ライブ更新サービスの URL。デフォルトの URL は、config を管理サービスのコンテキスト・ルートに追加することで、管理サービスの URL から取得されます。 |
| mfp.config.service.user | 必須 | ライブ更新サービスにアクセスするために使用されるユーザー名。 サーバー・ファーム・トポロジーでは、ユーザー名はファームのすべてのメンバーで同じでなければなりません。 |
| mfp.config.service.password | 必須 | ライブ更新サービスにアクセスするために使用されるパスワード。 サーバー・ファーム・トポロジーでは、パスワードはファームのすべてのメンバーで同じでなければなりません。 |
| mfp.config.service.schema | オプション | ライブ更新サービスが使用するスキーマの名前。 |

管理サービスは、さまざまなプッシュ設定を保管する補助ファシリティーとして、プッシュ・サービスを使用します。これらのプロパティーを使用して、プッシュ・サービスへの到達方法を構成します。プッシュ・サービスは OAuth セキュリティー・モデルによって保護されるため、 OAuth で機密クライアントを使用可能にするには、さまざまなプロパティーを設定する必要があります。

#### 管理サービスの JNDI プロパティー: プッシュ・サービス
{: #jndi-properties-for-administration-service-push-service }

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.push.url | オプション | プッシュ・サービスの URL。このプロパティーが指定されていない場合、プッシュ・サービスは使用不可とみなされます。このプロパティーが適切に設定されていない場合、管理サービスがプッシュ・サービスに接続できず、{{ site.data.keys.mf_console }} のプッシュ・サービスの管理が機能しません。 |
| mfp.admin.authorization.server.url | オプション | プッシュ・サービスによって使用される OAuth 許可サーバーの URL。デフォルトの URL は、コンテキスト・ルートを最初にインストールされたランタイムのコンテキスト・ルートに変更することで、管理サービスの URL から取得されます。複数のランタイムをインストールする場合、このプロパティーを設定するのが最良です。このプロパティーが適切に設定されていない場合、管理サービスがプッシュ・サービスに接続できず、{{ site.data.keys.mf_console }} のプッシュ・サービスの管理が機能しません。 |
| mfp.push.authorization.client.id | オプション/条件によって必須 | プッシュ・サービス用の OAuth 許可を処理する機密クライアントの ID。**mfp.admin.push.url** プロパティーが指定されている場合のみ必須。 |
| mfp.push.authorization.client.secret | オプション/条件によって必須 | プッシュ・サービス用の OAuth 許可を処理する機密クライアントの秘密鍵。**mfp.admin.push.url** プロパティーが指定されている場合のみ必須。 |
| mfp.admin.authorization.client.id | オプション/条件によって必須 | 管理サービス用の OAuth 許可を処理する機密クライアントの ID。**mfp.admin.push.url** プロパティーが指定されている場合のみ必須。 |
| mfp.push.authorization.client.secret | オプション/条件によって必須 | 管理サービス用の OAuth 許可を処理する機密クライアントの秘密鍵。**mfp.admin.push.url** プロパティーが指定されている場合のみ必須。 |

### {{ site.data.keys.mf_console }} の JNDI プロパティー
{: #jndi-properties-for-mobilefirst-operations-console }
{{ site.data.keys.mf_console }} の Web アプリケーション (mfp-admin-ui.war) で、以下のプロパティーを設定できます。

| プロパティー                 | オプションまたは必須 | 説明  |
|--------------------------|-----------------------|--------------|
| mfp.admin.endpoint | オプション | {{ site.data.keys.mf_console }} が、{{ site.data.keys.mf_server }} 管理の REST サービスを見つけられるようにします。**mfp-admin-service.war** Web アプリケーションの外部アドレスとコンテキスト・ルートを指定します。ファイアウォールまたはセキュア・リバース・プロキシーが使用されるシナリオでは、この URI は外部 URI でなければならず、ローカル LAN の内側の内部 URI であってはなりません。例えば、https://wl.net:443/mfpadmin などです。 |
| mfp.admin.global.logout | オプション | コンソールのログアウト中に WebSphere ユーザー認証キャッシュをクリアします。このプロパティーは、WebSphere Application Server V7 にのみ有用です。デフォルト値は false です。 |
| mfp.admin.hsts | オプション | RFC 6797 に従って HTTP [Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security) を有効にする場合は、このプロパティーを true に設定します。詳細については、W3C  の Strict Transport Security ページを参照してください。デフォルト値は false です。 |
| mfp.admin.ui.cors | オプション | デフォルト値は true です。詳細については、[W3C の Cross-Origin Resource Sharing ページ](http://www.w3.org/TR/cors/)を参照してください。 |
| mfp.admin.ui.cors.strictssl | オプション | {{ site.data.keys.mf_console }} は SSL (HTTPS プロトコル) で保護されているが、{{ site.data.keys.mf_server }} 管理サービスは保護されていない (またはその逆の) CORS 状態を許可する場合は、false に設定します。このプロパティーは、**mfp.admin.ui.cors** プロパティーが有効な場合にのみ有効です。 |

### {{ site.data.keys.mf_server }} ライブ更新サービスの JNDI プロパティーのリスト
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
{{ site.data.keys.mf_server }} ライブ更新サービスをアプリケーション・サーバー用に構成する際、以下の JNDI プロパティーを設定できます。次の表では、IBM リレーショナル・データベースライブ更新サービスの JNDI プロパティーをリストします。

| プロパティー | オプションまたは必須 | 説明 |
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout | オプション | RDBMS で照会を実行するためのタイムアウト (秒単位)。値 0 は、無限のタイムアウトを意味します。 負の値は、デフォルト (オーバーライドなし) を意味します。<br/><br/>値が構成されていない場合は、デフォルト値が使用されます。詳しくは、[setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int)) を参照してください。 |

これらのプロパティーの設定方法については、[{{ site.data.keys.mf_server }} Web アプリケーションの JNDI プロパティーの設定](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)を参照してください。

### {{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト
{: #list-of-jndi-properties-for-mobilefirst-runtime }
{{ site.data.keys.mf_server }} ランタイムをアプリケーション・サーバー用に構成する際、オプションまたは必須の JNDI プロパティーを設定する必要があります。  
以下の表で、JNDI 項目として常に使用可能な {{ site.data.keys.product_adj }} プロパティーをリストします。

| プロパティー | 説明 |
|----------|-------------|
| mfp.admin.jmx.dmgr.host | 必須。デプロイメント・マネージャーのホスト名。WebSphere Application Server Network Deployment のみ。 |
| mfp.admin.jmx.dmgr.port | 必須。デプロイメント・マネージャーの RMI ポートまたは SOAP ポート。WebSphere Application Server Network Deployment のみ。 |
| mfp.admin.jmx.host | Liberty のみ。JMX REST 接続のホスト名。Liberty 集合の場合、コントローラーのホスト名を使用します。 |
| mfp.admin.jmx.port | Liberty のみ。JMX REST 接続用のポート番号。Liberty 集合の場合、REST コネクターのポートは、`<httpEndpoint>` エレメントで宣言される httpsPort 属性の値と同じでなければなりません。このエレメントは、Liberty コントローラーの server.xml ファイル内で宣言されます。 |
| mfp.admin.jmx.user | オプション。WebSphere Application Server ファーム: SOAP 接続のユーザー名。<br/><br/>Liberty 集合: Liberty コントローラーの server.xml ファイルの `<administrator-role>` エレメントで定義されたコントローラー管理者のユーザー名。 |
| mfp.admin.jmx.pwd | オプション。WebSphere Application Server ファーム: SOAP 接続のユーザー・パスワード。<br/><br/>Liberty 集合: Liberty コントローラーの server.xml ファイルの `<administrator-role>` エレメントで定義されたコントローラー管理者のパスワード。 |
| mfp.admin.serverid | サーバー・ファームおよび Liberty 集合では必須、その他の場合はオプション。<br/><br/>サーバー・ファーム: サーバー ID。ファーム内のサーバーごとに異なる必要があります。<br/><br/>Liberty 集合: メンバー ID。集合内のメンバーごとに ID が異なっている必要があります。値 controller は、集合コントローラー用に予約済みであるため使用できません。 |
| mfp.topology.platform | オプション。サーバー・タイプ。有効な値は以下のとおりです。<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>この値を設定しないと、アプリケーションはサーバー・タイプを推測しようとします。 |
| mfp.topology.clustermode | オプション。サーバー・タイプに加え、ここにサーバー・トポロジーを指定します。有効な値は以下のとおりです。<ul><li>Standalone<li>クラスター</li><li>Farm</li></ul>デフォルト値は Standalone です。 |
| mfp.admin.jmx.replica | オプション。Liberty 集合の場合のみ。<br/><br/>このプロパティーは、このランタイムを管理する管理コンポーネントが別の Liberty コントローラー (レプリカ) にデプロイされたときにのみ設定します。<br/><br/>複数の異なるコントローラー・レプリカのエンドポイント・リスト (`replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` 構文を使用)。 |
| mfp.analytics.console.url | オプション。Analytics コンソールにリンクする URL。この URL は IBM {{ site.data.keys.mf_analytics }} によって公開されます。{{ site.data.keys.mf_console }} から Analytics コンソールにアクセスする場合は、このプロパティーを設定します。 例えば、`http://<hostname>:<port>/analytics/console` などです。 |
| mfp.analytics.password | IBM {{ site.data.keys.mf_analytics }} のデータ入力ポイントが基本認証で保護されている場合に使用されるパスワード。 |
| mfp.analytics.url | 着信分析データを受信する IBM {{ site.data.keys.mf_analytics }} によって公開される URL。例えば、`http://<hostname>:<port>/analytics-service/rest` などです。 |
| mfp.analytics.username | IBM {{ site.data.keys.mf_analytics }} のデータ入力ポイントが基本認証で保護されている場合に使用されるユーザー名。|
| mfp.device.decommissionProcessingInterval | 廃止タスクが実行される頻度 (秒単位) を定義します。デフォルト: 86400 (1 日)。 |
| mfp.device.decommission.when | デバイス廃用タスクによってクライアント・デバイスが廃用にされるまでの非アクティブ猶予日数。 デフォルト: 90 日。 |
| mfp.device.archiveDecommissioned.when | 廃止されたクライアント・デバイスがアーカイブされるまでの非アクティブ猶予日数。<br/><br/>このタスクは、廃止されたクライアント・デバイスをアーカイブ・ファイルに書き込みます。アーカイブされたクライアント・デバイスは、{{ site.data.keys.mf_server }} の **home\devices_archive** ディレクトリーにあるファイルに書き込まれます。このファイルの名前には、アーカイブ・ファイルが作成されたときのタイム・スタンプが含まれます。 デフォルト: 90 日。 |
| mfp.licenseTracking.enabled | {{ site.data.keys.product }} でデバイス・トラッキングを有効または無効にするために使用する値。<br/><br/>パフォーマンス上の理由のため、{{ site.data.keys.product }} が Business to Consumer (B2C) アプリケーションのみを実行する場合は、デバイス・トラッキングを無効にすることができます。デバイス・トラッキングが無効になると、ライセンス・レポートも無効になり、ライセンス・メトリックが作成されません。<br/><br/>指定可能な値は true (デフォルト) および false です。 |
| mfp.runtime.temp.folder | ランタイムの一時ファイル・フォルダーを定義します。設定されていない場合は、Web コンテナーのデフォルト一時フォルダー・ロケーションを使用します。 |
| mfp.adapter.invocation.url | Java アダプター内から、または REST エンドポイントを使用して呼び出される JavaScript アダプター内からアダプター・プロシージャーを呼び出すために使用される URL。このプロパティーが設定されていない場合は、現在実行中の要求の URL が使用されます (これがデフォルト動作)。この値には、コンテキスト・ルートを含めた、フル URL が含まれている必要があります。 |
| mfp.authorization.server | 許可サーバー・モード。以下のいずれかのモードです。{::nomarkdown}<ul><li>embedded: {{ site.data.keys.product_adj }} 許可サーバーを使用します。</li><li>external: 外部許可サーバーを使用します。</li></ul>{:/}. この値を設定する場合は、外部サーバーの **mfp.external.authorization.server.secret** プロパティーと **mfp.external.authorization.server.introspection.url** プロパティーも設定する必要があります。 |
| mfp.external.authorization.server.secret | 外部許可サーバーの秘密鍵。このプロパティーは、外部許可サーバーを使用しているとき、つまり **mfp.authorization.server** が external に設定されているときに必要で、それ以外は無視されます。 |
| mfp.external.authorization.server.introspection.url | 外部許可サーバーのイントロスペクション・エンドポイントの URL。このプロパティーは、外部許可サーバーを使用しているとき、つまり **mfp.authorization.server** が **external** に設定されているときに必要で、それ以外は無視されます。 |
| ssl.websphere.config | HTTP アダプター用の鍵ストアを構成するために使用されます。false (デフォルト) に設定すると、{{ site.data.keys.product_adj }} ランタイムが {{ site.data.keys.product_adj }} 鍵ストアを使用することが指示されます。true に設定すると、{{ site.data.keys.product_adj }} ランタイムが WebSphere SSL 構成を使用することが指示されます。詳しくは、[WebSphere Application Server SSL 構成および HTTP アダプター](#websphere-application-server-ssl-configuration-and-http-adapters)を参照してください。 |

### {{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

| プロパティー | オプションまたは必須 | 説明 |
|----------|-----------------------|-------------|
| mfp.push.db.type | オプション | データベース・タイプ。指定可能な値: DB、CLOUDANT。デフォルト: DB |
| mfp.push.db.queue.connections | オプション | データベース操作を行うスレッド・プールのスレッド数。デフォルト: 3 |
| mfp.push.db.cloudant.url | オプション | Cloudant アカウントの URL。このプロパティーが定義されている場合、Cloudant DB はこの URL に接続されます。 |
| mfp.push.db.cloudant.dbName | オプション | Cloudant アカウントのデータベースの名前。小文字で開始し、小文字、数字、および文字 _、$、- のみで構成されている必要があります。デフォルト: mfp\_push\_db |
| mfp.push.db.cloudant.username | オプション | データベースの保管に使用される Cloudant アカウントのユーザー名。このプロパティーは定義されないと、リレーショナル・データベースが使用されます。 |
| mfp.push.db.cloudant.password | オプション | データベースの保管に使用される Cloudant アカウントのパスワード。このプロパティーは、mfp.db.cloudant.username が設定されたときに設定されます。 |
| mfp.push.db.cloudant.doc.version | オプション | Cloudant 文書のバージョン。 |
| mfp.push.db.cloudant.socketTimeout | オプション	| Cloudant のネットワーク接続喪失を検出するためのタイムアウト (ミリ秒単位)。値 0 は、無限のタイムアウトを意味します。 負の値は、デフォルト (オーバーライドなし) を意味します。デフォルト。[https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration) を参照。 |
| mfp.push.db.cloudant.connectionTimeout | オプション	| Cloudant のネットワーク接続を確立するためのタイムアウト (ミリ秒単位)。値 0 は、無限のタイムアウトを意味します。 負の値は、デフォルト (オーバーライドなし) を意味します。デフォルト。[https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration) を参照。 |
| mfp.push.db.cloudant.maxConnections | オプション | Cloudant コネクターの最大接続数。デフォルト。[https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration) を参照。 |
| mfp.push.db.cloudant.ssl.authentication | オプション | SSL 証明書チェーンの検証およびホスト名の検証が、Cloudant データベースへの HTTPS 接続に対して有効化されるかどうかを指定するブール値 (true または false)。デフォルト: True |
| mfp.push.db.cloudant.ssl.configuration | オプション	| (WAS フル・プロファイルのみ) Cloudant データベースへの HTTPS 接続の場合: ホストおよびポートの構成が指定されていない場合に使用する、WebSphere Application Server 構成内の SSL 構成の名前。 |
| mfp.push.db.cloudant.proxyHost | オプション	| Cloudant コネクターのプロキシー・ホスト。デフォルト: [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration) を参照。 |
| mfp.push.db.cloudant.proxyPort | オプション	| Cloudant コネクターのプロキシー・ポート。デフォルト: [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration) を参照。 |
| mfp.push.services.ext.security | オプション	| セキュリティー拡張機能プラグイン。 |
| mfp.push.security.endpoint | オプション	| 許可サーバーのエンドポイント URL。 |
| mfp.push.security.user | オプション	| 許可サーバーにアクセスするためのユーザー名。 |
| mfp.push.security.password | オプション	| 許可サーバーにアクセスするためのパスワード。 |
| mfp.push.services.ext.analytics | オプション | 分析拡張機能プラグイン。 |
| mfp.push.analytics.endpoint | オプション | 分析サーバーのエンドポイント URL。 |
| mfp.push.analytics.user | オプション | 分析サーバーにアクセスするユーザー名。 |
| mfp.push.analytics.password | オプション | 分析サーバーにアクセスするパスワード。 |
| mfp.push.analytics.events.notificationDispatch | オプション	| 通知がディスパッチされようとしているときの分析イベント。デフォルト: true |
| mfp.push.internalQueue.maxLength | オプション | ディスパッチまで通知タスクを保持するキューの長さ。デフォルト: 200000 |
| mfp.push.gcm.proxy.enabled | オプション	| プロキシーを介して Google GCM にアクセスする必要があるかどうかを示します。デフォルト: false |
| mfp.push.gcm.proxy.protocol | オプション | http または https のいずれかにすることができます。 |
| mfp.push.gcm.proxy.host | オプション | GCM プロキシー・ホスト。負の値はデフォルト・ポートを意味します。 |
| mfp.push.gcm.proxy.port | オプション | GCM プロキシー・ポート。デフォルト: -1 |
| mfp.push.gcm.proxy.user | オプション | プロキシーで認証が必要な場合のプロキシー・ユーザー名。空のユーザー名は、認証がないことを意味します。 |
| mfp.push.gcm.proxy.password | オプション | プロキシーで認証が必要な場合のプロキシー・パスワード。 |
| mfp.push.gcm.connections | オプション | プッシュ GCM の最大接続数。デフォルト: 10 |
| mfp.push.apns.proxy.enabled | オプション | APN にプロキシーを介してアクセスする必要があるかどうかを示します。デフォルト: false |
| mfp.push.apns.proxy.type | オプション | APN プロキシー・タイプ。 |
| mfp.push.apns.proxy.host | オプション | APN プロキシー・ホスト。 |
| mfp.push.apns.proxy.port | オプション | APN プロキシー・ポート。デフォルト: -1 |
| mfp.push.apns.proxy.user | オプション | プロキシーで認証が必要な場合のプロキシー・ユーザー名。空のユーザー名は、認証がないことを意味します。 |
| mfp.push.apns.proxy.password | オプション | プロキシーで認証が必要な場合のプロキシー・パスワード。 |
| mfp.push.apns.connections | オプション | プッシュ APN の最大接続数。デフォルト: 3 |
| mfp.push.apns.connectionIdleTimeout | オプション | APN アイドル接続タイムアウト。デフォルト: 0 |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448 
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## データ・ソースの構成
{: #configuring-data-sources }
サポートされるデータベースに関連する、一部のデータ・ソースの構成の詳細について説明します。

* [DB2 トランザクション・ログ・サイズの管理](#managing-the-db2-transaction-log-size)
* [{{ site.data.keys.mf_server }} および Application Center のデータ・ソースに対する DB2 HADR シームレス・フェイルオーバーの構成](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [失効した接続の処理](#handling-stale-connections)
* [{{ site.data.keys.mf_console }} からのアプリケーションの作成または削除後の失効データ](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### DB2 トランザクション・ログ・サイズの管理
{: #managing-the-db2-transaction-log-size }
IBM {{ site.data.keys.mf_console }} で 40 MB 以上の大きさのアプリケーションをデプロイすると、「トランザクション・ログが満杯です」というエラーを受け取る場合があります。

以下のシステム出力は、「トランザクション・ログが満杯です」エラー・コードの例です。

```bash
DB2 SQL Error: SQLCODE=-964, SQLSTATE=57011
```

各アプリケーションのコンテンツは {{ site.data.keys.product_adj }} 管理データベースに格納されます。

アクティブなログ・ファイルは、**LOGPRIMARY** と **LOGSECOND** の各データベース構成パラメーターでその数が定義され、**LOGFILSIZ** データベース構成パラメーターでそのサイズが定義されます。単一トランザクションでは、**LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096 KB より大きいログ・スペースは使用できません。

`DB2 GET DATABASE CONFIGURATION` コマンドには、ログ・ファイル・サイズ、および 1 次ログ・ファイルと 2 次ログ・ファイルの数に関する情報が含まれています。

デプロイする {{ site.data.keys.product_adj }} アプリケーションの最大サイズに応じて、DB2 ログ・スペースの拡張が必要になる場合があります。

`DB2 update db cfg` コマンドを使用して、**LOGSECOND** パラメーターを大きくします。データベースがアクティブになっているときは、スペースは割り振られません。その代わり、このスペースは必要な場合にのみ割り振られます。

### {{ site.data.keys.mf_server }} および Application Center のデータ・ソースに対する DB2 HADR シームレス・フェイルオーバーの構成
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
WebSphere Application Server Liberty プロファイルおよび WebSphere Application Server でシームレス・フェイルオーバー機能を有効化する必要があります。この機能を使用すると、データベースがフェイルオーバーし、DB2 JDBC ドライバーで転送される場合、例外を管理できます。

> **注:** DB2 HADR フェイルオーバーは、Apache Tomcat 用としてはサポートされていません。

DB2 HADR のデフォルトでは、DB2 JDBC ドライバーが、既存の接続の再使用を初めて試行する際、データベースのフェイルオーバーの検出後にクライアント転送を実行すると、ドライバーは、**ERRORCODE=-4498** と **SQLSTATE=08506** と一緒に **com.ibm.db2.jcc.am.ClientRerouteException** をトリガーします。WebSphere Application Server は、アプリケーションがこの例外を受信する前に **com.ibm.websphere.ce.cm.StaleConnectionException** にマップします。

この場合、アプリケーションは例外をキャッチして、トランザクションを再度実行する必要があります。{{ site.data.keys.product_adj }} および Application Center のランタイム環境では例外を管理しませんが、シームレス・フェイルオーバーと呼ばれる機能を活用します。この機能を有効にするには、**enableSeamlessFailover** JDBC プロパティーを「1」に設定する必要があります。

#### WebSphere Application Server Liberty プロファイルの構成
{: #websphere-application-server-liberty-profile-configuration }
**server.xml** ファイルを編集して、{{ site.data.keys.product_adj }} および Application Center データ・ソースの **properties.db2.jcc** エレメントに **enableSeamlessFailover** プロパティーを追加する必要があります。例えば、次のとおりです。 

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### WebSphere Application Server の構成
{: #websphere-application-server-configuration }
各 {{ site.data.keys.product_adj }} および Application Center データ・ソースの WebSphere Application Server 管理コンソールで以下の操作を実施します。

1. **「リソース」→「JDBC」→「データ・ソース」→「データ・ソース名」**と進みます。
2. **「新規」**を選択し、以下のカスタム・プロパティーを追加するか、プロパティーが既に存在している場合は値を更新します。`enableSeamlessFailover : 1`
3. **「適用」**をクリックします。
4. 構成を保存します。

HADR 対応 DB2 データベースへの接続の構成方法について詳しくは、[HADR 対応 DB2 データベースへの接続のセットアップ](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=en)を参照してください。

### 失効した接続の処理
{: #handling-stale-connections }
データベース・タイムアウトの問題が起きないようにアプリケーション・サーバーを構成します。

**StaleConnectionException** は、JDBC ドライバーが接続要求または接続操作からリカバリー不能エラーを返したときに、Java アプリケーション・サーバー・プロファイルのデータベース接続コードによって生成される例外です。**StaleConnectionException** は、現在接続プールにある接続がもう有効ではないことを示す例外がデータベース・ベンダーによって発行されると発生します。この例外はさまざまな原因で起こります。**StaleConnectionException** の原因として最も一般的なのは、データベース接続プールから接続を取り出そうとして、長期間使用されていなかった場合に接続がタイムアウトになっているか除去されていることが判明することです。

この例外を回避するようにアプリケーション・サーバーを構成できます。

#### Apache Tomcat の構成
{: #apache-tomcat-configuration }
**MySQL **  
MySQL データベースは、一定期間アクティブでない接続があると、接続をクローズします。このタイムアウトは、**wait_timeout** という名前のシステム変数によって定義されます。デフォルトは 28000 秒 (8 時間) です。

MySQL が接続をクローズした後にアプリケーションがデータベースに接続しようとすると、以下の例外が生成されます。

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

**server.xml** ファイルおよび **context.xml** ファイルを編集し、各 `<Resource>` エレメントに以下のプロパティーを追加します。

* **testOnBorrow="true"**
* **validationQuery="select 1"**

例えば、次のとおりです。 

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### WebSphere Application Server Liberty プロファイルの構成
{: #websphere-application-server-liberty-profile-configuration-1 }
**server.xml** ファイルを編集し、各 `<dataSource>` エレメント (ランタイム・データベースおよび Application Center データベース) に、agedTimeout プロパティーを指定した `<connectionManager>` エレメントを追加します。

```xml
<connectionManager agedTimeout="timeout_value"/>
```

タイムアウト値は、主として、同時に開いている接続の数に基づきますが、プール内の最小接続数と最大接続数にも基づきます。したがって、これらの **connectionManager** 属性を調整して、最も適切な値を特定する必要があります。**connectionManager** エレメントについて詳しくは、[Liberty: **server.xml** ファイルの構成エレメント](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html)を参照してください。

> **注:** WebSphere Application Server Liberty プロファイルまたは WebSphere Application Server フル・プロファイルと組み合わせて使用される MySQL は、サポートされる構成には分類されません。詳しくは、「[WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)」を参照してください。IBM サポートによってフルにサポートされている構成の利点を活用するためには、WebSphere Application Server によってサポートされている IBM DB2 データベースまたは別のデータベースを使用します。

### {{ site.data.keys.mf_console }} からのアプリケーションの作成または削除後の失効データ
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
Tomcat 8 アプリケーション・サーバーで、MySQL データベースを使用している場合、{{ site.data.keys.mf_console }} からのサービス呼び出しで 404 エラーが返されることがあります。

Tomcat 8 アプリケーション・サーバーで、MySQL データベースを使用している場合、{{ site.data.keys.mf_console }} を使用してアプリケーションを削除するか、新しいアプリケーションを追加し、その後で何回かコンソールを再表示しようとすると、データが失効していることがあります。例えば、既に削除済みのアプリがリストに表示される場合があります。

この問題を回避するには、データ・ソースまたはデータベース管理システムで、分離レベルを **READ_COMMITTED** に変更します。

**READ_COMMITTED** の意味については、[MySQL 資料](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc) ([http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html)) を参照してください。

* データ・ソースで分離レベルを **READ_COMMITTED** に変更するには、Tomcat 構成ファイル **server.xml** を変更します。**<Resource name="jdbc/mfpAdminDS" .../>** セクションで、**defaultTransactionIsolation="READ_COMMITTED"** 属性を追加します。
* データベース管理システムでグローバルに分離レベルを **READ_COMMITTED** に変更するには、MySQL 資料 ([http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html)) の [SET TRANSACTION Syntax ページ](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html)を参照してください。

#### WebSphere Application Server フル・プロファイル構成
{: #websphere-application-server-full-profile-configuration }
**DB2 または Oracle**  
失効した接続の問題を最小限に抑えるため、WebSphere Application Server 管理コンソールで、各データ・ソースの接続プール構成をチェックします。

1. WebSphere Application Server 管理コンソールにログインします。
2. **「リソース」→「JDBC プロバイダー」→「database_jdbc_provider」→「データ・ソース」→「your_data_source」→「接続プール・プロパティー」**と選択します。
3. **「最小接続数」**の値を 0 に設定します。
4. **「リープ時間」**の値を**「未使用タイムアウト」**の値より小さい値に設定します。
5. **「パージ・ポリシー」**プロパティーが **EntirePool (デフォルト)** に設定されていることを確認します。

詳しくは、[接続プール設定](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html)を参照してください。

**MySQL **  

1. WebSphere Application Server 管理コンソールにログインします。
2. **「リソース」→「JDBC」→「データ・ソース」**と選択します。
3. 各 MySQL データ・ソースについて以下の操作を実行します。
    * データ・ソースをクリックします。
    * **「追加プロパティー」**の下の**「接続プール」**プロパティーを選択します。
    * **「経過時間タイムアウト (Aged timeout)」**プロパティーの値を変更します。MySQL がこれらの接続を閉じる前に接続がパージされるようにするために、この値は、MySQL の **wait_timeout** システム変数よりも小さい値にする必要があります。
    * **「OK」**をクリックします。

> **注:** WebSphere Application Server Liberty プロファイルまたは WebSphere Application Server フル・プロファイルと組み合わせて使用される MySQL は、サポートされる構成には分類されません。詳しくは、「[WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)」を参照してください。IBM サポートによってフルにサポートされている構成の利点を活用するためには、WebSphere Application Server によってサポートされている IBM DB2 データベースまたは別のデータベースを使用します。

## ロギングとモニタリングのメカニズムの構成
{: #configuring-logging-and-monitoring-mechanisms }
{{ site.data.keys.product }} は、エラー、警告、情報メッセージをログ・ファイルに報告します。基本的なロギングのメカニズムはアプリケーション・サーバーによって異なります。

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.product }} (略して {{ site.data.keys.mf_server }}) は、標準の java.util.logging パッケージを使用します。デフォルトでは、すべての {{ site.data.keys.product_adj }} ロギングがアプリケーション・サーバー・ログ・ファイルに入ります。各アプリケーション・サーバーで使用可能な標準のツールを使用して {{ site.data.keys.mf_server }} ロギングを制御できます。例えば、WebSphere Application Server Liberty でトレース・ロギングをアクティブにする場合、トレース・エレメントを server.xml ファイルに追加します。WebSphere Application Server でトレース・ロギングをアクティブにするには、コンソールでロギング画面を使用し、{{ site.data.keys.product_adj }} ログのトレースを有効にします。

{{ site.data.keys.product_adj }} のログはすべて **com.ibm.mfp** で始まります。  
Application Center のログは **com.ibm.puremeap** で始まります。

ログ・ファイルの場所も含めて各アプリケーション・サーバーのロギング・モデルについて詳しくは、以下の表に示す関連アプリケーション・サーバーの資料を参照してください。

| アプリケーション・サーバー | 資料の場所 |
| -------------------|---------------------------|
| Apache Tomcat	     | [http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
| WebSphere Application Server バージョン 8.5 フル・プロファイル | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
| WebSphere Application Server バージョン 8.5 Liberty プロファイル | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### ログ・レベル・マッピング
{: #log-level-mappings }
{{ site.data.keys.mf_server }} は **java.util.logging** API を使用します。ロギング・レベルは以下のレベルにマップされます。

* WL.Logger.debug: FINE
* WL.Logger.info: INFO
* WL.Logger.warn: WARNING
* WL.Logger.error: SEVERE

### ログ・モニタリング・ツール
{: #log-monitoring-tools }
Apache Tomcat の場合、[IBM Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) またはその他の業界標準のログ・ファイル・モニタリング・ツールを使用してログをモニターし、エラーと警告を強調表示できます。

WebSphere Application Server の場合、IBM Knowledge Center で説明されているログ表示機能を使用します。URL は、このページの「{{ site.data.keys.mf_server }}」セクションの表にリストされています。

### バックエンド接続
{: #back-end-connectivity }
バックエンド接続をモニターするトレースを有効にするには、このページの「{{ site.data.keys.mf_server }}」セクションの表で、特定のアプリケーション・サーバー・プラットフォーム用の資料を参照してください。**com.ibm.mfp.server.js.adapter** パッケージを使用し、ログ・レベルを **FINEST** に設定します。

### 管理操作の監査ログ
{: #audit-log-for-administration-operations }
{{ site.data.keys.mf_console }} は、ログインの監査ログ、ログアウトの監査ログ、およびアプリケーションまたはアダプターのデプロイまたはアプリケーションのロックといったすべての管理操作の監査ログを格納します。監査ログは、{{ site.data.keys.product_adj }} 管理サービスの Web アプリケーション (**mfp-admin-service.war**) で JNDI プロパティー **mfp.admin.audit** を false に設定することにより無効にできます。

監査ログが使用可能な場合は、ページのフッターにある**「監査ログ」**リンクをクリックして、{{ site.data.keys.mf_console }} から監査ログをダウンロードできます。 

### ログイン問題と認証問題
{: #login-and-authentication-issues }
ログインと認証の問題を診断するには、パッケージ **com.ibm.mfp.server.security** でトレースを使用可能にし、ログ・レベルを **FINEST** に設定します。

## 複数ランタイムの構成
{: #configuring-multiple-runtimes }
複数のランタイムで {{ site.data.keys.mf_server }} を構成し、{{ site.data.keys.mf_console }} でアプリケーションの「タイプ」によって表示を区別することができます。

> **注:** Mobile Foundation Bluemix サービスで作成された Mobile Foundation サーバー・インスタンスで、複数ランタイムはサポートされません。Bluemix サービスでは、代わりに複数サービス・インスタンスを作成してください。

#### ジャンプ先
{: #jump-to-1 }
* [WebSphere Liberty プロファイルでの複数ランタイムの構成](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [異なるランタイムへのアプリケーションの登録とアダプターのデプロイ](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [ランタイム構成のエクスポートおよびインポート](#exporting-and-importing-runtime-configurations)

### WebSphere Liberty プロファイルでの複数ランタイムの構成
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. アプリケーション・サーバーの **server.xml** ファイルを開きます。通常、**[application-server]/usr/servers/server-name/** フォルダー内にあります。例えば、{{ site.data.keys.mf_dev_kit }} では、**[installation-folder]/mfp-server/usrs/servers/mfp/server.xml** にファイルがあります。

2. 2 つめの `application` エレメントを追加します。

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. 2 つめの JNDI 項目セットを追加します。

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. 2 つめの `dataSource` エレメントを追加します。

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **注:**
    >
    > * `dataSource` が、別のデータベース・スキーマを指していることを確認します。
    > * 新しいランタイムに[別のデータベース・インスタンス](../databases)を作成したことを確認します。
    > * 開発環境では、子エレメント `properties.derby.embedded` に `createDatabase="create"` を追加します。

5. アプリケーション・サーバーを再始動します。

### 異なるランタイムへのアプリケーションの登録とアダプターのデプロイ
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
{{ site.data.keys.mf_server }} が複数のランタイムで構成された場合、アプリケーションの登録とアダプターのデプロイは少し異なります。

* [{{ site.data.keys.mf_console }}](#registering-and-deploying-from-the-mobilefirst-operations-console) からの登録およびデプロイ
* [コマンド・ラインからの登録およびデプロイ](#registering-and-deploying-from-the-command-line)

#### {{ site.data.keys.mf_console }} からの登録およびデプロイ
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
{{ site.data.keys.mf_console }} でこれらのアクションを実行する際には、登録先またはデプロイ先のランタイムを選択することが必要になります。

<img class="gifplayer" alt="{{ site.data.keys.mf_console }} の複数ランタイム" src="register-and-deploy-to-multiple-runtimes.png"/>

#### コマンド・ラインからの登録およびデプロイ
{: #registering-and-deploying-from-the-command-line }
**mfpdev** コマンド・ライン・ツールでこれらのアクションを実行する際には、登録先またはデプロイ先のランタイム名を追加することが必要になります。

アプリケーションを登録するには、以下を実行します。`mfpdev app register <server-name> <runtime-name>`  

```bash
mfpdev app register local second-runtime
```

アダプターをデプロイするには、以下を実行します。`mfpdev adapter deploy <server-name> <runtime-name>`  

```bash
mfpdev adapter deploy local second-runtime
```

* **local** は、{{ site.data.keys.mf_cli }} でのデフォルト・サーバー定義の名前です。*local* は、登録またはデプロイする必要がある宛先のサーバー定義名に置き換えます。
* **runtime-name** は、登録先またはデプロイ先のランタイムの名前です。

> 以下の CLI help コマンドの詳細を確認してください。
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## ランタイム構成のエクスポートおよびインポート
{: #exporting-and-importing-runtime-configurations }
{{ site.data.keys.mf_server }} **管理サービス**の REST API を使用し、ランタイム構成をエクスポートして別の {{ site.data.keys.mf_server }} にインポートすることができます。

例えば、開発環境でランタイム構成をセットアップし、その構成をエクスポートして、迅速なセットアップのためにテスト環境にインポートし、その後、テスト環境の固有のニーズに合わせて追加で構成を行うことができます。

> 使用可能なすべての REST API の詳細は、[API リファレンス](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html)にあります。

## ライセンス・トラッキングの構成
{: #configuring-license-tracking }
ライセンス・トラッキングはデフォルトで有効になります。ライセンス・トラッキングの構成方法について詳しくは、以下のトピックをお読みください。ライセンス・トラッキングについて詳しくは、[ライセンス・トラッキング](../../../administering-apps/license-tracking)を参照してください。

* [クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングの構成](#configuring-license-tracking-for-client-device-and-addressable-device)
* [IBM License Metric Tool ログ・ファイルの構成](#configuring-ibm-license-metric-tool-log-files)

### クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングの構成
{: #configuring-license-tracking-for-client-device-and-addressable-device }
クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングはデフォルトで有効になります。ライセンス・レポートは {{ site.data.keys.mf_console }} で使用可能です。以下の JNDI プロパティーを指定して、ライセンス・トラッキングについてのデフォルト設定を変更することができます。

> **注:** トークン・ライセンスの使用を定義した契約がある場合、[トークン・ライセンスのためのインストールおよび構成](../token-licensing)も参照してください。

以下の JNDI プロパティーを指定して、ライセンス・トラッキングについてのデフォルト設定を変更することができます。

**mfp.device.decommission.when**  
デバイス廃用タスクによってデバイスが廃用にされるまでの非アクティブ猶予日数。ライセンス・レポートでは、廃用にされたデバイスはアクティブ・デバイスにはカウントされません。このプロパティーのデフォルト値は 90 日です。クライアント・デバイスまたはアドレス可能デバイスによってライセンス交付を受けたソフトウェアを使用している場合は値を 30 日未満に設定しないでください。そうしないと、ライセンス・レポートでは準拠性を十分に判定できない可能性があります。

**mfp.device.archiveDecommissioned.when**  
廃用にされたデバイスが廃用タスク実行時にアーカイブ・ファイルに入れられる時期を定義する値 (日数)。アーカイブされたデバイスは、IBM {{ site.data.keys.mf_server }} の **home\devices_archive** ディレクトリーにあるファイルに書き込まれます。このファイルの名前には、アーカイブ・ファイルが作成されたときのタイム・スタンプが含まれます。デフォルト値は 90 日です。

**mfp.device.decommissionProcessingInterval**  
廃用タスクが実行される頻度 (秒単位) を定義します。デフォルト: 86400 (1 日)。廃用タスクは以下の処理を実行します。

* **mfp.device.decommission.when** 設定に基づいて、非アクティブなデバイスを廃用にします。
* オプションで、**mfp.device.archiveDecommissioned.when** 設定に基づいて、廃用にされたデバイスのうち古いものをアーカイブします。
* ライセンス・トラッキング・レポートを生成します。

**mfp.licenseTracking.enabled**  
{{ site.data.keys.product }} でライセンス・トラッキングを有効または無効にするために使用される値。デフォルトでは、ライセンス・トラッキングは有効にされます。パフォーマンス上の理由のため、{{ site.data.keys.product }} が Client Device または Addressable Device によるライセンス交付を受けていない場合は、このフラグを無効にすることができます。デバイス・トラッキングが無効になると、ライセンス・レポートも無効になり、ライセンス・メトリックが作成されません。その場合、アプリケーション・カウントに関する IBM License Metric Tool レコードのみが生成されます。

JNDI プロパティーの指定について詳しくは、[{{ site.data.keys.product_adj }} ランタイムの JNDI プロパティーのリスト](#list-of-jndi-properties-for-mobilefirst-runtime)を参照してください。

### IBM License Metric Tool ログ・ファイルの構成
{: #configuring-ibm-license-metric-tool-log-files }
{{ site.data.keys.product }} は IBM Software License Metric Tag (SLMT) ファイルを生成します。IBM Software License Metric Tag をサポートするバージョンの IBM License Metric Tool は、ライセンス消費レポートを生成することができます。ここでは、生成されるファイルの場所および最大サイズを構成する方法を説明します。

デフォルトでは、IBM Software License Metric Tag ファイルは以下のディレクトリーにあります。

* Windows の場合: **%ProgramFiles%\ibm\common\slm**
* UNIX および UNIX 系のオペレーティング・システムの場合: **/var/ibm/common/slm**

これらのディレクトリーに書き込めない場合、ファイルは {{ site.data.keys.product_adj }} ランタイム環境を実行しているアプリケーション・サーバーのログ・ディレクトリーに作成されます。

以下のプロパティーを使用して、これらのファイルの場所と管理を構成できます。

* **license.metric.logger.output.dir**: IBM Software License Metric Tag ファイルの場所
* **license.metric.logger.file.size**: SLMT ファイルの最大サイズ。これを超えると循環が実行されます。デフォルト・サイズは 1 MB です。
* **license.metric.logger.file.number**: 循環中に保持する SLMT アーカイブ・ファイルの最大数。デフォルトの数は 10 です。

デフォルト値を変更するには、**key=value** の形式で Java プロパティー・ファイルを作成し、さらに **license_metric_logger_configuration** JVM プロパティーでプロパティー・ファイルへのパスを指定する必要があります。

IBM License Metric Tool レポートの詳細については、[IBM License Metric Tool との統合](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool)を参照してください。

## WebSphere Application Server SSL 構成および HTTP アダプター
{: #websphere-application-server-ssl-configuration-and-http-adapters }
プロパティーを設定することにより、HTTP アダプターは WebSphere SSL 構成を利用できるようになります。

デフォルトでは、HTTP アダプターは、Java ランタイム環境 (JRE) トラストストアを {{ site.data.keys.mf_server }} 鍵ストアに連結した WebSphere SSL (これについては、[{{ site.data.keys.mf_server }} 鍵ストアの構成](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore)に説明があります) を使用しません。[自己署名証明書の使用によるアダプターとバックエンド・サーバーの間の SSL の構成](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)も参照してください。

HTTP アダプターで WebSphere SSL 構成を使用するには、**ssl.websphere.config** JNDI プロパティーを true に設定します。この設定には、以下の効果があります (優先順)。

1. WebSphere 上で稼働しているアダプターが、{{ site.data.keys.mf_server }} 鍵ストアではなく、WebSphere 鍵ストアを使用します。
2. **ssl.websphere.alias** プロパティーが設定されている場合、アダプターは、このプロパティーに設定されている別名に関連付けられた SSL 構成を使用します。
