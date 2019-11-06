---
layout: tutorial
breadcrumb_title: Validating Mobile Foundation archive from PPA
title: Validación del archivo de IBM Mobile Foundation descargado desde Passport Advantage Archive
weight: 5
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
### Validación del archivo de IBM Mobile Foundation descargado desde Passport Advantage Archive (Opcional) 

El paquete de IBM Mobile Foundation para Red Hat OpenShift Container Platform, que está disponible en Passport Advantage, está firmado con código (con Digi Cert) para aplicar la integridad del paquete. Se envían un archivo `.sig` (archivo de firma) y un archivo `.pub` (clave pública RSA) a Passport Advantage. junto con el archivo .tar.gz IBM MobileFirst Platform Foundation Versión 8.0 de IBM MobileFirst Platform Server en Red Hat OpenShift Container Platform. Los clientes pueden validar la integridad del paquete verificando la firma tal como se indica a continuación.

#### Información del paquete tal como está disponible en Passport Advantage

**Paquete**: Archivo .tar.gz IBM MobileFirst Platform Foundation V8.0 de IBM MobileFirst Platform Server en Red Hat OpenShift Container Platform English (Ejemplo: Número de componente de eImage: CC3FDEN)

**Archivo de firma**: Archivo de firma para el archivo .tar.gz IBM MobileFirst Platform Foundation V8.0 de IBM MobileFirst Platform Server en Red Hat OpenShift Container Platform English (Ejemplo: Número de componente de eImage: CC3FEEN)

**Clave pública RSA**: Archivo de clave pública para el archivo .tar.gaz IBM MobileFirst Platform Foundation V8.0 de IBM MobileFirst Platform Server en Red Hat OpenShift Container Platform English (Número de componente de eImage: CC3FFEN)

#### Pasos para verificar la firma

* [openssl](https://www.openssl.org), descargue e instale el kit de herramientas openssl.
* Ahora verifique el paquete de IBM Mobile Foundation con el mandato siguiente. 

  ```bash
  openssl dgst -sha256 -verify <PUBLIC_KEY> -signature <SIGNATURE_FILE> <IBM MOBILE FOUNDATION PACKAGE ARCHIVE>
  ```
Por ejemplo:

  ```bash
  openssl dgst -sha256 -verify CC3FFEN.pub -signature CC3FEEN.sig CC3FDEN.tar.gz
  ```  
