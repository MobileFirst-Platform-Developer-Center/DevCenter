---
layout: tutorial
title: Analytics Receiver
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

{{ site.data.keys.mf_analytics_receiver_short }} は、モバイル・アプリケーションからイベント・ログを受信し、メモリー内のイベント・キューを使用してそれらを段階的に {{ site.data.keys.mf_analytics_short }} に転送するようにセットアップできる、オプションのサービスです。{{ site.data.keys.mf_analytics_receiver_short }} は、ログを {{ site.data.keys.mf_analytics }} に送信する前にログを保管する、メモリー内のイベント・キューを保持します。

Mobile Analytics のデフォルトのセットアップと構成では、{{ site.data.keys.mf_server }} はすべてのモバイル・クライアントのイベント・ログを受信し、それらを {{ site.data.keys.mf_analytics }} に転送します。デバイスが多数ある場合、モバイル・クライアント・アプリケーションの使用率が高く、クライアント・アプリケーションから大量の分析データが記録されて送信される場合、{{ site.data.keys.mf_server }} のパフォーマンスが影響を受ける可能性があります。{{ site.data.keys.mf_analytics_receiver_short }} を使用可能にすると、{{ site.data.keys.mf_server }} から分析イベントを処理する負荷が軽減され、{{ site.data.keys.mf_server }} リソースをランタイム機能に十分に活用できるようになります。

{{ site.data.keys.mf_analytics_receiver_short }} は、いつでもセットアップと構成ができます。最新の Mobile Foundation クライアント SDK でモバイル・クライアント・アプリケーションを更新します。アプリケーション・コードの変更は必要ありません。{{ site.data.keys.mf_server }} JNDI プロパティーを {{ site.data.keys.mf_analytics_receiver_short }} 構成で更新し、分析イベントを送信するクライアント・アプリケーションで {{ site.data.keys.mf_analytics_receiver_short }} エンドポイントを使用できるようにします。

![Analytics Receiver トポロジー](AnalyticsTopology.png)

## {{ site.data.keys.mf_analytics_receiver_short }} 構成
{: #analytics-receiver-configuration }

Analytics Receiver WAR ファイルは、{{ site.data.keys.mf_server }} インストールと共に格納されます。詳しくは、「{{ site.data.keys.mf_server }} の配布構造」を参照してください。

* {{ site.data.keys.mf_analytics_receiver_server }} のインストール方法については、[{{ site.data.keys.mf_analytics_receiver_server }} インストール・ガイド](../../installation-configuration/production/analyticsreceiver/installation)を参照してください。
* IBM MobileFirst Analytics Receiver の構成方法の詳細は、[構成ガイド](../../installation-configuration/production/analyticsreceiver/configuration)を参照してください。

* {{ site.data.keys.mf_analytics_receiver_short }} のインストール後の構成のクイック・チェックとして、次の JNDI プロパティーが {{ site.data.keys.mf_analytics }} を指していることを確認してください。

  | プロパティー                       | 説明                                                  | デフォルト値  |
  |------------------------------------|-------------------------------------------------------|---------------|
  | receiver.analytics.url                  | 必須。着信する分析データを受信する {{ site.data.keys.mf_analytics_server }} によって公開される URL。例えば、http://hostname:port/analytics-service/rest などです。| なし |
  | receiver.analytics.username             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名。 | なし |
  | receiver.analytics.password             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるパスワード。 | なし |
  | receiver.analytics.event.qsize          | オプション。分析イベント・キュー・サイズのサイズ。これは、十分な JVM ヒープ・サイズを提供することによって、慎重に追加する必要があります。デフォルトのキュー・サイズは 10000。 | なし |

* 受信側を *loguploader* として使用できるようにするには、{{ site.data.keys.mf_server }} で以下の JNDI プロパティーを確実に設定します。これらの JNDI プロパティーは、{{ site.data.keys.mf_analytics_receiver_server }} を指す必要があります。

  | プロパティー                       | 説明                                                  | デフォルト値  |
  |------------------------------------|-------------------------------------------------------|---------------|
  | mfp.analytics.receiver.url                  | 必須。着信する分析データを受信する {{ site.data.keys.mf_analytics_receiver_server }} によって公開される URL。例えば、http://hostname:port/analytics-receiver/rest などです。| なし |
  | mfp.analytics.receiver.username             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるユーザー名。 | なし |
  | mfp.analytics.receiver.password             | データのエントリー・ポイントが基本認証で保護されている場合に使用されるパスワード。 | なし |

* サーバー・ログは {{ site.data.keys.mf_server }} から {{ site.data.keys.mf_analytics_server }} に直接送信されるため、{{ site.data.keys.mf_analytics_short }} セットアップが {{ site.data.keys.mf_server }} で妨げられないようにしてください。

## トラブルシューティング
{: #troubleshooting }

{{ site.data.keys.mf_analytics_receiver }} のトラブルシューティングについては、[Analytics Receiver のトラブルシューティング](../../troubleshooting/analyticsreceiver/)を参照してください。
