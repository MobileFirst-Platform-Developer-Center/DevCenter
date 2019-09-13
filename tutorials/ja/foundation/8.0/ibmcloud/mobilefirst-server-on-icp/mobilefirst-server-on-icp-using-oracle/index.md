---
layout: tutorial
title: IBM Cloud Private で Oracle データベースを使用する Mobile Foundation のセットアップ
breadcrumb_title: Foundation with Oracle DB on ICP
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview}

すぐに使用可能な IBM Mobile Foundation - ICP PPA パッケージは、IBM DB2 サーバーの使用をサポートしています。 このチュートリアルでは、Mobile Foundation データの保管にリモート Oracle データベースを使用するように、IBM Cloud Private (ICP) にデプロイされている Mobile Foundation を拡張することに焦点を当てます。

## 前提条件
{: #assumption }
チュートリアルを続行するための前提条件は次のとおりです。

* IBM Cloud Private が既にセットアップ済みで、ICP 上に IBM Mobile Foundation パスポート・アドバンテージ・アーカイブをロードしている。
* リモート Oracle データベース・サーバー上に手動で作成された Mobile Foundation データベース表をセットアップしている ([ダウンロード]((customizable-db-artifacts-for-mfp-icp.zip)し、Mobile Foundation サーバー用の Oracle データベースの db スクリプトを参照)。
* IBM Cloud Private CLI のツールが、ローカル・コンピューター (`bx pr`、`docker`、`kube`、または `cloudctl` など) 上にインストールされている。

>**注:** DB2 データベース用に Helm がデプロイされているときに、表は自動的に作成されます。 Oracle、PostgreSQL、または MySQL の場合、Helm チャートをデプロイする前に、手動で表を作成する必要があります。

## カスタマイズが必要な成果物
{: #artifacts-to-be-customized }

Mobile Foundation サーバーの Docker イメージには、Oracle DB サポートを有効にするためにカスタマイズできる特定の成果物があります。 以下は、Oracle 関連の成果物と構成を使用してコンテナーを作成するために変更の必要がある Docker イメージ内のファイルです。
1.	`mfpdbconfig.sh`
2.	`mfpfsqldb.xml` - Oracle DB および関連データ・ソースをサポートするように変更します。
3.	Oracle クライアント JBDC ドライバーを含めます。
4.	`server.xml` を更新します。

>**注:** 上記のファイル名は、ベースの Docker イメージをカスタマイズするために同じにしておく必要があります。


### 手順
{: #procedure}

1.	ICP コンソールの**カタログ**から、`ibm-mfpf-*` Helm チャートがロードされていることを確認します。
2.	添付ファイル (`mfp-icp-oracle.zip`) を unzip し、`Dockerfile` と、使用するディレクトリー構造とサンプル `Dockerfile` を示す `usr-mfpf-server` を見つけます。
3.	Docker イメージを拡張する必要があるイメージ・バージョンの修正を使用するように、`Dockerfile` を変更します。<br/>
     *例:*<br/>
      `FROM mycluster.icp:8500/default/mfpf-server:<a.b.c.d>`<br/>
       *a.b.c.d* は、イメージ・レジストリーで使用可能なイメージ・バージョンです。
4.	Docker イメージをカスタマイズするためのブログの手順に従い、Mobile Foundation サーバー・ポッドを作成します。
5.	Docker イメージが上記の手順で拡張されたら、ICP コンソールを使用して Mobile Foundation サーバーの Helm チャートをデプロイできます。 新しいイメージが提供されていることを確認します。

Docker イメージのカスタマイズまたは拡張については、[How to customize the Mobile Foundation component deployed on IBM Cloud Private (ICP) ](https://mobilefirstplatform.ibmcloud.com/blog/2018/11/04/customize-mfp-on-icp/)を参照してください。

>**注:** MySQL データベースおよび PostgreSQL データベースには、適切な JDBC ドライバーを使用する必要があります。
