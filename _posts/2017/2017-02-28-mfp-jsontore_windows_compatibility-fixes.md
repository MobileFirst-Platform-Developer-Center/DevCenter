---
title: Compatibility issues with cordova-windows and MobileFirst JSONStore Plugin
date: 2017-02-28
tags:
- MobileFirst_Foundation
- JSONStore
- Windows
version: 8.0
author:
  name: Srihari Kulkarni, Srutha Keerthi K, Shubha S
---
## Overview
In the last couple of weeks, we're seeing a few issues with the more recent versions of cordova-windows. This post is to give you a run down of the issues seen with different versions of cordova-windows and how to overcome them. Below is a list of compatibility issues and their solutions. 


###"An unhandled win32 exception occurred in WWAHost.exe" error is seen when executing an application with the JSON Store plugin added.  

![Win32 Exception]({{site.baseurl}}/assets/blog/2017-02-28-jsonstore-windows-compatibility/Win32Exception.png)

The external DLLs that are added on platform add from the JSONStore plugin have their **Package Action** property set to ***None***. For the **mfpclient.properties** file in your project, go to properties *(select the file in the project in VS and press F12)*, set the **Package Action** property to ***Content*** and the **Copy to Output Directory** property to ***Copy Always***. This will ensure that your project picks up the contents of the properties as a stream and makes it available to your project. 

![Set Properties]({{site.baseurl}}/assets/blog/2017-02-28-jsonstore-windows-compatibility/mfpclientProperties.png)

###*"PERSISTENT\_STORE_FAILURE"* error occurs when initializing a JSON Store collection on cordova-windows. 

For cordova-windows v4.4.3 and below, follow the properties setting of the referenced external DLLs **(sqlite3 and msvcr110)** similar to the workaround mentioned above. Set the **Package Action** property to ***Content*** and the **Copy to Output Directory** property to ***Copy Always***. This occurs as the project will be unable to pick the DLLs content if the DLL's **Package Action** property is set to ***None***. 
 
![Set Properties]({{site.baseurl}}/assets/blog/2017-02-28-jsonstore-windows-compatibility/PackageActionSetting.png)

###UWP JSONStore projects error out during runtime with the following error : *"PERSISTENT\_STORE_FAILURE"* error on JsonStore initialization in release mode. 

This is because the dependent DLLs are not referenced in *Release* mode due to a bug in cordova as the runtime directives file is not added to the project. [A bug has been raised in Cordova Jira for this](https://issues.apache.org/jira/browse/CB-12499). 
 

To workaround this issue, you will have to add the "**Default.rd.xml**" file to the UWP app with the default content that is available for a Win 10 app which is : 

 ```
<Directives xmlns="http://schemas.microsoft.com/netfx/2013/01/metadata">
  <Application> 
    <!-- 
      An Assembly element with Name="*Application*" applies to all assemblies in 
      the application package. The asterisks are not wildcards. 
    --> 
    <Assembly Name="*Application*" Dynamic="Required All" /> 
  </Application> 
</Directives> 
 ```
 
This ensures that the dependent DLLs are referenced correctly even in *Release* mode. 
>Learn more on runtime directives here : [Runtime Directives](https://msdn.microsoft.com/en-us/library/dn600639%28v=vs.110%29.aspx)  


###JSONStore projects with ARM architecture do not run on win phone due to the runtime error *PERSISTENT\_STORE_FAILURE*. 

The root cause is that the DLLs are being picked from windows desktop folder of the DLLs source rather than the windows phone folder of the DLLs. This is due to a bug in cordova-plugin-mfp-jsonstore. 

To resolve this issue, remove the current DLL added to the project and add the dependent DLLs (namely sqlite3.dll and msvcr.dll) from the wp folder of the ARM arch DLLs from the path **&lt;*Your JSONStore Cordova Project's root folder*&gt;/plugins/cordova-plugin-mfp-jsonstore/src/windows/buildtarget/wp/ARM/&lt;*Add DLLs from here*&gt;**. The fix for this will be available in the future iFix. 
 
 
 ![WinPhone DLL Addition]({{site.baseurl}}/assets/blog/2017-02-28-jsonstore-windows-compatibility/RemoveAndAddDLL.png)
 
 