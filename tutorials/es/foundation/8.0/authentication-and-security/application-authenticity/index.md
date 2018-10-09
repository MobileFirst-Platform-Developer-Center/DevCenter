---
layout: tutorial
title: Autenticidad de aplicación
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Para asegurar la aplicación de manera apropiada, habilite la [comprobación de seguridad](../#security-checks) de autenticidad de aplicación de {{ site.data.keys.product_adj }} predefinida (`appAuthenticity`). Cuando esté habilitada, la verificación valida la autenticidad de la aplicación antes de proporcionarle un servicio. Las aplicaciones en un entorno de producción deberían tener esta característica habilitada.

Para habilitar la autenticidad de aplicación, puede seguir las instrucciones que se muestran en pantalla en **{{ site.data.keys.mf_console }}** → **[su-applicación]** → **Authenticidad**, o revisar la información siguiente.

#### Disponibilidad
{: #availability }
* La autenticidad de aplicación está disponible en todas las plataformas soportadas (iOS, Android, Windows 8.1 Universal, Windows 10 UWP) en las aplicaciones nativas y en Cordova.

#### Limitaciones
{: #limitations }
* La autenticidad de aplicación no da soporte a **Bitcode** en iOS. Por lo tanto, antes de utilizar la autenticidad de aplicación, inhabilite Bitcode en las propiedades de proyecto de Xcode.

#### Ir a:
{: #jump-to }
- [Flujo de la autenticidad de aplicación](#application-authenticity-flow)
- [Habilitación de la autenticidad de aplicación](#enabling-application-authenticity)
- [Configuración de la autenticidad de aplicación](#configuring-application-authenticity)
- [BTS (Build Time Secret)](#bts)
- [Resolución de problemas](#troubleshooting)
  - [Restablecer](#reset)
  - [Tipos de validación](#validation)
  - [Soporte para las versiones SDK 8.0.0.0-MFPF-IF201701250919 o anteriores](#legacy)

## Flujo de la autenticidad de aplicación
{: #application-authenticity-flow }
La comprobación de seguridad de autenticidad de aplicación se ejecuta durante el registro de la aplicación en {{ site.data.keys.mf_server }}, que la primera vez produce una instancia de los intentos de la aplicación de conectarse al servidor. De forma predeterminada, la verificación de autenticidad no se ejecuta de nuevo.

Una vez habilitada la autenticidad de aplicaciones y si el cliente necesita introducir cambios en su aplicación, la versión de la aplicación necesitará actualizarse.

Consulte [Configuración de la autenticidad de aplicación](#configuring-application-authenticity) para conocer más sobre como personalizar este comportamiento.

## Habilitación de la autenticidad de aplicación
{: #enabling-application-authenticity }
Para que la autenticidad de aplicación se habilite en su aplicación:

1. Abra {{ site.data.keys.mf_console }} en su navegador favorito.
2. Seleccione la aplicación de la barra lateral de navegación y pulse el elemento de menú **Autenticidad**.
3. Conmute el botón **Activado/desactivado** en el recuadro **Estado**.

![Habilitación de la autenticidad de aplicación](enable_application_authenticity.png)

MobileFirst Server valida la autenticidad de aplicación en el primer intento por conectarse al servidor. Para aplicar esta validación también a recursos protegidos, añada la comprobación de seguridad `appAuthenticity` al ámbito de protección.

### Inhabilitación de la autenticidad de aplicación
{: #disabling-application-authenticity }
Es posible que algunas modificaciones en la aplicación durante el desarrollo causen fallos en la validación de la autenticidad. Por consiguiente, se recomienda inhabilitar la autenticidad de aplicación durante el proceso de desarrollo. Las aplicaciones en un entorno de producción deberían tener esta característica habilitada.

Para inhabilitar la autenticidad de aplicación, vuelva a conmutar el botón **Activado/desactivado** en el recuadro **Estado**.

## Configuración de la autenticidad de aplicación
{: #configuring-application-authenticity }
De forma predeterminada, la autenticidad de aplicación se comprueba solo durante el registro del cliente. Sin embargo, igual que con cualquier otra comprobación de seguridad, puede decidir si desea proteger la aplicación o los recursos con la comprobación de seguridad `appAuthenticity` en la consola, siguiendo las instrucciones de [Protección de recursos](../#protecting-resources).

Puede configurar la comprobación de seguridad de autenticidad de aplicación predefinida con las propiedades siguientes:

- `expirationSec`: Tiene como valor predeterminado 3600 segundos / 1 hora. Defina la duración hasta que la señal de autenticidad caduca.

Después de que se haya completado la verificación de autenticidad, no se vuelve a producir hasta que se caduca la señal en función del valor definido.

#### Para configurar la propiedad `expirationSec`:
{: #to-configure-the-expirationsec property }
1. Cargue {{ site.data.keys.mf_console }}, navegue a **[su aplicación]** → **Seguridad** → **Configuraciones de comprobación de seguridad**, y pulse **Nueva**.

2. Busque el elemento de ámbito `appAuthenticity`.

3. Defina un nuevo valor en segundos.

![Configuración de la propiedad expirationSec en la consola](configuring_expirationSec.png)

## BTS (Build Time Secret)
{: #bts }
BTS (Build Time Secret) es una **herramienta opcional para mejorar la validación de autenticidad** solo para las aplicaciones de iOS. La herramienta inyecta la aplicación con un secreto determinado en el momento de la compilación, que se utiliza más adelante en el proceso de validación de autenticidad.

La herramienta BTS puede descargarse en el **{{ site.data.keys.mf_console }}** → **Centro de descargas**.

Para utilizar la herramienta BTS en Xcode:
1. En el separador **Fases de compilación** pulse el botón **+** y cree una nueva **Fase de script de ejecución**.
2. Copie la vía de acceso de la herramienta BTS y péguela en la nueva "Fase de script de ejecución" que ha creado.
3. Arrastre la fase de script de ejecución sobre la fase **Compilar fuentes**.

La herramienta debería utilizarse al construir una versión de producción de la aplicación.

## Resolución de problemas
{: #troubleshooting }

### Restablecer
{: #reset }
El algoritmo de la autenticidad de aplicación utiliza los datos y metadatos de aplicación para la validación. El primer dispositivo en conectarse al servidor después de habilitar la autenticación de aplicación, proporciona una "huella" de la aplicación, que contiene parte de los datos.

Es posible restablecer esta huella y proporcionar nuevos datos al algoritmo. Esto puede resultar de utilidad durante el desarrollo (por ejemplo, después de modificar la aplicación en Xcode). Para restablecer la huella, utilice el mandato **restablecer** en la CLI [**mfpadm**](../../administering-apps/using-cli/).

Después de restablecer la huella, la comprobación de seguridad appAuthenticity continua trabajando como lo hacía al principio (esto será completamente transparente para el usuario).

### Tipos de validación
{: #validation }

Mobile First Platform Foundation proporciona autenticidad de aplicaciones estática y dinámica para las aplicaciones. Estos tipos de validaciones difieren del algoritmo y de los atributos utilizados para generar semillas de autenticidad de aplicaciones. De forma predeterminada, cuando la autenticidad de aplicación está habilitada, utiliza el algoritmo de validación **dinámico**. Ambos tipos de validación garantizan la seguridad de la aplicación. La autenticidad de aplicaciones dinámica utiliza validaciones y comprobaciones estrictas para la autenticidad de aplicaciones. Para la autenticidad de aplicaciones estática, utilizamos el algoritmo ligeramente relajado, que no utilizará todas las comprobaciones de validación que se utilizan en la autenticidad de aplicaciones dinámica.

La autenticidad de aplicaciones dinámica se puede configurar desde la consola de MobileFirst. El algoritmo interno cuida la generación de los datos de autenticidad de aplicaciones basadas en las opciones elegidas en la consola.
Para la autenticidad de aplicaciones estática, se necesita utilizar la [CLI de **mfpadm**](../../administering-apps/using-cli/).

Para habilitar la autenticidad de aplicaciones estática y para conmutar entre tipos de validación, utilice la [CLI de **mfpadm**](../../administering-apps/using-cli/):

```bash
mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```
`TYPE` puede ser `dinámica` o `estática`.

### Soporte para las versiones SDK 8.0.0.0-MFPF-IF201701250919 o anteriores
{: #legacy }
Solo los clientes SDK publicados en **febrero de 2017 o posterior** dan soporte a los tipos de validación dinámica o estática. Para las versiones de SDK **8.0.0.0-MFPF-IF201701250919 o anteriores**, utilice la herramienta de autenticación de aplicación existente:

El archivo binario de aplicación debe estar firmado utilizando la herramienta mfp-app-autenticity. Los archivos binarios elegibles son: `ipa` para iOS, `apk` para Android, y `appx` para Windows 8.1 Universal y Windows 10 UWP.

1. Descargue la herramienta mpf-app-authenticity en el **{{ site.data.keys.mf_console }} → Centro de descargas**.
2. Abra una ventana **Línea de mandatos** y ejecute el mandato: `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file`

   Por ejemplo:

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   Este mandato genera un archivo `.authenticity_data` llamado `MyBankApp.authenticity_data`, junto al archivo `MyBankApp.ipa`.
3. Cargue el archivo `.authenticity_data` utilizando la CLI [**mfpadm**](../../administering-apps/using-cli/):
  ```bash
  app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-data FILE
  ```
