---
layout: labs
title: MobileFirst Foundation 8.0 Developer Labs
tabs:
  - name: Lab selection
    path: /labs/developers/8.0/intro/
  - name: Advanced Car Service
    path: /labs/developers/8.0/advancedcarservice
  - name: Advanced Utility Service
    path: /labs/developers/8.0/advancedutilityservice
  - name: Advanced Messenger
    path: /labs/developers/8.0/advancedmessenger
  - name: Advanced Wallet
    path: /labs/developers/8.0/advancedwallet
---

![lab session for 8.0](../advancedutilityservice/screenstory.png)

## Lab Highlights
* Using Ionic v1 for hybrid development
* Develop using the mfpdev CLI with Foundation on Bluemix Service
* Securing backend APIs with user authentication
* Using Cloudant to store and retrieve work orders
* Using Weather Company Data and APIs to get relevant weather alerts
* Using Watson Speech to Text service to quickly fill out a form

## Setup and Quick Start
This lab assumes that you are familiar at this point with developing hybrid mobile applications with Mobile Foundation and using Bluemix services. You will need a Bluemix account and an environment suitable for using Mobile Foundation. To get up and running quickly, please check out the [Quick Start Lab](https://github.com/MobileFirst-Platform-Developer-Center/UtilitiesDemoApp/blob/release80/labs/0.%20Quick%20Start.md) that will set up all the services and application for you with a simple script.

## Overview
In this lab, we will be taking on the role of a Utilities Company that sends out field engineers to inspect and repair utility equipment, such as power lines or [backflow preventers](https://en.wikipedia.org/wiki/Backflow_prevention_device). We want to build a mobile application that will allow the field engineers to quickly find their next scheduled work item, warn them if there is inclement weather at the location, and allow them to easily fill in the report form using voice services. The application needs to work for both iOS and Android.

We will be utilizing the Bluemix services:

* {{ site.data.keys.product }}
* Cloudant - to store work items
* Weather Company Data - to check the weather at work locations
* Watson Speech to Text - to securely transcribe an audio file with Watson services

## Lab Steps
Head over to the [lab's GitHub repository](https://github.com/MobileFirst-Platform-Developer-Center/UtilitiesDemoApp) to see the labs mentioned below.

| #  | Lab      | Description |
|----|----------|-------------|
| 1  | MobileFirst Adapters | Intro to using MobileFirst adapters|
| 2  | Cloudant | How to use Cloudant to persist our data |
| 3  | Weather Company Data | How to use the Weather Company Data in an adapter |
| 4  | MobileFirst Security | Using security with MobileFirst |
| 5  | Watson Speech To Text | How to use the Watson Speech to Text service |
{: .table-striped }
