---
title: Performance Testing for MobileFirst Foundation 8.0
date: 2016-08-09
tags:
- MobileFirst_Foundation
- Performance
- Testing
version:
- 8.0
author:
  name: Nir Grande
---
## Overview
The purpose of this blog post is to describe how to run performance tests on the different features of MobileFirst Server in MobileFirst Foundation 8.0. An Apache JMeter performance test is used and Java classes are compiled especially for JMeter.

There are two main testing flows:

1. MobileFirst flow - The standard MobileFirst flow, starting from a client request and ending with the reception of a valid access token.
2. Test flow - A JMeter test flow that emulates a MobileFirst client. A zip file containing the files that are used in the JMeter flow below has been provided. Read more in my previous blog post, [MobileFirst Platform Foundation Performance Testing for Session Independent Mode (OAuth model)](https://mobilefirstplatform.ibmcloud.com/blog/2015/12/20/mfp-performance-testing-session-independent-mode/#Attachment).

Before we describe the actual test flow, let us consider the OAuth flow:

## OAuth flow with Java adapter
The OAuth 2.0 protocol is based on acquiring an access token, which encapsulates the authorization that is granted to the client. In that context, the IBM MobileFirst Platform Server serves as an authorization server and is able to generate such tokens. The client can then use these tokens to access resources on a resource server, which can be either the MobileFirst Server itself, or an external server. The resource servers perform validation on the token to make sure that the client can be granted access to the requested resource. This separation between resource server and authorization server in the new OAuth-based model allows you to enforce MobileFirst security on resources that are running outside the MobileFirst Server.

## MobileFirst flow
The resource in this flow is Java adapter.

**Registration**  
This phase occurs once in the lifetime of a mobile app that is installed on a device. In this phase, the client registers itself with the MobileFirst Server. When application authenticity has been configured, it is activated during registration. 

**Authorization**  
In this phase, the client has to undergo specific security checks, according to the scope of the authorization request. All the security checks supported by MobileFirst can be used in this phase.

**Token**  
After successful authorization, the client is redirected to the token endpoint, where it is authenticated using the PKI trust that was established during the registration phase. The endpoint then generates two sets of tokens and sends them back to the client: an **access token**, which encapsulates all the security checks that the client has passed in the authorization phase and an **token ID**, which contains information regarding the user and device identity of the client.

**Access resource**  
From this point it is possible to access the resource, either an adapter or an external resource, with a valid token.

## Test flow

* [Prerequisites](#prerequisites): Before running the script, ensure that the MobileFirst Server is running. Deploy the adapters, create the application and also copy all the dependencies as mentioned below. 
* [Registration](#registration) - This step can be bypassed by adding the clients directly to the database. It is a single action in the application life cycle that should have no effect on performance.
* [Authorization](#authorization) - In the test, authorization is required for the usernamePassword security check. This means that the client must identify with valid username and device token in order to successfully pass the authorization phase and get a valid grant code. 
* [Sign grant code](#sign-grant-code) - This Java class mimics client behavior by signing the grant code that was received in the authorization phase.
* [Token](#token) - The client sends the signed grant code and receives an access token. This value is then extracted by JMeter.
* [Sample REST API call](#sample-rest-api-call) - Shows how to access the resource endpoint with a valid token.

JMeter is used here for simulating a MobileFirst client. It lets you use hundreds of threads, each thread holding a large number of fake devices. Using this method, you can stress the MobileFirst Server according to your needs. This flow describes a single client session with several requests. 

### Prerequisites
1. Import the Java class that has been provided to the /lib/ext folder in JMeter.

![importing java class to jmeter]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/1jmeterjarlocation.png)

2. Deploy the automationAdapters adapter. The adapter contains the security check **usernamePassword** that is being used during the authorization process in this demonstration.

3. The application is needed for the registration procedure. You should register an application with the name **test** for the Android platform with the package **com.sample.oauthdemoandroid** and version **1.0**.

![registering the application in the mobilefirst operations console]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/2registerapplication.png)

### Registration
The registration flow occurs during the first client-server negotiation and is written to the **MFP_PERSISTENT_DATA** table. Only registered clients can access MobileFirst Server-served resources.

Registration is a single action that should have no effect on performance. We did not implement this operation inside JMeter script.  
The **MFP_PERSISTENT_DATA** table has been populated with pairs of coordinated `client_id` and `device_id`. This data will be used later by JMeter.

The following SQL command inserts clients into the **CLIENT_INSTANCES** table:

```sql
insert into MFP_PERSISTENT_DATA values (COUNT, REPLACE('{"clientId":"CLIENT_NUM","registrationData":{"application":{"id":"com.sample.oauthdemoandroid","clientPlatform":"android","version":"1.0"},"device":{"id":"device_CLIENT_NUM","model":"sdk_phone_armv7","os":"android 5.0.2","deviceDisplayName":null,"deviceStatus":"ACTIVE"}, "attributes":["java.util.LinkedHashMap",{}]},"signatureAlgorithm":"RS256","publicCredentials":["java.security.interfaces.RSAPublicKey",{"kty":"RSA","n":"AJqHV9w5pYsoIQ_INnOFspIMAsZHxKgkEf_VsMC2CYXq5KeFdg0cuCE-AbGqu6TXEDHXaTh_YtUBaQz06HDZqOeKmmE-ESypdZtAxPg56E5QKIDupWtaMWlxw-fScKAD30RT_E_GkkfdK3IEckWZ1gM1tvVCx_3YQ4Cxtxg-I6LJ","e":"AQAB"}],"privateCredentials":null,"registrationComplete":true,"enabled":true,"remoteDisableNotifyId":0,"lastActivityTime":1462785710974,"associatedUsers":["java.util.HashMap",{}],"publicAttributes":{"attributes":{}},"protectedAttributes":{"attributes":{}}}', 'CLIENT_NUM', COUNT), '28f042d9-2b86-3285-8afb-b9aae7faf1bc', NULL, 0, 'com.sample.oauthdemoandroid', '1.0', 1, '[]', 0, 'hash');
end while;
END P1
```

You can use the DB2 SQL script that is attached in the zip file below.

Parameters:

* **count** - Variable that represents the client id and device id
* **com.sample.oauthdemoandroid** - Application ID 
* **1.0** - Application version
* **ANDROID**- Application environment
* **RSA** - Constant public key

The default `insert` command assumes you have a registered application and deployed adapter as described above in the Prerequisites section. Wrap this command according to your needs and to the tool you use.  
Please note that the command inserts the public key that is used by the Java class. This value should not be changed.

### Authorization
Authorization involves a set of requests, with which the client eventually receives a grant code after successfully handling all challenges. 

Send the appropriate headers for each request.  
The following is the default header for all requests:

* **Content-Type**: application/json; charset=utf-8

The authorization process will be demonstrated in two phases:

#### PreAuthorization1
Sends a request to preauthorize endpoint in order to get the challenge back:

* **client id** - The client that is used during the session
* **scope** - App is protected by usernamePassword. If you have a different authentication flow, change this parameter accordingly. 

Use your own values for `scope` and `client id`. 

The Server returns the **usernamePassword** challenge

![get the challenge from the mobilefirst server]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/3preauthrequest.png)

> Change the response status to **HTTP 200**.  
> When JMeter performs initialization the first time, MobileFirst Server will respond with an HTTP 401 status. This is as expected, so the performance tool should treat this HTTP status as a success, too. Consider changing the HTTP status to HTTP 200. Otherwise, JMeter reports this request as “failed” and records it as an error, thus impacting significantly on the performance testing report. 

![changing the response to http code 200]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/4changeresponseto200.png)

#### PreAuthorization2
Sends a request to preauthorize endpoint again with the correct username and password:

* **client id** - The client that is used during the session
* **scope** – usernamePassword
* **username** – demo. Do not change the value if you use usernamePassword scope
* **password** – demo. Do not change the value if you use usernamePassword scope

The MobileFirst Server returns the authentication confirmation.

![Results of PreAuthorization2]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/5authconfirmation.png)

#### Authorization
Now, execute the authorization request to authorization endpoint, with the following parameters.

![executing the authorization request]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/6authorization.png)

The expected response is 302 and the server sends the grant code:

![HTTP 302 result]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/7response302andcode.png)

The grant code is extracted by JMeter:

![an extracted grant code]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/8extractcode.png)

### Sign grant code
This step is an internal JMeter operation in order to sign the grant code.  
Ensure that the **jmeter80.jwsCreatorForJMeter** class name is selected.

The class gets the `grantCode` parameter (extracted grant code). It also gets the `appid` (leave this parameter as is) and the `clientid`. It then signs the grant code with the constant public key, which was already inserted using the registration script.

The class signs the grant code and returns the `jws` parameter to be used as a header to get the access token:

![returning the jws parameter]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/9signgrantcode.png)

### Token
This is the final authorization step. At the end of this flow, the client receives the access token that will be used to access the resource endpoint.

Add the **Content-Type** header with the correct value, needed by the token endpoint:

![Adding the content-type header]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/10headertoken.png)

Token request: Pass in six parameters including three dynamic – `client_id`, `code` and `client_asssertion` (`jws`): 

![performing the token request]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/11tokenrequest.png)

In the response you get an `access_token`:

![receiving an access token]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/12getaccesstoken.png)

Extract parameter: `access_token`

![receiving an access token]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/13extractaccesstoken.png)

The above steps should work as-is on any target server, assuming the server URL and context path are correct.  
The context path is a user-defined parameter, and server URL can be configured in the **HTTP request defaults** section.


### Sample REST API call
This is a sample API call to a test adapter. Use your own adapter API.  
This call demonstrates how to pass the access_token into the Authorization header.  

![Adding tokens to the authorization header]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/14addaccesstokenheader.png)

![REST API call]({{site.baseurl}}/assets/blog/2016-08-09-performance-testing-for-mobilefirst-foundation-8-0/15restAPIcall.png)

### Attachment
[This zip file](https://github.com/danisade/mfpperf80files/blob/master/package.zip) includes the following files:

1.	JMeter script - Script file that demonstrates all the steps above
2.	Grant code signer Java class - Java class that signs grant code
3.	SQL script for DB2 convention - SQL insert command for DB2
4.	usernamepassword adapter that defines  the security test

### Tips when running the script:

* Fill in the desired number of threads and loop count in data per user. It is recommended to start with one cycle for monitoring purposes. Ensure the single flow works as expected.
* When running with more threads, do not forget to select the errors checkbox in the Flow results section to avoid a mass of write operations that will kill the JMeter.
* You can also spread the script among several JMeter clients, or run it from the command line.



