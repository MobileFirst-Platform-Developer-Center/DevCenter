---
layout: tutorial
title: Conectar con microservicios utilizando el proxy de API
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Proxy de API
{: #dab-api-proxy }

Cuando se conecta con el programa de fondo de la empresa, puede beneficiarse de la seguridad y la analítica de la plataforma MobileFirst utilizando el proxy de API. Como sugiere el nombre, es un proxy que se puede utilizar como proxy sobre solicitudes en el programa de fondo real.

### Algunas de las ventajas del uso del proxy de API

* El host de fondo real no está expuesto a la aplicación móvil y se mantiene seguro en el servidor de MobileFirst. 
* Obtener los análisis de las solicitudes realizados en el programa de fondo

### ¿Cómo se utiliza el proxy de API?

1. Descargue el adaptador del proxy de API móvil desde la consola de Mobile Foundation.

    ![Proxy de API](dab-api-proxy.png)

2. Despliegue el adaptador del proxy de API en el servidor de Mobile Foundation.

3. Configure el URI de programa de fondo en la configuración del adaptador de proxy de API. El URI debe tener el formato `protocolo:host:puerto/contexto/`. Por ejemplo, `http://secure-backend/basecontext/`.
4. Realice las solicitudes al programa de fondo con la `API WLResourceRequest`. Utilice el fragmento de código de llamada a la API desde la sección **MOBILE CORE**. Altere el objeto de opciones para establecer la clave `useAPIProxy` en true. 

    Ejemplo:
    ```
    var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
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
