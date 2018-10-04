---
layout: tutorial
title: 新增内容
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0 进行了重大更改，极大地改善了您的 {{ site.data.keys.product_adj }} 应用程序开发、部署和管理体验。

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">构建应用程序方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} SDK 和命令行界面已重新设计，使您能够更灵活高效地开发应用程序。 另外，您现在可以在开发跨平台应用程序时使用任何首选的 Cordova 工具。</p>

                <p>查看以下部分，以了解可用于开发应用程序的新功能。</p>

                <h3>新增了开发和部署流程</h3>
                <p>您不再创建需要在应用程序服务器中进行安装的项目 WAR 文件。 只需安装一次 {{ site.data.keys.mf_server }}，然后将应用程序、资源安全性或推送服务的服务器端配置上载到服务器。 您可以使用 {{ site.data.keys.mf_console }} 修改应用程序的配置。</p>

                <p>{{ site.data.keys.product_adj }} 项目不再存在。 而是使用您选择的开发环境来开发移动应用程序。<br/>
                您可以在不停止 {{ site.data.keys.mf_server }} 的情况下修改应用程序和适配器的服务器端配置。</p>

                <ul>
                    <li>有关新开发流程的更多信息，请参阅<a href="../../../application-development/">开发概念和概述</a>。</li>
                    <li>有关迁移现有应用程序的更多信息，请参阅<a href="../../../upgrading/migration-cookbook">迁移手册</a>。</li>
                    <li>有关管理 {{ site.data.keys.product_adj }} 应用程序的更多信息，请参阅“管理 {{ site.data.keys.product_adj }} 应用程序”。</li>
                </ul>

                <h3>Web 应用程序</h3>
                <p>您现在可以使用 {{ site.data.keys.product_adj }} 客户端 JavaScript API，通过首选的工具和 IDE 开发 Web 应用程序。 您可以向 {{ site.data.keys.mf_server }} 注册 Web 应用程序以将安全功能添加到应用程序中。</p>

                <p>您还可以使用新的客户端 JavaScript Web Analytics API（作为新 Web SDK 的一部分提供），以将 {{ site.data.keys.mf_analytics }} 功能添加到 Web 应用程序中。</p>

                <h3>使用首选的 Cordova 工具开发跨平台应用程序</h3>
                <p>您现在可以使用首选的 Cordova 工具（如 Apache Cordova CLI 或 Ionic Framework）开发跨平台混合应用程序。 独立于 {{ site.data.keys.product }} 获取这些工具，然后添加 {{ site.data.keys.product_adj }} 插件以提供 {{ site.data.keys.product_adj }} 后端功能。</p>

                <p>您可以安装 {{ site.data.keys.product }} Studio
Eclipse 插件，以在 Eclipse 开发环境中管理 {{ site.data.keys.product }} 支持的跨平台 Cordova 应用程序。 {{ site.data.keys.product }} Studio 插件还提供了可从 Eclipse 环境内部运行的其他 {{ site.data.keys.mf_cli }} 命令。</p>

                <h3>SDK 组件化</h3>
                <p>之前，将 {{ site.data.keys.product_adj }} 客户机 SDK 作为单框架或 JAR 文件提供。 您现在可以选择包含或排除特定功能。 除了核心 SDK 之外，每个 {{ site.data.keys.product_adj }} API 还具有自己的可选组件集。</p>

                <h3>新增了改进的开发命令行界面 (CLI)</h3>
                <p>{{ site.data.keys.mf_cli }} 已重新设计，可实现更高的开发效率，包括用于自动化脚本。 命令现在以前缀 mfpdev 开头。 CLI 包含在 {{ site.data.keys.mf_dev_kit_full }} 中，或者您可以从 npm 快速下载最新版本的 CLI。</p>

                <h3>迁移辅助工具</h3>
                <p>迁移辅助工具可简化将现有应用程序迁移到 {{ site.data.keys.product }}V8.0 的过程。 该工具会扫描现有 {{ site.data.keys.product_adj }} 应用程序，并创建 V8.0 中除去、不推荐使用或更换的文件中使用的 API 的列表。 在使用 {{ site.data.keys.product }} 创建的 Apache Cordova 应用程序上运行迁移辅助工具时，它会为符合 V8.0 要求的应用程序创建新的 Cordova 结构。 有关迁移辅助工具的更多信息，请参阅：</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>自 Cordova 4.0 开始，可插式 WebView 允许替换缺省 Web 运行时。 Cordova 应用程序和 {{ site.data.keys.product }} 现在支持 Crosswalk。 使用 Crosswalk WebView for Android 支持在各种移动设备中获得高性能且始终如一的用户体验。 要利用 Crosswalk 功能，请应用 Cordova Crosswalk 插件。</p>

                <h3>通过 NuGet 分发针对 Windows 8 和 Windows 10 通用应用程序的 {{ site.data.keys.product_adj }} SDK</h3>
                <p>通过位于以下地址的 NuGet 提供针对 Windows 8 和 Windows 10 通用应用程序的 {{ site.data.keys.product_adj }} SDK：<a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>。 要开始操作，</p>

                <h3>org.apache.http 被替换为 okHttp</h3>
                <p>已从 Android SDK 中除去 <code>org.apache.http</code>。 okHttp 将用作 http 依赖关系。</p>

                <h3>针对 iOS 混合 Cordova 应用程序的 WKWebView 支持</h3>
                <p>您现在可以将 Cordova 应用程序中的缺省 UIWebView 替换为 WKWebView。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">MobileFirst API 方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>新功能改进并扩展可用于开发移动应用程序的 API。 通过最新的 API 来利用 {{ site.data.keys.product }} 中的新功能、已改进的功能或已更改的功能。</p>

                <h3>已更新的 JavaScript 服务器端 API</h3>
                <p>仅对受支持的适配器类型支持后端调用功能。 目前仅支持 HTTP 和 SQL 适配器，因此也支持后端调用程序 <code>WL.Server.invokeHttp</code> 和 <code>WL.Server.invokeSQL</code>。</p>

                <h3>新的 Java 服务器端 API</h3>
                <p>提供新的 Java 服务器端 API，此 API 可用于扩展 {{ site.data.keys.mf_server }}。</p>

                <h4>新增了针对安全性的 Java 服务器端 API</h4>
                <p>新的安全性 API 包 <code>com.ibm.mfp.server.security.external</code> 及其包含的包中提供开发安全性检查所需的接口以及使用安全性检查上下文的适配器。</p>

                <h4>新增了针对客户机注册数据的 Java 服务器端 API</h4>
                <p>新的客户机注册数据 API 包 <code>com.ibm.mfp.server.registration.external</code> 及其包含的包中提供可访问持久存储的 {{ site.data.keys.product_adj }} 客户机注册数据的接口。</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>利用该新 API，您可以返回适配器的 JAX-RS 应用程序。</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>利用该新 API，您可以从适配器配置中获取值（或缺省值）。</p>

                <h3>已更新的 Java 服务器端 API</h3>
                <p>提供已更新的 Java 服务器端 API，此 API 可用于扩展 {{ site.data.keys.mf_server }}。</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>未在此版本中更改此新 API 的特征符。 但是，其行为现在与 <code>String getPropertyValue (String propertyName)</code>（如“新的 Java 服务器端 API”中所述）的行为相同。</p>

                <h4>WLServerAPIProvider</h4>
                <p>在 V7.0.0 和 V7.1.0 中，可通过 WLServerAPIProvider 接口访问 Java API。 例如：<code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> 和 <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>这些静态接口仍受支持，以允许编译和部署在先前版本的产品中开发的适配器。 不使用推送通知或旧安全性 API 的旧适配器将在新版本中继续可用。 使用推送通知或旧安全性 API 的适配器将中断。</p>

                <h3>针对 Web 应用程序的 JavaScript 客户端 API</h3>
                <p>用于开发跨平台 Cordova 应用程序的 JavaScript 客户端 API 现在还可用于开发 Web 应用程序，只在初始化方法上略有不同。 请注意，并非所有的 JavaScript API 功能都适用于 Web 应用程序。</p>

                <p>此外，还提供了新的 JavaScript 客户端 Web Analytics API，用于向 Web 应用程序添加 {{ site.data.keys.mf_analytics }} 功能。</p>

                <h3>针对 Windows 8 Universal 和 Windows Phone 8 Universal 的已更新 C# 客户端 API</h3>
                <p>已更改了针对 Windows 8 Universal 和 Windows Phone 8 Universal 的 C# 客户端 API。</p>

                <h3>针对 Android 的新 Java 客户端 API</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>通过此新方法，您可以从 {{ site.data.keys.mf_server }} 注册数据中获取设备的显示名称。</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>通过此新方法，您可以在 {{ site.data.keys.mf_server }} 注册数据中设置设备的显示名称。</p>

                <h3>针对 iOS 的新 Objective-C 客户端 API</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>通过此新方法，您可以从 {{ site.data.keys.mf_server }} 注册数据中获取设备的显示名称。</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>通过此新方法，您可以在 {{ site.data.keys.mf_server }} 注册数据中设置设备的显示名称。</p>

                <h3>管理服务的更新后的 REST API</h3>
                <p>部分重构了管理服务的 REST API。 特别需要指出的是，除去了信标和介体的 API，针对推送通知的大多数 REST 服务现在属于推送服务的 REST API 的一部分。</p>

                <h3>运行时的更新后的 REST API</h3>
                <p>{{ site.data.keys.product_adj }} 运行时的 REST API 现在为移动式客户机和保密客户机提供多个服务，以调用适配器、获取访问令牌以及获取直接更新内容等。 大多数 REST API 端点受 OAuth 保护。 在开发服务器上，您可以在以下位置查看运行时 API 的 Swagger 文档：<code>http(s)://server_ip:server_port/context_root/doc</code>。</p>

                <h3>多证书锁定支持</h3>
                <p>从 iFix 8.0.0.0-IF201706240159 开始，{{ site.data.keys.mf_bm_short }} 支持锁定多个证书。 这使得用户能够安全访问多个主机。 在此 iFix 之前，{{ site.data.keys.mf_bm_short }} 支持锁定单个证书。 {{ site.data.keys.mf_bm_short }} 引入了一个新 API，通过允许用户将多个 X509 证书（购买自认证中心）的公用密钥锁定到客户机应用程序，来允许连接到多个主机。 应将所有证书的副本放置在您的客户机应用程序中。 在 SSL 握手期间，{{ site.data.keys.product_full }} 客户机 SDK 将验证服务器证书的公用密钥与存储在应用程序中的某个证书的公用密钥是否匹配。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">MobileFirst 安全性方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>完全重新设计了 {{ site.data.keys.product }} 中的安全框架。 引入了新的安全功能，并对现有功能进行了一些修改。</p>

                <h3>安全框架检修</h3>
                <p>重新设计和重新实施了 {{ site.data.keys.product_adj }} 安全框架，以改善和简化安全开发和管理任务。 此框架现在本身基于 OAuth 模型，实施独立于会话。 请参阅“{{ site.data.keys.product_adj }} 安全框架概述”。</p>

                <p>在服务器端，框架的多个构建块被替换为安全性检查（在适配器中实施），可使用新 API 简化开发。 提供样本实施和预定义的安全性检查。 请参阅“安全性检查”。 可以在适配器描述符中配置安全性检查，并且可以通过进行运行时适配器或应用程序配置更改来定制安全性检查，而无需重新部署适配器或中断流。 可以通过重新设计的 {{ site.data.keys.mf_console }} 安全接口来完成配置。 还可以手动或者使用 {{ site.data.keys.mf_cli }} 或 mfpadm 工具来编辑配置文件。</p>

                <h3>应用程序真实性安全检查</h3>
                <p>{{ site.data.keys.product_adj }} 应用程序真实性验证现在作为预定义的安全性检查实施，替换先前的“扩展应用程序真实性检查”。 您可以使用 {{ site.data.keys.mf_console }} 或 mfpadm 动态启用、禁用和配置应用程序真实性验证。 提供独立的 {{ site.data.keys.product_adj }} 应用程序真实性 Java 工具 (mfp-app-authenticity-tool.jar)，用于生成应用程序真实性文件。</p>

                <h3>保密客户机</h3>
                <p>使用新的 OAuth 安全框架重新设计和重新实施了保密客户机支持。</p>

                <h3>Web 应用程序安全性</h3>
                <p>已修订的基于 OAuth 的安全框架支持 Web 应用程序。 您现在可以向 {{ site.data.keys.mf_server }} 注册 Web 应用程序以将安全功能添加到应用程序中，并保护对 Web 资源的访问。 有关开发 {{ site.data.keys.product_adj }} Web 应用程序的更多信息，请参阅“开发 Web 应用程序”。 Web 应用程序不支持应用程序真实性安全性检查。</p>

                <h3>跨平台应用程序（Cordova 应用程序）的新增和改进的安全功能</h3>
                <p>提供额外的安全功能，帮助保护您的 Cordova 应用程序。这些功能包括：</p>

                <ul>
                    <li>Web 资源加密：使用此功能对 Cordova 软件包中的 Web 资源加密，有助于防止他人修改软件包。</li>
                    <li>Web 资源校验和：使用此功能运行校验和测试，以将应用程序的 Web 资源的当前统计信息与首次打开时建立的基线统计信息进行比较。 此校验有助于防止他人在安装和打开应用程序后修改应用程序。</li>
                    <li>证书锁钉：使用此功能将应用程序的证书与主机服务器上的证书关联。 此功能有助于防止应用程序与服务器之间传递的信息被查看或修改。</li>
                    <li>支持联邦信息处理标准 (FIPS) 140-2：使用此功能确保传输的数据遵守 FIPS 140-2 加密标准。</li>
                    <li>OpenSSL：要针对 iOS 平台对 Cordova 应用程序使用 OpenSSL 数据加密和解密，可以使用 cordova-plugin-mfp-encrypt-utils Cordova 插件。</li>
                </ul>

                <h3>设备单点登录</h3>
                <p>现在通过新的预定义 <code>enableSSO</code> 安全性检查应用程序描述符配置属性方式来支持设备单点登录 (SSO)。</p>

                <h3>直接更新</h3>
                <p>同早期版本的 {{ site.data.keys.product_adj }} 相比，从 V8.0 开始</p>

                <ul>
                    <li>如果客户机应用程序访问不受保护的资源，那么应用程序不会接收更新，即使更新在 {{ site.data.keys.mf_server }} 上可用。</li>
                    <li>激活直接更新后，将对受保护资源的每个请求实施直接更新。</li>
                </ul>

                <h3>外部资源保护</h3>
                <p>修改了受支持的方法和提供的用于保护外部服务器上资源的工件：</p>

                <ul>
                    <li>提供新的可配置的 {{ site.data.keys.product_adj }} Java 令牌验证器访问令牌验证模块，以便使用 {{ site.data.keys.product_adj }} 安全框架保护任何外部 Java 服务器上的资源。 该模块作为 Java 库 (mfp-java-token-validator-8.0.0.jar) 提供，将替换使用废弃的 {{ site.data.keys.mf_server }} 令牌验证端点来创建定制的 Java 验证模块。</li>
                    <li>{{ site.data.keys.product_adj }} OAuth 信任关联拦截器 (TAI) 过滤器（用于保护外部 WebSphere Application Server 或 WebSphere Application Server Liberty 服务器上的 Java 资源）现在作为 Java 库 (com.ibm.imf.oauth.common_8.0.0.jar) 提供。 该库使用新的 Java 令牌验证器验证模块，并且所提供 TAI 的配置已更改。</li>
                    <li>不再需要服务器端 {{ site.data.keys.product_adj }} OAuth
TAI API，已将其除去。</li>
                    <li>已修改用于保护外部 Node.js 服务器上 Java 资源的 passport-mfp-token-validation {{ site.data.keys.product_adj }} Node.js 框架，以支持新的安全框架。</li>
                    <li>对于使用授权服务器的新自省端点的任何类型的资源服务器，您还可以编写自己的定制过滤器和验证模块。</li>
                </ul>

                <h3>与作为授权服务器的 WebSphere DataPower 集成</h3>
                <p>您现在可以选择使用 WebSphere DataPower 作为 OAuth 授权服务器，而非使用缺省的 {{ site.data.keys.mf_server }} 授权服务器。 您可以将 DataPower 配置为与 {{ site.data.keys.product_adj }} 安全框架集成。</p>

                <h3>基于 LTPA 的单点登录 (SSO) 安全性检查</h3>
                <p>通过使用新的预定义的基于 LTPA 的单点登录 (SSO) 安全性检查，支持在使用 WebSphere 轻量级第三方认证 (LTPA) 的服务器中共享用户认证。 此检查将替换废弃的 {{ site.data.keys.product_adj }} LTPA 域，并且将消除先前的所需配置。</p>

                <h3>使用 {{ site.data.keys.mf_console }} 进行移动应用程序管理</h3>
                <p>进行了一些更改，以支持通过 {{ site.data.keys.mf_console }} 跟踪和管理移动应用程序、用户和设备。 阻止设备或应用程序访问仅适用于尝试访问受保护的资源。</p>

                <h3>{{ site.data.keys.mf_server }}
密钥库</h3>
                <p>单个 {{ site.data.keys.mf_server }} 密钥库用于签署 OAuth 令牌和“直接更新”包，并且用于相互 HTTPS (SSL) 认证。 您可以使用 {{ site.data.keys.mf_console }} 或 mfpadm 动态配置此密钥库。</p>

                <h3>针对 iOS 的本机加密和解密</h3>
                <p>OpenSSL 已从 iOS 的主要框架中除去，替换为本机加密/解密。 可以将 OpenSSL 添加为独立框架。 请参阅“为 iOS 启用 OpenSSL”。 对于 iOS Cordova JavaScript，OpenSSL 仍嵌入在主要框架中。 对于两个 API，本机加密和 OpenSSL 加密都可用。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">操作系统支持方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} 现在支持 Windows 10 通用应用程序、位码构建和 Apple watchOS 2。</p>

                <h3>针对 Windows 10 Native 支持通用应用程序</h3>
                <p>通过 {{ site.data.keys.product }}，您现在可以编写本机 C# Universal App Platform 应用程序，以在您的应用程序中使用 {{ site.data.keys.product_adj }} SDK。</p>

                <h3>支持 Windows 混合环境</h3>
                <p>Windows 10 Universal Windows Platform (UWP) 支持 Windows 混合环境。 有关如何开始的更多信息，请参阅：</p>

                <h3>不再支持 BlackBerry</h3>
                <p>{{ site.data.keys.product }} 中不再支持 BlackBerry 环境。</p>

                <h3>位码</h3>
                <p>现在对 iOS 项目支持位码构建。 但是，对于使用位码构建的应用程序，不支持 {{ site.data.keys.product_adj }} 应用程序真实性安全性检查。</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 现在受支持，并且需要位码构建。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">部署和管理应用程序方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>引入了全新的 {{ site.data.keys.product }} 功能来帮助您部署和管理应用程序。 您现在无需重新启动 {{ site.data.keys.mf_server }} 即可更新应用程序和适配器。</p>

                <h3>改进的 DevOps 支持</h3>
                <p>{{ site.data.keys.mf_server }} 经历了明显的重新设计，可更好地支持您的 DevOps 环境。 将 {{ site.data.keys.mf_server }} 一次安装到应用程序服务器环境中，在上载应用程序或更改 {{ site.data.keys.mf_server }} 配置时，无需对应用程序服务器配置进行任何更改。</p>

                <p>在更新应用程序或应用程序所依赖的任何适配器时，无需重新启动 {{ site.data.keys.mf_server }}。 您可以在服务器仍处理流量时，执行配置操作、上载新版本的适配器或注册新应用程序。</p>

                <p>配置更改和开发操作受安全角色保护。</p>

                <p>您可以采用各种方式将开发工件上载到服务器，使您的操作更加灵活：</p>

                <ul>
                    <li>已增强 {{ site.data.keys.mf_console }}：特别需要指出的是，您现在可以使用它注册应用程序或新版本的应用程序、管理应用程序安全性参数、部署证书、创建推送通知标记和发送推送通知。 控制台现在还包含上下文帮助指南。</li>
                    <li>命令行工具</li>
                </ul>

                <p>您上载到服务器的开发工件包含适配器及其配置、应用程序的安全配置、推送通知证书和日志过滤器。</p>

                <h3>在 {{ site.data.keys.product }} 上运行在 IBM Cloud 上创建的应用程序</h3>
                <p>开发人员可以迁移 IBM Cloud 应用程序以在 {{ site.data.keys.product }} 上运行。 迁移需要对您的客户机应用程序进行配置更改以与 {{ site.data.keys.product }} API 匹配。</p>

                <h3>{{ site.data.keys.product }} 在 IBM Cloud 上用作服务</h3>
                <p>您现在可以在 IBM Cloud 上使用 {{ site.data.keys.mf_bm_full }} 服务来创建和运行企业移动应用程序。</p>

                <h3>无 .wlapp 文件</h3>
                <p>在先前版本中，通过上载 <b>.wlapp</b> 文件将应用程序部署到 {{ site.data.keys.mf_server }} 中。 该文件包含用于描述应用程序以及（如果是混合应用程序）所需 Web 资源的数据。 在 V8.0.0 中，不再使用 <b>.wlapp</b> 文件：</p>

                <ul>
                    <li>可通过部署应用程序描述符 JSON 文件，在 {{ site.data.keys.mf_server }} 中注册应用程序。</li>
                    <li>要使用“直接更新”更新 Cordova 应用程序，可将修改后的 Web 资源的归档（.zip 文件）上载到服务器中。 此归档文件不再包含先前版本的 {{ site.data.keys.product }} 中可能存在的 Web 预览文件或皮肤。 已废弃这些功能。 该归档仅包含发送至客户机的 Web 资源以及“直接更新”验证的校验和。</li>
                </ul>

                <p>要对安装在最终用户设备上的客户机 Cordova 应用程序启用“直接更新”，必须将修改后的 Web 资源以归档（.zip 文件）形式部署到服务器上。 要启用安全的“直接更新”，必须在 {{ site.data.keys.mf_server }} 中部署用户定义的密钥库文件，并且必须将匹配的公用密钥的副本包含在已部署的客户机应用程序中。</p>

                <h3>适配器</h3>
                <h4>适配器是 Apache Maven 项目。</h4>
                <p>现在将适配器视为 Maven 项目。 您可以使用标准命令行 Maven 命令或支持 Maven 的任何 IDE（如 Eclipse 和 IntelliJ）来创建、构建和部署适配器。</p>

                <h4>DevOps 环境中的适配器配置和部署</h4>
                <ul>
                    <li>{{ site.data.keys.mf_server }} 管理员现在可以使用 {{ site.data.keys.mf_console }} 来修改已部署的适配器的行为。 重新配置后，在服务器中更改立即生效，无需重新部署适配器或重新启动服务器。</li>
                    <li>现在，您可以“热部署”适配器，表示当 {{ site.data.keys.mf_server }} 仍在处理流量时在运行时部署、取消部署和重新部署这些适配器。</li>
                </ul>

                <h4>适配器描述符文件中的更改</h4>
                <p><b>adapter.xml</b> 描述符文件已稍作更改。 有关适配器的适配器描述符文件结构的更多信息，请参阅<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">适配器教程</a>。</p>

                <h4>与 Swagger UI 集成</h4>
                <p>{{ site.data.keys.mf_server }} 现在与 Swagger UI 集成。 对于任何适配器，您可以通过在 {{ site.data.keys.mf_console }} 中单击资源选项卡中的查看 Swagger 文档来查看关联的 API。 此功能仅在开发环境中可用。</p>

                <h4>支持 JavaScript 适配器</h4>
                <p>仅支持具有 HTTP 和 SQL 连接类型的 JavaScript 适配器。</p>

                <h4>JAX-RS 2.0 支持</h4>
                <p>JAX-RS 2.0 引入了新的服务器端功能：服务器端异步 HTTP、过滤器和拦截器。  适配器现在可以利用这些新功能。</p>

                <h3>{{ site.data.keys.product }} on IBM Containers</h3>
                <p><a href="http://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage 站点</a>站点上提供了针对 V8.0.0 发布的 {{ site.data.keys.product }} on IBM Containers。 此版本的 {{ site.data.keys.product }} on IBM Containers 可随时用于生产环境中，并支持 IBM Cloud 上的企业 dashDB™ 事务数据库。</p>

                <p><b>注：</b>请参阅“部署 {{ site.data.keys.product }} on IBM Containers 的先决条件”。</p>

                <h3>在 IBM PureApplication System 上部署 {{ site.data.keys.mf_server }}</h3>
                <p>您现在可以在 IBM PureApplication System 上将 {{ site.data.keys.mf_server }} 部署到受支持的 {{ site.data.keys.product }} 系统模式中并对其进行配置。</p>

                <p>所有受支持的 {{ site.data.keys.product }} 系统模式现在都包含对现有 IBM DB2 数据库的支持。 虚拟系统模式上现在支持 {{ site.data.keys.mf_app_center_full }}。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">{{ site.data.keys.mf_server }}方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} 已重新设计，可帮助减少部署和更新应用程序所需要的时间和成本。 除了重新设计 {{ site.data.keys.mf_server }}之外，{{ site.data.keys.product }}还将扩展可用安装方法的数量。</p>

                <p>新的 {{ site.data.keys.mf_server }}设计引入了两个新组件：{{ site.data.keys.mf_server }}实时更新服务和 {{ site.data.keys.mf_server }}工件。</p>

                <p>{{ site.data.keys.mf_server }} 实时更新服务设计为帮助减少增量更新应用程序所需要的时间和成本。 它可管理和存储应用程序和适配器的服务器端配置数据。 您可以通过重新构建或重新部署应用程序来更改或更新应用程序的各种部件：</p>

                <ul>
                    <li>基于您定义的用户细分，动态更改或更新应用程序行为。</li>
                    <li>动态更改或更新服务器端业务逻辑。</li>
                    <li>动态更改或更新应用程序安全性。</li>
                    <li>外部化和动态更改应用程序配置。</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} 工件为 {{ site.data.keys.mf_console }}提供资源。</p>

                <p>除了重新设计了 {{ site.data.keys.mf_server }}，现在还提供更多安装选项。 除了手动安装之外，{{ site.data.keys.product }}还为您提供两个选项在服务器机群中安装 {{ site.data.keys.mf_server }}。 您还可以在 Liberty 集合体中安装 {{ site.data.keys.mf_server }}。</p>

                <p>您现在可以使用 Ant 任务或使用 Server Configuration Tool 在服务器场中安装 {{ site.data.keys.mf_server }}组件。 有关更多信息，请参阅以下主题：</p>

                <ul>
                    <li>安装服务器场</li>
                    <li>有关 {{ site.data.keys.mf_server }} 安装的教程</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} 也支持 Liberty 集合体。 有关服务器拓扑以及各种安装方法的更多信息，请参阅以下主题：</p>

                <ul>
                    <li>Liberty 集合体拓扑</li>
                    <li>运行 Server Configuration Tool</li>
                    <li>使用 Ant 任务安装</li>
                    <li>在 WebSphere Application Server Liberty 集合体上手动安装</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">{{ site.data.keys.mf_analytics }}方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }}
引入了重新设计的控制台，其中包含信息表示改进和基于角色的访问控制。 现在，可使用多种不同的语言访问此控制台。</p>

                <p>{{ site.data.keys.mf_analytics_console }} 已重新设计，以直观且更有意义的方式提供信息，并对一些事件类型使用摘要数据。</p>

                <p>您现在可以通过单击齿轮图标来注销 {{ site.data.keys.mf_analytics_console }}。</p>

                <p>现在可以使用以下语言访问 {{ site.data.keys.mf_analytics_console }}：</p>
                <ul>
                    <li>德语</li>
                    <li>西班牙语</li>
                    <li>法语</li>
                    <li>意大利语</li>
                    <li>日语</li>
                    <li>韩语</li>
                    <li>葡萄牙语(巴西)</li>
                    <li>俄语</li>
                    <li>简体中文</li>
                    <li>繁体中文</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics_console }} 现在基于已登录用户的安全角色显示不同的内容。<br/>
                有关更多信息，请参阅<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">基于角色的访问控制</a>。</p>

                <p>{{ site.data.keys.mf_analytics_server }} 使用 Elasticsearch V1.7.5。</p>

                <p>已通过新的 Web Analytics 客户端 API 添加针对 Web 应用程序的 {{ site.data.keys.mf_analytics_short }} 支持。</p>

                <p>一些事件类型在较早版本的 {{ site.data.keys.mf_analytics_server }} 与 V8.0 之间已发生更改。 由于此更改，必须将先前在服务器配置文件中配置的任何 JNDI 属性转换为新事件类型。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">{{ site.data.keys.product_adj }}推送通知方面的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>现在提供了推送通知服务作为独立服务，托管在独立的 Web 应用程序上。</p>

                <p>较早版本的 {{ site.data.keys.product }} 将推送通知服务作为应用程序运行时的一部分嵌入其中。</p>

                <h3>编程模型</h3>
                <p>编程模型跨越服务器和客户机，并且您需要设置应用程序以使推送通知服务在客户机应用程序上运行。 可使用以下两类客户机来与推送通知服务交互：</p>

                <ul>
                    <li>移动式客户机应用程序</li>
                    <li>后端服务器应用程序</li>
                </ul>

                <h3>推送通知服务的安全性</h3>
                <p>{{ site.data.keys.product }} 授权服务器将实施 OAuth 协议以保护推送通知服务。</p>

                <h3>推送通知服务模型</h3>
                <p>不支持基于事件源的模型。 在 {{ site.data.keys.product }} 上通过推送服务模型启用推送通知功能。</p>

                <h3>推送 REST API</h3>
                <p>您可以启用部署在 {{ site.data.keys.mf_server }} 外的后端服务器应用程序，以在 {{ site.data.keys.product }}
运行时中使用推送 REST API 访问推送通知功能。</p>

                <h3>从基于事件源的现有通知模型升级</h3>
                <p>不支持基于事件源的模型。 可通过推送服务模型完全启用推送通知功能。 需要将所有基于事件源的现有应用程序迁移到新的推送服务模型中。</p>

                <h3>发送推送通知</h3>
                <p>您可以选择从服务器发送基于事件源的推送通知、基于标记的推送通知或启用广播的推送通知。</p>

                <p>可以使用以下方法发送推送通知：</p>
                <ul>
                    <li>通过 {{ site.data.keys.mf_console }}，可以发送两种类型的通知：标记和广播。 请参阅“使用 {{ site.data.keys.mf_console }} 发送推送通知”。</li>
                    <li>通过推送消息 (POST) REST API，可以发送所有形式的通知：标记、广播和认证。</li>
                    <li>通过 {{ site.data.keys.mf_server }} 管理服务的 REST API，可以发送所有形式的通知：标记、广播和认证。</li>
                </ul>

                <h3>发送 SMS 通知</h3>
                <p>您可以配置推送服务以向用户设备发送短消息服务 (SMS) 通知。</p>

                <h3>安装推送通知服务</h3>
                <p>推送通知服务打包为 {{ site.data.keys.mf_server }} 组件（{{ site.data.keys.mf_server }} 推送服务）。</p>

                <h3>推送服务模型在 Windows Universal Platform 应用程序上受支持</h3>
                <p>您现在可以迁移本机 Windows Universal Platform (UWP) 应用程序以使用推送服务模型发送推送通知。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">{{ site.data.keys.mf_app_center }} 中的新增内容</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>在 IBM Cloud（基于容器）中现在可通过 BYOL 脚本支持 {{ site.data.keys.mf_app_center }}。</p>
            </div>
        </div>
    </div>
</div>
