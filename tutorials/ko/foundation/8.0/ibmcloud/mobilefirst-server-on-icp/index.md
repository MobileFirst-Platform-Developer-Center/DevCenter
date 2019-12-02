---
layout: tutorial
title: IBM Cloud Private에 IBM Mobile Foundation 설치
breadcrumb_title: Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server }} 인스턴스, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} 및 {{ site.data.keys.mf_app_center}} 인스턴스를 {{ site.data.keys.prod_icp }}에 구성하려면 아래 지시사항에 따르십시오.

* 전제조건 완료
* {{ site.data.keys.prod_icp }}용 {{ site.data.keys.product_full }}의 Passport Advantage 아카이브(PPA 아카이브) 다운로드
* {{ site.data.keys.prod_icp }} 클러스터의 PPA 아카이브 로드
* {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }}(선택사항), {{ site.data.keys.mf_push }}(선택사항) 및 {{ site.data.keys.mf_app_center }}(선택사항) 구성 및 설치

#### 다음으로 이동:
{: #jump-to }
* [전제조건](#prereqs)
* [IBM Mobile Foundation Passport Advantage 아카이브 다운로드](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation Passport Advantage 아카이브 로드](#load-the-ibm-mfpf-ppa-archive)
* [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)
* [필수 리소스](#resources-required)
* [설치 확인](#verify-install)
* [샘플 애플리케이션](#sample-app)
* [{{ site.data.keys.prod_adj }} Helm Charts 및 릴리스 업그레이드](#upgrading-mf-helm-charts)
* [Mobile Foundation 플랫폼용 IBM Certified Cloud Pak으로 마이그레이션](#migrate)
* [MFP 분석 데이터 백업 및 복구](#backup-analytics)
* [설치 제거](#uninstall)

## 전제조건
{: #prereqs}

{{ site.data.keys.prod_icp }} 계정이 있어야 하며 [{{ site.data.keys.prod_icp }} 클러스터를 설정](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup)해야 합니다.

컨테이너 및 이미지를 관리하려면 {{ site.data.keys.prod_icp }} 설치의 일부로 호스트 시스템에 다음을 설치해야 합니다.

* [Docker](https://docs.docker.com/install/) 설치 및 설정
* [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started)(`cloudctl`)
* [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)(`kubectl`)
* [Helm](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_helm_cli.html)(`helm`)

> 지원되는 Docker CLI 버전을 [여기](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/supported_system_config/supported_docker.html)에서 찾으십시오.

> 사용자의 ICP 클러스터에서와 동일한 Kube CLI, IBM Cloud CLI 및 Helm 버전을 설치하십시오. IBM Cloud Private 관리 콘솔에서 다운로드하십시오. **메뉴 > 명령행 도구 > Cloud Private CLI**를 클릭하십시오.

예:

IBM Cloud Private에 시크릿, 지속적 볼륨(PV) 및 지속적 볼륨 청구(PVC)와 같은 Kubernetes 아티팩트를 작성하려면 `kubectl` CLI가 필수입니다.

a. IBM Cloud Private 관리 콘솔에서 `kubectl` 도구를 설치하십시오. **메뉴 > 명령행 도구 > Cloud Private CLI**을 클릭하십시오.

b. `curl` 명령을 사용하여 설치 프로그램을 다운로드하려면 **Kubernetes CLI 설치**를 펼치십시오. 운영 체제에 대한 curl 명령을 복사하고 실행한 다음 설치 프로시저를 계속하십시오.

c. 적용 가능한 운영 체제에 대한 curl 명령을 선택하십시오. 예를 들면, macOS에 대해 다음 명령을 실행할 수 있습니다.

   ```bash
   curl -kLo <install_file> https://<cluster ip>:<port>/api/cli/kubectl-darwin-amd64
   chmod 755 <path_to_installer>/<install_file>
   sudo mv <path_to_installer>/<install_file> /usr/local/bin/kubectl
   ```
참조: [Kubernetes CLI(kubectl) 설치](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/manage_cluster/install_kubectl.html)

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
{{ site.data.keys.product }}의 PPA 아카이브를 로그하기 전에 Docker를 설치해야 합니다. [여기](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html)에서 지시사항을 확인하십시오.

PPA 아카이브를 {{ site.data.keys.prod_icp }} 클러스터에 로드하려면 아래에 제공된 단계를 따르십시오.

  1. IBM Cloud ICP 플러그인(`cloudctl`)을 사용하여 클러스터에 로그인하십시오.
      >{{ site.data.keys.prod_icp }} 문서의 [CLI 명령 참조서](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html)를 확인하십시오.

     예를 들어, 다음과 같습니다.

     ```bash
     cloudctl login -a https://ip:port
     ```
      선택적으로 SSL 유효성 검증을 건너뛰려면 위의 명령에서 `--skip-ssl-validation` 플래그를 사용하십시오. 이 옵션을 사용하면 클러스터 엔드포인트의 `username` 및 `password`에 대한 프롬프트가 표시됩니다. 로그인이 성공하면 아래의 단계를 진행하십시오.

  2. 다음 명령을 사용하여 {{ site.data.keys.product }}의 PPA 아카이브를 로드하십시오.
     ```
     cloudctl catalog load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
     ```
     {{ site.data.keys.product }}의 *archive_name*은 IBM Passport Advantage에서 다운로드한 PPA 아카이브의 이름입니다.

     이전 단계를 수행하고 클러스터 엔드포인트를 `cloudctl`의 기본값으로 설정한 경우 `--clustername`은 무시할 수 있습니다.

  3.  {{ site.data.keys.prod_icp }} 관리 콘솔에서 Docker 이미지 및 Helm Charts를 보십시오.
      Docker 이미지를 보려면 다음과 같이 하십시오.
      * **플랫폼 > 컨테이너 이미지**를 선택하십시오.
      * Helm Charts가 **카탈로그**에 표시됩니다.

  위의 단계를 완료하면 {{ site.data.keys.prod_adj }} Helm Charts의 업로드된 버전이 ICP 카탈로그에 표시됩니다. {{ site.data.keys.mf_server }}가 **ibm-mobilefoundation-prod**로 나열됩니다.

## IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성
{: #configure-install-mf-helmcharts}

{{ site.data.keys.mf_server }}를 설치 및 구성하기 전에 다음이 있어야 합니다.

이 절에서는 시크릿 작성 단계를 요약합니다.

시크릿 오브젝트를 사용하여 비밀번호, OAuth 토큰, ssh 키 등의 민감한 정보를 저장하고 다룰 수 있습니다. 이 정보를 시크릿에 두는 것은 팟(Pod) 정의 또는 컨테이너 이미지에 두는 것보다 더 안전하고 유연합니다.

1. (필수)사전 구성된 데이터베이스는 Mobile Foundation 서버와 Application Center 컴포넌트의 기술 데이터를 저장하는 데 필요합니다.

   아래 지원되는 DBMS 중 하나를 사용해야 합니다.

     1. **IBM DB2**
     2. **MySQL**
     3. **Oracle**

   ***Oracle 또는 MySQL 데이터베이스***를 사용 중인 경우 아래 단계를 수행하십시오.

   - Oracle 및 MySQL용 JDBC 드라이버는 Mobile Foundation 설치 프로그램에 포함되지 않습니다. JDBC 드라이버가 있는지 확인하십시오(MySQL의 경우, 커넥터/J JDBC 드라이버를 사용하고 Oracle의 경우, Oracle 씬 JDBC 드라이버를 사용하십시오). 마운트된 볼륨을 작성하고 JDBC 드라이버를 `/nfs/share/dbdrivers` 위치에 배치하십시오.

   - NFS 호스트 세부사항과 JDBC 드라이버가 저장되는 경로를 제공하여 지속적 볼륨(PV)을 작성하십시오. 다음은 `PersistentVolume.yaml` 샘플입니다.
      ```
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        labels:
          name: mfppvdbdrivers
        name: mfppvdbdrivers
      spec:
        accessModes:
        - ReadWriteMany
        capacity:
          storage: 20Gi
        nfs:
          path: <nfs_path>
          server: <nfs_server>
       EOF
      ```
      > 참고: 위 yaml에서 <nfs_server> <nfs_path> 항목을 추가하는지 확인하십시오.

    - 지속적 볼륨 청구(PVC)를 작성하고 배치되는 동안 Helm 차트에 PVC 이름을 제공하십시오. 다음은 `PersistentVolumeClaim.yaml` 샘플입니다.
      ```bash
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: mfppvc
        namespace: my_namespace
      spec:
        accessModes:
        - ReadWriteMany
        resources:
          requests:
             storage: 20Gi
        selector:
          matchLabels:
            name: mfppvdbdrivers
        volumeName: mfppvdbdrivers
      status:
        accessModes:
        - ReadWriteMany
        capacity:
          storage: 20Gi
      EOF
      ```
   >NOTE: 위 yaml에 올바른 네임스페이스를 추가했는지 확인하십시오.

2. (필수)미리 작성한 **로그인 시크릿**이 서버, Analytics 및 Application Center 콘솔 로그인에 필요합니다. 예:

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

3. (선택사항)자체 키 저장소 및 신뢰 저장소가 있는 시크릿을 작성하여 자체 키 저장소 및 신뢰 저장소를 서버, 푸시, Analytics 및 Application Center 배치에 제공할 수 있습니다.

   리터럴 KEYSTORE_PASSWORD 및 TRUSTSTORE_PASSWORD를 사용하는 키 저장소 및 신뢰 저장소 비밀번호와 함께 `keystore.jks` 및 `truststore.jks`를 사용하여 시크릿을 사전 작성하고 시크릿 이름을 각 컴포넌트의 keystoreSecret 필드에 시크릿 이름을 제공하십시오.

   `keystore.jks`, `truststore.jks` 파일 및 비밀번호를 아래와 같이 보관하십시오.  

   예:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > 참고: 파일과 리터럴의 이름이 위 명령에서 언급될 때 동일해야 합니다.	이 시크릿 이름을 각 컴포넌트의 `keystoresSecretName` 입력 필드에 제공하여 helm 차트를 구성할 때 기본 키 저장소를 대체하십시오.

4. (선택사항) Mobile Foundation 컴포넌트는 호스트 이름을 사용하여 도달하기 위해 외부 클라이언트에 대한 호스트 이름 기반 Ingress로 설정될 수 있습니다. Ingress는 TLS 개인 키와 인증을 사용하여 보호될 수 있습니다. TLS 개인 키와 인증은 키 이름 `tls.key` 및 `tls.crt`를 가진 시크릿에서 정의되어야 합니다.

   **mf-tls-secret** 시크릿은 다음 명령을 사용하여 Ingress 자원과 동일한 네임스페이스에 작성됩니다.

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   그런 다음 시크릿의 이름이 global.ingress.secret 필드에서 제공됩니다.

   > 참고: 기타 helm 릴리스에 대해 이미 사용되고 있으면 동일한 ingress 호스트 이름을 사용하지 마십시오.

5. (선택사항) 구성을 사용자 정의하려면(예: 로그 추적 설정 수정, 새 jndi 특성 추가 등) 구성 XML 파일을 사용하여 configmap을 사용해야 합니다. 이렇게 하면 새 구성 설정을 추가하거나 Mobile Foundation 컴포넌트의 기존의 구성을 대체할 수 있습니다.

    사용자 정의 구성은 다음과 같이 작성될 수 있는 configMap(mfpserver 사용자 정의 구성)을 통하여 Mobile Foundation 컴포넌트에 의해 액세스됩니다.

	```bash
	kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
	```

    Mobile Foundation을 배치하는 동안 Helm 차트에서 **사용자 정의 서버 구성**에서 제공되는 configmap은 위의 명령을 사용하여 작성했습니다.

    mfpserver 사용자 정의 구성 configmap을 사용하여 warning(기본 설정은 info)으로 추적 로그 스펙을 설정하는 예는 아래와 같습니다.

    - 샘플 구성 XML(logging.xml)

	```bash
    <server>
          <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
          maxFileSize="20" />
    </server>
	```

    - configmap을 작성한 후 helm 차트 배치 동안 동일 항목 추가

	```bash
    kubectl create configmap mfpserver-custom-config --from-file=logging.xml
	```

    - Mobile Foundation 컴포넌트의 messages.log에서 변경에 주의하십시오. ***Property traceSpecification will be set to com.ibm.mfp.=debug:\*=warning.***

6. (선택사항)Mobile Foundation 서버는 Admin Service를 위한 기밀 클라이언트로 사전 정의됩니다. 이러한 클라이언트의 신임 정보는 `mfpserver.adminClientSecret` 및 `mfpserver.pushClientSecret` 필드에서 제공됩니다.

   이러한 시크릿은 다음과 같이 작성될 수 있습니다.

   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > 참고: `mfpserver.pushClientSecret` 및 `mfpserver.adminClientSecret` 필드에 대한 값이 Mobile Foundation helm 차트 배치 동안 제공되지 않으면 기본 auth ID/클라이언트 시크릿인 `admin / nimda`(`mfpserver.adminClientSecret`의 경우) 및 `push / hsup`(`mfpserver.pushClientSecret`의 경우)가 생성되어 사용됩니다.

7. Analytics 배치의 경우 지속적인 분석 데이터에 대한 옵션 아래에서 하나를 선택할 수 있습니다.

    a) `Persistent Volume(PV)`과 `Persistent Volume Claim(PVC)`을 준비하고 helm 차트에서 PVC 이름을 제공합니다.

      예:

      샘플 `PersistentVolume.yaml`

      ```bash
	apiVersion: v1
	kind: PersistentVolume
	metadata:
	  labels:
	    name: mfvol
	  name: mfvol
	spec:
	  accessModes:
	  - ReadWriteMany
	  capacity:
	    storage: 20Gi
	  nfs:
	    path: <nfs_path>
	    server: <nfs_server>
      ```

    > 참고: 위 yaml에 <nfs_server> 및 <nfs_path> 항목을 추가했는지 확인하십시오.

      샘플 `PersistentVolumeClaim.yaml`

      ```bash
	apiVersion: v1
	kind: PersistentVolumeClaim
	metadata:
	  name: mfvolclaim
	  namespace: <namespace>
	spec:
	  accessModes:
	  - ReadWriteMany
	  resources:
	    requests:
	      storage: 20Gi
	  selector:
	    matchLabels:
	      name: mfvol
	  volumeName: mfvol
	status:
	  accessModes:
	  - ReadWriteMany
	  capacity:
	    storage: 20Gi
	```

    > 위 yaml에 올바른 <네임스페이스>를 추가했는지 확인하십시오.

    b) 차트에서 동적 프로비저닝을 선택하십시오.

8. (필수) 서버, 푸시 및 Application Center에 대한 **데이터베이스 시크릿**을 작성합니다.
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

   이 절에서는 데이터베이스에 대한 액세스를 제어하기 위한 보안 메커니즘의 개요를 제공합니다. 지정된 하위 명령을 사용하여 시크릿을 작성하고 데이터베이스 세부사항 아래에 작성된 시크릿 이름을 제공하십시오.

9. (선택사항) 별도의 데이터베이스 Admin 시크릿이 제공될 수 있습니다. 데이터베이스 Admin 시크릿에서 제공된 사용자 세부사항은 DB 초기화 태스크를 실행하는 데 사용되며 차례로 데이터베이스에서 필요한 Mobile Foundation 스키마와 테이블을 작성합니다(존재하지 않는 경우에 한함). 데이터베이스 Admin 시크릿을 통해 데이터베이스 인스턴스에서 DDL 오퍼레이션을 제어할 수 있습니다.

    `MFP Server DB Admin Secret` 및 `MFP Appcenter DB Admin Secret` 세부사항이 제공되지 않으면, 기본 `Database Secret Name`이 DB 초기화 태스크를 수행하는 데 사용됩니다.

    Mobile Foundation 서버에 대한 `MFP Server DB Admin Secret`을 작성하려면 아래 코드 스니펫을 실행하십시오.

      ```bash
      # Create MFP Server Admin DB secret update the same in the Helm chart while deploying Mobile Foundation server component
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      data:
        MFPF_ADMIN_DB_ADMIN_USERNAME: encoded_uname
        MFPF_ADMIN_DB_ADMIN_PASSWORD: encoded_password
        MFPF_RUNTIME_DB_ADMIN_USERNAME: encoded_uname
        MFPF_RUNTIME_DB_ADMIN_PASSWORD: encoded_password
        MFPF_PUSH_DB_ADMIN_USERNAME: encoded_uname
        MFPF_PUSH_DB_ADMIN_PASSWORD: encoded_password
      kind: Secret
      metadata:
        name: mfpserver-dbadminsecret
      type: Opaque
      EOF
      ```

    Mobile Foundation 서버에 대한 `MFP Appcenter DB Admin Secret`을 작성하려면 아래 코드 스니펫을 실행하십시오.      

      ```bash
      # Create Appcenter Admin DB secret and update the same in the Helm chart while deploying Mobile Foundation AppCenter   component
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      data:
        APPCNTR_DB_ADMIN_USERNAME: encoded_uname
        APPCNTR_DB_ADMIN_PASSWORD: encoded_password
      kind: Secret
      metadata:
      name: appcenter-dbadminsecret
      type: Opaque
      EOF
      ```

10. (선택사항) IBM Cloud Privat 설정의 컨테이너 레지스트리(DockerHub, 개인용 Docker 레지스트리 등) 외부에 있는 레지스트리에서 컨테이너 이미지를 가져오는 경우 컨테이너 **이미지 정책** 및 **이미지 가져오기 시크릿**을 작성하십시오.

   ```bash
	# Create image policy
	cat <<EOF | kubectl apply -f -
	apiVersion: securityenforcement.admission.cloud.ibm.com/v1beta1
	kind: ImagePolicy
	metadata:
	 name: image-policy
	 namespace: <namespace>
	spec:
	 repositories:
	 - name: docker.io/*
	   policy: null
	 - name: <container-image-registry-hostname>/*
	   policy: null
	EOF
   ```

   ```bash
   kubectl create secret docker-registry -n <namespace> <container-image-registry-hostname> --docker-username=<docker-registry-username> --docker-password=<docker-registry-password>
   ```

   > 참고: < > 내 텍스트는 올바른 값으로 업데이트해야 합니다.


   자세한 정보는 [MobileFirst Server 키 저장소 구성]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오.

### PodSecurityPolicy 요구사항

이 차트는 배치 전에 대상 네임스페이스에 PodSecurityPolicy를 바인드해야 합니다. 사전 정의된 PodSecurityPolicy를 선택하거나 클러스터 관리자에게 대신 사용자 정의 PodSecurityPolicy를 작성해줄 것을 요청하십시오.

* 사전 정의된 PodSecurityPolicy 이름: [`ibm-restricted-psp`](https://ibm.biz/cpkspec-psp)
* 사용자 정의 PodSecurityPolicy 정의:

    ```bash
	apiVersion: extensions/v1beta1
	kind: PodSecurityPolicy
	metadata:
	  name: ibm-mobilefoundation-prod-psp
	  annotations:
	    apparmor.security.beta.kubernetes.io/allowedProfileNames: runtime/default
	    apparmor.security.beta.kubernetes.io/defaultProfileName: runtime/default
	    seccomp.security.alpha.kubernetes.io/allowedProfileNames: docker/default
	    seccomp.security.alpha.kubernetes.io/defaultProfileName: docker/default
	spec:
	  requiredDropCapabilities:
	  - 모든
	  볼륨:
	  - configMap
	  - emptyDir
	  - projected
	  - secret
	  - downwardAPI
	  - persistentVolumeClaim
	  seLinux:
	    rule: RunAsAny
	  runAsUser:
	    rule: MustRunAsNonRoot
	  supplementalGroups:
	    rule: MustRunAs
	    ranges:
	    - min: 1
	      max: 65535
	  fsGroup:
	    rule: MustRunAs
	    ranges:
	    - min: 1
	      max: 65535
	  allowPrivilegeEscalation: false
	  forbiddenSysctls:
	  - "*"
    ```

   * 사용자 정의 PodSecurityPolicy에 대한 사용자 정의 ClusterRole:

    ```bash
	apiVersion: rbac.authorization.k8s.io/v1
	kind: ClusterRole
	metadata:
	  name: ibm-mobilefoundation-prod-psp-clusterrole
	rules:
	- apiGroups:
	  - extensions
	  resourceNames:
	  - ibm-mobilefoundation-prod-psp
	  resources:
	  - podsecuritypolicies
	  verbs:
	  - use
    ```
    > 참고: PodSecurityPolicy를 한 번만 작성해야 합니다. PodSecurityPolicy가 이미 존재하면 이 단계를 건너뛰십시오.

   클러스터 관리자는 위 PSP 및 ClusterRole 정의를 UI의 자원 작성 화면에 붙여넣거나 다음 2개의 명령을 실행할 수 있습니다.

```bash
    kubectl create -f <PSP yaml file>
    kubectl create clusterrole ibm-mobilefoundation-prod-psp-clusterrole --verb=use --resource=podsecuritypolicy --resource-name=ibm-mobilefoundation-prod-psp
```

   또한 `RoleBinding`을 작성해야 합니다.

```bash
    kubectl create rolebinding ibm-mobilefoundation-prod-psp-rolebinding --clusterrole=ibm-mobilefoundation-prod-psp-clusterrole --serviceaccount=<namespace>:default --namespace=<namespace>
```

## 필수 자원
{: #resources-required}

이 차트는 기본적으로 다음 자원을 사용합니다.

| 컴포넌트 | CPU  |메모리 | 스토리지
|---|---|---|---|
| Mobile Foundation Server | **요청/최소:** 1000m CPU, **제한/최대:** 2000m CPU | **요청/최소:** 2048Mi 메모리, **제한/최대:** 4096Mi 메모리 | 데이터베이스 요구사항의 경우 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts) 참조
| Mobile Foundation Push | **요청/최소:** 1000m CPU, **제한/최대:** 2000m CPU | **요청/최소:** 2048Mi 메모리, **제한/최대:** 4096Mi 메모리  | 데이터베이스 요구사항의 경우 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts) 참조
| Mobile Foundation Analytics | **요청/최소:** 1000m CPU, **제한/최대:** 2000m CPU  | **요청/최소:** 2048Mi 메모리, **제한/최대:** 4096Mi 메모리  | 지속적 볼륨. 자세한 정보는 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts) 참조
| Mobile Foundation Application Center | **요청/최소:** 1000m CPU, **제한/최대:** 2000m CPU | **요청/최소:** 2048Mi 메모리, **제한/최대:** 4096Mi 메모리  | 데이터베이스 요구사항의 경우 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts) 참조

## 구성
{: #configuration}

### 매개변수
아래 표에서는 {{ site.data.keys.mf_server }} 인스턴스, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }}, {{ site.data.keys.prod_icp }}의 {{ site.data.keys.mf_appcenter }}에서 사용하는 환경 변수를 제공합니다.

| 규정자 |매개변수  | 정의 | 허용값 |
|---|---|---|---|
| global.arch | amd64    | 하이브리드 클러스터에서의 amd64 작업자 노드 스케줄러 선호사항 | 3 - 가장 선호(기본값) |
|      | ppcle64  | 하이브리드 클러스터에서의 ppc64le 작업자 노드 스케줄러 선호사항 | 2 - 선호사항 없음(기본값) |
|      | s390x    | 하이브리드 클러스터에서의 S390x 작업자 노드 스케줄러 선호사항 | 2 - 선호사항 없음(기본값) |
| global.image     | pullPolicy |이미지 가져오기 정책 | Always, Never 또는 IfNotPresent. 기본값: IfNotPresent |
|      |  pullSecret    | 이미지 가져오기 시크릿 | 이미지가 ICP 이미지 레지스트리에 호스팅되지 않은 경우에만 필수 |
| global.ingress | hostname | 외부 클라이언트에서 사용할 외부 호스트 이름 또는 IP 주소 | 기본적으로 클러스터 프록시 노드의 IP 주소로 설정하려면 공백으로 두기|
|         |secret | TLS 시크릿 이름| Ingress 정의에서 사용해야 하는 인증서의 스크릿 이름을 지정합니다. 시크릿은 관련 인증서 및 키를 사용하여 사전에 작성해야 합니다. SSL/TLS를 사용하는 경우 필수입니다. 여기에 이름을 제공하기 전에 인증서 & 키를 사용하여 시크릿을 사전에 작성하십시오. |
|         | sslPassThrough | SSL 패스스루 사용 | Mobile Foundation 서비스로 SSL 요청을 패스스루해야 하는지 여부를 지정합니다. Mobile Foundation 서비스에서 SSL이 종료됩니다. 기본값: false |
| global.dbinit | enabled | Server, Push, Application Center 데이터베이스 초기화 사용 | Server, Push, Application Center 배치의 경우 데이터베이스를 초기화하고 스키마/테이블을 작성합니다(Analytics의 경우 필요하지 않음). 기본값: true |
|  | repository | 데이터베이스 초기화를 위한 Docker 이미지 저장소 | Mobile Foundation 데이터베이스 Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
| mfpserver | enabled          | Server를 사용하도록 플래그 지정 | true(기본값) 또는 false |
| mfpserver.image | repository | Docker 이미지 저장소 | Mobile Foundation Server Docker 이미지 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인|
|  mfpserver.db | host | Mobile Foundation Server 테이블을 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름. | IBM DB2®(기본값). |
|                       | port | 	데이터베이스가 설정되는 포트 | |
|                       | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
|                       | name | Mobile Foundation Server 데이터베이스의 이름 | |
|                       | schema | 작성할 서버 DB 스키마. | 스키마가 이미 있으면 이를 사용합니다. 그렇지 않으면 작성됩니다. |
|                       | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값: false(http). 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
|                       | driverPvc | JDBC 데이터베이스 드라이버에 액세스하기 위한 지속적 볼륨 청구| JDBC 데이터베이스 드라이버를 호스팅하는 지속적 볼륨 청구 이름을 지정합니다. 선택된 데이터베이스 유형이 DB2가 아닌 경우 필수입니다. |
|                       | adminCredentialsSecret | MFPServer DB 관리 시크릿 | DB 초기화를 사용하는 경우 Mobile Foundation 컴포넌트를 위해 데이터베이스 테이블과 스키마를 작성하려면 시크릿 제공 |
| mfpserver | adminClientSecret | Admin 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [전제조건](#Prerequisites)의 6번을 참조하십시오. |
|  | pushClientSecret | Push 클라이언트 시크릿 | 작성한 클라이언트 시크릿 이름을 지정합니다. [전제조건](#Prerequisites)의 6번을 참조하십시오. |
| mfpserver.replicas |  | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 3) |
| mfpserver.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicas 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. 최소값보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| mfpserver.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
|    mfpserver.customConfiguration |  |  사용자 정의 서버 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Server 특정 추가 구성 참조를 제공합니다. |
| mfpserver.jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| mfpserver | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| mfpserver.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  | 기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfppush | enabled          | Mobile Foundation Push를 사용하도록 플래그 지정 | true(기본값) 또는 false |
|           | repository   | Docker 이미지 저장소 |Mobile Foundation Push Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
| mfppush.replicas | | 작성해야 하는 Mobile Foundation Server 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 3) |
| mfppush.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| mfppush.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| mfppush.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Push 특정 추가 구성 참조를 제공합니다. |
| mfppush.jndiConfigurations | mfpfProperties | 배치를 사용자 정의할 Mobile Foundation Server JNDI 특성 | 쉼표로 구분된 이름 값 쌍 제공 |
| mfppush | keystoresSecretName | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| mfppush.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  | 기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfpanalytics | enabled          | Analytics를 사용하도록 플래그 지정 | false(기본값) 또는 true |
| mfpanalytics.image | repository          | Docker 이미지 저장소 | Mobile Foundation Operational Analytics Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인|
| mfpanalytics.replicas |  | 작성해야 하는 Mobile Foundation Operational Analytics의 인스턴스 수(팟(Pod)) | 양의 정수(기본값: 2) |
| mfpanalytics.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
|  mfpanalytics.shards|  | Mobile Foundation Analytics에 대한 Elasticsearch 샤드 수 | 기본값: 2|             
|  mfpanalytics.replicasPerShard|  |Mobile Foundation Analytics에 대해 각 샤드당 유지보수할 Elasticsearch 복제본 수 | 기본값: 2|
| mfpanalytics.persistence | enabled         | 데이터를 지속하기 위해 PersistentVolumeClaim 사용                        | true |                                                 |
|            |useDynamicProvisioning      | storageclass를 지정하거나 비어두기  | false  |                                                  |
|           |volumeName| 볼륨 이름 제공  | data-stor(기본값) |
|           |claimName| 기존 PersistentVolumeClaim 제공  | nil |
|           |storageClassName     | PersistentVolumeClaim을 지원하는 스토리지 클래스 | nil |
|           |size             | 데이터 볼륨 크기      | 20Gi |
| mfpanalytics.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
|    mfpanalytics.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Analytics 특정 추가 구성 참조를 제공합니다. |
| mfpanalytics.jndiConfigurations | mfpfProperties | 운영 분석을 사용자 정의하기 위해 지정할 Mobile Foundation JNDI 특성| 쉼표로 구분된 이름 값 쌍 제공  |
| mfpanalytics | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| mfpanalytics.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 2000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 4096Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  | 기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 2048Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |
| mfpappcenter | enabled          | Application Center를 사용하도록 플래그 지정 | false(기본값) 또는 true |  
| mfpappcenter.image | repository          | Docker 이미지 저장소 | Mobile Foundation Application Center Docker 이미지의 저장소 |
|           | tag          | Docker 이미지 태그 | Docker 태그 설명 참조 |
|           | consoleSecret | 로그인을 위해 사전 작성된 시크릿 | 전제조건 절 확인|
|  mfpappcenter.db | host | Appcenter 데이터베이스에서 구성해야 하는 데이터베이스의 IP 주소 또는 호스트 이름	| |
|                       | port | 	데이터베이스 포트  | |             
|                       | name | 사용할 데이터베이스의 이름 | 데이터베이스가 사전에 작성되어야 합니다.|
|                       | secret | 데이터베이스 신임 정보를 포함하는 사전 작성된 시크릿| |
|                       | schema | 작성할 Application Center 데이터베이스 스키마. | 스키마가 이미 있으면 이를 사용합니다. 없으면 작성됩니다. |
|                       | ssl | 데이터베이스 연결 유형  | 데이터베이스 연결이 http 또는 https여야 하는지를 지정합니다. 기본값: false(http). 동일한 연결 모드로 데이터베이스 포트도 구성해야 합니다. |
|                       | driverPvc | 	 JDBC 데이터베이스 드라이버에 액세스하기 위한 지속적 볼륨 청구  | JDBC 데이터베이스 드라이버를 호스팅하는 지속적 볼륨 청구 이름을 지정합니다. 선택된 데이터베이스 유형이 DB2가 아닌 경우 필수입니다. |
|                       | adminCredentialsSecret | Application Center DB 관리 시크릿 | DB 초기화를 사용하는 경우 Mobile Foundation 컴포넌트를 위해 데이터베이스 테이블과 스키마를 작성하려면 시크릿 제공 |
| mfpappcenter.autoscaling     | enabled | 수평 팟(Pod) 자동 스케일러(HPA)의 배치 여부를 지정합니다. 이 필드를 사용하면 replicaCount 필드를 사용하지 않습니다. | false(기본값) 또는 true |
|           | minReplicas  | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 하한. | 양의 정수(기본값: 1) |
|           | maxReplicas | 자동 스케일러가 설정할 수 있는 팟(Pod) 수에 대한 상한. minReplicas보다 낮을 수 없습니다. | 양의 정수(기본값: 10) |
|           | targetCPUUtilizationPercentage | 모든 팟(Pod)에서 대상의 평균 CPU 사용률(요청된 CPU의 백분율로 표시). | 1 - 100(50에 대한 기본) 사이의 정수 |
| mfpappcenter.pdb     | enabled | PDB의 사용/사용 안함 여부를 지정합니다. | true(기본값) 또는 false |
|           | min  | 사용 가능한 최소 팟(Pod) | 양의 정수(기본값: 1) |
| mfpappcenter.customConfiguration |  |  사용자 정의 구성(선택사항)  | 사전 작성된 구성 맵에 대한 Application Center 특정 추가 구성 참조를 제공합니다. |
| mfpappcenter | keystoreSecret | 키 저장소 및 해당 비밀번호를 사용하여 시크릿을 사전 작성하려면 구성 절을 참조하십시오.|
| mfpappcenter.resources | limits.cpu  | 허용되는 최대 CPU 크기를 설명합니다.  | 기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|                  | limits.memory | 허용되는 최대 메모리 크기를 설명합니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오.|
|           | requests.cpu  | 필요한 최소 CPU 크기를 설명합니다. 지정하지 않으면 제한(지정된 경우)을 기본적으로 사용하며, 그렇지 않은 경우 구현 정의 값을 사용합니다.  | 기본값은 1000m입니다. Kubernetes - [CPU 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)를 참조하십시오. |
|           | requests.memory | 필요한 최소 메모리 양 설명. 지정되지 않은 경우 메모리 크기는 제한(지정된 경우) 또는 구현에서 정의한 값을 기본적으로 사용합니다. | 기본값은 1024Mi입니다. Kubernetes - [메모리의 의미](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)를 참조하십시오. |

> Kibana를 사용한 {{ site.data.keys.prod_adj }} 로그 분석에 대한 학습서는 [여기](analyzing-mobilefirst-logs-on-icp/)를 참조하십시오.

### ICP 카탈로그에서 {{ site.data.keys.prod_adj }} Helm Charts 설치
{: #install-hmc-icp}

#### {{ site.data.keys.mf_server }} 설치
{: #install-mf-server}

{{ site.data.keys.mf_server }}와 함께, 동일한 차트에서 {{ site.data.keys.mf_analytics }} 및 {{ site.data.keys.mf_app_center }}도 배치할 수 있습니다. 그러나 {{ site.data.keys.mf_analytics }} 및 {{ site.data.keys.mf_app_center }}의 배치는 선택사항입니다.

참고:

1. {{ site.data.keys.mf_server }}를 설치하기 전에 DB2 데이터베이스가 사전 구성되어 있는지 확인하십시오.
2. {{ site.data.keys.mf_analytics }} Chart를 설치하기 전에 **지속적 볼륨**을 구성하십시오. {{ site.data.keys.mf_analytics }}를 구성하려면 **지속적 볼륨**을 제공하십시오. **지속적 볼륨**을 작성하려면 [{{ site.data.keys.prod_icp }} 문서](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_cluster/create_volume.html)에 자세히 설명된 단계를 따르십시오. 또한 동일한 yaml 파일에 대한 [IBM {{ site.data.keys.product }} Helm Charts 설치 및 구성](#configure-install-mf-helmcharts)의 **6번 절**을 참조할 수도 있습니다.

아래 단계에 따라 {{ site.data.keys.prod_icp }} 관리 콘솔에서 IBM Mobile Foundation을 설치 및 구성하십시오.

1. 관리 콘솔에서 **카탈로그**로 이동하십시오.
2. **ibm-mobilefoundation-prod** helm chart를 선택하십시오.
3. **구성**을 클릭하십시오.
4. 환경 변수를 제공하십시오. 자세한 정보는 [구성](#configuration)을 참조하십시오.
5. **라이센스 계약**에 동의하십시오.
6. **설치**를 클릭하십시오.

> 참고: ICP 기반 최신 Mobile Foundation 패키지는 다음과 같은 지원되는 소프트웨어를 번들로 제공합니다.
> 1. IBM JRE8 SR5 FP37(8.0.5.37)
> 2. IBM WebSphere Liberty v18.0.0.5

## 설치 확인
{: #verify-install}

{{ site.data.keys.mf_analytics }}(선택사항) 및 {{ site.data.keys.mf_server }}를 설치 및 구성한 후 다음을 완료하여 설치 및 배치된 포드 상태를 확인할 수 있습니다.

{{ site.data.keys.prod_icp }} 관리 콘솔에서 **워크로드 > Helm 릴리스**를 선택하십시오. 설치의 *릴리스 이름*을 클릭하십시오.

## {{ site.data.keys.prod_adj }} 콘솔 액세스
{: #access-mf-console}

설치에 성공한 후 배치를 완료하는 데 몇 분 정도 걸릴 수 있습니다.

웹 브라우저에서 IBM Cloud Private 콘솔 페이지로 이동하고 다음과 같이 Helm 릴리스 페이지로 이동하십시오.
1. 페이지의 맨 위 왼쪽에서 메뉴를 클릭하십시오.
2. 워크로드 > Helm 릴리스를 선택하십시오.
3. 배치된 IBM Mobile Foundation Helm 릴리스를 클릭하십시오.
4. Mobile Foundation Server Operations Console에 액세스하는 프로시저는 [참고](https://github.ibm.com/MobileFirst/ibm-mobilefoundation-prod/blob/development/stable/ibm-mobilefoundation-prod/templates/NOTES.txt) 절을 참조하십시오.

## 샘플 애플리케이션
{: #sample-app}
샘플 어댑터를 배치하고 {{ site.data.keys.prod_icp }}에서 실행되는 IBM {{ site.data.keys.mf_server }}에 샘플 어댑터를 배치하고 샘플 애플리케이션을 실행하려면 [{{ site.data.keys.prod_adj }} 학습서](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)를 참조하십시오.

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

## Mobile Foundation 플랫폼용 IBM Certified Cloud Pak로 마이그레이션
{: #migrate}

[IBM Certified Cloud Pak](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/app_center/cloud_paks_over.html)를 통해 Mobile Foundation은 이제 단일 helm 차트로 배치가 가능합니다. 그러면 Mobile Foundation 컴포넌트를 배치하는 경우 서로 다른 3개의 helm 차트(즉, ibm-mfpf-server-prod, ibm-mfpf-analytics-prod, ibm-mfpf-appcenter-prod)를 사용하는 이전 접근 방식을 대체합니다.

ICP 배치에서 별도의 Helm 릴리스로 설치된 이전 Mobile Foundation 컴포넌트를 IBM Certified Cloud Pak를 포함하는 새로운 통합된 단일 helm 차트로 마이그레이션하는 작업은 간단합니다.

1. Server, Push, Application Center, Analytics에 대한 모든 구성 매개변수를 보유할 수 있습니다.
2. 데이터베이스 세부사항이 이전 배치와 동일하게 사용되면 새로운 Mobile Foundation 배치(Server, Push, Application Center)는 이전과 동일한 데이터를 보유합니다.
3. 입력할 데이터베이스 값의 변경사항에 주의하십시오. 이제 시크릿을 통해 데이터베이스에 대한 액세스가 제어됩니다. 콘솔 로그인, 데이터베이스 계정 등을 포함하여 모든 신임 정보에 대한 시크릿을 작성하는 방법은 [전제조건](#Prerequisites)의 4번 절을 참조하십시오.
4. Mobile Foundation Analytics 데이터는 이전 배치에서 동일한 지속적 볼륨 청구를 재사용하여 보유할 수 있습니다.

## MFP Analytics 데이터 백업 및 복구
{: #backup-analytics}

MFP Analytics 데이터는 Kubernetes [PersistentVolume 또는 PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction)의 일부로 사용 가능합니다. [Kubernetes에서 제공하는 볼륨 플러그인](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) 중 하나를 사용할 수 있습니다.

백업 및 복원은 사용하는 볼륨 플러그인에 따라 다릅니다. 다양한 수단과 도구를 통해 볼륨을 백업 또는 복원할 수 있습니다.

Kuberenetes는 [**VolumeSnapshot, VolumeSnapshotContent, Restore 옵션**](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature)을 제공합니다. 관리자가 프로비저닝하는 [클러스터의 볼륨](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction)에 대한 사본을 가져올 수 있습니다.

다음 [예제 yaml 파일](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes)을 사용하여 스냅샷 기능을 테스트하십시오.

또한 다른 도구를 활용하여 볼륨 백업을 작성하고 동일한 볼륨을 복원할 수 있습니다.

- ICP 기반 IBM Cloud Automation Manager(CAM)

    [CAM 인스턴스에 대한 백업/복원, 고가용성(HA), 재해 복구(DR)](https://developer.ibm.com/cloudautomation/2018/05/08/backup-ha-dr/) 전략과 CAM 기능 활용

- ICP 기반 [Portworx](https://portworx.com)

    Kubernetes와 같은 컨테이너 오케스트레이터를 통해 또는 컨테이너로 배치된 애플리케이션을 위해 설계된 스트로지 솔루션입니다.

- [AppsCode](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) 지원 Stash

    Stash를 사용하여 Kubernetes에서 볼륨을 백업할 수 있습니다.

## 설치 제거
{: #uninstall}
{{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 설치 제거하려면 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)를 사용하십시오.
다음 명령을 사용하여 설치된 차트 및 연관된 배치를 완전히 삭제하십시오.

```bash
helm delete <my-release> --purge --tls
```
*my-release*은 Helm Chart의 배치된 릴리스 이름입니다.

이 명령은 차트와 연관된 모든 Kubernetes 컴포넌트(지속적 볼륨 청구(PVC) 제외)를 제거합니다. 이 기본 Kubernetes 동작을 통해 소중한 데이터가 삭제되지 않도록 보장합니다.
