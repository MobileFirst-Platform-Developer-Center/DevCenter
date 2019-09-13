---
layout: tutorial
title: MobileFirst Analytics Server 構成ガイド
breadcrumb_title: Configuration Guide
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_analytics_server }} 用のいくつかの構成が必要です。 示されているように、単一のノードに適用される構成パラメーターもあれば、クラスター全体に適用される構成パラメーターもあります。

#### ジャンプ先
{: #jump-to }

* [構成プロパティー](#configuration-properties)
* [Analytics データのバックアップ](#backing-up-analytics-data)
* [クラスター管理と Elasticsearch](#cluster-management-and-elasticsearch)

### プロパティー
{: #properties }
構成プロパティーの完全リスト、およびアプリケーション・サーバーでの設定方法については、[構成プロパティー](#configuration-properties)を参照してください。

* スプリット・ブレーン・シンドロームを回避するために、**discovery.zen.minimum\_master\_nodes** プロパティーは、**ceil((クラスター内のマスター適格ノードの数 / 2) + 1)** に設定する必要があります。
    * master-eligible である、クラスター内の Elasticsearch ノードは、どの master-eligible ノードがマスターかを判別するためにクォーラムを確立する必要があります。
    * master eligible ノードをクラスターに追加すると master-eligible ノード数が変わるため、設定も変更する必要があります。 新しい master-eligible ノードをクラスターに導入する場合、設定を変更する必要があります。 クラスターの管理方法について詳しくは、[クラスター管理と Elasticsearch](#cluster-management-and-elasticsearch) を参照してください。
* すべてのノードで **clustername** プロパティーを設定して、クラスターに名前を付けます。
    * Elasticsearch の開発者のインスタンスが、デフォルト名を使用しているクラスターに偶然加わってしまわないように、クラスターに名前を付けます。
* 各ノードで **nodename** プロパティーを設定して、各ノードに名前を付けます。
    * デフォルトで Elasticsearch は、ランダムな Marvel キャラクターの名前をとって各ノードを命名し、ノード再始動ごとにノード名が異なります。
* 各ノードで **datapath** プロパティーを設定することにより、データ・ディレクトリーへのファイル・システム・パスを明示的に宣言します。
* 各ノードで **masternodes** プロパティーを設定することにより、専用のマスター・ノードを明示的に宣言します。

### クラスターのリカバリー設定
{: #cluster-recovery-settings }
マルチノード・クラスターにスケールアウトした後、フル・クラスター再始動が時々必要になる場合があります。 フル・クラスター再始動が必要な場合は、リカバリー設定を検討する必要があります。 クラスターに 10 台のノードがあり、1 度に 1 ノードずつクラスターが起動されていくときに、マスター・ノードは、各ノードがクラスターに加わるとすぐに、データのバランシングを開始する必要があると見なします。 マスターのこのような動作が許可されると、多くの不要なリバランシングが必要になります。 最小数のノードがクラスターに加わるまで待機してから、マスターがノードへのリバランシング命令の開始を許可されるように、クラスター設定を構成する必要があります。 それにより、クラスターの再始動を、数時間から数分へと削減することができます。

* クラスターで指定数のノードが起動して加わるまで、Elasticsearch がリバランシングを開始しないようにするには、**gateway.recover\_after\_nodes** プロパティーを必要な値に設定してください。 クラスターに 10 個のノードがあれば、**gateway.recover\_after\_nodes** プロパティー値を 8 に設定すると妥当であるかもしれません。
* **gateway.expected\_nodes** プロパティーは、クラスター内に予期するノード数に設定する必要があります。 この例で、**gateway.expected_nodes** プロパティーの値は 10 です。
* マスター・ノードの始動から、設定した時間が経過するまで、リバランスした命令を送信するのを待つようにマスターに指示するために、**gateway.recover\_after\_time** プロパティーを設定する必要があります。

前の設定の組み合わせは、Elasticsearch が、**gateway.recover\_after\_nodes** 値の数のノードが稼働するまで待つことを意味します。 そして、**gateway.recover\_after\_time** 値の分数後、または **gateway.expected\_nodes** 値の数のノードがクラスターに加わった後 (いずれか早い方) に、リカバリーが開始されます。

### 留意事項
{: #what-not-to-do }
* 実動クラスターは放置しないでください。
    * クラスターには、モニターと保守が必要です。 タスク専用の有効な Elasticsearch モニター・ツールが多く使用可能です。
* **datapath** 設定に Network Attached Storage (NAS) を使用しないでください。 NAS により、待ち時間が長くなり、Single Point of Failure となってしまいます。 常にローカル・ホスト・ディスクを使用してください。
* クラスターが複数のデータ・センターに及ばないようにしてください。また、クラスターが地理的に遠距離に渡ることは必ず避けてください。 ノード間の待ち時間は、重大なパフォーマンス・ボトルネックとなります。
* 独自のクラスター構成管理ソリューションを運用してください。 Puppet、Chef、Ansible など、多くの有効な構成管理ソリューションが利用可能です。

## 構成プロパティー
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }} は、追加の構成をしなくても正常に開始できます。

構成は、JNDI プロパティーを通じて {{ site.data.keys.mf_server }} と {{ site.data.keys.mf_analytics_server }} の両方で行われます。 さらに、{{ site.data.keys.mf_analytics_server }} では、構成を制御するための環境変数の使用をサポートします。 環境変数は、JNDI プロパティーより優先されます。

これらのプロパティーの変更を有効にするには、分析ランタイム Web アプリケーションを再始動する必要があります。 アプリケーション・サーバー全体を再始動する必要はありません。

WebSphere Application Server Liberty で JNDI プロパティーを設定するには、**server.xml** ファイルに以下のようにタグを追加します。

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Tomcat で JNDI プロパティーを設定するには、context.xml ファイルに以下のようにタグを追加します。

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

WebSphere Application Server の JNDI プロパティーは、環境変数として確認できます。

* WebSphere Application Server コンソールで、**「アプリケーション」→「アプリケーション・タイプ」→「WebSphere エンタープライズ・アプリケーション」**を選択します。
* **{{ site.data.keys.product_adj }} 管理サービス**・アプリケーションを選択します。
* **「Web モジュール・プロパティー」**で**「Web モジュールの環境項目」**をクリックして、JNDI プロパティーを表示します。

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
以下の表は、{{ site.data.keys.mf_server }} で設定可能なプロパティーを示しています。

| プロパティー                           | 説明                                           | デフォルト値 |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | このプロパティーには、{{ site.data.keys.mf_analytics_console }} の URL を設定します。 例えば、http://hostname:port/analytics/console などです。 このプロパティーを設定すると、{{ site.data.keys.mf_console }} で分析アイコンが有効になります。 | なし |
| mfp.analytics.logs.forward         | このプロパティーが true に設定されると、{{ site.data.keys.mf_server }} で記録されたサーバー・ログが {{ site.data.keys.mf_analytics }} でキャプチャーされます。 | true |
| mfp.analytics.url                  |必須。 着信する分析データを受け取る、{{ site.data.keys.mf_analytics_server }} により公開される URL。 例えば、http://hostname:port/analytics-service/rest/v2 などです。 | なし |
| analyticsconsole/mfp.analytics.url |	オプション。 Analytics REST サービスの絶対 URI。 ファイアウォールまたはセキュア・リバース・プロキシーが使用されるシナリオでは、この URI は、ローカル LAN の内側の内部 URI ではなく、外部 URI でなければなりません。 この値では、URI プロトコル、ホスト名、またはポートの場所に * を入れて、着信 URL の対応する部分を表すことができます。	*://*:*/analytics-service。プロトコル、ホスト名、およびポートは動的に決定されます。 |
| mfp.analytics.username             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名。 | なし |
| mfp.analytics.password             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるパスワード。 | なし |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
以下の表は、{{ site.data.keys.mf_analytics_server }} で設定可能なプロパティーを示しています。

| プロパティー                           | 説明                                           | デフォルト値 |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Elasticsearch ノード・タイプを定義します。 有効値は master および data です。 このプロパティーが設定されていない場合、ノードはマスター適格ノードとデータ・ノードとして動作します。 | 	なし |
| analytics/shards | 索引当たりのシャードの数。 この値は、クラスターで開始された最初のノードでしか設定できず、変更不可です。 | 1 |
| analytics/replicas_per_shard | クラスターのシャードごとのレプリカの数。 この値は、実行中のクラスターで動的に変更可能です。 | 0 |
| analytics/masternodes | マスター適格ノードのホスト名とポートを含むコンマ区切りのストリング。 | なし |
| analytics/clustername | クラスターの名前。 同じサブセットで動作する複数のクラスターを設定する予定で、それらを一意的に識別する必要がある場合は、この値を設定します。 | worklight |
| analytics/nodename | クラスター内のノードの名前。 | ランダムに生成されたストリング
| analytics/datapath | ファイル・システムで分析データが保存されるパス。 | ./analyticsData |
| analytics/settingspath | Elasticsearch 設定ファイルのパス。 詳しくは、Elasticsearch を参照してください。 | なし |
| analytics/transportport | ノード間の通信に使用されるポート。 | 9600 |
| analytics/httpport | Elasticsearch への HTTP 通信に使用されるポート。 | 9500 |
| analytics/http.enabled | Elasticsearch への HTTP 通信を使用可能または使用不可にします。 | false |
| analytics/serviceProxyURL | 分析 UI WAR ファイルと分析サービス WAR ファイルをインストールして、アプリケーション・サーバーを分けることができます。 これを行う場合は、UI WAR ファイルの JavaScript ランタイムが、ブラウザーのクロスサイト・スクリプティング防御によってブロックされる可能性があることを考慮する必要があります。 このブロックを迂回するために、UI WAR ファイルには、JavaScript ランタイムがオリジン・サーバーから REST API 応答を取得するための Java プロキシー・コードが含まれます。 しかし、プロキシーは、REST API 要求を分析サービス WAR ファイルに転送するように構成されています。 WAR ファイルをインストールしてアプリケーション・サーバーを分けた場合に、このプロパティーを構成してください。 | なし |
| analytics/bootstrap.mlockall | このプロパティーは、Elasticsearch メモリーがディスクにスワップされるのを防ぎます。 | true |
| analytics/multicast | マルチキャスト・ノード・ディスカバリーを使用可能または使用不可にします。 | false |
| analytics/warmupFrequencyInSeconds | ウォームアップ照会が実行される頻度。 ウォームアップ照会はバックグラウンドで実行され、照会結果をメモリーに入れさせるため、Web コンソールのパフォーマンスが向上します。 負の値が指定された場合、ウォームアップ照会は使用不可になります。 | 600 |
| analytics/tenant | 主要な Elasticsearch 索引の名前。	worklight |

キーにピリオドが含まれない (例えば、**http.enabled** ではなく **httpport**) 場合はすべて、変数名に接頭部 **ANALYTICS_** が付いたシステム環境変数が設定を制御できます。 JNDI プロパティーとシステム環境変数の両方が設定されると、システム環境変数が優先されます。 例えば、JNDI プロパティー **analytics/httpport** とシステム環境変数 **ANALTYICS_httpport** の両方を設定した場合、 **ANALYTICS_httpport** の値が使用されます。

> **重要**: 現在、MobileFirst Analytics v8.0 ではマルチテナンシーはサポートされていません。 MobileFirst Server からのイベントはデフォルトで、単一のテナント・アーキテクチャーに送信されます。

#### ドキュメントの存続時間 (TTL)
{: #document-time-to-live-ttl }
TTL は実際上、データ保存ポリシーの設定および保守方法です。 この決定は、システム・リソースのニーズに劇的な影響をもたらします。 データを長く保持するほど、必要な RAM、ディスク、スケーリングは増える可能性があります。

各ドキュメント・タイプには、固有の TTL があります。 ドキュメントの TTL を設定すると、ドキュメントを一定期間保管した後、自動的に削除することができます。

各 TTL JNDI プロパティーの名前は、**analytics/TTL_[document-type]** です。 例えば、**NetworkTransaction** の TTL 設定の名前は、**analytics/TTL_NetworkTransaction** になります。

これらの値は、以下の基本時間単位を使用して設定可能です。

* 1Y = 1 年
* 1M = 1 月
* 1w = 1 週
* 1d = 1 日
* 1h = 1 時間
* 1m = 1 分
* 1s = 1 秒
* 1ms = 1 ミリ秒

サポートされる document-type は以下のとおりです。

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **注:** 以前のバージョンの {{ site.data.keys.mf_analytics_server }} からのマイグレーションを実行しており、かつ、以前に TTL JNDI プロパティーを構成したことがある場合は、[{{ site.data.keys.mf_analytics_server }}の以前のバージョンで使用されたサーバー・プロパティーのマイグレーション ](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server)を参照してください。

#### Elasticsearch
{: #elasticsearch }
{{ site.data.keys.mf_analytics_console }} の処理を行うストレージおよびクラスタリングの基盤テクノロジーは Elasticsearch です。  
Elasticsearch では、主にパフォーマンス・チューニング用に、チューナブル・プロパティーが多く用意されています。 JNDI プロパティーの多くは、Elasticsearch で提供されるプロパティーの抽象化です。

Elasticsearch により提供されるすべてのプロパティーは、プロパティー名の前に **analytics/** を付加した JNDI プロパティーを使用することでも設定できます。 例えば、**threadpool.search.queue_size** は、Elasticsearch が提供するプロパティーです。 これは、以下の JNDI プロパティーで設定できます。

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

通常、これらのプロパティーは、カスタム設定ファイルで設定されます。 Elasticsearch とそのプロパティー・ファイルのフォーマットに関する十分な知識がある場合は、以下のように **settingspath** JNDI プロパティーを使用して、設定ファイルへのパスを指定できます。

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

熟練した Elasticsearch IT 管理者である、特定の必要性が確認されている、あるいは、サービスまたはサポート・チームで指示されている場合を除き、これらの設定の調整は検討しないでください。

## Analytics データのバックアップ
{: #backing-up-analytics-data }
{{ site.data.keys.mf_analytics }} のバックアップ方法について説明します。

{{ site.data.keys.mf_analytics }} のデータは、{{ site.data.keys.mf_analytics_server }} ファイル・システム上のファイル・セットとして保管されます。 このフォルダーの場所は、{{ site.data.keys.mf_analytics_server }} 構成で datapath JNDI プロパティーによって指定されます。 JNDI プロパティーについて詳しくは、[構成プロパティー](#configuration-properties)を参照してください。

{{ site.data.keys.mf_analytics_server }} 構成もファイル・システムに保管され、その名前は server.xml です。

これらのファイルは、既に機能している既存のサーバー・バックアップ手順があれば、それを使用してバックアップすることができます。 これらのファイルをバックアップする際に特別な手順は不要ですが、{{ site.data.keys.mf_analytics_server }} は必ず停止してください。 そうでないと、データがバックアップの実行中に変更される可能性があり、メモリーに保管されたデータが、ファイル・システムに書き込まれない可能性があります。 データの不整合が発生しないようにするために、バックアップの開始前に {{ site.data.keys.mf_analytics_server }} を停止してください。

## クラスター管理と Elasticsearch
{: #cluster-management-and-elasticsearch }
クラスターを管理し、ノードを追加してメモリーとキャパシティーの負担を緩和します。

### クラスターへのノードの追加
{: #add-a-node-to-the-cluster }
クラスターに新しいノードを追加するには、{{ site.data.keys.mf_analytics_server }} をインストールするか、またはスタンドアロン Elasticsearch インスタンスを実行します。

スタンドアロン Elasticsearch インスタンスを選んだ場合は、メモリーとキャパシティーの要件に関するクラスターの負担は一部緩和されますが、データ取り込みの負担は緩和されません。 データ・レポートは、データの整合性維持と最適化のために、パーシスタント・ストアに行く前に {{ site.data.keys.mf_analytics_server }} を常に通らなければなりません。

ミックス・アンド・マッチが可能です。

基盤の Elasticsearch データ・ストアは、ノードが同種であることを予期するため、クラスター内にパワフルな 8 コア 64 GB RAM ラック・システムと、残り物の余ったノートブックを混在させないでください。 ノード間で類似したハードウェアを使用してください。

#### クラスターへの {{ site.data.keys.mf_analytics_server }}の追加
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
{{ site.data.keys.mf_analytics_server }} をクラスターに追加する方法を説明します。

Elasticsearch は {{ site.data.keys.mf_analytics_server }} に組み込まれているため、クラスターの動作を定義するには Elasticsearch セットアップを使用します。 例えば、WebSphere Application Server Liberty ファームを作成したり、他のアプリケーション・サーバーのセットアップを使用したりしないでください。

以下の手順例で、ノードをマスター・ノードにもデータ・ノードにも構成しないでください。 代わりに、Elasticsearch REST API がモニターおよび動的構成のために公開されるように一時的に稼働する目的の「検索ロード・バランサー」としてノードを構成してください。

**注:**

* 必ず、[システム要件](../installation/#system-requirements)に従って、このノードのハードウェアとオペレーティング・システムを構成してください。
* ポート 9600 は、Elasticsearch が使用する転送ポートです。 そのため、ポート 9600 は、クラスター・ノード間のどのファイアウォールも通すように開放されていなければなりません。

1. 新しく割り振られたシステム上のアプリケーション・サーバーに、分析サービス WAR ファイルと分析 UI WAR ファイル (UI が必要な場合) をインストールします。 {{ site.data.keys.mf_analytics_server }} のこのインスタンスを、サポートされる任意のアプリケーション・サーバーにインストールします。
    * [{{ site.data.keys.mf_analytics }} の WebSphere Application Server Liberty へのインストール](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [{{ site.data.keys.mf_analytics }} の Tomcat へのインストール](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [{{ site.data.keys.mf_analytics }} の WebSphere Application Server へのインストール](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. JNDI プロパティーに関するアプリケーション・サーバーの構成ファイルを編集 (またはシステム環境変数を使用) して、少なくとも以下のフラグを構成します。

    | フラグ | 値 (例) | デフォルト | 注記 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	このノードが参加するクラスター。 |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	偶発的なクラスター参加を回避するには、false に設定します。 |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	なし | 	既存クラスター内のマスター・ノードのリスト。 マスター・ノードで転送ポート設定を指定した場合は、デフォルト・ポート 9600 を変更してください。 |
    | node.master | 	false | 	true | 	このノードがマスター・ノードになれないようにします。 |
    | node.data|	false | 	true | 	このノードがデータを保管できないようにします。 |
    | http.enabled | 	true	 | true | 	Elasticsearch REST API 用に非セキュアの HTTP ポート 9200 を開きます。 |

3. 実動シナリオでは、すべての構成フラグを検討してください。 Elasticsearch が、データとは異なるファイル・システム・ディレクトリーにプラグインを保持するようにしたい場合があります。そのために、**path.plugins** フラグを設定する必要があります。
4. 必要に応じ、アプリケーション・サーバーを実行して WAR アプリケーションを開始します。
5. この新規ノードのコンソール出力を監視するか、{{ site.data.keys.mf_analytics_console }} の**「管理」**ページで**「クラスターとノード」**セクションのノード・カウントを監視することで、この新規ノードがクラスターに参加したことを確認してください。

#### クラスターへのスタンドアロン Elasticsearch ノードの追加
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
スタンドアロン Elasticsearch ノードをクラスターに追加する方法を説明します。

簡単な数個のステップで、スタンドアロン Elasticsearch ノードを既存の {{ site.data.keys.mf_analytics }} クラスターに追加することができます。 ただし、このノードのロールを決定する必要があります。 それは、マスター適格ノードになりますか? その場合には、必ずスプリット・ブレーンの問題が発生しないようにしてください。 それは、データ・ノードになりますか? それは、クライアント専用ノードになりますか? ノードを一時的に開始して、Elasticsearch の REST API を直接公開して稼働中のクラスターに動的構成変更を作用させるために、おそらくクライアント専用ノードが必要になります。

以下の手順例で、ノードをマスター・ノードにもデータ・ノードにも構成しないでください。 代わりに、Elasticsearch REST API がモニターおよび動的構成のために公開されるように一時的に稼働する目的の「検索ロード・バランサー」としてノードを構成してください。

**注:**

* 必ず、[システム要件](../installation/#system-requirements)に従って、このノードのハードウェアとオペレーティング・システムを構成してください。
* ポート 9600 は、Elasticsearch が使用する転送ポートです。 そのため、ポート 9600 は、クラスター・ノード間のどのファイアウォールも通すように開放されていなければなりません。

1. Elasticsearch を [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz) からダウンロードします。
2. ファイルを解凍します。
3. **config/elasticsearch.yml** ファイルを編集し、少なくとも以下のフラグを構成します。

    | フラグ | 値 (例) | デフォルト | 注記 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	このノードが参加するクラスター。 |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	偶発的なクラスター参加を回避するには、false に設定します。 |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	なし | 	既存クラスター内のマスター・ノードのリスト。 マスター・ノードで転送ポート設定を指定した場合は、デフォルト・ポート 9600 を変更してください。 |
    | node.master | 	false | 	true | 	このノードがマスター・ノードになれないようにします。 |
    | node.data|	false | 	true | 	このノードがデータを保管できないようにします。 |
    | http.enabled | 	true	 | true | 	Elasticsearch REST API 用に非セキュアの HTTP ポート 9200 を開きます。 |


4. 実動シナリオでは、すべての構成フラグを検討してください。 Elasticsearch が、データとは異なるファイル・システム・ディレクトリーにプラグインを保持するようにしたい場合があります。そのために、path.plugins フラグを設定する必要があります。
5. `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` を実行して、ICU プラグインをインストールします。
6. `./bin/elasticsearch` を実行します。
7. この新規ノードのコンソール出力を監視するか、{{ site.data.keys.mf_analytics_console }} の**「管理」**ページで**「クラスターとノード」**セクションのノード・カウントを監視することで、この新規ノードがクラスターに参加したことを確認してください。

#### 回路ブレーカー
{: #circuit-breakers }
Elasticsearch の回路ブレーカーについて説明します。

Elasticsearch には、操作で **OutOfMemoryError** が発生しないようにするための回路ブレーカーが複数含まれています。 例えば、{{ site.data.keys.mf_console }} にデータを提供する照会で JVM ヒープの 40 % を使用することになった場合、回路ブレーカーが起動して例外が発生し、コンソールは空のデータを受け取ります。

Elasticsearch では、ディスク満杯の防御も行われます。 Elasticsearch データ・ストアの書き込みに構成されているディスクが容量の 90 % に達すると、Elasticsearch ノードがクラスター内のマスター・ノードに通知します。 それにより、マスター・ノードは、満杯になりそうなノードを避けて、新たな文書書き込みを宛先変更します。 クラスター内にノードが 1 つしかない場合、データを書き込みできる 2 次ノードはありません。 そのため、データは書き込まれず、失われます。
