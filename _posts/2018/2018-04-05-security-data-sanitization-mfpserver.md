---
title: Security and data sanitization in MobileFirst Server for loguploader endpoint
date: 2018-04-05
tags:
- Mobile_Analytics
- Analytics
- Loguploader
version:
- 8.0
author:
  name: Krishna K Chandrasekar
---
Endpoint `/mfp/api/loguploader` accepts unauthenticated requests and payload. Though the endpoint accepts the entire request at once, the payload is processed at multiple levels to ensure that it meets the data format and sanity checks required by the analytics server. Failing the sanity checks results in the request not being sent to the analytics service.

Processing of incoming request happens at multiple levels, of which the two high levels stages are:
- processing that happens within Analytics SDK on MobileFirst Server, this processed data is sent to Analytics via the analytics-service/rest endpoint.
- processing that happens within the analytics server component.

Consider the following scenarios which elaborates on the data sanitization process:

**Logdata sent as payload POSTed to endpoint contains the malicious URL/scripts**

- When the data is sent to analytics server it will be displayed in charts and tables.
- Though the malicious link (or script) is part of the message/stack trace/any data that is sent to analytics server, the server handles the data in an encoded manner and the data is stored with the proper encoding.
- When the same messages are displayed in the analytics console it is no longer a hyperlink, an executable or an invokable script.
- Analytics server stores the data as plain text and it will be displayed as a simple message (irrespective of the format in which the intruder has sent it)

**Payload POSTed to the loguploader endpoint with trackingId modified with intruder's data**

- MobileFirst Server accepts the payload even though the `trackingId` has some malicious information
- But before sending it to analytics server the data is processed.
- Analytics SDK Component on the server returns the following error in response:
  ```
  ResponseCode : 400  - Invalid Tracking ID results in a message returned by Analytics component "Can not construct instance of java.util.UUID from String value 'someJunkTrackingID': not a valid textual representation, problem: UUID has to be represented by the standard 36-char representation"
  ```
- This error enforces that the `trackingId` has to be a complying UUID
- If the intruder substitues the `trackingId` wrongly with that of his own, the system while processing will fail to correlate them when it is assembled at the analytics server before storing it to the Analytics Data Store (Elasticsearch store).

The scenarios above explain how analytics server handles the data before rendering or storing. Also, if the logdata POSTed to MobileFirst Server (via loguploader) has any intrusion data, it is going to sanitize the data at multiple levels before storing/rendering it on analytics.
