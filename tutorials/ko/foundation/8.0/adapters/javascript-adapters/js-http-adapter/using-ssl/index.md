---
layout: tutorial
title: JavaScript HTTP 어댑터에서 SSL 사용
breadcrumb_title: SSL 사용
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
백엔드 서비스에 연결하기 위해 단순 및 상호 인증과 함께 HTTP 어댑터에서 SSL을 사용할 수 있습니다.   
SSL은 전송 레벨 보안으로, 기본 인증과 독립적으로 작동합니다. HTTP 또는 HTTPS를 통해 기본 인증을 수행할 수 있습니다.

1. adapter.xml 파일에서 HTTP 어댑터의 URL 프로토콜을 <b>https</b>로 설정하십시오. 
2. SSL 인증서를 {{ site.data.keys.mf_server }} 키 저장소에 저장하십시오. [{{ site.data.keys.mf_server }} 키 저장소 구성](../../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오.

### 상호 인증과 함께 SSL 사용
{:# ssl-with-mutual-authentication }

상호 인증과 함께 SSL을 사용하는 경우, 다음과 같은 추가 단계도 수행해야 합니다. 

1. HTTP 어댑터에 대해 사용자 고유의 개인 키를 생성하거나 신뢰할 수 있는 기관에서 제공된 키를 사용하십시오. 
2. 사용자 고유의 개인 키를 생성한 경우, 생성된 개인 키의 공용 인증서를 내보내고 이 인증서를 백엔드 신뢰 저장소로 가져오십시오. 
3. 개인 키의 별명 및 비밀번호를 **adapter.xml** 파일의 `connectionPolicy` 요소에 정의하십시오.  
