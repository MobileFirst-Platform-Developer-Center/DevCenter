---
layout: tutorial
title: Adaptadores JavaScript
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

Los adaptadores JavaScript proporcionan plantillas para la conexión con sistemas de fondo SQL y HTTP.
Proporcionan un conjunto de servicios, denominados procedimientos. Las aplicaciones móviles pueden llamar a estos procedimientos mediante solicitudes AJAX.


**Requisito previo:** Asegúrese de leer primero la guía de aprendizaje [Creación de adaptadores Java y JavaScript](../creating-adapters).


## Estructura de archivos
{: #file-structure }

![mvn-adapter](js-adapter-fs.png)

### Carpeta adapter-resources 
{: #the-adapter-resources-folder }

La carpeta **adapter-resources** contiene un archivo de configuración XML.
Este archivo de configuración describe las opciones de conectividad y lista los procedimientos expuestos para la aplicación u otros adaptadores.


```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">
    <displayName>JavaScriptAdapter</displayName>
    <description>JavaScriptAdapter</description>

    <connectivity>
        <connectionPolicy>
        ...
        </connectionPolicy>
    </connectivity>

    <procedure name="procedure1"></procedure>
    <procedure name="procedure2"></procedure>

    <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a name="click-for-adapter-xml-attributes-and-subelements" class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Pulse para los subelementos y atributos de adapter.xml</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><code>name</code>: <i>Obligatorio.</i> Nombre del adaptador. Este nombre debe ser exclusivo dentro de {{ site.data.keys.mf_server }}.
Puede contener caracteres alfanuméricos y subrayados, y debe comenzar con una letra.
Después de definir y desplegar un adaptador, no puede modificar su nombre.
</li>
					<li><b>&lt;displayName&gt;</b>: <i>Opcional.</i> Nombre del adaptador que se visualiza en {{ site.data.keys.mf_console }}.
Si no se especifica este elemento, se utiliza en su lugar el valor del atributo name.
</li>
					<li><b>&lt;description&gt;</b>: <i>Opcional.</i> Información adicional sobre el adaptador.
Se visualiza en {{ site.data.keys.mf_console }}.</li>
					<li><b>&lt;connectivity&gt;</b>: <i>Obligatorio.</i> Define el mecanismo por el que el adaptador se conecta a la aplicación de fondo. Contiene el subelemento &lt;connectionPolicy&gt;.
<ul>
                            <li><b>&lt;connectionPolicy&gt;</b>: <i>Obligatorio</i>. Define las propiedades de conexión.
La estructura de este subelemento depende de la tecnología de integración de la aplicación de fondo.
Para obtener más información sobre &lt;connectionPolicy&gt;, consulte el <a href="js-http-adapter">elemento &lt;connectionPolicy&gt; del adaptador HTTP</a> y el <a href="js-sql-adapter">elemento &lt;connectionPolicy&gt; del adaptador SQL</a>.
</li>
                        </ul>
                    </li>
                    <li><b>&lt;procedure&gt;</b>: <i>Obligatorio</i>.
Define un proceso para acceder a un servicio que una aplicación de fondo expone.
<ul>
                            <li><code>name</code>: <i>Obligatorio.</i> Nombre del procedimiento.
Este nombre debe ser exclusivo dentro del adaptador.
Puede contener caracteres alfanuméricos y subrayados, y debe comenzar con una letra.
</li>
                            <li><code>audit</code>: <i>Opcional.</i> Define si las llamadas al procedimiento se registran en el registro de auditoría.
Los siguientes valores son válidos:
<ul>
                                    <li><code>true</code>: Las llamadas al procedimiento se registran en el registro de auditoría.
</li>
                                    <li><code>false</code>: Predeterminado.
Las llamadas al procedimiento no se registran en el registro de auditoría.
</li>
                                </ul>
                            </li>
                            <li><code>scope</code>: <i>Opcional.</i> Ámbito de seguridad que protege el procedimiento de recurso del adaptador.
El ámbito puede ser una serie de uno o varios elementos de ámbito separados por espacios, o un valor nulo para aplicar el ámbito predeterminado.
Un elemento de ámbito puede ser una palabra clave que se correlaciona con una comprobación de seguridad, o el nombre de una comprobación de seguridad.
El ámbito predeterminado es <code>RegisteredClient</code>, que es una palabra clave reservada de {{ site.data.keys.product_adj }}.
La protección predeterminada precisa de una señal de acceso para acceder al recurso.
<br/>
								Para obtener más información sobre la protección de recursos OAuth de {{ site.data.keys.product_adj }} y de cómo configurar la protección de recursos de adaptador de JavaScript, consulte <a href="../../authentication-and-security/#protecting-adapter-resources">Protección de recursos de adaptador</a>.<br/>
								Cuando el valor el atributo <code>secured</code> es <code>false</code> se ignora el atributo <code>scope</code>.
</li>
                            <li><code>secured</code>: <i>Opcional.</i>
Define si el procedimiento de adaptador procedimiento está protegido por la infraestructura de seguridad de {{ site.data.keys.product_adj }}.
Los siguientes valores son válidos:
<ul>
                                    <li><code>true</code>: Predeterminado.
El procedimiento está protegido.
Las llamadas al procedimiento requieren una señal de acceso válida.
</li>
                                    <li><code>false</code>. El procedimiento no está protegido.
Las llamadas al procedimiento no necesitan una señal de acceso.
Consulte <a href="../../authentication-and-security/#unprotected-resources">Recursos no protegidos</a>.
Cuando se establece este valor, se ignora el atributo <code>scope</code>.
</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><b>&lt;securityCheckDefinition&gt;</b>: <i>Opcional.</i> Define un objeto de comprobación de seguridad.
Obtenga más información sobre comprobaciones de seguridad en la guía de aprendizaje <a href="../../authentication-and-security/creating-a-security-check">Creación de comprobaciones de seguridad</a>.
</li>
        			<li><code>property</code>: <i>Opcional.</i> Declara una propiedad definida por el usuario.
Obtenga más información en la sección <a href="#custom-properties">Propiedades personalizadas</a> de esta guía de aprendizaje.
</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>

#### Propiedades personalizadas
{: #custom-properties }

El archivo **adapter.xml** también puede contener propiedades personalizadas definidas por el usuario.
Los valores que los desarrolladores les asignan durante la creación del adaptador se pueden modificar en el separador **{{ site.data.keys.mf_console }} → [su adaptador] → Configuraciones**, sin tener que volver a desplegar el adaptador.
Las propiedades definidas por el usuario se pueden leer con la [API getPropertyValue](#getpropertyvalue) y, a continuación, personalizar adicionalmente en tiempo de ejecución.


> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Nota:** Los elementos de propiedades de configuración se deben ubicar siempre *debajo* de los elementos &lt;procedure&gt;.
En el ejemplo anterior se definió una propiedad &lt;displayName&gt; con un valor predeterminado, de forma que se podía utilizar más tarde.

El elemento &lt;property&gt; toma los siguientes atributos:


- `name`: Nombre de la propiedad, tal como se define en la clase de configuración.

- `defaultValue`: Modifica el valor predeterminado definido en la clase de configuración.

- `displayName`: *opcional*, nombre descriptivo a visualizar en la consola.

- `description`: *opcional*, descripción a visualizar en la consola.

- `type`: *opcional*, asegura que la propiedad es de un tipo específico como, por ejemplo, `integer`, `string`, `boolean` o una lista de valores válidos (por ejemplo `type="['1','2','3']"`).


![Propiedades de la consola](console-properties.png)

#### Operaciones pull y push
{: #pull-and-push-configurations }

Las propiedades del adaptador personalizado se pueden compartir mediante el archivo de configuración que se encuentra en el separador de **Archivos de configuración**.
  
Para ello, utilice los mandatos `pull` y `push` que se describen más abajo mediante Maven o mediante {{ site.data.keys.mf_cli }}.
Para poder compartir las propiedades, es necesario *cambiar los valores predeterminados asignados a las propiedades*.

Ejecute los mandatos desde la carpeta raíz del proyecto Maven de adaptador: 

**Maven**  

* Para hacer **pull** al archivo de configuraciones  
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```

* Para hacer **push** al archivo de configuraciones
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* Para hacer **pull** al archivo de configuraciones
  ```bash
  mfpdev adapter pull
  ```

* Para hacer **push** al archivo de configuraciones
  ```bash
  mfpdev adapter push
  ```

#### Hacer push a configuraciones a varios servidores
{: #pushing-configurations-to-multiple-servers }

Los mandatos **pull** y **push** ayudan a crear varios flujos de DevOps, donde distintos valores son necesarios en los adaptadores según el entorno en que se encuentre (DEV, QA, UAT, PRODUCTION).

**Maven**  
Observe más arriba cómo de forma predeterminada especifica un archivo **config.json**.
Cree archivos con nombre diferentes para dirigirse a distintos destinos.


**{{ site.data.keys.mf_cli }}**  
Utilice el distintivo **--configFile** o **-c** para especificar un archivo de configuración diferente que el predeterminado:


```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> Obtenga más información utilizando `mfpdev help adapter pull/push`.

### Carpeta js 
{: #the-js-folder }

Esta carpeta contiene todos los archivos de implementación JavaScript de los procedimientos que se declaran en el archivo **adapter.xml**.
También puede contener ninguno, uno o varios archivos XSL, con un esquema de transformación para datos XML recuperados sin procesar.
Los datos que un adaptador recupera se pueden devolver sin procesar o procesados de forma previa por el propio adaptador.
En ambos casos, se presenta a la aplicación como un **objeto JSON**.

## Procedimientos de adaptador de JavaScript
{: #javascript-adapter-procedures }

Los procedimientos se declaran en XML y se implementan con JavaScript del lado del servidor, para los siguientes propósitos:


* Para proporcionar funciones de adaptador para la aplicación
* Para llamar a servicios de fondo para recuperar datos o realizar acciones

Cada uno de los procedimientos que se declara en el archivo **adapter.xml** debe tener la correspondiente función en el archivo JavaScript.


Mediante la utilización de JavaScript del lado del servidor, un procedimiento puede procesar los datos antes o después de que llame al servicio.
Se pueden aplicar filtrado adicional para recuperar datos mediante la utilización de código XSLT simple.
  
Los procedimientos del adaptador JavaScript se implementan en JavaScript.
Sin embargo, puesto que un adaptador es una entidad en el lado del servidor, es posible [utilizar código Java en el adaptador](../javascript-adapters/using-java-in-javascript-adapters).


### Utilización de variables globales
{: #using-global-variables }

{{ site.data.keys.mf_server }} no se basa en sesiones HTTP y cada solicitud puede dirigirse a un nodo diferente.
No se debería basar en variables globales para mantener datos desde una solicitud a la siguiente.


### Umbral de respuesta del adaptador
{: #adapter-response-threshold }

Las llamadas del adaptador no están diseñadas para devolver grandes estructuras de datos porque la respuesta del adaptador se almacena en la memoria de {{ site.data.keys.mf_server }} como una serie.
Por lo tanto, los datos que sobrepasen la cantidad de memoria disponible pueden originar excepciones de falta de memoria y hacer que falle la invocación al adaptador.
Para evitar dichas anomalías, configure un valor de umbral a partir del cual {{ site.data.keys.mf_server }} devuelva las respuestas HTTP comprimidas con gzip.
El protocolo HTTP tiene cabeceras estándar para dar soporte a la compresión gzip.
La aplicación de cliente también debe poder dar soporte a contenido gzip en HTTP.


#### Lado del servidor 
{: #server-side }

En {{ site.data.keys.mf_console }}, bajo **Tiempos de ejecución > Valores > Umbral de compresión de GZIP para respuestas de adaptador**, establezca el valor de umbral deseado.
El valor predeterminado es de 20 KB.
  
**Nota:** Una vez guardado el cambio en {{ site.data.keys.mf_console }}, es efectivo de forma inmediata en el tiempo de ejecución.


#### Lado del cliente
{: #client-side }

Asegúrese de habilitar el cliente para analizar una respuesta gzip, estableciendo el valor de la cabecera `Accept-Encoding` en `gzip` en cada solicitud de cliente.
Utilice el método `addHeader` con su variable de solicitud, por ejemplo:`request.addHeader("Accept-Encoding","gzip");`

## API del lado del servidor
{: #server-side-apis }

Los adaptadores JavaScript pueden utilizar API del lado del servidor para realizar operaciones relacionadas con {{ site.data.keys.mf_server }}, como por ejemplo, llamar a otros adaptadores JavaScript, crear registros de servidor, obtener valores de las propiedades de configuración, crear informes de actividades para las analíticas u obtener la identidad del emisor de solicitudes.
  

### getPropertyValue
{: #getpropertyvalue }

Utilice la API `MFP.Server.getPropertyValue(propertyName)` para recuperar las propiedades definidas en **adapter.xml** o en {{ site.data.keys.mf_console }}:


```js
MFP.Server.getPropertyValue("name");
```

### getTokenIntrospectionData
{: #gettokenintrospectiondata }

Utilice la API `MFP.Server.getTokenIntrospectionData()` para: 

Obtener el ID de usuario actual utilice:


```js
function getAuthUserId(){
   var securityContext = MFP.Server.getTokenIntrospectionData();
   var user = securityContext.getAuthenticatedUser();

   return "User ID: " + user.getId;
}
```

### getAdapterName
{: #getadaptername }

Utilice la API `getAdapterName()` para recuperar el nombre de adaptador.


### invokeHttp
{: #invokehttp }

Utilice la API `MFP.Server.invokeHttp(options)` en adaptadores HTTP.
  
Utilice los ejemplos de uso en la guía de aprendizaje [Adaptador JavaScript HTTP](js-http-adapter).


### invokeSQL
{: #invokesql }

Utilice las API `MFP.Server.invokeSQLStatement(options)` y `MFP.Server.invokeSQLStoredProcedure(options)` en adaptadores de SQL.
  
Utilice los ejemplos de uso en la guía de aprendizaje [Adaptador JavaScript SQL](js-sql-adapter).


### addResponseHeader
{: #addresponseheader }

Utilice la API `MFP.Server.addResponseHeader(name,value)` para añadir una o varias nuevas cabeceras a la respuesta:


```js
MFP.Server.addResponseHeader("Expires","Sun, 5 October 2014 18:00:00 GMT");
```
### getClientRequest
{: #getclientrequest }

Utilice la API `MFP.Server.getClientRequest()` para obtener una referencia al objeto Java HttpServletRequest que se utilizó para invocar un procedimiento de adaptador:


```js
var request = MFP.Server.getClientRequest();
var userAgent = request.getHeader("User-Agent");
```

### invokeProcedure
{: #invokeprocedure }

Utilice `MFP.Server.invokeProcedure(invocationData)` para llamar a otros adaptadores JavaScript.
  
Utilice los ejemplos de uso en la guía de aprendizaje [Mashup y utilización de adaptador avanzada](../advanced-adapter-usage-mashup).


### Registro 
{: #logging }

La API JavaScript proporciona funcionalidades de registro a través de la clase MFP.Logger.
Contiene cuatro funciones que corresponden a los cuatro niveles de registro estándar.
  
Consulte la guía de aprendizaje [recopilación de registro del lado del servidor](../server-side-log-collection) para obtener más información.


## Ejemplos de adaptador de JavaScript
{:# javascript-adapter-examples }
