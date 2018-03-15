---
layout: tutorial
title: Watson コグニティブ・サービス用のアダプター
breadcrumb_title: Adapters for Watson services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

Watson on IBM Cloud では、現在利用できる最も広範なコグニティブ・テクノロジーにアクセスし、スマートなアプリケーションを迅速かつ安全に構築できます。Watson サービスによって有効にされる機能の中には、評判を理解するためにイメージとビデオを分析する機能や、テキストからキーワードとエンティティーを抽出する機能があります。

コグニティブ・コンピューティングで Watson が実現するのはそれだけではありません。 Natural Language Understanding、Visual Recognition、Discovery で、オペレーションを改革し、業界を変革する能力がある非構造化データから洞察を導き出します。 IBM Cloud 上の Watson コグニティブ・サービスについて詳しくは、[ここ](https://www.ibm.com/watson/developercloud/)を参照してください。

{{ site.data.keys.product }} アダプターを使用して、すべての必要なサーバー・サイド・ロジックを実行し、バックエンド・システムから情報を取得して、クライアント・アプリケーションおよびクラウド・サービスに転送します。 {{ site.data.keys.product }} では、一部の Watson コグニティブ・サービス用のアダプターも提供されるようになりました。

##  Watson サービス用のアダプター
{: #watson-adapter}

[iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) 以降の {{ site.data.keys.product_full }} には、[Conversation](https://www.ibm.com/watson/developercloud/conversation.html)、[Discovery](https://www.ibm.com/watson/developercloud/discovery.html)、および [Natural Language Understanding](https://www.ibm.com/watson/developercloud/natural-language-understanding.html) などの一部の Watson コグニティブ・サービス用にすぐに使用可能なアダプターが用意されています。 これらのアダプターは、Mobile Foundation コンソールの**ダウンロード・センター**からダウンロードできます。

アプリケーションが Watson コグニティブ・サービスに接続できるように、コグニティブ・サービス・アダプターをダウンロードして、このアダプターを {{ site.data.keys.product_adj }} サーバーにデプロイします。 これで、アプリケーションは、Watson サービスを呼び出すためにアダプター API を呼び出すことができるようになります。

アダプターのデプロイ後に、Watson サービスに接続するようにこのアダプターを構成します。 これを行うには、**「アダプター構成 (Adapter Configuration)」**ページに移動して、**「アダプター構成 (Adapter Configuration)」**ページの_**「ユーザー名」**_フィールドと_**「パスワード」**_フィールドに Watson **サービス資格情報**の*ユーザー名* と*パスワード* を指定し、構成を保存します。

アダプターを変更する必要がある場合は、以下の github リポジトリーからアダプターのソース・コードをダウンロードします。<br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU (Natural Language Understanding)**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
