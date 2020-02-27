---
layout: tutorial
title: Utilización de las API ReST de simulación 
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## API de simulación 
{: #dab-mock-api }

Normalmente, durante el desarrollo de una aplicación móvil, el servidor de fondo desde el que se han de capturar los datos no estará totalmente disponible para los desarrolladores de móviles. En estos casos, puede resultar útil que esté disponible un servidor de simulación que devuelva los mismos datos que el servidor de fondo. La característica de API de simulación en Digital App Builder ayuda en este tema. El desarrollador de aplicaciones móviles puede simular fácilmente el servidor simplemente proporcionando datos JSON. 

>**Nota**: Esta característica solo está disponible en modalidad de código. 

Para crear y gestionar las API con las que simular servicios REST de fondo: 

1. Abra su proyecto de aplicación en modalidad de código  
2. Seleccione **API**. Pulse **Añadir una API**.
    ![API de simulación](dab-mock-api.png)

3. En la ventana que se abre, escriba un nombre para la API y pulse **Añadir**.
    ![Añadir API de simulación](dab-new-mock-api.png)

4. Esto mostrará la API que ha creado con el URL generado automáticamente.
    ![Jason de API de simulación](dab-new-mock-api-jason.png)

5. Pulse **Editar**. Proporcione los datos que desea que se devuelvan cuando se invoca esta API y pulse **Guardar**. Por ejemplo, 

    ```
    [
      {
        "firstName": "John",
        "lastName": "Doe",
        "title": "Director of Marketing",
        "office": "D531"
      },
      {
        "firstName": "Don",
        "lastName": "Joe",
        "title": "Vice President,Sales",
        "office": "B2600"
      }
    ]
    ```

    ![Ejemplo de jason de API de simulación](dab-exp-moc-api.png)

>**Nota**: Para probar rápidamente la API, pulse **Probar ahora ** y se abrirá la documentación de Swagger en su navegador predeterminado donde puede probar sus API. 

### Consumo de las API de simulación en la aplicación 
{: #dab-mock-api-consuming }

1. En la modalidad de código, arrastre y suelte el fragmento de código **Llamada de API** desde la sección **MOBILE CORE**. 
2. Edite el código para modificar el URL y apunte al punto final de la API de simulación. Por ejemplo, 

    ```
     var resourceRequest = new WLResourceRequest(
         "/adapters/APIProject/api/entity4",
         WLResourceRequest.GET,
         { "useAPIProxy": false }
     );
     resourceRequest.send().then(
         function(response) {
             alert("Success: " + response.responseText);
         },
         function(response) {
             alert("Failure: " + JSON.stringify(response));
         }
     );
    ```
 
