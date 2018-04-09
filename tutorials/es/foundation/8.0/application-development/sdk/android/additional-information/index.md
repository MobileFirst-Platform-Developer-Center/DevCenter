---
layout: tutorial
title: Información adicional
breadcrumb_title: Additional info
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Registro de Javadocs para un proyecto de Android Studio Gradle 
{: #registering-javadocs-to-an-android-studio-gradle-project }
Los {{ site.data.keys.product_adj }} Android Javadocs están incluidos en los archivos *.aar que Gradle importa.
Sin embargo debe enlazarlos a la biblioteca relevante en Android Studio.

1. En Android Studio, asegúrese de que tiene la vista **Proyecto**.

2. Encuentre el nombre de la biblioteca bajo el nodo **Bibliotecas externas** (el archivo Javadoc aparece bajo el mismo).

3. Pulse con el botón derecho del ratón sobre el nombre de la biblioteca y seleccione **Propiedades de biblioteca**.
4. Desde el diálogo de Propiedades de biblioteca, seleccione el botón "+" 
5. Vaya hasta el archivo JAR Javadoc descargado (**ibmmobilefirstplatformfoundation-javadoc.jar**) bajo **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** y selecciónelo.

6. Pulse **Aceptar**. Los Javadocs estarán ahora disponibles en su proyecto.


### Notas
{: #notes }

* No es posible desactivar las API {{ site.data.keys.product_adj }} desde dentro de un servicio Android. 
