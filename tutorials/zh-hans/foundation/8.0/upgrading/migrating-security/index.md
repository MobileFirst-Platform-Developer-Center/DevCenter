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
在 V8.0 中，针对 {{ site.data.keys.product_full }}    安全框架做出了一些重大改动，旨在改善和简化安全性开发和管理任务。特别是，已更改了安全性构建块 - 在 8.0 中，OAuth 安全性作用域和安全性检查取代了先前版本中的安全性测试、域和登录模块。

本指南旨在指导您完成迁移应用程序安全代码所需的步骤。我们将使用 7.1 样本应用程序作为起点，并描述从 7.1 样本应用程序迁移到 8.0 应用程序（具有相同的安全保护）的完整过程。下面附带了 7.1 样本应用程序和迁移的应用程序。

下文中描述的迁移步骤包括：
*	将资源适配器迁移到 8.0 并保留对资源的保护
*	迁移客户机应用程序
*	创建安全性检查以取代 7.1 应用程序的认证域
*	修改客户端的验证问题处理程序以使用新的验证问题处理程序 API。

在本教程的[第二部分](#migrating-other-types-of-authentication-realms)中，我们将解决样本应用程序的迁移过程中未说明的其他迁移问题：
*	除了样本中说明的基于表单的认证和基于适配器的认证外，还迁移其他类型的授权域。
*	访问令牌到期时间
*	应用程序级别保护（应用程序安全性测试）
*	在 8.0 的更简单安全模型中，不再需要 7.1 中的某些安全配置设置，例如，用户身份域和设备身份域

> 在开始迁移之前，建议您通读[迁移手册](../migration-cookbook)。另请参阅[认证和安全性](../../authentication-and-security)教程，以了解新安全框架的基本概念。
## 样本应用程序
{: #the-sample-application }
我们的起点是 7.1 样本混合应用程序。该应用程序可访问使用 OAuth 保护的 Java 适配器。该适配器有两个方法 - 由基于表单的认证域（使用用户名和密码登录）保护的 `getBalance` 方法以及由基于适配器的认证域（需要用户提供 pin 码）保护的 `transferMoney` 方法。7.1 样本应用程序的源代码和迁移到 8.0 后的样本应用程序的源代码均可供[下载](https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample)。

## 迁移资源适配器
{: #migrating-the-resource-adapter }
我们将开始资源适配器的迁移过程。在 {{ site.data.keys.product }}    8.0 中，适配器是作为独立 Maven 项目开发的，这与 7.1（适配器是项目的一部分）中不同。这意味着我们可以迁移、构建和部署资源适配器，这些过程独立于客户机应用程序。对于客户机应用程序本身和安全性检查（实际上也作为适配器进行部署）也同样如此。这使我们可以按自己选择的顺序自由迁移这些部件。在本教程中，我们将首先迁移资源适配器，以便于我们介绍用于保护资源的 OAuth 安全性作用域元素。

请注意，我们将要迁移资源适配器 `AccountAdapter`，但不需要迁移适配器 `PinCodeAdapter`，因为后者用于基于适配器的认证，而在 8.0 中不再支持基于适配器的认证。在接下来的某个步骤中，我们会将此适配器替换为 {{ site.data.keys.product }}    8.0 安全性检查。

> 有关将适配器迁移到 8.0 的指示信息，请参阅[迁移手册](../migration-cookbook)。

7.1 样本中的 `AccountAdpter` 方法已受到 `@OAuthSecurity` 注释的保护。在 V8.0 中使用了相同的注释。唯一的差别在于，在 7.1 中，作用域元素 `UserLoginRealm` 和 `PinCodeRealm` 表示 authenticationConfig.xml 文件中定义的安全域。而另一方面，在 8.0 中，作用域元素映射到服务器上部署的安全性检查。我们可以将代码保持不变，并使用相同的作用域元素名称，但将作用域元素重命名为 `UserLogin` 和 `PinCode`，因为在 MFP 8.0 中不再使用术语“域”：

```java
@OAuthSecurity(scope="UserLogin")

@OAuthSecurity(scope="PinCode")
```

### 使用新的 API 获取用户身份
{: #use-the-new-api-for-getting-the-user-identity }
资源适配器使用服务器端安全性 API 来获取已认证用户的身份。在 8.0 中已更改了此 API，因此，我们需要修复此 API。将以下 7.1 代码：

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

替换为 8.0 中的新 API：


```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```

使用 Maven 或 {{ site.data.keys.mf_cli }}   ，[构建适配器并将其部署到服务器](../../adapters/creating-adapters/#build-and-deploy-adapters)。

## 迁移客户机应用程序
{: #migrating-the-client-application }
接下来，我们将迁移客户机应用程序。请参阅迁移手册，以获取客户机应用程序迁移指示信息。请暂时注释掉验证问题处理程序的代码。我们稍后将修复验证问题处理程序。在应用程序的主 HTML 文件 index.html 中，在导入验证问题处理程序代码的行周围放置一条注释。

```html
      <!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

### 切换到用于注销的新客户端 API
{: #change-to-the-new-client-api-for-logout }
作为客户机迁移的一部分，您需要处理 MobileFirst 8.0 客户端 API 中的更改。要获取客户端 API 更改的列表，请参阅[升级 WebView](../migrating-client-applications/cordova/#upgrading-the-webview)。
在样本应用程序中，有一项与安全性相关的客户端 API 更改 - 用于注销的 API。在 8.0 中不支持 7.1 的 `WL.Client.logout` 方法。改为使用 `WLAuthorizationManager.logout`，并传递用于替换 7.1 中的授权域的安全性检查的名称。
样本应用程序中的“注销”按钮将从 `UserLogin` 安全性检查和 `PinCode` 安全性检查中注销用户：

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

完成应用程序迁移步骤后，构建应用程序，并在 {{ site.data.keys.mf_server }}    上使用 `mfpdev app register` 命令注册该应用程序。现在，您应该会看到 {{ site.data.keys.mf_console }}    中列出了该应用程序。

## 迁移基于表单的认证域
{: #migrating-the-form-based-authentication-realm }
在此阶段，我们已迁移并部署了客户机应用程序和资源适配器。但如果尝试立即运行该应用程序，该应用程序将无法访问资源。这是因为该应用程序期望提供一个访问令牌（其中包含资源适配器方法所需的作用域元素（“UserLogin”或“PinCode”）），但由于尚未创建安全性检查，所以该应用程序无法获取访问令牌，因此无权访问受保护的资源。

现在，我们将创建名为“UserLogin”的 8.0 安全性检查，用于代替 7.1 的基于表单的认证域“UserLoginRealm”。此安全性检查执行的认证步骤与基于表单的认证器和定制登录模块先前实施的认证步骤相同 - 向客户机发送验证问题、收集来自验证问题应答的凭证、验证凭证并创建用户身份。如下所示，创建安全性检查非常简单，只需将用于验证来自 7.1 定制登录模块的凭证的代码复制到新的安全性检查即可。

安全性检查将作为适配器来实现，因此我们从创建名为 `UserLogin` 的[新 Java 适配器](../../adapters/creating-adapters)开始。

创建 Java 适配器时，缺省模板假定适配器将提供资源。该适配器可用于提供资源和将安全性测试打包，但在此情况下我们仅将新适配器用于安全性检查。因此，我们将除去缺省资源实现：删除 UserLoginApplication.java 和 UserLoginResource.java 文件。同时从 adapter.xml 中除去 <JAXRSApplicationClass> 元素。
在 Java 适配器的 adapter.xml 文件中，添加一个名为 `securityCheckDefinition` 的 XML 元素。例如：

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* name 属性是安全性检查的名称。
* class 属性指定安全性检查的实现 Java 类。我们将在下一步中创建此类。
* 属性 successStateExpirationSec 等同于 7.1 登录模块的 expirationInSeconds 属性。它表示成功登录此安全性检查保持的时间间隔（以秒计）。在 7.1 和 8.0 中，这些属性的缺省值均为 3600 秒。如果使用其他值配置 7.1 登录模块，那么应在此处放置相同的值。

鉴于本教程，我们仅定义 `successStateExpirationSec` 属性。实际上，您可以通过[安全性检查配置](../../authentication-and-security/creating-a-security-check/#security-check-configuration)完成更多操作。特别是，可以配置安全性检查以使用一些高级功能（例如，已阻止状态的到期时间、多次尝试和“记住我”）。您可以添加定制配置属性，并从 MFP 控制台中修改运行时中的配置属性。

### 创建安全性检查 Java 类
{: #creating-the-security-check-java-class }
创建用于扩展 `UserAuthenticationSecurityCheck` 的名为 `UserLogin` 的 Java 类，并将其添加到适配器中。接下来，我们将覆盖以下三个方法的缺省实现：`createChallenge`、`validateCredentials` 和 `createUser`。

* 在 `validateCredentials` 方法中放置认证逻辑。从 7.1 登录模块中复制认证逻辑代码（用于验证用户名和密码的代码），并将其放在此处。在此情况下，该逻辑非常简单 - 仅仅是测试密码与用户名是否相同。
* 在 `createChallenge` 方法中，创建要发送到客户机的验证问题消息（散列映射）。通常，安全性检查可在此处放置一个验证问题短语或其他类型的验证问题对象，以用于验证客户机的响应。此安全性检查不需要验证问题短语，因此只需在验证问题消息中放入错误消息（前提是已发现错误）即可。
* `createUser` 方法等同于 7.1 登录模块中的 `createIdentity` 方法。

下面是完整的类。

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null && credentials.containsKey("username") &&
		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the 7.1 login module
            if (!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
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

使用 Maven 或 {{ site.data.keys.mf_cli }}   ，[构建适配器并将其部署到服务器](../../adapters/creating-adapters/#build-and-deploy-adapters)。在 {{ site.data.keys.mf_console }}    中，您应该会在适配器列表中看到新适配器 UserLogin

## 迁移 pin 码域
{: #migrating-the-pin-code-realm }
样本中的 pin 码域是使用基于适配器的认证实现的，但在 V8.0 中不再支持基于适配器的认证。我们会将此域替换为新的安全性检查。

创建名为 `PinCode` 的新 Java 适配器。创建用于扩展 `CredentialsValidationSecurityCheck` 的名为 `PinCode` 的 Java 类，并将其添加到适配器中。请注意，我们这次使用 `CredentialsValidationSecurityCheck` 作为基类，而不是使用用于 UserLogin 安全性检查的 `UserAuthenticationSecurityCheck`。这是因为 pin 码安全性检查只需验证凭证（pin 码），而不指定用户身份。

要创建用于扩展 `CredentialsValidationSecurityCheck` 的安全性检查，需要实现以下两个方法：`createChallenge` 和 `validateCredentials`。

与 `UserLogin` 安全性检查类似，`PinCode` 安全性检查不会将任何特殊信息作为验证问题的一部分发送到客户机。`createChallenge` 方法仅在验证问题消息中放入错误消息（前提是存在错误消息）。

```java
    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
```

`validateCredentials` 方法将验证 pin 码。在此情况下，验证代码包含一行代码，但通常可将 7.1 认证适配器中的验证代码复制到 `validateCredentials` 方法中。

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if (credentials!=null && credentials.containsKey("pin")){
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

[构建适配器并将其部署到服务器](../../adapters/creating-adapters/#build-and-deploy-adapters)。

## 迁移验证问题处理程序
{: #migrating-the-challenge-handlers }
此时，我们已迁移客户机应用程序，并使用资源适配器和安全性检查来保护资源。唯一缺少的部分是客户端的验证问题处理程序，客户机可通过该处理程序来响应验证问题并将凭证发送到安全性检查。请记住，迁移客户机应用程序时，已经注释掉包含验证问题处理程序的行。现在可以取消注释这些行，然后将验证问题处理程序迁移到 8.0。

我们将从用户登录验证问题处理程序开始。在 8.0 和 7.1 中，此验证问题处理程序执行相同的功能 - 负责在收到验证问题时向用户显示登录表单，并向服务器发送用户名和密码。但是，验证问题处理程序的客户端 API 已经过更改和简化，因此需要进行如下更改：

* 将用于创建验证问题处理程序的调用替换为：

```javascript
var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
```

方法 `createSecurityCheckChallengeHandler` 将创建验证问题处理程序以处理由 {{ site.data.keys.product_adj }}    安全性检查发送的验证问题。在大部分情况下，应使用此方法代替 7.1 客户端 API 的 `createWLChallengeHandler` 方法或 `createChallengeHandler` 方法。唯一的例外是用于处理第三方网关发送的验证问题的验证问题处理程序。此类型的验证问题处理程序（在 8.0 中称为网关验证问题处理程序）是使用 `WL.Client.createGatewayChallengeHandler() 方法创建的。例如，如果资源受到用于将定制登录表单发送到客户机的逆向代理（如 DataPower）的保护，那么应使用网关验证问题处理程序来处理验证问题。有关网关验证问题处理程序的更多信息，请参阅[验证问题处理程序概览](https://mobilefirstplatform.ibmcloud.com/blog/2016/06/22/challenge-handlers/)一文。

* 除去 `isCustomResponse` 方法。安全性检查验证问题处理程序不再需要此方法。
* 将 `handleChallenge` 方法替换为验证问题处理程序必须实现的三个方法 - `handleChallenge()`、`handleSuccess()` 和 `handleFailure`。在 8.0 中，验证问题处理程序不需要再检查响应以了解响应是否携带验证问题（成功或出错）。框架将处理这些任务并调用相应的方法。
* 除去对 `submitSuccess` 的调用。框架将自动处理成功响应。
* 将对 `submitFailure` 的调用替换为 `userLoginChallengeHandler.cancel`。
* 将对 `submitLoginForm` 的调用替换为：

```javascript
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
```

应用这些更改后的验证问题处理程序的完整代码如下所示。

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

pin 码验证问题处理程序的迁移与用户登录验证问题处理程序的迁移非常类似，因此在此处不作详细介绍。请参阅附带的 8.0 样本中已迁移的验证问题处理程序的代码。应用程序迁移到此已完成。现在，您可以重新构建应用程序、将其部署到服务器、测试其能否运行并测试是否按预期那样保护对资源的访问。

## 迁移其他类型的认证域
{: #migrating-other-types-of-authentication-realms }
在上面的部分中，我们描述了迁移基于表单的认证域和基于适配器的认证域的过程。7.1 应用程序可能包含其他类型的域，其中包括已显式添加到应用程序安全性测试中的域，或缺省情况下包含在 `mobileSecurityTest` 或 `webSecurityTest` 中的域。请参阅有关将其他类型的域迁移到 8.0 的以下准则。

### 应用程序真实性
{: #application-authenticity }
在 8.0 中，应用程序真实性是作为预定义的安全性检查提供。缺省情况下，在应用程序运行时向 {{ site.data.keys.mf_server }}    注册（在应用程序实例首次尝试连接到服务器时发生）期间运行此安全性检查。但是，与任何 {{ site.data.keys.product_adj }}    安全性检查一样，您也可以在定制安全性作用域中包含此预定义检查。

### LTPA 域
{: #ltpa-realm }
使用预定义的 8.0 安全性检查 `LtpaBasedSSO`。有关更多信息，请参阅[使用 IBM DataPower 保护 {{ site.data.keys.product_adj }}    8.0 应用程序流量]({{ site.baseurl }}/blog/2016/06/17/datapower-integration/)教程。

### 设备配置
{: #device-provisioning }
8.0 中的客户机注册过程取代了 7.1 中的设备配置过程。在 {{ site.data.keys.product_adj }}    8.0 中，客户机（应用程序实例）在首次尝试访问服务器时会向 {{ site.data.keys.mf_server }}    进行注册。在注册过程中，客户机将提供用于自身身份认证的公用密钥。此保护机制始终处于启用状态，无需将设备配置域迁移到 8.0。

### 反跨站请求伪造 (anti-XSRF) 域
{: #anti-cross-site-request-forgery-anti-xsrf-realm }
在 8.0 的基于 OAuth 的安全框架中，不再支持 Anti-XSRF。

### 直接更新域
{: #direct-update-realm }
无需将直接更新域迁移到 8.0。虽然在 {{ site.data.keys.product_adj }}    8.0 中支持“直接更新”功能，但无需对它执行安全性检查，如先前版本中所需的直接更新域。但请注意，使用“直接更新”功能来交付更新的步骤已发生更改。有关更多信息，请参阅[迁移直接更新](../migrating-client-applications/cordova/#migrating-direct-update)文档主题。

### 远程禁用域
{: #remote-disable-realm }
无需将远程禁用域迁移到 8.0。{{ site.data.keys.product_adj }}    8.0 中的“远程禁用”功能无需执行安全性检查。

### 定制鉴别符和登录模块
{: #custom-authenticators-and-login-modules }
如上所述，创建新的安全性检查。使用基类 `UserAuthenticationSecurityCheck` 或 `CredentialsValidationSecurityCheck`。虽然无法直接迁移鉴别符类或登录模块类，但可以将相关代码片段复制到安全性检查中，例如，用于生成验证问题的代码，用于从响应中抽取凭证的代码以及用于验证凭证的代码。

## 迁移 7.1 的其他安全配置
{: #migrating-additional-security-configurations-of-71 }
### 应用程序安全性测试
{: #the-application-security-test }
除了用于保护资源适配器的 OAuth 作用域外，7.1 样本应用程序还受到应用程序级别安全性测试的保护。此样本在 application-descriptor.xml 文件中未定义应用程序安全性测试，因此使用缺省安全性测试来获得保护。7.1 中的移动应用程序的缺省安全性测试由 8.0 (anti-XSRF) 中不相关的域或者不需要显式迁移（直接更新、远程禁用）的域组成。因此，在此情况下，无需迁移应用程序安全性测试。

如果应用程序具有应用程序安全性测试，其中包含在迁移到 8.0 后仍希望在应用程序级别保留的检查（域），那么可以为此应用程序配置强制性作用域。当应用程序尝试访问受保护的资源时，除了映射到用于保护资源的作用域的检查外，它还必须通过那些映射到强制性作用域的安全性检查。

要为应用程序定义强制性作用域，请在 {{ site.data.keys.mf_console }}    中选择应用程序版本，选择“安全性”选项卡，然后单击“添加到作用域”按钮。您可以在作用域中包含任何预定义或定制的安全性检查或者映射的作用域元素。

### 访问令牌到期时间
{: #access-token-expiration }
检查 application-descriptor.xml 文件中“访问令牌到期时间”属性的值。V7.1 和 V8.0 中的缺省值均为 3600 秒，因此，除非您的应用程序在应用程序描述符文件中定义了其他值，否则无需进行任何更改。要在 8.0 中设置该到期时间值，请在 {{ site.data.keys.mf_console }}    中浏览至“应用程序版本”页面，选择“安全性”选项卡，并在“最大令牌到期周期”字段中输入该值。

### 用户身份域
{: #user-identity-realm }
在 MobileFirst 7.1 中，认证域可配置为用户身份域。使用 OAuth 认证流程的应用程序在应用程序描述符文件中使用 `userIdentityRealms` 属性来定义用户身份域的有序列表。在使用经典 Worklight 认证流程（非 OAuth）的应用程序中，属性 `isInternalUserId` 指示该域是否为用户身份域。在 {{ site.data.keys.product_adj }}    8.0 中不再需要这些配置。在 {{ site.data.keys.product_adj }}    8.0 中，活动的用户身份是由调用 `setActiveUser` 方法的最后一次安全性检查来设置。如果安全性检查扩展了抽象基类 `UserAuthenticationSecurityCheck`（如样本应用程序中的 UserLogin 安全性检查），那么此基类将负责设置活动用户。

### 设备身份域
{: #device-identity-realm }
在 7.1 应用程序中，必须有一个域定义为设备身份域。在 8.0 中无需迁移此配置。在 {{ site.data.keys.product_adj }}    8.0 中，设备身份与安全性检查无关。在客户机注册流程中注册设备信息，即在客户机首次尝试访问受保护的资源时发生。

## 总结
{: #summary }
在本教程中，我们仅介绍了从先前版本迁移现有应用程序的安全工件所需的基本步骤。我们鼓励您[了解有关新的安全框架的更多信息](../../authentication-and-security/)，并利用本文中未介绍的其他功能。
