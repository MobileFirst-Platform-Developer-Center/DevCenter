---
layout: tutorial
title: IBM Cloud Private での MobileFirst ログ・メッセージの分析
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.prod_icp }} の{{ site.data.keys.prod_adj }}デプロイメントでは、コンソールで JSON 形式のロギングを使用して基になる Liberty を実行すると、ログ・イベントをフィールドに分割して Elasticsearch に保管することができます。 Kibana を使用して、ダッシュボードと検索で複数の Liberty ポッドをモニターしたり、照会を使用して大量のログ・レコードをフィルター処理したりできます。

Kubernetes デプロイメントは、コンテナーで構成されるポッドから成ります。 {{ site.data.keys.prod_icp }} では、各ポッドのコンソール出力は、自動的に組み込みのエラスティック・ロギング・スタックに転送されます。 エラスティック・ロギングについて詳しくは、[{{ site.data.keys.prod_icp }} ロギング](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html)を参照してください。


## 手順
{: #procedure}

{{ site.data.keys.prod_icp }} カタログを参照し、アプリケーションのデプロイに使用する適切な Helm チャートを選択する手順を完了します。

1.  Helm チャートで JSON ロギングを使用可能にします。

      a.  {{ site.data.keys.prod_icp }} コンソールで、**「メニュー」 > 「カタログ」**をクリックします。<br/>
      b.  **「ログ (Logs)」**セクションで、**ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod** Helm チャートを選択します。<br/>
          **注:** コンソールにアクセスしたときに、この Helm チャートが Helm カタログに含まれていない場合は、**「管理 (Manage)」 > 「Helm リポジトリー (Helm Repositories)」**を選択し、リポジトリーを同期するボタンをクリックしてカタログを最新表示します。


      c.  「ロギング (Logging)」のフィールドを以下のデフォルト値に設定するか、または{{ site.data.keys.prod_adj }} Helm チャートをデプロイするときに、コマンド・ラインで `--set` フラグを使用して、前の値を設定することができます。<br/>
      <p><b>Helm チャートのフィールドと、JSON ロギングの値</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>GUI のフィールド名</th>
            <th> コマンド・ラインのフィールド名</th>
            <th>フィールド値</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>コンソールのロギング形式 </td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>コンソールのロギング・レベル</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>コンソールのロギング・ソース</td>
            <td>logs.consoleLogLevel</td>
            <td>message、trace、accessLog、ffdc<br/><br/>サポートされるソース・タイプ: messages、traces、accessLog、ffdc  <br/>コンソールのロギング・ソースで、各ソース・タイプをコンマ区切りのリストで指定します。 <br/>accessLog を使用するには、<code>server.xml</code> ファイルに追加の設定が必要です。 <br/>詳しくは、<a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">HTTP アクセス・ロギング</a>を参照してください。</td>
          </tr>
        </tbody>
      </table>
2.  Kibana をデプロイします。<br/>
    JSON ロギングを使用可能にして Liberty をデプロイすると、ログ・レコードは Elasticsearch に保管され、Kibana を使用してログ・レコードを表示できます。<br/>

      a.  Kibana をデプロイするには、コンソールで、**「カタログ」 > 「Helm チャート」**をクリックします。<br/>
      b.  **ibm-icplogging-kibana** Helm チャートを選択し、ターゲットの名前空間で**「kube-system」**をクリックします。<br/>
      c.  **「インストール」**をクリックします。<br/>

3.  Kibana を開きます。<br/>

      a.  コンソールで、**「ネットワーク・アクセス (Network Access)」 > 「サービス (Services)」**をクリックします。<br/>
      b.  サービスのリストから**「Kibana」**を選択します。<br/>
      c.  **「ノード・ポート (Node port)」**フィールドの中にあるリンクをクリックして、Kibana を開きます。<br/>

4.  Kibana での索引パターンを作成します。<br/>

      a.  Kibana から、**「管理」 > 「索引パターン (Index Patterns)」**をクリックします。 索引名またはパターンに「`logstash-*`」を入力します。<br/>
      b.  *「時間フィルター (Time Filter)」*フィールド名として**「ibm_datetime」**を選択します。<br/>
      c.  **「作成」**をクリックします。<br/>

5. 独自の照会を作成したり、視覚化したり、ダッシュボードを作成したりして、ログ・データを分析することができます。

6. [こちら](https://github.com/WASdev/sample.dashboards)から、サンプル・ダッシュボードのセットをダウンロードします。 ダッシュボードを Kibana にインポートするには、**「管理」 > 「保存されたオブジェクト (Saved Objects)」**を選択して、**「インポート (Import)」**をクリックします。

## 発展的なチュートリアル
{: #further_reading}

* [{{ site.data.keys.prod_icp }} での Liberty ロギング](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
