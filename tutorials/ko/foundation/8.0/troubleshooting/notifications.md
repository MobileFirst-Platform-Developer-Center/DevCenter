---
layout: tutorial
title: 푸시 알림 문제점 해결
breadcrumb_title: Notifications
relevantTo: [ios,android,windows,cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product }} 푸시 서비스를 사용할 때 발생할 수 있는 문제를 해결하는 데 도움을 주는 정보를 찾아보십시오. 

<div class="panel panel-default">
  <div class="panel-heading"><h4>푸시 서비스가 다양한 “전달 실패” 알림 상황을 처리하는 방식</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>GCM으로부터의 응답이 "내부 서버 오류" 또는 "GCM 서비스 사용 불가능"인 경우에는 알림을 다시 전송하려고 시도합니다. 이러한 시도의 빈도는 "재시도 간격"의 값에 따라 결정됩니다. </li>
        <li>GCM에 연결할 수 없는 경우 - 오류가 <b>trace.log</b> 파일에 인쇄되며 메시지 전송을 다시 시도하지 않습니다. </li>
        <li>GCM에 연결할 수 있으나 실패를 수신한 경우:
            <ul>
                <li>등록되지 않음 / 올바르지 않은 ID / 일치하지 않는 ID / 등록 누락 - GCM에서의 잘못된 디바이스 ID 사용 또는 앱 등록으로 인해 발생했을 가능성이 높습니다. 데이터베이스에 시간이 경과된(stale) 데이터가 발생하는 것을 방지하기 위해 디바이스 ID가 삭제됩니다. 알림이 다시 전송되지 않습니다. </li>
                <li>메시지가 너무 큼 - 메시지 전송을 다시 시도하지 않으며 <b>trace.log</b> 파일에 로그가 기록됩니다. </li>
                <li>오류 코드 401 - 인증 오류가 원인일 가능성이 높습니다. 메시지 전송을 다시 시도하지 않으며 <b>trace.log</b> 파일에 로그가 기록됩니다. </li>
                <li>오류 코드 400 또는 403 - 메시지 전송을 다시 시도하지 않으며 <b>trace.log</b> 파일에 로그가 기록됩니다. </li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>APNS의 경우에는 APNS 연결이 닫혀 있는 경우 재시도가 이뤄집니다. APNS와의 연결 설정 시도가 세 번 수행됩니다. 그 외의 경우에는 재시도가 이뤄지지 않습니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Xcode에서 "apns-environment" 관련 오류가 발생함</h4></div>
  <div class="panel-body">
    <p>애플리케이션 서명에 사용된 프로비저닝 프로파일에 푸시 기능이 사용으로 설정되어 있는지 확인하십시오. Apple Developer 포털의 앱 ID 설정 페이지에서 이를 확인할 수 있습니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>APNS 알림을 디스패치할 때 로그에 Java 소켓 오류가 기록되며 알림이 디바이스에 도달하지 못함</h4></div>
  <div class="panel-body">
    <p>APNS는 {{ site.data.keys.mf_server }}와 APNS 서비스 간의 지속적 소켓 연결을 필요로 합니다. 푸시 서비스는 열린 소켓이 있다고 가정하고 알림을 전송하려고 시도합니다. 그러나 고객의 방화벽은 사용하지 않는 소켓을 닫도록 구성되어 있는 경우가 많습니다(푸시 기능은 사용 빈도가 적을 수 있음). 일반적인 소켓 닫기는 한 엔드포인트에서 신호를 전송하고 다른 쪽에서 이를 수신확인하여 이뤄지므로 이러한 갑작스러운 소켓 닫기는 어느 엔드포인트에서도 발견할 수 없습니다. 닫힌 소켓을 통해 푸시 서비스 디스패치가 시도되면 로그에 소켓 예외가 기록됩니다. </p>
    
    <p>이러한 예외를 방지하려면 방화벽 규칙이 APNS 소켓을 닫지 않도록 하거나, <code>push.apns.connectionIdleTimeout</code> <a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">푸시 서비스의 JNDI 특성</a>을 사용하십시오. 이 특성을 구성하면 서버는 지정된 제한시간(소켓에 대한 방화벽 제한시간보다 짧음) 내에 APNS 푸시 알림에 사용되는 소켓을 단계적으로 닫습니다. 이렇게 하면 고객은 소켓이 방화벽에 의해 갑작스럽게 종료되기 전에 소켓을 닫을 수 있습니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>iOS 디바이스에 푸시 알림을 전송할 때 SOCKS 관련 오류가 발생함</h4></div>
  <div class="panel-body">
    <p>예: <blockquote>java.net.SocketException: Malformed reply from SOCKS serverat java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    APNS 알림은 TCP 소켓을 통해 전송됩니다. 이로 인해 APNS 알림에 사용되는 프록시는 TCP 소켓을 지원해야 한다는 제한사항이 적용됩니다. 일반 HTTP 프록시(GCM에 대해 작동)는 이 제한사항을 만족시키지 않습니다. 이러한 이유로, APNS 알림에 대해 지원되는 유일한 프록시는 SOCKS 프록시입니다. SOCKS 프로토콜 버전 4 또는 5가 지원됩니다. APNS 알림을 SOCKS 프록시를 통해 전송하도록 JNDI 특성이 구성되었으나 해당 프록시가 구성되지 않았거나, 오프라인 / 사용 불가능 상태이거나, 트래픽을 차단하는 경우에는 예외 처리(throw)가 수행됩니다. 고객은 자신의 SOCKS 프록시가 사용 가능하며 작동하고 있는지 확인해야 합니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>알림이 전송되었으나 디바이스에 도달하지 않음</h4></div>
  <div class="panel-body">
    <p>알림은 즉시 전송되거나 지연될 수 있습니다. 이 지연시간은 몇 초이거나 몇 분일 수도 있습니다. 원인에는 다양한 이유가 있을 수 있습니다. </p>
    <ul>
        <li>{{ site.data.keys.mf_server }}는 알림이 중개자 서비스에 도달하면 알림을 제어할 수 없게 됩니다. </li>
        <li>디바이스의 네트워크 또는 온라인 상태(디바이스 켜짐/꺼짐)를 고려해야 합니다. </li>
        <li>방화벽 또는 프록시가 사용되었는지 확인하고, 사용된 경우에는 중개자와의 통신을 차단하도록 구성되지 않았는지 확인하십시오. </li>
        <li>방화벽에서 GCM/APNS/WNS 중개자에 대해 실제 중개자 URL을 사용하는 대신 선택적으로 IP를 화이트리스트에 추가하지 마십시오. 중개자 URL은 어떤 IP로도 해석될 수 있으므로 이는 문제를 발생시킬 수 있습니다. 고객은 IP가 아니라 URL에 대해 액세스를 허용해야 합니다. Telnet을 사용하여 중개자 URL에 연결함으로써 중개자 연결을 확인하는 것은 불완전할 수 있다는 점을 유의하십시오. 특히 iOS의 경우 이는 아웃바운드 연결만을 증명할 뿐입니다. 실제 전송은 TCP 소켓을 통해 이뤄지며 Telnet은 이를 보장하지 않습니다. 특정 IP 주소만을 허용하면 다음과 같은 오류가 발생할 수 있습니다. 예를 들어 GCM의 경우: <blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>iOS에서 일부 알림만 디바이스에 도달함</h4></div>
  <div class="panel-body">
    <p>Apple의 QoS는 <b>통합 알림(coalescing notifications)</b>을 정의합니다. 이는 알림이 디바이스에 즉시 전달될 수 없는 경우 APNS 서버가 1개의 알림만 서버에 보존함을 의미합니다(토큰을 통해 식별됨). 예를 들어, 5개의 알림이 차례대로 디스패치되었습니다. 디바이스가 연결된 네트워크의 상태가 좋지 않아 첫 번째 알림이 전달되고 두 번째 알림이 APNS 서버에 임시로 저장되었습니다. 그 후 세 번째 알림이 디스패치되어 APNS 서버에 도달합니다. 이제 이전(전달되지 않은) 두 번째 알림이 버려지고 세 번째 알림(최신 항목)이 저장됩니다. 일반 사용자에게 이는 누락된 알림으로 나타납니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Android에서 앱이 실행 중이며 포그라운드에 있는 경우에만 알림이 사용 가능함</h4></div>
  <div class="panel-body">
    <p>... 애플리케이션이 실행 중이 아닌 경우, 또는 애플리케이션이 백그라운드에 있는 경우 알림 창에 있는 알림을 눌러도 애플리케이션이 실행되지 않습니다. 이는 <b>strings.xml</b> 파일의 <b>app_name</b> 필드가 사용자 정의 이름으로 변경된 것이 원인일 수 있습니다. 이렇게 되면 <b>AndroidManifest.xml</b> 파일에 정의된 애플리케이션 이름과 의도된 조치가 일치하지 않습니다. 애플리케이션에 대해 다른 이름을 사용해야 하는 경우에는 대신 <b>app_label</b> 필드를 사용하거나, <b>strings.xml</b> 파일에서 사용자 정의된 정의를 사용하십시오. </p>
  </div>
</div>


<div class="panel panel-default">
  <div class="panel-heading"><h4>푸시 알림을 APNS에 전송할 때 SSLHandshakeExceptions 발생</h4></div>
  <div class="panel-body">
  <p>예: </p> <blockquote>ApnsConnection | com.ibm.mfp.push.server.notification.apns.Apns.Connectionlmpl sendMessage Failed to send message Message (Id=1;  Token=xxxx; Payload={"payload":{"\nid\":\"44b7f47\",\"tag\":\"Push.ALL\"}", "aps":{"alert":{"action-loc-key":null,"body":"TEST"}}})... trying again after delay javax.net.ssl.SSLHandshakeException:Received fatal alert: handshake_failure</blockquote>
<p>이 문제는 IBM JDK 1.8 JVM을 사용하는 경우에만 발생합니다. 솔루션은 IBM JDK 1.8을 버전 8.0.3.11 이상으로 업그레이드하는 것입니다. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>{{ site.data.keys.mf_console }}에서 푸시 서비스가 비활성으로 표시됨</h4></div>
  <div class="panel-body">
    <p>해당 .war 파일이 배치되었으며 <code>mfp.admin.push.url</code>, <code>mfp.push.authorization.server.url</code> 및 <code>secret</code> 특성이 <b>server.xml</b> 파일에서 올바르게 구성되었는데도 푸시 서비스가 비활성으로 표시됩니다. </p>
    <p>서버의 JNDI 특성이 MFP 관리자 서비스에 대해 올바르게 설정되었는지 확인하십시오. 예를 들면 이는 다음 항목을 포함해야 합니다. </p>

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
