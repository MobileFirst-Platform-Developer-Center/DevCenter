---
layout: tutorial
title: MobileFirst Server の更新
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM MobileFirst Platform Foundation が提供するコンポーネントはいくつかあり、それらは既にインストールされている可能性があります。

ここでは、それらのコンポーネントを更新するための依存関係について説明します。

### MobileFirst Server 管理サービス、MobileFirst オペレーション・コンソール、および MobileFirst ランタイム環境
{: #server-console }

MobileFirst Server はこれら 3 つのコンポーネントから構成されます。これらは一緒に更新する必要があります。

### Application Center
{: #appenter}

このコンポーネントのインストールはオプションです。このコンポーネントは、他のコンポーネントからは独立しています。必要な場合、他とは異なる暫定修正レベルで実行することができます。

### MobileFirst Operational Analytics
{: #analytics}

このコンポーネントのインストールはオプションです。MobileFirst コンポーネントは REST API を介して MobileFirst Operational Analytics にデータを送信します。MobileFirst Operational Analytics と MobileFirst Server の他のコンポーネントを同じ暫定修正レベルで実行することが推奨されます。


## MobileFirst Server 管理サービス、MobileFirst オペレーション・コンソール、および MobileFirst ランタイム環境の更新
{: #updating-server}

これらのコンポーネントの更新は以下の 2 つの方法で実行できます。
* サーバー構成ツールを使用する
* Ant タスクを使用する

更新手順は、初期インストール時に使用した方法によって決まります。

> **注:** Installation Manager(IM) は、アップデート/暫定修正のロールバックをサポートしていません。ただし、古い WAR ファイルがあれば、Ant またはサーバー構成ツールを使用したロールバックが可能です。

### サーバー構成ツールを使用したフィックスパックの適用
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
{{ site.data.keys.mf_server }} が構成ツールを使用してインストールされていて、構成ファイルが保持されている場合は、構成ファイルを再使用してフィックスパックまたは暫定修正を適用できます。

1. サーバー構成ツールを始動します。
    * Linux の場合、アプリケーションのショートカットから**「アプリケーション」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * Windows の場合、**「スタート」→「プログラム」→「IBM MobileFirst Platform Server」→「サーバー構成ツール」**とクリックします。
    * macOS の場合、シェル・コンソールを開きます。 **mfp\_server\_install_dir/shortcuts** に移動し、**./configuration-tool.sh** と入力します。
    * **mfp\_server\_install\_dir** ディレクトリーが、{{ site.data.keys.mf_server }} をインストールした場所です。

2. **「構成」→「デプロイ済みの WAR ファイルを置換する (Replace the deployed WAR files)」**をクリックし、フィックスパックまたは暫定修正を適用する既存の構成を選択します。


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
