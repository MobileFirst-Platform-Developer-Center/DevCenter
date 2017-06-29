---
layout: tutorial
title: What's new
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0 brings significant changes that modernize your {{ site.data.keys.product_adj }} application development, deployment, and management experience.

<div class="panel-group accordion" id="release-notes" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">What's new in building apps</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>The {{ site.data.keys.product }} SDK and command-line interface have been redesigned to give you greater flexibility and efficiency when developing your apps. Also, you can now use any of your preferred Cordova tools when you develop cross-platform apps.</p>

                <p>Review the following sections to learn what is new for developing your apps.</p>

                <h3>New development and deployment process</h3>
                <p>You no longer create a project WAR file that needs to be installed in the application server. Instead, the {{ site.data.keys.mf_server }} is installed once, and you upload the server-side configuration of your apps, of the resource security or of the push service to the server. You can modify the configuration of your apps with the {{ site.data.keys.mf_console }}.</p>

                <p>{{ site.data.keys.product_adj }} projects no longer exist. Instead, you develop your mobile app with the development environment of your choice.<br/>
                You can modify the server-side configuration of your apps and adapters without stopping the {{ site.data.keys.mf_server }}.</p>

                <ul>
                    <li>For more information about the new development process, see <a href="../../../application-development/">Development concepts and overview</a></li>
                    <li>For more information about the migration of existing applications, see <a href="../../../upgrading/migration-cookbook">the Migrating Cookbook</a>.</li>
                    <li>For more information about administering {{ site.data.keys.product_adj }} applications, see Administering {{ site.data.keys.product_adj }} applications.</li>
                </ul>

                <h3>Web applications</h3>
                <p>You can now use the {{ site.data.keys.product_adj }} client-side JavaScript API to develop web applications with your preferred tools and IDE. You can register your web application to {{ site.data.keys.mf_server }} to add security capabilities to the application.</p>

                <p>You can also use the new client-side JavaScript web analytics API, which is provided as part of the new web SDK, to add {{ site.data.keys.mf_analytics }} capabilities to your web application.</p>

                <h3>Develop cross-platform apps with your preferred Cordova tools</h3>
                <p>You can now use your preferred Cordova tools (such as Apache Cordova CLI or Ionic Framework) to develop your cross-platform hybrid apps. You obtain these tools independently of {{ site.data.keys.product }}, and then add {{ site.data.keys.product_adj }} plug-ins to provide {{ site.data.keys.product_adj }} back-end capabilities.</p>

                <p>You can install the {{ site.data.keys.product }} Studio Eclipse plug-in to manage your cross-platform Cordova apps that are enabled with {{ site.data.keys.product }} in the Eclipse development environment. The {{ site.data.keys.product }} Studio plug-in also provides additional {{ site.data.keys.mf_cli }} commands that you can run from within the Eclipse environment.</p>

                <h3>SDK componentization</h3>
                <p>Previously {{ site.data.keys.product_adj }} client SDK was delivered as a single framework or JAR file. You can now choose to include or exclude specific functionalities. In addtion to the core SDK, each {{ site.data.keys.product_adj }} API has its own set of optional components.</p>

                <h3>New, improved development command-line interface (CLI)</h3>
                <p>The {{ site.data.keys.mf_cli }} has been redesigned for greater development efficiency, including for use in automated scripts. Commands now start with the prefix mfpdev. The CLI is included in the {{ site.data.keys.mf_dev_kit_full }}, or you can quickly download the latest version of the CLI from npm.</p>

                <h3>Migration assistance tool</h3>
                <p>A migration assistance tool simplifies the procedure of migrating your existing apps to {{ site.data.keys.product }} version 8.0. The tool scans your existing {{ site.data.keys.product_adj }} apps and creates a list of the APIs that are used in the file that are either removed, deprecated, or replaced in version 8.0. When you run the migration assistance tool on Apache Cordova applications that were created with the {{ site.data.keys.product }}, it creates a new Cordova structure for the app that is compliant with version 8.0. For more information about the migration assistance tool.</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>Starting with Cordova 4.0 the pluggable WebView allows the default web runtime to be replaced. Crosswalk is now supported by Cordova applications with {{ site.data.keys.product }}. Using the Crosswalk WebView for Android allows high performance and consistent user experience across a wide range of mobile devices. To take advantage of the Crosswalk capabilities, apply the Cordova Crosswalk plug-in.</p>

                <h3>Distributing {{ site.data.keys.product_adj }} SDK for Windows 8 and Windows 10 Universal apps with NuGet</h3>
                <p>The {{ site.data.keys.product_adj }} SDK for Windows 8 and Windows 10 Universal apps is available from NuGet at <a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>. To get started.</p>

                <h3>org.apache.http replaced by okHttp</h3>
                <p><code>org.apache.http</code> has been removed from the Android SDK. okHttp will be used as the http dependency.</p>

                <h3>WKWebView support for iOS hybrid Cordova apps</h3>
                <p>You can now replace the default UIWebView in Cordova apps with WKWebView.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">What's new in MobileFirst APIs</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>New features improve and extend the APIs that you can use to develop mobile applications. Use the latest APIs to take advantage of new, improved, or changed functions in {{ site.data.keys.product }}.</p>

                <h3>Updated JavaScript server-side API</h3>
                <p>Back-end invocation functions are supported only for adapter types that are supported. Currently, only HTTP and SQL adapters are supported, so back-end invokers <code>WL.Server.invokeHttp</code> and <code>WL.Server.invokeSQL</code> are supported, too.</p>

                <h3>New Java server-side API</h3>
                <p>A new Java server-side API is provided, which you can use to extend {{ site.data.keys.mf_server }}.</p>

                <h4>New Java server-side API for security</h4>
                <p>The new security API package, <code>com.ibm.mfp.server.security.external</code>, and its contained packages, include the interfaces that are required for developing security checks and adapters that use the security-check context.</p>

                <h4>New Java server-side API for client registration data</h4>
                <p>The new client registration-data API package, <code>com.ibm.mfp.server.registration.external</code>, and its contained packages, include an interface for providing access to persistent {{ site.data.keys.product_adj }} client registration data.</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>With this new API, you can return the JAX-RS application for the adapter.</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>With this new API, you can get the value from the adapter configuration (or default value).</p>

                <h3>Updated Java server-side API</h3>
                <p>An updated Java server-side API is provided, which you can use to extend {{ site.data.keys.mf_server }}.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>The signature of this new API has not changed in this version. However, its behavior is now identical to that of <code>String getPropertyValue (String propertyName)</code>, which is described in New Java server-side API.</p>

                <h4>WLServerAPIProvider</h4>
                <p>In V7.0.0 and V7.1.0, the Java API was accessible through the WLServerAPIProvider interface. For example: <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> and <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>These static interfaces are still supported, to allow adapters that were developed in previous versions of the product to compile and deploy. Old adapters that do not use push notifications or the previous security API continue to work with the new version. Adapters that do use push notifications or the previous security API break.</p>

                <h3>JavaScript client-side APIs for web applications</h3>
                <p>The JavaScript client-side API that is used for development of cross-platform Cordova applications is now available also for development of web applications, with slight variations in the initialization method. Note that not all functions of the JavaScript API are applicable to web applications.</p>

                <p>In addition, a new JavaScript client-side web analytics API is provided for adding {{ site.data.keys.mf_analytics }} capabilities to your web application.</p>

                <h3>Updated C# client-side API for Windows 8 Universal and Windows Phone 8 Universal</h3>
                <p>The C# client-side API for Windows 8 Universal and Windows Phone 8 Universal have changed.</p>

                <h3>New Java client-side APIs for Android</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>With this new method, you can get the display name of a device from the {{ site.data.keys.mf_server }} registration data.</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>With this new method, you can set the display name of a device in the {{ site.data.keys.mf_server }} registration data.</p>

                <h3>New Objective-C client-side APIs for iOS</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>With this new method, you can get the display name of a device from the {{ site.data.keys.mf_server }} registration data.</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>With this new method, you can set the display name of a device in the {{ site.data.keys.mf_server }} registration data.</p>

                <h3>Updated REST API for the administration service</h3>
                <p>The REST API for the administration service is partly refactored. In particular, the API for beacons and mediators is removed and most REST services for push notification are now part of the REST API for the push service.</p>

                <h3>Updated REST API for the runtime</h3>
                <p>The REST API for the {{ site.data.keys.product_adj }} runtime now provides several services for mobile clients and confidential clients to call adapters, obtain access tokens, get Direct Update content, and more. Most of the REST API endpoints are protected by OAuth. On a development server, you can view the Swagger doc for the runtime API at:  <code>http(s)://server_ip:server_port/context_root/doc</code>.</p>

                <h3>Multiple certificate pinning support</h3>
                <p>Staring with iFix 8.0.0.0-IF201706240159, {{ site.data.keys.mf_bm_short }} supports pinning of multiple certificates. This allows users to have secure access to multiple hosts. Prior to this iFix, {{ site.data.keys.mf_bm_short }} supported pinning of a single certificate. {{ site.data.keys.mf_bm_short }} has introduced a new API, which allows connection to multiple hosts by allowing the user to pin public keys of multiple X509 certificates (purchased from a certificate authority) to the client application. A copy of all the certificates should be placed in your client application. During the SSL handshake, the {{ site.data.keys.product_full }} client SDK verifies that the public key of the server certificate matches the public key from one of the certificates that are stored in the app.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">What's new in MobileFirst security</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>The security framework in {{ site.data.keys.product }} was entirely redesigned. New security features were introduced, and some modifications were made to existing features.</p>

                <h3>Security framework overhaul</h3>
                <p>The {{ site.data.keys.product_adj }} security framework was redesigned and reimplemented to improve and simplify security development and administration tasks. The framework is now inherently based on the OAuth model, and the implementation is session-independent. See Overview of the {{ site.data.keys.product_adj }} security framework.</p>

                <p>On the server side, the multiple building blocks of the framework were replaced with security checks (implemented in adapters), allowing for simplified development with new APIs. Sample implementations and predefined security checks are provided. See Security checks. Security checks can be configured in the adapter descriptor, and customized by making runtime adapter or application configuration changes, without redeploying the adapter or disrupting the flow. The configurations can be done from the redesigned {{ site.data.keys.mf_console }} security interfaces. You can also edit the configuration files manually, or use the {{ site.data.keys.mf_cli }} or mfpadm tools.</p>

                <h3>Application-authenticity security check</h3>
                <p>{{ site.data.keys.product_adj }} application-authenticity validation is now implemented as a predefined security check that replaces the previous "extended application authenticity checking". You can dynamically enable, disable, and configure application-authenticity validation by using either {{ site.data.keys.mf_console }} or mfpadm. A stand-alone {{ site.data.keys.product_adj }} application-authenticity Java tool (mfp-app-authenticity-tool.jar) is provided for generating an application-authenticity file.</p>

                <h3>Confidential clients</h3>
                <p>The support for confidential clients was redesigned and reimplemented using the new OAuth security framework.</p>

                <h3>Web-applications security</h3>
                <p>The revised OAuth-based security framework supports web applications. You can now register web applications with {{ site.data.keys.mf_server }} to add security capabilities to your application and protect access to your web resources. For more information about developing {{ site.data.keys.product_adj }} web applications, see Developing web applications. The application-authenticity security check is not supported for web applications.</p>

                <h3>Cross-platform applications (Cordova apps), new and changed security features</h3>
                <p>Additional security features are available to help protect your Cordova app. These features include the following:</p>

                <ul>
                    <li>Web resources encryption: Use this feature to encrypt the web resources in your Cordova package to help prevent someone from modifying the package.</li>
                    <li>Web resources checksum: Use this feature to run a checksum test that compares the current statistics of the web resources of the app with the baseline statistics that were established when it was first opened. This check helps to prevent someone from modifying the app after it is installed and opened.</li>
                    <li>Certificate pinning: Use this feature to associate the certificate of an app with a certificate on the host server. This feature helps to prevent information that is passed between the app and the server from being viewed or modified.</li>
                    <li>Support for the Federal Information Processing Standard (FIPS) 140-2: Use this feature to ensure that data that is transferred is compliant with the FIPS 140-2 cryptography standard.</li>
                    <li>OpenSSL: To use OpenSSL data encryption and decryption with your Cordova app for the iOS platform, you can use the cordova-plugin-mfp-encrypt-utils Cordova plug-in.</li>
                </ul>

                <h3>Device Single Sign-On</h3>
                <p>Device single sign-on (SSO) is now supported by way of the new predefined <code>enableSSO</code> security-check application-descriptor configuration property.</p>

                <h3>Direct Update</h3>
                <p>In contrast to earlier versions of {{ site.data.keys.product_adj }}, starting with V8.0</p>

                <ul>
                    <li>If a client application accesses an unprotected resource, the application does not receive updates, even if an update is available on {{ site.data.keys.mf_server }}.</li>
                    <li>After it has been activated, Direct Update is enforced on every request for a protected resource.</li>
                </ul>

                <h3>External-resources Protection</h3>
                <p>The supported method and provided artifacts for protecting resources on external servers were modified:</p>

                <ul>
                    <li>A new, configurable {{ site.data.keys.product_adj }} Java Token Validator access-token validation module is provided for using the {{ site.data.keys.product_adj }} security framework to protect resources on any external Java server. The module is provided as a Java library (mfp-java-token-validator-8.0.0.jar), and replaces the use of the obsolete {{ site.data.keys.mf_server }} token-validation endpoint to create a custom Java validation module.</li>
                    <li>The {{ site.data.keys.product_adj }} OAuth Trust Association Interceptor (TAI) filter, for protecting Java resources on an external WebSphere  Application Server or WebSphere Application Server Liberty server, is now provided as a Java library (com.ibm.imf.oauth.common_8.0.0.jar). The library uses the new Java Token Validator validation module, and the configuration of the provided TAI changed.</li>
                    <li>The server-side {{ site.data.keys.product_adj }} OAuth TAI API is no longer required and was removed.</li>
                    <li>The passport-mfp-token-validation {{ site.data.keys.product_adj }} Node.js framework, for protecting Java resources on an external Node.js server, was modified to support the new security framework.</li>
                    <li>You can also write your own custom filter and validation module, for any type of resource server, which uses the new introspection endpoint of the authorization server.</li>
                </ul>

                <h3>Integration with WebSphere DataPower as an authorization server</h3>
                <p>You can now select to use WebSphere DataPower  as the OAuth authorization server, instead of the default {{ site.data.keys.mf_server }} authorization server. You can configure DataPower to integrate with the {{ site.data.keys.product_adj }} security framework.</p>

                <h3>LTPA-based single sign-on (SSO) security check</h3>
                <p>Support for sharing user authentication among servers that use WebSphere light-weight third-party authentication (LTPA) is now provided by using the new predefined LTPA-based single sign-on (SSO) security check. This check replaces the obsolete {{ site.data.keys.product_adj }} LTPA realm, and eliminates the previous required configuration.</p>

                <h3>Mobile-application management with {{ site.data.keys.mf_console }}</h3>
                <p>Some changes were made to the support for tracking and managing mobile applications, users, and devices from {{ site.data.keys.mf_console }}. Blocking device or application access is applicable only to attempts to access protected resources.</p>

                <h3>{{ site.data.keys.mf_server }} keystore</h3>
                <p>A single {{ site.data.keys.mf_server }} keystore is used for signing OAuth tokens and Direct Update packages, and for mutual HTTPS (SSL) authentication. You can dynamically configure this keystore by using either {{ site.data.keys.mf_console }} or mfpadm.</p>

                <h3>Native encryption and decryption for iOS</h3>
                <p>OpenSSL has been removed from the main framework for iOS and replaced by a native encryption/decryption. OpenSSL can be added as a separate framework. See Enabling OpenSSL for iOS. For iOS Cordova JavaScript, OpenSSL is still embedded in the main framework. For both APIs both native and OpenSSL encryption is available.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">What's new in Operating System Support</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} now supports Windows 10 Universal apps, bitcode builds, and Apple watchOS 2.</p>

                <h3>Support for universal applications for Windows 10 Native</h3>
                <p>With {{ site.data.keys.product }}, you can now write native C# Universal App Platform applications to use the {{ site.data.keys.product_adj }} SDK within your app.</p>

                <h3>Support for Windows hybrid environments</h3>
                <p>Windows 10 Universal Windows Platform (UWP) support for Windows hybrid environments. For more information on how to get started.</p>

                <h3>BlackBerry end of support</h3>
                <p>The BlackBerry environment is no longer supported in {{ site.data.keys.product }}.</p>

                <h3>Bitcode</h3>
                <p>Bitcode builds are now supported for iOS projects. However, the {{ site.data.keys.product_adj }} application-authenticity security check is not supported for apps built with bitcode.</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 is now supported and requires bitcode builds.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">What's new in deploying and managing apps</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-deploy-manage-apps">
            <div class="panel-body">
                <p>New {{ site.data.keys.product }} capabilities are introduced to help you deploy and manage your apps. You can now update your apps and adapters without restarting {{ site.data.keys.mf_server }}.</p>

                <h3>Improved DevOps support</h3>
                <p>{{ site.data.keys.mf_server }} has been significantly redesigned to better support your DevOps environment. {{ site.data.keys.mf_server }} is installed once into your application server environment, and no changes to the application server configuration are required when you upload an application or change the {{ site.data.keys.mf_server }} configuration.</p>

                <p>You do not need to restart {{ site.data.keys.mf_server }} when you update your apps or any adapters that your apps depend on. You can perform configuration operations, or upload a new version of an adapter or register a new application while the server is still handling traffic.</p>

                <p>Configuration changes and development operations are protected by security roles.</p>

                <p>You can upload development artifacts to the server in various ways to give you more operational flexibility:</p>

                <ul>
                    <li>{{ site.data.keys.mf_console }} is enhanced: In particular, you can now use it to register an application or a new version of an application, to manage app security parameters, and to deploy certificates, create push notification tags, and send push notifications. The console now also includes contextual help guides.</li>
                    <li>Command-line tool</li>
                </ul>

                <p>Development artifacts that you upload to the server include adapters and their configuration, security configurations for your apps, push notification certificates, and log filters.</p>

                <h3>Running applications that were created on IBM Bluemix on {{ site.data.keys.product }}</h3>
                <p>Developers can migrate IBM Bluemix applications to run on {{ site.data.keys.product }}. Migration requires that you make configuration changes to your client application to match {{ site.data.keys.product }} APIs.</p>

                <h3>{{ site.data.keys.product }} as a service on IBM Bluemix</h3>
                <p>You can now use the {{ site.data.keys.mf_bm_full }}  service on IBM Bluemix to create and run your enterprise mobile apps.</p>

                <h3>No .wlapp files</h3>
                <p>In previous versions, applications were deployed to {{ site.data.keys.mf_server }} by uploading a <b>.wlapp</b> file. The file contained data that described the application and, in the case of hybrid applications, the required web resources also. In V8.0.0, instead of the <b>.wlapp</b> file:</p>

                <ul>
                    <li>You register an app in {{ site.data.keys.mf_server }} by deploying an application descriptor JSON file.</li>
                    <li>To update Cordova applications by using Direct Update, you upload an archive (.zip file) of the modified web resource to the server. The archive file no longer contains the web preview files or skins that were possible in previous versions of {{ site.data.keys.product }}. These have been discontinued. The archive contains only the web resources that are sent to the clients, as well as checksums for Direct Update validations.</li>
                </ul>

                <p>To enable Direct Update of client Cordova apps that are installed on end-user devices, you must now deploy the modified web resources as an archive (.zip file) to the server. To enable secure Direct Update, a user-defined keystore file must be deployed in {{ site.data.keys.mf_server }} and a copy of the matching public key must be included in the deployed client application.</p>

                <h3>Adapters</h3>
                <h4>Adapters are Apache Maven projects.</h4>
                <p>Adapters are now treated as Maven projects. You can create, build, and deploy adapters by using standard command-line Maven commands or using any IDE that supports Maven, such as Eclipse and IntelliJ.</p>

                <h4>Adapter configuration and deployment in DevOps environments</h4>
                <ul>
                    <li>{{ site.data.keys.mf_server }} administrators can now use the {{ site.data.keys.mf_console }} to modify the behavior of an adapter that has been deployed. After reconfiguration, the changes take effect in the server immediately, without the need to redeploy the adapter, or restart the server.</li>
                    <li>You can now "hot deploy" adapters, meaning deploy, undeploy, and redeploy them at run time, while {{ site.data.keys.mf_server }} is still serving traffic.</li>
                </ul>

                <h4>Changes in the adapter descriptor file</h4>
                <p>The <b>adapter.xml</b> descriptor file has changed slightly. For more information on the structure of the adapter descriptor file for adapters, see the <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">Adapters tutorials</a>.</p>

                <h4>Integration with Swagger UI</h4>
                <p>{{ site.data.keys.mf_server }} now integrates with Swagger UI. For any adapter, you can view the associated API by clicking View Swagger Docs in the Resources tab in the {{ site.data.keys.mf_console }}. The feature is available in development environments only.</p>

                <h4>Support for JavaScript adapters</h4>
                <p>JavaScript adapters are supported with HTTP and SQL connectivity types, only.</p>

                <h4>Support for JAX-RS 2.0</h4>
                <p>JAX-RS 2.0 introduces new server-side functionality: server-side asynchronous HTTP, filters and interceptors.  Adapters can now exploit these new features.</p>

                <h3>{{ site.data.keys.product }} on IBM Containers</h3>
                <p>{{ site.data.keys.product }} on IBM Containers released for V8.0.0 is available on the <a href="http://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage site</a>. This version of {{ site.data.keys.product }} on IBM Containers is production ready and supports enterprise dashDB™ transactional database on IBM Bluemix.</p>

                <p><b>Note:</b> See the prerequisites for deploying {{ site.data.keys.product }} on IBM Containers.</p>

                <h3>Deploying {{ site.data.keys.mf_server }} on IBM PureApplication System</h3>
                <p>You can now deploy and configure {{ site.data.keys.mf_server }} to the supported {{ site.data.keys.product }} System Pattern on IBM PureApplication  System.</p>

                <p>All supported {{ site.data.keys.product }} system patterns now include support for an existing IBM DB2  database. {{ site.data.keys.mf_app_center_full }} is now supported on a Virtual System Pattern.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">What's new in {{ site.data.keys.mf_server }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} has been redesigned to help reduce the time and cost of deploying and updating your apps. In addition to the redesign of the {{ site.data.keys.mf_server }}, {{ site.data.keys.product }} expands the number of installation methods available.</p>

                <p>The new {{ site.data.keys.mf_server }} design introduces two new components, {{ site.data.keys.mf_server }} live update service and {{ site.data.keys.mf_server }} artifacts.</p>

                <p>{{ site.data.keys.mf_server }} live update service is designed to help reduce the time and cost of incremental updates for your apps. It manages and stores the server-side configuration data of the apps and adapters. You can change or update various parts of your app with rebuilding or redeploying your app:</p>

                <ul>
                    <li>Dynamically change or update app behavior based on user segments that you define.</li>
                    <li>Dynamically change or update server-side business logic.</li>
                    <li>Dynamically change or update app security.</li>
                    <li>Externalize and dynamically change app configuration.</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} artifacts provide resources for {{ site.data.keys.mf_console }}.</p>

                <p>Along with the redesign of {{ site.data.keys.mf_server }}, more installation options are now provided. In addition to the manual installation, {{ site.data.keys.product }} gives you two options to install {{ site.data.keys.mf_server }} in a server farm. You can also install {{ site.data.keys.mf_server }} in Liberty collective.</p>

                <p>You can now install the {{ site.data.keys.mf_server }} components in a server farm by using Ant tasks, or with the Server Configuration Tool. For more information, see the following topics:</p>

                <ul>
                    <li>Installing a server farm</li>
                    <li>Tutorials about {{ site.data.keys.mf_server }} installation</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} also supports Liberty collective. For more information about the server topology and various installation methods, see the following topics:</p>

                <ul>
                    <li>Liberty collective topology</li>
                    <li>Running the Server Configuration Tool</li>
                    <li>Installing with Ant Tasks</li>
                    <li>Manual installation on WebSphere  Application Server Liberty collective</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">What's new in {{ site.data.keys.mf_analytics }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }} introduces a redesigned console with information presentation improvements and role-based access controls. The console is also now available in a number of different languages.</p>

                <p>The {{ site.data.keys.mf_analytics_console }} was redesigned to present information in an intuitive and more meaningful fashion, and uses summarized data for some event types.</p>

                <p>You can now sign out of the {{ site.data.keys.mf_analytics_console }} by clicking on the gear icon.</p>

                <p>The {{ site.data.keys.mf_analytics_console }} is now available in the following languages:</p>
                <ul>
                    <li>German</li>
                    <li>Spanish</li>
                    <li>French</li>
                    <li>Italian</li>
                    <li>Japanese</li>
                    <li>Korean</li>
                    <li>Portuguese (Brazilian)</li>
                    <li>Russian</li>
                    <li>Simplified Chinese</li>
                    <li>Traditional Chinese</li>
                </ul>

                <p>The {{ site.data.keys.mf_analytics_console }} now shows different content based on the security role of the logged-in user.<br/>
                For more information, see <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">Role-based access control</a>.</p>

                <p>{{ site.data.keys.mf_analytics_server }} uses Elasticsearch V1.7.5.</p>

                <p>{{ site.data.keys.mf_analytics_short }} support for web applications was added with the new web analytics client-side API.</p>

                <p>Some event types were changed between earlier versions of {{ site.data.keys.mf_analytics_server }} and V8.0. Because of this change, any JNDI properties that were previously configured in your server configuration file must be converted to the new event type.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">What's new in {{ site.data.keys.product_adj }} Push Notifications</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>The push notification service is now provided as a stand-alone service hosted on a separate web application.</p>

                <p>Earlier versions of {{ site.data.keys.product }} embedded the push notification service as part of the application runtime.</p>

                <h3>Programming model</h3>
                <p>The programming model spans across the server to client, and you need to set up your application for push notification service to work on your client applications. Two types of clients would interact with push notification service:</p>

                <ul>
                    <li>Mobile client applications</li>
                    <li>Back-end server applications</li>
                </ul>

                <h3>Security for push notification service</h3>
                <p>{{ site.data.keys.product }} authorization server enforces the OAuth protocol to secure push notification service.</p>

                <h3>Push notification service model</h3>
                <p>The event source-based model is not supported. The push notification capability is enabled on {{ site.data.keys.product }} by the push service model.</p>

                <h3>Push REST API</h3>
                <p>You can enable back-end server applications that are deployed outside {{ site.data.keys.mf_server }} to access push notification functions by using REST API for push in the {{ site.data.keys.product }} runtime.</p>

                <h3>Upgrading from existing event source-based notification model</h3>
                <p>The event source-based model is not supported. The push notification capability is enabled entirely by the push service model. All existing event source-based applications need to be migrated to the new push service model.</p>

                <h3>Sending push notifications</h3>
                <p>You can choose to send an event-source based, tag-based, or broadcast-enabled push notification from the server.</p>

                <p>Push notifications can be sent by using the following methods:</p>
                <ul>
                    <li>Using {{ site.data.keys.mf_console }}, two types of notifications can be sent: tag and broadcast. See Sending push notification with the {{ site.data.keys.mf_console }}.</li>
                    <li>Using Push Message (POST) REST API, all forms of notifications can be sent: tag, broadcast, and authenticated.</li>
                    <li>Using REST API for the {{ site.data.keys.mf_server }} administration service, all forms of notifications can be sent: tag, broadcast, and authenticated.</li>
                </ul>

                <h3>Sending SMS notifications</h3>
                <p>You can configure the push service to send a short message service (SMS) notification to user devices.</p>

                <h3>Installation of the push notification service</h3>
                <p>The push notification service is packaged as a {{ site.data.keys.mf_server }} component ({{ site.data.keys.mf_server }} push service).</p>

                <h3>Push service model is supported on Windows Universal Platform apps</h3>
                <p>You can now migrate native Windows Universal Platform (UWP) applications to use the push service model to send push notifications.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">What's new in {{ site.data.keys.mf_app_center }} </a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_app_center }} is now supported in Bluemix (based on containers) via BYOL scripts.</p>
            </div>
        </div>
    </div>
</div>
