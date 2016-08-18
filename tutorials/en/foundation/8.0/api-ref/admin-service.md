---
layout: api-ref-rest-api
title: REST API for MobileFirst Server Admin Service
breadcrumb_title: Admin Service
relevantTo: [ios,android,windows,javascript]
weight: 2
apis:
  - name: Adapter (DELETE)
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

### Select a REST endpoint:
Not available.


