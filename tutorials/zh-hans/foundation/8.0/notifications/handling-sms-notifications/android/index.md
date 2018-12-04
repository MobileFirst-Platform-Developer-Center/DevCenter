---
layout: tutorial
title: 在 Android 中处理 SMS 通知
breadcrumb_title: Handling SMS in Android
relevantTo: [android]
weight: 10
downloads:
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
SMS 通知是推送通知的一个子集，因此请务必先阅读[在 Android 中查看推送通知](../../)教程。

**先决条件：**

* 确保您已阅读过下列教程：
  * [通知概述](../../)
  * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
  * [将 {{ site.data.keys.product }} SDK 添加到 iOS 应用程序](../../../application-development/sdk/ios)
* 本地运行的 {{ site.data.keys.mf_server }} 或远程运行的 {{ site.data.keys.mf_server }}。
* 安装在开发人员工作站上的 {{ site.data.keys.mf_cli }}


#### 跳转至：
{: #jump-to }
* [通知 API](#notifications-api)   
* [使用 SMS 预订 servlet](#using-an-sms-subscribe-servlet)     
* [样本应用程序](#sample-application)

## 通知 API
{: #notifications-api }
在 SMS 通知中，当注册设备时，将传递电话号码值。

#### 验证问题处理程序
{: #challenge-handlers }
如果 `push.mobileclient` 作用域映射到**安全性检查**，那么需要确保在使用任何推送 API 之前，存在已注册的匹配**验证问题处理程序**。

#### 初始化
{: #initialization }
在客户机应用程序使用适当的应用程序上下文连接到 MFPPush 服务时为必需项。

* 应先调用此 API 方法，然后再使用任何其他 MFPPush API。
* 注册回调函数以处理已收到的推送通知。

```java
MFPPush.getInstance().initialize(this);
```

#### 注册设备
{: #register-device }
向推送通知服务注册设备。

```java
MFPPush.getInstance().registerDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Successfully registered
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registration failed with error
    }
}, optionObject);
```

* **optionObject**：一个 `JSONObject`，其包含注册设备所用的电话号码。 例如：

```java
JSONObject optionObject = new JSONObject();
try {
    // Obtain the inputted phone number.
    optionObject.put("phoneNumber", editPhoneText.getText().toString());
}
catch(Exception ex) {
    ex.printStackTrace();
}
```

> 也可以使用[推送设备注册 (POST) REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html) 来注册设备

#### 注销设备
{: #unregister-device }
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

## 使用 SMS 预订 servlet
{: #using-an-sms-subscribe-servlet }
可使用 REST API 将通知发送到已注册的设备。 可以发送所有形式的通知：标记通知、广播通知和已认证的通知

要发送通知，可使用 POST 向 REST 端点发出请求：`imfpush/v1/apps/<application-identifier>/messages`。  
示例 URL： 

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.sms/messages
```

> 要查看所有推送通知 REST API，请参阅用户文档中的 <a href="https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html">REST API 运行时服务</a>主题。

要发送通知，请参阅[发送通知](../../sending-notifications)教程。

<img alt="样本应用程序图像" src="sample-app.png" style="float:right"/>
## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80) Android 项目。

**注：**要运行此样本，需要在任何 Android 设备上安装最新版本的 Google Play Services。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。
