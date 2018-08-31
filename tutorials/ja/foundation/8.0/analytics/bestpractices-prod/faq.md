---
layout: tutorial
title: よくある質問
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

このトピックでは、{{ site.data.keys.mf_analytics_server }} に関連したよくある質問について説明します。

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	分析クラスターのシャードおよびレプリカの数はどのように設定すればいいですか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>マルチ索引 Elasticsearch クラスターでは、以下の設定が重要です。
                <ul><li>最小シャード数を、クラスター内のノード数に設定する。</li><li>シャード当たりのレプリカ数を最低限 2 に設定する。</li></ul><br/>MobileFirst Analytics v8.0 は、複数の索引を使用してイベント・データを保管します。</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. MobileFirst Analytics v8.0 で、<code>server.xml</code> の構成では 3 個のシャードが設定されていますが、Analytics オペレーション・コンソールの管理ページには 15 個を超えるシャードが表示されます。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>MobileFirst Analytics v8.0 では、Elasticsearch のデータ・ストアは複数の索引を持ちます。単一索引ベースのデータ・ストアではありません。索引は、Analytics に流入してくるイベントのタイプに基づいて動的に作成されます。したがって、エンド・ユーザーは、複数の索引について心配する必要はありません。ここでは、Elasticsearch 内部の各索引が、構成ファイルに設定されたシャード数に分割されます。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. Analytics オペレーション・コンソールでの表示が極端に遅いのですが、なぜですか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p>データ要件および顧客要件に照らして正しいハードウェアかどうかが<a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">ハードウェア・サイジング計算器</a>を使用してチェックされていることを確認してください。ハードウェア、Analytics サーバーに入ってくるデータ・イベントのタイプやサイズ、イベントの量など、いくつかの要因がシステムのパフォーマンスに影響を及ぼします。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. パージしたデータを復旧できますか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>いいえ。いったんパージしたデータを復旧することはできません。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. データ・パージの発生が TTL 値の設定に正しく対応しません。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>TTL プロパティーは、Analytics プラットフォームに存在するデータには適用されません。TTL プロパティーを設定した後でデータを追加する必要があります。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. Analytics オペレーション・コンソールにデータが何も表示されません。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>MobileFirst Server JNDI プロパティーを使用して正しい Analytics エンドポイントが構成されていることを確認してください。レンダリングされるデータに応じて日付フィルターが正しく設定されていることを確認してください。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. Elasticsearch クラスター REST API を呼び出すことができません。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>Elasticsearch REST API を呼び出すには、Analytics サーバーの <code>server.xml</code> 内でプロパティー <b>analytics/http.enabled</b> が <b>true</b> に設定されている必要があります。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	Analytics において IBM WebSphere Application Server ND (またはフル・プロファイル) と共に Open JDK を使用できますか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>いいえ。IBM WebSphere Application Server フル・プロファイルまたは Network Deployment (ND) を使用している間は、すぐに使用可能な状態で WebSphere Application Server と一緒に提供される IBM JDK を使用するようにしてください。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	<b>アプリケーション・セッション数</b>が増え始めるのはいつですか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>アプリケーションを開いた最初の時点では<b>アプリケーション・セッション数</b>はゼロです。エンド・ユーザーがモバイル・アプリケーションをバックグラウンドに移してからフォアグラウンドに戻すと、このアクションによって<b>アプリケーション・セッション数</b>が 1 に増えます。同じアクションをさらに繰り返すと、<b>アプリケーション・セッション数</b>は増え続けます。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	分析クラスター・ヘルスで「黄」と示されます。これはどういう意味ですか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>クラスター・ヘルスの「黄」は、問題ではないことがあります。ほとんどの場合、未割り当てのシャードがあるとクラスター・ヘルスは「黄」と示されます。新しいノードがクラスターに加わると、Elasticsearch は未割り当てのシャードを新しいノードに再割り振りするため、クラスター・ヘルスは「緑」になります。場合によっては、シャード数が多すぎても、どのノードにも割り当てられていないシャードが残るため、クラスター・ヘルスの状況が「黄」と示されます。クラスター内のすべてのノードがアクティブで良好に作動していること、および、シャードの状態が開始済みまたはアクティブであることを確認してください。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	Web アプリケーションにとってアプリケーション・セッション数は何を意味しますか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>Web アプリケーションの場合、アプリケーション・セッション数は、ブラウザー・セッションに基づいて増やされ、ブラウザー (アプリケーション) から MFP Server への接続に基づきます。</p>

                  <p>ブラウザーが一般ウィンドウ/タブを使用していて、サーバーへの接続を実行すると、アプリケーション・セッション数が 1 だけ増加するとしましょう。同じブラウザーでユーザーが別のタブでアプリケーションを開き、接続を実行すると、セッションは増加しません。セッションは 30 分間アクティブでないままです。再接続を再び試行すると、1 だけ増加します。</p>

                  <p>ユーザーがブラウザー・キャッシュを初期化し、接続を試行すると、デバイスは新しいものであると見なされ、デバイス数が増やされます。ブラウザーは実デバイス ID を保有していないため、オフラインのファイル/キャッシュが初期化されるまで、ブラウザー・アプリケーション用に生成される ID は 1 つになります。</p>

                  <p>これは、匿名ブラウザー・ウィンドウにも当てはまります。匿名ブラウザー・ウィンドウを使用していて、接続を試行すると、各タブからの接続に使用されるアプリケーションは新規セッションであると見なされ、セッション数が増やされます。ユーザーが 2 つの異なるブラウザーを使用していて、MFP Server に接続するためにアプリケーションにアクセスすると、デバイス数は 2 増やされます。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	Analytics ダッシュボードにある<i>アクティブ・ユーザー</i> は何を指すのですか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>アクティブ・ユーザー</i> は、アプリケーションを使用しているユーザーの数です。固有の各ユーザーが、アプリケーションを使用しているユーザーとしてカウントされます。デフォルトでは、デバイス ID が userID です。ただし、アプリケーション開発者は <code>setUserContext(userid)</code> API を使用できます。これにより、userID はアプリケーション開発者が設定する値に置き換えられます。</p>

                  <p>1 つの解決策/手段は、ユーザーが Web アプリケーションにアクセスしたときにコンピューターで固有 ID を生成し、それをカスタム・データとして送信することです。 このデータは、ユーザーがアプリケーションにアクセスし、<code>setUserContext</code> を使用して userID を設定する実際のマシン (またはコンピューター/ブラウザー) の統計情報を計算するのに使用できます。また、このデータは、カスタム・グラフを生成するためにも使用できます。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	ネイティブ・アプリケーションまたは Cordova アプリケーションにとってアプリケーション・セッション数は何を意味しますか?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>Analytics 8.0 におけるアプリケーション・セッションの計算は、それより前のバージョンの MFP Analytics とはまったく異なります。</p>

                  <p>アプリケーション・セッション数は、アプリケーションがバックグラウンドからフォアグラウンドに移されると 1 だけ増やされます。これを Cordova アプリケーションに対して有効にするには、CLIENT APP LIFECYCLE イベントを有効にする必要があります。詳しくは、<a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">ここ</a>を参照してください。</p>
            </div>
        </div>      
    </div>
</div>       
