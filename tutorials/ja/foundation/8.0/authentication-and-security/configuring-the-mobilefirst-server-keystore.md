---
layout: tutorial
title: MobileFirst Server 鍵ストアの構成
breadcrumb_title: サーバー鍵ストアの構成
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
鍵ストアは、ネットワーク・トランザクションの関与者の妥当性を検証および認証するための、セキュリティー鍵および証明書のリポジトリーです。{{ site.data.keys.mf_server }} 鍵ストアは、{{ site.data.keys.mf_server }} インスタンスの ID を定義し、OAuth トークンおよびダイレクト・アップデート・パッケージにデジタル署名するために使用します。さらに、アダプターが相互 HTTPS (SSL) 認証を使用してバックエンド・サーバーと通信する際も、鍵ストアを使用して {{ site.data.keys.mf_server }} インスタンスの SSL クライアント ID を検証します。

実動レベルのセキュリティーのために、開発から実動への移行時に、管理者は、ユーザー定義の鍵ストアを使用するように {{ site.data.keys.mf_server }} を構成する必要があります。デフォルトの {{ site.data.keys.mf_server }} 鍵ストアは、開発中にのみ使用するためのものです。

### 注
{: #notes }
* 鍵ストアを使用してダイレクト・アップデート・パッケージの認証性を検証するには、鍵ストアで定義された {{ site.data.keys.mf_server }} ID の公開鍵にアプリケーションを静的にバインドします。 [クライアント・サイドでのセキュア・ダイレクト・アップデートの実装](../../application-development/direct-update)を参照してください。
* 実動後の {{ site.data.keys.mf_server }} 鍵ストアの再構成については、慎重な検討が必要です。構成の変更により、以下の影響が考えられます。
    * クライアントが、以前の鍵ストアで署名されたトークンの代わりに、新しい OAuth トークンを取得することが必要になる場合があります。ほとんどの場合、このプロセスはアプリケーションでは認識されません。
    * クライアント・アプリケーションが、新しい鍵ストア構成の {{ site.data.keys.mf_server }} ID に一致しない公開鍵にバインドされている場合、ダイレクト・アップデートは失敗します。 更新を引き続き取得するには、アプリケーションをその新しい公開鍵にバインドし、アプリケーションをリパブリッシュする必要があります。あるいは、アプリケーションがバインドされている公開鍵に一致するように、鍵ストア構成を再度変更します。[クライアント・サイドでのセキュア・ダイレクト・アップデートの実装](../../application-development/direct-update)を参照してください。
    *  相互 SSL 認証について、アダプターで構成されている SSL クライアント ID の別名とパスワードが新しい鍵ストアにない場合、またはそれらが SSL 証明書に一致しない場合、SSL 認証は失敗します。以下の手順のステップ 2 でアダプター構成情報を参照してください。

## セットアップ
{: #setup }
1. {{ site.data.keys.mf_server }} の ID を定義した鍵ペアを含む Java 鍵ストア (JKS) ファイルまたは PKCS 12 鍵ストア・ファイルを別名で作成します。該当の鍵ストア・ファイルが既にある場合は、次のステップにスキップします。

   > **注:** この別名による鍵ペアのアルゴリズムのタイプは、RSA でなければなりません。以下の説明は、**keytool** ユーティリティーを使用する場合に、アルゴリズムのタイプを RSA に設定する方法を示しています。

   鍵ストア・ファイルの作成には、サード・パーティー・ツールを使用できます。例えば、以下のコマンドで Java **keytool** ユーティリティーを実行することで、JKS 鍵ストア・ファイルを生成できます (ここで、`<keystore name>` は鍵ストアの名前、`<alias name>` は選択した別名です)。

   ```bash
   keytool -keystore <keystore name> -genkey -alias <alias name> -keylag RSA
   ```

   以下のサンプル・コマンドでは、`my_alias` という別名で JKS ファイル **my_company.keystore** を生成します。

   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   ユーティリティーによって、鍵ストア・ファイルと別名のパスワードなど、さまざまな入力パラメーターの指定が求められます。

   > **注:** 必ず `-keyalg RSA` オプションを設定して、生成後の鍵アルゴリズムのタイプを、デフォルトの DSA ではなく RSA に設定してください。

   アダプターとバックエンド・サーバーの間の相互 SSL 認証に鍵ストアを使用するには、{{ site.data.keys.product }} SSL クライアント ID の別名も鍵ストアに追加します。これを行うは、{{ site.data.keys.mf_server }} ID の別名で鍵ストア・ファイルを作成する場合と同じ方法を使用できますが、代わりに、SSL クライアント ID の別名とパスワードを指定します。

2. 鍵ストアを使用するように {{ site.data.keys.mf_server }} を構成します。
   次の手順に従って、鍵ストアを使用するように {{ site.data.keys.mf_server }} を構成します。

      * **JavaScript アダプター**
        {{ site.data.keys.mf_console }} ナビゲーション・サイドバーで、**「ランタイム設定」**を選択し、次に**「鍵ストア」**タブを選択します。このタブの手順に従って、ユーザー定義の {{ site.data.keys.mf_server }} 鍵ストアを構成します。このステップでは、鍵ストア・ファイルをアップロードし、そのタイプを指示して、 鍵ストア・パスワード、{{ site.data.keys.mf_server }} ID 別名の名前、および別名パスワードを指定します。
        正常に構成されると、**「状況」**が*「ユーザー定義」*に変わり、それ以外の場合はエラーが表示され、状況は*「デフォルト」*のままになります。
        SSL クライアント ID 別名 (使用された場合) とそのパスワードは、`<connectionPolicy>` エレメントの `<sslCertificateAlias>` サブエレメントおよび `<sslCertificatePassword>` サブエレメント内で、関連アダプターの記述子ファイルに構成されます。[HTTP アダプター connectionPolicy エレメント](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file)を参照してください。

      * **Java アダプター**
        Java アダプターの相互 SSL 認証を構成するには、サーバーの鍵ストアを更新する必要があります。これは、以下の手順に従って行うことができます。

        * 鍵ストア・ファイルを `<ServerInstallation>/mfp-server/usr/servers/mfp/resources/security` にコピーします。

        * `server.xml` ファイル `<ServerInstallation>/mfp-server/usr/servers/mfp/server.xml` を編集します。

        * 適切なファイル名、パスワード、およびタイプを使用して、鍵ストア構成を更新します。
        `<keyStore id=“defaultKeyStore” location=<Keystore name> password=<Keystore password> type=<Keystore type> />`

Bluemix 上の {{ site.data.keys.mf_bm_short}} サービス使用してデプロイする場合は、サーバーをデプロイする前に、**「詳細設定」**の下の鍵ストア・ファイルをアップロードできます。
