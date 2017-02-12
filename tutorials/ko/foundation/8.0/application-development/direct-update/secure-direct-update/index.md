---
layout: tutorial
title: 보안 직접 업데이트 구현
breadcrumb_title: 보안 직접 업데이트
relevantTo: [cordova]
weight: 2
---

## 개요
{: #overview }
보안 직접 업데이트가 작동하려면 사용자 정의 키 저장소 파일이 {{ site.data.keys.mf_server }}에 배치되고 일치하는 공개 키의 사본이 배치된 클라이언트 애플리케이션에 포함되어야 합니다. 

이 주제에서는 새 클라이언트 애플리케이션 및 업그레이드된 기존 클라이언트 애플리케이션에 공개 키를 바인드하는 방법에 대해 설명합니다. {{ site.data.keys.mf_server }}에서 키 저장소를 구성하는 데 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 키 저장소 구성](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오. 

서버는 개발 단계(Phase)에 대해 보안 직접 업데이트를 테스트하는 데 사용할 수 있는 기본 제공 키 저장소를 제공합니다. 

**참고:** 클라이언트 애플리케이션에 공개 키를 바인드하고 다시 빌드한 후에는 {{ site.data.keys.mf_server }}에 다시 업로드할 필요가 없습니다. 그러나 이전에 공개 키 없이 애플리케이션을 마켓에 공개한 경우 다시 공개해야 합니다. 

개발 용도로 사용하도록 다음 기본 더미 공개 키가 {{ site.data.keys.mf_server }}와 함께 제공됩니다. 

```xml
-----BEGIN PUBLIC KEY-----
MIIDPjCCAiagAwIBAgIEUD3/bjANBgkqhkiG9w0BAQsFADBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxETA
PBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wgRG
V2MCAXDTEyMDgyOTExMzkyNloYDzQ3NTAwNzI3MTEzOTI2WjBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxE
TAPBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wg
RGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzQN3vEB2/of7KAvuvyoIt0T7cjaSTjnOBm0N3+q
zx++dh92KpNJXj/a3o4YbwJXkJ7jU8ykjCYvjXRf0hme+HGhiIVwxJo54iqh76skDS5m7DaseFdndZUJ4p7NFVw
I5ixA36ZArSZ/Pn/ej56/RRjBeRI7AEGXUSGojBUPA6J6DYkwaXQRew9l+Q1kj4dTigyKL5Os0vNFaQyYu+bT2E
vnOixQ0DXm94IqmHZamZKbZLrWcOEfuAsSjKYOdMSM9jkCiHaKcj7fpEZhUxRRs7joKs1Ri4ihs6JeUvMEiG4gK
l9V3FP/Huy0pfkL0F8xMHgaQ4c/lxS/s3PV0OEg+7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgEhhqRl2Rgkt
MJeqOCRcT3uyr4XDK3hmuhEaE0nOvLHi61PoLKnDUNryWUicK/W+tUP9jkN5xRckdzG6TJ/HPySmZ7Adr6QRFu+
xcIMY+/S8j4PHLXBjoqgtUMhkt7S2/thN/VA6mwZpw4Ol0Pa2hyT2TkhQoYYkRwYCk9pxmuBCoH/eCWpSxquNny
RwrY25x0YzccXUaMI8L3/3hzq3mW40YIMiEdpiD5HqjUDpzN1funHNQdsxEIMYsWmGAwOdV5slFzyrH+ErUYUFA
pdGIdLtkrhzbqHFwXE0v3dt+lnLf21wRPIqYHaEu+EB/A4dLO6hm+IjBeu/No7H7TBFm
-----END PUBLIC KEY-----
```

> 중요: 프로덕션 용도로 공개 키를 사용하지 마십시오. 

## 키 저장소 생성 및 배치
{: #generating-and-deploying-the-keystore }
키 저장소에서 인증서를 생성하고 공개 키를 추출하는 데 사용 가능한 여러 가지 도구가 있습니다. 다음 예제는 JDK keytool 유틸리티 및 openSSL을 사용하는 프로시저를 설명합니다. 

1. {{ site.data.keys.mf_server }}에 배치된 키 저장소 파일에서 공개 키를 추출하십시오.
     
참고: 공개 키는 Base64로 인코딩되어야 합니다. 
    
   예를 들어 별명이 `mfp-server`이고 키 저장소 파일이 **keystore.jks**라고 가정하십시오.   
   인증서를 생성하려면 다음 명령을 실행하십시오. 
    
   ```bash
   keytool -export -alias mfp-server -file certfile.cert
   -keystore keystore.jks -storepass keypassword
   ```
    
   인증서 파일이 생성됩니다.   
   다음 명령을 실행하여 공개 키를 추출하십시오. 
    
   ```bash
   openssl x509 -inform der -in certfile.cert -pubkey -noout
   ```
    
   **참고:** Keytool만 사용하여 Base64 형식으로 공개 키를 추출할 수는 없습니다. 
    
2. 다음 프로시저 중 하나를 수행하십시오. 
    * 애플리케이션의 mfpclient 특성에 `BEGIN PUBLIC KEY` 및 `END PUBLIC KEY` 마커를 사용하지 말고 `wlSecureDirectUpdatePublicKey` 바로 뒤에 결과 텍스트를 복사하십시오. 
    * 명령 프롬프트에서 `mfpdev app config direct_update_authenticity_public_key <public_key>` 명령을 실행하십시오. 
    
    `<public_key>`의 경우 `BEGIN PUBLIC KEY` 및 `END PUBLIC KEY` 마커 없이 1단계의 결과 텍스트를 붙여넣으십시오. 

3. cordova build 명령을 실행하여 애플리케이션에 공개 키를 저장하십시오. 


