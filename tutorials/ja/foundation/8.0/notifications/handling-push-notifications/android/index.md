---
layout: tutorial
title: Android でのプッシュ通知の処理
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Android Studio プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
受け取ったプッシュ通知を Android アプリケーションが処理できるようにするためには、Google Play Services のサポートを構成する必要があります。アプリケーションが構成されると、{{ site.data.keys.product_adj }} が提供する通知 API を使用して、デバイスの登録や登録抹消、タグへのサブスクライブやアンサブスクライブを実行できます。このチュートリアルでは、Android アプリケーションでプッシュ通知を処理する方法について学習します。

**前提条件**

* 必ず、以下のチュートリアルをお読みください。
    * [{{ site.data.keys.product_adj }} 開発環境のセットアップ](../../../installation-configuration/#installing-a-development-environment)
    * [Android アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/android)
    * [プッシュ通知の概要](../../)
* ローカルで稼働している {{ site.data.keys.mf_server }}、またはリモートで稼働している {{ site.data.keys.mf_server }}
* 開発者ワークステーションに {{ site.data.keys.mf_cli }} がインストールされていること

#### ジャンプ先:
{: #jump-to }
* [通知構成](#notifications-configuration)
* [通知 API](#notifications-api)
* [プッシュ通知の処理](#handling-a-push-notification)
* [サンプル・アプリケーション](#sample-application)

## 通知構成
{: #notifications-configuration }
新しい Android Studio プロジェクトを作成するか、または既存のプロジェクトを使用します。  
{{ site.data.keys.product_adj }} Native Android SDK がプロジェクトにまだ存在しない場合は、[Android アプリケーションへの {{ site.data.keys.product }} SDK の追加](../../../application-development/sdk/android)チュートリアルの説明に従ってください。

### プロジェクトのセットアップ
{: #project-setup }
1. **Android →「Gradle Scripts」**で、**build.gradle (Module: app)** ファイルを選択し、以下の行を `dependencies` に追加します。

   ```bash
   com.google.android.gms:play-services-gcm:9.0.2
   ```
   - **注:** [Google の既知の問題](https://code.google.com/p/android/issues/detail?id=212879)のために、Play Services の最新バージョン (現行は 9.2.0) は使用できません。下位バージョンを使用してください。

   以下も追加します。

   ```xml
   compile group: 'com.ibm.mobile.foundation',
            name: 'ibmmobilefirstplatformfoundationpush',
            version: '8.0.+',
            ext: 'aar',
            transitive: true
   ```
    
   または、以下のように 1 行にします。

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
   ```

2. **Android →「app」→「manifests」**で、`AndroidManifest.xml` ファイルを開きます。
	* 以下の許可を `manifest` タグの上部に追加します。

	  ```xml
	  <!-- Permissions -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <!-- GCM Permissions -->
      <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
      <permission
    	    android:name="your.application.package.name.permission.C2D_MESSAGE"
    	    android:protectionLevel="signature" />
      ```
      
	* 以下を `application` タグに追加します。

	  ```xml
      <!-- GCM Receiver -->
      <receiver
            android:name="com.google.android.gms.gcm.GcmReceiver"
            android:exported="true"
            android:permission="com.google.android.c2dm.permission.SEND">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <category android:name="your.application.package.name" />
            </intent-filter>
      </receiver>

      <!-- MFPPush Intent Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            </intent-filter>
      </service>

      <!-- MFPPush Instance ID Listener Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.gms.iid.InstanceID" />
            </intent-filter>
      </service>

      <activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler"
           android:theme="@android:style/Theme.NoDisplay"/>
	  ```

	  > **注:** 必ず、ご使用のアプリケーションの実際のパッケージ名で `your.application.package.name` を置き換えてください。

    * 以下の `intent-filter` をアプリケーションのアクティビティーに追加します。
      
      ```xml
      <intent-filter>
          <action android:name="your.application.package.name.IBMPushNotification" />
          <category android:name="android.intent.category.DEFAULT" />
      </intent-filter>
      ```
      
## 通知 API
{: #notifications-api }
### MFPPush インスタンス
{: #mfppush-instance }
すべての API 呼び出しは、`MFPPush` のインスタンスから呼び出される必要があります。これを行うには、クラス・レベルのフィールド (`private MFPPush push = MFPPush.getInstance();` など) を作成し、その後、クラス内で一貫して `push.<api-call>` を呼び出します。

代わりに、プッシュ API メソッドにアクセスする必要があるインスタンスごとに `MFPPush.getInstance().<api_call>` を呼び出すこともできます。

### チャレンジ・ハンドラー
{: #challenge-handlers }
`push.mobileclient` スコープが**セキュリティー検査**にマップされる場合、プッシュ API を使用する前に、一致する**チャレンジ・ハンドラー**が存在し、登録済みであることを確認する必要があります。

> チャレンジ・ハンドラーについて詳しくは、[資格情報の検証](../../../authentication-and-security/credentials-validation/android)チュートリアルを参照してください。



### クライアント・サイド
{: #client-side }

| Java メソッド| 説明|
|-----------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize(Context context);`](#initialization) | 提供されたコンテキストの MFPPush を初期化します。|
| [`isPushSupported();`](#is-push-supported) | デバイスがプッシュ通知をサポートするかどうか。|
| [`registerDevice(JSONObject, MFPPushResponseListener);`](#register-device) | デバイスをプッシュ通知サービスに登録します。|
| [`getTags(MFPPushResponseListener)`](#get-tags) | プッシュ通知サービス・インスタンス内で使用可能なタグを取得します。|
| [`subscribe(String[] tagNames, MFPPushResponseListener)`](#subscribe) | 指定されたタグにデバイスをサブスクライブします。|
| [`getSubscriptions(MFPPushResponseListener)`](#get-subscriptions) | デバイスが現在サブスクライブしているタグをすべて取得します。|
| [`unsubscribe(String[] tagNames, MFPPushResponseListener)`](#unsubscribe) | 特定のタグからアンサブスクライブします。|
| [`unregisterDevice(MFPPushResponseListener)`](#unregister) | プッシュ通知サービスからデバイスを登録抹消します。|

#### 初期化
{: #initialization }
クライアント・アプリケーションが、正しいアプリケーション・コンテキストの MFPPush サービスに接続するために必要です。

* 最初に API メソッドを呼び出してから、その他の MFPPush API を使用する必要があります。
* 受け取ったプッシュ通知を処理するコールバック関数を登録します。

```java
MFPPush.getInstance().initialize(this);
```

#### プッシュがサポートされるか
{: #is-push-supported }
デバイスがプッシュ通知をサポートするかどうかをチェックします。

```java
Boolean isSupported = MFPPush.getInstance().isPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### デバイスの登録
{: #register-device }
デバイスをプッシュ通知サービスに登録します。

```java
MFPPush.getInstance().registerDevice(null, new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Successfully registered
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registration failed with error
    }
});
```

#### タグの取得
{: #get-tags }
プッシュ通知サービスからすべての使用可能なタグを取得します。

```java
MFPPush.getInstance().getTags(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully retrieved tags as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to receive tags with error
    }
});
```

#### サブスクライブ
{: #subscribe }
目的のタグにサブスクライブします。

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().subscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Subscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to subscribe
    }
});
```

#### サブスクリプションの取得
{: #get-subscriptions }
デバイスが現在サブスクライブしているタグを取得します。

```java
MFPPush.getInstance().getSubscriptions(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Successfully received subscriptions as list of strings
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to retrieve subscriptions with error
    }
});
```

#### アンサブスクライブ
{: #unsubscribe }
タグからアンサブスクライブします。

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().unsubscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Unsubscribed successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unsubscribe
    }
});
```

#### 登録抹消
{: #unregister }
プッシュ通知サービス・インスタンスからデバイスを登録抹消します。

```java
MFPPush.getInstance().unregisterDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        disableButtons();
        // Unregistered successfully
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Failed to unregister
    }
});
```

## プッシュ通知の処理
{: #handling-a-push-notification }
プッシュ通知を処理するためには、`MFPPushNotificationListener` をセットアップする必要があります。これは、以下のいずれかのメソッドを実装することで実現できます。

### オプション 1
{: #option-one }
プッシュ通知を処理する必要があるアクティビティー内で、以下のようにします。

1. `implements MFPPushNofiticationListener` をクラス宣言に追加します。
2. `onCreate` メソッド内で `MFPPush.getInstance().listen(this)` を呼び出すことで、このクラスがリスナーになるように設定します。
2. 次に、以下の*必須* メソッドを追加する必要があります。

   ```java
@Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
```

3. このメソッド内で `MFPSimplePushNotification` を受け取り、目的の動作にあわせて通知を処理できます。

### オプション 2
{: #option-two }
下記の概略のように、`MFPPush` のインスタンスで `listen(new MFPPushNofiticationListener())` を呼び出すことで、リスナーを作成します。

```java
MFPPush.getInstance().listen(new MFPPushNotificationListener() {
    @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
});
```

<img alt="サンプル・アプリケーションのイメージ" src="notifications-app.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80) して Android Studio プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
