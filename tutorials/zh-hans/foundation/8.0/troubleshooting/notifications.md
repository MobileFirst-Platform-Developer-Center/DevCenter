---
layout: tutorial
title: 对推送通知进行故障诊断
breadcrumb_title: Notifications
relevantTo: [ios,android,windows,cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
请查找相关信息来帮助解决在使用 {{ site.data.keys.product }} 推送服务时可能遇到的问题。

<div class="panel panel-default">
  <div class="panel-heading"><h4>推送服务如何处理各种“送达失败”通知情况？</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>如果来自 GCM 的响应为“内部服务器错误”或“GCM 服务不可用”，那么将尝试重新发送通知。 将根据“稍后重试”的值来确定尝试频率。</li>
        <li>GCM 不可访问 - 在 <b>trace.log</b> 文件中打印了一条错误，并且不会重新发送消息。</li>
        <li>GCM 可访问，但收到故障
            <ul>
                <li>未注册/标识无效/标识不匹配/缺少注册 - 原因可能是无效地使用了 GCM 中的设备标识或应用户程序注册。 从数据库删除此设备标识以避免数据库中出现过时数据。 不会重新发送通知。</li>
                <li>消息过大 - 不重试发送消息，并在 <b>trace.log</b> 文件中记录一条日志。</li>
                <li>错误代码 401 - 原因可能是认证错误，不重试发送消息，并在 <b>trace.log</b> 文件中记录一条日志。</li>
                <li>错误代码 400 或 403 - 不重试发送消息，并在 <b>trace.log</b> 文件中记录一条日志。</li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>对于 APNS，如果 APNS 连接已关闭，那么将进行重试。 将三次尝试与 APNS 建立连接。 在其他情况下，将不进行重试。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>在 Xcode 中收到与“apns-environment”有关的错误</h4></div>
  <div class="panel-body">
    <p>验证用于对应用程序进行签名的配置概要文件是否启用了推送功能。 可在 Apple Developer 门户网站中的 App ID 的设置页面中验证这一点。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>分派 APNS 通知时在日志中出现 Java 套接字异常，并且通知从未达到设备</h4></div>
  <div class="panel-body">
    <p>APNS 要求在 {{ site.data.keys.mf_server }} 与 APNS 服务之间存在持久套接字连接。 推送服务假定存在已打开的套接字，并且尝试向外发送通知。 但是，客户的防火墙经常被配置为关闭未使用的套接字（可能未频繁使用推送）。 任一端点可能都无法发现这种意外的套接字关闭 - 因为正常的套接字关闭仅在其中一个端点发送信号而另一个端点确认后才会发生。 当尝试通过已关闭的套接字来分派推送服务时，日志中将显示套接字异常。</p>
    
    <p>为避免此类情况，请确保防火墙规则不会关闭 APNS 套接字，或者使用 <code>push.apns.connectionIdleTimeout</code> <a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">推送服务的 JNDI 属性</a>。 通过配置此属性，服务器将在给定超时（小于针对套接字的防火墙超时）内正常关闭用于 APNS 推送通知的套接字。 这样，客户可在套接字被防火墙突然关闭之前将其关闭。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>向 iOS 设备发送推送通知时发生 SOCKS 相关错误</h4></div>
  <div class="panel-body">
    <p>例如： <blockquote>java.net.SocketException: Malformed reply from SOCKS serverat java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    通过 TCP 套接字发送 APNS 通知。 由此产生了如下限制：用于 APNS 通知的代理应支持 TCP 套接字。 此处不适合使用正常 HTTP 代理（适用于 GCM）。 因此，APNS 通知唯一支持的代理是 SOCKS 代理。 支持 SOCKS V4 或 V5 协议。 当 JNDI 属性配置为通过 SOCKS 代理转发 APNS 通知，但未配置代理、代理脱机/不可用或者代理阻止流量时，会抛出此异常。 客户应验证其 SOCKS 代理是否可用且正常运行。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>已发送通知，但此通知从未到达设备</h4></div>
  <div class="panel-body">
    <p>通知可能即时发送或出现延迟。 延迟可为几秒到几分钟。 导致延迟的原因可能有：</p>
    <ul>
        <li>在通知到达介体服务后，{{ site.data.keys.mf_server }} 将无法控制该通知。</li>
        <li>需要考虑设备的网络或联机状态（设备开启/关闭）。</li>
        <li>检查是否使用了防火墙或代理，如果已使用防火墙或代理，请检查这些防火墙或代理是否未配置为阻止与介体的通信。</li>
        <li>请勿选择性地为 GCM/APNS/WNS 介体将 IP 添加到防火墙的白名单中，而是应使用实际介体 URL。 这可能导致出现问题，因为介体 URL 可能解析为任何 IP。 客户应允许访问 URL 而不是 IP。 请注意，通过使用 Telnet 连接到介体 URL 来确保介体连接不一定能提供整体连接状况。 尤其是对于 iOS，这只能证明出站连接。 实际发送是通过 Telnet 无法保证的 TCP 套接字来完成的。 如果仅允许特定 IP 地址，那么可能发生如下情况，例如，对于 GCM： <blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>在 iOS 中，某些通知到达设备，而某些通知未到达</h4></div>
  <div class="panel-body">
    <p>Apple 的 QoS 定义了所谓的<b>联合通知</b>。 这意味着，如果通知无法立即送达到设备（通过令牌来标识），那么 APNS 服务器在其服务器中仅保留 1 条通知。 例如，逐个分派 5 条通知时。 如果设备位于不稳定的网络中，第一条通知已送达，第二条通知临时存储在 APNS 服务器上， 此时第三条通知已分派并到达 APNS 服务器， 那么现在丢弃了先前（未送达的）第二条通知，并存储第三条（最后一条）通知。 对于最终用户，这条通知显示为缺失通知。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>在 Android 中，仅当应用程序正在运行并且位于前台时，通知才可用</h4></div>
  <div class="panel-body">
    <p>... 如果应用程序未在运行，或者应用程序位于后台，那么点击通知栏中的通知不会启动此应用程序。 原因可能是 <b>strings.xml</b> 文件中的 <b>app_name</b> 字段已更改为定制名称。 这将导致应用程序名称与 <b>AndroidManifest.xml</b> 文件中定义的目标操作不匹配。  如果应用程序需要不同名称，应改为使用 <b>app_label</b> 字段，或者使用 <b>strings.xml</b> 文件中的定制定义。</p>
  </div>
</div>


<div class="panel panel-default">
  <div class="panel-heading"><h4>向 APNS 发送推送通知时出现 SSLHandshakeExceptions</h4></div>
  <div class="panel-body">
  <p>例如：</p> <blockquote>ApnsConnection | com.ibm.mfp.push.server.notification.apns.Apns.Connectionlmpl sendMessage Failed to send message Message (Id=1;  Token=xxxx; Payload={"payload":{"\nid\":\"44b7f47\",\"tag\":\"Push.ALL\"}", "aps":{"alert":{"action-loc-key":null,"body":"TEST"}}})... trying again after delay javax.net.ssl.SSLHandshakeException:Received fatal alert: handshake_failure</blockquote>
<p>仅当使用 IBM JDK 1.8 JVM 时才会通知此问题。 解决方案是将 IBM JDK 1.8 升级至 V8.0.3.11 或更高版本。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>在 {{ site.data.keys.mf_console }} 中推送服务显示为“不活动”</h4></div>
  <div class="panel-body">
    <p>尽管推送服务的 .war 文件已部署并且在 <b>server.xml</b> 文件中已正确配置 <code>mfp.admin.push.url</code>、<code>mfp.push.authorization.server.url</code> 和 <code>secret</code> 属性，但此推送服务仍显示为“不活动”。</p>
    <p>验证是否已针对 MFP 管理服务正确设置了服务器的 JNDI 属性。 其中应包含如下内容：</p>

{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value='"http://localhost:9080/imfpush"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.server.url" value='"http://localhost:9080/mfp"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.id" value='"push-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.secret" value='"pushSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.id" value='"admin-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.secret" value='"adminSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.password" value='"{xor}DCs+LStubWw="'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.user" value='"configUser"'/>
{% endhighlight %}
  </div>
</div>
