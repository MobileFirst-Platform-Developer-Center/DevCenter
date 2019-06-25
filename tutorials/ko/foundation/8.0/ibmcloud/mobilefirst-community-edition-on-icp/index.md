---
layout: tutorial
title: IBM Mobile Foundation for Developers 8.0 on IBM Cloud Private 배치
breadcrumb_title: Foundation for Developers on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

IBM Mobile Foundation for Developers 8.0 on {{ site.data.keys.prod_icp }}은 Mobile Foundation 서버와 Operational Analytics 컴포넌트로 구성된 Mobile Foundation의 개발자 에디션입니다. 서버 런타임에는 Mobile Foundation 데이터를 저장하기 위한 기본 제공 Derby 데이터베이스가 있습니다. 이로 인해 사용자는 {{ site.data.keys.prod_icp }}의 Kubernetes 배치에서 하나의 팟(Pod)으로만 제한됩니다. Community Edition은 {{ site.data.keys.prod_icp }}에서 Mobile Foundation 사용자에게 최소한의 구성 매개변수를 제공하고 Mobile Foundation 인스턴스를 쉽게 설정할 수 있는 개발자 환경을 제공합니다.

{{ site.data.keys.prod_icp }}에 사전 구성된 Operational Analytics가 포함된 IBM Mobile Foundation 서버의 개발자 에디션을 설치하려면 아래 지시사항을 따르십시오.<br/>
* IBM Cloud Private Kubernetes Cluster(IBM Cloud Private CE 또는 Native/Enterprise)를 설정하십시오.
* [선택사항] 필수 도구인 Docker CLI, IBM Cloud CLI(cloudctl), Kubernetes CLI(kubectl) 및 Helm CLI(helm)를 사용하여 호스트 컴퓨터를 설정하십시오.


#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [IBM Cloud Private 카탈로그에서 IBM Mobile Foundation for Developers 8.0 설치 및 구성](#install-the-ibm-mfpf-icp-catalog)
* [설치 확인](#verify-install)
* [샘플 애플리케이션](#sample-app)
* [설치 제거](#uninstall)
* [제한사항](#limitations)

## 전제조건
{: #prereqs}

IBM Cloud Private(Community Edition 또는 Native/Enterprise)을 설정하고 준비해야 합니다. 설정 지시사항은 [IBM Cloud Private Cluster 설치](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/install.html) 문서를 참조하십시오.

컨테이너 및 이미지를 관리하려면 {{ site.data.keys.prod_icp }} 설치의 일부로 호스트 시스템에 다음 도구를 설치해야 합니다.

* Docker
* IBM Cloud CLI(`cloudctl`)
* Kubernetes CLI(`kubectl`)
* Helm(`helm`)

CLI를 사용하여 {{ site.data.keys.prod_icp }} Cluster에 액세스하려면 *kubectl* 클라이언트를 구성해야 합니다. [자세히 알아보기](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html).


## IBM Mobile Foundation for Developers 8.0 Helm Charts 설치 및 구성
{: #install-the-ibm-mfpf-icp-catalog}

카탈로그에서 IBM Mobile Foundation for Developers 8.0(**ibm-mobilefoundation-dev**) Helm Charts를 설치하려면 [카탈로그에서 Helm 차트 배치](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_release.html) 프로시저를 따르십시오.

### IBM Mobile Foundation for Developers 8.0 환경 변수
{: #env-mf-developers }
아래 표에서는 IBM Mobile Foundation for Developers 8.0에 사용되는 환경 변수를 보여줍니다.

| 규정자 | 매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| arch |  | 작업자 노드 아키텍처 | 이 차트를 배치해야 하는 작업자 노드 아키텍처.<br/>**AMD64** 플랫폼만 현재 지원됩니다. |
| image | pullPolicy | 이미지 가져오기 정책 | Always, Never 또는 IfNotPresent. <br/> 기본값은 **IfNotPresent**입니다. |
|  | repository | Docker 이미지 이름 | {{ site.data.keys.prod_adj }} Server Docker 이미지의 이름입니다. |
|  | tag | Docker 이미지 태그 | [Docker 태그 설명](https://docs.docker.com/engine/reference/commandline/image_tag/)을 참조하십시오. |
| resources |limits.cpu | 허용되는 최대 CPU 양 설명 | 기본값은 2000m입니다. Kubernetes - [CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|  | limits.memory | 허용되는 최대 메모리 양 설명 | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
|  | requests.cpu |필요한 최소 CPU 양을 설명. 지정하지 않으면 한계(지정된 경우) 또는 구현 정의 값으로 기본 설정됩니다. | 기본값은 2000m입니다. Kubernetes - [CPU의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|  | requests.memory | 필요한 최소 메모리 양 설명. 지정하지 않으면 메모리 양이 한계(지정된 경우) 또는 구현 정의 값으로 기본 설정됩니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| logs | consoleFormat | 컨테이너 로그 출력 형식을 지정합니다. | 기본값은 **json**입니다. |
|  | consoleLogLevel | 컨테이너 로그로 이동하는 메시지 유형을 제어합니다. | 기본값은 **info**입니다. |
|  | consoleSource | 컨테이너 로그에 기록되는 소스를 지정합니다. 여러 소스의 경우 쉼표로 구분된 목록을 사용합니다. | 기본값은 **message**, **trace**, **accessLog**, **ffdc**입니다. |

## 설치 확인
{: #verify-install}

Mobile Foundation for Developers 8.0을 설치한 후에 다음을 수행하여 설치 및 배치된 팟(Pod)의 상태를 확인할 수 있습니다.

{{ site.data.keys.prod_icp }} 관리 콘솔에서 **워크로드 > Helm 릴리스**를 선택하십시오. 설치의 *릴리스 이름*을 클릭하십시오.


## {{ site.data.keys.prod_adj }} 콘솔 액세스
{: #access-mf-console}

설치 완료 후 `<protocol>://<ip_address>:<port>/mfpconsole`을 사용하여 {{ site.data.keys.prod_adj }} Operational Console에 액세스할 수 있습니다.
IBM {{ site.data.keys.mf_analytics }} Console은 `<protocol>://<ip_address>:<port>/analytics/console`을 사용하여 액세스할 수 있습니다.

프로토콜은 `http` 또는 `https`일 수 있습니다. 또한 **NodePort** 배치의 경우 포트는 **NodePort**가 됩니다. 설치된 {{ site.data.keys.prod_adj }} Chart의 ip_address 및 **NodePort**를 가져오려면 아래의 단계를 따르십시오.

1. {{ site.data.keys.prod_icp }} 관리 콘솔에서 **워크로드 > Helm 릴리스**를 선택하십시오.
2. helm 차트 설치의 *릴리스 이름*을 클릭하십시오.
3. **참고** 섹션을 확인하십시오.

## 샘플 애플리케이션
{: #sample-app}
샘플 어댑터를 배치하고 {{ site.data.keys.prod_icp }}에서 실행되는 IBM {{ site.data.keys.mf_server }}에 샘플 어댑터를 배치하고 샘플 애플리케이션을 실행하려면 [{{ site.data.keys.prod_adj }} 학습서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)를 참조하십시오.

## 설치 제거
{: #uninstall}
{{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 설치 제거하려면 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)를 사용하십시오.

대시보드에서 **워크로드 > Helm 릴리스**를 클릭하고 차트 배치에 사용된 *release_name*을 검색한 다음 **조치** 메뉴를 클릭하고 **삭제**를 선택하여 설치된 차트를 완전히 삭제하십시오.

다음 명령을 사용하여 설치된 차트 및 연관된 배치를 완전히 삭제하십시오.
```bash
helm delete --purge <release_name>
```
*release_name*은 Helm Chart의 배치된 릴리스 이름입니다.

## 제한사항
{: #limitations}

이 Helm Charts는 개발 및 테스트용으로만 제공됩니다. 데이터는 임베디드 Derby 데이터베이스에 저장됩니다. 데이터베이스 제한사항으로 인해 차트는 하나의 팟(Pod)에서만 작동합니다.
