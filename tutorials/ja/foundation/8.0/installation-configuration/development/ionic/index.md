---
layout: tutorial
title: Ionic 開発環境のセットアップ
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Ionic は [AngularJS](https://angularjs.org/) および [Apache Cordova](https://cordova.apache.org/) にビルドされたフレームワークで、これを利用して、HTML、CSS、Javascript などの Web テクノロジーを使用するハイブリッドのモバイルおよび Web アプリを迅速に作成することができます。

モバイル・アプリや Web アプリを開発するためのフレームワークとして Ionic を選択した開発者は、以下のセクションで、Ionic アプリで [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) SDK の使用を開始する方法が分かります。

アプリケーションの作成には、任意のコード・エディター (Atom.io、Visual Studio Code、Eclipse、IntelliJ、その他) を使用できます。

**前提条件:** Ionic 開発環境をセットアップする際には、[MobileFirst 開発環境のセットアップ](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst)のチュートリアルも必ずお読みください。

## Ionic CLI のインストール
{: #installing_cli }
Ionic 開発を始めるために必要な最初のステップは [Ionic CLI](https://ionicframework.com/docs/cli/) をインストールすることです。

**Cordova および Ionic CLI をインストールするには**

* [NodeJS](https://nodejs.org/en/) をダウンロードしてインストールします。
* コマンド・ライン・ウィンドウから、次のコマンドを実行します。
```bash  
  npm install -g ionic
```  

## Ionic アプリへの Mobile Foundation SDK の追加
{: #adding_mfp_ionic_sdk }
Ionic アプリケーションの MobileFirst 開発を続行するには、MobileFirst Cordova SDK またはプラグインを Ionic アプリケーションに追加する必要があります。

MobileFirst SDK を Cordova アプリケーションに追加する方法を確認します。
アプリケーション開発については、チュートリアル[Ionic アプリケーションへの Mobile Foundation SDK の追加]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic)を参照してください。
