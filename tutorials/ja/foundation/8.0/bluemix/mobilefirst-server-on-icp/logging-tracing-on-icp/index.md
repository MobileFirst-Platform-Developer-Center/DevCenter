---
layout: tutorial
title: IBM Cloud Private でのロギングとトレース
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_full }} は、エラー、警告、および通知メッセージをログ・ファイルに記録します。 ロギングの基礎となるメカニズムは、アプリケーション・サーバーによって異なります。 {{site.data.keys.prod_icp }} では、サポートされるアプリケーション・サーバーは Liberty のみです。

以下の資料で、{{ site.data.keys.prod_icp }} 上の Kubernetes クラスターで実行されている {{ site.data.keys.mf_server }} のトレースを有効にし、ログを収集する方法について説明します。


#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [ロギングおよびモニターのメカニズムの構成](#configure-log-monitor)
* [*kubectl* ログの収集](#collect-kubectl-logs)
* [IBM 提供のカスタム・スクリプトを使用したログの収集](#collect-logs-custom-script)


## 前提条件
{: #prereqs}

ログ収集およびトラブルシューティングに必要な以下のツールをインストールし、構成します。
* Docker (`docker`)
* Kubernetes CLI (`kubectl`)

{{site.data.keys.prod_icp }} 上で稼働するクラスター用の `kubectl` クライアントを構成するには、[ここ](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html)に記述されているステップに従ってください。


## ロギングおよびモニターのメカニズムの構成
{: #configure-log-monitor}

デフォルトでは、すべての {{ site.data.keys.product }} ロギングがアプリケーション・サーバー・ログ・ファイルに入ります。 Liberty で使用可能な標準ツールを使用して、{{site.data.keys.product }} サーバー・ロギングを制御できます。 詳しくは、[ロギングとモニタリングのメカニズムの構成](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)の資料を参照してください。

[ロギングとモニタリングのメカニズムの構成](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)には、ロギングを構成するために `server.xml` を更新する方法の詳細が記載されているほか、トレースの有効化に関する情報も提供されています。 トレースを選択的に有効にするには、フィルター `com.ibm.ws.logging.trace.specification` を使用します。[詳細はこちら](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html)を参照してください。 このプロパティーは、`jvm.option` から指定するか、サーバー・インスタンスの `bootstrap.properties` で指定できます。

例えば、`jvm.options` に以下のエントリーを追加すると、`com.ibm.mfp` で始まるすべてのメソッドのトレースが有効になり、トレース・レベルは *all* に設定されます。
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```
 このエントリーは、JNDI 構成を使用して設定することもできます。 詳しくは、[こちら]({{ site.baseurl }}/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server)を参照してください。


## *kubectl* ログの収集
{: #collect-kubectl-logs}

`kubectl logs` コマンドを使用すると、Kubernetes クラスター上にデプロイ済みのコンテナーに関する情報を取得できます。 例えば、以下のコマンドは、コマンドに指定されている *pod_name* を持つポッドのログを取得します。

```bash
kubectl logs po/<pod_name>
```
`kubectl logs` コマンドについて詳しくは、[Kubernetes の資料](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/)を参照してください。

## IBM 提供のカスタム・スクリプトを使用したログの収集
{: #collect-logs-custom-script}

{{site.data.keys.mf_server }} のログおよびコンテナーのログは、スクリプト [get-icp-logs.sh](get-icp-logs.sh) を使用して収集できます。 このスクリプトは、*Helm リリース名* を入力として受け取り、デプロイされているすべてのポッドのログを収集します。

このスクリプトは、以下のように実行できます。
```bash
get-icp-logs <helm_release_name> [<output_directory>] [<name_space>]
```
以下の表で、カスタム・スクリプトで使用される各パラメーターについて説明します。

| オプション | 説明 | 注釈 |
|--------|-------------|---------|
| helm_release_name | 該当する Helm チャート・インストール済み環境のリリース名 | **必須** |
| output_directory | 収集されたログが配置される出力ディレクトリー | **オプション**<br/>デフォルト: 現行作業ディレクトリーの下の **mfp-icp-logs**。 |
| name_space | 該当する Helm チャートがインストールされている名前空間 | **オプション**<br/>デフォルト: **default** |
