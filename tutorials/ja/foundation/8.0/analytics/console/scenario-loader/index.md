---
layout: tutorial
title: シナリオ・ローダー
breadcrumb_title: Scenario Loader
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

> **注:** シナリオ・ローダーは、その性質上、*試験的* であるため、完全にはサポートされていません。 状況に応じて使用してください。
>
> * 一部のグラフには、データは取り込まれません。

シナリオ・ローダーは、{{ site.data.keys.mf_analytics_console_full }}のさまざまなグラフおよびレポートにダミー・データを取り込みます。 そのデータは、Elasticsearch データ・ストアに保管されており、既存のテスト・データまたは実働データから安全に分離されています。

ロードされるデータは、人工的な性質のものであり、データ・ストアに直接注入されます。 クライアントやサーバーによって作成された実際の分析データの結果ではありません。 このデータの目的は、UI に表示されるさまざまなレポートおよびグラフの性質を理解しやすくすることにあります。 したがって、データをテストの目的で使用**しない**でください。

#### ジャンプ先
{: #jump-to }

* [始める前に](#before-you-start)
* [シナリオ・ローダーへの接続](#connecting-to-the-scenario-loader)
* [データ・ロードの構成](#configuring-the-data-loading)
* [データのロードおよび削除](#loading-and-deleting-the-data)
* [データが取り込まれたグラフおよび表の表示](#viewing-the-populated-charts-and-tables)
* [デバッグ・モードの無効化](#disabling-the-debug-mode)

## 始める前に
{: #before-you-start }

シナリオ・ローダーは、{{ site.data.keys.mf_analytics_console }}と一緒にパッケージされています。 シナリオ・ローダーに接続する前に、{{ site.data.keys.mf_analytics_console_short }}が実行されており、アクセス可能であることを確認してください。

## シナリオ・ローダーへの接続
{: #connecting-to-the-scenario-loader }

1. シナリオ・ローダーを有効にするには、JVM 引数 `-DwlDevEnv=true` または環境変数 `ANALYTICS_DEBUG=true` のいずれかを設定します。

2. ブラウザーでコンソール URL `http://<console-path>/scenarioLoader` を使用してシナリオ・ローダーにアクセスします。ここで、`<console-path>` は、`mfp-server/usr/servers/mfp/server.xml` ファイルで定義されている JNDI プロパティー値です。例:

    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. 「シナリオ・ローダー (Scenario Loader)」ページが、{{ site.data.keys.mf_analytics_console_short }}のナビゲーション・バーと一緒に表示されます。 シナリオ・ローダーはナビゲーション・バーからはアクセス不能なままです。

## データ・ロードの構成
{: #configuring-the-data-loading}

1. **「テスト構成 (Testing Configuration)」**セクションには、生成されたデータの性質 (**「基本」**タブ) およびボリューム (**「キャパシティー・プランニング」**タブ) を制御するためのさまざまな設定が用意されています。
    十分なデータをロードするために、少なくとも 30 日間の**「履歴日数 (Days of history)」**を設定するようにしてください。

    これらの設定に関する情報はすべて、**「テスト構成 (Testing Configuration)」**セクションにあります。

2. **「管理」**アイコン <img  alt="レンチのアイコン" style="margin:0;display:inline" src="wrench.png"/> をクリックし、**「設定」**タブを選択します。 **「詳細設定」**セクションで、**「デフォルト・テナント」**の値が `dummy_data_for_demo_purposes_only` に設定されていることを確認してください。

## データのロードおよび削除
{: #loading-and-deleting-the-data }

データをロードするには、**「シナリオ・オペレーション (Scenario Operations)」**セクションで**「シナリオのロードを開始 (Start Scenario Loading)」**ボタンをクリックします。

データを削除するには、**「テスト構成 (Testing Configuration)」**セクションで**「今すぐ削除 (Delete Now)」**ボタンをクリックします。

**注:** **「シナリオ・オペレーション (Scenario Operations)」**セクションで、データ作成および削除についての免責事項をお読みください。

## データが取り込まれたグラフおよび表の表示
{: #viewing-the-populated-charts-and-tables }

データがロードされると、Analytics コンソールで使用できる多くの (しかし、すべてではない) グラフおよび表にデータが取り込まれます。

{{ site.data.keys.mf_analytics_console_short }}のナビゲーション・バーから、さまざまなページおよびタブを確認してデータが取り込まれたグラフおよび表を表示します。

## デバッグ・モードの無効化
{: #disabling-the-debug-mode }

デバッグ・モードで合成データで作業した後に実データで作業するには、以下のようにします。

1. **「テスト構成 (Testing Configuration)」**セクションで**「今すぐ削除 (Delete Now)」**ボタンをクリックして、データを削除します。
2. **「設定」**→**「詳細設定」**セクションで、必ず **「デフォルト・テナント」**の値を `worklight` に設定します。
3. true に設定された変数については、false に設定します (JVM 引数 `-DwlDevEnv=false`、または環境変数 `ANALYTICS_DEBUG=false`)。
4. {{ site.data.keys.mf_analytics_server }}を再始動します。
