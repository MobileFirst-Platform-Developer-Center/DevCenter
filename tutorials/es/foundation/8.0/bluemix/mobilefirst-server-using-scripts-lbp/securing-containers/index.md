---
layout: tutorial
title: Protección de MobileFirst
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Los siguientes son varios métodos que puede seguir para proteger su instancia de {{ site.data.keys.mf_server }}.

#### Ir a
{: #jump-to }
* [Configuración de ATS (App Transport Security)](#configuring-app-transport-security-ats)
* [Configuración de LDAP para contenedores](#ldap-configuration-for-containers)

## Configuración de ATS (App Transport Security)
{: #configuring-app-transport-security-ats }
La configuración de ATS no afecta a las aplicaciones que se conectan desde otros sistemas operativos móviles, no de iOS. Otros sistemas operativos móviles no obligan a los servidores a comunicarse en el nivel de seguridad de ATS pero pueden continuar comunicándose con servidores configurados para ATS. Antes de configurar el servidor, tenga preparados los certificados generados. Los pasos siguientes presuponen que el archivo de almacén de claves **ssl_cert.p12** tiene el certificado personal y que **ca.crt** es el certificado de firma.

1. Copie el archivo **ssl_cert.p12** en la carpeta **mfpf-server-libertyapp/usr/security/**.
2. Modifique el archivo **mfpf-server-libertyapp/usr/config/keystore.xml** y el archivo **appcenter/usr/config/keystore.xml** (para appcenter) de un modo similar a la siguiente configuración de ejemplo:

   ```xml
   <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
   </server>
   ```
    - **ssl-1.0** se añade como una característica al gestor de características para permitir que el servidor trabaje con la comunicación SSL.
    - **sslProtocol="TLSv1.2"** se añade en la etiqueta ssl para indicar que el servidor solo se comunica en el protocolo TLS (Transport Layer Security) versión 1.2. Se puede añadir más de un protocolo. Por ejemplo, si se añade **sslProtocol="TLSv1+TLSv1.1+TLSv1.2"**, se asegura de que el servidor se pueda comunicar en TLS V1, V1.1 y V1.2. (Se requiere TLS V1.2 para las aplicaciones iOS 9).
    - **enabledCiphers="TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384"** se añade a la etiqueta ssl para que el servidor fuerce que la comunicación solo utilice dicho cifrado.
    - La etiqueta **keyStore** indica al servidor que utilice los nuevos certificados creados según los requisitos anteriores.

Los siguientes cifrados específicos requieren los valores de políticas JCE (Java Cryptography Extension) y una opción JVM adicional:

* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256_GCM\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384

Los archivos de políticas ya están instalados en el tiempo de ejecución de Liberty for Java y no es necesario que los vuelva a añadir al paquete. Simplemente añada la siguiente opción JVM al archivo **mfpf-server-libertyapp/usr/env/jvm.options**: `Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`.

Solo para fines de desarrollo, puede inhabilitar ATS añadiendo la siguiente propiedad al archivo info.plist:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

## Configuración de la seguridad para {{ site.data.keys.product_full }}
{: #security-configuration-for-ibm-mobilefirst-foundation }
Su configuración de seguridad de la instancia de IBM MobileFirst Foundation debe incluir el cifrado de contraseñas, la habilitación de la comprobación de autenticidad de aplicaciones y la protección del acceso a las consolas.

### Cifrado de contraseñas 
{: #encrypting-passwords }
Almacene las contraseñas de los usuarios de {{ site.data.keys.mf_server }} con un formato cifrado. Puede utilizar el mandato securityUtility, disponible en el perfil de Liberty, para codificar las contraseñas con el cifrado XOR o AES. A continuación, se pueden copiar las contraseñas cifradas en el archivo /usr/env/server.env. Para obtener las instrucciones, consulte la sección Cifrado de contraseñas para roles de usuarios configurados en {{ site.data.keys.mf_server }}.

### Validación de la autenticidad de aplicaciones 
{: #application-authenticity-validation }
Para que las aplicaciones móviles no autorizadas no puedan acceder a {{ site.data.keys.mf_server }}, [habilite la comprobación de seguridad de autenticidad de aplicaciones](../../../authentication-and-security/application-authenticity).


### Protección de una conexión con el sistema de fondo 
{: #securing-a-connection-to-the-back-end }
Si necesita una conexión segura entre su contenedor y un sistema de fondo local, puede utilizar el servicio Bluemix Secure Gateway. Puede encontrar los detalles de la configuración en este artículo: Conexión segura con sistemas de fondo locales desde contenedores MobileFirst on IBM Bluemix.

#### Cifrado de contraseñas para roles de usuarios configurados en {{ site.data.keys.mf_server }}
{: #encrypting-passwords-for-user-roles-configured-in-mobilefirst-server }
Las contraseñas de los roles de usuarios configurados para {{ site.data.keys.mf_server }} se pueden cifrar.  
Las contraseñas se configuran en los archivos **server.env** en **package_root/mfpf-server-liberty-app/usr/env**. Las contraseñas se deben almacenar en formato cifrado.

1. Puede utilizar el mandato `securityUtility` en el perfil de Liberty para codificar la contraseña. Seleccione el cifrado XOR o AES para codificar la contraseña.
2. Copie la contraseña cifrada en el archivo **server.env**. Ejemplo: `MFPF_ADMIN_PASSWORD={xor}PjsyNjE=`
3. Si utiliza el cifrado AES y ha utilizado su propia clave de cifrado, en lugar de la clave predeterminada, debe crear un archivo de configuración que contenga su clave de cifrado y añadirlo al directorio **usr/config**. El servidor Liberty accede al archivo para descifrar la contraseña durante la ejecución. El archivo de configuración debe tener la extensión de archivo .xml y su formato debe ser similar al siguiente:

```bash
<?xml version="1.0" encoding="UTF-8"?>
<server>
    <variable name="wlp.password.encryption.key" value="yourKey" />
</server>
```

#### Restricción del acceso a las consolas que se ejecutan en contenedores
{: #restricting-access-to-the-consoles-running-on-containers }
Puede restringir el acceso a MobileFirst Operations Console y a MobileFirst Analytics Console en entornos de producción creando y desplegando un TAI (Trust Association Interceptor) para interceptar las solicitudes dirigidas a las consolas.

El TAI puede implementar una lógica de filtrado específica del usuario que decide si se reenvía una solicitud a la consola o si se requiere una aprobación. Este método de filtrado le proporciona flexibilidad para añadir su propio mecanismo de autenticación, si es necesario.

Consulte también: [Desarrollo de un TAI personalizado para el perfil de Liberty](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dev_custom_tai.html?view=embed)

1. Cree un TAI personalizado que implemente su mecanismo de seguridad para controlar el acceso a MobileFirst Operations Console. El siguiente ejemplo de un TAI personalizado utiliza la dirección IP de la solicitud de entrada para validar si se proporciona o no acceso a MobileFirst Operations Console.

   ```java
   package com.ibm.mfpconsole.interceptor;
   import java.util.Properties;

   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;

   import com.ibm.websphere.security.WebTrustAssociationException;
   import com.ibm.websphere.security.WebTrustAssociationFailedException;
   import com.ibm.wsspi.security.tai.TAIResult;
   import com.ibm.wsspi.security.tai.TrustAssociationInterceptor;

   public class MFPConsoleTAI implements TrustAssociationInterceptor {

       String allowedIP =null;

       public MFPConsoleTAI() {
          super();
       }

   /*
    * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#isTargetInterceptor
    * (javax.servlet.http.HttpServletRequest)
    */
    public boolean isTargetInterceptor(HttpServletRequest req)
                  throws WebTrustAssociationException {
      //Add logic to determine whether to intercept this request

	   boolean interceptMFPConsoleRequest = false;
	   String requestURI = req.getRequestURI();

	   if(requestURI.contains("mfpconsole")) {
		   interceptMFPConsoleRequest = true;
	   }

	   return interceptMFPConsoleRequest;
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#negotiateValidateandEstablishTrust
     * (javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
     */

    public TAIResult negotiateValidateandEstablishTrust(HttpServletRequest request,
                    HttpServletResponse resp) throws WebTrustAssociationFailedException {
        // Add logic to authenticate a request and return a TAI result.
        String tai_user = "MFPConsoleCheck";

        if(allowedIP != null) {

        	String ipAddress = request.getHeader("X-FORWARDED-FOR");
        	if (ipAddress == null) {
        	  ipAddress = request.getRemoteAddr();
        	}

        	if(checkIPMatch(ipAddress, allowedIP)) {
        		TAIResult.create(HttpServletResponse.SC_OK, tai_user);
        	}
        	else {
        		TAIResult.create(HttpServletResponse.SC_FORBIDDEN, tai_user);
        	}

        }
        return TAIResult.create(HttpServletResponse.SC_OK, tai_user);
    }

    private static boolean checkIPMatch(String ipAddress, String pattern) {
	   if (pattern.equals("*.*.*.*") || pattern.equals("*"))
		      return true;

	   String[] mask = pattern.split("\\.");
	   String[] ip_address = ipAddress.split("\\.");

	   for (int i = 0; i < mask.length; i++)
	   {
		   if (mask[i].equals("*") || mask[i].equals(ip_address[i]))
		      continue;
		   else
		      return false;
		}
		return true;
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#initialize(java.util.Properties)
     */

    public int initialize(Properties properties)
                    throws WebTrustAssociationFailedException {

    	if(properties != null) {
    		if(properties.containsKey("allowedIPs")) {
    			allowedIP = properties.getProperty("allowedIPs");
    		}
    	}
        return 0;
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getVersion()
     */

    public String getVersion() {
        return "1.0";
    }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#getType()
     */
        public String getType() {
            return this.getClass().getName();
        }

    /*
     * @see com.ibm.wsspi.security.tai.TrustAssociationInterceptor#cleanup()
     */

    public void cleanup()
        {}
   }
   ```

2. Exporte la implementación de TAI personalizada en un archivo .jar y colóquela en la carpeta **env** aplicable (**mfpf-server-libertyapp/usr/env**).
3. Cree un archivo XML de configuración que contenga los detalles del interceptor TAI (consulte el código de configuración de TAI de ejemplo que se ha proporcionado en el paso 1) y, a continuación, añada su archivo .xml a la carpeta aplicable (**mfpf-server-libertyapp/usr/config**). Su archivo .xml deberá ser similar al ejemplo siguiente. **Sugerencia:** Asegúrese de que actualiza el nombre de clase y las propiedades de modo que reflejen su implementación.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
        <server description="new server">
        <featureManager>
            <feature>appSecurity-2.0</feature>
        </featureManager>

        <trustAssociation id="MFPConsoleTAI" invokeForUnprotectedURI="true"
                          failOverToAppAuthType="false">
            <interceptors id="MFPConsoleTAI" enabled="true"
                          className="com.ibm.mfpconsole.interceptor.MFPConsoleTAI"
                          invokeBeforeSSO="true" invokeAfterSSO="false" libraryRef="MFPConsoleTAI">
                <properties allowedIPs="9.182.149.*"/>
            </interceptors>
        </trustAssociation>

        <library id="MFPConsoleTAI">
            <fileset dir="${server.config.dir}" includes="MFPConsoleTAI.jar"/>
        </library>
   </server>
   ```

4. Vuelva a desplegar el servidor. Ahora MobileFirst Operations Console solo estará accesible cuando se cumpla con el mecanismo de seguridad TAI configurado.

## Configuración de LDAP para contenedores
{: #ldap-configuration-for-containers }
Puede configurar IBM MobileFirst Foundation para que se conecte de forma segura con un repositorio LDAP.

Se puede utilizar el registro LDAP externo para los fines siguientes:

* Para configurar la seguridad de administración de MobileFirst con un registro LDAP externo.
* Para configurar aplicaciones móviles de MobileFirst de modo que funcionen con un registro LDAP externo.

### Configuración de la seguridad de administración con LDAP
{: #configuring-administration-security-with-ldap }
Configure la seguridad de administración de MobileFirst con un registro LDAP externo.  
El proceso de configuración incluye los pasos siguientes:

* Configurar un repositorio LDAP
* Realizar cambios en el archivo de registro (registry.xml)
* Configurar una pasarela segura para conectar un repositorio LDAP local y el contenedor. (Para realizar este paso necesita una aplicación existente en Bluemix).

#### Repositorio LDAP
{: #ldap-repository }
Cree usuarios y grupos en el repositorio LDAP. En el caso de los grupos, la autorización se aplica en función de si los usuarios son miembros del grupo.

#### Archivo de registro 
{: #registry-file }
1. Abra el archivo **registry.xml** y busque el elemento `basicRegistry`. Sustituya el elemento `basicRegistry` por código que sea similar al siguiente fragmento de código:

   ```xml
   <ldapRegistry
        id="ldap"
        host="1.234.567.8910" port="1234" ignoreCase="true"
        baseDN="dc=worklight,dc=com"
        ldapType="Custom"
        sslEnabled="false"
        bindDN="uid=admin,ou=system"
        bindPassword="secret">
        <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
        groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
        userIdMap="*:uid"
        groupIdMap="*:cn"
        groupMemberIdMap="groupOfNames:member"/>
   </ldapRegistry>
   ```

    Entrada | Descripción
    --- | ---
    `host` y `port` | Nombre de host (dirección IP) y número de puerto de su servidor LDAP local.
    `baseDN` | El nombre de dominio (DN) en LDAP que captura todos los detalles acerca de una organización específica.
    `bindDN="uid=admin,ou=system"	` | Detalles de enlace del servidor LDAP. Por ejemplo, los valores predeterminados para Apache Directory Service pueden ser `uid=admin,ou=system`.
    `bindPassword="secret"	` | Contraseña de enlace para el servidor LDAP. Por ejemplo, el valor predeterminado para Apache Directory Service es `secret`.
    `<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="groupOfNames:member"/>	` | Los filtros predeterminados que se utilizan para consultar el servicio de directorio, tal como Apache, durante la autenticación y la autorización.

2. Asegúrese de que las siguientes características estén habilitadas para `appSecurity-2.0` y `ldapRegistry-3.0`:

   ```xml
   <featureManager>
        <feature>appSecurity-2.0</feature>
        <feature>ldapRegistry-3.0</feature>
   </featureManager>
   ```

   Para obtener información detallada acerca de cómo configurar diferentes repositorios de servidor LDAP, consulte [WebSphere Application Server Liberty Knowledge Center](http://www-01.ibm.com/support/knowledgecenter/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ldap.html).

#### Pasarela segura 
{: #secure-gateway }
Para configurar una conexión de pasarela segura con su servidor LDAP, debe crear una instancia del servicio Secure Gateway en Bluemix y, a continuación, obtener la información de IP para el registro. Para realizar esta tarea necesita el nombre de host LDAP y el número de puerto.

1. Inicie sesión en Bluemix y vaya a **Catálogo, Categoría > Integración** y, a continuación, pulse **Secure Gateway**.
2. En Añadir servicio, seleccione una aplicación y pulse **Crear**. Ahora el servicio está enlazado a su aplicación.
3. Vaya al panel de control de Bluemix para la aplicación, pulse la instancia de servicio de **Secure Gateway** y, a continuación, pulse **Añadir pasarela**.
4. Asigne un nombre a la pasarela, pulse **Añadir destinos** y añada el nombre, la dirección IP y el puerto de su servidor LDAP local.
5. Siga las indicaciones para completar la conexión. Para ver el destino inicializado, vaya a la pantalla Destino del servicio de pasarela LDAP.
6. Para obtener información sobre el host y el puerto que necesita, pulse el icono Información en la instancia de servicio de la pasarela LDAP (situado en el panel de control de Secure Gateway). Los detalles que se muestran son un alias de su servidor LDAP local.
7. Capture los valores de **ID de destino** y de **Host de nube: Puerto**. Vaya al archivo registry.xml y añada estos valores, sustituyendo cualquier valor existente. Consulte el ejemplo siguiente de un fragmento de código actualizado en el archivo registry.xml:

```xml
<ldapRegistry
    id="ldap"
    host="cap-sg-prd-5.integration.ibmcloud.com" port="15163" ignoreCase="true"
    baseDN="dc=worklight,dc=com"
    ldapType="Custom"
    sslEnabled="false"
    bindDN="uid=admin,ou=system"
    bindPassword="secret">
    <customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))"
    groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))"
    userIdMap="*:uid"
    groupIdMap="*:cn"
    groupMemberIdMap="groupOfNames:member"/>
</ldapRegistry>
```

### Configuración de aplicaciones para que funcionen con LDAP
{: #configuring-apps-to-work-with-ldap }
Configure las aplicaciones móviles MobileFirst para que funcionen con un registro LDAP externo.  
El proceso de configuración incluye el paso siguiente: Configurar una pasarela segura para la conexión con un repositorio LDAP local y el contenedor. (Para realizar este paso necesita una aplicación existente en Bluemix).

Para configurar una conexión de pasarela segura con su servidor LDAP, debe crear una instancia del servicio Secure Gateway en Bluemix y, a continuación, obtener la información de IP para el registro. Para realizar este paso necesita el nombre de host LDAP y el número de puerto.

1. Inicie sesión en Bluemix y vaya a **Catálogo, Categoría > Integración** y, a continuación, pulse **Secure Gateway**.
2. En Añadir servicio, seleccione una aplicación y pulse **Crear**. Ahora el servicio está enlazado a su aplicación.
3. Vaya al panel de control de Bluemix para la aplicación, pulse la instancia de servicio de **Secure Gateway** y, a continuación, pulse **Añadir pasarela**.
4. Asigne un nombre a la pasarela, pulse **Añadir destinos** y añada el nombre, la dirección IP y el puerto de su servidor LDAP local.
5. Siga las indicaciones para completar la conexión. Para ver el destino inicializado, vaya a la pantalla Destino del servicio de pasarela LDAP.
6. Para obtener información sobre el host y el puerto que necesita, pulse el icono Información en la instancia de servicio de la pasarela LDAP (situado en el panel de control de Secure Gateway). Los detalles que se muestran son un alias de su servidor LDAP local.
7. Capture los valores de **ID de destino** y de **Host de nube: Puerto**. Proporcione estos valores para el módulo de inicio de sesión de LDAP.

**Resultados**  
Se ha establecido la comunicación entre la aplicación MobileFirst en Bluemix con su servidor LDAP local. Se ha validado la autenticación y la autenticación de la aplicación Bluemix en su servidor LDAP local.
