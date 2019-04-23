---
layout: tutorial
title: 애플리케이션 서버에 MobileFirst Server 설치
breadcrumb_title: Installing MobileFirst Server to an application server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
컴포넌트 설치는 Ant 태스크 또는 Server Configuration Tool을 사용하거나 수동으로 수행할 수 있습니다. 애플리케이션 서버에 컴포넌트를 성공적으로 설치할 수 있도록 설치 프로세스에 대한 전제조건 및 세부사항을 파악하십시오.

애플리케이션 서버에 대한 컴포넌트 설치를 계속 진행하기 전에 컴포넌트에 대한 데이터베이스 및 테이블을 사용할 준비가 되었는지 확인하십시오. 자세한 정보는 [데이터베이스 설정](../databases)을 참조하십시오.

컴포넌트를 설치할 서버 토폴로지도 정의해야 합니다. [토폴로지 및 네트워크 플로우](../topologies)를 참조하십시오.

#### 다음으로 이동
{: #jump-to }

* [애플리케이션 서버 전제조건](#application-server-prerequisites)
* [Server Configuration Tool을 사용한 설치](#installing-with-the-server-configuration-tool)
* [Ant 태스크를 사용한 설치](#installing-with-ant-tasks)
* [{{ site.data.keys.mf_server }} 컴포넌트 수동 설치](#installing-the-mobilefirst-server-components-manually)
* [서버 팜 설치](#installing-a-server-farm)

## 애플리케이션 서버 전제조건
{: #application-server-prerequisites }
선택한 애플리케이션 서버에 따라 다음 주제 중 하나를 선택하여 {{ site.data.keys.mf_server }} 컴포넌트 설치 전에 이행해야 하는 전제조건을 파악하십시오.

* [Apache Tomcat 전제조건](#apache-tomcat-prerequisites)
* [WebSphere Application Server Liberty 전제조건](#websphere-application-server-liberty-prerequisites)
* [WebSphere Application Server 및 WebSphere Application Server Network Deployment 전제조건](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Apache Tomcat 전제조건
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }}에는 다음과 같은 주제에 자세히 설명되어 있는 Apache Tomcat 구성에 대한 일부 요구사항이 있습니다.  
다음 기준을 충족하는지 확인하십시오.

* 지원되는 Apache Tomcat 버전을 사용합니다. [시스템 요구사항](../../../../product-overview/requirements)을 참조하십시오.
* Apache Tomcat은 JRE 7.0 이상과 함께 실행되어야 합니다.
* 관리 서비스와 런타임 컴포넌트 사이의 통신을 허용하기 위해 JMX 구성을 사용할 수 있어야 합니다. 이 통신에서는 아래의 **Apache Tomcat을 위한 JMX 연결 구성**에 설명된 대로 RMI를 사용합니다.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Apache Tomcat을 위한 JMX 연결 구성에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Apache Tomcat 애플리케이션 서버를 위한 보안 JMX 연결을 구성해야 합니다.</p>
                <p>Server Configuration Tool 및 Ant 태스크는 기본 보안 JMX 연결을 구성할 수 있으며 여기에는 JMX 원격 포트의 정의 및 인증 특성의 정의가 포함됩니다. 이들은 <b>tomcat_install_dir/bin/setenv.bat</b> 및 <b>tomcat_install_dir/bin/setenv.sh</b>를 수정하여 이 옵션을 <b>CATALINA_OPTS</b>에 추가합니다.</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>참고:</b> 8686이 기본값입니다. 컴퓨터에서 이 포트를 사용할 수 없으면 이 포트의 값을 변경할 수 있습니다.</p>

                <ul>
                    <li><b>tomcat_install_dir/bin/startup.bat</b> 또는 <b>tomcat_install_dir/bin/catalina.bat</b>를 사용하여 Apache Tomcat을 시작하는 경우 <b>setenv.bat</b> 파일이 사용됩니다.</li>
                    <li><b>tomcatInstallDir/bin/startup.sh</b> 또는 <b>tomcat_install_dir/bin/catalina.sh</b>를 사용하여 Apach Tomcat을 시작하는 경우 <b>setenv.sh</b> 파일이 사용됩니다.</li>
                </ul>

                <p>다른 명령을 사용하여 Apache Tomcat을 시작하는 경우에는 이 파일이 사용되지 않습니다. Apache Tomcat Windows Service Installer를 설치한 경우에는 서비스 실행기가 <b>setenv.bat</b>를 사용하지 않습니다.</p>

                <blockquote><b>중요:</b> 이 구성은 기본적으로 안전하지 않습니다. 구성에 보안을 설정하려면 다음 프로시저의 2단계 및 3단계를 수동으로 완료해야 합니다.</blockquote>

                <p>Apache Tomcat 수동 구성:</p>

                <ol>
                    <li>단순 구성의 경우에는 다음과 같은 옵션을 <b>CATALINA_OPTS</b>에 추가하십시오.

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>인증을 활성화하려면 Apache Tomcat 사용자 문서 <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL 지원 - BIO 및 NIO</a>와 <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL 구성 방법</a>을 참조하십시오.</li>
                    <li>SSL이 사용으로 설정된 JMX 구성의 경우 다음과 같은 옵션을 추가하십시오.
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<key store location>
-Djavax.net.ssl.trustStorePassword=<key store password>
-Djavax.net.ssl.trustStoreType=<key store type>
-Djavax.net.ssl.keyStore=<key store location>
-Djavax.net.ssl.keyStorePassword=<key store password>
-Djavax.net.ssl.keyStoreType=<key store type>
{% endhighlight %}

                    <b>참고:</b> 포트 8686은 변경될 수 있습니다.</li>
                    <li>
                        <p>Tomcat 인스턴스가 방화벽 뒤에서 실행 중인 경우에는 JMX 원격 라이프사이클 리스너를 구성해야 합니다. <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX 원격 라이프사이클 리스너</a>에 대해서는 Apache Tomcat 문서를 참조하십시오.</p><p>다음 예에서와 같이 다음과 같은 환경 특성도 <b>server.xml</b> 파일에서 관리 서비스 애플리케이션의 컨텍스트 섹션에 추가해야 합니다.</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="registryPort" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="serverPort" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        이전 예에서:
                        <ul>
                            <li>registryPort는 JMX 원격 라이프사이클 리스너의 <b>rmiRegistryPortPlatform</b> 속성과 동일한 값을 가져야 합니다.</li>
                            <li>serverPort는 JMX 원격 라이프사이클 리스너의 <b>rmiServerPortPlatform</b> 속성과 동일한 값을 가져야 합니다.</li>
                        </ul>
                    </li>
                    <li><b>CATALINA_OPTS</b>에 옵션을 추가하는 대신 Apache Tomcat Windows Service Installer를 사용하여 Apache Tomcat을 설치한 경우에는 <b>tomcat_install_dir/bin/Tomcat7w.exe</b>를 실행하고 특성 창의 <b>Java</b> 탭에서 옵션을 추가하십시오.

                    <img alt="Apache Tomcat 7 특성" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty 전제조건
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }}에는 다음과 같은 주제에 자세히 설명되어 있는 Liberty 서버의 구성에 대한 일부 요구사항이 있습니다.  

다음 기준을 충족하는지 확인하십시오.

* 지원되는 Liberty 버전을 사용합니다. [시스템 요구사항](../../../../product-overview/requirements)을 참조하십시오.
* Liberty는 JRE 7.0 이상과 함께 실행되어야 합니다. JRE 6.0은 지원되지 않습니다.
* 일부 Liberty 버전은 Java EE 6와 Java EE 7의 기능을 모두 지원합니다. 예를 들어, jdbc-4.0 Liberty 기능은 Java EE 6의 일부인 반면 jdbc-4.1 Liberty 기능은 Java EE 7의 일부입니다. {{ site.data.keys.mf_server }} V8.0.0은 Java EE 6 또는 Java EE 7 기능과 함께 설치될 수 있습니다. 하지만 {{ site.data.keys.mf_server }}의 이전 버전을 동일한 Liberty 서버에서 실행하려면 Java EE 6 기능을 사용해야 합니다. {{ site.data.keys.mf_server }} V7.1.0 이하는 Java EE 7 기능을 지원하지 않습니다.
* JMX는 아래의 **WebSphere Application Server Liberty 프로파일을 위한 JMX 연결 구성**에 설명된 대로 구성해야 합니다.
* 프로덕션 환경에서 설치의 경우에는 컴퓨터가 시작될 때 자동으로 {{ site.data.keys.mf_server }} 컴포넌트가 시작되도록
Liberty 서버를 Windows, Linux 또는 UNIX 시스템에서 서비스로 시작할 수 있습니다.
Liberty 서버를 실행하는 프로세스는 프로세스를 시작한 사용자가 로그아웃할 때 중지되지 않습니다.
* {{ site.data.keys.mf_server }} V8.0.0은 이전 버전의 배치된 {{ site.data.keys.mf_server }} 컴포넌트가 포함된 Liberty 서버에 배치할 수 없습니다.
* Liberty Collective 환경에서 설치의 경우 Liberty Collective 제어기 및 Liberty Collective 클러스터 멤버를 [Liberty Collective 구성](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc)에 설명된 대로 구성해야 합니다.

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>WebSphere Application Server Liberty 프로파일을 위한 JMX 연결 구성에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }}를 사용하려면 보안 JMX 연결을 구성해야 합니다.</p>

                <ul>
                    <li>Server Configuration Tool 및 Ant 태스크는 기본 보안 JMX 연결을 구성할 수 있으며 여기에는 유효 기간이 365일인 자체 서명된 SSL 인증서 생성이 포함됩니다. 이 구성은 프로덕션 용도가 아닙니다.</li>
                    <li>프로덕션용으로 보안 JMX 연결을 구성하려면 <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Liberty 프로파일에 대한 보안 JMX 연결 구성</a>에 설명된 대로 지시사항을 수행하십시오.</li>
                    <li>rest-connector는 WebSphere Application Server, Liberty Core 및 기타 Liberty 에디션에 사용할 수 있지만 Liberty 서버를 사용 가능한 기능의 서브세트와 함께 패키지할 수 있습니다. rest-connector 기능을 Liberty 설치에서 사용하려면 다음 명령을 입력하십시오.
{% highlight bash %}                    
liberty_install_dir/bin/productInfo featureInfo
{% endhighlight %}
                    <b>참고:</b> 이 명령의 출력에 restConnector-1.0이 포함되어 있는지 확인하십시오.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server 및 WebSphere Application Server Network Deployment 전제조건
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }}에는 다음과 같은 주제에 자세히 설명되어 있는 WebSphere Application Server 및 WebSphere Application Server Network Deployment의 구성에 대한 일부 요구사항이 있습니다.  
다음 기준을 충족하는지 확인하십시오.

* 지원되는 WebSphere Application Server 버전을 사용합니다. [시스템 요구사항](../../../../product-overview/requirements)을 참조하십시오.
* 애플리케이션 서버는 JRE 7.0과 함께 실행되어야 합니다. 기본적으로 WebSphere Application Server는 Java 6.0 SDK를 사용합니다. Java 7.0 SDK로 전환하려면 [WebSphere Application Server에서 Java 7.0 SDK로 전환](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html)을 참조하십시오.
* 관리 보안이 켜져 있어야 합니다. {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.mf_server }} 구성 서비스는 보안 역할에 의해 보호됩니다. 자세한 정보는 [보안 사용](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en)을 참조하십시오.
* 관리 서비스와 런타임 컴포넌트 사이의 통신을 허용하기 위해 JMX 구성을 사용할 수 있어야 합니다. 이 통신에서는 SOAP를 사용합니다. WebSphere Application Server Network Deployment의 경우 RMI를 사용할 수 있습니다. 자세한 정보는 아래의 **WebSphere Application Server 및 WebSphere Application Server Network Deployment를 위한 JMX 연결 구성**을 참조하십시오.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>WebSphere Application Server 및 WebSphere Application Server Network Deployment를 위한 JMX 연결 구성에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }}를 사용하려면 보안 JMX 연결을 구성해야 합니다.</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }}를 사용하려면 JMX 조작을 수행하기 위해 RMI 포트 또는 SOAP 포트에 액세스해야 합니다. 기본적으로 SOAP 포트는 WebSphere Application Server에서 활성 상태입니다. {{ site.data.keys.mf_server }}는 기본적으로 SOAP 포트를 사용합니다. SOAP 포트와 RMI 포트가 모두 비활성화되어 있으면 {{ site.data.keys.mf_server }}가 실행되지 않습니다.</li>
                    <li>RMI는 WebSphere Application Server Network Deployment에서만 지원됩니다. RMI는 독립형 프로파일 또는 WebSphere Application Server 서버 팜에서 지원되지 않습니다.</li>
                    <li>관리 및 애플리케이션 보안을 활성화해야 합니다.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### 파일 시스템 전제조건
{: #file-system-prerequisites }
{{ site.data.keys.mf_server }}를 애플리케이션 서버에 설치하려면 특정 파일 시스템 권한을 가진 사용자가 {{ site.data.keys.product_adj }} 설치 도구를 실행해야 합니다.  
설치 도구에는 다음이 포함됩니다.

* IBM Installation Manager
* Server Configuration Tool
* {{ site.data.keys.mf_server }}를 배치하는 데 필요한 Ant 태스크

WebSphere Application Server Liberty 프로파일의 경우 다음과 같은 조치를 수행하기 위해 필요한 권한을 가지고 있어야 합니다.

* Liberty 설치 디렉토리의 파일을 읽습니다.
* Liberty 서버의 구성 디렉토리(일반적으로 usr/servers/server-name)에서 파일을 작성하여 백업 사본을 작성하고 server.xml 및 jvm.options를 수정합니다.
* Liberty 공유 리소스 디렉토리(일반적으로 usr/shared)에서 파일 및 디렉토리를 작성합니다.
* Liberty 서버 앱 디렉토리(일반적으로 usr/servers/server-name/apps)에서 파일을 작성합니다.

WebSphere Application Server 전체 프로파일 및 WebSphere Application Server Network Deployment의 경우 다음과 같은 조치를 수행하기 위해 필요한 권한을 가지고 있어야 합니다.

* WebSphere Application Server 설치 디렉토리의 파일을 읽습니다.
* 선택한 WebSphere Application Server 전체 프로파일 또는 Deployment Manager 프로파일의 구성 파일을 읽습니다.
* wsadmin 명령을 실행합니다.
* 프로파일 구성 디렉토리에서 파일을 작성합니다. 설치 도구는 공유 라이브러리 또는 JDBC 드라이버 등의 리소스를 해당 디렉토리에 배치합니다.

Apache Tomcat의 경우 다음과 같은 조치를 수행하기 위해 필요한 권한을 가지고 있어야 합니다.

* 구성 디렉토리를 읽습니다.
* 구성 디렉토리에서 백업 파일을 작성하고 파일을 수정합니다(예: server.xml 및 tomcat-users.xml).
* bin 디렉토리에서 백업 파일을 작성하고 파일을 수정합니다(예: setenv.bat).
* lib 디렉토리에서 파일을 작성합니다.
* webapps 디렉토리에서 파일을 작성합니다.

이 모든 애플리케이션 서버의 경우 애플리케이션 서버를 실행하는 사용자는 {{ site.data.keys.product_adj }} 설치 도구를 실행한 사용자가 작성한 파일을 읽을 수 있어야 합니다.

## Server Configuration Tool을 사용한 설치
{: #installing-with-the-server-configuration-tool }
Server Configuration Tool을 사용하여 {{ site.data.keys.mf_server }} 컴포넌트를 애플리케이션 서버에 설치하십시오.

Server Configuration Tool은 데이터베이스를 설정하고 컴포넌트를 애플리케이션 서버에 설치할 수 있습니다. 이 도구는 단일 사용자를 위한 것입니다. 구성 파일은 디스크에 저장됩니다. 구성 파일이 저장되는 디렉토리는 메뉴 **파일 → 환경 설정**을 사용하여 수정할 수 있습니다. 이 파일은 한 번에 하나의 Server Configuration Tool 인스턴스에서만 사용해야 합니다. 이 도구는 동일한 파일에 대한 동시 액세스를 관리하지 않습니다. 도구의 여러 인스턴스가 동일한 파일에 액세스하는 경우 데이터가 유실될 수 있습니다. 이 도구가 데이터베이스를 작성하고 설정하는 방법에 대한 자세한 정보는 [Server Configuration Tool을 사용하여 데이터베이스 테이블 작성](../databases/#create-the-database-tables-with-the-server-configuration-tool)을 참조하십시오. 데이터베이스가 존재하는 경우 이 도구는 일부 테스트 테이블의 컨텐츠 및 존재를 테스트하여 데이터베이스를 발견할 수 있으며 이 데이터베이스 테이블을 수정하지 않습니다.

* [지원되는 운영 체제](#supported-operating-systems)
* [지원되는 토폴로지](#supported-topologies)
* [Server Configuration Tool 실행](#running-the-server-configuration-tool)
* [Server Configuration Tool을 사용하여 수정팩 적용](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### 지원되는 운영 체제
{: #supported-operating-systems }
다음과 같은 운영 체제에 있는 경우 Server Configuration Tool을 사용할 수 있습니다.

* Windows x86 또는 x86-64
* macOS x86-64
* Linux x86 또는 Linux x86-64

기타 운영 체제에서는 이 도구를 사용할 수 없습니다. [Ant 태스크를 사용한 설치](#installing-with-ant-tasks)에 설명된 대로 {{ site.data.keys.mf_server }} 컴포넌트를 설치하려면 Ant 태스크를 사용해야 합니다.

### 지원되는 토폴로지
{: #supported-topologies }
Server Configuration Tool은 다음과 같은 토폴로지를 사용하여 {{ site.data.keys.mf_server }} 컴포넌트를 설치합니다.

* 모든 컴포넌트({{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임)가 동일한 애플리케이션 서버에 있습니다. 하지만 WebSphere Application Server Network Deployment에서 클러스터에 설치할 때 관리 및 라이브 업데이트 서비스와 런타임에 대해 서로 다른 클러스터를 지정할 수 있습니다. Liberty Collective의 경우 {{ site.data.keys.mf_console }}, 관리 서비스 및 라이브 업데이트 서비스는 Collective 제어기에서 설치되고 런타임은 Collective 멤버에서 설치됩니다.
* {{ site.data.keys.mf_server }} 푸시 서비스가 설치되는 경우 해당 서비스도 동일한 서버에 설치됩니다. 하지만 WebSphere Application Server Network Deployment에서 클러스터에 설치할 때 푸시 서비스에 대해 다른 클러스터를 지정할 수 있습니다. Liberty Collective의 경우 푸시 서비스는 런타임이 설치될 때와 동일할 수 있는 Liberty 멤버에서 설치됩니다.
* 모든 컴포넌트는 동일한 데이터베이스 시스템 및 사용자를 사용합니다. 또한 DB2의 경우 모든 컴포넌트는 동일한 스키마를 사용합니다.
* Server Configuration Tool은 비대칭 배치를 위한 WebSphere Application Server Network Deployment 및 Liberty Collective의 경우를 제외하고 단일 서버를 위한 컴포넌트를 설치합니다. 다중 서버에 설치하는 경우에는 도구가 실행된 후 팜이 구성되어야 합니다. WebSphere Application Server Network Deployment에서는 서버 팜 구성이 필요하지 않습니다.

기타 토폴로지 또는 기타 데이터베이스 설정의 경우에는 대신 Ant 태스크를 사용하거나 수동으로 컴포넌트를 설치할 수 있습니다.

### Server Configuration Tool 실행
{: #running-the-server-configuration-tool }
Server Configuration Tool을 실행하기 전에 다음과 같은 요구사항이 충족되었는지 확인하십시오.

* 컴포넌트에 대한 데이터베이스 및 테이블을 사용할 준비가 되어 있습니다. [데이터베이스 설정](../databases)을 참조하십시오.
* 컴포넌트를 설치할 서버 토폴로지가 결정되어 있습니다. [토폴로지 및 네트워크 플로우](../topologies)를 참조하십시오.
* 애플리케이션 서버가 구성되어 있습니다. [애플리케이션 서버 전제조건](#application-server-prerequisites)을 참조하십시오.
* 도구를 실행하는 사용자가 특정 파일 시스템 권한을 가지고 있습니다. [파일 시스템 전제조건](#file-system-prerequisites)을 참조하십시오.

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>구성 도구 실행에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Server Configuration Tool을 시작하십시오.
                        <ul>
                            <li>Linux의 경우 애플리케이션 바로 가기 <b>애플리케이션 → IBM MobileFirst Platform Server → Server Configuration Tool</b>에서</li>
                            <li>Windows의 경우 <b>시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool</b>을 클릭하십시오.</li>
                            <li>macOS의 경우 쉘 콘솔을 여십시오. <b>mfp_server_install_dir/shortcuts</b>로 이동한 후 <b>./configuration-tool.sh</b>를 입력하십시오.</li>
                            <li><b>mfp_server_install_dir</b> 디렉토리는 사용자가 {{ site.data.keys.mf_server }}를 설치한 디렉토리입니다.</li>
                        </ul>
                    </li>
                    <li><b>파일 → 새 구성</b>을 선택하여 {{ site.data.keys.mf_server }} 구성을 작성하십시오.
                        <ul>
                            <li><b>구성 세부사항</b> 패널에서 런타임 컴포넌트 및 관리 서비스의 컨텍스트 루트를 입력하십시오. 환경 ID를 입력할 수 있습니다. 환경 ID는 고급 유스 케이스에서 사용됩니다(예: <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">{{ site.data.keys.mf_server }}의 여러 설치가 동일한 애플리케이션 서버 또는 동일한 WebSphere Application Server 셀에서 작성되는 경우</a>).</li>
                            <li><b>콘솔 설정</b> 패널에서 {{ site.data.keys.mf_console }} 설치 여부를 선택하십시오. 이 콘솔이 설치되지 않은 경우에는 명령행 도구(<b>mfpdev</b> 또는 <b>mfpadm</b>) 또는 REST API를 사용하여 {{ site.data.keys.mf_server }} 관리 서비스와 상호작용해야 합니다.</li>
                            <li><b>데이터베이스 선택</b> 패널에서 사용하려는 데이터베이스 관리 시스템을 선택하십시오. 모든 컴포넌트는 동일한 데이터베이스 유형 및 동일한 데이터베이스 인스턴스를 사용합니다. 데이터베이스 분할창에 대한 자세한 정보는 <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Server Configuration Tool을 사용하여 데이터베이스 테이블 작성</a>을 참조하십시오.</li>
                            <li><b>애플리케이션 서버 선택</b> 패널에서 {{ site.data.keys.mf_server }}를 배치할 애플리케이션 서버의 유형을 선택하십시오.</li>
                        </ul>
                    </li>
                    <li><b>애플리케이션 서버 설정</b> 패널에서 애플리케이션 서버를 선택하고 다음과 같은 단계를 수행하십시오.
                        <ul>
                            <li>WebSphere Application Server Liberty에 설치의 경우:
                                <ul>
                                    <li>Liberty의 설치 디렉토리 및 {{ site.data.keys.mf_server }}를 설치할 서버의 이름을 입력하십시오.</li>
                                    <li>콘솔에 로그인할 기본 사용자를 작성할 수 있습니다. 이 사용자는 Liberty Basic 레지스트리에서 작성됩니다. 프로덕션 설치의 경우 <b>기본 사용자 작성</b> 옵션을 선택 취소하고 설치 후에 사용자 액세스를 구성할 수 있습니다. 자세한 정보는 <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 관리를 위한 사용자 인증 구성</a>을 참조하십시오.</li>
                                    <li>배치 유형 <b>독립형 배치</b>(기본값), <b>서버 팜 배치</b> 또는 <b>Liberty Collective 배치</b>를 선택하십시오.</li>
                                </ul>

                                Liberty Collective 배치 옵션을 선택한 경우 다음과 같은 단계를 수행하십시오.
                                <ul>
                                    <li>Liberty Collective 서버 지정:
                                        <ul>
                                            <li>관리 서비스, {{ site.data.keys.mf_console }} 및 라이브 업데이트 서비스가 설치되는 위치. 서버는 Liberty Collective 제어기여야 합니다.</li>
                                            <li>런타임이 설치되는 위치. 서버는 Liberty Collective 멤버여야 합니다.</li>
                                            <li>푸시 서비스가 설치되는 위치. 서버는 Liberty Collective 멤버여야 합니다.</li>
                                        </ul>
                                    </li>
                                    <li>멤버의 서버 ID를 입력하십시오. 이 ID는 집합의 멤버마다 서로 달라야 합니다.</li>
                                    <li>집합 멤버의 클러스터 이름을 입력하십시오.</li>
                                    <li>제어기 호스트 이름 및 HTTPS 포트 번호를 입력하십시오. 값은 Liberty Collective 제어기의 <b>server.xml</b> 파일에 있는 <code>variable</code> 요소에 정의되어 있는 값과 동일해야 합니다.</li>
                                    <li>제어기 관리자 이름 및 비밀번호를 입력하십시오.</li>
                                </ul>
                            </li>
                            <li>WebSphere Application Server 또는 WebSphere Application Server Network Deployment에 설치의 경우:
                                <ul>
                                    <li>WebSphere Application Server의 설치 디렉토리를 입력하십시오.</li>
                                    <li>{{ site.data.keys.mf_server }}를 설치할 WebSphere Application Server 프로파일을 선택하십시오. WebSphere Application Server Network Deployment에 설치하는 경우 배치 관리자의 프로파일을 선택하십시오. 배치 관리자 프로파일에서 범위(<b>서버</b> 또는 <b>클러스터</b>)를 선택할 수 있습니다. <b>클러스터</b>를 선택하는 경우 클러스터를 지정해야 합니다.
                                        <ul>
                                            <li>런타임이 설치되는 위치</li>
                                            <li>관리 서비스, {{ site.data.keys.mf_console }} 및 라이브 업데이트 서비스가 설치되는 위치</li>
                                            <li>푸시 서비스가 설치되는 위치</li>
                                        </ul>
                                    </li>
                                    <li>관리자 로그인 ID 및 비밀번호를 입력하십시오. 관리자는 보안 역할을 가지고 있어야 합니다.</li>
                                    <li><b>{{ site.data.keys.mf_console }}에서 WebSphere 관리자를 관리자로 선언</b> 옵션을 선택하는 경우 {{ site.data.keys.mf_server }}를 설치하는 데 사용되는 사용자가 콘솔의 관리 보안 역할에 맵핑되고 관리자 권한으로 콘솔에 로그인할 수 있습니다. 이 사용자는 라이브 업데이트 서비스의 보안 역할에도 맵핑됩니다. 사용자 이름 및 비밀번호는 관리 서비스의 JNDI 특성(<b>mfp.config.service.user</b> 및 <b>mfp.config.service.password</b>)으로 설정됩니다.</li>
                                    <li><b>{{ site.data.keys.mf_console }}에서 WebSphere 관리자를 관리자로 선언</b> 옵션을 선택하지 않는 경우에는 {{ site.data.keys.mf_server }}를 사용하려면 먼저 다음과 같은 태스크를 수행해야 합니다.
                                        <ul>
                                            <li>다음을 수행하여 관리 서비스와 라이브 업데이트 서비스 간 통신을 사용으로 설정:
                                                <ul>
                                                    <li>사용자를 라이브 업데이트 서비스의 보안 역할 <b>configadmin</b>에 맵핑</li>
                                                    <li>관리 서비스의 JNDI 특성(<b>mfp.config.service.user</b> 및 <b>mfp.config.service.password</b>)에서 이 사용자의 로그인 ID 및 비밀번호 추가</li>
                                                    <li>한 명 이상의 사용자를 관리 서비스 및 {{ site.data.keys.mf_console }}의 보안 역할에 맵핑하십시오. <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 관리를 위한 사용자 인증 구성</a>을 참조하십시오.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>Apache Tomcat에 설치의 경우:
                                <ul>
                                    <li>Apache Tomcat의 설치 디렉토리를 입력하십시오.</li>
                                    <li>RMI와의 JMX 통신에 사용되는 포트를 입력하십시오. 기본적으로 값은 8686입니다. Server Configuration Tool은 <b>tomcat_install_dir/bin/setenv.bat</b> 또는 <b>tomcat_install_dir/bin/setenv.sh</b> 파일을 수정하여 이 포트를 엽니다. 이 포트를 수동으로 열려고 하거나 <b>setenv.bat</b> 또는 <b>setenv.sh</b>에서 이 포트를 여는 일부 코드가 이미 있는 경우에는 이 도구를 사용하지 마십시오. 대신 Ant 태스크를 설치하십시오. Ant 태스크를 사용한 설치에 대해 RMI 포트를 수동으로 여는 옵션이 제공됩니다.</li>
                                    <li>콘솔에 로그인할 기본 사용자를 작성하십시오. 이 사용자는 <b>tomcat-users.xml</b> 구성 파일에서도 작성됩니다. 프로덕션 설치의 경우 기본 사용자 작성 옵션을 선택 취소하고 설치 후에 사용자 액세스를 구성할 수 있습니다. 자세한 정보는 <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">{{ site.data.keys.mf_server }} 관리를 위한 사용자 인증 구성</a>을 참조하십시오.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>애플리케이션 서버에서 푸시 서비스를 설치하려면 <b>푸시 서비스 설정</b> 패널에서 <b>푸시 서비스 설치</b> 옵션을 선택하십시오. 컨텍스트 루트는 <b>imfpush</b>입니다. 푸시 서비스와 관리 서비스 사이의 통신을 사용으로 설정하려면 다음과 같은 매개변수를 정의해야 합니다.
                        <ul>
                            <li>푸시 서비스의 URL 및 런타임의 URL을 입력하십시오. Liberty, Apache Tomcat 또는 독립형 WebSphere Application Server에 설치하는 경우 이 URL은 자동으로 계산될 수 있습니다. 이 URL은 로컬 서버의 컴포넌트(런타임 또는 푸시 서비스) URL을 사용합니다. WebSphere Application Server Network Deployment에 설치하거나 통신이 웹 프록시 또는 로드 밸런서를 통해 수행되는 경우에는 수동으로 URL을 입력해야 합니다.</li>
                            <li>서비스 간 OAuth 통신에 대한 기밀 클라이언트 ID 및 본인확인정보를 입력하십시오. 그렇지 않으면 도구가 기본값 및 랜덤 비밀번호를 생성합니다.</li>
                        </ul>
                    </li>
                    <li>{{ site.data.keys.mf_analytics }}가 설치된 경우 <b>Analytics 설정</b> 패널에서 <b>Analytics Server에 대한 연결 사용</b>을 선택하십시오. 다음과 같은 연결 설정을 입력하십시오.
                        <ul>
                            <li>Analytics Console의 URL</li>
                            <li>Analytics Server의 URL(Analytics 데이터 서비스)</li>
                            <li>Analytics Server에 데이터를 공개하도록 허용되는 사용자 로그인 ID 및 비밀번호</li>
                        </ul>

                        도구가 Analytics Server에 데이터를 전송하도록 런타임 및 푸시 서비스를 구성합니다.
                    </li>
                    <li><b>배치</b>를 클릭하여 설치를 계속하십시오.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

Apache Tomcat 또는 Liberty 프로파일의 경우 설치가 완료된 후 애플리케이션 서버를 다시 시작하십시오.

Apache Tomcat이 서비스로 실행되면 RMI를 여는 데 필요한 명령문이 포함된 setenv.bat 또는 setenv.sh 파일을 읽지 않습니다. 결과적으로 {{ site.data.keys.mf_server }}가 올바르게 작동할 수 없습니다. 필수 변수를 설정하려면 [Apache Tomcat을 위한 JMX 연결 구성](#apache-tomcat-prerequisites)을 참조하십시오.

WebSphere Application Server Network Deployment의 경우 애플리케이션은 설치되지만 시작되지 않습니다. 애플리케이션을 수동으로 시작해야 합니다. WebSphere Application Server 관리 콘솔에서 이를 수행할 수 있습니다.

Server Configuration Tool에서 구성 파일을 보존하십시오. 임시 수정사항을 설치하기 위해 재사용할 수 있습니다. 임시 수정사항을 적용하는 메뉴는 **구성 >배치된 WAR 파일 바꾸기**입니다.

### Server Configuration Tool을 사용하여 수정팩 적용
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
구성 도구를 사용하여 {{ site.data.keys.mf_server }}를 설치할 때 구성 파일이 보존되는 경우 구성 파일을 재사용하여 임시 수정사항 또는 수정팩을 적용할 수 있습니다.

1. Server Configuration Tool을 시작하십시오.
    * Linux의 경우 애플리케이션 바로 가기 **애플리케이션 → IBM MobileFirst Platform Server → Server Configuration Tool**에서
    * Windows의 경우 **시작 → 프로그램 → IBM MobileFirst Platform Server → Server Configuration Tool**을 클릭하십시오.
    * macOS의 경우 쉘 콘솔을 여십시오. **mfp\_server\_install_dir/shortcuts**로 이동하여 **./configuration-tool.sh**를 입력하십시오.
    * **mfp\_server\_install\_dir** 디렉토리는 {{ site.data.keys.mf_server }}를 설치한 디렉토리입니다.

2. **구성 → 배치된 WAR 파일 바꾸기**를 클릭한 후 기존 구성을 선택하여 수정팩 또는 임시 수정사항을 적용하십시오.

## Ant 태스크를 사용하여 설치
{: #installing-with-ant-tasks }
Ant 태스크를 사용하여 {{ site.data.keys.mf_server }} 컴포넌트를 애플리케이션 서버에 설치하십시오.

**mfp\_install\_dir/MobileFirstServer/configuration-samples 디렉토리**에서 {{ site.data.keys.mf_server }} 설치에 필요한 샘플 구성 파일을 찾을 수 있습니다.

또한 Server Configuration Tool을 사용하여 구성을 작성한 후 **파일 → 구성을 Ant 파일로 내보내기...**를 사용하여 Ant 파일을 내보낼 수 있습니다. 샘플 Ant 파일은 Server Configuration Tool과 동일한 제한사항을 가지고 있습니다.

* 모든 컴포넌트({{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 아티팩트 및 {{ site.data.keys.product_adj }} 런타임)는 동일한 애플리케이션 서버에 있습니다. 하지만 WebSphere Application Server Network Deployment에서 클러스터에 설치할 때 관리 및 라이브 업데이트 서비스와 런타임에 대해 서로 다른 클러스터를 지정할 수 있습니다.
* {{ site.data.keys.mf_server }} 푸시 서비스가 설치되는 경우 해당 서비스도 동일한 서버에 설치됩니다. 하지만 WebSphere Application Server Network Deployment에서 클러스터에 설치할 때 푸시 서비스에 대해 다른 클러스터를 지정할 수 있습니다.
* 모든 컴포넌트는 동일한 데이터베이스 시스템 및 사용자를 사용합니다. 또한 DB2의 경우 모든 컴포넌트는 동일한 스키마를 사용합니다.
* Server Configuration Tool은 단일 서버를 위한 컴포넌트를 설치합니다. 다중 서버에 설치하는 경우에는 도구가 실행된 후 팜이 구성되어야 합니다. WebSphere Application Server Network Deployment에서는 서버 팜 구성이 지원되지 않습니다.

Ant 태스크를 사용하여 서버 팜에서 실행되도록 {{ site.data.keys.mf_server }} 서비스를 구성할 수 있습니다. 서버를 팜에 포함하려면 애플리케이션 서버를 적절하게 구성하는 일부 특정 속성을 지정해야 합니다. Ant 태스크를 사용한 서버 팜 구성에 대한 자세한 정보는 [Ant 태스크를 사용한 서버 팜 설치](#installing-a-server-farm-with-ant-tasks)를 참조하십시오.

[토폴로지 및 네트워크 플로우](../topologies)에서 지원되는 기타 토폴로지의 경우 샘플 Ant 파일을 수정할 수 있습니다.

Ant 태스크에 대한 참조는 다음과 같습니다.

* [{{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.mf_server }} 관리 및 라이브 업데이트 서비스 설치를 위한 Ant 태스크](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [{{ site.data.keys.mf_server }} 푸시 서비스 설치를 위한 Ant 태스크](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

샘플 구성 파일 및 태스크를 사용한 설치에 대한 개요는 [명령행 모드에서 {{ site.data.keys.mf_server }} 설치](../../simple-install/tutorials/command-line)를 참조하십시오.

제품 설치의 일부인 Ant 배포를 사용하여 Ant 파일을 실행할 수 있습니다. 예를 들어, WebSphere Application Server Network Deployment 클러스터를 가지고 있고 데이터베이스가 IBM DB2인 경우 **mfp\_install\_dir/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** Ant 파일을 사용할 수 있습니다. 파일을 편집하고 모든 필수 특성을 입력한 후 **mfp\_install\_dir/MobileFirstServer/configuration-samples** 디렉토리에서 다음과 같은 명령을 실행할 수 있습니다.

* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - 이 명령은 일부 컴포넌트를 설치, 설치 제거 또는 업데이트하는 데 필요한 Ant 파일의 모든 가능한 대상의 목록을 표시합니다.
* **mfp\_install\_dir/shortcuts/ant -f configure-wasnd-cluster-db2.xml install** - 이 명령은 Ant 파일의 특성에서 입력한 매개변수를 사용하여 DB2를 데이터 소스로 하여 {{ site.data.keys.mf_server }}를 WebSphere Application Server Network Deployment 클러스터에 설치합니다.

<br/>
설치 후 수정팩을 적용하는 데 재사용할 수 있도록 Ant 파일의 사본을 작성하십시오.

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

### 샘플 Ant 파일 수정
{: #sample-ant-files-modifications }
**mfp\_install\_dir/MobileFirstServer/configuration-samples** 디렉토리에 제공된 샘플 Ant 파일을 수정하여 설치 요구사항에 적응할 수 있습니다.  
다음 절에서는 사용자의 요구에 맞게 설치하도록 샘플 Ant 파일을 수정하는 방법에 대한 세부사항을 제공합니다.

1. [추가 JNDI 특성 지정](#specify-extra-jndi-properties)
2. [기존 사용자 지정](#specify-existing-users)
3. [Liberty Java EE 레벨 지정](#specify-liberty-java-ee-level)
4. [데이터 소스 JDBC 특성 지정](#specify-data-source-jdbc-properties)
5. [{{ site.data.keys.mf_server }}가 설치되지 않은 컴퓨터에서 Ant 파일 실행](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [WebSphere Application Server Network Deployment 대상 지정](#specify-websphere-application-server-network-deployment-targets)
7. [Apache Tomcat에서 RMI 포트 수동 구성](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### 추가 JNDI 특성 지정
{: #specify-extra-jndi-properties }
**installmobilefirstadmin**, **installmobilefirstruntime** 및 **installmobilefirstpush** Ant 태스크는 컴포넌트가 작동하기 위해 필요한 JNDI 특성에 대한 값을 선언합니다. 이 JNDI 특성은 JMX 통신과 다른 컴포넌트(예: 라이브 업데이트 서비스, 푸시 서비스, 분석 서비스 또는 권한 부여 서버)에 대한 링크를 정의하는 데 사용됩니다. 하지만 기타 JNDI 특성에 대한 값도 정의할 수 있습니다. `<property>` 요소(이 세 태스크에 대해 존재함)를 사용하십시오. JNDI 특성의 목록은 다음을 참조하십시오.

* [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

예를 들어, 다음과 같습니다.

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin>
```

#### 기존 사용자 지정
{: #specify-existing-users }
기본적으로 **installmobilefirstadmin** Ant 태스크는 사용자를 작성합니다.

* WebSphere Application Server Liberty에서는 JMX 통신을 위한 Liberty 관리자를 정의하기 위해
* 애플리케이션 서버에서는 라이브 업데이트 서비스와 통신하는 데 사용되는 사용자를 정의하기 위해

새 사용자를 작성하는 대신 기존 사용자를 사용하려면 다음과 같은 조작을 수행하십시오.

1.     `<jmx>` 요소에서, 사용자 및 비밀번호를 지정하고 **createLibertyAdmin** 속성의 값을 false로 설정하십시오. 예를 들어, 다음과 같습니다.

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2.     `<configuration>` 요소에서, 사용자 및 비밀번호를 지정하고 **createConfigAdminUser** 속성의 값을 false로 설정하십시오. 예를 들어, 다음과 같습니다.

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

또한 샘플 Ant 파일에 의해 작성되는 사용자는 관리 서비스 및 콘솔의 보안 역할에 맵핑됩니다. 이 설정을 통해 설치 후 이 사용자를 사용하여 {{ site.data.keys.mf_server }}에 로그온할 수 있습니다. 이 동작을 변경하려면 샘플 Ant 파일에서 `<user>` 요소를 제거하십시오. 또는 `<user>` 요소에서 **password** 속성을 제거할 수 있으며 사용자는 애플리케이션 서버의 로컬 레지스트리에서 작성되지 않습니다.

#### Liberty Java EE 레벨 지정
{: #specify-liberty-java-ee-level }
WebSphere Application Server Liberty의 일부 배포판에서는 Java EE 6 또는 Java EE 7의 기능을 지원합니다. 기본적으로 Ant 태스크는 설치할 기능을 자동으로 발견합니다. 예를 들어, **jdbc-4.0** Liberty 기능은 Java EE 6의 경우 설치되고 **jdbc-4.1** 기능은 Java EE 7의 경우 설치됩니다. Liberty 설치에서 Java EE 6와 Java EE 7 모두의 기능을 지원하는 경우에는 기능의 특정 레벨을 강제 실행할 수 있습니다. {{ site.data.keys.mf_server }} V8.0.0과 V7.1.0을 동일한 Liberty 서버에서 실행하려는 경우가 하나의 예입니다. {{ site.data.keys.mf_server }} V7.1.0 이하에서는 Java EE 6 기능만 지원합니다.

Java EE 6 기능의 특정 레벨을 강제 실행하려면 `<websphereapplicationserver>` 요소의 jeeversion 속성을 사용하십시오. 예를 들어, 다음과 같습니다.

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### 데이터 소스 JDBC 특성 지정
{: #specify-data-source-jdbc-properties }
JDBC 연결에 대한 특성을 지정할 수 있습니다. `<property>` 요소의 `<property>` 요소를 사용하십시오. 이 요소는 **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime** 및 **installmobilefirstpush** Ant 태스크에서 사용할 수 있습니다. 예를 들어, 다음과 같습니다.

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### {{ site.data.keys.mf_server }}가 설치되지 않은 컴퓨터에서 Ant 파일 실행
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
{{ site.data.keys.mf_server }}가 설치되지 않은 컴퓨터에서 Ant 태스크를 실행하려면 다음과 같은 항목이 필요합니다.

* Ant 설치
* 원격 컴퓨터에 대한 **mfp-ant-deployer.jar** 파일의 사본. 이 라이브러리에는 Ant 태스크의 정의가 포함되어 있습니다.
* 설치될 리소스 지정. 기본적으로 WAR 파일은 **mfp-ant-deployer.jar** 근처에서 가져오지만 이 WAR 파일의 위치를 지정할 수 있습니다. 예를 들어, 다음과 같습니다.

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

자세한 정보는 [설치 참조서](../../installation-reference)에서 각 {{ site.data.keys.mf_server }} 컴포넌트를 설치하는 데 필요한 Ant 태스크를 참조하십시오.

#### WebSphere Application Server Network Deployment 대상 지정
{: #specify-websphere-application-server-network-deployment-targets }
WebSphere Application Server Network Deployment에 설치하려면 지정된 WebSphere Application Server 프로파일이 배치 관리자여야 합니다. 다음과 같은 구성에 배치할 수 있습니다.

* 클러스터
* 단일 서버
* 셀(셀의 모든 서버)
* 노드(노드의 모든 서버)

**configure-wasnd-cluster-dbms-name.xml**, **configure-wasnd-server-dbms-name.xml** 및 **configure-wasnd-node-dbms-name.xml** 등의 샘플 파일에는 각 유형의 대상에 배치할 선언이 포함되어 있습니다. 자세한 정보는 [설치 참조서](../../installation-reference)에 있는 각 {{ site.data.keys.mf_server }} 컴포넌트를 설치하는 데 필요한 Ant 태스크를 참조하십시오.

> 참고: V8.0.0부터 WebSphere Application Server Network Deployment 셀에 대한 샘플 구성 파일은 제공되지 않습니다.


#### Apache Tomcat에서 RMI 포트 수동 구성
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
기본적으로 Ant 태스크는 **setenv.bat** 파일 또는 **setenv.sh** 파일을 수정하여 RMI 포트를 엽니다. RMI 포트를 수동으로 여는 것을 선호하는 경우에는 값이 false인 **tomcatSetEnvConfig** 속성을 **installmobilefirstadmin**, **updatemobilefirstadmin** 및 **uninstallmobilefirstadmin** 태스크의 `<jmx>` 요소에 추가하십시오.

## {{ site.data.keys.mf_server }} 컴포넌트 수동 설치
{: #installing-the-mobilefirst-server-components-manually }
수동으로 {{ site.data.keys.mf_server }} 컴포넌트를 애플리케이션 서버에 설치할 수도 있습니다.  
다음 주제에서는 프로덕션에서 지원되는 애플리케이션에 컴포넌트를 설치하는 프로세스에 대해 안내하는 완전한 정보를 제공합니다.

* [WebSphere Application Server Liberty에 수동 설치](#manual-installation-on-websphere-application-server-liberty)
* [WebSphere Application Server Liberty Collective에 수동 설치](#manual-installation-on-websphere-application-server-liberty-collective)
* [Apache Tomcat에 수동 설치](#manual-installation-on-apache-tomcat)
* [WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### WebSphere Application Server Liberty에 수동 설치
{: #manual-installation-on-websphere-application-server-liberty }
[WebSphere Application Server Liberty 전제조건](#websphere-application-server-liberty-prerequisites)에 설명된 대로 요구사항을 이행했는지도 확인하십시오.

* [토폴로지 제한조건](#topology-constraints)
* [애플리케이션 서버 설정](#application-server-settings)
* [{{ site.data.keys.mf_server }} 애플리케이션에 필요한 Liberty 기능](#liberty-features-required-by-the-mobilefirst-server-applications)
* [글로벌 JNDI 항목](#global-jndi-entries)
* [클래스 로더](#class-loader)
* [비밀번호 디코더 사용자 기능](#password-decoder-user-feature)
* [구성 세부사항](#configuration-details-liberty)

#### 토폴로지 제한조건
{: #topology-constraints }
{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 MobileFirst 런타임은 동일한 애플리케이션 서버에 설치되어야 합니다. 라이브 업데이트 서비스의 컨텍스트 루트는 **the-adminContextRootconfig**로 정의되어야 합니다. 푸시 서비스의 컨텍스트 루트는 **imfpush**여야 합니다. 제한조건에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)을 참조하십시오.

#### 애플리케이션 서버 설정
{: #application-server-settings }
서블릿을 즉시 로드하도록 **webContainer** 요소를 구성해야 합니다. 이 설정은 JMX를 통한 초기화의 경우 필수입니다. 예를 들어, `<webContainer deferServletLoad="false"/>`입니다.

선택적으로 일부 Liberty 버전에서 관리 서비스 및 런타임의 시작 시퀀스를 중단하는 제한시간 초과 문제를 방지하려면 기본 **executor** 요소를 변경하십시오. 큰 값을 **coreThreads** 및 **maxThreads** 속성으로 설정하십시오. 예를 들어, 다음과 같습니다.

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

또한 **tcpOptions** 요소를 구성하고 **soReuseAddr** 속성을 `true`로 설정할 수 있습니다(`<tcpOptions soReuseAddr="true"/>`).

#### {{ site.data.keys.mf_server }} 애플리케이션에 필요한 Liberty 기능
{: #liberty-features-required-by-the-mobilefirst-server-applications }
Java EE 6 또는 Java EE 7의 경우 다음과 같은 기능을 사용할 수 있습니다.

**{{ site.data.keys.mf_server }} 관리 서비스**

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} 푸시 서비스**  

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **servlet-3.0**(Java EE 7의 경우 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} 런타임**  

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **servlet-3.0**(Java EE 7의 경우 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### 글로벌 JNDI 항목
{: #global-jndi-entries }
런타임과 관리 서비스 사이의 JMX 통신을 구성하려면 다음과 같은 글로벌 JNDI 항목이 필요합니다.

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

이 글로벌 JNDI 항목은 이 구문을 사용하여 설정되며 컨텍스트 루트가 접두부로 사용되지 않습니다. 예를 들어, `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`입니다.

> **참고:** 075가 61로 변환되거나 31.500이 31.5로 변환되지 않도록 JNDI 값의 자동 변환에 대해 보호하려면 값을 정의할 때 이 구문 '"075"'를 사용하십시오.

관리 서비스의 JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.  

팜 구성의 경우 다음과 같은 주제도 참조하십시오.

* [서버 팜 토폴로지](../topologies/#server-farm-topology)
* [토폴로지 및 네트워크 플로우](../topologies)
* [서버 팜 설치](#installing-a-server-farm)

#### 클래스 로더
{: #class-loader }
모든 애플리케이션에 대해 클래스 로더에 상위 마지막 위임이 있어야 합니다. 예를 들어, 다음과 같습니다.

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### 비밀번호 디코더 사용자 기능
{: #password-decoder-user-feature }
비밀번호 디코더 사용자 기능을 Liberty 프로파일에 복사하십시오. 예를 들어, 다음과 같습니다.

* UNIX 및 Linux 시스템의 경우:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Windows 시스템의 경우:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### 구성 세부사항
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>{{ site.data.keys.mf_server }} 관리 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>관리 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 관리 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpadmin</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 관리 서비스의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.admin.push.url</b>을 선언하여 관리 서비스가 <b>/mfpadmin</b>을 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>푸시 서비스가 설치되면 다음과 같은 JNDI 특성을 구성해야 합니다.</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>구성 서비스와의 통신을 위한 JNDI 특성은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>관리 서비스에 대한 데이터 소스의 JNDI 이름은 <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 <b>/mfpadmin</b>을 사용하여 관리 서비스가 설치되고 이 서비스가 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 다음과 같은 역할을 선언하십시오.</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>{{ site.data.keys.mf_server }} 라이브 업데이트 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>라이브 업데이트 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>라이브 업데이트 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>에 있습니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. <b>/the-adminContextRootconfig</b>. 예를 들어, 관리 서비스의 컨텍스트 루트가 <b>/mfpadmin</b>인 경우 라이브 업데이트 서비스의 컨텍스트 루트는 <b>/mfpadminconfig</b>여야 합니다.</p>

                <h3>데이터 소스</h3>
                <p>라이브 업데이트 서비스에 대한 데이터 소스의 JNDI 이름은 the-contextRoot/jdbc/ConfigDS로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 /mfpadminconfig를 사용하여 라이브 업데이트 서비스가 설치되고 이 서비스가 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 configadmin 역할을 선언하십시오. 한 명 이상의 사용자가 이 역할에 맵핑되어야 합니다. 관리 서비스의 다음과 같은 JNDI 특성에 사용자 및 해당 비밀번호가 제공되어야 합니다.</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>{{ site.data.keys.mf_console }} 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>콘솔은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>콘솔 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpconsole</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 콘솔의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.admin.endpoint</b>를 선언하여 콘솔이 <b>/mfpconsole</b>을 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint 특성의 일반적인 값은 <b>*://*:*/the-adminContextRoot</b>입니다.<br/>
                 JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }}의 JNDI 특성</a>을 참조하십시오.</p>

                <h3>보안 역할</h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 다음과 같은 역할을 선언하십시오.</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                콘솔의 보안 역할에 맵핑되는 사용자는 관리 서비스의 동일한 보안 역할에도 맵핑되어야 합니다.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>MobileFirst 런타임 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>런타임은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>런타임 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 기본적으로는 <b>/mfp</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 런타임의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.analytics.url</b>을 선언하여 런타임이 <b>/mobilefirst</b>를 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p><b>mobilefirst/mfp.authorization.server</b> 특성을 정의해야 합니다. 예를 들어, 다음과 같습니다.</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>{{ site.data.keys.mf_analytics }}가 설치된 경우 다음과 같은 JNDI 특성을 정의해야 합니다.</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>런타임에 대한 데이터 소스의 JNDI 이름은 <b>jndiName=the-contextRoot/jdbc/mfpDS</b>로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 <b>/mobilefirst</b>를 사용하여 런타임이 설치되고 이 런타임이 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>{{ site.data.keys.mf_server }} 푸시 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>푸시 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>푸시 서비스 WAR 파일은 <b>mfp_install_dir/PushService/mfp-push-service.war</b>에 있습니다. 컨텍스트 루트를 <b>/imfpush</b>로 정의해야 합니다. 그렇지 않으면 컨텍스트 루트가 SDK에서 하드코딩되므로 클라이언트 디바이스가 여기에 연결될 수 없습니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 푸시 서비스의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.push.analytics.user</b>를 선언하여 푸시 서비스가 <b>/imfpush</b>를 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                다음과 같은 특성을 정의해야 합니다.
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 값은 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>이어야 합니다.</li>
                    <li><b>mfp.push.db.type</b> - 관계형 데이터베이스의 경우 값은 DB여야 합니다.</li>
                </ul>

                {{ site.data.keys.mf_analytics }}가 구성된 경우 다음과 같은 JNDI 특성을 정의하십시오.
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 값은 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>이어야 합니다.</li>
                </ul>
                JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록</a>을 참조하십시오.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>{{ site.data.keys.mf_server }} 아티팩트 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>아티팩트 컴포넌트는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>이 컴포넌트에 대한 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>에 있습니다. 컨텍스트 루트를 <b>/mfp-dev-artifacts</b>로 정의해야 합니다.</p>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server Liberty Collective에 수동 설치
{: #manual-installation-on-websphere-application-server-liberty-collective }
[WebSphere Application Server Liberty 전제조건](#websphere-application-server-liberty-prerequisites)에 설명된 대로 요구사항을 이행했는지도 확인하십시오.

* [토폴로지 제한조건](#topology-constraints-collective)
* [애플리케이션 서버 설정](#application-server-settings-collective)
* [{{ site.data.keys.mf_server }} 애플리케이션에 필요한 Liberty 기능](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [글로벌 JNDI 항목](#global-jndi-entries-collective)
* [클래스 로더](#class-loader-collective)
* [비밀번호 디코더 사용자 기능](#password-decoder-user-feature-collective)
* [구성 세부사항](#configuration-details-collective)

#### 토폴로지 제한조건
{: #topology-constraints-collective }
{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.mf_console }}은 Liberty Collective 제어기에서 설치해야 합니다. {{ site.data.keys.product_adj }} 런타임 및 {{ site.data.keys.mf_server }} 푸시 서비스는 Liberty Collective 클러스터의 모든 멤버에서 설치해야 합니다.

라이브 업데이트 서비스의 컨텍스트 루트는 **the-adminContextRootconfig**로 정의되어야 합니다. 푸시 서비스의 컨텍스트 루트는 **imfpush**여야 합니다. 제한조건에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)을 참조하십시오.

#### 애플리케이션 서버 설정
{: #application-server-settings-collective }
서블릿을 즉시 로드하도록 **webContainer** 요소를 구성해야 합니다. 이 설정은 JMX를 통한 초기화의 경우 필수입니다. 예를 들어, `<webContainer deferServletLoad="false"/>`입니다.

선택적으로 일부 Liberty 버전에서 관리 서비스 및 런타임의 시작 시퀀스를 중단하는 제한시간 초과 문제를 방지하려면 기본 **executor** 요소를 변경하십시오. 큰 값을 **coreThreads** 및 **maxThreads** 속성으로 설정하십시오. 예를 들어, 다음과 같습니다.

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

또한 **tcpOptions** 요소를 구성하고 **soReuseAddr** 속성을 `true`로 설정할 수 있습니다(`<tcpOptions soReuseAddr="true"/>`).

#### {{ site.data.keys.mf_server }} 애플리케이션에 필요한 Liberty 기능
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

Java EE 6 또는 Java EE 7의 경우 다음과 같은 기능을 추가해야 합니다.

**{{ site.data.keys.mf_server }} 관리 서비스**

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.mf_server }} 푸시 서비스**  

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **servlet-3.0**(Java EE 7의 경우 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }} 런타임**  

* **jdbc-4.0**(Java EE 7의 경우 jdbc-4.1)
* **servlet-3.0**(Java EE 7의 경우 servlet-3.1)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### 글로벌 JNDI 항목
{: #global-jndi-entries-collective }
런타임과 관리 서비스 사이의 JMX 통신을 구성하려면 다음과 같은 글로벌 JNDI 항목이 필요합니다.

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

이 글로벌 JNDI 항목은 이 구문을 사용하여 설정되며 컨텍스트 루트가 접두부로 사용되지 않습니다. 예를 들어, `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`입니다.

> **참고:** 075가 61로 변환되거나 31.500이 31.5로 변환되지 않도록 JNDI 값의 자동 변환에 대해 보호하려면 값을 정의할 때 이 구문 '"075"'를 사용하십시오.

* 관리 서비스의 JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.  
* 런타임의 JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오.

#### 클래스 로더
{: #class-loader-collective }
모든 애플리케이션에 대해 클래스 로더에 상위 마지막 위임이 있어야 합니다. 예를 들어, 다음과 같습니다.

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### 비밀번호 디코더 사용자 기능
{: #password-decoder-user-feature-collective }
비밀번호 디코더 사용자 기능을 Liberty 프로파일에 복사하십시오. 예를 들어, 다음과 같습니다.

* UNIX 및 Linux 시스템의 경우:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Windows 시스템의 경우:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### 구성 세부사항
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>{{ site.data.keys.mf_server }} 관리 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>관리 서비스는 사용자가 Liberty Collective 제어기에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. Liberty Collective 제어기의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty Collective에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                관리 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpadmin</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 관리 서비스의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.admin.push.url</b>을 선언하여 관리 서비스가 <b>/mfpadmin</b>을 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>푸시 서비스가 설치되면 다음과 같은 JNDI 특성을 구성해야 합니다.</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>구성 서비스와의 통신을 위한 JNDI 특성은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>관리 서비스에 대한 데이터 소스의 JNDI 이름은 <b>jndiName=the-contextRoot/jdbc/mfpAdminDS</b>로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 <b>/mfpadmin</b>을 사용하여 관리 서비스가 설치되고 이 서비스가 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>보안 역할</h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 다음과 같은 역할을 선언하십시오.</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>{{ site.data.keys.mf_server }} 라이브 업데이트 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>라이브 업데이트 서비스는 사용자가 Liberty Collective 제어기에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. Liberty Collective 제어기의 <b>server.xml</b> 파일에서 이 애플리케이션의 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty Collective에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                라이브 업데이트 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>에 있습니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. <b>/the-adminContextRootconfig</b>. 예를 들어, 관리 서비스의 컨텍스트 루트가 <b>/mfpadmin</b>인 경우 라이브 업데이트 서비스의 컨텍스트 루트는 <b>/mfpadminconfig</b>여야 합니다.</p>

                <h3>데이터 소스</h3>
                <p>라이브 업데이트 서비스에 대한 데이터 소스의 JNDI 이름은 <b>the-contextRoot/jdbc/ConfigDS</b>로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 <b>/mfpadminconfig</b>를 사용하여 라이브 업데이트 서비스가 설치되고 이 서비스가 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>보안 역할</h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 configadmin 역할을 선언하십시오. 한 명 이상의 사용자가 이 역할에 맵핑되어야 합니다. 관리 서비스의 다음과 같은 JNDI 특성에 사용자 및 해당 비밀번호가 제공되어야 합니다.</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>{{ site.data.keys.mf_console }} 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>콘솔은 사용자가 Liberty Collective 제어기에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. Liberty Collective 제어기의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                 콘솔 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpconsole</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 콘솔의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.admin.endpoint</b>를 선언하여 콘솔이 <b>/mfpconsole</b>을 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>mfp.admin.endpoint 특성의 일반적인 값은 <b>*://*:*/the-adminContextRoot</b>입니다.<br/>
                 JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }}의 JNDI 특성</a>을 참조하십시오.</p>

                <h3>보안 역할</h3>
                <p>애플리케이션의 <b>application-bnd</b> 요소에서 다음과 같은 역할을 선언하십시오.</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                콘솔의 보안 역할에 맵핑되는 사용자는 관리 서비스의 동일한 보안 역할에도 맵핑되어야 합니다.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>{{ site.data.keys.product_adj }} 런타임 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>런타임은 사용자가 Liberty Collective 클러스터 멤버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 모든 Liberty Collective 클러스터 멤버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty Collective에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                런타임 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 기본적으로는 <b>/mfp</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 런타임의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.analytics.url</b>을 선언하여 런타임이 <b>/mobilefirst</b>를 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p><b>mobilefirst/mfp.authorization.server</b> 특성을 정의해야 합니다. 예를 들어, 다음과 같습니다.</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>{{ site.data.keys.mf_analytics }}가 설치된 경우 다음과 같은 JNDI 특성을 정의해야 합니다.</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>런타임에 대한 데이터 소스의 JNDI 이름은 <b>jndiName=the-contextRoot/jdbc/mfpDS</b>로 정의되어야 합니다. 다음 예에서는 컨텍스트 루트 <b>/mobilefirst</b>를 사용하여 런타임이 설치되고 이 런타임이 관계형 데이터베이스를 사용하는 경우를 보여줍니다.</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>{{ site.data.keys.mf_server }} 푸시 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>푸시 서비스는 사용자가 Liberty Collective 클러스터 멤버 또는 Liberty 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. Liberty 서버에서 푸시 서비스를 설치하는 경우에는 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a> 아래의 <a href="#configuration-details-liberty">{{ site.data.keys.mf_server }} 푸시 서비스 구성 세부사항</a>을 참조하십시오.
                <br/><br/>
                {{ site.data.keys.mf_server }} 푸시 서비스가 Liberty Collective에서 설치되는 경우 이는 런타임의 경우와 동일한 클러스터 또는 다른 클러스터에서 설치될 수 있습니다.
                <br/><br/>
                모든 Liberty Collective 클러스터 멤버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty-collective">WebSphere Application Server Liberty Collective에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.    
                <br/><br/>
                푸시 서비스 WAR 파일은 <b>mfp_install_dir/PushService/mfp-push-service.war</b>에 있습니다. 컨텍스트 루트를 <b>/imfpush</b>로 정의해야 합니다. 그렇지 않으면 컨텍스트 루트가 SDK에서 하드코딩되므로 클라이언트 디바이스가 여기에 연결될 수 없습니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성을 정의할 때 푸시 서비스의 컨텍스트 루트가 JNDI 이름의 접두부가 되어야 합니다. 다음 예에서는 <b>mfp.push.analytics.user</b>를 선언하여 푸시 서비스가 <b>/imfpush</b>를 컨텍스트 루트로 사용하여 설치되는 경우를 보여줍니다.</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                다음과 같은 특성을 정의해야 합니다.
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 값은 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>이어야 합니다.</li>
                    <li><b>mfp.push.db.type</b> - 관계형 데이터베이스의 경우 값은 DB여야 합니다.</li>
                </ul>

                {{ site.data.keys.mf_analytics }}가 구성된 경우 다음과 같은 JNDI 특성을 정의하십시오.
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 값은 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>이어야 합니다.</li>
                </ul>
                JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록</a>을 참조하십시오.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>{{ site.data.keys.mf_server }} 아티팩트 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>아티팩트 컴포넌트는 사용자가 Liberty Collective 제어기에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. Liberty Collective 제어기의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-liberty">WebSphere Application Server Liberty에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>이 컴포넌트에 대한 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>에 있습니다. 컨텍스트 루트를 <b>/mfp-dev-artifacts</b>로 정의해야 합니다.</p>
            </div>
        </div>
    </div>
</div>

### Apache Tomcat에 수동 설치
{: #manual-installation-on-apache-tomcat }
[Apache Tomcat 전제조건](#apache-tomcat-prerequisites)에 설명된 대로 요구사항을 이행했는지 확인하십시오.

* [토폴로지 제한조건](#topology-constraints-tomcat)
* [애플리케이션 서버 설정](#application-server-settings-tomcat)
* [구성 세부사항](#configuration-details-tomcat)

#### 토폴로지 제한조건
{: #topology-constraints-tomcat }
{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임은 동일한 애플리케이션 서버에 설치되어야 합니다. 라이브 업데이트 서비스의 컨텍스트 루트는 **the-adminContextRootconfig**로 정의되어야 합니다. 푸시 서비스의 컨텍스트 루트는 **imfpush**여야 합니다. 제한조건에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)을 참조하십시오.

#### 애플리케이션 서버 설정
{: #application-server-settings-tomcat }
**싱글 사인온 밸브**를 활성화해야 합니다. 예를 들어, 다음과 같습니다.

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

사용자가 **tomcat-users.xml**에서 정의된 경우 선택적으로 메모리 영역을 활성화할 수 있습니다. 예를 들어, 다음과 같습니다.

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### 구성 세부사항
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>{{ site.data.keys.mf_server }} 관리 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>관리 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                관리 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpadmin</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>JNDI 특성은 애플리케이션 컨텍스트의 <code>Environment</code> 요소에서 정의됩니다. 예를 들어, 다음과 같습니다.</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>런타임과의 JMX 통신을 사용하려면 다음과 같은 JNDI 특성을 정의하십시오.</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>푸시 서비스가 설치되면 다음과 같은 JNDI 특성을 구성해야 합니다.</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>구성 서비스와의 통신을 위한 JNDI 특성은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>데이터 소스(jdbc/mfpAdminDS)는 **Context** 요소에서 리소스로 선언됩니다. 예를 들어, 다음과 같습니다.</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>보안 역할</h3>
                <p>관리 서비스 애플리케이션에 사용 가능한 보안 역할은 다음과 같습니다.</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>{{ site.data.keys.mf_server }} 라이브 업데이트 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>라이브 업데이트 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                라이브 업데이트 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>에 있습니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. <b>/the-adminContextRoot/config</b>. 예를 들어, 관리 서비스의 컨텍스트 루트가 <b>/mfpadmin</b>인 경우 라이브 업데이트 서비스의 컨텍스트 루트는 <b>/mfpadminconfig</b>여야 합니다.</p>

                <h3>데이터 소스</h3>
                <p>라이브 업데이트 서비스에 대한 데이터 소스의 JNDI 이름은 <code>jdbc/ConfigDS</code>로 정의되어야 합니다. <code>Context</code> 요소에서 리소스로 선언하십시오.</p>

                <h3>보안 역할</h3>
                <p>라이브 업데이트 서비스 애플리케이션에 사용 가능한 보안 역할은 <b>configadmin</b>입니다.
                <br/><br/>
                한 명 이상의 사용자가 이 역할에 맵핑되어야 합니다. 관리 서비스의 다음과 같은 JNDI 특성에 사용자 및 해당 비밀번호가 제공되어야 합니다.</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>{{ site.data.keys.mf_console }} 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>콘솔은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                 콘솔 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpconsole</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p><b>mfp.admin.endpoint</b> 특성을 정의해야 합니다. 이 특성의 일반적인 값은 <b>*://*:*/the-adminContextRoot</b>입니다.
                <br/><br/>
                 JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }}의 JNDI 특성</a>을 참조하십시오.</p>

                <h3>보안 역할</h3>
                <p>애플리케이션에 사용 가능한 보안 역할은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>{{ site.data.keys.product_adj }} 런타임 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>런타임은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                런타임 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 기본적으로는 <b>/mfp</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p><b>mfp.authorization.server</b> 특성을 정의해야 합니다. 예를 들어, 다음과 같습니다.</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>관리 서비스와의 JMX 통신을 사용하려면 다음과 같은 JNDI 특성을 정의하십시오.</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }}가 설치된 경우 다음과 같은 JNDI 특성을 정의해야 합니다.</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>런타임에 대한 데이터 소스의 JNDI 이름은 <b>jdbc/mfpDS</b>로 정의되어야 합니다. <b>Context</b> 요소에서 리소스로 선언하십시오.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>{{ site.data.keys.mf_server }} 푸시 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>푸시 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.    
                <br/><br/>
                푸시 서비스 WAR 파일은 <b>mfp_install_dir/PushService/mfp-push-service.war</b>에 있습니다. 컨텍스트 루트를 <b>/imfpush</b>로 정의해야 합니다. 그렇지 않으면 컨텍스트 루트가 SDK에서 하드코딩되므로 클라이언트 디바이스가 여기에 연결될 수 없습니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>다음과 같은 특성을 정의해야 합니다.</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 값은 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>이어야 합니다.</li>
                    <li><b>mfp.push.db.type</b> - 관계형 데이터베이스의 경우 값은 DB여야 합니다.</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }}가 구성된 경우 다음과 같은 JNDI 특성을 정의하십시오.</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 값은 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>이어야 합니다.</li>
                </ul>
                JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록</a>을 참조하십시오.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>{{ site.data.keys.mf_server }} 아티팩트 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>아티팩트 컴포넌트는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-apache-tomcat">Apache Tomcat에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>이 컴포넌트에 대한 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>에 있습니다. 컨텍스트 루트를 <b>/mfp-dev-artifacts</b>로 정의해야 합니다.</p>
            </div>
        </div>
    </div>
</div>

### WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
<a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">WebSphere Application Server 및 WebSphere Application Server Network Deployment 전제조건</a>에 설명된 대로 요구사항을 이행했는지 확인하십시오.

* [토폴로지 제한조건](#topology-constraints-nd)
* [애플리케이션 서버 설정](#application-server-settings-nd)
* [클래스 로더](#class-loader-nd)
* [구성 세부사항](#configuration-details-nd)

#### 토폴로지 제한조건
{: #topology-constraints-nd }
<b>독립형 WebSphere Application Server의 경우</b>  
{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임은 동일한 애플리케이션 서버에 설치되어야 합니다. 라이브 업데이트 서비스의 컨텍스트 루트는 <b>the-adminContextRootConfig</b>로 정의되어야 합니다. 푸시 서비스의 컨텍스트 루트는 <b>imfpush</b>여야 합니다. 제한조건에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 컴포넌트 및 {{ site.data.keys.mf_analytics }}에 대한 제한조건](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)을 참조하십시오.

<b>WebSphere Application Server Network Deployment의 경우</b>  
{{ site.data.keys.mf_server }}가 실행 중인 동안 배치 관리자가 실행 중이어야 합니다. 배치 관리자는 런타임과 관리 서비스 사이의 JMX 통신에 사용됩니다. 관리 서비스 및 라이브 업데이트 서비스는 동일한 애플리케이션 서버에 설치되어야 합니다. 런타임은 관리 서비스와 다른 서버에 설치될 수 있지만 동일한 셀에 있어야 합니다.

#### 애플리케이션 서버 설정
{: #application-server-settings-nd }
관리 보안 및 애플리케이션 보안이 사용 가능해야 합니다. WebSphere Application Server 관리 콘솔에서 애플리케이션 보안을 사용으로 설정할 수 있습니다.

1. WebSphere Application Server 관리 콘솔에 로그인하십시오.
2. **보안 → 글로벌 보안**을 클릭하십시오. 관리 보안 사용이 선택되어 있는지 확인하십시오.
3. 또한 **애플리케이션 보안 사용**이 선택되어 있는지 확인하십시오. 애플리케이션 보안은 관리 보안이 사용으로 설정된 경우에만 사용으로 설정할 수 있습니다.
4. **확인**을 클릭하십시오.
5. 변경사항을 저장하십시오.

자세한 정보는 WebSphere Application Server 문서에서 [보안 사용](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc)을 참조하십시오.

서버 클래스 로더 정책은 상위 마지막 위임을 지원해야 합니다. {{ site.data.keys.mf_server }} WAR 파일은 상위 마지막 클래스 로더 모드로 설치되어야 합니다. 클래스 로더 정책을 검토하십시오.

1. WebSphere Application Server 관리 콘솔에 로그인하십시오.
2. **서버 → 서버 유형 → WebSphere Application Server**를 클릭한 후 {{ site.data.keys.product }}에 사용되는 서버를 클릭하십시오.
3. 클래스 로더 정책이 **다중**으로 설정된 경우에는 아무것도 수행하지 마십시오.
4. 클래스 로더 정책이 **단일**로 설정되고 클래스 로드 모드가 **로컬 클래스 로더로 로드된 클래스 먼저(상위 마지막)**로 설정된 경우에는 아무것도 수행하지 마십시오.
5. 클래스 로더 정책이 **단일**로 설정되고 클래스 로드 모드가 **상위 클래스 로더로 로드된 클래스 먼저(상위 먼저)**로 설정된 경우에는 클래스 로더 정책을 **다중**으로 변경하십시오. 또한 {{ site.data.keys.mf_server }} 애플리케이션 이외의 모든 애플리케이션의 클래스 로더 순서를 **상위 클래스 로더로 로드된 클래스 먼저(상위 먼저)**로 설정하십시오.

#### 클래스 로더
{: #class-loader-nd }
모든 {{ site.data.keys.mf_server }} 애플리케이션에 대해 클래스 로더에 상위 마지막 위임이 있어야 합니다.

애플리케이션이 설치된 후 클래스 로더 위임을 상위 마지막으로 설정하려면 다음의 단계를 수행하십시오.

1. **애플리케이션 관리** 링크를 클릭하거나 **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션**을 클릭하십시오.
2. **{{ site.data.keys.mf_server }}** 애플리케이션을 클릭하십시오. 기본적으로 애플리케이션의 이름은 WAR 파일의 이름입니다.
3. **세부사항 특성** 섹션에서 **클래스 로드 및 업데이트 발견** 링크를 클릭하십시오.
4. **클래스 로더 순서** 분할창에서 **로컬 클래스 로더로 로드된 클래스(상위 마지막)** 옵션을 선택하십시오.
5. **확인**을 클릭하십시오.
6. **모듈** 섹션에서 **모듈 관리** 링크를 클릭하십시오.
7. 모듈을 클릭하십시오.
8. **클래스 로더 순서** 필드에 대해 **로컬 클래스 로더로 로드된 클래스(상위 마지막)** 옵션을 선택하십시오.
9. **확인**을 두 번 클릭하여 선택사항을 확인하고 애플리케이션의 **구성** 패널로 돌아가십시오.
10. **저장**을 클릭하여 변경사항을 지속시키십시오.

#### 구성 세부사항
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>{{ site.data.keys.mf_server }} 관리 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>관리 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                관리 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-service.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpadmin</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>WebSphere Application Server 관리 콘솔을 사용하여 JNDI 특성을 설정할 수 있습니다. <b>애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션 → application_name → 웹 모듈용 환경 항목</b>으로 이동하여 항목을 설정하십시오.</p>

                <p>런타임과의 JMX 통신을 사용하려면 다음과 같은 JNDI 특성을 정의하십시오.</p>

                <b>WebSphere Application Server Network Deployment의 경우</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - 배치 관리자의 SOAP 포트입니다.</li>
                    <li><b>mfp.topology.platform</b> - 값을 <b>WAS</b>로 설정하십시오.</li>
                    <li><b>mfp.topology.clustermode</b> - 값을 <b>Cluster</b>로 설정하십시오.</li>
                    <li><b>mfp.admin.jmx.connector</b> - 값을 <b>SOAP</b>로 설정하십시오.</li>
                </ul>

                <b>독립형 WebSphere Application Server의 경우</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 값을 <b>WAS</b>로 설정하십시오.</li>
                    <li><b>mfp.topology.clustermode</b> - 값을 <b>Standalone</b>으로 설정하십시오.</li>
                    <li><b>mfp.admin.jmx.connector</b> - 값을 <b>SOAP</b>로 설정하십시오.</li>
                </ul>

                <p>푸시 서비스가 설치되면 다음과 같은 JNDI 특성을 구성해야 합니다.</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>구성 서비스와의 통신을 위한 JNDI 특성은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>관리 서비스에 대한 데이터 소스를 작성하여 <b>jdbc/mfpAdminDS</b>에 맵핑하십시오.</p>

                <h3>시작 순서</h3>
                <p>런타임 애플리케이션보다 먼저 관리 서비스 애플리케이션을 시작해야 합니다. <b>시작 동작</b> 섹션에서 순서를 설정할 수 있습니다. 예를 들어, 관리 서비스의 경우 시작 순서를 <b>1</b>로 설정하고 런타임의 경우 시작 순서를 <b>2</b>로 설정하십시오.</p>

                <h3>보안 역할</h3>
                <p>관리 서비스 애플리케이션에 사용 가능한 보안 역할은 다음과 같습니다.</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>{{ site.data.keys.mf_server }} 라이브 업데이트 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>라이브 업데이트 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                라이브 업데이트 서비스 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-live-update.war</b>에 있습니다. 라이브 업데이트 서비스의 컨텍스트 루트는 다음과 같은 방식으로 정의되어야 합니다. <b>/the-adminContextRoot/config</b>. 예를 들어, 관리 서비스의 컨텍스트 루트가 <b>/mfpadmin</b>인 경우 라이브 업데이트 서비스의 컨텍스트 루트는 <b>/mfpadminconfig</b>여야 합니다.</p>

                <h3>데이터 소스</h3>
                <p>라이브 업데이트 서비스에 대한 데이터 소스를 작성하여 <b>jdbc/ConfigDS</b>에 맵핑하십시오.</p>

                <h3>보안 역할</h3>
                <p>이 애플리케이션에 대해 <b>configadmin</b> 역할이 정의됩니다.
                <br/><br/>
                한 명 이상의 사용자가 이 역할에 맵핑되어야 합니다. 관리 서비스의 다음과 같은 JNDI 특성에 사용자 및 해당 비밀번호가 제공되어야 합니다.</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>{{ site.data.keys.mf_console }} 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>콘솔은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                 콘솔 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-admin-ui.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 일반적으로는 <b>/mfpconsole</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>WebSphere Application Server 관리 콘솔을 사용하여 JNDI 특성을 설정할 수 있습니다. <b>애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션 → application_name → 웹 모듈용 환경 항목</b>으로 이동하여 항목을 설정하십시오.
                <br/><br/>
                <b>mfp.admin.endpoint</b> 특성을 정의해야 합니다. 이 특성의 일반적인 값은 <b>*://*:*/the-adminContextRoot</b>입니다.
                <br/><br/>
                 JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">{{ site.data.keys.mf_console }}의 JNDI 특성</a>을 참조하십시오.</p>

                <h3>보안 역할</h3>
                <p>애플리케이션에 사용 가능한 보안 역할은 다음과 같습니다.</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                콘솔의 보안 역할에 맵핑되는 사용자는 관리 서비스의 동일한 보안 역할에도 맵핑되어야 합니다.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>MobileFirst 런타임 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>런타임은 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다.
                <br/><br/>
                계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.
                <br/><br/>
                런타임 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-server.war</b>에 있습니다. 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 하지만 기본적으로는 <b>/mfp</b>입니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>WebSphere Application Server 관리 콘솔을 사용하여 JNDI 특성을 설정할 수 있습니다. <b>애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션 → application_name → 웹 모듈용 환경 항목</b>으로 이동하여 항목을 설정하십시오.</p>

                <p>값이 임베드된 <b>mfp.authorization.server</b> 특성을 정의해야 합니다.<br/>
                또한 다음과 같은 JNDI 특성을 정의하여 관리 서비스와의 JMX 통신을 사용으로 설정하십시오.</p>

                <b>WebSphere Application Server Network Deployment의 경우</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - 배치 관리자의 호스트 이름입니다.</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - 배치 관리자의 SOAP 포트입니다.</li>
                    <li><b>mfp.topology.platform</b> - 값을 <b>WAS</b>로 설정하십시오.</li>
                    <li><b>mfp.topology.clustermode</b> - 값을 <b>Cluster</b>로 설정하십시오.</li>
                    <li><b>mfp.admin.jmx.connector</b> - 값을 <b>SOAP</b>로 설정하십시오.</li>
                </ul>

                <b>독립형 WebSphere Application Server의 경우</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - 값을 <b>WAS</b>로 설정하십시오.</li>
                    <li><b>mfp.topology.clustermode</b> - 값을 <b>Standalone</b>으로 설정하십시오.</li>
                    <li><b>mfp.admin.jmx.connector</b> - 값을 <b>SOAP</b>로 설정하십시오.</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }}가 설치된 경우 다음과 같은 JNDI 특성을 정의해야 합니다.</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>시작 순서</h3>
                <p>관리 서비스 애플리케이션 이후에 런타임 애플리케이션을 시작해야 합니다. <b>시작 동작</b> 섹션에서 순서를 설정할 수 있습니다. 예를 들어, 관리 서비스의 경우 시작 순서를 <b>1</b>로 설정하고 런타임의 경우 시작 순서를 <b>2</b>로 설정하십시오.</p>

                <h3>데이터 소스</h3>
                <p>런타임에 대한 데이터 소스를 작성한 후 <b>jdbc/mfpDS</b>에 맵핑하십시오.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>{{ site.data.keys.mf_server }} 푸시 서비스 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>푸시 서비스는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.    
                <br/><br/>
                푸시 서비스 WAR 파일은 <b>mfp_install_dir/PushService/mfp-push-service.war</b>에 있습니다. 컨텍스트 루트를 <b>/imfpush</b>로 정의해야 합니다. 그렇지 않으면 컨텍스트 루트가 SDK에서 하드코딩되므로 클라이언트 디바이스가 여기에 연결될 수 없습니다.</p>

                <h3>필수 JNDI 특성</h3>
                <p>WebSphere Application Server 관리 콘솔을 사용하여 JNDI 특성을 설정할 수 있습니다. <b>애플리케이션 > 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션 → application_name → 웹 모듈용 환경 항목</b>으로 이동하여 항목을 설정하십시오.</p>

                <p>다음과 같은 특성을 정의해야 합니다.</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - 값은 <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>이어야 합니다.</li>
                    <li><b>mfp.push.db.type</b> - 관계형 데이터베이스의 경우 값은 DB여야 합니다.</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics }}가 구성된 경우 다음과 같은 JNDI 특성을 정의하십시오.</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - 값은 <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>이어야 합니다.</li>
                </ul>
                <p>JNDI 특성에 대한 자세한 정보는 <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록</a>을 참조하십시오.</p>

                <h3>데이터 소스</h3>
                <p>푸시 서비스에 대한 데이터 소스를 작성하여 <b>jdbc/imfPushDS</b>에 맵핑하십시오.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>{{ site.data.keys.mf_server }} 아티팩트 구성 세부사항</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>아티팩트 컴포넌트는 사용자가 애플리케이션 서버에 배치할 수 있도록 WAR 애플리케이션으로 패키지됩니다. 애플리케이션 서버의 <b>server.xml</b> 파일에서 이 애플리케이션에 대한 일부 특정 구성을 작성해야 합니다. 계속 진행하기 전에 <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">WebSphere Application Server 및 WebSphere Application Server Network Deployment에 수동 설치</a>에서 모든 서비스에 공통인 구성 세부사항을 검토하십시오.</p>

                <p>이 컴포넌트에 대한 WAR 파일은 <b>mfp_install_dir/MobileFirstServer/mfp-dev-artifacts.war</b>에 있습니다. 컨텍스트 루트를 <b>/mfp-dev-artifacts</b>로 정의해야 합니다.</p>
            </div>
        </div>
    </div>
</div>

## 서버 팜 설치
{: #installing-a-server-farm }
Ant 태스크를 실행하거나 Server Configuration Tool을 사용하거나 수동으로 서버 팜을 설치할 수 있습니다.

* [서버 팜의 구성 계획](#planning-the-configuration-of-a-server-farm)
* [Server Configuration Tool을 사용한 서버 팜 설치](#installing-a-server-farm-with-the-server-configuration-tool)
* [Ant 태스크를 사용한 서버 팜 설치](#installing-a-server-farm-with-ant-tasks)
* [수동으로 서버 팜 구성](#configuring-a-server-farm-manually)
* [팜 구성 확인](#verifying-a-farm-configuration)
* [서버 팜 노드의 라이프사이클](#lifecycle-of-a-server-farm-node)

### 서버 팜의 구성 계획
{: #planning-the-configuration-of-a-server-farm }
서버 팜의 구성을 계획하려면 애플리케이션 서버를 선택하고 {{ site.data.keys.product_adj }} 데이터베이스를 구성하고 팜의 각 서버에서 {{ site.data.keys.mf_server }} 컴포넌트의 WAR 파일을 배치하십시오. Server Configuration Tool, Ant 태스크 또는 수동 조작을 사용하여 서버 팜을 구성하는 옵션이 있습니다.

서버 팜 설치를 계획하려는 경우에는 [{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 MobileFirst 런타임에 대한 제한조건](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)을 먼저 참조하십시오(특히 [서버 팜 토폴로지](../topologies/#server-farm-topology) 참조).

{{ site.data.keys.product }}에서 서버 팜은 애플리케이션 서버의 컴포넌트를 관리하여 관리 또는 연합되지 않는 여러 독립형 애플리케이션 서버로 구성됩니다. {{ site.data.keys.mf_server }}는 서버 팜의 일부가 될 수 있도록 애플리케이션 서버를 개선하는 수단으로 팜 플러그인을 내부적으로 제공합니다.

#### 서버 팜 선언 시기
{: #when-to-declare-a-server-farm }
**다음과 같은 경우 서버 팜을 선언하십시오. **

* {{ site.data.keys.mf_server }}가 여러 Tomcat 애플리케이션 서버에 설치됩니다.
* {{ site.data.keys.mf_server }}가 여러 WebSphere Application Server 서버에 설치되지만 WebSphere Application Server Network Deployment에는 설치되지 않습니다.
* {{ site.data.keys.mf_server }}가 여러 WebSphere Application Server Liberty 서버에 설치됩니다.

**다음과 같은 경우에는 서버 팜을 선언하지 마십시오. **

* 애플리케이션 서버가 독립형입니다.
* 여러 애플리케이션 서버가 WebSphere Application Server Network Deployment에 의해 연합됩니다.

#### 팜 선언이 필수인 이유
{: #why-it-is-mandatory-to-declare-a-farm }
{{ site.data.keys.mf_console }} 또는 {{ site.data.keys.mf_server }} 관리 서비스 애플리케이션을 통해 관리 조작이 수행될 때마다 런타임 환경의 모든 인스턴스에 조작을 복제해야 합니다. 이러한 관리 조작의 예는 앱 또는 어댑터의 새 버전을 업로드하는 것입니다. 복제는 조작을 처리하는 관리 서비스 애플리케이션 인스턴스가 수행하는 JMX 호출을 통해 수행됩니다. 관리 서비스는 클러스터의 모든 런타임 인스턴스에 접속해야 합니다. 위의 **서버 팜 선언 시기** 아래에 나열된 환경에서는 팜이 구성된 경우에만 JMX를 통해 런타임에 접속할 수 있습니다. 팜을 적절하게 구성하지 않고 서버를 클러스터에 추가하는 경우 해당 서버의 런타임은 각각의 관리 조작 후 다시 시작될 때까지 불일치 상태에 있습니다.

### Server Configuration Tool을 사용한 서버 팜 설치
{: #installing-a-server-farm-with-the-server-configuration-tool }
Server Configuration Tool을 사용하여 서버 팜의 각 멤버에 사용되는 단일 애플리케이션 서버 유형의 요구사항에 따라 팜의 각 서버를 구성하십시오.

Server Configuration Tool을 사용하여 서버 팜을 계획할 때는 먼저 독립형 서버를 작성한 후 안전한 방식으로 서로 통신할 수 있도록 독립형 서버 각각의 신뢰 저장소를 구성하십시오. 그런 다음 다음과 같은 조작을 수행하는 도구를 실행하십시오.

* {{ site.data.keys.mf_server }} 컴포넌트가 공유하는 데이터베이스 인스턴스를 구성하십시오.
* {{ site.data.keys.mf_server }} 컴포넌트를 각 서버에 배치하십시오.
* 서버 팜의 멤버가 되도록 해당 서버의 구성을 수정하십시오.

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Server Configuration Tool을 사용한 서버 팜 설치에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }}를 사용하려면 보안 JMX 연결을 구성해야 합니다.</p>

                <ol>
                    <li>서버 팜 멤버로 구성해야 하는 애플리케이션 서버를 준비하십시오.
                        <ul>
                            <li>서버 팜의 멤버를 구성하기 위해 사용할 애플리케이션 서버의 유형을 선택하십시오. {{ site.data.keys.product }}은 서버 팜에 있는 다음과 같은 애플리케이션 서버를 지원합니다.
                                <ul>
                                    <li>WebSphere Application Server 전체 프로파일<br/>
                                    <b>참고:</b> 팜 토폴로지에서는 RMI JMX 커넥터를 사용할 수 없습니다. 이 토폴로지에서는 {{ site.data.keys.product }}이 SOAP 커넥터만 지원합니다.</li>
                                    <li>WebSphere Application Server Liberty 프로파일</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                지원되는 애플리케이션 서버 버전을 확인하려면 <a href="../../../../product-overview/requirements">시스템 요구사항</a>을 참조하십시오.

                                <blockquote><b>중요:</b> {{ site.data.keys.product }}은 동종 서버 팜만 지원합니다. 서버 팜은 동일한 유형의 애플리케이션 서버에 연결되는 경우 동종 서버 팜입니다. 서로 다른 유형의 애플리케이션 서버를 연관시키면 런타임 시 예측할 수 없는 동작이 발생합니다. 예를 들어, Apache Tomcat 서버와 WebSphere Application Server 전체 프로파일 서버의 혼합을 가진 팜은 올바르지 않은 구성입니다.</blockquote>
                            </li>
                            <li>팜에서 원하는 멤버 수만큼 독립형 서버를 설정하십시오.
                                <ul>
                                    <li>이 독립형 서버는 각각 동일한 데이터베이스와 통신해야 합니다. 이 서버가 사용하는 포트를 동일한 호스트에서 구성된 다른 서버가 사용하지 않는지 확인해야 합니다. 이 제한조건은 HTTP, HTTPS, REST, SOAP 및 RMI 프로토콜에서 사용하는 포트에 적용됩니다.</li>
                                    <li>이 서버 각각에는 {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 하나 이상의 {{ site.data.keys.product_adj }} 런타임이 배치되어 있어야 합니다.</li>
                                    <li>서버 설정에 대한 자세한 정보는 <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임에 대한 제한조건</a>을 참조하십시오.</li>
                                </ul>
                            </li>
                            <li>각각의 신뢰 저장소에 있는 모든 서버 사이에서 서명자 인증서를 교환하십시오.
                            <br/><br/>
                            보안이 사용으로 설정되어야 하므로 이 단계는 WebSphere Application Server 전체 프로파일 또는 Liberty를 사용하는 팜의 경우 필수입니다. 또한 Liberty 팜의 경우 싱글 사인온 기능을 보장하기 위해 각 서버에서 동일한 LTPA 구성을 복제해야 합니다. 이 구성을 수행하려면 <a href="#configuring-a-server-farm-manually">수동으로 서버 팜 구성</a>의 6단계에 있는 가이드라인을 따르십시오.
                            </li>
                        </ul>
                    </li>
                    <li>팜의 각 서버에 대해 Server Configuration Tool을 실행하십시오. 모든 서버는 동일한 데이터베이스를 공유해야 합니다. <b>애플리케이션 서버 설정</b> 패널에서 배치 유형 <b>서버 팜 배치</b>를 선택해야 합니다. 이 도구에 대한 자세한 정보는 <a href="#running-the-server-configuration-tool">Server Configuration Tool 실행</a>을 참조하십시오.
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Ant 태스크를 사용한 서버 팜 설치
{: #installing-a-server-farm-with-ant-tasks }
Ant 태스크를 사용하여 서버 팜의 각 멤버에 사용되는 단일 애플리케이션 서버 유형의 요구사항에 따라 팜의 각 서버를 구성하십시오.

Ant 태스크를 사용하여 서버 팜을 계획할 때는 먼저 독립형 서버를 작성한 후 안전한 방식으로 서로 통신할 수 있도록 독립형 서버 각각의 신뢰 저장소를 구성하십시오. 그런 다음 Ant 태스크를 실행하여 {{ site.data.keys.mf_server }} 컴포넌트가 공유하는 데이터베이스 인스턴스를 구성하십시오. 마지막으로 Ant 태스크를 실행하여 {{ site.data.keys.mf_server }} 컴포넌트를 각 서버에 배치하고 서버 팜의 멤버가 되도록 해당 서버의 구성을 수정하십시오.

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Ant 태스크를 사용한 서버 팜 설치에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }}를 사용하려면 보안 JMX 연결을 구성해야 합니다.</p>

                <ol>
                    <li>서버 팜 멤버로 구성해야 하는 애플리케이션 서버를 준비하십시오.
                        <ul>
                            <li>서버 팜의 멤버를 구성하기 위해 사용할 애플리케이션 서버의 유형을 선택하십시오. {{ site.data.keys.product }}은 서버 팜에 있는 다음과 같은 애플리케이션 서버를 지원합니다.
                                <ul>
                                    <li>WebSphere Application Server 전체 프로파일 <b>참고:</b> 팜 토폴로지에서는 RMI JMX 커넥터를 사용할 수 없습니다. 이 토폴로지에서는 {{ site.data.keys.product }}이 SOAP 커넥터만 지원합니다.</li>
                                    <li>WebSphere Application Server Liberty 프로파일</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                지원되는 애플리케이션 서버 버전을 확인하려면 <a href="../../../../product-overview/requirements">시스템 요구사항</a>을 참조하십시오.

                                <blockquote><b>중요:</b> {{ site.data.keys.product }}은 동종 서버 팜만 지원합니다. 서버 팜은 동일한 유형의 애플리케이션 서버에 연결되는 경우 동종 서버 팜입니다. 서로 다른 유형의 애플리케이션 서버를 연관시키면 런타임 시 예측할 수 없는 동작이 발생합니다. 예를 들어, Apache Tomcat 서버와 WebSphere Application Server 전체 프로파일 서버의 혼합을 가진 팜은 올바르지 않은 구성입니다.</blockquote>
                            </li>
                            <li>팜에서 원하는 멤버 수만큼 독립형 서버를 설정하십시오.
                            <br/><br/>
                             이 독립형 서버는 각각 동일한 데이터베이스와 통신해야 합니다. 이 서버가 사용하는 포트를 동일한 호스트에서 구성된 다른 서버가 사용하지 않는지 확인해야 합니다. 이 제한조건은 HTTP, HTTPS, REST, SOAP 및 RMI 프로토콜에서 사용하는 포트에 적용됩니다.
                            <br/><br/>
                            이 서버 각각에는 {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 하나 이상의 {{ site.data.keys.product_adj }} 런타임이 배치되어 있어야 합니다.
                            <br/><br/>
                            서버 설정에 대한 자세한 정보는 <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">{{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 {{ site.data.keys.product_adj }} 런타임에 대한 제한조건</a>을 참조하십시오.</li>
                            <li>각각의 신뢰 저장소에 있는 모든 서버 사이에서 서명자 인증서를 교환하십시오.
                            <br/><br/>
                            보안이 사용으로 설정되어야 하므로 이 단계는 WebSphere Application Server 전체 프로파일 또는 Liberty를 사용하는 팜의 경우 필수입니다. 또한 Liberty 팜의 경우 싱글 사인온 기능을 보장하기 위해 각 서버에서 동일한 LTPA 구성을 복제해야 합니다. 이 구성을 수행하려면 <a href="#configuring-a-server-farm-manually">수동으로 서버 팜 구성</a>의 6단계에 있는 가이드라인을 따르십시오.
                            </li>
                        </ul>
                    </li>
                    <li>관리 서비스, 라이브 업데이트 서비스 및 런타임에 대한 데이터베이스를 구성하십시오.
                        <ul>
                            <li>사용할 데이터베이스를 결정하고 Ant 파일을 선택하여 <b>mfp_install_dir/MobileFirstServer/configuration-samples</b> 디렉토리에서 데이터베이스를 작성하고 구성하십시오.
                                <ul>
                                    <li>DB2의 경우 <b>create-database-db2.xml</b>을 사용하십시오.</li>
                                    <li>MySQL의 경우 <b>create-database-mysql.xml</b>을 사용하십시오.</li>
                                    <li>Oracle의 경우 <b>create-database-oracle.xml</b>을 사용하십시오.</li>
                                </ul>
                                <blockquote>참고: Derby 데이터베이스는 한 번에 하나의 연결만 허용하므로 팜 토폴로지에서 Derby 데이터베이스를 사용하지 마십시오.</blockquote>

                            </li>
                            <li>Ant 파일을 편집하고 데이터베이스에 필요한 모든 특성을 입력하십시오.
                            <br/><br/>
                            {{ site.data.keys.mf_server }} 컴포넌트가 사용하는 데이터베이스의 구성을 사용으로 설정하려면 다음과 같은 특성의 값을 설정하십시오.
                                <ul>
                                    <li><b>mfp.process.admin</b>을 <b>true</b>로 설정하십시오. 관리 서비스 및 라이브 업데이트 서비스에 대한 데이터베이스를 구성하기 위해서입니다.</li>
                                    <li><b>mfp.process.runtime</b>을 <b>true</b>로 설정하십시오. 런타임에 대한 데이터베이스를 구성하기 위해서입니다.</li>
                                </ul>
                            </li>
                            <li><b>mfp_install_dir/MobileFirstServer/configuration-samples</b> 디렉토리에서 <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> 및 <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code> 명령을 실행하십시오(<b>create-database-ant-file.xml</b>을 선택한 실제 Ant 파일 이름으로 바꿔야 함).
                            <br/><br/>
                            {{ site.data.keys.mf_server }} 데이터베이스는 팜의 애플리케이션 서버 사이에서 공유되므로 이 두 명령은 팜에 있는 서버의 수에 관계없이 한 번만 실행해야 합니다.
                            </li>
                            <li>선택적으로 다른 런타임을 설치하려면 다른 데이터베이스 이름 또는 스키마를 가진 다른 데이터베이스를 구성해야 합니다. 이를 위해서는 Ant 파일을 편집하고 특성을 수정하고 팜에 있는 서버의 수에 관계없이 <code>mfp_install_dir/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code> 명령을 한 번 실행하십시오.</li>
                        </ul>
                    </li>
                    <li>관리 서비스, 라이브 업데이트 서비스 및 런타임을 서버에 배치하고 이 서버를 서버 팜의 멤버로 구성하십시오.
                        <ul>
                            <li><b>mfp\_install\_dir/MobileFirstServer/configuration-samples</b> 디렉토리에서 사용자의 애플리케이션 서버 및 데이터베이스에 해당하는 Ant 파일을 선택하여 관리 서비스, 라이브 업데이트 서비스 및 런타임을 서버에 배치하십시오.
                            <br/><br/>
                            예를 들어, DB2 데이터베이스를 가진 Liberty 서버에 배치의 경우 <b>configure-liberty-db2.xml</b> 파일을 선택하십시오. 팜에서 원하는 멤버 수만큼 이 파일의 사본을 작성하십시오.
                            <br/><br/>
                            <b>참고:</b> 이 파일은 이미 배치된 {{ site.data.keys.mf_server }} 컴포넌트의 업그레이드 또는 팜의 각 멤버에서 이들 컴포넌트의 설치 제거에 재사용할 수 있으므로 구성 후 보존하십시오.</li>
                            <li>Ant 파일의 각 사본을 편집하고 2단계에서 사용되는 데이터베이스에 대해 동일한 특성을 입력하고 애플리케이션 서버에 대해 필요한 기타 특성도 입력하십시오.
                            <br/><br/>
                             서버를 서버 팜 멤버로 구성하려면 다음과 같은 특성의 값을 설정하십시오.
                                <ul>
                                    <li><b>mfp.farm.configure</b>를 true로 설정하십시오.</li>
                                    <li><b>mfp.farm.server.id</b>: 이 팜 멤버에 대해 정의하는 ID입니다. 팜의 각 서버가 자체 고유 ID를 가지고 있는지 확인하십시오. 팜에 있는 두 서버가 동일한 ID를 가지고 있는 경우 팜은 예측할 수 없는 방식으로 작동합니다.</li>
                                    <li><b>mfp.config.service.user</b>: 라이브 업데이트 서비스에 액세스하는 데 사용되는 사용자 이름입니다. 이 사용자 이름은 팜의 모든 멤버에 대해 동일해야 합니다.</li>
                                    <li><b>mfp.config.service.password</b>: 라이브 업데이트 서비스에 액세스하는 데 사용되는 비밀번호입니다. 이 비밀번호는 팜의 모든 멤버에 대해 동일해야 합니다.</li>
                                </ul>
                                서버에 {{ site.data.keys.mf_server }} 컴포넌트의 WAR 파일 배치를 사용하려면 다음과 같은 특성의 값을 설정하십시오.
                                    <ul>
                                        <li><b>mfp.process.admin</b>을 <b>true</b>로 설정하십시오. 관리 서비스 및 라이브 업데이트 서비스의 WAR 파일을 배치하기 위해서입니다.</li>
                                        <li><b>mfp.process.runtime</b>을 <b>true</b>로 설정하십시오. 런타임의 WAR 파일을 배치하기 위해서입니다.</li>
                                    </ul>
                                <br/>
                                <b>참고:</b> 팜의 서버에 둘 이상의 런타임을 설치하려는 경우에는 속성 ID를 지정하고 <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> 및 <b>uninstallmobilefirstruntime</b> Ant 태스크에서 각 런타임에 대해 고유해야 하는 값을 설정하십시오.
                                <br/>
                                For example,
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>각 서버에 대해 <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> 및 <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code> 명령을 실행하십시오(<b>configure-appserver-database-ant-file.xml</b>을 선택한 실제 Ant 파일 이름으로 바꿔야 함).
                            <br/><br/>
                             이 명령은 <b>installmobilefirstadmin</b> 및 <b>installmobilefirstruntime</b> Ant 태스크를 실행합니다. 이 태스크에 대한 자세한 정보는 <a href="../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">{{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.mf_server }} 관리 및 라이브 업데이트 서비스 설치를 위한 Ant 태스크</a> 및 <a href="../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크</a>를 참조하십시오.
                            </li>
                            <li>선택적으로 다른 런타임을 설치하려면 다음의 단계를 수행하십시오.
                                <ul>
                                    <li>3.b단계에서 구성한 Ant 파일의 사본을 작성하십시오.</li>
                                    <li>사본을 편집하고 다른 런타임 구성과는 다른 <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> 및 <b>uninstallmobilefirstruntime</b>의 <b>id</b> 속성 값과 고유 컨텍스트 루트를 설정하십시오.</li>
                                    <li>팜의 각 서버에서 <code>mfp_install_dir/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code> 명령을 실행하십시오(<b>configure-appserver-database-ant-file2.xml</b>을 편집되는 Ant 파일의 실제 이름으로 바꿔야 함).</li>
                                    <li>팜의 각 서버에 대해 이 단계를 반복하십시오.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>모든 서버를 다시 시작하십시오.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 수동으로 서버 팜 구성
{: #configuring-a-server-farm-manually }
서버 팜의 각 멤버에 사용되는 단일 애플리케이션 서버 유형의 요구사항에 따라 팜의 각 서버를 구성해야 합니다.

서버 팜을 계획하는 경우에는 먼저 동일한 데이터베이스 인스턴스와 통신하는 독립형 서버를 작성하십시오. 그런 다음 이 서버의 구성을 수정하여 이 서버를 서버 팜의 멤버로 만드십시오.

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>서버 팜 수동 구성에 대한 지시사항을 보려면 클릭</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>서버 팜의 멤버를 구성하기 위해 사용할 애플리케이션 서버의 유형을 선택하십시오. {{ site.data.keys.product }}은 서버 팜에 있는 다음과 같은 애플리케이션 서버를 지원합니다.
                        <ul>
                            <li>WebSphere Application Server 전체 프로파일<br/>
                            <b>참고:</b> 팜 토폴로지에서는 RMI JMX 커넥터를 사용할 수 없습니다. 이 토폴로지에서는 {{ site.data.keys.product }}이 SOAP 커넥터만 지원합니다.</li>
                            <li>WebSphere Application Server Liberty 프로파일</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        지원되는 애플리케이션 서버 버전을 확인하려면 <a href="../../../../product-overview/requirements">시스템 요구사항</a>을 참조하십시오.

                        <blockquote><b>중요:</b> {{ site.data.keys.product }}은 동종 서버 팜만 지원합니다. 서버 팜은 동일한 유형의 애플리케이션 서버에 연결되는 경우 동종 서버 팜입니다. 서로 다른 유형의 애플리케이션 서버를 연관시키면 런타임 시 예측할 수 없는 동작이 발생합니다. 예를 들어, Apache Tomcat 서버와 WebSphere Application Server 전체 프로파일 서버의 혼합을 가진 팜은 올바르지 않은 구성입니다.</blockquote>
                    </li>
                    <li>사용할 데이터베이스를 결정하십시오. 다음 중에서 선택할 수 있습니다.
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        {{ site.data.keys.mf_server }} 데이터베이스는 팜의 애플리케이션 서버 사이에서 공유되며 이는 다음을 의미합니다.
                        <ul>
                            <li>팜에 있는 서버의 수에 관계없이 데이터베이스를 한 번만 작성합니다.</li>
                            <li>Derby 데이터베이스는 한 번에 하나의 연결만 허용하므로 팜 토폴로지에서 Derby 데이터베이스를 사용할 수 없습니다.</li>
                        </ul>
                        데이터베이스에 대한 자세한 정보는 <a href="../databases">데이터베이스 설정</a>을 참조하십시오.
                    </li>
                    <li>팜에서 원하는 멤버 수만큼 독립형 서버를 설정하십시오.
                        <ul>
                            <li>이 독립형 서버는 각각 동일한 데이터베이스와 통신해야 합니다. 이 서버가 사용하는 포트를 동일한 호스트에서 구성된 다른 서버가 사용하지 않는지 확인해야 합니다. 이 제한조건은 HTTP, HTTPS, REST, SOAP 및 RMI 프로토콜에서 사용하는 포트에 적용됩니다.</li>
                            <li>이 서버 각각에는 {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스 및 하나 이상의 {{ site.data.keys.product_adj }} 런타임이 배치되어 있어야 합니다.</li>
                            <li>독립형 토폴로지에서 이 서버 각각이 제대로 작동하는 경우 이 서버를 서버 팜의 멤버로 변환할 수 있습니다.</li>
                        </ul>
                    </li>
                    <li>팜의 멤버가 되도록 되어 있는 모든 서버를 중지하십시오.</li>
                    <li>애플리케이션 서버의 유형에 맞게 적절하게 각 서버를 구성하십시오.<br/>일부 JNDI 특성을 올바르게 설정해야 합니다. 서버 팜 토폴로지에서 mfp.config.service.user 및 mfp.config.service.password JNDI 특성은 팜의 모든 멤버에 대해 동일한 값을 가지고 있어야 합니다. Apache Tomcat의 경우에는 JVM 인수가 제대로 정의되어 있는지도 확인해야 합니다.
                        <ul>
                            <li><b>WebSphere Application Server Liberty 프로파일</b>
                                <br/>
                                server.xml 파일에서 다음 샘플 코드에 표시된 JNDI 특성을 설정하십시오.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="farm_member_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="myRESTConnectorUser"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="password-of-rest-connector-user"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                이 특성은 적절한 값으로 설정되어야 합니다.
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: 이 팜 멤버에 대해 정의된 ID입니다. 이 ID는 모든 팜 멤버에서 고유해야 합니다.</li>
                                    <li><b>mfp.admin.jmx.user</b> 및 <b>mfp.admin.jmx.pwd</b>: 이 값은 <code>administrator-role</code> 요소에서 선언된 대로 사용자의 인증 정보와 일치해야 합니다.</li>
                                    <li><b>mfp.admin.jmx.host</b>: 이 매개변수를 이 서버에 액세스하기 위해 원격 멤버가 사용하는 호스트 이름 또는 IP로 설정하십시오. 따라서 이를 <b>localhost</b>로 설정하지 마십시오. 이 호스트 이름은 팜의 기타 멤버에 의해 사용되며 모든 팜 멤버에 액세스할 수 있어야 합니다.</li>
                                    <li><b>mfp.admin.jmx.port</b>: 이 매개변수를 JMX REST 연결에 사용되는 서버 HTTPS 포트로 설정하십시오. <b>server.xml</b> 파일의 <code>httpEndpoint</code> 요소에서 값을 찾을 수 있습니다.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
<b>conf/server.xml</b> 파일을 수정하여 모든 런타임 컨텍스트 및 관리 서비스 컨텍스트에서 다음과 같은 JNDI 특성을 설정하십시오.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="farm_member_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                <b>mfp.admin.serverid</b> 특성은 이 팜 멤버에 대해 정의된 ID로 설정되어야 합니다. 이 ID는 모든 팜 멤버에서 고유해야 합니다.
                                <br/>
<code>-Djava.rmi.server.hostname</code> JVM 인수가 이 서버에 액세스하기 위해 원격 멤버가 사용하는 호스트 이름 또는 IP로 설정되는지 확인해야 합니다. 따라서 이를 <b>localhost</b>로 설정하지 마십시오. 또한 <code>-Dcom.sun.management.jmxremote.port</code> JVM 인수가 JMX RMI 연결을 사용으로 설정하기 위해 아직 사용되고 있지 않은 포트를 사용하여 설정되어 있는지 확인해야 합니다. 두 인수 모두 <b>CATALINA_OPTS</b> 환경 변수에서 설정됩니다.
                            </li>
                            <li><b>WebSphere Application Server 전체 프로파일</b>
                                <br/>
                                서버에 배치된 모든 런타임 애플리케이션 및 관리 서비스에서 다음과 같은 JNDI 특성을 선언해야 합니다.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                WebSphere Application Server 콘솔에서
                                <ul>
                                    <li><b>애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션</b>을 선택하십시오.</li>
                                    <li>관리 서비스 애플리케이션을 선택하십시오.</li>
                                    <li><b>웹 모듈 특성</b>에서 <b>웹 모듈용 환경 항목</b>을 클릭하여 JNDI 특성을 표시하십시오.</li>
                                    <li>다음과 같은 특성의 값을 설정하십시오.
                                        <ul>
                                            <li><b>mfp.topology.clustermode</b>를 <b>Farm</b>으로 설정하십시오.</li>
                                            <li><b>mfp.admin.serverid</b>를 이 팜 멤버에 대해 선택한 ID로 설정하십시오. 이 ID는 모든 팜 멤버에서 고유해야 합니다.</li>
                                            <li><b>mfp.admin.jmx.user</b>를 SOAP 커넥터에 대한 액세스 권한을 가진 사용자 이름으로 설정하십시오.</li>
                                            <li><b>mfp.admin.jmx.pwd</b>를 <b>mfp.admin.jmx.user</b>에서 선언된 대로 사용자의 비밀번호로 설정하십시오.</li>
                                            <li><b>mfp.admin.jmx.port</b>를 SOAP 포트의 값으로 설정하십시오.</li>
                                        </ul>
                                    </li>
                                    <li><b>mfp.admin.jmx.connector</b>가 <b>SOAP</b>로 설정되어 있는지 확인하십시오.</li>
                                    <li><b>확인</b>을 클릭하고 구성을 저장하십시오.</li>
                                    <li>서버에 배치된 모든 {{ site.data.keys.product_adj }} 런타임 애플리케이션에 대해 유사한 변경을 수행하십시오.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>팜의 모든 멤버 사이에서 신뢰 저장소의 서버 인증서를 교환하십시오. WebSphere Application Server 전체 프로파일 및 WebSphere Application Server Liberty 프로파일을 사용하는 팜에서는 서버 간 통신이 SSL로 보호되므로 이러한 팜의 경우 신뢰 저장소의 서버 인증서 교환은 필수입니다.
                        <ul>
                            <li><b>WebSphere Application Server Liberty 프로파일</b>
                                <br/>
                                 IBM 유틸리티(예: Keytool 또는 iKeyman)를 사용하여 신뢰 저장소를 구성할 수 있습니다.
                                <ul>
                                    <li>Keytool에 대한 자세한 정보는 IBM SDK, Java Technology Edition의 <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a>을 참조하십시오.</li>
                                    <li>iKeyman에 대한 자세한 정보는 IBM SDK, Java Technology Edition의 <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a>을 참조하십시오.</li>
                                </ul>
                                키 저장소 및 신뢰 저장소의 위치는 <b>server.xml</b> 파일에서 정의됩니다. <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">SSL 구성 속성</a>에서 <b>keyStoreRef</b> 및 <b>trustStoreRef</b> 속성을 참조하십시오. 기본적으로 Liberty 프로파일의 키 저장소는 <b>${server.config.dir}/resources/security/key.jks</b>에 있습니다. 신뢰 저장소 참조가 누락되었거나 <b>server.xml</b> 파일에 정의되지 않은 경우 <b>keyStoreRef</b>에 의해 지정된 키 저장소가 사용됩니다. 서버는 기본 키 저장소를 사용하며 파일은 서버가 처음으로 실행될 때 작성됩니다. 이 경우에는 유효 기간이 365일인 기본 인증서가 작성됩니다. 프로덕션의 경우에는 사용자의 자체 인증서(필요한 경우 중간 인증서 포함)를 사용하거나 생성된 인증서의 만기 날짜를 변경해 볼 수 있습니다.

                                <blockquote>참고: 신뢰 저장소의 위치를 확인하려는 경우에는 다음 선언을 server.xml 파일에 추가하여 확인할 수 있습니다.
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                마지막으로 서버를 시작한 후 <b>${wlp.install.dir}/usr/servers/server_name/logs/trace.log</b> 파일에서 com.ibm.ssl.trustStore가 포함된 행을 찾으십시오.
                                <ul>
                                    <li>팜에 있는 다른 서버의 공용 인증서를 서버의 <b>server.xml</b> 구성 파일이 참조하는 신뢰 저장소로 가져오십시오. <a href="../../simple-install/tutorials/graphical-mode">그래픽 모드에서 {{ site.data.keys.mf_server }} 설치</a> 튜토리얼에서는 팜에 있는 두 Liberty 서버 사이에서 인증서를 교환하는 데 필요한 지시사항을 제공합니다. 자세한 정보는 <a href="../../simple-install/tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">{{ site.data.keys.mf_server }}를 실행하는 두 개의 Liberty 서버로 구성된 팜 작성</a> 섹션의 5단계를 참조하십시오.</li>
                                    <li>WebSphere Application Server Liberty 프로파일의 각 인스턴스를 다시 시작하여 보안 구성을 적용하십시오. 싱글 사인온(SSO)이 작동하려면 다음의 단계가 필요합니다.</li>
                                    <li>팜의 한 멤버를 시작하십시오. 기본 LTPA 구성에서는 Liberty 서버가 정상적으로 시작되면 LTPA 키 저장소가 <b>${wlp.user.dir}/servers/server_name/resources/security/ltpa.keys</b>로 생성됩니다.</li>
                                    <li><b>ltpa.keys</b> 파일을 각 팜 멤버의 <b>${wlp.user.dir}/servers/server_name/resources/security</b> 디렉토리에 복사하여 팜 멤버 사이에서 LTPA 키 저장소를 복제하십시오. LTPA 구성에 대한 자세한 정보는 <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Liberty 프로파일에서 LTPA 구성</a>을 참조하십시오.</li>
                                </ul>
                            </li>
                            <li><b>WebSphere Application Server 전체 프로파일</b>
                                <br/>
                                 WebSphere Application Server 관리 콘솔에서 신뢰 저장소를 구성하십시오.
                                <ul>
                                    <li>WebSphere Application Server 관리 콘솔에 로그인하십시오.</li>
                                    <li><b>보안 → SSL 인증서 및 키 관리</b>를 선택하십시오.</li>
                                    <li><b>관련 항목</b>에서 <b>키 저장소 및 인증서</b>를 선택하십시오.</li>
                                    <li><b>키 저장소 사용법</b> 필드에서 <b>SSL 키 저장소</b>가 선택되어 있는지 확인하십시오. 이제 팜의 다른 모든 서버에서 인증서를 가져올 수 있습니다.</li>
                                    <li><b>NodeDefaultTrustStore</b>를 클릭하십시오.</li>
                                    <li><b>추가 특성</b>에서 <b>서명자 인증서</b>를 선택하십시오.</li>
                                    <li><b>포트에서 검색</b>을 클릭하십시오. 이제 팜에 있는 각각의 기타 서버에 대한 통신 및 보안 세부사항을 입력할 수 있습니다. 각각의 기타 팜 멤버에 대해 다음의 단계를 수행하십시오.</li>
                                    <li><b>호스트</b> 필드에 서버 호스트 이름 또는 IP 주소를 입력하십시오.</li>
                                    <li><b>포트</b> 필드에 HTTPS 전송(SSL) 포트를 입력하십시오.</li>
                                    <li><b>아웃바운드 연결의 SSL 구성</b>에서 <b>NodeDefaultSSLSettings</b>를 선택하십시오.</li>
                                    <li><b>별명</b> 필드에 이 서명자 인증서의 별명을 입력하십시오.</li>
                                    <li><b>서명자 정보 검색</b>을 클릭하십시오.</li>
                                    <li>원격 서버에서 검색된 정보를 검토한 후 <b>확인</b>을 클릭하십시오.</li>
                                    <li><b>저장</b>을 클릭하십시오.</li>
                                    <li>서버를 다시 시작하십시오.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### 팜 구성 확인
{: #verifying-a-farm-configuration }
이 태스크의 용도는 팜 멤버의 상태를 확인하고 팜이 제대로 구성되었는지 확인하는 것입니다.

1. 팜의 모든 서버를 시작하십시오.
2. {{ site.data.keys.mf_console }}에 액세스하십시오. 예를 들어, HTTPS의 **https://hostname:secure_port/mfpconsole** 또는 **http://server_name:port/mfpconsole**입니다.
    콘솔 사이드바에 서버 팜 노드로 레이블 지정된 추가 메뉴가 표시됩니다.
3. **서버 팜 노드**를 클릭하여 등록된 팜 멤버 및 해당 상태의 목록에 액세스하십시오. 다음 예에서 **FarmMember2**로 식별되는 노드는 중지되었다고 간주되며 이는 이 서버에 장애가 발생했을 수 있으며 일부 유지보수가 필요함을 나타냅니다.

![{{ site.data.keys.mf_console }}에 있는 팜 노드의 상태](farm_nodes_status_list.jpg)

### 서버 팜 노드의 라이프사이클
{: #lifecycle-of-a-server-farm-node }
영향받는 노드의 상태 변경을 트리거하여 팜 멤버 사이의 가능한 서버 문제점을 표시하기 위해 하트비트 비율 및 제한시간 값을 구성할 수 있습니다.

#### 팜 노드로 서버 등록 및 모니터링
{: #registration-and-monitoring-servers-as-farm-nodes }
팜 노드로 구성된 서버가 시작되면 해당 서버의 관리 서비스가 자동으로 해당 서버를 새 팜 멤버로 등록합니다.
팜 멤버가 종료되면 팜 멤버는 자동으로 팜에서 등록 해제됩니다.

응답할 수 없게 되는(예: 정전 또는 서버 장애로 인해) 팜 멤버를 추적하기 위해 하트비트 메커니즘이 존재합니다. 이 하트비트 메커니즘에서 {{ site.data.keys.product_adj }} 런타임은 지정된 비율로 주기적으로 {{ site.data.keys.product_adj }} 관리 서비스에 하트비트를 전송합니다. {{ site.data.keys.product_adj }} 관리 서비스에서 팜 멤버가 하트비트를 전송한 이후 너무 오랜 시간이 경과했음을 등록하는 경우 팜 멤버는 중지된 것으로 간주됩니다.

중지된 것으로 간주되는 팜 멤버는 모바일 애플리케이션에 추가 요청을 제공하지 않습니다.

하나 이상의 노드가 중지되어도 다른 팜 멤버는 모바일 애플리케이션에 올바르게 요청을 제공하며 {{ site.data.keys.mf_console }}을 통해 트리거되는 새 관리 조작을 승인합니다.

#### 하트비트 비율 및 제한시간 값 구성
{: #configuring-the-heartbeat-rate-and-timeout-values }
다음과 같은 JNDI 특성을 정의하여 하트비트 비율 및 제한시간 값을 구성할 수 있습니다.

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.
