---
layout: tutorial
title: アプリケーションの管理
weight: 11
show_children: true
---
## 概説
{: #overview }
{{ site.data.keys.product_full }} には、開発中および稼働中の {{ site.data.keys.product_adj }} アプリケーションを管理するいくつかの方法が用意されています。{{ site.data.keys.mf_console }} は、デプロイされているすべての {{ site.data.keys.product_adj }} アプリケーションを一元的な Web ベースのコンソールからモニターすることができるメインのツールです。

{{ site.data.keys.mf_console }} を通じて実行できる主な操作は以下のとおりです。

* モバイル・アプリケーションを {{ site.data.keys.mf_server }} に登録して構成する。
* アダプターを {{ site.data.keys.mf_server }} にデプロイして構成する。
* アプリケーション・バージョンを管理して、新規バージョンをデプロイしたり、リモート側で古いバージョンを使用不可にしたりする。
* モバイル・デバイスとユーザーを管理して、特定のデバイスへのアクセスや、特定のユーザーからのアプリケーションへのアクセスを制御する。
* アプリケーションの開始時に通知メッセージを表示する。
* プッシュ通知サービスをモニターする。
* 特定のデバイスにインストールされた特定のアプリケーションについてクライアント・サイド・ログを収集する。

## 管理ロール
{: #administration-roles }
管理ユーザーの種類によっては、実行できない管理操作があります。{{ site.data.keys.mf_console }}、およびすべての管理ツールには、{{ site.data.keys.product_adj }} アプリケーションの管理用に定義された 4 つのロールがあります。以下の 

{{ site.data.keys.product_adj }} 管理ロールが定義されています。

**モニター**  
このロールでは、ユーザーはデプロイ済みの {{ site.data.keys.product_adj }} プロジェクトとデプロイ済みの成果物をモニターできます。このロールは読み取り専用です。

**オペレーター**  
オペレーターはすべてのモバイル・アプリケーション管理操作を実行できますが、アプリケーション・バージョンやアダプターの追加および削除はできません。

**デプロイメント担当者**  
このロールでは、ユーザーはオペレーターと同じ操作を実行できるだけでなく、アプリケーションとアダプターをデプロイすることもできます。

**管理者**  
このロールでは、ユーザーはすべてのアプリケーション管理操作を実行できます。

> {{ site.data.keys.product_adj }} 管理ロールについて詳しくは、[{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)を参照してください。

## 管理ツール
{: #administration-tools }
{{ site.data.keys.mf_console }} が、{{ site.data.keys.product_adj }} アプリケーションを管理する唯一の手段であるというわけではありません。{{ site.data.keys.product }} も、管理操作をビルド・プロセスやデプロイメント・プロセスに取り込むための他のツールを用意しています。

管理操作を実行するために使用可能な REST サービスのセットがあります。これらのサービスの API 参照資料については、[{{ site.data.keys.mf_server }} 管理サービスの REST API](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html#restservicesapi) を参照してください。

この REST サービスのセットを使用すると、{{ site.data.keys.mf_console }} で実行できるものと同じ操作を実行できます。アプリケーションやアダプターを管理できるだけでなく、例えば、アプリケーションの新規バージョンをアップロードしたり、古いバージョンを使用不可にしたりすることができます。

{{ site.data.keys.product_adj }} アプリケーションは、Ant タスクや **mfpadm** コマンド・ライン・ツールを使用することによっても管理できます。[Ant を使用した {{ site.data.keys.product_adj }} アプリケーションの管理](using-ant)または[コマンド・ラインを使用した {{ site.data.keys.product_adj }} アプリケーションの管理](using-cli)を参照してください。

Web ベースのコンソールと同様に、REST サービス、Ant タスク、およびコマンド・ライン・ツールも保護されており、使用するユーザーは管理者の資格情報を提供する必要があります。

### トピックを選択してください。
{: #select-a-topic }

