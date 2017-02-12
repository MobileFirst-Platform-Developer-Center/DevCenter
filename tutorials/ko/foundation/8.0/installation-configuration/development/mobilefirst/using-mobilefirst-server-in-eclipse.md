---
layout: tutorial
title: Eclipse에 MobileFirst Server 사용
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server }}를 Eclipse IDE에 통합할 수 있습니다. 이는 통합 개발 경험을 작성하는 데 도움이 될 수 있습니다. 

* Eclipse에서 CLI 기능을 노출할 수도 있습니다. [Eclipse에서 {{ site.data.keys.mf_server }} 사용](../../../../application-development/using-mobilefirst-cli-in-eclipse) 학습서를 참조하십시오. 
* 또한 Eclipse에서 어댑터를 개발할 수 있습니다. [Eclipse에서 어댑터 개발](../../../../adapters/developing-adapters) 학습서를 참조하십시오. 

### Eclipse에 서버 추가
{: #adding-the-server-to-eclipse }
1. Eclipse의 **서버** 보기에서 **새로 작성 → 서버**를 선택하십시오. 
2. IBM 폴더 옵션이 없으면 "추가적인 서버 어댑터 다운로드"를 클릭하십시오. 
3. **WebSphere Application Server Liberty 도구**를 선택한 후 화면 지시사항을 따르십시오. 
4. Eclipse의 **서버** 보기에서 **새로 작성 → 서버**를 선택하십시오. 
5. **IBM → WebSphere Application Server Liberty**를 선택하십시오. 
6. 서버 **이름** 및 **호스트 이름**을 제공한 후 **다음**을 클릭하십시오. 
7. 서버 루트 디렉토리의 경로를 제공한 후 사용할 JRE 버전을 선택하십시오. {{ site.data.keys.mf_dev_kit }} 사용 시 루트 디렉토리는 **[installation directory]/mfp-server** 폴더입니다. 
8. **다음**을 클릭한 후 **완료**를 클릭하십시오. 

이제 Eclipse IDE "서버" 보기에서 {{ site.data.keys.mf_server }}를 시작하고 중지할 수 있습니다. 
