---
layout: tutorial
breadcrumb_title: Enabling Ingress parameters
title: Enabling Ingress parameters
weight: 4
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Enabling Ingress parameters
{: #enable-ingress-parameters}

To access the deployed Mobile Foundation instances on OpenShift Cluster, one need to configure the ingress. Following scenarios helps one to achieve the same.

1. For **HTTP Deployments**, ingress section in `deploy/crds/charts_v1_mfoperator_cr.yaml` looks as below:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: ""
      sslPassThrough: false
    ```

2. For **HTTPS deployments**, TLS secret is mandatory.
    * Generate `tls.key` and `tls.crt` using the following command:

      ```bash
      openssl genrsa -out tls.key 2048
      openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=myhost.mydomain.com
      oc create secret tls mf-tls-secret --cert=tls.cert --key=tls.key
      ```

    * Create ingress tls secret using following command:

      ```bash
      kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
      ```

    ingress section in `deploy/crds/charts_v1_mfoperator_cr.yaml` looks as below:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    ```

3. For **HTTPS to backend services**, `tls.crt` needs to be imported to `keystore.jks` and `truststore.jks`.

    Pre-create a secret with `keystore.jks` and `truststore.jks` by including the `tls.crt` created in step 2 into the keystore and truststore along with keystore and truststore password using the literals KEYSTORE_PASSWORD and TRUSTSTORE_PASSWORD. Provide the secret name in the field *keystoreSecret* of respective component in the `deploy/crds/charts_v1_mfoperator_cr.yaml`.

    Keep the files `keystore.jks`, `truststore.jks` and its passwords as below.

    For example,

    ```bash
    oc create secret generic server-stores --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
    ```

    >**NOTE**: The names of the files and literals should be the same as mentioned in command above.	Provide this secret name in *keystoreSecret* input field of respective component to override the default keystores when configuring custom resource.

    ingress section in `deploy/crds/charts_v1_mfoperator_cr.yaml` looks as below:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    https: true
    mfpserver:
      keystoreSecret: "server-stores"
    ```  
