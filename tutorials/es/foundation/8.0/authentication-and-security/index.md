---
layout: tutorial
title: Autenticación y seguridad
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

La infraestructura de seguridad de {{ site.data.keys.product_adj }} se basa en el protocolo [OAuth 2.0](http://oauth.net/). De acuerdo con este protocolo, un recurso puede ser protegido por un **ámbito** que define los permisos requeridos para acceder al recurso. Para acceder a un recurso protegido, el cliente debe proporcionar una **señal de acceso** coincidente que encapsula el ámbito de la autorización que se le garantiza al cliente.

El protocolo OAuth separa los roles del servidor de autorización y el servidor de recursos en el que se aloja el recurso.

* El servidor de autorización gestiona la autorización de cliente y la generación del ámbito.
* El servidor de recursos utiliza el servidor de autorización para validar la señal de acceso que proporciona el cliente y para asegurar que coincide con el ámbito de protección del recurso solicitado.

La infraestructura de seguridad se genera en torno al servidor de autorización que implementa el protocolo OAuth y expone los puntos finales de OAuth con los que el cliente interactúa para obtener señales de acceso. La infraestructura de seguridad proporciona los bloques de creación para implementar una lógica de autorización personalizada además del servidor de autorización y del protocolo OAuth subyacente.
De forma predeterminada, {{ site.data.keys.mf_server }} también funciona con el **servidor de autorización**. Sin embargo, puede configurar un dispositivo IBM WebSphere DataPower para que actúe como el servidor de autorización e interactúe con {{ site.data.keys.mf_server }}.

La aplicación cliente puede utilizar estas señales para acceder a recursos en un **servidor de recursos** que puede ser o {{ site.data.keys.mf_server }} o un servidor externo. El servidor de recursos verifica la validez de la señal para asegurarse de que se le puede otorgar acceso al recurso solicitado al cliente. La separación entre el servidor de recurso y el servidor de autorización le permite imponer seguridad en los recursos que se están ejecutando fuera de {{ site.data.keys.mf_server }}.

Los desarrolladores de aplicación protegen acceso a los recursos definiendo el ámbito necesario para cada recurso protegido e implementando **comprobaciones de seguridad** y **manejadores de desafíos**. La infraestructura de seguridad de lado del servidor y la API del lado del cliente manejan el intercambio del mensaje OAuth y la interacción con el servidor de autorización de manera transparente, y de esta forma permiten a los desarrolladores centrarse solo en la lógica de autorización.

#### Ir a:
{: #jump-to }

* [Entidades de autorización](#authorization-entities)
* [Recursos de protección](#protecting-resources)
* [Flujo de autorización](#authorization-flow)
* [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Entidades de autorización
{: #authorization-entities }

### Señales de acceso
{: #access-tokens }

Una señal de acceso de {{ site.data.keys.product_adj }} es una entidad firmada de forma digital que describe los permisos de autorización de un cliente. Después de otorgarse la solicitud de autorización del cliente para un ámbito específico, y de la autenticación del cliente, el punto final de la señal del servidor de autorización envía al cliente una respuesta HTTP que contiene la señal de acceso solicitada.

#### Estructura
{: #structure }

La señal de acceso de {{ site.data.keys.product_adj }} contiene la información siguiente:

* **ID de cliente**: un identificador único del cliente.
* **Ámbito**: el ámbito al que se otorgó la señal (ver ámbitos de OAuth). Este ámbito no incluye un [ámbito de aplicación obligatorio](#mandatory-application-scope).
* **Hora de vencimiento de la señal**: la hora a partir de la cual la señal se vuelve inválida (caduca), en segundo.

#### Vencimiento de la señal
{: #token-expiration }

La señal de acceso garantizada continua siendo válida hasta que transcurre la hora de caducidad. La hora de caducidad de la señal de acceso se establece en el tiempo más corto de todas las horas de caducidad posibles de las comprobaciones de seguridad en el ámbito. Pero si el período hasta la hora de caducidad más breve es más largo que el período de vencimiento de señal máximo de la aplicación, la hora de caducidad de la señal se establece en el tiempo actual más el período de vencimiento máximo. El período de vencimiento de señal máximo predeterminado (duración de validación) es 3,600 segundos (1 hora), pero puede configurarse estableciendo el valor de la propiedad `maxTokenExpiration`. Consulte Configuración del período de vencimiento de señal de acceso máximo.

<div class="panel-group accordion" id="configuration-explanation" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="access-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>Configuración del período de vencimiento de señal de acceso máximo</b></a>
            </h4>
        </div>

        <div id="collapse-access-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="access-token-expiration">
            <div class="panel-body">
            <p>Configure el período de vencimiento de señal de acceso máximo de la aplicación utilizando uno de los métodos alternativos siguientes:</p>
            <ul>
                <li>Utilización de {{ site.data.keys.mf_console }}
                    <ul>
                        <li>Seleccione el separador <b>[su aplicación] → Seguridad</b>.</li>
                        <li>En la sección <b>Configuración de señal</b>, establezca el valor del campo <b>Período de vencimiento de señal máximo (segundos)</b> a su valor preferido, y pulse <b>Guardar</b>. Puede repetir este procedimiento, en cualquier momento, para modificar el período de vencimiento de señal máximo, o seleccionar <b>Restaurar valores predeterminados</b> para restaurar el valor predeterminado.</li>
                    </ul>
                </li>
                <li>Edición del archivo de configuración de la aplicación
                    <ol>
                        <li>Desde una <b>ventana de línea de mandatos</b>, navegue a la carpeta de raíz de proyecto y ejecute la <code>extracción de la aplicación mfpdev</code>.</li>
                        <li>Abra el archivo de configuración, ubicado en la carpeta <b>[project-folder]\mobilefirst</b>.</li>
                        <li>Edite el archivo definiendo la propiedad <code>maxTokenExpiration</code> y establezca el valor al período de vencimiento de señal de acceso máximo, en segundos:

{% highlight xml %}
{
    ...
    "maxTokenExpiration": 7200
}
{% endhighlight %}</li>
                        <li>Despliegue el archivo JSON de configuración actualizando ejecutando el mandato: <code>envío de aplicación mfpdev</code>.</li>
                    </ol>
                </li>
            </ul>

            <br/>
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>Cerrar sección</b></a>
            </div>
        </div>
    </div>
</div>

<div class="panel-group accordion" id="response-access-token" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="response-structure">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>Estructura de respuesta de señal de acceso</b></a>
            </h4>
        </div>

        <div id="collapse-response-structure" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure">
            <div class="panel-body">
                <p>Una respuesta HTTP correcta a una solicitud de señal de acceso contiene un objeto JSON con la señal de acceso y datos adicionales. A continuación, se muestra un ejemplo de una respuesta de señal de acceso válida del servidor de autorización:</p>

{% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
    "token_type": "Bearer",
    "expires_in": 3600,
    "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
    "scope": "scopeElement1 scopeElement2"
}
{% endhighlight %}

<p>El objeto JSON de respuesta de señal tiene los siguientes objetos de propiedad:</p>
<ul>
    <li><b>token_type</b>: el tipo de señal siempre es <i>"Bearer"</i>, de a cuerdo con la especificación <a href="https://tools.ietf.org/html/rfc6750">OAuth 2.0 Bearer Token Usage</a>.</li>
    <li><b>expires_in</b>: la hora de caducidad de la señal de acceso en segundos.</li>
    <li><b>access_token</b>: la señal de acceso generada (las señales de acceso reales son más largas que las que se muestran en el ejemplo).</li>
    <li><b>scope</b>: el ámbito solicitado.</li>
</ul>

<p>La información <b>expires_in</b> y <b>scope</b> también se encuentra en la misma señal (<b>access_token</b>).</p>

<blockquote><b>Nota:</b> La estructura de una respuesta de señal de acceso válida es relevante si utiliza la clase de nivel bajo <code>WLAuthorizationManager</code> y gestiona la interacción OAuth entre el cliente y la autorización y los servidores de recurso usted mismo, o si utiliza un cliente confidencial. Si utiliza la clase de nivel alto <code>WLResourceRequest</code> que encapsula el flujo OAuth para acceder a recursos protegidos, la infraestructura de seguridad maneja el proceso de las respuestas de señal de acceso en su lugar. <a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_oauth_client_apis.html?view=kc#c_oauth_client_apis">Consulte las API de seguridad de cliente</a> y los <a href="confidential-clients">Clientes confidenciales</a>.</blockquote>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>Cerrar sección</b></a>
            </div>
        </div>
    </div>
</div>

### Señales de renovación
{: #refresh-tokens}

Una Señal de renovación es un tipo de señal especial, que se puede utilizar para obtener una señal de acceso nueva cuando caduque la señal de acceso. Para solicitar una nueva señal de acceso, se puede presentar una señal de renovación válida. Las señales de renovación son señales de larga duración y seguirán siendo válidas durante un periodo de tiempo más largo en comparación con las señales de acceso.

Una aplicación debe utilizar con cuidado la señal de renovación porque puede permitir a un usuario seguir siempre autenticado. Las aplicaciones de redes sociales, las aplicaciones de comercio electrónico, las aplicaciones de navegación de catálogo de productos y tales aplicaciones de utilidad, donde el proveedor de aplicaciones no autentica a los usuarios regularmente, pueden utilizar las señales de renovación. Las aplicaciones que obligan la autenticación de usuario frecuentemente deben evitar utilizar las señales de renovación.  

#### Señal de renovación de MobileFirst
{: #mfp-refresh-token}

Una señal de renovación de MobileFirst es una entidad firmadas digitalmente como señal de acceso que describe los permisos de autorización de un cliente. La señal de renovación se puede utilizar para obtener una nueva señal de acceso del mismo ámbito. Una vez que se otorga la solicitud de autorización del cliente para un ámbito específico y que el cliente está autenticado, el punto final de la señal del servidor de autorización envía al cliente una respuesta HTTP que contiene la señal de acceso y la señal de renovación solicitadas. Cuando caduca la señal de acceso, el cliente envía una señal de renovación al punto final de señal del servidor de autorización para obtener un nuevo conjunto de señales de acceso y de señales de renovación.

**Estructura**

De forma similar a la señal de acceso de MobileFirst, la señal de renovación de MobileFirst contiene la información siguiente:
* **ID de cliente**: un identificador único del cliente.
* **Ámbito**: el ámbito al que se otorgó la señal (ver ámbitos de OAuth). Este ámbito no incluye un ámbito de aplicación obligatorio.
* **Hora de vencimiento de la señal**: la hora a partir de la cual la señal se vuelve inválida (caduca), en segundo.

#### Vencimiento de la señal
{: #token-expiration}

El periodo de vencimiento de la señal para la señal de renovación es mayor que el periodo de vencimiento de la señal de acceso típico. La señal de renovación una vez otorgada continúa siendo válida hasta que transcurre la hora de caducidad. Dentro de este periodo de validez, un cliente puede utilizar la señal de renovación para obtener un conjunto nuevo de señales de acceso y de señales de renovación. La señal de renovación tiene un periodo de vencimiento fijo de 30 días. Cada vez que el cliente recibe un conjunto nuevo de señales de acceso y de señales de renovación correctamente, se restablece el vencimiento de la señal de renovación, dando así al cliente una experiencia de una señal que no vence nunca. Las reglas de vencimiento de la señal de acceso permanecen igual que lo explicado en la sección **Señal de acceso**.

<div class="panel-group accordion" id="configuration-explanation-rt" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="refresh-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>Habilitación de la característica Señal de renovación</b></a>
            </h4>
        </div>

        <div id="collapse-refresh-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="refresh-token-expiration">
            <div class="panel-body">
            <p>La característica de señal de renovación se puede habilitar utilizando las propiedades siguientes en el lado del cliente y del servidor, respectivamente.</p>
            <b>Propiedad del lado del cliente (Android)</b><br/>

            <i>Nombre de archivo</i>:            mfpclient.properties<br/>
            <i>Nombre de propiedad</i>:   wlEnableRefreshToken<br/>
            <i>Valor de propiedad</i>:   true<br/>

            Por ejemplo,<br/>
            <i>wlEnableRefreshToken=true</i><br/><br/>

            <b>Propiedad del lado del cliente (iOS)</b><br/>

            <i>Nombre de archivo</i>:            mfpclient.plist<br/>
            <i>Nombre de propiedad</i>:   wlEnableRefreshToken<br/>
            <i>Valor de propiedad</i>:   true<br/>

            Por ejemplo,<br/>
            <i>wlEnableRefreshToken=true</i><br/><br/>


            <b>propiedad del lado del servidor</b><br/>

            <i>Nombre de archivo</i>:            server.xml<br/>
            <i>Nombre de propiedad</i>:   mfp.security.refreshtoken.enabled.apps<br/>
            <i>Valor de propiedad</i>:   <i>id de paquete de aplicación separado por ‘;’</i><br/><br/>

            <p>Por ejemplo,</p><br/>
            {% highlight xml %}
            <jndiEntry jndiName="mfp/mfp.security.refreshtoken.enabled.apps" value='"com.sample.android.myapp1;com.sample.android.myapp2"'/>
            {% endhighlight %}

            <p>Utilice id de paquetes distintos para distintas plataformas.</p>

                                    <br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>Cerrar sección</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>

<div class="panel-group accordion" id="response-refresh-token" role="tablist">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="response-structure-rt">
        <h4 class="panel-title">
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>Renovar estructura de la respuesta de señales</b></a>
        </h4>
    </div>

    <div id="collapse-response-structure-rt" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure-rt">
      <div class="panel-body">
        <p>A continuación, se muestra un ejemplo de una respuesta de señal de renovación válida del servidor de autorizaciones:</p>

        {% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
            "token_type": "Bearer",
            "expires_in": 3600,
            "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
            "scope": "scopeElement1 scopeElement2",
            "refresh_token": "yI7ICasdsdJodHRwOi8vc2Vashnneh "
        }
        {% endhighlight %}

        <p>La respuesta de la señal de renovaciones tiene el objeto de propiedades adicional <code>refresh_token</code> aparte del resto de los objetos de propiedades que se explican como parte de la estructura de la respuesta de la señal de acceso.</p>

        <br/>
              <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>Cerrar sección</b></a>
            </div>
          </div>
        </div>
</div>


>**Nota:** Las señales de renovación tienen una larga duración, en comparación con las señales de acceso. Por lo tanto, la característica de señal de renovación se debe utilizar con cuidado. Las aplicaciones donde la autenticación de usuario periódica no es necesaria son candidatos ideales para utilizar la característica de señal de renovación. 
>
> MobileFirst da soporte a la característica de señal de renovación en iOS a partir de CD Update 3. 


### Comprobaciones de seguridad
{: #security-checks }

Una comprobación de seguridad es una entidad de lado del servidor que implementa la lógica de seguridad para proteger los recursos de aplicación de lado de servidor. Un ejemplo simple de una comprobación de seguridad es una comprobación de seguridad de inicio de sesión de usuario que recibe las credenciales de un usuario y verifica las credenciales en relación con un registro de usuario. Otro ejemplo es la comprobación de seguridad de autenticidad de aplicación de {{ site.data.keys.product_adj }} que valida la autenticidad de la aplicación móvil y la protege frente a los intentos de acceso a los recursos de aplicación. También puede utilizarse la misma comprobación de seguridad para proteger varios recursos.

Una comprobación de seguridad normalmente emite desafíos de seguridad que requieren que el cliente responda de forma específica para pasar la comprobación. Este reconocimiento se produce como parte del flujo de adquisición de señal de acceso de OAuth. El cliente utiliza los **manejadores de desafíos** para manejar los desafíos de las comprobaciones de seguridad.

#### Comprobaciones de seguridad incorporadas
{: #built-in-security-checks }

Están disponibles las siguientes comprobaciones de seguridad predefinidas:

- [Autenticidad de aplicación](application-authenticity/)
- [Inicio de sesión único (SSO) basado en LTPA](ltpa-security-check/)
- [Actualización directa](../application-development/direct-update)

### Manejadores de desafíos
{: #challenge-handlers }
Al intentar acceder a los recursos protegidos, el cliente puede encontrarse con un desafío. Un desafío es una pregunta, una prueba de seguridad o una solicitud del servidor para asegurar que el cliente tiene permiso para acceder al recurso. Más frecuentemente, el desafío es una solicitud de credenciales como, por ejemplo, un nombre de usuario y una contraseña.

Un manejar de desafíos es una entidad del lado del cliente que implementa la lógica de seguridad del lado del cliente y la interacción de usuario relacionada.
**Importante**: Una vez recibido el desafío, no puede ignorarse. Debe responder o cancelarlo. Ignorar un desafío puede provocar comportamientos inesperados.

> Obtenga más información acerca de las comprobaciones de seguridad en la guía de aprendizaje [Creación de una comprobación de seguridad](creating-a-security-check/) y de los manejadores de seguridad en la guía de aprendizaje [Validación de credenciales](credentials-validation).

### Ámbitos
{: #scopes }

Puede proteger recursos, como los adaptadores, de acceso no autorizado asignando un **ámbito** al recurso.

Un ámbito se define como una cadena de uno o más elementos de ámbito separados por espacios ("scopeElement1 scopeElement2 ..."), o como un valor nulo para aplicar el ámbito predeterminado (`RegisteredClient`). La infraestructura de seguridad de {{ site.data.keys.product_adj }} requiere una señal de acceso para cualquier recurso de adaptador, incluso si el recurso no se ha asignado a un ámbito, a menos que inhabilite la protección del recurso. Consulte [Protección de recursos de adaptador](#protecting-adapter-resources ).

#### Elementos de ámbito
{: #scope-elements }

Un elemento de ámbito puede ser cualquiera de los siguientes:

* El nombre de una comprobación de seguridad.
* Una palabra clave arbitraria `access-restricted` o `deletePrivilege` que defina el nivel de seguridad necesario para el recurso. Más adelante, la palabra clave luego se correlaciona con una comprobación de seguridad.

#### Correlación de ámbito
{: #scope-mapping }

De forma predeterminada, los **elementos de ámbito** que escribe en el **ámbito** se correlacionan con una **comprobación de seguridad con el mismo nombre**.
Por ejemplo, si escribe una comprobación de seguridad denominada `PinCodeAttempts`, puede utilizar un elemento de ámbito con el mismo nombre en su ámbito.

La correlación de ámbitos permite correlacionar elementos de ámbitos con comprobaciones de seguridad. Cuando el cliente pide un elemento de ámbito, esta configuración define qué comprobaciones de seguridad deberían aplicarse.   Por ejemplo, puede correlacionar el elemento de ámbito `access-restricted` con la comprobación de seguridad `PinCodeAttempts`.

La correlación de ámbitos es útil si desea proteger un recurso de una manera diferente en función de la aplicación a la que intenta acceder.
También puede correlacionar un ámbito a una lista de comprobaciones de seguridad.

Por ejemplo:
scope = `access-restricted deletePrivilege`

* En la aplicación A
  * `access-restricted` se correlaciona con `PinCodeAttempts`.
  * `deletePrivilege` se correlaciona con una cadena vacía.
* En la aplicación B
  * `access-restricted` se correlaciona con `PinCodeAttempts`.
  * `deletePrivilege` se correlaciona con `UserLogin`.

> Para correlacionar su elemento de ámbito con una cadena vacía, no seleccione ninguna comprobación de seguridad en el menú emergente **Añadir nueva correlación de elemento de ámbito**.

<img class="gifplayer" alt="Correlaciones de ámbito" src="scope_mapping.png"/>

También puede editar el archivo JSON de configuración de la aplicación de forma manual con la configuración necesaria y enviar los cambios a {{ site.data.keys.mf_server }}.

1. Desde una **ventana de línea de mandatos**, navegue a la carpeta de raíz de proyecto y ejecute `mfpdev app pull`.
2. Abra el archivo de configuración ubicado en la carpeta **[project-folder]\mobilefirst**.
3. Edite el archivo definiendo una propiedad `scopeElementMapping`; en esta propiedad defina pares de datos compuestos por el nombre del elemento de ámbito seleccionado y una cadena de comprobaciones de seguridad separadas por espacio a las que se correlaciona el elemento. Por ejemplo:

    ```xml
    "scopeElementMapping": {
        "UserAuth": "UserAuthentication",
        "SSOUserValidation": "LtpaBasedSSO CredentialsValidation"
    }
    ```
4. Despliegue el archivo JSON de configuración actualizando ejecutando el mandato: `mfpdev app push`.

> También puede enviar configuraciones actualizadas a servidores remotos. Revise la guía de aprendizaje [Utilización de {{ site.data.keys.mf_cli }} para gestionar artefactos de {{ site.data.keys.product_adj }}](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts).

## Protección de recursos
{: #protecting-resources }

En el modelo OAuth, un recurso protegido es un recurso que requiere una señal de acceso. Puede utilizar la infraestructura de seguridad de {{ site.data.keys.product_adj }} para proteger los recursos alojados en una instancia de {{ site.data.keys.mf_server }}, y los recursos de un servidor externo. Proteja un recurso asignándole un ámbito que defina los permisos requeridos para adquirir una señal de acceso.

Puede proteger los recursos de varias maneras:

### Ámbito de aplicación obligatorio
{: #mandatory-application-scope }

A nivel de aplicación, puede definir un ámbito que se aplicará a todos los recursos utilizados en la aplicación. La infraestructura de seguridad ejecuta estas comprobaciones(si existen) además de las comprobaciones de seguridad del ámbito de recurso solicitado.

**Nota:**
* El ámbito de aplicación obligatorio no se aplica al acceder a [un recurso desprotegido](#unprotected-resources).
* La señal de acceso que se garantiza para el ámbito de recursos no contiene el ámbito de aplicación obligatorio.

<br/>
En {{ site.data.keys.mf_console }}, seleccione la aplicación de la sección **Aplicaciones** de la barra lateral de navegación, y luego seleccione el separador **Seguridad**. En **Ámbito de aplicación obligatorio**, seleccione **Añadir a ámbito**.

<img class="gifplayer" alt="Ámbito de aplicación obligatorio" src="mandatory-application-scope.png"/>

También puede editar el archivo JSON de configuración de la aplicación de forma manual con la configuración necesaria y enviar los cambios a {{ site.data.keys.mf_server }}.

1.  Desde una **ventana de línea de mandatos**, navegue a la carpeta de raíz de proyecto y ejecute `mfpdev app pull`.
2.  Abra el archivo de configuración ubicado en la carpeta **project-folder\mobilefirst**.
3.  Edite el archivo definiendo la propiedad `mandatoryScope` y estableciendo el valor de propiedad a una serie de ámbitos que contenga una lista separada por espacios de los elementos de ámbito seleccionados. Por ejemplo:

    ```xml
    "mandatoryScope": "appAuthenticity PincodeValidation"
    ```
4.  Despliegue el archivo JSON de configuración actualizando ejecutando el mandato: `mfpdev app push`.

> También puede enviar configuraciones actualizadas a servidores remotos. Revise la guía de aprendizaje [Utilización de {{ site.data.keys.mf_cli }} para gestionar artefactos de {{ site.data.keys.product_adj }}](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts).

### Protección de recursos de adaptador
{: #protecting-adapter-resources }

En el adaptador puede especificar el ámbito de protección para el método Java o un procedimiento de recurso de JavaScript, o para toda una clase de recursos Java, tal y como se indica en las siguientes secciones [Java](#protecting-java-adapter-resources) y [JavaScript](#protecting-javascript-adapter-resources). Un ámbito se define como una cadena de uno o más elementos de ámbito separados por espacios ("scopeElement1 scopeElement2 ..."), o como valor nulo para aplicar el ámbito predeterminado ([Ámbitos](#scopes)).

El ámbito de {{ site.data.keys.product_adj }} predeterminado es `RegisteredClient`, que requiere una señal de acceso para acceder al recurso y verifica que la solicitud de recurso es de una aplicación registrada con {{ site.data.keys.mf_server }}. Esta protección siempre se aplica, a menos que [inhabilite la protección de recurso](#disabling-resource-protection). Por lo tanto, incluso si no establece un ámbito para el recurso, este sigue protegido.

> <b>Nota:</b> `RegisteredClient` se reserva a la palabra clave de {{ site.data.keys.product_adj }}. No defina elementos de ámbito de persona personalizados o comprobaciones de seguridad con este nombre.

#### Protección de recursos de adaptador Java
{: #protecting-java-adapter-resources }

Para asignar un ámbito de protección a un método o clase JAX-RS añada la anotación `@OAuthSecurity` a la declaración de método o clase y establezca el elemento `scope` de la anotación a su ámbito preferido. Reemplace `YOUR_SCOPE` con una cadena de uno o más elementos de ámbito ("scopeElement1 scopeElement2 ..."):
```
@OAuthSecurity(scope = "YOUR_SCOPE")
```

Un ámbito de clase se aplica a todos los métodos de la clase, excepto los métodos que tienen su propia anotación `@OAuthSecurity`.

<b>Nota:</b> Cuando el elemento `enabled` de la anotación `@OAuthSecurity` se establece como `false`, el elemento `scope` se ignora. Consulte [Inhabilitación de la protección de recursos Java](#disabling-java-resource-protection).

##### Ejemplos
{: #java-adapter-resource-protection-examples }

El código siguiente protege un método `helloUser` con un ámbito que contiene los elementos de ámbito `UserAuthentication` y `Pincode`:
```java
@GET
@Path("/{username}")
@OAuthSecurity(scope = "UserAuthentication Pincode")
public String helloUser(@PathParam("username") String name){
    ...
}
```

El código siguiente protege una clase `WebSphereResources` con la comprobación de seguridad predefinida `LtpaBasedSSO`:
```java
@Path("/users")
@OAuthSecurity(scope = "LtpaBasedSSO")
public class WebSphereResources {
    ...
}
```

#### Protección de recursos de adaptador JavaScript
{: #protecting-javascript-adapter-resources }

Para asignar un ámbito de protección a un procedimiento JavaScript, en el archivo <b>adapter.xml</b> establezca el atributo de ámbito de elemento &lt;procedure&gt; a su ámbito preferido. Reemplace `PROCEDURE_NANE` con el nombre del procedimiento y `YOUR SCOPE` con una serie de uno o más elementos de ámbito ("scopeElement1 scopeElement2 ..."):
```xml
<procedure name="PROCEDURE_NANE" scope="YOUR_SCOPE">
```

<b>Nota:</b> Cuando el atributo `secured` del elemento &lt;procedure&gt; se establece en falso, el atributo `scope` se ignora. Consulte [Inhabilitación de la protección de recursos JavaScript](#disabling-javascript-resource-protection).

#### Ejemplo
{: #javascript-adapter-resource-protection-examples }

El código siguiente protege un método `userName` con un ámbito que contiene los elementos de ámbito `UserAuthentication` y `Pincode`:
```xml
<procedure name="userName" scope="UserAuthentication Pincode">
```

### Inhabilitación de la protección de recurso
{: #disabling-resource-protection }

Puede inhabilitar el [recurso de protección de {{ site.data.keys.product_adj }} ](#protecting-adapter-resources) predeterminado para un recurso de adaptador Java o JavaScript o para toda la clase de Java, tal y como se indica en las secciones [Java](#disabling-java-resource-protection) y [JavaScript](#disabling-javascript-resource-protection) siguientes. Cuando la protección del recurso esté inhabilitada, la comprobación de seguridad de {{ site.data.keys.product_adj
 }} no requiere ninguna señal de acceso al recurso. Consulte [recursos desprotegidos](#unprotected-resources).

#### Inhabilitación de la protección de recurso Java
{: #disabling-java-resource-protection }

Para inhabilitar una protección OAuth para el método o clase de recurso Java, añada la anotación `@OAuthSecurity` a la declaración de clase o recurso y establezca el valor del elemento `enabled` en `false`:
```java
@OAuthSecurity(enabled = false)
```
El valor predeterminado del elemento `enabled` de la anotación es `true`. Cuando el elemento `enabled` se establezca en `false`, el elemento `scope` se ignora y el recurso o clase de recurso es [unprotected](#unprotected-resources).

<b>Nota:</b> Cuando asigne un ámbito a un método de una clase desprotegida, el método se protege pese a la anotación de clase, a menos que establezca el elemento `enabled` de la anotación de recurso en `false`.

##### Ejemplos
{: #disabling-java-resource-protection-examples }

El código siguiente inhabilita la protección de recurso de un método `helloUser`:
```java
    @GET
    @Path("/{username}")
    @OAuthSecurity(enabled = "false")
    public String helloUser(@PathParam("username") String name){
        ...
    }
```

El código siguiente inhabilita la protección de un recurso para la clase `MyUnprotectedResources`:
```java
    @Path("/users")
    @OAuthSecurity(enabled = "false")
    public class MyUnprotectedResources {
        ...
    }
```

#### Inhabilitación de la protección de recurso JavaScript
{: #disabling-javascript-resource-protection }

Para inhabilitar la protección OAuth para un recurso de adaptador JavaScript (procedimiento), en el archivo <b>adapter.xml</b> establezca el atributo `secured` del elemento &lt;procedure&gt; en `false`:
```xml
<procedure name="procedureName" secured="false">
```

Cuando el atributo `secured` se establece en `false`, el atributo `scope` se ignora y el recurso queda [desprotegido](#unprotected-resources).

##### Ejemplo
{: #disabling-javascript-resource-protection-examples }

El código siguiente inhabilita la protección de recurso para un procedimiento `userName`:
```xml
<procedure name="userName" secured="false">
```

### Recursos desprotegidos
{: #unprotected-resources }

Un recurso desprotegido es un recurso que no requiere una señal de acceso. La infraestructura de seguridad de {{ site.data.keys.product_adj }} no gestiona el acceso a recursos desprotegidos y no valida o comprueba la identidad de los clientes que acceden a estos recursos. Por lo tanto, no se da soporte a las funciones como Direct Update, bloqueo del acceso a un dispositivo o la inhabilitación remota de una aplicación en los recursos desprotegidos.

### Protección de recursos externos
{: #protecting-external-resources }

Para proteger recursos externos, añada un filtro de recursos con un módulo de validación de una señal de acceso a un servidor de recurso externo. El módulo de validación de señal utiliza el punto final de introspección del servidor de autorización de la infraestructura de seguridad para validar el acceso a la señal de acceso de {{ site.data.keys.product_adj }} antes de garantizar al cliente OAuth acceso a los recursos. Puede utilizar la [{{ site.data.keys.product_adj }} API REST para que el {{ site.data.keys.product_adj }} tiempo de ejecución](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_runtime_overview.html?view=kc#rest_runtime_api) cree su propio módulo de validación de señal de acceso para un servidor externo. De forma alternativa, utilice alguna de las ampliaciones de {{ site.data.keys.product_adj }} para proteger recursos Java externos, tal y como se indica en la guía de aprendizaje [protección de recursos externos](protecting-external-resources).

## Flujo de autorización
{: #authorization-flow }

El flujo de autorización tiene dos fases:

1. El cliente adquiere una señal de acceso.
2. El cliente utiliza la señal para acceder a un recurso protegido.

### Obtención de una señal de acceso
{: #obtaining-an-access-token }

En esta fase, el cliente se somete a **comprobación de seguridad** para recibir una señal de acceso.

Antes de solicitar una señal de acceso, el cliente se registra con {{ site.data.keys.mf_server }}. Como parte del registro, proporciona una clave pública que se utilizará para autenticar su identidad. Esta fase se produce una vez en el tiempo de vida de una instancia de aplicación móvil. Si la comprobación de seguridad de la autenticidad de aplicación está habilitada, la autenticidad de la aplicación se valida durante el registro.

![Obtener señal](auth-flow-1.jpg)

1.  La aplicación cliente envía una solicitud para obtener una señal de acceso para un ámbito especificado.

    > El cliente solicita una señal de acceso con un ámbito determinado. El ámbito solicitado debería correlacionarse con la misma comprobación de seguridad como ámbito del recurso protegido al que el cliente quiere acceder y, de forma opcional, también puede correlacionarse con comprobaciones de seguridad adicionales. Si el cliente no tiene conocimiento previo acerca del ámbito del recurso protegido, primero puede solicitar una señal de acceso con un ámbito vacío e intentar acceder al recurso con la señal obtenida. El cliente recibirá una respuesta con un error 403 (Prohibido) y el ámbito necesario del recurso solicitado.

2.  La aplicación de cliente se somete a comprobaciones de seguridad en función del ámbito solicitado.

    > {{ site.data.keys.mf_server }} ejecuta comprobaciones de seguridad a las que se correlaciona el ámbito de la solicitud del cliente. El servidor de autorización otorga o rechaza la solicitud del cliente en función de los resultados de estas comprobaciones. Si se define un ámbito de aplicación obligatorio, las comprobaciones de seguridad del ámbito se ejecutan además de las comprobaciones del ámbito solicitado.

3.  Cuando el proceso de solicitud finaliza correctamente, la aplicación cliente reenvía la solicitud al servidor de autorización.

    > Si la autorización se realiza correctamente, el cliente se redirige al punto final de la señal del servidor de autorización, en el que se autentica utilizando la clave pública proporcionada como parte del registro del cliente. Si la autenticación es correcta, el servidor de autorización emite al cliente una señal de acceso firmada digitalmente que encapsula el ID del cliente, el ámbito solicitado y la hora de caducidad de la señal.

4.  La aplicación de cliente recibe la señal de acceso.

### Utilización de una señal para acceder a un recurso protegido
{: #using-a-token-to-access-a-protected-resource }

Es posible imponer seguridad en los recursos que se ejecutan en {{ site.data.keys.mf_server }}, como se muestra en el diagrama, y en los recursos que se ejecutan en cualquier servidor de recursos externo, tal y como se describe en la guía de aprendizaje [Utilización de {{ site.data.keys.mf_server }} para autenticar recursos externos](protecting-external-resources/).

Después de obtener una señal de acceso, el cliente adjunta la señal obtenida a solicitudes posteriores para acceder a recursos protegidos. El servidor de recursos utiliza el punto final de introspección del servidor de autorización para validar la señal. La validación incluye la utilización de la firma digital de la señal para verificar la identidad del cliente, verificando que el ámbito coincide con el ámbito solicitado autorizado, y asegurando que la señal no ha caducado. Al validar la señal, se otorga al cliente acceso al recurso.

![Proteger recursos](auth-flow-2.jpg)

1. La aplicación de cliente envía una solicitud con la señal de acceso recibida.
2. El módulo de validación valida la señal.
3. {{ site.data.keys.mf_server }} sigue a la invocación de adaptador.

## Guías de aprendizaje con las que continuar
{: #tutorials-to-follow-next }

Siga leyendo acerca de la autenticación en {{ site.data.keys.product_adj }} Foundation en las guías de aprendizaje de la navegación de la barra lateral.
