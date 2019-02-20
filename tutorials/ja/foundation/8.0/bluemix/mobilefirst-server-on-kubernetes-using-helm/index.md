---
layout: tutorial
title: Helm を使用した IBM Cloud Kubernetes クラスター上の Mobile Foundation のセットアップ
breadcrumb_title: Foundation on Kubernetes Cluster using Helm
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
下記の説明に従って、IBM Cloud Kubernetes クラスター (IKS) 上に {{ site.data.keys.mf_server }} インスタンスおよび {{ site.data.keys.mf_analytics }} インスタンスを、Helm チャートを使用して構成します。

* IBM Cloud Kubernetes クラスターをセットアップします。
* IBM Cloud Kubernetes Service CLI (`ibmcloud`) を組み込むようホスト・コンピューターをセットアップします。
* {{ site.data.keys.prod_icp }} 用の {{ site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA アーカイブ) をダウンロードします。
* IBM Cloud Kubernetes クラスターに PPA アーカイブをロードします。
* 最後に、{{site.data.keys.mf_analytics }} (オプション) および {{site.data.keys.mf_server }} を構成し、インストールします。

#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード](#load-the-ibm-mfpf-ppa-archive)
* [IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)
* [インストールの検査](#verify-install)
* [サンプル・アプリケーション](#sample-app)
* [{{site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード](#upgrading-mf-helm-charts)
* [アンインストール](#uninstall)

## 前提条件
{: #prereqs}

IBM Cloud アカウントを取得し、[IBM Cloud Kubernetes クラスター・サービス](https://console.bluemix.net/docs/containers/cs_tutorials.html)の資料に従って Kubernetes クラスターをセットアップしておく必要があります。

コンテナーおよびイメージを管理するために、IBM Cloud CLI プラグインのセットアップの一環として、以下のツールをホスト・マシンにインストールする必要があります。

* IBM Cloud CLI (`ibmcloud`)
* Kubernetes CLI
* IBM Cloud Container Registry プラグイン (`cr`)
* IBM Cloud Container Service プラグイン (`ks`)

CLI を使用して IBM Cloud Kubernetes クラスターにアクセスするために、IBM Cloud クライアントを構成する必要があります。 [詳細はこちら](https://console.bluemix.net/docs/cli/index.html)。

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード
{: #download-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA) は、[ここ](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)から入手できます。 {{site.data.keys.product }} の PPA アーカイブには、以下の {{site.data.keys.product }} コンポーネントの Docker イメージと Helm チャートが含まれます。
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード
{: #load-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product }} の PPA アーカイブをロードする前に、Docker をセットアップする必要があります。 [こちら](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html)の説明を参照してください。

以下のステップに従って、PPA アーカイブを IBM Cloud Kubernetes クラスターにロードします。

  1. IBM Cloud プラグインを使用してクラスターにログインします。

      >IBM Cloud CLI 資料で、[CLI コマンド・リファレンス](https://console.bluemix.net/docs/cli/index.html#overview)を参照してください。

      以下に例を示します。
      ```bash
      ibmcloud login -a https://ip:port
      ```
      オプションで、SSL 検証をスキップする場合は、上記のコマンドでフラグ `--skip-ssl-validation` を使用します。 このオプションを使用すると、クラスター・エンドポイントの `username` と `password` の入力を求めるプロンプトが出されます。 ログインに成功したら、以下のステップに進んでください。

  2. IBM Cloud Container Registry にログインし、以下のコマンドを使用して Container Service を初期化します。
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. 以下のコマンドを使用してデプロイメントの地域を設定します (例えば、米国南部)。
      ```bash
      ibmcloud cr region-set
      ```    

  4. 以下のコマンドを使用して、{{ site.data.keys.product }} の PPA アーカイブをロードします。
      ```
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
      ```
      {{ site.data.keys.product }} の *archive_name* は、IBM パスポート・アドバンテージからダウンロードした PPA アーカイブの名前です。


  Helm チャートは、(IBM Cloud Private Helm リポジトリーに保管される ICP Helm チャートと異なり) クライアント内に保管されるか、ローカルに保管されます。 チャートは、`ppa-import/charts` ディレクトリー内で見つけることができます。

## IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成
{: #configure-install-mf-helmcharts}

{{site.data.keys.mf_server }} をインストールし、構成するには、以下のものが事前に必要になります。

* [**必須**] 構成済みで使用可能な DB2 データベース。
  [{{site.data.keys.mf_server }} Helm を構成](#install-hmc-icp)するには、データベース情報が必要です。 {{site.data.keys.mf_server }} には、スキーマと表が必要であり、それらがこのデータベースに作成されます (存在しない場合)。

* [**オプション**] 鍵ストアとトラストストアが設定された秘密。
  独自の鍵ストアとトラストストアを設定した秘密を作成することにより、独自の鍵ストアとトラストストアをデプロイメントに提供できます。

  インストールの前に、以下のステップを実行してください。

  * `keystore.jks`、`keystore-password.txt`、`truststore.jks`、`truststore-password.txt` を使用して秘密を作成し、秘密の名前を *keystores.keystoresSecretName* フィールドに指定します。

  * `keystore.jks` ファイルとそのパスワードを `keystore-password.txt` というファイル内に保持し、`truststore.jks` ファイルとそのパスワードを `truststore-password.txt` というファイル内に保持します。

  * コマンド・ラインに移動し、以下を実行します。
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**注:** ファイルの名前は、前述したとおり、`keystore.jks`、`keystore-password.txt`、`truststore.jks`、および `truststore-password.txt` でなければなりません。

  * 秘密の名前を *keystoresSecretName* に指定して、デフォルトの鍵ストアをオーバーライドします。

  詳しくは、[MobileFirst Server 鍵ストアの構成]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。  

### {{ site.data.keys.mf_analytics }} の環境変数
{: #env-mf-analytics }
以下の表に、IBM Cloud Kubernetes クラスター上の {{ site.data.keys.mf_analytics }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー | このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。 |
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
|  | name | Docker イメージ名 | {{ site.data.keys.prod_adj }} Operational Analytics Docker イメージの名前。 |
| scaling | replicaCount | 作成する必要がある {{ site.data.keys.prod_adj }} Operational Analytics のインスタンス (ポッド) の数 | 正整数<br/>デフォルトは **2** |
| mobileFirstAnalyticsConsole | user | {{ site.data.keys.prod_adj }} Operational Analytics のユーザー名 | デフォルトは **admin** |
|  | password | {{ site.data.keys.prod_adj }} Operational Analytics のパスワード | デフォルトは **admin** |
| analyticsConfiguration | clusterName | {{ site.data.keys.prod_adj }} Analytics クラスターの名前 | デフォルトは **mobilefirst** |
|  | analyticsDataDirectory | Analytics データが保管されるパス。 *これは、コンテナー内で永続ボリューム要求がマウントされるパスと同じパスでもあります*。 | デフォルトは `/analyticsData` |
|  | numberOfShards | {{site.data.keys.prod_adj }} Analytics の Elasticsearch シャードの数 | 正整数<br/>デフォルトは **2** |
|  | replicasPerShard | {{site.data.keys.prod_adj }} Analytics のシャードごとに維持する Elasticsearch レプリカの数 | 正整数<br/>デフォルトは **2** |
| keystores | keystoresSecretName | 鍵ストアとそのパスワードを設定した秘密を作成するステップを説明している、[IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。 |  |
| jndiConfigurations | mfpfProperties | Operational Analytics をカスタマイズするために指定する {{site.data.keys.prod_adj }} JNDI プロパティー | 名前値のペアをコンマ区切りで指定します。 |
| resources | limits.cpu | 許可される CPU の最大量を記述します。 | デフォルトは **2000m**<br/>[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) をお読みください。 |
|  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **4096Mi**<br/>[Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) をお読みください。 |
|  | requests.cpu | 必要な CPU の最小量を記述します。 指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1000m** |
|  | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **2048Mi** |
| persistence | existingClaimName | 既存の永続ボリューム要求 (PVC) の名前 |  |
| logs | consoleFormat | コンテナー・ログの出力形式を指定します。 | デフォルトは **json** |
|  | consoleLogLevel | コンテナー・ログに移動するメッセージの細分度を制御します。 | デフォルトは **info** |
|  | consoleSource | コンテナー・ログに書き込まれるソースを指定します。 複数のソースには、コンマ区切りのリストを使用します。 | デフォルトは **message**、**trace**、**accessLog**、**ffdc** |


### {{ site.data.keys.mf_server }} の環境変数
{: #env-mf-server }
以下の表に、IBM Cloud Kubernetes クラスター上の {{ site.data.keys.mf_server }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー | このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。 |
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
|  | name | Docker イメージ名 | {{ site.data.keys.prod_adj }} サーバー Docker イメージの名前。 |
| scaling | replicaCount | 作成する必要がある {{site.data.keys.prod_adj }} Server のインスタンス (ポッド) の数 | 正整数<br/>デフォルトは **3** |
| mobileFirstOperationsConsole | user | {{site.data.keys.prod_adj }} サーバーのユーザー名 | デフォルトは **admin** |
|  | password | {{site.data.keys.prod_adj }} Server のユーザーのパスワード | デフォルトは **admin** |
| existingDB2Details | db2Host | {{site.data.keys.prod_adj }} Server の表を構成する必要がある DB2 データベースの IP アドレスまたはホスト | 現在、DB2 のみがサポートされています。 |
|  | db2Port | DB2 データベースがセットアップされているポート |  |
|  | db2Database | DB2 内に事前構成されているデータベースの名前 |  |
|  | db2Username | DB2 データベースにアクセスするための DB2 ユーザー名 | ユーザーには、表を作成するための権限と、スキーマがまだ存在しない場合、スキーマを作成するための権限が必要です。 |
|  | db2Password | 指定されたデータベースの DB2 パスワード  |  |
|  | db2Schema | 作成するサーバー DB2 スキーマ |  |
|  | db2ConnectionIsSSL | DB2 接続タイプ | データベース接続が **http** と **https** のいずれであるかを指定します。 デフォルト値は **false** (http) です。<br/>DB2 ポートも同じ接続モード用に構成されていることを確認してください。 |
| existingMobileFirstAnalytics | analyticsEndPoint | Analytics Server の URL | 例: `http://9.9.9.9:30400`<br/> コンソールへのパスは指定しないでください。これはデプロイメント時に追加されます。
 |
|  | analyticsAdminUser | Analytics 管理ユーザーのユーザー名 |  |
|  | analyticsAdminPassword | Analytics 管理ユーザーのパスワード |  |
| keystores | keystoresSecretName | 鍵ストアとそのパスワードを設定した秘密を作成するステップを説明している、[IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。 |  |
| jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための {{site.data.keys.prod_adj }} Server JNDI プロパティー | 名前値のペアをコンマで区切ります。 |
| resources | limits.cpu | 許可される CPU の最大量を記述します。 | デフォルトは **2000m**<br/>[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) をお読みください。 |
|  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **4096Mi**<br/>[Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) をお読みください。 |
|  | requests.cpu | 必要な CPU の最小量を記述します。 指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1000m** |
|  | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **2048Mi** |
| logs | consoleFormat | コンテナー・ログの出力形式を指定します。 | デフォルトは **json** |
|  | consoleLogLevel | コンテナー・ログに移動するメッセージの細分度を制御します。 | デフォルトは **info** |
|  | consoleSource | コンテナー・ログに書き込まれるソースを指定します。 複数のソースには、コンマ区切りのリストを使用します。 | デフォルトは **message**、**trace**、**accessLog**、**ffdc** |

> Kibana を使用して {{ site.data.keys.prod_adj }} ログを分析する場合のチュートリアルについては、[こちら](analyzing-mobilefirst-logs-on-icp/)を参照してください。

### Helm チャートのインストール
{: #install-hmc-icp}

#### {{ site.data.keys.mf_analytics }} のインストール
{: #install-mf-analytics}

{{site.data.keys.mf_analytics }} のインストールはオプションです。 {{site.data.keys.mf_server }} での分析を使用可能にする場合は、{{site.data.keys.mf_server }} をインストールする前に、まず {{site.data.keys.mf_analytics }} を構成してインストールする必要があります。

{{site.data.keys.mf_analytics }} チャートのインストールを開始する前に、**永続ボリューム**を構成します。 {{ site.data.keys.mf_analytics }} を構成するための**永続ボリューム**を提供します。 [IBM Cloud Kubernetes の資料](https://console.bluemix.net/docs/containers/cs_storage_file.html#file_storage)で詳述しているステップに従って、**永続ボリューム**を作成してください。

以下のステップに従って、IBM Cloud Kubernetes クラスター上に IBM {{ site.data.keys.mf_analytics }} をインストールし、構成します。

1. Kubernetes クラスターを構成するために、以下のコマンドを実行します。
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```
2. 以下のコマンドを使用して、デフォルトの Helm チャートの値を取得します。
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    {{ site.data.keys.mf_analytics }} の場合の例:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-1.0.17.tgz > values.yaml
    ```    

3. **values.yaml** を変更して、Helm チャートをデプロイするための適切な値を追加します。 [ingress](https://console.bluemix.net/docs/containers/cs_ingress.html).hostname の詳細、スケーリングなどが追加されていることを確認し、values.yaml を保存します。

4. Helm チャートをデプロイするために、以下のコマンドを実行します。
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Analytics サーバーをデプロイする場合の例:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-1.0.17.tgz
    ```    

#### {{ site.data.keys.mf_server }} のインストール
{: #install-mf-server}

{{site.data.keys.mf_server }} のインストールを開始する前に、DB2 データベースが事前構成されていることを確認してください。

以下のステップに従って、IBM Cloud Kubernetes クラスター上に IBM {{ site.data.keys.mf_server }} をインストールし、構成します。

1. Kube クラスターを構成します。
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```   

2. 以下のコマンドを使用して、デフォルトの Helm チャートの値を取得します。
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    {{ site.data.keys.mf_server }} の場合の例:
    ```bash
    helm inspect values ibm-mfpf-server-prod-1.0.17.tgz > values.yaml
    ```   

3. **values.yaml** を変更して、Helm チャートをデプロイするための適切な値を追加します。 データベース詳細、入口、スケーリングなどが追加されていることを確認し、values.yaml を保存します。

4. Helm チャートをデプロイするために、以下のコマンドを実行します。
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    サーバーをデプロイする場合の例:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-1.0.17.tgz
    ```

>**注:** AppCenter をインストールする場合、対応する Helm チャート (例えば、ibm-mfpf-appcenter-prod-1.0.17.tgz) を使用して、上記のステップに従ってください。

## インストールの検査
{: #verify-install}

{{site.data.keys.mf_analytics }} (オプション) および {{site.data.keys.mf_server }} のインストールと構成が完了したら、IBM Cloud CLI、Kubernetes CLI、および Helm コマンドを使用して、インストール済み環境およびデプロイされたポッドの状況を検査できます。

IBM Cloud CLI 資料の [CLI コマンド・リファレンス](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)、および [Helm 資料](https://docs.helm.sh/helm/) の Helm CLI を参照してください。

IBM Cloud ポータルにある IBM Cloud Kubernetes クラスターのページから、**「起動」**ボタンを使用して Kubernetes コンソールを開いて、クラスター成果物を管理できます。

## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

デプロイメントが成功すると、メモが出力としてターミナルに表示されます。 コマンドを直接実行して、*NodePort* 経由でコンソール URL にアクセスできます。

表示される Mobile Foundation サーバーのメモの例を以下に示します。

```text
The Notes displayed as follows as the result of the helm deployment
Get the Server URL by running these commands:
1. For http endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[0].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo http://$NODE_IP:$NODE_PORT/mfpconsole
2. For https endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[1].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo https://$NODE_IP:$NODE_PORT/mfpconsole
```

同様のインストール方式を使用して、IBM MobileFirst Analytics コンソール (`<protocol>://<ip_address>:<node_port>/analytics/console` を使用) や IBM Mobile Foundation Application Center コンソール (<`protocol>://<ip_address>:<node_port>/appcenter/console` を使用) にもアクセスできます。
コンソールにアクセスするための *NodePort* アプローチに加えて、サービスには、[Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html) ホスト経由でアクセスすることもできます。

以下のステップに従ってコンソールにアクセスします。

1. [IBM Cloud ダッシュボード](https://console.bluemix.net/dashboard/apps/)に移動します。
2. `Analytics/Server/AppCenter` がデプロイされた Kubernetes クラスターを選択して、**「概要」**ページを開きます。
3. 入口ホスト名の Ingress サブドメインを見つけ、以下のようにコンソールにアクセスします。
    * IBM Mobile Foundation Operations Console にアクセスする場合、以下を使用します。
     `<protocol>://<ingress-hostname>/mfpconsole`
    * IBM Mobile Foundation Analytics コンソールにアクセスする場合、以下を使用します。
     `<protocol>://<ingress-hostname>/analytics/console`
    * IBM Mobile Foundation Application Center コンソールにアクセスする場合、以下を使用します。
     `<protocol>://<ingress-hostname>/appcenter/console`

>**注:** ポート 9600 は、Kubernetes サービスで内部的に公開され、{{ site.data.keys.prod_adj }} Analytics インスタンスによってトランスポート・ポートとして使用されます。


## サンプル・アプリケーション
{: #sample-app}
IBM Cloud Kubernetes クラスターで実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## {{ site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード
{: #upgrading-mf-helm-charts}

Helm チャート/リリースをアップグレードする方法については、[バンドル製品のアップグレード](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)を参照してください。

### Helm リリース・アップグレードのサンプル・シナリオ

1. `values.yaml` の値の変更によって Helm リリースをアップグレードするには、`--set` フラグを指定した **helm upgrade** コマンドを使用します。 **-set** フラグは複数回指定できます。 コマンド・ラインで指定された右端のセットの優先順位が最も高くなります。
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. ファイル内に値を指定して Helm リリースをアップグレードするには、**-f** フラグを指定した `helm upgrade` コマンドを使用します。 **--values** フラグまたは **-f** フラグは複数回使用できます。 コマンド・ラインで指定された右端のファイルの優先順位が最も高くなります。 以下の例で、`myvalues.yaml` と `override.yaml` の両方に *Test* というキーが含まれている場合、`override.yaml` に設定された値が優先されます。
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. 最後のリリースの値を再利用し、値の一部をオーバーライドすることによって Helm リリースをアップグレードするには、以下のようなコマンドを使用できます。
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## アンインストール
{: #uninstall}
{{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。
以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。
