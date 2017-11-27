---
layout: tutorial
title: 创建安全性检查
breadcrumb_title: 创建安全性检查
relevantTo: [android,ios,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

安全性检查构成了 {{ site.data.keys.product_adj }} 安全框架的基本服务器端构建块。 安全性检查是实施特定授权逻辑的服务器端实体，如获取和验证客户机凭证。 可通过向资源分配一个映射到零项或多项安全性检查的作用域来保护资源。 安全框架可确保仅授权传递保护作用域的所有安全性检查的客户机访问资源。 可使用安全性检查来授权访问 {{ site.data.keys.mf_server }} 上托管的资源和外部资源服务器上的资源。

适配器可以是*资源*适配器（意味着它提供发送到客户机的资源和内容）或 *SecurityCheck* 适配器，或者同时为这**两者**。

> <b>注：</b>在适配器内实施安全性检查时，{{ site.data.keys.product_adj }} 安全框架和适配器 API 是独立的，不能混用。 因此，您无法在安全性检查代码中使用适配器 API（如 `AdpatersAPI` 接口），也不能在适配器资源代码中使用安全性检查 API。

安全框架的体系架构是模块化的，且十分灵活，因此实施安全性检查本身并不依赖于任何特定的资源或应用程序。 您可以复用相同的安全性检查来保护不同的资源，并将不同的安全性检查组合用于各种授权流。 为了增强灵活性，安全检查类通过 {{ site.data.keys.mf_console }} 公开了可在安全性检查定义中和运行时期间在适配器级别上定制的配置属性。

为促进和加速完成开发流程，{{ site.data.keys.product }} 提供了 `SecurityCheck` 接口的基本抽象实现。 此外，还提供了 `SecurityCheckConfiguration` 接口的基本抽象实现 (`SecurityCheckConfigurationBase`)，并为所提供的每个基本安全性检查类提供了补充样本安全性检查配置类。 从最能满足您的开发需要的基本安全性检查实施（及相关样本配置）开始，并根据需要扩展和修改实施。

> 了解有关[安全性检查合同](contract)的更多信息。

**先决条件：**

* 阅读[授权概念](../)教程。
* 了解如何[创建适配器](../../adapters/creating-adapters)。

**用法：**  
下述安全性检查基类可作为 {{ site.data.keys.product_adj }} `com.ibm.mfp.security.checks.base` Java Maven 库的一部分提供，可在从 [Maven Central 存储库](http://search.maven.org/#search|ga|1|a%3A%22mfp-security-checks-base%22)构建适配器时进行下载。 如果您正在脱机开发，可通过 **{{ site.data.keys.mf_console }} → 下载中心 →“工具”选项卡 → 安全性检查**来下载这些类。

#### 跳转至：
{: #jump-to }
* [定义安全性检查](#defining-a-security-check)
* [实施安全性检查](#security-check-implementation)
* [配置安全性检查](#security-check-configuration)
* [预定义的安全性检查](#predefined-security-checks)
* [后续内容](#what-s-next)

## 定义安全性检查
{: #defining-a-security-check }

[创建 Java 或 JavaScript 适配器](../../adapters/creating-adapters/)或者使用现有项。

> 创建 Java 适配器时，缺省模板会假定适配器将提供**资源**。 开发人员可选择将安全性检查和资源捆绑到同一适配器中，或将其分散到不同的适配器中。

要除去缺省**资源**实现，请删除 **[AdapterName]Application.java** 和 **[AdapterName]Resource.java** 文件。 同时还要从 **adapter.xml** 中除去 `<JAXRSApplicationClass>` 元素。

在 Java 适配器的 **adapter.xml** 文件中，添加名为 `securityCheckDefinition` 的 XML 元素。 例如：

```xml
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    <property name="successStateExpirationSec" defaultValue="60"/>
    <property name="blockedStateExpirationSec" defaultValue="60"/>
    <property name="maxAttempts" defaultValue="3"/>
</securityCheckDefinition>
```

* `name` 属性为安全性检查的名称。
* `class` 属性用于指定安全性检查的实现 Java 类。 您需要创建此类。
* 安全性检查可以使用 `property` 元素列表来[进一步配置](#security-check-configuration)。
* 有关定义定制属性的信息，请参阅[配置安全性检查](#security-check-configuration)。

在成功将具有安全性检查定义的适配器部署到 {{ site.data.keys.mf_server }} 之后，您还可以查看安全性检查及其配置信息，并通过 **{{ site.data.keys.mf_console }} → 适配器 → [您的适配器]**来更改运行时配置：

* 在**配置文件**选项卡中，您可以查看适配器描述符的服务器副本，包括可定义定制安全性检查及其可配置属性的 `<securityCheckDefinition>` 元素。 您还可以[拉取适配器配置](../../adapters/java-adapters/#custom-properties)，并将其推送到不同的服务器。
* 在**安全性检查**选项卡中，您可以查看安全性检查定义中公开的所有配置属性的列表。 这些属性将由其配置的 `displayName` 属性的值引用，或者在未配置显示名称时，由 name 属性的值引用。 如果您在定义中设置了属性的描述属性，那么也会显示此描述。 
对于每个属性，`defaultValue` 属性中配置的值都会显示为当前值。 您可以更改该值，以覆盖安全性检查定义中的缺省值。 您还可以在任何时候复原安全性检查定义中的原始缺省值。 
* 您也可以从 {{ site.data.keys.mf_console }} 的**应用程序**部分选择某个应用程序版本。

## 实施安全性检查
{: #security-check-implementation }

为安全性检查创建 **Java 类**。 该实施应扩展所提供的某个基类，如下所示。 所选父类确定了定制与简化之间的平衡。

### 安全性检查
{: #security-check }
`SecurityCheck` 是一个 Java **接口**，可定义表示安全性检查所需的最少的方法。  
实施安全性检查的开发人员应单独负责处理每个方案。

### ExternalizableSecurityCheck
{: #externalizablesecuritycheck }
此抽象类可实现基本版本的安全性检查接口。  
它提供了外化为 JSON、不活动超时以及截止日期倒计时等选项。

为此类划分子类赋予了安全性检查实施很大的灵活性。

> 在 [ExternalizableSecurityCheck](../externalizable-security-check) 教程中了解更多信息。

### CredentialsValidationSecurityCheck
{: #credentialsvalidationsecurityCheck }
此类可扩展 `ExternalizableSecurityCheck`，并实现其大多数方法来简化使用过程。 必须实现两种方法：`validateCredentials` 和 `createChallenge`。 此实现过程允许在特定时间间隔内进行有限次数的登录尝试，在此之后会在配置的时间段内阻止安全性检查。 如果成功登录，安全性检查状态将在配置的时间段内保持成功，在此期间用户可以访问请求的资源。

`CredentialsValidationSecurityCheck` 类用于简单流以验证任意凭证，以便授权访问资源。 同时还提供一项内置功能，用于在进行一定次数的尝试后阻止访问。

> 在 [CredentialsValidationSecurityCheck](../credentials-validation/) 教程中了解更多信息。

### UserAuthenticationSecurityCheck
{: #userauthenticationsecuritycheck}
此类可扩展 `CredentialsValidationSecurityCheck`，因此将继承其所有功能。 该类将添加到创建可用于识别当前登录用户的 `AuthenticatedUser` 用户身份对象的实现中。 同时还提供了一项内置功能，用于选择性地启用“记住我”登录行为。 必须实现三种方法：`createUser`、`validateCredentials` 和 `createChallenge`。

> 在 [UserAuthentication 安全性检查](../user-authentication/)教程中了解更多信息。

## 配置安全性检查
{: #security-check-configuration }

每个安全性检查实现类均可使用 `SecurityCheckConfiguration` 类，用来定义可用于此安全性检查的属性。 每个基本 `SecurityCheck` 类均随附一个匹配的 `SecurityCheckConfiguration` 类。 您可以创建自己的实现，用于扩展某个基本 `SecurityCheckConfiguration` 类，并将其用于定制安全性检查。

例如，`UserAuthenticationSecurityCheck` 的 `createConfiguration` 方法可返回 `UserAuthenticationSecurityCheckConfig` 实例。

```java
public abstract class UserAuthenticationSecurityCheck extends CredentialsValidationSecurityCheck {
  @Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
      return new UserAuthenticationSecurityCheckConfig(properties);
  }
}
```

`UserAuthenticationSecurityCheckConfig` 可启用名为 `rememberMeDurationSec` 的属性，缺省值为 `0`。

```java
public class UserAuthenticationSecurityCheckConfig extends CredentialsValidationSecurityCheckConfig {

    public int rememberMeDurationSec;

    public UserAuthenticationSecurityCheckConfig(Properties properties) {
        super(properties);
        rememberMeDurationSec = getIntProperty("rememberMeDurationSec", properties, 0);
    }

}
```

<br/>
可以在几个级别上配置这些属性：

### adapter.xml
{: #adapterxml }
在 Java 适配器的 **adapter.xml** 文件中，可在 `<securityCheckDefinition>` 内添加一个或多个 `<property>` 元素。  
`<property>` 元素具有以下属性：

- **name**：配置类中定义的属性名称。
- **defaultValue**：覆盖配置类中定义的缺省值。
- **displayName**：*可选*，控制台中显示的用户友好名称。
- **description**：*可选*，控制台中显示的描述。
- **type**：*可选*，确保属性采用特定的类型，如 `integer`、`string`、`boolean` 或有效值列表（例如，`type="['1','2','3']"`）。

示例：

```xml
<property name="maxAttempts" defaultValue="3" displayName="How many attempts are allowed?" type="integer"/>
```

> 有关实际的示例，请参阅 CredentialsValidation 安全性检查教程的[“配置安全性检查”部分](../credentials-validation/security-check/#configuring-the-security-check)。

### {{ site.data.keys.mf_console }} - 适配器
{: #mobilefirst-operations-console-adapter }
在 {{ site.data.keys.mf_console }} → **[您的适配器] →“安全性检查”选项卡**中，您可以更改 **adapter.xml** 文件中定义的任何属性的值。  
请注意，此屏幕上将**仅**显示 **adapter.xml** 文件中定义的属性；配置类中定义的属性将不会在此自动显示。

![控制台中的适配器](console-adapter-security.png)

您还可以使用必需的配置来手动编辑适配器的配置 JSON 文件，并将更改推送回 {{ site.data.keys.mf_server }}。

1. 从**命令行窗口**导航至项目的根文件夹，然后运行 `mfpdev adapter pull`。
2. 打开位于 **project-folder\mobilefirst** 文件夹中的配置文件。
3. 编辑此文件并查找 `securityCheckDefinitions` 对象。 在此对象中，查找或创建命名为所选安全性检查的对象。 在安全性检查对象内，查找或添加属性对象。 对于要配置的每个可用配置属性，请在属性对象内添加一对配置属性名称和值。 例如： 

   ```xml
   "securityCheckDefinitions": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "4",
                "failureExpirationSec: "90"
            }
        }
   }
   ```
   
4. 运行以下命令来部署更新的配置 JSON 文件：`mfpdev adapter push`。

### {{ site.data.keys.mf_console }} - 应用程序
{: #mobilefirst-operations-console-application }
同时还可以在应用程序级别上覆盖属性值。

在 {{ site.data.keys.mf_console }} → **[您的应用程序] →“安全性”选项卡**中的**安全性检查配置**部分下，可修改每项可用安全性检查中定义的值。

<img class="gifplayer" alt="配置安全性检查属性" src="console-application-security.png"/>

您还可以使用必需的配置来手动编辑适配器的配置 JSON 文件，并将更改推送回 {{ site.data.keys.mf_server }}。

1. 从**命令行窗口**导航至项目的根文件夹，然后运行 `mfpdev app pull`。
2. 打开位于 **project-folder\mobilefirst** 文件夹中的配置文件。
3. 编辑此文件并查找 `securityCheckConfigurations` 对象。 在此对象中，查找或创建命名为所选安全性检查的对象。 在安全性检查对象内，为要配置的每个可用配置属性添加一对配置属性名称和值。 例如：

   ```xml
   "SecurityCheckConfigurations": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "2",
                "failureExpirationSec: "60"
            }
        }
   }
   ```
   
4. 运行以下命令来部署更新的配置 JSON 文件：`mfpdev app push`。

## 预定义的安全性检查
{: #predefined-security-checks }

同时还可以使用以下预定义安全性检查：

- [应用程序真实性](../application-authenticity/)
- [直接更新](../../application-development/direct-update)
- LTPA

## 后续内容
{: #what-s-next }

在以下教程中继续阅读有关安全性检查的内容。  
请记住在完成开发或更改时部署适配器。

* [实现 CredentialsValidationSecurityCheck](../credentials-validation/)。
* [实现 UserAuthenticationSecurityCheck](../user-authentication/)。
* 了解其他 {{ site.data.keys.product }} [认证和安全性功能](../)。
