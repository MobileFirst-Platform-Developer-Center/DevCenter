---
layout: tutorial
title: 어댑터 자동 생성
breadcrumb_title: 어댑터 자동 생성
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.product }} 어댑터는 필요한 서버 측 논리를 수행하고 백엔드 시스템에서 클라이언트 애플리케이션과 클라우드 서비스로 정보를 전송 및 검색하는 데 사용됩니다. 

##  해당 OpenAPI 스펙에서 어댑터 생성
{: #generate-adapter-openapi-spec}

해당 OpenAPI 스펙(Swagger 스펙)에서 어댑터의 자동 생성은 애플리케이션 개발을 신속하게 수행하는 데 유용합니다. {{ site.data.keys.product }} 사용자는 이제 {{ site.data.keys.product }} 어댑터를 작성하는 대신 애플리케이션 논리에 중점을 두어 애플리케이션을 원하는 백엔드 서비스에 연결할 수 있습니다. 

>**참고:** 이 기능은 DevKit에서만 사용할 수 있습니다. 

이 기능을 사용하려면 마이크로서비스(또는 원하는 백엔드 서비스)용 OpenAPI 스펙(.json 또는 .yaml)이 사용 가능해야 합니다. 어댑터 생성 기능은 **마이크로서비스 커넥터**(**마이크로서비스 어댑터 생성기**라고도 함)라는 확장 어댑터를 통해 사용 가능하며 {{ site.data.keys.product }} 콘솔의 **Download Center**에서 다운로드할 수 있습니다. 

>**참고:** 전제조건으로, 설치된 JDK 폴더를 지정하도록 JAVA_HOME 변수를 구성하십시오. 


  ![Download Center의 어댑터 생성 이미지](./AdapterGen_DownloadCenter.png)


**마이크로서비스 어댑터 생성기** 어댑터를 다운로드하여 {{ site.data.keys.product }} 서버에 배치하십시오. 다운로드된 어댑터는 이제 탐색 분할창의 **확장기능** 아래에 나열됩니다. 


  ![탐색 분할창의 어댑터 생성 이미지](./AdapterGen_naviagtionPane.png)


**마이크로서비스 어댑터 생성기**를 클릭하면 사용자가 OpenAPI 스펙(.json 또는 .yaml) 파일을 제공할 수 있고 제공된 OpenAPI 스펙에서 어댑터를 생성하도록 선택할 수 있는 페이지가 실행됩니다. 

  ![어댑터 생성기 페이지 이미지](./AdapterGen_generationPage.png)


어댑터가 생성되면 브라우저에 자동으로 다운로드됩니다. 그런 다음 사용자는 앱에서 사용할 수 있도록 생성된 어댑터를 배치해야 합니다. **어댑터 소스 포함** 옵션을 선택하면 어댑터 소스 코드 및 생성된 어댑터가 zip 파일로 다운로드됩니다. 사용자는 생성된 어댑터 소스 코드를 수정하고 어댑터를 다시 빌드한 다음 배치할 수 있습니다.

어댑터 생성기는 OpenAPI 스펙 JSON의 정확성에 따라 달라집니다. 스펙이 불안전하거나 올바르지 않은 경우 생성에 실패하거나 백엔드 마이크로서비스의 API와 일치하지 않는 어댑터 API를 생성하게 될 수 있습니다. 

>자세한 내용은 [OpenAPI 스펙에서 마이크로서비스 및 백엔드 시스템의 어댑터 자동 생성](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/10/autogenerate-adapter-from-openapi-specification/) 블로그 게시물을 읽어 보십시오.

