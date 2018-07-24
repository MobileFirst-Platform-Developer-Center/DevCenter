---
layout: tutorial
title: IBM Cloud Private 上での MobileFirst Application Center のセットアップ
breadcrumb_title: Application Center on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM {{ site.data.keys.mf_app_center }} は、エンタープライズ・アプリケーション・ストアとして使用でき、組織内のいろいろなチーム・メンバー間で情報を共有する手段となります。 {{ site.data.keys.mf_app_center_short }} の概念は、Apple の公開 App Store や Android の Play Store に似ていますが、組織内でのプライベート使用のみをターゲットとしている点が異なります。 {{site.data.keys.mf_app_center_short }} を使用することで、同じ組織内のユーザーは、モバイル・アプリケーションのリポジトリーとして機能する単一の場所からモバイル・デバイスにアプリケーションをダウンロードできます。
MobileFirst Application Center について詳しくは、[MobileFirst Application Center の資料](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)を参照してください。


#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [IBM {{ site.data.keys.mf_app_center }} パスポート・アドバンテージ・アーカイブのダウンロード](#download-the-ibm-mac-ppa-archive)
* [{{ site.data.keys.prod_icp }} での IBM {{ site.data.keys.mf_app_center }} PPA アーカイブのロード](#load-the-ibm-mfpf-appcenter-ppa-archive)
* [{{site.data.keys.mf_app_center }} の環境変数](#env-mf-appcenter)
* [{{site.data.keys.mf_app_center }} のインストールおよび構成](#configure-install-mf-appcenter-helmcharts)
* [インストールの検査](#verify-install)
* [{{site.data.keys.mf_app_center }} へのアクセス](#access-mf-appcenter-console)
* [{{site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード](#upgrading-mf-helm-charts)
* [アンインストール](#uninstall)
* [参照](#references)

## 前提条件
{: #prereqs}

{{ site.data.keys.prod_icp }} アカウントを取得し、[{{ site.data.keys.prod_icp }} の資料](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html)に従って Kubernetes クラスターをセットアップしておく必要があります。

{{ site.data.keys.prod_icp }} に {{ site.data.keys.mf_app_center }} チャートをインストールし、構成するために、事前構成されたデータベースが必要です。 {{site.data.keys.mf_app_center }} Helm チャートを構成するには、データベース情報を指定する必要があります。 {{site.data.keys.mf_app_center }} に必要な表がこのデータベース内に作成されます。

> サポートされるデータベース: DB2。

コンテナーおよびイメージを管理するために、{{site.data.keys.prod_icp }} セットアップの一環として、以下のツールをホスト・マシンにインストールする必要があります。

* Docker
* IBM Cloud CLI (`bx`)
* {{ site.data.keys.prod_icp }} (ICP) Plugin for IBM Cloud CLI (`bx pr`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

## IBM {{ site.data.keys.mf_app_center }} パスポート・アドバンテージ・アーカイブのダウンロード
{: #download-the-ibm-mac-ppa-archive}
{{ site.data.keys.mf_app_center }} のパスポート・アドバンテージ・アーカイブ (PPA) は、[ここ]()から入手できます。 {{site.data.keys.product }} の PPA アーカイブには、以下の {{site.data.keys.product }} コンポーネントの Docker イメージと Helm チャートが含まれます。
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

{{site.data.keys.mf_app_center }} の暫定修正は、[IBM Fix Central](http://www.ibm.com/support/fixcentral) から入手できます。<br/>

## {{ site.data.keys.prod_icp }} での IBM {{ site.data.keys.mf_app_center }} PPA アーカイブのロード
{: #load-the-ibm-mfpf-appcenter-ppa-archive}

{{site.data.keys.product }} の PPA アーカイブをロードする前に、Docker をセットアップする必要があります。 [こちら](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html)の説明を参照してください。

以下のステップに従って、PPA アーカイブを {{site.data.keys.prod_icp }} クラスターにロードします。

  1. IBM Cloud ICP plugin (`bx pr`) を使用してクラスターにログインします。
      >{{ site.data.keys.prod_icp }} の資料で、[CLI コマンド解説書](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html)を参照してください。

      以下に例を示します。
      ```bash
      bx pr login -a https://<ip>:<port>
      ```
      オプションで、SSL 検証をスキップする場合は、上記のコマンドでフラグ `--skip-ssl-validation` を使用します。このオプションを使用すると、クラスター・エンドポイントの `username` と `password` の入力を求めるプロンプトが出されます。 ログインに成功したら、以下のステップに進んでください。

  2. 以下のコマンドを使用して、{{ site.data.keys.product }} の PPA アーカイブをロードします。
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      {{ site.data.keys.product }} の *archive_name* は、IBM パスポート・アドバンテージからダウンロードした PPA アーカイブの名前です。

      前のステップに従い、クラスター・エンドポイントを `bx pr` のデフォルトにした場合、`--clustername` は無視できます。

  3. PPA アーカイブをロードした後、リポジトリーを同期化します。これにより、Helm チャートが**カタログ**内に確実にリストされるようになります。 これは、{{site.data.keys.prod_icp }} 管理コンソールで行うことができます。<br/>
     * **「管理」>「リポジトリー」**を選択します。
     * **「リポジトリーの同期化 (Synch Repositories)」**をクリックします。

  4.  これで、Docker イメージと Helm チャートを {{ site.data.keys.prod_icp }} 管理コンソールで表示できます。<br/>
      Docker イメージを表示するには、以下のようにします。
      * **「プラットフォーム」>「イメージ」**を選択します。
      * Helm チャートが**「カタログ」**に表示されます。

  上記のステップを完了すると、アップロードされたバージョンの {{site.data.keys.prod_adj }} Helm チャートが ICP カタログに表示されます。 {{site.data.keys.mf_app_center }} は、カタログ内に **ibm-mfpf-appcenter-prod** と表示されます。

## {{ site.data.keys.mf_app_center }} の環境変数
{: #env-mf-appcenter }
以下の表に、{{ site.data.keys.prod_icp }} 上の {{ site.data.keys.mf_app_center }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| arch |  | ワーカー・ノード・アーキテクチャー | このチャートのデプロイ先となるワーカー・ノード・アーキテクチャー。現在、**AMD64** プラットフォームのみがサポートされています。 |
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | name | Docker イメージ名 | {{ site.data.keys.mf_app_center }} Docker イメージの名前。 |
|  | tag | Docker イメージ・タグ | [Docker タグの説明](https://docs.docker.com/engine/reference/commandline/image_tag/)を参照 |
| mobileFirstAppCenterConsole | user | {{site.data.keys.mf_app_center }} コンソールのユーザー名 |  |
|  | password | {{site.data.keys.mf_app_center }} コンソールのパスワード |  |
| existingDB2Details | appCenterDB2Host | {{site.data.keys.mf_app_center_short }} データベースが構成される DB2 サーバーの IP アドレス |  |
|  | appCenterDB2Port | セットアップされている DB2 データベースのポート |  |
|  | appCenterDB2Database | 使用するデータベースの名前 | データベースは事前に作成する必要があります。 |
|  | appCenterDB2Username | DB2 データベースにアクセスするための DB2 ユーザー名 | ユーザーには、表を作成するための権限と、スキーマがまだ存在しない場合、スキーマを作成するための権限が必要です。 |
|  | appCenterDB2Password | 指定されたデータベースの DB2 パスワード |  |
|  | appCenterDB2Schema | 作成する {{site.data.keys.mf_app_center_short }} DB2 スキーマ  |  |
|  | appCenterDB2ConnectionIsSSL | DB2 接続タイプ | データベース接続が **http** と **https** のいずれであるかを指定します。デフォルト値は **false** (http) です。 DB2 ポートも同じ接続モード用に構成されていることを確認してください。 |
| keystores | keystoresSecretName | 鍵ストアとそのパスワードを設定した秘密を作成するステップを説明している、[IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](../#configure-install-mf-helmcharts)を参照してください。 |  |
| resources | limits.cpu | 許可される CPU の最大量 | デフォルトは **1000m**<br/>詳しくは、[ここ](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)を参照してください。 |
|  | limits.memory | 許可されるメモリーの最大量 | デフォルトは **1024Mi**<br/>詳しくは、[ここ](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)を参照してください。 |
| resources.requests | requests.cpu | 必要な CPU の最小量を記述します。指定されない場合、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1000m** |
|  | requests.memory | 必要な最小メモリーを記述します。指定されない場合、メモリーは、*limits* が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1024Mi** |

## {{site.data.keys.mf_app_center }} のインストールおよび構成
{: #configure-install-mf-appcenter-helmcharts}

{{ site.data.keys.mf_app_center }} をインストールし、構成するには、以下のものが事前に必要になります。

* [**必須**] 構成済みで使用可能な DB2 データベース。
  [{{site.data.keys.mf_server }} Helm を構成](../#install-hmc-icp)するには、データベース情報が必要です。 {{site.data.keys.mf_server }} には、スキーマと表が必要であり、それらがこのデータベースに作成されます (存在しない場合)。

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

以下のステップに従って、{{site.data.keys.prod_icp }} 管理コンソールから IBM {{ site.data.keys.mf_app_center }} をインストールし、構成します。

1. 管理コンソールで**「カタログ」**に移動します。
2. **ibm-mfpf-appcenter-prod** Helm チャートを選択します。
3. **「構成」**をクリックします。
4. 環境変数を指定します。 詳しくは、[{{ site.data.keys.mf_app_center }} の環境変数](#env-mf-appcenter)を参照してください。
5. **「インストール」**をクリックします。

## インストールの検査
{: #verify-install}

{{site.data.keys.mf_analytics }} (オプション) および {{site.data.keys.mf_server }} のインストールと構成が完了したら、以下を実行することにより、インストール済み環境およびデプロイされたポッドの状況を検査できます。

{{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。 インストール済み環境の*リリース名* をクリックします。

## {{ site.data.keys.mf_app_center }} へのアクセス
{: #access-mf-appcenter-console}

{{site.data.keys.mf_app_center }} Helm チャートが正常にインストールされたら、`<protocol>://<external_ip>:<port>/appcenterconsole` を使用してブラウザーから {{site.data.keys.mf_app_center }} コンソールにアクセスできます。

プロトコルには、**http** または **https** のいずれかを使用できます。 また、NodePort デプロイメントの場合、ポートは NodePort になることに注意してください。 インストールされた {{ site.data.keys.mf_app_center }} チャートの ip_address および NodePort を取得するには、以下のステップに従ってください。

1. {{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。
2. Helm チャート・インストール済み環境の*リリース名* をクリックします。
3. **「メモ (Notes)」**セクションを参照します。

> **注:** {{site.data.keys.mf_app_center }} モバイル・クライアントにアクセスするには、パスポート・アドバンテージから Application Center パッケージをダウンロードしてください。 [詳細はこちら](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/mobile-client/)。

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
{{ site.data.keys.mf_app_center }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。
以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。

## 参照
{: #references}

{{ site.data.keys.mf_app_center }} について詳しくは、[ここ](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)を参照してください。
