---
layout: tutorial
title: Bluemix サービス上での Mobile Foundation の使用
breadcrumb_title: Mobile Foundation サービス
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、{{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}**) サービスを使用して Bluemix 上で {{ site.data.keys.mf_server }} インスタンスをセットアップするための手順を段階的に説明します。  
{{ site.data.keys.mf_bm_short }} は、 **Liberty for Java ランタイム** 上で MobileFirst Foundation v8.0 のスケーラブルな開発者環境または実稼働環境を素早く容易に稼働できるようにする、Bluemix サービスの 1 つです。

{{ site.data.keys.mf_bm_short }} サービスには、以下のプラン・オプションがあります。

1. **開発者**: このプランでは、{{ site.data.keys.mf_server }} が Liberty for Java ランタイム上で Cloud Foundry アプリケーションとしてプロビジョンされます。このプランでは、外部データベースの使用はサポートされず、複数のノードも定義されません。このプランは*開発およびテストのみに制限されます*。サーバー・インスタンスを使用して、開発およびテスト用に任意の数のモバイル・アプリケーションを登録できます。このプランでは、デフォルトで、{{ site.data.keys.mf_analytics_service }} サービスが追加されます。

    > **注:** 「開発者」プランでは、永続的なデータベースは提供されません。したがって、[トラブルシューティング・セクション](#troubleshooting)にある説明のとおりに、必ず構成をバックアップしてください。

2. **開発者商用**: このプランでは {{ site.data.keys.mf_server }} が Liberty for Java ランタイム上で Cloud Foundry アプリケーションとしてプロビジョンされます。ユーザーは、このプランを使用することで任意の数のモバイル・アプリケーションを開発およびテストできます。このプランでは、**dashDB OLTPサービス** の準備が整っている必要があります。dashDB サービスは別に作成され請求されます。このプランはサイズ制限があり、実動ではなく、チーム・ベースの開発アクティビティーとテスト・アクティビティーに使用することを目的としています。料金は、ご使用の環境の合計サイズによって異なります。オプションで、**「Analytics の追加」**ボタンをクリックして {{ site.data.keys.mf_analytics_service }} サービスを追加できます。

3. **容量ごとの商用:** このプランにより、ユーザーはモバイル・ユーザーやデバイスの数に関係なく、任意の数のモバイル・アプリケーションを実動で作成、テスト、および実行できます。大規模のデプロイメントと高可用性がサポートされます。このプランでは、**dashDB OLTPサービス** の準備が整っている必要があります。dashDB サービスは別に作成され請求されます。料金は、ご使用の環境の合計サイズによって異なります。オプションで、**「Analytics の追加」**ボタンをクリックして {{ site.data.keys.mf_analytics_service }} サービスを追加できます。

4. **1 つの商用アプリケーション**: このプランでは、{{ site.data.keys.mf_server }} が Liberty for Java ランタイム上のスケーラブルな Cloud Foundry アプリケーションにプロビジョンされます。また、このプランには、別に作成され請求される dashDB データベース・サービスも必要です。このプランでは、1 つのモバイル・アプリケーションの作成と管理を行うことができます。この 1 つのモバイル・アプリケーションは、iOS、Android、Windows、Mobile Web など、複数のフレーバーで構成できます。 オプションで、**「Analytics の追加」**ボタンをクリックして {{ site.data.keys.mf_analytics_service }} サービスを追加できます。

> 選択可能なプランとそれぞれの請求について詳しくは、[Bluemix.net のサービス・ページを参照してください](https://console.ng.bluemix.net/catalog/services/mobile-foundation/)。

#### ジャンプ先:
{: #jump-to}
* [{{ site.data.keys.mf_bm_short }} サービスのセットアップ](#setting-up-the-mobile-foundation-service)
* [{{ site.data.keys.mf_bm_short }} サービスの使用](#using-the-mobile-foundation-service)
* [サーバー構成](#server-configuration)
* [拡張サーバー構成](#advanced-server-configuration)
* [分析サポートの追加](#adding-analytics-support)
* [Analytics サポートの削除](#removing-analytics-support)
* [IBM Containers にデプロイされた Analytics から Analytics サービスへの切り替え](#switching-from-analytics-container-to-analytics-service)
* [{{ site.data.keys.mf_server }} 修正の適用](#applying-mobilefirst-server-fixes)
* [サーバー・ログへのアクセス](#accessing-server-logs)
* [トラブルシューティング](#troubleshooting)
* [発展的なチュートリアル](#further-reading)

## {{ site.data.keys.mf_bm_short }} サービスのセットアップ
{: #setting-up-the-mobile-foundation-service }
使用可能なプランをセットアップするには、まず最初に以下のステップに従います。

1. [bluemix.net](http://bluemix.net) をロードし、ログインして、**「カタログ」**をクリックします。
2. **「Mobile Foundation」**を検索し、表示されたタイル・オプションをクリックします。
3. *オプション*。サービス・インスタンスに付けるカスタム名を入力するか、またはデフォルトで示された名前を使用します。
4. 目的の価格設定プランを選択し、**「作成」**をクリックします。

    <img class="gifplayer" alt="{{ site.data.keys.mf_bm_short }} サービス・インスタンスの作成" src="service-creation.png"/>

### *開発者* プランのセットアップ
{: #setting-up-the-developer-plan }

{{ site.data.keys.mf_bm_short }} サービスを作成すると、{{ site.data.keys.mf_server }} が作成されます。
  * {{ site.data.keys.mf_server }} に即座にアクセスして操作することができます。
  * CLI を使用して {{ site.data.keys.mf_server }} にアクセスするには資格情報が必要です。これは、Bluemix コンソールの左側のナビゲーション・パネルにある**「サービス資格情報」**をクリックすると表示されます。

  ![{{ site.data.keys.mf_bm_short }} のイメージ](overview-page-new.png)

### *開発者商用* プラン、*容量ごとの商用* プラン、および *1 つの商用アプリケーション* プランのセットアップ
{: #setting-up-the-developer-pro-professional-percapacity-and-professional-1-application-plans }
1. これらのプランには、外部[dashDB トランザクション・データベース・インスタンス](https://console.ng.bluemix.net/catalog/services/dashdb/)が必要です。

    > [dashDB データベース・インスタンスのセットアップ]({{site.baseurl}}/blog/2016/11/02/using-dashdb-service-with-mobile-foundation/)についてもっとよく知る

    既存の dashDB サービス・インスタンス (DashDB Enterprise Transactional 2.8.500 または Enterprise Transactional 12.128.1400) がある場合は、**「既存のサービスの使用」**オプションを選択して、次のように資格情報を入力します。

    ![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](create-dashdb-instance-existing.png)

    1.b. 現在まだ dashDB サービス・インスタンスがない場合は、次のように**「新規サービスの作成」**オプションを選択して、画面に表示される指示に従います。

    ![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](create-dashdb-instance-new.png)

2. {{ site.data.keys.mf_server }} を始動します。
    - サーバー構成については、基本レベルをそのまま保持して **「基本サーバーの始動」**をクリックするか、または
    - [「設定」タブ](#advanced-server-configuration)でサーバー構成を更新して、**「拡張サーバーの始動」**をクリックします。

    このステップの間に、{{ site.data.keys.mf_bm_short }} サービス用として Cloud Foundry アプリケーションが生成され、MobileFirst Foundation 環境が初期化されます。このステップは 5 分から 10 分かかることがあります。

3. インスタンスの準備ができれば、[サービスを使用](#using-the-mobile-foundation-service)できます。

    ![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](overview-page.png)

## {{ site.data.keys.mf_bm_short }} サービスの使用
{: #using-the-mobile-foundation-service }

今、{{ site.data.keys.mf_server }} は実行中です。次のようなダッシュボードが示されます。

![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](service-dashboard.png)

**「Analytics の追加」**をクリックして、サーバー・インスタンスに {{ site.data.keys.mf_analytics_service }} サポートを追加します。
『[分析サポートの追加](#adding-analytics-support)』セクションで詳しく学びます。

**「コンソールの起動」**をクリックして {{ site.data.keys.mf_console }} を開きます。デフォルトのユーザー名は「admin」で、「目」アイコンをクリックすることでパスワードを明らかにすることができます。

![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](dashboard.png)

### サーバー構成
{: #server-configuration }
基本のサーバー・インスタンスは、次のもので構成されます。

* 1 つのノード (サーバー・サイズ: 「小」)
* 1GB のメモリー
* 2GB のストレージ容量

### 拡張サーバー構成
{: #advanced-server-configuration }
**「設定」**タブでは、次のような要素を使用して、さらにサーバー・インスタンスをカスタマイズできます。

* ノード、メモリー、ストレージのさまざまな組み合わせ
* {{ site.data.keys.mf_console }} admin のパスワード
* LTPA 鍵
* JNDI 構成
* ユーザー・レジストリー
* トラストストア
* {{ site.data.keys.mf_analytics_service }} の構成
* DashDB データベースとして Enterprise Transactional 2.8.500 または Enterprise Transactional 12.128.1400 を選択 (*1 つの商用アプリケーション* プランで選択可能)
* VPN

![{{ site.data.keys.mf_bm_short }} のセットアップのイメージ](advanced-server-configuration.png)

## {{ site.data.keys.mf_analytics_service }} サポートの追加
{: #adding-analytics-support }
サービスの「ダッシュボード」ページから**「Analytics の追加」**をクリックすることで、{{ site.data.keys.mf_analytics_service }} サポートを {{ site.data.keys.mf_bm_short }} サービス・インスタンスに追加できます。このアクションにより、{{ site.data.keys.mf_analytics_service }} サービス・インスタンスがプロビジョンされます。

>{{ site.data.keys.mf_bm_short }} サービスの**開発者**プラン・インスタンスを作成または再作成すると、デフォルトで、{{ site.data.keys.mf_analytics_service }} サービス・インスタンスが追加されます。

<!--* When using the **Developer** plan this action will also automatically hook the {{ site.data.keys.mf_analytics_service }} service instance to your {{ site.data.keys.mf_server }} instance.  
* When using the **Developer Pro**, **Professional Per Capacity** or **Professional 1 Application** plans, this action will require additional input from you to select: amount of available Nodes, available Memory and a storage volume. -->

操作が完了したら、ブラウザー上で {{ site.data.keys.mf_console }} ページを再ロードして {{ site.data.keys.mf_analytics_service_console }} にアクセスします。  

> [{{ site.data.keys.mf_analytics_service }} カテゴリーの {{ site.data.keys.mf_analytics_service }} についてもっとよく知る](../../analytics)。

##  {{ site.data.keys.mf_analytics_service }} サポートの削除
{: #removing-analytics-support}

サービスの「ダッシュボード」ページから**「Analytics の削除」**をクリックすると、{{ site.data.keys.mf_bm_short }} サービス・インスタンスの {{ site.data.keys.mf_analytics_service }} サポートを削除できます。このアクションにより、{{ site.data.keys.mf_analytics_service }} サービス・インスタンスが削除されます。

操作が完了したら、ブラウザー上で {{ site.data.keys.mf_console }} ページを再ロードします。

##  IBM Containers にデプロイされた Analytics から Analytics サービスへの切り替え
{: #switching-from-analytics-container-to-analytics-service}

>**注:** {{ site.data.keys.mf_analytics_service }} を削除すると、使用可能なすべての Analytics データが削除されます。このデータは、新しい {{ site.data.keys.mf_analytics_service }} インスタンスでは使用できません。

ユーザーはサービス・ダッシュボードから**「Analytics の削除」**ボタンをクリックして、現在のコンテナーを削除できます。これにより Analytics インスタンスが削除され、**「Analytics の追加」**ボタンが使用可能になり、ユーザーはこれをクリックして新しい {{ site.data.keys.mf_analytics_service }} サービス・インスタンスを追加できます。

## {{ site.data.keys.mf_server }} 修正の適用
{: #applying-mobilefirst-server-fixes }
{{ site.data.keys.mf_bm }} サービスの更新は、人的介入を必要とせず自動的に適用されます。ただし、更新を実行するための同意だけはユーザーが行います。更新が使用可能になると、指示とアクション・ボタンが含まれたバナーが、サービスの「ダッシュボード」ページに表示されます。

## サーバー・ログへのアクセス
{: #accessing-server-logs }
サーバー・ログにアクセスするには、以下で説明する手順に従います。

**シナリオ 1:**

1. ホスト・マシンをセットアップします。<br/>
Bluemix Cloud Foundry アプリケーションを管理するには、Cloud Foundry CLI をインストールする必要があります。<br/>
[Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases) をインストールします。
2. 端末を開き、*組織*および*スペース*に `cf login` を使用してログインします。
3. CLI で次のコマンドを実行します。
```bash
  cf ssh <mfp_Appname> -c "/bin/cat logs/messages.log" > messages.log
```
4. トレースが使用可能な場合に限り、次のコマンドを実行します。
```bash
cf ssh <mfp_Appname> -c "/bin/cat logs/trace.log" > trace.log
 ```

**シナリオ 2:**      

* サーバー・ログにアクセスするには、サイドバー・ナビゲーションを開き、**「アプリケーション」→「ダッシュボード」→「Cloud Foundry アプリケーション」**をクリックします。
* アプリケーションを選択して、**「ログ」→「Kibana で表示」**をクリックします。
* ログ・メッセージを選択してコピーします。


#### トレース
{: #tracing }
トレースを有効にするには、DEBUG レベルのメッセージが **trace.log** ファイルに表示されるようにするため、次のようにします。

1. **「ランタイム」→「メモリーとインスタンス (Memory and Instances)」**で、サービス・インスタンス (**0** で始まるインスタンス ID) を選択します。
2. **「トレース」**アクション・オプションをクリックします。
3. トレース・ステートメントとして `com.ibm.mfp.*=all` と入力し、**「トレースを実行依頼 (Submit trace)」**をクリックします。

これで、上記で指定した場所で **trace.log** ファイルを使用できるようになりました。

<img class="gifplayer" alt="{{ site.data.keys.mf_bm_short }} サービスのサーバー・ログ" src="server-logs.png"/>

## トラブルシューティング
{: #troubleshooting }
開発者プランでは永続的なデータベースが提供されず、これがデータ喪失につながる可能性があります。このような場合に素早く正常動作に戻せるように、以下のベスト・プラクティスに従ってください。

* 次のようなサーバー・サイド・アクションを行うたび:
    * アダプターのデプロイや、アダプターの何らかの構成またはプロパティー値の更新
    * スコープ・マッピングのような、何らかのセキュリティー構成の実行

    コマンド・ラインから次のコマンドを実行して、構成を .zip ファイルとしてダウンロードします。

  ```bash
  $curl -X GET -u admin:admin -o export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/export/all
  ```

* サーバーを再作成した場合や、構成を失った場合は、コマンド・ラインから次のコマンドを実行して、構成をサーバーにインポートします。

  ```bash
  $curl -X POST -u admin:admin -F file=@./export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi
  ```

## 発展的なチュートリアル
{: #further-reading }
{{ site.data.keys.mf_server }} インスタンスが稼働中になりました。

* [{{ site.data.keys.mf_console }}](../../product-overview/components/console)について十分把握しておきます。
* これらの[クイック・スタート・チュートリアル](../../quick-start)で MobileFirst Foundation を体験します。
* [使用可能なチュートリアル](../../all-tutorials/)すべてに目をとおします。
