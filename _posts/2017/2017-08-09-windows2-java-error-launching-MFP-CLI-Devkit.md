---
title: MobileFirst CLI tools and Devkit installers fail to launch after Java 8.0 update on Windows machines.
date: 2017-08-23
tags:
- MobileFirst_Foundation
- CLI
- Devkit
- InstallAnywhere
version: 
 - 7.1
 - 8.0
author:
  name: Vivin Krishnan
---

## The issue

On Windows machines with Oracle Java 8 update 60 and above, IBM MobileFirst installers using InstallAnywhere technology fails with the following error:

![Windows2JVM]({{site.baseurl}}/assets/blog/2017-08-09-windows2-java-error-launching-MFP-CLI-Devkit/Windows2JVM.png) 

InstallAnywhere based IBM MobileFirst installers include IBM MobileFirst CLI Tool installers as well as IBM MobileFirst 8.0 DevKit installer. 

## The cause

Changes introduced by Oracle in Java 8 update 60 cause installers built using InstallAnywhere to fail with this error. The reason for this failure is because, with Oracle Java 8u60 and above, InstallAnywhere fails to automatically detect the location of the latest supported JVM, on the Windows machine.

To learn more about the issue, see this [article](https://flexeracommunity.force.com/customer/articles/ISSUE/The-Without-VM-Installer-Fails-To-Launch-Using-Java-8-Update-60-On-Windows).

## Resolution

One of the following approaches can be used to resolve the issue:

### Use an older version of the Java update

The issue is not seen with updates earlier to Java 8u60. Alternatively, use Java 7.

### Tell InstallAnywhere which JVM to use for the launch 

As mentioned in this [article](https://flexeracommunity.force.com/customer/articles/ISSUE/The-Without-VM-Installer-Fails-To-Launch-Using-Java-8-Update-60-On-Windows) to workaround this issue, launch the installer via command line and tell InstallAnywhere which JVM to use for the launch by using the `LAX_VM` parameter:

![Windows2JVM_workaround_CLI]({{site.baseurl}}/assets/blog/2017-08-09-windows2-java-error-launching-MFP-CLI-Devkit/Windows2JVM_workaround_CLI.png) 

![Windows2JVM_workaround_DevKit]({{site.baseurl}}/assets/blog/2017-08-09-windows2-java-error-launching-MFP-CLI-Devkit/Windows2JVM_workaround_DevKit.png) 
 
