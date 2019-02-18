---
layout: tutorial
title: Clientes confidenciales
relevantTo: [android,ios,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Las aplicaciones móviles puede utilizar los SDK de cliente de {{ site.data.keys.product_adj }} para realizar una solicitud de acceso a los recursos protegidos.  
También lo pueden hacer otras entidades que no sean aplicaciones móviles. Dichas entidades se consideran **Clientes confidenciales**.

Los clientes confidenciales son clientes capaces de mantener la confidencialidad de las credenciales de autenticación. Puede utilizar el servidor de autorización de {{ site.data.keys.product_adj }} para garantizar el acceso de clientes confidencial a recursos protegidos, de acuerdo con la especificación OAuth. Esta característica le permite acceder a los recursos de clientes no móviles como, por ejemplo, las aplicaciones de pruebas de rendimiento y cualquier otro tipo de fondo que necesite una solicitud a un recurso protegido o utilice una de las **API REST** de {{ site.data.keys.product }} como, por ejemplo, la API REST para las **notificaciones push**.

Empiece con registrar un cliente confidencial con {{ site.data.keys.mf_server }}. Como parte del registro, proporcione las credenciales del cliente confidencial, que consisten en un ID y un secreto. Además, defina el ámbito permitido del cliente, que determina los ámbitos que se pueden conceder al cliente. Cuando un cliente confidencial registrado solicita una señal de acceso del servidor de autorización, el servidor autentica el cliente utilizando las credenciales registradas y verifica que el ámbito solicitado coincide con el ámbito permitido del cliente.

Los clientes confidenciales registrados pueden obtener una señal para utilizarla en todas las solicitudes en {{ site.data.keys.mf_server }}. Este flujo se basa en el [flujo de credenciales de cliente ](https://tools.ietf.org/html/rfc6749#section-1.3.4) de la especificación OAuth. Tenga en cuenta que la señal de acceso para un cliente confidencial es válida durante una hora. Si utiliza un cliente confidencial para una tarea que dura más de una hora, renueve la señal cada hora enviando una solicitud de señal nueva.

## Registro del cliente confidencial
{: #registering-the-confidential-client }
En la barra de navegación de {{ site.data.keys.mf_console }}, pulse **Valores de entorno de ejecución** → **Clientes confidenciales**. Pulse **Nuevo** para añadir una nueva entrada.  
Debe proporcionar la información siguiente:

- **Nombre de visualización**: Se utiliza un nombre de visualización opcional para hacer referencia al cliente confidencial. El nombre de visualización predeterminado es el valor del parámetro de ID. Por ejemplo: **Servidor de nodo de fondo**.
- **ID**: Un identificador único para el cliente confidencial (puede considerarse como "nombre de usuario").
  El ID solo puede contener caracteres ASCII.
- **Secreto**: Una contraseña privada que permite autorizar el acceso del cliente confidencial (puede considerarse una clave de API).
  El secreto solo puede contener caracteres ASCII.
- **Ámbito permitido**: Al cliente confidencial que utiliza esta combinación de ID y secreto se le concede de forma automática el ámbito que se define aquí. Para obtener más información acerca de los ámbitos, consulte [Ámbitos](../#scopes).
    - Un elemento de un ámbito permitido puede incluir el carácter comodín asterisco especial (`*`), que representa cualquier secuencia de cero o más caracteres. Por ejemplo, si el elemento de ámbito es `send*`, el cliente confidencial puede acceder a los ámbitos que contiene cualquier elemento de ámbito que empieza con "send" como, por ejemplo, "sendMessage". El comodín asterisco puede colocarse en cualquier posición en el elemento de ámbito, y también puede aparecer más de una vez. 
    - Un parámetro de ámbito permitido que consiste en un único carácter asterisco (*) indica que el cliente confidencial puede conceder una señal para cualquier ámbito.

**Ejemplos de ámbitos:**

- [Protección de recursos externos](../protecting-external-resources) utiliza el ámbito `authorization.introspect`.
- [El envío de una notificación push](../../notifications/sending-notifications) mediante la API REST utiliza los elementos de ámbito separados por espacios `messages.write` y `push.application.<applicationId>`.
- Un elemento de ámbito personalizado puede proteger a los adaptadores, como por ejemplo `accessRestricted`.
- El ámbito `*` es un ámbito general que concede acceso a cualquier ámbito solicitado.

<img class="gifplayer" alt="Configuración de un cliente confidencial" src="push-confidential-client.png"/>

## Clientes confidenciales predefinidos
{: #predefined-confidential-clients }
{{ site.data.keys.mf_server }} tiene algunos clientes confidenciales predefinidos:

### test
{: #test }
El cliente `test` solo está disponible en modo de desarrollo. Le permite probar los recursos de forma sencilla.

- **ID**: `test`
- **Secreto**: `test`
- **Ámbito permitido**: `*` (cualquier ámbito)

### admin
{: #admin }
El servicio de administración de {{ site.data.keys.product }} utiliza el cliente `admin` de manera interna.

### push
{: #push }
El servicio de push de {{ site.data.keys.product }} utiliza el cliente `push` de manera interna.

## Obtención de una señal de acceso
{: #obtaining-an-access-token }
Se puede obtener una señal del {{ site.data.keys.mf_server }} **punto final de señal**.  

**Para realizar pruebas**, puede utilizar Postman tal y como se describe a continuación.  
En una situación real, implemente Postman en la lógica de fondo con la tecnología que desee.

1.  Realice una solicitud **POST** a **http(s)://[ipaddress-or-hostname]:[port]/[runtime]/api/az/v1/token**.  
    Por ejemplo: `http://localhost:9080/mfp/api/az/v1/token`
    - En un entorno de desarrollo, {{ site.data.keys.mf_server }} utiliza un tiempo de ejecución `mfp` preexistente.  
    - En un entorno de producción, sustituya el valor de tiempo de ejecución con el nombre de tiempo de ejecución.

2.  Establezca la solicitud con el tipo de contenido de `application/x-www-form-urlencoded`.  
3.  Establezca los dos parámetros de forma siguientes:
    - `grant_type` - Establezca el valor en `client_credentials`.
    - `scope` - Establezca el valor en un ámbito de protección del recurso. Si el recurso no se asigna a un ámbito de protección, omita este parámetro para aplicar el ámbito predeterminado (`RegisteredClient`). Para obtener más información, consulte [Ámbitos](../../authentication-and-security/#scopes).

       ![Imagen de configuración de postman](confidential-client-steps-1-3.png)

4.  Para autenticar la solicitud, utilice [Autenticación básica](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side). Utilice el **ID** y el **secreto** del cliente confidencial.

    ![Imagen de configuración de postman](confidential-client-step-4.png)

    Fuera de Postman, si utiliza el cliente confidencial **test**, establezca la **cabecera HTTP ** en `Authorization: Basic dGVzdDp0ZXN0` (`test:test` codificado utilizando **base64**).

La respuesta para esta solicitud incluirá un objeto `JSON`, entre otros, la **señal de acceso** y la hora de caducidad (1 hora).

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp ...",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "sendMessage accessRestricted"
}
```

![Creación de un cliente confidencial](confidential-client-access-token.png)

## Utilización de la señal de acceso
{: #using-the-access-token }
A partir de este momento, puede realizar solicitudes a los recursos deseados añadiendo la **cabecera HTTP**: `Authorization: Bearer eyJhbGciOiJSUzI1NiIsImp ...`, sustituyendo la señal de acceso por una de las extraídas del objeto JSON anterior.

## Respuestas posibles
{: #possible-responses }
Además de las respuestas normales que es posible que genere el recurso, estas son algunas de las respuestas que {{ site.data.keys.mf_server }} genera.

### Bearer
{: #bearer }
Un estado de respuesta HTTP **401** con la cabecera HTTP `WWW-Authenticate : Bearer` significa que no se ha encontrado ninguna señal en la cabecera `Authorization` de la solicitud original.

### invalid_token
{: #invalid-token }
Un estado de respuesta HTTP **401** con la cabecera HTTP `WWW-Authenticate: Bearer error="invalid_token"` significa que la señal que se ha enviado es **inválida** o ha **expirado**.

### insufficient_scope
{: #insufficient-scope }
Un estado de respuesta HTTP **403** con la cabecera HTTP `WWW-Authenticate : Bearer error="insufficient_scope", scope="RegisteredClient scopeA scopeB"` significa que la señal encontrada en la solicitud original no coincide con la señal que el recurso necesita. La cabecera también incluye el ámbito esperado.

Cuando emite una solicitud, si no sabe qué ámbito necesita el recurso, utilice `insufficient_scope` para determinar el ámbito necesario. Por ejemplo, solicite una señal sin especificar un alcance y realice una solicitud al recurso. A continuación, puede extraer el ámbito necesario de la respuesta 403 y solicitar una nueva señal para este ámbito.

