---
layout: tutorial
title: 不推荐和已停用的功能与 API
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
请仔细考虑已除去的功能和 API 元素将如何影响您的 {{ site.data.keys.product_full }} 环境。

#### 跳转至
{: #jump-to }
* [V8.0 中已停用的功能和未包含的功能](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [服务器端 API 更改](#server-side-api-changes)
* [客户端 API 更改](#client-side-api-changes)

## V8.0 中已停用的功能和未包含的功能
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
与先前版本相比，{{ site.data.keys.product }} V8.0 彻底进行了简化。由于此简化，V7.1 中可用的一些功能在 V8.0 中已停用。在大多数情况下，建议使用其他方式来实现这些功能。这些功能被标记为已废弃。V7.1 中的某些其他功能已从 V8.0 中消失，但不是因 V8.0 采用新设计所致。为了将这些已排除的功能与 v8.0 中已停用的功能区分开来，将这些功能标记为在 V8.0 中未提供。

<table class="table table-striped">
    <tr>
        <td>功能</td>
        <td>状态和替换路径</td>
    </tr>
    <tr>
        <td><p>MobileFirst Studio 替换为 Eclipse 的 {{site.data.keys.mf_studio }} 插件。</p></td>
        <td><p>替换为 Eclipse 的 {{site.data.keys.mf_studio }} 插件，受标准和社区基本 Eclipse 插件支持。您可以直接使用 Apache Cordova CLI 或使用启用了 Cordova 的 IDE（如 Visual Studio Code、Eclipse、IntelliJ 等）开发混合应用程序。有关使用 Eclipse 作为启用了 Cordova 的 IDE 的更多信息，请参阅<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">用于在 Eclipse 中管理 Cordova 项目的 IBM {{site.data.keys.mf_studio }} 插件</a>。</p>

        <p>您可以使用 Apache Maven 或支持 Maven 的 IDE（例如，Eclipse 和 IntelliJ 等）开发适配器。有关开发适配器的更多信息，请参阅<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">适配器类别</a>。有关使用 Eclipse 作为启用了 Maven 的 IDE 的更多信息，请阅读<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">在 Eclipse 中开发适配器教程</a>。</p>

        <p>安装 {{ site.data.keys.mf_dev_kit_full }}  以使用 {{site.data.keys.mf_server }} 测试适配器和应用程序。如果您不希望从诸如 NPM、Maven、Cocoapod 或 NuGet 等基于因特网的存储库中进行下载，也可以直接访问 {{ site.data.keys.product_adj }}    开发工具和 SDK。有关 {{site.data.keys.mf_dev_kit }} 的更多信息，请参阅<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{site.data.keys.mf_dev_kit }}</a>。</p>
        </td>
    </tr>
    <tr>
        <td><p>对于混合应用程序，已废弃了皮肤、Shell、“设置”页面、压缩以及 JavaScript UI 元素。</p></td>
        <td><p>已废弃。直接使用 Apache Cordova 开发混合应用程序。有关替换皮肤、Shell、“设置”页面和压缩的更多信息，请参阅“已除去的组件和比较使用 V8.0 和 V7.1 及更早版本开发的 Cordova 应用程序”。</p>
        </td>
    </tr>
    <tr>
        <td><p>对于混合应用程序，无法再将 Sencha Touch 导入到 {{ site.data.keys.product_adj }}    项目。</p></td>
        <td><p>已废弃。直接使用 Apache Cordova 来开发 {{ site.data.keys.product_adj }} 混合应用程序，并且提供 {{ site.data.keys.product_adj }} 功能作为 Cordova 插件。请参阅 Sencha Touch 文档以集成 Sencha Touch 和 Cordova。</p>
        </td>
    </tr>
    <tr>
        <td><p>已废弃了加密高速缓存。</p></td>
        <td><p>已废弃。要在本地存储加密数据，请使用 JSONStore。有关 JSONStore 的更多信息，请参阅 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">JSONStore 教程</a>。</p>
        </td>
    </tr>
    <tr>        
        <td><p>在 V8.0 中未提供按需触发“直接更新”。客户机应用程序会在获取会话的 OAuth 令牌时检查是否有“直接更新”。在 V8.0 中，无法将客户机应用程序以编程方式设定为在不同时间点检查是否有“直接更新”。</p></td>
        <td><p>在 V8.0 中未提供。</p></td>
    </tr>
    <tr>
        <td><p>具有会话依赖性配置的适配器。在 V7.1.0 中，您可以将 {{site.data.keys.mf_server }} 配置为在会话独立方式（缺省值）或会话依赖方式下工作。从 V8.0 开始，不再支持会话依赖方式。服务器本身独立于 HTTP 会话，不需要任何相关配置。</p></td>
        <td><p>已废弃。</p></td>
    </tr>
    <tr>
        <td><p>V8.0 中不支持基于 IBM WebSphere eXtreme Scale 的属性存储。</p></td>
        <td><p>在 V8.0 中未提供。</p></td>
    </tr>
    <tr>
        <td><p>在 V8.0 中未提供针对 IBM Business Process Manager (IBM BPM) 流程应用程序的服务发现和适配器生成功能、Microsoft Azure Marketplace DataMarket、OData RESTful API、RESTful 资源、SAP Netweaver Gateway 公开的服务以及 Web Service。</p></td>
        <td><p>在 V8.0 中未提供。</p></td>
    </tr>
    <tr>
        <td>在 V8.0 中未提供 JMS JavaScript 适配器。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中未提供 SAP Gateway JavaScript 适配器。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中未提供 SAP JCo JavaScript 适配器。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中未提供 Cast Iron JavaScript 适配器。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中未提供 OData 和 Microsoft Azure OData JavaScript 适配器。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中不支持针对 USSD 的推送通知支持。</td>
        <td>已废弃。</td>
    </tr>
    <tr>
        <td>在 V8.0 中不支持基于事件的推送通知。</td>
        <td>已废弃。使用推送通知服务。有关迁移至推送通知服务的更多信息，请参阅“从基于事件源的通知迁移到推送通知”主题。</td>
    </tr>
    <tr>
      <td>
        安全性：在 V8.0 中不需要反跨站点请求伪造 (anti-XSRF) 域 (<code>wl_antiXSRFRealm</code>)。
      </td>
      <td>
        在 V7.1.0 中，认证上下文存储在 HTTP 会话中并以跨站点请求中的浏览器发送的会话 cookie 来标识。该版本中的反 XSRF 域用于通过使用从客户机发送到服务器的其他头来保护 cookie 传输，防御 XSRF 攻击。
        <br/>
        在 V8.0.0 中，安全上下文不再与 HTTP 会话相关联，并且不以会话 cookie 来标识。
        而改为使用认证头中传递的 OAuth 2.0 访问令牌来完成授权。
        由于授权头不再由跨站点请求中的浏览器发送，无需防御 XSRF 攻击。
      </td>
    </tr>
    <tr>
        <td>安全性：用户证书认证。V8.0 不包含任何预定义的安全性检查以通过 X.509 客户端证书认证用户。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>安全性：与 IBM Trusteer 集成。V8.0 不包含任何预定义的安全性检查或提问以测试 IBM Trusteer 风险因素。</td>
        <td>在 V8.0 中未提供。使用 IBM Trusteer Mobile SDK。</td>
    </tr>
    <tr>
        <td>安全性：设备供应和设备自动供应。</td>
        <td><p>已废弃。</p><p> 注：在正常授权流中处理设备供应。将在安全流的注册过程中自动收集设备数据。有关安全流的更多信息，请参阅“端到端授权流”。</p>
        </td>
    </tr>
    <tr>
        <td>安全性：用于通过 ProGuard 对 Android 代码进行模糊处理的配置文件。V8.0 不包含预定义的 proguard-project.txt 配置文件，该配置文件用于对 MobileFirst Android 应用程序进行 Android ProGuard 模糊处理。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>安全性：将替换基于适配器的认证。认证将使用 OAuth 协议，并通过安全性检查来实现。</td>
        <td>替换为基于安全性检查的实现。</td>
    </tr>
    <tr>
        <td><p>安全性：LDAP 登录。V8.0 不包含任何预定义的安全性检查以使用 LDAP 服务器认证用户。</p>
        <p>但是，对于 WebSphere Application Server 或 WebSphere Application Server Liberty，将使用应用程序服务器或网关以将 LDAP 等身份提供者映射至 LTPA，并使用 LTPA 安全性检查为用户生成 OAuth 令牌。</p></td>
        <td>在 V8.0 中未提供。替换为 WebSphere Application Server 或 WebSphere Application Server Liberty 的 LTPA 安全性检查。</td>
    </tr>
    <tr>
        <td>
        HTTP 适配器的认证配置。预定义的 HTTP 适配器不支持以用户身份连接到远程服务器。</td>
        <td><p>在 V8.0 中未提供。</p><p>编辑 HTTP 适配器的源代码并添加认证代码。使用 <code>MFP.Server.invokeHttp</code> 将标识令牌添加到 HTTP 请求头中。</p></td>
    </tr>
    <tr>
        <td>
        在 V8.0 中未提供安全分析功能，此功能可通过 MobileFirst Analytics Console 监控 MobileFirst 安全框架的事件。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>已废弃了用于推送通知的基于事件源的模型，将其替换为基于标记的推送服务模型。</td>
        <td>已废弃，将其替换为基于标记的推送服务模型。</td>
    </tr>
    <tr>
        <td>V8.0 中不支持非结构化补充服务数据 (USSD)。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>在 V8.0 中不支持将 Cloudant 用作 {{site.data.keys.mf_server }} 的数据库。</td>
        <td>在 V8.0 中未提供。</td>
    </tr>
    <tr>
        <td>地理定位：在 {{ site.data.keys.product }}    V8.0 中已废弃了地理定位支持。已废弃针对信标和介体的 REST API。已废弃客户端和服务器端 API WL.Geo 和 WL.Device。</td>
        <td>已废弃。将本机设备 API 或第三方 Cordova 插件用于地理定位。</td>
    </tr>
    <tr>
        <td>已废弃 {{ site.data.keys.product_adj }}    数据代理功能。也废弃了 Cloudant IMFData 和 CloudantToolkit API。</td>
        <td>已废弃。有关替换您的应用程序中的 IMFData 和 CloudantToolkit API 的更多信息，请参阅“迁移通过 IMFData 或 Cloudant </td>
    </tr>
    <tr>
        <td>IBM Tealeaf SDK 不再与 {{ site.data.keys.product }}    捆绑在一起。</td>
        <td>已废弃。使用 IBM Tealeaf SDK。有关更多信息，请参阅 IBM Tealeaf Customer Experience 文档中的 <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a> 和 <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a>。</td>
    </tr>
    <tr>
        <td>{{site.data.keys.mf_test_workbench_full }} 未与 {{ site.data.keys.product }}    捆绑在一起。</td>
        <td>已废弃。</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.product }}    V8.0 不支持 BlackBerry、Adobe AIR 和 Windows Silverlight。没有为这些平台提供 SDK。</td>
        <td>已废弃。</td>
    </tr>
</table>

## 服务器端 API 更改
{: #server-side-api-changes}

要迁移 {{ site.data.keys.product_adj }}    应用程序的服务器端，请考虑对 API 的更改。  
以下各表列出了 V8.0 中停用服务器端 API 元素、V8.0 中不推荐使用的服务器端 API 元素以及建议的迁移路径。有关迁移应用程序服务器端的更多信息，

### V8.0 中停用的 JavaScript API 元素
{: #javascript-api-elements-discontinued-v-v-80 }
#### 安全性
{: #security }

| API 元素                         | 替换路径                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUser`、`WL.Server.getCurrentUserIdentity`、`WL.Server.getCurrentDeviceIdentity`、`WL.Server.setActiveUser`、`WL.Server.getClientId`、`WL.Server.getClientDeviceContext`、`WL.Server.setApplicationContext` | 改为使用 `MFP.Server.getAuthenticatedUser`。 |

#### 事件源
{: #event-source }

| API 元素                         | 替换路径                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | 改为使用 `MFP.Server.getAuthenticatedUser`。 |
| `WL.Server.setEventHandlers`         | 要从基于事件源的通知迁移到基于标记的通知，请参阅“从基于事件源的通知迁移到推送通知”。                                                     |
| `WL.Server.createEventHandler`       |                                                |
| `WL.Server.createSMSEventHandler`	 | 要发送 SMS 消息，请使用推送服务 REST API。有关更多信息，请参阅[发送通知](../../../notifications/sending-notifications)。                         |
| `WL.Server.createUSSDEventHandler`	 | 通过使用第三方服务来集成 USSD。  |

#### 推送
{: #push }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`、`WL.Server.notifyAllDevices`、`WL.Server.sendMessage`、`WL.Server.notifyDevice`、`WL.Server.notifyDeviceSubscription`、`WL.Server.notifyAll`、`WL.Server.createDefaultNotification`、`WL.Server.submitNotification` 	| 要从基于事件源的通知迁移到基于标记的通知，请参阅“从基于事件源的通知迁移到推送通知”。 |
| `WL.Server.subscribeSMS`	                | 使用 REST API 推送设备注册 (POST) 来注册设备。要发送和接收 SMS 通知，请在调用 API 时在有效内容中提供 phoneNumber。                               |
| `WL.Server.unsubscribeSMS`	                | 使用 REST API 推送设备注册 (DELETE) 来取消注册设备。 |
| `WL.Server.getSMSSubscription`	            | 使用 REST API 推送设备注册 (GET) 来获取设备注册。 |

#### 定位服务
{: #location-services }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | 通过使用第三方服务来集成位置服务。 |

#### WS-Security
{: #ws-security }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | 使用 WebSphere Application Server 的 WS-Security 功能。 |

### V8.0 中停用的 Java API 元素
{: #java-api-elements-discontinued-in-v-80 }
#### 安全性
{: #security-java }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | 改为使用 AdapterSecurityContext。            |

#### 推送
{: #push-java }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| 要从基于事件源的通知迁移到基于标记的通知，请参阅“从基于事件源的通知迁移到推送通知”。 |
| `INotification PushAPI.buildNotification();` | 要从基于事件源的通知迁移到基于标记的通知，请参阅“从基于事件源的通知迁移到推送通知”。 |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | 要从基于事件源的通知迁移到基于标记的通知，请参阅“从基于事件源的通知迁移到推送通知”。 |

#### 适配器
{: #adapters-java }

| API 元素                                | 替换路径                               |
|-------------------------------------------|------------------------------------------------|
| `com.worklight.adapters.rest.api 包`中的 `AdaptersAPI` 接口 | 改用 `com.ibm.mfp.adapter.api` 包中的 `AdaptersAPI` 接口。 |
| `com.worklight.adapters.rest.api` 包中的 `AnalyticsAPI` 接口 | 改用 `com.ibm.mfp.adapter.api` 包中的 `AnalyticsAPI` 接口。 |
| `com.worklight.adapters.rest.api` 包中的 `ConfigurationAPI` 接口 | 改用 `com.ibm.mfp.adapter.api` 包中的 `ConfigurationAPI` 接口。 |
| `com.worklight.core.auth` 包中的 `OAuthSecurity` 注释 | 改用 `com.ibm.mfp.adapter.api` 包中的 `OAuthSecurity` 注释。 |
| `com.worklight.wink.extensions` 包中的 `MFPJAXRSApplication` 类 | 改用 `com.ibm.mfp.adapter.api` 包中的 `MFPJAXRSApplication` 类。 |
| `com.worklight.adapters.rest.api` 包中的 `WLServerAPI` 接口 | 使用 JAX-RS `Context` 注释直接访问 {{ site.data.keys.product_adj }}    API 接口。 |
| `com.worklight.adapters.rest.api` 包中的 `WLServerAPIProvider` 类 | 使用 JAX-RS `Context` 注释直接访问 {{ site.data.keys.product_adj }}    API 接口。 |

## 客户端 API 更改
{: #client-side-api-changes}

API 中的以下更改与迁移 {{ site.data.keys.product_adj }}    客户机应用程序有关。  
以下各表列出了 V8.0.0 中停用的客户端 API 元素、V8.0.0 中不推荐使用的客户端 API 元素以及建议的迁移路径。

### JavaScript API
{: #javascript-apis }
影响用户接口的这些 JavaScript API 在 V8.0 中不再受支持。可以使用可用的第三方 Cordova 插件或通过创建定制 Cordova 插件对其进行替换。

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WL.BusyIndicator`、`WL.OptionsMenu`、`WL.TabBar`、`WL.TabBarItem` | 使用 Cordova 插件或 HTML 5 元素。 |
| `WL.App.close` | 在 {{ site.data.keys.product_adj }}    外处理此事件。 |
| `WL.App.copyToClipboard()` | 使用提供此功能的 Cordova 插件。 |
| `WL.App.openUrl(url, target, options)` | 使用提供此功能的 Cordova 插件。**注：**供您参考：Cordova **InAppBrowser** 插件提供此功能。 |
| `WL.App.overrideBackButton(callback)`、`WL.App.resetBackButton()` | 使用提供此功能的 Cordova 插件。**注：**供您参考：Cordova **backbutton** 插件提供此功能。 |
| `WL.App.getDeviceLanguage()` | 使用提供此功能的 Cordova 插件。**注：**供您参考：Cordova **cordova-plugin-globalization** 插件提供此功能。 |
| `WL.App.getDeviceLocale()` | 使用提供此功能的 Cordova 插件。**注：**供您参考：Cordova **cordova-plugin-globalization** 插件提供此功能。 |
| `WL.App.BackgroundHandler` | 要运行定制处理程序函数，请使用标准 Cordova 暂停事件侦听器。使用可提供隐私并防止 iOS 和 Android 系统与用户拍摄快照或截屏的 Cordova 插件。有关更多信息，请参阅 **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)** 的描述。 |
| `WL.Client.close`、`WL.Client.restore`、`WL.Client.minimize` | 提供了这些功能以支持 {{ site.data.keys.product }}    V8.0.0 不支持的 Adobe AIR 平台。 |
| `WL.Toast.show(string)` | 将 Cordova 插件用于 Toast。 |

此 API 集在 V8.0 中不再受支持。

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WL.Client.checkForDirectUpdate(options)` | 无替换。**注：**您可以调用 `WLAuthorizationManager.obtainAccessToken` 以触发可用的“直接更新”。访问安全性令牌会触发服务器上可用的“直接更新”。但无法根据需要触发“直接更新”。 |
| `WL.Client.setSharedToken({key: myName, value: myValue})`、`WL.Client.getSharedToken({key: myName})`、`WL.Client.clearSharedToken({key: myName})` | 无替换。 |
| `WL.Client.isConnected()`、`connectOnStartup` init option | 使用 `WLAuthorizationManager.obtainAccessToken` 检查服务器连接并实施应用程序管理规则。 |
| `WL.Client.setUserPref(key,value, options)`、`WL.Client.setUserPrefs(userPrefsHash, options)`、`WL.Client.deleteUserPrefs(key, options)` | 无替换。您可以使用适配器和 `MFP.Server.getAuthenticatedUser` API 管理用户首选项。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 无替换。 |
| `WL.Client.logActivity(activityType)` | 使用 `WL.Logger`。 |
| `WL.Client.login(realm, options)` | 使用 `WLAuthorizationManager.login`。有关认证和安全的入门信息，请参阅“认证和安全”教程。 |
| `WL.Client.logout(realm, options)` | 使用 `WLAuthorizationManager.logout`。 |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | 使用 `WLAuthorizationManager.obtainAccessToken`。 |
| `WL.Client.transmitEvent(event, immediate)`、`WL.Client.purgeEventTransmissionBuffer()`、`WL.Client.setEventTransmissionPolicy(policy)` | 为接收这些事件的通知创建定制适配器。 |
| `WL.Device.getContext()`、`WL.Device.startAcquisition(policy, triggers, onFailure)`、`WL.Device.stopAcquisition()`、`WL.Device.Wifi`、`WL.Device.Geo.Profiles`、`WL.Geo` | 使用本机 API 或第三方 Cordova 插件进行地理定位。 |
| `WL.Client.makeRequest (url, options)` | 创建提供同一功能的定制适配器。 |
| `WLDevice.getID(options)` | 使用提供此功能的 Cordova 插件。**注：**供您参考：来自 c**ordova-plugin-device** 的 `device.uuid` 插件提供此功能。 |
| `WL.Device.getFriendlyName()` | 使用 `WL.Client.getDeviceDisplayName` |
| `WL.Device.setFriendlyName()` | 使用 `WL.Client.setDeviceDisplayName` |
| `WL.Device.getNetworkInfo(callback)` | 使用提供此功能的 Cordova 插件。**注：**供您参考：**cordova-plugin-network-information** 插件提供此功能。 |
| `WLUtils.wlCheckReachability()` | 创建用于检查服务器可用性的定制适配器。 |
| `WL.EncryptedCache` | 使用 JSONStore 以在本地存储加密数据。JSONStore 位于 **cordova-plugin-mfp-jsonstore** 插件中。有关更多信息，请参阅 [JSONStore](../../../application-development/jsonstore)。 |
| `WL.SecurityUtils.remoteRandomString(bytes)` | 创建提供同一功能的定制适配器。 |
| `WL.Client.getAppProperty(property)` | 可以通过使用 **cordova-plugin-appversion** 插件来检索应用程序版本属性。所返回的版本是本机应用程序版本（仅限 Android 和 iOS）。 |
| `WL.Client.Push.*` | 使用 **cordova-plugin-mfp-push** 插件中的 JavaScript 客户端推送 API。 |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | 使用 `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)` 以针对推送和 SMS 注册设备。 |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | 使用 `WLAuthorizationManager.obtainAccessToken` 以获取所需作用域的令牌。 |
| `WLClient.getLastAccessToken(scope)` | 使用 `WLAuthorizationManager.obtainAccessToken` |
| `WLClient.getLoginName()`、`WL.Client.getUserName(realm)` | 无替换 |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | 使用 `WLAuthorizationManager.isAuthorizationRequired` 和 `WLAuthorizationManager.getResourceScope`。 |
| `WL.Client.isUserAuthenticated(realm)` | 无替换 |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | 无替换 |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | 无替换 |
| `WL.Client.createChallengeHandler(realmName)` | 要创建验证问题处理程序来处理定制网关验证问题，请使用 `WL.Client.createGatewayChallengeHandler(gatewayName)`。要创建验证问题处理程序来处理 {{ site.data.keys.product_adj }}    安全性检查验证问题，请使用 `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`。 |
| `WL.Client.createWLChallengeHandler(realmName)` | 使用 `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`。 |
| `challengeHandler.isCustomResponse()`，其中 challengeHandler 是 `WL.Client.createChallengeHandler()` 返回的验证问题处理程序对象 | 使用 `gatewayChallengeHandler.canHandleResponse()`，其中 `gatewayChallengeHandler` 是 `WL.Client.createGatewayChallengeHandler()` 返回的验证问题处理程序对象。 |
| `wlChallengeHandler.processSucccess()`，其中 `wlChallengeHandler` 是 `WL.Client.createWLChallengeHandler()` 返回的验证问题处理程序对象 | 使用 `securityCheckChallengeHandler.handleSuccess()`，其中 `securityCheckChallengeHandler` 是 `WL.Client.createSecurityCheckChallengeHandler()` 返回的验证问题处理程序对象。 |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | 在验证问题处理程序中实施类似逻辑。对于定制网关验证问题处理程序，请使用 `WL.Client.createGatewayChallengeHandler()` 返回的验证问题处理程序对象。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题处理程序，请使用 `WL.Client.createSecurityCheckChallengeHandler()` 返回的验证问题处理程序对象。 |
| `WL.Client.createProvisioningChallengeHandler()` | 无替换。设备供应现在由安全框架自动处理。 |

#### 不推荐的 JavaScript API
{: #deprecated-javascript-apis }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`、`WL.Client.invokeProcedure(invocationData, options)`、`WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`、`WLProcedureInvocationResult` | 改为使用 `WLResourceRequest`。**注：**`invokeProcedure` 的实现使用 `WLResourceRequest`。 |
| `WLClient.getEnvironment` | 使用提供此功能的 Cordova 插件。**注：**供您参考：**device.platform** 插件提供此功能。 |
| `WLClient.getLanguage` | 使用提供此功能的 Cordova 插件。**注：**供您参考：**cordova-plugin-globalization** 插件提供此功能。 |
| `WL.Client.connect(options)` | 使用 `WLAuthorizationManager.obtainAccessToken` 检查服务器连接并实施应用程序管理规则。 |

### Android API
{: #android-apis}
####  停用的 Android API 元素
{: #discontinued-android-api-elements }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WLConfig WLClient.getConfig()` | 无替换。 |
| `WLDevice WLClient.getWLDevice()`、`WLClient.transmitEvent(org.json.JSONObject event)`、`WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`、`WLClient.purgeEventTransmissionBuffer()` | 使用 Android API 或第三方软件包进行地理定位。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 无替换。 |
| `WL.Client.getUserInfo(realm, key`、`WL.Client.updateUserInfo(options)` | 无替换。 |
| `WLClient.checkForNotifications()` | 使用 `WLAuthorizationManager.obtainAccessToken("", listener)` 检查服务器连接并实施应用程序管理规则。 |
| `WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`、`WLClient.login(java.lang.String realmName, WLRequestListener listener)` | 使用 `AuthorizationManager.login()` |
| `WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`、`WLClient.logout(java.lang.String realmName, WLRequestListener listener)` | 使用 `AuthorizationManager.logout()` |
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener
| `WLClient.getLastAccessToken()`、`WLClient.getLastAccessToken(java.lang.String scope)` | 使用 `AuthorizationManager` |
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | 使用 `AuthorizationManager` |
| `WLClient.logActivity(java.lang.String activityType)` | 使用 `com.worklight.common.Logger`。有关更多信息，请参阅“记录器 SDK”。 |
| `WLAuthorizationPersistencePolicy` | 无替换。要实现授权持久性，请在应用程序代码中存储授权令牌并创建定制 HTTP 请求。 |
| `WLSimpleSharedData.setSharedToken(myName, myValue)`、`WLSimpleSharedData.getSharedToken(myName)`、`WLSimpleSharedData.clearSharedToken(myName)` | 使用 Android API 在应用程序之间共享令牌。 |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | 无替换 |
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | 使用 `BaseChallengeHandler.cancel()` |
| `ChallengeHandler` | 对于定制网关验证问题，请使用 `GatewayChallengeHandler`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题，请使用 `SecurityCheckChallengeHandler`。|
| `WLChallengeHandler` | 使用 `SecurityCheckChallengeHandler`。 |
| `ChallengeHandler.isCustomResponse()` | 使用 `GatewayChallengeHandler.canHandleResponse()`。 |
| `ChallengeHandler.submitAdapterAuthentication ` | 在验证问题处理程序中实施类似逻辑。对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler`。|

#### 不推荐的 Android API
{: #deprecated-android-apis }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` | 不推荐使用。使用 `WLResourceRequest`。**注：**`invokeProcedure` 的实现使用 `WLResourceRequest`。 |
| `WLClient.connect(WLResponseListener responseListener)`、`WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` | 使用 `WLAuthorizationManager.obtainAccessToken("", listener)` 检查服务器连接并实施应用程序管理规则。 |

#### 取决于旧 org.apach.http API 的 Android API 不再受支持
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| 现在不推荐使用 `org.apache.http.Header[]`。因此，移除了以下方法：||
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | 改为使用新的 `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API。 |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | 改为使用新的 `WLResourceRequest.addHeader(String name, String value)` API。 |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | 改为使用新的 `List<String> WLResourceRequest.getHeaders(String headerName)` API。 |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | 改为使用新的 `WLResourceRequest.getHeaders(String headerName)` API。 |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | 改为使用新的 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API。 |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | 改为使用新的 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API。 |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | 替换为 `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | 无替换。MFP 客户机允许循环重定向。 |
| `WLHttpResponseListener`、`WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`、`WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`、`WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`、`WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`、`WLResourceRequest.send(WLHttpResponseListener listener)`、`WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`、`WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` | 由于不推荐使用 Apache HTTP 客户机依赖关系而已移除。创建自己的请求，以对请求和响应具有完全控制。 |

#### `com.worklight.androidgap.api` 包为 Cordova 应用程序提供 Android 平台功能。在 {{ site.data.keys.product }}    中，进行了多个更改以适应 Cordova 集成。
{: #comworklightandroidgapapi }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| Android 活动已替换为 Android 上下文。 | |
| `static WL.createInstance(android.app.Activity activity)` | `static WL.createInstance(android.content.Context context)` 创建共享实例。 |
| `static WL.getInstance()` |  `static WL.getInstance()` 获取 WL 类的实例。不能在 `WL.createInstance(Context)` 之前调用此方法。 |

### Objective-C API
{: #objective-c-apis }
#### 停用的 iOS Objective C API
{: #discontinued-ios-objective-c-apis }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `[WLClient getWLDevice][WLClient transmitEvent:]`、`[WLClient setEventTransmissionPolicy]`、`[WLClient purgeEventTransmissionBuffer]` | 已移除地理定位。使用本机 iOS 或第三方软件包进行地理定位。 |
| `WL.Client.getUserInfo(realm, key)`、`WL.Client.updateUserInfo(options)` | 无替换。 |
| `WL.Client.deleteUserPref(key, options)` | 无替换。您可以使用适配器和 `MFP.Server.getAuthenticatedUser` API 管理用户首选项。 |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | 使用 `WLAuthorizationManager obtainAccessTokenForScope`。 |
| `[WLClient login:withDelegate:]` | 使用 `WLAuthorizationManager login`。 |
| `[WLClient logout:withDelegate:]` | 使用 `WLAuthorizationManager logout`。 |
| `[WLClient lastAccessToken]`、`[WLClient lastAccessTokenForScope:]` | 使用 `WLAuthorizationManager obtainAccessTokenForScope`。 |
| `[WLClient obtainAccessTokenForScope:withDelegate:]`、`[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` | 使用 `WLAuthorizationManager obtainAccessTokenForScope`。 |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | 使用来自 IBMMobileFirstPlatformFoundationPush 框架的 iOS 应用程序的 Objective C 客户端推送 API |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | 使用来自 IBMMobileFirstPlatformFoundationPush 框架的 iOS 应用程序的 Objective C 客户端推送 API。 |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | 不推荐使用。改为使用 `WLResourceRequest`。 |
| `WLClient sendUrlRequest:delegate:]` | 改为使用 `[WLResourceRequest sendWithDelegate:delegate]`。 |
| `[WLClient (void) logActivity:(NSString *) activityType]` | 已移除。使用 Objective C 记录器。 |
| `[WLSimpleDataSharing setSharedToken: myName value: myValue]`、`[WLSimpleDataSharing getSharedToken: myName]]`、`[WLSimpleDataSharing clearSharedToken: myName]` | 使用 OS API 在应用程序之间共享令牌。 |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | 使用 `BaseChallengeHandler.cancel()`。 |
| `BaseProvisioningChallengeHandler` | 无替换。设备供应现在由安全框架自动处理。 |
| `ChallengeHandler` | 对于定制网关验证问题，请使用 `GatewayChallengeHandler`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题，请使用 `SecurityCheckChallengeHandler`。|
| `WLChallengeHandler` | 使用 `SecurityCheckChallengeHandler`。 |
| `ChallengeHandler.isCustomResponse()` | 使用 `GatewayChallengeHandler.canHandleResponse()`。 |
| `ChallengeHandler.submitAdapterAuthentication ` | 在验证问题处理程序中实施类似逻辑。对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题处理程序，请使用 `SecurityCheckChallengeHandler`。 |

### Windows C# API
{: #windows-c-apis }
#### 不推荐使用的 Windows C# API 元素 - 类
{: #deprecated-windows-c-api-elements-classes }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `ChallengeHandler` | 对于定制网关验证问题，请使用 `GatewayChallengeHandler`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题，请使用 `SecurityCheckChallengeHandler`。|
| `ChallengeHandler. isCustomResponse()` | 使用 `GatewayChallengeHandler.canHandleResponse()`。 |
| `ChallengeHandler.submitAdapterAuthentication ` | 在验证问题处理程序中实施类似逻辑。对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题处理程序，请使用 `SecurityCheckChallengeHandler`。 |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | 对于定制网关验证问题处理程序，请使用 `GatewayChallengeHandler.Shouldcancel()`。对于 {{ site.data.keys.product_adj }}    安全性检查验证问题处理程序，请使用 `SecurityCheckChallengeHandler.ShouldCancel()`。 |
| `WLAuthorizationManager` | 改用 `WorklightClient.WorklightAuthorizationManager`。 |
| `WLChallengeHandler` | 使用 `SecurityCheckChallengeHandler`。 |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)` | 使用 `SecurityCheckChallengeHandler.ShouldCancel()`。 |
| `WLClient` | 改用 `WorklightClient`。 |
| `WLErrorCode` | 不受支持。 |
| `WLFailResponse` | 改用 `WorklightResponse`。 |
| `WLResponse` | 改用 `WorklightResponse`。 |
| `WLProcedureInvocationData` | 改用 `WorklightProcedureInvocationData`。 |
| `WLProcedureInvocationFailResponse` | 不受支持。 |
| `WLProcedureInvocationResult` | 不受支持。 |
| `WLRequestOptions` | 不受支持。 |
| `WLResourceRequest` | 不受支持。 |

#### 不推荐使用的 Windows C# API 元素 - 接口
{: #deprecated-windows-c-api-elements-interfaces }

| API 元素           | 迁移路径                           |
|-----------------------|------------------------------------------|
| `WLHttpResponseListener` | 不受支持。 |
| `WLResponseListener` | 响应将可用作 `WorklightResponse` 对象 |
| `WLAuthorizationPersistencePolicy` | 不受支持。 |
