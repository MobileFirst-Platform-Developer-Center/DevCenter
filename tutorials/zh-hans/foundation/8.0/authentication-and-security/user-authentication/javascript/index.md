---
layout: tutorial
title: 在 JavaScript（Cordova、Web）应用程序中实施验证问题处理程序
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download PreemptiveLogin Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80
  - name: Download PreemptiveLogin Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80
  - name: Download RememberMe Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80
  - name: Download RememberMe Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
**先决条件：**确保阅读 **CredentialsValidationSecurityCheck** 的[验证问题处理程序实施](../../credentials-validation/javascript)教程。

验证问题处理程序将演示一些其他功能 (API)，例如，优先的 `login`、`logout` 和 `obtainAccessToken`。

## 登录
{: #login }
在此示例中，`UserLogin` 期望使用名为 `username` 和 `password` 的 *key:value*。 它还可选择接受布尔值 `rememberMe` 键，这告知安全性检查在较长时间段内记住此用户。 在样本应用程序中，通过来自登录表单复选框中的布尔值收集此项。

```js
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
```

您可能还想要在不接收任何验证问题的情况下登录用户。 例如，将登录屏幕显示为应用程序的第一个屏幕，或者在注销或登录失败后显示登录屏幕。 我们将这些场景称为**优先登录**。

如果没有要回答的验证问题，那么无法调用 `submitChallengeAnswer` API。 对于这些场景，{{ site.data.keys.product }} SDK 包含 `login` API：

```js
WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
    function () {
        WL.Logger.debug("login onSuccess");
    },
    function (response) {
        WL.Logger.debug("login onFailure: " + JSON.stringify(response));
    });
```

如果凭证错误，那么安全性检查将发送回**验证问题**。

开发者负责根据应用程序的需求了解，相对于 `submitChallengeAnswer` 何时要使用 `login`。 实现此目标的一种方式是定义布尔标志，例如，`isChallenged`，并在 `handleChallenge` 到达时将其设置为 `true`，或者在任何其他情况下（失败、成功、初始化等）将其设置为 `false`。

在用户单击**登录**按钮时，您可以动态选择要使用的 API：

```js
if (isChallenged){
    userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
} else {
    WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
//...
    );
}
```

> **注：**
>`WLAuthorizationManager` `login()` API 具有自己的 `onSuccess` 和 `onFailure` 方法，同时**也**会调用相关验证问题处理程序的 `handleSuccess` 或 `handleFailure` 方法。

## 获取访问令牌
{: #obtaining-an-access-token }
因为此安全性检查支持 **RememberMe** 功能（作为 `rememberMe` 布尔值键），所以它将用于在应用程序启动时检查客户机当前是否已登录。

{{ site.data.keys.product }} SDK 提供 `obtainAccessToken` API 以要求服务器提供有效令牌：

```js
WLAuthorizationManager.obtainAccessToken(userLoginChallengeHandler.securityCheckName).then(
    function (accessToken) {
        WL.Logger.debug("obtainAccessToken onSuccess");
        showProtectedDiv();
    },
    function (response) {
        WL.Logger.debug("obtainAccessToken onFailure: " + JSON.stringify(response));
        showLoginDiv();
});
```
> **注：**
> `WLAuthorizationManager` `obtainAccessToken()` API 具有自己的 `onSuccess` 和 `onFailure` 方法，同时**也**会调用相关验证问题处理程序的 `handleSuccess` 或 `handleFailure` 方法。

如果客户机已登录或者处于*已记住*状态，那么 API 会触发成功。 如果客户机未登录，那么安全性检查将发送回验证问题。

`obtainAccessToken` API 接受**作用域**。 作用域可以是**安全性检查**的名称。

> 在[授权概念](../../)教程中了解有关**作用域**的更多信息。

## 检索已认证的用户
{: #retrieving-the-authenticated-user }
验证问题处理程序 `handleSuccess` 方法接收 `data` 作为参数。
如果安全性检查设置 `AuthenticatedUser`，那么此对象包含用户的属性。 您可以使用 `handleSuccess` 来保存当前用户：

```js
userLoginChallengeHandler.handleSuccess = function(data) {
    WL.Logger.debug("handleSuccess");
    isChallenged = false;
    document.getElementById ("rememberMe").checked = false;
    document.getElementById('username').value = "";
    document.getElementById('password').value = "";
    document.getElementById("helloUser").innerHTML = "Hello, " + data.user.displayName;
    showProtectedDiv();
}
```

此处，`data` 具有一个名为 `user` 的键，其自身包含表示 `AuthenticatedUser` 的 `JSONObject`：

```json
{
  "user": {
    "id": "john",
    "displayName": "john",
    "authenticatedAt": 1455803338008,
    "authenticatedBy": "UserLogin"
  }
}
```

## 注销
{: #logout }
{{ site.data.keys.product }} SDK 还提供 `logout` API 以从特定安全性检查注销：

```js
WLAuthorizationManager.logout(securityCheckName).then(
    function () {
        WL.Logger.debug("logout onSuccess");
        location.reload();
    },
    function (response) {
        WL.Logger.debug("logout onFailure: " + JSON.stringify(response));
    });
```

## 样本应用程序
{: #sample-applications }
两个样本与此教程相关联：

- **PreemptiveLogin**：使用优先 `login` API 且始终从登录屏幕开始的应用程序。
- **RememberMe**：具有*记住我*复选框的应用程序。 在下一次打开应用程序时，用户可绕过登录屏幕。

两个样本均使用来自 **SecurityCheckAdapters** 适配器 Maven 项目的相同 `UserLogin` 安全性检查。

- [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) SecurityCheckAdapters Maven 项目。  
- [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80) RememberMe Cordova 项目。  
- [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80) PreemptiveLogin Cordova 项目。
- [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80) RememberMe Web 项目。
- [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80) PreemptiveLogin Web 项目。

### 样本用法
{: #sample-usage }
请遵循样本的 README.md 文件获取指示信息。
应用程序的用户名/密码必须匹配，例如，“john”/“john”。

![样本应用程序](sample-application.png)
