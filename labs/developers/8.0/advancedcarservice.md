---
layout: labs
title: MobileFirst Foundation 8.0 Developer Labs
tabs:
  - name: Lab selection
    path: /labs/developers/8.0/intro
  - name: Advanced Car Service
    path: /labs/developers/8.0/advancedcarservice
  - name: Advanced Messenger
    path: /labs/developers/8.0/advancedmessenger
  - name: Advanced Wallet
    path: /labs/developers/8.0/advancedwallet
---

![lab session for 8.0](../advancedcarservice/screenstory.png)
    
## Lab Highlights
* Hybrid, Ionic 1 based
* Development using CLI with Foundation on Bluemix
* User Authentication
* NodeJS to Mock onPrem CRM
* MessageHub for latency to process requests on a large scale
* DashDB to cache data to lessen the load on the CRM
* SecureGateway to tunnel through firewall to use onPrem CRM

## Pre-requisites and Setup
Please follow the instructions found in the [Setup Mobile Foundation on Bluemix](https://github.com/MobileFirst-Platform-Developer-Center/MotoCorpService/tree/release80/Lab) lab.

## Overview
In this lab, imagine you are an Enterprise that owns car service centers utlizing an on-premise CRM. You want to equip service center employees with iPhones, and build an app that will help them coordinate activities in the service center to improve service times and quality of service across potentialy tens of thousands of locations.

One important element in this solution it is to allow your employees to have access to the most accurate data about your customer, as a customer can engage with your Enterprise via multiple channels.

So through this example we will explore a possible architecture that would allow an Enterprise that already has an OnPrem CRM solution, to expose the CRM data to a mobile app for its Service Centers employees, so they can deliver better customer service.

We will be utilizing the Bluemix services:

* MobileFirst Foundation
* DashDB
* MessageHub
* SecureGateway

![scenario diagram](../advancedcarservice/diagram.png)

In this lab we will cover how to implement the solution above asynchronously. The mobile app will be reading from a cached data repository (DashDB) which will be updated as frequently as possibly. The mobile app will also be writing (creating new customers/visits) via a messaging system (MessageHub). This allows the CRM to consume updates in a more controlled flow, mitigating the peaks and valleys of a service center working day. So if needed, more resources can be added to the CRM to support more load throughout the day, to keep data updated with less latency.
    
### Write
* User creates a new visit in the mobile app (Mobile App)
* Login adapter validates that the OAuth token for that user is valid (Login Adapter)
* Customer Adapter is the main adapter for requests and forwards it to the MessageHub Adapter (Customer Adapter)
* MessageHub Adapter creates a new visit (topic) request to MessageHub (MessageHub Adapter)
* MessageHub Adapter creates a new visit (topic) request to MessageHub (MessageHub Adapter)
* MessageHub creates a new visit topic (MessageHub)
* MessageHub Consumer subscribes to the visit topic and receives the new visit topic and updates the CRM (MessageHub Consumer)
* SecureGateway creates a tunnel through the firewall so that the consumer can reach the onPrem CRM (SecureGateway)
* The OnPrem CRM receives the new visit and replicates the new visit to DashDB (DashDB)

### Read
* User requests to view information on a specific visit (Mobile App)
* Login adapter validates that the OAuth token for that user is valid (Login Adapter)
* Customer adapter forwards that request to the DashDB Adapter (Customer Adapter)
* DashDB adapter queries DashDB for that specific visit (DashDB Adapter)
* DashDB runs the query and returns the result back to the DashDB Adapter (DashDB)

## Lab Steps
Head over to the [lab's GitHub repository](https://github.com/MobileFirst-Platform-Developer-Center/MotoCorpService/tree/release80/Lab) to see the labs mentioned below.

| #  | Lab      | Description |
|----|----------|-------------|
| 1  | Overview | This lab goes into detail about the data flow, how backend services are used, and what scenarios were considered.|
| 2  | Setup Mobile Foundation on Bluemix | This lab shows how to setup and configure a MobileFirst Foundation service on Bluemix. |
| 3  | Security Implementation Login | This lab talks about how easy it is to integrate OAuth2 Security into your app. |
| 4  | MessageHub Adapter | This lab talks about how to setup a MessageHub instance on Bluemix and create an MFP adapter to create topics and send topics to MessageHub. |
| 5  | DashDB Adapter | This lab shows how to instantiate a DashDB service and use an MFP adapter to read data from a customers and visits table. |
| 6  | NodeJS CRM OnPrem | This lab shows how to get the mock onPrem CRM running. |
| 7  | NodeJS CRM OnPrem | This lab shows how to configure SecureGateway with your onPrem CRM to tunnel through a firewall. |
| 8  | Java MessageHub Consumer | This lab shows how to create a Java runtime app on Bluemix to subscribe to topics. |
| 9  | Customer Adapter | This lab shows how to mashup adapters so that any changes to resouces can be managed on the server side |
| 10 | Ionic Mobile App | This lab shows how to integrate the Ionic App with the MFP Adapters. |
| 11 | Bluemix Mobile Analytics | This lab shows how to to use the Bluemix Mobile Analytics service to monitor the data for your business needs. |
{: .table-striped }
