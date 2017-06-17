---
layout: tutorial
title: 開発環境のセットアップ
breadcrumb_title: 開発環境
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} を使用してクライアントおよびサーバーのコード開発を始める前に、まず、開発環境をセットアップする必要があります。これには、必要な各種ソフトウェアおよびツールのインストールが含まれます。以下に、ニーズに応じて開発者のワークステーションにインストールする必要があるソフトウェアをリストします。

また、[ワークステーション・インストール・ガイド](mobilefirst/installation-guide/)にもステップバイステップの詳細な手順が示されています。

#### ジャンプ先:

* [サーバー](#server)
* [アプリケーション開発](#application-development)
* [アダプター開発](#adapter-development)
* [プラットフォーム固有の説明](#platform-specific-instructions)

### サーバー
{: #server }
{{ site.data.keys.mf_server }} は、[Mobile Foundation Bluemix サービス](../../bluemix/using-mobile-foundation)経由で、または {{ site.data.keys.mf_dev_kit_full }} を使用してローカルで (ローカルの開発目的用) 使用することができます。{{ site.data.keys.mf_server }} を実行するには、Java 7 または 8 が必要です。

Mobile Foundation Bluemix サービスを使用する予定の場合は、Bluemix.net のアカウントが必要です。

### アプリケーション開発
{: #application-development }
最低限、以下のソフトウェアが必要です。

* NodeJS ({{ site.data.keys.mf_cli }} の要件)
* {{ site.data.keys.mf_cli }}
* Cordova CLI
* IDE:
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io / Visual Studio Code / WebStorm / IntelliJ / Eclipse / その他の IDE

### アダプター開発
{: #adapter-development }
最低限、以下のソフトウェアが必要です。

* NodeJS ({{ site.data.keys.mf_cli }} の要件)
* *オプションの* {{ site.data.keys.mf_cli }}
* Maven (Java が必要)
* IDE:
    - IntelliJ / Eclipse / その他の IDE

### プラットフォーム固有の説明
{: #platform-specific-instructions }
