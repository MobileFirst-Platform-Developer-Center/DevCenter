---
layout: tutorial
title: 설치 참조
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_server_full }}, {{ site.data.keys.mf_app_center_full }} 및 {{ site.data.keys.mf_analytics_full }}의 설치에 필요한 Ant 태스크 및 구성 샘플 파일에 대한 참조 정보입니다.

#### 다음으로 이동
{: #jump-to }
* [Ant configuredatabase 태스크 참조](#ant-configuredatabase-task-reference)
* [{{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.mf_server }} 관리 및 라이브 업데이트 서비스 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [{{ site.data.keys.mf_server }} 푸시 서비스 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Application Center 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-application-center)
* [{{ site.data.keys.mf_analytics }} 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [내부 런타임 데이터베이스](#internal-runtime-databases)
* [샘플 구성 파일](#list-of-sample-configuration-files)
* [{{ site.data.keys.mf_analytics }}에 대한 샘플 구성 파일](#sample-configuration-files-for-mobilefirst-analytics)

## Ant configuredatabase 태스크 참조
{: #ant-configuredatabase-task-reference }
configuredatabase Ant 태스크에 대한 참조 정보입니다. 이 참조 정보는 관계형 데이터베이스에만 해당됩니다. Cloudant에는 적용되지 않습니다.

**configuredatabase** Ant 태스크는 {{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 푸시 서비스, {{ site.data.keys.product_adj }} 런타임 및 Application Center 서비스에서 사용하는 관계형 데이터베이스를 작성합니다. 이 Ant 태스크는 다음과 같은 조치를 통해 관계형 데이터베이스를 구성합니다.

* {{ site.data.keys.product_adj }} 테이블이 있는지 확인하여 필요한 경우 해당 테이블을 작성합니다.
* {{ site.data.keys.product }}의 이전 버전에 대해 해당 테이블이 존재하는 경우에는 해당 테이블을 현재 버전으로 마이그레이션합니다.
* {{ site.data.keys.product }}의 현재 버전에 대해 해당 테이블이 존재하는 경우에는 아무것도 수행하지 않습니다.

또한 다음 조건 중 하나가 충족되는 경우:

* DBMS 유형이 Derby입니다.
* 내부 요소 `<dba>`가 있습니다.
* DBMS 유형이 DB2이고 지정된 사용자에게 데이터베이스를 작성할 수 있는 권한이 있습니다.

이 태스크는 다음과 같은 영향을 미칠 수 있습니다.

* 필요한 경우 데이터베이스를 작성하십시오(Oracle 12c 및 Cloudant의 경우는 제외).
* 사용자를 작성하고 필요한 경우 해당 사용자에게 데이터베이스에 대한 액세스 권한을 부여하십시오.

> **참고:** Cloudant와 함께 사용하는 경우 configuredatabase Ant 태스크는 영향을 미치지 않습니다.

### configuredatabase 태스크에 대한 속성 및 요소
{: #attributes-and-elements-for-configuredatabase-task }

**configuredatabase** 태스크는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명 |필수 |기본값 |
|-----------|-------------|----------|---------|
|kind      |데이터베이스의 유형: {{ site.data.keys.mf_server }}에서 : MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin 또는 푸시. Application Center에서: ApplicationCenter. |예 |없음 |
|includeConfigurationTables |라이브 업데이트 서비스와 관리 서비스 모두에서 데이터베이스 조작을 수행할지 아니면 관리 서비스에서만 데이터베이스 조작을 수행할지를 지정합니다. 값은 true 또는 false입니다. |아니오 |true |
|execute |configuredatabase Ant 태스크를 실행할지 여부를 지정합니다. 값은 true 또는 false입니다. |아니오 |true |

#### kind
{: #kind }
{{ site.data.keys.product }}은 네 가지 유형의 데이터베이스를 지원합니다. {{ site.data.keys.product_adj }} 런타임은 **MobileFirstRuntime** 데이터베이스를 사용합니다. {{ site.data.keys.mf_server }} 관리 서비스는 **MobileFirstAdmin** 데이터베이스를 사용합니다. {{ site.data.keys.mf_server }} 라이브 업데이트 서비스는 **MobileFirstConfig** 데이터베이스를 사용합니다. 기본적으로 이는 **MobileFirstAdmin** 유형을 사용하여 작성됩니다. {{ site.data.keys.mf_server }} 푸시 서비스는 **push** 데이터베이스를 사용합니다. Application Center는 **ApplicationCenter** 데이터베이스를 사용합니다.

#### includeConfigurationTables
{: #includeconfigurationtables }
**includeConfigurationTables** 속성은 **kind** 속성이 **MobileFirstAdmin**인 경우에만 사용할 수 있습니다. 올바른 값은 true 또는 false입니다. 이 속성이 true로 설정되면 **configuredatabase** 태스크는 하나의 실행으로 관리 서비스 데이터베이스와 라이브 업데이트 서비스 데이터베이스 모두에서 데이터베이스 조작을 수행합니다. 이 속성이 false로 설정되면 **configuredatabase** 태스크는 관리 서비스 데이터베이스에서만 데이터베이스 조작을 수행합니다.

#### execute
{: #execute }
**execute** 속성은 **configuredatabase** Ant 태스크의 실행을 사용 또는 사용 안함으로 설정합니다. 올바른 값은 true 또는 false입니다. 이 속성이 false로 설정되면 **configuredatabase** 태스크는 구성 또는 데이터베이스 조작을 수행하지 않습니다.

**configuredatabase** 태스크는 다음과 같은 요소를 지원합니다.

|요소             |설명	                |개수 |
|---------------------|-----------------------------|-------|
| `<derby>`           |Derby에 대한 매개변수입니다.   |0..1  |
| `<db2>`             |	DB2에 대한 매개변수입니다.     |0..1  |
| `<mysql>`           |	MySQL에 대한 매개변수입니다.   |0..1  |
| `<oracle>`          |	Oracle에 대한 매개변수입니다.  |0..1  |
| `<driverclasspath>` |JDBC 드라이버 클래스 경로입니다. |0..1  |

각 데이터베이스 유형에 대해 `<property>` 요소를 사용하여 데이터베이스에 액세스하는 데 필요한 JDBC 연결 특성을 지정할 수 있습니다. `<property>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명                |필수 |기본값 |
|-----------|----------------------------|----------|---------|
|이름      |특성의 이름입니다.	 |예      |없음    |
|value	    |특성의 값입니다.|예	    |없음    |   

#### Apache Derby
{: #apache-derby }
`<derby>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명                                |필수 |기본값                                                                      |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
|database  |데이터베이스 이름입니다.                         |아니오	    |유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR             |
|datadir   |데이터베이스가 포함된 디렉토리입니다. |예      |없음                                                                         |
|schema	|스키마 이름입니다.                           |아니오       |유형에 따라 MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH 또는 APPCENTER |

`<derby>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                     |개수   |
|--------------|---------------------------------|---------|
| `<property>` |JDBC 연결 특성입니다.   |0..∞    |

사용 가능한 특성은 [데이터베이스 연결 URL의 속성 설정](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html)을 참조하십시오.

#### DB2
{: #db2 }
`<db2>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명                            |필수 |기본값 |
|-----------|----------------------------------------|----------|---------|
|database  |데이터베이스 이름입니다.                     |아니오       |유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR |
|server    |데이터베이스 서버의 호스트 이름입니다.	 |예      |없음  |
|port      |데이터베이스 서버의 포트입니다.       |아니오	    |50000 |
|user      |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. |예	    |없음  |
|비밀번호  |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	 |아니오	    |대화식으로 조회됨 |
|instance  |DB2 인스턴스의 이름입니다.          |아니오	    |서버에 따라 다름 |
|schema    |스키마 이름입니다.                       |아니오	    |사용자에 따라 다름   |

DB2 사용자 계정에 대한 자세한 정보는 [DB2 보안 모델 개요](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)를 참조하십시오.  
`<db2>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                             |개수   |
|--------------|-----------------------------------------|---------|
| `<property>` |JDBC 연결 특성입니다.           |0..∞    |
| `<dba>`      |데이터베이스 관리자 신임 정보입니다. |0..1    |

사용 가능한 특성은 [IBM Data Server Driver for JDBC and SQLJ에 대한 특성](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)을 참조하십시오.  
내부 요소 `<dba>`는 데이터베이스 관리자의 신임 정보를 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명                            |필수 |기본값 |
|-----------|----------------------------------------|----------|---------|
|user      |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다.  |예      |없음    |
|비밀번호  |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.    |아니오	    |대화식으로 조회됨 |

`<dba>` 요소에 지정된 사용자는 SYSADM 또는 SYSCTRL DB2 권한이 있어야 합니다. 자세한 정보는 [권한 개요](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html)를 참조하십시오.

`<driverclasspath>` 요소에는 DB2 JDBC 드라이버 및 관련 라이센스의 JAR 파일이 있어야 합니다. 다음 방법 중 하나로 해당 파일을 검색할 수 있습니다.

* [DB2 JDBC 드라이버 버전](http://www.ibm.com/support/docview.wss?uid=swg21363866) 페이지에서 DB2 JDBC 드라이버 다운로드
* 또는 DB2 서버의 **DB2_INSTALL_DIR/java** 디렉토리에서 **db2jcc4.jar** 파일 및 관련 **db2jcc_license_*.jar** 파일을 페치하십시오.

Ant 태스크를 사용하여 테이블스페이스 등의 테이블 할당에 대한 세부사항을 지정할 수 없습니다. 테이블스페이스를 제어하려면 [DB2 데이터베이스 및 사용자 요구사항](../prod-env/databases/#db2-database-and-user-requirements) 절에 있는 수동 지시사항을 사용해야 합니다.

#### MySQL
{: #mysql }
`<mysql>` 요소에는 다음 속성이 있습니다.

|속성 |설명                            |필수 |기본값 |
|-----------|----------------------------------------|----------|---------|
|database	|데이터베이스 이름입니다.	                 |아니오       |유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR |
|server	|데이터베이스 서버의 호스트 이름입니다.	 |예	    |없음 |
|port	    |데이터베이스 서버의 포트입니다.	     |아니오	    |3306 |
|user	    |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. |예	    |없음 |
|password	|데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	 |아니오	    |대화식으로 조회됨 |

MySQL 사용자 계정에 대한 자세한 정보는 [MySQL 사용자 계정 관리](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html)를 참조하십시오.  
`<mysql>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                                      |개수 |
|--------------|--------------------------------------------------|-------|
| `<property>` |JDBC 연결 특성입니다.                    |0..∞  |
| `<dba>`      |데이터베이스 관리자 신임 정보입니다.          |0..1  |
| `<client>`   |데이터베이스에 대한 액세스가 허용되는 호스트입니다. |0..∞  |

사용 가능한 특성은 [Connector/J에 대한 드라이버/데이터 소스 클래스 이름, URL 구문 및 구성 특성](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html)을 참조하십시오.  
내부 요소 `<dba>`는 데이터베이스 관리자 신임 정보를 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명                            |필수 |기본값 |
|-----------|----------------------------------------|----------|---------|
|user	    |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. |예	    |없음 |
|password	|데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	 |아니오	    |대화식으로 조회됨 |

`<dba>` 요소에 지정된 사용자는 MySQL 수퍼유저 계정이어야 합니다. 자세한 정보는 [초기 MySQL 계정 보호](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html)를 참조하십시오.

각 `<client>` 내부 요소는 클라이언트 컴퓨터 또는 클라이언트 컴퓨터의 와일드카드를 지정하는 데 사용합니다. 이 컴퓨터는 데이터베이스에 연결할 수 있습니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명                                                              |필수 |기본값 |
|-----------|--------------------------------------------------------------------------|----------|---------|
|hostname	|%가 플레이스홀더인 기호 호스트 이름, IP 주소 또는 템플리트입니다. |예	  |없음    |

hostname 구문에 대한 자세한 정보는 [계정 이름 지정](http://dev.mysql.com/doc/refman/5.5/en/account-names.html)을 참조하십시오.

`<driverclasspath>` 요소에는 MySQL Connector/J JAR 파일이 있어야 합니다. [Connector/J 다운로드](http://www.mysql.com/downloads/connector/j/) 페이지에서 해당 파일을 다운로드할 수 있습니다.

또는 다음 속성이 있는 `<mysql>` 요소를 사용할 수 있습니다.

|속성 |설명                            |필수 |기본값               |
|-----------|----------------------------------------|----------|-----------------------|
|url       |데이터베이스 연결 URL입니다.	         |예      |없음                  |
|user	    |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. |예      |없음                  |
|password	|데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	 |아니오       |대화식으로 조회됨 |

> `참고:` 대체 속성을 사용하여 데이터베이스를 지정하는 경우에는 이 데이터베이스가 존재해야 하고 사용자 계정이 존재해야 하고 사용자가 이미 데이터베이스에 액세스할 수 있어야 합니다. 이 경우 **configuredatabase** 태스크는 데이터베이스 또는 사용자 작성을 시도하지 않고 사용자에 대한 액세스 권한 부여도 시도하지 않습니다. **configuredatabase** 태스크는 데이터베이스에 현재 {{ site.data.keys.mf_server }} 버전에 대한 필수 테이블이 있는지만 확인합니다. 내부 요소 `<dba>` 또는 `<client>`.

#### Oracle
{: #oracle }
`<oracle>` 요소에는 다음 속성이 있습니다.

|속성      |설명                                                              |필수 |기본값 |
|----------------|--------------------------------------------------------------------------|----------|---------|
|database       |데이터베이스 이름 또는 Oracle 서비스 이름입니다. **참고:** 항상 서비스 이름을 사용하여 PDB 데이터베이스에 연결해야 합니다. |아니오 |ORCL |
|server	     |데이터베이스 서버의 호스트 이름입니다.                                    |예      |없음 |
|port	         |데이터베이스 서버의 포트입니다.                                         |아니오       |1521 |
|user	         |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 테이블 아래의 참고를 참조하십시오.	|예      |없음 |
|password	     |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.                                    |아니오       |대화식으로 조회됨 |
|sysPassword	 |사용자 SYS에 대한 비밀번호입니다.                                           |아니오       |데이터베이스가 아직 없는 경우 대화식으로 조회됨 |
|systemPassword |사용자 SYSTEM에 대한 비밀번호입니다.                                        |아니오       |데이터베이스 또는 사용자가 아직 없는 경우 대화식으로 조회됨 |

> `참고:` user 속성의 경우 대문자로 된 사용자 이름을 사용하는 것이 좋습니다. Oracle 사용자 이름은 일반적으로 대문자입니다. 다른 데이터베이스 도구와 달리 **configuredatabase** Ant 태스크는 사용자 이름의 소문자를 대문자로 변환하지 않습니다. **configuredatabase** Ant 태스크가 데이터베이스에 연결하는 데 실패하면 **user** 속성에 대한 값을 대문자로 입력하십시오.

Oracle 사용자 계정에 대한 자세한 정보는 [인증 방법 개요](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374)를 참조하십시오.  
`<oracle>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                                      |개수 |
|--------------|--------------------------------------------------|-------|
| `<property>` |JDBC 연결 특성입니다.                    |0..∞  |
| `<dba>`      |데이터베이스 관리자 신임 정보입니다.          |0..1  |

사용 가능한 연결 특성에 대한 정보는 [클래스 OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html)를 참조하십시오.  
내부 요소 `<dba>`는 데이터베이스 관리자 신임 정보를 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성      |설명                                                              |필수 |기본값 |
|----------------|--------------------------------------------------------------------------|----------|---------|
|user	         |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 테이블 아래의 참고를 참조하십시오.	|예      |없음    |
|password	     |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.                                    |아니오       |대화식으로 조회됨 |

`<driverclasspath>` 요소에는 Oracle JDBC 드라이버 JAR 파일이 있어야 합니다. [JDBC, SQLJ, Oracle JPublisher 및 UCP(Universal Connection Pool)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html)에서 Oracle JDBC 드라이버를 다운로드할 수 있습니다.

Ant 태스크를 사용하여 테이블스페이스 등의 테이블 할당에 대한 세부사항을 지정할 수 없습니다. 테이블스페이스를 제어하려면 Ant 태스크를 실행하기 전에 수동으로 사용자 계정을 작성하여 이 사용자 계정에 기본 테이블스페이스를 지정하십시오. 기타 세부사항을 제어하려면 [Oracle 데이터베이스 및 사용자 요구사항](../prod-env/databases/#oracle-database-and-user-requirements) 절에 있는 수동 지시사항을 사용해야 합니다.

|속성 |설명                            |필수 |기본값               |
|-----------|----------------------------------------|----------|-----------------------|
|url       |데이터베이스 연결 URL입니다.	         |예      |없음                  |
|user	    |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. |예      |없음                  |
|password	|데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	 |아니오       |대화식으로 조회됨 |

> **참고:** 대체 속성을 사용하여 데이터베이스를 지정하는 경우에는 이 데이터베이스가 존재해야 하고 사용자 계정이 존재해야 하고 사용자가 이미 데이터베이스에 액세스할 수 있어야 합니다. 이 경우 태스크는 데이터베이스 또는 사용자 작성을 시도하지 않고 사용자에 대한 액세스 권한 부여도 시도하지 않습니다. **configuredatabase** 태스크는 데이터베이스에 현재 {{ site.data.keys.mf_server }} 버전에 대한 필수 테이블이 있는지만 확인합니다. 내부 요소 `<dba>`를 지정하지 않아도 됩니다.

## {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.mf_server }} 관리 및 라이브 업데이트 서비스 설치를 위한 Ant 태스크
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
**installmobilefirstadmin**, **updatemobilefirstadmin** 및 **uninstallmobilefirstadmin** Ant 태스크는 {{ site.data.keys.mf_console }}, 아티팩트 컴포넌트, 관리 서비스 및 라이브 업데이트 서비스 설치를 위해 제공됩니다.

### 태스크 영향
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
**installmobilefirstadmin** Ant 태스크는 관리 및 라이브 업데이트 서비스의 WAR 파일을 웹 애플리케이션으로 실행하고 선택적으로 {{ site.data.keys.mf_console }}을 설치하도록 애플리케이션 서버를 구성합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 지정된 컨텍스트 루트(기본값 /mfpadmin)에서 관리 서비스 웹 애플리케이션을 선언합니다.
* 관리 서비스의 지정된 컨텍스트 루트에서 파생된 컨텍스트 루트에서 라이브 업데이트 서비스 웹 애플리케이션을 선언합니다. 기본값은 /mfpadminconfig입니다.
* 관계형 데이터베이스의 경우 데이터 소스를 선언하며 WebSphere Application Server 전체 프로파일에서는 관리 서비스에 대한 JDBC 제공자를 선언합니다.
* 관리 서비스 및 라이브 업데이트 서비스를 애플리케이션 서버에 배치합니다.
* 선택적으로 지정된 컨텍스트 루트(기본값은 /mfpconsole)에서 {{ site.data.keys.mf_console }}을 웹 애플리케이션으로 선언합니다. {{ site.data.keys.mf_console }} 인스턴스가 지정된 경우 Ant 태스크는 해당 관리 서비스와 통신하기 위해 적절한 JNDI 환경 항목을 선언합니다. 예를 들어, 다음과 같습니다.

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* 선택적으로 {{ site.data.keys.mf_console }}이 설치된 경우 지정된 컨텍스트 루트 /mfp-dev-artifacts에서 {{ site.data.keys.mf_server }} 아티팩트 웹 애플리케이션을 선언합니다.
* JNDI 환경 항목을 사용하여 관리 서비스에 대한 구성 특성을 구성합니다. 이 JNDI 환경 항목은 애플리케이션 서버 토폴로지에 대한 일부 추가 정보도 제공합니다(예: 해당 토폴로지가 독립형 구성, 클러스터 또는 서버 팜인지 여부).
* 선택적으로 {{ site.data.keys.mf_console }}과 관리 및 라이브 업데이트 서비스 웹 애플리케이션에서 사용하는 역할에 맵핑되는 사용자를 구성합니다.
* JMX 사용을 위해 애플리케이션 서버를 구성합니다.
* 선택적으로 {{ site.data.keys.mf_server }} 푸시 서비스와의 통신을 구성합니다.
* 선택적으로 MobileFirst JNDI 환경 항목을 설정하여 애플리케이션 서버를 {{ site.data.keys.mf_server }} 관리 파트의 서버 팜 멤버로 구성합니다.

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
**updatemobilefirstadmin** Ant 태스크는 애플리케이션 서버에서 이미 구성된 {{ site.data.keys.mf_server }} 웹 애플리케이션을 업데이트합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 관리 서비스 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.
* 라이브 업데이트 서비스 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.
* {{ site.data.keys.mf_console }} WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.
이 태스크는 웹 애플리케이션 구성, 데이터 소스, JNDI 환경 항목, 사용자 대 역할 맵핑 및 JMX 구성 등의 애플리케이션 서버 구성을 변경하지 않습니다.

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
**uninstallmobilefirstadmin** Ant 태스크는 installmobilefirstadmin의 이전 실행의 영향을 실행 취소합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 지정된 컨텍스트 루트를 가진 관리 서비스 웹 애플리케이션의 구성을 제거합니다. 그 결과 이 태스크는 해당 애플리케이션에 수동으로 추가된 설정도 제거합니다.
* {{ site.data.keys.mf_console }}과 관리 및 라이브 업데이트 서비스의 WAR 파일을 옵션으로 애플리케이션 서버에서 제거합니다.
* 관계형 DBMS의 경우 데이터 소스를 제거하며 WebSphere Application Server 전체 프로파일에서는 관리 및 라이브 업데이트 서비스에 대한 JDBC 제공자를 제거합니다.
* 관계형 DBMS의 경우 관리 및 라이브 업데이트 서비스에서 사용한 데이터베이스 드라이버를 애플리케이션 서버에서 제거합니다.
* 연관된 JNDI 환경 항목을 제거합니다.
* WebSphere Application Server Liberty 및 Apache Tomcat의 경우 installmobilefirstadmin 호출에 의해 구성된 사용자를 제거합니다.
* JMX 구성을 제거합니다.

### 속성 및 요소
{: #attributes-and-elements }
**installmobilefirstadmin**, **updatemobilefirstadmin** 및 **uninstallmobilefirstadmin** Ant 태스크는 다음과 같은 속성을 가지고 있습니다.

|속성         |설명                                                              |필수 |기본값 |
|-------------------|--------------------------------------------------------------------------|----------|---------|
|contextroot       |{{ site.data.keys.product_adj }} 런타임 환경, 애플리케이션 및 어댑터에 대한 정보를 얻기 위한 관리 서비스에 대한 URL의 공통 접두부입니다. |아니오 |/mfpadmin |
|id                |다른 배치를 구별합니다.              |아니오 |비어 있음 |
|environmentId     |다른 {{ site.data.keys.product_adj }} 환경을 구별합니다. |아니오 |비어 있음 |
|servicewar        |관리 서비스에 대한 WAR 파일입니다.       |아니오 |mfp-admin-service.war 파일은 mfp-ant-deployer.jar 파일과 동일한 디렉토리에 있습니다. |
|shortcutsDir      |바로 가기를 배치할 디렉토리입니다.            |아니오 |없음 |
|wasStartingWeight |WebSphere Application Server에 대한 시작 순서입니다. 값이 작을수록 먼저 시작됩니다. |아니오 |1 |

#### contextroot 및 id
{: #contextroot-and-id }
**contextroot** 및 **id** 속성은 {{ site.data.keys.mf_console }} 및 관리 서비스의 다른 배치를 구별합니다.

WebSphere Application Server Liberty 프로파일 및 Tomcat 환경에서는 contextroot 매개변수로도 이 용도를 충족합니다. WebSphere Application Server 전체 프로파일 환경에서는 id 속성이 대신 사용됩니다. 이 id 속성이 없으면 컨텍스트 루트가 동일한 두 개의 WAR 파일이 충돌하여 이들 파일이 배치되지 않습니다.

#### environmentId
{: #environmentid }
독립적으로 작동해야 하는 {{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.product_adj }} 런타임 웹 애플리케이션으로 각각 구성된 여러 환경을 구별하려면 **environmentId** 속성을 사용하십시오. 예를 들어, 이 옵션을 사용하면 동일한 서버 또는 동일한 WebSphere Application Server Network Deployment 셀에서 테스트 환경, 사전 프로덕션 환경 및 프로덕션 환경을 호스팅할 수 있습니다. 이 environmentId 속성은 관리 서비스 및 {{ site.data.keys.product_adj }} 런타임 프로젝트가 JMX(Java Management Extensions)를 통해 통신할 때 사용하는 MBean 이름에 추가되는 접미부를 작성합니다.

#### servicewar
{: #servicewar }
관리 서비스 WAR 파일에 대해 다른 디렉토리를 지정하려면 **servicewar** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

#### shortcutsDir
{: #shortcutsdir }
**shortcutsDir** 속성은 {{ site.data.keys.mf_console }}에 대한 바로 가기를 배치할 위치를 지정합니다. 이 속성을 설정하는 경우에는 다음과 같은 파일을 해당 디렉토리에 추가할 수 있습니다.

* **mobilefirst-console.url** - 이 파일은 Windows 바로 가기입니다. 이 파일은 브라우저에서 {{ site.data.keys.mf_console }}을 엽니다.
* **mobilefirst-console.sh**- 이 파일은 UNIX 쉘 스크립트이며 브라우저에서 {{ site.data.keys.mf_console }}을 엽니다.
* **mobilefirst-admin-service.url** - 이 파일은 Windows 바로 가기입니다. 이 파일은 브라우저에서 열리며 JSON 형식으로 관리될 수 있는 {{ site.data.keys.product_adj }} 프로젝트의 목록을 리턴하는 REST 서비스를 호출합니다. 나열된 각각의 {{ site.data.keys.product_adj }} 프로젝트에 대해 해당 아티팩트에 대한 일부 세부사항(예: 애플리케이션 수, 어댑터 수, 활성 디바이스 수, 해제된 디바이스 수)도 확인할 수 있습니다. 목록에는 {{ site.data.keys.product_adj }} 프로젝트 런타임이 실행 중인지 아니면 유휴 상태인지도 표시됩니다.
* **mobilefirst-admin-service.sh** - 이 파일은 **mobilefirst-admin-service.url** 파일과 동일한 출력을 제공하는 UNIX 쉘 스크립트입니다.

#### wasStartingWeight
{: #wasstartingweight }
WebSphere Application Server에서 사용되는 값을 가중치로 지정하여 시작 순서를 존중하게 하려면 **wasStartingWeight** 속성을 사용하십시오. 시작 순서 값의 결과로 다른 {{ site.data.keys.product_adj }} 런타임 프로젝트보다 먼저 관리 서비스 웹 애플리케이션이 배치되고 시작됩니다. 웹 애플리케이션보다 먼저 {{ site.data.keys.product_adj }} 프로젝트가 배치되거나 시작되면 JMX 통신이 설정되지 않고 런타임이 관리 서비스 데이터베이스와 동기화할 수 없어 서버 요청을 처리할 수 없습니다.

**installmobilefirstadmin**, **updatemobilefirstadmin** 및 **uninstallmobilefirstadmin** Ant 태스크는 다음과 같은 요소를 지원합니다.

|요소               |설명                                      |개수 |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` |애플리케이션 서버입니다.                          |1     |
| `<configuration>`     |라이브 업데이트 서비스입니다.	                       |1     |
| `<console>`           |관리 콘솔입니다.                      |0..1  |
| `<database>`          |데이터베이스입니다.                                   |1     |
| `<jmx>`               |JMX(Java Management Extensions)를 사용으로 설정합니다.	           |1     |
| `<property>`          |특성입니다.	                               |0..   |
| `<push>`              |푸시 서비스.	                               |0..1  |
| `<user>`              |보안 역할에 맵핑될 사용자입니다.	       |0..   |

### {{ site.data.keys.mf_console }} 지정
{: #to-specify-a-mobilefirst-operations-console }
`<console>` 요소는 {{ site.data.keys.mf_console }}의 설치를 사용자 정의하는 정보를 수집합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성         |설명                                                               |필수 |기본값     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
|contextroot       |{{ site.data.keys.mf_console }}의 URI입니다.                            |아니오       |/mfpconsole |
|install           |{{ site.data.keys.mf_console }}을 설치해야 하는지 여부를 표시합니다. |아니오       |예         |
|warfile           |콘솔 WAR 파일입니다.	                                                    |아니오        |mfp-admin-ui.war 파일은 mfp-ant-deployer.jar 파일과 동일한 디렉토리에 있습니다. |

`<console>` 요소에서는 다음 요소를 지원합니다.

|요소               |설명                                      |개수 |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         |{{ site.data.keys.mf_server }} 아티팩트입니다.                |0..1  |
| `<property>`	        |특성입니다.	                               |0..   |

`<artifacts>` 요소에는 다음과 같은 속성이 있습니다.

|속성         |설명                                                               |필수 |기본값     |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
|install           |아티팩트 컴포넌트를 설치해야 하는지 여부를 표시합니다.            |아니오       |true        |
|warFile           |아티팩트 WAR 파일입니다.                                                   |아니오       |mfp-dev-artifacts.war 파일은 mfp-ant-deployer.jar 파일과 동일한 디렉토리에 있습니다. |

이 요소를 사용하면 자체 JNDI 특성을 정의하거나 {{ site.data.keys.mf_console }} WAR 파일 및 관리 서비스에서 제공하는 JNDI 특성의 기본값을 대체할 수 있습니다.

`<property>` 요소는 Application Server에 정의할 배치 특성을 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성  |설명                |필수 |기본값 |
|------------|----------------------------|----------|---------|
|이름       |특성의 이름입니다.  |예      |없음    |
|value	     |특성의 값입니다. |	예      |없음    |

이 요소를 사용하면 자체 JNDI 특성을 정의하거나 {{ site.data.keys.mf_console }} WAR 파일 및 관리 서비스에서 제공하는 JNDI 특성의 기본값을 대체할 수 있습니다.

JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.

### 애플리케이션 서버 지정
{: #to-specify-an-application-server }
`<applicationserver>` 요소를 사용하여 기본 Application Server에 따라 다른 매개변수를 정의하십시오. `<applicationserver>` 요소에서는 다음 요소를 지원합니다.

|요소                                   |설명                                      |개수 |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` 또는 `<was>` |WebSphere Application Server에 대한 매개변수입니다. <br/><br/>`<websphereapplicationserver>` 요소(줄여서 `was>`)는 WebSphere Application Server 인스턴스를 나타냅니다. WebSphere Application Server 전체 프로파일(Base 및 Network Deployment)이 지원되므로 WebSphere Application Server Liberty Core 및 WebSphere Application Server Liberty Network Deployment도 지원됩니다.               |0..1  |
| `<tomcat>`                                |Apache Tomcat에 대한 매개변수입니다.	               |0..1  |

이 요소의 속성 및 내부 요소가 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블에 설명되어 있습니다.  
그러나 Liberty Collective에 대한 `<was>` 요소의 내부 요소는 다음 테이블을 참조하십시오.

|요소                  |설명                      |개수 |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` |Liberty Collective 제어기입니다. |	0..1  |

`<collectiveController>` 요소에는 다음과 같은 속성이 있습니다.

|속성                |설명                            |필수 |기본값 |
|--------------------------|----------------------------------------|----------|---------|
|serverName               |Collective 제어기의 이름입니다.	|예      |없음    |
|controllerAdminName      |Collective 제어기에서 정의되는 관리 사용자 이름입니다. 이 이름은 새 멤버를 Collective에 결합하는 데 사용되는 사용자와 동일한 사용자입니다.                                                         |예      |없음    |
|controllerAdminPassword  |관리 사용자 비밀번호입니다.	    |예      |없음    |
|createControllerAdmin    |Collective 제어기의 기본 레지스트리에서 관리 사용자를 작성해야 하는지 여부를 표시합니다. 가능한 값은 true 또는 false입니다.                                                              |아니오	   |true    |

### 라이브 업데이트 서비스 구성 지정
{: #to-specify-the-live-update-service-configuration }
`<configuration>` 요소는 라이브 업데이트 서비스에 따라 달라지는 매개변수를 정의하는 데 사용합니다. `<configuration>` 요소에는 다음과 같은 속성이 있습니다.

|속성                |설명                                                    |필수 |기본값 |
|--------------------------|----------------------------------------------------------------|----------|---------|
|install                  |라이브 업데이트 서비스를 설치해야 하는지 여부를 표시합니다.	|예 |true |
|configAdminUser	       |라이브 업데이트 서비스의 관리자입니다.	                |아니오(서버 팜 토폴로지의 경우에는 필수임) |정의되지 않은 경우에는 사용자가 생성됩니다. 서버 팜 토폴로지에서는 팜에 있는 모든 멤버의 사용자 이름이 동일해야 합니다. |
|configAdminPassword      |라이브 업데이트 서비스 사용자에 대한 관리자 비밀번호입니다.       |**configAdminUser**에 대해 사용자가 지정된 경우 |없음. 서버 팜 토폴로지에서는 팜에 있는 모든 멤버의 비밀번호가 동일해야 합니다. |
|createConfigAdminUser	   |관리자가 누락된 경우 애플리케이션 서버의 기본 레지스트리에서 관리자를 작성할지 여부를 표시합니다. |아니오 |true |
|warFile                  |라이브 업데이트 서비스 WAR 파일입니다.	                            |아니오         |mfp-live-update.war 파일은 mfp-ant-deployer.jar 파일과 동일한 디렉토리에 있습니다. |

`<configuration>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                           |개수 |
|--------------|---------------------------------------|-------|
| `<user>`     |라이브 업데이트 서비스의 사용자입니다. |0..1  |
| `<property>` |특성입니다.	                   |0..   |

`<user>` 요소는 애플리케이션의 특정 보안 역할에 포함할 사용자에 대한 매개변수를 수집하는 데 사용합니다.

|속성   |설명                                                             |필수 |기본값 |
|-------------|-------------------------------------------------------------------------|----------|---------|
|role	      |애플리케이션에 대한 올바른 보안 역할입니다. 가능한 값: configadmin.	|예      |없음    |
|name	      |사용자 이름입니다.	                                                        |예      |없음    |
|password	  |사용자를 작성해야 하는 경우 비밀번호입니다.	                        |아니오       |없음    |

`<user>` 요소를 사용하여 사용자를 정의한 다음 {{ site.data.keys.mf_console }}에서 인증을 위해 `configadmin` 역할에 해당 사용자를 맵핑할 수 있습니다.

특정 역할이 의미하는 권한에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리에 대한 사용자 인증 구성](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)을 참조하십시오.

> **팁:** 사용자가 외부 LDAP 디렉토리에 있는 경우에는 **role** 및 **name** 속성만 설정하고 비밀번호는 정의하지 마십시오.

`<property>` 요소는 Application Server에 정의할 배치 특성을 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성  |설명                |필수 |기본값 |
|------------|----------------------------|----------|---------|
|이름       |특성의 이름입니다.  |예      |없음    |
|value	     |특성의 값입니다. |	예      |없음    |

이 요소를 사용하면 자체 JNDI 특성을 정의하거나 {{ site.data.keys.mf_console }} WAR 파일 및 관리 서비스에서 제공하는 JNDI 특성의 기본값을 대체할 수 있습니다. JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)을 참조하십시오.

### 애플리케이션 서버 지정
{: #to-specify-an-application-server-1 }
`<applicationserver>` 요소를 사용하여 기본 Application Server에 따라 다른 매개변수를 정의하십시오. `<applicationserver>` 요소에서는 다음 요소를 지원합니다.

|요소      |설명                                              |개수 |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` 또는 `<was>`	|WebSphere Application Server에 대한 매개변수입니다.<br/><br/><websphereapplicationserver> 요소(줄여서 <was>)는 WebSphere Application Server 인스턴스를 나타냅니다. WebSphere Application Server 전체 프로파일(Base 및 Network Deployment)이 지원되므로 WebSphere Application Server Liberty Core 및 WebSphere Application Server Liberty Network Deployment도 지원됩니다. |0..1  |
| `<tomcat>`   |Apache Tomcat에 대한 매개변수입니다.                        |0..1  |

이 요소의 속성 및 내부 요소가 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블에 설명되어 있습니다.  
하지만 Liberty Collective에 대한 <was> 요소의 내부 요소에 대해서는 다음 테이블을 참조하십시오.

|요소               |설명                  |개수 |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	|Liberty Collective 멤버입니다. |0..1  |

`<collectiveMember>` 요소에는 다음과 같은 속성이 있습니다.

|속성   |설명                                             |필수 |기본값 |
|-------------|---------------------------------------------------------|----------|---------|
|serverName  |	Collective 멤버의 이름입니다.                      |예      |없음    |
|clusterName |	Collective 멤버가 속하는 클러스터 이름입니다. |예	   |없음    |

> **참고:** 푸시 서비스와 런타임 컴포넌트가 동일한 Collective 멤버에 설치되는 경우 이들은 동일한 클러스터 이름을 가지고 있어야 합니다. 이 컴포넌트가 동일한 Collective의 구별되는 멤버에 설치되는 경우 클러스터 이름은 다를 수 있습니다.

### Analytics 지정
{: #to-specify-analytics }
`<analytics>` 요소는 {{ site.data.keys.product_adj }} 푸시 서비스를 이미 설치된 {{ site.data.keys.mf_analytics }} 서비스에 연결하려 함을 나타냅니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성     |설명                                                               |필수 |기본값 |
|---------------|---------------------------------------------------------------------------|----------|---------|
|install	    |푸시 서비스를 {{ site.data.keys.mf_analytics }}에 연결할지 여부를 표시합니다. |아니오       |false   |
|analyticsURL 	|{{ site.data.keys.mf_analytics }} 서비스의 URL입니다.	                            |예	   |없음    |
|username	    |사용자 이름입니다.	                                                        |예	   |없음    |
|password	    |비밀번호입니다.	                                                            |예	   |없음    |
|validate	    |{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증합니다.	|아니오	   |true    |

**install**  
이 푸시 서비스가 연결되어야 하고 이벤트를 {{ site.data.keys.mf_analytics }}에 전송해야 함을 표시하려면 install 속성을 사용하십시오. 올바른 값은 true 또는 false입니다.

**analyticsURL**  
수신되는 Analytics 데이터를 수신하는 {{ site.data.keys.mf_analytics }}에 의해 노출되는 URL을 지정하려면 analyticsURL 속성을 사용하십시오.

예: `http://<hostname>:<port>/analytics-service/rest`

**username**  
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름을 지정하려면 username 속성을 사용하십시오.

**password**  
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호를 지정하려면 password 속성을 사용하십시오.

**validate**  
{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증하고 비밀번호를 사용하여 사용자 이름 인증을 확인하려면 validate 속성을 사용하십시오. 가능한 값은 true 또는 false입니다.

### 푸시 서비스 데이터베이스에 대한 연결 지정
{: #to-specify-a-connection-to-the-push-service-database }

`<database>` 요소는 Application Server에서 데이터 소스 선언을 지정하는 매개변수를 수집하여 푸시 서비스 데이터베이스에 액세스합니다.

다음과 같은 단일 데이터베이스를 선언해야 합니다. `<database kind="Push">`. `<database>` 요소에는 `<dba>` 및 `<client>` 요소가 없다는 점을 제외하고, `<database>` 요소를 configuredatabase Ant 태스크와 비슷하게 지정하십시오. `<property>` 요소가 있을 수도 있습니다. 

`<database>` 요소에는 다음과 같은 속성이 있습니다.

|속성     |설명                                     |필수 |기본값 |
|---------------|-------------------------------------------------|----------|---------|
|kind          |데이터베이스의 유형입니다(Push).	                  |예	     |없음    |
|validate	    |데이터베이스에 액세스할 수 있는지 여부를 유효성 검증합니다. |아니오       |true    |

`<database>` 요소에서는 다음 요소를 지원합니다. 관계형 DBMS에 대한 이 데이터베이스 요소의 구성에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블을 참조하십시오.

|요소            |설명                                                      |개수 |
|--------------------|----------------------------------------------------------------- |-------|
|<db2>	             |DB2 데이터베이스에 대한 매개변수입니다.	                            |0..1  |
|<derby>	         |Apache Derby 데이터베이스에 대한 매개변수입니다.	                    |0..1  |
|<mysql>	         |MySQL 데이터베이스에 대한 매개변수입니다.                               |0..1  |
|<oracle>	         |Oracle 데이터베이스에 대한 매개변수입니다.	                            |0..1  |
|<cloudant>	     |Cloudant 데이터베이스에 대한 매개변수입니다.	                        |0..1  |
|<driverclasspath>	 |JDBC 드라이버 클래스 경로에 대한 매개변수입니다(관계형 DBMS 전용). |0..1  |

> **참고: ** `<cloudant>` 요소의 속성은 런타임과 약간 다릅니다. 자세한 정보는 다음 테이블을 참조하십시오.

|속성     |설명                                     |필수 |기본값                   |
|---------------|-------------------------------------------------|----------|---------------------------|
|url           |Cloudant 계정의 URL입니다.                |아니오       |https://user.cloudant.com |
|user          |Cloudant 계정의 사용자 이름입니다.	      |예	     |없음                      |
|비밀번호      |Cloudant 계정의 비밀번호입니다.	          |아니오	     |대화식으로 조회됨     |
|dbName        |Cloudant 데이터베이스 이름입니다. **중요:** 이 데이터베이스 이름은 소문자로 시작해야 하며 소문자(a - z) 및 숫자(0 - 9)와 _, $ 및 - 문자만 포함해야 합니다.                                |아니오       |mfp_push_db               |

## {{ site.data.keys.mf_server }} 푸시 서비스 설치를 위한 Ant 태스크
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
**installmobilefirstpush**, **updatemobilefirstpush** 및 **uninstallmobilefirstpush** Ant 태스크는 푸시 서비스 설치를 위해 제공됩니다.

### 태스크 영향
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
**installmobilefirstpush** Ant 태스크는 푸시 서비스 WAR 파일을 웹 애플리케이션으로 실행하도록 애플리케이션 서버를 구성합합니다. 이 태스크는 다음과 같은 영향을 미칩니다.
**/imfpush** 컨텍스트 루트에서 푸시 서비스 웹 애플리케이션을 선언합니다. 컨텍스트 루트는 변경할 수 없습니다.
관계형 데이터베이스의 경우 데이터 소스를 선언하며 WebSphere Application Server 전체 프로파일에서는 푸시 서비스에 대한 JDBC 제공자를 선언합니다.
JNDI 환경 항목을 사용하여 푸시 서비스에 대한 구성 특성을 구성합니다. 이 JNDI 환경 항목은 {{ site.data.keys.product_adj }} 권한 부여 서버 및 {{ site.data.keys.mf_analytics }}와의 OAuth 통신(Cloudant가 사용되는 경우에는 Cloudant와의 OAuth 통신)을 구성합니다.

#### updatemobilefirstpush
{: #updatemobilefirstpush }
**updatemobilefirstpush** Ant 태스크는 애플리케이션 서버에서 이미 구성된 {{ site.data.keys.mf_server }} 웹 애플리케이션을 업데이트합니다. 이 태스크는 푸시 서비스 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
**uninstallmobilefirstpush** Ant 태스크는 이전 **installmobilefirstpush** 실행의 영향을 실행 취소합니다. 이 태스크는 다음과 같은 영향을 미칩니다.
지정된 컨텍스트 루트를 가진 푸시 서비스 웹 애플리케이션의 구성을 제거합니다. 그 결과 이 태스크는 해당 애플리케이션에 수동으로 추가된 설정도 제거합니다.
옵션으로 애플리케이션 서버에서 푸시 서비스 WAR 파일을 제거합니다.
관계형 DBMS의 경우 데이터 소스를 제거하며 WebSphere Application Server 전체 프로파일에서는 푸시 서비스에 대한 JDBC 제공자를 제거합니다.
연관된 JNDI 환경 항목을 제거합니다.

### 속성 및 요소
{: #attributes-and-elements-1 }
**installmobilefirstpush**, **updatemobilefirstpush** 및 **uninstallmobilefirstpush** Ant 태스크는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명                           |필수 |기본값     |
|-----------|---------------------------------------|----------|-------------|
|id        |다른 배치를 구별합니다.	|아니오	   |비어 있음
|warFile	|푸시 서비스에 대한 WAR 파일입니다.	|아니오	   |../PushService/mfp-push-service.war 파일은 mfp-ant-deployer.jar 파일이 포함된 MobileFirstServer 디렉토리에 대해 상대적입니다. |

### Id
{: #id }
**id** 속성은 동일한 WebSphere Application Server 셀에서 푸시 서비스의 서로 다른 배치를 구별합니다. 이 id 속성이 없으면 컨텍스트 루트가 동일한 두 개의 WAR 파일이 충돌하여 이들 파일이 배치되지 않습니다.

### warFile
{: #warfile }
푸시 서비스 WAR 파일에 대해 다른 디렉토리를 지정하려면 **warFile** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

**installmobilefirstpush**, **updatemobilefirstpush** 및 **uninstallmobilefirstpush** Ant 태스크는 다음과 같은 요소를 지원합니다.

|요소               |설명             |개수 |
|-----------------------|-------------------------|-------|
| `<applicationserver>` |애플리케이션 서버입니다. |1     |
| `<analytics>`	        |Analytics입니다.	      |0..1  |
| `<authorization>`	    |{{ site.data.keys.mf_server }} 컴포넌트와의 통신을 인증하는 데 필요한 권한 부여 서버입니다. |1 |
| `<database>`	        |데이터베이스입니다.	      |1     |
| `<property>`	        |특성입니다.	      |0..∞  |

### 권한 부여 서버 지정
{: #to-specify-the-authorization-server }
`<authorization>` 요소는 정보를 수집하여 다른 {{ site.data.keys.mf_server }} 컴포넌트와의 인증 통신을 위한 권한 부여 서버를 구성합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성          |설명                           |필수 |기본값     |
|--------------------|---------------------------------------|----------|-------------|
|auto               |권한 부여 서버 URL이 계산되는지 여부를 표시합니다. 가능한 값은 true 또는 false입니다.	|WebSphere Application Server Network Deployment 클러스터 또는 노드의 경우 필수   	 |true |
|authorizationURL   |권한 부여 서버의 URL입니다.	 |모드가 auto가 아닌 경우 |로컬 서버에 있는 런타임의 컨텍스트 루트 |
|runtimeContextRoot |런타임의 컨텍스트 루트입니다.	     |아니오	     |/mfp       |
|pushClientID	     |권한 부여 서버의 푸시 서비스 기밀 ID입니다.  |예 |없음 |
|pushClientSecret	 |권한 부여 서버의 푸시 서비스 기밀 클라이언트 비밀번호입니다. |예 |없음 |

#### auto
{: #auto }
값이 true로 설정되면 로컬 애플리케이션 서버에서 런타임의 컨텍스트 루트를 사용하여 자동으로 권한 부여 서버의 URL이 계산됩니다. WebSphere Application Server Network Deployment의 클러스터에 배치하는 경우 auto 모드는 지원되지 않습니다.

#### authorizationURL
{: #authorizationurl }
권한 부여 서버의 URL입니다. 권한 부여 서버가 {{ site.data.keys.product_adj }} 런타임인 경우 이 URL은 런타임의 URL입니다. 예를 들어, `http://myHost:9080/mfp`입니다.

#### runtimeContextRoot
{: #runtimecontextroot }
자동 모드에서 권한 부여 서버의 URL을 계산하는 데 사용되는 런타임의 컨텍스트 루트입니다.
#### pushClientID
{: #pushclientid }
권한 부여 서버의 기밀 클라이언트로서 이 푸시 서비스 인스턴스의 ID입니다. ID 및 본인확인정보를 권한 부여 서버에 대해 등록해야 합니다. **installmobilefirstadmin** Ant 태스크를 사용하거나 {{ site.data.keys.mf_console }}에서 등록할 수 있습니다.

#### pushClientSecret
{: #pushclientsecret }
권한 부여 서버의 기밀 클라이언트로서 이 푸시 서비스 인스턴스의 본인확인정보 키입니다. ID 및 본인확인정보를 권한 부여 서버에 대해 등록해야 합니다. **installmobilefirstadmin** Ant 태스크를 사용하거나 {{ site.data.keys.mf_console }}에서 등록할 수 있습니다.

`<property>` 요소는 Application Server에 정의할 배치 특성을 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성  |설명                |필수 |기본값 |
|------------|----------------------------|----------|---------|
|이름       |특성의 이름입니다.  |	예	     |없음    |
|value	     |특성의 값입니다. |	예	     |없음    |

이 요소를 사용하면 자체 JNDI 특성을 정의하거나 푸시 서비스 WAR 파일이 제공하는 JNDI 특성의 기본값을 대체할 수 있습니다.

JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)을 참조하십시오.

### 애플리케이션 서버 지정
{: #to-specify-an-application-server-2 }
`<applicationserver>` 요소를 사용하여 기본 Application Server에 따라 다른 매개변수를 정의하십시오. `<applicationserver>` 요소에서는 다음 요소를 지원합니다.

|요소                               |설명                                      |개수 |
|---------------------------------------|--------------------------------------------------|-------|
|<websphereapplicationserver> 또는 <was>	|WebSphere Application Server에 대한 매개변수입니다. |`<websphereapplicationserver>` 요소(줄여서 `<was>`)는 WebSphere Application Server 인스턴스를 나타냅니다. WebSphere Application Server 전체 프로파일(Base 및 Network Deployment)이 지원되므로 WebSphere Application Server Liberty Core 및 WebSphere Application Server Liberty Network Deployment도 지원됩니다. |0..1 |
| `<tomcat>` |Apache Tomcat에 대한 매개변수입니다. |0..1 |

이 요소의 속성 및 내부 요소가 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블에 설명되어 있습니다.

그러나 Liberty Collective에 대한 `<was>` 요소의 내부 요소는 다음 테이블을 참조하십시오.

|요소              |설명                  |개수 |
|----------------------|------------------------------|-------|
| `<collectiveMember>` |Liberty Collective 멤버입니다. |	0..1  |

`<collectiveMember>` 요소에는 다음과 같은 속성이 있습니다.

|속성   |설명                        |필수 |기본값 |
|-------------|------------------------------------|----------|---------|
|serverName  |Collective 멤버의 이름입니다. |예      |없음    |
|clusterName |	Collective 멤버가 속하는 클러스터 이름입니다. |예 |없음 |

> **참고:** 푸시 서비스와 런타임 컴포넌트가 동일한 Collective 멤버에 설치되는 경우 이들은 동일한 클러스터 이름을 가지고 있어야 합니다. 이 컴포넌트가 동일한 Collective의 구별되는 멤버에 설치되는 경우 클러스터 이름은 다를 수 있습니다.

### Analytics 지정
{: #to-specify-analytics-1 }
`<analytics>` 요소는 {{ site.data.keys.product_adj }} 푸시 서비스를 이미 설치된 {{ site.data.keys.mf_analytics }} 서비스에 연결하려 함을 나타냅니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성    |설명                        |필수 |기본값 |
|--------------|------------------------------------|----------|---------|
|install	   |푸시 서비스를 {{ site.data.keys.mf_analytics }}에 연결할지 여부를 표시합니다. |아니오 |false |
|analyticsURL |{{ site.data.keys.mf_analytics }} 서비스의 URL입니다. |예 |없음 |
|username	   |사용자 이름입니다. |예 |없음 |
|password	   |비밀번호입니다. |예 |없음 |
|validate	   |{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증합니다. |아니오 |true |

#### install
{: #install }
이 푸시 서비스가 연결되어야 하고 이벤트를 {{ site.data.keys.mf_analytics }}에 전송해야 함을 표시하려면 **install** 속성을 사용하십시오. 올바른 값은 true 또는 false입니다.

#### analyticsURL
{: #analyticsurl }
수신되는 Analytics 데이터를 수신하는 {{ site.data.keys.mf_analytics }}에 의해 노출되는 URL을 지정하려면 **analyticsURL** 속성을 사용하십시오.  
예: `http://<hostname>:<port>/analytics-service/rest`

#### username
{: #username }
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름을 지정하려면 **username** 속성을 사용하십시오.

#### password
{: #password }
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호를 지정하려면 **password** 속성을 사용하십시오.

#### validate
{: #validate }
{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증하고 비밀번호를 사용하여 사용자 이름 인증을 확인하려면 **validate** 속성을 사용하십시오. 가능한 값은 true 또는 false입니다.

### 푸시 서비스 데이터베이스에 대한 연결 지정
{: #to-specify-a-connection-to-the-push-service-database-1 }
`<database>` 요소는 Application Server에서 데이터 소스 선언을 지정하는 매개변수를 수집하여 푸시 서비스 데이터베이스에 액세스합니다.

다음과 같은 단일 데이터베이스를 선언해야 합니다. `<database kind="Push">`. `<database>` 요소에는 `<dba>` 및 `<client>` 요소가 없다는 점을 제외하고, `<database>` 요소를 configuredatabase Ant 태스크와 비슷하게 지정하십시오. `<property>` 요소가 있을 수도 있습니다. 

`<database>` 요소에는 다음과 같은 속성이 있습니다.

|속성    |설명                  |필수 |기본값 |
|--------------|------------------------------|----------|---------|
|kind         |데이터베이스의 유형입니다(Push). |예      |없음    |
|validate	   |데이터베이스에 액세스할 수 있는지 여부를 유효성 검증합니다. |아니오 |true |

`<database>` 요소에서는 다음 요소를 지원합니다. 관계형 DBMS에 대한 이 데이터베이스 요소의 구성에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블을 참조하십시오.

|요소              |설명                               |개수 |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           |DB2 데이터베이스에 대한 매개변수입니다.         |0..1  |
| `<derby>`	           |Apache Derby 데이터베이스에 대한 매개변수입니다. |0..1  |
| `<mysql>`	           |MySQL 데이터베이스에 대한 매개변수입니다.        |0..1  |
| `<oracle>`           |Oracle 데이터베이스에 대한 매개변수입니다.       |0..1  |
| `<cloudant>`	       |Cloudant 데이터베이스에 대한 매개변수입니다.     |0..1  |
| `<driverclasspath>`  |JDBC 드라이버 클래스 경로에 대한 매개변수입니다(관계형 DBMS 전용). |0..1 |

> **참고: ** `<cloudant>` 요소의 속성은 런타임과 약간 다릅니다. 자세한 정보는 다음 테이블을 참조하십시오.

|속성    |설명                            |필수   |기본값 |
|--------------|----------------------------------------|------------|---------|
|url	       |Cloudant 계정의 URL입니다.       |아니오         |https://user.cloudant.com |
|user	       |Cloudant 계정의 사용자 이름입니다. |예 |없음 |
|password	   |Cloudant 계정의 비밀번호입니다.	|아니오  |대화식으로 조회됨 |
|dbName	   |Cloudant 데이터베이스 이름입니다. **중요:** 이 데이터베이스 이름은 소문자로 시작해야 하며 소문자(a - z) 및 숫자(0 - 9)와 _, $ 및 - 문자만 포함해야 합니다. |아니오	|mfp_push_db |

## {{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
**installmobilefirstruntime**, **updatemobilefirstruntime** 및 **uninstallmobilefirstruntime** Ant 태스크에 대한 참조 정보입니다.

### 태스크 영향
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
**installmobilefirstruntime** Ant 태스크는 {{ site.data.keys.product_adj }} 런타임 WAR 파일을 웹 애플리케이션으로 실행하도록 애플리케이션 서버를 구성합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 지정된 컨텍스트 루트(기본값은 /mfp)에서 {{ site.data.keys.product_adj }} 웹 애플리케이션을 선언합니다.
* 애플리케이션 서버에 런타임 WAR 파일을 배치합니다.
* 데이터 소스를 선언하고 WebSphere Application Server 전체 프로파일에서는 런타임에 대한 JDBC 제공자를 선언합니다.
* 애플리케이션 서버에서 데이터베이스 드라이버를 배치합니다.
* JNDI 환경 항목을 통해 {{ site.data.keys.product_adj }} 구성 특성을 설정합니다.
* 선택적으로 {{ site.data.keys.product_adj }} JNDI 환경 항목을 설정하여 애플리케이션 서버를 런타임에 대한 서버 팜 멤버로 구성합니다.

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
**updatemobilefirstruntime** Ant 태스크는 이미 애플리케이션 서버에서 구성된 {{ site.data.keys.product_adj }} 런타임을 업데이트합니다. 이 태스크는 런타임 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 런타임 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다. 그 외에 이 태스크는 웹 애플리케이션 구성, 데이터 소스 및 JNDI 환경 항목 등의 애플리케이션 서버 구성을 변경하지 않습니다.

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
**uninstallmobilefirstruntime** Ant 태스크는 이전 **installmobilefirstruntime** 실행의 영향을 실행 취소합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 지정된 컨텍스트 루트를 가진 {{ site.data.keys.product_adj }} 웹 애플리케이션 구성을 제거합니다. 이 태스크는 해당 애플리케이션에 수동으로 추가되는 설정도 제거합니다.
* 애플리케이션 서버에서 런타임 WAR 파일을 제거합니다.
* 데이터 소스를 제거하며 WebSphere Application Server 전체 프로파일에서는 런타임에 대한 JDBC 제공자를 제거합니다.
* 연관된 JNDI 환경 항목을 제거합니다.

### 속성 및 요소
{: #attributes-and-elements-2 }
**installmobilefirstruntime**, **updatemobilefirstruntime** 및 **uninstallmobilefirstruntime** Ant 태스크는 다음과 같은 속성을 가지고 있습니다.

|속성         |설명                                                                 |필수   |기본값                   |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
|contextroot       |애플리케이션(컨텍스트 루트)에 대한 URL의 공통 접두부입니다.                |아니오 |/mfp  |
|id	            |다른 배치를 구별합니다.                                       |아니오 |비어 있음 |
|environmentId	    |다른 {{ site.data.keys.product_adj }} 환경을 구별합니다.                          |아니오 |비어 있음 |
|warFile	        |{{ site.data.keys.product_adj }} 런타임에 대한 WAR 파일입니다.                                       |아니오 |mfp-server.war 파일은 mfp-ant-deployer.jar 파일과 동일한 디렉토리에 있습니다. |
|wasStartingWeight |WebSphere Application Server에 대한 시작 순서입니다. 값이 작을수록 먼저 시작됩니다. |아니오 |2     |                           |

#### contextroot 및 id
{: #contextroot-and-id-1 }
**contextroot** 및 **id** 속성은 다른 {{ site.data.keys.product_adj }} 프로젝트를 구별합니다.

WebSphere Application Server Liberty 프로파일 및 Tomcat 환경에서는 contextroot 매개변수로도 이 용도를 충족합니다. WebSphere Application Server 전체 프로파일 환경에서는 id 속성이 대신 사용됩니다.

#### environmentId
{: #environmentid-1 }
독립적으로 작동해야 하는 {{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.product_adj }} 런타임 웹 애플리케이션으로 각각 구성된 여러 환경을 구별하려면 **environmentId** 속성을 사용하십시오. 관리 서비스 애플리케이션의 경우 <installmobilefirstadmin> 호출에서 설정된 것과 동일한 런타임 애플리케이션의 값으로 이 속성을 설정해야 합니다.

#### warFile
{: #warfile-1 }
{{ site.data.keys.product_adj }} 런타임 WAR 파일에 대해 다른 디렉토리를 지정하려면 **warFile** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

#### wasStartingWeight
{: #wasstartingweight-1 }
WebSphere Application Server에서 사용되는 값을 가중치로 지정하여 시작 순서를 존중하게 하려면 **wasStartingWeight** 속성을 사용하십시오. 시작 순서 값의 결과로 {{ site.data.keys.product_adj }} 런타임 프로젝트보다 먼저 {{ site.data.keys.mf_server }} 관리 서비스 웹 애플리케이션이 배치되고 시작됩니다. 웹 애플리케이션보다 먼저 {{ site.data.keys.product_adj }} 프로젝트가 배치되거나 시작되는 경우에는 JMX 통신이 설정되지 않으며 {{ site.data.keys.product_adj }} 프로젝트를 관리할 수 없습니다.

**installmobilefirstruntime**, **updatemobilefirstruntime** 및 **uninstallmobilefirstruntime** 태스크는 다음과 같은 요소를 지원합니다.

|요소               |설명                                      |개수 |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          |특성입니다.	                               |0..   |
| `<applicationserver>` |애플리케이션 서버입니다.                          |1     |
| `<database>`          |데이터베이스입니다.                                   |1     |
| `<analytics>`         |Analytics입니다.                                   |0..1  |

`<property>` 요소는 Application Server에 정의할 배치 특성을 지정하는 데 사용합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명                |필수 |기본값 |
|-----------|----------------------------|----------|---------|
|이름      |특성의 이름입니다.	 |예      |없음    |
|value	    |특성의 값입니다.|예	    |없음    |  

`<applicationserver>` 요소는 {{ site.data.keys.product_adj }} 애플리케이션이 배치될 Application Server를 설명합니다. 이 요소는 다음 요소 중 하나의 컨테이너입니다.

|요소                                    |설명                                      |개수 |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` 또는 `<was>`  |WebSphere Application Server에 대한 매개변수입니다.	|0..1  |
| `<tomcat>`                                 |Apache Tomcat에 대한 매개변수입니다.                |0..1  |

`<websphereapplicationserver>` 요소(줄여서 `<was>`)는 WebSphere Application Server 인스턴스를 나타냅니다. WebSphere Application Server 전체 프로파일(Base 및 Network Deployment)이 지원되므로 WebSphere Application Server Liberty Core 및 WebSphere Application Server Liberty Network Deployment도 지원됩니다. `<websphereapplicationserver>` 요소에는 다음과 같은 속성이 있습니다.

|속성       |설명                                            |필수                 |기본값 |
|-----------------|--------------------------------------------------------|--------------------------|---------|
|installdir      |	WebSphere Application Server 설치 디렉토리입니다.   |예                      |없음    |
|profile         |	WebSphere Application Server 프로파일 또는 Liberty입니다.      |예	                  |없음    |
|userI	WebSphere Application Server 관리자 이름입니다.	               |예(Liberty 제외)  |없음    |
|비밀번호        |WebSphere Application Server 관리자 비밀번호입니다.   |아니오 |         |
|libertyEncoding |	WebSphere Application Server Liberty에 대한 데이터 소스 비밀번호를 인코딩하는 알고리즘입니다. 가능한 값은 없음, xor 및 aes입니다. xor 또는 aes 인코딩이 사용되는지 여부에 관계없이 명확한 비밀번호가 인수로 securityUtility 프로그램에 전달되며 이는 외부 프로세스를 통해 호출됩니다. ps 명령을 사용하거나 UNIX 운영 체제의 /proc 파일 시스템에서 비밀번호를 볼 수 있습니다.                                                         |아니오                       |	xor     |
|jeeVersion      |	Liberty 프로파일용입니다. JEE6 웹 프로파일 또는 JEE7 웹 프로파일의 기능을 설치할지 여부를 지정합니다. 가능한 값은 6, 7 또는 auto입니다.|아니오 |auto |
|configureFarm   |	WebSphere Application Server Liberty 및 WebSphere Application Server 전체 프로파일용입니다(WebSphere Application Server Network Deployment 에디션 및 Liberty Collective용이 아님). 서버가 서버 팜 멤버인지 여부를 지정합니다. 가능한 값은 true 또는 false입니다. |아니오	      |false   |
|farmServerId    |	서버 팜에서 서버를 고유하게 식별하는 문자열입니다. {{ site.data.keys.mf_server }} 관리 서비스 및 이와 통신하는 모든 {{ site.data.keys.product_adj }} 런타임은 동일한 값을 공유해야 합니다.                                                                |예                      |	없음    |

이 요소는 단일 서버 배치를 위해 다음 요소를 지원합니다.

|요소     |설명      |개수 |
|-------------|------------------|-------|
| `<server>`  |단일 서버입니다. |0..1  |

이 컨텍스트에서 사용되는 <server> 요소는 다음과 같은 속성을 가지고 있습니다.

|속성 |설명      |필수 |기본값 |
|-----------|------------------|----------|---------|
|name	    |서버 이름입니다. |예      |없음    |

이 요소는 Liberty Collective를 위해 다음과 같은 요소를 지원합니다.

|요소               |설명                  |개수 |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  |Liberty Collective 멤버입니다. |0..1  |

`<collectiveMember>` 요소에는 다음과 같은 속성이 있습니다.

|속성               |설명      |필수 |기본값 |
|-------------------------|------------------|----------|---------|
|serverName              |	Collective 멤버의 이름입니다.                       |예 |없음 |
|clusterName             |	Collective 멤버가 속하는 클러스터 이름입니다.  |예 |없음 |
|serverId                |	Collective 멤버를 고유하게 식별하는 문자열입니다. |예 |없음 |
|controllerHost          |	Collective 제어기의 이름입니다.                   |예 |없음 |
|controllerHttpsPort     |	Collective 제어기의 HTTPS 포트입니다.             |예 |없음 |
|controllerAdminName     |	Collective 제어기에서 정의되는 관리 사용자 이름입니다. 이 이름은 새 멤버를 Collective에 결합하는 데 사용되는 사용자와 동일한 사용자입니다. |예 |없음 |
|controllerAdminPassword |	관리 사용자 비밀번호입니다.	                     |예 |없음 |
|createControllerAdmin   |	Collective 멤버의 기본 레지스트리에서 관리 사용자를 작성해야 하는지 여부를 표시합니다. 가능한 값은 true 또는 false입니다. |아니오 |true |

이 요소는 Network Deployment를 위해 다음과 같은 요소를 지원합니다.

|요소     |설명                                   |개수 |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	전체 셀입니다.	                          |0..1  |
| `<cluster>` |	클러스터의 모든 서버입니다.                 |	0..1  |
| `<node>`    |	클러스터를 제외한 노드의 모든 서버입니다. |0..1  |
| `<server>`  |	단일 서버입니다.	                          |0..1  |

`<cell>` 요소에 속성이 없습니다.

`<cluster>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명       |필수 |기본값 |
|-----------|-------------------|----------|---------|
|이름      |클러스터 이름입니다. |예	   |없음    |

`<node>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명    |필수 |기본값 |
|-----------|----------------|----------|---------|
|이름      |노드 이름입니다. |예	    |없음    |

`<server>` 요소(Network Deployment 컨텍스트에서 사용됨)에는 다음과 같은 속성이 있습니다.

|속성  |설명      |필수 |기본값 |
|------------|------------------|----------|---------|
|nodeName   |노드 이름입니다.   |예	   |없음    |
|serverName |서버 이름입니다. |예      |없음    |

`<tomcat>` 요소는 Apache Tomcat 서버를 나타냅니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성     |설명      |필수 |기본값 |
|---------------|------------------|----------|---------|
|installdir    |Apache Tomcat의 설치 디렉토리입니다. CATALINA_HOME 디렉토리와 CATALINA_BASE 디렉토리 사이에서 분할되는 Tomcat 설치의 경우 CATALINA_BASE 환경 변수의 값을 지정하십시오.     |예 |없음    |
|configureFarm |서버가 서버 팜 멤버인지 여부를 지정합니다. 가능한 값은 true 또는 false입니다.	|아니오 |false |
|farmServerId	|서버 팜에서 서버를 고유하게 식별하는 문자열입니다. {{ site.data.keys.mf_server }} 관리 서비스 및 이와 통신하는 모든 {{ site.data.keys.product_adj }} 런타임은 동일한 값을 공유해야 합니다. |예 |없음 |

`<database>` 요소는 특정 데이터베이스에 액세스하는 데 필요한 정보를 지정합니다. `<database>` 요소는 `<dba>` 및 `<client>` 요소가 없다는 점을 제외하면 configuredatabase Ant와 비슷하게 지정됩니다. 그러나 `<property>` 요소가 있을 수도 있습니다. `<database>` 요소에는 다음과 같은 속성이 있습니다.

|속성 |설명                                |필수 |기본값 |
|-----------|--------------------------------------------|----------|---------|
|kind      |데이터베이스의 유형입니다({{ site.data.keys.product_adj }} 런타임). |예 |없음 |
|validate  |데이터베이스에 액세스 가능한지 여부를 유효성 검증합니다. 가능한 값은 true 또는 false입니다. |아니오 |true |

`<database>` 요소에서는 다음 요소를 지원합니다.

|요소             |설명	                |개수 |
|---------------------|-----------------------------|-------|
| `<derby>`           |Derby에 대한 매개변수입니다.   |0..1  |
| `<db2>`             |	DB2에 대한 매개변수입니다.     |0..1  |
| `<mysql>`           |	MySQL에 대한 매개변수입니다.   |0..1  |
| `<oracle>`          |	Oracle에 대한 매개변수입니다.  |0..1  |
| `<driverclasspath>` |JDBC 드라이버 클래스 경로입니다. |0..1  |

`<analytics>` 요소는 {{ site.data.keys.product_adj }} 런타임을 이미 설치된 {{ site.data.keys.mf_analytics_console }} 및 서비스에 연결하려 함을 나타냅니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성    |설명                                                                      |필수 |기본값 |
|--------------|----------------------------------------------------------------------------------|----------|---------|
|install      |{{ site.data.keys.product_adj }} 런타임을 {{ site.data.keys.mf_analytics }}에 연결할지 여부를 표시합니다. |아니오       |false   |
|analyticsURL |{{ site.data.keys.mf_analytics }} 서비스의 URL입니다.	                                      |예      |없음    |
|consoleURL   |{{ site.data.keys.mf_analytics_console }}의 URL입니다.	                                      |예      |없음    |
|username     |사용자 이름입니다.	                                                                  |예      |없음    |
|비밀번호     |비밀번호입니다.	                                                                  |예      |없음    |
|validate     |{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증합니다.	      |아니오	     |true    |
|tenant       |{{ site.data.keys.product_adj }} 런타임에서 수집되는 데이터의 색인화를 위한 테넌트입니다.	      |아니오       |내부 ID |

#### install
{: #install-1 }
이 {{ site.data.keys.product_adj }} 런타임이 연결되어야 하고 이벤트를 {{ site.data.keys.mf_analytics }}에 전송해야 함을 표시하려면 **install** 속성을 사용하십시오. 올바른 값은 **true** 또는 **false**입니다.

#### analyticsURL
{: #analyticsurl-1 }
수신되는 Analytics 데이터를 수신하는 {{ site.data.keys.mf_analytics }}에 의해 노출되는 URL을 지정하려면 **analyticsURL** 속성을 사용하십시오.  
예: `http://<hostname>:<port>/analytics-service/rest`

#### consoleURL
{: #consoleurl }
{{ site.data.keys.mf_analytics_console }}에 링크되는 {{ site.data.keys.mf_analytics }}에 의해 노출되는 URL에 대해 **consoleURL** 속성을 사용하십시오.  
예: `http://<hostname>:<port>/analytics/console`

#### username
{: #username-1 }
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 사용자 이름을 지정하려면 **username** 속성을 사용하십시오.

#### password
{: #password-1 }
{{ site.data.keys.mf_analytics }}에 대한 데이터 시작점이 기본 인증으로 보호되는 경우 사용되는 비밀번호를 지정하려면 **password** 속성을 사용하십시오.

#### validate
{: #validate-1 }
{{ site.data.keys.mf_analytics_console }}에 액세스 가능한지 여부를 유효성 검증하고 비밀번호를 사용하여 사용자 이름 인증을 확인하려면 **validate** 속성을 사용하십시오. 가능한 값은 **true** 또는 **false**입니다.

#### tenant
{: #tenant }
이 속성에 대한 자세한 정보는 [구성 특성](../analytics/configuration/#configuration-properties)을 참조하십시오.

### Apache Derby 데이터베이스 지정
{: #to-specify-an-apache-derby-database }
`<derby>` 요소에는 다음과 같은 속성이 있습니다.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|database	 |데이터베이스 이름입니다.	                      |아니오       |	유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR |
|datadir	 |데이터베이스가 포함된 디렉토리입니다. |	예	     |없음    |
|schema     |	스키마 이름입니다.                          |	아니오	     |유형에 따라 MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH 또는 APPCENTER |

`<derby>` 요소에서는 다음 요소를 지원합니다.

|요소       |설명	                |개수 |
|---------------|-------------------------------|-------|
| `<property>`  |데이터 소스 특성 또는 JDBC 연결 특성입니다.	|0.. |

사용 가능한 특성에 대한 자세한 정보는 클래스 [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html)에 대한 문서를 참조하십시오. [클래스 EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html)에 대한 문서도 참조하십시오.

Liberty 서버에 대해 사용 가능한 특성에 대한 자세한 정보는 [Liberty 프로파일: server.xml 파일의 구성 요소](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)에 있는 `properties.derby.embedded`에 대한 문서를 참조하십시오.

**mfp-ant-deployer.jar** 파일을 {{ site.data.keys.product }} 설치 디렉토리에서 사용하는 경우 `<driverclasspath>` 요소가 필요하지 않습니다.

### DB2 데이터베이스 지정
{: #to-specify-a-db2-database }
`<db2>` 요소에는 다음과 같은 속성이 있습니다.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|database   |데이터베이스 이름입니다. |아니오 I 유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR |
|server     |데이터베이스 서버의 호스트 이름입니다.      |예	     |없음    |
|port       |데이터베이스 서버의 포트입니다.           |아니오	     |50000   |
|user       |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다.     |이 사용자에게는 데이터베이스에 대한 확장된 권한이 필요하지 않습니다. 데이터베이스에 대한 제한을 구현하는 경우에는 데이터베이스 사용자 및 권한에 나열되는 제한된 권한을 가진 사용자를 설정할 수 있습니다.                                 |예 |I 예 I 없음 I |
|비밀번호   |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.      |아니오       |대화식으로 조회됨 |
|schema     |스키마 이름입니다.                           |아니오       |사용자에 따라 다름 |

DB2 사용자 계정에 대한 자세한 정보는 [DB2 보안 모델 개요](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html)를 참조하십시오.  
`<db2>` 요소에서는 다음 요소를 지원합니다.

|요소       |설명	                |개수 |
|---------------|-------------------------------|-------|
| `<property>`  |데이터 소스 특성 또는 JDBC 연결 특성입니다.	|0.. |

사용 가능한 특성에 대한 자세한 정보는 [IBM Data Server Driver for JDBC and SQLJ에 대한 특성](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html)을 참조하십시오.

Liberty 서버에 대해 사용 가능한 특성에 대한 자세한 정보는 [Liberty 프로파일: server.xml 파일의 구성 요소](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)에서 **properties.db2.jcc** 절을 참조하십시오.

`<driverclasspath>` 요소에는 DB2 JDBC 드라이버 및 관련 라이센스의 JAR 파일이 있어야 합니다. [DB2 JDBC 드라이버 버전](http://www.ibm.com/support/docview.wss?uid=swg21363866)에서 DB2 JDBC 드라이버를 다운로드할 수 있습니다.

### MySQL 데이터베이스 지정
{: #to-specify-a-mysql-database }
`<mysql>` 요소에는 다음과 같은 속성이 있습니다.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|database	 |데이터베이스 이름입니다.	                      |아니오       |유형에 따라 MFPDATA, MFPADM, MFPCFG, MFPPUSH 또는 APPCNTR |
|server	 |데이터베이스 서버의 호스트 이름입니다.	  |예      |없음    |
|port	     |데이터베이스 서버의 포트입니다.           |아니오	     |3306    |
|user	     |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 사용자에게는 데이터베이스에 대한 확장된 권한이 필요하지 않습니다. 데이터베이스에 대한 제한을 구현하는 경우에는 데이터베이스 사용자 및 권한에 나열되는 제한된 권한을 가진 사용자를 설정할 수 있습니다. |예 |예 |없음 |
|password	 |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	  |아니오	     |대화식으로 조회됨 |

**database**, **server** 및 **port** 대신 URL을 지정할 수도 있습니다. 이 경우에는 다음과 같은 속성을 사용하십시오.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|url	     |데이터베이스에 연결하는 데 필요한 URL입니다.	  |예	     |없음    |
|user	     |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 사용자에게는 데이터베이스에 대한 확장된 권한이 필요하지 않습니다. 데이터베이스에 대한 제한을 구현하는 경우에는 데이터베이스 사용자 및 권한에 나열되는 제한된 권한을 가진 사용자를 설정할 수 있습니다. |예  |없음 |
|password	 |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	  |아니오       |대화식으로 조회됨 |

MySQL 사용자 계정에 대한 자세한 정보는 [MySQL 사용자 계정 관리](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html)를 참조하십시오.

`<mysql>` 요소에서는 다음 요소를 지원합니다.

|요소       |설명	                |개수 |
|---------------|-------------------------------|-------|
| `<property>`  |데이터 소스 특성 또는 JDBC 연결 특성입니다.	|0.. |

사용 가능한 특성에 대한 자세한 정보는 [Connector/J에 대한 드라이버/데이터 소스 클래스 이름, URL 구문 및 구성 특성](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html)에 있는 문서를 참조하십시오.

Liberty 서버에 대해 사용 가능한 특성에 대한 자세한 정보는 [Liberty 프로파일: server.xml 파일의 구성 요소](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)에서 특성 절을 참조하십시오.

`<driverclasspath>` 요소에는 MySQL Connector/J JAR 파일이 있어야 합니다. [Connector/J 다운로드](http://www.mysql.com/downloads/connector/j/)에서 다운로드할 수 있습니다.

### Oracle 데이터베이스 지정
{: #to-specify-an-oracle-database }
`<oracle>` 요소에는 다음과 같은 속성이 있습니다.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|database   |데이터베이스 이름 또는 Oracle 서비스 이름입니다. 참고: 항상 서비스 이름을 사용하여 PDB 데이터베이스에 연결해야 합니다. |아니오 |ORCL |
|server	 |데이터베이스 서버의 호스트 이름입니다.	I 예 I 없음 I
|port	     |데이터베이스 서버의 포트입니다.	I 없음 I 1521 I
|user	     |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 사용자에게는 데이터베이스에 대한 확장된 권한이 필요하지 않습니다. 데이터베이스에 대한 제한을 구현하는 경우에는 데이터베이스 사용자 및 권한에 나열되는 제한된 권한을 가진 사용자를 설정할 수 있습니다. 이 테이블 아래의 참고를 참조하십시오. |예 |없음 |
|password	 |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	  |아니오       |대화식으로 조회됨 |

> **참고:** **user** 속성의 경우 대문자로 된 사용자 이름을 사용하는 것이 좋습니다. Oracle 사용자 이름은 일반적으로 대문자입니다. 다른 데이터베이스 도구와 달리 **installmobilefirstruntime** Ant 태스크는 사용자 이름의 소문자를 대문자로 변환하지 않습니다. **installmobilefirstruntime** Ant 태스크가 데이터베이스에 연결하는 데 실패하면 **user** 속성의 값을 대문자로 입력하십시오.

**database**, **server** 및 **port** 대신 URL을 지정할 수도 있습니다. 이 경우에는 다음과 같은 속성을 사용하십시오.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|url	     |데이터베이스에 연결하는 데 필요한 URL입니다.	  |예      |없음    |
|user	     |데이터베이스에 액세스하는 데 필요한 사용자 이름입니다. 이 사용자에게는 데이터베이스에 대한 확장된 권한이 필요하지 않습니다. 데이터베이스에 대한 제한을 구현하는 경우에는 데이터베이스 사용자 및 권한에 나열되는 제한된 권한을 가진 사용자를 설정할 수 있습니다. 이 테이블 아래의 참고를 참조하십시오. |예 |없음 |
|password	 |데이터베이스에 액세스하는 데 필요한 비밀번호입니다.	  |아니오	     |대화식으로 조회됨 |

> **참고:** **user** 속성의 경우 대문자로 된 사용자 이름을 사용하는 것이 좋습니다. Oracle 사용자 이름은 일반적으로 대문자입니다. 다른 데이터베이스 도구와 달리 **installmobilefirstruntime** Ant 태스크는 사용자 이름의 소문자를 대문자로 변환하지 않습니다. **installmobilefirstruntime** Ant 태스크가 데이터베이스에 연결하는 데 실패하면 **user** 속성의 값을 대문자로 입력하십시오.

Oracle 사용자 계정에 대한 자세한 정보는 [인증 방법 개요](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374)를 참조하십시오.

Oracle 데이터베이스 연결 URL에 대한 자세한 정보는 [데이터 소스 및 URL](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm)에 있는 **데이터베이스 URL 및 데이터베이스 지정자** 절을 참조하십시오.

이 요소는 다음과 같은 요소를 지원합니다.

|요소       |설명	                |개수 |
|---------------|-------------------------------|-------|
| `<property>`  |데이터 소스 특성 또는 JDBC 연결 특성입니다.	|0.. |

사용 가능한 특성에 대한 자세한 정보는 [데이터 소스 및 URL](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm)에 있는 **데이터 소스 및 URL** 절을 참조하십시오.

Liberty 서버에 대해 사용 가능한 특성에 대한 자세한 정보는 [Liberty 프로파일: server.xml 파일의 구성 요소](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html)에 있는 **properties.oracle** 절을 참조하십시오.

`<driverclasspath>` 요소에는 Oracle JDBC 드라이버 JAR 파일이 있어야 합니다. [JDBC, SQLJ, Oracle JPublisher 및 UCP(Universal Connection Pool)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html)에서 Oracle JDBC 드라이버를 다운로드할 수 있습니다.

`<property>` 요소(`<derby>`, `<db2>`,` <mysql>` 또는 `<oracle>` 요소에서 사용할 수 있음)에는 다음과 같은 속성이 있습니다.

|속성  |설명                                |필수 |기본값 |
|------------|--------------------------------------------|----------|---------|
|이름       |특성의 이름입니다.	              |예      |없음    |
|type	     |특성 값의 Java 유형입니다(일반적으로 java.lang.String/Integer/Boolean). |아니오 |java.lang.String |
|value	     |특성의 값입니다.	              |예      |없음   |

## Application Center 설치를 위한 Ant 태스크
{: #ant-tasks-for-installation-of-application-center }
`<installApplicationCenter>`, `<updateApplicationCenter>` 및 `<uninstallApplicationCenter>` Ant 태스크는 Application Center 콘솔 및 서비스의 설치용으로 제공됩니다.

### 태스크 영향
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
`<installApplicationCenter>` 태스크는 Application Center 서비스 WAR 파일을 웹 애플리케이션으로 실행하고 Application Center 콘솔을 설치하도록 Application Server를 구성합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* /applicationcenter 컨텍스트 루트에서 Application Center 서비스 웹 애플리케이션을 선언합니다.
* 데이터 소스를 선언하며 WebSphere Application Server 전체 프로파일에서는 Application Center 서비스에 대한 JDBC 제공자도 선언합니다.
* 애플리케이션 서버에 Application Center 서비스 웹 애플리케이션을 배치합니다.
* /appcenterconsole 컨텍스트 루트에서 Application Center 콘솔을 웹 애플리케이션으로 선언합니다.
* 애플리케이션 서버에 Application Center 콘솔 WAR 파일을 배치합니다.
* JNDI 환경 항목을 사용하여 Application Center 서비스에 대한 구성 특성을 구성합니다. 엔드포인트 및 프록시와 관련된 JNDI 환경 항목은 주석 처리됩니다. 일부 경우에는 해당 항목을 주석 해제해야 합니다.
* Application Center 콘솔 및 서비스 웹 애플리케이션에서 사용하는 역할에 맵핑되는 사용자를 구성합니다.
* WebSphere Application Server의 경우 웹 컨테이너에 필요한 사용자 정의 특성을 구성합니다.

#### updateApplicationCenter
{: #updateApplicationCenter }
`<updateApplicationCenter>` 태스크는 Application Server에 이미 구성된 Application Center 애플리케이션을 업데이트합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* Application Center 서비스 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.
* Application Center 콘솔 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 해당 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.

이 태스크는 웹 애플리케이션 구성, 데이터 소스, JNDI 환경 항목 및 사용자 대 역할 맵핑 등의 애플리케이션 서버 구성을 변경하지 않습니다. 이 태스크는 이 주제에 설명된 <installApplicationCenter> 태스크를 사용하여 수행되는 설치에만 적용됩니다.

> **참고:** WebSphere Application Server Liberty 프로파일의 경우 이 태스크는 기능을 변경하지 않고 설치된 애플리케이션에 대한 기능의 잠재적인 최소가 아닌 목록을 server.xml 파일에 남겨 둡니다.

#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
`<uninstallApplicationCenter>` Ant 태스크는 이전 `<installApplicationCenter>` 실행의 영향을 실행 취소합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* **/applicationcenter** 컨텍스트 루트를 가진 Application Center 서비스 웹 애플리케이션의 구성을 제거합니다. 그 결과 이 태스크는 해당 애플리케이션에 수동으로 추가된 설정도 제거합니다.
* 애플리케이션 서버에서 Application Center 서비스 및 콘솔 WAR 파일을 모두 제거합니다.
* 데이터 소스를 제거하며 WebSphere Application Server 전체 프로파일에서는 Application Center 서비스에 대한 JDBC 제공자도 제거합니다.
* 애플리케이션 서버에서 Application Center 서비스가 사용한 데이터베이스 드라이버를 제거합니다.
* 연관된 JNDI 환경 항목을 제거합니다.
* `<installApplicationCenter>` 호출을 통해 구성되는 사용자를 제거합니다.

### 속성 및 요소
{: #attributes-and-elements-3 }
`<installApplicationCenter>`, `<updateApplicationCenter>` 및 `<uninstallApplicationCenter>` 태스크에는 다음 속성이 있습니다.

|속성    |설명                                |필수 |기본값 |
|--------------|--------------------------------------------|----------|---------|
|id	       |WebSphere Application Server 전체 프로파일에서 다른 배치를 구별합니다.	|아니오 |비어 있음 |
|servicewar   |Application Center 서비스에 대한 WAR 파일입니다. |아니오 |applicationcenter.war 파일은 Application Center 콘솔 디렉토리 **product_install_dir/ApplicationCenter/console**에 있습니다. |
|shortcutsDir |바로 가기를 배치하는 디렉토리입니다. |아니오 |없음 |
|aaptDir |Android SDK 플랫폼 도구 패키지의 aapt 프로그램이 포함된 디렉토리입니다. |아니오 |없음 |

#### id
{: #id-1 }
WebSphere Application Server 전체 프로파일 환경에서 **id** 속성은 Application Center 콘솔 및 서비스의 서로 다른 배치를 구별하는 데 사용됩니다. 이 **id** 속성을 사용하지 않으면 동일한 컨텍스트 루트를 가진 두 개의 WAR 파일은 충돌하므로 배치되지 않습니다.

#### servicewar
{: #servicewar-1 }
Application Center 서비스 WAR 파일에 대해 다른 디렉토리를 지정하려면 **servicewar** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

#### shortcutsDir
{: #shortcutsdir-1 }
**shortcutsDir** 속성은 Application Center 콘솔에 대한 바로 가기를 배치할 위치를 지정합니다. 이 속성을 설정하면 다음과 같은 파일이 이 디렉토리에 추가됩니다.

* **appcenter-console.url**: 이 파일은 Windows 바로 가기입니다. 이 파일은 브라우저에서 Application Center 콘솔을 엽니다.
* **appcenter-console.sh**: 이 파일은 UNIX 쉘 스크립트입니다. 이 파일은 브라우저에서 Application Center 콘솔을 엽니다.

#### aaptDir
{: #aaptdir }
**aapt** 프로그램은 {{ site.data.keys.product }} 배포의 일부입니다. **product_install_dir/ApplicationCenter/tools/android-sdk**.  
이 속성이 설정되지 않은 경우 apk 애플리케이션 업로드 중에 Application Center는 제한이 있는 자체 코드를 사용하여 해당 애플리케이션을 구문 분석합니다.

`<installApplicationCenter>`, `<updateApplicationCenter>` 및 `<uninstallApplicationCenter>` 태스크에서는 다음 요소를 지원합니다.

|요소           |설명	                            |개수 |
|-------------------|-------------------------------------------|-------|
|applicationserver	|애플리케이션 서버입니다.                   |1     |
|console           |Application Center 콘솔입니다.	        |1     |
|database          |데이터베이스입니다.	                        |1     |
|user	            |보안 역할에 맵핑될 사용자입니다. |0..∞  |

### Application Center 콘솔 지정
{: #to-specify-an-application-center-console }
`<console>` 요소는 Application Center 콘솔의 설치를 사용자 정의하기 위한 정보를 수집합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성    |설명                                      |필수 |기본값 |
|--------------|--------------------------------------------------|----------|---------|
|warfile      |Application Center 콘솔에 대한 WAR 파일입니다. |	아니오       |appcenterconsole.war 파일은 Application Center 콘솔 디렉토리 **product_install_dir/ApplicationCenter/console**에 있습니다. |

### 애플리케이션 서버 지정
{: #to-specify-an-application-server-3 }
`<applicationserver>` 요소를 사용하여 기본 Application Server에 따라 다른 매개변수를 정의하십시오. `<applicationserver>` 요소에서는 다음 요소를 지원합니다.

|요소           |설명	                            |개수 |
|-------------------|-------------------------------------------|-------|
|**websphereapplicationserver** 또는 **was**	|WebSphere Application Server에 대한 매개변수입니다. `<websphereapplicationserver>` 요소(줄여서 `<was>`)는 WebSphere Application Server 인스턴스를 나타냅니다. WebSphere Application Server 전체 프로파일(Base 및 Network Deployment)이 지원되므로 WebSphere Application Server Liberty Core도 지원됩니다. Application Center의 경우 Liberty Collective는 지원되지 않습니다. |0..1 |
|tomcat            |Apache Tomcat에 대한 매개변수입니다. |0..1 |

이 요소의 속성 및 내부 요소가 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) 페이지의 테이블에 설명되어 있습니다.

### 서비스 데이터베이스에 대한 연결 지정
{: #to-specify-a-connection-to-the-services-database }
`<database>` 요소는 Application Server에서 데이터 소스 선언을 지정하는 매개변수를 수집하여 서비스 데이터베이스에 액세스합니다.

다음과 같은 단일 데이터베이스를 선언해야 합니다. `<database kind="ApplicationCenter">`. `<database>` 요소에는 `<dba>` 및 `<client>` 요소가 없다는 점을 제외하고, `<database>` 요소는 `<configuredatabase>` Ant 태스크와 비슷하게 지정합니다. `<property>` 요소가 있을 수도 있습니다. 

`<database>` 요소에는 다음과 같은 속성이 있습니다.

|속성    |설명                                            |필수 |기본값 |
|--------------|--------------------------------------------------------|----------|---------|
|kind         |데이터베이스의 유형입니다(ApplicationCenter).              |예      |없음    |
|validate	   |데이터베이스에 액세스 가능한지 여부를 유효성 검증합니다. |아니오       |True    |

`<database>` 요소에서는 다음 요소를 지원합니다. 이 데이터베이스 요소의 구성에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블을 참조하십시오.

|요소           |설명	                            |개수 |
|-------------------|-------------------------------------------|-------|
|db2	            |DB2 데이터베이스에 대한 매개변수입니다.	        |0..1  |
|derby             |Apache Derby 데이터베이스에 대한 매개변수입니다.	|0..1  |
|mysql             |MySQL 데이터베이스에 대한 매개변수입니다.	    |0..1  |
|oracle	        |Oracle 데이터베이스에 대한 매개변수입니다.	    |0..1  |
|driverclasspath   |JDBC 드라이버 클래스 경로에 대한 매개변수입니다.	|0..1  |

### 사용자 및 보안 역할 지정
{: #to-specify-a-user-and-a-security-role }
`<user>` 요소는 애플리케이션의 특정 보안 역할에 포함할 사용자에 대한 매개변수를 수집하는 데 사용합니다.

|속성    |설명                                            |필수 |기본값 |
|--------------|--------------------------------------------------------|----------|---------|
|role         |사용자 역할 appcenteradmin입니다. |예 |없음 |
|name	       |사용자 이름입니다. |예 |없음 |
|password	   |비밀번호입니다(사용자를 작성해야 하는 경우).	|아니오 |없음 |

## {{ site.data.keys.mf_analytics }} 설치를 위한 Ant 태스크
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
**installanalytics**, **updateanalytics** 및 **uninstallanalytics** Ant 태스크는 {{ site.data.keys.mf_analytics }} 설치를 위해 제공됩니다.

이 Ant 태스크의 용도는 애플리케이션 서버에서 데이터에 대해 적절한 스토리지를 사용하여 {{ site.data.keys.mf_analytics_console }} 및 {{ site.data.keys.mf_analytics }} 서비스를 구성하는 것입니다.
이 태스크는 마스터 및 데이터 역할을 수행하는 {{ site.data.keys.mf_analytics }} 노드를 설치합니다. 자세한 정보는 [클러스터 관리 및 Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch)를 참조하십시오.

### 태스크 영향
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
**installanalytics** Ant 태스크는 IBM {{ site.data.keys.mf_analytics }}를 실행하도록 애플리케이션 서버를 구성합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 애플리케이션 서버에 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} WAR 파일을 배치합니다.
* 지정된 컨텍스트 루트 /analytics-service에서 {{ site.data.keys.mf_analytics }} 서비스 웹 애플리케이션을 선언합니다.
* 지정된 컨텍스트 루트 /analytics에서 {{ site.data.keys.mf_analytics_console }} 웹 애플리케이션을 선언합니다.
* JNDI 환경 항목을 통해 {{ site.data.keys.mf_analytics_console }} 및 {{ site.data.keys.mf_analytics }} 서비스 구성 특성을 설정합니다.
* WebSphere Application Server Liberty 프로파일에서 웹 컨테이너를 구성합니다.
* 선택적으로 {{ site.data.keys.mf_analytics_console }}을 사용할 사용자를 작성합니다.

#### updateanalytics
{: #updateanalytics }
**updateanalytics** Ant 태스크는 애플리케이션 서버에서 이미 구성된 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} 웹 애플리케이션 WAR 파일을 업데이트합니다. 이 파일은 이전에 배치된 프로젝트 WAR 파일과 동일한 기본 이름을 가지고 있어야 합니다.

이 태스크는 웹 애플리케이션 구성 및 JNDI 환경 항목 등의 애플리케이션 서버 구성을 변경하지 않습니다.

#### uninstallanalytics
{: #uninstallanalytics }
**uninstallanalytics** Ant 태스크는 이전 **installanalytics** 실행의 영향을 실행 취소합니다. 이 태스크는 다음과 같은 영향을 미칩니다.

* 각각의 컨텍스트 루트를 가진 {{ site.data.keys.mf_analytics }} 서비스와 {{ site.data.keys.mf_analytics_console }} 웹 애플리케이션 모두의 구성을 제거합니다.
* 애플리케이션 서버에서 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} WAR 파일을 제거합니다.
* 연관된 JNDI 환경 항목을 제거합니다.

### 속성 및 요소
{: #attributes-and-elements-4 }
**installanalytics**, **updateanalytics** 및 **uninstallanalytics** 태스크는 다음과 같은 속성을 가지고 있습니다.

|속성    |설명                                            |필수 |기본값 |
|--------------|--------------------------------------------------------|----------|---------|
|serviceWar   |{{ site.data.keys.mf_analytics }} 서비스에 대한 WAR 파일입니다.     |아니오       |analytics-service.war 파일은 Analytics 디렉토리에 있습니다. |

#### serviceWar
{: #servicewar-2 }
{{ site.data.keys.mf_analytics }} 서비스 WAR 파일에 대해 다른 디렉토리를 지정하려면 **serviceWar** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

`<installanalytics>`, `<updateanalytics>` 및 `<uninstallanalytics>` 태스크에서는 다음 요소를 지원합니다.

|속성         |설명                               |필수 |기본값 |
|-------------------|-------------------------------------------|----------|---------|
|console	        | {{ site.data.keys.mf_analytics }}   	                |예	   |1       |
|user	            |보안 역할에 맵핑될 사용자입니다.	|아니오	   |0..     |
|storage	        |스토리지의 유형입니다.	                    |예 	   |1       |
|applicationserver	|애플리케이션 서버입니다.	                |예	   |1       |
|property          |특성입니다.	                            |아니오 	   |0..     |

### {{ site.data.keys.mf_analytics_console }} 지정
{: #to-specify-a-mobilefirst-analytics-console }
`<console>` 요소는 {{ site.data.keys.mf_analytics_console }}의 설치를 사용자 정의하는 정보를 수집합니다. 이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성    |설명                                  |필수 |기본값 |
|--------------|----------------------------------------------|----------|---------|
|warfile	   |콘솔 WAR 파일입니다.	                      |아니오	     |analytics-ui.war 파일은 Analytics 디렉토리에 있습니다. |
|shortcutsdir |바로 가기를 배치하는 디렉토리입니다. |아니오	     |없음    |

#### warFile
{: #warfile-2 }
{{ site.data.keys.mf_analytics_console }} WAR 파일에 대해 다른 디렉토리를 지정하려면 **warFile** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 사용하여 이 WAR 파일의 이름을 지정할 수 있습니다.

#### shortcutsDir
{: #shortcutsdir-2 }
**shortcutsDir** 속성은 {{ site.data.keys.mf_analytics_console }}에 대한 바로 가기를 배치할 위치를 지정합니다. 이 속성을 설정하는 경우에는 다음과 같은 파일을 해당 디렉토리에 추가할 수 있습니다.

* **analytics-console.url**: 이 파일은 Windows 바로 가기입니다. 이 파일은 브라우저에서 {{ site.data.keys.mf_analytics_console }}을 엽니다.
* **analytics-console.sh**: 이 파일은 UNIX 쉘 스크립트입니다. 이 파일은 브라우저에서 {{ site.data.keys.mf_analytics_console }}을 엽니다.

> 참고: 이 바로 가기는 ElasticSearch 테넌트 매개변수를 포함하지 않습니다.

`<console>` 요소에서는 다음과 같은 중첩 요소를 지원합니다.

|요소  |설명	|개수 |
|----------|----------------|-------|
|property |특성	    |0..   |

이 요소를 사용하면 자체 JNDI 특성을 정의할 수 있습니다.

`<property>` 요소에는 다음과 같은 속성이 있습니다.

|속성  |설명                |필수 |기본값 |
|------------|----------------------------|----------|---------|
|이름       |특성의 이름입니다.  |예      |없음    |
|value	     |특성의 값입니다. |	예      |없음    |

### 사용자 및 보안 역할 지정
{: #to-specify-a-user-and-a-security-role-1 }
`<user>` 요소는 애플리케이션의 특정 보안 역할에 포함할 사용자에 대한 매개변수를 수집하는 데 사용합니다.

|속성   |설명                                   |필수 |기본값 |
|-------------|-----------------------------------------------|----------|---------|
|role	      |애플리케이션에 대한 올바른 보안 역할입니다.    |예      |없음    |
|name	      |사용자 이름입니다.	                              |예      |없음    |
|password	  |사용자를 작성해야 하는 경우 비밀번호입니다. |아니오       |없음    |

` <user>` 요소를 사용하여 사용자를 정의한 다음 {{ site.data.keys.mf_console }}에서 인증을 위해 다음 역할에 해당 사용자를 맵핑할 수 있습니다.

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### {{ site.data.keys.mf_analytics }}에 대한 스토리지 유형 지정
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
`<storage>` 요소는 {{ site.data.keys.mf_analytics }}에서 수집하는 정보와 데이터를 저장하기 위해 사용하는 기본 스토리지 유형을 나타냅니다.

이 요소는 다음과 같은 요소를 지원합니다.

|요소       |설명	|개수   |
|---------------|---------------|---------|
|elasticsearch	|ElasticSearch |클러스터 |

`<elasticsearch>` 요소는 ElasticSearch 클러스터에 대한 매개변수를 수집합니다.

|속성        |설명                                   |필수 |기본값   |
|------------------|-----------------------------------------------|----------|-----------|
|clusterName	   |ElasticSearch 클러스터 이름입니다.	           |아니오       |worklight |
|nodeName	       |ElasticSearch 노드 이름입니다. 이 이름은 ElasticSearch 클러스터에서 고유해야 합니다.	|아니오 |`worklightNode_<random number>` |
|mastersList	   | ElasticSearch 클러스터에서 ElasticSearch 마스터 노드의 호스트 이름 및 포트가 포함된 쉼표로 구분된 문자열입니다(예: hostname1:transport-port1,hostname2:transport-port2).	           |아니오       |	토폴로지에 따라 다름 |
|dataPath	       |ElasticSearch 클러스터 위치입니다.	       |아니오	      |애플리케이션 서버에 따라 다름 |
|shards	       |ElasticSearch 클러스터가 작성하는 샤드의 수입니다. 이 값은 ElasticSearch 클러스터에서 작성되는 마스터 노드에 의해서만 설정될 수 있습니다.	|아니오 |5 |
|replicasPerShard |ElasticSearch 클러스터의 각 샤드에 대한 복제본 수입니다. 이 값은 ElasticSearch 클러스터에서 작성되는 마스터 노드에 의해서만 설정될 수 있습니다. |아니오 |1 |
|transportPort	   |ElasticSearch 클러스터에서 노드 간 통신에 사용되는 포트입니다.	|아니오 |9600 |

#### clusterName
{: #clustername }
ElasticSearch 클러스터에 대해 사용자가 선택한 이름을 지정하려면 **clusterName** 속성을 사용하십시오.

ElasticSearch 클러스터는 동일한 클러스터 이름을 공유하는 하나 이상의 노드로 구성되므로 여러 노드를 구성하는 경우 **clusterName** 속성에 대해 동일한 값을 지정합니다.

#### nodeName
{: #nodename }
ElasticSearch 클러스터에서 구성할 노드에 대해 사용자가 선택한 이름을 지정하려면 **nodeName** 속성을 사용하십시오. 노드가 여러 머신에 걸쳐 있는 경우에도 각 노드 이름은 ElasticSearch 클러스터에서 고유해야 합니다.

#### mastersList
{: #masterslist }
ElasticSearch 클러스터에 있는 마스터 노드의 쉼표로 구분된 목록을 제공하려면 **mastersList** 속성을 사용하십시오. 이 목록의 각 마스터 노드는 해당 호스트 이름 및 ElasticSearch 노드 간 통신 포트에 의해 식별되어야 합니다. 이 포트는 기본값인 9600이거나 해당 마스터 노드를 구성할 때 **transportPort** 속성을 사용하여 지정한 포트 번호입니다.

예: `hostname1:transport-port1, hostname2:transport-port2`.

**참고:**

* 기본값인 9600과 다른 **transportPort**를 지정하는 경우에는 **transportPort** 속성을 사용하여 이 값도 설정해야 합니다. 기본적으로 **mastersList** 속성이 생략되면 지원되는 모든 애플리케이션 서버에서 호스트 이름 및 ElasticSearch 전송 포트를 발견하려고 시도합니다.
* 대상 애플리케이션 서버가 WebSphere Application Server Network Deployment 클러스터인 경우 나중에 이 클러스터에서 서버를 추가하거나 제거하는 경우에는 ElasticSearch 클러스터와 동기화 상태를 유지하기 위해 수동으로 이 목록을 편집해야 합니다.

#### dataPath
{: #datapath }
ElasticsSearch 데이터를 저장할 다른 디렉토리를 지정하려면 **dataPath** 속성을 사용하십시오. 절대 경로 또는 상대 경로를 지정할 수 있습니다.

**dataPath** 속성이 지정되지 않은 경우 ElasticSearch 클러스터 데이터는 **analyticsData**라는 기본 디렉토리(애플리케이션 서버에 따라 위치가 다름)에 저장됩니다.

* WebSphere Application Server Liberty 프로파일의 경우 위치는 `${wlp.user.dir}/servers/serverName/analyticsData`입니다.
* Apache Tomcat의 경우 위치는 `${CATALINA_HOME}/bin/analyticsData`입니다.
* WebSphere Application Server 및 WebSphere Application Server Network Deployment의 경우 위치는 `${was.install.root}/profiles/<profileName>/analyticsData`입니다.

{{ site.data.keys.mf_analytics }} 서비스 컴포넌트가 이벤트를 수신할 때 **analyticsData** 디렉토리 및 이 디렉토리에 포함된 서브디렉토리 및 파일의 계층 구조가 없으면 런타임 시 이들이 자동으로 작성됩니다.

#### shards
{: #shards }
ElasticSearch 클러스터에서 작성할 샤드 수를 지정하려면 **shards** 속성을 사용하십시오.

#### replicasPerShard
{: #replicaspershard }
ElasticSearch 클러스터에서 각 샤드에 대해 작성할 복제본의 수를 지정하려면 **replicasPerShard** 속성을 사용하십시오.

각각의 샤드는 0개 이상의 복제본을 가질 수 있습니다. 기본적으로 각각의 샤드는 하나의 복제본을 가지지만 복제본 수는 {{ site.data.keys.mf_analytics }}의 기존 색인에서 동적으로 변경될 수 있습니다. 복제본 샤드는 해당 샤드와 동일한 노드에서 시작될 수 없습니다.

#### transportPort
{: #transportport }
이 노드와 통신할 때 ElasticSearch 클러스터의 다른 노드가 사용해야 하는 포트를 지정하려면 **transportPort** 속성을 사용하십시오. 이 노드가 프록시 또는 방화벽 뒤에 있으면 이 포트가 사용 가능하고 액세스 가능한지 확인해야 합니다.

### 애플리케이션 서버 지정
{: #to-specify-an-application-server-4 }
`<applicationserver>` 요소를 사용하여 기본 Application Server에 따라 다른 매개변수를 정의하십시오. `<applicationserver>` 요소에서는 다음 요소를 지원합니다.

**참고:** 이 요소의 속성 및 내부 요소가 [{{ site.data.keys.product_adj }} 런타임 환경 설치를 위한 Ant 태스크](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)의 테이블에 설명되어 있습니다.

|요소                                   |설명	|개수   |
|-------------------------------------------|---------------|---------|
|**websphereapplicationserver** 또는 **was** |WebSphere Application Server에 대한 매개변수입니다.	|0..1 |
|tomcat	                                |Apache Tomcat에 대한 매개변수입니다.	|0..1 |

### 사용자 정의 JNDI 특성 지정
{: #to-specify-custom-jndi-properties }
`<installanalytics>`, `<updateanalytics>` 및 `<uninstallanalytics>` 요소에서는 다음 요소를 지원합니다.

|요소  |설명 |개수 |
|----------|-------------|-------|
|property |특성	 |0..   |

이 요소를 사용하면 자체 JNDI 특성을 정의할 수 있습니다.

이 요소는 다음과 같은 속성을 가지고 있습니다.

|속성  |설명                |필수 |기본값 |
|------------|----------------------------|----------|---------|
|이름       |특성의 이름입니다.  |예      |없음    |
|value	     |특성의 값입니다. |	예      |없음    |

## 내부 런타임 데이터베이스
{: #internal-runtime-databases }
런타임 데이터베이스 테이블, 해당 용도 및 각 테이블에 저장된 데이터의 크기 정도에 대해 학습하십시오. 관계형 데이터베이스에서 엔티티는 데이터베이스 테이블에서 구성됩니다.

### {{ site.data.keys.mf_server }} 런타임에서 사용하는 데이터베이스
{: #database-used-by-mobilefirst-server-runtime }
다음 테이블에는 런타임 데이터베이스 테이블, 해당 설명 및 관계형 데이터베이스에서 해당 테이블 사용 방법의 목록이 제공됩니다.

|관계형 데이터베이스 테이블 이름 |설명 |크기의 정도 |
|--------------------------------|-------------|--------------------|
|LICENSE_TERMS	                 |디바이스 역할 해제 태스크가 실행될 때마다 캡처되는 다양한 라이센스 메트릭을 저장합니다. |수십 개의 행. 이 값은 JNDI 특성 mfp.device.decommission.when 특성에 의해 설정된 값을 초과하지 않습니다. JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오. |
|ADDRESSABLE_DEVICE	         |주소 지정 가능한 디바이스 메트릭을 매일 저장합니다. 또한 클러스터가 시작될 때마다 항목이 추가됩니다.	|약 400개의 행. 13개월보다 오래된 항목은 매일 삭제됩니다. |
|MFP_PERSISTENT_DATA	         |클라이언트와 연관된 디바이스, 애플리케이션, 사용자에 대한 정보 및 디바이스 상태를 포함하여 OAuth 서버에 등록된 클라이언트 애플리케이션의 인스턴스를 저장합니다. |디바이스 및 애플리케이션 쌍당 하나의 행 |
|MFP_PERSISTENT_CUSTOM_ATTR	 |클라이언트 애플리케이션의 인스턴스와 연관된 사용자 정의 속성입니다. 사용자 정의 속성은 애플리케이션이 각 클라이언트 인스턴스에 대해 등록한 애플리케이션별 속성입니다. |디바이스 및 애플리케이션 쌍당 0개 이상의 행 |
|MFP_TRANSIENT_DATA	         |클라이언트 및 디바이스의 인증 컨텍스트 |디바이스 및 애플리케이션 쌍당 두 개의 행(디바이스 싱글 사인온 사용 시 디바이스당 별도의 두 행). SSO에 대한 자세한 정보는 [디바이스 싱글 사인온(SSO) 구성](../../../authentication-and-security/device-sso)을 참조하십시오. |
|SERVER_VERSION	             |제품 버전입니다.	|하나의 행 |

### {{ site.data.keys.mf_server }} 관리 서비스에서 사용하는 데이터베이스
{: #database-used-by-mobilefirst-server-administration-service }
다음 테이블에는 관리 데이터베이스 테이블, 해당 설명 및 관계형 데이터베이스에서 해당 테이블 사용 방법의 목록이 제공됩니다.

|관계형 데이터베이스 테이블 이름 |설명 |크기의 정도 |
|--------------------------------|-------------|--------------------|
|ADMIN_NODE	                 |관리 서비스를 실행하는 서버에 대한 정보를 저장합니다. 하나의 서버만 있는 독립형 토폴로지에서는 이 엔티티가 사용되지 않습니다. |서버당 하나의 행(독립형 서버가 사용되는 경우에는 비어 있음) |
|AUDIT_TRAIL	                 |관리 서비스를 사용하여 수행된 모든 관리 조치의 감사 추적을 저장합니다. |수천 개의 행 |
|CONFIG_LINKS	                 |라이브 업데이트 서비스에 대한 링크를 저장합니다. 어댑터 및 애플리케이션에는 라이브 업데이트 서비스에 저장되는 구성이 있으며 링크를 사용하여 해당 구성을 찾습니다.	|수백 개의 행. 어댑터당 2개 - 3개 행이 사용됩니다. 애플리케이션당 4개 - 6개 행이 사용됩니다. |
|FARM_CONFIG	                 |서버 팜이 사용될 때 팜 노드의 구성을 저장합니다. |수십 개의 행(서버 팜이 사용되는 경우에는 비어 있음) |
|GLOBAL_CONFIG	                 |일부 글로벌 구성 데이터를 저장합니다. |1개 행 |
|PROJECT	                     |배치된 프로젝트의 이름을 저장합니다. |수십 개의 행. |
|PROJECT_LOCK	                 |내부 클러스터 동기화 태스크입니다. |수십 개의 행. |
|TRANSACTIONS	                 |내부 클러스터 동기화 테이블이며 모든 현재 관리 조치의 상태를 저장합니다. |수십 개의 행. |
|MFPADMIN_VERSION	             |제품 버전입니다.	|하나의 행 |

### {{ site.data.keys.mf_server }} 라이브 업데이트 서비스에서 사용하는 데이터베이스
{: #database-used-by-mobilefirst-server-live-update-service }
다음 테이블에는 라이브 업데이트 서비스 데이터베이스 테이블, 해당 설명 및 관계형 데이터베이스에서 해당 테이블 사용 방법의 목록이 제공됩니다.

|관계형 데이터베이스 테이블 이름 |설명 |크기의 정도 |
|--------------------------------|-------------|--------------------|
|CS_SCHEMAS	                 |플랫폼에 있는 버전화된 스키마를 저장합니다.	|스키마당 하나의 행 |
|CS_CONFIGURATIONS	             |각 버전화된 스키마에 대한 구성의 인스턴스를 저장합니다. |구성당 하나의 행 |
|CS_TAGS	                     |각 구성 인스턴스에 대해 검색 가능한 필드 및 값을 저장합니다.	|구성의 각 검색 가능한 필드와 각 필드 이름 및 값에 대한 행 |
|CS_ATTACHMENTS	             |각 구성 인스턴스에 대한 첨부 파일을 저장합니다. |첨부 파일당 하나의 행 |
|CS_VERSION	                 |테이블 또는 인스턴스를 작성한 MFP의 버전을 저장합니다. |MFP의 버전이 있는 테이블의 단일 행 |

### {{ site.data.keys.mf_server }} 푸시 서비스에서 사용하는 데이터베이스
{: #database-used-by-mobilefirst-server-push-service }
다음 테이블에는 푸시 서비스 데이터베이스 테이블, 해당 설명 및 관계형 데이터베이스에서 해당 테이블 사용 방법의 목록이 제공됩니다.

|관계형 데이터베이스 테이블 이름 |설명 |크기의 정도 |
|--------------------------------|-------------|--------------------|
|PUSH_APPS	                     |푸시 알림 테이블이며 푸시 애플리케이션의 세부사항을 저장합니다. |애플리케이션당 하나의 행 |
|PUSH_ENV	                     |푸시 알림 테이블이며 푸시 환경의 세부사항을 저장합니다. |수십 개의 행. |
|PUSH_TAGS	                     |푸시 알림 테이블이며 정의된 태그의 세부사항을 저장합니다.	     |수십 개의 행. |
|PUSH_DEVICES	                 |푸시 알림 테이블입니다. 디바이스당 하나의 레코드를 저장합니다.	         |디바이스당 하나의 행 |
|PUSH_SUBSCRIPTIONS	         |푸시 알림 테이블입니다. 태그 등록당 하나의 레코드를 저장합니다. |디바이스 등록당 하나의 행 |
|PUSH_MESSAGES	                 |푸시 알림 테이블이며 푸시 메시지의 세부사항을 저장합니다.	 |수십 개의 행. |
|PUSH_MESSAGE_SEQUENCE_TABLE	 |푸시 알림 테이블이며 생성된 시퀀스 ID를 저장합니다.	 |하나의 행 |
|PUSH_VERSION	                 |제품 버전입니다.	                                         |하나의 행 |

데이터베이스 설정에 대한 자세한 정보는 [데이터베이스 설정](../prod-env/databases)을 참조하십시오.

## 샘플 구성 파일
{{ site.data.keys.product }}에는 {{ site.data.keys.mf_server }}를 설치하기 위해 Ant 태스크를 시작하는 데 도움이 되는 다수의 샘플 구성 파일이 포함되어 있습니다.

이 Ant 태스크를 시작하는 가장 쉬운 방법은 {{ site.data.keys.mf_server }} 배포의 **MobileFirstServer/configuration-samples/** 디렉토리에 제공된 샘플 구성 파일을 사용하여 작업하는 것입니다. Ant 태스크를 사용한 {{ site.data.keys.mf_server }} 설치에 대한 자세한 정보는 [Ant 태스크를 사용한 설치](../prod-env/appserver/#installing-with-ant-tasks)를 참조하십시오.

### 샘플 구성 파일 목록
{: #list-of-sample-configuration-files }
적절한 샘플 구성 파일을 선택하십시오. 다음과 같은 파일이 제공됩니다.

|태스크                                                     |Derby                     |DB2                     |MySQL                     |Oracle                      |
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
|데이터베이스 관리자 신임 정보를 사용하여 데이터베이스 작성 |create-database-derby.xml |create-database-db2.xml |create-database-mysql.xml |create-database-oracle.xml
|Liberty에 {{ site.data.keys.mf_server }} 설치	                   |configure-liberty-derby.xml |configure-liberty-db2.xml |configure-liberty-mysql.xml |(MySQL에 대한 참고 참조) |configure-liberty-oracle.xml |
|WebSphere Application Server 전체 프로파일에 {{ site.data.keys.mf_server }} 설치(단일 서버) |	configure-was-derby.xml |configure-was-db2.xml |configure-was-mysql.xml(MySQL에 대한 참고 참조) |configure-was-oracle.xml |
|WebSphere Application Server Network Deployment에 {{ site.data.keys.mf_server }} 설치(구성 파일에 대한 참고 참조) |configure-wasnd-cluster-derby.xml, configure-wasnd-server-derby.xml, configure-wasnd-node-derby.xml. configure-wasnd-cell-derby.xml |configure-wasnd-cluster-db2.xml, configure-wasnd-server-db2.xml, configure-wasnd-node-db2.xml, configure-wasnd-cell-db2.xml |configure-wasnd-cluster-mysql.xml(MySQL에 대한 참고 참조), configure-wasnd-server-mysql.xml(MySQL에 대한 참고 참조), configure-wasnd-node-mysql.xml(MySQL에 대한 참고 참조), configure-wasnd-cell-mysql.xml |configure-wasnd-cluster-oracle.xml, configure-wasnd-server-oracle.xml, configure-wasnd-node-oracle.xml, configure-wasnd-cell-oracle.xml |
|Apache Tomcat에 {{ site.data.keys.mf_server }} 설치	           |configure-tomcat-derby.xml |configure-tomcat-db2.xml |configure-tomcat-mysql.xml |configure-tomcat-oracle.xml |
|Liberty Collective에 {{ site.data.keys.mf_server }} 설치	       |관련 없음              |configure-libertycollective-db2.xml |configure-libertycollective-mysql.xml |configure-libertycollective-oracle.xml |

**MySQL에 대한 참고:** WebSphere Application Server Liberty 프로파일 또는 WebSphere Application Server 전체 프로파일과 조합된 MySQL은 지원되는 구성으로 분류되지 않습니다. 자세한 정보는 WebSphere Application Server 지원 설명서를 참조하십시오. IBM DB2 또는 WebSphere Application Server에서 지원하는 다른 데이터베이스를 사용하여 IBM 지원 센터에서 완전히 지원하는 구성을 활용해 보십시오.

**WebSphere Application Server Network Deployment용 구성 파일에 대한 참고:** **wasnd**에 대한 구성 파일에는 **cluster**, **node**, **server** 또는 **cell**로 설정할 수 있는 범위가 포함되어 있습니다. 예를 들어, **configure-wasnd-cluster-derby.xml**의 경우 범위는 **cluster**입니다. 이 범위 유형은 다음과 같이 배치 대상을 정의합니다.

* **cluster**: 클러스터에 배치합니다.
* **server**: 배치 관리자가 관리하는 단일 서버에 배치합니다.
* **node**: 노드에서 실행 중이지만 클러스터에 속하지 않는 모든 서버에 배치합니다.
* **cell**: 셀의 모든 서버에 배치합니다.

## {{ site.data.keys.mf_analytics }}에 대한 샘플 구성 파일
{: #sample-configuration-files-for-mobilefirst-analytics }
{{ site.data.keys.product }}에는 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }}을 설치하기 위해 Ant 태스크를 시작하는 데 도움이 되는 다수의 샘플 구성 파일이 포함되어 있습니다.

`<installanalytics>`, `<updateanalytics>` 및 `<uninstallanalytics>` Ant 태스크를 시작하는 가장 쉬운 방법은 {{ site.data.keys.mf_server }} 배포의 **Analytics/configuration-samples/** 디렉토리에서 제공되는 샘플 구성 파일을 사용하여 작업하는 것입니다.

### 1단계
{: #step-1 }
적절한 샘플 구성 파일을 선택하십시오. 다음과 같은 XML 파일이 제공됩니다. 이 파일을 다음 단계에서는 **configure-file.xml**이라고 합니다.

|태스크 |Application server |
|------|--------------------|
|WebSphere Application Server Liberty 프로파일에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치 |configure-liberty-analytics.xml |
|Apache Tomcat에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치 |configure-tomcat-analytics.xml |
|WebSphere Application Server 전체 프로파일에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치 |configure-was-analytics.xml |
|WebSphere Application Server Network Deployment에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치(단일 서버) |configure-wasnd-server-analytics.xml |
|WebSphere Application Server Network Deployment에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치(셀) |configure-wasnd-cell-analytics.xml |
|WebSphere Application Server Network Deployment에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치(노드) |configure-wasnd-node.xml |
|WebSphere Application Server Network Deployment에 {{ site.data.keys.mf_analytics }} 서비스 및 콘솔 설치(클러스터) |configure-wasnd-cluster-analytics.xml |

**WebSphere Application Server Network Deployment의 구성 파일에 대한 참고:**  
wasnd에 대한 구성 파일에는 **cluster**, **node**, **server** 또는 **cell**로 설정될 수 있는 범위가 포함되어 있습니다. 예를 들어, **configure-wasnd-cluster-analytics.xml**의 경우 범위는 **cluster**입니다. 이 범위 유형은 다음과 같이 배치 대상을 정의합니다.

* **cluster**: 클러스터에 배치합니다.
* **server**: 배치 관리자가 관리하는 단일 서버에 배치합니다.
* **node**: 노드에서 실행 중이지만 클러스터에 속하지 않는 모든 서버에 배치합니다.
* **cell**: 셀의 모든 서버에 배치합니다.

### 2단계
{: #step-2 }
샘플 파일의 파일 액세스 권한을 가능하면 제한적으로 변경하십시오. 3단계에서는 일부 비밀번호를 제공해야 합니다. 동일한 컴퓨터의 다른 사용자가 이러한 비밀번호를 모르게 하려면 본인 외의 사용자에 대해 파일의 읽기 권한을 제거해야 합니다. 다음 예와 같이 명령을 사용할 수 있습니다.

UNIX의 경우: `chmod 600 configure-file.xml`
Windows의 경우: `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### 3단계
{: #step-3 }
마찬가지로 애플리케이션 서버가 WebSphere Application Server Liberty 프로파일 또는 Apache Tomcat인 경우 사용자 계정에서만 서버가 시작되도록 되어 있으면 다음과 같은 파일에서 본인 이외의 사용자에 대한 읽기 권한도 제거해야 합니다.

* WebSphere Application Server Liberty 프로파일의 경우: **wlp/usr/servers/<server>/server.xml**
* Apache Tomcat의 경우: **conf/server.xml**

### 4단계
{: #step-4 }
파일의 시작 부분에 있는 특성의 플레이스홀더 값을 바꾸십시오.

**참고:**  
다음과 같은 특수문자는 Ant XML 스크립트의 값에서 사용될 때 이스케이프해야 합니다.

* Apache Ant 매뉴얼의 특성 절에 설명된 대로 `${variable}` 구문을 통해 Ant 변수를 명시적으로 참조하려는 경우가 아니면 달러 부호(`$`)는 $$로 써야 합니다.
* XML 엔티티를 명시적으로 참조하려는 경우가 아니면 앰퍼샌드 문자(`&`)는 `&amp;`로 써야 합니다.
* 작은따옴표로 묶인 문자열에 있는 경우를 제외하고 큰따옴표(`"`)는 `&quot;`로 써야 합니다.

### 5단계
{: #step-5 }
`ant -f configure-file.xml install` 명령을 실행하십시오.

이 명령은 애플리케이션 서버에서 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} 컴포넌트를 설치합니다.
업데이트된 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} 컴포넌트를 설치하려면(예: {{ site.data.keys.mf_server }} 수정팩을 적용하는 경우) `ant -f configure-file.xml minimal-update` 명령을 실행하십시오.

설치 단계를 되돌리려면 `ant -f configure-file.xml uninstall` 명령을 실행하십시오.

이 명령은 {{ site.data.keys.mf_analytics }} 서비스 및 {{ site.data.keys.mf_analytics_console }} 컴포넌트를 설치 제거합니다.
