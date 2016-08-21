---
layout: api-ref-rest-api
title: REST API for MobileFirst Server Admin Service
breadcrumb_title: Admin Service
relevantTo: [ios,android,windows,javascript]
weight: 2
apis:
  - name: Adapter (DELETE)
    description: Retrieves metadata of a specific adapter.
    shortdesc: Retrieves metadata of a specific adapter.
    roles: 
        - name: mfpadmin
        - name: mfpdeployer
        - name: mfpmonitor
        - name: mfpoperator
    method: GET
    path: /management-apis/2.0/runtimes/runtime-name/adapters/adapter-name
    example: https://www.example.com/mfpadmin/management-apis/2.0/runtimes/myruntime/adapters/myadapter?locale=de_DE
    pathParams:
        - name: runtime-name
          value: The name of the runtime. This is the context root of the runtime web application, without the leading slash.
        - name: adapter-name
          value: The name of the adapter.
    queryParams:
        - name: locale
          value: The locale used for error messages.
    produces: application/json, application/xml, text/xml
    response: The metadata of the specified adapter.
    responseJsonExample: | 
        {
            "deployTime" : "2014-04-13T00:18:36.979Z",
            "displayName" : "MyApplication",
            "link" : "https://www.example.com/mfpadmin/management-apis/2.0/runtimes/{runtime-name}/applications/{app-name}/{app-env}/{app-version}",
            "name" : "SampleAdapter",
            "productVersion" : "8.0",
            "project" : {
                "name" : "myproject",
            },
            "resourceName" : "abc",
            "resourceType" : "APP_DESCRIPTOR",
            "runtimeInfo" : {
                "descriptorXML" : "",
                "resources" : {
                    "basePath" : "/mfp/api/adapters/demoAdapter",
                    "info" : {
                        "description" : "The adapter for bank-end service",
                        "title" : "demoAdapter"
                    },
                    "paths" : {
                    },
                    "swagger" : "2.0"
                }
            }
        }
    responseXmlExample: |
        <?xml version="1.0" encoding="UTF-8"?>
        <adapter
          deployTime="2014-04-13T00:18:36.979Z"
          displayName="MyApplication"
          link="https://www.example.com/mfpadmin/management-apis/2.0/runtimes/{runtime-name}/applications/{app-name}/{app-env}/{app-version}"
          name="SampleAdapter"
          productVersion="8.0"
          resourceName="abc"
          resourceType="APP_DESCRIPTOR">
          <project name="myproject"/>
          <runtimeInfo descriptorXML="">
            <resources
              basePath="/mfp/api/adapters/demoAdapter"
              swagger="2.0">
              <info
                description="The adapter for bank-end service"
                title="demoAdapter"/>
              <paths/>
            </resources>
          </runtimeInfo>
        </adapter>
    responseProperties:
        - name: deployTime
          value: The date in ISO 8601 format when the artifact was deployed.
        - name: displayName
          value: The optional display name of the artifact.
        - name: link
          value: The URL to access detailed information about the deployed artifacts such as application, adapter etc.
        - name: name
          value: The name of the adatper.
        - name: productVersion
          value: The exact product version.
        - name: project
          value: The project the artifact belong to.
          children:
              - name: name
                value: The name of the project, which is the context root of the runtime.
        - name: resourceName
          value: The name of the artifact.
        - name: resourceType
          value: The type of the artifact.
        - name: runtimeInfo
          value: The runtime information of the adapter
          children:
              - name: basePath
                value: The base api path to the adatper
              - name: info
                value: The information about the adapter
                children: 
                    - name: description
                      value: The description of the adapter
                    - name: title
                      value: The title of the adapter
              - name: paths
                value: The adapter methods
              - name: swagger
                value: The Swagger version
    errors:
        - name: 403
          value: The user is not authorized to call this service.
        - name: 404
          value: The corresponding runtime or the adapter is not found.
        - name: 500
          value: An internal error occurred.
  - name: Adapter (GET)
  - name: Adapter (POST)
  - name: Adapters (GET)
  - name: Adapter Configuration (GET)
  - name: Adapter Configuration (PUT)
  - name: Application (GET)
  - name: Application (POST)
  - name: Applications (GET)
  - name: Application Configuration (GET)
  - name: Application Configuration (PUT)
  - name: Application Authenticity (DELETE)
  - name: Application Descriptor (GET)
  - name: Application Environment (GET)
  - name: Application License Configuration (GET)
  - name: Application License Configuration (POST)
  - name: Application Version (DELETE)
  - name: Application Version (GET)
  - name: Confidential Clients (GET)
  - name: Confidential Clients (PUT)
  - name: Create Subscription (POST)
  - name: Create Tag (POST)
  - name: Delete Tag (DELETE)
  - name: Delete APNS Settings (DELETE)
  - name: Delete GCM Settings (DELETE)
  - name: Delete WNS Settings (DELETE)
  - name: Delete Message (DELETE)
  - name: Delete Subscription (DELETE)
  - name: Deploy (POST)
  - name: Deploy Application Authenticity Data (POST)
  - name: Deploy a Web Resource (POST)
  - name: Device Application Status (PUT)
  - name: Device Status (PUT)
  - name: Device (DELETE)
  - name: Devices (GET)
  - name: Diagnostic Service (GET)
  - name: Export Adapter Resources (GET)
  - name: Export Adapters (GET)
  - name: Export Application Environment (GET)
  - name: Export Application Environment Settings (GET)
  - name: Export Application Resources (GET)
  - name: Export Applications (GET)
  - name: Export Resources (GET)
  - name: Export Runtime Resources (GET)
  - name: Farm Topology Members (GET)
  - name: Farm Topology Members (DELETE)
  - name: Get Message (GET)
  - name: Get Tags (GET)
  - name: Get APNS Settings (GET)
  - name: Get GCM Settings (GET)
  - name: Get WNS Settings (GET)
  - name: Global Configuration (GET)
  - name: Keystore (DELETE)
  - name: Keystore (GET)
  - name: Keystore (POST)
  - name: License Configuration (DELETE)
  - name: Push Device Regisration (DELETE)
  - name: Push Device Regisration (GET)
  - name: Push Device Subscription (GET)
  - name: Register Application With Push Service (POST)
  - name: Remove Subscription (DELETE)
  - name: Retrieve Device Regisration (GET)
  - name: Retrieve Tag (GET)
  - name: Retrieve Web Resource (GET)
  - name: Retrieve Subscription to Push Service (GET)
  - name: Runtime Configuration (GET)
  - name: Runtime Configuration (PUT)
  - name: Runtime (DELETE)
  - name: Runtime (GET)
  - name: Runtime Lock (DELETE)
  - name: Runtime Lock (GET)
  - name: Runtimes (GET)
  - name: Send Bulk Messages (POST)
  - name: Send Message (POST)
  - name: Transaction (GET)
  - name: Transactions (GET)
  - name: Update Device Regisration (PUT)
  - name: Update APNS Settings (PUT)
  - name: Update GCM Settings (PUT)
  - name: Update WNS Settings (PUT)
  - name: Update Tag Settings (PUT)
---
<br/>
> <span class="glyphicon glyphicon glyphicon-fire" aria-hidden="true"></span> **Note:** This page is under construction. [Click for the existing API Reference](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/topics/r_apiref.html).

## Overview
The REST API for the Admin service provides several services to administer runtime adapters, applications, devices, audit, transactions, security, and push notifications.

The REST service API for adapters and applications for each runtime is in `/management-apis/2.0/runtimes/runtime-name/`, where **runtime-name** is the name of the runtime that is administered through the REST service. Then, the type of object addressed by the service is identified, together with the appropriate method. For example, `/management-apis/2.0/runtimes/runtime-name/Adapters (POST)` refers to the service for deploying an adapter.

### REST Endpoints



