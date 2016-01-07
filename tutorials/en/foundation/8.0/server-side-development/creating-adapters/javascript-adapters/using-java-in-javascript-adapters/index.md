---
layout: tutorial
title: Using Java in JavaScript Adapters
relevantTo: [ios,android,windowsphone8,windows8,cordova]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JavaScriptAdapters
weight: 3
---

## Overview

When JavaScript is not sufficient to implement required functionality, or if a Java class already exists, you can use Java code as an extension for the JavaScript adapter.

**Prerequisite:** Make sure to read the [JavaScript Adapters](../) tutorial first.

## Adding custom Java classes 
<span style="color:red">IMAGE</span>

1. To use an existing Java library, add the JAR file to the `server\lib` folder of your MobileFirst project.
After the adapter is built and deployed, this JAR file is automatically deployed to MobileFirst Server.

2. To add custom Java code to your project, right-click the `server/java` folder in your MobileFirst project and add a Java class file. Name it `Calculator.java`.
**Important:** The package name must start with either `com`, `org`, or `net`.

3. Add this file to a package. This sample uses the `com.sample.customcode` package.
This package name can be interpreted as folders: `java\com\sample\customcode`

4. Add methods to your Java class.  
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
5. If your Java code has additional dependencies, put the required JAR files in the `server\lib` folder of your MobileFirst project.

## Invoking custom Java classes from the adapter
After your custom Java code is created and any required JAR files are added, you can call it from the JavaScript code:

* Invoke the static Java method as shown, and use the full class name to reference it directly:
#### UsingJavaInAdapter-impl.js

    ```js
    function addTwoIntegers(a,b){
      return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
      };
    }
    ```
* To use the instance method, create a class instance and invoke the instance method from it:
#### UsingJavaInAdapter-impl.js

    ```js
    function subtractTwoIntegers(a,b){
      var calcInstance = new com.sample.customcode.Calculator();   
      return {
        result : calcInstance.subtractTwoIntegers(a,b)
      };
    }
    ```

## Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/JavaScriptAdapters) the MobileFirst project.
