---
layout: tutorial
breadcrumb_title: Foundation on Red Hat OpenShift
title: 기존 Red Hat OpenShift Container Platform에 Mobile Foundation 배치
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->

IBM Mobile Foundation Operator를 사용하여 OpenShift 클러스터에서 Mobile Foundation 인스턴스를 설치하는 방법에 대해 알아봅니다.

OpenShift Container Platform에 대한 인타이틀먼트를 가져오는 두 가지 방법이 있습니다.

* IBM Cloud Pak for Applications에 대한 인타이틀먼트를 보유합니다. 여기에 OpenShift Container Platform 인타이틀먼트가 포함되어 있습니다.
* Red Hat에서 구매한 기존의 OpenShift Container Platform을 보유합니다.

OCP에 Mobile Foundation을 배치하는 단계는 OCP 인타이틀먼트를 확보한 방법과 상관없이 동일합니다.

## 전제조건
{: #prereqs}

다음은 Mobile Foundation Operator를 사용하여 Mobile Foundation 인스턴스를 설치하는 프로세스를 시작하기 전의 전제조건입니다.

- OpenShift 클러스터r v3.11 이상.
- [OpenShift 클라이언트 도구](https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html) (`oc`).
- Mobile Foundation에는 데이터베이스가 필요합니다. 지원되는 데이터베이스를 작성하고 추후 사용을 위한 데이터베이스 액세스 세부사항을 가까이 보관하십시오. [여기](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/)를 참조하십시오.
- Mobile Foundation Analytics에는 Analytics 데이터를 지속하기 위해 마운트된 스토리지 볼륨이 필요합니다(NFS가 권장됨).

## 아키텍처
{: #architecture}

아래 이미지는 Red Hat OpenShift에서 모바일 서비스의 내부 아키텍처를 보여줍니다.

![아키텍처](./architecture-mf-on-openshift.png)

## IBM Mobile Foundation 인스턴스 설치

### IBM Mobile Foundation 패키지를 다운로드하십시오.
{: #download-mf-package}

[IBM Passport Advantage(PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)에서 Openshift용 IBM Mobile Foundation 패키지를 다운로드하십시오. `workdir` 디렉토리에 아카이브를 압축 해제하십시오.

  > **참고:** PPA 패키지의 유효성을 검증하고 서명을 확인하려는 경우 [여기](./additional-docs/validating-ppa/)를 참조하십시오.

### Mobile Foundation에 대한 OpenShift 프로젝트 설정
{: #setup-openshift-for-mf}

1. OpenShift 클러스터에 로그인하고 새 프로젝트를 작성하십시오.   
   ```bash
   export MFOS_PROJECT=<project-name>
   oc login -u <username> -p <password> <cluster-url>
   oc new-project $MFOS_PROJECT
   ```
2. 다음 명령을 사용하여 Openshift에 대한 IBM Mobile Foundation 패키지를 압축 해제하십시오.
  ```bash
  tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C <workdir>/
  ```
3. 로컬에서 OpenShift 레지스트리에 이미지를 로드하고 푸시하십시오.   
   ```bash
    docker login -u <username> -p $(oc whoami -t) $(oc registry info)
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
      docker tag ${file/.tar.gz/} $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
      docker push $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
    done
   ```
4. 데이터베이스 신임 정보로 시크릿을 작성하십시오.

    ```yaml
    cat <<EOF | oc apply -f -
    apiVersion: v1
    data:
      MFPF_ADMIN_DB_USERNAME: <base64-encoded-string>
      MFPF_ADMIN_DB_PASSWORD: <base64-encoded-string>
      MFPF_RUNTIME_DB_USERNAME: <base64-encoded-string>
      MFPF_RUNTIME_DB_PASSWORD: <base64-encoded-string>
      MFPF_PUSH_DB_USERNAME: <base64-encoded-string>
      MFPF_PUSH_DB_PASSWORD: <base64-encoded-string>
      MFPF_APPCNTR_DB_USERNAME: <base64-encoded-string>
      MFPF_APPCNTR_DB_PASSWORD: <base64-encoded-string>
    kind: Secret
    metadata:
    name: mobilefoundation-db-secret
    type: Opaque
    EOF
    ```
  > **참고**: 인코딩된 문자열은 `echo -n <string-to-encode> | base64`를 사용하여 확보할 수 있습니다.

5. Mobile Foundation Analytics의 경우 지속적 볼륨(PV)을 구성하십시오.
    ```yaml
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      labels:
        name: mfanalyticspv
      name: mfanalyticspv
    spec:
      capacity:
        storage: 20Gi
      accessModes:
        - ReadWriteMany
      persistentVolumeReclaimPolicy: Retain
      nfs:
        path: <nfs-mount-volume-path>
        server: <nfs-server-hostname-or-ip>
    EOF
    ```

6. Mobile Foundation Analytics의 경우 지속적 볼륨 청구(PVC)를 구성하십시오.
   ```yaml
   cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mfanalyticsvolclaim
      namespace: <projectname-or-namespace>
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
      selector:
        matchLabels:
          name: mfanalyticspv
      volumeName: mfanalyticspv
    EOF
   ```

### IBM Mobile Foundation Operator 배치
{: #deploy-mf-operator}

1. 태그와 함께 Operator 이미지 이름(*mf-operator*)이 `deploy/operator.yaml`에서 Operator에 대해 설정되었는지 확인하십시오(**REPO_URL**).

    ```bash
    sed -i 's|REPO_URL|<image-repo-url>:<image-tag>|g' deploy/operator.yaml
    ```

2. `deploy/cluster_role_binding.yaml`에서 클러스터 역할 바인딩 정의에 대해 네임스페이스가 설정되었는지 확인하십시오(**REPLACE_NAMESPACE**).

    ```bash
    sed -i 's|REPLACE_NAMESPACE|$MFOS_PROJECT|g' deploy/cluster_role_binding.yaml
    ```

3. 다음 명령을 실행하여, CRD, Operator를 배치하고 SCC(Security Context Constraints)를 설치하십시오.

    ```bash
    oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
    oc create -f deploy/
    oc adm policy add-scc-to-group mf-operator system:serviceaccounts:$MFOS_PROJECT
    ```

### IBM Mobile Foundation 컴포넌트 배치
{: #deploy-mf-components}

1. Mobile Foundation 컴포넌트를 배치하려면 요구사항에 따라 사용자 정의 자원 구성 `deploy/crds/charts_v1_mfoperator_cr.yaml`을 수정하십시오. 사용자 정의 구성에 대한 전체 참조는 [여기](./additional-docs/cr-configuration/)에서 제공합니다.

   > **중요한 참고**: 배치 후 Mobile Foundation 인스턴스에 액세스하려면 ingress 호스트 이름을 구성해야 합니다. 사용자 정의 자원 구성에 ingress가 구성되었는지 확인하십시오. 동일한 구성 방법은 이 [링크](./additional-docs/enable-ingress/)를 참조하십시오.

    ```bash
    oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
    ```
2. 다음 명령을 실행하여 팟(Pod)이 작성되어 실행 중인지 확인하십시오. Mobile Foundation Server 및 푸시를 각 세 개의 복제본(기본값)과 함께 사용할 수 있는 시나리오에서 출력은 아래와 유사합니다.

      ```bash
      $ oc get pods
      NAME                           READY     STATUS    RESTARTS   AGE
      mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
      mfpf-server-2327bbewss-3bw31   1/1       Running   0          1m 20s
      mfpf-server-29kw92mdlw-923ks   1/1       Running   0          1m 21s
      mfpf-server-5woxq30spw-3bw31   1/1       Running   0          1m 19s
      mfpf-push-2womwrjzmw-239ks     1/1       Running   0          59s
      mfpf-push-29kw92mdlw-882pa     1/1       Running   0          52s
      mfpf-push-1b2w2s973c-983lw     1/1       Running   0          52s
      ```
    > **참고:** 실행 중인 팟(1/1) 상태는 서비스가 액세스에 대해 사용 가능함을 표시합니다.3. 다음 명령을 실행하여 Mobile Foundation 엔드포인트에 액세스하기 위한 라우트가 작성되었는지 확인하십시오.

    ```bash
    $ oc get routes
    NAME                                      HOST/PORT               PATH        SERVICES             PORT      TERMINATION   WILDCARD
    ibm-mf-cr-1fdub-mfp-ingress-57khp   myhost.mydomain.com   /imfpush          ibm-mf-cr--mfppush     9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-8skfk   myhost.mydomain.com   /mfpconsole       ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-dqjr7   myhost.mydomain.com   /doc              ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-ncqdg   myhost.mydomain.com   /mfpadminconfig   ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-x8t2p   myhost.mydomain.com   /mfpadmin         ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-xt66r   myhost.mydomain.com   /mfp              ibm-mf-cr--mfpserver   9080                    None
    ```

### IBM Mobile Foundation 컴포넌트의 콘솔에 액세스

Mobile Foundation 컴포넌트의 콘솔에 액세스하기 위한 엔드포인트는 다음과 같습니다.

  * **Mobile Foundation Server 관리 콘솔** - `http://<ingress_hostname>/mfpconsole`
  * **Operational Analytics 콘솔** - `http://<ingress_hostname>/analytics/console`
  * **Application Center 콘솔** - `http://<ingress_hostname>/appcenterconsole`

## 설치 제거
{: #uninstall}

다음 명령을 사용하여 설치 후 정리를 수행하십시오.

```bash
oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
oc delete -f deploy/
oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
```

### 추가 참조

1. [Mobile Foundation 데이터베이스 설정](../../installation-configuration/production/prod-env/databases/)
2. [IBM Mobile Foundation 데이터베이스로 Oracle 또는 MySQL 사용](additional-docs/advanced-db-config/)
3. [Mobile Foundation에 대한 사용자 정의 자원 구성 매개변수](additional-docs/cr-configuration/)
4. [Ingress를 사용하는 시나리오](additional-docs/enable-ingress/)
