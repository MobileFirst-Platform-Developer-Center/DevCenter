---
layout: tutorial
title: 设置认证
breadcrumb_title: 设置认证
relevantTo: [android,ios,windows,javascript]
weight: 5
downloads:
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80
  - name: 下载 iOS Swift 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80
  - name: 下载 Android 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80
  - name: 下载 Win8 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80
  - name: 下载 Win10 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80
  - name: 下载 Web 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80
  - name: 下载 SecurityCheck Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可通过多项安全性检查保护资源。在此类场景中，{{ site.data.keys.mf_server }} 会同时将所有相关验证问题发送到应用程序。  

一项安全性检查也可依赖于另一项安全性检查。因此，重要的是能够控制何时发送验证问题。  
例如，本教程描述具有用户名和密码保护的两个资源的应用程序，其中第二个资源还需要额外的 PIN 码。

**先决条件：**在继续前先阅读 [CredentialsValidationSecurityCheck](../credentials-validation) 和 [UserAuthenticationSecurityCheck](../user-authentication) 教程。

#### 跳转至：
{: #jump-to }
* [引用安全性检查](#referencing-a-security-check)
* [状态机](#state-machine)
* [Authorize 方法](#the-authorize-method)
* [验证问题处理程序](#challenge-handlers)
* [样本应用程序](#sample-applications)

## 引用安全性检查
{: #referencing-a-security-check }
创建两项安全性检查：`StepUpPinCode` 和 `StepUpUserLogin`。它们的初始实施与[凭证验证](../credentials-validation/security-check/)和[用户认证](../user-authentication/security-check/)教程中描述的实施相同。

在此示例中，`StepUpPinCode` **依赖于 ** `StepUpUserLogin`。仅在成功登录到 `StepUpUserLogin` 之后要求用户输入 PIN 码。出于此目的，`StepUpPinCode` 必须能够**引用** `StepUpUserLogin` 类。  

{{ site.data.keys.product_adj }} 框架提供注释以插入引用。  
在 `StepUpPinCode` 类中的类级别添加：

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要信息：**需要在相同适配器内绑定这两种安全性检查实施。
为解析此引用，该框架会查找具有相应类的安全性检查，并将其引用插入到从属安全性检查。  
如果存在相同类的多项安全性检查，那么注释具有可选的 `name` 参数，可用于指定所引用检查的唯一名称。

## 状态机
{: #state-machine }
扩展 `CredentialsValidationSecurityCheck`（包含 `StepUpPinCode` 和 `StepUpUserLogin`）的所有类均继承一个简单状态机。在任何指定时刻，安全性检查都可处于以下一种状态：

- `STATE_ATTEMPTING`：已发送验证问题并且安全性检查正在等待客户机响应。在此状态期间将保持尝试计数。
- `STATE_SUCCESS`：已成功验证凭证。
- `STATE_BLOCKED`：已到达最大尝试次数并且检查处于已锁定状态。

可使用继承的 `getState()` 方法获取当前状态。

在 `StepUpUserLogin` 中，添加 convenience 方法以检查用户当前是否已登录。
本教程中稍后将使用此方法。

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## Authorize 方法
{: #the-authorize-method }
`SecurityCheck` 接口定义名为 `authorize` 的方法。此方法负责实施安全性检查的主逻辑，例如，发送验证问题或验证请求。  
`StepUpPinCode` 扩展的类 `CredentialsValidationSecurityCheck` 已包含此方法的实施。但是，在此情况下，目标是在开始 `authorize` 方法的缺省行为之前检查 `StepUpUserLogin` 的状态。

要执行此操作，请**覆盖** `authorize` 方法：

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

此实施检查 `StepUpUserLogin` 引用的当前状态：

* 如果状态为 `STATE_SUCCESS`（用户已登录），那么安全性检查的正常流程将继续。
* 如果 `StepUpUserLogin` 为任何其他状态，那么不执行任何操作：不发送验证问题，既不成功也不失败。

假定 `StepUpPinCode` 和 `StepUpUserLogin` **共同**保护资源，那么此流程会确保在提示输入次要凭证（PIN 码）之前用户已登录。即使已激活这两项安全性检查，客户机也从不会同时收到两个验证问题。

或者，如果**仅** `StepUpPinCode` 保护资源（该框架将仅激活此安全性检查），那么您可以更改 `authorize` 实现以手动触发 `StepUpUserLogin`：

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        //If StepUpUserLogin is successful, continue the normal processing of StepUpPinCode
        super.authorize(scope, credentials, request, response);
    } else {
        //In any other case, process StepUpUserLogin instead.
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## 检索当前用户
{: #retrieve-current-user }
在 `StepUpPinCode` 安全性检查中，主要了解当前用户的标识，从而可在某些数据库中查找此用户的 PIN 码。

在 `StepUpUserLogin` 安全性检查中，添加以下方法以从**授权上下文**获取当前用户：

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

在 `StepUpPinCode` 中，然后可使用 `userLogin.getUser()` 方法从 `StepUpUserLogin` 安全性检查获取当前用户，并针对此特定用户检查有效的 PIN 码：

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    //Get the correct PIN code from the database
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## 验证问题处理程序
{: #challenge-handlers }
在客户机端，无特殊 API 来处理多个步骤。每个验证问题处理程序都会处理自己的验证问题。在此示例中，必须注册两个单独的验证问题处理程序：一个用于处理来自 `StepUpUserLogin` 的验证问题，一个用于处理来自 `StepUpPincode` 的验证问题。

<img alt="设置样本应用程序" src="sample_application.png" style="float:right"/>
## 样本应用程序
{: #sample-applications }
### 安全性检查
{: #security-check }
`StepUpUserLogin` 和 `StepUpPinCode` 安全性检查可用于 StepUp Maven 项目下的 SecurityChecks 项目。
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)安全性检查 Maven 项目。

### 应用程序
{: #applications }
样本应用程序可用于 iOS (Swift)、Android、Windows 8.1/10、Cordova 和 Web。

* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80) Cordova 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80) iOS Swift 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80) Android 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80) Windows 8.1 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80) Windows 10 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80) Web 应用程序项目。

### 样本用法
{: #sample-usage }
请遵循样本的 README.md 文件获取指示信息。
