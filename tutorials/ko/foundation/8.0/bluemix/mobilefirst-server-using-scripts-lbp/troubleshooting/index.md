---
layout: tutorial
title: 문제점 해결
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Liberty for Java 런타임에서 {{site.data.keys.product_full }}에 대한 문제점 해결	
{: resolving-problems-with-ibm-mobilefirst-foundation-on-liberty-for-java-runtime }
Liberty for Java 런타임에서 IBM MobileFirst Foundation에 대한 작업 중에 발견된 문제점을 해결할 수 없는 경우 IBM 지원 센터에 문의하기 전에 다음 주요 정보를 수집하십시오. 

문제점 해결 프로세스를 수행하는 데 도움이 되도록 다음 정보를 수집하십시오. 

* 사용 중인 IBM MobileFirst Foundation의 버전(V8.0.0 이상이어야 함)과 적용된 임시 수정사항
* 선택한 Liberty for Java 런타임 크기. 예: 2GB
* Bluemix dashDB 데이터베이스 플랜 유형. 예: EnterpriseTransactional 2.8.500.
* mfpconsole 경로
* Cloud Foundry의 버전: `cf -v` 
* MobileFirst Foundation 서버가 배치된 조직과 공간에서 다음 Cloud Foundry CLI 명령을 실행하여 리턴된 정보
 - `cf app APP_NAME`

### mfpfsqldb.xml 파일을 작성할 수 없음
{: #unable-to-create-the-mfpfsqldbxml-file }
**prepareserverdbs.sh** 스크립트 실행 종료 시 오류가 발생합니다. 

> 오류: mfpfsqldb.xml을 작성할 수 없음

**해결 방법**  
이 문제점은 중간 데이터베이스 연결 문제일 수 있습니다. 스크립트를 다시 실행하십시오. 

### 스크립트가 실패하고 토큰에 대한 메시지를 리턴함	
{: #script-fails-and-returns-message-about-tokens }
스크립트 실행에 실패하고 cf 토큰 새로 고치기 또는 토큰 새로 고치기 실패 같은 메시지가 리턴됩니다. 

**설명**  
Bluemix 세션의 제한시간이 초과되었을 수 있습니다. Bluemix에 로그인한 후 스크립트를 실행해야 합니다. 

**해결 방법**
initenv.sh 스크립트를 다시 실행하여 Bluemix에 로그인한 후 실패한 스크립트를 다시 실행하십시오. 

### 관리 DB, 활성 업데이트, 푸시 서비스가 비활성으로 표시됨	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
**prepareserver.sh** 스크립트가 정상적으로 완료된 경우에도 관리 DB, 활성 업데이트, 푸시 서비스가 비활성으로 표시되거나 런타임이 MobileFirst Foundation Operations Console에 나열되지 않습니다. 

**설명**  
데이터베이스 서비스에 대한 연결이 설정되지 않았거나 배치 중에 추가 값이 추가되었을 때 server.env 파일에서 형식화 문제가 발생했을 가능성이 있습니다. 

줄 바꾸기 문자 없이 server.env 파일에 값이 추가된 경우 특성을 분석할 수 없습니다. 다음 오류와 유사하게 표시되는 분석되지 않은 특성으로 인해 발생한 오류에 대해 로그 파일을 확인하여 이와 같은 잠재적인 문제점의 유효성을 검증할 수 있습니다. 

> FWLSE0320E: 관리 서비스 준비 여부를 확인하는 데 실패했습니다. 원인: [프로젝트 샘플] java.net.MalformedURLException: 잘못된 호스트: "${env.IP_ADDRESS}"

**해결 방법**  
Liberty 앱을 수동으로 다시 시작하십시오. 문제가 지속되면 데이터베이스 서비스에 대한 연결 횟수가 데이터베이스 플랜에서 프로비저닝하는 연결 횟수를 초과하는지 확인하십시오. 횟수를 초과하는 경우 진행하기 전에 필요한 조정을 수행하십시오. 

분석되지 않은 특성으로 인해 문제가 발생한 경우 제공된 파일을 편집할 때 행 끝을 구별하도록 편집기에서 줄 바꾸기(LF) 문자를 추가하는지 확인하십시오. 예를 들어, macOS의 TextEdit 앱에서는 LF 대신 CR 문자를 사용해 행의 끝을 표시하여 문제가 발생합니다. 

