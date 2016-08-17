---
layout: api-ref-rest-api
title: REST API for MobileFirst Server Push Service
breadcrumb_title: Push Service
relevantTo: [ios,android,windows,javascript]
weight: 3
apis:
- name: Push Device Registration (DELETE)
  description: The device registrations of push service is deleted for the given <code>deviceId</code>. The call returns HTTP response code 204 with no content on successful deletion of the device registration.
  method: DELETE
  path: /apps/applicationId/devices/deviceId
  example: https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789
  pathParams:
      - name: deviceId
        value: The device identifier
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
  produces: application/json
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A device registration with the specified <code>deviceId</code> is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Device Registration (GET)
  description: Retrieves an existing device registration.
  method: GET
  path: /apps/applicationId/devices/deviceId
  example: https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789
  pathParams:
      - name: deviceId
        value: The device identifier
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
  produces: application/json
  reseponse: The details of the device registration that is retrieved.
  responseJsonExample: |
      {
          "createdMode" : "API",
          "createdTime" : "2015-05-20T11:42:11Z",
          "deviceId" : "12345-6789",
          "lastUpdatedTime" : "2015-05-20T11:42:11Z",
          "phoneNumber" : "123456789",
          "platform" : "A",
          "token" : "12345-6789",
          "userId" : "admin"
      }
  responseProperties:
      - name: createdMode
        value: Defaults to <code>API</code>.
      - name: createdTime
        value: The time at which the tag was created.
      - name: deviceId
        value: The unique id of the device.
      - name: lastUpdatedTime
        value: The date and time when the push device registration was last updated on the server in ISO 8601 format.
      - name: phoneNumber
        value: Phone number to be used for SMS based notification.
      - name: platform
        value: The device platform.
      - name: token
        value: The unique push token of the device.
      - name: userId
        value: The <code>userId</code> of the device.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A device registration with the specified <code>deviceId</code> is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Device Registration (POST)
  description: The device registrations happens from the device. The <code>deviceId</code> is the unique ID for the device for the application.
  method: POST
  path: /apps/applicationId/devices
  example: https://example.com:443/imfpush/v1/apps/myapp/devices
  pathParams:
      - name: applicationId
        value: The name or identifier of the application.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
      - name: Content-Type
        value: (Mandatory) Specify the JSON content type. For example application/json.
  consumes: application/json
  produces: application/json
  payload: The details of the device registration.
  payloadJsonExample: |
    {
        "deviceId" : "12345-6789",
        "phoneNumber" : "123456789",
        "platform" : "A",
        "token" : "xyz"
    }
  payloadProperties:
      - name: deviceId
        value: Unique id of the device.
      - name: phoneNumber
        value: Phone number to be used for SMS based notification.
      - name: platform
        value: The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.
      - name: token
        value: Device token obtained via the service provider.
 response: The details of the application.
 responseJsonExample: |
     {
        "createdMode" : "API",
        "createdTime" : "2015-05-20T11:42:11Z",
        "deviceId" : "12345-6789",
        "lastUpdatedTime" : "2015-05-20T11:42:11Z",
        "phoneNumber" : "123456789",
        "platform" : "A",
        "token" : "xyz",
        "userAgent" : "TestUserAgent",
        "userId" : "admin"
     }
 responseProperties:
     - name: createdMode
       value: Defaults to <code>API</code>.
     - name: createdTime
       value: The time at which the tag was created.
     - name: deviceId
       value: The unique id of the device.
     - name: lastUpdatedTime
       value: The date and time when the push device registration was last updated on the server in ISO 8601 format.
     - name: phoneNumber
       value: Phone number to be used for SMS based notification.
     - name: platform
       value: The device platform. The device platform. 'A' refers to Apple(iOS) devices, 'G' refers to Google(Android) and 'W' refers to Microsoft(Windows) devices.
     - name: token
       value: The unique push token of the device.
     - name: userAgent
       value: The user agent for the the device registration
     - name: userId
       value: The <code>userId</code> of the device.  
  errors:
     - name: 400
       value: The request was not understood by the push server. An invalid JSON could result in this error code.
     - name: 401
       value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
     - name: 405
       value: The content type specified in Content-Type header is not application/json.
     - name: 406
       value: Unsupported Accept type - The content type specified in Accept header is not application/json.
     - name: 500
       value: An internal error occurred.
- name: Push Tag (GET)
  description: Retrieves all tags.
  method: GET
  path: /apps/applicationId/tags
  example: https://example.com:443/imfpush/v1/apps/myapp/tags?expand=true&filter=platform==A&offset=0&size=10&subscriptionCount=10
  pathParams: 
      - name: applicationId
        value: The name or identifier of the application
  queryParams:
      - name: expend
        value: Retrieves additional metadata for every device registration that is returned in the response.
      - name: filter
        value: Search criteria filter. Refer to the filter section for detailed syntax.
      - name: offset
        value: Pagination offset that is normally used along with the size.
      - name: size
        value: Pagination size that is normally used along with the offset to retrieve a subset.
      - name: subscriptionCount
        value: Retrieves the number of tag subscriptions.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the tag that is retrieved.
  responseJsonExample: |
      {
        "pageInfo" : {
          "count" : "2",
          "next" : "",
          "previous" : "",
          "totalCount" : "10",
        },
        "tags" : [
          {
            "createdMode" : "API",
            "createdTime" : "2015-08-22T18:19:58Z",
            "description" : "Description about SampleTag",
            "href" : "https://example.com:443/imfpush/v1/apps/testApp/tags/SampleTag",
            "lastUpdatedTime" : "2015-08-22T18:19:58Z",
            "name" : "SampleTag"
          },
          ...
        ]
      }
  responseProperties:
      - name: pageInfo
        value: The pagination information.
      - name: tags
        value: The array of applications.
      - name: count
        value: The number of device registration that are retrieved.
      - name: next
        value: A hyperlink to the next page.
      - name: previous
        value: A hyperlink to the previous page.
      - name: totalCount
        value: The total number of device registration present for the given search criteria.
      - name: createdMode
        value: Defaults to <code>API</code>.
      - name: createdTime
        value: The time at which the tag was created.
      - name: description
        value: The description of the tag.
      - name: href
        value: The URL to the tag.
      - name: lastUpdatedTime
        value: The time at which the tag was last updated.
      - name: name
        value: A unique name of the tag in the application.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A tag with the specified name is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
---

## Overview
The REST API for the Push service in the MobileFirst runtime environment enables back-end server applications that were deployed outside of the MobileFirst Server to access Push functions from a REST API endpoint.

The Push service on the MobileFirst Server is exposed over a REST API endpoint that can be directly accessed by non-mobile clients. You can use the REST API runtime services for Push for registrations, subscriptions, messages, and retrieving tags. Paging and filtering is supported for database persistence in both Cloudant and SQL.

This REST API endpoint is protected by OAuth which requires the clients [to be confidential clients]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/confidential-clients/) and also possess the required access scopes in their OAuth access tokens that is passed by a designated HTTP header.
