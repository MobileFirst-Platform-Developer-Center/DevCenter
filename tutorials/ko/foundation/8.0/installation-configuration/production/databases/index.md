---
layout: tutorial
title: 데이터베이스 설정
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
다음 {{ site.data.keys.mf_server_full }} 컴포넌트는 기술 데이터를 데이터베이스에 저장해야 합니다.

* {{ site.data.keys.mf_server }} 관리 서비스
* {{ site.data.keys.mf_server }} 라이브 업데이트 서비스
* {{ site.data.keys.mf_server }} 푸시 서비스
* {{ site.data.keys.product }} 런타임

> **참고:** 다른 컨텍스트 루트를 가진 여러 런타임 인스턴스가 설치되는 경우 각 인스턴스에는 자체 테이블 세트가 필요합니다.
> 데이터베이스는 IBM  DB2 , Oracle 또는 MySQL 등의 관계형 데이터베이스일 수 있습니다.

#### 관계형 데이터베이스(DB2, Oracle 또는 MySQL)
{: #relational-databases-db2-oracle-or-mysql }
각 컴포넌트에는 테이블 세트가 필요합니다. 테이블은 Ant 태스크 또는 Server Configuration Tool을 사용하여 각 컴포넌트에 고유한 SQL 스크립트를 실행하여 수동으로 작성될 수 있습니다([수동으로 데이터베이스 테이블 작성](#create-the-database-tables-manually) 참조). 각 컴포넌트의 테이블 이름은 겹치지 않습니다. 따라서 이 컴포넌트의 모든 테이블을 단일 스키마 아래에 배치할 수 있습니다.

하지만 각각 애플리케이션 서버에 자체 컨텍스트 루트를 가진 {{ site.data.keys.product }} 런타임의 여러 인스턴스를 설치하도록 결정하는 경우에는 모든 인스턴스에 자체 테이블 세트가 필요합니다. 이 경우 이들은 서로 다른 스키마에 있어야 합니다.

> **DB2에 대한 참고:** {{ site.data.keys.product_adj }} 라이센스 사용자는 DB2를 Foundation에 대한 지원 시스템으로 사용할 수 있습니다. 이를 위해서는 DB2 소프트웨어를 설치한 후 다음을 수행해야 합니다.
> 
> * [IBM Passport Advantage(PPA) 웹 사이트](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)에서 직접 용도가 제한된 활성화 이미지 다운로드
> * **db2licm** 명령을 사용하여 용도가 제한된 활성화 라이센스 파일 **db2xxxx.lic** 적용
>
> [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html)에서 자세히 학습하십시오.

#### 다음으로 이동
{: #jump-to }

* [데이터베이스 사용자 및 권한](#database-users-and-privileges)
* [데이터베이스 요구사항](#database-requirements)
* [수동으로 데이터베이스 테이블 작성](#create-the-database-tables-manually)
* [Server Configuration Tool을 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-the-server-configuration-tool)
* [Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)

## 데이터베이스 사용자 및 권한
{: #database-users-and-privileges }
런타임 시 애플리케이션 서버의 {{ site.data.keys.mf_server }} 애플리케이션은 데이터 소스를 자원으로 사용하여 관계형 데이터베이스에 연결합니다. 데이터 소스에는 데이터베이스에 액세스할 수 있는 특정 권한을 가진 사용자가 필요합니다.

관계형 데이터베이스에 대한 액세스 권한을 가지도록 애플리케이션 서버에 배치되는 각각의 {{ site.data.keys.mf_server }} 애플리케이션에 대한 데이터 소스를 구성해야 합니다. 데이터 소스에는 데이터베이스에 액세스할 수 있는 특정 권한을 가진 사용자가 필요합니다. 작성해야 하는 사용자의 수는 {{ site.data.keys.mf_server }} 애플리케이션을 애플리케이션 서버에 배치하는 데 사용되는 설치 프로시저에 따라 다릅니다.

### Server Configuration Tool을 사용한 설치
{: #installation-with-the-server-configuration-tool }
모든 컴포넌트({{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 구성 서비스, {{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.product }} 런타임)에 대해 동일한 사용자가 사용됩니다.

### Ant 태스크를 사용한 설치
{: #installation-with-ant-tasks }
제품 배포에 제공되는 샘플 Ant 파일은 모든 컴포넌트에 대해 동일한 사용자를 사용합니다. 하지만 다른 사용자를 사용하도록 Ant 파일을 수정할 수 있습니다.

* 관리 서비스 및 구성 서비스는 Ant 태스크를 사용하여 별도로 설치할 수 없으므로 이들에 대해서는 동일한 사용자
* 런타임에 대해서는 다른 사용자
* 푸시 서비스에 대해서는 다른 사용자

### 수동 설치
{: #manual-installation }
각 {{ site.data.keys.mf_server }} 컴포넌트에 다른 데이터 소스를 지정할 수 있으므로 다른 사용자를 지정할 수 있습니다.
런타임 시 사용자는 해당 데이터의 테이블 및 시퀀스에 대해 다음과 같은 권한을 가지고 있어야 합니다.

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Ant 태스크 또는 Server Configuration Tool을 사용한 설치를 실행하기 전에 수동으로 테이블이 작성되지 않은 경우에는 테이블을 작성할 수 있는 사용자가 있는지 확인하십시오. 다음과 같은 권한도 필요합니다.

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

제품을 업그레이드하는 경우에는 다음과 같은 추가 권한이 필요합니다.

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## 데이터베이스 요구사항
{: #database-requirements }
데이터베이스는 {{ site.data.keys.mf_server }} 애플리케이션의 모든 데이터를 저장합니다. {{ site.data.keys.mf_server }} 컴포넌트를 설치하기 전에 데이터베이스 요구사항이 충족되었는지 확인하십시오.

* [DB2 데이터베이스 및 사용자 요구사항](#db2-database-and-user-requirements)
* [Oracle 데이터베이스 및 사용자 요구사항](#oracle-database-and-user-requirements)
* [MySQL 데이터베이스 및 사용자 요구사항](#mysql-database-and-user-requirements)

> 지원되는 데이터베이스 소프트웨어 버전의 최신 목록은 [시스템 요구사항](../../../product-overview/requirements/) 페이지를 참조하십시오.

### DB2 데이터베이스 및 사용자 요구사항
{: #db2-database-and-user-requirements }
DB2에 대한 데이터베이스 요구사항을 검토하십시오. 단계를 수행하여 사용자 및 데이터베이스를 작성하고 특정 요구사항을 충족하도록 데이터베이스를 설정하십시오.

데이터베이스 문자 세트를 UTF-8로 설정했는지 확인하십시오.

데이터베이스의 페이지 크기는 32768이상이어야 합니다. 다음 프로시저에서는 페이지 크기가 32768인 데이터베이스를 작성합니다. 또한 사용자(**mfpuser**)를 작성한 후 이 사용자에게 데이터베이스 액세스 권한을 부여합니다. 그러면 Server Configuration Tool 또는 Ant 태스크에서 테이블을 작성하는 데 이 사용자를 사용할 수 있습니다.

1. 운영 체제에 대해 적절한 명령을 사용하여 DB2 관리 그룹(예: **DB2USERS**)에서 예를 들어, **mfpuser**라는 시스템 사용자를 작성하십시오. 이 사용자에게 비밀번호(예: **mfpuser**)를 제공하십시오.
2. **SYSADM** 또는 **SYSCTRL** 권한을 가진 사용자로 DB2 명령행 프로세서를 여십시오.
    * Windows 시스템에서 **시작 → IBM DB2 → 명령행 프로세서**를 클릭하십시오.
    * Linux 또는 UNIX 시스템의 경우 **~/sqllib/bin**으로 이동하여 `./db2`를 입력하십시오.
3. {{ site.data.keys.mf_server }} 데이터베이스를 작성하려면 다음 예와 비슷한 SQL문을 입력하십시오.

사용자 이름 **mfpuser**를 자체 이름으로 바꾸십시오.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Oracle 데이터베이스 및 사용자 요구사항
{: #oracle-database-and-user-requirements }
Oracle에 대한 데이터베이스 요구사항을 검토하십시오. 단계를 수행하여 사용자 및 데이터베이스를 작성하고 특정 요구사항을 충족하도록 데이터베이스를 설정하십시오.

데이터베이스 문자 세트를 유니코드 문자 세트(AL32UTF8)로 설정하고 자국 문자 세트를 UTF8 - 유니코드 3.0 UTF-8로 설정했는지 확인하십시오.  

런타임 사용자([데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명되어 있음)는 연관된 테이블스페이스와 {{ site.data.keys.product }} 서비스에 필요한 기술 데이터를 기록하는 데 충분한 할당량을 가지고 있어야 합니다. 제품에서 사용하는 테이블에 대한 자세한 정보는 [내부 런타임 데이터베이스](../installation-reference/#internal-runtime-databases)를 참조하십시오.

테이블은 런타임 사용자의 기본 스키마에서 작성될 것으로 예상됩니다. Ant 태스크 및 Server Configuration Tool은 인수로 전달된 사용자의 기본 스키마에서 테이블을 작성합니다. 테이블 작성에 대한 자세한 정보는 [수동으로 Oracle 데이터베이스 테이블 작성](#creating-the-oracle-database-tables-manually)을 참조하십시오.

필요한 경우 프로시저에서는 데이터베이스를 작성합니다. 이 데이터베이스에서 테이블 및 색인을 작성할 수 있는 사용자가 추가되어 런타임 사용자로 사용됩니다.

1. 아직 데이터베이스가 없으면 Oracle DBCA(Database Configuration Assistant)를 사용하고 마법사의 단계를 수행하여 새 범용 데이터베이스(이 예에서는 ORCL)를 작성하십시오.
    * 글로벌 데이터베이스 이름 **ORCL\_your\_domain** 및 시스템 ID(SID) **ORCL**을 사용하십시오.
    * **데이터베이스 컨텐츠**의 **사용자 정의 스크립트** 탭에서 SQL 스크립트를 실행하지 마십시오. 왜냐하면 사용자 계정을 먼저 작성해야 하기 때문입니다.
    * **초기화 매개변수** 단계의 **문자 세트** 탭에서 **유니코드(AL32UTF8) 문자 세트 및 UTF8 - 유니코드 3.0 UTF-8 자국 문자 세트 사용**을 선택하십시오.
    * 기본값을 승인하여 프로시저를 완료하십시오.
2. Oracle 데이터베이스 제어 또는 Oracle SQLPlus 명령행 해석기를 사용하여 데이터베이스 사용자를 작성하십시오.
3. Oracle 데이터베이스 제어 사용:
    * **SYSDBA**로 연결하십시오.
    * **사용자** 페이지로 이동하여 **서버**를 클릭한 후 **보안** 섹션에서 **사용자**를 클릭하십시오.
    * 사용자(예: **MFPUSER**)를 작성하십시오.
    * 다음과 같은 속성을 지정하십시오.
        * **프로파일**: DEFAULT
        * **인증**: password
        * **기본 테이블스페이스**: USERS
        * **임시 테이블스페이스**: TEMP
        * **상태**: Unlocked
        * 시스템 권한 추가: CREATE SESSION
        * 시스템 권한 추가: CREATE SEQUENCE
        * 시스템 권한 추가: CREATE TABLE
        * 인용구 추가: USERS 테이블스페이스의 경우 무제한
    * Oracle SQLPlus 명령행 해석기 사용:

다음 예에 있는 명령은 데이터베이스에 대해 **MFPUSER**라는 사용자를 작성합니다.

```sql
CONNECT SYSTEM/<SYSTEM_password>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER_password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### MySQL 데이터베이스 및 사용자 요구사항
{: #mysql-database-and-user-requirements }
MySQL에 대한 데이터베이스 요구사항을 검토하십시오. 단계를 수행하여 사용자 및 데이터베이스를 작성하고 특정 요구사항을 충족하도록 데이터베이스를 구성하십시오.

문자 세트를 UTF8로 설정했는지 확인하십시오.

적절한 값으로 다음과 같은 특성을 지정해야 합니다.

* 256M 이상의 max_allowed_packet
* 250M 이상의 innodb_log_file_size

특성 설정 방법에 대한 자세한 정보는 [MySQL 문서](http://dev.mysql.com/doc/)를 참조하십시오.  
프로시저에서는 데이터베이스(MFPDATA)와 호스트(mfp-host)의 모든 권한을 가진 데이터베이스에 연결할 수 있는 사용자(mfpuser)를 작성합니다.

1. `-u root` 옵션을 사용하여 MySQL 명령행 클라이언트를 실행하십시오.
2. 다음과 같은 명령을 입력하십시오.

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'mfp-host' IDENTIFIED BY 'mfpuser-password';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-password';
   FLUSH PRIVILEGES;
   ```

    여기서 "at" 부호(@) 앞의 mfpuser는 사용자 이름이고 **IDENTIFIED BY** 뒤의 **mfpuser-password**는 비밀번호이고 **mfp-host**는 {{ site.data.keys.product_adj }}가 실행되는 호스트의 이름입니다.
    
    사용자는 {{ site.data.keys.mf_server }} 애플리케이션이 설치된 Java 애플리케이션 서버를 실행하는 호스트에서 MySQL 서버에 연결할 수 있어야 합니다.
    
## 수동으로 데이터베이스 테이블 작성
{: #create-the-database-tables-manually }
{{ site.data.keys.mf_server }} 애플리케이션에 대한 데이터베이스 테이블은 Ant 태스크 또는 Server Configuration Tool을 사용하여 수동으로 작성될 수 있습니다. 이 주제에서는 수동으로 해당 테이블을 작성하는 방법에 대한 설명 및 세부사항을 제공합니다.

* [수동으로 DB2 데이터베이스 테이블 작성](#creating-the-db2-database-tables-manually)
* [수동으로 Oracle 데이터베이스 테이블 작성](#creating-the-oracle-database-tables-manually)
* [수동으로 MySQL 데이터베이스 테이블 작성](#creating-the-mysql-database-tables-manually)

### 수동으로 DB2 데이터베이스 테이블 작성
{: #creating-the-db2-database-tables-manually }
{{ site.data.keys.mf_server }} 설치에 제공되는 SQL 스크립트를 사용하여 DB2 데이터베이스 테이블을 작성하십시오.

개요 절에 설명된 대로 네 개의 {{ site.data.keys.mf_server }} 컴포넌트 모두에 테이블이 필요합니다. 이들은 동일한 스키마 또는 서로 다른 스키마에서 작성될 수 있습니다. 하지만 {{ site.data.keys.mf_server }} 애플리케이션이 Java 애플리케이션 서버에 배치되는 방식에 따라 일부 제한조건이 적용됩니다. 이는 [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명된 대로 DB2의 가능한 사용자에 대한 주제와 비슷합니다.

#### Server Configuration Tool을 사용한 설치
{: #installation-with-the-server-configuration-tool-1 }
모든 컴포넌트({{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.product }} 런타임)에 대해 동일한 스키마가 사용됩니다.

#### Ant 태스크를 사용한 설치
{: #installation-with-ant-tasks-1 }
제품 배포에 제공되는 샘플 Ant 파일은 모든 컴포넌트에 대해 동일한 스키마를 사용합니다. 하지만 서로 다른 스키마를 사용하도록 Ant 파일을 수정할 수 있습니다.

* 관리 서비스 및 라이브 업데이트 서비스는 Ant 태스크를 사용하여 별도로 설치할 수 없으므로 이들에 대해서는 동일한 사용자
* 런타임에 대해서는 다른 스키마
* 푸시 서비스에 대해서는 다른 스키마

#### 수동 설치
{: #manual-installation-1 }
각 {{ site.data.keys.mf_server }} 컴포넌트에 대해 다른 데이터 소스를 지정할 수 있으므로 다른 스키마를 지정할 수 있습니다.  
테이블을 작성하는 스크립트는 다음과 같습니다.

* 관리 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql**에서
* 라이브 업데이트 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-db2.sql**에서
* 런타임 컴포넌트의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-db2.sql**에서
* 푸시 서비스의 경우 **mfp\_install\_dir/PushService/databases/create-push-db2.sql**에서

다음 프로시저에서는 동일한 스키마(MFPSCM)에서 모든 애플리케이션에 대한 테이블을 작성합니다. 여기서는 데이터베이스 및 사용자가 이미 작성되었다고 가정합니다. 자세한 정보는 [DB2 데이터베이스 및 사용자 요구사항](#db2-database-and-user-requirements)을 참조하십시오.

사용자(mfpuser)를 사용하여 다음 명령으로 DB2를 실행하십시오.

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-db2.sql
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf mfp_install_dir/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf mfp_install_dir/PushService/databases/create-push-db2.sql -t
```

테이블이 mfpuser에 의해 작성되는 경우 이 사용자는 자동으로 테이블에 대한 권한을 가지며 런타임 시 해당 권한을 사용할 수 있습니다. [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명된 대로 런타임 사용자의 권한을 제한하거나 권한을 더 세부적으로 제어하려면 DB2 문서를 참조하십시오.

### 수동으로 Oracle 데이터베이스 테이블 작성
{: #creating-the-oracle-database-tables-manually }
{{ site.data.keys.mf_server }} 설치에 제공되는 SQL 스크립트를 사용하여 Oracle 데이터베이스 테이블을 작성하십시오.

개요 절에 설명된 대로 네 개의 {{ site.data.keys.mf_server }} 컴포넌트 모두에 테이블이 필요합니다. 이들은 동일한 스키마 또는 서로 다른 스키마에서 작성될 수 있습니다. 하지만 {{ site.data.keys.mf_server }} 애플리케이션이 Java 애플리케이션 서버에 배치되는 방식에 따라 일부 제한조건이 적용됩니다. 세부사항은 [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명되어 있습니다.

테이블은 런타임 사용자의 기본 스키마에서 작성되어야 합니다. 테이블을 작성하는 스크립트는 다음과 같습니다.

* 관리 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql**에서
* 라이브 업데이트 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-oracle.sql**에서
* 런타임 컴포넌트의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-oracle.sql**에서
* 푸시 서비스의 경우 **mfp\_install\_dir/PushService/databases/create-push-oracle.sql**에서

다음 프로시저에서는 동일한 사용자(**MFPUSER**)에 대해 모든 애플리케이션에 대한 테이블을 작성합니다. 여기서는 데이터베이스 및 사용자가 이미 작성되었다고 가정합니다. 자세한 정보는 [Oracle 데이터베이스 및 사용자 요구사항](#oracle-database-and-user-requirements)을 참조하십시오.

Oracle SQLPlus에서 다음 명령을 실행하십시오.

```sql
CONNECT MFPUSER/MFPUSER_password@ORCL
@mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-configservice-oracle.sql
@mfp_install_dir/MobileFirstServer/databases/create-runtime-oracle.sql
@mfp_install_dir/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

테이블이 MFPUSER에 의해 작성되는 경우 이 사용자는 자동으로 테이블에 대한 권한을 가지며 런타임 시 해당 권한을 사용할 수 있습니다. 테이블은 사용자의 기본 스키마에서 작성됩니다. [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명된 대로 런타임 사용자의 권한을 제한하거나 권한을 더 세부적으로 제어하려면 Oracle 문서를 참조하십시오.

### 수동으로 MySQL 데이터베이스 테이블 작성
{: #creating-the-mysql-database-tables-manually }
{{ site.data.keys.mf_server }} 설치에 제공되는 SQL 스크립트를 사용하여 MySQL 데이터베이스 테이블을 작성하십시오.

개요 절에 설명된 대로 네 개의 {{ site.data.keys.mf_server }} 컴포넌트 모두에 테이블이 필요합니다. 이들은 동일한 스키마 또는 서로 다른 스키마에서 작성될 수 있습니다. 하지만 {{ site.data.keys.mf_server }} 애플리케이션이 Java 애플리케이션 서버에 배치되는 방식에 따라 일부 제한조건이 적용됩니다. 이는 [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명된 대로 MySQL의 가능한 사용자에 대한 주제와 비슷합니다.

#### Server Configuration Tool을 사용한 설치
{: #installation-with-the-server-configuration-tool-2 }
모든 컴포넌트({{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.product }} 런타임)에 대해 동일한 데이터베이스가 사용됩니다.

#### Ant 태스크를 사용한 설치
{: #installation-with-ant-tasks-2 }
제품 배포에 제공되는 샘플 Ant 파일은 모든 컴포넌트에 대해 동일한 데이터베이스를 사용합니다. 하지만 다른 데이터베이스를 사용하도록 Ant 파일을 수정할 수 있습니다.

* 관리 서비스 및 라이브 업데이트 서비스는 Ant 태스크를 사용하여 별도로 설치할 수 없으므로 이들에 대해서는 동일한 데이터베이스
* 런타임에 대해서는 다른 데이터베이스
* 푸시 서비스에 대해서는 다른 데이터베이스

#### 수동 설치
{: #manual-installation-2 }
각 {{ site.data.keys.mf_server }} 컴포넌트에 다른 데이터 소스를 지정할 수 있으므로 다른 데이터베이스를 지정할 수 있습니다.  
테이블을 작성하는 스크립트는 다음과 같습니다.

* 관리 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql**에서
* 라이브 업데이트 서비스의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-configservice-mysql.sql**에서
* 런타임 컴포넌트의 경우 **mfp\_install\_dir/MobileFirstServer/databases/create-runtime-mysql.sql**에서
* 푸시 서비스의 경우 **mfp\_install\_dir/PushService/databases/create-push-mysql.sql**에서

다음 예에서는 동일한 사용자 및 데이터베이스에 대해 모든 애플리케이션에 대한 테이블을 작성합니다. 여기서는 [MySQL용 데이터베이스에 대한 요구사항](#database-requirements)의 경우와 마찬가지로 데이터베이스 및 사용자가 작성되었다고 가정합니다.

다음 프로시저에서는 동일한 사용자(mfpuser) 및 데이터베이스(MFPDATA)에 대해 모든 애플리케이션에 대한 테이블을 작성합니다. 여기서는 데이터베이스 및 사용자가 이미 작성되었다고 가정합니다.

1. `-u mfpuser` 옵션을 사용하여 MySQL 명령행 클라이언트를 실행하십시오.
2. 다음과 같은 명령을 입력하십시오.

```sql
USE MFPDATA;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE mfp_install_dir/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE mfp_install_dir/PushService/databases/create-push-mysql.sql;
```

## Server Configuration Tool을 사용하여 데이터베이스 테이블 작성
{: #create-the-database-tables-with-the-server-configuration-tool }
{{ site.data.keys.mf_server }} 애플리케이션에 대한 데이터베이스 테이블은 Ant 태스크 또는 Server Configuration Tool을 사용하여 수동으로 작성될 수 있습니다. 이 주제에서는 Server Configuration Tool을 사용하여 {{ site.data.keys.mf_server }}를 설치할 때 데이터베이스 설정에 대한 설명 및 세부사항을 제공합니다.

Server Configuration Tool은 설치 프로세스의 일부로 데이터베이스 테이블을 작성할 수 있습니다. 일부 경우에는 {{ site.data.keys.mf_server }} 컴포넌트에 대한 데이터베이스 및 사용자도 작성할 수 있습니다. Server Configuration Tool을 사용한 설치 프로세스에 대한 개요는 [그래픽 모드에서 {{ site.data.keys.mf_server }} 설치](../tutorials/graphical-mode)를 참조하십시오.

구성 신임 정보를 완료하고 Server Configuration Tool 분할창에서 **배치**를 클릭하면 다음과 같은 조작이 실행됩니다.

* 필요한 경우 데이터베이스 및 사용자를 작성합니다.
* {{ site.data.keys.mf_server }} 테이블이 데이터베이스에 있는지 여부를 확인합니다. 해당 테이블이 없는 경우에는 해당 테이블을 작성합니다.
* {{ site.data.keys.mf_server }} 애플리케이션을 애플리케이션 서버에 배치합니다.

Server Configuration Tool을 실행하기 전에 수동으로 데이터베이스 테이블이 작성되는 경우 이 도구는 해당 테이블을 발견하고 테이블 설정 단계(Phase)를 건너뛸 수 있습니다.

선택한 지원되는 DBMS(Database Management System)에 따라 도구가 데이터베이스 테이블을 작성하는 방법에 대한 자세한 내용과 관련된 다음 주제 중 하나를 선택하십시오.

* [Server Configuration Tool을 사용하여 DB2 데이터베이스 테이블 작성](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Server Configuration Tool을 사용하여 Oracle 데이터베이스 테이블 작성](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [Server Configuration Tool을 사용하여 MySQL 데이터베이스 테이블 작성](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### Server Configuration Tool을 사용하여 DB2 데이터베이스 테이블 작성
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Server Configuration Tool을 사용하여 DB2 데이터베이스 테이블을 작성하십시오.

Server Configuration Tool은 기본 DB2 인스턴스에서 데이터베이스를 작성할 수 있습니다. Server Configuration Tool의 **데이터베이스 선택** 패널에서 IBM DB2 옵션을 선택하십시오. 다음 세 분할창에서 데이터베이스 신임 정보를 입력하십시오. **데이터베이스 추가 설정** 분할창에서 입력되는 데이터베이스 이름이 DB2 인스턴스에 없는 경우에는 추가 정보를 입력하여 도구가 사용자를 위해 데이터베이스를 작성하게 할 수 있습니다.

Server Configuration Tool은 다음 SQL문을 사용하여 기본 설정으로 데이터베이스 테이블을 작성합니다.
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

기본 DB2 설치에서는 많은 권한이 PUBLIC에 부여되므로 프로덕션용으로 사용하기에는 적합하지 않습니다.

### Server Configuration Tool을 사용하여 Oracle 데이터베이스 테이블 작성
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Server Configuration Tool을 사용하여 Oracle 데이터베이스 테이블을 작성하십시오.

Server Configuration Tool의 데이터베이스 선택 패널에서 **Oracle Standard 또는 Enterprise Edition, 11g 또는 12c** 옵션을 선택하십시오. 다음 세 분할창에서 데이터베이스 신임 정보를 입력하십시오.

**데이터베이스 추가 설정** 패널에서 Oracle 사용자 이름을 입력할 때 해당 이름은 대문자여야 합니다. Oracle 데이터베이스 사용자(FOO)가 있을 때 소문자로 된 사용자 이름(foo)을 입력하면 Server Configuration Tool은 이를 다른 사용자로 간주합니다. Oracle 데이터베이스에 대한 기타 도구와 달리 Server Configuration Tool은 사용자 이름이 자동으로 대문자로 변환되지 않도록 보호합니다.

Server Configuration Tool은 서비스 이름 또는 Oracle 시스템 ID(SID)를 사용하여 데이터베이스를 식별합니다. 하지만 Oracle RAC에 연결하려면 복합 JDBC URL을 입력해야 합니다. 이 경우 **데이터베이스 설정** 패널에서 **일반 Oracle JDBC URL을 사용하여 연결** 옵션을 선택한 후 Oracle 씬 드라이버의 URL을 입력하십시오.

Oracle에 대한 데이터베이스 및 사용자를 작성해야 하는 경우 Oracle DBCA(Database Creation Assistant) 도구를 사용하십시오. 자세한 정보는 [Oracle 데이터베이스 및 사용자 요구사항](#oracle-database-and-user-requirements)을 참조하십시오.

Server Configuration Tool도 동일한 작업을 수행할 수 있지만 제한사항이 있습니다. 이 도구는 Oracle 11g 또는 Oracle 12g에 대한 사용자를 작성할 수 있습니다. 하지만 Oracle 11g에 대한 데이터베이스만 작성할 수 있고 Oracle 12c에 대한 데이터베이스는 작성할 수 없습니다.

**데이터베이스 추가 설정** 패널에서 입력하는 데이터베이스 이름 또는 사용자 이름이 없는 경우에는 데이터베이스 또는 사용자를 작성하는 데 필요한 추가 단계에 대한 다음 두 절을 참조하십시오.

#### 데이터베이스 작성
{: #creating-the-database }

1. Oracle 데이터베이스를 실행하는 컴퓨터에서 SSH 서버를 실행하십시오.

    Server Configuration Tool은 Oracle 호스트에 대한 SSH 세션을 열어 데이터베이스를 작성합니다. Linux 및 일부 UNIX 시스템 버전을 제외하고 Oracle 데이터베이스가 Server Configuration Tool과 동일한 컴퓨터에서 실행되는 경우에도 SSH 서버가 필요합니다.

2. **데이터베이스 작성 요청** 패널에서 데이터베이스를 작성할 수 있는 권한을 가진 Oracle 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오.
3. 동일한 패널에서 작성될 데이터베이스의 **SYS** 사용자 및 **SYSTEM** 사용자에 대한 비밀번호도 입력하십시오.

**데이터베이스 추가 설정** 패널에서 입력하는 SID 이름을 사용하여 데이터베이스가 작성됩니다. 이는 프로덕션용으로는 적합하지 않습니다.

#### 사용자 작성
{: #creating-the-user }

1. Oracle 데이터베이스를 실행하는 컴퓨터에서 SSH 서버를 실행하십시오.

    Server Configuration Tool은 Oracle 호스트에 대한 SSH 세션을 열어 데이터베이스를 작성합니다. Linux 및 일부 UNIX 시스템 버전을 제외하고 Oracle 데이터베이스가 Server Configuration Tool과 동일한 컴퓨터에서 실행되는 경우에도 SSH 서버가 필요합니다.

2. **데이터베이스 추가 설정** 패널에서 작성될 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오.
3. **데이터베이스 작성 요청** 패널에서 데이터베이스 사용자를 작성할 수 있는 권한을 가진 Oracle 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오.
4. 동일한 패널에서 데이터베이스의 **SYSTEM** 사용자에 대한 비밀번호도 입력하십시오.

### Server Configuration Tool을 사용하여 MySQL 데이터베이스 테이블 작성
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Server Configuration Tool을 사용하여 MySQL 데이터베이스 테이블을 작성하십시오.

Server Configuration Tool은 사용자를 위해 MySQL 데이터베이스를 작성할 수 있습니다. Server Configuration Tool의 **데이터베이스 선택** 패널에서 **MySQL 5.5.x, 5.6.x 또는 5.7.x** 옵션을 선택하십시오. 다음 세 분할창에서 데이터베이스 신임 정보를 입력하십시오. 데이터베이스 추가 설정 패널에서 입력하는 사용자 또는 데이터베이스가 없으면 도구가 이를 작성할 수 있습니다.

MySQL 서버가 [MySQL 데이터베이스 및 사용자 요구사항](#mysql-database-and-user-requirements)에서 권장되는 설정을 가지고 있지 않으면 Server Configuration Tool에 경고가 표시됩니다. Server Configuration Tool을 실행하기 전에 요구사항을 이행했는지 확인하십시오.

다음 프로시저에서는 도구를 사용하여 데이터베이스 테이블을 작성할 때 수행해야 하는 일부 추가 단계를 제공합니다.

1. **데이터베이스 추가 설정** 패널의 연결 설정 옆에서 사용자가 데이터베이스에 연결할 수 있는 모든 호스트를 입력해야 합니다. 즉, {{ site.data.keys.mf_server }}가 실행되는 모든 호스트입니다.
2. **데이터베이스 작성 요청** 패널에서 MySQL 관리자의 로그인 ID 및 비밀번호를 입력하십시오. 기본적으로 관리자는 root입니다.

## Ant 태스크를 사용하여 데이터베이스 테이블 작성
{: #create-the-database-tables-with-ant-tasks }
{{ site.data.keys.mf_server }} 애플리케이션에 대한 데이터베이스 테이블은 Ant 태스크 또는 Server Configuration Tool을 사용하여 수동으로 작성될 수 있습니다. 이 주제에서는 Ant 태스크를 사용하여 해당 테이블을 작성하는 방법에 대한 설명 및 세부사항을 제공합니다.

{{ site.data.keys.mf_server }}가 Ant 태스크를 사용하여 설치된 경우 이 절에서 데이터베이스의 설정에 대한 관련 정보를 찾을 수 있습니다.

Ant 태스크를 사용하여 {{ site.data.keys.mf_server }} 데이터베이스 테이블을 설정할 수 있습니다. 일부 경우에는 이 태스크를 사용하여 데이터베이스 및 사용자도 작성할 수 있습니다. Ant 태스크를 사용한 설치 프로세스에 대한 개요는 [명령행 모드에서 {{ site.data.keys.mf_server }} 설치](../tutorials/command-line)를 참조하십시오.

Ant 태스크를 시작하는 데 도움이 되는 샘플 Ant 파일 세트가 설치와 함께 제공됩니다. **mfp\_install\_dir/MobileFirstServer/configurations-samples**에서 해당 파일을 찾을 수 있습니다. 해당 파일은 다음과 같은 패턴을 따라 이름이 지정됩니다.

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Ant 파일은 다음과 같은 태스크를 수행할 수 있습니다.

* 데이터베이스 및 데이터베이스 사용자가 있는 경우 데이터베이스에서 테이블을 작성합니다. 데이터베이스에 대한 요구사항이 [데이터베이스 요구사항](#database-requirements)에 나열됩니다.
* {{ site.data.keys.mf_server }} 컴포넌트의 WAR 파일을 애플리케이션 서버에 배치합니다. 이 Ant 파일은 동일한 데이터베이스 사용자를 사용하여 테이블을 작성하고 런타임 시 애플리케이션에 대한 런타임 데이터베이스 사용자를 설치합니다. 또한 이 파일은 모든 {{ site.data.keys.mf_server }} 애플리케이션에 대해 동일한 데이터베이스 사용자를 사용합니다.

#### create-database-dbms.xml
{: #create-database-dbmsxml }
Ant 파일은 지원되는 데이터베이스 관리 시스템(DBMS)에 필요한 경우 데이터베이스를 작성한 후 데이터베이스에서 테이블을 작성할 수 있습니다. 하지만 데이터베이스는 기본 설정으로 작성되므로 프로덕션용으로 적합하지 않습니다.

Ant 파일에서 **configureDatabase** Ant 태스크를 사용하여 데이터베이스를 설정하는 사전 정의된 대상을 찾을 수 있습니다. 자세한 정보는 [Ant configuredatabase](../installation-reference/#ant-configuredatabase-task-reference) 태스크 참조를 참조하십시오.

### 샘플 Ant 파일 사용
{: #using-the-sample-ant-files }
샘플 Ant 파일에는 사전 정의된 대상이 있습니다. 다음 프로시저에 따라 해당 파일을 사용하십시오.

1. 작업 디렉토리에서 애플리케이션 서버 및 데이터베이스 구성에 따라 Ant 파일을 복사하십시오.
2. 파일을 편집하고 Ant 파일에 대한 `<! -- Start of Property Parameters -->` 섹션에서 구성의 값을 입력하십시오.
3. 데이터베이스 대상을 사용하여 Ant 파일을 실행하십시오. `mfp_install_dir/shortcuts/ant -f your_ant_file databases`.

이 명령은 모든 {{ site.data.keys.mf_server }} 애플리케이션({{ site.data.keys.mf_server }} 관리 서비스, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스, {{ site.data.keys.mf_server }} 푸시 서비스 및 {{ site.data.keys.mf_server }} 런타임)에 대해 지정된 데이터베이스 및 스키마에서 테이블을 작성합니다. 조작에 대한 로그가 생성되어 디스크에 저장됩니다.

* Windows의 경우에는 **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\** 디렉토리에 있습니다.
* UNIX의 경우에는 **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/** 디렉토리에 있습니다.

### 데이터베이스 테이블 작성 및 런타임에 대해 다른 사용자
{: #different-users-for-the-database-tables-creation-and-for-run-time }
**mfp\_install\_dir/MobileFirstServer/configurations-samples**에 있는 샘플 Ant 파일은 다음에 대해 동일한 데이터베이스 사용자를 사용합니다.

* 모든 {{ site.data.keys.mf_server }} 애플리케이션(관리 서비스, 라이브 업데이트 서비스, 푸시 서비스 및 런타임)
* 애플리케이션 서버의 데이터 소스에 대해 런타임 시 사용자 및 데이터베이스를 작성하는 데 사용되는 사용자

[데이터베이스 사용자 및 권한](#database-users-and-privileges)에 설명된 대로 사용자를 구분하려면 자체 Ant 파일을 작성해야 하거나 각 데이터베이스 대상이 다른 사용자를 가지도록 샘플 Ant 파일을 수정해야 합니다. 자세한 정보는 [설치 참조](../installation-reference)를 참조하십시오.

DB2 및 MySQL의 경우 데이터베이스 작성과 런타임에 대해 서로 다른 사용자를 가질 수 있습니다. 각 유형의 사용자에 대한 권한이 [데이터베이스 사용자 및 권한](#database-users-and-privileges)에 나열되어 있습니다. Oracle의 경우에는 데이터베이스 작성과 런타임에 대해 서로 다른 사용자를 사용할 수 없습니다. Ant 태스크에서는 테이블이 사용자의 기본 스키마에 있다고 간주합니다. 런타임 사용자에 대한 권한을 줄이려면 런타임 시 사용될 사용자의 기본 스키마에서 수동으로 테이블을 작성해야 합니다. 자세한 정보는 [수동으로 Oracle 데이터베이스 테이블 작성](#creating-the-oracle-database-tables-manually)을 참조하십시오.

선택한 지원되는 데이터베이스 관리 시스템(DBMS)에 따라 다음 주제 중 하나를 선택하여 Ant 태스크를 사용하여 데이터베이스를 작성하십시오.

### Ant 태스크를 사용하여 DB2 데이터베이스 테이블 작성
{: #creating-the-db2-database-tables-with-ant-tasks }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Ant 태스크를 사용하여 DB2 데이터베이스를 작성하십시오.

이미 있는 데이터베이스에서 데이터베이스 테이블을 작성하려면 [Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)을 참조하십시오.

데이터베이스 및 데이터베이스 테이블을 작성하려면 Ant 태스크를 사용하여 작성할 수 있습니다. **dba** 요소가 포함된 Ant 파일을 사용하는 경우 Ant 태스크는 DB2의 기본 인스턴스에서 데이터베이스를 작성합니다. 이 요소는 **create-database-<dbms>.xml**이라는 샘플 Ant 파일에서 찾을 수 있습니다.

Ant 태스크를 실행하기 전에 DB2 데이터베이스를 실행하는 컴퓨터에 SSH 서버가 있는지 확인하십시오. **configureDatabase** Ant 태스크는 DB2 호스트에 대한 SSH 세션을 열어 데이터베이스를 작성합니다. Ant 태스크를 실행하는 컴퓨터와 동일한 컴퓨터에서 DB2 데이터베이스가 실행되는 경우에도 SSH 서버가 필요합니다(Linux 및 일부 UNIX 시스템 버전의 경우는 제외).

[Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)에 설명된 대로 일반 가이드라인을 따라 **create-database-db2.xml** 파일의 사본을 편집하십시오.

**dba** 요소에 관리 권한(**SYSADM** 또는 **SYSCTRL** 권한)을 가진 DB2 사용자의 로그인 ID 및 비밀번호도 제공해야 합니다. DB2용 샘플 Ant 파일(**create-database-db2.xml**)에서 설정할 특성은 **database.db2.admin.username** 및 **database.db2.admin.password**입니다.

**databases** Ant 대상이 호출되면 **configureDatabase** Ant 태스크가 다음 SQL문을 사용하여 기본 설정으로 데이터베이스를 작성합니다.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

기본 DB2 설치에서는 많은 권한이 PUBLIC에 부여되므로 프로덕션용으로 사용하기에는 적합하지 않습니다.

### Ant 태스크를 사용하여 Oracle 데이터베이스 테이블 작성
{: #creating-the-oracle-database-tables-with-ant-tasks }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Ant 태스크를 사용하여 Oracle 데이터베이스 테이블을 작성하십시오.

Ant 파일에서 Oracle 사용자 이름을 입력할 때 해당 이름은 대문자여야 합니다. Oracle 데이터베이스 사용자(FOO)가 있을 때 소문자로 된 사용자 이름(foo)을 입력하면 **configureDatabase** Ant 태스크는 이를 다른 사용자로 간주합니다. Oracle 데이터베이스에 대한 기타 도구와 달리 **configureDatabase** Ant 태스크는 사용자 이름이 자동으로 대문자로 변환되지 않도록 보호합니다.

**configureDatabase** Ant 태스크는 서비스 이름 또는 Oracle 시스템 ID(SID)를 사용하여 데이터베이스를 식별합니다. 하지만 Oracle RAC에 연결하려면 복합 JDBC URL을 입력해야 합니다. 이 경우 **configureDatabase** Ant 태스크에 있는 **oracle** 요소는 **database**, **server**, **port**, **user** 및 **password** 속성 대신 **url**, **user** 및 **password** 속성을 사용해야 합니다. 자세한 정보는 [Ant **configuredatabase** 태스크 참조](../installation-reference/#ant-configuredatabase-task-reference)에 있는 테이블을 참조하십시오. **mfp\_install\_dir/MobileFirstServer/configurations-samples**에 있는 샘플 Ant 파일은 **oracle** 요소에서 **database**, **server**, **port**, **user** 및 **password** 속성을 사용합니다. JDBC URL을 사용하여 Oracle에 연결해야 하는 경우에는 이를 수정해야 합니다.

이미 있는 데이터베이스에서 데이터베이스 테이블을 작성하려면 [Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)을 참조하십시오.

데이터베이스, 사용자 또는 데이터베이스 테이블을 작성하려면 Oracle DBCA(Database Creation Assistant) 도구를 사용하십시오. 자세한 정보는 [Oracle 데이터베이스 및 사용자 요구사항](#oracle-database-and-user-requirements)을 참조하십시오.

**configureDatabase** Ant 태스크도 동일한 작업을 수행할 수 있지만 제한사항이 있습니다. 이 태스크는 Oracle 11g 또는 Oracle 12g에 대해 데이터베이스 사용자를 작성할 수 있습니다. 하지만 Oracle 11g에 대한 데이터베이스만 작성할 수 있고 Oracle 12c에 대한 데이터베이스는 작성할 수 없습니다. 데이터베이스 또는 사용자를 작성하기 위해 필요한 추가 단계에 대해서는 다음 두 절을 참조하십시오.

#### 데이터베이스 작성
{: #creating-the-database-1 }
[Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)에 설명된 대로 일반 가이드라인을 따라 **create-database-oracle.xml** 파일의 사본을 편집하십시오.

1. Oracle 데이터베이스를 실행하는 컴퓨터에서 SSH 서버를 실행하십시오.

    **configureDatabase** Ant 태스크는 Oracle 호스트에 대한 SSH 세션을 열어 데이터베이스를 작성합니다. Linux 및 일부 UNIX 시스템 버전의 경우를 제외하고 SSH는 Ant 태스크를 실행하는 동일한 컴퓨터에서 Oracle 데이터베이스가 실행되는 경우에도 필요합니다.

2. **create-database-oracle.xml** 파일에서 정의되는 **dba** 요소에서 SSH를 통해 Oracle 서버에 연결할 수 있고 데이터베이스를 작성할 수 있는 권한을 가진 Oracle 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오. 다음과 같은 특성에서 값을 지정할 수 있습니다.
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. **oracle** 요소에서 작성할 데이터베이스 이름을 입력하십시오. 속성은 **database**입니다. **database.oracle.mfp.dbname** 특성에서 값을 지정할 수 있습니다.
4. 동일한 **oracle** 요소에서 작성될 데이터베이스의 **SYS** 사용자 및 **SYSTEM** 사용자에 대한 비밀번호도 입력하십시오. 속성은 **sysPassword** 및 **systemPassword**입니다. 해당 특성에서 값을 지정할 수 있습니다.
    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Ant 파일에서 모든 데이터베이스 신임 정보를 입력한 후 이를 저장하고 **databases** Ant 대상을 실행하십시오.

**oracle** 요소의 데이터베이스에서 입력되는 SID 이름을 사용하여 데이터베이스가 작성됩니다. 이는 프로덕션용으로는 적합하지 않습니다.

#### 사용자 작성
{: #creating-the-user-1 }
[Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)에 설명된 대로 일반 가이드라인을 따라 **create-database-oracle.xml** 파일의 사본을 편집하십시오.

1. Oracle 데이터베이스를 실행하는 컴퓨터에서 SSH 서버를 실행하십시오.

    **configureDatabase** Ant 태스크는 Oracle 호스트에 대한 SSH 세션을 열어 데이터베이스를 작성합니다. Linux 및 일부 UNIX 시스템 버전의 경우를 제외하고 SSH는 Ant 태스크를 실행하는 동일한 컴퓨터에서 Oracle 데이터베이스가 실행되는 경우에도 필요합니다.

2. **create-database-oracle.xml** 파일에서 정의되는 oracle 요소에서 작성할 Oracle 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오. 속성은 **user** 및 **password**입니다. 해당 특성에서 값을 지정할 수 있습니다.
    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. 동일한 **oracle** 요소에서 데이터베이스의 **SYSTEM** 사용자에 대한 비밀번호도 입력하십시오. 속성은 **systemPassword**입니다. **database.oracle.systemPassword** 특성에서 값을 지정할 수 있습니다.
4. **dba** 요소에서 사용자를 작성할 수 있는 권한을 가진 Oracle 데이터베이스 사용자의 로그인 ID 및 비밀번호를 입력하십시오. 다음과 같은 특성에서 값을 지정할 수 있습니다.
    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Ant 파일에서 모든 데이터베이스 신임 정보를 입력한 후 이를 저장하고 **databases** Ant 대상을 실행하십시오.

**oracle** 요소에서 입력되는 이름 및 비밀번호를 사용하여 데이터베이스 사용자가 작성됩니다. 이 사용자는 {{ site.data.keys.mf_server }} 테이블을 작성한 후 업그레이드하고 런타임 시 사용할 수 있는 권한을 가지고 있습니다.

### Ant 태스크를 사용하여 MySQL 데이터베이스 테이블 작성
{: #creating-the-mysql-database-tables-with-ant-tasks }
{{ site.data.keys.mf_server }} 설치와 함께 제공되는 Ant 태스크를 사용하여 MySQL 데이터베이스 테이블을 작성하십시오.

이미 있는 데이터베이스에서 데이터베이스 테이블을 작성하려면 [Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)을 참조하십시오.

MySQL 서버가 [MySQL 데이터베이스 및 사용자 요구사항](#mysql-database-and-user-requirements)에서 권장되는 설정을 가지고 있지 않으면 **configureDatabase** Ant 태스크가 경고를 표시합니다. Ant 태스크를 실행하기 전에 요구사항을 이행했는지 확인하십시오.

데이터베이스 및 데이터베이스 테이블을 작성하려면 [Ant 태스크를 사용하여 데이터베이스 테이블 작성](#create-the-database-tables-with-ant-tasks)에 설명된 일반 가이드라인을 따라 **create-database-mysql.xml** 파일의 사본을 편집하십시오.

다음 프로시저에서는 **configureDatabase** Ant 태스크를 사용하여 데이터베이스 테이블을 작성할 때 수행해야 하는 일부 추가 단계를 제공합니다.

1. **create-database-mysql.xml** 파일에서 정의되는 **dba** 요소에서 MySQL 관리자의 로그인 ID 및 비밀번호를 입력하십시오. 기본적으로 관리자는 **root**입니다. 다음과 같은 특성에서 값을 지정할 수 있습니다.
    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. **mysql** 요소에서 사용자가 데이터베이스에 연결할 수 있는 각 호스트에 대한 **client** 요소를 추가하십시오. 즉, {{ site.data.keys.mf_server }}가 실행되는 모든 호스트입니다.
Ant 파일에서 모든 데이터베이스 신임 정보를 입력한 후 이를 저장하고 **databases** Ant 대상을 실행하십시오.
