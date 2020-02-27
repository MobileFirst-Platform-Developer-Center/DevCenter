---
layout: tutorial
title: Instalación de IBM Mobile Foundation en IBM Cloud Private
breadcrumb_title: Foundation en IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Siga las instrucciones siguientes para configurar la instancia de {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} y la instancia de {{ site.data.keys.mf_app_center}} en {{ site.data.keys.prod_icp }}:

* Complete los requisitos previos 
* Descargue el archivo PPA (Passport Advantage Archive) de {{ site.data.keys.product_full }} para {{ site.data.keys.prod_icp }}
* Cargue el archivo PPA en el clúster de {{ site.data.keys.prod_icp }} 
* Configure e instale {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (opcional), {{ site.data.keys.mf_push }} (opcional) y {{ site.data.keys.mf_app_center }} (opcional)

#### Ir a:
{: #jump-to }
* [Requisitos previos](#prereqs)
* [Descargar el archivo Passport Advantage de IBM Mobile Foundation](#download-the-ibm-mfpf-ppa-archive)
* [Cargar el archivo Passport Advantage de IBM Mobile Foundation](#load-the-ibm-mfpf-ppa-archive)
* [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
* [Recursos necesarios](#resources-required)
* [Verificación de la instalación](#verify-install)
* [Aplicación de ejemplo](#sample-app)
* [Actualización de {{ site.data.keys.prod_adj }}releases y gráficos Helm](#upgrading-mf-helm-charts)
* [Migrar a IBM Certified Cloud Pak for Mobile Foundation Platform](#migrate)
* [Copia de seguridad y recuperación de MFP Analytics Data](#backup-analytics)
* [Desinstalar](#uninstall)

## Requisitos previos
{: #prereqs}

Debe tener una cuenta de {{ site.data.keys.prod_icp }} y debe haber configurado el clúster de [{{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup).

Para gestionar los contenedores y las imágenes, debe instalar lo siguiente en la máquina host como parte de la configuración de {{ site.data.keys.prod_icp }}:

* Instalar y configurar [Docker](https://docs.docker.com/install/)
* [CLI de IBM Cloud](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started) (`cloudctl`)
* [CLI de Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (`kubectl`)
* [Helm](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_helm_cli.html) (`helm`)

> Puede encontrar la versión de la CLI de Docker soportada
[aquí](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/supported_system_config/supported_docker.html)

> Instale la misma CLI de Kube, CLI de IBM Cloud y versión de Helm que en su clúster de ICP (Descárguela desde la consola de gestión de IBM Cloud Private, pulse **Menú > Herramientas de línea de mandatos > CLI de Cloud Private** )

Por ejemplo:

Para crear artefactos de Kubernetes como secretos, volúmenes persistentes (PV) y reclamaciones de volúmenes persistentes (PVC) en IBM Cloud Private, se requiere la interfaz de línea de mandatos de `kubectl`.

a. Instale las herramientas de `kubectl` desde la consola de gestión de IBM Cloud Private, pulse **Menú > Herramientas de línea de mandatos > CLI de Cloud Private**.

b. Expanda **Instalar CLI de Kubernetes** para descargar el instalador utilizando un mandato `curl`. Copie y ejecute el mandato curl para su sistema operativo y siga con el procedimiento de instalación.

c. Elija el mandato curl para el sistema operativo aplicable. Por ejemplo, puede ejecutar el mandato siguiente para macOS:

   ```bash
   curl -kLo <archivo_instalación> https://<ip clúster>:<port>/api/cli/kubectl-darwin-amd64
   chmod 755 <vía_acceso_instalador>/<archivo_instalación>
   sudo mv <vía_acceso_instalador>/<archivo_instalación> /usr/local/bin/kubectl
   ```
Referencia: [Instalación de la CLI de Kubernetes (kubectl)](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/manage_cluster/install_kubectl.html)

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
Antes de cargar el archivo PPA de {{ site.data.keys.product }}, debe configurar Docker. Consulte las instrucciones [aquí](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html).

Siga los pasos indicados a continuación para cargar el archivo PPA en el clúster de {{ site.data.keys.prod_icp }}:

  1. Inicie sesión en el clúster con el plugin IBM Cloud ICP (`cloudctl`).
      >Consulte [Referencia de mandatos de CLI](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html) en la documentación de {{ site.data.keys.prod_icp }}.

     Por ejemplo:

     ```bash
     cloudctl login -a https://ip:port
     ```
      Opcionalmente, si desea omitir la validación SSL, utilice el distintivo `--skip-ssl-validation` en el mandato anterior. Mediante esta opción, se solicitan los valores de `username` y `password` del punto final del clúster. Continúe con los pasos siguientes, una vez iniciada la sesión.

  2. Cargue el archivo PPA de {{ site.data.keys.product }} mediante el mandato siguiente:
      ```
     cloudctl catalog load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
     ```
     *archive_name* de {{ site.data.keys.product }} es el nombre del archivo PPA descargado desde IBM Passport Advantage,

     `--clustername` puede ignorarse si se ha seguido el paso anterior y se ha establecido el punto final del clúster como valor predeterminado para `cloudctl`.

  3.  Vea las imágenes Docker y los gráficos Helm en la consola de gestión de {{ site.data.keys.prod_icp }}.
      Para ver las imágenes Docker,
      * Seleccione **Plataforma > Imágenes de contenedor**.
      * Los gráficos Helm se muestran en el **Catálogo**.

  Tras completar los pasos anteriores, verá que aparece la versión cargada de {{ site.data.keys.prod_adj }} los gráficos Helm en el catálogo de ICP. {{ site.data.keys.mf_server }} se lista como **ibm-mobilefoundation-prod**.

## Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}
{: #configure-install-mf-helmcharts}

Antes de instalar y configurar {{ site.data.keys.mf_server }}, debe tener lo siguiente:

Esta sección resume los pasos para crear secretos. 

Los objetos de secreto le permiten gestionar la información confidencial, tal como contraseñas, señales OAuth, claves ssh etc. Incluir esta información en un secreto es más seguro y flexible que hacerlo en una definición de Pod o en una imagen de contenedor. 

1. (Obligatorio) Se requiere una base de datos preconfigurada para almacenar los datos técnicos de los componentes Mobile Foundation Server y Application Center. 

   Debe utilizar uno de los DBMS soportados siguientes: 

     1. **IBM DB2**
     2. **MySQL**
     3. **Oracle**

   Siga los pasos siguientes si está utilizando la ***base de datos Oracle o MySQL -***

   - Los controladores JDBC para Oracle y MySQL no se incluyen en el instalador de Mobile Foundation. Asegúrese de que tiene el controlador JDBC. Para MySQL, utilice el controlador JDBC de Connector/J. Para Oracle, utilice el controlador JDBC ligero. Cree un volumen montado y coloque el controlador JDBC en la ubicación `/nfs/share/dbdrivers`

   - Cree un volumen persistente (PV) proporcionando los detalles del host NFS y la vía de acceso en la que se almacena el controlador JDBC. El siguiente es un `PersistentVolume.yaml` de ejemplo
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
      > NOTA: Asegúrese de que añade las entradas <nfs_server> y <nfs_path> en el yaml anterior.

    - Cree una reclamación de volumen persistente (PVC) y proporcione el nombre de PVC en el gráfico Helm durante el despliegue. El siguiente es un `PersistentVolumeClaim.yaml` de ejemplo
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
   >NOTA: Asegúrese de que añade el espacio de nombres correcto en el yaml anterior 

2. (Obligatorio) Se requiere un **Secreto de inicio de sesión** creado previamente para el inicio de sesión en el servidor, Analytics y Application Center. Por ejemplo:

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

3. (Opcional) Puede proporcionar su propio almacén de claves y almacén de confianza al despliegue del servidor, Push, Analytics y Application Center creando un secreto con su propio almacén de claves y almacén de confianza.

   Cree previamente un secreto con `keystore.jks` y `truststore.jks` junto con la contraseña del almacén de claves y el almacén de confianza utilizando los literales KEYSTORE_PASSWORD y TRUSTSTORE_PASSWORD, proporcione el nombre de secreto en el campo keystoreSecret del componente respectivo

   Conserve los archivos `keystore.jks`, `truststore.jks` y sus contraseñas como se indica a continuación  

   Por ejemplo:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > NOTA: Los nombres de los archivos y literales deben ser los mismos que se han mencionado en el mandato anterior. Proporcione este nombre de secreto en el campo de entrada `keystoresSecretName` del componente respectivo para reemplazar los almacenes de claves predeterminados cuando configura el gráfico helm. 

4. (Opcional) Se pueden configurar los componentes de Mobile Foundation con el nombre de host basado en Ingress para que los clientes externos puedan conectarse a los mismos utilizando el nombre de host. Se puede proteger Ingress utilizando una clave TLS privada y un certificado. La clave privada TLS y el certificado se deben definir en un secreto con los nombres de clave `tls.key` y `tls.crt`. 

   El secreto **mf-tls-secret** se crea en el mismo espacio de nombres que el recurso Ingress utilizando el mandato siguiente:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   El nombre se proporciona en el campo global.ingress.secret 

   > NOTA: Evite utilizar el mismo nombre de host Ingress si ya se utilizaba en otros releases de helm. 

5. (Opcional) Para personalizar la configuración, (por ejemplo, para modificar un valor de rastreo de registro, añadir una nueva propiedad jndi, etc.), tendrá que crear un mapa de configuración con el archivo XML de configuración. Esto le permite añadir un nuevo valor de configuración o reemplazar las configuraciones existentes de los componentes de Mobile Foundation. 

    Los componentes de Mobile Foundation acceden a la configuración personalizada mediante un configMap (mfpserver-custom-config) que se puede crear del modo siguiente -

	```bash
	kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
	```

    El configmap creado utilizando el mandato anterior se debe proporcionar en la **Configuración del servidor personalizada** del gráfico Helm durante el despliegue de Mobile Foundation.

    El siguiente es un ejemplo de cómo establecer la especificación del registro de rastreo, (el valor predeterminado es info) utilizando mfpserver-custom-config configmap.

    - XML de configuración de ejemplo (logging.xml)

	```bash
    <server>
          <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
          maxFileSize="20" />
    </server>
	```

    - Cree configmap y añádalo durante el despliegue del gráfico helm 

	```bash
    kubectl create configmap mfpserver-custom-config --from-file=logging.xml
	```

    - Observe el cambio en messages.log (de los componentes de Mobile Foundation) - ***La propiedad traceSpecification se establecerá en com.ibm.mfp.=debug:\*=warning.***

6. (Opcional) Mobile Foundation Server está predefinido con clientes confidenciales para el servicio de administración. Las credenciales de estos clientes se proporcionan en los campos `mfpserver.adminClientSecret` y `mfpserver.pushClientSecret`. 

   Estos secretos se pueden crear del modo siguiente: 

   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > NOTA: Si no se proporcionan los valores para los campos `mfpserver.pushClientSecret` y `mfpserver.adminClientSecret` durante el despliegue del gráfico helm de Mobile Foundation, se generan y utilizan el ID de autorización y el Secreto de cliente predeterminados `admin/nimda` para `mfpserver.adminClientSecret` y `push/hsup` para `mfpserver.pushClientSecret`.

7. Para el despliegue de Analytics, se pueden elegir las opciones siguientes para los datos de analíticas persistentes

    a) Tener preparados el `Volumen persistente (PV)` y la `Reclamación de volúmenes persistentes (PVC)` y proporcionar el nombre de PVC del gráfico helm, 

      Por ejemplo:

      `PersistentVolume.yaml` de ejemplo 

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

    > NOTA: Asegúrese de que añade las entradas <nfs_server> y <nfs_path> en el yaml anterior.

      `PersistentVolumeClaim.yaml` de ejemplo 

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

    > NOTA: Asegúrese de que añade el <espacio de nombres> correcto en el yaml anterior. 

    b) Seleccionar el suministro dinámico en el gráfico. 

8. (Obligatorio) Crear **secretos de base de datos** para el servidor, push y el centro de aplicaciones.
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

   En esta sección se describen los mecanismos de seguridad para controlar el acceso a la base de datos. Cree un secreto utilizando el submandato especificado y proporcione el nombre de secreto creado bajo los detalles de la base de datos.

9. (Opcional) Se puede proporcionar un secreto de administrador de base de datos separado. Los detalles de usuario proporcionados en el secreto de administrador de base de datos se utilizarán para ejecutar las tareas de inicialización de la base de datos que, a su vez, crean el esquema de Mobile Foundation necesario y las tablas de la base de datos (si no existe). Mediante el secreto de administración de base de datos, puede controlar las operaciones DDL en su instancia de base de datos.

    Si no se proporcionan los detalles del `Secreto Admin de BD de MFP Server` y el `Secreto Admin de BD de MFP Appcenter`, se utilizará el `Nombre del secreto de base de datos` para realizar las tareas de inicialización de base de datos.

    Ejecute el siguiente fragmento de código para crear un `Secreto Admin de BD de MFP Server` para Mobile Foundation Server:

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

    Ejecute el siguiente fragmento de código para crear un `Secreto Admin de BD de MFP Appcenter` para Mobile Foundation Server:      

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

10. (Opcional) Cree el contenedor **Política de imagen** y **Secretos de extracción de imagen** cuando las imágenes del contenedor se extraen de un registro que está fuera del registro del contenedor de la configuración de IBM Cloud Private (DockerHub, registro de docker privado, etc.) 

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

   > NOTA: el texto incluido < > se ha de actualizar con los valores correctos. 


   Para obtener más información, consulte [Configuración del almacén de claves de MobileFirst Server]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).

### Requisitos de PodSecurityPolicy

Este gráfico requiere que se enlace una PodSecurityPolicy con el espacio de nombres de destino antes del despliegue. Elija una política de seguridad de pod (PodSecurityPolicy) predefinida o solicite al administrador del clúster que cree una PodSecurityPolicy personalizada:

* Nombre de PodSecurityPolicy predefinido: [`ibm-restricted-psp`](https://ibm.biz/cpkspec-psp)
* Definición de PodSecurityPolicy personalizada: 

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
	  - TODOS los
	  volúmenes: 
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

   * ClusterRole (rol de clúster) personalizado para la PodSecurityPolicy personalizada:

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
    > NOTA: Solo es necesario crear la PodSecurityPolicy una vez, si ya existe PodSecurityPolicy, omita este paso.

   El administrador del clúster puede pegar las definiciones de PSP y ClusterRole anteriores en la pantalla de creación de recursos de la interfaz de usuario o ejecutar los dos mandatos siguientes:

```bash
    kubectl create -f <PSP yaml file>
    kubectl create clusterrole ibm-mobilefoundation-prod-psp-clusterrole --verb=use --resource=podsecuritypolicy --resource-name=ibm-mobilefoundation-prod-psp
```

   También es necesario crear `RoleBinding`:

```bash
    kubectl create rolebinding ibm-mobilefoundation-prod-psp-rolebinding --clusterrole=ibm-mobilefoundation-prod-psp-clusterrole --serviceaccount=<namespace>:default --namespace=<namespace>
```

## Recursos necesarios 
{: #resources-required}

De forma predeterminada, este gráfico utiliza los siguientes recursos: 

| Componente | CPU  | Memoria | Almacenamiento
|---|---|---|---|
| Mobile Foundation Server | **Solicitud/Mín:** 1000m CPU, **Límite/Máx:** 2000m CPU | **Solicitud/Mín:** 2048Mi de memoria, **Límite/Máx:** 4096Mi de memoria | Para los requisitos de base de datos, consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
| Mobile Foundation Push | **Solicitud/Mín:** 1000m CPU, **Límite/Máx:** 2000m CPU | **Solicitud/Mín:** 2048Mi de memoria, **Límite/Máx:** 4096Mi de memoria | Para los requisitos de base de datos, consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
| Mobile Foundation Analytics | **Solicitud/Mín:** 1000m CPU, **Límite/Máx:** 2000m CPU | **Solicitud/Mín:** 2048Mi de memoria, **Límite/Máx:** 4096Mi de memoria | Un volumen persistente. Consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts) para obtener más información
| Mobile Foundation Application Center | **Solicitud/Mín:** 1000m CPU, **Límite/Máx:** 2000m CPU | **Solicitud/Mín:** 2048Mi de memoria, **Límite/Máx:** 4096Mi de memoria | Para los requisitos de base de datos, consulte [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts)
## Configuración
{: #configuration}

### Parámetros 
La tabla siguiente indica las variables de entorno utilizadas en la instancia de {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} y {{ site.data.keys.mf_appcenter }} en {{ site.data.keys.prod_icp }}.

| Calificador | Parámetro | Definición | Valor permitido |
|---|---|---|---|
| global.arch | amd64 | Preferencia de planificador de nodos trabajadores de amd64 en un clúster híbrido | 3 - Más preferido (Predeterminado) |
|      | ppcle64 | Preferencia de planificador de nodos trabajadores de ppc64le en un clúster híbrido | 2 - Sin preferencia (Predeterminado) |
|      | s390x | Preferencia de planificador de nodos trabajadores de S390x en un clúster híbrido | 2 - Sin preferencia (Predeterminado) |
| global.image     | pullPolicy | Política de extracción de imágenes | Always, Never, o IfNotPresent. Predeterminado: IfNotPresent |
|      |  pullSecret    | Secreto de extracción de imagen | Solo es necesario si las imágenes no están alojadas en el registro de imágenes de ICP |
| global.ingress | hostname | El nombre de host externo o dirección IP para que lo utilicen los clientes externos | Déjelo en blanco para utilizar el valor predeterminado de la dirección IP del nodo de proxy del clúster|
|         | secret | Nombre del secreto TLS | Especifica el nombre del secreto para el certificado que se ha de utilizar en la definición Ingress. El secreto se ha de crear previamente utilizando el certificado y clave relevantes. Es obligatorio si está habilitado SSL/TLS. Cree previamente el secreto con el certificado & clave antes de proporcionar el nombre aquí |
|         | sslPassThrough | Habilitar passthrough SSL | Especifica si se ha de pasar la solicitud SSL mediante el servicio Mobile Foundation - la terminación de SSL se produce en el servicio Mobile Foundation. Predeterminado: false |
| global.dbinit | habilitado | Habilitar la inicialización de las bases de datos del servidor, Push y Centro de aplicaciones | Inicializa las bases de datos y crea esquemas y tablas para el despliegue del servidor, Push y el centro de aplicaciones.(No es necesario para las analíticas). Predeterminado: true |
|  | repository | Repositorios de imagen Docker para la inicialización de base de datos | Repositorio de imagen de docker de la base de datos Mobile Foundation |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
| mfpserver | habilitado       | Distintivo para habilitar el servidor | true (predeterminado) o false |
| mfpserver.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Server |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
|  mfpserver.db | host | Dirección IP o nombre de host de la base de datos donde se han de configurar las tablas de Mobile Foundation Server. | IBM DB2 (predeterminado). |
|                       | port | 	Puerto donde se configura la base de datos | |
|                       | secret | Secreto ya creado que tiene credenciales de base de datos| |
|                       | name | Nombre de la base de datos de Mobile Foundation Server | |
|                       | schema | Esquema de bd de servidor que se ha de crear. | Si ya existe el esquema, se utilizará. De lo contrario, se creará. |
|                       | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es false (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
|                       | driverPvc | Reclamación de volumen persistente para acceder al controlador de base de datos JDBC| Especifique el nombre de la reclamación de volumen persistente que aloja el controlador de base de datos JDBC. Es necesario si el tipo de base de datos seleccionado no es DB2 |
|                       | adminCredentialsSecret | Secreto Admin de BD de MFPServer | Si ha habilitado la inicialización de base de datos, proporcione el secreto para crear las tablas y esquemas de base datos para los componentes de Mobile Foundation |
| mfpserver | adminClientSecret | Secreto de cliente administrador | Especifique el nombre del secreto de cliente creado. Consulte #6 en [Requisitos previos](#Prerequisites) |
|  | pushClientSecret | Secreto de cliente Push | Especifique el nombre del secreto de cliente creado. Consulte #6 en [Requisitos previos](#Prerequisites) |
| mfpserver.replicas |  | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: 3) |
| mfpserver.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler). Tenga en cuenta que al habilitar este campo se inhabilita el campo de réplicas. | false (predeterminado) o true |
|           | minReplicas  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | maxReplicas | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior al mín. | Entero positivo (predeterminado: 10) |
|           | targetCPUUtilizationPercentage | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| mfpserver.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
|    mfpserver.customConfiguration |  |  Configuración del servidor predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica del servidor a una correlación de configuración creada previamente |
| mfpserver.jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation Server para personalizar el despliegue  | Especifique pares de valores de nombre separados por comas |
| mfpserver | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpserver.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | habilitado       | Distintivo para habilitar Mobile Foundation Push | true (predeterminado) o false |
|           | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Push |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
| mfppush.replicas | | Número de instancias (pods) de Mobile Foundation Server que se han de crear | Entero positivo (Predeterminado: 3) |
| mfppush.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | minReplicas  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | maxReplicas | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetCPUUtilizationPercentage | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| mfppush.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| mfppush.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Push a una correlación de configuración creada previamente |
|mfppush.jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation Server para personalizar el despliegue  | Especifique pares de valores de nombre separados por comas |
| mfppush | keystoresSecretName | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfppush.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics | habilitado       | Distintivo para habilitar las analíticas | false (predeterminado) o true |
| mfpanalytics.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Operational Analytics |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
| mfpanalytics.replicas |  | Número de instancias (pods) de Mobile Foundation Operational Analytics que se han de crear | Entero positivo (Predeterminado: 2) |
| mfpanalytics.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | minReplicas  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | maxReplicas | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetCPUUtilizationPercentage | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
|  mfpanalytics.shards|  | Número de fragmentos Elasticsearch para Mobile Foundation Analytics | predeterminado: 2 |             
|  mfpanalytics.replicasPerShard|  | Número de réplicas Elasticsearch que se van a mantener por cada fragmento de Mobile Foundation Analytics | predeterminado: 2 |
| mfpanalytics.persistence | habilitado      | Utilice una PersistentVolumeClaim para la persistencia de los datos     | true |                                                 |
|            |useDynamicProvisioning      | Especifique una storeclass o deje el campo vacío  | false  |                                                  |
|           |volumeName| Proporcione un nombre de volumen  | data-stor (predeterminado) |
|           | claimName| Proporcione una PersistentVolumeClaim existente | nil |
|           |storageClassName     | Clase de almacenamiento de la PersistentVolumeClaim de respaldo | nil |
|           |size             | Tamaño del volumen de datos      | 20Gi |
| mfpanalytics.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
|    mfpanalytics.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Analytics a una correlación de configuración creada previamente |
| mfpanalytics.jndiConfigurations | mfpfProperties | Propiedades JNDI de Mobile Foundation que se han de especificar para personalizar las analíticas operativas| Especifique pares de valores de nombre separados por comas |
| mfpanalytics | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpanalytics.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 2000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 4096Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 2048Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpappcenter | habilitado       | Distintivo para habilitar Application Center | false (predeterminado) o true |  
| mfpappcenter.image | repository | Repositorio de imagen Docker | Repositorio de la imagen Docker de Mobile Foundation Application Center |
|           | tag | Etiqueta de imagen Docker | Consulte la descripción de la etiqueta Docker |
|           | consoleSecret | Un secreto ya creado para inicio de sesión | Consulte la sección de requisitos previos |
|  mfpappcenter.db | host | Dirección IP o nombre de host de la base de datos donde se ha de configurar la base de datos de Appcenter. | |
|                       | port | 	 Puerto de la base de datos | |             
|                       | name | Nombre de la base de datos que se va a utilizar | La base de datos debe crearse previamente. |
|                       | secret | Secreto ya creado que tiene credenciales de base de datos| |
|                       | schema | Esquema de base de datos de Application Center que se ha de crear. | Si ya existe el esquema, se utilizará. Si no es así, se creará. |
|                       | ssl |Tipo de conexión de base de datos | Especifique si la conexión de base de datos ha de ser http o https. El valor predeterminado es false (http). Asegúrese de que el puerto de base de datos también esté configurado para la misma modalidad de conexión. |
|                       | driverPvc | 	 Reclamación de volumen persistente para acceder al controlador de base de datos JDBC| Especifique el nombre de la reclamación de volumen persistente que aloja el controlador de base de datos JDBC. Es necesario si el tipo de base de datos seleccionado no es DB2 |
|                       | adminCredentialsSecret | Secreto Admin de BD de Application Center | Si ha habilitado la inicialización de base de datos, proporcione el secreto para crear las tablas y esquemas de base datos para los componentes de Mobile Foundation |
| mfpappcenter.autoscaling     | habilitado | Especifica si se despliega un HPA (Horizontal Pod Autoscaler).  Tenga en cuenta que al habilitar este campo se inhabilita el campo replicaCount. | false (predeterminado) o true |
|           | minReplicas  | Límite inferior del número de pods que puede establecer el escalador automático. | Entero positivo (predeterminado: 1) |
|           | maxReplicas | Límite superior del número de pods que puede establecer el escalador automático. No puede ser inferior a minReplicas. | Entero positivo (predeterminado: 10) |
|           | targetCPUUtilizationPercentage | Uso promedio objetivo de CPU (representado como un porcentaje de la CPU solicitada) sobre todos los pods. | Entero entre 1 y 100 (predeterminado 50) |
| mfpappcenter.pdb     | habilitado | Especifique si se ha de habilitar/inhabilitar PDB.| true (predeterminado) o false |
|           | min  | mínimo de pods disponibles | Entero positivo (predeterminado: 1) |
| mfpappcenter.customConfiguration |  |  Configuración predeterminada (Opcional)  | Proporcione una referencia de configuración adicional específica de Application Center a una correlación de configuración creada previamente |
| mfpappcenter | keystoreSecret | Consulte la sección de configuración para crear previamente el secreto con almacenes de claves y sus contraseñas.|
| mfpappcenter.resources | limits.cpu | Describe la cantidad máxima de CPU permitida.  | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describe la cantidad de memoria máxima permitida. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu | Describe la cantidad mínima de CPU requerida - si no se especifica tomará el valor predeterminado del límite (si se ha especificado) o de lo contrario el valor definido por la implementación. | El valor predeterminado es 1000m. Consulte Kubernetes - [significado de CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describe la cantidad mínima de memoria necesaria. Si no se especifica, el límite será el valor predeterminado de cantidad de memoria (si se ha especificado) o el valor definido por implementación. | El valor predeterminado es 1024Mi. Consulte Kubernetes - [significado de memoria](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

> Para ver la guía de aprendizaje sobre el análisis de registros de {{ site.data.keys.prod_adj }} utilizando Kibana, consulte [aquí](analyzing-mobilefirst-logs-on-icp/).

### Instalación de gráficos Helm {{ site.data.keys.prod_adj }} desde el catálogo de ICP
{: #install-hmc-icp}

#### Instalación de {{ site.data.keys.mf_server }}
{: #install-mf-server}

Es posible que junto con {{ site.data.keys.mf_server }} también despliegue {{ site.data.keys.mf_analytics }} y {{ site.data.keys.mf_app_center }} desde el mismo gráfico. No obstante, el despliegue de {{ site.data.keys.mf_analytics }} y {{ site.data.keys.mf_app_center }}  es opcional. 

Nota: 

1. Antes de empezar la instalación de {{ site.data.keys.mf_server }}, preconfigure una base de datos DB2.
2. Antes de empezar la instalación del gráfico de {{ site.data.keys.mf_analytics }}, configure el **Volumen persistente**. Proporcione el **Volumen persistente** para configurar {{ site.data.keys.mf_analytics }}. Siga los pasos descritos en la [documentación de {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_cluster/create_volume.html) para crear un **Volumen persistente**. También puede consultar la **sección-6** en [Instalar y configurar gráficos Helm de IBM {{ site.data.keys.product }}](#configure-install-mf-helmcharts) para ver el archivo yaml de ejemplo.

Siga esos pasos para instalar y configurar IBM Mobile Foundation desde la consola de gestión de {{ site.data.keys.prod_icp }}.

1. Vaya a **Catálogo** en la consola de gestión.
2. Seleccione el gráfico helm **ibm-mobilefoundation-prod**.
3. Pulse **Configurar**.
4. Proporcione las variables de entorno. Consulte [Configuración](#configuration) para obtener más información. 
5. Acepte el **Acuerdo de licencia**.
6. Pulse **Instalar**.

> NOTA: La versión más reciente de Mobile Foundation incluida en los paquetes de ICP da soporte al software siguiente -
> 1. IBM JRE8 SR5 FP37 (8.0.5.37)
> 2. IBM WebSphere Liberty v18.0.0.5

## Verificación de la instalación
{: #verify-install}

Después de haber instalado y configurado {{ site.data.keys.mf_analytics }} (opcional) y {{ site.data.keys.mf_server }}, puede verificar la instalación y el estado de los pods desplegados mediante las acciones siguientes:

En la consola de gestión de {{ site.data.keys.prod_icp }}. Seleccione **Cargas de trabajo > Releases de Helm**. Pulse el *nombre de release* de la instalación.

## Acceso a la consola {{ site.data.keys.prod_adj }}
{: #access-mf-console}

Después de una instalación correcta, el despliegue puede tardar algunos minutos en completarse. 

Desde un navegador web, vaya a la página de la consola de IBM Cloud Private y vaya a la página de release de helm como se indica a continuación
1. Pulse el menú en la parte superior izquierda de la página. 
2. Seleccione cargas de trabajo > Releases de Helm.
3. Pulse el release de helm de IBM Mobile Foundation desplegado.
4. Consulte la sección [NOTAS](https://github.ibm.com/MobileFirst/ibm-mobilefoundation-prod/blob/development/stable/ibm-mobilefoundation-prod/templates/NOTES.txt) para obtener información sobre el procedimiento para acceder a la consola de operaciones de Mobile Foundation Server. 

## Aplicación de ejemplo
{: #sample-app}
Consulte las [{{ site.data.keys.prod_adj }} guías de aprendizaje](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) para desplegar el adaptador de ejemplo y ejecutar la aplicación de ejemplo en IBM {{ site.data.keys.mf_server }} en ejecución en {{ site.data.keys.prod_icp }},

## Actualización de {{ site.data.keys.prod_adj }} releases y gráficos Helm
{: #upgrading-mf-helm-charts}

Consulte [Actualización de productos empaquetados](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html) para obtener instrucciones sobre cómo actualizar los gráficos/releases de helm.

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

## Migrar a IBM Certified Cloud Pak for Mobile Foundation Platform
{: #migrate}

Ahora con [IBM Certified Cloud Pak](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/app_center/cloud_paks_over.html), Mobile Foundation está disponible para su despliegue como un único gráfico helm. Esto sustituye el método anterior de utilizar tres diagramas de Helm diferentes (viz. ibm-mfpf-server-prod, ibm-mfpf-analytics-prod e ibm-mfpf-appcenter-prod) para el despliegue de los componentes de Mobile Foundation.

Migrar desde los componentes antiguos de Mobile Foundation instalados como releases de helm separados en el despliegue de ICP al nuevo único gráfico helm consolidado con IBM Certified Cloud Pak es sencillo, 

1. Puede retener todos los parámetros de configuración para Server, Push, Application Center y Analytics.
2. Si los detalles de la base de datos se utilizan del mismo modo que en el despliegue antiguo, el nuevo despliegue de Mobile Foundation (Server, Push y Application Center) tendrá los mismos datos que los del antiguo.
3. Observe el cambio en los valores de la base de datos que se deben especificar. Ahora el acceso a la base de datos se controla ahora mediante los secretos. Consulte la sección-4 en [Requisitos previos](#Prerequisites) para crear secretos para cualquier credencial (incluidos los inicios de sesión de consola, las cuentas de base de datos, etc).
4. Los datos de Mobile Foundation Analytics se pueden retener reutilizando la misma Reclamación de volumen persistente utilizada en el despliegue antiguo.

## Copia de seguridad y recuperación de MFP Analytics Data
{: #backup-analytics}

MFP Analytics Data está disponible como parte de [PersistentVolume o PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) de Kubernetes. Es posible que esté utilizando uno de los [plugins de volumen que ofrece Kubernetes](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes).

La copia de seguridad y la restauración depende de los plugins de volumen que utilice. Hay varios medios y herramientas mediante los cuales puede realizar la copia de seguridad o restauración del volumen.

Kubernetes proporciona las [**Opciones VolumeSnapshot, VolumeSnapshotContent y Restore**](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature). Puede realizar una copia del [volumen del clúster](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) suministrada por un administrador.

Utilice los siguientes [archivos yaml de ejemplo](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes) para probar la característica de instantánea.

También puede utilizar otras herramientas para realizar una copia de seguridad y restauración del volumen -

- IBM Cloud Automation Manager (CAM) en ICP

    Utilice las prestaciones de CAM y las estrategias para la [Copia de seguridad/restauración, Alta disponibilidad (HA) y Recuperación ante siniestro (DR) para instancias CAM](https://developer.ibm.com/cloudautomation/2018/05/08/backup-ha-dr/)

- [Portworx](https://portworx.com) en ICP

    Es una solución de almacenamiento diseñada para aplicaciones desplegadas como contenedores o mediante orquestaciones de contenedor, tal como Kubernetes

- Stash mediante [AppsCode](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/)

    Mediante el uso de Stash, puede realizar la copia de seguridad de los volúmenes en Kubernetes

## Desinstalar
{: #uninstall}
Para desinstalar {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}, utilice [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Utilice el mandato siguiente para suprimir completamente los gráficos instalados y los despliegues asociados:

```bash
helm delete <my-release> --purge --tls
```
*my-release* es el nombre de release desplegado del gráfico Helm.

Este mandato elimina todos los componentes de Kubernetes (excepto cualquier Reclamación de volumen persistente (PVC)) asociada al gráfico. Este comportamiento predeterminado de Kubernetes asegura que no se supriman los datos valiosos. 
