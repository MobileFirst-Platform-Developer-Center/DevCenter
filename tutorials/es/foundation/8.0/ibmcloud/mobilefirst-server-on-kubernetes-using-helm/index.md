---
layout: tutorial
title: Configuración de Mobile Foundation en IBM Cloud Kubernetes Cluster mediante Helm
breadcrumb_title: Foundation on Kubernetes using Helm
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga las instrucciones siguientes para configurar una instancia de {{ site.data.keys.mf_server }}, una instancia de {{ site.data.keys.mf_push }}, una instancia de {{ site.data.keys.mf_analytics }} y una instancia de {{ site.data.keys.mf_app_center}} en IBM Cloud Kubernetes Cluster (IKS) utilizando gráficos Helm.

A continuación se muestran los pasos básicos para comenzar: <br/>
* Complete los requisitos previos 
* Descargue el archivo PPA (Passport Advantage Archive) de {{ site.data.keys.product_full }} para {{ site.data.keys.prod_icp }}
* Cargue el archivo PPA en IBM Cloud Kubernetes Cluster 
* Configure e instale {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (opcional) y {{ site.data.keys.mf_app_center}} (opcional)

#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Descargar el archivo Passport Advantage de IBM Mobile Foundation](#download-the-ibm-mfpf-ppa-archive)
* [Cargar el archivo Passport Advantage de IBM Mobile Foundation](#load-the-ibm-mfpf-ppa-archive)
* [Variables de entorno](#env-variables)
* [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
* [Instalación de gráficos Helm](#install-hmc-icp)
* [Verificación de la instalación](#verify-install)
* [Aplicación de ejemplo](#sample-app)
* [Actualización de {{ site.data.keys.prod_adj }}releases y gráficos Helm](#upgrading-mf-helm-charts)
* [Desinstalar](#uninstall)
* [Resolución de problemas](#troubleshooting)

## Requisitos previos
{: #prereqs}

Debe tener una [**cuenta de IBM Cloud**](http://cloud.ibm.com/) y debe haber configurado el [**clúster de IBM Cloud Kubernetes**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial).

Para gestionar los contenedores y las imágenes, instale lo siguiente en la máquina host como parte de la configuración de los plugins de la CLI de IBM Cloud:

* CLI de IBM Cloud (`ibmcloud`)
* CLI de Kubernetes (`kubectl`)
* Plugin de IBM Cloud Container Registry (`cr`)
* Plugin de IBM Cloud Container Service (`ks`)
* Instalar y configurar [Docker](https://docs.docker.com/install/)
* Helm (`helm`)
Para trabajar con el clúster Kubernetes utilizando la CLI, debe configurar el cliente *ibmcloud*. 
1. Asegúrese de iniciar sesión en la [página Clústeres](https://cloud.ibm.com/kubernetes/clusters). (Nota: la cuenta [IBMid](https://myibm.ibm.com/) es necesaria).
2. Pulse el clúster Kubernetes en el que se debe desplegar el gráfico de IBM Mobile Foundation.
3. Siga las instrucciones del separador **Acceso** cuando se haya creado el clúster.
>**Nota:** La creación de clúster tarda unos minutos. Cuando el clúster se haya creado correctamente, pulse el separador **Nodos de trabajador** y tome nota de la *IP pública*.

Para acceder a IBM Cloud Kubernetes Cluster mediante la CLI, debe configurar el cliente IBM Cloud. [Más información](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).

## Descargar el archivo Passport Advantage de IBM Mobile Foundation
{: #download-the-ibm-mfpf-ppa-archive}
El archivo Passport Advantage (PPA) de {{ site.data.keys.product_full }} está disponible [aquí](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). El archivo PPA de {{ site.data.keys.product }} contendrá las imágenes docker y los gráficos Helm de los componentes siguientes de {{ site.data.keys.product }}:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

Se utiliza un componente *Inicialización de BD* de {{ site.data.keys.product_adj }} o se facilitan las tareas de inicialización de base de datos. Esto proporciona la creación del esquema de Mobile Foundation y las tablas (si es necesario) en la base de datos (si no existe). 

## Cargar el archivo Passport Advantage de IBM Mobile Foundation
{: #load-the-ibm-mfpf-ppa-archive}

Siga los pasos siguientes para cargar el archivo PPA en IBM Cloud Kubernetes Cluster:

  1. Inicie sesión en el clúster mediante el plugin de IBM Cloud. Consulte la [documentación de la CLI de IBM] (https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview) para obtener información sobre los mandatos.

      Por ejemplo:
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
      Incluya la opción `--sso` si utiliza un ID federado. Opcionalmente, si desea omitir la validación SSL, utilice el distintivo `--skip-ssl-validation` en el mandato anterior. Esto omitirá la validación de SSL de las solicitudes HTTP. El uso de este parámetro puede generar problemas de seguridad. 

  2. Inicie sesión en IBM Cloud Container Registry e inicialice Container Service mediante los mandatos siguientes:
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. Establezca la región del despliegue mediante el mandato siguiente (p. ej. us-south)
      ```bash
      ibmcloud cr region-set
      ```  

  4. Siga los pasos siguientes para obtener acceso a su clúster -

      1. Descargue e instale algunas herramientas de CLI y el plugin de Kubernetes Service.
```bash
      curl -sL https://ibm.biz/idt-installer | bash
      ```

      2. Descargue los archivos kubeconfig para el clúster.
```bash
      ibmcloud ks cluster-config --cluster my_cluster_name
      ```

      3. Establezca la variable de entorno *KUBECONFIG*. Copie la salida del mandato anterior y péguela en el terminal.  La salida del mandato es similar a la del ejemplo siguiente:
     ```bash
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/my_namespace/kube-config-dal10-my_namespace.yml
      ```

      4. Verifique que puede conectarse al clúster listando los nodos de trabajador.
      ```bash
      kubectl get nodes
      ```

  5. Cargue el archivo PPA de {{ site.data.keys.product }} siguiendo estos pasos: 
       1. **Extraiga** el archivo PPA 
       2. **Etiquete** las imágenes cargadas con el espacio de nombres de registro de IBM Cloud Container y con la versión adecuada. 
       3. **Envíe** la imagen
       4. [Opcional] Cree y **envíe los archivos manifest**, si los nodos de trabajador están basados en una combinación de arquitecturas (por ejemplo, amd64, ppc64le, s390x).

      A continuación se muestra un ejemplo para cargar las imágenes **mfpf-server** y **mfpf-push** en los nodos de trabajador basados en la arquitectura **amd64**. Debe seguir el mismo proceso para **mfpf-appcenter** y **mfpf-analytics**.

      ```bash

      # 1. Extraiga el archivo PPA 

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Etiquete las imágenes cargadas con el espacio de nombres de registro de IBM Cloud Container y con la versión adecuada. 

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0

      # 3. Envíe todas las imágenes 

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 4. Limpieza del archivo extraído

      rm -rf ppatmp
      ```

      A continuación, se muestra un ejemplo para cargar las imágenes **mfpf-server** y **mfpf-push** en los nodos de trabajador basados en **varias arquitecturas**. Debe seguir el mismo proceso para **mfpf-appcenter** y **mfpf-analytics**.

      ```bash
      # 1. Extraer el archivo PPA 

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Etiquete las imágenes cargadas con el espacio de nombres de registro de IBM Cloud Container y con la versión adecuada. 

      ## 2.1 Etiquetado de mfpf-server

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker tag mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker tag mfpf-server:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 2.2 Etiquetado de mfpf-dbinit

      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker tag mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker tag mfpf-dbinit:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 2.3 Etiquetado de mfpf-push

      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker tag mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker tag mfpf-push:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 3. Enviar todas las imágenes 

      ## 3.1 Enviando imágenes de mfpf-server 

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      ## 3.3 Enviando imágenes de mfpf-dbinit 

      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      ## 3.3 Enviando imágenes de mfpf-push 

      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 4. [Opcional] Crear y enviar los manifiestos

      ## 4.1 Crear manifest-lists

      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      ## 4.2 Anotar los manifiestos 

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

      ## 4.3 Enviar la lista de manifiestos 

      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 5. Limpieza del archivo extraído

      rm -rf ppatmp
      ```

   >**Nota:**
   > 1. El método del mandato `ibmcloud cr ppa-archive load` no da soporte al paquete PPA con soporte de varias arquitecturas. Por lo tanto, hay que extraer y enviar el paquete manualmente al repositorio de IBM Cloud Container (los usuarios que utilicen versiones PPA más antiguas tienen que utilizar el siguiente mandato para la carga). 

   > 2. Varias arquitecturas se refiere a arquitecturas que incluyen intel (amd64), power64 (ppc64le) y s390x. Solo se da soporte a varias arquitecturas a partir de ICP 3.1.1. 

  ```bash
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
      ```
   *archive_name* de {{ site.data.keys.product }} es el nombre del archivo PPA descargado desde IBM Passport Advantage,

   Los gráficos Helm se almacenan en el cliente o localmente (a diferencia del gráfico helm de ICP almacenado en el repositorio helm de IBM Cloud Private). Los gráficos pueden estar en el directorio `ppa-import/charts` (o charts).

## Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}
{: #configure-install-mf-helmcharts}

Antes de instalar y configurar {{ site.data.keys.mf_server }}, debe tener lo siguiente:

Esta sección resume los pasos para crear secretos. 

Los objetos de secreto le permiten gestionar la información confidencial, tal como contraseñas, señales OAuth, claves ssh etc. Incluir esta información en un secreto es más seguro y flexible que hacerlo en una definición de Pod o en una imagen de contenedor. 

* [**Obligatorio**] Se debe configurar una instancia de base de datos DB2 y debe estar lista para su uso. Necesitará la información de base de datos para [configurar {{ site.data.keys.mf_server }} helm](#install-hmc-icp). {{ site.data.keys.mf_server }} requiere un esquema y tablas, que se crearán (si no existen) en esta base de datos.

* [**Obligatorio**] Crear **secretos de base de datos** para el servidor, Push y el centro de aplicaciones.
En esta sección se describen los mecanismos de seguridad para controlar el acceso a la base de datos. Cree un secreto utilizando el submandato especificado y proporcione el nombre de secreto creado bajo los detalles de la base de datos.

Ejecute el fragmento de código siguiente para crear un secreto de base de datos para Mobile Foundation Server:

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

Ejecute el fragmento de código siguiente para crear un secreto de base de datos para el centro de aplicaciones

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
   > NOTA: Puede codificar los detalles de nombre de usuario y contraseña utilizando el mandato siguiente -

   ```bash
	export $MY_USER_NAME=<myuser>
	export $MY_PASSWORD=<mypassword>

	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```


* [**Obligatorio**] Se requiere un **Secreto de inicio de sesión** creado previamente para el inicio de sesión en el servidor, Analytics y Application Center. Por ejemplo:

   ```bash
   kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
   ```

   Para Analytics.

   ```bash
   kubectl create secret generic analyticslogin --from-literal=ANALYTICS_ADMIN_USER=admin --from-literal=ANALYTICS_ADMIN_PASSWORD=admin
   ```

   Para Application Center.

   ```bash
   kubectl create secret generic appcenterlogin --from-literal=APPCENTER_ADMIN_USER=admin --from-literal=APPCENTER_ADMIN_PASSWORD=admin
   ```

   > NOTA: Si no se proporcionan estos secretos, se crean con el nombre de usuario y contraseña predeterminados de admin/admin durante el despliegue del gráfico helm de Mobile Foundation

* [**Opcional**] Puede proporcionar su propio almacén de claves y almacén de confianza al despliegue del servidor, Push, Analytics y Application Center creando un secreto con su propio almacén de claves y almacén de confianza.

   Cree previamente un secreto con `keystore.jks` y `truststore.jks` junto con la contraseña del almacén de claves y el almacén de confianza utilizando los literales KEYSTORE_PASSWORD y TRUSTSTORE_PASSWORD, proporcione el nombre de secreto en el campo keystoreSecret del componente respectivo

   Conserve los archivos `keystore.jks`, `truststore.jks` y sus contraseñas como se indica a continuación  

   Por ejemplo:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > NOTA: Los nombres de los archivos y literales deben ser los mismos que se han mencionado en el mandato anterior. Proporcione este nombre de secreto en el campo de entrada `keystoresSecretName` del componente respectivo para reemplazar los almacenes de claves predeterminados cuando configura el gráfico helm. 

* [**Opcional**] Se pueden configurar los componentes de Mobile Foundation con el nombre de host basado en Ingress para que los clientes externos puedan conectarse a los mismos utilizando el nombre de host. Se puede proteger Ingress utilizando una clave TLS privada y un certificado. La clave privada TLS y el certificado se deben definir en un secreto con los nombres de clave `tls.key` y `tls.crt`. 

   El secreto **mf-tls-secret** se ha de crear en el mismo espacio de nombres que el recurso Ingress utilizando el mandato siguiente:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   El nombre de host de Ingress se proporciona en el campo global.ingress.secret. Modifique **values.yaml** para añadir el nombre de host Ingress apropiado y el nombre de secreto de Ingress durante el despliegue del diagrama Helm. 

   > NOTA: Evite utilizar el mismo nombre de host Ingress si ya se utilizaba en otros releases de helm. 

* [**Opcional**] Mobile Foundation Server está predefinido con clientes confidenciales para el servicio de administración. Las credenciales de estos clientes se proporcionan en los campos `mfpserver.adminClientSecret` y `mfpserver.pushClientSecret`. 

   Estos secretos se pueden crear del modo siguiente: 
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > NOTA: Si no se proporcionan los valores para los campos `mfpserver.pushClientSecret` y `mfpserver.adminClientSecret` durante el despliegue del gráfico helm de Mobile Foundation, se generan y utilizan el ID de autorización y el Secreto de cliente predeterminados `admin/nimda` para `mfpserver.adminClientSecret` y `push/hsup` para `mfpserver.pushClientSecret`.

* [**Obligatorio**] Antes de empezar la instalación del gráfico de Mobile Foundation Analytics, configure el Volumen persistente y la Reclamación de volumen persistente según corresponda. Proporcione el volumen persistente para configurar Mobile Foundation Analytics. Siga los pasos que se describen en la [documentación de IBM Cloud Kubernetes para crear un volumen persistente](https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_storage).


## Variables de entorno 
{: #env-variables }
La tabla siguiente indica las variables de entorno utilizadas en la instancia de {{ site.data.keys.mf_server }}, de {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} y de {{ site.data.keys.mf_app_center }}

| Calificador | Parámetro | Definición | Valor permitido |
|-----------|-----------|------------|---------------|
| ***`Configuración global`*** | |  |  |
| arch | amd64 | Preferencia de planificador de nodos trabajadores de amd64 en un clúster híbrido | 3 - Preferido (valor predeterminado). |
|  |  ppcle64 | Preferencia de planificador de nodos trabajadores de ppc64le en un clúster híbrido | 2 - Sin preferencia (valor predeterminado). |
|  | s390x | Preferencia de planificador de nodos trabajadores de S390x en un clúster híbrido | 2 - Sin preferencia (valor predeterminado). |
| image | pullPolicy | Política de extracción de imágenes | El valor predeterminado es **IfNotPresent**. |
|  | pullSecret | Secreto de extracción de imagen |  |
| ingress | hostname | El nombre de host externo o dirección IP para que lo utilicen los clientes externos | Equilibra las cargas de trabajo de tráfico de red del clúster enviando solicitudes públicas o privadas a sus aplicaciones |
|  | secret | Nombre del secreto TLS | Especifica el nombre del secreto para el certificado que se ha de utilizar en la definición Ingress. El secreto se ha de crear previamente utilizando el certificado y clave relevantes. Es obligatorio si está habilitado SSL/TLS. Cree previamente el secreto con el certificado & clave antes de proporcionar el nombre aquí |
|  | sslPassThrough | Habilitar passthrough SSL | Especifica si se ha de pasar la solicitud SSL mediante el servicio Mobile Foundation - la terminación de SSL se produce en el servicio Mobile Foundation. Predeterminado: false |
| https | true |  |  |
| dbinit | habilitado | Habilitar la inicialización de las bases de datos del servidor, Push y Centro de aplicaciones | Inicializa las bases de datos y crea esquemas y tablas para el despliegue del servidor, Push y el centro de aplicaciones.(No es necesario para las analíticas). Predeterminado: true |
| | repository | Repositorios de imagen Docker para la inicialización de base de datos | Repositorio de imagen de docker de la base de datos Mobile Foundation |
|  | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|  | replicas | Número de instancias (pods) de Mobile Foundation DBinit que se han de crear | Entero positivo (Predeterminado: 1) |
| ***`Configuración del servidor MFP`*** | | | |
| mfpserver | habilitado | Distintivo para habilitar el servidor | true (predeterminado) o false |
|  | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Server |
|  | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|  | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
|  db | host | Dirección IP o nombre de host de la base de datos donde se han de configurar las tablas de Mobile Foundation Server. | IBM DB2 (predeterminado). |
| | port |Puerto donde se configura la base de datos | |
| | secret | Secreto ya creado que tiene credenciales de base de datos| |
| | name | Nombre de la base de datos de Mobile Foundation Server | |
|  | schema | Esquema de bd de servidor que se ha de crear. | Si ya existe el esquema, se utilizará. De lo contrario, se creará. |
|  | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es false (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
| adminClientSecret | Especifique el nombre del secreto | Secreto de cliente administrador | Especifique el nombre del secreto de cliente creado. [Consulte](#configure-install-mf-helmcharts) |
| pushClientSecret | Especifique el nombre del secreto | Secreto de cliente Push | Especifique el nombre del secreto de cliente creado. [Consulte](#configure-install-mf-helmcharts) |
| internalConsoleSecretDetails | consoleUser: "admin" |  |  |
|  | consolePassword: "admin" |  |  |
| internalClientSecretDetails | adminClientSecretId: admin |  |  |
| | adminClientSecretPassword: nimda |  |  |
| | pushClientSecretId: push |  |  |
| | pushClientSecretPassword: hsup |  |  |
| replicas | 3 | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: 3) |
| autoscaling | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler). Tenga en cuenta que al habilitar este campo se inhabilita el campo de réplicas. | false (predeterminado) o true |
| | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
| | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior al mín. | Entero positivo (predeterminado: 10) |
| | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| pdb | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
| | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation Server para personalizar el despliegue  | Especifique pares de valores de nombre separados por comas |
| | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`Configuración de MFP Push`*** | | | |
| mfppush | enabled | Distintivo para habilitar Mobile Foundation Push | true (predeterminado) o false |
|           | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Push |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
| replicas | | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: 3) |
| autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation Server para personalizar el despliegue  | Especifique pares de valores de nombre separados por comas |
| | keystoresSecretName | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`Configuración de MFP Analytics`*** | | | |
| mfpanalytics | habilitado       | Distintivo para habilitar las analíticas | false (predeterminado) o true |
| image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Operational Analytics |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
| replicas |  | Número de instancias (pods) de Mobile Foundation Operational Analytics que se han de crear | Entero positivo (Predeterminado: 2) |
| autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
|  shards|  | Número de fragmentos Elasticsearch para Mobile Foundation Analytics | predeterminado: 2 |             
| replicasPerShard |  | Número de réplicas Elasticsearch que se van a mantener por cada fragmento de Mobile Foundation Analytics | predeterminado: 2 |
| persistence | habilitado | Utilice una PersistentVolumeClaim para la persistencia de los datos     | true |                                                 |
|  |useDynamicProvisioning | Especifique una storeclass o deje el campo vacío  | false  |                                                  |
| |volumeName| Proporcione un nombre de volumen  | data-stor (predeterminado) |
|   |claimName| Proporcione una PersistentVolumeClaim existente | nil |
|   |storageClassName     | Clase de almacenamiento de la PersistentVolumeClaim de respaldo | nil |
|   |size    | Tamaño del volumen de datos      | 20Gi |
|pdb  | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|   | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation que se han de especificar para personalizar las analíticas operativas| Especifique pares de valores de nombre separados por comas |
|  | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|   | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`Configuración de MFP Application Center`*** | | | |
| mfpappcenter | enabled          | Distintivo para habilitar Application Center | false (predeterminado) o true |  
| image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Application Center |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
| db | host | Dirección IP o nombre de host de la base de datos donde se ha de configurar la base de datos de Appcenter. | |
|   | port | 	 Puerto de la base de datos | |             
| | name | Nombre de la base de datos que se va a utilizar | La base de datos debe crearse previamente. |
|   | secret | Secreto ya creado que tiene credenciales de base de datos| |
|   | schema | Esquema de base de datos de Application Center que se ha de crear. | Si ya existe el esquema, se utilizará. Si no es así, se creará. |
|   | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es false (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
| autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | min  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | max | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetcpu | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
|  | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |


> Para ver la guía de aprendizaje sobre el análisis de registros de {{ site.data.keys.prod_adj }} utilizando Kibana, consulte [aquí](analyzing-mobilefirst-logs-on-icp/).

## Instalación de gráficos Helm
{: #install-hmc-icp}

### Instalación de {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

La instalación de {{ site.data.keys.mf_analytics }} es opcional. Si desea habilitar el análisis en {{ site.data.keys.mf_server }}, primero debe configurar e instalar {{ site.data.keys.mf_analytics }}, antes de instalar {{ site.data.keys.mf_server }}.

Antes de empezar la instalación, asegúrese de que ha cubierto todas las indicaciones de la sección **Obligatorio** en ***[Instalar y configurar gráficos helm de IBM {{site.data.keys.product }}]***(#configure-install-mf-helmcharts).

Siga los pasos siguientes para instalar y configurar IBM {{ site.data.keys.mf_analytics }} en IBM Cloud Kubernetes Cluster. 

1. Para configurar Kubernetes Cluster, ejecute el mandato siguiente:
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```
2. Obtenga los valores predeterminados de gráfico Helm mediante el mandato siguiente.
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    Ejemplo de {{ site.data.keys.mf_analytics }}:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-2.0.0.tgz > values.yaml
    ```    

3. Modifique **values.yaml** para añadir los valores adecuados antes del despliegue del gráfico Helm. Asegúrese de que se ha añadido la información de base de datos, nombre de host ingress, secreto, etc. y guarde el archivo values.yaml.

Consulte la sección [Variables de entorno](#env-variables) para obtener más detalles.

4. Para desplegar el gráfico Helm, ejecute el mandato siguiente:
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Ejemplo de despliegue del servidor de Analytics:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-2.0.0.tgz
    ```    

### Instalación de {{ site.data.keys.mf_server }}
{: #install-mf-server}

Antes de empezar la instalación de {{ site.data.keys.mf_server }}, preconfigure una base de datos DB2.

Siga los pasos siguientes para instalar y configurar IBM {{ site.data.keys.mf_server }} en IBM Cloud Kubernetes Cluster.

1. Configure Kubernetes Cluster:
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```   

2. Obtenga los valores predeterminados de gráfico Helm mediante el mandato siguiente:
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    Ejemplo de {{ site.data.keys.mf_server }}:
    ```bash
    helm inspect values ibm-mfpf-server-prod-2.0.0.tgz > values.yaml
    ```

3. Modifique **values.yaml** para añadir los valores adecuados para el despliegue del gráfico Helm. Asegúrese de que se haya añadido la información de base de datos, ingress, escalado etc. y guardado values.yaml.

4. Para desplegar el gráfico Helm, ejecute el mandato siguiente.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    Ejemplo de despliegue de servidor:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-2.0.0.tgz
    ```

>**Nota:** Para instalar AppCenter los pasos anteriores deben ir seguidos del gráfico Helm correspondiente, (por ejemplo, ibm-mfpf-appcenter-prod-2.0.0.tgz.tgz).

## Verificación de la instalación
{: #verify-install}

Cuando haya instalado y configurado los componentes de Mobile Foundation, puede verificar su instalación y el estado de los pods desplegados utilizando la CLI de IBM Cloud, la CLI de Kubernetes y los mandatos helm. 

Consulte la [Referencia de mandatos de CLI](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) en la documentación de la CLI de IBM y la CLI de Helm de la [documentación de Helm](https://docs.helm.sh/helm/).

En la página de IBM Cloud Kubernetes Cluster en IBM Cloud Portal, puede utilizar el botón **Panel de control de Kubernetes** para abrir la consola de Kubernetes para gestionar los artefactos de clúster.

## Acceso a la consola {{ site.data.keys.prod_adj }}
{: #access-mf-console}

Una vez realizada la instalación correctamente, puede acceder a la consola operativa de IBM {{ site.data.keys.prod_adj }} mediante `<protocol>://<public_ip>:<node_port>/mfpconsole`. <br/>
Se puede acceder a la consola de IBM {{ site.data.keys.mf_analytics }} mediante `<protocol>://<public_ip>:<port>/analytics/console`. El protocolo puede ser `http` o `https`. Además, tenga en cuenta que el puerto será **NodePort** en el caso del despliegue de **NodePort**. Para obtener la dirección ip y **NodePort** de los gráficos de {{ site.data.keys.prod_adj }} instalados, siga estos pasos desde el panel de control de Kubernetes. 
* Para obtener **IP pública**: Seleccione **Kubernetes**>**Nodos de trabajador**> bajo la dirección IP pública; tenga en cuenta la dirección IP.
* El **Puerto de nodo** se puede encontrar en el **Panel de control de Kubernetes**>. Seleccione **Servicios**>bajo los **puntos finales internos**. Tenga en cuenta la entrada para el *Puerto de nodo TCP* (un puerto de cinco dígitos).

Además del método *NodePort* para acceder a la consola, también se puede acceder al servicio mediante el host [Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html).

Siga los pasos siguientes para acceder a la consola:

1. Vaya al [**panel de IBM Cloud**](https://console.bluemix.net/dashboard/apps/).
2. Elija el **Clúster de Kubernetes** en que se ha desplegado `Analytics/Server/AppCenter` y abra la página **Visión general**. 
3. Localice el subdominio Ingress para el nombre de host ingress y acceda a las consolas de la forma siguiente.
    * Acceda a la consola de IBM Mobile Foundation Operational mediante:
     `<protocol>://<ingress-hostname>/mfpconsole`
    * Acceda a la consola de IBM Mobile Foundation Analytics mediante:
     `<protocol>://<ingress-hostname>/analytics/console`
    * Acceda a la consola de IBM Mobile Foundation Application Center mediante:
     `<protocol>://<ingress-hostname>/appcenterconsole`
4. El soporte de servicios SSL está inhabilitado de forma predeterminada en ingress nginx. Es posible que observe la conectividad durante el acceso a la consola mediante https. Siga los pasos siguientes para habilitar los servicios SSL en ingress -
    1. En la página IBM Cloud Kubernetes Cluster, inicie el panel de control de Kubernetes
    2. En el panel lateral izquierdo, pulse la opción Ingresses
    3. Seleccione el nombre de Ingress
    4. Pulse el botón Editar en la parte superior derecha 
    5. Modifique el archivo yaml y añada la anotación ssl-services
    Ejemplo :

    ```bash
    "annotations": {
      "ingress.bluemix.net/ssl-services": "ssl-service=my_service_name1;ssl-service=my_service_name2",
      .....
      ....
      ...
      ...
    }
    ```
   6. Pulse Actualizar

>**Nota:** El puerto 9600 se expone internamente en el servicio Kubernetes y las instancias de {{ site.data.keys.prod_adj }} Analytics lo utilizan como puerto de transporte.

## Aplicación de ejemplo
{: #sample-app}
Consulte las [guías de aprendizaje de {{ site.data.keys.prod_adj }}](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) para desplegar el adaptador de ejemplo y ejecutar la aplicación de ejemplo en IBM {{ site.data.keys.mf_server }} en ejecución en IBM Cloud Kubernetes Cluster.

## Actualización de {{ site.data.keys.prod_adj }} releases y gráficos Helm
{: #upgrading-mf-helm-charts}

Consulte [Actualización de productos empaquetados](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/upgrade_helm.html) para obtener instrucciones sobre cómo actualizar los gráficos/releases de helm.

### Casos de ejemplo para las actualizaciones de release de Helm

1. Para actualizar el release de helm con los cambios de los valores de `values.yaml`, utilice el mandato `helm upgrade` con el distintivo **--set**. Puede especificar el distintivo **--set** varias veces. Se dará prioridad al conjunto especificado más a la derecha en la línea de mandatos.
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. Para actualizar el release de helm indicando valores en un archivo, utilice el mandato `helm upgrade` con el distintivo **-f**. Puede utilizar **--values** o el distintivo **-f** varias veces. Se dará prioridad al archivo especificado más a la derecha en la línea de mandatos. En el siguiente ejemplo, si `myvalues.yaml` y `override.yaml` contienen una clave denominada *Test*, tendrá prioridad el valor establecido en `override.yaml`.
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. Para actualizar el release de helm reutilizando los valores del último release y sustituyendo algunos de ellos, se puede utilizar un mandato como el siguiente:
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## Desinstalar
{: #uninstall}
Para desinstalar {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}, utilice [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:
```bash
helm delete --purge <release_name>
```
*release_name* es el nombre de release desplegado del gráfico Helm.

## Resolución de problemas
{: #troubleshooting}

Esta sección le guía durante el proceso de identificación y resolución de los posibles escenarios de error que puede encontrar al desplegar Mobile Foundation

1. Error de instalación de Helm. `Error: No se ha podido encontrar un pod tiller preparado`

 - Ejecute el siguiente conjunto de mandatos como está y vuelva a intentar la instalación de helm
  ```bash
  helm init
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm init --service-account tiller --upgrade
  ```

2. No se han podido extraer las imágenes al desplegar el gráfico Helm - `No se ha podido extraer la imagen; Error: ErrImagePull`

 - Asegúrese de que el menú desplegable de la imagen se haya añadido a values.yaml antes del despliegue de Helm. Si no existe el secreto de extracción de imagen, cree un secreto de extracción y asígnelo a `image.pullSecret` en el archivo *values.yaml*.


 Ejemplo para crear un secreto de extracción: 

  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  ```

  > Nota: Conserve el valor de `--docker-username=iamapikey` tal como está, si utiliza la clave de API de IBM Cloud para la autenticación. 

3. Problemas de conectividad al acceder a la consola mediante ingress

 - Para resolver el problema, inicie el panel de control de Kubernetes y seleccione la opción 'Ingreses'. Edite el archivo yaml de Ingress y añada los detalles del host de Ingress como se indica a continuación: 

    Ejemplo :
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
