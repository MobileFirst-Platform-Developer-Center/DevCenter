# Class

## `WLAnalytics`

WLAnalytics means of persistently capturing analytics data and provides a method call to send captured data to the IBM MobileFirst Platform server, to be forwarded to the Operational Analytics engine. Capture is on by default. When this WLAnalytics class's capture flag is turned on via enable method call, all messages passed through this class's log method will be persisted to file in the following JSON object format: { "timestamp" : "17-02-2013 13:54:27:123", // "dd-MM-yyyy hh:mm:ss:S" "level" : "ERROR", // ERROR || WARN || INFO || LOG || DEBUG "package" : "your_tag", // typically a class name, app name, or JavaScript object name "msg" : "the message", // a helpful log message "metadata" : {"hi": "world"}, // (optional) additional JSON metadata, appended via doLog API call "threadid" : long // (optional) id of the current thread }

### `constructor()`

### `enable()`

Enable persistent capture of analytics data. Enable, and thus capture, is the default.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `disable()`

Disable persistent capture of analytics data.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `log(message: string, metadata: *)`

Log data you want to be captured in the context of "analytics". Some data is already captured by the framework. To avoid collisions, the following keys will be excluded if logged: appStoreID appStoreLabel appStoreVersion appStoreVersionDisplay mfpAppName mfpAppVersion deviceBrand deviceOSversion deviceOS deviceModel deviceID timezone timestamp

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The message to be logged |
| metadata | * |  | Any additional metadata to be added to the log message. |

### `addDeviceEventListener(deviceEvent: string)`

Enable analytics to capture the specified DeviceEvent

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| deviceEvent | string |  | A string representation of the device event to capture. Valid values are "LIFECYCLE" and "NETWORK" |

### `removeDeviceEventListener(deviceEvent: string)`

Disable analytics from capturing the specified DeviceEvent

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| deviceEvent | string |  | A string representation of the device event to capture. Valid values are "LIFECYCLE" and "NETWORK" |

### `send()`

Send the accumulated log data when the persistent log buffer exists and is not empty.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `sendWithCallback(): Promise`

Send the accumulated log data when the persistent log buffer exists and is not empty.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setUserContext(user: string)`

Specify current application user. If you want user-based analytics, you must use this method call. For example, use it when the user logs in, and call the unsetUserContext method when the user logs out. Or if your application supports user profiles, call this method when the user profile changes.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| user | string |  | User ID for the current app user. |

### `unsetUserContext()`

Unset any user context previously set.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

## `WLAuthorizationManager`

This class manages the OAuth interaction between the device and the authorization server.

### `constructor()`

### `obtainAccessToken(scope: string): Promise<string>`

Initiates the OAuth flow with the MobileFirst server to get an access token for the specified resource scope.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| scope | string |  | Scope for which the access token is to be returned. |

### `login(securityCheck: string, credentials: Object): Promise<string>`

Logs in to the specified security check.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| securityCheck | string |  | The security check to log into. |
| credentials | Object |  | Credentials for logging in to the security check in JSON format. |

### `logout(securityCheck: string): Promise<string>`

Logs out of a specified security check

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| securityCheck | string |  | The security check to log out of |

### `clearAccessToken(scope: string)`

Clears the provided access token. Note: When failing to access a resource with an obtained token, call the clearAccessToken method to clear the invalid token before calling WLAuthorizationManager.obtainAccessToken to obtain a new access token.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| scope | string |  | The scope whose access token must be cleared. |

## `WLClient`

This collection of topics lists the public methods of the IBM® MobileFirst® runtime client API for mobile apps, desktop, and web. WL.Client is a JavaScript client library that provides access to IBM MobileFirst capabilities. You can use WL.Client to perform the following types of functions:

### `constructor()`

### `addGlobalHeader(name: string, value: string)`

Adds a HTTP header to all requests made by the MobileFirst SDK. Use the WLClient.removeGlobalHeader API to stop adding the header to further requests

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| name | string |  | Name of the HTTP header |
| value | string |  | The value of the HTTP header |

### `submitChallengeAnswer(securityCheckName: string, answer: object)`

Send an answer back to the security check that triggered this challenge. The answer should be in a JSON format.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| securityCheckName | string |  | The security check name that represents the challenge. Used to identify which security check requires authentication. |
| answer | object |  | The challenge answer to be returned to the server. For example, this could be credentials collected from the user. |

### `getDeviceDisplayName(): Promise<string>`

Gets the display name of the device. The display name is retrieved from the MobileFirst Server registration data. You can see the device display name in the Devices section of the MobileFirst Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setDeviceDisplayName(deviceDisplayName: string): *`

Sets the friendly name of the device. You can see the device display name in the Devices section of the MobileFirst console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| deviceDisplayName | string |  | The friendly name to be set for the device. |

### `getServerUrl(): Promise<string>`

Returns the current MobileFirst Platform server URL. You can define the server URL in the mfpclient.properties (Android) / mfpclient.plist (iOS) or by calling the WLClient.setServerUrl API

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setServerUrl(serverUrl: string): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| serverUrl | string |  | The URL of the MobileFirst Platform server to point to. |

### `setHeartbeatInterval(heartbeatIntervalInSeconds: number)`

The number of seconds between which a heartbeat request is sent to the MobileFirst server to keep the connection alive. The default interval is 7 minutes or 420 seconds. Heartbeats are sent only when the app is in the foreground.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| heartbeatIntervalInSeconds | number |  | Heartbeat interval value in seconds |

### `pinTrustedCertificatesPublicKey(certificateFileNames: string[])`

Pins the host X509 certificate public key to the client application. Secured calls to the pinned remote host will be checked for a public key match. Secured calls to other hosts containing other certificates will be rejected. Some mobile operating systems might cache the certificate validation check results. Your app must call the certificate pinning method before making a secured request. Calling this method a second time overrides any previous pinning operation. The certificates must be in DER format. When multiple certificates are pinned, a secured call is checked for a match with any one of the certificates.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| certificateFileNames | string[] |  | The list of paths to the certificate files. On Android this will be under the assets folder. |

### `registerChallengeHandler(challengeHandlerClass: ChallengeHandler, securityCheckName: string)`

Register a challenge handler to handle act upon challenges provided for a given security check.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| challengeHandlerClass | ChallengeHandler |  | The challenge handler object implementing the methods of a SecurityCheck Challenge handler |
| securityCheckName | string |  | The name of the security check for which this challenge handler must respond. |

## `WLLogger`

WLLogger is a class for logging that provides some enhanced capability such as capturing log calls, package filtering, and log level control at both global and individual package scope. It also provides a method call to send captured logs to the IBM MobileFirst Platform server. When this Logger class's capture flag is turned on via setCapture(true) method call, all messages passed through this class's log methods will be persisted to store in the following JSON object format: { "timestamp" : "17-02-2013 13:54:27:123", // "dd-MM-yyyy hh:mm:ss:S" "level" : "ERROR", // FATAL || ERROR || WARN || INFO || LOG || DEBUG || TRACE "package" : "your_tag", // typically a class name, app name, or JavaScript object name "msg" : "the message", // a helpful log message "metadata" : {"hi": "world"}, // (optional) additional JSON metadata, appended via doLog API call "threadid" : long // (optional) id of the current thread } Log file data is sent to the IBM MobileFirst Platform server when this class's send() method is called and the accumulated log size is greater than zero. When the log data is successfully uploaded, the persisted local log data is deleted.

### `constructor()`

### `logTag: *`

### `init(tag: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| tag | * | nullable: undefined |

### `debug(message: string)`

Logs a message at DEBUG level

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The message to log. |

### `debugWithMetadata(message: string, metadata: Object)`

Logs a message at DEBUG level with additional metadata. The metadata is available as custom fields while creating custom charts on the MobileFirst Analytics Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The message to log |
| metadata | Object |  | Any additional metadata to log. |

### `error(message: string)`

Logs a message at ERROR level

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The error message to log. |

### `errorWithMetadata(message: string, metadata: Object)`

Logs a message at ERROR level with additional metadata. The metadata is available as custom fields while creating custom charts on the MobileFirst Analytics Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The error message to log |
| metadata | Object |  | Any additional metadata to log. |

### `warn(message: string)`

Logs a message at WARN level

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The warning message to log. |

### `warnWithMetadata(message: string, metadata: Object)`

Logs a message at WARN level with additional metadata. The metadata is available as custom fields while creating custom charts on the MobileFirst Analytics Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The warning message to log |
| metadata | Object |  | Any additional metadata to log. |

### `info(message: string)`

Logs a message at INFO level

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The information message to log. |

### `infoWithMetadata(message: string, metadata: Object)`

Logs a message at INFO level with additional metadata. The metadata is available as custom fields while creating custom charts on the MobileFirst Analytics Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The information message to log |
| metadata | Object |  | Any additional metadata to log. |

### `trace(message: string)`

Logs a message at TRACE level

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The trace message to log. |

### `traceWithMetadata(message: string, metadata: Object)`

Logs a message at TRACE level with additional metadata. The metadata is available as custom fields while creating custom charts on the MobileFirst Analytics Console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| message | string |  | The trace message to log |
| metadata | Object |  | Any additional metadata to log. |

### `setCapture(capture: boolean)`

Global setting to turn persisting of log data passed to this class's log methods on or off.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| capture | boolean |  | True to turn on logging, false to turn it off. |

### `getCapture(): Promise<boolean>`

Get the current value of the capture flag, indicating that the Logger is recording log calls persistently.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setFilters(filter: Object)`

Filter on packages at and above designated LEVEL. This is a white list. Any package not listed in the filters will not be logged. Pass null or an empty HashMap parameter to remove filters and resume logging at the default LEVEL.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| filter | Object |  | set of filters and associated level (and above) to allow for logging |

### `getFilters(): Promise<Object>`

Get the current list of filters.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getLevel(): Promise<string>`

Get the current Logger level.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `send()`

Send the accumulated log data when the persistent log buffer exists and is not empty. The data accumulates in the log buffer from the use of Logger with capture turned on.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setLevel(level: string)`

Set the level and above at which log messages should be saved/printed. A null parameter value is ignored and has no effect.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| level | string |  | A string representation of the Logger level. Valid values are "TRACE", "INFO", "DEBUG", "WARN", "ERROR" |

### `updateConfigFromServer()`

Get and apply the configuration from the IBM MobileFirst Platform Server. The configuration comes from the use of the "Config Profiles" tab in the IBM MobileFirst Platform administrative console.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getMaxFileSize(): Promise<number>`

Get the current setting for the max file size threshold.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `setMaxFileSize(sizeInBytes: number)`

Set the maximum size of the local log file. Once the maximum file size is reached, no more data will be appended. The file must then be sent to the server using the send() API.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| sizeInBytes | number |  | The maximum size of the file in number of bytes. The minimum is 10000. |

## `WLResourceRequest`

This class encapsulates a resource request. The resource can be an adapter that is deployed to an instance of MobileFirst Server, or a resource on an external resource server. The class provides several send methods with different inputs for the body of a request. A successful response is any response with a status in the 2xx range from the server. A response with a 4xx or 5xx status from the server is considered a failure.

### `constructor(url: string, method: string, timeout: number, scope: string)`

Create a new ResourceRequest object to fetch data from a resource endpoint.

### `uuid: *`

### `send(): Promise<Map, String>`

Initiate a request to the resource without any content in the body.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `sendWithJSON(jsonObject: Object): Promise<Map, String>`

Initiate a request to the resource with the specified JSON content in the body.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| jsonObject | Object |  | The body of the request in JSON format. |

### `sendWithFormParameters(formParams: Object): Promise<Map, String>`

Initiate a request to the resource with the specified form parameters in the body.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| formParams | Object |  | The JSON object of form parameters in name-value pairs |

### `sendWithRequestBody(body: string): Promise<Map, String>`

Initiate a request to the resource with raw text in the body.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| body | string |  | The body that is part of the request. |

### `getMethod(): Promise<string>`

Get the HTTP method of this resource request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `addHeader(name: string, value: string)`

Adds a header to this resource request. This method allows response headers to have multiple values.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| name | string |  | The name of the header to add to the request. |
| value | string |  | The value of the header to add to the request. |

### `setQueryParameters(params: Object)`

Set the query parameters that should be added to this request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| params | Object |  | A JSON object containing name value pairs of query parameters that should be added to this request. |

### `getQueryParameters(): Promise<Object>`

Get all the query parameters that are added to this request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getQueryString(): Promise<string>`

Get the query string of this request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getAllHeaders(): Promise<Object>`

Get a list of all the headers added to this request

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getHeaders(headerName: string): Promise<Array>`

Get a list of values for a given header

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| headerName | string |  | The name of the header |

### `setHeaders(headers: Object)`

Sets the specified headers for this resource request. For a header that is already set, the new value overwrites the previous value.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| headers | Object |  | A JSON object containing a map of all headers to be set for this request. |

### `removeHeaders(headerName: string)`

Removes headers with the specified name for this resource request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| headerName | string |  | The name of the header to remove. |

### `setTimeout(timeoutInMilliseconds: number)`

Sets the expiration period (timeout) for this resource request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| timeoutInMilliseconds | number |  | The timeout in milliseconds |

### `getUrl(): string`

Returns the URL for this resource request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

### `getTimeout(): number`

Get the timeout for this resource request.

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

# Function

## `bytesToUuid(buf: *, offset: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| buf | * | nullable: undefined |
| offset | * | nullable: undefined |

## `md5(bytes: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| bytes | * | nullable: undefined |

## `md5ToHexEncodedArray(input: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| input | * | nullable: undefined |

## `wordsToMd5(x: *, len: *): undefined[]`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| x | * | nullable: undefined |
| len | * | nullable: undefined |

## `bytesToWords(input: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| input | * | nullable: undefined |

## `safeAdd(x: *, y: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| x | * | nullable: undefined |
| y | * | nullable: undefined |

## `bitRotateLeft(num: *, cnt: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| num | * | nullable: undefined |
| cnt | * | nullable: undefined |

## `md5cmn(q: *, a: *, b: *, x: *, s: *, t: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| q | * | nullable: undefined |
| a | * | nullable: undefined |
| b | * | nullable: undefined |
| x | * | nullable: undefined |
| s | * | nullable: undefined |
| t | * | nullable: undefined |

## `md5ff(a: *, b: *, c: *, d: *, x: *, s: *, t: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| a | * | nullable: undefined |
| b | * | nullable: undefined |
| c | * | nullable: undefined |
| d | * | nullable: undefined |
| x | * | nullable: undefined |
| s | * | nullable: undefined |
| t | * | nullable: undefined |

## `md5gg(a: *, b: *, c: *, d: *, x: *, s: *, t: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| a | * | nullable: undefined |
| b | * | nullable: undefined |
| c | * | nullable: undefined |
| d | * | nullable: undefined |
| x | * | nullable: undefined |
| s | * | nullable: undefined |
| t | * | nullable: undefined |

## `md5hh(a: *, b: *, c: *, d: *, x: *, s: *, t: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| a | * | nullable: undefined |
| b | * | nullable: undefined |
| c | * | nullable: undefined |
| d | * | nullable: undefined |
| x | * | nullable: undefined |
| s | * | nullable: undefined |
| t | * | nullable: undefined |

## `md5ii(a: *, b: *, c: *, d: *, x: *, s: *, t: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| a | * | nullable: undefined |
| b | * | nullable: undefined |
| c | * | nullable: undefined |
| d | * | nullable: undefined |
| x | * | nullable: undefined |
| s | * | nullable: undefined |
| t | * | nullable: undefined |

## `md5(bytes: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| bytes | * | nullable: undefined |

## `exports(): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |

## `f(s: *, x: *, y: *, z: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| s | * | nullable: undefined |
| x | * | nullable: undefined |
| y | * | nullable: undefined |
| z | * | nullable: undefined |

## `ROTL(x: *, n: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| x | * | nullable: undefined |
| n | * | nullable: undefined |

## `sha1(bytes: *): undefined[]`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| bytes | * | nullable: undefined |

## `sha1(bytes: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| bytes | * | nullable: undefined |

## `uuidToBytes(uuid: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| uuid | * | nullable: undefined |

## `stringToBytes(str: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| str | * | nullable: undefined |

## `exports(name: *, version: *, hashfunc: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| name | * | nullable: undefined |
| version | * | nullable: undefined |
| hashfunc | * | nullable: undefined |

## `v1(options: *, buf: *, offset: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| options | * | nullable: undefined |
| buf | * | nullable: undefined |
| offset | * | nullable: undefined |

## `v4(options: *, buf: *, offset: *): *`

| Name | Type | Attribute | Description |
| --- | --- | --- | --- |
| options | * | nullable: undefined |
| buf | * | nullable: undefined |
| offset | * | nullable: undefined |