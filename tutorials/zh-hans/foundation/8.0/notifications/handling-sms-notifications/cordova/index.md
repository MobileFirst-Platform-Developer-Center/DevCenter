---
layout: tutorial
title: 在 Cordova 中处理 SMS 通知
breadcrumb_title: 在 Cordova 中处理 SMS
relevantTo: [cordova]
weight: 8
downloads:
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsCordova/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
SMS 通知是推送通知的一个子集，因此请务必先阅读[在 Cordova 中查看推送通知](../../)教程。  
iOS 和 Android 都支持 Cordova 应用程序中的 SMS 通知。

**先决条件：**

* 确保您已阅读过下列教程：
  * [通知概述](../../)
  * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
  * [将 {{ site.data.keys.product }} SDK 添加到 iOS 应用程序](../../../application-development/sdk/cordova)
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

#### 注册设备
{: #register-device }
向推送通知服务注册设备。

```javascript
MFPPush.registerNotificationsCallback(notificationReceived);

function registerDevice() {
    var phoneNumber = prompt("Enter Your 10 digit phone number");
    if(phoneNumber != null &&  phoneNumber!="" &&  /^\d+$/.test(phoneNumber)) {
        var options = {};
        options.phoneNumber = phoneNumber;
        MFPPush.registerDevice(options, 
        function(successResponse) {
            alert("Successfully registered");
            enableButtons();
        }, function(failureResponse) {
            alert("Failed to register");
        });
        return true;
    }

    else {
        alert("Failed to register, You have entered invalid number");
    }
}
```

> 也可以使用[推送设备注册 (POST) REST API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html) 来注册设备

## 使用 SMS 预订 servlet
{: #using-an-sms-subscribe-servlet}
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
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsSwift/tree/release80) Cordova 项目。

**注：**要运行此样本，需要在任何 Android 设备上安装最新版本的 Google Play Services。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。
