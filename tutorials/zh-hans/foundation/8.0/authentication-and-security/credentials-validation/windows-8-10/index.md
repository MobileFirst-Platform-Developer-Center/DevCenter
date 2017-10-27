---
layout: tutorial
title: 在 Windows 8.1 Universal 和 Windows 10 UWP 应用程序中实施验证问题处理程序
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: 下载 Win8 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80
  - name: 下载 Win10 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80
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
{: #creating-the-challenge-handler }
验证问题处理程序是可处理 {{ site.data.keys.mf_server }} 发送的验证问题的类，如显示登录屏幕、收集凭证和将其提交回安全性检查。

在此示例中，安全性检查为 `PinCodeAttempts`，在[实现 CredentialsValidationSecurityCheck](../security-check) 中定义。 此安全性检查发送的验证问题包含剩余登录尝试次数 (`remainingAttempts`) 以及可选 `errorMsg`。

创建可扩展 `Worklight.SecurityCheckChallengeHandler` 的 C# 类：

```csharp
public class PinCodeChallengeHandler : Worklight.SecurityCheckChallengeHandler
{
}
```

## 处理验证问题
{: #handling-the-challenge }
`SecurityCheckChallengeHandler` 类的最低要求是实现构造方法和 `HandleChallenge` 方法，它负责请求用户提供凭证。 `HandleChallenge` 方法会接收作为 `Object` 的验证问题。

添加构造方法：

```csharp
public PinCodeChallengeHandler(String securityCheck) {
    this.securityCheck = securityCheck;
}
```

在此 `HandleChallenge` 示例中，警报会提示用户输入 PIN 码：

```csharp
public override void HandleChallenge(Object challenge)
{
    try {
      JObject challengeJSON = (JObject)challenge;

      if (challengeJSON.GetValue("errorMsg") != null)
      {
          if (challengeJSON.GetValue("errorMsg").Type == JTokenType.Null)
              errorMsg = "This data requires a PIN Code.\n";
      }

      await CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
           async () =>
           {
               _this.HintText.Text = "";
               _this.LoginGrid.Visibility = Visibility.Visible;
               if (errorMsg != "")
               {
                   _this.HintText.Text = errorMsg + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }
               else
               {
                   _this.HintText.Text = challengeJSON.GetValue("errorMsg") + "\n" + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }

               _this.GetBalance.IsEnabled = false;
           });
    } catch (Exception e)
    {
        Debug.WriteLine(e.StackTrace);
    }
}
```

> 样本应用程序中包含 `showChallenge` 的实现。

如果凭证不正确，那么预计框架会再次调用 `HandleChallenge`。

## 提交验证问题的答案
{: #submitting-the-challenges-answer }
在从 UI 收集凭证之后，使用 `SecurityCheckChallengeHandler` 的 `ShouldSubmitChallengeAnswer()` 和 `GetChallengeAnswer()` 方法将答案发送回安全性检查。 `ShouldSubmitChallengeAnswer()` 会返回一个布尔值，指示是否应将验证问题响应发送回安全性检查。 在此示例中，`PinCodeAttempts` 预期有一个名为 `pin` 且包含提交的 PIN 码的属性：

```csharp
public override bool ShouldSubmitChallengeAnswer()
{
  JObject pinJSON = new JObject();
  pinJSON.Add("pin", pinCodeTxt.Text);
  this.challengeAnswer = pinJSON;
  return this.shouldsubmitchallenge;
}

public override JObject GetChallengeAnswer()
{
  return this.challengeAnswer;
}

```

## 取消验证问题
{: #cancelling-the-challenge }
在某些情况下（如单击 UI 中的**取消**按钮），您想要通知框架完全丢弃此验证问题。

要实现此目标，请覆盖 `ShouldCancel` 方法。


```csharp
public override bool ShouldCancel()
{
  return shouldsubmitcancel;
}
```

## 注册验证问题处理程序
{: #registering-the-challenge-handler }
为了使验证问题处理程序侦听正确的验证问题，您必须通知框架将验证问题处理程序与特定的安全性检查名称相关联。

为此，请使用安全性检查初始化验证问题处理程序，如下所述：

```csharp
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts");
```

然后，您必须**注册**验证问题处理程序实例：

```csharp
IWorklightClient client = WorklightClient.createInstance();
client.RegisterChallengeHandler(pinCodeChallengeHandler);
```

## 样本应用程序
{: #sample-application }
**PinCodeWin8** 和 **PinCodeWin10** 样本为使用 `ResourceRequest` 获取银行存款余额的 C# 应用程序。  
该方法通过 PIN 码受到保护，最多有 3 次尝试机会。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) SecurityCheckAdapters Maven 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80) Windows 8 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80) Windows 10 UWP 项目。

### 样本用法
{: #sample-usage }
请遵循样本的 README.md 文件获取指示信息。

![样本应用程序](sample-application.png)   
