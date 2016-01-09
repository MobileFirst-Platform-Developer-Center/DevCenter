---
layout: tutorial
title: Using the MobileFirst Platform Operations Console
relevantTo: [ios,android,windows,cordova]
weight: 6
---
## Overview
The MobileFirst Platform Operations Console is a web-based UI which enables simplified work flows for both the developer and the administrator to create, monitor, secure and administer applications &amp; adapters.

#### Jump to:

* [Accessing the console](#accessing-the-console)
* [Console actions](#console-actions)

## Accessing the console
The MobileFirst Operations Console can be accessed in the following ways:

### From a locally installed MobileFirst Server
#### Desktop Browser
From your browser of choice, load the URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).

#### Command-line
From a **Terminal** window, with the MobileFirst CLI installed, run the command: <code>mfpdev server console</code>

#### MobileFirst Studio
<span style="color:red">From MobileFirst in Eclipse, click on **Open MobileFirst Console**</span>.

![Image showing how to access the console from MobileFirst Studio]()

### From a remotely installed MobileFirst Server
#### Desktop Browser
From your browser of choice, load the URL <code>http://the-server-host:server-port-number/mfpconsole</code>  
The host server can be a customer-owner server, or running on a service such as Bluemix.

#### Command-line
From a **Terminal** window, with the MobileFirst CLI installed, 

1. Add a remote server definition:

    *Interactive Mode*  
    Run the command: <code>mfpdev server add</code> and follow the on-screen instructions.

    *Direct Mode*  
    Run the command with the following structure: <code>mfpdev server add [server-name] --URL [remote-server-URL] --login [admin-username] --password [admin-password] --contextroot [admin-service-name]</code>. For example:

    ```bash
    mfpdev server add MyRemoteServer http://my-remote-host:9080/ --login TheAdmin --password ThePassword --contextroot mfpadmin
    ```

2. Run the command: <code>mfpdev server console MyRemoteServer</code>

> Learn more about the various CLI commands in the [Using CLI to manage MobileFirst artifacts](../../client-side-development/using-cli-to-manage-mobilefirst-artifacts/) tutorial.

## Navigating the console
<span style="color:red">Show the various pages in the console and what can be done in each of them</span>


## OLD CONTENT:

<h4>Application access</h4>
<p>By using the Remote Disable feature, an administrator can deny a user access to a certain application version, due to phase-out policy or due to security issues encountered in the application.</p>
<h4>Authenticity</h4>
<p>Learn more about application authenticity in the <a href="../../authentication-security/application-authenticity/">Application Authenticity tutorial</a>.</p>

<h2 id="consoleActions">Console actions</h2>
<h3>License tracking</h3>
<p>License terms vary depending on which edition (Enterprise or Consumer) of MobileFirst Platform Foundation is being used. License tracking is enabled by default and tracks metrics relevant to the licensing policy, such as active client devices and installed applications. This information helps determine whether the current usage of MobileFirst Platform is within the license entitlement levels and can prevent potential license violations.</p>
<p>By tracking the usage of client devices and determining whether the devices are active, administrators can decommission devices that should no longer be accessing the service. This situation might arise if an employee has left the company, for example.</p>
<blockquote><p>For more information, see the topic about license tracking, in the user documentation.</p></blockquote>

<h3>Devices</h3>
<p>Administrators can search for devices that access the MobileFirst Server and can manage access rights.</p>
<p>You can search for devices on the user ID or on a friendly name.</p>
<ul>
<li>The user ID is the identifier that was used to log in to the authentication realm.</li>
<li>A friendly name is a name that is associated with the device to distinguish it from other devices that share the user ID. You can set the friendly name on the client by using the client-side JavaScript APIs: <code>WL.Device.getFriendlyName</code> and <code>WL.Device.setFriendlyName</code>.
</li>
</ul>
<blockquote><p>For more information, see the topic about device access management in the MobileFirst Operations Console, in the user documentation.</p></blockquote>

<h3>Client log profiles</h3>
<p>Related tutorial: <a href="../../advanced-client-side-development/remote-controlled-client-side-log-collection/">Remote controlled client-side log collection</a></p>
<p>Administrators can use log profiles to adjust client logger configurations, such as log level and log package filters, for any combination of operating system, operating system version, application, application version, and device model.</p>
<p>When an administrator creates a configuration profile, the log configuration is concatenated with responses to explicit WLClient <code>connect</code> and <code>invokeProcedure</code>/<code>WLResourceRequest</code> API calls, and is applied automatically.</p>
<blockquote><p>For more information, see the topic about client-side log capture configuration from MobileFirst Operations Console, in the user documentation.</p></blockquote>

<h3>Errors log</h3>
<p>The Errors log shows a list of the failed management operations that were initiated from the MobileFirst Operations Console, or from the command line, on the current runtime environment. Use the log to see the effect of the failure on the servers.</p>
<blockquote><p>For more information, see the topic about error log of operations on runtime environments, in the user documentation.</p></blockquote>

<h3>Audit log</h3>
<p>The audit log provides information on administration operations such as login, logout, deploying apps or adapters, or locking apps. You can disable the audit log by setting the <code>ibm.worklight.admin.audit</code> JNDI property on the web application of the MobileFirst Administration Service (<code>worklightadmin.war</code>) to <code>false</code>.</p>
<blockquote><p>For more information, see the topic about audit log of administration operations, in the user documentation.</p></blockquote>
