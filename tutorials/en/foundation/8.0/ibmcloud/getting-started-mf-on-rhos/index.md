---
layout: tutorial
breadcrumb_title: Get started with Foundation on OpenShift
title: Get started with Mobile Foundation on an OpenShift cluster
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->


> **NOTE:** This Get Started Trail applies to OpenShift Container Platform installed either as as part of IBM Cloud Pak for Applications or separately outside of it.

* [Introduction](#introduction)
* [Architecture](#architecture)
* [Installing Mobile Foundation](#install-mf)
* [Developing applications](#develop-apps)
* [Deploying applications](#deploying-apps)

## Introduction
IBM Mobile Foundation v8 is now available to install and run on Red Hat Openshift 3.11 or later. Red Hat OpenShift is an enterprise Kubernetes platform designed to address the complex realities of container orchestration in production systems.

As enterprises continue to digitally transform their businesses, PaaS application development environments, including container and microservices architectures, enable enterprises to focus more on creating and improving value-add application features and less on managing underlying operating systems and infrastructure. Red Hat OpenShift is designed to make this easier for Kubernetes environments through automated installation, patching, and upgrades for every layer of the container stack from the operating system through application services.

Mobile Foundation offers an industry-leading secured platform for developers to rapidly build and deploy the next generation of multi channel digital apps, including mobile, wearables, conversation, web, and PWAs.  Accelerate the development and deployment of powerful, engaging digital apps with: -
* Containerized mobile back-end services for OpenShift Container Platform covering comprehensive security, application life cycle management, offline data sync and back-end integration.
* Low-code studio to build digital apps and rich SDKs for widely used mobile frameworks both native and hybrid developers.
* A private App Store to publish your apps for consumption by users
* User engagement by means of  analytics service for application insights, feedback using In-App feedback, Push notifications, Feature Toggle and A/B testing.

## Architecture
{: #architecture}

Image below shows the high level architecture of the Mobile Foundation deployment on Red Hat OpenShift cluster.

![Architecture](architecture-mobile-services-openshift.png)

## Installing Mobile Foundation
{: #install-mf}

To install Mobile Foundation on an existing OpenShift cluster follow the instructions [here](../mobilefoundation-on-openshift).

>**Note:** To install Mobile Foundation on Red Hat OpenShift Container Platform on IBM Cloud, follow the instructions [here](../deploy-mf-on-ibmcloud-ocp).

## Developing Applications
{: #develop-apps}

You can quickly and easily develop Mobile Applications that use Mobile Foundation Lifecycle Management, Security, Engagement and Analytics by using the IBM Digital App Builder (DAB) Tool.  DAB also provides mobile application accelerators for secure connectivity to backend microservices.  

* Build and Test your first Mobile Foundation Application within minutes - [get started with IBM Digital App Builder](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)

## Deploying Applications
{: #deploying-apps}
Every Mobile Foundation Application has two deployables:
* Mobile Client Applications which can be deployed to the Mobile Foundation App Center or any other public App Store
* Mobile Foundation Service Configurations for Application Lifecycle, Security, Push Notifications, LiveUpdate.  These configurations can be exported from Mobile Foundation development enviroment and imported into a Mobile Foundation staging or production environment.  

Refer to the following for more information related to exporting and importing Mobile Foundation Service configurations across deployments:
[Different ways of exporting and importing Mobile Foundation server artifacts](http://mobilefirstplatform.ibmcloud.com/blog/2016/07/25/how-to-replicate-mobilefirst-environment/).
