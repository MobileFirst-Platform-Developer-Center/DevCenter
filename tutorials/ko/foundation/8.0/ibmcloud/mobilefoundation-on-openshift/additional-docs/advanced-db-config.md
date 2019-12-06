---
layout: tutorial
breadcrumb_title: Using Oracle (or) MySQL as IBM Mobile Foundation database
title: IBM Mobile Foundation 데이터베이스로 Oracle 또는 MySQL 사용
weight: 2
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## IBM Mobile Foundation 데이터베이스로 Oracle 또는 MySQL 사용

Mobile Foundation 서버, Push 및 Application Center 컴포넌트에 대한 데이터를 저장하려면 사전 구성된 데이터베이스가 필요합니다.

[여기](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/#mysql-database-and-user-requirements) 지침에 따라 DB2 외 데이터베이스에서 Mobile Foundation을 설정하십시오.

기본적으로 Mobile Foundation 설치 프로그램은 IBM DB2 JDBC 드라이버에 함께 패키지되어 있습니다. Oracle 및 MySQL의 경우 JDBC 드라이버(MySQL의 경우 커넥터/J JDBC 드라이버 사용, Oracle의 경우 Oracle 씬 JDBC 드라이버 사용)가 지속적 볼륨에 있는지 확인하십시오.

1. JDBC 드라이버를 NFS로 마운트된 볼륨에 배치하십시오. 예: */nfs/share/dbdrivers*

2. JDBC 드라이버가 저장되는 경로 및 올바른 NFS 서버 세부사항을 제공하여 지속적 볼륨(PV) 및 지속적 볼륨 청구(PVC)를 작성하십시오. 샘플 yaml은 아래 표시됩니다.

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

    > **참고**: 위 yaml에 올바른 *projectname-or-namespace*를 추가했는지 확인하십시오.

### [선택사항] 특수 관리 권한으로 Mobile Foundation 데이터베이스 오퍼레이션 처리
{: #handle-mf-db-operations}

데이터베이스 초기화 태스크를 실행하도록 별도의 데이터베이스 관리 시크릿을 보유할 수 있습니다. 그러면 차례로 데이터베이스에서 필요한 Mobile Foundation 스키마 및 테이블을 작성합니다(아직 없는 경우). 데이터베이스 Admin 시크릿을 통해 데이터베이스 인스턴스에서 DDL 오퍼레이션을 제어할 수 있습니다.

`MFP Server DB Admin Secret` 및 `MFP Appcenter DB Admin Secret` 세부사항이 제공되지 않으면 기본 `Database Secret Name`을 사용하여 데이터베이스 초기화 태스크를 수행합니다.

아래 코드 스니펫을 실행하여 Mobile Foundation에 대한 `MFP Server DB Admin Secret`을 작성하십시오.

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

아래 코드 스니펫을 실행하여 Appcenter에 대한 `MFP Appcenter DB Admin Secret`을 작성하십시오.

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
