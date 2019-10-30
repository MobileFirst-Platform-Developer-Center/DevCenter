---
layout: tutorial
title: MobileFirst server, runtime and console messages
breadcrumb_title: Foundation Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Overview
{: #overview }
Find information to help resolve issues that you may encounter with the Mobile Foundation Server.

## Mobile Foundation runtime messages
{: #mfp-runtime-error-codes }
**Prefix:** FWLSE<br/>
**Range:** 0000-0012

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE0000E** | *Could not store AuthorizationGrant {0} in TransientStorage.* |
| **FWLSE0001E** | *Failed to retrieve client {0}.* |
| **FWLSE0002E** | *Invalid request, missing or invalid parameters: {0}.* |
| **FWLSE0003E** | *Unsupported grant type {0}.* |
| **FWLSE0004E** | *RedirectUri was passed to authorization endpoint: {0}, but was not passed to token endpoint.* |
| **FWLSE0005E** | *RedirectUri conflict. authorization endpoint: {0}, token endpoint: {1}.* |
| **FWLSE0006E** | *Failed parsing grant code from token request: {0}.* |
| **FWLSE0007E** | *Grant code validation failed. Grant code {0} was provided for clientId {1} but used by clientId {2}.* |
| **FWLSE0008E** | *Action parse AccessToken failed with exception.* |
| **FWLSE0009E** | *Unable to sign access token.* |
| **FWLSE0010E** | *Unable to validate JWT, error in the server Keystore.* |
| **FWLSE0011E** | *Unable to validate JWT, {0}.* |
| **FWLSE0012E** | *Client JWT authentication failed - Invalid jti.* |


### Java adapter messages

**Prefix:** FWLSE<br/>
**Range:** 0290-0299

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE0290E** | *JAXRS Application class: {0} was not found (or cannot be loaded). Make sure that the class name in the adapter's xml file is correct and that the class actually exist in the adapter''s bin folder or in one of the jars of the adapter's lib folder.* |
| **FWLSE0291E** | *JAXRS Application class: {0} cannot be instantiated. Make sure that the class has a public zero arguments constructor. If there is a constructor, look at the server log to see the root cause for the failure in instance creation.* |
| **FWLSE0292E** | *JAXRS Application class: {0} must extend javax.ws.rs.Application.* |
| **FWLSE0293E** | *Adapter deployment failed. Property type {0} is not supported.* |
| **FWLSE0294E** | *Adapter deployment failed. Value {0} is illegal for type {1}.* |
| **FWLSE0295E** | *Adapter configuration deployment failed. Property {0} is not defined in adapter {1}.* |
| **FWLSE0296E** | *Adapter configuration deployment failed. Property {0} is invalid for type {1}.* |
| **FWLSE0297W** | *Failed to generate Swagger documentation for adapter {0}.* |
| **FWLSE0298W** | *Procedure {0} in adapter {1} has the 'connectAs' attribute set to 'enduser'. This feature is not supported.* |
| **FWLSE0299E** | *Adapter connectivity configuration deployment failed. The properties {0} do not exist.* |


**Prefix:** FWLSE<br/>
**Range:** 0500-0506

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE0500E** | *Adapter connectivity configuration deployment failed. The parameter {0} should be an integer.* |
| **FWLSE0501E** | *Adapter connectivity configuration deployment failed. The parameter {0} should be positive.* |
| **FWLSE0502E** | *Adapter connectivity configuration deployment failed. The parameter {0} is out of range.* |
| **FWLSE0503E** | *Adapter connectivity configuration deployment failed. The parameter {0} should be a boolean.* |
| **FWLSE0504E** | *Adapter connectivity configuration deployment failed. The {0} should be either http or https.* |
| **FWLSE0505E** | *Adapter connectivity configuration deployment failed. The cookie policy {0} is not support.* |
| **FWLSE0506E** | *Adapter connectivity configuration deployment failed. The parameter {0} should be a string.* |

### Registration messages

**Prefix:** FWLSE<br/>
**Range:** 4200-4229

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE4200E** | *Change device application status failed.* |
| **FWLSE4201E** | *Change device status failed.* |
| **FWLSE4202E** | *Get devices failed.* |
| **FWLSE4203E** | *Remove device failed.* |
| **FWLSE4204E** | *Get clients assotiated with device failed.* |
| **FWLSE4205E** | *getAll for pageInfo: {0} failed.* |
| **FWLSE4206E** | *GetByAttributes failed.* |
| **FWLSE4207E** | *Couldn't convert data to persistent data.* |
| **FWLSE4208E** | *Failed to read client {0}.* |
| **FWLSE4209E** | *update device display name failed.* |
| **FWLSE4210E** | *Unable to create signature.* |
| **FWLSE4211E** | *Failed to store client registration data because it was not properly retrieved. Client Id: {0}.* |
| **FWLSE4212E** | *update display name on all device clients failed.* |
| **FWLSE4213E** | *Client JWT authentication failed - public keys do not match.* |
| **FWLSE4214E** | *Client data is null - this can happen if the client data has been archived (deleted) just now.* |
| **FWLSE4215E** | *Trying multiple times to access console, giving up.* |
| **FWLSE4216E** | *GetDeviceClientsError for deviceId: {0}.* |
| **FWLSE4217E** | *Error while trying to get devices with pageStart: {0} and pageSize: {1}.* |
| **FWLSE4218E** | *Error while trying to get devices for name: {0} with pageStart: {1} and pageSize: {2}.* |
| **FWLSE4219E** | *RemoveDeviceError for deviceId: {0}.* |
| **FWLSE4220E** | *Failed to create web key for client {0}.* |
| **FWLSE4221E** | *Search devices failed with pageInfo: {0} ,searchMethod: {1} and filter: {2}.* |
| **FWLSE4222E** | *Client registration failed - invalid signature.* |
| **FWLSE4223E** | *Client registration failed - invalid application. error: {0}.* |
| **FWLSE4224E** | *Failed to process registration request.* |
| **FWLSE4225E** | *Invalid update self registration request, client signature could not be verified.* |
| **FWLSE4226E** | *App authenticity failure on registration update, update failed {0}.* |
| **FWLSE4227E** | *Update registration failed.* |
| **FWLSE4228E** | *applyRegistrationValidations failure on registration, removing the client {0}.* |
| **FWLSE4229W** | *Re-read of initialized client context, the changes may be lost.* |

### App Messages

**Prefix:** FWLST<br/>
**Range:** 0100-0106

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLST0100E** | *tried to access direct update to an application which was never associated with direct update security.* |
| **FWLST0101E** | *No application with name: {0} found.* |
| **FWLST0102E** | *can't finish direct update due to {0}.* |
| **FWLST0110E** | *tried to access native update to an application which was never associated with native update security.* |
| **FWLST0111E** | *No application with name: {0} found.* |
| **FWLST0112E** | *can't finish native update due to {0}.* |
| **FWLST0120E** | *tried to access model update to an application which was never associated with model update security.* |
| **FWLST0121E** | *No application with name: {0} found.* |
| **FWLST0122E** | *can't finish model update due to {0}.* |
| **FWLST0103E** | *Invalid client log profile, level should not be null.* |
| **FWLST0104E** | *Invalid client log profile, found more than one global profile.* |
| **FWLST0105E** | *Cannot upload user log file due to {0}.* |
| **FWLST0106E** | *Application deployment failed. {0} application Id is illegal. Application id may only contain a-z, A-Z, _-. characters.* |

### JavaScript adapter Messages

**Prefix:** FWLST<br/>
**Range:** 0900-0906

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLST0900E** | *Adapter descriptor deployment failed. Keystore Invalid.* |
| **FWLST0901W** | *SSL alias {0} does not exist in keystore. Backend invocations that require the keystore will fail.* |
| **FWLST0902W** | *SSL alias exist in descriptor but no password. Backend invocations that require the keystore will fail.* |
| **FWLST0902W** | *SSL password exist in descriptor but no alias. Backend invocations that require the keystore will fail.* |
| **FWLST0903W** | *SSL alias and password invalid. Backend invocations that require the keystore will fail.* |
| **FWLST0904E** | *Exception was thrown while invoking procedure: {0} in adapter: {1}.* |
| **FWLST0905E** | *Adapter deployment failed. SQL driver {0} was not found in the adapter resources.* |
| **FWLST0906E** | *Exception was thrown while invoking SQL {0}.* |


**Prefix:** FWLSE<br/>

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE0014W** | *The parameter {0} is not known and will be ignored.* |
| **FWLSE0152E** | *Unable to find certificate chain with alias: {0}.* |
| **FWLSE0207E** | *Failed read from the HTTP response input stream.* |
| **FWLSE0299W** | *Response for request: {0} returned in 0ms. HTTP message flow investigation is required.* |
| **FWLSE0310E** | *JSON parse failure.* |
| **FWLSE0311E** | *XML parse or transform failure.* |
| **FWLSE0318I** | *{0}.* |
| **FWLSE0319W** | *Backend response content type {0} did not match the expected content type {1}, continue processing the response. The request and response headers and body: {2}.* |
| **FWLSE0330E** | *Cannot initialize the WebSphere SSL context.* |


### Core Messages

**Prefix:** FWLST<br/>

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLST3022W** | *Folder {0} is non-writable. User-based home directory will be used.* |
| **FWLST3023E** | *Project {0} failed to start: Could not create directory {1}.* |
| **FWLST3024I** | *MFP server is using folder {0} as filesystem cache.* |
| **FWLST3025W** | *MFP server analytics report is disabled due to empty URL in registry configuration.* |
| **FWLST3026W** | *MFP sever had error while calling analytics service: {0}.* |
| **FWLST3027I** | *Configuration changed. Analytics server is now enabled on: {0}.* |
| **FWLST4047W** | *Product version couldn't be found. Searched in file named: {0} and property named: {1}.* |
| **FWLST4048W** | *Runtime version couldn't be found. Searched in file named: {0} and property named: {1}.* |

### Security Messages

**Prefix:** FWLSE<br/>
**Range:** 4010-4068

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE4010E** | *Unable to read keystore deployment zip file.* |
| **FWLSE4011E** | *Zip file does not include keystore file.* |
| **FWLSE4012E** | *Zip file does not include properties file.* |
| **FWLSE4016E** | *The type of the keystore certificate algorithm is not RSA. Follow the console guide to create a keystore with an RSA algorithm.* |
| **FWLSE4017E** | *Unable to create keystore. Keystore: type: {0}.* |
| **FWLSE4018E** | *Some cryptographic algorithm is not supported in this environment. Keystore: type: {0}.* |
| **FWLSE4019E** | *This exception indicates one of a variety of certificate problems. Keystore: type: {0}.* |
| **FWLSE4021E** | *Unable to create keystore. Path: type: {0}.* |
| **FWLSE4022E** | *Unable to recover key from keystore. Keystore: type: {0}.* |
| **FWLSE4023E** | *Unable to extract private key from KeyStore, invalid or missing alias. alias:  {0}.* |
| **FWLSE4024W** | *Duplicate configuration for security check {0} in this adapter. Configuration used: {1}.* |
| **FWLSE4025W** | *Security check {0} was already configured in a different adapter, the new configuration will not be used.* |
| **FWLSE4026E** | *Class {1} for security check {0} was not found.* |
| **FWLSE4027E** | *Unable to create security check {0}. class: {1}, error: {2}.* |
| **FWLSE4028E** | *Class {1} for security check {0} does not implement the SecurityCheck interface.* |
| **FWLSE4029E** | *Deployment of authenticity data failed. Error Message: {0}.* |
| **FWLSE4030E** | *Duplicate scope element mapping was found for scope element {0}, mapping used: {1}.* |
| **FWLSE4031E** | *Duplicate security check configuration was found for security check {0}.* |
| **FWLSE4032E** | *The application descriptor of application {0} contains a configuration for security check {1}. The security check is missing, or there was an attempt to remove it.* |
| **FWLSE4033E** | *The application descriptor of application {0} contains a configuration for security check {1}. The security-check configuration could not be applied.* |
| **FWLSE4034E** | *Security check {0} has a configuration error for param {1}: {2}.* |
| **FWLSE4035W** | *Security check ''{0}'' has a configuration warning for param {1}: {2}.* |
| **FWLSE4036W** | *The application descriptor of application {0} contains a  configuration for a mandatory application scope {1}. One or more of the scope elements are missing, or there was an attempt to remove them.* |
| **FWLSE4037E** | *Security check {0} cannot have the same name as a scope element mapping.* |
| **FWLSE4038E** | *The application descriptor of application {0} contains a  configuration for a scope {1} that is mapped to security check {2}. The security check is missing, or there was an attempt to remove it.* |
| **FWLSE4039W** | *Empty scope element cannot be mapped. Attempting to map to: {0}.* |
| **FWLSE4040E** | *{0} field for adapter configuration is not formatted correctly.* |
| **FWLSE4041W** | *Illegal characters used in scope element {0}. Legal characters include letters, numbers, '-' and '_'.* |
| **FWLSE4042I** | *Security check {0} configuration for param {1}: {2}.* |
| **FWLSE4043E** | *Application's maximum token expiration must be positive. Configured: {0}.* |
| **FWLSE4044I** | *User {0} is authenticated through Ltpa-Based SSO security.* |
| **FWLSE4045I** | *User is NOT authenticated through Ltpa-Based SSO security.* |
| **FWLSE4046** | *checking if device disabled for registration failed with exception.* |
| **FWLSE4047:** | *Maximum token expiration value for application {0} is greater than the expiration limit. Value: {1}, expiration limit: {2}.* |
| **FWLSE4048E** | *Failed to validate access token with external AZ server {0}.* |
| **FWLSE4049E** | *Ordering security checks failed.* |
| **FWLSE4050E** | *Invalid client data.* |
| **FWLSE4051E** | *Application doesn't exist.* |
| **FWLSE4052E** | *Failed reading externalized security checks. Context initialized clean for client: {0}.* |
| **FWLSE4053E** | *Security Check does not exist - {0}.* |
| **FWLSE4054E** | *Failed to externalize the security checks. The security checks are deleted for client: {0}.* |
| **FWLSE4055E** | *Failed to get scope expiration, 0 returned.* |
| **FWLSE4056E** | *Introspection failed with exception.* |
| **FWLSE4057E** | *Unexpected token validation result: {0}.* |
| **FWLSE4058E** | *Error while encoding header and payload.* |
| **FWLSE4059E** | *Fail to create header object from the decoded header: {0}.* |
| **FWLSE4060E** | *Fail to create payload object from the decoded payload: {1}.* |
| **FWLSE4061E** | *Error while encoding header64 + payload64.* |
| **FWLSE4062E** | *Error while encoding header for signing or while creating header.* |
| **FWLSE4063E** | *Error while encoding payload.* |
| **FWLSE4064E** | *Client is not allowed the scope {0}.* |
| **FWLSE4065E** | *Client is unauthorized.* |
| **FWLSE4066E** | *Implicit grant flow is available only for Swagger UI.* |
| **FWLSE4067E** | *Client is unauthorized.* |
| **FWLSE4068E** | *Client is unauthorized.* |


### Server persistency Messages

**Prefix:** FWLSE<br/>
**Range:** 3000-3009

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE3000E** | *Data source JNDI binding not found for names: {0} and {1}.* |
| **FWLSE3001E** | *Can't serialize List to json array.* |
| **FWLSE3002E** | *Can't create persistent data item: {0}.* |
| **FWLSE3003E** | *JSON Array deserialization problem.* |
| **FWLSE3004E** | *Can't read CLOB value column.* |
| **FWLSE3005E** | *Can't serialize List to json array.* |
| **FWLSE3006E** | *Couldn't start transaction :{0}.* |
| **FWLSE3007E** | *Unexpected error encountered.* |
| **FWLSE3008E** | *Couldn't generate hash.* |
| **FWLSE3009E** | *Error occurred while trying to commit the transaction.* |

### Server war Messages

**Prefix:** FWLSE<br/>
**Range:** 3100-3103

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE3100E** | *Unrecognized authorization server mode: {0}.* |
| **FWLSE3101E** | *Jndi entry {0} not found, authorization server mode unknown.* |
| **FWLSE3102I** | *Failed to gather annotations for class {0}. Swagger UI may miss some scope.* |
| **FWLSE3103I** | *Failed to determine class for bean {0}. Swagger UI may miss some scopes.* |
| **FWLSE3103I** | *Starting with embedded authorization server.* |
| **FWLSE3103I** | *Starting with external authorization server integration.* |

### License Messages

**Prefix:** FWLSE<br/>

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE0277I** | *Creating an ILMT record in the file {0}.* |
| **FWLSE0278I** | *The default ILMT directory {0} cannot be used.* |
| **FWLSE0279E** | *Failed to create an ILMT record.* |
| **FWLSE0280I** | *ILMT Debug Mode activated by the environment variable {0}.* |
| **FWLSE0281E** | *Failed to create an ILMT logger.* |
| **FWLSE0282I** | *Using the ILMT directory {0}.* |
| **FWLSE0283E** | *The ILMT directory is not compliant. You can set an appropriate directory to a property named 'license.metric.logger.output.dir' in the file 'license_metric_logger.properties' and use the JVM property '-Dlicense_metric_logger_configuration=\<path to license_metric_logger.properties\>'.* |
| **FWLSE0284E** | *Failed to retrieve the path where this {0} instance is running. This is not ILMT-compliant.* |
| **FWLSE0286I** | *Unexpected exception.* |
| **FWLSE0287E** | *Failed to create an ILMT record because the ILMT Logger was not correctly initialized. This is not ILMT-compliant. Review the log files to find the cause of the initialization error.* |
| **FWLSE0367E** | *Missing License Report data. Failed to create an ILMT record.* |

### Purge Messages

**Prefix:** FWLSE<br/>
**Range:** 0290-0292

| **FWLSE0290I** | *Completed deletion of {0} records in {1} ms.* |
| **FWLSE0291I** | *Completed deletion of {0} batches in {1} ms.* |
| **FWLSE0292I** | *Recommended persistent data delete is for records older than {0} days.* |

### Other Messages

**Prefix:** FWLSE<br/>

| **FWLSE0211W** | *Recommended decommissioning interval ({0}) is 86400 seconds which is 1 day.* |
| **FWLSE0801E** | *Password decode utility com.ibm.websphere.crypto.PasswordUtil is not available. Cannot support encrypted password for {0}.* |
| **FWLSE0802E** | *Unable to decode password for {0}.* |
| **FWLSE0803E** | *Cannot find message for id {0} in bundle {1} " + ". Error:{2}.* |
| **FWLSE0802E** | *Unable to decode password for {0}.* |



## Mobile Foundation Administration service messages
{: #admin-services-error-codes }
<!-- Messages taken from mfp-admin-services/mfp-admin-util/src/main/resources/com/ibm/worklight/admin/resources/messages.properties-->
**Prefix:** FWLSE<br/>
**Range:** 3000-3299

| **Error Code**  | **Description** |
|-----------------|-----------------|
| **FWLSE3000E** | **A server error was detected.** |
| **FWLSE3001E** | **A conflict was detected.** |
| **FWLSE3002E** | **The resource is not found.** |
| **FWLSE3003E** | **The runtime cannot be added since its payload contains no name.** |
| **FWLSE3010E** | **A database error was detected.** <br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, misconfigure the data base. |
| **FWLSE3011E** | **The port number "{0}" of the mfp.admin.proxy.port JNDI property is not valid.** <br/><br/>{0} is the port number, e.g. 9080.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, set JNDI property mfp.admin.proxy.port to a nonsense value.  Then open the Operations Console. The message will eventually appear in the server logs. |
| **FWLSE3012E** | **JMX connection error. Reason: "{0}". Check the application server logs for details.** <br/><br/>{0} is an error message coming from the JMX protocol of the web server.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, misconfigure JMX somehow that it throws exceptions. |
| **FWLSE3013E** | **Timeout when trying to obtain the transaction lock after {0} milliseconds.** <br/><br/>{0} is the number of milliseconds, for instance 32000.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this happens with a data base connected through an unstable or slow network. |
| **FWLSE3017E** | **A database error was detected: {0}. Reason: {1}** <br/><br/>{0} is the error message from cloudant.<br/>{1} is the reason message from cloudant.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, misconfigure Cloudant. |
| **FWLSE3018E** | **Cloudant operation did not complete within {0} milliseconds.** <br/><br/>{0} is the number of milliseconds, for instance 32000.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, use Cloudant DB and set JNDI property mfp.db.cloudant.documentOperation.timeout to 1. If the connection to cloudant is slow, open the Operations Console. The message will eventually appear in the server logs. |
| **FWLSE3019E** | **Unable to obtain transaction lock. Reason: {0}** <br/><br/>{0} is some exception message that we returned from external. Can be any string.  <br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, can be reproduced when you have a farm with Cloudant and you shut down the locking master while a locking operations is ongoing. Then open the Operations Console.  The message will eventually appear in the server logs. |
| **FWLSE3021E** | **Timeout when trying to obtain the transaction lock after {0} milliseconds. Increase the {1} property.**<br/><br/>{0} is the number of milliseconds, for instance 32000.<br/>{1} is the name of the JNDI property from which the timeout is taken.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this happens with a data base connected through an unstable or slow network. |
| **FWLSE3030E** | **The runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>**Where:** {0} is the runtime name (any string).<br/><br/>This error occurs when the {{ site.data.keys.mf_server }} is unable to load the runtime stored in the database.  [APAR PI71317](http://www-01.ibm.com/support/docview.wss?uid=swg1PI71317) was released to address some occurrences of this message.  If the fix level of the server is earlier than **iFix 8.0.0.0-IF20170125-0919**, upgrade to the [latest iFix](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all). |
| **FWLSE3031E** | **The runtime "{0}" cannot be added or deleted since it is still running.** <br/><br/>{0} is the runtime name (any string). |
| **FWLSE3032E** | **The runtime "{0}" cannot be added since it exists already.** <br/><br/>{0} is the runtime name (any string). |
| **FWLSE3033E** | **The runtime "{0}" is not empty but you requested to delete the runtime only when it is empty.** <br/><br/>{0} is the runtime name (any string).<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, delete a stopped runtime which still contains apps. |
| **FWLSE3034E** | **The application "{1}" for the runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the runtime name (any string).<br/>{1} is the application name (any string). |
| **FWLSE30302E** | **The license config for application "{1}" for the runtime "{0}" does not exist in the MobileFirst administration database.** <br/><br/>{0} is the runtime name (any string).<br/>{1} is the application name (any string). |
| **FWLSE30303E** | **The license config cannot be deleted since application "{1}" for the runtime "{0}" exists in the MobileFirst administration database or the license config doesn''t exists.** <br/>{0} is the runtime name (any string).<br/>{1} is the application name (any string). |
| **FWLSE30035E** | **The application "{1}" cannot be added since it exists already in the runtime "{0}".** <br/><br/>{0} is the runtime name (any string).<br/>{1} is the application name (any string).<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> occurs only in unit tests |
| **FWLSE3035E** | **The application "{1}" with environment "{2}" of runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the runtime name (any string)<br/>{1} is the application name (any string).<br/>{2} is the environment name: android, ios, ... |
| **FWLSE30304E** | **The AppAuthenticity Data for application "{1}" with environment "{2}" and version "{3}" of runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the runtime name (any string)<br/>{1} is the application name (any string).<br/>{2} is the environment name: android, ios, ... |
| **FWLSE3036E** | **The application "{1}" with environment "{2}" and version "{3}" of runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the runtime name (any string).<br/>{1} is the application name (any string).<br/>{2} is the environment name: android, ios, ... <br/>{3} is the version: 1.0, 2.0 ... |
| **FWLSE3037E** | **The environment "{1}" with version "{2}" cannot be added since it exists already in the application "{0}".** <br/><br/>{0} is the application name (any string).<br/>{1} is the environment name: android, ios, ... <br/>{2} is the version: 1.0, 2.0 ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> occurs only in unit tests |
| **FWLSE3038E** | **The adapter "{1}" of the runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the runtime name (any string).  {1} is the adapter name (any string). |
| **FWLSE3039E:** | **The adapter "{0}" cannot be added since it exists already in the runtime "{1}".** <br/>{0} is the runtime name (any string).  {1} is the adapter name (any string).<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> occurs only in unit tests. |
| **FWLSE3040E** | **The configuration profile "{0}" was not found for any runtime in the MobileFirst administration database. The database may be corrupted.** <br/><br/>{0} is the id of the configuration profile (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, might occur in trace log when deleting a nonexisting client config profile. |
| **FWLSE3045E** | **No MBean found for {0} administration.** <br/><br/>{0} is the word MobileFirst.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3041E** | **No MBean found for {0} project ''{1}''. Possibly the {0} runtime web application for {0} project ''{1}'' is not running. If it is running, use JConsole to inspect the available MBeans. If it is not running, full error details are available in the log files of the server.** <br/><br/>{0} is the word MobileFirst.  {1} is the project/runtime name (any string) |
| **FWLSE3042E** | **Communication error with the MBean ''{0}''. Check the application server logs.** <br/><br/>{0} is the MBean canonical ID, which is a string.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Might occur if we install a 6.2 worklight-jee-library in a 7.1 MobileFirst server. |
| **FWLSE3043E** | **The MBean named ''{0}'' is no longer present. Check the application server logs.** <br/><br/>{0} is the MBean canonical ID, which is a string.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, occurs in server farm when shut down a server while a deployment operation is ongoing. |
| **FWLSE3044E** | **The MBean named ''{1}'' does not support the expected operations. Check that the {0} runtime version is the same than the administration services.** <br/><br/>{0} is the word MobileFirst. {1} is the MBean canonical ID, which is a string.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Might occur if we install a 6.2 worklight-jee-library in a 7.1 MobileFirst server. |
| **FWLSE3050E** | **The MBean operation returns an unknown type. Check that the {0} runtime version is the same than the administration services.** <br/><br/>{0} is the word MobileFirst.<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Might occur if we install a 6.2 worklight-jee-library in a 7.1 MobileFirst server. |
| **FWLSE3051E** | **Invalid payload. See additional messages for details.** |
| **FWLSE3052E** | **The following payload is not recognized: "{0}".** <br/><br/>{0} is an extract of the payload in JSON syntax, e.g. "{ a : 0 }" |
| **FWLSE3053E** | **Invalid parameters. See additional messages for details.** |
| **FWLSE3061E** | **The environment "{0}" referenced in the file "{1}" of the wlapp file is unknown. Check that the application was correctly built.** <br/><br/>{0} is the environment: android, ios.  {1} is a file name |
| **FWLSE3063E** | **The application cannot be deployed since the "{0}" folder is missing in the wlapp file. Check that the application was correctly built.** <br/><br/>{0} is a folder name, for instance "meta".<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Deploy a wlapp that does not contain the meta folder |
| **FWLSE3065E** | **The application cannot be deployed since the "{0}" field is missing in the wlapp file. Check that the application was correctly built.** <br/><br/>{0} is a mandatory field, for instance "app.id" |
| **FWLSE3066E** | **The application cannot be deployed since the application version "{2}" is different than the version of the {0} runtime "{3}". \nUse {1} "{4}" to build and deploy the application.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is an application version: 1.0, 2.0, ... {3} is the runtime version {4} is the required studio version |
| **FWLSE3067E** | **The application cannot be deployed since the application version is older than the version of the {0} runtime "{2}". \nUse {1} "{3}" to build and deploy the application.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is the runtime version {3} is the required studio version |
| **FWLSE3068E** | **The adapter cannot be deployed since the adapter version "{2}" is different than the version of the {0} runtime "{3}". \nUse {1} "{4}" to build and deploy the adapter.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is an adapter version: 1.0, 2.0, ... {3} is the runtime version {4} is the required studio version |
| **FWLSE3069E** | **The adapter cannot be deployed since the adapter version is older than the version of the {0} runtime "{2}". \nUse {1} "{3}" to build and deploy the adapter.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is the runtime version {3} is the required studio version |
| **FWLSE3070E** | **Update of application "{1}" with environment "{2}" and version "{3}" failed because it is locked. It can be unlocked using the {0} Operations Console.** <br/><br/>{0} is the word MobileFirst {1} is the application name (any string) {2} is the application environment: android, ios, ... {3} is the application version: 1.0, 2.0, ... |
| **FWLSE3071E** | **Cannot deploy hybrid application "{0}" because there is already a native application with the same name.** <br/><br/>{0} is the application name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Create a native and a hybrid application of the same name and deploy both in Operations Console. |
| **FWLSE3072E** | **Cannot deploy native application "{0}" because there is already a hybrid application with the same name.** <br/><br/>{0} is the application name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Create a native and a hybrid application of the same name and deploy both in Operations Console. |
| **FWLSE3073E** | **Cannot find the Adobe Air installer file in application "{1}" version "{2}". \nPlease use {0} to rebuild and deploy the wlapp file for this application.** <br/><br/>{0} is the name of studio, e.g. MobileFirst Studi {1} is the application name (any string) {2} is the application version: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Occurs when the adobe application is messed up |
| **FWLSE3074W** | **The lock has been properly updated for application "{0}" with environment "{1}" and version "{2}" but this setting has no effect on environment "{1}" because this environment does not support Direct Update.** <br/><br/>{0} is the application name (any string) {1} is the application environment: android, ios, ... {2} is the application version: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3075W** | **The application authentication rule has been properly updated for application "{0}" with environment "{1}" and version "{2}" but this setting has no effect on application "{0}" environment "{1}" because this environment do not support application authenticity checking. You can enable this support for this application environment by declaring in application-descriptor.xml a security configuration defined in authenticationConfig.xml.** <br/><br/>{0} is the application name (any string) {1} is the application environment: android, ios, ... {2} is the application version: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3076W** | **The application "{0}" with environment "{1}" and version "{2}" was not deployed because it did not change since the previous deployment.** <br/><br/>{0} is the application name (any string) {1} is the application environment: android, ios, ... {2} is the application version: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, deploy the exact same (legal) wlapp twice with the Operations console. |
| **FWLSE3077W** | **The adapter "{0}" was not deployed because it did not change since the previous deployment.** <br/><br/>{0} is the adapter name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, deploy the exact same (legal) adapter twice with the Operations console. |
| **FWLSE3078W** | **The thumbnail file is missing in the wlapp file for application "{0}" with environment "{1}" and version "{2}".** <br/><br/>{0} is the application name (any string) {1} is the application environment: android, ios, ... {2} is the application version: 1.0, 2.0, ... |
| **FWLSE3079W** | **Impossible to verify that the application "{2}" with environment "{3}" and version "{4}" has been built with the same {1} version as the {0} runtime because the application and runtime versions are both built with versions of Worklight Studio older than 6.0. Please ensure that both have been built with the same version of {1}.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is the application name (any string) {3} is the application environment: android, ios, ... {4} is the application version: 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, deploy wlapp build with Worklight Studio 5.0.6 or older, into MobileFirst Server 7.1. |
| **FWLSE3080W** | **Impossible to verify that the adapter "{2}" has been built with the same {1} version as the {0} runtime because the adapter and runtime versions are both built with versions of Worklight Studio older than 6.0. Please ensure that both have been built with the same version of {1}.** <br/><br/>{0} is the word MobileFirst {1} is the name of studio, e.g. MobileFirst Studio {2} is the adapter name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, deploy adapter build with Worklight Studio 5.0.6 or older, into MobileFirst Server 7.1. |
| **FWLSE3081E** | **Application authenticity check is not supported for the environment "{0}". Only iOS and Android environments are supported.** <br/><br/>{0} is the application environment: android, ios, ...<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, edit android app with enabled authenticity check and modify the env, then deploy. |
| **FWLSE3082E** | **The content of the file "{0}" is empty and so cannot be deployed.** <br/><br/>{0} is a file name |
| **FWLSE3084E** | **The adapter file cannot be deployed since it doesn't contain the mandatory adapter XML file. Check that it was correctly built.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> deploy an adapter that contains no XML file |
| **FWLSE3085E** | **The application file cannot be deployed since it doesn''t contain the mandatory "{0}" file. Check that it was correctly built.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> deploy a wlapp that contains no meta/deployment.data file |
| **FWLSE3090E** | **The transaction was never finished. Check the application server logs.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, happens when a transaction gets stalled of unknown reason for 30 min |
| **FWLSE3091W** | **The processing of transaction {0} failed. Check the application server logs.** <br/><br/>{0} is the transaction id, typically a number<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Maybe can be produced by shutting down a runtime while a transaction is ongoing. |
| **FWLSE3092W** | **The transaction {0} was canceled before its processing started. Check the application server logs.** <br/><br/>{0} is the transaction id, typically a number<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult.This occurs if you create several deployment transactions, from which at least one is not yet processed when shut down the server. When restart the server, the unprocessed transaction gets cancelled. |
| **FWLSE3100W** | **The binary resource {3} cannot be accessed. HTTP Range Request {0}-{1} cannot be satisfied. The maximal content length is {2} bytes.** <br/><br/>{0} is the start of the byte range, e.g. 0 {1} is the end of the byte range, e.g. 6666 {2} is the number of bytes available, e.g. 25 {3} is the resource name (like a file name) |
| **FWLSE3101W** | **Application {1}, environment {2}, version {3} built with {0} version {4} was overridden by environment built with {0} version {5}** <br/><br/>{0} is the name of studio: MobileFirst Studio {1} is the application name (any string) {2} is the application environment: android, ios, ... {3} is the application version: 1.0, 2.0, ... {4} is the a version of studio, e.g. 3.0 {5} is the another version of studio, e.g. 4.0<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, you need to have an app build with two different versions of Studio, but the app must have the same version number and the same environment. If you then deploy both apps on the same server, the message may occur. But maybe the message is hidden by other messages. I never saw that message. |
| **FWLSE3102W** | **Application {0} is not enabled for push notification.** <br/><br/>{0} is the application name (any string) |
| **FWLSE3103E** | **Push notification tag {0} not found for application {2} of runtime {1}.** <br/><br/>{0} is the push notification tag (any string) {1} is the runtime name (any string) {2} is the application name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> occurs only in unit tests |
| **FWLSE3104E** | **Push notification tag {0} already exists for application {2} of runtime {1}.** <br/><br/>{0} is the push notification tag (any string) {1} is the runtime name (any string) {2} is the application name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3105W** | **Push notification certificate for {0} expired.** <br/><br/>{0} is the push mediator name (any string)<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3113E** | **Multiple errors when synchronizing the runtime {0}.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this occurs in a farm setup (multi node setup) when the server starts, but each node reports a different error. |
| **FWLSE3199I** | **========= {0} version {1} started.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> This occurs always in the server log when the server started. |
| **FWLSE3210W** | **Environment: {1} of application {0} version {2} has been deployed with a different version of the native MobileFirst SDK. Direct updates will no longer be available for existing clients with other versions of the MobileFirst SDK. To continue to use direct updates, increment the app version, publish it to the public app store, deploy to the server, and (optionally) block/notify older versions of the app to enforce customers to upgrade to the new version from the app store.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this may occur if an app was created by an older version of MobileFirst Studio with a different, older MobileFirst SDK. But I am not familiar with native MobileFirst SDK versions. |
| **FWLSE3119E** | **APNS certificate validation failed. See additional messages for details.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Occurs if the Apple Push Notification certificate is invalid. |
| **FWLSE3120E** | **This API can be used only after migrating the application to MobileFirst Platform 6.3. Current version of the application is {0}**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Occurs with new push notifications used with old apps. |
| **FWLSE3121E** | **This API is no longer available on the server. See additional messages for details.** |
| **FWLSE3122E** | **The authenticity check rule of an application can no longer be modified inside the server. You should rebuild your application in order to modify the authenticity check rule and deploy it.** |
| **FWLSE3123W** | **Environment: {1} of application {0} version {2} has been deployed with extended application authenticity disabled. It is recommended to to use extended app authenticity to further protect from unauthorized apps by using the enable extended-authenticity command of the mfpadm tool before deploying the application.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> In Operations Console, deploy an app with basic authenticity. All apps prior to 7.0 have no extended authenticity and should show this warning or the next. The warning does not occur if you use the Operations Console that is embedded in Worklight Studio. |
| **FWLSE3124W** | **Environment: {1} of application {0} version {2} has been deployed with application authenticity disabled. Enable it to further protect from unauthorized apps.** |

### Token License Messages

| **FWLSE3125E** | **The Rational Common Licensing native library is not found. Make sure the JVM property (java.library.path) is defined with the right path and the native library can be executed. Restart IBM MobileFirst Platform Server after taking corrective action.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Do not set the JVM property (java.library.path) pointing to RCL native library in the application server configuration. Then this message will be thrown at runtime synchronization. |
| **FWLSE3126E** | **The Rational Common Licensing shared library is not found. Make sure the shared library is configured. Restart IBM MobileFirst Platform Server after taking corrective action.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Do not set the shared library path pointing to RCL java library in the application server configuration. Then this message will be thrown at runtime synchronization. |
| **FWLSE3127E** | **The Rational License Key Server connection is not configured. Make sure the admin JNDI properties "{0}" and "{1}" are set. Restart IBM MobileFirst Platform Server after taking corrective action.** <br/><br/>{0} is the host name of the license server {1} is the port of the license server<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Do not set the JNDI properties (related to token licensing) in the application server configuration. Then this message will be thrown at runtime synchronization. |
| **FWLSE3128E** | **The Rational License Key Server "{0}" is not accessible. Make sure that license server is running and accessible to IBM MobileFirst Platform Server. If this error occurs at runtime startup, restart IBM MobileFirst Platform Server after taking corrective action.** <br/><br/>{0} is the full address of the license server<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Do not start the license server. Then this message will be thrown at runtime synchronization or during application deployment. |
| **FWLSE3129E** | **Insufficient token licenses for feature "{0}".** <br/><br/>{0} is the license feature name<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Exhaust all the licenses in the license server. Then this message will be thrown at runtime synchronization or during application deployment. |
| **FWLSE3130E** | **Token licenses have expired for feature "{0}".** <br/><br/>{0} is the license feature name<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Allow the token licenses to expire. Then this message will be thrown at runtime synchronization or during application deployment. |
| **FWLSE3131E** | **License error was detected. Check the application server logs for more details.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. |
| **FWLSE3132E** | **The connection to Rational License Key Server is configured with the admin JNDI properties "{0}" and "{1}" but this IBM MobileFirst Platform Server is not enabled for token licensing.** <br/><br/>{0} is the host name of the license server {1} is the port of the license server<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Do not activate token licensing. But set the JNDI properties (related to token licensing) in the application server configuration. Then this message will be thrown at runtime synchronization. |
| **FWLSE3133I** | **This application is disabled. Please contact the administrator for more details.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Allow the token licenses to expire. Then all the applications would automatically gets disabled and when the application is accessed from device, this message is seen. |
| **FWLSE3134E** | **The Rational Common Licensing native library is not found.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3135E** | **The Rational Common Licensing shared library is not found.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3136E** | **The Rational License Key Server details are not configured.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3137E** | **The Rational License Key Server "{0}" is not accessible.** <br/><br/>{0} is the full address of the license server<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3138E** | **Insufficient token licenses for feature "{0}".** <br/><br/>{0} is the license feature name<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3139E** | **Token licenses have expired for feature "{0}".** <br/><br/>{0} is the license feature name<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3140E** | **License error was detected.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |
| **FWLSE3141E** | **The Rational License Key Server details are configured.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Internally to be stored in db. Difficult. |

### Farm Configuration Messages

| **FWLSE3200W** | **The server "{0}" cannot be added as a new farm member because a server with the same ID is already registered for the runtime "{1}". This can happen either if the JNDI property mfp.admin.serverid has the same value on another running node, or if your server did not unregister itself properly when it last shut down.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this happens if you configure a server farm wrongly. A server farm consists of multiple computers (nodes). Each computer must have an id (JNDI property mfp.admin.serverid).  If you use the exact same id for two different nodes, you would see this message in the server log. |
| **FWLSE3201E** | **Failed to unregister the farm member "{0}" for runtime "{1}".**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, may occur in the server logs if you have a server farm and shut down one node in the farm, and anything went wrong during the shutdown. |
| **FWLSE3202E** | **Failed to retrieve the list of farm members for server "{0}".**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, may occur in the server logs when the admin service is shut down in a server farm.  It then tries to notify the farm members and needs a list of farm members for that. |
| **FWLSE3203E** | **No farm node is registered with server id "{0}" for runtime "{1}".** |
| **FWLSE3204W** | **Node "{0}" seems unreachable, this transaction was not performed on this node.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this can occur in a server farm if you disconnect one farm node from the network and wait long enough. It appears in the server log. |
| **FWLSE3205W** | **Unable to put the runtime "{0}" on server "{1}" in denial of service mode. You can ignore this warning if the runtime is also shutting down.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this can occur in a server farm if you disconnect one farm node from the network and wait long enough or shut down the server. But additionally to the normal processing, another exception must happen (e.g. an OutOfMemory exception). |
| **FWLSE3206E** | **Not allowed to unregister the server "{0}" for the runtime "{1}" because the server appears to be still alive.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, you could reproduce this by calling the REST API to remove a farm node while this farm node is still running. |
| **FWLSE3207E** | **The farm member with server id "{0}" is not reachable. Please try again later.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. In theory, this can occur in a server farm if you disconnect one farm node from the network and then try to deploy a wlapp. The transaction will fail and you can then see this message in the error log (transaction log, accessible though the UI). |
| **FWLSE3208E** | **An invalid status code "{0}" was returned. The response content is "{1}".**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> This can occur whenever an unexpected status code is returned from a config service REST invocation. |
| **FWLSE3209E** | **An exception has occurred during configuration service invocation. The exception message is "{0}".**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> This can occur whenever there are problems with CRUD operations dealing with configurations in the configuration service. This exection is generic and wraps multiple errors |
| **FWLSE3210E** | **The resource(s) {0} that you are trying to export is not found.** |
| **FWLSE3211E** | **The resourceInfos parameter {0} is specified incorrectly. The parameter needs to have a value in the format resourceName\|\|resourceType.** |

## {{ site.data.keys.mf_console }} Messages

**Prefix:** FWLSE<br/>
**Range:** 3300-3399

| **FWLSE3301E** | **Problem with SSL certificates. Possible fixes: Put the application server''s certificate into the truststore. Or define the JNDI property {0} to {1} (not in production environments).**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Difficult. Occurs if you setup the server with SSL, but use a wrong SSL certificate. Can also occur with self-signed certificates under certain circumstances. |
| **FWLSE3302E** | **The keystore for the runtime "{0}" does not exist in the MobileFirst administration database. The database may be corrupted.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> if keystore not present |
| **FWLSE3303E** | **The Application name "{0}", Environment "{1}", and Version "{2}" from the Web Resource/Authenticity data does not match the deployed application.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Upload a web resource generated for a different application |
| **FWLSE3304E** | **JNDI property "{0}" is not set. Push service is not enabled in this server.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Give incorrect push server url |
| **FWLSE3305E** | **Keystore alias can not be null.**<br/><br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> try to upload a keystore and skip the password and alias fields. |
| **FWLSE3306E** | **Keystore password can not be null.** |
| **FWLSE3307E** | **Can not find alias "{0}" in this keystore.** |
| **FWLSE3308E** | **Alias password mismatch.** |
| **FWLSE3309E** | **Alias password can not be null.** |
| **FWLSE3310W** | **The server allows only "{0}" applications to be deployed.** <br/>{::nomarkdown}<i>Steps to reproduce:</i>{:/}<br/> Try to deploy apps that will cross the limit set by the jndi property mfp.admin.max.apps |
