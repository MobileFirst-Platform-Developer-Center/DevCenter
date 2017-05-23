---
layout: tutorial
title: ログとトレースの収集
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説 
{: #overview }
IBM Containers for Bluemix では、コンテナーの CPU、メモリー、およびネットワーキングに関連したロギングおよびモニター用の組み込み機能がいくつか提供されています。 オプションで、{{site.data.keys.product_adj }} コンテナーのログ・レベルを変更できます。

{{site.data.keys.mf_server }} コンテナーおよび {{site.data.keys.mf_analytics }} コンテナーのログ・ファイルを作成するオプションは、(レベル `*=info` を使用して) デフォルトで有効になっています。ログ・レベルは、手動でコード・オーバーライドを追加するか、特定のスクリプト・ファイルを使用してコードを注入することにより変更できます。コンテナーのログとサーバーまたはランタイムのログはどちらも、Kibana 可視化ツールを使用して Bluemix logmet コンソールから表示できます。モニターは、オープン・ソースのメトリック・ダッシュボードおよびグラフ・エディターである Grafana を使用して、Bluemix logmet コンソールから実行できます。

{{site.data.keys.product_adj }} コンテナーがセキュア・シェル (SSH) 鍵を有効にして作成され、パブリック IP アドレスにバインドされている場合は、適切な秘密鍵を使用して、コンテナー・インスタンスのログを安全に表示できます。

### ロギングのオーバーライド
{: #logging-overrides }
ログ・レベルは、手動でコード・オーバーライドを追加するか、特定のスクリプト・ファイルを使用してコードを注入することにより変更できます。ログ・レベルを変更するための、手動でのコード・オーバーライドの追加は、最初にイメージを準備しているときに行う必要があります。新しいロギング構成を、別個の構成スニペットとして **package\_root/mfpf-[analytics|server]/usr/config** フォルダーに追加する必要があります。それが、Liberty サーバー上の configDropins/overrides フォルダーにコピーされます。

ログ・レベルを変更するための、特定のスクリプト・ファイルを使用したコードの注入は、V8.0.0 パッケージで提供されている start\*.sh スクリプト・ファイル (**startserver.sh**、 **startanalytics.sh**、**startservergroup.sh**、**startanalyticsgroup.sh**) のいずれかの実行時に、特定のコマンド・ライン引数を使用することにより達成できます。以下に示す、オプションのコマンド・ライン引数を適用できます。

* `[-tr|--trace]` trace_specification
* `[-ml|--maxlog]` maximum\_number\_of\_log\_files
* `[-ms|--maxlogsize]` maximum\_size\_of\_log\_files

## コンテナー・ログ・ファイル
{: #container-log-files }
ログ・ファイルは、各コンテナー・インスタンスの {{site.data.keys.mf_server }} および Liberty Profile のランタイム・アクティビティーに関して生成され、以下の場所にあります。

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

ログ・ファイルへのアクセスに示された手順に従ってコンテナーにログインし、ログ・ファイルにアクセスすることができます。

コンテナーが存在しなくなった後もログ・ファイルを永続させるには、ボリュームを有効にします。(デフォルトでは、ボリュームは有効になりません。)
ボリュームを有効にすると、logmet インターフェース (https://logmet.ng.bluemix.net/kibana など) を使用して、Bluemix からログを表示することもできます。

**ボリュームの有効化**
ボリュームを使用すると、コンテナーはログ・ファイルを永続化できるようになります。{{site.data.keys.mf_server }} コンテナーおよび {{site.data.keys.mf_analyics }} コンテナーのログ用のボリュームは、デフォルトでは有効になりません。

**start*.sh** スクリプトの実行時に、
`ENABLE_VOLUME [-v | --volume]` を `Y` に設定することにより、ボリュームを有効に設定できます。また、スクリプトの対話式実行の場合、これは **args/startserver.properties** ファイルおよび **args/startanalytics.properties** ファイルでも構成可能です。

永続化されたログ・ファイルは、コンテナーの **/var/log/rsyslog** フォルダーと **/opt/ibm/wlp/usr/servers/mfp/logs** フォルダーに保存されます。  
コンテナーに対して SSH 要求を出すことによって、ログにアクセスできます。

## ログ・ファイルへのアクセス
{: #accessing-log-files }
コンテナー・インスタンスごとに、ログが作成されます。ログ・ファイルにアクセスするには、IBM Container Cloud Service REST API を使用するか、`cf ic` コマンドを使用するか、または Bluemix logmet コンソールを使用します。

### IBM Container Cloud Service REST API
{: #ibm-container-cloud-service-rest-api }
すべてのコンテナー・インスタンスについて、 [Bluemix logmet サービス](https://logmet.ng.bluemix.net/kibana/) (https://logmet.ng.bluemix.net/kibana/) を使用して、**docker.log** および**/var/log/rsyslog/syslog** を表示できます。ログ・アクティビティーは、同じ Kibana ダッシュボードを使用して確認できます。

実行中のコンテナー・インスタンスにアクセスするには、IBM Containers CLI コマンド (`cf ic exec`) を使用します。あるいは、セキュア・シェル (SSH) を介して、コンテナーのログ・ファイルを取得することもできます。

### SSH の有効化
{: #enabling-ssh}
SSH を有効にするには、**prepareserver.sh** スクリプトまたは **prepareanalytics.sh** スクリプトを実行する前に、SSH 公開鍵を **package_root/[mfpf-server または mfpf-analytics]/usr/ssh** フォルダーにコピーします。これにより、SSH が有効にされたイメージがビルドされます。その特定のイメージから作成されたコンテナーはすべて、SSH が有効になっています。

イメージのカスタマイズの一環として SSH が有効にされない場合は、**startserver.sh** スクリプトまたは **startanalytics.sh** スクリプトの実行時に SSH\_ENABLE 引数と SSH\_KEY 引数を使用して、コンテナーに対して SSH を有効にすることができます。オプションとして、関連のスクリプト .properties ファイルをカスタマイズして、鍵の内容を組み込むことができます。

コンテナー・ログのエンドポイントは、コンテナー・インスタンスの指定の ID を使用して、stdout ログを取得します。

例: `GET /containers/{container_id}/logs`

#### コマンド・ラインからのコンテナーへのアクセス
{: #accessing-containers-from-the-command-line }
コマンド・ラインから、実行中の {{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} のコンテナー・インスタンスにアクセスし、ログやトレースを取得できます。

1. コマンド `cf ic exec -it container_instance_id "bash"` を実行して、コンテナー・インスタンス内に対話式ターミナルを作成します。
2. ログ・ファイルまたはトレースを見つけるために、以下のコマンド例を使用します。

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp 
   container_instance@root# vi messages.log
   ```

3. ログをローカル・ワークステーションにコピーするために、以下のコマンド例を使用します。

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### SSH を使用したコンテナーへのアクセス
{: #accessing-containers-using-ssh }
セキュア・シェル (SSH) を使用して {{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} のコンテナーにアクセスすることにより、syslog および Liberty ログを取得できます。

コンテナー・グループを実行している場合は、パブリック IP アドレスを各インスタンスにバインドし、SSH を使用してログを安全に表示できます。SSH を有効にするために、**startservergroup.sh** スクリプトを実行する前に、必ず SSH 公開鍵を **mfp-server\server\ssh** フォルダーにコピーしてください。

1. コンテナーに対して SSH 要求を行います。例: `mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. ログ・ファイル・ロケーションをアーカイブします。例:

```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

ログ・アーカイブをローカル・ワークステーションにダウンロードします。例: 

```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
