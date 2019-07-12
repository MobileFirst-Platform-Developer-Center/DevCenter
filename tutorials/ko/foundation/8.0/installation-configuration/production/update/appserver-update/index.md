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

>**참고:** MobileFirst 서버를 업데이트하기 전에 기존 MFP 설치 디렉토리를 백업하는 것이 좋습니다.
> 해당 파일을 백업할 때는 MobileFirst 서버가 중지되었는지 확인하는 것 외에는 특별한 프로시저가 필요하지 않습니다. 해당 서버가 중지되지 않은 경우에는 백업을 수행하는 중에 데이터가 변경되어 메모리에 저장된 데이터가 아직 파일 시스템에 기록되지 않았을 수 있습니다. 데이터 불일치를 방지하려면 백업을 시작하기 전에 MobileFirst 서버를 중지하십시오.
>
MFP는 IBM IM(Installation Manager)을 통한 업데이트/iFix의 롤백을 지원하지 않습니다. 그러나 업데이트 전에 백업되는 MFP 관련 war 파일을 사용하는 SCT(Server Configuration Tool) 또는 ANT 태스크를 사용하여 롤백할 수 있습니다.
>

<!-- **Note:** Installation Manager(IM) does not support rolling back of an update/iFix. However, rollback is possible using Ant or Server Configuration Tool, if you have the old war files. -->

### Server Configuration Tool을 사용하여 수정팩 적용
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
구성 도구를 사용하여 {{ site.data.keys.mf_server }}를 설치할 때 구성 파일이 보존되는 경우 구성 파일을 재사용하여 임시 수정사항 또는 수정팩을 적용할 수 있습니다.

1. Server Configuration Tool을 시작하십시오.
    * Linux의 경우 애플리케이션 바로 가기 **애플리케이션 → IBM MobileFirst Platform Server → Server Configuration Tool**에서
    * Windows의 경우 **시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool**을 클릭하십시오.
    * macOS의 경우 쉘 콘솔을 여십시오. **mfp\_server\_install_dir/shortcuts**로 이동하여 **./configuration-tool.sh**를 입력하십시오.
    * **mfp\_server\_install\_dir** 디렉토리는 {{ site.data.keys.mf_server }}를 설치한 디렉토리입니다.

2. **구성 → 배치된 WAR 파일 바꾸기**를 클릭한 후 기존 구성을 선택하여 수정팩 또는 임시 수정사항을 적용하십시오.

### Server Configuration Tool을 사용하여 수정팩 롤백
{: #rollback-a-fix-pack-by-using-the-server-configuration-tool }

MobileFirst 서버가 Server Configuration Tool을 사용하여 설치되고 구성 파일이 보존되는 경우 구성 파일을 재사용하여 수정팩 또는 임시 수정사항을 롤백할 수 있습니다.

1.  Server Configuration Tool을 시작하십시오.
    * MFP 설치 디렉토리(`mfp_server_install_dir/MobileFirstServer`)의 백업된 위치에서 복사하여 MFP 관련 war 파일을 수동으로 대체하십시오.
    * Linux의 경우 애플리케이션 바로 가기 **애플리케이션 → IBM MobileFirst Platform Server → Server Configuration Tool**에서
    * Windows의 경우 **시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool**을 클릭하십시오.
    * MacOS에서 쉘 콘솔을 여십시오. `mfp_server_install_dir/shortcuts로 이동하고 ./configuration-tool.sh`를 입력하십시오.
    * `mfp_server_install_dir` 디렉토리는 MobileFirst 서버를 설치한 위치입니다.

2.  롤백해야 하는 구성을 선택하십시오. **구성**을 클릭하고 옵션 - **구성 편집 및 재배치**를 선택하십시오.

3.  각 페이지에서 **다음**을 클릭하고 끝까지 순회한 다음 **업데이트**를 클릭하십시오.


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

### Ant 파일을 사용하여 수정팩을 롤백하십시오.
{: #rollback-a-fix-pack-by-using-the-ant-files }

#### 샘플 Ant 파일로 롤백
{: #rollback-with-the-sample-ant-file }

`mfp_install_dir/MobileFirstServer/configuration-samples` 디렉토리에서 제공되는 샘플 Ant 파일을 사용하여 MobileFirst 서버를 설치하는 경우 이 Ant 파일의 사본을 재사용하여 수정팩을 롤백할 수 있습니다. 비밀번호 값에 대해 Ant 파일이 실행될 때 대화식으로 프롬프트에 표시될 12개의 별표(`*`)를 실제 값 대신 입력할 수 있습니다.

1.  MFP 설치 디렉토리(`mfp_server_install_dir/MobileFirstServer`)의 백업된 위치에서 복사하여 MFP 관련 war 파일을 수동으로 대체하십시오.
2.  Ant 파일에서 **mfp.server.install.dir** 특성의 값을 확인하십시오. 이 값은 업데이트된 MobileFirst 서버 WAR 파일을 가져오는 데 사용됩니다.
3.  다음 명령을 실행하십시오.
    ```bash
    mfp_install_dir/shortcuts/ant -f <your_ant_file update>
    ```

#### 고유한 Ant 파일로 롤백
{: #rollback-with-own-ant-file }

고유한 Ant 파일을 사용하는 경우 각 업데이트/롤백 태스크(*installmobilefirstadmin*, *installmobilefirstruntime*, *installmobilefirstpush*)에 대해 Ant 파일에 동일한 매개변수를 가진 해당 업데이트 태스크가 있는지 확인하십시오. 해당 업데이트 태스크는 *updatemobilefirstadmin*, *updatemobilefirstruntime* 및 *updatemobilefirstpush*입니다.

1.  MFP 설치 디렉토리(`mfp_server_install_dir/MobileFirstServer`)의 백업된 위치에서 복사하여 MFP 관련 war 파일을 수동으로 대체하십시오.
2.  **mfp-ant-deployer.jar** 파일에 대한 `taskdef` 요소의 클래스 경로를 확인하십시오. 이는 수정팩이 적용되는 MobileFirst 서버 설치의 mfp-ant-deployer.jar 파일을 가리켜야 합니다. 기본적으로 업데이트된 MobileFirst 서버 WAR 파일은 mfp-ant-deployer.jar의 위치에서 가져옵니다.
3.  Ant 파일의 업데이트 태스크(*updatemobilefirstadmin*, *updatemobilefirstruntime* 및 *updatemobilefirstpush*)를 실행하십시오.
