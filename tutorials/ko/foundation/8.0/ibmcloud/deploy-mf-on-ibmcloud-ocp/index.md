---
layout: tutorial
breadcrumb_title: Foundation on IBM Cloud OpenShift
title: IBM Cloud의 Red Hat OpenShift Container Platform에 Mobile Foundation 배치
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->

### 전제조건
{: #prereqs}

Mobile Foundation 인스턴스 설치 프로세스를 시작하기 전의 전제조건은 다음과 같습니다.

- [IBM Account](https://myibm.ibm.com)를 사용하여 IBM Cloud에 [OpenShift 클러스터를 작성](https://cloud.ibm.com/kubernetes/registry/main/namespaces?platformType=openshift)하십시오.
- [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-install-ibmcloud-cli)(`ibmcloud`).
- [IBM Passport Advantage(PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)에서 Openshift용 IBM Mobile Foundation 패키지를 다운로드하십시오.
- Mobile Foundation에는 데이터베이스가 필요합니다. 지원되는 데이터베이스를 작성하고 추후 사용을 위한 데이터베이스 액세스 세부사항을 가까이 보관하십시오. [여기](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/)를 참조하십시오.
- [선택사항] NFS 마운트 볼륨 또는 Mobile Foundation Analytics용 [File Storage](https://cloud.ibm.com/docs/containers?topic=containers-file_storage)

### IBM Cloud의 Red Hat OpenShift 클러스터에 Mobile Foundation을 배치하는 단계
{: #steps-deployment}

이 절에서 설명하는 단계에 따라 Mobile Foundation OpenShift Container Platform(OCP) 패키지를 IBM Cloud의 Red Hat OpenShift 클러스터에 배치하십시오.

1.  사설 레지스트리 안으로 이미지를 푸시하고 이미지를 풀링할 때 사용할 수 있는 시크릿을 작성하십시오.

    a. IBM Cloud에 로그인하십시오.

    ```bash
    ibmcloud login
    ```

    b. 다음 명령을 실행하여 OpenShift의 내부 Docker 레지스트리에 로그인하십시오.

    ```bash
    # Create a route from the terminal to the docker registry
    oc create route reencrypt --service=docker-registry -n default
    oc get route docker-registry -n default

    # login into the OpenShift internal container registry
    docker login -u $(oc whoami) -p $(oc whoami -t) <docker-registry-url>
    ```

    예를 들어, 다음과 같습니다.

    ```bash
    $ oc get route docker-registry -n default
    NAME              HOST/PORT                                              PATH      SERVICES          PORT       TERMINATION   WILDCARD
    docker-registry   docker-registry-default.-xxxx.appdomain.cloud    docker-registry                   5000-tcp   reencrypt     None

    $ docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.-xxxx.appdomain.cloud
    Login Succeeded
    ```

    c. PPA 아카이브를 작업 디렉토리로 압축을 풀고(`mfoskpg` 사용) IBM Mobile Foundation 이미지를 로컬로 사용하십시오.

    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C mfospkg/

    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    export MFOS_PROJECT=<my_namespace>
    export CONTAINER_REGISTRY_URL=<docker-registry-url>    # e.g. docker-registry-default.-xxxx.appdomain.cloud
    ```

    d. 로컬 머신에서 OpenShift 레지스트리로 이미지를 로드하고 푸시하십시오.

    ```bash
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
    docker tag ${file/.tar.gz/} $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    docker push $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    done
    ```

    > **중요 참고:** 여기부터는 OpenShift의 내부 컨테이너 레지스트리에서 컨테이너에 액세스할 때 이미지 URL을 `docker-registry.default.svc:5000/<project_name>/<image_name>:<image_tag>`로 사용하십시오.

2. OpenShift 프로젝트를 작성하십시오.

    a. [IBM Cloud](https://cloud.ibm.com/kubernetes/clusters?platformType=openshift)에서 OpenShift 클러스터 대시보드를 여십시오.

    b. **액세스** 탭으로 이동하여 빠른 지시사항 세트에 따라 OpenShift 콘솔에 액세스하십시오.

    c. 클러스터 페이지의 **OpenShift 웹 콘솔** 단추를 클릭하여 OpenShift 콘솔을 여십시오.

    d. 웹 콘솔에서 OpenShift 프로젝트를 작성하십시오. 또는 `oc` CLI를 사용하여 프로젝트를 작성할 수 있습니다. [문서](https://docs.openshift.com/container-platform/3.11/dev_guide/projects.html#create-a-project-using-the-cli)를 참조하십시오.

3. Operator를 배치하십시오.

    a. 태그가 있는 MF Operator 이미지(**mf-operator**)가 `deploy/operator.yaml`에서 Operator에 대해 설정되어 있는지 확인하십시오. 플레이스홀더 REPO_URL을 OpenShift 컨테이너 내부 레지스트리 URL로 대체하십시오. 예: `docker-registry.default.svc:5000/myprojectname/mf-operator:1.0.1`

    b. OpenShift 프로젝트 이름이 `deploy/cluster_role_binding.yaml`의 클러스터 역할 바인딩 정의에 대해 설정되어 있는지 확인하십시오. 플레이스홀더 REPLACE_NAMESPACE를 대체하십시오.

    c. 아래 명령을 실행하여 Operator를 배치하고 Security Context Constraints(SCC)를 설치하십시오.

    ```bash
     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # Use your own <project_name> while running the command
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<project_name>
    ```

     그러면 mf-operator 팟(Pod)이 작성되고 실행됩니다. 팟(Pod)을 나열하여 팟(Pod)이 작성되었는지 확인하십시오. 출력은 다음과 같이 표시됩니다.

    ```bash
    $ oc get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

4.  데이터베이스에 액세스하려면 IBM Mobile Foundation 배치에 필요한 시크릿을 작성하십시오.
    >[여기](../mobilefoundation-on-openshift/#setup-openshift-for-mf)의 문서를 참조하십시오.

5.  Analytics에 대한 지속적 볼륨 및 볼륨 청구를 작성하십시오.
    >[여기](../mobilefoundation-on-openshift/#setup-openshift-for-mf)의 문서를 참조하십시오.

6.  IBM Mobile Foundation 컴포넌트를 배치하십시오.

    임의의 Mobile Foundation 컴포넌트를 배치하려면 `deploy/crds/charts_v1_mfoperator_cr.yaml`에서 적절한 사용자 정의 리소스 값을 수정하십시오.

    a.  플레이스홀더 REPO_URL을 대체하여 `deploy/crds/charts_v1_mfoperator_cr.yaml`에서 Docker 저장소 URL을 설정하십시오. 예: `docker-registry.default.svc:5000/myprojectname/mfpf-server:2.0.1`.

    b.  [선택사항] 이미지 레지스트리가 OpenShift 클러스터 외부인 경우, **pullSecret**을 `deploy/crds/charts_v1_mfoperator_cr.yaml` 파일에 추가하십시오. 시크릿 정의는 다음 샘플 스니펫과 유사합니다.

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: pull-secret-name
    ```

    [여기](../mobilefoundation-on-openshift/#deploy-mf-operator)의 문서를 참조하여 나머지 구성(복제본, 스케일링, DB 특성 등)을 완료하십시오.

7. 사용자 정의 리소스를 작성하거나 업데이트하십시오. 이 단계에서는 CR yaml에서 사용할 수 있는 모든 Mobile Foundation 컴포넌트를 위한 팟(Pod)을 작성하고 실행합니다.

	```bash
	oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
	```

    다음 명령을 실행하여 팟(Pod)이 작성되어 실행 중인지 확인하십시오. Mobile Foundation Server 및 푸시를 각 세 개의 복제본(기본값)과 함께 사용할 수 있는 시나리오에서 출력은 아래와 유사합니다.

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

	> **참고:** 실행 중인 팟(1/1) 상태는 서비스가 액세스에 대해 사용 가능함을 표시합니다.

8. 다음 명령을 실행하여 Mobile Foundation 엔드포인트에 액세스하기 위한 라우트가 작성되었는지 확인하십시오.

    ```bash
    $ oc get routes
    NAME                                      HOST/PORT               PATH        SERVICES             PORT      TERMINATION   WILDCARD
    ibm-mf-cr-1fdub-mfp-ingress-57khp   myhost.mydomain.cloud   /imfpush          ibm-mf-cr--mfppush     9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-8skfk   myhost.mydomain.cloud   /mfpconsole       ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-dqjr7   myhost.mydomain.cloud   /doc              ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-ncqdg   myhost.mydomain.cloud   /mfpadminconfig   ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-x8t2p   myhost.mydomain.cloud   /mfpadmin         ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-xt66r   myhost.mydomain.cloud   /mfp              ibm-mf-cr--mfpserver   9080                    None
    ```

### IBM Mobile Foundation 컴포넌트의 콘솔에 액세스

Mobile Foundation 컴포넌트의 콘솔에 액세스하기 위한 엔드포인트는 다음과 같습니다.

  * **Mobile Foundation Server 관리 콘솔** - `http://<ingress_subdomain>/mfpconsole`
  * **Operational Analytics 콘솔** - `http://<ingress_subdomain>/analytics/console`
  * **Application Center 콘솔** - `http://<ingress_subdomain>/appcenterconsole`

### 설치 제거

다음 단계는 배치를 정리할 때 사용할 수 있습니다.

* 다음 단계를 사용하여 사용자 정의 자원(CR) 및 사용자 정의 자원 정의(CRD)를 삭제하십시오.

	```bash
	oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
	oc delete -f deploy/
	oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
	oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
	```

### 추가 정보

분석 데이터를 지속적 볼륨에 작성하는 것과 관련된 문제를 해결하려면 IBM Cloud에서 File Storage를 사용하는 Mobile Foundation Analytics의 경우, 다음 명령을 실행하십시오.

```bash
oc run perms-pod --overrides='
{
           "spec": {
            "containers": [
                {
                    "command": [
                        "/bin/sh",
                        "-c",
                        "mkdir -p /usr/ibm/wlp/usr/servers/mfpf-analytics/analyticsData && chown -R 1001:0 /usr/ibm/wlp/usr/servers/mfpf-analytics/analyticsData"
                    ],
                    "image": "alpine:3.2",
                    "name": "perms-pod",
                    "volumeMounts": [{
                        "mountPath": "/opt/ibm/wlp/usr/servers/mfpf-analytics/analyticsData",
                        "name": "pvc-data"
                    }]
                }
            ],        
            "volumes": [
                {
                    "name": "pvc-data",
                    "persistentVolumeClaim": {
                        "claimName": "<pvc-name>"
                    }
                }
            ]
        }
}
'  --image=notused --restart=Never
```
