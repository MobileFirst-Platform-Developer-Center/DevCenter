---
layout: tutorial
title: Novedades
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0 proporciona cambios significativos que modernizan la experiencia en la gestión, despliegue y desarrollo de aplicaciones {{ site.data.keys.product_adj }}.

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">Novedades en la creación de aplicaciones</a> </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>Se ha rediseñado la interfaz de mandatos y SDK de {{ site.data.keys.product }} para ofrecer una mayor flexibilidad y eficiencia a la hora de desarrollar sus aplicaciones. Además, ahora puede utilizar cualquiera de sus herramientas de Cordova preferidas al desarrollar aplicaciones entre plataformas. </p>

                <p>Revise las secciones siguientes para conocer las novedades en el desarrollo de aplicaciones. </p>

                <h3>Nuevo proceso de desarrollo y despliegue </h3>
                <p>Ya no es necesario crear un archivo WAR de proyecto para instalarlo en el servidor de aplicaciones. En su lugar, {{ site.data.keys.mf_server }} se instala una vez y se sube al servidor la configuración de lado del servidor de sus aplicaciones, de la seguridad de los recursos o del servicio push. Puede modificar la configuración sus aplicaciones con {{ site.data.keys.mf_console }}. </p>

                <p>Ya no existen los proyectos de {{ site.data.keys.product_adj }}. En su lugar, puede desarrollar su aplicación móvil con el entorno de desarrollo que desee. <br/>
                Es posible modificar la configuración del lado del servidor de sus aplicaciones y adaptadores sin detener {{ site.data.keys.mf_server }}. </p>

                <ul>
                    <li>Para obtener más información sobre el nuevo proceso de desarrollo, consulte <a href="../../../application-development/">Visión general y conceptos de desarrollo</a></li>
                    <li>Para obtener más información sobre la migración de aplicaciones existentes, consulte la <a href="../../../upgrading/migration-cookbook">Guía de migración</a>.</li>
                    <li>Para obtener más información sobre la administración de aplicaciones de {{ site.data.keys.product_adj }}, consulte Administración de aplicaciones de {{ site.data.keys.product_adj }}. </li>
                </ul>

                <h3>Aplicaciones Web</h3>
                <p>Ahora puede utilizar API JavaScript del lado del cliente de {{ site.data.keys.product_adj }} para desarrollar aplicaciones web con su IDE y sus herramientas preferidas. Puede registrar su aplicación web en {{ site.data.keys.mf_server }} para añadir funcionalidades de seguridad a la aplicación.</p>

                <p>También puede utilizar la nueva API de analíticas web de JavaScript del lado del cliente, que se proporciona como parte del nuevo SDK, para añadir funcionalidades {{ site.data.keys.mf_analytics }} a su aplicación web. </p>

                <h3>Desarrollo de aplicaciones entre plataformas con sus herramientas de Cordova preferidas</h3>
                <p>Ahora puede utilizar su herramientas de Cordova preferidas (como, por ejemplo, Apache Cordova CLI o Ionic Framework) para desarrollar aplicaciones híbridas entre plataformas. Obtendrá estas herramientas independientemente de {{ site.data.keys.product }} y, a continuación, añadirá plugins de {{ site.data.keys.product_adj }} para proporcionar las funcionalidades de fondo de {{ site.data.keys.product_adj }}. </p>

                <p>Es posible instalar el plugin {{ site.data.keys.product }} Studio Eclipse para gestionar aplicaciones Cordova entre plataformas que estén habilitadas con {{ site.data.keys.product }} en el entorno de desarrollo de Eclipse. El plugin {{ site.data.keys.product }} también proporciona mandatos {{ site.data.keys.mf_cli }} adicionales que se pueden ejecutar desde dentro del entorno Eclipse. </p>

                <h3>Componentes en el SDK </h3>
                <p>Con anterioridad, el SDK del cliente de {{ site.data.keys.product_adj }} se proporcionaba como un único archivo JAR o infraestructura. Ahora puede optar por incluir o excluir determinadas funcionalidades. Además del SDK básico, cada API de {{ site.data.keys.product_adj }}tiene su propio conjunto de componentes opcionales. </p>

                <h3>Mejoras en la interfaz de línea de mandatos (CLI) de desarrollo </h3>
                <p>{{ site.data.keys.mf_cli }} ha sido rediseñado para una mayor eficiencia para el desarrollo. También se ha añadido la posibilidad de utilizar scripts automatizados. Los mandatos ahora empiezan con el prefijo mfpdev. La interfaz de línea de mandatos se incluye en {{ site.data.keys.mf_dev_kit_full }}, o se puede bajar con rapidez la última versión de la interfaz de línea de mandatos desde npm. </p>

                <h3>Herramienta Asistente de migración</h3>
                <p>Se trata de una herramienta de ayuda para la migración que simplifica el procedimiento de migrar aplicaciones existentes para {{ site.data.keys.product }} versión 8.0. La herramienta explora las aplicaciones de {{ site.data.keys.product_adj }} existentes y crea una lista de API que se utilizan en el archivo y que se han eliminado, sustituido o están en desuso en la versión 8.0. Cuando se ejecuta la herramienta Asistente de migración con aplicaciones Apache Cordova que se crearon con {{ site.data.keys.product }}, crea una nueva estructura de Cordova para la aplicación conforme a la versión 8.0. Para obtener más información sobre la herramienta Asistente de migración. </p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>Comenzando con Cordova 4.0 el plugin WebView permite sustituir el tiempo de ejecución web predeterminado. Las aplicaciones Cordova con {{ site.data.keys.product }} ahora dan soporte a Crosswalk. La utilización de Crosswalk WebView para Android permite una experiencia de usuario coherente y con un elevado rendimiento a lo largo de distintos dispositivos móviles. Para sacar partido de las funcionalidades de Crosswalk, aplique el plugin Cordova Crosswalk. </p>

                <h3>Distribución de {{ site.data.keys.product_adj }} SDK para aplicaciones Windows 8 y Windows 10 Universal con NuGet</h3>
                <p>{{ site.data.keys.product_adj }} SDK para aplicaciones Windows 8 y Windows 10 Universal está disponible en NuGet en <a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>. </p>

                <h3>org.apache.http sustituido por okHttp </h3>
                <p><code>org.apache.http</code> se ha eliminado de Android SDK. Se utilizará a okHttp como la dependencia http. </p>

                <h3>Soporte de WKWebView para aplicaciones Cordova híbridas iOS </h3>
                <p>Ahora puede sustituir el UIWebView predeterminado en aplicaciones Cordova con WKWebView. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">Novedades en las API de MobileFirst</a> </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>Nuevas características que mejoran y amplían las API que puede utilizar para desarrollar aplicaciones móviles. Las últimas API permiten sacar partido de las funciones nuevas, mejoradas o cambiadas en {{ site.data.keys.product }}.</p>

                <h3>Se ha actualizado la API de servidor de JavaScript </h3>
                <p>Sólo se da soporte a funciones de invocación de fondo para tipos de adaptador soportados. Actualmente, sólo se da soporte a los adaptadores HTTP y SQL, de forma que también se da soporte a los invocadores de fondo <code>WL.Server.invokeHttp</code> y <code>WL.Server.invokeSQL</code>. </p>

                <h3>Nueva API del lado del servidor de Java </h3>
                <p>Se proporciona una nueva API del lado del servidor de Java para extender {{ site.data.keys.mf_server }}.</p>

                <h4>Nueva API del lado del servidor de Java para la seguridad </h4>
                <p>El nuevo paquete de API de seguridad, <code>com.ibm.mfp.server.security.external</code>, y los paquetes que contiene, incluyen las interfaces que se necesitan para desarrollar adaptadores y comprobaciones de seguridad que utilizan el contexto de comprobación de seguridad. </p>

                <h4>Nueva API del lado del servidor de Java para datos de registro de cliente </h4>
                <p>El nuevo paquete de API de datos de registro de cliente, <code>com.ibm.mfp.server.registration.external</code>, y los paquetes que contiene, incluyen una interfaz para proporcionar acceso a los datos de registro de cliente persistentes de {{ site.data.keys.product_adj }}. </p>

                <h4>Application getJaxRsApplication()</h4>
                <p>Con esta nueva API, puede devolver la aplicación JAX-RS para el adaptador. </p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>Con esta nueva API, puede obtener el valor desde la configuración del adaptador (o el valor predeterminado). </p>

                <h3>API de servidor de Java actualizada </h3>
                <p>Se proporciona una API del lado del servidor de Java actualizada para extender {{ site.data.keys.mf_server }}.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>La firma de esta nueva API no se ha modificado en esta versión. Sin embargo, su comportamiento es ahora idéntico al de <code>String getPropertyValue (String propertyName)</code>, que se describe en Nueva API del lado del servidor de Java. </p>

                <h4>WLServerAPIProvider</h4>
                <p>En la V7.0.0 y V7.1.0, era posible acceder a la API de Java a través de la interfaz WLServerAPIProvider. Por ejemplo: <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> y <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>Todavía se sigue dando soporte a las interfaces estáticas, para permitir que los adaptadores desarrollados en versiones anteriores del producto se puedan compilar y desplegar. Adaptadores antiguos que no utilizan notificaciones push o la API de seguridad anterior continuarán funcionando en la nueva versión. Adaptadores que sí utilizan notificaciones push o la API de seguridad anterior, fallarán. </p>

                <h3>API de JavaScript del lado del cliente para aplicaciones web </h3>
                <p>La API del lado del cliente de JavaScript que se utiliza para el desarrollo de aplicaciones Cordova entre plataformas está ahora disponible también para el desarrollo de aplicaciones web, con ligeras modificaciones en el método de inicialización. Tenga en cuenta que no todas las funciones de las API de JavaScript se aplican a las aplicaciones web. </p>

                <p>Además, se proporciona una nueva API de analíticas web del lado del cliente de JavaScript para añadir funcionalidades de {{ site.data.keys.mf_analytics }} a las aplicaciones web. </p>

                <h3>API del lado del cliente de C# actualizada para Windows 8 Universal y Windows Phone 8 Universal </h3>
                <p>Se ha cambiado la API del lado del cliente de C# para Windows 8 Universal y Windows Phone 8 Universal. </p>

                <h3>Nuevas API del lado del cliente de Java para Android </h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>Con este nuevo método, puede obtener de los datos de registro de {{ site.data.keys.mf_server }} el nombre para mostrar de un dispositivo. </p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>Con este nuevo método, puede establecer en los datos de registro de {{ site.data.keys.mf_server }} el nombre para mostrar de un dispositivo. </p>

                <h3>Nuevas API del lado del cliente de Object-C para iOS </h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>Con este nuevo método, puede obtener de los datos de registro de {{ site.data.keys.mf_server }} el nombre para mostrar de un dispositivo. </p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>Con este nuevo método, puede establecer en los datos de registro de {{ site.data.keys.mf_server }} el nombre para mostrar de un dispositivo. </p>

                <h3>API REST actualizada para el servicio de administración </h3>
                <p>Se ha refactorizado de forma parcial la API REST para el servicio de administración. En concreto, se ha eliminado la API para balizas y mediadores y ahora la mayoría de los servicios REST para notificaciones push son ahora parte de la API REST para el servicio push. </p>

                <h3>API REST actualizada para el tiempo de ejecución </h3>
                <p>Ahora la API REST para el tiempo de ejecución de {{ site.data.keys.product_adj }} proporciona varios servicios para clientes móviles y clientes confidenciales para llamar a adaptadores, obtener señales de acceso, obtener contenido de Direct Update, etc. OAuth protege la mayoría de los puntos finales de API REST. En un servidor de desarrollo, puede visualizar el documento Swagger para la API del entorno de tiempo de ejecución en: <code>http(s)://ip_servidor:puerto_servidor/raíz_contexto/doc</code>.</p>

                <h3>Soporte para la fijación de varios certificados</h3>
                <p>A partir del iFix 8.0.0.0-IF201706240159, {{ site.data.keys.mf_bm_short }} da soporte a la fijación ("pinning") de varios certificados. Esto permite que los usuarios tengan un acceso seguro a varios hosts. Con anterioridad a este iFix, {{ site.data.keys.mf_bm_short }} daba soporte a la fijación de un único certificado. {{ site.data.keys.mf_bm_short }} incorpora una nueva API, que permite la conexión a varios hosts permitiendo que el usuario fije claves públicas de varios certificados X509 (comprados a una autoridad de certificación) para la aplicación de cliente. Se debería colocar una copia de todos los certificados en su aplicación de cliente. Durante el reconocimiento de SSL, el SKD de cliente de {{ site.data.keys.product_full }} verifica que la clave pública del certificado de servidor coincida con la clave pública de uno de los certificados  almacenados en la aplicación. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">Novedades en la seguridad de MobileFirst</a> </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>Se ha rediseñado en su totalidad la infraestructura de seguridad en {{ site.data.keys.product }}. Se han añadido nuevas características de seguridad y se han realizado algunas modificaciones a características existentes. </p>

                <h3>Cambios en la infraestructura de seguridad </h3>
                <p>Se ha rediseñado y se ha vuelto a implementar la infraestructura de seguridad de {{ site.data.keys.product_adj }} para mejorar y simplificar las tareas de administración y desarrollo de la seguridad. La infraestructura ahora se basa de forma inherente en el modelo OAuth, y su implementación no depende de la sesión. Consulte Visión general de la infraestructura de seguridad de {{ site.data.keys.product_adj }}. </p>

                <p>En el lado del servidor, los distintos bloques que forman la infraestructura han sido sustituidos con comprobaciones de seguridad (implementadas en los adaptadores), permitiendo un desarrollo simplificado con nuevas API. Se proporcionan comprobaciones de seguridad predefinidas e implementaciones de ejemplo. Consulte Comprobaciones de seguridad. Las comprobaciones de seguridad se pueden configurar en el descriptor del adaptador, y se pueden personalizar realizando cambios de configuración de aplicación o de adaptador de tiempo de ejecución, sin tener que volver a desplegar el adaptador o interrumpir el flujo. Las configuraciones se pueden realizar desde las interfaces de seguridad de {{ site.data.keys.mf_console }} que han sido rediseñadas. También existe la posibilidad de editar manualmente los archivos de configuración o de utilizar las herramientas mfpadm o {{ site.data.keys.mf_cli }}. </p>

                <h3>Comprobación de seguridad de autenticidad de aplicación </h3>
                <p>La validación de autenticidad de aplicación de {{ site.data.keys.product_adj }} ahora se implementa como una comprobación de seguridad predefinida que sustituye a la anterior "comprobación de autenticidad de aplicación ampliada". La validación de autenticidad de aplicación se puede habilitar, inhabilitar y configurar de forma dinámica mediante {{ site.data.keys.mf_console }} o mfpadm. Se proporciona una herramienta Java de autenticidad de aplicación de {{ site.data.keys.product_adj }} autónoma (mfp-app-authenticity-tool.jar) para generar archivos de autenticidad de aplicación. </p>

                <h3>Clientes confidenciales </h3>
                <p>El soporte para los clientes confidenciales ha sido rediseñado y se ha vuelto a implementar utilizando la nueva infraestructura de seguridad de OAuth. </p>

                <h3>Seguridad de aplicaciones web </h3>
                <p>La revisada infraestructura de seguridad basada en OAuth da soporte a aplicaciones web. Ahora es posible registrar aplicaciones web con {{ site.data.keys.mf_server }} para añadir funcionalidades de seguridad a sus aplicaciones y proteger el acceso a sus recursos web. Para obtener más información sobre cómo desarrollar aplicaciones web {{ site.data.keys.product_adj }}, consulte Desarrollo de aplicaciones web. No se da soporte a la comprobación de seguridad de autenticidad de las aplicaciones web. </p>

                <h3>Aplicaciones entre plataformas (aplicaciones Cordova), características de seguridad nuevas y cambiadas </h3>
                <p>Hay disponibles características adicionales de seguridad para ayudar a proteger las aplicaciones Cordova. Estas características incluyen:</p>

                <ul>
                    <li>Cifrado de recursos web: Utilice esta característica para cifrar los recursos web en el paquete de Cordova para evitar que un tercero modifique el paquete. </li>
                    <li>Suma de comprobación de recursos web: Utilice esta característica para ejecutar una prueba de suma de comprobación que compara las estadísticas actuales de los recursos web de la aplicación con las estadísticas de línea base que se establecieron cuando se abrió por primera vez. Esta comprobación ayuda a impedir que un tercero modifique la aplicación después de haberla instalado y abierto. </li>
                    <li>Fijación de certificado: Utilice esta característica para asociar el certificado de una aplicación con un certificado en el servidor de host. Esta característica ayuda a impedir que la información que se pasa entre la aplicación y el servidor sea visualizada o modificada. </li>
                    <li>Soporte al Federal Information Processing Standard (FIPS) 140-2: Utilice esta característica para asegurarse de que los datos que se transfieren cumplen el estándar de criptografía FIPS 140-2. </li>
                    <li>OpenSSL: Para utilizar el cifrado y descifrado de datos de OpenSSL con sus aplicaciones Cordova para la plataforma iOS, puede utilizar el plugin de Cordova cordova-plugin-mfp-encrypt-utils. </li>
                </ul>

                <h3>Inicio de sesión único (SSO) de dispositivo </h3>
                <p>Ahora se da soporte al inicio de sesión único (SSO) de dispositivo a través de la nueva propiedad de configuración del descriptor de aplicación de comprobación de seguridad predefinida <code>enableSSO</code>. </p>

                <h3>Direct Update</h3>
                <p>A diferencia de versiones anteriores de {{ site.data.keys.product_adj }}, a partir de la V8.0</p>

                <ul>
                    <li>Si una aplicación de cliente accede a un recurso no protegido, dicha aplicación no recibirá actualizaciones, incluso si la actualización está disponible en {{ site.data.keys.mf_server }}. </li>
                    <li>Una vez activada, de forma obligatoria se utilizará Direct Update en cada solicitud para un recurso protegido. </li>
                </ul>

                <h3>Protección de recursos externos </h3>
                <p>Se han modificado los artefactos proporcionados y el método soportado para proteger recursos en servidores externos:</p>

                <ul>
                    <li>Ahora se proporciona un nuevo módulo de validación de señales de acceso {{ site.data.keys.product_adj }} Java Token Validator para utilizar la infraestructura de seguridad de {{ site.data.keys.product_adj }} para proteger recursos en cualquier servidor Java externo. El módulo se proporciona como una biblioteca Java (mfp-java-token-validator-8.0.0.jar) y sustituye la utilización del punto final de validación de señales obsoleto de {{ site.data.keys.mf_server }} para crear un módulo de validación Java personalizado. </li>
                    <li>El filtro {{ site.data.keys.product_adj }} OAuth Trust Association Interceptor (TAI), para proteger recursos Java en un servidor WebSphere Application Server Liberty o WebSphere Application Server externo, se proporciona ahora como una biblioteca Java (com.ibm.imf.oauth.common_8.0.0.jar). La biblioteca utiliza el nuevo módulo de validación Java Token Validator. También ha cambiado la configuración del módulo TAI proporcionado. </li>
                    <li>La API TAI OAuth {{ site.data.keys.product_adj }} del lado del servidor ya no es necesaria y ha sido eliminada. </li>
                    <li>Se ha modificado la infraestructura de Node.js de {{ site.data.keys.product_adj }} passport-mfp-token-validation, para proteger recursos Java en un servidor Node.js externo, para dar soporte a la nueva infraestructura de seguridad. </li>
                    <li>También puede escribir su propio módulo de validación y filtro personalizado, para cualquier tipo de servidor de recursos, que utiliza el nuevo punto final de introspección del servidor de autorización. </li>
                </ul>

                <h3>Integración con WebShpere DataPower como servidor de autorización </h3>
                <p>Ahora se puede seleccionar utilizar WebSphere DataPower como servidor de autorización OAuth, en lugar del servidor de autorización predeterminado de {{ site.data.keys.mf_server }}. Puede configurar a DataPower para integrarlo con la infraestructura de seguridad de {{ site.data.keys.product_adj }}. </p>

                <h3>Comprobación de seguridad de inicio de sesión único (SSO) basado en LTPA </h3>
                <p>Ahora se proporciona soporte para compartir la autenticación de usuarios entre servidores que utilizan la autenticación LTPA (Light-weight Third-Party Authentication) de WebSphere mediante la utilización de la nueva comprobación de seguridad de inicio de sesión único (SSO) basado en LTPA. Esta comprobación sustituye el reino LTPA de {{ site.data.keys.product_adj }} obsoleto y elimina la configuración anteriormente necesaria. </p>

                <h3>Gestión de aplicaciones móviles con {{ site.data.keys.mf_console }}</h3>
                <p>Se han realizado algunos cambios para dar soporte al seguimiento y la gestión de aplicaciones, usuarios y dispositivos {{ site.data.keys.mf_console }}. El bloqueo del acceso de aplicaciones o dispositivos únicamente se aplica a los intentos de acceder a recursos protegidos. </p>

                <h3>Almacén de claves de {{ site.data.keys.mf_server }} </h3>
                <p>Se utiliza un almacén de claves de {{ site.data.keys.mf_server }} individual para la firma de señales de OAuth y paquetes de Direct Update así como para la autenticación HTTPS mutua (SSL). Este almacén de claves se puede configurar de forma dinámica utilizando {{ site.data.keys.mf_console }} o mfpadm. </p>

                <h3>Cifrado y descifrado nativo para iOS </h3>
                <p>Se ha eliminado a OpenSSL de la infraestructura principal para iOS y ha sido sustituido por un cifrado/descifrado nativo. OpenSSL se puede añadir como una infraestructura separada. Consulte Habilitación de OpenSSL para iOS. Para JavaScript de iOS Cordova, OpenSSL se sigue incluyendo en la infraestructura principal. El cifrado está disponible tanto para API nativas como para OpenSSL. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">Novedades en el soporte a sistemas operativos</a> </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} ahora da soporte a aplicaciones Windows 10 Universal, compilaciones de bitcode y Apple watchOS 2.</p>

                <h3>Soporte a aplicaciones universales para Windows 10 Native </h3>
                <p>Con {{ site.data.keys.product }}, ahora podrá escribir aplicaciones C# Universal App Platform nativas para que utilicen {{ site.data.keys.product_adj }} SDK en su aplicación. </p>

                <h3>Soporte para entornos híbridos de Windows  </h3>
                <p>Soporte de Windows 10 Universal Windows Platform (UWP) para entornos híbridos de Windows. Para obtener información sobre cómo empezar. </p>

                <h3>Fin del soporte a BlackBerry </h3>
                <p>En {{ site.data.keys.product }} deja de darse soporte al entorno BlackBerry. </p>

                <h3>Bitcode</h3>
                <p>Ahora se da soporte a las compilaciones de bitcode para proyectos iOS. Sin embargo, no se da soporte a la comprobación de seguridad de autenticidad de aplicación de {{ site.data.keys.product_adj }} para aplicaciones compiladas con bitcode. </p>

                <h3>Apple watchOS 2</h3>
                <p>Ahora se da soporte a Apple watchOS 2. Apple watchOS 2 precisa de compilaciones de bitcode. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">Novedades en el despliegue y la gestión de aplicaciones</a> </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Se presentan nuevas funcionalidades de {{ site.data.keys.product }} que ayudan a desplegar y gestionar sus aplicaciones. Ahora se podrán actualizar aplicaciones y adaptadores sin tener que reiniciar {{ site.data.keys.mf_server }}. </p>

                <h3>Soporte mejorado de DevOps </h3>
                <p>{{ site.data.keys.mf_server }} ha sido rediseñado de forma significativa para obtener un mejor soporte para el desarrollo de DevOps. {{ site.data.keys.mf_server }} se instala una vez en su entorno de servidor de aplicaciones, sin que sean necesarios cambios en la configuración del servidor de aplicaciones cada vez que se sube una aplicación o se cambia la configuración de {{ site.data.keys.mf_server }}. </p>

                <p>No es necesario reiniciar {{ site.data.keys.mf_server }} cuando se actualizan aplicaciones o adaptadores de los que dependan sus aplicaciones. Se pueden realizar operaciones de configuración, o subir una nueva versión de un adaptador o registrar una nueva aplicación sin que el servidor deje de manejar tráfico. </p>

                <p>Los roles de seguridad protegen las operaciones de desarrollo y cambios de configuración. </p>

                <p>Los artefactos de desarrollo se pueden subir al servidor de distintas maneras para ofrecer una mayor flexibilidad operativa: </p>

                <ul>
                    <li>Se ha mejorado {{ site.data.keys.mf_console }}:  En concreto, ahora se puede utilizar para registrar una aplicación o una versión nueva de una aplicación, para gestionar parámetros de seguridad de aplicaciones, y para desplegar certificados, crear etiquetas de notificación push y enviar notificaciones push. La consola ahora también incluye guías de ayuda contextual. </li>
                    <li>Herramienta de línea de mandatos </li>
                </ul>

                <p>Los artefactos de desarrollo que los usuarios suben al servidor incluyen adaptadores y sus configuraciones, configuraciones de seguridad de las aplicaciones, certificados de notificación push y filtros de registro. </p>

                <h3>Ejecución de aplicaciones que se crearon en IBM Bluemix en {{ site.data.keys.product }}</h3>
                <p>Los desarrolladores de aplicaciones de IBM Bluemix las pueden ejecutar en {{ site.data.keys.product }}. La migración precisa de la realización de cambios de configuración en las aplicaciones de cliente para utilizar las API de {{ site.data.keys.product }}. </p>

                <h3>{{ site.data.keys.product }} como un servicio en IBM Bluemix</h3>
                <p>Ahora de puede utilizar el servicio {{ site.data.keys.mf_bm_full }} en IBM Bluemix para crear y ejecutar aplicaciones móviles empresariales. </p>

                <h3>Sin archivos .wlapp</h3>
                <p>En versiones anteriores, las aplicaciones se desplegaban en {{ site.data.keys.mf_server }} subiendo un archivo <b>.wlapp</b>. El archivo contenía datos que describían la aplicación y, en el caso de aplicaciones híbridas, también de los recursos web necesarios. En la V8.0.0, en lugar del archivo <b>.wlapp</b>: </p>

                <ul>
                    <li>Una aplicación se registra en {{ site.data.keys.mf_server }} desplegando un archivo JSON descriptor de la aplicación. </li>
                    <li>Para actualizar aplicaciones Cordova utilizando Direct Update, se sube al servidor un archivador (archivo .zip) del recurso web modificado. El archivo archivador ya no contiene los archivos de vista previa web de las máscaras que eran posible incluir en versiones anteriores de {{ site.data.keys.product }}. Se han discontinuado. El archivado contiene únicamente los recursos web que se envían a los clientes, así como las sumas de comprobación para las validaciones de Direct Update. </li>
                </ul>

                <p>Para habilitar Direct Update de aplicaciones Cordova de cliente que están instaladas en dispositivos de usuario final, ahora debe desplegar los recursos web modificados como un archivador (archivo .zip) en el servidor. Para habilitar la utilización segura de Direct Update, en necesario desplegar un archivo de almacén de claves definido por el usuario en {{ site.data.keys.mf_server }}. También se debe incluir una copia de la clave pública coincidente en la aplicación de cliente desplegada. </p>

                <h3>Adaptadores</h3>
                <h4>Los adaptadores son proyectos Apache Maven. </h4>
                <p>Los adaptadores ahora se tratan como proyectos Maven. Cree, compile y despliegue adaptadores utilizando mandatos Maven de la línea de mandatos o utilizando un IDE que dé soporte a Maven como, por ejemplo, Eclipse e IntelliJ. </p>

                <h4>Configuración y despliegues de adaptadores en entornos DevOps</h4>
                <ul>
                    <li>Los administradores de {{ site.data.keys.mf_server }} ahora pueden utilizar a {{ site.data.keys.mf_console }} para modificar el comportamiento de un adaptador que se haya desplegado. Después de la reconfiguración, los cambios se hacen efectivos en el servidor de forma inmediata, sin la necesidad de volver a desplegar el adaptador ni reiniciar el servidor. </li>
                    <li>Ahora es posible "desplegar en caliente" adaptadores, lo que significar, desplegar, anular el despliegue o volver a desplegarlos en tiempo de ejecución, a la vez que {{ site.data.keys.mf_server }} sigue con su tráfico habitual. </li>
                </ul>

                <h4>Cambios en el archivo descriptor del adaptador </h4>
                <p>El archivo descriptor <b>adapter.xml</b> ha cambiado un poco. Para obtener más información sobre la estructura del archivo descriptor del adaptador, consulte las <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">Guías de aprendizaje de adaptadores</a>. </p>

                <h4>Integración con la interfaz de usuario de Swagger </h4>
                <p>{{ site.data.keys.mf_server }} ahora se integra con la interfaz de usuario de Swagger. Con cualquier adaptador, podrá visualizar la API asociada pulsando Ver documentos de Swagger en el separador Recursos en {{ site.data.keys.mf_console }}. La característica únicamente está disponible en entornos de desarrollo. </p>

                <h4>Soporte para adaptadores JavaScript</h4>
                <p>En los adaptadores JavaScript únicamente se da soporte a los tipos de conectividad HTTP y SQL. </p>

                <h4>Soporte para JAX-RS 2.0 </h4>
                <p>JAX-RS 2.0 presenta una nueva funcionalidad del lado del servidor: HTTP asíncrono del lado del servidor, filtros e interceptores. Ahora los adaptadores pueden sacar partido de estas nuevas características. </p>

                <h3>{{ site.data.keys.product }} on IBM Containers</h3>
                <p>{{ site.data.keys.product }} on IBM Containers está disponible para la V8.0.0 en el sitio <a href="http://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage</a>. Esta versión de {{ site.data.keys.product }} on IBM Containers está lista para entornos de producción y da soporte a la base de datos transaccional empresarial dashDB en IBM Bluemix. </p>

                <p><b>Nota:</b> Consulte los requisitos previos para desplegar {{ site.data.keys.product }} on IBM Containers.</p>

                <h3>Despliegue de {{ site.data.keys.mf_server }} en IBM PureApplication System</h3>
                <p>Ahora es posible desplegar y configurar {{ site.data.keys.mf_server }} en el {{ site.data.keys.product }} System Pattern en IBM PureApplication System. </p>

                <p>Todos los patrones de sistema de {{ site.data.keys.product }} soportados ahora incluyen el soporte para una base de datos IBM DB2 existente. Ahora se da soporte a {{ site.data.keys.mf_app_center_full }} en un patrón de sistema virtual. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">Novedades en {{ site.data.keys.mf_server }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>Se ha rediseñado {{ site.data.keys.mf_server }} para reducir el tiempo y el coste de desplegar y actualizar aplicaciones. Además del rediseño de {{ site.data.keys.mf_server }}, {{ site.data.keys.product }} incrementa el número de métodos de instalación disponibles. </p>

                <p>El nuevo diseño de {{ site.data.keys.mf_server }} presenta dos nuevos componentes, el servicio de actualización activo de {{ site.data.keys.mf_server }} y los artefactos de {{ site.data.keys.mf_server }}. </p>

                <p>El servicio de actualización activa de {{ site.data.keys.mf_server }} está diseñado para reducir el tiempo y el coste de las actualizaciones incrementales de sus aplicaciones. Gestiona y almacena datos de configuración del lado del servidor de las aplicaciones y los adaptadores. Es posible cambiar o actualizar distintas partes de sus aplicaciones al compilarlas o desplegarlas: </p>

                <ul>
                    <li>Actualizar o cambiar dinámicamente el comportamiento de la aplicación en base a segmentos de usuario que éste defina. </li>
                    <li>Actualizar o cambiar dinámicamente la lógica empresarial del lado del servidor. </li>
                    <li>Actualizar o cambiar dinámicamente la seguridad de la aplicación. </li>
                    <li>Cambiar dinámicamente o externalizar la configuración de la aplicación. </li>
                </ul>

                <p>Los artefactos de {{ site.data.keys.mf_server }} proporcionan recursos para {{ site.data.keys.mf_console }}. </p>

                <p>Junto con el rediseño de {{ site.data.keys.mf_server }}, ahora se proporcionan más opciones de instalación. Además de la instalación manual, {{ site.data.keys.product }} ofrece dos opciones para instalar {{ site.data.keys.mf_server }} en una granja de servidores. También puede instalar {{ site.data.keys.mf_server }} en una colectividad Liberty. </p>

                <p>Ahora puede instalar los componentes de {{ site.data.keys.mf_server }} en una granja de servidores utilizando tareas Ant o con la Herramienta de configuración del servidor. Para obtener más información, consulte los temas siguientes: </p>

                <ul>
                    <li>Instalación de una granja de servidores</li>
                    <li>Guías de aprendizaje sobre la instalación de {{ site.data.keys.mf_server }} </li>
                </ul>

                <p>{{ site.data.keys.mf_server }} también da soporte a colectividades Liberty. Para obtener más información sobre la topología del servidor y los distintos métodos de instalación, consulte los siguientes temas: </p>

                <ul>
                    <li>Topología de colectividad de Liberty</li>
                    <li>Ejecución de la Herramienta de configuración del servidor</li>
                    <li>Instalación con tareas Ant</li>
                    <li>Instalación manual en una colectividad Application Server Liberty</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">Novedades en {{ site.data.keys.mf_analytics }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }} presenta una consola rediseñada con mejoras en la presentación de la información y unos controles de acceso basados en roles. La consola está ahora disponible también en distintos idiomas. </p>

                <p>Se ha rediseñado a {{ site.data.keys.mf_analytics_console }} para que presente la información de forma intuitiva y más útil, utilizando datos resumidos para algunos tipos de sucesos. </p>

                <p>Ahora existe la posibilidad de finalizar una sesión de {{ site.data.keys.mf_analytics_console }} pulsando el icono de la rueda dentada. </p>

                <p>{{ site.data.keys.mf_analytics_console }} ahora está disponible en los siguientes idiomas: </p>
                <ul>
                    <li>Alemán</li>
                    <li>Español </li>
                    <li>Francés </li>
                    <li>Italiano </li>
                    <li>Japonés</li>
                    <li>Coreano </li>
                    <li>Portugués (Brasil)</li>
                    <li>Ruso </li>
                    <li>Chino (simplificado)</li>
                    <li>Chino (tradicional)</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics_console }} ahora muestra contenido diferente en función del rol de seguridad del usuario que ha iniciado la sesión. <br/>
                Para obtener más información, consulte <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">Control de acceso basado en roles</a>.</p>

                <p>{{ site.data.keys.mf_analytics_server }} utiliza Elasticsearch V1.7.5.</p>

                <p>Se ha añadido soporte a {{ site.data.keys.mf_analytics_short }} para aplicaciones web con la nueva API del lado de cliente de analíticas web. </p>

                <p>Se han cambiado algunos tipos de suceso entre las versiones anteriores de {{ site.data.keys.mf_analytics_server }} y la V8.0. Debido a este cambio, todas las propiedades JNDI que se configuraron con anterioridad en su archivo de configuración del servidor se deben convertir al nuevo tipo de suceso. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">Novedades en notificaciones push de {{ site.data.keys.product_adj }}</a> </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>Ahora el servicio de notificaciones push se proporciona como un servicio autónomo que se aloja en una aplicación web aparte. </p>

                <p>Versiones anteriores de {{ site.data.keys.product }} incluían el servicio de notificaciones push como parte del tiempo de ejecución de la aplicación. </p>

                <h3>Modelo de programación </h3>
                <p>El modelo de programación abarca del cliente al servidor. Es necesario configurar la aplicación para que el servicio de notificaciones push pueda funcionar con sus aplicaciones de cliente. Hay dos tipos de cliente que pueden interactuar con el servicio de notificaciones push: </p>

                <ul>
                    <li>Aplicaciones de cliente móvil </li>
                    <li>Aplicaciones de servidor de fondo </li>
                </ul>

                <h3>Seguridad para el servicio de notificaciones push </h3>
                <p>El servidor de autorización de {{ site.data.keys.product }} impone el protocolo OAuth para proteger el servicio de notificaciones push. </p>

                <h3>Modelo del servicio de notificaciones push </h3>
                <p>No se da soporte al modelo basado en un origen de sucesos. La funcionalidad de las notificaciones push se habilita en {{ site.data.keys.product }}  mediante el modelo de servicio push. </p>

                <h3>API REST de Push </h3>
                <p>Existe también la posibilidad de habilitar aplicaciones de servidor de fondo que se despliegan fuera de {{ site.data.keys.mf_server }} para acceder a las funciones de notificación push utilizando la API REST para push en el entorno de tiempo de ejecución de {{ site.data.keys.product }}. </p>

                <h3>Actualización desde un modelo de notificaciones basado en un origen de sucesos existente </h3>
                <p>No se da soporte al modelo basado en un origen de sucesos. La funcionalidad de las notificaciones push se habilita en su totalidad mediante el modelo de servicio push. Es necesario migrar todas las aplicaciones basadas en un origen de sucesos al modelo de servicio push. </p>

                <h3>Envío de notificaciones push </h3>
                <p>Puede elegir enviar desde el servidor notificaciones push basadas en un origen de sucesos, basadas en una etiqueta o habilitadas para difusiones. </p>

                <p>Las notificaciones push se pueden enviar de las siguientes maneras: </p>
                <ul>
                    <li>Utilizando {{ site.data.keys.mf_console }} se pueden enviar dos tipos de notificaciones: etiqueta y difusión. Consulte Envío de notificaciones push con {{ site.data.keys.mf_console }}.</li>
                    <li>Utilizando la API REST Push Message (POST), se pueden enviar todos los tipos de notificaciones: etiqueta, difusión y autenticada. </li>
                    <li>Utilizando la API REST para el servicio de administración de {{ site.data.keys.mf_server }}, se pueden enviar todos los tipos de notificaciones: etiqueta, difusión y autenticada. </li>
                </ul>

                <h3>Envío de notificaciones SMS </h3>
                <p>Existe la posibilidad de configurar el servicio push para que envíe notificaciones SMS (Short Message Service) a dispositivos de los usuarios. </p>

                <h3>Instalación del servicio de notificaciones push </h3>
                <p>El servicio de notificaciones push se empaqueta como un componente de {{ site.data.keys.mf_server }} (servicio push de {{ site.data.keys.mf_server }}). </p>

                <h3>En las aplicaciones Windows Universal Platform se da soporte al modelo de servicio push</h3>
                <p>Es posible migrar aplicaciones Universal Windows Platform (UWP) nativas para que utilicen el modelo de servicio push para enviar notificaciones push. </p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">Novedades en {{ site.data.keys.mf_app_center }} </a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>Ahora se da soporte a {{ site.data.keys.mf_app_center }} en Bluemix (basado en contenedores) a través de scripts BYOL. </p>
            </div>
        </div>
    </div>
</div>
