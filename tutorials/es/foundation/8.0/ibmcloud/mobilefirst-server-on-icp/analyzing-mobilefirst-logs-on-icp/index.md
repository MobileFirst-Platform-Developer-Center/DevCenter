---
layout: tutorial
title: Análisis de mensajes de registro de MobileFirst en IBM Cloud Private
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

En despliegues de {{ site.data.keys.prod_adj }} en {{ site.data.keys.prod_icp }}, al ejecutar Liberty subyacente con el registro del formato JSON en la consola, los sucesos de registro se pueden descomponer en campos y se pueden almacenar en Elasticsearch. Puede utilizar Kibana para supervisar varios pods de Liberty con paneles de control y buscar o puede filtrar un gran número de registros de registro con consultas.

Un despliegue de Kubernetes se compone de pods, que están compuestos de contenedores. En {{ site.data.keys.prod_icp }}, la salida de la consola de cada pod se reenvía a la pila de registro elástica incorporada automáticamente. Para obtener más información sobre el registro elástico, consulte [Registro de {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html).


## Procedimiento
{: #procedure}

Complete los pasos para examinar el catálogo de {{ site.data.keys.prod_icp }} y seleccione el gráfico de Helm apropiado, que se utiliza para desplegar aplicaciones.

1.  Habilite el registro de JSON en el gráfico de Helm.

      a.  Desde la consola de {{ site.data.keys.prod_icp }}, pulse **Menú > Catálogo**.<br/>
      b.  Seleccione el gráfico de Helm de **ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod**, en la sección **Registros**.<br/>
          **Nota:** Si el catálogo de Helm no contiene este gráfico de Helm al acceder a la consola, seleccione **Gestionar > Repositorios de Helm** y pulse el botón para sincronizar repositorios para renovar el catálogo.


      c.  Establezca los campos de Registro en los siguientes valores predeterminados; como alternativa, puede establecer los valores anteriores al desplegar el gráfico de Helm de {{ site.data.keys.prod_adj }} desde la línea de mandatos utilizando el distintivo `--set`.<br/>
      <p><b>Campos y valores del gráfico de Helm para el registro de JSON</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>Nombre de campo de GUI</th>
            <th> Nombre de campo de línea de mandatos</th>
            <th>Valor de campo</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Formato de registro de la consola </td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>Nivel de registro de la consola</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>Origen del registro de la consola</td>
            <td>logs.consoleLogLevel</td>
            <td>message, trace, accessLog, ffdc<br/><br/>Los tipos de orígenes soportados son: messages, traces, accessLog o ffdc.  <br/>Especifique cada tipo de origen de en una lista separada por comas en el origen de registro de la consola. <br/>El uso de accessLog requiere parámetros adicionales en el archivo <code>server.xml</code>. <br/>Para obtener más información, consulte <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">Registro de acceso de HTTP</a>.</td>
          </tr>
        </tbody>
      </table>
2.  Despliegue Kibana.<br/>
    Una vez que haya desplegado Liberty con el registro de JSON habilitado, los registros de registro se almacenan en Elasticsearch, y puede ver los registros de registro con Kibana.<br/>

      a.  Para desplegar Kibana, desde la consola, pulse **Catálogo > Gráficos de Helm**.<br/>
      b.  Seleccione el gráfico de Helm **ibm-icplogging-kibana** y pulse **kube-system** en el espacio de nombres de destino.<br/>
      c.  Pulse **Instalar**.<br/>

3.  Abra Kibana.<br/>

      a.  Pulse **Acceso de red > Servicios** desde la consola.<br/>
      b.  Seleccione **Kibana** de la lista de servicios.<br/>
      c.  Pulse el enlace del campo **Puerto de nodo** para abrir Kibana.<br/>

4.  Cree un patrón de índice en Kibana.<br/>

      a.  Desde Kibana, pulse **Gestión > Patrones de índice**. Escriba `logstash-*` para el nombre de índice o patrón.<br/>
      b.  Seleccione **ibm_datetime** como el nombre de campo de *Filtro de tiempo*.<br/>
      c.  Pulse **Crear**.<br/>

5. Puede crear sus propias consultas, visualizaciones o paneles de control para analizar los datos de registro.

6. Descargue un conjunto de paneles de control de ejemplo desde [aquí](https://github.com/WASdev/sample.dashboards). Para importar paneles de control en Kibana, seleccione **Gestión > Objetos guardados**, pulse **Importar**.

## Lectura adicional
{: #further_reading}

* [Registro de Liberty en {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
