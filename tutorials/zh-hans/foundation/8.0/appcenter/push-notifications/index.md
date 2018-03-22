---
layout: tutorial
title: 应用程序更新的推送通知
breadcrumb_title: Push notifications
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
您可以配置 Application Center 客户机，以便在应用商店中有应用程序更新可用时向用户发送推送通知。

Application Center 管理员使用推送通知向任何 iOS 或 Android 设备自动发送通知。 针对收藏的应用程序的更新和 Application Center 服务器上部署并标记为建议的新应用程序发送通知。

### 推送通知进程
{: #push-notification-process }
如果满足以下条件，推送通知会发送到设备。

* 设备已安装并且已至少启动过一次 Application Center。
* 用户针对此设备在**设置 → 通知**界面中未禁用 Application Center 的推送通知。
* 允许用户安装该应用程序。 此类许可权由 Application Center 访问权控制。
* 针对在此设备上使用 Application Center 的用户，此应用程序标记为建议的应用程序或首选的应用程序。 当用户通过 Application Center 安装应用程序时会自动设置这些标记。 您可以通过在设备上查看 Application Center **收藏夹**选项卡来查看将哪些应用程序标记为首选应用程序。
* 在设备上未安装该应用程序，或者相比于设备上已安装的应用程序版本，有更新的版本可用。

Application Center 客户机在设备上首次启动时，可能会询问用户是否接受入站推送通知。 针对 iOS 移动设备是这种情况。 在移动设备上禁用了此服务时，推送通知功能将不起作用。

iOS 和现代 Android 操作系统版本提供了逐个应用程序打开或关闭此服务的方法。

请联系设备供应商以了解如何配置移动设备的推送通知。

#### 跳至：
{: #jump-to }
* [为应用程序更新配置推送通知](#configuring-push-notifications)
* [配置 Application Center 服务器以连接到 Google 云消息传递](#gcm)
* [配置 Application Center 服务器以连接至 Apple 推送通知服务](#apns)
* [构建不依赖 GCM API 的移动式客户机版本](#no-gcm)

## 为应用程序更新配置推送通知
{: #configuring-push-notifications }
您必须配置 Application Center 服务的凭证或证书，才能与第三方推送通知服务器进行通信。

### 配置 Application Center 的服务器计划程序
{: #configuring-the-server-scheduler }
服务器计划程序是随服务器自动启动和停止的后台服务。 此计划程序用于定期清空由管理员操作自动使用要发送的推送更新消息来填充的堆栈。 发送两批推送更新消息之间的缺省时间间隔为十二个小时。 如果此缺省值不适合您，那么您可以使用服务器环境变量 **ibm.appcenter.push.schedule.period.amount** 和 **ibm.appcenter.push.schedule.period.unit** 对其进行修改。

**ibm.appcenter.push.schedule.period.amount** 的值为整数。 **ibm.appcenter.push.schedule.period.unit** 的值可为 seconds、minutes 或 hours。 如果未指定单位，该数量将是以小时为单位表示的时间间隔。 这些变量用于定义两批推送消息之间的耗用时间。

使用 JNDI 属性定义这些变量。

> **要点：**在生产环境中，请避免将该单位设置为 seconds。 耗用时间越短，服务器上的负载越大。 只能对测试和评估目的使用“秒”单位。 例如，当把耗用时间设置为 10 秒时，几乎立即发送推送消息。

请参阅 [Application Center 的 JNDI 属性](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)，以获取可设置的完整属性列表。

### Apache Tomcat 服务器的示例
{: tomcat }
在 server.xml 文件中使用 JNDI 属性定义这些变量：

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server v8.5
{: #websphere }
要针对 WebSphere Application Server v8.5 配置 JNDI 变量，请执行如下操作：

1. 单击**应用程序 → 应用程序类型 → Websphere 企业应用程序**。
2. 选择“Application Center 服务”应用程序。
3. 单击 **Web 模块属性 → Web 模块的环境条目**。
4. 编辑**值**列中的字符串。

#### WebSphere
Application Server Liberty Profile
{: #liberty }
有关如何为 WebSphere Application Server Liberty Profile 配置 JNDI 变量的信息，请参阅[为服务器配置文件的常量使用 JNDI 绑定](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html)。

设置推送通知服务的其余操作取决于安装目标应用程序的设备的供应商。

## 配置 Application Center 服务器以连接到 Google 云消息传递
{: #gcm }
要为应用程序启用 Google Cloud Messaging (GCM)，您必须将 GCM 服务连接到启用了 Google API 的开发人员 Google 帐户。 请参阅 [GCM 入门](http://developer.android.com/google/gcm/gs.html)，以获取详细信息。

> 要点：不具有 Google 云消息传递 (GCM) 的 Application Center 客户机：Application Center 依赖于是否提供 Google 云消息传递 (GCM) API。 该 API 可能在某些地域（如中国）的设备上不可用。 要支持那些地域，您可构建不依赖 GCM API 的 Application Center 客户机版本。 推送通知功能在该 Application Center 客户机版本上将不起作用。 请参阅[构建不依赖 GCM API 的移动式客户机版本](#no-gcm)，以获取详细信息。

1. 如果您不具有相应的 Google 帐户，请转至[创建 Google 帐户](https://mail.google.com/mail/signup)，并为 Application Center 客户机创建一个帐户。
2. 使用 [Google API 控制台](https://code.google.com/apis/console/)中的 Google API 注册此帐户。 注册会创建一个新的缺省项目，您可以重命名此项目。 您提供给此 GCM 项目的名称与您的 Android 应用程序包名称无关。 创建项目时，GCM 项目标识会附加到项目 URL 末尾。 您应记录此尾部编号作为您的项目标识，以便将来引用。
3. 为您的项目启用 GCM 服务；在 Google API 控制台中，单击左侧的**服务**选项卡并启用服务列表中的“Google Cloud Messaging for Android”服务。
4. 请确保您的应用程序通信可使用简单 API 访问服务器密钥。
    * 单击控制台左侧的 **API 访问**垂直选项卡。
    * 创建一个简单 API 访问服务器密钥，或者如果已创建了缺省密钥，记下缺省密钥的详细信息。 存在另两种密钥，但与此时的情况无关。
    * 请保存简单 API 访问服务器密钥以便将来通过 GCM 进行应用程序通信时使用。 密钥长度约为 40 个字符，称为 Google API 密钥，以后在服务器端需要此密钥。
5. 在 Application Center Android 客户机的 JavaScript 项目中输入 GCM 项目标识作为字符串资源属性；在 **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** 模板文件中，使用自己的值修改以下行：

   ```xml
   gcmProjectId:""// Google API project (project name = com.ibm.appcenter) ID needed for Android push.
   // example : 123456789012
   ```

6. 注册 Google API 密钥作为 Application Center 服务器的 JNDI 属性。 密钥名称为：**ibm.appcenter.gcm.signature.googleapikey**。 例如，您可以在 **server.xml** 文件中为 Apache Tomcat 服务器将此密钥配置为 JNDI 属性：

   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String" 
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   JNDI 属性必须按照您的应用程序服务器需求进行定义。  
   请参阅 [Application Center 的 JNDI 属性](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)，以获取可设置的完整属性列表。

**要点：**

* 如果您将 GCM 用于先前版本的 Android，那么您可能需要将自己的设备与现有 Google 帐户配对，GCM 才能有效工作。 请参阅 [GCM 服务](http://developer.android.com/google/gcm/gcm.html)：“它使用 Google 服务的现有连接。 对于低于 3.0 版本的设备，这需要用户在其移动设备上设置其 Google 帐户。 在运行 Android 4.0.4 或更高版本的设备上无需 Google 帐户。”
* 您还必须确保防火墙接受至端口 443 上的 android.googleapis.com 的出站连接，从而使推送通知正常工作。

## 配置 Application Center 服务器以连接至 Apple 推送通知服务
{: #apns }
为 Apple 推送通知服务 (APN) 配置您的 iOS 项目。 请确保可以从 Application Center 服务器访问以下服务器。

**沙箱服务器**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**生产服务器**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

您必须是已注册的 Apple 开发人员才能使用 Apple 推送通知服务 (APN) 成功配置自己的 iOS 项目。 在公司内，负责 Apple 开发的管理角色会请求 APN 支持。 此请求的响应应该会为您提供支持 APN 的供应概要文件，以用于您的 iOS 应用程序捆绑软件；即，在 Xcode 项目的配置页面中定义的字符串值。 此供应概要文件用于生成签名证书文件。
存在两种类型的供应概要文件：开发概要文件和生产概要文件，分别用于处理开发环境和生产环境。 开发概要文件专门用于处理 Apple 开发 APN 服务器。 生产概要文件专门用于处理 Apple 生产 APN 服务器。 这两种类型的服务器提供的服务质量不同。

注：如果设备与受防火墙保护的公司 Wi-Fi 连接，那么仅当至以下类型地址的连接未被防火墙阻止时，该设备才能接收推送通知。

`x-courier.sandbox.push.apple.com:5223`  
其中，x 是整数。

1. 针对 Application Center Xcode 项目获取支持 APN 的供应概要文件。 管理员的 APN 支持请求的结果显示为一个列表，此列表可通过以下地址进行访问：[https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action)。 列表中的每个项都显示概要文件是否具有 APN 功能。 如果您有此概要文件，可以通过双击此概要文件以在 Application Center 客户机 Xcode 项目目录中下载并安装此概要文件。 然后，会在您的密钥库和 Xcode 项目中自动安装此概要文件。

2. 如果您要直接从 XCode 启动 Application Center 以在设备上对其进行测试或调试，请在“XCode 组织器”窗口中转至“供应概要文件”部分并在您的移动设备上安装此概要文件。

3. 创建由 Application Center 用于保护与 APN 服务器之间的通信的签名证书。 此服务器将使用该证书来签署发送至 APN 服务器的每一条推送请求。 此签名证书是从您的供应概要文件生成的。

* 打开“Keychain Access”实用程序，然后单击左侧窗格中的**我的证书**类别。
* 查找您要安装的证书并显示其内容。 您会看到证书和专用密钥；针对 Application Center，证书行包含 Application Center 应用程序捆绑软件 **com.ibm.imf.AppCenter**。
* 选择**文件 → 导出项**以选中该证书和密钥，并将其导出为个人信息交换 (.p12) 文件。 此 .p12 文件包含在使用安全握手协议与 APN 服务器进行通信时所需的专用密钥。
* 将 .p12 证书复制到负责运行 Application Center 服务的计算机，并在适当的位置安装该证书。 创建与 APN 服务器之间的安全隧道需要该证书文件及其密码。 您还需要某些信息以指示使用的是开发证书还是生产证书。 开发供应概要文件会生成开发证书，生产概要文件会提供生产证书。 Application Center 服务 Web 应用程序使用 JNDI 属性来引用此安全数据

下表中的示例显示了在 Apache Tomcat 服务器的 server.xml 文件中如何定义 JNDI 属性。

| JNDI 属性	| 类型和描述 | Apache Tomcat 服务器的示例 |
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location | 用于定义 .p12 证书的完整路径的字符串值。 | `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password | 用于定义访问证书所需的密码的字符串值。 | `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` |
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate |	用于定义可生成认证证书的供应概要文件是否为开发证书的布尔值（标识为 true 或 false）。 | `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` |

请参阅 [Application Center 的 JNDI 属性](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center)，以获取可设置的完整 JNDI 属性列表。

## 构建不依赖 GCM API 的移动式客户机版本
{: #no-gcm }
您可从 Android 版客户机除去对 Google Cloud Messaging (GCM) API 的依赖，使之符合某些地域的约束。 在该客户机版本上无法推送通知。

Application Center 依赖 Google Cloud Messaging (GCM) API 的可用性。 该 API 可能在某些地域（如中国）的设备上不可用。 要支持那些地域，您可构建不依赖 GCM API 的 Application Center 客户机版本。 推送通知功能在该 Application Center 客户机版本上将不起作用。

1. 通过检查 **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** 文件是否包含以下行，
来检查推送通知是否禁用：`"gcmProjectId": "" ,`。
2. 从 **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** 文件中的两个位置除去以下注释之间的所有行：`<!-- AppCenter Push configuration -->` 和 `<!-- end of AppCenter Push configuration -->`。
3. 删除 **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java** 类。
4. 在 Eclipse 中，在 IBMAppCenter/apps/AppCenter/android 文件夹中运行“Build Android Environment”。
5. 删除此前在运行“Build Android Environment”命令时由 MobileFirst 插件创建的 **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar** 文件。
6. 刷新新创建的 IBMAppCenterAppCenterAndroid 项目，以便了解到 GCM 库已除去。
7. 构建 Application Center 的 .apk 文件。

每次构建 Android 环境时，MobileFirst Eclipse 插件都会自动添加 **gcm.jar** 库。 因此，每次运行 MobileFirst Android 构建过程时，都必须从 **IBMAppCenter/apps/AppCenter/android/native/libs/** 目录中删除此 java 归档文件。 否则，生成的 **appcenter.apk** 文件中将出现 **gcm.jar** 库。
