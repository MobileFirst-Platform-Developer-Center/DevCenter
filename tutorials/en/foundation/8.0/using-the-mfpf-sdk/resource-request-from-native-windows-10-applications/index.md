---
layout: tutorial
title: Resource Request from Native Windows 10 Applications
relevantTo: [windows]
weight: 7
---
<ul>
<li class="download-sample">
<a href="https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures" target="_blank">Download MobileFirst project</a>
    </li>
<li class="download-sample">
<a href="https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresWP8" target="_blank">Download Native project</a>
    </li>
</ul>

<h2>Overview</h2>
<p>To create and configure a Windows Phone 8 (Silverlight) native project, first follow the <a href="../../configuring-the-mfpf-sdk/configuring-a-native-windows-phone-8-application-with-the-mfp-sdk/">Configuring a native Windows Phone 8 application with the MobileFirst Platform SDK</a> tutorial.</p>
<p>MobileFirst applications can access resources using the `WLResourceRequest` REST API.<br />
This tutorial explains how to use the `WLResourceRequest` API with an HTTP adapter.</p>
<h2 id="initialize">Initializing WLClient</h2>
<p>[code lang="csharp"]<br />
WLClient client = WLClient.getInstance();<br />
[/code]</p>
<ol>
<li>To establish a connection to MobileFirst Server, use the `connect` method by specifying the `MyConnectResponseListener` class instance as a parameter.<br />
[code lang="csharp"]<br />
client.connect(new MyConnectResponseListener(this));<br />
[/code]</p>
<p>The `WLClient` instance tries to connect to the MobileFirst Server instance according to the properties of the `wlclient.properties` file.<br />
After the connection is established, it invokes one of the methods of the `MyConnectResponseListener` class.
</li>
<li>Specify that the `MyConnectResponseListener` class implements the `WLResponseListener` interface.
<p>[code lang="csharp"]<br />
public class MyConnectResponseListener : WLResponseListener<br />
[/code]</p>
<p>The `WLResponseListener` interface defines two methods:</p>
<ul>
<li>`public void ``onSuccess (WLResponse response) { }`</li>
<li>`public void ``onFailure (WLFailResponse response) { }`</li>
</ul>
</li>
<li>Use the previous methods to process connection success or connection failure.
</li>
</ol>
<h2 id="invoke">Invoking an adapter procedure</h2>
<p>After the connection is established with a MobileFirst Server instance, you can use the `WLClient` instance to invoke adapter procedures.</p>
<ol>
<li>Create a `WLProcedureInvocationData` object with the adapter and procedure names.
</li>
<li>Add the required parameters as an object array and set request options (for example: Invocation Context).
</li>
<li>Get the existing `WLClient` instance and use it to invoke an adapter procedure.
</li>
<li>Specify the `MyInvokeListener` class instance as a parameter.
<p>[code lang="csharp"]<br />
WLProcedureInvocationData invocationData = new WLProcedureInvocationData(&quot;RSSReader&quot;, &quot;getFeed&quot;);<br />
invocationData.setParameters(new Object[]{});<br />
String myContextObject = &quot;InvokingAdapterProceduresWP8&quot;;<br />
WLRequestOptions options = new WLRequestOptions();<br />
options.setInvocationContext(myContextObject);<br />
WLClient.getInstance().invokeProcedure(invocationData, new MyInvokeListener(this), options);<br />
[/code]
</li>
</ol>
<h2 id="response">Receiving a procedure response</h2>
<p>After the procedure invocation is completed, the `WLClient` instance calls one of the methods of the `MyInvokeListener` class.<br />
As before, you must specify that the `MyInvokeListener` class implements the `WLResponseListener` interface.</p>
<p>[code lang="csharp"]<br />
using IBM.Worklight;<br />
namespace InvokingAdapterProceduresWP8{<br />
  public class MyInvokeListener : WLResponseListener<br />
    { }<br />
{<br />
[/code]</p>
<p>The `onSuccess` and `onFailure` methods are invoked by the `WLClient`. The response object contains the response data. You can use its methods and properties to retrieve the required information.</p>
<p>[code lang="csharp"]<br />
public void onSuccess(WLResponse response)<br />
{<br />
    WLProcedureInvocationResult invocationResponse = ((WLProcedureInvocationResult) response);<br />
    JObject items;<br />
    try<br />
    {<br />
        items = invocationResponse.getResponseJSON();<br />
        Deployment.Current.Dispatcher.BeginInvoke(() =&gt;<br />
        {<br />
            myMainPage.AddTextToReceivedTextBlock(&quot;Response Success: &quot; + items.ToString());<br />
        });<br />
    }<br />
    catch (JsonReaderException e)<br />
    {<br />
        Deployment.Current.Dispatcher.BeginInvoke(() =&gt;<br />
        {<br />
            myMainPage.AddTextToReceivedTextBlock(&quot;JSONException : &quot; + e.Message);<br />
        });<br />
    }<br />
}</p>
<p>public void onFailure(WLFailResponse response)<br />
{<br />
    Deployment.Current.Dispatcher.BeginInvoke(() =&gt;<br />
    {<br />
        myMainPage.AddTextToReceivedTextBlock(&quot;Response failed: &quot; + response.ToString());<br />
    });<br />
}<br />
[/code]</p>
<h2 id="sample">Sample application</h2>
<p><a href="https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures" target="_blank">Click to download</a> the MobileFirst project.</p>
<p><a href="https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresWP8" target="_blank">Click to download</a> the Native project.</p>
<ul>
<li>The `InvokingAdapterProcedures` project contains a <strong>MobileFirst Native API</strong> to deploy to MobileFirst Server.</li>
<li>The `InvokingAdapterProcedures` project contains a <strong>native Windows Phone 8 application</strong> that uses a MobileFirst native API library to communicate with a MobileFirst Server instance.</li>
</ul>
<p>Make sure to update the `wlclient.properties` file in `NativeWP8Invoking` with the relevant server settings.</p>
<p><a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/04_10_results.jpg"><img src="{{ site.baseurl }}/assets/backup/04_10_results.jpg" alt="04_10_results" width="367" height="660" class="aligncenter size-full wp-image-3286" /></a></p>
