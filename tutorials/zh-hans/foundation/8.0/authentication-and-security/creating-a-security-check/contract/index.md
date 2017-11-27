---
layout: tutorial
title: 安全性检查合同
breadcrumb_title: 安全性检查合同
relevantTo: [android,ios,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
每项安全性检查都必须实现 `com.ibm.mfp.server.security.external.SecurityCheck` 接口（安全性检查接口）。 此接口构成安全性检查与 {{ site.data.keys.product_adj }} 安全框架间的基本合同。 实施安全性检查必须满足以下需求：

* **功能**：安全性检查必须提供客户机`授权`和`自省`功能。
* **状态管理**：安全性检查必须管理其状态，包括创建、处理和当前状态管理。
* **配置**：安全性检查必须创建安全性检查配置对象，用来定义受支持的安全性检查配置属性，并验证基本配置的定制类型和值。

有关安全性检查接口的完整参考信息，[请参阅 API 参考中的 `SecurityCheck`](../../../api/server-side-api/java/)。

## 安全性检查功能
{: #securityc-check-functions }
安全性检查为安全框架提供两大功能：

### 授权
{: #authorization }
该框架使用 `SecurityCheck.authorize` 方法来授权客户机请求。 当客户机请求访问特定的 OAuth 作用域时，该框架会将作用域元素映射到安全性检查。 对于作用域中的每项安全性检查，该框架都会调用 `authorize` 方法，针对包含作用域元素（映射到此安全性检查）的作用域请求授权。 该方法的 **scope** 参数中提供了此作用域。

安全性检查会将其响应添加到在响应参数中传递给它的 [`AuthorizationResponse`对象](../../../api/server-side-api/java/)。 响应包含安全性检查名称和响应类型，它可以是成功、失败或验证问题（[请参阅 `AuthorizationResponse.ResponseType`](../../../api/server-side-api/java/)）。

在响应包含验证问题对象或定制成功或失败数据时，该框架会将数据传递至 JSON 对象中的客户机安全性检查验证问题处理程序。 为获得成功，响应还要包含为其请求授权的作用域（如 **scope** 参数中设置）以及授权到期时间。 为授权客户机访问请求作用域，作用域的每项安全性检查的 `authorize` 方法都必须返回成功，并且所有到期时间都必须晚于当前时间。

### 自省
{: #introspection }
该框架使用 `SecurityCheck.introspect` 方法为资源服务器检索自省数据。 该方法针对为其请求自省的作用域中包含的每项安全性检查而调用。 如同 `authorize` 方法一样，`introspect` 方法接收 **scope** 参数，其中包含映射到此安全性检查的作用域元素。 在返回自省数据前，该方法会验证安全性检查的当前状态是否仍支持先前为此作用域授予的权限。 如果授权仍有效，那么 `introspect` 方法会将其响应添加到在 **response** 参数中传递给它的 [IntrospectionResponse 对象](../../../api/server-side-api/java/)。

响应包含安全性检查名称、为其请求授权的作用域（如 **scope** 参数中设置）、授权到期时间以及请求的定制自省数据。 如果无法再授予权限（例如，如果先前成功状态的到期时间已过），那么该方法将在不添加响应的情况下返回。

**注：**

* 安全框架从安全性检查收集处理结果，并将相关数据传递至客户机。 该框架处理过程完全不了解安全性检查的状态。
* 对 `authorize` 或 `introspect` 方法的调用可能会使安全性检查的当前状态发生变化，即使当前状态仍未到期也如此。

> [在 ExternalizableSecurityCheck](../../externalizable-security-check) 教程中了解有关 `authorize` 和 `introspect` 方法的更多信息。

### 安全性检查状态管理
{: #security-check-state-management }
安全性检查是有状态的，这意味着安全性检查负责跟踪和保留其交互状态。 针对每个授权或自省请求，安全框架都会从外部存储器（通常是分布式高速缓存）中检索相关安全性检查的状态。 在请求处理结束后，该框架会将安全性检查状态重新存储到外部存储器中。

安全性检查合同要求安全性检查：

* 实现 `java.io.Externalizable` 接口。 安全性检查使用此接口来管理其状态的序列化和反序列化。
* 为其当前状态定义到期时间和不活动超时。 安全性检查状态表示授权流程中的某个阶段，并且不能是不确定的。 根据所实施的逻辑，在安全性检查实施中设置状态有效性的特定时间段和最长不活动时间。 安全性检查通过实现 SecurityCheck 接口的 `getExpiresAt` 和 `getInactivityTimeoutSec` 方法，通知框架其所选到期时间和不活动超时。

### 安全性检查配置
{: #security-check-configuration }
安全性检查可公开配置属性，可以在适配器和应用程序级别上定制其值。 特定类的安全性检查定义可确定公开此类的哪些受支持的配置属性，并可以定制类定义中设置的缺省值。 可为定义安全性检查的适配器以及使用检查的每个应用程序动态地进一步定制属性值。

安全性检查类通过实现 `createConfiguration` 方法来公开其支持的属性，这会创建一个实现 `com.ibm.mfp.server.security.external.SecurityCheckConfiguration` 接口（安全性检查配置接口）的安全性检查配置类实例。 此接口可补充 `SecurityCheck` 接口，并且也是安全性检查合同的一部分。 安全性检查可创建未公开任何属性的配置对象，但 `createConfiguration` 方法必须返回有效的配置对象，且不能返回空值。 有关安全性检查配置接口的完整参考，请参阅 [`SecurityCheckConfiguration`](../../../api/server-side-api/java/)。

安全框架会在部署期间调用安全性检查的 `createConfiguration` 方法，这将在任何适配器或应用程序配置发生变化时进行。 该方法的属性参数包含适配器的安全性检查定义中定义的属性及其当前定制值（或未定制情况下的缺省值）。 实施安全性检查配置应验证所收到的属性值，并提供返回验证结果的方法。

安全性检查配置必须实现 `getErrors`、`getWarnings` 和 `getInfo` 方法。 抽象的安全性检查配置基类 [`SecurityCheckConfigurationBase`](../../../api/server-side-api/java/) 还定义和实现定制的 `getStringProperty`、`getIntProperty` 和 `addMessage` 方法。 请参阅此类的代码文档，以获取详细信息。

**注：**安全性检查定义以及任何适配器或应用程序定制中的配置属性名称和值，都必须与配置类中定义的受支持的属性及允许值匹配。

> 在安全性检查中了解有关[创建定制属性](../#security-check-configuration)的更多信息。
