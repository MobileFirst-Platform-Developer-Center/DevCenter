---
layout: tutorial
title: MobileFirst server 보호
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
아래에 {{ site.data.keys.mf_server }} 인스턴스를 보호하기 위해 수행할 수 있는 몇몇 방법이 있습니다. 

#### 다음으로 이동
{: #jump-to }
* [ATS(App Transport Security) 구성](#configuring-app-transport-security-ats)
* [컨테이너의 LDAP 구성](#ldap-configuration-for-containers)

## ATS(App Transport Security) 구성
{: #configuring-app-transport-security-ats }
ATS 구성은 기타 비iOS 모바일 운영 체제에서 연결 중인 애플리케이션에는 영향을 미치지 않습니다. 기타 모바일 운영 체제에서는 서버가 ATS 레벨의 보안에서 통신하지 않아도 되지만 ATS가 구성된 서버와 계속 통신할 수 있습니다. 서버를 구성하기 전에 생성된 인증서를 준비하십시오. 다음 단계에서는 키 저장소 파일 **ssl_cert.p12**에 개인용 인증서가 있으며 **ca.crt**가 서명 인증서라고 가정합니다. 

1. **ssl_cert.p12** 파일을 **mfpf-server-libertyapp/usr/security/** 폴더에 복사하십시오. 
2. **mfpf-server-libertyapp/usr/config/keystore.xml** 및 **appcenter/usr/config/keystore.xml**(appcenter용) 파일을 다음 예제 구성과 유사하게 수정하십시오. 

   ```xml
   <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
   </server>
   ```
    - 서버가 SSL 통신을 사용하여 작업할 수 있도록 **ssl-1.0**이 기능 관리자에 기능으로 추가되었습니다. 
    - 서버가 TLS(Transport Layer Security) 버전 1.2 프로토콜에서만 통신하도록 **sslProtocol="TLSv1.2"**가 ssl 태그에 추가되었습니다. 둘 이상의 프로토콜을 추가할 수 있습니다. 예를 들어, **sslProtocol="TLSv1+TLSv1.1+TLSv1.2"**를 추가하면 서버가 TLS V1, V1.1, V1.2에서 통신할 수 있습니다. (TLS V1.2는 iOS 9 앱에 필수입니다.)
    - 서버가 해당 암호만 사용하여 통신을 강제 실행하도록 **enabledCiphers="TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384"**가 ssl 태그에 추가되었습니다. 
    - **keyStore** 태그는 위의 요구사항에 따라 작성된 새 인증서를 사용하도록 서버에 알립니다. 

다음과 같은 특정 암호에는 JCE(Java Cryptography Extension) 정책 설정과 추가 JVM 옵션이 필요합니다. 

* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256_GCM\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384

정책 파일은 Liberty for Java 런타임에 이미 설치되어 있으므로 패키지에 다시 추가할 필요가 없습니다. 다음 JVM 옵션만 **mfpf-server-libertyapp/usr/env/jvm.options** 파일에 추가하십시오. `Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`.

개발 단계 용도로만 info.plist 파일에 다음 특성을 추가하여 ATS를 사용 안함으로 설정할 수 있습니다. 

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

## {{ site.data.keys.product_full }}의 보안 구성
{: #security-configuration-for-ibm-mobilefirst-foundation }
IBM MobileFirst Foundation 인스턴스 보안 구성은 비밀번호 암호화, 애플리케이션 인증 검사 사용, 콘솔에 대한 액세스 보호를 포함해야 합니다. 

### 비밀번호 암호화
{: #encrypting-passwords }
{{ site.data.keys.mf_server }} 사용자의 비밀번호를 암호화된 형식으로 저장하십시오. Liberty 프로파일에서 사용 가능한 securityUtility 명령을 사용하여 XOR 또는 AES 암호화로 비밀번호를 인코딩할 수 있습니다. 그런 다음 암호화된 비밀번호를 /usr/env/server.env 파일에 복사할 수 있습니다. 지시사항은 {{ site.data.keys.mf_server }}에 구성된 사용자 역할의 비밀번호 암호화를 참조하십시오. 

### 애플리케이션 인증 유효성 검증
{: #application-authenticity-validation }
권한 없는 모바일 애플리케이션에서 {{ site.data.keys.mf_server }}에 액세스하지 못하도록 [애플리케이션 인증 보안 검사를 사용](../../../authentication-and-security/application-authenticity)하십시오.


### 백엔드에 대한 연결 보안 설정
{: #securing-a-connection-to-the-back-end }
컨테이너와 사내 구축형 백엔드 시스템 간 보안 연결이 필요한 경우 Bluemix Secure Gateway 서비스를 사용할 수 있습니다. 구성 세부사항은 IBM Bluemix Containers의 MobileFirst에서 사내 구축형 백엔드에 안전하게 연결 문서에서 제공됩니다. 

#### {{ site.data.keys.mf_server }}에 구성된 사용자 역할의 비밀번호 암호화
{: #encrypting-passwords-for-user-roles-configured-in-mobilefirst-server }
{{ site.data.keys.mf_server }}에 대해 구성된 사용자 역할의 비밀번호를 암호화할 수 있습니다.   
비밀번호는 **package_root/mfpf-server-liberty-app/usr/env**의 **server.env** 파일에 구성되어 있습니다. 비밀번호를 암호화된 형식으로 저장해야 합니다. 

1. Liberty 프로파일에서 `securityUtility` 명령을 사용하여 비밀번호를 인코딩할 수 있습니다. XOR 또는 AES 암호화를 선택하여 비밀번호를 인코딩하십시오. 
2. 암호화된 비밀번호를 **server.env** 파일에 복사하십시오. 예: `MFPF_ADMIN_PASSWORD={xor}PjsyNjE=`
3. AES 암호화를 사용 중이고 기본 키 대신 사용자 고유 암호화 키를 사용한 경우 암호화 키를 포함하는 구성 파일을 작성하여 **usr/config** 디렉토리에 추가해야 합니다. Liberty 서버가 런타임 중에 파일에 액세스하여 비밀번호를 복호화합니다. 구성 파일의 파일 확장자는 .xml이어야 하고 다음 형식과 유사해야 합니다. 

```bash
<?xml version="1.0" encoding="UTF-8"?>
<server>
    <variable name="wlp.password.encryption.key" value="yourKey" />
</server>
```

#### 컨테이너에서 실행 중인 콘솔에 대한 액세스 제한
{: #restricting-access-to-the-consoles-running-on-containers }
콘솔에 대한 요청을 차단하기 위해 TAI(Trust Association Interceptor)를 작성하고 배치하여 프로덕션 환경에서 MobileFirst Operations Console과 MobileFirst Analytics Console에 대한 액세스를 제한할 수 있습니다. 

TAI는 요청이 콘솔에 전달되는지 또는 승인이 필요한지 결정하는 사용자 특정 필터링 로직을 구현할 수 있습니다. 이 필터링 메소드는 필요한 경우 사용자 고유 인증 메커니즘을 추가하는 유연성을 제공합니다. 

[Liberty 프로파일에 대한 사용자 정의 TAI 개발](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dev_custom_tai.html?view=embed)도 참조하십시오. 

1. 보안 메커니즘을 구현하는 사용자 정의 TAI를 작성하여 MobileFirst Operations Console에 대한 액세스를 제어하십시오. 다음 사용자 정의 TAI 예제에서는 수신 요청의 IP 주소를 사용하여 MobileFirst Operations Console에 대한 액세스 권한을 제공할지 여부의 유효성을 검증합니다. 

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

2. 사용자 정의 TAI 구현을 .jar 파일에 내보내 적용 가능한 **env** 폴더(**mfpf-server-libertyapp/usr/env**)에 배치하십시오. 
3. TAI 인터셉터에 대한 세부사항을 포함하는 XML 구성 파일을 작성한 후(1단계에 제공된 TAI 구성 예제 코드 참조 .xml 파일을 적용 가능한 폴더(**mfpf-server-libertyapp/usr/config**)에 추가하십시오. .xml 파일은 다음 예제와 유사해야 합니다. **팁:** 구현을 반영하도록 클래스 이름과 특성을 업데이트하십시오. 

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

4. 서버를 다시 배치하십시오. 이제 구성된 TAI 보안 메커니즘을 충족하는 경우에만 MobileFirst Operations Console에 액세스할 수 있습니다. 

## 컨테이너의 LDAP 구성
{: #ldap-configuration-for-containers }
외부 LDAP 저장소에 안전하게 연결하도록 IBM MobileFirst Foundation을 구성할 수 있습니다. 

다음과 같은 용도로 외부 LDAP 레지스트리를 사용할 수 있습니다. 

* 외부 LDAP 레지스트리로 MobileFirst 관리 보안을 구성합니다. 
* 외부 LDAP 레지스트리에 대해 작업하도록 MobileFirst 모바일 애플리케이션을 구성합니다. 

### LDAP을 사용하여 관리 보안 구성
{: #configuring-administration-security-with-ldap }
외부 LDAP 레지스트리로 MobileFirst 관리 보안을 구성합니다.   
구성 프로세스에는 다음 단계가 포함됩니다. 

* LDAP 저장소 설정과 구성
* 레지스트리 파일(registry.xml)의 변경
* 로컬 LDAP 저장소와 컨테이너에 연결할 보안 게이트웨이의 구성. (이 단계를 수행하려면 Bluemix에 기존 앱이 있어야 합니다.)

#### LDAP 저장소
{: #ldap-repository }
LDAP 저장소에 사용자와 그룹을 작성하십시오. 그룹의 경우 권한은 사용자 멤버십을 기반으로 적용됩니다. 

#### 레지스트리 파일
{: #registry-file }
1. **registry.xml**을 열고 `basicRegistry` 요소를 찾으십시오. `basicRegistry` 요소를 다음 스니펫과 유사한 코드로 대체하십시오. 

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

        항목| 설명

    --- | ---
    `host` 및 `port` | 로컬 LDAP 서버의 호스트 이름(IP 주소)과 포트 번호입니다.
    
    `baseDN` | 특정 조직에 대한 모든 세부사항을 캡처하는 LDAP의 도메인 이름(DN)입니다.
    
    `bindDN="uid=admin,ou=system"	`| LDAP 서버의 바인딩 세부사항입니다. 예를 들어, Apache Directory Service의 기본값은 `uid=admin,ou=system`입니다.
    
    `bindPassword="secret"	`| LDAP 서버의 바인딩 비밀번호입니다. 예를 들어, Apache Directory Service의 기본값은 `secret`입니다.
    
    `<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v)(objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="groupOfNames:member"/>	` | 인증과 권한 부여 중에 디렉토리 서비스(예: Apache)를 조회하는 데 사용되는 사용자 정의 필터입니다.


2. `appSecurity-2.0`과 `ldapRegistry-3.0`에 다음 기능을 사용할 수 있는지 확인하십시오. 

   ```xml
   <featureManager>
        <feature>appSecurity-2.0</feature>
        <feature>ldapRegistry-3.0</feature>
   </featureManager>
   ```

   여러 LDAP 서버 저장소 구성에 대한 세부사항은 [WebSphere Application Server Liberty Knowledge Center](http://www-01.ibm.com/support/knowledgecenter/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ldap.html)를 참조하십시오. 

#### 보안 게이트웨이
{: #secure-gateway }
LDAP 서버에 대한 보안 게이트웨이 연결을 구성하려면 Bluemix에 Secure Gateway 서비스의 인스턴스를 작성한 후 LDAP 레지스트리의 IP 정보를 얻어야 합니다. 이 태스크를 수행하려면 로컬 LDAP 호스트 이름과 포트 번호가 필요합니다. 

1. Bluemix에 로그온하고 **카탈로그, 카테고리 > 통합**으로 이동한 후 **Secure Gateway**를 클릭하십시오. 
2. 서비스 추가에서 앱을 선택한 후 **작성**을 클릭하십시오. 이제 서비스가 사용자 앱에 바인드됩니다. 
3. 앱의 Bluemix 대시보드로 이동하여 **Secure Gateway** 서비스 인스턴스를 클릭한 후 **게이트웨이 추가**를 클릭하십시오. 
4. 게이트웨이의 이름을 지정하고 **대상 추가**를 클릭한 후 로컬 LDAP 서버의 이름, IP 주소, 포트를 입력하십시오. 
5. 프롬프트에 따라 연결을 완료하십시오. 초기화된 대상을 확인하려면 LDAP 게이트웨이 서비스의 대상 화면으로 이동하십시오. 
6. 필요한 호스트 정보와 포트 정보를 얻으려면 LDAP 게이트웨이 서비스 인스턴스의 정보 아이콘을 클릭하십시오(Secure Gateway 대시보드에 있음). 표시되는 세부사항은 로컬 LDAP 서버의 별명입니다. 
7. **대상 ID** 값과 **클라우드 호스트:포트** 값을 캡처하십시오. registry.xml 파일로 이동해서 해당 값을 추가하여 기존 값을 대체하십시오. registry.xml 파일에 있는 업데이트된 코드 스니펫의 다음 예를 참조하십시오. 

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

### LDAP에 대해 작업하도록 앱 구성
{: #configuring-apps-to-work-with-ldap }
외부 LDAP 레지스트리에 대해 작업하도록 MobileFirst 모바일 앱을 구성합니다.   
구성 프로세스는 로컬 LDAP 저장소와 컨테이너에 연결할 보안 게이트웨이 구성 단계를 포함합니다. (이 단계를 수행하려면 Bluemix에 기존 앱이 있어야 합니다.)

LDAP 서버에 대한 보안 게이트웨이 연결을 구성하려면 Bluemix에 Secure Gateway 서비스의 인스턴스를 작성한 후 LDAP 레지스트리의 IP 정보를 얻어야 합니다. 이 단계를 수행하려면 로컬 LDAP 호스트 이름과 포트 번호가 필요합니다. 

1. Bluemix에 로그온하고 **카탈로그, 카테고리 > 통합**으로 이동한 후 **Secure Gateway**를 클릭하십시오. 
2. 서비스 추가에서 앱을 선택한 후 **작성**을 클릭하십시오. 이제 서비스가 사용자 앱에 바인드됩니다. 
3. 앱의 Bluemix 대시보드로 이동하여 **Secure Gateway** 서비스 인스턴스를 클릭한 후 **게이트웨이 추가**를 클릭하십시오. 
4. 게이트웨이의 이름을 지정하고 **대상 추가**를 클릭한 후 로컬 LDAP 서버의 이름, IP 주소, 포트를 입력하십시오. 
5. 프롬프트에 따라 연결을 완료하십시오. 초기화된 대상을 확인하려면 LDAP 게이트웨이 서비스의 대상 화면으로 이동하십시오. 
6. 필요한 호스트 정보와 포트 정보를 얻으려면 LDAP 게이트웨이 서비스 인스턴스의 정보 아이콘을 클릭하십시오(Secure Gateway 대시보드에 있음). 표시되는 세부사항은 로컬 LDAP 서버의 별명입니다. 
7. **대상 ID** 값과 **클라우드 호스트:포트** 값을 캡처하십시오. LDAP 로그인 모듈에 해당 값을 제공하십시오. 

**결과**  
로컬 LDAP 서버와 Bluemix의 MobileFirst 앱 간 통신이 설정됩니다. 로컬 LDAP 서버에 대해 Bluemix 앱의 인증과 권한 부여의 유효성을 검증합니다. 
