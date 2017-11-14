---
layout: tutorial
title: Utilización de la API REST de analíticas
breadcrumb_title: API REST de analíticas
relevantTo: [ios,android,cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

{{ site.data.keys.mf_analytics_full }} proporciona determinadas API REST para ayudar a los desarrolladores con la importación (POST) y exportación (GET) de los datos de las analíticas. 

## Ir a: 
{: #jump-to }

* [API REST de analíticas](#analytics-rest-api)
* [Pruébelo en Swagger Docs](#try-it-out-on-swagger-docs)

## API REST de analíticas
{: #analytics-rest-api }

Para utilizar las API REST de analíticas:


**URL base**

`/analytics-service/rest`

**Ejemplo**

`https://example.com:9080/analytics-service/v3/applogs`


Método API REST | Punto final| Descripción
--- | --- | ---
Registros de aplicación (POST) | /v3/applogs | Crea un nuevo registro de aplicación. 
Sesión de aplicación (POST) | /v3/appsession | Crea una sesión de aplicación o actualiza una existente al informar con el mismo appSessionID.
Genérico (POST) | /v3/bulk | Sucesos de informes genéricos. 
Gráfico personalizado (GET)| /v3/customchart | Exporta todas las definiciones de gráfico personalizado. 
Gráfico personalizado (POST)| /v3/customchart/import | Importa una lista de gráficos personalizados.
Datos personalizados (POST) | /v3/customdata | Crea nuevos datos personalizados. 
Dispositivo (POST) | /v3/device | Crea o actualiza un dispositivo.
Exportar datos (GET) | /v3/export | Exporta datos en el formato de datos especificado. 
Transacción de red (POST) | /v3/networktransaction |  Crea un nueva transacción de red.
Registro de servidor (POST) | /v3/serverlog | Crea un nuevo registro de servidor.
Usuario (POST) | /v3/user | Crea un nuevo usuario. 

## Pruébelo en Swagger Docs
{: #try-it-out-on-swagger-docs }

Pruebe las API REST de analíticas en Swagger Docs.  
En una configuración de {{ site.data.keys.mf_server }} donde se haya habilitado las analíticas, visite `<ipaddress>:<port>/analytics-service`.

![Interfaz de usuario de {{ site.data.keys.mf_analytics }} Swagger Docs](analytics-swagger.png)

Pulsando en **Ampliar operaciones**, podrá ver notas de implementación, parámetros y mensajes de respuesta para cada método. 

> Aviso: Todos los datos que envíe mediante **Try it out!** 
podrían interferir con datos que ya estén en el almacén de datos. Si no está probando de forma específica enviar datos a su entorno de producción, utilice un nombre de prueba para la `x-mfp-analytics-api-key`.



![Probar Swagger Docs](test-swagger.png)
