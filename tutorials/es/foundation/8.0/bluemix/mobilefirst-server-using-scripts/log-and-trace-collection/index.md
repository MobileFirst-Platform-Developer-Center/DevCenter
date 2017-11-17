---
layout: tutorial
title: Recopilación de registros y rastreo
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
IBM Containers para Bluemix incluye funciones de registro y supervisión relacionadas con la CPU, la memoria y las redes. Opcionalmente, puede cambiar los niveles de registro para sus contenedores de {{ site.data.keys.product_adj }}.

La opción para crear archivos de registro para contenedores de {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} y {{ site.data.keys.mf_app_center }} está habilitada de forma predeterminada (utilizando el nivel (`*=info`). Puede cambiar los niveles de registro añadiendo una alteración manual de código o inyectando código mediante un archivo de script determinado. Los registros de contenedor, servidor y tiempo de ejecución se pueden visualizar desde una consola logmet de Bluemix mediante la herramienta de visualización Kibana. La supervisión se puede llevar a cabo desde una consola logmet de Bluemix mediante Grafana, un panel de control de métricas de código abierto y un editor de gráficos.

Cuando crea se crea su contenedor {{ site.data.keys.product_adj }} con una clave SSH (Secure Shell) y se enlaza a una dirección IP pública, puede utilizar una clave privada adecuada para ver de forma segura los registros de la instancia del contenedor.

### Alteraciones temporales del registro
{: #logging-overrides }
Puede cambiar los niveles de registro añadiendo una alteración manual de código o inyectando código mediante un archivo de script determinado. La adición de una alteración temporal de código para cambiar el nivel de registro se debe realizar cuando se prepara por primera vez la imagen. Debe añadir la nueva configuración del registro a la carpeta **package\_root/mfpf-[analytics|server]/usr/config** y a la carpeta **package_root/mfp-appcenter/usr/config** como un fragmento de código de configuración separado, que se copia en la carpeta configDropins/overrides del servidor Liberty.

Se puede llevar a cabo la inyección de código mediante un archivo de script concreto utilizando determinados argumentos de línea de mandatos, cuando se ejecuta cualquiera de los archivos de script start\*.sh proporcionados en el paquete V8.0.0 (**startserver.sh**, **startanalytics.sh**, **startservergroup.sh**, **startanalyticsgroup.sh**, **startappcenter.sh**, **startappcentergroup.sh**). Los siguientes argumentos de línea de mandatos son aplicables:

* `[-tr|--trace]` trace_specification
* `[-ml|--maxlog]` maximum\_number\_of\_log\_files
* `[-ms|--maxlogsize]` maximum\_size\_of\_log\_files

## Archivos de registro de contenedor
{: #container-log-files }
Los archivos de registro se generan para las actividades de {{ site.data.keys.mf_server }} y del tiempo de ejecución Liberty Profile de cada instancia de contenedor y se pueden encontrar en las ubicaciones siguientes:

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

Los archivos de registro se generan para las actividades del servidor de {{ site.data.keys.mf_app_center }} y del tiempo de ejecución Liberty Profile de cada instancia de contenedor y se pueden encontrar en las ubicaciones siguientes:

* /opt/ibm/wlp/usr/servers/appcenter/logs/messages.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/console.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/trace.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/ffdc/*

Puede iniciar sesión en el contenedor siguiendo los siguientes pasos que se describen en la sección Acceso a los archivos de registro y, a continuación, podrá acceder a los archivos de registro.

Para que persistan los archivos, incluso después de que deje de existir un contenedor, habilite un volumen. (De forma predeterminada, el volumen no está habilitado). Si habilita un volumen también puede ver los registros desde Bluemix utilizando la interfaz logmet, tal como: //logmet.ng.bluemix.net/kibana.

**Habilitación de un volumen**
Un volumen permite que la persistencia de archivos de registro en contenedores. El volumen para los registros de contenedor de {{ site.data.keys.mf_server }} y de {{ site.data.keys.mf_analyics }} no está habilitado de forma predeterminada.

Puede habilitar el volumen cuando ejecuta los scripts **start*.sh**, estableciendo `ENABLE_VOLUME [-v | --volume]` en `Y`. Esto también se puede configurar en los archivos **args/startserver.properties** y **args/startanalytics.properties** para la ejecución interactiva de los scripts.

Los archivos de registro persistentes se guardan en las carpetas **/var/log/rsyslog** y **/opt/ibm/wlp/usr/servers/mfp/logs** del contenedor.  
Se puede acceder a los registros emitiendo una solicitud SSH para el contenedor.

## Acceso a archivos de registro
{: #accessing-log-files }
Los registros se crean para cada instancia de contenedor. Puede acceder a los archivos de registros utilizando la API REST de IBM Container Cloud Service, mediante los mandatos `cf ic` o mediante la consola logmet de Bluemix.

### API REST de IBM Container Cloud Service
{: #ibm-container-cloud-service-rest-api }
Para cualquier instancia de contenedor, se puede visualizar **docker.log** y **/var/log/rsyslog/syslog** mediante el [servicio logmet de Bluemix](https://logmet.ng.bluemix.net/kibana/). Las actividades del registro se pueden visualizar utilizando el panel de control Kibana similar.

Se pueden utilizar los mandatos de IBM Containers (`cf ic exec`) para acceder a las instancias de contenedor en ejecución. De forma alternativa, puede obtener los archivos de registro de contenedor mediante SSH (Secure Shell).

### Habilitación de SSH
{: #enabling-ssh}
Para habilitar SSH, copie la clave pública SSH en la carpeta **package_root/[mfpf-server o mfpf-analytics]/usr/ssh** antes de ejecutar los scripts **prepareserver.sh** o **prepareanalytics.sh**. Esto crea la imagen con SSH habilitado. Cualquier contenedor creado desde dicha imagen concreta tendrá habilitado SSH.

Si no se habilita SSH como parte de la personalización de la imagen, puede habilitarlo para el contenedor utilizando los argumentos SSH\_ENABLE y SSH\_KEY, cuando ejecuta los scripts **startserver.sh** o **startanalytics.sh** scripts. Opcionalmente, puede personalizar los archivos .properties del script para incluir el contenido de la clave.

El punto final de los registros del contenedor obtiene los registros stdout con el ID de la instancia de contenedor especificado.

Ejemplo: `GET /containers/{container_id}/logs`

#### Acceso a contenedores desde la línea de mandatos
{: #accessing-containers-from-the-command-line }
Puede acceder a las instancias de contenedor de {{ site.data.keys.mf_server }} y de {{ site.data.keys.mf_analytics }} desde la línea de mandatos para obtener los registros y los rastreos.

1. Cree un terminal interactivo en la instancia del contenedor ejecutando el mandato siguiente: `cf ic exec -it container_instance_id "bash"`.
2. Para localizar los archivos de registro o los rastreos, utilice el siguiente mandato de ejemplo:

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
   container_instance@root# vi messages.log
   ```

3. Para copiar los registros en su estación de trabajo local, utilice el siguiente mandato de ejemplo:

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### Acceso a los contenedores mediante SSH
{: #accessing-containers-using-ssh }
Puede obtener los syslogs y los registros de Liberty utilizando SSH (Secure Shell) para acceder a sus contenedores de {{ site.data.keys.mf_server }} y de {{ site.data.keys.mf_analytics }}.

Si está ejecutando un grupo de contenedores, puede enlazar una dirección IP pública con cada instancia y ver los registros de forma segura mediante SSH. Para habilitar SSH, asegúrese de copiar la clave pública de SSH en la carpeta **mfp-server\server\ssh** antes de ejecutar el script **startservergroup.sh**.

1. Realice una solicitud SSH para el contenedor. Ejemplo: `mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. Archive la ubicación del archivo de registro. Ejemplo:

```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

Descargue el archivo de registro en su estación de trabajo. Ejemplo:

```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
