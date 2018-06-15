---
layout: tutorial
title: IBM Cloud Kubernetes Cluster에서 MobileFirst Server 설정
breadcrumb_title: Mobile Foundation on Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM Cloud에서 {{ site.data.keys.mf_server }} 인스턴스와 {{ site.data.keys.mf_analytics }} 인스턴스를 구성하려면 아래의 지시사항을 수행하십시오. 이를 달성하기 위해 다음 단계를 수행합니다.

* 표준(유료 클러스터)의 Kubernetes Cluster 유형을 작성하십시오.
* 필수 도구(Docker, Cloud Foundry CLI( cf ), IBM Cloud CLI( bx ), IBM Cloud CLI를 위한 Container Service 플러그인( bx cs ), IBM Cloud CLI를 위한 Container Registry 플러그인( bx cr ), Kubernetes CLI(kubectl))를 사용하여 호스트 컴퓨터를 설정하십시오. 
* {{ site.data.keys.mf_server }} Docker 이미지를 빌드하여 IBM Cloud 저장소에 푸시하십시오. 
* 마지막으로, Kubernetes Cluster에 Docker 이미지를 실행하십시오.

>**참고:**  
>
* Windows OS는 현재 이와 같은 스크립트 실행에 지원되지 않습니다.  
* IBM Containers에 배치하는 데 {{ site.data.keys.mf_server }} 구성 도구를 사용할 수 없습니다.

#### 다음으로 이동:
{: #jump-to }
* [IBM Cloud에서 계정 등록](#register-an-account-on-ibmcloud)
* [호스트 시스템 설정](#set-up-your-host-machine)
* [IBM Cloud Container Service를 사용하여 Kubernetes Cluster 작성 및 설정](#setup-kube-cluster)
* [{{ site.data.keys.mf_bm_pkg_name }} 아카이브 다운로드](#download-the-ibm-mfpf-container-8000-archive)
* [전제조건](#prerequisites)
* [IBM Containers를 사용하여 Kubernetes Cluster에서 {{ site.data.keys.product_adj }} 및 Analytics Servers 설정](#setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers)
* [{{ site.data.keys.mf_server }} 수정사항 적용](#applying-mobilefirst-server-fixes)
* [IBM Cloud에서 Kubernetes 배치 제거](#removing-kube-deployments)
* [IBM Cloud에서 데이터베이스 서비스 구성 제거](#removing-the-database-service-configuration-from-ibmcloud)

## IBM Cloud에서 계정 등록
{: #register-an-account-on-ibmcloud }
아직 계정이 없는 경우 [IBM Cloud 웹 사이트](https://bluemix.net)를 방문하여 **무료로 시작하기** 또는 **등록**을 클릭하십시오. 다음 단계로 이동하려면 먼저 등록 양식에 입력해야 합니다.

### IBM Cloud 대시보드
{: #the-ibmcloud-dashboard }
IBM Cloud에 로그인하면 활성 IBM Cloud **영역**의 개요를 제공하는 IBM Cloud 대시보드가 표시됩니다. 기본적으로 이 작업 영역의 이름은 "dev"입니다. 필요한 경우 여러 작업 영역/영역을 작성할 수 있습니다.

## 호스트 시스템 설정
{: #set-up-your-host-machine }
컨테이너와 이미지를 관리하려면 다음 도구를 설치해야 합니다.
* Docker
* IBM Cloud CLI(bx)
* IBM Cloud CLI를 위한 Container Service 플러그인( bx cs )
* IBM Cloud CLI를 위한 Container Registry 플러그인( bx cr )
* Kubernetes CLI(kubectl)

[전제조건 CLI를 설정하기 위한 단계](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps)를 확인하려면 IBM Cloud 문서를 참조하십시오. 

## IBM Cloud Container Service를 사용하여 Kubernetes Cluster 작성 및 설정
{: #setup-kube-cluster}
[IBM Cloud에서 Kubernetes Cluster를 설정](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli)하려면 IBM Cloud 문서를 참조하십시오.

>**참고:** {{ site.data.keys.mf_bm_short }}을 배치하는 경우 표준(유료 클러스터)의 Kubernetes Cluster 유형이 필요합니다.

## {{ site.data.keys.mf_bm_pkg_name }} 아카이브 다운로드
{: #download-the-ibm-mfpf-container-8000-archive}
IBM Cloud Containers를 사용하여 Kubernetes Cluster로 {{ site.data.keys.mf_bm_short }}을 설정하려면 나중에 IBM Cloud에 푸시할 이미지를 먼저 작성해야 합니다. <br/>
[IBM Fix Central](http://www.ibm.com/support/fixcentral)에서 IBM Containers의 MobileFirst Server에 대한 임시 수정사항을 얻을 수 있습니다.<br/>
Fix Central에서 최신 임시 수정사항을 다운로드하십시오. Kubernetes 지원은 iFix **8.0.0.0-IF201707051849**에서 가능합니다.

아카이브 파일에는 이미지를 빌드하는 데 필요한 파일(**dependencies** 및 **mfpf-libs**)과 Kubernetes에서 {{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 빌드하고 배치하는 데 필요한 파일(bmx-kubenetes)이 있습니다.

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>클릭하면 사용할 아카이브 파일 컨텐츠와 사용 가능한 환경 특성에 대해 자세히 볼 수 있습니다.</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="아카이브 파일의 파일 시스템 구조를 표시하는 이미지" style="float:right;width:570px"/>
                <h4>bmx-kubernetes 폴더</h4>
                <p>IBM Cloud Container Service를 사용하여 Kubernetes Cluster에 배치하는 데 필요한 사용자 정의 파일 및 스크립트가 들어 있습니다. </p>

                <h4>Dockerfile-mfpf-analytics 및 Dockerfile-mfpf-server</h4>

                <ul>
                    <li><b>Dockerfile-mfpf-server</b>: {{ site.data.keys.mf_server }} 이미지를 빌드하는 데 필요한 모든 명령을 포함하는 텍스트 문서입니다.</li>
                    <li><b>Dockerfile-mfpf-analytics</b>: {{ site.data.keys.mf_analytics }} 이미지를 빌드하는 데 필요한 모든 명령을 포함하는 텍스트 문서입니다.</li>
                    <li><b>scripts</b> 폴더: 이 폴더에는 구성 파일 세트가 포함된 <b>args</b> 폴더가 들어 있습니다. 또한 IBM Cloud에 로그인하고 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 이미지를 빌드하며 IBM Cloud에서 이미지를 푸시하고 실행하는 데 필요한 스크립트가 들어 있습니다. 스크립트를 대화식으로 실행하거나 구성 파일을 현상태대로 사전 구성하여 실행할 수 있습니다(나중에 자세히 설명함). 사용자 정의할 수 있는 args/*.properties 파일 외에는 이 폴더의 요소를 수정하지 마십시오. 스크립트 사용법 도움말을 보려면 <code>-h</code> 또는 <code>--help</code> 명령행 인수를 사용하십시오(예: <code>scriptname.sh --help</code>).</li>
                    <li><b>usr-mfpf-server</b> 및 <b>usr-mfpf-analytics</b> 폴더:
                        <ul>
                            <li><b>bin</b> 폴더: 컨테이너 시작 시 실행되는 스크립트 파일(mfp-init)이 들어 있습니다. 사용자 고유의 사용자 정의 코드를 추가하여 실행할 수 있습니다.</li>
                            <li><b>config</b> 폴더: {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }}에서 사용되는 서버 구성 단편(키 저장소, 서버 특성, 사용자 레지스트리)이 들어 있습니다.</li>
                            <li><b>keystore.xml</b> - SSL 암호화에 사용되는 보안 인증서 저장소의 구성입니다. 나열된 파일을 ./usr/security 폴더에서 참조해야 합니다.</li>
                            <li><b>ltpa.xml</b> - LTPA 키와 비밀번호를 정의하는 구성 파일입니다.</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }}와 {{ site.data.keys.mf_analytics }}의 구성 특성입니다. 다음 문서 주제에 나열된 지원되는 특성을 참조하십시오.
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a></li>
                                </ul>
                            </li>
                            <li><b>mfpfsqldb.xml</b> - DB2 또는 dashDB 데이터베이스에 연결하는 JDBC Data 소스 정의입니다.</li>
                            <li><b>registry.xml</b> - 사용자 레지스트리 구성입니다. basicRegistry(기본 XML 기반 사용자 레지스트리) 구성이 기본값으로 제공됩니다. basicRegistry에 사용할 사용자 이름과 비밀번호를 구성하거나 ldapRegistry를 구성할 수 있습니다.</li>
                            <li><b>tracespec.xml</b> - 디버깅 및 로깅 레벨을 사용으로 설정하는 추적 스펙입니다.</li>
                        </ul>
                    </li>
                    <li><b>jre-security</b> 폴더: JRE 보안 관련 파일(신뢰 저장소, 정책 JAR 파일 등)을 이 폴더에 저장하여 해당 파일을 업데이트할 수 있습니다. 이 폴더의 파일은 컨테이너의 <b>JAVA_HOME/jre/lib/security/</b> 폴더에 복사됩니다.</li>
                    <li><b>security</b> 폴더: 키 저장소, 신뢰 저장소, LTPA 키 파일(ltpa.keys)을 저장하는 데 사용됩니다.</li>
                    <li><b>env</b> 폴더: 서버 초기화에 사용되는 환경 특성(server.env)과 사용자 정의 JVM 옵션(jvm.options)이 들어 있습니다.</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
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
                    <li><b>dependencies</b> 폴더: {{ site.data.keys.mf_bm_short }} 런타임과 IBM Java JRE 8을 포함합니다.</li>
                    <li><b>mfpf-libs folder</b> 폴더: {{ site.data.keys.product_adj }} 제품 컴포넌트 라이브러리와 CLI를 포함합니다.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>섹션 닫기</b></a>
            </div>
        </div>
    </div>
</div>

## 전제조건
{: #prerequisites }

Kubernetes에 대한 실용적인 지식이 있어야 합니다. 자세한 내용은 [Kubernetes 문서](https://kubernetes.io/docs/concepts/)를 참조하십시오.


## IBM Containers를 사용하여 Kubernetes Cluster에서 {{ site.data.keys.product_adj }} 및 Analytics Servers 설정
{: #setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers }
위에서 설명한 대로 스크립트를 대화식으로 또는 구성 파일을 사용하여 실행할 수 있습니다.

* **구성 파일 사용** - 스크립트를 실행하고 각 구성 파일을 인수로 전달합니다.
* **대화식** - 인수 없이 스크립트를 실행합니다.

>**참고:** 스크립트를 대화식으로 실행할 경우 구성을 건너뛸 수 있지만 제공해야 하는 인수에 대해 읽고 이해해야 합니다.

대화식으로 실행하는 경우 제공된 인수의 사본은 `./recorded-args/` 디렉토리에 저장됩니다. 따라서 처음으로 대화식 모드를 사용할 수 있고 이후 배치를 위한 참조로 특성 파일을 재사용할 수 있습니다.

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">구성 파일 사용</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <b>args</b> 폴더에는 스크립트를 실행하는 데 필요한 인수가 포함된 구성 파일 세트가 들어 있습니다.  다음 파일의 인수 값을 채우십시오.<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_API_URL - </b>배치하려는 지역 또는 영역입니다. <br>
                      <blockquote>예: <i>api.ng.bluemix.net</i>(미국), <i>api.eu-de.bluemix.net</i>(독일), <i>api.au-syd.bluemix.net</i>(시드니)</blockquote>
                    </li>
                    <li><b>IBM_CLOUD_ACCOUNT_ID - </b>영숫자 값으로 된 사용자의 계정 ID입니다(예: <i>a1b1b111d11e1a11d1fa1cc999999999</i>). <br>	계정 ID를 가져오려면 <code>bx target</code> 명령을 사용하십시오.</li>
                    <li><b>IBM_CLOUD_USER - </b>IBM Cloud 사용자 이름(이메일)입니다.</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>IBM Cloud 비밀번호입니다.</li>
                    <li><b>IBM_CLOUD_ORG - </b>IBM Cloud 조직 이름입니다.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>IBM Cloud 영역(앞서 설명함)입니다.</li>
                </ul><br/>
                <h4>prepareserverdbs.properties</h4>
                {{ site.data.keys.mf_bm_short }} 서비스에는 외부 <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 on Cloud</i></a> 인스턴스가 필요합니다.<br/>
                <blockquote><b>참고:</b> 사용자 고유의 DB2 데이터베이스도 사용할 수 있습니다. 데이터베이스에 연결하도록 IBM Cloud Kubenetes Cluster를 구성해야 합니다. </blockquote>
                DB2 인스턴스를 설정한 후 다음과 같은 필수 인수를 제공하십시오.
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i>(DB2 on Cloud를 사용하는 경우) 또는 <i>DB2</i>(사용자 고유의 DB2 데이터베이스를 사용하는 경우)입니다.</li>
                    <li>사용자 고유의 DB2 데이터베이스(예: DB_TYPE=DB2)를 사용 중인 경우 다음 항목을 제공하십시오.
                      <ul><li><b>DB2_HOST</b> - DB2 설정의 호스트 이름입니다.</li>
                          <li><b>DB2_DATABASE</b> - 데이터베이스의 이름입니다.</li>
                          <li><b>DB2_PORT</b> - 데이터베이스에 연결하는 포트입니다.</li>
                          <li><b>DB2_USERNAME</b> - 데이터베이스 사용자(제공된 스키마 내의 테이블을 작성할 수 있는 권한이 있어야 하는 사용자 또는 스키마를 작성할 수 있어야 하는 사용자(스키마가 아직 존재하지 않는 경우))입니다.</li>
                          <li><b>DB2_PASSWORD</b> - DB2 사용자의 비밀번호입니다.</li>
                      </ul>
                    </li>
                    <li>DB2 on Cloud(예: DB_TYPE=dashDB)를 사용 중인 경우 다음 항목을 제공하십시오.
                      <ul><li><b>ADMIN_DB_SRV_NAME</b> - 관리 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다.</li>
                          <li><b>RUNTIME_DB_SRV_NAME</b> - 런타임 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다. 기본값은 관리 서비스 이름입니다.</li>
                          <li><b>PUSH_DB_SRV_NAME</b> - 런타임 데이터를 저장하는 데 사용할 dashDB 서비스 인스턴스 이름입니다. 기본값은 관리 서비스 이름입니다.</li>
                      </ul>
                    </li>
                    <li><b>ADMIN_SCHEMA_NAME</b> - 관리 데이터의 스키마 이름입니다. 기본값은 <i>MFPDATA</i>입니다.</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>런타임 데이터의 스키마 이름입니다. 기본값은 <i>MFPDATA</i>입니다.</li>
                    <li><b>PUSH_SCHEMA_NAME - </b>런타임 데이터의 스키마 이름입니다. 기본값은 <i>MFPDATA</i>입니다.</li>
                    <blockquote><b>참고:</b> 여러 사용자 또는 다중 {{ site.data.keys.mf_bm_short }} 배치에서 DB2 데이터베이스 서비스 인스턴스를 공유 중인 경우 고유 스키마 이름을 제공하십시오.</blockquote>
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - 이미지에 대한 태그입니다. <em>registry-url/namespace/image:tag</em> 양식이어야 합니다.</li>
                  <li><b>ANALYTICS_IMAGE_TAG</b> - 이미지에 대한 태그입니다. <em>registry-url/namespace/image:tag</em> 양식이어야 합니다.</li>
                  <blockquote>예: <em>registry.ng.bluemix.net/myuniquenamespace/mymfpserver:v1</em><br/>아직 Docker 레지스트리 네임스페이스를 작성하지 않은 경우 다음 명령 중 하나를 사용하여 레지스트리 네임스페이스를 작성하십시오.<br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
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

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>다음 지시사항은 구성 파일을 사용하여 스크립트를 실행하는 방법을 보여줍니다. 대화식 모드에서 선택해야 하는 명령행 인수의 목록도 사용 가능합니다.</p>

            <ol>
                <li><b>initenv.sh – IBM Cloud에 로그인</b><br />
                    IBM Containers에서 {{ site.data.keys.mf_bm_short }}을 빌드하고 실행하는 데 필요한 환경을 작성하려면 <b>initenv.sh</b> 스크립트를 실행하십시오.
                    <b>대화식 모드</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>비대화식 모드</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareserverdbs.sh - {{ site.data.keys.mf_server }} 데이터베이스 준비</b><br />
                    <b>prepareserverdbs.sh</b> 스크립트는 DB2 데이터베이스 서비스를 사용해서 {{ site.data.keys.mf_server }}를 구성하는 데 사용됩니다. 1단계에서 로그인한 조직과 영역에서 DB2 서비스의 서비스 인스턴스를 사용할 수 있어야 합니다. 다음을 실행하십시오.
                    <b>대화식 모드</b>
{% highlight bash %}
./prepareserverdbs.sh
{% endhighlight %}
                    <b>비대화식 모드</b>
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh(선택사항) – IBM Cloud에 로그인</b><br />
                      이 단계는 DB2 서비스 인스턴스를 사용할 수 있는 조직과 영역 이외의 조직과 영역에서 컨테이너를 작성해야 하는 경우에만 필수입니다. 값이 예인 경우에는 컨테이너가 작성되고 시작되어야 하는 새 조직과 영역으로 initenv.properties를 업데이트하고 <b>initenv.sh</b> 스크립트를 다시 실행하십시오.
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - {{ site.data.keys.mf_server }} 이미지 준비</b><br />
                    {{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }} 이미지를 빌드하여 IBM Cloud 저장소에 푸시하려면 <b>prepareserver.sh</b> 스크립트를 실행하십시오. IBM Cloud 저장소에서 사용할 수 있는 모든 이미지를 보려면 <code>bx cr image-list</code>를 실행하십시오. <br/>
                    목록은 이미지 이름, 작성 날짜, ID를 포함합니다.<br/>
                    <b>대화식 모드</b>
{% highlight bash %}
./prepareserver.sh
{% endhighlight %}
                    <b>비대화식 모드</b>
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                </li>
                <li>IBM Cloud Container Service를 사용하여 Kubernetes 클러스터의 Docker 컨테이너에 {{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 배치하십시오.
                <ol>
                  <li>터미널 컨텍스트를 클러스터에 설정하십시오.<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  클러스터 이름을 확인하려면 다음 명령을 실행하십시오. <br/><code>bx cs clusters</code><br/>
                  출력에서 구성 파일에 대한 경로는 환경 변수를 설정하는 명령으로 표시됩니다. 예를 들면, 다음과 같습니다.<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  <em>my-cluster</em>를 클러스터 이름으로 대체한 후 위의 명령을 복사하고 붙여넣어 터미널에서 환경 변수를 설정하고 <b>Enter</b>를 누르십시오.
                  </li>
                  <li><b>[{{ site.data.keys.mf_analytics }}의 경우 필수]: </b> <b>지속적 볼륨 클레임</b>을 작성하십시오. 이는 지속적 분석 데이터에 사용됩니다. 일회성 단계입니다. 이전에 이미 작성한 경우 <b>PVC</b>를 재사용할 수 있습니다. <em>yaml</em> 파일 <b>args/mfpf-persistent-volume-claim.yaml</b>을 편집한 후 명령을 실행하십시오.
                  다음 <em>kubectl</em> 명령을 실행하기 전에 모든 변수가 해당 값으로 대체되어야 합니다.<br/><code>kubectl create -f ./args/mfpf-persistent-volume-claim.yaml</code><br/>
                  후속 단계에서 제공해야 하므로 <b>지속적 볼륨 클레임</b>의 이름을 기록하십시오.
                  </li>
                  <li><b>수신 도메인</b>을 가져오려면 다음 명령을 실행하십시오.<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   수신 도메인을 기록하십시오. TLS를 구성해야 하는 경우 <b>수신 시크릿</b>을 기록하십시오.</li>
                  <li>Kubernetes 배치를 작성하십시오.<br/>yaml 파일인 <b>args/mfpf-deployment-all.yaml</b>을 편집하고 세부사항을 채우십시오. <em>kubectl</em> 명령을 실행하기 전에 모든 변수가 해당 값으로 대체되어야 합니다.<br/>
                  <b>./args/mfpf-deployment-all.yaml</b>에는 다음 항목에 대한 배치가 포함됩니다.
                  <ul>
                    <li>{{ site.data.keys.mf_server }}의 Kubernetes 배치: 세 개의 인스턴스(복제본), 1024MB 메모리 및 1Core CPU로 구성.</li>
                    <li>{{ site.data.keys.mf_analytics }}의 Kubernetes 배치: 두 개의 인스턴스(복제본), 1024MB 메모리 및 1Core CPU로 구성.</li>
                    <li>{{ site.data.keys.mf_server }}의 Kubernetes 서비스.</li>
                    <li>{{ site.data.keys.mf_analytics }}의 Kubernetes 서비스.</li>
                    <li>{{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}에 대한 모든 REST 엔드포인트를 포함하는 전체 설정에 대한 수신(ingress).</li>
                    <li>{{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }} 인스턴스에서 환경 변수를 사용할 수 있도록 하는 configMap.</li>
                  </ul>
                  YAML 파일에서 다음 값을 편집해야 합니다.<br/>
                    <ol><li>위에 설명된 대로 <code>bx cs cluster-get</code> 명령의 출력과는 다른 <em>my-cluster.us-south.containers.mybluemix.net</em>의 발생(<b>수신 도메인</b>의 출력 사용)</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpfanalytics:latest</em> 및 <em>registry.ng.bluemix.net/repository/mfpfserver:latest</em> - 이미지를 업로드하기 위해 prepareserver.sh에서 사용한 동일한 이름을 사용하십시오.</li>
                    <li><b>claimName</b>: <em>mfppvc</em> - PVC를 작성하기 위해 위에서 사용한 대로 동일한 지속적 볼륨 클레임 이름을 사용하십시오.<br/></li>
                    </ol>
                    다음 명령을 실행하십시오.<br/>
                    <code>kubectl create -f ./args/mfpf-deployment-all.yaml</code>
                    <blockquote><b>참고:<br/></b>다음 템플리트 yaml 파일이 제공됩니다.<br/>
                    <ul><li><b>mfpf-deployment-all.yaml</b>: http를 사용하여 {{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 배치합니다.</li>
                      <li><b>mfpf-deployment-all-tls.yaml</b>: http를 사용하여 {{ site.data.keys.mf_server }} 및 {{ site.data.keys.mf_analytics }}를 배치합니다.</li>
                      <li><b>mfpf-deployment-server.yaml</b>: http를 사용하여 {{ site.data.keys.mf_server }}를 배치합니다.</li>
                      <li><b>mfpf-deployment-analytics.yaml</b>: http를 사용하여 {{ site.data.keys.mf_analytics }}를 배치합니다.</li></ul></blockquote>
                      작성 후 Kubernetes 대시보드를 사용하려면 다음 명령을 실행하십시오.<br/>
                      <code>kubectl proxy</code><br/>브라우저에서 <b>localhost:8001/ui</b>를 여십시오.
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>

IBM Cloud에서 {{ site.data.keys.mf_server }}가 실행되면 애플리케이션 개발을 시작할 수 있습니다. {{ site.data.keys.product }} [학습서](../../all-tutorials)를 검토하십시오.


## {{ site.data.keys.mf_server }} 수정사항 적용
{: #applying-mobilefirst-server-fixes }

[IBM Fix Central](http://www.ibm.com/support/fixcentral)에서 IBM Containers의 {{ site.data.keys.mf_server }}에 대한 임시 수정사항을 얻을 수 있습니다.  
임시 수정사항을 적용하기 전에 기존 구성 파일을 백업하십시오. 구성 파일은 다음 폴더에 있습니다.
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry 애플리케이션: **package_root/bmx-kubernetes/usr-mfpf-server**

### iFix 적용 단계:

1. 임시 수정사항 아카이브를 다운로드하고 기존 설치 폴더에 컨텐츠의 압축을 풀어 기존 파일을 겹쳐쓰십시오.
2. 백업한 구성 파일을 **package_root/bmx-kubernetes/usr-mfpf-server** 및 **package_root/bmx-kubernetes/usr-mfpf-analytics** 폴더에 복원하여 새로 설치된 구성 파일을 겹쳐쓰십시오.
3. 편집기에서 **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** 파일을 편집하고 다음 행이 있는 경우 제거하십시오.
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    이제 업데이트된 서버를 빌드하고 배치할 수 있습니다.

    a. 서버 이미지를 다시 빌드한 후 IBM Containers 서비스로 푸시하려면 `prepareserver.sh` 스크립트를 실행하십시오.

    b. 다음 명령을 실행하여 롤링 업데이트를 실행하십시오.
      <code>kubectl rolling-update NAME -f FILE</code>

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## IBM Cloud에서 Kubernetes 배치 제거
{: #removing-kube-deployments}

IBM Cloud Kubernetes 클러스터에서 배치된 인스턴스를 제거하려면 다음 명령을 실행하십시오. 

`kubectl delete -f mfpf-deployment-all.yaml`(yaml에 정의된 모든 Kubernetes 유형 제거)

IBM Cloud 레지스트리에서 이미지 이름을 제거하려면 다음 명령을 실행하십시오. 
```bash
bx cr image-list(레지스트리의 이미지 나열)
bx cr image-rm image-name(레지스트리에서 이미지 제거)
```

## IBM Cloud에서 데이터베이스 서비스 구성 제거
{: #removing-the-database-service-configuration-from-ibmcloud }
{{ site.data.keys.mf_server }} 이미지 구성 중에 **prepareserverdbs.sh** 스크립트를 실행한 경우 {{ site.data.keys.mf_server }}에 필요한 구성과 데이터베이스 테이블이 작성됩니다. 이 스크립트는 컨테이너의 데이터베이스 스키마도 작성합니다.

IBM Cloud에서 데이터베이스 서비스 구성을 제거하려면 IBM Cloud 대시보드를 사용하여 다음 프로시저를 수행하십시오. 

1. IBM Cloud 대시보드에서 사용한 DB2 on Cloud 서비스를 선택하십시오. **prepareserverdbs.sh** 스크립트를 실행하는 동안 매개변수로 제공한 DB2 서비스 이름을 선택하십시오.
2. DB2 콘솔을 실행하여 선택한 DB2 서비스 인스턴스의 스키마와 데이터베이스 오브젝트에 대한 작업을 수행하십시오.
3. IBM {{ site.data.keys.mf_server }} 구성과 관련된 스키마를 선택하십시오. 스키마 이름은 **prepareserverdbs.sh** 스크립트를 실행하는 동안 매개변수로 제공한 이름입니다.
4. 스키마 이름과 그 아래의 오브젝트를 신중히 검사한 후 각 스키마를 삭제하십시오. IBM Cloud에서 데이터베이스 구성이 제거됩니다. 
