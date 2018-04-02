---
layout: tutorial
title: JavaScript HTTP アダプターでの SSL の使用
breadcrumb_title: Using SSL
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
バックエンド・サービスに接続するために、単純認証および相互認証を使用して、HTTP アダプターで SSL を使用することができます。  
SSL はトランスポート・レベル・セキュリティーを表しており、それは基本認証とは独立しています。 基本認証は、HTTP と HTTPS のいずれを使用しても実行できます。

1. adapter.xml ファイルで、HTTP アダプターの URL プロトコルを <b>https</b> に設定します。
2. SSL 証明書を {{ site.data.keys.mf_server }} 鍵ストアに保管します。 [{{ site.data.keys.mf_server }} 鍵ストアの構成](../../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。

### 相互認証と SSL
{:# ssl-with-mutual-authentication }

相互認証と共に SSL を使用する場合、以下のステップも実行する必要があります。

1. HTTP アダプター用に独自の秘密鍵を生成するか、信頼できる機関により提供された秘密鍵を使用します。
2. 独自の秘密鍵を生成した場合、生成された秘密鍵の公開証明書をエクスポートし、それをバックエンド・トラストストアにインポートします。
3. **adapter.xml** ファイルの `connectionPolicy` エレメントで秘密鍵の別名およびパスワードを定義します。 
