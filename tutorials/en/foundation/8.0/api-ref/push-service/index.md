---
layout: api-ref-rest-api
title: REST API for MobileFirst Server Push Service
breadcrumb_title: Push Service
relevantTo: [ios,android,windows,javascript]
weight: 3
apis:
- name: Push Device Registration (DELETE)
  description: The device registrations of push service is deleted for the given <code>deviceId</code>. The call returns HTTP response code 204 with no content on successful deletion of the device registration.
  shortdesc: Deletes (un-registers) an existing device registration from the push service.
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
  shortdesc: Retrieves an existing device registration of push.
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
  response: The details of the device registration that is retrieved.
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
  shortdesc: Creates a device registration with the push service.
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
  response: The details of the device registration that is retrieved.
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
- name: Push Device Registration (PUT)
  description: The push device registration is updated with the new user ID or the token specified. In most use cases this call is used to update the userId only.
  shortdesc: Updates an existing device registration with the push service.
  method: PUT
  path: /apps/applicationId/devices/deviceId
  example: https://example.com:443/imfpush/v1/apps/myapp/devices/12345-6789
  pathParams:
      - name: deviceId
        value: The device identifier
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
      - name: Content-Type
        value: (Mandatory) Specify the JSON content type. For example application/json.
  consumes: application/json
  produces: application/json
  payload: The details the device registration will be updated with.
  payloadJsonExample: | 
    {
        "deviceId" : "12345-6789",
        "phoneNumber" : "123456789",
        "token" : "xyz",
        "userId" : "admin"
    } 
  payloadProperties:
      - name: deviceId
        value: Unique ID of the device.
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
      "userId" : "admin"
    }
  responseProperties:
      - name: createdMode
        value: The mode of creation.
      - name: createdTime
        value: The date and time when the push device registration was created on the server in ISO 8601 format.
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
      - name: userId
        value: The <code>userId</code> of the device.
  errors:
    - name: 400
      value: Bad Request - The request was not understood by the push server. An invalid JSON could result in this error code.
    - name: 401
      value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
    - name: 404
      value: A device registration with the specified deviceId is not found.
    - name: 405
      value: Unsupported Content type - The content type specified in Content-Type header is not application/json.
    - name: 406
      value: Unsupported Accept type - The content type specified in Accept header is not application/json.
    - name: 500
      value: An internal error occurred.    
- name: Push Device registrations (GET)
  description: Device registrations for the push service are retrieved for the specified criteria.
  shortdesc: Retrieves all or a subset of existing device registration(s).
  method: GET
  path: /apps/applicationId/devices
  example: https://example.com:443/imfpush/v1/apps/myapp/devices?expand=true&filter=platform==A&offset=0&size=10&userId=admin
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
      - name: userId
        value: retrieves device registrations only for the specified user.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the device registration that is retrieved.
  responseJsonExample: |
    {
        "devices" : [
        {
            "deviceId" : "12345-6789",
            "phoneNumber" : "123456789",
            "platform" : "A",
            "token" : "xyz",
            "userId" : "admin"
        },
        ...
        ],
        "pageInfo" : {
            "count" : "2",
            "next" : "",
            "previous" : "",
            "totalCount" : "10"
        }
    }
  responseProperties:
      - name: devices
        value: The array of device registrations with Push.
      - name: pageInfo
        value: The pagination information.
      - name: deviceId
        value: The unique ID of the device.
      - name: phoneNumber
        value: Phone number to be used for SMS based notification.
      - name: platform
        value: The device platform.
      - name: token
        value: The unique push token of the device.
      - name: userId
        value: The <code>userId</code> of the device.
      - name: count
        value: The number of device registration that are retrieved.
      - name: next
        value: A hyperlink to the next page.
      - name: previous
        value: A hyperlink to the previous page.
      - name: totalCount
        value: The total number of device registration present for the given search criteria.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Device Subscription (DELETE)
  description: Using the <code>subscriptionId</code> it unsubscribes the tag from the device. The call would not delete the device registration or the tag.
  shortdesc: Delete subscription by <code>subscriptionId</code>.
  method: DELETE
  path: /apps/applicationId/subscriptions/subscriptionId
  example: https://example.com:443/imfpush/v1/apps/myapp/subscriptions/mysubscription
  pathParams:
      - name: applicationId
        value: The name or identifier of the application
      - name: subscriptionId
        value: The identifier of the subscription.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A device registration with the specified deviceId is not found.
      - name: 500
        value: An internal error occurred.
- name: Push Device Subscription (GET)
  description: The subscription referenced by the subscriptionId is retrieved.
  shortdesc: Retrieves an existing subscription.
  method: GET
  path: /apps/applicationId/subscriptions/subscriptionId
  example: https://example.com:443/imfpush/v1/apps/myapp/subscriptions/mysubscription
  pathParams:
      - name: applicationId
        value: The name or identifier of the application
      - name: subscriptionId
        value: The identifier of the subscription.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the device subscription that is retrieved.
  responseJsonExample: |
    {
        "devices" : [
        {
            "deviceId" : "12345-6789",
            "platform" : "A",
            "token" : "12345-6789",
            "userId" : "admin"
        },
        ...
        ],
        "pageInfo" : {
            "count" : "2",
            "next" : "",
            "previous" : "",
            "totalCount" : "10"
        }
    }
  responseProperties:
      - name: devices
        value: The array of device registrations with Push.
      - name: pageInfo
        value: The pagination information.
      - name: deviceId
        value: The unique ID of the device.
      - name: platform
        value: The device platform.
      - name: token
        value: The unique push token of the device.
      - name: userId
        value: The <code>userId</code> of the device.
      - name: count
        value: The number of device registration that are retrieved.
      - name: next
        value: A hyperlink to the next page.
      - name: previous
        value: A hyperlink to the previous page.
      - name: totalCount
        value: The total number of device registration present for the given search criteria.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A device registration with the specified deviceId is not found.
      - name: 500
        value: An internal error occurred.
- name: Push Device Subscription (POST)
  description: Given the <code>deviceId</code> and the tag name, the request creates a new subscription which subscribes the device to the tag specified.
  shortdesc: Creates a new subscription for a tag.
  method: GET
  path: /apps/applicationId/subscriptions
  example: https://example.com:443/imfpush/v1/apps/myapp/subscriptions
  pathParams:
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  consumes: application/json
  produces: application/json
  payload: The details of the device and the tag name to which it has to subscribe.
  payloadJsonExample: |
    {
      "deviceId" : "12345-6789",
      "tagName" : "testTag"
    }
  payloadProperties:
      - name: deviceId
        value: The unique id of the device
      - name: tagName
        value: The tag name to subscribe.
  response: The details of the device subscription that is updated.
  responseJsonExample: |
    {
      "deviceId" : "12345-6789",
      "tagName" : "testTag"
    }
  responseProperties:
      - name: deviceId
        value: The unique id of the device.
      - name: tagName
        value: The tag name to subscribe.
  errors:
      - name: 400
        value: A device registraion has userId longer than 254 characters.
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: A device registration with the specified deviceId is not found.
      - name: 405 
        value: Unsupported Content type - The content type specified in Content-Type header is not application/json.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500 
        value: An internal error occurred.
- name: Push Device Subscriptions (GET)
  description: Retrieves subscriptions for the push service for the specified criteria
  shortdesc: Retrieves all or a subset of existing subscriptions.
  method: GET
  path: /apps/applicationId/subscriptions
  example: https://example.com:443/imfpush/v1/apps/myapp/subscriptions?deviceId=12345-6789&expand=true&filter=tagName=@tag&offset=0&size=10&tagName=sports&userId=user1
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
      - name: tagName
        value: Retrieves subscriptions only for the specified tagName.
      - name: userId
        value: Retrieves device registrations only for the specified user.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the device subscription that is retrieved.
  responseJsonExample: |
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
  responseProperties:
      - name: devices
        value: The array of device registrations with Push.
      - name: pageInfo
        value: The pagination information.
      - name: deviceId
        value: The unique ID of the device.
      - name: platform
        value: The device platform.
      - name: token
        value: The unique push token of the device.
      - name: userId
        value: The <code>userId</code> of the device.
      - name: count
        value: The number of device registration that are retrieved.
      - name: next
        value: A hyperlink to the next page.
      - name: previous
        value: A hyperlink to the previous page.
      - name: totalCount
        value: The total number of device registration present for the given search criteria.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Tag (DELETE)
  description: Delete the tag in the application.
  shortdesc: Delete the tag in the application.
  method: DELETE
  path: /apps/applicationId/tags/tagName
  example: https://example.com:443/imfpush/v1/apps/myapp/tags/sports
  pathParams:
      - name: applicationId
        vlaue: The name or identifier of the application
      - name: tagName
        value: The name of the tag.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: The tag with the specified tagName is not found.
      - name: 500
        value: An internal error occurred.
- name: Push Tag (GET)
  description: Retrieves an existing tag of push.
  shortdesc: Retrieves an existing tag of push.
  method: GET
  path: /apps/applicationId/tags/tagName
  example: https://example.com:443/imfpush/v1/apps/myapp/tags/sports
  pathParams: 
      - name: applicationId
        value: The name or identifier of the application
      - name: tagName
        value: The name of the tag
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the tag that is retrieved.
  responseJsonExample: |
    {
        "createdMode" : "API",
        "createdTime" : "2015-08-22T18:19:58Z",
        "description" : "Description about SampleTag",
        "lastUpdatedTime" : "2015-08-22T18:19:58Z",
        "name" : "SampleTag"
    }
  responseProperties:
      - name: createdMode
        value: Defaults to API.
      - name: createdTime
        value: The time at which the tag was created.
      - name: description
        value: The decription of the tag.
      - name: lastUpdatedTime
        value: The time at which the tag was last updated.
      - name: name
        value: A unique name of the tag in the application.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: The tag with the specified <code>tagName</code> is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Tag (POST)
  description: Creates a tag with the unique name in the application, which is referenced by the <code>applicationId</code> parameter. The tag has associated with a description about the tag. The tag name cannot be updated after it is created.
  shortdesc: Creates a tag.
  method: POST
  path: /apps/applicationId/tags
  example: https://example.com:443/imfpush/v1/apps/myapp/tags
  pathParams:
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>tags.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
      - name: Content-Type
        value: (Mandatory) Specify the JSON content type. For example application/json.
  consumes: application/json
  produces: application/json
  payload: The details of the tag.
  payloadJsonExample: |
    {
        "description" : "Description about SampleTag",
        "name" : "SampleTag",
    }
  payloadProperties:
      - name: description
        value: The description of the tag.
      - name: name
        value: An unique name of the tag in the application.
  response: The details of the tag.
  responseJsonExample: | 
    {
        "createdMode" : "API",
        "createdTime" : "2015-08-22T18:19:58Z",
        "description" : "Description about SampleTag",
        "href" : "https://example.com:443/imfpush/v1/apps/testApp/tags/SampleTag",
        "lastUpdatedTime" : "2015-08-22T18:19:58Z",
        "name" : "SampleTag",
    }
  responseProperties:
      - name: createdMode
        value: Defaults to API.
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
      - name: 400
        value: Bad Request - The request was not understood by the push server. An invalid JSON could result in this error code.
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 405
        value: Unsupported Content type - The content type specified in Content-Type header is not application/json.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Tag (PUT)
  description: Updates the tag referenced by the tagName of the application referenced by the <code>applicationId</code>.
  shortdesc: Updates tag information.
  method: PUT
  path: /apps/applicationId/tags/tagName
  example: https://example.com:443/imfpush/v1/apps/myapp/tags/sports
  pathParams:
      - name: applicationId
        value: The name or identifier of the application.
      - name: tagName
        value: The name of the tag.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US
      - name: Authorization
        value: (Mandatory) The token with the scope <code>tags.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
      - name: Content-Type
        value: (Mandatory) Specify the JSON content type. For example application/json.
  produces: application/json
  payload: The details of the tag.
  payloadJsonExample: | 
    {
        "description" : "Description about SampleTag",
        "name" : "SampleTag",
    }
  payloadProperties:
      - name: description
        value: The description of the tag.
      - name: name
        value: A unique name of the tag in the application.
  response: The details of the tag.
  responseJsonExample: | 
    {
        "createdMode" : "API",
        "createdTime" : "2015-08-22T18:19:58Z",
        "description" : "Description about SampleTag",
        "href" : "https://example.com:443/imfpush/v1/apps/testApp/tags/SampleTag",
        "lastUpdatedTime" : "2015-08-22T18:19:58Z",
        "name" : "SampleTag",
    }
  responseProperties:
      - name: createdMode
        value: Defaults to API.
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
      - name: 400
        value: Bad Request - The request was not understood by the push server. An invalid JSON could result in this error code.
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: The tag with the specified tagName is not found.
      - name: 405
        value: Unsupported Content type - The content type specified in Content-Type header is not application/json.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Tags (GET)
  description: Retrieves all tags of push.
  shortdesc: Retrieves all tags of push.
  method: GET
  path: /apps/applicationId/tags
  example: https://example.com:443/imfpush/v1/apps/myapp/tags?expand=true&filter=platform==A&offset=0&size=10&subscriptionCount=10
  pathParams:
      - name: applicationId
        value: The name or identifier of the application.
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
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
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
            "name" : "SampleTag",
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
        value: Defaults to API.
      - name: createdTime
        value: The time at which the tag was created.
      - name: description
        value: The decription of the tag.
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
- name: Push Message (DELETE)
  description: Deletes the message details by <code>messageId</code>.
  shortdesc: Deletes the message details by <code>messageId</code>.
  method: DELETE
  path: /apps/applicationId/messages/messageId
  example: https://example.com:443/imfpush/v1/apps/myapp/messages/mymessage
  pathParams:
      - name: applicationId
        value: The name or identifier of the application.
      - name: messageId
        value: The identifier of the message.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: The message with the specified messageId is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Message (GET)
  description: Retrieves the message details by <code>messageId</code>.
  shortdesc: Retrieves the message details by <code>messageId</code>.
  method: GET
  path: /apps/applicationId/messages/messageId
  example: https://example.com:443/imfpush/v1/apps/myapp/messages/mymessage
  pathParams:
      - name: applicationId
        value: The name or identifier of the application.
      - name: messageId
        value: The identifier of the message.
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  produces: application/json
  response: The details of the message that is retrieved.
  responseJsonExample: | 
    {
        "alert" : "TestMessage",
        "messageId" : "1234",
    }
  responseProperties:
      - name: alert
        value: The message text.
      - name: messageId
        value: The unique identifier of the message.
  errors:
      - name: 401
        value: Unauthorized - The caller is either not authenticated or not authorized to make this request.
      - name: 404
        value: The message with the specified <code>messageId</code> is not found.
      - name: 406
        value: Unsupported Accept type - The content type specified in Accept header is not application/json.
      - name: 500
        value: An internal error occurred.
- name: Push Message (POST)
  description: Sends a push notifications to the specified targets and returns HTTP return code 202 when the request to send the message is accepted.
  shortdesc: Send message with different options.
  method: POST
  path: /apps/applicationId/messages
  example: https://example.com:443/imfpush/v1/apps/myapp/message
  pathParams:
      - name: applicationId
        value: The name or identifier of the application
  headerParams:
      - name: Accept-Language
        value: (Optional) The preferred language to use for error messages. Defaults to en-US.
      - name: Authorization
        value: (Mandatory) The token with the scope <code>devices.write</code> and <code>push.application.<applicationId></code> obtained using the confidential client in the format Bearer token. 
  consumes: application/json
  produces: application/json
  payload: The payload in JSON format has values for message, target, and settings.
  payloadJsonExample: |
    {
        "message" : {
          "alert" : "Test message",
        },
        "notificationType" : 1,
        "settings" : {
          "apns" : {
            "badge" : 1,
            "category" : 1,
            "iosActionKey" : "Ok",
            "payload" : {"custom":"data"},
            "sound" : "song.mp3",
            "type" : "SILENT",
          },
          "gcm" : {
            "bridge" : false,
            "category" : "email",
            "collapseKey" : "testkey",
            "delayWhileIdle" : false,
            "payload" : {"custom":"data"},
            "priority" : "low",
            "redact" : "Test Redact Message",
            "sound" : "song.mp3",
            "sync" : false,
            "timeToLive" : 10,
            "visibility" : "public",
          },
          "wns" : {
            "badge" : {"value":"10"},
            "cachePolicy" : false,
            "expirationTime" : 20,
            "raw" : {"payload":{"custom":"data"}},
            "tile" : {"visual":{"binding":[{"template":"TileSquareText04", "text": [{"content":"Text1"}]}, {"template":"TileWideText04","text": [{"content":"Text1"}]}]}},
            "toast" : {"launch":{"custom":"data"}, "visual":{"binding":{"template":"ToastText04","text":[{"content":"Text1"},{"content":"Text2"},{"content":"Text3"}]}},
          },
        },
        "target" : {
          "deviceIds" : [ "MyDeviceId1", ... ],
          "platforms" : [ "A,G", ... ],
          "tagNames" : [ "Gold", ... ],
          "userIds" : [ "MyUserId", ... ],
        }
    }
  payloadProperties:
      - name: message
        value: The alert message to be sent
        children:
            - name: alert
              value: A string to be displayed in the alert.
      - name: notificationType
        value: Integer value to indicate the channel (Push/SMS) used to send message. Allowed values are 1 (only Push), 2 (only SMS) and 3 (Push and SMS)
      - name: settings
        value: The settings are the different attributes of the notification.
        children:
            - name: apns
              value: Attributes for sending message to an iOS device.
              children2:
                  - name: badge
                    value: An integer value to be displayed in a badge on the application icon.
                  - name: category
                    value: Name of the category for iOS (8 and above) interactive push notifications.
                  - name: iosActionKey
                    value: The label of the dialog box button that allows the user to open the app upon receiving the notification.
                  - name: payload
                    value: A JSON block that is transferred to the application if the application is opened by the user when the notification is received, or if the application is already open.
                  - name: sound
                    value: The name of a file to play when the notification arrives.
                  - name: type
                    value: Specify the type of APNS notification. It should be either DEFAULT, MIXED or SILENT
            - name: gcm
              value: Attributes for sending message to an Android device.
              children2:
                  - name: bridge
                    value: (GCM) A Boolean value that indicates whether the notification should be bridged or not to other devices connected to this handheld device. Only applies to Android 5.0 or higher.
                  - name: category
                    value: A string value that indicates the category to which this notification belongs. Allowed values are 'call', 'alarm', 'email', 'err', 'event', 'msg', 'progress', 'promo', 'recommendation', 'service', 'social', 'status', and 'transport'. Only applies to Android 5.0 or higher.
                  - name: collapseKey
                    value: A string value that indicates that the message can be replaced. When multiple messages are queued up in GCM Servers with the same key, only the last one is delivered.
                  - name: delayWhileIdle
                    value: A Boolean value that indicates that the message must not be sent if the device is idle. The server waits for the device to become active before the message is sent. Default value is false.
                  - name: payload
                    value: A JSON block that is transferred to the application if the application is opened by the user when the notification is received, or if the application is already open.
                  - name: sound
                    value: The name of a file to play when the notification arrives.
                  - name: priority
                    value: A string value that indicates the priority of this notification. Allowed values are 'max', 'high', 'default', 'low' and 'min'. High/Max priority notifications along with 'sound' field may be used for Heads up notification in Android 5.0 or higher.
                  - name: redact
                    value: A string to be displayed in the alert as a redacted version of the original content when the visibility level is 'private'. Only applies to Android 5.0 or higher.
                  - name: sync
                    value: A Boolean value that indicates whether the notification should be sync'd between devices of the same user, that is, if a notification is handled on a device it gets dismissed on the other devices of the same user.
                  - name: timeToLive
                    value: The duration (in seconds) that the message is kept on GCM storage if the device is offline. Default value is 4 weeks, and must be set as a JSON number.
                  - name: visibility
                    value: A string value that indicates the visibility level of notification content on the secured lock screen in Android L devices. Allowed values are 'public, 'private' and 'secret'. Only applies to Android 5.0 or higher.  
            - name: wns
              value: Attributes for sending message to a windows device.
              children2:
                  - name: target
                    value: Set of targets can be user Ids, devices, platforms, or tags. Only one of the targets can be set.  
                  - name: badge
                    children3:
                        - name: value
                          value: An optional numeric or string value that indicates a prrdefined glyph to be displayed.
                        - name: version
                          value: Optional. Version of the payload.
                  - name: cachePolicy
                    value: A boolean value that indicates if the notification should be cached or not.
                  - name: expirationTime
                    value: Optional. Expriry time of the notification.
                  - name: raw
                    children3:
                        - name: payload
                          value: Optional. A JSON block that is transferred to the application only if the application is already open.
                  - name: tile
                    children3:
                        - name: tag
                          value: Optional. A string value that is set as label for the notification. Used in notification cycling.
                  - name: visual
                    children3:
                        - name: addImageQuery
                          value: Optional. A boolean value that indicates if the query string need to be appended to image URI.
                        - name: baseUri
                          value: Optional. Base URI to be combined with the relative URIs.
                        - name: binding
                          value: For tile notifications, its a JSON array containing JSON blocks of binding attributes. For toast notification, its a JSON block of binding attributes.
                        - name: branding
                          value: Optional. Indicates whether logo or app's name to be shown. Default is None.
                        - name: contentId
                          value: Optional. A string value that identifies the notification content. Only applies to tile notifications.
                        - name: lang
                          value: Optional. Locale of the payload.
                        - name: version
                          value: Optional. Version of the payload
                  - name: binding
                    children3:
                        - name: addImageQuery
                          value: Optional. A boolean value that indicates if the query string need to be appended to image URI.
                        - name: baseUri
                          value: Optional. Base URI to be combined with the relative URIs.
                        - name: branding
                          value: Optional. Indicates whether logo or app's name to be shown. Default is None.
                        - name: contentId
                          value: Optional. A string value that identifies the notification content. Only applies to tile notifications.
                        - name: fallback
                          value: Optional. Template to be used as a fallback.
                        - name: image
                          value: Optional. A JSON array containing JSON blocks of following image attributes.
                        - name: lang
                          value: Optional. Locale of the payload.
                        - name: template
                          value: Mandatory. Template type of the notification.
                        - name: text
                          value: Optional. A JSON array containing JSON blocks of following text attributes.
                  - name: image
                    children3:
                        - name: addImageQuery
                          value: Optional. A boolean value that indicates if the query string need to be appended to image URI.
                        - name: alt
                          value: Optional. Image description.
                        - name: src
                          value: Mandatory. Image URI.
                  - name: text
                    children3:
                        - name: content
                          value: Mandatory. A string value that is displayed in the toast.
                        - name: lang
                          value: Optional. Locale of the payload.
                  - name: toast
                    children3:
                        - name: audio
                        - name: duration
                          value: Optional. Notification will be displayed for the specified duration. Should be 'short' or 'long'.
                        - name: launch
                          value: Optional. A string value that is passed to the application when it is launched by tapping or clicking the toast notification.
                        - name: visual
                  - name: visual
                    children3:
                        - name: loop
                          value: Optional. A boolean value to indicate if the sound should be repeated or not.
                        - name: silent
                          value: Optional. A boolean value to indicate if the sound should be played or not.
                        - name: src
                          value: Optional. A string value that specifies the notification sound type or path to local audio file.
      - name: target
        children:
            - name: deviceIds
              value: An array of the devices represented by the device identifiers. Devices with these ids receive the notification. This is a unicast notificatio
            - name: platforms
              value: An array of device platforms. Devices running on these platforms receive the notification. Supported values are A (Apple/iOS), G (Google/Android) and W (Microsoft/Windows).
            - name: tagNames
              value: An array of tags specified as tagNames. Devices that are subscribed to these tags receive the notification. Use this type of target for tag based notifications
            - name: userIds
              value: An array of users represented by their userIds to send the notification. This is a unicast notification.
  errors:
      - name: 400
        value: Invalid JSON
      - name: 403
        value: The user is not authorized to call this service.
      - name: 404
        value: The corresponding runtime is not found or not running.
      - name: 500
        value: An internal error occurred.
- name: Push Application (DELETE)
- name: Push Application (GET)
- name: Push Application (POST)
- name: Push Application (PUT)
- name: Push Applications (GET)
- name: Push Application Settings (GET)
- name: Push APNS Settings (DELETE)
- name: Push APNS Settings (GET)
- name: Push APNS Settings (POST)
- name: Push GCM Settings (DELETE)
- name: Push GCM Settings (GET)
- name: Push GCM Settings (POST)
- name: Push WNS Settings (DELETE)
- name: Push WNS Settings (GET)
- name: Push WNS Settings (POST)
- name: Push SMS Settings (DELETE)
- name: Push SMS Settings (GET)
- name: Push SMS Settings (PUT)
- name: Push Webhook (DELETE)
- name: Push Webhooks (POST)
- name: Push Webhooks (PUT)
- name: Push Health Checker (GET)
- name: Bulk Push Messages (POST)
---
<br/>
> <span class="glyphicon glyphicon glyphicon-fire" aria-hidden="true"></span> **Note:** This page is under construction. [Click for the existing API Reference](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/topics/r_apiref.html).

## Overview
The REST API for the Push service in the MobileFirst runtime environment enables back-end server applications that were deployed outside of the MobileFirst Server to access Push functions from a REST API endpoint.

The Push service on the MobileFirst Server is exposed over a REST API endpoint that can be directly accessed by non-mobile clients. You can use the REST API runtime services for Push for registrations, subscriptions, messages, and retrieving tags. Paging and filtering is supported for database persistence in both Cloudant and SQL.

These REST API endpoints are protected by OAuth which requires the clients [to be confidential clients](../../authentication-and-security/confidential-clients/) and also possess the required scope(s) in their OAuth access tokens that is passed by a designated HTTP header.

#### Jump to
* [Swagger UI](#swagger-ui)
* [REST Endpoints](#rest-endpoints)

### Swagger UI
The REST endpoints below are also accessible from a Swagger UI in the development environment provided by the [DevKit Installer](../../setting-up-your-development-environment/mobilefirst-development-environment). To access it, load the following URL: [http://localhost:9080/doc/?url=/imfpush/v1/swagger.json](http://localhost:9080/doc/?url=/imfpush/v1/swagger.json).

![Swagger UI for the Push Service REST endpoints](push-service-swagger.png)

### REST Endpoints
