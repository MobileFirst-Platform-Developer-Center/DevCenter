---
layout: tutorial
title: 实现 ExternalizableSecurityCheck
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
抽象的 `ExternalizableSecurityCheck` 类实现了 `SecurityCheck` 接口，并处理安全性检查功能的两个重要方面：外部化和状态管理。

* 外部化 - 该类实现 `Externalizable` 接口，因此派生类无需自行实现。
* 状态管理 - 该类预定义 `STATE_EXPIRED` 状态，这意味着安全性检查已到期并且不会保留其状态。 派生类需要定义其安全性检查所支持的其他状态。

子类需要实现三种方法：`initStateDurations`、`authorize` 和 `introspect`。

本教程解释如何实现类并演示如何管理状态。

**先决条件：**确保阅读[授权概念](../)和[创建安全性检查](../creating-a-security-check)教程。

#### 跳转至：
{: #jump-to }
* [initStateDurations 方法](#the-initstatedurations-method)
* [authorize 方法](#the-authorize-method)
* [introspect 方法](#the-introspect-method)
* [AuthorizationContext 对象](#the-authorizationcontext-object)
* [RegistrationContext 对象](#the-registrationcontext-object)

## initStateDurations 方法
{: #the-initstatedurations-method }
`ExternalizableSecurityCheck` 定义名为 `initStateDurations` 的抽象方法。 子类必须通过提供其安全性检查支持的所有状态的名称和持续时间来实现此方法。 持续时间值通常来自安全性检查配置。

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((SecurityCheckConfig) config).successStateExpirationSec);
}
```

> 有关安全性检查配置的更多信息，请参阅“实现 CredentialsValidationSecurityCheck”教程中的[配置类部分](../credentials-validation/security-check/#configuration-class)。

## authorize 方法
{: #the-authorize-method }
`SecurityCheck` 接口定义名为 `authorize` 的方法。 此方法负责实施安全性检查的主逻辑、管理状态以及向客户机发送响应（成功、验证问题或失败）。

使用以下 helper 方法来管理状态：

```java
protected void setState(String name)
```
```java
public String getState()
```
以下示例仅检查用户是否登录，并相应地返回成功或失败：

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (loggedIn){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();           
        failure.put("failure", "User is not logged-in");
        response.addFailure(getName(), failure);
    }
}
```

`AuthorizationResponse.addSuccess` 方法会向响应对象添加成功作用域及其到期时间。 它需要：

* 安全性检查授权的作用域。
* 已授权作用域的到期时间。  
`getExpiresAt` helper 方法返回当前状态的到期时间，如果当前状态为 null，那么返回 0：

  ```java
  public long getExpiresAt()
  ```
   
* 安全性检查的名称。

`AuthorizationResponse.addFailure` 方法会向响应对象添加失败。 它需要：

* 安全性检查的名称。
* 失败 `Map` 对象。

`AuthorizationResponse.addChallenge` 方法会向响应对象添加验证问题。 它需要：

* 安全性检查的名称。
* 验证问题 `Map` 对象。

## introspect 方法
{: #the-introspect-method }
`SecurityCheck` 接口定义名为 `introspect` 的方法。 此方法必须确保安全性检查处于授予所请求作用域的状态。 如果授予作用域，那么安全性检查必须向结果参数报告授予的作用域、其到期时间以及定制自省数据。 如果未授予作用域，那么安全性检查不会执行任何操作。  
此方法可能更改安全性检查和/或客户机注册记录的状态。

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```

## AuthorizationContext 对象
{: #the-authorizationcontext-object }
`ExternalizableSecurityCheck` 类提供 `AuthorizationContext authorizationContext` 对象，用于存储与安全性检查的当前客户机相关联的瞬时数据。  
使用以下方法来存储和获取数据：

* 获取此安全性检查为当前客户机设置的已认证的用户：

  ```java
  AuthenticatedUser getActiveUser();
  ```
  
* 通过此安全性检查设置当前客户机的活动用户：

  ```java
  void setActiveUser(AuthenticatedUser user);
  ```

## RegistrationContext 对象
{: #the-registrationcontext-object }
`ExternalizableSecurityCheck` 类提供 `RegistrationContext registrationContext` 对象，用于存储与当前客户机相关联的持久/部署数据。  
使用以下方法来存储和获取数据：

* 获取此安全性检查为当前客户机注册的用户：

  ```java
  AuthenticatedUser getRegisteredUser();
  ```
  
* 为当前客户机注册指定用户：

  ```java
  setRegisteredUser(AuthenticatedUser user);
  ```
  
* 获取当前客户机的公共持久属性：

  ```java
  PersistentAttributes getRegisteredPublicAttributes();
  ```
  
* 获取当前客户机的受保护持久属性：

  ```java
  PersistentAttributes getRegisteredProtectedAttributes();
  ```
  
* 按指定的搜索条件查找移动式客户机的注册数据：

  ```java
  List<ClientData> findClientRegistrationData(ClientSearchCriteria criteria);
  ```

## 样本应用程序
{: #sample-application }
有关实现 `ExternalizableSecurityCheck` 的样本，请参阅[注册](../enrollment)教程。
