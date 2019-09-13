---
layout: tutorial
title: Glosario
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{ site.data.keys.mf_console }}" for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>
Este glosario proporciona términos y definiciones para software y productos de {{ site.data.keys.product }}.

Este glosario utiliza las siguientes referencias cruzadas:

* **Consulte** le remite a un término similar o a una abreviación de la forma completa.
* **Consulte también** le remite a un término relacionado u opuesto.

Para ver otros términos y definiciones, consulte el [sitio web de terminología de IBM](http://www.ibm.com/software/globalization/terminology/).

## A
{: #a }

### política de adquisición
{: #acquisition-policy }
Una política que controla cómo se recopilan los datos desde un sensor de un dispositivo móvil. La política la define un código de aplicación.

### adaptador
{: #adapter }
El código del lado del servidor de una aplicación de {{ site.data.keys.product_adj }}. Los adaptadores se conectan a las aplicaciones empresariales, envían datos a aplicaciones móviles y desde ellas y realizan cualquier lógica de lado del servidor en datos enviados.

### base de datos de administración
{: #administration-database }
La base de datos de {{ site.data.keys.mf_console }} y de Administration Services. Las tablas de bases de datos definen elementos como, por ejemplo, las aplicaciones, los adaptadores, los proyectos con sus descripciones y las órdenes de magnitud.

### Administration Services
{: #administration-services }
Una aplicación que aloja las tareas de administración y los servicios REST. La aplicación Administration Services está empaquetada en su propio archivo WAR.

### alias
{: #alias }
Una asociación supuesta o real entre dos entidades de datos, o entre una entidad de datos y un puntero.

### Android
{: #android }
Un sistema operativo móvil creado por Google, la mayor parte se publica bajo las licencias de código abierto de Apache 2.0 y GPLv2. Consulte también dispositivo móvil.

### API / Application Programming Interface (API)
{: #api-application-programming-interfacae-api }
Interfaz que permite que un programa de aplicación escrito en lenguaje de alto nivel utilice datos o funciones específicos del sistema operativo o de otro programa.

### aplicación (o app)
{: #app }
Una aplicación web o de dispositivo móvil. Consulte también aplicación web.

### Application Center
{: #application-center }
Un componente de {{ site.data.keys.product_adj }} que sirve para compartir aplicaciones y facilitar la colaboración entre los miembros del equipo en un único repositorio de aplicaciones móviles.

### Instalador de Application Center
{: #application-center-installer }
Una aplicación que lista el catálogo de las aplicaciones disponibles en Application Center. El instalador de Application Center debe estar en un dispositivo para poder instalar aplicaciones desde su repositorio de aplicaciones privado.

### archivo descriptor de aplicación
{: #application-descriptor-file }
Un archivo de metadatos que define varios aspectos de una aplicación.

### autenticación
{: #authentication }
Un servicio de seguridad que proporciona una prueba que un usuario de un sistema es realmente la persona que afirma ser. Los mecanismos comunes para implementar el servicio son las contraseñas y las firmas digitales.

## B
{: #b }
### Base64
{: #base64 }
Un texto sin formato que se utiliza para codificar datos binarios. La codificación Base64 se utiliza habitualmente en la autenticación del certificado de usuario para codificar certificados X.509, CSR de X.509 y CRL de X.509. Consulte también, codificado DER, codificado PEM.

### binario
{: #binary }
Perteneciente a algo que se compila o es ejecutable.

### bloque
{: #block }
Una recopilación de muchas propiedades (como las del adaptador, el procedimiento o el parámetro).

### notificación de difusión
{: #broadcast-notification }
Una notificación dirigida a todos los usuarios de una aplicación específica de {{ site.data.keys.product_adj }}. Consulte también notificación basada en etiqueta.

### definición de compilación
{: #build-definition }
Un objeto que define una compilación como, por ejemplo, una compilación de integración de ámbito semanal.

## C
{: #c }

### CA / Certificate Authority (CA)
{: #ca--certificate-authority-ca }
Es una organización externa de confianza o compañía que emite los certificados digitales. La entidad emisora de certificados generalmente comprueba la identidad de las personas a quienes se otorga el certificado exclusivo. Consulte también [certificado](#certificate).

### función de devolución de llamada
{: #callback-function }
Código ejecutable que permite una capa de software de nivel inferior para llamar a una función definida en una capa de nivel superior.

### catálogo
{: #catalog }
Un conjunto de aplicaciones.

### certificado
{: #certificate }
En seguridad informática, documento digital que enlaza una clave pública a la identidad del propietario del certificado y, de este modo, posibilita la autenticación del propietario del certificado. Una entidad emisora de certificados es la encargada de emitir un certificado, que está firmado digitalmente por dicha entidad. Consulte también [autoridad de certificación](#ca--certificate-authority-ca).

### aplicación de empresa de autoridad de certificación
{: #certificate-authority-enterprise-application }
Una aplicación de empresa que proporciona certificados y claves privadas para las aplicaciones de sus clientes.

### desafío
{: #challenge }
Una solicitud a un sistema de determinada información. La información, que se devuelve a un servidor como respuesta a esta solicitud, es necesaria para la autenticación del cliente.

### manejador de desafíos
{: #challenge-handler }
Un componente del lado del cliente que emite una secuencia de desafíos en el lado del servidor y responde en el lado del cliente.

### cliente
{: #client }
Un programa de software o sistema que solicita servicios desde un servidor.

### componente de autenticación del lado de cliente
{: #client-side-authentication-componnet }
Un componente que recopila información del cliente, luego utiliza módulos de inicio de sesión para comprobar esta información.

### clon
{: #clone }
Una copia idéntica de la versión aprobada más reciente de un componente con un nuevo ID de componente exclusivo.

### clúster
{: #cluster }
Una conjunto de sistemas completos que funcionan juntos para proporcionar una funcionalidad de cálculo única y unificada.

### aplicación de empresa
{: #company-application }
Una aplicación diseñada para uso interno en una empresa.

### concentrador de la empresa
{: #company-hub }
Una aplicación que puede distribuir otras aplicaciones especificadas para instalarlas en un dispositivo móvil. Por ejemplo, Application Center es un concentrador de la empresa. Consulte también [Application Center](#application-center).

### componente
{: #component }
Un programa u objeto reutilizable que realiza una función determinada y funciona con otras aplicaciones y componentes.

### credencial
{: #credential }
Un conjunto de información que garantiza a un usuario o proceso determinados derechos de acceso.

### CRL / Certificate Revocation List (CRL)
{: #crl-certificate-revocation-list-crl }
Una lista de certificados que se han revocado antes de la fecha de caducidad planificada. Las listas de revocación de certificados son mantenidas por la autoridad de certificación y utilizadas, durante un reconocimiento de Secure Sockets Layer (SSL) para asegurarse de que los certificados implicados no se hayan revocado.

## D
{: #d }

### origen de datos
{: #data-source }
Los medios por los que una aplicación accede a datos desde una base de datos.

### despliegue
{: #deployment }
El proceso de la instalación y configuración de una aplicación de software y todos sus componentes.

### codificado DER
{: #der-encoded }
Pertenece a una forma binaria de un certificado formateado con ASCII PEM. Consulte también Base64, codificado PEM.

### dispositivo
{: #device }
Consulte [dispositivo móvil](#mobile-device).

### contexto de dispositivo
{: #device-context }
Datos que se han utilizado para identificar la ubicación de un dispositivo. Estos datos pueden incluir coordenadas geográficas, puntos de acceso WiFi e información detallada de indicación de fecha y hora. Consulte también desencadenador.

### inscripción de dispositivo
{: #device-enrollment }
El proceso de un propietario de dispositivos de registrar su dispositivo como de confianza.

### documentify
{: #documentify }
Un mandato JSONStore que se utiliza para crear un documento.

## E
{: #e }

### emulador
{: emulator }
Una aplicación que se puede utilizar para ejecutar un medio de aplicaciones para una plataforma que no sea la actual.

### cifrado
{: #encryption }
En la seguridad de sistemas, proceso que transforma datos a una forma no inteligible de manera que no se pueden obtener los datos originales o solamente se pueden obtener utilizando un proceso de descifrado.

### aplicación de empresa
{: #enterprise-application }
Consulte aplicación de empresa.

### entidad
{: #entity }
Un usuario, grupo o recurso que estén definidos en un servicio de seguridad.

### entorno
{: #environment }
Una instancia determinada de una configuración de hardware y software.

### suceso
{: #event }
Una situación significativa en una tarea o sistema. Los sucesos pueden incluir la terminación o la anomalía de una operación, una acción de usuario, o el cambio de estado de un proceso.

### origen de sucesos
{: #event-source }
Un objeto que da soporte a un servidor de notificaciones asíncronas dentro de una máquina virtual Java individual. Si utiliza un origen de sucesos, se podrá registrar un objeto de escucha de sucesos y se utilizará para mejorar cualquier interfaz.

## F
{: #f }

### faceta
{: #facet }
Una entidad de XML que restringe los tipos de datos de XML.

### nodo de granja de servidores
{: #farm-node }
Un servidor en red alojado en una granja de servidores.

### disparar
{: #fire }
En la programación orientada a objetos, provocar una transición de estados.

## G
{: #g }
### pasarela
{: #gateway }
Un dispositivo o programa que se usa para conectar redes o sistemas con distintas arquitecturas de red.

### geocodificación
{: #geocoding }
El proceso de identificación de geocódigos de marcadores geográficos más tradicionales (direcciones, códigos postales, etc.). Por ejemplo, un punto de referencia puede
ubicarse en la intersección de dos calles, pero el geocódigo del punto de referencia consiste en una
secuencia numérica.

### geolocalización
{: #geolocation }
El proceso para indicar una ubicación basada en la evaluación de varios tipos de señales. En informática móvil, normalmente se utilizan puntos de acceso WLAN y torres celulares para aproximarse a una ubicación. Consulte también geocodificación, servicios de ubicación.

## H
{: #h }

### granja de servidores homogénea
{: #homogeneous-server-farm }
Una granja de servidores en la que todos los servidores de aplicaciones tiene el mismo tipo, nivel y versión.

### aplicación híbrida
{: #hybrid-application }
Una aplicación que se escribe principalmente en lenguajes orientados en la web (HTML5, CSS y JS) pero se acomoda en un shell nativo para que la aplicación se comporte correctamente y proporcione el usuario con todas las funciones de una aplicación nativa.

## I
{: #i }

### aplicación interna
{: #in-house-application }
Consulte también [aplicación de empresa](#company-application).

## J
{: #j }

### JMX / Java Management Extensions (JMX)
{: #jmx--java-management-extensions-jmx }
Una forma de hacer gestión de y por medio de tecnología Java. JMX es una ampliación abierta y universal del lenguaje de programación Java para la gestión y se puede desplegar en todos los sectores en los que ésta sea necesaria.

## K
{: #k }

### clave
{: #key }
Un valor matemático criptográfico que se utiliza para firmar, verificar, cifrar o descifrar digitalmente los mensajes. Consulte también clave privada y clave pública.
Uno o más caracteres de un elemento de datos que se utilizan para identificar de forma exclusiva un registro y establecer su orden con respecto a otros registros.

### cadena de claves
{: #keychain }
Un sistema de gestión de contraseñas para software de Apple. Una cadena de claves actúa cono un contenedor de almacenamiento seguro para contraseñas que se utilizan en varias aplicaciones y servicios.

### pareja de claves
{: #key-pair }
En seguridad de sistemas, una clave pública y una clave privada. Si la pareja de claves se utiliza para el cifrado, el remitente utiliza la clave pública del destinatario para cifrar el mensaje y el destinatario utiliza su clave privada para descifrarlo. Si la pareja de claves se utiliza para firmar, el firmante utiliza su clave privada para cifrar una representación del mensaje y el destinatario utiliza le clave pública del remitente para descifrar la representación del mensaje para la comprobación de la firma.

## L
{: #l }

### biblioteca
{: #library }
Un objeto del sistema que sirve como un directorio para otros objetos. Una biblioteca agrupa objetos relacionados y permite a los usuarios buscar objetos por nombre.
Un conjunto de elementos modelo, que incluye elementos empresariales, procesos, tareas, recursos y organizaciones.

### equilibrio de carga
{: #load-balancing }
Un método de red de sistemas para distribuir cargas de trabajo por varios sistemas o en un clúster de sistemas, enlaces de red, unidades de procesamiento central u otros recursos. Un equilibrio de carga satisfactorio optimiza el uso de recursos, maximiza el rendimiento, minimiza el tiempo de respuesta y evita la sobrecarga.

### almacén local
{: #local-store }
Una área de un dispositivo en la que las aplicaciones se pueden almacenar localmente y recuperar datos localmente sin la necesidad de una conexión de red.

## M
{: #m }

### MBean / Managed Bean (MBean)
{: #mbean--managed-bean-mbean}
En la especificación de JMX (Java Management Extensions), los objetos Java que implementan recursos y su instrumentación.

### móvil
{: #mobile }
Consulte [dispositivo móvil](#mobile-device).

### cliente móvil
{: #mobile-client }
Consulte [instalador de Application Center](#application-center-installer).

### dispositivo móvil
{: #mobile-device }
Un asistente digital personal, tableta o teléfono que funcione en una red de radio. Consulte también Android.

### Adaptador MobileFirst
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Consulte [adaptador](#adapter)

### MobileFirst Data Proxy
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Un componente del lado del servidor para que IMFData SDK se pueda utilizar para proteger llamadas de aplicación móvil a Cloudant utilizando las funcionalidades de seguridad de {{ site.data.keys.product }} OAuth. El proxy de datos de {{ site.data.keys.product_adj }} precisa de una autenticación a través del interceptor de asociación de confianza.

### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Una interfaz basada en web que se utiliza para controlar y gestionar entornos de tiempo de ejecución de {{ site.data.keys.product_adj }} que se despliegan en {{ site.data.keys.mf_server }} y para recopilar y analizar estadísticas de usuario.

### Entorno de tiempo de ejecución de MobileFirst
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Un componente del lado del servidor optimizado para sistemas móviles que ejecuta el lado del servidor de las aplicaciones móviles (integración de fondo, gestión de versiones, seguridad, notificación push unificada). Cada entorno de tiempo de ejecución se empaqueta como una aplicación web (archivo WAR).

### MobileFirst Server
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Un componente de {{ site.data.keys.product_adj }} que maneja la seguridad, conexiones de fondo, notificaciones push, la gestión de aplicaciones móviles y analíticas. {{ site.data.keys.mf_server }} es un conjunto de aplicaciones que se ejecuta en un servidor de aplicaciones y que actúa como contenedor de tiempo de ejecución para entornos de tiempo de ejecución de {{ site.data.keys.product_adj }}.

## N
{: #n }

### aplicación nativa
{: #native-app }
Una aplicación que se compila en código binario para utilizarla en el sistema operativo móvil del dispositivo.

### nodo
{: #node }
Un grupo lógico de servidores gestionados.

### notificación
{: #notification }
Una incidencia en un proceso que puede desencadenar una acción. Las notificaciones se pueden utilizar para crear modelos de condiciones de interés que se transmitan desde un remitente a un conjunto (normalmente desconocido) de destinatarios (los receptores).

## O
{: #o }

### OAuth
{: #oauth }
Un protocolo de autorización basado en HTTP que proporciona a las aplicaciones acceso de ámbito a un recurso protegido en nombre del propietario del recurso, creando una interacción de aprobación entre el propietario del recurso, el cliente y el servidor de recursos.

## P
{: #p }

### navegación de páginas
{: #page-navigation }
Una característica del navegador que permite a los usuarios navegar hacia atrás y hacia delante en un navegador.

### codificación PEM
{: #pem-encoded }
Perteneciente a un certificado codificado en Base64. Consulte también Base64, codificación DER.

### PKI / Public Key Infrastructure (PKI)
{: #pki--public-key-infrastructure-pki }
Un sistema de certificados digitales, autoridades de certificación y otras autoridades de registro que verifican y autentican la validez de cada parte implicada en la transacción de red.

### puente PKI
{: #pki-bridge }
Un concepto de {{ site.data.keys.mf_server }} que permite a la infraestructura de autenticación del certificado de usuario comunicarse con una PKI.

### sondeo
{: #poll }
Solicitar repetidamente datos de un servidor.

### clave privada
{: #private-key }
En las comunicaciones seguras, un patrón de algoritmos utilizado para cifrar mensajes que sólo la clave pública correspondiente puede descifrar. La clave privada también se utiliza para descifrar mensajes cifrados por la clave pública correspondiente. La clave privada se conserva en el sistema del usuario y se protege con una contraseña. Consulte también clave, clave pública.

### proyecto
{: #project }
El entorno de desarrollo para varios componentes, como aplicaciones, adaptadores, archivos de configuración, código de Java personalizado y bibliotecas.

### archivo WAR de proyecto
{: #project-war-file }
Archivo archivador web (WAR) que contiene las configuraciones para el entorno de tiempo de ejecución de {{ site.data.keys.product_adj }} y que se despliega en el servidor de aplicaciones.

### provisión
{: #provisin }
Proporcionar, desplegar y rastrear un servicio, componente, aplicación o servicio.

### proxy
{: #proxy }
Una pasarela de aplicaciones desde una red a otra para una aplicación de red específica como Telnet o FTP, por ejemplo, donde un servidor Telnet de proxy de cortafuegos realiza la autenticación del usuario y luego deja pasar el tráfico mediante el proxy como si no estuviera ahí. La función se realiza en el cortafuegos y no en la estación de trabajo del cliente, lo que supone más carga de trabajo en el cortafuegos.

### clave pública
{: #public-key }
En las comunicaciones seguras, patrón de algoritmos que se utiliza para descifrar mensajes que se han cifrado con la clave privada correspondiente. Una clave pública también se utiliza para cifrar mensajes que han sido descifrados sólo con la correspondiente clave privada. Los usuarios difunden sus claves públicas a todos aquellos con los que deben intercambiar mensajes cifrados. Consulte también clave, clave privada.

### push
{: #push }
Enviar información desde un servidor a un cliente. Cuando un servidor envía contenido, es el servidor que inicia la transacción, no una solicitud desde el cliente.

### notificación push
{: #push-notification }
Una alerta que indica un cambio o actualización que aparece en un icono de aplicación móvil.

## R
{: #r }

### proxy inverso
{: #reverse-proxy }
Una topología de reenvío de IP donde el proxy actúa en nombre del servidor HTTP de fondo. Se trata de un proxy de aplicación para servidores que utilizan HTTP.

### raíz
{: #root }
El directorio que contiene todos los demás directorios de un sistema.

## S
{: #s}

### sal
{: #salt }
Datos generados aleatoriamente que se insertan en una contraseña o hash de frase de contraseña, y que convierten dichas contraseñas en no comunes y difíciles de averiguar.

### SDK / Software Development Kit (SDK)
{: #sdk--software-development-kit-sdk }
Un conjunto de herramientas, API y documentación para ayudar en el desarrollo de software en un lenguaje de computación específico o en un determinado entorno operativo.

### prueba de seguridad
{: #security-test }
Un conjunto ordenado de los reinos de autenticación que se utilizan para proteger un recurso, como el procedimiento de adaptador, aplicación o URL estática.

### granja de servidores
{: #server-farm }
Un grupo de servidores en red.

### servicio
{: #service }
Un programa que realiza una función primaria en un servidor o un software relacionado.

### sesión
{: #sessions }
Una conexión lógica o virtual entre dos estaciones, programas de software o dispositivos en una red que permite que los dos elementos se comuniquen e intercambien datos durante la sesión.

### firma
{: #sign }
Adjuntar una sola firma electrónica, derivada del ID de usuario del remitente, en un documento o campo al enviar un documento. Firmando el correo le asegura que si un usuario no autorizado crea una nueva copia de un ID de usuario, el usuario no autorizado no podrá falsificar su firma. Además, la firma comprueba que nadie ha alterado los datos mientras el mensaje está en transito.

### simulador
{: #simulator }
Un entorno para el código transitorio que se escribe en una plataforma diferente. Los simuladores se utilizan para desarrollar y probar el código en el mismo entorno de desarrollo integrado,
sin embargo, más tarde se despliega el código en su plataforma específica. Por ejemplo, se puede desarrollar un código para un dispositivo de Android en un sistema y luego probarlo utilizando un simulador en dicho sistema.

### skin
{: #skin }
Un elemento de una interfaz gráfica de usuario que se puede cambiar para alterar el aspecto de la interfaz sin afectar a su funcionalidad.

### deslizar
{: #slide }
Mover horizontalmente un elemento de interfaz deslizante en una pantalla táctil. Normalmente, las aplicaciones utilizan gestos de deslizar para bloquear y desbloquear teléfonos o para alternar las opciones.

### subelemento
{: #subelement }
En estándares EDI UN/EDIFACT, un elemento de datos EDI que forma parte de un elemento de datos compuestos EDI. Por ejemplo, un elemento de datos EDI y su calificador son subelementos de un elemento de datos compuestos EDI.

### suscripción
{: #subscription }
Un registro que contiene la información que un suscriptor pasa a un intermediario local o servidor para describir las publicaciones que desea recibir.

### sintaxis
{: #syntax }
Las reglas para la construcción de un mandato o una sentencia.

### mensaje de sistema
{: #system-message }
Un mensaje automatizado a un dispositivo móvil que proporciona alertas o estados operativos, por ejemplo si las conexiones son correctas o no.

## T
{: t}

### notificación basada en etiquetas
{: #tag-based-notification }
Una notificación dirigida a dispositivos suscritos para una etiqueta específica. Las etiquetas se utilizan para representar temas de interés
del usuario. Consulte también notificación de difusión.

### TAI / Trust Association Interceptor (TAI)
{: #tai--trust-association-interceptor-tai }
El mecanismo con el que se valida la confianza en el entorno de producto de cada solicitud que el servidor proxy haya recibido. El método de validación se acuerda entre el servidor proxy y el interceptor.

### tocar
{: #tap }
Tocar brevemente una pantalla táctil. Normalmente, las aplicaciones utilizan gestos como toques para seleccionar elementos, se parece a pulsar con el botón izquierdo del ratón.

### plantilla
{: #template }
Un grupo de elementos que comparten propiedades comunes. Estas propiedades se pueden definir una sola vez, en el nivel de plantilla, y todos los elementos las heredan para utilizarlas en la plantilla.

### desencadenador
{: #trigger }
Un mecanismo que detecta una aparición y puede provocar un proceso adicional como respuesta. Los desencadenadores se pueden activar cuando se producen cambios en el contexto del dispositivo. Consulte también contexto de dispositivo.

## U
{: #u }

## V
{: #v }

### vista
{: #view }
Un panel que está fuera del área del editor y que se puede utilizar para ver los recursos del entorno de trabajo o trabajar con ellos.

## W
{: #w}

### aplicación /app web
{: #web-app--application }
Aplicación a la que puede accederse mediante un navegador web y que proporciona otras funciones aparte de la visualización estática de la información, permitiendo, por ejemplo, que el usuario realice una consulta a una base de datos. Los componentes habituales de una aplicación web incluyen páginas HTML, páginas JSP y servlets. Consulte también [aplicación](#A).

### servidor de aplicaciones web
{: #web-application-server }
El entorno de tiempo de ejecución para aplicaciones web dinámicas. Un servidor de aplicaciones web Java EE implementa los servicios del estándar Java EE.

### recurso web
{: #web-resource }
Cualquiera de los recursos que se crean durante el desarrollo de una aplicación web como, por ejemplo, proyectos web, páginas HTML, archivos JSP (JavaServer Pages), servlets, bibliotecas de etiquetas personalizadas y archivadores.

### widget
{: #widget }
Una aplicación portátil y reutilizable o una pieza de contenido dinámico que se puede ubicar en una página web, recibir entradas y comunicarse con una aplicación u otro widget.

### derivador
{: #wrapper }
Una sección de código que contiene código que de lo contrario el compilador no podría interpretar. El derivador funciona como una interfaz entre el compilador y el código del compilador.

## X
{: #x }

### certificado X.509
{: #x509-certificate }
Un certificado que contiene información definida mediante el estándar X.509.
