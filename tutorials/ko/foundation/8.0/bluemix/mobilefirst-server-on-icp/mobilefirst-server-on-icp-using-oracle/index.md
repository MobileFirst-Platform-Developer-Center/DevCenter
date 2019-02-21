---
layout: tutorial
title: IBM Cloud Private에서 Oracle 데이터베이스를 사용하는 Mobile Foundation 설정
breadcrumb_title: Foundation with Oracle DB on ICP
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview}

바로 사용이 가능한 IBM Mobile Foundation - ICP PPA 패키지는 IBM DB2 서버의 사용을 지원합니다. 이 학습서는 Mobile Foundation 데이터를 저장할 때 원격 Oracle 데이터를 사용할 수 있도록 ICP(IBM Cloud Private)에 배치된 Mobile Foundation을 확장하는 데 중점을 둡니다. 

## 가정
{: #assumption }
이 학습서를 진행하기 전에 다음과 같이 가정합니다. 

* 이미 IBM Cloud Private을 설정했고 ICP에 IBM Mobile Foundation Passport Advantage 아카이브를 로드했습니다. 
* 원격 Oracle 데이터베이스에 수동으로 작성된 Mobile Foundation 데이터베이스 테이블을 설정하고([다운로드]((customizable-db-artifacts-for-mfp-icp.zip)) 및 Mobile Foundation 서버에 대한 Oracle 데이터베이스의 db 스크립트를 참조합니다. 
* IBM Cloud Private CLI 도구가 로컬 컴퓨터(`bx pr`, `docker`, `kube` 또는 `cloudctl` 등)에 설치되어 있습니다. 

>**참고:** DB2 데이터베이스의 helm 배치 동안 테이블이 자동으로 작성됩니다. Oracle, PostgreSQL 또는 MySQL의 경우 helm 차트를 배치하기 전에 테이블을 수동으로 작성해야 합니다. 

## 사용자 정의가 필요한 아티팩트
{: #artifacts-to-be-customized }

Mobile Foundation 서버의 Docker 이미지에는 Oracle DB 지원을 이용하기 위해 사용자 정의해야 하는 특정 아티팩트가 있습니다. 다음은 Oracle 관련 아티팩트와 구성으로 작성된 컨테이너를 포함하기 위해 수정되어야 하는 Docker 이미지 내 파일입니다. 
1.	`mfpdbconfig.sh`.
2.	`mfpfsqldb.xml` - Oracle DB 및 관련 데이터 소스를 지원하기 위해 수정됨.
3.	Oracle 클라이언트 JBDC 드라이버 포함
4.	`server.xml` 업데이트

>**참고:** 위 파일 이름은 기본 Docker 이미지를 사용자 정의하기 위해 동일하게 유지됩니다. 


### 프로시저
{: #procedure}

1.	ICP 콘솔 **카탈로그**에서 `ibm-mfpf-*` helm 차트가 로드되었는지 확인하십시오.
2.	첨부 파일(`mfp-icp-oracle.zip`)의 압축을 풀어서 사용할 샘플 `Dockerfile` 및 디렉토리 구조를 보여주는 `Dockerfile` 및 `usr-mfpf-server`를 찾으십시오. 
3.	Docker 이미지가 확장되어야 하는 이미지 버전 수정을 사용할 수 있도록 `Dockerfile`을 수정하십시오. <br/>
     *예:*<br/>
      `FROM mycluster.icp:8500/default/mfpf-server:<a.b.c.d>`<br/>
       *a.b.c.d*는 이미지 레지스트리에서 사용 가능한 이미지 버전입니다. 
4.	Docker 이미지 사용자 정의를 위해 블로그의 지시사항을 따르고 Mobile Foundation 서버 팟(pod)을 작성하십시오. 
5.	Docker 이미지가 위 단계를 통해 확장되면 Mobile Foundation 서버를 위한 Helm 차트를 배치하는 데 ICP 콘솔을 사용할 수 있습니다. 새 이미지가 제공되는지 확인하십시오.  

Docker 이미지 사용자 정의 또는 확장에 대해서는 [IBM Cloud Private(ICP)에 배치된 Mobile Foundation 컴포넌트 사용자 정의 방법](https://mobilefirstplatform.ibmcloud.com/blog/2018/11/04/customize-mfp-on-icp/)을 참조하십시오. 

>**참고:** MySQL 및 PostgreSQL 데이터베이스의 경우 적절한 JDBC 드라이버를 사용해야 합니다. 
