---
layout: tutorial
breadcrumb_title: Mobile Foundation Custom Resource (CR) configuration
title: IBM Mobile Foundation 사용자 정의 자원(CR) 구성
weight: 3
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->

### 매개변수

| 규정자 |매개변수  | 정의 | 허용값 |
|---|---|---|---|
| global.arch | amd64    | 하이브리드 클러스터에서의 amd64 작업자 노드 스케줄러 선호사항 | amd64 |
| global.image     | pullPolicy |이미지 가져오기 정책 | Always, Never 또는 IfNotPresent. 기본값: **IfNotPresent** |
|      |  pullSecret    | 이미지 가져오기 시크릿 | 이미지가 OCP 이미지 레지스트리에 호스팅되지 않은 경우에만 필수입니다. |
| global.ingress | hostname | 외부 클라이언트에서 사용할 외부 호스트 이름 또는 IP 주소 | 기본적으로 클러스터 프록시 노드의 IP 주소로 설정하려면 공백으로 두기|
|         | secret | TLS 시크릿 이름| Ingress 정의에서 사용해야 하는 인증서의 스크릿 이름을 지정합니다. 시크릿은 관련 인증서 및 키를 사용하여 사전에 작성해야 합니다. SSL/TLS를 사용하는 경우 필수입니다. 여기에 이름을 제공하기 전에 인증서 & 키를 사용하여 시크릿을 사전에 작성하십시오. [여기](#optional-creating-tls-secret-for-ingress-configuration)를 참조하십시오. |
|         | sslPassThrough | SSL 패스스루 사용 | Mobile Foundation 서비스로 SSL 요청을 패스스루해야 하는지 여부를 지정합니다. Mobile Foundation 서비스에서 SSL이 종료됩니다.  **false**(기본값) 또는 true|
| global.dbinit | enabled | Server, Push, Application Center 데이터베이스 초기화 사용 | Server, Push, Application Center 배치의 경우 데이터베이스를 초기화하고 스키마/테이블을 작성합니다(Analytics의 경우 필요하지 않음).  **true**(기본값) 또는 false |
|  | repository | 데이터베이스 초기화를 위한 Docker 이미지 저장소 | Mobile Foundation 데이터베이스 Docker 이미지의 저장소. REPO_URL 플레이스홀더는 올바른 Docker 레지스트리 URL로 바꾸어야 합니다. |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
| mfpserver | enabled          | Server를 사용하도록 플래그 지정 | **true**(기본값) 또는 false |
| mfpserver.image | repository | Docker 이미지 저장소 | Mobile Foundation Server Docker 이미지의 저장소. REPO_URL 플레이스홀더는 올바른 Docker 레지스트리 URL로 바꾸어야 합니다. |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | [여기](#optional-creating-custom-defined-console-login-secrets) 참조
|  mfpserver.db | type | 지원되는 데이터베이스 벤더 이름. | **DB2**(기본값)/MySQL/Oracle |
|               | host | Mobile Foundation Server 테이블을 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름. | |
|                       | port | 	데이터베이스가 설정되는 포트 | |
|                       | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
|                       | name | Mobile Foundation Server 데이터베이스의 이름 | |
|                       | schema | 작성할 서버 DB 스키마. | 스키마가 이미 있으면 이를 사용합니다. 그렇지 않으면 작성됩니다. |
|                       | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값은 **false**(http)입니다. 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
|                       | driverPvc | JDBC 데이터베이스 드라이버에 액세스하기 위한 지속적 볼륨 청구| JDBC 데이터베이스 드라이버를 호스팅하는 지속적 볼륨 청구 이름을 지정합니다. 선택된 데이터베이스 유형이 DB2가 아닌 경우 필수입니다. |
|                       | adminCredentialsSecret | MFPServer DB 관리 시크릿 | DB 초기화를 사용하는 경우 시크릿을 제공하여 Mobile Foundation 컴포넌트에 대한 데이터베이스 테이블 및 스키마를 작성합니다. |
| mfpserver | adminClientSecret | Admin 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [여기](#optional-creating-secrets-for-confidential-clients) 참조  |
|  | pushClientSecret | Push 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [여기](#optional-creating-secrets-for-confidential-clients) 참조 |
| mfpserver.replicas |  | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: **3**) |
| mfpserver.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicas 필드를 사용하지 않습니다. | **false**(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: **1**) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. 최소값보다 낮을 수 없습니다. | 양의 정수(기본값: **10**) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100 사이의 정수(기본값: **50**) |
| mfpserver.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | **true**(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
|    mfpserver.customConfiguration |  |  사용자 정의 서버 구성(선택사항)  | 사전 작성된 구성 맵에 대한 서버 특정 추가 구성 참조를 제공합니다.  [여기](#optional-custom-server-configuration) 참조|
| mfpserver.jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| mfpserver | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 [구성 절](#optional-creating-custom-keystore-secret-for-the-deployments)을 참조하십시오.|
| mfpserver.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  |기본값: **2000m**. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 **2048Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값은 **1000m**입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값: **1536Mi**. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfppush | enabled          | Mobile Foundation Push를 사용하도록 플래그 지정 | **true**(기본값) 또는 false |
|           | repository   | Docker 이미지 저장소 |Mobile Foundation Push Docker 이미지의 저장소. REPO_URL 플레이스홀더는 올바른 Docker 레지스트리 URL로 바꾸어야 합니다. |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
| mfppush.replicas | | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: **3**) |
| mfppush.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | **false**(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: **1**) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: **10**) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100 사이의 정수(기본값: **50**) |
| mfppush.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | **true**(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| mfppush.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Push 특정 추가 구성 참조를 제공합니다.  [여기](#optional-custom-server-configuration) 참조 |
| mfppush.jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| mfppush | keystoresSecretName | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 [구성 절](#optional-creating-custom-keystore-secret-for-the-deployments)을 참조하십시오.|
| mfppush.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  |기본값은 **1000m**입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 **2048Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값: **750m**. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 **1024Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfpanalytics | enabled          | Analytics를 사용하도록 플래그 지정 | **false**(기본값) 또는 true |
| mfpanalytics.image | repository          | Docker 이미지 저장소 | Mobile Foundation Operational Analytics Docker 이미지의 저장소. REPO_URL 플레이스홀더는 올바른 Docker 레지스트리 URL로 바꾸어야 합니다. |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | [여기](#optional-creating-custom-defined-console-login-secrets) 참조|
| mfpanalytics.replicas |  | 작성해야 하는 Mobile Foundation Operational Analytics의 인스턴스 수(팟(Pod)) | 양의 정수(기본값: **2**) |
| mfpanalytics.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | **false**(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: **1**) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: **10**) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
|  mfpanalytics.shards|  | Mobile Foundation Analytics에 대한 Elasticsearch 샤드 수 | 기본값: 2|             
|  mfpanalytics.replicasPerShard|  |Mobile Foundation Analytics에 대해 각 샤드당 유지보수할 Elasticsearch 복제본 수 | 기본값: **2**|
| mfpanalytics.persistence | enabled         | 데이터를 지속하기 위해 PersistentVolumeClaim 사용                        | **true** |                                                 |
|            |useDynamicProvisioning      | storageclass를 지정하거나 비어두기  | **false**  |                                                  |
|           |volumeName| 볼륨 이름 제공  | **data-stor**(기본값) |
|           |claimName| 기존 PersistentVolumeClaim 제공  | nil |
|           |storageClassName     | PersistentVolumeClaim을 지원하는 스토리지 클래스 | nil |
|           |size             | 데이터 볼륨 크기      | 20Gi |
| mfpanalytics.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | **true**(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: **1**) |
|    mfpanalytics.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Analytics 특정 추가 구성 참조를 제공합니다. [여기]를 참조하십시오. (#optional-custom-server-configuration |
| mfpanalytics.jndiConfigurations | mfpfProperties | 운영 분석을 사용자 정의하기 위해 지정할 Mobile Foundation JNDI 특성| 쉼표로 구분된 이름 값 쌍 제공  |
| mfpanalytics | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 [구성 절](#optional-creating-custom-keystore-secret-for-the-deployments)을 참조하십시오.|
| mfpanalytics.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  |기본값은 **1000m**입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 **2048Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값: **750m**. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfpappcenter | enabled          | Application Center를 사용하도록 플래그 지정 | **false**(기본값) 또는 true |  
| mfpappcenter.image | repository          | Docker 이미지 저장소 | Mobile Foundation Application Center Docker 이미지의 저장소. REPO_URL 플레이스홀더는 올바른 Docker 레지스트리 URL로 바꾸어야 합니다. |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | [여기](#optional-creating-custom-defined-console-login-secrets) 참조|
|  mfpappcenter.db | type | 지원되는 데이터베이스 벤더 이름. | **DB2**(기본값)/MySQL/Oracle |
|                   | host | Appcenter 데이터베이스에서 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름	| |
|                       | port | 	데이터베이스 포트  | |             
|                       | name | 사용할 데이터베이스의 이름 | 데이터베이스가 사전에 작성되어야 합니다.|
|                       | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
|                       | schema | 작성할 Application Center 데이터베이스 스키마. | 스키마가 이미 있으면 이를 사용합니다. 없으면 작성됩니다. |
|                       | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값은 **false**(http)입니다. 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
|                       | driverPvc | JDBC 데이터베이스 드라이버에 액세스하기 위한 지속적 볼륨 청구| JDBC 데이터베이스 드라이버를 호스팅하는 지속적 볼륨 청구 이름을 지정합니다. 선택된 데이터베이스 유형이 DB2가 아닌 경우 필수입니다. |
|                       | adminCredentialsSecret | Application Center DB 관리 시크릿 | DB 초기화를 사용하는 경우 Mobile Foundation 컴포넌트를 위해 데이터베이스 테이블과 스키마를 작성하려면 시크릿 제공 |
| mfpappcenter.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | **false**(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: **1**) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: **10**) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100 사이의 정수(기본값: **50**) |
| mfpappcenter.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | **true**(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: **1**) |
| mfpappcenter.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Application Center 특정 추가 구성 참조를 제공합니다. [여기](#optional-custom-server-configuration) 참조 |
| mfpappcenter | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 [구성 절](#optional-creating-custom-keystore-secret-for-the-deployments)을 참조하십시오.|
| mfpappcenter.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  |기본값은 **1000m**입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 **2048Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값: **750m**. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 **1024Mi**입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |

## [선택사항] 사용자 정의된 콘솔 로그인 시크릿 작성

기본적으로 모든 Mobile Foundation 컴포넌트에 대한 콘솔 로그인 시크릿은 배치 중에 자동으로 작성됩니다. 선택적으로 Server, Analytics, Application Center 콘솔에 명시적으로 액세스하도록 **로그인 시크릿**을 작성하도록 선택할 수 있습니다. 다음은 해당 예입니다.

Server의 경우,

```
kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
```

Analytics의 경우,

```
kubectl create secret generic analyticslogin --from-literal=MFPF_ANALYTICS_ADMIN_USER=admin --from-literal=MFPF_ANALYTICS_ADMIN_PASSWORD=admin
```

Application Center의 경우,

```
kubectl create secret generic appcenterlogin --from-literal=MFPF_APPCNTR_ADMIN_USER=admin --from-literal=MFPF_APPCNTR_ADMIN_PASSWORD=admin
```

> 참고: 이러한 시크릿이 제공되지 않으면, Mobile Foundation 설치 중에 기본 사용자 이름과 비밀번호인 admin/admin을 사용하여 작성됩니다.

## [선택사항] ingress 구성에 대한 TLS 시크릿 작성

Mobile Foundation 컴포넌트는 호스트 이름을 사용하여 도달하기 위해 외부 클라이언트에 대한 호스트 이름 기반 Ingress로 설정될 수 있습니다. Ingress는 TLS 개인 키와 인증을 사용하여 보호될 수 있습니다. TLS 개인 키와 인증은 키 이름 `tls.key` 및 `tls.crt`를 가진 시크릿에서 정의되어야 합니다.

**mf-tls-secret** 시크릿은 다음 명령을 사용하여 Ingress 자원과 동일한 네임스페이스에 작성됩니다.

```
kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
```

그런 다음, 시크릿 이름은 사용자 정의 자원 구성 yaml의 *global.ingress.secret* 필드에서 제공됩니다.

## [선택사항] 배치를 위한 사용자 정의 keyStore 시크릿 작성

자체 키 저장소 및 신뢰 저장소가 있는 시크릿을 작성하여 자체 키 저장소 및 신뢰 저장소를 Server, Push, Analytics, Application Center 배치에 제공할 수 있습니다.

리터럴 KEYSTORE_PASSWORD 및 TRUSTSTORE_PASSWORD를 사용하는 키 저장소 및 신뢰 저장소 비밀번호와 함께 `keystore.jks` 및 `truststore.jks`를 사용하여 시크릿을 사전 작성하고 시크릿 이름을 각 컴포넌트의 keystoreSecret 필드에 시크릿 이름을 제공하십시오.

다음은 `keystore.jks`, `truststore.jks`를 사용하여 서버 배치에 대한 키 저장소 시크릿을 작성하고 비밀번호를 설정하는 예입니다.
```
kubectl create secret generic server-secret --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
```

> 참고: 파일과 리터럴의 이름이 위 명령에서 언급될 때 동일해야 합니다.	이 시크릿 이름을 각 컴포넌트의 `keystoresSecretName` 입력 필드에 제공하여 helm 차트를 구성할 때 기본 키 저장소를 대체하십시오.


## [선택사항] 기밀 클라이언트를 위한 시크릿 작성

Mobile Foundation Server는 Admin Service의 기밀 클라이언트로 사전 정의됩니다. 이러한 클라이언트의 신임 정보는 `mfpserver.adminClientSecret` 및 `mfpserver.pushClientSecret` 필드에서 제공됩니다.

이러한 시크릿은 다음과 같이 작성될 수 있습니다.

```
kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin

kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
```

이러한 `mfpserver.pushClientSecret` 및 `mfpserver.adminClientSecret` 필드의 값을 helm 차트 설치 중에 제공하지 않으면 다음과 같이 각각 아래 신임 정보를 사용하여 기본 클라이언트 시크릿이 작성됩니다.

* `mfpserver.adminClientSecret`의 경우 `admin / nimda`
* `mfpserver.pushClientSecret`의 경우 `push / hsup`

## [선택사항] 사용자 정의 서버 구성

구성을 사용자 정의하려면(예: 로그 추적 설정 수정, 새 jndi 특성 추가 등) 구성 XML 파일을 사용하여 구성 맵을 사용해야 합니다. 이렇게 하면 새 구성 설정을 추가하거나 Mobile Foundation 컴포넌트의 기존의 구성을 대체할 수 있습니다.

사용자 정의 구성은 다음과 같이 작성될 수 있는 configMap(mfpserver 사용자 정의 구성)을 통하여 Mobile Foundation 컴포넌트에 의해 액세스됩니다.

```
kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
```

Mobile Foundation을 배치하는 동안 Helm 차트에서 **사용자 정의 서버 구성**에서 제공되는 configmap은 위의 명령을 사용하여 작성했습니다.

mfpserver 사용자 정의 구성 configmap을 사용하여 warning(기본 설정은 info)으로 추적 로그 스펙을 설정하는 예는 아래와 같습니다.

- 샘플 구성 XML(logging.xml)

```
<server>
        <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
        maxFileSize="20" />
</server>
```

- configmap을 작성한 후 helm 차트 배치 동안 동일 항목 추가

```
kubectl create configmap mfpserver-custom-config --from-file=logging.xml
```

- Mobile Foundation 컴포넌트의 messages.log에서 변경에 주의하십시오. ***Property traceSpecification will be set to com.ibm.mfp.=debug:\*=warning.***

## [선택사항] 사용자 정의 생성된 LTPA 키 사용

기본적으로 Mobile Foundation의 이미지는 각 Mobile Foundation 컴포넌트에 대해 `ltpa.keys` 세트를 번들합니다. 프로덕션 환경에서 사용자 정의로 생성된 항목으로 기본 `ltpa.keys`를 업데이트해야 하는 경우 사용자 정의 구성을 사용하여 config xml과 함께 사용자 정의 생성된 `ltpa.keys`를 추가할 수 있습니다.

다음은 구성 샘플 `ltpa.xml`입니다.

```xml
<server description="mfpserver">
    <ltpa
        keysFileName="ltpa.keys" />
    <webAppSecurity ssoUseDomainFromURL="true" />
</server>
```

다음 명령은 사용자 정의 LTPA 키를 추가하는 예입니다.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys
```

LTPA 키 생성에 대한 자세한 정보 및 기타 세부사항은 [Liberty 문서](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ltpa.html)를 참조하십시오.

**참고:** 사용자 정의 구성을 추가하는 경우 여러 custom-configmaps를 포함하는 방법은 지원되지 않습니다. 대신, 다음과 같이 사용자 정의 구성 *configmap*을 작성하는 것이 좋습니다.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys --from-file=moreconfig.xml
```
