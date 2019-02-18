---
layout: tutorial
title: Adaptadores para servicios cognitivos de Watson
breadcrumb_title: Adapters for Watson services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Watson en IBM Cloud, proporciona acceso a la más amplia gama de tecnologías cognitivas disponible actualmente para crear aplicaciones inteligentes de forma rápida y segura. El análisis de imágenes y vídeo para entender sentimientos o la extracción de palabras claves y entidades de texto son algunas de las funcionalidades que ofrecen los servicios Watson.

Watson ofrece mucho más en lo que ser refiere a la informática cognitiva. Natural Language Understanding, Visual Recognition y Discovery ofrecen un entendimiento de los datos no estructurados ofreciendo la posibilidad de reinventar operaciones y transformando sectores verticales. Obtenga [aquí](https://www.ibm.com/watson/developercloud/) más información sobre los servicios cognitivos de Watson en IBM Cloud.

Los adaptadores de {{ site.data.keys.product }} se utilizan para realizar toda la lógica necesaria del lado del servidor y para transferir y recuperar información desde sistemas de fondo para los servicios de nube y las aplicaciones de cliente. {{ site.data.keys.product }} ahora proporciona adaptadores para algunos de los servicios cognitivos de Watson.

##  Adaptadores para servicios de Watson
{: #watson-adapter}

{{ site.data.keys.product_full }} a partir del [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) proporciona de forma estándar adaptadores para algunos de los servicios cognitivos de Watson como, por ejemplo, [Conversation](https://www.ibm.com/watson/developercloud/conversation.html), [Discovery](https://www.ibm.com/watson/developercloud/discovery.html) y [Natural Language Understanding](https://www.ibm.com/watson/developercloud/natural-language-understanding.html). Estos adaptadores están disponibles para su descarga desde el **Centro de descargas** en Mobile Foundation Console.

Para que su aplicación se pueda conectar al servicio cognitivo de Watson, descargue el adaptador del servicio cognitivo y despliéguelo en el servidor de {{ site.data.keys.product_adj }}. La aplicación podrá ahora llamar a la API del adaptador para invocar al servicio Watson.

Una vez se haya desplegado el adaptador, configúrelo para conectarse al servicio de Watson. Para ello, vaya a la página de **Configuración de adaptador** y proporcione el *nombre de usuario* y la *contraseña*, desde las **Credenciales del servicio** de Watson, en el campo _**nombre de usuario**_ y _**contraseña**_ en la página **Configuración de adaptador** y guarde la configuración.

Si necesita modificar el adaptador, descargue el código fuente del adaptador desde el repositorio github:<br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU (Natural Language Understanding)**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
