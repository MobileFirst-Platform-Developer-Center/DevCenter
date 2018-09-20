---
layout: tutorial
title: 注册
breadcrumb_title: Enrollment
relevantTo: [android,ios,windows,javascript]
weight: 7
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
该样本演示了定制注册流程和递增授权。 在此一次性注册流程中，用户需要输入其用户名和密码，还需要定义 PIN 码。  

**先决条件：**确保阅读 [ExternalizableSecurityCheck](../externalizable-security-check/) 和[递增](../step-up/)教程。

#### 跳转至：
{: #jump-to }
* [应用程序流](#application-flow)
* [将数据存储在持久性属性中](#storing-data-in-persistent-attributes)
* [安全性检查](#security-checks)
* [样本应用程序](#sample-applications)

## 应用程序流
{: #application-flow }
* 在应用程序初次启动时（注册前），会显示具有以下两个按钮的 UI：**获取公共数据**和**注册**。
* 在用户点击**注册**按钮开始注册时，会使用登录表单进行提示，然后请求该用户设置 PIN 码。
* 在用户成功注册后，UI 包含四个按钮：**获取公共数据**、**获取余额**、**获取交易**和**注销**。 用户无需输入 PIN 码，便可访问全部四个按钮。
* 再次启动应用程序时（注册后），UI 仍包含所有四个按钮。 然而，当用户单击**获取交易*** 按钮时，会要求该用户输入 PIN 码。

尝试输入 PIN 码三次失败后，会提示该用户使用用户名和密码重新认证和重置 PIN 码。

## 将数据存储在持久性属性中
{: #storing-data-in-persistent-attributes }
您可以选择将受保护数据保存在 `PersistentAttributes` 对象中，此对象是已注册客户机的定制属性的容器。 可以从安全性检查类或从适配器资源类访问该对象。

在提供的样本应用程序中，在适配器资源类中使用 `PersistentAttributes` 对象来存储 PIN 码：

* **setPinCode** 资源可添加 **pinCode** 属性，并调用 `AdapterSecurityContext.storeClientRegistrationData()` 方法来存储更改。

  ```java
  @POST
  @OAuthSecurity(scope = "setPinCode")
  @Path("/setPinCode/{pinCode}")
  
  public Response setPinCode(@PathParam("pinCode") String pinCode){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		clientData.getProtectedAttributes().put("pinCode", pinCode);
  		adapterSecurityContext.storeClientRegistrationData(clientData);
  		return Response.ok().build();
  }
  ```
  
  此处，`users` 具有一个名为 `EnrollmentUserLogin` 的键，其本身包含 `AuthenticatedUser` 对象。

* **unenroll** 资源可删除 **pinCode** 属性，并调用 `AdapterSecurityContext.storeClientRegistrationData()` 方法来存储更改。

  ```java
  @DELETE
  @OAuthSecurity(scope = "unenroll")
  @Path("/unenroll")
  
  public Response unenroll(){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		if (clientData.getProtectedAttributes().get("pinCode") != null){
  			clientData.getProtectedAttributes().delete("pinCode");
  			adapterSecurityContext.storeClientRegistrationData(clientData);
  		}
  		return Response.ok().build();
  }
  ```

## 安全性检查
{: #security-checks }
注册样本包含三项安全性检查：

### EnrollmentUserLogin
{: #enrollmentuserlogin }
`EnrollmentUserLogin` 安全性检查保护 **setPinCode** 资源，以便只有已认证的用户才能够设置 PIN 码。 此安全性检查意味着快速到期，并且仅在“初次体验”期间进行。 它与[实现 UserAuthenticationSecurityCheck](../user-authentication/security-check) 教程中所解释的 `UserLogin` 安全性检查相同， 但额外的 `isLoggedIn` 和 `getRegisteredUser` 方法除外。  
如果安全性检查状态等于 SUCCESS，`isLoggedIn` 方法会返回 `true`，否则将返回 `false`。  
`getRegisteredUser` 方法会返回已认证的用户。

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```
```java
public AuthenticatedUser getRegisteredUser() {
    return registrationContext.getRegisteredUser();
}
```

### EnrollmentPinCode
{: #enrollmentpincode }
`EnrollmentPinCode` 安全性检查可保护**获取交易**资源，与[实现 CredentialsValidationSecurityCheck](../credentials-validation/security-check) 教程中所解释的 `PinCodeAttempts` 安全性检查相似（一些更改除外）。

在本教程的示例中，`EnrollmentPinCode` **取决于** `EnrollmentUserLogin`。 成功登录到 `EnrollmentUserLogin` 后，只会要求用户输入 PIN 码。

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

在应用程序**初次**启动且用户成功注册时，用户必须能够在无需输入其刚刚设置的 PIN 码的情况下访问**获取交易**资源。 为此，`authorize` 方法使用 `EnrollmentUserLogin.isLoggedIn` 方法来检查用户是否登录。 这意味着只要 `EnrollmentUserLogin` 不到期，用户便能够访问**获取交易**。

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    }
}
```

本教程针对用户尝试三次后输入 PIN 码失败的情况而设计，以便在提示用户使用用户名和密码并重置 PIN 码进行认证之前，先删除 **pinCode** 属性。

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    } else {
        super.authorize(scope, credentials, request, response);
        if (getState().equals(STATE_BLOCKED)){
            attributes.delete("pinCode");
        }
    }
}
```

`validateCredentials` 方法与在 `PinCodeAttempts` 安全性检查中相同，只是此处会将凭证与存储的 **pinCode** 属性进行比较。

```java
@Override

protected boolean validateCredentials(Map<String, Object> credentials) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if(credentials!=null &&  credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals(attributes.get("pinCode"))){
            errorMsg = null;
            return true;
        }
        else {
            errorMsg = "The pin code is not valid. Hint: " + attributes.get("pinCode");
        }
    }
    else{
        errorMsg = "The pin code was not provided.";
    }
    //In any other case, credentials are not valid
    return false;
}
```

### IsEnrolled
{: #isenrolled }
`IsEnrolled` 安全性检查可保护：

* **getBalance** 资源，以便只有注册用户才能看到余额。
* **transactions** 资源，以便只有注册用户才能获取交易。
* **unenroll** 资源，以便只有在先前设置了 **pinCode** 的情况下才能将其删除。

#### 创建安全性检查
{: #creating-the-security-check }
[创建 Java 适配器](../../adapters/creating-adapters/)，并添加名为 `IsEnrolled` 且可扩展 `ExternalizableSecurityCheck` 的 Java 类。

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

#### IsEnrolledConfig 配置类
{: #the-isenrolledconfig-configuration-class }
创建可扩展 `ExternalizableSecurityCheckConfig` 的 `IsEnrolledConfig` 配置类：

```java
public class IsEnrolledConfig extends ExternalizableSecurityCheckConfig {

    public int successStateExpirationSec;

    public IsEnrolledConfig(Properties properties) {
        super(properties);
        successStateExpirationSec = getIntProperty("expirationInSec", properties, 8000);
    }
}
```

将 `createConfiguration` 方法添加到 `IsEnrolled` 类中：

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    @Override
    public SecurityCheckConfiguration createConfiguration(Properties properties) {
        return new IsEnrolledConfig(properties);
    }
}
```
#### initStateDurations 方法
{: #the-initstatedurations-method }
将 SUCCESS 状态的持续时间设置为 `successStateExpirationSec`：

```java
@Override
protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((IsEnrolledConfig) config).successStateExpirationSec);
}
```

#### authorize 方法
{: #the-authorize-method }
代码样本仅检查用户是否注册，并相应地返回成功或失败：

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```

* 如果存在 `pinCode` 属性：

 * 请使用 `setState` 方法将状态设置为 SUCCESS。
 * 请使用 `addSuccess` 方法将成功添加到响应对象中。

* 如果 `pinCode` 属性不存在：

 * 请使用 `setState` 方法将状态设置为 EXPIRED。
 * 请使用 `addFailure` 方法将失败添加到响应对象中。

<br/>
`IsEnrolled` 安全性检查**取决于** `EnrollmentUserLogin`：

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

通过添加以下代码来设置活动用户：

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
   
然后，`transactions` 资源可获取当前的 `AuthenticatedUser` 对象来呈现显示名称：

```java
@GET
@Produces(MediaType.TEXT_PLAIN)
@OAuthSecurity(scope = "transactions")
@Path("/transactions")

public String getTransactions(){
  AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
  return "Transactions for " + currentUser.getDisplayName() + ":\n{'date':'12/01/2016', 'amount':'19938.80'}";
}
```
    
> 有关 `securityContext` 的更多信息，请参阅 Java 适配器教程中的[安全性 API](../../adapters/java-adapters/#security-api) 部分。

通过添加以下内容，将注册用户添加到响应对象中：

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), getName(), "user", userLogin.getRegisteredUser());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
    
在样本代码中，`IsEnrolled` 验证问题处理程序的 `handleSuccess` 方法使用用户对象来呈现显示名称。

<img alt="注册样本应用程序" src="sample_application.png" style="float:right"/>
## 样本应用程序
{: #sample-applications }

### 安全性检查
{: #security-check }
注册 Maven 项目下的 SecurityChecks 项目中提供了 `EnrollmentUserLogin`、`EnrollmentPinCode` 和 `IsEnrolled` 安全性检查。
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)安全性检查 Maven 项目。

### 应用程序
{: #applications }
样本应用程序可用于 iOS (Swift)、Android、Cordova 和 Web。

* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80) Cordova 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80) iOS Swift 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80) Android 项目。
* [单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80) Web 应用程序项目。

### 样本用法
{: #sample-usage }
请遵循样本的 README.md 文件获取指示信息。
