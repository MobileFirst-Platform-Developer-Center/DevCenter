---
layout: tutorial
breadcrumb_title: Using Oracle (or) MySQL as IBM Mobile Foundation database
title: Using Oracle (or) MySQL as IBM Mobile Foundation database
weight: 2
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Using Oracle (or) MySQL as IBM Mobile Foundation database

A pre-configured database is required to store the data for Mobile Foundation server, Push and Application Center components.

Follow the instructions [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/#mysql-database-and-user-requirements) to setup Mobile Foundation with a non-DB2 database.

By default, Mobile Foundation installers is packaged with IBM DB2 JDBC drivers. For Oracle and MySQL, make sure that the JDBC driver (for MySQL - use the Connector/J JDBC driver,  for Oracle - use the Oracle thin JDBC driver) is placed within a Persistent Volume.

1. Place the JDBC driver in a NFS mounted volume. Example: */nfs/share/dbdrivers*

2. Create a Persistent Volume (PV) and Persistent Volume Claim (PVC) by providing the correct NFS server details and the path where the JDBC driver is stored. Sample yaml is shown below.

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

    > **NOTE**: Make sure you add the right *projectname-or-namespace* in the yaml above.

### [OPTIONAL] Handling Mobile Foundation database operations with special (admin) privileges
{: #handle-mf-db-operations}

We can have a separate database admin secret to execute the database initialization tasks, which would in turn create the required Mobile Foundation schema and tables in the database (if it does not already exist). Through the database Admin secret, you can control the DDL operations on your database instance.

If the `MFP Server DB Admin Secret` and `MFP Appcenter DB Admin Secret` details are not provided, then the default `Database Secret Name` will be used to perform database initialization tasks.

Run the below code snippet to create a `MFP Server DB Admin Secret` for Mobile Foundation Server.

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

Run the below code snippet to create a `MFP Appcenter DB Admin Secret` for Appcenter.

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
