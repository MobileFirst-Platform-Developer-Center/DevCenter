---
layout: tutorial
title: CDN からのダイレクト・アップデート要求の処置
breadcrumb_title: CDN サポート
relevantTo: [cordova]
weight: 1
---
## 概説
{: #overview }
CDN (コンテンツ配信ネットワーク) から ({{site.data.keys.mf_server }} からではなく) ダイレクト・アップデート要求に応えるようにダイレクト・アップデート要求を構成することができます。

#### CDN 使用の利点

{: #advantages-of-using-a-cdn }
{{site.data.keys.mf_server }} ではなく CDN を使用してダイレクト・アップデート要求に対応することには以下のような利点があります。

* {{site.data.keys.mf_server }} からネットワーク・オーバーヘッドを除去します。

* {{site.data.keys.mf_server }} からの要求処理時に 250 MB/秒制限よりも転送速度が速くなります。
* ユーザーの地理的な居場所に関係なく、すべてのユーザーに対して、より均質なダイレクト・アップデート体験を保証します。

#### 一般要件

{: #general-requirements }
CDN からのダイレクト・アップデート要求に応じるには、構成が以下の条件に従うようにしてください。

* CDN は、{{site.data.keys.mf_server }} の前にあるリバース・プロキシー (必要ならば別のリバース・プロキシーの前にあるリバース・プロキシー) でなければなりません。

* 開発環境からアプリケーションをビルドする際は、ターゲット・サーバーを {{site.data.keys.mf_server }}
のホストとポートではなく CDN のホストとポートにセットアップします。例えば、{{site.data.keys.mf_cli }} コマンド mfpdev server add を実行している場合は、CDN のホストとポートを指定します。
* CDN 管理パネルで、次のダイレクト・アップデート URL にキャッシングのためのマークを付けて、CDN がダイレクト・アップデート要求以外のすべての要求を {{site.data.keys.mf_server }} に渡すようにする必要があります。ダイレクト・アップデート要求の場合は、コンテンツを取得したかどうかを CDN が調べます。取得していた場合は、
{{site.data.keys.mf_server }}
にアクセスせずに要求を返します。取得していない場合は、
{{site.data.keys.mf_server }}
にアクセスしてダイレクト・アップデート・アーカイブ (.zip ファイル) を取得し、
その特定の URL に対する次回以降の要求に備えてそのファイルを保管します。
{{site.data.keys.product_full }} の v8.0 でビルドされたアプリケーションの場合、ダイレクト・アップデート URL は、`PROTOCOL://DOMAIN:PORT/CONTEXT_PATH/api/directupdate/VERSION/CHECKSUM/TYPE` です。接頭部 `PROTOCOL://DOMAIN:PORT/CONTEXT_PATH` は、すべてのランタイム要求で一定です。例: http://my.cdn.com:9080/mfp/api/directupdate/0.0.1/742914155/full?appId=com.ibm.DirectUpdateTestApp&clientPlatform=android


この例では、要求の一部でもある、追加の要求パラメーターがあります。

* CDN は、要求パラメーターのキャッシングを許可する必要があります。
2 つの異なるダイレクト・アップデートのアーカイブは、要求パラメーター
しか違わないことがあります。
* CDN はダイレクト・アップデート応答の TTL をサポートしなければなりません。このサポートは、同じバージョンに対する複数のダイレクト・アップデートをサポートするために必要です。
* CDN は、 サーバー・クライアント・プロトコルで使用される HTTP ヘッダーを変更することも削除することもできません。

## 構成例

{: #example-configuration }
この例では、ダイレクト・アップデートのアーカイブをキャッシ
ュに入れる Akamai CDN 構成を基にしています。以下のタスクは、ネットワーク管理者、{{site.data.keys.product_adj }} 管理者、および Akamai 管理者が行うものです。

#### ネットワーク管理者
{: #network-administrator }
{{site.data.keys.mf_server }}
の DNS に別のドメインを作成します。例えば、サーバー・ドメインが `cdn.yourcompany.com` である場合は、cdn.yourcompany.com などの追加ドメインを作成する必要があります。
DNS 内で、新しい `cdn.yourcompany.com` ドメインに対して、`CNAME` を Akamai 提供のドメイン名に設定します。例えば `yourcompany.com.akamai.net` などです。

#### {{site.data.keys.product_adj }}
管理者
{: #mobilefirst-administrator }
新しい cdn.yourcompany.com ドメインを {{site.data.keys.product_adj }} アプリケーションの {{site.data.keys.mf_server }} URL として設定します。例えば、Ant ビルダー・タスクの場合であれは、プロパティーは次のとおりです。`<property name="wl.server" value="http://cdn.yourcompany.com/${contextPath}/"/>`。

#### Akamai 管理者
{: #akamai-administrator }
1. Akamai プロパティー・マネージャーを開き、**ホスト名**プロパティーを新しいドメインの値に設定します。

    ![プロパティー・ホスト名を新規ドメインの値に設定](direct_update_cdn_3.jpg)
    
2. 「デフォルト・ルール」タブで、元の {{site.data.keys.mf_server }} ホストおよびポートを構成し、**「カスタム・フォワード・ホスト・ヘッダー」**値を新しく作成されたドメインに設定します。
    ![「カスタム・フォワード・ホスト・ヘッダー」値を新しく作成されたドメインに設定](direct_update_cdn_4.jpg)
    
3. **「キャッシング・オプション」**リストから、**「ストアなし」**を選択します。
    ![「キャッシング・オプション」リストから、「ストアなし」を選択します。](direct_update_cdn_5.jpg)

4. **「静的コンテンツ構成」**タブから、アプリケーションのダイレクト・アップデート URL に従って一致基準を構成します。例えば、`If Path matches one of direct_update_URL` を明示する条件を作成します。

    ![アプリケーションのダイレクト・アップデート URL に従って一致基準を構成します。](direct_update_cdn_6.jpg)
    
5. 以下のような値を設定して、ダイレクト・アップデート URL をキャッシュに入れ、TTL を設定するようにキャッシング動作を構成します。

    | フィールド | 値 |
    |-------|-------|
    | キャッシング・オプション | キャッシュ |
    | 失効オブジェクトを強制的に再評価 | 検証できなければ失効オブジェクトを処理 |
    | 最大経過時間 | 3 分 |

    ![キャッシング動作を構成するための値の設定](direct_update_cdn_7.jpg)

6. キャッシュ・キー内のすべての要求パラメーターを使用するようにキャ
ッシュ・キー動作を構成します (異なるアプリケーションまたはバージョンご
とに異なるダイレクト・アップデート・アーカイブをキャッシュ
に入れるためには、このようにする必要があります)。
例えば、**「動作」**リストから、`「すべてのパラメーターを組み込む (要求からの順序を保持する)」`を選択します。
    ![キャッシュ・キー内のすべての要求パラメーターを使用するようにキャッシュ・キー動作を構成します。](direct_update_cdn_8.jpg)


