---
layout: tutorial
title: Creating a Security Check
breadcrumb_title: Creating a security check
relevantTo: [android,ios,windows,javascript]
weight: 2
---
## Overview
A security check is an entity that is responsible for obtaining and validating client credentials.

Security checks are defined inside **an adapter** and are implemented in Java code. Any adapter can theoretically define a security check.  

An adapter can either be a *resource* adapter (meaning it serves resources and content to send to the client), a *SecurityCheck* adapter, or **both**.

**Prerequisites:**

* Read the [Authorization concepts](../) tutorial.
* Learn how to [creating adapters](../../adapters/creating-adapters).

#### Jump to:

* [Defining a security Check](#defining-a-security-check)
* [Security Check Implementation](#security-check-implementation)
* [Security Check Configuration](#security-check-configuration)
* [Predefined Security Checks](#predefined-security-checks)
* [Tutorials to follow next](#tutorials-to-follow-next)

## Defining a Security Check
[Create a Java or JavaScript adapter](../../adapters/creating-adapters/) or use an exiting one.

> When creating a Java adapter, the default template assumes that the adapter will serve **resources**. It is the developer's choice to bundle security checks and resources in the same adapter, or to separate them into distinct adapters.

To remove the default **resource** implementation, delete the files **[AdapterName]Application.java** and **[AdapterName]Resource.java**. Remove the `<JAXRSApplicationClass>` element from **adapter.xml**, too.

In the Java adapter's `adapter.xml` file, add an XML element called `securityCheckDefinition`. For example:

```xml
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    <property name="successStateExpirationSec" defaultValue="60"/>
    <property name="blockedStateExpirationSec" defaultValue="60"/>
    <property name="maxAttempts" defaultValue="3"/>
</securityCheckDefinition>
```

- The `name` attribute is the name of your security check.
- The `class` attribute specifies the implementation Java class of the security check. You need to create this class.
- Security checks can be [further configured](#security-check-configuration) with a list of `property` elements.

## Security Check Implementation
Create the **Java class** for the security check. The implementation should extend one of the provided base classes, as shown below. The parent class you choose determines the balance between customization and simplicity.

### Security Check
`SecurityCheck` is a Java **interface**, which defines the minimum required methods to represent the security check.  
It is the sole responsibility of the developer who implements the security check to handle each scenario.

### ExternalizableSecurityCheck
This abstract class implements a basic version of the security-check interface.  
It provides, among other options: externalization as JSON, inactivity timeout, expiration countdown, and more.

Subclassing this class leaves a lot of flexibility in your security check implementation.

> Learn more in the [ExternalizableSecurityCheck](../externalizable-security-check) tutorial.

### CredentialsValidationSecurityCheck
This abstract class extends `ExternalizableSecurityCheck` and implements most of its methods to simplify usage. Two methods must be implemented: `validateCredentials` and `createChallenge`.

The `CredentialsValidationSecurityCheck` class is meant for simple flows to validate arbitrary credentials, to grant access to a resource. A built-in capability to block access after a set number of attempts is also provided.

> Learn more in the [CredentialsValidationSecurityCheck](../credentials-validation/) tutorials.

### UserAuthenticationSecurityCheck
This abstract class extends `CredentialsValidationSecurityCheck` and therefore inherits all of its features.

In addition, the `UserAuthenticationSecurityCheck` class provides the MobileFirst framework with an `AuthenticatedUser` object which represents the logged-in user. You must implement the `createUser`, `validateCredentials`, and `createChallenge` methods.

A built-in capability to optionally enable a "Remember Me" login behavior is also provided.

> Learn more in the [UserAuthentication security check](../user-authentication/) tutorials.

## Security Check Configuration
Each security-check implementation class can use a `SecurityCheckConfiguration` class that defines properties available for that security check. Each base `SecurityCheck` class comes with a matching `SecurityCheckConfiguration` class. You can create your own implementation that extends one of the base `SecurityCheckConfiguration` classes and use it for your custom security check.

For example, the `createConfiguration` method of `UserAuthenticationSecurityCheck` returns an instance of `UserAuthenticationSecurityCheckConfig`.

```java
public abstract class UserAuthenticationSecurityCheck extends CredentialsValidationSecurityCheck {
  @Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
      return new UserAuthenticationSecurityCheckConfig(properties);
  }
}
```

`UserAuthenticationSecurityCheckConfig` enables a property called `rememberMeDurationSec` with a default of `0`.

```java
public class UserAuthenticationSecurityCheckConfig extends CredentialsValidationSecurityCheckConfig {

    public int rememberMeDurationSec;

    public UserAuthenticationSecurityCheckConfig(Properties properties) {
        super(properties);
        rememberMeDurationSec = getIntProperty("rememberMeDurationSec", properties, 0);
    }

}
```

These properties can be configured at several levels:

### adapter.xml
In the Java adapter's `adapter.xml` file, inside `<securityCheckDefinition>`, you can add one or more `<property>` elements.  
The `<property>` element takes the following attributes:

- **name**: The name of the property, as defined in the configuration class.
- **defaultValue**: Overrides the default value defined in the configuration class.
- **displayName**: *optional*, a user-friendly name to be displayed in the console.
- **description**: *optional*, a description to be displayed in the console.
- **type**: *optional*, ensures that the property is of a specific type such as `integer`, `string`, `boolean`, or a list of valid values (for example `type="['1','2','3']"`).

Example:

```xml
<property name="maxAttempts" defaultValue="3" displayName="How many attempts are allowed?" type="integer"/>
```

### MobileFirst Operations Console - Adapter
In the MobileFirst Operations Console → **[your adapter] → Security Check tab**, you can change the value of any property defined in the `adapter.xml` file.  
Note that **only** the properties defined in the `adapter.xml` file appear on this screen; properties defined in the configuration class won't appear here automatically.

![Adapter in console](console-adapter-security.png)

### MobileFirst Operations Console - Application
Property values can also be overridden at the application level.

In the MobileFirst Operations Console → **[your application] → Security tab**, under the **Security Check Configurations** section, you can modify the values defined in each security check available.

<img class="gifplayer" alt="Configuring security check properties" src="console-application-security.png"/>

## Predefined Security Checks
These predefined security checks are also available:

- [Application Authenticity](../application-authenticity/)
- [Direct Update](../../using-the-mfpf-sdk/direct-update)
- LTPA

## Tutorials to follow next
Continue reading about security checks in the following tutorials.  
Remember to deploy your adapter when you're done developing or making changes.

* [Implementing the CredentialsValidationSecurityCheck](../credentials-validation/).
* [Implementing the UserAuthenticationSecurityCheck](../user-authentication/).
* Learn about additional MobileFirst Foundation [authentication and security features](../).
