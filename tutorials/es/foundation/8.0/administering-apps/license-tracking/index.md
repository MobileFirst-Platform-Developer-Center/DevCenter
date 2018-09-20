---
layout: tutorial
title: Seguimiento de licencia
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El seguimiento de licencia está habilitado de forma predeterminada en {{ site.data.keys.product_full }}, que realiza un seguimiento de las métricas relevantes para la política de licencias como, por ejemplo, dispositivos de cliente activos, dispositivos dirigibles y aplicaciones instaladas. Esta información le ayudará a decidir si el uso actual de {{ site.data.keys.product }} está dentro de los niveles de titularidad de licencia y podrá ayudarle a prevenir posibles violaciones de licencia.

Además, realizando el seguimiento del uso de dispositivos de clientes y determinando si los dispositivos están activos, los administradores de {{ site.data.keys.product_adj }} pueden desactivar los dispositivos que ya no acceden a la plataforma {{ site.data.keys.mf_server }}. Esta situación puede darse si un empleado por ejemplo deja la empresa.

#### Ir a
{: #jump-to }

* [Establecimiento de la información de licencia de la aplicación](#setting-the-application-license-information)
* [Informe de seguimiento de licencia](#license-tracking-report)
* [Validación de licencias de señal](#token-license-validation)
* [Integración con IBM License Metric Tool](#integration-with-ibm-license-metric-tool)

## Establecimiento de la información de licencia de la aplicación
{: #setting-the-application-license-information }
Aprenda a establecer la información de licencia de la aplicación para las aplicaciones que registra en {{ site.data.keys.mf_server }}.

Los términos de la licencia distinguen entre {{ site.data.keys.product_full }}, {{ site.data.keys.product_full }} Consumer (Consumidor), {{ site.data.keys.product_full }} Enterprise (Empresa) e IBM {{ site.data.keys.product_adj }} Additional Brand Deployment (Despliegue de marca adicional). Establezca la información de licencia de una aplicación cuando la registre en un servidor de forma que los informes de seguimiento de licencias generen la información de licencia correcta. Si su servidor está configurado para la gestión de licencias de señal, la información de la licencia se utilizar para extraer la característica correcta del servidor de licencias.

Se establece el Tipo de aplicación y el Tipo de licencia de señal.
Los valores posibles para Tipo de aplicación son:  

* **B2C**: Utilice este tipo de aplicación si la aplicación tiene licencia como consumidor de {{ site.data.keys.product_full }}.
* **B2E**: Utilice este tipo de aplicación si la aplicación tiene licencia como empresa de {{ site.data.keys.product_full }}.
* **UNDEFINED**: Utilice este tipo de aplicación si no necesita realizar un seguimiento del cumplimiento en relación a la métrica Dispositivos dirigibles.

Los valores posibles para el Tipo de licencia de señal son:

* **APPLICATION**: Utilice APPLICATION para la mayoría de las aplicaciones. Éste es el valor predeterminado.
* **ADDITIONAL\_BRAND\_DEPLOYMENT**: Utilice ADDITIONAL\_BRAND\_DEPLOYMENT si su aplicación se licencia como IBM {{ site.data.keys.product_adj }} Additional Brand Deployment.
* **NON_PRODUCTION**: Utilice NON\_PRODUCTION mientras desarrolla o prueba la aplicación en el servidor de producción. Con las aplicaciones que tiene un tipo de licencia de señal NON_PRODUCTION no se extrae ninguna señal.

> **Importante:** La utilización de NON_PRODUCTION para una aplicación de producción es un incumplimiento de los términos de la licencia.

**Nota:** Si su servidor está configurado para la gestión de licencias de señal y tiene previsto registrar una aplicación con el Tipo de licencia de señal ADDITIONAL\_BRAND\_DEPLOYMENT o NON_PRODUCTION, establezca la información de licencia de la aplicación antes de registrar la primera versión de la aplicación. El programa mfpadm permite establecer la información de licencia para una aplicación antes que registre una versión. Una vez establecida al información de la licencia, se extraerá el número de señales adecuado cuando haya registrado la primera versión de la aplicación.
Para obtener más información sobre la validación de señales, consulte Validación de licencias de señal.

Para establecer el tipo de licencia con {{ site.data.keys.mf_console }}

1. Seleccione su aplicación
2. Seleccione **Valores**
3. Establezca el **Tipo de aplicación** y el **Tipo de licencia de señal**
4. Pulse **Guardar**

Para establecer el tipo de licencia con el programa mfpadm, utilice `mfpadm app <appname> set license-config <application-type> <token license type>`

En el siguiente ejemplo se establece la información de licencia B2E / APPLICATION a la aplicación denominada **my.test.application**

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## Informe de seguimiento de licencias
{: #license-tracking-report }
{{ site.data.keys.product }} proporciona un informe de seguimiento de licencias para la métrica Dispositivo de cliente, la métrica Dispositivo dirigible y la métrica Aplicación. El informe también proporciona datos históricos.

El informe de seguimiento de licencias muestra los datos siguientes:

* Número de aplicaciones desplegadas en el servidor de {{ site.data.keys.mf_server }}.
* Número de dispositivos dirigibles del mes actual del calendario.
* Número de dispositivos de cliente, tanto activos como fuera de servicio.
* Número de dispositivos de cliente informados en los últimos n días, en el que n es el número de días de inactividad después de que el dispositivo del cliente se haya puesto fuera de servicio.

Es posible que desee analizar los datos con un mayor detalle. Para este propósito, puede descargar un archivo CSV que incluye los informes de licencia así como un listado histórico de las métricas de licencia.

Para acceder al informe de Seguimiento de licencias,

1. Abra {{ site.data.keys.mf_console }}.
2. Pulse el menú **Hola, su_nombre**.
3. Seleccione **Licencias**.

Para obtener un archivo CSV desde el informe de Seguimiento de licencias, pulse **Acciones/Descargar informe**.

## Validación de licencias de señal
{: #token-license-validation }
Si instala y configura IBM {{ site.data.keys.mf_server }} para la gestión de licencias de señal, el servidor valida las licencias en varios escenarios. Si su configuración no es correcta, la licencia no se valida en la supresión o registro de aplicación.

### Escenarios de validación
{: #validation-scenarios }
Las licencias se validan en varios escenarios:

#### En el registro de la aplicación
{: #on-application-registration }
El registro de la aplicación falla si no hay disponibles señales suficientes para el tipo de licencia de su aplicación.

> **Sugerencia:** Puede establecer el tipo de licencia de señal de su aplicación antes de registrar la primera versión de dicha aplicación.

Las licencias se extraen únicamente una vez por aplicación. Si registra una nueva plataforma para la misma aplicación, o si registra una nueva versión de una aplicación y plataforma existente, no se requiere ninguna nueva señal.

#### Cambio en el tipo de licencia de señal
{: #on-token-license-type-change }
Cuando cambia el Tipo de licencia de señal de una aplicación, las señales para la aplicación se liberan y, a continuación, se toman de nuevo para el nuevo tipo de licencia.

#### En la supresión de la aplicación
{: #on-application-deletion }
Las licencias se incorporan cuando se suprime la última versión de una aplicación.

#### Al iniciar el servidor
{: #at-server-start }
Se extrae la licencia de cada aplicación registrada. El servidor desactiva las aplicaciones si no hay disponbiles señales suficientes para todas las aplicaciones.

> **Importante:** El servidor no reactiva el automáticamente las aplicaciones. Después de incrementar el número de señales disponibles, debe reactivar las aplicaciones de forma manual. Para obtener más información sobre cómo inhabilitar y habilitar aplicaciones, consulte [Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Al caducar la licencia
{: #on-license-expiration }
Después de cierto tiempo, la licencia caduca y se debe extraer de nuevo. El servidor desactiva las aplicaciones si no hay disponbiles señales suficientes para todas las aplicaciones.

> **Importante:** El servidor no reactiva el automáticamente las aplicaciones. Después de aumentar el número de señales disponibles, debe volver a activar las aplicaciones manualmente. Para obtener más información sobre cómo inhabilitar y habilitar aplicaciones, consulte [Inhabilitación de forma remota del acceso de la aplicación a recursos protegidos](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Al concluir el servidor
{: #at-server-shutdown }
Durante la conclusión de un servidor se incorporan las licencias de todas las aplicaciones desplegadas. Las señales se liberan solamente cuando se cierra el último servidor del clúster de una granja.

### Causas de errores de validación de licencia
{: #causes-of-license-validation-failure }
En los siguientes casos la validación de las licencias podría fallar cuando se registra o suprime una aplicación:

* La biblioteca nativa de Rational Common Licensing no está instalada y configurada.
* El servicio de administración no está configurado para la gestión de licencias de señal. Para obtener más información, consulte [Instalación y configuración para la gestión de licencias de señal](../../installation-configuration/production/token-licensing).
* No es posible acceder a Rational License Key Server.
* No hay disponibles suficientes señales.
* La licencia ha caducado.

### Nombre de característica de IBM Rational License Key Server utilizada por {{ site.data.keys.product_full }}
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
Dependiendo del tipo de licencia de señal de una aplicación, se utilizan las siguientes características.

|Tipo de licencia de señal |Nombre característica | 
|--------------------|--------------|
|APPLICATION        | 	ibmmfpfa    | 
|ADDITIONAL\_BRAND\_DEPLOYMENT |	ibmmfpabd | 
|NON_PRODUCTION	|(sin característica) | 

## Integración con IBM License Metric Tool
{: #integration-with-ibm-license-metric-tool }
IBM License Metric Tool permite evaluar el cumplimiento de su licencia de IBM.

Si no ha instalado una versión de IBM License Metric Tool que dé soporte a archivos IBM Software License Metric Tag o SWID (identificación de software), puede revisar el uso de la licencia con los informes de Seguimiento de licencias en {{ site.data.keys.mf_console }}. Para obtener más información, consulte [Informe de seguimiento de licencias](#license-tracking-report).

### Acerca de la gestión de licencias basadas en PVU utilizando archivos SWID
{: #about-pvu-based-licensing-using-swid-files }
Si ha comprado una oferta IBM MobileFirst Foundation Extension V8.0.0, se licencia bajo la métrica de unidades de valor de procesador (PVU).

El cálculo de PVU se basa en el soporte de IBM License Metric Tool para archivos SWID e ISO/IEC 19970-2. Los archivos SWID se graban en el servidor cuando IBM Installation Manager instala {{ site.data.keys.mf_server }} o {{ site.data.keys.mf_analytics_server }}. Cuando IBM License Metric Tool descubre un archivo SWID no válido para un producto de acuerdo al catálogo actual, se visualiza una señal de aviso en el widget de Catálogo de software. Para obtener más información sobre cómo funciona IBM License Metric Tool con archivos SWID, consulte [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html).

El número de instalaciones de Application Center no viene limitada por la gestión de licencias basadas en PVU.

La licencia de PVU para Foundation Extension únicamente se puede comprar junto a estas licencias de producto:
IBM WebSphere Application Server Network Deployment, IBM API Connect Professional o IBM API Connect Enterprise. IBM Installation Manager añade o actualiza el archivo SWID que License Metric Tool utilizará.

> Para obtener más información sobre {{ site.data.keys.product_full }} Extension, consulte [https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN).

> Para obtener más información sobre la gestión de licencias de PVU, consulte [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html).

### Etiquetas SLMT
{: #slmt-tags }
IBM MobileFirst Foundation genera archivos IBM Software License Metric Tag (SLMT). Las versiones de IBM License Metric Tool que dan soporte a IBM Software License Metric Tag pueden generar informes de consumo de licencia. Lea esta sección para interpretar estos informes para {{ site.data.keys.mf_server }}, y para configurar la generación de archivos IBM Software License Metric Tag.

Cada instancia de un entorno de tiempo de ejecución de MobileFirst genera un archivo IBM Software License Metric Tag. Las métricas supervisadas son `CLIENT_DEVICE`, `ADDRESSABLE_DEVICE` y `APPLICATION`. Sus valores se renuevan cada 24 horas.

#### Acerca de la métrica CLIENT_DEVICE
{: #about-the-client_device-metric }
La métrica `CLIENT_DEVICE` puede tener los subtipos siguientes:

* Dispositivos activos

    El número de dispositivos de cliente que han utilizado el entorno de ejecución de MobileFirst, u otra instancia de ejecución de MobileFirst perteneciente al mismo clúster o granja de servidores, y que se han decomisionado. Para obtener más información sobre los dispositivos decomisionados, consulte [Configuración del seguimiento de licencias para dispositivos de cliente y dispositivos dirigibles](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

* Dispositivos inactivos

    El número de dispositivos de cliente que han utilizado el entorno de ejecución de MobileFirst, u otra instancia de ejecución de MobileFirst perteneciente al mismo clúster o granja de servidores, y que se han decomisionado. Para obtener más información sobre los dispositivos decomisionados, consulte [Configuración del seguimiento de licencias para dispositivos de cliente y dispositivos dirigibles](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

Los casos siguientes son específicos:

* Si el periodo de decomisionamiento del dispositivo se ha establecido en un período corto, el subtipo "Dispositivos inactivos" se sustituye por el subtipo "Dispositivos activos o inactivos".
* Si el seguimiento de dispositivo se ha inhabilitado, solo se genera una única entrada para `CLIENT_DEVICE`, con el valor 0, y el subtipo de métrica "Seguimiento de dispositivo inhabilitado".

#### Acerca de la métrica APPLICATION
{: #about-the-application-metric }
La métrica APPLICATION no tiene un subtipo a no ser que el entorno de tiempo de ejecución de MobileFirst se esté ejecutando en un servidor de despliegue.

El valor del que informa esta métrica es el número de aplicaciones que están desplegadas en el entorno de tiempo de ejecución de MobileFirst. Cada aplicación se cuenta como una unidad, independientemente de si se trata de una nueva aplicación, un despliegue de marca adicional o un tipo adicional de una aplicación existente (por ejemplo, nativa, híbrida o web).

#### Acerca de la métrica ADDRESSABLE_DEVICE
{: #about-the-addressable_device-metric }
La métrica ADDRESSABLE_DEVICE tiene el siguiente subtipo:

* Aplicación: `<applicationName>`, Categoría: `<application type>`

El tipo de aplicación es **B2C**, **B2E** o **UNDEFINED**. Si desea definir el tipo de una aplicación, consulte [Establecimiento de la información de licencia de la aplicación](#setting-the-application-license-information).

Los casos siguientes son específicos:

* Si el periodo de decomisonamiento del dispositivo se establece en inferior a 30 días, se añade el aviso "Periodo de decomisionamiento breve" al subtipo.
* Si se inhabilita el seguimiento de licencias, no se generan informes dirigibles.

Para obtener más información sobre la configuración del seguimiento de licencias utilizando métricas, consulte

* [Configuración del seguimiento de licencias para dispositivos de cliente y dispositivos dirigibles](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [Configuración de archivos de registro de IBM License Metric Tool](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
