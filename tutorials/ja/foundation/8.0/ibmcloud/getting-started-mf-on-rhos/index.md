---
layout: tutorial
breadcrumb_title: Get started with Foundation on OpenShift
title: OpenShift クラスターで Mobile Foundation の使用を開始する
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->


> **注:** この使用開始の説明は、IBM Cloud Pak for Applications の一部としてインストールされた、またはその外部で個別にインストールされた OpenShift Container Platform に適用されます。

* [概要](#introduction)
* [アーキテクチャー](#architecture)
* [Mobile Foundation のインストール](#install-mf)
* [アプリケーションの開発](#develop-apps)
* [アプリケーションのデプロイ](#deploying-apps)

## 概要
Red Hat Openshift 3.11 以降をインストールし、実行するために、IBM Mobile Foundation v8 を使用できるようになりました。 Red Hat OpenShift は、実動システムの複雑なコンテナー・オーケストレーションに対処するために設計されたエンタープライズ Kubernetes プラットフォームです。

企業は、ビジネスを継続的にデジタル変換しているため、コンテナー、マイクロサービス・アーキテクチャーなどの PaaS アプリケーション開発環境を使用することで、付加価値アプリケーション機能の作成および改善に重点を置くことができ、また基礎となるオペレーティング・システムおよびインフラストラクチャーの管理を軽減できます。 Red Hat OpenShift は、アプリケーション・サービスを使用したオペレーティング・システムからのコンテナー・スタックのすべての層に対する自動化されたインストール、パッチ適用、およびアップグレードにより、Kubernetes 環境に対してこれを簡単に行うことができるように設計されています。

開発者が次世代のマルチチャネル・デジタル・アプリケーション (モバイル、ウェアラブル、対話型、Web、PWA など) を迅速に構築およびデプロイできるようにするために、Mobile Foundation は業界最高レベルの安全なプラットフォームを提供しています。  以下により、強力で高度なデジタル・アプリケーションを迅速に開発およびデプロイできます。
* 包括的なセキュリティー、アプリケーション・ライフサイクル管理、オフライン・データ同期、およびバックエンド統合をカバーする OpenShift Container Platform のカスタマイズされたモバイル・バックエンド・サービス。
* ネイティブ開発者とハイブリッド開発者の両方で幅広く使用されるモバイル・フレームワーク用のデジタル・アプリケーションとリッチ SDK を構築するためのロー・コード・スタジオ。
* ユーザーが使用できるようアプリケーションを公開するためのプライベート・アプリケーション・ストア。
* アプリケーション・インサイトのための分析サービス、アプリケーション内フィードバックを使用したフィードバック、プッシュ通知、機能切り替え、および A/B テストを手段としたユーザー・エンゲージメント。

## アーキテクチャー
{: #architecture}

以下の図は、Red Hat OpenShift クラスターでの Mobile Foundation デプロイメントの大まかなアーキテクチャーを示しています。

![アーキテクチャー](architecture-mobile-services-openshift.png)

## Mobile Foundation のインストール
{: #install-mf}

既存の OpenShift クラスターに Mobile Foundation をインストールするには、[ここ](../mobilefoundation-on-openshift)にある指示に従います。

>**注:** IBM Cloud 上の Red Hat OpenShift Container Platform に Mobile Foundation をインストールするには、[ここ](../deploy-mf-on-ibmcloud-ocp)にある指示に従います。

## アプリケーションの開発
{: #develop-apps}

IBM Digital App Builder (DAB) ツールを使用することで、Mobile Foundation のライフサイクル管理、セキュリティー、エンゲージメント、および分析を使用するモバイル・アプリケーションを素早く簡単に開発できます。  DAB は、バックエンド・マイクロサービスに安全に接続するためのモバイル・アプリケーション・アクセラレーターも提供しています。  

* 数分で最初の Mobile Foundation アプリケーションを作成し、テストする - [IBM Digital App Builder 入門](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)

## アプリケーションのデプロイ
{: #deploying-apps}
どの Mobile Foundation アプリケーションでも以下の 2 つをデプロイできます。
* Mobile Foundation App Center またはその他のパブリック・アプリケーション・ストアにデプロイできるモバイル・クライアント・アプリケーション。
* アプリケーション・ライフサイクル、セキュリティー、プッシュ通知、ライブ・アップデートのための Mobile Foundation サービス構成。  これらの構成は、Mobile Foundation の開発環境からエクスポートし、Mobile Foundation のステージング環境や実稼働環境にインポートできます。  

デプロイメント間での Mobile Foundation サービス構成のエクスポートおよびインポートについて詳しくは、[Different ways of exporting and importing Mobile Foundation server artifacts](http://mobilefirstplatform.ibmcloud.com/blog/2016/07/25/how-to-replicate-mobilefirst-environment/)を参照してください。
