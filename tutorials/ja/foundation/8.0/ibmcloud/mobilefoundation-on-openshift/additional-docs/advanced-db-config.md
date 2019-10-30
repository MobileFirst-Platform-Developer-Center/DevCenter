---
layout: tutorial
breadcrumb_title: Using Oracle (or) MySQL as IBM Mobile Foundation database
title: Oracle (または) MySQL を IBM Mobile Foundation データベースとして使用する
weight: 2
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Oracle (または) MySQL を IBM Mobile Foundation データベースとして使用する

Mobile Foundation サーバー、Push および Application Center コンポーネントのデータを保管するために、事前構成済みのデータベースが必要です。

DB2 以外のデータベースを使用して Mobile Foundation をセットアップするには、[ここ](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/#mysql-database-and-user-requirements)にある指示に従います。

デフォルトでは、Mobile Foundation インストーラーは IBM DB2 JDBC ドライバーとともにパッケージ化されています。Oracle および MySQL の場合、JDBC ドライバー (MySQL の場合、Connector/J JDBC ドライバーを使用し、Oracle の場合、Oracle シン JDBC ドライバーを使用します) が永続ボリューム内に配置されていることを確認してください。

1. JDBC ドライバーを NFS マウント・ボリュームに配置します。例: */nfs/share/dbdrivers*

2. NFS サーバーの正しい詳細および JDBC ドライバーが保管されている場所のパスを指定することで、永続ボリューム (PV) および永続ボリューム要求 (PVC) を作成します。サンプル yaml を以下に示します。

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

    > **注**: 上記の yaml に正しい *projectname-or-namespace* を追加したことを確認します。

### [オプション] 特権 (admin) を使用して Mobile Foundation データベース操作を処理する
{: #handle-mf-db-operations}

個別のデータベース管理秘密を使用して、データベースの初期化タスクを実行できます。これにより、必要な Mobile Foundation スキーマおよび表がデータベースに作成されます (まだ存在しない場合)。データベース管理秘密を使用して、データベース・インスタンスでの DDL 操作を制御できます。

`MFP サーバー DB 管理秘密`および `MFP Appcenter DB 管理秘密`の詳細が指定されていない場合、デフォルトの`データベース秘密名`を使用してデータベース初期化タスクが実行されます。

Mobile Foundation サーバー用の `MFP サーバー DB 管理秘密`を作成するには、以下のコード・スニペットを実行します。

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

Appcenter 用の `MFP Appcenter DB 管理秘密`を作成するには、以下のコード・スニペットを実行します。

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
