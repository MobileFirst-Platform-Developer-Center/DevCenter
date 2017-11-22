---
layout: tutorial
title: Java in JavaScript-Adaptern verwenden
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Wenn JavaScript für die Implementierung der erforderlichen Funktionalität nicht ausreicht oder bereits eine Java-Klasse vorhanden ist, können Sie Java-Code als Erweiterung für den JavaScript-Adapter verwenden. 

**Voraussetzung:** Arbeiten Sie zuerst das Lernprogramm [JavaScript-Adapter](../) durch. 

## Angepasste Java-Klassen hinzufügen
{: #adding-custom-java-classes }

![UsingJavainJS](UsingJavainJS.png)

Wenn Sie eine vorhandene Java-Bibliothek verwenden möchten, fügen Sie die JAR-Datei als Abhängigkeit zu Ihrem Projekt hinzu. Weitere Informationen zum Hinzufügen einer Abhängigkeit finden Sie im Abschnitt "Abhängigkeiten"
des Lernprogramms [Java- und JavaScript-Adapter erstellen](../../creating-adapters/#dependencies). 

Wenn Sie angepassten Java-Code zu Ihrem Projekt hinzufügen möchten, fügen Sie einen Ordner mit dem Namen
**java** zum Ordner **src/main** Ihres Java-Projekts hinzu und stellen Sie Ihr Paket in diesen neuen Ordner. Für das Beispiel in diesem Lernprogramm werden ein Paket
`com.sample.customcode` und eine Java-Klassendatei mit dem Namen `Calculator.java` verwendet.   

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:** Der Paketname muss
mit `com`, `org` oder `net` beginnen.



Fügen Sie Methoden zu Ihrer Java-Klasse hinzu.   
Es folgen Beispiele für eine statische Methode (für die keine neue Instanz erforderlich ist) und einer Instanzdefinitionsmethode: 

```java
public class Calculator {

  // Zwei ganze Zahlen addieren
  public static int addTwoIntegers(int first, int second){
    return first + second;
  }

  // Zwei ganze Zahlen subtrahieren
  public int subtractTwoIntegers(int first, int second){
    return first - second;
  }
}
```

## Angepasste Java-Klassen mit dem Adapter aufrufen
{: #invoking-custom-java-classes-from-the-adapter }

Wenn Ihr angepasster Java-Code erstellt ist und alle erforderlichen JAR-Dateien hinzugefügt wurden, können Sie Ihren Code vom JavaScript-Code aus aufrufen. 

* Rufen Sie die statische Java-Methode wie hier angegeben auf und geben Sie für den direkten Verweis auf die Methode den vollständigen Klassennamen an. 

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* Wenn Sie die Instanzdefinitionsmethode verwenden, erstellen Sie eine Klasseninstanz, von der aus Sie die Instanzdefinitionsmethode aufrufen. 

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## Beispieladapter
{: #sample-adapter }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Maven-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }

* Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
den [JavaScript-HTTP-Adapter zu erstellen und zu implementieren](../../creating-adapters/). 
* Informationen zum Testen oder Debuggen eines Adapters enthält das Lernprogramm [Adapter testen und debuggen](../../testing-and-debugging-adapters). 

Beim Testen erwartet der Adapter ein Array mit Zahlen, die addiert oder subtrahiert werden sollen, z. B. `[1,2]`.
