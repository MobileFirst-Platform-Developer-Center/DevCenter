---
layout: tutorial
title: MobileFirst 서버 키 저장소 구성
breadcrumb_title: 서버 키 저장소 구성
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
키 저장소는 네트워크 트랜잭션에 관련된 당사자를 확인하고 유효성을 인증하는 데 사용되는 보안 키 및 인증서의 저장소입니다. {{ site.data.keys.mf_server }} 키 저장소는 {{ site.data.keys.mf_server }} 인스턴스의 ID를 정의하며 OAuth 토큰과 직접 업데이트 패키지에 디지털 방식으로 서명하는 데 사용됩니다. 또한 어댑터가 상호 HTTPS(SSL) 인증을 사용하여 백엔드 서버와 통신할 때 키 저장소는 {{ site.data.keys.mf_server }} 인스턴스의 SSL 클라이언트 ID를 확인하는 데 사용됩니다. 

프로덕션 레벨 보안을 위해 개발 환경에서 프로덕션 환경으로 전환하는 동안 관리자는 사용자 정의 키 저장소를 사용하도록
{{ site.data.keys.mf_server }}를 구성해야 합니다. 기본 {{ site.data.keys.mf_server }} 키 저장소는 개발 중에만 사용됩니다. 

### 참고
{: #notes }
* 키 저장소를 사용하여 직접 업데이트 패키지의 신뢰성을 확인하려면
키 저장소에 정의된 {{ site.data.keys.mf_server }} ID의 공용 키와 애플리케이션을
정적으로 바인드하십시오. [클라이언트 측에서보안 직접 업데이트 구현](../../application-development/direct-update)을 참조하십시오. 
* 프로덕션 이후 {{ site.data.keys.mf_server }} 키 저장소를 다시 구성하는 것은 신중하게 고려해야 합니다. 구성을 변경하면
다음과 같은 영향이 나타날 수 있습니다.
    * 클라이언트가 이전 키 저장소로 서명된 토큰 대신 새 OAuth 토큰을
확보해야 할 수 있습니다. 대부분의 경우 이 프로세스는 애플리케이션에
투명하게 진행됩니다. 
    * 클라이언트 애플리케이션이 새 키 저장소 구성의 {{ site.data.keys.mf_server }} ID와
일치하지 않는 공용 키에 바인드되어 있는 경우, 직접 업데이트가 실패합니다. 계속 업데이트를 가져오려면
애플리케이션을 새 공용 키와 바인드하고 해당 애플리케이션을
다시 공개하십시오. 또는, 애플리케이션이 바인드된 공용 키와 일치하도록 키 저장소 구성을
다시 변경하십시오. [클라이언트 측에서보안 직접 업데이트 구현](../../application-development/direct-update)을 참조하십시오. 
    *  상호 SSL 인증의 경우, 어댑터에 구성된 SSL 클라이언트 ID 별명과 비밀번호가
새 키 저장소에서 발견되지 않거나 SSL 인증과 일치하지 않으면 SSL 인증이
실패합니다. 다음 프로시저 중 2단계에서 어댑터 구성 정보를 참조하십시오. 

## 설정
{: #setup }
1. {{ site.data.keys.mf_server }}의 ID를 정의하는 키 쌍을 포함하는 별명으로 JKS(Java keystore) 또는 PKCS 12 키 저장소를 작성하십시오. 적절한 키 저장소 파일이 이미 있으면
다음 단계로 건너뛰십시오.

   > **참고:** 별명 키쌍 알고리즘의 유형은 RSA이어야 합니다. 다음 지시사항은 **keytool** 유틸리티를 사용할 때 알고리즘 유형을 RSA로 설정하는 방법을 설명합니다. 

   써드파티 도구를 사용하여 키 저장소 파일을 작성할 수 있습니다. 예를 들어, 다음 명령으로 Java **keytool** 유틸리티를 실행하여 JKS 키 저장소 파일을 생성할 수 있습니다. 여기서 `<keystore name>`은 키 저장소의 이름이고, `<alias name>`은 사용자가 선택한 별명입니다. 
```bash
   keytool -keystore <keystore name> -genkey -alias <alias name> -keylag RSA
   ```

   다음
샘플 명령은 `my_alias` 별명을 사용하여 **my_company.keystore**
JKS 파일을 생성합니다.


   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   유틸리티에 키 저장소 파일의 비밀번호와 별명을 포함하여 다양한 입력 매개변수를 지정하라는 메시지가 표시됩니다. 

   > **참고:** 기본 DSA 대신에 생성된 키 알고리즘의 유형을 RSA로 설정하려면 `-keyalg RSA` 옵션을 설정해야 합니다.



   어댑터와 백엔드 서버 사이에 상호 SSL 인증을 위한 키 저장소를 사용하려면 {{ site.data.keys.product }} SSL-클라이언트 ID 별명을 키 저장소에 추가하십시오. {{ site.data.keys.mf_server }} ID 별명으로 키 저장소 파일을 작성할 때 사용한 방법과 동일한 방법으로 이 작업을 수행할 수 있지만, 대신 SSL 클라이언트 ID를 위한 비밀번호와 별명을 제공하십시오. 

2. 키 저장소를 사용하도록 {{ site.data.keys.mf_server }} 구성:
   키 저장소를 사용하도록 {{ site.data.keys.mf_server }}를 구성하려면 아래의 단계를 수행하십시오. 

      * **Javascript 어댑터**
        {{ site.data.keys.mf_console }} 탐색 사이드바에서 **런타임 설정**을 선택한 후 **키 저장소** 탭을 선택하십시오. 사용자 정의 {{ site.data.keys.mf_server }} 키 저장소를 구성하려면 이 탭에 나와 있는 지시사항을 따르십시오. 단계에는 키 저장소 파일을 업로드하고 해당 유형을 표시하고 키 저장소 비밀번호, {{ site.data.keys.mf_server }} ID 별명의 이름 및 별명 비밀번호를 제공하는 작업이 포함됩니다.
        성공적으로 구성되면 **상태**가 *사용자 정의*로 변경됩니다. 그렇지 않으면 오류가 표시되고 상태가 *기본값*으로 유지됩니다.
        SSL 클라이언트 ID 별명(사용된 경우) 및 해당 비밀번호는 `<connectionPolicy>` 요소의 `<sslCertificateAlias>` 및 `<sslCertificatePassword>` 하위 요소 내 관련 어댑터의 디스크립터 파일에서 구성됩니다. [HTTP 어댑터 connectionPolicy 요소](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file)를 참조하십시오. 

      * **Java 어댑터**
        Java 어댑터에 대해 상호 SSL 인증을 구성하려면 서버의 키 저장소를 업데이트해야 합니다. 아래의 단계에 따라 이를 수행할 수 있습니다. 

        * 키 저장소 파일을 `<ServerInstallation>/mfp-server/usr/servers/mfp/resources/security`에 복사하십시오. 

        * `server.xml` 파일 `<ServerInstallation>/mfp-server/usr/servers/mfp/server.xml`을 편집하십시오. 

        * 올바른 파일 이름, 비밀번호 및 유형을 사용하여 키 저장소 구성을 업데이트하십시오.
        `<keyStore id=“defaultKeyStore” location=<Keystore name> password=<Keystore password> type=<Keystore type> />`

Bluemix에서 {{ site.data.keys.mf_bm_short}} 서비스를 사용하여 배치하는 경우에는 서버를 배치하기 전에 **고급 설정** 아래에서 키 저장소 파일을 업로드할 수 있습니다. 
