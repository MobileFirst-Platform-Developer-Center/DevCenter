---
layout: tutorial
title: The mobile client
relevantTo: [ios,android,windows,javascript]
weight: 5
---
## Overview
You can install applications on your mobile device with the Application Center mobile client.

The Application Center mobile client is the application that runs on your Android, iOS, Windows Phone, or Windows device. Only Windows Phone 8 is supported by the current version of the Application Center. You use the mobile client to list the catalog of available applications in the Application Center. You can install these applications on your device. The mobile client is sometimes referred to as the Application Center installer. This application must be present on your device if you want to install on your device applications from your private application repository.

### Prerequisites
Your system administrator must give you a user name and password before you can download and install the mobile client. The user name and password are required whenever you start the mobile client on your device. For Windows Store applications, the user name and password are required for the mobile client only at run time. For security reasons, do not disseminate these credentials. These credentials are the same credentials used to log in to the Application Center console.

## nstalling the client on an Android mobile device
You can install the mobile client, or any signed application marked with the installer flag, on your Android mobile device by entering the access URL in your browser, entering your credentials, and completing the required steps.

1. Start the browser on your mobile device.
2. Enter the following access URL in the address text field: `http://hostname:portnumber/applicationcenter/installers.html`

    Where hostname is the address of the server and portnumber is the number of the port where the Application Center is installed. Your system administrator can provide this information.

    The Application Center also provides an alternative URL for installing the client on a mobile device: `http://hostname:portnumber/applicationcenter/inst.html`. The page of this URL works better with some older or some nonstandard mobile web browsers. If the page installers.html does not work on your mobile device, you can use inst.html. This page is provided in English only and is not translated into other languages.

    If you try to open the page with HTTPS and use self-signed certificates, older Android browsers cannot open the page. In this case, you must use a non self-signed certificate or use another browser on the Android device, such as Firefox, Chrome, or Opera. In Android 4 and later, the Android browser displays a security warning about the SSL certificate, but lets you proceed to the website after confirmation that you consent to an unsafe connection.

3. Enter your user name and password. When your user name and password are validated, the list of compatible installer applications for your device is displayed in the browser. Normally, only one application, the mobile client, appears in this list.

4. If the web server uses a self-signed CA certificate, install the certificate at least once on the device. The Application Center administrator should provide the certificate; see [Managing and installing self-signed CA certificates in an Application Center test environment for details](../../../installation-configuration/production/appcenter/#managing-and-installing-self-signed-ca-certificates-in-an-application-center-test-environment).