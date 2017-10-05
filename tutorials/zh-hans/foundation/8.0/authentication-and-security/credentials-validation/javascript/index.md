---
layout: tutorial
title: 在 JavaScript（Cordova 或 Web）应用程序中实施验证问题处理程序
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: 下载 Web 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80
  - name: 下载 SecurityCheck Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在尝试访问受保护资源时，服务器（安全性检查）会向客户机发回一个列表，其中包含一个或多个**验证问题**，供客户机处理。  
该列表会作为 `JSON` 对象接收，列出安全性检查名称以及其他数据的可选 `JSON`：

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

然后，客户机应该为每项安全性检查注册**验证问题处理程序**。  
验证问题处理程序可定义特定于安全性检查的客户机端行为。

## 创建验证问题处理程序
{: creating-the-challenge-handler }
验证问题处理程序可处理 {{ site.data.keys.mf_server }} 发送的验证问题，如显示登录屏幕、收集凭证和将其提交回安全性检查。

在此示例中，安全性检查为 `PinCodeAttempts`，在[实现 CredentialsValidationSecurityCheck](../security-check) 中定义。 此安全性检查发送的验证问题包含剩余登录尝试次数 (`remainingAttempts`) 以及可选 `errorMsg`。


使用 `WL.Client.createSecurityCheckChallengeHandler()` API 方法创建和注册验证问题处理程序：

```javascript
PinCodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## 处理验证问题
{: #handling-the-challenge }
`createSecurityCheckChallengeHandler` 协议的最低要求是实现 `handleChallenge()` 方法，它负责请求用户提供凭证。 `handleChallenge` 方法会接收作为 `JSON` 对象的验证问题。

在此示例中，警报会提示用户输入 PIN 码：

```javascript
PinCodeChallengeHandler.handleChallenge = function(challenge) {
    var msg = "";

    // Create the title string for the prompt
    if(challenge.errorMsg != null) {
        msg =  challenge.errorMsg + "\n";
    } else {
        msg = "This data requires a PIN code.\n";
    }

    msg += "Remaining attempts: " + challenge.remainingAttempts;

    // Display a prompt for user to enter the pin code     
    var pinCode = prompt(msg, "");

    if(pinCode){ // calling submitChallengeAnswer with the entered value
        PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
    } else { // calling cancel in case user pressed the cancel button
        PinCodeChallengeHandler.cancel();   
    }                            
};
```

如果凭证不正确，那么预计框架会再次调用 `handleChallenge`。

## 提交验证问题的答案
{: #submitting-the-challenges-answer }
在从 UI 收集凭证之后，使用 `createSecurityCheckChallengeHandler` 的 `submitChallengeAnswer()` 将答案发送回安全性检查。 在此示例中，`PinCodeAttempts` 预期有一个名为 `pin` 且包含提交的 PIN 码的属性：

```javascript
PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
```

## 取消验证问题
{: #cancelling-the-challenge }
在某些情况下（如单击 UI 中的**取消**按钮），您想要通知框架完全丢弃此验证问题。  
要实现此目标，请调用：

```javascript
PinCodeChallengeHandler.cancel();
```

## 处理故障
{: #handling-failures }
某些场景可能会触发故障（如达到最大尝试次数）。 要处理这些场景，请实现 `createSecurityCheckChallengeHandler` 的 `handleFailure()`。  
作为参数传递的 JSON 对象的结构很大程度上取决于故障性质。

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure &&  error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
        alert("Error! " + JSON.stringify(error));
    }
};
```

## 处理成功
{: #handling-successes }
通常，该框架会自动处理成功情况，以支持应用程序的其余部分继续运作。

您还可以通过实现 `createSecurityCheckChallengeHandler` 的 `handleSuccess()`，选择在框架关闭验证问题处理程序流之前执行某些操作。 同样，`success` JSON 对象的内容和结构取决于安全性检查发送的内容。

在 `PinCodeAttemptsCordova` 样本应用程序中，成功不包含任何其他数据。

## 注册验证问题处理程序
{: #registering-the-challenge-handler }
为了使验证问题处理程序侦听正确的验证问题，您必须通知框架将验证问题处理程序与特定的安全性检查名称相关联。  
为此，请使用安全性检查创建验证问题处理程序，如下所述：

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## 样本应用程序
{: #sample-applications }
**PinCodeWeb** 和 **PinCodeCordova** 项目使用 `WLResourceRequest` 获取银行存款余额。  
该方法通过 PIN 码受到保护，最多有 3 次尝试机会。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80) Web 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80) Cordova 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) SecurityAdapters Maven 项目。  

### 样本用法
{: #sample-usage }
请遵循样本的 README.md 文件获取指示信息。

![样本应用程序](pincode-attempts-cordova.png)
