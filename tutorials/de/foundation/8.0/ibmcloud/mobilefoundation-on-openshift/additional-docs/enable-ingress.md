---
layout: tutorial
breadcrumb_title: Ingress-Parameter aktivieren
title: Ingress-Parameter aktivieren
weight: 4
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Ingress-Parameter aktivieren
{: #enable-ingress-parameters}

Sie müssen Ingress für den Zugriff auf die im OpenShift-Cluster implementierten Mobile-Foundation-Instanzen konfigurieren. Sehen Sie sich dazu die folgenden Szenarien an. 

1. Bei **HTTP-Implementierungen** sieht der Ingress-Abschnitt in der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` wie folgt aus:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: ""
      sslPassThrough: false
    ```

2. Bei **HTTPS-Implementierungen** ist ein geheimer TLS-Schlüssel obligatorisch.
    * Generieren Sie mit dem folgenden Befehl `tls.key` und `tls.crt`:

      ```bash
      openssl genrsa -out tls.key 2048
      openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=myhost.mydomain.com
      oc create secret tls mf-tls-secret --cert=tls.cert --key=tls.key
      ```

    * Erstellen Sie mit dem folgenden Befehl den geheimen TLS-Zugriffsschlüssel:

      ```bash
      kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
      ```

    Der Ingress-Abschnitt in der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` sieht wie folgt aus:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    ```

3. Wenn **HTTPS für Back-End-Services** verwendet wird, muss `tls.crt` in die Dateien `keystore.jks` und `truststore.jks` importiert werden.

    Erstellen Sie vorab einen geheimen Schlüssel mit `keystore.jks` und `truststore.jks`. Nehmen Sie die in Schritt 2 erstellte Datei `tls.crt` in den Keystore und den Truststore auf. Nehmen Sie außerdem das Keystore- und Truststore-Kennwort auf. Verwenden Sie dafür die Literale KEYSTORE_PASSWORD und TRUSTSTORE_PASSWORD. Geben Sie der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` im Feld *keystoreSecret* für die jeweilige Komponente den Namen des geheimen Schlüssels an.

    Speichern Sie die Dateien `keystore.jks` und `truststore.jks` sowie die zugehörigen Kennwörter wie nachfolgend angegeben.

    Beispiel: 

    ```bash
    oc create secret generic server-stores --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
    ```

    > **HINWEIS**: Die  Namen der Dateien und Literale müssen mit den Angaben im obigen Befehl übereinstimmen. Geben Sie diesen Namen des geheimen Schlüssels im Eingabefeld *keystoreSecret* der jeweiligen Komponente an, um die Standard-Keystores beim Konfigurieren angepasster Ressourcen außer Kraft zu setzen. 

    Der Ingress-Abschnitt in der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` sieht wie folgt aus:

    ```yaml
    ingress:
      hostname: "myhost.mydomain.com"
      secret: "mf-tls-secret"
      sslPassThrough: false
    https: true
    mfpserver:
      keystoreSecret: "server-stores"
    ```  
