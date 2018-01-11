---
layout: tutorial
title: 迁移认证和安全性概念
breadcrumb_title: 迁移认证概念
downloads:
  - name: 下载迁移样本
    url: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
weight: 3
---
## 概述
{: #overview }

在 V8.0 中，{{ site.data.keys.product_full }} 安全框架做出了一些重大修改，旨在改善和简化安全性开发和管理任务。 这些更改包含取代了 V7.1 安全性构建块：在 8.0 中，OAuth 安全性作用域和安全性检查取代了先前版本中的安全性测试、域和登录模块。

本教程旨在全程指导您完成将应用程序的安全代码迁移到 V8.0 所需的步骤。 本教程概述了将样本 {{ site.data.keys.product_adj }} V7.1 应用程序转变为具有相同安全防护能力的 V8.0 应用程序的完整过程。 V7.1 样本应用程序和已迁移的 V8.0 应用程序都可供下载。 请使用本教程开头的**下载迁移样本**链接。

本教程的[第一部分](#migrating-the-sample-application)说明如何将 V7.1 样本应用程序迁移至 V8.0。 这包括迁移资源适配器、将基于表单和基于适配器的认证域替换为安全性检查，以及迁移客户机应用程序及其验证问题处理程序。<br />
[第二部分](#migrating-other-types-of-authentication-realms)说明如何将其他类型的 V7.1 认证域迁移至 V8.0，这未在样本应用程序中演示。<br />
[第三部分](#migrating-other-v71-security-configurations)解释如何将其他 V7.1 安全配置迁移至 V8.0。 这包含应用程序级别保护、访问令牌到期以及用户和设备身份的配置。
{% comment %} 我已编辑并进行了重新排序，包括将第二部分拆分为第二部分和第三部分 - 这与原始文档中的标题级别匹配。 我将链接（也进行了编辑）移至所有第二级别标题（“部分”）。
{% endcomment %}

> **注：**在开始迁移之前，建议您阅读 [V8.0 迁移手册](../migration-cookbook)。  
>要了解有关新安全框架的基本概念，请参阅[认证和安全](../../authentication-and-security)。

## 迁移样本应用程序
{: #migrating-the-sample-application }

此迁移过程的起点是 V7.1 样本混合应用程序。 该应用程序可访问使用 V7.1 OAuth 安全模型保护的 Java 适配器。 该适配器具有两个方法：
*  `getBalance`，使用基于表单的认证域进行保护，该域实施用户名和密码登录。
*  `transferMoney`，使用基于适配器的认证域进行保护，实施基于 pin 码的用户授权。

使用本教程开头的**下载迁移样本**链接，下载 V7.1 样本应用程序的源代码以及迁移后的 V8.0 应用程序的源代码。

遵循以下步骤，将 V7.1 样本应用程序迁移至 V8.0：
*  [迁移资源适配器](#migrating-the-resource-adapter)，包括资源保护逻辑。
*  [迁移客户机应用程序](#migrating-the-client-application)。
*  通过将 V7.1 样本应用程序的认证域替换为 V8.0 安全性检查，[迁移认证域](#migrating-rm-and-adapter-based-auth-realms)。
*  在客户机端[迁移验证问题处理程序](#migrating-the-challenge-handlers)，以使用新的验证问题处理程序 API。

### 迁移资源适配器
{: #migrating-the-resource-adapter }
首先迁移资源适配器。 在 {{ site.data.keys.product }} V8.0 中，适配器是作为独立的 Maven 项目开发的，这与 V7.1 不同，后者的适配器是应用程序项目的一部分。 因此，您可以独立于客户机应用程序迁移资源适配器，以及构建和部署迁移的适配器。 对于 V8.0 客户机应用程序和 V8.0 安全性检查（在适配器中实施）也同样如此。 因此，您可以按照自己选择的顺序迁移这些工件。 本教程首先介绍如何迁移资源适配器，包括对用于 V8.0 资源保护的 OAuth 安全作用域元素的简介。

> **注：** 
> *  以下指示信息适用于迁移样本 `AccountAdapter` 资源适配器。由于在 V8.0 中不再支持实施的基于适配器的认证，因此无需迁移样本 `PinCodeAdapter`。 [替换基于 pin 码适配器的认证域](#replacing-the-pin-code-adapter-based-authentication-realm)步骤解释如何将 V7.1 pin 码适配器替换为提供类似保护的 V8.0 安全性检查。
> *  有关如何将适配器迁移至 V8.0 的指示信息，请参阅 [V8.0 迁移手册](../migration-cookbook)。

V7.1 样本中的 `AccountAdpter` 方法使用 `@OAuthSecurity` 注释进行保护，该注释定义方法的保护作用域（`UserLoginRealm` 和 `PinCodeRealm`）。 在 V8.0 中使用相同的注释，但作用域元素具有不同的意义：在 V7.1 中，作用域元素是指在 **authenticationConfig.xml** 文件中定义的安全域。 在 V8.0 中，将作用域元素映射至部署到 {{ site.data.keys.mf_server }} 的适配器中定义的安全性检查。 您可以选择保持资源保护代码（包括作用域元素名称）不变。 但是，由于在 {{ site.data.keys.product }} V8.0 中不再使用术语“域”，因此 V8.0 应用程序中的作用域元素重命名为 `UserLogin` 和 `PinCode`：

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

#### 更新用户身份检索代码
{: #updating-the-user-identity-retrieval-code }

样本资源适配器使用服务器端安全性 API 来获取已认证用户的身份。 在 V8.0 中对此 API 进行了更改，因此您需要修改适配器代码以使用更新的 API。 在迁移后的 V8.0 应用程序中，除去以下 V7.1 代码：

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

将其替换为以下代码，使用新的 V8.0 API：

```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```
在编辑适配器代码之后，可使用 Maven 或 {{ site.data.keys.mf_cli }} 构建适配器并将其部署到服务器。 有关更多信息，请参阅[构建和部署适配器](../../adapters/creating-adapters/#build-and-deploy-adapters)。

### 迁移客户机应用程序
{: #migrating-the-client-application }

接下来，迁移客户机应用程序。 有关详细的客户机应用程序迁移指示信息，请参阅 [V8.0 迁移手册](../migration-cookbook)。  本教程重点介绍安全码的迁移。 在此阶段，通过编辑应用程序的主 HTML 文件 **index.html**，在用于导入验证问题处理程序代码的行前后添加注释符号，从而排除验证问题处理程序代码：

```html 
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

稍后将在[迁移验证问题处理程序](#migrating-the-challenge-handlers)步骤中修改样本应用程序的验证问题处理程序代码。

#### 更新客户机端 API 调用
{: #updating-the-client-side-api-calls }

在客户机迁移过程中，您需要适应 V8.0 客户机端 API 的变更。 有关 {{ site.data.keys.product }} V8.0 客户机 API 变更的列表，请参阅[升级 WebView](../migrating-client-applications/cordova/#upgrading-the-webview)。
样本应用程序具有一项与安全相关的客户机 API 变更，即注销 API。 在 V8.0 中不支持 V7.1 `WL.Client.logout` 方法。 改为使用 V8.0 `WLAuthorizationManager.logout` 方法，向其传递取代 V7.1 授权域的安全性检查的名称。 样本应用程序中的**注销**按钮将使用户同时从 `UserLogin` 和 `PinCode` 安全性检查注销：

```javascript
function logout() {
    WLAuthorizationManager.logout('UserLogin').then(
        function () {
            WLAuthorizationManager.logout('PinCode').then(function () {
                $("#ResponseDiv").html("Logged out");
            }, function (error) {
                WL.Logger.debug("failure on logout from PinCode check: " +
                    JSON.stringify(error));
            });
      },
      function (error) {
          WL.Logger.debug("failure on logout from UserLogin check: " +
              JSON.stringify(error));
      });
}
```

完成客户机应用程序迁移步骤之后，构建应用程序，然后使用命令 `mfpdev app register` 向 {{ site.data.keys.mf_server }} 注册该应用程序。 在成功注册应用程序之后，可以看到该应用程序列在 {{ site.data.keys.mf_console }} 导航侧边栏的**应用程序**部分中。

### 迁移样本应用程序的认证域
{: #migrating-rm-and-adapter-based-auth-realms }

在此阶段，您已迁移 V8.0 客户机应用程序和部署的资源适配器。 但是，迁移的应用程序无法访问受保护的适配器资源。 这是因为资源适配器方法受 `UserLogin` 和 `PinCode` 作用域元素保护，而这两个作用域元素尚未映射至任何安全性检查。 因此，应用程序无法获取所需访问令牌来访问受保护的方法。 要解决此问题，必须将 V7.1 认证域替换为映射至适配器方法的保护作用域元素的 V8.0 安全性检查。

#### 替换基于用户登录表单的认证域
{: #replacing-the-user-login-form-based-authentication-realm }

要替换 V7.1 `UserLoginRealm` 基于表单的认证域，请创建 V8.0 `UserLogin` 安全性检查，它将执行与 V7.1 基于表单的认证器和定制登录模块相同的认证步骤：安全性检查会向客户机发送提问、从提问应答中收集登录凭证、验证凭证并创建用户身份。 如以下指示信息中所示，创建安全性检查并不复杂。 在创建安全性检查之后，您可以将用于验证来自 V7.1 定制登录模块的登录凭证的代码复制到新的安全性检查。

在 V8.0 中，安全性检查以适配器的形式实现。 在 {{ site.data.keys.product }} V8.0 中，Java 适配器可以提供资源以及对安全性测试打包。 但是，在此迁移过程中，您将保留迁移的 `AccountAdpter` 资源适配器，并且创建单独的适配器来打包新的安全性检查。 因此，首先创建名为 `UserLogin` 的新 Java 适配器。 有关详细的指示信息，请参阅[创建新 Java 适配器](../../adapters/creating-adapters)。

要在新的 `UserLogin` 适配器中定义 `UserLogin` 安全性检查，请将 &lt;securityCheckDefinition&gt; XML 元素添加到适配器的 **adapter.xml** 文件，如以下代码所示：

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* `name` 属性指定安全性检查的名称（“UserLogin”）。
* `class` 属性指定安全性检查实施的 Java 类（“com.sample.UserLogin”）。 该类在[下一步](#creating-the-user-login-security-check-java-class)中创建。
* `successStateExpirationSec` 属性等同于 V7.1 登录模块的 `expirationInSeconds` 属性。 它指示安全性检查成功状态的有效期（即，成功的安全性检查登录保持有效的时间长度，以秒为单位）。 V7.1 和 V8.0 属性的缺省值都为 3600 秒。 如果在 V7.1 登录模块中配置了不同的有效期，请编辑 V8.0 `successStateExpirationSec` 属性的值以设置为相同值。

本教程解释如何仅定义 `successStateExpirationSec` 属性，但您可以使用安全性检查执行更多操作。 例如，您可以实施一些高级功能，如阻止状态到期、多次登录尝试或“记住我”登录。 可以更改配置属性的缺省值、添加定制属性以及在运行时通过 {{ site.data.keys.mf_console }} 或使用 {{ site.data.keys.mf_cli }} (**mfpdev**) 来修改属性值。 有关更多信息，请参阅 [V8.0 安全性检查文档](../../authentication-and-security/creating-a-security-check/)，尤其是[配置安全性检查](../../authentication-and-security/creating-a-security-check/#security-check-configuration)章节。

##### 创建用户登录安全性检查 Java 类
{: #creating-the-user-login-security-check-java-class }

在 `UserLogin` 适配器中，创建继承了 {{ site.data.keys.product_adj }} `UserAuthenticationSecurityCheck` 抽象基类的 `UserLogin` Java 类（而 UserAuthenticationSecurityCheck 则继承了 {{ site.data.keys.product_adj }} `CredentialsValidationSecurityCheck` 抽象基类）。 接下来，覆盖 `createChallenge`、`validateCredentials` 和 `createUser` 基类方法的缺省实现。

*  `createChallenge` 方法用于创建要发送到客户机的验证问题对象（散列映射）。 可以修改此方法的实现，以包含要用于验证客户机响应的验证问题短语或其他类型的验证问题对象。 但是，对于样本应用程序而言，只需向验证问题对象添加发生错误时要显示的错误消息。
*  `validateCredentials` 方法包含认证逻辑。 将用于验证来自 V7.1 登录模块的用户名和密码的认证代码复制到该 V8.0 方法。 样本会实现基本验证逻辑，验证密码是否与用户名相同。
*  `createUser` 方法等同于 V7.1 登录模块的 `createIdentity` 方法。

以下是完整的类实现代码：

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null &&  credentials.containsKey("username") &&

		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the V7.1 login module
            if (!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;

                errorMsg = null;
                return true;
            } else {
                errorMsg = "Wrong Credentials";
            }
        } else {
            errorMsg = "Credentials not set properly";
        }
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg", errorMsg);
        return challenge;
    }

    @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
    }
}
```

有关 `UserAuthenticationSecurityCheck` 类及其实现的更多信息，请参阅[实现 UserAuthenticationSecurityCheck 类](../../authentication-and-security/user-authentication/security-check/)。


要完成更改，请使用 Maven 或 {{ site.data.keys.mf_cli }} 构建 `UserLogin` 适配器并将其部署到服务器。 有关更多信息，请参阅[构建和部署适配器](../../adapters/creating-adapters/#build-and-deploy-adapters)。 在成功部署适配器之后，可以看到该适配器列在 {{ site.data.keys.mf_console }} 导航侧边栏的**适配器**部分中。

#### 替换基于 pin 码适配器的认证域
{: #replacing-the-pin-code-adapter-based-authentication-realm }

V7.1 样本应用程序的 `PinCodeRealm` 域是通过基于适配器的认证实现的，这在 V8.0 中不再受支持。 为取代该域，需要创建新的 `PinCode` Java 适配器，并向其添加继承了 {{ site.data.keys.product_adj }} `CredentialsValidationSecurityCheck` 抽象基类的 `PinCode` Java 类。

**注：**
*  用于创建 `PinCode` 适配器的步骤类似于用于创建 `UserLogin` 适配器的步骤，如[替换基于用户登录表单的认证域](#replacing-the-user-login-form-based-authentication-realm)步骤中所述。
*  `PinCode` 安全性检查只需要验证登录凭证（pin 码），而不需要指定用户身份。 因此，该安全性检查类继承了 `CredentialsValidationSecurityCheck` 基类，而不是继承用于 `UserLogin` 安全性检查的 `UserAuthenticationSecurityCheck` 类。

要创建继承 `CredentialsValidationSecurityCheck` 基类的安全性检查，必须实现 `createChallenge` 和 `validateCredentials` 方法。

*  `createChallenge` 实现类似于 `UserLogin` 安全性检查的实现。 `PinCode` 安全性检查没有特殊信息要包含在向客户机发送的验证问题中。 因此，只需向验证问题对象添加发生错误时要显示的错误消息。

   ```java
       @Override
    protected Map<String, Object> createChallenge() {
           Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
   ```

*  `validateCredentials` 方法将验证 pin 码。 在以下示例中，验证代码由一行构成，但也可以将验证代码从 V7.1 认证适配器复制到该 `validateCredentials` 方法中。

   ```java
   @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
       if (credentials!=null &&  credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();
        if (pinCode.equals("1234")) {
               return true;
        } else {
               errorMsg = "Pin code is not valid.";
           }
       } else {
           errorMsg = "Pin code was not provided";
    }
    return false;
}
   ```

在完成 V7.1 认证域到安全性检查的迁移之后，构建适配器并将其部署到 {{ site.data.keys.mf_server }}。 有关更多信息，请参阅[构建和部署适配器](../../adapters/creating-adapters/#build-and-deploy-adapters)。

### 迁移验证问题处理程序
{: #migrating-the-challenge-handlers }

在此阶段，您已迁移样本资源适配器和客户机应用程序，并且已将 V7.1 认证域替换为 V8.0 安全性检查。 完成样本应用程序的安全性迁移仅剩迁移客户机应用程序的验证问题处理程序。 客户机应用程序使用验证问题处理程序响应安全性验证问题，并将从用户那里接收的凭证发送至安全性检查。

在[迁移客户机应用程序](#migrating-the-client-application)后，可通过注释掉应用程序主 HTML 文件 **index.html** 中的相关行来排除验证问题处理程序代码。 现在，通过除去先前添加在这些行前后的注释符号，重新添加应用程序的验证问题处理程序代码。

```html 
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
```

然后，继续将验证问题处理程序代码迁移至 V8.0，如以下指示信息中所述。 有关 V8.0 验证问题处理程序 API 的更多信息，请参阅[快速查看 {{ site.data.keys.product }} 8.0 中的验证问题处理程序]({{ site.baseurl }}/blog/2016/06/22/challenge-handlers/)以及 V8.0 [JavaScript 客户机端 API 参考](../../api/client-side-api/javascript/client/)中的 `WL.Client` 和 `WL.Client.AbstractChallengeHandler` 文档。

首先迁移用户登录验证问题处理程序 (`userLoginChallengeHandler`)，它会在 V8.0 中执行与 V7.1 中相同的功能：该验证问题处理程序将在收到验证问题时做出响应，向用户提供登录表单，然后向 {{ site.data.keys.mf_server }} 发送用户名和密码。 但是，由于 V8.0 中的客户机验证问题处理程序 API 有所不同，比 V7.1 中的对应功能更简单，因此必须进行以下更改：

*  将用于创建验证问题处理程序的代码替换为以下代码，该代码将调用 V8.0 `WL.Client.createSecurityCheckChallengeHandler` 方法：

   ```javascript
   var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
   ```
   
   `WL.Client.createSecurityCheckChallengeHandler` 将创建验证问题处理程序以处理来自 {{ site.data.keys.product_adj }} 安全性检查的验证问题。 V8.0 还引入了 `WL.Client.createGatewayChallengeHandler` 方法，可处理来自第三方网关的验证问题，该方法在 V8.0 中称为网关验证问题处理程序。 将 V7.1 应用程序迁移至 V8.0 时，针对 `WL.Client` `createWLChallengeHandler` 或 `createChallengeHandler` 方法的调用将替换为调用与期望的验证问题源匹配的 V8.0 `WL.Client` 验证问题处理程序创建方法。 例如，如果您的资源受到用于将定制登录表单发送到客户机的 DataPower 逆向代理的保护，那么应使用 `createGatewayChallengeHandler` 创建网关验证问题处理程序来处理网关验证问题。

*  除去对验证问题处理程序 `isCustomResponse` 方法的调用。 在 V8.0 中，不再需要该方法来处理安全性验证问题。
*  将 `userLoginChallengeHandler.handleChallenge` 方法的实现替换为 V8.0 验证问题处理程序 `handleChallenge`、`handleSuccess` 和 `handleFailure` 方法的实现。 V7.1 通过单一验证问题处理程序方法检查响应，以确定是包含验证问题还是返回成功或错误消息。 而 V8.0 针对每种类型验证问题处理程序的响应提供单独的方法，安全框架将确定响应类型并调用相应的方法。
*  除去对 `submitSuccess` 方法的调用。 V8.0 安全框架将隐式处理成功响应。
*  将针对 `submitFailure` 方法的调用替换为调用 V8.0 `cancel` 验证问题处理程序方法。
*  将针对 `submitLoginForm` 方法的调用替换为调用 V8.0 `submitChallengeAnswer` 验证问题处理程序方法：

   ```javascript
   userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
   ```
   
在应用这些更改之后验证问题处理程序的完整代码如下所示：
   
```javascript
function createUserLoginChallengeHandler() {
    var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    userLoginChallengeHandler.handleChallenge = function(challenge) {
        showLoginDiv();
        var statusMsg = (challenge.errorMsg !== null) ? challenge.errorMsg : "";
        $("#loginErrorMessage").html(statusMsg);
    };

    userLoginChallengeHandler.handleSuccess = function(data) {
        hideLoginDiv();
    };

    userLoginChallengeHandler.handleFailure = function(error) {
        if (error.failure !== null) {
            alert(error.failure);
        } else {
            alert("Failed to login.");
        }
    };

    $('#AuthSubmitButton').bind('click', function () {
        var username = $('#AuthUsername').val();
        var password = $('#AuthPassword').val();
        if (username === "" || password === "") {
            alert("Username and password are required");
            return;
        }

        userLoginChallengeHandler.submitChallengeAnswer(
            {'username':username, 'password':password});});

    $('#AuthCancelButton').bind('click', function () {
        userLoginChallengeHandler.cancel();
        hideLoginDiv();
    });

    return userLoginChallengeHandler;
 }
```

pin 码验证问题处理程序 (`pinCodeChallengeHandler`) 的迁移类似于用户登录验证问题处理程序的迁移。 因此，请遵循 `userLoginChallengeHandler` 迁移指示信息，并针对 pin 码验证问题处理程序进行必要的调整。 请参阅 V8.0 样本应用程序中已迁移的 pin 码验证问题处理程序的完整代码。

您现在已将 V7.0 样本应用程序迁移至 V8.0。 重新构建应用程序，将其部署至 {{ site.data.keys.mf_server }}，进行测试，验证是否按预期那样保护对适配器方法资源的访问。

## 迁移其他类型的认证域
{: #migrating-other-types-of-authentication-realms }

截至目前，您已了解如何迁移 V7.1 样本应用程序中基于表单的域和基于适配器的域。 但是，V7.1 应用程序可能包含其他类型的认证域，包括属于应用程序安全测试一部分的域（`mobileSecurityTest`、`webSecurityTest` 或 `customSecurityTest`）。 以下部分概述了如何将这些其他类型的认证域迁移至 V8.0。

*  [应用程序真实性](#application-authenticity)
*  [LTPA 域](#ltpa-realm)
*  [设备配置](#device-provisioning)
*  [反跨站请求伪造 (anti-XSRF) 域
](#anti-cross-site-request-forgery-anti-xsrf-realm)
*  [直接更新域](#direct-update-realm)
*  [远程禁用域](#remote-disable-realm)
*  [定制认证器和登录模块](#custom-authenticators-and-login-modules)

### 应用程序真实性
{: #application-authenticity }

在 {{ site.data.keys.product }} V8.0 中，应用程序真实性验证作为预定义的安全性检查 `appAuthenticity` 提供。 缺省情况下，在应用程序运行时向 {{ site.data.keys.mf_server }} 注册（在应用程序实例首次尝试连接到服务器时发生）期间运行此安全性检查。 但是，与任何 {{ site.data.keys.product_adj }} 安全性检查一样，您也可以在定制安全性作用域中包含此预定义检查。 有关更多信息，请参阅[应用程序真实性](../../authentication-and-security/application-authenticity/)。

### LTPA 域
{: #ltpa-realm }

要替换 V7.1 LTPA 域，请使用 {{ site.data.keys.product }} V8.0 预定义的基于 LTPA 的 SSO 安全性检查 `LtpaBasedSSO`。 有关该安全性检查的更多信息，请参阅[基于 LTPA 的单点登录 (SSO) 安全性检查](../../authentication-and-security/ltpa-security-check/)。

### 设备配置
{: #device-provisioning }

V7.1 设备配置域 (`wl_deviceAutoProvisioningRealm`) 不需要迁移至 V8.0。 {{ site.data.keys.product }} V8.0 客户机迁移过程将替换 V7.1 设备配置。 在 V8.0 中，客户机（应用程序实例）在首次尝试访问服务器时会向 {{ site.data.keys.mf_server }} 进行注册。 在注册过程中，客户机将提供用于自身身份认证的公用密钥。 此保护机制始终处于启用状态，因此对于安全性检查而言无需替换 V7.1 设备配置域。

### 反跨站请求伪造 (anti-XSRF) 域
{: #anti-cross-site-request-forgery-anti-xsrf-realm }

V7.1 反跨站点请求伪造 (anti-XSRF) 域 (`wl_antiXSRFRealm`) 不需要迁移至 V8.0。 在 V7.1.0 中，认证上下文存储在 HTTP 会话中，并且由跨站点请求中通过浏览器发送的会话 cookie 来识别。 此版本中的 anti-XSRF 域用于通过从客户机发送到服务器的额外头来保护 cookie 传输免遭 XSRF 攻击。 在 {{ site.data.keys.product }} V8.0 中，安全上下文不再与 HTTP 会话关联并且不由会话 cookie 识别。 而是使用授权头中传递的 OAuth 2.0 访问令牌来完成授权。 由于未在跨站点请求中通过浏览器发送授权头，因此无需防御 XSRF 攻击。

### 直接更新域
{: #direct-update-realm }

V7.1 远程禁用域 (`wl_directUpdateRealm`) 不需要迁移至 V8.0。 “直接更新”功能的 {{ site.data.keys.product }} V8.0 实现不需要相关的安全性检查，这与 V7.1 中的域需求不同。 

**注：**用于使用“直接更新”功能交付更新的 V8.0 步骤与 V7.1 过程不同。 有关更多信息，请参阅[迁移“直接更新”](../migrating-client-applications/cordova/#migrating-direct-update)。

### 远程禁用域
{: #remote-disable-realm }

V7.1 远程禁用域 (`wl_remoteDisableRealm`) 不需要迁移至 V8.0。 “远程禁用”功能的 {{ site.data.keys.product }} V8.0 实现不需要相关的安全性检查，这与 V7.1 中的域需求不同。 有关 V8.0 中远程禁用功能的信息，请参阅[远程禁用应用程序对受保护资源的访问](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources)。

### 定制认证器和登录模块
{: #custom-authenticators-and-login-modules }

要替换定制 V7.1 认证器和登录模块，请根据[创建用户登录安全性检查 Java 类](#creating-the-user-login-security-check-java-class)样本应用程序迁移步骤中的指示信息来创建新的安全性检查。 安全性检查可以继承 `UserAuthenticationSecurityCheck` 或 `CredentialsValidationSecurityCheck` {{ site.data.keys.product }} V8.0 基类。 虽然无法直接迁移 V7.1 认证器类或登录模块类，但可以将相关代码片段复制到安全性检查中。 这包括用于生成安全性验证问题、从验证问题响应中抽取登录凭证或验证凭证等的代码。

## 迁移其他 V7.1 安全配置
{: #migrating-other-v71-security-configurations }

*  [应用程序安全性测试](#the-application-security-test)
*  [访问令牌到期](#access-token-expiration)
*  [用户身份域](#user-identity-realm)
*  [设备身份域](#device-identity-realm)

### 应用程序安全性测试
{: #the-application-security-test }

在 V7.1 中，应用程序描述符 (**application-descriptor.xml**) 除了定义适用于特定应用程序资源的保护之外，还可以定义适用于整个应用程序环境的应用程序安全性测试。 当应用程序描述符未显式定义安全性测试（如在 V7.1 样本应用程序中）时适用的缺省 V7.1 移动应用程序安全性测试为 `mobileSecurityTest`。 该安全性测试由 V8.0 (anti-XSRF) 中不相关的域或者不需要显式迁移（直接更新和远程禁用）的域组成。 因此，针对样本应用程序的应用程序环境保护，无需任何特定的迁移。

如果 V7.1 应用程序具有应用程序安全性测试，其中包含迁移到 V8.0 后仍希望在应用程序级别保留的检查（域），那么可以配置强制性应用程序作用域。 在 V8.0 中，对受保护资源的访问需要传递映射到强制性应用程序作用域的安全性检查以及映射到资源的保护作用域的检查。 要在 V8.0 {{ site.data.keys.mf_console }} 中定义强制性应用程序作用域，请从导航侧边栏的**应用程序**部分选择您的应用程序，然后选择**安全性**选项卡。 在**强制性应用程序作用域**下，选择**添加到作用域**。 您可以在应用程序作用域中包含任何预定义或定制的安全性检查或者映射的作用域元素。 有关 V8.0 中强制性应用程序作用域的配置的更多信息，请参阅[强制性应用程序作用域](../..//authentication-and-security/#mandatory-application-scope)。

### 访问令牌到期
{: #access-token-expiration }

V7.1 和 V8.0 中的最长访问令牌有效期的缺省值为 3600 秒。 因此，如果您的 V7.1 应用程序依赖该缺省值，则不需要任何迁移工作即可在 V8.0 中应用该值。 但是，如果 V7.1 应用程序描述符文件 (**application-descriptor.xml**) 为 `accessTokenExpiration` 属性设置了不同的值，那么您可以为等同的 V8.0 属性 (`maxTokenExpiration`) 配置相同的值。 您可以在 {{ site.data.keys.mf_console }} 中执行此操作：转至应用程序的**安全性**选项卡，然后编辑**令牌配置**部分中**最大令牌有效期（秒）**字段的缺省值。 如果选择应用程序的**配置文件**控制台选项卡，那么可以看到 `maxTokenExpiration` 属性的值已设置为您配置的值。

### 用户身份域
{: #user-identity-realm }

在 V7.1 中，可以将认证域配置为用户身份域。 使用 {{ site.data.keys.product_adj }} OAuth 安全模型的认证流程的应用程序凭借应用程序描述符文件中的 `userIdentityRealms` 属性来定义用户身份域的有序列表。 在使用 {{ site.data.keys.product_adj }} 典型（非 OAuth）安全模型的认证流程的应用程序中，属性 `isInternalUserId` 指示域是否为用户身份域。 在 V8.0 中，不再需要这些用户身份配置。 在 V8.0 中，活动用户的身份由调用 `setActiveUser` 方法的上一次安全性检查来设置。 如果安全性检查继承 `UserAuthenticationSecurityCheck` 抽象基类，例如样本 V8.0 `UserLogin` 检查，那么可以依靠该基类来设置活动用户的身份。


### 设备身份域
{: #device-identity-realm }

V7.1 应用程序必须定义设备身份域。 在 V8.0 中，不再需要该域。 在 V8.0 中，设备身份与安全性检查无关。 在客户机注册流程中会注册设备信息，即在客户机首次尝试访问受保护的资源时进行。

## 后续工作
{: #whats-next }

本教程仅介绍了将使用先前版本的 {{ site.data.keys.product }} 开发的现有应用程序的安全性工件迁移至 V8.0 所需的基本步骤。 要充分利用 V8.0 安全性功能，请参阅 [V8.0 安全框架文档](../../authentication-and-security/)。

