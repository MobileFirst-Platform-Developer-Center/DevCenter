---
layout: tutorial
breadcrumb_title: Using Oracle (or) MySQL as IBM Mobile Foundation database
title: Utilización de Oracle (o) MySQL como base de datos de IBM Mobile Foundation
weight: 2
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Utilización de Oracle (o) MySQL como base de datos de IBM Mobile Foundation

Se requiere una base de datos preconfigurada para almacenar los componentes Mobile Foundation Server, Push y Application Center. 

Para configurar Mobile Foundation con una base de datos no de DB2, siga las instrucciones
[aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/#mysql-database-and-user-requirements). 

De forma predeterminada, los instaladores de Mobile Foundation están empaquetados con los controladores JDBC de IBM DB2. En Oracle y MySQL, asegúrese de que el controlador JDBC, (para MySQL utilice el controlador JDBC Connector/J y para Oracle utilice el controlador JDBC ligero de Oracle), esté ubicado en un volumen persistente.

1. Coloque el controlador JDBC en un volumen montado en NFS. Ejemplo: */nfs/share/dbdrivers*

2. Cree un volumen persistente (PV) y una reclamación de volumen persistente (PVC) proporcionando los detalles del servidor NFS correctos y la vía de acceso en la que se almacena el controlador JDBC. El yaml de ejemplo se muestra a continuación.

    ```yaml
     # Sample PersistentVolume.yaml
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

    ```yaml
    # Sample PersistentVolumeClaim.yaml
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: mfppvc
        namespace: projectname-or-namespace
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

    > **NOTA**: Asegúrese de que ha añadido el *projectname-o-namespace* correcto en el yaml anterior. 

### [OPCIONAL] Manejo de las operaciones de base de datos de Mobile Foundation con privilegios especiales (admin)
{: #handle-mf-db-operations}

Es posible tener un secreto admin de base de datos separado para ejecutar las tareas de inicialización de base de datos que, a su vez, crean el esquema y las tablas de Mobile Foundation en la base de datos (si todavía no existe). Mediante el secreto de administración de base de datos, puede controlar las operaciones DDL en su instancia de base de datos. 

Si no se proporcionan los detalles del `Secreto Admin de BD de MFP Server` y el `Secreto Admin de BD de MFP Appcenter`, se utilizará el `Nombre del secreto de base de datos` para realizar las tareas de inicialización de base de datos.

Ejecute el siguiente fragmento de código para crear un `Secreto Admin de BD de MFP Server` para Mobile Foundation Server.

```yaml
# Create MFP Server Admin DB secret for Mobile Foundation server component
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

Ejecute el siguiente fragmento de código para crear un `Secreto Admin de BD de MFP Appcenter` para Appcenter.

```yaml
# Create Appcenter Admin DB secret for Mobile Foundation Appcenter
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  MFPF_APPCNTR_DB_ADMIN_USERNAME: encoded_uname
  MFPF_APPCNTR_DB_ADMIN_PASSWORD: encoded_password
kind: Secret
metadata:
name: appcenter-dbadminsecret
type: Opaque
EOF
```
