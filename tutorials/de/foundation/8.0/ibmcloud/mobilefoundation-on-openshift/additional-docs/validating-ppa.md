---
layout: tutorial
breadcrumb_title: Validating Mobile Foundation archive from PPA
title: Von Passport Advantage heruntergeladenes IBM Mobile-Foundation-Archiv validieren
weight: 5
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
### Von Passport Advantage heruntergeladenes IBM Mobile-Foundation-Archiv validieren (optional)

Das in Passport Advantage verfügbare IBM Mobile-Foundation-Paket für die Containerplattform Red Hat OpenShift ist mit Digi Cert signiert, um die Integrität des Pakets zu sichern. Zusammen mit der .tar.gz-Datei von IBM MobileFirst Platform Foundation Version 8.0 für IBM MobileFirst Platform Server für die Containerplattform Red Hat OpenShift werden eine Signaturdatei (`.sig`) und ein öffentlicher RSA-Schlüssel (`.pub`) an Passport Advantage gesendet. Kunden können die Integrität des Pakets überprüfen, indem sie wie folgt die Signatur überprüfen.

#### In Passport Advantage verfügbare Paketinformationen

**Package**: .tar.gz-Datei von IBM MobileFirst Platform Foundation Version 8.0 für IBM MobileFirst Platform Server für die Containerplattform Red Hat OpenShift in Englisch (z. B. eImage Part Number: CC3FDEN)

**Signature File**: Signaturdatei zur .tar.gz-Datei von IBM MobileFirst Platform Foundation Version 8.0 für IBM MobileFirst Platform Server für die Containerplattform Red Hat OpenShift in Englisch (z. B. eImage Part Number: CC3FEEN)

**RSA Public Key**: Datei mit dem öffentlichen Schlüssel zur .tar.gz-Datei von IBM MobileFirst Platform Foundation Version 8.0 für IBM MobileFirst Platform Server für die Containerplattform Red Hat OpenShift in Englisch (eImage Part Number: CC3FFEN)

#### Schritte für die Überprüfung der Signatur

* Laden Sie das OpenSSL-Toolkit ([openssl](https://www.openssl.org)) herunter und installieren Sie es.
* Überprüfen Sie dann mit folgendem Befehl das IBM Mobile-Foundation-Paket:

  ```bash
  openssl dgst -sha256 -verify <ÖFFENTLICHER_SCHLÜSSEL> -signature <SIGNATURDATEI> <ARCHIV MIT DEM IBM MOBILE-FOUNDATION-PAKET>
  ```
  Beispiel:

  ```bash
  openssl dgst -sha256 -verify CC3FFEN.pub -signature CC3FEEN.sig CC3FDEN.tar.gz
  ```  
