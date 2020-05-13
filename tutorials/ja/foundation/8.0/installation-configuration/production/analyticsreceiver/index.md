---
layout: tutorial
title: MobileFirst Analytics Receiver Server のインストールおよび構成
breadcrumb_title: MobileFirst Analytics Receiver Server のインストール
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Mobile Analytics Receiver サーバーは、Mobile Foundation 分析イベントを Mobile Foundation Server ランタイムではなく、モバイル・クライアント・アプリケーションから送信するためにデプロイできるオプションのサーバーです。このデプロイ・オプションを使用すると、Mobile Foundation サーバー・ランタイムから分析イベント処理をオフロードできるため、ランタイム機能にリソースを十分に活用できます。  

{{ site.data.keys.mf_analytics_receiver_server }} は、単一の WAR ファイルとして提供されます。これは別のサーバーにインストールする必要があります。インストールは、次のいずれかの方法で行うことができます。

* Ant タスクを使用したインストール
* 手動インストール

選択した Web アプリケーション・サーバーに {{ site.data.keys.mf_analytics_receiver_server }} をインストールした後で、追加の構成を行います。詳しくは、以下のインストール後に {{ site.data.keys.mf_analytics_receiver_server }} の構成を参照してください。インストーラーで手動セットアップを選択する場合、使用するアプリケーション・サーバーの資料を参照してください。

> **注:** 単一のホスト・マシンに {{ site.data.keys.mf_analytics_receiver_server }} の複数のインスタンスをインストールしないでください。 

Analytics Receiver WAR ファイルは、MobileFirst Server インストールと共に格納されます。詳しくは、「MobileFirst Server の配布構造」を参照してください。

* {{ site.data.keys.mf_analytics_receiver_server }} のインストール方法について詳しくは、[{{ site.data.keys.mf_analytics_receiver_server }} インストール・ガイド](installation)を参照してください。
* IBM MobileFirst Analytics Receiver の構成方法について詳しくは、[構成ガイド](configuration)を参照してください。
