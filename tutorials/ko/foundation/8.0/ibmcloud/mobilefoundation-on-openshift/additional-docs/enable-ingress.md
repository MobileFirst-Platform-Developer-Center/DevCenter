---
layout: tutorial
breadcrumb_title: Enabling Ingress parameters
title: Ingress 매개변수 사용
weight: 4
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Ingress 매개변수 사용
{: #enable-ingress-parameters}

OpenShift 클러스터에 배치된 Mobile Foundation 인스턴스에 액세스하려면 ingress를 구성해야 합니다. 다음 시나리오는 동일한 작업을 수행하는 데 도움이 됩니다.

1. **HTTP 배치**의 경우 `deploy/crds/charts_v1_mfoperator_cr.yaml`의 ingress 섹션은 아래와 비슷합니다.

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: ""
      sslPassThrough: false
    ```

2. **HTTPS 배치**의 경우 TLS 시크릿은 필수입니다.
    * 다음 명령을 사용하여 `tls.key` 및 `tls.crt`를 생성하십시오.

      ```bash
      openssl genrsa -out tls.key 2048
      openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=myhost.mydomain.com
      oc create secret tls mf-tls-secret --cert=tls.cert --key=tls.key
      ```

    * 다음 명령을 사용하여 ingress tls 시크릿을 작성하십시오.

      ```bash
      kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
      ```

    `deploy/crds/charts_v1_mfoperator_cr.yaml`의 ingress 섹션은 아래와 비슷합니다.

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    ```

3. **백엔드 서비스에 대한 HTTPS**의 경우 `tls.crt`는 `keystore.jks` 및 `truststore.jks`로 가져와야 합니다.

    2단계에서 작성한 `tls.crt`를 리터럴 KEYSTORE_PASSWORD 및 TRUSTSTORE_PASSWORD를 사용하여 키 저장소 및 신뢰 저장소 비밀번호와 함께 키 저장소 및 신뢰 저장소에 포함하여 `keystore.jks` 및 `truststore.jks`에서 시크릿을 미리 작성하십시오. `deploy/crds/charts_v1_mfoperator_cr.yaml`에서 각 컴포넌트의 *keystoreSecret* 필드에 시크릿 이름을 제공하십시오.

    파일 `keystore.jks`, `truststore.jks`, 해당 비밀번호를 아래와 같이 유지하십시오.

    예를 들어, 다음과 같습니다.

    ```bash
    oc create secret generic server-stores --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
    ```

    >**참고**: 파일 이름 및 리터럴은 위 명령에서 언급된 것과 동일해야 합니다. 사용자 정의 자원을 구성할 때 각 문서의 *keystoreSecret* 입력 필드에 이 시크릿 이름을 제공하여 기본 키 저장소를 대체하십시오.

    `deploy/crds/charts_v1_mfoperator_cr.yaml`의 ingress 섹션은 아래와 비슷합니다.

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    https: true
    mfpserver:
      keystoreSecret: "server-stores"
    ```  
