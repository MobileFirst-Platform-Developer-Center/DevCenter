---
layout: tutorial
title: IBM Cloud Private への IBM Mobile Foundation のインストール
breadcrumb_title: IBM Cloud Private 上の Foundation
relevantTo: [ios,android,windows,javascript]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下の指示に従い、{{ site.data.keys.prod_icp }} で {{ site.data.keys.mf_server }} インスタンス、{{ site.data.keys.mf_analytics }}、{{ site.data.keys.mf_push }}、および {{ site.data.keys.mf_app_center}} インスタンスを構成します。

* 前提条件を満たす
* {{ site.data.keys.prod_icp }} 用の {{ site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA アーカイブ) をダウンロードする
* {{ site.data.keys.prod_icp }} クラスターに PPA アーカイブをロードする
* {{ site.data.keys.mf_server }}、{{ site.data.keys.mf_analytics }} (オプション)、{{ site.data.keys.mf_push }} (オプション)、および {{ site.data.keys.mf_app_center }} (オプション) をインストールし、構成する

#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード](#load-the-ibm-mfpf-ppa-archive)
* [IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)
* [必要なリソース](#resources-required)
* [インストールの検査](#verify-install)
* [サンプル・アプリケーション](#sample-app)
* [{{site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード](#upgrading-mf-helm-charts)
* [Mobile Foundation Platform 用の IBM Certified Cloud Pak へのマイグレーション](#migrate)
* [MFP Analytics データのバックアップおよびリカバリー](#backup-analytics)
* [アンインストール](#uninstall)

## 前提条件
{: #prereqs}

{{ site.data.keys.prod_icp }} アカウントが必要であり、[{{ site.data.keys.prod_icp }}クラスター](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup)をセットアップしておく必要があります。

コンテナーおよびイメージを管理するために、{{ site.data.keys.prod_icp }} セットアップの一部としてホスト・マシンに以下をインストールする必要があります。

* [Docker](https://docs.docker.com/install/) をインストールし、セットアップする
* [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started) (`cloudctl`)
* [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (`kubectl`)
* [Helm](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_helm_cli.html) (`helm`)

> サポートされている Docker CLI のバージョンについては、[ここ](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/supported_system_config/supported_docker.html)を参照してください。

> ICP クラスターと同じバージョンの Kube CLI、IBM Cloud CLI、および Helm をインストールします (IBM Cloud Private 管理コンソールからダウンロードし、**「メニュー」>「コマンド・ライン・ツール (Command Line Tools)」>「Cloud Private CLI」**をクリックします)。

例えば、次のとおりです。

IBM Cloud Private で、秘密、永続ボリューム (PV)、永続ボリューム要求 (PVC) などの Kubernetes 成果物を作成するために、`kubectl` CLI が必要です。

a. IBM Cloud Private 管理コンソールから `kubectl` ツールをインストールし、**「メニュー」>「コマンド・ライン・ツール (Command Line Tools)」>「Cloud Private CLI」**をクリックします。

b. **「Kubernetes CLI のインストール (Install Kubernetes CLI)」**を展開し、`curl` コマンドを使用してインストーラーをダウンロードします。 ご使用のオペレーティング・システム用の curl コマンドをコピーして実行し、インストール手順を続行します。

c. 該当するオペレーティング・システム用の curl コマンドを選択します。 例えば、macOS では以下のコマンドを実行できます。

   ```bash
   curl -kLo <install_file> https://<cluster ip>:<port>/api/cli/kubectl-darwin-amd64
   chmod 755 <path_to_installer>/<install_file>
   sudo mv <path_to_installer>/<install_file> /usr/local/bin/kubectl
   ```
参照: [Kubernetes CLI (kubectl) のインストール](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/manage_cluster/install_kubectl.html)

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード
{: #download-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA) は、[ここ](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)から入手できます。 {{site.data.keys.product }} の PPA アーカイブには、以下の {{site.data.keys.product }} コンポーネントの Docker イメージと Helm チャートが含まれます。
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

データベース初期化タスクを簡単に実行できるようにするために、{{ site.data.keys.product_adj }} *DB 初期化*コンポーネントが使用されます。 これにより、(必要に応じて) データベースで Mobile Foundation スキーマおよび表の作成が処理されます (存在しない場合)。

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード
{: #load-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product }} の PPA アーカイブをロードする前に、Docker をセットアップする必要があります。 [こちら](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html)の説明を参照してください。

以下のステップに従って、PPA アーカイブを {{site.data.keys.prod_icp }} クラスターにロードします。

  1. IBM Cloud ICP プラグイン (`cloudctl`) を使用してクラスターにログインします。
      >{{ site.data.keys.prod_icp }} 資料で、[CLI コマンド・リファレンス](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html)を参照してください。

     以下に例を示します。

     ```bash
     cloudctl login -a https://ip:port
     ```
      オプションで、SSL 検証をスキップする場合は、上記のコマンドでフラグ `--skip-ssl-validation` を使用します。 このオプションを使用すると、クラスター・エンドポイントの `username` と `password` の入力を求めるプロンプトが出されます。 ログインに成功したら、以下のステップに進んでください。

  2. 以下のコマンドを使用して、{{ site.data.keys.product }} の PPA アーカイブをロードします。
     ```
     cloudctl catalog load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
     ```
     {{ site.data.keys.product }} の *archive_name* は、IBM パスポート・アドバンテージからダウンロードした PPA アーカイブの名前です。

     前のステップに従い、クラスター・エンドポイントを `cloudctl` のデフォルトにした場合、`--clustername` は無視できます。

  3.  {{site.data.keys.prod_icp }} 管理コンソールで、Docker イメージおよび Helm チャートを表示します。
      Docker イメージを表示するには、以下のようにします。
      * **「プラットフォーム」>「コンテナー・イメージ (Container Images)」**を選択します。
      * Helm チャートが**「カタログ」**に表示されます。

  上記のステップを完了すると、アップロードされたバージョンの {{site.data.keys.prod_adj }} Helm チャートが ICP カタログに表示されます。 {{ site.data.keys.mf_server }} は **ibm-mobilefoundation-prod** としてリストされます。

## IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成
{: #configure-install-mf-helmcharts}

{{site.data.keys.mf_server }} をインストールし、構成するには、以下のものが事前に必要になります。

このセクションでは、秘密の作成手順について説明します。

秘密オブジェクトを使用すると、パスワード、OAuth トークン、ssh キーなどの機密情報を保管および管理できます。 このような情報は、ポッド定義やコンテナー・イメージに保管するよりも、秘密に保管した方がより安全でフレキシブルです。

1. (必須) Mobile Foundation サーバーおよび Application Center コンポーネントの技術データを保管するために、事前構成済みのデータベースが必要です。

   以下のサポートされている DBMS のいずれかを使用する必要があります。

     1. **IBM DB2**
     2. **MySQL**
     3. **Oracle**

   ***Oracle または MySQL データベース***を使用する場合、以下の手順に従います。

   - Oracle および MySQL 用の JDBC ドライバーは、Mobile Foundation インストーラーには含まれていません。 JDBC ドライバーがあることを確認します (MySQL の場合、Connector/J JDBC ドライバーを使用し、Oracle の場合、Oracle シン JDBC ドライバーを使用します)。 マウントされたボリュームを作成し、JDBC ドライバーをロケーション `/nfs/share/dbdrivers` に配置します。

   - NFS ホストの詳細、および JDBC ドライバーが保管されているパスを指定して、永続ボリューム (PV) を作成します。 以下は、サンプルの `PersistentVolume.yaml` です。
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
      > 注: 上記の yaml に必ず <nfs_server> エントリーと <nfs_path> エントリーを追加してください。

    - 永続ボリューム要求 (PVC) を作成し、デプロイ時に Helm チャートで PVC 名を指定します。 以下は、サンプルの `PersistentVolumeClaim.yaml` です。
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
   >注: 上記の yaml に正しい名前空間を追加したことを確認します。

2. (必須) Server、Analytics、および Application Center コンソールへのログインでは、事前に作成した**ログイン秘密**が必要です。 例えば、次のとおりです。

   ```bash
   kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
   ```

   Analytics の場合。

   ```bash
   kubectl create secret generic analyticslogin --from-literal=ANALYTICS_ADMIN_USER=admin --from-literal=ANALYTICS_ADMIN_PASSWORD=admin
   ```

   Application Center の場合。

   ```bash
   kubectl create secret generic appcenterlogin --from-literal=APPCENTER_ADMIN_USER=admin --from-literal=APPCENTER_ADMIN_PASSWORD=admin
   ```

   > 注: これらの秘密が提供されていない場合、Mobile Foundation Helm チャートのデプロイ時に、デフォルトのユーザー名とパスワード (admin/admin) を使用して作成されます。

3. (オプション) 独自の鍵ストアとトラストストアを使用する秘密を作成することで、Server、Push、Analytics、および Application Center デプロイメントに対して独自の鍵ストアとトラストストアを提供できます。

   リテラル KEYSTORE_PASSWORD および TRUSTSTORE_PASSWORD を使用して鍵ストアおよびトラストストアのパスワードとともに `keystore.jks` および `truststore.jks` を含む秘密を事前に作成し、各構成要素の keystoreSecret フィールドに秘密名を指定します。

   以下のように、ファイル `keystore.jks`、`truststore.jks` とそのパスワードを保持します。  

   例えば、次のとおりです。

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > 注: ファイルおよびリテラルの名前は、上記のコマンドで示したものと同じでなければなりません。	Helm チャートの構成時にデフォルトの鍵ストアをオーバーライドするには、各構成要素の `keystoresSecretName` 入力フィールドにこの秘密名を指定します。

4. (オプション) 外部クライアントがホスト名を使用して Mobile Foundation コンポーネントに到達できるようにするために、ホスト名ベースの入口を使用してそれらの Mobile Foundation コンポーネントを構成できます。 この入口は、TLS の秘密鍵と証明書を使用することで保護できます。 TLS の秘密鍵と証明書は、`tls.key` および `tls.crt` という鍵名を使用して秘密で定義する必要があります。

   以下のコマンドを使用すると、入口リソースと同じ名前空間に秘密 **mf-tls-secret** が作成されます。

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   その後、global.ingress.secret フィールドに秘密の名前を指定します。

   > 注: 他の Helm リリースに対して入口ホスト名が既に使用されている場合、同じ入口ホスト名は使用しないでください。

5. (オプション) 構成をカスタマイズするには (例: ログ・トレース設定を変更する、新しい jndi プロパティーを追加するなど)、構成 XML ファイルを使用して configmap を作成する必要があります。 これにより、新しい構成設定を追加することや、Mobile Foundation コンポーネントの既存の構成をオーバーライドすることができます。

    Mobile Foundation コンポーネントは、configMap (mfpserver-custom-config) を介してカスタム構成にアクセスします。これは、以下のように作成できます。

	```bash
	kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
	```

    上記のコマンドを使用して作成した configmap を、Mobile Foundation のデプロイ時に Helm チャートの**カスタム・サーバー構成**で指定する必要があります。

    以下は、mfpserver-custom-config configmap を使用してトレース・ログ仕様を「warning」に設定する例です (デフォルト設定は「info」)。

    - サンプル構成 XML (logging.xml)

	```bash
    <server>
          <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
          maxFileSize="20" />
    </server>
	```

    - configmap を作成し、Helm チャートのデプロイメント時に同じ内容を追加する

	```bash
    kubectl create configmap mfpserver-custom-config --from-file=logging.xml
	```

    - (Mobile Foundation コンポーネントの) messages.log の変更に注意してください - ***プロパティー traceSpecification を com.ibm.mfp.=debug:\*=warning に設定します。***

6. (オプション) Mobile Foundation サーバーを、管理サービスの機密クライアントを使用して事前定義します。 これらのクライアントの資格情報は、`mfpserver.adminClientSecret` フィールドと `mfpserver.pushClientSecret` フィールドに指定します。

   これらの秘密は、以下のように作成できます。

   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > 注: Mobile Foundation Helm チャートのデプロイメント時に `mfpserver.pushClientSecret` フィールドと `mfpserver.adminClientSecret` フィールドに値を指定しなかった場合、`mfpserver.adminClientSecret` に対してはデフォルトの認証 ID/クライアント秘密である `admin/nimda` が、`mfpserver.pushClientSecret` に対してはデフォルトの認証 ID/クライアント秘密である `push/hsup` が生成され、使用されます。

7. Analytics デプロイメントの場合、Analytics データを保持するために以下のオプションを選択できます。

    a) `永続ボリューム (PV)` および`永続ボリューム要求 (PVC)` を準備し、Helm チャートで PVC 名を指定するには

      例えば、次のとおりです。

      サンプル `PersistentVolume.yaml`

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

    > 注: 上記の yaml に <nfs_server> エントリーと <nfs_path> エントリーを追加したことを確認します。

      サンプル `PersistentVolumeClaim.yaml`

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

    > 注: 上記の yaml に正しい <namespace> を追加したことを確認します。

    b) チャートで動的プロビジョニングを選択するには

8. (必須) Server、Push、および Application Center に対して**データベース秘密**を作成します。
このセクションでは、データベースへのアクセスを制御するためのセキュリティー・メカニズムについて説明します。 指定のサブコマンドを使用して秘密を作成し、データベースの詳細で作成した秘密の名前を指定します。

   以下のコード・スニペットを実行して、Mobile Foundation サーバーのデータベース秘密を作成します。

   ```bash
	# mfpserver 秘密を作成する
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

   以下のコード・スニペットを実行して、Application Center のデータベース秘密を作成します。

   ```bash
	# appcenter 秘密を作成する
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

   > 注: 以下のコマンドを使用してユーザー名とパスワードの詳細をエンコードできます。

   ```bash
	export $MY_USER_NAME=<myuser>
	export $MY_PASSWORD=<mypassword>

	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```

   このセクションでは、データベースへのアクセスを制御するためのセキュリティー・メカニズムについて説明します。 指定のサブコマンドを使用して秘密を作成し、データベースの詳細で作成した秘密の名前を指定します。

9. (オプション) 個別のデータベース管理秘密を指定できます。 データベース管理秘密で指定されているユーザー詳細を使用して DB 初期化タスクが実行されます。これにより、必要な Mobile Foundation スキーマと表がデータベースに作成されます (存在しない場合)。 データベース管理秘密を使用して、データベース・インスタンスでの DDL 操作を制御できます。

    `MFP サーバー DB 管理秘密`および `MFP Appcenter DB 管理秘密`の詳細が指定されていない場合、デフォルトの`データベース秘密名`を使用して DB 初期化タスクが実行されます。

    Mobile Foundation サーバー用の `MFP サーバー DB 管理秘密`を作成するには、以下のコード・スニペットを実行します。

      ```bash
      # Mobile Foundation サーバー・コンポーネントのデプロイ時に、MFP サーバー DB 管理秘密を作成して、Helm チャートで同じものを更新する
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

    Mobile Foundation サーバー用の `MFP Appcenter DB 管理秘密`を作成するには、以下のコード・スニペットを実行します。      

      ```bash
      # Mobile Foundation AppCenter コンポーネントのデプロイ時に、Appcenter DB 管理秘密を作成して、Helm チャートで同じものを更新する
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

10. (オプション) コンテナー・イメージが IBM Cloud Private セットアップのコンテナー・レジストリー (DockerHub、プライベート Docker レジストリーなど) の外部にあるレジストリーからプルされる場合、コンテナーの**イメージ・ポリシー**および**イメージ・プル秘密**を作成します。

   ```bash
	# イメージ・ポリシーを作成する
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

   > 注: < > 内のテキストを正しい値で更新する必要があります。


   詳しくは、[MobileFirst Server 鍵ストアの構成]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)を参照してください。

### PodSecurityPolicy の要件

このチャートでは、デプロイメント前に PodSecurityPolicy をターゲット名前空間にバインドする必要があります。 事前定義の PodSecurityPolicy を選択するか、クラスター管理者にカスタム PodSecurityPolicy の作成を依頼してください。

* 事前定義の PodSecurityPolicy 名: [`ibm-restricted-psp`](https://ibm.biz/cpkspec-psp)
* カスタム PodSecurityPolicy 定義:

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
	  - ALL
	  volumes:
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

   * カスタム PodSecurityPolicy のカスタム ClusterRole:

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
    > 注: PodSecurityPolicy は 1 回のみ作成する必要があります。PodSecurityPolicy が既に存在する場合、この手順はスキップしてください。

   クラスター管理者は、上記の PSP 定義および ClusterRole 定義を UI のリソース作成画面に貼り付けること、または以下の 2 つのコマンドを実行することができます。

```bash
    kubectl create -f <PSP yaml file>
    kubectl create clusterrole ibm-mobilefoundation-prod-psp-clusterrole --verb=use --resource=podsecuritypolicy --resource-name=ibm-mobilefoundation-prod-psp
```

   `RoleBinding` も作成する必要があります。

```bash
    kubectl create rolebinding ibm-mobilefoundation-prod-psp-rolebinding --clusterrole=ibm-mobilefoundation-prod-psp-clusterrole --serviceaccount=<namespace>:default --namespace=<namespace>
```

## 必要なリソース
{: #resources-required}

このチャートでは、デフォルトでは以下のリソースが使用されます。

| コンポーネント | CPU  | メモリー | ストレージ
|---|---|---|---|
| Mobile Foundation サーバー | **要求/最小:** 1000m CPU、**制限/最大:** 2000m CPU | **要求/最小:** 2048 Mi メモリー、**制限/最大:** 4096 Mi メモリー | データベースの要件については、[IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。
| Mobile Foundation Push | **要求/最小:** 1000m CPU、**制限/最大:** 2000m CPU | **要求/最小:** 2048 Mi メモリー、**制限/最大:** 4096 Mi メモリー  | データベースの要件については、[IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。
| Mobile Foundation Analytics | **要求/最小:** 1000m CPU、**制限/最大:** 2000m CPU  | **要求/最小:** 2048 Mi メモリー、**制限/最大:** 4096 Mi メモリー  | 永続ボリューム。 詳しくは、[IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。
| Mobile Foundation Application Center | **要求/最小:** 1000m CPU、**制限/最大:** 2000m CPU | **要求/最小:** 2048 Mi メモリー、**制限/最大:** 4096 Mi メモリー  | データベースの要件については、[IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)を参照してください。

## 構成
{: #configuration}

### パラメーター
以下の表に、{{ site.data.keys.prod_icp }} 上の {{ site.data.keys.mf_server }} インスタンス、{{ site.data.keys.mf_analytics }}、{{ site.data.keys.mf_push }}、および {{ site.data.keys.mf_appcenter }} で使用される環境変数を示します。

| 修飾子 | パラメーター  | 定義 | 使用可能な値 |
|---|---|---|---|
| global.arch |  amd64    | ハイブリッド・クラスター内の amd64 ワーカー・ノード・スケジューラー設定 | 3 - 最優先 (デフォルト) |
|      |  ppcle64  | ハイブリッド・クラスター内の ppc64le ワーカー・ノード・スケジューラー設定 | 2 - 優先なし (デフォルト) |
|      |  s390x    | ハイブリッド・クラスター内の S390x ワーカー・ノード・スケジューラー設定 | 2 - 優先なし (デフォルト) |
| global.image     | pullPolicy | イメージ・プル・ポリシー | Always、Never、または IfNotPresent デフォルト: IfNotPresent |
|      |  pullSecret    | イメージ・プル秘密 | イメージが ICP イメージ・レジストリーでホストされない場合にのみ必要です。 |
| global.ingress | hostname | 外部クライアントで使用される外部ホスト名または IP アドレス | ブランクのままにすると、デフォルトではクラスター・プロキシー・ノードの IP アドレスが設定されます。|
|         | secret | TLS 秘密名| 入口定義で使用する必要のある証明書の秘密の名前を指定します。 関連する証明書と鍵を使用して秘密を事前に作成する必要があります。 SSL/TLS が有効の場合は必須です。 ここに名前を指定する前に証明書と鍵を使用して秘密を事前に作成します。 |
|         | sslPassThrough | SSL パススルーの有効化 | SSL 要求を Mobile Foundation サービスにパススルーする必要があることを指定します。Mobile Foundation サービスで SSL の終了が発生します。 デフォルト: false |
| global.dbinit | enabled | Server、Push、および Application Center のデータベースの初期化の有効化 | Server、Push、および Application Center デプロイメント用のデータベースを初期化し、スキーマ/表を作成します (Analytics では不要)。 デフォルト: true |
|  | repository | データベース初期化用の Docker イメージ・リポジトリー | Mobile Foundation データベース Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
| mfpserver | enabled          | Server を有効にするためのフラグ | true (デフォルト) または false |
| mfpserver.image | repository | Docker イメージ・リポジトリー | Mobile Foundation サーバー Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
|  mfpserver.db | host | Mobile Foundation サーバー表を構成する必要があるデータベースの IP アドレスまたはホスト名 | IBM DB2® (デフォルト) |
|                       | port | 	データベースがセットアップされているポート | |
|                       | secret | データベース資格情報が含まれる事前に作成された秘密| |
|                       | name | Mobile Foundation サーバー・データベースの名前 | |
|                       | schema | 作成する Server DB スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。 それ以外の場合、作成されます。 |
|                       | ssl | データベース接続タイプ  | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は false (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
|                       | driverPvc | JDBC データベース・ドライバーにアクセスするための永続ボリューム要求| JDBC データベース・ドライバーをホストする永続ボリューム要求の名前を指定します。 選択したデータベース・タイプが DB2 ではない場合は必須です。 |
|                       | adminCredentialsSecret | MFPServer DB 管理秘密 | DB の初期化を有効にした場合、Mobile Foundation コンポーネント用のデータベース表およびスキーマを作成するために秘密を指定します。 |
| mfpserver | adminClientSecret | 管理クライアント秘密 | 作成したクライアント秘密の名前を指定します。 [前提条件](#Prerequisites)の 6 番を参照してください。 |
|  | pushClientSecret | Push クライアント秘密 | 作成したクライアント秘密の名前を指定します。 [前提条件](#Prerequisites)の 6 番を参照してください。 |
| mfpserver.replicas |  | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: 3) |
| mfpserver.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicas フィールドが無効になるので注意してください。 | false (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 下限値より小さくすることはできません。 | 正整数 (デフォルトは 10) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| mfpserver.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
|    mfpserver.customConfiguration |  |  カスタム・サーバー構成 (オプション)  | 事前に作成した構成マップに対して Server 固有の追加構成リファレンスを提供します。 |
| mfpserver.jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。 |
| mfpserver | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpserver.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfppush | enabled          | Mobile Foundation Push を有効にするためのフラグ | true (デフォルト) または false |
|           | repository   | Docker イメージ・リポジトリー |Mobile Foundation Push Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
| mfppush.replicas | | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: 3) |
| mfppush.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | false (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは 10) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| mfppush.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| mfppush.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Push 固有の追加構成リファレンスを提供します。 |
| mfppush.jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。 |
| mfppush | keystoresSecretName | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfppush.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfpanalytics | enabled          | Analytics を有効にするためのフラグ | false (デフォルト) または true |
| mfpanalytics.image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Operational Analytics Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
| mfpanalytics.replicas |  | 作成する必要がある Mobile Foundation Operational Analytics のインスタンス (ポッド) の数 | 正整数 (デフォルト: 2) |
| mfpanalytics.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | false (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは 10) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
|  mfpanalytics.shards|  | Mobile Foundation Analytics の Elasticsearch シャードの数 | デフォルトは 2|             
|  mfpanalytics.replicasPerShard|  | Mobile Foundation Analytics のシャードごとに維持する Elasticsearch レプリカの数 | デフォルトは 2|
| mfpanalytics.persistence | enabled         | PersistentVolumeClaim を使用してデータを永続化します。                        | true |                                                 |
|            |useDynamicProvisioning      | storageclass を指定するか、空のままにします。  | false  |                                                  |
|           |volumeName| ボリューム名を指定します。  | data-stor (デフォルト) |
|           |claimName| 既存の PersistentVolumeClaim を指定します。  | nil |
|           |storageClassName     | バッキング PersistentVolumeClaim のストレージ・クラス | nil |
|           |size             | データ・ボリュームのサイズ      | 20Gi |
| mfpanalytics.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
|    mfpanalytics.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Analytics 固有の追加構成リファレンスを提供します。 |
| mfpanalytics.jndiConfigurations | mfpfProperties | Operational Analytics をカスタマイズするために指定する Mobile Foundation JNDI プロパティー| 名前と値のペアをコンマで区切って指定します。  |
| mfpanalytics | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpanalytics.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfpappcenter | enabled          | Application Center を有効にするためのフラグ | false (デフォルト) または true |  
| mfpappcenter.image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Application Center Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
|  mfpappcenter.db | host | Appcenter データベースを構成する必要があるデータベースの IP アドレスまたはホスト名	| |
|                       | port | 	データベースのポート  | |             
|                       | name | 使用するデータベースの名前 | データベースを事前に作成する必要があります。|
|                       | secret | データベース資格情報が含まれる事前に作成された秘密| |
|                       | schema | 作成する Application Center データベース・スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。 存在しない場合は、作成されます。 |
|                       | ssl |データベース接続タイプ  | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は false (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
|                       | driverPvc | 	JDBC データベース・ドライバーにアクセスするための永続ボリューム要求  | JDBC データベース・ドライバーをホストする永続ボリューム要求の名前を指定します。 選択したデータベース・タイプが DB2 ではない場合は必須です。 |
|                       | adminCredentialsSecret | Application Center DB 管理秘密 | DB の初期化を有効にした場合、Mobile Foundation コンポーネント用のデータベース表およびスキーマを作成するために秘密を指定します。 |
| mfpappcenter.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | false (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは 10) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| mfpappcenter.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| mfpappcenter.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Application Center 固有の追加構成リファレンスを提供します。 |
| mfpappcenter | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpappcenter.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 1024Mi です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 1024Mi です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |

> Kibana を使用して {{ site.data.keys.prod_adj }} ログを分析する場合のチュートリアルについては、[こちら](analyzing-mobilefirst-logs-on-icp/)を参照してください。

### ICP カタログからの {{site.data.keys.prod_adj }} Helm チャートのインストール
{: #install-hmc-icp}

#### {{ site.data.keys.mf_server }} のインストール
{: #install-mf-server}

{{ site.data.keys.mf_server }} とともに、同じチャートから {{ site.data.keys.mf_analytics }} と {{ site.data.keys.mf_app_center }} もデプロイできます。 ただし、{{ site.data.keys.mf_analytics }} と {{ site.data.keys.mf_app_center }} のデプロイはオプションです。

注:

1. {{site.data.keys.mf_server }} のインストールを開始する前に、DB2 データベースが事前構成されていることを確認してください。
2. {{site.data.keys.mf_analytics }} チャートのインストールを開始する前に、**永続ボリューム**を構成します。 {{ site.data.keys.mf_analytics }} を構成するための**永続ボリューム**を提供します。 [{{ site.data.keys.prod_icp }}の資料](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_cluster/create_volume.html)で詳しく説明されている手順に従い、**永続ボリューム**を作成します。 サンプル yaml ファイルについて、[IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)の**セクション 6**も参照してください。

以下のステップに従って、{{site.data.keys.prod_icp }} 管理コンソールから IBM Mobile Foundation をインストールし、構成します。

1. 管理コンソールで**「カタログ」**に移動します。
2. **ibm-mobilefoundation-prod** Helm チャートを選択します。
3. **「構成」**をクリックします。
4. 環境変数を指定します。 詳しくは、[構成](#configuration)を参照してください。
5. **「ご使用条件 (License Agreement)」**に同意します。
6. **「インストール」**をクリックします。

> 注: 最新の Mobile Foundation on ICP パッケージには、サポートされている以下のソフトウェアがバンドルされています。
> 1. IBM JRE8 SR5 FP37 (8.0.5.37)
> 2. IBM WebSphere Liberty v18.0.0.5

## インストールの検査
{: #verify-install}

{{site.data.keys.mf_analytics }} (オプション) および {{site.data.keys.mf_server }} のインストールと構成が完了したら、以下を実行することにより、インストール済み環境およびデプロイされたポッドの状況を検査できます。

{{ site.data.keys.prod_icp }} 管理コンソールで、**「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」**を選択します。 インストール済み環境の*リリース名* をクリックします。

## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

インストールが成功した後、デプロイメントが完了するまで数分かかる場合があります。

Web ブラウザーから IBM Cloud Private コンソール・ページに移動し、以下のように Helm リリース・ページに移動します。
1. ページの左上にある「メニュー」をクリックします。
2. 「ワークロード (Workloads)」>「Helm リリース (Helm Releases)」を選択します。
3. デプロイ済みの IBM Mobile Foundation Helm リリースをクリックします。
4. Mobile Foundation サーバーの Operations Console にアクセスする手順については、[注](https://github.ibm.com/MobileFirst/ibm-mobilefoundation-prod/blob/development/stable/ibm-mobilefoundation-prod/templates/NOTES.txt)セクションを参照してください。

## サンプル・アプリケーション
{: #sample-app}
{{ site.data.keys.prod_icp }} で実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## {{ site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード
{: #upgrading-mf-helm-charts}

Helm チャート/リリースをアップグレードする方法については、[バンドル製品のアップグレード](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)を参照してください。

### Helm リリース・アップグレードのサンプル・シナリオ

1. `values.yaml` の値の変更によって Helm リリースをアップグレードするには、`--set` フラグを指定した **helm upgrade** コマンドを使用します。 **-set** フラグは複数回指定できます。 コマンド・ラインで指定された右端のセットの優先順位が最も高くなります。

  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. ファイル内に値を指定して Helm リリースをアップグレードするには、**-f** フラグを指定した `helm upgrade` コマンドを使用します。 **--values** フラグまたは **-f** フラグは複数回使用できます。 コマンド・ラインで指定された右端のファイルの優先順位が最も高くなります。 以下の例で、`myvalues.yaml` と `override.yaml` の両方に *Test* というキーが含まれている場合、`override.yaml` に設定された値が優先されます。

  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. 最後のリリースの値を再利用し、値の一部をオーバーライドすることによって Helm リリースをアップグレードするには、以下のようなコマンドを使用できます。

  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## Mobile Foundation Platform 用の IBM Certified Cloud Pak へのマイグレーション
{: #migrate}

[IBM Certified Cloud Pak](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/app_center/cloud_paks_over.html) を使用すると、Mobile Foundation を単一 Helm チャートとしてのデプロイメントで使用できます。 これにより、Mobile Foundation コンポーネントをデプロイするために 3 つの異なる Helm チャート (viz.ibm-mfpf-server-prod、ibm-mfpf-analytics-prod、および ibm-mfpf-appcenter-prod) を使用する以前の方法が置き換えられます。

ICP デプロイメントで個別の Helm リリースとしてインストールされた古い Mobile Foundation コンポーネントから、IBM Certified Cloud Pak を使用する新しい単一の統合 Helm チャートへのマイグレーションは簡単です。

1. Server、Push、Application Center、および Analytics のすべての構成パラメーターを保持できます。
2. 古いデプロイメントと同様のデータベース詳細が使用される場合、新しい Mobile Foundation デプロイメント (Server、Push、および Application Center) で、古いデプロイメントと同じデータが使用されます。
3. 入力するデータベース値の変更に注意してください。 データベースへのアクセスは、秘密を通じて制御されるようになりました。 [前提条件](#Prerequisites)のセクション 4 を参照して、資格情報 (コンソール・ログイン、データベース・アカウントなど) の秘密を作成してください。
4. 古いデプロイメントで使用されていた同じ永続ボリューム要求を再使用することで、Mobile Foundation Analytics データを保持できます。

## MFP Analytics データのバックアップおよびリカバリー
{: #backup-analytics}

MFP Analytics データは、Kubernetes [PersistentVolume または PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) の一部として使用できます。 [Kubernetes が提供するボリューム・プラグイン](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes)のいずれかを使用します。

バックアップおよびリストアは、使用するボリューム・プラグインに基づきます。 ボリュームをバックアップまたはリストアできるさまざまな手段/ツールがあります。

Kuberenetes は、[**VolumeSnapshot、VolumeSnapshotContent、および Restore のオプション**](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature)を提供しています。 管理者がプロビジョンした[クラスター内のボリューム](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction)のコピーを作成できます。

以下の[サンプル yaml ファイル](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes)を使用して、スナップショット機能をテストします。

また、他のツールを利用して、ボリュームのバックアップを作成すること、およびその同じバックアップをリストアすることもできます。

- ICP 上の IBM Cloud Automation Manager (CAM)

    CAM の機能、および [CAM インスタンスのバックアップ/リストア、高可用性 (HA)、および災害復旧 (DR)](https://developer.ibm.com/cloudautomation/2018/05/08/backup-ha-dr/) の戦略を利用します。

- ICP 上の [Portworx](https://portworx.com)

    コンテナーとして、または Kubernetes などのコンテナー・オーケストレーターを介してデプロイされるアプリケーション用に設計されたストレージ・ソリューションです。

- [AppsCode](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) によるスタッシュ

    スタッシュを使用すると、Kubernetes でボリュームをバックアップできます。

## アンインストール
{: #uninstall}
{{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。
以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。

```bash
helm delete <my-release> --purge --tls
```
*my-release* は、デプロイ済みの Helm チャートのリリース名です。

このコマンドにより、チャートに関連付けられているすべての Kubernetes コンポーネント (永続ボリューム要求 (PVC) 以外) が削除されます。 このデフォルトの Kubernetes 動作では、有用なデータは削除されません。
