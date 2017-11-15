---
layout: tutorial
title: Cloud Functions アダプター
breadcrumb_title: Cloud Functions アダプター
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

> OpenWhisk は、Cloud Functions と呼ばれるようになりました。

IBM Cloud Functions は、拡張が容易なサーバーレス環境でコードを実行できるようにする Function-as-a-Service (FaaS) プラットフォームです。Cloud Functions プラットフォームのユース・ケースの 1 つには、サーバーレス・モバイル・バックエンド・コードの開発と実行があります。Bluemix 上の Cloud Functions プラットフォームについて詳しくは、[ここ](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south)を参照してください。

{{ site.data.keys.product }} アダプターを使用して、すべての必要なサーバー・サイド・ロジックを実行し、バックエンド・システムから情報を取得して、クライアント・アプリケーションおよびクラウド・サービスに転送します。{{ site.data.keys.product }} では、Cloud Functions 用のアダプターが提供されるようになりました。

##  Cloud Functions アダプター
{: #cloud-functions-adapter}

[iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) 以降の {{ site.data.keys.product_full }} では、Cloud Functions アダプターが用意されています。このアダプターは、Mobile Foundation コンソールの**ダウンロード・センター**からダウンロードしてデプロイできます。

アダプターをダウンロードしてデプロイした後で、Cloud Functions に接続するように構成する必要があります。

### Cloud Functions に接続するようにアダプターを構成
{: configure-adapter-connect-cloud-functions}

Cloud Functions に接続するようにアダプターを構成するには、**「アダプター構成 (Adapter Configuration)」**ページに移動して、Cloud Functions の許可キーの_**ユーザー名**_ と_**パスワード**_ を指定します。Cloud Functions の_**ユーザー名**_ と_**パスワード**_ を入手するには、以下の CLI コマンドを実行します。

```bash
./wsk property get --auth KEY
```

上のコマンドは、コロンで区切られた許可キーを返します。コロンの左側が_**ユーザー名**_ で、コロンの右側は_**パスワード**_ です。

_**username:password**_

前述のとおりに入手した_**ユーザー名**_ と_**パスワード**_ を Cloud Functions アダプターの構成ページで指定して、構成を保存する必要があります。これで、クライアント・アプリケーションは、Cloud Functions バックエンド・コードを呼び出すためにアダプター API を呼び出すことができるようになります。

>Cloud Functions アダプターを変更するために、この [Github リポジトリー](https://github.com/mfpdev/mfp-extension-adapters)からアダプターのソース・コードをダウンロードできます。
