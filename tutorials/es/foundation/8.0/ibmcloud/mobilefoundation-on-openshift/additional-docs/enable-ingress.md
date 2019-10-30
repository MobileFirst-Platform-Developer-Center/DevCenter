---
layout: tutorial
breadcrumb_title: Enabling Ingress parameters
title: Habilitación de parámetros de Ingress 
weight: 4
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Habilitación de parámetros de Ingress 
{: #enable-ingress-parameters}

Para acceder a las instancias de Mobile Foundation desplegadas en el clúster OpenShift, es necesario configurar Ingress. Los siguientes casos de uso le ayudan a realizar lo mismo. 

1. En **Despliegues HTTP**, la sección ingress en `deploy/crds/charts_v1_mfoperator_cr.yaml` es similar a la siguiente: 

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: ""
      sslPassThrough: false
    ```

2. En **Despliegues HTTPS**, el secreto TLS es obligatorio. 
    * Genere `tls.key` y `tls.crt` utilizando el mandato siguiente:

      ```bash
      openssl genrsa -out tls.key 2048
      openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=myhost.mydomain.com
      oc create secret tls mf-tls-secret --cert=tls.cert --key=tls.key
      ```

    * Cree el secreto tls de ingress con el mandato siguiente:

      ```bash
      kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
      ```

    la sección ingress en `deploy/crds/charts_v1_mfoperator_cr.yaml` es similar a la siguiente:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    ```

3. En **HTTPS para servicios de fondo**, se debe importar `tls.crt` a `keystore.jks` y `truststore.jks`.

    Cree previamente un secreto con `keystore.jks` y `truststore.jks` incluyendo el `tls.crt`, creado en el paso 2, en el almacén de claves y el almacén de confianza utilizando los literales KEYSTORE_PASSWORD y TRUSTSTORE_PASSWORD. Proporcione el nombre de secreto en el campo *keystoreSecret* del componente respectivo en `deploy/crds/charts_v1_mfoperator_cr.yaml`.

    Conserve los archivos `keystore.jks`, `truststore.jks` y sus contraseñas como se indica a continuación. 

    Por ejemplo:

    ```bash
    oc create secret generic server-stores --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
    ```

    >**NOTA**: Los nombres de los archivos y literales deben ser los mismos que se han mencionado en el mandato anterior.	Proporcione este nombre de secreto en el campo de entrada *keystoreSecret* del componente respectivo para reemplazar los almacenes de claves predeterminados cuando configura el recurso personalizado. 

    la sección ingress en `deploy/crds/charts_v1_mfoperator_cr.yaml` es similar a la siguiente:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    https: true
    mfpserver:
      keystoreSecret: "server-stores"
    ```  
