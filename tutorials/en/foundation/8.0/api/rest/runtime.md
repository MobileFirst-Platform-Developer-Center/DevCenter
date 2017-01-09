---
layout: tutorial
title: REST API for the MobileFirst runtime
breadcrumb_title: Runtime
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
The REST API for the {{ site.data.keys.product_adj }} runtime provides several services for mobile clients and confidential clients to call adapters, obtain access tokens, get Direct Update content, and more. Most of the REST API endpoints are protected by OAuth.

### Testing the REST API for the MobileFirst runtime with Swagger UI
On a development server, you can test the runtime REST API with Swagger UI.  
{{ site.data.keys.product_adj }} exposes the runtime REST API at the /doc endpoint: http(s)://server_ip:server_port/context_root/doc.

## API Reference
<iframe width="100%" height="1000px" frameBorder="0" src="../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/overview.html"></iframe>

<!--#### [Read Adapter Swagger Doc (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getAdapterDocUsingGET.html)
Return the adapter's swagger documentation for the named adapter
#### [adapterServing (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingGET.html)
#### [adapterServing (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingPOST.html)
#### [adapterServing (PUT)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingPUT.html)
#### [adapterServing (DELETE)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingDELETE.html)
#### [adapterServing (OPTIONS)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingOPTIONS.html)
#### [adapterServing (PATCH)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/adapterServingUsingPATCH.html)
#### [Authorize (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/authorizeUsingGET_1.html)
Authorize the client for a given scope
#### [redirect (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/redirectUsingGET.html)
#### [Introspect (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/introspectUsingPOST_1.html)
Introspect the client on a given token
#### [Get token (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getTokenUsingPOST_1.html)
Generate a token for a given client
#### [webClientLogProfile (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getClientLogProfileUsingGET_2.html)
Send web client log profile
#### [clientLogProfile (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getClientLogProfileUsingGET_1.html)
Send client log profile
#### [directupdate (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getDirectUpdateZipUsingGET.html)
Send direct getDirectUpdateZip to the client
#### [loguploader (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/logUploaderUsingPOST_1.html)
Upload client logs to server
#### [heartbeat (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/heartBeatUsingPOST_1.html)
Accept heartbeat from the client and note the last activity time
#### [logout (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/logoutUsingPOST_1.html)
Logout from the given security check
#### [Pre-Authorization (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/authorizeUsingPOST_1.html)
Secure the given scope for the given client
#### [reach (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/reachUsingGET.html)
#### [Get client public data (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getClientUsingGET_1.html)
Get public client data by ID. Protected by <b>clients:read</b> scope
#### [Update client (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/updateClientUsingPOST.html)
Update client registration data. Protected by <b>clients:modify</b> scope
#### [Delete client (DELETE)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/deleteClientUsingDELETE_1.html)
Delete client registration data. Protected by <b>clients:delete</b> scope
#### [Get client protected data (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getClientProtectedUsingGET.html)
Get protected client data by ID. Protected by <b>clients:read-protected</b> scope
#### [Client self registration (POST)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/selfRegistrationUsingPOST_1.html)
Create a new client, the client ID is returned in the Location header. Protected by app authenticity security check
#### [Get client public data (GET)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/getClientUsingGET_3.html)
Get public client data by ID. Protected by <b>JWT Client assertion</b>
#### [Client self re-registration (PUT)](../../api-ref/rest-api-docs/html/refrest-mfp-server-runtime/html/updateSelfRegistrationUsingPUT_1.html)
Submit new registration data for the existing client ID. Protected by app authenticity security check-->