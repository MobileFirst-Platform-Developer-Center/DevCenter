---
layout: tutorial
title: Analytics Receiver のトラブルシューティング
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下に、{{ site.data.keys.mf_analytics_receiver }} を使用する際に発生する可能性がある問題を解決するために役立つ情報を記載しています。

<div class="panel panel-default">
  <div class="panel-heading"><h4>モバイル・アプリケーションは {{ site.data.keys.mf_analytics_receiver }} にデータを送信できませんでした
</h4></div>
  <div class="panel-body">
  <p>以下の可能性を調べてください。</p>
  <ul>
    <li>{{ site.data.keys.mf_server }} が {{ site.data.keys.mf_analytics_receiver }} の正しい値を指していることを確認します。<i>mfp.analytics.receiver.url</i> が {{ site.data.keys.mf_analytics_receiver }} 固有の REST エンドポイント (<code>http://hostip:port/analytics-receiver/rest</code>) を指していることを確認します。</li>
    <li>エンドポイント URL に完全修飾ホスト名が含まれていることも確認してください。含まれていない場合、モバイル・アプリケーションは {{ site.data.keys.mf_analytics_receiver }} と通信できず、次のエラーが発生する可能性があります。

{% highlight xml %}
外部ネットワーク・アクセスに失敗しました。応答: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=ホスト "*****" を解決できません: ホスト名に関連付けられたアドレスがありません, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> アプリを {{ site.data.keys.mf_server }} に登録し、{{ site.data.keys.mf_analytics_receiver }} 固有の REST URL と資格情報を取得します。そこで、アプリをアンインストールし、次にそのアプリをインストールして {{ site.data.keys.mf_server }} に登録し、{{ site.data.keys.mf_analytics_receiver }} 固有の詳細を取得してみてください。クライアント・ログが {{ site.data.keys.mf_analytics_receiver }} を介して正常に送信されたかどうかを確認します。</li>
    </ul>
  </div>
</div>
