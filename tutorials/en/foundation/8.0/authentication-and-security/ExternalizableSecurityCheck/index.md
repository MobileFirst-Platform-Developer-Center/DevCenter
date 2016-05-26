---
layout: tutorial
title: Implementing the ExternalizableSecurityCheck
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 6
---
## Overview
The abstract `ExternalizableSecurityCheck` class implements the `SecurityCheck` interface and handles two important aspects of the security check functionality: externalization and state management.

* Externalization - this class implements the `Externalizable` interface, so that the derived classes don't need to implement it themselves.
* State management - this class predefined a `STATE_EXPIRED` state that means the security check is expired and its state will not be preserved. The derived classes need to define other states supported by their security check.

Three methods are required to be implemented by the subclasses: `initStateDurations`, `authorize` and `introspect`.

This tutorial..

**Prerequisites:**

#### Jump to:

## Creating the Security Check
[Create a Java adapter](../../../adapters/creating-adapters) and add a Java class named `IsEnrolled` that extends `ExternalizableSecurityCheck`.

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

## The `initStateDurations` Method
The `ExternalizableSecurityCheck` defines an abstract method called `initStateDurations`. The subclasses must implement that method providing the names and durations for all states supported by their security check. The duration values usually come from the security check configuration.

In our sample...

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((IsEnrolledConfig) config).successStateExpirationSec);
}
```

## The `authorize` Method
The `SecurityCheck` interface defines a method called `authorize`. This method is responsible for implementing the main logic of the security check, it returns success, challenge, or failure. Here is were you manage state transitions.

* `scope` - the requested scope.
* `credentials` - the credentials sent by the client.
* `request` - the request sent by the client.
* `response` - the response to which this check adds its success, challenge, or failure.

Use the following methods to manage states:

```java
protected void setState(String name)

public String getState()
```

In our sample it simply checks if the user is enrolled:

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

This implementation checks the "pinCode" attribute:

* In case it exist:

 * Set the state to SUCCESS by using the `setState` method.
 * Add success to the response object by using the `addSuccess` method.
* In case it doesn't exist:

 * Set the state to EXPIRED by using the `setState` method.
 * Add failure to the response object by using the `addFailure` method.

 The `addSuccess` and `addFailure` methods... ??

## The `introspect` Method
The `SecurityCheck` interface defines a method called `introspect`. This method...

In our sample...

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```
