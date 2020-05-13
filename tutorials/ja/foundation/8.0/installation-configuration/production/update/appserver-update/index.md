---
layout: tutorial
title: MobileFirst Server の更新
breadcrumb_title: MobileFirst Server の更新
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst Platform Foundation が提供するコンポーネントはいくつかあり、それらは既にインストールされている可能性があります。

ここでは、それらのコンポーネントを更新するための依存関係について説明します。

### MobileFirst Server 管理サービス、MobileFirst オペレーション・コンソール、および MobileFirst ランタイム環境
{: #server-console }

MobileFirst Server はこれら 3 つのコンポーネントから構成されます。 これらは一緒に更新する必要があります。

### Application Center
{: #appenter}

このコンポーネントのインストールはオプションです。 このコンポーネントは、他のコンポーネントからは独立しています。 必要な場合、他とは異なる暫定修正レベルで実行することができます。

### MobileFirst Operational Analytics
{: #analytics}

このコンポーネントのインストールはオプションです。 MobileFirst コンポーネントは REST API を介して MobileFirst Operational Analytics にデータを送信します。 MobileFirst Operational Analytics と MobileFirst Server の他のコンポーネントを同じ暫定修正レベルで実行することが推奨されます。

### MobileFirst Operational Analytics Receiver
{: #analyticsreceiver}

このコンポーネントのインストールはオプションです。 MobileFirst アプリケーションは、REST API を介して MobileFirst Operational Analytics Receiver にログ・データを送信します。MobileFirst Operational Analytics がインストールされている場合にのみ、このコンポーネントをインストールしてください。MobileFirst Operational Analytics Receiver と MobileFirst Server の他のコンポーネントを同じ暫定修正レベルで実行することが推奨されます。

## MobileFirst Server 管理サービス、MobileFirst オペレーション・コンソール、および MobileFirst ランタイム環境の更新
{: #updating-server}

これらのコンポーネントの更新は以下の 2 つの方法で実行できます。
* サーバー構成ツールを使用する
* Ant タスクを使用する

更新手順は、初期インストール時に使用した方法によって決まります。

>**注:**  MobileFirst Server を更新する前に、既存の MFP インストール・ディレクトリーをバックアップすることをお勧めします。
> これらのファイルをバックアップするときに特別な手順は不要ですが、MobileFirst Server は必ず停止してください。  そうでないと、データがバックアップの実行中に変更される可能性があり、メモリーに保管されたデータが、ファイル・システムに書き込まれない可能性があります。 データの不整合が発生しないようにするために、バックアップの開始前に MobileFirst Server を停止してください。
>
MFP は IBM Installation Manager (IM) を使用したアップデート/暫定修正のロールバックをサポートしていません。 ただし、更新前にバックアップされた MFP 関連の WAR ファイルを使用すれば、ANT タスクまたはサーバー構成ツール (SCT) を使用したロールバックが可能です。
>

<!-- **Note:** Installation Manager(IM) does not support rolling back of an update/iFix. However, rollback is possible using Ant or Server Configuration Tool, if you have the old war files. -->

### サーバー構成ツールを使用したフィックスパックの適用
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
{{ site.data.keys.mf_server }} が構成ツールを使用してインストールされていて、構成ファイルが保持されている場合は、構成ファイルを再使用してフィックスパックまたは暫定修正を適用できます。

1. サーバー構成ツールを始動します。
    * Linux の場合、アプリケーションのショートカットから**「アプリケーション」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * Windows の場合、**「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * macOS の場合、シェル・コンソールを開きます。 **mfp\_server\_install_dir/shortcuts** に移動し、**./configuration-tool.sh** と入力します。
    * **mfp\_server\_install\_dir** ディレクトリーが、{{ site.data.keys.mf_server }} をインストールした場所です。

2. **「構成」→「デプロイ済みの WAR ファイルを置換する (Replace the deployed WAR files)」**をクリックし、フィックスパックまたは暫定修正を適用する既存の構成を選択します。

### サーバー構成ツールを使用したフィックスパックのロールバック
{: #rollback-a-fix-pack-by-using-the-server-configuration-tool }

MobileFirst Server がサーバー構成ツールを使用してインストールされ、構成ファイルが保持されている場合は、構成ファイルを再使用して、フィックスパックまたは暫定修正をロールバックできます。

1.  サーバー構成ツールを始動します。
    * MFP 関連の WAR ファイルを、MFP インストール・ディレクトリー (`mfp_server_install_dir/MobileFirstServer`) のバックアップされた場所からコピーして、手動で置き換えます。
    * Linux の場合、アプリケーションのショートカットから**「アプリケーション」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * Windows の場合、**「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * MacOS の場合、シェル・コンソールを開きます。 `mfp_server_install_dir/shortcuts` に移動し、`./configuration-tool.sh` と入力します。
    * `mfp_server_install_dir` ディレクトリーが、MobileFirst Server をインストールした場所です。

2.  ロールバックする必要がある構成を選択します。 **「構成」**をクリックし、**「構成の編集と再デプロイ (Edit and redeploy configuration)」**オプションを選択します。

3.  各ページで**「次へ」**をクリックしながら、最後まで全探索したら、**「更新」**をクリックします。


### Ant ファイルを使用したフィックスパックの適用
{: #applying-a-fix-pack-by-using-the-ant-files }

#### サンプル Ant ファイルを使用した更新
{: #updating-with-the-sample-ant-file }
**mfp\_install\_dir/MobileFirstServer/configuration-samples** ディレクトリー内に用意されているサンプル Ant ファイルを使用して {{ site.data.keys.mf_server }} をインストールする場合、この Ant ファイルのコピーを再使用してフィックスパックを適用することができます。 パスワードの値には、実際の値の代わりに 12 個の星印 (\*) を入力することができます。こうすると Ant ファイルの実行時に対話式にプロンプトが出されます。

1. Ant ファイルの **mfp.server.install.dir** プロパティーの値を確認します。 この値は、フィックスパックが適用された製品が含まれているディレクトリーを指している必要があります。 この値は、更新済みの {{ site.data.keys.mf_server }} WAR ファイルを取得するのに使用されます。
2. 次のコマンドを実行します。`mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### 独自の Ant ファイルを使用した更新
{: #updating-with-own-ant-file }
独自の Ant ファイルを使用する場合、それぞれのインストール・タスク (**installmobilefirstadmin**、**installmobilefirstruntime**、および **installmobilefirstpush**) に対応する、同じパラメーターを持つ更新タスクを、Ant ファイルに含めるようにしてください。 対応する更新タスクは、**updatemobilefirstadmin**、**updatemobilefirstruntime**、および **updatemobilefirstpush** です。

1. **mfp-ant-deployer.jar** ファイルの **taskdef** エレメントのクラスパスを確認します。 これは、{{ site.data.keys.mf_server }} のインストール済み環境内の、フィックスパックの適用された **mfp-ant-deployer.jar** ファイルを指している必要があります。 デフォルトでは、更新された {{ site.data.keys.mf_server }} WAR ファイルは **mfp-ant-deployer.jar** のロケーションから取得されます。
2. ご使用の Ant ファイルの更新タスク (**updatemobilefirstadmin**、**updatemobilefirstruntime**、および **updatemobilefirstpush**) を実行します。

### Ant ファイルを使用したフィックスパックのロールバック
{: #rollback-a-fix-pack-by-using-the-ant-files }

#### サンプル Ant ファイルを使用したロールバック
{: #rollback-with-the-sample-ant-file }

`mfp_install_dir/MobileFirstServer/configuration-samples` ディレクトリー内に用意されているサンプル Ant ファイルを使用して MobileFirst Server をインストールする場合、この Ant ファイルのコピーを再使用してフィックスパックをロールバックできます。 パスワードの値には、実際の値の代わりに 12 個の星印 (`*`) を入力することができます。こうすると Ant ファイルの実行時に対話式にプロンプトが出されます。

1.  MFP 関連の WAR ファイルを、MFP インストール・ディレクトリー (`mfp_server_install_dir/MobileFirstServer`) のバックアップされた場所からコピーして、手動で置き換えます。
2.  Ant ファイルの **mfp.server.install.dir** プロパティーの値を確認します。 この値は、更新済みの MobileFirst Server WAR ファイルを取得するのに使用されます。
3.  次のコマンドを実行します。
    ```bash
    mfp_install_dir/shortcuts/ant -f <your_ant_file update>
    ```

#### 独自の Ant ファイルを使用したロールバック
{: #rollback-with-own-ant-file }

独自の Ant ファイルを使用する場合、それぞれの更新/ロールバック・タスク (*installmobilefirstadmin*、*installmobilefirstruntime*、および *installmobilefirstpush*) に対応する、同じパラメーターを持つ更新タスクを、Ant ファイルに含めるようにしてください。 対応する更新タスクは、*updatemobilefirstadmin*、*updatemobilefirstruntime*、および *updatemobilefirstpush* です。

1.  MFP 関連の WAR ファイルを、MFP インストール・ディレクトリー (`mfp_server_install_dir/MobileFirstServer`) のバックアップされた場所からコピーして、手動で置き換えます。
2.  **mfp-ant-deployer.jar** ファイルの `taskdef` エレメントのクラスパスを確認します。 これは、MobileFirst Server のインストール済み環境内の、フィックスパックの適用された mfp-ant-deployer.jar ファイルを指している必要があります。 デフォルトでは、更新された MobileFirst Server WAR ファイルは、mfp-ant-deployer.jar の場所から取得されます。
3.  ご使用の Ant ファイルの更新タスク (*updatemobilefirstadmin*、*updatemobilefirstruntime*、および *updatemobilefirstpush*) を実行します。
