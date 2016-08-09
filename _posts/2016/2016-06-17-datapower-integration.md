---
title: Protecting IBM MobileFirst Foundation 8.0 application traffic using IBM DataPower
date: 2016-06-17
tags:
- MobileFirst_Platform
- DataPower
version:
- 8.0
author:
  name: Nathan Hazout
---
> **Note:** This article was written for MobileFirst Foundation 8.0. For a similar topic on 7.1 see [Protecting IBM MobileFirst Platform Foundation application traffic using IBM DataPower]({{site.baseurl}}/blog/2016/02/20/datapower-integration/)

## Introduction
You can use IBM® WebSphere® DataPower® in the DMZ of your enterprise to protect MobileFirst mobile application traffic.

Protecting mobile application traffic that comes into your network from customer and employee devices involves preventing data from being altered, authenticating users, and allowing only authorized users to access applications. To protect mobile application traffic that is initiated by a client MobileFirst application, you can use the security gateway features of IBM WebSphere DataPower.

Enterprise topologies are designed to include different zones of protection so that specific processes can be secured and optimized. You can use IBM WebSphere DataPower in different ways in the DMZ and in other zones within your network to protect enterprise resources. When you start to build out MobileFirst applications to be delivered to the devices of your customers and employees, you can apply these methods to mobile traffic.

You can use IBM WebSphere DataPower as a front-end reverse proxy and security gateway. DataPower uses a multiprotocol gateway (MPGW) service to proxy and secure access to MobileFirst mobile applications.

> This article assumes prior knowledge of other MobileFirst features, such as challenge handlers.

> **Note:** This article is based on the older LTPA integration. For the newer **DataPower as the OAuth authorization server** integration, [consult the documentation](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/t_datapower_as_authorization_server.html).

## Supported versions
This pattern, samples and blog post were designed to work with DataPower 7.0.0.10 and MobileFirst Foundation 8.0. The supported platforms are currently Android, iOS and Cordova.

This also requires MobileFirst Foundation to run on an application server that supports LTPA tokens.

## Flow
### Initial flow
![Initial Flow]({{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/initial-flow.jpg)

### Logout flow
![Logout flow]({{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/logout-flow.jpg)

### Expired flow
![Expired flow]({{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/expired-flow.jpg)

## Setting up your MobileFirst application
Create a MobileFirst application, with any application logic you need, such as adapter calls. Start by designing your application without any security to make sure everything works without DataPower.

### Challenge Handler

The DataPower pattern provided here will send an HTML login form when trying to access a protected resource. You can use a `GatewayChallengeHandler` to detect the incoming login form, by searching the response for a known string, such as `j_security_check`. DataPower then expects you to submit the login form with the credentials.

- The form's action URL is `/j_security_check`.
- The form you submit back needs to contain 2 elements: `j_username` and `j_password`.

`GatewayChallengeHandler` are different from the more common `SecurityCheckChallengeHandler` in that you are responsible for detecting whether the current response needs to be handled.

Below is an example for Cordova applications.

You can also download the linked samples for Cordova, Android or iOS.

Declare the challenge handler. The name you put as a parameter is not important:

```js
var dataPowerChallengeHandler = WL.Client.createGatewayChallengeHandler("LtpaBasedSSO");
```

Implement `canHandleResponse` to determine whether the current HTTP response is relevant for this challenge handler. With this DataPower pattern, I look for the string `j_security_check`:

```js
dataPowerChallengeHandler.canHandleResponse = function(response) {
    if (!response || response.responseText === null) {
        return false;
    }
    var indicatorIdx = response.responseText.search('j_security_check');

    if (indicatorIdx >= 0) {
        return true;
    }

    return false;
};
```

The method `handleChallenge` will be called when `canHandleResponse` returns `true`. This method can show your own login form here. Assuming that `#auth` contains the necessary HTML to collect the credentials:

```js
dataPowerChallengeHandler.handleChallenge = function(response) {
    document.getElementById('result').style.display = 'none';
    document.getElementById('auth').style.display = 'block';
};
```

Clicking the submit button should trigger `submitLoginForm`, passing the credentials as parameters:

```js
document.getElementById("AuthSubmitButton").addEventListener("click", function() {
    var reqURL = '/j_security_check';
    var options = {};
    options.parameters = {
        j_username: document.getElementById('AuthUsername').value,
        j_password: document.getElementById('AuthPassword').value
    };
    dataPowerChallengeHandler.submitLoginForm(reqURL, options, dataPowerChallengeHandler.submitLoginFormCallback);
});
```

The framework will call `submitLoginFormCallback` when the response returns. Check if the response is valid and then call `submitSuccess` to complete the authentication.

```js
dataPowerChallengeHandler.submitLoginFormCallback = function(response) {
    var isLoginFormResponse = dataPowerChallengeHandler.canHandleResponse(response);
    if (isLoginFormResponse) {
        dataPowerChallengeHandler.handleChallenge(response);
    } else {
        document.getElementById('result').style.display = 'block';
        document.getElementById('auth').style.display = 'none';
        dataPowerChallengeHandler.submitSuccess();
    }
};
```

### Mandatory Application Scope
DataPower will be responsible for the authentication and will communicate the status with the MobileFirst server via LTPA. To make sure that only requests with a valid LTPA token access your resources, your resources need to be protected by the security check `LtpaBasedSSO`.

One way to achieve this is to set a **Mandatory Application Scope** on your application. This will make sure that each application attempt at accessing a resource will be checked for LTPA first.

In the MobileFirst Operation Console, choose your application, then in the **Security** tab, look for **Mandatory Application Scope**. Click **Add a scope** and choose `LtpaBasedSSO` from the list.

Alternatively you can choose to protect individual resources with `LtpaBasedSSO`.

### server.xml
In your server, look for your *ltpa.keys* file. Write down the value for `com.ibm.websphere.ltpa.Realm` inside that file.

In your *server.xml*, look for the `<basicRegistry>` or `<ldapRegsitry>` element. Create one if it does not exist (instructions not covered here). Add a `realm` attribute to that element. The value for `realm` should be the value you wrote down above from your *ltpa.keys* file.

When using `<basicRegistry>`, make sure that the authorized users are listed here.

```xml
<basicRegistry realm="worklightRealm">
  <user name="admin" password="admin"/>
  <user name="fred" password="smith"/>
</basicRegistry>
```

To configure with LDAP, consult the documentation for your application server.

## DataPower configuration
### Import pattern
> The following was tested in DataPower XG45.7.0.0.10.

1. Download the [MFP\_LTPA\_Integration](https://raw.githubusercontent.com/nasht00/DataPowerIntegration/master/pattern/MFP_LTPA_Integration.zip) pattern file.
2. Create a new **Application Domain** in your DataPower instance, switch to this new domain.
3. Before deploying the pattern, you need to configure the **SSL Proxy Profile** that DataPower will use to support **HTTPS** requests from the clients. If you don't have one already, search for **SSL Proxy Profile** in the DataPower search bar and add a new profile. You may need to upload a certificate and private keys. Those steps are not covered here, please see DataPower documentation.
![SSL Proxy Profile]({{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/ssl-proxy-profile.png)
4. Go to your DataPower's **Blueprint Console**. Make sure you are logged in to that same domain.
5. Go to the **Patterns** tab.
6. Click on the *import* button (<img alt="import button" style="margin:0;display:inline" src="{{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/import-icon.png"/>), and upload the MFP\_LTPA\_Integration pattern you downloaded.
7. Click on the **Deploy...** button.
8. Fill in the details required to deploy the pattern.
	* The **destination** should be the full URL to your MobileFirst server context (`http(s)://hostname:port/ProjectName`). If your server requires SSL, you may need to specify an SSL profile.
	* The **HTTPS connection** sets the IP and port that remote clients will use to connect (`0.0.0.0` means any IP). This is the entry point to your application from the outside world. Because the *Front-side handler* uses HTTPS, you need to select the previously configured **SSL proxy profile** from the dropdown.
	* Upload the **LTPA** file (`ltpa.keys`) used in your MobileFirst server and type the password for this file (the default password for WebSphere is `WebAS`).
	* Use the same file and password for the second **LTPA** configuration.

	> Because of a known issue in DataPower firmwares 7.2 and above, the LTPA steps may not appear while deploying the pattern, in which case you need to configure the LTPA key manually after deploying the pattern.
9. **Deploy Pattern**
10. Back in your **Control Panel**, go to **Multi-Protocol Gateway** and verify that the *Op-State* is **up**.
	![status]({{site.baseurl}}/assets/blog/2016-02-20-datapower-integration/gateway-status.png)
11. Make sure your MobileFirst application is configured to communicate with your DataPower's IP and port. 	

### Default behavior with BasicRegistry
By default, this patterns checks the credentials against a hardcoded file called **local:///MyAAA.xml**, which contains a test user with username **fred** and password **smith**. This default is intended for development use only and should be modified for any deployment connected to an untrusted network. The user you want to test with needs to be in both DataPower's **MyAAA.xml** and the registry configured in Liberty's **server.xml** file.

For production deployments, it is likely that customers will want to adjust the authentication mechanism, for example to integrate with an external user registry or other security system.

You can do this by editing your *Multi-Protocol Gateway Policy*: In the DataPower search bar, search for **AAA Policy**. Edit the policy called **MFPIntegration\_Web\_HTTPS\_FormLTPA\_Form2LTPA**. In the **Authentication** tab, change the authentication **method**. For example, you can choose **Bind to LDAP server** to perform a simple bind against an LDAP compliant directory server.  The pattern supports the use of any valid DataPower AAA policy, however remember that the user identity returned from the authentication step must also exist in the Liberty user registry.

### Note regarding SSL
The pattern by default ONLY supports SSL. You are required to setup a **SSL Proxy Profile** for the pattern to be deployed.
Keep in mind that most mobile devices reject self-signed certificates by default (workaround not covered here).

During development, if you wish to open a non-SSL (HTTP) port, you need to modify the gateway:
In your Multi-Protocol Gateway, look for *Front side settings*. Add an **HTTP Front side handler**, choose a port for HTTP requests, and make sure to check `GET` in the list of allowed methods.

## Samples &amp; Pattern
You can download the samples and pattern from [GitHub](https://github.com/mfpdev/DataPowerLTPA/tree/release80).
There are 3 samples available:

- **DataPowerCordova** contains a Cordova sample.
- **DataPowerSwift** contains a native Xcode project.
- **DataPowerAndroid** contains a native Android Studio project.
- **pattern**: contains the DataPower pattern to use for those samples.

Each of those samples use the `ResourceAdapter` adapter which can be found on [GitHub](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/release80) as well.

Make sure to configure the *server.xml* and deploy the artifacts before running the samples.
