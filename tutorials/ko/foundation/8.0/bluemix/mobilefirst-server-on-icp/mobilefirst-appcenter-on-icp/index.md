---
layout: tutorial
title: IBM Cloud Private에서 MobileFirst Application Center 설정
breadcrumb_title: Application Center on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM {{ site.data.keys.mf_app_center }}는 엔터프라이즈 애플리케이션 저장소로 사용할 수 있으며 조직 내의 다른 팀 구성원 간에 정보를 공유하는 방법입니다. {{ site.data.keys.mf_app_center_short }}의 개념은 조직 내에서 개인 용도만 대상으로 한다는 점을 제외하고는 Apple의 공용 App Store 또는 Android의 Play Store와 비슷합니다. {{ site.data.keys.mf_app_center_short }}를 사용하여 동일한 조직 내의 사용자가 모바일 애플리케이션의 저장소 역할을 하는 단일 위치에서 모바일 디바이스로 애플리케이션을 다운로드할 수 있습니다.
MobileFirst Application Center에 대한 자세한 정보는 [MobileFirst Application Center 문서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)를 참조하십시오.


#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [IBM {{ site.data.keys.mf_app_center }} Passport Advantage 아카이브 다운로드](#download-the-ibm-mac-ppa-archive)
* [{{ site.data.keys.prod_icp }}에 IBM {{ site.data.keys.mf_app_center }} PPA 아카이브 로드](#load-the-ibm-mfpf-appcenter-ppa-archive)
* [{{ site.data.keys.mf_app_center }}에 대한 환경 변수](#env-mf-appcenter)
* [{{ site.data.keys.mf_app_center }} 설치 및 구성](#configure-install-mf-appcenter-helmcharts)
* [설치 확인](#verify-install)
* [{{ site.data.keys.mf_app_center }} 액세스](#access-mf-appcenter-console)
* [{{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드](#upgrading-mf-helm-charts)
* [설치 제거](#uninstall)
* [참조](#references)

## 전제조건
{: #prereqs}

{{ site.data.keys.prod_icp }} 계정이 있어야 하며 [{{ site.data.keys.prod_icp }}의 문서](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html)에 따라 Kubernetes Cluster를 설정해야 합니다.

{{ site.data.keys.prod_icp }}에 {{ site.data.keys.mf_app_center }} Charts를 설치 및 구성하려면 사전 구성된 데이터베이스가 필요합니다. {{ site.data.keys.mf_app_center }} helm chart를 구성하려면 데이터베이스 정보를 제공해야 합니다. {{ site.data.keys.mf_app_center }}에 필요한 테이블이 이 데이터베이스에 작성됩니다.

> 지원되는 데이터베이스는 DB2입니다.

컨테이너 및 이미지를 관리하려면 {{ site.data.keys.prod_icp }} 설치의 일부로 호스트 시스템에 다음 도구를 설치해야 합니다.

* Docker
* IBM Cloud CLI(`bx`)
* {{ site.data.keys.prod_icp }}(ICP) IBM Cloud CLI를 위한 플러그인( `bx pr` )
* Kubernetes CLI(`kubectl`)
* Helm(`helm`)

## IBM {{ site.data.keys.mf_app_center }} Passport Advantage 아카이브 다운로드
{: #download-the-ibm-mac-ppa-archive}
{{ site.data.keys.mf_app_center }}의 Passport Advantage(PPA) 아카이브는 [여기]()에서 사용할 수 있습니다. {{ site.data.keys.product }}의 PPA 아카이브에는 다음 {{ site.data.keys.product }} 컴포넌트의 Docker 이미지 및 Helm Charts가 포함됩니다.
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

[IBM Fix Central](http://www.ibm.com/support/fixcentral)에서 {{ site.data.keys.mf_app_center }}에 대한 임시 수정사항을 얻을 수 있습니다.<br/>

## {{ site.data.keys.prod_icp }}에 IBM {{ site.data.keys.mf_app_center }} PPA 아카이브 로드
{: #load-the-ibm-mfpf-appcenter-ppa-archive}

{{ site.data.keys.product }}의 PPA 아카이브를 로그하기 전에 Docker를 설치해야 합니다. [여기](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html)에서 지시사항을 확인하십시오.

PPA 아카이브를 {{ site.data.keys.prod_icp }} 클러스터에 로드하려면 아래에 제공된 단계를 따르십시오.

  1. IBM Cloud ICP 플러그인(`bx pr`)을 사용하여 클러스터에 로그인하십시오.
      >{{ site.data.keys.prod_icp }} 문서의 [CLI 명령 참조서](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html)를 확인하십시오.

      예를 들어, 다음과 같습니다.
      ```bash
      bx pr login -a https://<ip>:<port>
      ```
      선택적으로 SSL 유효성 검증을 건너뛰려면 위의 명령에서 `--skip-ssl-validation` 플래그를 사용하십시오. 이 옵션을 사용하면 클러스터 엔드포인트의 `username` 및 `password`에 대한 프롬프트가 표시됩니다. 로그인이 성공하면 아래의 단계를 진행하십시오.

  2. 다음 명령을 사용하여 {{ site.data.keys.product }}의 PPA 아카이브를 로드하십시오.
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      {{ site.data.keys.product }}의 *archive_name*은 IBM Passport Advantage에서 다운로드한 PPA 아카이브의 이름입니다.

      이전 단계를 수행하고 `bx pr`의 기본값으로 클러스터 엔드포인트를 작성한 경우 `--clustername`은 무시할 수 있습니다.

  3. PPA 아카이브를 로드한 후 저장소를 동기화하면 Helm Charts가 **카탈로그**에 나열됩니다. {{ site.data.keys.prod_icp }} 관리 콘솔에서 이 작업을 완료할 수 있습니다.<br/>
     * **관리 > 저장소**를 선택하십시오.
     * **저장소 동기화**를 클릭하십시오.

  4.  그런 다음 {{ site.data.keys.prod_icp }} 관리 콘솔에서 Docker 이미지 및 Helm Charts를 볼 수 있습니다.<br/>
      Docker 이미지를 보려면 다음과 같이 하십시오.
      * **플랫폼 > 이미지**를 선택하십시오.
      * Helm Charts가 **카탈로그**에 표시됩니다.

  위의 단계를 완료하면 {{ site.data.keys.prod_adj }} Helm Charts의 업로드된 버전이 ICP 카탈로그에 표시됩니다. {{ site.data.keys.mf_app_center }}가 카탈로그에 **ibm-mfpf-appcenter-prod**로 표시됩니다.

## {{ site.data.keys.mf_app_center }}에 대한 환경 변수
{: #env-mf-appcenter }
아래의 표에서는 {{ site.data.keys.prod_icp }}의 {{ site.data.keys.mf_app_center }}에서 사용되는 환경 변수를 제공합니다.

| 규정자 | 매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| arch |  | 작업자 노드 아키텍처 | 이 차트를 배치해야 하는 작업자 노드 아키텍처. **AMD64** 플랫폼만 현재 지원됩니다. |
| image | pullPolicy |이미지 가져오기 정책 | 기본값은 **IfNotPresent**입니다. |
|  | name | Docker 이미지 이름 | {{ site.data.keys.mf_app_center }} Docker 이미지의 이름. |
|  | tag | Docker 이미지 태그 | [Docker 태그 설명](https://docs.docker.com/engine/reference/commandline/image_tag/)을 참조하십시오. |
| mobileFirstAppCenterConsole | user | {{ site.data.keys.mf_app_center }} 콘솔의 사용자 이름 |  |
|  | password | {{ site.data.keys.mf_app_center }} 콘솔의 비밀번호 |  |
| existingDB2Details | appCenterDB2Host |{{ site.data.keys.mf_app_center_short }} 데이터베이스가 구성된 DB2 서버의 IP 주소 |  |
|  | appCenterDB2Port | 설정된 DB2 데이터베이스의 포트 |  |
|  | appCenterDB2Database | 사용할 데이터베이스의 이름 | 이전에 데이터베이스를 작성해야 합니다. |
|  | appCenterDB2Username | DB2 데이터베이스에 액세스할 DB2 사용자 이름 | 사용자에게 테이블을 작성하고 스키마를 작성할 수 있는 액세스 권한이 있어야 합니다(아직 없는 경우). |
|  | appCenterDB2Password | 제공된 데이터베이스의 DB2 비밀번호 |  |
|  | appCenterDB2Schema | 작성할 {{ site.data.keys.mf_app_center_short }} DB2 스키마  |  |
|  | appCenterDB2ConnectionIsSSL | DB2 연결 유형 | 데이터베이스 연결이 **http**여야 하는지 또는 **https**여야 하는지 지정하십시오. 기본값은 **false**(http)입니다. 또한 DB2 포트가 동일한 연결 모드로 구성되어 있는지 확인하십시오. |
| keystores | keystoresSecretName | 키 저장소 및 해당 비밀번호가 있는 시크릿 작성 단계를 설명하는 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](../#configure-install-mf-helmcharts)을 참조하십시오. |  |
| resources | limits.cpu | 허용되는 최대 CPU 양 | 기본값은 **1000m**입니다.<br/>자세한 정보는 [여기](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|  | limits.memory | 허용되는 최대 메모리 양 | 기본값은 **1024Mi**입니다.<br/>자세한 정보는 [여기](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| resources.requests | requests.cpu | 필요한 최소 CPU 양 설명. 지정되지 않은 경우 이 기본값은 *한계*(지정된 경우)이거나 그렇지 않으면 구현 정의된 값입니다. |기본값은 **1000m**입니다. |
|  | requests.memory | 필요한 최소 메모리 설명. 지정되지 않은 경우 메모리의 기본값은 *한계*(지정된 경우)이거나 구현 정의된 값입니다. | 기본값은 **1024Mi**입니다. |

## {{ site.data.keys.mf_app_center }} 설치 및 구성
{: #configure-install-mf-appcenter-helmcharts}

{{ site.data.keys.mf_app_center }}를 설치 및 구성하기 전에 다음이 있어야 합니다.

* [**필수**] 구성되어 사용할 준비가 된 DB2 데이터베이스.
  [{{ site.data.keys.mf_server }} helm을 구성](../#install-hmc-icp)하려면 데이터베이스 정보가 필요합니다. {{ site.data.keys.mf_server }}에는 스키마 및 테이블이 필요하며 없는 경우 이 데이터베이스에 작성됩니다.

* [**선택사항**] 키 저장소 및 신뢰 저장소가 있는 시크릿.
  자체 키 저장소 및 신뢰 저장소가 있는 시크릿을 작성하여 자체 키 저장소 및 신뢰 저장소를 배치에 제공할 수 있습니다.

  설치 전에 아래의 단계를 따르십시오.

  * `keystore.jks`, `keystore-password.txt`, `truststore.jks`, `truststore-password.txt`로 시크릿을 작성하고 *keystores.keystoresSecretName* 필드에 시크릿 이름을 제공하십시오.

  * `keystore-password.txt` 및 `truststore.jks` 파일에 `keystore.jks` 및 해당 비밀번호를 보관하고 `truststore-password.jks` 파일에 해당 비밀번호를 보관하십시오.

  * 명령행으로 이동하여 다음을 실행하십시오.
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**참고:** 파일 이름은 언급한 것과 동일해야 합니다. 예를 들어, `keystore.jks`, `keystore-password.txt`, `truststore.jks` 및 `truststore-password.txt`입니다.

  * 기본 키 저장소를 대체하려면 *keystoresSecretName*의 시크릿 이름을 제공하십시오.

  자세한 정보는 [MobileFirst Server 키 저장소 구성]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오.

{{ site.data.keys.prod_icp }} 관리 콘솔에서 IBM {{ site.data.keys.mf_app_center }}를 설치 및 구성하려면 아래의 단계를 따르십시오.

1. 관리 콘솔에서 **카탈로그**로 이동하십시오.
2. **ibm-mfpf-appcenter-prod** helm chart를 선택하십시오.
3. **구성**을 클릭하십시오.
4. 환경 변수를 제공하십시오. 자세한 정보는 [{{ site.data.keys.mf_app_center }}에 대한 환경 변수](#env-mf-appcenter)를 참조하십시오.
5. **설치**를 클릭하십시오.

## 설치 확인
{: #verify-install}

{{ site.data.keys.mf_analytics }}(선택사항) 및 {{ site.data.keys.mf_server }}를 설치 및 구성한 후 다음을 완료하여 설치 및 배치된 포드 상태를 확인할 수 있습니다.

{{ site.data.keys.prod_icp }} 관리 콘솔에서 **워크로드 > Helm 릴리스**를 선택하십시오. 설치의 *릴리스 이름*을 클릭하십시오.

## {{ site.data.keys.mf_app_center }} 액세스
{: #access-mf-appcenter-console}

{{ site.data.keys.mf_app_center }} Helm Chart 설치를 완료한 후 `<protocol>://<external_ip>:<port>/appcenterconsole`을 사용하여 브라우저에서 {{ site.data.keys.mf_app_center }} 콘솔에 액세스할 수 있습니다.

프로토콜은 **http** 또는 **https**일 수 있습니다. 또한 NodePort 배치의 경우 포트는 NodePort가 됩니다. 설치된 {{ site.data.keys.mf_app_center }} Chart의 ip_address 및 NodePort를 가져오려면 아래의 단계를 따르십시오.

1. {{ site.data.keys.prod_icp }} 관리 콘솔에서 **워크로드 > Helm 릴리스**를 선택하십시오.
2. helm chart 설치의 *릴리스 이름*을 클릭하십시오.
3. **참고** 섹션을 확인하십시오.

> **참고:** {{ site.data.keys.mf_app_center }} 모바일 클라이언트에 액세스하려면 Passport Advantage에서 애플리케이션 센터 패키지를 다운로드하십시오. [자세히 알아보기](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/mobile-client/).

## {{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드
{: #upgrading-mf-helm-charts}

helm charts/릴리스 업그레이드 방법에 대한 지시사항은 [번들 제품 업그레이드](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)를 참조하십시오.

### Helm 릴리스 업그레이드를 위한 샘플 시나리오

1. `values.yaml` 값을 변경한 helm 릴리스를 업그레이드하려면 `helm upgrade` 명령을 **--set** 플래그와 함께 사용하십시오. **--set** 플래그를 여러 번 지정할 수 있습니다. 우선순위는 명령행에 지정된 가장 오른쪽 세트에 주어집니다.
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. 파일에 값을 제공하여 helm 릴리스를 업그레이드하려면 `helm upgrade` 명령을 **-f** 플래그와 함께 사용하십시오. **--values** 또는 **-f** 플래그를 여러 번 사용할 수 있습니다. 우선순위는 명령행에 지정된 가장 오른쪽 파일에 주어집니다. 다음 예제에서 `myvalues.yaml` 및 `override.yaml` 모두에 *테스트* 키가 포함된 경우 `override.yaml`에 설정된 값이 우선순위입니다.
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. 마지막 릴리스의 값을 다시 사용하고 일부를 대체하여 helm 릴리스를 업그레이드하기 위해 아래와 같은 명령을 사용할 수 있습니다.
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## 설치 제거
{: #uninstall}
{{ site.data.keys.mf_app_center }}를 설치 제거하려면 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)를 사용하십시오.
다음 명령을 사용하여 설치된 차트 및 연관된 배치를 완전히 삭제하십시오.
```bash
helm delete --purge <release_name>
```
*release_name*은 Helm Chart의 배치된 릴리스 이름입니다.

## 참조
{: #references}

{{ site.data.keys.mf_app_center }}에 대한 자세한 정보는 [여기](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/)를 참조하십시오.
