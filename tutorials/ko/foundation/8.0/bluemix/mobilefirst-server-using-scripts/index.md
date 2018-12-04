---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Setting Up MobileFirst Server on IBM Cloud using Scripts for IBM Containers
#breadcrumb_title: IBM Containers
#relevantTo: [ios,android,windows,javascript]
#weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM Cloud에서 {{ site.data.keys.mf_server }} 인스턴스와 {{ site.data.keys.mf_analytics }} 인스턴스를 구성하려면 아래의 지시사항을 수행하십시오. 이를 달성하기 위해 다음 단계를 수행합니다.

* 필수 도구(Cloud Foundry CLI, Docker, IBM Containers Extension(cf ic) 플러그인)를 사용하여 호스트 컴퓨터 설정
* IBM Cloud 계정 설정
* {{ site.data.keys.mf_server }} 이미지를 빌드하여 IBM Cloud 저장소에 푸시하십시오.

마지막으로 IBM Containers에서 단일 Container 또는 Container 그룹으로 이미지를 실행하고 애플리케이션을 등록할 뿐 아니라 어댑터를 배치합니다.

**참고:**  

* Windows OS는 현재 이와 같은 스크립트 실행에 지원되지 않습니다.  
* IBM Containers에 배치하는 데 {{ site.data.keys.mf_server }} 구성 도구를 사용할 수 없습니다.

#### 다음으로 이동:
{: #jump-to }
* [IBM Cloud에 계정 등록](#register-an-account-at-bluemix)
* [호스트 시스템 설정](#set-up-your-host-machine)
* [{{ site.data.keys.mf_bm_pkg_name }} 아카이브 다운로드](#download-the-ibm-mfpf-container-8000-archive)
* [전제조건](#prerequisites)
* [IBM Containers에서 {{ site.data.keys.product_adj }} 및 Analytics Server 설정](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [{{ site.data.keys.mf_server }} 수정사항 적용](#applying-mobilefirst-server-fixes)
* [IBM Cloud에서 컨테이너 제거](#removing-a-container-from-bluemix)
* [IBM Cloud에서 데이터베이스 서비스 구성 제거](#removing-the-database-service-configuration-from-bluemix)

## IBM Cloud에 계정 등록
{: #register-an-account-at-bluemix }
아직 계정이 없는 경우 [IBM Cloud 웹 사이트](https://bluemix.net)를 방문하여 **무료로 시작하기** 또는 **등록**을 클릭하십시오. 다음 단계로 이동하려면 먼저 등록 양식에 입력해야 합니다.

### IBM Cloud 대시보드
{: #the-bluemix-dashboard }
IBM Cloud에 로그인하면 활성 IBM Cloud **영역**의 개요를 제공하는 IBM Cloud 대시보드가 표시됩니다. 기본적으로 이 작업 영역의 이름은 "dev"입니다. 필요한 경우 여러 작업 영역/영역을 작성할 수 있습니다.

## 호스트 시스템 설정
{: #set-up-your-host-machine }
컨테이너와 이미지를 관리하려면 Docker, Cloud Foundry CLI, IBM Containers(cf ic) 플러그인과 같은 도구를 설치해야 합니다.

### Docker
{: #docker }
왼쪽의 메뉴에서 [Docker 문서](https://docs.docker.com/)로 이동하고 **설치 → Docker Engine**을 선택한 후 사용자의 OS 유형을 선택하고 지시사항에 따라 Docker Toolbox를 설치하십시오.

**참고:** IBM에서는 Docker의 Kitematic을 지원하지 않습니다.

macOS의 경우 두 개의 옵션을 사용해서 Docker 명령을 실행할 수 있습니다.

* macOS Terminal.app에서는 추가 설정이 필요하지 않습니다. 여기에서만 작업할 수 있습니다.
* Docker Quickstart Terminal에서는 다음과 같이 진행하십시오.

* 다음 명령을 실행하십시오.

  ```bash
  docker-machine env default
  ```

* 결과를 환경 변수로 설정하십시오. 예를 들면, 다음과 같습니다.

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> 자세한 정보는 Docker 문서를 참조하십시오.

### Cloud Foundry 플러그인과 IBM Containers 플러그인
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195)를 설치하십시오.
2. [IBM Containers 플러그인(cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html)을 설치하십시오.

## {{ site.data.keys.mf_bm_pkg_name }} 아카이브 다운로드
{: #download-the-ibm-mfpf-container-8000-archive}
IBM Containers에서 {{ site.data.keys.product }}을 설정하려면 나중에 IBM Cloud에 푸시할 이미지를 먼저 작성해야 합니다.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">이 페이지의 지시사항을 수행하여</a> IBM Containers의 {{ site.data.keys.mf_server }} 아카이브(.zip 파일, *CNBL0EN* 검색)를 다운로드하십시오.

아카이브 파일에는 이미지를 빌드하는 데 필요한 파일(**dependencies**, **mfpf-libs**), {{ site.data.keys.mf_analytics }} Container를 빌드하고 배치하는 데 필요한 파일(**mfpf-analytics**), {{ site.data.keys.mf_server }} Container를 구성하는 데 필요한 파일(**mfpf-server**)이 들어 있습니다.

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>클릭하면 사용할 아카이브 파일 컨텐츠와 사용 가능한 환경 특성에 대해 자세히 볼 수 있습니다.</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="아카이브 파일의 파일 시스템 구조를 표시하는 이미지" style="float:right;width:570px"/>
                <h4>dependencies 폴더</h4>
                <p>{{ site.data.keys.product }} 런타임과 IBM Java JRE 8을 포함합니다.</p>

                <h4>mfpf-libs 폴더</h4>
                <p>{{ site.data.keys.product_adj }} 제품 컴포넌트 라이브러리와 CLI를 포함합니다.</p>

                <h4>mfpf-server 폴더와 mfpf-analytics 폴더</h4>

                <ul>
                    <li><b>Dockerfile</b>: 이미지를 빌드하는 데 필요한 모든 명령을 포함하는 텍스트 문서입니다.</li>
                    <li><b>scripts</b> 폴더: 이 폴더에는 구성 파일 세트가 포함된 <b>args</b> 폴더가 들어 있습니다. 또한 IBM Cloud에 로그인하고 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 이미지를 빌드하며 IBM Cloud에서 이미지를 푸시하고 실행하기 위해 실행할 스크립트가 들어 있습니다. 스크립트를 대화식으로 실행하거나 구성 파일을 현상태대로 사전 구성하여 실행할 수 있습니다(나중에 자세히 설명함). 사용자 정의할 수 있는 args/*.properties 파일 외에는 이 폴더의 요소를 수정하지 마십시오. 스크립트 사용법 도움말을 보려면 <code>-h</code> 또는 <code>--help</code> 명령행 인수를 사용하십시오(예: <code>scriptname.sh --help</code>).</li>
                    <li><b>usr</b> 폴더:
                        <ul>
                            <li><b>bin</b> 폴더: 컨테이너 시작 시 실행되는 스크립트 파일이 들어 있습니다. 사용자 고유의 사용자 정의 코드를 추가하여 실행할 수 있습니다.</li>
                            <li><b>config</b> 폴더: {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }}에서 사용되는 서버 구성 단편(키 저장소, 서버 특성, 사용자 레지스트리)이 들어 있습니다.</li>
                            <li><b>keystore.xml</b> - SSL 암호화에 사용되는 보안 인증서 저장소의 구성입니다. 나열된 파일을 ./usr/security 폴더에서 참조해야 합니다.</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }}와 {{ site.data.keys.mf_analytics }}의 구성 특성입니다. 다음 문서 주제에 나열된 지원되는 특성을 참조하십시오.
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - 사용자 레지스트리 구성입니다. basicRegistry(기본 XML 기반 사용자 레지스트리) 구성이 기본값으로 제공됩니다. basicRegistry에 사용할 사용자 이름과 비밀번호를 구성하거나 ldapRegistry를 구성할 수 있습니다.</li>
                        </ul>
                    </li>
                    <li><b>env</b> 폴더: 서버 초기화에 사용되는 환경 특성(server.env)과 사용자 정의 JVM 옵션(jvm.options)이 들어 있습니다.</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology-server-env" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>클릭하면 지원되는 서버 환경 특성의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>특성</b></td>
                                            <td><b>기본값</b></td>
                                            <td><b>설명</b></td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>클라이언트 HTTP 요청에 사용되는 포트입니다. 이 포트를 사용하지 않으려면 -1을 사용하십시오.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>SSL(HTTPS)로 보안 설정된 클라이언트 HTTP 요청에 사용되는 포트입니다. 이 포트를 사용하지 않으려면 -1을 사용하십시오.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>구성이 필요하지 않습니다. 올바른 값은 <code>Standalone</code> 또는 <code>Farm</code>입니다. 컨테이너가 컨테이너 그룹으로 실행되는 경우 <code>Farm</code> 값이 자동으로 설정됩니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>{{ site.data.keys.mf_server }} 관리 서비스를 사용할 수 있는 컨텍스트 루트입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>{{ site.data.keys.mf_console }}을 사용할 수 있는 컨텍스트 루트입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>사전 정의된 역할 <code>mfpadmin</code>이 지정된 사용자 그룹의 이름입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP	</td>
                                            <td>mfpdeployergroup</td>
                                            <td>사전 정의된 역할 <code>mfpdeployer</code>가 지정된 사용자 그룹의 이름입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>사전 정의된 역할 <code>mfpmonitor</code>가 지정된 사용자 그룹의 이름입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP	</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>사전 정의된 역할 <code>mfpoperator</code>가 지정된 사용자 그룹의 이름입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER	</td>
                                            <td>WorklightRESTUser</td>
                                            <td>{{ site.data.keys.mf_server }} 관리 서비스의 Liberty 서버 관리자입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin. 프로덕션 환경에 배치하기 전에 기본값을 개인용 비밀번호로 변경하십시오.</td>
                                            <td>{{ site.data.keys.mf_server }} 관리 서비스의 Liberty 서버 관리자 비밀번호입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 조작을 수행할 관리자 역할의 사용자 이름입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD	</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 조작을 수행할 관리자 역할의 비밀번호입니다.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>섹션 닫기</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>클릭하면 지원되는 분석 환경 특성의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>특성</b></td>
                                            <td><b>기본값</b></td>
                                            <td><b>설명</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>클라이언트 HTTP 요청에 사용되는 포트입니다. 이 포트를 사용하지 않으려면 -1을 사용하십시오.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>클라이언트 HTTP 요청에 사용되는 포트입니다. 이 포트를 사용하지 않으려면 -1을 사용하십시오.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>사전 정의된 역할 <b>worklightadmin</b>을 소유하는 사용자 그룹의 이름입니다.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>섹션 닫기</b></a>
                                </div>
                            </div>
                        </div>
                    </div>


                    </li>
                    <li><b>jre-security</b> 폴더: JRE 보안 관련 파일(신뢰 저장소, 정책 JAR 파일 등)을 이 폴더에 저장하여 해당 파일을 업데이트할 수 있습니다. 이 폴더의 파일은 컨테이너의 JAVA_HOME/jre/lib/security/ 폴더에 복사됩니다.</li>
                    <li><b>security</b> 폴더: 키 저장소, 신뢰 저장소, LTPA 키 파일(ltpa.keys)을 저장하는 데 사용됩니다.</li>
                    <li><b>ssh</b> 폴더: 컨테이너에 대한 SSH 액세스가 가능하도록 설정하는 데 사용되는 SSH 공개 키 파일(id_rsa.pub)을 저장하는 데 사용됩니다.</li>
                    <li><b>wxs</b> 폴더({{ site.data.keys.mf_server }} 전용): Data Cache가 서버의 속성 저장소로 사용되는 경우 데이터 캐시/극단 범위 클라이언트 라이브러리를 포함합니다.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>섹션 닫기</b></a>
            </div>
        </div>
    </div>
</div>

## 전제조건
{: #prerequisites }
다음 섹션 중에 IBM Containers 명령을 실행하므로 아래의 단계는 필수입니다.

1. IBM Cloud 환경에 로그인하십시오.  

    `cf login`을 실행하십시오.  
    프롬프트가 표시되면 다음 정보를 입력하십시오.
      * IBM Cloud API 엔드포인트
      * 이메일
      * 비밀번호
      * 조직(둘 이상의 조직이 있는 경우)
      * 영역(둘 이상의 영역이 있는 경우)

2. IBM Containers 명령을 실행하려면 먼저 IBM Container 클라우드 서비스에 로그인해야 합니다.  
`cf ic login`을 실행하십시오.

3. 컨테이너 레지스트리의 `namespace`가 설정되었는지 확인하십시오. `namespace`는 IBM Cloud 레지스트리에서 개인용 저장소를 식별하는 고유 이름입니다. 네임스페이스는 조직에 한 번 지정되며 변경될 수 없습니다. 다음 규칙에 따라 네임스페이스를 선택하십시오.
     * 소문자, 숫자 또는 밑줄만 포함할 수 있습니다.
     * 4 - 30자입니다. 명령행에서 컨테이너를 관리하려는 경우 빨리 입력할 수 있는 짧은 네임스페이스를 선호할 수 있습니다.
     * IBM Cloud 레지스트리에서 고유해야 합니다.

    네임스페이스를 설정하려면 `cf ic namespace set <new_name>` 명령을 실행하십시오.  
    설정한 네임스페이스를 가져오려면 `cf ic namespace get` 명령을 실행하십시오.

> IC 명령에 대해 자세히 알아보려면 `ic help` 명령을 사용하십시오.

## IBM Containers에서 {{ site.data.keys.product_adj }}, Analytics Servers 및 {{ site.data.keys.mf_app_center_short }} 설정
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
위에서 설명한 대로 스크립트를 대화식으로 또는 구성 파일을 사용하여 실행할 수 있습니다.

* 구성 파일 사용 - 스크립트를 실행하고 각 구성 파일을 인수로 전달합니다.
* 대화식 - 인수 없이 스크립트를 실행합니다.

**참고:** 스크립트를 대화식으로 실행할 경우 구성을 건너뛸 수 있지만 적어도 제공해야 하는 인수에 대해 읽고 이해해야 합니다.


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }
{{ site.data.keys.mf_app_center }}를 사용하려면 여기서 시작하십시오.

>**참고:** 설치 프로그램과 DB 도구는 사내 구축형 {{ site.data.keys.mf_app_center }} 설치 폴더(`installer` 및 `tools` folders)에서 다운로드할 수 있습니다.

<div class="panel-group accordion" id="scripts" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1appcenter" aria-expanded="false" aria-controls="collapseStep1appcenter">구성 파일 사용</a>
            </h4>
        </div>

        <div id="collapseStep1appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <b>args</b> 폴더에는 스크립트를 실행하는 데 필요한 인수가 포함된 구성 파일 세트가 들어 있습니다. 다음 파일의 인수 값을 채우십시오.<br/>
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>IBM Cloud 사용자 이름(이메일)입니다.</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>IBM Cloud 비밀번호입니다.</li>
                  <li><b>IBM_CLOUD_ORG - </b>IBM Cloud 조직 이름입니다.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>IBM Cloud 영역(앞서 설명함)입니다.</li>
              </ul>
              <h4>prepareappcenterdbs.properties</h4>
              {{ site.data.keys.mf_app_center }}에는 외부 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="_blank">dashDB Enterprise Transactional 데이터베이스 인스턴스</a>(Enterprise Transactional 2.8.500 또는 Enterprise Transactional 12.128.1400)가 필요합니다.
              <blockquote><p><b>참고:</b> dashDB Enterprise Transactional 플랜의 배치는 즉각적이지 않을 수 있습니다. 서비스 배치 전에 영업 팀에서 연락을 드릴 수 있습니다.</p></blockquote>

              dashDB 인스턴스를 설정한 후 다음과 같은 필수 인수를 제공하십시오.
              <ul>
                  <li><b>APPCENTER_DB_SRV_NAME - </b>Application Center 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다.</li>
                  <li><b>APPCENTER_SCHEMA_NAME - </b>Application Center 데이터를 저장하는 데 사용할 데이터베이스 스키마 이름입니다.</li>
                  <blockquote><b>참고:</b> 여러 사용자가 dashDB 서비스 인스턴스를 공유 중인 경우 고유한 스키마 이름을 제공해야 합니다.</blockquote>

              </ul>
              <h4>prepareappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>이미지에 대한 태그입니다. <em>registry-url/namespace/your-tag</em> 양식이어야 합니다.</li>
              </ul>
              <h4>startappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b><em>prepareappcenter.sh</em>의 경우와 동일합니다.</li>
                  <li><b>SERVER_CONTAINER_NAME - </b>IBM Cloud Container의 이름입니다.</li>
                  <li><b>SERVER_IP - </b>IBM Cloud Container를 바인드할 IP 주소입니다.</li>
                  <blockquote>IP 주소를 지정하려면 <code>cf ic ip request</code>를 실행하십시오.
                  제공된 IBM Cloud 영역의 여러 컨테이너에서 IP 주소를 재사용할 수 있습니다.
                  IP 주소를 이미 지정한 경우에는 <code>cf ic ip list</code>를 실행할 수 있습니다.</blockquote>
              </ul>
              <h4>startappcentergroup.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b><em>prepareappcenter.sh</em>의 경우와 동일합니다.</li>
                  <li><b>SERVER_CONTAINER_GROUP_NAME - </b>IBM Cloud Container 그룹의 이름입니다.</li>
                  <li><b>SERVER_CONTAINER_GROUP_HOST - </b>호스트 이름입니다.</li>
                  <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>도메인 이름입니다. 기본값은 <code>mybluemix.net</code>입니다.</li>
              </ul>    
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="appcenterstep2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2appcenter" aria-expanded="false" aria-controls="collapseStep2appcenter">스크립트 실행</a>
            </h4>
        </div>

        <div id="collapseStep2appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>다음 지시사항은 구성 파일을 사용하여 스크립트를 실행하는 방법을 보여줍니다. 대화식 모드에서 실행하는 데 사용하지 않는 명령행 인수의 목록도 사용 가능합니다.</p>
                <ol>
                    <li><b>initenv.sh – IBM Cloud에 로그인</b><br />
                    IBM Containers에서 {{ site.data.keys.product }}를 빌드하고 실행하는 데 필요한 환경을 작성하려면 <b>initenv.sh</b> 스크립트를 실행하십시오.
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud 사용자 ID 또는 이메일 주소</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud 비밀번호</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud 조직 이름</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud 영역 이름</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>IBM Cloud API 엔드포인트 (기본값은 https://api.ng.bluemix.net).</td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareappcenterdbs.sh - {{ site.data.keys.mf_app_center }} 데이터베이스 준비</b><br/>
                    <b>prepareappcenterdbs.sh</b> 스크립트는 dashDB 데이터베이스 서비스를 사용해서 {{ site.data.keys.mf_app_center }}를 구성하는 데 사용됩니다. 1단계에서 로그인한 조직과 영역에서 dashDB 서비스의 서비스 인스턴스를 사용할 수 있어야 합니다.
                    다음을 실행하십시오.

{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenterdbs" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenterdbs">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenterdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenterdbs">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>명령행 인수</b></td>
                                              <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-db | --acdb ] APPCENTER_DB_SRV_NAME	</td>
                                              <td>IBM Cloud dashDB 서비스(Enterprise Transactional의 IBM Cloud 서비스 플랜 포함)</td>
                                            </tr>    
                                            <tr>
                                              <td>선택사항: [-ds | --acds ] APPCENTER_SCHEMA_NAME	</td>
                                              <td>Application Center 서비스의 데이터베이스 스키마 이름입니다. 기본값은 <i>APPCNTR</i>입니다.</td>
                                            </tr>    
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
prepareappcenterdbs.sh --acdb AppCenterDashDBService
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>섹션 닫기</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>initenv.sh(선택사항) – IBM Cloud에 로그인</b><br />
                    이 단계는 dashDB 서비스 인스턴스를 사용할 수 있는 조직과 영역 이외의 조직과 영역에서 컨테이너를 작성해야 하는 경우에만 필수입니다. 값이 예인 경우에는 컨테이너가 작성되고 시작되어야 하는 새 조직과 영역으로 <b>initenv.properties</b>를 업데이트하고 <b>initenv.sh</b> 스크립트를 다시 실행하십시오.</li>

{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}


                    <li><b>prepareappcenter.sh - {{ site.data.keys.mf_app_center }} 이미지 준비</b><br />
                    {{ site.data.keys.mf_app_center }} 이미지를 빌드하여 IBM Cloud 저장소에 푸시하려면 <b>prepareappcenter.sh</b> 스크립트를 실행하십시오. IBM Cloud 저장소에서 사용할 수 있는 모든 이미지를 보려면 <code>cf ic images</code>를 실행하십시오.
                    목록은 이미지 이름, 작성 날짜, ID를 포함합니다.

                        다음을 실행하십시오.
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                                <td>사용자 정의된 MobileFirst Application Center 이미지에 사용할 이름입니다. 형식: <em>registryUrl/namespace/imagename</em></td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
prepareappcenter.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcenter.sh - IBM Container에서 이미지 실행</b><br/>
                    <b>startappcenter.sh</b> 스크립트는 IBM Container에서 {{ site.data.keys.mf_app_center }} 이미지를 실행하는 데 사용됩니다. 또한 <b>SERVER_IP</b> 특성에서 구성한 공용 IP에 이미지를 바인드합니다.

                        다음을 실행하십시오.
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>{{ site.data.keys.mf_app_center }} 이미지의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] SERVER_IP	</td>
                                                <td>{{ site.data.keys.mf_app_center }} 컨테이너를 바인드할 IP 주소입니다. (사용 가능한 공용 IP를 제공하거나 <code>cf ic ip request</code> 명령을 사용하여 IP 주소를 요청할 수 있습니다.)</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-si|--services] SERVICE_INSTANCES	</td>
                                                <td>컨테이너에 바인드하려는 쉼표로 구분된 IBM Cloud 서비스 인스턴스입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-h|--http] EXPOSE_HTTP </td>
                                                <td>HTTP 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-s|--https] EXPOSE_HTTPS </td>
                                                <td>HTTPS 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-m|--memory] SERVER_MEM </td>
                                                <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-se|--ssh] SSH_ENABLE </td>
                                                <td>컨테이너에 SSH를 사용합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-sk|--sshkey] SSH_KEY </td>
                                                <td>컨테이너에 삽입할 SSH 키입니다. (id_rsa.pub 파일의 컨텐츠를 제공하십시오.)</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-tr|--trace] TRACE_SPEC </td>
                                                <td>적용할 추적 스펙입니다. 기본값: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-ml|--maxlog] MAX_LOG_FILES </td>
                                                <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-v|--volume] ENABLE_VOLUME </td>
                                                <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>

                                        </table>

                                        <p>예:</p>
{% highlight bash %}
startappcenter.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcentergroup.sh - IBM Container 그룹에서 이미지 실행</b><br/>
                    <b>startappcentergroup.sh</b> 스크립트는 IBM Container 그룹에서 {{ site.data.keys.mf_app_center }} 이미지를 실행하는 데 사용됩니다. 또한 <b>SERVER_CONTAINER_GROUP_HOST</b> 특성에서 구성한 호스트 이름에 이미지를 바인드합니다.

                        다음을 실행하십시오.
{% highlight bash %}
./startappcentergroup.sh args/startappcentergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcentergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcentergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcentergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcentergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>IBM Cloud 레지스트리에 있는 {{ site.data.keys.mf_app_center }} 컨테이너 이미지의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>{{ site.data.keys.mf_app_center }} 컨테이너 그룹의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>경로의 호스트 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN </td>
                                                <td>경로의 도메인 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-gm|--min] SERVERS_CONTAINER_GROUP_MIN </td>
                                                <td>최소 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-gx|--max] SERVER_CONTAINER_GROUP_MAX </td>
                                                <td>최대 컨테이너 인스턴스 수입니다. 기본값은 2입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED </td>
                                                <td>원하는 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-a|--auto] ENABLE_AUTORECOVERY </td>
                                                <td>컨테이너 인스턴스의 자동 복구 옵션을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-si|--services] SERVICES </td>
                                                <td>컨테이너에 바인드하려는 쉼표로 구분된 IBM Cloud 서비스 인스턴스 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-tr|--trace] TRACE_SPEC </td>
                                                <td>적용할 추적 스펙입니다. 기본값은 </code>*=info</code>입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-ml|--maxlog] MAX_LOG_FILESC </td>
                                                <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-m|--memory] SERVER_MEM </td>
                                                <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항: [-v|--volume] ENABLE_VOLUME </td>
                                                <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>

                                        </table>

                                        <p>예:</p>
{% highlight bash %}
startappcentergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_server }}에서 분석을 사용하려면 여기에서 시작하십시오.

<div class="panel-group accordion" id="scripts-analytics" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1-analytics">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">구성 파일 사용</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <b>args</b> 폴더에는 스크립트를 실행하는 데 필요한 인수가 포함된 구성 파일 세트가 들어 있습니다. 다음 파일의 인수 값을 채우십시오.<br/>
            <b>참고:</b> 필수 인수만 포함합니다. 추가 인수에 대해 자세히 알아보려면 특성 파일에 있는 문서를 참조하십시오.
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>IBM Cloud 사용자 이름(이메일)입니다.</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>IBM Cloud 비밀번호입니다.</li>
                  <li><b>IBM_CLOUD_ORG - </b>IBM Cloud 조직 이름입니다.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>IBM Cloud 영역(앞서 설명함)입니다.</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>이미지에 대한 태그입니다. <em>registry-url/namespace/your-tag</em> 양식이어야 합니다.</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b><em>prepareserver.sh</em>의 경우와 동일합니다.</li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>IBM Cloud Container의 이름입니다.</li>
                  <li><b>ANALYTICS_IP - </b>IBM Cloud Container를 바인드할 IP 주소입니다.<br/>
                  IP 주소를 지정하려면 <code>cf ic ip request</code>를 실행하십시오.<br/>
                  영역의 여러 컨테이너에서 IP 주소를 재사용할 수 있습니다.<br/>
                  IP 주소를 하나 이미 지정한 경우에는 <code>cf ic ip list</code>를 실행할 수 있습니다.</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b><em>prepareserver.sh</em>의 경우와 동일합니다.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>IBM Cloud Container 그룹의 이름입니다.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>호스트 이름입니다.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>도메인 이름입니다. 기본값은 <code>mybluemix.net</code>입니다.</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">스크립트 실행</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>다음 지시사항은 구성 파일을 사용하여 스크립트를 실행하는 방법을 보여줍니다. 대화식 모드에서 실행하는 데 사용하지 않는 명령행 인수의 목록도 사용 가능합니다.</p>
                <ol>
                    <li><b>initenv.sh – IBM Cloud에 로그인</b><br />
                    IBM Containers에서 {{ site.data.keys.mf_analytics }}를 빌드하고 실행하는 데 필요한 환경을 작성하려면 <b>initenv.sh</b> 스크립트를 실행하십시오.
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud 사용자 ID 또는 이메일 주소</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud 비밀번호</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud 조직 이름</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud 영역 이름</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>IBM Cloud API 엔드포인트 (기본값은 https://api.ng.bluemix.net).</td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - {{ site.data.keys.mf_analytics }} 이미지 준비</b><br />
                        {{ site.data.keys.mf_analytics }} 이미지를 빌드하여 IBM Cloud 저장소에 푸시하려면 <b>prepareanalytics.sh</b> 스크립트를 실행하십시오.

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        IBM Cloud 저장소에서 사용할 수 있는 모든 이미지를 보려면 <code>cf ic images</code>를 실행하십시오.<br/>
                        목록은 이미지 이름, 작성 날짜, ID를 포함합니다.

                        <div class="panel-group accordion" id="terminology-analytics-prepareanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>명령행 인수</b></td>
                                              <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>사용자 정의된 분석 이미지에 사용할 이름입니다. 형식: IBM_Cloud_레지스트리_URL/개인용_네임스페이스/이미지_이름</td>
                                            </tr>      
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>섹션 닫기</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - IBM Container에서 이미지 실행</b><br />
                    <b>startanalytics.sh</b> 스크립트는 IBM Container에서 {{ site.data.keys.mf_analytics }} 이미지를 실행하는 데 사용됩니다. 또한 <b>ANALYTICS_IP</b> 특성에서 구성한 공용 IP에 이미지를 바인드합니다.</li>

                    다음을 실행하십시오.
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>IBM Containers 레지스트리에 로드된 분석 컨테이너 이미지의 이름. 형식: IBMCloudRegistry/PrivateNamespace/ImageName:태그</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>분석 컨테이너의 이름</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>컨테이너를 바인드할 IP 주소. (사용 가능한 공용 IP를 제공하거나 <code>cf ic ip request</code> 명령을 사용하여 IP 주소를 요청할 수 있습니다.)</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-h|--http] EXPOSE_HTTP	</td>
                                                <td>HTTP 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-s|--https] EXPOSE_HTTPS	</td>
                                                <td>HTTPS 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-m|--memory] SERVER_MEM	</td>
                                                <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-se|--ssh] SSH_ENABLE	</td>
                                                <td>컨테이너에 SSH를 사용합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-sk|--sshkey] SSH_KEY	</td>
                                                <td>컨테이너에 삽입할 SSH 키입니다. (id_rsa.pub 파일의 컨텐츠를 제공하십시오.)</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>적용할 추적 스펙입니다. 기본값: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME	</td>
                                                <td>분석 데이터의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>분석 데이터용으로 작성하고 마운트할 볼륨의 이름을 지정합니다. 기본 이름은 <b>mfpf_analytics_container_name</b>입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>데이터를 저장할 위치를 지정합니다. 기본 폴더 이름은 <b>/analyticsData</b>입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.mf_analytics }} 특성을 쉼표로 구분된 키:값 쌍으로 지정합니다. 참고: 이 스크립트를 사용하여 특성을 지정하는 경우 동일한 특성이 usr/config 폴더의 구성 파일에 설정되지 않았는지 확인하십시오.</td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
                        {% highlight bash %}
                        startanalytics.sh --tag image_tag_name --name container_name --ip container_ip_address
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - IBM Container 그룹에서 이미지 실행</b><br />
                        <b>startanalyticsgroup.sh</b> 스크립트는 IBM Container 그룹에서 {{ site.data.keys.mf_analytics }} 이미지를 실행하는 데 사용됩니다. 또한 <b>ANALYTICS_CONTAINER_GROUP_HOST</b> 특성에서 구성한 호스트 이름에 이미지를 바인드합니다.

                        다음을 실행하십시오.
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalyticsgroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>IBM Containers 레지스트리에 로드된 분석 컨테이너 이미지의 이름. 형식: IBMCloudRegistry/PrivateNamespace/ImageName:태그</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>분석 컨테이너 그룹의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>경로의 호스트 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>경로의 도메인 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN</td>
                                                <td>최소 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX	</td>
                                                <td>최대 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED	</td>
                                                <td>원하는 컨테이너 인스턴스 수입니다. 기본값은 2입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>적용할 추적 스펙입니다. 기본값: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.product_adj }} 특성을 쉼표로 구분된 키:값 쌍으로 지정합니다. 예: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-m|--memory] SERVER_MEM	</td>
                                                <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>분석 데이터용으로 작성하고 마운트할 볼륨의 이름을 지정합니다. 기본값은 <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b>입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>분석 데이터를 저장하는 데 사용할 디렉토리를 지정합니다. 기본값은 <b>/analyticsData</b>입니다.</td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
startanalyticsgroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                http://ANALYTICS-CONTAINER-HOST/analytics/console URL을 로드하여 Analytics Console을 실행하십시오. 실행하는 데 시간이 걸릴 수 있습니다.  
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">구성 파일 사용</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <b>args</b> 폴더에는 스크립트를 실행하는 데 필요한 인수가 포함된 구성 파일 세트가 들어 있습니다.  다음 파일의 인수 값을 채우십시오.<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_USER - </b>IBM Cloud 사용자 이름(이메일)입니다.</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>IBM Cloud 비밀번호입니다.</li>
                    <li><b>IBM_CLOUD_ORG - </b>IBM Cloud 조직 이름입니다.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>IBM Cloud 영역(앞서 설명함)입니다.</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                 {{ site.data.keys.mf_bm_short }} 서비스에는 외부 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>dashDB Enterprise Transactional 데이터베이스</i> 인스턴스</a>(<i>Enterprise Transactional 2.8.500</i> 또는 <i>Enterprise Transactional 12.128.1400</i>)가 필요합니다.<br/>
                <b>참고:</b> dashDB Enterprise Transactional 플랜의 배치는 즉각적이지 않을 수 있습니다. 서비스 배치 전에 영업 팀에서 연락을 드릴 수 있습니다.<br/><br/>
                dashDB 인스턴스를 설정한 후 다음과 같은 필수 인수를 제공하십시오.
                <ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>관리 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다.</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>관리 데이터의 스키마 이름입니다. 기본값은 MFPDATA입니다.</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>런타임 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다. 기본값은 관리 서비스 이름입니다.</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>런타임 데이터의 스키마 이름입니다. 기본값은 MFPDATA입니다.</li>
                    <b>참고:</b> 여러 사용자가 dashDB 서비스 인스턴스를 공유 중인 경우 고유 스키마 이름을 제공하십시오.
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>이미지에 대한 태그입니다. <em>registry-url/namespace/your-tag</em> 양식이어야 합니다.</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b><em>prepareserver.sh</em>의 경우와 동일합니다.</li>
                    <li><b>SERVER_CONTAINER_NAME - </b>IBM Cloud Container의 이름입니다.</li>
                    <li><b>SERVER_IP - </b>IBM Cloud Container를 바인드할 IP 주소입니다.<br/>
                  IP 주소를 지정하려면 <code>cf ic ip request</code>를 실행하십시오.<br/>
                  영역의 여러 컨테이너에서 IP 주소를 재사용할 수 있습니다.<br/>
                  IP 주소를 하나 이미 지정한 경우에는 <code>cf ic ip list</code>를 실행할 수 있습니다.</li>
                    <li><b>MFPF_PROPERTIES - </b>쉼표로 구분된(<b>공백 없음</b>) {{ site.data.keys.mf_server }} JNDI 특성입니다. 여기서 분석 관련 특성을 정의합니다. <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b><em>prepareserver.sh</em>의 경우와 동일합니다.</li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>IBM Cloud Container 그룹의 이름입니다.</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>호스트 이름입니다.</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>도메인 이름입니다. 기본값은 <code>mybluemix.net</code>입니다.</li>
                    <li><b>MFPF_PROPERTIES - </b>쉼표로 구분된(<b>공백 없음</b>) {{ site.data.keys.mf_server }} JNDI 특성입니다. 여기서 분석 관련 특성을 정의합니다. <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">스크립트 실행</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <p>다음 지시사항은 구성 파일을 사용하여 스크립트를 실행하는 방법을 보여줍니다. 대화식 모드에서 실행하는 데 사용하지 않는 명령행 인수의 목록도 사용 가능합니다.</p>

            <ol>
                <li><b>initenv.sh – IBM Cloud에 로그인</b><br />
                    IBM Containers에서 {{ site.data.keys.product }}을 빌드하고 실행하는 데 필요한 환경을 작성하려면 <b>initenv.sh</b> 스크립트를 실행하십시오.
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-initenv" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>명령행 인수</b></td>
                                            <td><b>설명</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] IBM_CLOUD_USER</td>
                                            <td>IBM Cloud 사용자 ID 또는 이메일 주소</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                            <td>IBM Cloud 비밀번호</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                            <td>IBM Cloud 조직 이름</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                            <td>IBM Cloud 영역 이름</td>
                                        </tr>
                                        <tr>
                                            <td>선택사항. [-a|--api] IBM_CLOUD_API_URL	</td>
                                            <td>IBM Cloud API 엔드포인트 (기본값은 https://api.ng.bluemix.net).</td>
                                        </tr>
                                    </table>

                                    <p>예:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - {{ site.data.keys.mf_server }} 데이터베이스 준비</b><br />
                    <b>prepareserverdbs.sh</b> 스크립트는 dashDB 데이터베이스 서비스를 사용해서 {{ site.data.keys.mf_server }}를 구성하는 데 사용됩니다. 1단계에서 로그인한 조직과 영역에서 dashDB 서비스의 서비스 인스턴스를 사용할 수 있어야 합니다. 다음을 실행하십시오.
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserverdbs" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>명령행 인수</b></td>
                                            <td><b>설명</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>IBM Cloud dashDB™ 서비스(Enterprise Transactional의 IBM Cloud 서비스 플랜 포함)</td>
                                        </tr>
                                        <tr>
                                            <td>선택사항. [-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>관리 서비스의 데이터베이스 스키마 이름입니다. 기본값은 MFPDATA입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>선택사항. [-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>런타임 데이터를 저장하는 데 사용할 IBM Cloud 데이터베이스 서비스 인스턴스 이름입니다. 기본값은 관리 데이터에 대해 지정된 서비스와 동일하게 설정됩니다.</td>
                                        </tr>
                                        <tr>
                                            <td>선택사항. [-p |--push ] ENABLE_PUSH	</td>
                                            <td>푸시 서비스에 사용할 데이터베이스를 구성할 수 있도록 합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>푸시 데이터를 저장하는 데 사용할 IBM Cloud 데이터베이스 서비스 인스턴스 이름입니다. 기본값은 런타임 데이터에 대해 지정된 서비스와 동일하게 설정됩니다.</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>푸시 서비스의 데이터베이스 스키마 이름입니다. 기본값은 런타임 스키마 이름입니다.</td>
                                        </tr>
                                    </table>

                                    <p>예:</p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>섹션 닫기</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh(선택사항) – IBM Cloud에 로그인</b><br />
                      이 단계는 dashDB 서비스 인스턴스를 사용할 수 있는 조직과 영역 이외의 조직과 영역에서 컨테이너를 작성해야 하는 경우에만 필수입니다. 값이 예인 경우에는 컨테이너가 작성되고 시작되어야 하는 새 조직과 영역으로 initenv.properties를 업데이트하고 <b>initenv.sh</b> 스크립트를 다시 실행하십시오.
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - {{ site.data.keys.mf_server }} 이미지 준비</b><br />
                    {{ site.data.keys.mf_server }} 이미지를 빌드하여 IBM Cloud 저장소에 푸시하려면 <b>prepareserver.sh</b> 스크립트를 실행하십시오. IBM Cloud 저장소에서 사용할 수 있는 모든 이미지를 보려면 <code>cf ic images</code>를 실행하십시오.<br/>
                    목록은 이미지 이름, 작성 날짜, ID를 포함합니다.<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>명령행 인수</b></td>
                                            <td><b>설명</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>사용자 정의된 {{ site.data.keys.mf_server }} 이미지에 사용할 이름입니다. 형식: registryUrl/namespace/imagename</td>
                                        </tr>
                                    </table>

                                    <p>예:</p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                  <br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>섹션 닫기</b></a>
                              </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - IBM Container에서 이미지 실행</b><br />
                    <b>startserver.sh</b> 스크립트는 IBM Container에서 {{ site.data.keys.mf_server }} 이미지를 실행하는 데 사용됩니다. 또한 <b>SERVER_IP</b> 특성에서 구성한 공용 IP에 이미지를 바인드합니다. 다음을 실행하십시오.</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-startserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>명령행 인수</b></td>
                                        <td><b>설명</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>{{ site.data.keys.mf_server }} 이미지의 이름입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>{{ site.data.keys.mf_server }} 컨테이너를 바인드할 IP 주소입니다. (사용 가능한 공용 IP를 제공하거나 <code>cf ic ip request</code> 명령을 사용하여 IP 주소를 요청할 수 있습니다.)</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-si|--services] SERVICE_INSTANCES	</td>
                                        <td>컨테이너에 바인드하려는 쉼표로 구분된 IBM Cloud 서비스 인스턴스입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-h|--http] EXPOSE_HTTP	</td>
                                        <td>HTTP 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-s|--https] EXPOSE_HTTPS	</td>
                                        <td>HTTPS 포트를 공개합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-m|--memory] SERVER_MEM	</td>
                                        <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-se|--ssh] SSH_ENABLE	</td>
                                        <td>컨테이너에 SSH를 사용합니다. 허용되는 값은 Y(기본값) 또는 N입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-sk|--sshkey] SSH_KEY	</td>
                                        <td>컨테이너에 삽입할 SSH 키입니다. (id_rsa.pub 파일의 컨텐츠를 제공하십시오.)</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-tr|--trace] TRACE_SPEC	</td>
                                        <td>적용할 추적 스펙입니다. 기본값: <code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                        <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                        <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-v|--volume] ENABLE_VOLUME	</td>
                                        <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                    </tr>
                                    <tr>
                                        <td>선택사항. [-e|--env] MFPF_PROPERTIES	</td>
                                        <td>{{ site.data.keys.product_adj }} 특성을 쉼표로 구분된 키:값 쌍으로 지정합니다. 예: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>.  <b>참고:</b> 이 스크립트를 사용하여 특성을 지정하는 경우 동일한 특성이 usr/config 폴더의 구성 파일에 설정되지 않았는지 확인하십시오.</td>
                                    </tr>
                                </table>

                                <p>예:</p>
{% highlight bash %}
startserver.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>섹션 닫기</b></a>
                            </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - IBM Container 그룹에서 이미지 실행</b><br />
                    <b>startservergroup.sh</b> 스크립트는 IBM Container 그룹에서 {{ site.data.keys.mf_server }} 이미지를 실행하는 데 사용됩니다. 또한 <b>SERVER_CONTAINER_GROUP_HOST</b> 특성에서 구성한 호스트 이름에 이미지를 바인드합니다.</li>
                    다음을 실행하십시오.
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-startservergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>클릭하면 명령행 인수의 목록이 표시됩니다.</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>명령행 인수</b></td>
                                                <td><b>설명</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>IBM Cloud 레지스트리에 있는 {{ site.data.keys.mf_server }} 컨테이너 이미지의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>{{ site.data.keys.mf_server }} 컨테이너 그룹의 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>경로의 호스트 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>경로의 도메인 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gm|--min] SERVERS_CONTAINER_GROUP_MIN	</td>
                                                <td>최소 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gx|--max] SERVER_CONTAINER_GROUP_MAX	</td>
                                                <td>최대 컨테이너 인스턴스 수입니다. 기본값은 1입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED	</td>
                                                <td>원하는 컨테이너 인스턴스 수입니다. 기본값은 2입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-a|--auto] ENABLE_AUTORECOVERY	</td>
                                                <td>컨테이너 인스턴스의 자동 복구 옵션을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>

                                            <tr>
                                                <td>선택사항. [-si|--services] SERVICES	</td>
                                                <td>컨테이너에 바인드하려는 쉼표로 구분된 IBM Cloud 서비스 인스턴스 이름입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>적용할 추적 스펙입니다. 기본값은 <code>*=info</code>입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>로그 파일을 겹쳐쓰기 전에 유지보수할 최대 로그 파일 수입니다. 기본값은 5개 파일입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>최대 로그 파일 크기입니다. 기본 크기는 20MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>{{ site.data.keys.product_adj }} 특성을 쉼표로 구분된 키:값 쌍으로 지정합니다. 예: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>참고:</b> 이 스크립트를 사용하여 특성을 지정하는 경우 동일한 특성이 usr/config 폴더의 구성 파일에 설정되지 않았는지 확인하십시오.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-m|--memory] SERVER_MEM	</td>
                                                <td>컨테이너에 메모리 크기 한계(MB)를 지정합니다. 허용되는 값은 1024MB(기본값)와 2048MB입니다.</td>
                                            </tr>
                                            <tr>
                                                <td>선택사항. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>컨테이너 로그의 마운팅 볼륨을 사용합니다. 허용되는 값은 Y 또는 N(기본값)입니다.</td>
                                            </tr>
                                        </table>

                                        <p>예:</p>
{% highlight bash %}
startservergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>섹션 닫기</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **참고:** 구성이 변경된 후에는 컨테이너를 다시 시작해야 합니다(`cf ic restart containerId`). 컨테이너 그룹의 경우 그룹 내의 각 컨테이너 인스턴스를 다시 시작해야 합니다. 예를 들어, 루트 인증서가 변경되면 새 인증서가 추가된 후 각 컨테이너 인스턴스를 다시 시작해야 합니다.

http://MF\_CONTAINER\_HOST/mfpconsole URL을 로드하여 {{ site.data.keys.mf_console }}을 실행하십시오. 실행하는 데 시간이 걸릴 수 있습니다.  
[{{ site.data.keys.mf_cli }}를 사용하여 {{ site.data.keys.product_adj }} 아티팩트 관리](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 학습서의 지시사항을 수행하여 원격 서버를 추가하십시오.  

IBM Cloud에서 {{ site.data.keys.mf_server }}가 실행되면 애플리케이션 개발을 시작할 수 있습니다. {{ site.data.keys.product }} [학습서](../../all-tutorials)를 검토하십시오.

#### 포트 번호 제한사항
{: #port-number-limitation }
현재 공용 도메인에 사용할 수 있는 포트 번호에 IBM Containers 제한사항이 있습니다. 따라서 {{ site.data.keys.mf_analytics }} 컨테이너와 {{ site.data.keys.mf_server }} 컨테이너에 지정된 기본 포트 번호(HTTP의 경우 9080, HTTPS의 경우 9443)를 변경할 수 없습니다. 컨테이너 그룹의 컨테이너에서는 HTTP 포트 9080을 사용해야 합니다. 컨테이너 그룹은 다중 포트 번호 또는 HTTPS 요청의 사용을 지원하지 않습니다.


## {{ site.data.keys.mf_server }} 수정사항 적용
{: #applying-mobilefirst-server-fixes }

[IBM Fix Central](http://www.ibm.com/support/fixcentral)에서 IBM Containers의 {{ site.data.keys.mf_server }}에 대한 임시 수정사항을 얻을 수 있습니다.  
임시 수정사항을 적용하기 전에 기존 구성 파일을 백업하십시오. 구성 파일은 다음 폴더에 있습니다.
* {{ site.data.keys.mf_analytics }}: **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry 애플리케이션: **package_root/mfpf-server/usr**
* {{ site.data.keys.mf_app_center_short }}: **package_root/mfp-appcenter/usr**

### iFix 적용 단계:

1. 임시 수정사항 아카이브를 다운로드하고 기존 설치 폴더에 컨텐츠의 압축을 풀어 기존 파일을 겹쳐쓰십시오.
2. 백업한 구성 파일을 **package_root/mfpf-analytics/usr**, **package_root/mfpf-server/usr** 및 **package_root/mfp-appcenter/usr** 폴더에 복원하여 새로 설치된 구성 파일을 겹쳐쓰십시오.
3. 편집기에서 **package_root/mfpf-server/usr/env/jvm.options** 파일을 편집하고 다음 행이 있는 경우 제거하십시오.
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    이제 업데이트된 서버를 빌드하고 배치할 수 있습니다.

    a. 서버 이미지를 다시 빌드한 후 IBM Containers 서비스로 푸시하려면 `prepareserver.sh` 스크립트를 실행하십시오.

    b. 서버 이미지를 독립형 컨테이너로 실행하려면 `startserver.sh` 스크립트를 실행하고, 서버 이미지를 컨테이너 그룹으로 실행하려면 `startservergroup.sh`를 실행하십시오.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## IBM Cloud에서 컨테이너 제거
{: #removing-a-container-from-bluemix }
IBM Cloud에서 컨테이너를 제거하는 경우 레지스트리에서 이미지 이름도 제거해야 합니다.  
다음 명령을 실행하여 IBM Cloud에서 컨테이너를 제거하십시오.

1. `cf ic ps`(현재 실행 중인 컨테이너 나열)
2. `cf ic stop container_id`(컨테이너 중지)
3. `cf ic rm container_id`(컨테이너 제거)

IBM Cloud 레지스트리에서 이미지 이름을 제거하려면 다음 cf ic 명령을 실행하십시오.

1. `cf ic images`(레지스트리의 이미지 나열)
2. `cf ic rmi image_id`(레지스트리에서 이미지 제거)

## IBM Cloud에서 데이터베이스 서비스 구성 제거
{: #removing-the-database-service-configuration-from-bluemix }
{{ site.data.keys.mf_server }} 이미지 구성 중에 **prepareserverdbs.sh** 스크립트를 실행한 경우 {{ site.data.keys.mf_server }}에 필요한 구성과 데이터베이스 테이블이 작성됩니다. 이 스크립트는 컨테이너의 데이터베이스 스키마도 작성합니다.

IBM Cloud에서 데이터베이스 서비스 구성을 제거하려면 IBM Cloud 대시보드를 사용하여 다음 프로시저를 수행하십시오.

1. IBM Cloud 대시보드에서 사용한 dashDB 서비스를 선택하십시오. **prepareserverdbs.sh** 스크립트를 실행하는 동안 매개변수로 제공한 dashDB 서비스 이름을 선택하십시오.
2. dashDB 콘솔을 실행하여 선택한 dashDB 서비스 인스턴스의 스키마와 데이터베이스 오브젝트에 대한 작업을 수행하십시오.
3. IBM {{ site.data.keys.mf_server }} 구성과 관련된 스키마를 선택하십시오. 스키마 이름은 **prepareserverdbs.sh** 스크립트를 실행하는 동안 매개변수로 제공한 이름입니다.
4. 스키마 이름과 그 아래의 오브젝트를 신중히 검사한 후 각 스키마를 삭제하십시오. IBM Cloud에서 데이터베이스 구성이 제거됩니다.

마찬가지로 {{ site.data.keys.mf_app_center }} 구성 중에 **prepareappcenterdbs.sh**를 실행한 경우에도 위 단계에 따라 IBM Cloud에서 데이터베이스 서비스 구성을 제거하십시오.
