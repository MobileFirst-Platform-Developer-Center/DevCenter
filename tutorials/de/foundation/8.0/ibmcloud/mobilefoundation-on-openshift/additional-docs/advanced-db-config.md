---
layout: tutorial
breadcrumb_title: Oracle oder MySQL als IBM Mobile-Foundation-Datenbank verwenden
title: Oracle oder MySQL als IBM Mobile-Foundation-Datenbank verwenden
weight: 2
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Oracle oder MySQL als IBM Mobile-Foundation-Datenbank verwenden

Eine vorkonfigurierte Datenbank ist erforderlich, um die Daten der Komponenten Mobile Foundation Server, Push und Application Center zu speichern.

Anweisungen für das Einrichten der Mobile Foundation mit einer Nicht-DB2-Datenbank finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/#mysql-database-and-user-requirements).

Die Pakete der Mobile-Foundation-Installationsprogramme enthalten standardmäßig IBM DB2-JDBC-Treiber. Stellen Sie für Oracle und MySQL sicher, dass sich der JDBC-Treiber (für MySQL der Connector/J-JDBC-Treiber, für Oracle der Oracle-Thin-JDBC-Treiber) auf einem persistenten Datenträger befindet. 

1. Stellen Sie den JDBC-Treiber auf einen angehängten NFS-Datenträger, z. B. auf */nfs/share/dbdrivers*.

2. Erstellen Sie einen persistenten Datenträger und eine Anforderung eines persistenten Datenträgers. Geben Sie dazu die NFS-Serverdetails und den Pfad an, unter dem der JDBC-Treiber gespeichert ist. Nachfolgend sehen Sie eine YAML-Beispieldatei:

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
            path: <NFS-Pfad>
            server: <NFS-Server>
         EOF
      ```

    ```yaml
    # Beispiel für PersistentVolumeClaim.yaml
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

    > **HINWEIS**: In der obigen YAML-Datei müssen Sie den richtigen Projektnamen oder Namespace (für *projectname-or-namespace*) angeben.

### [OPTIONAL] Mobile-Foundation-Datenbankoperationen mit Sonderrechten (Administratorberechtigung)
{: #handle-mf-db-operations}

Sie können einen separaten geheimen Schlüssel für Datenbankverwaltung haben, um die Datenbankinitialisierung durchzuführen. Während der Initialisierung werden dann das erforderliche Mobile-Foundation-Schema und die erforderlichen Tabellen in der Datenbank erstellt (sofern noch nicht vorhanden). Mithilfe des geheimen Schlüssels für Datenbankverwaltung können Sie die DDL-Operationen für Ihre Datenbankinstanz steuern.

Wenn der geheime Schlüssel für MFP-Server-Datenbankverwaltung und MFP-Application-Center-Datenbankverwaltung (`MFP Server DB Admin Secret` und `MFP Appcenter DB Admin Secret`) nicht angegeben ist, wird für die Datenbankinitialisierung der Standardname für den geheimen Datenbankschlüssel (`Database Secret Name`) verwendet. 

Führen Sie das folgende Code-Snippet aus, um einen geheimen Schlüssel für MFP-Server-Datenbankverwaltung (`MFP Server DB Admin Secret`) zu erstellen.

```yaml
# Geheimen Schlüssel für MFP-Server-DB-Verwaltung für die Komponente Mobile Foundation Server erstellen
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

Führen Sie das folgende Code-Snippet aus, um einen geheimen Schlüssel für MFP-Application-Center-Datenbankverwaltung (`MFP Appcenter DB Admin Secret`) zu erstellen.

```yaml
# Geheimen Schlüssel für Application-Center-Datenbankverwaltung für das Mobile Foundation Application Center erstellen
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
