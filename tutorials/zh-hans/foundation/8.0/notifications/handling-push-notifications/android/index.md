---
layout: tutorial
title: 在 Android 中处理推送通知
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在 Android 应用程序处理已收到的任何推送通知之前，需要配置 Google Play Services 支持。 在配置应用程序后，可以使用 {{ site.data.keys.product_adj }} 提供的通知 API 来注册和注销设备以及预订和取消预订标记。 在本教程中，您将学会如何在 Android 应用程序中处理推送通知。

**先决条件：**

* 确保您已阅读过下列教程：
    * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
    * [将 {{ site.data.keys.product }} SDK 添加到 Android 应用程序](../../../application-development/sdk/android)
    * [推送通知概述](../../)
* 本地运行的 {{ site.data.keys.mf_server }} 或远程运行的 {{ site.data.keys.mf_server }}。
* 安装在开发人员工作站上的 {{ site.data.keys.mf_cli }}

#### 跳转至：
{: #jump-to }
* [通知配置](#notifications-configuration)
* [通知 API](#notifications-api)
* [处理推送通知](#handling-a-push-notification)
* [样本应用程序](#sample-application)
* [在 Android 上将客户机应用程序迁移到 FCM](#migrate-to-fcm)

## 通知配置
{: #notifications-configuration }
创建新的 Android Studio 项目或使用现有项目。  
如果该项目中还没有 {{ site.data.keys.product_adj }} 本机 Android SDK，请遵循[将 {{ site.data.keys.product }} SDK 添加到 Android 应用程序](../../../application-development/sdk/android)教程中的指示信息。

### 项目设置
{: #project-setup }
1. 在 **Android → Gradle 脚本**中，选择 **build.gradle（模块：应用程序）**文件，并将以下行添加到 `dependencies` 中：

   ```bash
   com.google.android.gms:play-services-gcm:9.0.2
   ```
   - **注：**存在一个[已知的 Google 缺陷](https://code.google.com/p/android/issues/detail?id=212879)，此缺陷将阻止使用最新的 Play Services 版本（当前为 9.2.0）。 请使用较低的版本。

   以及：

   ```xml
   compile group: 'com.ibm.mobile.foundation',
            name: 'ibmmobilefirstplatformfoundationpush',
            version: '8.0.+',
            ext: 'aar',
            transitive: true
   ```
    
   或在单独一行中：

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
   ```

2. 在 **Android → 应用程序 → 清单**中，打开 `AndroidManifest.xml` 文件。
	* 向顶部的 `manifest` 标记中添加以下许可权：

	  ```xml
	  <!-- Permissions -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <!-- GCM Permissions -->
      <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
      <permission
    	    android:name="your.application.package.name.permission.C2D_MESSAGE"
    	    android:protectionLevel="signature" />
      ```
      
	* 向 `application` 标记添加以下内容：

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

	  > **注：**请确保将 `your.application.package.name` 替换为您应用程序的实际包名。

    * 向应用程序的活动中添加以下 `intent-filter`。
      
      ```xml
      <intent-filter>
          <action android:name="your.application.package.name.IBMPushNotification" />
          <category android:name="android.intent.category.DEFAULT" />
      </intent-filter>
      ```
      
## 通知 API
{: #notifications-api }
### MFPPush 实例
{: #mfppush-instance }
必须在一个 `MFPPush` 实例上发出所有 API 调用。  为此，需要创建一个类级别字段（例如 `private MFPPush push = MFPPush.getInstance();`），然后在该类中调用 `push.<api-call>`。

也可以针对要访问推送 API 方法的每个实例都调用 `MFPPush.getInstance().<api_call>`。

### 验证问题处理程序
{: #challenge-handlers }
如果 `push.mobileclient` 作用域映射到**安全性检查**，那么需要确保在使用任何推送 API 之前，存在已注册的匹配**验证问题处理程序**。

> 在[凭证验证](../../../authentication-and-security/credentials-validation/android)教程中了解有关验证问题处理程序的更多信息。

### 客户端
{: #client-side }

| Java 方法 | 描述 |
|-----------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize(Context context);`](#initialization) | 针对提供的上下文，初始化 MFPPush。 |
| [`isPushSupported();`](#is-push-supported) | 设备是否支持推送通知。 |
| [`registerDevice(JSONObject, MFPPushResponseListener);`](#register-device) | 向推送通知服务注册设备。 |
| [`getTags(MFPPushResponseListener)`](#get-tags) | 在推送通知服务实例中检索可用的标记。 |
| [`subscribe(String[] tagNames, MFPPushResponseListener)`](#subscribe) | 使设备预订指定的标记。 |
| [`getSubscriptions(MFPPushResponseListener)`](#get-subscriptions) | 检索设备当前预订的所有标记。 |
| [`unsubscribe(String[] tagNames, MFPPushResponseListener)`](#unsubscribe) | 取消对特定标记的预订。 |
| [`unregisterDevice(MFPPushResponseListener)`](#unregister) | 从推送通知服务注销设备。 |

#### 初始化
{: #initialization }
在客户机应用程序使用适当的应用程序上下文连接到 MFPPush 服务时为必需项。

* 应先调用此 API 方法，然后再使用任何其他 MFPPush API。
* 注册回调函数以处理已收到的推送通知。

```java
MFPPush.getInstance().initialize(this);
```

#### 是否支持推送
{: #is-push-supported }
检查设备是否支持推送通知。

```java
Boolean isSupported = MFPPush.getInstance().isPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 注册设备
{: #register-device }
向推送通知服务注册设备。

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

#### 获取标记
{: #get-tags }
从推送通知服务检索所有可用标记。

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

#### 预订
{: #subscribe }
预订所需的标记。

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

#### 获取预订
{: #get-subscriptions }
检索设备当前预订的标记。

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

#### 取消预订
{: #unsubscribe }
取消对标记的预订。

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

#### 注销
{: #unregister }
从推送通知服务实例注销设备。

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

## 处理推送通知
{: #handling-a-push-notification }
要处理推送通知，需要设置 `MFPPushNotificationListener`。  可实现以下某种方法来执行此操作。

### 选项 1
{: #option-one }
在要处理推送通知的活动中。

1. 向类声明中添加 `implements MFPPushNofiticationListener`。
2. 通过在 `onCreate` 方法中调用 `MFPPush.getInstance().listen(this)`，将该类设置为侦听器。
2. 然后，需要添加以下*必需*方法：

   ```java
   @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
   ```

3. 在此方法中，您将收到 `MFPSimplePushNotification`，并可以处理关于期望行为的通知。

### 选项 2
{: #option-two }
通过对 `MFPPush` 实例调用 `listen(new MFPPushNofiticationListener())` 来创建侦听器，如下所述：

```java
MFPPush.getInstance().listen(new MFPPushNotificationListener() {
    @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Handle push notification here
    }
});
```

<img alt="样本应用程序图像" src="notifications-app.png" style="float:right"/>

## 样本应用程序
{: #sample-application }

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80) Android Studio 项目。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。

## 在 Android 上将客户机应用程序迁移到 FCM
{: #migrate-to-fcm }

Google Cloud Messaging (GCM) 已[不推荐使用](https://developers.google.com/cloud-messaging/faq)，它已与 Firebase Cloud Messaging (FCM) 集成。Google 将在 2019 年 4 月之前关闭大多数 GCM 服务。

如果您正在使用 GCM 项目，那么请[将 Android 上的 GCM 客户机应用程序迁移到 FCM](https://developers.google.com/cloud-messaging/android/android-migrate-fcm)。

目前，使用 GCM 服务的现有应用程序将继续按原样运行。由于推送通知服务已更新为使用 FCM 端点，因此以后所有新应用程序必须使用 FCM。

**注**：在迁移到 FCM 后，更新您的项目以使用 FCM 凭证（而不是旧的 GCM 凭证）。

### FCM 项目设置

与旧的 GCM 模型相比，在 FCM 中设置应用程序稍有不同。 

 1. 获取通知提供程序凭证、创建一个 FCM 项目并将相同内容添加到 Android 应用程序。包含应用程序包名称 `com.ibm.mobilefirstplatform.clientsdk.android.push`。请参阅[此处的文档](https://console.bluemix.net/docs/services/mobilepush/push_step_1.html#push_step_1_android)，直至您已完成生成 `google-services.json` 文件的步骤

 2. 配置您的 Gradle 文件。在应用程序的 `build.gradle` 文件中添加以下内容 

    ```xml
    dependencies {
       ......
       compile 'com.google.firebase:firebase-messaging:10.2.6'
       .....

    }
    ```
	
    apply plugin: 'com.google.gms.google-services'
    
    - 在 `buildscript` 文件中添加以下依赖关系 -
    
    `classpath 'com.google.gms:google-services:3.0.0'`

 3. 配置 AndroidManifest 文件。`Android manifest.xml` 中需要进行以下更改 

**移除以下条目：**

```xml
    <receiver android:exported="true" android:name="com.google.android.gms.gcm.GcmReceiver" android:permission="com.google.android.c2dm.permission.SEND">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            <category android:name="your.application.package.name" />
        </intent-filter>
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
            <category android:name="your.application.package.name" />
        </intent-filter>
    </receiver>  
	
    <service android:exported="false" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService">
        <intent-filter>
            <action android:name="com.google.android.gms.iid.InstanceID" />
        </intent-filter>
    </service>

    <uses-permission android:name="your.application.package.name.permission.C2D_MESSAGE" />
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
```

**下列条目需要修改：**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
        </intent-filter>
    </service>
```

**将条目修改为：**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.firebase.MESSAGING_EVENT" />
        </intent-filter>
    </service>
```

**添加以下条目：**

```xml
    <service android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPush"
            android:exported="true">
            <intent-filter>
                <action android:name="com.google.firebase.INSTANCE_ID_EVENT" />
            </intent-filter>
    </service>
```
	
 4. 在 Android Studio 中打开应用程序。复制您在应用程序目录内的 **step-1** 中创建的 `google-services.json` 文件。请注意，`google-service.json` 文件将包含您添加的包名称。		
		
 5. 编译 SDK。构建应用程序。




