---
layout: tutorial
title: Adición de MobileFirst Foundation SDK a aplicaciones Web
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Desarrolle aplicaciones web de {{ site.data.keys.product_adj }} de escritorio o móviles mediante sus herramientas y entornos de desarrollo preferidos.
  
En esta guía de aprendizaje, aprenderá a añadir {{ site.data.keys.product_adj }} Web SDK a su aplicación web, así como registrar la aplicación web con {{ site.data.keys.mf_server }}

{{ site.data.keys.product_adj }} Web SDK se proporciona como un conjunto de archivos JavaScript. El SDK [está disponible en NPM](https://www.npmjs.com/package/ibm-mfp-web-sdk).   
El SDK incluye los siguientes archivos:


- **ibmmfpf.js** - El núcleo del SDK.
- **ibmmfpfanalytics.js** - Proporciona soporte para {{ site.data.keys.mf_analytics }}.


#### Ir a 
{: #jump-to }
- [Requisitos previos](#prerequisites)
- [Adición de {{ site.data.keys.product_adj }} Web SDK](#adding-the-mobilefirst-web-sdk)
- [Inicialización de {{ site.data.keys.product_adj }} Web SDK](#initializing-the-mobilefirst-web-sdk)
- [Registro de la aplicación web](#registering-the-web-application)
- [Actualización de {{ site.data.keys.product_adj }} Web SDK](#updating-the-mobilefirst-web-sdk)
- [Política de mismo origen](#same-origin-policy)
- [Política de orígenes seguros](#secure-origins-policy)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Requisitos previos
{: #prerequisites }
-   Consulte el requisito previo de [navegadores web soportados](../../../installation-configuration/development/web/#web-app-supported-browsers) para configurar el entorno de desarrollo web.


-   Para ejecutar mandatos NPM, debe instalar [Node.js](https://nodejs.org).

## Adición de {{ site.data.keys.product_adj }} Web SDK
{: #adding-the-mobilefirst-web-sdk }
Para añadir el SDK a aplicaciones web nuevas o existentes, descárguelo primero en su estación de trabajo y, a continuación, añádalo a su aplicación web.


### Descarga del SDK 
{: #downloading-the-sdk }
1. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz de su aplicación web.

2. Ejecute el mandato: `npm install ibm-mfp-web-sdk`.

Este mandato crea la siguiente estructura de directorios:

![Contenido de la carpeta SDK](sdk-folder.png)

### Adición del SDK
{: #adding-the-sdk }
Para añadir {{ site.data.keys.product }} Web SDK, haga referencia al mismo de forma estándar en la aplicación web.
  
El SDK también [da soporte a AMD](https://en.wikipedia.org/wiki/Asynchronous_module_definition), de forma que es posible utilizar cargadores de módulos como, por ejemplo, [RequireJS](http://requirejs.org/) para cargar el SDK.


#### Estándar
Haga referencia al archivo **ibmmfpf.js** en el elemento `HEAD`.
  

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

#### Utilización de RequireJS

**HTML**  

```html
<script type="text/javascript" src="node_modules/requirejs/require.js" data-main="index"></script>
```

**JavaScript**

```javascript
require.config({
	'paths': {
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['mfp'], function(WL) {
    // application logic.
});
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** Si está añadiendo el soporte para las analíticas, coloque la referencia al archivo **ibmmfpfanalytics.js** **antes** de la referencia al archivo **ibmmfpf.js**.


## Inicialización de {{ site.data.keys.product_adj }} Web SDK
{: #initializing-the-mobilefirst-web-sdk }
Inicialización de {{ site.data.keys.product }} Web SDK especificando los valores de **raíz de contexto** y el **ID de aplicación** en el archivo JavaScript principal de su aplicación web:


```javascript
var wlInitOptions = {
    mfpContextRoot : '/mfp', // "mfp" is the default context root in the {{ site.data.keys.product }}
    applicationId : 'com.sample.mywebapp' // Replace with your own value.
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Application logic.
});
```

- **mfpContextRoot:** Raíz de contexto que {{ site.data.keys.mf_server }} utilizará.

- **applicationId:** Nombre del paquete de la aplicación, tal como la definió al [registrar la aplicación](#registering-the-web-application).

### Registro de la aplicación web
{: #registering-the-web-application }
Las aplicaciones se pueden registrar desde {{ site.data.keys.mf_console }} o desde {{ site.data.keys.mf_cli }}.


#### Desde {{ site.data.keys.mf_console }}
{: #from-mobilefirst-operations-console }
1. Abra su navegador preferido y cargue {{ site.data.keys.mf_console }} especificando el URL `http://localhost:9080/mfpconsole/`.

2. Pulse el botón **Nuevo** junto a **Aplicaciones** para crear una nueva aplicación.

3. Seleccione **Web** como plataforma y proporcione un nombre y un identificador.

4. Pulse **Registrar aplicación**.

![Adición de la plataforma web](add-web-platform.png)

#### Desde {{ site.data.keys.mf_cli }}
{: #from-mobilefirst-cli }
Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz de la aplicación web y ejecute el mandato: `mfpdev app register`.

## Actualización de {{ site.data.keys.product_adj }} Web SDK
{: #updating-the-mobilefirst-web-sdk }
Los releases de SDK se pueden encontrar en el [repositorio NPM ](https://www.npmjs.com/package/ibm-mfp-web-sdk) de SDK.
  
Para actualizar {{ site.data.keys.product_adj }} Web SDK con el último release:


1. Vaya a la carpeta raíz de la aplicación web.
2. Ejecute el mandato: `npm update ibm-mfp-web-sdk`.

## Política del mismo origen
{: #same-origin-policy }
Si los recursos web están alojados en una máquina de servidor diferente de la máquina en la que {{ site.data.keys.mf_server }} está instalado, se desencadena un incumplimiento de [política del mismo origen](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy).
El modelo de seguridad de política del mismo origen se ha diseñado para protegerse con relación a posibles amenazas de seguridad desde orígenes no verificados.
De acuerdo a esta política, un navegador permite a recursos web (como, por ejemplo, scripts) interactuar solo con los recursos provenientes del mismo origen (que se define como una combinación de esquema de URI, un nombre de host y un número de puerto).
Para obtener más información sobre la política del mismo origen, consulte la especificación del [Concepto de origen web](https://tools.ietf.org/html/rfc6454), y específicamente los [3. Principios de la política del mismo origen](https://tools.ietf.org/html/rfc6454#section-3).

Las aplicaciones web que utilizan {{ site.data.keys.product_adj }} Web SDK deben trabajar en una topología de soporte.
Por ejemplo, utilizando un proxy inverso para redirigir de forma interna las solicitudes al servidor apropiado manteniendo el mismo origen individual.


### Alternativas
{: #alternatives }
Puede satisfacer los requisitos de política utilizando cualquiera de los siguientes métodos:


- Sirviendo recursos de aplicación web, por ejemplo, desde el mismo servidor de aplicaciones de perfil WebSphere Application Server Liberty que se utiliza en {{ site.data.keys.mf_dev_kit_full }}.

- Utilizando Node.js como un proxy inverso para redirigir solicitudes de aplicación de {{ site.data.keys.mf_server }}.


> Obtenga más información en la guía de aprendizaje [Configuración del entorno de desarrollo web](../../../installation-configuration/development/web)

## Política de orígenes seguros
{: #secure-origins-policy }
Al utilizar Chrome durante el desarrollo, el navegador podría no permitir que una aplicación se cargase utilizando HTTP y un host que **no fuese** `localhost`.
La razón se encuentra en que la política de orígenes seguros está implementada y utilizada de forma predeterminada en este navegador.


Para solucionar esto, inicie el navegador Chrome con el siguiente distintivo:


```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- Sustituya "test-to-new-user-profile/myprofile" con la ubicación de una carpeta que actuará como un nuevo perfil de usuario de Chrome para que el distintivo funcione.


Para obtener más información sobre los orígenes seguros, consulte [este documento para desarrolladores de Chormium](https://www.chromium.org/Home/chromium-security/prefer-secure-origins-for-powerful-new-features).

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product_adj }} Web SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
