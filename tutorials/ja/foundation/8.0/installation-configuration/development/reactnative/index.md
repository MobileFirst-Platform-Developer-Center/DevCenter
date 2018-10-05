---
layout: tutorial
title: React Native 開発環境のセットアップ
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
React Native は、[React](https://reactjs.org/)を使用してネイティブの iOS および Android アプリケーションをビルドするためのフレームワークで、これを利用して、HTML、CSS、Javascript などの Web テクノロジーを使用するネイティブ・モバイル・アプリケーションを迅速に作成することができます。

モバイル・アプリや Web アプリを開発するためのフレームワークとして React Native を選択した開発者は、以下のセクションで、React Native アプリで [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) SDK の使用を開始する方法が分かります。

アプリケーションの作成には、任意のコード・エディター (Atom.io、Visual Studio Code、Eclipse、IntelliJ、その他) を使用できます。

**前提条件:** React Native 開発環境をセットアップする際には、[MobileFirst 開発環境のセットアップ](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst)のチュートリアルも必ずお読みください。

## React Native CLI のインストール
{: #installing_cli }
React Native 開発を始めるために必要な最初のステップは [React Native CLI](https://facebook.github.io/react-native/docs/getting-started.html) をインストールすることです。

**React Native CLI をインストールするには**

* [NodeJS](https://nodejs.org/en/) をダウンロードしてインストールします。
* コマンド・ライン・ウィンドウから、次のコマンドを実行します。
```bash
npm install -g react-native-cli
```

## React Native アプリへの Mobile Foundation SDK の追加
{: #adding_mfp_reactnative_sdk }
React Native アプリケーションの MobileFirst 開発を続行するには、MobileFirst React Native SDK またはプラグインを React Native アプリケーションに追加する必要があります。

MobileFirst SDK を React Native アプリケーションに追加する方法を確認します。
アプリケーション開発については、チュートリアル[React Native アプリケーションへの Mobile Foundation SDK の追加]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/reactnative)を参照してください。
