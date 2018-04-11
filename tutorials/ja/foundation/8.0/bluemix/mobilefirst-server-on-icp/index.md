---
layout: tutorial
title: IBM Cloud Private 上での MobileFirst Server のセットアップ
breadcrumb_title: Mobile Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
下記の説明に従って、{{ site.data.keys.prod_icp }} 上で {{ site.data.keys.mf_server }} インスタンスおよび {{ site.data.keys.mf_analytics }} インスタンスを構成します。

* IBM Cloud Private Kubernetes クラスターをセットアップします。
* 必要なツール (Docker、IBM Cloud CLI (bx)、{{ site.data.keys.prod_icp }} (icp) Plugin for IBM Cloud CLI (bx pr)、Kubernetes CLI (kubectl)、および Helm CLI (helm)) を使用して、ホスト・コンピューターをセットアップします。
* {{ site.data.keys.prod_icp }} 用の {{ site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA アーカイブ) をダウンロードします。
* PPA アーカイブを {{site.data.keys.prod_icp }} クラスターにロードします。
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

{{ site.data.keys.prod_icp }} アカウントを取得し、[{{ site.data.keys.prod_icp }} クラスター・インストール](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html)の資料に従って Kubernetes クラスターをセットアップしておく必要があります。

コンテナーおよびイメージを管理するために、{{site.data.keys.prod_icp }} セットアップの一環として、以下のツールをホスト・マシンにインストールする必要があります。

* Docker
* IBM Cloud CLI (`bx`)
* {{ site.data.keys.prod_icp }} (ICP) Plugin for IBM Cloud CLI (`bx pr`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

CLI を使用して {{site.data.keys.prod_icp }} クラスターにアクセスするために、*kubectl* クライアントを構成する必要があります。[詳細はこちら](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html)。

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード
{: #download-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA) は、[ここ](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)から入手できます。{{site.data.keys.product }} の PPA アーカイブには、以下の {{site.data.keys.product }} コンポーネントの Docker イメージと Helm チャートが含まれます。
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード
{: #load-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product }} の PPA アーカイブをロードする前に、Docker をセットアップする必要があります。[こちら](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html)の説明を参照してください。

以下のステップに従って、PPA アーカイブを {{site.data.keys.prod_icp }} クラスターにロードします。

  1. IBM Cloud ICP Plugin (`bx pr`) を使用してクラスターにログインします。
      >{{ site.data.keys.prod_icp }} の資料で、[CLI コマンド解説書](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html)を参照してください。

      以下に例を示します。
      ```bash
      bx pr login -a https://ip:port
      ```
      オプションで、SSL 検証をスキップする場合は、上記のコマンドでフラグ `--skip-ssl-validation` を使用します。このオプションを使用すると、クラスター・エンドポイントの `username` と `password` の入力を求めるプロンプトが出されます。ログインに成功したら、以下のステップに進んでください。

  2. 以下のコマンドを使用して、{{site.data.keys.product }} の PPA アーカイブをロードします。
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      {{ site.data.keys.product }} の *archive_name* は、IBM パスポート・アドバンテージからダウンロードした PPA アーカイブの名前です。

      前のステップに従い、クラスター・エンドポイントを `bx pr` のデフォルトにした場合、`--clustername` は無視できます。

  3. PPA アーカイブをロードした後、リポジトリーを同期化します。これにより、**カタログ**内に確実に Helm チャートがリストされるようになります。これは、{{site.data.keys.prod_icp }} 管理コンソールで行うことができます。
      * **「管理」>「リポジトリー」**を選択します。
      * **「リポジトリーの同期化 (Synch Repositories)」**をクリックします。

  4.  {{site.data.keys.prod_icp }} 管理コンソールで、Docker イメージおよび Helm チャートを表示します。
      Docker イメージを表示するには、以下のようにします。
      * **「プラットフォーム」>「イメージ」**を選択します。
      * Helm チャートが**「カタログ」**に表示されます。

  上記のステップを完了すると、アップロードされたバージョンの {{site.data.keys.prod_adj }} Helm チャートが ICP カタログに表示されます。{{site.data.keys.mf_server }} は、**ibm-mfpf-server-prod** としてリストされ、{{site.data.keys.mf_analytics }} は、**ibm-mfpf-analytics-prod** としてリストされます。

## IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成
{: #configure-install-mf-helmcharts}

{{site.data.keys.mf_server }} をインストールし、構成するには、以下のものが事前に必要になります。

* [**必須**] 構成済みで使用可能な DB2 データベース。
  [{{site.data.keys.mf_server }} Helm を構成](#install-hmc-icp)するには、データベース情報が必要です。{{site.data.keys.mf_server }} には、スキーマと表が必要であり、それらがこのデータベースに作成されます (存在しない場合)。

* [**オプション**] 鍵ストアとトラストストアが設定された秘密。
  独自の鍵ストアとトラストストアを設定した秘密を作成することにより、独自の鍵ストアとトラストストアをデプロイメントに提供できます。

  インストールの前に、以下のステップを実行してください。

  * `keystore.jks`、`keystore-password.txt`、`truststore.jks`、`truststore-password.txt` を使用して秘密を作成し、秘密の名前を *keystores.keystoresSecretName* フィールドに指定します。

  * `keystore.jks` ファイルとそのパスワードを `keystore-password.txt` というファイル内に保持し、`truststore.jks` ファイルとそのパスワードを `truststore-password.jks` というファイル内に保持します。

  * コマンド・ラインに移動し、以下を実行します。
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**注:** ファイルの名前は、前述したとおり、`keystore.jks`、`keystore-password.txt`、`truststore.jks`、および `truststore-password.txt` でなければなりません。

  * 秘密の名前を *keystoresSecretName* に指定して、デフォルトの鍵ストアをオーバーライドします。

  詳しくは、[MobileFirst Server 鍵ストアの構成]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。  

### {{ site.data.keys.mf_analytics }} の環境変数
{: #env-mf-analytics }
以下の表に、{{ site.data.keys.prod_icp }} 上の {{ site.data.keys.mf_analytics }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー| このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。|
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
|  | name | Docker イメージ名 | {{ site.data.keys.prod_adj }} Operational Analytics Docker イメージの名前。 |
| scaling | replicaCount | 作成する必要がある {{site.data.keys.prod_adj }} Operational Analytics のインスタンス (ポッド) の数 | 正整数<br/>デフォルトは **2** |
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
|  | requests.cpu | 必要な CPU の最小量を記述します。指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。| デフォルトは **1000m** |
|  | requests.memory | 必要なメモリーの最小量を記述します。指定されない場合、メモリー量は、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。| デフォルトは **2048Mi** |
| persistence | existingClaimName | 既存の永続ボリューム要求 (PVC) の名前  |  |


### {{ site.data.keys.mf_server }} の環境変数
{: #env-mf-server }
以下の表に、{{ site.data.keys.prod_icp }} 上の {{ site.data.keys.mf_server }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー| このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。<br/>現在、**AMD64** プラットフォームのみがサポートされています。|
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
|  | name | Docker イメージ名 | {{site.data.keys.prod_adj }} Server Docker イメージの名前。 |
| scaling | replicaCount | 作成する必要がある {{site.data.keys.prod_adj }} Server のインスタンス (ポッド) の数 | 正整数<br/>デフォルトは **3** |
| mobileFirstOperationsConsole | ユーザー | {{site.data.keys.prod_adj }} サーバーのユーザー名 | デフォルトは **admin** |
|  | password | {{site.data.keys.prod_adj }} Server のユーザーのパスワード | デフォルトは **admin** |
| existingDB2Details | db2Host | {{site.data.keys.prod_adj }} Server の表を構成する必要がある DB2 データベースの IP アドレスまたはホスト | 現在、DB2 のみがサポートされています。 |
|  | db2Port | DB2 データベースがセットアップされているポート |  |
|  | db2Database | DB2 内に事前構成されているデータベースの名前 |  |
|  | db2Username | DB2 データベースにアクセスするための DB2 ユーザー名 | ユーザーには、表を作成するための権限と、スキーマがまだ存在しない場合、スキーマを作成するための権限が必要です。 |
|  | db2Password | 指定されたデータベースの DB2 パスワード  |  |
|  | db2Schema | 作成するサーバー DB2 スキーマ |  |
|  | db2ConnectionIsSSL | DB2 接続タイプ | データベース接続が **http** と **https** のいずれであるかを指定します。デフォルト値は **false** (http) です。<br/>DB2 ポートも同じ接続モード用に構成されていることを確認してください。 |
| existingMobileFirstAnalytics | analyticsEndPoint | Analytics Server の URL | 例: `http://9.9.9.9:30400`。<br/> コンソールへのパスは指定しないでください。これはデプロイメント時に追加されます。
 |
|  | analyticsAdminUser | Analytics 管理ユーザーのユーザー名 |  |
|  | analyticsAdminPassword | Analytics 管理ユーザーのパスワード |  |
| keystores | keystoresSecretName | 鍵ストアとそのパスワードを設定した秘密を作成するステップを説明している、[IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。 |  |
| jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための {{site.data.keys.prod_adj }} Server JNDI プロパティー | 名前値のペアをコンマで区切ります。 |
| resources | limits.cpu | 許可される CPU の最大量を記述します。 | デフォルトは **2000m**<br/>[Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) をお読みください。 |
|  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **4096Mi**<br/>[Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) をお読みください。 |
|  | requests.cpu | 必要な CPU の最小量を記述します。指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。| デフォルトは **1000m** |
|  | requests.memory | 必要なメモリーの最小量を記述します。指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。| デフォルトは **2048Mi** |

### ICP カタログからの {{site.data.keys.prod_adj }} Helm チャートのインストール
{: #install-hmc-icp}

#### {{ site.data.keys.mf_analytics }} のインストール
{: #install-mf-analytics}

{{site.data.keys.mf_analytics }} のインストールはオプションです。{{site.data.keys.mf_server }} での分析を使用可能にする場合は、{{site.data.keys.mf_server }} をインストールする前に、まず {{site.data.keys.mf_analytics }} を構成してインストールする必要があります。

{{site.data.keys.mf_analytics }} チャートのインストールを開始する前に、**永続ボリューム**を構成します。{{ site.data.keys.mf_analytics }} を構成するための**永続ボリューム**を提供します。[{{site.data.keys.prod_icp }} の資料](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/create_volume.html)で詳述しているステップに従って、**永続ボリューム**を作成してください。

以下のステップに従って、{{site.data.keys.prod_icp }} 管理コンソールから IBM {{site.data.keys.mf_analytics }} をインストールし、構成します。

1. 管理コンソールで**「カタログ」**に移動します。
2. **ibm-mfpf-analytics-prod** Helm チャートを選択します。
3. **「構成」**をクリックします。
4. 環境変数を指定します。詳しくは、[{{site.data.keys.mf_analytics }} の環境変数](#env-mf-analytics)を参照してください。
5. **「ご使用条件 (License Agreement)」**に同意します。
6. **「インストール」**をクリックします。

#### {{ site.data.keys.mf_server }} のインストール
{: #install-mf-server}

{{site.data.keys.mf_server }} のインストールを開始する前に、DB2 データベースが事前構成されていることを確認してください。


以下のステップに従って、{{site.data.keys.prod_icp }} 管理コンソールから IBM {{ site.data.keys.mf_server }} をインストールし、構成します。

1. 管理コンソールで**「カタログ」**に移動します。
2. **ibm-mfpf-server-prod** Helm チャートを選択します。
3. **「構成」**をクリックします。
4. 環境変数を指定します。詳しくは、[{{site.data.keys.mf_server }} の環境変数](#env-mf-server)を参照してください。
5. **「ご使用条件 (License Agreement)」**に同意します。
6. **「インストール」**をクリックします。

## インストールの検査
{: #verify-install}

{{site.data.keys.mf_analytics }} (オプション) および {{site.data.keys.mf_server }} のインストールと構成が完了したら、以下を実行することにより、インストール済み環境およびデプロイされたポッドの状況を検査できます。

{{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。インストール済み環境の*リリース名* をクリックします。


## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

インストールが成功したら、`<protocol>://<ip_address>:<port>/mfpconsole` を使用して、IBM {{ site.data.keys.prod_adj }} Operations Console にアクセスできます。
IBM {{ site.data.keys.mf_analytics }} Console には、`<protocol>://<ip_address>:<port>/analytics/console` を使用してアクセスできます。

プロトコルには、`http` または `https` を使用できます。また、**NodePort** デプロイメントの場合、ポートは **NodePort** になることに注意してください。インストールされた {{site.data.keys.prod_adj }} チャートの ip_address および **NodePort** を取得するには、以下のステップに従ってください。

1. {{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。
2. Helm チャート・インストール済み環境の*リリース名* をクリックします。
3. **「メモ (Notes)」**セクションを参照します。

>**注:** ポート 9600 は、Kubernetes サービスで内部的に公開され、{{ site.data.keys.prod_adj }} Analytics インスタンスによってトランスポート・ポートとして使用されます。


## サンプル・アプリケーション
{: #sample-app}
{{ site.data.keys.prod_icp }} で実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## {{ site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード
{: #upgrading-mf-helm-charts}

Helm チャート/リリースをアップグレードする方法については、[バンドル製品のアップグレード](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)を参照してください。

### Helm リリース・アップグレードのサンプル・シナリオ

1. `values.yaml` の値の変更によって Helm リリースをアップグレードするには、`--set` フラグを指定した **helm upgrade** コマンドを使用します。**-set** フラグは複数回指定できます。コマンド・ラインで指定された右端のセットの優先順位が最も高くなります。
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. ファイル内に値を指定して Helm リリースをアップグレードするには、**-f** フラグを指定した `helm upgrade` コマンドを使用します。**--values** フラグまたは **-f** フラグは複数回使用できます。コマンド・ラインで指定された右端のファイルの優先順位が最も高くなります。以下の例で、`myvalues.yaml` と `override.yaml` の両方に *Test* というキーが含まれている場合、`override.yaml` に設定された値が優先されます。
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. 最後のリリースの値を再利用し、値の一部をオーバーライドすることによって Helm リリースをアップグレードするには、以下のようなコマンドを使用できます。
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## アンインストール
{: #uninstall}
{{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。
