---
layout: tutorial
title: Preguntas más frecuentes
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

En este tema se describe la lista de preguntas comunes en relación con {{ site.data.keys.mf_analytics_server }}.

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	¿Cómo puedo definir el número de fragmentos y réplicas de mi clúster de analíticas?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>En un clúster de elasticsearch de varios índices, es importante definir lo siguiente:
                <ul><li>El número mínimo de fragmentos se debe definir en el número de nodos del clúster.</li><li>Las réplicas por fragmento se deben definir en un mínimo de dos.</li></ul><br/>MobileFirst Analytics v8.0 utiliza varios para almacenar los datos de suceso.</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. En MobileFirst Analytics v8.0, la configuración de <code>server.xml</code> tiene 3 fragmentos definidos, pero la página de administración de la consola de operaciones de Analytics muestra más de 15 fragmentos.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>En MobileFirst Analytics v8.0, el almacén de datos de Elasticsearch tiene varios índices. No se trata de un almacén de datos basado en un solo índice. Los índices se crean de forma dinámica en función del tipo de sucesos que fluyen en las analíticas. De este modo, los usuarios finales no tienen que preocuparse de los diferentes índices. Cada índice de Elasticsearch se divide en el número de fragmentos definido en el archivo de configuración.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. ¿Por qué mi consola de operaciones de Analytics se representa de forma extremadamente lenta?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p>Asegúrese de que se utiliza la <a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">calculadora de dimensionamiento de hardware</a> para comprobar el hardware correcto según los requisitos del cliente y los datos. Hay varios factores que influyen en el rendimiento del sistema, incluido el hardware, el tipo o el tamaño de los sucesos de datos que entran al servidor de analíticas y el volumen de los sucesos.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. ¿Puedo recuperar los datos depurados?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>No. Una vez que se depuran los datos, no se pueden recuperar.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. La depuración de datos no funciona correctamente, independientemente de definir o no los valores de TTL.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>Las propiedades de TTL no se aplican a los datos que existen en la plataforma de Analytics. Debe establecer las propiedades de TTL antes de añadir los datos.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. La consola de operaciones de Analytics no muestra ningún dato.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>Asegúrese de que las propiedades JNDI de MobileFirst Server se utilizan para configurar los puntos finales adecuados de Analytics. Asegúrese de que el filtro de fecha esté definido correctamente para que se presenten los datos.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. No se ha podido invocar a las API REST de clúster de Elasticsearch.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>Para invocar las API REST de Elasticsearch, es obligatorio que la propiedad <b>analytics/http.enabled</b> esté definida en <b>true</b> en el archivo <code>server.xml</code> del servidor de analíticas.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	Can ¿Puedo utilizar Open JDK con ND (o perfil completo) de IBM WebSphere Application Server en Analytics?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>No. Cuando utilice el perfil completo o ND (Network Deployment) de IBM WebSphere Application Server, asegúrese de utilizar el IBM JDK que se proporciona listo para utilizar con WebSphere Application Server.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	¿Cuándo empieza a incrementarse el número de <b>Sesiones de aplicaciones</b>?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>La primera vez que se abre la aplicación, el número de <b>Sesiones de aplicaciones</b> es cero. Cuando el usuario final coloca la aplicación móvil en segundo plano y la vuelve a poner en primer plano, esta acción incrementa las <b>Sesiones de aplicaciones</b> a 1. Al repetir la misma acción, se van incrementando las <b>Sesiones de aplicaciones</b>.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	¿Qué significa que el estado del clúster de analíticas sea AMARILLO?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>El estado del clúster AMARILLO no tiene por qué ser un problema. La mayoría de las veces, cuando hay fragmentos sin asignar, el estado del clúster se muestra amarillo. Cuando se incorporan nuevos nodos al clúster, Elasticsearch reasigna los fragmentos sin asignar a los nuevos nodos, lo que provoca que el estado del clúster sea VERDE. En ocasiones, tener un recuento excesivo de fragmentos también provoca que queden fragmentos sin asignar a alguno de los nodos, y por eso el estado del clúster se muestra amarillo. Asegúrese de que todos los nodos del clúster están activos y funcionan correctamente, y de que los fragmentos se encuentran en estado iniciado/activo.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	¿Qué significan las Sesiones de aplicaciones para las aplicaciones web?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>Para aplicaciones web, el recuento de Sesiones de aplicaciones se incrementa en función de la sesión de navegador y se basa en la conexión del navegador (aplicación) a MFP Server.</p>

                  <p>Si el navegador utiliza el separador/ventana general y realiza una conexión al servidor, el recuento de sesiones de aplicaciones se incrementa en uno. En el mismo navegador, si el usuario abre la aplicación en otro separador y realiza la conexión, la sesión no se incrementa. La sesión permanece inactiva durante 30 minutos. Cuando intenta volver a conectar de nuevo, se incrementa en uno.</p>

                  <p>Si el usuario borra la memoria caché de navegador e intenta conectarse, el dispositivo se considera como un dispositivo nuevo y se incrementa el recuento de dispositivos. Puesto que los navegadores no tienen un ID de dispositivo real, se genera un ID para la aplicación de navegador hasta que se borra la memoria caché/los archivos fuera de línea.</p>

                  <p>Esto se aplica también a las ventanas de navegador de incógnito; si utiliza una ventana de navegador de incógnito e intenta conectarse, una aplicación utilizada para conectarse desde cada separador se considera una nueva sesión, y se incrementa el recuento de sesiones. Si el usuario utiliza dos navegadores diferentes y accede a la aplicación para conectarse a MFP Server, el recuento de dispositivos se incrementa en dos.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	¿A qué hace referencia <i>Usuarios activos</i> en el panel de control de las analíticas?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>Usuarios activos</i> es el número de usuarios que están utilizando la aplicación. Cada usuario exclusivo se cuenta como usuario que utiliza la aplicación. De forma predeterminada, deviceID es userID. Sin embargo, el desarrollador de aplicación puede utilizar la API <code>setUserContext(userid)</code>. Esto sustituirá el userID por el valor que defina el desarrollador de aplicación.</p>

                  <p>Una solución/enfoque consiste en generar un uniqueID desde el ordenador cuando el usuario accede a la WebApp y lo envía como customData. Estos datos se pueden utilizar para calcular las estadísticas de las máquinas reales (o sistemas/navegadores) desde las que el usuario accede a la aplicación y utiliza <code>setUserContext</code> para definir el userID. Estos datos también se pueden utilizar para generar los gráficos personalizados.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	¿Qué significan las Sesiones de aplicaciones para las aplicaciones nativas/Cordova?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>En Analytics 8.0, calcular una sesión de aplicación es completamente diferente a las versiones anteriores de MFP Analytics.</p>

                  <p>El recuento de sesiones de aplicaciones se incrementa en uno cuando la aplicación pasa al primer plano desde el segundo plano. Para habilitar esto en las aplicaciones Cordova, se deben habilitar los sucesos de CICLO DE VIDA DE APLICACIÓN CLIENTE. Consulte <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">aquí</a> para obtener más información.</p>
            </div>
        </div>      
    </div>
</div>       
