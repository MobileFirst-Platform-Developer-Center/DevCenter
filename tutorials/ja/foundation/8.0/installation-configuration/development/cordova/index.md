---
layout: tutorial
title: Cordova 開発環境のセットアップ
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
[Cordova (PhoneGap) 開発](https://cordova.apache.org/)を始めるために、ごく基本的で必要なステップとして、Cordova CLI をインストールします。 Cordova CLI は、Cordova アプリケーションの作成を可能にするツールです。 これらのアプリケーションは、サード・パーティーの各種フレームワークおよびツール (Ionic、AngularJS、jQuery Mobile、その他多数) を使用してさらに拡張することができます。 
Cordova アプリケーションでは、アプリケーションおよびアダプターの実装には、任意のコード・エディター (Atom.io、Visual Studio Code、Eclipse、IntelliJ、その他) を使用できます。

**前提条件:** Cordova 開発環境をセットアップする際には、[{{ site.data.keys.product_adj }} 開発環境のセットアップ](../mobilefirst/)のチュートリアルも必ずお読みください。

## Cordova CLI のインストール
{: #installing-the-cordova-cli }
{{ site.data.keys.product }} は、Apache [Cordova CLI 6.x](https://www.npmjs.com/package/cordova) 以降をサポートします。  
インストールするには、以下のようにします。

1. [NodeJS](https://nodejs.org/en/) をダウンロードしてインストールします。
2. **コマンド・ライン**・ウィンドウから、次のコマンドを実行します。`npm install -g cordova`

## 次のステップ
{: #next-steps }
Cordova アプリケーションで {{ site.data.keys.product_adj }} 開発を続けるには、{{ site.data.keys.product_adj }} Cordova SDK/プラグインが Cordova アプリケーションに追加されなければなりません。

* [{{ site.data.keys.product_adj }} SDK を Cordova アプリケーションに](../../../application-development/sdk/cordova/)追加する方法を確認します。
* アプリケーション開発については、[{{ site.data.keys.product }} SDK の使用](../../../application-development/)のチュートリアルを参照してください。
* アダプター開発については、[アダプター](../../../adapters/)のカテゴリーを参照してください。
