---
layout: tutorial
title: Validador de Node.js
breadcrumb_title: Node.js validator
relevantTo: [android,ios,windows,javascript]
weight: 3
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona una infraestructura Node.js para imponer funciones de seguridad en recursos externos.  
La infraestructura Node.js se proporciona como un módulo npm (**passport-mfp-token-validation**).

Este tutorial muestra cómo proteger un recurso de Node.js simple, `GetBalance`, utilizando un ámbito (`accessRestricted`).

**Requisitos previos:**  

* Lea la guía de aprendizaje [Utilización de {{ site.data.keys.mf_server }} para autenticar recursos externos](../).
* Comprensión de la [infraestructura de seguridad de {{ site.data.keys.product }}](../../).

## El módulo passport-mfp-token-validation
{: #the-passport-mfp-token-validation-module }
El módulo passport-mfp-token-validation proporciona un mecanismo de autenticación para verificar las señales de acceso emitidas por {{ site.data.keys.mf_server }}.

Para instalar el módulo, ejecute:

```bash
npm install passport-mfp-token-validation@8.0.X
```

## Utilización
{: #usage }
* El ejemplo utiliza los módulos `express` y `passport-mfp-token-validation`:

  ```javascript
  var express = require('express');
  var passport = require('passport-mfp-token-validation').Passport;
  var mfpStrategy = require('passport-mfp-token-validation').Strategy;
  ```

* Configure `Strategy` de la siguiente manera:

  ```javascript
  passport.use(new mfpStrategy({
    authServerUrl: 'http://localhost:9080/mfp/api',
    confClientID: 'testclient',
    confClientPass: 'testclient',
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
  }));
  ```
  
 * `authServerUrl`: Sustituya `localhost:9080` con la dirección IP y el número de puerto de {{ site.data.keys.mf_server }}.
 * `confClientID`, `confClientPass`: Sustituya el ID de cliente y la contraseña confidenciales por los que ha definido en {{ site.data.keys.mf_console }}.
 * `analytics`: El elemento de análisis es opcional, y solo es necesario si desea registrarse en sucesos analíticos en {{ site.data.keys.product }}.  
 Reemplace `localhost:9080`, `username`, and `password` con la dirección IP del servidor de análisis, el número de puerto, el nombre de usuario y la contraseña.

* Autentique las solicitudes llamando a `passport.authenticate`:

  ```javascript
  var app = express();
  app.use(passport.initialize());

  app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
      session: false,
      scope: 'accessRestricted'
  }),
  function(req, res) {
      res.send('17364.9');
  });

  var server = app.listen(3000, function() {
      var port = server.address().port
      console.log("Sample app listening at http://localhost:%s", port)
  });
  ```

 * En `Strategy` debería usar `mobilefirst-strategy`.
 * Establezca `session` en `false`.
 * Especifique el nombre `scope`.

## Aplicación de ejemplo 
{: #sample-application }
[Descargue el ejemplo Node.js](https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80).

### Uso de ejemplo
{: #sample-usage }
1. Navegue a la carpeta raíz del ejemplo y ejecute el mandato: `npm install` seguido de: `npm start`.
2. Asegúrese de [actualizar el cliente confidencial](../#confidential-client) y los valores secretos en {{ site.data.keys.mf_console }}.
3. Despliegue alguna de las comprobaciones de seguridad: **[UserLogin](../../user-authentication/security-check/)** o **[PinCodeAttempts](../../credentials-validation/security-check/)**.
4. Registre la aplicación coincidente.
5. Correlacione el ámbito `accessRestricted` en la comprobación de seguridad.
6. Actualice la aplicación de cliente para crear `WLResourceRequest` en su URL de servlet.
