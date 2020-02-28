---
layout: tutorial
title: IBM Cloud Kubernetes クラスターへの IBM Mobile Foundation for Developers 8.0 のデプロイ
breadcrumb_title: IBM Cloud Kubernetes クラスター上の Foundation for Developers
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

IBM Mobile Foundation for Developers 8.0 は、サーバーと Operational Analytics コンポーネントで構成される開発者エディションです。

Mobile Foundation サーバー・ランタイムには、Mobile Foundation データを保管するための Derby データベースが組み込まれています。 これにより、ユーザーは IBM Cloud Kubernetes デプロイメント内の 1 つのポッドに制限されます。 Community Edition では、Mobile Foundation ユーザーは、最小限の構成パラメーターを使用して、IBM Cloud Kubernetes Service で Mobile Foundation インスタンスを簡単にセットアップするという開発を経験できます。

以下の手順に従って、IBM Cloud Kubernetes Service 上の事前構成済み Operational Analytics を含む IBM Mobile Foundation サーバーの開発者エディションをインストールします。<br/>
* [ここ](https://cloud.ibm.com/kubernetes/clusters)から Kubernetes クラスターを作成し、構成します。
* [オプション] 必要なツール (Docker CLI、Kubernetes CLI (kubectl)、および Helm CLI (helm)) を使用してホスト・コンピューターをセットアップします。

#### ジャンプ先:
{: #jump-to }

* [前提条件](#prereqs)
* [Helm Chart Catalog からの IBM Mobile Foundation for Developers 8.0 のインストールおよび構成](#install-the-ibm-mfpf-iks-catalog)
* [インストールの検査](#verify-install)
* [サンプル・アプリケーション](#sample-app)
* [アンインストール](#uninstall)
* [制限](#limitations)

## 前提条件
{: #prereqs}

[IBM Cloud](https://cloud.ibm.com/) ポータルを使用して、IBM Cloud Kubernetes Service (無料プラン) を作成しておく必要があります。 セットアップ手順については、[資料](https://cloud.ibm.com/docs/containers?topic=containers-getting-started)を参照してください。
kube ポッドおよび helm デプロイメントを管理するために、ホスト・マシンに以下のツールをインストールする必要があります。
* ibmcloud CLI (`ibmcloud`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)
CLI を使用して Kubernetes クラスターを処理するために、*ibmcloud* クライアントを構成する必要があります。
1. [クラスター・ページ](https://cloud.ibm.com/kubernetes/clusters)にログインしていることを確認します。 (注: [IBMid アカウント](https://myibm.ibm.com/)が必要です。)
2. IBM Mobile Foundation Chart をデプロイする先の Kubernetes クラスターをクリックします。
3. クラスターが作成された後、**「アクセス」**タブの指示に従います。
>**注:** クラスターの作成には数分かかります。 クラスターが正常に作成された後、**「ワーカー・ノード (Worker Nodes)」**タブをクリックし、*パブリック IP* をメモします。

## IBM Mobile Foundation for Developers 8.0 の Helm チャートのインストールおよび構成
{: #install-the-ibm-mfpf-iks-catalog}

IBM Cloud クライアント端末 (*ibmcloud* CLI) で、「[Deploying charts from the Helm Catalog](https://cloud.ibm.com/kubernetes/helm/ibm-charts/ibm-mobilefoundation-dev)」の「**INSTALL CHART**」セクションの手順に従い、Catalog から IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) Helm チャートをインストールします。

### IBM Mobile Foundation for Developers 8.0 の環境変数
{: #env-mf-developers }

以下の表に、IBM Mobile Foundation for Developers 8.0 で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー | このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。 |
| image | pullPolicy | イメージ・プル・ポリシー | Always、Never、または IfNotPresent <br/>デフォルトは **IfNotPresent** |
|  | repository | Docker イメージ名 | {{ site.data.keys.prod_adj }} サーバー Docker イメージの名前。 |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
| resources | limits.cpu | 許可される CPU の最大量を記述します。 | デフォルトは 1000m。 Kubernetes の[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)を参照してください。 |
|  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 2048Mi。 Kubernetes の [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)を参照してください。 |
|  | requests.cpu | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 750m です。 Kubernetes の[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)を参照してください。 |
|  | requests.memory | 必要なメモリーの最小量を記述します。 未指定の場合、デフォルトではメモリー量は制限値 (values.yaml で指定されている場合) または実装定義値になります。 | デフォルトは 1024Mi です。 Kubernetes の [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)を参照してください。 |
| logs | consoleFormat | コンテナー・ログの出力形式を指定します。 | デフォルトは **json** |
|  | consoleLogLevel | コンテナー・ログに移動するメッセージの細分度を制御します。 | デフォルトは **info** |
|  | consoleSource | コンテナー・ログに書き込まれるソースを指定します。 複数のソースには、コンマ区切りのリストを使用します。 | デフォルトは **message**、**trace**、**accessLog**、**ffdc** |

## インストールの検査
{: #verify-install}

Mobile Foundation for Developers 8.0 のインストールが完了したら、以下を実行することにより、インストール済み環境およびデプロイされたポッドの状況を検査できます。
1. [クラスター・ページ](https://cloud.ibm.com/kubernetes/clusters)で、IBM Mobile Foundation Chart がデプロイされている Kubernetes クラスターをクリックします。
2. **「Kubernetes ダッシュボード (Kubernetes dashboard)」**ボタンをクリックして Kube ダッシュボードに移動します。
3. ダッシュボードで、**デプロイメント**および**ポッド**を確認します。これらはそれぞれ**「デプロイ済み (DEPLOYED)」**状態および**「実行中 (RUNNING)」**状態になっている必要があります。
4. サービスにアクセスするには、デプロイメントの*パブリック IP* および*ノード・ポート*が必要になります。
    - **パブリック IP** を取得するには - **「Kubernetes」** **>** **「ワーカー・ノード (Worker Nodes)」**を選択し、*「パブリック IP (Public IP)」*に指定されている IP アドレスをメモします。
    - **ノード・ポート**は、**Kubernetes ダッシュボード**で見つけることができます。**>** **「サービス」**を選択し、「内部エンドポイント (internal endpoints)」で*「TCP ノード・ポート (TCP Node Port)」*のエントリー (5 桁のポート) をメモします。
5. ブラウザーを開き、`http://[public ip]:[node port]/mfpconsole` と入力します。これにより、管理コンソールが表示されます。
6. デフォルトの資格ユーザーとして `admin`、パスワードとして `admin` を入力して、Mobile Foundation サーバーの管理コンソールにログインします。
7. サーバーの Admin、Push、および Analytics の各操作が使用可能であることを確認します。

### [オプション] コマンド・ラインの使用

または、コマンド・ラインを使用して以下の手順に従います。 以下のコマンドで、**status** が *DEPLOYED* として表示されることを確認します。
```bash
helm list
```
`kubectl` コマンドを実行して、ポッドが **RUNNING** 状態であるかどうか確認します。
1. Kubernetes クラスター上のすべてのデプロイメントのリストを取得し、Mobile Foundation デプロイメント名をメモします。
    ```bash
    kubectl get deployments
    ```
2. 以下のコマンドを実行して、デプロイメントの可用性とそれらの詳細な状況を確認します。 状況が `(1/1) RUNNING` である場合、kube ポッドは使用可能です。
    ```bash
    kubectl describe deployment <deployment_name>
    kubectl get pods
    ```
## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

インストールが成功したら、`<protocol>://<public_ip>:<node_port>/mfpconsole` を使用して、IBM {{ site.data.keys.prod_adj }} Operations Console にアクセスできます。<br/>
IBM {{ site.data.keys.mf_analytics }} Console には、`<protocol>://<public_ip>:<port>/analytics/console` を使用してアクセスできます。
プロトコルには、`http` または `https` を使用できます。 また、**NodePort** デプロイメントの場合、ポートは **NodePort** になることに注意してください。 インストールされている {{ site.data.keys.prod_adj }} チャートの IP アドレスおよび **NodePort** を取得するには、Kubernetes ダッシュボードで以下の手順に従います。
* **パブリック IP** を取得するには - **「Kubernetes」** > **「ワーカー・ノード (Worker Nodes)」**を選択し、 「パブリック IP (Public IP)」で IP アドレスをメモします。
* **ノード・ポート**は、**Kubernetes ダッシュボード**で見つけることができます。**「サービス」**を選択し、**「内部エンドポイント (internal endpoints)」**で*「TCP ノード・ポート (TCP Node Port)」*のエントリー (5 桁のポート) をメモします。

## サンプル・アプリケーション
{: #sample-app}

IBM Cloud Kubernetes クラスターで実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## アンインストール
{: #uninstall}

`ibm-mobilefoundation-dev` Helm チャートをアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。
以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。

## 制限
{: #limitations}

この Helm チャートは、開発およびテスト目的のためにのみ提供されます。 データは組み込みの Derby データベースに保管されますが、永続的には保管されません。 データベースの制限により、チャート・デプロイメントは 1 つのポッドでのみ動作します。
