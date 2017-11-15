---
layout: tutorial
title: MobileFirst サーバーの保護
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下に示すいくつかの方法に従うことで、{{ site.data.keys.mf_server }} インスタンスを保護できます。

#### ジャンプ先
{: #jump-to }
* [App Transport Security (ATS) の構成](#configuring-app-transport-security-ats)
* [コンテナーの LDAP 構成](#ldap-configuration-for-containers)

## App Transport Security (ATS) の構成
{: #configuring-app-transport-security-ats }
ATS の構成は、iOS 以外の他のモバイル・オペレーティング・システムから接続するアプリケーションには影響を与えません。他のモバイル・オペレーティング・システムでは、サーバーが ATS レベルのセキュリティーに基づいて通信することを義務付けていませんが、ATS が構成されたサーバーとの通信も可能です。サーバーを構成する前に、生成された証明書を準備してください。以下の手順では、鍵ストア・ファイル **ssl_cert.p12** に個人証明書があり、**ca.crt** は署名証明書であるものと想定しています。

1. **ssl_cert.p12** ファイルを **mfpf-server-libertyapp/usr/security/** フォルダーにコピーします。
2. **mfpf-server-libertyapp/usr/config/keystore.xml** ファイルと **appcenter/usr/config/keystore.xml** (AppCenter 用) ファイルを、以下の構成例に似たものに変更します。

   ```xml
   <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
   </server>
   ```
    - サーバーが SSL 通信を処理できるようにするために、フィーチャー管理機能に **ssl-1.0** がフィーチャーとして追加されています。
    - サーバーが Transport Layer Security (TLS) バージョン 1.2 プロトコルのみに基づいて通信することを義務付けるために、**sslProtocol="TLSv1.2"** が ssl タグに追加されています。複数のプロトコルを追加できます。例えば、**sslProtocol="TLSv1+TLSv1.1+TLSv1.2"** を追加すると、サーバーは TLS V1、V1.1、および V1.2 に基づいて通信できます。(iOS 9 アプリケーションでは、TLS V1.2 が必要です。)
    - **enabledCiphers="TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384"** が ssl タグに追加され、サーバーがその暗号のみを使用して通信を実行するようにします。
    - **keyStore** タグは、上記の要件のとおりに作成された新規の証明書を使用するようにサーバーに伝えます。

以下の特定の暗号では、Java Cryptography Extension (JCE) ポリシーの設定と、追加の JVM オプションが必要です。

* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256_GCM\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384

ポリシー・ファイルは、既に Liberty for Java ランタイムにインストールされていますので、パッケージに再度追加する必要はありません。次の JVM オプションを **mfpf-server-libertyapp/usr/env/jvm.options** ファイルに追加するだけです。 `Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`.

開発ステージでの目的のためにのみ、以下のプロパティーを info.plist ファイルに追加して、ATS を無効にすることができます。

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

## {{ site.data.keys.product_full }} のセキュリティー構成
{: #security-configuration-for-ibm-mobilefirst-foundation }
IBM MobileFirst Foundation インスタンスのセキュリティー構成には、パスワードの暗号化、アプリケーション認証性検査の有効化、およびコンソールへのアクセスの保護を組み込む必要があります。

### パスワードの暗号化
{: #encrypting-passwords }
{{ site.data.keys.mf_server }} ユーザーのパスワードを、暗号化された形式で保管します。Liberty プロファイル内で使用可能な securityUtility コマンドを使用すると、XOR 暗号化または AES 暗号化のいずれかを使用してパスワードをエンコードすることができます。その後、暗号化されたパスワードを /usr/env/server.env ファイルにコピーできます。指示については、「{{ site.data.keys.mf_server }} に構成されたユーザー役割のパスワードの暗号化」を参照してください。

### アプリケーション認証性検査
{: #application-authenticity-validation }
無許可のモバイル・アプリケーションが {{ site.data.keys.mf_server }} にアクセスしないようにするために、[アプリケーション認証性セキュリティー検査を有効にします](../../../authentication-and-security/application-authenticity)。


### バックエンドへの接続の保護
{: #securing-a-connection-to-the-back-end }
コンテナーとオンプレミスのバックエンド・システムとの間の接続を保護する必要がある場合は、Bluemix セキュア・ゲートウェイ・サービスを使用できます。構成の詳細は、以下の記事に記載されています。 Connecting Securely to On-Premise Backends from MobileFirst on IBM Bluemix containers。

#### {{ site.data.keys.mf_server }} に構成されたユーザー役割のパスワードの暗号化
{: #encrypting-passwords-for-user-roles-configured-in-mobilefirst-server }
{{ site.data.keys.mf_server }} 用に構成されたユーザー役割のパスワードを暗号化することができます。  
パスワードは、**package_root/mfpf-server-liberty-app/usr/env** フォルダーの **server.env** ファイルに構成されます。パスワードは、暗号化された形式で保管する必要があります。

1. Liberty プロファイル内の `securityUtility` コマンドを使用して、パスワードをエンコードすることができます。XOR 暗号化または AES 暗号化のいずれかを選択して、パスワードをエンコードします。
2. 暗号化されたパスワードを **server.env** ファイルにコピーします。例: `MFPF_ADMIN_PASSWORD={xor}PjsyNjE=`
3. AES 暗号化を使用しており、デフォルトの鍵の代わりに独自の暗号鍵を使用した場合、その暗号鍵を含む構成ファイルを作成して、**usr/config** ディレクトリーに追加する必要があります。Liberty サーバーは、実行時にこのファイルにアクセスして、パスワードを暗号化解除します。構成ファイルは、.xml ファイル拡張子を持ち、以下のフォーマットに似たものでなければなりません。

```bash
<?xml version="1.0" encoding="UTF-8" ?> 
<server>
    <variable name="wlp.password.encryption.key" value="yourKey" />
</server>
```

#### コンテナーで実行中のコンソールへのアクセスの制限
{: #restricting-access-to-the-consoles-running-on-containers }
トラスト・アソシエーション・インターセプター (TAI) を作成してデプロイすることで、コンソールへの要求をインターセプトすることにより、実稼働環境内の MobileFirst Operations Console および MobileFirst Analytics コンソールへのアクセスを制限できます。

TAI により、要求をコンソールに転送するか、あるいは承認が必要かを決定するユーザー固有のフィルタリング・ロジックを実装できます。このフィルター方式では、必要に応じて独自の認証メカニズムを柔軟に追加できます。

[Developing a custom TAI for the Liberty profile (Liberty プロファイル用のカスタム TAI の開発)](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dev_custom_tai.html?view=embed) も参照してください。

1. MobileFirst Operations Console へのアクセスを制御するためのセキュリティー・メカニズムを実装したカスタム TAI を作成します。以下のカスタム TAI 例では、着信要求の IP アドレスを使用して、MobileFirst Operations Console へのアクセスを提供するかどうかを検証しています。

   ```java
   package com.ibm.mfpconsole.interceptor;
   import java.util.Properties;

   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;

   import com.ibm.websphere.security.WebTrustAssociationException;
   import com.ibm.websphere.security.WebTrustAssociationFailedException;
   import com.ibm.wsspi.security.tai.TAIResult;
   import com.ibm.wsspi.security.tai.TrustAssociationInterceptor;

   public class MFPConsoleTAI implements TrustAssociationInterceptor {
String allowedIP =null;

       public MFPConsoleTAI() {
          super();
       }

   /*
    * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#isTargetInterceptor
    * (javax.servlet.http.HttpServletRequest)
    */
    public boolean isTargetInterceptor(HttpServletRequest req)
                  throws WebTrustAssociationException {
      //Add logic to determine whether to intercept this request
	
	   boolean interceptMFPConsoleRequest = false;
	   String requestURI = req.getRequestURI();
	
	   if(requestURI.contains("mfpconsole")) {
		   interceptMFPConsoleRequest = true;
    	   }

    	   return interceptMFPConsoleRequest;
       }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#negotiateValidateandEstablishTrust
     * (javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
     */

    public TAIResult negotiateValidateandEstablishTrust(HttpServletRequest request,
                    HttpServletResponse resp) throws WebTrustAssociationFailedException {
        // Add logic to authenticate a request and return a TAI result.
        String tai_user = "MFPConsoleCheck";

            if(allowedIP != null) {
        	
        	String ipAddress = request.getHeader("X-FORWARDED-FOR");
            	if (ipAddress == null) {
            	  ipAddress = request.getRemoteAddr();  
            	}

            	if(checkIPMatch(ipAddress, allowedIP)) {
            		TAIResult.create(HttpServletResponse.SC_OK, tai_user);
        	}
        	else {
        		TAIResult.create(HttpServletResponse.SC_FORBIDDEN, tai_user);
            	}

            }
            return TAIResult.create(HttpServletResponse.SC_OK, tai_user);
        }

       private static boolean checkIPMatch(String ipAddress, String pattern) {

    	   if (pattern.equals("*.*.*.*") || pattern.equals("*"))
		      return true;

	   String[] mask = pattern.split("\\.");
	   String[] ip_address = ipAddress.split("\\.");

	   for (int i = 0; i < mask.length; i++)
	   {
		   if (mask[i].equals("*") || mask[i].equals(ip_address[i]))
		      continue;
		   else
		      return false;
		}
		return true;
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#initialize(java.util.Properties)
     */

    public int initialize(Properties properties)
                    throws WebTrustAssociationFailedException {
    	
    	if(properties != null) {
    		if(properties.containsKey("allowedIPs")) {
    			allowedIP = properties.getProperty("allowedIPs");
    		}
    	}
        return 0;
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getVersion()
     */

    public String getVersion() {
        return "1.0";
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getType()
     */
        public String getType() {
            return this.getClass().getName();
        }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#cleanup()
     */

    public void cleanup()
        {}
   }
   ```

2. カスタム TAI 実装を .jar ファイルにエクスポートして、該当する **env** フォルダー (**mfpf-server-libertyapp/usr/env**) に入れます。
3. TAI インターセプターの詳細を含む XML 構成ファイルを作成し (ステップ 1 で提供された TAI 構成のコード例を参照)、.xml ファイルを該当するフォルダー (**mfpf-server-libertyapp/usr/config**) に追加します。.xml ファイルは次の例に似たものになります。**ヒント:** 実際の実装を反映するようにクラス名とプロパティーを更新してください。

   ```xml
   <?xml version="1.0" encoding="UTF-8" ?> 
<server description="new server">
        <featureManager>
            <feature>appSecurity-2.0</feature>
        </featureManager>

        <trustAssociation id="MFPConsoleTAI" invokeForUnprotectedURI="true"
                          failOverToAppAuthType="false">
            <interceptors id="MFPConsoleTAI" enabled="true"  
                          className="com.ibm.mfpconsole.interceptor.MFPConsoleTAI"
                          invokeBeforeSSO="true" invokeAfterSSO="false" libraryRef="MFPConsoleTAI">
                <properties allowedIPs="9.182.149.*"/>
            </interceptors>
        </trustAssociation>

        <library id="MFPConsoleTAI">
            <fileset dir="${server.config.dir}" includes="MFPConsoleTAI.jar"/>
        </library>
   </server>
   ```
4. サーバーを再デプロイします。これで、構成された TAI セキュリティー・メカニズムを満たしている場合にのみ、MobileFirst Operations Console にアクセス可能になりました。

## コンテナーの LDAP 構成
{: #ldap-configuration-for-containers }
外部 LDAP リポジトリーにセキュアに接続するように IBM MobileFirst Foundation を構成できます。

以下の目的のために、外部 LDAP レジストリーを使用できます。

* 外部 LDAP レジストリーを使用して MobileFirst 管理セキュリティーを構成する。
* 外部 LDAP レジストリーと連動するように MobileFirst モバイル・アプリケーションを構成する。

### LDAP を使用した管理セキュリティーの構成
{: #configuring-administration-security-with-ldap }
外部 LDAP レジストリーを使用して MobileFirst 管理セキュリティーを構成します。  
構成プロセスには、以下のステップが含まれます。

* LDAP リポジトリーのセットアップと構成
* レジストリー・ファイル (registry.xml) の変更
* ローカル LDAP リポジトリーおよびコンテナーに接続するためのセキュア・ゲートウェイの構成。(このステップを実行するためには、Bluemix 上に既存のアプリが必要です。)

#### LDAP リポジトリー
{: #ldap-repository }
LDAP リポジトリーにユーザーとグループを作成します。グループの場合、許可は、ユーザー・メンバーシップに基づいて適用されます。

#### レジストリー・ファイル
{: #registry-file }
1. **registry.xml** を開き、`basicRegistry` エレメントを見つけます。`basicRegistry` エレメントを、以下のスニペットに似たコードに置き換えます。

   ```xml
   <ldapRegistry
        id="ldap"
        host="1.234.567.8910" port="1234" ignoreCase="true"
        baseDN="dc=worklight,dc=com"
        ldapType="Custom"
        sslEnabled="false"
        bindDN="uid=admin,ou=system"
        bindPassword="secret">
        <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
        groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
        userIdMap="*:uid"
        groupIdMap="*:cn"
        groupMemberIdMap="groupOfNames:member"/>
   </ldapRegistry>
   ```

    項目| 説明
    --- | ---
    `host` および `port` | ローカル LDAP サーバーのホスト名 (IP アドレス) およびポート番号。
    `baseDN` | 特定の組織に関するすべての詳細をキャプチャーする、LDAP 内のドメイン・ネーム (DN)。
    `bindDN="uid=admin,ou=system"	` | LDAP サーバーのバインディング詳細。例えば、Apache Directory Service の場合のデフォルト値は `uid=admin,ou=system` です。
    
    `bindPassword="secret"	`| LDAP サーバーのバインディング・パスワード。例えば、Apache Directory Service の場合のデフォルト値は `secret` です。
    
    `<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="groupOfNames:member"/>	` | 認証および許可でディレクトリー・サービス (Apache など) に照会する際に使用するカスタム・フィルター。

2. `appSecurity-2.0` および `ldapRegistry-3.0` で以下のフィーチャーが有効になっていることを確認します。

   ```xml
   <featureManager>
        <feature>appSecurity-2.0</feature>
        <feature>ldapRegistry-3.0</feature>
   </featureManager>
   ```

   各種 LDAP サーバー・リポジトリーの構成について詳しくは、[WebSphere Application Server Liberty Knowledge Center](http://www-01.ibm.com/support/knowledgecenter/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ldap.html) を参照してください。

#### セキュア・ゲートウェイ
{: #secure-gateway }
LDAP サーバーへのセキュア・ゲートウェイ接続を構成するには、Bluemix 上に Secure Gateway サービスのインスタンスを作成し、LDAP レジストリーの IP 情報を取得する必要があります。このタスクには、ローカル LDAP ホスト名とポート番号が必要です。

1. Bluemix にログオンし、**「カタログ」、「カテゴリー」>「統合」**にナビゲートし、**「Secure Gateway」**をクリックします。
2. 「サービスの追加」でアプリを選択し、**「作成」**をクリックします。これで、サービスがユーザーのアプリにバインドされました。
3. アプリケーションの Bluemix ダッシュボードに移動し、**「Secure Gateway」** サービス・インスタンスをクリックし、**「ゲートウェイの追加」**をクリックします。
4. ゲートウェイを指定し、**「宛先の追加」**をクリックし、ローカル LDAP サーバーの名前、IP アドレス、ポートを入力します。
5. プロンプトに従って接続を完了します。初期化された宛先を表示するには、LDAP ゲートウェイ・サービスの宛先画面にナビゲートします。
6. 必要なホストおよびポートの情報を取得するには、LDAP ゲートウェイ・サービス・インスタンス (Secure Gateway ダッシュボード上にある) の情報アイコンをクリックします。表示される詳細は、ローカル LDAP サーバーの別名です。
7. **「宛先 ID (Destination ID)」**と**「クラウド・ホスト : ポート (Cloud Host : Port)」**の値を取り込みます。registry.xml ファイルに移動し、既存の値を置き換えてこれらの値を追加します。以下に示す、registry.xml ファイル内の更新されたコード・スニペットの例を参照してください。

```xml
<ldapRegistry
    id="ldap"
    host="cap-sg-prd-5.integration.ibmcloud.com" port="15163" ignoreCase="true"
    baseDN="dc=worklight,dc=com"
    ldapType="Custom"
    sslEnabled="false"
    bindDN="uid=admin,ou=system"
    bindPassword="secret">
    <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
    groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
    userIdMap="*:uid"
    groupIdMap="*:cn"
    groupMemberIdMap="groupOfNames:member"/>
</ldapRegistry>
```

### LDAP と連動するためのアプリケーションの構成
{: #configuring-apps-to-work-with-ldap }
外部 LDAP レジストリーと連動するように MobileFirst モバイル・アプリケーションを構成します。  
構成プロセスには、「ローカル LDAP リポジトリーおよびコンテナーに接続するためのセキュア・ゲートウェイの構成」ステップが含まれます。(このステップを実行するためには、Bluemix 上に既存のアプリが必要です。)

LDAP サーバーへのセキュア・ゲートウェイ接続を構成するには、Bluemix 上に Secure Gateway サービスのインスタンスを作成し、LDAP レジストリーの IP 情報を取得する必要があります。このステップには、ローカル LDAP ホスト名とポート番号が必要です。

1. Bluemix にログオンし、**「カタログ」、「カテゴリー」>「統合」**にナビゲートし、**「Secure Gateway」**をクリックします。
2. 「サービスの追加」でアプリを選択し、**「作成」**をクリックします。これで、サービスがユーザーのアプリにバインドされました。
3. アプリケーションの Bluemix ダッシュボードに移動し、**「Secure Gateway」** サービス・インスタンスをクリックし、**「ゲートウェイの追加」**をクリックします。
4. ゲートウェイを指定し、**「宛先の追加」**をクリックし、ローカル LDAP サーバーの名前、IP アドレス、ポートを入力します。
5. プロンプトに従って接続を完了します。初期化された宛先を表示するには、LDAP ゲートウェイ・サービスの宛先画面にナビゲートします。
6. 必要なホストおよびポートの情報を取得するには、LDAP ゲートウェイ・サービス・インスタンス (Secure Gateway ダッシュボード上にある) の情報アイコンをクリックします。表示される詳細は、ローカル LDAP サーバーの別名です。
7. **「宛先 ID (Destination ID)」**と**「クラウド・ホスト : ポート (Cloud Host : Port)」**の値を取り込みます。これらの値を LDAP ログイン・モジュールに対して提供します。

**結果**  
Bluemix 上の MobileFirst アプリケーションとローカル LDAP サーバーの間の通信が確立されます。Bluemix アプリケーションからの認証と許可が、ローカル LDAP サーバーと突き合わせて検証されます。
