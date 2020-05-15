---
layout: tutorial
breadcrumb_title: IBM Cloud OpenShift 上の Foundation
title: IBM Cloud 上の Red Hat OpenShift Container Platform への Mobile Foundation のデプロイ
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->

### 前提条件
{: #prereqs}

以下は、Mobile Foundation インスタンスのインストール・プロセスを開始する前に満たす必要がある前提条件です。

- [IBM アカウント](https://myibm.ibm.com)を使用して IBM Cloud で [OpenShift クラスターを作成します](https://cloud.ibm.com/kubernetes/registry/main/namespaces?platformType=openshift)。
- [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-install-ibmcloud-cli) (`ibmcloud`)。
- [IBM パスポート・アドバンテージ (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) から Openshift 用の IBM Mobile Foundation パッケージをダウンロードします。
- Mobile Foundation にはデータベースが必要です。 サポートされているデータベースを作成し、データベース・アクセスの詳細を以後使用できるように用意します。 [ここ](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/)を参照してください。
- (オプション) Mobile Foundation Analytics 用の NFS マウント・ボリューム (または) [ファイル・ストレージ](https://cloud.ibm.com/docs/containers?topic=containers-file_storage)。

### IBM Cloud 上の Red Hat OpenShift クラスターに Mobile Foundation をデプロイする手順
{: #steps-deployment}

このセクションで説明している手順に従い、IBM Cloud 上の Red Hat OpenShift クラスターに Mobile Foundation OpenShift Container Platform (OCP) パッケージをデプロイします。

1.  イメージをプライベート・レジストリーにプッシュし、イメージをプルするときに使用できる秘密を作成します。

    a. IBM Cloud にログインします。

    ```bash
    ibmcloud login
    ```

    b. 以下のコマンドを実行して、OpenShift の内部 Docker レジストリーにログインします。

    ```bash
    # 端末から Docker レジストリーへのルートを作成する
    oc create route reencrypt --service=docker-registry -n default
    oc get route docker-registry -n default

    # OpenShift 内部コンテナー・レジストリーにログインする
    docker login -u $(oc whoami) -p $(oc whoami -t) <docker-registry-url>
    ```

    以下に例を示します。

    ```bash
    $ oc get route docker-registry -n default
    NAME              HOST/PORT                                              PATH      SERVICES          PORT       TERMINATION   WILDCARD
    docker-registry   docker-registry-default.-xxxx.appdomain.cloud    docker-registry                   5000-tcp   reencrypt     None

    $ docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.-xxxx.appdomain.cloud
    Login Succeeded
    ``>


    c. PPA アーカイブを作業ディレクトリー (例えば `mfoskpg`) に解凍し、IBM Mobile Foundation イメージをローカルにロードします。

    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C mfospkg/

    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    export MFOS_PROJECT=<my_namespace>
    export CONTAINER_REGISTRY_URL=<docker-registry-url>    # 例えば、docker-registry-default.-xxxx.appdomain.cloud
    ```

    d. ローカル・マシンからイメージをロードし、OpenShift レジストリーにプッシュします。

    ```bash
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
    docker tag ${file/.tar.gz/} $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    docker push $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    done
    ```

    > **重要事項:** この後、OpenShift の内部コンテナー・レジストリーからコンテナー・イメージにアクセスするために、イメージ URL `docker-registry.default.svc:5000/<project_name>/<image_name>:<image_tag>` を使用します。

2. OpenShift プロジェクトを作成します。

    a. [IBM Cloud](https://cloud.ibm.com/kubernetes/clusters?platformType=openshift) から OpenShift クラスター・ダッシュボードを開きます。

    b. **「アクセス」**タブに移動し、クイック・セットの説明に従い OpenShift コンソールにアクセスします。

    c. クラスター・ページの**「OpenShift Web コンソール (OpenShift Web Console)」**ボタンをクリックして、OpenShift コンソールを開きます。

    d. Web コンソールで OpenShift プロジェクトを作成します (または `oc` CLI を使用してプロジェクトを作成できます)。 [資料](https://docs.openshift.com/container-platform/3.11/dev_guide/projects.html#create-a-project-using-the-cli)を参照してください。

3. オペレーターをデプロイします。

    a. `deploy/operator.yaml` で、タグ付きの MF オペレーター・イメージ (**mf-operator**) がオペレーターに対して設定されていることを確認します (プレースホルダー REPO_URL を OpenShift コンテナーの内部レジストリーの URL (例えば `docker-registry.default.svc:5000/myprojectname/mf-operator:1.0.1`) に置き換えます)。

    b. `deploy/cluster_role_binding.yaml` で、クラスター・ロール・バインディング定義に対して OpenShift プロジェクト名が設定されていることを確認します (プレースホルダー REPLACE_NAMESPACE を置き換えます)。

    c. 以下のコマンドを実行してオペレーターをデプロイし、セキュリティー・コンテキスト制約 (SCC) をインストールします。

    ```bash
     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # コマンドの実行時に独自の <project_name> を使用する
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<project_name>
    ```

     これにより、mf-operator ポッドが作成され、実行されます。 ポッドをリストし、ポッドが正常に作成されたことを確認します。 出力は以下のようになります。

    ```bash
    $ oc get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

4.  データベースにアクセスするための IBM Mobile Foundation デプロイメント用の秘密を作成します。
    >[ここ](../mobilefoundation-on-openshift/#setup-openshift-for-mf)にある資料を参照してください。

5.  Analytics 用の永続ボリュームおよび永続ボリューム要求を作成します。
    >[ここ](../mobilefoundation-on-openshift/#setup-openshift-for-mf)にある資料を参照してください。

6.  IBM Mobile Foundation コンポーネントをデプロイします。

    いずれかの Mobile Foundation コンポーネントをデプロイするには、`deploy/crds/charts_v1_mfoperator_cr.yaml` で該当するカスタム・リソース値を変更します。

    a.  `deploy/crds/charts_v1_mfoperator_cr.yaml` でプレースホルダー REPO_URL を置き換えることで、Docker リポジトリーの URL (例えば `docker-registry.default.svc:5000/myprojectname/mfpf-server:2.0.1`) を設定します。

    b.  (オプション) イメージ・レジストリーが OpenShift クラスターの外部にある場合、`deploy/crds/charts_v1_mfoperator_cr.yaml` ファイルに **pullSecret** を追加します。 秘密の定義は、 以下のサンプル・スニペットのようになります。

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: pull-secret-name
    ```

    [ここ](../mobilefoundation-on-openshift/#deploy-mf-operator)にある資料を参照して、残りの構成 (レプリカ、スケーリング、DB プロパティーなど) を完了してください。

7. カスタム・リソースを作成または更新します。 この手順により、CR yaml で有効化されているすべての Mobile Foundation コンポーネントに対してポッドが作成され、実行されます。

	```bash
	oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
	```

    以下のコマンドを実行し、ポッドが正常に作成され、実行されていることを確認します。 Mobile Foundation サーバーおよび Push が 3 つの各レプリカ (デフォルト) で有効になっているデプロイメント・シナリオでは、出力は以下のようになります。

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

	> **注:** Running (1/1) 状況のポッドは、サービスにアクセスできることを示します。

8. 以下のコマンドを実行して、Mobile Foundation エンドポイントにアクセスするためのルートが作成されているかどうか確認します。

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

### IBM Mobile Foundation コンポーネントのコンソールへのアクセス

以下は、Mobile Foundation コンポーネントのコンソールにアクセスするためのエンドポイントです。

  * **Mobile Foundation サーバーの管理コンソール** - `http://<ingress_subdomain>/mfpconsole`
  * **Operational Analytics コンソール** - `http://<ingress_subdomain>/analytics/console`
  * **Application Center コンソール** - `http://<ingress_subdomain>/appcenterconsole`

### アンインストール

以下の手順を使用すると、デプロイメントをクリーンアップできます。

* 以下の手順を使用して、カスタム・リソース (CR) およびカスタム・リソース定義 (CRD) を削除します。

	```bash
	oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
	oc delete -f deploy/
	oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
	oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
	```

### 追加情報

IBM Cloud 上のファイル・ストレージを使用する Mobile Foundation Analytics で、Analytics データを永続ボリュームに書き込むための権限の問題に対処するために、以下のコマンドを実行してください。

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
