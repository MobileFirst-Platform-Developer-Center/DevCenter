---
layout: tutorial
title: ライセンス・トラッキング
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
ライセンス・トラッキングは、
{{site.data.keys.product_full }}
でデフォルトで使用可能になっています。これは、アクティブ・クライアン
ト・デバイス、アドレス可能デバイス、およびインストールされているアプリ
など、ライセンス・ポリシーに関連したメトリックを追跡します。この情報は、
{{site.data.keys.product }}
の現在の使用がライセンス資格レベル内に収まっているかどうかを判別する
のに役立ち、ライセンス違反が起こらないようにすることができます。

また、クライアント・デバイスの使用を追跡し、デバイスがアクティブか
どうかを判別することで、
{{site.data.keys.product_adj }}
管理者は、
{{site.data.keys.mf_server }}
にアクセスしなくなっているデバイスを廃棄できます。このような状況は、例えば従業員が退社した場合に発生することがあります。

#### ジャンプ先
{: #jump-to }

* [アプリケーション・ライセンス情報の設定](#setting-the-application-license-information)
* [ライセンス・トラッキング・レポート](#license-tracking-report)
* [トークン・ライセンス検証](#token-license-validation)
* [IBM License Metric Tool との統合](#integration-with-ibm-license-metric-tool)

## アプリケーション・ライセンス情報の設定
{: #setting-the-application-license-information }
{{site.data.keys.mf_server }}
に登録するアプリケーションのアプリケーション・ライセンス情報を設定する
方法を説明します。

ライセンス条項により、{{site.data.keys.product_full }}、{{site.data.keys.product_full }} Consumer、{{site.data.keys.product_full }} Enterprise、および IBM {{site.data.keys.product_adj }} Additional Brand Deployment が識別されます。ライセンス・トラッキング・レポートが正しいラ
イセンス情報を生成できるように、アプリケーションをサーバー
に登録する際にアプリケーションのライセンス情報を設定します。サーバーがトークン・ライセンス用に構成
されている場合、ライセンス情報を使用してライセンス・サーバーから正
しいフィーチャーをチェックアウトします。

アプリケーション・タイプとトークン・ライ
センス・タイプを設定します。アプリケーション・タイプに使用可能な値は次の通りです。  

* **B2C**: アプリケーションが {{site.data.keys.product_full }} Consumer のライセンス交付を受けている場合に、このアプリケーション・タイプを使用します。
* **B2E**: アプリケーションが {{site.data.keys.product_full }} Enterprise のライセンス交付を受けている場合に、このアプリケーション・タイプを使用します。
* **UNDEFINED**: Addressable Device メトリックに対する準拠性をトラッキングする必要がない場合に、このアプリケーション・タイプを使用します。

トークン・ライセンス・タイプに使用可能な値は次の通りです。

* **APPLICATION**: ほとんどのアプリケーションで APPLICATION を使用します。これはデフォルトです。
* **ADDITIONAL\_BRAND\_DEPLOYMENT**: アプリケーションが IBM {{site.data.keys.product_adj }} Additional Brand Deployment のライセンス交付を受けている場合に、この ADDITIONAL\_BRAND\_DEPLOYMENT を使用します。
* **NON_PRODUCTION**: 実動サーバー上でアプリケーションを開発およびテストしている間は、NON\_PRODUCTION を使用します。NON_PRODUCTION トークン・ライセンス・タイプの
アプリケーションに対してチェックアウトされるトークンはありません。

> **重要:** 実動アプリケーションに NON_PRODUCTION を使用すると、ライセンス条項に違反することになります。

**注:** サーバーがトークン・ライセンス用に構成されていて、トークン・ライセンス・タイプ ADDITIONAL\_BRAND\_DEPLOYMENT または NON_PRODUCTION を指定してアプリケーションを登録する予定の場合、アプリケーションの初期バージョンを登録する前に、アプリケーション・ライセンス情報を設定します。mfpadm プログラムを使用して、バージョンを登録する前にアプリケーションのライセンス情報を設定することができます。ライセンス情報を設定した後、アプリケーションの初期バー
ジョンを登録する際にトークンの正しい数がチェックアウトされます。トークンの検証について詳しくは、『トークン・ライセンス検証』を参照してください。

{{site.data.keys.mf_console }}
を使用してライセンス・タイプを設定するには、以下の手順を実行します。

1. アプリケーションを選択します。
2. **「設定」**を選択します。
3. **アプリケーション・タイプ**と**トークン・ライセンス・タイプ**を設定します。
4. **「保存」**をクリックします。

mfpadm プログラムを使用してライセンス・タイプを設定するには、次を使用します。
`mfpadm app <appname> set license-config <application-type> <token license type>`

次の例では、ライセンス
情報 B2E / APPLICATION を **my.test.application** とい
う名前のアプリケーションに設定します。

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## ライセンス・トラッキング・レポート
{: #license-tracking-report }

{{site.data.keys.product }}
は、Client Device メトリック、Addressable
Device メトリック、および Application メトリックのライセンス・
トラッキング・レポートを表示します。レポートでは履歴データも表示されます。

ライセンス・トラッキング・レポートは以下のデータを表示し
ます。

* {{site.data.keys.mf_server }}
にデプロイされているアプリケーションの数
* 現行のカレンダー月のアドレス可能デバイス数
* アクティブおよび廃棄されたクライアント・デバイス数
* 直前の n 日間にレポートされたクライアント・デバイスの最高数 (n は、クライアント・デバイスが廃棄されるまでの非アクティブであった日数)。

さらにデータを分析することが必要な場
合があります。この目的のために、ライセンス・レポートならびにライセンス・メトリックの履歴リストを含む CSV ファイルをダウンロードすることができます。

ライセンス・トラッキン
グ・レポートにアクセスするには、以下を実行します。

1. 
{{site.data.keys.mf_console }}
を開きます。
2. **「こんにちは、～ さん」**メニューをクリックします。
3. **「ライセンス」**を選択します。

ライセンス・トラッキング・レポートから CSV ファイルを取得するには
、**「アクション/レポートのダウンロード (Actions/Download
report)」**をクリックします。

## トークン・ライセンス検証
{: #token-license-validation }
IBM {{site.data.keys.mf_server }} をトークン・ライセンス用にインストールして構成すると、各種シナリオでサーバーはライセンスを検証します。構成が正しくない場合、アプリケーションの登録または
削除でライセンスが検証されません。

### 検証シナリオ
{: #validation-scenarios }
ライセンスは、次のような各種シナリオで検証されます。

#### アプリケーションの登録
{: #on-application-registration }
ご使用のアプリケーションのトークン・ライセンス・タイプで使用可能
なトークンが十分ない場合、アプリケーションの登録は失敗します。

> **ヒント:** アプリケーションの初期バージョンを登録する前に、トークン・ライセンス・タイプを設定することができます。

ライセンスは、アプリケーションにつき 1 回のみチェックされます。
同じアプリケーションに新規のプラットフォームを登録する場合、または既
存のアプリケーションとプラットフォームに新規バージョンを登録する場合
は、新しいトークンは要求されません。

#### トークン・ライセンス・タイプの変更
{: #on-token-license-type-change }
アプリケーションのトークン・ライセンス・タイプを変更すると、
アプリケーションのトークンがリリースされた後、新規のライセンス・タ
イプのトークンに戻されます。

#### アプリケーションの削除
{: #on-application-deletion }
アプリケーションの最後のバージョンが削除されると、ライセンスはチ
ェックインされます。

#### サーバー始動時
{: #at-server-start }
ライセンスは、登録されたすべてのアプリケーションに対してチェ
ックアウトされます。すべてのアプリケーションについて使用可能なトークンが十分ない場合、サーバーはアプリケーションを非アクティブ化します。

> **重要:** サーバーは、アプリケーションを自動的に再アクティブ化しません。使用可能なトークンの数を増やした後は、アプ
リケーションを手動で再アクティブ化する必要があります。アプリケーションの使用不可化と使用可能化について詳しくは、[保護リソースへのアプリケーション・アクセスのリモート側での無効化](../using-console/#remotely-disabling-application-access-to-protected-resources)を参照してください。

#### ライセンスの期限切れ
{: #on-license-expiration }
一定の時間が過ぎると、ライセンスの有効期限が切れ、再度チェックア
ウトする必要があります。すべてのアプリケーションについて使用可能なトークンが十分ない場合、サーバーはアプリケーションを非アクティブ化します。

> **重要:** サーバーは、アプリケーションを自動的に再アクティブ化しません。使用可能なトークンの数を増やした後は、アプ
リケーションを手動で再アクティブ化する必要があります。アプリケーションの使用不可化と使用可能化について詳しくは、[保護リソースへのアプリケーション・アクセスのリモート側での無効化](../using-console/#remotely-disabling-application-access-to-protected-resources)を参照してください。

#### サーバーのシャットダウン時
{: #at-server-shutdown }
サーバーのシャットダウン時に、デプロイされているアプリケーション
ごとにライセンスがチェックインされます。トークンは、ファームのクラスターの最終サーバ
ーがシャットダウンする場合のみリリースされます。

### ライセンス検証失敗の原因
{: #causes-of-license-validation-failure }
以下の場合、アプリケーションの登録時または削除時にライセンス検証が失敗す
ることがあります。

* Rational Common Licensing ネイティブ・ライブラリーがインストールおよび構成されていない。
* 管理サービスがトークン・ライセンスに対して構成されていない。
詳しくは、
[
トークン・ライセンスのインストールと構成 (Installing
and configuring for token licensing)](../../installation-configuration/production/token-licensing) を参照してください。
* Rational License Key Server にアクセスできない。
* 十分なトークンが使用可能ではない。
* ライセンスの有効期限が切れた。

### {{site.data.keys.product_full }} が使用する IBM Rational License Key Server フィーチャーの名前
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
アプリケーションのトークン・ライセンス ・タイプ
に応じて、以下のフィーチャーが使用されます。

| トークン・ライセンス・タイプ | フィーチャー名 | 
|--------------------|--------------|
| APPLICATION        | 	ibmmfpfa    | 
| ADDITIONAL\_BRAND\_DEPLOYMENT |	ibmmfpabd | 
| NON_PRODUCTION	| (フィーチャーなし) | 

## IBM License Metric Tool との統合
{: #integration-with-ibm-license-metric-tool }
IBM License Metric Tool によって、IBM ライセンスのコンプライアンスを評価できます。

IBM Software License Metric Tag や SWID (ソフトウェア ID) ファイルをサポートする IBM License Metric Tool のバージョンをインストールしていない場合は、{{site.data.keys.mf_console }} のライセンス・トラッキング・レポートを用いてこのライセンスの使用を検討することができます。詳しくは、[ライセンス・トラッキング・レポート](#license-tracking-report)を参照してください。

### SWID ファイルを使用した、PVU ベースのライセンス交付
{: #about-pvu-based-licensing-using-swid-files }
IBM MobileFirst Foundation Extension V8.0.0 オファリングを購入した場合、プロセッサー・バリュー・ユニット (PVU) メトリックの下でライセンス交付されます。

PVU 計算は、ISO/IEC 19970-2 および SWID ファイルに対する、IBM License Metric Tool のサポートに基づきます。SWID ファイルは、IBM Installation Manager が {{site.data.keys.mf_server }} や {{site.data.keys.mf_analytics_server }} をインストールするときに、サーバーに書き込まれます。IBM License Metric Tool が現在のカタログによると無効である製品の SWID ファイルを検出すると、ソフトウェア・カタログ・ウィジェットに警告記号が表示されます。IBM License Metric Tool がどのように SWID ファイルと連動するかについて詳しくは、[https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html)を参照してください。

Application Center のインストール数は、PVU ベースのライセンスによって制限されません。

Foundation Extension の PVU ライセンスは、IBM WebSphere Application Server Network Deployment、IBM API Connect™ Professional、IBM API Connect Enterprise のいずれかの製品ライセンスと共にのみ購入できます。IBM Installation Manager は、License Metric Tool によって使用される SWID ファイルの追加や更新を行います。

> {{site.data.keys.product_full }} Extension について詳しくは、[https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN)を参照してください。

> PVU ライセンス交付について詳しくは、[https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html) を参照してください。

### SLMT タグ
{: #slmt-tags }
IBM MobileFirst Foundation は IBM Software License Metric Tag (SLMT) ファイルを生成します。IBM Software License Metric Tag をサポートするバージョンの IBM License Metric Tool は、ライセンス消費レポートを生成することができます。このセクションでは、{{site.data.keys.mf_server }} 向けのこれらのレポートを解釈したり、IBM Software License Metric Tag ファイルの生成を構成したりする方法について説明します。

稼働中の MobileFirst ランタイム環境の各インスタンスは、IBM Software License Metric Tag ファイルを生成します。モニター対象のメトリックは、`CLIENT_DEVICE`
、`ADDRESSABLE_DEVICE`、`APPLICATION`
です。この値は 24 時間おきに更新されます。

#### CLIENT_DEVICE メトリックについて
{: #about-the-client_device-metric }

`CLIENT_DEVICE` メトリックは、以下のサブタイプをもつこ
とができます。

* アクティブ・デバイス

    MobileFirst ランタイム環境、あるいは同じクラスターまたはサーバー・ファームに属する他の MobileFirst ランタイム・インスタンスを使用したクライアント・デバイスで、使用廃止されていないものの数。使用廃止されたデバイスについて詳しくは、[クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングの構成](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)を参照してください。

* 非アクティブ・デバイス

    MobileFirst ランタイム環境、あるいは同じクラスターまたはサーバー・ファームに属する他の MobileFirst ランタイム・インスタンスを使用したクライアント・デバイスで、使用廃止されたものの数。使用廃止されたデバイスについて詳しくは、[クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングの構成](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)を参照してください。

特殊な
ケースを以下に示します。

* デバイスの使用廃止期間が短期間に設定されている場合は、サブタイプ「非アクティブ・デバイス」はサブタイプ「アクティブまたは非アクティブなデバイス」に置き換えられます。
* デバイス・トラッキングが使用不可になっている場合は、値が 0 で「デバイス・トラッキング使用不可」というメトリック・サブタイプをもつ 1 つのエントリーのみが `CLIENT_DEVICE` に生成されます。

#### APPLICATION メトリックについて
{: #about-the-application-metric }
APPLICATION メトリックは、MobileFirst ランタイム環境が開発サーバーで実行されていない限り、サブタイプをもちません。

このメトリックにレポートされる値は、MobileFirst ランタイム環境にデプロイされているアプリケーションの数です。各アプリケーションは、新規アプリケーシ
ョンや追加ブランドのデプロイメント、既存アプリケーション (例えば、ネイ
ティブ、ハイブリッド、Web) の追加タイプといった区別なく、いずれも 1 ユ
ニットとしてカウントされます。

#### ADDRESSABLE_DEVICE メトリックについて
{: #about-the-addressable_device-metric }
ADDRESSABLE_DEVICE メトリックには以下のサブタイプがあります。

* アプリケーション: `<applicationName>`、カテ
ゴリー: `<applicationtype>`

アプリ
ケーション・タイプは、**B2C**、**B2E**、ま
たは **UNDEFINED** です。アプリケーションのアプリケーション・タイプを定義するには、[アプリケーション・ライセンス情報の設定](#setting-the-application-license-information)を参照してください。

特殊な
ケースを以下に示します。

* デバイスの使用廃止期間が 30 日未満に設定されている場合は、「Short decommissioning period」という警告がサブタイプに追加されます。
* ライセンス・トラッキングが使用不可にされた場合、アドレス可能レ
ポートは生成されません。

メトリックを使用したライセンス・トラッキングの構成について詳しくは、以下を参照してください。

* [クライアント・デバイスおよびアドレス可能デバイスに対するライセンス・トラッキングの構成](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [IBM License Metric Tool ログ・ファイルの構成](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
