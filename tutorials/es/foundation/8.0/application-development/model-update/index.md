---
layout: tutorial
title: Uso de Model Update en aplicaciones
breadcrumb_title: Model Update
relevantTo: [iOS]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Con la introducción de modelos de aprendizaje automático (ML) en dispositivo, tales como CoreML y TensorFlow Lite, ahora las aplicaciones móviles pueden llevar a cabo operaciones de ML como el reconocimiento de imágenes, voz a texto, etc., en el dispositivo incluso cuando éste se encuentra fuera de línea. Una característica importante de un modelo de aprendizaje automático es que evoluciona continuamente. Actualizar estos modelos con sus versiones más recientes en un dispositivo se convierte algo extremadamente crucial para el éxito de una aplicación móvil. 

Para ayudar con este requisito, IBM Mobile Foundation presenta la característica Model Update. Ahora las aplicaciones de Mobile Foundation pueden incluir modelos de ML que pueden actualizarse "a través del aire" con versiones actualizadas. Las organizaciones pueden por lo tanto asegurarse de que los usuarios finales siempre tendrán la última versión de los modelos de IA.

Comprima los modelos más recientes en formato zip para enviar la versión del modelo a una aplicación. Este `.zip` debe cargarse bajo el separador **Aprendizaje automático** de la consola de Operaciones de MobileFirst. A continuación se activará la actualización del modelo cuando la aplicación invoque la API `downloadModelUpdate`.

>**Plataformas soportadas:** Actualmente, Model Update solamente está soportado para iOS.  

### Puntos a tener en cuenta
{: #notes }
* Model Update actualiza solamente los modelos de inteligencia artificial como CoreML de Apple o TensorFlow de Google.

#### Ir a:
{: #jump-to}

- [Como funciona Model Update](#how-model-update-works)
- [Creación y despliegue de paquetes de modelo actualizados](#creating-and-deploying-model-packages)
- [Invocación de una actualización](#invoking-an-update)

## Como funciona Model Update
{: #how-model-update-works }
Los modelos inicialmente se empaquetan con la aplicación para asegurar primero una disponibilidad fuera de línea. Después, la aplicación comprueba si hay actualizaciones en cada solicitud a {{ site.data.keys.mf_server }} donde se invoque la API `downloadModelUpdate`.

Después de una actualización de modelo, la API `downloadModelUpdate` devuelve la ubicación del modelo descargado y esta ubicación se actualiza siempre que se realiza una actualización.

### Creación de versiones
{: #versioning }
Una actualización de Model Update se aplica únicamente a una versión específica de la aplicación. En otras palabras, las actualizaciones generadas para una aplicación con la versión 2.0 no se pueden aplicar a otra versión de la misma aplicación.

## Creación y despliegue de modelos de paquete actualizados
{: #creating-and-deploying-model-packages }
Cuando está disponible una versión más nueva o actualizada del modelo, siga los pasos siguientes para cargar el archivo de modelo al {{ site.data.keys.mf_server }}.

### Pasos:

 1. Cree un archivo `.zip` de uno o más archivos de modelo de aprendizaje automático (por ejemlpo, `.mlmodel` ).
 2. Abra la {{ site.data.keys.mf_console }} y pulse en la entrada de la aplicación en el panel izquierdo.
 3. Navegue hasta el separador **Aprendizaje automático** y pulse en **Cargar archivo de modelo** para cargar los modelos empaquetados.

## Invocación de una actualización
{: #invoking-an-update }
La actualización del modelo de la aplicación puede comprobarse invocando la API siguiente.

### iOS

```
 WLClient.sharedInstance().downloadModelUpdate(completionHandler: CompletionHandler, showProgressBar: Boolean);
```

>**Nota:** Esta API no debe invocarse de manera simultánea con la API `ObtainAccessToken` ni con `WLResourceRequest`.

Normalmente los desarrolladores deben llamar a esta API durante el inicio de la aplicación.

La API `downloadModelUpdate` devuelve uno de los siguientes códigos de estado y un enlace al paquete descargado, si la descarga tiene éxito, o se devuelve la vía de acceso al paquete descargado previamente.

El estado final será uno de los códigos siguientes:

| Código de estado | Descripción |
|-------------|-------------|
| `SUCCESS` | La actualización del modelo finalizó sin errores. |
| `CANCELED` | La actualización del modelo se ha cancelado. |
| `FAILURE_NETWORK_PROBLEM` | Se produjo un problema con una conexión de red durante la actualización. |
| `FAILURE_DOWNLOADING` | El archivo no se ha descargado completamente. |
| `FAILURE_NOT_ENOUGH_SPACE` | No hay espacio suficiente en el dispositivo para descargar y desempaquetar el archivo de actualización. |
| `FAILURE_UNZIPPING` | Se ha producido un problema desempaquetar el archivo de actualización. |
| `FAILURE_ALREADY_IN_PROGRESS` | Se ha solicitado una actualización cuando ya había otra en curso. |
| `FAILURE_INTEGRITY` | No se ha podido verificar el archivo de actualización. |
| `FAILURE_UNKNOWN` | Error interno inesperado. |


## Model Update seguro
{: #secure-model-update }
Inhabilitado de forma predeterminada, Model Update Seguro impide que un atacante de terceros modifique los modelos que se transmiten desde {{ site.data.keys.mf_server }} (o desde una red de entrega de contenidos) a la aplicación cliente.

### Para habilitar la autenticación de Model Update:
Con la ayuda de su herramienta preferida, extraiga la clave pública del almacén de claves de {{ site.data.keys.mf_server }} y conviértala a base64.  
El valor generado se debería utilizar entonces tal como se indica a continuación:

1. En la aplicación cliente, abra el archivo de configuración de MobileFirst (por ejemplo, `mfpclient.plist` para iOS y `mfpclient.properties` para Android).
2. Añada el nuevo valor de clave llamado `wlSecureModelUpdatePublicKey`.
3. Proporcione la clave pública para el valor de clave correspondiente y guarde el archivo.

Cualquier entrega futura de Model Update a aplicaciones de cliente estarán protegidas mediante la autenticidad de Model Update.

> Para configurar el servidor de aplicaciones con el archivo del almacén de claves actualizado, consulte [Implementación de Model Update seguro](secure-model-update/)

### Model Update en las fases de desarrollo, pruebas y producción
A efectos de desarrollo y pruebas, los desarrolladores habitualmente utilizarán Model Update simplemente subiendo un archivador al servidor de desarrollo. Todo y que este proceso es fácil de implementar, no es muy seguro ylos modelos pueden ser manipulados indebidamente durante el tránsito o bien después de descargarse en el dispositivo.

Para la fase de producción, o incluso para la de pruebas de pre-producción, se recomienda encarecidamente implementar Model Update seguro antes de publicar la aplicación en la tienda de aplicaciones. Model Update seguro requiere una pareja de claves RSA extraídas de un certificado de servidor firmado por una autoridad de certificación.

>**Nota:**
Hay que proceder con precaución para no modificar la configuración del almacén de claves después de que se haya publicado la aplicación, con una nueva clave pública las actualizaciones que se descargan ya no se podrán autenticar sin volver a configurar la aplicación y será necesario volver a publicar la aplicación. Sin estos pasos, Model Update fallará en el cliente.

> Obtenga más información en [Model Update seguro](secure-model-update/).

### Velocidades de transferencia de Model Update
En condiciones óptimas, una instancia de {{ site.data.keys.mf_server }} individual puede enviar datos a los clientes a una velocidad de 250 MB por segundo. Si son necesarias velocidades más elevadas, considere la posibilidad de utilizar un clúster o un servicio de una CDN.
