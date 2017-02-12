---
layout: tutorial
title: Eclipse에서 어댑터 개발
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

앞의 [어댑터 학습서](../)에서 학습한 것처럼 어댑터는 Maven을 직접 사용하거나 {{ site.data.keys.mf_cli }}를 통해 작성된 Maven 프로젝트입니다. 그런 다음 어댑터 코드는 IDE에서 편집될 수 있고 나중에 Maven 또는 {{ site.data.keys.mf_cli }}를 사용하여 빌드 및 배치될 수 있습니다. 개발자는 또한 Eclipse 또는 IntelliJ와 같은 지원되는 IDE 내에서 모두 작성, 개발, 빌드, 배치를 선택할 수 있습니다. 이 학습서에서 어댑터가 Eclipse IDE에서 작성 및 빌드됩니다. 

> IntelliJ를 사용하는 방법에 대한 지시사항은 [MobileFirst Java 어댑터 개발을 위해 IntelliJ 사용]({{site.baseurl}}/blog/2016/03/31/using-intellij-to-develop-adapters) 블로그 게시물을 참조하십시오.
**전제조건:**

* 먼저 [어댑터 학습서](../)를 읽어 어댑터에 익숙해질 것. 
* Eclipse에서 Maven 통합. Eclipse Kepler (v4.3) 시작, Maven 지원은 Eclipse에서 기본 제공됩니다. Eclipse 인스턴스가 Maven을 지원하지 않으면, [m2e 지침에 따라](http://www.eclipse.org/m2e/) Maven 지원을 추가하십시오.

#### 다음으로 이동
{: #jump-to }

* [새 어댑터 Maven 프로젝트 작성](#creating-a-new-adapter-maven-project)
* [기존 어댑터 Maven 프로젝트 가져오기](#importing-an-existing-adapter-maven-project)
* [어댑터 Maven 프로젝트 빌드 및 배치](#building-and-deploying-an-adapter-maven-project)
* [추가 정보](#further-reading)

## 어댑터 Maven 프로젝트 작성 또는 가져오기
{: #create-or-import-an-adapter-maven-project }

아래 지시사항에 따라 새 어댑터 Maven 프로젝트를 작성하거나 기존 프로젝트를 가져오십시오.

### 새 어댑터 Maven 프로젝트 작성
{: #creating-a-new-adapter-maven-project }

1. 새 어댑터 Maven 프로젝트를 작성하려면 **파일 → 새로 작성 → 기타... → Maven → Maven 프로젝트**를 선택하고 **다음**을 클릭하십시오.

    ![어댑터 Maven 프로젝트를 Eclipse에서 작성하는 방법을 보여주는 이미지](new-maven-project.png)

2. 프로젝트 이름 및 위치를 제공하십시오.   
    - 단순 프로젝트 작성을 위한 옵션이 **꺼짐**으로 되어 있는지 확인한 후 **다음**을 클릭하십시오. 

    ![어댑터 Maven 프로젝트를 Eclipse에서 작성하는 방법을 보여주는 이미지](select-project-name-and-location.png)

3. 어댑터 아키타입을 선택하거나 추가하십시오. 
    - [아키타입을 로컬로 설치](../creating-adapters/#install-maven)했으나 아키타입 목록에 표시되지 않는 경우**구성 → 로컬 카탈로그 추가 → 홈 디렉토리의 /.m2/repository/archetype-catalog.xml로 이동**을 선택하십시오.
    - **아키타입 추가**를 클릭하고 다음 세부사항을 제공하십시오.
        - **아키타입 그룹 ID**: `com.ibm.mfp`
        - **아키타입 아티팩트 ID**: `adapter-maven-archetype-java`, `adapter-maven-archetype-http` 또는 `adapter-maven-archetype-sql`
        - **아키타입 버전**: `8.0.2016061011` ([Maven Central](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation)에서 사용 가능한 최신 버전을 찾을 수 있음)

    ![어댑터 Maven 프로젝트를 Eclipse에서 작성하는 방법을 보여주는 이미지](create-an-archetype.png)

4. Maven 프로젝트 매개변수를 지정하십시오.   
    - 필수 **그룹 ID**, **아티팩트 ID**, **버전** 및 **패키지** 매개변수를 지정하고 **완료**를 클릭하십시오. 

    ![어댑터 Maven 프로젝트를 Eclipse에서 작성하는 방법을 보여주는 이미지](project-parameters.png)

### 기존 어댑터 Maven 프로젝트 가져오기
{: #importing-an-existing-adapter-maven-project }

어댑터 Maven 프로젝트를 가져오려면 **파일 → 가져오기... → Maven → 기존 Maven 프로젝트**를 선택하십시오.

![어댑터 Maven 프로젝트를 Eclipse로 가져오는 방법을 보여주는 이미지](import-adapter-maven-project.png)

## 어댑터 Maven 프로젝트 빌드 및 배치
{: #building-and-deploying-an-adapter-maven-project }

어댑터 프로젝트는 Maven 명령행 명령, {{ site.data.keys.mf_cli }} 또는  Eclipse를 통해 빌드 및 배치될 수 있습니다.   
[어댑터를 빌드하고 배치하는 방법을 학습하십시오](../creating-adapters/#build-and-deploy-adapters).

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** Eclipse는 플러그인을 사용하여 **명령행** 창을 통합함으로써 일관된 개발 환경을 작성하여 배치 단계를 용이하게 하도록 강화될 수도 있습니다. 이 창에서 Maven 또는 {{ site.data.keys.mf_cli }} 명령을 실행할 수 있습니다. ### 어댑터 빌드
{: #building-an-adapter }

어댑터를 빌드하려면 어댑터 폴더를 마우스 오른쪽 단추로 클릭하고 **실행 도구 → Maven 설치**를 선택하십시오.   

### 어댑터 배치
{: #deploying-an-adapter }

어댑터를 배치하려면 먼저 배치 Maven 명령을 추가하십시오. 

1. **실행 → 구성 실행...**을 선택하고, **Maven 빌드**를 마우스 오른쪽 단추로 클릭한 다음 **새로 작성**을 선택하십시오. 
2. "Maven 배치"로 이름을 지정하십시오.
2. 목표를 "adapter:deploy"로 설정하십시오.
3. **적용**을 클릭한 후 **실행**을 클릭하여 초기 배치를 실행하십시오.

이제 어댑터 폴더를 마우스 오른쪽 단추로 클릭하고 **실행 도구 → Maven 배치**를 선택할 수 있습니다. 

### 어댑터 빌드 및 배치
{: #building-and-deploying-an-adapter }

또한 "빌드" 및 "배치" Maven 목표를 단일 "빌드 및 배치" 목표로 결합할 수 있습니다. "clean install adapter:deploy"

## 추가 정보
{: #further-reading }

[어댑터 테스트 및 디버깅](../testing-and-debugging-adapters) 학습서에서 어댑터의 Java 코드 디버깅 방법을 학습하십시오. 
