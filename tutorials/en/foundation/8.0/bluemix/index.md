---
layout: tutorial
breadcrumb_title: Foundation on Bluemix
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{{ site.data.keys.product_full }} can be hosted on Bluemix. Following is some basic information about Bluemix.

IBM Bluemix is an implementation of IBM's Open Cloud Architecture. It leverages Cloud Foundry to enable developers to rapidly build, deploy, and manage their cloud applications, while tapping a growing ecosystem of available services and runtime frameworks.

> Learn more about the Bluemix architecture and Bluemix concepts [on the Bluemix website](https://www.ng.bluemix.net/docs/overview/overview.html).

### How does it work?
In a nutshell, there are two ways to run {{ site.data.keys.product }} on Bluemix, depending on the type of license entitlement. 

* Bluemix subscription or PayGo license: {{ site.data.keys.mf_bm_full }} service 
* On Prem license: Use IBM provided scripts to set up an instance of {{ site.data.keys.product_full }} on IBM Containers or Liberty for Java runtime. 

To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.

To run {{ site.data.keys.product}} on a Bluemix Liberty for Java runtime, the following components are used: an **Cloudfoundry app** that contains a **WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. 
### IBM Containers
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).

### Liberty for Java runtime
The Liberty for Java runtime is powered by the liberty-for-java buildpack. The liberty-for-java buildpack provides a complete runtime environment for running applications on top of WebSphere Liberty profile. A command line interface is then used to manage your apps on Bluemix.

[Learn more about Liberty for Java](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html).

## Tutorials to follow next
* Create a {{ site.data.keys.mf_server }} instance [using the {{ site.data.keys.mf_bm }} service](using-mobile-foundation/).
* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.
* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts-lbp/) using Liberty Build Pack.
