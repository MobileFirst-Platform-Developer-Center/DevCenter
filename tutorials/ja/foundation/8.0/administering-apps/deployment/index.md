---
layout: tutorial
title: テスト環境および実稼働環境へのアプリケーションのデプロイ
breadcrumb_title: 環境へのアプリケーションのデプロイ
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
アプリケーションの開発サイクルが終了した場合、そのアプリケーションをテスト環境にデプロイしてから、実稼働環境にデプロイします。

### ジャンプ先
{: #jump-to }

* [実稼働環境へのアダプターのデプロイまたは更新](#deploying-or-updating-an-adapter-to-a-production-environment)
* [自己署名証明書の使用による  アダプターとバックエンド・サーバーの間の SSL の構成](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)
* [実稼働環境へのアプリケーションの登録](#registering-an-application-to-a-production-environment)
* [テスト・サーバーまたは実動サーバーへのサーバー・サイド成果物の転送](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [実動での {{ site.data.keys.product_adj }} アプリケーションの更新](#updating-mobilefirst-apps-in-production)

## 実稼働環境へのアダプターのデプロイまたは更新
{: #deploying-or-updating-an-adapter-to-a-production-environment }
アダプターには、{{ site.data.keys.product }} によってデプロイされてサービスを受けるアプリケーションのサーバー・サイド・コードが含まれています。アダプターを実稼働環境にデプロイまたは更新する前に、このチェックリストをお読みください。アダプターの作成およびビルドについて詳しくは、[{{ site.data.keys.product_adj }} アプリケーションのサーバー・サイドの開発](../../adapters)を参照してください。

実動サーバーが稼働中に、アダプターをアップロード、更新、および構成することができます。 サーバー・ファームのすべてのノードが新規アダプターまたは構成を受信すると、アダプターへのすべての着信要求は新規の設定を使用します。

1. 実稼働環境で既存のアダプターを更新する場合は、このアダプターに、サーバーに登録されている既存のアプリケーションとの非互換性および回帰がないことを確認します。

    ストアに既に公開されて使用されている複数のアプリケーションや同じアプリケーションの複数のバージョンで、同じアダプターを使用することができます。テスト・サーバー用にビルドした新規アダプターとアプリケーションのコピーに対して、テスト・サーバーで非回帰テストを実行してから、実稼働環境でアダプターを更新します。

2. Java アダプターが HTTPS を使用した Java URL 接続を使用する場合、バックエンド証明書が {{ site.data.keys.mf_server }} 鍵ストアにあることを確認します。
        
    詳しくは、[HTTP アダプターでの SSL の使用 (Using SSL in HTTP adapters)](../../adapters/javascript-adapters/js-http-adapter/using-ssl/) を参照してください。自己署名証明書の使用について詳しくは、[自己署名証明書の使用によるアダプターとバックエンド・サーバーの間の SSL の構成](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)を参照してください。

    > **注:** アプリケーション・サーバーが WebSphere  Application Server Liberty の場合、証明書は Liberty のトラストストアにも格納する必要があります。  

3. アダプターのサーバー・サイド構成を確認してください。
4. `mfpadm deploy adapter` および `mfpadm adapter set user-config` コマンドを使用して、アダプターおよびその構成をアップロードします。

    アダプター用の **mfpadm** について詳しくは、[アダプター用のコマンド](../using-cli/#commands-for-adapters)を参照してください。
        
## 自己署名証明書の使用による  アダプターとバックエンド・サーバーの間の SSL の構成
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
サーバーの自己署名 SSL 証明書を {{ site.data.keys.product_adj }} 鍵ストアにインポートすることにより、アダプターとバックエンド・サーバーとの間の SSL を構成することができます。

1. サーバーのパブリック証明書をバックエンド・サーバー鍵ストアからエクスポートします。

    > **注:** keytool または openssl lib を使用して、バックエンド鍵ストアからバックエンド・パブリック証明書をエクスポートします。Web ブラウザーで export フィーチャーを使用しないでください。

2. バックエンド・サーバー証明書を {{ site.data.keys.product_adj }} 鍵ストアにインポートします。
3. 新しい {{ site.data.keys.product_adj }} 鍵ストアをデプロイします。詳しくは、[{{ site.data.keys.mf_server }} 鍵ストアの構成](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。

### 例
{: #example }
バックエンド証明書の **CN** 名は、アダプター記述子ファイル **adapter.xml** 内に構成されている名前と一致している必要があります。例えば、次のように構成されている **adapter.xml** ファイルについて検討します。

```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

バックエンド証明書は、**CN=mybackend.com** を使用して生成される必要があります。

別の例として、次のアダプター構成について検討します。

```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

バックエンド証明書は、**CN=123.124.125.126** を使用して生成される必要があります。

次の例は、Keytool プログラムを使用して構成を実行する方法を示しています。

1. 365 日間のプライベート証明書を含むバックエンド・サーバー鍵ストアを作成します。
        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **注:** **「ファーストネームおよびラストネーム (First and Last Name)」** フィールドには、**adapter.xml** で使用するサーバー URL が含まれます (**mydomain.com** または **localhost** など)。

2. 鍵ストアと連携して動作するようにバックエンド・サーバーを構成します。例えば、Apache Tomcat では、**server.xml** ファイルを次のように変更します。

   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. **adapter.xml** ファイル内の接続性構成をチェックします。

   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- The following properties are used by adapter's key manager for choosing a specific certificate from the key store
        <sslCertificateAlias></sslCertificateAlias> 
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. パブリック証明書を、作成されたバックエンド・サーバー鍵ストアからエクスポートします。

   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. 以下のようにして、エクスポートした証明書を {{ site.data.keys.mf_server }} 鍵ストアにインポートします。

   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. 証明書が鍵ストアに正しくインポートされたことをチェックします。

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. 新しい {{ site.data.keys.mf_server }} 鍵ストアをデプロイします。

## テスト環境または実稼働環境用のアプリケーションのビルド
{: #building-an-application-for-a-test-or-production-environment }
テスト環境または実稼働環境用にアプリケーションをビルドするには、アプリケーションをターゲット・サーバー向けに構成する必要があります。アプリケーションを実稼働環境用にビルドするには、追加の手順が適用されます。

1. ターゲット・サーバーの鍵ストアが構成されていることを確認します。
詳しくは、[{{ site.data.keys.mf_server }} 鍵ストアの構成](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。

2. アプリケーションのインストール可能な成果物を配布する予定の場合は、アプリケーションのバージョンをインクリメントします。
3. アプリケーションを、ビルドする前にターゲット・サーバー用に構成します。

    ターゲット・サーバーの URL とランタイム名を、クライアントのプロパティー・ファイルで定義します。{{ site.data.keys.mf_cli }} を使用してターゲット・サーバーを変更することもできます。実行中のサーバーにアプリケーションを登録せずにターゲット・サーバー用にアプリケーションを構成するには、`mfpdev app config server <server URL>` コマンドおよび `mfpdev app config runtime <runtime_name>` コマンドを使用できます。あるいは、`mfpdev app register` コマンドを実行して、実行中のサーバーにアプリケーションを登録することもできます。サーバーの公開 URL を使用してください。この URL は、{{ site.data.keys.mf_server }} に接続するためにモバイル・アプリケーションによって使用されます。
    
    例えば、デフォルトの名前 mfp を持つランタイムを使用して、アプリケーションをターゲット・サーバー mfp.mycompany.com 用に構成するには、
    `mfpdev app config server https://mfp.mycompany.com` および `mfpdev app config runtime mfp` を実行します。
    
4. アプリケーションの秘密鍵と許可サーバーを構成します。
    * ご使用のアプリケーションが証明書のピン留めを実装する場合、ターゲット・サーバーの証明書を使用します。証明書のピン留めについて詳しくは、[証明書のピン留め](../../authentication-and-security/certificate-pinning)を参照してください。
    * iOS アプリケーションが App Transport Security (ATS) を使用する場合、ターゲット・サーバー用に ATS を構成します。
    * Apache Cordova アプリケーションのセキュア・ダイレクト・アップデートを構成するには、[クライアント・サイドでのセキュア・ダイレクト・アップデートの実装 (Implementing secure Direct Update on the client side)](../../application-development/direct-update) を参照してください。
    * Apache Cordova を使用してアプリケーションを開発する場合は、Cordova Content Security Policy (CSP) を構成します。    

5. Apache Cordova を使用して開発したアプリケーション用にダイレクト・アップデートを使用する予定の場合は、アプリケーションのビルドに使用した Cordova プラグインのバージョンをアーカイブします。

    ダイレクト・アップデートは、ネイティブ・コードの更新には使用できません。ネイティブ・ライブラリーまたは Cordova プロジェクトのビルド・ツールの 1 つを変更し、そのファイルを {{ site.data.keys.mf_server }} にアップロードした場合は、サーバーはこの違いを検出し、クライアント・アプリケーションには一切更新を送信しません。ネイティブ・ライブラリーの変更には、異なる Cordova バージョン、新規の Cordova iOS プラグイン、または元のアプリケーションのビルド時に使用したものよりも新しい mfpdev プラグイン・フィックスパックが含まれている可能性があります。
    
6. 実動用にアプリケーションを構成します。
    * デバイス・ログへの出力を無効にすることを検討します。
    * {{ site.data.keys.mf_analytics }} を使用する予定である場合は、アプリケーションが収集データを {{ site.data.keys.mf_server }} に送信することを確認します。
    * 複数のテスト・サーバー用の単一のビルドを作成する予定がない場合は、`setServerURL` API を呼び出すアプリケーションのフィーチャーを無効にすることを検討してください。

7. 実動サーバー用にビルドしてインストール可能成果物を配布する予定の場合は、アプリケーション・ソース・コードをアーカイブして、テスト・サーバー上でこのアプリケーションに対して非回帰テストを実行できるようにします。

    例えば、アダプターを後から更新する場合、このアダプターを使用する配布済みのアプリケーションに非回帰テストを実行する場合があります。詳しくは、[実稼働環境へのアダプターのデプロイまたは更新](#deploying-or-updating-an-adapter-to-a-production-environment)を参照してください。
    
8. オプション: アプリケーションのアプリケーション認証性ファイルを作成します。

    アプリケーションをサーバーに登録してアプリケーション認証のセキュリティー検査を有効にした後に、アプリケーション認証ファイルを使用します。
    * 詳しくは、[アプリケーション認証性セキュリティー検査の有効化](../../authentication-and-security/application-authenticity)を参照してください。
    * アプリケーションの実動サーバーへの登録について詳しくは、[実稼働環境へのアプリケーションの登録](#registering-an-application-to-a-production-environment)を参照してください。

## 実稼働環境へのアプリケーションの登録
{: #registering-an-application-to-a-production-environment }
アプリケーションを実稼働環境に登録する場合、そのアプリケーション記述子をアップロードし、ライセンス・タイプを定義し、オプションでアプリケーション認証をアクティブにします。

#### 始める前に
{: #before-you-begin }
* {{ site.data.keys.mf_server }} 鍵ストアが構成されてデフォルトの鍵ストアではないことを確認します。デフォルトの鍵ストアを指定して実動でサーバーを使用しないでください。{{ site.data.keys.mf_server }} 鍵ストアは、{{ site.data.keys.mf_server }} インスタンスの ID を定義し、OAuth トークンおよびダイレクト・アップデート・パッケージにデジタル署名するために使用します。サーバーの鍵ストアを実動で使用するには、秘密鍵を使用してこれを構成する必要があります。詳しくは、[{{ site.data.keys.mf_server }} 鍵ストアの構成](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。
* アプリケーションが使用するアダプターをデプロイします。詳しくは、[実稼働環境へのアダプターのデプロイまたは更新](#deploying-or-updating-an-adapter-to-a-production-environment)を参照してください。
* ターゲット・サーバー用にアプリケーションをビルドします。詳しくは、[テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)を参照してください。

アプリケーションを実稼働環境に登録する場合、そのアプリケーション記述子をアップロードし、ライセンス・タイプを定義し、オプションでアプリケーション認証をアクティブにします。アプリケーションの古いバージョンがデプロイ済みの場合は、更新戦略を定義することもあります。以下の手順で、重要なステップと、**mfpadm** プログラムを使用したステップの自動化の方法について説明します。

1. トークン・ライセンス用に {{ site.data.keys.mf_server }} が構成される場合、License Key Server 上に使用可能なトークンが十分にあることを確認します。詳しくは、[トークン・ライセンス検証](../license-tracking/#token-license-validation)および[トークン・ライセンスの使用の計画](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing)を参照してください。

   > **ヒント:** アプリケーションの初期バージョンを登録する前に、アプリケーションのトークン・ライセンス・タイプを設定することができます。詳しくは、『[アプリケーション・ライセンス情報の設定 (Setting the application license information)](../license-tracking/#setting-the-application-license-information)』を参照してください。

2. テスト・サーバーから実動サーバーへアプリケーション記述子を転送します。

   この演算は、ご使用のアプリケーションを実動サーバーへ登録し、その構成をアップロードします。アプリケーション記述子の転送について詳しくは、[テスト・サーバーまたは実動サーバーへのサーバー・サイド成果物の転送](#transferring-server-side-artifacts-to-a-test-or-production-server)を参照してください。

3. アプリケーション・ライセンス情報を設定します。詳しくは、[アプリケーション・ライセンス情報の設定](../license-tracking/#setting-the-application-license-information)を参照してください。
4. アプリケーション認証のセキュリティー検査を構成します。アプリケーション認証のセキュリティー検査について詳しくは、 [アプリケーション認証のセキュリティー検査の構成](../../authentication-and-security/application-authenticity/#configuring-application-authenticity)を参照してください。

   > **注:** アプリケーション認証ファイルを作成するには、アプリケーション・バイナリー・ファイルが必要です。詳しくは、[アプリケーション認証性セキュリティー検査の有効化](../../authentication-and-security/application-authenticity/#enabling-application-authenticity)を参照してください。

5. アプリケーションがプッシュ通知を使用する場合、プッシュ通知証明書をサーバーにアップロードします。{{ site.data.keys.mf_console }}を使用してアプリケーションのプッシュ証明書をアップロードできます。証明書はアプリケーションのすべてのバージョンに共通です。

   > **注:** アプリケーションがストアに公開される前に、実動用の証明書を使用してアプリケーションのプッシュ通知をテストすることができない場合があります。

6. アプリケーションをストアに公開する前に、次の項目を確認します。
    * リモート・アプリケーションの無効化または管理者メッセージの表示など、使用する予定のモバイル・アプリケーション管理フィーチャーをテストします。詳しくは、[モバイル・アプリケーションの管理](../using-console/#mobile-application-management)を参照してください。
    * 更新の場合、更新戦略を定義します。詳しくは、[実動での {{ site.data.keys.product_adj }} アプリケーションの更新](#updating-mobilefirst-apps-in-production)を参照してください。

## テスト・サーバーまたは実動サーバーへのサーバー・サイド成果物の転送
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
コマンド・ライン・ツールまたは REST API を使用して、あるサーバーから別のサーバーへアプリケーション構成を転送することができます。

アプリケーション記述子ファイルは JSON ファイルであり、アプリケーションの説明と構成を含みます。{{ site.data.keys.mf_server }} インスタンスに接続するアプリケーションを実行する場合、アプリケーションはそのサーバーに登録されて構成される必要があります。アプリケーションの構成を定義した後、アプリケーション記述子を別のサーバー (例えばテスト・サーバーや実動サーバー) に転送することができます。アプリケーション記述子を新規サーバーに転送後、アプリケーションは新規サーバーに登録されます。モバイル・アプリケーションを開発していてコードへのアクセス権限があるかどうか、またはサーバーを管理していてモバイル・アプリケーションのコードへのアクセス権限がないかどうかによって、異なる手順が使用可能です。

> **重要:** 認証データを含むアプリケーションをインポートする場合で、認証データの生成以降にアプリケーション自体が再コンパイルされている場合、認証データをリフレッシュする必要があります。詳しくは、 [ アプリケーション認証のセキュリティー検査の構成 (Configuring the application-authenticity security check)](../../authentication-and-security/application-authenticity/#configuring-application-authenticity) を参照してください。

* モバイル・アプリケーションのコードへのアクセス権限がある場合は、 `mfpdev app pull` および `mfpdev app push` コマンドを使用してください。
* モバイル・アプリケーションのコードへのアクセス権限がない場合、管理サービスを使用してください。

#### ジャンプ先
{: #jump-to-1 }

* [mfpdev を使用したアプリケーション構成の転送](#transferring-an-application-configuration-by-using-mfpdev)
* [管理サービスを使用したアプリケーション構成の転送](#transferring-an-application-configuration-with-the-administration-service)
* [REST API を使用したサーバー・サイド成果物の転送](#transferring-server-side-artifacts-by-using-the-rest-api)
* [MobileFirst Operations Console からのアプリケーションとアダプターのエクスポートとインポート](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### mfpdev を使用したアプリケーション構成の転送
{: #transferring-an-application-configuration-by-using-mfpdev }
アプリケーションの開発後、アプリケーションを開発環境からテスト環境または実稼働環境へ転送することができます。

* ローカル・コンピューターに既存の {{ site.data.keys.product_adj }} アプリケーションが必要です。アプリケーションを {{ site.data.keys.mf_server }} に登録する必要があります。サーバー・プロファイルの作成については、**mfpdev app register** を実行するか、この文書の『アプリケーションの開発』セクションにあるアプリケーションのタイプの登録に関するトピックを参照してください。
* ローカル・コンピューターが、現在アプリケーションが登録されているサーバーと、アプリケーションの転送先とするサーバーに接続されていなければなりません。
* 元の {{ site.data.keys.mf_server }} およびアプリケーションの転送先とするサーバーの両方に対して、ローカル・コンピューター上にサーバー・プロファイルが必要です。サーバー・プロファイルの作成については、**mfpdev server add** を実行します。
* {{ site.data.keys.mf_cli }} がインストールされている必要があります。

**mfpdev app pull** コマンドを使用して、アプリケーションのサーバー・サイド構成ファイルのコピーをローカル・コンピューターに送信します。次に ** mfpdev app push** コマンドを使用して、これを別の {{ site.data.keys.mf_server }} に送信します。また、** mfpdev app push** コマンドは、指定したサーバーにアプリケーションを登録します。

これらのコマンドを使用して、あるサーバーから別のサーバーへランタイム構成を転送することもできます。

構成情報には、サーバーに対してアプリケーションを一意に識別するアプリケーション記述子と、アプリケーションに固有のその他の情報が含まれます。構成ファイルは圧縮ファイル (.zip 形式) として提供されます。.zip ファイルは、**appName/mobilefirst** ディレクトリーに置かれ、次のように名前が付けられます。

```bash
appID-platform-version-artifacts.zip
```

ここで、**appID** はアプリケーション名、**platform** は **android**、**ios**、または **windows** のいずれか、version はアプリケーションのバージョン・レベルです。Cordova アプリケーションでは、各ターゲット・プラットフォーム用に個別の .zip ファイルが作成されます。

**mfpdev app push** コマンドを使用する場合、新規 {{ site.data.keys.mf_server }} のプロファイル名および URL を反映するように、アプリケーションのクライアント・プロパティー・ファイルが変更されます。

1. 開発コンピューターで、アプリケーションのルート・ディレクトリーであるディレクトリーまたはそのサブディレクトリーのいずれかにナビゲートします。
2. **mfpdev app pull** コマンドを実行します。パラメーターを指定せずにコマンドを指定すると、アプリケーションはデフォルトの {{ site.data.keys.mf_server }} からプルされます。特定のサーバーとその管理者パスワードを指定することもできます。例えば、**myapp1** という Android アプリケーションの場合は以下のようになります。

   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   このコマンドは、サーバー・プロファイルの名前が Server 10 である {{ site.data.keys.mf_server }} 上で、現行アプリケーションの構成ファイルを検出します。次に、これらの構成ファイルを含む圧縮ファイル **myapp1-android-1.0.0-artifacts.zip** をローカル・コンピューターに送信し、 **myapp1/mobilefirst** ディレクトリーに格納します。
    
3. **mfpdev app push** コマンドを実行します。パラメーターを指定せずにコマンドを指定すると、アプリケーションはデフォルトの {{ site.data.keys.mf_server }} にプッシュされます。特定のサーバーとその管理者パスワードを指定することもできます。例えば、直前のステップでプッシュされたアプリケーションの場合は以下のようになります。`mfpdev app push Server12 -password secretPass234!`
    
   このコマンドは、サーバー・プロファイル名が Server12 で管理者パスワードが **secretPass234!** である {{ site.data.keys.mf_server }} に、**myapp1-android-1.0.0-artifacts.zip** ファイルを送信します。サーバーの URL を使用して、アプリケーションが登録されるサーバーが Server12 であることを反映するように、クライアント・プロパティー・ファイル **myapp1/app/src/main/assets/mfpclient.properties** が変更されます。

アプリケーションのサーバー・サイド構成ファイルは、mfpdev app push コマンドで指定した {{ site.data.keys.mf_server }} にあります。アプリケーションはこの新規サーバーに登録されます。

### 管理サービスを使用したアプリケーション構成の転送
{: #transferring-an-application-configuration-with-the-administration-service }
管理者は、{{ site.data.keys.mf_server }} の管理サービスを使用して、あるサーバーから別のサーバーへアプリケーションの構成を転送することができます。アプリケーション・コードへのアクセスは不要ですが、クライアント・アプリケーションはターゲット・サーバーに対して作成されなければなりません。

#### 始める前に
{: #before-you-begin-1 }
ターゲット・サーバー用にクライアント・アプリケーションをビルドします。詳しくは、[テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)を参照してください。

アプリケーションが構成されているサーバーからアプリケーション記述子をダウンロードし、新規サーバーへデプロイします。アプリケーション記述子は {{ site.data.keys.mf_console }} で確認できます。

1. オプション: アプリケーション・サーバーが構成されているサーバーのアプリケーション記述子を検討します。
    そのサーバーの {{ site.data.keys.mf_console }} を開き、アプリケーション・バージョンを選択して、**「構成ファイル」**タブへ移動します。

2. アプリケーションが構成されているサーバーからアプリケーション記述子をダウンロードします。REST API または **mfpadm** を使用してダウンロードすることができます。

   > **注:** {{ site.data.keys.mf_console }} からアプリケーションまたはアプリケーション・バージョンをエクスポートすることもできます。[{{ site.data.keys.mf_console }} からのアプリケーションとアダプターのエクスポートとインポート](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)を参照してください。
    * REST API を使用してアプリケーション記述子をダウンロードするには、 [ アプリケーション記述子 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST API を使用します。

    以下の URL は、アプリケーション ID が **my.test.application**、プラットフォームが **ios** 、およびそのバージョンが **0.0.1** のアプリケーションのアプリケーション記述子を返します。{{ site.data.keys.mf_server }}: `http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor` に対する呼び出しが行われます。
    
    例えば、次のように、curl のようなツールで、そのような URL を使用できます。`curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`
    
    <br/>
    サーバ―構成に応じて URL の次のエレメントを変更します。
     * **9080** は、開発中は {{ site.data.keys.mf_server }} のデフォルトの HTTP ポートです。
     * **mfpadmin** は、管理サービスのデフォルトのコンテキスト・ルートです。 

    REST API について詳しくは、{{ site.data.keys.mf_server }} 管理サービスの REST API を参照してください。
     * **mfpadm** を使用してアプリケーション記述子をダウンロードします。

       **mfpadm** プログラムは、{{ site.data.keys.mf_server }} インストーラーを実行するとインストールされます。**product\_install\_dir/shortcuts/** ディレクトリーから開始します。ここで、**product\_install\_dir** は {{ site.data.keys.mf_server }} のインストール・ディレクトリーを示しています。
    
       以下の例では、 **mfpadm** コマンドが必要とするパスワード・ファイルを作成します。次にアプリケーション ID が **my.test.application**、プラットフォームが **ios**、およびそのバージョンが **0.0.1** のアプリケーションのアプリケーション記述子をダウンロードします。開発中、指定された URL は {{ site.data.keys.mf_server }} の HTTPS URL です。
    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       サーバ―構成に応じて、次のコマンド・ラインのエレメントを変更します。
        * **9443** は、開発での {{ site.data.keys.mf_server }} のデフォルトの HTTPS ポートです。
        * **mfpadmin** は、管理サービスのデフォルトのコンテキスト・ルートです。 
        * --secure false は、サーバーの SSL 証明書が自己署名された場合でも、あるいは URL で使用されるサーバーのホスト名とは異なるホスト名のために作成された場合でも、受け入れられることを示しています。

       **mfpadm** プログラムについて詳しくは、[コマンド・ラインを使用した {{ site.data.keys.product_adj }} アプリケーションの管理](../using-cli)を参照してください。
    
3. アプリケーション記述子をアプリケーションを登録する新規サーバーにアップロードするか、その構成を更新します。
REST API または **mfpadm** を使用してアップロードすることができます。
   * REST API を使用してアプリケーション記述子をアップロードするには、 [ アプリケーション (POST) ](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST API を使用します。
    
     以下の URL はアプリケーション記述子をランタイム mfp にアップロードします。POST 要求を送信します。ペイロードは JSON アプリケーション記述子です。この例の呼び出しは、ローカル・コンピューターで実行され、かつ HTTP ポートを 9081 に設定した構成のサーバーに対して行われます。
    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     例えば、curl のようなツールでそのような URL を使用できます。
    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * mfpadm を使用してアプリケーション記述子をアップロードします。

     以下の例では、mfpadm コマンドが必要とするパスワード・ファイルを作成します。次にアプリケーション ID が my.test.application、プラットフォームが ios、およびそのバージョンが 0.0.1 のアプリケーションのアプリケーション記述子をアップロードします。指定される URL は、ローカル・コンピューター上で実行されるサーバーの HTTPS URL ですが、9444 に設定された HTTPS ポートで構成され、mfp という名前のランタイム用の HTTPS URL です。

     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### REST API を使用したサーバー・サイド成果物の転送
{: #transferring-server-side-artifacts-by-using-the-rest-api }
使用者の役割にかかわらず、{{ site.data.keys.mf_server }} 管理サービスを利用してアプリケーション、アダプター、およびリソースをエクスポートし、バックアップしたり再使用したりすることができます。また管理者またはデプロイヤーとして、エクスポート・アーカイブを異なるサーバーにデプロイすることもできます。アプリケーション・コードへのアクセスは不要ですが、クライアント・アプリケーションはターゲット・サーバーに対して作成されなければなりません。

#### 始める前に
{: #before-you-begin-2 }
ターゲット・サーバー用にクライアント・アプリケーションをビルドします。詳しくは、[テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)を参照してください。

エクスポート API は選択された成果物をランタイム用に .zip アーカイブとして取得します。デプロイメント API を使用してアーカイブされたコンテンツを再使用します。

> **重要:** ユース・ケースをよく考慮してください。  
>  
> * エクスポート・ファイルには、アプリケーション認証データが含まれます。そのデータは、モバイル・アプリケーションのビルドに固有です。モバイル・アプリケーションには、サーバーの URL とそのランタイム名が含まれます。そのため、別のサーバーや別のランタイムを使用する場合は、アプリケーションを再ビルドする必要があります。エクスポートされたアプリケーション・ファイルのみを転送しても機能しません。
> * 一部の成果物は、サーバーによって異なる可能性があります。プッシュの資格情報は、開発環境で作業するか実稼働環境で作業するかによって異なります。
> * アプリケーション・ランタイム構成 (アクティブか無効かの状態やログ・プロファイルを含む) は、一部のケースでは転送できますが、すべてのケースで転送できるわけではありません。
> * Web リソースの転送は、例えば新規サーバーを使用するアプリケーションを再ビルドする場合など、一部のケースでは意味がない可能性があります。

* すべてのリソースまたは選択されたリソースのサブセットを 1 つのアダプターまたはすべてのアダプターにエクスポートするには、[アダプター・リソースのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) または [アダプターのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc) の API を使用します。
* (Android または iOS のような) 固有のアプリケーション環境で、すべてのリソース (つまりすべてのバージョンおよびその環境で対象となるバージョンのすべてのリソース) をエクスポートするには、[アプリケーション環境のエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc) の API を使用します。
* あるアプリケーションの、固有のバージョン (例えば Android アプリケーションのバージョン 1.0 または 2.0) についてすべてのリソースをエクスポートするには、[アプリケーション環境リソースのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc) の API を使用します。
* ランタイム用に固有のアプリケーションまたはすべてのアプリケーションをエクスポートするには、[アプリケーションのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) または [アプリケーション・リソースのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc) の API を使用します。**注:** プッシュ通知の資格情報はアプリケーション・リソース間ではエクスポートされません。
* アダプターのコンテンツ、記述子、ライセンス構成、コンテンツ、ユーザー構成、鍵ストア、およびアプリケーションの Web リソースをエクスポートするには、[リソースのエクスポート (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-) の API を使用します。
* ランタイム用にすべてのまたは選択されたリソースをエクスポートするには、[ランタイム・リソースのエクスポート (GET) ](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) の API を使用します。例えば、この汎用の curl コマンドを使ってすべてのリソースを .zip ファイルとして取得できます。

  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* アダプター、アプリケーション、ライセンス構成、鍵ストア、Web リソースなどの、Web アプリケーション・リソースを含むアーカイブをデプロイするには、[デプロイ (POST) ](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc) の API を使用します。例えば、この curl コマンドを使って、成果物を含む既存の .zip ファイルをデプロイすることができます。

  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* アプリケーション認証データをデプロイするには、[アプリケーション認証データのデプロイ (POST) (Deploy Application Authenticity Data (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) の API を使用します。
* アプリケーションの Web リソースをデプロイするには、[Web リソースのデプロイ (POST) (Deploy a web resource (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc) の API を使用します。

同じランタイムにエクスポート・アーカイブをデプロイする場合、アプリケーションまたはバージョンは必ずしもエクスポートされた状態で復元されるわけではありません。つまり、再デプロイは、後続の変更を削除しません。むしろ一部のアプリケーション・リソースが、エクスポート時と再デプロイの間に変更される場合は、エクスポート・アーカイブに含まれるリソースのみ、元の状態で再デプロイされます。例えば、認証性データなしでアプリケーションをエクスポートしてから認証性データをアップロードし、その後に初期アーカイブをインポートするとします。この場合、認証性データは消去されません。

### {{ site.data.keys.mf_console }} からのアプリケーションとアダプターのエクスポートとインポート
{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
コンソールから、特定の条件でアプリケーションまたはそのバージョンのいずれかをエクスポートし、後から同一サーバー上の異なるランタイムまたは異なるサーバー上にインポートすることができます。また、アダプターのエクスポートと再インポートも可能です。この機能は再使用またはバックアップの目的で使用してください。

**mfpadmin** 管理者ロールおよび **mfpdeployer** デプロイヤー・ロールが付与されている場合、アプリケーションの 1 つのバージョンまたはすべてのバージョンのエクスポートが許可されます。アプリケーションまたはバージョンは、 .zip 圧縮ファイルとしてエクスポートされ、アプリケーション ID、記述子、 認証性データ、および Web リソースを保存します。後からアーカイブをインポートして、そのアプリケーションまたはバージョンを同じサーバーまたは別のサーバー上にある別のランタイムに再デプロイすることができます。

> **重要:** ユース・ケースをよく考慮してください。  
> 
> * エクスポート・ファイルには、アプリケーション認証データが含まれます。そのデータは、モバイル・アプリケーションのビルドに固有です。モバイル・アプリケーションには、サーバーの URL とそのランタイム名が含まれます。そのため、別のサーバーや別のランタイムを使用する場合は、アプリケーションを再ビルドする必要があります。エクスポートされたアプリケーション・ファイルのみを転送しても機能しません。
> * 一部の成果物は、サーバーによって異なる可能性があります。プッシュの資格情報は、開発環境で作業するか実稼働環境で作業するかによって異なります。
> * アプリケーション・ランタイム構成 (アクティブか無効かの状態やログ・プロファイルを含む) は、一部のケースでは転送できますが、すべてのケースで転送できるわけではありません。
> * Web リソースの転送は、例えば新規サーバーを使用するアプリケーションを再ビルドする場合など、一部のケースでは意味がない可能性があります。

REST API または mfpadm ツールを使用して、アプリケーション記述子を転送することもできます。詳しくは、[管理サービスを使用したアプリケーション構成の転送](#transferring-an-application-configuration-with-the-administration-service)を参照してください。

1. ナビゲーション・サイドバーから、アプリケーション、アプリケーション・バージョン、またはアダプターを選択します。
2. **「アクション」 → 「アプリケーションのエクスポート」**または**「バージョンのエクスポート」**または**「アダプターのエクスポート」**を選択します。

    エクスポートされたリソースをカプセル化する .zip アーカイブ・ファイルを保存するようにプロンプトが出されます。ダイアログ・ボックスの外観はご使用のブラウザーによって異なり、ターゲット・フォルダーはご使用のブラウザー設定によって異なります。

3. アーカイブ・ファイルを保存します。

    アーカイブ・ファイル名には、例えば **export_applications_com.sample.zip** のように、アプリケーション名とバージョン、またはアダプターを含んでいます。

4. 既存のエクスポート・アーカイブを再使用するには、**「アクション」 → 「アプリケーションのインポート」**または**「バージョンのインポート」**を選択し、アーカイブを参照して**「デプロイ」**をクリックします。

メイン・コンソール・フレームは、インポートされたアプリケーションまたはアダプターの詳細を表示します。

同じランタイムにインポートする場合、アプリケーションまたはバージョンは必ずしもエクスポートされた状態で復元されるわけではありません。つまり、インポート時の再デプロイは、後続の変更を削除しません。むしろ一部のアプリケーション・リソースが、エクスポート時とインポート時の再デプロイで変更される場合、エクスポート・アーカイブに含まれるリソースのみ、元の状態で再デプロイされます。例えば、認証性データなしでアプリケーションをエクスポートしてから認証性データをアップロードし、その後に初期アーカイブをインポートするとします。この場合、認証性データは消去されません。

## 実動での {{ site.data.keys.product_adj }} アプリケーションの更新
{: #updating-mobilefirst-apps-in-production }
Application Center またはアプリケーション・ストアで、既に実動の {{ site.data.keys.product_adj }} アプリケーションをアップグレードする際の一般ガイドラインが存在します。

アプリケーションをアップグレードする場合、旧バージョンが機能する状態のままで新規アプリケーション・バージョンをデプロイすることも、新規アプリケーション・バージョンをデプロイして旧バー ジョンをブロックすることもできます。Apache Cordova を使用して開発されたアプリケーションの場合、Web リソースのみを更新することを考慮することもできます。

### 新規アプリケーション・バージョンのデプロイ、旧バージョンの動作の保持
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
新機能を導入する際、またはネイティブ・コードを変更する際に使用する最も一般的なアップグレード・パスは、アプリケーションの新規バージョンのリリースです。以下の手順を検討してください。

1. アプリケーション・バージョン番号をインクリメントします。
2. アプリケーションをビルドし、テストします。詳しくは、[テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)を参照してください。
3. アプリケーションを {{ site.data.keys.mf_server }} に登録し、構成します。
4. 新規 .apk、.ipa、.appx、または .xap ファイルをそれぞれのアプリケーション・ストアに送信します。
5. レビューと承認、およびアプリケーションが使用可能になるのを待ちます。
6. オプション - 旧バージョンのユーザーに通知メッセージを送信し、新規バージョンを告知します。[管理者メッセージの表示](../using-console/#displaying-an-administrator-message)および[複数言語での管理者メッセージの定義](../using-console/#defining-administrator-messages-in-multiple-languages)を参照してください。


### 新規アプリケーション・バージョンのデプロイ、旧バージョンのブロック
{: #deploying-a-new-app-version-and-blocking-the-old-version }
このアップグレード・パスは、ユーザーに新規バージョンへのアップグレードを強制し、旧バージョンへのアクセスをブロックする場合に使用します。以下の手順を検討してください。

1. オプション - 旧バージョンのユーザーに通知メッセージを送信し、数日での必須の更新を告知します。[管理者メッセージの表示](../using-console/#displaying-an-administrator-message)および[複数言語での管理者メッセージの定義](../using-console/#defining-administrator-messages-in-multiple-languages)を参照してください。
2. アプリケーション・バージョン番号をインクリメントします。
3. アプリケーションをビルドし、テストします。詳しくは、[テスト環境または実稼働環境用のアプリケーションのビルド](#building-an-application-for-a-test-or-production-environment)を参照してください。
4. アプリケーションを {{ site.data.keys.mf_server }} に登録し、構成します。
5. 新規 .apk、.ipa、.appx、または .xap ファイルをそれぞれのアプリケーション・ストアに送信します。
6. レビューと承認、およびアプリケーションが使用可能になるのを待ちます。
7. リンクを新規アプリケーション・バージョンにコピーします。
8. {{ site.data.keys.mf_console }} でアプリケーションの旧バージョンをブロックし、メッセージと新規バージョンへのリンクを提供します。[保護リソースへのアプリケーション・アクセスのリモート側での無効化](../using-console/#remotely-disabling-application-access-to-protected-resources)を参照してください。

> **注:** 旧アプリケーションを無効にした場合、旧アプリケーションは {{ site.data.keys.mf_server }} と通信できなくなります。アプリケーションの開始時にサーバーへの接続を強制しない限り、ユーザーは引き続き、アプリケーションを開始してオフラインで作業できます。

### 直接更新 (ネイティブ・コードの変更なし)
{: #direct-update-no-native-code-changes }
直接更新は、実動アプリケーションに迅速なフィックスをデプロイするために使用する、必須のアップグレード・メカニズムです。バージョンを変更せずにアプリケーションを {{ site.data.keys.mf_server }} に再デプロイすると、{{ site.data.keys.mf_server }} は、ユーザーがサーバーに接続したときに、更新された Web リソースをデバイスに直接的にプッシュします。更新されたネイティブ・コードはプッシュされません。直接更新を考慮する際に留意する必要がある事項は、以下のとおりです。

1. 直接更新はアプリケーション・バージョンを更新しません。アプリケーションは同じバージョンのままですが、異なる Web リソース・セットを使用するようになります。バージョン番号が変更されていないため、正しくない目的で使用すると混乱が生じる可能性があります。
2. また、直接更新は厳密には新規リリースではないため、アプリケーション・ストアのレビュー・プロセスを受けません。レビューをバイパスしてまったく新しいバージョンのアプリケーションをデプロイすることはベンダーにとって望ましいことではないため、これを乱用すべきではありません。各ストアの使用条件を読んで、それに従うのは、ユーザーの責任です。直接更新の最適な使用は、数日待つことができない緊急の問題を修正する場合です。
3. 直接更新はセキュリティー・メカニズムと見なされるため、オプションではなく必須です。直接更新を開始した場合、すべてのユーザーはそれを使用できるようにアプリケーションを更新する必要があります。
4. 最初のデプロイメントで使用したバージョンとは異なるバージョンの {{ site.data.keys.product }} を使用してアプリケーションをコンパイル (ビルド) すると、直接更新は機能しません。

> **注:** iOS アプリケーションのサブミット/検証を保管するための Test Flight または iTunes Connect を使用して作成されたアーカイブ/IPA ファイルは、ランタイムのクラッシュ/失敗を発生させる可能性があります。詳しくは、ブログ [Preparing iOS apps for App Store submission を {{ site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) でお読みください。
