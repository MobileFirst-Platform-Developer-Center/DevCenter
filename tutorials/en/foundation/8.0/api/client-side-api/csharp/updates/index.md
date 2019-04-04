---
layout: tutorial
title: Updates to C# client-side API Reference
breadcrumb_title: Updates
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>

## C Sharp
{: #c-sharp }
### API updates for native Windows 10 UWP and Windows 8 Universal applications.

1.  API **WorklightAccessToken** has been introduced.

    <blockquote>
    <h2>2.12 WorklightAccessToken Class</h2> <br/>
            2.12.1 Method Value<br/>
            2.12.2 Method AuthorizationRequestHeader<br/>
            2.12.3 Method FormEncodedBodyParameter<br/>
            2.12.4 Method FailResponse

            <h3>WorklightAccessToken Class</h3><br/>
            <i>syntax</i><br/>
            public class WorklightaccessToken<br/>

    <br/>
            <i>Description</i> <br/>
            This class exposes methods that helps you to get information about the accesstoken received from the MobileFirst server.<br/>

    <br/>
            2.12.1 <b>Method Value</b><br/>

    <br/>
            <i>syntax</i><br/>
            string Value {get;}<br/>
    <br/>

            <i>Description</i> <br/>
            Returns the access token value.<br/>
    <br/>

            2.12.3 <b>Method AuthorizationRequestHeader</b><br/>
    <br/>

            <i>syntax</i><br/>
            public string AuthorizationRequestHeader { get;}<br/>

    <br/>
            <i>Description</i><br/>
            Value used when sending the access token in the authorization request header.<br/>
    <br/>

            2.12.3 <b>Method FormEncodedBodyParameter</b><br/>
    <br/>

            <i>syntax</i> <br/>
            public string FormEncodedBodyParameter { get;}<br/>

    <br/>
            <i>Description</i><br/>
            Value used when sending the access token in the HTTP request entity-body.<br/>

    <br/>
            2.12.4 <b>Method FailResponse</b><br/>
    <br/>

            <i>syntax</i><br/>
            public WorklightResponse FailResponse { get; } <br/>
    <br/>

            <i>Description</i><br/>
            Returns the failure response when the access token cannot be obtained. This value is null if the access token is obtained successfully.<br/><br/>
    </blockquote>
