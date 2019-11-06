---
layout: tutorial
title: Helm を使用した IBM Cloud Kubernetes クラスター上の Mobile Foundation のセットアップ
breadcrumb_title: Foundation on Kubernetes using Helm
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下の指示に従い、Helm チャートを使用して IBM Cloud Kubernetes クラスター (IKS) 上で {{ site.data.keys.mf_server }} インスタンス、{{ site.data.keys.mf_push }}、{{ site.data.keys.mf_analytics }} インスタンス、および {{ site.data.keys.mf_app_center}} インスタンスを構成します。

以下は、入門のための基本的な手順です。<br/>
* 前提条件を満たす
* {{ site.data.keys.prod_icp }} 用の {{ site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA アーカイブ) をダウンロードする
* IBM Cloud Kubernetes クラスターに PPA アーカイブをロードする
* {{ site.data.keys.mf_server }}、{{ site.data.keys.mf_analytics }} (オプション)、および {{ site.data.keys.mf_app_center}} (オプション) をインストールし、構成する

#### ジャンプ先:
{: #jump-to }
* [前提条件](#prereqs)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード](#download-the-ibm-mfpf-ppa-archive)
* [IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード](#load-the-ibm-mfpf-ppa-archive)
* [環境変数](#env-variables)
* [IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成](#configure-install-mf-helmcharts)
* [Helm チャートのインストール](#install-hmc-icp)
* [インストールの検査](#verify-install)
* [サンプル・アプリケーション](#sample-app)
* [{{site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード](#upgrading-mf-helm-charts)
* [アンインストール](#uninstall)
* [トラブルシューティング](#troubleshooting)

## 前提条件
{: #prereqs}

[**IBM Cloud アカウント**](http://cloud.ibm.com/)が必要であり、[**IBM Cloud Kubernetes クラスター**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial)をセットアップしておく必要があります。

コンテナーおよびイメージを管理するために、IBM Cloud CLI プラグイン・セットアップの一部としてホスト・マシンに以下をインストールします。

* IBM Cloud CLI (`ibmcloud`)
* Kubernetes CLI (`kubectl`)
* IBM Cloud Container Registry プラグイン (`cr`)
* IBM Cloud Container Service プラグイン (`ks`)
* [Docker](https://docs.docker.com/install/) をインストールし、セットアップする
* Helm (`helm`)
CLI を使用して Kubernetes クラスターを処理するために、*ibmcloud* クライアントを構成する必要があります。
1. [クラスター・ページ](https://cloud.ibm.com/kubernetes/clusters)にログインしていることを確認します。(注: [IBMid アカウント](https://myibm.ibm.com/)が必要です。)
2. IBM Mobile Foundation Chart をデプロイする先の Kubernetes クラスターをクリックします。
3. クラスターが作成された後、**「アクセス」**タブの指示に従います。
>**注:** クラスターの作成には数分かかります。クラスターが正常に作成された後、**「ワーカー・ノード (Worker Nodes)」**タブをクリックし、*パブリック IP* をメモします。

CLI を使用して IBM Cloud Kubernetes クラスターにアクセスするために、IBM Cloud クライアントを構成する必要があります。 [詳細はこちら](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started)。

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのダウンロード
{: #download-the-ibm-mfpf-ppa-archive}
{{site.data.keys.product_full }} のパスポート・アドバンテージ・アーカイブ (PPA) は、[ここ](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)から入手できます。 {{site.data.keys.product }} の PPA アーカイブには、以下の {{site.data.keys.product }} コンポーネントの Docker イメージと Helm チャートが含まれます。
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

データベース初期化タスクを簡単に実行できるようにするために、{{ site.data.keys.product_adj }} *DB 初期化*コンポーネントが使用されます。これにより、(必要に応じて) データベースで Mobile Foundation スキーマおよび表の作成が処理されます (存在しない場合)。

## IBM Mobile Foundation パスポート・アドバンテージ・アーカイブのロード
{: #load-the-ibm-mfpf-ppa-archive}

以下のステップに従って、PPA アーカイブを IBM Cloud Kubernetes クラスターにロードします。

  1. IBM Cloud プラグインを使用してクラスターにログインします。 コマンド・リファレンスについては、IBM Cloud CLI の資料 (https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview) を参照してください。

      以下に例を示します。
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
      統合 ID を使用する場合、`--sso` オプションを組み込みます。オプションとして SSL の検証をスキップできます。上記のコマンドで `--skip-ssl-validation` フラグを使用します。これにより、HTTP 要求の SSL 検証がバイパスされます。このパラメーターを使用すると、セキュリティーの問題が発生する場合があります。

  2. IBM Cloud Container Registry にログインし、以下のコマンドを使用して Container Service を初期化します。
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. 以下のコマンドを使用してデプロイメントの地域を設定します (例えば、米国南部)。
      ```bash
      ibmcloud cr region-set
      ```  

  4. 以下の手順に従い、クラスターへのアクセス権限を取得します。

      1. いくつかの CLI ツールと Kubernetes Service のプラグインをダウンロードし、インストールします。
      ```bash
      curl -sL https://ibm.biz/idt-installer | bash
      ```

      2. ご使用のクラスター用の kubeconfig ファイルをダウンロードします。
      ```bash
      ibmcloud ks cluster-config --cluster my_cluster_name
      ```

      3. *KUBECONFIG* 環境変数を設定します。前のコマンドからの出力をコピーし、ご使用の端末に貼り付けます。コマンド出力は、以下の例のようになります。
      ```bash
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/my_namespace/kube-config-dal10-my_namespace.yml
      ```

      4. ワーカー・ノードをリストして、クラスターに接続できることを確認します。
      ```bash
      kubectl get nodes
      ```

  5. 以下のステップを実行して、{{ site.data.keys.product }} のPPA アーカイブをロードします。
       1. PPA アーカイブを**解凍**します。
       2. ロードしたイメージに、IBM Cloud Container レジストリー名前空間と適切なバージョンの**タグ**を付けます。
       3. イメージを**プッシュ**します。
       4. (オプション) ワーカー・ノードがアーキテクチャー (amd64、ppc64le、s390x など) の組み合わせに基づく場合、マニフェストを作成し、その**マニフェストをプッシュ**します。

      以下は、**amd64** アーキテクチャーに基づいたワーカー・ノードに **mfpf-server** イメージと **mfpf-push** イメージをロードする例です。**mfpf-appcenter** および **mfpf-analytics** についても同じプロセスに従う必要があります。

      ```bash

      # 1. Extract the PPA archive

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Tag the loaded images with the IBM Cloud Container registry namespace and with the right version

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0

      # 3. Push all the images

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 4. Cleanup the extracted archive

      rm -rf ppatmp
      ```

      以下は、**マルチアーキテクチャー**に基づくワーカー・ノードに **mfpf-server** イメージと **mfpf-push** イメージをロードする例です。**mfpf-appcenter** および **mfpf-analytics** についても同じプロセスに従う必要があります。

      ```bash
      # 1. Extract the PPA archive

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Tag the loaded images with the IBM Cloud Container registry namespace and with the right version

      ## 2.1 Tagging mfpf-server

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker tag mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker tag mfpf-server:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 2.2 Tagging mfpf-dbinit

      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker tag mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker tag mfpf-dbinit:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 2.3 Tagging mfpf-push

      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker tag mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker tag mfpf-push:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 3. Push all the images

      ## 3.1 Pushing mfpf-server images

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 3.3 Pushing mfpf-dbinit images

      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 3.3 Pushing mfpf-push images

      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 4. [Optional] Create and Push the manifests

      ## 4.1 Create manifest-lists

      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      ## 4.2 Annotate the manifests

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

      ## 4.3 Push the manifest list

      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 5. Cleanup the extracted archive

      rm -rf ppatmp
      ```

   >**注:**
   > 1. `ibmcloud cr ppa-archive load` コマンドによるアプローチは、マルチ・アーキテクチャー・サポートを備えた PPA パッケージをサポートしていません。 したがって、パッケージを解凍して手動で IBM Cloud Container リポジトリーにプッシュする必要があります (古い PPA バージョンを使用しているユーザーは、次のコマンドを使用してロードする必要があります)。

   > 2. マルチ・アーキテクチャーとは intel (amd64)、power64 (ppc64le)、s390x などのアーキテクチャーを指します。 マルチ・アーキテクチャーは ICP 3.1.1 以降でのみサポートされます。

  ```bash
  ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
  ```
   {{ site.data.keys.product }} の *archive_name* は、IBM パスポート・アドバンテージからダウンロードした PPA アーカイブの名前です。

   Helm チャートは、(IBM Cloud Private Helm リポジトリーに保管される ICP Helm チャートと異なり) クライアント内に保管されるか、ローカルに保管されます。 チャートは、`ppa-import/charts` (または charts) ディレクトリー内で見つけることができます。

## IBM {{site.data.keys.product }} Helm チャートのインストールおよび構成
{: #configure-install-mf-helmcharts}

{{site.data.keys.mf_server }} をインストールし、構成するには、以下のものが事前に必要になります。

このセクションでは、秘密の作成手順について説明します。

秘密オブジェクトを使用すると、パスワード、OAuth トークン、ssh キーなどの機密情報を保管および管理できます。このような情報は、ポッド定義やコンテナー・イメージに保管するよりも、秘密に保管した方がより安全でフレキシブルです。

* (**必須**) DB2 データベース・インスタンスを構成し、使用できるよう準備する必要があります。[{{site.data.keys.mf_server }} Helm を構成](#install-hmc-icp)するには、データベース情報が必要です。 {{site.data.keys.mf_server }} には、スキーマと表が必要であり、それらがこのデータベースに作成されます (存在しない場合)。

* (**必須**) Server、Push、および Application Center に対して**データベース秘密**を作成します。
このセクションでは、データベースへのアクセスを制御するためのセキュリティー・メカニズムについて説明します。指定のサブコマンドを使用して秘密を作成し、データベースの詳細で作成した秘密の名前を指定します。

以下のコード・スニペットを実行して、Mobile Foundation サーバーのデータベース秘密を作成します。

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

以下のコード・スニペットを実行して、Application Center のデータベース秘密を作成します。

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
   > 注: 以下のコマンドを使用してユーザー名とパスワードの詳細をエンコードできます。

   ```bash
	export $MY_USER_NAME=<myuser>
	export $MY_PASSWORD=<mypassword>

	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```


* (**必須**) Server、Analytics、および Application Center のコンソールにログインするには、事前に作成した**ログイン秘密**が必要です。例えば、次のとおりです。

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

* (**オプション**) 独自の鍵ストアとトラストストアを使用する秘密を作成することで、Server、Push、Analytics、および Application Center デプロイメントに対して独自の鍵ストアとトラストストアを提供できます。

   リテラル KEYSTORE_PASSWORD および TRUSTSTORE_PASSWORD を使用して鍵ストアおよびトラストストアのパスワードとともに `keystore.jks` および `truststore.jks` を含む秘密を事前に作成し、各構成要素の keystoreSecret フィールドに秘密名を指定します。

   以下のように、ファイル `keystore.jks`、`truststore.jks` とそのパスワードを保持します。  

   例えば、次のとおりです。

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > 注: ファイルおよびリテラルの名前は、上記のコマンドで示したものと同じでなければなりません。Helm チャートの構成時にデフォルトの鍵ストアをオーバーライドするには、各構成要素の `keystoresSecretName` 入力フィールドにこの秘密名を指定します。

* (**オプション**) 外部クライアントがホスト名を使用して Mobile Foundation コンポーネントに到達できるようにするために、ホスト名ベースの入口を使用してそれらの Mobile Foundation コンポーネントを構成できます。この入口は、TLS の秘密鍵と証明書を使用することで保護できます。TLS の秘密鍵と証明書は、`tls.key` および `tls.crt` という鍵名を使用して秘密で定義する必要があります。

   以下のコマンドを使用して、入口リソースと同じ名前空間に秘密 **mf-tls-secret** を作成する必要があります。

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   その後、global.ingress.secret フィールドに、入口ホスト名と秘密の名前を指定します。Helm チャートのデプロイ時に **values.yaml** を変更して、適切な入口ホスト名と入口秘密名を追加します。

   > 注: 他の Helm リリースに対して入口ホスト名が既に使用されている場合、同じ入口ホスト名は使用しないでください。

* (**オプション**) Mobile Foundation サーバーを、管理サービスの機密クライアントを使用して事前定義します。これらのクライアントの資格情報は、`mfpserver.adminClientSecret` フィールドと `mfpserver.pushClientSecret` フィールドに指定します。

   これらの秘密は、以下のように作成できます。
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > 注: Mobile Foundation Helm チャートのデプロイメント時に `mfpserver.pushClientSecret` フィールドと `mfpserver.adminClientSecret` フィールドに値を指定しなかった場合、`mfpserver.adminClientSecret` に対してはデフォルトの認証 ID/クライアント秘密である `admin/nimda` が、`mfpserver.pushClientSecret` に対してはデフォルトの認証 ID/クライアント秘密である `push/hsup` が生成され、使用されます。

* (**必須**) Mobile Foundation Analytics Chart のインストールを開始する前に、永続ボリュームと永続ボリューム要求を必要に応じて構成します。永続ボリュームを用意して Mobile Foundation Analytics を構成します。[永続ボリュームの作成に関する IBM Cloud Kubernetes の資料](https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_storage)で詳しく説明されている手順に従います。


## 環境変数
{: #env-variables }
以下の表に、{{ site.data.keys.mf_server }} インスタンス、{{ site.data.keys.mf_analytics }}、{{ site.data.keys.mf_push }}、および {{ site.data.keys.mf_app_center }} で使用される環境変数を示します。

| 修飾子 | パラメーター | 定義 | 使用可能な値 |
|-----------|-----------|------------|---------------|
| ***`グローバル構成`*** | |  |  |
| arch | amd64 | ハイブリッド・クラスター内の amd64 ワーカー・ノード・スケジューラー設定 | 3 - 最優先 (デフォルト)。 |
|  | ppcle64 | ハイブリッド・クラスター内の ppc64le ワーカー・ノード・スケジューラー設定 | 2 - 優先なし (デフォルト)。 |
|  | s390x | ハイブリッド・クラスター内の S390x ワーカー・ノード・スケジューラー設定 | 2 - 優先なし (デフォルト)。 |
| image | pullPolicy | イメージ・プル・ポリシー | デフォルトは **IfNotPresent** |
|  | pullSecret | イメージ・プル秘密 |  |
| ingress | hostname | 外部クライアントで使用される外部ホスト名または IP アドレス | パブリック要求またはプライベート要求をアプリケーションに転送することで、クラスター内のネットワーク・トラフィックの負荷のバランスを取ります。|
|  | secret | TLS 秘密名| 入口定義で使用する必要のある証明書の秘密の名前を指定します。関連する証明書と鍵を使用して秘密を事前に作成する必要があります。SSL/TLS が有効の場合は必須です。ここに名前を指定する前に証明書と鍵を使用して秘密を事前に作成します。|
|  | sslPassThrough | SSL パススルーの有効化 | SSL 要求を Mobile Foundation サービスにパススルーする必要があることを指定します。Mobile Foundation サービスで SSL の終了が発生します。デフォルト: false |
| https | true |  |  |
| dbinit | enabled | Server、Push、および Application Center のデータベースの初期化の有効化 | Server、Push、および Application Center デプロイメント用のデータベースを初期化し、スキーマ/表を作成します (Analytics では不要)。デフォルト: true |
| | repository | データベース初期化用の Docker イメージ・リポジトリー | Mobile Foundation データベース Docker イメージのリポジトリー |
|  | tag | Docker イメージ・タグ | Docker タグの説明を参照 |
|  | replicas | 作成する必要がある Mobile Foundation DBinit のインスタンス ( ポッド ) の数。| 正整数 (デフォルト: 1) |
| ***`MFP Server 構成`*** | | | |
| mfpserver | enabled | Server を有効にするためのフラグ | true (デフォルト) または false |
|  | repository | Docker イメージ・リポジトリー | Mobile Foundation サーバー Docker イメージのリポジトリー |
|  | tag | Docker イメージ・タグ | Docker タグの説明を参照 |
|  | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
|  db | host | Mobile Foundation サーバー表を構成する必要があるデータベースの IP アドレスまたはホスト名 | IBM DB2® (デフォルト) |
| | port | データベースがセットアップされているポート | |
| | secret | データベース資格情報が含まれる事前に作成された秘密| |
| | name | Mobile Foundation サーバー・データベースの名前 | |
|  | schema | 作成する Server DB スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。それ以外の場合、作成されます。|
|  | ssl | データベース接続タイプ | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は false (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
| adminClientSecret | 秘密の名前を指定します。| 管理クライアント秘密 | 作成したクライアント秘密の名前を指定します。[参照](#configure-install-mf-helmcharts) |
| pushClientSecret | 秘密の名前を指定します。| Push クライアント秘密 | 作成したクライアント秘密の名前を指定します。[参照](#configure-install-mf-helmcharts) |
| internalConsoleSecretDetails | consoleUser: "admin" |  |  |
|  | consolePassword: "admin" |  |  |
| internalClientSecretDetails | adminClientSecretId: admin |  |  |
| | adminClientSecretPassword: nimda |  |  |
| | pushClientSecretId: push |  |  |
| | pushClientSecretPassword: hsup |  |  |
| replicas | 3 | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: 3) |
| autoscaling | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。このフィールドを有効にすると、replicas フィールドが無効になるので注意してください。| false (デフォルト) または true |
| | min  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
| | max | Autoscaler によって設定できるポッド数の上限値。下限値より小さくすることはできません。| 正整数 (デフォルトは 10) |
| | targetcpu | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| pdb | enabled | PDB を有効にするか無効にするかを指定します。| true (デフォルト) または false |
| | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。|
| | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| ***`MFP Push 構成`*** | | | |
| mfppush | enabled | Mobile Foundation Push を有効にするためのフラグ | true (デフォルト) または false |
|           | repository | Docker イメージ・リポジトリー | Mobile Foundation Push Docker イメージのリポジトリー |
|           | tag | Docker イメージ・タグ | Docker タグの説明を参照 |
| replicas | | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: 3) |
| autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。| false (デフォルト) または true |
|           | min  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | max | Autoscaler によって設定できるポッド数の上限値。minReplicas より小さくすることはできません。| 正整数 (デフォルトは 10) |
|           | targetcpu | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| pdb     | enabled | PDB を有効にするか無効にするかを指定します。| true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。|
| | keystoresSecretName | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| ***`MFP Analytics 構成`*** | | | |
| mfpanalytics | enabled          | Analytics を有効にするためのフラグ | false (デフォルト) または true |
| image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Operational Analytics Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
| replicas |  | 作成する必要がある Mobile Foundation Operational Analytics のインスタンス (ポッド) の数 | 正整数 (デフォルト: 2) |
| autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。| false (デフォルト) または true |
|           | min  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | max | Autoscaler によって設定できるポッド数の上限値。minReplicas より小さくすることはできません。| 正整数 (デフォルトは 10) |
|           | targetcpu | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
|  shards|  | Mobile Foundation Analytics の Elasticsearch シャードの数 | デフォルトは 2|             
|  replicasPerShard|  | Mobile Foundation Analytics のシャードごとに維持する Elasticsearch レプリカの数 | デフォルトは 2|
| persistence | enabled | PersistentVolumeClaim を使用してデータを永続化します。               | true |                                                 |
|  |useDynamicProvisioning | storageclass を指定するか、空のままにします。| false  |                                                  |
| |volumeName| ボリューム名を指定します。| data-stor (デフォルト) |
|   |claimName| 既存の PersistentVolumeClaim を指定します。| nil |
|   |storageClassName     | バッキング PersistentVolumeClaim のストレージ・クラス | nil |
|   |size    | データ・ボリュームのサイズ      | 20Gi |
| pdb  | enabled | PDB を有効にするか無効にするかを指定します。| true (デフォルト) または false |
|   | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| jndiConfigurations | mfpfProperties | Operational Analytics をカスタマイズするために指定する Mobile Foundation JNDI プロパティー| 名前と値のペアをコンマで区切って指定します。|
|  | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 2000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|   | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 4096Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|   | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|   | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 2048Mi。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| ***`MFP Application Center 構成`*** | | | |
| mfpappcenter | enabled          | Application Center を有効にするためのフラグ | false (デフォルト) または true |  
| image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Application Center Docker イメージのリポジトリー |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | 『前提条件』セクションを参照|
| db | host | Appcenter データベースを構成する必要があるデータベースの IP アドレスまたはホスト名	| |
|   | port | 	データベースのポート  | |             
| | name | 使用するデータベースの名前 | データベースを事前に作成する必要があります。|
|   | secret | データベース資格情報が含まれる事前に作成された秘密| |
|   | schema | 作成する Application Center データベース・スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。存在しない場合は、作成されます。|
|   | ssl | データベース接続タイプ | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は false (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
| autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。| false (デフォルト) または true |
|           | min  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは 1) |
|           | max | Autoscaler によって設定できるポッド数の上限値。minReplicas より小さくすることはできません。| 正整数 (デフォルトは 10) |
|           | targetcpu | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
| pdb     | enabled | PDB を有効にするか無効にするかを指定します。| true (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
|  | keystoreSecret | 構成セクションを参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは 1024Mi です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは 1000m。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 1024Mi です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |


> Kibana を使用して {{ site.data.keys.prod_adj }} ログを分析する場合のチュートリアルについては、[こちら](analyzing-mobilefirst-logs-on-icp/)を参照してください。

## Helm チャートのインストール
{: #install-hmc-icp}

### {{ site.data.keys.mf_analytics }} のインストール
{: #install-mf-analytics}

{{site.data.keys.mf_analytics }} のインストールはオプションです。 {{site.data.keys.mf_server }} での分析を使用可能にする場合は、{{site.data.keys.mf_server }} をインストールする前に、まず {{site.data.keys.mf_analytics }} を構成してインストールする必要があります。

インストールを開始する前に、***IBM {{ site.data.keys.product }} Helm チャートのインストールおよび構成*** (#configure-install-mf-helmcharts) のすべての**必須**セクションに対処したか確認します。

以下の手順に従い、IBM Cloud Kubernetes クラスターに IBM {{ site.data.keys.mf_analytics }} をインストールし、構成します。

1. Kubernetes クラスターを構成するために、以下のコマンドを実行します。
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```
2. 以下のコマンドを使用して、デフォルトの Helm チャートの値を取得します。
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    {{ site.data.keys.mf_analytics }} の場合の例:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-2.0.0.tgz > values.yaml
    ```    

3. Helm チャートをデプロイする前に **values.yaml** を変更して適切な値を追加します。データベースの詳細、入口ホスト名、秘密などが追加されていることを確認し、values.yaml を保存します。

詳しくは、[環境変数](#env-variables)セクションを参照してください。

4. Helm チャートをデプロイするために、以下のコマンドを実行します。
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Analytics サーバーをデプロイする場合の例:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-2.0.0.tgz
    ```    

### {{ site.data.keys.mf_server }} のインストール
{: #install-mf-server}

{{site.data.keys.mf_server }} のインストールを開始する前に、DB2 データベースが事前構成されていることを確認してください。

以下のステップに従って、IBM Cloud Kubernetes クラスター上に IBM {{ site.data.keys.mf_server }} をインストールし、構成します。

1. Kube クラスターを構成します。
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```   

2. 以下のコマンドを使用して、デフォルトの Helm チャートの値を取得します。
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    {{ site.data.keys.mf_server }} の場合の例:
    ```bash
    helm inspect values ibm-mfpf-server-prod-2.0.0.tgz > values.yaml
    ```

3. **values.yaml** を変更して、Helm チャートをデプロイするための適切な値を追加します。 データベース詳細、入口、スケーリングなどが追加されていることを確認し、values.yaml を保存します。

4. Helm チャートをデプロイするために、以下のコマンドを実行します。
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    サーバーをデプロイする場合の例:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-2.0.0.tgz
    ```

>**注:** AppCenter をインストールする場合、対応する Helm チャート (例えば、ibm-mfpf-appcenter-prod-2.0.0.tgz.tgz) を使用して、上記のステップに従ってください。

## インストールの検査
{: #verify-install}

Mobile Foundation コンポーネントをインストールし、構成した後、IBM Cloud CLI、Kubernetes CLI、および helm コマンドを使用することで、インストール済み環境およびデプロイされたポッドの状況を確認できます。

IBM Cloud CLI 資料の [CLI コマンド・リファレンス](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)、および [Helm 資料](https://docs.helm.sh/helm/) の Helm CLI を参照してください。

IBM Cloud ポータルにある IBM Cloud Kubernetes クラスターのページから、**「Kubernetes ダッシュボード」**ボタンを使用して Kubernetes コンソールを開いて、クラスター成果物を管理できます。

## {{site.data.keys.prod_adj }} コンソールへのアクセス
{: #access-mf-console}

インストールが成功したら、`<protocol>://<public_ip>:<node_port>/mfpconsole` を使用して、IBM {{ site.data.keys.prod_adj }} Operations Console にアクセスできます。<br/>
IBM {{ site.data.keys.mf_analytics }} Console には、`<protocol>://<public_ip>:<port>/analytics/console` を使用してアクセスできます。
プロトコルには、`http` または `https` を使用できます。 また、**NodePort** デプロイメントの場合、ポートは **NodePort** になることに注意してください。 インストールされている {{ site.data.keys.prod_adj }} チャートの IP アドレスおよび **NodePort** を取得するには、Kubernetes ダッシュボードで以下の手順に従います。
* **パブリック IP** を取得するには - **「Kubernetes」** > **「ワーカー・ノード (Worker Nodes)」**を選択し、「パブリック IP (Public IP)」で IP アドレスをメモします。
* **ノード・ポート**は、**Kubernetes ダッシュボード**で見つけることができます。**「サービス」**を選択し、**「内部エンドポイント (internal endpoints)」**で*「TCP ノード・ポート (TCP Node Port)」*のエントリー (5 桁のポート) をメモします。

コンソールにアクセスするための *NodePort* アプローチに加えて、サービスには、[Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html) ホスト経由でアクセスすることもできます。

以下のステップに従ってコンソールにアクセスします。

1. [**IBM Cloud ダッシュボード**](https://console.bluemix.net/dashboard/apps/)に移動します。
2. `Analytics/Server/AppCenter` がデプロイされている **Kubernetes クラスター**を選択し、**「概要」**ページを開きます。
3. 入口ホスト名の Ingress サブドメインを見つけ、以下のようにコンソールにアクセスします。
    * IBM Mobile Foundation Operations Console にアクセスする場合、
     `<protocol>://<ingress-hostname>/mfpconsole` を使用します。
    * IBM Mobile Foundation Analytics Console にアクセスする場合、
     `<protocol>://<ingress-hostname>/analytics/console` を使用します。
    * IBM Mobile Foundation Application Center Console にアクセスする場合、
     `<protocol>://<ingress-hostname>/appcenterconsole` を使用します。
4. nginx 入口では、SSL サービス・サポートはデフォルトでは無効になっています。https を介してコンソールにアクセスするとき、接続に注意してください。以下の手順に従い、入口で SSL サービスを有効にします。
    1. IBM Cloud Kubernetes クラスター・ページから、Kubernetes ダッシュボードを起動します。
    2. 左側のパネルで、「入口 (Ingresses)」オプションをクリックします。
    3. 入口名を選択します。
    4. 右上の「編集」ボタンをクリックします。
    5. yaml ファイルを変更し、ssl-services アノテーションを追加します。
    例:

    ```bash
    "annotations": {
      "ingress.bluemix.net/ssl-services": "ssl-service=my_service_name1;ssl-service=my_service_name2",
      .....
      ....
      ...
      ...
    }
    ```
   6. 「更新」をクリックします。

>**注:** ポート 9600 は、Kubernetes サービスで内部的に公開され、{{ site.data.keys.prod_adj }} Analytics インスタンスによってトランスポート・ポートとして使用されます。

## サンプル・アプリケーション
{: #sample-app}
IBM Cloud Kubernetes クラスターで実行される IBM {{ site.data.keys.mf_server }} 上にサンプル・アダプターをデプロイし、サンプル・アプリケーションを実行するには、[{{ site.data.keys.prod_adj }} チュートリアル](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)を参照してください。

## {{ site.data.keys.prod_adj }} Helm チャートおよびリリースのアップグレード
{: #upgrading-mf-helm-charts}

Helm チャート/リリースをアップグレードする方法については、[バンドル製品のアップグレード](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/upgrade_helm.html)を参照してください。

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

## アンインストール
{: #uninstall}
{{site.data.keys.mf_server }} および {{site.data.keys.mf_analytics }} をアンインストールするには、[Helm CLI](https://docs.helm.sh/using_helm/#installing-helm) を使用します。
以下のコマンドを使用して、インストールされているチャートおよび関連するデプロイメントを完全に削除します。
```bash
helm delete --purge <release_name>
```
*release_name* は、デプロイ済みの Helm チャートのリリース名です。

## トラブルシューティング
{: #troubleshooting}

このセクションでは、Mobile Foundation のデプロイ中に発生する可能性のあるエラー・シナリオの特定および解決についてガイドします。

1. Helm のインストールが失敗した。`エラー: 使用可能なティラー・ポッドが見つかりません (Error: could not find a ready tiller pod)`

 - 以下の一連のコマンドをそのまま実行し、helm のインストールを再試行します。
  ```bash
  helm init
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm init --service-account tiller --upgrade
  ```

2. Helm チャートのデプロイ中にイメージをプルできない - `イメージをプルできません。エラー: ErrImagePull (Failed to pull image, Error: ErrImagePull)`

 - helm のデプロイメントの前に pullSecret イメージが values.yaml に追加されていることを確認します。イメージ・プル秘密が存在しない場合、プル秘密を作成し、それを *values.yaml* ファイル内の `image.pullSecret` に割り当てます。

 プル秘密の作成例:

  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  ```

  > 注: 認証のために IBM Cloud API 鍵を使用する場合、`--docker-username=iamapikey` の値をそのまま保持します。

3. 入口を通じてコンソールにアクセスしている最中に接続の問題が発生する

 - この問題を解決するには、Kubernetes ダッシュボードを起動し、「入口 (Ingresses)」オプションを選択します。入口 yaml を編集し、以下のように入口ホストの詳細を追加します。

    例:
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
