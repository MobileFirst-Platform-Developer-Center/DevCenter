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
                
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#device-registration-get" data-target="#collapse-device-registration-get" aria-expanded="false" aria-controls="collapse-device-registration-get"><b>Close section</b></a>
            </div>
        </div>
    </div>
    
</div>