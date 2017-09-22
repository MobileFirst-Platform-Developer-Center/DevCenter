---
layout: tutorial
title: MobileFirst Server schützen
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Nachfolgend sind mehrere mögliche Methoden für den Schutz Ihrer MobileFirst-Server-Instanz aufgeführt. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [App Transport Security (ATS) konfigurieren](#configuring-app-transport-security-ats)
* [LDAP-Konfiguration für Container](#ldap-configuration-for-containers)

## App Transport Security (ATS) konfigurieren
{: #configuring-app-transport-security-ats }
Die ATS-Konfiguration hat keinen Einfluss auf Anwendungen, die von anderen Betriebssystemen für mobile Geräte als iOS eine Verbindung herstellen. Andere Betriebssysteme für mobile Geräte erfordern nicht, dass Server auf ATS-Sicherheitsniveau kommunizieren, ermöglichen jedoch eine Kommunikation
mit Servern mit ATS-Konfiguration. Halten Sie die generierten Zertifikate bereit, wenn Sie Ihr Container-Image konfigurieren. Bei den folgenden Schritten wird davon ausgegangen, dass die Keystore-Datei **ssl_cert.p12** das persönliche Zertifikat enthält und dass **ca.crt** das Signaturzertifikat ist. 

1. Kopieren Se die Datei **ssl_cert.p12** in den Ordner **mfpf-server-libertyapp/usr/security/**. 
2. Modifizieren Sie die Datei **mfpf-server-libertyapp/usr/config/keystore.xml** und die Datei **appcenter/usr/config/keystore.xml** (für das Application Center). Orientieren Sie sich dabei an der folgenden Beispielkonfiguration: 

   ```xml
   <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
   </server>
   ```
    - **ssl-1.0** wird als ein Feature im Feature-Manager hinzugefügt, damit der Server die SSL-Kommunikation
verwenden kann. 
    - **sslProtocol="TLSv1.2"** wird zum Tag ssl hinzugefügt, um durchzusetzen, dass der Server nur über das Protokoll TLS Version 1.2 (Transport Layer Security) kommuniziert. Sie können mehr als ein Protokoll hinzufügen.
Wenn Sie beispielsweise **sslProtocol="TLSv1+TLSv1.1+TLSv1.2"** hinzufügen, ist sichergestellt, dass der Server über TLS Version 1, Version 1.1 und Version 1.2 kommunizieren kann.
(Für iOS-9-Apps ist TLS Version 1.2 erforderlich.) 
    - **enabledCiphers="TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384"** wird zum Tag ssl hinzugefügt, damit der Server die Kommunikation ausschließlich unter Verwendung dieses Chiffrierwertes zulässt. 
    - Der **keyStore** teilt dem Server mit, dass er die neuen Zertifikate verwenden soll, die gemäß den obigen Anforderungen erstellt wurden. 

Für die folgenden Chiffrierwerte sind JCE-Richtlinieneinstellungen (Java Cryptography Extension) und eine zusätzliche JVM-Option erforderlich: 

* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256_GCM\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384

Die Richtliniendateien sind bereits in der Liberty-for-Java-Laufzeit installiert. Sie müssen Sie daher nicht erneut zum Paket hinzufügen. Fügen Sie nur die folgende JVM-Option zur Datei **mfpf-server-libertyapp/usr/env/jvm.options** hinzu: `Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`.

Während der Entwicklungsphase können Sie ATS inaktivieren, indem Sie die folgende Eigenschaft zur Datei info.plist hinzufügen: 

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

## Sicherheitskonfiguration für die {{ site.data.keys.product_full }}
{: #security-configuration-for-ibm-mobilefirst-foundation }
Ihre Sicherheitskonfiguration für die IBM MobileFirst-Foundation-Instanz sollte verschlüsselte Kennwörter, die aktivierte Prüfung der Anwendungsauthentizität und einen sicheren Zugriff auf die Konsolen umfassen. 

### Kennwörter verschlüsseln
{: #encrypting-passwords }
Speichern Sie die Kennwörter für Benutzer von {{ site.data.keys.mf_server }} in einem verschlüsselten Format. Sie können den Befehl securityUtility von Liberty Profile verwenden, um Kennwörter mit der XOR- oder der AES-Verschlüsselung zu verschlüsseln. Verschlüsselte Kennwörter können dann in die Datei /usr/env/server.env kopiert werden.
                Lesen Sie hierzu die Informationen unter "Kennwörter für in {{ site.data.keys.mf_server }} konfigurierte Benutzerrollen verschlüsseln". 

### Validierung der Anwendungsauthentizität
{: #application-authenticity-validation }
[Aktivieren Sie die Sicherheitsüberprüfung der Anwendungsauthentizität](../../../authentication-and-security/application-authenticity), um
nicht autorisierte Anwendungen am Zugriff
auf
{{ site.data.keys.mf_server }} zu hindern. 


### Verbindung zum Back-End schützen
{: #securing-a-connection-to-the-back-end }
Wenn Sie eine sichere Verbindung zwischen Ihrem Container und einem Back-End-System vor Ort benötigen, können Sie den Service Bluemix Secure Gateway verwenden. Die Konfigurationsdetails sind im folgenden Artikel
angegeben: Connecting securely from IBM MobileFirst Platform Foundation on Bluemix to on-premises systems. 

#### Kennwörter für in {{ site.data.keys.mf_server }} konfigurierte Benutzerrollen verschlüsseln
{: #encrypting-passwords-for-user-roles-configured-in-mobilefirst-server }
Die Kennwörter für Benutzerrollen, die für {{ site.data.keys.mf_server }} konfiguriert sind, können verschlüsselt werden.   
Kennwörter werden in der Datei **server.env** unter **Paketstammverzeichnis/mfpf-server-liberty-app/usr/env** konfiguriert. Sie sollten Kennwörter in einem verschlüsselten Format
speichern. 

1. Zum Verschlüsseln des Kennworts können Sie den Befehl `securityUtility` von Liberty Profile verwenden. Wählen Sie für die Verschlüsselung des Kennworts die XOR- oder AES-Verschlüsselung aus. 
2. Kopieren Sie das verschlüsselte Kennwort in die Datei **server.env**. Beispiel: `MFPF_ADMIN_PASSWORD={xor}PjsyNjE=`
3. Wenn Sie die AES-Verschlüsselung und anstelle des Standardschlüssels einen eigenen Chiffrierschlüssel verwenden, müssen Sie eine Konfigurationsdatei erstellen, die Ihren Chiffrierschlüssel enthält, und diese Datei zum Verzeichnis **usr/config** hinzufügen. Der Liberty-Server greift auf die Datei zu, um das Kennwort in der Laufzeit zu entschlüsseln. Die Konfigurationsdatei muss die Dateierweiterung .xml und folgendes Format haben:


```bash
<?xml version="1.0" encoding="UTF-8"?>
<server>
    <variable name="wlp.password.encryption.key" value="yourKey" />
</server>
```

#### Zugriff auf die in Containern ausgeführten Konsolen einschränken
{: #restricting-access-to-the-consoles-running-on-containers }
In Produktionsumgebungen können Sie den Zugriff auf die MobileFirst Operations Console und die MobileFirst Analytics Console einschränken, indem Sie einen TAI (Trust Association Interceptor) erstellen und implementieren. Dieser TAI fängt Anforderungen an die Konsolen ab. 

Der TAI kann benutzerspezifische Filterlogik implementieren, die entscheidet, ob eine Anforderung an die Konsole weitergeleitet wird oder eine Genehmigung erforderlich ist. Diese Filtermethode ist flexibel, sodass Sie ggf. Ihren eigenen Authentifizierungsmechanismus hinzufügen können. 

Lesen Sie hierzu auch den Artikel [Angepassten TAI für das Liberty-Profil entwickeln](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dev_custom_tai.html?view=embed). 

1. Erstellen Sie einen angepassten TAI, der Ihren Sicherheitsmechanismus für die Steuerung des Zugriffs auf die MobileFirst Operations Console implementiert. Der folgende angepasste Beispiel-TAI verwendet die IP-Adresse der eingehenden Anforderung, um festzustellen, ob Zugriff auf die MobileFirst Operations Console gewährt werden soll oder nicht. 

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
      // Logik hinzufügen, die festlegt, ob diese Anforderung abgefangen werden soll

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
        // Logik hinzufügen, um eine Anforderung zu authentifizieren und ein TAI-Ergebnis zurückzugeben
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

2. Exportieren Sie die Implementierung des angepassten TAI in eine JAR-Datei und stellen Sie diese in den betreffenden Ordner **env** (**mfpf-server-libertyapp/usr/env**).
3. Erstellen Sie eine XML-Konfigurationsdatei mit den Details des TAI (siehe Beispielcode für eine TAI-Konfiguration in Schritt 1) und fügen Sie Ihre XML-Datei zum betreffenden Ordner (**mfpf-server-libertyapp/usr/config**) hinzu. Ihre .xml-Datei sollte dem folgenden Beispiel ähneln.
**Tipp:** Vergessen Sie nicht, den Klassennamen und die Eigenschaften an Ihre Implementierung anzupassen. 

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

4. Reimplementieren Sie den Server. Der Zugriff auf die MobileFirst Operations Console ist jetzt nur möglich, wenn die Bedingungen des konfigurierten TAI-Sicherheitsmechanismus erfüllt sind.

## LDAP-Konfiguration für Container
{: #ldap-configuration-for-containers }
Sie können die IBM MobileFirst Foundation so konfigurieren, dass sie eine sichere Verbindung zu einem LDAP-Repository herstellt. 

Die externe LDAP-Registry kann für folgende Zwecke verwendet werden: 

* Um die MobileFirst-Verwaltungssicherheit mit einer externen LDAP-Registry zu konfigurieren
* Um mobile MobileFirst-Anwendungen für eine externe LDAP-Registry zu konfigurieren

### Verwaltungssicherheit mit LDAP konfigurieren
{: #configuring-administration-security-with-ldap }
Konfigurieren Sie die MobileFirst-Verwaltungssicherheit mit einer externen LDAP-Registry.   
Der Konfigurationsprozess umfasst die folgenden Schritte: 

* LDAP-Repository einrichten und konfigurieren
* Registry-Datei (registry.xml) ändern
* Geschütztes Gateway für die Verbindung zu einem lokalen LDAP-Repository und zum Container konfigurieren. (Für diesen Schritt benötigen Sie eine vorhandene App in Bluemix.) 

#### LDAP-Repository
{: #ldap-repository }
Erstellen Sie Benutzer und Gruppen in der LDAP-Repository. Die Autorisierung für Gruppen wird ausgehend von der Zugehörigkeit von Benutzern zu den Gruppen umgesetzt. 

#### Registry-Datei
{: #registry-file }
1. Öffnen Sie die Datei **registry.xml** und suchen Sie das Element `basicRegistry`. Ersetzen Sie das Element `basicRegistry` durch ähnlichen Code wie im folgenden Snippet: 

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

    Eintrag | Beschreibung
    --- | ---
    `host` und `port` | Hostname (IP-Adresse) und Portnummer Ihres lokalen LDAP-Servers
    `baseDN` | Domänenname (DN) in LDAP mit allen Details einer bestimmten Organisation
    `bindDN="uid=admin,ou=system"	` | Bindungsdetails des LDAP-Servers. Für einen Apache Directory Service würden die Standardwerte beispielsweise `uid=admin,ou=system` lauten.
    `bindPassword="secret"` | Bindungskennwort für den LDAP-Server. Der Standardwert für einen Apache Directory Service wäre beispielsweise `secret`.
    `<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="groupOfNames:member"/>	` | Angepasste Filter für das Abfragen des Verzeichnisservice (z. B. Apache) während der Authentifizierung und Autorisierung
2. Stellen Sie sicher, dass die folgenden Features für `appSecurity-2.0` und `ldapRegistry-3.0` aktiviert sind:

   ```xml
   <featureManager>
        <feature>appSecurity-2.0</feature>
        <feature>ldapRegistry-3.0</feature>
   </featureManager>
   ```

   Einzelheiten zum Konfigurieren verschiedener LDAP-Server-Repositorys finden Sie im [Knowledge Center zu WebSphere Application Server Liberty](http://www-01.ibm.com/support/knowledgecenter/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ldap.html).

#### Geschütztes Gateway
{: #secure-gateway }
Wenn Sie eine Verbindung vom geschützten Gateway zu Ihrem LDAP-Server konfigurieren möchten, müssen Sie in Bluemix eine Instanz des Service "Secure Gateway" erstellen und dann die IP-Informationen für die LDAP-Registry anfordern.
Für diese Aufgabe benötigen Sie den Hostnamen und die Portnummer Ihres lokalen LDAP-Servers. 

1. Melden Sie sich bei Bluemix an und wählen Sie **Katalog, Kategorie > Integration** aus. Klicken Sie dann auf **Secure Gateway**.
2. Wählen Sie unter "Service hinzufügen" eine App aus und klicken Sie auf **Erstellen**. Der Service ist jetzt an Ihre App gebunden. 
3. Öffnen Sie das Bluemix-Dashboard für die App und klicken Sie auf die Instanz des Service **Secure Gateway**. Klicken Sie dann auf **Gateway hinzufügen**.
4. Benennen Sie das Gateway und klicken Sie auf **Ziele hinzufügen**. Geben Sie den Namen, die IP-Adresse und den Port Ihres lokalen LDAP-Servers ein. 
5. Folgen Sie der Bedienerführung, um die Verbindung fertigzustellen. Navigieren Sie zur Zielanzeige für den LDAP-Gateway-Service, um zu sehen, wie das Ziel initialisiert wird. 
6. Zum Anfordern der benötigten Host- und Portinformationen können Sie für die Instanz des LDAP-Gateway-Service (im Dashboard für Secure Gateway) auf das Informationssymbol klicken. Angezeigt wird ein Aliasname für Ihren lokalen LDAP-Server. 
7. Notieren Sie die Werte für **Ziel-ID** und **Cloud-Host: Port**. Öffnen Sie die Datei registry.xml und ersetzen Sie die vorhandenen Werte durch die gerade notierten Werte. Das folgende Beispiel zeigt ein aktualisiertes Code-Snippet aus der Datei registry.xml:


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

### Apps für LDAP konfigurieren
{: #configuring-apps-to-work-with-ldap }
Konfigurieren Sie mobile MobileFirst-Apps für die Verwendung mit einer externen LDAP-Registry.   
Zum Konfigurationsprozess gehört der Schritt, ein sicheres Gateway für die Verbindung zu einem lokalen LDAP-Repository und zum Container zu konfigurieren. (Für diesen Schritt benötigen Sie eine vorhandene App in Bluemix.) 

Wenn Sie eine Verbindung vom geschützten Gateway zu Ihrem LDAP-Server konfigurieren möchten, müssen Sie in Bluemix eine Instanz des Service "Secure Gateway" erstellen und dann die IP-Informationen für die LDAP-Registry anfordern.
Für diesen Schritt benötigen Sie den Namen und die Portnummer Ihres lokalen LDAP-Hosts. 

1. Melden Sie sich bei Bluemix an und wählen Sie **Katalog, Kategorie > Integration** aus. Klicken Sie dann auf **Secure Gateway**.
2. Wählen Sie unter "Service hinzufügen" eine App aus und klicken Sie auf **Erstellen**. Der Service ist jetzt an Ihre App gebunden. 
3. Öffnen Sie das Bluemix-Dashboard für die App und klicken Sie auf die Instanz des Service **Secure Gateway**. Klicken Sie dann auf **Gateway hinzufügen**.
4. Benennen Sie das Gateway und klicken Sie auf **Ziele hinzufügen**. Geben Sie den Namen, die IP-Adresse und den Port Ihres lokalen LDAP-Servers ein. 
5. Folgen Sie der Bedienerführung, um die Verbindung fertigzustellen. Navigieren Sie zur Zielanzeige für den LDAP-Gateway-Service, um zu sehen, wie das Ziel initialisiert wird. 
6. Zum Anfordern der benötigten Host- und Portinformationen können Sie für die Instanz des LDAP-Gateway-Service (im Dashboard für Secure Gateway) auf das Informationssymbol klicken. Angezeigt wird ein Aliasname für Ihren lokalen LDAP-Server. 
7. Notieren Sie die Werte für **Ziel-ID** und **Cloud-Host: Port**. Geben Sie diese Werte für das LDAP-Anmeldemodul an. 

**Ergebnisse**  
Die MobileFirst-App in Bluemix kann jetzt mit Ihrem lokalen LDAP-Server kommunizieren. Die Authentifizierung und Autorisierung der Bluemix-App wird anhand Ihres lokalen LDAP-Servers validiert. 
