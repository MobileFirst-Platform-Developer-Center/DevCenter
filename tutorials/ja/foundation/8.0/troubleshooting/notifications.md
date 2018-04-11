---
layout: tutorial
title: プッシュ通知のトラブルシューティング
breadcrumb_title: Notifications
relevantTo: [ios,android,windows,cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下に、{{ site.data.keys.product }} プッシュ・サービスを使用する際に発生する可能性がある問題を解決するために役立つ情報を記載しています。

<div class="panel panel-default">
  <div class="panel-heading"><h4>プッシュ・サービスはさまざまな「配信に失敗しました」通知状況をどのように処理しますか?</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>GCM からの応答が「内部サーバー・エラーです」または「GCM サービスは使用不可です」の場合、通知の再送が試行されます。試行頻度は、「Retry-After」の値に基づいて決定されます。</li>
        <li>GCM に到達できない場合、エラーは <b>trace.log</b> ファイルに出力され、メッセージは再送されません。</li>
        <li>GCM は到達可能でも、障害を受け取った場合
            <ul>
                <li>「登録されていません」/「ID が無効です」/「ID が不一致です」/「登録がありません」は、デバイス ID の使用が無効か、GCM でのアプリケーションの登録が無効であるために発生した可能性があります。データベースで不整合なデータが発生することを避けるために、デバイス ID がデータベースから削除されます。通知は再送されません。</li>
                <li>メッセージが大きすぎる場合、メッセージの送信は再試行されず、ログが <b>trace.log</b> ファイルに記録されます。</li>
                <li>エラー・コード 401 の場合、認証エラーが原因の可能性があります。メッセージの送信は再試行されず、ログが <b>trace.log</b> ファイルに記録されます。</li>
                <li>エラー・コード 400 または 403 の場合、メッセージの送信は再試行されず、ログが <b>trace.log</b> ファイルに記録されます。</li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>APNS では、APNS 接続が閉じられた場合に再試行されます。APNS との接続を確立するために、3 回試行されます。その他の場合、再試行は行われません。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Xcode で「apns-environment」に関連するエラーが表示されます</h4></div>
  <div class="panel-body">
    <p>アプリケーションにサインインするために使用されるプロビジョニング・プロファイルでプッシュ機能が有効になっていることを確認します。これは、Apple Developer Portal のアプリケーション ID の設定ページで確認できます。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>APNS 通知の発送時にログに Java ソケット例外が記録され、通知がデバイスに到達しません</h4></div>
  <div class="panel-body">
    <p>APNS では、{{ site.data.keys.mf_server }} と APNS サービスの間に永続的ソケット接続が必要です。プッシュ・サービスはオープンしているソケットがあると想定し、通知を送信しようとします。しかし、多くの場合、顧客のファイアウォールは、未使用のソケットをクローズするように構成されています (プッシュは頻繁に使用されないことがあります)。そのような予期しないソケットのクローズはどちらのエンドポイントからも検出できません。これは、通常のソケットのクローズは、一方のエンドポイントでシグナルを送信し、他方のエンドポイントでは確認を送信する場合に発生するためです。プッシュ・サービスの発送がクローズされたソケットで試行されると、ログにはソケット例外が表示されます。</p>
    
    <p>これを回避するには、ファイアウォール・ルールで APNS ソケットが確実にクローズされないようにするか、<a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">プッシュ・サービスの JNDI プロパティー</a>である <code>push.apns.connectionIdleTimeout</code> を使用します。このプロパティーを構成することで、サーバーは、指定されたタイムアウト (ソケットのファイアウォール・タイムアウト未満) 内に APNS プッシュ通知に使用されるソケットを正常にクローズします。このようにして、顧客はファイアウォールによって不意にシャットダウンされる前にソケットをクローズできます。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>プッシュ通知を iOS デバイスに送信するときに SOCKS 関連エラーが発生します</h4></div>
  <div class="panel-body">
    <p>次に例を示します。<blockquote>java.net.SocketException: Malformed reply from SOCKS serverat java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    APNS 通知は TCP ソケットを介して送信されます。これにより、APNS 通知に使用されるプロキシーでは TCP ソケットがサポートされる必要があるという制限が発生します。(GCM で機能する) 通常の HTTP プロキシーはここでは十分ではありません。このため、APNS 通知の場合にサポートされる唯一のプロキシーは SOCKS プロキシーです。SOCKS プロトコル・バージョン 4 または 5 がサポートされます。SOCKS プロキシー経由で APNS 通知を送信するように JNDI プロパティーが構成されていても、このプロキシーが構成されていない、オフライン/使用不可、またはトラフィックをブロックする場合、例外がスローされます。顧客は、SOCKS プロキシーが使用可能で機能していることを確認する必要があります。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>通知は送信されたが、デバイスに到達しませんでした</h4></div>
  <div class="panel-body">
    <p>通知は即時に行われることも、遅延することもあります。遅延は数秒から数分になる場合があります。以下のようなさまざまな理由を考慮できます。</p>
    <ul>
        <li>{{ site.data.keys.mf_server }} では、メディエーター・サービスに到達した通知を制御できません。</li>
        <li>デバイスのネットワークまたはオンライン状況 (デバイスのオン/オフ) を考慮する必要があります。</li>
        <li>ファイアウォールまたはプロキシーが使用されているかどうかを確認し、使用されている場合は、メディエーターへの (およびメディエーターからの) 通信をブロックするように構成されていないことを確認してください。</li>
        <li>実際のメディエーター URL を使用する代わりに、GCM/APNS/WNS メディエーターについて IP をファイアウォールで選択的にホワイトリスト指定しないでください。メディエーター URL は任意の IP に解決されることがあるため、これによって問題が発生する可能性があります。顧客は、IP ではなく URL へのアクセスを許可する必要があります。メディエーター URL に telnet することでメディエーター接続が確保されるようにしても、必ずしも全体像を把握できるわけではないことに注意してください。特に iOS では、これはアウトバウンド接続を証明するだけです。実際の送信は TCP ソケット経由で行われ、telnet では保証されません。特定の IP アドレスのみを許可することで、例えば GCM では、以下のことが発生する可能性があります。<blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>iOS では、デバイスに到達する通知と到着しない通知があります</h4></div>
  <div class="panel-body">
    <p>Apple の QoS は、<b>合体通知</b>と呼ばれるものを定義します。これは、APNS サーバーが (トークンによって識別された) デバイスに通知を即時に配信できない場合に、サーバーで 1 つの通知のみを維持することを意味します。例えば、5 つの通知が次々に発送された場合について考えます。デバイスが不安定なネットワーク上にあり、最初の通知が配信され、2 番目の通知が APNS サーバーによって一時的に保管されたとします。それまでに、3 番目の通知が発送され、APNS サーバーに到達します。現在、以前の (配信されていない) 2 番目の通知は破棄され、3 番目 (最後の通知) は保管されます。エンド・ユーザーには、これは欠落している通知として現れます。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Android では、アプリケーションが実行中でフォアグラウンドにある場合にのみ通知が使用可能です</h4></div>
  <div class="panel-body">
    <p>... アプリケーションが実行中ではない場合、またはアプリケーションがバックグラウンドにある場合、通知の陰影で通知をタップしてもアプリケーションは起動しません。これは、<b>strings.xml</b> ファイルの <b>app_name</b> フィールドがカスタム名に変更されたために発生した可能性があります。これにより、<b>AndroidManifest.xml</b> ファイルで定義されたアプリケーション名と意図したアクションが一致しなくなります。アプリケーションに別の名前が必要な場合、<b>app_label</b> フィールドを代わりに使用するか、<b>strings.xml</b> ファイルでカスタム定義を使用する必要があります。</p>
  </div>
</div>


<div class="panel panel-default">
  <div class="panel-heading"><h4>プッシュ通知を APNS に送信すると SSLHandshakeExceptions が発生します</h4></div>
  <div class="panel-body">
  <p>次に例を示します。</p> <blockquote>ApnsConnection | com.ibm.mfp.push.server.notification.apns.Apns.Connectionlmpl sendMessage Failed to send message Message (Id=1;  Token=xxxx; Payload={"payload":{"\nid\":\"44b7f47\",\"tag\":\"Push.ALL\"}", "aps":{"alert":{"action-loc-key":null,"body":"TEST"}}})... trying again after delay javax.net.ssl.SSLHandshakeException:Received fatal alert: handshake_failure</blockquote>
<p>この問題は、IBM JDK 1.8 JVM の使用時にのみ検出されます。解決方法は、IBM JDK 1.8 をバージョン 8.0.3.11 以降にアップグレードすることです。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>プッシュ・サービスが {{ site.data.keys.mf_console }} で非アクティブと表示されます</h4></div>
  <div class="panel-body">
    <p>デプロイされている .war ファイルと、<code>mfp.admin.push.url</code>、<code>mfp.push.authorization.server.url</code>、および <code>secret</code> の各プロパティーが <b>server.xml</b> ファイルで正しく構成されている場合でも、プッシュ・サービスが非アクティブと表示されます。</p>
    <p>MFP 管理サービスに対してサーバーの JNDI プロパティーが正しく設定されていることを確認してください。これには、例えば以下のものが含まれている必要があります。</p>

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
