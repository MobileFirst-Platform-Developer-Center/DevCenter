---
layout: tutorial
title: MobileFirst Server のライセンス
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
IBM {{ site.data.keys.mf_server }} では、購入した対象に基づいて、2 つの異なるライセンス方式をサポートしています。

永久ライセンス を購入した場合は、購入した対象を消費して、{{ site.data.keys.mf_console }} の「**ライセンス・トラッキング・ページ (License tracking page)**」、および[ライセンス・トラッキング・レポート](../../administering-apps/license-tracking/#license-tracking-report)を通じて、使用量とコンプライアンスを検証することができます。 トークン・ライセンスを購入した場合は、リモート・トークン・ライセンス・サーバーと通信するように {{ site.data.keys.mf_server }} を構成します。

### アプリケーションまたはアドレス可能なデバイスのライセンス
{: #application-or-addressable-device-licenses }
アプリケーションまたはアドレス可能なデバイスのライセンスを購入した場合は、購入した対象を消費して、{{ site.data.keys.mf_console }} の「ライセンス・トラッキング」ページか、ライセンス・トラッキング・レポートを通じて、使用量とコンプライアンスを検証できます。

### プロセッサー・バリュー・ユニット (PVU) ライセンス交付
{: #processor-value-unit-pvu-licensing }
プロセッサー・バリュー・ユニット (PVU) ライセンス交付は、IBM {{ site.data.keys.product }} Extension ([ライセンス情報文書](http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument)を参照) を購入している場合に使用できます。ただし、IBM  WebSphere Application Server Network Deployment、IBM API Connect™ Professional、または IBM API Connect Enterprise の購入後に限ります。

PVU ライセンスの価格設定体系は、インストールされている製品に使用可能なプロセッサーのタイプと数の両方に対応します。 資格付与は、フル・キャパシティーまたはサブキャパシティーにすることができます。 プロセッサー・バリュー・ユニット・ライセンス交付では、各プロセッサー・コアに割り当てられたバリュー・ユニット数に基づいてソフトウェアのライセンスを取得します。

例えば、プロセッサー・タイプ A にはコアあたり 80 バリュー・ユニットが割り当てられ、プロセッサー・タイプ B にはコアあたり 100 バリュー・ユニットが割り当てられているとします。 製品を 2 つのタイプ A プロセッサー上で実行するライセンスを取得する場合、コアあたり 160 バリュー・ユニットの資格付与が必要です。 製品を 2 つのタイプ B プロセッサー上で実行する場合、必要な資格付与はコアあたり 200 バリュー・ユニットです。

> PVU ライセンス交付についての詳細は、[ こちら](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html)を参照してください。

### トークン・ライセンス
{: #token-licensing }
従来のフローティング環境では、ライセンスごとに事前定義された数量を消費しますが、トークン環境では、すべての製品が、ライセンスごとに事前定義されたトークン値を消費します。 ライセンス・キーにはトークンのプールがあり、ライセンス・サーバーはそれを使用して、チェックインおよびチェックアウトされたトークンを計算します。 製品がライセンス・サーバーに対してライセンスをチェックインまたはチェックアウトすると、トークンが消費または解放されます。

ライセンスの契約で、トークン・ライセンスの使用の可否、使用可能なトークンの数、およびトークンによって検証されるフィーチャーが規定されます。 『トークン・ライセンス検証』を参照してください。

トークンに基づくライセンスを購入した場合は、トークン・ライセンス対応バージョンの {{ site.data.keys.mf_server }} をインストールして、サーバーがリモート・トークン・サーバーと通信できるようにアプリケーション・サーバーを構成します。 『トークン・ライセンスのためのインストールおよび構成』を参照してください。

トークン・ライセンスでは、アプリケーションをデプロイする前に、各アプリケーションのアプリケーション記述子にライセンス・アプリケーション・タイプを指定できます。 ライセンス・アプリケーション・タイプとして、APPLICATION または ADDITIONAL_BRAND_DEPLOYMENT のいずれかを使用できます。 テストを行う場合は、ライセンス・アプリケーション・タイプの値を NON_PRODUCTION に設定できます。 詳しくは、『アプリケーション・ライセンス情報の設定』を参照してください。

Rational License Key Server 8.1.4.9 と共にリリースされた Rational License Key Server Administration and Reporting Tool により、{{ site.data.keys.product }} で消費されるライセンスを管理し、そのレポートを生成することができます。 レポートの関連部分は、**「MobileFirst Platform Foundation Application」**または**「MobileFirst Platform Additional Brand Deployment」**という表示名で識別可能です。 これらの名前は、トークンが消費されたライセンス・アプリケーション・タイプを表します。 詳しくは、『[Rational License Key Server Administration and Reporting Tool の概要](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html)』および『[Rational License Key Server フィックスパック 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300)』を参照してください。

{{ site.data.keys.mf_server }} でのトークン・ライセンスの使用の計画については、『トークン・ライセンスの使用計画』を参照してください。

{{ site.data.keys.product }} のライセンス・キーを入手するには、IBM Rational License Key Center にアクセスする必要があります。 ライセンス・キーの生成と管理について詳しくは、[IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) を参照してください。
