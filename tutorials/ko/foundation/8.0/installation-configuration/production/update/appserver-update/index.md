---
layout: tutorial
title: MobileFirst 서버 업데이트
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM MobileFirst Platform Foundation에서는 사용자가 설치했을 수 있는 몇 가지 컴포넌트를 제공합니다.

다음은 이들을 업데이트하는 종속 항목에 대한 설명입니다.

### MobileFirst Server 관리 서비스, MobileFirst Operations Console 및 MobileFirst 런타임 환경
{: #server-console }

이 세 가지 컴포넌트가 MobileFirst Server로 구성됩니다. 함께 업데이트해야 합니다.

### Application Center
{: #appenter}

이 컴포넌트의 설치는 선택사항입니다. 이 컴포넌트는 다른 컴포넌트와 독립적입니다. 필요한 경우 다른 임시 수정사항 레벨에서 실행될 수 있습니다.

### MobileFirst Operational Analytics
{: #analytics}

이 컴포넌트의 설치는 선택사항입니다. MobileFirst 컴포넌트는 REST API를 통해 MobileFirst Operational Analytics로 데이터를 전송합니다. 임시 수정사항 레벨이 동일한 MobileFirst Server의 다른 컴포넌트와 함께 MobileFirst Operational Analytics를 실행하는 것이 바람직합니다.


## MobileFirst Server 관리 서비스, MobileFirst Operations Console 및 MobileFirst 런타임 환경 업데이트
{: #updating-server}

두 가지 방법으로 이 컴포넌트를 업데이트할 수 있습니다.
* Server Configuration Tool 사용
* Ant 태스크 사용

업데이트 프로시저는 초기 설치 시 사용한 방법에 따라 다릅니다.

> **참고:** Installation Manager(IM)는 업데이트/iFix의 롤백을 지원하지 않습니다. 그러나 예전 war 파일이 있는 경우 Ant 또는 Server Configuration Tool를 사용하여 롤백할 수 있습니다.

### Server Configuration Tool을 사용하여 수정팩 적용
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
구성 도구를 사용하여 {{ site.data.keys.mf_server }}를 설치할 때 구성 파일이 보존되는 경우 구성 파일을 재사용하여 임시 수정사항 또는 수정팩을 적용할 수 있습니다.

1. Server Configuration Tool을 시작하십시오.
    * Linux의 경우 애플리케이션 바로 가기 **애플리케이션 → IBM MobileFirst Platform Server → Server Configuration Tool**에서
    * Windows의 경우 **시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool**을 클릭하십시오.
    * macOS의 경우 쉘 콘솔을 여십시오. **mfp\_server\_install_dir/shortcuts**로 이동하여 **./configuration-tool.sh**를 입력하십시오.
    * **mfp\_server\_install\_dir** 디렉토리는 {{ site.data.keys.mf_server }}를 설치한 디렉토리입니다.

2. **구성 → 배치된 WAR 파일 바꾸기**를 클릭한 후 기존 구성을 선택하여 수정팩 또는 임시 수정사항을 적용하십시오.


### Ant 파일을 사용하여 수정팩 적용
{: #applying-a-fix-pack-by-using-the-ant-files }

#### 샘플 Ant 파일로 업데이트
{: #updating-with-the-sample-ant-file }
**mfp\_install\_dir/MobileFirstServer/configuration-samples** 디렉토리에 제공된 샘플 Ant 파일을 사용하여 {{ site.data.keys.mf_server }}를 설치하는 경우 이 Ant 파일의 사본을 재사용하여 수정팩을 적용할 수 있습니다. 비밀번호 값에 대해 Ant 파일이 실행될 때 대화식으로 프롬프트에 표시될 12개의 별표(\*)를 실제 값 대신 입력할 수 있습니다.

1. Ant 파일에서 **mfp.server.install.dir** 특성의 값을 확인하십시오. 이 값은 수정팩이 적용된 제품이 포함된 디렉토리를 가리켜야 합니다. 이 값은 업데이트된 {{ site.data.keys.mf_server }} WAR 파일을 가져오는 데 사용됩니다.
2. `mfp_install_dir/shortcuts/ant -f your_ant_file update` 명령을 실행하십시오.

#### 자체 Ant 파일로 업데이트
{: #updating-with-own-ant-file }
자체 Ant 파일을 사용하는 경우 각각의 설치 태스크(**installmobilefirstadmin**, **installmobilefirstruntime** 및 **installmobilefirstpush**)에 대해 Ant 파일에 동일한 매개변수를 가진 해당 업데이트 태스크가 있는지 확인하십시오. 해당 업데이트 태스크는 **updatemobilefirstadmin**, **updatemobilefirstruntime** 및 **updatemobilefirstpush**입니다.

1. **mfp-ant-deployer.jar** 파일에 대한 **taskdef** 요소의 클래스 경로를 확인하십시오. 이 경로는 수정팩이 적용되는 {{ site.data.keys.mf_server }} 설치의 **mfp-ant-deployer.jar** 파일을 가리켜야 합니다. 기본적으로 업데이트된 {{ site.data.keys.mf_server }} WAR 파일은 **mfp-ant-deployer.jar**의 위치에서 가져옵니다.
2. Ant 파일의 업데이트 태스크(**updatemobilefirstadmin**, **updatemobilefirstruntime** 및 **updatemobilefirstpush**)를 실행하십시오.
