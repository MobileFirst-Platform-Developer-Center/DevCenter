---
layout: tutorial
title: 从基于事件源的通知迁移推送通知
breadcrumb_title: 迁移推送通知
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
从 {{ site.data.keys.product_full }} V8.0 起，基于事件源的模型将不受支持，并且完全由推送服务模型启用推送通知功能。 要将 {{ site.data.keys.product_adj }} 先前版本上基于事件源的现有应用程序移至 V8.0，必须将其迁移到新的推送服务模型。

迁移期间，请谨记，这并不是要用一个 API 代替另一个 API，更多的是使用一种模型/方法代替另一种模型/方法。

例如，在基于事件源的模型中，如果要对移动应用程序用户进行分段，从而向特定分段发送通知，那么会将每个分段作为不同事件源进行建模。 在推送服务模型中，将通过定义表示分段的标记并使用户预订各自的标记来实现相同目的。 基于标记的通知将替代基于事件源的通知。

#### 跳至：
{: #jump-to }
* [迁移方案](#migration-scenarios)
* [迁移工具](#migration-tool)

<br/>

下表为您提供两种模型之间的比较。

| 用户需求 | 事件源模型 | 推送服务模型 |
|------------------|--------------------|--------------------|
| 为应用程序启用推送通知 | {::nomarkdown}<ul><li>创建事件源适配器并在其中创建 EventSource。</li><li>使用推送凭证配置或设置应用程序。</li></ul>{:/} | 使用推送凭证配置或设置应用程序。 |
| 为移动客户端应用程序启用推送通知 | {::nomarkdown}<ul><li>创建 WLClient</li><li>连接到 {{ site.data.keys.mf_server }}</li><li>获取推送客户机实例</li><li>预订事件源</li></ul>{:/} | {::nomarkdown}<ul><li>实例化推送客户机</li><li>初始化推送客户机</li><li>注册移动设备</li></ul>{:/} |
| 要为移动式客户机应用程序启用基于特定标记的通知 | 不受支持。 | 预订相关标记（使用标记名称）。 |
| 在移动式客户机应用程序中接收并处理通知 | 注册侦听器实施。 | 注册侦听器实施。 |
| 将推送通知发送到移动式客户机应用程序 | {::nomarkdown}<ul><li>实现用于在内部调用 WL.Server API 来发送推送通知的适配器过程。</li><li>WL 服务器 API 提供发送通知的方式：<ul><li>按用户</li><li>按设备</li><li><li>广播（所有设备）</li></ul></li><li>然后，后端服务器应用程序可以调用适配器过程，以触发作为其应用程序逻辑中的一部分的推送通知。</li></ul>{:/} | {::nomarkdown}<ul><li>后端服务器应用程序可以直接调用消息 REST API。 但是，这些应用程序必须作为机密客户机向 {{ site.data.keys.mf_server }} 注册，并获取必须在 REST API 的授权头中传递的有效 OAuth 访问令牌。</li><li>REST API 提供用于发送通知的选项：<ul><li>按用户</li><li>按设备</li><li>按平台</li><li>按标记</li><li>广播（所有设备）</li></ul></li></ul>{:/} |
| 要按定期时间段（轮询时间间隔）触发推送通知 |  实现用于在事件源适配器内发送推送通知的函数，并将其作为 createEventSource 函数调用的一部分。 | 不受支持。 |
| 使用名称、URL 和事件类型注册挂钩。 | 在预订或取消预订推送通知的设备的路径上实现挂钩。 | 不受支持。 |

## 迁移方案
{: #migration-scenarios }
从 {{ site.data.keys.product }} V8.0 开始，将不支持基于事件源的模型，并且在 {{ site.data.keys.product }} 上完全由推送服务模型启用推送通知功能，该模型是事件源模型的更简单且灵活的替代方法。

IBM MobileFirst Platform Foundation 先前版本上基于事件源的现有应用程序需要迁移到 V8.0，从而迁移到新的推送服务模型。

#### 跳转到相关部分
{: #jump-to-section }
* [混合应用程序](#hybrid-applications)
* [本机 Android 应用程序](#native-android-applications)
* [本机 iOS 应用程序](#native-ios-applications)
* [本机 Windows Universal 应用程序](#native-windows-universal-applications)

### 混合应用程序
{: #hybrid-applications }
迁移方案示例包括使用单一事件源或多个源、广播或者单点广播通知或标签通知的应用程序。

#### 方案 1：现有应用程序在其应用中使用单个事件源
{: #hybrid-scenario-1-existing-applications-using-single-event-source-in-their-application }
应用程序已在 {{ site.data.keys.product_adj }} 的较早版本上使用单个事件源，因为它仅通过基于事件源的模型支持推送。

##### 客户机
{: #client-hybrid-1 }
要在 V8.0.0 中对此进行迁移，请将此模型转换为单点广播通知。

1. 初始化应用程序中的 {{ site.data.keys.product_adj }} 推送客户机实例，并在成功回调中注册应接收通知的回调方法。

   ```javascript
   MFPPush.initialize(function(successResponse){
   MFPPush.registerNotificationsCallback(notificationReceived); },
   function(failureResponse){alert("Failed to initialize");    
                              }  
   );
   ```

2. 实施通知回调方法。

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```

3. 向推送通知服务注册移动设备。

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. （可选）从推送通知服务注销移动设备。

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. 除去 WL.Client.Push.isPushSupported()（如果已使用）并使用：

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. 除去以下 `WL.Client.Push` API，因为将没有要预订并用于注册通知回调的事件源。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

##### 服务器
{: #server-hybrid-1 }
1. 除去适配器中的以下 WL.Server API（如果已使用）：
    * `notifyAllDevices()`
    * `notifyDevice()`
    * `notifyDeviceSubscription()`
    * `createEventSource()`
2. 针对使用同一事件源的每个应用程序完成以下步骤：
    1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

        您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
    2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
    3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
    4. 您可以使用以下任一方法来发送通知：
        * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
        * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### 方案 2：现有应用程序在其应用中使用多个事件源
{: #hybrid-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
使用多个事件源的应用程序要求基于预订对用户进行细分。

##### 客户机
{: #client-hybrid-2 }
这将映射到基于相关主题对用户/设备进行分段的标记。 要对此进行迁移，可以将此模型转换为基于标记的通知。

1. 初始化应用程序中的 MFPPush 客户机实例，并在成功回调中注册应接收通
知的回调方法。

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 实施通知回调方法。

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. 向推送通知服务注册移动设备。

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. （可选）从推送通知服务注销移动设备。

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. 除去 `WL.Client.Push.isPushSupported()`（如果已使用）并使用。

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	   }
   );
   ```

6. 除去以下 `WL.Client.Push` API，因为将没有要预订并用于注册通知回调的事件源。
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

7. 预订标记。

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. （可选）从标记取消预订。

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### 服务器
{: #server-hybrid-2 }
除去适配器中的以下 `WL.Server` API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### 方案 3：现有应用程序在其应用中使用广播/单点广播通知
{: #hybrid-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 客户机
{: #client-hybrid-3 }
1. 初始化应用程序中的 MFPPush 客户机实例，并在成功回调中注册应接收通
知的回调方法。

   ```javascript
   MFPPush.initialize(function(successResponse){
        MFPPush.registerNotificationsCallback(notificationReceived);              					},
        function(failureResponse){
            alert("Failed to initialize");
        }
   );
   ```

2. 实施通知回调方法。

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```

3. 向推送通知服务注册移动设备。

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
        alert("Successfully registered");
	    },
	  function(failureResponse) {
        alert("Failed to register");
	    }
   );
   ```

4. （可选）从推送通知服务注销移动设备。

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
        alert("Successfully unregistered");
	    },
	  function(failureResponse) {
        alert("Failed to unregister");
	    }
   );
   ```

5. 除去 WL.Client.Push.isPushSupported()（如果已使用）并使用：

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
        alert(successResponse);
	    },
	  function(failureResponse) {
        alert("Failed to get the push suport status");
	    }
   );
   ```

6. 除去以下 `WL.Client.Push` API：
    * `onReadyToSubscribe()`
    * `onMessage()`

##### 服务器
{: #server-hybrid-3 }
除去适配器中的 `WL.Server.sendMessage()`（如果已使用）。  
针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### 方案 4：现有应用程序在其应用中使用标签通知
{: #hybrid-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 客户机
{: #client-hybrid-4 }
1. 初始化应用程序中的 MFPPush 客户机实例，并在成功回调中注册应接收通
知的回调方法。

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 实施通知回调方法。

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. 向推送通知服务注册移动设备。

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. （可选）从推送通知服务注销移动设备。

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. 除去 `WL.Client.Push.isPushSupported()`（如果已使用）并使用：

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	   }
   );
   ```

6. 除去以下 `WL.Client.Push` API：
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `onReadyToSubscribe()`
    * `onMessage()`

7. 预订标记：

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
		alert("Successfully subscribed");
        },
      function(failureResponse) {
		alert("Failed to subscribe");
        }
   );
   ```

8. （可选）从标记取消预订：

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### 服务器
{: #server-hybrid-4 }
除去适配器中的 `WL.Server.sendMessage()`（如果已使用）。  
针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

### 本机 Android 应用程序
{: #native-android-applications }
迁移方案示例包括使用单一事件源或多个源、广播或者单点广播通知或标签通知的应用程序。

#### 方案 1：现有应用程序在其应用中使用单个事件源
{: #android-scenario-1-existing-applications-using-single-event-source-in-their-application }
应用程序已在 MobileFirst 的先前版本上使用单个事件源，因为它仅通过基于事件源的模型支持推送。

##### 客户机
{: #client-android-1 }
要在 V8.0 中对此进行迁移，请将此模型转换为单点广播通知。

1. 初始化应用程序中的 MFPPush 客户机实例。

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. 实现接口 MFPPushNotificationListener 并定义 onReceive()。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 向推送通知服务注册移动设备。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. （可选）从推送通知服务注销移动设备。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用 `push.isPushSupported();`。
6. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

##### 服务器
{: #server-android-1 }
除去适配器中的以下 `WL.Server` API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### 方案 2：现有应用程序在其应用中使用多个事件源
{: #android-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
使用多个事件源的应用程序要求基于预订对用户进行细分。

##### 客户机
{: #client-android-2 }
这将映射到基于相关主题对用户/设备进行分段的标记。 要将它迁移到 {{ site.data.keys.product }} V8.0.0，请将此模型转换为基于标记的通知。

1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. 实现接口 MFPPushNotificationListener 并定义 onReceive()。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 向推送通知服务注册移动设备。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. （可选）从推送通知服务注销移动设备：

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用 `push.isPushSupported();`。
6. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`

7. `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现
8. 预订标记：

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

9. （可选）从标记取消预订：

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### 服务器
{: #server-android-2 }
除去适配器中的以下 `WL.Server` API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。     

#### 方案 3：现有应用程序在其应用中使用广播/单点广播通知
{: #android-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 客户机
{: #client-android-3 }

1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. 实施接口 `MFPPushNotificationListener` 并定义
`onReceive()`。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 向推送通知服务注册移动设备。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. （可选）从推送通知服务注销移动设备。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用 `push.isPushSupported();`。
6. 除去以下 WLClient.Push API：
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

##### 服务器
{: #server-android-3 }
除去适配器中的 WL.Server.sendMessage()` API（如果已使用）：

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。    

#### 方案 4：现有应用程序在其应用中使用标签通知
{: #android-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 客户机
{: #client-android-4 }

1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. 实现接口 MFPPushNotificationListener 并定义 onReceive()。

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 向推送通知服务注册移动设备。

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. （可选）从推送通知服务注销移动设备。

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用 `push.isPushSupported()`；
6. 除去以下 `WLClient.Push` API：
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

7. 预订标记：

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

8. （可选）从标记取消预订：

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### 服务器
{: #server-android-4 }
除去适配器中的 `WL.Server.sendMessage()`（如果已使用）。

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

### 本机 iOS 应用程序
{: #native-ios-applications }
迁移方案示例包括使用单一事件源或多个源、广播或者单点广播通知或标签通知的应用程序。

#### 方案 1：现有应用程序在其应用中使用单个事件源
{: #ios-scenario-1-existing-applications-using-single-event-source-in-their-application }
应用程序已在 {{ site.data.keys.product_adj }} 的较早版本上使用单个事件源，因为它仅通过基于事件源的模型支持推送。

##### 客户机
{: #client-ios-1 }
要在 V8.0 中对此进行迁移，请将此模型转换为单点广播通知。

1. 初始化应用程序中的 `MFPPush` 客户机实例。

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. 在 `didReceiveRemoteNotification()` 中实施通知处理。
3. 向推送通知服务注册移动设备。

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
    	   NSLog(@"Failed to register");
        } else {
            NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. （可选）从推送通知服务注销移动设备。

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        } else {
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用：

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 实施

7. 在
`didRegisterForRemoteNotificationsWithDeviceToken`
中调用 `sendDeviceToken()`。

   ```objc
   [[MFPPush sharedInstance] sendDeviceToken:deviceToken];
   ```

##### 服务器
{: #server-ios-1 }
除去适配器中的以下 WL.Server API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。

#### 方案 2：现有应用程序在其应用中使用多个事件源
{: #ios-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
使用多个事件源的应用程序要求基于预订对用户进行细分。

##### 客户机
{: #client-ios-2}
这将映射到基于相关主题对用户/设备进行分段的标记。 要将它迁移到 {{ site.data.keys.product_adj }} V8.0.0，请将此模型转换为基于标记的通知。

1. 初始化应用程序中的 `MFPPush` 客户机实例。

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. 在 `didReceiveRemoteNotification()` 中实施通知处理。
3. 向推送通知服务注册移动设备：

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. （可选）从推送通知服务注销移动设备：

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用：

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 实施

7. 在
`didRegisterForRemoteNotificationsWithDeviceToken`
中调用 `sendDeviceToken()`。
8. 预订标记：

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

9. （可选）从标记取消预订：

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### 服务器
:{: #server-ios-2 }
除去适配器中的 `WL.Server`（如果已使用）。

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。    

#### 方案 3：现有应用程序在其应用中使用广播/单点广播通知
{: #ios-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 客户机
{: #client-ios-3 }
1. 初始化应用程序中的 MFPPush 客户机实例：

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. 在 `didReceiveRemoteNotification()` 中实施通知处理。
3. 向推送通知服务注册移动设备：

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. （可选）从推送通知服务注销移动设备。

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用：

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 除去以下 `WLClient.Push` API：
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 实施

##### 服务器
{: #server-ios-3 }
除去适配器中的 `WL.Server.sendMessage`（如果已使用）。

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。  

#### 方案 4：现有应用程序在其应用中使用标签通知
{: #ios-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 客户机
{: #client-ios-4 }

1. 初始化应用程序中的 MFPPush 客户机实例：

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. 在 `didReceiveRemoteNotification()` 中实施通知处理。
3. 向推送通知服务注册移动设备：

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. （可选）从推送通知服务注销移动设备：

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. 除去 `WLClient.Push.isPushSupported()`（如果已使用）并使用 `[[MFPPush sharedInstance] isPushSupported]`。
6. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 实施

7. 在
`didRegisterForRemoteNotificationsWithDeviceToken`
中调用 `sendDeviceToken()`。
8. 预订标记：

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        } else {    
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

9. （可选）从标记取消预订：

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### 服务器
{: server-ios-4 }
除去适配器中的以下 `WL.Server.sendMessage()`（如
果已使用）。

针对使用同一事件源的每个应用程序完成以下步骤：

1. 使用 {{ site.data.keys.mf_console }} 设置凭证。 请参阅[配置推送通知设置](../../notifications/sending-notifications)。

    您还可以对 Android 应用程序使用[更新 GCM 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API 来设置凭证，或者对 iOS 应用程序使用[更新 APN 设置 (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API 来设置凭证。
2. 在**作用域元素映射**中添加作用域 `push.mobileclient`。
3. 创建标记以支持将推送通知发送至订户。 请参阅“为推送通知[定义标记](../../notifications/sending-notifications/#defining-tags)”。
4. 您可以使用以下任一方法来发送通知：
    * {{ site.data.keys.mf_console }}。 请参阅[将推送通知发送至订户](../../notifications/sending-notifications/#sending-notifications)。
    * 具有 `userId`/`deviceId` 的[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API。  

### 本机 Windows Universal 应用程序
{: #native-windows-universal-applications }
迁移方案示例包括使用单一事件源或多个源、广播或者单点广播通知或标签通知的应用程序。

#### 方案 1：现有应用程序在其应用中使用单个事件源
{: #windows-scenario-1-existing-applications-using-single-event-source-in-their-application }
要在 V8.0 中对此进行迁移，请将此模型转换为单点广播通知。

##### 客户机
{: #windows-client-1}

1. 初始化应用程序中的 `MFPPush` 客户机实例。

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. 向推送通知服务注册移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. （可选）从推送通知服务注销移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. 除去 `WLClient.Push.IsPushSupported()`（如果已使用）并使用 `push.IsPushSupported();`。
5. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

##### 服务器
{: #windows-server-1 }
除去适配器中的以下 `WL.Server` API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 在 {{ site.data.keys.mf_console }} 的**推送设置**页面中设置 WNS 凭证或使用 WNS 设置 REST API。
2. 将**映射作用域元素**中的作用域 `push.mobileclient` 添加到 {{ site.data.keys.mf_console }} 的“安全性”选项卡的安全性检查部分中。
3. 您还可将[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API 与 `userId`/`deviceId` 配合使用来发送消息。

#### 方案 2：现有应用程序在其应用中使用多个事件源
{: #windows-scenario-2-existing-applications-using-multiple-event-sources-in-their-appliction }
使用多个事件源的应用程序要求基于预订对用户进行细分。

##### 客户机
{: #windows-client-2 }
这将映射到基于相关主题对用户/设备进行分段的标记。 要将它迁移到 {{ site.data.keys.product_adj }} V8.0.0，请将此模型转换为基于标记的通知。

1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. 向 IMFPUSH 服务注册移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. （可选）从 IMFPUSH 服务注销移动设备：

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. 除去 `WLClient.Push.IsPushSupported()`（如果已使用）并使用 `push.IsPushSupported();`。
5. 除去以下 `WLClient.Push` API，因为将没有要预订并用于注册通知回调的事件源：
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

6. 预订标记：

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

7. （可选）从标记取消预订：

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### 服务器
{: #windows-server-2 }
除去适配器中的以下 `WL.Server` API（如果已使用）：

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

针对使用同一事件源的每个应用程序完成以下步骤：

1. 在 {{ site.data.keys.mf_console }} 的**推送设置**页面中设置 WNS 凭证或使用 WNS 设置 REST API。
2. 将**映射作用域元素**中的作用域 `push.mobileclient` 添加到 {{ site.data.keys.mf_console }} 的**安全性**选项卡的安全性检查部分中。
3. 在 {{ site.data.keys.mf_console }} 的**标记**页面中创建推送标记。
4. 您还可将[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API 与 `userId`/`deviceId`/`tagNames`（作为目标）配合使用来发送通知。

#### 方案 3：现有应用程序在其应用中使用广播/单点广播通知
{: #windows-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }

##### 客户机
{:# windows-client-3 }
1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. 向推送通知服务注册移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. （可选）从推送通知服务注销移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. 除去 `WLClient.Push.isPushSupported()`（如果已使用），并使用 `push.IsPushSupported();`。
5. 除去以下 `WLClient.Push` API：
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

##### 服务器
{: #windows-server-3 }
除去适配器中的 `WL.Server.sendMessage()`（如果已使用）。

针对使用同一事件源的每个应用程序完成以下步骤：

1. 在 {{ site.data.keys.mf_console }} 的**推送设置**页面中设置 WNS 凭证或使用 WNS 设置 REST API。
2. 将**映射作用域元素**中的作用域 `push.mobileclient` 添加到 {{ site.data.keys.mf_console }} 的**安全性**选项卡的安全性检查部分中。
3. 在 {{ site.data.keys.mf_console }} 的**标记**页面中创建推送标记。
4. 您还可将[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API 与 `userId`/`deviceId`/`tagNames`（作为目标）配合使用来发送通知。

#### 方案 4：现有应用程序在其应用中使用标签通知
{: #windows-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 客户机
{: #windows-client-4 }

1. 初始化应用程序中的 `MFPPush` 客户机实例：

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   ```

2. 实现接口 MFPPushNotificationListener 并定义 onReceive()。

   ```csharp
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

3. 向推送通知服务注册移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

4. （可选）从推送通知服务注销移动设备。

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

5. 除去 `WLClient.Push.IsPushSupported()`（如果已使用）并使用 `push.IsPushSupported()`；
6. 除去以下 `WLClient.Push` API：
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 和 `WLNotificationListener` 实现

7. 预订标记：

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

8. （可选）从标记取消预订：

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### 服务器
{: #windows-server-4 }
除去适配器中的 `WL.Server.sendMessage()`（如果已使用）。

针对使用同一事件源的每个应用程序完成以下步骤：

1. 在 {{ site.data.keys.mf_console }} 的**推送设置**页面中设置 WNS 凭证或使用 WNS 设置 REST API。
2. 将**映射作用域元素**中的作用域 `push.mobileclient` 添加到 {{ site.data.keys.mf_console }} 的**安全性**选项卡的安全性检查部分中。
3. 在 {{ site.data.keys.mf_console }} 的**标记**页面中创建推送标记。
4. 您还可将[推送消息 (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API 与 `userId`/`deviceId`/`tagNames`（作为目标）配合使用来发送通知。

## 迁移工具
{: #migration-tool }
迁移工具可帮助将 MobileFirst Platform Foundation 7.1 推送数据（设备、用户预订、凭证和标记）迁移到 {{ site.data.keys.product }} 8.0。  
迁移工具可通过以下功能简化此过程：

1. 从 MobileFirst Platform Foundation 7.1 数据库中读取每个应用程序的设备、凭证、标记和用户预订。
2. 将数据复制到 {{ site.data.keys.product }} 8.0 数据库中各个应用程序的相应表格中。
3. 迁移所有 V7.1 环境的所有推送数据，而不考虑 V8.0 应用程序中的环境。

迁移工具将不会修改与用户预订、应用程序环境或设备相关的任何数据。  

使用迁移工具之前，请务必了解以下信息：

1. 您必须已安装 Java V1.6 或更高版本。
2. 确保 MobileFirst Server 7.1 和 {{ site.data.keys.mf_server }} 8.0 均已设置并准备就绪。
3. 生成 MobileFirst Server 7.1 和 {{ site.data.keys.mf_server }} 8.0 的备份。
4. 在 {{ site.data.keys.mf_server }} 8.0 中注册以上应用程序的最新版本。
	* 应用程序的显示名称应与 MobileFirst Platform Foundation 7.1 中相应的应用程序相匹配。
	* 请记住 PacakgeName/BundleID，并为应用程序提供相同的值。
	* 如果在 {{ site.data.keys.mf_server }} 8.0 上未注册该应用程序，那么迁移将失败。
5. 为应用程序的每个环境提供作用域-元素映射。 [了解有关作用域映射的更多信息](../../notifications/sending-notifications/#scope-mapping)。

#### 过程
{: #procedure }
1. 从[以下 GitHub 存储库](http://github.com)下载迁移工具。
2. 下载该工具后，在 **migration.properties** 文件中提供以下详细信息：

    | 值                | 描述  | 样本值 |
    |----------------------|--------------|---------------|
    | w.db.type		       | 考虑中的数据库类型	           | pw.db.type = db2 可能的值：DB2、Oracle、MySql 或 Derby |
    | pw.db.url			   | MobileFirst Platform Foundation 7.1 Worklight DB URL  | jdbc:mysql://localhost:3306/WRKLGHT |
    | pw.db.adminurl	   | MobileFirst Platform Foundation 7.1 Admin DB URL      | jdbc:mysql://localhost:3306/ADMIN |
    | pw.db.username	   | MobileFirst Platform Foundation 7.1 Worklight DB 用户名 | pw.db.username=root |
    | pw.db.password	   | MobileFirst Platform Foundation 7.1 Worklight DB 密码 | pw.db.password=root |
    | pw.db.adminusername  | MobileFirst Platform Foundation 7.1 Admin DB 用户名     | pw.db.adminusername=root |
    | pw.db.adminpassword  | MobileFirst Platform Foundation 7.1 Admin DB 密码     | pw.db.adminpassword=root |
    | pw.db.urlTarget	   | MFP 8.0 DB URL						        | jdbc:mysql://localhost:3306/MFPDATA |
    | pw.db.usernameTarget | MFP 8.0 DB 用户名						| pw.db.usernameTarget=root |
    | pw.db.passwordTarget | MFP 8.0 DB 密码						| pw.db.passwordTarget=root |
    | pw.db.schema         | MobileFirst Platform Foundation 7.1 Worklight DB 模式 | WRKLGT |
    | pw.db.adminschema    | MobileFirst Platform Foundation 7.1 Admin DB 模式     | WLADMIN |
    | pw.db.targetschema   | {{ site.data.keys.product }} 8.0 Worklight DB 模式    | MFPDATA |
    | runtime			   | MobileFirst Platform Foundation 7.1 Runtime 名称		 | runtime=worklight |
    | applicationId	       | 提供 MobileFirst Platform Foundation 7.1 上注册的应用程序列表（用逗号 (,) 分隔） | HybridTestApp,NativeiOSTestApp |
    | targetApplicationId  | 提供 {{ site.data.keys.product }} 8.0 上注册的应用程序列表（用逗号 (,) 分隔）   | com.HybridTestApp,com.NativeiOSTestApp |

    * 确保已按正确的顺序提供 **applicationID** 和 **targetApplicationId** 的值。 将采用 1-1（或 n-n）方式执行映射，即 **applicationId** 列表中第一个应用程序的数据将迁移到 **targetApplicationId** 列表中的第一个应用程序。
	* 在 **targetApplicationId** 列表中，提供应用程序的 packageName/BundleId。 即，对于 MobileFirst Platform Foundation 7.1 中的 TestApp1，**targetApplicationId** 将作为 TestApp1 的 packageName/BundleId（即 com.TestApp1）。 这是因为在 MobileFirst Platform Foundation 7.1 中，**applicationId** 是应用程序名称，在 {{ site.data.keys.mf_server }} 8.0 中，它是基于应用程序环境的 packageName/BundleId/packageIdentityName。

2. 通过使用以下命令来运行该工具：

   ```bash
   java -jar pushDataMigration.jar path-to-migration.properties
   ```

   * 如果工具 .jar 文件与属性文件位于不同位置，请将 **path-to-migration.properties** 替换为指向 **migration.properties** 的路径。 否则，请从该命令中除去路径。
