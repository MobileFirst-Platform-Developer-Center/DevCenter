---
layout: tutorial
title: Windows Quick Start
---
<br>
<p>The purpose of this demonstration is to make you experience an end-to-end flow where the MobileFirst Platform Foundation SDK for Windows 8 and Windows 10 is integrated into a Visual Studio project and used to retrieve data by using a MobileFirst adapter.</p>

<p>To learn more about, <a href="../windows-8-tutorials">visit the Native Windows 8 Development</a> or <a href="../windows-10-tutorials">Native Windows 10 Development</a> tutorial pages.

<p><b>Prerequisite:</b> Make sure that you have installed the following software:</p>
<ul>
    <li><a href="{{site.baseurl}}/downloads/">MobileFirst Platform command line tool</a></li>
    <li>Visual Studio 2013</li>
</ul>

<p><b>Select a Windows release:</b></p>


<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseWindows8" aria-expanded="true" aria-controls="windows8">Quick Start Windows 8</a>
            </h4>
        </div>

        <div id="collapseWindows8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows8">
            <div class="panel-body">
                <ol>
    <li>
        <h3>Create a MobileFirst project and adapter.</h3>
        <ul>
            <li><h4>Create a new project and Windows 8 Universal framework/server-side application entity.</h4>
                [code lang="shell"]
                mfp create MyProject
                cd MyProject
                mfp add api MyWin8Universal -e windows8
                [/code]
            </li>
            <li><h4>Add an HTTP adapter to the project.</h4>
                [code firstline="4" lang="shell"]
                mfp add adapter MyAdapter -t http
                [/code]
            </li>
        </ul>
    </li>
    <li>
        <h3>Deploy artifacts to the MobileFirst Server.</h3>
        <ul>
            <li><h4>Start the MobileFirst Server and deploy the server-side application entity and adapter.</h4>
                [code firstline="5" lang="shell"]
                mfp start
                mfp push
                [/code]
            </li>
        </ul>
    </li>
    <li><h3>Create a Visual Studio Windows 8 Universal project.</h3></li>
     <li><h3>Add a reference to the following libraries in your project:</h3>

 <ul>
<li><code>worklight-windowsphone8.dll</code></li>
<li><code>Newtonsoft.Json.dll</code></li>
<li><code>SharpCompress.dll</code></li>
</ul>
    </li>
    <li>
        <h3>Implement the MobileFirst adapter invocation.</h3>
        <ul>

            <li>The following code invokes an adapter:
[code lang="csharp"]
WLResourceRequest request = new WLResourceRequest("/adapters/MyAdapter/getStories", "GET");
request.setQueryParameter("params","technology");
MyInvokeListener listener = new MyInvokeListener();
request.send(listener);
[/code]
            </li>
        </ul>
    </li>
    <li><h3>Final configurations</h3>

<ul>
   <li>Copy the <code>wlclient.properties</code> file to the root of the native Windows Universal project.</li>
</ul>

<ul>
   <li>In Visual Studio, open the Properties window of <code>wlclient.properties</code> and set the <strong>Copy to Output Directory </strong> option to <strong>Copy always</strong>.</li></ul>

<ul>
   <li>Supply the server IP address to the <code>wlServerHost</code> property in <code>wlclient.properties</code>.</li>
</ul>

<ul>
   <li>Add the following capabilities to the <code>Package.appxmanifest</code> file:
<h4>Internet (Client and Server)
Private Networks (Client and Server)</h4></li>
</ul>

    </li>
    <li><h3>Click <strong>Run</strong>.</h3>
Review the Visual Studio console for the data retrieved by the adapter request.

    </li>
</ol>

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/VisualStudioConsole.png"><img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/VisualStudioConsole-1024x405.png" alt="VisualStudioConsole" width="980" height="388" class="aligncenter size-large wp-image-14788" /></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseWindows10" aria-expanded="true" aria-controls="windows10">Quick Start Windows 10</a>
            </h4>
        </div>

        <div id="collapseWindows10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows10">
            <div class="panel-body">
                <ol>
    <li>
        <h3>Create a MobileFirst project and adapter.</h3>
        <ul>
            <li><h4>Create a new project and Windows 8 Universal framework/server-side application entity.</h4>
                [code lang="shell"]
                mfp create MyProject
                cd MyProject
                mfp add api MyWin8Universal -e windows8
                [/code]
            </li>
            <li><h4>Add an HTTP adapter to the project.</h4>
                [code firstline="4" lang="shell"]
                mfp add adapter MyAdapter -t http
                [/code]
            </li>
        </ul>
    </li>
    <li>
        <h3>Deploy artifacts to the MobileFirst Server.</h3>
        <ul>
            <li><h4>Start the MobileFirst Server and deploy the server-side application entity and adapter.</h4>
                [code firstline="5" lang="shell"]
                mfp start
                mfp push
                [/code]
            </li>
        </ul>
    </li>
    <li><h3>Create a Visual Studio Windows 8 Universal project.</h3></li>
     <li><h3>Add a reference to the following libraries in your project:</h3>

 <ul>
<li><code>worklight-windowsphone8.dll</code></li>
<li><code>Newtonsoft.Json.dll</code></li>
<li><code>SharpCompress.dll</code></li>
</ul>
    </li>
    <li>
        <h3>Implement the MobileFirst adapter invocation.</h3>
        <ul>

            <li>The following code invokes an adapter:
[code lang="csharp"]
WLResourceRequest request = new WLResourceRequest("/adapters/MyAdapter/getStories", "GET");
request.setQueryParameter("params","technology");
MyInvokeListener listener = new MyInvokeListener();
request.send(listener);
[/code]
            </li>
        </ul>
    </li>
    <li><h3>Final configurations</h3>

<ul>
   <li>Copy the <code>wlclient.properties</code> file to the root of the native Windows Universal project.</li>
</ul>

<ul>
   <li>In Visual Studio, open the Properties window of <code>wlclient.properties</code> and set the <strong>Copy to Output Directory </strong> option to <strong>Copy always</strong>.</li></ul>

<ul>
   <li>Supply the server IP address to the <code>wlServerHost</code> property in <code>wlclient.properties</code>.</li>
</ul>

<ul>
   <li>Add the following capabilities to the <code>Package.appxmanifest</code> file:
<h4>Internet (Client and Server)
Private Networks (Client and Server)</h4></li>
</ul>

    </li>
    <li><h3>Click <strong>Run</strong>.</h3>
Review the Visual Studio console for the data retrieved by the adapter request.

    </li>
</ol>

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/VisualStudioConsole.png"><img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/VisualStudioConsole-1024x405.png" alt="VisualStudioConsole" width="980" height="388" class="aligncenter size-large wp-image-14788" /></a>
            </div>
        </div>
    </div>
</div>
