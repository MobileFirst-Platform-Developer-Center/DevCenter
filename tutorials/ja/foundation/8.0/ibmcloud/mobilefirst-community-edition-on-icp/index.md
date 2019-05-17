---
layout: tutorial
title: IBM Mobile Foundation for Developers 8.0 on IBM Cloud Private のデプロイ
breadcrumb_title: Foundation for Developers on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

IBM Mobile Foundation for Developers 8.0 on {{ site.data.keys.prod_icp }} は、Mobile Foundation サーバーと Operational Analytics コンポーネントから成る、Mobile Foundation の開発者エディションです。 サーバー・ランタイムには、Mobile Foundation データを保管するための Derby データベースが組み込まれています。 これにより、ユーザーは {{ site.data.keys.prod_icp }} の Kubernetes デプロイメント内の 1 つのポッドに制限されます。 Community Edition を使用して、Mobile Foundation ユーザーは、最小限の構成パラメーターで {{ site.data.keys.prod_icp }} 上に Mobile Foundation インスタンスを簡単にセットアップするという開発者の体験をすることができます。

以下の手順に従って、{{ site.data.keys.prod_icp }} に、IBM Mobile Foundation サーバーおよび事前定義された Operational Analytics から成る開発者エディションをインストールします。<br/>
* IBM Cloud Private Kubernetes クラスター (IBM Cloud Private CE または Native/Enterprise) をセットアップします。
* [オプション] 必要なツール (Docker CLI、IBM Cloud CLI (cloudctl)、Kubernetes CLI (kubectl)、および Helm CLI (helm)) を組み込むよう、ホスト・コンピューターをセットアップします。


#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [IBM Cloud Private カタログからの IBM Mobile Foundation for Developers 8.0 のインストールおよび構成](#install-the-ibm-mfpf-icp-catalog)
* [インストールの検査](#verify-install)
* [サンプル・アプリケーション](#sample-app)
* [アンインストール](#uninstall)
* [制限](#limitations)

## 前提条件
{: #prereqs}

IBM Cloud Private (Community Edition または Native/Enterprise) をセットアップして準備しておく必要があります。 セットアップ手順については、[IBM Cloud Private クラスター・インストール](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/install.html)資料を参照してください。

コンテナーおよびイメージを管理するために、{{site.data.keys.prod_icp }} セットアップの一環として、以下のツールをホスト・マシンにインストールする必要があります。

* Docker
* IBM Cloud CLI (`cloudctl`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

CLI を使用して {{site.data.keys.prod_icp }} クラスターにアクセスするために、*kubectl* クライアントを構成する必要があります。 [詳細はこちら](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html)。


## IBM Mobile Foundation for Developers 8.0 の Helm チャートのインストールおよび構成
{: #install-the-ibm-mfpf-icp-catalog}

カタログから、IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) の Helm チャートをインストールするには、[Catalog 内の Helm チャートのデプロイ](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_release.html)の手順に従ってください。

### IBM Mobile Foundation for Developers 8.0 の環境変数
{: #env-mf-developers }
以下の表に、IBM Mobile Foundation for Developers 8.0 で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー | このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。 |
| image | pullPolicy | イメージ・プル・ポリシー | Always、Never、または IfNotPresent <br/>デフォルトは **IfNotPresent** |
|  | repository | Docker イメージ名 | {{ site.data.keys.prod_adj }} サーバー Docker イメージの名前。 |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
| resources | limits.cpu | 許可される CPU の最大量を記述します。 | デフォルトは 2000m。 Kubernetes の[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)を参照してください。 |
|  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)を参照してください。 |
|  | requests.cpu | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2000m。 Kubernetes の[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)を参照してください。 |
|  | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)を参照してください。 |
| logs | consoleFormat | コンテナー・ログの出力形式を指定します。 | デフォルトは **json** |
|  | consoleLogLevel | コンテナー・ログに移動するメッセージの細分度を制御します。 | デフォルトは **info** |
|  | consoleSource | コンテナー・ログに書き込まれるソースを指定します。 複数のソースには、コンマ区切りのリストを使用します。 | デフォルトは **message**、**trace**、**accessLog**、**ffdc** |

## インストールの検査
{: #verify-install}

Mobile Foundation for Developers 8.0 のインストールが完了したら、以下を実行することにより、インストール済み環境およびデプロイされたポッドの状況を検査できます。

{{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。 インストール済み環境の*リリース名* をクリックします。


## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

インストールが成功したら、`<protocol>://<ip_address>:<port>/mfpconsole` を使用して、IBM {{ site.data.keys.prod_adj }} Operations Console にアクセスできます。
IBM {{ site.data.keys.mf_analytics }} Console には、`<protocol>://<ip_address>:<port>/analytics/console` を使用してアクセスできます。

プロトコルには、`http` または `https` を使用できます。 また、**NodePort** デプロイメントの場合、ポートは **NodePort** になることに注意してください。 インストールされた {{site.data.keys.prod_adj }} チャートの ip_address および **NodePort** を取得するには、以下のステップに従ってください。

1. {{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。
2. Helm チャート・インストール済み環境の*リリース名* をクリックします。
3. **「メモ (Notes)」**セクションを参照します。

## サンプル・アプリケーション
{: #sample-app}
{{ site.data.keys.prod_icp }} で実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## アンインストール
{: #uninstall}
{{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。

ダッシュボードから、**「ワークロード (Workloads)」 > 「Helm リリース (Helm Releases)」**をクリックし、チャートのデプロイに使用する *release_name* を検索し、**「アクション (Action)」**メニューをクリックし、**「削除 (Delete)」**を選択し、インストールされているチャートを完全に削除します。

以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。

## 制限
{: #limitations}

この Helm チャートは、開発およびテスト目的のためにのみ提供されます。 データは、組み込み Derby データベースに保管されます。 データベースの制限により、チャートは 1 つのポッドでのみ動作します。
