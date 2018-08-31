---
layout: tutorial
title: JSONStore のトラブルシューティング
breadcrumb_title: JSONStore
relevantTo: [ios,android,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下に、JSONStore API を使用する際に発生する可能性がある問題を解決するために役立つ情報を記載しています。

## ヘルプ要求をする際の情報提供
{: #provide-information-when-you-ask-for-help }
提供する情報が不足するリスクを負うよりも、多くの情報を提供することをお勧めします。 以下のリストは、JSONStore の問題に関してサポートを受けるために必要な情報の出発点と考えてください。

* オペレーティング・システムおよびバージョン。 例えば、Windows XP SP3 Virtual Machine や Mac OSX 10.8.3。
* Eclipse のバージョン。 例えば、Eclipse Indigo 3.7 Java EE。
* JDK のバージョン。 例えば、Java SE Runtime Environment (ビルド 1.7)。
* {{ site.data.keys.product }} のバージョン。 例えば、IBM Worklight V5.0.6 Developer Edition。
* iOS のバージョン。 例えば、iOS Simulator 6.1 や iPhone 4S iOS 6.0 (非推奨。『非推奨となった機能および API エレメント』を参照)。
* Android のバージョン。 例えば、Android Emulator 4.1.1 や Samsung Galaxy Android 4.0 API Level 14。
* Windows のバージョン。 例えば、Windows 8、Windows 8.1、Windows Phone 8.1。
* adb のバージョン。 例えば、Android Debug Bridge バージョン 1.0.31。
* ログ (iOS の Xcode 出力や Android の logcat 出力など)。

## 問題の切り分けの試行
{: #try-to-isolate-the-issue }
より正確に問題を報告するために問題を切り分けるには、以下のステップを実行します。

1. エミュレーター (Android) またはシミュレーター (iOS) をリセットし、destroy API を呼び出してクリーン・システムで開始します。
2. サポートされている実稼働環境で稼働するようにします。
    * Android >= 2.3 ARM v7/ARM v8/x86 エミュレーターまたはデバイス
    * iOS >= 6.0 シミュレーターまたはデバイス (非推奨)
    * Windows 8.1/10 ARM/x86/x64 シミュレーターまたはデバイス
3. init API または open API にパスワードを渡さずに、暗号化をオフにします。
4. JSONStore により生成された SQLite データベース・ファイルを調べます。 暗号化はオフにする必要があります。

   * Android エミュレーターの場合:

   ```bash
   $ adb shell
   $ cd /data/data/com.<app-name>/databases/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * iOS シミュレーターの場合:

   ```bash
   $ cd ~/Library/Application Support/iPhone Simulator/7.1/Applications/<id>/Documents/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```  

   * Windows 8.1 Universal / Windows 10 UWP シミュレーターの場合:

   ```bash
   $ cd C:\Users\<username>\AppData\Local\Packages\<id>\LocalState\wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * **注:** Web ブラウザー (Firefox、Chrome、Safari、Internet Explorer) で稼働する JavaScript 専用実装環境では、SQLite データベースは使用されません。 ファイルは HTML5 LocalStorage に保管されます。
   * `.schema` がある `searchFields` を調べて、`SELECT * FROM <collection-name>;` を使用してデータを選択します。 sqlite3 を終了するには、`.exit` と入力します。 ユーザー名を init メソッドに渡す場合、ファイルは **the-username.sqlite** という名前になります。 ユーザー名を渡さない場合、ファイルはデフォルトで **jsonstore.sqlite** という名前になります。
5. (Android のみ) JSONStore の詳細出力を有効にします。

   ```bash
   adb shell setprop log.tag.jsonstore-core VERBOSE
   adb shell getprop log.tag.jsonstore-core
   ```

6. デバッガーを使用します。

## 一般的な問題
{: #common-issues }
以下に記載する JSONStore の特性を理解しておくと、発生する可能性のある一般的な問題の解決に役立つ場合があります。  

* バイナリー・データを JSONStore に保管するための唯一の方法は、まずそのデータを base64 でエンコードすることです。 JSONStore 内に実際のファイルの代わりに、ファイル名またはパスを保管します。
* {{ site.data.keys.v62_product_full }} V6.2.0 でのみネイティブ・コードから JSONStore データにアクセスできます。
* モバイル・オペレーティング・システムによって定められた制限以外に、JSONStore 内に保管可能なデータ量に制限はありません。
* JSONStore は永続データ・ストレージを提供します。 メモリー内に保管されるだけではありません。
* コレクション名が数字または記号で始まる場合、init API は失敗します。 IBM Worklight V5.0.6.1 以降は、該当するエラー `4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING` を返します。
* 検索フィールドにおいて、number と integer には違いがあります。 タイプが `number` の場合、`1` や `2` などの数値は、`1.0` や `2.0` として保管されます。 タイプが `integer` の場合は `1` および `2` として保管されます。
* アプリケーションが強制的に停止されたり異常終了したりした場合、そのアプリケーションを再始動して `init` API または `open` API を呼び出すと、そのアプリケーションは常にエラー・コード -1 で失敗します。 この問題が発生した場合、まず `closeAll` API を呼び出します。
* JSONStore の JavaScript 実装環境では、コードを順次に呼び出す必要があります。 1 つの操作が完了するのを待ってから、次の操作を呼び出します。
* Cordova アプリケーション用の Android 2.3.x ではトランザクションはサポートされていません。
* 64 ビット・デバイスで JSONStore を使用する場合、エラー`「java.lang.UnsatisfiedLinkError: dlopen が失敗しました。「...」は 64 ビットではなく 32 ビットです (java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit)」`が表示されることがあります。
* このエラーは、Android プロジェクト内に 64 ビットのネイティブ・ライブラリーがあること、およびこれらのライブラリーが使用された場合 JSONStore は現在機能しないことを意味しています。 確認するために、Android プロジェクトの下の **src/main/libs** または **src/main/jniLibs** に移動して、x86_64 フォルダーまたは arm64-v8a フォルダーがあるかどうかを調べます。 ある場合、これらのフォルダーを削除すると、JSONStore は再び機能するようになります。
* 場合 (または環境) によっては、JSONStore プラグインが初期化される前にフローが `wlCommonInit()` に入ります。 これが原因で JSONStore 関連の API 呼び出しは失敗します。 `cordova-plugin-mfp` ブートストラップは、完了時に `wlCommonInit` 関数をトリガーする `WL.Client.init` を自動的に呼び出します。 この初期化プロセスは JSONStore プラグインでは異なります。 JSONStore プラグインには、`WL.Client.init` 呼び出しを_停止_ する方法はありません。 さまざまな環境で、`mfpjsonjslloaded` が完了する前にフローが `wlCommonInit()` に入ることがあります。
`mfpjsonjsloaded` イベントと `mfpjsloaded` イベントの順序を確認するために、開発者はオプションで `WL.CLient.init` を手動で呼び出すことができます。 これによって、プラットフォーム固有のコードを使用する必要はなくなります。

  `WL.CLient.init` の呼び出しを手動で構成するには、以下のステップを実行します。                             

  1. `config.xml` で、`clientCustomInit` プロパティーを **true** に変更します。

  + `index.js` ファイルで、以下のようにします。                                   
    * 次の行をファイルの先頭に追加します。                
      ```javascript
      document.addEventListener('mfpjsonjsloaded', initWL, false);
      ```           
    * `wlCommonInit()` の `WL.JSONStore.init` 呼び出しはそのままにします。                    

    * 次の関数を追加します。  
    ```javascript                                         
function initWL(){                                                     
        var options = typeof wlInitOptions !== 'undefined' ? wlInitOptions
        : {};                                                                
        WL.Client.init(options);                                           
}                                                                      
```                                                                       

  これは、mfpjsonjsloaded イベントを (wlCommonInit の外部で) 待機します。
これにより、確実にスクリプトがロードされるので、wlCommonInit をトリガーする WL.Client.init をその後に呼び出してから、WL.JSONStore.init を呼び出します。

## ストア内部
{: #store-internals }
JSONStore データの保管方法の例を確認します。

この簡素化された例には、以下の主要な要素があります。

* _id は固有 ID です (例えば、AUTO INCREMENT PRIMARY KEY)。
* json には、保管されている JSON オブジェクトの正確な表現が含まれています。
* name および age は検索フィールドです。
* key は追加の検索フィールドです。

| _id | key | name | age | JSON |
|-----|-----|------|-----|------|
| 1   | c   | carlos | 99 | {name: 'carlos', age: 99} |
| 2   | t   | tim   | 100 | {name: 'tim', age: 100} |

{_id : 1}、{name: 'carlos'}、{age: 99}、{key: 'c'} のいずれかの照会またはこれらの照会の組み合わせを使用して検索を行った場合に返される文書は {_id: 1, json: {name: 'carlos', age: 99} } です。

その他の内部 JSONStore フィールドは以下のとおりです。

* _dirty: 文書がダーティーとマーク付けされているかどうかを判別します。 このフィールドは、文書に対する変更をトラッキングする上で役立ちます。
* _deleted: 文書に削除済みかどうかのマークを付けます。 このフィールドは、コレクションからオブジェクトを削除したり、後でそれらのオブジェクトをバックエンドでの変更のトラッキングに使用したり、これらのオブジェクトを削除するかどうかを決定したりする上で役立ちます。
* _operation: 文書で最後に実行される操作 (例えば、置換) を反映するストリング。

## JSONStore エラー
{: #jsonstore-errors }
### JavaScript
{: #javascript }
JSONStore は、エラー・オブジェクトを使用して、障害の原因に関するメッセージを返します。

JSONStore 操作 (例えば、JSONStoreInstance クラスの find メソッドや add メソッド) 中にエラーが発生した場合、エラー・オブジェクトが返されます。 これは障害の原因に関する情報を提供します。

```javascript
var errorObject = {
  src: 'find', // Operation that failed.
  err: -50, // Error code.
  msg: 'PERSISTENT\_STORE\_FAILURE', // Error message.
  col: 'people', // Collection name.
  usr: 'jsonstore', // User name.
  doc: {_id: 1, {name: 'carlos', age: 99}}, // Document that is related to the failure.
  res: {...} // Response from the server.
}
```

すべてのキー/値のペアがすべてのエラー・オブジェクトの一部であるとは限りません。 例えば、doc 値は、ある文書 (例えば、JSONStoreInstance クラスの remove メソッド) がある文書を削除できなかったために操作が失敗した場合にのみ使用可能です。

### Objective-C
{: #objective-c }
失敗する可能性があるすべての API が、NSError オブジェクトへのアドレスを使用するエラー・パラメーターを取ります。 エラーが通知されないようにするには、nil で渡すことができます。 操作が失敗した場合、エラーと userInfo (存在する場合) を含む NSError がアドレスに取り込まれます。 userInfo には追加の詳細 (例えば、障害の原因となった文書) が含まれていることがあります。

```objc
// This NSError points to an error if one occurs.
NSError* error = nil;

// Perform the destroy.
[JSONStore destroyDataAndReturnError:&error];
```

### Java
{: #java }
すべての Java API 呼び出しが、発生したエラーに応じて特定の例外をスローします。 それぞれの例外を個別に処理することも、すべての JSONStore 例外のアンブレラとして JSONStoreException を catch することもできます。

```java
try {
  WL.JSONStore.closeAll();
}

catch(JSONStoreException e) {
  // Handle error condition.
}
```

### エラー・コードのリスト
{: #list-of-error-codes }
一般的なエラー・コードとその説明のリスト:

|エラー・コード      | 説明 |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | 認識できないエラー。 |
| -75 OS\_SECURITY\_FAILURE | このエラー・コードは requireOperatingSystemSecurity フラグに関連しています。 このエラーは、destroy API が、オペレーティング・システムのセキュリティー (パスコード・フォールバックによるタッチ ID) によって保護されているセキュリティー・メタデータを削除できない場合や、init API または open API がセキュリティー・メタデータを見つけることができない場合に発生する可能性があります。 また、デバイスがオペレーティング・システムのセキュリティーをサポートしない場合に、オペレーティング・システムのセキュリティーの使用が要求された場合にも発生する可能性があります。 |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore はクローズされています。 最初に JSONStore クラスで open メソッドの呼び出しを試行して、ストアへのアクセスを有効にしてください。  |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | トランザクションのロールバック中に問題が発生しました。 |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION | トランザクションの進行中に removeCollection を呼び出すことはできません。  |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | 進行中のトランザクションがある場合は destroy を呼び出すことはできません。 |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | 実行中トランザクションがある場合は closeAll を呼び出すことはできません。  |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | 進行中のトランザクションがある場合はストアを初期化できません。 |
| -43 TRANSACTION_FAILURE | トランザクションの問題が発生しました。 |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | 進行中のトランザクションがない場合は、トランザクションのロールバックをコミットできません。 |
| -41 TRANSACTION\_IN\_POGRESS | 別のトランザクションの進行中には新規トランザクションを開始できません。 |
| -40 FIPS\_ENABLEMENT\_FAILURE | FIPS に何らかの問題があります。
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | ファイル・システムからのファイル情報の取得中に問題が発生しました。 |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | コレクションからの文書の置き換え中に問題が発生しました。 |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | コレクションからの文書の削除中に問題が発生しました。 |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | データ保護鍵 (DPK) の保管中に問題が発生しました。 |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | 入力データの索引付け中に問題が発生しました。 |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | searchFields に渡しているタイプが string、integer、number、または boolean であることを確認してください。  |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | 文書の配列に対する操作 (例えば、replace メソッド) は、特定の文書での動作時には失敗することがあります。 失敗した文書が返され、トランザクションはロールバックされます。 Android では、サポートされないアーキテクチャーで JSONStore を使用しようとした場合もこのエラーが発生します。  |
| -10 ACCEPT\_CONDITION\_FAILED | ユーザーが指定した accept 関数が false を返しました。 |
| -9 OFFSET\_WITHOUT\_LIMIT | オフセットを使用するには、制限を指定する必要もあります。 |
| -8 INVALID\_LIMIT\_OR\_OFFSET | 検証エラー。正整数でなければなりません。 |
| -7 INVALID_USERNAME | 検証エラー ([A から Z]、[a から z]、および [0 から 9] のみでなければなりません)。 |
| -6 USERNAME\_MISMATCH\_DETECTED | ログアウトするには、JSONStore ユーザーは最初に closeAll メソッドを呼び出す必要があります。 一度に存在できるユーザーは 1 人だけです。 |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED | ストアのコンテンツを保持するファイルを削除しようとしたときに、destroy メソッドの問題が発生しました。 |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | キーチェーン (iOS) または共有のユーザー設定 (Android) をクリアしようとしたときに destroy メソッドの問題が発生しました。 |
| -3 INVALID\_KEY\_ON\_PROVISION | 暗号化されたストアに誤ったパスワードが渡されました。 |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | 検索フィールドが動的ではありません。 新しい検索フィールドを使用して init メソッドまたは open メソッドを呼び出す前に、destroy メソッドまたは removeCollection メソッドを呼び出さずに検索フィールドを変更することはできません。 このエラーは、検索フィールドの名前またはタイプを変更した場合に発生する可能性があります。 例: {key: 'string'} から {key: 'number'} または {myKey: 'string'} から {theKey: 'string'}。 |
| -1 PERSISTENT\_STORE\_FAILURE | 一般的なエラー。 ネイティブ・コードで誤動作が発生しました。init メソッドが呼び出された可能性があります。|
| 0 SUCCESS | JSONStore ネイティブ・コードは成功を示すために 0 を返すことがあります。 |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | 検証エラー。 |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | 検証エラー。 |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | 検証エラー。 |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | 検証エラー。 |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | 検証エラー。 |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | 検証エラー。 |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | 検証エラー。 |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB | ダーティーのマークが付けられたすべての文書を選択する照会が失敗しました。 照会の SQL の例は、SELECT * FROM [collection] WHERE _dirty > 0 です。 |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | JSONStoreCollection クラスで push メソッドや load メソッドなどの関数を使用するには、アダプターを init メソッドに渡す必要があります。 |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | 検証エラー。 |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | 検証エラー。 |
| 12 ADAPTER_FAILURE | WL.Client.invokeProcedure の呼び出しで問題 (具体的にはアダプターへの接続の問題) が発生しました。 このエラーは、バックエンドの呼び出しを試行したアダプターでの障害とは異なります。 |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | 検証エラー。 |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | 既存の関数 (find と add) を置き換えるために JSONStoreCollection クラスで enhance メソッドを呼び出すことは許可されていません。 |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | push が文書をアダプターに送信しましたが、JSONStore は文書をダーティーではないとマーク付けできません。 |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | パスワードを使用してコレクションを開始するには、「セキュアなランダム・トークン」が返されるため、{{ site.data.keys.mf_server }} への接続が必要です。 IBM Worklight V5.0.6 以降では、開発者は、オプション・オブジェクトを介して {localKeyGen: true} をローカルで init メソッドに渡すことでセキュアなランダム・トークンを生成できます。 |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | WL.Client.invokeProcedure が障害コールバックを呼び出したため、データをロードできませんでした。 |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | init メソッドに渡されたロード・オブジェクトが、検証に合格しませんでした。 |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | add メソッドの呼び出し時にロード・オブジェクトで使用されたキーに問題があります。 |
| 20 UNDEFINED\_PUSH\_OPERATION | ダーティーな文書をサーバーにプッシュするためのプロシージャーが定義されていません。 例えば、init メソッド (新規文書はダーティーで、操作は「add」) と push メソッド (操作「add」で新規文書を検索) が呼び出されたが、追加プロシージャーを使用する add キーが、コレクションにリンクされたアダプターに見つかりませんでした。 アダプターのリンクは、init メソッド内で行われます。 |
| 21 INVALID\_ADD\_INDEX\_KEY | 追加の検索フィールドで問題が発生しました。 |
| 22 INVALID\_SEARCH\_FIELD | いずれかの検索フィールドが無効です。 渡されるどの検索フィールドも _id、json、_deleted、_operation ではないことを確認してください。 |
| 23 ERROR\_CLOSING\_ALL | 一般的なエラー。 ネイティブ・コードが closeAll メソッドを呼び出したときにエラーが発生しました。 |
| 24 ERROR\_CHANGING\_PASSWORD | パスワードを変更できません。 例えば、渡された古いパスワードが誤っていました。 |
| 25 ERROR\_DURING\_DESTROY | 一般的なエラー。 ネイティブ・コードが destroy メソッドを呼び出したときにエラーが発生しました。|
| 26 ERROR\_CLEARING\_COLLECTION | 一般的なエラー。 ネイティブ・コードが removeCollection メソッドを呼び出したときにエラーが発生しました。 |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | 検証エラー。|
| 28 INVALID\_SORT\_OBJECT | いずれかの JSON オブジェクトが無効であるため、ソートのために指定された配列が無効です。 正しい構文は、各オブジェクトにプロパティーが 1 つだけ含まれる JSON オブジェクトの配列です。 このプロパティーは、ソート基準と、昇順で検索するのか降順で検索するのかを指定してフィールドを検索します。 例: {searchField1 : "ASC"}。 |
| 29 INVALID\_FILTER\_ARRAY | 結果のフィルター処理に指定された配列が無効です。 この配列の正しい構文は、各ストリングが検索フィールドまたは内部 JSONStore フィールドのいずれかになっているストリングの配列です。 詳しくは、『ストア内部』を参照してください。|
| 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | 配列が JSON オブジェクトのみの配列ではない場合の検証エラー。 |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | 検証エラー。 |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | 検証エラー。 |
