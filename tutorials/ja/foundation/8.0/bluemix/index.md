---
layout: tutorial
breadcrumb_title: Bluemix 上の Foundation
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_full }} は Bluemix 上でホストできます。以下に、Bluemix に関する基本情報をいくつか示します。

IBM Bluemix は、IBM のオープン・クラウド・アーキテクチャーの実装環境です。Cloud Foundry ベースの IBM Bluemix により、開発者は、利用可能なサービスやランタイム・フレームワークから成る拡大するエコシステムを活用しながら、クラウド・アプリケーションを素早くビルドし、デプロイし、管理することができます。

> Bluemix のアーキテクチャーおよび Bluemix の概念について詳しくは、[Bluemix の Web サイト](https://console.ng.bluemix.net/docs/overview/whatisbluemix.html#bluemixoverview)をご覧ください。

### HTTP アダプターを使用するための準備
{: #how-does-it-work }
簡単に言うと、{{site.data.keys.product }} を Bluemix で実行する方法には、ライセンス資格の種類によって 2 とおりあります。

* Bluemix サブスクリプションまたは PayGo ライセンス: {{site.data.keys.mf_bm_full }} サービス
* オンプレミス・ライセンス: IBM 提供のスクリプトを使用して、IBM Containers または Liberty for Java ランタイム上に {{site.data.keys.product_full }} インスタンスをセットアップします。

{{site.data.keys.product }} を Bluemix の IBM Containers 上で実行させるためには、複数のコンポーネントが相互に対話しなければなりません。まず最初のコンポーネントは、**イメージ **で、これには、**Linux ディストリビューションと WebSphere Liberty のインストール済み環境**が含まれ、**{{site.data.keys.mf_server }} インスタンス**がデプロイされています。イメージは **IBM コンテナー**内部に格納され、IBM コンテナーは **Bluemix** によって管理されます。

{{site.data.keys.product}} を Bluemix の Liberty for Java ランタイム上で実行させる場合に使用するコンポーネントは、**WebSphere Liberty のインストール済み環境** が含まれた **Cloudfoundry アプリケーション**で、これに **{{site.data.keys.mf_server }} インスタンス**をデプロイして使用します。

### IBM Containers
{: #ibm-containers }
IBM Containers は、ホストされているクラウド環境において、イメージの実行に使用されるオブジェクトです。IBM Containers には、アプリの実行に必要なものがすべて保持されます。

IBM コンテナーのインフラストラクチャーには、イメージをアップロード、保管、取得できるように、イメージ用の専用レジストリーが含まれています。Bluemix がこれらのイメージを管理できるように、イメージを準備します。その後、コマンド・ライン・インターフェースを使用して、Bluemix 上でコンテナーを管理します。詳しくは、次のチュートリアルをご覧ください。

[IBM Containers についての詳細を参照してください](https://www.ng.bluemix.net/docs/containers/container_index.html)。

### Liberty for Java ランタイム
{: #liberty-for-java-runtime }
Liberty for Java ランタイムには liberty-for-java ビルドパックの機能が採用されています。liberty-for-java ビルドパックにより、WebSphere Liberty プロファイルの上でアプリケーションを実行させるための完全なランタイム環境が提供されます。その後、コマンド・ライン・インターフェースを使用して、Bluemix 上でアプリケーションを管理します。

[Liberty for Java についてもっとよく知る](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html)。

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
* [{{site.data.keys.mf_bm }} サービス](using-mobile-foundation/)を使用して {{site.data.keys.mf_server }} インスタンスを作成します。
* IBM コンテナーを使用し、 [IBM 提供のスクリプトを使用して](mobilefirst-server-using-scripts/)、{{site.data.keys.mf_server }} インスタンスを Bluemix 上に作成します。
* Liberty  ビルド・パックを使用し、 [IBM 提供のスクリプトを使用して](mobilefirst-server-using-scripts-lbp/)、{{site.data.keys.mf_server }} インスタンスを Bluemix 上に作成します。
