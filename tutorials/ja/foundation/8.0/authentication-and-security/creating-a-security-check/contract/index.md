---
layout: tutorial
title: セキュリティー検査コントラクト
breadcrumb_title: セキュリティー検査コントラクト
relevantTo: [android,ios,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
すべてのセキュリティー検査で `com.ibm.mfp.server.security.external.SecurityCheck` インターフェース (セキュリティー検査インターフェース) を実装する必要があります。このインターフェースは、セキュリティー検査と {{ site.data.keys.product_adj }} セキュリティー・フレームワーク間の基本コントラクトを構成します。セキュリティー検査の実装は、以下の要件を満たす必要があります。

* **機能**: セキュリティー検査では、クライアント `authorization` および `introspection` の機能を提供する必要があります。
* **状態管理**: セキュリティー検査は、作成、破棄、現行状態の管理など、その状態を管理する必要があります。
* **構成**: セキュリティー検査は、セキュリティー検査構成オブジェクトを作成する必要があります。このオブジェクトは、サポートされるセキュリティー検査構成プロパティーを定義し、基本構成のカスタマイズのタイプおよび値を検証します。

セキュリティー検査インターフェースの完全なリファレンスについては、[API リファレンスの `SecurityCheck`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/SecurityCheck.html?view=kc) を参照してください。

## セキュリティー検査機能
{: #securityc-check-functions }
セキュリティー検査は、セキュリティー・フレームワークに以下の 2 つの主な機能を提供します。

### Authorization
{: #authorization }
フレームワークは `SecurityCheck.authorize` メソッドを使用してクライアント要求を許可します。クライアントが特定の OAuth スコープへのアクセスを要求すると、フレームワークはスコープ・エレメントをセキュリティー検査にマップします。スコープ内のセキュリティー検査ごとに、フレームワークは `authorize` メソッドを呼び出して、当該セキュリティー検査にマップされたスコープ・エレメントが含まれているスコープの許可を要求します。このスコープは、メソッドの **scope** パラメーターに指定します。 

セキュリティー検査は、response パラメーターに入れて渡された [`AuthorizationResponse` オブジェクト](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/AuthorizationResponse.html?view=kc)に応答を追加します。応答には、セキュリティー検査の名前および応答タイプ (成功、失敗、またはチャレンジのいずれか) が含まれます ([`AuthorizationResponse.ResponseType` を参照](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/AuthorizationResponse.ResponseType.html?view=kc))。

応答にチャレンジ・オブジェクトまたはカスタム成功または失敗のデータが含まれている場合、フレームワークはそのデータを JSON オブジェクトに入れてクライアントのセキュリティー検査チャレンジ・ハンドラーに渡します。成功の場合、応答には、許可が要求されたスコープ (**scope** パラメーターで設定)、および付与された許可の有効期限時刻も含まれます。要求されたスコープへのアクセス権限をクライアントに付与するには、スコープのセキュリティー検査のそれぞれの `authorize` メソッドが成功を返す必要があり、またすべての有効期限時刻が現在時刻より後でなければなりません。

### イントロスペクション
{: #introspection }
フレームワークは `SecurityCheck.introspect` メソッドを使用して、リソース・サーバーのイントロスペクション・データを取得します。このメソッドは、イントロスペクションが要求されたスコープに含まれているセキュリティー検査ごとに呼び出されます。`authorize` メソッドと同様に、`introspect` メソッドは、当該セキュリティー検査にマップされたスコープ・エレメントが含まれている **scope** パラメーターを受け取ります。イントロスペクション・データを返す前に、このメソッドは、セキュリティー検査の現行状態がこのスコープに対して以前に付与された許可をまだサポートしているかを検査します。許可がまだ有効な場合、`introspect` メソッドは、**response** パラメーターに入れて渡された [IntrospectionResponse オブジェクト](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/IntrospectionResponse.html?view=kc)に応答を追加します。

応答には、セキュリティー検査の名前、許可が要求されたスコープ (**scope** パラメーターで設定)、付与された許可の有効期限時刻、および要求されたカスタム・イントロスペクション・データが含まれます。許可を付与できなくなっている場合 (例えば、以前の成功状態の有効期限時刻が経過している場合)、このメソッドは、応答を追加することなく戻ります。

**注:**

* セキュリティー・フレームワークは、セキュリティー検査からの処理結果を収集し、関連データをクライアントに渡します。フレームワークの処理は、セキュリティー検査の状態を一切認識しません。
* `authorize` メソッドまたは `introspect` メソッドを呼び出すと、現行状態の有効期限時刻が経過していなくても、セキュリティー検査の現行状態が変更される可能性があります。 

> `authorize` メソッドおよび `introspect` メソッドについて詳しくは、[ExternalizableSecurityCheck](../../externalizable-security-check) チュートリアルを参照してください。

### セキュリティー検査の状態管理
{: #security-check-state-management }
セキュリティー検査はステートフルです。つまり、セキュリティー検査がその対話状態を追跡および保持する責任を負います。それぞれの許可要求またはイントロスペクション要求で、セキュリティー・フレームワークは、外部ストレージ (通常、分散キャッシュ) から関連するセキュリティー検査の状態を取得します。要求処理の最後に、フレームワークは、セキュリティー検査の状態を外部ストレージに再び保管します。

セキュリティー検査コントラクトにより、セキュリティー検査には以下が要求されます。

* `java.io.Externalizable` インターフェースを実装します。セキュリティー検査はこのインターフェースを使用して、その状態のシリアライゼーションおよびデシリアライゼーションを管理します。
* 有効期限時刻とその現在の状態の非アクティブ・タイムアウトを定義します。セキュリティー検査の状態は許可プロセスにおけるステージを表し、無期限にすることはできません。状態の有効期間と最大非アクティブ時間の具体的な期間は、実装ロジックに従って、セキュリティー検査実装で設定されます。セキュリティー検査は、SecurityCheck インターフェースの `getExpiresAt` メソッドおよび `getInactivityTimeoutSec` メソッドの実装を介して、選択した有効期限時刻および非アクティブ・タイムアウトをフレームワークに通知します。

### セキュリティー検査構成
{: #security-check-configuration }
セキュリティー検査は、構成プロパティーを公開できます。構成プロパティーの値は、アダプター・レベルとアプリケーション・レベルの両方でカスタマイズ可能です。特定のクラスのセキュリティー検査定義により、当該クラスのサポートされる構成プロパティーの中で公開するものが決まり、またクラス定義に設定されているデフォルト値をカスタマイズできます。セキュリティー検査を定義するアダプターと、検査を使用する各アプリケーションの両方に対して、さらにプロパティー値を動的にカスタマイズできます。

セキュリティー検査クラスは、`createConfiguration` メソッドを実装することで、クラスでサポートされるプロパティーを公開します。このメソッドは、`com.ibm.mfp.server.security.external.SecurityCheckConfiguration` インターフェース (セキュリティー検査構成インターフェース) を実装するセキュリティー検査構成クラスのインスタンスを作成します。このインターフェースは、`SecurityCheck` インターフェースを補完し、またセキュリティー検査コントラクトの一部でもあります。セキュリティー検査は、プロパティーをいっさい公開しない構成オブジェクトを作成できますが、`createConfiguration` メソッドは有効な構成オブジェクトを返す必要があり、null を返すことはできません。セキュリティー検査構成インターフェースの完全なリファレンスについては、[`SecurityCheckConfiguration`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/SecurityCheckConfiguration.html?view=kc) を参照してください。 

セキュリティー・フレームワークは、デプロイメント時にセキュリティー検査の `createConfiguration` メソッドを呼び出します。これは、アダプターまたはアプリケーションのすべての構成変更で発生します。メソッドの properties パラメーターには、アダプターのセキュリティー検査定義で定義されているプロパティー、およびそのカスタマイズされた現行値 (またはカスタマイズが行われていない場合はデフォルト値) が含まれます。セキュリティー検査構成の実装では、受け取ったプロパティーの値を検証し、また検証結果を返すメソッドを提供する必要があります。

セキュリティー検査構成では、`getErrors`、`getWarnings`、および `getInfo` の各メソッドを実装する必要があります。抽象セキュリティー検査構成の基底クラスである [`SecurityCheckConfigurationBase`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/security/external/checks/impl/SecurityCheckConfigurationBase.html?view=kc) も、カスタムの `getStringProperty`、`getIntProperty`、および `addMessage` の各メソッドを定義および実装しています。詳しくは、当該クラスのコードの資料を参照してください。

**注:** セキュリティー検査定義内およびアダプターまたはアプリケーションのカスタマイズ内の構成プロパティーの名前と値は、構成クラスで定義されている、サポートされるプロパティーと許可される値に一致している必要があります。

> セキュリティー検査の[カスタム・プロパティーの作成](../#security-check-configuration)について詳細を参照してください。
