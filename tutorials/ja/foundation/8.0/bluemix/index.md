---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Mobile Foundation on IBM Cloud
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **注:** *IBM Bluemix は、IBM Cloud になりました。 詳しくは、[こちら](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/)を参照してください。*

## 概説
{: #overview }
{{ site.data.keys.product_full }} は IBM Cloud 上でホストできます。 以下に、IBM Cloud に関する基本情報をいくつか示します。

IBM Cloud は、IBM のオープン・クラウド・アーキテクチャーの実装環境です。 Cloud Foundry ベースの IBM Bluemix により、開発者は、利用可能なサービスやランタイム・フレームワークから成る拡大するエコシステムを活用しながら、クラウド・アプリケーションを素早くビルドし、デプロイし、管理することができます。

> IBM Cloud のアーキテクチャーおよび IBM Cloud の概念について詳しくは、[こちら](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview)をご覧ください。

### 機能の仕組み
{: #how-does-it-work }
簡単に言うと、{{ site.data.keys.product }} を IBM Cloud で実行する方法には、ライセンス資格の種類によって 2 とおりあります。

> **注:** *IBM Containers サービスは現在非推奨になったため、IBM Containers 上の Mobile Foundation はサポートされません。 [詳細はこちら](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/)。*

* IBM Cloud サブスクリプションまたは PayGo ライセンス: {{ site.data.keys.mf_bm_full }} サービス
* オンプレミス・ライセンス: IBM 提供のスクリプトを使用して、Kubernetes クラスターまたは Liberty for Java ランタイム上に {{ site.data.keys.product_full }} インスタンスをセットアップします。

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

{{ site.data.keys.product}} を IBM Cloud の Liberty for Java ランタイム上で実行させる場合に使用するコンポーネントは、**WebSphere Liberty のインストール済み環境** が含まれた **Cloudfoundry アプリケーション**で、これに **{{ site.data.keys.mf_server }} インスタンス**をデプロイして使用します。

### IBM Cloud 上の Kubernetes クラスター
Kubernetes は、コンピュート・マシンのクラスター上にアプリケーション・コンテナーをスケジューリングするためのオーケストレーション・ツールです。 Kubernetes を使用すると、開発者はコンテナーの処理能力や柔軟性を活用して、可用性の高いアプリケーションを短時間で開発できます。
Kubernetes CLI を使用して、Kubernetes クラスターを作成および管理できます。

[IBM Cloud 上の Kubernetes クラスターの詳細](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Liberty for Java ランタイム
{: #liberty-for-java-runtime }
Liberty for Java ランタイムには liberty-for-java ビルドパックの機能が採用されています。 liberty-for-java ビルドパックにより、WebSphere Liberty プロファイルの上でアプリケーションを実行させるための完全なランタイム環境が提供されます。 その後、コマンド・ライン・インターフェースを使用して、IBM Cloud 上でアプリケーションを管理します。

[Liberty for Java についてもっとよく知る](https://console.bluemix.net/docs/runtimes/liberty/index.html)。


## 次に使用するチュートリアル
{: #tutorials-to-follow-next }

* [IBM 提供のスクリプトを使用して](mobilefirst-server-using-kubernetes/)、IBM Cloud の Kubernetes クラスター上に {{site.data.keys.mf_bm_short }} インスタンスを作成します。
* [{{ site.data.keys.mf_bm }} サービスのセットアップ](using-mobile-foundation/)のチュートリアルを使用して、{{ site.data.keys.mf_server }} インスタンスを作成します。
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* [IBM 提供のスクリプトを使用し](mobilefirst-server-using-scripts-lbp/)、IBM Cloud 上で Liberty for Java を使用して {{ site.data.keys.mf_server }} インスタンスを作成します。
