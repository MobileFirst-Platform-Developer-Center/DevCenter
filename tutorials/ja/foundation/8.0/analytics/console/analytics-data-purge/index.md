---
layout: tutorial
title: データの保存と消去
breadcrumb_title: データの保存と消去
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics }} データはサーバーに保管され、データが消去されるまでレポート作成に使用できます。どのイベント・タイプ・データを保存し、どのイベント・タイプ・データを消去するかを制御できます。データは、ある一定の間隔で消去することも手動で消去することも可能です。

## Analytics コンソールからのデータ保存の構成
{: #configuring-data-retention-from-the-analytics-console }

1. {{ site.data.keys.mf_analytics_console }}から**「管理」**アイコン (<img  alt="レンチのアイコン" style="margin:0;display:inline" src="wrench.png"/>) をクリックします。
2. **「設定」**タブを選択します。

   ![データの保存構成](analytics_console_data_retention.png)

   * 即時にデータを削除するには、**「破棄」**ラジオ・ボタンを選択します。
   * **「データの保持」**列で、保存する日数を選択するか、デフォルトの**「データを無期限に保持」**の値のままにします。

3. **「変更の保存」**をクリックします。

新規保存ポリシーが整備されました。
