---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Windows 8 Univeral Applications
breadcrumb_title: Windows 8 Universal SDK
relevantTo: [windows8]
weight: 4
---
<h2>Overview</h2>
<p>To serve a native Windows 8 Universal application, MobileFirst Server must be aware of it. For this purpose, IBM MobileFirst Platform Foundation provides a Native API library, which contains a set of APIs and configuration files.</p>
<p>This tutorial explains how to generate the Windows 8 Universal Native API and how to integrate it with a native Windows Universal application. These steps are necessary for you to be able to use it later on for tasks such as connecting to MobileFirst Server, invoking adapter procedures, implementing authentication methods, and so on.</p>
<p><strong>Prerequisite:</strong> Developers are expected to be proficient with Microsoft developer tools.</p>
<h2>Creating and deploying a MobileFirst native API</h2>
<h3>CLI</h3>
<ol>
<li><a href="../../advanced-client-side-development/using-cli-create-build-manage-project-artifacts/">Using the CLI</a>, create a new MobileFirst project: <code>$ mfp create HelloWorldNative</code></li>
<li>Go to the newly created project directory: <code>$ cd HelloWorldNative/</code></li>
<li>Add a new Windows Universal native API: <code>$ mfp add api Win8HelloWorld -e windows8</code></li>
<li>Navigate into the native API folder and run the command: <code>$ mfp push</code>. <strong>Note:</strong> This action is required for MobileFirst Server to recognize the application if it attempts to connect.</li>
</ol>

<h3>Manually adding the MobileFirst Native SDK</h3>

To import worklight studio packages, NuGet package manager is used.
NuGet is the package manager for the Microsoft development platform including .NET. The NuGet client tools provide the ability to produce and consume packages. The NuGet Gallery is the central package repository used by all package authors and consumers.
<br>
Follow the instructions to manually add MobileFirst native SDK to
an existing or new Windows 8 Univeral application.

<ol>
<li>
Create a Windows 8 Universal project using Visual Studio 2013/2015 or use an existing project.
</li>
<li>
Right click the project solution and navigate -> Manage Nuget packages for solution.
</li>
<li>
In the search option , search for IBM MobileFirst Platform. Choose IBM.MobileFirstPlatform.8.0.0.0.
</li>
<li>
Click Install. This installs the IBM MobileFirstPlatform Native SDK and its dependencies.
</li>
</ol>
Alternatively,
<br/>
<br/>

<ol>
<li>
Browse to https://www.nuget.org/packages
</li>
<li>
Search for IBM MobileFirstPlatform SDK
</li>
<li>
Download IBM.MobileFirstPlatform.8.0.0.0.nupkg to your filesystem.
</li>
<li>
Open Visual Studio 2013/2015. Click on Tools -> NuGet Package Manager -> Package Manager Settings.
Select Package Sources
Click Add (+)
Give some name to your package and choose the path to your .nupkg file and click update.
Close the dialog. 	
</li>
<li>
 In Solution explorer, right click on the Solution| Manage NuGet Packages for Solution...
Select the source you created in Step 1 or search for IBM MobileFirst Platform in search tab
Choose IBM MobileFirst Platform
</li>
<li> Click on Install 	</li>
</ol>

<p>The MobileFirst native API contains several components:</p>
<ul>
<li><code>worklight-windows8.dll</code> is a MobileFirst API library that you must copy to your native Windows 8 Universal project. This is contained within the "buildtarget" folder , under the respective hardware architecture.</li>
<li><code>Newtonsoft.Json.dll</code> is a library that provides JSON support.</li>
<li><code>SharpCompress.dll</code> is a library that provides compression support.</li>
<li><code>application-descriptor.xml</code> defines application metadata and security settings that MobileFirst Server enforces.</li>
<li><code>mfpclient.resw</code> contains connectivity settings that a native Windows Universal application uses. You must copy this file to your native Windows Universal project.</li>
<li>As with any MobileFirst project, you create the server configuration by modifying the files that are in the <code>server\conf</code> folder.</li>
</ul>
<h2>mfpclient.resw</h2>
<p>You can edit the <em>wlclient.properties</em> file to set connectivity information.</p>
<ul>
<li>wlServerProtocol – The communication protocol to MobileFirst Server, which is either http or https.</li>
<li>wlServerHost – The host name of the MobileFirst Server instance.</li>
<li>wlServerPort – The port of the MobileFirst Server instance.</li>
<li>wlServerContext – The context root path of the application on MobileFirst Server.</li>
<li>wlAppId – The application ID as defined in the <code>application-descriptor.xml</code> file.</li>
<li>wlAppVersion – The application version.</li>
<li>wlEnvironment – The target environment of the native application.</li>
<li>wlPlatformVersion – The MobileFirst Studio version.</li>
<li>languagePreferences – The list of preferred locales.</li>
</ul>
<h2>Creating and configuring a Windows Universal native application</h2>
<ol>
<li>Create a Windows Universal Application project or use an existing one.</li>
<li>Add as a <em>reference</em> <code>worklight-windows8.dll</code>, <code>Newtonsoft.Json.dll</code> and <code>SharpCompress.dll</code> files.Choose the right <code>worklight-windowsphone8.dll</code> from the folder that matches the architecture of the target device (ARM/x64/x86).</li>
<li>Copy the <code>mfpclient.reswcode> file to the root of the native project.</li>
<li>In Visual Studio, open the <strong>Properties</strong> window of the <code>mfpclient.resw</code> file and set the <strong>Copy to Output Directory</strong> option to <strong>Copy always</strong>.</li>
<li>Add the following capabilities to the <code>Package.appxmanifest</code>:<br />
<em>Internet (Client &amp; Server)</em><br />
<em>Private Networks (Client &amp; Server)</em></li>
</ol>
<blockquote><p>For more information, see the topic about developing native C# applications for Windows Universal, in the user documentation.</p></blockquote>
<h2 id="next">Tutorials to follow next</h2>
<p>Now that your application contains the Native API library, you can follow the tutorials in the <a href="../../native/windows8/">Native Windows 8 Development</a> section to learn more about authentication and security, server-side development, advanced client-side development, notifications and more.</p>
