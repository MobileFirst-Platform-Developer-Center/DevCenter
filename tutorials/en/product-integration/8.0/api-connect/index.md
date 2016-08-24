---
layout: tutorial
title: API Connect
downloads:
  - name: Download MobileFirst APIC OAuthProvider
    url: https://hub.jazz.net/git/imflocalsdk/console-tools-and-sdks/contents/master/mobilefirst-ouath-provider_1.0.0.yaml
  - name: Download Sample Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80

---

## Overview
IBM API Connect is a  cloud-based API Management solution that allows you to design, control, secure, publish, manage, analyze, and scale your API with its simple-to-use configuration and coding platform.
To learn more about IBM API Connect, visit the [IBM API Connect Developer Center](https://developer.ibm.com/apiconnect/).  

Add IBM MobileFirst Platform Foundation security capabilities to your API Connect API by using the MobileFirst OAuthProvider Swagger template, which adds 2 capabilities:  
 1. Protect API Connect endpoints with the MobileFirst server as the authorization server.  
 2. Proxy MobileFirst client management requests and responses through DataPower to the MobileFirst server that is located behind the DMZ.  
 

<img src="cd_apic_mfpsecurityhld.png" width="700"/>

Currently the security integration of MobileFirst and API Connect is supported only when DataPower is used as the Gateway server ("Edge Gateway").  

Note that API Connect supports only HTTPS endpoints which may require the addition of API Connect certificates to your client application.


This documentation assumes that the user is familiar with the MobileFirst tutorial. We use the PinCode challenge sample that demonstrates basic Android credential validation. 


### Jump to:
* [Prerequisites](#prerequisites)
* [Protect the API Connect endpoint with MobileFirst as an authorization server](#protect-the-api-connect-endpoint-with-mobilefirst-as-an-authorization-server)
  * Import MobileFirst OAuthProvider template
  * Configure MobileFirst OAuthProvider template
  * Get the full URL path of MobileFirst OAuthProvider for /oauth2/authorize
  * Create Simple REST API
  * Protect the API using the MobileFirst OAuth Security Definition
  * Add APIs to the product and publish it
* [Update the sample MobileFirst client application](#update-the-sample-pincodeandroid-mobilefirst-client-application)
  * Update `wlclient.properties`
  * Update the `WLResourceRequest` request
  * Add HTTPS Certificate for the API Connect endpoint
* [Support for multiple MobileFirst OAuthProviders](#support-for-multiple-mobilefirst-oauthproviders)


## Prerequisites
* API Connect DataPower (Edge) version 5040 or later
* A MobileFirst Server V8 installed locally
* MobileFirst CLI and OpenSSL.
	To download MobileFirst CLI, see https://mobilefirstplatform.ibmcloud.com/downloads/. For more info: https://www.npmjs.com/package/mfpdev-cli ..... Or install it with NPM:

	`npm install -g mfpdev-cli`
* OpenSSL. See https://www.openssl.org/.
* A MobileFirst Android client application   
    * Download the MobileFirst sample **PinCodeAndroid** app and set up the the sample according to the `readme` file:  [PinCodeAndroid sample](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80).  
    * Follow the challenge handler tutorial to complete the application: 
     [Implementing the challenge handler in Android applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/credentials-validation/android/).  


## Protect the API Connect endpoint with MobileFirst as an authorization server

After completing this tutorial and the PinCode sample you will have:  
 1. An Android application with the `PinCodeChallengeHandler` for the  `PinCodeAttempts` security check adapter.  
 2. A `ResourceAdapter` that protects the  `/balance` endpoint with the `accessRestricted` scope.  
 3. A `PinCodeAttempts` security check adapter which is mapped to `Scope Element` of `accessRestricted` for the Android application.  

## Defining the Confidential Clients in the MobileFirst Operations Console

Set the **mfp-client-id** and **mfp-client-secret** in the MobileFirst Operations Console:

1. In the **Runtime Settings** choose the  **Confidential Clients** tab.

2. Click the **New** button.

3. Provide the following values and save:

	* **Display Name** `API Connect`
  
	* **ID**: `apic`
  
	* **Secret**: YOUR_CLIENT_SECRET
  
	* **Allowed Scope**: `authorization.introspect`
	


![Create Confidential Client](createConfClient.png)


### Import the MobileFirst OAuthProvider template
From the API Designer, create an OAuthProvider REST API by importing the  [Swagger template YAML file](https://hub.jazz.net/git/imflocalsdk/console-tools-and-sdks/contents/master/mobilefirst-ouath-provider_1.0.0.yaml)   (`mobilefirst-ouath-provider_1.0.0.yaml`). For more information, see
[Adding a REST API by using an OpenAPI (Swagger 2.0) file](http://www.ibm.com/support/knowledgecenter/SSMNED_5.0.0/com.ibm.apic.apionprem.doc/create_api_swagger.html).


After importing, different configuration options are displayed and the **Design** tab is selected. Go to the **Assemble** tab.
![API Connect Designer API editor](initialMenu.png)

You will see the following components in the assembly flow for the MobileFirst OAuth Provider API:

* MobileFirst Configuration
* gatewayscript
* proxy
* gatewayscript

![Configuration Flow](configFlow.png)

#### Configure the MobileFirst OAuthProvider template
Using the API Designer, configure the imported API.  
1. From the **Assemble** tab choose the **MobileFirst Configuration** component.  
2. In the **MobileFirst Configuration** component,  update the following variable values:  
   *  **mfp-oauth-type:** Leave the default value (`true`).  
   * **mfp-server-url:** The MobileFirst Server URL in the format PROTOCOL://SERVER_HOST:SERVER_PORT.  For example `http://myMobileFirstServer:9080`.  Find this value in the `mfpclient.properties` file (`wlServerHost` and `wlServerPort`). The protocol is the `wlServerProtocol` value.  
   * **mfp-server-context:** MobileFirst server context. Find this value in the `mfpclient.properties` file (`wlServerContext`).  
   * **mfp-client-id:** As configured in **Runtime Settings** of the MobileFirst Operations Console in **Runtime Settings ->  Confidential Clients** for the `authorization.introspect` scope.  
   * **mfp-client-secret:** As configured in the MobileFirst Operations Console  **Runtime Settings -> Confidential Clients** for the `authorization.introspect` scope.  




In order to send a request to a MobileFirst Server HTTPS endpoint, you must create a TLS profile for enabling secured connection between API Connect and MobileFirst.  Note that API Connect supports P12 and PEM certificate formats only. See [TLS profiles](http://www.ibm.com/support/knowledgecenter/SSMNED_5.0.0/com.ibm.apic.apionprem.doc/task_apionprem_ssl.html) for information on adding TLS profiles to API Connect.

After adding the TLS Profile, go to the **proxy**  policy component in the **Assemble** tab. Choose the newly created **TLS Profile** property.


### Get the full URL path of MobileFirst OAuthProvider for `/oauth2/authorize`
Choose and configure a Catalog for your product, and set the full path:

1. Open the **Dashboard**.
2. Choose a catalog (for example **Sandbox**) for your product.
3. Go to **Settings -> Endpoints** and copy the **Base URL** which has the following format:

  `https://{DataPowerGateway}/{organizationName}/{catalogName}`

1. To determine full URL path of MobileFirst OAuthProvider for /oauth2/authorize, concatenate the `Base URL`,  the **MobileFirst OAuthProvider** value (`/mfpProvider`), and the `/oauth2/authorize` endpoint.

 The full URL of the of MobileFirst OAuthProvider should look like this:

 `https://{DataPowerGateway}/{organizationName}/{catalogName}/mfpProvider/oauth2/authorize`

### Create a simple REST API to protect with MobileFirst
In this example we create an API called **Branches**. We will add this to the **Bank** product. For more information, see [Creating an invoke REST API definition](http://www.ibm.com/support/knowledgecenter/SSMNED_5.0.0/com.ibm.apic.toolkit.doc/tutorial_apionprem_apiproxy.html).

From the API Connect Designer **APIs** tab:

1. To create a REST API definition, click the ![Add](addIcon.png) button and then select **New OpenAPI from scratch**.

  ![New API](newAPIFromScratch75.png)

2. Configure the following parameters:

	* **Title**: Branches
    
	* **Base Path**: /branches

	* **Version**: 1.0.0.

   	* **Description** can be any value.

3. Click **Create API**. The **Design** tab of the REST API is displayed.

5. In the **Base Path** section, the **Base Path** field is already populated with '/branches'.

6. To create a path, click the **Add Path** icon (![Add](addIcon.png)).

7. In the **Path** field enter **/details**.

7. Click the **Assemble** tab. The **invoke** policy component appears in the **Assemble** pane.

 ![Invoke](invoke.png)

1. Click the **invoke** policy component. The property sheet pane for the invoke component opens.

1. Populate the **URL** field with the back-end resource URL to be protected with MobileFirst. The other values are optional.
 ![Invoke Configuration](invokeConfig.png)

1. Click the  ![Save](saveButton.png) button to save the API definition.

### Protect the API using the MobileFirst OAuth Security Definition
Once you have the full URL path of MobileFirst OAuthProvider for `/oauth2/authorize`, go to the **Design** tab in the API Connect Designer.

#### Security Definitions
Create a  **Security Definition**.

1. In the newly created Branches API, choose **Security Definition** from the design list and add click the ![Add](addIcon.png) button to add a defintion of type **OAuth**.
    ![Add a Security Definition](addSecurityDefinition.png)

1. Set the values.
[details
   * **Flow:** Choose **Implicit**.
   * **Authorization URL:** Use the full URL path of MobileFirst OAuthProvider for `/oauth2/authorize`.
   * **Scopes:** `accessRestricted`.

  ![Choose the Security Definition](securityDef.png)

#### Add the Security Definition
Add a Security Definition to Details API path.
  1. Go to the **Paths** section and choose the Details path.
  1. Click the GET method and expand it.
  1. In the **Security** section uncheck **Use API security definitions**. A list of defined Security Definitions appears. Check the newly created **MobileFirst OAuth Security Definition**.

    ![Choose the OAuth Definition](securityDef2.png)
    Click the  ![Save](saveButton.png) button to add the Security Definition to the API.

### Add APIs to the product and publish it
1. Create a new product or use existing product. See [Creating a Product in the API Designer](http://www.ibm.com/support/knowledgecenter/SSFS6T/com.ibm.apic.toolkit.doc/tapim_create_product.html).
2. Add  the two APIs to the product: the MobileFirst OAuthProvider API and the new Details (or other) API you want to protect with the MobileFirst OAuth Security Definition.
3. Stage the Product. See [Staging a Product](http://www.ibm.com/support/knowledgecenter/en/SSMNED_5.0.0/com.ibm.apic.toolkit.doc/task_deploy_product_offline.html.).
4. Publish the Product: Go to the Catalog **Dashboard** and choose the product to publish.


## Update the sample PinCodeAndroid MobileFirst client application

### Update the `wlclient.properties` file

After setting up the **PinCodeAndroid** sample (including the setup described in the `readme` file), the `wclient.properties` is configured to send all MobileFirst internal requests directly to MobileFirst server.  

However, when working with APIC Connect, the client application requests are proxied by the API Connect endpoints exposed by the MobileFirst OAuthProvider.  

To enable the proxy, change the following property values:   
* **wlServerProtocol:** Change to `https`.    
* **wlServerHost:** Change to DataPower GW hostname/IP (as it appears in the base URL).  
* **wlServerPort:** Change to 443.
* **wlServerContext:** Change to the relative base path of the MobileFirst OAuthProvider. For example `/{organizationName}/{catalogName}/mfpProvider/`.  


### Update the WLResourceRequest request
In the MobileFirst tutorial sample code, change the following in the `PinCodeApplication.java` code.

Replace this:  
```java
    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
```
with this:   

```java
    String apicPath = "YOUR_APIC_ENDPOINT_PATH_WHICH_IS_PROTECTED_BY_MOBILEFIRST";
    WLResourceRequest request = new WLResourceRequest(apicPath, WLResourceRequest.GET);
```
Note: For API Connect endpoint path (`apicPath`), you must supply the full URL.

### Add an HTTPS certificate for API Connect endpoint
To learn about HTTPS, SSL, and adding the necessary certificate for Android applications see [Security with HTTPS and SSL](https://developer.android.com/training/articles/security-ssl.html). The code found there is the basis for the new `trustUnknownCertificateAuthority` method `PinCodeApplication.java` in the following section.

For the MobileFirst Android sample you can use the following instructions:

1. Create an API Connect certificate:

   `openssl s_client -connect {DATAPOWER_GW_HOSTNAME}:443 | openssl x509 > apic-certificate.crt`  
2. Copy the `apic-certificate.crt` file to the  `/app/src/main/assets`  Android project folder.  
3. Create the new method `trustUnknownCertificateAuthority`.

### Create and call the new `trustUnknownCertificateAuthority` method

 In the existing `PinCodeApplication.java` file of the **PinCodeAndroid** sample create the new `trustUnknownCertificateAuthority` method.

```java
    public static void trustUnknownCertificateAuthority(Context ctx, String certFileName, String hostname) throws java.security.cert.CertificateException, IOException, KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        InputStream caInput = ctx.getAssets().open(certFileName);
        java.security.cert.Certificate ca;
        try {
            ca = cf.generateCertificate(caInput);
            System.out.println(ca.toString());
        } finally {
            caInput.close();
        }

        // Create a KeyStore containing our trusted CAs
        String keyStoreType = KeyStore.getDefaultType();
        KeyStore keyStore = KeyStore.getInstance(keyStoreType);
        keyStore.load(null, null);
        keyStore.setCertificateEntry("ca", ca);

        // Create a TrustManager that trusts the CAs in our KeyStore
        String tmfAlgorithm = TrustManagerFactory.getDefaultAlgorithm();
        TrustManagerFactory tmf = TrustManagerFactory.getInstance(tmfAlgorithm);
        tmf.init(keyStore);

        // Create an SSLContext that uses our TrustManager
        SSLContext context = SSLContext.getInstance("TLS");
        context.init(null, tmf.getTrustManagers(), null);

		// Note you should import com.worklight.wlclient.HttpClientManager;
        HttpClientManager hcm = HttpClientManager.getInstance();
        OkHttpClient ohc = hcm.getOkHttpClient();
        ohc.setSslSocketFactory(context.getSocketFactory());

        HostnameVerifier hostnameVerifier = new HostnameVerifier() {
            @Override
            public boolean verify(String hostname, SSLSession session) {
                if (hostname.contentEquals(hostname)) {
                    return true;
                }
                return false;
            }
        };
        ohc.setHostnameVerifier(hostnameVerifier);
    }
4. Add the `trustUnknownCertificateAuthority` method.

```

In the same `PinCodeApplication.java` file, after this line:

```java
    WLClient client = WLClient.createInstance(this);
```

call the  `trustUnknownCertificateAuthority` method:

```java
    String DATAPOWER_GW_HOSTNAME = "YOUR DATAPOWER GW HOSTNAME";
    try {
        trustUnknownCertificateAuthority(getApplicationContext(), "apic-certificate.crt", DATAPOWER_GW_HOSTNAME);
        } catch (Exception name) {
            // handle the exception
        }
```

## Support for multiple MobileFirst OAuthProviders

To add additional OAuthProviders, alter the Swagger template each time before re-importing:

1. **x-ibm-name:** Change "mobilefirst-ouath-provider" to another unique name (only lower case is allowed).  
1. **basePath:** Change "/mfpProvider" to another unique path.  
1. **title:** Change "MobileFirstOAuthProvider" to a unique title.
1. **description:** Change "MobileFirst OAuthProvider Template" to a unique description.  

For each additonal OAuthProvider, use the new base path value to replace the `/mfpProvider` value.
