---
layout: tutorial
title: 문제점 해결
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### IBM Containers의 {{ site.data.keys.product_full }}에 대한 문제점 해결	
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
IBM Containers의 {{ site.data.keys.product_full }}에 대한 작업 중에 발견된 문제점을 해결할 수 없는 경우 IBM 지원 센터에 문의하기 전에 다음 주요 정보를 수집하십시오. 

문제점 해결 프로세스를 수행하는 데 도움이 되도록 다음 정보를 수집하십시오. 

* 사용 중인 {{ site.data.keys.product }} 버전(V8.0.0 이상이어야 함)과 적용된 임시 수정사항
* 선택한 컨테이너 크기. 예: 중간 2GB
* Bluemix dashDB 데이터베이스 플랜 유형. 예: EnterpriseTransactional 2.8.50
* 컨테이너 ID
* 공용 IP 주소(지정된 경우)
* Docker와 Cloud Foundry의 버전: `cf -v` 및 `docker version`
* {{ site.data.keys.product }} 컨테이너가 배치된 조직과 공간에서 IBM Containers (cf ic) 명령에 대해 다음 Cloud Foundry CLI 플러그인을 실행하여 리턴된 정보
 - `cf ic info`
 - `cf ic ps -a`(둘 이상의 컨테이너 인스턴스가 나열되는 경우 문제점이 있는 컨테이너 인스턴스를 표시해야 합니다.)
* 컨테이너 작성 중(**startserver.sh** 스크립트 실행 중)에 SSH(Secure Shell)와 볼륨을 사용한 경우 다음 폴더에 있는 모든 파일을 수집하십시오. /opt/ibm/wlp/usr/servers/mfp/logs 및 /var/log/rsyslog/syslog
* 볼륨만 사용하고 SSH는 사용하지 않은 경우에는 Bluemix 대시보드를 사용하여 사용 가능한 로그 정보를 수집하십시오. Bluemix 대시보드에서 컨테이너 인스턴스를 클릭한 후 사이드바에서 모니터링 및 로그 링크를 클릭하십시오. 로깅 탭으로 이동한 후 고급 보기를 클릭하십시오. Kibana 대시보드가 별도로 열립니다. 검색 도구 모음을 사용하여 예외 스택 추적을 검색한 후 @time-stamp, _id 예외의 전체 세부사항을 수집하십시오. 

### 스크립트 실행 중 Docker 관련 오류	
{: #docker-related-error-while-running-script }
initenv.sh 또는 prepareserver.sh 스크립트를 실행한 후 Docker 관련 오류가 발생하면 Docker 서비스를 다시 시작하십시오. 

**메시지 예** 

> 저장소 docker.io/library/ubuntu 가져오는 중  
>이미지를 가져오는 중에 오류가 발생했습니다. Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS 메시지 ID 불일치

**설명**  
이 오류는 인터넷 연결이 변경되고(예: VPN에 연결, VPN에서 연결 끊기 또는 네트워크 구성 변경) Docker 런타임 환경이 아직 다시 시작되지 않은 경우 발생할 수 있습니다. 이 시나리오에서는 Docker 명령이 실행될 때 오류가 발생할 수 있습니다. 

**해결 방법**  
Docker 서비스를 다시 시작하십시오. 오류가 지속되면 컴퓨터를 다시 부팅한 후 Docker 서비스를 다시 시작하십시오. 

### Bluemix 레지스트리 오류	
{: #bluemix-registry-error }
prepareserver.sh 또는 prepareanalytics.sh 스크립트를 실행한 후 레지스트리 관련 오류가 발생하면 initenv.sh 스크립트를 먼저 실행하십시오. 

**설명**  
일반적으로 prepareserver.sh 또는 prepareanalytics.sh 스크립트 실행 중에 네트워크 문제가 발생하면 처리가 정지되고 실패합니다. 

**해결 방법**  
먼저 initenv.sh 스크립트를 다시 실행하여 Bluemix의 컨테이너 레지스트리에 로그인하십시오. 그런 다음 이전에 실패한 스크립트를 다시 실행하십시오. 

### mfpfsqldb.xml 파일을 작성할 수 없음
{: #unable-to-create-the-mfpfsqldbxml-file }
**prepareserverdbs.sh** 스크립트 실행 종료 시 오류가 발생합니다. 

> 오류: mfpfsqldb.xml을 작성할 수 없음

**해결 방법**  
이 문제점은 중간 데이터베이스 연결 문제일 수 있습니다. 스크립트를 다시 실행하십시오. 

### 이미지를 푸시하는 데 시간이 오래 걸림	
{: #taking-a-long-time-to-push-image }
prepareserver.sh 스크립트를 실행할 때 IBM Containers 레지스트리에 이미지를 푸시하는 데 20분이 넘게 걸립니다. 

**설명**  
**prepareserver.sh** 스크립트는 전체 {{ site.data.keys.product }} 스택을 푸시하므로 20 - 60분 정도 걸릴 수 있습니다. 

**해결 방법**  
60분이 경과한 후에도 스크립트가 완료되지 않으면 연결 문제로 인해 프로세스가 정지되었을 수 있습니다. 안정적인 연결이 다시 설정되면 스크립트를 다시 시작하십시오. 

### 바인딩 불완전 오류	
{: #binding-is-incomplete-error }
스크립트(예: **startserver.sh** 또는 **startanalytics.sh**)를 실행하여 컨테이너를 시작할 때 바인딩이 불완전한 오류로 인해 IP 주소를 수동으로 바인드하라는 프롬프트가 표시됩니다. 

**설명**  
이 스크립트는 특정 기간이 경과한 후에 종료되도록 디자인되었습니다. 

**해결 방법**  
관련 cf ic 명령을 실행하여 IP 주소를 수동으로 바인드하십시오. 예를 들면, cf ic ip bind입니다. 

IP 주소를 수동으로 바인드하는 데 실패하는 경우 컨테이너의 상태가 실행 중인지 확인한 후 바인딩을 다시 시도하십시오.   
**참고:** 컨테이너가 실행 중 상태여야 바인드가 완료됩니다. 

### 스크립트가 실패하고 토큰에 대한 메시지를 리턴함	
{: #script-fails-and-returns-message-about-tokens }
스크립트 실행에 실패하고 cf 토큰 새로 고치기 또는 토큰 새로 고치기 실패 같은 메시지가 리턴됩니다. 

**설명**  
Bluemix 세션의 제한시간이 초과되었을 수 있습니다. Bluemix에 로그인한 후 컨테이너 스크립트를 실행해야 합니다. 

**해결 방법**
initenv.sh 스크립트를 다시 실행하여 Bluemix에 로그인한 후 실패한 스크립트를 다시 실행하십시오. 

### 관리 DB, 활성 업데이트, 푸시 서비스가 비활성으로 표시됨	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
**prepareserver.sh** 스크립트가 정상적으로 완료된 경우에도 관리 DB, 활성 업데이트, 푸시 서비스가 비활성으로 표시되거나 런타임이 {{ site.data.keys.mf_console }}에 나열되지 않습니다. 

**설명**  
데이터베이스 서비스에 대한 연결이 설정되지 않았거나 배치 중에 추가 값이 추가되었을 때 server.env 파일에서 형식화 문제가 발생했을 가능성이 있습니다. 

줄 바꾸기 문자 없이 server.env 파일에 값이 추가된 경우 특성을 분석할 수 없습니다. 다음 오류와 유사하게 표시되는 분석되지 않은 특성으로 인해 발생한 오류에 대해 로그 파일을 확인하여 이와 같은 잠재적인 문제점의 유효성을 검증할 수 있습니다. 

> FWLSE0320E: 관리 서비스 준비 여부를 확인하는 데 실패했습니다. 원인: [프로젝트 샘플] java.net.MalformedURLException: 잘못된 호스트: "${env.IP_ADDRESS}"



**해결 방법**  
수동으로 컨테이너를 다시 시작하십시오. 문제가 지속되면 데이터베이스 서비스에 대한 연결 횟수가 데이터베이스 플랜에서 프로비저닝하는 연결 횟수를 초과하는지 확인하십시오. 횟수를 초과하는 경우 진행하기 전에 필요한 조정을 수행하십시오. 

분석되지 않은 특성으로 인해 문제가 발생한 경우 제공된 파일을 편집할 때 행 끝을 구별하도록 편집기에서 줄 바꾸기(LF) 문자를 추가하는지 확인하십시오. 예를 들어, macOS의 TextEdit 앱에서는 LF 대신 CR 문자를 사용해 행의 끝을 표시하여 문제가 발생합니다. 

### prepareserver.sh 스크립트 실패	
{: #prepareserversh-script-fails }
**prepareserver.sh** 스크립트가 실패하고 405 허용되지 않은 메소드 오류를 리턴합니다. 

**설명**  
**prepareserver.sh** 스크립트를 실행하여 IBM Containers 레지스트리에 이미지를 푸시하는 경우 다음 오류가 발생합니다. 

> IBM Containers 레지스트리에 {{ site.data.keys.mf_server }} 이미지를 푸시하는 중..  
> 디먼의 오류 응답:  
> 405 허용되지 않은 메소드  
> 허용되지 않은 메소드  
> 메소드는 요청된 URL에 허용되지 않습니다.

이 오류는 일반적으로 호스트 환경에서 Docker 변수가 수정된 경우에 발생합니다. initenv.sh 스크립트를 실행한 후 도구에서 원시 Docker 명령을 사용하여 IBM Containers에 연결하기 위해 로컬 Docker 환경을 대체할 옵션을 제공합니다. 

**해결 방법**  
IBM Containers 레지스트리 환경을 가리키도록 Docker 변수(예: DOCKER\_HOST, DOCKER\_CERT\_PATH)를 수정하지 마십시오. **prepareserver.sh** 스크립트가 올바로 작동하려면 Docker 변수가 로컬 Docker 환경을 가리켜야 합니다. 
