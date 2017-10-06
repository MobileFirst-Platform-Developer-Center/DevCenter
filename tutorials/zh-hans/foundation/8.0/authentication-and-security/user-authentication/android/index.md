---
layout: tutorial
title: 在 Android 应用程序中实施验证问题处理程序
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: 下载 PreemptiveLogin 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80
  - name: 下载 RememberMe 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80
  - name: 下载 SecurityCheck Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
**先决条件：**确保阅读 **CredentialsValidationSecurityCheck** [验证问题处理程序实施](../../credentials-validation/android)教程。

验证问题处理程序教程演示一些其他功能 (API)，例如，优先的 `login`、`logout` 和 `obtainAccessToken`。

## 登录
{: #login }
在此示例中，`UserLogin` 期望使用名为 `username` 和 `password` 的 *key:value*。它还可选择接受布尔值 `rememberMe` 键，这告知安全性检查在较长时间段内记住此用户。 在样本应用程序中，使用来自登录表单复选框中的布尔值收集此项。

`credentials` 自变量为包含 `username`、`password` 和 `rememberMe` 的 `JSONObject`：

```java
submitChallengeAnswer(credentials);
```

您可能还想要在不接收任何验证问题的情况下登录用户。 例如，您可以将登录屏幕显示为应用程序的第一个屏幕，或者在注销或登录失败后显示登录屏幕。 这些场景被称为**优先登录**。

如果没有要回答的验证问题，那么无法调用 `submitChallengeAnswer` API。 对于这些场景，{{ site.data.keys.product }} SDK 包含 `login` API：

```java
WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Login Preemptive Success");

    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Login Preemptive Failure");
    }
});
```

如果凭证错误，那么安全性检查将发送回**验证问题**。

开发者负责根据应用程序的需求了解，相对于 `submitChallengeAnswer` 何时要使用 `login`。 实现此目标的一种方式是定义布尔标志，例如，`isChallenged`，并在 `handleChallenge` 到达时将其设置为 `true`，或者在任何其他情况下（失败、成功、初始化等）将其设置为 `false`。

在用户单击**登录**按钮时，您可以动态选择要使用的 API：

```java
public void login(JSONObject credentials){
    if(isChallenged){
        submitChallengeAnswer(credentials);
    }
    else{
        WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
//...
        });
    }
}
```

> **注：**
>`WLAuthorizationManager` `login()` API 具有自己的 `onSuccess` 和 `onFailure` 方法，同时**也**会调用相关验证问题处理程序的 `handleSuccess` 或 `handleFailure` 方法。

## 获取访问令牌
{: #obtaining-an-access-token }
因为此安全性检查支持 **RememberMe** 功能（作为 `rememberMe` 布尔值键），所以它将用于在应用程序启动时检查客户机当前是否已登录。

{{ site.data.keys.product }} SDK 提供 `obtainAccessToken` API 以要求服务器提供有效令牌：

```java
WLAuthorizationManager.getInstance().obtainAccessToken(scope, new WLAccessTokenListener() {
    @Override
    public void onSuccess(AccessToken accessToken) {
        Log.d(securityCheckName, "auto login success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "auto login failure");
    }
});
```

> **注：**
>`WLAuthorizationManager` `obtainAccessToken()` API 具有自己的 `onSuccess` 和 `onFailure` 方法，同时**也**会调用相关验证问题处理程序的 `handleSuccess` 或 `handleFailure` 方法。

如果客户机已登录或者处于*已记住*状态，那么 API 会触发成功。 如果客户机未登录，那么安全性检查将发送回验证问题。

`obtainAccessToken` API 接受**作用域**。 作用域可以是**安全性检查**的名称。

> 在[授权概念](../../)教程中了解有关**作用域**的更多信息

## 检索已认证的用户
{: #retrieving-the-authenticated-user }
验证问题处理程序 `handleSuccess` 方法获取 `JSONObject identity` 作为参数。
如果安全性检查设置 `AuthenticatedUser`，那么此对象包含用户的属性。 您可以使用 `handleSuccess` 来保存当前用户：

```java
@Override
public void handleSuccess(JSONObject identity) {
    super.handleSuccess(identity);
    isChallenged = false;
    try {
        //Save the current user
        SharedPreferences preferences = context.getSharedPreferences(Constants.PREFERENCES_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(Constants.PREFERENCES_KEY_USER, identity.getJSONObject("user").toString());
        editor.commit();
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

此处，`identity` 具有一个名为 `user` 的键，其自身包含表示 `AuthenticatedUser` 的 `JSONObject`：

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

```java
WLAuthorizationManager.getInstance().logout(securityCheckName, new WLLogoutResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Logout Success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Logout Failure");
    }
});
```

## 样本应用程序
{: #sample-applications }
两个样本与此教程相关联：

- **PreemptiveLoginAndroid**：使用优先 `login` API 且始终从登录屏幕开始的应用程序。
- **RememberMeAndroid**：具有*记住我*复选框的应用程序。 在下一次打开应用程序时，用户可绕过登录屏幕。

两个样本均使用来自 **SecurityCheckAdapters** 适配器 Maven 项目的相同 `UserLogin` 安全性检查。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) SecurityCheckAdapters Maven 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80) Remember Me 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80) Preemptive Login 项目。

### 样本用法
{: sample-usage }
请遵循样本的 README.md 文件获取指示信息。  
应用程序的用户名/密码必须匹配，例如，“john”/“john”。

![样本应用程序](sample-application.png)
