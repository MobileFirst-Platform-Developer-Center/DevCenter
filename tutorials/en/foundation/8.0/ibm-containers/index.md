
---
layout: tutorial
breadcrumb_title: IBM Containers
show_disqus: true
title: IBM MobileFirst Foundation on IBM Containers
relevantTo: [ios,android,windows,javascript]
weight: 9
---
## Overview
Before talking about IBM MobileFirst Foundation and IBM Containers, here is some information about Bluemix.

**IBM Bluemix** is an implementation of IBM's Open Cloud Architecture. It leverages **Cloud Foundry** to enable developers to rapidly build, deploy, and manage their cloud applications, while tapping a growing ecosystem of available services and runtime frameworks.

> Learn more about the Bluemix architecture and Bluemix concepts [on the Bluemix website](https://www.ng.bluemix.net/docs/overview/overview.html).

### How does it work?
In a nutshell: To run IBM MobileFirst Foundation on IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **MobileFirst Server instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.

### IBM Containers
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).

> To learn more about IBM MobileFirst Foundation on IBM Containers, visit the user documentation website.

## Tutorials to follow next
* Create a MobileFirst Server instance [using the Mobile Foundation Bluemix service](using-mobile-foundation/).
* Create a MobileFirst Server instance on IBM Containers [using IBM-provided scripts](mobilefirst-server-using-scripts/).
