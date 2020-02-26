---
layout: tutorial
title: Helm을 사용하여 IBM Cloud Kubernetes Cluster에 Mobile Foundation 설정
breadcrumb_title: Foundation on Kubernetes using Helm
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Helm Chart를 사용하여 IBM Cloud Kubernetes Cluster(IKS)에서 {{ site.data.keys.mf_server }} 인스턴스, {{ site.data.keys.mf_push }}, {{ site.data.keys.mf_analytics }} 인스턴스, {{ site.data.keys.mf_app_center}} 인스턴스를 구성하려면 아래의 지시사항을 따르십시오.

다음은 시작할 기본 단계입니다.<br/>
* 전제조건 완료
* {{ site.data.keys.prod_icp }}용 {{ site.data.keys.product_full }}의 Passport Advantage 아카이브(PPA 아카이브) 다운로드
* IBM Cloud Kubernetes Cluster에서 PPA 아카이브 로드
* {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }}(선택사항), {{ site.data.keys.mf_app_center}}(선택사항) 구성 및 설치

#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [IBM Mobile Foundation Passport Advantage 아카이브 다운로드](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation Passport Advantage 아카이브 로드](#load-the-ibm-mfpf-ppa-archive)
* [환경 변수](#env-variables)
* [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)
* [Helm 차트 설치](#install-hmc-icp)
* [설치 확인](#verify-install)
* [샘플 애플리케이션](#sample-app)
* [{{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드](#upgrading-mf-helm-charts)
* [설치 제거](#uninstall)
* [문제점 해결](#troubleshooting)

## 전제조건
{: #prereqs}

[**IBM Cloud 계정**](http://cloud.ibm.com/)이 있어야 하며 [**IBM Cloud Kubernetes Cluster**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial)를 설정해야 합니다.

컨테이너 및 이미지를 관리하려면 IBM Cloud CLI 플러그인 설치의 일부로 호스트 시스템에 다음을 설치하십시오.

* IBM Cloud CLI(`ibmcloud`)
* Kubernetes CLI(`kubectl`)
* IBM Cloud Container 레지스트리 플러그인(`cr`)
* IBM Cloud Container 서비스 플러그인(`ks`)
* [Docker](https://docs.docker.com/install/) 설치 및 설정
* Helm(`helm`)
CLI를 사용하여 Kubernetes 클러스터에 대해 작업하려면 *ibmcloud* 클라이언트를 구성해야 합니다.
1. [클러스터 페이지](https://cloud.ibm.com/kubernetes/clusters)에 로그인하십시오. (참고: [IBM ID 계정](https://myibm.ibm.com/)이 필요합니다.)
2. IBM Mobile Foundation 차트를 배치할 Kubernetes 클러스터를 클릭하십시오.
3. 클러스터가 작성되면 **액세스** 탭의 지시사항을 따르십시오.
>**참고:** 클러스터 작성에는 몇 분 정도 걸립니다. 클러스터가 작성된 후 **작업자 노드** 탭을 클릭하고 *공인 IP*를 기록해 두십시오.

CLI를 사용하여 IBM Cloud Kubernetes Cluster에 액세스하려면 IBM Cloud 클라이언트를 구성해야 합니다. [자세히 알아보기](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).

## IBM Mobile Foundation Passport Advantage 아카이브 다운로드
{: #download-the-ibm-mfpf-ppa-archive}
{{ site.data.keys.product_full }}의 Passport Advantage(PPA) 아카이브는 [여기](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)에서 사용할 수 있습니다. {{ site.data.keys.product }}의 PPA 아카이브에는 다음 {{ site.data.keys.product }} 컴포넌트의 Docker 이미지 및 Helm Charts가 포함됩니다.
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

{{ site.data.keys.product_adj }} *DB 초기화* 컴포넌트가 사용되거나 데이터베이스 초기화 태스크를 활용합니다. 데이터베이스에서 Mobile Foundation 스키마 및 테이블(필수인 경우) 작성을 관리합니다(존재하지 않는 경우).

## IBM Mobile Foundation Passport Advantage 아카이브 로드
{: #load-the-ibm-mfpf-ppa-archive}

IBM Cloud Kubernetes Cluster에 PPA 아카이브를 로드하려면 아래에 제공된 단계를 따르십시오.

  1. IBM Cloud 플러그인을 사용하여 클러스터에 로그인하십시오. 명령 참조는 [IBM Cloud CLI 문서](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview)를 참조하십시오.

      예를 들어, 다음과 같습니다.
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
            연합 ID를 사용하는 경우 `--sso` 옵션을 포함하십시오. 선택적으로 위 명령에서 `--skip-ssl-validation` 플래그를 사용하여 SSL 유효성 검증을 건너뛸 수 있습니다. 그러면 HTTP 요청의 SSL 유효성 검증을 우회합니다. 이 매개변수를 사용하면 보안 문제가 발생할 수 있습니다.

  2. 다음 명령을 사용하여 IBM Cloud Container 레지스트리에 로그인하고 Container Service를 초기화하십시오.
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. 다음 명령을 사용하여 배치 영역을 설정하십시오(예: us-south)
      ```bash
      ibmcloud cr region-set
      ```  

  4. 아래 단계에 따라 클러스터에 대한 액세스 권한을 얻으십시오.

      1. 몇 가지 CLI 도구와 Kubernetes Service 플러그인을 다운로드 및 설치하십시오.
      ```bash
      curl -sL https://ibm.biz/idt-installer | bash
      ```

      2. 클러스터에 대한 kubeconfig 파일을 다운로드하십시오.
      ```bash
      ibmcloud ks cluster-config --cluster my_cluster_name
      ```

      3. *KUBECONFIG* 환경 변수를 설정하십시오. 이전 명령의 출력을 복사하여 터미널에 붙여넣으십시오. 명령 출력은 다음 예제와 유사합니다.
      ```bash
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/my_namespace/kube-config-dal10-my_namespace.yml
      ```

      4. 작업자 노드를 나열하여 클러스터에 연결할 수 있는지 확인하십시오.
      ```bash
      kubectl get nodes
      ```

  5. 다음 단계를 사용하여 {{ site.data.keys.product }}의 PPA 아카이브를 로드하십시오.
       1. PPA 아카이브 **추출**
       2. IBM Cloud Container 레지스트리 네임스페이스 및 올바른 버전으로 로드된 이미지에 **태그 지정**
       3. 이미지 **푸시**
       4. [선택사항] 작업자 노드가 아키텍처 조합에 기반한 경우(예: amd64, ppc64le, s390x) **Manifest 작성 및 푸시**

      다음은 **amd64** 아키텍처에 기반한 작업자 노드에 **mfpf-server** 및 **mfpf-push** 이미지를 로드하는 예입니다. **mfpf-appcenter** 및 **mfpf-analytics**에 대해 동일한 프로세스를 수행해야 합니다.

      ```bash

      # 1. PPA 아카이브 추출

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. IBM Cloud Container 레지스트리 네임스페이스 및 올바른 버전으로 로드된 이미지에 태그 지정

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0

      # 3. 모든 이미지 푸시

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 4. 추출된 아카이브 정리

      rm -rf ppatmp
      ```

      다음은 **다중 아키텍처**에 기반한 작업자 노드에 **mfpf-server** 및 **mfpf-push** 이미지를 로드하는 예입니다. **mfpf-appcenter** 및 **mfpf-analytics**에 대해 동일한 프로세스를 수행해야 합니다.

      ```bash
      # 1. PPA 아카이브 추출

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. IBM Cloud Container 레지스트리 네임스페이스 및 올바른 버전으로 로드된 이미지에 태그 지정

      ## 2.1 mfpf-server 태그 지정

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker tag mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker tag mfpf-server:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 2.2 mfpf-dbinit 태그 지정

      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker tag mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker tag mfpf-dbinit:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 2.3 mfpf-push 태그 지정

      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker tag mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker tag mfpf-push:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 3. 모든 이미지 푸시

      ## 3.1 mfpf-server 이미지 푸시

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 3.3 mfpf-dbinit 이미지 푸시

      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 3.3 mfpf-push 이미지 푸시

      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 4. [선택사항] Manifest 작성 및 푸시

      ## 4.1 manifest-lists 작성

      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      ## 4.2 Manifest 어노테이션 작성

      ### mfpf-server

      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le --os linux --arch ppc64le


      ### mfpf-dbinit

      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le --os linux --arch ppc64le


      ### mfpf-push

      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le --os linux --arch ppc64le

      ## 4.3 Manifest 목록 푸시

      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 5. 추출된 아카이브 정리

      rm -rf ppatmp
      ```

   >**참고:**
   > 1. `ibmcloud cr ppa-archive load` 명령 접근 방식은 다중 아키텍처 지원이 있는 PPA 패키지를 지원하지 않습니다. 그러므로 IBM Cloud Container 저장소에 수동으로 패키지를 추출하고 푸시해야 합니다(이전 PPA 버전을 사용하는 사용자는 로드에 다음 명령을 사용해야 함).

   > 2. 다중 아키텍처는 intel(amd64), power64(ppc64le), s390x를 포함한 아키텍처를 참조합니다. 다중 아키텍처는 ICP 3.1.1에서만 지원됩니다.

  ```bash
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
  ```
   {{ site.data.keys.product }}의 *archive_name*은 IBM Passport Advantage에서 다운로드한 PPA 아카이브의 이름입니다.

   helm 차트는 클라이언트 또는 로컬에 저장됩니다(IBM Cloud Private helm 저장소에 저장되는 ICP helm 차트와 다름). 차트는 `ppa-import/charts`(또는 charts) 디렉토리 내에 위치할 수 있습니다.

## IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성
{: #configure-install-mf-helmcharts}

{{ site.data.keys.mf_server }}를 설치 및 구성하기 전에 다음이 있어야 합니다.

이 절에서는 시크릿 작성 단계를 요약합니다.

시크릿 오브젝트를 사용하여 비밀번호, OAuth 토큰, ssh 키 등의 민감한 정보를 저장하고 다룰 수 있습니다. 이 정보를 시크릿에 두는 것은 팟(Pod) 정의 또는 컨테이너 이미지에 두는 것보다 더 안전하고 유연합니다.

* [**필수**] DB2 데이터베이스 인스턴스를 구성하고 사용할 준비가 되어야 합니다. [{{ site.data.keys.mf_server }} helm을 구성](#install-hmc-icp)하려면 데이터베이스 정보가 필요합니다. {{ site.data.keys.mf_server }}에는 스키마 및 테이블이 필요하며 없는 경우 이 데이터베이스에 작성됩니다.

* [**Mandatory**] Creating **database secrets** for Server, Push and Application Center.
이 절에서는 데이터베이스에 대한 액세스를 제어하기 위한 보안 메커니즘의 개요를 제공합니다. 지정된 하위 명령을 사용하여 시크릿을 작성하고 데이터베이스 세부사항 아래에 작성된 시크릿 이름을 제공하십시오.

Mobile Foundation 서버에 대한 데이터베이스 시크릿을 작성하려면 아래 코드 스니펫을 실행하십시오.

   ```bash
	# Create mfpserver secret
	cat <<EOF | kubectl apply -f -
	apiVersion: v1
	data:
	  MFPF_ADMIN_DB_USERNAME: encoded_uname
	  MFPF_ADMIN_DB_PASSWORD: encoded_password
	  MFPF_RUNTIME_DB_USERNAME: encoded_uname
	  MFPF_RUNTIME_DB_PASSWORD: encoded_password
	  MFPF_PUSH_DB_USERNAME: encoded_uname
	  MFPF_PUSH_DB_PASSWORD: encoded_password
	kind: Secret
	metadata:
	  name: mfpserver-dbsecret
	type: Opaque
	EOF
   ```

Application Center에 대한 데이터베이스 시크릿을 작성하려면 아래 코드 스니펫을 실행하십시오.

   ```bash
	# create appcenter secret
	cat <<EOF | kubectl apply -f -
	apiVersion: v1
	data:
	  APPCNTR_DB_USERNAME: encoded_uname
	  APPCNTR_DB_PASSWORD: encoded_password
	kind: Secret
	metadata:
	  name: appcenter-dbsecret
	type: Opaque
	EOF
   ```
   > 참고: 아래 명령을 사용하여 사용자 이름 및 비밀번호 세부사항을 인코딩할 수 있습니다.

   ```bash
	export $MY_USER_NAME=<myuser>
	export $MY_PASSWORD=<mypassword>

	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```


* [**필수**] 미리 작성한 **로그인 시크릿**이 Server, Analytics, Application Center 콘솔 로그인에 필요합니다. 예:

   ```bash
   kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
   ```

   Analytics의 경우:

   ```bash
   kubectl create secret generic analyticslogin --from-literal=ANALYTICS_ADMIN_USER=admin --from-literal=ANALYTICS_ADMIN_PASSWORD=admin
   ```

   Application Center의 경우:

   ```bash
   kubectl create secret generic appcenterlogin --from-literal=APPCENTER_ADMIN_USER=admin --from-literal=APPCENTER_ADMIN_PASSWORD=admin
   ```

   > 참고: 이러한 시크릿이 제공되지 않으면, Mobile Foundation helm 차트의 배치 동안 기본 사용자 이름과 비밀번호인 admin/admin을 사용하여 작성됩니다.

* [**선택사항**] 자체 키 저장소 및 신뢰 저장소가 있는 시크릿을 작성하여 자체 키 저장소 및 신뢰 저장소를 Server, Push, Analytics, Application Center 배치에 제공할 수 있습니다.

   리터럴 KEYSTORE_PASSWORD 및 TRUSTSTORE_PASSWORD를 사용하는 키 저장소 및 신뢰 저장소 비밀번호와 함께 `keystore.jks` 및 `truststore.jks`를 사용하여 시크릿을 사전 작성하고 시크릿 이름을 각 컴포넌트의 keystoreSecret 필드에 시크릿 이름을 제공하십시오.

   `keystore.jks`, `truststore.jks` 파일 및 비밀번호를 아래와 같이 보관하십시오.  

   예:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > 참고: 파일과 리터럴의 이름이 위 명령에서 언급될 때 동일해야 합니다. 이 시크릿 이름을 각 컴포넌트의 `keystoresSecretName` 입력 필드에 제공하여 helm 차트를 구성할 때 기본 키 저장소를 대체하십시오.

* [**선택사항**] Mobile Foundation 컴포넌트는 호스트 이름을 사용하여 도달하기 위해 외부 클라이언트에 대한 호스트 이름 기반 Ingress로 설정될 수 있습니다. Ingress는 TLS 개인 키와 인증을 사용하여 보호될 수 있습니다. TLS 개인 키와 인증은 키 이름 `tls.key` 및 `tls.crt`를 가진 시크릿에서 정의되어야 합니다.

   **mf-tls-secret** 시크릿은 다음 명령을 사용하여 Ingress 자원과 동일한 네임스페이스에 작성해야 합니다.

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   그런 다음 시크릿의 이름 및 ingress 호스트 이름이 global.ingress.secret 필드에서 제공됩니다. **values.yaml**을 수정하여 helm 차트를 배치하는 데 적합한 ingress 호스트 이름 및 ingress 시크릿 이름을 추가하십시오.

   > 참고: 기타 Helm 릴리스에 대해 이미 사용되고 있으면 동일한 ingress 호스트 이름을 사용하지 마십시오.

* [**선택사항**] Mobile Foundation Server는 Admin Service의 기밀 클라이언트로 사전 정의됩니다. 이러한 클라이언트의 신임 정보는 `mfpserver.adminClientSecret` 및 `mfpserver.pushClientSecret` 필드에서 제공됩니다.

   이러한 시크릿은 다음과 같이 작성될 수 있습니다.
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > 참고: `mfpserver.pushClientSecret` 및 `mfpserver.adminClientSecret` 필드에 대한 값이 Mobile Foundation helm 차트 배치 동안 제공되지 않으면 기본 auth ID/클라이언트 시크릿인 `admin / nimda`(`mfpserver.adminClientSecret`의 경우) 및 `push / hsup`(`mfpserver.pushClientSecret`의 경우)가 생성되어 사용됩니다.

* [**필수**] Mobile Foundation Analytics Chart 설치를 시작하기 전에 지속적 볼륨 및 지속적 볼륨 청구를 적절히 구성하십시오. Mobile Foundation Analytics를 구성하려면 지속적 볼륨을 제공하십시오. [지속적 볼륨을 작성하기 위한 IBM Cloud Kubernetes 문서](https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_storage)에서 자세히 설명하는 단계를 따르십시오.


## 환경 변수
{: #env-variables }
아래 표에서는 {{ site.data.keys.mf_server }} 인스턴스, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }}, {{ site.data.keys.mf_app_center }}에서 사용되는 환경 변수를 제공합니다

| 규정자 |매개변수 | 정의 | 허용값 |
|-----------|-----------|------------|---------------|
| ***`글로벌 구성`*** | |  |  |
| arch | amd64 | 하이브리드 클러스터에서의 amd64 작업자 노드 스케줄러 선호사항 | 3 - 가장 선호(기본값). |
|  | ppcle64 | 하이브리드 클러스터에서의 ppc64le 작업자 노드 스케줄러 선호사항 | 2 - 선호사항 없음(기본값). |
|  | s390x | 하이브리드 클러스터에서의 S390x 작업자 노드 스케줄러 선호사항 | 2 - 선호사항 없음(기본값). |
| image | pullPolicy |이미지 가져오기 정책 | 기본값은 **IfNotPresent**입니다. |
|  | pullSecret | 이미지 가져오기 시크릿 |  |
| ingress | hostname | 외부 클라이언트에서 사용할 외부 호스트 이름 또는 IP 주소 | 앱에 공용 또는 개인용 요청을 전달하여 클러스터에서 네트워크 트래픽 워크로드 균형 조절 |
|  | secret | TLS 시크릿 이름 | Ingress 정의에서 사용해야 하는 인증서의 스크릿 이름을 지정합니다. 시크릿은 관련 인증서 및 키를 사용하여 사전에 작성해야 합니다. SSL/TLS를 사용하는 경우 필수입니다. 여기에 이름을 제공하기 전에 인증서 & 키를 사용하여 시크릿을 사전에 작성하십시오. |
|  | sslPassThrough | SSL 패스스루 사용 | Mobile Foundation 서비스로 SSL 요청을 패스스루해야 하는지 여부를 지정합니다. Mobile Foundation 서비스에서 SSL이 종료됩니다. 기본값: false |
| https | true |  |  |
| dbinit | enabled | Server, Push, Application Center 데이터베이스 초기화 사용 | Server, Push, Application Center 배치의 경우 데이터베이스를 초기화하고 스키마/테이블을 작성합니다(Analytics의 경우 필요하지 않음). 기본값: true |
| | repository | 데이터베이스 초기화를 위한 Docker 이미지 저장소 | Mobile Foundation 데이터베이스 Docker 이미지의 저장소 |
|  | tag | Docker 이미지 태그 | Docker 태그 설명 참조 |
|  | replicas | 작성해야 하는 Mobile Foundation DBinit 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 1) |
| ***`MFP Server 구성`*** | | | |
| mfpserver | enabled | Server를 사용하도록 플래그 지정 | true(기본값) 또는 false |
|  | repository | Docker 이미지 저장소 | Mobile Foundation Server Docker 이미지 저장소 |
|  | tag | Docker 이미지 태그 | Docker 태그 설명 참조 |
|  | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인 |
|  db | host | Mobile Foundation Server 테이블을 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름. | IBM DB2®(기본값). |
| | port |데이터베이스가 설정되는 포트 | |
| | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
| | name | Mobile Foundation Server 데이터베이스의 이름 | |
|  | schema | 작성할 서버 DB 스키마. | 스키마가 이미 있으면 이를 사용합니다. 그렇지 않으면 작성됩니다. |
|  | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값: false(http). 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
| adminClientSecret | 시크릿 이름 지정 | Admin 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [참조](#configure-install-mf-helmcharts) |
| pushClientSecret | 시크릿 이름 지정 | Push 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [참조](#configure-install-mf-helmcharts) |
| internalConsoleSecretDetails | consoleUser: "admin" |  |  |
|  | consolePassword: "admin" |  |  |
| internalClientSecretDetails | adminClientSecretId: admin |  |  |
| | adminClientSecretPassword: nimda |  |  |
| | pushClientSecretId: push |  |  |
| | pushClientSecretPassword: hsup |  |  |
| replicas |3 | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 3) |
| autoscaling | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicas 필드를 사용하지 않습니다. | false(기본값) 또는 true |
| | min  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
| | max | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. 최소값보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
| | targetcpu | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| pdb | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
| | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| ***`MFP Push 구성`*** | | | |
| mfppush | enabled | Mobile Foundation Push를 사용하도록 플래그 지정 | true(기본값) 또는 false |
|           | repository | Docker 이미지 저장소 |Mobile Foundation Push Docker 이미지의 저장소 |
|           | tag | Docker 이미지 태그 | Docker 태그 설명 참조 |
| replicas | | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 3) |
| autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | min  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | max | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetcpu | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| | keystoresSecretName | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| ***`MFP Analytics 구성`*** | | | |
| mfpanalytics | enabled          | Analytics를 사용하도록 플래그 지정 | false(기본값) 또는 true |
| image | repository          | Docker 이미지 저장소 | Mobile Foundation Operational Analytics Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인|
| replicas |  | 작성해야 하는 Mobile Foundation Operational Analytics의 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 2) |
| autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | min  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | max | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetcpu | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
|  shards|  | Mobile Foundation Analytics에 대한 Elasticsearch 샤드 수 | 기본값: 2|             
| replicasPerShard|  |Mobile Foundation Analytics에 대해 각 샤드당 유지보수할 Elasticsearch 복제본 수 | 기본값: 2|
| persistence | enabled | 데이터를 지속하기 위해 PersistentVolumeClaim 사용                        | true |                                                 |
|  |useDynamicProvisioning | storageclass를 지정하거나 비어두기  | false  |                                                  |
| |volumeName| 볼륨 이름 제공  | data-stor(기본값) |
|   |claimName| 기존 PersistentVolumeClaim 제공  | nil |
|   |storageClassName     | PersistentVolumeClaim을 지원하는 스토리지 클래스 | nil |
|   |size    | 데이터 볼륨 크기      | 20Gi |
| pdb  | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|   | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| jndiConfigurations | mfpfProperties | 운영 분석을 사용자 정의하기 위해 지정할 Mobile Foundation JNDI 특성| 쉼표로 구분된 이름 값 쌍 제공  |
|  | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|   | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|   | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|   | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| ***`MFP Application Center 구성`*** | | | |
| mfpappcenter | enabled          | Application Center를 사용하도록 플래그 지정 | false(기본값) 또는 true |  
| image | repository          | Docker 이미지 저장소 | Mobile Foundation Application Center Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인|
| db | host | Appcenter 데이터베이스에서 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름	| |
|   | port | 	데이터베이스 포트  | |             
| | name | 사용할 데이터베이스의 이름 | 데이터베이스가 사전에 작성되어야 합니다.|
|   | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
|   | schema | 작성할 Application Center 데이터베이스 스키마. | 스키마가 이미 있으면 이를 사용합니다. 없으면 작성됩니다. |
|   | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값: false(http). 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
| autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | min  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | max | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetcpu | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
|  | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  |기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  |기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |


> Kibana를 사용한 {{ site.data.keys.prod_adj }} 로그 분석에 대한 학습서는 [여기](analyzing-mobilefirst-logs-on-icp/)를 참조하십시오.

## Helm 차트 설치
{: #install-hmc-icp}

### {{ site.data.keys.mf_analytics }} 설치
{: #install-mf-analytics}

{{ site.data.keys.mf_analytics }} 설치는 선택사항입니다. {{ site.data.keys.mf_server }}에서 Analytics를 사용으로 설정하려면 {{ site.data.keys.mf_server }}를 설치하기 전에 {{ site.data.keys.mf_analytics }}를 먼저 구성하고 설치해야 합니다.

설치를 시작하기 전에 ***[IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성]***(#configure-install-mf-helmcharts) 아래 모든 **필수** 절을 처리했는지 확인하십시오.

아래 단계에 따라 IBM Cloud Kubernetes Cluster에서 IBM {{ site.data.keys.mf_analytics }}를 설치 및 구성하십시오.

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
    helm inspect values ibm-mfpf-analytics-prod-2.0.0.tgz > values.yaml
    ```    

3. **values.yaml**을 수정하여 helm 차트를 배치하기 전에 적절한 값을 추가하십시오. 데이터베이스 세부사항, ingress 호스트 이름, 시크릿 등이 추가되었는지 확인하고 values.yaml을 저장하십시오.

자세한 정보는 [환경 변수](#env-variables) 절을 참조하십시오.

4. helm 차트를 배치하려면 다음 명령을 실행하십시오.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Analytics Server 배치를 위한 예제:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-2.0.0.tgz
    ```    

### {{ site.data.keys.mf_server }} 설치
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
    helm inspect values ibm-mfpf-server-prod-2.0.0.tgz > values.yaml
    ```

3. **values.yaml**을 수정하여 helm 차트를 배치하는 데 적합한 값을 추가하십시오. 데이터베이스 세부사항, 수신(ingress), 스케일링 등이 추가되었는지 확인하고 values.yaml을 저장하십시오.

4. helm 차트를 배치하려면 다음 명령을 실행하십시오.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    서버 배치를 위한 예제:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-2.0.0.tgz
    ```

>**참고:** AppCenter를 설치하려면 해당 helm 차트(예: ibm-mfpf-appcenter-prod-2.0.0.tgz.tgz)를 사용하여 위의 단계를 수행해야 합니다.

## 설치 확인
{: #verify-install}

Mobile Foundation 컴포넌트를 설치 및 구성한 후에 IBM Cloud CLI, Kubernetes CLI, helm 명령을 사용하여 배치된 팟(Pod)의 상태 및 설치를 확인할 수 있습니다.

IBM Cloud CLI 문서의 [CLI 명령 참조서](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)와 [Helm 문서](https://docs.helm.sh/helm/)의 Helm CLI를 참조하십시오.

IBM Cloud Portal의 IBM Cloud Kubernetes Cluster 페이지에서 **Kubernetes 대시보드** 단추를 사용하여 Kubernetes 콘솔을 열어 클러스터 아티팩트를 관리할 수 있습니다.

## {{ site.data.keys.prod_adj }} 콘솔 액세스
{: #access-mf-console}

설치 완료 후 `<protocol>://<public_ip>:<node_port>/mfpconsole`을 사용하여 {{ site.data.keys.prod_adj }} Operational Console에 액세스할 수 있습니다.<br/>
IBM {{ site.data.keys.mf_analytics }} 콘솔은 `<protocol>://<public_ip>:<port>/analytics/console`을 사용하여 액세스할 수 있습니다.
프로토콜은 `http` 또는 `https`일 수 있습니다. 또한 **NodePort** 배치의 경우 포트는 **NodePort**가 됩니다. 설치된 {{ site.data.keys.prod_adj }} Chart의 IP 주소 및 **NodePort**를 가져오려면 Kubernetes 대시보드에서 아래의 단계를 따르십시오.
* **공인 IP**를 얻으려면 공인 IP 아래에서 **Kubernetes** > **작업자 노드** >를 선택하십시오. IP 주소를 기록해 두십시오.
* **노드 포트**는 **Kubernetes 대시보드**에서 찾을 수 있습니다. > **내부 엔드포인트** 아래의 **서비스**를 선택하고 > *TCP 노드 포트*(다섯 자리 숫자 포트) 입력에 주의하십시오.

콘솔에 액세스하기 위한 *NodePort* 방법 이외에, [수신](https://console.bluemix.net/docs/containers/cs_ingress.html) 호스트를 통해서도 서비스에 액세스할 수 있습니다.

콘솔에 액세스하려면 아래의 단계를 따르십시오.

1. [**IBM Cloud Dashboard**](https://console.bluemix.net/dashboard/apps/)로 이동하십시오.
2. `Analytics/Server/AppCenter`가 배치된 **Kubernetes Cluster**를 선택하고 **개요** 페이지를 여십시오.
3. 수신 호스트 이름의 수신 서브도메인을 찾아 다음과 같이 콘솔에 액세스하십시오.
    * 다음을 사용하여 IBM Mobile Foundation Operational Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/mfpconsole`
    * 다음을 사용하여 IBM Mobile Foundation Analytics Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/analytics/console`
    * 다음을 사용하여 IBM Mobile Foundation Application Center Console에 액세스하십시오.
     `<protocol>://<ingress-hostname>/appcenterconsole`
4. SSL 서비스 지원은 기본적으로 nginx ingress에서 사용 안함으로 설정됩니다. https를 통해 콘솔에 연결하는 동안 연결성에 주의해야 할 수도 있습니다. 아래 단계에 따라 ingress에서 SSL 서비스를 사용으로 설정하십시오.
    1. IBM Cloud Kubernetes Cluster 페이지에서 Kubernetes 대시보드 실행
    2. 왼쪽 패널에서 옵션 Ingress 클릭
    3. Ingress 이름 선택
    4. 맨 위 오른쪽에서 편집 단추 클릭
    5. yaml 파일 수정 및 ssl-services 주석 추가
    예:

    ```bash
    "annotations": {
      "ingress.bluemix.net/ssl-services": "ssl-service=my_service_name1;ssl-service=my_service_name2",
      .....
      ....
      ...
      ...
    }
    ```
   6. 업데이트 클릭

>**참고:** 포트 9600은 Kubernetes 서비스에서 내부적으로 노출되며 {{ site.data.keys.prod_adj }} Analytics 인스턴스가 전송 포트로 사용됩니다.

## 샘플 애플리케이션
{: #sample-app}
샘플 어댑터를 배치하고 IBM Cloud Kubernetes Cluster에서 실행되는 IBM {{ site.data.keys.mf_server }}에서 샘플 애플리케이션을 실행하려면 [{{ site.data.keys.prod_adj }} 학습서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)를 참조하십시오.

## {{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드
{: #upgrading-mf-helm-charts}

helm 차트/릴리스 업그레이드 방법에 대한 지시사항은 [번들 제품 업그레이드](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/upgrade_helm.html)를 참조하십시오.

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

## 문제점 해결
{: #troubleshooting}

이 절에서는 Mobile Foundation을 배치하는 동안 발생할 수 있는 오류 시나리오를 식별하고 해결하는 과정을 안내합니다.

1. Helm 설치에 실패합니다. `Error: could not find a ready tiller pod`

 - 아래 명령 세트를 그대로 실행하여 Helm 설치 재시도
  ```bash
  helm init
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm init --service-account tiller --upgrade
  ```

2. Helm Chart를 배치하는 중 이미지를 가져올 수 없음 - `Failed to pull image, Error: ErrImagePull`

 - 이미지 pullSecret이 Helm 배치 전에 values.yaml에 추가되었는지 확인하십시오. 이미지 가져오기 시크릿이 존재하지 않는 경우 가져오기 시크릿을 작성하고 *values.yaml* 파일의 `image.pullSecret`에 지정하십시오.

 가져오기 시크릿을 작성하는 예:

  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  ```

  > 참고: 인증을 위해 BM Cloud API 키를 사용하는 경우 `--docker-username=iamapikey` 값을 그대로 유지하십시오.

3. ingress를 통해 콘솔에 액세스하는 동안 연결성 문제

 - 문제를 해결하려면 Kubernetes 대시보드에 실행하고 옵션 'Ingresses'를 선택하십시오. Ingress yaml을 편집하고 아래와 같이 Ingress 호스트 세부사항을 추가하십시오.

    예:
    ```

      "spec": {
"tls": [
         {
           "hosts": [
             “ingress_host_name”
           ],
           "secretName": "ingress-secret-name"
         }
       ],
       "rules": [
         {
        ….
	….
     ```
