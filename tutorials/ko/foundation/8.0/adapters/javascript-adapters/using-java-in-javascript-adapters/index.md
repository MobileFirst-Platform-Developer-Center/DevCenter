---
layout: tutorial
title: JavaScript 어댑터에서 Java 사용
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: 어댑터 Maven 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

JavaScript가 필요한 기능성을 구현하기에 충분하지 않을 때 또는 Java 클래스가 이미 있는 경우, JavaScript 어댑터를 위한 확장으로 Java 코드를 사용할 수 있습니다. 

**전제조건:** [JavaScript 어댑터](../) 학습서를 먼저 읽으십시오. 

## 사용자 정의 Java 클래스 추가
{: #adding-custom-java-classes }

![JS에서 Java 사용](UsingJavainJS.png)

기존 Java 라이브러리를 사용하려면 프로젝트에 종속성으로 JAR 파일을 추가하십시오. 종속성 추가 방법에 대한 자세한 정보는 [Java 및 JavaScript 어댑터 작성](../../creating-adapters/#dependencies) 학습서에서 종속성 섹션을 참조하십시오. 

사용자 정의 Java 코드를 프로젝트에 추가하려면 어댑터 프로젝트에서 **src/main** 폴더에 **java**로 이름 지정된 폴더를 추가하고 패키지를 해당 폴더 안에 넣으십시오. 이 학습서의 샘플은 `Calculator.java`로 이름 지정된 Java 클래스 파일과 `com.sample.customcode` 패키지를 파일을 사용합니다.    

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **중요:** 패키지 이름은 `com`, `org` 또는 `net`로 시작해야 합니다.



메소드를 Java 클래스에 추가하십시오.   
(새 인스턴스를 요구하지 않는) 정적 메소드 및 인스턴스 메소드의 예는 다음과 같습니다.

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

## 어댑터에서 사용자 정의 Java 클래스 호출
{: #invoking-custom-java-classes-from-the-adapter }

사용자 정의 Java 코드를 작성하고 필요한 JAR 파일을 추가한 후 JavaScript 코드에서 이를 호출할 수 있습니다.

* 표시된 것처럼 정적 Java 메소드를 호출하고, 직접 참조하도록 전체 클래스 이름을 사용하십시오.

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* 인스턴스 메소드를 사용하려면 클래스 인스턴스를 작성하고 인스턴스 메소드를 호출하십시오.

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## 샘플 어댑터
{: #sample-adapter }

Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)하십시오. 

### 샘플 사용법
{: #sample-usage }

* [JavaScriptHTTP 어댑터를 빌드 및 배치](../../creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오. 
* 어댑터를 테스트하거나 디버깅하려면 [어댑터 테스트 및 디버깅](../../testing-and-debugging-adapters) 학습서를 참조하십시오. 

테스트할 때 어댑터는 더하거나 뺄 어레이 수를 예상합니다. 예: `[1,2]`
