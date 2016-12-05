---
title: Configuring MobileFirst Foundation 8.0 on Bluemix with on-prem custom registry for application authentication
date: 2016-08-05
tags:
- MobileFirst_Foundation
- Authentication
- WebDAV
- Security
version:
- 8.0
author:
  name: Vinod Appajanna
---

## Introduction
This article walks you through on how a Bluemix liberty app (in particular Mobile foundation) connects to a on premise filebased user repository that is published as a [WebDAV resource](http://www.webdav.org/) for authentication.

Basically WebDAV is a set of extensions to the HTTP protocol which allows users to collaboratively edit and manage files on remote web servers. One can access or share the files remotely over the Internet. This can be extended not just for authentication (as explained in this blog) but also for sharing the content across the liberty app instances.

![Authentication flow]({{site.baseurl}}/assets/blog/2016-08-06-mfp-liberty-app-using-custmomuserreg-as-webdav-resource-on-bluemix/MFPCustUserReg.png)

## See in action
Here is a YouTube demo that shows how to create/add a custom user registry as a liberty feature, configure a secure gateway &amp; WebDAV for liberty app and login to the registry. I have also briefed the steps that are part of video in the below sections. If you want to skip some sections in the video and move directly to a particular section then you can do so by clicking the [video clip] links.

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/TL1z7sQQb-Y"></iframe>
  </div>
</div>
<p style="text-align: center;">Full Video Demo - Bluemix liberty app authenticating with on-prem custom userregistry</p>
</br>


## Create a Custom User registry as liberty feature
* Prerequisite (installations):
 - Install Libety buildtools/WebSphere Application developer tools in the eclipse
 - Install "WAS Liberty with OSGI Application" in the eclipse
* Create a OSGi Bundle project [[video clip]](http://www.youtube.com/watch?v=TL1z7sQQb-Y&t=6m26s)
* Import the following packages as a dependency in OSGi bundle project

    ```
    com.ibm.websphere.security
    com.ibm.websphere.security.cred
    org.osgi.framework
    org.osgi.service.cm
    ```

* Copy the sample Activator.java and FileRegistrySample.java to the project
* Create a new liberty Feature and export the bundles created above as .esa file.
* Install the feature to Liberty server [[video clip]](http://www.youtube.com/watch?v=TL1z7sQQb-Y&t=12m08s)
	- cd "liberty-bin-dir" eg: `cd /usr/CustomUserRegWebDavDemo/mfp-server-all-in-one/mfp-server/bin`
	- `sudo ./featureManager install CustUserRegWebDavFeature.esa`
  - Optional (to uninstall a feature):
	  `sudo ./featureManager uninstall CustUserRegWebDavFeature`
* server.xml changes to include the new feature:

```xml
<feature>usr:CustUserRegWebDavFeature</feature>
<customUserRegistry usersFile="http://cap-sg-stage-5.integration.ibmcloud.com:15217/userregistry/users.props" groupsFile="http://cap-sg-stage-5.integration.ibmcloud.com:15217/userregistry/groups.props">
</customUserRegistry>
```

So, now we are done with creating the liberty feature and adding it to the server.xml.

## Enabling WebDAV on remote machine [[video clip]](http://www.youtube.com/watch?v=TL1z7sQQb-Y&t=16m08s)

* Enabling IIS server and WEBDAV on Windows Machine
 - Under Windows features turn on the following features
   * Internet Information Services
   * IIS Management Console
   * WebDAV Publishing
   * Windows Authentication
* Copy the users and groups file registries and expose the same as a WEBDAV resource.

##Configure Secured Gateway to connect to On-Prem [[video clip]](http://www.youtube.com/watch?v=TL1z7sQQb-Y&t=20m26s)

* Create a SG service and add the destination
* On the Client SG
  - Connect to the server by entering the SG ID
  - Add host and port to the Access list

## Update server.xml, prepare, push the liberty app to Bluemix and login [[video clip]](http://www.youtube.com/watch?v=TL1z7sQQb-Y&t=24m35s)

* Update the userFile and groupFile attribute to point it to WebDAV resource/Custom user registry
* Zip the App
* Push the App
* Login to the App

Note: To install the app on to Bluemix you need to install [cloudfoundry](https://console.ng.bluemix.net/docs/cli/cliplug-in.html) plugin on your system and then login.

## Sample
[Download sample for OSGi Liberty feature](https://github.com/vinapp/liberty-customreg-as-webdavres)

## References

1. [WebDAV Introduction](http://www.webdav.org/)
2. [Installing and Configuring WebDAV on linux/apache](http://www.cyberciti.biz/faq/rhel-fedora-linux-apache-enable-webdav/)
3. [Installing and Configuring WebDAV on Windows](http://www.iis.net/learn/install/installing-publishing-technologies/installing-and-configuring-webdav-on-iis)
4. [Access Files Using WebDAV - All Platform](http://www2.le.ac.uk/offices/itservices/ithelp/my-computer/files-and-security/work-off-campus/webdav)
5. [About Implementing Custom User registry as a liberty feature](https://developer.ibm.com/wasdev/docs/creating-a-custom-user-registry-as-a-liberty-user-feature/)
