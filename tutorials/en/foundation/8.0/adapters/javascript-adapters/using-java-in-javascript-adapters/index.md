---
layout: tutorial
title: Using Java in JavaScript Adapters
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
When JavaScript is not sufficient to implement required functionality, or if a Java class already exists, you can use Java code as an extension for the JavaScript adapter.

**Prerequisite:** Make sure to read the [JavaScript Adapters](../) tutorial first.

## Adding custom Java classes 
![UsingJavainJS](UsingJavainJS.png)

To use an existing Java library, add the JAR file as a dependency to your project. For more information on how to add a dependency, see the Dependencies section in the [Creating Java and JavaScript Adapters](../../creating-adapters/#dependencies) tutorial.

To add custom Java code to your project, add a folder named **java** to the **src/main** folder in your adapter project and put your package in it. The sample in this tutorial uses a `com.sample.customcode` package and a Java class file named `Calculator.java`.   

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important:** The package name must start with either `com`, `org`, or `net`.

Add methods to your Java class.  
Here are an examples of a static method (that does not require a new instance) and an instance method:

```java
public class Calculator {

  // Add two integers.
  public static int addTwoIntegers(int first, int second){
    return first + second;
  }

  // Subtract two integers.
  public int subtractTwoIntegers(int first, int second){
    return first - second;
  }
}
```

## Invoking custom Java classes from the adapter
After your custom Java code is created and any required JAR files are added, you can call it from the JavaScript code:

* Invoke the static Java method as shown, and use the full class name to reference it directly:

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* To use the instance method, create a class instance and invoke the instance method from it:

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## Sample adapter
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) the Maven project.

### Sample usage
* Use either Maven, {{ site.data.keys.mf_cli }} or your IDE of choice to [build and deploy the JavaScriptHTTP adapter](../../creating-adapters/).
* To test or debug an adapter, see the [testing and debugging adapters](../../testing-and-debugging-adapters) tutorial.

When testing, the adapter expects an array with numbers to add or subtract, for example: `[1,2]`.
