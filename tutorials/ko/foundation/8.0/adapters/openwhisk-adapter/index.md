---
layout: tutorial
title: Cloud Functions 어댑터
breadcrumb_title: Cloud Functions adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

> OpenWhisk는 이제 Cloud Functions라고 합니다.

IBM Cloud Functions는 서버를 사용하지 않고 확장 가능한 환경에서 코드를 실행할 수 있는 FaaS(Function-as-a-Service) 플랫폼입니다. Cloud Functions 플랫폼의 유스 케이스 중 하나가 서버를 사용하지 않는 모바일 백엔드 코드를 개발하고 실행하는 것입니다. IBM Cloud의 Cloud Functions에 대해 자세히 알아보려면 [여기](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south)를 클릭하십시오. 

{{ site.data.keys.product }} 어댑터는 필요한 서버 측 논리를 수행하고 백엔드 시스템에서 클라이언트 애플리케이션과 클라우드 서비스로 정보를 전송 및 검색하는 데 사용됩니다. {{ site.data.keys.product }}은 이제 Cloud Functions용 어댑터를 제공합니다.

##  Cloud Functions 어댑터
{: #cloud-functions-adapter}

{{ site.data.keys.product_full }}은 [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/)부터 Cloud Functions 어댑터를 제공합니다. Mobile Foundation 콘솔의 **Download Center**에서 이 어댑터를 다운로드하고 배치할 수 있습니다.

어댑터를 다운로드하고 배치한 후 Cloud Functions에 연결하도록 어댑터를 구성해야 합니다.

### Cloud Functions에 연결하도록 어댑터 구성
{: configure-adapter-connect-cloud-functions}

Cloud Functions에 연결하도록 어댑터를 구성하려면 **어댑터 구성** 페이지로 이동하여 Cloud Functions의 인증 키로부터 _**사용자 이름**_ 및 _**비밀번호**_를 제공하십시오. 다음 CLI 명령을 실행하여 Cloud Functions의 _**사용자 이름 **_ 및 _**비밀번호**_를 얻을 수 있습니다.

```bash
./wsk property get --auth KEY
```

위의 명령은 쉼표로 구분된 인증 키를 리턴합니다. 쉼표의 왼쪽에는 _**사용자 이름**_이 있고 쉼표의 오른쪽에는 _**비밀번호**_가 있습니다.

_**사용자 이름:비밀번호**_

위의 방법으로 얻은 _**사용자 이름**_ 및 _**비밀번호**_는 Cloud Functions 어댑터 구성 페이지에 제공되어야 하며 구성을 저장해야 합니다. 이제 클라이언트 앱은 어댑터 API를 호출(call)하여 Cloud Functions 백엔드 코드를 호출(invoke)할 수 있습니다.

>Cloud Functions 어댑터를 수정하기 위해 이 [Github Repo](https://github.com/mfpdev/mfp-extension-adapters)에서 어댑터 소스 코드를 다운로드할 수 있습니다.
