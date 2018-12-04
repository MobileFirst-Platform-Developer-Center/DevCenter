---
layout: tutorial
title: 实现 UserAuthenticationSecurityCheck 类
breadcrumb_title: Security Check
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Download Security Checks
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
此抽象类扩展 `CredentialsValidationSecurityCheck`，且基于其而构建以适合最常见的简单用户认证用例。 除了验证凭证，它还创建了可从框架的各个部分访问的**用户身份**，从而使您能够标识当前用户。 （可选）`UserAuthenticationSecurityCheck` 还提供**记住我**功能。

本教程使用的安全性检查示例会请求用户名和密码，并使用用户名来表示已认证的用户。

**先决条件：**确保阅读 [CredentialsValidationSecurityCheck](../../credentials-validation/) 教程。

#### 跳转至：
{: #jump-to }
* [创建安全性检查](#creating-the-security-check)
* [创建验证问题](#creating-the-challenge)
* [验证用户凭证](#validating-the-user-credentials)
* [创建 AuthenticatedUser 对象](#creating-the-authenticateduser-object)
* [添加 RememberMe 功能](#adding-rememberme-functionality)
* [配置安全性检查](#configuring-the-security-check)
* [样本安全性检查](#sample-security-check)

## 创建安全性检查
{: #creating-the-security-check }
[创建 Java 适配器](../../../adapters/creating-adapters)，并添加名为 `UserLogin` 且可扩展 `UserAuthenticationSecurityCheck` 的 Java 类。

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

    @Override
    protected AuthenticatedUser createUser() {
        return null;
    }

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }
}
```

## 创建验证问题
{: #creating-the-challenge }
验证问题与[实现 CredentialsValidationSecurityCheck](../../credentials-validation/security-check/) 中描述的内容完全相同。

```java
@Override
    protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

## 验证用户凭证
{: #validating-the-user-credentials }
在客户机发送验证问题答案时，此答案会作为 `Map` 传递至 `validateCredentials`。 使用此方法来实施您的逻辑。 如果凭证是有效的，那么该方法将返回 `true`。

在此示例中，在 `username` 和 `password` 相同时，凭证被认为是“有效”的：

```java
@Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
            return true;
        }
        else {
            errorMsg = "Wrong Credentials";
        }
    }
    else{
        errorMsg = "Credentials not set properly";
    }
    return false;
}
```

## 创建 AuthenticatedUser 对象
{: #creating-the-authenticateduser-object }
`UserAuthenticationSecurityCheck` 类在持久数据中存储当前客户机（用户、设备和应用程序）的表示，使您能够在代码的各个部分中检索当前用户，例如，验证问题处理程序或适配器。
通过类 `AuthenticatedUser` 的实例来表示用户。 其构造方法采用 `id`、`displayName` 和 `securityCheckName` 参数。

此示例针对 `id` 和 `displayName` 参数使用 `username`。

1. 首先，修改 `validateCredentials` 方法以保存 `username` 自变量：

   ```java
   private String userId, displayName;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;
                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "The credentials are not set properly.";
        }
        return false;
   }
   ```

2. 然后，覆盖 `createUser` 方法以返回 `AuthenticatedUser` 的新实例：

   ```java
   @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
   }
   ```

您可以使用 `this.getName()` 来获取当前安全性检查名称。

在成功的 `validateCredentials` 之后，`UserAuthenticationSecurityCheck` 会调用 `createUser()` 实现。

### 在 AuthenticatedUser 中存储属性
{: #storing-attributes-in-the-authenticateduser }
`AuthenticatedUser` 具有一个替代构造方法：

```java
AuthenticatedUser(String id, String displayName, String securityCheckName, Map<String, Object> attributes);
```

此构造方法添加要使用用户表示存储的定制属性的 `Map`。 映射可用于存储其他信息，例如，个人档案图片、Web 站点等。此信息可供客户机端（验证问题处理程序）和资源（使用自省数据）访问。

> **注：**
>属性 `Map` 必须仅包含 Java 库中绑定的类型/类对象（例如，`String`、`int` 和 `Map` 等），而**不能**包含定制类。

## 添加 RememberMe 功能
{: #adding-rememberme-functionality }
缺省情况下，`UserAuthenticationSecurityCheck` 使用 `successStateExpirationSec` 属性来确定成功状态的持续时间。 此属性继承自 `CredentialsValidationSecurityCheck`。

如果想要允许用户保持登录的时间超过 `successStateExpirationSec` 值，那么 `UserAuthenticationSecurityCheck` 可添加此功能。

`UserAuthenticationSecurityCheck` 会添加一个名为 `rememberMeDurationSec` 的属性，其缺省值为 `0`：缺省情况下，将记住用户 **0 秒**，这意味着缺省情况下禁用此功能。 将该值更改为对您的应用程序有意义的数字（一天、一周、一个月……）。

您还可以通过覆盖 `rememberCreatedUser()` 方法来管理该功能，此方法缺省情况下返回 `true`，表示缺省情况下激活此功能（前提是更改了持续时间属性）。

在此示例中，客户通过发送 `boolean` 值作为所提交凭证的一部分来决定启用/禁用 **RememberMe** 功能。

1. 首先，修改 `validateCredentials` 方法以保存 `rememberMe` 选择：

   ```java
   private String userId, displayName;
   private boolean rememberMe = false;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;

                //Optional RememberMe
                if(credentials.containsKey("rememberMe") ){
                    rememberMe = Boolean.valueOf(credentials.get("rememberMe").toString());
                }

                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "Credentials not set properly";
        }
        return false;
   }
   ```

2. 然后，覆盖 `rememberCreatedUser()` 方法：

   ```java
   @Override
   protected boolean rememberCreatedUser() {
        return rememberMe;
   }
   ```

## 配置安全性检查
{: #configuring-the-security-check }
在 **adapter.xml** 文件中，添加 `<securityCheckDefinition>` 元素：

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed."/>
  <property name="blockedStateExpirationSec" defaultValue="10" description="How long before the client can try again (seconds)."/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)."/>
  <property name="rememberMeDurationSec" defaultValue="120" description="How long is the user remembered by the RememberMe feature (seconds)."/>
</securityCheckDefinition>
```
如前所述，`UserAuthenticationSecurityCheck` 继承所有 `CredentialsValidationSecurityCheck` 属性，例如，`blockedStateExpirationSec` 和 `successStateExpirationSec` 等。

此外，您还可以配置 `rememberMeDurationSec` 属性。

## 样本安全性检查
{: #sample-security-check }
[下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)安全性检查 Maven 项目。

Maven 项目包含 `UserAuthenticationSecurityCheck` 的实现。
