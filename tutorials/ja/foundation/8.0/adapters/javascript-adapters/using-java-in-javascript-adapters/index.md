---
layout: tutorial
title: JavaScript アダプターでの Java の使用
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

必要な機能を実装するのに JavaScript では不十分な場合や既存の Java クラスがある場合には、JavaScript アダプターの拡張として Java コードを使用することができます。

**前提条件:** 最初に必ず、[JavaScript アダプター](../)チュートリアルをお読みください。

## カスタム Java クラスの追加
{: #adding-custom-java-classes }

![UsingJavainJS](UsingJavainJS.png)

既存の Java ライブラリーを使用するには、JAR ファイルを依存関係としてプロジェクトに追加します。 依存関係の追加方法について詳しくは、[Java アダプターおよび JavaScript アダプターの作成](../../creating-adapters/#dependencies)チュートリアルの『依存関係』セクションを参照してください。

カスタム Java コードをプロジェクトに追加するには、アダプター・プロジェクトの **src/main** フォルダーに **java** という名前のフォルダーを追加して、そこにパッケージを置きます。 このチュートリアルのサンプルでは、`com.sample.customcode` パッケージと Java クラス・ファイル名 `Calculator.java` を使用します。   

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:** パッケージ名の先頭は `com`、`org`、または `net` でなければなりません。

Java クラスにメソッドを追加します。  
静的メソッドの例 (新規インスタンスを必要としません) とインスタンス・メソッドの例を以下に示します。

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

## アダプターからのカスタム Java クラスの呼び出し
{: #invoking-custom-java-classes-from-the-adapter }

カスタム Java コードを作成して必要な JAR ファイルを追加すると、そのファイルを JavaScript コードから呼び出すことができます。

* 静的 Java メソッドを次のようにして呼び出し、完全クラス名を使用して直接参照します。

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* インスタンス・メソッドを使用するには、クラス・インスタンスを作成して、そのインスタンスからインスタンス・メソッドを呼び出します。

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## サンプル・アダプター
{: #sample-adapter }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) して Maven プロジェクトをダウンロードします。

### 使用例
{: #sample-usage }

* Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[JavaScriptHTTP アダプターのビルドとデプロイ](../../creating-adapters/)を行います。
* アダプターをテストまたはデバッグするには、[アダプターのテストおよびデバッグ](../../testing-and-debugging-adapters)チュートリアルを参照してください。

テスト時には、アダプターは、例えば `[1,2]` のような、加算または減算する数値を持つ配列を予期しています。
