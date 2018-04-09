---
layout: tutorial
title: 機密クライアント
relevantTo: [android,ios,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
モバイル・アプリケーションは、{{ site.data.keys.product_adj }} クライアント SDK を使用して、保護リソースへのアクセスを要求できます。  
モバイル・アプリケーション以外のその他のエンティティーも同様の要求を実行できます。 そのようなエンティティーは、**機密クライアント**と見なされます。

機密クライアントとは、認証資格情報の機密性を維持できるクライアントです。 {{ site.data.keys.product_adj }} 許可サーバーを使用して、OAuth 仕様に従って、保護リソースへのアクセス権限を機密クライアントに付与できます。 この機能によって、保護リソースを要求したり、いずれかの {{ site.data.keys.product }} **REST API** (**プッシュ通知** 用の REST API など) を使用したりする必要が生じる可能性のある、モバイルでないクライアント (パフォーマンス・テスト・アプリケーションなど) やそれ以外の種類のバックエンドに対して、リソースへのアクセスを認可できるようになります。

まず、{{ site.data.keys.mf_server }} で機密クライアントを登録することから開始します。 登録の一環として、ID と秘密で構成される、機密クライアントの資格情報を提供します。 また、クライアントの許可されるスコープを設定します。これにより、当該クライアントに許可できるスコープが決まります。 登録済み機密クライアントが許可サーバーに対してアクセス・トークンを要求すると、サーバーは、登録済み資格情報を使用してクライアントを認証し、要求されたスコープがクライアントの許可されるスコープに一致しているかを検査します。

登録済み機密クライアントは、{{ site.data.keys.mf_server }} へのすべての要求で使用できるトークンを獲得できます。 このフローは、OAuth 仕様の[クライアント資格情報フロー](https://tools.ietf.org/html/rfc6749#section-1.3.4)に基づいています。 機密クライアントのアクセス・トークンの有効期間は 1 時間である点に注意してください。 1 時間を超えるタスクに機密クライアントを使用する場合、新しいトークン要求を送信して 1 時間ごとにトークンを更新してください。

## 機密クライアントの登録
{: #registering-the-confidential-client }
{{ site.data.keys.mf_console }} のナビゲーション・サイドバーで、**「ランタイム設定」**→**「機密クライアント」**をクリックします。 **「新規」**をクリックして、新規エントリーを追加します。  
以下の情報を指定する必要があります。

- **表示名**: 機密クライアントを指すために使用するオプションの表示名。 デフォルトの表示名は、ID パラメーターの値です。 例えば、**Back-end Node server** です。
- **ID**: 機密クライアントの固有 ID (「ユーザー名」に相当します)。
  ID には ASCII 文字のみを使用できます。
- **秘密鍵**: 機密クライアントからのアクセスを許可するための秘密のパスフレーズ (API キーに相当します)。
  秘密鍵には ASCII 文字のみを使用できます。
- **許可されるスコープ**: 上記の ID と秘密鍵の組み合わせを使用する機密クライアントは、ここで定義されるスコープが自動的に認可されます。 スコープについて詳しくは、[スコープ](../#scopes)を参照してください。
    - 許可されるスコープのエレメントには、特殊なアスタリスク・ワイルドカード文字 (`*`) を含めることもできます。これは、ゼロ文字以上の文字列を示します。 例えば、スコープ・エレメントが `send*` の場合、「sendMessage」など、「send」で始まる任意のスコープ・エレメントが含まれているスコープへのアクセス権限を機密クライアントに付与できます。 アスタリスク・ワイルドカードは、スコープ・エレメントの任意の位置に配置でき、また複数回使用できます。 
    - 単一のアスタリスク文字 (*) で構成される「許可されるスコープ」パラメーターは、任意のスコープのトークンを機密クライアントに付与できることを示します。

**スコープの例:**

- [外部リソースの保護](../protecting-external-resources)には、スコープ `authorization.introspect` を使用します。
- REST API 経由での[プッシュ通知の送信](../../notifications/sending-notifications)には、スペースで区切った `messages.write` スコープ・エレメントと `push.application.<applicationId>` スコープ・エレメントを使用します。
- アダプターは、カスタム・スコープ・エレメント (`accessRestricted` など) で保護できます。
- スコープ `*` は、包括的なスコープであり、要求されたあらゆるスコープのアクセスを認可します。

<img class="gifplayer" alt="機密クライアントの構成" src="push-confidential-client.png"/>

## 事前定義機密クライアント
{: #predefined-confidential-clients }
{{ site.data.keys.mf_server }} には、付属の機密クライアントがいくつかあります。

### テスト
{: #test }
`test` クライアントは、開発モードでのみ使用可能です。 これを使用すると、リソースを簡単にテストできます。

- **ID**: `test`
- **秘密鍵**: `test`
- **許可されるスコープ**: `*` (任意のスコープ)

### admin
{: #admin }
`admin` クライアントは、{{ site.data.keys.product }} 管理サービスによって内部で使用されます。

### push
{: #push }
`push` クライアントは、{{ site.data.keys.product }} プッシュ・サービスによって内部で使用されます。

## アクセス・トークンの取得
{: #obtaining-an-access-token }
トークンは、{{ site.data.keys.mf_server }} **トークン・エンドポイント**から取得できます。  

**テストのために**、以下の説明に従って Postman を使用できます。  
現実の状況では、任意のテクノロジーを使用して、バックエンド・ロジックに Postman を実装します。

1.  **http(s)://[ipaddress-or-hostname]: [port]/[runtime]/api/az/v1/token** への **POST** 要求を行います。  
    例えば、`http://localhost:9080/mfp/api/az/v1/token` です。
    - 開発環境では、{{ site.data.keys.mf_server }} は既存の `mfp` ランタイムを使用します。  
    - 実稼働環境では、ランタイム値をご使用のランタイム名で置き換えてください。

2.  コンテンツ・タイプに `application/x-www-form-urlencoded` を指定した要求を設定します。  
3.  以下の 2 つのフォーム・パラメーターを設定します。
    - `grant_type` - 値を `client_credentials` に設定します。
    - `scope` - 値をリソースの保護スコープに設定します。 リソースに保護スコープが割り当てられていない場合は、このパラメーターを省略して、デフォルトのスコープ (`RegisteredClient`) を適用します。 詳しくは、[スコープ](../../authentication-and-security/#scopes)を参照してください。

       ![postman 構成のイメージ](confidential-client-steps-1-3.png)

4.  要求を認証するには、[基本認証](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side)を使用します。 機密クライアントの **ID** と**秘密鍵**を使用します。

    ![postman 構成のイメージ](confidential-client-step-4.png)

    Postman の外部で **test** 機密クライアントを使用する場合は、**HTTP ヘッダー**を `Authorization: Basic dGVzdDp0ZXN0` (**base64** を使用して `test:test` をエンコード) に設定します。

この要求の応答には `JSON` オブジェクトが含まれ、そこに**アクセス・トークン**とトークンの有効期限 (1 時間) が組み込まれています。

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp ...",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "sendMessage accessRestricted"
}
```

![機密クライアントの作成](confidential-client-access-token.png)

## アクセス・トークンの使用
{: #using-the-access-token }
これ以降、**HTTP ヘッダー** `Authorization: Bearer eyJhbGciOiJSUzI1NiIsImp ...` を追加し、アクセス・トークンを前述した JSON オブジェクトから抽出したトークンに置き換えることで、目的のリソースに対する要求を行うことができます。

## 可能性のある応答
{: #possible-responses }
リソースによって生成される通常応答に加えて、{{ site.data.keys.mf_server }} によって生成されるいくつかの応答にも注意してください。

### Bearer
{: #bearer }
HTTP **401** 応答状況と HTTP ヘッダー `WWW-Authenticate : Bearer` は、元の要求の `Authorization` ヘッダーでトークンが見つからなかったことを意味します。

### invalid_token
{: #invalid-token }
HTTP **401** 応答状況と HTTP ヘッダー `WWW-Authenticate: Bearer error="invalid_token"` は、送信されたトークンが**無効**または**有効期限切れ**であったことを意味します。

### insufficient_scope
{: #insufficient-scope }
HTTP **403** 応答状況と HTTP ヘッダー `WWW-Authenticate : Bearer error="insufficient_scope", scope="RegisteredClient scopeA scopeB"` は、元の要求内で見つかったトークンが、このリソースで必要なスコープと一致しなかったことを意味します。 このヘッダーには、予期したスコープも含まれています。

要求の発行時に、リソースで必要なスコープが不明な場合、`insufficient_scope` を使用して必要なスコープを判別します。 例えば、スコープを指定せずにトークンを要求して、リソースに対する要求を行います。 その後、403 応答から必要なスコープを抽出し、このスコープの新しいトークンを要求できます。

