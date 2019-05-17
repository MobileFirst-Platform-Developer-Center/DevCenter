---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Troubleshooting
#relevantTo: [ios,android,windows,javascript]
#weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Resolución de problemas de {{ site.data.keys.product_full }} en IBM Containers
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
Cuando no pueda solucionar un problema que ha surgido cuando trabajaba con {{ site.data.keys.product_full }} en IBM Containers, asegúrese de recopilar esta información clave antes de contactar a IBM Support.

Para agilizar el proceso de resolución de problemas, recopile la información siguiente:

* La versión de {{ site.data.keys.product }} que utiliza (debe ser V8.0.0 o superior) y cualquier arreglo temporal que se haya aplicado.
* El tamaño del contenedor seleccionado. Por ejemplo, Medio 2GB.
* El tipo de plan de base de datos IBM Cloud dashDB. Por ejemplo, EnterpriseTransactional 2.8.50.
* El ID de contenedor
* La dirección IP pública (si está asignada)
* Versiones de Docker y Cloud Foundry: `cf -v` y `docker version`
* La información que devuelve la ejecución de los siguientes mandatos del plugin de Cloud Foundry CLI para IBM Containers (cf ic) desde la organización y espacio en que se ha desplegado su contenedor {{ site.data.keys.product }}:
 - `cf ic info`
 - `cf ic ps -a` (Si se lista más de una instancia de contenedor, asegúrese de que indica la instancia que tiene un problema).
* Si SSH (Secure Shell) y los volúmenes se han habilitado durante la creación del contenedor (al ejecutar el script **startserver.sh**), recopile todos los archivos de las carpetas siguientes: /opt/ibm/wlp/usr/servers/mfp/logs y /var/log/rsyslog/syslog
* Si solo se ha habilitado el volumen y no SSH, recopile la información de registro disponible utilizando el panel de control de IBM Cloud. Después de pulsar la instancia del contenedor en el panel de control de IBM Cloud, pulse el enlace Supervisión y Registros en la barra lateral. Vaya al separador Registro y pulse VISTA AVANZADA. El panel de control de Kibana se abre por separado. Mediante la barra de herramientas de búsqueda, busque el rastreo de la pila de excepciones y recopile todos los detalles de la excepción, @time-stamp, _id.

### Error relacionado con Docker durante la ejecución del script
{: #docker-related-error-while-running-script }
Si encuentra errores relacionados con Docker durante la ejecución del script initenv.sh o prepareserver.sh, intente reiniciar el servicio de Docker.

**Mensaje de ejemplo**

> Extracción del repositorio docker.io/library/ubuntu  
> Error while pulling image: Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS message ID mismatch

**Descripción**  
Es posible que se produzca el error si se ha cambiado la conexión de internet (por ejemplo, si se conecta o desconecta de una VPN o si la configuración de red cambia) y el entorno de tiempo de ejecución de Docker todavía no se ha reiniciado. En este escenario, se puede producir problemas cuando se emite cualquier mandato de Docker.

**Cómo se resuelve**  
Reinicie el servicio de Docker. Si el error persiste, reinicie el sistema y, a continuación, reinicie el servicio de Docker.

### Error de registro de IBM Cloud
{: #bluemix-registry-error }
Si encuentra un error relacionado con el registro después de ejecutar el script prepareserver.sh o prepareanalytics.sh intente ejecutar en primer lugar el script initenv.sh.

**Descripción**  
En general, cualquier problema que se produzca durante la ejecución de los scripts prepareserver.sh o prepareanalytics.sh puede ser la causa de que se cuelgue el proceso y falle.

**Cómo se resuelve**  
En primer lugar, vuelva a ejecutar el script initenv.sh para iniciar sesión en el registro del contenedor en IBM Cloud. A continuación, vuelva a ejecutar el script que ha fallado anteriormente.

### No se ha podido crear el archivo mfpfsqldb.xml
{: #unable-to-create-the-mfpfsqldbxml-file }
Se produce un error al final de la ejecución del script **prepareserverdbs.sh**:

> Error: No se puede crear mfpfsqldb.xml

**Cómo se resuelve**  
Es posible que se trate de un problema intermitente de conexión de base de datos. Intente ejecutar de nuevo el script.

### Hacer push en la imagen tarda mucho tiempo
{: #taking-a-long-time-to-push-image }
Cuando se ejecuta el script prepareserver.sh, se tarda más de 20 minutos en hacer push en una imagen para el registro de IBM Containers.

**Descripción**  
El script **prepareserver.sh** hace push a toda la pila de {{ site.data.keys.product }}, lo cual puede tardar entre 20 y 60 minutos.

**Cómo se resuelve**  
Si el script no se ha completado después de un periodo de tiempo de 60 minutos, es posible que se haya colgado el proceso debido a un problema de conexión. Después de restablecer una conexión estable, reinicie el script.

### Error de enlace incompleto
{: #binding-is-incomplete-error }
Cuando ejecuta un script para iniciar un contenedor (por ejemplo **startserver.sh** o **startanalytics.sh**) se le solicita que enlace manualmente una dirección IP debido a un error de enlace incompleto.

**Descripción**  
El script se ha diseñado de modo que finaliza después de un periodo de tiempo determinado.

**Cómo se resuelve**  
Enlace manualmente la dirección IP ejecutando el mandato cf ic relacionado. Por ejemplo, cf ic ip bind.

Si el enlace manual de la dirección IP no se realiza correctamente, asegúrese de que el contenedor esté en ejecución y vuelva a intentar el enlace.  
**Nota:** Los contenedores deben estar en ejecución para poder enlazarlos correctamente.

### El script falla y devuelve un mensaje relacionado con las señales
{: #script-fails-and-returns-message-about-tokens }
Un script no se ejecuta correctamente y devuelve un mensaje similar a: Renovando las señales o Ha fallado la renovación de la señal.

**Descripción**  
Es posible que se haya superado el tiempo de espera de la sesión IBM Cloud. El usuario debe haber iniciado sesión en IBM Cloud antes de ejecutar los scripts del contenedor.

**Cómo se resuelve**
Vuelva a ejecutar el script initenv.sh para iniciar sesión en IBM Cloud y, a continuación, vuelva a ejecutar el script que ha fallado.

### La base de datos de administración, Live Update y Push Service se muestran como inactivos
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
La base de datos de administración, Live Update y Push Service se muestran como inactivos o no figura listado ningún tiempo de ejecución en {{ site.data.keys.mf_console }}, a pesar de que el script **prepareserver.sh** se ha completado correctamente.

**Descripción**  
Es posible que no se haya podido establecer una conexión con el servicio de base de datos o que se haya producido un problema de formato en el archivo server.env cuando se han añadido valores adicionales durante el despliegue .

Si se han añadido valores adicionales al archivo server.env sin caracteres de nueva línea, las propiedades no se resuelven. Puede validar este problema potencial comprobando si hay errores en los archivos de registro debido a propiedades no resueltas similares a este error:

> FWLSE0320E: No se ha podido comprobar si los servicios de administración están preparados. Causa: [project Sample] java.net.MalformedURLException: Host anómalo: "${env.IP_ADDRESS}"

**Cómo se resuelve**  
Reinicie manualmente los contenedores. Si el problema persiste, compruebe si el número de conexiones con el servicio de base de datos supera el número de conexiones suministrado por su plan de base de datos. Si es así, realice los ajustes necesarios antes de continuar.

Si el problema es debido a propiedades no resueltas, asegúrese de que su editor añade el carácter de salto de línea (LF) para marcar el fin de una línea, cuando edite cualquier archivo suministrado. Por ejemplo, la aplicación TextEdit en macOS puede utilizar el carácter CR para marcar el final de la línea, en lugar de LF, lo que puede ser la causa del problema.

### El script prepareserver.sh falla
{: #prepareserversh-script-fails }
El script **prepareserver.sh** falla y devuelve el error 405 Método no permitido.

**Descripción**  
Se produce el siguiente error cuando se ejecuta el script **prepareserver.sh** para hacer push en la imagen para el registro de IBM Containers.

> Haciendo push para la imagen {{ site.data.keys.mf_server }} para el registro de IBM Containers.  
> Respuesta de error del daemon:  
> 405 Método no permitido  
> Método no permitido  
> El método no está permitido para el URL solicitado.

Normalmente, este error ocurre si se han modificado las variables de Docker en el entorno de host. Después de ejecutar el script initenv.sh, la herramienta proporciona una opción para reemplazar el entorno de Docker local y conectar con IBM Containers utilizando mandatos de Docker nativos.

**Cómo se resuelve**  
No modifique las variables de Docker (tales como DOCKER\_HOST y DOCKER\_CERT\_PATH) de modo que apunten al entorno de registro de IBM Containers. Para que el script **prepareserver.sh** funcione correctamente, las variables de Docker deben apuntar al entorno de Docker local.
