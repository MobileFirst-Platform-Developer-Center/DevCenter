---
layout: tutorial
breadcrumb_title: Enabling Ingress parameters
title: Ingress パラメーターの有効化
weight: 4
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Ingress パラメーターの有効化
{: #enable-ingress-parameters}

OpenShift クラスターにデプロイされた Mobile Foundation インスタンスにアクセスするには、ingress を構成する必要があります。 以下のシナリオで、同じことを実現できます。

1. **HTTP デプロイメント**の場合、`deploy/crds/charts_v1_mfoperator_cr.yaml` の ingress セクションは以下のようになります。

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: ""
      sslPassThrough: false
    ```

2. **HTTPS デプロイメント**の場合、TLS 秘密が必要です。
    * 以下のコマンドを使用して `tls.key` および `tls.crt` を生成します。

      ```bash
      openssl genrsa -out tls.key 2048
      openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=myhost.mydomain.com
      oc create secret tls mf-tls-secret --cert=tls.cert --key=tls.key
      ```

    * 以下のコマンドを使用して ingress tls 秘密を作成します。

      ```bash
      kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
      ```

    `deploy/crds/charts_v1_mfoperator_cr.yaml` の ingress セクションは以下のようになります。

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    ```

3. **バックエンド・サービスに対する HTTPS** では、`tls.crt` を `keystore.jks` および `truststore.jks` にインポートする必要があります。

    `keystore.jks` および `truststore.jks` で秘密を事前に作成します。このために、リテラル KEYSTORE_PASSWORD および TRUSTSTORE_PASSWORD を使用して、鍵ストアおよびトラストストアのパスワードとともに、ステップ 2 で作成した `tls.crt` を鍵ストアおよびトラストストアに組み込みます。 `deploy/crds/charts_v1_mfoperator_cr.yaml` 内の各構成要素の *keystoreSecret* フィールドに秘密名を指定します。

    以下のように、ファイル `keystore.jks`、`truststore.jks` とそのパスワードを保持します。

    以下に例を示します。

    ```bash
    oc create secret generic server-stores --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
    ```

    >**注**: ファイルおよびリテラルの名前は、上記のコマンドで示したものと同じでなければなりません。	カスタム・リソースの構成時にデフォルトの鍵ストアをオーバーライドするには、各構成要素の *keystoreSecret* 入力フィールドにこの秘密名を指定します。

    `deploy/crds/charts_v1_mfoperator_cr.yaml` の ingress セクションは以下のようになります。

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    https: true
    mfpserver:
      keystoreSecret: "server-stores"
    ```  
