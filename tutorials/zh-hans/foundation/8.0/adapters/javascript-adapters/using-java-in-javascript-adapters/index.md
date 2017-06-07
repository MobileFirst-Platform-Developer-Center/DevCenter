---
layout: tutorial
title: 在 JavaScript 适配器中使用 Java
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

当 JavaScript 不足以实施所需的功能，或者 Java 类已存在时，您可以使用 Java 代码作为 JavaScript 适配器的扩展。

**先决条件：**确保首先阅读 [JavaScript 适配器](../)教程。

## 添加定制 Java 类
{: #adding-custom-java-classes }

![UsingJavainJS](UsingJavainJS.png)

要使用现有的 Java 库，请将 JAR 文件作为依赖关系添加到项目中。有关如何添加依赖关系的更多信息，请参阅[创建 Java 和 JavaScript 适配器](../../creating-adapters/#dependencies)教程的“依赖关系”部分。

要将定制 Java 代码添加到项目中，请向适配器项目中的 **src/main** 文件夹添加名为 **java** 的文件夹，然后将您自己的程序包放入其中。本教程中的样本使用 `com.sample.customcode` 程序包和名为 `Calculator.java` 的 Java 类文件。   

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：**程序包名称必须以 `com`、`org` 或 `net` 开头。
向您的 Java 类添加方法。  
以下是静态方法（不需要新实例）和实例方法的示例：

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

## 从适配器调用定制 Java 类
{: #invoking-custom-java-classes-from-the-adapter }

创建定制 Java 代码并添加所需的所有 JAR 文件后，您即可以从 JavaScript 代码进行调用：

* 如下所示调用静态 Java 方法，并使用完整类名直接引用此方法：

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* 要使用实例方法，请创建类实例并从中调用实例方法：

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## 样本适配器

{: #sample-adapter }

[单击以下载 ](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)Maven 项目。

### 样本用法
{: #sample-usage }

* 使用 Maven、{{ site.data.keys.mf_cli }} 或您所选的 IDE 来[构建和部署 JavaScriptHTTP 适配器](../../creating-adapters/)。
* 要测试或调试适配器，请参阅[测试和调试适配器](../../testing-and-debugging-adapters)教程。

测试时，适配器预期有一个数组，其中包含用于加减的数字，例如：`[1，2]`。
