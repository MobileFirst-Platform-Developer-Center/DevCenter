---
layout: tutorial
breadcrumb_title: Validating Mobile Foundation archive from PPA
title: Validating IBM Mobile Foundation archive downloaded from Passport Advantage Archive
weight: 5
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
### Validating IBM Mobile Foundation archive downloaded from Passport Advantage Archive (Optional)

IBM Mobile Foundation package for Red Hat OpenShift Container Platform, which is available in Passport Advantage, is code signed (with Digi Cert) to enforce integrity of the package. A `.sig` (signature file) and a `.pub` (RSA public key) file are shipped to the Passport Advantage along with the IBM MobileFirst Platform Foundation V8.0 .tar.gz file of IBM MobileFirst Platform Server on Red Hat OpenShift Container Platform. Customers can validate the integrity of the package by verifying the signature as below.

#### Package Information as available in Passport Advantage

**Package**: IBM MobileFirst Platform Foundation V8.0 .tar.gz file of IBM MobileFirst Platform Server on Red Hat OpenShift Container Platform English (Example: eImage Part Number: CC3FDEN)

**Signature File**: Signature file for IBM MobileFirst Platform Foundation V8.0 .tar.gz file of IBM MobileFirst Platform Server on Red Hat OpenShift Container Platform English (Example: eImage Part Number: CC3FEEN)

**RSA Public Key**: Public Key file for IBM MobileFirst Platform Foundation V8.0 .tar.gz file of IBM MobileFirst Platform Server on Red Hat OpenShift Container Platform English (eImage Part Number: CC3FFEN)

#### Steps to verify the signature

* [openssl](https://www.openssl.org), download and install the openssl toolkit.
* Now verify the IBM Mobile Foundation package using the following command.

  ```bash
  openssl dgst -sha256 -verify <PUBLIC_KEY> -signature <SIGNATURE_FILE> <IBM MOBILE FOUNDATION PACKAGE ARCHIVE>
  ```
  For example,

  ```bash
  openssl dgst -sha256 -verify CC3FFEN.pub -signature CC3FEEN.sig CC3FDEN.tar.gz
  ```  
