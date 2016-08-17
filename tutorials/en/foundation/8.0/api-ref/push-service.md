---
layout: tutorial
title: REST API for MobileFirst Server Push Service
breadcrumb_title: Push Service
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<br/>
The REST API for the Push service in the MobileFirst runtime environment enables back-end server applications that were deployed outside of the MobileFirst Server to access Push functions from a REST API endpoint.

The Push service on the MobileFirst Server is exposed over a REST API endpoint that can be directly accessed by non-mobile clients. You can use the REST API runtime services for Push for registrations, subscriptions, messages, and retrieving tags. Paging and filtering is supported for database persistence in both Cloudant and SQL.

This REST API endpoint is protected by OAuth which requires the clients [to be confidential clients]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/confidential-clients/) and also possess the required access scopes in their OAuth access tokens that is passed by a designated HTTP header.

### Select a REST endpoint:

<div class="panel-group accordion" id="api-ref" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-registration-del">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-registration-del" aria-expanded="false" aria-controls="collapse-device-registration-del"><b>Push Device Registration (DELETE)</b></a>
            </h4>
        </div>

        <div id="collapse-device-registration-del" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-registration-del">
            <div class="panel-body">
                <p>Deletes (un-registers) an existing device registration from the push service.</p>
                
                <h5>Description:</h5>
                <p>The device registrations of push service is deleted for the given <code>deviceId</code>. The call returns HTTP response code 204 with no content on successful deletion of the device registration.</p>
                
                <h5>Method:</h5>
                <p><code>DELETE</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/devices/deviceId</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>deviceId:</b> The device identifier</li>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                </ul>
                
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>404:</b> A device registration with the specified <code>deviceId</code> is not found.</li>
                    <li><b>406:</b> Unsupported Accept type - The content type specified in Accept header is not application/json.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registration-del" data-target="#collapse-device-registration-del" aria-expanded="false" aria-controls="collapse-device-registration-del"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-registration-get">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-registration-get" aria-expanded="false" aria-controls="collapse-device-registration-get"><b>Push Device Registration (GET)</b></a>
            </h4>
        </div>

        <div id="collapse-device-registration-get" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-registration-get">
            <div class="panel-body">
                <p>Retrieves an existing device registration.</p>
                
                <h5>Description:</h5>
                <p>Device registrations for a push service that are retrieved for a specific <code>deviceId</code>.</p>
                
                <h5>Method:</h5>
                <p><code>GET</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/devices/deviceId</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>deviceId:</b> The device identifier</li>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                </ul>
                
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Response</h5>
                <p>The details of the device registration that is retrieved.</p>
                
                <b>JSON example</b>
                
{% highlight json %}
{
    "createdMode" : "API",
    "createdTime" : "2015-05-20T11:42:11Z",
    "deviceId" : "12345-6789",
    "lastUpdatedTime" : "2015-05-20T11:42:11Z",
    "phoneNumber" : "123456789",
    "platform" : "A",
    "token" : "12345-6789",
    "userId" : "admin",
}
{% endhighlight %}

                <h5>Response Properties</h5>
                <p>The response has the following properties:</p>
                
                <ul>
                    <li><b>createdMode:</b> The mode of creation.</li>
                    <li><b>createdTime:</b> The date and time when the push device registration was created on the server in ISO 8601 format.</li>
                    <li><b>deviceId:</b> The unique id of the device.</li>
                    <li><b>lastUpdatedTime:</b> The date and time when the push device registration was last updated on the server in ISO 8601 format.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform.</li>
                    <li><b>token:</b> The unique push token of the device.</li>
                    <li><b>userId:</b> The <code>userId</code> of the device.</li>                    
                </ul>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>404:</b> A device registration with the specified <code>deviceId</code> is not found.</li>
                    <li><b>406:</b> Unsupported Accept type - The content type specified in Accept header is not application/json.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
            
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registration-get" data-target="#collapse-device-registration-get" aria-expanded="false" aria-controls="collapse-device-registration-get"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-registration-post">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-registration-post" aria-expanded="false" aria-controls="collapse-device-registration-post"><b>Push Device Registration (POST)</b></a>
            </h4>
        </div>

        <div id="collapse-device-registration-post" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-registration-post">
            <div class="panel-body">
                <p>Creates a device registration with the push service.</p>
                
                <h5>Description:</h5>
                <p>The device registrations happens from the device. The <code>deviceId</code> is the unique ID for the device for the application.</p>
                
                <h5>Method:</h5>
                <p><code>POST</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/devices</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/devices</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                    <li><b>Content-Type:</b> (Mandatory) Specify the JSON content type. For example: application/json.</li>
                </ul>
                
                <h5>Consumes</h5>
                <p>application/json</p>
                
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Payload</h5>
                <p>The details of the device registration.</p>
                
                <b>JSON example</b>
                
{% highlight json %}
{
  "deviceId" : "12345-6789",
  "phoneNumber" : "123456789",
  "platform" : "A",
  "token" : "xyz",
}
{% endhighlight %}
                
                <h5>Payload properties:</h5>
                <p>The payload has the following properties:</p>
                
                <ul>
                    <li><b>deviceId:</b> Unique id of the device.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.</li>
                    <li><b>token:</b> Device token obtained via the service provider.</li>
                </ul>
                
                <h5>Response</h5>
                <p>The details of the application.</p>
                
                <b>JSON example</b>
                
{% highlight json %}
{
  "createdMode" : "API",
  "createdTime" : "2015-05-20T11:42:11Z",
  "deviceId" : "12345-6789",
  "lastUpdatedTime" : "2015-05-20T11:42:11Z",
  "phoneNumber" : "123456789",
  "platform" : "A",
  "token" : "xyz",
  "userAgent" : "TestUserAgent",
  "userId" : "admin",
}
{% endhighlight %}   

                <h5>Response properties</h5>
                <p>The response has the following properties:</p>
                
                <ul>
                    <li><b>createdMode:</b> The mode of creation.</li>
                    <li><b>createdTime:</b> The date and time when the push device registration was created on the server in ISO 8601 format.</li>
                    <li><b>deviceId:</b> The unique id of the device.</li>
                    <li><b>lastUpdatedTime:</b> The date and time when the push device registration was last updated on the server in ISO 8601 format.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform. The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.</li>
                    <li><b>token:</b> The unique push token of the device.</li>
                    <li><b>userAgent:</b> The user agent for the the device registration</li>
                    <li><b>userId:</b> The <code>userId</code> of the device.</li>                    
                </ul>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>400:</b> Bad Request - The request was not understood by the push server. An invalid JSON could result in this error code.</li>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>405:</b> Unsupported Content type - The content type specified in Content-Type header is not application/json.</li>
                    <li><b>406:</b> Unsupported Accept type - The content type specified in Accept header is not application/json.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registration-post" data-target="#collapse-device-registration-post" aria-expanded="false" aria-controls="collapse-device-registration-post"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-registration-put">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-registration-put" aria-expanded="false" aria-controls="collapse-device-registration-put"><b>Push Device Registration (PUT)</b></a>
            </h4>
        </div>

        <div id="collapse-device-registration-put" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-registration-put">
            <div class="panel-body">
                <p>Updates an existing device registration with the push service.</p>
                
                <h5>Description:</h5>
                <p>The push device registration is updated with the new user ID or the token specified. In most use cases this call is used to update the <code>userId</code> only.</p>
                
                <h5>Method:</h5>
                <p><code>PUT</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/devices/deviceId</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>deviceId:</b> The device identifier</li>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                    <li><b>Content-Type:</b> (Mandatory) Specify the JSON content type. For example: application/json.</li>
                </ul>
                
                <h5>Consumes</h5>
                <p>application/json</p>
                
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Payload</h5>
                <p>The details the device registration will be updated with.</p>
                
                <b>JSON example</b>
                
    {% highlight json %}
    {
        "deviceId" : "12345-6789",
        "phoneNumber" : "123456789",
        "token" : "xyz",
        "userId" : "admin",
    }
    {% endhighlight %}
                
                <h5>Payload properties:</h5>
                <p>The payload has the following properties:</p>
                
                <ul>
                    <li><b>deviceId:</b> Unique id of the device.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.</li>
                    <li><b>token:</b> Device token obtained via the service provider.</li>
                </ul>
                
                <h5>Response</h5>
                <p>The details of the application.</p>
                
                <b>JSON example</b>
                
    {% highlight json %}
    {
        "createdMode" : "API",
        "createdTime" : "2015-05-20T11:42:11Z",
        "deviceId" : "12345-6789",
        "lastUpdatedTime" : "2015-05-20T11:42:11Z",
        "phoneNumber" : "123456789",
        "platform" : "A",
        "token" : "xyz",
        "userId" : "admin",
    }
    {% endhighlight %}   

                <h5>Response properties</h5>
                <p>The response has the following properties:</p>
                
                <ul>
                    <li><b>createdMode:</b> The mode of creation.</li>
                    <li><b>createdTime:</b> The date and time when the push device registration was created on the server in ISO 8601 format.</li>
                    <li><b>deviceId:</b> The unique id of the device.</li>
                    <li><b>lastUpdatedTime:</b> The date and time when the push device registration was last updated on the server in ISO 8601 format.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform. The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.</li>
                    <li><b>token:</b> The unique push token of the device.</li>
                    <li><b>userId:</b> The <code>userId</code> of the device.</li>                    
                </ul>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>400:</b> Bad Request - The request was not understood by the push server. An invalid JSON could result in this error code.</li>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>404:</b> A device registration with the specified deviceId is not found.</li>
                    <li><b>405:</b> Unsupported Content type - The content type specified in Content-Type header is not application/json.</li>
                    <li><b>406:</b> Unsupported Accept type - The content type specified in Accept header is not application/json.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registration-put" data-target="#collapse-device-registration-put" aria-expanded="false" aria-controls="collapse-device-registration-put"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-registrations-get">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-registrations-get" aria-expanded="false" aria-controls="collapse-device-registration-get"><b>Push Device Registrations (GET)</b></a>
            </h4>
        </div>

        <div id="collapse-device-registrations-get" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-registrations-get">
            <div class="panel-body">
                <p>Retrieves all or a subset of existing device registration(s) of push.</p>
                
                <h5>Description:</h5>
                <p>Device registrations for the push service are retrieved for the specified criteria.</p>
                
                <h5>Method:</h5>
                <p><code>GET</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/devices</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/devices?expand=true&filter=platform==A&offset=0&size=10&userId=admin</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                </ul>
                
                <h5>Query Parameters</h5>
                <p>Query parameters are optional.</p>
                
                <ul>
                    <li><b>expend:</b> Retrieves additional metadata for every device registration that is returned in the response.</li>
                    <li><b>filter:</b> Search criteria filter. Refer to the filter section for detailed syntax.</li>
                    <li><b>offset:</b> Pagination offset that is normally used along with the size.</li>
                    <li><b>size:</b> Pagination size that is normally used along with the offset to retrieve a subset.</li>
                    <li><b>userId:</b> Retrieves device registrations only for the specified user.</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                </ul>
                
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Response</h5>
                <p>The details of the device registration that is retrieved.</p>
                
                <b>JSON example</b>
                
{% highlight json %}
{
  "devices" : [
    {
      "deviceId" : "12345-6789",
      "phoneNumber" : "123456789",
      "platform" : "A",
      "token" : "xyz",
      "userId" : "admin",
    },
    ...
  ],
  "pageInfo" : {
    "count" : "2",
    "next" : "",
    "previous" : "",
    "totalCount" : "10",
  },
}
{% endhighlight %}

                <h5>Response Properties</h5>
                <p>The response has the following properties:</p>
                
                <ul>
                    <li><b>devices:</b> The array of device registrations with Push.</li>
                    <li><b>pageInfo:</b> The pagination information.</li>
                </ul>
                
                <p><code>devices</code> has the following properties:</p>
                
                <ul>
                    <li><b>deviceId:</b> The unique id of the device.</li>
                    <li><b>phoneNumber:</b> Phone number to be used for SMS based notification.</li>
                    <li><b>platform:</b> The device platform.</li>
                    <li><b>token:</b> The unique push token of the device.</li>
                    <li><b>userId:</b> The <code>userId</code> of the device.</li>                    
                </ul>
                
                <p><code>pageInfo</code> has the following properties:</p>
                
                <ul>
                    <li><b>count:</b> The number of device registration that are retrieved.</li>
                    <li><b>next:</b> A hyperlink to the next page.</li>
                    <li><b>previous:</b> A hyperlink to the previous page.</li>
                    <li><b>totalCount:</b> The total number of device registration present for the given search criteria.</li>
                </ul>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>406:</b> Unsupported Accept type - The content type specified in Accept header is not application/json.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
            
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registrations-get" data-target="#collapse-device-registrations-get" aria-expanded="false" aria-controls="collapse-device-registrations-get"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-subscription-del">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-subscription-del" aria-expanded="false" aria-controls="collapse-device-subscription-del"><b>Push Device Subscription (DELETE)</b></a>
            </h4>
        </div>

        <div id="collapse-device-subscription-del" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-subscription-del">
            <div class="panel-body">
                <p>Delete subscription by <code>subscriptionId</code>.</p>
                
                <h5>Description:</h5>
                <p>Using the <code>subscriptionId</code> it unsubscribes the tag from the device. The call would not delete the device registration or the tag.</p>
                
                <h5>Method:</h5>
                <p><code>DELETE</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/subscriptions/subscriptionId</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/subscriptions/mysubscription</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                    <li><b>subscriptionId:</b> The identifier of the subscription.</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                </ul>
                            
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>404:</b> A device registration with the specified deviceId is not found.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-subscription-del" data-target="#collapse-device-subscription-del" aria-expanded="false" aria-controls="collapse-device-subscription-del"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="device-subscription-get">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#api-ref" data-target="#collapse-device-subscription-get" aria-expanded="false" aria-controls="collapse-device-subscription-get"><b>Push Device Subscription (GET)</b></a>
            </h4>
        </div>

        <div id="collapse-device-subscription-get" class="panel-collapse collapse" role="tabpanel" aria-labelledby="device-subscription-get">
            <div class="panel-body">
                <p>Retrieves an existing subscription.</p>
                
                <h5>Description:</h5>
                <p>The subscription referenced by the subscriptionId is retrieved.</p>
                
                <h5>Method:</h5>
                <p><code>GET</code></p>
                
                <h5>Path:</h5>
                <p><code>/apps/applicationId/subscriptions/subscriptionId</code></p>
                
                <h5>Example:</h5>
                <p><code>https://example.com:443/imfpush/v1/apps/myapp/subscriptions/mysubscription</code></p>
                
                <h5>Path Parameters:</h5>
                <ul>
                    <li><b>applicationId:</b> The name or identifier of the application</li>
                    <li><b>subscriptionId:</b> The identifier of the subscription.</li>
                </ul>
                
                <h5>Header Parameters:</h5>
                <ul>
                    <li><b>Accept-Language:</b> (Optional) The preferred language to use for error messages. Default: en-US</li>
                    <li><b>Authorization:</b> (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.</li>
                </ul>
                            
                <h5>Produces:</h5>
                <p>application/json</p>
                
                <h5>Response:</h5>
                <p>The details of the device subscription that is retrieved.</p>
                
                <b>JSON example</b>
                
    {% highlight json %}
    {
      "devices" : [
        {
          "deviceId" : "12345-6789",
          "platform" : "A",
          "token" : "12345-6789",
          "userId" : "admin",
        },
        ...
      ],
      "pageInfo" : {
        "count" : "2",
        "next" : "",
        "previous" : "",
        "totalCount" : "10",
      },
    }
    {% endhighlight %}

                <h5>Response Properties</h5>
                <p>The response has the following properties:</p>
                            
                <ul>
                    <li><b>devices:</b> The array of device registrations with Push.</li>
                    <li><b>pageInfo:</b> The pagination information.</li>
                </ul>

                <p><code>devices</code> has the following properties:</p>

                <ul>
                    <li><b>deviceId:</b> The unique id of the device.</li>
                    <li><b>platform:</b> The device platform.</li>
                    <li><b>token:</b> The unique push token of the device.</li>
                    <li><b>userId:</b> The <code>userId</code> of the device.</li>                    
                </ul>

                <p><code>pageInfo</code> has the following properties:</p>

                <ul>
                    <li><b>count:</b> The number of device registration that are retrieved.</li>
                    <li><b>next:</b> A hyperlink to the next page.</li>
                    <li><b>previous:</b> A hyperlink to the previous page.</li>
                    <li><b>totalCount:</b> The total number of device registration present for the given search criteria.</li>
                </ul>
                
                <h5>Errors:</h5>
                <ul>
                    <li><b>401:</b> Unauthorized - The caller is either not authenticated or not authorized to make this request.</li>
                    <li><b>404:</b> A device registration with the specified deviceId is not found.</li>
                    <li><b>500:</b> An internal error occurred.</li>
                </ul>
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-subscription-get" data-target="#collapse-device-subscription-get" aria-expanded="false" aria-controls="collapse-device-subscription-get"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
</div>