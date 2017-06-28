---
layout: tutorial
title: MobileFirst Analytics Server	のインストールおよび構成
breadcrumb_title: MobileFirst Analytics Server のインストール
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_analytics_server }} は、2 つの異なる WAR ファイルとして提供されます。WebSphere Application Server または WebSphere Application Server Liberty 上でデプロイするための便宜上、{{ site.data.keys.mf_analytics_server }} は、2 つの WAR ファイルを含む EAR ファイルとしても提供されます。

> **注:** 単一のホスト・マシンに {{ site.data.keys.mf_analytics_server }} の複数のインスタンスをインストールしないでください。クラスターの管理について詳しくは、Elasticsearch の資料を参照してください。

analytics WAR ファイルおよび EAR ファイルは、MobileFirst Server インストールと共に格納されます。詳しくは、MobileFirst Server の配布構造を参照してください。WAR ファイルをデプロイする場合、MobileFirst Analytics Console は次の場所で使用可能です。`http://<hostname>:<port>/analytics/console` 例: `http://localhost:9080/analytics/console`

* {{ site.data.keys.mf_analytics_server }} のインストール方法について詳しくは、[{{ site.data.keys.mf_analytics_server }} インストール・ガイド](installation)を参照してください。
* IBM MobileFirst Analytics の構成方法について詳しくは、[構成ガイド](configuration)を参照してください。
