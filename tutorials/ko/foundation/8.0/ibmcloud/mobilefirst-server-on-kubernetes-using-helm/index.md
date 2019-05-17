---
layout: tutorial
title: Helm을 사용하여 IBM Cloud Kubernetes Cluster에 Mobile Foundation 설정
breadcrumb_title: Foundation on Kubernetes Cluster using Helm
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Helm 차트를 사용하여 IBM Cloud Kubernetes Cluster(IKS)에서 {{ site.data.keys.mf_server }} 인스턴스 및 {{ site.data.keys.mf_analytics }} 인스턴스를 구성하려면 아래의 지시사항을 따르십시오.

* IBM Cloud Kubernetes Cluster를 설정하십시오.
* IBM Cloud CLI Kubernetes 서비스 CLI(`ibmcloud`)를 사용하여 호스트 컴퓨터를 설정하십시오.
* {{ site.data.keys.prod_icp }}용 {{ site.data.keys.product_full }}의 Passport Advantage 아카이브(PPA 아카이브)를 다운로드하십시오.
* IBM Cloud Kubernetes Cluster에 PPA 아카이브를 로드하십시오.
* 마지막으로 {{ site.data.keys.mf_analytics }}(선택사항) 및 {{ site.data.keys.mf_server }}를 구성 및 설치하십시오.

#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [IBM Mobile Foundation Passport Advantage 아카이브 다운로드](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation Passport Advantage 아카이브 로드](#load-the-ibm-mfpf-ppa-archive)
* [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)
* [설치 확인](#verify-install)
* [샘플 애플리케이션](#sample-app)
* [{{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드](#upgrading-mf-helm-charts)
* [설치 제거](#uninstall)

## 전제조건
{: #prereqs}

IBM Cloud 계정이 있어야 하며 [IBM Cloud Kubernetes Cluster 서비스](https://console.bluemix.net/docs/containers/cs_tutorials.html)의 문서에 따라 Kubernetes Cluster를 설정해야 합니다.

컨테이너 및 이미지를 관리하려면 IBM Cloud CLI 플러그인 설치의 일부로 호스트 시스템에 다음 도구를 설치해야 합니다.

* IBM Cloud CLI(`ibmcloud`)
* Kubernetes CLI
* IBM Cloud Container 레지스트리 플러그인(`cr`)
* IBM Cloud Container 서비스 플러그인(`ks`)

CLI를 사용하여 IBM Cloud Kubernetes Cluster에 액세스하려면 IBM Cloud 클라이언트를 구성해야 합니다. [자세히 알아보기](https://console.bluemix.net/docs/cli/index.html).

## IBM Mobile Foundation Passport Advantage 아카이브 다운로드
{: #download-the-ibm-mfpf-ppa-archive}
{{ site.data.keys.product_full }}의 Passport Advantage(PPA) 아카이브는 [여기](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)에서 사용할 수 있습니다. {{ site.data.keys.product }}의 PPA 아카이브에는 다음 {{ site.data.keys.product }} 컴포넌트의 Docker 이미지 및 Helm Charts가 포함됩니다.
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## IBM Mobile Foundation Passport Advantage 아카이브 로드
{: #load-the-ibm-mfpf-ppa-archive}
{{ site.data.keys.product }}의 PPA 아카이브를 로그하기 전에 Docker를 설치해야 합니다. [여기](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html)에서 지시사항을 확인하십시오.

IBM Cloud Kubernetes Cluster에 PPA 아카이브를 로드하려면 아래에 제공된 단계를 따르십시오.

  1. IBM Cloud 플러그인을 사용하여 클러스터에 로그인하십시오.

      >IBM Cloud CLI 문서의 [CLI 명령 참조서](https://console.bluemix.net/docs/cli/index.html#overview)를 참조하십시오.

      예를 들어, 다음과 같습니다.
      ```bash
      ibmcloud login -a https://ip:port
      ```
      선택적으로 SSL 유효성 검증을 건너뛰려면 위의 명령에서 `--skip-ssl-validation` 플래그를 사용하십시오. 이 옵션을 사용하면 클러스터 엔드포인트의 `username` 및 `password`에 대한 프롬프트가 표시됩니다. 로그인이 성공하면 아래의 단계를 진행하십시오.

  2. 다음 명령을 사용하여 IBM Cloud Container 레지스트리에 로그인하고 Container Service를 초기화하십시오.
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. 다음 명령을 사용하여 배치 영역을 설정하십시오(예: us-south)
      ```bash
      ibmcloud cr region-set
      ```    

  4. 다음 명령을 사용하여 {{ site.data.keys.product }}의 PPA 아카이브를 로드하십시오.
      ```
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
      ```
      {{ site.data.keys.product }}의 *archive_name*은 IBM Passport Advantage에서 다운로드한 PPA 아카이브의 이름입니다.


  helm 차트는 클라이언트 또는 로컬에 저장됩니다(IBM Cloud Private helm 저장소에 저장되는 ICP helm 차트와 다름). 차트는 `ppa-import/charts` 디렉토리 내에 위치할 수 있습니다.

## IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성
{: #configure-install-mf-helmcharts}

{{ site.data.keys.mf_server }}를 설치 및 구성하기 전에 다음이 있어야 합니다.

* [**필수**] 구성되어 사용할 준비가 된 DB2 데이터베이스.
  [{{ site.data.keys.mf_server }} helm을 구성](#install-hmc-icp)하려면 데이터베이스 정보가 필요합니다. {{ site.data.keys.mf_server }}에는 스키마 및 테이블이 필요하며 없는 경우 이 데이터베이스에 작성됩니다.

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

### {{ site.data.keys.mf_analytics }}에 대한 환경 변수
{: #env-mf-analytics }
아래의 표에서는 IBM Cloud Kubernetes Cluster의 {{ site.data.keys.mf_analytics }}에서 사용되는 환경 변수를 제공합니다.

| 규정자 |매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| arch |  | 작업자 노드 아키텍처 | 이 차트를 배치해야 하는 작업자 노드 아키텍처.<br/>**AMD64** 플랫폼만 현재 지원됩니다. |
| image | pullPolicy |이미지 가져오기 정책 | 기본값은 **IfNotPresent**입니다. |
|  | tag | Docker 이미지 태그 | [Docker 태그 설명](https://docs.docker.com/engine/reference/commandline/image_tag/)을 참조하십시오. |
|  | name | Docker 이미지 이름 | {{ site.data.keys.prod_adj }} Operational Analytics Docker 이미지의 이름. |
| scaling | replicaCount | 작성해야 하는 {{ site.data.keys.prod_adj }} Operational Analytics의 인스턴스(포드) 수 | 양의 정수<br/>기본값은 **2**입니다. |
| mobileFirstAnalyticsConsole | user | {{ site.data.keys.prod_adj }} Operational Analytics의 사용자 이름 | 기본값은 **admin**입니다. |
|  | password | {{ site.data.keys.prod_adj }} Operational Analytics의 비밀번호 | 기본값은 **admin**입니다. |
| analyticsConfiguration | clusterName |{{ site.data.keys.prod_adj }} Analytics 클러스터의 이름 | 기본값은 **mobilefirst**입니다. |
|  | analyticsDataDirectory | 분석 데이터가 저장된 경로. *또한 지속적 볼륨 클레임이 컨테이너 내부에 마운트된 경로와 동일합니다*. | 기본값은 `/analyticsData`입니다. |
|  | numberOfShards | {{ site.data.keys.prod_adj }} Analytics에 대한 Elasticsearch 샤드 수 | 양의 정수<br/>기본값은 **2**입니다. |
|  | replicasPerShard | {{ site.data.keys.prod_adj }} Analytics에 대해 각 샤드별로 유지보수할 Elasticsearch 복제본 수 | 양의 정수<br/>기본값은 **2**입니다. |
| keystores | keystoresSecretName | 키 저장소 및 해당 비밀번호가 있는 시크릿 작성 단계를 설명하는 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)을 참조하십시오. |  |
| jndiConfigurations | mfpfProperties | {{ site.data.keys.prod_adj }} Operational Analytics 사용자 정의를 위해 지정할 JNDI 특성 | 쉼표로 구분된 이름 값 쌍을 제공하십시오. |
| resources | limits.cpu | 허용되는 최대 CPU 양 설명 | 기본값은 **2000m**입니다.<br/>[CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 읽으십시오. |
|  | limits.memory | 허용되는 최대 메모리 양 설명 | 기본값은 **4096Mi**입니다.<br/>[메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 읽으십시오. |
|  | requests.cpu | 필요한 최소 CPU 양 설명. 지정되지 않은 경우 기본값은 *한계*(지정된 경우)이거나 그렇지 않으면 구현 정의 값입니다. |기본값은 **1000m**입니다. |
|  | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 양의 기본값은 *한계*(지정된 경우)이거나 구현 정의 값입니다. | 기본값은 **2048Mi**입니다. |
| persistence |existingClaimName | 기존 지속성 볼륨 클레임(PVC)의 이름 |  |
| logs | consoleFormat | 컨테이너 로그 출력 형식을 지정합니다. | 기본값은 **json**입니다. |
|  | consoleLogLevel | 컨테이너 로그로 이동하는 메시지 유형을 제어합니다. | 기본값은 **info**입니다. |
|  | consoleSource | 컨테이너 로그에 기록되는 소스를 지정합니다. 여러 소스의 경우 쉼표로 구분된 목록을 사용합니다. | 기본값은 **message**, **trace**, **accessLog**, **ffdc**입니다. |


### {{ site.data.keys.mf_server }}에 대한 환경 변수
{: #env-mf-server }
아래의 표에서는 IBM Cloud Kubernetes Cluster의 {{ site.data.keys.mf_server }}에서 사용되는 환경 변수를 제공합니다.

| 규정자 |매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| arch |  | 작업자 노드 아키텍처 | 이 차트를 배치해야 하는 작업자 노드 아키텍처.<br/>**AMD64** 플랫폼만 현재 지원됩니다. |
| image | pullPolicy |이미지 가져오기 정책 | 기본값은 **IfNotPresent**입니다. |
|  | tag | Docker 이미지 태그 | [Docker 태그 설명](https://docs.docker.com/engine/reference/commandline/image_tag/)을 참조하십시오. |
|  | name | Docker 이미지 이름 | {{ site.data.keys.prod_adj }} Server Docker 이미지의 이름입니다. |
| scaling | replicaCount | 작성해야 하는 {{ site.data.keys.prod_adj }} Server의 인스턴스(포드) 수 | 양의 정수<br/>기본값은 **3**입니다. |
| mobileFirstOperationsConsole | user | {{ site.data.keys.prod_adj }} Server의 사용자 이름 | 기본값은 **admin**입니다. |
|  | password | {{ site.data.keys.prod_adj }} Server 사용자의 비밀번호 | 기본값은 **admin**입니다. |
| existingDB2Details | db2Host | {{ site.data.keys.prod_adj }} Server 테이블을 구성해야 하는 DB2 데이터베이스의 IP 주소 또는 호스트 | 현재 DB2만 지원됩니다. |
|  | db2Port | DB2 데이터베이스가 설정된 포트 |  |
|  | db2Database | DB2에서 사용하기 위해 사전 구성된 데이터베이스의 이름 |  |
|  | db2Username | DB2 데이터베이스에 액세스할 DB2 사용자 이름 | 사용자에게 테이블을 작성하고 스키마를 작성할 수 있는 액세스 권한이 있어야 합니다(아직 없는 경우). |
|  | db2Password | 제공된 데이터베이스의 DB2 비밀번호  |  |
|  | db2Schema | 작성할 서버 DB2 스키마 |  |
|  | db2ConnectionIsSSL | DB2 연결 유형 | 데이터베이스 연결이 **http**여야 하는지 또는 **https**여야 하는지 지정하십시오. 기본값은 **false**(http)입니다.<br/>또한 DB2 포트가 동일한 연결 모드로 구성되어 있는지 확인하십시오. |
| existingMobileFirstAnalytics | analyticsEndPoint |Analytics Server의 URL | 예를 들어, `http://9.9.9.9:30400`입니다.<br/> 콘솔에 대한 경로를 지정하지 마십시오. 이 경로는 배치 중에 추가됩니다.
 |
|  | analyticsAdminUser | Analytics 관리자의 사용자 이름 |  |
|  | analyticsAdminPassword | Analytics 관리자의 비밀번호 |  |
| keystores | keystoresSecretName | 키 저장소 및 해당 비밀번호가 있는 시크릿 작성 단계를 설명하는 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)을 참조하십시오. |  |
| jndiConfigurations | mfpfProperties | 배치 사용자 정의를 위한 {{ site.data.keys.prod_adj }} Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍입니다. |
| resources | limits.cpu | 허용되는 최대 CPU 양 설명 | 기본값은 **2000m**입니다.<br/>[CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 읽으십시오. |
|  | limits.memory | 허용되는 최대 메모리 양 설명 | 기본값은 **4096Mi**입니다.<br/>[메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 읽으십시오. |
|  | requests.cpu | 필요한 최소 CPU 양 설명. 지정되지 않은 경우 이 기본값은 *한계*(지정된 경우)이거나 그렇지 않으면 구현 정의 값입니다. |기본값은 **1000m**입니다. |
|  | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 이 기본값은 *한계*(지정된 경우)이거나 구현 정의 값입니다. | 기본값은 **2048Mi**입니다. |
| logs | consoleFormat | 컨테이너 로그 출력 형식을 지정합니다. | 기본값은 **json**입니다. |
|  | consoleLogLevel | 컨테이너 로그로 이동하는 메시지 유형을 제어합니다. | 기본값은 **info**입니다. |
|  | consoleSource | 컨테이너 로그에 기록되는 소스를 지정합니다. 여러 소스의 경우 쉼표로 구분된 목록을 사용합니다. | 기본값은 **message**, **trace**, **accessLog**, **ffdc**입니다. |

> Kibana를 사용한 {{ site.data.keys.prod_adj }} 로그 분석에 대한 학습서는 [여기](analyzing-mobilefirst-logs-on-icp/)를 참조하십시오.

### Helm 차트 설치
{: #install-hmc-icp}

#### {{ site.data.keys.mf_analytics }} 설치
{: #install-mf-analytics}

{{ site.data.keys.mf_analytics }} 설치는 선택사항입니다. {{ site.data.keys.mf_server }}에서 Analytics를 사용으로 설정하려면 {{ site.data.keys.mf_server }}를 설치하기 전에 {{ site.data.keys.mf_analytics }}를 먼저 구성하고 설치해야 합니다.

{{ site.data.keys.mf_analytics }} Chart를 설치하기 전에 **지속적 볼륨**을 구성하십시오. {{ site.data.keys.mf_analytics }}를 구성하려면 **지속적 볼륨**을 제공하십시오. **지속적 볼륨**을 작성하려면 [IBM Cloud Kubernetes 문서](https://console.bluemix.net/docs/containers/cs_storage_file.html#file_storage)에 자세히 설명된 단계를 따르십시오.

IBM Cloud Kubernetes Cluster에 IBM {{ site.data.keys.mf_analytics }}를 설치하고 구성하려면 아래의 단계를 따르십시오.

1. Kubernetes Cluster를 구성하려면 아래의 명령을 실행하십시오.
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```
2. 다음 명령을 사용하여 기본 helm 차트 값을 가져오십시오.
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    {{ site.data.keys.mf_analytics }}에 대한 예제:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-1.0.17.tgz > values.yaml
    ```    

3. **values.yaml**을 수정하여 helm 차트를 배치하는 데 적합한 값을 추가하십시오. [ingress](https://console.bluemix.net/docs/containers/cs_ingress.html).hostname 세부사항, 스케일링 등이 추가되었는지 확인하고 values.yaml을 저장하십시오.

4. helm 차트를 배치하려면 다음 명령을 실행하십시오.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Analytics Server 배치를 위한 예제:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-1.0.17.tgz
    ```    

#### {{ site.data.keys.mf_server }} 설치
{: #install-mf-server}

{{ site.data.keys.mf_server }}를 설치하기 전에 DB2 데이터베이스가 사전 구성되어 있는지 확인하십시오.

IBM Cloud Kubernetes Cluster에 IBM {{ site.data.keys.mf_server }}를 설치하고 구성하려면 아래의 단계를 따르십시오.

1. Kube Cluster를 구성하십시오.
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```   

2. 다음 명령을 사용하여 기본 helm 차트 값을 가져오십시오.
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    {{ site.data.keys.mf_server }}에 대한 예제:
    ```bash
    helm inspect values ibm-mfpf-server-prod-1.0.17.tgz > values.yaml
    ```   

3. **values.yaml**을 수정하여 helm 차트를 배치하는 데 적합한 값을 추가하십시오. 데이터베이스 세부사항, 수신(ingress), 스케일링 등이 추가되었는지 확인하고 values.yaml을 저장하십시오.

4. helm 차트를 배치하려면 다음 명령을 실행하십시오.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    서버 배치를 위한 예제:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-1.0.17.tgz
    ```

>**참고:** AppCenter를 설치하려면 해당 helm 차트(예: ibm-mfpf-appcenter-prod-1.0.17.tgz)를 사용하여 위의 단계를 수행해야 합니다.

## 설치 확인
{: #verify-install}

{{ site.data.keys.mf_analytics }}(선택사항) 및 {{ site.data.keys.mf_server }}를 설치하고 구성한 후에는 IBM Cloud CLI, Kubernetes CLI 및 helm 명령을 사용하여 설치와 배치된 팟(Pod)의 상태를 확인할 수 있습니다.

IBM Cloud CLI 문서의 [CLI 명령 참조서](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)와 [Helm 문서](https://docs.helm.sh/helm/)의 Helm CLI를 참조하십시오.

IBM Cloud Portal의 IBM Cloud Kubernetes Cluster 페이지에서 **시작** 단추를 사용하여 Kubernetes 콘솔을 열어 클러스터 아티팩트를 관리할 수 있습니다.

## {{ site.data.keys.prod_adj }} 콘솔 액세스
{: #access-mf-console}

배치에 성공하면 노트가 터미널에 출력으로 표시됩니다. 직접 명령을 실행하여 *NodePort*를 통해 콘솔 URL을 가져올 수 있습니다.

예를 들어, Mobile Foundation Server의 경우 표시되는 노트는 다음과 같습니다.

```text
The Notes displayed as follows as the result of the helm deployment
Get the Server URL by running these commands:
1. For http endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[0].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo http://$NODE_IP:$NODE_PORT/mfpconsole
2. For https endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[1].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo https://$NODE_IP:$NODE_PORT/mfpconsole
```

유사한 설치 방법을 사용하는 경우, `<protocol>://<ip_address>:<node_port>/analytics/console`을 사용하여 IBM MobileFirst Analytics Console에 액세스하고 <`protocol>://<ip_address>:<node_port>/appcenter/console`을 사용하여 IBM Mobile Foundation Application Center에 액세스할 수 있습니다.
콘솔에 액세스하기 위한 *NodePort* 방법 이외에, [수신](https://console.bluemix.net/docs/containers/cs_ingress.html) 호스트를 통해서도 서비스에 액세스할 수 있습니다.

콘솔에 액세스하려면 아래의 단계를 따르십시오.

1. [IBM Cloud Dashboard](https://console.bluemix.net/dashboard/apps/)로 이동하십시오.
2. `Analytics/Server/AppCenter`가 배치된 Kubernetes Cluster를 선택하여 **개요** 페이지를 여십시오.
3. 수신 호스트 이름의 수신 서브도메인을 찾아 다음과 같이 콘솔에 액세스하십시오.
    * 다음을 사용하여 IBM Mobile Foundation Operational Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/mfpconsole`
    * 다음을 사용하여 IBM Mobile Foundation Analytics Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/analytics/console`
    * 다음을 사용하여 IBM Mobile Foundation Application Center Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/appcenter/console`

>**참고:** 포트 9600은 Kubernetes 서비스에서 내부적으로 노출되며 {{ site.data.keys.prod_adj }} Analytics 인스턴스가 전송 포트로 사용됩니다.


## 샘플 애플리케이션
{: #sample-app}
샘플 어댑터를 배치하고 IBM Cloud Kubernetes Cluster에서 실행되는 IBM {{ site.data.keys.mf_server }}에서 샘플 애플리케이션을 실행하려면 [{{ site.data.keys.prod_adj }} 학습서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)를 참조하십시오.

## {{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드
{: #upgrading-mf-helm-charts}

helm 차트/릴리스 업그레이드 방법에 대한 지시사항은 [번들 제품 업그레이드](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)를 참조하십시오.

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
{{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 설치 제거하려면 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)를 사용하십시오.
다음 명령을 사용하여 설치된 차트 및 연관된 배치를 완전히 삭제하십시오.
```bash
helm delete --purge <release_name>
```
*release_name*은 Helm Chart의 배치된 릴리스 이름입니다.
