---
layout: tutorial
breadcrumb_title: Validating Mobile Foundation archive from PPA
title: Passport Advantage 아카이브에서 다운로드한 IBM Mobile Foundation 아카이브 유효성 검증
weight: 5
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
### Passport Advantage 아카이브에서 다운로드한 IBM Mobile Foundation 아카이브 유효성 검증(선택사항)

Passport Advantage에서 사용 가능한 Red Hat OpenShift Container Platform용 IBM Mobile Foundation 패키지는 패키지 무결성을 보장하기 위해 디지털인증서로 코드 서명됩니다. `.sig`(서명 파일) 및 `.pub`(RSA 공개 키) 파일은 Red Hat OpenShift Container Platform에서 IBM MobileFirst Platform Server의 IBM MobileFirst Platform Foundation V8.0 .tar.gz 파일과 함께 Passport Advantage로 발송됩니다. 고객은 아래와 같이 서명을 확인하여 패키지 무결성의 유효성을 검증할 수 있습니다.

#### Passport Advantage에서 사용할 수 있는 패키지 정보

**패키지**: Red Hat OpenShift Container Platform에서 IBM MobileFirst Platform Server의 IBM MobileFirst Platform Foundation V8.0 .tar.gz 파일(영어)(예: eImage 부품 번호: CC3FDEN)

**서명 파일**: Red Hat OpenShift Container Platform에서 IBM MobileFirst Platform Server의 IBM MobileFirst Platform Foundation V8.0 .tar.gz 파일에 대한 서명 파일(영어)(예: eImage 부품 번호: CC3FEEN)

**RSA 공개 키**: Red Hat OpenShift Container Platform에서 IBM MobileFirst Platform Server의 IBM MobileFirst Platform Foundation V8.0 .tar.gz 파일에 대한 공개 키 파일(영어)(eImage 부품 번호: CC3FFEN)

#### 서명을 확인하는 단계

* [openssl](https://www.openssl.org)로 연결하고 openssl 툴킷을 다운로드 및 설치하십시오.
* 이제 다음 명령을 사용하여 IBM Mobile Foundation 패키지를 확인하십시오.

  ```bash
  openssl dgst -sha256 -verify <PUBLIC_KEY> -signature <SIGNATURE_FILE> <IBM MOBILE FOUNDATION PACKAGE ARCHIVE>
  ```
예를 들어, 다음과 같습니다.

  ```bash
  openssl dgst -sha256 -verify CC3FFEN.pub -signature CC3FEEN.sig CC3FDEN.tar.gz
  ```  
