---
layout: tutorial
title: IBM Cloud Kubernetes 클러스터에 IBM Mobile Foundation for Developers 8.0 배치
breadcrumb_title: IBM Cloud Kubernetes Cluster의 Foundation for Developers
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

IBM Mobile Foundation for Developers 8.0은 서버와 Operational Analytics 컴포넌트로 구성된 개발자 에디션입니다.

Mobile Foundation 서버 런타임에는 Mobile Foundation 데이터를 저장하기 위한 기본 제공 Derby 데이터베이스가 있습니다. 이로 인해 사용자는 IBM Cloud Kubernetes 배치에서 하나의 팟(Pod)으로만 제한됩니다. Community Edition은 IBM Cloud Kubernetes 서비스에서 Mobile Foundation 사용자에게 최소한의 구성 매개변수를 제공하고 Mobile Foundation 인스턴스를 쉽게 설정할 수 있는 개발자 환경을 제공합니다.

IBM Cloud Kubernetes 서비스에 사전 구성된 Operational Analytics가 포함된 IBM Mobile Foundation 서버의 개발자 에디션을 설치하려면 아래 지시사항을 따르십시오.<br/>
* [여기](https://cloud.ibm.com/kubernetes/clusters)에 Kubernetes 클러스터를 작성하고 구성하십시오.
* [선택사항] 필수 도구인 Docker CLI, Kubernetes CLI(kubectl) 및 Helm CLI(helm)를 사용하여 호스트 컴퓨터를 설정하십시오.

#### 다음으로 이동:
{: #jump-to }

* [전제조건](#prereqs)
* [Hel 차트 카탈로그에서 IBM Mobile Foundation for Developers 8.0 설치 및 구성](#install-the-ibm-mfpf-iks-catalog)
* [설치 확인](#verify-install)
* [샘플 애플리케이션](#sample-app)
* [설치 제거](#uninstall)
* [제한사항](#limitations)

## 전제조건
{: #prereqs}

[IBM Cloud](https://cloud.ibm.com/) 포털을 사용하여 IBM Cloud Kubernetes 서비스(무료 플랜)를 작성해야 합니다. 설정 지시사항은 [문서](https://cloud.ibm.com/docs/containers?topic=containers-getting-started)를 참조하십시오.
kube 팟(Pod) 및 helm 배치를 관리하려면 호스트 머신에 다음 도구를 설치해야 합니다.
* ibmcloud CLI(`ibmcloud`)
* Kubernetes CLI(`kubectl`)
* Helm(`helm`)
CLI를 사용하여 Kubernetes 클러스터에 대해 작업하려면 *ibmcloud* 클라이언트를 구성해야 합니다.
1. [클러스터 페이지](https://cloud.ibm.com/kubernetes/clusters)에 로그인하십시오. (참고: [IBM ID 계정](https://myibm.ibm.com/)이 필요합니다.)
2. IBM Mobile Foundation 차트를 배치할 Kubernetes 클러스터를 클릭하십시오.
3. 클러스터가 작성되면 **액세스** 탭의 지시사항을 따르십시오.
>**참고:** 클러스터 작성에는 몇 분 정도 걸립니다. 클러스터가 작성된 후 **작업자 노드** 탭을 클릭하고 *공인 IP*를 기록해 두십시오.

## IBM Mobile Foundation for Developers 8.0 Helm Charts 설치 및 구성
{: #install-the-ibm-mfpf-iks-catalog}

IBM Cloud 클라이언트 터미널(*ibmcloud* CLI)에서 [Helm 카탈로그에서 차트 배치](https://cloud.ibm.com/kubernetes/helm/ibm-charts/ibm-mobilefoundation-dev)의 **차트 설치** 섹션의 프로시저에 따라 카탈로그에서 IBM Mobile Foundation for Developers 8.0(**ibm-mobilefoundation-dev**) helm 차트를 설치하십시오.

### IBM Mobile Foundation for Developers 8.0 환경 변수
{: #env-mf-developers }

아래 표에서는 IBM Mobile Foundation for Developers 8.0에 사용되는 환경 변수를 보여줍니다.

| 규정자 |매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| arch |  | 작업자 노드 아키텍처 | 이 차트를 배치해야 하는 작업자 노드 아키텍처.<br/>**AMD64** 플랫폼만 현재 지원됩니다. |
| image | pullPolicy |이미지 가져오기 정책 | Always, Never 또는 IfNotPresent. <br/> 기본값은 **IfNotPresent**입니다. |
|  | repository | Docker 이미지 이름 | {{ site.data.keys.prod_adj }} Server Docker 이미지의 이름입니다. |
|  | tag | Docker 이미지 태그 | [Docker 태그 설명](https://docs.docker.com/engine/reference/commandline/image_tag/)을 참조하십시오. |
| resources | limits.cpu | 허용되는 최대 CPU 양 설명 | 기본값은 1000m입니다. Kubernetes - [CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|  | limits.memory | 허용되는 최대 메모리 양 설명 | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
|  | requests.cpu |필요한 최소 CPU 양을 설명. 지정하지 않으면 한계(지정된 경우) 또는 구현 정의 값으로 기본 설정됩니다. | 기본값은 750m입니다. Kubernetes - [CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|  | requests.memory | 필요한 최소 메모리 양 설명. 지정하지 않으면 메모리 양이 한계(values.yaml을 통해 지정된 경우) 또는 구현 정의 값으로 기본 설정됩니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| logs | consoleFormat | 컨테이너 로그 출력 형식을 지정합니다. | 기본값은 **json**입니다. |
|  | consoleLogLevel | 컨테이너 로그로 이동하는 메시지 유형을 제어합니다. | 기본값은 **info**입니다. |
|  | consoleSource | 컨테이너 로그에 기록되는 소스를 지정합니다. 여러 소스의 경우 쉼표로 구분된 목록을 사용합니다. | 기본값은 **message**, **trace**, **accessLog**, **ffdc**입니다. |

## 설치 확인
{: #verify-install}

Mobile Foundation for Developers 8.0을 설치한 후에 다음을 수행하여 설치 및 배치된 팟(Pod)의 상태를 확인할 수 있습니다.
1. [클러스터 페이지](https://cloud.ibm.com/kubernetes/clusters)에서 IBM Mobile Foundation 차트를 배치할 Kubernetes 클러스터를 클릭하십시오.
2. **Kubernetes 대시보드** 단추를 클릭하여 Kube 대시보드로 이동하십시오.
3. 대시보드에서 **배치** 및 **팟(Pod)**을 확인하십시오. 각각 **배치됨** 및 **실행 중** 상태여야 합니다.
4. 이제 서비스에 액세스하려면 배치의 *공인 IP* 및 *노드 포트*가 필요합니다.
    - **공인 IP**를 얻으려면 **Kubernetes** **>** **작업자 노드**를 선택하십시오. IP 주소는 *공인 IP*에서 제공됩니다.
    - **노드 포트**는 내부 엔드포인트의 **Kubernetes 대시보드** **>** **서비스 선택**에서 찾을 수 있습니다. *TCP 노드 포트*(다섯 자리 숫자 포트) 입력에 주의하십시오.
5. 브라우저를 열고 관리 콘솔로 연결해 줄 `http://[public ip]:[node port]/mfpconsole`을 입력하십시오.
6. 기본 인증 정보 사용자로 `admin`을 입력하고 비밀번호로 `admin`을 입력하여 Mobile Foundation 서버 관리 콘솔에 로그인하십시오.
7. 서버 관리, 푸시 및 분석 오퍼레이션이 사용 가능한지 확인하십시오.

### [선택사항] 명령행 사용

또는 아래 프로시저에 따라 명령행을 사용할 수 있습니다. 다음 명령이 **상태**를 *배치됨*으로 표시하는지 확인하십시오.
```bash
helm list
```
`kubectl` 명령을 실행하여 팟(Pod)이 **실행 중** 상태인지 확인하십시오.
1. Kubernetes 클러스터에 대한 모든 배치 목록을 얻고, Mobile Foundation 배치 이름을 기록해 두십시오.
    ```bash
    kubectl get deployments
    ```
2. 다음 명령을 실행하여 배치 가용성 및 상태 세부사항을 확인하십시오. kube 팟(Pod)의 상태에서 가용성이 `(1/1) RUNNING`으로 표시되어야 합니다.
    ```bash
    kubectl describe deployment <deployment_name>
    kubectl get pods
    ```
## {{ site.data.keys.prod_adj }} 콘솔 액세스
{: #access-mf-console}

설치 완료 후 `<protocol>://<public_ip>:<node_port>/mfpconsole`을 사용하여 {{ site.data.keys.prod_adj }} Operational Console에 액세스할 수 있습니다.<br/>
IBM {{ site.data.keys.mf_analytics }} 콘솔은 `<protocol>://<public_ip>:<port>/analytics/console`을 사용하여 액세스할 수 있습니다.
프로토콜은 `http` 또는 `https`일 수 있습니다. 또한 **NodePort** 배치의 경우 포트는 **NodePort**가 됩니다. 설치된 {{ site.data.keys.prod_adj }} Chart의 IP 주소 및 **NodePort**를 가져오려면 Kubernetes 대시보드에서 아래의 단계를 따르십시오.
* **공인 IP**를 얻으려면 공인 IP 아래에서 **Kubernetes** > **작업자 노드** >를 선택하십시오. IP 주소를 기록해 두십시오.
* **노드 포트**는 **Kubernetes 대시보드**에서 찾을 수 있습니다. > **내부 엔드포인트** 아래의 **서비스**를 선택하고 > *TCP 노드 포트*(다섯 자리 숫자 포트) 입력에 주의하십시오.

## 샘플 애플리케이션
{: #sample-app}

샘플 어댑터를 배치하고 IBM Cloud Kubernetes cluster에서 실행되는 IBM {{ site.data.keys.mf_server }}에서 샘플 애플리케이션을 실행하려면 [{{ site.data.keys.prod_adj }} 학습서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)를 참조하십시오.

## 설치 제거
{: #uninstall}

`ibm-mobilefoundation-dev` helm 차트를 설치하려면 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)를 사용하십시오.
다음 명령을 사용하여 설치된 차트 및 연관된 배치를 완전히 삭제하십시오.
```bash
helm delete --purge <release_name>
```
*release_name*은 Helm Chart의 배치된 릴리스 이름입니다.

## 제한사항
{: #limitations}

이 Helm Charts는 개발 및 테스트용으로만 제공됩니다. 데이터는 임베디드 Derby 데이터베이스에 저장되고 지속되지 않습니다. 데이터베이스 제한사항으로 인해 차트 배치는 하나의 팟(Pod)에서만 작동합니다.
