---
layout: tutorial
title: MobileFirst Server, mensajes de tiempo de ejecución y de la consola 
breadcrumb_title: Foundation Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Visión general
{: #overview }
Puede encontrar información para ayudarle a los problemas que pueda encontrar en Mobile Foundation Server.

## Mensajes de tiempo de ejecución de Mobile Foundation
{: #mfp-runtime-error-codes }
**Prefijo:** FWLSE<br/>
**Rango:** 0000-0012

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE0000E** | *No se ha podido almacenar AuthorizationGrant {0} en TransientStorage.* |
| **FWLSE0001E** | *No se ha podido recuperar el cliente {0}.* |
| **FWLSE0002E** | *Solicitud no válida, faltan parámetros o no son válidos: {0}.* |
| **FWLSE0003E** | *Tipo de concesión no válida {0}.* |
| **FWLSE0004E** | *Se ha pasado RedirectUri al punto final de autorización: {0}, pero no se ha pasado el punto final de señal.*                   |
| **FWLSE0005E** | *Conflicto de RedirectUri. Punto final de autorización: {0}, punto final de señal: {1}.*  |
| **FWLSE0006E** | *Error de análisis de código de concesión de solicitud de señal: {0}.* |
| **FWLSE0007E** | *Ha fallado la validación del código de concesión. Se ha proporcionado el código de concesión
{0} para clientId {1} pero se
ha utilizado clientId {2}.*  |
| **FWLSE0008E** | *Error de análisis de acción AccessToken con excepción.* |
| **FWLSE0009E** | *No se ha podido firmar la señal de acceso.* |
| **FWLSE0010E** | *No se ha podido validar JWT, error en el almacén de claves del servidor.* |
| **FWLSE0011E** | *No se ha podido validar JWT, {0}.* |
| **FWLSE0012E** | *Error de autenticación de JWT de cliente - Jti no válido.* |


### Mensajes del adaptador Java

**Prefijo:** FWLSE<br/>
**Rango:** 0290-0299

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE0290E** | *Clase de aplicación JAXRS: no se ha encontrado {0} (o no se ha podido cargar). Asegúrese de que el nombre de clase del archivo xml del adaptador sea correcto y que exista la clase en la carpeta bin del adaptador o en cualquier archivo jar de la carpeta lib del adaptador.* |
| **FWLSE0291E** | *Clase de aplicación JAXRS: no se puede crear una instancia de {0}.
Asegúrese de que la clase tenga un constructor de argumentos cero público. Si existe un constructor, consulte el registro del servidor para ver la causa raíz del error de creación de la instancia.* |
| **FWLSE0292E** | *Clase de aplicación JAXRS: {0} debe ampliar javax.ws.rs.Application.* |
| **FWLSE0293E** | *Error de despliegue de adaptador. El tipo de propiedad {0} no está soportado.* |
| **FWLSE0294E** | *Error de despliegue de adaptador. El valor {0} no está permitido para el tipo {1}.* |
| **FWLSE0295E** | *Error de despliegue de la configuración del adaptador. La propiedad {0} no está definida en el adaptador {1}.* |
| **FWLSE0296E** | *Error de despliegue de la configuración del adaptador. La propiedad {0} no es válida para el tipo {1}.* |
| **FWLSE0297W** | *Error al generar la documentación de Swagger para el adaptador {0}.* |
| **FWLSE0298W** | *El procedimiento {0} del adaptador {1} tiene establecido el adaptador 'connectAs' en 'enduser'. Esta característica no está soportada.* |
| **FWLSE0299E** | *Error de despliegue de la configuración de conexión del adaptador. No existen las propiedades {0}.* |


**Prefijo:** FWLSE<br/>
**Rango:** 0500-0506

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE0500E** | *Error de despliegue de la configuración de conexión del adaptador. El parámetro {0} debe ser un entero.* |
| **FWLSE0501E** | *Error de despliegue de la configuración de conexión del adaptador. El parámetro {0} debe ser positivo.* |
| **FWLSE0502E** | *Error de despliegue de la configuración de conexión del adaptador. El parámetro {0} está fuera de rango.* |
| **FWLSE0503E** | *Error de despliegue de la configuración de conexión del adaptador. El parámetro {0} debe ser booleano.* |
| **FWLSE0504E** | *Error de despliegue de la configuración de conexión del adaptador. El {0} debe ser http o https.* |
| **FWLSE0505E** | *Error de despliegue de la configuración de conexión del adaptador. La política de cookies {0} no está soportada.* |
| **FWLSE0506E** | *Error de despliegue de la configuración de conexión del adaptador. El parámetro {0} debe ser una serie.* |

### Mensajes de registro

**Prefijo:** FWLSE<br/>
**Rango:** 4200-4229

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE4200E** | *Error de cambio de estado de aplicación de dispositivo.* |
| **FWLSE4201E** | *Error al cambiar estado de dispositivo.* |
| **FWLSE4202E** | *Error al obtener dispositivo.* |
| **FWLSE4203E** | *Error al eliminar dispositivo.* |
| **FWLSE4204E** | *Error al obtener clientes asociados al dispositivo.* |
| **FWLSE4205E** | *Error de getAll para pageInfo: {0}.* |
| **FWLSE4206E** | *Error de GetByAttributes.* |
| **FWLSE4207E** | *No se pueden convertir los datos en datos persistentes.* |
| **FWLSE4208E** | *Error de lectura de cliente {0}.* |
| **FWLSE4209E** | *error al cambiar nombre de visualización de dispositivo.* |
| **FWLSE4210E** | *No se puede crear la firma.* |
| **FWLSE4211E** | *Error al almacenar los datos de registro del cliente porque no se ha recuperado correctamente. ID de cliente: {0}.* |
| **FWLSE4212E** | *error al actualizar el nombre de visualización de todos los clientes del dispositivo.* |
| **FWLSE4213E** | *Error de autenticación JWT de cliente - las claves públicas no coinciden.* |
| **FWLSE4214E** | *Los datos del cliente son nulo - esto puede ocurrir si se acaban de archivar (suprimir) los datos de cliente ahora.* |
| **FWLSE4215E** | *Después de varios intentos de acceso a la consola, se abandona. * |
| **FWLSE4216E** | *GetDeviceClientsError para deviceId: {0}.* |
| **FWLSE4217E** | *Error al intentar obtener dispositivos con pageStart: {0} y pageSize: {1}.* |
| **FWLSE4218E** | *Error al intentar obtener dispositivos para el nombre: {0} con pageStart: {1} y pageSize: {2}.* |
| **FWLSE4219E** | *RemoveDeviceError para deviceId: {0}.* |
| **FWLSE4220E** | *Error al crear clave web para el cliente {0}.* |
| **FWLSE4221E** | *Error al buscar dispositivos con pageInfo: {0}, searchMethod: {1}y filtro: {2}.* |
| **FWLSE4222E** | *Error de registro de cliente - firma no válida.* |
| **FWLSE4223E** | *Error de registro de cliente - aplicación no válida. error: {0}.* |
| **FWLSE4224E** | *Error al procesar solicitud de registro.* |
| **FWLSE4225E** | *Solicitud de actualización de autoregistro no válida, no se ha podido verificar la firma.* |
| **FWLSE4226E** | *Error de autenticación al actualizar registro, ha fallado la actualización {0}.* |
| **FWLSE4227E** | *Error al actualizar el registro.* |
| **FWLSE4228E** | *Error de applyRegistrationValidations durante el registro, eliminando el cliente {0}.* |
| **FWLSE4229W** | *Repitiendo lectura del contexto del cliente inicializado, los cambios se pueden perder.* |

### Mensajes de la aplicación 

**Prefijo:** FWLST<br/>
**Rango:** 0100-0106

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLST0100E** | *se ha intentado acceder a Direct Update para una aplicación que no ha estado asociada nunca con la seguridad de Direct Update.* |
| **FWLST0101E** | *No se ha encontrado ninguna aplicación con el nombre: {0}.* |
| **FWLST0102E** | *no se puede finalizar Direct Update debido a {0}.* |
| **FWLST0110E** | *se ha intentado acceder a la actualización nativa para una aplicación que no ha estado asociada nunca con la seguridad de actualización nativa.* |
| **FWLST0111E** | *No se ha encontrado ninguna aplicación con el nombre: {0}.* |
| **FWLST0112E** | *no se puede finalizar la actualización nativa debido a {0}.* |
| **FWLST0120E** | *se ha intentado acceder a la actualización de modelo para una aplicación que no ha estado asociada nunca con la seguridad de actualización de modelo.* |
| **FWLST0121E** | *No se ha encontrado ninguna aplicación con el nombre: {0}.* |
| **FWLST0122E** | *no se puede finalizar la actualización de modelo debido a {0}.* |
| **FWLST0103E** | *Perfil de registro de cliente no válido, el nivel no debe ser nulo.* |
| **FWLST0104E** | *Perfil de registro de cliente no válido, se ha encontrado más de un perfil.* |
| **FWLST0105E** | *No se puede cargar el archivo de registro debido a {0}.* |
| **FWLST0106E** | *Error de despliegue de aplicación. El ID de aplicación {0} no está permitido. El ID de aplicación solo puede contener los caracteres a-z, A-Z, _-..* |

### Mensajes del adaptador JavaScript

**Prefijo:** FWLST<br/>
**Rango:** 0900-0906

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLST0900E** | *Error de despliegue del descriptor del adaptador. Almacén de claves no válido.* |
| **FWLST0901W** | *El alias de SSL {0} no existe en el almacén de claves. Las invocaciones de programa de fondo que requieran el almacén de claves fallarán.* |
| **FWLST0902W** | *El alias de SSL existe en el descriptor pero no la contraseña. Las invocaciones de programa de fondo que requieran el almacén de claves fallarán.* |
| **FWLST0902W** | *La contraseña de SSL existe en el descriptor pero no el alias. Las invocaciones de programa de fondo que requieran el almacén de claves fallarán.* |
| **FWLST0903W** | *Alias y contraseña de SSL no válidas. Las invocaciones de programa de fondo que requieran el almacén de claves fallarán.* |
| **FWLST0904E** | *Se ha generado una excepción al invocar el procedimiento: {0} en el adaptador: {1}.* |
| **FWLST0905E** | *Error de despliegue de adaptador. No se ha encontrado el controlador SQL {0} en los recursos del adaptador.* |
| **FWLST0906E** | *Se ha generado una excepción al invocar SQL {0}.* |


**Prefijo:** FWLSE<br/>

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE0014W** | *No se conoce el parámetro {0} y se omitirá.* |
| **FWLSE0152E** | *No se puede encontrar la cadena de certificados con el alias: {0}.* |
| **FWLSE0207E** | *Error de lectura de la corriente de entrada de respuesta HTTP.* |
| **FWLSE0299W** | *Respuesta para la solicitud: Devuelto {0} en 0ms. Es necesario investigar el flujo de mensajes HTTP.* |
| **FWLSE0310E** | *Error de análisis JSON.* |
| **FWLSE0311E** | *Error de análisis XML o transformación.* |
| **FWLSE0318I** | *{0}.* |
| **FWLSE0319W** | *El tipo de contenido de respuesta del programa de fondo {0} no coincide con el tipo de contenido esperado {1}, se continúa procesando la respuesta. Las cabeceras y cuerpo de solicitud y respuesta: {2}.* |
| **FWLSE0330E** | *No se puede inicializar el contexto SSL de WebSphere.* |


### Mensajes principales 

**Prefijo:** FWLST<br/>

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
|**FWLST3022W** | *La carpeta {0} no es grabable. Se utilizará el directorio de inicio basado en el usuario.* |
| **FWLST3023E** | *Error al iniciar el proyecto {0}: No se ha podido crear el directorio {1}.* |
| **FWLST3024I** | *El servidor MFP está utilizando la carpeta {0} como caché del sistema de archivos.* |
| **FWLST3025W** | *El informe de análisis del servidor MFP está inhabilitado debido a un URL vacío en la configuración del registro.* |
| **FWLST3026W** | *Error en el servidor MFP al invocar el servicio de análisis: {0}.* |
| **FWLST3027I** | *La configuración ha cambiado. Ahora el servidor de análisis está habilitado en: {0}.* |
| **FWLST4047W** | *No se ha podido encontrar la versión del producto. Se ha buscado en el archivo: {0} y en la propiedad: {1}.* |
| **FWLST4048W** | *No se ha podido encontrar la versión del tiempo de ejecución. Se ha buscado en el archivo: {0} y en la propiedad: {1}.* |

### Mensajes de seguridad

**Prefijo:** FWLSE<br/>
**Rango:** 4010-4068

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE4010E** | *No se ha podido leer el archivo zip del despliegue del almacén de claves.* |
| **FWLSE4011E** | *El archivo zip no incluye el archivo del almacén de claves.* |
| **FWLSE4012E** | *El archivo zip no incluye el archivo de propiedades.* |
| **FWLSE4016E** | *El tipo del algoritmo de certificado del almacén de claves no es RSA. Siga las indicaciones de la guía de la consola para crear un almacén de claves con un algoritmo RSA.* |
| **FWLSE4017E** | *No se puede crear el almacén de claves. Almacén de claves: tipo: {0}.* |
| **FWLSE4018E** | *Algún algoritmo tipográfico no está soportado en este entorno. Almacén de claves: tipo: {0}.* |
| **FWLSE4019E** | *Esta excepción indica una variedad de problemas de certificado. Almacén de claves: tipo: {0}.* |
| **FWLSE4021E** | *No se puede crear el almacén de claves. Vía de acceso: tipo: {0}.* |
| **FWLSE4022E** | *No se puede recuperar la clave del almacén de claves. Almacén de claves: tipo: {0}.* |
| **FWLSE4023E** | *No se ha podido extraer la clave privada de KeyStore, falta el alias o no es válido. alias:  {0}.* |
| **FWLSE4024W** | *Configuración duplicada para la comprobación de seguridad {0} en este adaptador. Se utiliza la configuración: {1}.* |
| **FWLSE4025W** | *La comprobación de seguridad {0} ya se ha configurado en un adaptador diferente, no se utilizará la nueva configuración.* |
| **FWLSE4026E** | *No se ha encontrado la clase {1} para la comprobación de seguridad {0}.* |
| **FWLSE4027E** | *No se puede crear la comprobación de seguridad {0}. clase: {1}, error: {2}.* |
| **FWLSE4028E** | *La clase {1} para la comprobación de seguridad {0} no implementa la interfaz SecurityCheck.* |
| **FWLSE4029E** | *Error de despliegue de autenticidad. Mensaje de error: {0}.* |
| **FWLSE4030E** | *Se ha encontrado una correlación de elemento de ámbito duplicada para el elemento de ámbito {0}, se utiliza la correlación: {1}.* |
| **FWLSE4031E** | *Se ha encontrado una configuración de comprobación de seguridad duplicada para la comprobación de seguridad {0}.* |
| **FWLSE4032E** | *El descriptor de aplicación de la aplicación {0} contiene una configuración para la comprobación de seguridad {1}. Falta la comprobación de seguridad o se ha intentado eliminarla.* |
| **FWLSE4033E** | *El descriptor de aplicación de la aplicación {0} contiene una configuración para la comprobación de seguridad {1}. No se ha podido aplicar la configuración de comprobación de seguridad.* |
| **FWLSE4034E** | *La comprobación de seguridad {0} tiene un error de configuración para el parámetro {1}: {2}.* |
| **FWLSE4035W** | *La comprobación de seguridad ''{0}'' tiene un aviso de configuración para el parámetro {1}: {2}.* |
| **FWLSE4036W** | *El descriptor de aplicación de la aplicación {0} contiene una configuración para un ámbito de aplicación obligatorio {1}. Faltan uno o varios elementos de ámbito o se ha intentado eliminarlos.* |
| **FWLSE4037E** | *La comprobación de seguridad {0} no puede tener el mismo nombre que una correlación de elementos de ámbito.* |
| **FWLSE4038E** | *El descriptor de aplicación de la aplicación {0} contiene una configuración para un ámbito {1} que está correlacionado con la comprobación de seguridad {2}. Falta la comprobación de seguridad o se ha intentado eliminarla.* |
| **FWLSE4039W** | *Un elemento de ámbito vacío no se puede correlacionar. Intentando correlacionar con: {0}.* |
| **FWLSE4040E** | *El campo {0} de la configuración del adaptador no tiene el formato correcto.* |
| **FWLSE4041W** | *Se han utilizado caracteres no permitidos en el elemento de ámbito {0}. Los caracteres permitidos son letras, números, '-' y '_'.* |
| **FWLSE4042I** | *Configuración de la comprobación de seguridad {0} para el parámetro {1}: {2}.* |
| **FWLSE4043E** | *La caducidad de señal máxima de la aplicación debe ser positiva.Configurada: {0}.* |
| **FWLSE4044I** | *El usuario {0} se autentica mediante la seguridad SSO basada en Ltpa.* |
| **FWLSE4045I** | *El usuario NO se autentica mediante la seguridad SSO basada en Ltpa.* |
| **FWLSE4046** | *comprobando si el dispositivo inhabilitado para el registro ha fallado con la excepción.* |
| **FWLSE4047:** | *El valor máximo de caducidad de señal para la aplicación {0} es mayor que el límite de caducidad. Valor: {1}, límite de caducidad: {2}.* |
| **FWLSE4048E** | *Error al validar la señal de acceso con el servidor AZ externo {0}.* |
| **FWLSE4049E** | *Ha fallado el orden de comprobaciones de seguridad.* |
| **FWLSE4050E** | *Datos de cliente no válidos.* |
| **FWLSE4051E** | *La aplicación no existe.* |
| **FWLSE4052E** | *Error al leer comprobaciones de seguridad externalizadas. Limpieza de contexto inicializada para el cliente: {0}.* |
| **FWLSE4053E** | *La comprobación de seguridad no existe - {0}.* |
| **FWLSE4054E** | *Error al externalizar las comprobaciones de seguridad. Se suprimen las comprobaciones de seguridad para el cliente: {0}.* |
| **FWLSE4055E** | *Error al obtener la caducidad de ámbito, se devuelve 0.* |
| **FWLSE4056E** | *Error de introspección con excepción.* |
| **FWLSE4057E** | *Resultado de validación de señal no previsto: {0}.* |
| **FWLSE4058E** | *Error al codificar la cabecera y la carga útil.* |
| **FWLSE4059E** | *Error al crear objeto de cabecera desde cabecera decodificada: {0}.* |
| **FWLSE4060E** | *Error al crear objeto de carga útil desde cabecera decodificada: {1}.* |
| **FWLSE4061E** | *Error al codificar header64 + payload64.* |
| **FWLSE4062E** | *Error al codificar la cabecera de firma o al crear la cabecera.* |
| **FWLSE4063E** | *Error al codificar la carga útil.* |
| **FWLSE4064E** | *El cliente no tiene permiso para el ámbito {0}.* |
| **FWLSE4065E** | *El cliente no está autorizado.* |
| **FWLSE4066E** | *El flujo de concesión implícito solo está disponible para la IU de Swagger.* |
| **FWLSE4067E** | *El cliente no está autorizado.* |
| **FWLSE4068E** | *El cliente no está autorizado.* |


### Mensajes de persistencia de servidor 

**Prefijo:** FWLSE<br/>
**Rango:** 3000-3009

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE3000E** | *No se ha encontrado el enlace JNDI del origen de datos para: {0} y {1}.* |
| **FWLSE3001E** | *No se puede serializar la lista para la matriz json.* |
| **FWLSE3002E** | *No se puede crear el elemento de datos persistentes: {0}.* |
| **FWLSE3003E** | *Problema de deserialización de matriz JSON.* |
| **FWLSE3004E** | *No se puede leer la columna de valores CLOB.* |
| **FWLSE3005E** | *No se puede serializar la lista para la matriz json.* |
| **FWLSE3006E** | *No se ha podido iniciar la transacción: {0}.* |
| **FWLSE3007E** | *Se ha encontrado un error inesperado.* |
| **FWLSE3008E** | *No se ha podido generar hash.* |
| **FWLSE3009E** | *Se ha producido un error al intentar confirmar la transacción.* |

### Mensajes war del servidor 

**Prefijo:** FWLSE<br/>
**Rango:** 3100-3103

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE3100E** | *Modo de servidor de autorización desconocido: {0}.* |
| **FWLSE3101E** | *No se ha encontrado la entrada Jndi {0}, modo de servidor de autorización desconocido.* |
| **FWLSE3102I** | *Error al recopilar anotaciones para la clase {0}. Es posible que falte algún ámbito en la IU de Swagger.* |
| **FWLSE3103I** | *Error al determina la clase para el bean {0}. Es posible que falten algunos ámbitos en la IU de Swagger.* |
| **FWLSE3103I** | *Iniciando con el servidor de autorización incluido.* |
| **FWLSE3103I** | *Iniciando con la integración del servidor de autorización externo.* |

### Mensajes de licencia 

**Prefijo:** FWLSE<br/>

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE0277I** | *Creando un registro ILMT en el archivo {0}.* |
| **FWLSE0278I** | *No se puede utilizar el directorio ILMT {0} predeterminado.* |
| **FWLSE0279E** | *Error al crear un registro ILMT.* |
| **FWLSE0280I** | *Modo de depuración ILMT activado por la variable de entorno {0}.* |
| **FWLSE0281E** | *Error al crear un registrador ILMT.* |
| **FWLSE0282I** | *Utilizando el directorio ILMT {0}.* |
| **FWLSE0283E** | *El directorio ILMT no es compatible. Puede establecer un directorio adecuado en una propiedad 'license.metric.logger.output.dir' en el archivo 'license_metric_logger.properties' y utilizar la propiedad JVM '-Dlicense_metric_logger_configuration=\<path to license_metric_logger.properties\>'.* |
| **FWLSE0284E** | *Error al recuperar la vía de acceso en que se ejecuta esta instancia {0}. No es compatible con ILMT.* |
| **FWLSE0286I** | *Excepción imprevista.* |
| **FWLSE0287E** | *Error al crear un registro ILMT debido a que no se ha inicializado correctamente el registrador ILMT. Esto no es compatible con ILMT. Revise los archivos de registro para encontrar la causa del error de inicialización.* |
| **FWLSE0367E** | *Faltan datos del informe de licencia. No se ha podido crear un registro ILMT.* |

### Mensajes de depuración 

**Prefijo:** FWLSE<br/>
**Rango:** 0290-0292

| **FWLSE0290I** | *Completed deletion of {0} records in {1} ms.* |
| **FWLSE0291I** | *Completed deletion of {0} batches in {1} ms.* |
| **FWLSE0292I** | *La supresión de datos persistentes recomendada es para los registros con una antigüedad superior a {0} días.* |

### Otros mensajes 

**Prefijo:** FWLSE<br/>

| **FWLSE0211W** | *El intervalo de decomisionamiento recomendado ({0}) es de 86400 segundos, lo cual es 1 día.* |
| **FWLSE0801E** | *El programa de utilidad de decodificación de contraseña com.ibm.websphere.crypto.PasswordUtil no está disponible. No se soporta la contraseña cifrada para {0}.* |
| **FWLSE0802E** | *No se puede decodificar la contraseña para {0}.* |
| **FWLSE0803E** | *No se puede encontrar el mensaje para el id {0} en el paquete {1} " + ". Error:{2}.* |
| **FWLSE0802E** | *No se puede decodificar la contraseña para {0}.* |



## Mensajes de servicio de Mobile Foundation Administration
{: #admin-services-error-codes }
<!-- Messages taken from mfp-admin-services/mfp-admin-util/src/main/resources/com/ibm/worklight/admin/resources/messages.properties-->
**Prefijo:** FWLSE<br/>
**Rango:** 3000-3299

| **Código de error**  | **Descripción** |
|-----------------|-----------------|
| **FWLSE3000E** | **Se ha detectado un error del servidor.** |
| **FWLSE3001E** | **Se ha detectado un conflicto.** |
| **FWLSE3002E** | **No se ha encontrado el recurso.** |
| **FWLSE3003E** | **No se puede añadir el tiempo de ejecución porque su carga útil no incluye un nombre.** |
| **FWLSE3010E** | **Se ha detectado un error de base de datos.** <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, desconfigurar la base de datos. |
| **FWLSE3011E** | **El número de puerto "{0}" de la propiedad JNDI mfp.admin.proxy.port no es válido.** <br/><br/>{0} es el número de puerto, por ejemplo, 9080.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, establezca la propiedad JNDI mfp.admin.proxy.port en un valor sin sentido. A continuación, abrir la consola de operaciones. Finalmente el mensaje aparecerá en los registros del servidor. |
| **FWLSE3012E** | **Error de conexión JMX. Razón: "{0}". Consulte los registros del servidor de la aplicación para obtener más detalles.** <br/><br/>{0} es un mensaje de error procedente del protocolo JMX del servidor web.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, desconfigurar JMX de algún modo para que genere excepciones. |
| **FWLSE3013E** | **Tiempo de espera excedido al obtener el bloqueo de transacción después de {0} milisegundos.** <br/><br/>{0} es el número de milisegundos, por ejemplo, 32000.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto sucede con una base de datos conectada mediante una red inestable o lenta. |
| **FWLSE3017E** | **Se ha detectado un error de base de datos: {0}. Razón: {1}** <br/><br/>{0} es el mensaje de error de cloudant.<br/>{1} es el mensaje de error de cloudant.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, desconfigurar Cloudant. |
| **FWLSE3018E** | **La operación de Cloudant no se ha completado en {0} milisegundos.** <br/><br/>{0} es el número de milisegundos, por ejemplo, 32000.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, utilice la BD de Cloudant y establezca la propiedad JNDI mfp.db.cloudant.documentOperation.timeout en 1. Si la conexión con cloudant es lenta, abra la consola de operaciones. Finalmente el mensaje aparecerá en los registros del servidor. |
| **FWLSE3019E** | **No se puede obtener el bloqueo de transacción. Razón: {0}** <br/><br/>{0} es un mensaje de excepción que devolvemos de forma externa. Puede ser cualquier serie. <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, se puede reproducir si tiene una granja con Cloudant y concluye el maestro del bloqueo mientras hay operaciones de bloqueo en curso. A continuación, abra la consola de operaciones. Finalmente el mensaje aparecerá en los registros del servidor. |
| **FWLSE3021E** | **Tiempo de espera excedido al obtener el bloqueo de transacción después de {0} milisegundos. Incremente la propiedad {1}.**<br/><br/>{0} es el número de milisegundos, por ejemplo, 32000.<br/>{1} es el nombre de la propiedad JNDI de la que se obtiene el tiempo de espera.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto sucede con una base de datos conectada mediante una red inestable o lenta. |
| **FWLSE3030E** | **El tiempo de ejecución "{0}" no existe en la base de datos de administración de MobileFirst. Es posible que la base de datos esté dañada.** <br/><br/>**Donde:** {0} es el nombre del tiempo de ejecución (cualquier serie). <br/><br/>Este error se produce cuando {{ site.data.keys.mf_server }} no puede cargar el tiempo de ejecución almacenado en la base de datos.  [APAR PI71317](http://www-01.ibm.com/support/docview.wss?uid=swg1PI71317) se publicó para solucionar algunas de las apariciones de este mensaje. Si el nivel de arreglo del servidor es anterior a **iFix 8.0.0.0-IF20170125-0919**, actualice al
[iFix más reciente](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all). |
| **FWLSE3031E** | **No se puede añadir o suprimir el tiempo de ejecución "{0}" porque todavía se está ejecutando.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). |
| **FWLSE3032E** | **No se puede añadir el tiempo de ejecución "{0}" porque ya existe.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). |
| **FWLSE3033E** | **El tiempo de ejecución "{0}" no está vacío pero ha solicitado que se suprima el tiempo de ejecución solo cuando esté vacío.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, suprima un tiempo de ejecución detenido que todavía contenga aplicaciones. |
| **FWLSE3034E** | **La aplicación "{1}" para el tiempo de ejecución "{0}" no existe en la base de datos de administración de MobileFirst. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/>{1} es el nombre de la aplicación (cualquier serie). |
| **FWLSE30302E** | **La configuración de la licencia para la aplicación "{1}" para el tiempo de ejecución "{0}" no existe en la base de datos de MobileFirst Administration.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/>{1} es el nombre de la aplicación (cualquier serie). |
| **FWLSE30303E** | **La configuración de la licencia no se puede suprimir porque la aplicación "{1}" para el tiempo de ejecución "{0}" existe en la base de datos de MobileFirst Administration o la configuración de la licencia no existe.** <br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/>{1} es el nombre de la aplicación (cualquier serie). |
| **FWLSE30035E** | **No se puede añadir la aplicación "{1}" porque ya existe en el tiempo de ejecución "{0}".** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/>{1} es el nombre de la aplicación (cualquier serie). <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> solo ocurre en las pruebas de unidades |
| **FWLSE3035E** | **La aplicación "{1}" con el entorno "{2}" del tiempo de ejecución "{0}" no existe en la base de datos de MobileFirst Administration. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie) <br/>{1} es el nombre de la aplicación (cualquier serie). <br/>{2} es el nombre del entorno: android, ios, ... |
| **FWLSE30304E** | **AppAuthenticity Data para la aplicación "{1}" con el entorno "{2}" y versión "{3}" del tiempo de ejecución "{0}" no existe en la base de datos de MobileFirst Administration. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie) <br/>{1} es el nombre de la aplicación (cualquier serie). <br/>{2} es el nombre del entorno: android, ios, ... |
| **FWLSE3036E** | **La aplicación "{1}" con el entorno "{2}" y versión "{3}" del tiempo de ejecución "{0}" no existe en la base de datos de MobileFirst Administration. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). <br/>{1} es el nombre de la aplicación (cualquier serie). <br/>{2} es el nombre del entorno: android, ios, ... <br/>{3} es la versión: 1.0, 2.0 ... |
| **FWLSE3037E** | **No se puede añadir el entorno "{1}" con la versión "{2}" dado que ya existe en la aplicación "{0}".** <br/><br/>{0} es el nombre de la aplicación (cualquier serie). <br/>{1} es el nombre del entorno: android, ios, ... <br/>{2} es la versión: 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> solo ocurre en las pruebas de unidades |
| **FWLSE3038E** | **El adaptador "{1}" del tiempo de ejecución "{0}" no existe en la base de datos de administración de MobileFirst. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el nombre del tiempo de ejecución (cualquier serie). {1} es el nombre del adaptador (cualquier serie). |
| **FWLSE3039E:** | **No se puede añadir el adaptador "{0}" porque ya existe en el tiempo de ejecución "{1}".** <br/>{0} es el nombre del tiempo de ejecución (cualquier serie). {1} es el nombre del adaptador (cualquier serie). <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> solo ocurre en las pruebas de unidades. |
| **FWLSE3040E** | **No se ha encontrado el perfil de configuración "{0}" para ningún tiempo de ejecución de la base de datos de MobileFirst Administration. Es posible que la base de datos esté dañada.** <br/><br/>{0} es el id del perfil de configuración (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, puede producirse en el registro de rastreo cuando se suprime un perfil de configuración de cliente no existente. |
| **FWLSE3045E** | **No se ha encontrado ningún MBean para la administración {0}.** <br/><br/>{0} es la palabra MobileFirst.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3041E** | **No se ha encontrado ningún MBean para el proyecto {0} ''{1}''. Es posible que la aplicación web de tiempo de ejecución {0} para el proyecto {0} ''{1}'' no se esté ejecutando. Si se está ejecutando, utilice JConsole para inspeccionar los MBeans disponibles. Si no se está ejecutando, los detalles completos del error están disponibles en los archivos de registro del servidor. **
<br/><br/>{0} es la palabra MobileFirst. {1} es el nombre de proyecto/tiempo de ejecución (cualquier serie) |
| **FWLSE3042E** | **Error de comunicación con el MBean ''{0}''. Consulte los registros del servidor de aplicaciones.** <br/><br/>{0} es el ID canónico del MBean, que es una serie. <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Puede producirse si se instala una worklight-jee-library 6.2 en un servidor MobileFirst 7.1. |
| **FWLSE3043E** | **El MBean con el nombre ''{0}'' ya no está presente. Consulte los registros del servidor de aplicaciones.** <br/><br/>{0} es el ID canónico del MBean, que es una serie. <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, se produce en la granja de servidores cuando se concluye un servidor mientras está en curso una operación de despliegue. |
| **FWLSE3044E** | **El MBean con el nombre ''{1}'' no admite las operaciones esperadas. Compruebe que la versión del tiempo de ejecución de {0} sea la misma que la de los servicios de administración.**
<br/><br/>{0} es la palabra MobileFirst. {1} es el ID canónico del MBean, que es una serie. <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Puede producirse si se instala una worklight-jee-library 6.2 en un servidor MobileFirst 7.1. |
| **FWLSE3050E** | **La operación de MBean devuelve un tipo desconocido. Compruebe que la versión del tiempo de ejecución de {0} sea la misma que la de los servicios de administración.**
<br/><br/>{0} es la palabra MobileFirst.<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Puede producirse si se instala una worklight-jee-library 6.2 en un servidor MobileFirst 7.1. |
| **FWLSE3051E** | **Carga útil no válida. Consulte los mensajes adicionales para obtener más detalles.**
|
| **FWLSE3052E** | **La carga útil siguiente no se reconoce: "{0}".** <br/><br/>{0} es un extracto de la carga útil en sintaxis JSON, por ejemplo, "{ a : 0 }" |
| **FWLSE3053E** | **Parámetros no válidos. Consulte los mensajes adicionales para obtener más detalles.**
|
| **FWLSE3061E** | **El entorno "{0}" mencionado en el archivo "{1}" del archivo wlapp se desconoce. Compruebe que la aplicación se haya compilado correctamente.** <br/><br/>{0} es el entorno: android, ios.  {1} es un nombre de archivo |
| **FWLSE3063E** | **No se puede desplegar la aplicación ya que la carpeta "{0}" no está en el archivo wlapp. Compruebe que la aplicación se haya compilado correctamente.** <br/><br/>{0} es un nombre carpeta, por ejemplo, "meta".<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Despliegue un wlapp que no contenga la carpeta meta |
| **FWLSE3065E** | **No se puede desplegar la aplicación ya que el campo "{0}" no está en el archivo wlapp. Compruebe que la aplicación se haya compilado correctamente.** <br/><br/>{0} es un campo obligatorio, por ejemplo, "app.id" |
| **FWLSE3066E** | **No se puede desplegar la aplicación ya que la versión de la aplicación "{2}" es diferente a la versión del tiempo de ejecución {0} "{3}". \nUtilice {1} "{4}" para compilar y desplegar la aplicación.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es una versión de la aplicación: 1.0, 2.0, ... {3} es la versión del tiempo de ejecución {4} es la versión de Studio necesaria |
| **FWLSE3067E** | **No se puede desplegar la aplicación ya que la versión de la aplicación es más antigua que la versión del tiempo de ejecución {0} "{2}". \nUtilice {1} "{3}" para compilar y desplegar la aplicación.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es la versión de tiempo de ejecución {3} es la versión de Studio necesaria. |
| **FWLSE3068E** | **No se puede desplegar el adaptador ya que la versión del adaptador "{2}" es diferente a la versión del tiempo de ejecución {0} "{3}". \nUtilice {1} "{4}" para compilar y desplegar el adaptador.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es una versión del adaptador: 1.0, 2.0, ... {3} es la versión del tiempo de ejecución {4} es la versión de Studio necesaria |
| **FWLSE3069E** | **No se puede desplegar el adaptador ya que la versión del adaptador es más antigua que la versión del tiempo de ejecución {0} "{2}". \nUtilice {1} "{3}" para compilar y desplegar el adaptador.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es la versión de tiempo de ejecución {3} es la versión de Studio necesaria. |
| **FWLSE3070E** | **Error al actualizar la aplicación "{1}" con el entorno "{2}" y la versión "{3}" debido a que está bloqueada. Se puede desbloquear utilizando la consola de operaciones de {0}.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de aplicación (cualquier serie) {2} es el entorno de aplicación: android, ios... {3} es la versión de la aplicación: 1.0, 2.0, ... |
| **FWLSE3071E** | **No se puede desplegar la aplicación híbrida "{0}" porque ya existe una aplicación nativa con el mismo nombre.** <br/><br/>{0} es el nombre de la aplicación (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Cree una aplicación nativa y una aplicación híbrida con el mismo nombre y despliegue las dos en la consola de operaciones. |
| **FWLSE3072E** | **No se puede desplegar la aplicación nativa "{0}" porque ya existe una aplicación nativa con el mismo nombre.** <br/><br/>{0} es el nombre de la aplicación (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Cree una aplicación nativa y una aplicación híbrida con el mismo nombre y despliegue las dos en la consola de operaciones. |
| **FWLSE3073E** | **No se puede encontrar el archivo del instalador de Adobe Air en la aplicación "{1}" versión "{2}". \nUtilice {0} para volver a compilar y desplegar el archivo wlapp para esta aplicación.**
<br/><br/>{0} es el nombre de Studio, por ejemplo, MobileFirst Studio {1} es el nombre de la aplicación (cualquier serie) {2} es la versión de la aplicación: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Se produce cuando la aplicación adobe está en mal estado |
| **FWLSE3074W** | **El bloqueo se ha actualizado correctamente para la aplicación "{0}" con el entorno "{1}" y la versión "{2}", pero este valor no tiene ningún efecto en el entorno "{1}" porque este entorno no da soporte a Direct Update.** <br/><br/>{0} es el nombre de aplicación (cualquier serie) {1} es el entorno de la aplicación: android, ios, ... {2} es la versión de la aplicación: 1.0, 2.0, ... <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3075W** | **La regla de autenticación de la aplicación se ha actualizado correctamente para la aplicación "{0}" con el entorno "{1}" y versión "{2}" pero este valor no tiene ningún efecto en la aplicación "{0}" del entorno "{1}" porque este entorno no da soporte a la comprobación de autenticación. Puede habilitar este soporte para este entorno de aplicación declarando en el archivo application-descriptor.xml una configuración de seguridad definida en authenticationConfig.xml. **
<br/><br/>{0} es el nombre de aplicación (cualquier serie) {1} es el entorno de la aplicación: android, ios, ... {2} es la versión de la aplicación: 1.0, 2.0, ... <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3076W** | **La aplicación "{0}" con el entorno "{1}" y versión "{2}" no se ha desplegado porque no ha cambiado desde el despliegue anterior.** <br/><br/>{0} es el nombre de aplicación (cualquier serie) {1} es el entorno de la aplicación: android, ios, ... {2} es la versión de la aplicación: 1.0, 2.0, ... <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, despliegue dos veces exactamente el mismo wlapp (legal) con la consola de operaciones.  |
| **FWLSE3077W** | **El adaptador "{0}" no se ha desplegado porque no ha cambiado desde el despliegue anterior.** <br/><br/>{0} es el nombre del adaptador (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, despliegue dos veces exactamente el mismo adaptador (legal) con la consola de operaciones.  |
| **FWLSE3078W** | **Falta el archivo de miniaturas en el archivo wlapp para la aplicación "{0}" del entorno "{1}" y versión "{2}".** <br/><br/>{0} es el nombre de aplicación (cualquier serie) {1} es el entorno de la aplicación: android, ios, ... {2} es la versión de la aplicación: 1.0, 2.0, ... |
| **FWLSE3079W** | **Imposible verificar que la aplicación "{2}" con el entorno "{3}" y la versión "{4}" se ha creado con la misma versión {1} que el tiempo de ejecución {0} porque las versiones de la aplicación y el tiempo de ejecución se han creado con versiones de Worklight Studio anteriores a la 6.0. Asegúrese de que ambas se hayan compilado con la misma versión {1}.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es el nombre de la aplicación (cualquier serie) {3} es el entorno de aplicación: android, ios... {4} es la versión de la aplicación: 1.0, 2.0, ... <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, despliegue la compilación ild con Worklight Studio 5.0.6 o anterior, en MobileFirst Server 7.1. |
| **FWLSE3080W** | **No se puede verificar que el adaptador "{2}" se haya creado con la misma versión {1} que el tiempo de ejecución {0} ya que las versiones del adaptador y el tiempo de ejecución se han creado con versiones de Worklight anteriores a la versión 6.0. Asegúrese de que ambas se hayan compilado con la misma versión {1}.**
<br/><br/>{0} es la palabra MobileFirst {1} es el nombre de Studio, por ejemplo, MobileFirst Studio {2} es el nombre del adaptador (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, despliegue la compilación del adaptador con Worklight Studio 5.0.6 o anterior, en MobileFirst Server 7.1. |
| **FWLSE3081E** | **No está soportada la comprobación de autenticación para el entorno "{0}". Solo se da soporte a los entornos iOS y Android.** <br/><br/>{0} es el entorno de la aplicación: android, ios, ...<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, edite la aplicación android con la comprobación de autenticación habilitada y modifique el entorno, a continuación, realice el despliegue. |
| **FWLSE3082E** | **El contenido del archivo "{0}" está vacío y no se puede desplegar.** <br/><br/>{0} es un nombre de archivo |
| **FWLSE3084E** | **El archivo del adaptador no se puede desplegar ya que no contiene el archivo XML de adaptador obligatorio. Compruebe si se ha compilado correctamente.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> despliegue un adaptador que no contenga un archivo XML |
| **FWLSE3085E** | **El archivo de aplicación no se puede desplegar ya que contiene el archivo "{0}" obligatorio. Compruebe si se ha compilado correctamente.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> despliegue un wlapp que no contenga ningún archivo meta/deployment.data |
| **FWLSE3090E** | **La transacción no se ha finalizado nunca. Consulte los registros del servidor de aplicaciones.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto sucede cuando se estanca una transacción por una razón desconocida durante 30 minutos |
| **FWLSE3091W** | **Ha fallado el proceso de la transacción {0}. Consulte los registros del servidor de aplicaciones.** <br/><br/>{0} es el id de transacción, normalmente un número<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Es posible que se pueda reproducir concluyendo un tiempo de ejecución mientras una transacción está en curso. |
| **FWLSE3092W** | **Se ha cancelado la transacción {0} antes de iniciar el proceso. Consulte los registros del servidor de aplicaciones.** <br/><br/>{0} es el id de transacción, normalmente un número<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Esto se produce si crea varias transacciones de despliegue, en las que todavía no se ha procesado al menos una de ellas cuando concluye el servidor. Al reiniciar el servidor, la transacción no procesada se cancelará. |
| **FWLSE3100W** | **No se puede acceder al recurso binario {3}. No se ha podido cumplir la solicitud de rango HTTP {0}-{1}. La longitud máxima del contenido es de {2} bytes. **
<br/><br/>{0} es el inicio del rango de bytes, por ejemplo, 0; {1} es el fin del rango de bytes, por ejemplo, 6666; {2} es el número de bytes disponibles, por ejemplo 25; {3} es el nombre de recurso (como un nombre de archivo) |
| **FWLSE3101W** | **La aplicación {1}, entorno {2}, versión {3} compilada con {0} versión {4} se ha reemplazado por el entorno compilado con {0} versión {5}** <br/><br/>{0} es el nombre de Studio: MobileFirst Studio {1} es el nombre de aplicación (cualquier serie) {2} es el entorno de aplicación: android, ios, ... {3} es la versión de la aplicación: 1.0, 2.0, ... {4} es la versión de Studio, por ejemplo 3.0; {5} es la otra versión de Studio, por ejemplo, 4.0<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, es necesario tener una compilación de la aplicación con dos versiones diferentes de Studio, pero la aplicación debe tener el mismo número de versión y el mismo entorno. Si, a continuación, despliega ambas aplicaciones en el mismo servidor, es posible que se genere el mensaje. Pero también es posible que el mensaje quede oculto por otros mensajes. No se ha visto nunca este mensaje. |
| **FWLSE3102W** | **La aplicación {0} no está habilitada para notificaciones push.** <br/><br/>{0} es el nombre de la aplicación (cualquier serie) |
| **FWLSE3103E** | **No se ha encontrado la etiqueta de notificaciones push {0} para la aplicación {2} del tiempo de ejecución {1}.** <br/><br/>{0} es la etiqueta de notificaciones push (cualquier serie) {1} es el nombre del tiempo de ejecución (cualquier serie) {2} es el nombre de la aplicación (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> solo ocurre en las pruebas de unidades |
| **FWLSE3104E** | **Ya existe la etiqueta de notificaciones push {0} para la aplicación {2} del tiempo de ejecución {1}.** <br/><br/>{0} es la etiqueta de notificaciones push (cualquier serie) {1} es el nombre del tiempo de ejecución (cualquier serie) {2} es el nombre de la aplicación (cualquier serie) <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3105W** | **El certificado de notificaciones push {0} ha caducado.** <br/><br/>{0} es el nombre del mediador de push (cualquier serie)<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3113E** | **Múltiples errores al sincronizar el tiempo de ejecución {0}.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto ocurre en una configuración de granja (configuración de varios nodos) cuando se inicia el servidor pero cada nodo notifica un error diferente. |
| **FWLSE3199I** | **========= {0} versión {1} iniciado.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Esto siempre ocurre en el registro del servidor cuando se inicia el servidor. |
| **FWLSE3210W** | **El entorno: {1} de la aplicación {0} versión {2} se ha desplegado con una versión distinta del SDK nativo de MobileFirst. Las actualizaciones directas ya no estarán disponibles para los clientes existentes con otras versiones del SDK de MobileFirst. Para continuar utilizando las actualizaciones directas, aumente la versión de la aplicación, publíquela en la App Store, despliéguela en el servidor y, opcionalmente, bloquee o notifique las versiones más antiguas de la aplicación para forzar la actualización de los clientes a la versión nueva desde App Store.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto puede suceder si se ha creado una aplicación mediante una versión más antigua de MobileFirst Studio con un SDK de MobileFirst diferente y antiguo. No estoy familiarizado con las versiones de SDK de MobileFirst nativas. |
| **FWLSE3119E** | **Ha fallado la validación de certificados APNS. Consulte los mensajes adicionales para obtener más detalles.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Ocurre si el certificado de notificaciones push de Apple no es válido. |
| **FWLSE3120E** | **Esta API solo se puede utilizar después de migrar la aplicación a MobileFirst Platform 6.3. La versión actual de la aplicación es {0}**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Se produce con las nuevas notificaciones push utilizadas con aplicaciones antiguas. |
| **FWLSE3121E** | **Esta API ya no está disponible en el servidor. Consulte los mensajes adicionales para obtener más detalles.**
|
| **FWLSE3122E** | **La regla de comprobación de autenticación de una aplicación ya no se puede modificar en el servidor. Debe volver a compilar la aplicación para poder modificar la regla de comprobación de autenticidad y desplegarla. ** |
| **FWLSE3123W** | **El entorno: {1} de la aplicación {0} versión {2} se ha desplegado con la autenticación de aplicación ampliada inhabilitada. Se le recomienda que utilice la autenticidad de aplicación ampliada como protección ante aplicaciones no autorizadas utilizando el mandato enable extended-authenticity de la herramienta mfpadm antes de desplegar la aplicación. **
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> En la consola de operaciones, despliegue una aplicación con autenticación básica. Todas las aplicaciones anteriores a la versión 7.0 no tienen una autenticidad ampliada y deben mostrar este aviso o el siguiente. El aviso no se muestra si utiliza la consola de operaciones que está incluida en Worklight Studio. |
| **FWLSE3124W** | **El entorno: {1} de la aplicación {0} versión {2} se ha desplegado con la autenticación de aplicación inhabilitada. Habilítela para obtener una protección adicional ante aplicaciones no autorizadas.**
|

### Mensajes de licencia de señal 

| **FWLSE3125E** | **No se ha encontrado la biblioteca nativa de Rational Common Licensing. Asegúrese de que la propiedad JVM (java.library.path) está definida con la vía de acceso correcta y que es posible ejecutar la biblioteca nativa. Reinicie IBM MobileFirst Platform Server después de corregir el problema.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> No establezca la propiedad JVM (java.library.path) para que apunte a la biblioteca nativa de RCL en la configuración del servidor de aplicaciones. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución. |
| **FWLSE3126E** | **No se ha encontrado la biblioteca compartida de Rational Common Licensing. Asegúrese de que la biblioteca compartida esté configurada. Reinicie IBM MobileFirst Platform Server después de corregir el problema.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> No establezca la vía de acceso a la biblioteca compartida para que apunte a la biblioteca java de RCL en la configuración del servidor de aplicaciones. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución. |
| **FWLSE3127E** | **La conexión de Rational License Key Server no está configurada. Asegúrese de que se han establecido las propiedades JNDI de administración "{0}" y "{1}". Reinicie IBM MobileFirst Platform Server después de corregir el problema.** <br/><br/>{0} es el nombre de host del servidor de licencias {1} es el puerto del servidor de licencias<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> No establezca las propiedades JNDI (relacionadas con las licencias de señales) en la configuración del servidor de aplicaciones. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución. |
| **FWLSE3128E** | **No se puede acceder a Rational License Key Server "{0}". Asegúrese de que el servidor de licencias esté en ejecución y que IBM MobileFirst Platform Server pueda acceder al mismo. Si este error se produce en el arranque del tiempo de ejecución reinicie IBM MobileFirst Platform Server después de corregir el problema. **
<br/><br/>{0} es la dirección completa del servidor de licencias<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> No inicie el servidor de licencias. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución o durante el despliegue de la aplicación. |
| **FWLSE3129E** | **Licencias de señales insuficientes para la característica "{0}".** <br/><br/>{0} es el nombre de la característica de licencia<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Agote todas las licencias del servidor de licencias. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución o durante el despliegue de la aplicación. |
| **FWLSE3130E** | **Licencias de señales caducadas para la característica "{0}".** <br/><br/>{0} es el nombre de la característica de licencia<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Permita que caduquen las licencias de señales. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución o durante el despliegue de la aplicación. |
| **FWLSE3131E** | **Se ha detectado un error de licencia. Compruebe los registros del servidor de aplicaciones para obtener información más detallada.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. |
| **FWLSE3132E** | **La conexión con Rational License Key Server se ha configurado con las propiedades JNDI de administrador "{0}" y "{1}" pero este IBM MobileFirst Platform Server no está habilitado para la gestión de licencias de señales.** <br/><br/>{0} es el nombre de host del servidor de licencias {1} es el puerto del servidor de licencias<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> No active las licencias de señales. Pero establezca las propiedades JNDI (relacionadas con las licencias de señales) en la configuración del servidor de aplicaciones. De este modo, este mensaje se emitirá durante la sincronización del tiempo de ejecución. |
| **FWLSE3133I** | **Esta aplicación está inhabilitada. Póngase en contacto con el administrador para obtener más detalles.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Permita que caduquen las licencias de señales. De este modo, todas las aplicaciones se inhabilitarán de forma automática y cuando se acceda a la aplicación desde el dispositivo, se podrá ver este mensaje. |
| **FWLSE3134E** | **No se ha encontrado la biblioteca nativa de Rational Common Licensing.** <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3135E** | **No se ha encontrado la biblioteca compartida de Rational Common Licensing.** <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3136E** | **Los detalles de Rational License Key Server no se han configurado.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3137E** | **No se puede acceder a Rational License Key Server "{0}".** <br/><br/>{0} es la dirección completa del servidor de licencias<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3138E** | **Licencias de señales insuficientes para la característica "{0}".** <br/><br/>{0} es el nombre de la característica de licencia<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3139E** | **Licencias de señales caducadas para la característica "{0}".** <br/><br/>{0} es el nombre de la característica de licencia<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3140E** | **Se ha detectado un error de licencia.** <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |
| **FWLSE3141E** | **Los detalles de Rational License Key Server se han configurado.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Internamente para su almacenamiento en la base de datos. Difícil. |

### Mensajes de configuración de la granja de servidores

| **FWLSE3200W** | **El servidor "{0}" no se puede añadir como un nuevo miembro de la granja de servidores porque ya se ha registrado un servidor con el mismo ID para el tiempo de ejecución "{1}". Esto puede suceder si la propiedad JNDI mfp.admin.serverid tiene el mismo valor en otro nodo en ejecución, o si el servidor no ha cancelado su registro correctamente durante la última conclusión.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto sucede si se configura una granja de servidores de forma errónea. Una granja de servidores consta de varios sistemas (nodos). Cada sistema debe tener un ID (propiedad JNDI mfp.admin.serverid). Si utiliza exactamente el mismo ID para dos nodos diferentes, verá este mensaje en el registro del servidor. |
| **FWLSE3201E** | **Error al anular el registro del miembro de la granja de servidores "{0}" para el tiempo de ejecución "{1}".**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto puede suceder en los registros del servidor si tiene una granja de servidores y cierra un nodo de la granja de servidores, y se ha producido un error durante la conclusión. |
| **FWLSE3202E** | **No se ha podido recuperar la lista de miembros de la granja de servidores para el servidor "{0}".**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, es posible que ocurra en los registros del servidor cuando se cierra el servicio de administración en una granja de servidores.  A continuación, intenta notificar a los miembros de la granja de servidores y necesita una lista de miembros de la granja para hacerlo. |
| **FWLSE3203E** | **No se ha registrado ningún nodo de la granja de servidores con el ID de servidor "{0}" para el tiempo de ejecución "{1}".** |
| **FWLSE3204W** | **Aparentemente, no se puede localizar el nodo "{0}", esta transacción no se ha realizado en este nodo.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto puede ocurrir en una granja de servidores si desconecta de la red un nodo de la granja y espera el tiempo suficiente. Se muestra en el registro del servidor. |
| **FWLSE3205W** | **No se ha podido poner el tiempo de ejecución "{0}" en el servidor "{1}" en modo de denegación de servicio. Puede omitir este aviso si el tiempo de ejecución también está concluyendo.** <br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto puede ocurrir en una granja de servidores si desconecta de la red un nodo de la granja y espera el tiempo suficiente o concluye el servidor. Pero, además, en el proceso normal, se debe producir otra excepción (por ejemplo, una excepción OutOfMemory). |
| **FWLSE3206E** | **No se permite anular el registro del servidor "{0}" para el tiempo de ejecución "{1}" porque aparentemente el servidor todavía está activo.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, podría reproducirlo invocando la API REST para eliminar un nodo de la granja de servidores mientras este nodo todavía se esté ejecutando. |
| **FWLSE3207E** | **No se puede acceder al miembro de la granja de servidores con el ID de servidor "{0}". Vuelva a intentarlo más tarde.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. En teoría, esto puede ocurrir en una granja de servidores si desconecta de la red un nodo de la granja y luego intenta desplegar un wlapp. La transacción fallará y, a continuación, podrá ver este mensaje en el registro de errores (registro de transacciones, accesible mediante la IU). |
| **FWLSE3208E** | **Se ha devuelto un código de estado no válido "{0}". El contenido de la respuesta es "{1}".**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Esto se puede producir siempre que se devuelve un código de estado inesperado desde una invocación REST del servicio de configuración. |
| **FWLSE3209E** | **Se ha producido una excepción durante la invocación del servicio de configuración. El mensaje de excepción es "{0}".**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Esto puede ocurrir siempre que hay problemas con las operaciones CRUD que se ocupan de configuraciones del servicio de configuración. Esta excepción es genérica e incluye varios errores |
| **FWLSE3210E** | **No se ha encontrado el recurso {0} que está intentando exportar.** |
| **FWLSE3211E** | **El parámetro resourceInfos {0} se ha especificado de forma incorrecta. El parámetro debe tener un valor con el formato nombre_recurso \ | \|resourceType.** |

## Mensajes de {{ site.data.keys.mf_console }} 

**Prefijo:** FWLSE<br/>
**Rango:** 3300-3399

| **FWLSE3301E** | **Problemas con los certificados SSL. Arreglos posibles: Coloque el certificado del servidor de aplicaciones en el almacén de confianza. O defina la propiedad JNDI {0} en {1} (no en los entornos de producción).**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Difícil. Se produce si configura el servidor con SSL pero utiliza un certificado SSL erróneo. También se puede producir con certificados autofirmados bajo determinadas circunstancias. |
| **FWLSE3302E** | **El almacén de claves del tiempo de ejecución "{0}" no existe en la base de datos de MobileFirst Administration. Es posible que la base de datos esté dañada.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> si el almacén de claves no está presente |
| **FWLSE3303E** | **El nombre de la aplicación "{0}", entorno "{1}" y versión "{2}" de los datos de recurso web/autenticación no coinciden con los de la aplicación desplegada.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Cargue un recurso web generado para una aplicación diferente |
| **FWLSE3304E** | **La propiedad JNDI "{0}" no se ha establecido. No se ha habilitado el servicio push en este servidor.**
<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Proporcione un url de servidor push incorrecto |
| **FWLSE3305E** | **El alias del almacén de claves no puede ser nulo.**<br/><br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> intente cargar un almacén de claves y omita los campos de contraseña y alias. |
| **FWLSE3306E** | **El alias del almacén de claves no puede ser nulo.**|
| **FWLSE3307E** | **No se puede encontrar el alias "{0}" en este almacén de claves.** |
| **FWLSE3308E** | **Falta de coincidencia en la contraseña de alias.** |
| **FWLSE3309E** | **El alias de la contraseña no puede ser nulo.**|
| **FWLSE3310W** | **El servidor solo permite desplegar aplicaciones "{0}".** <br/>{::nomarkdown}<i>Pasos a reproducir:</i>{:/}<br/> Intente desplegar las aplicaciones que traspasarán el límite establecido por la propiedad jndi property mfp.admin.max.apps |
