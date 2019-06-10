---
layout: tutorial
title: Utilización de SSL en adaptadores JavaScript HTPT
breadcrumb_title: Using SSL
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
El protocolo SSL se puede utilizar en un adaptador HTTP con autenticación simple o mutua para conectarse a los servicios de fondo.  
SSL proporciona seguridad a nivel de transporte, que es independiente de la autenticación básica. La autenticación básica se puede realizar sobre HTTP o HTTPS.

1. Establezca el protocolo del URL del adaptador HTTP en <b>https</b> en el archivo adapter.xml.
2. Almacene certificados SSL en el almacén de claves de {{ site.data.keys.mf_server }}. [Consulte configuración del almacén de claves de {{ site.data.keys.mf_server }}](../../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

### SSL con autenticación mutua
{:# ssl-with-mutual-authentication }

Si utiliza SSL con autenticación mutua, también debe realizar los pasos siguientes:

1. Generar sus propias claves privadas para el adaptador HTTP o utilizar una que proporcione una autoridad de certificación de confianza.
2. Si genera su propia clave privada, exporte el certificado público de la clave privada generada e impórtelo en el almacén de confianza del servicio de fondo.
3. Defina un alias y una contraseña para la clave privada en el elemento `connectionPolicy` del archivo **adapter.xml**. 
