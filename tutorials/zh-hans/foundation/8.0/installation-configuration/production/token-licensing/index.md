---
layout: tutorial
title: 安装并配置令牌许可
breadcrumb_title: 令牌许可
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
如果您计划对 {{ site.data.keys.mf_server }} 使用令牌许可，那么必须安装 Rational Common Licensing 库，并把应用程序服务器配置为将 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server。

以下主题描述了安装概述、如何手动安装 Rational Common Licensing 库、如何配置应用程序服务器，以及令牌许可的平台限制。

#### 跳至：
{: #jump-to }

* [规划使用令牌许可](#planning-for-the-use-of-token-licensing)
* [令牌许可的安装概述](#installation-overview-for-token-licensing)
* [将 Apache Tomcat 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [将 WebSphere Application Server Liberty Profile 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [将 WebSphere Application Server 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [令牌许可所支持平台的限制](#limitations-of-supported-platforms-for-token-licensing)
* [对令牌许可问题进行故障诊断](#troubleshooting-token-licensing-problems)

## 规划使用令牌许可
{: #planning-for-the-use-of-token-licensing }
如果为 {{ site.data.keys.mf_server }} 购买了令牌许可，那么在规划安装时应考虑额外的步骤。

### 技术限制
{: #technical-restrictions }
下面是使用令牌许可时的技术限制：

#### 受支持的平台：
{: #supported-platforms }
[令牌许可的支持平台限制](#limitations-of-supported-platforms-for-token-licensing)中列出了支持令牌许可的平台列表。 在未列出的平台上运行的 {{ site.data.keys.mf_server }} 可能无法安装和配置令牌许可。 Rational Common Licensing 客户机的本机库可能不可用于该平台或者不受支持。

#### 受支持的拓扑：
{: #supported-topologies }
[{{ site.data.keys.mf_server }}管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product_adj }} 运行时的约束](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)上列出了令牌许可支持的拓扑。

### 网络需求
{: #network-requirement }
{{ site.data.keys.mf_server }} 必须能够与 Rational License Key Server 进行通信。

需要能够访问许可证服务器的以下两个端口，才能进行该通信：

* 许可证管理器守护程序 (**lmgrd**) 端口 - 缺省端口号为 27000。
* 供应商守护程序 (**ibmratl**) 端口
 
要配置这些端口以使其使用静态值，请参阅“如何穿过防火墙向客户端机器提供许可证密钥”。

### 安装过程
{: #installation-process }
在安装过程中运行 IBM Installation Manager 时，必须激活令牌许可。 有关用于启用令牌许可的指示信息的更多信息，请参阅[令牌许可的安装概述](#installation-overview-for-token-licensing)。

安装 {{ site.data.keys.mf_server }} 后，您必须为服务器手动配置令牌许可。 有关更多信息，请参阅此部分中的以下主题。

在完成此手动配置之前，{{ site.data.keys.mf_server }} 无法正常运行。 Rational Common Licensing 客户机库将安装在应用程序服务器中，并且由您定义 Rational License Key Server 的位置。

### 操作
{: #operations }
在安装和配置 {{ site.data.keys.mf_server }} 以用于令牌许可后，服务器将在各个场景期间验证许可证。 有关在操作期间检索令牌的更多信息，请参阅[令牌许可证验证](../../../administering-apps/license-tracking/#token-license-validation)。

如果需要在启用了令牌许可的生产服务器上测试非生产应用程序，那么可以将应用程序声明为非生产应用程序。 有关声明应用程序类型的更多信息，请参阅[设置应用程序许可证信息](../../../administering-apps/license-tracking/#setting-the-application-license-information)。

## 令牌许可的安装概述
{: #installation-overview-for-token-licensing }
如果您打算对 {{ site.data.keys.product }} 使用令牌许可，请确保按下列顺序完成以下准备步骤。

> **要点：**在执行支持令牌许可的安装期间，您针对令牌许可（是否激活）所做的选择将无法修改。 如果您稍后需要更改令牌许可选项，那么必须卸载并重新安装 {{ site.data.keys.product }}。

1. 在运行 IBM Installation Manager 来安装 {{ site.data.keys.product }} 时，激活令牌许可。

   #### 图形方式安装
   如果以图形方式安装产品，请在安装期间选择**常规设置**面板中的**使用 Rational License Key Server 激活令牌许可**选项。
    
   ![在 IBM Installation Manager 中激活令牌许可](licensing_with_tokens_activate.jpg)
    
   #### 命令行方式安装
   如果采用静默方式进行安装，请将响应文件中 **user.licensed.by.tokens** 参数的值设置为 **true**。  
   例如，您可以：
    
   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
   ```
    
2. 在产品安装完成后，将 {{ site.data.keys.mf_server }} 部署至应用程序服务器。 有关更多信息，请参阅[将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](../appserver)。

3. 为 {{ site.data.keys.mf_server }} 配置令牌许可。 步骤取决于应用程序服务器。

* 对于 WebSphere Application Server Liberty Profile，请参阅[将 WebSphere Application Server Liberty Profile 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* 对于 Apache Tomcat，请参阅[将 Apache Tomcat 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* 对于 WebSphere Application Server Full Profile，请参阅[将 WebSphere Application Server 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)。

## 将 Apache Tomcat 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
在将 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server 之前，必须先在 Apache Tomcat 应用程序服务器上安装 Rational Common Licensing 本机库和 Java 库。

* 必须已安装并配置 Rational License Key Server 8.1.4.8 或更高版本。 网络必须允许与 {{ site.data.keys.mf_server }} 进行通信，方法是打开双向通信端口（**lmrgd** 和 **ibmratl**）。 有关更多信息，请参阅 [Rational License Key Server 门户网站](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295)和[如何穿过防火墙向客户端机器提供许可证密钥](http://www.ibm.com/support/docview.wss?uid=swg21257370)。
* 确保生成 {{ site.data.keys.product }} 的许可证密钥。 有关使用 IBM Rational License Key Center 生成和管理许可证密钥的更多信息，请参阅 [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) 以及[通过 IBM Rational License Key Center 获取许可证密钥](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)。
* 必须按照[令牌许可的安装概述](#installation-overview-for-token-licensing)中所述，在 Apache
Tomcat 上使用“通过 Rational License Key Server 激活令牌许可”选项来安装和配置 {{ site.data.keys.mf_server }}。

### 安装 Rational Common Licensing 库
{: #installing-rational-common-licensing-libraries }

1. 选择 Rational Common Licensing 本机库。 根据运行 Apache Tomcat 的 Java 运行时环境 (JRE) 的操作系统和位版本，必须在 **product\_install\_dir/MobileFirstServer/tokenLibs/bin/your\_corresponding\_platform/the\_native\_library\_file** 中选择正确的本机库。 例如，对于具有 64 位 JRE 的 Linux x86，该库位于 **product\_install\_dir/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so** 中。
2. 将本机库复制到运行 {{ site.data.keys.mf_server }} 管理服务的计算机上。 该目录可能是 **${CATALINA_HOME}/bin**。 
    > **注：****${CATALINA_HOME}** 是 Apache Tomcat 的安装目录。
3. 将 **rcl_ibmratl.jar** 文件复制到 **${CATALINA_HOME}/lib** 中。 **rcl_ibmratl.jar** 文件是 Rational Common Licensing Java 库，位于 **product\_install\_dir/MobileFirstServer/tokenLibs** 目录中。 该库使用步骤 2 中复制的本机库，并且只能供 Apache Tomcat 装入一次。 必须将该文件放在 **${CATALINA_HOME}/lib** 目录中或 Apache Tomcat 公共类装入器路径中的任何目录中。
    > **要点：**Apache Tomcat 的 Java 虚拟机 (JVM) 需要具有已复制的本机库和 Java 库的读和执行权限。 在您的操作系统中，至少应用程序服务器进程还必须具有这两个已复制文件的读和执行权限。
4. 通过应用程序服务器的 JVM 来配置对 Rational Common Licensing 库的访问权。 对于任何操作系统，通过添加以下行来配置 **${CATALINA_HOME}/bin/setenv.bat** 文件（或 UNIX 上的 **setenv.sh** 文件）：

   **Windows：**  
    
   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absolute_path_to_the_previous_bin_directory
   ```
    
   **UNIX：**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absolute_path_to_the_previous_bin_directory"
   ```
    
   > **注：**如果您移动了运行管理服务的服务器的配置文件夹，必须使用新的绝对路径来更新 **java.library.path**。

5. 配置 {{ site.data.keys.mf_server }} 以访问 Rational License Key Server。 在 **${CATALINA_HOME}/conf/server.xml** 文件中，查找管理服务应用程序的 `Context` 元素，并添加以下 JNDI 配置行。

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="rlks_hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="rlks_port" type="java.lang.String" override="false"/>
   ```
   * **rlks_hostname** 是 Rational License Key Server 的主机名。
   * **rlks_port** 是 Rational License Key Server 的端口。 缺省情况下，该值为 **27000**。

有关 JNDI 属性的更多信息，请参阅[管理服务的 JNDI 属性：许可](../server-configuration/#jndi-properties-for-administration-service-licensing)。

### 安装在 Apache Tomcat 服务器场上
{: #installing-on-apache-tomcat-server-farm }
要配置 Apache Tomcat 服务器场上的 {{ site.data.keys.mf_server }} 连接，必须针对运行 {{ site.data.keys.mf_server }} 管理服务的服务器场中的每个节点，完成[安装 Rational Common Licensing 库](#installing-rational-common-licensing-libraries)中描述的所有步骤。 有关服务器场的更多信息，请参阅[服务器场拓扑](../topologies/#server-farm-topology)和[安装服务器场](../appserver/#installing-a-server-farm)。

## 将 WebSphere Application Server Liberty Profile 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
在将 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server 之前，必须先在 Liberty Profile 上安装 Rational Common Licensing 本机库和 Java 库。

* 必须已安装并配置 Rational License Key Server 8.1.4.8 或更高版本。 网络必须允许与 {{ site.data.keys.mf_server }} 进行通信，方法是打开双向通信端口（**lmrgd** 和 **ibmratl**）。 有关更多信息，请参阅 [Rational License Key Server 门户网站](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295)和[如何穿过防火墙向客户端机器提供许可证密钥](http://www.ibm.com/support/docview.wss?uid=swg21257370)。
* 确保生成 {{ site.data.keys.product }} 的许可证密钥。 有关使用 IBM Rational License Key Center 生成和管理许可证密钥的更多信息，请参阅 [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) 以及[通过 IBM Rational License Key Center 获取许可证密钥](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)。
* 必须按照[令牌许可的安装概述](#installation-overview-for-token-licensing)中所述，在 Apache
Tomcat 上使用“通过 Rational License Key Server 激活令牌许可”选项来安装和配置 {{ site.data.keys.mf_server }}。

### 安装 Rational Common Licensing 库
{: #common-licensing-libraries-liberty }

1. 为 Rational Common Licensing 客户机定义共享库。 该库使用本机代码并且只可供应用程序服务器装入一次。 因此，使用该库的应用程序必须将其作为公共库进行引用。
   * 选择 Rational Common Licensing 本机库。 根据运行 Liberty Profile 的 Java 运行时环境 (JRE) 的操作系统和位版本，必须在 **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file** 中选择正确的本机库。 例如，对于具有 64 位 JRE 的 Linux x86，该库位于 **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so** 中。
   * 将本机库复制到运行 {{ site.data.keys.mf_server }} 管理服务的计算机上。 该目录可能是 **${shared.resource.dir}/rcllib**。 **${shared.resource.dir}** 目录通常位于 **usr/shared/resources** 中，其中 usr 是同时还包含 usr/servers 目录的目录。 有关 **${shared.resource.dir}** 的标准位置的更多信息，请参阅 [WebSphere Application Server Liberty Core - 目录位置和属性](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=en&view=kc)。 如果 **rcllib** 文件夹不存在，请创建此文件夹，然后将本机库文件复制到其中。
    
   > **注：**确保应用程序服务器的 Java 虚拟机 (JVM) 具有本机库的读和执行权限。 在 Windows 上，如果应用程序服务器的 JVM 不具有已复制本机库的执行权限，那么应用程序服务器日志中会出现以下异常。
    
   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * 将 **rcl_ibmratl.jar** 文件复制到 **${shared.resource.dir}/rcllib** 中。 **rcl_ibmratl.jar** 文件是 Rational Common Licensing Java 库，位于 **product_install_dir/MobileFirstServer/tokenLibs** 目录中。

   > **注：**Liberty Profile 的 Java 虚拟机 (JVM) 必须能够读取所复制的 Java 库。 在您的操作系统中，至少应用程序服务器进程还必须具有该文件的读权限。    
   * 在 **${server.config.dir}/server.xml** 文件中，声明使用 **rcl_ibmratl.jar** 文件的共享库。

   ```xml
   <!-- Declare a shared Library for the RCL client. -->
   <!- This library can be loaded only once because it uses native code. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * 通过向应用程序类装入器添加属性 **commonLibraryRef**，将该共享库声明为 {{ site.data.keys.mf_server }} 管理服务应用程序的公共库。 由于库只能装入一次，因此它必须用作公共库，而不能用作私有库。

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
      [...]
      <!- Declare the shared library as an attribute commonLibraryRef to 
          the class loader of the application. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * 如果使用 Oracle 作为数据库，那么 **server.xml** 已具有以下类装入器：

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```
    
   您还需要将 Rational Common Licensing 库作为公共库附加到 Oracle 库中，如下所示：
    
   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * 通过应用程序服务器的 JVM 来配置对 Rational Common Licensing 库的访问权。 对于任何操作系统，通过添加以下行来配置 **${wlp.user.dir}/servers/server_name/jvm.options** 文件：

   ```xml
   -Djava.library.path=Absolute_path_to_the_previously_created_rcllib_folder
   ```
    
   > **注：**如果您移动了运行管理服务的服务器的配置文件夹，必须使用新的绝对路径来更新 **java.library.path**。

   **${wlp.user.dir}** 目录通常位于 **liberty_install_dir/usr** 中，并且包含 servers 目录。 但是，其位置可进行定制。 有关更多信息，请参阅[定制 Liberty 环境](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc)
    
2. 配置 {{ site.data.keys.mf_server }} 以访问 Rational License Key Server。

   在 **${wlp.user.dir}/servers/server_name/server.xml** 文件中，添加以下 JNDI 配置行。
    
   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="rlks_hostname"/> 
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="rlks_port"/> 
   ```
   * **rlks_hostname** 是 Rational License Key Server 的主机名。
   * **rlks_port** 是 Rational License Key Server 的端口。 缺省情况下，该值为 27000。

   有关 JNDI 属性的更多信息，请参阅[管理服务的 JNDI 属性：许可](../server-configuration/#jndi-properties-for-administration-service-licensing)。

### 安装在 Liberty Profile 服务器场上
{: #installing-on-liberty-profile-server-farm }
要配置 Liberty Profile 服务器场上的 {{ site.data.keys.mf_server }} 连接，必须针对运行 {{ site.data.keys.mf_server }} 管理服务的服务器场中的每个节点，完成[安装 Rational Common Licensing 库](#installing-rational-common-licensing-libraries)中描述的所有步骤。 有关服务器场的更多信息，请参阅[服务器场拓扑](../topologies/#server-farm-topology)和[安装服务器场](../appserver/#installing-a-server-farm)。

## 将 WebSphere Application Server 上安装的 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
在将 {{ site.data.keys.mf_server }} 连接到 Rational License Key Server 之前，必须先在 WebSphere Application Server 上为 Rational Common Licensing 库配置共享库。

* 必须已安装并配置 Rational License Key Server 8.1.4.8 或更高版本。 网络必须允许与 {{ site.data.keys.mf_server }} 进行通信，方法是打开双向通信端口（**lmrgd** 和 **ibmratl**）。 有关更多信息，请参阅 [Rational License Key Server 门户网站](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295)和[如何穿过防火墙向客户端机器提供许可证密钥](http://www.ibm.com/support/docview.wss?uid=swg21257370)。
* 确保生成 {{ site.data.keys.product }} 的许可证密钥。 有关使用 IBM Rational License Key Center 生成和管理许可证密钥的更多信息，请参阅 [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) 以及[通过 IBM Rational License Key Center 获取许可证密钥](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html)。
* 必须按照[令牌许可的安装概述](#installation-overview-for-token-licensing)中所述，在 Apache
Tomcat 上使用“通过 Rational License Key Server 激活令牌许可”选项来安装和配置 {{ site.data.keys.mf_server }}。

### 在独立服务器上安装 Rational Common Licensing 库
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. 为 Rational Common Licensing 库定义共享库。 该库使用本机代码，并且只可供类装入器在应用程序服务器生命周期内装入一次。 因此，将该库声明为共享库，并且将其与运行 {{ site.data.keys.mf_server }} 管理服务的所有应用程序服务器相关联。 有关将该库声明为共享库的原因的更多信息，请参阅[在共享库中配置本机库](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc)。
    * 选择 Rational Common Licensing 本机库。 根据运行 WebSphere Application Server 的 Java 运行时环境 (JRE) 的操作系统和位版本，必须在 **product_install_dir/MobileFirstServer/tokenLibs/bin/your_corresponding_platform/the_native_library_file** 中选择正确的本机库。
    
        例如，对于具有 64 位 JRE 的 Linux x86，该库位于 **product_install_dir/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so** 中。
    
        要为独立的 WebSphere Application Server 或 WebSphere Application Server Network Deployment 安装确定 Java 运行时环境的位版本，请从 **bin** 目录中运行 **versionInfo.bat**（在 Windows 上）或 **versionInfo.sh**（在 UNIX 上）。 **versionInfo.sh** 文件位于 **/opt/IBM/WebSphere/AppServer/bin** 中。 查看**已安装的产品**部分中的“体系结构”值。 如果“体系结构”值已明确提及 64 位或者其后缀为 64 或 _64，那么 Java 运行时环境是 64 位。
    * 将与您平台对应的本机库放到操作系统上的某个文件夹中。 例如，**/opt/IBM/RCL_Native_Library/**。
    * 将 **rcl_ibmratl.jar** 文件复制到 **/opt/IBM/RCL_Native_Library/** 中。 **rcl_ibmratl.jar** 文件是 Rational Common Licensing Java 库，位于 **product_install_dir/MobileFirstServer/tokenLibs** 目录中。
    
        > **要点：**应用程序服务器的 Java 虚拟机 (JVM) 需要具有已复制的本机库和 Java 库的读和执行权限。 在您的操作系统中，至少应用程序服务器进程还必须具有这两个已复制文件的读和执行权限。    
    * 在 WebSphere Application Server 管理控制台中声明共享库。
        * 登录到 WebSphere Application Server 管理控制台。
        * 展开**环境 → 共享库**。
        * 选择对所有运行 {{ site.data.keys.mf_server }} 管理服务的服务器都可见的作用域。 例如，集群。
        * 单击**新建**。
        * 在“名称”字段中输入库的名称。 例如，“RCL 共享库”。
        * 在“类路径”字段中，输入 **rcl_ibmratl.jar** 文件的路径。 例如，**/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**。
        * 单击**确定**以保存更改。 服务器重新启动后，此设置将生效。
    
        > **注：**在步骤 3 中，在服务器 Java 虚拟机的 **ld.library.path** 属性中设置该库的本机库路径。
    * 将该共享库与所有运行 {{ site.data.keys.mf_server }} 管理服务的服务器相关联。
    
        将共享库与服务器相关联将允许多个应用程序使用该共享库。 如果需要将 Rational Common Licensing 客户机仅用于 {{ site.data.keys.mf_server }} 管理服务，您可以创建具有独立类装入器的共享库，并将其与管理服务应用程序相关联。

        以下指示信息描述了如何将库与服务器相关联。 对于 WebSphere Application Server Network Deployment，您必须对所有运行 {{ site.data.keys.mf_server }} 管理服务的服务器都完成这些指示信息。    
        * 设置类装入器策略和方式。    
            1. 在 WebSphere Application Server 管理控制台中，单击**服务器 → 服务器类型 → WebSphere 应用程序服务器 → server_name**，以访问应用程序服务器设置页面。
            2. 为服务器的应用程序类装入器策略和类装入方式设置值：
                * **类装入器策略**：多个
                * **类装入方式**：最先通过父类装入器装入的类
            3. 在**服务器基础结构**部分中，单击 **Java 和流程管理 → 类装入器**。
            4. 单击**新建**，确保将类装入器顺序设置为**最先通过父类装入器装入类**。
            5. 单击**应用**以创建新的类装入器标识。                
        * 为应用程序需要的每个共享库文件创建库引用。
            1. 单击在上一步中创建的类装入器的名称。
            2. 在**其他属性**部分中，单击**共享库引用**。
            3. 单击 **添加**。
            4. 在“库引用设置”页面中，选择适当的库引用。 该名称标识应用程序使用的共享库文件。 例如，RCL 共享库。
            5. 单击**应用**，然后保存更改。
2. 配置 {{ site.data.keys.mf_server }} 管理服务 Web 应用程序的环境条目。
    * 在 WebSphere Application Server 管理控制台中，单击**应用程序 → 应用程序类型 → WebSphere 企业应用程序**，然后选择管理服务应用程序：**MobileFirst_Administration_Service**。
    * 在 **Web 模块属性**部分中，单击 **Web 模块的环境条目**。
    * 输入 **mfp.admin.license.key.server.host** 和 **mfp.admin.license.key.server.port** 的值。
        * **mfp.admin.license.key.server.host** 是 Rational License Key Server 的主机名。
        * **mfp.admin.license.key.server.port** 是 Rational License Key Server 的端口。 缺省情况下，该值为 27000。
    * 单击**确定**以保存更改。
3. 通过应用程序服务器 JVM 来配置对 Rational Common Licensing 库的访问权。
    * 在 WebSphere Application Server 管理控制台中，单击**服务器 → 服务器类型 → WebSphere 应用程序服务器**，并选择您的服务器。
    * 在**服务器基础结构**部分中，单击 **Java 和流程管理 → 流程定义 → Java 虚拟机 → 定制属性 → 新建**以添加定制属性。
    * 在**名称**字段中，输入定制属性的名称作为 **java.library.path**。
    * 在**值**字段中，输入步骤 1b 中用于存放本机库文件的文件夹的路径。 例如，**/opt/IBM/RCL_Native_Library/**。
    * 单击**确定**以保存更改。
4. 重新启动应用程序服务器。

### 在 WebSphere Application Server Network Deployment 上安装 Rational Common Licensing 库
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
要在 WebSphere Application Server Network Deployment 上安装本机库，必须完成上述[在独立服务器上安装 Rational Common Licensing 库](#installing-rational-common-licensing-library-on-a-stand-alone-server)中描述的所有步骤。 必须重新启动您配置的服务器或集群，才能使更改生效。

WebSphere Application Server Network Deployment 的每个节点必须具有 Rational Common Licensing 本机库的副本。

必须配置每个运行 {{ site.data.keys.mf_server }} 管理服务的服务器，使其有权访问本地计算机上复制的本机库。 还必须将这些服务器配置为连接到 Rational License Key Server。

> **要点：**如果将集群与 WebSphere Application Server Network Deployment 一起使用，那么该集群可能会发生变化。 必须在运行管理服务的集群中配置每个新添加的服务器。

## 令牌许可所支持平台的限制
{: #limitations-of-supported-platforms-for-token-licensing }
下面列出了支持 {{ site.data.keys.mf_server }}（已启用令牌许可）的操作系统、操作系统版本和硬件体系结构。

要获得令牌许可，{{ site.data.keys.mf_server }} 需要使用 Rational Common Licensing 库来连接到 Rational License Key Server。

该库包含一个 Java 库和若干本机库。 这些本机库取决于运行 {{ site.data.keys.mf_server }} 的平台。 因此，只有在可运行 Rational Common Licensing 库的平台上才支持通过 {{ site.data.keys.mf_server }} 获得令牌许可。

下表描述了支持具有令牌许可的 {{ site.data.keys.mf_server }} 的平台。

| 操作系统             | 操作系统版本 |	硬件体系结构 |
|------------------------------|--------------------------|-----------------------|
| AIX                          | 7.1                      |	POWER8（仅限 64 位） |
| SUSE Linux Enterprise Server | 11	                      | 仅限 x86-64           |
| Windows Server               | 2012	                  | 仅限 x86-64           |

令牌许可不支持 32 位 Java 运行时环境 (JRE)。 确保应用程序服务器使用 64 位 JRE。

## 对令牌许可问题进行故障诊断
{: #troubleshooting-token-licensing-problems }
如果在安装 {{ site.data.keys.mf_server }} 时已激活令牌许可功能，请查找相关信息以帮助您解决可能遇到的令牌许可问题。

在安装并配置令牌许可后启动 {{ site.data.keys.mf_server }} 管理服务时，在应用程序服务器日志中或在 {{ site.data.keys.mf_console }} 上可能会发出某些错误或异常。 这些异常可能是由错误安装 Rational Common Licensing 库以及错误配置应用程序服务器所引起。

**Apache Tomcat**  
根据您的平台，请查看 **catalina.log** 或 catalina.out 文件。

**WebSphere® Application Server Liberty Profile**  
查看 **messages.log** 文件。

**WebSphere Application Server Full Profile**  
查看 **SystemOut.log** 文件。

> **要点：**如果将令牌许可安装在 WebSphere Application Server Network Deployment 或集群上，那么必须查看每个服务器的日志。

下面列出了在安装和配置令牌许可后可能发生的异常：

* [未找到 Rational Common Licensing 本机库](#rational-common-licensing-native-library-is-not-found)
* [未找到 Rational Common Licensing 共享库](#rational-common-licensing-shared-library-is-not-found)
* [未配置 Rational License Key Server 连接](#the-rational-license-key-server-connection-is-not-configured)
* [Rational License Key Server 不可访问](#the-rational-license-key-server-is-not-accessible)
* [无法初始化 Rational Common Licensing API](#failed-to-initialize-rational-common-licensing-api)
* [令牌许可证不足](#insufficient-token-licenses)
* [rcl_ibmratl.jar 文件无效](#invalid-rcl_ibmratljar-file)

### 未找到 Rational Common Licensing 本机库
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: 未找到 Rational Common Licensing 本机库。 确保使用正确的路径定义 JVM 属性 (java.library.path)，并且可执行本机库。 采取纠正措施后，请重新启动 {{ site.data.keys.mf_server }}。

#### 对于 WebSphere Application Server Full Profile
{: #for-websphere-application-server-full-profile }
该错误的可能原因为：

* 未在服务器级别定义名称为 **java.library.path** 的公共属性。
* 指定为 **java.library.path** 属性值的路径未包含 Rational Common Licensing 本机库。
* 本机库没有相应的许可权。 在 UNIX 和 Windows 上，对于使用应用程序服务器的 Java™ 运行时
* 环境访问该库的用户，他们必须具有该库的读和执行权限。

#### 对于 WebSphere Application Server Liberty Profile 和 Apache Tomcat
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
该错误的可能原因为：

* 指定为 java.library.path 属性值的 Rational Common Licensing 本机库路径未进行设置或者不正确。
    * 对于 Liberty Profile，请查看 **${wlp.user.dir}/servers/server_name/jvm.options** 文件。
    * 对于 Apache Tomcat，请查看 **${CATALINA_HOME}/bin/setenv.bat** 文件或 setenv.sh 文件（取决于您的平台）。
* 在 **java.library.path** 属性所定义的路径中未找到本机库。 请检查所定义的路径中是否存在具有期望名称的本机库。
* 本机库没有相应的许可权。 该错误前面可能出现过异常“`com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: 访问被拒绝`。

应用程序服务器的 Java 运行时环境需要此本机库的读和执行权限。 操作系统中的应用程序服务器进程必须至少具有该库文件的读和执行权限。

* 在 Liberty Profile 的 **${server.config.dir}/server.xml** 文件中未定义使用 **rcl_ibmratl.jar** 文件的共享库。 **rcl_ibmratl.jar** 也可能位于错误的目录中，或目录没有相应的许可权。
* 在 Liberty Profile 的 **${server.config.dir}/server.xml** 文件中，未将使用 **rcl_ibmratl.jar** 文件的共享库声明为 {{ site.data.keys.mf_server }} 管理服务应用程序的公共库。
* 在应用程序服务器的 Java 运行时环境与本机库之间混用了 32 位和 64 位对象。 例如，将 32 位 Java 运行时环境与 64 位本机库一起使用。 不支持这种混用。

### 未找到 Rational Common Licensing 共享库
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: 未找到 Rational Common Licensing 共享库。 确保已配置该共享库。 采取纠正措施后，请重新启动 {{ site.data.keys.mf_server }}。

该错误的可能原因为：

* **rcl_ibmratl.jar** 文件不在期望的目录中。
    * 对于 Apache Tomcat，请检查该文件是否位于 **${CATALINA_HOME}/lib** 目录中。
    * 对于 WebSphere Application Server Liberty Profile，请检查该文件是否位于 Rational Common Licensing 客户机共享库的 server.xml 文件所定义的目录中。 例如，**${shared.resource.dir}/rcllib**。 在 **server.xml** 文件中，请确保将此共享库正确引用为 {{ site.data.keys.mf_server }} 管理服务应用程序的公共库。
    * 对于 WebSphere Application Server，请确保此文件位于 WebSphere Application Server 共享库的类路径所指定的目录中。 请检查该共享库的类路径是否包含以下条目：**absolute\_path/rcl\_ibmratl.jar**（其中 absolute_path 是 **rcl_ibmratl.jar** 文件的绝对路径）。

没有为应用程序服务器设置 **java.library.path** 属性。 定义名为 **java.library.path** 的属性，并将 Rational Common Licensing 本机库的路径设置为该值。 例如，**/opt/IBM/RCL\_Native\_Library/**。
* 本机库没有期望的许可权。 在 Windows 上，应用程序服务器的 Java 运行时环境必须具有本机库的读和执行权限。
* 在应用程序服务器的 Java 运行时环境与本机库之间混用了 32 位和 64 位对象。 例如，将 32 位 Java 运行时环境与 64 位本机库一起使用。 不支持这种混用。

### 未配置 Rational License Key Server 连接
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: 未配置 Rational License Key Server 连接。 确保已设置管理 JNDI 属性“mfp.admin.license.key.server.host”和“mfp.admin.license.key.server.port”。 采取纠正措施后，请重新启动 {{ site.data.keys.mf_server }}。

该错误的可能原因为：

* 已正确配置 Rational Common Licensing 本机库和使用 **rcl_ibmratl.jar** 文件的共享库，但未在 {{ site.data.keys.mf_server }} 管理服务应用程序中设置 JNDI 属性（**mfp.admin.license.key.server.host** 和 **mfp.admin.license.key.server.port**）的值。
* Rational License Key Server 已关闭。
* 无法访问已安装了 Rational License Key Server 的主计算机。 请检查具有指定端口的 IP 地址或主机名。

### Rational License Key Server 不可访问
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: Rational License Key Server“{端口}@{IP 地址或主机名}”不可访问。 确保许可证服务器正在运行且可供 {{ site.data.keys.mf_server }} 访问。 如果在运行时启动时发生此错误，请在采取纠正措施后重新启动 {{ site.data.keys.mf_server }}。

该错误的可能原因为：

* 已正确定义 Rational Common Licensing 共享库和本机库，但没有可连接到 Rational License Key Server 的有效配置。 请检查许可证服务器的 IP 地址、主机名和端口。 确保许可证服务器已启动并且可从安装了应用程序服务器的计算机上进行访问。
* 在 **java.library.path** 属性所定义的路径中未找到本机库。
* 本机库没有相应的许可权。
* 本机库不在所定义的目录中。
* Rational License Key Server 在防火墙后面。 该错误前面可能出现过以下异常：[ERROR] 由于 Rational Licence Key Server ({端口}@{IP 地址或主机名}) 已关闭或不可访问（com.ibm.rcl.ibmratl.LicenseServerUnreachableException），所以无法获取应用程序“WorklightStarter”的许可证。 针对功能部件搜索的所有许可证文件：{端口}@{IP 地址或主机名}

确保在防火墙中已打开许可证管理器守护程序 (lmgrd) 端口和供应商守护程序 (ibmratl) 端口。 有关更多信息，请参阅“如何穿过防火墙向客户端机器提供许可证密钥”。

### 无法初始化 Rational Common Licensing API
{: #failed-to-initialize-rational-common-licensing-api }

> 由于找不到或无法装入其本机库，所以无法初始化 Rational Common Licensing (RCL) APIcom.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl（在 java.library.path 中未找到）

该错误的可能原因为：

* 在 **java.library.path** 属性所定义的路径中未找到 Rational Common Licensing 本机库。 请检查所定义的路径中是否存在具有期望名称的本机库。
* 没有为应用程序服务器设置 **java.library.path** 属性。 定义名为 **java.library.path** 的属性，并将 Rational Common Licensing 本机库的路径设置为该值。 例如，**/opt/IBM/RCL_Native_Library/**。
* 在应用程序服务器的 Java 运行时环境与本机库之间混用了 32 位和 64 位对象。 例如，将 32 位 Java 运行时环境与 64 位本机库一起使用。 不支持这种混用。

### 令牌许可证不足
{: #insufficient-token-licenses }

> FWLSE3129E: 功能部件“{0}”的令牌许可证不足。

当 Rational License Key Server 上的剩余令牌许可证数不足以部署新的 {{ site.data.keys.product_adj }} 应用程序时，就会发生此错误。

### rcl_ibmratl.jar 文件无效
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: 共享库 RCL Shared Library 包含不能解析为有效 jar 文件的类路径条目，该库 jar 文件预计位于 {0}/rcl_ibmratl.jar 中。

**注：**仅用于 WebSphere Application Server 和 WebSphere Application Server Network Deployment

该错误的可能原因为：

* **rcl_ibmratl.jar** Java 库没有相应的许可权。 该错误后面可能出现异常“java.util.zip.ZipException: 在打开的 zip 文件中出现错误”。 请检查安装了 WebSphere Application Server 的用户是否具有 **rcl_ibmratl.jar** 文件的读许可权。
* 如果没有其他异常，那么在共享库类路径中引用的 **rcl_ibmratl.jar** 文件可能无效或不存在。 请检查 **rcl_ibmratl.jar** 文件是否有效或者是否存在于所定义的路径中。


