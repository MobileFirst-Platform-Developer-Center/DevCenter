---
layout: tutorial
title: 发送通知
relevantTo: [ios,android,windows,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要将推送通知或 SMS 通知发送到 iOS、Android 或 Windows 设备，首先需要使用 FCM 详细信息（针对 Android）、APNS 证书（针对 iOS）或 WNS 凭证（针对 Windows 8.1 Universal/Windows 10 UWP）来配置 {{ site.data.keys.mf_server }}。
然后，可以将通知发送到：所有设备（广播）、已注册特定标记的设备、单个设备标识、用户标识、仅 iOS 设备、仅 Android 设备、仅 Windows 设备或基于已认证的用户。

**先决条件**：请确保已阅读过[通知概述](../)教程。

#### 跳转至
{: #jump-to }
* [设置通知](#setting-up-notifications)
    * [Firebase 云消息传递](#firebase-cloud-messaging)
    * [Apple 推送通知服务](#apple-push-notifications-service)
    * [Windows 推送通知服务](#windows-push-notifications-service)
    * [SMS 通知服务](#sms-notification-service)
    * [作用域映射](#scope-mapping)
    * [已认证的通知](#authenticated-notifications)
* [定义标记](#defining-tags)
* [发送通知](#sending-notifications)    
    * [{{ site.data.keys.mf_console }}](#mobilefirst-operations-console)
    * [REST API](#rest-apis)
    * [定制通知](#customizing-notifications)
* [代理支持](#proxy-support)
* [后续教程](#tutorials-to-follow-next)

## 设置通知
{: #setting-up-notifications }
要启用通知支持，需要在 {{ site.data.keys.mf_server }} 和客户机应用程序中执行几个配置步骤。  
继续了解服务器端设置，或者跳转至[客户端设置](#tutorials-to-follow-next)。

在服务器端，必要的设置包括：配置所需供应商（APNS、FCM 或 WNS）和映射“push.mobileclient”作用域。

### Firebase 云消息传递
{: #firebase-cloud-messaging }
> **注：**Google 具有[不推荐的 GCM](https://developers.google.com/cloud-messaging/faq)，并已将云消息传递与 Firebase 相集成。 如果您正在使用 GCM 项目，请确保[将 Android 上的 GCM 客户机应用程序迁移到 FCM](https://developers.google.com/cloud-messaging/android/android-migrate-fcm)。

Android 设备将 Firebase 云消息传递 (FCM) 服务用于推送通知。  
要设置 FCM：

1. 访问 [Firebase Console](https://console.firebase.google.com/?pli=1)。
2. 创建新项目并提供项目名称。
3. 单击设置“齿轮”图标并选择**项目设置**。
4. 单击**云消息传递**选项卡以生成**服务器 API 密钥**和**发送方标识**，然后单击**保存**。

> 您还可以使用 [{{ site.data.keys.product_adj }} 推送服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_gcm_settings_put.html#Push-GCM-Settings--PUT-) 或 [{{ site.data.keys.product_adj }} 管理服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html#restservicesapi) 来设置 FCM

#### 注
{: #notes }
如果贵组织的防火墙限制了与因特网之间的流量，那么必须执行以下步骤：  

* 将防火墙配置为允许与 FCM 的连接，以便 FCM 客户机应用程序能够接收消息。
* 需要打开的端口包括 5228、5229 和 5230。 FCM 通常只使用 5228，但有时也会使用 5229 和 5230。
* FCM 没有提供特定的 IP，因此您必须允许防火墙接受与 Google ASN 15169 中所列 IP 块中的所有 IP 地址的出站连接。
* 确保防火墙接受端口 443 上从 {{ site.data.keys.mf_server }} 到 fcm.googleapis.com 的出站连接。

<img class="gifplayer" alt="添加 GCM 凭证的图像" src="gcm-setup.png"/>

### Apple 推送通知服务
{: #apple-push-notifications-service }
iOS 设备将 Apple 推送通知服务 (APNS) 用于推送通知。  
要设置 APNS：

1. 为开发或生产环境生成推送通知证书。 有关详细步骤，请参阅[此处](https://console.bluemix.net/docs/services/mobilepush/push_step_1.html#push_step_1)`针对 iOS` 部分。
2. 在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 推送设置**中，选择证书类型并提供证书的文件和密码。 然后，单击**保存**。

#### 注
{: #notes-apns }
* 要发送推送通知，必须可从 {{ site.data.keys.mf_server }} 实例访问以下服务器：  
    * 沙箱服务器：  
        * gateway.sandbox.push.apple.com:2195
        * feedback.sandbox.push.apple.com:2196
    * 生产服务器：  
        * gateway.push.apple.com:2195
        * Feedback.push.apple.com:2196
        * 1-courier.push.apple.com 5223
* 在开发阶段，使用 apns-certificate-sandbox.p12 沙箱证书文件。
* 在生产阶段，使用 apns-certificate-production.p12 生产证书文件。
    * 只有在将利用 APNS 生产证书的应用程序成功提交到 Apple 应用商店后才能测试该证书。

**注：**MobileFirst 不支持 Universal 证书。

> 您还可以使用 [{{ site.data.keys.product_adj }} 推送服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_apns_settings_put.html#Push-APNS-settings--PUT-) 或 [{{ site.data.keys.product_adj }} 管理服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc) 来设置 APNS

<img class="gifplayer" alt="添加 APNS 凭证的图像" src="apns-setup.png"/>

### Windows 推送通知服务
{: #windows-push-notifications-service }
Windows 设备将 Windows 推送通知服务 (WNS) 用于推送通知。  
要设置 WNS：

1. 请遵循 [Microsoft 提供的指示信息](https://msdn.microsoft.com/en-in/library/windows/apps/hh465407.aspx)来生成**包安全标识 (SID)** 和**客户机密钥**值。
2. 在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 推送设置**中，添加这些值并单击**保存**。

> 您还可以使用 [{{ site.data.keys.product_adj }} 推送服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_wns_settings_put.html?view=kc) 或 [{{ site.data.keys.product_adj }} 管理服务 REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_wns_settings_put.html?view=kc) 来设置 WNS

<img class="gifplayer" alt="添加 WNS 凭证的图像" src="wns-setup.png"/>

### SMS 通知服务
{: #sms-notification-service }
将使用以下 JSON 来设置用于发送 SMS 通知的 SMS 网关。 [使用 `smsConf` REST API](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_sms_settings_put.html) 以利用 SMS 网关配置来更新 {{ site.data.keys.mf_server }}

```json
{
	"host": "2by0.com",
	"name": "dummy",
	"port": "80",
	"programName": "gateway/add.php",
	"parameters": [{
		"name": "xmlHttp",
		"value": "false",
		"encode": "true"
	}, {
		"name": "httpsEnabled",
		"value": "false",
		"encode": "true"
	}]

}
```

> 可在[推送服务 API 参考](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html)中找到与 SMS 相关的更多 REST API

### 作用域映射
{: #scope-mapping }
将 **push.mobileclient** 作用域元素映射到应用程序。

1. 装入 {{ site.data.keys.mf_console }}，然后导航至 **[您的应用程序] → 安全性 → 作用域/元素映射**，单击**新建**。
2. 在**作用域元素**字段中写入“push.mobileclient”。 然后，单击**添加**。

    <div class="panel-group accordion" id="scopes" role="tablist">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="additional-scopes">
                <h4 class="panel-title">
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>单击以获取其他可用作用域的列表</b></a>
                </h4>
            </div>

            <div id="collapse-additional-scopes" class="panel-collapse collapse" role="tabpanel">
                <div class="panel-body">
                    <table class="table table-striped">
                        <tr>
                            <td><b>作用域</b></td>
                            <td><b>描述</b></td>
                        </tr>
                        <tr>
                            <td>apps.read	</td>
                            <td>允许读取应用程序资源。</td>
                        </tr>
                        <tr>
                            <td>apps.write	</td>
                            <td>允许创建、更新或删除应用程序资源。</td>
                        </tr>
                        <tr>
                            <td>gcmConf.read	</td>
                            <td>允许读取 GCM 配置设置（API 密钥和发送方标识）。</td>
                        </tr>
                        <tr>
                            <td>gcmConf.write	</td>
                            <td>允许更新或删除 GCM 配置设置。</td>
                        </tr>
                        <tr>
                            <td>apnsConf.read	</td>
                            <td>允许读取 APNS 配置设置。</td>
                        </tr>
                        <tr>
                            <td>apnsConf.write	</td>
                            <td>允许更新或删除 APNS 配置设置。</td>
                        </tr>
                        <tr>
                            <td>devices.read	</td>
                            <td>允许读取设备。</td>
                        </tr>
                        <tr>
                            <td>devices.write	</td>
                            <td>允许创建、更新或删除设备。</td>
                        </tr>
                        <tr>
                            <td>subscriptions.read	</td>
                            <td>允许读取预订。</td>
                        </tr>
                        <tr>
                            <td>subscriptions.write	</td>
                            <td>允许创建、更新或删除预订。</td>
                        </tr>
                        <tr>
                            <td>messages.write	</td>
                            <td>允许发送推送通知。</td>
                        </tr>
                        <tr>
                            <td>webhooks.read	</td>
                            <td>允许读取事件通知。</td>
                        </tr>
                        <tr>
                            <td>webhooks.write	</td>
                            <td>允许发送事件通知。</td>
                        </tr>
                        <tr>
                            <td>smsConf.read	</td>
                            <td>允许读取 SMS 配置设置。</td>
                        </tr>
                        <tr>
                            <td>smsConf.write	</td>
                            <td>允许更新或删除 SMS 配置设置。</td>
                        </tr>
                        <tr>
                            <td>wnsConf.read	</td>
                            <td>允许读取 WNS 配置设置</td>
                        </tr>
                        <tr>
                            <td>wnsConf.write	</td>
                            <td>允许更新或删除 WNS 配置设置。</td>
                        </tr>
                    </table>
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>关闭部分</b></a>
                </div>
            </div>
        </div>
    </div>

    <img class="gifplayer" alt="作用域映射" src="scope-mapping.png"/>

### 已认证的通知
{: #authenticated-notifications }
已认证的通知是发送到一个或多个`用户标识`的通知。  

将 **push.mobileclient** 作用域元素映射到应用程序所使用的安全性检查。  

1. 装入 {{ site.data.keys.mf_console }}，然后导航至 **[您的应用程序] → 安全性 → 作用域/元素映射**，然后单击**新建**或编辑现有作用域元素条目。
2. 选择安全性检查。 然后，单击**添加**。

    <img class="gifplayer" alt="已认证的通知" src="authenticated-notifications.png"/>

## 定义标记
{: #defining-tags }
在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 标记**中，单击**新建**。  
提供适当的`标记名称`和`描述`，然后单击**保存**。

<img class="gifplayer" alt="添加标记" src="adding-tags.png"/>

预订将设备注册与标记捆绑在一起。 当从标记中注销设备时，将从该设备自身自动取消预订所有相关的预订。 在一个设备有多个用户的情况下，在移动应用程序中应根据用户登录条件来实施预订。 例如，在用户成功登录到应用程序时发出预订调用，而在处理注销操作的过程中显式发出取消预订调用。

## 发送通知
{: #sending-notifications }
可以从 {{ site.data.keys.mf_console }} 或通过 REST API 发送推送通知。

* 通过 {{ site.data.keys.mf_console }}，可以发送以下两种类型的通知：标记通知和广播通知。
* 通过 REST API，可以发送所有形式的通知：标记通知、广播通知和已认证的通知。

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
可以将通知发送到单个设备标识、一个或多个用户标识、仅 iOS 设备、仅 Android 设备或已预订标记的设备。

#### 标记通知
{: #tag-notifications }
标记通知是只将预订了特定标记的所有设备作为目标的通知消息。 标记表示用户感兴趣的主题，并且能够根据所选兴趣来接收通知。

在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 发送通知**选项卡中，从**发送到**选项卡中选择**按标记划分的设备**，并提供**通知文本**。 然后，单击**发送**。

<img class="gifplayer" alt="按标记发送" src="sending-by-tag.png"/>

#### 广播通知
{: #breadcast-notifications }
广播通知是标记推送通知的一种形式，其将所有预订设备作为目标。 任何支持推送的 {{ site.data.keys.product_adj }} 应用程序在缺省情况下都可通过预订保留的 `Push.all` 标记（为每个设备自动创建）来启用广播通知。 可以使用编程方式取消预订 `Push.all` 标记。

在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 发送通知**选项卡中，从**发送到**选项卡中选择**所有**，并提供**通知文本**。 然后，单击**发送**。

![发送到所有](sending-to-all.png)

### REST API
{: #rest-apis }
使用 REST API 发送通知时，可以发送所有形式的通知：标记通知、广播通知和已认证的通知。

要发送通知，可使用 POST 向 REST 端点发出请求：`imfpush/v1/apps/<application-identifier>/messages`。  
示例 URL：

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.PinCodeSwift/messages
```

> 要查看所有推送通知 REST API，请参阅用户文档中的 [REST API 运行时服务](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html)主题。

#### 通知有效内容
{: #notification-payload }
请求可以包含以下有效内容属性：

有效内容属性| 定义
--- | ---
message | 要发送的警报消息
settings | 设置是通知的不同属性。
target | 目标集可以是使用者标识、设备、平台或标记。 只可以设置目标之一。
deviceIds | 设备标识表示的一组设备。 具有这些标识的设备将收到通知。 这是单点广播通知。
notificationType | 表示用于发送消息的通道（推送/SMS）的整数值。 允许的值包括 1（仅推送）、2（仅 SMS）和 3（推送和 SMS）
platforms | 一组设备平台。 运行在这些平台上的设备将收到通知。 受支持的值有 A (Apple/iOS)、G (Google/Android) 和 M (Microsoft/Windows)。
tagNames | 指定为 tagNames 的一组标记。 预订这些标记的设备将收到通知。 对基于标记的通知使用此类型的目标。
userIds | 通过 userIds 表示的一组要发送通知的用户。 这是单点广播通知。
phoneNumber | 用于注册设备和接收通知的电话号码。 这是单点广播通知。

**推送通知有效内容 JSON 示例**

```json
{
    "message" : {
    "alert" : "Test message",
  },
  "settings" : {
    "apns" : {
      "badge" : 1,
      "iosActionKey" : "Ok",
      "payload" : "",
      "sound" : "song.mp3",
      "type" : "SILENT",
    },
    "gcm" : {
      "delayWhileIdle" : ,
      "payload" : "",
      "sound" : "song.mp3",
      "timeToLive" : ,
    },
  },
  "target" : {
    // The list below is for demonstration purposes only - per the documentation only 1 target is allowed to be used at a time.
    "deviceIds" : [ "MyDeviceId1", ... ],
    "platforms" : [ "A,G", ... ],
    "tagNames" : [ "Gold", ... ],
    "userIds" : [ "MyUserId", ... ],
  },
}
```

**SMS 通知有效内容 JSON 示例**

```json
{
  "message" : {
    "alert": "Hello World from an SMS message"
  },
  "notificationType":3,
   "target" : {
     "deviceIds" : ["38cc1c62-03bb-36d8-be8e-af165e671cf4"]
   }
}
```

#### 发送通知
{: #sending-the-notification }
可使用不同的工具发送通知。  
出于测试目的，将使用 Postman，如下所述：

1. [配置保密客户机](../../authentication-and-security/confidential-clients/)。   
    通过 REST API 发送推送通知时，将使用由空格分隔的作用域元素 `messages.write` 和 `push.application.<applicationId>。`

    <img class="gifplayer" alt="配置保密客户机" src="push-confidential-client.png"/>

2. [创建访问令牌](../../authentication-and-security/confidential-clients#obtaining-an-access-token)。  


3. 向 **http://localhost:9080/imfpush/v1/apps/com.sample.PushNotificationsAndroid/messages** 发出 **POST** 请求
    - 如果使用远程 {{ site.data.keys.product_adj }}，请将 `hostname` 和 `port` 值替换为您自己的值。
    - 使用您自己的值更新应用程序标识值。

4. 设置头：
    - **Authorization**: `Bearer eyJhbGciOiJSUzI1NiIsImp ...`
    - 将“Bearer”后面的值替换为上述步骤 (1) 中的访问令牌值。

    ![authorization 头](postman_authorization_header.png)

5. 设置主体：
    - 更新其属性，如上述[通知有效内容](#notification-payload)中所述。
    - 例如，通过添加具有 **userIds** 属性 (attribute) 的 **target** 特性 (property)，可以将通知发送到特定的注册用户。

   ```json
   {
        "message" : {
            "alert" : "Hello World!"
        }
   }
   ```

   ![authorization 头](postman_json.png)

在单击**发送**按钮后，设备现在应该收到通知：

![样本应用程序的图像](notifications-app.png)

### 定制通知
{: #customizing-notifications }
在发送通知消息之前，您还可以定制以下通知属性。  

在 {{ site.data.keys.mf_console }} → **[您的应用程序] → 推送 → 标记 → 发送通知**选项卡中，展开**iOS/Android 定制设置**部分以更改通知属性。

### Android
{: #android }
* 通知声音、通知可在 FCM 存储器中存储的时间、定制有效内容等。
* 如果您想要更改通知标题，请在 Android 项目的 **strings.xml** 文件中添加 `push_notification_tile`。

### iOS
{: #ios }
* 通知声音、定制有效内容、操作键标题、通知类型和角标数字。

![定制推送通知](customizing-push-notifications.png)

## 代理支持
{: #proxy-support }
可使用代理设置来设置可选代理，通知将通过此可选代理发送至 Android 和 iOS 设备。 可以使用 **push.apns.proxy.** 和 **push.gcm.proxy.** 配置属性来设置代理。 有关更多信息，请参阅 [{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)。

## 后续教程
{: #tutorials-to-follow-next }
现在，已设置好服务器端，将开始设置客户端并处理收到的通知。

* 处理推送通知
    * [在 Cordova 应用程序中处理推送通知](../handling-push-notifications/cordova)
    * [在 iOS 应用程序中处理推送通知](../handling-push-notifications/ios)
    * [在 Android 应用程序中处理推送通知](../handling-push-notifications/android)
    * [在 Windows 应用程序中处理推送通知](../handling-push-notifications/windows)

* 处理 SMS 通知
    * [在 Cordova 应用程序中处理 SMS 通知](../handling-sms-notifications/cordova)
    * [在 iOS 应用程序中处理 SMS 通知](../handling-sms-notifications/ios)
    * [在 Android 应用程序中处理 SMS 通知](../handling-sms-notifications/android)
