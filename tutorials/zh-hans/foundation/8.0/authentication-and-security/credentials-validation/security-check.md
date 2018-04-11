---
layout: tutorial
title: 实现 CredentialsValidationSecurityCheck 类
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
此抽象类可扩展 `ExternalizableSecurityCheck`，并实现其大多数方法来简化使用过程。 以下两种方法为必需方法：`validateCredentials` 和 `createChallenge`。  
`CredentialsValidationSecurityCheck` 类用于简单流以验证任意凭证，以便授权访问资源。 同时还提供一项内置功能，用于在进行一定次数的尝试后阻止访问。

本教程使用硬编码 PIN 码示例来保护资源，并给予用户 3 次尝试机会（此后将阻止客户机应用程序实例 60 秒）。

**先决条件：**确保阅读[授权概念](../../)和[创建安全性检查](../../creating-a-security-check)教程。

#### 跳转至：
{: #jump-to }
* [创建安全性检查](#creating-the-security-check)
* [创建验证问题](#creating-the-challenge)
* [验证用户凭证](#validating-the-user-credentials)
* [配置安全性检查](#configuring-the-security-check)
* [样本安全性检查](#sample-security-check)

## 创建安全性检查
{: #creating-the-security-check }
[创建 Java 适配器](../../../adapters/creating-adapters)，并添加名为 `PinCodeAttempts` 且可扩展 `CredentialsValidationSecurityCheck` 的 Java 类。

```java
public class PinCodeAttempts extends CredentialsValidationSecurityCheck {

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
在触发安全性检查时，会将验证问题发送给客户机。 返回 `null` 会创建空的验证问题，在某些情况下这可能已足够。  
您可以选择使用验证问题返回数据，如要显示的错误消息，或可由客户机使用的任何其他数据。

例如，`PinCodeAttempts` 会发送预定义的错误消息以及剩余尝试次数。

```java
@Override
    protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

> 样本应用程序中包含 `errorMsg` 的实现。

`getRemainingAttempts()` 从 `CredentialsValidationSecurityCheck` 继承而来。

## 验证用户凭证
{: #validating-the-user-credentials }
在客户机发送验证问题的答案时，此答案会作为 `Map` 传递至 `validateCredentials`。 如果凭证有效，此方法应实施您的逻辑并返回 `true`。

```java
@Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null &&  credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals("1234")){
            return true;
        }
        else {
            errorMsg = "The pin code is not valid.";
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

### 配置类
{: #configuration-class }
您还可以使用 adapter.xml 文件和 {{ site.data.keys.mf_console }} 来配置有效的 PIN 码。

创建可扩展 `CredentialsValidationSecurityCheckConfig` 的新 Java 类。 重要的是要扩展与父安全性检查类匹配的类，以便继承缺省配置。

```java
public class PinCodeConfig extends CredentialsValidationSecurityCheckConfig {

    public String pinCode;

    public PinCodeConfig(Properties properties) {
        super(properties);
        pinCode = getStringProperty("pinCode", properties, "1234");
    }

}
```

此类中唯一需要的方法是可处理 `Properties` 实例的构造方法。 `get[Type]Property` 方法可用于从 adapter.xml 文件检索特定的属性。 如果找不到任何值，那么第三个参数会定义缺省值 (`1234`)。

您还可以使用 `addMessage` 方法，在此构造方法中添加错误处理：

```java
public PinCodeConfig(Properties properties) {
    //Make sure to load the parent properties
    super(properties);

    //Load the pinCode property
    pinCode = getStringProperty("pinCode", properties, "1234");

    //Check that the PIN code is at least 4 characters long. Triggers an error.
    if(pinCode.length() < 4) {
        addMessage(errors,"pinCode","pinCode needs to be at least 4 characters");
    }

    //Check that the PIN code is numeric. Triggers warning.
    try {
        int i = Integer.parseInt(pinCode);
    }
    catch(NumberFormatException nfe) {
        addMessage(warnings,"pinCode","PIN code contains non-numeric characters");
    }
}
```

在主类 (`PinCodeAttempts`) 中，添加能够装入配置的以下两种方法：

```java
@Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
    return new PinCodeConfig(properties);
}
@Override
protected PinCodeConfig getConfiguration() {
    return (PinCodeConfig) super.getConfiguration();
}
```

您现在可以使用 `getConfiguration().pinCode` 方法来检索缺省 PIN 码。  

您可以修改 `validateCredentials` 方法来使用配置中的 PIN 码，而不使用硬编码值。

```java
@Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null &&  credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(getConfiguration().pinCode)){
            return true;
        }
        else {
            errorMsg = "Pin code is not valid. Hint: " + getConfiguration().pinCode;
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

## 配置安全性检查
{: #configuring-the-security-check }
在 adapter.xml 中，添加 `<securityCheckDefinition>` 元素：

```xml
<securityCheckDefinition name="PinCodeAttempts" class="com.sample.PinCodeAttempts">
  <property name="pinCode" defaultValue="1234" description="The valid PIN code"/>
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed"/>
  <property name="blockedStateExpirationSec" defaultValue="60" description="How long before the client can try again (seconds)"/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)"/>
</securityCheckDefinition>
```

`name` 属性必须是安全性检查的名称。 将 `class` 参数设置为先前创建的类。

`securityCheckDefinition` 可以包含零个或多个 `property` 元素。 `pinCode` 属性是 `PinCodeConfig` 配置类中定义的属性。 其他属性从 `CredentialsValidationSecurityCheckConfig` 配置类继承而来。

缺省情况下，如果您未在 adapter.xml 文件中指定这些属性，那么将会接收由 `CredentialsValidationSecurityCheckConfig` 设置的缺省值：

```java
public CredentialsValidationSecurityCheckConfig(Properties properties) {
    super(properties);
    maxAttempts = getIntProperty("maxAttempts", properties, 1);
    attemptingStateExpirationSec = getIntProperty("attemptingStateExpirationSec", properties, 120);
    successStateExpirationSec = getIntProperty("successStateExpirationSec", properties, 3600);
    blockedStateExpirationSec = getIntProperty("blockedStateExpirationSec", properties, 0);
}
```
`CredentialsValidationSecurityCheckConfig` 类可定义以下属性：



- `maxAttempts`：在达到 *failure* 之前允许的尝试次数。
- `attemptingStateExpirationSec`：客户机必须提供有效凭证并统计尝试次数的时间间隔（秒）。
- `successStateExpirationSec`：保持成功登录的时间间隔（秒）。
- `blockedStateExpirationSec`：达到 `maxAttempts` 后阻止客户机的时间间隔（秒）。

请注意，`blockedStateExpirationSec` 的缺省值将设置为 `0`：如果客户机发送无效凭证，它可以“在 0 秒后”重试。 这意味着在缺省情况下，将禁用“尝试”功能。


## 样本安全性检查
{: #sample-security-check }
[下载](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)安全性检查 Maven 项目。

Maven 项目包含 CredentialsValidationSecurityCheck 的实现。
