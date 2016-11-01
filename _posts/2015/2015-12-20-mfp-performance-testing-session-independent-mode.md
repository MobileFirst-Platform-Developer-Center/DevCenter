---
title: 'MobileFirst Platform Foundation 7.1 Performance Testing for Session Independent Mode (OAuth model)'
date: 2015-12-20
tags:
- MobileFirst_Platform
- Performance
- Testing
- OAuth
version:
- 6.3
- 7.0
- 7.1
author:
  name: Nir Grande
---

##Overview
The purpose of this page is to describe how to run performance tests on the different features of the MFP Server. In this post, an Apache JMeter performance test is used and Java classes are compiled especially for JMeter.

There are two descriptions in this post:

* [MFP flow](#mfp-flow) - The standard MFP flow, starting from the client request and ending with the reception of a valid access token.
* [Test flow](#test-flow) - A JMeter test flow that emulates an MFP client.
A zip file containing the files that are used in the JMeter flow below has been provided. Read more [here](#Attachment).

Before we describe the actual test flow, let us consider the OAuth flow:

**OAuth flow with Java adapter**  
The OAuth 2.0 protocol is based on acquiring an access token, which encapsulates the authorization that is granted to the client. In that context, the IBM MobileFirst Platform Server serves as an authorization server and is able to generate such tokens. The client can then use these tokens to access resources on a resource server, which can be either the MobileFirst Server itself, or an external server. The resource servers perform validation on the token to make sure that the client can be granted access to the requested resource. This separation between resource server and authorization server in the new OAuth-based model allows you to enforce MobileFirst security on resources that are running outside the MobileFirst Server.

### MFP flow
The resource in this flow is Java adapter     

**Registration** - This phase occurs once in the lifetime of a mobile app that is installed on a device. In this phase, the client registers itself with the MobileFirst Server. When application authenticity has been configured, it is activated during registration. 

**Authorization** - In this phase, the client has to undergo specific security checks, according to the scope of the authorization request. All the security checks supported by MobileFirst can be used in this phase (built-in realms such as remoteDisable and others, custom realms, and adapter-based authentication).  

**Token** - After successful authorization, the client is redirected to the token endpoint, where it is authenticated using the PKI trust that was established during the registration phase. The endpoint then generates two sets of tokens and sends them back to the client: an access token, which encapsulates all the security checks that the client has passed in the authorization phase and an ID token, which contains information regarding the user and device identity of the client.

**Access resource** - From this point it is possible to access the resource, either an adapter or an external resource, with a valid token.

### Test flow
* [Prerequisite](#prerequisite) - Before running the script, ensure that the MFP Server is up. Deploy the application and also copy all the dependencies as mentioned below. 
* [Registration](#registration) - In this test this step is bypassed by adding the clients directly to the database. It is a single action in the application life cycle that should have no effect on performance.
* [Authorization](#authorization) - In the test, authorization is required for the `antiXSRF` and `deviceNoProvisioning` realms. This means that the client has to extract the correct instance id and device token in order to successfully pass the authorization phase and get a valid grant code. 
* [Sign grant code](#sign-grant-code) - This Java class mimics client behavior by signing the grant code that was received in the authorization phase.  
* [Token](#token) - The client sends the signed grant code and receives an access token and ID token. These values are then extracted by JMeter.
* [A sample REST API call](#sample-of-rest-api-call) - Shows how to access the resource endpoint with a valid token.

JMeter is used here for simulating an MFP client. It lets you use hundreds of threads, each thread holding a large number of fake devices. Using this method, you can stress the MFP server according to your needs. This flow describes a single client session with several requests. 


### Prerequisite

* Import the Java class that has been provided to the /lib/ext folder in JMeter.

    ![placing the jar file]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/placingjar.png)
    
* Deploy the `test` app. The application is needed for the registration procedure. The application is protected by the default security test that includes `antiXSRF` realm. If your app is protected by other realms, you must answer all these challenges successfully before getting the grant code.
    
    ![deploy app]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/deploy-app.png)


### Registration
The registration flow occurs during the first client server negotiation and is written to the `CLIENT_INSTANCES` table. Only registered clients can access MFP resources.  
Registration is a single action that should have no effect on performance. We did not implement this operation inside JMeter script.  
The `CLIENT INSTANCES` table has been populated with pairs of coordinated `client_id` and `device_id`. This data will be used later by JMeter.

The following SQL command inserts clients into the CLIENT_INSTANCES table:

```sql
insert into CLIENT_INSTANCES values (count ,'test','1.0','ANDROID',blob(x'30819F300D06092A864886F70D010101050003818D00308189028181009A8757DC39A58B28210FC8367385B2920C02C647C4A82411FFD5B0C0B60985EAE4A785760D1CB8213E01B1AABBA4D71031D769387F62D501690CF4E870D9A8E78A9A613E112CA9759B40C4F839E84E502880EEA56B5A316971C3E7D270A003DF4453FC4FC69247DD2B7204724599D60335B6F542C7FDD84380B1B7183E23A2C90203010001'),count,'Android-4.2.2','Lenovo S750');
```

You can use the DB2 sql script that is attached in the zip file below.  
Parameters:

* `count` - Variable that represents the client id and device id
* `test `- Application name 
* `1.0` - Application version
* `ANDROID `- Application environment
* `blob `- Constant public key

The default insert command assumes you have an application called `test `in an `ANDROID` environment. Ensure that you have deployed such a dummy application. Wrap this command according to your needs and to the tool you use.  
Please note that the command inserts the public key that is used by the Java class. This value should not be changed.



## Authorization
Authorization involves a set of requests, with which the client eventually receives a grant code after successfully handling all challenges. 

Send the appropriate headers for each request.  
The following are the default headers for all requests:

![default headers]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/default-headers.png)

* `x-wl-app-version`: Version of your app
* `x-wl-platform-version`: MFP platform version (for 7.1, do not change)
* `X-WL-ClientId` - Client ID
* `X-WL-Session` -  Any string for session ID 

Now we will demonstrate the authorization process in two phases:

#### Authorization1
Sends a request to authorization in order to get the challenges back and extract them:

![no provisioning]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/no_provisioning.png)

* `client id` - The client that is used during the session
* `scope ` - App is protected by `anti-XSRF`. We will add another challenge - `deviceNoProvisioning` - to the authorization by using the scope parameter. If you have a different authentication flow, change this parameter accordingly. 

Use your own values for `scope` and `client id`. Leave all the other parameters as they appear here. 

The Server returns the `anti-XSRF` and `deviceNoProvisioning` realm challenges: 

![auth response]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/auth1response.png)

Extract the `wl-instance-Id` and the `device-token` from the response and send them as headers in all requests to the MFP Server. If you do not, the authentication check will fail and the request will be rejected. Challenge data is different for each session, so you need to extract and store the challenge data for each thread:

Extract `instance-id`

![extract instance id]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/extract_instance_id.png)

Extract `device token`

![extract device token]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/extractdevicetoken1.png)

Change response status to HTTP 200  
When JMeter performs initialization the first time, MFP Server will respond with an HTTP 401 status. This is as expected, so the performance tool should treat this HTTP status as a success, too. You may consider changing the HTTP status to HTTP 200. Otherwise, JMeter reports this request as “failed” and records it as an error, thus impacting significantly on the performance testing report.  

![change response to 200]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/changeresponeto200png1.png)



#### Authorization2
First, add the extracted values of the previous request (`device-token` + `instance-id`) as headers:

![anti-xsrf headers]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/antixsrf-headers.png)

Now, execute the same authorization request again, with the same parameters.  
The expected response is 307 and the server sends the grant code:

![auth response]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/auth2response.png)

The grant code is extracted by JMeter:

![extract grant code]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/extract_grant_code.png)

#### Sign grant code
This phase is an internal JMeter operation in order to sign the grant code.  
Ensure that the `jmeter.jwscreator` class name is selected.

The class gets the `payload` parameter (extracted grant code) and signs the grant code with the constant public key, which was already inserted using the registration script.  
The class signs the grant code and returns the `jws` parameter to be used as a header to get the access token:

![sign grant code class]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/signgrantcodeclass.png)


### Token
This is the final authorization step. At the end of this flow, the client receives the access token that will be used to access the resource endpoint.  
Add the `X-WL-Authenticate` header, returned by the `sign grant code` Java request:

![x-wl-authenticate]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/x-wl-authenticate1.png)

Token request: Pass in four parameters including two dynamic – `client_id` and `code`: 

![token request]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/tokenrequest.png)

In the response you get `access_token` and `id_token`:

![token response]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/tokenresponse.png)

Extract both parameters: `access_token` and `id_token`

![extract access token]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/extractaccesstoken.png)

![extract id token]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/extract-id-token.png)

The above steps should work as-is on any target server, assuming the server URL and context path are correct.  
The context path is a user-defined parameter, and server URL can be configured in the ****HTTP request defaults** section.

### Sample of REST API call
This is a sample API call to a test adapter. Use your own adapter API.  
This call demonstrates how to pass the `access_token` and `id_token` into the Authorization header.

Adding tokens to the authorization header

![tokens headers]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/tokensheaders1.png)

Sample request showing how to access a resource endpoint with a REST API call:

![call bills]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/callbills.png)

### Attachment
The zip file [perftestfiles]({{site.baseurl}}/assets/blog/2015-12-20-mfp-performance-testing-session-independent-mode/perftestfiles.zip) includes the following files:

1. JMeter script - Script file that demonstrates all the steps above
2. Grant code signer Java class - Java class that signs grant code
3. SQL script for DB2 convention - SQL insert command for DB2
4. `test` dummy application with `android` environment 

Tips when running the script:

* Fill in the desired **number of threads** and **loop count** in **data per user**. It is recommended to start with one cycle for monitoring purposes. Ensure the single flow works as expected.
* When running with more threads, do not forget to select the **errors** checkbox in the **Flow results** section to avoid a mass of write operations that will kill the JMeter.
* You can also spread the script among several JMeter clients, or run it from the command line.
