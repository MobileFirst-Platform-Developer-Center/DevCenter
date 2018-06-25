---
layout: tutorial
title: MobileFirst Operations Console を介したアプリケーション管理
breadcrumb_title: Administrating using the console
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
アプリをロックまたはアクセスを拒否するか、通知メッセージを表示することにより、 {{ site.data.keys.mf_console }} を使用して {{ site.data.keys.product_adj }} アプリケーションを管理することができます。

以下のいずれかの URL を入力することによって、コンソールを開始できます。

* 実動またはテスト用のセキュア・モード: `https://hostname:secure_port/mfpconsole`
* 開発: `http://server_name:port/mfpconsole`

{{ site.data.keys.mf_console }} にアクセスする権限を持つログインとパスワードが必要です。 詳しくは、[{{ site.data.keys.mf_server }} 管理用のユーザー認証の構成](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)を参照してください。

{{ site.data.keys.mf_console }} を使用してアプリケーションを管理することができます。

{{ site.data.keys.mf_console }} から Analytics コンソールにアクセスして、Analytics サーバーによる分析用モバイル・データの収集を制御することもできます。 詳しくは、[{{ site.data.keys.mf_console }} からのデータ収集の有効化または無効化](../../analytics/console/#enabledisable-analytics-support)を参照してください。

#### ジャンプ先
{: #jump-to }

* [モバイル・アプリケーションの管理](#mobile-application-management)
* [アプリケーションの状況とトークン・ライセンス](#application-status-and-token-licensing)
* [ランタイム環境での操作のエラー・ログ](#error-log-of-operations-on-runtime-environments)
* [管理操作の監査ログ](#audit-log-of-administration-operations)

## モバイル・アプリケーションの管理
{: #mobile-application-management }
{{ site.data.keys.product_adj }} モバイル・アプリケーション管理機能により、 {{ site.data.keys.mf_server }} オペレーターと管理者は、アプリケーションに対するユーザーおよびデバイスのアクセス権限について、より詳細な管理が可能になります。

{{ site.data.keys.mf_server }} は、モバイル・インフラストラクチャーにアクセスする試みをすべてトラッキングし、アプリケーション、ユーザー、アプリケーションがインストールされるデバイスに関する情報を保管します。 アプリケーション、ユーザー、およびデバイス間のマッピングは、サーバーのモバイル・アプリケーション管理機能の基礎を形成します。

IBM {{ site.data.keys.mf_console }} を使用して、リソースへのアクセスをモニターし管理します。

* ユーザーを名前で検索し、ユーザーがリソースへのアクセスに使用しているデバイスおよびアプリケーションに関する情報を表示します。
* デバイスをデバイスの表示名で検索し、デバイスに関連づけられたユーザーおよびこのデバイスで使用される登録された {{ site.data.keys.product_adj }} アプリケーションを表示します。
* 特定のデバイス上にあるアプリケーションのすべてのインスタンスからリソースにアクセスするのをブロックします。 これは、デバイスが紛失したり盗まれたときに便利です。
* 特定のデバイス上にある特定のアプリケーションに対してのみ、リソースにアクセスするのをブロックします。 例えば、従業員の部署が変更になったときに、その従業員の以前の部署のアプリケーションのアクセスはブロックする一方で、同じデバイス上にある他のアプリケーションからのアクセスは許可することができます。
* デバイスの登録を抹消し、すべての登録とそのデバイスで収集されたモニター・データを削除します。

アクセス・ブロックには以下の特徴があります。

* ブロッキング・オペレーションは元に戻すことができます。 {{ site.data.keys.mf_console }} でデバイスまたはアプリケーション・ステータスを変更すると、ブロックを解除することができます。
* ブロックは保護リソースにのみ適用されます。 ブロックされたクライアントは、引き続きアプリケーションを使用して保護されていないリソースにアクセスすることができます。 保護されていないリソース (Unprotected resources) を参照してください。
* {{ site.data.keys.mf_server }} 上のアダプター・リソースへのアクセスは、この操作を選択した直後にブロックされます。 ただし、これは外部サーバー上のリソースには当てはまらない場合があります。アプリケーションに期限切れになっていない有効なアクセス・トークンがまだ存在する可能性があるためです。

### デバイスの状況
{: #device-status }
{{ site.data.keys.mf_server }} は、サーバーにアクセスするすべてのデバイスの状況情報を保守します。 使用できるステータス値は、 **アクティブ (Active)**、**紛失 (Lost)**、 **盗難 (Stolen)**、**期限切れ (Expired)**、および**使用不可 (Disabled)**です。

デフォルト・デバイスの状況は **アクティブ (Active)** で、このデバイスからのアクセスがブロックされないことを示します。 このステータスを **紛失 (Lost)**、 **盗難 (Stolen)**、または **使用不可 (Disabled)** に変更して、デバイスからアプリケーション・リソースへのアクセスをブロックすることができます。 ステータスはいつでも**アクティブ (Active)** に復元してアクセスを再度許可することができます。 [{{ site.data.keys.mf_console }} でのデバイス・アクセスの管理](#managing-device-access-in-mobilefirst-operations-console)を参照してください。

**期限切れ (Expired)** ステータスは、デバイスがこのサーバー・インスタンスに最後に接続してから事前構成の非活動期間が経過した後に {{ site.data.keys.mf_server }} によって設定される、特殊なステータスです。 このステータスは、ライセンス・トラッキングに使用され、デバイスのアクセス権に影響しません。 **期限切れ (Expired)** ステータスのデバイスがサーバーに再接続すると、そのステータスは **アクティブ (Active)**に復元され、デバイスにサーバーへのアクセス権限が付与されます。

### デバイスの表示名
{: #device-display-name }
{{ site.data.keys.mf_server }} は、{{ site.data.keys.product_adj }} クライアント SDK が割り当てる固有のデバイス ID でデバイスを識別します。 デバイスの表示名を設定すると、デバイスをその表示名で検索することができます。 アプリケーション開発者は `WLClient` クラスの `setDeviceDisplayName` メソッドを使用して、デバイスの表示名を設定します。 [{{ site.data.keys.product_adj }} クライアント・サイド API](../../api/client-side-api/javascript/client/) の `WLClient` 文書を参照してください。 (JavaScript クラスは `WL.Client` です。) Java アダプター開発者 (セキュリティー検査の開発者など) は、com.ibm.mfp.server.registration.external.model `MobileDeviceData` クラスの `setDeviceDisplayName` メソッドを使用してデバイス表示名を設定することもできます。 [MobileDeviceData](../../api/client-side-api/objc/client/) を参照してください。

### {{ site.data.keys.mf_console }} でのデバイス・アクセスの管理
{: #managing-device-access-in-mobilefirst-operations-console }
リソースへのデバイス・アクセスをモニターして管理するには、{{ site.data.keys.mf_console }} ダッシュボードの「デバイス」タブを選択します。

検索フィールドを使用して、デバイスに関連付けられた ユーザー ID でデバイスを検索するか、デバイスの表示名で検索します (設定されている場合)。 [デバイスの表示名](#device-display-name)を参照してください。 ユーザー ID の一部またはデバイス表示名の一部でも検索することができます (最低 3 文字)。

検索結果には、指定されたユーザー ID またはデバイス表示名に一致するすべてのデバイスが表示されます。 デバイスごとに、デバイス ID と表示名、デバイス・モデル、オペレーティング・システム、およびデバイスに関連付けられたユーザー ID のリストを確認することができます。

デバイスの状況 (Device Status) 列は、デバイスの状況を表示します。 デバイスの状況を **紛失 (Lost)**、 **盗難 (Stolen)**、または **使用不可 (Disabled)** に変更して、デバイスから保護リソースへのアクセスをブロックすることができます。 ステータスを**アクティブ (Active)** に戻すと、元のアクセス権限が復元します。

**アクション (Actions)** 列で**登録抹消 (Unregister)** を選択して、デバイスの登録を抹消することができます。 デバイスの登録抹消は、デバイスにインストールされているすべての {{ site.data.keys.product_adj }} アプリケーションの登録データを削除します。 また、デバイスの表示名、デバイスに関連付けられたユーザーのリスト、およびアプリケーションがこのデバイスに登録したパブ リック属性が削除されます。

**注:** **登録抹消 (Unregister)** アクションは元に戻すことができません。 デバイス上の {{ site.data.keys.product_adj }} アプリケーションの 1 つが次回サーバーにアクセスしようとすると、新しいデバイス ID を使用して再登録されます。 デバイスを再登録することを選択すると、デバイスの状況が**アクティブ (Active)** に設定され、以前のブロックの有無にかかわらず、デバイスに保護リソースへのアクセス権限が付与されます。 そのため、デバイスをブロックしたい場合は、デバイスを登録抹消しないでください。 かわりに、デバイスの状況を**紛失 (Lost)**、**盗難 (Stolen)**、または**使用不可 (Disabled)** に変更してください。

特定のデバイス上でアクセスされたすべてのアプリケーションを表示するには、デバイス・テーブルのデバイス ID の隣にある拡張矢印アイコンを選択します。 表示されたアプリケーション・テーブルの各行に、アプリケーションの名前とアプリケーションのアクセス状況 (このデバイスのこのアプリケーションで保護リソースへのアクセスが可能かどうか) が含まれます。 アプリケーションの状況を **使用不可（Disabled）** に変更して、このデバイスのアプリケーションに限定してアクセスをブロックすることができます。

#### ジャンプ先
{: #jump-to-1 }

* [保護リソースへのアプリケーション・アクセスのリモート側での無効化](#remotely-disabling-application-access-to-protected-resources)
* [管理者メッセージの表示](#displaying-an-administrator-message)
* [複数言語での管理者メッセージの定義](#defining-administrator-messages-in-multiple-languages)

### 保護リソースへのアプリケーション・アクセスのリモート側での無効化
{: #remotely-disabling-application-access-to-protected-resources }
{{ site.data.keys.mf_console }} (コンソール) を使用して、特定のモバイル・オペレーティング・システム上のアプリケーションの特定バージョンへのユーザー・アクセスを無効化し、ユーザーにカスタム・メッセージを表示することができます。

1. コンソールのナビゲーション・サイドバーにある**「アプリケーション」 **セクションからご使用のアプリケーションのバージョンを選択し、次にアプリケーションの**「管理」**タブを選択します。
2. ステータスを**「アクセス無効」**に変更します。
3. **最新バージョンの URL」**フィールドで、オプションでアプリケーションの新規バージョン (通常は、適切なパブリックまたはプライベートのアプリケーション・ストア内にある) の URL を指定します。 一部の環境では、アプリケーション・バージョンの「詳細」ビューに直接アクセスするための URL が Application Center によって表示されます。 [アプリケーション・プロパティー (Application properties)](../../appcenter/appcenter-console/#application-properties) を参照してください。
4. **「デフォルトの通知メッセージ」**フィールドで、ユーザーがアプリケーションにアクセスしようとする際に表示するカスタム通知メッセージを追加します。 次のサンプル・メッセージは、最新バージョンにアップグレードするようにユーザーに指示します。

   ```bash
   このバージョンは、現在ではサポートされなくなりました。 最新バージョンにアップグレードしてください。
   ```

5. **「サポート対象ロケール」**セクションで、オプションで他の言語の通知メッセージを指定することができます。
6. **「保存」**を選択して変更を適用します。

ユーザーがリモート側で無効にされたアプリケーションを実行すると、カスタム・メッセージが記載されたダイアログ・ウィンドウが表示されます。 メッセージは、保護リソースへのアクセスを必要とするすべてのアプリケーション対話で、またはアプリケーションがアクセス・トークンを取得しようとする場合に表示されます。 バージョン・アップグレード URL を指定すると、デフォルトの **「閉じる」**ボタンに加え、新規バージョンへアップグレードするための**「新規バージョンを入手」 **ボタンがダイアログに表示されます。 ユーザーがバージョンをアップグレードせずにダイアログ・ウィンドウを閉じる場合、保護リソースにアクセスする必要のない一部のアプリケーションで処理を続行することができます。 ただし、保護リソースへのアクセスを必要とするすべてのアプリケーション対話で、再びダイアログ・ウィンドウが表示され、アプリケーションはリソースへのアクセス権限を付与されません。

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### 管理者メッセージの表示
{: #displaying-an-administrator-message }
通知メッセージを構成するには、以下の手順に従ってください。 このメッセージを使用して、計画的な保守のダウンタイムなど、一時的な状態をアプリケーション・ユーザーに通知することができます。

1. {{ site.data.keys.mf_console }} ナビゲーション・サイドバーの**「アプリケーション」**セクションからご使用のアプリケーションのバージョンを選択し、次にアプリケーションの「管理」タブを選択します。
2. ステータスを**「アクティブおよび通知 (Active and Notifying)」**に変更します。
3. カスタム始動メッセージを追加します。 以下のサンプル・メッセージは、ユーザーにアプリケーションの計画的な保守作業をお知らせします。

   ```bash
   計画的な保守のため、サーバーは土曜日の午前 4 時から午後 6 時まで使用不可となります。
   ```

4. 「サポート対象ロケール」セクションで、オプションで他の言語の通知メッセージを指定することができます。

5. **「保存」**を選択して変更を適用します。

メッセージは、アプリケーションが最初に {{ site.data.keys.mf_server }} を使用して保護リソースにアクセスするときや、アクセス・トークンを取得するときに表示されます。 アプリケーションが始動時にアクセス・トークンを取得すると、メッセージはこの段階で表示されます。 それ以外の場合は、メッセージは、保護リソースへアクセスするかアクセス・トークンを取得するアプリケーションからの最初の要求で表示されます。 このメッセージは最初の対話時に 1 度しか表示されません。

### 複数言語での管理者メッセージの定義
{: #defining-administrator-messages-in-multiple-languages }
<b>注:</b> Microsoft Internet Explorer (IE) および Microsoft Edge では、管理メッセージはオペレーティング・システムの地域形式の設定に従って表示されます。構成されているブラウザーやオペレーティング・システムの表示言語の設定に従って表示されるものではありません。 [IE および Edge の Web アプリケーションの制限](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge)を参照してください。


コンソールを使用して定義したアプリケーション管理者メッセージを表示するための複数言語を構成するには、以下の手順を実行してください。 これらのメッセージはデバイスのロケールに基づいて送信されるもので、モバイル・オペレーティング・システムがロケールの指定に使用する標準に準拠していなければなりません。

1. {{ site.data.keys.mf_console }} ナビゲーション・サイドバーの**「アプリケーション」**セクションからご使用のアプリケーションのバージョンを選択し、次にアプリケーションの**「管理」**タブを選択します。
2. **「アクティブおよび通知 (Active and Notifying)」**または**「アクセス無効」** のステータスを選択します。
3. **「ロケールの更新 (Update Locales)」**を選択します。 ディスプレイ・ダイアログ・ウィンドウの**「ファイルのアップロード (Upload File)」**セクションで、**「アップロード」**を選択し、ロケールを定義する CSV ファイルの場所を参照します。

   CSV ファイルの各行に、1 対のコンマ区切りの文字列が含まれています。 最初の文字列は、ロケール・コード (フランス語 (フランス) の場合は fr-FR、英語の場合は en など) で、2 番目の文字列は対応する言語のメッセージ・テキストです。 指定されたロケール・コードは、ISO 639-1、ISO 3166-2、および ISO 15924 など、モバイル・オペレーティング・システムがロケールの指定に使用する標準に準拠していなければなりません。

   > **注:** CSV ファイルを作成するには、UTF-8 エンコードをサポートするエディター (Notepad など) を使用する必要があります。

   以下に、複数ロケールの同一メッセージを定義する CSV ファイルの例を示します。

   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. **「通知メッセージの確認 (Verify notification message)」**セクションで、 CSV ファイルのロケール・コードとメッセージの表を確認することができます。 メッセージを確認し、**「OK」**を選択します。
いつでも「編集」を選択して、ロケール CSV ファイルを置き換えることができます。 このオプションを使用して、空の CSV ファイルをアップロードしてすべてのロケールを削除することもできます。
5. **「保存」**を選択して変更を適用します。

ローカライズされた通知メッセージは、デバイスのロケールに応じて、ユーザーのモバイル・デバイスに表示されます。 デバイスのロケールにメッセージが構成されなかった場合は、指定したデフォルトのメッセージが表示されます。

## アプリケーションの状況とトークン・ライセンス
{: #application-status-and-token-licensing }
不十分なトークンが原因でブロック済みの状況が生じたら、{{ site.data.keys.mf_console }} で正しいアプリケーション状況に手動で復元する必要があります。

トークン・ライセンスを使用している場合、アプリケーションのライセンス・トークンが不十分になると、そのアプリケーションのすべてのバージョンのアプリケーション状況が**ブロック済み**に変わります。 この場合、そのアプリケーションのいずれのバージョンの状況も変更できなくなります。 以下のメッセージが {{ site.data.keys.mf_console }} に表示されます。

```bash
アプリケーションはライセンスの期限が切れためブロックされました。
```

その後、アプリケーション実行のために十分なトークンが空くか、お客様の組織が追加でトークンを購入すれば、{{ site.data.keys.mf_console }} に以下のメッセージが表示されます。

```bash
アプリケーションはライセンスの期限が切れためブロックされましたが、現在ライセンスは使用可能です。
```

この時点ではまだ、表示された状況は**ブロック済み**のままです。 「状況」フィールドを編集することで、メモリーまたは独自のレコードから正しい現在の状況を手動で復元する必要があります。 {{ site.data.keys.product }} は、不十分なライセンス・トークンが原因でブロックされたアプリケーションの {{ site.data.keys.mf_console }} 内の**ブロック済み**状況の表示を管理しません。 そのようなブロック済みアプリケーションを {{ site.data.keys.mf_console }} で表示可能な本来の状況に復元する作業は、お客様の責任で行ってください。

## ランタイム環境での操作のエラー・ログ
{: #error-log-of-operations-on-runtime-environments }
エラー・ログを使用すると、選択したランタイム環境で {{ site.data.keys.mf_console }} またはコマンド・ラインから開始され、失敗した管理操作にアクセスして、サーバーへ失敗の影響を確認できます。

トランザクションが失敗すると、ステータス・バーにエラーの通知が表示され、エラー・ログへのリンクが表示されます。 エラー・ログを使用すると、例えば各サーバーの状況と具体的なエラー・メッセージなど、エラーの詳細情報を取得したり、エラーの履歴を調べることができます。 エラー・ログでは、最新の操作が最初に表示されます。

{{ site.data.keys.mf_console }} でランタイム環境の**「エラー・ログ」**をクリックして、エラー・ログにアクセスします。

失敗した操作を参照する行を展開し、各サーバーの現在の状態についての詳細にアクセスします。 完全なログにアクセスするには、**「ログのダウンロード」**をクリックしてログをダウンロードします。

![コンソールのエラー・ログ](error-log.png)

## 管理操作の監査ログ
{: #audit-log-of-administration-operations }
{{ site.data.keys.mf_console }} では、管理操作の監査ログを参照することができます。

{{ site.data.keys.mf_console }} は、ログインの監査ログ、ログアウトの監査ログ、およびアプリケーションまたはアダプターのデプロイまたはアプリケーションのロックといったすべての管理操作の監査ログへのアクセスを提供します。 監査ログは、{{ site.data.keys.product_adj }} 管理サービスの Web アプリケーション上の **mfp.admin.audit** Java Naming and Directory Interface (JNDI) プロパティーを **false** に設定することで無効にすることができます。

監査ログにアクセスするには、ヘッダー・バーのユーザー名をクリックして**「バージョン情報」**を選択し、**「追加サポート情報 (Additional support information)」**、**「監査ログのダウンロード」**とクリックします。

| フィールド名 | 説明 |
|------------|-------------|
| Timestamp	 | レコードが作成された日時。 |
| Type	     | 操作のタイプ。 可能な値については、以下の操作タイプのリストを参照してください。 |
| User	     | サインインしているユーザーの**ユーザー名**。 |
| Outcome	 | 操作の結果。可能な値は、SUCCESS、ERROR、PENDINGです。 |
| ErrorCode	 | 結果が ERROR の場合、ErrorCode はエラーの内容を示します。 |
| Runtime	 | 操作に関連する {{ site.data.keys.product_adj }} プロジェクトの名前。 |

以下のリストに操作の Type の可能な値を示します。

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime
