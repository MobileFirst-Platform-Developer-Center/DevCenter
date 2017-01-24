---
layout: tutorial
title: 词汇表
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{ site.data.keys.mf_console }}   " for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>本词汇表提供{{ site.data.keys.product }}   软件和产品的术语及定义。
本词汇表中使用了以下交叉引用：

* **请参阅**：让您根据非首选词汇来参考首选词汇，或根据缩写词来参考拼写完整的格式。
* **另请参阅**：让您参考意思相关或相反的词汇。

要了解其他术语和定义，请访问 [IBM Terminology Web 站点](http://www.ibm.com/software/globalization/terminology/)。

### 安全性测试 (security test)
{: #security-test }
一组有序的认证域，用于保护资源，例如，适配器程序、应用程序或静态 URL。

### 包装程序 (wrapper)
{: #wrapper }
一个代码段，包含编译器可能无法解释的代码。包装程序充当编译器与包装的代码之间的接口。

### 本地存储 (local store)
{: #local-store }
设备上的一个区域，应用程序可以在其中以本地方式存储和检索数据，而无需网络连接。

### 本机应用程序 (native app)
{: #native-app }
编译成二进制代码的应用程序，可以在设备上的移动操作系统中使用。

### 别名 (alias)
{: #alias }
两个数据实体之间或数据实体与指针之间具有假设或实际的关联。

### 部署 (deployment)
{: #deployment }
安装和配置软件应用程序及其所有组件的过程。

### 采集策略 (acquisition policy)
{: #acquisition-policy }
一种策略，控制如何从移动设备的传感器中收集数据。该策略由应用程序代码定义。

### 场节点 (farm node)
{: #farm-node }
位于服务器场内的联网服务器。

### 触发器 (trigger)
{: #trigger }
一种机制，检测某种事件并且可以引起额外的处理操作来作为响应。设备上下文中发生变化时可能会激活触发器。另请参阅设备上下文 (device
context)。

### 触发 (fire)
{: #fire }
在面向对象的程序设计中，引起状态过渡。

### 窗口小部件 (widget)
{: #widget }
可移植、可复用的应用程序或动态内容片段，可以放入 Web 应用程序中、接收输入以及与应用程序或另一个窗口小部件进行通信。

### 代理 (proxy)
{: #proxy }
特定网络应用程序（如 Telnet 或 FTP）的应用程序网关（从一个网络到另一个网络），例如，防火墙代理 Telnet 服务器在其中执行用户认证，然后让流量流经代理，就好像没有代理一样。如果在防火墙而非客户机工作站中执行功能，将会导致防火墙中产生更多负载。

### 地理位置编码 (geocoding)
{: #geocoding }
从传统地理位置标记（地址、邮政编码等）识别地理位置代码的过程。例如，地标可位于两条街道的交叉处，但是该地标的地理位置代码由一个数字序列组成。

### 地理位置 (geolocation)
{: #geolocation }
根据针对各种信号类型的评估来进行精确定位的过程。在移动计算中，WLAN 访问点和信号发射塔通常用于粗略估计某个位置。另请参阅“地理位置编码 (geocoding)”和“定位服务 (location services)”。

### 点击 (tap)
{: #tap }
短暂地接触触摸屏。通常，应用程序使用点击手势来选择项目（类似于鼠标左键单击）。

### 二进制 (binary)
{: #binary }
属于可编译对象，或者是可执行文件。

### 仿真器 (emulator)
{: emulator }
一个应用程序，用于运行旨在供当前平台以外的其他平台使用的应用程序。

### 服务器场 (server farm)
{: #server-farm }
一组联网服务器。

### 服务 (service)
{: #service }
一个程序，执行服务器或相关软件中的主要功能。

### 负载均衡 (load balancing)
{: #load-balancing }
用于在多台计算机或一个计算机集群、网络链路、中央处理器、磁盘驱动器或其他资源中分配工作负载的计算机联网方法。成功的负载均衡可以优化资源使用、最大化吞吐量、最小化响应时间和避免超负荷。

### 根目录 (root)
{: #root }
包含系统中所有其他目录的目录。

### 公共密钥基础结构 (PKI / Public Key Infrastructure (PKI))
{: #pki--public-key-infrastructure-pki }
数字证书、认证中心和其他注册中心的系统，这些组织可验证和认证网络交易中所涉及每一方的有效性。

### 公司应用程序 (company application)
{: #company-application }
专供公司内部使用的应用程序。

### 公司主数据中心 (Company Hub)
{: #company-hub }
可分配移动设备上安装的其他指定应用程序的一项应用程序。例如，Application Center 就是一个公司主数据中心。另请参阅 [Application Center](#application-center)。

### 供应 (provision)
{: #provisin }
提供、部署和跟踪服务、组件、应用程序或资源。

### 公用密钥 (public key)
{: #public-key }
在安全通信中指一种算法模式，用于解密由对应的专用密钥加密的消息。公用密钥还用于对消息进行加密，加密后的消息只能使用对应的专用密钥进行解密。用户会将其公用密钥告知必须与其交换加密消息的所有人。另请参阅“密钥 (key)”和“专用密钥 (private key)”。

### 构建定义 (build definition)
{: #build-definition }
用于定义构建的对象，如每周进行的项目范围内的集成构建。

### 构面 (facet)
{: #facet }
用于限制 XML 数据类型的 XML 实体。

### 管理数据库 (administration database)
{: #administration-database }
{{ site.data.keys.mf_console }}    和管理服务的数据库。该数据库表定义诸如应用程序、适配器、带有其描述及数量级的项目的元素。

### 广播通知 (broadcast notification)
{: #broadcast-notification }
针对特定 {{ site.data.keys.product_adj }}    应用程序的所有用户的通知。另请参阅“基于标记的通知 (tag-based notification)”。

### 滑动 (slide)
{: #slide }
在触摸屏上水平移动滑块界面项。
通常情况下，应用程序使用滑动手势来锁定和解锁手机或切换选项。

### 环境 (environment)
{: #environment }
硬件和软件配置的特定实例。

### 回调函数 (callback function)
{: #callback-function }
可执行代码，允许较低水平的软件层调用较高水平的层中定义的函数。

### 会话 (session)
{: #sessions }
网络上两个站、软件程序或设备之间的逻辑或虚拟连接，允许两个元素在整个会话期间进行通信和交换数据。

### 混合应用程序 (hybrid application)
{: #hybrid-application }
一个应用程序，主要采用面向 Web 的语言（HTML5、CSS 和 JS）编写但包装在本机 shell 中，以使应用程序行为类似于本机应用程序，并为用户提供本机应用程序的所有功能。

### 基于标记的通知 (tag-based notification)
{: #tag-based-notification }
针对特定标记而订阅的设备的通知。标记用于表示用户感兴趣的主题。另请参阅广播通知 (broadcast notification)。

### 集群 (cluster)
{: #cluster }
共同协作以提供单一的统一计算功能的整个系统的集合。

### 加密盐 (Salt)
{: #salt }
插入密码或口令散列中的随机生成的数据，使得这些密码变得不寻常（并且更难以破解）。

### 加密 (encryption)
{: #encryption }
在计算机安全性中，是指将数据转换为无法理解的形式的过程，通过这种方式，原始数据将无法获取或者通过解密过程才能获取原始数据。

### 节点
{: #node }
受管服务器的逻辑组。

### 客户端认证组件 (client-side authentication component)
{: #client-side-authentication-componnet }
一个组件，用于收集客户机信息，然后使用登录模块验证此信息。

### 客户机 (client)
{: #client }
从服务器请求服务的软件程序或计算机。

### 克隆 (clone)
{: #clone }
最新获得批准的组件版本的相同副本，具有新的唯一组件标识。

### 库 (library)
{: #library }
充当其他对象目录的系统对象。库对相关对象分组并允许用户按名称查找对象。模型元素的集合，包括业务项、进程、任务、资源和组织。

### 块 (block)
{: #block }
多个属性（如适配器、过程或参数）的集合。

### 轮询 (poll)
{: #poll }
从服务器重复请求数据。

### 密钥对 (key pair)
{: #key-pair }
在计算机安全性中指公用密钥和专用密钥。在将密钥对用于加密时，发送方使用接收方的公用密钥加密消息，接收方使用其专用密钥解密消息。在将密钥对用于签名时，签署方使用其专用密钥加密消息表示，接收方使用发送方的公用密钥解密消息表示以验证签名。

### 密钥链 (keychain)
{: #keychain }
Apple 软件的密码管理系统。密钥链用作多个应用程序和服务所使用的密码的安全存储容器。

### 密钥 (key)
{: #key }
经过加密的数学值，用于以数字方式签署、验证、加密或解密消息。另请参阅“专用密钥 (private key)”和“公用密钥 (public key)”。
数据项中的一个或多个字符，用于唯一地标识某条记录并确定该记录相对于其他记录的顺序。

### 模板 (template)
{: #template }
共享公共属性的一组元素。这些属性只能在模板级别定义一次，所有使用该模板的元素都将继承这些属性。

### 模拟器 (simulator)
{: #simulator }
为不同的平台编写的登台代码的环境。模拟器用于在同一 IDE 中开发和测试代码，但随后将代码部署到其特定平台。例如，某人可以为计算机上的 Android 设备开发代码，然后使用该计算机上的模拟器对其进行测试。

### 目录 (catalog)
{: #catalog }
应用程序的集合。

### 内部应用程序 (in-house application)
{: #in-house-application }
请参阅[公司应用程序 (company application)](#company-application)。

### 逆向代理 (reverse proxy)
{: #reverse-proxy }
IP 转发拓扑，其中的代理代表的是后端 HTTP 服务器。它是针对使用 HTTP 的服务器的应用程序代理。

### 皮肤 (skin)
{: #skin }
可以更改的图形用户界面元素，用于更改界面外观，而不影响其功能。

### 凭证 (credential)
{: #credential }
一组信息，可以将某些访问权授予用户或进程。

### 企业应用程序 (enterprise application)
{: #enterprise-application }
请参阅“公司应用程序 (company application)”。

### 签署 (sign)
{: #sign }
通过邮件发送文档时，将源自发送方用户标识的唯一电子签名附加到文档或字段。如果未获得授权的用户创建了用户标识的新副本，签署邮件可以确保未获得授权的用户无法通过该标识伪造签名。
此外，签名可以验证在传送消息时没有人篡改数据。

### 认证中心企业应用程序 (certificate authority enterprise application)
{: #certificate-authority-enterprise-application }
为客户机应用程序提供证书和专用密钥的公司应用程序。

### 认证中心 (CA / Certificate Authority (CA))
{: #ca--certificate-authority-ca }
颁发数字证书的可靠的第三方组织或公司。认证中心通常将验证被授予唯一证书的个体的身份。另请参阅[证书 (certificate)](#certificate)。

### 认证 (authentication)
{: #authentication }
一种安全服务，用于证明计算机系统的用户与该人所声称的身份相符。实施此服务的常见机制为密码和数字签名。

### 软件开发包 (SDK / Software Development Kit (SDK))
{: #sdk--software-development-kit-sdk }
一组工具、API 和文档，可帮助以特定的计算机语言或针对特定操作环境开发软件。

### 设备上下文 (device context)
{: #device-context }
用于识别设备位置的数据。该数据可能会包含地理位置坐标、WiFi 访问点和时间戳记详细信息。另请参阅“触发器 (trigger)”。

### 设备注册 (device enrollment)
{: #device-enrollment }
设备所有者将其设备注册为可信的过程。

### 设备 (device)
{: #device }
请参阅[移动设备 (mobile device)](#mobile-device)

### 实体 (entity)
{: #entity }
针对安全服务而定义的用户、组或资源。

### 事件源 (event source)
{: #event-source }
支持单个 Java™ 虚拟机内的异步通知服务器的对象。通过使用事件源，可以注册事件侦听器对象，并将其用于实现任何接口。

### 事件 (event)
{: #event }
对任务或系统具有重要意义的事情。事件可能包含操作完成或失败、用户操作或进程状态变化。

### 适配器 (adapter)
{: #adapter }
{{ site.data.keys.product_adj }}    应用程序的服务器端代码。适配器连接到企业应用程序，与移动应用程序相互传递数据，并对发送的数据执行任何必需的服务器端逻辑。

### 视图 (view)
{: #view }
编辑器区域外部的一个窗格，可用于查看或使用工作台中的资源。

### 受管 Bean (MBean / Managed Bean (MBean))
{: #mbean--managed-bean-mbean}
Java 管理扩展 (JMX) 规范中实现资源及其检测的 Java 对象。

### 数据源 (data source)
{: #data-source }
应用程序用来访问数据库中数据的方法。

### 通知 (notification)
{: #notification }
过程中可能会触发操作的情形。通知可用于对兴趣条件进行建模，该兴趣条件将会从发送方传输至（通常未知的）一组感兴趣方（接收方）。

### 同类的服务器场 (homogeneous server farm)
{: #homogeneous-server-farm }
所有应用程序服务器的类型、级别和版本均相同的服务器场。

### 推送通知 (push notification)
{: #push-notification }
一个警报，指示显示在移动设备应用程序图标发生更改或更新。

### 推送 (push)
{: #push }
将信息从服务器发送至客户机。服务器推送内容时，将会由服务器启动事务，而不是由来自客户机的请求启动事务。

### 网关 (gateway)
{: #gateway }
设备或程序，用于连接具有不同网络体系结构的网络或系统。

### 系统消息 (system message)
{: #system-message }
移动设备上自动发送的消息，用于提供操作状态或警报，例如，连接是否成功。

### 项目 (project)
{: #project }
各种组件（如应用程序、适配器、配置文件、定制 Java 代码和库）的开发环境。

### 项目 WAR 文件 (project WAR file)
{: #project-war-file }
Web 归档 (WAR) 文件，包含 {{ site.data.keys.product_adj }}    运行时环境的配置，部署在应用程序服务器上。

### 信任关联拦截器 (TAI / Trust Association Interceptor (TAI))
{: #tai--trust-association-interceptor-tai }
在生产环境中针对代理服务器收到的每个请求验证信任的机制。验证方法由代理服务器和拦截器商定。

### 验证问题处理程序 (challenge handler)
{: #challenge-handler }
客户端组件，该组件在服务器端发出一系列验证问题，并在客户端应答。

### 验证问题 (challenge)
{: #challenge }
向系统发出的针对特定信息的请求。该信息会发送回服务器以响应此请求，进行客户机认证时必须提供此消息。

### 页面导航 (page navigation)
{: #page-navigation }
一项浏览器功能，支持用户在浏览器中向后和向前导航。

### 移动设备 (mobile device)
{: #mobile-device }
运行在无线网络中的电话、平板电脑或个人数字助理。另请参阅“Android”。

### 移动设备 (mobile)
{: #mobile }
请参阅[移动设备 (mobile device)](#mobile-device)。

### 移动式客户机 (mobile client)
{: #mobile-client }
请参阅 [Application Center 安装程序 (Application Center installer)](#application-center-installer)。

### 应用程序编程接口 (API / Application Programming Interface (API))
{: #api-application-programming-interfacae-api }
一种接口，允许以高级语言编写的应用程序使用操作系统或其他程序的特定数据或功能。

### 应用程序描述符文件 (application descriptor file)
{: #application-descriptor-file }
一个元数据文件，用于定义应用程序的各个方面。

### 应用程序 (app)
{: #app }
Web 或移动设备应用程序。另请参阅“Web 应用程序 (web application)”。

### 语法 (syntax)
{: #syntax }
命令或语句的构造规则。

### 预订 (subscription)
{: #subscription }
一条记录，包含订户传递至本地代理程序或服务器的信息，用于描述要接收的出版物。

### 证书撤销列表 (CRL / Certificate Revocation List (CRL))
{: #crl-certificate-revocation-list-crl }
已在计划截止日期前撤销的证书列表。证书撤销列表由认证中心维护并在安全套接字层 (SSL) 握手期间使用，以确保不撤销所涉及的证书。

### 证书 (certificate)
{: #certificate }
在计算机安全性中，用于将公用密钥绑定到证书所有者的身份，从而能够认证证书所有者的数字文档。证书由认证中心发放并由该中心进行数字签名。另请参阅[认证中心 (certificate authority)](#ca--certificate-authority-ca)。

### 专用密钥 (private key)
{: #private-key }
在安全通信中指一种算法模式，用于加密只有对应的公用密钥才能解密的消息。专用密钥还用于解密由对应的公用密钥加密的消息。专用密钥保存在用户系统上并受密码保护。另请参阅“密钥 (key)”和“公用密钥 (public key)”。

### 子元素 (subelement)
{: #subelement }
UN/EDIFACT EDI 标准中属于 EDI 组合数据元素的 EDI 数据元素。例如，EDI 数据元素及其限定符是 EDI 组合数据元素的子元素。

### 组件 (component)
{: #component }
可复用的对象或程序，用于执行特定的功能或与其他组件和应用程序进行协作。

## A {
{: #a }
}
### Administration Services
{: #administration-services }
托管 REST 服务和管理任务的应用程序。Administration Services 应用程序打包在其自己的 WAR 文件中。

### Android
{: #android }
Google 创建的移动操作系统，大多数都是根据 Apache 2.0 和 GPLv2 开放式源代码许可发行的。另请参阅“移动设备 (mobile device)”。

### Application Center
{: #application-center }
{{ site.data.keys.product_adj }}    组件，可用于共享应用程序并在移动应用程序的单一存储库中促进团队成员之间的协作。

### Application Center 安装程序 (Application Center installer)
{: #application-center-installer }
一个应用程序，用于列出 Application Center 中可用应用程序的目录。设备中必须存在 Application Center Installer，才能从专用应用程序存储库安装应用程序。

## B
{: #b }
### Base64
{: #base64 }
用于对二进制数据进行编码的纯文本格式。用户证书认证中通常使用 Base64 编码对 X.509 证书、X.509 CSR 和 X.509 CRL 进行编码。另请参阅“DER 编码 (DER encoded)”和“PEM 编码 (PEM encoded)”。

## D
{: #d }

### DER 编码 (DER encoded)
{: #der-encoded }
与 ASCII PEM 格式证书的二进制格式有关。
另请参阅“Base64”和“PEM 编码 (PEM encoded)”。

### documentify
{: #documentify }
用于创建文档的 JSONStore 命令。

## J
{: #j }

### Java 管理扩展 (JMX / Java Management Extensions (JMX))
{: #jmx--java-management-extensions-jmx }
对 Java 技术进行管理和通过 Java 技术进行管理的一种途径。JMX 是 Java 编程语言在管理方面的一个通用开放式扩展，可在所有需要管理的行业中进行部署。

## M
{: #m }

### MobileFirst 适配器
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
请参阅[适配器](#adapter)

### MobileFirst 数据代理
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
IMFData SDK 的服务器端组件，可用于通过使用 {{ site.data.keys.product }}    OAuth 安全功能来保护对 Cloudant 的移动应用程序调用。{{ site.data.keys.product_adj }}    数据代理需要通过信任关联拦截器进行认证。### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
基于 Web 的界面，用于控制和管理 {{ site.data.keys.mf_server }}    中部署的 {{ site.data.keys.product_adj }}    运行时环境，以及收集和分析用户统计信息。### MobileFirst 运行时环境
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
运行移动应用程序服务器端的移动优化的服务器端组件（后端集成、版本管理、安全性和统一推送通知）。每个运行时环境都打包为一个 Web 应用程序（WAR 文件）。### MobileFirst
Server
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{ site.data.keys.product_adj }}    组件，用于处理安全性、后端连接、推送通知、移动应用程序管理和分析。{{ site.data.keys.mf_server }}    是应用程序服务器上运行的应用程序集合，充当 {{ site.data.keys.product_adj }}    运行时环境的运行时容器。## N
{: #n }

## O
{: #o }

### OAuth
{: #oauth }
一种基于 HTTP 的授权协议，通过在资源所有者、客户机和资源服务器之间创建核准交互，使应用程序代表资源所有者在限定范围内访问受保护的资源。

## P
{: #p }

### PEM 编码 (PEM encoded)
{: #pem-encoded }
与 Base64 编码证书有关。另请参阅“Base64”和“DER 编码 (DER encoded)”。

### PKI 网桥 (PKI bridge)
{: #pki-bridge }
一项 {{ site.data.keys.mf_server }}    概念，用于支持用户证书认证框架与 PKI 通信。

## W
{: #w}

### Web 应用程序服务器 (web application server)
{: #web-application-server }
动态 Web 应用程序的运行时环境。Java EE Web 应用程序服务器将实施 Java EE 标准的服务。

### Web 应用程序 (web app / application)
{: #web-app--application }
一个应用程序，可通过 Web 浏览器访问并提供除静态信息显示以外的一些功能，例如，允许用户查询数据库。Web 应用程序的公共组件包括 HTML 页面、JSP 页面和 servlet。另请参阅[应用程序 (app)](#A)。

### Web 资源 (web resource)
{: #web-resource }
开发 Web 应用程序期间创建的任何一个资源，例如，Web 项目、HTML 页面、JavaServer 页面 (JSP) 文件、servlet、定制标记库和归档文件。

## X
{: #x }

### X.509 证书 (X.509 certificate)
{: #x509-certificate }
一个包含由 X.509 标准定义的信息的证书。
