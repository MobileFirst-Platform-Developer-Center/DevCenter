---
layout: tutorial
title: Registro y rastreo en IBM Cloud Private
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} registra los errores, los avisos y los mensajes informativos en un archivo de registro. El mecanismo subyacente de registro varía en función del servidor de aplicaciones. En {{ site.data.keys.prod_icp }}, el único servidor de aplicaciones admitido es Liberty.

El documento siguiente explica cómo habilitar el rastreo y recopilar los registros de {{ site.data.keys.mf_server }} que se ejecuta en Kubernetes Cluster en {{ site.data.keys.prod_icp }}.


#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Configurar el mecanismo de registro y supervisión](#configure-log-monitor)
* [Recopilación de los registros de *kubectl*](#collect-kubectl-logs)
* [Recopilación de registros mediante un script personalizado proporcionado por IBM](#collect-logs-custom-script)


## Requisitos previos
{: #prereqs}

Instale y configure las siguientes herramientas necesarias para la recopilación de registros y la resolución de problemas:
* Docker (`docker`)
* Kubernetes CLI (`kubectl`)

Para configurar el cliente `kubectl` para el clúster que se ejecuta en {{ site.data.keys.prod_icp }}, siga los pasos descritos [aquí](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html).


## Configurar el mecanismo de registro y supervisión
{: #configure-log-monitor}

De forma predeterminada, todos los registros de {{ site.data.keys.product }} van a los archivos de registro del servidor de aplicaciones. Las herramientas estándar que están disponibles en Liberty pueden utilizarse para controlar el registro del servidor de {{ site.data.keys.product }}. Obtenga más información en la documentación de [Configuración de los mecanismos de registro y supervisión](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html).

En [Configuración de los mecanismos de registro y supervisión](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html), se detalla cómo actualizar `server.xml` para configurar el registro y se proporciona información sobre la habilitación del rastreo. Utilice el filtro `com.ibm.ws.logging.trace.specification` para habilitar el rastreo de forma selectiva, [más información](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html). Esta propiedad puede especificarse mediante `jvm.option` o en `bootstrap.properties` de la instancia de servidor.

Por ejemplo, al añadir la siguiente entrada a `jvm.options`, se habilita el rastreo para todos los métodos que empiezan por `com.ibm.mfp` y el nivel de rastreo se establece en *all*.
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```
 También puede definir esta entrada mediante la configuración JNDI. Para obtener más información, consulte [aquí]({{ site.baseurl }}/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server).


## Recopilación de los registros de *kubectl*
{: #collect-kubectl-logs}

El mandato `kubectl logs` puede utilizarse para obtener información sobre el contenedor desplegado en Kubernetes Cluster. Por ejemplo, el siguiente mandato recupera los registros para el pod, cuyo *pod_name* se proporciona en el mandato:

```bash
kubectl logs po/<pod_name>
```
Para obtener más información sobre el mandato `kubectl logs`, consulte la [documentación de Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/).

## Recopilación de registros mediante un script personalizado proporcionado por IBM
{: #collect-logs-custom-script}

Los registros de contenedor y los registros de {{ site.data.keys.mf_server }} se pueden recopilar mediante el script [get-icp-logs.sh](get-icp-logs.sh). Utiliza *Helm release name* como entrada y recopila los registros de todos los pods desplegados.

El script se puede ejecutar de la forma siguiente:
```bash
get-icp-logs <helm_release_name> [<output_directory>] [<name_space>]
```
La tabla siguiente describe cada uno de los parámetros utilizados por el script personalizado.

| Opción | Descripción | Observaciones |
|--------|-------------|---------|
| helm_release_name | Nombre de release de la instalación del gráfico Helm respectivo | **Obligatorio** |
| output_directory | Directorio de salida donde se colocan los registros recopilados | **Opcional**<br/>Valor predeterminado: **mfp-icp-logs** en el directorio de trabajo actual. |
| name_space | Espacio de nombres donde se instala el gráfico Helm respectivo | **Opcional**<br/>Valor predeterminado: **default** |
