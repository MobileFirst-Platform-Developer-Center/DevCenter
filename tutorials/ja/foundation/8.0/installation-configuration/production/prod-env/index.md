---
layout: tutorial
title: 実稼働環境での MobileFirst Server のインストール
breadcrumb_title: Installing MobileFirst Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルは、実稼働環境用に MobileFirst Server をインストールおよび構成する開発者と管理者を対象としています。
ここでは、特定の環境に合ったインストールの計画および準備に役立つよう、MobileFirst Server のインストールに関するチュートリアル以上の詳しい手順を説明します。


## インストール前提条件
{: #prereqs }

MobileFirst Server のインストールを円滑に進めるために、すべてのソフトウェア[前提条件](prereqs)が満たされていることを確認してください。

## IBM Installation Manager の実行
{: #run-install-mgr }

IBM Installation Manager は、IBM MobileFirst Platform Server のファイルおよびツールをコンピューターにインストールします。[IBM Installation Manager のインストールと実行に関するチュートリアル](../installation-manager)に従ってください。

## データベースのセットアップ
{: #databases }

MobileFirst Server コンポーネントが使用するデータベースをセットアップします。[データベースのセットアップに関するチュートリアル](databases)に従ってください。

## トポロジーとネットワーク・フロー
{: #topologies }

MobileFirst Server コンポーネントの可能なサーバー・トポロジーおよびそれらのネットワーク・フローに関するトピックです。[可能なサーバー・トポロジーおよびネットワーク・フローに関するチュートリアル](topologies)に従ってください。

## アプリケーション・サーバーへの MobileFirst Server のインストール
{: #install-to-appserver }

コンポーネントのインストールは、Ant タスクを使用するか、サーバー構成ツールを使用するか、または手動で行うことができます。 コンポーネントをアプリケーション・サーバー上に正常にインストールできるように、前提条件およびインストール・プロセスについての詳細を確認してください。 [MobileFirst コンポーネントをアプリケーション・サーバーにインストールする方法に関するチュートリアル](appserver)に従ってください。
