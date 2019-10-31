---
layout: tutorial
breadcrumb_title: Validating Mobile Foundation archive from PPA
title: パスポート・アドバンテージ・アーカイブからダウンロードした IBM Mobile Foundation アーカイブの検証
weight: 5
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
### パスポート・アドバンテージ・アーカイブからダウンロードした IBM Mobile Foundation アーカイブの検証 (オプション)

パスポート・アドバンテージで入手できる Red Hat OpenShift Container Platform 用の IBM Mobile Foundation パッケージでは、パッケージの整合性を強化するために (Digi Cert により) コードに署名されています。Red Hat OpenShift Container Platform 上の IBM MobileFirst Platform Server の IBM MobileFirst Platform Foundation V8.0 .tar.gz ファイルとともに、`.sig` (署名ファイル) および `.pub` (RSA 公開鍵) ファイルがパスポート・アドバンテージに公開されています。お客様は、以下のように署名を検証することで、パッケージの整合性を確認できます。

#### パスポート・アドバンテージで入手できるパッケージ情報

**パッケージ**: Red Hat OpenShift Container Platform 上の IBM MobileFirst Platform Server の IBM MobileFirst Platform Foundation V8.0 .tar.gz ファイル (英語)(例: eImage パーツ番号: CC3FDEN)

**署名ファイル**: Red Hat OpenShift Container Platform 上の IBM MobileFirst Platform Server の IBM MobileFirst Platform Foundation V8.0 .tar.gz ファイルの署名ファイル (英語)(例: eImage パーツ番号: CC3FEEN)

**RSA 公開鍵**: Red Hat OpenShift Container Platform 上の IBM MobileFirst Platform Server の IBM MobileFirst Platform Foundation V8.0 .tar.gz ファイルの公開鍵ファイル (英語)(eImage パーツ番号: CC3FFEN)

#### 署名を検証する手順

* [openssl](https://www.openssl.org): openssl ツールキットをダウンロードし、インストールします。
* その後、以下のコマンドを使用して IBM Mobile Foundation パッケージを検証します。

  ```bash
  openssl dgst -sha256 -verify <PUBLIC_KEY> -signature <SIGNATURE_FILE> <IBM MOBILE FOUNDATION PACKAGE ARCHIVE>
  ```
  以下に例を示します。

  ```bash
  openssl dgst -sha256 -verify CC3FFEN.pub -signature CC3FEEN.sig CC3FDEN.tar.gz
  ```  
