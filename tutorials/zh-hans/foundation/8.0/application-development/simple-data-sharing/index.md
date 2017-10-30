---
layout: tutorial
title: 简单数据共享
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
通过“简单数据共享”功能，可在单个设备上的一系列应用程序中安全地共享轻量信息。 此功能使用已存在于不同移动 SDK 中的本机 API 来提供一个统一的开发者 API。 此 {{ site.data.keys.product_adj }} API 将消除不同平台的复杂性，便于开发人员快速实施代码以进行应用程序间的通信。

在 iOS 和 Android 上针对 Cordova 和本机应用程序都支持此功能。

在启用“简单数据共享”功能之后，您可以使用提供的 Cordova 和本机 API 在设备上的一系列应用程序中交换简单字符串标记。

#### 跳转至
{: #jump-to}
* [术语](#terminology)
* [启用“简单数据共享”功能](#enabling-the-simple-data-sharing-feature)
* [简单数据共享 API 概念](#simple-data-sharing-api-concepts)
* [限制和注意事项](#limitations-and-considerations)

## 术语
{: #terminology }
### {{ site.data.keys.product_adj }} 应用程序系列
{: #mobilefirst-application-family }
应用程序系列是关联共享相同级别信任的一组应用程序的方法。 同一系列的应用程序之间可以彼此安全地共享信息。

要被视为同一 {{ site.data.keys.product_adj }} 应用程序系列的一部分，同一系列中的所有应用程序都必须满足以下需求：

* 为应用程序描述符中的应用程序系列指定相同的值。
	* 对于 iOS 应用程序，此需求与访问组权利值同义。
	* 对于 Android 应用程序，此需求与 **AndroidManifest.xml** 文件中的 **sharedUserId** 值同义。

    > **注：**对于 Android，名称必须采用 **x.y** 格式。

* 应用程序必须由相同的签署身份进行签署。 此需求意味着只有来自相同组织的应用程序才能使用此功能。
    * 对于 iOS 应用程序，此要求意味着使用相同应用程序标识前缀、供应概要文件和签署身份对应用程序进行签名。
	* 对于 Android 应用程序，此要求意味着相同签署证书和密钥。

除了 {{ site.data.keys.product }} 提供的 API 之外，同一 {{ site.data.keys.product_adj }} 应用程序系列中的应用程序也可以使用通过各自的本机移动 SDK API 可用的数据共享 API。

### 字符串标记
{: #string-tokens }
现在可以通过“简单数据共享”功能在混合或本机 iOS 和 Android 应用程序中执行如下操作：在同一 {{ site.data.keys.product_adj }} 应用程序系列的应用程序中共享字符串标记。

字符串标记被认为是简单字符串，例如密码或 cookie。 使用大字符串将导致严重的性能降级。

使用 API 时请考虑对标记进行加密，以提高安全性。

> 有关更多信息，请参阅 [JSONStore 安全实用程序](../jsonstore/security-utilities/)。

## 启用“简单数据共享”功能
{: #enabling-the-simple-data-sharing-feature }
不管您的应用程序是本机应用程序还是基于 Cordova 的应用程序，下面的指示信息都适用。  
在 Xcode/Android Studio 中打开您的应用程序，并且：

### iOS
{: #ios }
1. 在 Xcode 中，为要成为相同应用程序系列一部分的所有应用程序添加具有唯一名称的密钥链访问组。 在系列中，所有应用程序的应用程序标识权利必须相同。
2. 确保属于相同系列的应用程序共享相同的“应用程序标识”前缀。 有关更多信息，请参阅“3. 在 iOS 开发人员库中管理多个应用程序标识前缀”。
4. 保存并签署应用程序。 确保该组中的所有应用程序均由相同的 iOS 整数和供应概要文件签名。
5. 针对要加入相同应用程序系列的所有应用程序重复以上步骤。

现在，您可以使用本机“简单数据共享”API 在相同系列中的应用程序组之间共享简单字符串。

### Android
{: #android }
1. 通过在 **AndroidManifest.xml** 文件的清单标记中指定应用程序系列名称作为 **android:sharedUserId** 元素来启用“简单数据共享”选项。 例如：

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
   ```

2. 确保使用相同的签名凭证对属于相同系列的应用程序进行签名。
3. 卸载未指定 **sharedUserId** 或使用不同的 **sharedUserId** 的任何较早版本的应用程序。
4. 在设备上安装该应用程序。
5. 针对要加入相同应用程序系列的所有应用程序重复以上步骤。

现在，您可以使用提供的本机“简单数据共享”API 在相同系列中的应用程序组之间共享简单字符串。

## 简单数据共享 API 概念
{: #simple-data-sharing-api-concepts }
“简单数据共享”API 允许相同系列中的任何应用程序在同一个位置设置、获取和清除键值对。 “简单数据共享”API 对每个平台都是相似的，并且可提供摘要层，隐藏每个本机 SDK 的 API 中存在的复杂性，使之便于使用。

以下示例显示了如何从不同环境的共享凭证存储器设置、获取和删除标记。

### JavaScript
{: #javascript }
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> 有关 Cordova API 的更多信息，请参阅 `WL.Client` API 参考中的 [getSharedToken](../../api/client-side-api/javascript/client/)、[setSharedToken](../../api/client-side-api/javascript/client/) 和 [clearSharedToken](../../api/client-side-api/javascript/client/) 函数。

### Objective-C
{: #objective-c }
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> 有关 Objective-C API 的更多信息，请参阅 API 参考中的 [WLSimpleDataSharing](../../api/client-side-api/objc/client/) 类。

### Java
{: #java }
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> 有关 Java API 的更多信息，请参阅 API 参考中的 [WLSimpleDataSharing](../../api/client-side-api/java/client/)类。

## 限制和注意事项
{: #limitations-and-considerations }
### 安全性注意事项
{: #security-considerations }
由于此功能允许在一组应用程序之间进行数据访问，所以必须特别注意防止未授权用户对设备进行访问。 请考虑以下安全方面：

#### 设备锁定
{: #device-lock }
为了提高安全性，请确保设备受到设备密码、密码或 Pin 码的保护，以便设备丢失或被盗时保护对设备的访问。

#### 越狱检测
{: #jailbreak-detection }
考虑使用移动设备管理解决方案以保证企业中的设备未越狱或未被获取 root 权限。

#### 加密
{: #encryption }
在共享标记前，请考虑对所有标记进行加密，以提高安全性。 有关更多信息，请参阅 JSONStore 安全实用程序。

### 大小限制
{: #size-limit }
此功能是专为共享小字符串（如密码或 cookie）设计的。 请不要滥用此功能，因为尝试加密和解密或读取和写入任何大型数据值可能导致性能受影响。

### 维护问题
{: #maintenance-challenges }
Android 开发人员必须意识到，启用此功能或更改应用程序系列值将导致无法升级以不同系列名称安装的现有应用程序。 出于安全原因，Android 要求先卸载较早版本的应用程序，然后才能在新系列名称下安装应用程序。
