---
layout: tutorial
title: Evaluate IBM MobileFirst Platform Foundation on IBM Containers
breadcrumb_title: Evaluate
relevantTo: [ios,android,windows,cordova]
---
## Overview
This tutorial goes through the steps that you must follow to evaluate running IBM MobileFirst Platform Foundation on IBM Containers: You register an account at the Bluemix website, you create an IBM Container that contains a preconfigured, self-contained, MobileFirst Platform Foundation "Getting Started" image, you set up this image, and finally you download a sample mobile application and run it with the MobileFirst Server instance that runs inside the Container service on Bluemix.

**Prerequisites:** First make sure that you read the [Introduction to IBM MobileFirst Platform Foundation on IBM Containers](../) tutorial.

#### Jump to:

* [Registering an account on Bluemix](#registering-an-account-on-bluemix)
* [Creating an IBM Container](#creating-an-ibm-container)
* [Foundation on IBM Containers Overview page](#foundation-on-ibm-containers-overview-page)

## Registering an account on Bluemix
If you do not have an account yet, visit the [Bluemix website](http://www.bluemix.net) and click **Get Started Free** or **Sign Up** button. You must first fill out a registration form before you can move to the next step.

![Image of the Bluemix sign up page](bluemix-sign-up.png)

After signing in to Bluemix, you are presented with the Bluemix Dashboard which provides an overview of the active Bluemix **space**. This is a work area which by default receives the name "dev". You can create multiple work areas/spaces if needed.

The next step is to add an **IBM Container** in the Bluemix space.

## Creating an IBM Container

* In the Bluemix Dashboard, click **Start Containers**.

![Image of creating an IBM Container](bluemix-create-container.png)

* In the screen that display, select the **IBM MobileFirst Platform Foundation Getting Started** image.
    
![Image of selecting the Foundation image for the IBM Container](select_the_image.png)

* Provide a name for the container.
* Select **Container size (memory: "Medium")**, request a public IP address, assign public ports (80, 9080).
* Click **Create** to create the container.

![Image of image details for the IBM Container](image_details.png)

The Container page is then loaded.  
**Note:** After the page is loaded, the Container might be still in "building" stage.

To access the container, use the IP address that you have previously binded to it.  
If you haven't done so, you can still do it from the **Public IP address** drop-down menu.

The address to use is: `http(s)://binded-IP-address`.  
Before you can access the container, you first go through a one-time registration page. After you have registered, the Overview page displays.

![Image of the IBM Container page](containerpage.png)

## Foundation on IBM Containers Overview page
Use one of the sample applications to reach the final step of the evaluation: connecting an app to a MobileFirst Server instance that runs on top of Bluemix.

The landing page also provides links to various documentation resources.

![Image of the Overview page](overview-page.png)

Visit the [IBM MobileFirst Platform Foundation on IBM Containers sample app](../sample-app/) tutorial for instructions and downloading, setting up, and runnning the sample application.
