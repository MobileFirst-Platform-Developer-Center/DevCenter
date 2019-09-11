---
layout: tutorial
title: Verify the signature of the PPA download
weight: 1
---

IBM Mobile Foundation packages in PPA are code signed (with Digi Cert) to enforce integrity of the packages.  Along with the archive file that contains IBM Mobile Foundation software product a `.sig` and a `.pub` files are shipped onto to the PPA.   Customers can validate or verify the integrity of the product before using it by verifying the signature as follows.

## Steps to verify the signature

* [openssl](https://www.openssl.org), download and install the openssl toolkit.
* Now verify the IBM Mobile Foundation package using the following command.
  ```bash
  openssl dgst -sha256 -verify <PUBLIC_KEY> -signature <SIGNATURE_FILE> <IBM MOBILE FOUNDATION PACKAGE ARCHIVE>
  ```
  For example,
  ```bash
  openssl dgst -sha256 -verify mfponprem.pub -signature IBM-MobileFoundation-Enterprise-Pak-2.0.0.tar.gz.sig IBM-MobileFoundation-Enterprise-Pak-2.0.0.tar.gz
  ```  
