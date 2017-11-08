---
layout: tutorial
title: Utilización de Java en adaptadores JavaScript
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Cuando JavaScript no es suficiente para implementar la funcionalidad necesaria, o si una clase Java ya existe, puede utilizar código Java como una extensión para el adaptador JavaScript. 

**Requisito previo:** Asegúrese de leer primero la guía de aprendizaje [Adaptadores JavaScript](../).


## Adición de clases Java personalizadas 
{: #adding-custom-java-classes }

![UsingJavainJS](UsingJavainJS.png)

Para utilizar una biblioteca Java existente, añada el archivo JAR como una dependencia para el proyecto.  Para obtener más información sobre cómo añadir una dependencia, consulte la sección de Depencias en la guía de aprendizaje [Creación de adaptadores Java y JavaScript](../../creating-adapters/#dependencies).


Para añadir código Java personalizado al proyecto, añada una carpeta denominada **java** a la carpeta **src/main** en su proyecto de adaptador y coloque en ella su paquete. En el ejemplo de esta guía de aprendizaje se utiliza un paquete `com.sample.customcode` y un archivo de clase Java denominado `Calculator.java`.    

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** El nombre del paquete debe empezar con `com`, `org` o `net`.
Adición de métodos a su clase de Java.   
A continuación se muestran ejemplos de un método estático (que no precisa una nueva instancia) y un método de instancia: 

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

## Invocación de clases Java personalizadas desde el adaptador 
{: #invoking-custom-java-classes-from-the-adapter }

Después de haber creado su código Java personalizado y de haber añadido todos los archivos JAR necesarios, puede llamarlo desde el código JavaScript: 

* Invoque al método Java estático tal como se muestra a continuación, y utilice el nombre de clase completo para hacer directamente referencia al mismo:  

```javascript
function addTwoIntegers(a,b){
    return {
        result: com.sample.customcode.Calculator.addTwoIntegers(a,b)
    };
}
```
  
* Para utilizar el método de instancia, crea una instancia de la clase e invoque al método de la instancia desde la misma: 

```javascript
function subtractTwoIntegers(a,b){
    var calcInstance = new com.sample.customcode.Calculator();   
    return {
        result : calcInstance.subtractTwoIntegers(a,b)
    };
}
```

## Adaptador de ejemplo
{: #sample-adapter }

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) el proyecto Maven.


### Uso de ejemplo 
{: #sample-usage }

* Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar el adaptador JavaScriptHTTP](../../creating-adapters/).

* Para probar o depurar un adaptador, consulte la guía de aprendizaje [Pruebas y depuración de adaptadores](../../testing-and-debugging-adapters).


Al realizar pruebas, el adaptador espera una matriz con valores numéricos para añadir o sustraer, por ejemplo:
`[1,2]`.
