---
layout: tutorial
title: IMFData または Cloudant SDK を使用して Cloudant にモバイル・データを保管するアプリケーションのマイグレーション
breadcrumb_title: モバイル・データを保管するアプリケーションのマイグレーション
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
モバイル・アプリケーションのデータを Cloudant データベースに保管できます。Cloudant は、JSON データ、フルテキスト・データ、および地理情報データなどの幅広い種類のデータ・タイプの処理が可能な、拡張 NoSQL データベースです。Java™ 、Objective-C、および Swift 用の SDK があります。

> CloudantToolkit および IMFData のフレームワークは {{ site.data.keys.product_full }} v8.0 で非推奨になりました

* iOS の場合は、CloudantToolkit フレームワークおよび IMFData フレームワークの代わりに [CDTDatastore](https://github.com/cloudant/CDTDatastore) SDK を使用します。
* Android の場合は、CloudantToolkit フレームワークおよび IMFData フレームワークの代わりに [Cloudant Sync Android SDK](https://github.com/cloudant/sync-android) を使用します。Cloudant Sync を使用すると、データをローカル側で永続化させ、リモート・データ・ストアで複製することができます。

リモート・ストアに直接アクセスしたい場合は、アプリケーションで REST 呼び出しを使用し、「[Cloudant API Reference](https://docs.cloudant.com/api.html)」を参照してください。

### Cloudant か JSONStore か
{: #cloudant-versus-jsonstore }
以下のシナリオでは、Cloudant の代わりに JSONStore を使用することを検討することをお勧めします。

* FIPS 140-2 準拠方式で保管される必要があるデータをモバイル・デバイスに保管している場合。
* デバイスとエンタープライズ間でデータを同期する必要がある場合。
* ハイブリッド・アプリケーションを開発している場合。

JSONStore について詳しくは、『[JSONStore](../../application-development/jsonstore)』を参照してください。

#### ジャンプ先
{: #jump-to }
* [{{ site.data.keys.product_adj }} と Cloudant のセキュリティーの統合](#integrating-mobilefirst-and-cloudant-security)
* [データベースの作成](#creating-databases)
* [デバイスのデータの暗号化](#encrypting-data-on-the-device)
* [ユーザー・アクセス権の設定](#setting-user-permissions)
* [データのモデル化](#modeling-data)
* [CRUD 操作の実行](#performing-crud-operations)
* [索引の作成](#creating-indexes)
* [データの照会](#querying-data)
* [オフライン・ストレージおよび同期のサポート](#supporting-offline-storage-and-synchronization)

## {{ site.data.keys.product_adj }} と Cloudant のセキュリティーの統合
{: #integrating-mobilefirst-and-cloudant-security }
### アダプター・サンプル
{: #adapter-sample }
サンプルをダウンロードするには、「Sample: [mfp-bluelist-on-premises](https://github.com/MobileFirst-Platform-Developer-Center/BlueList-On-Premise)」を参照してください。

Bluelist サンプルに含まれるアダプターを理解するには、[Cloudant セキュリティー](https://cloudant.com/for-developers/faq/auth/)と [{{ site.data.keys.product_adj }} セキュリティー・フレームワーク](../../authentication-and-security)の両方を理解する必要があります。

Bluelist アダプター・サンプルには以下の 2 つの主要な機能があります。

* {{ site.data.keys.product_adj }} OAuth トークンを Cloudant セッション Cookie と交換する。
* Bluelist サンプルから、Cloudant への必要な admin 要求を実行する。

サンプルでは、サーバー上で admin 権限を求める API 要求を実行する方法を示します (そのようにすることがセキュアである場合)。自分の admin 資格情報をモバイル・デバイスに配置することは可能ですが、モバイル・デバイスからのアクセスを制限することをお勧めします。

Bluelist のサンプルでは、{{ site.data.keys.product_adj }} のセキュリティーと Cloudant のセキュリティーを統合します。アダプターのサンプルでは、{{ site.data.keys.product_adj }} ID を Cloudant ID にマップします。モバイル・デバイスは、Cloudant セッション Cookie を受け取って、非 admin API 要求を実行します。このサンプルでは、Couch セキュリティー・モデルを使用します。

### REST エンドポイントの登録
{: #enroll-rest-endpoint }
以下の図は、Bluelist アダプター・サンプルの **/enroll** エンドポイントによって実行される統合を示したものです。

![サンプル統合図](SecurityIntegration.jpg)

1. モバイル・デバイスが、{{ site.data.keys.product_adj }} OAuth トークンを {{ site.data.keys.mf_server }} から取得します。
2. モバイル・デバイスは、 アダプターで **/enroll** でエンドポイントを呼び出します。
3.  アダプター・サンプルが {{ site.data.keys.mf_server }} を使用して {{ site.data.keys.product_adj }} OAuth トークンを検証します。
4. 有効である場合は、Cloudant への admin API 要求を実行します。サンプルは、**_users** データベースで既存の Cloudant ユーザーをチェックします。
    * そのユーザーが存在する場合は、**_users** データベースで Cloudant ユーザー資格情報を検索します。
    * 新規ユーザーが渡された場合は、 Cloudant 管理者資格情報を使用し、新規 Cloudant ユーザーを作成し、**_users** データベースに保管します。
    * ユーザーに固有のデータベース名を作成し、Cloudant 上にその名前を持つリモート・データベースを作成します。
    * Cloudant ユーザーに、新しく作成したデータベースの読み取り/書き込み権限を付与します。
    * Bluelist アプリケーションに必要な索引を作成します。
5. 新規の Cloudant セッション Cookie を要求します。
6. アダプター・サンプルが、Cloudant セッション Cookie、リモート・データベース名、および Cloudant URL をモバイル・デバイスに返します。
7. セッション Cookie の有効期限が切れるまで、モバイル・デバイスが、Cloudant に対して直接要求を行います。

### セッション Cookie REST エンドポイント
{: #sessioncookie-rest-endpoint }
セッション Cookie の有効期限が切れた場合、モバイル・デバイスは Cloudant セッション cookie と {{ site.data.keys.product_adj }} OAuth トークンを **/sessioncookie** エンドポイントで交換できます。

## データベースの作成
{: #creating-databases }
### ローカル・データ・ストアへのアクセス
{: #accessing-local-data-stores }
ローカル・データ・ストアを使用して、オフラインの場合でも、高速にアクセスできるように、クライアント・デバイス上にデータを保管できます。  
ローカル・データベースにアクセスするための Store オブジェクトを作成するには、データ・ストアの名前を指定します。

> **重要:** データベース名は小文字でなければなりません。

#### iOS
{: #ios }
##### 変更前 (IMFData/CloudantToolkit を使用):
{: #before-with-imdata-cloudanttoolkit }

**Objective-C**  

```objc
//Get reference to data manager
IMFDataManager *manager = [IMFDataManager sharedInstance];
NSString *name = @"automobiledb";
NSError *error = nil;
```
**Swift**

```swift
//Create local store
CDTStore *store = [manager localStore:name error:&error];
let manager = IMFDataManager.sharedInstance()
let name = "automobiledb"

var store:CDTStore?
do {
    store = try manager.localStore(name)
} catch let error as NSError {
    // Handle error
}
```

##### 変更後 (Cloudant Sync を使用):
{: #after-with-cloudant-sync }

**Objective-C**  

```objc
// Get reference to datastore manager
CDTDatastoreManager *datastoreManager = existingDatastoreManager;
NSString *name = @"automobiledb";
NSError *error = nil;

//Create datastore
CDTDatastore *datastore = [datastoreManager datastoreNamed:name error:&error];
```

**Swift**

```swift
// Get reference to datastore manager
let datastoreManager:CDTDatastoreManager = existingDatastoreManager
let name:String  = "automobiledb"

//Create local store
var datastore:CDTDatastore?
do{
    datastore = try datastoreManager.datastoreNamed(name)
}catch let error as NSError{
    // Handle error
}
```

#### Android
{: #android }
##### 変更前 (IMFData/CloudantToolkit を使用):
{: before-with-imfdata-cloudanttoolkit }

```java
// Get reference to DataManager
DataManager manager = DataManager.getInstance();

// Create local store
String name = "automobiledb";

Task<Store> storeTask = manager.localStore(name);
storeTask.continueWith(new Continuation<Store, Void>() {
    @Override
    public Void then(Task<Store> task) throws Exception {
        if(task.isFaulted()){
            // Handle error
        }else{
            // Do something with Store
            Store store = task.getResult();
        }
        return null;
    }
});
```

##### 変更後 (Cloudant Sync を使用): Android:
{: #after-with-cloudant-sync-android }
```java
// Create DatastoreManager
   File path = context.getDir("databasedir", Context.MODE_PRIVATE);
   DatastoreManager manager = new DatastoreManager(path.getAbsolutePath());

   // Create a Datastore
       String name = "automobiledb";
       Datastore datastore = manager.openDatastore(name);
```

### リモート・データ・ストアの作成
{: #creating-remote-data-stores }
リモート・ストアにデータを保存するために、データ・ストア名を指定します。

#### iOS
{: #for-ios }
##### 変更前 (IMFData/CloudantToolkit を使用): iOS:
{: #before-with-imfdata-cloudanttoolkit-for-ios }

**Objective-c**

```objc
// Get reference to data manager
IMFDataManager *manager = [IMFDataManager sharedInstance];
NSString *name = @"automobiledb";

// Create remote store
[manager remoteStore:name completionHandler:^(CDTStore *createdStore, NSError *error) {
    if(error){
        // Handle error
    }else{
        CDTStore *store = createdStore;
        NSLog(@"Successfully created store: %@", store.name);
    }
}];
```

**Swift**

```swift
let manager = IMFDataManager.sharedInstance()
let name = "automobiledb"

manager.remoteStore(name, completionHandler: { (createdStore:CDTStore!, error:NSError!) -> Void in
    if nil != error {
        //Handle error
    } else {
        let store:CDTStore = createdStore
        print("Successfully created store: \(store.name)")
    }
})
```

##### 変更後 (Cloudant Sync を使用): iOS:
{: #after-with-cloudant-sync-for-ios }
**Objective-c**

```objc
```

**Swift**

```swift
```

#### Android
{: #for-android }
##### 変更前 (IMFData/CloudantToolkit を使用): Android:
{: #before-with-imfdata-cloudanttoolkit-for-android }

```java
```

##### 変更後 (Cloudant Sync を使用): Android:
{: #after-with-cloudant-sync-for-android }
```java
```

## デバイスのデータの暗号化
{: #encrypting-data-on-the-device }
モバイル・デバイス上のローカル・データ・ストアの暗号化を有効にするには、アプリケーションを更新して暗号化機能を含むようにし、暗号化されたデータ・ストアを作成する必要があります。

### iOS デバイスのデータの暗号化
{: #encrypting-data-on-ios-devices }
1. CocoaPods を使用して暗号化機能を取得します。
   * Podfile を開き、以下の行を追加します。

   ##### 変更前 (IMFData/CloudantToolkit を使用):
   {: #before-with-imfdata-cloudanttoolkit }    
   ```xml
pod 'IMFDataLocal/SQLCipher'
```

   ##### 変更後 (Cloudant Sync を使用): iOS デバイスのデータの暗号化:
   {: after-with-cloudant-sync-encrypt-ios-devices }
   ```xml
pod 'CDTDatastore/SQLCipher'```        

   詳しくは、[CDTDatastore の暗号化に関する資料](https://github.com/cloudant/CDTDatastore/blob/master/doc/encryption.md)を参照してください。

   * 以下のコマンドを実行して、アプリケーションに依存関係を追加します。

     ```bash
pod install```

2. Swift アプリケーション内で暗号化機能を使用するには、アプリケーションの関連ブリッジング・ヘッダーに以下の import を追加します。

   ##### 変更前 (IMFData/CloudantToolkit を使用): iOS デバイスのデータの暗号化:
   {: #before-with-imfdata-cloudanttoolkit-encrypt-ios-devices}
   ```objc
   #import <CloudantSync.h>
   #import <CloudantSyncEncryption.h>
   #import <CloudantToolkit/CloudantToolkit.h>
   #import <IMFData/IMFData.h>
   ```

   ##### 変更後 (Cloudant Sync を使用): iOS デバイスのデータの暗号化 (Swift):
   {: #after-with-cloudant-sync-encrypt-ios-swift }
   ```objc
   #import <CloudantSync.h>
   #import <CloudantSyncEncryption.h>
   ```

3. 暗号化を行うように鍵プロバイダーと共にローカル・ストアを初期化します。

   > **警告:** データベースを作成した後でパスワードを変更すると、既存のデータベースを暗号化解除できなくなるため、エラーが発生します。データベースが暗号化された後でパスワードを変更することはできません。パスワードを変更するには、データベースを削除する必要があります。

   ##### 変更前 (IMFData/CloudantToolkit を使用) : 暗号化のためのローカル・ストアの初期化:
   {: #before-with-imfdata-cloudanttoolkit-initialize-local-store }
   **Objective-C**

   ```objc
   //Get reference to data manager
   IMFDataManager *manager = [IMFDataManager sharedInstance];
   NSString *name = @"automobiledb";
   NSError *error = nil;

   // Initalize a key provider
   id<CDTEncryptionKeyProvider> keyProvider = [CDTEncryptionKeychainProvider providerWithPassword: @"passw0rd" forIdentifier: @"identifier"];

   //Initialize local store
   CDTStore *localStore = [manager localStore: name withEncryptionKeyProvider: keyProvider error: &error];
   ```

   **Swift**

   ```swift
   let manager = IMFDataManager.sharedInstance()
   let name = "automobiledb"

   let keyProvider = CDTEncryptionKeychainProvider(password: "passw0rd", forIdentifier: "identifier")
   var store:CDTStore?
   do {
        store = try manager.localStore(name, withEncryptionKeyProvider: keyProvider)
   } catch let error as NSError {
        // Handle error
}
```

   ##### 変更後 (Cloudant Sync を使用) : 暗号化のためのローカル・ストアの初期化:
   {: #after-with-cloudant-sync-initialize-local-store }
   **Objective-C**

   ```objc
   // Get reference to datastore manager
   CDTDatastoreManager *datastoreManager = existingDatastoreManager;
   NSString *name = @"automobiledb";
   NSError *error = nil;

   // Create KeyProvider
   id<CDTEncryptionKeyProvider> keyProvider = [CDTEncryptionKeychainProvider providerWithPassword: @"passw0rd" forIdentifier: @"identifier"];

   //Create local store
   CDTDatastore *datastore = [datastoreManager datastoreNamed:name withEncryptionKeyProvider:keyProvider error:&error];
   ```

   **Swift**

   ```swift
   // Get reference to datastore manager
   let datastoreManager:CDTDatastoreManager = existingDatastoreManager
   let name:String  = "automobiledb"

   //Create local store
   var datastore:CDTDatastore?
   let keyProvider = CDTEncryptionKeychainProvider(password: "passw0rd", forIdentifier: "identifier")
   do{
        datastore = try datastoreManager.datastoreNamed(name, withEncryptionKeyProvider: keyProvider)
   }catch let error as NSError{
        // Handle error
   }
   ```

4. 暗号化されたローカル・ストアを使用してデータを複製する場合、CDTPullReplication メソッドおよび CDTPushReplication メソッドを鍵プロバイダーと共に初期化する必要があります。

   ##### 変更前 (IMFData/CloudantToolkit を使用) : 鍵プロバイダーとともに初期化:   
   {: #before-with-imfdata-cloudanttoolkit-initialize-with-key-provider }
   **Objective-C**

   ```objc
   //Get reference to data manager
   IMFDataManager *manager = [IMFDataManager sharedInstance];
   NSString *databaseName = @"automobiledb";

   // Initalize a key provider
   id<CDTEncryptionKeyProvider> keyProvider = [CDTEncryptionKeychainProvider providerWithPassword:@"password" forIdentifier:@"identifier"];

   // pull replication
   CDTPullReplication *pull = [manager pullReplicationForStore: databaseName withEncryptionKeyProvider: keyProvider];

   // push replication
   CDTPushReplication *push = [manager pushReplicationForStore: databaseName withEncryptionKeyProvider: keyProvider];
   ```

   **Swift**

   ```swift
   //Get reference to data manager
   let manager = IMFDataManager.sharedInstance()
   let databaseName = "automobiledb"

   // Initalize a key provider
   let keyProvider = CDTEncryptionKeychainProvider(password: "password", forIdentifier: "identifier")

   // pull replication
   let pull:CDTPullReplication = manager.pullReplicationForStore(databaseName, withEncryptionKeyProvider: keyProvider)

   // push replication
   let push:CDTPushReplication = manager.pushReplicationForStore(databaseName, withEncryptionKeyProvider: keyProvider)
   ```

   ##### 変更後 (with Cloudant Sync) : 鍵プロバイダーとともに初期化:
   {: #after-with-cloudant-sync-initialize-with-key-provider }
   暗号化データベースで複製を行う場合に、暗号化されていないデータベースでの複製に変更を加える必要はありません。

### Android デバイスのデータの暗号化
{: #encrypting-data-on-android-devices }
Android デバイス上のデータを暗号化するには、アプリケーションに正しいライブラリーを組み込むことによって暗号化機能を取得します。その後、暗号化用のローカル・ストアを初期化し、データを複製できます。

1. build.gradle ファイル内で Cloudant Toolkit ライブラリーを依存関係として追加します。

   ##### 変更前 (IMFData/CloudantToolkit を使用): Android デバイスのデータの暗号化:
   {: #before-with-imfdata-cloudanttoolkit-encrypt-android-devices }
   ```xml
   repositories {
   mavenCentral()
   }

   dependencies {
       compile 'com.ibm.mobile.services:cloudant-toolkit-local:1.0.0'
   }
   ```

   ##### 変更後 (Cloudant Sync を使用): Android デバイスのデータの暗号化:
   {: #after-with-cloudant-sync-encrypt-android-devices }
    ```xml
    repositories {
        mavenLocal()
        maven { url "http://cloudant.github.io/cloudant-sync-eap/repository/" }
        mavenCentral()
    }

    dependencies {
        compile group: 'com.cloudant', name: 'cloudant-sync-datastore-core', version:'0.13.2'
        compile group: 'com.cloudant', name: 'cloudant-sync-datastore-android', version:'0.13.2'
        compile group: 'com.cloudant', name: 'cloudant-sync-datastore-android-encryption', version:'0.13.2'
    }
    ```

2. [SQLCipher for Android v3.2](https://www.zetetic.net/sqlcipher/open-source/) の **.jar** および **.so** バイナリー・ファイルをダウンロードし、それらのファイルを、アプリケーション構造内の適切なフォルダー内でアプリケーションに組み込みます。
    * ライブラリーを追加します。共有ライブラリー・ファイルおよび SQLCipher アーカイブを、Android アプリケーション・ディレクトリーの **jniLibs** フォルダーに追加します。
    * 必要な ICU 圧縮ファイルをアプリケーションの assets フォルダーに追加します。
    * **sqlcipher.jar** をファイル依存関係として追加します。Android Studio のアプリケーション・フォルダーのメニューから、**「モジュール設定を開く」**の下の**「依存関係」**タブを選択します。
3. 暗号化を行うように鍵プロバイダーと共にローカル・ストアを初期化します。

   > **警告:** データベースを作成した後でパスワードを変更すると、既存のデータベースを暗号化解除できなくなるため、エラーが発生します。データベースが暗号化された後でパスワードを変更することはできません。パスワードを変更するには、データベースを削除する必要があります。

   ##### 変更前 (IMFData/CloudantToolkit を使用) : ローカル・ストアの初期化 (Android):
   {: #before-with-imfdata-cloudanttoolkit-initialize-local-store-android }
   ```java
   // Get reference to DataManager
   DataManager manager = DataManager.getInstance();

   // Initalize a key provider
   KeyProvider keyProvider = new AndroidKeyProvider(getContext(),"password","identifier");

   // Create local store
   String databaseName = "automobiledb";
   Task<Store> storeTask = manager.localStore(databaseName, keyProvider);
   storeTask.continueWith(new Continuation<Store, Void >() {
        @Override
        public Void then(Task<Store> task) throws Exception {
            if (task.isFaulted()) {
                // Handle error
            } else {
                // Do something with Store
                Store store = task.getResult();
            }
            return null;
         }
   });
   ```

   ##### 変更後 (Cloudant Sync を使用) : ローカル・ストアの初期化 (Android):
   {: #after-with-cloudant-sync-initialize-local-store-android }   
   ```java
   // Load SQLCipher libs
   SQLiteDatabase.loadLibs(context);

   // Create DatastoreManager
   File path = context.getDir("databasedir", Context.MODE_PRIVATE);
   DatastoreManager manager = new DatastoreManager(path.getAbsolutePath());

   // Create encrypted local store
   String name = "automobiledb";

   KeyProvider keyProvider = new AndroidKeyProvider(context,"passw0rd","identifier");
   Datastore datastore = manager.openDatastore(name, keyProvider);
   ```

4. 暗号化されたローカル・ストアを使用してデータを複製する場合、KeyProvider オブジェクトを `pullReplicationForStore()` メソッドまたは `pushReplicationForStore()` メソッドに渡す必要があります。

   ##### 変更前 (IMFData/CloudantToolkit を使用): 鍵プロバイダーとともに初期化 (Android):
   {: #before-with-imfdata-cloudanttoolkit-initialize-with-key-provider-android }
   ```java
   //Get reference to data manager
   DataManager manager = DataManager.getInstance();
   String databaseName = "automobiledb";

   // Initalize a key provider
   KeyProvider keyProvider = new AndroidKeyProvider(getContext(),"password","identifier");

   // pull replication
   Task<PushReplication> pullTask = manager.pullReplicationForStore(databaseName, keyProvider);

   // push replication
   Task<PushReplication> pushTask = manager.pushReplicationForStore(databaseName, keyProvider);
   ```

   ##### 変更後 (Cloudant Sync を使用): 鍵プロバイダーとともに初期化 (Android)
   {: #after-with-cloudant-sync-initialize-with-key-provider-android }
暗号化データベースで複製を行う場合に、暗号化されていないデータベースでの複製に変更を加える必要はありません。

## ユーザー・アクセス権の設定
{: #setting-user-permissions }
リモート・データベースに対するユーザー・アクセス権を設定できます。

##### 変更前 (IMFData/CloudantToolkit を使用): ユーザー・アクセス権の設定:
{: #before-with-imfdata-cloudanttoolkit-setting-user-permissions }
**Objective-C**

```objc
// Get reference to data manager
IMFDataManager *manager = [IMFDataManager sharedInstance];

// Set permissions for current user on a store
[manager setCurrentUserPermissions: DB_ACCESS_GROUP_MEMBERS forStoreName: @"automobiledb" completionHander:^(BOOL success, NSError *error) {
    if(error){
        // Handle error
    }else{
        // setting permissions was successful
    }
}];
```

**Swift**

```swift
// Get reference to data manager
let manager = IMFDataManager.sharedInstance()

// Set permissions for current user on a store
manager.setCurrentUserPermissions(DB_ACCESS_GROUP_MEMBERS, forStoreName: "automobiledb") { (success:Bool, error:NSError!) -> Void in
    if nil != error {
        // Handle error
    } else {
        // setting permissions was successful
    }
}
```

**Java**

```java
Task<Boolean> permissionsTask = manager.setCurrentUserPermissions(DataManager.DB_ACCESS_GROUP_MEMBERS, "automobiledb");

permissionsTask.continueWith(new Continuation<Boolean, Object>() {
    @Override
    public Object then(Task<Boolean> task) throws Exception {
        if(task.isFaulted()){
            // Handle error
        }else{
           // setting permissions was successful
        }
        return null;
    }
});
```

##### 変更後 (Cloudant Sync を使用): ユーザー・アクセス権の設定:
{: #after-with-cloudant-sync-setting-user-permissions }
モバイル・デバイスからユーザー・アクセス権を設定することはできません。Cloudant ダッシュボードまたはサーバー・サイド・コードを使用してアクセス権を設定する必要があります。{{ site.data.keys.product_adj }} OAuth のトークンと Cloudant のセキュリティーとの統合方法のサンプルについては、[Bluelist サンプル](https://github.ibm.com/MFPSamples/BlueList-On-Premise)を参照してください。

## データのモデル化
{: #modeling-data }
Cloudant はデータを JSON ドキュメントとして保管します。アプリケーションでオブジェクトとしてデータを保管するには、ネイティブ・オブジェクトを基盤の JSON ドキュメント形式にマップする、付属のデータ・オブジェクト・マッパー・クラスを使用します。

* iOS: Cloudant はデータを JSON ドキュメントとして保管します。CloudantToolkit フレームワークは、ネイティブ・オブジェクトと JSON ドキュメントの間でマッピングを行うためのオブジェクト・マッパーを備えていました。CDTDatastore API には、この機能はありません。以降のセクションにおけるスニペットでは、CDTDatastore オブジェクトを使用して同じ操作を実現する方法を示します。
* Android: AndroidCloudant はデータを JSON ドキュメントとして保管します。CloudantToolkit API は、ネイティブ・オブジェクトと JSON ドキュメントの間でマッピングを行うためのオブジェクト・マッパーを備えていました。Cloudant Sync には、この機能はありません。以降のセクションにおけるスニペットでは、DocumentRevision オブジェクトを使用して同じ操作を実現する方法を示します。

## CRUD 操作の実行
{: #performing-crud-operations }
データ・ストアの内容を変更できます。

* `create`、`retrieve`、 `update`、および `delete` (CRUD) の操作について詳しくは、[CDTDatastore の CRUD の資料](https://github.com/cloudant/CDTDatastore/blob/master/doc/crud.md)を参照してください。
* リモート・ストアでの `create`、`retrieve`、`update`、および `delete` (CRUD) の操作については、[Cloudant 文書 API](https://docs.cloudant.com/document.html) を参照してください。

### データの作成
{: #creating-data }

_**変更前**_

**Objective-C**

```objc
// Use an existing store
CDTStore *store = existingStore;

// Create your Automobile to save
Automobile *automobile = [[Automobile alloc] initWithMake:@"Toyota" model:@"Corolla" year: 2006];

[store save:automobile completionHandler:^(id savedObject, NSError *error) {
    if (error) {
        // save was not successful, handler received an error
    } else {
        // use the result
        Automobile *savedAutomobile = savedObject;
        NSLog(@"saved revision: %@", savedAutomobile);
    }
}];
```

**Swift**

```swift
// Use an existing store
let store:CDTStore = existingStore

// Create your object to save
let automobile = Automobile(make: "Toyota", model: "Corolla", year: 2006)

store.save(automobile, completionHandler: { (savedObject:AnyObject!, error:NSError!) -> Void in
   if nil != error {
       //Save was not successful, handler received an error
   } else {
       // Use the result
       print("Saved revision: \(savedObject)")
   }
})
```

**Java**

```java
// Use an existing store
Store store = existingStore;

// Create your object to save
Automobile automobile = new Automobile("Toyota", "Corolla", 2006);

// Save automobile to store
Task<Object> saveTask = store.save(automobile);
saveTask.continueWith(new Continuation<Object, Void>() {
    @Override
    public Void then(Task<Object> task) throws Exception {
        if (task.isFaulted()) {
            // save was not successful, task.getError() contains the error
        } else {
            // use the result
            Automobile savedAutomobile = (Automobile) task.getResult();
        }
        return null;
    }
});
```

_**変更後**_

```objc
// Use an existing store
CDTDatastore *datastore = existingDatastore;

// Create document body
CDTMutableDocumentRevision * revision = [CDTMutableDocumentRevision revision];
revision.body = @{@"@datatype" : @"Automobile", @"make" :@"Toyota", @"model": @"Corolla", @"year" : @2006};

NSError *error = nil;
CDTDocumentRevision *createdRevision = [datastore createDocumentFromRevision:revision error:&error];

if (error) {
        // save was not successful, handler received an error
} else {
    // use the result
    NSLog(@"Revision: %@", createdRevision);
}
```

**Swift**

```swift
// Use an existing store
let datastore:CDTDatastore = existingDatastore

// Create document body
let revision = CDTMutableDocumentRevision()
revision.setBody(["make":"Toyota","model":"Corolla","year":2006])

var createdRevision:CDTDocumentRevision?
do{
    createdRevision = try datastore.createDocumentFromRevision(revision)
    NSLog("Revision: \(createdRevision)");
}catch let error as NSError{
    // Handle error
}
```

**Java**

```java
// Use an existing store
Datastore datastore = existingStore;

// Create document body
Map<String, Object> body = new HashMap<String, Object>();
body.put("@datatype", "Automobile");
body.put("make", "Toyota");
body.put("model", "Corolla");
body.put("year", 2006);

// Create revision and set body
MutableDocumentRevision revision  = new MutableDocumentRevision();
revision.body = DocumentBodyFactory.create(body);

// Save revision to store
DocumentRevision savedRevision = datastore.createDocumentFromRevision(revision);
```

### データの読み取り
{: #reading-data }

_**変更前**_

**Objective-C**

```objc
CDTStore *store = existingStore;
NSString *automobileId = existingAutomobileId;

// Fetch Autombile from Store
[store fetchById:automobileId completionHandler:^(id object, NSError *error) {
    if (error) {
        // fetch was not successful, handler received an error
    } else {
        // use the result
        Automobile *savedAutomobile = object;
        NSLog(@"fetched automobile: %@", savedAutomobile);
    }
}];
```

**Swift**

```swift
// Using an existing store and Automobile
let store:CDTStore = existingStore
let automobileId:String = existingAutomobileId

// Fetch Autombile from Store
store.fetchById(automobileId, completionHandler: { (object:AnyObject!, error:NSError!) -> Void in
    if nil != error {
        // Fetch was not successful, handler received an error
    } else {
        // Use the result
        let savedAutomobile:Automobile = object as! Automobile
        print("Fetched automobile: \(savedAutomobile)")
    }
})
```

**Java**

```java
// Use an existing store and documentId
Store store = existingStore;
String automobileId = existingAutomobileId;

// Fetch the automobile from the store
Task<Object> fetchTask = store.fetchById(automobileId);
fetchTask.continueWith(new Continuation<Object, Void>() {
    @Override
    public Void then(Task<Object> task) throws Exception {
        if (task.isFaulted()) {
            // fetch was not successful, task.getError() contains the error
        } else {
            // use the result 
            Automobile fetchedAutomobile = (Automobile) task.getResult();
        }
        return null;
    }
});
```

_**変更後**_

**Objective-C**

```objc
// Use an existing store and documentId
CDTDatastore *datastore = existingDatastore;
NSString *documentId = existingDocumentId;

// Fetch the CDTDocumentRevision from the store
NSError *error = nil;
CDTDocumentRevision *fetchedRevision = [datastore getDocumentWithId:documentId error:&error];

if (error) {
        // fetch was not successful, handler received an error
} else {
    // use the result
    NSLog(@"Revision: %@", fetchedRevision);
}
```

**Swift**

```swift
// Use an existing store and documentId
let datastore:CDTDatastore = existingDatastore
let documentId:String = existingDocumentId

var fetchedRevision:CDTDocumentRevision?
do{
    fetchedRevision = try datastore.getDocumentWithId(documentId)
    NSLog("Revision: \(fetchedRevision)");
}catch let error as NSError{
    // Handle error
}
```

**Java**

```java
// Use an existing store and documentId
Datastore datastore = existingStore;
String documentId = existingDocumentId;

// Fetch the revision from the store
DocumentRevision fetchedRevision = datastore.getDocument(documentId);
```

### データの更新
{: #updating-data }

_**変更前**_

**Objective-C**

```objc
// Use an existing store and Automobile
CDTStore *store = existingStore;
Automobile *automobile = existingAutomobile;

// Update some of the values in the Automobile
automobile.year = 2015;

// Save Autombile to the store
[store save:automobile completionHandler:^(id savedObject, NSError *error) {
    if (error) {
        // sasve was not successful, handler received an error
    } else {
        // use the result
        Automobile *savedAutomobile = savedObject;
        NSLog(@"saved automobile: %@", savedAutomobile);
    }
}];
```

**Swift**

```swift
// Use an existing store and Automobile
let store:CDTStore = existingStore
let automobile:Automobile = existingAutomobile

// Update some of the values in the Automobile
automobile.year = 2015

// Save Autombile to the store
store.save(automobile, completionHandler: { (savedObject:AnyObject!, error:NSError!) -> Void in
    if nil != error {
        // Update was not successful, handler received an error
    } else {
        // Use the result
        let savedAutomobile:Automobile = savedObject as! Automobile
        print("Updated automobile: \(savedAutomobile)")
    }
})
```

**Java**

```java
// Use an existing store and Automobile
Store store = existingStore;
Automobile automobile = existingAutomobile;

// Update some of the values in the Automobile
automobile.setYear(2015);

// Save automobile to store
Task<Object> saveTask = store.save(automobile);
saveTask.continueWith(new Continuation<Object, Void>() {
    @Override
    public Void then(Task<Object> task) throws Exception {
        if (task.isFaulted()) {
            // save was not successful, task.getError() contains the error
        } else {
            // use the result
            Automobile savedAutomobile = (Automobile) task.getResult();
        }
        return null;
    }
});
```

_**変更後**_

**Objective-C**

```objc
// Use an existing store and document
CDTDatastore *datastore = existingDatastore;
CDTMutableDocumentRevision *documentRevision = [existingDocumentRevision mutableCopy];

// Update some of the values in the revision
[documentRevision.body setValue:@2015 forKey:@"year"];

NSError *error = nil;
CDTDocumentRevision *updatedRevision = [datastore updateDocumentFromRevision:documentRevision error:&error];
if (error) {
    // save was not successful, handler received an error
} else {
    // use the result
    NSLog(@"Revision: %@", updatedRevision);
}
```

**Swift**

```swift
// Use an existing store and document
let datastore:CDTDatastore = existingDatastore
let documentRevision:CDTMutableDocumentRevision = existingDocumentRevision.mutableCopy()

// Update some of the values in the revision
documentRevision.body()["year"] = 2015

var updatedRevision:CDTDocumentRevision?
do{
    updatedRevision = try datastore.updateDocumentFromRevision(documentRevision)
    NSLog("Revision: \(updatedRevision)");
}catch let error as NSError{
    // Handle error
}
```

**Java**

```java
// Use an existing store and documentId
// Use an existing store
Datastore datastore = existingStore;

// Make a MutableDocumentRevision from the existing revision
MutableDocumentRevision revision = existingRevision.mutableCopy();

// Update some of the values in the revision
Map<String, Object> body = revision.getBody().asMap();
body.put("year", 2015);
revision.body = DocumentBodyFactory.create(body);

// Save revision to store
DocumentRevision savedRevision = datastore.updateDocumentFromRevision(revision);
```

### データの削除
{: #deleting-data }
オブジェクトを削除するには、削除するオブジェクトをストアに渡します。

_**変更前**_

**Objective-C**

```objc
// Using an existing store and Automobile
CDTStore *store = existingStore;
Automobile *automobile = existingAutomobile;

// Delete the Automobile object from the store
[store delete:automobile completionHandler:^(NSString *deletedObjectId, NSString *deletedRevisionId, NSError *error) {
    if (error) {
        // delete was not successful, handler received an error
    } else {
        // use the result
        NSLog(@"deleted Automobile doc-%@-rev-%@", deletedObjectId, deletedRevisionId);
    }
}];
```

**Swift**

```swift
// Using an existing store and Automobile
let store:CDTStore = existingStore
let automobile:Automobile = existingAutomobile

// Delete the Automobile object
store.delete(automobile, completionHandler: { (deletedObjectId:String!, deletedRevisionId:String!, error:NSError!) -> Void in
    if nil != error {
        // delete was not successful, handler received an error
    } else {
        // use the result
        print("deleted document doc-\(deletedObjectId)-rev-\(deletedRevisionId)")
    }
})
```

**Java**

```java
// Use an existing store and automobile
Store store = existingStore;
Automobile automobile = existingAutomobile;

// Delete the automobile from the store
Task<String> deleteTask = store.delete(automobile);
deleteTask.continueWith(new Continuation<String, Void>() {
    @Override
    public Void then(Task<String> task) throws Exception {
        if (task.isFaulted()) {
            // delete was not successful, task.getError() contains the error
        } else {
            // use the result
            String deletedAutomobileId = task.getResult();
        }
        return null;
    }
});
```

_**変更後**_

**Objective-C**

```objc
// Use an existing store and revision
CDTDatastore *datastore = existingDatastore;
CDTDocumentRevision *documentRevision = existingDocumentRevision;

// Delete the CDTDocumentRevision from the store
NSError *error = nil;
CDTDocumentRevision *deletedRevision = [datastore deleteDocumentFromRevision:documentRevision error:&error];
if (error) {
    // delete was not successful, handler received an error
} else {
    // use the result
    NSLog(@"deleted document: %@", deletedRevision);
}
```

**Swift**

```swift
// Use an existing store and revision
let datastore:CDTDatastore = existingDatastore
let documentRevision:CDTDocumentRevision = existingDocumentRevision

var deletedRevision:CDTDocumentRevision?
do{
    deletedRevision = try datastore.deleteDocumentFromRevision(documentRevision)
    NSLog("Revision: \(deletedRevision)");
}catch let error as NSError{
    // Handle error
}
```

**Java**

```java
// Use an existing store and revision
Datastore datastore = existingStore;
BasicDocumentRevision documentRevision = (BasicDocumentRevision) existingDocumentRevision;

// Delete revision from store
DocumentRevision deletedRevision = datastore.deleteDocumentFromRevision(documentRevision);
```

## 索引の作成
{: #creating-indexes }
照会を実行するには、索引を作成する必要があります。

* iOS: 詳しくは、[CDTDatastore の照会に関する資料](https://github.com/cloudant/CDTDatastore/blob/master/doc/query.md)を参照してください。リモート・ストアでの照会操作については、[Cloudant 照会 API](https://docs.cloudant.com/cloudant_query.html) を参照してください。
* Android: 詳しくは、[Cloudant Sync の照会に関する資料](https://github.com/cloudant/sync-android/blob/master/doc/query.md)を参照してください。リモート・ストアでの CRUD 操作については、[Cloudant の照会 API](https://docs.cloudant.com/cloudant_query.html) を参照してください。

1. データ型が含まれている索引を作成します。データ型が含まれた索引作成は、オブジェクト・マッパーがストアで設定されている場合に役立ちます。

   _**変更前**_

   **Objective-C**

   ```objc
   // Use an existing data store
   CDTStore *store = existingStore;

   // The data type to use for the Automobile class
   NSString *dataType = [store.mapper dataTypeForClassName:NSStringFromClass([Automobile class])];

   // Create the index
   [store createIndexWithDataType:dataType fields:@[@"year", @"make"] completionHandler:^(NSError *error) {
       if(error){
           // Handle error
       }else{
           // Continue application flow
       }
   }];
   ```

   **Swift**

   ```swift
   // A store that has been previously created.
   let store:CDTStore = existingStore

   // The data type to use for the Automobile class
   let dataType:String = store.mapper.dataTypeForClassName(NSStringFromClass(Automobile.classForCoder()))

   // Create the index
   store.createIndexWithDataType(dataType, fields: ["year","make"]) { (error:NSError!) -> Void in
        if nil != error {
            // Handle error
        } else {
            // Continue application flow
        }
   }
   ```

   **Java**

   ```java
   // Use an existing data store
   Store store = existingStore;

   // The data type to use for the Automobile class
   String dataType = store.getMapper().getDataTypeForClassName(Automobile.class.getCanonicalName());

   // The fields to index.
   List<IndexField> indexFields = new ArrayList<IndexField>();
   indexFields.add(new IndexField("year"));
   indexFields.add(new IndexField("make"));

   // Create the index
   Task<Void> indexTask = store.createIndexWithDataType(dataType, indexFields);
   indexTask.continueWith(new Continuation<Void, Void>() {
        @Override
        public Void then(Task<Void> task) throws Exception {
            if(task.isFaulted()){
                // Handle error
            }else{
                // Continue application flow
            }
            return null;
        }
   });
   ```

   _**変更後**_

   **Objective-C**

   ```objc
   // A store that has been previously created.
   CDTDatastore *datastore = existingDatastore;

   NSString *indexName = [datastore ensureIndexed:@[@"@datatype", @"year", @"make"] withName:@"automobileindex"];
   if(!indexName){
        // Handle error
   }
   ```

   **Swift**

   ```swift
   // A store that has been previously created.
   let datastore:CDTDatastore = existingDatastore

   // Create the index
   let indexName:String? = datastore.ensureIndexed(["@datatype","year","make"], withName: "automobileindex")
   if(indexName == nil){
        // Handle error
   }
   ```

   **Java**

   ```java
   // Use an existing store
   Datastore datastore = existingStore;

   // Create an IndexManager
   IndexManager indexManager = new IndexManager(datastore);

   // The fields to index.
   List<Object> indexFields = new ArrayList<Object>();
   indexFields.add("@datatype");
   indexFields.add("year");
   indexFields.add("make");

   // Create the index
   indexManager.ensureIndexed(indexFields, "automobile_index");
   ```

2. 索引を削除します。

   _**変更前**_

   **Objective-C**

   ```objc
   // Use an existing data store
   CDTStore *store = existingStore;
   NSString *indexName = existingIndexName;

   // Delete the index
   [store deleteIndexWithName:indexName completionHandler:^(NSError *error) {
        if(error){
            // Handle error
        }else{
            // Continue application flow
        }
   }];
   ```

   **Swift**

   ```swift
   // Use an existing store
   let store:CDTStore = existingStore

   // The data type to use for the Automobile class
   let dataType:String = store.mapper.dataTypeForClassName(NSStringFromClass(Automobile.classForCoder()))

   // Delete the index
   store.deleteIndexWithDataType(dataType, completionHandler: { (error:NSError!) -> Void in
        if nil != error {
            // Handle error
        } else {
            // Continue application flow
        }
   })
   ```

   **Java**

   ```java
   // Use an existing data store
   Store store = existingStore;
   String indexName = existingIndexName;

   // Delete the index
   Task<Void> indexTask = store.deleteIndex(indexName);
   indexTask.continueWith(new Continuation<Void, Void>() {
        @Override
        public Void then(Task<Void> task) throws Exception {
            if(task.isFaulted()){
                // Handle error
            }else{
                // Continue application flow
            }
            return null;
        }
   });
   ```

   _**変更後**_

   **Objective-C**

   ```objc
   // Use an existing store
   CDTDatastore *datastore = existingDatastore;
   NSString *indexName = existingIndexName;

   // Delete the index
   BOOL success = [datastore deleteIndexNamed:indexName];
   if(!success){
        // Handle error
   }
   ```

   **Swift**

   ```swift
   // A store that has been previously created.
   let datastore:CDTDatastore = existingDatastore
   let indexName:String = existingIndexName

   // Delete the index
   let success:Bool = datastore.deleteIndexNamed(indexName)
   if(!success){
        // Handle error
   }
   ```

   **Java**

   ```java
   // Use an existing store
   Datastore datastore = existingStore;
   String indexName = existingIndexName;
   IndexManager indexManager = existingIndexManager;

   // Delete the index
   indexManager.deleteIndexNamed(indexName);
   ```

## データの照会
{: #querying-data }
索引を作成した後、データベース内のデータを照会できます。

* iOS: 詳しくは、[CDTDatastore の照会に関する資料](https://github.com/cloudant/CDTDatastore/blob/master/doc/query.md)を参照してください。
* Android: 詳しくは、[Cloudant Sync の照会に関する資料](https://github.com/cloudant/sync-android/blob/master/doc/query.md)を参照してください。
* リモート・ストアでの照会操作については、[Cloudant 照会 API](https://docs.cloudant.com/cloudant_query.html) を参照してください。

#### iOS (データの照会)
{: #ios-querying-data }
##### 変更前 (IMFData/CloudantToolkit を使用): iOS (データの照会):
{: #before-with-imfdata-cloudanttoolkit-querying-data-ios }

**Objective-C**

```objc
// Use an existing store
CDTStore *store = existingStore;

NSPredicate *queryPredicate = [NSPredicate predicateWithFormat:@"(year = 2006)"];
CDTCloudantQuery *query = [[CDTCloudantQuery alloc] initDataType:[store.mapper dataTypeForClassName:NSStringFromClass([Automobile class])] withPredicate:queryPredicate];

[store performQuery:query completionHandler:^(NSArray *results, NSError *error) {
    if(error){
        // Handle error
    }else{
        // Use result of query.  Result will be Automobile objects.
    }
}];
```

**Swift**

```swift
// Use an existing store
let store:CDTStore = existingStore

let queryPredicate:NSPredicate = NSPredicate(format:"(year = 2006)")
let query:CDTCloudantQuery = CDTCloudantQuery(dataType: "Automobile", withPredicate: queryPredicate)

store.performQuery(query, completionHandler: { (results:[AnyObject]!, error:NSError!) -> Void in
    if nil != error {
        // Handle error
    } else {
        // Use result of query.  Result will be Automobile objects.
    }
})
```

##### 変更後 (Cloudant Sync を使用) (データの照会):
{: #after-with-cloudant-sync-querying-data }
**Objective-C**

```objc
// Use an existing store
CDTDatastore *datastore = existingDatastore;

CDTQResultSet *results = [datastore find:@{@"@datatype" : @"Automobile", @"year" : @2006}];
if(results){
    // Use results
}
```

```swift
// Use an existing store
let datastore:CDTDatastore = existingDatastore

let results:CDTQResultSet? = datastore.find(["@datatype" : "Automobile", "year" : 2006])
if(results == nil){
    // Handle error
}
```

#### Android (データの照会)
{: #android-querying-data }
オブジェクトの照会を実行するには、データ・タイプに対して照会フィルターを使用して Cloudant 照会を作成します。Store オブジェクトに対して照会を実行します。

##### 変更前 (IMFData/CloudantToolkit を使用): Android (データの照会):
{: #before-with-imfdata-cloudanttoolkit-querying-data-android }
```java
// Use an existing store
Store store = existingStore;

// Create data type predicate
Map<String, Object> dataTypeEqualityOpMap = new HashMap<String, Object>();
dataTypeEqualityOpMap.put("$eq", "Automobile");

Map<String, Object> dataTypeSelectorMap = new HashMap<String, Object>();
dataTypeSelectorMap.put("@datatype", dataTypeEqualityOpMap);

// Create year predicate
Map<String, Object> yearEqualityOpMap = new HashMap<String, Object>();
yearEqualityOpMap.put("$eq", 2006);

Map<String, Object> yearSelectorMap = new HashMap<String, Object>();
yearSelectorMap.put("year", yearEqualityOpMap);

// Add predicates to AND compound predicate
List<Map<String, Object>> andPredicates = new ArrayList<Map<String, Object>>();
andPredicates.add(dataTypeSelectorMap);
andPredicates.add(yearSelectorMap);

Map<String, Object> andOpMap = new HashMap<String, Object>();
andOpMap.put("$and", andPredicates);

Map<String, Object> cloudantQueryMap = new HashMap<String, Object>();
cloudantQueryMap.put("selector", andOpMap);

// Create a Cloudant Query Object
CloudantQuery query = new CloudantQuery(cloudantQueryMap);

// Run the Cloudant Query against a Store
Task<List> queryTask = store.performQuery(query);
queryTask.continueWith(new Continuation<List, Object>() {
    @Override
    public Object then(Task<List> task) throws Exception {
        if(task.isFaulted()){
            // Handle Error
        }else{
            List queryResult = task.getResult();
            // Use queryResult to do something
        }
        return null;
    }
});
```

##### 変更後 (Cloudant Sync を使用): Android (データの照会):
{: #after-with-cloudant-sync-android-querying-data }
```java
// Use an existing store
Datastore datastore = existingStore;
IndexManager indexManager = existingIndexManager;

// Create data type predicate
Map<String, Object> dataTypeEqualityOpMap = new HashMap<String, Object>();
dataTypeEqualityOpMap.put("$eq", "Automobile");

Map<String, Object> dataTypeSelectorMap = new HashMap<String, Object>();
dataTypeSelectorMap.put("@datatype", dataTypeEqualityOpMap);

// Create year predicate
Map<String, Object> yearEqualityOpMap = new HashMap<String, Object>();
yearEqualityOpMap.put("$eq", 2006);

Map<String, Object> yearSelectorMap = new HashMap<String, Object>();
yearSelectorMap.put("year", yearEqualityOpMap);

// Add predicates to AND compound predicate
List<Map<String, Object>> andPredicates = new ArrayList<Map<String, Object>>();
andPredicates.add(dataTypeSelectorMap);
andPredicates.add(yearSelectorMap);

Map<String, Object> selectorMap = new HashMap<String, Object>();
selectorMap.put("$and", andPredicates);

// Run the query against a Store
QueryResult result = indexManager.find(selectorMap);
```

## オフライン・ストレージおよび同期のサポート
{: #supporting-offline-storage-and-synchronization }
モバイル・デバイス上のデータをリモート・データベース・インスタンスと同期できます。リモート・データベースの更新をモバイル・デバイス上のローカル・データベースにプルするか、ローカル・データベースの更新をリモート・データベースにプッシュできます。

* iOS: 詳しくは、[CDTDatastore 複製の資料](https://github.com/cloudant/CDTDatastore/blob/master/doc/replication.md)を参照してください。
* Android: 詳しくは、[Cloudant Sync 複製の資料](https://github.com/cloudant/sync-android/blob/master/doc/replication.md)を参照してください。リモート・ストアでの CRUD 操作については、[Cloudant 複製 API](https://docs.cloudant.com/replication.html) を参照してください。

### プル複製の実行
{: #running-pull-replication }

_**変更前**_

**Objective-C**

```objc
// store is an existing CDTStore object created using IMFDataManager remoteStore
__block NSError *replicationError;
CDTPullReplication *pull = [manager pullReplicationForStore: store.name];
CDTReplicator *replicator = [manager.replicatorFactory oneWay:pull error:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator creation was successful
}

[replicator startWithError:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator start was successful
}

// (optionally) monitor replication via polling
while (replicator.isActive) {
    [NSThread sleepForTimeInterval:1.0f];
    NSLog(@"replicator state : %@", [CDTReplicator stringForReplicatorState:replicator.state]);
}
```

**Swift**

```swift
// Use an existing store
let store:CDTStore = existingStore

do {
    // store is an existing CDTStore object created using IMFDataManager remoteStore
    let pull:CDTPullReplication = manager.pullReplicationForStore(store.name)
    let replicator:CDTReplicator = try manager.replicatorFactory.oneWay(pull)
    
    // start replication
    try replicator.start()

    // (optionally) monitor replication via polling
    while replicator.isActive() {
        NSThread.sleepForTimeInterval(1.0)
        print("replicator state : \(CDTReplicator.stringForReplicatorState(replicator.state))")
    }

} catch let error as NSError {
    // Handle error
}
```

**Java**

```java
// Use an existing store
Store store = existingStore;

// create a pull replication task
// name is the database name of the store being replicated
Task<PullReplication> pullTask = manager.pullReplicationForStore(store.getName());
pullTask.continueWith(new Continuation<PullReplication, Object>() {
    @Override
    public Object then(Task<PullReplication> task) throws Exception {
        if(task.isFaulted()){
            // Handle error
        }else{
            // Start the replication
            PullReplication pull = task.getResult();
            Replicator replicator = ReplicatorFactory.oneway(pull);
            replicator.start();
        }
        return null;
    } 
});
```

_**変更後**_

**Objective-C**

```objc
// Use an existing datastore
NSURL *remoteStoreUrl = existingRemoteStoreUrl;
CDTDatastoreManager *datastoreManager = existingDatastoreManager;
CDTDatastore *datastore = existingDatastore;

// Create pull replication objects
__block NSError *replicationError;
CDTReplicatorFactory *replicatorFactory = [[CDTReplicatorFactory alloc]initWithDatastoreManager:datastoreManager];
CDTPullReplication *pull = [CDTPullReplication replicationWithSource:remoteStoreUrl target:datastore];
CDTReplicator *replicator = [replicatorFactory oneWay:pull error:&error];
if(replicationError){
    // Handle error
}else{
    // replicator creation was successful
}

[replicator startWithError:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator start was successful
}

// (optionally) monitor replication via polling
while (replicator.isActive) {
    [NSThread sleepForTimeInterval:1.0f];
    NSLog(@"replicator state : %@", [CDTReplicator stringForReplicatorState:replicator.state]);
}
```

**Swift**

```swift
let remoteStoreUrl:NSURL = existingRemoteStoreUrl
let datastoreManager:CDTDatastoreManager = existingDatastoreManager
let datastore:CDTDatastore = existingDatastore


do {
    // store is an existing CDTStore object created using IMFDataManager remoteStore
    let replicatorFactory = CDTReplicatorFactory(datastoreManager: datastoreManager)
    let pull:CDTPullReplication = CDTPullReplication(source: remoteStoreUrl, target: datastore)
    let replicator:CDTReplicator = try replicatorFactory.oneWay(pull)

    // start replication
    try replicator.start()

    // (optionally) monitor replication via polling
    while replicator.isActive() {
        NSThread.sleepForTimeInterval(1.0)
        print("replicator state : \(CDTReplicator.stringForReplicatorState(replicator.state))")
    }

} catch let error as NSError {
    // Handle error
}
```

**Java**

```java
// Use an opened Datastore to replicate to
Datastore datastore = existingDatastore;
URI uri = existingURI;

// Create a replicator that replicates changes from the remote
final Replicator replicator = ReplicatorBuilder.pull().from(uri).to(datastore).build();

// Register event listener
replicator.getEventBus().register(new Object() {

    @Subscribe
    public void complete(ReplicationCompleted event) {

        // Handle ReplicationCompleted event
    }

    @Subscribe
    public void error(ReplicationErrored event) {

        // Handle ReplicationErrored event
    }
});

// Start replication
replicator.start();
```

### プッシュ複製の実行
{: #running-push-replication }

_**変更前**_

**Objective-C**

```objc
/ store is an existing CDTStore object created using IMFDataManager localStore
__block NSError *replicationError;
CDTPushReplication *push = [manager pushReplicationForStore: store.name];
CDTReplicator *replicator = [manager.replicatorFactory oneWay:push error:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator creation was successful
}

[replicator startWithError:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator start was successful
}

// (optionally) monitor replication via polling
while (replicator.isActive) {
    [NSThread sleepForTimeInterval:1.0f];
    NSLog(@"replicator state : %@", [CDTReplicator stringForReplicatorState:replicator.state]);
}
```

**Swift**

```swift
// Use an existing store
let store:CDTStore = existingStore

do {
    // store is an existing CDTStore object created using IMFDataManager localStore
    let push:CDTPushReplication = manager.pushReplicationForStore(store.name)
    let replicator:CDTReplicator = try manager.replicatorFactory.oneWay(push)
    
    // Start replication
    try replicator.start()

    // (optionally) monitor replication via polling
    while replicator.isActive() {
        NSThread.sleepForTimeInterval(1.0)
        print("replicator state : \(CDTReplicator.stringForReplicatorState(replicator.state))")
    }
} catch let error as NSError {
    // Handle error
}
```

**Java**

```java
// Use an existing store
Store store = existingStore;

// create a push replication task
// name is the database name of the store being replicated
Task<PushReplication> pushTask = manager.pushReplicationForStore(store.getName());
pushTask.continueWith(new Continuation<PushReplication, Object>() {
    @Override
    public Object then(Task<PushReplication> task) throws Exception {
        if(task.isFaulted()){
            // Handle error
        }else{
            // Start the replication
            PushReplication push = task.getResult();
            Replicator replicator = ReplicatorFactory.oneway(push);
            replicator.start();
        }
        return null;
    }
});
```

_**変更後**_

**Objective-C**

```objc
// Use an existing datastore
NSURL *remoteStoreUrl = existingRemoteStoreUrl;
CDTDatastoreManager *datastoreManager = existingDatastoreManager;
CDTDatastore *datastore = existingDatastore;

// Create push replication objects
__block NSError *replicationError;
CDTReplicatorFactory *replicatorFactory = [[CDTReplicatorFactory alloc]initWithDatastoreManager:datastoreManager];
CDTPushReplication *push = [CDTPushReplication replicationWithSource:datastore target:remoteStoreUrl];
CDTReplicator *replicator = [replicatorFactory oneWay:push error:&error];
if(replicationError){
    // Handle error
}else{
    // replicator creation was successful
}

[replicator startWithError:&replicationError];
if(replicationError){
    // Handle error
}else{
    // replicator start was successful
}

// (optionally) monitor replication via polling
while (replicator.isActive) {
    [NSThread sleepForTimeInterval:1.0f];
    NSLog(@"replicator state : %@", [CDTReplicator stringForReplicatorState:replicator.state]);
}
```

**Swift**

```swift
let remoteStoreUrl:NSURL = existingRemoteStoreUrl
let datastoreManager:CDTDatastoreManager = existingDatastoreManager
let datastore:CDTDatastore = existingDatastore


do {
    // store is an existing CDTStore object created using IMFDataManager remoteStore
    let replicatorFactory = CDTReplicatorFactory(datastoreManager: datastoreManager)
    let push:CDTPushReplication = CDTPushReplication(source: datastore, target: remoteStoreUrl)
    let replicator:CDTReplicator = try replicatorFactory.oneWay(push)
    
    // start replication
    try replicator.start()

    // (optionally) monitor replication via polling
    while replicator.isActive() {
        NSThread.sleepForTimeInterval(1.0)
        print("replicator state : \(CDTReplicator.stringForReplicatorState(replicator.state))")
    }

} catch let error as NSError {
    // Handle error
}
```

**Java**

```java
// Use an opened Datastore to replicate from
Datastore datastore = existingStore;
URI uri = existingURI;

// Create a replicator that replicates changes from the local
// database to the remote datastore.
final Replicator replicator = ReplicatorBuilder.push().from(datastore).to(uri).build();

// Register event listener
replicator.getEventBus().register(new Object() {

    @Subscribe
    public void complete(ReplicationCompleted event) {

        // Handle ReplicationCompleted event
    }

    @Subscribe
    public void error(ReplicationErrored event) {

        // Handle ReplicationErrored event
    }
});

// Start replication
replicator.start();
```
